<%@ Page Title="" Language="C#" MasterPageFile="~/TDS/BTS_MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="Deductions.aspx.cs" Inherits="Admin_Deductions" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../BTStrp/css/datepicker.min.css" rel="stylesheet" />
    <script src="../BTStrp/js/bootstrap_multiselect.js" type="text/javascript"></script>
    <script type="text/javascript" src="../BTStrp/js/moment.js"></script>
    <script src="../BTStrp/js/form_select2.js" type="text/javascript"></script>
    <script src="../BTStrp/js/datatables_basic.js" type="text/javascript"></script>
    <script src="../BTStrp/js/Ajax_Pager.min.js" type="text/javascript"></script>
    <script src="../BTStrp/js/components_popups.js" type="text/javascript"></script>
    <script src="../BTStrp/js/components_modals.js" type="text/javascript"></script>
    <script src="../BTStrp/js/echarts.min.js" type="text/javascript"></script>
    <script src="../BTStrp/js/PopupAlert.js" type="text/javascript"></script>
    <script src="../BTStrp/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../BTStrp/js/bootstrap2.3.2.min.js"></script>
    <%--<script type="text/javascript" src="../js/typeahead.jquery.js"></script>--%>

    <style type="text/css">
        .fade {
            opacity: 0;
            -webkit-transition: opacity .15s linear;
            -o-transition: opacity .15s linear;
            transition: opacity .15s linear;
        }

            .fade.in {
                opacity: 1;
            }

        .modal-open {
            overflow: hidden;
        }

        .modal {
            position: fixed;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            z-index: 1050;
            display: none;
            overflow: hidden;
            -webkit-overflow-scrolling: touch;
            outline: 0;
        }

            .modal.fade .modal-dialog {
                -webkit-transition: -webkit-transform .3s ease-out;
                -o-transition: -o-transform .3s ease-out;
                transition: transform .3s ease-out;
                -webkit-transform: translate(0, -25%);
                -ms-transform: translate(0, -25%);
                -o-transform: translate(0, -25%);
                transform: translate(0, -25%);
            }

            .modal.in .modal-dialog {
                -webkit-transform: translate(0, 0);
                -ms-transform: translate(0, 0);
                -o-transform: translate(0, 0);
                transform: translate(0, 0);
            }

        .modal-open .modal {
            overflow-x: hidden;
            overflow-y: auto;
        }

        .modal-dialog {
            position: relative;
            width: auto;
            margin: 10px;
        }

        .fixed-cell {
            /* Your styles for the fixed cell here */
            position: sticky;
            left: 0;
            background-color: white; /* Ensure it doesn't obscure the table header */
            z-index: 1; /* Ensure it's above other cells */
        }

        .modal-content {
            position: relative;
            background-color: #fff;
            -webkit-background-clip: padding-box;
            background-clip: padding-box;
            border: 1px solid #999;
            border: 1px solid rgba(0, 0, 0, .2);
            border-radius: 6px;
            outline: 0;
            -webkit-box-shadow: 0 3px 9px rgba(0, 0, 0, .5);
            box-shadow: 0 3px 9px rgba(0, 0, 0, .5);
        }

        .modal-backdrop {
            position: fixed;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            z-index: 1040;
            background-color: #000;
        }

            .modal-backdrop.fade {
                filter: alpha(opacity=0);
                opacity: 0;
            }

            .modal-backdrop.in {
                filter: alpha(opacity=50);
                opacity: .5;
            }

        .modal-header {
            padding: 15px;
            border-bottom: 1px solid #e5e5e5;
        }

            .modal-header .close {
                margin-top: -2px;
            }

        .modal-title {
            margin: 0;
            line-height: 1.42857143;
        }

        .modal-body {
            position: relative;
            padding: 15px;
        }

        .modal-footer {
            padding: 15px;
            text-align: right;
            border-top: 1px solid #e5e5e5;
        }

            .modal-footer .btn + .btn {
                margin-bottom: 0;
                margin-left: 5px;
            }

            .modal-footer .btn-group .btn + .btn {
                margin-left: -1px;
            }

            .modal-footer .btn-block + .btn-block {
                margin-left: 0;
            }

        .modal-scrollbar-measure {
            position: absolute;
            top: -9999px;
            width: 50px;
            height: 50px;
            overflow: scroll;
        }

        @media (min-width: 768px) {
            .modal-dialog {
                width: 600px;
                margin: 30px auto;
            }

            .modal-content {
                -webkit-box-shadow: 0 5px 15px rgba(0, 0, 0, .5);
                box-shadow: 0 5px 15px rgba(0, 0, 0, .5);
            }

            .modal-sm {
                width: 300px;
            }
        }

        @media (min-width: 992px) {
            .modal-lg {
                width: 900px;
            }
        }
    </style>
    <script language="javascript" type="text/javascript">

        var ddid = 0;

        var UP = 0;
        var NT = '';
        var Mis = '';
        var deddrp = '';
        var vMod = '';
        var myTimer;
        var voucherData, editReasonValue;
        var RecMode = '';
        var Chllst = '';
        var ChlMode = '';
        var ddlRMode = '';
        var CPaid = '';
        $(document).ready(function () {

            $("[id*=ddlperpage]").val(200);
            $("[id*=btnReturns]").hide();
            $("[id*=hdnDEdit]").val('');
            $("[id*=hdnDName]").val('');
            $("[id*=hdnDSrch]").val('');
            $("[id*=hdnSection]").val('');
            $("[id*=hdnConnString]").val($("[id*=ddlFinancialYear] :selected").text());
            $("[id*=hdnPages]").val(1);
            $("[id*=dv_VoucherModify]").hide();
            $("[id*=divMisMatch]").hide();
            $("[id*=dvAddVoucher]").hide();
            $("[id*=btnSave]").hide();
            $("[id*=btnVoucherCancel]").hide();
            $("[id*=btnCancel]").hide();
            $("[id*=drpPerPage]").hide();
            $("[id*=tblNri]").hide();
            $("[id*=dvAddVoucher]").hide();
            //$("[id*=divChlVchr]").hide();
            $("[id*=btnProcess]").show();
            $("[id*=btndwnd]").show();
            $("[id*=btnChkError]").show();
            $("[id*=btnChlCancel]").hide();
            $("[id*=drpCPerPage]").hide();
            $("[id*=ddlForm]").val($("[id*=hdnForm]").val());
            $("[id*=ddltype]").val($("[id*=hdnQuater]").val());
            var M = $("[id*=hdnMis]").val();
            M = M.split(',');
            Mis = M[0];
            $("[id*=ddltype]").trigger('change');

            //FillGrid(ddid);

            onLoad();
            getNature_Branch_Drps();
            FillBSRCodes();
            Fill_Challan_DropDowns();

            $("[id*=btnAdd]").click(function () {
                $("[id*=ddlForm]").attr("disabled", true);
                $("[id*=ddltype]").attr("disabled", true);
                $("[id*=ddl_Reasons]").empty();
                $("[id*=ddl_Reasons]").append("<option value='0'>--Select Reasons--</option>");
                $("[id*=ddl_Reasons]").append().trigger('change');
                $("[id*=spnPG]").html('Deduction Details');
                Clearall();
                ClearChallanControls();
                EnableFields();
                //Fill_Challan_DropDowns();
                RecMode = 'Add';
                vMod = 'hide';
                $("[id*=btnAdd]").hide();
                $("[id*=dvAddVoucher]").show();
                $("[id*=tdSearch]").hide();
                $("[id*=btnCancel]").hide();
                $("[id*=btnProcess]").hide();
                $("[id*=btndwnd]").hide();
                $("[id*=btnChkError]").hide();
                $("[id*=dv_VoucherModify]").hide();
                $("[id*=btnSave]").show();
                $("[id*=tblPager]").hide();

                $("[id*=btnVoucherCancel]").show();
                $("[id*=txt_VoucherDate]").val($("[id*=hdnDate]").val());
                $("[id*=txtDedDate]").val($("[id*=hdnDate]").val());
                $("[id*=hndCurrmth]").val('');
                var x = $("[id*=hdnDName]").val();
                var f = $("[id*=ddlForm]").val();
                ShowHideNRIDivs();
                var o = document.getElementById("ddlChallan").length; //$("[id*=ddlChallan]").Option.length;
                if (o == 1) {
                    $("[id*=ddlChallan]").attr("disabled", true);
                }
                else {
                    $("[id*=ddlChallan]").attr("disabled", false);
                }
            });

            $("[id*=btnProcess]").click(function () {
                $("[id*=btnReturns]").click();
            });

            $("[id*=refreshIcon]").click(function () {
                loadLoginDetails();
                getCaptcha();
            });

            $("[id*=VryChln]").click(function () {
                $('#modal_ChallanVerify').modal('show');
                /* $("[id*=dvTracesuserDe]").hide();*/
                loadLoginDetails();
                getCaptcha();
            });

            $("[id*=btnVoucherCancel]").click(function () {

                $("[id*=ddlForm]").attr("disabled", false);
                $("[id*=ddltype]").attr("disabled", false);
                ClearChallanControls();
                //RecMode = '';
                //ChlMode = '';
                if (Mis == 'Mis') {
                    $("[id*=dv_VoucherModify]").show();
                    $("[id*=dgVoucherModify]").hide();
                    $("[id*=divMisMatch]").show();
                    $("[id*=divModify]").hide();
                    $("[id*=tdSearch]").hide();
                    $("[id*=btnSave]").hide();

                    $("[id*=btnVoucherCancel]").hide();
                    $("[id*=dvAddVoucher]").hide();
                    $("[id*=tblLstRec] tbody").empty();
                }
                else {
                    if (RecMode == 'Add') {
                        $("[id*=dv_VoucherModify]").hide();
                        $("[id*=tdSearch]").show();
                        $("[id*=btnCancel]").hide();
                        $("[id*=dvAddVoucher]").hide();
                        $("[id*=cr_Vou]").show();
                        $("[id*=btnChlCancel]").hide();
                        $("[id*=drpCPerPage]").hide();
                        $("[id*=btnSave]").hide();
                        $("[id*=btnVoucherCancel]").hide();
                        $("[id*=btnProcess]").show();
                        $("[id*=btndwnd]").show();
                        $("[id*=btnChkError]").show();

                        $("[id*=tblLstRec] tbody").empty();
                        $("[id*=hndCurrmth]").val('');
                        Clearall();
                        $("[id*=hdnForm]").val($("[id*=ddlForm]").val());
                        $("[id*=hdnQuater]").val($("[id*=ddltype]").val());
                        FillGrid(ddid);

                        $("[id*=hdnChallanId]").val(0);
                    }
                    else {
                        $("[id*=dv_VoucherModify]").show();
                        $("[id*=divModify]").show();
                        $("[id*=dvAddVoucher]").hide();
                        $("[id*=btnSave]").hide();
                        $("[id*=btnVoucherCancel]").hide();
                        $("[id*=btnProcess]").hide();
                        $("[id*=btndwnd]").hide();
                        if (ChlMode == 'Edit') {
                            $("[id*=btnChlCancel]").show();
                            $("[id*=drpCPerPage]").show();
                            $("[id*=btnCancel]").hide();
                            var Cid = $("[id*=hdnChallanId]").val();
                            p = $("[id*=ddlperpage]").val();
                            $("[id*=spnPG]").html('Challan Entries');
                            VoucherGrid_Challan(0, 1, p, Cid);
                        }
                        else {
                            var p = $("[id*=ddlperpage]").val();
                            var UP = 0;
                            var mth = $("[id*=hndCurrmth]").val();
                            $("[id*=spnPG]").html('Deduction Details');
                            if (mth == '') {
                                $("[id*=drpPerPage]").hide();
                                $("[id*=dv_VoucherModify]").hide();
                                $("[id*=tdSearch]").show();
                                $("[id*=btnCancel]").hide();
                                $("[id*=btnProcess]").show();
                                $("[id*=btndwnd]").show();
                                $("[id*=btnChkError]").show();
                                $("[id*=tblLstRec] tbody").empty();
                                $("[id*=hndCurrmth]").val('');
                                $("[id*=ddlForm]").attr("disabled", false);
                                $("[id*=ddltype]").attr("disabled", false);
                                $("[id*=hdnForm]").val($("[id*=ddlForm]").val());
                                $("[id*=hdnQuater]").val($("[id*=ddltype]").val());

                                RecMode = '';
                                if (ddid > 0) {
                                    FillGrid(ddid);
                                } else {
                                    FillGrid(0);
                                }
                                Clearall();
                                $("[id*=btnAdd]").show();
                            }
                            else {
                                ModifyGrid(mth, 1, p, UP);
                                $("[id*=btnChlCancel]").hide();
                                $("[id*=drpCPerPage]").hide();
                            }
                        }
                        $("[id*=btnChkError]").show();
                        //$("[id*=tdSearch]").show();

                        //$("[id*=dvFltr]").hide();

                        $("[id*=tblLstRec] tbody").empty();

                        ////$("[id*=ddl_typesrch]").val(0);

                        $("[id*=hdnForm]").val($("[id*=ddlForm]").val());
                        $("[id*=hdnQuater]").val($("[id*=ddltype]").val());

                        //$("[id*=hndCurrmth]").val('');
                        $("[id*=hdnChallanId]").val(0);
                        Clearall();
                    }
                }
                $("[id*=btnAdd]").show();
                vMod = 'show';
            });

            $("[id*=btnChallanModalPopupAdd]").click(function () {
                ClearChallanControls();
                var dtot = $("[id*=txtTotal]").val();
                $("[id*=lblchlDTAmt]").html('0.00');
                $("[id*=lblchlDTAmt]").html(dtot);
                $('#modal_Addchallan').modal('show');
            });

            $("[id*=btnChlAdd]").click(function () {
                ClearChallanControls();
                //var dt = $("[id*=hdnDate]").val();
                //$("[id*=txtChinDate]").val(dt);
                $("[id*=lblchlDTAmt]").html('');
                $('[id*=hdnchlid]').val(0);
                $('#modal_Addchallan').modal('show');
            });

            $('#txtSearchDeducteeName.typeahead').typeahead({
                source: function (query, process) {
                    map = {};

                    var Conn = $("[id*=hdnConnString]").val();
                    var D = $("[id*=txtSearchDeducteeName]").val();
                    var F = $("[id*=hdnForm]").val();
                    if (F == '0') { F = ''; }
                    if (D == '') { return; }

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../TDS/BTStrp/handler/Voucher.asmx/Get_TypeAhead",
                        data: '{Conn:"' + Conn + '", F: "' + F + '", D: "' + D + '"}',
                        dataType: 'json',
                        cache: false,
                        success: function (response, textStatus, jqXHR) {
                            var main_obj = jQuery.parseJSON(response.d);
                            var myDrps = main_obj;

                            objects = Srch_ConstructMap(myDrps, map);
                            process(objects);
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                        }
                    });
                },
                updater: function (item) {
                    // $('#hdnDedId').val(map[item].id);
                    var did = map[item].id
                    $("[id*=hdnSrchDed]").val(did);
                    SearchDeductee(did);
                    return item;
                }
            });

            $('#txtded.typeahead').typeahead({
                source: function (query, process) {
                    map = {};
                    var compid = $("[id*=hdnCompanyid]").val();
                    var Conn = $("[id*=hdnConnString]").val();
                    var D = $("[id*=txtded]").val();
                    var F = $("[id*=hdnForm]").val();
                    if (F == '0') { F = ''; }
                    if (D != '' && D.length >= 2) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../../TDS/BTStrp/handler/Voucher.asmx/Get_TypeAhead",
                            data: '{compid:' + compid + ', Conn:"' + Conn + '", F: "' + F + '", D: "' + D + '"}',
                            dataType: 'json',
                            cache: false,
                            success: function (response, textStatus, jqXHR) {
                                var main_obj = jQuery.parseJSON(response.d);

                                var myDrps = main_obj;
                                objects = constructMap(myDrps, map);
                                process(objects);
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                            }
                        });
                    }
                    //objects = constructMap(data, map);
                    //process(objects);
                },
                updater: function (item) {
                    // $('#hdnDedId').val(map[item].id);
                    var did = map[item].id
                    $("[id*=hdnDedId]").val(did);
                    ChangeDeductee(did);
                    return item;
                }
            });

            $("[id*=Label1]").html('Voucher Entries');

            if (Mis != '') {
                $("[id*=ddlForm]").val(M[1]);
                $("[id*=ddltype]").val(M[2]);
                $("[id*=hdnForm]").val(M[1]);
                $("[id*=hdnQuater]").val(M[2]);
            }

            //$("[id*=ddlSearchChallanStatus]").change(function () {
            //    var d = $("[id*=hdnSrchDed]").val(); //$("[id*=ddlSearchDeducteeName]").val();
            //    //var n = $("[id*=ddlSearchNature]").val();
            //    var ch = $("[id*=ddlSearchChallanStatus]").val();
            //    var mth = $("[id*=hndCurrmth]").val();
            //    $("[id*=hdnMis]").val('');
            //    Mis = '';
            //    Search_Grid(mth, 1, 25, d, ch, n);
            //});

            $("[id*=ddl_Type]").change(function () {

                if (RecMode != '') {
                    getNatureSubId();
                }
            });

            $("[id*=ddl_Nature]").change(function () {
                if (RecMode != '') {
                    var n = $("[id*=ddl_Nature]").val();
                    if (parseFloat(n) > 0) {
                        getNatureSubId();
                    }
                }
            });

            $("[id*=ddlChallan]").click(function () {
                ChlMode = 'Click';
            });

            $("[id*=ddlChallan]").change(function () {
                var challanId = $(this).val();

                if (ChlMode == 'Click' && challanId > 0) {
                    if (parseFloat(challanId) > 0) {
                        var Vid = 0;
                        var Cid = challanId;
                        //get_SelectedVoucherChallan(challanId, 0);
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../../TDS/BTStrp/handler/Voucher.asmx/get_SelectedVoucherChallan",
                            data: '{Cid: ' + Cid + ', Vid: ' + Vid + '}',
                            dataType: "json",
                            success: function (msg) {
                                var myList = '';
                                myList = jQuery.parseJSON(msg.d);
                                var challandata = myList[0];
                                ChlMode = '';
                                if (challandata != undefined && challandata != null) {

                                    $("[id*=hdnChallanId]").val(challandata.ChallanID);
                                    $("[id*=txtChallaDt]").val(challandata.ChallanDate);
                                    $("[id*=ddl_ChallanBSRCodes]").val(challandata.BankId);
                                    $("[id*=ddl_ChallanBSRCodes]").trigger('change');
                                    var Camt = parseFloat(challandata.TDS) + parseFloat(challandata.Sur) + parseFloat(challandata.Cess);
                                    $("[id*=txtChallanTdsNC]").val(Camt);
                                    $("[id*=txtChallanDedAmt]").val(challandata.VoucherTotal);

                                    $("[id*=txtChallanDiffAmt]").val(parseFloat(Camt) - parseFloat(challandata.VoucherTotal));

                                    $("[id*=txtChallaDt]").attr("readonly", true);
                                    $("[id*=ddl_ChallanBSRCodes]").attr("disabled", true);
                                    $("[id*=txtChallanTdsNC]").attr("readonly", true);
                                    $("[id*=txtChallanDedAmt]").attr("readonly", true);
                                    $("[id*=txtChallanDiffAmt]").attr("readonly", true);


                                    $("[id*=hdnChlTDSAmt]").val(Camt);

                                    //var damt = challandata.Camt;
                                    //var CBal = parseFloat(Camt) - parseFloat(damt);
                                    //CBal = CBal + '.00';
                                    //damt = damt + '.00';



                                    //calulate amounts
                                    var voucherTotalAmount = $("[id*=txtTotal]").val();
                                    var ConsumedAmt = $("[id*=txtChallanDedAmt]").val();
                                    if (ConsumedAmt == '' || ConsumedAmt == undefined) {
                                        ConsumedAmt = 0;
                                    }
                                    //Camt = parseFloat(Camt) - parseFloat(ConsumedAmt);
                                    var totalAmount = 0; //challandata.Camt - challandata.VoucherTotal;
                                    $("[id*=hdnVoucherTotalAmount]").val(voucherTotalAmount);
                                    $("[id*=hdnTotalAmount]").val(totalAmount);

                                    if (RecMode == 'Add') {
                                        totalAmount = parseFloat(Camt) - (parseFloat(voucherTotalAmount) + parseFloat(ConsumedAmt));
                                        if (totalAmount < 0) {

                                            showPrimaryAlert('Voucher Total cannot be more than Challan TDS Amount');
                                        }
                                    }
                                    else {
                                        /////////////// delete old voucher amt from challan
                                        totalAmount = parseFloat(Camt) - parseFloat(challandata.VoucherTotal);
                                        /////////////// add current voucher amt in challan and check the difference

                                        totalAmount = parseFloat(totalAmount) - parseFloat(voucherTotalAmount);


                                        if (totalAmount < 0) {

                                            showPrimaryAlert('Voucher Total cannot be more than Challan TDS Amount');

                                        }
                                    }

                                    setAllControlsNumericFormat();
                                }
                                Blockloaderhide();
                            },
                            failure: function (response) {
                                Blockloaderhide();
                            },
                            error: function (response) {
                                Blockloaderhide();
                            }
                        });

                    }
                    else {
                        $("[id*=hdnChallanId]").val(0);
                        $("[id*=txtChallaDt]").val();
                        $("[id*=ddl_ChallanBSRCodes]").val(0);
                        $("[id*=ddl_ChallanBSRCodes]").trigger('change');
                        $("[id*=txtChallanTdsNC]").val(0);
                        $("[id*=txtChallanDedAmt]").val(0);
                        $("[id*=txtChallanDiffAmt]").val(0);
                    }
                }

            });

            $("[id*=ddlperpage]").change(function () {
                var p = $("[id*=ddlperpage]").val();
                var d = $("[id*=hdnSrchDed]").val();   //$("[id*=ddlSearchDeducteeName]").val();
                //var n = $("[id*=ddlSearchNature]").val();
                //var ch = $("[id*=ddlSearchChallanStatus]").val();
                var ch = '';
                var n = '';
                var mth = $("[id*=hndCurrmth]").val();
                $("[id*=hdnPages]").val(1);
                Search_Grid(mth, 1, p, d, ch, n);
            });

            $("[id*=ddlForm]").change(function () {
                var f = $("[id*=ddlForm]").val();
                var t = $("[id*=ddltype]").val();
                //$("[id*=divChlVchr]").hide();
                $("[id*=cr_Vou]").show();
                if (vMod == 'hide') {
                    $("[id*=btnAdd]").show();
                    $("[id*=hdnForm]").val(f);
                    $("[id*=hdnQuater]").val(t);
                    $("[id*=hdnDSrch]").val('');
                    $("[id*=hdnDrps]").val('');
                    onLoad();
                    getNature_Branch_Drps();
                }
                else {
                    if (f != '0' && t != '0') {
                        vMod = 'show';
                        $("[id*=btnAdd]").show();
                        $("[id*=hdnForm]").val(f);
                        $("[id*=hdnQuater]").val(t);
                        $("[id*=hdnDSrch]").val('');
                        $("[id*=hdnDrps]").val('');
                        onLoad();
                        getNature_Branch_Drps();
                    }
                    else {
                        $("[id*=btnAdd]").hide();
                        $("[id*=hdnQuater]").val('');
                        $("[id*=hdnForm]").val('');
                        $("[id*=hdnDSrch]").val('');
                        $("[id*=hdnDrps]").val('');
                        onLoad();
                        getNature_Branch_Drps();
                    }
                }
                ShowHideNRIDivs();
            });

            $("[id*=ddltype]").change(function () {
                var f = $("[id*=ddlForm]").val();
                var t = $("[id*=ddltype]").val();
                //$("[id*=divChlVchr]").hide();
                $("[id*=cr_Vou]").show();
                if (vMod == 'hide') {
                    $("[id*=btnAdd]").show();
                    $("[id*=hdnForm]").val(f);
                    $("[id*=hdnQuater]").val(t);
                    onLoad();
                }
                else {
                    if (f != '0' && t != '0') {
                        vMod = 'show';
                        $("[id*=btnAdd]").show();
                        $("[id*=hdnForm]").val(f);
                        $("[id*=hdnQuater]").val(t);
                        onLoad();
                    }
                    else {
                        vMod = 'hide';
                        $("[id*=btnAdd]").hide();
                        $("[id*=hdnQuater]").val('');
                        $("[id*=hdnForm]").val('');
                        onLoad();
                    }
                }
            });

            $("[id*=drpQua]").change(function () {
                var Q = $("[id*=drpQua]").val();
                var F = $("[id*=drpForm]").val();

                if (Q != '' && F != '') {
                    $("[id*=hdnMis]").val('Mis,' + F + Q);
                    Mis = 'Mis';
                    $("[id*=Label1]").html('MisMatch Voucher Entries');
                    MisMatch_Vouchers(Q, F);
                }
            });

            $("[id*=drpForm]").change(function () {
                var Q = $("[id*=drpQua]").val();
                var F = $("[id*=drpForm]").val();
                if (Q != '' && F != '') {
                    $("[id*=hdnMis]").val('Mis,' + F + Q);
                    Mis = 'Mis';
                    $("[id*=Label1]").html('MisMatch Voucher Entries');
                    MisMatch_Vouchers(Q, F);
                }
            });

            //$("[id*=ddlSearchNature]").change(function () {
            //    var p = $("[id*=ddlperpage]").val();
            //    var d = $("[id*=hdnSrchDed]").val();  // $("[id*=ddlSearchDeducteeName]").val();
            //    var n = $("[id*=ddlSearchNature]").val();
            //    var ch = $("[id*=ddlSearchChallanStatus]").val();
            //    var mth = $("[id*=hndCurrmth]").val();
            //    Search_Grid(mth, 1, p, d, ch, n);
            //});

            $("[id*=ddl_Reasons]").click(function () {
                ddlRMode = 'Click';
            });
            $("[id*=ddl_Reasons]").change(function () {
                var R = $("[id*=ddl_Reasons]").val();
                if (R == 'Lower Rt. Under Section 197 A') {
                    $("[id*=txtCertNo]").attr("disabled", false);
                }
                else {
                    $("[id*=txtCertNo]").val('');
                    $("[id*=txtCertNo]").attr("disabled", true);
                }
                var PAN = $("[id*=txtPAN]").val();
                if (R == 'Non-Availability of PAN C' && PAN != 'PANNOTAVBL') {
                    $("[id*=ddl_Reasons]").val('');
                }

                if (PAN == 'PANNOTAVBL') {
                    $("[id*=ddl_Reasons]").val('Non-Availability of PAN C');
                }
                if (ddlRMode == 'Click') {
                    GetRate();
                }



                ddlRMode = '';
            });

            $("[id*=btnBack]").click(function () {
                $("[id*=hdnMis]").val('');
                Mis = '';
                $("[id*=dv_VoucherModify]").hide();
                $("[id*=dvAddVoucher]").hide();
                $("[id*=btnSave]").hide();
                $("[id*=btnVoucherCancel]").hide();
                $("[id*=tdSearch]").show();
                $("[id*=btnCancel]").hide();
                $("[id*=tblLstRec] tbody").empty();
                //$("[id*=hndCurrmth]").val('');
                ////$("[id*=ddl_typesrch]").val(0);
                $("[id*=Label1]").html('Voucher Entries');
                Clearall();
                $("[id*=hdnForm]").val($("[id*=ddlForm]").val());
                $("[id*=hdnQuater]").val($("[id*=ddltype]").val());

                FillGrid(ddid);
            });

            $("[id*=btnSave]").click(function () {
                SaveDeduction;
            });

            $("[id*=btnvoucherecord]").click(function () {

                var chk = "", row = "", rid = "", paidids = '', nonpaid = '';
                $("input[name=chkEjob]").each(function () {
                    row = $(this).closest("tr");
                    chk = $(this).is(':checked');
                    if (chk == true) {
                        enddt = row.find("input[name=hdnCid]").val();
                        if (enddt != '') {
                            paidids = $(this).val() + ',' + paidids;
                        } else {
                            nonpaid = $(this).val() + ',' + nonpaid;
                        }
                    }
                });

                if (paidids == '' && nonpaid == '') {
                    showInfoAlert('Select Vouchers to Delete !!!');
                    return false
                } else {
                    Blockloadershow();
                    Clearall();
                    //var compid = $("[id*=hdnCompanyid]").val();
                    var Conn = $("[id*=hdnConnString]").val();
                    var msg = '';
                    if (paidids != '') {
                        msg = 'Only Unpaid deduction will get deleted';
                    }
                    else {
                        msg = 'Delete deduction?'
                    }
                }

                var notice = new PNotify({
                    title: 'Confirmation',
                    text: '<p>' + msg + '</p>',
                    hide: false,
                    type: 'warning',
                    confirm: {
                        confirm: true,
                        buttons: [
                            {
                                text: 'Yes',
                                addClass: 'btn btn-sm btn-primary'
                            },
                            {
                                addClass: 'btn btn-sm btn-link'
                            }
                        ]
                    },
                    buttons: {
                        closer: false,
                        sticker: false
                    }
                })

                // On confirm
                notice.get().on('pnotify.confirm', function () {
                    Del_Vouchers(paidids, nonpaid, 0, Conn);
                })

                // On cancel
                notice.get().on('pnotify.cancel', function () {

                });
                event.stopPropagation();
            });

            $("[id*=btnChlCancel]").click(function () {

                $("[id*=dv_VoucherModify]").hide();
                $("[id*=tdSearch]").show();
                $("[id*=btnCancel]").hide();
                //$("[id*=divChlVchr]").hide();
                $("[id*=cr_Vou]").show();
                $("[id*=btnChlCancel]").hide();
                $("[id*=drpCPerPage]").hide();

                $("[id*=btnProcess]").show();
                $("[id*=btndwnd]").show();
                $("[id*=btnChkError]").show();
                $("[id*=spnPG]").html('Deduction Details');
                $("[id*=tblLstRec] tbody").empty();
                //$("[id*=hndCurrmth]").val('');
                //$("[id*=ddlForm]").attr("disabled", false);
                //$("[id*=ddltype]").attr("disabled", false);
                $("[id*=hdnForm]").val($("[id*=ddlForm]").val());
                $("[id*=hdnQuater]").val($("[id*=ddltype]").val());
                if (ddid > 0) {
                    FillGrid(ddid);
                } else {
                    FillGrid(0);
                }
                Clearall();
                $("[id*=btnAdd]").show();
            });

            $("[id*=btnCancel]").click(function () {
                $("[id*=drpPerPage]").hide();
                $("[id*=dv_VoucherModify]").hide();
                $("[id*=dvAddVoucher]").hide();
                ChlMode = '';
                $("[id*=tdSearch]").show();
                $("[id*=btnCancel]").hide();
                $("[id*=btnProcess]").show();
                $("[id*=btndwnd]").show();
                $("[id*=btnChkError]").show();
                $("[id*=tblLstRec] tbody").empty();
                //$("[id*=hndCurrmth]").val('');
                $("[id*=ddlForm]").attr("disabled", false);
                $("[id*=ddltype]").attr("disabled", false);
                $("[id*=hdnForm]").val($("[id*=ddlForm]").val());
                $("[id*=hdnQuater]").val($("[id*=ddltype]").val());
                $("[id*=drpChallanType]").attr("disabled", false);
                $("[id*=spnPG]").html('Deduction Details');
                RecMode = '';
                if (ddid > 0) {
                    FillGrid(ddid);
                } else {
                    FillGrid(0);
                }
                GetAddedChallaninList(0);
                Clearall();
                $("[id*=btnAdd]").show();
            });

            $("[id*=txtTDSRt]").keyup(function (e) { //$("[id*=txtTDSRt]").blur(function () {
                CalculateAmounts('txtTDSRt');
                setNumericFormat($(this));
            });

            $("[id*=txtIncome]").keyup(function (e) { //$("[id*=txtIncome]").blur(function () {
                CalculateAmounts('txtIncome');
                setNumericFormat($(this));
            });

            $("[id*=txtsurc]").keyup(function (e) {//$("[id*=txtsurc]").blur(function () {
                CalculateAmounts('txtsurc');
                setNumericFormat($(this));
            });

            $("[id*=txtChlTDS]").blur(function () {
                setNumericFormat($(this));
            });

            $("[id*=txtChSur]").blur(function () {
                setNumericFormat($(this));
            });

            $("[id*=txtChlCess]").blur(function () {
                setNumericFormat($(this));
            });

            $("[id*=txtChInt]").blur(function () {
                setNumericFormat($(this));
            });

            $("[id*=txtChlOth]").blur(function () {
                setNumericFormat($(this));
            });

            $("[id*=txtChTotal]").blur(function () {
                setNumericFormat($(this));
            });

            $("[id*=txtChallanTdsNC]").blur(function () {
                setNumericFormat($(this));
            });

            $("[id*=txtChallanDedAmt]").blur(function () {
                setNumericFormat($(this));
            });

            $("[id*=txtChallanDiffAmt]").blur(function () {
                setNumericFormat($(this));
            });
            $("[id*=txtStart]").blur(function () {
                var st = $("[id*=txtStart]").val();
                var ed = $("[id*=txtend]").val();
                if (st == '' || st == undefined) {
                    return;
                }
                if (ed == '' || ed == undefined) {
                    return;
                }
                var mth = $("[id*=hndCurrmth]").val();
                var PageIndex = $("[id*=hdnPages]").val();
                p = $("[id*=ddlperpage]").val();

                if (ChlMode == 'Edit') {
                    var Cid = $("[id*=hdnChallanId]").val();
                    VoucherGrid_Challan(0, 1, p, Cid);
                }
                else {
                    ModifyGrid(mth, PageIndex, p, 0);
                }
            });

            $("[id*=txtend]").blur(function () {
                var st = $("[id*=txtStart]").val();
                var ed = $("[id*=txtend]").val();
                if (st == '' || st == undefined) {
                    return;
                }
                if (ed == '' || ed == undefined) {
                    return;
                }
                var mth = $("[id*=hndCurrmth]").val();
                var PageIndex = $("[id*=hdnPages]").val();
                p = $("[id*=ddlperpage]").val();
                if (ChlMode == 'Edit') {
                    var Cid = $("[id*=hdnChallanId]").val();
                    VoucherGrid_Challan(0, 1, p, Cid);
                }
                else {
                    ModifyGrid(mth, PageIndex, p, 0);
                }
            });


            $("[id*=txt_VoucherDate]").change(function () {
                var did = $("[id*=hdnDedId]").val();
                if (did != '' && did != undefined && did != '0') {
                    GetRate();
                }
            });

            $("[id*=txt_VoucherDate]").blur(function () {
                var did = $("[id*=hdnDedId]").val();
                var fn = $("[id*=hdnConnString]").val();
                var fy = fn.split('_');
                var st = '04/01/' + fy[0];
                var ed = '03/31/20' + fy[1];
                var vd = new Date;
                var s = new Date;
                var e = new Date;
                var d = $("[id*=txt_VoucherDate]").val();
                var dt = d.split('-');
                d = dt[1] + '/' + dt[2] + '/' + dt[0];

                vd = moment(d);
                s = moment(st);
                e = moment(ed);
                if (moment(vd) < moment(s)) {
                    $("[id*=txt_VoucherDate]").val('');
                    showInfoAlert('Voucher date cannot be outside the Financial year');
                    return;
                }
                if (moment(vd) > moment(e)) {
                    $("[id*=txt_VoucherDate]").val('');
                    showInfoAlert('Voucher date cannot be outside the Financial year');
                    return;
                }
                var qua = $("[id*=ddltype]").val();
                var q = qua.substring(1);
                if (q == 1) {
                    if (dt[1] < 4 || dt[1] > 6) {
                        $("[id*=txt_VoucherDate]").val('');
                        showInfoAlert('Voucher date cannot be outside the Quarter');
                        return;
                    }
                }
                else if (q == 2) {
                    if (dt[1] < 7 || dt[1] > 9) {
                        $("[id*=txt_VoucherDate]").val('');
                        showInfoAlert('Voucher date cannot be outside the Quarter');
                        return;
                    }
                }
                else if (q == 3) {
                    if (dt[1] < 10 || dt[1] > 13) {
                        $("[id*=txt_VoucherDate]").val('');
                        showInfoAlert('Voucher date cannot be outside the Quarter');
                        return;
                    }
                }
                else if (q == 4) {
                    if (dt[1] < 1 || dt[1] > 3) {
                        $("[id*=txt_VoucherDate]").val('');
                        showInfoAlert('Voucher date cannot be outside the Quarter');
                        return;
                    }
                }

                var d = $("[id*=txt_VoucherDate]").val();
                $("[id*=txtDedDate]").val(d);
            });

            $("[id*=txtDdate]").blur(function () {

                var fn = $("[id*=hdnConnString]").val();
                var fy = fn.split('_');
                var st = '04/01/' + fy[0];
                var ed = '03/31/20' + fy[1];

                var vd = new Date;
                var s = new Date;
                var e = new Date;
                var d = $("[id*=txtDedDate]").val();
                var dt = d.split('/');
                d = dt[1] + '/' + dt[0] + '/' + dt[2];

                vd = moment(d);
                s = moment(st);
                e = moment(ed);
                if (moment(vd) < moment(s)) {
                    $("[id*=txtDedDate]").val('');
                    alert('Deduction date cannot be outside the Financial year');
                    return;
                }
                if (moment(vd) > moment(e)) {
                    $("[id*=txtDedDate]").val('');
                    alert('Deduction date cannot be outside the Financial year');
                    return;
                }
            });

            $("[id*=txtDedDate]").keyup(function (e) {
                if (e.which == 13) {
                    e.preventDefault();
                    return false;
                }
            });

            $('[id*=txtChlTDS]').blur(function () {
                CalculateTotal();
            });

            $('[id*=txtChSur]').blur(function () {
                CalculateTotal();
            });

            $('[id*=txtChlCess]').blur(function () {
                CalculateTotal();
            });

            $('[id*=txtChInt]').blur(function () {
                CalculateTotal();
            });

            $('[id*=txtChlOth]').blur(function () {
                CalculateTotal();
            });

            $("[id*=txtCess]").keyup(function (e) { // $('[id*=txtCess]').blur(function () {
                CalculateAmounts('txtCess');
                setNumericFormat($(this));
            });

            $('[id*=txtTotal]').blur(function () {
                setNumericFormat($(this));
            });

            $('[id*=btnChlnSave]').click(function () {
                var cid = $('[id*=hdnchlid]').val();
                var compid = $("[id*=hdnCompanyid]").val();
                var grandtotal = 0;
                var tds = $('[id*=txtChlTDS]').val();
                var sur = $('[id*=txtChSur]').val();
                var cess = $('[id*=txtChlCess]').val();
                var int = $('[id*=txtChInt]').val();
                var oth = $('[id*=txtChlOth]').val();
                var fee = 0;
                var C = $('[id*=txtBankChinNo]').val();
                var DT = $('[id*=txtChinDate]').val();
                var bsrCode = $('[id*=ddl_BSRCodes]').val();
                var Q = $("[id*=hdnQuater]").val();
                var F = $("[id*=hdnForm]").val();
              ////  $('[id*=btnChlnSave]').attr("disabled", true);  ******
                $('[id*=btnChlnSave]').hide();
                ////////// Checking for Voucher if in edit mode challan is added
                //var Vid = $("[id*=hdnVoucherID]").val();
                //if (Vid == '' || Vid == undefined) {
                //    Vid = 0;
                //}
                if (F == '0') { F = ''; }
                if (Q == '0') { Q = ''; }
                if (cid == '' || cid == undefined) {
                    cid = 0;
                }

                if (isNaN(parseFloat(tds))) {
                    tds = 0.00;
                }
                if (isNaN(parseFloat(sur))) {
                    sur = 0.00;
                }
                if (isNaN(parseFloat(cess))) {
                    cess = 0.00;
                }
                if (isNaN(parseFloat(int))) {
                    int = 0.00;
                }
                if (isNaN(parseFloat(oth))) {
                    oth = 0.00;
                }
                var TI = 0.00;
                TI = parseFloat(tds) + parseFloat(int);
                var vsid = '';
                if (bsrCode == 0) {
                    showInfoAlert(" BSR code is required");

                    $("[id*=ddl_BSRCodes]").css("background-color", "#FCE4EC");

                   //// $('[id*=btnChlnSave]').attr("disabled", false); ******
                    $('[id*=btnChlnSave]').show();
                    return;
                }
                else if (DT == '') {
                    showInfoAlert("Challan Date is required");

                    $("[id*=txtChinDate]").css("background-color", "#FCE4EC");

                 ////   $('[id*=btnChlnSave]').attr("disabled", false); ******
                    $('[id*=btnChlnSave]').show();
                    return;
                }
                else if (C == '') {
                    showInfoAlert("Challan No is required");

                    $("[id*=txtChinDate]").css("background-color", "#FCE4EC");

                   //// $('[id*=btnChlnSave]').attr("disabled", false);  ******
                    $('[id*=btnChlnSave]').show();
                    return;
                }
                else if (TI == 0) {
                    showInfoAlert("Challan tds is required");

                    $('[id*=txtChlTDS]').css("background-color", "#FCE4EC");
                  ////  $('[id*=btnChlnSave]').attr("disabled", false);   ******
                    $('[id*=btnChlnSave]').show();
                    return;
                }
                else {

                    var ch = parseFloat(tds) + parseFloat(sur) + parseFloat(cess);
                    var dmt = $("[id*=lblchlDTAmt]").html(); //$("[id*=hdnvids4Chl]").val();
                    if (ChlMode == 'Add' && RecMode == 'Edit') {
                        vsid = $("[id*=hdnvids4Chl]").val();
                        if (ch < dmt) {
                            showDangerAlert('Challan Amt is less than selected deductions Amt');
                          ////  $('[id*=btnChlnSave]').attr("disabled", false);  ******
                            $('[id*=btnChlnSave]').show();
                            return;
                        }
                    }
                    var grandtotal = parseFloat(tds) + parseFloat(sur) + parseFloat(cess) + parseFloat(int) + parseFloat(oth);
                    if (bsrCode == '') {
                    }
                    if (DT == '') {
                    }
                    if (C == '') {
                    }
                    if (C == '0') { }

                    var chl = tds + '^' + sur + '^' + cess + '^' + int + '^' + oth + '^' + grandtotal + '^' + C + '^' + DT + '^' + bsrCode + '^' + F + '^' + Q + '^' + cid;
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../TDS/BTStrp/handler/Voucher.asmx/Save_Challan",
                        data: '{chl: "' + chl + '", vids:"' + vsid + '"}',
                        dataType: "json",
                        success: function (msg) {
                            var myList = '';

                            myList = jQuery.parseJSON(msg.d);
                           //// $('[id*=btnChlnSave]').attr("disabled", false);    ******
                            $('[id*=btnChlnSave]').show();
                            // main_obj = myList[0];
                            var challans = myList[0].LstChallan;
                            showSuccessAlert('Challan added successfully');
                            if (myList[0].Challan_ID > 0) {
                                $("[id*=hdnChallanId]").val(myList[0].Challan_ID);
                                if (ChlMode == 'Add' && RecMode == 'Edit') {
                                    ChlMode = '';
                                    VoucherGrid_Challan(0, 1, p, myList[0].Challan_ID);

                                }
                                else {


                                    if (RecMode == '') {
                                        $("[id*=ddlChallan]").append("<option value='" + myList[0].Challan_ID + "'>" + C + "</option>");
                                        //GetAddedChallaninList(myList[0].Challan_ID);
                                        FillChallanTable(challans);
                                    }
                                    else {
                                        ChlMode = 'Click';
                                        //// add challan to dropdown
                                        ///// set values
                                        $("[id*=ddlChallan]").append("<option value='" + myList[0].Challan_ID + "'>" + C + "</option>");

                                        var Tdstotal = parseFloat(tds) + parseFloat(sur) + parseFloat(cess);
                                        $("[id*=ddlChallan]").val(myList[0].Challan_ID);
                                        $("[id*=ddlChallan]").trigger('change');
                                        $("[id*=hdnChallanId]").val(myList[0].Challan_ID);
                                        $("[id*=txtChallaDt]").val(DT);
                                        $("[id*=ddl_ChallanBSRCodes]").val(bsrCode);
                                        $("[id*=ddl_ChallanBSRCodes]").trigger('change');
                                        $("[id*=txtChallanTdsNC]").val(Tdstotal);
                                        $("[id*=txtChallanDedAmt]").val(0);
                                        $("[id*=txtChallanDiffAmt]").val(grandtotal);
                                        FillChallanTable(challans);
                                    }

                                }

                                $('#modal_Addchallan').modal('hide');
                                //if (RecMode == 'Edit') {
                                //$("[id*=ddlChallan]").val(myList[0].ChallanID);
                                //$("[id*=ddlChallan]").trigger('change');

                                //}
                            }
                            if (myList[0].ChallanID < 0) {
                                showDangerAlert("Challan no already exists");
                                Blockloaderhide();
                            }
                            $("[id*=txtBankChinNo]").css("background-color", "");
                            $("[id*=txtChinDate]").css("background-color", "");
                            $("[id*=ddl_BSRCodes]").css("background-color", "");
                            $('[id*=txtChlTDS]').css("background-color", "");
                            $('[id*=hdnchlid]').val(0);
                            Blockloaderhide();
                            ChlMode = '';

                        },
                        failure: function (response) {
                            showDangerAlert("Error");
                            Blockloaderhide();
                           //// $('[id*=btnChlnSave]').attr("disabled", false);     ******
                            $('[id*=btnChlnSave]').show();
                        },
                        error: function (response) {
                            showDangerAlert("Error");
                            Blockloaderhide();
                            //// $('[id*=btnChlnSave]').attr("disabled", false);     ******
                            $('[id*=btnChlnSave]').show();
                        }
                    });
                }
            });

            $("[id*=txtPAN]").change(function () {
                var inputvalues = $(this).val();
                var panChk = IsValidPanNumber(inputvalues)
                if (!panChk) {
                    if (inputvalues != 'PANNOTAVBL') {
                        showDangerAlert("Please enter correct pan no");
                        $("[id*=txtPAN]").val("");
                    }
                }

            });

            $("[id*=txtPAN]").blur(function () {
                var p = $(this).val();
                if (p == 'PANNOTAVBL') {
                    $("[id*=ddl_Reasons]").val('Non-Availability of PAN C');
                    $("[id*=ddl_Reasons]").trigger('change');
                }

            });

            $("[id*=drpIsNri]").change(function () {
                if ($("[id*=drpIsNri]").val() == 'Y') {
                    $("[id*=dvEstIndia]")[0].style.display = 'block';
                }
                else $("[id*=dvEstIndia]")[0].style.display = 'none';
            });

            $("[id*=txtCertNo]").blur(function () {
                var c = $("[id*=txtCertNo]").val();
                if (c.length != 10) {
                    showDangerAlert('Incorrect Certificate number');
                }
            });

            $("[id*=btnChlnMap]").click(function () {
                Blockloadershow();

                var f = $("[id*=ddlForm]").val();
                var vsid = '';
                var totvamt = 0;
                var totcamt = 0;
                var S = $("[id*=txtSrchChln]").val();
                if (S == undefined) {
                    S = '0';
                }
                var Q = $("[id*=hdnQuater]").val();
                $("[id*=DTAmt]").html('0');
                $("input[name=chkEjob]:checked").each(function () {
                    var row = $(this).closest("tr");
                    var vid = $(this).val();
                    vsid = vid + '^' + vsid;
                    totvamt = totvamt + parseFloat(row.find("td").eq(7).text());
                    totcamt = totcamt + parseFloat(row.find("td").eq(8).text());

                });
                if (vsid == '') {
                    showDangerAlert('Select atleast 1 deductions');
                    Blockloaderhide();
                    return;
                }
                else {
                    $("[id*=hdnvids4Chl]").val(vsid);
                }

                $("[id*=DTAmt]").html(totcamt);
                ///////// Clear lables
                $("[id*=lblCno]").html('');
                $("[id*=lblCdt]").html('');
                $("[id*=CTAmt]").html('0');
                $("[id*=CBalAmt]").html('0');
                // $("[id*=DTAmt]").html('0');

                $('#modal_chl').modal('show');
                $("[id*=mdlChlnDtds]").show();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../TDS/BTStrp/handler/Voucher.asmx/Search_Challan",
                    data: '{ S: "' + Q + '", f:"' + f + '"}',
                    dataType: "json",
                    success: function (msg) {
                        var myList = '';
                        myList = jQuery.parseJSON(msg.d);
                        ///// Challan
                        var tbl = '';
                        $("[id*=tblSrchChln] tr").empty();
                        $("[id*=tblSrchChln] tbody").empty();
                        tbl = tbl + "<tr >";
                        tbl = tbl + "<th style='text-align: center; '>No</th>";
                        tbl = tbl + "<th >Date</th>";
                        tbl = tbl + "<th >BSR</th>";
                        tbl = tbl + "<th >TDS+Sur+Cess</th>";
                        tbl = tbl + "<th >Total Amt</th>";
                        tbl = tbl + "<th >Consumed Amt</th>";
                        tbl = tbl + "<th >Balance Amt</th>";
                        tbl = tbl + "<th >Qtr</th>";
                        tbl = tbl + "</tr>";
                        if (myList.length > 0) {
                            for (var i = 0; i < myList.length; i++) {
                                tbl = tbl + "<tr>";
                                tbl = tbl + "<td ><a href='#'  onclick='Select_Chln($(this))' >" + myList[i].ChallanNo + "</a>" + "<input type='hidden' id='hdnCid' value='" + myList[i].ChallanID + "' name='hdnCid'></td>";
                                tbl = tbl + "<td ><input type='hidden' id='hdncSur' value='" + myList[i].Sur + "' name='hdncSur'>" + myList[i].ChallanDate + "</td>";
                                tbl = tbl + "<td ><input type='hidden' id='hdncInt' value='" + myList[i].Interest + "' name='hdncInt'>" + myList[i].BSR + "</td>";
                                tbl = tbl + "<td style='text-align: right;' ><input type='hidden' id='hdncCess' value='" + myList[i].Cess + "' name='hdncCess'>" + myList[i].TDS + '.00' + "</td>";
                                tbl = tbl + "<td style='text-align: right;' ><input type='hidden' id='hdncOth' value='" + myList[i].Others + "' name='hdncOth'>" + myList[i].CAmount + '.00' + "</td>";
                                tbl = tbl + "<td style='text-align: right;' ><a href='#'  onclick='Select_Chln($(this))' >" + myList[i].CTotal + '.00' + "</a></td>";
                                tbl = tbl + "<td >" + myList[i].Balance + "</td>";
                                tbl = tbl + "<td >" + myList[i].Quarter + "<input type='hidden' id='hdnDAmt' value='" + myList[i].CTotal + '.00' + "' name='hdnDAmt'></td>";

                                tbl = tbl + "</tr>";
                            };


                            $("[id*=tblSrchChln]").append(tbl);
                        }
                        else {
                            tbl = tbl + "<tr>";

                            tbl = tbl + "<td ></td>";
                            tbl = tbl + "<td >No Record Found !!!</td>";
                            tbl = tbl + "<td ></td>";
                            tbl = tbl + "<td ></td>";
                            tbl = tbl + "<td ></td>";
                            tbl = tbl + "<td ></td>";
                            tbl = tbl + "<td ></td>";
                            tbl = tbl + "<td ></td>";
                            tbl = tbl + "</tr>";
                            $("[id*=tblSrchChln]").append(tbl);

                        }

                        Blockloaderhide();
                    },
                    failure: function (response) {
                        Blockloaderhide();
                    },
                    error: function (response) {
                        Blockloaderhide();
                    }
                });

            });


            $("[id*=btnNAddMapChl]").click(function () {
                Blockloadershow();

                var f = $("[id*=ddlForm]").val();
                var vsid = '';
                var totvamt = 0;
                var totcamt = 0;
                var S = $("[id*=txtSrchChln]").val();
                if (S == undefined) {
                    S = '0';
                }
                var Q = $("[id*=hdnQuater]").val();
                $("[id*=DTAmt]").html('0');
                $("input[name=chkEjob]:checked").each(function () {
                    var row = $(this).closest("tr");
                    var vid = $(this).val();
                    vsid = vid + '^' + vsid;
                    totvamt = totvamt + parseFloat(row.find("td").eq(7).text());
                    totcamt = totcamt + parseFloat(row.find("td").eq(8).text());

                });
                if (vsid == '') {
                    showDangerAlert('Select atleast 1 deductions');
                    Blockloaderhide();
                    return;
                }
                else {
                    $("[id*=hdnvids4Chl]").val(vsid);
                }
                ChlMode = 'Add';
                RecMode = 'Edit';
                //$("[id*=DTAmt]").html(totcamt);

                $("[id*=dvchlded]").show();

                $('#modal_Addchallan').modal('show');
                ClearChallanControls();
                $("[id*=lblchlDTAmt]").html('0.00');
                $("[id*=lblchlDTAmt]").html(totcamt);
                Blockloaderhide();
            });

            ////// Remove Voucher from Challan
            $("[id*=btnRmChlnMap]").click(function () {

                var msg = '';

                msg = 'Remove deductions from Challan?';


                var notice = new PNotify({
                    title: 'Confirmation',
                    text: '<p>' + msg + '</p>',
                    hide: false,
                    type: 'warning',
                    confirm: {
                        confirm: true,
                        buttons: [
                            {
                                text: 'Yes',
                                addClass: 'btn btn-sm btn-primary'
                            },
                            {
                                addClass: 'btn btn-sm btn-link'
                            }
                        ]
                    },
                    buttons: {
                        closer: false,
                        sticker: false
                    }
                })

                // On confirm
                notice.get().on('pnotify.confirm', function () {
                    RemoveVoucher4rmChallan();
                })

                // On cancel
                notice.get().on('pnotify.cancel', function () {

                });
                event.stopPropagation();

            });

            $("[id*=btnChlnUvid]").click(function () {
                Blockloadershow();
                var C = $("[id*=hdnChallanId]").val();
                var S = $("[id*=hdnvids4Chl]").val();
                var ca = $("[id*=CBalAmt]").html();
                var v = $("[id*=DTAmt]").html();
                if (parseFloat(ca) < parseFloat(v)) {
                    showDangerAlert('Challan amount is less than deduction amount');
                    return;
                }
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../TDS/BTStrp/handler/Voucher.asmx/Update_Challan",
                    data: '{ S: "' + S + '", C:"' + C + '"}',
                    dataType: "json",
                    success: function (msg) {

                        myList = jQuery.parseJSON(msg.d);
                        if (myList != null && myList.length > 0) {
                            showSuccessAlert('Challan updated success');
                            $("[id*=hdnvids4Chl]").val('');
                            $("[id*=hdnChallanId]").val('');
                            var p = $("[id*=ddlperpage]").val();
                            var UP = 1;
                            var mth = $("[id*=hndCurrmth]").val();
                            ModifyGrid(mth, 1, p, UP);
                        }
                        Blockloaderhide();
                    },
                    failure: function (response) {
                        Blockloaderhide();
                    },
                    error: function (response) {
                        Blockloaderhide();
                    }
                });
            });

            $("[id*=drpChallanType]").click(function () {
                CPaid = 'Click';
            });

            $("[id*=drpChallanType]").change(function () {
                if (CPaid == 'Click') {
                    var mth = $("[id*=hndCurrmth]").val();
                    var PageIndex = $("[id*=hdnPages]").val();
                    var ct = $("[id*=drpChallanType]").val();
                    CPaid = '';
                    p = $("[id*=ddlperpage]").val();
                    if (ChlMode == 'Edit') {
                        var Cid = $("[id*=hdnChallanId]").val();
                        VoucherGrid_Challan(0, 1, p, Cid);
                    }
                    else {
                        ModifyGrid(mth, PageIndex, p, ct);
                    }
                }
            });
        });



        function RemoveVoucher4rmChallan() {
            Blockloadershow();

            var f = $("[id*=ddlForm]").val();
            var vsid = '';

            $("input[name=chkEjob]:checked").each(function () {
                var row = $(this).closest("tr");
                var vid = $(this).val();
                vsid = vid + '^' + vsid;
            });

            if (vsid == '') {
                showDangerAlert('Select atleast 1 deductions');
                Blockloaderhide();
                return;
            }


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/Voucher.asmx/Remove_Vids_Challan",
                data: '{ S: "' + vsid + '"}',
                dataType: "json",
                success: function (msg) {
                    var myList = '';
                    myList = jQuery.parseJSON(msg.d);
                    if (myList != null && myList.length > 0) {
                        showSuccessAlert('Challan removed from deduction');
                        $("[id*=hdnvids4Chl]").val('');
                        $("[id*=hdnChallanId]").val('');
                        var p = $("[id*=ddlperpage]").val();
                        var UP = 0;
                        var mth = $("[id*=hndCurrmth]").val();
                        ModifyGrid(mth, 1, p, UP);
                    }
                    Blockloaderhide();
                },
                failure: function (response) {
                    Blockloaderhide();
                },
                error: function (response) {
                    Blockloaderhide();
                }
            });
        }



        function validateDates() {
            var did = $("[id*=hdnDedId]").val();
            var fn = $("[id*=hdnConnString]").val();
            var fy = fn.split('_');
            var st = '04/01/' + fy[0];
            var ed = '03/31/20' + fy[1];
            var vd = new Date;
            var s = new Date;
            var e = new Date;
            var d = $("[id*=txt_VoucherDate]").val();
            var dt = d.split('-');
            d = dt[1] + '/' + dt[2] + '/' + dt[0];

            vd = moment(d);
            s = moment(st);
            e = moment(ed);
            if (moment(vd) < moment(s)) {
                $("[id*=txt_VoucherDate]").val('');
                showInfoAlert('Voucher date cannot be outside the Financial year');
                return;
            }
            if (moment(vd) > moment(e)) {
                $("[id*=txt_VoucherDate]").val('');
                showInfoAlert('Voucher date cannot be outside the Financial year');
                return;
            }
            var qua = $("[id*=ddltype]").val();
            var q = qua.substring(1);
            if (q == 1) {
                if (dt[1] < 4 || dt[1] > 6) {
                    $("[id*=txt_VoucherDate]").val('');
                    showInfoAlert('Voucher date cannot be outside the Quarter');
                    return;
                }
            }
            else if (q == 2) {
                if (dt[1] < 7 || dt[1] > 9) {
                    $("[id*=txt_VoucherDate]").val('');
                    showInfoAlert('Voucher date cannot be outside the Quarter');
                    return;
                }
            }
            else if (q == 3) {
                if (dt[1] < 10 || dt[1] > 13) {
                    $("[id*=txt_VoucherDate]").val('');
                    showInfoAlert('Voucher date cannot be outside the Quarter');
                    return;
                }
            }
            else if (q == 4) {
                if (dt[1] < 1 || dt[1] > 3) {
                    $("[id*=txt_VoucherDate]").val('');
                    showInfoAlert('Voucher date cannot be outside the Quarter');
                    return;
                }
            }

        }

        function GetAddedChallaninList(Cid) {
            var compid = $("[id*=hdnCompanyid]").val();
            var Conn = $("[id*=hdnConnString]").val();
            var Q = $("[id*=hdnQuater]").val();
            var F = $("[id*=hdnForm]").val();
            if (F == '0') { F = ''; }
            if (Q == '0') { Q = ''; }
            Blockloadershow();
            //Ajax start
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/Voucher.asmx/onLoad",
                data: '{compid:' + compid + ', Conn:"' + Conn + '", F: "' + F + '", Q: "' + Q + '"}',
                dataType: "json",
                success: function (msg) {
                    main_obj = jQuery.parseJSON(msg.d);
                    main_obj = main_obj[0];
                    var challans = main_obj.Challan;
                    FillChallanTable(challans);
                    $("[id*=ddlChallan]").empty();
                    var opt = new Option('--Select--', 0, true, true);
                    $("[id*=ddlChallan]").append(opt);//.trigger('change');

                    for (var i = 0; i < challans.length; i++) {
                        $("[id*=ddlChallan]").append("<option value='" + challans[i].ChallanID + "'>" + challans[i].ChallanNo + "</option>");
                    }

                    Blockloaderhide();
                },
                failure: function (response) {
                    showDangerAlert("Error");
                    Blockloaderhide();
                },
                error: function (response) {
                    showDangerAlert("Error");
                    Blockloaderhide();
                }
            });
        }

        function AmountPaidKeyUp() {
            CalculateAmounts('txtAmtPd');
            setNumericFormat($(this));
        }

        function FillBSRCodes() {
            //Ajax start
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/Deductee.asmx/GetBSRCodes",
                dataType: "json",
                success: function (msg) {
                    var outputBSRCodes = '';
                    outputBSRCodes = jQuery.parseJSON(msg.d);

                    if (outputBSRCodes != null && outputBSRCodes.length > 0) {
                        $("[id*=ddl_BSRCodes]").empty();
                        $("[id*=ddl_BSRCodes]").append("<option value='0'>--Select BSR Codes--</option>");
                        for (var i = 0; i < outputBSRCodes.length; i++) {
                            $("[id*=ddl_BSRCodes]").append("<option value='" + outputBSRCodes[i].BankId + "'>" + outputBSRCodes[i].BSRCode + "</option>");
                        }
                        $("[id*=ddl_ChallanBSRCodes]").empty();
                        $("[id*=ddl_ChallanBSRCodes]").append("<option value='0'>--Select BSR Codes--</option>");
                        for (var i = 0; i < outputBSRCodes.length; i++) {
                            $("[id*=ddl_ChallanBSRCodes]").append("<option value='" + outputBSRCodes[i].BankId + "'>" + outputBSRCodes[i].BSRCode + "</option>");
                        }
                    }
                    Blockloaderhide();
                },
                failure: function (response) {
                    showDangerAlert("Error");
                    Blockloaderhide();
                },
                error: function (response) {
                    showDangerAlert("Error");
                    Blockloaderhide();
                }
            });
        }

        function ClearChallanControls() {
            $("[id*=txtBankChinNo]").val('');
            $("[id*=ddl_BSRCodes]").val('0');
            $("[id*=ddl_BSRCodes]").trigger('change');
            $("[id*=txtChlTDS]").val('0.00');
            $("[id*=txtChSur]").val('0.00');
            $("[id*=txtChlCess]").val('0.00');
            $("[id*=txtChInt]").val('0.00');
            $("[id*=txtChlOth]").val('0.00');
            $("[id*=txtChTotal]").val('0.00');
            $("[id*=ddlChallan]").val('0');
            $("[id*=ddlChallan]").trigger('change');
            $("[id*=ddl_ChallanBSRCodes]").val('0');
            $("[id*=ddl_ChallanBSRCodes]").trigger('change');
            $("[id*=txtChallaDt]").val('0.00');
            $("[id*=txtChallanTdsNC]").val('0.00');
            $("[id*=txtChallanDedAmt]").val('0.00');
            $("[id*=txtChallanDiffAmt]").val('0.00');
        }

        function CalculateAmounts(modifiedField) {
            var txtAmtPd = $('[id*=txtAmtPd]').val();
            if (isNaN(parseFloat(txtAmtPd))) {
                txtAmtPd = "0.00";
                $('[id*=txtAmtPd]').val(txtAmtPd);
            }

            //////////////rate1 get
            var txtTDSRt = $('[id*=txtTDSRt]').val();
            if (isNaN(parseFloat(txtTDSRt))) {
                txtTDSRt = "0.00";
                $('[id*=txtTDSRt]').val(txtTDSRt);
            }


            //////////////amount 1 get
            var txtIncome = 0.00;

            if (modifiedField != "txtIncome") {
                txtIncome = txtAmtPd * (txtTDSRt / 100);
                txtIncome = Math.round(parseFloat(txtIncome));
                if (isNaN(parseFloat(txtIncome))) {
                    txtIncome = "0.00";
                }
                txtIncome = txtIncome + '.00';
                $('[id*=txtIncome]').val(txtIncome);
            }
            else {
                txtIncome = $('[id*=txtIncome]').val();
            }

            ///////////////amount 2 set
            /// Surcharge
            var txtsurc = $('[id*=txtsurc]').val();
            if (isNaN(parseFloat(txtsurc))) {
                txtsurc = "0.00";
                $('[id*=txtsurc]').val(txtsurc);
            }

            ///////////////////net amount 2 get 
            var txt_NetAmount2 = 0;
            txt_NetAmount2 = Math.round(parseFloat(txtIncome) + parseFloat(txtsurc));

            ///////////////amount 3 set
            //// Cess
            var txtCess = $('[id*=txtCess]').val();
            if (isNaN(parseFloat(txtCess))) {
                txtCess = "0.00";
                $('[id*=txtCess]').val(txtCess);
            }

            ////////////////set netamount 3
            //$('[id*=txt_NetAmount3]').html(Math.round(parseFloat(txtCess) + parseFloat(txt_NetAmount2)));

            ////////////////get netamount 3
            var txt_NetAmount3 = 0;
            txt_NetAmount3 = Math.round(parseFloat(txtCess) + parseFloat(txt_NetAmount2));
            txt_NetAmount3 = Math.round(parseFloat(txt_NetAmount3));
            txt_NetAmount3 = txt_NetAmount3 + '.00';
            $('[id*=txtTotal]').val(txt_NetAmount3);
            $('[id*=hdntxtTotal]').val(Math.round(parseFloat(txt_NetAmount3)));

            var deductedAmnt = 0;
            //var textboxValue = $('[id*=txtChallanDedAmt]').val();
            //deductedAmnt = $('[id*=txtChallanDedAmt]').val() - txt_NetAmount3;
            //$('[id*=txtChallanDedAmt]').val(Math.round(parseFloat(deductedAmnt)));
            $('[id*=hdnNewVoucherTotal]').val(Math.round(txt_NetAmount3));

            /////////////////// Checking if challan is selected then voucher amt - challan amt
            var camt = $("[id*=hdnChlTDSAmt]").val();
            var cid = $("[id*=hdnChallanId]").val();
            var vamt = $("[id*=hdnVAmt]").val();

            if (cid == '' || cid == undefined) {
                cid = 0;
            }
            if (cid > 0) {
                camt = camt - vamt;
                camt = camt + txt_NetAmount3;
                if (camt < 0) {
                    $('[id*=txtIncome]').val(0);
                    $('[id*=txtsurc]').val(0);
                    $('[id*=txtCess]').val(0);
                    $('[id*=txtTotal]').val(0);
                    $('[id*=hdntxtTotal]').val(0);
                    $('[id*=hdnNewVoucherTotal]').val(0);
                    showPrimaryAlert('Voucher Total cannot be more than Challan TDS Amount');
                }
            }
            else {
                camt = camt + txt_NetAmount3;
                if (camt < 0) {
                    $('[id*=txtIncome]').val(0);
                    $('[id*=txtsurc]').val(0);
                    $('[id*=txtCess]').val(0);
                    $('[id*=txtTotal]').val(0);
                    $('[id*=hdntxtTotal]').val(0);
                    $('[id*=hdnNewVoucherTotal]').val(0);
                    showPrimaryAlert('Voucher Total cannot be more than Challan TDS Amount');
                }

            }

        }

        function IsValidPanNumber(panNumber) {
            const regex = /[A-Z]{5}[0-9]{4}[A-Z]{1}/;
            if (panNumber.length != 10) { return false; }
            if (regex.test(panNumber) == false) { return false }
            const charArray = panNumber.split('');
            var IsValidPan = true;
            charArray.forEach((CharOrNumber, index) => {
                if (index < 5) {
                    if (IsValidLatter(CharOrNumber) == false) {
                        IsValidPan = false;
                    }
                } else if (index > 4 && index < 9) {
                    if (IsValidNumaricValue(CharOrNumber) == false) {
                        IsValidPan = false;
                    }
                } else if (index == 9) {
                    if (IsValidLatter(CharOrNumber) == false) {
                        IsValidPan = false;
                    }
                }
            });
            return IsValidPan;
        }

        function IsValidNumaricValue(String) {
            let numberRegex = /^[+-]?\d+(\.\d+)?([eE][+-]?\d+)?$/;
            if (numberRegex.test(String)) {
                return true;
            } else {
                return false;
            }
        }

        function IsValidLatter(ch) {
            return /^[A-Z]$/i.test(ch);
        }

        function check_height() {
            var h = document.getElementById("cr_chln");
            h = h.clientHeight;
            if (h < 300) {
                document.getElementById("cr_chln").style.height = "320px";
                document.getElementById("cr_Vou").style.height = "320px";
            }
        }

        function txtAmtPd_Keyup(event) {
            if (event.keyCode != '9') {
                if (isNaN(parseFloat($("[id*=txtAmtPd]").val()))) {
                    $("[id*=txtAmtPd]").val('');
                } else {
                    $("[id*=txtAmtPd]").val(parseFloat($("[id*=txtAmtPd]").val()).toString());
                }
                checkVoucherDate();
            }
            //if (event.keyCode == '9') {
            //    setNumericFormat($(this));
            //}
        }

        function txtTDSRt_Keyup(event) {
            if (event.keyCode != '9') {
                if (isNaN(parseFloat($("[id*=txtAmtPd]").val()))) {
                    $("[id*=txtAmtPd]").val('');
                } else {
                    $("[id*=txtAmtPd]").val(parseFloat($("[id*=txtAmtPd]").val()).toString());
                }
                checkVoucherDate();
            }
            //if (event.keyCode == '9') {
            //    setNumericFormat($(this));
            //}
        }

        function txt_Sur_Keyup(event) {
            if (event.keyCode != '9') {
                //if (isNaN(parseFloat($("[id*=txt_NetAmount2]").val()))) {
                //    $("[id*=txt_NetAmount2]").val('');
                //} else {
                //    $("[id*=txt_NetAmount2]").val(parseFloat($("[id*=txt_NetAmount2]").val()).toString());
                //}
                checkVoucherDate();
            }

        }

        function txt_Cess_Keyup(event) {
            if (event.keyCode != '9') {
                if (isNaN(parseFloat($("[id*=txt_NetAmount3]").val()))) {
                    $("[id*=txt_NetAmount3]").val('');
                } else {
                    $("[id*=txt_NetAmount3]").val(parseFloat($("[id*=txt_NetAmount3]").val()).toString());
                }
                checkVoucherDate();
            }
        }

        function pageLoad() {
            $(':text').bind('keydown', function (e) { //on keydown for all textboxes
                if (e.keyCode == 13) //if this is enter key
                    e.preventDefault();
            });
        }

        function checkVoucherDate() {
            var date = $('[id*=txt_VoucherDate]').val();
            if (date != "") {
                CalCualteNetAmount();
            }
            else {
                showInfoAlert("Please Select Voucher Date !");
            }
        }

        function checksectionwithcal() {
            var date = $('[id*=txt_VoucherDate]').val();
            if (date != "") {
                CalCualteNetAmount();
            }
            else {
                $('[id*=txtAmtPd]').val(0);
                showInfoAlert("Please Select Voucher Date !");
            }
        }

        function CalCualteNetAmount() {

            //////////////net amount get
            /// Voucher Amt
            var txtAmtPd = $('[id*=txtAmtPd]').val();
            if (isNaN(parseFloat(txtAmtPd))) {
                txtAmtPd = "0.00";
                $('[id*=txtAmtPd]').val('0.00');
            }

            //////////////rate1 get
            var txtTDSRt = $('[id*=txtTDSRt]').val();
            if (isNaN(parseFloat(txtTDSRt))) {
                txtTDSRt = "0";
                $('[id*=txtTDSRt]').val(0);
            }
            ///////////////amount 1 set
            //// Tds Amt
            if (parseFloat(txtTDSRt) > 0) {
                var total = (parseFloat(txtAmtPd) * parseFloat(txtTDSRt)) / 100;
                $('[id*=txtIncome]').val(Math.round(total));
            }
            else {
                $('[id*=txtIncome]').val('0.00');
            }

            //////////////amount 1 get
            var txtIncome = $('[id*=txtIncome]').val();
            if (isNaN(parseFloat(txtIncome))) {
                txtIncome = "0.00";
            }

            ///////////////amount 2 set
            /// Surcharge
            var txtsurc = $('[id*=txtsurc]').val();
            if (isNaN(parseFloat(txtsurc))) {
                txtsurc = "0.00";
                $('[id*=txtsurc]').val('0.00');
            }

            /////////////////net amount2 set
            //$('[id*=txt_NetAmount2]').html(Math.round(parseFloat(txtIncome) + parseFloat(txtsurc)));

            /////////////////net amount 2 get 
            //var txt_NetAmount2 = $('[id*=txt_NetAmount2]').html();

            ///////////////amount 3 set
            //// Cess
            var txtCess = $('[id*=txtCess]').val();
            if (isNaN(parseFloat(txtCess))) {
                txtCess = "0.00";
                $('[id*=txtCess]').val('0.00');
            }

            //////////////set netamount 3
            var txt_NetAmt = parseFloat(txtIncome) + parseFloat(txtsurc) + parseFloat(txtCess);

            //////////////get netamount 3
            //var txt_NetAmount3 = $('[id*=txt_NetAmount3]').html();
            $('[id*=txtTotal]').val(Math.round(parseFloat(txt_NetAmt)));
            $('[id*=hdntxtTotal]').val(Math.round(parseFloat(txt_NetAmt)));
        }

        function getNatureSubId() {
            Blockloadershow();
            var n = $("[id*=ddl_Nature]").val();
            var t = $("[id*=ddl_Type]").val();
            if (n == undefined) {
                Blockloaderhide();
                return;
            }
            if (t == undefined) {
                Blockloaderhide();
                return;
            }

            if (n == '0') {
                Blockloaderhide();
                return;
            }
            if (t == '0') {
                Blockloaderhide();
                return;
            }
            //Ajax start
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/Ws_PanNo.asmx/Get_NatureSubId",
                data: '{n:' + n + ',t:"' + t + '"}',
                dataType: "json",
                success: function (msg) {
                    var myList = '';
                    myList = jQuery.parseJSON(msg.d);
                    myList = myList[0];

                    if (msg.d.length > 0 && myList != undefined && myList != null) {
                        var Sec = myList.Lst_Sec;
                        $('[id*=hdnNatureSubID]').val(myList.Nature_Sub_Id);
                        var did = $("[id*=hdnDedId]").val();
                        //var did = $("[id*=drpded]").val();
                        //var x = $("[id*=hdnSection]").val();
                        //if (x == '') {
                        $("[id*=ddl_Reasons]").empty();
                        $("[id*=ddl_Reasons]").append("<option value='0'>--Select Reasons--</option>");
                        for (var i = 0; i < myList.Lst_Sec.length; i++) {
                            $("[id*=ddl_Reasons]").append("<option value='" + Sec[i].Section_Id + "'>" + Sec[i].Section + "</option>");
                        }
                        if (editReasonValue != null && editReasonValue != '') {
                            $("[id*=ddl_Reasons]").val(editReasonValue);
                            $("[id*=ddl_Reasons]").trigger('change');
                        }
                        else {
                            $("[id*=ddl_Reasons]").val('Presc.Rt.');
                            $("[id*=ddl_Reasons]").trigger('change');
                        }
                        //if ($("[id*=hdnNatureSubID]").val() != '0') {
                        //    $("[id*=ddl_Reasons]").val($("[id*=hdnNatureSubID]").val());
                        //    $("[id*=ddl_Reasons]").trigger('change');

                        //}
                        //$("[id*=hdnSection]").val('1');
                        //}
                        if (did != '' && did != undefined && did != '0') {
                            var rt = $("[id*=txtTDSRt]").val();
                            //if (rt == 0 || rt == '' ) {
                            GetRate();
                            //}
                        }
                        var fy = $("[id*=hdnConnString]").val();
                        var dt = $("[id*=txt_VoucherDate]").val();

                        //if (n == 18 && fy == '2021_22' && dt >= '17/09/2021')
                        //{
                        //    $("[id*=ddl_Reasons]").val('No Tax on A/c of pmt under sec 197A Z');

                        //}

                    }
                    Blockloaderhide();
                },
                failure: function (response) {
                    showDangerAlert("Error");
                    Blockloaderhide();
                },
                error: function (response) {
                    showDangerAlert("Error");
                    Blockloaderhide();
                }
            });
        }

 
        function AllEdit_Show(i) {
            $("[id*=dvChMfy]").hide();
            $("[id*=drpPerPage]").show();
            $("[id*=btnCancel]").show();
            $("[id*=btnChlCancel]").hide();
            $("[id*=drpCPerPage]").hide();
            $("[id*=btnAdd]").hide();
            var row = i.closest("tr");
            var mth = row.find("input[name=hdnMth]").val();
            $("[id*=hdnPages]").val(1);
            $("[id*=hndCurrmth]").val(mth);
            $("[id*=drpChallanType]").val(0);
            $("[id*=drpChallanType]").trigger('change');
            UP = 0;
            //NT = $("[id*=ddlSearchNature]").val();
            if (NT == null) {
                NT = '';
            }
            p = $("[id*=ddlperpage]").val();
            $("[id*=ddlForm]").attr("disabled", true);
            $("[id*=ddltype]").attr("disabled", true);
            //$("[id*=btnChlnMap]").attr("disabled", true);
            //$("[id*=btnRmChlnMap]").attr("disabled", false);

            ModifyGrid(mth, 1, p, UP);
        }


        function Edit_Show(i) {
            $("[id*=dvChMfy]").hide();
            $("[id*=drpPerPage]").show();
            $("[id*=btnCancel]").show();
            $("[id*=btnChlCancel]").hide();
            $("[id*=drpCPerPage]").hide();
            $("[id*=btnAdd]").hide();
            var row = i.closest("tr");
            var mth = row.find("input[name=hdnMth]").val();
            $("[id*=hdnPages]").val(1);
            $("[id*=hndCurrmth]").val(mth);
            $("[id*=drpChallanType]").val(1);
            $("[id*=drpChallanType]").trigger('change');
            UP = 0;
            //NT = $("[id*=ddlSearchNature]").val();
            if (NT == null) {
                NT = '';
            }
            p = $("[id*=ddlperpage]").val();
            $("[id*=ddlForm]").attr("disabled", true);
            $("[id*=ddltype]").attr("disabled", true);
            //$("[id*=btnChlnMap]").attr("disabled", true);
            //$("[id*=btnRmChlnMap]").attr("disabled", false);

            ModifyGrid(mth, 1, p, UP);
        }

        function Edit_ShowUP(i) {
            $("[id*=dvChMfy]").hide();
            $("[id*=drpPerPage]").show();
            $("[id*=btnCancel]").show();
            $("[id*=btnChlCancel]").hide();
            $("[id*=drpCPerPage]").hide();
            $("[id*=btnAdd]").hide();
            var row = i.closest("tr");
            var mth = row.find("input[name=hdnMth]").val();
            $("[id*=hdnPages]").val(1);
            $("[id*=hndCurrmth]").val(mth);
            $("[id*=drpChallanType]").val(2);
            $("[id*=drpChallanType]").trigger('change');
            UP = 1;
            //NT = $("[id*=ddlSearchNature]").val();
            if (NT == null) {
                NT = '';
            }
            p = $("[id*=ddlperpage]").val();
            $("[id*=ddlForm]").attr("disabled", true);
            $("[id*=ddltype]").attr("disabled", true);
            //$("[id*=btnChlnMap]").attr("disabled", false);
            //$("[id*=btnRmChlnMap]").attr("disabled", true);
            $("[id*=dvNewAddChl]").show();
            ModifyGrid(mth, 1, p, UP);

        }

        function View_Show(i) {
            var row = i.closest("tr");
            var Cid = row.find("input[name=hdnCid]").val();
            var compid = $("[id*=hdnCompanyid]").val();
            p = $("[id*=ddlperpage]").val();
            $("[id*=lblCAmtpd]").html(row.find("td").eq(5).text());
            $("[id*=lblCno]").html(row.find("td").eq(2).text());
            $("[id*=drpChallanType]").val(1);
            $("[id*=drpChallanType]").trigger('change');
            //$("[id*=dvNewAddChl]").hide();
            //$("[id*=btnChlnMap]").hide();



            var vcnt = row.find("td").eq(1).text();
            if (vcnt == 0) {
                showWarningAlert("No deduction against this challan");
            }
            else {
                $("[id*=spnPG]").html('Challan Entries');
                $("[id*=drpChallanType]").attr("disabled", true);
                VoucherGrid_Challan(0, 1, p, Cid);
                ChlMode = 'Edit';

                var b = row.find("input[name=hdncBsr]").val();
                var cdt = row.find("td").eq(0).text();
                var I = row.find("input[name=hdncInt]").val();
                var cs = row.find("input[name=hdncCess]").val();
                var su = row.find("input[name=hdncSur]").val();
                var Ot = row.find("input[name=hdncOth]").val();
                var cno = row.find("td").eq(3).text();
                var Ctds = row.find("td").eq(5).text();
                var Ctot = row.find("td").eq(8).text();
                var Cdiff = row.find("td").eq(7).text();
                $("[id*=hdnChallanId]").val(Cid);
                $("[id*=lblMfyCNo]").html(cno);
                $("[id*=lblMfyChlDt]").html(cdt);
                $("[id*=lblMfyChlBSRNC]").html(b);
                $("[id*=lblCTDSMfy]").html(Ctds);
                $("[id*=lblCSurMfy]").html(su);
                $("[id*=lblCCessMfy]").html(cs);
                $("[id*=lblCIntMfy]").html(I);
                $("[id*=lblCOthMfy]").html(Ot);
                $("[id*=lblCTAmtMfy]").html(Ctot);
                $("[id*=lblCDiffMfy]").html(Cdiff);
                $("[id*=dvChMfy]").show();
                //var damt = parseFloat(Camt) - parseFloat(CBal);
                //damt = damt + '.00';
                //$("[id*=lblDAmt]").html(damt);
                //$("[id*=lblBal]").html(CBal);
            }



        }

        function VoucherGrid_Challan(mth, pageIndex, Pagesize, Cid) {

            Blockloadershow();
            var Conn = $("[id*=hdnConnString]").val();
            var c = $("[id*=hdnCompanyid]").val();

            var RecordCount = 0;

            var Chid = parseFloat(Cid);
            /*            $("[id*=dvAddVoucher]").hide();*/
            var n = NT;
            var F = $("[id*=ddlForm]").val();
            var Q = $("[id*=ddltype]").val();
            if (Chid == undefined) {
                Chid = 0;
            }
            document.getElementById("dvTblVMfy").classList.remove("col-md-12");
            document.getElementById("dvTblVMfy").classList.add("col-md-9");
            $("[id*=dgVoucherModify] tr").empty();
            var fltr = $("[id*=hdnForm]").val();
            $("[id*=divMisMatch]").hide();
            $("[id*=dvFltr]").show();

            $("[id*=divModify]").show();
            $("[id*=dv_VoucherModify]").show();
            $("[id*=dvdelete]").show();
            $("[id*=dvLnk]").hide();
            $("[id*=dvChln]").hide();
            var chlnk = $("[id*=hdnLnk]").val();
            if (chlnk != '' || chlnk != 0) {
                $("[id*=dvChln]").show();
                $("[id*=dvdelete]").hide();
                $("[id*=dvLnk]").show();
            }
            $("[id*=dgVoucherModify]").show();
            $("[id*=btnProcess]").hide();
            $("[id*=btndwnd]").hide();
            $("[id*=btnChkError]").hide();
            $("[id*=tdSearch]").hide();
            if (ChlMode == '') {
                $("[id*=btnCancel]").show();
                $("[id*=btnChlCancel]").hide();
                $("[id*=drpCPerPage]").hide();
            }

            ////    $('[id*=btnNAddMapChl]').attr("disabled", true);     ******
            ////    $('[id*=btnRmChlnMap]').attr("disabled", false);     ******
            ////    $('[id*=btnvoucherecord]').attr("disabled", true); ******
            ////    $('[id*=btnChlnMap]').attr("disabled", true);   ******

            $('[id*=btnNAddMapChl]').hide();
            $('[id*=btnRmChlnMap]').show();
            $('[id*=btnvoucherecord]').hide();
            $('[id*=btnChlnMap]').hide();

            Mis = '';

            //Ajax start
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/Voucher.asmx/Challan_VoucherGrd",
                data: '{c:' + c + ', mth:' + mth + ',pI:' + pageIndex + ',pS:' + Pagesize + ', Conn:"' + Conn + '", Chid:' + Chid + ',  n:"' + n + '", fltr:"' + fltr + '",  F:"' + F + '",Q:"' + Q + '"}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);

                    var tbl = '';
                    $("[id*=txtAmtpd]").val(0.00);
                    $("[id*=txtTDS]").val(0.00);

                    $("[id*=dgVoucherModify] tr").empty();
                    tbl = tbl + "<thead>";
                    tbl = tbl + "<tr>";
                    tbl = tbl + "<th  style='text-align: center;' class='labelChange'>Sr No</th>";
                    tbl = tbl + "<th  style='text-align: center;' class='labelChange'>Date</th>";
                    tbl = tbl + "<th  class='labelChange' style='text-align: left;'>Deductee</th>";
                    tbl = tbl + "<th  class='labelChange' style='text-align: left;'>PAN</th>";
                    tbl = tbl + "<th  class='labelChange' style='text-align: left;'>PANVerified</th>";
                    tbl = tbl + "<th  class='labelChange' style='text-align: left;'>Rate</th>";
                    tbl = tbl + "<th  style='text-align: center;' class='labelChange'>Section</th>";
                    tbl = tbl + "<th  style='text-align: right;' class='labelChange'>Amt Paid</th>";
                    tbl = tbl + "<th  style='text-align: right;' class='labelChange'>TDS</th>";
                    tbl = tbl + "<th class='labelChange' style='text-align: center;' >Chln No</th>";
                    tbl = tbl + "<th class='labelChange' style='text-align: center;' >Chln Paid</th>";
                    //tbl = tbl + "<th >Edit</th>";
                    tbl = tbl + "<th  class='labelChange' style='text-align: center;'> <input type='checkbox' id='chkAll' name='chkAll' onclick='chkAllselect($(this))'></td></th>";
                    tbl = tbl + "</tr>";
                    tbl = tbl + "</thead>";
                    tbl = tbl + "<tbody>";
                    if (myList.length > 0) {
                        var amtlist = myList[0].LTDSgrid;
                        var j = '';
                        for (var i = 0; i < myList.length; i++) {

                            tbl = tbl + "<tr>";
                            tbl = tbl + "<td class='labelChange' style='width:5%; text-align: center; '>" + myList[i].SrNo + "</td>";
                            tbl = tbl + "<td style='text-align: center;' class='labelChange'>" + myList[i].PDate + "<input type='hidden' id='hdndid' value='" + myList[i].did + "' name='hdndid'></td>";
                            tbl = tbl + "<td style='text-align: left;' class='labelChange'><a href='#'  onclick='Edit_Rec($(this),0)' > " + myList[i].DName + "</a><input type='hidden' id='hdnvid' value='" + myList[i].vid + "' name='hdnvid'></td>";
                            tbl = tbl + "<td style='text-align: left;' class='labelChange'>" + myList[i].PanNO + "</td>";
                            if (myList[i].PanVer == 'Valid PAN') {
                                tbl = tbl + "<td style='text-align: center;' class='labelChange'><i class='icon-checkmark2 mr-3 icon-2x' style='color: green;' id='imgCPaid' name='imgCPaid'></td>";
                            }
                            else {
                                tbl = tbl + "<td style='text-align: center;' class='labelChange'><i class='icon-cross3 mr-3 icon-2x' style='color: red;' id='imgCNot' name='imgCNot'></td>";
                            }
                            tbl = tbl + "<td style='text-align: left;' class='labelChange'>" + myList[i].TdsRate + "</td>";
                            tbl = tbl + "<td style='text-align: center;' class='labelChange'>" + myList[i].sec + "</td>";
                            tbl = tbl + "<td style='text-align: right;' class='labelChange'>" + myList[i].AmtPaid + ".00</td>";
                            tbl = tbl + "<td style='text-align: right;' class='labelChange'>" + myList[i].TdsAmt + ".00</td>";
                            tbl = tbl + "<td style='text-align: center;' class='labelChange'>" + myList[i].BnkChl + "</td>";
                            if (parseFloat(myList[i].CPaid) > 0) {
                                tbl = tbl + "<td style='text-align: center;' class='labelChange'><i class='icon-checkmark2 mr-3 icon-2x' style='color: green;' id='imgCPaid' name='imgCPaid'><input type='hidden' id='hdnCid' value='" + myList[i].CPaid + "' name='hdnCid'></td>";
                            }
                            else {
                                tbl = tbl + "<td style='text-align: center;' class='labelChange'><i class='icon-cross3 mr-3 icon-2x' style='color: red;' id='imgCNot' name='imgCNot'><input type='hidden' id='hdnCid' value='" + myList[i].CPaid + "' name='hdnCid'></td>";
                            }
                            tbl = tbl + "<td style='text-align: center;' class='labelChange'><input type='checkbox' id='chkEjob' name='chkEjob' value='" + myList[i].vid + "' ></td></tr>"
                        };
                        tbl = tbl + "</tbody>";
                        $("[id*=dgVoucherModify]").append(tbl);
                        $("[id*=txtAmtpd]").val(amtlist[0].Amt);
                        $("[id*=txtTDS]").val(amtlist[0].TDS);

                        if (parseFloat(myList[0].Totalcount) > 0) {
                            RecordCount = parseFloat(myList[0].Totalcount);

                        }
                        $("[id*=dv_VoucherModify]").show();
                        $("[id*=tdSearch]").hide();
                        $("[id*=btnCancel]").show();
                        $("[id*=btnChlCancel]").hide();
                        $("[id*=drpCPerPage]").hide();
                        Pager(RecordCount, mth, UP);

                    }

                    else {
                        tbl = tbl + "<tr>";
                        tbl = tbl + "<td  class='padding5'></td>";
                        tbl = tbl + "<td  class='padding5'></td>";
                        tbl = tbl + "<td  class='padding5'>No Record Found !!!</td>";
                        tbl = tbl + "<td  class='padding5'></td>";
                        tbl = tbl + "<td  class='padding5'></td>";
                        tbl = tbl + "<td  class='padding5'></td>";
                        tbl = tbl + "<td  class='padding5'></td>";
                        tbl = tbl + "<td  class='padding5'></td>";
                        tbl = tbl + "<td  class='padding5'></td>";
                        tbl = tbl + "<td  class='padding5'></td>";
                        tbl = tbl + "<td  class='padding5'></td>";
                        tbl = tbl + "<td  class='padding5'></td>";
                        tbl = tbl + "</tr>";
                        $("[id*=dgVoucherModify]").append(tbl);
                        Pager(0, mth, UP);
                    }

                    var x = $("[id*=hdnDEdit]").val();

                    if (x == '') {
                        // $("[id*=ddlSearchDeducteeName]").empty();
                        //var first = $("[id*=ddl_DeducteeName]");
                        //var second = $("[id*=ddlSearchDeducteeName]");
                        //var options = first[0].innerHTML;
                        //var options = second[0].innerHTML + options;
                        //second[0].innerHTML = options;

                        //$("[id*=ddlSearchDeducteeName]").append("<option value=''>--Select Deductee--</option>");
                        //for (var i = 0; i < myDrps.length; i++) {

                        //    $("[id*=ddlSearchDeducteeName]").append("<option value='" + myDrps[i].deducteeid + "'>" + myDrps[i].Dname + "</option>");

                        //}
                        $("[id*=hdnDEdit]").val('1');
                    }

                    Blockloaderhide();
                },
                failure: function (response) {

                },
                error: function (response) {

                }
            });
        }

        function onLoad() {
            Blockloadershow();
            var compid = $("[id*=hdnCompanyid]").val();
            var Conn = $("[id*=hdnConnString]").val();
            var Q = $("[id*=hdnQuater]").val();
            var F = $("[id*=hdnForm]").val();
            if (F == '0') { F = ''; }
            if (Q == '0') { Q = ''; }
            //Ajax start
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/Voucher.asmx/onLoad",
                data: '{compid:' + compid + ', Conn:"' + Conn + '", F: "' + F + '", Q: "' + Q + '"}',
                dataType: "json",
                success: function (msg) {
                    main_obj = jQuery.parseJSON(msg.d);
                    main_obj = main_obj[0];
                    var myDrps = main_obj.Deductee;
                    var Grd = main_obj.Grd;
                    var Chl = main_obj.Challan;

                    var x = $("[id*=hdnDSrch]").val();

                    if (x == '') {
                        $("[id*=hdnDSrch]").val('1');
                        $("[id*=hdnDEdit]").val('1');
                    }

                    ////// Checking for MisMatch vouchers
                    if (Mis == '') {
                        $("[id*=hdnMis]").val('');
                        var tbl = '';
                        $("[id*=dgVoucherEntries] tr").empty();
                        //$("[id*=dgVoucherEntries] thead").empty();
                        tbl = tbl + "<thead>"
                        tbl = tbl + "<tr style='background:#dcdcdc'>";
                        tbl = tbl + "<th class='labelChange' style='text-align: center; font - weight: bold;'>Month</th>";
                        tbl = tbl + "<th class='labelChange' style='text-align: center; font - weight: bold;' >Entries</th>";
                        tbl = tbl + "<th class='labelChange' style='text-align: center; font - weight: bold;' >Amount</th>";
                        tbl = tbl + "<th class='labelChange' style='text-align: center; font - weight: bold;'>TDS</th>";
                        tbl = tbl + "<th class='labelChange' style='text-align: center; font - weight: bold;' >Unpaid</th>";

                        tbl = tbl + "</tr>";
                        tbl = tbl + "</thead>";
                        tbl = tbl + "<tbody>";
                        if (Grd.length > 0) {
                            for (var i = 0; i < Grd.length; i++) {
                                tbl = tbl + "<tr>";
                                tbl = tbl + "<td class='labelChange' style='text-align:center; '><a href='#' onclick='AllEdit_Show($(this))'>" + Grd[i].mth + "</a><input type='hidden' id='hdnMth' value='" + Grd[i].mthno + "' name='hdnMth'></td>";
                                tbl = tbl + "<td class='labelChange' style='text-align:center; '><a href='#' onclick='Edit_Show($(this))'>" + Grd[i].Entries + "</a></td>";
                                tbl = tbl + "<td class='labelChange' style='text-align:right;'>" + Grd[i].Amt.toFixed(2) + "</td>";
                                tbl = tbl + "<td class='labelChange' style='text-align:right;'>" + Grd[i].Tds.toFixed(2) + "</td>";
                                tbl = tbl + "<td class='labelChange' style='text-align:center;' ><label id='lblup' ><a href='#' onclick='Edit_ShowUP($(this))'> " + Grd[i].Upaid + "</a></label></td></tr>";

                            };
                            tbl = tbl + "</tbody>";
                            //// Footer
                            tbl = tbl + "<tr>";
                            tbl = tbl + "<td class='labelChange' style='text-align:center; font-weight:bold;'>Total</td>";
                            tbl = tbl + "<td class='labelChange' style='text-align:center;'>" + Grd[0].Tent + "</td>";
                            tbl = tbl + "<td class='labelChange' style='text-align:right;' >" + Grd[0].TAmt.toFixed(2) + "</td>";
                            tbl = tbl + "<td class='labelChange' style='text-align:right;' >" + Grd[0].TTds.toFixed(2) + "</td>";
                            tbl = tbl + "<td class='labelChange' style='text-align:center; ' >" + Grd[0].Tup + "</td></tr>";

                            $("[id*=dgVoucherEntries]").append(tbl);
                        }
                        else {
                            tbl = tbl + "<tr>";
                            tbl = tbl + "<td ></td>";
                            tbl = tbl + "<td ></td>";
                            tbl = tbl + "<td style='font-weight:bold;'>No Record Found !!!</td>";
                            tbl = tbl + "<td ></td>";
                            tbl = tbl + "<td ></td>";
                            tbl = tbl + "</tr>";
                            $("[id*=dgVoucherEntries]").append(tbl);
                        }
                    }
                    else {
                        var M = $("[id*=hdnMis]").val();
                        M = M.split(',');
                        var f = M[1];
                        var q = M[2];
                        $("[id*=drpQua]").val(q);
                        $("[id*=drpForm]").val(f);
                        $("[id*=dv_VoucherModify]").show();
                        $("[id*=dgVoucherModify]").hide();
                        $("[id*=divMisMatch]").show();
                        $("[id*=divModify]").hide();
                        $("[id*=tdSearch]").hide();
                        $("[id*=Label1]").html('MisMatch Voucher Entries');
                        getNature_Branch_Drps();
                        MisMatch_Vouchers(q, f);
                    }

                    ///// Challan
                    FillChallanTable(Chl);
                    Fill_Challan_DropDowns();
                    Blockloaderhide();
                },
                failure: function (response) {

                },
                error: function (response) {

                }
            });
        }

        function FillChallanTable(challans) {

            var tbl = '';
            $("[id*=tblChallan] tr").empty();
            Blockloadershow();
            tbl = tbl + "<thead style='background-color:#dcdcdc;'>";
            tbl = tbl + "<tr style='background:#dcdcdc;'>";
            tbl = tbl + "<th class='labelChange' style='width:5%; text-align: center; font - weight: bold;' >Sr.</th>";
            tbl = tbl + "<th class='labelChange' style='width:5%; text-align: center; font - weight: bold;' >Vchr</th>";
            tbl = tbl + "<th class='labelChange' style='width:10%; text-align: center; font - weight: bold;' >Date</th>";
            tbl = tbl + "<th class='labelChange' style='width:10%; text-align: center; font - weight: bold;'>Chln No</th>";
            tbl = tbl + "<th class='labelChange' style='width:10%; text-align: center; font - weight: bold;'>Sec</th>";
            tbl = tbl + "<th class='labelChange' style='width:10%; text-align: center; font - weight: bold;' >TDS</th>";
            tbl = tbl + "<th class='labelChange' style='width:10%; text-align: center; font - weight: bold;' >Consumed</th>";
            tbl = tbl + "<th class='labelChange' style='width:10%; text-align: center; font - weight: bold;' >Diff</th>";
            tbl = tbl + "<th class='labelChange' style='width:10%; text-align: center; font - weight: bold;' >Total</th>";
            tbl = tbl + "<th class='labelChange' style='width:5%; text-align: center; font - weight: bold;' >Verify</th>";
            tbl = tbl + "<th class='labelChange' style='width:5%; text-align: center; font - weight: bold;' >Action</th>";

            tbl = tbl + "</tr>";
            tbl = tbl + "</thead>";
            tbl = tbl + "<tbody>";
            if (challans.length > 0) {
                for (var i = 0; i < challans.length; i++) {
                    tbl = tbl + "<tr onclick='View_Show($(this))' style='cursor: pointer;'>";
                    tbl = tbl + "<td class='labelChange' style='width:5%; text-align: center; '>" + (i + 1) + "</td>";
                    tbl = tbl + "<td class='labelChange' style='width:5%; text-align: center;'>" + challans[i].VouchersCount + "<input type='hidden' id='hdncdt' value='" + challans[i].CDate + "' name='hdncdt'></td>";
                    tbl = tbl + "<td class='labelChange' style='width:10%; text-align: center;' >" + challans[i].ChallanDate + "<input type='hidden' id='hdncOth' value='" + challans[i].Others + "' name='hdncOth'><input type='hidden' id='hdncTDS' value='" + challans[i].TDS + "' name='hdncTDS'><input type='hidden' id='hdnbnkid' value='" + challans[i].BankId + "' name='hdnbnkid'><input type='hidden' id='hdncBsr' value='" + challans[i].BSR + "' name='hdncBsr'></td>";
                    tbl = tbl + "<td class='labelChange' style='width:10%; text-align: center;' >" + challans[i].ChallanNo + "<input type='hidden' id='hdnCid' value='" + challans[i].ChallanID + "' name='hdnCid'></td>";
                    tbl = tbl + "<td class='labelChange' style='width:10%; text-align: center;'>" + challans[i].Sec + "<input type='hidden' id='hdncInt' value='" + challans[i].Interest + "' name='hdncInt'></td>";
                    tbl = tbl + "<td sclass='labelChange' style='width:10%; text-align: right;'>" + challans[i].TDS + ".00<input type='hidden' id='hdncCess' value='" + challans[i].Cess + "' name='hdncCess'><input type='hidden' id='hdncOth' value='" + challans[i].COth + "' name='hdncOth'></td>";
                    tbl = tbl + "<td class='labelChange' style='width:10%; text-align: right;'>" + challans[i].VTds + ".00<input type='hidden' id='hdncCess' value='" + challans[i].Cess + "' name='hdncCess'></td>";
                    //var d = parseFloat(challans[i].CAmount) - parseFloat(challans[i].VTds);
                    tbl = tbl + "<td class='labelChange' style='width:10%; text-align: right;'>" + challans[i].Difference + ".00<input type='hidden' id='hdncSur' value='" + challans[i].Sur + "' name='hdncSur'> </td>";
                    tbl = tbl + "<td class='labelChange' style='width:10%; text-align: right;'>" + challans[i].CAmount + ".00</td>";

                    if (challans[i].Verify == 'Matched') {
                        tbl = tbl + "<td style='text-align: center;' class='labelChange'><i class='icon-checkmark2 mr-3 icon-2x' style='color: green;' id='imgCPaid' name='imgCPaid'></td>";
                    }
                    else {
                        tbl = tbl + "<td style='text-align: center;' class='labelChange'><i class='icon-cross3 mr-3 icon-2x' style='color: red;' id='imgCNot' name='imgCNot'></td>";
                    }
                    tbl = tbl + "<td class='text-right py-0 align-middle btn-group btn-group-sm' style='width:10%; text-align: center;'>" +
                        "<a class='btn btn-info'><i onclick='Edit_Challan(event,$(this))' style='cursor: pointer;' class='far fa-edit mr-1 fa-1x'></i></a>" +
                        "<a class='btn btn-danger'><i onclick='Delete_Challan(event,$(this))' style='cursor: pointer;' class='fas fa-trash'></i></a></td>";
                    tbl = tbl + "</tr> ";
                };
                tbl = tbl + "</tbody>";
                //// Footer
                tbl = tbl + "<tr>";
                tbl = tbl + "<td style='text-align: right; padding-left:5px;padding-right:5px;font-weight:bold;'class='fixed-cell'>Total</td>";
                tbl = tbl + "<td style='text-align: right; padding-left:5px;padding-right:5px;' ></td>";
                tbl = tbl + "<td style='text-align: right; padding-left:5px;padding-right:5px;' ></td>";
                tbl = tbl + "<td style='text-align: right; padding-left:5px;padding-right:5px;' ></td>";
                tbl = tbl + "<td style='text-align: right; padding-left:5px;padding-right:5px;' ></td>";
                tbl = tbl + "<td style='text-align: center; padding-left:5px;padding-right:5px; font-weight:bold;' id=''><input type='hidden' id='hdnTotalChallanAmount' value='" + challans[0].CTotal + "' name='hdnTotalChallanAmount'>" + challans[0].CTotal + '.00' + "</td>";
                tbl = tbl + "<td style='text-align: right; padding-left:5px;padding-right:5px;' ></td>";
                tbl = tbl + "<td style='text-align: right; padding-left:5px;padding-right:5px;' ></td>";
                tbl = tbl + "<td style='text-align: right; padding-left:5px;padding-right:5px;' ></td>";
                tbl = tbl + "<td style='text-align: right; padding-left:5px;padding-right:5px;' ></td>";
                tbl = tbl + "<td style='text-align: right; padding-left:5px;padding-right:5px;' ></td>";
                tbl = tbl + "</tr> ";

                $("[id*=tblChallan]").append(tbl);
                Blockloaderhide();
            }
            else {
                tbl = tbl + "<tr>";
                tbl = tbl + "<td ></td>";
                tbl = tbl + "<td ></td>";
                tbl = tbl + "<td ></td>";
                tbl = tbl + "<td ></td>";
                tbl = tbl + "<td </td>";
                tbl = tbl + "<td style='font-weight:bold; width:40%'>No Record Found !!!</td>";
                tbl = tbl + "<td></td>";
                tbl = tbl + "<td ></td>";
                tbl = tbl + "<td ></td>";
                tbl = tbl + "<td ></td>";
                tbl = tbl + "<td ></td>";
                tbl = tbl + "</tr>";
                $("[id*=tblChallan]").append(tbl);
            }
            Blockloaderhide();
        }

        function Edit_Challan(event, i) {
            Blockloadershow();
            var row = i.closest("tr");
            var challanId = row.find("input[name=hdnCid]").val();

            if (challanId != null && challanId != undefined) {
                var b = row.find("input[name=hdnbnkid]").val();
                var cdt = row.find("input[name=hdncdt]").val();
                var o = row.find("input[name=hdncOth]").val();
                var i = row.find("input[name=hdncInt]").val();
                var c = row.find("input[name=hdncCess]").val();
                var s = row.find("input[name=hdncSur]").val();
                var ctot = row.find("td").eq(8).text();
                var chlno = row.find("td").eq(3).text();

                var chlTDS = row.find("input[name=hdncTDS]").val();

                $('[id*=dvchlded]').hide();

                $('[id*=hdnchlid]').val(challanId);
                $('[id*=txtChlTDS]').val(chlTDS);
                $('[id*=txtChSur]').val(s);
                $('[id*=txtChlCess]').val(c);
                $('[id*=txtChInt]').val(i);
                $('[id*=txtChlOth]').val(o);

                $('[id*=txtBankChinNo]').val(chlno);
                $('[id*=txtChinDate]').val(cdt);
                $('[id*=txtChTotal]').val(ctot);


                $('[id*=ddl_BSRCodes]').val(b);
                $("[id*=ddl_BSRCodes]").trigger('change');
                $('#modal_Addchallan').modal('show');
            }
            Blockloaderhide();
            event.stopPropagation();
        }

        function Delete_Challan(event, i) {
            var row = i.closest("tr");
            var challanId = row.find("input[name=hdnCid]").val();
            var Vcnt = row.find("td").eq(1).text();
            var msg = '';
            if (Vcnt > 0) {
                showDangerAlert('Cannot delete challan, Voucher exist against Challan');
                return;
            }

            var msg = 'Are you sure want to Delete this Challan ? ';

            var notice = new PNotify({
                title: 'Confirmation',
                text: '<p>' + msg + '</p>',
                hide: false,
                type: 'warning',
                confirm: {
                    confirm: true,
                    buttons: [
                        {
                            text: 'Yes',
                            addClass: 'btn btn-sm btn-primary'
                        },
                        {
                            addClass: 'btn btn-sm btn-link'
                        }
                    ]
                },
                buttons: {
                    closer: false,
                    sticker: false
                }
            })

            // On confirm
            notice.get().on('pnotify.confirm', function () {
                DeleteChallanRecord(challanId);
            })

            // On cancel
            notice.get().on('pnotify.cancel', function () {

            });
            event.stopPropagation();
        }

        function DeleteChallanRecord(cid) {
            Blockloadershow();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/Voucher.asmx/DeleteChallan",
                data: '{ cid:' + cid + '}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);

                    if (myList.length > 0) {
                        showSuccessAlert('Challan deleted success');
                        // get_Challans();
                        GetAddedChallaninList(0);
                    }
                    Blockloaderhide();
                },
                failure: function (response) {
                    Blockloaderhide();
                },
                error: function (response) {
                    Blockloaderhide();
                }
            });

        }

        function lnk_vchr(i) {
            var row = i.closest("tr");
            var Cid = row.find("input[name=hdnCid]").val();
            $("[id*=hdnLnk]").val(Cid);
            showWarningAlert("Challan Selected, Select UnPaid Vouchers");
        }

        function constructMap(data, map) {
            var objects = [];
            $.each(data, function (i, object) {
                var id = object.deducteeid;
                var name = object.Dname;
                map[name] = { id: id, name: name };
                objects.push(name);
            });
            return objects;
        }

        function Srch_ConstructMap(data, map) {
            var objects = [];
            $.each(data, function (i, object) {
                var id = object.deducteeid;
                var name = object.Dname;
                map[name] = { id: id, name: name };
                objects.push(name);
            });
            return objects;
        }

        function ChangeType(P) {

            if (P == 'P') {
                $("[id*=ddl_Type]").val('Individual');
            }
            else if (P == 'C') {
                $("[id*=ddl_Type]").val('Company');
            }

            else if (P == 'H') {
                $("[id*=ddl_Type]").val('Hindu');
            }
            else if (P == 'A') {
                $("[id*=ddl_Type]").val('AOP');
            }
            else if (P == 'B') {
                $("[id*=ddl_Type]").val('BInd');
            }

            else if (P == 'J') {
                $("[id*=ddl_Type]").val('Artificial');
            }

            else if (P == 'F') {
                $("[id*=ddl_Type]").val('Firm');
            }
            else if (P == 'T') {
                $("[id*=ddl_Type]").val('Trust');
            }
            else if (P == 'Others') {

                $("[id*=ddl_Type]").val('Others');
            }
            else if (P == 'N') {
                $("[id*=ddl_Type]").val(0);
            }
            else if (P == 'L') {

                $("[id*=ddl_Type]").val('Others');
            }
            else {
                alert('Incorrect Deductee Type 4 Charater of PAN. Click on Understanding PAN');
                $("[id*=ddl_Type]").val(0);
            }
        }

        function SearchDeductee(did) {
            var p = $("[id*=ddlperpage]").val();
            var d = did;
            //var n = $("[id*=ddlSearchNature]").val();
            //var ch = $("[id*=ddlSearchChallanStatus]").val();
            var ch = '';
            var n = '';
            var mth = $("[id*=hndCurrmth]").val();
            $("[id*=hdnPages]").val(1);
            Search_Grid(mth, 1, p, d, ch, n);
        }

        function ChangeDeductee(did) {
            var d = $("[id*=hdnDedId]").val();
            //var d = $("[id*=drpded]").val();
            var Conn = $("[id*=hdnConnString]").val();
            var compid = $("[id*=hdnCompanyid]").val();
            var F = $("[id*=hdnForm]").val();
            if (d == '') {
                return;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/Voucher.asmx/Deductee_Details",
                data: '{compid:' + compid + ',did:' + d + ', Conn:"' + Conn + '", F:"' + F + '"}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    if (myList.length > 0) {

                        var dT = $("[id*=txt_VoucherDate]").val();
                        $("[id*=txt_TDSCert]").val(myList[0].Cert);
                        if (myList[0].isInd == true) {
                            $("[id*=ddl_Type]").val('Individual');
                        }
                        else {
                            $("[id*=ddl_Type]").val(myList[0].tid);

                        }
                        $("[id*=ddl_Type]").trigger('change');

                        $("[id*=drpBAC1A]").val(myList[0].BAC1A);
                        $("[id*=txt_PANNumber]").val(myList[0].PAN);

                        var status = myList[0].PAN_AAdhar;

                        if (status == '0.00') {
                            $("[id*=lblPANsts]").html('Not Verified <i class="icon-cross3 mr-1 icon-2x"></i>').css('color', 'red');
                        }
                        else if (status == '') {
                            $("[id*=lblPANsts]").html('Not Verified <i class="icon-cross3 mr-1 icon-2x"></i>').css('color', 'red');
                        }
                        else if (status == 'PANNOTAVBL') {
                            $("[id*=lblPANsts]").html('InValid <i class="icon-cross3 mr-1 icon-2x"></i>').css('color', 'red');
                        }
                        else {
                            if (status.toLowerCase() == 'active' || status.toLowerCase() == 'valid and operative') {
                                $("[id*=lblPANsts]").html(status + '<i class="icon-check3 mr-1 icon-2x"></i>').css('color', 'green');
                            } else {
                                $("[id*=lblPANsts]").html(status + '<i class="icon-cross3 mr-1 icon-2x"></i>').css('color', 'red');
                            }
                        }


                        $("[id*=hdnisNri]").val(myList[0].isNri);
                        if (parseFloat(myList[0].Compliance) == 1) {
                            showInfoAlert('Compliance 206AB , 206CCA Check failed, deduction rate 5% or 20% whichever is higher');
                        }
                        //$("[id*=ddl_DeducteeName]").attr("disabled", false);
                        var rs = myList[0].sec;
                        ////////////////// Check certificate applicable or not

                        var PAN = myList[0].PAN;
                        var PChar = PAN.substring(4, 3);
                        ChangeType(PChar);
                        //$("[id*=ddl_Reasons]").val(myList[0].rsid);
                        //$("[id*=ddl_Reasons]").trigger('change');

                        $("[id*=txtTDSRt]").val(myList[0].Rate);
                        $("[id*=txtPAN]").val(PAN);
                        var Nat = myList[0].Lst_Nature;
                        if (Nat.length > 0) {
                            $("[id*=ddl_Nature]").val(Nat[0].Nature_ID);
                            $("[id*=ddl_Nature]").trigger('change');
                            $('[id*=hdnNatureSubID]').val(Nat[0].Nature_Sub_Id);
                            // GetRate();
                            getNatureSubId();
                        }
                        else {
                            $("[id*=ddl_Nature]").val(0);
                            $('[id*=hdnNatureSubID]').val(0);
                            getNatureSubId();
                        }
                        //////////////// Nri
                        if (myList[0].isNri == true) {
                            $("[id*=tblNri]").show();
                            $("[id*=drpRemit]").val(0);
                            $("[id*=drpCountry]").val(myList[0].Countryid);
                            $("[id*=drpCountry]").trigger('change');
                            $("[id*=txtAddress]").val(myList[0].Add1);
                            $("[id*=txtContact]").val(myList[0].Cnumber);
                            $("[id*=txtEmail]").val(myList[0].Email);
                            $("[id*=txtIdent]").val(myList[0].TaxId);
                            $("[id*=ddlRate]").val(myList[0].RT);
                            $("[id*=ddlRate]").trigger('change');
                        }

                        var Sec = myList[0].Lst_Sec;
                        var x = $("[id*=hdnSection]").val();
                        //if (x == '') {
                        $("[id*=ddl_Reasons]").empty();
                        $("[id*=ddl_Reasons]").append("<option value='0'>--Select Reasons--</option>");
                        if (Sec.length > 0) {
                            for (var i = 0; i < Sec.length; i++) {
                                $("[id*=ddl_Reasons]").append("<option value='" + Sec[i].Section_Id + "'>" + Sec[i].Section + "</option>");
                            }
                            $("[id*=hdnSection]").val('1');
                        }
                        //}
                        //$("[id*=ddl_Reasons]").val(rs);
                        //$("[id*=ddl_Reasons]").trigger('change');
                        if (rs != 'Non-Availability of PAN C' && PAN != 'PANNOTAVBL') {
                            $("[id*=ddl_Reasons]").val('Non-Availability of PAN C');
                            $("[id*=ddl_Reasons]").trigger('change');
                        }

                        if (PAN == 'PANNOTAVBL') {
                            $("[id*=ddl_Reasons]").val('Non-Availability of PAN C');
                            $("[id*=ddl_Reasons]").trigger('change');
                        }
                        if (myList[0].rsid == null || myList[0].rsid == '') {
                            $("[id*=ddl_Reasons]").val('Presc.Rt.');
                            $("[id*=ddl_Reasons]").trigger('change');
                        }
                        else {
                            $("[id*=ddl_Reasons]").val(myList[0].rsid);
                            $("[id*=ddl_Reasons]").trigger('change');
                        }

                        if (rs == 'Lower Rt. Under Section 197 A') {
                            $("[id*=txt_TDSCert]").removeAttr("disabled");
                        }
                        else {
                            $("[id*=txt_TDSCert]").val('');
                            $("[id*=txt_TDSCert]").attr("disabled", "false");
                        }
                    }
                },
                failure: function (response) {
                    Blockloaderhide();
                },
                error: function (response) {
                    Blockloaderhide();
                }
            });
        }

        function getNature_Branch_Drps() {
            Blockloadershow();

            var Conn = $("[id*=hdnConnString]").val();
            var F = $("[id*=hdnForm]").val();
            //Ajax start
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/Voucher.asmx/Get_Nature_Branch_Drp",
                data: '{ Conn:"' + Conn + '", F:"' + F + '"}',
                dataType: "json",
                success: function (msg) {
                    main_obj = jQuery.parseJSON(msg.d);
                    main_obj = main_obj[0];

                    var Nature = main_obj.Nature;   //
                    var Remitance = main_obj.Remitance;
                    var Country = main_obj.Country;
                    var Branch = main_obj.Branch;

                    var x = $("[id*=hdnDrps]").val();

                    if (x == '') {
                        $("[id*=ddl_Nature]").empty();
                        //$("[id*=ddlSearchNature]").empty();
                        //$("[id*=ddlSearchNature]").append("<option value=0>--Select--</option>");

                        $("[id*=ddl_Nature]").append("<option value=0>--Select Section--</option>");
                        for (var i = 0; i < main_obj.Nature.length; i++) {
                            $("[id*=ddl_Nature]").append("<option value='" + Nature[i].Nature_ID + "'>" + Nature[i].NatureName + "</option>");
                        }

                        $("[id*=drpRemit]").empty();
                        $("[id*=drpRemit]").append("<option value=0>--Select--</option>");
                        for (var i = 0; i < main_obj.Remitance.length; i++) {
                            $("[id*=drpRemit]").append("<option value='" + Remitance[i].rcode + "'>" + Remitance[i].remittance + "</option>");
                        }

                        $("[id*=drpCountry]").empty();
                        $("[id*=drpCountry]").append("<option value=0>--Select--</option>");
                        for (var i = 0; i < main_obj.Country.length; i++) {
                            $("[id*=drpCountry]").append("<option value='" + Country[i].Countryid + "'>" + Country[i].Country + "</option>");
                        }

                        $("[id*=drpBranch]").empty();
                        $("[id*=drpBranch]").append("<option value=0>--Select--</option>");
                        for (var i = 0; i < main_obj.Branch.length; i++) {
                            $("[id*=drpBranch]").append("<option value='" + Branch[i].bid + "'>" + Branch[i].Bname + "</option>");
                        }

                        ////////////// Clone Dropdowns

                        // first = $("[id*=ddl_Nature]");
                        //var second = $("[id*=ddlSearchNature]");
                        //var options = first[0].innerHTML;
                        //var options = second[0].innerHTML + options;
                        //second[0].innerHTML = options;
                        //$("[id*=hdnDrps]").val('1');
                        //$("[id*=ddlSearchNature]").val(0);
                    }
                    Blockloaderhide();
                },
                failure: function (response) {
                    Blockloaderhide();
                },
                error: function (response) {
                    Blockloaderhide();
                }
            });
        }

        function FillGrid(did) {
            var Conn = $("[id*=hdnConnString]").val();
            var compid = $("[id*=hdnCompanyid]").val();
            var Q = $("[id*=hdnQuater]").val();
            var F = $("[id*=hdnForm]").val();
            //Ajax start
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/Voucher.asmx/FillGrd",
                data: '{compid:' + compid + ',did:"' + did + '", Conn:"' + Conn + '", F:"' + F + '", Q: "' + Q + '"}',
                dataType: "json",
                success: function (msg) {
                    var Grd = jQuery.parseJSON(msg.d);
                    var tbl = '';
                    $("[id*=dgVoucherEntries] tr").empty();
                    //$("[id*=dgVoucherEntries] thead").empty();
                    tbl = tbl + "<thead>";
                    tbl = tbl + "<tr style='background:#dcdcdc;'>";
                    tbl = tbl + "<th class='labelChange' style=' text-align: center; font - weight: bold;'>Month</th>";
                    tbl = tbl + "<th class='labelChange' style=' text-align: center; font - weight: bold;'>Entries</th>";
                    tbl = tbl + "<th class='labelChange' style=' text-align: right; font - weight: bold; '>Amount</th>";
                    tbl = tbl + "<th class='labelChange' style=' text-align: right; font - weight: bold;'>TDS</th>";
                    tbl = tbl + "<th class='labelChange' style=' text-align: center; font - weight: bold;' >Unpaid</th>";

                    tbl = tbl + "</tr>";
                    tbl = tbl + "</thead>";
                    tbl = tbl + "<tbody>";

                    if (Grd.length > 0) {
                        for (var i = 0; i < Grd.length; i++) {
                            tbl = tbl + "<tr>";
                            tbl = tbl + "<td class='labelChange' style=' text-align: center; font - weight: bold;'><a href='#'  onclick='Edit_Show($(this))'>" + Grd[i].mth + "</a><input type='hidden' id='hdnMth' value='" + Grd[i].mthno + "' name='hdnMth'></td>";
                            tbl = tbl + "<td class='labelChange' style=' text-align: center;'><a href='#'  onclick='Edit_Show($(this))'>" + Grd[i].Entries + "</a></td>";
                            tbl = tbl + "<td  class='labelChange' style=' text-align: right;'>" + Grd[i].Amt.toFixed(2) + "</td>";
                            tbl = tbl + "<td class='labelChange' style=' text-align: right;'>" + Grd[i].Tds.toFixed(2) + "</td>";
                            tbl = tbl + "<td class='labelChange' style=' text-align: center;' ><label id='lblup' ><a href='#' onclick='Edit_ShowUP($(this))'> " + Grd[i].Upaid + "</a></label></td></tr>";
                        };
                        tbl = tbl + "</tbody>";
                        //// Footer
                        tbl = tbl + "<tr>";
                        tbl = tbl + "<td class='labelChange' style=' text-align: center; font-weight:bold;' >Total</td>";
                        tbl = tbl + "<td class='labelChange' style=' text-align: center; font-weight:bold;' >" + Grd[0].Tent + "</td>";
                        tbl = tbl + "<td class='labelChange' style=' text-align: right; font-weight:bold;' >" + Grd[0].TAmt.toFixed(2) + "</td>";
                        tbl = tbl + "<td class='labelChange' style=' text-align: right; font-weight:bold;' >" + Grd[0].TTds.toFixed(2) + "</td>";
                        tbl = tbl + "<td class='labelChange' style=' text-align: center;font-weight:bold;' >" + Grd[0].Tup + "</td></tr>";

                        $("[id*=dgVoucherEntries]").append(tbl);
                    }

                    else {
                        tbl = tbl + "<tr>";

                        tbl = tbl + "<td ></td>";
                        tbl = tbl + "<td >No Record Found !!!</td>";
                        tbl = tbl + "<td ></td>";
                        tbl = tbl + "<td ></td>";
                        tbl = tbl + "<td ></td>";
                        tbl = tbl + "</tr>";
                        $("[id*=dgVoucherEntries]").append(tbl);
                    }
                    Blockloaderhide();
                },
                failure: function (response) {
                    Blockloaderhide();
                },
                error: function (response) {
                    Blockloaderhide();
                }
            });
        }

        function chkAllselect(i) {
            var chkprop = i.is(':checked');
            // $('#chkAllTeam', row).prop("checked");
            $("input[name=chkEjob]").each(function () {

                if (chkprop) {
                    $(this).prop('checked', true);
                }
                else {
                    //$(this).removeAttr('checked');
                    $(this).prop('checked', false);
                }
            });
        }

        function ModifyGrid(mth, pageIndex, Pagesize, UP) {
            Blockloadershow();
            var Conn = $("[id*=hdnConnString]").val();

            if (UP == '') {
                UP = 0;
            }
            var RecordCount = 0;
            var ch = $("[id*=drpChallanType]").val();
            document.getElementById("dvTblVMfy").classList.remove("col-md-9");
            document.getElementById("dvTblVMfy").classList.add("col-md-12");
            if (ch == '2') {
               ////     $('[id*=btnNAddMapChl]').attr("disabled", false);   ******
               ////     $('[id*=btnRmChlnMap]').attr("disabled", true);   ******
               ////     $('[id*=btnvoucherecord]').attr("disabled", false);   ******
               ////     $('[id*=btnChlnMap]').attr("disabled", false);   ******
                $('[id*=btnNAddMapChl]').show();
                $('[id*=btnRmChlnMap]').hide();
                $('[id*=btnvoucherecord]').show();
                $('[id*=btnChlnMap]').show();
            }
            if (ch == '1') {
               //// $('[id*=btnNAddMapChl]').attr("disabled", true);   ******
               //// $('[id*=btnRmChlnMap]').attr("disabled", false);   ******
               //// $('[id*=btnvoucherecord]').attr("disabled", true);   ******
               //// $('[id*=btnChlnMap]').attr("disabled", true);   ******
                $('[id*=btnNAddMapChl]').hide();
                $('[id*=btnRmChlnMap]').show();
                $('[id*=btnvoucherecord]').hide();
                $('[id*=btnChlnMap]').hide();


            }
            if (ch == '0') {
               //// $('[id*=btnNAddMapChl]').attr("disabled", true);   ******
               //// $('[id*=btnRmChlnMap]').attr("disabled", true);   ******
               //// $('[id*=btnvoucherecord]').attr("disabled", true);   ******
               //// $('[id*=btnChlnMap]').attr("disabled", true);   ******

                $('[id*=btnNAddMapChl]').hide();
                $('[id*=btnRmChlnMap]').hide();
                $('[id*=btnvoucherecord]').hide();
                $('[id*=btnChlnMap]').hide();
            }

            var d = parseFloat(ddid);

            var n = NT;
            var F = $("[id*=ddlForm]").val();
            var Q = $("[id*=ddltype]").val();
            if (d == undefined) {
                d = '0';
            }
            $("[id*=dgVoucherModify] tr").empty();
            //$("[id*=ddlSearchDeducteeName]").val();
            //getNature_Branch_Drps();

            var fltr = $("[id*=hdnForm]").val();
            $("[id*=divMisMatch]").hide();
            $("[id*=dvFltr]").show();

            $("[id*=divModify]").show();
            $("[id*=dv_VoucherModify]").show();
            $("[id*=dvdelete]").show();
            $("[id*=dvLnk]").hide();
            $("[id*=dvChln]").hide();
            var chlnk = $("[id*=hdnLnk]").val();
            if (chlnk != '' || chlnk != 0) {
                $("[id*=dvChln]").show();
                $("[id*=dvdelete]").hide();
                $("[id*=dvLnk]").show();
            }
            $("[id*=dgVoucherModify]").show();
            $("[id*=btnProcess]").hide();
            $("[id*=btndwnd]").hide();
            $("[id*=btnChkError]").hide();
            $("[id*=tdSearch]").hide();
            if (ChlMode == '') {
                $("[id*=btnCancel]").show();
                $("[id*=btnChlCancel]").hide();
                $("[id*=drpCPerPage]").hide();
            }
            var st = $("[id*=txtStart]").val();
            var ed = $("[id*=txtend]").val();

            $("[id*=hdnMis]").val('');
            Mis = '';

            //Ajax start
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/Voucher.asmx/ModifyGrd",
                data: '{mth:' + mth + ',pI:' + pageIndex + ',pS:' + Pagesize + ', Conn:"' + Conn + '", d:"' + d + '",  n:"' + n + '", ch:"' + ch + '",  U:' + UP + ',fltr:"' + fltr + '",  F:"' + F + '",Q:"' + Q + '",st: "' + st + '", ed:"' + ed + '"}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    Blockloadershow();
                    var tbl = '';
                    $("[id*=txtAmtpd]").val(0.00);
                    $("[id*=txtTDS]").val(0.00);

                    $("[id*=dgVoucherModify] tr").empty();
                    tbl = tbl + "<thead>";
                    tbl = tbl + "<tr>";
                    tbl = tbl + "<th  style='text-align: center;' class='labelChange'>Sr No</th>";
                    tbl = tbl + "<th  style='text-align: center;' class='labelChange'>Date</th>";
                    tbl = tbl + "<th  class='labelChange' style='text-align: left;'>Deductee</th>";
                    tbl = tbl + "<th  class='labelChange' style='text-align: left;'>PAN</th>";
                    tbl = tbl + "<th  class='labelChange' style='text-align: left;'>PANVerified</th>";
                    tbl = tbl + "<th  class='labelChange' style='text-align: left;'>Rate</th>";
                    tbl = tbl + "<th  style='text-align: center;' class='labelChange'>Section</th>";
                    tbl = tbl + "<th  style='text-align: right;' class='labelChange'>Amt Paid</th>";
                    tbl = tbl + "<th  style='text-align: right;' class='labelChange'>TDS</th>";
                    tbl = tbl + "<th class='labelChange' style='text-align: center;' >Chln No</th>";
                    tbl = tbl + "<th class='labelChange' style='text-align: center;' >Chln Paid</th>";
                    //tbl = tbl + "<th >Edit</th>";
                    tbl = tbl + "<th  class='labelChange' style='text-align: center;'> <input type='checkbox' id='chkAll' name='chkAll' onclick='chkAllselect($(this))'></td></th>";
                    tbl = tbl + "</tr>";
                    tbl = tbl + "</thead>";
                    tbl = tbl + "<tbody>";
                    if (myList.length > 0) {
                        var amtlist = myList[0].LTDSgrid;
                        var j = '';
                        for (var i = 0; i < myList.length; i++) {

                            tbl = tbl + "<tr>";
                            tbl = tbl + "<td class='labelChange' style='width:5%; text-align: center; '>" + myList[i].SrNo + "</td>";
                            tbl = tbl + "<td style='text-align: center;' class='labelChange'>" + myList[i].PDate + "<input type='hidden' id='hdndid' value='" + myList[i].did + "' name='hdndid'></td>";
                            tbl = tbl + "<td style='text-align: left;' class='labelChange'><a href='#'  onclick='Edit_Rec($(this),0)' > " + myList[i].DName + "</a><input type='hidden' id='hdnvid' value='" + myList[i].vid + "' name='hdnvid'></td>";
                            tbl = tbl + "<td style='text-align: left;' class='labelChange'>" + myList[i].PanNO + "</td>";
                            if (myList[i].PanVer == 'Valid PAN') {
                                tbl = tbl + "<td style='text-align: center;' class='labelChange'><i class='icon-checkmark2 mr-3 icon-2x' style='color: green;' id='imgCPaid' name='imgCPaid'></td>";
                            }
                            else {
                                tbl = tbl + "<td style='text-align: center;' class='labelChange'><i class='icon-cross3 mr-3 icon-2x' style='color: red;' id='imgCNot' name='imgCNot'></td>";
                            }
                            tbl = tbl + "<td style='text-align: left;' class='labelChange'>" + myList[i].TdsRate + "</td>";
                            tbl = tbl + "<td style='text-align: center;' class='labelChange'>" + myList[i].sec + "</td>";
                            tbl = tbl + "<td style='text-align: right;' class='labelChange'>" + myList[i].AmtPaid + ".00</td>";
                            tbl = tbl + "<td style='text-align: right;' class='labelChange'>" + myList[i].TdsAmt + ".00</td>";
                            tbl = tbl + "<td style='text-align: center;' class='labelChange'>" + myList[i].BnkChl + "</td>";
                            if (parseFloat(myList[i].CPaid) > 0) {
                                tbl = tbl + "<td style='text-align: center;' class='labelChange'><i class='icon-checkmark2 mr-3 icon-2x' style='color: green;' id='imgCPaid' name='imgCPaid'><input type='hidden' id='hdnCid' value='" + myList[i].CPaid + "' name='hdnCid'></td>";
                            }
                            else {
                                tbl = tbl + "<td style='text-align: center;' class='labelChange'><i class='icon-cross3 mr-3 icon-2x' style='color: red;' id='imgCNot' name='imgCNot'><input type='hidden' id='hdnCid' value='" + myList[i].CPaid + "' name='hdnCid'></td>";
                            }
                            tbl = tbl + "<td style='text-align: center;' class='labelChange'><input type='checkbox' id='chkEjob' name='chkEjob' value='" + myList[i].vid + "' ></td></tr>"
                        };
                        tbl = tbl + "</tbody>";
                        $("[id*=dgVoucherModify]").append(tbl);
                        $("[id*=txtAmtpd]").val(amtlist[0].Amt);
                        $("[id*=txtTDS]").val(amtlist[0].TDS);

                        if (parseFloat(myList[0].Totalcount) > 0) {
                            RecordCount = parseFloat(myList[0].Totalcount);

                        }
                        $("[id*=dv_VoucherModify]").show();
                        $("[id*=tdSearch]").hide();
                        $("[id*=btnCancel]").show();
                        $("[id*=btnChlCancel]").hide();
                        $("[id*=drpCPerPage]").hide();
                        Pager(RecordCount, mth, UP);

                    }

                    else {
                        tbl = tbl + "<tr>";
                        tbl = tbl + "<td  class='padding5'></td>";
                        tbl = tbl + "<td  class='padding5'></td>";
                        tbl = tbl + "<td  class='padding5'>No Record Found !!!</td>";
                        tbl = tbl + "<td  class='padding5'></td>";
                        tbl = tbl + "<td  class='padding5'></td>";
                        tbl = tbl + "<td  class='padding5'></td>";
                        tbl = tbl + "<td  class='padding5'></td>";
                        tbl = tbl + "<td  class='padding5'></td>";
                        tbl = tbl + "<td  class='padding5'></td>";
                        tbl = tbl + "<td  class='padding5'></td>";
                        tbl = tbl + "<td  class='padding5'></td>";
                        tbl = tbl + "<td  class='padding5'></td>";
                        tbl = tbl + "</tr>";
                        $("[id*=dgVoucherModify]").append(tbl);
                        Pager(0, mth, UP);
                    }

                    var x = $("[id*=hdnDEdit]").val();

                    if (x == '') {
                        // $("[id*=ddlSearchDeducteeName]").empty();
                        //var first = $("[id*=ddl_DeducteeName]");
                        //var second = $("[id*=ddlSearchDeducteeName]");
                        //var options = first[0].innerHTML;
                        //var options = second[0].innerHTML + options;
                        //second[0].innerHTML = options;

                        //$("[id*=ddlSearchDeducteeName]").append("<option value=''>--Select Deductee--</option>");
                        //for (var i = 0; i < myDrps.length; i++) {

                        //    $("[id*=ddlSearchDeducteeName]").append("<option value='" + myDrps[i].deducteeid + "'>" + myDrps[i].Dname + "</option>");

                        //}
                        $("[id*=hdnDEdit]").val('1');
                    }

                    Blockloaderhide();
                },
                failure: function (response) {
                    Blockloaderhide();
                },
                error: function (response) {
                    Blockloaderhide();
                }
            });
        }

        function Pager(RecordCount, mth, UP) {
            $(".Pager").ASPSnippets_Pager({
                ActiveCssClass: "current",
                PagerCssClass: "pager",
                PageIndex: parseInt($("[id*=hdnPages]").val()),
                PageSize: parseInt($("[id*=ddlperpage]").val()),
                RecordCount: parseInt(RecordCount)
            });

            ////pagging changed bind LeaveMater with new page index
            $(".Pager .page").on("click", function () {
                $("[id*=hdnPages]").val($(this).attr('page'));
                //UP =$("[id*=ddlSearchChallanStatus]").val();
                p = $("[id*=ddlperpage]").val();
                if (UP == '') { UP == 0; }
                ModifyGrid(mth, ($(this).attr('page')), p, UP);
            });
        }

        function GetRate() {
            Blockloadershow();
            var nsid = $("[id*=hdnNatureSubID]").val();
            var dT = $("[id*=txt_VoucherDate]").val();
            var Conn = $("[id*=hdnConnString]").val();
            if (dT == '') {
                showInfoAlert('Date not selected');
                return;
            }
            var nid = $("[id*=ddl_Nature]").val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/Voucher.asmx/Deductee_Rate",
                data: '{nsid:"' + nsid + '", dT:"' + dT + '", Conn:"' + Conn + '", nid:' + nid + '}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    if (myList == null) {
                        showInfoAlert('194J Section is not applicable for current date')
                        $("[id*=ddl_Nature]").val(0);
                        $("[id*=btnSave]").hide();
                        Blockloaderhide();
                        return;
                    }
                    if (myList.length > 0) {
                        $("[id*=txtTDSRt]").val(myList[0].Rate);
                        $("[id*=btnSave]").show();
                        if (myList[0].VDT >= '05/15/2020' && myList[0].nid >= 13) {
                            $("[id*=btnSave]").hide();
                            showInfoAlert('Section 194J has changed');
                        }
                    }

                    var dr = $("[id*=ddl_Reasons]").val();


                    if (dr == 'No Tax only for sec 194, 194A, 194EE, 193, 194DA, 192A, 194I(a), 194I(b) & 194D B' || dr == 'No Tax on A/c of pmt under sec 197A Z') {
                        $("[id*=txtTDSRt]").val(0);
                    }
                    else if (dr == 'No Deduction on account of payment made to a person under section 194N N' || dr == 'No Deduction or lower deduction is on account of payment made to a person  under sub-section (5) of section 194A D') {
                        $("[id*=txtTDSRt]").val(0);
                    }
                    else if (dr == 'No Deduction is as per the provisions of sub-section (2A) of section 194LBA O' || dr == 'No Deduction or lower deduction under second provison to section 194N M') {
                        $("[id*=txtTDSRt]").val(0);
                    }
                    else if (dr == 'No deduction  being made to a person referred In Board Circular no. 3 of 2002 or Circular 11 of 2002 E' || dr == 'No deduction is on account of payment of dividend made to a business trust 194 P') {
                        $("[id*=txtTDSRt]").val(0);
                    }
                    else if (dr == 'No deduction in view of payment made to an entity referred to in clause (x) of sub-section (3) of section 194A Q') {
                        $("[id*=txtTDSRt]").val(0);
                    }

                    Blockloaderhide();
                },
                failure: function (response) {
                    Blockloaderhide();
                },
                error: function (response) {
                    Blockloaderhide();
                }
            });
        }

        function MisMatch_Vouchers(Q, F) {
            var Conn = $("[id*=hdnConnString]").val();
            var compid = parseFloat($("[id*=hdnCompanyid]").val());
            var UP = '';
            Pager(0, 0, UP);
            $("[id*=btnCancel]").hide();
            $("[id*=btnAdd]").hide();
            $("[id*=tblMisMatch] tbody").empty();
            var Err = "";
            //Ajax start
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/Voucher.asmx/MisMatch_Vouchers",
                data: '{compid:' + compid + ',f:"' + F + '",q:"' + Q + '", Conn:"' + Conn + '"}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);

                    myList = myList[0];
                    var tbl = "";
                    var PAN = myList.Lst_PAN;   //

                    var Trans = myList.Lst_Tr;    //
                    var Nri = myList.Lst_Nri;
                    var tbl = '';
                    if (PAN.length > 0) {

                        Err = "1";
                        tbl = tbl + "<tr >";
                        tbl = tbl + "<th style='text-align: center;'  >Date</th>";
                        tbl = tbl + "<th style=text-align: center;'  >Deductee</th>";
                        tbl = tbl + "<th style=text-align: center;'  >Voucher Amt</th>";
                        tbl = tbl + "<th style=text-align: center;'  >Voucher PAN</th>";
                        tbl = tbl + "<th style=text-align: center;'  >Deductee PAN</th>";
                        //tbl = tbl + "<th style=text-align: center;'  >Edit</th></tr>";
                        for (var i = 0; i < PAN.length; i++) {
                            tbl = tbl + "<tr >";
                            tbl = tbl + "<td style='text-align: center;'>" + PAN[i].PDate + "<input type='hidden' name='hdnvid' value='" + PAN[i].Vid + "'/></td>";
                            tbl = tbl + "<td style='text-align: center;'><a href='#'  onclick='Edit_Rec($(this),0)' > " + PAN[i].DName + "</a><input type='hidden' name='hdnCid' value='0'/></td>";
                            tbl = tbl + "<td style='text-align: right;'>" + PAN[i].AmtPaid + "</td>";
                            tbl = tbl + "<td style='text-align: center;'>" + PAN[i].VPAN + "</td>";
                            tbl = tbl + "<td style='text-align: center;'>" + PAN[i].DPAN + "</td>";


                            tbl = tbl + "</tr >";
                        };

                        $("[id*=tblMisMatch]").append(tbl);
                    }

                    else if (Trans.length > 0) {

                        Err = "1";
                        tbl = tbl + "<tr >";
                        tbl = tbl + "<th style='width:10%;text-align: center;'  >Date</th>";
                        tbl = tbl + "<th style='width:30%;text-align: center;'  >Deductee</th>";
                        tbl = tbl + "<th style='width:15%;text-align: center;'  >Voucher Amt</th>";
                        tbl = tbl + "<th style='width:10%;text-align: center;'  >TDS</th>";
                        tbl = tbl + "<th style='width:10%;text-align: center;'  >Correct TDS</th>";
                        tbl = tbl + "<th style='width:5%;text-align: center;'  >Rate</th>";
                        tbl = tbl + "<th style='width:10%;text-align: center;'  >Certificate</th>";
                        tbl = tbl + "<th style='width:20%;text-align: center;'  >Error</th>";
                        //tbl = tbl + "<th style='width:10%;text-align: center;'  >Edit</th></tr>";
                        for (var i = 0; i < Trans.length; i++) {
                            tbl = tbl + "<tr >";
                            tbl = tbl + "<td  style='text-align: center;'>" + Trans[i].PDate + "<input type='hidden' name='hdnvid' value='" + Trans[i].Vid + "'/></td>";
                            tbl = tbl + "<td  style='text-align: center;'><a href='#'  onclick='Edit_Rec($(this),0)'>" + Trans[i].DName + "</a><input type='hidden' name='hdnCid' value='0'/></td>";
                            tbl = tbl + "<td  style='text-align: right;'>" + Trans[i].AmtPaid + "</td>";
                            tbl = tbl + "<td  style='text-align: right;'>" + Trans[i].TdsAmt + "</td>";
                            tbl = tbl + "<td  style='text-align: right;'>" + Trans[i].CTdsAmt + "</td>";
                            tbl = tbl + "<td  style='text-align: right;'>" + Trans[i].RT + "</td>";
                            tbl = tbl + "<td  style='text-align: center;'>" + Trans[i].Cert + "</td>";
                            tbl = tbl + "<td  style='text-align: center;'>" + Trans[i].Error + "</td>";

                            tbl = tbl + "</tr >";
                        };

                        $("[id*=tblMisMatch]").append(tbl);
                    }
                    else if (Nri.length > 0) {

                        Err = "1";
                        tbl = tbl + "<tr >";
                        tbl = tbl + "<th style='width:10%;text-align: center;'  >Deductee</th>";
                        tbl = tbl + "<th style='width:30%;text-align: center;'  >Email</th>";
                        tbl = tbl + "<th style='width:15%;text-align: center;'  >Tel</th>";
                        tbl = tbl + "<th style='width:10%;text-align: center;'  >Tax</th>";
                        tbl = tbl + "<th style='width:5%;text-align: center;'  >Address</th>";

                        for (var i = 0; i < Nri.length; i++) {
                            tbl = tbl + "<tr >";
                            tbl = tbl + "<td  style='text-align: center;'>" + Nri[i].DName + "</td>";
                            if (Nri[i].Email == '') {
                                tbl = tbl + "<td  style='text-align: center; color:Red; font-weight: bold; font-size:14px;'>Required</td>";
                            }
                            else {
                                tbl = tbl + "<td  style='text-align: center;'>" + Nri[i].Email + "</td>";
                            }

                            if (Nri[i].Tel == '') {
                                tbl = tbl + "<td  style='text-align: right; color:Red;font-weight: bold; font-size:14px;'>required</td>";
                            }
                            else {
                                tbl = tbl + "<td  style='text-align: right;'>" + Nri[i].Tel + "</td>";
                            }

                            if (Nri[i].Tax == '') {
                                tbl = tbl + "<td  style='text-align: right; color:Red;font-weight: bold; font-size:14px;'>Required</td>";
                            }
                            else {
                                tbl = tbl + "<td  style='text-align: right;'>" + Nri[i].Tax + "</td>";
                            }

                            if (Nri[i].Add == '') {
                                tbl = tbl + "<td  style='text-align: right; color:Red;font-weight: bold; font-size:14px;'>Required</td>";
                            }
                            else {
                                tbl = tbl + "<td  style='text-align: right;'>" + Nri[i].Add + "</td>";
                            }
                            tbl = tbl + "</tr >";
                        };

                        $("[id*=tblMisMatch]").append(tbl);
                    }
                    else {
                        tbl = tbl + "<tr >";
                        tbl = tbl + "<td  style='text-align: center;'>No Record Found !!!</td>";
                        tbl = tbl + "</tr >";
                        $("[id*=tblMisMatch]").append(tbl);
                        //  Pager(0, mth);
                    }

                },
                failure: function (response) {
                    Blockloaderhide();
                },
                error: function (response) {
                    Blockloaderhide();
                }
            });
        }

        function Del_Vouchers(paidids, nonpaid, compid, Conn) {
            //Ajax start
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/Voucher.asmx/DeleteRecords",
                data: '{compid:' + compid + ',paidids:"' + paidids + '",nonpaid:"' + nonpaid + '", Conn:"' + Conn + '"}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    if (myList.length > 0) {
                        if (parseFloat(myList[0].vid) > 0) {
                            showSuccessAlert('Deductions Removed Successfully!!!')
                            //  ShowSuccessWindow('Voucher Removed Successfully!!!');
                            var mth = $("[id*=hndCurrmth]").val();
                            var PageIndex = $("[id*=hdnPages]").val();
                            p = $("[id*=ddlperpage]").val();
                            ModifyGrid(mth, PageIndex, p, 0);
                            Clearall();
                            $("[id*=hndCurrmth]").val(mth);
                        }
                    }
                    Blockloaderhide();
                },
                failure: function (response) {
                    Blockloaderhide();
                },
                error: function (response) {
                    Blockloaderhide();
                }
            });
        }
        ////////// Challan Edit
        function Edit_Rec(i, chln) {


            Blockloadershow();
            var mth = $("[id*=hndCurrmth]").val();
            RecMode = 'Edit';
            Clearall();
            ClearChallanControls();
            $("[id*=hndCurrmth]").val(mth);
            $("[id*=ddlForm]").attr("disabled", true);
            $("[id*=ddltype]").attr("disabled", true);
            $("[id*=tblPager]").hide();
            var row = i.closest("tr");
            var vid = row.find("input[name=hdnvid]").val();
            var compid = $("[id*=hdnCompanyid]").val();
            var Conn = $("[id*=hdnConnString]").val();
            var cid = 0;

            $("[id*=hdnVAmt]").val(0);
            //////////////////////////// Updating Challan
            //Ajax start
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/Voucher.asmx/EditRecords",
                data: '{vid:' + vid + ', Conn:"' + Conn + '"}',
                dataType: "json",
                success: function (msg) {
                    EnableFields();
                    var myList = jQuery.parseJSON(msg.d);


                    if (myList.length > 0) {
                        RecMode = 'Edit';
                        //ChlMode = 'Edit';
                        voucherData = myList[0];
                        var Grd = voucherData.Grd;
                        var ddlrs = voucherData.Lst_Sec
                        $("[id*=btnChlCancel]").hide();
                        $("[id*=drpCPerPage]").hide();
                        $("[id*=drpPerPage]").hide();
                        $("[id*=btnAdd]").hide();
                        $("[id*=dv_VoucherModify]").hide();
                        $("[id*=tdSearch]").hide();
                        $("[id*=btnCancel]").hide();
                        $("[id*=dvAddVoucher]").show();
                        $("[id*=btnSave]").show();
                        $("[id*=btnVoucherCancel]").show();
                        cid = voucherData.Cid;
                        if (parseFloat(cid) > 0) {
                            showInfoAlert("Challan already paid");
                            MakeFieldsReadOnlyOnChallanAlreadyPaid();
                        }
                        else {
                            $("[id*=btnSave]").show();
                        }

                        $("[id*=txt_VoucherDate]").val(voucherData.PDate);
                        $("[id*=txtDedDate]").val(voucherData.DDate);

                        //$("[id*=txtDedDate]").val(voucherData.DeducteeDate);
                        $("[id*=txt_TDSCert]").val(voucherData.Cert);
                        $("[id*=ddl_Type]").val(voucherData.tid);
                        $("[id*=ddl_Type]").trigger('change');
                        if (voucherData.PAN != 'undefined' && voucherData.PAN != null) {
                            $("[id*=txtPAN]").val(voucherData.PAN);
                        }

                        $("[id*=txtAmtPd]").val(voucherData.AmtPaid);
                        $("[id*=txtTDSRt]").val(voucherData.Rate);
                        $("[id*=txtsurc]").val(voucherData.Sur);
                        $("[id*=txtCess]").val(voucherData.Cess);
                        $("[id*=txtTotal]").val(voucherData.Total);
                        $("[id*=hdnVAmt]").val(voucherData.Total);
                        $("[id*=hdnVoucherID]").val(voucherData.vid);
                        $("[id*=hdnNatureSubID]").val(voucherData.nsid);
                        $("[id*=hdnDedId]").val(voucherData.did);
                        $("[id*=txtded]").val(voucherData.DName);
                        $("[id*=ddl_Nature]").val(voucherData.nid);
                        $("[id*=ddl_Nature]").trigger('change');
                        var rs = voucherData.rsid;

                        if (voucherData.Invid != 'undefined' && voucherData.Invid != null) {
                            $("[id*=txtInvNo]").val(voucherData.Invid);
                        }
                        $("[id*=txtInvNo]").attr("disabled", false);
                        $("[id*=drpBranch]").attr("disabled", false);
                        $("[id*=drpBranch]").val(voucherData.Bid);
                        $("[id*=drpBranch]").trigger('change');
                        $("[id*=drpRemit]").val(voucherData.rid);
                        $("[id*=drpRemit]").trigger('change');
                        $("[id*=hdnisNri]").val(voucherData.isNri);

                        var PA = myList[0].PAN_AAdhar;
                        if (PA == '' || PA == null) {
                            PA = 'Not Verified';
                            $("[id*=lblPANsts]").html(PA + '<i class="icon-cross3 mr-1 icon-2x"></i>').css('color', 'red');
                        }

                        if (PA == '0.00') {
                            $("[id*=lblPANsts]").html('Not Verified <i class="icon-cross3 mr-1 icon-2x"></i>').css('color', 'red');;
                        }
                        if (PA == '') {
                            $("[id*=lblPANsts]").html('InValid <i class="icon-cross3 mr-1 icon-2x"></i>').css('color', 'red');;
                        }
                        else {
                            $("[id*=lblPANsts]").html(PA);
                            if (PA.toLowerCase() == 'active' || PA.toLowerCase() == 'valid and operative') {
                                $("[id*=lblPANsts]").html(PA + '<i class="icon-check3 mr-1 icon-2x"></i>').css('color', 'green');
                            } else {
                                $("[id*=lblPANsts]").html(PA + '<i class="icon-cross3 mr-1 icon-2x"></i>').css('color', 'red');
                            }
                        }

                        var isNRI_boolean = voucherData.isNri == false ? "N" : "Y";
                        $("[id*=drpIsNri]").val(isNRI_boolean);
                        $("[id*=drpIsNri]").trigger('change');
                        $("[id*=hdnSel]").val(voucherData.sel);
                        $("[id*=hdnNatureFromType]").val(voucherData.formType);
                        $("[id*=txtAddress]").val(voucherData.Add1);
                        $("[id*=txtEmail]").val(voucherData.Emailid);
                        $("[id*=txtContact]").val(voucherData.Contactno);
                        $("[id*=txtIncome]").val(voucherData.Total);
                        $("[id*=drpCountry]").val(voucherData.CountryId);
                        $("[id*=drpCountry]").trigger('change');
                        $("[id*=ddlRate]").val(voucherData.NriTDSRT);
                        $("[id*=ddlRate]").trigger('change');
                        $("[id*=hdnQuater]").val(voucherData.Quater);

                        $("[id*=ddl_Reasons]").empty();
                        $("[id*=ddl_Reasons]").append("<option value='0'>--Select Reasons--</option>");
                        for (var i = 0; i < voucherData.Lst_Sec.length; i++) {
                            $("[id*=ddl_Reasons]").append("<option value='" + ddlrs[i].Section_Id + "'>" + ddlrs[i].Section + "</option>");
                        }

                        $("[id*=ddl_Reasons]").val(rs);
                        $("[id*=ddl_Reasons]").trigger('change');
                        editReasonValue = rs;
                        if (rs == 'Lower Rt. Under Section 197 A') {
                            $("[id*=txtCertNo]").val(voucherData.Cert)
                            $("[id*=txtCertNo]").attr("disabled", false);
                        }
                        else {
                            $("[id*=txtCertNo]").attr("disabled", true)
                        }

                        if (voucherData.isNri == false) {
                            $("[id*=drpRemit]").attr("disabled", true);
                        }

                        ShowHideNRIDivs();
                        $("[id*=drpBAC]").val(voucherData.BAC1A);
                        $("[id*=drpEstInIndia]").val(voucherData.eqInd);
                        $("[id*=drpEstInIndia]").trigger('change');
                        $("[id*=drpIsNri]").val(voucherData.eqNri);
                        $("[id*=drpIsNri]").trigger('change');
                        if (voucherData.eqNri == 'Y') {
                            $("[id*=dvEstIndia]")[0].style.display = 'block';

                        }
                        else
                            $("[id*=dvEstIndia]")[0].style.display = 'none';

                        if (cid > 0) {
                            get_SelectedVoucherChallan(cid, vid);
                        }
                        var o = document.getElementById("ddlChallan").length; //$("[id*=ddlChallan]").Option.length;
                        if (o == 1) {
                            $("[id*=ddlChallan]").attr("disabled", true);
                        }
                        else {
                            $("[id*=ddlChallan]").attr("disabled", false);
                        }

                        // Fill_Challan_DropDowns(cid);
                        setAllControlsNumericFormat();
                    }

                    Blockloaderhide();
                },
                failure: function (response) {
                    Blockloaderhide();
                },
                error: function (response) {
                    Blockloaderhide();
                }
            });
        }

        function ShowHideNRIDivs() {
            var f = $("[id*=ddlForm]").val();
            if (f == '27EQ') {
                var dv = $("[id*=dv27QNRI]");
                dv[0].style.display = 'none';
                var dv = $("[id*=dv27EQTCS]");
                dv[0].style.display = 'block';
            }
            else if (f == '27Q') {
                var dv = $("[id*=dv27QNRI]");
                dv[0].style.display = 'block';
                var dv = $("[id*=dv27EQTCS]");
                dv[0].style.display = 'none';
                $("[id*=drpIsNri]").val("Y");
            }
            else {
                var dv = $("[id*=dv27EQTCS]");
                dv[0].style.display = 'none';
                var dv = $("[id*=dv27QNRI]");
                dv[0].style.display = 'none';
                $("[id*=drpIsNri]").val("N");
            }
        }

        function EnableFields() {
            $("[id*=txt_VoucherDate]").attr("readonly", false);
            $("[id*=txt_TDSCert]").attr("readonly", false);
            $("[id*=txtCertNo]").attr("readonly", false);
            $("[id*=txtAmtPd]").attr("readonly", false);
            $("[id*=txtTDSRt]").attr("readonly", false);
            $("[id*=txtIncome]").attr("readonly", false);
            $("[id*=txtsurc]").attr("readonly", false);
            $("[id*=txtCess]").attr("readonly", false);

            $("[id*=hdnVoucherID]").attr("readonly", false);
            $("[id*=hdnNatureSubID]").attr("readonly", false);
            $("[id*=hdnDedId]").attr("readonly", false);
            $("[id*=txtded]").attr("readonly", false);
            $("[id*=txtInvNo]").attr("readonly", false);
            $("[id*=hdnisNri]").attr("readonly", false);
            $("[id*=txtAddress]").attr("readonly", false);
            $("[id*=txtEmail]").attr("readonly", false);
            $("[id*=txtContact]").attr("readonly", false);
            $("[id*=txtIncome]").attr("readonly", false);
            $("[id*=hdnQuater]").attr("readonly", false);
            $("[id*=txtAmtPd]").attr("readonly", false);
            $("[id*=hdnChallanId]").attr("readonly", false);
            $("[id*=lblChlno]").attr("readonly", false);
            $("[id*=lblCdate]").attr("readonly", false);
            $("[id*=lblBSR]").attr("readonly", false);
            $("[id*=lblTDS]").attr("readonly", false);
            $("[id*=lblSur]").attr("readonly", false);
            $("[id*=lblCess]").attr("readonly", false);
            $("[id*=lblInt]").attr("readonly", false);
            $("[id*=lblOth]").attr("readonly", false);
            $("[id*=lblTot]").attr("readonly", false);
            $("[id*=lblDAmt]").attr("readonly", false);
            $("[id*=lblBal]").attr("readonly", false);
            $("[id*=txtChallan]").attr("readonly", false);
            $("[id*=txtChallaDt]").attr("readonly", false);
            $("[id*=ddl_ChallanBSRCodes]").attr("readonly", false);
            $("[id*=lblTDS]").attr("readonly", false);
            $("[id*=lblInt]").attr("readonly", false);
            $("[id*=lblOth]").attr("readonly", false);
            $("[id*=txtAmtPd]").attr("readonly", false);
            $("[id*=txtChallanTdsNC]").attr("readonly", false);
            $("[id*=txtChallanDedAmt]").attr("readonly", false);
            $("[id*=txtChallanDiffAmt]").attr("readonly", false);

            $("[id*=txtContact]").attr("readonly", false);
            $("[id*=txtIdent]").attr("readonly", false);

            $("[id*=ddl_Type]").attr("disabled", false);
            $("[id*=ddl_Nature]").attr("disabled", false);
            $("[id*=drpBranch]").attr("disabled", false);
            $("[id*=drpRemit]").attr("disabled", false);
            $("[id*=drpIsNri]").attr("disabled", false);
            $("[id*=drpCountry]").attr("disabled", false);
            $("[id*=ddlRate]").attr("disabled", false);
            $("[id*=ddl_Reasons]").attr("disabled", false);
            $("[id*=drpRemit]").attr("disabled", false);
            $("[id*=drpEQ_Ind]").attr("disabled", false);
            $("[id*=drpEQ_Nri]").attr("disabled", false);
            $("[id*=drpBAC]").attr("disabled", false);
        }


        function MakeFieldsReadOnlyOnChallanAlreadyPaid() {
            $("[id*=txt_VoucherDate]").attr("readonly", true);
            $("[id*=txt_TDSCert]").attr("readonly", true);
            $("[id*=txtCertNo]").attr("readonly", true);
            $("[id*=txtAmtPd]").attr("readonly", true);
            $("[id*=txtTDSRt]").attr("readonly", true);
            $("[id*=txtIncome]").attr("readonly", true);
            $("[id*=txtsurc]").attr("readonly", true);
            $("[id*=txtCess]").attr("readonly", true);

            $("[id*=hdnVoucherID]").attr("readonly", true);
            $("[id*=hdnNatureSubID]").attr("readonly", true);
            $("[id*=hdnDedId]").attr("readonly", true);
            $("[id*=txtded]").attr("readonly", true);
            $("[id*=txtInvNo]").attr("readonly", true);
            $("[id*=hdnisNri]").attr("readonly", true);
            $("[id*=txtAddress]").attr("readonly", true);
            $("[id*=txtEmail]").attr("readonly", true);
            $("[id*=txtContact]").attr("readonly", true);
            $("[id*=txtIncome]").attr("readonly", true);
            $("[id*=hdnQuater]").attr("readonly", true);
            $("[id*=txtAmtPd]").attr("readonly", true);
            $("[id*=hdnChallanId]").attr("readonly", true);
            $("[id*=lblChlno]").attr("readonly", true);
            $("[id*=lblCdate]").attr("readonly", true);
            $("[id*=lblBSR]").attr("readonly", true);
            $("[id*=lblTDS]").attr("readonly", true);
            $("[id*=lblSur]").attr("readonly", true);
            $("[id*=lblCess]").attr("readonly", true);
            $("[id*=lblInt]").attr("readonly", true);
            $("[id*=lblOth]").attr("readonly", true);
            $("[id*=lblTot]").attr("readonly", true);
            $("[id*=lblDAmt]").attr("readonly", true);
            $("[id*=lblBal]").attr("readonly", true);
            $("[id*=txtChallan]").attr("readonly", true);
            $("[id*=txtChallaDt]").attr("readonly", true);
            $("[id*=ddl_ChallanBSRCodes]").attr("readonly", true);
            $("[id*=lblTDS]").attr("readonly", true);
            $("[id*=lblInt]").attr("readonly", true);
            $("[id*=lblOth]").attr("readonly", true);
            $("[id*=txtAmtPd]").attr("readonly", true);
            $("[id*=txtChallanTdsNC]").attr("readonly", true);
            $("[id*=txtChallanDedAmt]").attr("readonly", true);
            $("[id*=txtChallanDiffAmt]").attr("readonly", true);

            $("[id*=txtContact]").attr("readonly", true);
            $("[id*=txtIdent]").attr("readonly", true);

            $("[id*=ddl_Type]").attr("disabled", true);
            $("[id*=ddl_Nature]").attr("disabled", true);
            $("[id*=drpBranch]").attr("disabled", true);
            $("[id*=drpRemit]").attr("disabled", true);
            $("[id*=drpIsNri]").attr("disabled", true);
            $("[id*=drpCountry]").attr("disabled", true);
            $("[id*=ddlRate]").attr("disabled", true);
            $("[id*=ddl_Reasons]").attr("disabled", true);
            $("[id*=drpRemit]").attr("disabled", true);
            $("[id*=drpEQ_Ind]").attr("disabled", true);
            $("[id*=drpEQ_Nri]").attr("disabled", true);
            $("[id*=drpBAC]").attr("disabled", true);
        }

        function SaveDeduction() {
            Blockloadershow();
            vMod = 'show';
            var fn = $("[id*=hdnConnString]").val();
            var fy = fn.split('_');
            var st = '04/01/' + fy[0];
            var ed = '03/31/20' + fy[1];
            var vd = new Date;
            var s = new Date;
            var e = new Date;
            var d = $("[id*=txt_VoucherDate]").val();
            var dt = d.split('-');
            d = dt[1] + '/' + dt[2] + '/' + dt[0];

            vd = moment(d);
            s = moment(st);
            e = moment(ed);
            if (moment(vd) < moment(s)) {
                $("[id*=txt_VoucherDate]").val('');
                $("[id*=txtDedDate]").val('');
                showInfoAlert('Voucher date cannot be outside the Financial year');
                Blockloaderhide();
                return;
            }
            if (moment(vd) > moment(e)) {
                $("[id*=txtDedDate]").val('');
                $("[id*=txt_VoucherDate]").val('');
                showInfoAlert('Voucher date cannot be outside the Financial year');
                Blockloaderhide();
                return;
            }

            var ddt = $("[id*=txtDedDate]").val();
            if (ddt == '' | ddt == undefined) {
                $("[id*=txtDedDate]").val(dt);
            }

            var qua = $("[id*=ddltype]").val();
            var q = qua.substring(1);
            if (q == 1) {
                if (dt[1] < 4 || dt[1] > 6) {
                    $("[id*=txtDedDate]").val('');
                    $("[id*=txt_VoucherDate]").val('');
                    showInfoAlert('Voucher date cannot be outside the Quarter');
                    Blockloaderhide();
                    return;
                }
            }
            else if (q == 2) {
                if (dt[1] < 7 || dt[1] > 9) {
                    $("[id*=txtDedDate]").val('');
                    $("[id*=txt_VoucherDate]").val('');
                    showInfoAlert('Voucher date cannot be outside the Quarter');
                    Blockloaderhide();
                    return;
                }
            }
            else if (q == 3) {
                if (dt[1] < 10 || dt[1] > 13) {
                    $("[id*=txt_VoucherDate]").val('');
                    $("[id*=txtDedDate]").val('');
                    showInfoAlert('Voucher date cannot be outside the Quarter');
                    Blockloaderhide();
                    return;
                }
            }
            else if (q == 4) {
                if (dt[1] < 1 || dt[1] > 3) {
                    $("[id*=txt_VoucherDate]").val('');
                    $("[id*=txtDedDate]").val('');
                    showInfoAlert('Voucher date cannot be outside the Quarter');
                    Blockloaderhide();
                    return;
                }
            }
            var frm = $("[id*=hdnForm]").val();
            var chk = $("[id*=chk]").is(':checked');
            var Conn = $("[id*=hdnConnString]").val();

            ////////  calulate Challan amounts
            var ChallanId = $("[id*=ddlChallan]").val();
            if (ChallanId > 0) {
                var voucherTotalAmount = $("[id*=txtTotal]").val();
                var totalAmount = 0; //challandata.Camt - challandata.VoucherTotal;

                var Camt = $("[id*=hdnChlTDSAmt]").val();
                var consumeAmt = $("[id*=txtChallanDedAmt]").val();
                if (consumeAmt == '' | consumeAmt == undefined) {
                    consumeAmt = 0;
                }
                if (RecMode == 'Add') {
                    var vt = $("[id*=txtTotal]").val();
                    totalAmount = parseFloat(Camt) - (parseFloat(vt) + parseFloat(consumeAmt));
                    if (totalAmount < 0) {

                        Blockloaderhide();
                        showPrimaryAlert('Voucher Total cannot be more than Challan TDS Amount');
                        return;
                    }
                }
                else {

                    /////////////// delete old voucher amt from challan
                    totalAmount = parseFloat(Camt) - parseFloat(consumeAmt);
                    /////////////// add current voucher amt in challan and check the difference
                    var vvt = $("[id*=txtTotal]").val();
                    totalAmount = parseFloat(totalAmount) - parseFloat(vvt);


                    if (totalAmount < 0) {
                        Blockloaderhide();
                        showPrimaryAlert('Voucher Total cannot be more than Challan TDS Amount');
                        return;
                    }
                }

            }


            var deductionData = {};
            deductionData.Conn = Conn;
            deductionData.CompanyId = $("[id*=hdnCompanyid]").val();
            deductionData.DeducteeId = $("[id*=hdnDedId]").val();
            deductionData.VoucherId = $("[id*=hdnVoucherID]").val();
            deductionData.NatureSubId = $("[id*=hdnNatureSubID]").val();
            deductionData.Sel = $("[id*=hdnSel]").val();
            deductionData.Sel = deductionData.Sel == "" ? 0 : deductionData.Sel;
            deductionData.FormType = $("[id*=hdnForm]").val();
            deductionData.ChallanId = $("[id*=ddlChallan]").val();
            deductionData.ChallanDate = $("[id*=txtChallaDt]").val();
            deductionData.VoucherDate = $("[id*=txt_VoucherDate]").val();
            deductionData.TDSCertificate = $("[id*=txtCertNo]").val();
            deductionData.PAN = $("[id*=txtPAN]").val();
            deductionData.InvOrBillNo = $("[id*=txtInvNo]").val();
            deductionData.VoucherAmount = $("[id*=txtAmtPd]").val();
            deductionData.TDSPercentage = $("[id*=txtTDSRt]").val();
            deductionData.TdsAmt = $("[id*=txtIncome]").val();
            deductionData.SurchargeAmt = $("[id*=txtsurc]").val();
            deductionData.ECessAmt = $("[id*=txtCess]").val();
            //deductionData.net = $("[id*=txtTotal]").val();
            deductionData.DName = $("[id*=txtded]").val();
            deductionData.Add1 = $("[id*=txtAddress]").val();
            deductionData.Email = $("[id*=txtEmail]").val();
            deductionData.ContactNo = $("[id*=txtContact]").val();
            deductionData.Quarter = $("[id*=ddltype]").val();
            deductionData.TaxId = $("[id*=txtIdent]").val();
            deductionData.VoucherDate = $("[id*=txt_VoucherDate]").val();
            deductionData.ChallanBankNo = $("[id*=ddl_ChallanBSRCodes]").val();
            deductionData.NatureId = $("[id*=ddl_Nature]").val();
            deductionData.NatureId = deductionData.NatureId == "" ? 0 : deductionData.NatureId;
            deductionData.Reason = $("[id*=ddl_Reasons]").val();
            deductionData.DeducteeType = $("[id*=ddl_Type]").val();
            deductionData.BranchId = $("[id*=drpBranch]").val();
            deductionData.BranchId = deductionData.BranchId == "" ? 0 : deductionData.BranchId;
            deductionData.RemittanceId = $("[id*=drpRemit]").val();
            deductionData.RemittanceId = deductionData.RemittanceId == "" ? 0 : deductionData.RemittanceId;
            deductionData.NriTDSRT = $("[id*=ddlRate]").val();
            deductionData.CountryId = $("[id*=drpCountry]").val();
            deductionData.CountryId = deductionData.CountryId == "" ? 0 : deductionData.CountryId;
            //deductionData.IsNRI = $("[id*=drpIsNri]").val();

            deductionData.ThresholdLimit = $("[id*=chk]").is(':checked');
            deductionData.TotalTaxAmt = $("[id*=txtTotal]").val();
            //.TotalTaxAmt = deductionData.TotalTaxAmt == "" ? 0 : deductionData.TotalTaxAmt;
            deductionData.DeductedDate = $("[id*=txtDedDate]").val();

            var fn = $("[id*=hdnConnString]").val();
            var fy = fn.split('_');
            //////////////////// Validation
            if (deductionData.Reason == 'Lower Rt. Under Section 197 A' && deductionData.TDSCertificate == '') {
                $("[id*=txtCertNo]").val('');
                $("[id*=txtCertNo]").removeAttr('disable');

                showInfoAlert('Certificate No applicable for this Reason');
                Blockloaderhide();
                return;
            }

            if (deductionData.VoucherAmount <= 0) {
                showInfoAlert('Voucher amount cannot be Zero or Negative');
                Blockloaderhide();
                return;
            }

            var dr = deductionData.Reason;
            if (deductionData.TDSPercentage == 0 && frm != '27Q') {   ///////////// Threshold limit code not included.

                if (dr == 'Presc.Rt.' || dr == 'Lower Rt. Under Section 197 A' || dr == 'Non-Availability of PAN C' || dr == 'For software acquired under section 194J S' || dr == 'Deduction upto Rs. 50000/- in respect of interest income from deposits held by Senior Citizens u/s 80TTB R' || dr == 'deduction is on higher rate in view of section 206AB for non-filing of return of income U') {

                    showInfoAlert('TDS Rate cannot be Zero or Negative');
                    Blockloaderhide();
                    return;

                }
            }
            if (deductionData.TDSPercentage < 20 && dr == 'Non-Availability of PAN C') {
                showInfoAlert('PANNOTAVBL tds rate connot be less than 20%');
                Blockloaderhide();
                return;
            }

            if (deductionData.FormType == '27EQ') {
                if (deductionData.EstbInIndia == '0') {
                    showDangerAlert('For Nri, Establishment in India is mandatory');
                    Blockloaderhide();
                    return;
                }
                if (deductionData.BAC1A == '') {
                    showInfoAlert('Opting for I115BAC cannot be blank');
                    Blockloaderhide();
                    return;
                }

            }
            var c = $("[id*=txtCertNo]").val();

            if (c.length != 10 && c != '') {
                showDangerAlert('Incorrect Certificate number');
            }

            var st = '04/01/' + fy[0];
            var ed = '03/31/20' + fy[1];
            var vd = new Date;
            var s = new Date;
            var e = new Date;

            vd = moment(deductionData.VoucherDate).format('MM/DD/YYYY');
            s = moment(st);
            e = moment(ed);
            if (moment(vd) < moment(s)) {
                //$("[id*=txt_VoucherDate]").val('');
                showInfoAlert('Voucher date cannot be outside the Financial year');
                Blockloaderhide();
                return;
            }
            if (moment(vd) > moment(e)) {
                //$("[id*=txt_VoucherDate]").val('');
                showInfoAlert('Voucher date cannot be outside the Financial year');
                Blockloaderhide();
                return;
            }

            if (deductionData.PAN.length != 10) {
                showInfoAlert('PAN no should be 10 digit');
                Blockloaderhide();
                return;
            }

            ///////////////////////// Nri Validation
            if (frm == '27Q') {


                if (deductionData.NriTDSRT == 0) {
                    showInfoAlert('Tds Rate as per GOVT cannot be blank');
                    Blockloaderhide();
                    return;
                }
                if (deductionData.Reason == 0) {
                    showInfoAlert('Reasons cannot be blank');
                    Blockloaderhide();
                    return;
                }
                if (deductionData.DeducteeType == 0) {
                    showInfoAlert('Deductee type cannot be blank');
                    return;
                }
                if (deductionData.CountryId == 0) {
                    showInfoAlert('Nri Country cannot be blank');
                    Blockloaderhide();
                    return;
                }
                if (deductionData.BAC1A == '') {
                    showInfoAlert('Opting for I115BAC cannot be blank');
                    Blockloaderhide();
                    return;
                }

                if (deductionData.TDSPercentage <= 0) {   ///////////// Threshold limit code not included.
                    showInfoAlert('TDS Rate cannot be Zero or Negative');
                    Blockloaderhide();
                    return;
                }
                if ($("[id*=txtIncome]").val() == 0) {   ///////////// Threshold limit code not included.

                    showInfoAlert('TDS Amount cannot be Zero or Negative');
                    Blockloaderhide();
                    return;

                }

                if (deductionData.PAN == 'PANNOTAVBL') {
                    if (deductionData.Add1 == '') {
                        showInfoAlert('Address required for PANNOTAVBL');
                        Blockloaderhide();
                        return;
                    }
                    if (deductionData.Email == '') {
                        showInfoAlert('Email required for PANNOTAVBL');
                        Blockloaderhide();
                        return;
                    }
                    if (deductionData.ContactNo == '') {
                        showInfoAlert('Contact Number required for PANNOTAVBL');
                        Blockloaderhide();
                        return;
                    }
                }

                if (deductionData.ContactNo != '') {
                    if (deductionData.ContactNo.indexOf(' ') >= 0) {
                        showInfoAlert("Remove space and special chars from Contact Number ");
                        Blockloaderhide();
                        return;
                    }
                    var cnn = parseFloat(deductionData.ContactNo);
                    if (isNaN(cnn)) {
                        showInfoAlert("Contact Number should be numeric");
                        Blockloaderhide();
                        return;
                    }
                }
            }
            ///////////////////////// end Nri Validation


            if (deductionData.TDSPercentage > 0 && deductionData.TdsAmt == 0) {
                showDangerAlert('TDS Amount cannot be zero');
                Blockloaderhide();
                return;
            }
            if (deductionData.TDSPercentage < 0) {
                showDangerAlert('TDS Amount cannot be in negative');
                Blockloaderhide();
                return;
            }

            if (deductionData.ContactNo == '0' || deductionData.PAN == '' || deductionData.DeducteeId == '0' || deductionData.Reason == '0' || deductionData.Reason == '' ||
                deductionData.DeducteeType == '0' || deductionData.NatureId == '0' || deductionData.NatureSubId == '0' || deductionData.VoucherDate == '') {

                showInfoAlert("Deductee, Nature, Type, Reason, Date, Voucher Amt, Total Amt, Values Required");
                $("[id*=txtded]").css("background-color", "#FCE4EC");
                $("[id*=ddl_Reasons]").css("background-color", "#FCE4EC");
                $("[id*=ddl_Type]").css("background-color", "#FCE4EC");
                $("[id*=ddl_Nature]").css("background-color", "#FCE4EC");
                $("[id*=txt_VoucherDate]").css("background-color", "#FCE4EC");
                $("[id*=txtAmtPd]").css("background-color", "#FCE4EC");
                $("[id*=txtTDSRt]").css("background-color", "#FCE4EC");
                Blockloaderhide();
                return;
            }


            if (deductionData.IsNRI == 'true' && deductionData.RemittanceId == '0') {
                Blockloaderhide();
                showInfoAlert("For NRI Deductees Remittance is Required")
                Blockloaderhide();
                return;
            }

            if (chk == false && deductionData.TDSPercentage == '0') {
                showInfoAlert("Rate Required ")
                Blockloaderhide();
                return;
            }



            //////////////////// Validation Complete

            if (deductionData.FormType == '27EQ') {
                deductionData.IsNRI = false;
                deductionData.Nri27EQ = $("[id*=drpIsNri]").val();
                deductionData.EstbInIndia = $("[id*=drpEstInIndia]").val();
                deductionData.BAC1A = $("[id*=drpBAC]").val();



            }
            else if (deductionData.FormType == '27Q') {
                deductionData.IsNRI = true;
                deductionData.Nri27EQ = null;
                deductionData.BAC1A = $("[id*=drpBAC]").val();
            }
            else {
                deductionData.IsNRI = false;
                deductionData.Nri27EQ = null;
                deductionData.BAC1A = null;
            }



            //var MM = moment(vd).format('MM');
            if (deductionData.CountryId == '') {
                deductionData.CountryId = 0;
            }



            //////////////////////// Fetching Challan details
            //chlDT = chlDT.split('/');
            //chlDT = chlDT[2] + '/' + chlDT[0] + '/' + chlDT[1];
            //var chl = deductionData.chlid + '^' + deductionData.chlDT + '^' + deductionData.bsr;

            ///////////////////////// End of Challan


            if ($("[id*=ddlChallan]").val() == 0) {
                deductionData.ChallanId = 0;
            }
            var payload = {
                "deduction": deductionData,
                "Conn": Conn
            };

            //if (parseFloat($("[id*=hdnVoucherTotalAmount]").val()) > parseFloat($("[id*=hdnTotalAmount]").val())) {
            //    showWarningAlert("Tds amount should be less than challan amount");
            //    Blockloaderhide();
            //    return;
            //}
            //else {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/Voucher.asmx/SaveDeduction",
                //data: '{compid:' + compid + ',va:' + va + ',vr:' + vr + ',tds:' + tds + ',sur:' + sur + ',ces:' + ces + ',net:' + net + ', Conn:"' + Conn + '", rec:"' + rec + '", chl:"' + chl + '"}',
                data: JSON.stringify(payload),
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);

                    if (myList.length > 0) {
                        //if (parseFloat(myList[0].vid) > 0) {
                        showSuccessAlert('Voucher Saved Success')
                        RecMode = '';
                        Clearall();
                        GetAddedChallaninList(0);
                        //var o = document.getElementById("ddlChallan").length; //$("[id*=ddlChallan]").Option.length;
                        //if (o == 1) {
                        //    $("[id*=ddlChallan]").attr("disabled", true);
                        //}
                        //else {
                            $("[id*=ddlChallan]").attr("disabled", false);
                        //}
                    }
                    if (Mis == 'Mis') {
                        $("[id*=dvAddVoucher]").hide();
                        $("[id*=dv_VoucherModify]").show();
                        $("[id*=dgVoucherModify]").hide();
                        $("[id*=divMisMatch]").show();
                        $("[id*=divModify]").hide();
                        $("[id*=tdSearch]").hide();
                        var Q = $("[id*=drpQua]").val();
                        var F = $("[id*=drpForm]").val();
                        if (Q != '' && F != '') {
                            MisMatch_Vouchers(Q, F);
                        }
                    }
                    Blockloaderhide();
                },
                failure: function (response) {
                    Blockloaderhide();
                },
                error: function (response) {
                    Blockloaderhide();
                }
            });
            /*}*/
        }

        function Search_Grid(mth, pageIndex, Pagesize, d, ch, n) {
            Blockloadershow();
            var Conn = $("[id*=hdnConnString]").val();
            var c = $("[id*=hdnCompanyid]").val();
            var fltr = 0; ////$("[id*=ddl_typesrch]").val();
            var F = $("[id*=ddlForm]").val();
            var Q = $("[id*=ddltype]").val();
            var RecordCount = 0;
            var s = '';
            var UP = 0;

            if (ch == undefined) {
                ch = '';
            }
            if (d == undefined) {
                d = '0';
            }
            if (n == undefined) {
                n = '0';
            }
            s = '';
            //Ajax start
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/Voucher.asmx/ModifyGrd",
                data: '{c:' + c + ', mth:' + mth + ',pI:' + pageIndex + ',pS:' + Pagesize + ', Conn:"' + Conn + '", d:"' + d + '", n:"' + n + '", ch:"' + ch + '",  U:' + UP + ',fltr:"' + fltr + '",  F:"' + F + '",Q:"' + Q + '"}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    var tbl = '';
                    $("[id*=txtAmtpd1]").val(0.00);
                    $("[id*=txtTDS]").val(0.00);
                    $("[id*=dgVoucherModify] tr").empty();
                    tbl = tbl + "<thead>";
                    tbl = tbl + "<tr>";
                    tbl = tbl + "<th  style='text-align: center;' class='labelChange'>Sr No</th>";
                    tbl = tbl + "<th  style='text-align: center;' class='labelChange'>Payment Date</th>";
                    tbl = tbl + "<th  style='text-align: center;' class='labelChange'>Deductee</th>";
                    tbl = tbl + "<th  class='labelChange' style='text-align: left;'>PAN</th>";
                    tbl = tbl + "<th  class='labelChange' style='text-align: left;'>PANVerified</th>";
                    tbl = tbl + "<th  class='labelChange' style='text-align: left;'>Rate</th>";
                    tbl = tbl + "<th  style='text-align: center;' class='labelChange'>Section</th>";
                    tbl = tbl + "<th  style='text-align: center;' class='labelChange'>Amount Paid</th>";
                    tbl = tbl + "<th  style='text-align: center;' class='labelChange'>TDS</th>";
                    tbl = tbl + "<th style='text-align: center;' class='labelChange' >Chln No</th>";
                    tbl = tbl + "<th style='text-align: center;' class='labelChange' >Chln Paid</th>";
                    //tbl = tbl + "<th >Edit</th>";
                    tbl = tbl + "<th  class='padding5'>Sel <input type='checkbox' id='chkAll' name='chkAll' onclick='chkAllselect($(this))'></td></th>";
                    tbl = tbl + "</tr>";
                    tbl = tbl + "</thead>";
                    tbl = tbl + "<tbody>";
                    if (myList.length > 0) {
                        var amtlist = myList[0].LTDSgrid;
                        var j = '';
                        for (var i = 0; i < myList.length; i++) {
                            tbl = tbl + "<tr>";
                            tbl = tbl + "<td class='labelChange' style='width:5%; text-align: center; '>" + myList[i].SrNo + "</td>";
                            tbl = tbl + "<td style='text-align: center;' class='labelChange'>" + myList[i].PDate + "<input type='hidden' id='hdndid' value='" + myList[i].did + "' name='hdndid'></td>";
                            tbl = tbl + "<td style='text-align: left;' class='labelChange'><a href='#'  onclick='Edit_Rec($(this),0)' > " + myList[i].DName + "</a><input type='hidden' id='hdnvid' value='" + myList[i].vid + "' name='hdnvid'></td>";
                            tbl = tbl + "<td style='text-align: center;' class='labelChange'>" + myList[i].PanNO + "</td>";
                            if (myList[i].PanVer == 'Valid PAN') {
                                tbl = tbl + "<td style='text-align: center;' class='labelChange'><i class='icon-checkmark2 mr-3 icon-2x' style='color: green;' id='imgCPaid' name='imgCPaid'></td>";
                            }
                            else {
                                tbl = tbl + "<td style='text-align: center;' class='labelChange'><i class='icon-cross3 mr-3 icon-2x' style='color: red;' id='imgCNot' name='imgCNot'></td>";
                            }
                            tbl = tbl + "<td style='text-align: left;' class='labelChange'>" + myList[i].TdsRate + "</td>";
                            tbl = tbl + "<td style='text-align: center;' class='labelChange'>" + myList[i].sec + "</td>";
                            tbl = tbl + "<td style='text-align: right;' class='labelChange'>" + myList[i].AmtPaid + ".00</td>";
                            tbl = tbl + "<td style='text-align: right;' class='labelChange'>" + myList[i].TdsAmt + ".00</td>";
                            tbl = tbl + "<td style='text-align: center;' class='labelChange'>" + myList[i].BnkChl + "</td>";
                            if (parseFloat(myList[i].CPaid) > 0) {
                                tbl = tbl + "<td style='text-align: center;' class='labelChange'><i class='icon-checkmark2 mr-3 icon-2x' style='color: green;' id='imgCPaid' name='imgCPaid'><input type='hidden' id='hdnCid' value='" + myList[i].CPaid + "' name='hdnCid'></td>";
                            }
                            else {
                                tbl = tbl + "<td style='text-align: center;' class='labelChange'><i class='icon-cross3 mr-3 icon-2x' style='color: red;' id='imgCNot' name='imgCNot'><input type='hidden' id='hdnCid' value='" + myList[i].CPaid + "' name='hdnCid'></td>";
                            }
                            tbl = tbl + "<td style='text-align: center;' class='labelChange'><input type='checkbox' id='chkEjob' name='chkEjob' value='" + myList[i].vid + "' ></td></tr>";
                        };
                        tbl = tbl + "</tbody>";
                        $("[id*=dgVoucherModify]").append(tbl);
                        $("[id*=txtAmtpd]").val(amtlist[0].Amt);
                        $("[id*=txtTDS]").val(amtlist[0].TDS);

                        if (parseFloat(myList[0].Totalcount) > 0) {
                            RecordCount = parseFloat(myList[0].Totalcount);

                        }
                        $("[id*=dv_VoucherModify]").show();
                        $("[id*=tdSearch]").hide();
                        $("[id*=btnCancel]").hide();
                        Pager(RecordCount, mth, UP);
                        Blockloaderhide();
                    }

                    else {
                        tbl = tbl + "<tr>";
                        tbl = tbl + "<td  class='labelChange'></td>";
                        tbl = tbl + "<td  class='labelChange'></td>";
                        tbl = tbl + "<td  class='labelChange'>No Record Found !!!</td>";
                        tbl = tbl + "<td  class='labelChange'></td>";
                        tbl = tbl + "<td  class='labelChange'></td>";
                        tbl = tbl + "<td  class='labelChange'></td>";
                        tbl = tbl + "<td  class='labelChange'></td>";
                        tbl = tbl + "<td  class='labelChange'></td>";
                        tbl = tbl + "<td  class='labelChange'></td>";
                        tbl = tbl + "<td  class='labelChange'></td>";
                        tbl = tbl + "<td  class='labelChange'></td>";
                        tbl = tbl + "<td  class='labelChange'></td>";
                        tbl = tbl + "</tr>";
                        $("[id*=dgVoucherModify]").append(tbl);
                        Pager(0, mth, UP);
                    }


                    var x = $("[id*=hdnDEdit]").val();

                    if (x == '') {
                        // $("[id*=ddlSearchDeducteeName]").empty();
                        // var first = $("[id*=ddl_DeducterVoucherMonthEntries]");
                        // var second = $("[id*=ddlSearchDeducteeName]");
                        //var options = first[0].innerHTML;
                        // var options = second[0].innerHTML + options;
                        // second[0].innerHTML = options;

                        //$("[id*=ddlSearchDeducteeName]").append("<option value=''>--Select Deductee--</option>");
                        //for (var i = 0; i < myDrps.length; i++) {

                        //    $("[id*=ddlSearchDeducteeName]").append("<option value='" + myDrps[i].deducteeid + "'>" + myDrps[i].Dname + "</option>");

                        //}
                        $("[id*=hdnDEdit]").val('1');
                    }
                    Blockloaderhide();
                },
                failure: function (response) {
                    Blockloaderhide();
                },
                error: function (response) {
                    Blockloaderhide();
                }
            });
        }

        function Clearall() {
            $("[id*=txt_VoucherDate]").val('');
            $("[id*=txtDedDate]").val('');
            $("[id*=txt_TDSCert]").val('');
            $("[id*=txtPAN]").val('');
            $("[id*=txtCertNo]").val('');
            $("[id*=txtAmtPd1]").val('');
            $("[id*=txtTDSRt]").val('');
            $("[id*=txtIncome]").val('');
            $("[id*=txtsurc]").val('0.00');
            $("[id*=txtCess]").val('0.00');
            $("[id*=txtded]").val('');
            $("[id*=txtInvNo]").val('');
            $("[id*=txtAddress]").val('');
            $("[id*=txtEmail]").val('');
            $("[id*=txtContact]").val('');
            $("[id*=txtIncome]").val('');
            $("[id*=txtTotal]").val('0.00');
            $("[id*=txtChallanTdsNC]").val('0.00');
            $("[id*=txtChallanDedAmt]").val('0.00');
            $("[id*=txtChallanDiffAmt]").val('0.00');
            $("[id*=txtChallaDt]").val('');
            $("[id*=txtTotal]").val('');
            $("[id*=txtContact]").val('');
            $("[id*=txtIdent]").val('');
            $("[id*=ddl_ChallanBSRCodes]").val('0');

            $("[id*=ddl_Type]").val(0);
            $("[id*=ddl_Type]").trigger('change');
            $("[id*=ddl_Nature]").val(0);
            $("[id*=ddl_Nature]").trigger('change');
            $("[id*=drpBranch]").val(0);
            $("[id*=drpBranch]").trigger('change');
            $("[id*=drpRemit]").val(0);
            $("[id*=drpRemit]").trigger('change');
            $("[id*=drpCountry]").val(0);
            $("[id*=drpCountry]").trigger('change');
            vMod = 'hide';
            $("[id*=hdnDedId]").val('');
            $("[id*=hdnSrchDed]").val('');
            $("[id*=txtded]").val('');
            $("[id*=txtSearchDeducteeName]").val('');
            $("[id*=txt_VoucherDate]").val('');
            $("[id*=txtChallan]").val('');
            $("[id*=ddl_Reasons]").val(0);
            $("[id*=txt_TDSCert]").val('');
            $("[id*=ddl_Type]").val('');
            $("[id*=txtPAN]").val('');
            $("[id*=txtInvNo]").val('');
            $("[id*=drpBranch]").val(0);
            $("[id*=drpRemit]").val(0);
            $("[id*=txtAmtPd]").val('0.00');
            $("[id*=txtTDSRt]").val('0.00');
            $("[id*=txtIncome]").val('0.00');
            $("[id*=txtsurc]").val('0.00');
            $("[id*=txtCess]").val('0.00');
            $("[id*=txt_NetAmount3]").val('0.00');
            $("[id*=txtTotal]").html('0.00');
            $("[id*=hdnVoucherID]").val(0);
            $("[id*=hdnNatureSubID]").val('');
            $("[id*=hdnisNri]").val('');
            $("[id*=hdnSel]").val(0);
            $("[id*=hdnNatureFromType]").val('');
            $("[id*=hdnChallanId]").val('0');
            $("[id*=txtded]").css("background-color", "");
            $("[id*=ddl_Reasons]").css("background-color", "");
            $("[id*=ddl_Type]").css("background-color", "");
            $("[id*=ddl_Nature]").css("background-color", "");
            $("[id*=txt_VoucherDate]").css("background-color", "");
            $("[id*=txtAmtPd]").css("background-color", "");
            $("[id*=txtTDSRt]").css("background-color", "");
            $("[id*=txtBankChinNo]").css("background-color", "");
            $("[id*=txtChinDate]").css("background-color", "");
            $("[id*=ddl_BSRCodes]").css("background-color", "");
            $('[id*=txtChlTDS]').css("background-color", "");
            $("[id*=hdnVoucherTotalAmount]").val(0.00);
            $("[id*=hdnTotalAmount]").val(0.00)
        }

        function setAllControlsNumericFormat() {
            $(".decimal").each(function () {
                if (!isNaN($(this).val()) && $(this).val() != '')
                    $(this).val(parseFloat($(this).val()).toFixed(2));

                if ($(this).val() == '')
                    $(this).val('0.00');
            });
        }

        function setNumericFormat(ctrl) {
            //$(".spanwithno").each(function () {
            //    $(this).html(AddComma($(this).html()));
            //});
            //$(".decimal").each(function () {
            //    //var i = $(this).val();
            //    //var checkdot = i.split('.');
            //    //if (checkdot.length == 1) {
            //    //    $(this).val(AddComma($(this).val()));
            //    //}
            //    if (!isNaN($(this).val())) 
            //        $(this).val(parseFloat($(this).val()).toFixed(2));                
            //});

            //$(".decimal").each(function () {
            //var i = $(this).val();
            //var checkdot = i.split('.');
            //if (checkdot.length == 1) {
            //    $(this).val(AddComma($(this).val()));
            //}

            if (ctrl != null && ctrl != undefined && !isNaN(ctrl[0].value))
                ctrl.val(parseFloat(ctrl.val()).toFixed(2));
        }

        function AddComma(i) {
            if (i == null || i == undefined || i == '' || isNaN(i))
                i = 0;
            i = formatNumber(i);
            var checkdot = i.split('.');
            if (checkdot.length == 1) i = i + ".00";
            return i;
        }

        function formatNumber(num) {
            var n1, n2;
            num = num + '' || '';
            // works for integer and floating as well
            n1 = num.split('.');
            n2 = n1[1] || null;
            n1 = n1[0] //.replace(/(\d)(?=(\d\d)+\d$)/g, "$1,");
            num = n2 ? n1 + '.' + n2 : n1;
            return num;
        }

        ///////////////////////////// Challan

        function CalculateTotal() {
            var grandtotal = 0; // $('[id*=txtChTotal]').val();
            var tds = $('[id*=txtChlTDS]').val();
            var sur = $('[id*=txtChSur]').val();
            var cess = $('[id*=txtChlCess]').val();
            var int = $('[id*=txtChInt]').val();
            var oth = $('[id*=txtChlOth]').val();
            var fee = 0
            if (isNaN(parseFloat(tds))) {
                tds = 0;
            }
            if (isNaN(parseFloat(sur))) {
                sur = 0;
            }
            if (isNaN(parseFloat(cess))) {
                cess = 0;
            }
            if (isNaN(parseFloat(int))) {
                int = 0;
            }
            if (isNaN(parseFloat(oth))) {
                oth = 0;
            }
            var grandtotal = parseFloat(tds) + parseFloat(sur) + parseFloat(cess) + parseFloat(int) + parseFloat(oth);

            //var chl = 0
            //var chldt = ''
            //var bsr = ''
            $('[id*=txtChTotal]').val(grandtotal);

        }

        function Select_Chln(i) {
            var row = i.closest("tr");
            var Cid = row.find("input[name=hdnCid]").val();
            var DAmt = $("[id*=DTAmt]").html(); //row.find("input[name=hdnDAmt]").val();


            var sur = row.find("input[name=hdncSur]").val();
            var int = row.find("input[name=hdncInt]").val();
            var cess = row.find("input[name=hdncCess]").val();
            var oth = row.find("input[name=hdncOth]").val();
            var C = row.children('td:eq(0)').text();
            var DT = row.find("td").eq(1).text();
            var BSR = row.find("td").eq(2).text();
            var TDS = row.find("td").eq(3).text();
            var CBAL = row.find("td").eq(6).text();
            var Con = row.find("td").eq(5).text();
            $("[id*=lblCons]").html(Con);
            $("[id*=CBalAmt]").html(CBAL);
            $("[id*=hdnChallanId]").val(Cid);
            $("[id*=lblCno]").html(C);
            $("[id*=lblCdt]").html(DT);
            $("[id*=CTAmt]").html(TDS);
            $("[id*=mdlChlnDtds]").show();
            var Bal = parseFloat(CBAL) - parseFloat(DAmt);
            if (Bal < 0) {
                showDangerAlert('Challan Amt already used, Select another challan');
                return;
            }
        }

        function Fill_Challan_DropDowns() {
            var compId = $("[id*=hdnCompanyid]").val();
            var quarter = $("[id*=ddltype]").val();
            var formType = $("[id*=ddlForm]").val();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/Voucher.asmx/GetChallansByCompId",
                data: '{ compId:' + compId + ', formType: "' + formType + '", quarter: "' + quarter + '" }',
                dataType: "json",
                success: function (msg) {
                    var data = jQuery.parseJSON(msg.d);

                    ////// fill ChlLst for future use
                    Chllst = data;

                    $("[id*=ddlChallan]").empty();
                    var opt = new Option('--Select--', 0, true, true);
                    $("[id*=ddlChallan]").append(opt);//.trigger('change');

                    for (var i = 0; i < data.length; i++) {
                        $("[id*=ddlChallan]").append("<option value='" + data[i].ChallanID + "'>" + data[i].ChallanNo + "</option>");
                    }

                    //if (selectChallanId != null && selectChallanId > 0) {
                    //    $("[id*=ddlChallan]").val(selectChallanId);
                    //    let objChallan = data.find(o => o.ChallanID === selectChallanId);
                    //    $("[id*=ddl_ChallanBSRCodes]").val(objChallan.BankId);
                    //    $("[id*=txtChallanTdsNC]").val(objChallan.Total);
                    //    $("[id*=txtChallaDt]").val(objChallan.ChallanDate);
                    //}
                    //else {
                    //    $("[id*=ddlChallan]").val(0);
                    //    //$("[id*=ddlChallan]").trigger('change');
                    //    $("[id*=ddl_ChallanBSRCodes]").val('0');
                    //    $("[id*=ddl_ChallanBSRCodes]").trigger('change');
                    //    $("[id*=txtChallanTdsNC]").val('0.00');
                    //}
                },
                failure: function (response) {
                    Blockloaderhide();
                },
                error: function (response) {
                    Blockloaderhide();
                }
            });
        }

        function get_SelectedVoucherChallan(Cid, Vid) {
            // var row = i.closest("tr");
            var compid = $("[id*=hdnCompanyid]").val();
            $("[id*=hdnVoucherTotalAmount]").val(0.00);
            $("[id*=hdnTotalAmount]").val(0.00)
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/Voucher.asmx/get_SelectedVoucherChallan",
                data: '{Cid: ' + Cid + ', Vid: ' + Vid + '}',
                dataType: "json",
                success: function (msg) {
                    var myList = '';
                    myList = jQuery.parseJSON(msg.d);
                    var challandata = myList[0];

                    if (challandata != undefined && challandata != null) {

                        //var ChDT = challandata.ChallanDate;
                        //var yy = ChDT.substr(6, 4);
                        //var mm = ChDT.substr(3, 2);
                        //var dd = ChDT.substr(0, 2);
                        //ChDT = yy + '-' + mm + '-' + dd;

                        $("[id*=hdnChallanId]").val(challandata.ChallanID);
                        $("[id*=ddlChallan]").val(challandata.ChallanID);
                        $("[id*=ddlChallan]").trigger('change');
                        $("[id*=txtChallaDt]").val(challandata.ChallanDate);
                        $("[id*=ddl_ChallanBSRCodes]").val(challandata.BankId);
                        $("[id*=ddl_ChallanBSRCodes]").trigger('change');
                        //$("[id*=txtChallanTdsNC]").val(challandata.Tds);

                        var Camt = parseFloat(challandata.TDS) + parseFloat(challandata.Sur) + parseFloat(challandata.Cess);
                        $("[id*=txtChallanTdsNC]").val(Camt);
                        $("[id*=txtChallanDedAmt]").val(challandata.VoucherTotal);

                        $("[id*=txtChallanDiffAmt]").val(parseFloat(Camt) - parseFloat(challandata.VoucherTotal));

                        //$("[id*=txtChallanDedAmt]").val(challandata.VoucherTotal);
                        //$("[id*=txtChallanDiffAmt]").val(challandata.CTotal - challandata.VoucherTotal);

                        //var Camt = parseFloat(challandata.TDS) + parseFloat(challandata.Sur) + parseFloat(challandata.Cess);
                        $("[id*=hdnChlTDSAmt]").val(Camt);
                        //var damt = challandata.CTotal;
                        //var CBal = parseFloat(Camt) - parseFloat(damt);
                        //CBal = CBal + '.00';
                        //damt = damt + '.00';



                        //calulate amounts
                        var voucherTotalAmount = $("[id*=txtTotal]").val();
                        var ConsumedAmt = $("[id*=txtChallanDedAmt]").val();
                        if (ConsumedAmt == '' || ConsumedAmt == undefined) {
                            ConsumedAmt = 0;
                        }

                        var totalAmount = 0; //challandata.Camt - challandata.VoucherTotal;
                        $("[id*=hdnVoucherTotalAmount]").val(voucherTotalAmount);
                        $("[id*=hdnTotalAmount]").val(totalAmount);

                        if (RecMode == 'Add') {
                            totalAmount = parseFloat(Camt) - (parseFloat(voucherTotalAmount) + parseFloat(ConsumedAmt));
                            if (totalAmount < 0) {
                                $('[id*=txtIncome]').val(0);
                                $('[id*=txtsurc]').val(0);
                                $('[id*=txtCess]').val(0);
                                $('[id*=txtTotal]').val(0);
                                $('[id*=hdntxtTotal]').val(0);
                                $('[id*=hdnNewVoucherTotal]').val(0);
                                showPrimaryAlert('Voucher Total cannot be more than Challan TDS Amount');
                            }
                        }
                        else {
                            /////////////// delete old voucher amt from challan
                            totalAmount = parseFloat(Camt) - parseFloat(challandata.VoucherAmt);
                            /////////////// add current voucher amt in challan and check the difference

                            totalAmount = parseFloat(Camt) - parseFloat(voucherTotalAmount);
                            if (totalAmount < 0) {
                                showPrimaryAlert('Voucher Total cannot be more than Challan TDS Amount');
                            }
                        }
                        if (RecMode != '') {
                            RecMode = '';
                        }
                        setAllControlsNumericFormat();
                    }
                    Blockloaderhide();
                },
                failure: function (response) {
                    Blockloaderhide();
                },
                error: function (response) {
                    Blockloaderhide();
                }
            });
        }

        function isNumberKey(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 46 || charCode > 57)) {
                return false;
            }
            return true;
        }

        function UnMatchedVchr() {
            //// $("[id*=btnChlnMap]").attr("disabled", false);     ******
            //// $("[id*=btnRmChlnMap]").attr("disabled", true);    ******
            $("[id*=btnChlnMap]").show();
            $("[id*=btnRmChlnMap]").hide();

            ModifyGrid(0, 1, 200, 1);
        }

        function getCaptcha() {
            //get Captcha       
            Blockloadershow();
            $.ajax({
                type: "POST",
                url: "TService.asmx/tCaptcha",
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                success: function (data) {
                    var result = JSON.parse(data.d);
                    Cookies = result[0]["Cookie"];
                    document.getElementById("captchaImg").src = result[0]["base64"];
                    Blockloaderhide();
                    /* $("#tblCaptcha").show();*/
                },
                failure: function (response) {
                    Blockloaderhide();
                    showWarningAlert(response.d);
                }
            });

        }

        function loadLoginDetails() {
            $("[id*=dvTracesuserDe]").hide();
            Blockloadershow();
            $.ajax({
                type: "POST",
                url: "TService.asmx/Get_tracesLoginDetails",
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                success: function (data) {
                    var result = JSON.parse(data.d);
                    if (result.error) {
                        showWarningAlert(result.error);
                        $("[id*=dvTracesuserDe]").show();
                        $("[id*=dvCaptcha]").hide();
                        return false;
                    }
                    else {
                        //loop Challan Details
                        var dt_Login = JSON.parse(result["dt_Login"]);
                        if (dt_Login.length > 0) {
                            var Login_dtls = dt_Login[0];
                            $("#TANID").val(Login_dtls["Tan"]);
                            $("#txtUserID").val(Login_dtls["User_ID"]);
                            $("#txtPassword").val(Login_dtls["Password"]);
                        }
                        else {

                            $("#TANID").val($("[id*=txtTanNo]").val());
                            $("[id*=dvTracesuserDe]").show();
                            $("[id*=dvCaptcha]").hide();
                        }
                        Blockloaderhide();

                    }
                },
                failure: function (response) {
                    Blockloaderhide();
                    showWarningAlert(response.d);
                }
            });

        }

        function GetConsumption() {

            var UserID = $("#txtUserID").val();
            var Password = $("#txtPassword").val();
            var TAN_NO = $("#TANID").val();
            var compid = $("[id*=hdnCompanyid]").val();
            var CaptchaCode = $("#captcha").val();

            var Currentdt = new Date();
            var dd = Currentdt.getDate();
            var mm = Currentdt.toLocaleString('en-US', { month: 'short' });
            var yy = Currentdt.getFullYear();
            var FY = $("[id*=ddlFinancialYear] :selected").text()
            var fyy = FY.split('_')[0];

            if (dd < 10) {
                dd = '0' + dd;
            }
            //if (mm < 10) {
            //    mm = '0' + mm;
            //}
            // fyy = fyy.toString().slice(-2);
            var d = '01';
            var m = 'Apr';
            d = d.toString();
            m = m.toString();
            fyy = fyy.toString();
            dd = dd.toString();
            mm = mm.toString();
            yy = yy.toString();

            var frm = d + '-' + m + '-' + fyy; //  '01-Apr-2023';
            var to = dd + '-' + mm + '-' + yy;  //$("[id*=txt_to]").val();
            var sts = 'All'; //$("[id*=drpSts]").val();

            var Q = $("[id*=ddltype]").val();
            var F = $("[id*=ddlForm]").val();
            if ((UserID == null || UserID == "") || (Password == null || Password == "")) {
                showWarningAlert('Enter User Login Details');
                return false;
            }


            if (TAN_NO == null || TAN_NO == undefined) {
                showWarningAlert('TAN - Cannot be Blank');
                return false;
            }
            var rTkn = $("[id*=hdnPRN]").val();
            if (rTkn == '') {
                showWarningAlert('Provisional Reciept Number Required');
                return false;
            }
            var tracesData = {
                "objTraceData": {
                    PRN_NO: rTkn,
                    ChallanStatus: sts,
                    FromDT: frm,
                    ToDate: to,
                    Compid: compid,
                    Quarter: Q,
                    Forms: F

                },
                "objLogin": {
                    UserID: UserID,
                    Password: Password,
                    TAN: TAN_NO,
                    CaptchaCode: CaptchaCode,
                    Cookie: Cookies
                }
            };
            $("[id*=lblProcess]").show();
            $("[id*=lblSuccess]").hide();

            /*$(".MastermodalBackground2").show();*/
            document.getElementById("btnGetRequest").disabled = true;

            //debugger;
            $.ajax({
                type: "POST",
                url: "TService.asmx/Challan_Consumpution",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify(tracesData),
                success: function (data) {
                    document.getElementById("btnGetRequest").disabled = false;
                    /*  modal_ChallanVerify.hide();*/
                    Blockloaderhide();
                    var result = JSON.parse(data.d);
                    if (result.error) {
                        $("#captcha").val("");
                        //getCaptcha();

                        showWarningAlert(result.error);
                        $("[id*=lblSuccess]").hide();
                        $("[id*=lblProcess]").hide();

                        return false;
                    }
                    else {
                        if (result.success) {
                            $("[id*=lblSuccess]").show();
                            $("#captcha").val("");

                            //var btn = document.getElementById("ctl00_MasterPage_btnGenerateTextFile");
                            //document.getElementById("ctl00_MasterPage_btnGenerateTextFile").style.display = "block";
                            //btn.click();

                        }
                        if (result.timeout) {
                            $("#captcha").val("");
                            $("[id*=lblProcess]").hide();
                            $("[id*=lblSuccess]").hide();
                            return false;
                        }
                        if (result.Failed) {
                            showWarningAlert(response.d);
                            $("[id*=lblProcess]").hide();
                            $("[id*=lblSuccess]").hide();
                        }
                    }
                },
                failure: function (response) {
                    $("#captcha").val("");
                    //getCaptcha();
                    document.getElementById("btnGetRequest").disabled = false;
                    /*$(".MastermodalBackground2").hide();*/
                    showWarningAlert(response.d);
                    $("[id*=lblProcess]").hide();
                    $("[id*=lblSuccess]").hide();
                }
            });
            return false;
        }

        RequestTrace = function () {
            var rq = $("[id*=hdnReqst]").val();
            if (rq == 'Con') {
                GetConsumption();
            }
            else {
                var UserID = $("#txtUserID").val();
                var Password = $("#txtPassword").val();
                var TAN_NO = $("#TANID").val();
                var compid = $("[id*=hdnCompanyid]").val();
                var CaptchaCode = $("#captcha").val();

                var Currentdt = new Date();
                var dd = Currentdt.getDate();
                var mm = Currentdt.toLocaleString('en-US', { month: 'short' });
                var yy = Currentdt.getFullYear();
                var FY = $("[id*=ddlFinancialYear] :selected").text()
                var fyy = FY.split('_')[0];

                if (dd < 10) {
                    dd = '0' + dd;
                }
                //if (mm < 10) {
                //    mm = '0' + mm;
                //}
                // fyy = fyy.toString().slice(-2);
                var d = '01';
                var m = 'Apr';
                d = d.toString();
                m = m.toString();
                fyy = fyy.toString();
                dd = dd.toString();
                mm = mm.toString();
                yy = yy.toString();



                var frm = d + '-' + m + '-' + fyy; //  '01-Apr-2023';
                var to = dd + '-' + mm + '-' + yy;  //$("[id*=txt_to]").val();
                var sts = 'All'; //$("[id*=drpSts]").val();

                var Q = $("[id*=ddltype]").val();
                var F = $("[id*=ddlForm]").val();
                if ((UserID == null || UserID == "") || (Password == null || Password == "")) {
                    showWarningAlert('Enter User Login Details');
                    return false;
                }


                if (TAN_NO == null || TAN_NO == undefined) {
                    showWarningAlert('TAN - Cannot be Blank');
                    return false;
                }


                var tracesData = {
                    "objTraceData": {
                        ChallanStatus: sts,
                        FromDT: frm,
                        ToDate: to,
                        Compid: compid,
                        Quarter: Q,
                        Forms: F

                    },
                    "objLogin": {
                        UserID: UserID,
                        Password: Password,
                        TAN: TAN_NO,
                        CaptchaCode: CaptchaCode,
                        Cookie: Cookies
                    }
                };
                $("[id*=lblProcess]").show();
                $("[id*=lblSuccess]").hide();

                /* $(".MastermodalBackground2").show();*/
                document.getElementById("btnGetRequest").disabled = true;

                //debugger;
                $.ajax({
                    type: "POST",
                    url: "TService.asmx/Challan_Traces",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify(tracesData),
                    success: function (data) {
                        document.getElementById("btnGetRequest").disabled = false;
                        /*  modal_ChallanVerify.hide();*/
                        Blockloaderhide();
                        var result = JSON.parse(data.d);
                        if (result.error) {
                            $("#captcha").val("");
                            //getCaptcha();

                            showWarningAlert(result.error);
                            $("[id*=lblSuccess]").hide();
                            $("[id*=lblProcess]").hide();

                            return false;
                        }
                        else {
                            if (result.success) {
                                $("[id*=lblSuccess]").show();
                                $("#captcha").val("");

                                //var btn = document.getElementById("ctl00_MasterPage_btnGenerateTextFile");
                                //document.getElementById("ctl00_MasterPage_btnGenerateTextFile").style.display = "block";
                                //btn.click();

                            }
                            if (result.timeout) {
                                $("#captcha").val("");
                                $("[id*=lblProcess]").hide();
                                $("[id*=lblSuccess]").hide();
                                return false;
                            }
                            if (result.Failed) {
                                showWarningAlert(response.d);
                                $("[id*=lblProcess]").hide();
                                $("[id*=lblSuccess]").hide();
                            }
                        }
                    },
                    failure: function (response) {
                        $("#captcha").val("");
                        //getCaptcha();
                        document.getElementById("btnGetRequest").disabled = false;
                        /* $(".MastermodalBackground2").hide();*/
                        showWarningAlert(response.d);
                        $("[id*=lblProcess]").hide();
                        $("[id*=lblSuccess]").hide();
                    }
                });
                return false;
            }
        }

    </script>

    <style type="text/css">
        .rightAligned {
            text-align: right;
        }

        .Pager b {
            margin-top: 2px;
            margin-left: 5px;
            float: left;
            padding-right: 50%;
            padding-top: 8px;
            width: 70%;
            text-align: center !important;
        }

        .Pager span {
            background-color: #26A69A;
            z-index: 1;
            color: #fff;
            border-color: #26a69a;
            /*/*position: relative;*/
            overflow: hidden;
            text-align: center;
            min-width: 2.8rem;
            transition: all ease-in-out .15s;
            /*display: block;*/
            padding: .5rem 1rem;
            line-height: 1.5385;
            border-radius: 10rem;
            margin-right: 3px;
            text-align: center !important;
        }

        .Pager a {
            background-color: #eee;
            z-index: 1;
            color: #fff;
            border-color: #26a69a;
            position: relative;
            overflow: hidden;
            text-align: center;
            min-width: 2.8rem;
            transition: all ease-in-out .15s;
            /*display: block;*/
            padding: .5rem 1rem;
            line-height: 1.5385;
            border-radius: 10rem;
            margin-right: 3px;
            text-align: center !important;
        }

        .Pager {
            margin-bottom: 0;
            background-color: #fff;
            border-color: #fff;
            margin-left: 2px;
            /*border-radius: 0.1875rem;*/
            display: flex;
            padding-left: 0;
            height: 40px;
            text-align: center !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:HiddenField ID="hdnCompanyid" runat="server" />
    <asp:HiddenField ID="hdnVAmt" runat="server" />
    <asp:HiddenField ID="hdnChlTDSAmt" runat="server" />
    <asp:HiddenField ID="hdnReqst" runat="server" />
    <asp:HiddenField ID="hdnisNri" runat="server" />
    <asp:HiddenField ID="hdnQuater" runat="server" />
    <asp:HiddenField ID="hdnNatureFromType" runat="server" />
    <asp:HiddenField ID="hdnNatureID" runat="server" />
    <asp:HiddenField ID="hdnNatureSubID" runat="server" />
    <asp:HiddenField ID="hdnPRN" runat="server" />
    <asp:HiddenField ID="hdnVoucherID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnSel" runat="server" Value="0" />

    <asp:HiddenField ID="hdnChallanId" runat="server" Value="0" />
    <asp:HiddenField ID="hdntxtTotal" runat="server" />
    <asp:HiddenField ID="hdnSection" runat="server" />
    <asp:HiddenField ID="hdnConnString" runat="server" />
    <asp:HiddenField ID="hdnPages" runat="server" />
    <asp:HiddenField ID="hdnDSrch" runat="server" />
    <asp:HiddenField ID="hdnSrchDed" runat="server" />
    <asp:HiddenField ID="hdnDName" runat="server" />
    <asp:HiddenField ID="hdnDedId" runat="server" />
    <asp:HiddenField ID="hdnDEdit" runat="server" />
    <asp:HiddenField ID="hdnDate" runat="server" />
    <asp:HiddenField ID="hdnDrps" runat="server" />
    <asp:HiddenField ID="hdnMis" runat="server" />
    <asp:HiddenField ID="hdnForm" runat="server" />
    <asp:HiddenField ID="hdnLnk" runat="server" />
    <asp:HiddenField ID="hdnChlnSel" runat="server" />
    <asp:HiddenField ID="hdnNewVoucherTotal" runat="server" />
    <asp:HiddenField ID="hdnVoucherTotalAmount" runat="server" />
    <asp:HiddenField ID="hdnTotalAmount" runat="server" />
    <asp:HiddenField ID="hndCurrmth" runat="server" />

    <div>
        <div class="row" style="height: 10px;"></div>

        <div class="content-header">
            <div class="content">
                <div class="card">
                    <div class="row mb-2" style="align-items: center;">
                        <div class="col-sm-2">
                            <h5><span id="spnPG" class="font-weight-bold">Deduction Details</span></h5>
                        </div>
                        <div class="col-sm-2">
                            <select id="ddlForm" class="form-control select select2-hidden-accessible">
                                <option value="26Q" style="font-weight: bold;">26Q</option>
                                <option value="27Q" style="font-weight: bold;">27Q(NRI)</option>
                                <option value="27EQ" style="font-weight: bold;">27EQ(TCS)</option>
                            </select>
                        </div>
                        <div class="col-0.5" style="margin-left: 10px;">
                            <select id="ddltype" class="form-control select select2-hidden-accessible">
                                <option value="Q1" style="font-weight: bold;">Q1</option>
                                <option value="Q2" style="font-weight: bold;">Q2</option>
                                <option value="Q3" style="font-weight: bold;">Q3</option>
                                <option value="Q4" style="font-weight: bold;">Q4</option>
                            </select>
                        </div>
                        <div style="margin-left: 365px;">
                            <button id="btndwnd" name="btndwnd" class="btn btn-warning legitRipple" type="button"
                                onclick="window.open('https://eportal.incometax.gov.in/iec/foservices/#/download-csi-file/tan-user-details','_blank')">
                                <b><i class="icon-file-download mr-1 icon-1x"></i></b>Download CSI File</button>
                        </div>
                        <div style="margin-left: 17px;">
                            <a href="../../Admin/EReturns_NonSalary.aspx" id="btnProcess" name="btnProcess" class="btn btn-success legitRipple" type="button"><b><i class="fas fa-check mr-2 fa-1x"></i></b>Generate Return</a>
                            <%--  <button id="btnChkError" name="btnChkError" class="btn btn-outline-success legitRipple" type="button"><b><i class="mi-sync-problem mr-1 mi-1x"></i></b>Check Errors</button>--%>
                            <button id="btnSave" name="btnSave" class="btn btn-outline-success legitRipple" type="button"><b><i class="mi-save"></i></b>Save</button>
                            <button id="btnVoucherCancel" name="btnVoucherCancel" class="btn btn-outline-success legitRipple" type="button"><b><i class="fa fa-arrow-left mr-2 fa-1x"></i></b>Back</button>
                        </div>
                        <div class="col-1" style="margin-left: 130px;">
                            <button id="btnCancel" value="Cancel" class="btn btn-outline-success legitRipple" type="button"><i class="fa fa-arrow-left mr-2 fa-1x"></i>Back</button>
                        </div>
                        <div class="ShowPage" id="drpPerPage">
                            <select id="ddlperpage" class="form-control select select2-hidden-accessible">
                                <option value="200">200</option>
                                <option value="400">400</option>
                                <option value="600">600</option>
                                <option value="800">800</option>
                                <option value="1000">1000</option>
                                <option value="1500">1500</option>
                                <option value="2000">2000</option>
                            </select>
                        </div>
                        <div class="col-1" style="margin-left: -69px;">
                            <button id="btnChlCancel" value="Cancel" class="btn btn-outline-success legitRipple" type="button"><i class="fa fa-arrow-left mr-2 fa-1x"></i>Back</button>
                        </div>
                        <div class="col-1.5" id="drpCPerPage">
                            <select id="ddlCperpage" class="form-control select select2-hidden-accessible">
                                <option value="200">200</option>
                                <option value="400">400</option>
                                <option value="600">600</option>
                                <option value="800">800</option>
                                <option value="1000">1000</option>
                                <option value="1500">1500</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="row" id="tdSearch">
                    <div class="col-md-7">
                        <div class="card card-info" id="cr_chln" style="height: auto;">
                            <div class=" card-header" style="padding-top: 5px;">
                                <h5>
                                    <label class="card-title">List of Challans</label>
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="form-group row">
                                    <div class="col-5">
                                        <input id="" name="" type="text" class="form-control form-control-border" value="" placeholder="Search Challan.... " />
                                    </div>
                                    <div style="margin-left: auto;">
                                        <button id="btnChlAdd" type="button" class="btn btn-secondary"><i class="fas fa-plus mr-1 fa-1x"></i>Challan</button>
                                        <button id="VryChln" type="button" class="btn btn-success"><i class="fas fa-check mr-2 fa-1x"></i>Verify Challan</button>

                                    </div>
                                </div>
                                <div class="row">
                                    <div class="table-responsive" style="height: 350px;">
                                        <table id="tblChallan" class="table table-hover table-bordered  table-sm font-size-base   dataTable dtr-inline table-head-fixed "></table>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="col-md-5">

                        <div class="card card-info" id="cr_Vou" style="height: auto;">
                            <div class=" card-header" style="padding-top: 5px;">
                                <h5>
                                    <label class="card-title">Voucher / Deduction</label>
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="form-group row">
                                    <div style="margin-left: auto;">
                                        <button id="btnAdd" type="button" class="btn btn-secondary"><i class="fas fa-plus mr-1 fa-1x"></i>Voucher</button>

                                    </div>
                                </div>

                                <div class="row">
                                    <div class="table-responsive" style="height: 350px;">
                                        <table id="dgVoucherEntries" class="table table-bordered table-hover  table-xs font-size-base   dataTable dtr-inline table-head-fixed"></table>
                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>
            </div>
        </div>
        <div class="content-header">
            <div id="dv_VoucherModify" class="card">
                <div id="divModify" class="card-body">
                    <div class="" runat="server" id="dvFltr" style="padding-top: 0px;">
                        <div class="form-group row">
                            <div class="col-2">
                                <input id="txtSearchDeducteeName" name="txtSearchDeducteeName" type="text" class="form-control form-control-border" value="" placeholder=" Search Deductee..." />
                            </div>

                            <div class="col-1" style="padding-top: 8px;">
                                <label class=" col-form-label font-weight-bold">Filter Date:</label>
                            </div>
                            <div class="col-lg-1.5">
                                <input id="txtStart" type="date" class="form-control form-control-border" placeholder="dd/MM/yyyy" />
                            </div>
                            &nbsp;&nbsp;  &nbsp;&nbsp;
                                <div class="col-lg-1.5">
                                    <input id="txtend" type="date" class="form-control form-control-border" placeholder="dd/MM/yyyy" />
                                </div>


                            &nbsp;&nbsp;
                                <div class="col-1" style="padding-top: 8px;">
                                    <label class=" col-form-label font-weight-bold">Deduct.Tot</label>
                                </div>
                            <div class="col-2">
                                <input type="text" id="txtAmtpd1" name="txtAmtpd1" class="form-control form-control-border " style="text-align: right; font-size: 20px; font-weight: bold; color: green;" disabled />
                            </div>
                            &nbsp;&nbsp;
                                <div class="col-1" style="padding-top: 8px;">
                                    <label class="col-form-label font-weight-bold">Total TDS</label>
                                </div>
                            <div class="col-2">
                                <input type="text" id="txtTDS" name="txtTDS" class="form-control form-control-border " style="text-align: right; font-size: 20px; font-weight: bold; color: red;" disabled />
                            </div>
                        </div>
                        <div class="form-group row">
                            <div id="dvbtnChln" class="col-3">
                                <button type="button" class="btn btn-block btn-warning btn-sm" id="btnChlnMap" name="btnChlnMap"><i class="fas fa-plus mr-1 fa-1x"></i>Add to Existing Challan</button>
                            </div>
                            <div id="dvNewAddChl" class="col-2">
                                <button type="button" class="btn btn-block btn-success btn-sm" id="btnNAddMapChl" name="btnNAddMapChl"><i class="fas fa-plus mr-1 fa-1x"></i>Add to New Challan</button>
                            </div>
                            <div id="dvbtnRmChln" class="col-2">
                                <button type="button" class="btn btn-block btn-outline-danger btn-sm" id="btnRmChlnMap" name="btnRmChlnMap"><i class="fas fa-trash"></i>Remove from Challan</button>
                            </div>

                            <div id="dvdelete" class="col-3">
                                <button type="button" class="btn btn-block btn-outline-danger btn-sm" value="Delete" id="btnvoucherecord" name="btnvoucherecord" style="width: 227px;"><i class="fas fa-trash"></i>Delete Unpaid Deductions</button>
                            </div>

                            <div class="col-2" style="font-weight: bold;">
                                <select id="drpChallanType" name="drpChallanType" class="form-control form-control-border btn btn-block btn-default select select2-hidden-accessible col-lg-2">
                                    <option value="0" selected>All Deduction</option>
                                    <option value="1">Paid</option>
                                    <option value="2" onclick='UnMatchedVchr()'>UnPaid</option>

                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div id="dvTblVMfy" class="col-md-9">
                              <div class="card">
                            <div class="card-body">                      
                            <div class="table-responsive" style="height: 900px;">
                                <table id="dgVoucherModify" class="table table-bordered table-hover  table-sm font-size-base   dataTable dtr-inline table-head-fixed"></table>
                            </div>
                                </div>
                              </div>
                        </div>

                        <div id="dvChMfy" class="col-md-3">
                            <div class="card">
                            <div class="card-body">
                            <div class="form-group row" style="height: 25px;">
                                <div class="col-lg-6" style="padding-left: 0px; padding-top: 18px;">
                                    <label class="col-form-label ">Challan No</label>
                                </div>
                                <div style="padding-top: 20px;">:</div>
                                <div class="col-lg-5">
                                    <label id="lblMfyCNo" class="col-form-label "  style=" padding-top: 18px;"/>
                                </div>

                            </div>

                            <div class="form-group row" style="height: 25px;">
                                <div class="col-lg-6" style="padding-left: 0px; padding-top: 18px;">
                                    <label class="col-form-label ">Challan Dt</label>
                                </div>
                                <div style="padding-top: 20px;">:</div>
                                <div class="col-lg-5">
                                    <label id="lblMfyChlDt" class="col-form-label "  style=" padding-top: 18px;"/>
                                </div>
                            </div>

                            <div class="form-group row" style="height: 25px;">
                                <div class="col-lg-6" style="padding-left: 0px; padding-top: 18px;">
                                    <label class="col-form-label ">BSR Code</label>
                                </div>
                                <div style="padding-top: 20px;">:</div>
                                <div class="col-lg-5">
                                    <label id="lblMfyChlBSRNC" class="col-form-label "  style=" padding-top: 18px;"/>
                                </div>
                            </div>

                            <div class="form-group row" style="height: 25px;">
                                <div class="col-lg-6" style="padding-left: 0px; padding-top: 18px;">
                                    <label class="col-form-label ">TDS</label>
                                </div>
                                <div style="padding-top: 20px;">:</div>
                                <div class="col-lg-5">
                                    <label id="lblCTDSMfy" class="col-form-label"  style=" padding-top: 18px;"/>
                                </div>
                            </div>
                            <div class="form-group row" style="height: 25px;">
                                <div class="col-lg-6" style="padding-left: 0px; padding-top: 18px;">
                                    <label class="col-form-label ">Sur</label>
                                </div>
                                <div style="padding-top: 20px;">:</div>
                                <div class="col-lg-5">
                                    <label id="lblCSurMfy" class="col-form-label"  style=" padding-top: 18px;"/>
                                </div>
                            </div>
                            <div class="form-group row" style="height: 25px;">
                                <div class="col-lg-6" style="padding-left: 0px; padding-top: 18px;">
                                    <label class="col-form-label ">Cess</label>
                                </div>
                                <div style="padding-top: 20px;">:</div>
                                <div class="col-lg-5">
                                    <label id="lblCCessMfy" class="col-form-label"  style=" padding-top: 18px;"/>
                                </div>
                            </div>


                            <div class="form-group row" style="height: 25px;">
                                <div class="col-lg-6" style="padding-left: 0px; padding-top: 18px;">
                                    <label class="col-form-label ">Int</label>
                                </div>
                                <div style="padding-top: 20px;">:</div>
                                <div class="col-lg-5">
                                    <label id="lblCIntMfy" class="col-form-label"  style=" padding-top: 18px;"/>
                                </div>
                            </div>
                            <div class="form-group row" style="height: 25px;">
                                <div class="col-lg-6" style="padding-left: 0px; padding-top: 18px;">
                                    <label class="col-form-label ">Others</label>
                                </div>
                                <div style="padding-top: 20px;">:</div>
                                <div class="col-lg-5">
                                    <label id="lblCOthMfy" class="col-form-label"  style=" padding-top: 18px;"/>
                                </div>
                            </div>
                            <div class="form-group row" style="height: 25px;">
                                <div class="col-lg-6" style="padding-left: 0px; padding-top: 18px;">
                                    <label class="col-form-label ">Total</label>
                                </div>
                                <div style="padding-top: 20px;">:</div>
                                <div class="col-lg-5">
                                    <label id="lblCTAmtMfy" class="col-form-label"  style=" padding-top: 18px;"/>
                                </div>
                            </div>

                            <div class="form-group row" style="height: 25px;">
                                <div class="col-lg-6" style="padding-left: 0px; padding-top: 18px;">
                                    <label class="col-form-label ">Difference Amt</label>
                                </div>
                                <div style="padding-top: 20px;">:</div>
                                <div class="col-lg-5">
                                    <label id="lblCDiffMfy" class="col-form-label"  style=" padding-top: 18px;"/>
                                </div>
                            </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="divMisMatch" class="card">
                <div class="card-body">
                    <div class="row">
                        <div class="col-1">
                            <label class="col-form-label font-weight-bold">Select Quater</label>
                        </div>
                        <div class="col-1">
                            <select runat="server" id="drpQua" class="form-control">
                                <option value="">Select</option>
                                <option value="Q1">Q1</option>
                                <option value="Q2">Q2</option>
                                <option value="Q3">Q3</option>
                                <option value="Q4">Q4</option>
                            </select>
                        </div>
                        <div class="col-1">
                            <label class="col-form-label font-weight-bold">Select Form</label>
                        </div>
                        <div class="col-1">
                            <select runat="server" id="drpForm" class="form-control">
                                <option value="">Select</option>
                                <option value="26Q">26Q</option>
                                <option value="27Q">27Q</option>
                                <option value="27EQ">27EQ</option>

                            </select>
                        </div>
                        <div class="col-8">
                            <input id="btnBack" name="btnBack" class="btn btn-primary " value="Back to Voucher" type="button" />
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <table id="tblMisMatch" class="table text-nowrap" style="border-collapse: collapse;"></table>
                </div>
            </div>
            <table id="tblPager" style="border: 1px solid #BCBCBC; height: 50px; width: 100%">
                <tr>
                    <td>
                        <div class="Pager">
                        </div>
                    </td>
                </tr>
            </table>
        </div>


        <div id="dvAddVoucher">
            <div class="content">
                <div class="content-header">
                    <div class="row" id="">
                        <div class="col-md-5">
                            <div class="card" style="height: 330px;">
                                <div class="card-body">
                                    <div class="form-group row" style="height: 25px;">
                                        <div class="col-lg-3" style="padding-left: 0px; padding-top: 12px;">
                                            <label class="col-form-label ">Payment Dt</label>
                                        </div>
                                        <div style="padding-top: 12px; margin-left: 32px;">:</div>
                                        <div class="col-lg-5">
                                            <input id="txt_VoucherDate" type="date" class="form-control form-control-border" placeholder="dd/MM/yyyy" />
                                        </div>
                                    </div>

                                    <div class="form-group row" style="height: 20px;">
                                        <div class="col-lg-3" style="padding-left: 0px; padding-top: 12px;">
                                            <label class="col-form-label">Deducted Dt</label>
                                        </div>
                                        <div style="padding-top: 12px; margin-left: 32px;">:</div>
                                        <div class="col-lg-5">
                                            <input id="txtDedDate" type="date" class="form-control form-control-border" placeholder="dd/MM/yyyy" />
                                        </div>
                                    </div>

                                    <div class="form-group row" style="height: 25px;">
                                        <div class="col-lg-3" style="padding-left: 0px; padding-top: 20px;">
                                            <label class="col-form-label ">Deductee</label>
                                        </div>

                                        <div style="padding-top: 20px; margin-left: 32px;">:</div>
                                        <div class="col-lg-8">
                                            <input id="txtded" name="txtded" class="form-control form-control-border typeahead" type="text" />
                                        </div>
                                    </div>

                                    <div class="form-group row" style="height: 25px;">
                                        <div class="col-lg-3" style="padding-left: 0px; padding-top: 20px;">
                                            <label class="col-form-label ">PAN No</label>
                                        </div>
                                        <div style="padding-top: 20px; margin-left: 32px;">:</div>
                                        <div class="col-lg-3">
                                            <input id="txtPAN" type="text" class="form-control form-control-border" />
                                        </div>
                                        <div style="padding-top: 10px;">
                                            <label class="col-form-label font-weight-bold" id="lblPANsts"></label>
                                        </div>
                                    </div>

                                    <div class="form-group row" style="height: 25px;">
                                        <div class="col-lg-3" style="padding-left: 0px; padding-top: 20px;">
                                            <label class="col-form-label ">Code</label>
                                        </div>
                                        <div style="padding-top: 26px;">
                                            <i class="far fa-question-circle mr-3 fa-1x" style="color: blue;"
                                                data-toggle="tooltip" data-placement="top" title="Deductee Name and pan no should be valid & linked with aadhar"></i>
                                        </div>
                                        <div style="padding-top: 20px;">:</div>
                                        <div class="col-lg-8">
                                            <select id="ddl_Type" name="ddl_Type" class="form-control  select-search" data-fouc>
                                                <option value="0">Select Type</option>
                                                <option value='Company'>Company</option>
                                                <option value='Hindu'>Hindu Undivided Family </option>
                                                <option value='AOPCM'>Association of Persons (Others)</option>
                                                <option value='ST'>Co-operative Society/ Trust</option>
                                                <option value='Firm'>Firm</option>
                                                <option value='BInd'>Body of individuals</option>
                                                <option value='Artificial'>Artificial juridical person</option>
                                                <option value='Others'>Others</option>
                                                <option value='Individual'>Individual</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group row" style="height: 25px;">
                                        <div class="col-lg-3" style="padding-left: 0px; padding-top: 20px;">
                                            <label class="col-form-label ">Section </label>
                                        </div>
                                        <div style="padding-top: 26px;">
                                            <i class="far fa-question-circle mr-3 fa-1x" style="color: blue;"
                                                data-toggle="tooltip" data-placement="top" title="Deductee Name and pan no should be valid & linked with aadhar"></i>
                                        </div>
                                        <div style="padding-top: 20px;">:</div>
                                        <div class="col-lg-8">
                                            <select id="ddl_Nature" name="ddl_Nature" class="form-control select-search" data-fouc>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group row" style="height: 25px;">
                                        <div class="col-lg-3" style="padding-left: 0px; padding-top: 20px;">
                                            <label class="col-form-label ">Remarks</label>
                                        </div>
                                        <div style="padding-top: 26px;">
                                            <i class="far fa-question-circle mr-3 fa-1x" style="color: blue;"
                                                data-toggle="tooltip" data-placement="top" title="Deductee Name and pan no should be valid & linked with aadhar"></i>
                                        </div>
                                        <div style="padding-top: 20px;">:</div>
                                        <div class="col-lg-8">
                                            <select id="ddl_Reasons" name="ddl_Reasons" class="form-control select-search" data-fouc>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-3">
                            <div class="card" style="height: 330px;">
                                <div class="card-body">

                                    <div class="form-group row" style="height: 25px;">
                                        <div class="col-lg-4" style="padding-left: 0px; padding-top: 18px;">
                                            <label class="col-form-label ">Amount Paid</label>
                                        </div>
                                        <div style="padding-top: 20px;">:</div>
                                        <div class="col-lg-6">
                                            <input id="txtAmtPd" type="text" class="form-control form-control-border rightAligned decimal" value='0.00' onkeypress="return isNumberKey(event)" onkeyup="AmountPaidKeyUp()" />
                                        </div>
                                    </div>

                                    <div class="form-group row" style="height: 25px;">
                                        <div class="col-lg-4" style="padding-left: 0px; padding-top: 18px;">
                                            <label class="col-form-label ">TDS Rate % </label>
                                        </div>
                                        <div style="padding-top: 20px;">:</div>
                                        <div class="col-lg-6">
                                            <input id="txtTDSRt" type="text" class="form-control form-control-border rightAligned decimal" onkeypress="return isNumberKey(event)" value="0.00" />
                                        </div>
                                    </div>

                                    <div class="form-group row" style="height: 25px;">
                                        <div class="col-lg-4" style="padding-left: 0px; padding-top: 18px;">
                                            <label class="col-form-label ">Income Tax</label>
                                        </div>
                                        <div style="padding-top: 20px;">:</div>
                                        <div class="col-lg-6">
                                            <input id="txtIncome" type="text" class="form-control form-control-border rightAligned decimal" onkeypress="return isNumberKey(event)" value="0.00" />
                                        </div>
                                    </div>

                                    <div class="form-group row" style="height: 25px;">
                                        <div class="col-lg-4" style="padding-left: 0px; padding-top: 18px;">
                                            <label class="col-form-label ">Surcharge</label>
                                        </div>
                                        <div style="padding-top: 20px;">:</div>
                                        <div class="col-lg-6">
                                            <input id="txtsurc" type="text" class="form-control form-control-border rightAligned decimal" onkeypress="return isNumberKey(event)" value="0.00" />
                                        </div>
                                    </div>

                                    <div class="form-group row" style="height: 25px;">
                                        <div class="col-lg-4" style="padding-left: 0px; padding-top: 18px;">
                                            <label class="col-form-label ">Cess</label>
                                        </div>
                                        <div style="padding-top: 20px;">:</div>
                                        <div class="col-lg-6">
                                            <input id="txtCess" type="text" class="form-control form-control-border rightAligned decimal" onkeypress="return isNumberKey(event)" value="0.00" />
                                        </div>
                                    </div>

                                    <div class="form-group row" style="height: 25px;">
                                        <div class="col-lg-4" style="padding-left: 0px; padding-top: 18px;">
                                            <label class="col-form-label font-weight-bold">Total</label>
                                        </div>
                                        <div style="padding-top: 20px;">:</div>
                                        <div class="col-lg-6">
                                            <input id="txtTotal" type="text" style="font-weight: bold;" class="form-control form-control-border rightAligned decimal" value="0.00" onkeypress="return isNumberKey(event)" onchange="CheckValueAmount()" readonly />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="card" style="height: 330px;">
                                <div class="card-body">
                                    <div class="form-group row" style="height: 25px;">
                                        <div class="col-lg-4" style="padding-left: 0px; padding-top: 18px;">
                                            <label class="col-form-label ">Challan No</label>
                                        </div>
                                        <div style="padding-top: 20px;">:</div>
                                        <div class="col-lg-4">
                                            <select id="ddlChallan" name="ddlChallan" class="form-control select-search" data-fouc>
                                            </select>
                                        </div>
                                        <div style="margin-left: 10px;">
                                            <button type="button" id="btnChallanModalPopupAdd" class="btn btn-success legitRipple"><i class="fas fa-plus mr-2 fa-1x "></i>Challan</button>
                                        </div>
                                    </div>

                                    <div class="form-group row" style="height: 25px;">
                                        <div class="col-lg-4" style="padding-left: 0px; padding-top: 18px;">
                                            <label class="col-form-label ">Challan Dt</label>
                                        </div>
                                        <div style="padding-top: 20px;">:</div>
                                        <div class="col-lg-5">
                                            <input id="txtChallaDt" type="date" class="form-control form-control-border" placeholder="dd/MM/yyyy" />
                                        </div>
                                    </div>

                                    <div class="form-group row" style="height: 25px;">
                                        <div class="col-lg-4" style="padding-left: 0px; padding-top: 18px;">
                                            <label class="col-form-label ">BSR Code</label>
                                        </div>
                                        <div style="padding-top: 20px;">:</div>
                                        <div class="col-lg-6">
                                            <%--<input id="txtChallanBSRNC" type="text" class="form-control form-control-border" />--%>

                                            <select id="ddl_ChallanBSRCodes" name="ddl_Nature" class="form-control select-search" data-fouc>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group row" style="height: 25px;">
                                        <div class="col-lg-4" style="padding-left: 0px; padding-top: 18px;">
                                            <label class="col-form-label ">TDS</label>
                                        </div>
                                        <div style="padding-top: 20px;">:</div>
                                        <div class="col-lg-6">
                                            <input id="txtChallanTdsNC" value="0.00" type="text" class="form-control form-control-border rightAligned decimal" />
                                        </div>
                                    </div>

                                    <div class="form-group row" style="height: 25px;">
                                        <div class="col-lg-4" style="padding-left: 0px; padding-top: 18px;">
                                            <label class="col-form-label ">Deducted Amt</label>
                                        </div>
                                        <div style="padding-top: 20px;">:</div>
                                        <div class="col-lg-6">
                                            <input id="txtChallanDedAmt" type="text" value="0.00" class="form-control form-control-border rightAligned decimal" readonly="" />
                                        </div>
                                    </div>

                                    <div class="form-group row" style="height: 25px;">
                                        <div class="col-lg-4" style="padding-left: 0px; padding-top: 18px;">
                                            <label class="col-form-label ">Difference Amt</label>
                                        </div>
                                        <div style="padding-top: 20px;">:</div>
                                        <div class="col-lg-6">
                                            <input id="txtChallanDiffAmt" value="0.00" type="text" class="form-control form-control-border rightAligned decimal" readonly="" />
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="content">
                <div class="content-header">
                    <div class="card">
                        <div class="card-body">
                            <div class="card-header" style="padding: 0px;">
                                <div class="card-title">
                                    <h5><span class="font-weight-bold">Other Details</span></h5>
                                </div>
                            </div>
                            <div class="form-group row" style="height: 35px;">
                                <div class="col-lg-1" style="padding-left: 0px; padding-top: 20px;">
                                    <label class="col-form-label font-weight-bold">Certificate</label>
                                </div>
                                <div style="padding-top: 26px;">
                                    <i class="far fa-question-circle mr-3 fa-1x" style="color: blue;"
                                        data-toggle="tooltip" data-placement="top" title="Deductee Name and pan no should be valid & linked with aadhar"></i>
                                </div>
                                <div style="padding-top: 20px;">:</div>
                                <div class="col-lg-2" style="margin-left: 22px;">
                                    <input id="txtCertNo" type="text" class="form-control form-control-border" maxlength="10" />
                                </div>
                                <label class="col-lg-1 col-form-label font-weight-bold" style="padding-top: 20px; margin-left: 70px;">Inv/Bill No</label>
                                <div style="padding-top: 20px; margin-left: 33px;">:</div>
                                <div class="col-lg-2">
                                    <input id="txtInvNo" type="text" class="form-control form-control-border" />
                                </div>
                                <label class="col-lg-1 col-form-label font-weight-bold" style="padding-top: 20px; margin-left: 70px;">Branch</label>
                                <div style="padding-top: 15px;">:</div>
                                <div class="col-lg-2">
                                    <select id="drpBranch" name="drpBranch" class="form-control select-search" data-fouc></select>
                                </div>
                            </div>

                            <div id="dv27EQTCS">
                                <div class="form-group row" style="height: 25px;">
                                    <div class="col-lg-1" style="padding-left: 0px; padding-top: 14px;">
                                        <label class="col-form-label font-weight-bold">Is NRI</label>
                                    </div>
                                    <div style="padding-top: 19px;">
                                        <i class="far fa-question-circle mr-3 fa-1x" style="color: blue;"
                                            data-toggle="tooltip" data-placement="top" title="Deductee Name and pan no should be valid & linked with aadhar"></i>
                                    </div>
                                    <div style="padding-top: 13px;">:</div>
                                    <div class="col-lg-2" style="margin-left: 18px;">
                                        <select id="drpIsNri" name="drpIsNri" class="form-control select">
                                            <option value="0">Select</option>
                                            <option value="Y">Yes</option>
                                            <option value="N">No</option>
                                        </select>
                                    </div>

                                    <label class="col-lg-1 col-form-label font-weight-bold" style="padding-top: 16px; margin-left: 70px;">115BAC(1A)</label>
                                    <div style="padding-top: 20px; margin-left: 5px;">
                                        <i class="far fa-question-circle mr-3 fa-1x" style="color: blue;"
                                            data-toggle="tooltip" data-placement="top" title="Deductee Name and pan no should be valid & linked with aadhar"></i>
                                    </div>
                                    <div style="padding-top: 14px;">:</div>
                                    <div class="col-lg-2">
                                        <select id="drpBAC" name="drpBAC" class="form-control select">
                                            <option value="0">Select</option>
                                            <option value="Y">Yes</option>
                                            <option value="N">No</option>
                                        </select>
                                    </div>

                                    <div id="dvEstIndia" class="row" style="display: none">
                                        <div style="padding-left: 0px;">
                                            <label class="col-form-label font-weight-bold">Establishment in India:</label>
                                            <select id="drpEstInIndia" name="drpEstInIndia" class="form-control select col-1">
                                                <option value="0">Select</option>
                                                <option value="Y">Yes</option>
                                                <option value="N">No</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div id="dv27QNRI">

                                <div class="form-group row" style="height: 25px;">
                                    <div class="col-lg-1" style="padding-left: 0px; padding-top: 14px;">
                                        <label class="col-form-label font-weight-bold">Remittance</label>
                                    </div>
                                    <div style="padding-top: 13px; margin-left: 30px;">:</div>
                                    <div class="col-lg-2" style="margin-left: 18px;">
                                        <select id="drpRemit" name="drpRemit" class="form-control select-search" data-fouc></select>
                                    </div>

                                    <label class="col-lg-1 col-form-label font-weight-bold" style="padding-top: 16px; margin-left: 70px;">Country</label>
                                    <div style="padding-top: 14px; margin-left: 39px;">:</div>
                                    <div class="col-lg-2">
                                        <select id="drpCountry" name="drpCountry" class="form-control select-search" data-fouc>
                                        </select>
                                    </div>

                                    <label class="col-lg-1 col-form-label font-weight-bold" style="padding-top: 20px; margin-left: 70px;">TDS Rate</label>
                                    <div style="padding-top: 20px;">:</div>
                                    <div class="col-lg-2">
                                        <select id="ddlRate" name="ddlRate" class="form-control select-search" data-fouc></select>
                                    </div>
                                </div>

                                <div class="form-group row" style="height: 25px;">
                                    <div class="col-lg-1" style="padding-left: 0px; padding-top: 14px;">
                                        <label class="col-form-label font-weight-bold">Address</label>
                                    </div>
                                    <div style="padding-top: 13px; margin-left: 30px;">:</div>
                                    <div class="col-lg-2" style="margin-left: 18px;">
                                        <input id="txtAddress" name="txtAddress" type="text" class="form-control form-control-border" />
                                    </div>

                                    <label class="col-lg-1 col-form-label font-weight-bold" style="padding-top: 16px; margin-left: 70px;">Contact</label>
                                    <div style="padding-top: 14px; margin-left: 38px;">:</div>
                                    <div class="col-lg-2">
                                        <input id="txtContact" name="txtContact" type="text" class="form-control form-control-border" />
                                    </div>

                                    <label class="col-lg-1 col-form-label font-weight-bold" style="padding-top: 20px; margin-left: 70px;">Email</label>
                                    <div style="padding-top: 20px;">:</div>
                                    <div class="col-lg-2">
                                        <input id="txtEmail" name="txtEmail" type="text" class="form-control form-control-border" />
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <div class="col-lg-1.5" style="padding-left: 0px; padding-top: 14px;">
                                        <label class="col-form-label font-weight-bold">Tax Identification</label>
                                    </div>
                                    <div style="padding-top: 19px; margin-left: 5px;">
                                        <i class="far fa-question-circle mr-3 fa-1x" style="color: blue;"
                                            data-toggle="tooltip" data-placement="top" title="Deductee Name and pan no should be valid & linked with aadhar"></i>
                                    </div>
                                    <div style="padding-top: 13px;">:</div>
                                    <div class="col-lg-2" style="margin-left: 18px;">
                                        <input id="txtIdent" name="txtIdent" type="text" class="form-control form-control-border" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <%-- **************** Modal Popups *****************************************--%>

    <div id="modal_chl" class="modal fade" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary-1">
                    <h5 class="modal-title" id="Chlpopup" name="Chlpopup">Select Challan </h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <input type="hidden" id="hdnvids4Chl" runat="server" value="" />
                <form action="#" class="form-horizontal">
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="col-3">
                                <input id="challan" name="txtSearchchallan" type="text" class="form-control form-control-border" value="" placeholder=" Search ....." />
                            </div>

                        </div>

                        <div class="table-responsive" style="height: 180px; overflow: scroll;">
                            <table id="tblSrchChln" class="table table-bordered table-hover  table-sm font-size-base   dataTable dtr-inline table-head-fixed">
                            </table>
                        </div>
                        <div id="mdlChlnDtds" style="display: none;">

                            <div class=" card card-body">
                                <div class="form-group row">
                                    <div class="col-sm-3 col-form-label">
                                        <label class=" col-form-label">Challan No.</label>
                                    </div>

                                    <div class="col-2">
                                        <label id="lblCno" class=" form-control form-control-border font-weight-bold"></label>
                                    </div>


                                    <div class="col-sm-3 col-form-label">
                                        <label class="col-form-label">Consumed Amt</label>
                                    </div>
                                    <div class="col-2">
                                        <label id="lblCons" class=" form-control form-control-border font-weight-bold" style="color: green; text-align: right;">0.00</label>
                                    </div>

                                    <div class="col-sm-3 col-form-label">
                                        <label class="col-form-label">Challan Date</label>
                                    </div>

                                    <div class="col-2">
                                        <label id="lblCdt" class=" form-control form-control-border font-weight-bold"></label>
                                    </div>



                                    <div class="col-sm-3 col-form-label">
                                        <label class="col-form-label">Difference Amt</label>
                                    </div>
                                    <div class="col-2">
                                        <label id="CBalAmt" class=" form-control form-control-border font-weight-bold" style="color: red; text-align: right;">0.00</label>
                                    </div>


                                    <div class="col-sm-3 col-form-label">
                                        <label class="col-form-label">Challan Amt</label>
                                    </div>
                                    <div class="col-2">
                                        <label id="CTAmt" class=" form-control form-control-border font-weight-bold" style="text-align: right;">0.00</label>
                                    </div>

                                    <div class="col-sm-3 col-form-label">
                                        <label class="col-form-label">Unpaid Deductions Total</label>
                                    </div>
                                    <div class="col-2">
                                        <label id="DTAmt" class=" form-control form-control-border font-weight-bold" style="text-align: right;">0.00</label>
                                    </div>

                                </div>

                                <div class="modal-footer">
                                    <button id="btnChlnUvid" type="button" class="btn btn-success" data-dismiss="modal">Update Challan</button>
                                    <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>

                                </div>
                            </div>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>



    <div id="modal_Addchallan" class="modal fade" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary-1">
                    <h5 class="modal-title" id="lblpopup" name="lblpopup">Add Challan </h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <form action="#" class="form-horizontal">
                    <div class="modal-body">
                        <div class="row">

                            <div class="col-md-7">
                                <input type="hidden" id="hdnchlid" runat="server" value="" />
                                <div class="form-group row">
                                    <label class="col-lg-4 col-form-label ">Challan No</label>
                                    <div class="col-4">
                                        <input id="txtBankChinNo" maxlength="5" onkeypress="return isNumberKey(event)" class="form-control  form-control-border txt" />
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-lg-4 col-form-label ">Challan Date</label>
                                    <div class="col-4">
                                        <input id="txtChinDate" class="form-control form-control-border" type="date" placeholder="dd/MM/yyyy" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-lg-4 col-form-label ">BSR Code</label>
                                    <div class="col-5">
                                        <%--<input id="ddl_BSRCodes" maxlength="7" onkeypress="return isNumberKey(event)" class="form-control txt" />--%>
                                        <select id="ddl_BSRCodes" name="ddl_Nature" class="form-control select-search" data-fouc>
                                        </select>
                                    </div>
                                </div>
                                <div id="dvchlded" class="form-group row">
                                    <label class="col-lg-4 col-form-label ">Deduction Total</label>
                                    <div class="col-5">
                                        <label id="lblchlDTAmt" class=" form-control form-control-border font-weight-bold" style="text-align: right;">0.00</label>
                                    </div>
                                </div>

                            </div>
                            <div class="col-md-5">
                                <div class="form-group row">
                                    <label class="col-lg-4 col-form-label ">TDS</label>
                                    <div class="col-5">
                                        <input id="txtChlTDS" class="form-control  form-control-border txt decimal" onkeypress="return isNumberKey(event)" type="text" placeholder="TDS" style="text-align: right;" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-lg-4 col-form-label ">Surcharge</label>
                                    <div class="col-5">
                                        <input id="txtChSur" class="form-control form-control-border decimal" onkeypress="return isNumberKey(event)" type="text" placeholder="Surcharge " style="text-align: right;" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-lg-4 col-form-label ">Cess</label>
                                    <div class="col-5">
                                        <input id="txtChlCess" class="form-control form-control-border txt decimal" onkeypress="return isNumberKey(event)" type="text" placeholder="Cess" style="text-align: right;" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-lg-4 col-form-label ">Interest</label>
                                    <div class="col-5">
                                        <input id="txtChInt" type="text" onkeypress="return isNumberKey(event)" class="form-control form-control-border txt decimal" placeholder="Intrest" style="text-align: right;" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-lg-4 col-form-label ">Others</label>
                                    <div class="col-5">
                                        <input id="txtChlOth" class="form-control form-control-border txt decimal" onkeypress="return isNumberKey(event)" type="text" placeholder="Others " style="text-align: right;" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-lg-4 col-form-label font-weight-bold">Total Amt</label>
                                    <div class="col-5">
                                        <input id="txtChTotal" onkeypress="return isNumberKey(event)" class="form-control form-control-border txt decimal" type="text" placeholder="Total TDS " style="text-align: right;" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button id="btnChlnSave" type="button" class="btn btn-outline-success btn-labeled btn-labeled-left">Save</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div id="modal_ChallanVerify" class="modal fade" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary-1">
                    <h5 class="modal-title" id="lblmopopup" name="lblpopup">Challan Verify</h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="login-card-body card-info">
                        <img src="../../TDS/BTStrp/image/tds-logo.png" alt="Logo" />
                    </div>
                    <div id="dvTracesuserDe">
                        <div class="login-card-body card-info" style="padding: 0px;">
                            <div class="card-header">
                                <h3 class="card-title">Traces Details</h3>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label" style="padding-top: 12px;">TAN:</label>
                            <div class="col-3">
                                <input type="text" class="form-control form-control-border" id="TANID" autocomplete="one-time-code" readonly />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label" style="padding-top: 12px;">User ID:<span class="text-danger">*</span></label>
                            <div class="col-3">
                                <input type="text" class="form-control form-control-border" id="txtUserID" placeholder="Enter UserID" autocomplete="one-time-code" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label" style="padding-top: 12px;">Password<span class="text-danger">*</span></label>
                            <div class="col-3">
                                <input type="password" class="form-control form-control-border" id="txtPassword" placeholder="Enter Password" autocomplete="one-time-code" />
                            </div>
                        </div>
                        <div class="card-footer">
                            <input type="button" id="btnTraces" class="btn btn-outline-success legitRipple" value="Save" />
                            <button class="btn btn-outline-success legitRipple">Cancel</button>
                        </div>
                    </div>

                    <div id="dvCaptcha">
                        <img id="captchaImg" class="captchaimg1" alt="Captcha" src="" />
                        <span class="col-sm-3 col-form-label" style="margin-left: 40px;">
                            <i class="fas fa-sync-alt" id="refreshIcon" style="cursor: pointer;"></i>
                            Click to refresh image  
                        </span>
                    </div>
                    <div class="row"></div>
                    <div class="row"></div>
                    <div class="row"></div>
                    <div class="row">
                        <div class="col-sm-3">
                            <input type="text" class="form-control form-control-border" id="captcha" maxlength="5" autocomplete="one-time-code" placeholder="Enter captcha" />
                        </div>
                        <div class="col-sm-5" style="margin-left: 40px; padding-top: 10px;">
                            <label for="captcha" class="col-form-label">Enter text as in above image</label>
                        </div>
                    </div>
                    <div class="row"></div>
                    <div class="row"></div>
                    <div class="row"></div>
                    <div>
                        <input type="submit" name="btnGetRequest" value="Request" id="btnGetRequest" class="btn btn-outline-success legitRipple" onclick="return RequestTrace();" />
                        <asp:Button ID="Button1" Text="Cancel" runat="server" CssClass="btn btn-outline-success legitRipple" OnClientClick="return HideModalPopup()" Style="margin-left: 40px;" />
                    </div>
                    <div>
                        <label id="lblProcess" class="col-form-label" style="font-weight: bold; color: red; border: none;">Verifing Challans, Please wait .......</label>
                        <label id="lblSuccess" class="col-form-label" style="font-weight: bold; border: none; color: green;">Verifiying</label>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
