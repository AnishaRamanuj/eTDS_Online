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
    


});


function RequestDefaultSummary() {

    var ddlFAYear = $('#ddlFAYear option:selected').text();
    var ddlQuarter = $('#ddlQuarter option:selected').val();    

    var UserID = $("#txttraceuserid").val();
    var Password = $("#txttracepwd").val();
    var TAN_NO = $("input[type=text][id*=txtTanNo]").val();
    var CaptchaCode = $("#captcha").val();



    if ((ddlFAYear == "" || ddlFAYear == undefined) || (ddlQuarter == "" || ddlQuarter == undefined)) {
        ShowErrorWindow("All the details are required!");
        return false;
    }

    var tracesData = {
        "objTraceData":
            {
                FAYear: ddlFAYear,                
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
        url: "TService.asmx/reDefaultSummary",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify(tracesData),
        success: function (data) {

            //bind requested downloads
            var result = JSON.parse(data.d);
            if (result["error"] != undefined || result["error"] != null) {
                $(".MastermodalBackground2").hide();
                ShowErrorWindow(result["error"]);
                return false;
            }
            var dt = JSON.parse(result["dt"]);
            cookie = result["cookie"];


            var tbl_html_val = "<table id=\"tblStatmentSummary\" border=\"1\" cellpadding=\"0\" cellspacing=\"0\" style='width: 50%;margin:auto; border:1px solid #dcdcdc;'>";
            tbl_html_val += "<thead><tr style='background-color: rgba(194, 226, 250, 1);height:25px;'>";

            var arr_header = ["Quarter", "Form Type", "Net Payable(Rounded-Off)(Rs.)"];

            for (i = 0; i < arr_header.length; i++) {
                tbl_html_val += BindHeader('th', arr_header[i]);
            }

            tbl_html_val += "</thead><tbody>";

            var total = 0;

            for (var i = 0; i < dt.length; i++) {
                tbl_html_val += "<tr>";

                tbl_html_val += BindHeader('td', dt[i]["Quarter"]);               
                tbl_html_val += BindHeader('td', dt[i]["Form Type"]);
                tbl_html_val += "<td style='text-align:right;'>"+ dt[i]["Net Payable(Rounded-Off)"]+"</td>";

                total = parseFloat(total) + parseFloat(dt[i]["Net Payable(Rounded-Off)"]);

                tbl_html_val += "</tr>";
            }

            tbl_html_val += "<tr><td colspan='2' style='text-align:right;'>Total Net payable (Rs.)</td><td style='text-align:right;'>" + total.toFixed(2) + "</td></tr>";
            tbl_html_val += "</tbody>";
            tbl_html_val += "</table>";

            $("#divData").html(tbl_html_val);

            $(".MastermodalBackground2").hide();
        },
        failure: function (response) {
            $(".MastermodalBackground2").hide();
            ShowErrorWindow(response.d);
        }
    });


    return false;
}
