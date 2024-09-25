

// ==========================================================
// variables declaration section
// ==========================================================
var vGVService = new GVService();


// setup variables
var vShowAllocatedFields = 0;
var vProhibitZeroTaxDeduction = 0;
var vShowDeducteeCompanyWise = 0;
var vShowPartyRecord = 0;


// stored paln datelis data added by bashir on 23/03/2018
var arrPalns = new Array();


// ==========================================================
//---- Added by Shiv Shankar hemant on 2016-05-28
//--- For Set Focus on first position in text box
// ==========================================================
$.fn.selectRange = function (start, end) {
    if (end === undefined) {
        end = start;
    }
    return this.each(function () {
        if ('selectionStart' in this) {
            this.selectionStart = start;
            this.selectionEnd = end;
        } else if (this.setSelectionRange) {
            this.setSelectionRange(start, end);
        } else if (this.createTextRange) {
            var range = this.createTextRange();
            range.collapse(true);
            range.moveEnd('character', end);
            range.moveStart('character', start);
            range.select();
        }
    });
};
// ==========================================================
// ==========================================================

$(document).ready(function () {

    // show Credit Balance
    m_ReturnCreditBalance();

    $('#atotalpl').click(function (e) {
        m_PopulatePlanDetails();
        if (arrPalns != null && arrPalns.length != 0) {
            $("#divGT_PlanSlab").dialog({
                modal: true,
                resizable: false,
                height: 'auto',
                minWidth: 400,
                maxheight: 300
            });
            // existing grid is destroyed & display blank header
            m_ShowGridHeaderAndClear($("#grid_PlanSlab_desktop_view"));
            var $grid = m_PopulatePlanGrid(null, $("#grid_PlanSlab_desktop_view"), arrPalns, 'No slab found');
        }

    });
});

var m_PopulatePlanGrid = function (enmJ_Form, GridID, arrData, NotFoundText) {

    var vData = new Array();
    if (arrData != null) {
        vData = arrData;
    }

    // populate invoice slab grid
    var newObj = {
        collapsible: false,
        filterModel: {
            mode: 'OR'
        },
        //showTop: false,
        title: '',
        showBottom: false,
        wrap: false,                                     // wrap text
        hwrap: false,                                    // header wrap text
        resizable: false,                                // Resize the table
        columnBorders: false,                            // vertical Column border 
        numberCell: {
            show: false
        },                     // Show Serial no of Cell
        flexHeight: true,                                // flex/const  height
        scrollModel: {
            autoFit: true
        },                  // privent scroll
        selectionModel: {
            type: 'row', mode: 'single'
        }, // select single row
        hoverMode: "row",                                // mouse over highlight Row
        editable: false,                                 // prevent the editing controls
        scrollModel: {
            pace: 'fast', autoFit: true, theme: true, flexContent: true
        },
        pageModel: {
            type: "local", rPP: 10, rPPOptions: [10, 20, 50, 100], strRpp: "{0}", strDisplay: "Displaying {0} to {1} of {2} records.", idRefresh: 'btnRefresh_InvoiceSlab'
        },
        dataModel: {
            data: vData
        },
        strNoRows: NotFoundText,
        strLoading: 'Loading...',
        colModel: [
            {
                title: "Description", width: 200, dataType: "string", sortable: false
            },
            {
                title: "", width: 300, dataType: "string", sortable: false
            }]
    };

    var vGrid = GridID.pqGrid(newObj);
    return vGrid;
}
// m_PopulateInvoiceSlab
var m_PopulatePlanDetails = function () {
    //var vREGULAR_CORRECTION = 'R';
    //if (eJ_ReturnType == J_ReturnType.__Correction) vREGULAR_CORRECTION = 'C';

    //// Passing the class object
    //var objInvoiceSlab = {
    //    "InvoiceSlab": {
    //        "__REGULAR_CORRECTION": vREGULAR_CORRECTION
    //    }
    //};

    $.ajax({
        type: 'POST',
        url: "DataService.svc/T_PopulatePlanDetails",
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        processData: true,
        success: function (response) {
            if (response.T_PopulatePlanDetailsResult == null) return null;

            for (var i = 0; i < response.T_PopulatePlanDetailsResult.length; i++) {
                arrPalns[i] = [response.T_PopulatePlanDetailsResult[i].__CURRENT_PLAN_NAME.toString(),
                response.T_PopulatePlanDetailsResult[i].__CURRENT_PLAN_END_DATE.toString()];
            }
        },
        error: function (errorThrown) {

            //---- Added by Shiv Shankar Hemant on 2016-08-19
            alert(J_Message.__InternetIssue);
        }
    });
}
// ==========================================================
// ==========================================================





// ==========================================================
// user defined methods section
// ==========================================================


// m_ReturnQuarterStartDate
var m_ReturnQuarterStartDate = function (enmJ_Quarter, FinancialYear) {
    if (enmJ_Quarter == J_Quarter.__Q1)
        return "01/04/" + FinancialYear.substring(0, 4);
    else if (enmJ_Quarter == J_Quarter.__Q2)
        return "01/07/" + FinancialYear.substring(0, 4);
    else if (enmJ_Quarter == J_Quarter.__Q3)
        return "01/10/" + FinancialYear.substring(0, 4);
    else if (enmJ_Quarter == J_Quarter.__Q4)
        return "01/01/" + (parseInt(FinancialYear.substring(0, 4)) + 1).toString();
}

// m_ReturnQuarterEndDate
var m_ReturnQuarterEndDate = function (enmJ_Quarter, FinancialYear) {
    if (enmJ_Quarter == J_Quarter.__Q1)
        return "30/06/" + FinancialYear.substring(0, 4);
    else if (enmJ_Quarter == J_Quarter.__Q2)
        return "30/09/" + FinancialYear.substring(0, 4);
    else if (enmJ_Quarter == J_Quarter.__Q3)
        return "31/12/" + FinancialYear.substring(0, 4);
    else if (enmJ_Quarter == J_Quarter.__Q4)
        return "31/03/" + (parseInt(FinancialYear.substring(0, 4)) + 1).toString();
}

// m_IsValidTANFormat
var m_IsValidTANFormat = function (TAN) {
    if (!vGVService.J_IsAlphabets(vGVService.J_Left(TAN, 4))) return false;
    if (!vGVService.J_IsNumeric(vGVService.J_Mid(TAN, 4, 9), J_ErrorClass.__No, J_ArgumentType.__Value)) return false;
    if (!vGVService.J_IsAlphabets(vGVService.J_Mid(TAN, 9, 10))) return false;
    return true;
}

// m_IsValidPANFormat
var m_IsValidPANFormat = function (PAN) {
    if (!vGVService.J_IsAlphabets(vGVService.J_Left(PAN, 5))) return false;
    if (!vGVService.J_IsNumeric(vGVService.J_Mid(PAN, 5, 9), J_ErrorClass.__No, J_ArgumentType.__Value)) return false;
    if (!vGVService.J_IsAlphabets(vGVService.J_Mid(PAN, 9, 10))) return false;
    return true;
}



// m_ShowGridHeaderAndClear
var m_ShowGridHeaderAndClear = function (GridID) {
    GridID.pqGrid("destroy");
}

// m_IsUnsavedDataexistInGrid
var m_IsUnsavedDataexistInGrid = function (GridID) {
    var blnIsExist = false;
    for (var i = 0; i < GridID.pqGrid("option", "dataModel").data.length; i++) {
        if (GridID.pqGrid("option", "dataModel").data[i][J_GridIndexChallan.__ID] == 0) {
            blnIsExist = true;
            break;
        }
    }
    return blnIsExist;
}

// m_ReturnGridRowIndex
var m_ReturnGridRowIndex = function (GridID, ColumnIndex, ID) {
    var IsExist = false;
    var iRowIndex = 0;

    for (iRowIndex = 0; iRowIndex < GridID.pqGrid("option", "dataModel").data.length; iRowIndex++) {
        if (parseInt(GridID.pqGrid("option", "dataModel").data[iRowIndex][ColumnIndex]) == parseInt(ID)) {
            IsExist = true;
            break;
        }
    }

    if (IsExist) return iRowIndex;
    return -1;
}

// m_ShowYesNoMessage
var m_ShowYesNoMessage = function (divMessageControl, lblMessageTextControl, MessageText, lblHeader, HeaderText) {
    lblHeader.text(HeaderText);
    lblMessageTextControl.text(MessageText);
    divMessageControl.modal({ 'backdrop': 'static' });
}
// m_ShowYesNoWarningMessage
//------- Added by Shiv Shankar Hemant on 2016-05-24
var m_ShowYesNoWarningMessage = function (divMessageControl, lblMessageTextControl, MessageText, lblHeader, HeaderText) {
    lblHeader.text(HeaderText);
    lblMessageTextControl.html(MessageText);
    divMessageControl.modal({ 'backdrop': 'static' });
}




// m_ReturnSetup
var m_ReturnSetup = function () {
    vShowAllocatedFields = 0;
    vProhibitZeroTaxDeduction = 0;
    vShowDeducteeCompanyWise = 0;
    vShowPartyRecord = 0;

    $.ajax({
        type: 'POST',
        url: "DataService.svc/T_ReturnSetup",
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        processData: true,
        success: function (response) {
            if (response == null) return;

            vShowAllocatedFields = response.T_ReturnSetupResult.__SHOW_ALLOCATED_FIELDS;
            vProhibitZeroTaxDeduction = response.T_ReturnSetupResult.__PROHIBIT_ZERO_TAX_DEDUCTION;
            vShowDeducteeCompanyWise = response.T_ReturnSetupResult.__SHOW_DEDUCTEE_COMPANY_WISE;
            vShowPartyRecord = response.T_ReturnSetupResult.__SHOW_PARTY_RECORDS;
            $("#hdnPlanFlag").val(response.T_ReturnSetupResult.__PLAN_FLAG);


        },
        error: function (errorThrown) {
        }
    });
}

// m_ReturnCreditBalance
var m_ReturnCreditBalance = function () {
    $("#lblBalance").text(0.00);

    $.ajax({
        type: 'POST',
        url: "DataService.svc/T_ReturnCreditBalance",
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        processData: true,
        success: function (response) {
            if (response == null || response.T_ReturnCreditBalanceResult == null) return;

            // Commented by Shrey Kejriwal on 23-04-2016
            //$("#lblBalance").text(response.T_ReturnCreditBalanceResult.__Amount);

            //Added by Shrey Kejriwal on 23-04-2016
            $("#lblBalance").text(vGVService.J_IncludeCommas(response.T_ReturnCreditBalanceResult.__Amount, J_ArgumentType.__Value));

            $("#hdnPlanFlag").val(response.T_ReturnCreditBalanceResult.__SETUP_PLAN_FLAG);

            //Added by Bashir on 26-03-2017
            if (parseInt(response.T_ReturnCreditBalanceResult.__PLAN_STATUS) == 1) {

                $("#lbltotalpaln").text(response.T_ReturnCreditBalanceResult.__CURRENT_NO_OF_RETURNS + " Nos");
                $("#lblpalnname").text(response.T_ReturnCreditBalanceResult.__CURRENT_PLAN_NAME);
                $("#lblBaldays").text(response.T_ReturnCreditBalanceResult.__CURRENT_PLAN_END_DATE);
                //$("#lblBalancepalnDeductee").text(vGVService.J_IncludeCommas(response.T_ReturnCreditBalanceResult.__CURRENT_NO_OF_DEDUCTEE, J_ArgumentType.__Value));

                if (response.T_ReturnCreditBalanceResult.__PLAN_STATUS_LIVE == "LIVE") {

                    //============================
                    $("#snplan").show();
                    $("#lblpalnname").show();
                    $("#snplanaa").show();
                    $("#sncrplan").show();
                    $("#atotalpl").show();
                    $("#sncrp").hide();
                    $("#sncr").hide();
                    $("#lblBalance").hide();
                    $("#use").hide();
                    $("#sndays").hide();
                    $("#lblBaldays").hide();
                    //============================
                    if ($("#hdnPlanFlag").val() == 0) {
                        $("#liplans").hide();
                        $("#liaddcredit").hide();
                        $("#liupgrade").hide();
                        $("#litopup").hide();
                    }
                    else {
                        $("#liaddcredit").hide();
                        $("#liplans").hide();
                        $("#liupgrade").show();
                        $("#litopup").show();
                        $("#liaddcreditonly").hide();
                    }
                }
                    //else if (response.T_ReturnCreditBalanceResult.__PLAN_STATUS_DAYS_LOW == "DAYS_LOW") {
                    //    $("#liaddcredit").show();
                    //    $("#liplans").show();
                    //    $("#litopup").show();
                    //    //============================
                    //    $("#snplan").show();
                    //    $("#lblpalnname").show();
                    //    $("#snplanaa").show();
                    //    $("#sncrplan").hide();
                    //    $("#atotalpl").show();
                    //    $("#sncrp").show();
                    //    $("#sncr").hide();
                    //    $("#lblBalance").hide();
                    //    $("#use").hide();
                    //    $("#sndays").hide();
                    //    $("#lblBaldays").hide();
                    //    //============================
                    //}
                else if (response.T_ReturnCreditBalanceResult.__PLAN_STATUS_LIVE == "HYBRID") {


                    //============================
                    $("#snplan").show();
                    $("#lblpalnname").show();
                    $("#snplanaa").show();
                    $("#sncrplan").show();
                    $("#atotalpl").show();
                    $("#sncrp").hide();
                    $("#sncr").hide();
                    $("#lblBalance").hide();
                    $("#use").hide();
                    $("#sndays").hide();
                    $("#lblBaldays").hide();
                    //============================
                    if ($("#hdnPlanFlag").val() == 0) {
                        $("#liplans").hide();
                        $("#liaddcredit").hide();
                        $("#liupgrade").hide();
                        $("#litopup").hide();
                    }
                    else {
                        $("#liaddcreditonly").hide();
                        $("#liaddcredit").show();
                        $("#liplans").show();
                        $("#liupgrade").hide();
                        $("#litopup").show();
                    }
                }
                else {

                    //============================litopup liplans
                    $("#sncr").show();
                    $("#lblBalance").show();
                    $("#snplan").hide();
                    $("#lblpalnname").hide();
                    $("#snplanaa").hide();
                    $("#sncrplan").hide();
                    $("#atotalpl").hide();
                    $("#sncrp").hide();
                    $("#use").hide();
                    $("#sndays").hide();
                    $("#lblBaldays").hide();
                    //============================
                    if ($("#hdnPlanFlag").val() == 0) {
                        $("#liplans").hide();
                        $("#liaddcredit").hide();
                        $("#liupgrade").hide();
                        $("#litopup").hide();
                    }
                    else {
                        $("#liaddcreditonly").hide();
                        $("#liaddcredit").show();
                        $("#liplans").show();
                        $("#litopup").hide();
                        $("#liupgrade").hide();
                    }
                }
            }
            else {//snplan
                $("#snplan").hide();
                $("#snplanaa").hide();
                $("#sncrplan").hide();
                $("#sncrp").hide();
                $("#use").hide();
                $("#sndays").hide();
                $("#lblBaldays").hide();
                $("#liupgrade").hide();
                $("#litopup").hide();
                $("#lblp").hide();
                $("#lblDays").hide();
                $("#lblReturns").hide();
                $("#lblDeductee").hide();
                $("#lbltotalpaln").hide();
                $("#lblpalndayslaft").hide();
                $("#lblBalancepalnReturns").hide();
                $("#lblBalancepalnDeductee").hide();

                if ($("#hdnPlanFlag").val() == 0) {
                    $("#liplans").hide();
                    $("#liaddcredit").hide();
                }
                else {
                    $("#liaddcreditonly").hide();
                }
            }
        },
        error: function (errorThrown) {
        }
    });
}



// m_SessionLogoutDialog
//---- Added   on 2016-06-23
var m_SessionLogoutDialog = function () {

    // Show confirm Message
    bootbox.dialog({
        closeButton: false,
        message: J_Message.__Session_Timeout,
        title: J_Message.__ProjectTitle,
        buttons: {
            Yes: {
                label: "Close",
                className: "btn btn-primary ",
                callback: function () {
                    window.location = "../Login.aspx";
                }
            }
        }
    });

};



// m_RedirctToLoginPageDialog
//---- Added   on 2016-10-25
var m_RedirctToLoginPageDialog = function (Message) {

    // Show confirm Message
    bootbox.dialog({
        closeButton: false,
        message: Message,
        title: J_Message.__ProjectTitle,
        buttons: {
            Yes: {
                label: "Close",
                className: "btn btn-primary ",
                callback: function () {
                    window.location = "/";
                }
            }
        }
    });

};


// ==========================================================
// Events
// ==========================================================

// load
$(window).load(function () {
    m_ReturnSetup();
});

// ==========================================================
// ==========================================================