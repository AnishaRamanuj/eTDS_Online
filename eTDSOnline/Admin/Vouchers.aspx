<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="Vouchers.aspx.cs" Inherits="Admin_Vouchers" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>
<%--<%@ Import Namespace="System.Drawing" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%--<script type="text/javascript" src="../Scripts/jquery-1.8.2.min.js"></script>--%>
    <script type="text/javascript" src="../Scripts/jquery1.9.1.js"></script>

    <script type="text/javascript" src="../Scripts/moment.min.js"></script>
    <script type="text/javascript" src="../Scripts/Ajax_Pager.min.js"></script>
    <script type="text/javascript" src="../customScript/jquery-confirm.min.js"></script>
    <script type="text/javascript" src="../customScript/common.js"></script>

    <script type="text/javascript" src="../Scripts/bootstrap2.3.2.js"></script>
    <%--<script type="text/javascript" src="../Scripts/typeahead.js"></script>--%>
    <script type="text/javascript" src="../Scripts/hogan-2.0.0.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/bootstrap2.3.2.css" />
    <link rel="stylesheet" type="text/css" href="../css/bootstrap-responsive2.3.2.css" />


    <script language="javascript" type="text/javascript">
        //var myDrps = [];
        var ddid = 0;
        var UP = 0;
        var NT = '';
        var Mis = '';
        var deddrp = '';
        var vMod = '';
        var BAC1A = '';
        
        $(document).ready(function () {
            //$("[id*=ddl_DeducterVoucherMonthEntries]").attr("disabled", true);
            $("[id*=hdnDEdit]").val('');
            $("[id*=hdnDName]").val('');
            $("[id*=hdnDSrch]").val('');
            $("[id*=hdnSection]").val('');
            $("[id*=hdnConnString]").val($("[id*=ddlFinancialYear] :selected").text());
            $("[id*=hdnPages]").val(1);
            $("[id*=tbl_VoucherModify]").hide();
            $("[id*=btnBAC]").hide();
            $("[id*=divMisMatch]").hide();
            $("[id*=tblDtype]").hide();
            $("[id*=drpBACALL]").hide();
            $("[id*=Label6]").hide();
            $("[id*=tdAddNewVoucher]").hide();
            $("[id*=btnSave]").hide();
            $("[id*=btnVoucherCancel]").hide();
            $("[id*=btnCancel]").hide();
            $("[id*=tblNri]").hide();
            $("[id*=tdAddNewVoucher]").hide();
            $("[id*=trNriEQ]").hide();
            //$("[id*=btnAdd]").hide();
            $("[id*=ddlForm]").val($("[id*=hdnForm]").val());
            $("[id*=ddltype]").val($("[id*=hdnQuater]").val());
            var M = $("[id*=hdnMis]").val();
            M = M.split(',');
            Mis = M[0];
            $("[id*=Label1]").html('Voucher Entries');
            if (Mis != '') {
                $("[id*=ddlForm]").val(M[1]);
                $("[id*=ddltype]").val(M[2]);
                $("[id*=hdnForm]").val(M[1]);
                $("[id*=hdnQuater]").val(M[2]);
            }
            getDropdown();
            getNature_Branch_Drps();
            //MakeSmartSearch();
            $("[id*=ddlSearchChallanStatus]").change(function () {
                var d = $("[id*=hdnSrchDed]").val(); //$("[id*=ddlSearchDeducteeName]").val();
                var n = $("[id*=ddlSearchNature]").val();
                var ch = $("[id*=ddlSearchChallanStatus]").val();
                var mth = $("[id*=hndCurrmth]").val();
                $("[id*=hdnMis]").val('');
                Mis = '';
                Search_Grid(mth, 1, 25, d, ch, n);
            });

            $("[id*=ddl_Type]").change(function () {
                getNatureSubId();
            });

            $("[id*=ddl_Nature]").change(function () {
                var n = $("[id*=ddl_Nature]").val();
                if (parseFloat(n) > 0) {
                    getNatureSubId();
                }
            });
            $("[id*=ddlperpage]").change(function () {
                var p = $("[id*=ddlperpage]").val();
                var d = $("[id*=hdnSrchDed]").val();   //$("[id*=ddlSearchDeducteeName]").val();
                var n = $("[id*=ddlSearchNature]").val();
                var ch = $("[id*=ddlSearchChallanStatus]").val();
                var mth = $("[id*=hndCurrmth]").val();
                $("[id*=hdnPages]").val(1);
                Search_Grid(mth, 1, p, d, ch, n);
            });

            $("[id*=ddlForm]").change(function () {
                var f = $("[id*=ddlForm]").val();
                var t = $("[id*=ddltype]").val();
                $("[id*=tblNri]").hide();
                if (vMod == 'hide') { }
                else {
                    if (f != '0' && t != '0') {
                        vMod = 'show';
                        $("[id*=btnAdd]").show();
                        $("[id*=hdnForm]").val(f);
                        $("[id*=hdnQuater]").val(t);
                        $("[id*=hdnDSrch]").val('');
                        $("[id*=hdnDrps]").val('');
                        getDropdown();
                        getNature_Branch_Drps();
                    }
                    else {
                        $("[id*=btnAdd]").hide();
                        $("[id*=hdnQuater]").val('');
                        $("[id*=hdnForm]").val('');
                        $("[id*=hdnDSrch]").val('');
                        $("[id*=hdnDrps]").val('');
                        getDropdown();
                        getNature_Branch_Drps();
                    }
                }
                if (f == '27Q') {
                    $("[id*=tblNri]").show();
                }
                else {
                    $("[id*=tblNri]").hide();
                }
            });

            $("[id*=ddltype]").change(function () {
                var f = $("[id*=ddlForm]").val();
                var t = $("[id*=ddltype]").val();
                if (vMod == 'hide') { }
                else {
                    if (f != '0' && t != '0') {
                        vMod = 'show';
                        $("[id*=btnAdd]").show();
                        $("[id*=hdnForm]").val(f);
                        $("[id*=hdnQuater]").val(t);
                        getDropdown();
                    }
                    else {
                        vMod = 'hide';
                        $("[id*=btnAdd]").hide();
                        $("[id*=hdnQuater]").val('');
                        $("[id*=hdnForm]").val('');
                        getDropdown();
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

            $("[id*=ddlSearchNature]").change(function () {
                var p = $("[id*=ddlperpage]").val();
                var d = $("[id*=hdnSrchDed]").val();  // $("[id*=ddlSearchDeducteeName]").val();
                var n = $("[id*=ddlSearchNature]").val();
                var ch = $("[id*=ddlSearchChallanStatus]").val();
                var mth = $("[id*=hndCurrmth]").val();
                Search_Grid(mth, 1, p, d, ch, n);
            });


            $("[id*=ddl_Reasons]").change(function () {
                var R = $("[id*=ddl_Reasons]").val();
                R = R.substring(0, 9);
                if (R == 'Lower Rt.') {
                    $("[id*=txt_TDSCert]").removeAttr("disabled");
                }
                //else if (R == 'Lower Rt.') {
                //    $("[id*=txt_TDSCert]").removeAttr("disabled");
                //}
                else {
                    $("[id*=txt_TDSCert]").val('');
                    $("[id*=txt_TDSCert]").attr("disabled", "false");
                }
                var PAN = $("[id*=txt_PANNumber]").val();
                if (R == 'Non-Availability of PAN C' && PAN != 'PANNOTAVBL') {
                    $("[id*=ddl_Reasons]").val('');
                }

                if (PAN == 'PANNOTAVBL') {
                    $("[id*=ddl_Reasons]").val('Non-Availability of PAN C');
                }

            });


            $("[id*=txt_Amount3]").blur(function () {
                $("[id*=btnSave]").focus();
            });

            $("[id*=btnBack]").click(function () {
                $("[id*=hdnMis]").val('');
                Mis = '';
                $("[id*=tbl_VoucherModify]").hide();
                $("[id*=tdAddNewVoucher]").hide();
                $("[id*=btnSave]").hide();
                $("[id*=btnVoucherCancel]").hide();
                $("[id*=tdSearch]").show();
                $("[id*=btnVerify]").show();
                $("[id*=btnCancel]").hide();
                $("[id*=tblLstRec] tbody").empty();
                $("[id*=hndCurrmth]").val('');
                ////$("[id*=ddl_typesrch]").val(0);
                $("[id*=Label1]").html('Voucher Entries');
                Clearall();
                
                $("[id*=hdnForm]").val($("[id*=ddlForm]").val());
                $("[id*=hdnQuater]").val($("[id*=ddltype]").val());
                FillGrid(ddid);
            });

            $("[id*=btnSave]").click(function () {
                SaveRecords();
            });


            $("[id*=btnvoucherecord]").click(function () {
                var voucherid
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
                    alert('Kindly select Vouchers to Delete !!!');
                    return false
                } else {
                    ShowLoader();
                    Clearall();
                    var compid = $("[id*=hdnCompanyid]").val();
                    var Conn = $("[id*=hdnConnString]").val();

                    if (confirm('Challan already paid, Voucher will be removed from challan ?')) {

                        Del_Vouchers(paidids, nonpaid, compid, Conn);
                    }
                    else {
                        hideloader();
                    }
                }
            });


            $("[id*=btnCancel]").click(function () {
                $("[id*=tbl_VoucherModify]").hide();
                $("[id*=tdSearch]").show();
                $("[id*=btnVerify]").show();
                $("[id*=btnCancel]").hide();
                $("[id*=tblLstRec] tbody").empty();
                $("[id*=hndCurrmth]").val('');
                $("[id*=ddlForm]").attr("disabled", false);
                $("[id*=ddltype]").attr("disabled", false);

                $("[id*=hdnForm]").val($("[id*=ddlForm]").val());
                $("[id*=hdnQuater]").val($("[id*=ddltype]").val());
                if (ddid > 0) {
                    FillGrid(ddid);
                } else {
                    FillGrid(0);
                }
                Clearall();
                $("[id*=btnAdd]").show();
                vMod = '';
            });

            $("[id*=txt_NetAmount1]").blur(function () {
                setNumericFormat();
                CalCualteNetAmount();
            });

            $("[id*=txt_Rate1]").blur(function () {
                //setNumericFormat();
            });
            $("[id*=drpEQ_Nri]").change(function () {
                var n = $("[id*=drpEQ_Nri]").val();
                if (n == 'Y') {
                    $("[id*=trNriEQ]").show();
                }
                else {
                    $("[id*=trNriEQ]").hide();
                }

            });
            $("[id*=txt_Amount1]").blur(function () {

                var txt_NetAmount1 = $('[id*=txt_NetAmount1]').val();
                if (isNaN(parseFloat(txt_NetAmount1))) {
                    txt_NetAmount1 = "0.00";
                    $('[id*=txt_NetAmount1]').val('0.00')
                }

                //////////////rate1 get
                var txt_Rate1 = $('[id*=txt_Rate1]').val();
                if (isNaN(parseFloat(txt_Rate1))) {
                    txt_Rate1 = "0.00";
                    $('[id*=txt_Rate1]').val('0.00');
                }


                //////////////amount 1 get
                var txt_Amount1 = $('[id*=txt_Amount1]').val();
                if (isNaN(parseFloat(txt_Amount1))) {
                    txt_Amount1 = "0.00";
                }

                ///////////////amount 2 set
                /// Surcharge
                var txt_Amount2 = $('[id*=txt_Amount2]').val();
                if (isNaN(parseFloat(txt_Amount2))) {
                    txt_Amount2 = "0.00";
                    $('[id*=txt_Amount2]').val('0.00');
                }

                ///////////////net amount2 set
                $('[id*=txt_NetAmount2]').html(Math.round(parseFloat(txt_Amount1) + parseFloat(txt_Amount2)));


                ///////////////net amount 2 get 
                var txt_NetAmount2 = $('[id*=txt_NetAmount2]').html();

                ///////////////amount 3 set
                //// Cess
                var txt_Amount3 = $('[id*=txt_Amount3]').val();
                if (isNaN(parseFloat(txt_Amount3))) {
                    txt_Amount3 = "0.00";
                    $('[id*=txt_Amount3]').val(0.00);
                }

                //////////////set netamount 3
                $('[id*=txt_NetAmount3]').html(Math.round(parseFloat(txt_Amount3) + parseFloat(txt_NetAmount2)));

                //////////////get netamount 3
                var txt_NetAmount3 = $('[id*=txt_NetAmount3]').html();


                $('[id*=txt_NetAmounttotal]').html(Math.round(parseFloat(txt_NetAmount3)));
                $('[id*=hdntxt_NetAmounttotal]').val(Math.round(parseFloat(txt_NetAmount3)));
                setNumericFormat();
            });

            $("[id*=txt_Amount2]").blur(function () {
                setNumericFormat();
            });

            $("[id*=txt_Amount3]").blur(function () {
                setNumericFormat();
            });

            $("[id*=btnVoucherCancel]").click(function () {
                if (Mis == 'Mis') {
                    $("[id*=tbl_VoucherModify]").show();
                    $("[id*=dgVoucherModify]").hide();
                    $("[id*=divMisMatch]").show();
                    $("[id*=divModify]").hide();
                    $("[id*=tdSearch]").hide();
                    $("[id*=btnVerify]").hide();
                    $("[id*=btnSave]").hide();
                    $("[id*=btnVoucherCancel]").hide();
                    $("[id*=tdAddNewVoucher]").hide();
                    $("[id*=tblLstRec] tbody").empty();

                }
                else {
                    $("[id*=ddlForm]").attr("disabled", false);
                    $("[id*=ddltype]").attr("disabled", false);

                    $("[id*=tbl_VoucherModify]").hide();
                    $("[id*=tdAddNewVoucher]").hide();
                    $("[id*=btnSave]").hide();
                    $("[id*=btnVoucherCancel]").hide();
                    $("[id*=tdSearch]").show();
                    $("[id*=btnVerify]").show();
                    $("[id*=btnCancel]").hide();
                    $("[id*=tblLstRec] tbody").empty();
                    $("[id*=hndCurrmth]").val('');
                    ////$("[id*=ddl_typesrch]").val(0);
                    Clearall();
                    $("[id*=hdnForm]").val($("[id*=ddlForm]").val());
                    $("[id*=hdnQuater]").val($("[id*=ddltype]").val());
                    FillGrid(ddid);

                }
                $("[id*=btnAdd]").show();
                vMod = 'show';
            });

            $("[id*=btnAdd]").click(function () {
                Clearall();
                vMod = 'hide';
                $("[id*=btnAdd]").hide();
                $("[id*=ddlForm]").attr("disabled", true);
                $("[id*=ddltype]").attr("disabled", true);
                $("[id*=tdAddNewVoucher]").show();
                $("[id*=tdSearch]").hide();
                $("[id*=btnVerify]").hide();
                $("[id*=btnCancel]").show();
                $("[id*=tbl_VoucherModify]").hide();
                $("[id*=btnSave]").show();
                $("[id*=btnVoucherCancel]").show();
                $("[id*=txt_TDSCert]").attr("disabled", false);
                $("[id*=txtded]").attr("disabled", false);
                $("[id*=txt_VoucherDate]").val($("[id*=hdnDate]").val());
                $("[id*=hndCurrmth]").val('');
                var x = $("[id*=hdnDName]").val();
                var F = $("[id*=ddlForm]").val();
                Fiil_deducteeType();
                if (F == '27EQ') {
                    $("[id*=trEQ]").show();

                }
                else {
                    $("[id*=trEQ]").hide();
                }

            });



            $("[id*=txt_VoucherDate]").change(function () {
                var did = $("[id*=hdnDedId]").val(); //$("[id*=ddl_DeducteeName]").val();

                if (did != '' && did != undefined && did != '0') {
                    GetRate();
                }

            });

            $("[id*=txt_VoucherDate]").blur(function () {
                var did = $("[id*=hdnDedId]").val();  //$("[id*=ddl_DeducteeName]").val();
                var fn = $("[id*=hdnConnString]").val();
                var fy = fn.split('_');
                var st = '04/01/' + fy[0];
                var ed = '03/31/20' + fy[1];

                var vd = new Date;
                var s = new Date;
                var e = new Date;
                var d = $("[id*=txt_VoucherDate]").val();
                var dt = d.split('/');
                d = dt[1] + '/' + dt[0] + '/' + dt[2];

                vd = moment(d);
                s = moment(st);
                e = moment(ed);
                if (moment(vd) < moment(s)) {
                    $("[id*=txt_VoucherDate]").val('');
                    alert('Voucher date cannot be outside the Financial year');
                    return;
                }
                if (moment(vd) > moment(e)) {
                    $("[id*=txt_VoucherDate]").val('');
                    alert('Voucher date cannot be outside the Financial year');
                    return;
                }
                var qua = $("[id*=ddltype]").val();
                var q = qua.substring(1);
                if (q == 1) {
                    if (dt[1] < 4 || dt[1] > 6) {
                        $("[id*=txt_VoucherDate]").val('');
                        alert('Voucher date cannot be outside the Quarter');
                        return;
                    }
                }
                else if (q == 2) {
                    if (dt[1] < 7 || dt[1] > 9) {
                        $("[id*=txt_VoucherDate]").val('');
                        alert('Voucher date cannot be outside the Quarter');
                        return;
                    }
                }
                else if (q == 3) {
                    if (dt[1] < 10 || dt[1] > 13) {
                        $("[id*=txt_VoucherDate]").val('');
                        alert('Voucher date cannot be outside the Quarter');
                        return;
                    }
                }
                else if (q == 4) {
                    if (dt[1] < 1 || dt[1] > 3) {
                        $("[id*=txt_VoucherDate]").val('');
                        alert('Voucher date cannot be outside the Quarter');
                        return;
                    }
                }
            });

            $("[id*=txt_VoucherDate]").keyup(function (e) {
                if (e.which == 13) {
                    e.preventDefault();
                    return false;

                }
            });

            $("[id*=chk_Sections]").change(function () {
                var date = document.getElementById("<%=txt_VoucherDate.ClientID%>").value;
                if (date != "") {
                    if (document.getElementById("<%=chk_Sections.ClientID %>").checked == true) {
                        $("#<%= hdnrate1.ClientID %>").val($('[id*=txt_Rate1]').val());
                        $("#<%= hdnrate2.ClientID %>").val($('[id*=txt_Rate2]').val());
                        $("#<%= hdnrate3.ClientID %>").val($('[id*=txt_Rate3]').val());
                        <%--                        $("#<%= hdnrate4.ClientID %>").val($('[id*=txt_Rate4]').val());--%>
                        $('[id*=txt_Rate1]').val(0);
                        $('[id*=txt_Rate2]').val(0);
                        $('[id*=txt_Rate3]').val(0);
                        //$('[id*=txt_Rate4]').val(0);

                    }
                    else {
                        var hdnrate1 = $("#<%= hdnrate1.ClientID %>").val();
                        $('[id*=txt_Rate1]').val(hdnrate1);
                        $('[id*=txt_Rate2]').val($('[id*=hdnrate2]').val());
                        $('[id*=txt_Rate3]').val($('[id*=hdnrate3]').val());
                        //$('[id*=txt_Rate4]').val($('[id*=hdnrate4]').val());
                    }
                    checkVoucherDate();
                }
                else {
                    document.getElementById("<%=chk_Sections.ClientID %>").checked = false;
                    alert("Please Select Voucher Date !");
                }
            });



            $("[id*=btnBAC]").click(function () {
                var tbac = '';
                $('#tblMisMatch > tbody  > tr').each(function () {
                    var row = $(this).closest("tr");
                    var b = $("#ddlBAC", row).val();
                    var d = $("#hdnDid", row).val();
                    if (b != undefined) {
                        if (b != '0') {
                            tbac = b + '~' + d + '^' + tbac
                        }
                    }
                });
                var Conn = $("[id*=hdnConnString]").val();
                var compid = $("[id*=hdnCompanyid]").val();
                var Q = $("[id*=hdnQuater]").val();
                var F = $("[id*=hdnForm]").val();

                ShowLoader();
                //Ajax start
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../handler/Voucher.asmx/UpdateBAC",
                    data: '{compid:' + compid + ', Conn:"' + Conn + '", F: "' + F + '", Q: "' + Q + '", B: "' + tbac + '" }',
                    dataType: "json",
                    success: function (msg) {
                        var myList = '';
                        myList = jQuery.parseJSON(msg.d);

                        if (myList.length > 0) {
                            alert('Update Successfull');
                            MisMatch_Vouchers(Q, F);
                        }
                        hideloader();
                    },
                    failure: function (response) {

                    },
                    error: function (response) {

                    }
                });

            });


            $("[id*=btnDT]").click(function () {
                var tbac = '';
                $('#tblMisMatch > tbody  > tr').each(function () {
                    var row = $(this).closest("tr");
                    var b = $("#ddlDType", row).val();
                    var d = $("#hdnDid", row).val();
                    var PAN = row.find("td:eq(1)").html();
                    if (b != undefined) {
                        tbac = b + '~' + d + '~' + PAN + '^' + tbac
                    }
                });
                var Conn = $("[id*=hdnConnString]").val();
                var compid = $("[id*=hdnCompanyid]").val();
                var Q = $("[id*=hdnQuater]").val();
                var F = $("[id*=hdnForm]").val();

                ShowLoader();
                //Ajax start
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../handler/Voucher.asmx/UpdateDeducteeType",
                    data: '{compid:' + compid + ', Conn:"' + Conn + '", F: "' + F + '", Q: "' + Q + '", B: "' + tbac + '" }',
                    dataType: "json",
                    success: function (msg) {
                        var myList = '';
                        myList = jQuery.parseJSON(msg.d);

                        if (myList.length > 0) {
                            alert('Update Successfull');
                            MisMatch_Vouchers(Q, F);
                        }
                        hideloader();
                    },
                    failure: function (response) {

                    },
                    error: function (response) {

                    }
                });

            });

            $("[id*=btnPANLed]").click(function () {
                $("[id*=tblDtype]").show();
            });

            $("[id*=drpBACALL]").change(function () {
                var bac = $("[id*=drpBACALL]").val();
                $('#tblMisMatch > tbody  > tr').each(function () {
                    rw = $(this).closest("tr");
                    $("#ddlBAC", rw).val(bac);
                });
            });

            $("[id*=txtded]").blur(function () {
                var did = $("[id*=hdnDedId]").val();
                if (did != '') {
                    ChangeDeductee(did);
                }

            });

            $("[id*=btnVerify]").click(function () {
                ShowModalPopup();
                loadLoginDetails();
                getCaptcha();
            });

            $("[id*=imgRsh]").click(function () {
                loadLoginDetails();
                getCaptcha();
            });
        });

        function ShowLoader() {

            $('.MastermodalBackground2').css("display", "block");
        }

        function hideloader() {

            $('.MastermodalBackground2').css("display", "none");
        }



        function HideModalPopup() {
            $find("programmaticModalPopupOrginalBehavior").hide();
            $("[id*=lblProcess]").hide();
            $("[id*=lblSuccess]").hide();
            return false;
        }
        ///// show modalpopup
        function ShowModalPopup() {
            $find("programmaticModalPopupOrginalBehavior").show();
            $("[id*=lblProcess]").hide();
            $("[id*=lblSuccess]").hide();
            return false;
        }

        RequestTrace = function () {


            var UserID = $("#txtUserID").val();
            var Password = $("#txtPassword").val();
            var TAN_NO = $("#txtTan").val();
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
                ShowErrorWindow('Enter User Login Details');
                return false;
            }


            if (TAN_NO == null || TAN_NO == undefined) {
                ShowErrorWindow('TAN - Cannot be Blank');
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
            $(".MastermodalBackground2").show();
            document.getElementById("btnGetRequest").disabled = true;

            //debugger;
            $.ajax({
                type: "POST",
                url: "TService.asmx/Challan_Traces",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify(tracesData),
                success: function (data) {
                    HideModalPopup();
                    hideloader();
                    var result = JSON.parse(data.d);
                    if (result.error) {
                        $("#captcha").val("");
                        //getCaptcha();
                        $(".MastermodalBackground2").hide();
                        ShowErrorWindow(result.error);
                        $("[id*=lblSuccess]").hide();
                        $("[id*=lblProcess]").hide();
                        document.getElementById("btnGetRequest").disabled = false;
                        return false;
                    }
                    else {
                        if (result.success) {
                            $("[id*=lblSuccess]").show();
                            $("#captcha").val("");

                            window.location.href = "Challan_Status.aspx";
                            return false;
                        }
                        if (result.timeout) {
                            $("#captcha").val("");

                            return false;
                        }
                        if (result.Failed) {
                            $(".MastermodalBackground2").hide();
                            ShowErrorWindow(result.error);
                            $("[id*=lblSuccess]").hide();
                            $("[id*=lblProcess]").hide();
                            document.getElementById("btnGetRequest").disabled = false;
                        }
                    }
                },
                failure: function (response) {
                    $("#captcha").val("");
                    //getCaptcha();
                    document.getElementById("btnGetRequest").disabled = false;
                    $(".MastermodalBackground2").hide();
                    ShowErrorWindow(response.d);
                }
            });

            return false;
        }


        //reuestDownloads
        SaveTracesDetails = function () {
            debugger;
            var UserID = $("#txtUserID").val();
            var Password = $("#txtPassword").val();
            var TAN_NO = $("input[type=text][id*=txtTanNo]").val();
            var Compid = $("[id*=hdnCompid]").val();

            if (isValid(UserID) || isValid(Password)) {
                ShowWarningWindow('Enter User Login Details');
                return false;
            }


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
                        ShowSuccessWindow('Successfully Saved!!!')
                    }

                    $(".MastermodalBackground2").hide();
                },
                failure: function (response) {
                    $(".MastermodalBackground2").hide();
                    ShowErrorWindow(response.d);
                }
            });


            return false;
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

        function Fiil_deducteeType() {
            var F = $("[id*=ddlForm]").val();
            $("[id*=ddl_Type]").empty();
            $("[id*=ddl_Type]").append("<option value='0'>--Select--</option>");

            $("[id*=ddl_Type]").append("<option value='Company'>Company</option>");
            $("[id*=ddl_Type]").append("<option value='Hindu'>Hindu Undivided Family </option>");
            $("[id*=ddl_Type]").append("<option value='AOP'>Association of Persons (AOP)</option>");
            $("[id*=ddl_Type]").append("<option value='AOPCM'>Association of Persons (Others)</option>");
            $("[id*=ddl_Type]").append("<option value='ST'>Co-operative Society/ Trust</option>");
            $("[id*=ddl_Type]").append("<option value='Firm'>Firm</option>");
            $("[id*=ddl_Type]").append("<option value='BInd'>Body of individuals</option>");
            $("[id*=ddl_Type]").append("<option value='Artificial'>Artificial juridical person</option>");
            $("[id*=ddl_Type]").append("<option value='Others'>Others</option>");
            $("[id*=ddl_Type]").append("<option value='Individual'>Individual</option>");

        }

        function ValidSelect(i) {
            var row = i.closest("tr");
            var b = $("#ddlDType", row).val();
            var d = $("#hdnDid", row).val();
            var PAN = row.find("td:eq(1)").html();
            var P = PAN.substring(4, 3);
            if (P == 'P' && b == 'Individual') {
                $("#ddlDType", row).val('Individual');
            }
            else if (P == 'C' && b == 'Company') {
                $("#ddlDType", row).val('Company');
            }

            else if (P == 'H' && b == 'Hindu') {
                $("#ddlDType", row).val('Hindu');
            }
            else if (P == 'A' && b == 'AOP') {
                $("#ddlDType", row).val('AOP');
            }
            else if (P == 'B' && b == 'BInd') {
                $("#ddlDType", row).val('BInd');
            }
                //else if (P == 'G' && b == 'GA') {
                //    $("[id*=drp_Type]").val('GA');
                //}
            else if (P == 'J' && b == 'Artificial') {
                $("#ddlDType", row).val('Artificial');
            }
                //else if (P == 'L' && b == 'Individual') {
                //    $("[id*=drp_Type]").val('Individual');
                //}
            else if (P == 'F' && b == 'Firm') {
                $("#ddlDType", row).val('Firm');
            }
            else if (P == 'T' && b == 'Trust') {
                $("#ddlDType", row).val('Trust');
            }
            else if (b == 'Others') {

                $("#ddlDType", row).val('Others');
            }
            else {
                alert('Incorrect Deductee Type 4 Charater of PAN. Click on Understanding PAN');
                $("#ddlDType", row).val(0);
            }
        }

        //function txt_NetAmount1_Keyup(event) {
        //    if (event.keyCode != '9') {
        //        if (isNaN(parseFloat($("[id*=txt_NetAmount1]").val()))) {
        //            $("[id*=txt_NetAmount1]").val('');
        //        } else {
        //            $("[id*=txt_NetAmount1]").val(parseFloat($("[id*=txt_NetAmount1]").val()).toString());
        //        }
        //        checkVoucherDate();
        //    }
        //    //if (event.keyCode == '9') {
        //    //    setNumericFormat();
        //    //}
        //}

        function txt_Rate1_Keyup(event) {
            if (event.keyCode != '9') {
                if (isNaN(parseFloat($("[id*=txt_NetAmount1]").val()))) {
                    $("[id*=txt_NetAmount1]").val('');
                } else {
                    $("[id*=txt_NetAmount1]").val(parseFloat($("[id*=txt_NetAmount1]").val()).toString());
                }
                checkVoucherDate();
            }
            //if (event.keyCode == '9') {
            //    setNumericFormat();
            //}
        }

        function txt_Sur_Keyup(event) {
            if (event.keyCode != '9') {
                if (isNaN(parseFloat($("[id*=txt_NetAmount2]").val()))) {
                    $("[id*=txt_NetAmount2]").val('');
                } else {
                    $("[id*=txt_NetAmount2]").val(parseFloat($("[id*=txt_NetAmount2]").val()).toString());
                }
                checkVoucherDate();
            }
            //if (event.keyCode == '9') {
            //    setNumericFormat();
            //}
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
            //if (event.keyCode == '9') {
            //    setNumericFormat();
            //}
        }


        function pageLoad() {
            $(':text').bind('keydown', function (e) { //on keydown for all textboxes

                if (e.keyCode == 13) //if this is enter key

                    e.preventDefault();

            });
        }

        function checkVoucherDate() {
            var date = document.getElementById("<%=txt_VoucherDate.ClientID%>").value;
            if (date != "") {
                CalCualteNetAmount();
            }
            else {
                alert("Please Select Voucher Date !");
            }
        }

        function sectioncheck() {

        }

        function checksectionwithcal() {
            var date = document.getElementById("<%=txt_VoucherDate.ClientID%>").value;
            if (date != "") {
                CalCualteNetAmount();

            }
            else {
                $('[id*=txt_NetAmount1]').val(0);
                document.getElementById("<%=chk_Sections.ClientID %>").checked = false;
                alert("Please Select Voucher Date !");
            }
        }

        function CalCualteNetAmount() {

            //////////////net amount get
            /// Voucher Amt
            var txt_NetAmount1 = $('[id*=txt_NetAmount1]').val();
            var r = txt_NetAmount1;
            var j;
            j = r.indexOf(".");
            if (j == 0) {
                txt_NetAmount1 = txt_NetAmount1 + '.00';
            }
            $('[id*=txt_NetAmount1]').val(txt_NetAmount1);

            if (isNaN(parseFloat(txt_NetAmount1))) {
                txt_NetAmount1 = "0.00";
                $('[id*=txt_NetAmount1]').val(0.00)
            }

            //////////////rate1 get
            var txt_Rate1 = $('[id*=txt_Rate1]').val();
            if (isNaN(parseFloat(txt_Rate1))) {
                txt_Rate1 = "0.00";
                $('[id*=txt_Rate1]').val(0.00);
            }
            ///////////////amount 1 set
            //// Tds Amt
            if (parseFloat(txt_Rate1) > 0) {
                var total = (parseFloat(txt_NetAmount1) * parseFloat(txt_Rate1)) / 100;
                total =Math.round(total) + '.00';
                $('[id*=txt_Amount1]').val(total);

            }
            else {
                $('[id*=txt_Amount1]').val(0.00);
            }

            //////////////amount 1 get
            var txt_Amount1 = $('[id*=txt_Amount1]').val();
            if (isNaN(parseFloat(txt_Amount1))) {
                txt_Amount1 = "0.00";
            }

            ///////////////amount 2 set
            /// Surcharge
            var txt_Amount2 = $('[id*=txt_Amount2]').val();
            if (isNaN(parseFloat(txt_Amount2))) {
                txt_Amount2 = "0.00";
                $('[id*=txt_Amount2]').val(0.00);
            }

            ///////////////net amount2 set
            var Amt2 = Math.round(parseFloat(txt_Amount1) + parseFloat(txt_Amount2)) + '.00';
            $('[id*=txt_NetAmount2]').html(Amt2);


            ///////////////net amount 2 get 
            var txt_NetAmount2 = $('[id*=txt_NetAmount2]').html();

            ///////////////amount 3 set
            //// Cess
            var txt_Amount3 = $('[id*=txt_Amount3]').val();
            if (isNaN(parseFloat(txt_Amount3))) {
                txt_Amount3 = "0.00";
                $('[id*=txt_Amount3]').val(0.00);
            }

            //////////////set netamount 3
            var Amt3 = Math.round(parseFloat(txt_Amount3) + parseFloat(txt_NetAmount2)) + '.00';
            $('[id*=txt_NetAmount3]').html(Amt3);

            //////////////get netamount 3
            var txt_NetAmount3 = $('[id*=txt_NetAmount3]').html();

            var AmtNet = Math.round(parseFloat(txt_NetAmount3)) + '.00';
            $('[id*=txt_NetAmounttotal]').html(AmtNet);

            $('[id*=hdntxt_NetAmounttotal]').val(Math.round(parseFloat(txt_NetAmount3)));


        }


        function ValidateDate(sender, args) {

        }


        function getNatureSubId() {
            ShowLoader();
            var n = $("[id*=ddl_Nature]").val();
            var t = $("[id*=ddl_Type]").val();
            if (n == undefined) {
                hideloader();
                return;
            }
            if (t == undefined) {
                hideloader();
                return;
            }

            if (n == '0') {
                hideloader();
                return;
            }
            if (t == '0') {
                hideloader();
                return;
            }
            //Ajax start
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../handler/Ws_PanNo.asmx/Get_NatureSubId",
                data: '{n:' + n + ',t:"' + t + '"}',
                dataType: "json",
                success: function (msg) {
                    var myList = '';
                    myList = jQuery.parseJSON(msg.d);

                    if (myList == undefined) {

                    }
                    else if (myList.length > 0) {
                        myList = myList[0];
                        var Sec = myList.Lst_Sec;   //

                        $('[id*=hdnNatureSubID]').val(myList.Nature_Sub_Id);
                        var did = $("[id*=hdnDedId]").val();   //$("[id*=ddl_DeducteeName]").val();
                        var x = $("[id*=hdnSection]").val();
                        if (x == '') {
                            $("[id*=ddl_Reasons]").empty();
                            $("[id*=ddl_Reasons]").append("<option value='0'>--Select Reasons--</option>");
                            for (var i = 0; i < myList.Lst_Sec.length; i++) {
                                $("[id*=ddl_Reasons]").append("<option value='" + Sec[i].Section_Id + "'>" + Sec[i].Section + "</option>");
                            }
                            $("[id*=hdnSection]").val('1');
                        }
                        if (did != '' && did != undefined && did != '0') {
                            var rt = $("[id*=txt_Rate1]").val();
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
                    hideloader();
                },
                failure: function (response) {

                },
                error: function (response) {

                }
            });
        }

        function Edit_Show(i) {
            $("[id*=btnAdd]").hide();
            var row = i.closest("tr");
            var mth = row.find("input[name=hdnMth]").val();
            $("[id*=hdnPages]").val(1);
            $("[id*=hndCurrmth]").val(mth);
            UP = 0;
            NT = $("[id*=ddlSearchNature]").val();
            if (NT == null) {
                NT = '';
            }
            p = $("[id*=ddlperpage]").val();

            ModifyGrid(mth, 1, p, UP);
        }

        function Edit_ShowUP(i) {
            $("[id*=btnAdd]").hide();
            var row = i.closest("tr");
            var mth = row.find("input[name=hdnMth]").val();
            $("[id*=hndCurrmth]").val(mth);
            UP = 1;
            p = $("[id*=ddlperpage]").val();
            NT = $("[id*=ddlSearchNature]").val();
            if (NT == null) {
                NT = '';
            }
            ModifyGrid(mth, 1, p, UP);
        }

        function getDropdown() {
            ShowLoader();
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
                url: "../handler/Voucher.asmx/GetDropdowns",
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
                        $("[id*=dgVoucherEntries] tbody").empty();

                        tbl = tbl + "<tr >";
                        tbl = tbl + "<th style='text-align: center; width:30%;' class='cssGridHeader'>Month</th>";
                        tbl = tbl + "<th style='width:10%;' class='cssGridHeader'>Entries</th>";
                        tbl = tbl + "<th style='width:30%;' class='cssGridHeader'>Amount</th>";
                        tbl = tbl + "<th style='width:30%;' class='cssGridHeader'>TDS</th>";
                        tbl = tbl + "<th style='width:30%;' class='cssGridHeader'>Unpaid</th>";

                        tbl = tbl + "</tr>";

                        if (Grd.length > 0) {
                            for (var i = 0; i < Grd.length; i++) {
                                tbl = tbl + "<tr>";
                                tbl = tbl + "<td style='text-align: left;' class='cssGrdAlterItemStyle'  onclick='Edit_Show($(this))'>" + Grd[i].mth + "<input type='hidden' id='hdnMth' value='" + Grd[i].mthno + "' name='hdnMth'></td>";
                                tbl = tbl + "<td style='text-align: left;' class='cssGrdAlterItemStyle'  onclick='Edit_Show($(this))'>" + Grd[i].Entries + "</td>";
                                tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' onclick='Edit_Show($(this))'>" + Grd[i].Amt + '.00' + "</td>";
                                tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' onclick='Edit_Show($(this))'>" + Grd[i].Tds + '.00' + "</td>";
                                tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' ><label id='lblup' onclick='Edit_ShowUP($(this))'> " + Grd[i].Upaid + "</label></td></tr>";
                            };

                            //// Footer
                            tbl = tbl + "<tr>";
                            tbl = tbl + "<td style='text-align: left;' class='cssGridHeader'>Total</td>";
                            tbl = tbl + "<td style='text-align: left;' class='cssGridHeader'>" + Grd[0].Tent + "</td>";
                            tbl = tbl + "<td style='text-align: right;' class='cssGridHeader'>" + Grd[0].TAmt + '.00' + "</td>";
                            tbl = tbl + "<td style='text-align: right;' class='cssGridHeader'>" + Grd[0].TTds + '.00' + "</td>";
                            tbl = tbl + "<td style='text-align: right;' class='cssGridHeader'>" + Grd[0].Tup + "</td></tr>";

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
                    }
                    else {

                        var M = $("[id*=hdnMis]").val();
                        M = M.split(',');
                        var f = M[1];
                        var q = M[2];
                        $("[id*=drpQua]").val(q);
                        $("[id*=drpForm]").val(f);
                        $("[id*=tbl_VoucherModify]").show();
                        $("[id*=dgVoucherModify]").hide();
                        $("[id*=divMisMatch]").show();
                        $("[id*=divModify]").hide();
                        $("[id*=tdSearch]").hide();
                        $("[id*=btnVerify]").hide();
                        $("[id*=Label1]").html('MisMatch Voucher Entries');
                        getNature_Branch_Drps();
                        MisMatch_Vouchers(q, f);
                    }

                    ///// Challan
                    var tbl = '';
                    $("[id*=tblChallan] tbody").empty();

                    tbl = tbl + "<tr >";
                    tbl = tbl + "<th style='text-align: center; width:10%;' class='cssGridHeader'>Chln No</th>";
                    tbl = tbl + "<th class='cssGridHeader' style='width:5%; text-align: center; font - weight: bold;' >Vchr</th>";
                    tbl = tbl + "<th style='width:10%;' class='cssGridHeader'>Chln Date</th>";
                    tbl = tbl + "<th style='width:15%;' class='cssGridHeader'>Amount</th>";
                    tbl = tbl + "<th class='cssGridHeader' style='width:15%; text-align: center; font - weight: bold;' >Consumed</th>";
                    tbl = tbl + "<th class='cssGridHeader' style='width:15%; text-align: center; font - weight: bold;' >Diff</th>";
                    tbl = tbl + "<th style='width:20%;' class='cssGridHeader'>Total</th>";
                    tbl = tbl + "<th style='width:20%;' class='cssGridHeader'>Verify</th>";

                    tbl = tbl + "</tr>";
                    if (Chl.length > 0) {
                        for (var i = 0; i < Chl.length; i++) {
                            tbl = tbl + "<tr>";
                            tbl = tbl + "<td style='text-align: left;' class='cssGrdAlterItemStyle'  >" + Chl[i].ChallanNo + "<input type='hidden' id='hdnMth' value='" + Chl[i].mthno + "' name='hdnMth'></td>";
                            tbl = tbl + "<td style='text-align: left;' class='cssGrdAlterItemStyle' >" + Chl[i].VouchersCount + "</td>";
                            tbl = tbl + "<td style='text-align: left;' class='cssGrdAlterItemStyle' >" + Chl[i].ChallanDate + "</td>";
                            tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' >" + Chl[i].TDS + '.00' + "</td>";
                            tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' >" + Chl[i].Vtds + '.00' + "</td>";
                            tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' >" + Chl[i].Diff + '.00' + "</td>";
                            tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' >" + Chl[i].CAmount + '.00' + "</td>";
                            var v = Chl[i].Verify;
                            if (v == 'UnMatched') {
                                tbl = tbl + "<td style='text-align: right; color:red;' class='cssGrdAlterItemStyle' >" + Chl[i].Verify + "</td>";
                            }
                            else if (v == 'Null' || v == '') {
                                tbl = tbl + "<td style='text-align: right; color:red;' class='cssGrdAlterItemStyle' >Not Verified</td>";
                            }
                            else {
                                tbl = tbl + "<td style='text-align: right; color:green;' class='cssGrdAlterItemStyle' >" + Chl[i].Verify + "</td>";
                            }
                            tbl = tbl + "</tr > ";
                        };

                        //// Footer
                        tbl = tbl + "<tr>";
                        tbl = tbl + "<td style='text-align: left;' class='cssGridHeader'>Total</td>";
                        tbl = tbl + "<td style='text-align: right;' class='cssGridHeader'></td>";
                        tbl = tbl + "<td style='text-align: right;' class='cssGridHeader'></td>";
                        tbl = tbl + "<td style='text-align: right;' class='cssGridHeader'></td>";
                        tbl = tbl + "<td style='text-align: right;' class='cssGridHeader'></td>";
                        tbl = tbl + "<td style='text-align: right;' class='cssGridHeader'></td>";
                        tbl = tbl + "<td style='text-align: right;' class='cssGridHeader'>" + Chl[0].CTotal + '.00' + "</td>";
                        tbl = tbl + "<td style='text-align: right;' class='cssGridHeader'></td>";

                        tbl = tbl + "</tr>"
                        $("[id*=tblChallan]").append(tbl);
                    }
                    else {
                        tbl = tbl + "<tr>";

                        tbl = tbl + "<td ></td>";
                        tbl = tbl + "<td >No Record Found !!!</td>";
                        tbl = tbl + "<td ></td>";
                        tbl = tbl + "<td></td>";
                        tbl = tbl + "<td ></td>";
                        tbl = tbl + "<td ></td>";
                        tbl = tbl + "<td></td>";
                        tbl = tbl + "<td ></td>";
                        tbl = tbl + "</tr>";
                        $("[id*=tblChallan]").append(tbl);

                    }

                    hideloader();
                },
                failure: function (response) {

                },
                error: function (response) {

                }
            });

        }

        //function txt_ded_Keyup() {
        //    initFromField();
        //}

        $(function () {
            initFromField();
        });
        function constructMap(data, map) {
            var objects = [];
            $.each(data, function (i, object) {
                var id = object.deducteeid;
                var name = object.Dname;
                map[name] = { id: id, name: name };
                //map[object.Dname] = object ;
                //map[object.deducteeid] = object;
                //objects.push(object.Dname);
                objects.push(name);
            });
            return objects;
        }
        function initFromField() {

            var map;
            $('#the-basics .typeahead').typeahead({
                source: function (query, process) {
                    map = {};
                    var compid = $("[id*=hdnCompanyid]").val();
                    var Conn = $("[id*=hdnConnString]").val();
                    var Q = $("[id*=hdnQuater]").val();
                    var F = $("[id*=hdnForm]").val();
                    var D = $("[id*=txtded]").val();
                    if (F == '0') { F = ''; }
                    if (D == '') { return; }
                    if (D != '' && D.length >= 2) {
                        //  var data = [{ "id": 1, "label": "machin" }, { "id": 2, "label": "truc" }] // Or get your JSON dynamically and load it into this variable
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../handler/Voucher.asmx/Get_TypeAhead",
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
        }

        $(function () {
            initDeducteeSrch();
        });
        function Srch_ConstructMap(data, map) {
            var objects = [];
            $.each(data, function (i, object) {
                var id = object.deducteeid;
                var name = object.Dname;
                map[name] = { id: id, name: name };
                //map[object.Dname] = object ;
                //map[object.deducteeid] = object;
                //objects.push(object.Dname);
                objects.push(name);
            });
            return objects;
        }
        function initDeducteeSrch() {
            var map;
            $('#the-src .typeahead').typeahead({
                source: function (query, process) {
                    map = {};
                    var compid = $("[id*=hdnCompanyid]").val();
                    var Conn = $("[id*=hdnConnString]").val();
                    var Q = $("[id*=hdnQuater]").val();
                    var F = $("[id*=hdnForm]").val();
                    var D = $("[id*=txtSearchDeducteeName]").val();
                    if (F == '0') { F = ''; }
                    if (Q == '0') { Q = ''; }

                    //  var data = [{ "id": 1, "label": "machin" }, { "id": 2, "label": "truc" }] // Or get your JSON dynamically and load it into this variable
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../handler/Voucher.asmx/Get_TypeAhead",
                        data: '{compid:' + compid + ', Conn:"' + Conn + '", F: "' + F + '", D: "' + D + '"}',
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
                    //objects = constructMap(data, map);
                    //process(objects);
                },
                updater: function (item) {
                    // $('#hdnDedId').val(map[item].id);
                    var did = map[item].id
                    $("[id*=hdnSrchDed]").val(did);
                    SearchDeductee(did);
                    return item;

                }
            });
        }

        function SearchDeductee(did) {
            var p = $("[id*=ddlperpage]").val();
            var d = did;   //$("[id*=ddlSearchDeducteeName]").val();
            var n = $("[id*=ddlSearchNature]").val();
            var ch = $("[id*=ddlSearchChallanStatus]").val();
            var mth = $("[id*=hndCurrmth]").val();
            $("[id*=hdnPages]").val(1);
            Search_Grid(mth, 1, p, d, ch, n);

        }

        function ChangeDeductee(did) {
            var d = $("[id*=hdnDedId]").val(); //$("[id*=ddl_DeducteeName]").val();
            var Conn = $("[id*=hdnConnString]").val();
            var compid = $("[id*=hdnCompanyid]").val();
            var F = $("[id*=hdnForm]").val();
            if (d == '') {
                return;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../handler/Voucher.asmx/Deductee_Details",
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

                        $("[id*=drpBAC1A]").val(myList[0].BAC1A);
                        $("[id*=txt_PANNumber]").val(myList[0].PAN);
                        if (myList[0].PAN_AAdhar == '0.00') {
                            $("[id*=lblPANsts]").html('Not Verified');
                        }
                        else if (myList[0].PAN_AAdhar == '') {
                            $("[id*=lblPANsts]").html('Not Verified');
                        }
                        else {
                            $("[id*=lblPANsts]").html(myList[0].PAN_AAdhar);
                        }
                        $("[id*=hdnisNri]").val(myList[0].isNri);
                        // $("[id*=ddl_Nature]").val(myList[0].nid);
                        //$("[id*=hdnNatureFromType]").val(myList[0].formType);
                        //if (parseFloat(myList[0].Compliance) == 1) {
                        //    alert('Compliance 206AB , 206CCA Check failed, deduction rate 5% or 20% whichever is higher');
                        //}

                        var PAN = myList[0].PAN;
                        var PChar = PAN.substring(4, 3);
                        ChangeType(PChar);
                        //$("[id*=ddl_DeducteeName]").attr("disabled", false);
                        var rs = myList[0].sec;
                        ////////////////// Check certificate applicable or not


                        //$("[id*=ddl_Reasons]").val(myList[0].rsid);
                        $("[id*=txt_Rate1]").val(myList[0].Rate);
                        var Nat = myList[0].Lst_Nature;
                        if (Nat.length > 0) {
                            $("[id*=ddl_Nature]").val(Nat[0].Nature_ID);
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

                            $("[id*=ddl_Remittance]").val(0);
                            $("[id*=ddl_Country]").val(myList[0].Countryid);
                            $("[id*=txtAddress]").val(myList[0].Add1);
                            $("[id*=txtCno]").val(myList[0].Cnumber);
                            $("[id*=txtEmail]").val(myList[0].Email);
                            $("[id*=TxtTax]").val(myList[0].TaxId);
                            $("[id*=ddlRate]").val(myList[0].RT);
                        }


                        var Sec = myList[0].Lst_Sec;    
                        var x = $("[id*=hdnSection]").val();
                        if (x == '') {
                            $("[id*=ddl_Reasons]").empty();
                            $("[id*=ddl_Reasons]").append("<option value='0'>--Select Reasons--</option>");
                            if (Sec.length > 0) {
                                for (var i = 0; i < Sec.length; i++) {
                                    $("[id*=ddl_Reasons]").append("<option value='" + Sec[i].Section_Id + "'>" + Sec[i].Section + "</option>");
                                }
                                $("[id*=hdnSection]").val('1');
                            }
                        }
                        //var rs = $("[id*=ddl_Reasons]").val();
                        if (rs != 'Non-Availability of PAN C' && PAN != 'PANNOTAVBL') {
                            $("[id*=ddl_Reasons]").val(rs);
                        }

                        if (PAN == 'PANNOTAVBL') {
                            $("[id*=ddl_Reasons]").val('Non-Availability of PAN C');
                        }
                        //if (rs == 'Lower Rt. Under Section 197 A') {
                        $("[id*=txt_TDSCert]").removeAttr("disabled");
                        //}
                        //else {
                        //    $("[id*=txt_TDSCert]").val('');

                        //    $("[id*=txt_TDSCert]").attr("disabled", "false");
                        //}

                    }


                    //  FillLastGrid(d);
                },
                failure: function (response) {

                },
                error: function (response) {

                }
            });
        }

        //$('.typeahead').on('typeahead:selected', function (evt, item) {
        //    // do what you want with the item here
        //    alert(item);
        //})

        function ChangeType(P) {

            if (P == 'P') {
                $("[id*=ddl_Type]").val('Individual');
            }
            else if (P == 'C') {
                $("[id*=ddl_Type]").val('Company');
            }

            else if (P == 'H' ) {
                $("[id*=ddl_Type]").val('Hindu');
            }
            else if (P == 'A') {
                $("[id*=ddl_Type]").val('AOP');
            }
            else if (P == 'B' ) {
                $("[id*=ddl_Type]").val('BInd');
            }

            else if (P == 'J' ) {
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
            else if (P == 'N')
            {
                $("[id*=ddl_Type]").val(0);
            }
            else {
                alert('Incorrect Deductee Type 4 Charater of PAN. Click on Understanding PAN');
                $("[id*=ddl_Type]").val(0);
            }
        }

        function getNature_Branch_Drps() {
            ShowLoader();
            var compid = $("[id*=hdnCompanyid]").val();
            var Conn = $("[id*=hdnConnString]").val();
            var F = $("[id*=hdnForm]").val();
            //Ajax start
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../handler/Voucher.asmx/Get_Nature_Branch_Drp",
                data: '{compid:' + compid + ', Conn:"' + Conn + '", F:"' + F + '"}',
                dataType: "json",
                success: function (msg) {
                    main_obj = jQuery.parseJSON(msg.d);
                    main_obj = main_obj[0];

                    var Nature = main_obj.Nature;   //
                    var Remitance = main_obj.Remitance;    //
                    var Country = main_obj.Country;
                    var Branch = main_obj.Branch;    //

                    var x = $("[id*=hdnDrps]").val();

                    if (x == '') {
                        //$("[id*=ddl_Nature]").selectize()[0].selectize.destroy();
                        //$("[id*=ddlSearchNature]").selectize()[0].selectize.destroy();
                        $("[id*=ddl_Nature]").empty();
                        $("[id*=ddlSearchNature]").empty();
                        $("[id*=ddl_Nature]").append("<option value=0>--Select--</option>");
                        $("[id*=ddlSearchNature]").append("<option value=0>--Select--</option>");
                        //  $("[id*=ddl_Nature]").find('option').remove().end();


                        for (var i = 0; i < main_obj.Nature.length; i++) {

                            $("[id*=ddl_Nature]").append("<option value='" + Nature[i].Nature_ID + "'>" + Nature[i].NatureName + "</option>");
                        }

                        $("[id*=ddl_Remittance]").empty();
                        $("[id*=ddl_Remittance]").append("<option value=0>--Select--</option>");

                        for (var i = 0; i < main_obj.Remitance.length; i++) {

                            $("[id*=ddl_Remittance]").append("<option value='" + Remitance[i].rcode + "'>" + Remitance[i].remittance + "</option>");
                        }


                        $("[id*=ddl_Country]").empty();
                        $("[id*=ddl_Country]").append("<option value=0>--Select--</option>");

                        for (var i = 0; i < main_obj.Country.length; i++) {

                            $("[id*=ddl_Country]").append("<option value='" + Country[i].Countryid + "'>" + Country[i].Country + "</option>");
                        }

                        $("[id*=ddlBranch]").empty();
                        $("[id*=ddlBranch]").append("<option value=0>--Select--</option>");

                        for (var i = 0; i < main_obj.Branch.length; i++) {

                            $("[id*=ddlBranch]").append("<option value='" + Branch[i].bid + "'>" + Branch[i].Bname + "</option>");
                        }

                        ////////////// Clone Dropdowns

                        var first = $("[id*=ddl_Nature]");
                        var second = $("[id*=ddlSearchNature]");
                        var options = first[0].innerHTML;
                        var options = second[0].innerHTML + options;

                        second[0].innerHTML = options;
                        //$("[id*=ddl_Nature]").selectize();
                        //$("[id*=ddlSearchNature]").selectize();
                        $("[id*=hdnDrps]").val('1');
                        $("[id*=ddlSearchNature]").val(0);
                    }


                    hideloader();
                },
                failure: function (response) {

                },
                error: function (response) {

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
                url: "../handler/Voucher.asmx/FillGrd",
                data: '{compid:' + compid + ',did:"' + did + '", Conn:"' + Conn + '", F:"' + F + '", Q: "' + Q + '"}',
                dataType: "json",
                success: function (msg) {
                    var Grd = jQuery.parseJSON(msg.d);
                    var tbl = '';
                    $("[id*=dgVoucherEntries] tbody").empty();

                    tbl = tbl + "<tr >";
                    tbl = tbl + "<th style='text-align: center; width:30%;' class='cssGridHeader'>Month</th>";
                    tbl = tbl + "<th style='width:10%;' class='cssGridHeader'>Entries</th>";
                    tbl = tbl + "<th style='width:30%;' class='cssGridHeader'>Amount</th>";
                    tbl = tbl + "<th style='width:30%;' class='cssGridHeader'>TDS</th>";
                    tbl = tbl + "<th style='width:30%;' class='cssGridHeader'>Unpaid</th>";

                    tbl = tbl + "</tr>";

                    if (Grd.length > 0) {
                        for (var i = 0; i < Grd.length; i++) {
                            tbl = tbl + "<tr >";
                            tbl = tbl + "<td style='text-align: left;' class='cssGrdAlterItemStyle' onclick='Edit_Show($(this))'>" + Grd[i].mth + "<input type='hidden' id='hdnMth' value='" + Grd[i].mthno + "' name='hdnMth'></td>";
                            tbl = tbl + "<td style='text-align: left;' class='cssGrdAlterItemStyle' onclick='Edit_Show($(this))'>" + Grd[i].Entries + "</td>";
                            tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' onclick='Edit_Show($(this))'>" + Grd[i].Amt + '.00' + "</td>";
                            tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' onclick='Edit_Show($(this))'>" + Grd[i].Tds + '.00' + "</td>";
                            tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' ><label id='lblup' onclick='Edit_ShowUP($(this))'> " + Grd[i].Upaid + "</label></td></tr>";
                        };
                        //// Footer
                        tbl = tbl + "<tr>";
                        tbl = tbl + "<td style='text-align: left;' class='cssGridHeader'>Total</td>";
                        tbl = tbl + "<td style='text-align: left;' class='cssGridHeader'>" + Grd[0].Tent + "</td>";
                        tbl = tbl + "<td style='text-align: right;' class='cssGridHeader'>" + Grd[0].TAmt + '.00' + "</td>";
                        tbl = tbl + "<td style='text-align: right;' class='cssGridHeader'>" + Grd[0].TTds + '.00' + "</td>";
                        tbl = tbl + "<td style='text-align: right;' class='cssGridHeader'>" + Grd[0].Tup + "</td></tr>";

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



                },
                failure: function (response) {

                },
                error: function (response) {

                }
            });
        }

        function chkAllselect(i) {
            var chkprop = i.is(':checked');

            $("input[name=chkEjob]").each(function () {

                if (chkprop) {
                    $(this).attr('checked', 'checked');
                }
                else {
                    $(this).removeAttr('checked'); //sftrow.css('display', 'none'); 
                }
            });
        }

        function ModifyGrid(mth, pageIndex, Pagesize, UP) {
            ShowLoader();
            var Conn = $("[id*=hdnConnString]").val();
            var c = $("[id*=hdnCompanyid]").val();
            if (UP == '') {
                UP = 0;
            }
            
            var RecordCount = 0;
            var ch = '';
            var d = parseFloat(ddid);

            var n = NT;
            var F = $("[id*=ddlForm]").val();
            var Q = $("[id*=ddltype]").val();
            if (d == undefined) {
                d = '0';
            }
            $("[id*=ddltype]").attr('disabled', true);
            $("[id*=ddlForm]").attr('disabled', true);
            //$("[id*=ddlSearchDeducteeName]").val();
            getNature_Branch_Drps();
            var fltr = $("[id*=hdnForm]").val();
            $("[id*=divMisMatch]").hide();
            $("[id*=divModify]").show();
            $("[id*=tbl_VoucherModify]").show();
            $("[id*=dgVoucherModify]").show();

            $("[id*=tdSearch]").hide();
            $("[id*=btnVerify]").hide();
            $("[id*=btnCancel]").show();
            $("[id*=hdnMis]").val('');
            Mis = '';

            //Ajax start
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../handler/Voucher.asmx/ModifyGrd",
                data: '{c:' + c + ', mth:' + mth + ',pI:' + pageIndex + ',pS:' + Pagesize + ', Conn:"' + Conn + '", d:"' + d + '",  n:"' + n + '", ch:"' + ch + '",  U:' + UP + ',fltr:"' + fltr + '",  F:"' + F + '",Q:"' + Q + '"}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);

                    var tbl = '';
                    $("[id*=txtAmtpd]").val(0.00);
                    $("[id*=txtTDS]").val(0.00);

                    $("[id*=dgVoucherModify] tbody").empty();

                    tbl = tbl + "<tr>";
                    tbl = tbl + "<th  style='text-align: center;'>Payment Date</th>";
                    tbl = tbl + "<th >Deductee</th>";
                    tbl = tbl + "<th >Section</th>";
                    tbl = tbl + "<th >Amount Paid</th>";
                    tbl = tbl + "<th >TDS</th>";
                    tbl = tbl + "<th >Chln No</th>";
                    tbl = tbl + "<th >Chln Paid</th>";
                    tbl = tbl + "<th >Edit</th>";
                    tbl = tbl + "<th >Delete<input type='checkbox' id='chkAll' name='chkAll' onclick='chkAllselect($(this))'></td></th>";
                    tbl = tbl + "</tr>";

                    if (myList.length > 0) {
                        var amtlist = myList[0].LTDSgrid;
                        var j = '';
                        for (var i = 0; i < myList.length; i++) {


                            tbl = tbl + "<tr>";
                            tbl = tbl + "<td style='text-align: center;'>" + myList[i].PDate + "<input type='hidden' id='hdndid' value='" + myList[i].did + "' name='hdndid'></td>";
                            tbl = tbl + "<td style='text-align: left;'>" + myList[i].DName + "<input type='hidden' id='hdnvid' value='" + myList[i].vid + "' name='hdnvid'></td>";
                            tbl = tbl + "<td style='text-align: right;'>" + myList[i].sec + "</td>";
                            tbl = tbl + "<td style='text-align: right;'>" + myList[i].AmtPaid + "</td>";
                            tbl = tbl + "<td style='text-align: right;'>" + myList[i].TdsAmt + "</td>";
                            tbl = tbl + "<td style='text-align: right;'>" + myList[i].BnkChl + "</td>";
                            if (parseFloat(myList[i].CPaid) > 0) {
                                tbl = tbl + "<td style='text-align: center;'><img src='../images/valid.png' style='cursor:pointer; height:18px; width:18px;' id='imgCPaid' name='imgCPaid'><input type='hidden' id='hdnCid' value='" + myList[i].CPaid + "' name='hdnCid'></td>";
                            }
                            else {
                                tbl = tbl + "<td style='text-align: center;'><img src='../images/invalid.png' style='cursor:pointer; height:18px; width:18px;' id='imgCNot' name='imgCNot'><input type='hidden' id='hdnCid' value='" + myList[i].CPaid + "' name='hdnCid'></td>";
                            }

                            tbl = tbl + "<td style='text-align: center;'><img src='../images/edit.png' style='cursor:pointer; height:18px; width:18px;' onclick='Edit_Rec($(this))' id='stfEdit' name='stfEdit'></td>";

                            tbl = tbl + "<td style='text-align: center;'><input type='checkbox' id='chkEjob' name='chkEjob' value='" + myList[i].vid + "' ></td></tr>"
                            //tbl = tbl + "<td style='text-align: center;'><img src='../images/delete.png' style='cursor:pointer; height:18px; width:18px;' onclick='Del_Rec($(this))' id='stfDel' name='stfDel'></td>";

                        };
                        $("[id*=dgVoucherModify]").append(tbl);
                        $("[id*=txtAmtpd]").val(amtlist[0].Amt);
                        $("[id*=txtTDS]").val(amtlist[0].TDS);

                        if (parseFloat(myList[0].Totalcount) > 0) {
                            RecordCount = parseFloat(myList[0].Totalcount);

                        }
                        $("[id*=tbl_VoucherModify]").show();
                        $("[id*=tdSearch]").hide();
                        $("[id*=btnVerify]").hide();
                        $("[id*=btnCancel]").show();
                        Pager(RecordCount, mth, UP);
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

                    hideloader();
                },
                failure: function (response) {

                },
                error: function (response) {

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
                UP = $("[id*=ddlSearchChallanStatus]").val();
                p = $("[id*=ddlperpage]").val();
                if (UP == '') { UP == 0; }
                ModifyGrid(mth, ($(this).attr('page')), p, UP);
            });
        }

        function GetRate() {
            ShowLoader();
            var nsid = $("[id*=hdnNatureSubID]").val();
            var dT = $("[id*=txt_VoucherDate]").val();
            var Conn = $("[id*=hdnConnString]").val();
            var compid = $("[id*=hdnCompanyid]").val();
            var nid = $("[id*=ddl_Nature]").val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../handler/Voucher.asmx/Deductee_Rate",
                data: '{compid:' + compid + ',nsid:"' + nsid + '", dT:"' + dT + '", Conn:"' + Conn + '", nid:' + nid + '}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    if (myList == null) {
                        alert('194J Section is not applicable for current date')
                        $("[id*=ddl_Nature]").val(0);
                        $("[id*=btnSave]").hide();
                        hideloader();
                        return;
                    }
                    if (myList.length > 0) {
                        var r = myList[0].Rate;
                        var j;
                        j = r.indexOf(".");
                        if (j > 0) {
                            r = r.split('.');
                            j = r[1].length;
                            if (j == 1) {
                                r = myList[0].Rate;
                                r = r + '000';
                            }
                            else if (j == 2) {
                                r = myList[0].Rate;
                                r = r + '00';
                            }
                            else if (j == 3) {
                                r = myList[0].Rate;
                                r = r + '0';
                            }
                            $("[id*=txt_Rate1]").val(r);
                        }
                        else {
                            r = myList[0].Rate;
                            r = r + '.0000';

                            $("[id*=txt_Rate1]").val(r);
                        }

                        $("[id*=btnSave]").show();
                        if (myList[0].VDT >= '05/15/2020' && myList[0].nid >= 13) {
                            $("[id*=btnSave]").hide();
                            alert('Section 194J has changed');
                        }

                    }
                    hideloader();
                },
                failure: function (response) {

                },
                error: function (response) {

                }
            });


        }

        function MisMatch_Vouchers(Q, F) {
            var Conn = $("[id*=hdnConnString]").val();
            var compid = parseFloat($("[id*=hdnCompanyid]").val());
            var UP = '';
            Pager(0, 0, UP);
            $("[id*=btnAdd]").hide();
            $("[id*=tblMisMatch] tbody").empty();
            var Err = "";
            ShowLoader();
            //Ajax start
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../handler/Voucher.asmx/MisMatch_Vouchers",
                data: '{compid:' + compid + ',f:"' + F + '",q:"' + Q + '", Conn:"' + Conn + '"}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);

                    myList = myList[0];
                    var tbl = "";
                    var PAN = myList.Lst_PAN;   //

                    var Trans = myList.Lst_Tr;    //
                    var Nri = myList.Lst_Nri;
                    var BAC = myList.Lst_BACIA;
                    var Dtype = myList.Lst_DType;
                    $("[id*=tblDtype]").hide();
                    $("[id*=drpBACALL]").hide();
                    $("[id*=Label6]").hide();
                    var tbl = '';
                    if (PAN.length > 0) {

                        Err = "1";
                        tbl = tbl + "<tr >";
                        tbl = tbl + "<th style='width:10%;text-align: center;' class='cssGridHeader'>Date</th>";
                        tbl = tbl + "<th style='width:30%;text-align: center;' class='cssGridHeader'>Deductee</th>";
                        tbl = tbl + "<th style='width:20%;text-align: center;' class='cssGridHeader'>Voucher Amt</th>";
                        tbl = tbl + "<th style='width:10%;text-align: center;' class='cssGridHeader'>Voucher PAN</th>";
                        tbl = tbl + "<th style='width:10%;text-align: center;' class='cssGridHeader'>Deductee PAN</th>";
                        tbl = tbl + "<th style='width:10%;text-align: center;' class='cssGridHeader'>Edit</th></tr>";
                        for (var i = 0; i < PAN.length; i++) {
                            tbl = tbl + "<tr >";
                            tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + PAN[i].PDate + "<input type='hidden' name='hdnvid' value='" + PAN[i].Vid + "'/></td>";
                            tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + PAN[i].DName + " <input type='hidden' name='hdnCid' value='0'/></td>";
                            tbl = tbl + "<td class='setBorderJsonTd' style='text-align: right;'>" + PAN[i].AmtPaid + "</td>";
                            tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + PAN[i].VPAN + "</td>";
                            tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + PAN[i].DPAN + "</td>";

                            tbl = tbl + "<td style='text-align: center;'><img src='../images/edit.png' style='cursor:pointer; height:18px; width:18px;' onclick='Edit_Rec($(this))' id='stfEdit' name='stfEdit'></td>";
                            tbl = tbl + "</tr >";
                        };

                        $("[id*=tblMisMatch]").append(tbl);
                    }

                    else if (Trans.length > 0) {

                        Err = "1";
                        tbl = tbl + "<tr >";
                        tbl = tbl + "<th style='width:10%;text-align: center;' class='cssGridHeader'>Date</th>";
                        tbl = tbl + "<th style='width:30%;text-align: center;' class='cssGridHeader'>Deductee</th>";
                        tbl = tbl + "<th style='width:15%;text-align: center;' class='cssGridHeader'>Voucher Amt</th>";
                        tbl = tbl + "<th style='width:10%;text-align: center;' class='cssGridHeader'>TDS</th>";
                        tbl = tbl + "<th style='width:10%;text-align: center;' class='cssGridHeader'>Correct TDS</th>";
                        tbl = tbl + "<th style='width:5%;text-align: center;' class='cssGridHeader'>Rate</th>";
                        tbl = tbl + "<th style='width:10%;text-align: center;' class='cssGridHeader'>Certificate</th>";
                        tbl = tbl + "<th style='width:20%;text-align: center;' class='cssGridHeader'>Error</th>";
                        tbl = tbl + "<th style='width:10%;text-align: center;' class='cssGridHeader'>Edit</th></tr>";
                        for (var i = 0; i < Trans.length; i++) {
                            tbl = tbl + "<tr >";
                            tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + Trans[i].PDate + "<input type='hidden' name='hdnvid' value='" + Trans[i].Vid + "'/></td>";
                            tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + Trans[i].DName + " <input type='hidden' name='hdnCid' value='0'/></td>";
                            tbl = tbl + "<td class='setBorderJsonTd' style='text-align: right;'>" + Trans[i].AmtPaid + "</td>";
                            tbl = tbl + "<td class='setBorderJsonTd' style='text-align: right;'>" + Trans[i].TdsAmt + "</td>";
                            tbl = tbl + "<td class='setBorderJsonTd' style='text-align: right;'>" + Trans[i].CTdsAmt + "</td>";
                            tbl = tbl + "<td class='setBorderJsonTd' style='text-align: right;'>" + Trans[i].RT + "</td>";
                            tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + Trans[i].Cert + "</td>";
                            tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + Trans[i].Error + "</td>";
                            tbl = tbl + "<td style='text-align: center;'><img src='../images/edit.png' style='cursor:pointer; height:18px; width:18px;' onclick='Edit_Rec($(this))' id='stfEdit' name='stfEdit'></td>";
                            tbl = tbl + "</tr >";
                        };

                        $("[id*=tblMisMatch]").append(tbl);
                    }
                    else if (Nri.length > 0) {


                        Err = "1";
                        tbl = tbl + "<tr >";
                        tbl = tbl + "<th style='width:10%;text-align: center;' class='cssGridHeader'>Deductee</th>";
                        tbl = tbl + "<th style='width:30%;text-align: center;' class='cssGridHeader'>Email</th>";
                        tbl = tbl + "<th style='width:15%;text-align: center;' class='cssGridHeader'>Tel</th>";
                        tbl = tbl + "<th style='width:10%;text-align: center;' class='cssGridHeader'>Tax</th>";
                        tbl = tbl + "<th style='width:5%;text-align: center;' class='cssGridHeader'>Address</th> </tr>";

                        for (var i = 0; i < Nri.length; i++) {
                            tbl = tbl + "<tr >";
                            tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + Nri[i].DName + "</td>";
                            if (Nri[i].Email == '') {
                                tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center; color:Red; font-weight: bold; font-size:14px;'>Required</td>";
                            }
                            else {
                                tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + Nri[i].Email + "</td>";
                            }

                            if (Nri[i].Tel == '') {
                                tbl = tbl + "<td class='setBorderJsonTd' style='text-align: right; color:Red;font-weight: bold; font-size:14px;'>required</td>";
                            }
                            else {
                                tbl = tbl + "<td class='setBorderJsonTd' style='text-align: right;'>" + Nri[i].Tel + "</td>";
                            }

                            if (Nri[i].Tax == '') {
                                tbl = tbl + "<td class='setBorderJsonTd' style='text-align: right; color:Red;font-weight: bold; font-size:14px;'>Required</td>";
                            }
                            else {
                                tbl = tbl + "<td class='setBorderJsonTd' style='text-align: right;'>" + Nri[i].Tax + "</td>";
                            }

                            if (Nri[i].Add == '') {
                                tbl = tbl + "<td class='setBorderJsonTd' style='text-align: right; color:Red;font-weight: bold; font-size:14px;'>Required</td>";
                            }
                            else {
                                tbl = tbl + "<td class='setBorderJsonTd' style='text-align: right;'>" + Nri[i].Add + "</td>";
                            }
                            tbl = tbl + "</tr >";
                        };

                        $("[id*=tblMisMatch]").append(tbl);

                    }
                    else if (BAC.length > 0) {
                        BACIA = '1';
                        $("[id*=btnBAC]").show();
                        $("[id*=drpBACALL]").show();
                        $("[id*=Label6]").show();
                        tbl = tbl + "<tr >";
                        tbl = tbl + "<th style='width:60%;text-align: center;' class='cssGridHeader'>Deductee</th>";
                        tbl = tbl + "<th style='width:30%;text-align: center;' class='cssGridHeader'>115BAC 1A</th> </tr>";

                        var ddp = "<select id='ddlBAC' name='ddlBAC' class='Dropdown' style=' font-size: 12px;' >";
                        ddp = ddp + "<option value= 0></option>";
                        ddp = ddp + "<option value='Y'>Yes</option>";
                        ddp = ddp + "<option value='N'>No</option>";
                        ddp = ddp + "</select>";
                        for (var i = 0; i < BAC.length; i++) {
                            tbl = tbl + "<tr >";
                            tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + BAC[i].DName + "<input type='hidden' id='hdnDid' name='hdnDid' value='" + BAC[i].Did + "'/></td>";

                            tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + ddp + "</td>";

                            tbl = tbl + "</tr >";
                        };
                        $("[id*=btnDT]").hide();
                        $("[id*=btnBAC]").show();
                        $("[id*=btnPANLed]").hide();
                        $("[id*=tblMisMatch]").append(tbl);
                    }
                    else if (Dtype.length > 0) {


                        tbl = tbl + "<tr >";
                        tbl = tbl + "<th style='width:50%;text-align: center;' class='cssGridHeader'>Deductee</th>";
                        tbl = tbl + "<th style='width:20%;text-align: center;' class='cssGridHeader'>PAN</th>";
                        tbl = tbl + "<th style='width:30%;text-align: center;' class='cssGridHeader'>Type</th> </tr>";

                        var ddp = "<select id='ddlDType' name='ddlDType' class='Dropdown' onchange='ValidSelect($(this))' style=' font-size: 12px;' >";
                        ddp = ddp + "<option value= 0></option>";
                        ddp = ddp + "<option value='Company'>Company</option>";
                        ddp = ddp + "<option value='Hindu'>Hindu Undivided Family </option>";
                        ddp = ddp + "<option value='AOP'>Association of Persons (AOP)</option>";
                        ddp = ddp + "<option value='AOPCM'>Association of Persons (Others)</option>";
                        ddp = ddp + "<option value='ST'>Co-operative Society/ Trust</option>";
                        ddp = ddp + "<option value='Firm'>Firm</option>";
                        ddp = ddp + "<option value='BInd'>Body of individuals</option>";
                        ddp = ddp + "<option value='Artificial'>Artificial juridical person</option>";
                        ddp = ddp + "<option value='Others'>Others</option>";
                        ddp = ddp + "<option value='Individual'>Individual</option>";
                        ddp = ddp + "</select>";
                        for (var i = 0; i < Dtype.length; i++) {
                            tbl = tbl + "<tr style='height:30px;'>";
                            tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + Dtype[i].DName + "<input type='hidden' id='hdnDid' name='hdnDid' value='" + Dtype[i].Did + "'/></td>";
                            tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + Dtype[i].PAN + "</td>";
                            tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + ddp + " </td>";

                            tbl = tbl + "</tr >";
                        };
                        $("[id*=btnDT]").show();
                        $("[id*=btnBAC]").hide();
                        $("[id*=btnPANLed]").show();
                        $("[id*=tblMisMatch]").append(tbl);
                    }
                    else {
                        tbl = tbl + "<tr >";
                        tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>No Record Found !!!</td>";
                        tbl = tbl + "</tr >";
                        $("[id*=tblMisMatch]").append(tbl);
                        //  Pager(0, mth);
                    }

                },
                failure: function (response) {

                },
                error: function (response) {

                }
            });
        }


        function Del_Rec(i) {
            ShowLoader();
            Clearall();
            var row = i.closest("tr");
            var vid = row.find("input[name=hdnvid]").val();
            var compid = $("[id*=hdnCompanyid]").val();
            var Conn = $("[id*=hdnConnString]").val();
            var cid = row.find("input[name=hdnCid]").val();
            //if (parseFloat(cid) > 0) {
            //    alert("Challan already paid, Voucher will be removed from challan");
            //    hideloader();
            //    return;

            //}
            if (confirm('Challan already paid, Voucher will be removed from challan ?')) {

                Del_Vouchers(vid, compid, Conn);
            }
            else {
                hideloader();
            }

        }


        function Del_Vouchers(paidids, nonpaid, compid, Conn) {
            //Ajax start
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../handler/Voucher.asmx/DeleteRecords",
                data: '{compid:' + compid + ',paidids:"' + paidids + '",nonpaid:"' + nonpaid + '", Conn:"' + Conn + '"}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    if (myList.length > 0) {
                        if (parseFloat(myList[0].vid) > 0) {
                            alert('Voucher Removed Successfully!!!')
                            //  ShowSuccessWindow('Voucher Removed Successfully!!!');
                            var mth = $("[id*=hndCurrmth]").val();
                            var PageIndex = $("[id*=hdnPages]").val();
                            p = $("[id*=ddlperpage]").val();
                            ModifyGrid(mth, PageIndex, p, 0);
                            Clearall();
                            $("[id*=hndCurrmth]").val(mth);
                        }
                    }
                    hideloader();
                },
                failure: function (response) {

                },
                error: function (response) {

                }
            });
        }
        function Edit_Rec(i) {
            ShowLoader();
            Clearall();
            var row = i.closest("tr");
            var vid = row.find("input[name=hdnvid]").val();
            var compid = $("[id*=hdnCompanyid]").val();
            var Conn = $("[id*=hdnConnString]").val();
            var cid = row.find("input[name=hdnCid]").val();
            Fiil_deducteeType();
            //Ajax start
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../handler/Voucher.asmx/EditRecords",
                data: '{compid:' + compid + ',vid:' + vid + ', Conn:"' + Conn + '"}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    if (myList.length > 0) {
                        var MyGrd = myList[0];
                        var Grd = MyGrd.Grd;
                        var ddlrs = myList[0].Lst_Sec
                        $("[id*=btnAdd]").hide();
                        $("[id*=tbl_VoucherModify]").hide();
                        $("[id*=tdSearch]").hide();
                        $("[id*=btnVerify]").hide();
                        $("[id*=btnCancel]").show();
                        $("[id*=tdAddNewVoucher]").show();
                        $("[id*=btnSave]").show();
                        $("[id*=btnVoucherCancel]").show();

                        if (parseFloat(cid) > 0) {
                            alert("Challan already paid");
                            $("[id*=btnSave]").hide();
                        }
                        else {
                            $("[id*=btnSave]").show();
                        }
                        //$("[id*=ddl_DeducteeName]").selectize()[0].selectize.destroy();
                        //$("[id*=ddl_Nature]").selectize()[0].selectize.destroy();

                        $("[id*=txt_VoucherDate]").val(myList[0].PDate);
                        $("[id*=txt_TDSCert]").val(myList[0].Cert);
                        $("[id*=ddl_Type]").val(myList[0].tid);
                        $("[id*=txt_PANNumber]").val(myList[0].PAN);
                        $("[id*=txt_NetAmount1]").val(myList[0].AmtPaid + '.00');
                        $("[id*=txt_Rate1]").val(myList[0].Rate);
                        $("[id*=txt_Amount1]").val(myList[0].TdsAmt + '.00');
                        $("[id*=txt_Amount2]").val(myList[0].Sur + '.00');
                        //$("[id*=txt_NetAmount2]").val(myList[0].TdsAmt);
                        $("[id*=txt_Amount3]").val(myList[0].Cess + '.00');
                        //$("[id*=txt_NetAmount3]").val(myList[0].TdsAmt);
                        $("[id*=txt_NetAmounttotal]").html(myList[0].Total + '.00');

                        $("[id*=hdnVoucherID]").val(myList[0].vid);
                        $("[id*=hdnNatureSubID]").val(myList[0].nsid);

                        $("[id*=hdnDedId]").val(myList[0].did);   //$("[id*=ddl_DeducteeName]").val();
                        $("[id*=txtded]").val(myList[0].DName)
                        $("[id*=ddl_Nature]").val(myList[0].nid);
                        var rs = myList[0].rsid;

                        $("[id*=txt_InvBillNo]").val(myList[0].Invid);
                        $("[id*=ddlBranch]").val(myList[0].Bid);
                        $("[id*=ddl_Remittance]").val(myList[0].rid);
                        $("[id*=hdnisNri]").val(myList[0].isNri);
                        $("[id*=hdnSel]").val(myList[0].sel);
                        $("[id*=hdnNatureFromType]").val(myList[0].formType);


                        $("[id*=txtAddress]").val(myList[0].Add1);
                        $("[id*=txtEmail]").val(myList[0].Emailid);
                        $("[id*=txtCno]").val(myList[0].Contactno);
                        $("[id*=TxtTax]").val(myList[0].TaxId);
                        $("[id*=ddl_Country]").val(myList[0].CountryId);
                        $("[id*=ddlRate]").val(myList[0].NriTDSRT);

                        //$("[id*=chk]").val(myList[0].Thold);
                        $("[id*=hdnQuater]").val(myList[0].Quater);
                        var x = $("[id*=hdnSection]").val();
                        if (x == '') {
                            $("[id*=ddl_Reasons]").empty();
                            $("[id*=ddl_Reasons]").append("<option value='0'>--Select Reasons--</option>");
                            for (var i = 0; i < myList[0].Lst_Sec.length; i++) {
                                $("[id*=ddl_Reasons]").append("<option value='" + ddlrs[i].Section_Id + "'>" + ddlrs[i].Section + "</option>");
                            }
                            $("[id*=hdnSection]").val('1');
                        }
                        //var rs = $("[id*=ddl_Reasons]").val();
                        $("[id*=ddl_Reasons]").val(rs);

                        if (myList[0].isNri == false) {
                            $("[id*=ddl_Remittance]").attr("disabled", true);
                            // document.getElementById("ddl_Remittance").setAttribute("disabled", "disabled");
                            //$("[id*=ddl_Remittance]").disabled;
                        }
                        //document.getElementById("ddl_DeducteeName").setAttribute("disabled", "disabled");
                        $("[id*=txtded]").attr("disabled", true);
                        $("[id*=txt_NetAmount1]").keyup();
                        var F = $("[id*=ddlForm]").val();
                        if (F == '27EQ') {
                            $("[id*=trEQ]").show();
                        }
                        else {
                            $("[id*=trEQ]").hide();
                        }

                        $("[id*=drpEQ_Ind]").val(myList[0].eqInd);
                        $("[id*=drpEQ_Nri]").val(myList[0].eqNri);
                        $("[id*=drpBAC1A]").val(myList[0].BAC1A);
                        var PA = myList[0].PAN_AAdhar;
                        if (PA == '' || PA == null) {
                            PA = 'Not Verified';
                        }

                        if (PA == '0.00') {
                            $("[id*=lblPANsts]").html('Not Verified');
                        }
                        if (PA == '') {
                            $("[id*=lblPANsts]").html('Not Verified');
                        }
                        else {
                            $("[id*=lblPANsts]").html(PA);
                        }


                    }


                    hideloader();
                },
                failure: function (response) {

                },
                error: function (response) {

                }
            });
        }

        function SaveRecords() {
            ShowLoader();
            vMod = 'show';
            var compid = $("[id*=hdnCompanyid]").val();
            var Conn = $("[id*=hdnConnString]").val();
            var dt = $("[id*=txt_VoucherDate]").val();
            var did = $("[id*=hdnDedId]").val();  //$("[id*=ddl_DeducteeName]").val();
            var n = $("[id*=ddl_Nature]").val();
            var r = $("[id*=ddl_Reasons]").val();
            var ct = $("[id*=txt_TDSCert]").val();
            var ty = $("[id*=ddl_Type]").val();
            var P = $("[id*=txt_PANNumber]").val();
            var ib = $("[id*=txt_InvBillNo]").val();
            var b = $("[id*=ddlBranch]").val();
            var rt = $("[id*=ddl_Remittance]").val();
            var nd = $("[id*=ddlRate]").val();
            var va = $("[id*=txt_NetAmount1]").val();
            var vr = $("[id*=txt_Rate1]").val();
            var tds = $("[id*=txt_Amount1]").val();
            var sur = $("[id*=txt_Amount2]").val();
            var ces = $("[id*=txt_Amount3]").val();
            var net = $('#<%=txt_NetAmounttotal.ClientID%>').html();
            var vid = $("[id*=hdnVoucherID]").val();
            var nsid = $("[id*=hdnNatureSubID]").val();
            var nri = $("[id*=hdnisNri]").val();
            var sel = $("[id*=hdnSel]").val();
            var dname = $("[id*=txtded]").val();
            var fr = $("[id*=hdnNatureFromType]").val();
            var chk = $("[id*=chk]").is(':checked');
            var nf = $("[id*=txtAddress]").val();
            var ne = $("[id*=txtEmail]").val();
            var nc = $("[id*=txtCno]").val();
            var ni = $("[id*=TxtTax]").val();
            var nct = $("[id*=ddl_Country]").val();
            var q = $("[id*=hdnQuater]").val();
            var fn = $("[id*=hdnConnString]").val();
            var fy = fn.split('_');
            var st = '04/01/' + fy[0];
            var ed = '03/31/20' + fy[1];
            var eqNri = $("[id*=drpEQ_Nri]").val();
            var eqInd = $("[id*=drpEQ_Ind]").val();
            var BAC1A = $("[id*=drpBAC1A]").val();

            var PChar = P.substring(4, 3);
            if (PChar == 'P') {
                PChar = 1;
            }
            else if (PChar == 'C') {
                PChar = 1;
            }
            else if (PChar == 'P') {
                PChar = 2;
            }
            else if (PChar == 'H') {
                PChar = 3;
            }
            else if (PChar == 'A') {
                PChar = 4;
            }
            else if (PChar == 'F') {
                PChar = 7;
            }
            else if (PChar == 'B') {
                PChar = 8;
            }
            else if (PChar == 'T') {
                PChar = 10;
            }
            else if (PChar == 'O') {

                PChar = 10;
            }

            if (va <= 0) {
                alert('Voucher amount cannot be Zero or Negative');
                hideloader();
                return;
            }
            var vd = new Date;
            var s = new Date;
            var e = new Date;
            var d = $("[id*=txt_VoucherDate]").val();
            var dtt = d.split('/');
            d = dtt[1] + '/' + dtt[0] + '/' + dtt[2];
            vd = moment(d);
            s = moment(st);
            e = moment(ed);
            if (moment(vd) < moment(s)) {
                $("[id*=txt_VoucherDate]").val('');
                alert('Voucher date cannot be outside the Financial year');
                hideloader();
                return;
            }
            if (moment(vd) > moment(e)) {
                $("[id*=txt_VoucherDate]").val('');
                alert('Voucher date cannot be outside the Financial year');
                hideloader();
                return;
            }
            var frm = $("[id*=hdnForm]").val();
            if (nct == '') {
                nct = 0;
            }
            if (frm == '27EQ') {
                if (eqNri == '' && P == 'PANNOTAVBL') {
                    hideloader();
                    return;
                }
                if (BAC1A == '') {
                    alert('115BAC(1A) is Mandatory');
                    hideloader();
                    return;
                }
                if (BAC1A == undefined) {
                    alert('115BAC(1A) is Mandatory');
                    hideloader();
                    return;
                }
            }
            else {
                BAC1A = '0';
            }

            ///////////////////////// Nri Validation
            if (frm == '27Q') {
                if (P.length != 10) {
                    alert('PAN no should be 10 digit');
                    hideloader();
                    return;
                }


                if (nd == 0) {
                    alert('Tds Rate as per GOVT cannot be blank');
                    hideloader();
                    return;
                }
                if (r == 0) {
                    alert('Reasons cannot be blank');
                    hideloader();
                    return;
                }
                if (ty == 0) {
                    alert('Deductee type cannot be blank');
                    return;
                }
                if (nct == 0) {
                    alert('Nri Country cannot be blank');
                    hideloader();
                    return;
                }
                if (P == 'PANNOTAVBL') {
                    if (nf == '') {
                        alert('Address required for PANNOTAVBL');
                        hideloader();
                        return;
                    }
                    if (ne == '') {
                        alert('Email required for PANNOTAVBL');
                        hideloader();
                        return;
                    }
                    if (nc == '') {
                        alert('Contact Number required for PANNOTAVBL');
                        hideloader();
                        return;
                    }
                    //if (ni == '') {
                    //    alert('Tax identification Number required for PANNOTAVBL');
                    //    hideloader();
                    //    return;
                    //}
                }


                if (nc != '') {
                    if (nc.indexOf(' ') >= 0) {
                        ;
                        alert("Remove space and special chars from Contact Number ");
                        hideloader();
                        return;
                    }
                    var cnn = parseFloat($("[id*=txtCno]").val());
                    if (isNaN(cnn)) {
                        alert("Contact Number should be numeric");
                        hideloader();
                        return;
                    }
                }

            }
            ///////////////////////// end Nri Validation

            var R = $("[id*=ddl_Reasons]").val();
            R = R.substring(0, 9);
            if (R == 'Lower Rt.') {
                var crt = $("[id*=txt_TDSCert]").val();
                if (crt == '') {
                    alert("Certificate no Required");
                    hideloader();
                    return;
                }
            }

            if (vr > 0 && tds == 0) {
                $("[id*=txt_Amount1]").css("background-color", "#FCE4EC");
                alert("TDS Amt Required");
                hideloader();
                return;

            }

            if (did == '0' || nsid == '0') {

                alert("Deductee and Nature details are not selected, Select again");
                $("[id*=txtded]").val('');
                $("[id*=ddl_Nature]").val(0);
                hideloader();
                return;
            }
            if (va == '0') {
                $("[id*=txt_NetAmount1]").css("background-color", "#FCE4EC");
                alert("Voucher Amt Required");
                hideloader();
                return;
            }

            if (P == '') {
                $("[id*=txt_PANNumber]").css("background-color", "#FCE4EC");
                alert("PAN NO Required");
                hideloader();
                return;
            }
            if (r == '0') {
                $("[id*=ddl_Reasons]").css("background-color", "#FCE4EC");
                alert("Reason Required");
                hideloader();
                return;
            }
            if (ty == '0') {
                $("[id*=ddl_Type]").css("background-color", "#FCE4EC");
                alert("Type Required");
                hideloader();
                return;
            }
            if (n == '0') {
                $("[id*=ddl_Nature]").css("background-color", "#FCE4EC");
                alert("Nature Required");
                hideloader();
                return;
            }
            if (dt == '') {
                $("[id*=txt_VoucherDate]").css("background-color", "#FCE4EC");
                alert("Voucher Date Required");
                hideloader();
                return;
            }

            if (dname == '') {
                $("[id*=txtded]").css("background-color", "#FCE4EC");
                alert("Deductee Name Required");
                hideloader();
                return;
            }
            if (nri == 'true' && rt == '0') {
                hideloader();
                alert("For NRI Deductees Remittance is Required")
                hideloader();
                return;
            }
            if (r != 'No Tax only for sec 194, 194A, 194EE, 193, 194DA, 192A, 194I(a), 194I(b) & 194D B') {
                if (chk == false && vr == '0' && r != 'Transporter transaction and valid PAN is provided T') {
                    alert("Rate Required ")
                    hideloader();
                    return;
                }
            }
            var rec = dt + '^' + did + '^' + n + '^' + r + '^' + ct + '^' + ty + '^' + P + '^' + ib + '^' + b + '^' + rt;
            rec = rec + '^' + vid + '^' + nsid + '^' + nri + '^' + sel + '^' + frm + '^' + chk + '^' + q + '^' + dname;
            rec = rec + '^' + nd + '^' + nf + '^' + ne + '^' + nc + '^' + ni + '^' + nct + '^' + eqNri + '^' + eqInd + '^' + BAC1A + '^' + PChar;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../handler/Voucher.asmx/SaveRecords",
                data: '{compid:' + compid + ',va:' + va + ',vr:"' + vr + '",tds:' + tds + ',sur:' + sur + ',ces:' + ces + ',net:' + net + ', Conn:"' + Conn + '", rec:"' + rec + '"}',
                dataType: "json",
                success: function (msg) {

                    var myList = jQuery.parseJSON(msg.d);

                    if (myList.length > 0) {
                        if (parseFloat(myList[0].vid) > 0) {
                            //alert('Voucher Saved Success')
                            $("[id*=ddlForm]").attr("disabled", false);
                            $("[id*=ddltype]").attr("disabled", false);
                            Clearall();
                        }
                    }
                    if (Mis == 'Mis') {
                        $("[id*=tdAddNewVoucher]").hide();
                        $("[id*=tbl_VoucherModify]").show();
                        $("[id*=dgVoucherModify]").hide();
                        $("[id*=divMisMatch]").show();
                        $("[id*=divModify]").hide();
                        $("[id*=tdSearch]").hide();
                        $("[id*=btnVerify]").hide();
                        var Q = $("[id*=drpQua]").val();
                        var F = $("[id*=drpForm]").val();
                        if (Q != '' && F != '') {
                            MisMatch_Vouchers(Q, F);
                        }
                    }

                    hideloader();
                },
                failure: function (response) {
                    hideloader();
                },
                error: function (response) {
                    hideloader();
                }
            });
        }

        //function FillLastGrid(d) {
        //    ShowLoader();
        //    ////// Last Records Grd
        //    var compid = $("[id*=hdnCompanyid]").val();
        //    var Conn = $("[id*=hdnConnString]").val();
        //    //Ajax start
        //    $.ajax({
        //        type: "POST",
        //        contentType: "application/json; charset=utf-8",
        //        url: "../handler/Voucher.asmx/FillLstGrd",
        //        data: '{compid:' + compid + ',did:' + d + ', Conn:"' + Conn + '"}',
        //        dataType: "json",
        //        success: function (msg) {
        //            var Grd = jQuery.parseJSON(msg.d);


        //            var tbl = '';
        //            $("[id*=tblLstRec] tbody").empty();

        //            tbl = tbl + "<tr>";
        //            tbl = tbl + "<th  style='text-align: center;width:100px;'>Payment Date</th>";
        //            tbl = tbl + "<th style='text-align: center;width:500px;'>Deductee</th>";
        //            tbl = tbl + "<th style='text-align: center;width:100px;'>Amount Paid</th>";
        //            tbl = tbl + "<th style='text-align: center;width:100px;'>TDS</th>";
        //            tbl = tbl + "<th style='text-align: center;width:100px;'>Challan Paid</th>";
        //            tbl = tbl + "</tr>";

        //            if (Grd.length > 0) {
        //                var j = '';
        //                for (var i = 0; i < Grd.length; i++) {
        //                    tbl = tbl + "<tr>";
        //                    tbl = tbl + "<td st\yle='text-align: center;'>" + Grd[i].PDate + "<input type='hidden' id='hdndid' value='" + Grd[i].did + "' name='hdndid'></td>";
        //                    tbl = tbl + "<td style='text-align: left;'>" + Grd[i].DName + "<input type='hidden' id='hdnvid' value='" + Grd[i].vid + "' name='hdnvid'></td>";
        //                    tbl = tbl + "<td style='text-align: right;'>" + Grd[i].AmtPaid + '.00' + "</td>";
        //                    tbl = tbl + "<td style='text-align: right;'>" + Grd[i].TdsAmt + '.00' + "</td>";
        //                    if (parseFloat(Grd[i].CPaid) > 0) {
        //                        tbl = tbl + "<td style='text-align: center;'><img src='../images/valid.png' style='cursor:pointer; height:18px; width:18px;' id='imgCPaid' name='imgCPaid'></td>";
        //                    }
        //                    else {
        //                        tbl = tbl + "<td style='text-align: center;'><img src='../images/invalid.png' style='cursor:pointer; height:18px; width:18px;' id='imgCNot' name='imgCNot'></td>";
        //                    }
        //                };
        //                $("[id*=tblLstRec]").append(tbl);

        //            }

        //            else {
        //                tbl = tbl + "<tr>";

        //                tbl = tbl + "<td ></td>";
        //                tbl = tbl + "<td >No Record Found !!!</td>";
        //                tbl = tbl + "<td ></td>";
        //                tbl = tbl + "<td ></td>";

        //                tbl = tbl + "</tr>";
        //                $("[id*=tblLstRec]").append(tbl);

        //            }
        //            hideloader();
        //        },
        //        failure: function (response) {

        //        },
        //        error: function (response) {

        //        }
        //    });
        //}

        function Search_Grid(mth, pageIndex, Pagesize, d, ch, n) {
            ShowLoader();
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
                url: "../handler/Voucher.asmx/ModifyGrd",
                data: '{c:' + c + ', mth:' + mth + ',pI:' + pageIndex + ',pS:' + Pagesize + ', Conn:"' + Conn + '", d:"' + d + '", n:"' + n + '", ch:"' + ch + '",  U:' + UP + ',fltr:"' + fltr + '",  F:"' + F + '",Q:"' + Q + '"}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    var tbl = '';
                    $("[id*=txtAmtpd]").val(0.00);
                    $("[id*=txtTDS]").val(0.00);
                    $("[id*=dgVoucherModify] tbody").empty();

                    tbl = tbl + "<tr>";
                    tbl = tbl + "<th  style='text-align: center;'>Payment Date</th>";
                    tbl = tbl + "<th >Deductee</th>";
                    tbl = tbl + "<th >Section</th>";
                    tbl = tbl + "<th >Amount Paid</th>";
                    tbl = tbl + "<th >TDS</th>";
                    tbl = tbl + "<th >Challan Paid</th>";
                    tbl = tbl + "<th >Edit</th>";
                    tbl = tbl + "<th >Delete<input type='checkbox' id='chkAll' name='chkAll' onclick='chkAllselect($(this))'></td></th>";

                    tbl = tbl + "</tr>";

                    if (myList.length > 0) {
                        var amtlist = myList[0].LTDSgrid;
                        var j = '';
                        for (var i = 0; i < myList.length; i++) {
                            tbl = tbl + "<tr>";
                            tbl = tbl + "<td style='text-align: center;'>" + myList[i].PDate + "<input type='hidden' id='hdndid' value='" + myList[i].did + "' name='hdndid'></td>";
                            tbl = tbl + "<td style='text-align: left;'>" + myList[i].DName + "<input type='hidden' id='hdnvid' value='" + myList[i].vid + "' name='hdnvid'></td>";
                            tbl = tbl + "<td style='text-align: right;'>" + myList[i].sec + "</td>";

                            tbl = tbl + "<td style='text-align: right;'>" + myList[i].AmtPaid + "</td>";
                            tbl = tbl + "<td style='text-align: right;'>" + myList[i].TdsAmt + "</td>";
                            if (parseFloat(myList[i].CPaid) > 0) {
                                tbl = tbl + "<td style='text-align: center;'><img src='../images/valid.png' style='cursor:pointer; height:18px; width:18px;' id='imgCPaid' name='imgCPaid'><input type='hidden' id='hdnCid' value='" + myList[i].CPaid + "' name='hdnCid'></td>";
                            }
                            else {
                                tbl = tbl + "<td style='text-align: center;'><img src='../images/invalid.png' style='cursor:pointer; height:18px; width:18px;' id='imgCNot' name='imgCNot'><input type='hidden' id='hdnCid' value='" + myList[i].CPaid + "' name='hdnCid'></td>";
                            }

                            tbl = tbl + "<td style='text-align: center;'><img src='../images/edit.png' style='cursor:pointer; height:18px; width:18px;' onclick='Edit_Rec($(this))' id='stfEdit' name='stfEdit'></td>";
                            tbl = tbl + "<td style='text-align: center;'><input type='checkbox' id='chkEjob' name='chkEjob' value='" + myList[i].vid + "' ></td></tr>"
                            // tbl = tbl + "<td style='text-align: center;'><img src='../images/delete.png' style='cursor:pointer; height:18px; width:18px;' onclick='Del_Rec($(this))' id='stfDel' name='stfDel'></td>";

                        };
                        $("[id*=dgVoucherModify]").append(tbl);
                        $("[id*=txtAmtpd]").val(amtlist[0].Amt);
                        $("[id*=txtTDS]").val(amtlist[0].TDS);
                        if (parseFloat(myList[0].Totalcount) > 0) {
                            RecordCount = parseFloat(myList[0].Totalcount);

                        }
                        $("[id*=tbl_VoucherModify]").show();
                        $("[id*=tdSearch]").hide();
                        $("[id*=btnVerify]").hide();
                        $("[id*=btnCancel]").show();
                        Pager(RecordCount, mth);
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
                        tbl = tbl + "</tr>";
                        $("[id*=dgVoucherModify]").append(tbl);
                        Pager(0, mth);
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

                    hideloader();
                },
                failure: function (response) {

                },
                error: function (response) {

                }
            });
        }


        function Clearall() {
            //$("[id*=ddl_DeducteeName]").selectize()[0].selectize.destroy();
            //$("[id*=ddl_Nature]").selectize()[0].selectize.destroy();
            //$("[id*=ddl_Remittance]").selectize()[0].selectize.destroy();
            vMod = 'hide';
            $("[id*=hdnDedId]").val('');
            $("[id*=hdnSrchDed]").val('');
            $("[id*=txtded]").val('');
            $("[id*=txtSearchDeducteeName]").val('');

            $("[id*=txt_VoucherDate]").val('');
            // $("[id*=ddl_DeducteeName]").val(0);
            // $("[id*=ddlSearchNature]").val(0); 
            $("[id*=ddl_Nature]").val(0);
            $("[id*=ddl_Reasons]").val(0);
            $("[id*=txt_TDSCert]").val('');
            $("[id*=ddl_Type]").val('');
            $("[id*=txt_PANNumber]").val('');
            $("[id*=txt_InvBillNo]").val('');
            $("[id*=ddlBranch]").val(0);
            $("[id*=ddl_Remittance]").val(0);
            $("[id*=txt_NetAmount1]").val('');
            $("[id*=txt_Rate1]").val('');
            $("[id*=txt_Amount1]").val('');
            $("[id*=txt_Amount2]").val('');
            $("[id*=txt_NetAmount2]").val('');
            $("[id*=txt_Amount3]").val('');
            $("[id*=txt_NetAmount3]").val('');
            $("[id*=txt_NetAmounttotal]").html('');
            $("[id*=hdnVoucherID]").val('');
            $("[id*=hdnNatureSubID]").val('');
            $("[id*=hdnisNri]").val('');
            $("[id*=hdnSel]").val('');
            $("[id*=hdnNatureFromType]").val('');
            $('#<%=txt_NetAmount2.ClientID%>').html(0);
            $('#<%=txt_NetAmount3.ClientID%>').html(0);
            //$("[id*=lblPANsts]").val('');
            //$("[id*=chk]").val();    // Checkbox Threshold
            //$("[id*=hdnQuater]").val('');
            $("[id*=txtded]").css("background-color", "");
            $("[id*=ddl_Reasons]").css("background-color", "");
            $("[id*=ddl_Type]").css("background-color", "");
            $("[id*=ddl_Nature]").css("background-color", "");
            $("[id*=txt_VoucherDate]").css("background-color", "");
            $("[id*=txt_NetAmount1]").css("background-color", "");
            $("[id*=txt_Rate1]").css("background-color", "");

            $("[id*=txtAddress]").val('');
            $("[id*=txtCno]").val('');
            $("[id*=txtEmail]").val('');
            $("[id*=TxtTax]").val('');
            $("[id*=ddlRate]").val(0);

            //$("[id*=ddl_DeducteeName]").selectize();
            //$("[id*=ddl_Nature]").selectize();
            //$("[id*=ddl_Remittance]").selectize();
            //$("[id*=txt_VoucherDate]").val($("[id*=hdnDate]").val());
        }

        function setNumericFormat() {
            $(".spanwithno").each(function () {
                $(this).html(AddComma($(this).html()));
            });
            $(".decimal").each(function () {
                var i = $(this).val();
                var checkdot = i.split('.');
                if (checkdot.length == 1) {
                    $(this).val(AddComma($(this).val()));
                }
            });
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

        function ShowLoader() {

            $('.MastermodalBackground2').css("display", "block");
        }

        function hideloader() {

            $('.MastermodalBackground2').css("display", "none");
        }

        function focusTb() {
            $get('<%= txt_VoucherDate.ClientID %>').focus();
        }

    </script>
    <style type="text/css">
        .modal {
            position: fixed;
            z-index: 999;
            height: 100%;
            width: 100%;
            top: 0;
            filter: alpha(opacity=60);
            opacity: 0.6;
            -moz-opacity: 0.8;
        }

        .center {
            z-index: 1000;
            margin: 300px auto;
            padding: 10px;
            width: 64px;
            border-radius: 10px;
            filter: alpha(opacity=100);
            opacity: 1;
            -moz-opacity: 1;
        }

            .center img {
                height: 64px;
                width: 64px;
            }

        .rightSave {
            position: absolute;
            right: 180px;
            height: 27px;
            padding-left: 15px;
            padding-left: 15px;
            padding-top: 2px;
            /*top: 112px;*/
        }

        .rightCancel {
            /*position: absolute;*/
            right: 100px;
            /*top: 112px;*/
        }

        .rightdrp {
            position: absolute;
            right: 300px;
            height: 27px;
            padding-left: 15px;
            padding-left: 15px;
            /*top: 112px;*/
            width: 300px;
        }

        .drpright {
            position: absolute;
            right: 500px;
            height: 27px;
            padding-left: 15px;
            padding-left: 15px;
            top: 112px;
            width: 300px;
        }

        .Pager b {
            margin-top: 2px;
            float: left;
        }

        .Pager span {
            text-align: center;
            display: inline-block;
            width: 20px;
            margin-right: 3px;
            line-height: 150%;
            border: 1px solid #BCBCBC;
        }

        .Pager a {
            text-align: center;
            display: inline-block;
            width: 20px;
            background-color: #BCBCBC;
            color: #fff;
            border: 1px solid #BCBCBC;
            margin-right: 3px;
            line-height: 150%;
            text-decoration: none;
        }

        .txt_grds {
        }

        .Head1 {
            font-size: 14px;
            font-family: Verdana,Arial,Helvetica,sans-serif;
            color: #3D80E8;
            font-weight: bold;
            overflow: hidden;
            border-bottom-color: White;
        }

        .divspace {
            height: 20px;
        }

        .headerpage {
            height: 23px;
            width: 100%;
        }

        .Button {
            font-family: Verdana,Arial,Helvetica,sans-serif;
            font-size: 11px;
            font-weight: 600;
            height: 25px;
            color: #1464F4;
            -webkit-border-radius: 4px;
            -moz-border-radius: 4px;
            border-radius: 4px;
            cursor: pointer;
        }

        .modalganesh {
            z-index: 999999;
        }

        .cssPageTitle {
            font: bold 14px verdana, arial, "Trebuchet MS", sans-serif;
            border-bottom: 2px solid #0b9322;
            color: #0b9322;
        }

        .cssButton {
            cursor: pointer; /*background-image: url(../Images/ButtonBG1.png);*/
            background-color: #d3d3d3;
            border: 0px;
            padding: 4px 15px 4px 15px;
            color: Black;
            border: 1px solid #c4c5c6;
            border-radius: 3px;
            font: bold 12px verdana, arial, "Trebuchet MS", sans-serif;
            text-decoration: none;
            opacity: 0.8;
        }

            .cssButton:focus {
                background-color: #69b506;
                border: 1px solid #3f6b03;
                color: White;
                opacity: 0.8;
            }

            .cssButton:hover {
                background-color: #69b506;
                border: 1px solid #3f6b03;
                color: White;
                opacity: 0.8;
            }

        .cssPageTitle2 {
            font: bold 14px verdana, arial, "Trebuchet MS", sans-serif;
            /*border-bottom: 2px solid #0b9322;*/
            padding: 7px;
            color: #0b9322;
        }

        .allTimeSheettle tr:hover {
            cursor: inherit;
            background: #F2F2F2;
            border: 1px solid #ccc;
            padding: 5px;
            color: #474747;
        }

        .allTimeSheettle {
            cursor: pointer;
        }

        .property_tab .ajax__tab_tab {
            background: none repeat scroll 0 0 rgba(0, 0, 0, 0);
            font-weight: bold;
            height: 35px !important;
            margin: 0;
            padding: 8px 15px !important;
        }

        .cssGrdAlterItemStyle {
            font: normal 12px verdana, arial, "Trebuchet MS", sans-serif;
            background-color: #fefefe;
            height: 18px;
        }

            .cssGrdAlterItemStyle:hover {
                background-color: #f7f7f7;
            }

        .tblBorderClass {
            border-collapse: collapse;
        }

            .tblBorderClass th {
                background: #F2F2F2;
            }

            .tblBorderClass td, .tblBorderClass th {
                padding: 5px;
                margin: 0px;
                border: 1px solid #bcbcbc;
            }

            .tblBorderClass tr td:nth-child(1), .tblBorderClass tr td:nth-child(2), .tblBorderClass tr td:nth-child(3) {
                text-align: center;
            }

            .tblBorderClass input[type=text] {
                max-width: 42px;
                min-height: 20px;
            }

            .tblBorderClass tr:hover td {
                background: #c7d4dd !important;
            }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:HiddenField ID="hdnCompanyid" runat="server" />
    <asp:HiddenField ID="hdnNatureSection" runat="server" />
    <asp:HiddenField ID="hdnPanVerified" runat="server" />
    <asp:HiddenField ID="hdnisNri" runat="server" />
    <asp:HiddenField ID="hdnQuater" runat="server" />
    <asp:HiddenField ID="hdnNatureFromType" runat="server" />
    <asp:HiddenField ID="hdnNatureID" runat="server" />
    <asp:HiddenField ID="hdnNatureSubID" runat="server" />
    <asp:HiddenField ID="hdnRemittanceSelection" runat="server" />
    <asp:HiddenField ID="hdnVoucherID" runat="server" />
    <asp:HiddenField ID="hdnSel" runat="server" />
    <asp:HiddenField ID="hdnrate1" runat="server" />
    <asp:HiddenField ID="hdnrate2" runat="server" />
    <asp:HiddenField ID="hdnrate3" runat="server" />
    <asp:HiddenField ID="hdnrate4" runat="server" />
    <asp:HiddenField ID="hdntxt_NetAmounttotal" runat="server" />
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
    <div class="cssPageTitle" style="padding-top: 0px; padding-bottom: 0px;">
        <table style="width: 100%;">
            <tr>
                <td style="width: 200px;">
                    <asp:Label ID="Label1" runat="server" Font-Bold="true" Text="Voucher Entries"></asp:Label></td>

                <td style="width: 100px; padding-top: 12px;">
                    <select id="ddlForm" style="width: 100px; height: 25px;" class="cssDropDownList">
                        <option value="26Q">26Q</option>
                        <option value="27Q">27Q(NRI)</option>
                        <option value="27EQ">27EQ(TCS)</option>
                    </select>
                </td>
                <td style="width: 100px; padding-top: 12px;">
                    <select id="ddltype" style="width: 50px; height: 25px;" class="cssDropDownList">

                        <option value="Q1">Q1</option>
                        <option value="Q2">Q2</option>
                        <option value="Q3">Q3</option>
                        <option value="Q4">Q4</option>
                    </select>
                </td>
                <td style="width: 500px;">
                    <%--<label ID="Label7" runat="server" font-bold="true" style="position: absolute; right: 610px;">Quarter</label>--%>
                </td>
                <td style="text-align: right;">
                    <input id="btnSave" name="btnSave" tabindex="13" class="cssButton rightSave" value="Save" type="button" />
                    <input id="btnVoucherCancel" tabindex="14" class="cssButton rightCancel" value="Cancel" type="button" style="margin-right: 70px;" />
                    <input id="btnAdd" name="btnAdd" class="cssButton rightCancel" value="Add Voucher" type="button" />
                    <input id="btnVerify" type="button" class="cssButton rightCancel" style="width:150px;" value="Challan Verify" />
                </td>
            </tr>
        </table>


        <div class="drpright ">
        </div>

        <div class="rightdrp  ">
        </div>

    </div>


    <UC:MessageControl runat="server" ID="ucMessageControl" />
    <div id="tdSearch">
        <center>
            <div style="margin-top: 5px; margin-bottom: 10px; cursor: pointer;">
                <table style="width: 100%;">
                    <tr>
                        <td style="width:60%; top: 10px;">
                            <fieldset style="width: 100%; height: 442px;">
                                <legend style="text-align: left;padding-left:50px;">Challan</legend>
                                
                                <center>

                                    <div style="max-height: 430px; width: 100%; overflow: auto; padding-right: -15px;">
                                        <table id="tblChallan" class="tblBorderClass" style="border-collapse: collapse; width: 100%;"></table>
                                    </div>
                                </center>
                            </fieldset>
                        </td>
                        <td style="width:5%;"></td>
                        <td style="width:35%;">
                            <fieldset style="width: 100%; height: 442px;">
                                <legend style="text-align: left;padding-left:50px;">Voucher</legend>
                                <center>
                                    <table id="dgVoucherEntries" class="tblBorderClass" style="border-collapse: collapse; width: 100%; padding-left: 5%;"></table>
                                </center>
                            </fieldset>
                        </td>

                    </tr>
                </table>
            </div>
        </center>
    </div>
    <div id="tbl_VoucherModify">
        <div id="divModify">
            <table width="100%" cellpadding="3" cellspacing="0" style="padding-top: 10px;">

                <tr runat="server" id="TableRow5">
                    <td width="100px">
                        <label id="Label47" runat="server" class="cssLabel" style="font-weight: bold;">Search Field</label>
                        <asp:HiddenField ID="hndCurrmth" runat="server" />
                    </td>
                    <td style="width: 200px;">
                        <div id="the-src">
                            <input id="txtSearchDeducteeName" name="txtSearchDeducteeName" type="text" class="typeahead" value="" style="width: 400px;" placeholder="Deductee Name" />
                        </div>

                    </td>
                    <td style="width: 50px;"></td>
                    <td style="width: 210px;">
                        <select runat="server" id="ddlSearchNature" style="width: 200px; height: 25px;">
                        </select>
                    </td>
                    <td style="width: 50px;"></td>
                    <td>
                        <select runat="server" id="ddlSearchChallanStatus" class="cssDropDownList"
                            style="width: 150px; height: 25px;">
                            <option value="">Challan Status </option>
                            <option value="1">Challan Paid</option>
                            <option value="2">Challan Not Paid</option>
                        </select>
                    </td>
                    <td>
                        <select id="ddlperpage" class="cssDropDownList" style="width: 60px;">
                            <option value="200">200</option>
                            <option value="800">800</option>
                            <option value="1200">1200</option>
                            <option value="2000">2000</option>

                        </select>
                    </td>
                    <td>
                        <input id="btnCancel" value="Cancel" class="cssButton " type="button" />
                    </td>
                </tr>
                <tr>
                    <td></td>

                </tr>
            </table>
            <table style="padding-top: 10px;">

                <tr runat="server" id="Tr1">
                    <td width="100px">
                        <label id="Label2" runat="server" class="cssLabel" style="font-weight: bold;">Total Amount</label>

                    </td>
                    <td style="width: 100px;">
                        <input type="text" id="txtAmtpd" name="txtAmtpd" class="cssTextbox" style="text-align: right;" disabled />
                    </td>
                    <td width="50px"></td>
                    <td width="100px">
                        <label id="Label3" runat="server" class="cssLabel" style="font-weight: bold;">Total TDS</label>
                    </td>
                    <td style="width: 100px;">
                        <input type="text" id="txtTDS" name="txtTDS" class="cssTextbox" style="text-align: right;" disabled />
                    </td>
                    <td width="50px"></td>
                    <td style="width: 100px;">
                        <input type="button" class="cssButton" value="Delete selected record" id="btnvoucherecord" name="btnvoucherecord" />
                    </td>
                </tr>
                <tr>
                    <td></td>
                </tr>
            </table>
            <table id="dgVoucherModify" class="norecordTble allTimeSheettle" style="border-collapse: collapse; width: 100%;"></table>
        </div>
        <div id="divMisMatch">
            <table width="100%" cellpadding="3" cellspacing="0" style="padding-top: 10px;">

                <tr runat="server" id="Tr2">
                    <td width="50px">
                        <label id="Label4" runat="server" class="cssLabel" style="font-weight: bold;">Qtr</label>
                    </td>
                    <td style="width: 100px;">
                        <select runat="server" id="drpQua" class="cssDropDownList" style="width: 100px; height: 25px;">
                            <option value="">Select</option>
                            <option value="Q1">Q1</option>
                            <option value="Q2">Q2</option>
                            <option value="Q3">Q3</option>
                            <option value="Q4">Q4</option>
                        </select>
                    </td>
                    <td style="width: 50px;">
                        <label id="Label5" runat="server" class="cssLabel" style="font-weight: bold;">Form</label>
                    </td>
                    <td style="width: 210px;">
                        <select runat="server" id="drpForm" class="cssDropDownList" style="width: 150px; height: 25px;">
                            <option value="">Select</option>
                            <option value="26Q">26Q</option>
                            <option value="27Q">27Q</option>
                            <option value="27EQ">27EQ</option>

                        </select>
                    </td>

                    <td>
                        <input id="btnDT" name="btnDT" class="cssButton" value="Update Deductee Type" type="button" />
                        <input id="btnBAC" name="btnBAC" class="cssButton" value="Update 115BAC(1A)" type="button" />
                        <input id="btnBack" name="btnBack" class="cssButton" value="Back to Voucher" type="button" />
                        <input id="btnPANLed" name="btnBack" class="cssButton" value="Understanding PAN" type="button" />
                    </td>
                </tr>
            </table>
            <table id="tblDtype" class="tblBorderClass" style="border-collapse: collapse; width: 100%; padding-left: 5%; padding-top: 10px;">
                <tr>
                    <th>Ledgend 4th Charater of PAN</th>
                    <th></th>
                </tr>
                <tr>
                    <td>C - Company</td>
                    <td>H - Hindu Undivided Family </td>
                </tr>
                <tr>
                    <td>A - Association of Persons (AOP)</td>
                    <td>P - Individual </td>
                </tr>
                <tr>
                    <td>T - Co-operative Society/ Trust</td>
                    <td>F - Firm </td>
                </tr>
                <tr>
                    <td>B - Body of individuals</td>
                    <td>J - Artificial juridical person </td>
                </tr>
                <tr>
                    <td>Others - Others</td>
                    <td>Others - Association of Persons (Others) </td>
                </tr>
            </table>
            <div style="text-align: right">
                <label id="Label6" runat="server" class="cssLabel" style="font-weight: bold;">Sel All</label>
                <select runat="server" id="drpBACALL" class="cssDropDownList" style="width: 150px; height: 25px;">
                    <option value="">Select</option>
                    <option value="Y">Yes</option>
                    <option value="N">No</option>
                </select>
            </div>
            <table id="tblMisMatch" class="tblBorderClass" style="border-collapse: collapse; width: 100%;"></table>
        </div>
        <table id="tblPager" style="border: 1px solid #BCBCBC; border-bottom: none; background-color: rgba(219,219,219,0.54); text-align: right;"
            cellpadding="2" cellspacing="0" width="1095px">
            <tr>
                <td>
                    <div class="Pager">
                    </div>
                </td>
            </tr>
        </table>
    </div>


    <div id="tdAddNewVoucher">
        <table style="width: 1300px;">
            <tr>
                <td>
                    <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td valign="top" style="width: 750px;">
                                <table>
                                    <tr>
                                        <td style="font-family: Verdana; font-weight: bold;">Date
                                        </td>
                                        <td style="font-family: Verdana;">
                                            <asp:TextBox ID="txt_VoucherDate" TabIndex="1" runat="server" placeholder="DD/MM/YYYY" AutoPostBack="false" CssClass="cssTextbox"
                                                Width="150px" Style="margin-left: 61px;"></asp:TextBox>
                                            <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txt_VoucherDate"
                                                Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" />
                                            <asp:ImageButton ID="ImageButton1" ImageUrl="~/Images/calendar.gif" runat="server" Width="16px" />
                                            <asp:CalendarExtender ID="c1" runat="server" PopupButtonID="ImageButton1" TargetControlID="txt_VoucherDate"
                                                Format="dd/MM/yyyy" OnClientHidden="focusTb">
                                            </asp:CalendarExtender>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_VoucherDate"
                                                Display="None" ErrorMessage="Please Select Voucher Date !" ValidationGroup="ValidThisV"></asp:RequiredFieldValidator>

                                            <asp:CustomValidator ID="CustomValidator1" Display="None" ValidationGroup="ValidThisV"
                                                runat="server" ControlToValidate="txt_VoucherDate" ClientValidationFunction="ValidateDate"
                                                ErrorMessage="Not a Valid Voucher Date With Current Selection Of Financial Year !"></asp:CustomValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="font-family: Verdana; font-weight: bold;">Deductee
                                        </td>
                                        <td style="width: 480px; font-family: Verdana;">
                                            <div id="the-basics">
                                                <input id="txtded" name="txtded" tabindex="2" type="text" class="typeahead" value="" style="width: 400px; margin-left: 61px;" placeholder="Deductee Name" />
                                                <%--                                                        <select id="ddl_DeducteeName" tabindex="2" runat="server"  
                                                            style="width: 450px; height: 25px;">
                                                        </select>--%>
                                            </div>
                                        </td>
                                        <td style="width: 100px; font-weight: bold;">Type
                                        </td>
                                        <td>
                                            <select id="ddl_Type" runat="server" tabindex="3" style="width: 130px; height: 25px; margin-right: 10px;">
                                            </select>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td style="font-family: Verdana; width: 150px; font-weight: bold;">PAN
                                        </td>
                                        <td>
                                            <input id="txt_PANNumber" tabindex="4" runat="server" class="cssTextbox" style="width: 100px; margin-left: 61px;" />
                                        
                                        </td>
                                        <td>
                                            <label id="lblPANsts" class="labelstyle labelChange" style="font-weight: bold; height: 23px; width:200px; font-family: Verdana; font-size: small; margin-left: -297px;"></label>
                                        </td>

                                    </tr>
                                    <tr style="height: 37px;">
                                        <td style="font-family: Verdana; font-weight: bold;">Nature
                                        </td>
                                        <td colspan="3" style="font-family: Verdana;">
                                            <select id="ddl_Nature" runat="server" tabindex="5" style="width: 415px; margin-left: 61px; height: 25px;">
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="font-family: Verdana; font-weight: bold;">Reasons
                                        </td>
                                        <td style="font-family: Verdana;">
                                            <select id="ddl_Reasons" runat="server" tabindex="6" class="cssDropDownList" style="width: 415px; margin-left: 61px; height: 25px;">
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                                <hr style="border: 1px solid rgba(0, 0, 0, 0.3); margin: 5px;" />
                                <table>
                                    <tr style="height: 5px;"></tr>
                                    <tr style="height: 5px;">
                                        <td style="font-family: Verdana; font-weight: bold; font-size: 16px; width: 150px; color: #0b9322;">Optional</td>
                                    </tr>
                                    <tr style="height: 5px;"></tr>
                                    <tr>
                                        <td style="font-family: Verdana; width: 150px; font-weight: bold;">TDS Cert
                                        </td>
                                        <td>
                                            <input runat="server" id="txt_TDSCert" tabindex="" class="cssTextbox" maxlength="10" placeholder="10 digit certificate number" style="width: 290px;" />
                                            <%--<input type="button" id="btnVerify"  class="cssButton" value="Verify"  />--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="font-family: Verdana; width: 150px; font-weight: bold;">Inv/Bill.No.
                                        </td>

                                        <td style="font-family: Verdana;">
                                            <input id="txt_InvBillNo" runat="server" tabindex="" class="cssTextbox" style="width: 290px;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px; font-family: Verdana; font-weight: bold;">Branch
                                        </td>
                                        <td style="font-family: Verdana;">
                                            <select id="ddlBranch" runat="server" tabindex="" class="cssDropDownList"
                                                style="width: 302px; height: 25px;">
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                                <table id="trEQ">
                                    <tr>
                                        <td style="width: 150px; font-family: Verdana; font-weight: bold;">IS NRI
                                        </td>
                                        <td style="font-family: Verdana;">
                                            <select id="drpEQ_Nri" runat="server" tabindex="" class="cssDropDownList"
                                                style="width: 100px; height: 25px;">
                                                <option value="">Select</option>
                                                <option value="Y">Yes</option>
                                                <option value="N">No</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr style="height: 2px;">
                                        <td style="width: 150px; font-family: Verdana; font-weight: bold;">I115 BAC(1A)</td>
                                        <td>
                                            <select id="drpBAC1A" runat="server" tabindex="" class="cssDropDownList"
                                                style="width: 100px; height: 25px;">
                                                <option value="">Select</option>
                                                <option value="Y">Yes</option>
                                                <option value="N">No</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr id="trNriEQ">
                                        <td style="width: 150px; font-family: Verdana; font-weight: bold;">Establishment in India
                                        </td>
                                        <td style="font-family: Verdana;">
                                            <select id="drpEQ_Ind" runat="server" tabindex="" class="cssDropDownList"
                                                style="width: 290px; height: 25px;">
                                                <option value="">Select</option>
                                                <option value="Y">Yes</option>
                                                <option value="N">No</option>

                                            </select>
                                        </td>
                                    </tr>
                                </table>
                                <table id="tblNri">
                                    <tr>
                                        <td style="font-family: Verdana; width: 150px; font-weight: bold;">Remittance (For NRI)
                                        </td>
                                        <td colspan="3" style="font-family: Verdana;">
                                            <select id="ddl_Remittance" runat="server" class="cssDropDownList" tabindex="" style="width: 302px; height: 25px;">
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="font-family: Verdana; width: 150px; font-weight: bold;">Country (For NRI)
                                        </td>
                                        <td colspan="3" style="font-family: Verdana;">
                                            <select id="ddl_Country" runat="server" class="cssDropDownList" tabindex="" style="width: 302px; height: 25px;">
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="font-family: Verdana; width: 150px; font-weight: bold;">TDS Rate (For NRI)
                                        </td>
                                        <td colspan="3" style="font-family: Verdana;">
                                            <select id="ddlRate" runat="server" class="cssDropDownList" tabindex="" style="width: 302px; height: 25px;">
                                                <option value="0">Select</option>
                                                <option value="If TDS rate is as per Income TaxAct A">If TDS rate is as per Income TaxAct A</option>
                                                <option value="If TDS rate is as per DTAA B">If TDS rate is as per DTAA B</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="font-family: Verdana; width: 150px; font-weight: bold;">Address (For NRI)
                                        </td>
                                        <td colspan="3" style="font-family: Verdana;">
                                            <input id="txtAddress" runat="server" class="cssTextbox" tabindex="" style="width: 290px; height: 25px;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="font-family: Verdana; width: 150px; font-weight: bold;">Contact No (For NRI)
                                        </td>
                                        <td colspan="3" style="font-family: Verdana;">
                                            <input id="txtCno" runat="server" class="cssTextbox" tabindex="" style="width: 290px; height: 25px;" />

                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="font-family: Verdana; width: 150px; font-weight: bold;">Email (For NRI)
                                        </td>
                                        <td colspan="3" style="font-family: Verdana;">
                                            <input id="txtEmail" runat="server" class="cssTextbox" tabindex="22" style="width: 290px; height: 25px;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="font-family: Verdana; width: 150px; font-weight: bold;">Tax Identification (For NRI)
                                        </td>
                                        <td colspan="3" style="font-family: Verdana;">
                                            <input id="TxtTax" runat="server" class="cssTextbox" tabindex="23" style="width: 290px; height: 25px;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>


                            <td valign="top" style="border-color: #FFFFFF #FFFFFF #FFFFFF #000000; border-style: solid; border-width: 1px; padding-left: 12px;">
                                <table>
                                    <tr>
                                        <td style="font-family: Verdana; white-space: nowrap;">
                                            <input id="chk_Sections" tabindex="7" runat="server" type="checkbox" />
                                            <%--<label id="Label31" class="labelstyle labelChange" style="font-weight: bold">Amt not exceeded the threshold limit sections 193, 194, 194A, 194B, 194BB, 194C, 194D, 194EE, 194G, 194H, 194I,194J, 194 LA</label>--%>
                                            <label id="Label31" class="labelstyle labelChange" style="font-weight: bold;display: inline-block; vertical-align: middle; margin-left: 5px; padding-top:8px;">Threshold Limit</label>
                                        </td>
                                    </tr>
                                    <tr style="height: 10px;">
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table style="border-collapse: collapse;" width="100%">
                                                <tr>
                                                    <td style="border-width: 1px; border-style: solid; border-color: #000000; font-weight: bold; height: 30px; width: 200px; font-family: Verdana; text-align:center;">Particulars
                                                    </td>
                                                    <td style="border: 1px solid #000000; font-weight: bold; height: 30px; width: 100px; font-family: Verdana;text-align:center;">Rate %
                                                    </td>
                                                    <%--                                                    <td style="border: 1px solid #000000; font-weight:bold ; height:30px; width:100px;font-family:Verdana; ">&nbsp;&nbsp; Amount (Rs.)
                                                    </td>--%>
                                                    <td style="border: 1px solid #000000; font-weight: bold; height: 30px; width: 200px; font-family: Verdana;text-align:center;">Net Amt (Rs.)
                                                    </td>
                                                </tr>
                                                <tr style="height: 10px;">
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td style="font-family: Verdana; font-weight: bold;">Voucher Amt
                                                    </td>
                                                    <td></td>

                                                    <td style="text-align: right; font-family: Verdana;">
                                                        <input id="txt_NetAmount1" runat="server" tabindex="8" autocomplete="off" class="cssTextbox decimal "
                                                            style="text-align: right; font-weight: bold; width: 150px;" value="0"  />
                                                    </td>

                                                </tr>
                                                <tr style="height: 10px;">
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td style="font-family: Verdana; font-weight: bold;">TDS %
                                                    </td>
                                                    <td style="padding-left: 5px; font-family: Verdana;">
                                                        <input id="txt_Rate1" runat="server" tabindex="9" class="cssTextbox" style="text-align: right; width: 80px;" value="0" onkeyup="txt_Rate1_Keyup(event)" />
                                                    </td>
                                                    <%--<td></td>--%>
                                                    <td style="text-align: right; font-family: Verdana;">
                                                        <%-- <asp:Label Text="0" id="txt_Amount1" runat="server" class="cssLabel"></asp:Label>--%>
                                                        <input id="txt_Amount1" runat="server" tabindex="10" class="cssTextbox decimal" style="text-align: right; width: 150px;" />
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td style="font-family: Verdana; font-weight: bold;">Surcharge
                                                    </td>
                                                    <td style="padding-left: 5px;"></td>

                                                    <%--  <td style="text-align: right;font-family:Verdana;">

                                                    </td>--%>
                                                    <td style="text-align: right; font-family: Verdana;">
                                                        <asp:Label ID="txt_NetAmount2" class="cssLabel" runat="server" Text="0" ForeColor="White"></asp:Label>
                                                        <input id="txt_Amount2" runat="server" tabindex="11" class="cssTextbox  decimal" style="text-align: right; width: 150px;"
                                                            onkeyup="txt_Sur_Keyup(event)" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="font-family: Verdana; font-weight: bold;">Edu.Cess
                                                    </td>
                                                    <td style="padding-left: 5px;"></td>

                                                    <%--                                                    <td style="text-align: right;font-family:Verdana;">
                                                    </td>--%>
                                                    <td style="text-align: right; font-family: Verdana;">
                                                        <asp:Label ID="txt_NetAmount3" runat="server" Text="0" class="cssLabel" ForeColor="White"></asp:Label>
                                                        <input id="txt_Amount3" runat="server" tabindex="12" class="cssTextbox decimal" style="text-align: right; width: 150px;"
                                                            onkeyup="txt_Cess_Keyup(event)" />
                                                    </td>

                                                </tr>
                                                <tr style="height: 10px;">
                                                    <td></td>
                                                    <td></td>
                                                    <%--                                                    <td>

                                                    </td>--%>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <%--                                                    <td>

                                                    </td>--%>
                                                    <td style="text-align: right; border: 1px solid black; font-weight: bold; height: 30px; font-family: Verdana;">Total &nbsp;&nbsp;
                                                    </td>
                                                    <td style="border: 1px solid black; font-weight: bold; height: 30px; font-family: Verdana; text-align: right;">
                                                        <asp:Label ID="txt_NetAmounttotal" Style="text-align: right;" Width="150px"
                                                            Font-Bold="true" CssClass="cssLabel spanwithno" runat="server" Text="0"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>


                                            <asp:CheckBox ID="chk_IsNri" runat="server" Visible="false" />

                                        </td>
                                    </tr>

                                </table>


                            </td>
                        </tr>
                    </table>



                </td>
            </tr>
        </table>
    </div>


    <asp:Button Style="display: none" ID="hideModalPopupViaClientOrginal" runat="server"></asp:Button><br />
    <asp:ModalPopupExtender BackgroundCssClass="modalBackground" BehaviorID="programmaticModalPopupOrginalBehavior"
        RepositionMode="RepositionOnWindowScroll" DropShadow="False" ID="ModalPopupExtender2"
        TargetControlID="hideModalPopupViaClientOrginal" CancelControlID="imgBudgetdClose"
        PopupControlID="panel10" runat="server">
    </asp:ModalPopupExtender>

    <asp:Panel ID="panel10" runat="server"   BackColor="#FFFFFF">
        <div id="Div1" style="width: 100%; float: left; background-color: #55A0FF; color: #ffffff; font-weight: bold;">
            <div id="Div2" style="width: 90%; float: left; height: 20px; padding-left: 2%; padding-top: 1%">
                <asp:Label ID="lblpopup" runat="server" Font-Size="Larger" CssClass="subHead1 labelChange" Text=""></asp:Label>
            </div>
            <div id="Div3" class="ModalCloseButton">
                <img alt="" src="../images/error.png" id="imgBudgetdClose" border="0" name="imgClose"
                    onclick="return HideModalPopup()" />
            </div>
        </div>
        <div style="padding: 5px 5px 5px 5px; " id="addtasks" runat="server" class="comprw">
            <div id="divJb" class="divedBlock" style="padding-top: 10px;">

                <div style="overflow: hidden;  float: left; padding-left: 5px;">
                    <img alt="" src="../images/tds-logo.png" id="imgTraces" border="0" name="imgTraces"  />
                    <asp:Panel ID="pnljb" runat="server" >
                    <table width="100%" >
                        <tr>
                            <td valign="top" width="100%">

                                <div class="gridloader">
                                </div>
                                <table width="60%" id="tblTracesLogin">
                                    <tr>
                                        <td colspan="6">
                                            <span id="lblUserDetails" class="lblHeader" style="font-weight: 700;">Enter Traces Login Details</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border: 2px;">TAN : <span class="req">*</span>
                                        </td>
                                        <td>
                                            <input id="txtTan" class="cssTextbox" type="text" style="width: 120px;" value=""  autocomplete="none"  />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border: 2px;"> User ID : <span class="req">*</span>
                                        </td>
                                        <td>
                                            <input id="txtUserID" class="cssTextbox" style="width: 120px;" type="text" value=""  autocomplete="nope" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border: 2px;">Password : <span class="req">*</span>
                                        </td>
                                        <td>
                                            <input id="txtPassword" class="cssTextbox" style="width: 120px;" type="text" value="" />
                                        </td>

                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>
                                            <input type="submit" name="btnSaveRequest" value="Save" id="btnSaveRequest" class="cssButton" onclick="return SaveTracesDetails();" /></td>
                                    </tr>
                                </table>



                            </td>
                        </tr>
                    </table>
                        <table id="tblver" name="tblver" >

                            <tr id="trAuto1" name="trAuto1">
                                <td style="text-align:right;">
                                    <img id="captchaImg" class="captchaimg1" alt="Captcha" src="" /></td>
                                <td>
                                    <img id="imgRsh" src="../Images/refresh.png" style="width: 20px; padding-right: 10px; cursor: pointer;"  />
                                    <label style="font-weight: bold;">Click to refresh image</label>

                                </td>
                            </tr>
                            <tr style="height:15px;" >
                                <td>
                                    <label id="lblProcess" style="padding-right:20px;font-size:18px;  font-weight:bold; color:red;  border :none ;">Verifing Challans, Please wait .......</label>
                                </td>
                            </tr>
                            <tr id="trAuto2" name="trAuto2" >
                                <td style="text-align:left;">
                                   <input autocomplete="off" id="captcha" class="frmtxtbox" maxlength="5"  style="width:100px; " value="" />
                                </td>
                                <td style="font-weight: bold;font-size:14px; text-align:right;">Enter text as in above image</td>

                             </tr>
                            <tr style="height:15px;" >
                                <td>
                                    <label id="lblSuccess" style="padding-right:20px;font-size:18px; font-weight:bold; border:none ; color:green; ">Verifiying</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="submit" name="btnGetRequest" value="Request" id="btnGetRequest" class="cssButton" onclick="return RequestTrace();" />
                                </td>
                                <td>
                                    <asp:Button ID="Button1" Text="Cancel" runat="server" CssClass="cssButton" OnClientClick="return HideModalPopup()"  />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">

                                    <div style="width: 100%; margin: auto; padding-left:15px;" id="divData">
                                       
                                    </div>

                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </asp:Panel>

</asp:Content>

