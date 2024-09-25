<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="ManageNonSalary_Challan.aspx.cs" Inherits="Forms._ManageNonSalary_Challan" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<%--    <script src="../Scripts/jquery-2.1.3.min.js" type="text/javascript"></script>--%>
    <script type="text/javascript" src="../Scripts/jquery1.7.2.min.js"></script>
    <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>
    <link href="../css/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        //////////variable declaration
        //////////after rendering page load initialize like pageload event
        var TotalVCount = 0;
        var PSize = 3000;
        var PIndex = 1;
        var PCount = 1;
        $(document).ready(function () {
            $("[id*=lblMismatch]").hide();
            $("[id*=nextRec]").hide();
            QuarterWiseDateSet();
            var Conn = $("[id*=ddlFinancialYear] :selected").text();
            $("[id*=hdnConnString]").val(Conn);
            //////////on submit or press enter key event disabled
            $('form').bind("keypress", function (e) {
                if (e.keyCode == 13) {
                    e.preventDefault();
                    return false;
                }
            });

            ////////////////nature selection popup settings
            $("#dialog1").dialog({
                autoOpen: false,
                title: "Select Quarter & Return Type",
                width: 600,
                modal: true
            });
            /////////////events 

            $(document).on('click', "[id*=btnSubmitNatures]", function () {
                if (!ValidateCheckBoxList()) {
                    alert('Please select at least one Nature.');
                    return false;
                }
                QuarterWiseDateSet();
                $("[id*=lblSelectedQuarter]").val($("[id*=ddlQuaterType]").val());
                pageindex = 1;
                TableRemoveRows();
                //GetVoucherList($("[id*=hdnjavascriptcheckbalues]").val(), pageindex);
                MisMatch_Vouchers();
                $("#dialog1").dialog('close');
                return false;
            });

            //////////////close nature selection dialogue on cancel
            $("#JavaScriptCancel").click(function () {
                $("#dialog1").dialog('close');
            });
            ///////////////open nature selection dialogue
            $("#opener").click(function () {
                $("#dialog1").dialog('open');
                $('.ui-dialog-titlebar-close').hide();
                return false;
            });

            $("#nextRec").click(function () {
                if (PCount >= PIndex) {
                    var Nlist = $("[id*=hdnjavascriptcheckbalues]").val();
                    get_Vouchers(PIndex, PSize, Nlist);
                    PIndex = PIndex + 1;
                }
                else
                {
                    $("#nextRec").hide();
                }

            });
            /////////////naturer select all
            $(document).on('click', "[id*=chknaturesselectall]", function () {
                var check = $(this).is(":checked");
                $("[id*=chkNatures]").each(function () {
                    if (check) {
                        $(this).prop("checked", "checked");
                    }
                    else { $(this).removeAttr("checked"); }
                });
            });
            //////////if all nuture select manualy then select selectall option or viec versa
            $(document).on('click', "[id*=chkNatures]", function () {
                if ($("[id*=chkNatures] input:checked").length == $("[id*=chkNatures] input").length) {
                    $("[id*=chknaturesselectall]").prop("checked", "checked");
                } else {
                    $("[id*=chknaturesselectall]").removeAttr("checked");
                }
            });


            /////////////voucher select all
            $(document).on('click', "#chkHeader", function () {
                var check = $(this).is(":checked");
                $("input[name=chkVoucherbox]").each(function () {
                    if (check) {
                        $(this).prop("checked", "checked");
                    }
                    else { $(this).removeAttr("checked"); }
                });
                calculateVOucherTotal();
            });
            //////////if all voucher select manualy then select selectall option or viec versa
            $(document).on('click', "input[name=chkVoucherbox]", function () {
                if ($("input[name=chkVoucherbox]").length == $('[name="chkVoucherbox"]:checked').length) {
                    $("#chkHeader").prop("checked", "checked");
                } else {
                    $("#chkHeader").removeAttr("checked");
                }
                calculateVOucherTotal();
            });

            /////////////drop down bank name selection show branch code
            $(document).on('change', "[id*=ddlBankName]", function () {
                var parm = document.getElementById("<%=ddlBankName.ClientID %>");
                // Get Dropdownlist selected value itemMasterPage_
                if (parm.options[parm.selectedIndex].value != '0') {
                    var s = parm.options[parm.selectedIndex].value;
                    var i = s.split(',');
                    $('[id*=txtBranch]').val(i[1]);
                }
                else { $('[id*=txtBranch]').val(''); }
            });

            /////////////challan type change
            $(document).on('change', "[id*=ddlselectedfilter]", function () {
                TableRemoveRows();
                pageindex = 1;
                //GetVoucherList($("[id*=hdnjavascriptcheckbalues]").val(), pageindex);
                MisMatch_Vouchers();
            });

            $(document).on('change', "[id*=txtfilterFromDate]", function () {
                TableRemoveRows();
                pageindex = 1;
                // GetVoucherList($("[id*=hdnjavascriptcheckbalues]").val(), pageindex);
                MisMatch_Vouchers();
            });

            $(document).on('change', "[id*=txtfilterTodate]", function () {
                TableRemoveRows();
                pageindex = 1;
                // GetVoucherList($("[id*=hdnjavascriptcheckbalues]").val(), pageindex);
                MisMatch_Vouchers();
            });

            ///////////////calculate tds,surcharge etc.
            $(document).on('keyup', '.cssTextboxActual', function () {
                if (isNaN(parseFloat($(this).val()))) {
                    $(this).val('0');
                } else {
                    $(this).val(parseFloat($(this).val()).toString());
                }
                CalculateTotal();
            });


            ///////////////////////////////////////////////////////////////////////////////////////////////////////////
        });
        var pageindex = 1;


        //////////call ajax methods
        function GetVoucherList(NatureList, PageIndex) {
            ShowLoader();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ManageNonSalary_Challan.aspx/GetVoucherCount",
                data: "{compid:" + $("[id*=hdnCompanyid]").val() + ",NatureList:'" + NatureList + "',Quarter:'" + $("[id*=ddlQuaterType]").val() + "',Deductee_Type:'" + $("[id*=ddlselectedfilter]").val() + "'}",
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    var TotalCount = 0;
                    if (myList.length > 0) {
                        TotalCount = myList[0].TotalCount;
                    }
                    var PageSizen = 3000;
                    if (TotalCount > 3000) {
                        
                        var PIndex = parseFloat(TotalCount) / parseFloat(PageSizen);
                        PIndex = parseInt(PIndex) + 1;
                        PCount = PIndex
                        PIndex = 1;
                        get_Vouchers(PIndex, PageSizen, NatureList);
                        PIndex = PIndex + 1;
                        $("[id*=nextRec]").show();
                    }
                    else {
                        //var gotoserver = parseFloat(TotalCount) / parseFloat(PageSizen);
                        //gotoserver = parseInt(gotoserver) + 1;
                        //if (parseFloat(TotalCount) <= PageSizen) {
                        //    gotoserver = 1;
                        //}
                        //for (i = 1; i <= gotoserver; i++) {
                        PIndex = 1;
                        get_Vouchers(PIndex, PageSizen, NatureList);
                        //}
                    }
                },
                failure: function (response) {
                    hideloader();
                },
                error: function (response) {
                    hideloader();
                }
            });

        }
        //////////ajax success methods
        function OnsuccessVoucherList(response) {
            try {
                var totalinex = 1;
                var myList = jQuery.parseJSON(response.d);
                if (myList.length > 0) {
                    var tr;
                    for (var i = 0; i < myList.length; i++) {
                        tr = $('<tr class="cssGridAlternatingItemStyle" />');
                        tr.append("<td class='setBorderJsonTd'><input type='checkbox' id='chkVoucherbox' name='chkVoucherbox' value='" + myList[i].Voucher_ID + "' /><input type='hidden' name='hdnhiddennatureid' value='" + myList[i].Nature_ID + "'/><input type='hidden' name='hdndeducteetype' value='" + myList[i].Deductee_Type + "'/></td>");
                        tr.append("<td class='setBorderJsonTd'>" + myList[i].Nature_Sub_ID + "</td>");
                        tr.append("<td class='setBorderJsonTd'>" + myList[i].Deductee_Name + "</td>");
                        tr.append("<td class='setBorderJsonTd'>" + myList[i].PAN_NO + "</td>");
                        tr.append("<td class='setBorderJsonTd'>" + myList[i].Section + "</td>");
                        tr.append("<td class='setBorderJsonTd' align='right'>" + myList[i].Voucher_Amount + "</td>");
                        tr.append("<td class='setBorderJsonTd' align='right'>" + myList[i].TDS_Amt + "</td>");
                        tr.append("<td class='setBorderJsonTd' align='right'>" + myList[i].Surcharge_Amt + "</td>");
                        tr.append("<td class='setBorderJsonTd' align='right'>" + myList[i].ECess_Amt + "</td>");
                        tr.append("<td class='setBorderJsonTd' align='right'>" + myList[i].HECess_Amt + "</td>");
                        tr.append("<td class='setBorderJsonTd' align='right'>" + myList[i].Total_Tax_Amt + "</td>");
                        $('#jsonTable tbody').append(tr);
                       // totalinex = myList[i].Company_ID;
                        totalinex = myList[i].TotalIndex;
                    }


                  
                }
                else
                {
                    hideloader();
                }
            } catch (e) {
                ErrorShow(e);
            }
             hideloader();
        }
        //////////ajax error handler
        function OnError(xhr, errorType, exception) {
            var responseText;
            var msg = "";
            hideloader();
            try {
                responseText = jQuery.parseJSON(xhr.responseText);
                msg = msg + ("<div style='width:100%'><b>" + errorType + " " + exception + "</b></div>");
                msg = msg + ("<div style='width:100%'><u>Exception</u>:<br /><br />" + responseText.ExceptionType + "</div>");
                msg = msg + ("<div style='width:100%'><u>StackTrace</u>:<br /><br />" + responseText.StackTrace + "</div>");
                msg = msg + ("<div style='width:100%'><u>Message</u>:<br /><br />" + responseText.Message + "</div>");
                hideloader();
            } catch (e) {
                responseText = xhr.responseText;
                msg = msg + (responseText);
                hideloader();
            }
            ErrorShow(msg);
        }

        function get_Vouchers(PI, PS, NatureList)
        {
            var compid= $("[id*=hdnCompanyid]").val() ;
        
            var Quarter= $("[id*=ddlQuaterType]").val() ;
            
            var challanType=$("[id*=ddlselectedfilter]").val() ;
            var VoucherIDs=$("[id*=hdnOnPagePresentVoucherIDs]").val() ;
            var FromDate= $("[id*=txtfilterFromDate]").val() ;
            var todate= $("[id*=txtfilterTodate]").val() ;
             

            try {
                $.ajax({
                    type: "POST",
                    url: "ManageNonSalary_Challan.aspx/GetVoucherList",
                    data: "{compid:" + compid + ",NatureList:'" + NatureList + "',Quarter:'" + Quarter + "',PageIndex:" + PI + ",challanType:'" + challanType + "',hdnOnPagePresentVoucherIDs:'" + VoucherIDs + "',FromDate:'" + FromDate + "',todate:'" + todate + "', PageSize:" + PS + "}",
                    dataType: 'json',
                    contentType: "application/json",
                    MaxJsonLength: 86753090 ,
                    success: OnsuccessVoucherList,
                    failure: OnError,
                    error: OnError
                });
            } catch (e) {
                ErrorShow(e);
            }
        }

        function MisMatch_Vouchers()
        {
            var Conn = $("[id*=hdnConnString]").val();
            var compid = parseFloat($("[id*=hdnCompanyid]").val());
            $("[id*=hdnQuater]").val($("[id*=ddlQuaterType]").val());
            var q = $("[id*=hdnQuater]").val();
            var f = $("[id*=ddlReturnType]").val();
            var Err = "";
            //Ajax start
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../handler/Voucher.asmx/MisMatch_Vouchers",
                data: '{compid:' + compid + ',f:"' + f + '",q:"' + q + '", Conn:"' + Conn + '"}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);

                    myList = myList[0];

                    var PAN = myList.Lst_PAN;   //
                    var Nri = myList.Lst_Nri;    //
                    var BAC = myList.Lst_BACIA;
                    var Dtype = myList.Lst_DType;
                    var Trans = myList.Lst_Tr;    //

                    var tbl = '';
                    if (PAN.length > 0) {
                        $("[id*=tblError]").show();
                        $("[id*=tblmain]").hide();
                        $("[id*=lblMismatch]").show();
                        Err = "1";
                        //tbl = tbl + "<tr >";
                        //tbl = tbl + "<th style='width:10%;text-align: center;' class='cssGridHeader'>Date</th>";
                        //tbl = tbl + "<th style='width:30%;text-align: center;' class='cssGridHeader'>Deductee</th>";
                        //tbl = tbl + "<th style='width:20%;text-align: center;' class='cssGridHeader'>Voucher Amt</th>";
                        //tbl = tbl + "<th style='width:10%;text-align: center;' class='cssGridHeader'>Voucher PAN</th>";
                        //tbl = tbl + "<th style='width:10%;text-align: center;' class='cssGridHeader'>Deductee PAN</th></tr>";
                        //for (var i = 0; i < PAN.length; i++) {
                        //    tbl = tbl + "<tr >";
                        //    tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + PAN[i].PDate + "<input type='hidden' name='hdnVid' value='" + PAN[i].Vid + "'/></td>";
                        //    tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + PAN[i].DName + "</td>";
                        //    tbl = tbl + "<td class='setBorderJsonTd' style='text-align: right;'>" + PAN[i].AmtPaid + "</td>";
                        //    tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + PAN[i].VPAN + "</td>";
                        //    tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + PAN[i].DPAN + "</td>";
                            
                        //};

                        //$("[id*=tblMismatch]").append(tbl);
                    }
                    else if (Nri.length > 0) {
                        $("[id*=tblError]").show();
                        $("[id*=tblmain]").hide();
                        $("[id*=lblMismatch]").show();
                        Err = "1";
                        //tbl = tbl + "<tr >";
                        //tbl = tbl + "<th style='width:10%;text-align: center;' class='cssGridHeader'>Deductee</th>";
                        //tbl = tbl + "<th style='width:30%;text-align: center;' class='cssGridHeader'>Email</th>";
                        //tbl = tbl + "<th style='width:20%;text-align: center;' class='cssGridHeader'>Contact No</th>";
                        //tbl = tbl + "<th style='width:10%;text-align: center;' class='cssGridHeader'>Tax Identification</th>";
                        //tbl = tbl + "<th style='width:10%;text-align: center;' class='cssGridHeader'>Address</th></tr>";
                        //for (var i = 0; i < Nri.length; i++) {
                        //    tbl = tbl + "<tr >";
                        //    tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + Nri[i].DName + "</td>";
                        //    tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + Nri[i].Email + "</td>";
                        //    tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + Nri[i].Tel + "</td>";
                        //    tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + Nri[i].Tax + "</td>";
                        //    tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + Nri[i].Add + "</td>";

                        //};

                        //$("[id*=tblMismatch]").append(tbl);
                    }
                    else if (Trans.length > 0) {
                        $("[id*=tblError]").show();
                        $("[id*=tblmain]").hide();
                        $("[id*=lblMismatch]").show();
                        Err = "1";
                        //tbl = tbl + "<tr >";
                        //tbl = tbl + "<th style='width:10%;text-align: center;' class='cssGridHeader'>Date</th>";
                        //tbl = tbl + "<th style='width:30%;text-align: center;' class='cssGridHeader'>Deductee</th>";
                        //tbl = tbl + "<th style='width:15%;text-align: center;' class='cssGridHeader'>Voucher Amt</th>";
                        //tbl = tbl + "<th style='width:10%;text-align: center;' class='cssGridHeader'>TDS</th>";
                        //tbl = tbl + "<th style='width:10%;text-align: center;' class='cssGridHeader'>Correct TDS</th>";
                        //tbl = tbl + "<th style='width:5%;text-align: center;' class='cssGridHeader'>Rate</th>";
                        //tbl = tbl + "<th style='width:10%;text-align: center;' class='cssGridHeader'>Certificate</th>";
                        //tbl = tbl + "<th style='width:20%;text-align: center;' class='cssGridHeader'>Error</th></tr>";
                        //for (var i = 0; i < Trans.length; i++) {
                        //    tbl = tbl + "<tr >";
                        //    tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + Trans[i].PDate + "<input type='hidden' name='hdnVid' value='" + Trans[i].Vid + "'/></td>";
                        //    tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + Trans[i].DName + "</td>";
                        //    tbl = tbl + "<td class='setBorderJsonTd' style='text-align: right;'>" + Trans[i].AmtPaid + "</td>";
                        //    tbl = tbl + "<td class='setBorderJsonTd' style='text-align: right;'>" + Trans[i].TdsAmt + "</td>";
                        //    tbl = tbl + "<td class='setBorderJsonTd' style='text-align: right;'>" + Trans[i].CTdsAmt + "</td>";
                        //    tbl = tbl + "<td class='setBorderJsonTd' style='text-align: right;'>" + Trans[i].RT + "</td>";
                        //    tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + Trans[i].Cert + "</td>";
                        //    tbl = tbl + "<td class='setBorderJsonTd' style='text-align: center;'>" + Trans[i].Error + "</td>";

                        //};

                        //$("[id*=tblMismatch]").append(tbl);
                    }
                    else if (Dtype.length > 0) {
                        $("[id*=tblError]").show();
                        $("[id*=tblmain]").hide();
                        $("[id*=lblMismatch]").show();
                        Err = "1";
                    }
                    else if (BAC.length > 0) {
                        $("[id*=tblError]").show();
                        $("[id*=tblmain]").hide();
                        $("[id*=lblMismatch]").show();
                        Err = "1";
                    }
                    if (Err == "") {
                        $("[id*=lblMismatch]").hide();
                        GetVoucherList($("[id*=hdnjavascriptcheckbalues]").val(), pageindex);
                    }
                    else
                    {
                        window.location.href = "Vouchers.aspx?id=Mis," + f + ',' + q;
                    }
                },
                failure: function (response) {

                },
                error: function (response) {

                }
            });
        }

        //////////functions
        function CalculateTotal() {
            var grandtotal = 0;
            $('.cssTextboxActual').each(function () {
                if ($(this).val() == '')
                    $(this).val(0);

                grandtotal = grandtotal + parseFloat($(this).val());
            });
            $('[id*=txtActualDeposite]').val(Math.round(grandtotal));
            finaltotal();
        }

        function finaltotal() {
            var txtActualDeposite = $('[id*=txtActualDeposite]').val();
            var txtAdjDeposite = $('[id*=txtAdjDeposite]').val();

            var total = parseFloat(txtAdjDeposite) - parseFloat(txtActualDeposite);
            $('[id*=txtBalance]').val(Math.round(total));
        }

        /////////check box selection on oucher list
        function calculateVOucherTotal() {
            var grandtotal = 0, grandtotal5 = 0, grandtotal6 = 0, grandtotal7 = 0, grandtotal8 = 0;
            var cell, cell2, Cell5, Cell6, Cell7, Cell8;

            $("[id*=chkVoucherbox]:checked").each(function () {

                var currentrow = $(this).closest("tr");

                grandtotal = grandtotal + parseFloat($("td", currentrow).eq(10).html());
                grandtotal5 = grandtotal5 + parseFloat($("td", currentrow).eq(6).html());
                grandtotal6 = grandtotal6 + parseFloat($("td", currentrow).eq(7).html());
                grandtotal7 = grandtotal7 + parseFloat($("td", currentrow).eq(8).html());
                grandtotal8 = grandtotal8 + parseFloat($("td", currentrow).eq(9).html());
            });
            $('[id*=txtTotalTaxDeposited]').val(Math.round(grandtotal));
            $('[id*=txtAdjDeposite]').val(Math.round(grandtotal));
            $('[id*=txtTDSAdjAmount]').val(Math.round(grandtotal5));
            $('[id*=txtAdjSurcharge]').val(Math.round(grandtotal6));
            $('[id*=txtAdjECess]').val(Math.round(grandtotal7));
            $('[id*=txtAdjHECess]').val(Math.round(grandtotal8));
            CalculateTotal();
        }

        function DateCompare(DateA, DateB) {
            var a = new Date(DateA);
            var b = new Date(DateB);

            var msDateA = Date.UTC(a.getFullYear(), a.getMonth() + 1, a.getDate());
            var msDateB = Date.UTC(b.getFullYear(), b.getMonth() + 1, b.getDate());

            if (parseFloat(msDateA) > parseFloat(msDateB))
                return -1;  // less than
            else if (parseFloat(msDateA) == parseFloat(msDateB))
                return 1;  // equal
            else
                return 1;
        }


        function fn_DateCompare(DateA, DateB) {
            var a = new Date(DateA);
            var b = new Date(DateB);

            var today = new Date();
            var dd = today.getDate();
            var mm = today.getMonth() + 1; //January is 0!
            var yyyy = today.getFullYear();

            var CurrentDate = mm + '/' + dd + '/' + yyyy;
            CurrentDate = new Date(CurrentDate);

            var msDateA = Date.UTC(a.getFullYear(), a.getMonth() + 1, a.getDate());
            var msDateB = Date.UTC(b.getFullYear(), b.getMonth() + 1, b.getDate());
            var msDateCurrent = Date.UTC(CurrentDate.getFullYear(), CurrentDate.getMonth() + 1, CurrentDate.getDate());

            if (parseFloat(msDateA) > parseFloat(msDateB))
                return -1;  // less than
            else if (parseFloat(msDateA) == parseFloat(msDateB))
                return -1;  // equal
            else if (parseFloat(msDateCurrent) < parseFloat(msDateB))
                return 1;  // greater than
            else
                return 0;  // error
        }

        /////////remove vouchers row agains nature id 
        function TableRemoveRows() {
            ////////////get selected nature id in arrary

            var checkednatureid = $("[id*=hdnjavascriptcheckbalues]").val().split(',');


            var hdnOnPagePresentVoucherIDs = '';

            $("[id*=chkVoucherbox]").each(function () {
                var fromdate = $("[id*=txtfilterFromDate]").val();
                var todate = $("[id*=txtfilterTodate]").val();

                fromdate = fromdate.split('/');
                todate = todate.split('/');

                fromdate = new Date(fromdate[2], parseFloat(fromdate[1]) - 1, fromdate[0]);
                todate = new Date(todate[2], parseFloat(todate[1]) - 1, todate[0]);


                hdnOnPagePresentVoucherIDs = $(this).val() + ',' + hdnOnPagePresentVoucherIDs;
                var currentrow = $(this).closest("tr");
                var hdndeducteetype = $("input[name=hdndeducteetype]", currentrow).val();
                var hdnhiddennatureid = $("input[name=hdnhiddennatureid]", currentrow).val();
                var currdate = $("td", currentrow).eq(1).html();
                currdate = currdate.split('/');
                currdate = new Date(currdate[2], parseFloat(currdate[1]) - 1, currdate[0]);
                /////////////if selected nature id remove
                if (checkednatureid.indexOf(hdnhiddennatureid) == -1) {
                    currentrow.remove();
                }
                else if ($("[id*=ddlselectedfilter]").val() != "Both") {
                    /////////////IF challan type company or other
                    if ($("[id*=ddlselectedfilter]").val() != hdndeducteetype) {
                        currentrow.remove();
                    }
                }
                else {
                    if (fromdate <= currdate && currdate <= todate)
                    { }
                    else { currentrow.remove(); }
                }


            });

            /////////////set present voucher id 
            $("[id*=hdnOnPagePresentVoucherIDs]").val(hdnOnPagePresentVoucherIDs.trimEnd(','));
        }

        function OnNatureList() {
            try {
                var totalinex = 1;
                var myList = jQuery.parseJSON($("[id*=hdnNatureList]").val());
                //$("[id*=tblNatures]").empty();
                $("[id*=tblNatures] tbody").remove();
                if (myList.length > 0) {
                    var tbl = '';
                    var tr = '';
                    for (var i = 0; i < myList.length; i++) {
                        tr = $('<tr><td><input type="hidden" name="hdnNid" value="' + myList[i].Nature_ID + '"><input type="checkbox" id="chkNatures" name="chkNatures" value="' + myList[i].Nature_ID + '" />' + myList[i].NatureName + '</td></tr>');
                        $("[id*=tblNatures]").append(tr);
                    }
                }
                if ($("[id*=hdnOnEditVOucherJsonVlaues]").val() != '') {
                    var myList = jQuery.parseJSON($("[id*=hdnOnEditVOucherJsonVlaues]").val());
                    var tr;
                    for (var i = 0; i < myList.length; i++) {
                        tr = $('<tr class="cssGridAlternatingItemStyle" />');
                        tr.append("<td class='setBorderJsonTd'><input type='checkbox' id='chkVoucherbox' name='chkVoucherbox' value='" + myList[i].Voucher_ID + "' /><input type='hidden' name='hdnhiddennatureid' value='" + myList[i].Nature_ID + "'/><input type='hidden' name='hdndeducteetype' value='" + myList[i].Deductee_Type + "'/></td>");
                        tr.append("<td class='setBorderJsonTd'>" + myList[i].Nature_Sub_ID + "</td>");
                        tr.append("<td class='setBorderJsonTd'>" + myList[i].Deductee_Name + "</td>");
                        tr.append("<td class='setBorderJsonTd'>" + myList[i].PAN_NO + "</td>");
                        tr.append("<td class='setBorderJsonTd'>" + myList[i].Section + "</td>");
                        tr.append("<td class='setBorderJsonTd' align='right'>" + myList[i].Voucher_Amount + "</td>");
                        tr.append("<td class='setBorderJsonTd' align='right'>" + myList[i].TDS_Amt + "</td>");
                        tr.append("<td class='setBorderJsonTd' align='right'>" + myList[i].Surcharge_Amt + "</td>");
                        tr.append("<td class='setBorderJsonTd' align='right'>" + myList[i].ECess_Amt + "</td>");
                        tr.append("<td class='setBorderJsonTd' align='right'>" + myList[i].HECess_Amt + "</td>");
                        tr.append("<td class='setBorderJsonTd' align='right'>" + myList[i].Total_Tax_Amt + "</td>");
                        $('#jsonTable tbody').append(tr);
                    }

                    $("#chkHeader").attr('checked', 'checked');
                    $("[id*=chkVoucherbox]").attr('checked', 'checked');

                    calculateVOucherTotal();
                }
            } catch (e) {
                ErrorShow(e);
            }
        }

        function OnEditGetSetVOucherList() {
            var totalinex = 1;
            var myList = jQuery.parseJSON($("[id*=hdnNatureList]").val());
            //$("[id*=tblNatures]").empty();
            $("[id*=tblNatures] tbody").remove();
            if (myList.length > 0) {
                var tbl = '';
                var tr = '';
                for (var i = 0; i < myList.length; i++) {
                    tr = $('<tr><td><input type="hidden" name="hdnNid" value="' + myList[i].Nature_ID + '"><input type="checkbox" id="chkNatures" name="chkNatures" value="' + myList[i].Nature_ID + '" />' + myList[i].NatureName + '</td></tr>');
                    $("[id*=tblNatures]").append(tr);
                }
            }
            var myList = jQuery.parseJSON($("[id*=hdnOnEditVOucherJsonVlaues]").val());
            var tr;
            for (var i = 0; i < myList.length; i++) {
                tr = $('<tr class="cssGridAlternatingItemStyle" />');
                tr.append("<td class='setBorderJsonTd'><input type='checkbox' id='chkVoucherbox' name='chkVoucherbox' value='" + myList[i].Voucher_ID + "' /><input type='hidden' name='hdnhiddennatureid' value='" + myList[i].Nature_ID + "'/><input type='hidden' name='hdndeducteetype' value='" + myList[i].Deductee_Type + "'/></td>");
                tr.append("<td class='setBorderJsonTd'>" + myList[i].Nature_Sub_ID + "</td>");
                tr.append("<td class='setBorderJsonTd'>" + myList[i].Deductee_Name + "</td>");
                tr.append("<td class='setBorderJsonTd'>" + myList[i].PAN_NO + "</td>");
                tr.append("<td class='setBorderJsonTd'>" + myList[i].Section + "</td>");
                tr.append("<td class='setBorderJsonTd' align='right'>" + myList[i].Voucher_Amount + "</td>");
                tr.append("<td class='setBorderJsonTd' align='right'>" + myList[i].TDS_Amt + "</td>");
                tr.append("<td class='setBorderJsonTd' align='right'>" + myList[i].Surcharge_Amt + "</td>");
                tr.append("<td class='setBorderJsonTd' align='right'>" + myList[i].ECess_Amt + "</td>");
                tr.append("<td class='setBorderJsonTd' align='right'>" + myList[i].HECess_Amt + "</td>");
                tr.append("<td class='setBorderJsonTd' align='right'>" + myList[i].Total_Tax_Amt + "</td>");
                $('#jsonTable tbody').append(tr);
            }

            $("#chkHeader").attr('checked', 'checked');
            $("[id*=chkVoucherbox]").attr('checked', 'checked');

            calculateVOucherTotal();
        }

        function QuarterWiseDateSet() {
           var Fyr = $("[id*=ddlFinancialYear] :selected").text();
           var ONLOADfin = Fyr;
            ONLOADfin = ONLOADfin.split('_');
            if ($("[id*=ddlQuaterType] :selected").text() == "Q1") {
                $("[id*=txtfilterFromDate]").val('01/04/' + ONLOADfin[0]);
                $("[id*=txtfilterTodate]").val('30/06/' + ONLOADfin[0]);
            } else if ($("[id*=ddlQuaterType] :selected").text() == "Q2") {
                $("[id*=txtfilterFromDate]").val('01/07/' + ONLOADfin[0]);
                $("[id*=txtfilterTodate]").val('30/09/' + ONLOADfin[0]);
            } else if ($("[id*=ddlQuaterType] :selected").text() == "Q3") {
                $("[id*=txtfilterFromDate]").val('01/10/' + ONLOADfin[0]);
                $("[id*=txtfilterTodate]").val('31/12/' + ONLOADfin[0]);
            } else if ($("[id*=ddlQuaterType] :selected").text() == "Q4") {
                $("[id*=txtfilterFromDate]").val('01/01/20' + ONLOADfin[1]);
                $("[id*=txtfilterTodate]").val('31/03/20' + ONLOADfin[1]);
            }
        }



        //////////////Extra funcations
        function isNumberKey(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 46 || charCode > 57)) {
                return false;
            }
            return true;
        }
        function redidrectomainpage() {
            alert('Challan Saved Successfully');
            window.open('ManageNonSalary_ChallanList.aspx', '_self');
        }




        /////////////////////////////////////////////validations
        //////////////////Custom Validator for Nature Selection
        function ValidateCheckBoxList() {
            var isValid = false;

            <%--            var checkBoxList = document.getElementById("<%=chkNatures.ClientID %>");
            var checkboxes = checkBoxList.getElementsByTagName("input");
            var selected = '';
            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    isValid = true;
                    break;
                }
            }

            if (isValid) {
                for (var i = 0; i < checkboxes.length; i++) {
                    if (checkboxes[i].checked) {
                        selected = checkboxes[i].value + ',' + selected;
                    }
                }
            }--%>
            var All_id = '';
            $("input[name=chkNatures]:checked").each(function () {
                var row = $(this).closest("tr");

                var tid = $("#hdnNid", row).val();

                All_id = $(this).val() + ',' + All_id;
               
            });

            $("[id*=hdnjavascriptcheckbalues]").val(All_id);
            if (All_id != '') {
                isValid = true;
            }
            return isValid;
        }

        function ValidateAdjustAmount(sender, args) {

            var result = 0;
            var isValid = true;
            if ($('[id*=txtTDSActualAmount]').val() >= $('[id*=txtTDSAdjAmount]').val())
            { result = parseFloat(result) + 1; }
            if ($('[id*=txtActualSurcharge]').val() >= $('[id*=txtAdjSurcharge]').val())
            { result = parseFloat(result) + 1; }
            if ($('[id*=txtActualECess]').val() >= $('[id*=txtAdjECess]').val())
            { result = parseFloat(result) + 1; }
            if ($('[id*=txtActualHECess]').val() >= $('[id*=txtAdjHECess]').val())
            { result = parseFloat(result) + 1; }
            if (result == '4') { isValid = true; } else {
                //alert('Warning : Please Check TDS, Surcharge, E Cess, HE Cess Of Actual Amount Equal To Adj(Adjust) Amount ! ***Note : If Challan Paid By Extra Amount that will be Other Amount. ! Challan not Saved.');
                isValid = false;
            }
            args.IsValid = isValid;
        }

        function ValidationBSRCODE(sender, args) {

            var bsr = $("[id*=txtBranch]").val();

            if (bsr.length != 7) {
                args.IsValid = false;
                return;
             
            } else {
                args.IsValid = true;
            }

        }



        function ValidateGridViewCheckbox(sender, args) {

            var hdnCheckedVoucherID = '';
            $("[id*=chkVoucherbox]:checked").each(function () {
                hdnCheckedVoucherID = $(this).val() + ',' + hdnCheckedVoucherID;
            });
            var Nil = $("[id*=ddlNilChallan]").val();
            hdnCheckedVoucherID = hdnCheckedVoucherID.trimEnd(',');
            if (Nil == 'N') {
                if ($("[id*=txtTDSActualAmount]").val() == "0" && $("[id*=txtActualSurcharge]").val() == "0" && $("[id*=txtActualECess]").val() == "0" && $("[id*=txtActualHECess]").val() == "0" && $("[id*=txtActualInterest]").val() != "" && $("[id*=txtActualInterest]").val() != "0" && $("[id*=txtActualOthers]").val() == "0" && $("[id*=txtActualFees]").val() == "0") {
                    hdnCheckedVoucherID = "IntersetChallan";
                }

                if (hdnCheckedVoucherID == "" && $("[id*=txtActualInterest]").val() == "0" && $("[id*=txtActualFees]").val() == "0") {

                    args.IsValid = false;
                    return;
                }
            } else
            {
                args.IsValid = true;
            }

            $("[id*=hdnCheckedVoucherID]").val(hdnCheckedVoucherID);
            args.IsValid = true;
        }
        function ValidationChequeDate(sender, args) {

            var parmdate = $("[id*=txtChaqueDate]").val();
            var dateseparate = parmdate.split('/');
            var dd = dateseparate[0];
            var erro = 0;
            if (parseFloat(dd) > 32 || dd == '00') {
                erro = 1;
            }
            var mon = dateseparate[1];
            if (parseFloat(mon) > 13 || mon == '00') {
                erro = 1;
            }
            var year = dateseparate[2].substring(0, 2);
            if (parseFloat(year) > 21 || year == (00)) {
                erro = 1;
            }

            if (erro == 1) {
                args.IsValid = false;
            }
            else
            { args.IsValid = true; }
        }
        function ValidationForChequeDateWithinFinacial(sender, args) {

            var ChallanDate = $("[id*=txtChaqueDate]").val();
            var ChallanDateSplit = ChallanDate.split('/');
            var financialyears = $("#ddlFinancialYear option:selected").text();
            var startfin = financialyears.split('_');
            var res = fn_DateCompare('04/01/' + startfin[0], ChallanDateSplit[1] + '/' + ChallanDateSplit[0] + '/' + ChallanDateSplit[2]);

            if ('04/01/' + startfin[0] == ChallanDateSplit[1] + '/' + ChallanDateSplit[0] + '/' + ChallanDateSplit[2])
            { res = 0; }

            if (res == 0) {
                args.IsValid = true;
            }
            else
            { args.IsValid = false; }
        }
        function ValidationCh(sender, args) {

            //var le = $("[id*=txtBankChinNo]").val();
            //if (le.length == 5) {
                args.IsValid = true;
            //}
            //else
            //{ args.IsValid = false; }
        }
        function ValidationChqueno(sender, args) {

            var le = $("[id*=txtChequeNo]").val();
            if (le.length == 6) {
                args.IsValid = true;
            }
            else
            { args.IsValid = false; }
        }


        function ValidationChallanDate(sender, args) {

            var parmdate = $("[id*=txtChinDate]").val();
            if (parmdate == '') {
                args.IsValid = false;
                return;
            }
            var dateseparate = parmdate.split('/');
            var dd = dateseparate[0];
            var erro = 0;
            if (parseFloat(dd) > 32 || dd == '00') {
                erro = 1;
            }
            var mon = dateseparate[1];
            if (parseFloat(mon) > 13 || mon == '00') {
                erro = 1;
            }
            var year = dateseparate[2].substring(0, 2);
            if (parseFloat(year) > 21 || year == (00)) {
                erro = 1;
            }

            if (erro == 1) {
                args.IsValid = false;
            }
            else
            { args.IsValid = true; }
        }

        function ValidationForChallanDateWithinFinacial(sender, args) {

            var ChallanDate = $("[id*=txtChinDate]").val();
            var ChallanDateSplit = ChallanDate.split('/');
            var financialyears = $("#ddlFinancialYear option:selected").text();
            var startfin = financialyears.split('_');
            var res = fn_DateCompare('04/01/' + startfin[0], ChallanDateSplit[1] + '/' + ChallanDateSplit[0] + '/' + ChallanDateSplit[2]);

            if ('04/01/' + startfin[0] == ChallanDateSplit[1] + '/' + ChallanDateSplit[0] + '/' + ChallanDateSplit[2])
            { res = 0; }

            //            if (res == 0) {
            args.IsValid = true;
            //            }
            //            else
            //            { args.IsValid = false; }
        }
        ////////////////////////////////////Loader and Messages//////////////////////////////////////////////////////////
        ////////////////grid loader function for set height and width of gird size to loader div

        function ClearControls() {
        }

        function ShowLoader() {

            $('.MastermodalBackground2').css("display", "block");
        }

        function hideloader() {

            $('.MastermodalBackground2').css("display", "none");
        }

        function ShowGridLoader() {
            var he = $(".gridwithloader").height();
            var wi = $(".gridwithloader").width();
            $('.gridloader').css("height", he);
            $('.gridloader').css("width", wi);
            $('.gridloader').hide();
        }
        function ErrorShow(msg) {
            $("[id*=lblAllMessage]").html(msg);
            setTimeout(function () { $('.tdMessageShow').slideDown('slow').delay(8000).slideUp('slow'); }, 500);
            $('.tdMessageShow').css('color', 'White');
            $('.tdMessageShow').css('background-color', 'red');
        }
        function SuccessShow(msg) {
            $("[id*=lblAllMessage]").html(msg);
            setTimeout(function () { $('.tdMessageShow').slideDown('slow').delay(3000).slideUp('slow'); }, 500);
            $('.tdMessageShow').css('color', '#4F8A10');
            $('.tdMessageShow').css('background-color', '#DFF2BF');
        }

    </script>
    <style type="text/css">
        .cssTextboxActual
        {
            font: normal 12px verdana, arial, "Trebuchet MS" , sans-serif;
            height: 20px;
            text-align: right;
            border-radius: 4px;
            border: 1px solid #b5b5b5;
        }
        .cssTextboxActual:focus
        {
            box-shadow: 0 0 5px rgba(81, 203, 238, 1);
            padding: 3px 0px 3px 3px;
            border: 1px solid rgba(81, 203, 238, 1);
        }
        
        .cssTextboxActual:hover
        {
            border: 1px solid rgba(81, 203, 238, 1);
        }
        .setBorderJsonTd
        {
            border: 1px solid #DBDBDB;
        }
        .gridloader
        {
            margin: auto;
            display: none;
            position: absolute;
            z-index: 9999;
            background: rgba(0,0,0,0.3) url(../Images/loader.gif) center center no-repeat;
            overflow: hidden !important;
            display: none;
            background-size: 45px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:HiddenField ID="hdnCompanyid" runat="server" />
    <asp:HiddenField ID="hdnjavascriptcheckbalues" runat="server" />
    <asp:HiddenField ID="hdnChallanID" runat="server" />
    <asp:HiddenField ID="hdnOnPagePresentVoucherIDs" runat="server" />
    <asp:HiddenField ID="hdnCheckedVoucherID" runat="server" />
    <asp:HiddenField ID="hdnOnEditVOucherJsonVlaues" runat="server" />
    <asp:HiddenField ID="hdnNatureList" runat="server" />
    <asp:HiddenField ID="hdnQuater" runat="server" />
    <asp:HiddenField ID="hdnConnString"  runat="server" />
    <div id="dialog1" title="Dialog Title" hidden="hidden">
        <table width="100%">
            <tr>
                <td>
                    <asp:Label ID="Label10" runat="server" Text="Quarter" CssClass="cssLabel"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList runat="server" ID="ddlQuaterType" Width="87px" CssClass="cssDropDownList">
                        <asp:ListItem Text="Q1">Q1</asp:ListItem>
                        <asp:ListItem Text="Q2">Q2</asp:ListItem>
                        <asp:ListItem Text="Q3">Q3</asp:ListItem>
                        <asp:ListItem Text="Q4">Q4</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlQuaterType"
                        Display="None" ErrorMessage="Please Select Quater !" InitialValue="0" ValidationGroup="ValidateNature"></asp:RequiredFieldValidator>
                </td>
                <td>
                    <asp:Label ID="Label18" runat="server" Text="Return Type" CssClass="cssLabel"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList runat="server" ID="ddlReturnType" Enabled="false" CssClass="cssDropDownList"
                        OnSelectedIndexChanged="ddlReturnType_SelectedIndexChanged" Width="80px">
                        <asp:ListItem Selected="true" Value="0" Text="( Select )"></asp:ListItem>
                        <asp:ListItem Text="26Q">26Q</asp:ListItem>
                        <asp:ListItem Text="27Q">27Q</asp:ListItem>
                        <asp:ListItem Text="27EQ">27EQ</asp:ListItem>
                        
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:Button ID="btnSubmitNatures" runat="server" CssClass="cssButton"
                        Text="Next"  ></asp:Button>
                    
                </td>
                <td>
                    <input type="button" id="JavaScriptCancel" class="cssButton" value="Cancel" />
                </td>
            </tr>
            <tr>
                <td colspan="6" style="background-color: White; margin-left: auto; margin-right: auto;">
                    <div id="emmem" style="margin-top: 0px; overflow: auto;">
                        <asp:CheckBox ID="chknaturesselectall" Visible="false" Text="Select All " runat="server" />
<%--                        <asp:CheckBoxList ID="chkNatures" runat="server" Style="background-color: Transparent;
                            border-color: Transparent; border-width: 0px; border-style: None; border-collapse: collapse;">
                        </asp:CheckBoxList>--%>
                        <table id="tblNatures" > </table>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" ShowMessageBox="true" ShowSummary="false"
        ValidationGroup="validthis" runat="server" />
    <table width="100%" style="margin-bottom: 0px;" cellpadding="0" cellspacing="0">
        <tr>
            <td class="cssPageTitle" height="5px">
                <asp:Label ID="lblHeader" runat="server" Text="Challan"></asp:Label>
                  <%--<asp:Label ID="lblHeader" runat="server" Text="Challan Entries For Non Salary"></asp:Label>--%>
            </td>
        </tr>
        <tr>
            <td>
                <div style="width: 99%; padding-right: 2px; padding-left: 2px">
                    <UC:MessageControl runat="server" ID="ucMessageControl" />
                    <div class="tdMessageShow" style="border: 1px solid; margin-top: 3px; display: none;
                        font: Tahoma; font-size: 13px; text-transform: capitalize;">
                        <table width="100%" align="center" height="30px" cellpadding="5" cellspacing="5">
                            <tr>
                                <td>
                                    <asp:Label ID="lblAllMessage" Font-Bold="true" runat="server" Text="Label"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
    </table>
    <asp:ValidationSummary ID="valsumfornature" ValidationGroup="ValidateNature" runat="server"
        ShowSummary="false" ShowMessageBox="true" />
    <asp:CustomValidator ID="CustomValidator3" Style="white-space: nowrap;" runat="server"
        ClientValidationFunction="ValidateAdjustAmount" ValidationGroup="validthis" Display="None"
        ErrorMessage="Warning : Please Check TDS, Surcharge, E Cess, HE Cess Of Actual Amount Equal To Adj(Adjust) Amount ! ***Note : If Challan Paid By Extra Amount that will be Other Amount. ! Challan can not Saved."></asp:CustomValidator>
   <table id="tblError" width="100%">
       <tr id="trmismatch" runat="server">
            <td>
                <br />
                <asp:Label runat="server" Font-Bold="true" ForeColor="red" ID="lblMismatch" Text="Kindly resolve this Voucher Errors first"></asp:Label>
                <br />
                <br />
<%--                <table id="tblMismatch"  width="100%">

                </table>--%>

            </td>
      </tr>

   </table>
    
     <table id="tblmain" runat="server" width="100%">
        <tr>
            <td valign="top" width="100%" colspan="2">
                <fieldset style="background-color: White; margin-top: 0px; margin-bottom: 0px; padding-bottom: 0px;
                    padding-top: 0px;">
                    <legend>Select TDS Deduction</legend>
                    <table width="100%">
                        <tr>
                            <td valign="top" width="100%">
                                <div id="gridwithloader" class="gridwithloader">
                                    <div class="gridloader">
                                    </div>
                                    <table width="100%">
                                        <tr id="trfilter" runat="server">
                                            <td style="font-weight:600; border:2px;">
                                                Challan Type :
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlselectedfilter" Width="90px" CssClass="cssDropDownList"
                                                    runat="server">
                                                    <asp:ListItem>Company</asp:ListItem>
                                                    <asp:ListItem>Others</asp:ListItem>
                                                    <asp:ListItem>Individual</asp:ListItem>
                                                    <asp:ListItem Selected="True">Both</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td style="font-weight:bold">
                                                &nbsp;&nbsp;&nbsp;&nbsp; From Date
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtfilterFromDate" Width="100px" CssClass="cssTextbox" runat="server"></asp:TextBox>
                                                <asp:ImageButton ID="ImageButton2" ImageUrl="~/Images/calendar.gif" runat="server"
                                                    CausesValidation="false" />
                                                <asp:CalendarExtender ID="CalendarExtender3" runat="server" PopupButtonID="ImageButton2"
                                                    TargetControlID="txtfilterFromDate" Format="dd/MM/yyyy">
                                                </asp:CalendarExtender>
                                            </td>
                                            <td style="font-weight:bold">
                                                &nbsp; To Date
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtfilterTodate" Width="100px" CssClass="cssTextbox" runat="server"></asp:TextBox>
                                                <asp:ImageButton ID="ImageButton3" ImageUrl="~/Images/calendar.gif" runat="server"
                                                    CausesValidation="false" />
                                                <asp:CalendarExtender ID="CalendarExtender4" runat="server" PopupButtonID="ImageButton3"
                                                    TargetControlID="txtfilterTodate" Format="dd/MM/yyyy">
                                                </asp:CalendarExtender>
                                            </td>
                                            <%-- <td>
                                                <input id="btnFilterDateOnSubmit" class="cssButton" type="submit" value="Search" />
                                            </td>--%>
                                            <td>
                                            </td>
                                            <td width="40%">
                                                <div style="float: right">
                                                    <%--<asp:Button ID="btnExprecd"  runat="server" CssClass="cssButton" Text="Export to Excel" OnClick="btnExprecd_Click" />--%>
                                                    <input type="submit" id="opener" class="cssButton" value="Section Selection" /></div>
                                            </td>
                                        </tr>
                                    </table>
                                    <div style="max-height: 250px; width: 100%; overflow: auto; padding-right: -15px;">
                                        <table border="0" width="100%" cellpadding="5" id="jsonTable" style="border-collapse: collapse;
                                            border-color: #BCBCBC;">
                                            <thead>
                                                <tr class="cssGridHeader" style="color: Black;">
                                                    <th style="border: 1px solid #DBDBDB; width: 10px;">
                                                        <input id="chkHeader" type="checkbox" name="chkHeader" />
                                                    </th>
                                                    <th style="border: 1px solid #DBDBDB; width: 10px;">
                                                        Pay Date
                                                    </th>
                                                    <th style="border: 1px solid #DBDBDB; width: 190px;">
                                                        Party Name
                                                    </th>
                                                  <th style="border: 1px solid #DBDBDB; width: 100px;">
                                                        PAN NO.
                                                    </th>
                                                    <th style="border: 1px solid #DBDBDB; width: 10px;">
                                                        Sec
                                                    </th>
                                                    <th style="border: 1px solid #DBDBDB; width: 10px;">
                                                        Amount<br>
                                                        Paid
                                                    </th>
                                                    <th style="border: 1px solid #DBDBDB; width: 10px;">
                                                        TDS
                                                    </th>
                                                    <th style="border: 1px solid #DBDBDB; width: 10px;">
                                                        Sur<br>
                                                        Charge
                                                    </th>
                                                    <th style="border: 1px solid #DBDBDB; width: 10px;">
                                                        ECess
                                                    </th>
                                                    <th style="border: 1px solid #DBDBDB; width: 10px;">
                                                        HCess
                                                    </th>
                                                    <th style="border: 1px solid #DBDBDB; width: 10px;">
                                                        Total<br>
                                                        TDS
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <table align="right">
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label17" runat="server"  Text="Total Tax Deposited"
                                                style="padding-right: 20px; font-weight:bold ;" ></asp:Label>
                                            <asp:TextBox runat="server" Style="direction: rtl;" ID="txtTotalTaxDeposited" Width="100px"
                                                CssClass="cssTextbox">0</asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
        <tr>
            <td valign="top" width="300px">
                <fieldset style="margin-top: 0px; padding-top: 0px;">
                    <legend>Challan Amount Details</legend>
                    <table width="100%">
                        <tr>
                            <td colspan="2" style="text-align: right;">
                                &nbsp;<asp:Label ID="Label2" runat="server" Text="Actual Amount" Font-Bold="true"
                                    CssClass="cssLabel"></asp:Label>
                            </td>
                            <td>
                                &nbsp;&nbsp;&nbsp;
                                <asp:Label ID="Label19" runat="server" Text="Adj Amount" Font-Bold="true" CssClass="cssLabel"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <hr />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label20" runat="server" Text="TDS" CssClass="cssLabel"></asp:Label>
                            </td>
                            <td style="text-align: left">
                                <asp:TextBox runat="server" Style="text-align: right;" ID="txtTDSActualAmount" Width="100px"
                                    CssClass="cssTextboxActual">0</asp:TextBox>
                            </td>
                            <td style="text-align: left">
                                <asp:TextBox runat="server" Style="text-align: right;" ID="txtTDSAdjAmount" Width="100px"
                                    CssClass="cssTextbox" Height="20px">0</asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label21" runat="server" Text="Surcharge" CssClass="cssLabel"></asp:Label>
                            </td>
                            <td style="text-align: left">
                                <asp:TextBox runat="server" Style="text-align: right;" ID="txtActualSurcharge" Width="100px"
                                    CssClass="cssTextboxActual">0</asp:TextBox>
                            </td>
                            <td style="text-align: left">
                                <asp:TextBox runat="server" Style="text-align: right;" ID="txtAdjSurcharge" Width="100px"
                                    CssClass="cssTextbox" Height="20px">0</asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label22" runat="server" Text="E Cess" CssClass="cssLabel"></asp:Label>
                            </td>
                            <td style="text-align: left">
                                <asp:TextBox runat="server" Style="text-align: right;" ID="txtActualECess" Width="100px"
                                    CssClass="cssTextboxActual">0</asp:TextBox>
                            </td>
                            <td style="text-align: left">
                                <asp:TextBox runat="server" Style="text-align: right;" ID="txtAdjECess" Width="100px"
                                    CssClass="cssTextbox" Height="20px">0</asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label23" runat="server" Text="HE Cess" CssClass="cssLabel"></asp:Label>
                            </td>
                            <td style="text-align: left">
                                <asp:TextBox runat="server" Style="text-align: right;" ID="txtActualHECess" Width="100px"
                                    CssClass="cssTextboxActual">0</asp:TextBox>
                            </td>
                            <td style="text-align: left">
                                <asp:TextBox runat="server" Style="text-align: right;" ID="txtAdjHECess" Width="100px"
                                    CssClass="cssTextbox" Height="20px">0</asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label24" runat="server" Text="Interest" CssClass="cssLabel"></asp:Label>
                            </td>
                            <td style="text-align: left">
                                <asp:TextBox runat="server" Style="text-align: right;" ID="txtActualInterest" Width="100px"
                                    CssClass="cssTextboxActual">0</asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label25" runat="server" Text="Others" CssClass="cssLabel"></asp:Label>
                            </td>
                            <td style="text-align: left">
                                <asp:TextBox runat="server" Style="text-align: right;" ID="txtActualOthers" Width="100px"
                                    CssClass="cssTextboxActual">0</asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label26" runat="server" Text="Fees" CssClass="cssLabel"></asp:Label>
                            </td>
                            <td style="text-align: left">
                                <asp:TextBox runat="server" Style="text-align: right;" ID="txtActualFees" Width="100px"
                                    CssClass="cssTextboxActual">0</asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <hr />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label27" runat="server" Text="Total Deposit" Font-Bold="true" CssClass="cssLabel"></asp:Label>
                            </td>
                            <td style="text-align: left">
                                <asp:TextBox runat="server" Style="text-align: right;" ID="txtActualDeposite" Width="100px"
                                    CssClass="cssTextbox">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:TextBox runat="server" Style="text-align: right;" ID="txtAdjDeposite" Width="100px"
                                    CssClass="cssTextbox">0</asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td style="text-align: left">
                                <asp:Label ID="Label28" runat="server" Text="Balance" Font-Bold="true" CssClass="cssLabel"></asp:Label>
                            </td>
                            <td style="text-align: left">
                                <asp:TextBox runat="server" Style="text-align: right;" ID="txtBalance" Width="100px"
                                    CssClass="cssTextbox">0</asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
            <td valign="top" width="100%">
                <fieldset style="margin-top: 0px; height: 60px;">
                    <legend>Payments for TDS/TCS Deductions</legend>
                    <table width="100%" cellpadding="3" cellspacing="3">
                        <tr>
                            <td>
                                <asp:Label ID="Label11" runat="server" Text="Quarter" CssClass="cssLabel"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="lblSelectedQuarter" Width="40px" CssClass="cssTextbox"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="lblSelectedQuarter"
                                    Display="None" ErrorMessage="Please Quarter !" ValidationGroup="validthis"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                <asp:Label ID="Label12" runat="server" Text="Return Type" CssClass="cssLabel"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="lblSelectdReturnType" Width="100px" CssClass="cssTextbox"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Label ID="Label4" runat="server" Text="Nil Challan" CssClass="cssLabel"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList runat="server" ID="ddlNilChallan" Width="50px" CssClass="cssDropDownList">
                                    <asp:ListItem Value="1" Text="Y"></asp:ListItem>
                                    <asp:ListItem Value="0" Selected="True" Text="N"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <fieldset style="height: 156px;">
                    <legend>Challan Details</legend>
                    <table width="90%">
                        <tr>
                            <td>
                                <asp:Label ID="Label5" runat="server" Text="Challan No" CssClass="cssLabel"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox runat="server" MaxLength="5" onkeypress="return isNumberKey(event)"
                                    ID="txtBankChinNo" Width="100px" CssClass="cssTextbox"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtBankChinNo"
                                    Display="None" ErrorMessage="Please Enter Challan No !" ValidationGroup="validthis"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="CustomValidator2" ValidationGroup="validthis" runat="server"
                                    ControlToValidate="txtBankChinNo" ErrorMessage="Please Enter 5 Digit Challan No !"
                                    ClientValidationFunction="ValidationCh" Display="None"></asp:CustomValidator>
                            </td>
                            <td>
                                <asp:Label ID="Label6" runat="server" Text="Challan Date" CssClass="cssLabel"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="txtChinDate" CssClass="cssTextbox" Width="100px"></asp:TextBox>
                                <asp:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtChinDate"
                                    Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" />
                                <asp:ImageButton ID="imgChinDate" ImageUrl="~/Images/calendar.gif" runat="server"
                                    CausesValidation="false" />
                                <asp:CalendarExtender ID="CalendarExtender2" runat="server" PopupButtonID="imgChinDate"
                                    TargetControlID="txtChinDate" Format="dd/MM/yyyy">
                                </asp:CalendarExtender>
                                <asp:CustomValidator ID="CustomValidator4" ValidationGroup="validthis" ControlToValidate="txtChinDate"
                                    runat="server" Display="None" ValidateEmptyText="true" ClientValidationFunction="ValidationChallanDate"
                                    ErrorMessage="Invalid Challan Date Format  !"></asp:CustomValidator>
                                <asp:CustomValidator ID="CustomValidator6" ValidationGroup="validthis" ControlToValidate="txtChinDate"
                                    runat="server" Display="None" Enabled="false" ClientValidationFunction="ValidationForChallanDateWithinFinacial"
                                    ErrorMessage="Invalid Challan Date With in Selected Financial Year Or Cheque Date Must be Equal or less than Current Date !"></asp:CustomValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label8" runat="server" Text="Cheque Number" CssClass="cssLabel"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="txtChequeNo" Width="100px" onkeypress="return isNumberKey(event)"
                                    CssClass="cssTextbox" MaxLength="6"></asp:TextBox>
                                <asp:CustomValidator ID="CustomValidator1" ValidationGroup="validthis" runat="server"
                                    ControlToValidate="txtChequeNo" ErrorMessage="Please Enter 6 Digit Cheque No !"
                                    ClientValidationFunction="ValidationChqueno" Display="None"></asp:CustomValidator>
                            </td>
                            <td>
                                <asp:Label ID="Label9" runat="server" Text="Cheque Date" CssClass="cssLabel"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="txtChaqueDate" CssClass="cssTextbox" Width="100px"></asp:TextBox>
                                <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtChaqueDate"
                                    Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" />
                                <asp:ImageButton ID="ImageButton1" ImageUrl="~/Images/calendar.gif" runat="server"
                                    CausesValidation="false" />
                                <asp:CalendarExtender ID="CalendarExtender1" runat="server" PopupButtonID="ImageButton1"
                                    TargetControlID="txtChaqueDate" Format="dd/MM/yyyy">
                                </asp:CalendarExtender>
                                <asp:CustomValidator ID="CustomValidator5" ValidationGroup="validthis" ControlToValidate="txtChaqueDate"
                                    runat="server" Display="None" ClientValidationFunction="ValidationChequeDate"
                                    ErrorMessage="Invalid Cheque Date Format !"></asp:CustomValidator>
                                <asp:CustomValidator ID="CustomValidator7" ValidationGroup="validthis" ControlToValidate="txtChaqueDate"
                                    runat="server" Display="None" ClientValidationFunction="ValidationForChequeDateWithinFinacial"
                                    ErrorMessage="Invalid Cheque Date With in Selected Financial Year Or Cheque Date Must be Equal or less than Current Date !"></asp:CustomValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label7" runat="server" Text="Bank Name" CssClass="cssLabel"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList runat="server" ID="ddlBankName" Width="280px" CssClass="cssDropDownList">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlBankName"
                                    Display="None" ErrorMessage="Please Select Bank Name !" ValidationGroup="validthis"
                                    InitialValue="0"></asp:RequiredFieldValidator>

                            </td>
                            <td>
                                <asp:Label ID="Label29" runat="server" Text="Bank Bsrcode" CssClass="cssLabel"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="txtBranch" Width="100px" CssClass="cssTextbox"></asp:TextBox>
                                <asp:CustomValidator ID="CustomValidator9" ValidationGroup="validthis" runat="server"
                                    ControlToValidate="txtBranch" ErrorMessage=" 7 Digit Bsrcode Code required !"
                                    ClientValidationFunction="ValidationBSRCODE" Display="None"></asp:CustomValidator>
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <table style="text-align: left;">
                    <tr>
                        <td>
                            <asp:CustomValidator ID="CustomValidator8" ValidationGroup="validthis" runat="server"
                                Display="None" ClientValidationFunction="ValidateGridViewCheckbox" ErrorMessage="Please Select At Least One Record From List of TDS Deduction Paid In This Challan !"></asp:CustomValidator>
                            <asp:Button runat="server" ID="btnUpdate" CssClass="cssButton" Text="Save" OnClick="btnUpdate_Click"
                                ValidationGroup="validthis" />
                            &nbsp;
                            <asp:Button runat="server" ID="btnCancel" CssClass="cssButton" Text="Cancel" OnClick="btnCancel_Click" />

                        </td>
                        <td style="color: Red; font-size: 10px;">
                            ***Note : If remove any Date then select that date and press space bar .
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
