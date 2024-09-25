//page load event
var Cookies = "";
var stmtMstrId = 0;
var DeduteeCookie = "";
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

//load pan

getparam = function () {
    

    var ddlQuarter = $('#ddlQuarter option:selected').text();
    var ddlForm = $('#ddlForm option:selected').text();

    if ((ddlQuarter == "" || ddlQuarter == undefined) || (ddlForm == "" || ddlForm == undefined)) {
        return false;
    }



    //-----------------------
    var tracesData = {
        "tracesInfo": {
            Compid: $("[id*=hdnCompid]").val(),
            Quarter: ddlQuarter,
            FormType: ddlForm
        }

    };


    $(".MastermodalBackground2").show();


    $.ajax({
        type: "POST",
        url: "../../TDS/BTSTrp/handler/Voucher.asmx/Get_PANNo_List",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify(tracesData),
        success: function (data) {
            $(".MastermodalBackground2").hide();
            var result = JSON.parse(data.d);
            //loop PAN list      
            for (i = 0; i < result.length; i++) {
                $("#ddlPAN").append($("<option></option>").val(result[i]["PAN"]).html(result[i]["PAN"]));
            }
            document.getElementById('ddlPAN').selectedIndex = -1;
        },
        failure: function (response) {
            $(".MastermodalBackground2").hide();
            showDangerAlert(response.d);
        }
    });

    return false;
    
}

function RequestTDSStatus() {
    
    var ddlFAYear = $('#ddlFAYear option:selected').text();
    var ddlQuarter = $('#ddlQuarter option:selected').val();
   var ddlPAN = $('#ddlPAN option:selected').text();
    var ddlForm = $('#ddlForm option:selected').text();
    // ddlPAN = "AAJCA9880A";

    var UserID = $("#txttraceuserid").val();
    var Password = $("#txttracepwd").val();
    var TAN_NO = $("input[type=text][id*=txtTanNo]").val();
    var CaptchaCode = $("#captcha").val();

    // TAN_NO = "MUMA55657A";

    if ((ddlFAYear == "" || ddlFAYear == undefined) || (ddlQuarter == "" || ddlQuarter == undefined) || (ddlPAN == "" || ddlPAN == undefined)) {
        showDangerAlert("All the details are required!");
        return false;
    }

    var tracesData = {
        "objTraceData":
            {
                FAYear: ddlFAYear,
                Quarter: ddlQuarter,
                PAN1: ddlPAN,
                Forms: ddlForm,
                TAN: TAN_NO
            },
        "objLogin": {
            UserID: UserID,
            Password: Password,
            TAN:TAN_NO,
            CaptchaCode: CaptchaCode,
            Cookie: Cookies
        }
        //"date": new Date().getTime()
    };

    //--POST REQUEST             
    $(".MastermodalBackground2").show();
    $.ajax({
        type: "POST",
        url: "TService.asmx/reTCSTDSCredit",
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
            var dtStatementdtls = JSON.parse(result["dtStatementdtls"]);
            //var dtDeducteeDetails = JSON.parse(result["dtDeducteeDetails"]);
          //  var rows = dtDeducteeDetails.rows;
            DeduteeCookie = result["currentCookie"];

            var tbl_html_val = "<h3>Statement Details</h3>";
            tbl_html_val += "<table id=\"tblStatementDtls\" border=\"1\" cellpadding=\"0\" cellspacing=\"0\" style='width: 100%;margin:auto; border:1px solid #dcdcdc;'>";

            var total = 0, FieldValue,knt;
            

            for (var i = 0; i < dtStatementdtls.length; i++) {
                knt = i;
                if (knt % 3 == 0) {
                    tbl_html_val += "<tr>";
                }
                knt++;

                Field = dtStatementdtls[i]["Field"];
                tbl_html_val += "<td style='background-color: aliceblue'>"+  dtStatementdtls[i]["Field"] +"</td>";
                if (Field == "TAN")
                {
                    tbl_html_val += BindHeader('td',TAN_NO);
                }
                else if (Field == "Form Type") {
                    tbl_html_val += BindHeader('td', ddlForm);
                }
                else if (Field == "Quarter") {
                    tbl_html_val += BindHeader('td', $('#ddlQuarter option:selected').text());
                }
                else {
                    tbl_html_val += BindHeader('td', dtStatementdtls[i]["Value"]);
                }                                   
                             
                if (knt % 3 == 0) {
                    tbl_html_val += "</tr>";
                }
            }         
            
            tbl_html_val += "</table>";

            $("#divStatementDtls").html(tbl_html_val);

            stmtMstrId = result["stmstrID"];
            //fillDedDataGrid();
            GetDeducteeDetails();

     
            
            $(".MastermodalBackground2").hide();
          //  getCaptcha();
          //  $("#captcha").val("");
        },
        failure: function (response) {
            $(".MastermodalBackground2").hide();
            showDangerAlert(response.d);
        }
    });


    return false;
}
function fillDedDataGrid() {

    var ddlFAYear = $('#ddlFAYear option:selected').text();
    var ddlQuarter = $('#ddlQuarter option:selected').val();
    var ddlPAN = $('#ddlPAN option:selected').text();
    var ddlForm = $('#ddlForm option:selected').text();
    // ddlPAN = "AAJCA9880A";

    var UserID = $("#txttraceuserid").val();
    var Password = $("#txttracepwd").val();
    var TAN_NO = $("input[type=text][id*=txtTanNo]").val();
    var CaptchaCode = $("#captcha").val();

    if (stmtMstrId == 0) {
    } else {




        var tracesData = {
            "objTraceData":
                JSON.stringify({
                    FAYear: ddlFAYear,
                    Quarter: ddlQuarter,
                    PAN1: ddlPAN,
                    Forms: ddlForm,
                    TAN: TAN_NO
                }),
            stmtMstrId: stmtMstrId,
            cookie: cookie
            //  "date": new Date().getTime()
        };




        
        //  var rows = dtDeducteeDetails.rows;
      
       
    }
}

function GetDeducteeDetails() {

    var ddlFAYear = $('#ddlFAYear option:selected').text();
    var ddlQuarter = $('#ddlQuarter option:selected').val();
    var ddlPAN = $('#ddlPAN option:selected').text();
    var ddlForm = $('#ddlForm option:selected').text();
    var formType = ddlForm;
    var finYear = ddlFAYear;
    var quarter = ddlQuarter;
    // ddlPAN = "AAJCA9880A";
    $("#dedPAN").css("display", "");
    
    document.getElementById("DedDetail_pan").innerHTML = ddlPAN;

    var UserID = $("#txttraceuserid").val();
    var Password = $("#txttracepwd").val();
    var TAN_NO = $("input[type=text][id*=txtTanNo]").val();
    var CaptchaCode = $("#captcha").val();
    var records = jQuery("#dedDetailTab").getGridParam("records");
    for (var gridRecords1 = 0; gridRecords1 < records; gridRecords1++) {
        jQuery("#dedDetailTab").delRowData(gridRecords1);
    }
    var urlGetList = "../Handler/Dedutee_Details.ashx";//"Traces_TDS_TCS_Credit.aspx/reTCSTDSCredit_DeduteeDetails";

    jQuery("#dedDetailTab").jqGrid({
        url: urlGetList,
        mtype: 'POST',
        datatype: 'json',
        emptyrecords: "PAN not present in latest statement for selected input criteria",
        postData: {
            "objTraceData":
                JSON.stringify({
                    FAYear: ddlFAYear,
                    Quarter: ddlQuarter,
                    PAN1: ddlPAN,
                    Forms: ddlForm,
                    TAN: TAN_NO
                }),
            stmtMstrId: stmtMstrId,
            cookie: DeduteeCookie
        },
        jsonReader: {
            repeatitems: false,
            root: function (dedData) {
                document.getElementById("DedDetail_DedName").innerHTML = dedData.dedNam;
                return dedData.rows;
            },
            total: "totalpages", records: "rowCount", page: "page"
        },
        loadError: function (jxXHR, textStatus, errorThrown) { errorInGettingDetails(textStatus, errorThrown); },
        pager: '#pagernav', viewrecords: true, pgbuttons: true,
        rowNum: 10,
        loadonce: false,
        height: 'auto',
        colNames: ["Deductee Detail Record Number", "Name of Deductee",
            "PAN", "Section Code", "Rate of Deduction (%)",
            "Transaction Amount <span>(</span><span class='WebRupee'>Rs.</span><span class='marLeft-3'>)",
            "Amount of Cash Withdrawal in excess of Rs. 1 crore<br />  <span>(</span><span class='WebRupee'>Rs.</span><span class='marLeft-3'>)<br />",
            "Amount of cash withdrawal which is in excess of Rs. 20 lakhs but does not exceed Rs. 1 crore for cases covered by sub-clause (a) of clause (ii) of first proviso to section 194N<br />  <span>(</span><span class='WebRupee'>Rs.</span><span class='marLeft-3'>)<br />",
            "Amount of cash withdrawal which is in excess of Rs. 1 crore for cases covered by sub-clause(b) of clause (ii) of first proviso to Section 194N<br />  <span>(</span><span class='WebRupee'>Rs.</span><span class='marLeft-3'>)<br />",
            "Date of Transaction",
            "Tax Deducted / Collected <span>(</span><span class='WebRupee'>Rs.</span><span class='marLeft-3'>)",
            "Date of Deduction",
            "Tax Deposited   <span>(</span><span class='WebRupee'>Rs.</span><span class='marLeft-3'>)",
            "Status of Booking<sup>*</sup>"],
        colModel: [
            { name: 'dedDetRNo', index: 'dedDetRNo', width: 100, align: "left", sortable: false },
            { name: 'pan', index: 'pan', width: 0, hidden: true },
            { name: 'dedNam', index: 'dedNam', width: 0, hidden: true },
            { name: 'secCode', index: 'secCode', width: 80, align: "left", sortable: false },
            { name: 'dedRate', index: 'dedRate', width: 80, align: "right", sortable: false },
            {
                name: 'transAmnt', index: 'transAmnt', width: 120, align: "right", sortable: false,
                formatter: 'currency', formatoptions: { decimalSeparator: ".", thousandsSeparator: ",", decimalPlaces: 2 }
            },
            { name: 'cashwithdraw', index: 'cashwithdraw', width: 120, align: "right", sortable: false, "formatter": "currency", formatoptions: { thousandsSeparator: ',' }, "resizable": false, hidden: false },
            { name: 'cashWthdrwExcs20L', index: 'cashWthdrwExcs20L', width: 120, align: "right", sortable: false, "formatter": "currency", formatoptions: { thousandsSeparator: ',' }, "resizable": false, hidden: false },
            { name: 'cashWthdrwExcs1cr', index: 'cashWthdrwExcs1cr', width: 120, align: "right", sortable: false, "formatter": "currency", formatoptions: { thousandsSeparator: ',' }, "resizable": false, hidden: false },
            { name: 'transDate', index: 'transDate', width: 103, align: "center", sortable: false },
            {
                name: 'taxDeducted', index: 'taxDeducted', width: 120, align: "right", sortable: false,
                formatter: 'currency', formatoptions: { decimalSeparator: ".", thousandsSeparator: ",", decimalPlaces: 2 }
            },
            { name: 'deductionDate', index: 'deductionDate', width: 103, align: "center", sortable: false },
            {
                name: 'taxDeposited', index: 'taxDeposited', width: 120, align: "right", sortable: false,
                formatter: 'currency', formatoptions: { decimalSeparator: ".", thousandsSeparator: ",", decimalPlaces: 2 }
            },
            { name: 'status', index: 'status', width: 110, align: "left", sortable: false },
        ],
        loadComplete: function () {
            //CR596 Changes Starts
            if (formType == '26Q' || formType == '27Q') {
                if ((finYear == '2019' && (quarter > 3)) || (finYear > '2019')) {
                    jQuery("#dedDetailTab").jqGrid('showCol', 'cashwithdraw');
                } else {
                    jQuery("#dedDetailTab").jqGrid('hideCol', 'cashwithdraw');
                }

                if ((finYear == '2020' && (quarter > 3)) || (finYear > '2020')) {
                    jQuery("#dedDetailTab").jqGrid('showCol', 'cashWthdrwExcs20L');
                    jQuery("#dedDetailTab").jqGrid('showCol', 'cashWthdrwExcs1cr');
                } else {
                    jQuery("#dedDetailTab").jqGrid('hideCol', 'cashWthdrwExcs20L');
                    jQuery("#dedDetailTab").jqGrid('hideCol', 'cashWthdrwExcs1cr');
                }
            } else {
                jQuery("#dedDetailTab").jqGrid('hideCol', 'cashwithdraw');
                jQuery("#dedDetailTab").jqGrid('hideCol', 'cashWthdrwExcs20L');
                jQuery("#dedDetailTab").jqGrid('hideCol', 'cashWthdrwExcs1cr');
            }
            //CR596 Changes Ends  
        }
    }); jQuery("#dedDetailTab").jqGrid('setGridParam', {
        url: urlGetList,
        datatype: 'json', mtype: 'POST',
        postData: {
            "objTraceData":
                JSON.stringify({
                    FAYear: ddlFAYear,
                    Quarter: ddlQuarter,
                    PAN1: ddlPAN,
                    Forms: ddlForm,
                    TAN: TAN_NO
                }),
            stmtMstrId: stmtMstrId,
            cookie: DeduteeCookie
        }
    });
}
      //  var requestParam = 'pan=' + ddlPAN + '&stmtMstrId=' + stmtMstrId + '&finYear=' + ddlFAYear + '&quarter=' + ddlQuarter + '&formType=' + ddlForm

        
    

