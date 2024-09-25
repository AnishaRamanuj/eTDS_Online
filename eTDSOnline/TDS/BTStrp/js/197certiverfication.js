var Cookies = "";
var RequestType = "";
$(function () {
    //Load FA Year
    var year = new Date().getFullYear()-1;
    var FAOption = "";
    var toYear = "";
    for (i = year; i >= 2005 ; i--) {
        toYear = (parseInt(i.toString().substr(-2)) + 1);
        toYear = (parseInt(toYear) < 10 ? "0" + toYear : toYear);
        FAOption = i + "-" + toYear;
        if (i == year)
            $("#ddlFAYear").append($("<option selected></option>").val(i).html(FAOption));
        else $("#ddlFAYear").append($("<option></option>").val(i).html(FAOption));
    }

  
    loadLoginDetails();
    getCaptcha();
});






RequestTrace = function () {

 
    var UserID = $("#txtUserID").val();
    var Password = $("#txtPassword").val();
    var TAN_NO = $("#txtTan").val();    
    var ddlFAYear = $('#ddlFAYear option:selected').val();
    var CaptchaCode = $("#captcha").val();
    var ddlForm = $('#ddlForm  option:selected').text();
    var PAN = $("#txtPAN").val();

    if ((UserID == null || UserID == "") || (Password == null || Password == "")) {
        showDangerAlert('Enter User Login Details');
        return false;
    }


    if (TAN_NO == null || TAN_NO == undefined) {
        showDangerAlert('TAN - Cannot be Blank');
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
                showDangerAlert('Incorrect Format of the TAN No.');
                return false;
            }
        }
    }



    if (ddlFAYear == null || ddlFAYear == "" || ddlFAYear == undefined) {
        showDangerAlert('Select FA Year');
        return false;
    }
    if (PAN != null && PAN != undefined && PAN != "") {
        if (!PAN.match(/^([a-zA-Z]){4}([a-zA-Z]){1}([0-9]){4}([a-zA-Z]){1}?$/)) {
            showDangerAlert("PAN structure is not valid");
            return false;
        }
    }

  

    


    var tracesData = {
        "objTraceData": {
            FAYear: ddlFAYear,        
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
        url: "TService.asmx/req197Certification",
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
                showDangerAlert(result.error);
                document.getElementById("btnGetRequest").disabled = false;
                return false;
            }
            else {
                if (result.success) {
                    $("#captcha").val("");
                    getCaptcha();
                    var tbl_html_val = "<table id=\"tblRequestedDownloads\"  cellpadding=\"0\" cellspacing=\"0\" style=' width: 100%;margin:auto; border:1px solid #dcdcdc;'>";
                    tbl_html_val = tbl_html_val +
                        "<thead>" +
                        "<tr style='background-color: rgba(194, 226, 250, 1);height:25px;'>" +
                        "<th><b>Sr.No.</b></th>" +
                        "<th style='width:150px;'><b>Certificate Number</b></th>" +
                        "<th ><b>Financial Year</b></th>" +
                        "<th ><b>PAN of the Deductee</b></th>" +
                        "<th ><b>Name of Deductee </b></th>" +
                        "<th ><b>Valid From</b></th>" +
                        "<th ><b>Valid To  </b></th>" +
                        "<th  ><b>Section Code</b></th>" +
                        "<th  ><b>Nature of Payment</b></th>" +
                        "<th  ><b>Rate of TDS as per Certificate</b></th>" +
                        "<th  ><b>Certificate Limit (Amount)(Rs.)</b></th>" +
                        "<th  ><b>Amount Consumed(Rs.)</b></th>" +
                        "<th  ><b>Date of Issue</b></th>" +                                               

                        "</tr>" +
                        "</thead>" +
                        "<tbody>";

                    var dt = result.success[1];
                    for (var i = 0; i <dt.length; i++) {
                        tbl_html_val += "<tr>";
                        tbl_html_val += "<td>" + dt[i]["Sr.No."] + "</td>";
                        tbl_html_val += "<td>" + dt[i]["Certificate Number"] + "</td>";
                        tbl_html_val += "<td>" + dt[i]["Financial Year"] + "</td>";
                        tbl_html_val += "<td>" + dt[i]["PAN of the Deductee"] + "</td>";
                        tbl_html_val += "<td>" + dt[i]["Name of Deductee"] + "</td>";
                        tbl_html_val += "<td>" + dt[i]["Valid From"] + "</td>";
                        tbl_html_val += "<td>" + dt[i]["Valid To"] + "</td>";
                        tbl_html_val += "<td>" + dt[i]["Section Code"] + "</td>";
                        tbl_html_val += "<td>" + dt[i]["Nature of Payment"] + "</td>";
                        tbl_html_val += "<td>" + dt[i]["Rate of TDS as per Certificate"] + "</td>";
                        tbl_html_val += "<td>" + dt[i]["Certificate Limit (Amount)(Rs.)"] + "</td>";
                        tbl_html_val += "<td>" + dt[i]["Amount Consumed(Rs.)"] + "</td>";
                        tbl_html_val += "<td>" + dt[i]["Date of Issue"] + "</td>";
                                
                        tbl_html_val += "</tr>";
                    }
                    tbl_html_val += "</tbody>";
                    tbl_html_val += "</table>";
                    $("#divData").html(tbl_html_val);
                    $(".MastermodalBackground2").hide();
                    //clearControls();
                    //let ddlQuarter = document.getElementById("ddlQuarter");
                    //ddlQuarter.value = "";
                    //let ddlForm = document.getElementById("ddlForm");
                    //ddlForm.value = "";

                    
                    //ShowSuccessWindow(result.success);
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
            showDangerAlert(response.d);
        }
    });
  
    


    return false;
}


function clearControls() {
    //clear the controls
    $("#txtSerialNo").val("");
    $("#txtChallanNo").val("");
    $("#txtBSRCode").val("");
    $('[id$="txtDateOfDeposit"]').val("");
    $("#txtTaxDeposit").val("0.00");

    $('#chkNIlChallan').attr('checked', false);
    $('#chkNoValidPAN').attr('checked', false);
    $('#chkBookAdjustment').attr('checked', false);

    $("#txtPRN_No").val("");
    var id = "";
    for (i = 1; i <= 3; i++) {
        id = i;
        $("#txtPAN" + id).val("");
        $("#txtAmount" + id).val("");
    }
}

