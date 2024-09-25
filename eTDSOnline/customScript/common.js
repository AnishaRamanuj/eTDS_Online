function getCaptcha() {
    //get Captcha       
    $("#imgajaxLoader").show();
    $.ajax({
        type: "POST",
        url: "TService.asmx/tCaptcha",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (data) {
            var result = JSON.parse(data.d);
            Cookies = result[0]["Cookie"];
            document.getElementById("captchaImg").src = result[0]["base64"];
            $("#imgajaxLoader").hide();
            $("#tblCaptcha").show();
        },
        failure: function (response) {
            $("#imgajaxLoader").hide();
            ShowErrorWindow(response.d);
        }
    });

}
function loadLoginDetails() {
    $("[id*=tblTracesLogin]").hide();
    $("#imgajaxLoader").show();
    $.ajax({
        type: "POST",
        url: "TService.asmx/Get_tracesLoginDetails",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (data) {
            var result = JSON.parse(data.d);
            if (result.error) {
                ShowErrorWindow(result.error);
                $("[id*=tblTracesLogin]").show();
                $("[id*=tblver]").hide();
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
                    
                    $("#txtTan").val($("[id*=txtTanNo]").val());
                    $("[id*=tblTracesLogin]").show();
                    $("[id*=tblver]").hide();
                }
                $("#imgajaxLoader").hide();

            }
        },
        failure: function (response) {
            $("#imgajaxLoader").hide();
            ShowErrorWindow(response.d);
        }
    });

}
function showcaptcha()
{
    $("#tblCaptcha").show();
}

function GetUseridAndPassword() {
    var Compid = $("[id*=hdnCompid]").val();
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../handler/Voucher.asmx/GetTracesDetails",
        data: '{Compid:' + Compid + '}',
        dataType: "json",
        success: function (msg) {
            var myList = jQuery.parseJSON(msg.d);
            if (myList.length > 0) {
                $("[id*=txttraceuserid]").val(myList[0].Userid);
                $("[id*=txttracepwd]").val(myList[0].Password);

            } else {
                ShowWarningWindow('Enter Traces Login Details!!!');
                window.location = 'TracesDetails.aspx';
            }

        },
        failure: function (response) {

        },
        error: function (response) {

        }
    });
}

//Header and Row Binding
var html_concat = ";"
function BindHeader(field, data) {
    if (field == "th")
        html_concat = "<" + field + "><b>" + data + "</b></" + field + ">";
    else if (field == "td")
        html_concat = "<" + field + ">" + data + "</" + field + ">";

    return html_concat;
}

//Common Function
//Show Message
//Error
function ShowErrorWindow(Message) {
    $.confirm({
        columnClass: 'large',
        icon: 'fa fa-exclamation-circle',
        title: 'Error from eTDS',
        content: Message,
        type: 'red',
        useBootstrap: false,
        width: 'auto',
        buttons: {
            ok: function () {

            }
        }
    });
}
//Success
function ShowSuccessWindow(Message) {
    $.confirm({
        columnClass: 'meduim',
        icon: 'fa fa-check',
        title: 'Message from eTDS',
        content: Message,
        type: 'green',
        useBootstrap: false,
        width: 'auto',
        buttons: {
            ok: function () {

            }
        }
    });
}
//Message
function ShowInfoWindow(Message) {
    $.confirm({
        columnClass: 'medium',
        width: 'auto',
        icon: 'fa fa-commenting',
        title: 'Message from eTDS',
        content: Message,
        type: 'blue',
        useBootstrap: false,
        width: 'auto',
        buttons: {
            ok: function () {

            }
        }
    });
}
//Warning
function ShowWarningWindow(Message) {
    $.confirm({
        columnClass: 'medium',
        icon: 'fa fa-warning',
        title: 'Error',
        content: Message,
        type: 'orange',
        useBootstrap: false,
        width: 'auto',
        buttons: {
            ok: function () {

            }
        }
    });
}
//End Show Message

//End Common Function