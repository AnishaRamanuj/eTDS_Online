var Cookies = "";
var RequestType = "";
$(function () {
    //Load Form
    $("#ddlForm").append($("<option></option>").val("24Q").html("24Q"));
    $("#ddlForm").append($("<option></option>").val("26Q").html("26Q"));
    $("#ddlForm").append($("<option></option>").val("27Q").html("27Q"));
    $("#ddlForm").append($("<option></option>").val("27EQ").html("27EQ"));
  
    loadLoginDetails();
    getCaptcha();
});






RequestTrace = function () {

 
    var UserID = $("#txtUserID").val();
    var Password = $("#txtPassword").val();
    var TAN_NO = $("#txtTan").val();    

    var CaptchaCode = $("#captcha").val();
    var ddlForm = $('#ddlForm  option:selected').text();
    var PAN = $("#txtPAN").val();

    if ((UserID == null || UserID == "") || (Password == null || Password == "")) {
        ShowErrorWindow('Enter User Login Details');
        return false;
    }


    if (TAN_NO == null || TAN_NO == undefined) {
        ShowErrorWindow('TAN - Cannot be Blank');
        return false;
    }


    if (TAN_NO != "0" && TAN_NO != "") {
        if (TAN_NO != null || TAN_NO != undefined) {

            //PAN check
            var Pattern1 = /^([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}?$/;
            //TAN check
            var Pattern2 = /^([a-zA-Z]){4}([0-9]){5}([a-zA-Z]){1}?$/;
            //AIN check
            var Pattern3 = /^[0-9]{7}$/;

            if (TAN_NO.match(Pattern1) || TAN_NO.match(Pattern2) || TAN_NO.match(Pattern3)) {
                // ShowErrorWindow('correct Format of the TAN No.');
                //return false;
            } else {
                ShowErrorWindow('Incorrect Format of the TAN No.');
                return false;
            }
        }
    }



   

    if (PAN != null && PAN != undefined && PAN != "") {
        if (!PAN.match(/^([a-zA-Z]){4}([a-zA-Z]){1}([0-9]){4}([a-zA-Z]){1}?$/)) {
            ShowErrorWindow("PAN structure is not valid");
            return false;
        }
    }

  

    var tracesData = {
        "objTraceData": {
            Forms: ddlForm,
            PAN1: PAN         

        },
        "objLogin": {
            UserID: UserID,
            Password: Password,
            TAN: TAN_NO,
            CaptchaCode: CaptchaCode,
            Cookie: Cookies
        }
    };


    $(".MastermodalBackground2").show();
    document.getElementById("btnGetRequest").disabled = true;

    //debugger;
    $.ajax({
        type: "POST",
        url: "TService.asmx/reqPANVerify",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify(tracesData),
        success: function (data) {
          //  debugger;
            var result = JSON.parse(data.d);
            if (result.error) {
                $("#captcha").val("");
                getCaptcha();
                $(".MastermodalBackground2").hide();
                ShowErrorWindow(result.error);
                UpdatePAN(PAN, 'InValid PAN', result.failure.Status );
                document.getElementById("btnGetRequest").disabled = false;
                return false;
            }
            else {
                if (result.success) {
                    $("#captcha").val("");
                    getCaptcha();  
                    var tbl_html_val = "<div><span style='padding-right:20px;font-size:14px; background-color:#ffffff; border:none ;'>PAN : <b>" + PAN + "</b> </span><span style='padding-right:20px;font-size:14px; background-color:#ffffff; border:none ;'>Name : <b>" + result.success.Name + "</b> </span><span style='padding-right:20px;font-size:14px; background-color:#ffffff; border:none ;'>Status : <b>" + result.success.Status + "</b> </span></div>";
                    $("#divData").html(tbl_html_val);

                    $(".MastermodalBackground2").hide();
                    UpdatePAN(PAN, 'Valid PAN', result.success.Status );
                    document.getElementById("btnGetRequest").disabled = false;
                    $(".MastermodalBackground2").hide();
                    return false;
                }
            }
        },
        failure: function (response) {
            $("#captcha").val("");
            getCaptcha();
            document.getElementById("btnGetRequest").disabled = false;
            $(".MastermodalBackground2").hide();
            ShowErrorWindow(response.d);
        }
    });
  
    


    return false;
}

function UpdatePAN(PAN, vrfy, Sts )
{

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../handler/Ws_Deductee.asmx/Update_PAN",
        data: '{PAN:"' + PAN + '", vrfy:"' + vrfy + '", sts:"' + Sts + '"}',
        dataType: "json",
        success: function (msg) {
            var myList = jQuery.parseJSON(msg.d);

        },
        failure: function (response) {
            alert('Cant Connect to Server' + response.d);
        },
        error: function (response) {
            alert('Error Occoured ' + response.d);
        }
    });

}

//function clearControls() {
//    //clear the controls
//    $("#txtSerialNo").val("");
//    $("#txtChallanNo").val("");
//    $("#txtBSRCode").val("");
//    $('[id$="txtDateOfDeposit"]').val("");
//    $("#txtTaxDeposit").val("0.00");

//    $('#chkNIlChallan').attr('checked', false);
//    $('#chkNoValidPAN').attr('checked', false);
//    $('#chkBookAdjustment').attr('checked', false);

//    $("#txtPRN_No").val("");
//    var id = "";
//    for (i = 1; i <= 3; i++) {
//        id = i;
//        $("#txtPAN" + id).val("");
//        $("#txtAmount" + id).val("");
//    }
//}

