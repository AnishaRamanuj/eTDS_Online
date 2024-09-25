//page load event
var Cookies = "";
$(function () {

    GetUseridAndPassword();
    getCaptcha();
    


    //Load FA Year
    var year = new Date().getFullYear() - 1;
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


    //load form type
    $("#ddlForm").append($("<option></option>").val("24Q").html("24Q"));
    $("#ddlForm").append($("<option></option>").val("26Q").html("26Q"));
    $("#ddlForm").append($("<option></option>").val("27Q").html("27Q"));
    $("#ddlForm").append($("<option></option>").val("27EQ").html("27EQ"));

   
});


function GetUseridAndPassword() {
    var Compid = $("[id*=hdnCompid]").val();
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../TDS/BTStrp/handler/Voucher.asmx/GetTracesDetails",
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

function RequestStatementStatus()
{

    var ddlFAYear = $('#ddlFAYear option:selected').val();
    var ddlQuarter = $('#ddlQuarter option:selected').val();
    var ddlForm = $('#ddlForm option:selected').val();

    var UserID = $("#txttraceuserid").val();
    var Password = $("#txttracepwd").val();
    var TAN_NO = $("input[type=text][id*=txtTanNo]").val();    
    var CaptchaCode = $("#captcha").val();

 

    if ((ddlFAYear == "" || ddlFAYear == undefined) || (ddlQuarter == "" || ddlQuarter == undefined) || (ddlForm == "" || ddlForm == undefined)) {
        showDangerAlert("All the details are required!");
        return false;
    }

    var tracesData = {
        "objTraceData":
            {
                FAYear: ddlFAYear,
                Forms: ddlForm,
                Quarter: ddlQuarter
            },
        "objLogin": {
            UserID: UserID,
            Password: Password,
            TAN: TAN_NO,
            CaptchaCode: CaptchaCode,
            Cookie: Cookies
        },
    };

//--POST REQUEST             
$(".MastermodalBackground2").show();
$.ajax({
    type: "POST",
    url: "TService.asmx/reStatusofStatementFile",
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

        
        var tbl_html_val = "<table id=\"tblStatmentSummary\" border=\"1\" cellpadding=\"0\" cellspacing=\"0\" style='width: 100%;margin:auto; border:1px solid #dcdcdc;'>";
        tbl_html_val += "<thead><tr style='background-color: rgba(194, 226, 250, 1);height:25px;'>";

        var arr_header = ["Token Number", "Statement Type", "Financial Year", "Quarter", "Form Type", "Date of Filling", "Status", "Status As On Date", "Remarks"];

        for (i = 0; i < arr_header.length; i++) {
            tbl_html_val += BindHeader('th', arr_header[i]);
        }

        tbl_html_val += "</thead><tbody>";

      

        for (var i = 0; i < dt.length; i++) {
            tbl_html_val += "<tr>";

            tbl_html_val += BindHeader('td', dt[i]["Token Number"]);
            tbl_html_val += BindHeader('td', dt[i]["Statement Type"]);
            tbl_html_val += BindHeader('td', dt[i]["Finnancial Year"]);
            tbl_html_val += BindHeader('td', dt[i]["Quarter"]);
            tbl_html_val += BindHeader('td', dt[i]["Form Type"]);            
            tbl_html_val += BindHeader('td', dt[i]["Date of Filling"]);
            tbl_html_val += BindHeader('td', dt[i]["Status"]);
            tbl_html_val += BindHeader('td', dt[i]["Date of Processing"]);            
            tbl_html_val += BindHeader('td', "");
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

