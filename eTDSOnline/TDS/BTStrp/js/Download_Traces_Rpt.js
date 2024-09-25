
var baseURL = "https://www.tdscpc.gov.in/";
var cookie = "";
$(function () {
    getCaptcha();
    loadLoginDetails();
});

function loadLoginDetails() {
    $(".MastermodalBackground2").show();
    $.ajax({
        type: "POST",
        url: "TService.asmx/Get_tracesLoginDetails",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (data) {
            var result = JSON.parse(data.d);
            if (result.error) {
                $(".MastermodalBackground2").hide();
                showDangerAlert(result.error);
                return false;
            }
            else {
                //loop Challan Details
                var dt_Login = JSON.parse(result["dt_Login"]);
                if (dt_Login.length > 0) {
                    var Login_dtls = dt_Login[0];
                    $("#txtTan").val(Login_dtls["Tan"]);
                    $("#txtUserID").val(Login_dtls["User_ID"]);
                    $("#txtPassword").val(Login_dtls["Password"]);
                }
                else {
                    showDangerAlert('Enter Traces Login Details!!!');
                }
                $(".MastermodalBackground2").hide();

            }
        },
        failure: function (response) {
            $(".MastermodalBackground2").hide();
            showDangerAlert(response.d);
        }
    });

}



//reuestDownloads
TracesDetails = function () {
    debugger;
    var UserID = $("#txtUserID").val();
    var Password = $("#txtPassword").val();
    var TAN_NO = $("input[type=text][id*=txtTanNo]").val();
    var Compid = $("[id*=hdnCompid]").val();
    
    if (isValid(UserID) || isValid(Password)) {
        showDangerAlert('Enter User Login Details');
        return false;
    }


    //var tracesData = {
    //    "objLogin": {
    //        UserID: UserID,
    //        Password: Password,
    //        TAN: TAN_NO,
    //        Compid: Compid,

    //        //CaptchaCode: CaptchaCode,
    //        //Cookie: Cookies
    //    }
    //}
    //--POST REQUEST             
    $(".MastermodalBackground2").show();
    $.ajax({
        type: "POST",
        //url: "TService.asmx/reQList",
        url: "../handler/Voucher.asmx/TracesDetailsSave",
        contentType: "application/json; charset=utf-8",

        data: '{Compid:' + Compid + ',UserID:"' + UserID + '",Password:"' + Password + '",TAN:"' + TAN_NO + '"}',
        dataType: "json",
        success: function (data) {

            //bind requested downloads
            var result = JSON.parse(data.d);
            if (result[0].Compid > 0) {
                showSuccessAlert('Successfully Saved!!!')
            }
          
            $(".MastermodalBackground2").hide();
        },
        failure: function (response) {
            $(".MastermodalBackground2").hide();
            showDangerAlert(response.d);
        }
    });


    return false;
}

//reuestDownloads
RequestDownloads = function () {
    debugger;
    var UserID = $("#txtUserID").val();
    var Password = $("#txtPassword").val();
    var TAN_NO = $("#txtTan").val();
    var CaptchaCode = $("#captcha").val();
    if (isValid(UserID) || isValid(Password)) {
        showDangerAlert('Enter User Login Details');
        return false;
    }

    if (isValid(TAN_NO) || TAN_NO == null || TAN_NO == undefined) {
        showDangerAlert('TAN - Cannot be Blank');
        return false;
    }


    if (TAN_NO != "0") {
        if (!isValid(TAN_NO)) {

            var tp = TAN_NO;
            //PAN check
            var Pattern1 = /^([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}?$/;
            //TAN check
            var Pattern2 = /^([a-zA-Z]){4}([0-9]){5}([a-zA-Z]){1}?$/;
            //AIN check
            var Pattern3 = /^[0-9]{7}$/;

            if (tp.match(Pattern1) || tp.match(Pattern2) || tp.match(Pattern3)) {

            } else {
                showDangerAlert('Incorrect Format of the TAN No.');
                return false;
            }
        }
    }
    else {
        var tp = $('#txtTan').val();
        //PAN check
        var Pattern1 = /^([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}?$/;
        //TAN check
        var Pattern2 = /^([a-zA-Z]){4}([0-9]){5}([a-zA-Z]){1}?$/;
        //AIN check
        var Pattern3 = /^[0-9]{7}$/;

        if (tp.match(Pattern1) || tp.match(Pattern2) || tp.match(Pattern3)) {

        } else {
            showDangerAlert('Incorrect Format of the TAN No.');
            return false;
        }
    }

    if (isValid(CaptchaCode)) {
        showDangerAlert('Enter Captcha Code');
        return false;
    }


    var CurrentTANNO = "";
    if (TAN_NO != "0") {
        CurrentTANNO = TAN_NO;
    }
    else {
        CurrentTANNO = $('#txtTan').val();
    }


 
    var tracesData = {
        "objLogin": {
            UserID: UserID,
            Password: Password,
            TAN: TAN_NO,
            CaptchaCode: CaptchaCode,
            Cookie: Cookies
        }
    }
    //--POST REQUEST             
    $(".MastermodalBackground2").show();
    $.ajax({
        type: "POST",
        url: "TService.asmx/reQList",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify(tracesData),
        success: function (data) {
            
            //bind requested downloads
            var result = JSON.parse(data.d);
            if (result["error"] != undefined || result["error"] != null) {
                $(".MastermodalBackground2").hide();
                showDangerAlert(result["error"]);
                return false;
            }
            var dt = JSON.parse(result["dt"]);
            cookie = result["cookie"];
            var tbl_html_val = "<table id=\"tblRequestedDownloads\"  cellpadding=\"0\" cellspacing=\"0\" style='width: 100%;margin:auto; border:1px solid #dcdcdc;'>";
            tbl_html_val = tbl_html_val +
                   "<thead>" +
                   "<tr style='background-color: rgba(194, 226, 250, 1);height:25px;'>" +
                        "<th><b>Request Date</b></th>" +
                        "<th><b>Request Number</b></th>" +
                        "<th><b>Financial Year</b></th>" +
                        "<th><b>Quarter</b></th>" +
                        "<th><b>Form Type </b></th>" +
                        "<th><b>File Processed</b></th>" +
                        "<th><b>Status  </b></th>" +
                        "<th ><b>Remarks</b></th>" +
                        "<th scope='col' abbr='Starter' ></th>" +

                   "</tr>" +
                   "</thead>" +
                   "<tbody>";
            for (var i = 0; i < dt.length; i++) {
                tbl_html_val += "<tr>";
                tbl_html_val += "<td>" + dt[i]["Request Date"] + "</td>";
                tbl_html_val += "<td>" + dt[i]["Request Number"] + "</td>";
                tbl_html_val += "<td>" + dt[i]["Finnancial Number"] + "</td>";
                tbl_html_val += "<td>" + dt[i]["Quarter"] + "</td>";
                tbl_html_val += "<td>" + dt[i]["Form Type"] + "</td>";
                tbl_html_val += "<td>" + dt[i]["File Processed"] + "</td>";
                tbl_html_val += "<td>" + dt[i]["Status"] + "</td>";
                tbl_html_val += "<td>" + dt[i]["Remarks"] + "</td>";
                tbl_html_val += "<td> <input type='submit' name='btnDownload' value='Download' id='btnDownload' class='btn-info' onclick='return Download(\"" + dt[i]["Request Number"] + "\");'></td>";
                tbl_html_val += "</tr>";
            }
            tbl_html_val += "</tbody>";
            tbl_html_val += "</table>";
            $("#divData").html(tbl_html_val);
            $(".MastermodalBackground2").hide();
        },
        failure: function (response) {
            $(".MastermodalBackground2").hide();
            showDangerAlert(response.d);
        }
    });


    return false;
}


isValid = function (value) {
    return !value
}

//Download zip file
Download = function (value) {
    var obj = {};
    obj.reqNo = value;
    obj.cookie = cookie;

    $(".MastermodalBackground2").show();
    $.ajax({
        type: "POST",
        url: "TService.asmx/Download",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify(obj),
        success: function (data) {

            //file download
            var result = JSON.parse(data.d);
            
            if (result["error"] != undefined || result["error"] != null) {
                $(".MastermodalBackground2").hide();
                showDangerAlert(result["error"]);
                return false;
            }
            var fName = result["filename"];
            var data = result["data"];
            var binary_string = window.atob(data);
            var len = binary_string.length;
            var bytes = new Uint8Array(len);
            for (var i = 0; i < len; i++) {
                bytes[i] = binary_string.charCodeAt(i);
            }

            if (fName != "") {
                var blob = new Blob([bytes], { 'type': "application/octet-stream" });
                var link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                link.download = fName.substring(fName.indexOf("=") + 1);
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);

            } else {
                $("#captcha").val("");
                getCaptcha();
            }
            $(".MastermodalBackground2").hide();
        },
        failure: function (response) {
            $(".MastermodalBackground2").hide();
            showDangerAlert(response.d);
        }
    });
    return false;
}


