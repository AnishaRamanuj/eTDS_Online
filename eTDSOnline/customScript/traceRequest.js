var Cookies = "";
var RequestType = "";
$(function () {
    //Load FA Year
    var year = new Date().getFullYear() - 1;
    var FAOption = "";
    var toYear = "";
    for (i = year; i >= 2005; i--) {
        toYear = (parseInt(i.toString().substr(-2)) + 1);
        toYear = (parseInt(toYear) < 10 ? "0" + toYear : toYear);
        FAOption = i + "-" + toYear;
        if (i == year)
            $("#ddlFAYear").append($("<option selected></option>").val(i).html(FAOption));
        else $("#ddlFAYear").append($("<option></option>").val(i).html(FAOption));
    }

    //Load Form
    var url = new URL(window.location.href);
    RequestType = url.searchParams.get("rt");
    switch (RequestType) {
        case "FORM16A":
            $("#ddlForm").append($("<option></option>").val("26Q").html("26Q"));
            $("#ddlForm").append($("<option></option>").val("27Q").html("27Q"));
            break;
        case "FORM16":
            $("#ddlForm").append($("<option></option>").val("24Q").html("24Q"));
            break;

        case "FORM27D":
            $("#ddlForm").append($("<option></option>").val("27EQ").html("27EQ"));
            break;
        default:
            $("#ddlForm").append($("<option></option>").val("24Q").html("24Q"));
            $("#ddlForm").append($("<option></option>").val("26Q").html("26Q"));
            $("#ddlForm").append($("<option></option>").val("27Q").html("27Q"));
            $("#ddlForm").append($("<option></option>").val("27EQ").html("27EQ"));
            break;
    }

    //Additional Download
    switch (RequestType) {
        case "FORM16A":
        case "FORM16":
        case "FORM27D":
            $("#tdAddlJustification").show();
            $("#tdConsoFile").show();
            break;
        case "DEFAULT":
            $("#tdConsoFile").show();
            $("#tdAddlForm16A").show();
            break;
        default:
            $("#tdAddlJustification").show();
            $("#tdAddlForm16A").show();
            break;

    }
    loadLoginDetails();
    getCaptcha();
});


getChallan = function () {
    var ddlFAYear = $('#ddlFAYear option:selected').text();
    var ddlQuarter = $('#ddlQuarter option:selected').text();
    var ddlForm = $('#ddlForm option:selected').text();

    if ((ddlFAYear == "" || ddlFAYear == undefined) || (ddlQuarter == "" || ddlQuarter == undefined) || (ddlForm == "" || ddlForm == undefined)) {
        return false;
    }

    var tracesData = {
        "tracesData":
        {
            FAYear: ddlFAYear,
            Forms: ddlForm,
            Quarter: ddlQuarter
        }
    };


    $(".MastermodalBackground2").show();

    clearControls();

    $.ajax({
        type: "POST",
        url: "TService.asmx/GetChallan",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify(tracesData),
        success: function (data) {
            $(".MastermodalBackground2").hide();
            var result = JSON.parse(data.d);
            if (result.error) {
                ShowErrorWindow(result.error);
                return false;
            }
            else {
                //loop Challan Details
                var challan = JSON.parse(result["dt_Challan"]);


                $("#ddlChallan").empty();
                $("#ddlChallan").append("<option></option>");
                for (var i = 0; i < challan.length; i++) {
                    $("#ddlChallan").append("<option value='" + challan[i].Challan_ID + "'>" + challan[i].Challan_No + "_" + challan[i].Challan_Date + "_" + challan[i].Challan_Amount + "</option>");
                }
            }
        },
        failure: function (response) {
            $(".MastermodalBackground2").hide();
            ShowErrorWindow(response.d);
        }
    });
}


getparam = function () {
    //debugger;

    var ddlFAYear = $('#ddlFAYear option:selected').text();
    var ddlQuarter = $('#ddlQuarter option:selected').text();
    var ddlForm = $('#ddlForm option:selected').text();
    var ddlChallan = $('#ddlChallan').val();

    if ((ddlFAYear == "" || ddlFAYear == undefined) || (ddlQuarter == "" || ddlQuarter == undefined) || (ddlForm == "" || ddlForm == undefined) || (ddlChallan == "" || ddlChallan == undefined)) {
        clearControls();
        return false;
    }



    //-----------------------
    var tracesData = {
        "tracesData":
        {
            FAYear: ddlFAYear,
            Forms: ddlForm,
            Quarter: ddlQuarter,
            ChallanId: ddlChallan
        }
    };


    $(".MastermodalBackground2").show();

    clearControls();


    $.ajax({
        type: "POST",
        url: "TService.asmx/Get_chlnDetails",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify(tracesData),
        success: function (data) {
            $(".MastermodalBackground2").hide();
            var result = JSON.parse(data.d);
            if (result.error) {
                ShowErrorWindow(result.error);
                return false;
            }
            else {
                //loop Challan Details
                var challan = JSON.parse(result["dt_Challan"]);
                var voucher = JSON.parse(result["dt_Voucher"]);
                var PRN = JSON.parse(result["dt_PRN"]);
                var challan_dtls = challan[0];


                $("#txtChallanNo").val(challan_dtls["Challan_No"]);
                $("#txtBSRCode").val(challan_dtls["Bank_Bsrcode"]);
                $('[id$="txtDateOfDeposit"]').val(challan_dtls["Challan_Date"]);
                $("#txtTaxDeposit").val(challan_dtls["Challan_Amount"].toFixed(2));
                //if (challan_dtls["Nil_Challan"] == false) {
                //    $('#chkNIlChallan').attr('checked', true);
                //}

                //var id = 1;

                $("#ddlPAN1").empty();
                $("#ddlPAN1").append("<option></option>");
                $("#ddlPAN2").empty();
                $("#ddlPAN2").append("<option></option>");
                $("#ddlPAN3").empty();
                $("#ddlPAN3").append("<option></option>");

                for (i = 0; i < voucher.length; i++) {
                    $("#ddlPAN1").append("<option value='" + voucher[i].PAN_NO + "'>" + voucher[i].PAN_NO + "_" + voucher[i].PAN_Date + "_" + voucher[i].TDS_Amt + "</option>");
                    $("#ddlPAN2").append("<option value='" + voucher[i].PAN_NO + "'>" + voucher[i].PAN_NO + "_" + voucher[i].PAN_Date + "_" + voucher[i].TDS_Amt + "</option>");
                    $("#ddlPAN3").append("<option value='" + voucher[i].PAN_NO + "'>" + voucher[i].PAN_NO + "_" + voucher[i].PAN_Date + "_" + voucher[i].TDS_Amt + "</option>");
                    //id = parseInt(i) + 1;
                    //$("#txtPAN" + id).val(voucher[i]["PAN_NO"]);
                    //$("#txtAmount" + id).val(voucher[i]["TDS_Amt"].toFixed(2));
                }
                if (PRN.length > 0) {
                    $("#txtPRN_No").val(PRN[0]["PRN_No"]);

                }
                if (voucher.length > 0) {
                    //if (voucher[0]["PAN_Verified"] == 1) {
                    //    $('#chkNoValidPAN').attr('checked', true);
                    //}
                }

            }
        },
        failure: function (response) {
            $(".MastermodalBackground2").hide();
            ShowErrorWindow(response.d);
        }
    });

    return false;

}

getTDSAmt = function (id) {
    var ddlPAN = $('#ddlPAN' + id + ' option:selected').text();
    var ddlArray = ddlPAN.split('_');
    var TDS_Amt = ddlArray[ddlArray.length - 1];
    $("#txtAmount" + id).val(TDS_Amt);
}

RequestTrace = function () {


    //var UserID = $("#txtUserID").val();
    //var Password = $("#txtPassword").val();
    //var TAN_NO = $("#txtTan").val();
    var fy = $("[id*=hdnFY]").val();
    var UserID = $("[id*=hdnUserid]").val();
    var Password = $("[id*=hdnPassword]").val();
    var TAN_NO = $("input[type=text][id*=txtTanNo]").val();
    var CaptchaCode = $("#captcha").val();
    var ddlFAYear = fy; // $('#ddlFAYear option:selected').val();
    var ddlQuarter = $('#ddlQuarter option:selected').val();
    var ddlForm = $('#ddlForm  option:selected').text();
    var PRNNo = $("#txtPRN_No").val();

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



    if (ddlFAYear == null || ddlFAYear == "" || ddlFAYear == undefined) {
        ShowErrorWindow('Select FA Year');
        return false;
    }
    if (ddlQuarter == "" || ddlQuarter == null || ddlQuarter == undefined) {
        ShowErrorWindow('Select Quarter');
        return false;
    }
    if (ddlForm == "" || ddlForm == null || ddlForm == undefined) {
        ShowErrorWindow('Select Form');
        return false;
    }

    if (PRNNo == null || PRNNo == undefined || PRNNo == "") {
        ShowErrorWindow('Enter Token / PRN Number');
        return false;

    } else {
        if (isNaN(PRNNo)) {
            ShowErrorWindow('Token Number / PRN is a numerical field. Please ensure you enter only numerals');
            return false;
        }
    }
    //----------------------------------------------  
    //----------------------------------------------
    var DateOfDeposit = $('[id$="txtDateOfDeposit"]').val();
    if (DateOfDeposit != "") {
        //var reg = /(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d/;
        //  if (!$('[id$="txtDateOfDeposit"]').val().match(reg)) {
        var dtRegex = new RegExp("^([0]?[1-9]|[1-2]\\d|3[0-1])-(JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)-[1-2]\\d{3}$", 'i');
        if (!dtRegex.test(DateOfDeposit)) {
            ShowErrorWindow("Please enter dd-mmm-yyyy");
            return false;
        }
    }

    var PAN1 = $('#ddlPAN1').val();
    var PAN2 = $('#ddlPAN2').val();
    var PAN3 = $('#ddlPAN3').val();
    var Amount1 = $('#txtAmount1').val();
    var Amount2 = $('#txtAmount2').val();
    var Amount3 = $('#txtAmount3').val();

    if ((PAN1 == null || PAN1 == undefined || PAN1 == "") && ((PAN2 != null && PAN2 != undefined && PAN2 != "") || (PAN3 != null && PAN3 != undefined && PAN3 != ""))) {
        ShowErrorWindow("Please selct PAN in first row before second or third row.");
        return false;
    }

    if ((PAN2 == null || PAN2 == undefined || PAN2 == "") && (PAN3 != null && PAN3 != undefined && PAN3 != "")) {
        ShowErrorWindow("Please selct PAN in second row before third row.");
        return false;
    }

    if (PAN1 != null && PAN1 != undefined && PAN1 != "") {
        if (!PAN1.match(/^([a-zA-Z]){4}([a-zA-Z]){1}([0-9]){4}([a-zA-Z]){1}?$/)) {
            ShowErrorWindow("PAN structure is not valid");
            return false;
        }
    }
    if (PAN2 != null && PAN2 != undefined && PAN2 != "") {
        if (!PAN2.match(/^([a-zA-Z]){4}([a-zA-Z]){1}([0-9]){4}([a-zA-Z]){1}?$/)) {
            ShowErrorWindow("PAN structure is not valid");
            return false;
        }
    }
    if (PAN3 != null && PAN3 != undefined && PAN3 != "") {
        if (!PAN3.match(/^([a-zA-Z]){4}([a-zA-Z]){1}([0-9]){4}([a-zA-Z]){1}?$/)) {
            ShowErrorWindow("PAN structure is not valid");
            return false;
        }
    }


    if (CaptchaCode == null || CaptchaCode == undefined) {
        ShowErrorWindow('Enter Captcha Code');
        return false;
    }


    var NIlChallan = $("#chkNIlChallan").is(':checked');
    var BookAdjustment = $("#chkBookAdjustment").is(':checked');
    var NoValidPAN = $("#chkNoValidPAN").is(':checked');
    var SlNo = $("#txtSerialNo").val();
    var ChallanNo = $("#txtChallanNo").val();
    var BSRCode = $("#txtBSRCode").val();
    var TaxDeposited = $("#txtTaxDeposit").val();
    var AddlConsoFile = $("#chkConsoFile").is(':checked');
    var AddlJustification = $("#chkAddlJustification").is(':checked');
    var AddlForm16A = $("#chkAddlForm16A").is(':checked');
    var AddlForm16 = $("#chkAddlForm16PartA").is(':checked');
    var AddlForm27D = $("#chkAddlForm27D").is(':checked');

    if (ChallanNo == null || ChallanNo == undefined || ChallanNo == "") {
        ShowErrorWindow('Enter Challan Serial No./ DDO');
        return false;
    }

    if (BSRCode == null || BSRCode == undefined || BSRCode == "") {
        ShowErrorWindow('Enter BSR Code / Receipt No.');
        return false;
    }

    if (TaxDeposited == null || TaxDeposited == undefined || TaxDeposited == "") {
        ShowErrorWindow('Enter Challan Amount / Transfer Voucher');
        return false;
    }


    var tracesData = {
        "objTraceData": {
            FAYear: ddlFAYear,
            Quarter: ddlQuarter,
            Forms: ddlForm,
            AuthenticationCode: '',
            PRN_NO: PRNNo,
            IsNoChallan: NIlChallan,
            IsPaymentByBookAdjustmentCheck: BookAdjustment,
            IsNoChallanCheck: NoValidPAN,
            CDRecordNumber: SlNo,
            ChallanSerialNo: ChallanNo,
            BSRCode: BSRCode,
            TaxDepositedDate: DateOfDeposit,
            ChallanAmount: TaxDeposited,
            IsValidPANDeductee: false,
            TAN: TAN_NO,
            PAN1: PAN1,
            PAN1Amount: Amount1,
            PAN2: PAN2,
            PAN2Amount: Amount2,
            PAN3: PAN3,
            PAN3Amount: Amount3,
            FromChallanDepositDate: '',
            ToChallanDepositDate: '',
            ChallanStatus: '',
            AddlReqConsoFile: AddlConsoFile,
            AddlReqJustificationFile: AddlJustification,
            AddlReqForm16AFile: AddlForm16A,
            AddlReqForm16File: AddlForm16,
            AddlReqForm27DFile: AddlForm27D,

        },
        "objLogin": {
            UserID: UserID,
            Password: Password,
            TAN: TAN_NO,
            CaptchaCode: CaptchaCode,
            Cookie: Cookies
        },
        "RequestType": RequestType


    };


    $(".MastermodalBackground2").show();
    document.getElementById("btnGetRequest").disabled = true;

    debugger;
    $.ajax({
        type: "POST",
        url: "TService.asmx/reQTraces",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify(tracesData),
        success: function (data) {
            debugger;
            var result = JSON.parse(data.d);
            if (result.error) {
                $("#captcha").val("");
                getCaptcha();
                $(".MastermodalBackground2").hide();
                ShowErrorWindow(result.error);
                document.getElementById("btnGetRequest").disabled = false;
                return false;
            }
            else {
                if (result.success) {
                    $("#captcha").val("");
                    getCaptcha();
                    clearControls();
                    let ddlQuarter = document.getElementById("ddlQuarter");
                    ddlQuarter.value = "";
                    let ddlForm = document.getElementById("ddlForm");
                    ddlForm.value = "";

                    $('#chkConsoFile').attr('checked', false);
                    $('#chkAddlJustification').attr('checked', false);
                    $('#chkAddlForm16A').attr('checked', false);
                    $('#chkAddlForm16PartA').attr('checked', false);
                    $('#chkAddlForm27D').attr('checked', false);

                    ShowSuccessWindow(result.success);
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