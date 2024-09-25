<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="Deductee_Master.aspx.cs" Inherits="Admin_Deductee_Master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit"   TagPrefix="cc1" %>
<asp:Content id="Content1" ContentPlaceHolderid="head" Runat="Server">
    <script type="text/javascript" src="../Scripts/jquery-1.8.2.min.js"></script>
    <script src="../Scripts/Ajax_Pager.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../customScript/common.js"></script>
    <script type="text/javascript" src="../customScript/PANVerify.js"></script>
    <script type="text/javascript" src="../customScript/jquery-confirm.min.js"></script>
    <link href="../css/jquery-confirm.min.css" rel="stylesheet" />
    <link href="../css/common.css" rel="stylesheet" />

    <style type="text/css">
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
        .tdsm {
            font-size: small;
        }

        input[type=text], select {
            min-height: 25px;
        }

        th {
            color: #474747;
        }

        td {
            vertical-align: top;
        }
        /*************************************************************client job selection css****************/
        .tblClientJobSelection td, .tblClientJobSelection th {
            padding: 5px;
            text-align: left;
        }

        .tblClientJobSelection .DropDown {
            width: 412px;
        }

        .ajax__calendar_days td, .ajax__calendar_months td {
            padding: 0px;
        }

        /**************************************************************Timesheet Input css********************/
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

        .TbleBtns {
            float: right;
            display: inherit;
        }
        /***********************************tbljobprojectdetails css*******************************************/
        .tbljobprojectdetails td, .tbljobprojectdetails th {
            padding: 5px;
            text-align: left;
            padding-bottom: 0px;
        }
        /***************************tab loader css*****************************************************/
        #tabsLoader {
            position: absolute;
            z-index: 9999999;
            height: 348px;
            width: 1000px;
            background-color: Black;
            filter: alpha(opacity=40);
            opacity: 0.6;
            -moz-opacity: 0.8;
        }
        /************tab tables css*/
        .tabtables {
            border-collapse: collapse;
            font-size: smaller;
            width: 100%;
        }

            .tabtables th {
                background: #F2F2F2;
            }

            .tabtables td, .tabtables th {
                padding: 5px;
                text-align: left;
                border: 1px solid #bcbcbc;
            }
        /*****************************timesheet edit css popup table*****************************/
        .RoundpanelEdit {
            padding-bottom: 20px;
            min-height: auto;
            min-width: auto;
            width: auto;
        }

        #tblTimesheetEdit {
            margin-left: 20px;
        }

            #tblTimesheetEdit table {
                margin: -5px;
            }

            #tblTimesheetEdit td, #tblTimesheetEdit th {
                padding: 5px;
                text-align: left;
                vertical-align: top;
            }
        /*************************Expense table in popup***********************************/
        .tblExpense {
            border-collapse: collapse;
        }

        .tblExpense th {
            background: #F2F2F2;
        }

        .tblExpense th, .tblExpense td {
            vertical-align: top;
            border: 1px solid #bcbcbc;
            padding: 5px;
            text-align: left;
            vertical-align: top;
        }

        .PopHeaderTitle {
            width: 97.8%;
        }

        .holidays {
            background: #99CCFF;
        }

        .nonholidays {
            background: White;
        }

        img#close {
            position: absolute;
            right: -14px;
            top: -14px;
            cursor: pointer;
        }

        div#popupContact {
            position: absolute;
            left: 50%;
            top: 17%;
            margin-left: -202px;
            font-family: 'Raleway',sans-serif;
            display: none;
            width: 480px;
            height: 400px;
            opacity: .95;
            background-color: White;
            overflow: auto;
        }

        .ajax__calendar_container {
            z-index: 4;
        }

        .auto-style1 {
            position: absolute;
            right: 0;
            top: 1px;
            cursor: pointer;
            height: 34px;
        }
    </style>
    <script type="text/javascript" language="javascript">
        var PanVrf = '';
        var BulkPAN = '';
        var Cookies = "";
        var RequestType = "";
        $(document).ready(function () {
            $("[id*=hdnConnString]").val($("[id*=ddlFinancialYear] :selected").text());
            $("[id*=hdnPages]").val(1);
            var p = '';
            var r = '';
            var d = '';
            $("[id*=tblTracesLogin]").hide();
            $("[id*=drpNri]").val('No');
            $("[id*=drp_TdsRateNRI]").attr("disabled", true);
            $("[id*=drp_Country]").attr("disabled", true);
            $("[id*=txt_Email]").attr("disabled", true);
            $("[id*=txt_FlatNo]").attr("disabled", true);
            $("[id*=txtContact]").attr("disabled", true);
            $("[id*=txt_Street]").attr("disabled", true);
            $("[id*=txtTaxIdentificationno]").attr("disabled", true);
            $("[id*=txtTan]").attr("disabled", true);

            $("[id*=divDetails]").hide();
            $("[id*=divGrid]").show();
            $("[id*=divSearch]").show();  
            fillDeducteeGrid(1, 25, p, r, d);
            Fill_Country();
            $("[id*=ddlSearchReasons]").change(function () {
                var p = $("[id*=ddlSearchPAN]").val();
                if (p == 'Select PAN Status')
                {
                    p = '';
                }
                var r = $("[id*=ddlSearchReasons]").val();
                if (r == 'Select Reasons')
                {
                    r == '';
                }
                var d = $("[id*=txtSearchName]").val();
                fillDeducteeGrid(1, 25, p, r, d);
            });
            $("[id*=PnvVerfy]").click(function () {
                var P = $("[id*=txt_PanNo]").val();
                var l = $("[id*=txt_Name]").val();  
                ShowModalPopup();
                loadLoginDetails();
                getCaptcha();
                $("[id*=lbldPAN]").html(l);
                $("[id*=txtPAN]").val(P);

 
            });

            $("[id*=btnSPAN]").click(function () {
                var p = $("[id*=txtPANSrch]").val();
                if (p == '')
                {
                    var pp = $("[id*=ddlSearchPAN]").val();
                    if (pp == 'Select PAN Status') {
                        pp = '';
                    }
                    var r = $("[id*=ddlSearchReasons]").val();
                    if (r == 'Select Reasons') {
                        r == '';
                    }
                    var d = $("[id*=txtSearchName]").val();
                    fillDeducteeGrid(1, 25, pp, r, d);
                }
                else
                {
                    fillDeducteePAN(p);
                }
            });

            $("[id*=rd1]").change(function () {
                var r = $("[id*=rd1]").is(':checked');
               if (r == true ) {
                 // $("[id*=rd1]").val(0);
                  $("[id*=txt_TDSRate]").attr("disabled", true);
                  $("[id*=txt_SurCharge]").attr("disabled", true);
                  $("[id*=txt_TDSRate]").val('');
                  $("[id*=txt_SurCharge]").val('');
              }
              else
              {
                 // $("[id*=rd1]").val(0);
                  $("[id*=txt_TDSRate]").attr("disabled", false);
                  $("[id*=txt_SurCharge]").attr("disabled", false);
              }
            });

            $("[id*=rd2]").change(function () {
                var r = $("[id*=rd2]").is(':checked');
                if (r == true) {
                    // $("[id*=rd1]").val(0);
                    $("[id*=txt_TDSRate]").attr("disabled", false);
                    $("[id*=txt_SurCharge]").attr("disabled", false);
                }
                else {
                    // $("[id*=rd1]").val(0);
                    $("[id*=txt_TDSRate]").attr("disabled", true);
                    $("[id*=txt_SurCharge]").attr("disabled", true);
                    $("[id*=txt_TDSRate]").val('');
                    $("[id*=txt_SurCharge]").val('');
                }
            });

            $("[id*=drpNri]").change(function () {
                var n = $("[id*=drpNri]").val();
                if (n == 'Yes')
                {
                    $("[id*=drp_TdsRateNRI]").attr("disabled", false);
                    $("[id*=drp_Country]").attr("disabled", false);
                    $("[id*=txt_Email]").attr("disabled", false);
                    $("[id*=txt_FlatNo]").attr("disabled", false);
                    $("[id*=txtContact]").attr("disabled", false);
                    $("[id*=txt_Street]").attr("disabled", false);
                    $("[id*=txtTaxIdentificationno]").attr("disabled", false);  
                }
                else
                {
                    $("[id*=drp_TdsRateNRI]").attr("disabled", true);
                    $("[id*=drp_Country]").attr("disabled", true);
                    $("[id*=txt_Email]").attr("disabled", true);
                    $("[id*=txt_FlatNo]").attr("disabled", true);
                    $("[id*=txtContact]").attr("disabled", true);
                    $("[id*=txt_Street]").attr("disabled", true);
                    $("[id*=txtTaxIdentificationno]").attr("disabled", true);
                }

            });



            $("[id*=ddlSearchPAN]").change(function () {
                var p = $("[id*=ddlSearchPAN]").val();
                var r = $("[id*=ddlSearchReasons]").val();
                var d = $("[id*=txtSearchName]").val();
                if (p == 'Select PAN Status') {
                    p = '';
                }
                if (r == 'Select Reasons') {
                    r == '';
                }
                fillDeducteeGrid(1, 25, p, r, d);
            });

            $("[id*=btnSearch]").click(function () {
                var p = $("[id*=ddlSearchPAN]").val();
                var r = $("[id*=ddlSearchReasons]").val();
                var d = $("[id*=txtSearchName]").val();
                if (p == 'Select PAN Status') {
                    p = '';
                }
                if (r == 'Select Reasons') {
                    r == '';
                }
                fillDeducteeGrid( 1, 25, p, r, d );
            });

            $("[id*=ddlperpage]").change(function () {
                var p = $("[id*=ddlSearchPAN]").val();
                var r = $("[id*=ddlSearchReasons]").val();
                var d = $("[id*=txtSearchName]").val();
    
                fillDeducteeGrid(1, 25, p, r, d);
            });

            $("[id*=btnCancel]").click(function () {
                $("[id*=divDetails]").hide();
                $("[id*=divGrid]").show();
                $("[id*=divSearch]").show();
                ResetVar();
            });

            $("[id*=btnAddNew]").click(function () {
                $("[id*=drp_Reasons]").attr("disabled", false);
                $("[id*=divDetails]").show();
                $("[id*=divGrid]").hide();
                $("[id*=divSearch]").hide();
                $("[id*=hdnid]").val(0);
                ResetVar();
                $("[id*=drp_Type]").val('Company');
                $("[id*=drp_Reasons]").val('Presc.Rt.');
                $("[id*=rd1]").attr('checked', 'checked');
                $("[id*=txt_TDSRate]").attr("disabled", true);
                $("[id*=txt_SurCharge]").attr("disabled", true);
                $("[id*=txt_TDSRate]").val('');
                $("[id*=txt_SurCharge]").val('');
            });

            $("[id*=txtContact]").blur(function () {
                var s = $("[id*=txtContact]").val();
                if(s.indexOf(' ') >= 0){;
                    alert("Remove space and special chars from Contact Number ");
                }
                var n = parseFloat($("[id*=txtContact]").val());
                if (isNaN(n))
                {
                    alert("Contact Number should be numeric");
                }
            });

            $("[id*=btnSave]").click(function () {
                var did = $("[id*=hdnid]").val();
                var y = $("[id*=drp_Country]").val();
                var d = $("[id*=drp_TdsRateNRI]").val();
                var p = $("[id*=txt_PanNo]").val();
                var f = $("[id*=txt_FlatNo]").val();
                var e = $("[id*=txt_Email]").val();
                var s = $("[id*=txt_Street]").val();
                var c = $("[id*=txtContact]").val();
                var i = $("[id*=txtTaxIdentificationno]").val();
                var t = $("[id*=drp_Type]").val();
                var r = $("[id*=drp_Reasons]").val();
                if (p.length != 10)
                {
                    alert('PAN no should be 10 digit');
                    return;
                }


                if (y > 0 && d == 0)
                {
                    alert('Tds Rate as per GOVT cannot be blank');
                    return;
                }
                if (r == 0)
                {
                    alert('Reasons cannot be blank');
                    return;
                }
                if (t == 0) {
                    alert('Deductee type cannot be blank');
                    return;
                }
                if (y > 0 && p == 'PANNOTAVBL') {
                    if ( f == '' && s == '') {
                        alert('Address required for PANNOTAVBL');
                        return;
                    }
                    if ( e == '') {
                        alert('Email required for PANNOTAVBL');
                        return;
                    }
                    if ( c == '') {
                        alert('Contact Number required for PANNOTAVBL');
                        return;
                    }
                    //if ( i == '' ) {
                    //    alert('Tax identification Number required for PANNOTAVBL');
                    //    return;
                    //}
                }

                var s = $("[id*=txtContact]").val();
                if (s != '') {
                    if (s.indexOf(' ') >= 0) {;
                        alert("Remove space and special chars from Contact Number ");
                        return;
                    }
                    var n = parseFloat($("[id*=txtContact]").val());
                    if (isNaN(n)) {
                        alert("Contact Number should be numeric");
                        return;
                    }
                }
                SaveRecords(did);
            });

            $("[id*=txt_PanNo]").blur(function () {

                var P = $("[id*=txt_PanNo]").val();
                P = P.toUpperCase();
                if (P != 'PANNOTAVBL') {
                    $("[id*=drp_Reasons]").attr("disabled", false);
                    var c = P.substring(0, 5);
                    var j = P.substring(5, 9);
                    var PChar = c.substring(4, 1);

                    //if (PChar == 'P')
                    //{
                    //    $("[id*=drp_Type]").val('Individual');
                    //}
                    //else if (PChar == 'C') {
                    //    $("[id*=drp_Type]").val('Company');
                    //}

                    //else if (PChar == 'H') {
                    //    $("[id*=drp_Type]").val('Hindu');
                    //}
                    //else if (PChar == 'A') {
                    //    $("[id*=drp_Type]").val('AOP');
                    //}
                    //else if (PChar == 'B') {
                    //    $("[id*=drp_Type]").val('BInd');
                    //}
                    //else if (PChar == 'G') {
                    //    $("[id*=drp_Type]").val('GA');
                    //}
                    //else if (PChar == 'J') {
                    //    $("[id*=drp_Type]").val('Artificial');
                    //}
                    //else if (PChar == 'L') {
                    //    $("[id*=drp_Type]").val('Individual');
                    //}
                    //else if (PChar == 'F') {
                    //    $("[id*=drp_Type]").val('Firm');
                    //}
                    //else if (PChar == 'I') {
                    //    $("[id*=drp_Type]").val('Trust');
                    //}

                    for (var i = 0; i < c.length; i++) {
                        var s = c.substring(i, parseFloat(i) + 1);
                        if ((/[A-Z]/).test(s) == false) {
                            alert('InValid PAN');
                            $("[id*=txt_PanNo]").val('');
                            return;

                        }
                    };

                    if (isNaN(j)) {
                        alert("InValid PAN");
                        $("[id*=txt_PanNo]").val('');
                        return;
                    }
                    c = '';
                    c = P.substring(9, 10);
                    if ((/[A-Z]/).test(s)) {

                        $("[id*=txt_PanNo]").val(P);
                    }
                    else {
                        alert('InValid PAN');
                        $("[id*=txt_PanNo]").val('');
                        return;
                    }
                }
                else
                {
                    $("[id*=drp_Reasons]").val('Non-Availability of PAN C');
                    $("[id*=drp_Reasons]").attr("disabled", true);
                }
            });

            $("[id*=btnBulkPAN]").click(function () {
                ShowLoader();
                BulkPAN = '';
                var lbl = '';
                var i = 1;
                var tRow = $('#tblDeductee').find('tr').length;
                tRow = parseFloat(tRow) - 1;
                $('#tblDeductee > tbody  > tr').each(function () {
                    var row = $(this).closest("tr");
                    lbl = row.find('td:eq(1)').html();
                    var Vlbl = row.find('td:eq(5)').html();

                    if (lbl != undefined && Vlbl == 'InValid PAN') {
                        if (lbl != 'PANNOTAVBL') {
                           //// Bulk_Verification(lbl);
                            $.ajax({
                                type: "POST",
                                url: "../handler/Ws_Deductee.asmx/BulkPAN",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: '{Pan:"' + lbl + '"}',
                                success: function (msg) {
                                    var myList = jQuery.parseJSON(msg.d);
                                    if (myList.length > 0) {
                                        PanVrf = myList[0].PVerify;
                                        lbl = myList[0].PAN;
                                        BulkPAN = lbl + '^' + PanVrf + '~' + BulkPAN;
                                       
                                        row.find('td:eq(5)').html(PanVrf);
                                       
                                    }
                                    if (i == tRow) {
                                        UpdatePANVerification(BulkPAN);
                                    }
                                    i = parseFloat(i) + 1;
                                },
                                failure: function (response) {

                                }
                            });

                        }
                    }


                });
                hideloader();
            });

        });

        function fillDeducteeGrid(PageIndex, PageSize, p, r, d)
        {
            var compid = $("[id*=hdnCompanyID]").val();
            var Conn = $("[id*=hdnConnString]").val();
            var pan = $("[id*=ddlSearchPAN]").val();
            PageSize = $("[id*=ddlperpage]").val();

            $.ajax({
                type: "POST",
                url: "../Handler/Ws_Deductee.asmx/FillDeductee",
                ////int Compid, string pan, string reasons, string Dname, int PageIndex, int PageSize
                data: '{Compid:' + compid + ',pan: "' + p + '", reasons: "' + r + '", Dname: "' + d + '", PageIndex: ' + PageIndex + ', PageSize: ' + PageSize + ' }',
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    var tbl = '';
                    $("[id*=tblDeductee] tbody").empty();
                    tbl = tbl + "<tr>";
                    tbl = tbl + "<th  style='text-align: center;'>Srno</th>";
                    tbl = tbl + "<th  style='text-align: center;'>PAN</th>";
                    tbl = tbl + "<th >Deductee</th>";
                    tbl = tbl + "<th >Type</th>";
                    tbl = tbl + "<th >Is NRI</th>";
                    tbl = tbl + "<th >PAN Verify </th>";
                    tbl = tbl + "<th >PANVerified</th>";
                    tbl = tbl + "<th style='text-align: center;'>206AB</th>";
                    tbl = tbl + "<th >Edit</th>";
                    tbl = tbl + "<th >Delete</th>";

                    tbl = tbl + "</tr>";

                    if (myList.length > 0) {
                        for (var i = 0; i < myList.length; i++) {
                            tbl = tbl + "<tr>";
                            tbl = tbl + "<td style='text-align: center;'>" + myList[i].Srno + "<input type='hidden' id='hdndid' value='" + myList[i].did + "' name='hdndid'></td>";
                            tbl = tbl + "<td style='text-align: left;'>" + myList[i].PAN + "</td>";
                            tbl = tbl + "<td style='text-align: left;'>" + myList[i].DName + "</td>";

                            tbl = tbl + "<td >" + myList[i].DType + "<input type='hidden' id='hdncid' value='" + myList[i].compid + "' name='hdncid'></td>";
                            var n = myList[i].isNri;
                            if (n == true)
                            {
                                n = 'Yes';
                            }
                            else
                            {
                                n = 'No'
                            }
                            tbl = tbl + "<td >" + n + "</td>";
                            tbl = tbl + "<td  style='text-align: center;'><input id='PnvVerfy' type='button' value='Traces' title='Verify PAN with Traces' onclick='VerifyPANGrd($(this))' class='cssButton'/></td>";
                            tbl = tbl + "<td >" + myList[i].PANVerified + "</td>";
                            var c = '';
                            if (myList[i].Comp206 == 0)
                            {
                                c = '';
                            }
                            if (myList[i].Comp206 == 1) {
                                c = 'Y';
                            }
                            if (myList[i].Comp206 == 2) {
                                c = 'N';
                            }
                            tbl = tbl + "<td style='text-align: center;'>" + c + "</td>";
                            tbl = tbl + "<td style='text-align: center;'><img src='../images/edit.png' style='cursor:pointer; height:18px; width:18px;' onclick='Edit_Rec($(this))' id='stfEdit' name='stfEdit'></td>";
                            tbl = tbl + "<td style='text-align: center;'><img src='../images/delete.png' style='cursor:pointer; height:18px; width:18px;' onclick='Del_Rec($(this))' id='stfDel' name='stfDel'></td>";

                        };
                        $("[id*=tblDeductee]").append(tbl);

                        if (parseFloat(myList[0].Totalcount) > 0) {
                            RecordCount = parseFloat(myList[0].Totalcount);

                        }

                        Pager(RecordCount, p,r,d);
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
                        tbl = tbl + "<td ></td>";
                        tbl = tbl + "</tr>";
                        $("[id*=tblDeductee]").append(tbl);
                        Pager(0, p, r, d);
                    }

                },
                failure: function (response) {
                    alert('Cant Connect to Server' + response.d);
                },
                error: function (response) {
                    alert('Error Occoured ' + response.d);
                }
            });

        }

        function VerifyPANGrd(i)
        {

            var row = i.closest("tr");
            var d = row.find("input[name=hdndid]").val();
            var P = row.find('td:eq(1)').html();
            var l = row.find('td:eq(2)').html();
            ShowModalPopup();
            loadLoginDetails();
            getCaptcha();
            $("[id*=lbldPAN]").html(l);
            $("[id*=txtPAN]").val(P);
        }

        function fillDeducteePAN(P) {
            var compid = $("[id*=hdnCompanyID]").val();
            var Conn = $("[id*=hdnConnString]").val();

            $.ajax({
                type: "POST",
                url: "../Handler/Ws_Deductee.asmx/FillDeducteePAN",
                data: '{Compid:' + compid + ',pan: "' + P + '"}',
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    var tbl = '';
                    $("[id*=tblDeductee] tbody").empty();
                    tbl = tbl + "<tr>";
                    tbl = tbl + "<th  style='text-align: center;'>Srno</th>";
                    tbl = tbl + "<th  style='text-align: center;'>PAN</th>";
                    tbl = tbl + "<th >Deductee</th>";
                    tbl = tbl + "<th >Type</th>";
                    tbl = tbl + "<th >Is NRI</th>";
                    tbl = tbl + "<th >PAN Verify</th>";
                    tbl = tbl + "<th >PANVerified</th>";
                    tbl = tbl + "<th style='text-align: center;'>206AB</th>";
                    tbl = tbl + "<th >Edit</th>";
                    tbl = tbl + "<th >Delete</th>";

                    tbl = tbl + "</tr>";

                    if (myList.length > 0) {
                        for (var i = 0; i < myList.length; i++) {
                            tbl = tbl + "<tr>";
                            tbl = tbl + "<td style='text-align: center;'>" + myList[i].Srno + "<input type='hidden' id='hdndid' value='" + myList[i].did + "' name='hdndid'></td>";
                            tbl = tbl + "<td style='text-align: left;'>" + myList[i].PAN + "</td>";
                            tbl = tbl + "<td style='text-align: left;'>" + myList[i].DName + "</td>";

                            tbl = tbl + "<td >" + myList[i].DType + "<input type='hidden' id='hdncid' value='" + myList[i].compid + "' name='hdncid'></td>";
                            var n = myList[i].isNri;
                            if (n == true) {
                                n = 'Yes';
                            }
                            else {
                                n = 'No'
                            }
                            tbl = tbl + "<td >" + n + "</td>";
                            tbl = tbl + "<td  style='text-align: center;'><input id='PnvVerfy' type='button' value='Traces' title='Verify PAN with Traces' onclick='VerifyPANGrd($(this))' class='cssButton'/></td>";
                            tbl = tbl + "<td >" + myList[i].PANVerified + "</td>";
                            var c = '';
                            if (myList[i].Comp206 == 0) {
                                c = '';
                            }
                            if (myList[i].Comp206 == 1) {
                                c = 'Y';
                            }
                            if (myList[i].Comp206 == 2) {
                                c = 'N';
                            }
                            tbl = tbl + "<td style='text-align: center;'>" + c + "</td>";
                            tbl = tbl + "<td style='text-align: center;'><img src='../images/edit.png' style='cursor:pointer; height:18px; width:18px;' onclick='Edit_Rec($(this))' id='stfEdit' name='stfEdit'></td>";
                            tbl = tbl + "<td style='text-align: center;'><img src='../images/delete.png' style='cursor:pointer; height:18px; width:18px;' onclick='Del_Rec($(this))' id='stfDel' name='stfDel'></td>";

                        };
                        $("[id*=tblDeductee]").append(tbl);

                        if (parseFloat(myList[0].Totalcount) > 0) {
                            RecordCount = parseFloat(myList[0].Totalcount);

                        }

                        Pager(RecordCount, '', '', '');
                        
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
                        tbl = tbl + "<td ></td>";
                        tbl = tbl + "</tr>";
                        $("[id*=tblDeductee]").append(tbl);
                        --Pager(0, '', '', '');
                    }

                },
                failure: function (response) {
                    alert('Cant Connect to Server' + response.d);
                },
                error: function (response) {
                    alert('Error Occoured ' + response.d);
                }
            });

        }

        function Pager(RecordCount, p, r, d) {
            $(".Pager").ASPSnippets_Pager({
                ActiveCssClass: "current",
                PagerCssClass: "pager",
                PageIndex: parseInt($("[id*=hdnPages]").val()),
                PageSize: parseInt(25),
                RecordCount: parseInt(RecordCount)
            });


            $(".Pager .page").on("click", function () {
                $("[id*=hdnPages]").val($(this).attr('page'));
                var PageSize = parseInt($("[id*=ddlperpage]").val());
                fillDeducteeGrid(($(this).attr('page')), PageSize, p, r, d);
            });
        }

        function SaveRecords(did) {
            
            var compid = $("[id*=hdnCompanyID]").val();
            var Conn = $("[id*=hdnConnString]").val();
            var p = $("[id*=txt_PanNo]").val();
            var n = $("[id*=txt_Name]").val();
            var t = $("[id*=drp_Type]").val();
            var r = $("[id*=drp_Reasons]").val();
            var f = $("[id*=txt_FlatNo]").val();
            var e = $("[id*=txt_Email]").val();
            var s = $("[id*=txt_Street]").val();
            var c = $("[id*=txtContact]").val();
            var d = $("[id*=drp_TdsRateNRI]").val();
            var i = $("[id*=txtTaxIdentificationno]").val();
            var y = $("[id*=drp_Country]").val();
            var a = $("[id*=txt_TDSRate]").val();
            var u = $("[id*=txt_SurCharge]").val();
            var nri = $("[id*=drpNri]").val();
            var bac = $("[id*=drpBAC1A]").val();
            var Pver = '';
            var rchk = 1;
            if ($("[id*=rd1]").isChecked)
            {
                rchk = 0;
            }

            if (p == 'PANNOTAVBL') {
                Pver = 'InValid PAN';
            }
            else {
                Pver = 'Valid PAN';
            }
            var m = 0;
            m =  $("[id*=chk_ApplicationToAll]").is(':checked');
            if (m == true)
            {
                m = 1;
            }
            else
            {
                m = 0;
            }
            var isNri =0
            if (nri == 'Yes')
            {
                isNri = 1;
            }
            if (d == 0)
            {
                d = 0;
            }
            var ii = p + '^' + n + '^' + t + '^' + r + '^' + f + '^' + e + '^' + s + '^' + c + '^' + d + '^' + i + '^' + y + '^' + a + '^' + u + '^' + isNri + '^' + Pver + '^' + m + '^' + rchk + '^' + bac;
            //       1         2         3         4         5         6         7         8         9         10        11        12        13          14           15          16
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../handler/Ws_Deductee.asmx/Save_Deductee",
                data: '{compid:' + compid + ',did:' + did + ', ii:"' + ii + '"}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    if (myList.length > 0) {
                        if (myList[0].did > 0) {
                            $("[id*=divDetails]").hide();
                            $("[id*=divGrid]").show();
                            $("[id*=divSearch]").show();
                            ResetVar();
                            alert('Deductee save success');
                            fillDeducteeGrid(1, 25, '', '', '');
                        }
                        //else if (myList[0].did == 0) {
                        //    alert('Deductee with same PAN already exist');
                        //}
                    }

                },
                failure: function (response) {
                    alert('Cant Connect to Server' + response.d);
                },
                error: function (response) {
                    alert('Error Occoured ' + response.d);
                }
            });

        }


        function Fill_Country() {
            var compid = $("[id*=hdnCompanyID]").val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../handler/Ws_Deductee.asmx/Fill_Country",
                data: '{compid:' + compid + '}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    if (myList.length > 0) {
                        $("[id*=drp_Country]").empty();
                        $("[id*=drp_Country]").append("<option value='0'>--Select Country--</option>");
                        for (var i = 0; i < myList.length; i++) {
                            $("[id*=drp_Country]").append("<option value='" + myList[i].Countryid + "'>" + myList[i].Country + "</option>");
                        }

                    }

                },
                failure: function (response) {
                    alert('Cant Connect to Server' + response.d);
                },
                error: function (response) {
                    alert('Error Occoured ' + response.d);
                }
            });

        }

        function Del_Rec(i) {
            var row = i.closest("tr");
            var did = row.find("input[name=hdndid]").val();
            var compid = row.find("input[name=hdncid]").val();
            var Conn = $("[id*=hdnConnString]").val();
            $("[id*=hdnid]").val(did);
            if (confirm("Delete Deductee?"))
            {
                ////// Delete
                Delete_Deductee(did);
            }

        }

        function Delete_Deductee(did)
        {
            var compid = $("[id*=hdnCompanyID]").val();
            
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../handler/Ws_Deductee.asmx/delete_Deductee",
                data: '{compid:' + compid + ',did:' + did + '}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    if (myList.length > 0) {
                        if (myList[0].did > 0) {
                            alert('Deductee Deleted');
                            fillDeducteeGrid(1, 25, '', '', '');
                            ResetVar();
                        }
                        else
                        {
                            alert('Deductee already exist');
                        }
                    }

                },
                failure: function (response) {
                    alert('Cant Connect to Server' + response.d);
                },
                error: function (response) {
                    alert('Error Occoured ' + response.d);
                }
            });
        }

        function Edit_Rec(i) {
            var row = i.closest("tr");
            var did = row.find("input[name=hdndid]").val();
            var compid = row.find("input[name=hdncid]").val();
            var Conn = $("[id*=hdnConnString]").val();
            $("[id*=hdnid]").val(did);
            $("[id*=drp_Reasons]").attr("disabled", false);

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../handler/Ws_Deductee.asmx/Edit_Deductee",
                data: '{compid:' + compid + ',did:' + did + '}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    if (myList.length > 0) {
                        $("[id*=divDetails]").show();
                        $("[id*=divGrid]").hide();
                        $("[id*=divSearch]").hide();
                        $("[id*=txt_PanNo]").val(myList[0].PAN);
                        $("[id*=txt_Name]").val(myList[0].DName);
                        $("[id*=drp_Type]").val(myList[0].DType);
                        $("[id*=drp_Reasons]").val(myList[0].DReason);
                        $("[id*=txt_FlatNo]").val(myList[0].Add1);
                        $("[id*=txt_Email]").val(myList[0].Emailid);
                        $("[id*=txt_Street]").val(myList[0].Add2);
                        $("[id*=txtContact]").val(myList[0].Contactno);
                        $("[id*=drp_TdsRateNRI]").val(myList[0].NriTDSRT);
                        $("[id*=txtTaxIdentificationno]").val(myList[0].TaxId);
                        $("[id*=drp_Country]").val(myList[0].Countryid);
                        $("[id*=txt_TDSRate]").val(myList[0].TDSRT);
                        $("[id*=txt_SurCharge]").val(myList[0].Surcharge);
                        $("[id*=drpBAC1A]").val(myList[0].BAC_1A);
                        var r = myList[0].TDSRT_FR;
                        if (r == 0)
                        {
                            $("[id*=rd1]").attr('checked', 'checked');
                            $("[id*=rd2]").removeAttr('checked');
                        }
                        else
                        {
                            $("[id*=rd1]").removeAttr('checked');
                            $("[id*=rd2]").attr('checked', 'checked');
                        }
                        if (myList[0].isInd == 'True')
                        {
                            $("[id*=drp_Type]").val('Individual');
                        }
                        else
                        {
                            $("[id*=drp_Type]").val(myList[0].DType);
                        }

                        if (myList[0].isNri == true)
                        {
                            $("[id*=drpNri]").val('Yes');
                            $("[id*=drp_TdsRateNRI]").attr("disabled", false);
                            $("[id*=drp_Country]").attr("disabled", false);
                            $("[id*=txt_Email]").attr("disabled", false);
                            $("[id*=txt_FlatNo]").attr("disabled", false);
                            $("[id*=txtContact]").attr("disabled", false);
                            $("[id*=txt_Street]").attr("disabled", false);
                            $("[id*=txtTaxIdentificationno]").attr("disabled", false);
                        }
                        else
                        {
                            $("[id*=drpNri]").val('No');
                            $("[id*=drp_TdsRateNRI]").attr("disabled", true);
                            $("[id*=drp_Country]").attr("disabled", true);
                            $("[id*=txt_Email]").attr("disabled", true);
                            $("[id*=txt_FlatNo]").attr("disabled", true);
                            $("[id*=txtContact]").attr("disabled", true);
                            $("[id*=txt_Street]").attr("disabled", true);
                            $("[id*=txtTaxIdentificationno]").attr("disabled", true);
                        }
                         

                    }

                },
                failure: function (response) {
                    alert('Cant Connect to Server' + response.d);
                },
                error: function (response) {
                    alert('Error Occoured ' + response.d);
                }
            });
        }

        function ResetVar()
        {
            $("[id*=txt_PanNo]").val('');
            $("[id*=txt_Name]").val('');
            $("[id*=drp_Type]").val(0);
            $("[id*=drp_Reasons]").val(0);
            $("[id*=txt_FlatNo]").val('');
            $("[id*=txt_Email]").val('');
            $("[id*=txt_Street]").val('');
            $("[id*=txtContact]").val('');
            $("[id*=drp_TdsRateNRI]").val('');
            $("[id*=txtTaxIdentificationno]").val('');
            $("[id*=drp_Country]").val(0);
            $("[id*=txt_TDSRate]").val('0');
            $("[id*=txt_SurCharge]").val('0');
            $("[id*=drp_Reasons]").attr("disabled", false);
        }



        function ShowLoader() {

            $('.MastermodalBackground2').css("display", "block");
        }

        function hideloader() {

            $('.MastermodalBackground2').css("display", "none");
        }

        function UpdatePANVerification(BulkPAN)
        {
            var compid = $("[id*=hdnCompanyID]").val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../handler/Ws_Deductee.asmx/Update_PAN_Verification",
                data: '{compid:' + compid + ',BulkPAN:"' + BulkPAN + '" }',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    if (myList.length > 0) {
                        alert('PAN verification complete');
                        fillDeducteeGrid(1, 25, '', '', '');
                    }

                },
                failure: function (response) {
                    alert('Cant Connect to Server' + response.d);
                },
                error: function (response) {
                    alert('Error Occoured ' + response.d);
                }
            });
        }


        function HideModalPopup() {
            $find("programmaticModalPopupOrginalBehavior").hide();
            return false;
        }
        ///// show modalpopup
        function ShowModalPopup() {
            $find("programmaticModalPopupOrginalBehavior").show();
            return false;
        }

        function loadLoginDetails() {
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

        //reuestDownloads
        TracesDetails = function () {
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
 
        }

        TracesDetails = function () {
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


    </script>

</asp:Content>
<asp:Content id="Content2" ContentPlaceHolderid="MasterPage" runat="Server">
    <asp:HiddenField ID="hdnCompanyID" runat="server" />
    <asp:HiddenField ID="hdnConnString" runat="server" />
    <asp:HiddenField ID="hdnPages" runat="server" />            
    <asp:HiddenField ID="hdnid" runat="server" /> 
    <div class="cssPageTitle">
        <label id="Label1" >Deductee</label>
    </div>
                 
    <div id="divSearch" >
        <table style="width:100%" cellpadding="3" cellspacing="0">
            <tr runat="server" id="TableRow1">
                <td style="width:120px">
                    <label id="Label46"  class="cssLabel" >Deductee Name</label>
                </td>
                <td colspan="3">
                    <table id="Table11"  style="width:100%" cellpadding="0"
                        cellspacing="0">
                        <tr>
                            <td>
                                <input id="txtSearchName" class="cssTextbox"  style="width:300px;" /> 
                            </td>
                            <td style="width:100px">
                                <input type="button"  id="btnSearch" value="Search" class="cssButton"   />
                                                
                            </td>
                            <td>
                                <input type="button"  id="btnAddNew" 
                                    class="cssButton" value="Add New Deductee" />
                                <input  type="button" id="btnBulkPAN" class="cssButton"
                                    value="Bulk Pan Verification" />
                            </td>

                            <td style="text-align: right;">&nbsp;&nbsp;Pg Size&nbsp;
                                <select id="ddlperpage" class="cssDropDownList" style="width:60px;"  >
                                    <option value="25">25</option>
                                    <option value="75">75</option>
                                    <option value="200">200</option>
                                    <option value="800">800</option>
                                    <option value="1200">1200</option>
                                    <option value="2000">2000</option>

                                </select>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr runat="server" id="TableRow5">
                <td>
                    <label id="Label47"  class="cssLabel" >Filter By</label>
                </td>
                <td style="width:550px; ">
                    <select id="ddlSearchReasons" class="cssDropDownList">
                        <option value="">Select Reasons</option>
                        <option value="Presc.Rt.">Presc.Rt.</option>
                        <option value="Lower Rt. Under Section 197 A">Lower Rt. Under Section 197 A</option>
                        <option value="No Tax only for sec 194, 194A, 194EE And 193 B">No Tax only for sec 194, 194A, 194EE And 193 B</option>
                        <option value="No Tax on A/c of pmt under sec 197A Z">No Tax on A/c of pmt under sec 197A Z</option>
                        <option value="Non-Availability of PAN C">Non-Availability of PAN C</option>
                        <option value="Transporter and valid PAN T">Transporter and valid PAN T</option>
                        <option value="Software acquired under section 194J S">Software acquired under section 194J S</option>
                    </select>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <select id="ddlSearchPAN" class="cssDropDownList">
                        <option value="">Select PAN Status</option>
                        <option value="InValid PAN">InValid PAN</option>
                        <option value="Valid PAN">Valid PAN</option>
                        <option value="PAN Not Available">PAN Not Available</option>
                    </select>
                </td>
                <td style="width:140px;"><input id="txtPANSrch" name="txtPANSrch" runat="server" placeholder="PAN Search" style="width:120px; height:25px; text-transform: uppercase;" maxlength="10" value="" class="cssTextbox" type="text" />
                </td>
                <td style="width:400px">
                    <input type="button" id="btnSPAN" class="cssButton"  value="Search"  style="height:28px;" /> 
                </td>
            </tr>
        </table>
    </div>
                 
    <div id="divGrid"  style="width:100%;" >
                     
        <table id="tblDeductee" class="tblBorderClass" style="width:100%;" >

        </table>
        <table id="tblPager" style="border: 1px solid #BCBCBC; border-bottom: none; background-color: rgba(219,219,219,0.54); text-align: right;"
            cellpadding="2" cellspacing="0" width="1100px">
            <tr>
                <td>
                    <div class="Pager">
                    </div>
                </td>
            </tr>
        </table>                   
    </div>
    <div id="divDetails" >
                    
        <div>
            <fieldset style="border: solid 1px black; padding: 10px;">
                <legend>Deductee Details</legend>
                <table id="table1" style="width:100%">
                    <tr>
                        <td>
                            <span style="color: Red;">
                                PAN</span>
                        </td>
                        <td>
                            <input id="txt_PanNo" runat="server" maxlength="10" style="width:100px; value-transform: uppercase" 
                                class="cssTextbox" />&nbsp;&nbsp;<input id="PnvVerfy" type="button" value="Pan Verify" title="Verify PAN with Traces" class="cssButton"/>
                            <label id="lblPanVerified" runat="server" value=""></label>

                        </td>

                    </tr>
                    <tr>
                        <td style="width:84px;">
                            <span style="color: Red">
                                Name</span>
                        </td>
                        <td style="width:487px; ">
                            <input id="txt_Name" runat="server" style="width:400px;" class="cssTextbox"/>

                        </td>
                        <td >
                            <asp:CheckBox id="chk_ApplicationToAll" runat="server" class="cssCheckBox" />
                        </td>
                        <td style="width:290px;">
                            Application For All Companies
                        </td>

                        <td style="width:100px;">
                            &nbsp;
                        </td>
                        <td style="width:200px;">
                            <label  id="lblduplicateError"></label>
                        </td>                                               
                    </tr>

                </table>
            </fieldset>
            </div>  
        <div> 
            <fieldset style="border: solid 1px black; padding: 10px;">
                            <legend>TDS Details</legend>
                            <table  id="table2" style="width:100%">
                                <tr>

                                    <td style="width:84px;">
                                        <span style="color: Red;">
                                            Type</span>
                                    </td>
                                    <td>
                                        <select id="drp_Type" runat="server" style="width:300px;"
                                            class="cssDropDownList">
                                            <option value="0" >Select Type</option>
                                            <option value="Company">Company</option>
                                            <option value="Hindu">Hindu Undivided Family </option>
                                            <option value="AOP">Association of Persons (AOP) </option>
                                            <option value="AOPCM">Association of Persons (Others)</option>
                                            <option value="ST">Co-operative Society/ Trust</option>
                                            <option value="Firm">Firm</option>
                                            <option value="BInd">Body of individuals</option>
                                            <option value="Artificial">Artificial juridical person</option>
                                            <option value="Others">Others</option>
                                            <option value="Individual">Individual</option>
                                        </select>
                                        <label >All new deductee type are applicable for 27Q & 27EQ</label> 
                                    </td>

                                    <td>
                                        <span style="color: Red">
                                            Reasons</span>
                                    </td>
                                    <td> 
                                        <select id="drp_Reasons" runat="server" style="width:300px;"
                                            class="cssDropDownList">
                                            <option value="0">Select Reasons</option>
                                            <option value="Presc.Rt.">Presc.Rt.</option>
                                            <option value="Lower Rt. Under Section 197 A">Lower Rt. Under Section 197 A</option>
                                            <option value="No Tax only for sec 194, 194A, 194EE And 193 B">No Tax only for sec 194, 194A, 194EE And 193 B</option>
                                            <option value="No Tax on A/c of pmt under sec 197A Z">No Tax on A/c of pmt under sec 197A Z</option>
                                            <option value="Non-Availability of PAN C">Non-Availability of PAN C</option>
                                            <option value="Transporter and valid PAN T">Transporter and valid PAN T</option>
                                            <option value="Software acquired under section 194J S">Software acquired under section 194J S</option>
                                        </select>
                                                
                                    </td>

                                </tr>
                                <tr>
                                    <td style="color: Red;">Opting for 115BAC(1A)
                                    </td>
                                    <td style="font-family: Verdana;">
                                        <select id="drpBAC1A" runat="server" tabindex="18" class="cssDropDownList"
                                                style="width: 100px; height: 25px;">
                                            <option value="">Select</option>
                                            <option value="Y">Yes</option>
                                            <option value="N">No</option>                                            

                                        </select>
                                        <label>Only for 27EQ</label>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
        </div>
        <div>
            <fieldset  id="fldNRI" runat="server"  style="border: solid 1px black; padding: 10px;">
                            <legend>Form 27Q NRI Details</legend>
                            <table  id="table3" style="width:100%">
                                <tr>
                                    <td>
                                        <span style="color: Red">
                                            Is Nri</span>
                                    </td>            
                                    <td>
                                        <select id="drpNri" runat="server" style="width:100px"
                                            class="cssDropDownList">
                                            <option value="No">No</option>
                                            <option value="Yes">Yes</option>
                                        </select>
                                    </td>
                                    <td><span style="color: Red">
                                        TDS Rate</span></td>
                                    <td>
                                        <select id="drp_TdsRateNRI" runat="server" style="width:300px"
                                            class="cssDropDownList">
                                            <option value="0">Select</option>
                                            <option value="If TDS rate is as per Income TaxAct A">If TDS rate is as per Income TaxAct A</option>
                                            <option value="If TDS rate is as per DTAA B">If TDS rate is as per DTAA B</option>
                                        </select>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <span style="color: Red">
                                            Country</span>
                                    </td>
                                    <td>
                                        <select id="drp_Country" runat="server" style="width:300px"
                                            class="cssDropDownList">
                                            <option value="0">Select</option>
                                        </select>
                                    </td>

                                    <td>
                                        Email
                                    </td>
                                    <td>
                                        <input id="txt_Email" runat="server" style="width:300px" class="cssTextbox"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Address
                                    </td>
                                    <td>
                                        <input id="txt_FlatNo"  style="width:300px" class="cssTextbox" /> 
                                    </td>

                                    <td>
                                        Contact No
                                    </td>
                                    <td>
                                        <input id="txtContact" runat="server" style="width:150px" maxlength="15"
                                            class="cssTextbox"/>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                                     
                                    </td>
                                    <td>
                                        <input id="txt_Street" runat="server" style="width:300px" class="cssTextbox"/>
                                    </td>
                                    <td>
                                        Tax Identification No
                                    </td>
                                    <td>
                                        <input runat="server" id="txtTaxIdentificationno" maxlength="25"
                                            style="width:300px" class="cssTextbox"/>
                                                 
                                    </td>

                                </tr>


                            </table>
                        </fieldset>
        </div>
        <div>
            <fieldset id="fldRT" runat="server"  style="border: solid 1px black; padding: 10px;">
                            <legend style="font-size: 11pt; color: #555; font-weight: bold;">
                                TDS Rate From</legend>

                <table  id="table4" style="width:100%">
                    <tr>
                        <td>

                            <fieldset>
                                <input id="rd1" type="radio" name="rad" value="1">Slab </input>
                                <input id="rd2" type="radio" name="rad" value="0">Deductee Master </input> 
                            </fieldset>

                        </td>
                        <td style="value-align: right; padding-top:15px;">
                            TDS Rate
                        </td>
                        <td style="padding-top:15px;">
                            <input id="txt_TDSRate"  style="width:50px"  runat="server" class="cssTextbox"
                                maxlength="5"/>

                        </td>
                        <td style="value-align: right; padding-top:15px;">
                            SurCharge
                        </td>
                        <td style="padding-top:15px;">
                            <input id="txt_SurCharge"  style="width:50px" class="cssTextbox" maxlength="5"/>
                        </td>
                    </tr>
                </table>

            </fieldset>
        </div>
        <div>      
            <table  id="table5" style="width:100%">
                <tr>
                    <td>
                        <input type="button" id="btnSave" value="Save" class="cssButton" />
                                                  
                        &nbsp;
                        <input type="button" id="btnCancel" value="Cancel"  class="cssButton"  />
                        <asp:HiddenField id="hdnDeducteeID" Value="" runat="server" />
                    </td>
                </tr>
            </table>
        </div> 
                    
</div>

    <asp:Button Style="display: none" ID="hideModalPopupViaClientOrginal" runat="server"></asp:Button><br />
    <cc1:ModalPopupExtender BackgroundCssClass="modalBackground" BehaviorID="programmaticModalPopupOrginalBehavior"
        RepositionMode="RepositionOnWindowScroll" DropShadow="False" ID="ModalPopupExtender2"
        TargetControlID="hideModalPopupViaClientOrginal" CancelControlID="imgBudgetdClose"
        PopupControlID="panel10" runat="server">
    </cc1:ModalPopupExtender>

    <asp:Panel ID="panel10" runat="server" Width="700px" Height="390px" BackColor="#FFFFFF">
        <div id="Div1" style="width: 100%; float: left; background-color: #55A0FF; color: #ffffff; font-weight: bold;">
            <div id="Div2" style="width: 90%; float: left; height: 20px; padding-left: 2%; padding-top: 1%">
                <asp:Label ID="lblpopup" runat="server" Font-Size="Larger" CssClass="subHead1 labelChange" Text=""></asp:Label>
            </div>
            <div id="Div3" class="ModalCloseButton">
                <img alt="" src="../images/error.png" id="imgBudgetdClose" border="0" name="imgClose"
                    onclick="return HideModalPopup()" />
            </div>
        </div>
        <div style="padding: 5px 5px 5px 5px; height:295px;" id="addtasks" runat="server" class="comprw">
            <div id="divJb" class="divedBlock" style="padding-top: 10px;height: 395px;">

                <div style="overflow: hidden; width: 680px; height: 390px; float: left; padding-left: 5px;">
                    <img alt="" src="../images/tds-logo.png" id="imgTraces" border="0" name="imgTraces"  />
                    <asp:Panel ID="pnljb" runat="server"  Height="290px" Width="680px">
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
                                            <input id="txtTan" name="txtTan"  class="cssTextbox" type="text" style="width: 120px;" value=""  autocomplete="none" />
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
                                            <input id="txtPassword" class="cssTextbox" style="width: 120px;" type="password" value="" />
                                        </td>

                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>
                                            <input type="submit" name="btnSaveRequest" value="Save" id="btnSaveRequest" class="cssButton" onclick="return TracesDetails();" /></td>
                                    </tr>
                                </table>
                        <table id="tblver" name="tblver" >
                            <tr>
                                <td>
                                    PAN &nbsp;&nbsp;<input id="txtPAN" class="cssTextbox" style="width: 120px;" type="text" value="" required="true" />
                                    
                                </td>
                                <td>
                                    <label id="lbldPAN" style="font-weight: bold;"></label>
                                </td>
                            </tr>
                            <tr id="trAuto1" name="trAuto1">
                                <td style="text-align:right;">
                                    <img id="captchaImg" class="captchaimg1" alt="Captcha" src="" /></td>
                                <td>
                                    <img src="../Images/refresh.png" style="width: 20px; padding-right: 10px; cursor: pointer;" onclick="return getCaptcha();" />
                                    <label style="font-weight: bold;">Click to refresh image</label>

                                </td>
                            </tr>
                            <tr style="height:15px;" >
                                <td></td>
                            </tr>
                            <tr id="trAuto2" name="trAuto2" >
                                <td style="font-weight: bold;font-size:14px; text-align:right;">Enter text as in above image</td>
                                <td style="text-align:left;">
                                   <input autocomplete="off" id="captcha" class="frmtxtbox" maxlength="5" required="true" style="width:100px; " value="" />
                                </td>
                             </tr>
                            <tr style="height:15px;" >
                                <td></td>
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

