<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="ManageTdsComputation.aspx.cs" EnableEventValidation="false"
    Inherits="Admin_TDSComputation" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc" %>
<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" href="../Styles/jquery.auto-complete.css" />
    <link href="../Scripts/jquery1.8.9-ui.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.8.2.min.js" type="text/javascript"></script>
    <style type="text/css">
        .tbl {
            border-collapse: collapse;
            background-color: #fff;
        }

            .tbl img {
                margin: -3px;
                cursor: pointer;
            }

            .tbl tbody tr td {
                background-color: inherit;
                font: normal 12px verdana, arial, "Trebuchet MS", sans-serif;
                padding: 5px;
                border: 1px solid #BCBCBC;
            }

            .tbl thead tr th {
                background: rgba(219,219,219,0.54);
                padding: 5px;
                border: 1px solid #BCBCBC;
                font: 12px verdana, arial, "Trebuchet MS", sans-serif;
                font-weight: bold;
            }

            .tbl tfoot tr th {
                background: rgba(219,219,219,0.54);
                padding: 5px;
                border: 1px solid #BCBCBC;
                font: 12px verdana, arial, "Trebuchet MS", sans-serif;
                font-weight: bold;
            }

            .tbl tbody tr th {
                background: rgba(219,219,219,0.54);
                padding: 5px;
                border: 1px solid #BCBCBC;
            }

        #tblEmployeeTDScomputation tr:nth-child(odd) {
            background-color: rgba(188,188,188,0.06);
        }

        #tblEmployeeTDScomputation tr td:nth-child(2) {
            text-align: right;
        }

        #tblEmployeeTDScomputation tr td:nth-child(4), #tblEmployeeTDScomputation tr td:nth-child(5), #tblEmployeeTDScomputation tr td:nth-child(6) {
            text-align: right;
        }

            #tblEmployeeTDScomputation tr td:nth-child(6) input[type=text] {
                padding-right: 5px;
                text-align: right;
                height: 18px;
                margin: -2px;
            }

        #tblEmployeeTDScomputation tr:nth-child(4), #tblEmployeeTDScomputation tr:nth-child(9), #tblEmployeeTDScomputation tr:nth-child(11), #tblEmployeeTDScomputation tr:nth-child(13) {
          font: 12px verdana, arial, "Trebuchet MS", sans-serif;
          font-weight: bold;

        }

        .cssButtonForSearch {
            cursor: pointer; /*background-image: url(../Images/ButtonBG1.png);*/
            background-color: White;
            border: 0px;
            padding: 4px 15px 4px 15px;
            color: Black;
            border: 1px solid #c4c5c6;
            border-radius: 3px;
            font: bold 12px verdana, arial, "Trebuchet MS", sans-serif;
            text-decoration: none;
        }

            .cssButtonForSearch:focus {
                background-color: #69b506;
                border: 1px solid #3f6b03;
                color: White;
                opacity: 0.8;
            }

            .cssButtonForSearch:hover {
                background-color: #69b506;
                border: 1px solid #3f6b03;
                color: White;
                opacity: 0.8;
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

        .spanwithno {
            float: right;
            margin-right: 5px;
        }

        .tooltip-left {
            display: none;
        }

        #txtemployeesearch {
            background: white url(../Images/Search.gif) right no-repeat;
            padding: 2px 25px 2px 15px;
            height: 18px;
            width: 330px;
            margin-bottom: -4px;
            margin-top: -4px;
        }

        .dtbl th {
            width: 120px;
            text-align: left;
        }

        .dtbl td {
            width: 400px;
        }

        .ajax__calendar {
            z-index: 9999 !important;
            top: 550 !important;
        }

        #moldal_RendDetails .cssDropDownList {
            width: 70px;
        }

        .showPanError {
            float: right;
            color: Red;
        }

        .showPanSuccess {
            float: right;
            color: Green;
        }

        .MastermodalBackground2 {
            z-index: 1999 !important;
        }

        .indicates {
            margin: 2px;
            font-weight: bold;
            text-align: right;
        }

            .indicates img {
                width: 20px;
                height: 20px;
                margin: -3px;
                padding: 0px;
            }

        .Tab .ajax__tab_header {
            color: #4682b4;
            font-family: Calibri;
            font-size: 14px;
            font-weight: bold;
            background-color: #ffffff;
            margin-left: 0px;
            cursor: pointer;
        }
        /*Body*/
        .Tab .ajax__tab_body {
            border: 1px solid #b4cbdf;
            padding-top: 0px;
            cursor: pointer;
        }
        /*Tab Active*/
        .Tab .ajax__tab_active .ajax__tab_tab {
            color: #ffffff;
            background: url("../tabb/tab_active.gif") repeat-x;
            height: 20px;
            cursor: pointer;
        }

        .Tab .ajax__tab_active .ajax__tab_inner {
            color: #ffffff;
            background: url("../tabb/tab_left_active.gif") no-repeat left;
            padding-left: 10px;
            cursor: pointer;
        }

        .Tab .ajax__tab_active .ajax__tab_outer {
            color: #ffffff;
            background: url("../tabb/tab_right_active.gif") no-repeat right;
            padding-right: 6px;
            cursor: pointer;
        }
        /*Tab Hover*/
        .Tab .ajax__tab_hover .ajax__tab_tab {
            color: #000000;
            background: url("../tabb/tab_hover.gif") repeat-x;
            height: 20px;
            cursor: pointer;
        }

        .Tab .ajax__tab_hover .ajax__tab_inner {
            color: #000000;
            background: url("../tabb/tab_left_hover.gif") no-repeat left;
            padding-left: 10px;
            cursor: pointer;
        }

        .Tab .ajax__tab_hover .ajax__tab_outer {
            color: #000000;
            background: url("../tabb/tab_right_hover.gif") no-repeat right;
            padding-right: 6px;
            cursor: pointer;
        }
        /*Tab Inactive*/
        .Tab .ajax__tab_tab {
            color: #666666;
            background: url("../tabb/tab_Inactive.gif") repeat-x;
            height: 20px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
        }

        .Tab .ajax__tab_inner {
            color: #666666;
            background: url("../tabb/tab_left_inactive.gif") no-repeat left;
            padding-left: 10px;
            cursor: pointer;
        }

        .Tab .ajax__tab_outer {
            color: #666666;
            background: url("../tabb/tab_right_inactive.gif") no-repeat right;
            padding-right: 6px;
            margin-right: 2px;
            cursor: pointer;
        }
        .odd{background-color: #9A7FD1;} 

        
    </style>

    <script type="text/javascript">
        var baseUrl = '<%=ResolveUrl("../Handler/WebServiceTDSComputation.asmx/") %>';
        var otherservice = '<%=ResolveUrl("../Service.asmx/getAllEmployees") %>';
        var companyid = 0;
        var ddlFilterList = '';
        var EmployeeJsonList = '';
        var pgindex = 1;
        var MonthIDS = [4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3];
        ///current employee details from database
        var Rfsh = '';
        var Eid_Rfsh = [];
        var Emp;
        var iRfsh = 0;
        var SurSlab = '';
        var HeathCess = 0;
        var Surcharge = 0;
        var Surcharge115 = 0;
        var HltCess = 0;
        var SurchargeType = '';
        var Rbts;
        var HRR;
        var I115 = 0;
        var Hemt = 0;

        $(document).ready(function () {
            $("[id*=tbltr]").hide();
            $("[id*=dvBtns]").hide();
            $("[id*=hdnTaxShow]").val(0);
            companyid = $("[id*=hdnCompanyID]").val();
            $("[id*=hdnConnString]").val($("[id*=ddlFinancialYear] :selected").text());
            var fy = $("[id*=hdnConnString]").val();
            var CY = 0;
            CY = fy.split('_');
            GetState();
            if (parseFloat(CY[0]) < 2020) {
                $("[id*=chkBAC]").attr("disabled", "true");
                $("[id*=divBAC]").hide();
            }
            else {
                $("[id*=divBAC]").show();
                $("[id*=chkBAC]").removeAttr('disable');
            }
            TDSCancel();
            $(document).ajaxStart(function () {
                $('.MastermodalBackground2').show();
            }).ajaxStop(function () {
                $('.MastermodalBackground2').hide();
                if (Rfsh == 'True') {
                    SaveEmployeeComputation();
                }
            });
            var Fyr = '';
            Fyr = $("[id*=ddlFinancialYear] :selected").text();
            Fyr = Fyr.substring(0, 4);
            if (parseFloat(Fyr.substring(0, 4)) > 2016) {
                getSurchargeslab();
            }
            $("#txtemployeesearch").autoComplete({
                minChars: 0,
                source: function (term, suggest) {

                    if (EmployeeJsonList == '')
                        ServerServiceToGetData("{Comp:" + $("[id*=hdnCompanyID]").val() + "}", otherservice, 'false', getEmployeeJsonListSuccess);

                    term = term.toLowerCase();
                    var choices = EmployeeJsonList;
                    var suggestions = [];
                    for (i = 0; i < choices.length; i++)
                        if (~(choices[i].EmpName).toLowerCase().indexOf(term)) suggestions.push(choices[i]);
                    suggest(suggestions);
                },
                renderItem: function (item, search) {
                    search = search.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
                    var re = new RegExp("(" + search.split(' ').join('|') + ")", "gi");
                    return '<div class="autocomplete-suggestion" data-langname="' + item.EmpName + '" style="text-transform: capitalize;" data-lang="' + item.Employee_ID + '" data-val="' + search + '">' + item.EmpName.replace(re, "<b>$1</b>") + '</div>';
                },
                onSelect: function (e, term, item) {
                    //console.log('Item "' + item.data('langname') + ' (' + item.data('lang') + ')" selected by ' + (e.type == 'keydown' ? 'pressing enter or tab' : 'mouse click') + '.');
                    $("#txtemployeesearch").val(item.data('langname').toUpperCase());
                    goforComputatioin(item.data('lang'));
                }
            });

            $("#txtemployeesearch").blur(function () {
                if ($(this).val() == '')
                { $(this).val(Emp.FirstName.toUpperCase()); }
            });
            //$("[id*=txtHrr]").keyup(function (e) {
            //    if (e.which == 13) {
            //        $("input[name=txtHrr]").each(function () {
            //            var row = $(this).closest("tr");
            //            rIndex = row.closest('tr').index();
            //            if (rIndex == currentRowno + 1) {
            //                row.find('td:eq(3)').html($(this).val());
            //                return false;
            //            }
            //        });
            //    }
            //});
     
            $("[id*=chkNrl]").change(function () {
                var i = $(this);
                var Emply = '';
                var chkprop = i.is(':checked');
                Emply = Emp.Employee_ID;
                if (chkprop) {
                    $("[id*=chkBAC]").removeAttr('checked');
                    Emply = '';
                    I115 = 0;
                    tblColor();

                }
                else {
                    I115 = 1;
                    //SetZero_i115BAC();
                    //disable_I115Bac();
                    tblColor();          
                }
            });

            $("[id*=chkBAC]").change(function () {
                var i = $(this);
                var Emply = '';
                var chkprop = i.is(':checked');
                if (chkprop) {
                    $("[id*=chkNrl]").removeAttr('checked');
                    Emply = 'I115';
                    I115 = 1;
                    //SetZero_i115BAC();
                    //disable_I115Bac();
                    tblColor();

                }
                else {

                    Emply = Emp.Employee_ID;
                    I115 = 0;
                    //enable_I115Bac();
                    tblColor();
                }
                //// getIncomeTAX115
                //Company_ID = $("[id*=hdnCompanyID]").val();
                //Conn = $("[id*=hdnConnString]").val();
                //$.ajax({
                //    type: "POST",
                //    url: "../Handler/WebServiceTDSComputation.asmx/getIncomeTAX115",
                //    data: '{Company_ID:' + Company_ID + ', Emp: "' + Emply + '", Conn: "' + Conn + '"}',
                //    dataType: 'json',
                //    contentType: "application/json; charset=utf-8",
                //    success: function (msg) {
                //        var myList = jQuery.parseJSON(msg.d);
                //        for (var i = 0; i < 6; i++) {
                //            var slabperName = 'lblSlabPer' + (i + 1);
                //            var slabName = 'lblSlab' + (i + 1);
                //            $('[id*=' + slabperName + ']').html(0);
                //            $('[id*=' + slabName + ']').html(0);
                //        }
                //        if (parseFloat(myList.length) > 0) {
                //            $.each(myList, function (j, va) {
                //                var slabperName = 'lblSlabPer' + (j + 1);
                //                var slabName = 'lblSlab' + (j + 1);

                //                $('[id*=' + slabperName + ']').html(va.Slab);
                //                $('[id*=' + slabName + ']').html(va.Tax_Amount);
                //            });
                //        }
                //        TDSComputationFronTableCalculation();
                //    },
                //    failure: function (response) {
                //        alert('Cant Connect to Server' + response.d);
                //    },
                //    error: function (response) {
                //        alert('Error Occoured ' + response.d);
                //    }
                //});

            });


            GetAllEmployeeComputionSummary();
            /////////////////// Updating Rebate Limits
            var RebateLimits = jQuery.parseJSON($("[id*=hdnAllRebateLimits]").val());
            $.each(RebateLimits, function (i, va) {
                var conntrolname = '#txt' + va.Rebate_Name;
                console.log(conntrolname);
                $(conntrolname).attr("data-limit", va.Rebate_Limit);
                if (conntrolname == "#txtRebate80G") {
                    conntrolname = conntrolname + '_Qlfy';
                    $("[id*=txtRebate80G_Qlfy]").val(va.Rebate_Limit);
                }
                if (conntrolname == "#txtRebate80GG") {
                    conntrolname = conntrolname + '_Qlfy';
                    $("[id*=txtRebate80GG_Qlfy]").val(va.Rebate_Limit);
                }
                if (conntrolname == "#txtRebate80GGA") {
                    conntrolname = conntrolname + '_Qlfy';
                    $("[id*=txtRebate80GA_Qlfy]").val(va.Rebate_Limit);
                }
                if (conntrolname == "#txtRebate80GGC") {
                    conntrolname = conntrolname + '_Qlfy';
                    $("[id*=txtRebate80GGC_Qlfy]").val(va.Rebate_Limit);
                }
                if (conntrolname == "#txtRebate80RRB") {
                    conntrolname = conntrolname + '_Qlfy';
                    $("[id*=txtRebate80RRB_Qlfy]").val(va.Rebate_Limit);
                }
                if (conntrolname == "#txtRebate80U") {
                    conntrolname = conntrolname + '_Qlfy';
                    $("[id*=txtRebate80U]").val(va.Rebate_Limit);
                }
                if (conntrolname == "#txtRebate80CCG") {
                    conntrolname = conntrolname + '_Qlfy';
                    $("[id*=txtRebate80CCG_Qlfy]").val(va.Rebate_Limit);
                }
                if (conntrolname == "#txtRebate80TTA") {
                    conntrolname = conntrolname + '_Qlfy';
                    $("[id*=txtRebate80TTA_Qlfy]").val(va.Rebate_Limit);
                }
            });
            $(".txtRentInt").keyup(function (e) {
                var txtQty = $(this).val().replace(/[^0-9\.]/g, '');
                if (txtQty == '')
                { txtQty = '0'; }
                $(this).val(txtQty);
                return false;
            });
            $(".Rblur").blur(function () {
                var nn = this;
                var j = nn.id;
                var d = j + '_Ded';
                //if (j == 'txtRebate80CCD2') {

                //}
                //else {
                //    if (I115 == 1) {
                //        alert('Rebates are not applicable in New Tax Regime I115BAC');
                //        return;
                //    }
                //}
                var a = 0;
                a = $("[id*=" + d + "]").val();
                if (a == 0) {
                    $("[id*=" + d + "]").val(nn.value);

                }
                else if (a > nn.value) {
                    $("[id*=" + d + "]").val(nn.value);
                }
                else {
                    var ii = 0;
                    ii = nn.value;
                    if (a > ii) {
                        $("[id*=" + d + "]").val(nn.value);
                    }
                }
                setNumericFormat();

            });

            $(".Rblur_ded").blur(function () {
                var nn = this;
                var j = nn.id;
                var a = 0;
                var b = 0;
                //if (j == 'txtRebate80C_Ded') {
                //a = nn.value;
                //b = $("#txtPFSubTotal").text();
                //$("[id*=txtRebate80C]").val();
                //if (parseFloat(a) > parseFloat(b)) {
                //    $("[id*=" + j + "]").val(0);
                //    alert(j + " Deduction Cannot be greater than Investment " + j);
                //}
                //}
                //else
                //{
                //var d = j.split('_Ded');
                //a = nn.value;
                //d = d[0];
                //b = $("[id*=" + d + "]").val();
                //if (parseFloat(a) > parseFloat(b)) {
                //    $("[id*=" + j + "]").val(0);
                //    alert(j + " Deduction Cannot be greater than Investment " + j);
                //}
                // }


            });

            $(".cssDropDownList").change(function () {
                cssDropDownListToggleClass();
            });

            $("#RefreshAll").click(function () {
                var i = 0;
                Rfsh = 'True';
                $('#tblComputationSummary > tbody  > tr').each(function () {
                    var row = $(this).closest("tr");
                    var e = row.find("input[name=hdnEmp_ID]").val();
                    if (e == undefined) {
                    }
                    else {
                        Eid_Rfsh[i] = e;
                        i = i + 1;
                    }
                });

                goforComputatioin(Eid_Rfsh[0]);
            });

            $("#chkSurcharge").click(function () {
                TDSComputationFronTableCalculation();
            });




            ////////pan no validation
            $(".cssTextbox").blur(function () {
                var finds = $(this).closest("tr").find(".showPanError");
                if (finds != "" && finds != null && finds != undefined)
                    ValidateAllPANNo($(this));
            });
            $("input[type=text]").keydown(function () {
                var a = $('.MastermodalBackground2').css('display');

                if (a == "block")
                    return false;
            });



            $("[id*=txtRebate80C]").keyup(function (e) {
                AllTextBoxCal();
            });

            $("[id*=txtRebate80CCC]").keyup(function (e) {
                AllTextBoxCal();
            });
            $("[id*=txtReb80CCD]").keyup(function (e) {
                AllTextBoxCal();
            });
            $("[id*=txtRebate80CCD21b]").keyup(function (e) {
                AllTextBoxCal();
            });
            $("[id*=txtRebate80CCD2]").keyup(function (e) {
                AllTextBoxCal();
            });


            //$("[id*=chkHRA]").click(function () {
            //    if ($("#chkHRA").is(':checked')) {
            //        $("[id*=TxtManualHra]").show();
            //    }
            //    else
            //    {
            //        $("[id*=TxtManualHra]").hide();
            //    }
            //});
            //$("[id*=TxtManualHra]").blur(function () {
            //    var h = parseFloat($("[id*=TxtManualHra]").val());
            //    if (h != NaN) {
            //    var Amt = 0;
            //        $("#tblSectionten tbody tr").each(function () {
            //            var row = $(this).closest("tr");
            //            var spn =  $(".sectiontenAmountPerheadid", row).text();
            //            var lbl = row.find('td:eq(1)').html();
            //            if (lbl == 'HRA') {
            //                $(".sectiontenAmountPerheadid", row).text(h);
            //                spn = h;
            //            }
            //            Amt = Amt + parseFloat(spn);
            //        });
            //        $(".getTotalCal4").text(Amt);
            //        AllTextBoxCal();
            //    }
            //});

            /************************Computation Events******************************/
        });

        //function txtRebate80C_keyup(event) {
        //    var C = $(".txtRebate80C").val();
        //    $("#txtRebate80C_Ded").val(C);
        //}

        function getEmployeeJsonListSuccess(data) {
            EmployeeJsonList = jQuery.parseJSON(data.d);
        }

        function plusClick(i) {
            var src = i.attr('src'); // "static/images/banner/blue.jpg"
            var tarr = src.split('/');      // ["static","images","banner","blue.jpg"]
            var file = tarr[tarr.length - 1]; // "blue.jpg"
            var data = file.split('.')[0];  // "blue"
            if (data == "plus") {
                i.closest("tr").after("<tr><td style='border-color:#DBDBDB;'></td><td colspan = '999' style='border-color:#DBDBDB;'>" + i.next().html() + "</td></tr>");
                //                    $(this).closest("tr").after("<tr><td></td><td colspan = '999'>"+$(this).next().html()+"</td></tr>")
                i.attr("src", "../Images/minus.png");
            }
            else {
                i.attr("src", "../Images/plus.png");
                i.closest("tr").next().remove();
            }
        }

        function btnTDSSummarySearchClick()
        { pgindex = 1; GetAllEmployeeComputionSummary(); return false; }

        function GetAllEmployeeComputionSummary() {
            var tobj = {
                CompanyID: companyid,
                PageIndex: pgindex,
                PageSize: $('[id*=ddlperpage]').val(),
                SearchVal: $('#txtTdsSummarysearch').val(),
                ConnectionString: $("[id*=hdnConnString]").val(),
                FilterById: (($('[id*=ddlsearch]').val() == '' || $('[id*=ddlsearch]').val() == undefined || $('[id*=ddlsearch]').val() == null) ? '0' : $('[id*=ddlsearch]').val())
            };
            tobj = JSON.stringify({ 'tobj': tobj });

            ServerServiceToGetData(tobj, baseUrl + 'GetAllEmployeeComputionSummary', 'false', GetAllEmployeeComputionSummarysuccess);
        }


        function GetAllEmployeeComputionSummarysuccess(response) {
            var tblAllEmpComputationGrid = jQuery.parseJSON(response.d);
            var rows = '';
            var RecordCount = 0;
            $.each(tblAllEmpComputationGrid, function (i, v) {
                /////challan Summary
                var tblChallan = v.ChallanSummary;
                var tblChallanHtml = '';
                ///header
                tblChallanHtml += "<tr>";
                tblChallanHtml += "<th>#</th>";
                tblChallanHtml += "<th>Quarter</th>";
                tblChallanHtml += "<th>Challan NO</th>";
                tblChallanHtml += "<th>Challan Date</th>";
                tblChallanHtml += "<th>TDS Deduction Date</th>";
                tblChallanHtml += "<th>Salary</th>";
                tblChallanHtml += "<th>TDS Amount</th>";
                tblChallanHtml += "<th>Surcharge Amount</th>";
                tblChallanHtml += "<th>EducationCess Amount</th>";
                tblChallanHtml += "<th>High Education Cess Amount</th>";
                tblChallanHtml += "<th>Total TDS Amount</th>";
                tblChallanHtml += "</tr>";

                $.each(tblChallan, function (i, c) {
                    tblChallanHtml += "<tr>";
                    tblChallanHtml += "<td style='text-align:right;'>" + (i + 1) + "</td>";
                    tblChallanHtml += "<td width='10%'>" + c.Quater + "</td>";
                    tblChallanHtml += "<td width='10%' style='text-align:right;'>" + c.Challan_NO + "</td>";
                    tblChallanHtml += "<td width='10%' style='text-align:center;'>" + c.Challan_Date + "</td>";
                    tblChallanHtml += "<td width='10%' style='text-align:center;'>" + c.TDS_Deduction_Date + "</td>";
                    tblChallanHtml += "<td width='10%' class='frontMakeFormat' style='text-align:right;'>" + c.Employee_Salary + "</td>";
                    tblChallanHtml += "<td width='10%' class='frontMakeFormat' style='text-align:right;'>" + c.TDS_Amount + "</td>";
                    tblChallanHtml += "<td width='10%' class='frontMakeFormat' style='text-align:right;'>" + c.Surcharge_Amount + "</td>";
                    tblChallanHtml += "<td width='10%' class='frontMakeFormat' style='text-align:right;'>" + c.EducationCess_Amount + "</td>";
                    tblChallanHtml += "<td width='10%' class='frontMakeFormat' style='text-align:right;'>" + c.High_EductionCess_Amount + "</td>";
                    tblChallanHtml += "<td width='10%' class='frontMakeFormat' style='text-align:right;'>" + c.Total_TDS_Amount + "</td>";
                    tblChallanHtml += "</tr>";
                });

                if (tblChallan.length == 0)
                { tblChallanHtml += "<tr><td colspan='15'><center><b>No Records found</b></center></td></tr>"; }

                var ReasonforShortDeduction = '';
                if (v.SumofSalary > v.GrossEarn1)
                { ReasonforShortDeduction = '<span style="color:red; font-weight:bold;">Reason for Short Deduction : Sum of Salary Amount(<span class="frontMakeFormat">' + v.SumofSalary + '</span>) shown in challan is more than Gross Salary Amount(<span class="frontMakeFormat">' + v.GrossEarn1 + '</span>) in Computation !</span>'; }

                tblChallanHtml = '<div style="display:none;">' + ReasonforShortDeduction + '<table class="tbl" width="100%" cellpadding="0" cellspacing="0">' + tblChallanHtml + '</table></div>';


                ////tds summary
                if (ReasonforShortDeduction != '')
                { ReasonforShortDeduction = ''; }
                rows += "<tr>";
                if (tblChallan.length == 0)
                    rows += "<td></td>";
                else
                    rows += "<td" + ReasonforShortDeduction + "><img src='../Images/plus.png' onclick='plusClick($(this))'>" + tblChallanHtml + "</td>";
                if (ReasonforShortDeduction != '')
                { ReasonforShortDeduction = ' color:red; '; }
                rows += "<td style='" + ReasonforShortDeduction + " text-align:right; '>" + v.RowNumber + "</td>";
                rows += "<td style='" + ReasonforShortDeduction + "  text-transform:Capitalize;'><input id='hdnEmp_ID' name='hdnEmp_ID' type='hidden' value='" + v.Employee_ID + "' /><span style='text-transform: Capitalize;'>" + v.FirstName.toLocaleString().toLowerCase() + "</span></td>";
                rows += "<td class='frontMakeFormat' style='" + ReasonforShortDeduction + "  text-align:right;'>" + v.GrossEarn1 + "</td>";
                rows += "<td class='frontMakeFormat' style='" + ReasonforShortDeduction + " text-align:right;'>" + v.TotalRebate + "</td>";
                rows += "<td class='frontMakeFormat' style='" + ReasonforShortDeduction + "  text-align:right;'>" + v.Grossnet + "</td>";
                rows += "<td class='frontMakeFormat' style='" + ReasonforShortDeduction + " text-align:right;'>" + v.Itax1 + "</td>";
                rows += "<td class='frontMakeFormat' style='" + ReasonforShortDeduction + " text-align:right;'>" + v.PreTds + "</td>";
                rows += "<td class='frontMakeFormat' style='" + ReasonforShortDeduction + " text-align:right;'>" + v.FinalTax + "</td>";
                rows += "<td><a title='Click for TDS Computation'><img src='../Images/Computation.png' alt='TDS Computation' onclick='goforComputatioin(" + v.Employee_ID + ")' style='cursor:pointer; height:30px; width:25px;'></a></td>";
                rows += "<td><a title='Click for Rent Details'><img src='../Images/Rent_Home-512.png' alt='TDS Computation' onclick='getEmployeeRentDetails(" + v.Employee_ID + ")' style='cursor:pointer; height:30px; width:25px;'></a></td>";
                rows += "<td><a title='Click for Form 16 part B'><img src='../Images/form.png' alt='TDS Computation' onclick='getEmployeeFormsixteen(" + v.Employee_ID + ")' style='cursor:pointer; height:30px; width:25px;'></a></td>";
                rows += "</tr>";
                RecordCount = v.RecordCount;
                if (ddlFilterList == '') {
                    $('[id*=ddlsearch] option').remove();
                    ddlFilterList = v.FilterList;
                    $.each(ddlFilterList, function (i, b) {
                        var seleted = ''
                        if (b.FilterById == '6')
                        { seleted = ' selected="true" ' }
                        $('[id*=ddlsearch]').append('<option ' + seleted + ' value=' + b.FilterById + '>' + b.FilterByVal + '</option>');
                    });
                }
            });

            $(".Pager").ASPSnippets_Pager({
                ActiveCssClass: "current",
                PagerCssClass: "pager",
                PageIndex: parseInt(pgindex),
                PageSize: parseInt($('[id*=ddlperpage]').val()),
                RecordCount: parseInt(RecordCount)
            });
            if ($(".Pager").is(':empty')) {
                if (RecordCount > 0) {
                    $(".Pager").append('<b>Records 1 - ' + RecordCount + ' of ' + RecordCount + '</b>');
                }
                else { $(".Pager").append('<b>Records 0</b>'); }
            }
            $("[id*=tblComputationSummary] tr").not($("[id*=tblComputationSummary] tr:first-child")).remove();
            if (RecordCount > 0) {
                $("[id*=tblComputationSummary]").append(rows);
            }
            else { $("[id*=tblComputationSummary]").append("<tr><td colspan='15'><center><b>No Records found</b></center></td></tr>"); }

            ////initialise events
            $(".Pager .page").on("click", function () {
                pgindex = (parseInt($(this).attr('page')));
                GetAllEmployeeComputionSummary();
            });

            makeFrontFormat();
        }



        function ServerServiceToGetData(data, url, torf, successFun) {
            $.ajax({
                url: url,
                data: data,
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: successFun,
                error: function (response) {
                    alert(response.responseText);
                },
                failure: function (response) {
                    alert(response.responseText);
                }
            });
        }
        function capitalize(s) {
            return s && s[0].toUpperCase() + s.slice(1);
        }

        function showRendDialog() {
            $('html').css('overflow', 'hidden');
            var EmployeeName = '';
            if (RentEmp != null)
            { EmployeeName = RentEmp.FirstName.toLowerCase(); }
            $("#moldal_RendDetails").dialog({
                title: "Rent Details OF " + capitalize(EmployeeName),
                show: { effect: "fade", duration: 500 },
                draggable: false,
                closeOnEscape: true,
                modal: true,
                resizable: false,
                width: 890,
                height: 600,
                beforeClose: function (event, ui) {
                    $('html').css('overflow', 'scroll');
                },
                buttons: {
                    Save: function () {
                        if (!ValidatoinCount())
                        { return false; }
                        else {
                            $(this).dialog("close");
                            SaveEmployeeRentDetails();
                        }
                    },
                    Close: function () {
                        $(this).dialog("close");
                    }
                }
            });
        }
	
        function SaveEmployeeRentDetails() {
            if (!ValidatoinCount())
            { return false; }

            var fromdate = $("[id*=Frm_DT_superannuation_fund]").val();
            var todate = $("[id*=TO_DT_superannuation_fund]").val();
            if (fromdate != '')
            { fromdate = new Date(fromdate.split('/')[2], parseFloat(fromdate.split('/')[1]) - 1, fromdate.split('/')[0]); }
            if (todate != '')
            { todate = new Date(todate.split('/')[2], parseFloat(todate.split('/')[1]) - 1, todate.split('/')[0]); }

            var tobj = {
                Company_ID: companyid,
                Employee_ID: RentEmp.Employee_ID,
                ConnectionString: $("[id*=hdnConnString]").val(),
                Rent_Payment: $("[id*=Rent_Payment]").val(),
                PAN_landlord1: $("[id*=PAN_landlord1]").val(),
                Name_landlord1: $("[id*=Name_landlord1]").val(),
                PAN_landlord2: $("[id*=PAN_landlord2]").val(),
                Name_landlord2: $("[id*=Name_landlord2]").val(),
                PAN_landlord3: $("[id*=PAN_landlord3]").val(),
                Name_landlord3: $("[id*=Name_landlord3]").val(),
                PAN_landlord4: $("[id*=PAN_landlord4]").val(),
                Name_landlord4: $("[id*=Name_landlord4]").val(),
                Interest_lender: $("[id*=Interest_lender]").val(),
                PAN_lender1: $("[id*=PAN_lender1]").val(),
                Name_lender1: $("[id*=Name_lender1]").val(),
                PAN_lender2: $("[id*=PAN_lender2]").val(),
                Name_lender2: $("[id*=Name_lender2]").val(),
                PAN_lender3: $("[id*=PAN_lender3]").val(),
                Name_lender3: $("[id*=Name_lender3]").val(),
                PAN_lender4: $("[id*=PAN_lender4]").val(),
                Name_lender4: $("[id*=Name_lender4]").val(),
                Contributions_superannuation_fund: $("[id*=Contributions_superannuation_fund]").val(),
                Name_superannuation_fund: $("[id*=Name_superannuation_fund]").val(),
                Frm_DT_superannuation_fund: fromdate,
                TO_DT_superannuation_fund: todate,
                principal_interest_superannuation_fund: $("[id*=principal_interest_superannuation_fund]").val(),
                Rate_deduction_tax_3yrs: $("[id*=Rate_deduction_tax_3yrs]").val(),
                Repayment_superannuation_fund: $("[id*=Repayment_superannuation_fund]").val(),
                Total_Income_superannuation_fund: $("[id*=Total_Income_superannuation_fund]").val()
            };
            tobj = JSON.stringify({ 'tobj': tobj });

            ServerServiceToGetData(tobj, baseUrl + 'setEmployeeRentDetails', 'false', SuccessofEmployeeRentDetails);
        }	
		
        function GetState() {


            var compid = $("[id*=hdnCompanyID]").val();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ManageTdsComputation.aspx/Get_State",
                data: '{compid:' + compid + '}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    if (myList.length > 0) {
                        for (var i = 0; i < myList.length; i++) {

                            //$("[id*=drpState]").append("<option value='" + myDrps[i].deducteeid + "'>" + myDrps[i].Dname + "</option>");
                            $("[id*=drpState]").append("<option value='" + myList[i].State_Id + "'>" + myList[i].StateName + "</option>");

                        }
                    }
                    //  hideloader();
                },
                failure: function (response) {

                },
                error: function (response) {

                }
            });
        }

        function getSurchargeslab() {
            ServerServiceToGetData("{Company_ID:" + $("[id*=hdnCompanyID]").val() + ",Conn:'" + $("[id*=hdnConnString]").val() + "'}", baseUrl + 'getSurchargeSlab', 'false', SuccessForGetSurchargeSlab);
        }

        function SuccessForGetSurchargeSlab(data) {
            SurSlab = jQuery.parseJSON(data.d);
        }

        function getEmployeeRentDetails(EmpID) {
            $("#moldal_RendDetails input[type=text]").each(function () {
                $(this).val('');
            });
            $("#moldal_RendDetails select").each(function () {
                $(this).val('false');
            });
            $(".txtRentInt").each(function () { $(this).val('0'); });

            $(".showPanSuccess").each(function () { $(this).html(''); });
            $(".showPanError").each(function () { $(this).html(''); });

            ServerServiceToGetData("{Emplolyee_ID:" + EmpID + ",Company_ID:" + $("[id*=hdnCompanyID]").val() + ",Conn:'" + $("[id*=hdnConnString]").val() + "'}", baseUrl + 'getEmployeeRentDetails', 'false', SuccessForGetEmployeeRentDetails);
        }

        var RentEmp;
        function SuccessForGetEmployeeRentDetails(data) {
            RentEmp = jQuery.parseJSON(data.d);
            RentEmp = RentEmp[0];
            //    Rent_Payment bool
            setValuesoflabelTextSpan('Rent_Payment', RentEmp.Rent_Payment.toString(), null, null);

            //    Count_PAN_landlord
            //    PAN_landlord1
            setValuesoflabelTextSpan('PAN_landlord1', RentEmp.PAN_landlord1, null, null);
            //    Name_landlord1
            setValuesoflabelTextSpan('Name_landlord1', RentEmp.Name_landlord1, null, null);
            //    PAN_landlord2
            setValuesoflabelTextSpan('PAN_landlord2', RentEmp.PAN_landlord2, null, null);
            //    Name_landlord2
            setValuesoflabelTextSpan('Name_landlord2', RentEmp.Name_landlord2, null, null);
            //    PAN_landlord3
            setValuesoflabelTextSpan('PAN_landlord3', RentEmp.PAN_landlord3, null, null);
            //    Name_landlord3
            setValuesoflabelTextSpan('Name_landlord3', RentEmp.Name_landlord3, null, null);
            //    PAN_landlord4
            setValuesoflabelTextSpan('PAN_landlord4', RentEmp.PAN_landlord4, null, null);
            //    Name_landlord4
            setValuesoflabelTextSpan('Name_landlord4', RentEmp.Name_landlord4, null, null);
            //    Interest_lender bool
            setValuesoflabelTextSpan('Interest_lender', RentEmp.Interest_lender.toString(), null, null);
            //    Count_PAN_lender
            //    PAN_lender1
            setValuesoflabelTextSpan('PAN_lender1', RentEmp.PAN_lender1, null, null);
            //    Name_lender1
            setValuesoflabelTextSpan('Name_lender1', RentEmp.Name_lender1, null, null);
            //    PAN_lender2
            setValuesoflabelTextSpan('PAN_lender2', RentEmp.PAN_lender2, null, null);
            //    Name_lender2
            setValuesoflabelTextSpan('Name_lender2', RentEmp.Name_lender2, null, null);
            //    PAN_lender3
            setValuesoflabelTextSpan('PAN_lender3', RentEmp.PAN_lender3, null, null);
            //    Name_lender3
            setValuesoflabelTextSpan('Name_lender3', RentEmp.Name_lender3, null, null);
            //    PAN_lender4
            setValuesoflabelTextSpan('PAN_lender4', RentEmp.PAN_lender4, null, null);
            //    Name_lender4
            setValuesoflabelTextSpan('Name_lender4', RentEmp.Name_lender4, null, null);
            //    Contributions_superannuation_fund bit
            setValuesoflabelTextSpan('Contributions_superannuation_fund', RentEmp.Contributions_superannuation_fund.toString(), null, null);
            //    Name_superannuation_fund
            setValuesoflabelTextSpan('Name_superannuation_fund', RentEmp.Name_superannuation_fund, null, null);
            //    Frm_DT_superannuation_fund
            setValuesoflabelTextSpan('Frm_DT_superannuation_fund', RentEmp.Frm_DT_superannuation_fund_string, null, null);
            //    TO_DT_superannuation_fund
            setValuesoflabelTextSpan('TO_DT_superannuation_fund', RentEmp.TO_DT_superannuation_fund_string, null, null);
            //    principal_interest_superannuation_fund
            setValuesoflabelTextSpan('principal_interest_superannuation_fund', RentEmp.principal_interest_superannuation_fund, null, null);
            //    Rate_deduction_tax_3yrs
            setValuesoflabelTextSpan('Rate_deduction_tax_3yrs', RentEmp.Rate_deduction_tax_3yrs, null, null);
            //    Repayment_superannuation_fund
            setValuesoflabelTextSpan('Repayment_superannuation_fund', RentEmp.Repayment_superannuation_fund, null, null);
            //    Total_Income_superannuation_fund
            setValuesoflabelTextSpan('Total_Income_superannuation_fund', RentEmp.Total_Income_superannuation_fund, null, null);

            cssDropDownListToggleClass();
            showRendDialog();
        }

        function ValidateAllPANNo(txtObj) {
            var AllPans = [];
            //    $(".showPanError").each(function () { $(this).html(''); });
            //    $(".showPanSuccess").each(function () { $(this).html(''); });

            //    $(".showPanError").each(function () {
            //        var textBox = $("input[type=text]", $(this).closest("tr"));
            //        if (textBox.val() != '') {
            //            var CurrItem = {};
            //            CurrItem["textBoxID"] = textBox.attr("id");
            //            CurrItem["PANNO"] = textBox.val();
            //            CurrItem["PANStatus"] = "";
            //            AllPans.push(CurrItem);
            //        }
            //    });

            if (($(".showPanSuccess", txtObj.closest("tr")).html() != ''))
            { return false; }

            if (txtObj.val() == '')
            { $(".showPanSuccess", txtObj.closest("tr")).html(""); $(".showPanError", txtObj.closest("tr")).html(""); return false; }

            if (txtObj.val().length != 10)
            { $(".showPanError", txtObj.closest("tr")).html("Invalid PAN"); return false; }

            var CurrItem = {};
            CurrItem["textBoxID"] = txtObj.attr("id");
            CurrItem["PANNO"] = txtObj.val();
            CurrItem["PANStatus"] = "";

            AllPans.push(CurrItem);

            tobj = JSON.stringify({ 'tobj': AllPans });

            ServerServiceToGetData(tobj, baseUrl + 'PANValidation', 'false', SuccessOFPanValidation);
        }

        function SuccessOFPanValidation(data) {
            var AllPans = jQuery.parseJSON(data.d);
            $.each(AllPans, function (i, va) {
                if (va.PANStatus == "Valid PAN")
                    $(".showPanSuccess", $("#" + va.textBoxID).closest("tr")).html(va.PANStatus);
                else
                    $(".showPanError", $("#" + va.textBoxID).closest("tr")).html(va.PANStatus);
            });
        }

        function ValidatoinCount() {
            var countInvalidPan = 0;
            $(".showPanError").each(function () {
                if ($(this).html() != "")
                { countInvalidPan += 1; }
            });
            if (countInvalidPan > 0)
            { alert('Please Enter Valid PAN'); return false; }

            return true;
        }

        function SuccessofEmployeeRentDetails(data) {
            if (data.d > 0)
            { showSuccess('Saved successfully.'); }
            else
            { showError('Error while saving.......'); }
        }

        function cssDropDownListToggleClass() {
            $(".cssDropDownList").each(function () {
                var clName = $(this).data('hideclass');
                if (clName != "" && clName != undefined && clName != null) {
                    if ($(this).val() == 'true')
                    { $("." + clName).each(function () { $(this).show(); }); }
                    else { $("." + clName).each(function () { $(this).hide(); }); }
                }
            });
        }

        function TDSCancel() {
            $('#divEmployeeComputationSummary').show();
            $('#divEmployeeComputation').hide();
            $('#txtemployeesearch').hide();
            $("[id*=dvBtns]").hide();
        }

        function makeFrontFormat() {
            $(".frontMakeFormat").each(function () {
                $(this).html(AddComma($(this).html()));
            });
        }

        /**************open modal pupup screens*****************/
        function ShowModalPopups(titleName) {
            $('html').css('overflow', 'hidden');
            titleName = '#' + titleName;
            //if (I115 == 1 && titleName == '#modal_dialog_Reates') {
            //    alert('Rebates are not applicable in New Tax Regime I115BAC')
            //}
            //else {
                $(titleName).dialog({
                    title: $(titleName).data('modalheader'),
                    show: { effect: "fade", duration: 500 },
                    draggable: false,
                    beforeClose: function (event, ui) {
                        var isDialogopen = 0;
                        $(":ui-dialog").each(function () {
                            var $dialog = $(this);
                            if ($dialog.dialog('isOpen')) {
                                isDialogopen += 1;
                            };
                        });
                        if (isDialogopen == 1)
                            $('html').css('overflow', 'scroll');
                    },
                    closeOnEscape: true,
                    modal: true,
                    resizable: false,
                    width: $(titleName).data('width'),
                    height: $(titleName).data('height')
                });
            //}
        }

        function HideModalPopups(titleName) {
            $('html').css('hidden');
            titleName = '#' + titleName;
            $(titleName).dialog({
                title: $(titleName).data('modalheader'),
                hide: { effect: "fade", duration: 500 },
                closeOnEscape: true,
                modal: false,
                resizable: false

            });
        }
        function convertDate(inputFormat) {
            function pad(s) { return (s < 10) ? '0' + s : s; }
            var d = new Date(inputFormat);
            return [pad(d.getDate()), pad(d.getMonth() + 1), d.getFullYear()].join('/');
        }

        function setValuesoflabelTextSpan(nameOfcontrol, controlvalue, datakeyname, datakeyvalue) {
            nameOfcontrol = '#' + nameOfcontrol;
            var currobj = $(nameOfcontrol);
            if (currobj.length > 0) {
                if (currobj[0].nodeName == 'SPAN')
                { currobj.text(controlvalue); }
                if (currobj[0].nodeName == 'INPUT')
                { currobj.val(controlvalue); }
                if (currobj[0].nodeName == 'SELECT')
                { currobj.val(controlvalue); }
            }
        }
        function SetControlsEmpty() {
            setValuesoflabelTextSpan('txtSection80CVariousInvestments', 0, null, null);
            setValuesoflabelTextSpan('txtRebate80C', 0, null, null);
            setValuesoflabelTextSpan('txtRebate80C_Ded', 0, null, null);
            //Rebate80CCC
            setValuesoflabelTextSpan('txtRebate80CCC', 0, null, null);
            setValuesoflabelTextSpan('txtRebate80CCC_Ded', 0, null, null);
            //Rebate80CCD
            setValuesoflabelTextSpan('txtReb80CCD', 0, null, null);
            setValuesoflabelTextSpan('txtReb80CCD_Ded', 0, null, null);
            //Rebate80CCD2
            setValuesoflabelTextSpan('txtRebate80CCD2', 0, null, null);
            setValuesoflabelTextSpan('txtRebate80CCD2_Ded', 0, null, null);
            //Rebate80CCD1B
            setValuesoflabelTextSpan('txtRebate80CCD21b', 0, null, null);
            setValuesoflabelTextSpan('txtRebate80CCD21b_Ded', 0, null, null);
            //Rebate80QlfySal
            setValuesoflabelTextSpan('txtRebate80QlfySal', 0, null, null);
            //Rebate80NetSal
            setValuesoflabelTextSpan('txtRebate80NetSal', 0, null, null);

            //Rebate88D
            setValuesoflabelTextSpan('txtRebate80D', 0, null, null);
            setValuesoflabelTextSpan('txtRebate80D_Ded', 0, null, null);
            //Rebate80DD
            setValuesoflabelTextSpan('txtRebate80DD', 0, null, null);
            setValuesoflabelTextSpan('txtRebate80DD_Ded', 0, null, null);
            //Rebate80DDB
            setValuesoflabelTextSpan('txtRebate80DDB', 0, null, null);
            setValuesoflabelTextSpan('txtRebate80DDB_Ded', 0, null, null);
            //Rebate80QQB
            setValuesoflabelTextSpan('txtRebate80QQB', 0, null, null);
            setValuesoflabelTextSpan('txtRebate80QQB_Ded', 0, null, null);
            //Rebate80E
            setValuesoflabelTextSpan('txtRebate80E', 0, null, null);
            setValuesoflabelTextSpan('txtRebate80E_Ded', 0, null, null);
            //Rebate80EE
            setValuesoflabelTextSpan('txtRebate80EE', 0, null, null);
            setValuesoflabelTextSpan('txtRebate80EE_Ded', 0, null, null);
            //Rebate80G
            setValuesoflabelTextSpan('txtRebate80G', 0, null, null);
            //setValuesoflabelTextSpan('txtRebate80G_Qlfy', Rbts.Rebate80G_Qlfy, null, null);
            setValuesoflabelTextSpan('txtRebate80G_Ded', 0, null, null);
            //Rebate80GG
            setValuesoflabelTextSpan('txtRebate80GG', 0, null, null);
            //setValuesoflabelTextSpan('txtRebate80GG_Qlfy', Rbts.Rebate80GG_Qlfy, null, null);
            setValuesoflabelTextSpan('txtRebate80GG_Ded', 0, null, null);

            //Rebate80GGA
            setValuesoflabelTextSpan('txtRebate80GGA', 0, null, null);
            //setValuesoflabelTextSpan('txtRebate80GGA_Qlfy', Rbts.Rebate80GGA_Qlfy, null, null);
            setValuesoflabelTextSpan('txtRebate80GGA_Ded', 0, null, null);
            //Rebate80GGC
            setValuesoflabelTextSpan('txtRebate80GGC', 0, null, null);
            //setValuesoflabelTextSpan('txtRebate80GGC_Qlfy', Rbts.Rebate80GGC_Qlfy, null, null);
            setValuesoflabelTextSpan('txtRebate80GGC_Ded', 0, null, null);
            //Rebate80RRB
            setValuesoflabelTextSpan('txtRebate80RRB', 0, null, null);
            //setValuesoflabelTextSpan('txtRebate80RRB_Qlfy', Rbts.Rebate80RRB_Qlfy, null, null);
            setValuesoflabelTextSpan('txtRebate80RRB_Ded', 0, null, null);
            //Rebate80U
            setValuesoflabelTextSpan('txtRebate80U', 0, null, null);
            //setValuesoflabelTextSpan('txtRebate80U_Qlfy', Rbts.Rebate80U_Qlfy, null, null);
            setValuesoflabelTextSpan('txtRebate80U_Ded', 0, null, null);
            //Rebate80CCG
            setValuesoflabelTextSpan('txtRebate80CCG', 0, null, null);
            //setValuesoflabelTextSpan('txtRebate80CCG_Qlfy', Rbts.Rebate80CCG_Qlfy, null, null);
            setValuesoflabelTextSpan('txtRebate80CCG_Ded', 0, null, null);
            //Rebate80TTA
            setValuesoflabelTextSpan('txtRebate80TTA', 0, null, null);
            //setValuesoflabelTextSpan('txtRebate80TTA_Qlfy', Rbts.Rebate80TTA_Qlfy, null, null);
            setValuesoflabelTextSpan('txtRebate80TTA_Ded', 0, null, null);
        }
        /*********************tds Computation Started */

        function goforComputatioin(i) {
            $('#divEmployeeComputationSummary').hide();
            $('#txtemployeesearch').show();
            $('#divEmployeeComputation').show();
            var tobj = {
                Company_ID: companyid,
                Employee_ID: i,
                ConnectionString: $("[id*=hdnConnString]").val()
            };
            tobj = JSON.stringify({ 'tobj': tobj });

            $("#tblEmployeeTDScomputation").find("input[type=text]").each(function () {
                var conntrolname = $(this);
                if ('txtRebate80G_Qlfy' == conntrolname[0].id)
                { }
                else if ('txtRebate80G_Qlfy' == conntrolname[0].id)
                { }
                else if ('txtRebate80GG_Qlfy' == conntrolname[0].id)
                { }
                else if ('txtRebate80GGA_Qlfy' == conntrolname[0].id)
                { }
                else if ('txtRebate80GGC_Qlfy' == conntrolname[0].id)
                { }
                else if ('txtRebate80RRB_Qlfy' == conntrolname[0].id)
                { }
                else if ('txtRebate80U_Qlfy' == conntrolname[0].id)
                { }
                else if ('txtRebate80CCG_Qlfy' == conntrolname[0].id)
                { }
                else if ('txtRebate80TTA_Qlfy' == conntrolname[0].id)
                { }
                else {
                    $(this).val('0');
                }
            });
            $("#tblEmployeeTDScomputation").find(".spanwithno").each(function () { $(this).html('0'); });

            ServerServiceToGetData(tobj, baseUrl + 'getEmployeeComputation', 'false', getEmployeeComputation);
        }


        function Salaryblur(curr) {

            if (curr.data("headid") != '' && curr.data('month') != '' && curr.data("headid") != '0' && curr.data('month') != '0') {
                var thisheadid = curr.data("headid");
                var thismonth = curr.data("month");
                var currentRowno = curr.closest('tr').index();

                var i = 0;
                var rIndex = 0;
                var IndR = 0;

                if (curr.data("headnm") == 'Basic') {

                    $("input[name=txtHrr]").each(function () {
                        var row = $(this).closest("tr");
                        rIndex = row.closest('tr').index();
                        if (rIndex == currentRowno + 1) {
                            row.find('td:eq(1)').html(curr.val());
                            return false;
                        }
                    });
                }

                if ($(this).data("headnm") == 'DA') {

                    $("input[name=txtHrr]").each(function () {
                        var row = $(this).closest("tr");
                        rIndex = row.closest('tr').index();
                        if (rIndex == currentRowno + 1) {
                            row.find('td:eq(2)').html(curr.val());
                            return false;
                        }
                    });
                }
                if ($(this).data("headnm") == 'HRA') {

                    $("input[name=txtHrr]").each(function () {
                        var row = $(this).closest("tr");
                        rIndex = row.closest('tr').index();
                        if (rIndex == currentRowno + 1) {
                            row.find('td:eq(3)').html(curr.val());
                            return false;
                        }
                    });
                }

            }
        }

        function hrrKeyup(i) {
            var Currrow = i.closest("tr");
            var CurrIndex = Currrow.closest('tr').index();
            var CurrVal = Currrow.find("input[name=txtHrr]").val();
            $("input[name=txtHrr]").each(function () {
                var row = $(this).closest("tr");
                rIndex = row.closest('tr').index();
                if (rIndex >= CurrIndex) {
                    row.find("input[name=txtHrr]").val(CurrVal);

                }
            });
            AllTextBoxCal();
        }

        function getEmployeeComputation(data) {
            Emp = jQuery.parseJSON(data.d);
            Emp = Emp[0];
            Rbts = Emp.TRebates;
            Rbts = Rbts[0];
            HRR = Emp.LHRARentReceipt;
            var empid = Emp.Employee_ID;
            $("[id*=dvBtns]").show();
            SetControlsEmpty();
            //////LHRARentReceipt for point 2 section 10 calculation related table
            //////LMonthlySalaryBreakup formonthly salary gird
            //////LPerquisites for perquisites
            //////LProfessionTax for deductions profession tax
            //////LProfessiontaxMaster for point 4 deductions tax on employeement calculation related table
            //////LSection10 for section 10
            //////LTDSRebate for point 9 Section80c tds rebate


            //debugger
            var dteNow = Emp.Join_DT;
            dteNow = eval("new " + dteNow.replace(/\//g, ""));
            dteNow = convertDate(dteNow);
            if (dteNow == '01/01/1')
                dteNow = '';
            /*********************************************Employee Details**********************/
            //Employee_ID
            $("#txtemployeesearch").val(Emp.FirstName.toUpperCase());
            $("#FirstName").text(Emp.FirstName);
            $("#PAN_NO").text(Emp.PAN_NO);
            $("#Gender").text(Emp.Gender);
            $("#Senior_CTZN_Type").text(Emp.Senior_CTZN_Type);
            $("[id*=ddlMetrocities]").val(Emp.Metro_Cities);
            $("[id*=drpChild]").val(Emp.No_Of_Child);
            $("[id*=drpCtzn]").val(Emp.Senior_CTZN_Type);
            $("[id*=drpState]").val(Emp.state_id);
            if (Emp.CALC_PF == 1) {
                $("[id*=chkCalcProvidendFund]").attr('checked', 'checked');
            }
            else {
                $("[id*=chkCalcProvidendFund]").removeAttr('checked');
            }
            if (Emp.CALC_PT == 1) {
                $("[id*=chkCalcProfessionalTax]").attr('checked', 'checked');
            }
            else {
                $("[id*=chkCalcProfessionalTax]").removeAttr('checked');
            }

            //$("#Join_DT").text(dteNow);
            //$("#Designation_Name").text(Emp.Designation_Name);
            $("#ddlHrate").val(Emp.HRate);
            I115 = Emp.I115BAC;
            $("[id*=chkBAC]").removeAttr('checked');
            if (I115 == 1) {
                $("[id*=chkBAC]").attr('checked', 'checked');
                $("[id*=chkNrl]").removeAttr('checked');
                //SetZero_i115BAC();
                //disable_I115Bac();
                tblColor();
            }
            else {
                $("[id*=chkNrl]").attr('checked', 'checked');
                $("[id*=chkBAC]").removeAttr('checked');
                //enable_I115Bac();
                tblColor();
            }
            if (Emp.PAN_NO.trim() == "PANNOTAVBL")
            { $("#ddlHrate").val(1); }
            var M = '';
            if (Emp.Manual == true) {
                $("#chkPM").attr('checked', 'checked');
            }
            var H = '';
            $("#chkHRA").removeAttr('checked');
            if (Emp.ManualHRA == true) {
                $("#chkHRA").attr('checked', 'checked');
                $("[id*=TxtManualHra]").show();
            }
            else
            {
                $("[id*=TxtManualHra]").val(0);
                $("[id*=TxtManualHra]").hide();
            }
            SurchargeType = Emp.sur_type;
            if (SurchargeType == 'Marginal') {
                $("#chkSurcharge").attr('checked', 'checked');
            }
            else {
                $("#chkSurcharge").removeAttr('checked');
            }

            /*********************************************Point 1*****************************************/

            //    $("#Department_Name").text(Emp.Department_Name);
            //    Surcharge
            /*********Gross Salary (a)**********/
            //    Total_Earnings
            setValuesoflabelTextSpan('txtSalaryAsPerProvisions', Emp.Total_Earnings, null, null);
            /*********Gross Salary (b)**********/
            //    GrossPerks_B
            setValuesoflabelTextSpan('txtValueOfPerquisites', Emp.GrossPerks_B, null, null);
            /*********Gross Salary (c)**********/
            //    GrossProfits_C
            setValuesoflabelTextSpan('txtSalaryUnderSection', Emp.GrossProfits_C, null, null);
            /*********Gross Salary (d)**********/
            //    GrossTotal_D
            setValuesoflabelTextSpan('txtGrossSalaryTotal', Emp.GrossTotal_D, null, null);
            /**********display screen point 1************************/
            //    GrossEarn1
            setValuesoflabelTextSpan('txtGrossSalary', Emp.GrossEarn1, null, null);

            /*********************************************Point 2*****************************************/
            ////Section_10
            setValuesoflabelTextSpan('txtSection10', Emp.Section_10, null, null);
            ////get no of childs for child education calcualtion
            /////////No_Of_child
            setValuesoflabelTextSpan('hdnnoofchild', Emp.No_Of_child, null, null);

            /*********************************************Point 3*****************************************/
            //GrossEarn3
            setValuesoflabelTextSpan('txtTaxableBalance', Emp.GrossEarn3, null, null);
            //    PreSal
            setValuesoflabelTextSpan('txtPreviousTaxableSalary', Emp.PreSal, null, null);


            /*********************************************Point 4*****************************************/
            //TotalDeduction
            setValuesoflabelTextSpan('txtDeductions', Emp.TotalDeduction, null, null);
            //StandardDeduction
            setValuesoflabelTextSpan('txtStandardDeductions', Emp.StandardDeductions, null, null);
            //Entertainment
            setValuesoflabelTextSpan('txtEntertainmentAllowance', Emp.Entertainment, null, null);
            //PTax
            setValuesoflabelTextSpan('txtTaxonEmployeement', Emp.PTax, null, null);
            //////pt IDS
            $.each(Emp.LtblEmployeeTDSReletatedOtherDetails, function (i, va) { $("[id*=hdnPTCalHeadID]").val(va.ProfessionTaxIDS); });

            /*********************************************Point 5*****************************************/
            //GrossEarn5
            setValuesoflabelTextSpan('txtIncomecharge', Emp.GrossEarn5, null, null);


            /*********************************************Point 6*****************************************/
            //OtherIncome
            setValuesoflabelTextSpan('txtOtherIncome', Emp.OtherIncome, null, null);


            /*********************************************Point 7*****************************************/
            //IntHouseLoan
            setValuesoflabelTextSpan('txtHousingLoan', Emp.IntHouseLoan, null, null);


            /*********************************************Point 8*****************************************/
            //GrossEarn8
            setValuesoflabelTextSpan('txtGrossTotalIncome', Emp.GrossEarn8, null, null);


            /*********************************************Point 9*****************************************/
            //Rebate80C
            setValuesoflabelTextSpan('txtSection80CVariousInvestments', Rbts.Rebate80NetSal, null, null);
            setValuesoflabelTextSpan('txtRebate80C', Rbts.Rebate80C, null, null);
            setValuesoflabelTextSpan('txtRebate80C_Ded', Rbts.Rebate80C_Ded, null, null);
            //Rebate80CCC
            setValuesoflabelTextSpan('txtRebate80CCC', Rbts.Rebate80CCC, null, null);
            setValuesoflabelTextSpan('txtRebate80CCC_Ded', Rbts.Rebate80CCC_Ded, null, null);
            //Rebate80CCD
            setValuesoflabelTextSpan('txtReb80CCD', Rbts.Rebate80CCD, null, null);
            setValuesoflabelTextSpan('txtReb80CCD_Ded', Rbts.Rebate80CCD_Ded, null, null);
            //Rebate80CCD2
            setValuesoflabelTextSpan('txtRebate80CCD2', Rbts.Rebate80CCD2, null, null);
            setValuesoflabelTextSpan('txtRebate80CCD2_Ded', Rbts.Rebate80CCD2_Ded, null, null);
            //Rebate80CCD1B
            setValuesoflabelTextSpan('txtRebate80CCD21b', Rbts.Rebate80CCD1B, null, null);
            setValuesoflabelTextSpan('txtRebate80CCD21b_Ded', Rbts.Rebate80CCD1B_Ded, null, null);
            //Rebate80QlfySal
            setValuesoflabelTextSpan('txtRebate80QlfySal', Emp.Rebate80QlfySal, null, null);
            //Rebate80NetSal
            setValuesoflabelTextSpan('txtRebate80NetSal', Emp.Rebate80NetSal, null, null);
            //Rebate80QlfySalLimit
            var RebateLimits = jQuery.parseJSON($("[id*=hdnAllRebateLimits]").val());
            $.each(RebateLimits, function (i, va) {
                if (va.Rebate_Name == "Rebate80C")
                { setValuesoflabelTextSpan('txtRebate80QlfySalLimit', va.Rebate_Limit, null, null); }
            });



            /*********************************************Point 10*****************************************/
            //Rebate88D
            setValuesoflabelTextSpan('txtRebate80D', Rbts.Rebate88D, null, null);
            setValuesoflabelTextSpan('txtRebate80D_Ded', Rbts.Rebate88D_Ded, null, null);
            //Rebate80DD
            setValuesoflabelTextSpan('txtRebate80DD', Rbts.Rebate80DD, null, null);
            setValuesoflabelTextSpan('txtRebate80DD_Ded', Rbts.Rebate80DD_Ded, null, null);
            //Rebate80DDB
            setValuesoflabelTextSpan('txtRebate80DDB', Rbts.Rebate80DDB, null, null);
            setValuesoflabelTextSpan('txtRebate80DDB_Ded', Rbts.Rebate80DDB_Ded, null, null);
            //Rebate80QQB
            setValuesoflabelTextSpan('txtRebate80QQB', Rbts.Rebate80QQB, null, null);
            setValuesoflabelTextSpan('txtRebate80QQB_Ded', Rbts.Rebate80QQB_Ded, null, null);
            //Rebate80E
            setValuesoflabelTextSpan('txtRebate80E', Rbts.Rebate80E, null, null);
            setValuesoflabelTextSpan('txtRebate80E_Ded', Rbts.Rebate80E_Ded, null, null);
            //Rebate80EE
            setValuesoflabelTextSpan('txtRebate80EE', Rbts.Rebate80EE, null, null);
            setValuesoflabelTextSpan('txtRebate80EE_Ded', Rbts.Rebate80EE_Ded, null, null);
            //Rebate80G
            setValuesoflabelTextSpan('txtRebate80G', Rbts.Rebate80G, null, null);
            //setValuesoflabelTextSpan('txtRebate80G_Qlfy', Rbts.Rebate80G_Qlfy, null, null);
            setValuesoflabelTextSpan('txtRebate80G_Ded', Rbts.Rebate80G_Ded, null, null);
            //Rebate80GG
            setValuesoflabelTextSpan('txtRebate80GG', Rbts.Rebate80GG, null, null);
            //setValuesoflabelTextSpan('txtRebate80GG_Qlfy', Rbts.Rebate80GG_Qlfy, null, null);
            setValuesoflabelTextSpan('txtRebate80GG_Ded', Rbts.Rebate80GG_Ded, null, null);

            //Rebate80GGA
            setValuesoflabelTextSpan('txtRebate80GGA', Rbts.Rebate80GGA, null, null);
            //setValuesoflabelTextSpan('txtRebate80GGA_Qlfy', Rbts.Rebate80GGA_Qlfy, null, null);
            setValuesoflabelTextSpan('txtRebate80GGA_Ded', Rbts.Rebate80GGA_Ded, null, null);
            //Rebate80GGC
            setValuesoflabelTextSpan('txtRebate80GGC', Rbts.Rebate80GGC, null, null);
            //setValuesoflabelTextSpan('txtRebate80GGC_Qlfy', Rbts.Rebate80GGC_Qlfy, null, null);
            setValuesoflabelTextSpan('txtRebate80GGC_Ded', Rbts.Rebate80GGC_Ded, null, null);
            //Rebate80RRB
            setValuesoflabelTextSpan('txtRebate80RRB', Rbts.Rebate80RRB, null, null);
            //setValuesoflabelTextSpan('txtRebate80RRB_Qlfy', Rbts.Rebate80RRB_Qlfy, null, null);
            setValuesoflabelTextSpan('txtRebate80RRB_Ded', Rbts.Rebate80RRB_Ded, null, null);
            //Rebate80U
            setValuesoflabelTextSpan('txtRebate80U', Rbts.Rebate80U, null, null);
            //setValuesoflabelTextSpan('txtRebate80U_Qlfy', Rbts.Rebate80U_Qlfy, null, null);
            setValuesoflabelTextSpan('txtRebate80U_Ded', Rbts.Rebate80U_Ded, null, null);
            //Rebate80CCG
            setValuesoflabelTextSpan('txtRebate80CCG', Rbts.Rebate80CCG, null, null);
            //setValuesoflabelTextSpan('txtRebate80CCG_Qlfy', Rbts.Rebate80CCG_Qlfy, null, null);
            setValuesoflabelTextSpan('txtRebate80CCG_Ded', Rbts.Rebate80CCG_Ded, null, null);
            //Rebate80TTA
            setValuesoflabelTextSpan('txtRebate80TTA', Rbts.Rebate80TTA, null, null);
            //setValuesoflabelTextSpan('txtRebate80TTA_Qlfy', Rbts.Rebate80TTA_Qlfy, null, null);
            setValuesoflabelTextSpan('txtRebate80TTA_Ded', Rbts.Rebate80TTA_Ded, null, null);


            /*********************************************Point 18*****************************************/
            //Rebate89
            setValuesoflabelTextSpan('txtUnderSection89', Emp.Rebate89, null, null);

            /*********************************************Point 19*****************************************/
            //Less:a.Tax deducted at source U/s 192(1) tds computation
            $.each(Emp.LtblEmployeeTDSReletatedOtherDetails, function (i, va) {
                setValuesoflabelTextSpan('txtTaxDeductedAtSource', Math.round(va.ChallanTDS), null, null);
                setValuesoflabelTextSpan('txtTaxDeductedAtSourceSH', Math.round(va.ChallanTDS), null, null);
            });



            /*********************************************Point 20*****************************************/
            //PreTds
            setValuesoflabelTextSpan('txtTaxDeductedbyPreEmployer', Emp.PreTds, null, null);


            /*****************************point 1*************************************************/
            //debugger
            var MonthlyHeadIDs = [];
            var OnlyMonthHeadIDs = [];
            var tblMonthlySalaryHeader = '';
            var tblMonthlySalarybody = '';
            var tblMonthlySalaryfooter = '';
            var Hrval = 0;
            $("#tblMonthlySalary").empty();
            tblMonthlySalaryHeader += "<thead><tr><th><input type='hidden' data-name='headid' value='0'/>Month Name</th><th><input type='hidden' data-name='headid' value='0'/>Month Wise Total</th>";
            tblMonthlySalaryfooter += '<tfoot><tr><th>Total</th><th><span class="getTotalCal1 spanwithno">0</span></th>';
            $.each(Emp.LMonthlySalaryBreakup, function (index, value) {
                if ($.inArray(value.Head_ID, OnlyMonthHeadIDs) === -1) {
                    OnlyMonthHeadIDs.push(value.Head_ID);
                    MonthlyHeadIDs.push(value);
                    tblMonthlySalaryHeader += "<th><input type='hidden' data-name='headid' value='" + value.Head_ID + "'/>" + value.Head_Name + "</th>";
                    tblMonthlySalaryfooter += "<th><span data-headid='" + value.Head_ID + "' class='spanwithno monthlysalarytotal'>0</sapn></th>";
                }
            });

            var mn = '';
            tblMonthlySalaryHeader += '</tr></thead>';
            tblMonthlySalaryfooter += '</tr></tfoot>';
            $("#tblMonthlySalary").append(tblMonthlySalaryHeader + tblMonthlySalaryfooter);
            if (Hemt == 0) {
                var tbl = '';
                $("[id*=tblHrr] tbody").empty();
            }
            tbl = tbl + "<tr >";
            tbl = tbl + "<th style='text-align: center; width:15%;' class='cssGridHeader'>Month</th>";
            tbl = tbl + "<th style='width:25%;' class='cssGridHeader'>Basic</th>";
            tbl = tbl + "<th style='width:25%;' class='cssGridHeader'>DA</th>";
            tbl = tbl + "<th style='width:25%;' class='cssGridHeader'>HRA</th>";
            tbl = tbl + "<th style='width:30%;' class='cssGridHeader'>HRR</th>";
            //////////go with monthid
            $.each(MonthIDS, function (i, month) {
                tblMonthlySalarybody += '<tr>';
                tblMonthlySalarybody += '<td>' + ReturnMonthname(month) + '</td><td ><span style="width:80px; font-weight:bold; text-align:right;" data-month=' + month + ' class="spanwithno">0</sapn></td>';
                //////////go with headids
                mn = ReturnMonthname(month);
                $.each(OnlyMonthHeadIDs, function (j, headdistinctid) {
                    //////////go with monthid and headid for amt
                    $.each(Emp.LMonthlySalaryBreakup, function (index, amt) {
                        if (parseInt(amt.SalaryMonth) == month && amt.Head_ID == headdistinctid) {
                            tblMonthlySalarybody += '<td><input id="txtSalary" type="text" style="width:100px; float:right; margin:-3px; font-size:12px;" class="cssTextboxInt cssSalary" data-headid=' + headdistinctid + ' data-month=' + month + ' data-headnm=' + amt.Head_Name + ' value=' + amt.Amount + ' /></td>';
                            ////////// If HRR is not entered or the table is blank
                            /////// Entry for HRR Table
                            if (amt.Head_Name == 'Basic') {
                                tbl = tbl + "<tr >";
                                tbl = tbl + "<td style='text-align: left;' class='cssGrdAlterItemStyle'>" + mn + "</td>";
                                tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle'>" + amt.Amount + '.00' + "</td>";

                                Hrval = 1;
                            }
                            if (amt.Head_Name == 'DA') {

                                tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle'>" + amt.Amount + '.00' + "</td>";

                                Hrval = 1;
                            }
                            if (amt.Head_Name == 'HRA') {
                                tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle'>" + amt.Amount + '.00' + "</td>";
                                tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle'><input id='txtHrr' name='txtHrr' type='text' class='cssTextboxInt'  value=0.00 onkeyup='hrrKeyup($(this))'></input><input type='hidden' id='hdnMth' value='" + month + "' name='hdnMth' /></td></tr>";
                                Hrval = 1;
                            }

                        }
                    }); $("[id*=tblHrr]")
                    //////////go with monthid and headid for amt
                });

                //////////go with headids
                tblMonthlySalarybody += '</tr>';
            });
            //////////go with monthid

            if (Hrval == 1) {
                $("[id*=tblHrr]").append(tbl);

                hrval = 0;
            }


            $("#tblMonthlySalary").append('<tbody>' + tblMonthlySalarybody + '</tbody>');
            //getHraRentReciept(empid)
            getHraRentReciept(Emp.LHRARentReceipt)
            /****************************perquisites******************************************/
            //LMonthlySalaryBreakup
            $("#tblPerquisites tbody").empty();
            $.each(Emp.LPerquisites, function (i, v) {
                var curr = '';
                curr += "<tr>";
                curr += "<td style='text-align:right;'><input type='hidden' value='" + v.Perquisites_ID + "'/>" + (i + 1) + "</td>";
                curr += "<td>" + v.Perquisites_Name + "</td>";
                curr += "<td><input type='text' style='width:100px; margin:-2px;' class='cssTextboxInt' data-name='Perquisites_Value' value='" + v.Perquisites_Value + "' /></td>";
                curr += "<td><input type='text' style='width:100px; margin:-2px;' class='cssTextboxInt' data-name='EmployeePaid_Amt' value='" + v.EmployeePaid_Amt + "' /></td>";
                curr += "<td><input type='text' style='width:100px; margin:-2px;' class='cssTextboxInt' data-name='Taxable_Amt' value='" + v.Taxable_Amt + "' /></td>";
                curr += "</tr>";
                $("#tblPerquisites tbody").append(curr);
            });

            var tblPerquisitesfootre = '<tr><tfoot>';
            tblPerquisitesfootre += '<th></th><th></th>';
            tblPerquisitesfootre += '<th><span class="spanwithno Perquisites_Value" data-getTotal="Perquisites_Value">0</span></th>';
            tblPerquisitesfootre += '<th><span class="spanwithno EmployeePaid_Amt" data-getTotal="EmployeePaid_Amt">0</span></th>';
            tblPerquisitesfootre += '<th><span class="spanwithno  perquisitesAllTotal Taxable_Amt" data-getTotal="Taxable_Amt">0</span></th>';
            tblPerquisitesfootre += '</tr></tfoot>';
            $("#tblPerquisites tbody").append(tblPerquisitesfootre);

            /*****************************point 2*************************************************/

            /***********************************section 10*********************************************/

            //$("#tblSectionten tbody").empty(); var trSection10 = '';
            //$.each(Emp.LSection10, function (i, v) {

            //        if ($("#chkHRA").is(':checked')) {
            //            if (v.Head_Name == 'HRA') {
            //                $("[id*=TxtManualHra]").val(v.Amount);
            //            }
            //        }
            //        trSection10 += '<tr>';
            //        trSection10 += '<td width="3%" style="text-align:right;"><input type="hidden" value="' + v.Head_ID + '"/>' + (i + 1) + '</td>';
            //        trSection10 += '<td width="70%">' + v.Head_Name + '</td>';
            //        trSection10 += '<td><span id="spn" name="spn" class="spanwithno sectiontenAmountPerheadid" data-limit="' + v.Limit + '">' + v.Amount + '</span><input id="hdnHname" name="hdnHname" type="hidden" value="' + v.hname + '"/></td>';
            //        trSection10 += '</tr>';
                
            //});
            //$("#tblSectionten tbody").append(trSection10);

            /***********************************************point 4****************************************************/
            /************************************professtion tax***************************************************************/
            //$("#tblProfesstionTax tbody").empty();
            //var MPT = ''
            //if ($("#chkPM").is(':checked')) {
            //    MPT = 'Manual';
            //}
            //if (parseFloat(I115) == 1) {
            //    $.each(MonthIDS, function (i, month) {
            //        var currow = '';
            //        currow += '<tr>'
            //        currow += '<td><input type="hidden" value="' + month + '">' + ReturnMonthname(month) + '</td>'
            //        if (MPT == '') {
            //            currow += '<td><input id="Mpt" name="Mpt" type="text" class="cssTextboxInt professiontaxamt"  value="0" disable ></input></td>'
            //        }
            //        else {
            //            currow += '<td><input id="Mpt" name="Mpt" type="text" class="cssTextboxInt professiontaxamt"  value="0" disable="false"></input></td>'
            //        }
            //        currow += '</tr>'
            //        $("#tblProfesstionTax tbody").append(currow);

            //    });
            //}
            //else {
            //    $.each(MonthIDS, function (i, month) {
            //        if (Emp.LProfessionTax.length > 0) {
            //            $.each(Emp.LProfessionTax, function (j, va) {
            //                if (month == va.SalaryMonth) {
            //                    var currow = '';
            //                    currow += '<tr>'
            //                    currow += '<td><input type="hidden" value="' + month + '">' + ReturnMonthname(month) + '</td>'
            //                    if (MPT == '') {
            //                        currow += '<td><input  id="Mpt" name="Mpt" type="text" class="cssTextboxInt professiontaxamt"  value=' + va.Amount + ' disable></input></td>'
            //                    }
            //                    else {
            //                        currow += '<td><input id="Mpt" name="Mpt" type="text" class="cssTextboxInt professiontaxamt"  value=' + va.Amount + '  disable="false"></input></td>'
            //                    }
            //                    currow += '</tr>'
            //                    $("#tblProfesstionTax tbody").append(currow);
            //                }
            //            });
            //        }
            //        else {
            //            var currow = '';
            //            currow += '<tr>'
            //            currow += '<td><input type="hidden" value="' + month + '">' + ReturnMonthname(month) + '</td>'
            //            if (MPT == '') {
            //                currow += '<td><input id="Mpt" name="Mpt" type="text" class="cssTextboxInt professiontaxamt"  value="0" disable ></input></td>'
            //            }
            //            else {
            //                currow += '<td><input id="Mpt" name="Mpt" type="text" class="cssTextboxInt professiontaxamt"  value="0" disable="false"></input></td>'
            //            }
            //            currow += '</tr>'
            //            $("#tblProfesstionTax tbody").append(currow);
            //        }
            //    });
            //}
            /**********************************************point 9*******************************************************/
            /*********************section 80C*******************************/
            $("#tblAddedRebeats tbody").empty();
            //debugger
            $.each(Emp.LTDSRebate, function (j, va) {
                var currow = '';
                currow += '<tr>'
                currow += '<td width="80%"><input type="hidden" value="' + va.Rebate_ID + '">' + va.Rebate_Name + '</td>'
                currow += '<td><span class="spanwithno rebatamt">' + va.Amount + '</span></td>'

                //if (va.Rebate_ID == '2') currow += '<td></td>'; else
                currow += '<td style="text-align:center;"><img src="../Images/Delete_icon.png" onclick="removeRebate(this)"></td>';

                currow += '</tr>'
                $("#tblAddedRebeats tbody").append(currow);
            });


            /**********************************************point 13*******************************************************/
            for (var i = 0; i < 4; i++) {
                var slabperName = 'lblSlabPer' + (i + 1);
                var slabName = 'lblSlab' + (i + 1);
                $('[id*=' + slabperName + ']').html(0);
                $('[id*=' + slabName + ']').html(0);
            }
            $.each(Emp.LIncomeTaxMaster, function (j, va) {
                var slabperName = 'lblSlabPer' + (j + 1);
                var slabName = 'lblSlab' + (j + 1);
                $('[id*=' + slabperName + ']').html(va.Slab);
                $('[id*=' + slabName + ']').html(va.Tax_Amount);
            });

            for (var i = 0; i < 6; i++) {
                var slabperNameSH = 'lblSlabPer' + (i + 1) + 'SH';
                var slabNameSH = 'lblSlab' + (i + 1) + 'SH';
                $('[id*=' + slabperNameSH + ']').html(0);
                $('[id*=' + slabNameSH + ']').html(0);
            }
            $.each(Emp.IncomeTaxM, function (j, va) {
                var slabperNameSH = 'lblSlabPer' + (j + 1) + 'SH';
                var slabNameSH = 'lblSlab' + (j + 1) + 'SH';
                $('[id*=' + slabperNameSH + ']').html(va.Slab);
                $('[id*=' + slabNameSH + ']').html(va.Tax_Amount);
            });

            ////****************************************** Challan Summary ************************************************/
            $("#tblChnl tbody").empty();
            //debugger
            var tbl = '';
            tbl += "<tr>";
            tbl += "<th>#</th>";
            tbl += "<th>Quarter</th>";
            tbl += "<th>Challan NO</th>";
            tbl += "<th>Challan Date</th>";
            tbl += "<th>TDS Deduction Date</th>";
            tbl += "<th>Salary</th>";
            tbl += "<th>TDS Amount</th>";
            tbl += "<th>Surcharge Amount</th>";
            tbl += "<th>EducationCess Amount</th>";
            tbl += "<th>High Education Cess Amount</th>";
            tbl += "<th>Total TDS Amount</th>";
            tbl += "</tr>";

            $.each(Emp.TChallanDtls, function (j, c) {

                tbl += "<tr>";
                tbl += "<td style='text-align:right;'>" + (j + 1) + "</td>";
                tbl += "<td width='10%'>" + c.Quater + "</td>";
                tbl += "<td width='10%' style='text-align:right;'>" + c.Challan_NO + "</td>";
                tbl += "<td width='10%' style='text-align:center;'>" + c.Challan_Date + "</td>";
                tbl += "<td width='10%' style='text-align:center;'>" + c.TDS_Deduction_Date + "</td>";
                tbl += "<td width='10%' class='frontMakeFormat' style='text-align:right;'>" + c.Employee_Salary + "</td>";
                tbl += "<td width='10%' class='frontMakeFormat' style='text-align:right;'>" + c.TDS_Amount + "</td>";
                tbl += "<td width='10%' class='frontMakeFormat' style='text-align:right;'>" + c.Surcharge_Amount + "</td>";
                tbl += "<td width='10%' class='frontMakeFormat' style='text-align:right;'>" + c.EducationCess_Amount + "</td>";
                tbl += "<td width='10%' class='frontMakeFormat' style='text-align:right;'>" + c.High_EductionCess_Amount + "</td>";
                tbl += "<td width='10%' class='frontMakeFormat' style='text-align:right;'>" + c.Total_TDS_Amount + "</td>";
                tbl += "</tr>";
            });
            $("#tblChnl tbody").append(tbl);

            /////////////////////////////////////////////text box Event Initialze here
            $(".cssTextboxInt").keyup(function (e) {
                //debugger
                var txtQty = $(this).val().replace(/[^-0-9\.]/g, '');
                $(this).val(txtQty);

                if (e.keyCode == 13) {
                    MonthsalaryEnterKeypressedEvent($(this));
                }
                return false;
            });

            $(".cssTextboxInt").blur(function () {
                var txtid = $(this)[0].id;
                if (txtid == 'txtSalary') {
                    Salaryblur($(this));
                }
                else {
                    var txtQty = $(this).val().replace(/[^-0-9\.]/g, '');
                    if (txtQty == '')
                    { txtQty = 0; }
                    $(this).val(parseFloat(txtQty));
                    var Controlname = $(this)[0].id;
                    //////////check if text box havaing limit or input text is rebate value
                    var rebateLimit = $(this).data("limit");
                    if (rebateLimit != undefined && rebateLimit != "") {
                        rebateLimit = parseFloat(rebateLimit);
                        if (parseFloat($(this).val()) > rebateLimit) {
                            if (Controlname == "txtRebate80CCD21b") {
                                $("[id*=txtRebate80CCD21b_Ded]").val(rebateLimit);
                                Controlname = '';
                            }
                            if (Controlname == "txtRebate80CCD2") {
                                $("[id*=txtRebate80CCD2_Ded]").val(rebateLimit);
                                Controlname = '';
                            }

                            if (Controlname == "txtRebate8OD") {
                                $("[id*=txtRebate80D_Ded]").val(rebateLimit);
                                Controlname = '';
                            }
                            if (Controlname == "txtRebate80DD") {
                                $("[id*=txtRebate80DD_Ded]").val(rebateLimit);
                                Controlname = '';
                            }
                            if (Controlname == "txtRebate80DDB") {
                                $("[id*=txtRebate80DDB_Ded]").val(rebateLimit);
                                Controlname = '';
                            }
                            if (Controlname == "txtRebate80QQB") {
                                $("[id*=txtRebate80QQB_Ded]").val(rebateLimit);
                                Controlname = '';
                            }
                            if (Controlname == "txtRebate80E") {
                                $("[id*=txtRebate80E_Ded]").val(rebateLimit);
                                Controlname = '';
                            }
                            if (Controlname == "txtRebate80EE") {
                                $("[id*=txtRebate80EE_Ded]").val(rebateLimit);
                                Controlname = '';
                            }


                            if (Controlname == "txtRebate80G") {
                                $("[id*=txtRebate80G_Ded]").val(rebateLimit);
                                Controlname = '';
                            }
                            if (Controlname == "txtRebate80GG") {
                                $("[id*=txtRebate80GG_Ded]").val(rebateLimit);
                                Controlname = '';
                            }
                            if (Controlname == "txtRebate80GGA") {
                                $("[id*=txtRebate80GGA_Ded]").val(rebateLimit);
                                Controlname = '';
                            }
                            if (Controlname == "txtRebate80GGC") {
                                $("[id*=txtRebate80GGC_Ded]").val(rebateLimit);
                                Controlname = '';
                            }
                            if (Controlname == "txtRebate80RRB") {
                                $("[id*=txtRebate80RRB_Ded]").val(rebateLimit);
                                Controlname = '';
                            }
                            if (Controlname == "txtRebate80U") {
                                $("[id*=txtRebate80U_Ded]").val(rebateLimit);
                                Controlname = '';
                            }
                            if (Controlname == "txtRebate80CCG") {
                                $("[id*=txtRebate80CCG_Ded]").val(rebateLimit);
                                Controlname = '';
                            }
                            if (Controlname == "txtRebate80TTA") {
                                $("[id*=txtRebate80TTA_Ded]").val(rebateLimit);
                                Controlname = '';
                            }
                            if (Controlname != '') {
                                $(this).val(parseFloat(rebateLimit));
                            }

                        }
                        else {
                            Controlname = Controlname + '_Ded';
                            $("[id*=" + Controlname + "]").val($(this).val());
                        }
                    }
                }
                AllTextBoxCal();
            });
            ////////////////cal all values of subtotal
            AllTextBoxCal();
        }



        function getHraRentReciept(hrr) {
            if (hrr.length > 0) {
                $("input[name=txtHrr]").each(function () {
                    var row = $(this).closest("tr");
                    var e = parseFloat(row.find("input[name=hdnMth]").val());
                    for (var i = 0; i < hrr.length; i++) {
                        var jj = 0;
                        jj = parseFloat(hrr[i].Month_No);

                        if (e == jj) {
                            $(this).val(hrr[i].Amount);
                        }
                    }
                });

            }
        }
        function SaveHRR() {
            var empid = Emp.Employee_ID;
            var compid = $("[id*=hdnCompanyID]").val();

            var Conn = $("[id*=hdnConnString]").val();
            var aDns = '';
            $("input[name=txtHrr]").each(function () {
                var row = $(this).closest("tr");
                var rIndex = $(this).closest("tr")[0].sectionRowIndex;
                var mname = row.find('td:eq(0)').html();
                var mth = row.find("input[name=hdnMth]").val();
                var Hrr = $(this).val();
                if (Hrr != undefined) {

                    aDns = aDns + Hrr + "," + mth + "," + mname + "^";
                }

            });
            try {
                var calala = $.ajax({
                    type: "POST",
                    url: "../Handler/WebServiceTDSComputation.asmx/UpadteHRR",
                    data: '{Compid:' + compid + ',Conn: "' + Conn + '",empid:' + empid + ',Multi: "' + aDns + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        var myList = jQuery.parseJSON(msg.d);
                        if (myList[0].Head_id == 1) {
                            alert("Updated Successfully");
                        } else {
                        }
                    }
                });
            }
            catch (e) {
                alert('Error Occoured ' + e);
            }
        }

        ////////////////////////////////////////////////////////AllTextBoxCal
        function AllTextBoxCal() {
            removeComma();
            ///////point 1
            ///////////////monthly salary span total
            $("#tblMonthlySalary span").each(function () {
                if ($(this).data("headid") != '' && $(this).data("headid") != '0' && $(this).data("headid") != undefined) {
                    var grtotal = 0;
                    var spanheadid = $(this).data("headid");
                    $("#tblMonthlySalary input[type=text]").each(function () {
                        if ($(this).data("headid") == spanheadid)
                        { grtotal += parseFloat($(this).val()); }
                    });
                    $(this).html(grtotal);
                } else if ($(this).data("month") != '' && $(this).data("month") != '0' && $(this).data("month") != undefined) {
                    var grtotal = 0;
                    var spanmonthid = $(this).data("month");
                    $("#tblMonthlySalary input[type=text]").each(function () {
                        if ($(this).data("month") == spanmonthid)
                        { grtotal += parseFloat($(this).val()); }
                    });
                    $(this).html(grtotal);
                }
            });
            //////////perquisites
            $("#tblPerquisites span").each(function () {
                if ($(this).data("gettotal") != '' && $(this).data("gettotal") != '0') {
                    var grtotal = 0;
                    var fName = $(this).data("gettotal");
                    $("#tblPerquisites input[type=text]").each(function () {
                        if ($(this).data("name") == fName)
                        { grtotal += parseFloat($(this).val()); }
                    });
                    $(this).html(grtotal);
                }
            });


            ///////////section 80CCCD Limit point 9
            var BasicID = 0;
            $.each(Emp.LMonthlySalaryBreakup, function (ii, vsa) {
                if (vsa.Head_Name == "Basic") {
                    BasicID = vsa.Head_ID;
                    return false;
                }
            });
            //if (BasicID > 0) {
            //    $("#tblMonthlySalary .monthlysalarytotal").each(function () {
            //        if ($(this).data('headid') == BasicID)
            //        { BasicID = returnNumeric($(this).html()); return false; }
            //    });
            //    var txtReb80CCD = returnNumeric($("#txtReb80CCD").val());
            //    BasicID = Math.round((BasicID * 10) / 100);
            //    if (txtReb80CCD > BasicID) {
            //        $("#txtReb80CCD").val(BasicID);
            //    }
            //}


            //debugger
            /////////////section 10 calculation hrr cal
            var GrossMonthlySalaryArray = getGrossMonthlySalaryInArray();
            var Sec115Amt = 0;
         
            //$("#tblSectionten tbody tr").each(function () {
            //    var hid = $("input[type=hidden]", $(this)).val();
            //    var headname = $("td:eq(1)", $(this)).text();
            //    var currAmttt = 0;
            //    var row = $(this).closest('tr');
            //    var hn = row.find("input[name=hdnHname]").val();
            //    if (headname == "HRA") {
            //        if ($("#chkHRA").is(':checked')) {
            //            currAmttt = $("[id*=TxtManualHra]").val();
            //        }
            //        else {
            //            var FinalHRAamount = 0;
            //            //////var BasicDAHraHrrarrya = HrrCalculationTable(GrossMonthlySalaryArray);
            //            var BasicDAHraHrr = {
            //                list: []
            //            };
            //            $("input[name=txtHrr]").each(function () {
            //                var row = $(this).closest("tr");
            //                rIndex = row.closest('tr').index();
            //                var m = parseFloat(row.find("input[name=hdnMth]").val());
            //                var b = parseFloat(row.find('td:eq(1)').html());
            //                var d = parseFloat(row.find('td:eq(2)').html());
            //                var h = parseFloat(row.find('td:eq(3)').html());
            //                var hr = parseFloat(row.find("input[name=txtHrr]").val());
            //                BasicDAHraHrr.list.push({
            //                    "month": m,
            //                    "HRR": hr,
            //                    "HRA": h,
            //                    "DA": d,
            //                    "Basic": b
            //                });
            //            });
            //            var BasicDAHraHrrarrya = BasicDAHraHrr.list;
            //            if (BasicDAHraHrrarrya.length > 0) {
            //                var BasicAmt = 0, HraAmt = 0, HrrAmt = 0, DaAmt = 0, HRA1 = 0, HRA2 = 0, HRA3 = 0;
            //                $.each(BasicDAHraHrrarrya, function (i, va) {
            //                    if (va.Basic != 0 && va.HRR != 0 && va.HRA != 0) {
            //                        BasicAmt += va.Basic;
            //                        HrrAmt += va.HRR;
            //                        HraAmt += va.HRA;
            //                        DaAmt += va.DA;
            //                    }
            //                });

            //                BasicAmt = BasicAmt + DaAmt;

            //                $("[id*=lblTHrrAmt]").html(HrrAmt);
            //                //////////////if hra type Basic+DA 
            //                if (Emp.HraType == "Basic+DA")
            //                    BasicAmt += DaAmt;

            //                $("[id*=lbTBasicAmt]").html(BasicAmt);
            //                /// Condition 1              
            //                var HRA1 = HraAmt;
            //                $("[id*=lblTHraAmt]").html(HRA1);
            //                /// condition 2              
            //                var Amt = 0;

            //                ////Onetenth of Basic              
            //                Amt = (BasicAmt * 10) / 100;
            //                if (HrrAmt > 0 && HrrAmt > Amt) {
            //                    HRA2 = HrrAmt - Amt;
            //                }
            //                else {
            //                    HRA2 = Amt - HrrAmt;
            //                }
            //                $("[id*=lbl10Amt]").html(HRA2);


            //                //-- Condition 3               
            //                if (Emp.Metro_Cities == 'Mumbai' | Emp.Metro_Cities == 'Kolkata' | Emp.Metro_Cities == 'Delhi' | Emp.Metro_Cities == 'Chennai') {
            //                    HRA3 = BasicAmt / 2;
            //                    $("[id*=lblMetroC]").html(Emp.Metro_Cities);
            //                    $("[id*=lblper]").html('Half of Basic');
            //                    $("[id*=lblperVal]").html(HRA2);
            //                }
            //                else {
            //                    HRA3 = (BasicAmt * 40) / 100;
            //                    $("[id*=lblMetroC]").html('Others');
            //                    $("[id*=lblper]").html('40% of Basic');
            //                    $("[id*=lblperVal]").html(HRA2);

            //                }


            //                if (HRA1 <= HRA2 && HRA1 <= HRA3)
            //                    FinalHRAamount = HRA1;
            //                else if (HRA2 <= HRA3)
            //                    FinalHRAamount = HRA2;
            //                else
            //                    FinalHRAamount = HRA3;
            //            }
            //            currAmttt = FinalHRAamount;

            //            $("[id*=lblFinalAmt]").html(FinalHRAamount);
            //        }
            //    }
            //    else if (headname == "CHILD EDUCATION") {
            //        $.each(GrossMonthlySalaryArray, function (i, vaa) {
            //            if (vaa.headid == hid) {
            //                if (vaa.amount > 100) {

            //                    currAmttt += 100;
            //                }
            //                else {
            //                    currAmttt += vaa.amount;
            //                }
            //            }
            //        });

            //            if (parseFloat(Emp.No_Of_Child) > 2) {
            //                currAmttt = parseFloat(2) * currAmttt;
            //            }
            //            else {
            //                currAmttt = parseFloat(Emp.No_Of_Child) * currAmttt;
            //            }
            //        }
            //    else {
            //        $.each(GrossMonthlySalaryArray, function (i, vaa) {
            //            if (vaa.headid == hid)

            //                currAmttt += vaa.amount;
            //        });

            //    }
            //    var Limitforhead = $(".sectiontenAmountPerheadid", $(this)).data("limit");
            //    if (Limitforhead != '' && Limitforhead != undefined && Limitforhead != "0") {
            //        if (parseFloat(Limitforhead) > 0) {
            //            if (parseFloat(Limitforhead) < parseFloat(currAmttt))
            //            { currAmttt = parseFloat(Limitforhead); }
            //        }
            //    }
            //    $(".sectiontenAmountPerheadid", $(this)).text(parseFloat(currAmttt));
            //    if (hn == 'HRA')
            //    {
            //        Sec115Amt += 0;
            //    }
            //    else if (hn == 'Travel')
            //    {
            //        Sec115Amt += 0;
            //    }
            //    else
            //    {
            //        Sec115Amt = parseFloat(Sec115Amt) +  parseFloat(currAmttt);
            //    }

            //    $("#txtSection10SH").html(Sec115Amt);
            //});


            //////////////profession tax calculation
            //var MPT = '';
            //if ($("#chkPM").is(':checked')) {
            //    MPT = 'Manual';
            //}
            ////if (parseFloat(I115) == 0) {
            //    $("#tblProfesstionTax tbody tr").each(function () {
            //        var slabvalue = 0;
            //        if (Emp.CALC_PT) {
            //            if (MPT == '') {
            //                var month = $("input[type=hidden]", this).val();
            //                month = parseFloat(month);
            //                var pt_headids = $("[id*=hdnPTCalHeadID]").val().split(',');
            //                var currAmttt = 0;

            //                $.each(GrossMonthlySalaryArray, function (i, vaa) {
            //                    if (month == vaa.month)
            //                        $.each(pt_headids, function (j, va) {
            //                            if (vaa.headid == va.trim())
            //                                currAmttt += vaa.amount;
            //                        });
            //                });
            //                $.each(Emp.LProfessiontaxMaster, function (i, va) {
            //                    if (parseFloat(va.From_Tax_Amount) <= currAmttt && parseFloat(va.To_Tax_Amount) >= currAmttt)
            //                        slabvalue = va.Slab;

            //                    if (slabvalue == 200 && parseFloat(Emp.state_id) == 19 && month == 2)
            //                        slabvalue += 100;
            //                });
            //            }
            //            else {  //// Manual
            //                var row = $(this).closest("tr");
            //                var R = $("#Mpt", row).val();
            //                if (R != undefined) {
            //                    slabvalue = parseFloat(slabvalue) + parseFloat(R);
            //                }
            //            }
            //            // $("#Mpt", this).val(slabvalue);
            //            $(".professiontaxamt", this).val(slabvalue);
            //        } else { $(".professiontaxamt", this).val("0"); }
            //    });



                //////////////////////point 9 pf calculation
                $("#tblAddedRebeats tbody tr").each(function () {
                    if ("2" == $("input[type=hidden]", $(this).closest("tr")).val()) {
                        if (Emp.CALC_PF) {
                            var PFPer = returnNumeric($("[id*=hdnPFPercentage]").val())
                              , PFLimit = returnNumeric($("[id*=hdnPFLimit]").val())
                              , PFIDS = [];
                            $.each($("[id*=hdnPFCalHeadID]").val().split(","), function (a, b) {
                                PFIDS.push(returnNumeric(b));
                            });
                            var pfGrandTotal = 0;
                            if (PFIDS.length > 0)

                                ///////get month wise sum
                                var monthidsSum = [];
                            $.each(GrossMonthlySalaryArray, function (i, va) {
                                if (PFIDS.indexOf(va.headid) > -1) {

                                    var currItemM = [];
                                    currItemM["monthid"] = va.month;
                                    currItemM["amount"] = va.amount;
                                    ////////if month already inserted or not
                                    var insert = true;

                                    $.each(monthidsSum, function (j, vamonth) {
                                        if (vamonth.monthid == va.month) {
                                            vamonth.amount = parseFloat(vamonth.amount) + parseFloat(va.amount);
                                            insert = false;
                                        }
                                    });

                                    if (insert)
                                        monthidsSum.push(currItemM);
                                }
                            });

                            $.each(monthidsSum, function (i, va) {
                                if (PFLimit == 0) {
                                    pfGrandTotal += ((va.amount * PFPer) / 100);
                                }
                                else {
                                    pfGrandTotal += (((va.amount <= PFLimit ? va.amount : PFLimit) * PFPer) / 100);
                                }

                            });
                            $(".spanwithno ", $(this).closest("tr")).html(Math.round(pfGrandTotal));

                        } else {
                            $(".spanwithno ", $(this).closest("tr")).html("0");

                        }
                    }
                });
            //}

            //////////
            ///////////////getTotalCal 1 for month gross salary point1
            ///////////////getTotalCal 2 for perquisites point1
            ///////////////getTotalCal 3 for gross salary total point1 
            ///////////////getTotalCal 4 for section10 point2
            ///////////////getTotalCal 5 for profession tax point4
            ///////////////getTotalCal 6 for total of professtion tax point 4
            ///////////////getTotalCal 7 for total of deductions point 4
            ///////////////getTotalCal 8 for deductions a,b point 4
            ///////////////getTotalCal 9 for rebate 80 c sub total
            ///////////////getTotalCal 10 for section 80 cc and section 80ccd and rebte totat in point 9
            ///////////////getTotalCal 11 for point 9 total
            ///////////////getTotalCal 12 for total deductions point 10 total
            //debugger
            for (s = 1; s <= 12; s++) {
                $(".getTotalCal" + s).each(function () {
                    if ($(this).data("getclasstotal") != undefined) {
                        var clasSName = '.' + $(this).data("getclasstotal");
                        var gTotal = 0;
                        $(clasSName).each(function () {
                            var curr = 0;
                            if ($(this).prop("nodeName") == "SPAN")
                            { curr = $(this).html(); }
                            if ($(this).prop("nodeName") == "INPUT")
                            { curr = $(this).val(); }

                            if (isNaN(curr) || curr == '' || curr == undefined)
                            { curr = 0; }

                            gTotal += parseFloat(curr);
                        });
                        $(".getTotalCal" + s).html(Math.round(gTotal));
                    }
                });
            }
            var Sec115Amt = 0;
            //$("#txtSection10SH").html(Sec115Amt);
            $("#txtDeductionsSH").html('0');
            /////point 9 total  80C + 80CCC + 80CCD(1) = 150000

            //if (returnNumeric($("#lblpftotalgrid").html()) > returnNumeric($("#txtRebate80QlfySalLimit").html())) {
            //    var onev = returnNumeric($("#txtRebate80CCD21b").val());
            //    var twov = returnNumeric($("#txtRebate80CCD2").val());
            //    $(".getTotalCal11").html(onev + twov + returnNumeric($("#txtRebate80QlfySalLimit").html()));
            //}
            $("#txtRebate80C").val($(".getTotalCal9 ").html());
            var CC = $("#txtRebate80C").val();
            $("#txtRebate80C_Ded").val(CC);
            var onev = returnNumeric($("#txtRebate80C_Ded").val());
            if (onev > returnNumeric($("#txtRebate80QlfySalLimit").html())) {
                onev = 150000;
                $("#txtRebate80C_Ded").val(onev);
            }
            CC = 0;
            CC = $("#txtRebate80CCC").val();
            $("#txtRebate80CCC_Ded").val(CC);
            CC = 0;
            CC = $("#txtReb80CCD").val();
            $("#txtReb80CCD_Ded").val(CC);
            var twov = returnNumeric($("#txtRebate80CCC_Ded").val());
            var thr = returnNumeric($("#txtReb80CCD_Ded").val());
            var q = onev + twov;

            if (returnNumeric($("#txtRebate80QlfySalLimit").html()) < returnNumeric(q)) {
                $(".getTotalCal10").html($("#txtRebate80QlfySalLimit").html());
                q = returnNumeric($("#txtRebate80QlfySalLimit").html()) - onev;

                $("#txtRebate80CCC_Ded").val(q);
                q = returnNumeric($("#txtRebate80QlfySalLimit").html());
            }
            else {
                $(".getTotalCal10").html(q);

            }
            var j = 0;
            var j = q + thr;
            if (returnNumeric($("#txtRebate80QlfySalLimit").html()) < returnNumeric(j)) {
                $(".getTotalCal10").html($("#txtRebate80QlfySalLimit").html());
                q = returnNumeric($("#txtRebate80QlfySalLimit").html()) - q;

                $("#txtReb80CCD_Ded").val(q);
            }
            else {
                $(".getTotalCal10").html(j);
            }

            ////////////////////// CCD1B & CCD2 Calculation
            onev = 0;
            twov = 0;
            CC = 0;
            CC = $("#txtRebate80CCD21b").val();
            $("#txtRebate80CCD21b_Ded").val(CC);
            CC = 0;
            CC = $("#txtRebate80CCD2").val();
            $("#txtRebate80CCD2_Ded").val(CC);
            onev = returnNumeric($("#txtRebate80CCD21b_Ded").val());
            twov = returnNumeric($("#txtRebate80CCD2_Ded").val());
            q = returnNumeric($(".getTotalCal10").html()) + onev + twov;
            //$(".getTotalCal11").html(q);
            $("#txtSection80CVariousInvestments").html(q);
            $("#txtSection80CVariousInvestmentsSH").html(twov);


            onev = 0;
            twov = 0;
            CC = 0;
            CC = $("#txtRebate80D").val();
            if (CC < parseFloat($("#txtRebate80D_Ded").val())) {
                $("#txtRebate80D_Ded").val(CC);
            }

            onev = 0;
            twov = 0;
            CC = 0;
            CC = $("#txtRebate80DD").val();
            if (CC < parseFloat($("#txtRebate80DD").val()))
            { $("#txtRebate80DD_Ded").val(CC); }

            onev = 0;
            twov = 0;
            CC = 0;
            CC = $("#txtRebate80DDB").val();
            if (CC < parseFloat($("#txtRebate80DDB").val()))
            { $("#txtRebate80DDB_Ded").val(CC); }

            onev = 0;
            twov = 0;
            CC = 0;
            CC = $("#txtRebate80QQB").val();
            if (CC < parseFloat($("#txtRebate80QQB").val()))
            { $("#txtRebate80QQB_Ded").val(CC); }

            onev = 0;
            twov = 0;
            CC = 0;
            CC = $("#txtRebate80E").val();
            if (CC < parseFloat($("#txtRebate80E").val()))
            { $("#txtRebate80E_Ded").val(CC); }

            onev = 0;
            twov = 0;
            CC = 0;
            CC = $("#txtRebate80EE").val();
            if (CC < parseFloat($("#txtRebate80EE").val()))
            { $("#txtRebate80EE_Ded").val(CC); }

            //onev = 0;
            //twov = 0;
            //CC = 0;
            //q = 0;
            //q = $("#txtRebate80GG_Qlfy").val();
            //CC = $("#txtRebate80GG").val();
            //if (CC > q)
            //{
            //    CC = q;
            //}
            //$("#txtRebate80GG_Ded").val(CC);
            //onev = 0;
            //twov = 0;
            //CC = 0;

            //q = 0;
            //q = $("#txtRebate80G_Qlfy").val();
            //CC = $("#txtRebate80G").val();

            //if (CC > q) {
            //    CC = q;
            //}
            //$("#txtRebate80G_Ded").val(CC);


            //onev = 0;
            //twov = 0;
            //CC = 0;
            //q = 0;
            //q = $("#txtRebate80GGA_Qlfy").val();
            //CC = $("#txtRebate80GGA").val();
            //if (CC > q) {
            //    CC = q;
            //}
            //$("#txtRebate80GGA_Ded").val(CC);

            //onev = 0;
            //twov = 0;
            //CC = 0;
            //q = 0;
            //q = $("#txtRebate80GGC_Qlfy").val();
            //CC = $("#txtRebate80GGC").val();
            //if (CC > q) {
            //    CC = q;
            //}
            //$("#txtRebate80GGC_Ded").val(CC);

            //onev = 0;
            //twov = 0;
            //CC = 0;
            //q = 0;
            //q = $("#txtRebate80RRB_Qlfy").val();
            //CC = $("#txtRebate80RRB").val();
            //if (CC > q) {
            //    CC = q;
            //}
            //$("#txtRebate80RRB_Ded").val(CC);

            //onev = 0;
            //twov = 0;
            //CC = 0;
            //q = 0;
            //q = $("#txtRebate80RRB_Qlfy").val();
            //CC = $("#txtRebate80U").val();
            //if (CC > q) {
            //    CC = q;
            //}
            //$("#txtRebate80U_Ded").val(CC);

            //onev = 0;
            //twov = 0;
            //CC = 0;
            //q = 0;
            //q = $("#txtRebate80CCG_Qlfy").val();
            //CC = $("#txtRebate80CCG").val();
            //if (CC > q) {
            //    CC = q;
            //}
            //$("#txtRebate80CCG_Ded").val(CC);

            //onev = 0;
            //twov = 0;
            //CC = 0;
            //q = 0;
            //q = $("#txtRebate80TTA_Qlfy").val();
            //CC = $("#txtRebate80TTA").val();
            //if (CC > q) {
            //    CC = q;
            //}
            //$("#txtRebate80TTA_Ded").val(CC);


            //////////final Calculation()
            TDSComputationFronTableCalculation();
            
            //setNumericFormat();
        }

        ///////////////////////////////////////////////////////TDS Front Calculation start
        function TDSComputationFronTableCalculation() {
            var Err = 0;
            var point1 = $("[id*=txtGrossSalary]").html(); ///point 1
            var point2 = $("[id*=txtSection10]").html(); ///point 2
            var point3 = $("[id*=txtTaxableBalance]").html(); ///point 3
            var point4 = $("[id*=txtDeductions]").html(); ///point 4
            var point5 = $("[id*=txtIncomecharge]").html(); ///point 5
            var point6 = $("[id*=txtOtherIncome]").val(); ///point 6
            var point7 = $("[id*=txtHousingLoan]").val(); ///point 7
            var point8 = $("[id*=txtGrossTotalIncome]").html(); ///point 8
            if (parseFloat(point1) == 0)
            {
                PointZero(1);
                return;
            }
            ////////////point 3 calculation (Balance)
            point3 = (returnNumeric(point1) - returnNumeric(point2)) + returnNumeric($("[id*=txtPreviousTaxableSalary]").val());
            ///////////point 5 Income chargeable under the head Salaries

            point5 = returnNumeric(point3) - returnNumeric(point4);
            
            if (parseFloat(point5) < 0) {
                PointZero(5);
                 
                return;
            }
            $("[id*=txtIncomecharge]").html(point5);
            ///////////point  8 Gross Total Income
            point8 = (returnNumeric(point5) + returnNumeric(point6)) - returnNumeric(point7);
            


            if (parseFloat(point8) < 0) {
                PointZero(8);
                
                return;
            }
            else {
                $("[id*=txtGrossTotalIncome]").html(point8);
                var point9 = $("[id*=txtSection80CVariousInvestments]").html(); ///point 9
                if ($("[id*=txtNetIncome]").html() < 0) {
                    $("[id*=lblAggregateoftax]").html(0);
                    $("[id*=txtNetIncome]").html(0);
                    PointZero_I115(8);
                }
                var point10 = $("[id*=txtAggregateoftaxrebates]").html(); ///point 10
                var point11 = $("[id*=lblAggregateoftax]").html(); ///point 11
                var point12 = $("[id*=txtNetIncome]").html(); ///point 12
                var point13 = $("[id*=txtTaxonTotalIncome]").html(); ///point 13
                var point14 = $("[id*=txtRebate87A]").html(); ///point 14
                var point15 = $("[id*=txtTaxPayableAndSurcharge]").html(); ///point 15
                var pointSur = $("[id*=txtSurcharge]").html(); ///point 15
                var point16 = $("[id*=txtEducationCess]").html(); ///point 16
                var point17 = $("[id*=txtTaxPay]").html(); ///point 17
                var point18 = $("[id*=txtUnderSection89]").val(); ///point 18
                var point19 = $("[id*=txtTaxDeductedAtSource]").html(); ///point 19
                var point20 = $("[id*=txtTaxDeductedbyPreEmployer]").val(); ///point 20
                var point21 = $("[id*=lastpayabletax]").html(); ///point 21

            }



            ///////////point 11 Aggregate of tax rebates and relief
            point11 = returnNumeric(point9) + returnNumeric(point10);

            //////////point 12 Net Income
            point12 = returnNumeric(point8) - returnNumeric(point11);

            /////////////point 13 income tax slab calcaluation
            point13 = IncometaxSlabCalculation(point12);

            //////////point 14 87 A
            var RebateLimits = jQuery.parseJSON($("[id*=hdnAllRebateLimits]").val());
            var limitfor87A = 0;
            var sded = 0;
            var Sallimitfor87A = 0;
            $.each(RebateLimits, function (i, va) {
                if (va.Rebate_Name == "Rebate87A") {
                    limitfor87A = va.Rebate_Limit;
                    Sallimitfor87A = va.Salary_Limit;
                }

            });

            if (parseFloat(point12) <= Sallimitfor87A) {
                if (parseFloat(point13) >= parseFloat(limitfor87A))
                { point14 = limitfor87A; }
                else { point14 = point13; }
            } else { point14 = 0; }
            point14 = Math.round(point14);

            ///////////point 15 16 17 18 calculation related details
            var hdnSurcharge = 0, hdnCessPer = 0, hdnHcessper = 0, hdnHealthPer = 0;
            $.each(Emp.LtblEmployeeTDSReletatedOtherDetails, function (i, va) { hdnSurcharge = va.SurchargePer; hdnCessPer = va.Cessper; hdnHcessper = va.HCessper; hdnHealthPer = va.HealthPer });

            //////////point 15 Tax payable and surcharge
            point15 = parseFloat(point13) - parseFloat(point14);
            var Fyr = '';
            var surchargeType = '';
            if (point12 > 0) {
                Fyr = $("[id*=ddlFinancialYear] :selected").text();
                if (parseFloat(Fyr.substring(0, 4)) > 2016) {
                    if (parseFloat(Fyr.substring(0, 4)) < 2019) {
                        var sslab1 = SurSlab[0];
                        var sslab2 = SurSlab[1];
                        $("[id*=hdnSurchargePercentage]").val(0);
                        if (point12 >= SurSlab[0].SurchargeSalary && point12 < SurSlab[1].SurchargeSalary) {
                            $("[id*=hdnSurchargePercentage]").val(SurSlab[0].SurchargePer);

                        }
                        else if (point12 > sslab2.SurchargeSalary) {
                            $("[id*=hdnSurchargePercentage]").val(SurSlab[1].SurchargePer);

                        }
                    }
                    else if (parseFloat(Fyr.substring(0, 4)) == 2019) {
                        var Marginal = 0;
                        $("[id*=hdnSurchargePercentage]").val(0);
                        if (point12 >= SurSlab[0].SurchargeSalary && point12 < SurSlab[1].SurchargeSalary) {
                            if (SurSlab[1].Surchargetype == 'Marginal') {
                                surchargeType = 'Marginal';
                                Marginal = SurSlab[1].Marginal_Surcharge;

                            }
                            else {
                                $("[id*=hdnSurchargePercentage]").val(SurSlab[1].SurchargePer);
                            }

                        }
                        else if (point12 >= SurSlab[1].SurchargeSalary && point12 < SurSlab[2].SurchargeSalary) {
                            if (SurSlab[2].Surchargetype == 'Marginal') {
                                Marginal = SurSlab[2].Marginal_Surcharge;
                                surchargeType = 'Marginal';

                            }
                            else {
                                $("[id*=hdnSurchargePercentage]").val(SurSlab[2].SurchargePer);
                            }

                        }
                        else if (point12 >= SurSlab[2].SurchargeSalary && point12 < SurSlab[3].SurchargeSalary) {
                            if (SurSlab[3].Surchargetype == 'Marginal') {
                                Marginal = SurSlab[3].Marginal_Surcharge;
                                surchargeType = 'Marginal';
                            }
                            else {
                                $("[id*=hdnSurchargePercentage]").val(SurSlab[3].SurchargePer);
                            }

                        }
                        else if (point12 > SurSlab[3].SurchargeSalary && point12 < SurSlab[4].SurchargeSalary) {
                            if (SurSlab[4].Surchargetype == 'Marginal') {
                                Marginal = SurSlab[4].Marginal_Surcharge;
                                surchargeType = 'Marginal';
                            }
                            else {
                                $("[id*=hdnSurchargePercentage]").val(SurSlab[4].SurchargePer);
                            }

                        }
                        else if (point12 > SurSlab[4].SurchargeSalary && point12 < SurSlab[5].SurchargeSalary) {
                            if (SurSlab[5].Surchargetype == 'Marginal') {
                                Marginal = SurSlab[5].Marginal_Surcharge;
                                surchargeType = 'Marginal';
                            }
                            else {
                                $("[id*=hdnSurchargePercentage]").val(SurSlab[5].SurchargePer);
                            }

                        }
                        //else if (point12 > SurSlab[5].SurchargeSalary && point12 < SurSlab[6].SurchargeSalary) {
                        //    if (SurSlab[6].Surchargetype == 'Marginal') {
                        //        Marginal = SurSlab[6].Marginal_Surcharge;
                        //        surchargeType = 'Marginal';
                        //    }
                        //    else {
                        //        $("[id*=hdnSurchargePercentage]").val(SurSlab[6].SurchargePer);
                        //    }

                        //}
                        //else if (point12 > SurSlab[7].SurchargeSalary && point12 < SurSlab[8].SurchargeSalary) {
                        //    if (SurSlab[8].Surchargetype == 'Marginal') {
                        //        Marginal = SurSlab[8].Marginal_Surcharge;
                        //        surchargeType = 'Marginal';
                        //    }
                        //    else {
                        //        $("[id*=hdnSurchargePercentage]").val(SurSlab[8].SurchargePer);
                        //    }

                        //}
                        //else if (point12 > SurSlab[8].SurchargeSalary) {
                        //    if (SurSlab[6].Surchargetype == 'Marginal') {
                        //        Marginal = SurSlab[6].Marginal_Surcharge;
                        //        surchargeType = 'Marginal';
                        //    }
                        //    else {
                        //        $("[id*=hdnSurchargePercentage]").val(SurSlab[9].SurchargePer);
                        //    }

                        //}

                        Surcharge = 0;
                        //// var surchargeType = $("[id*=hdnSurchargeType]").val();
                        //var surchargeType = Emp.sur_type;;
                        //////////// Surcharge Type Normal or Marginal
                        if (surchargeType == "Marginal") {
                            //  point15 = point15 + (((point12 - 5000000) * 70) / 100);
                            point15 = point15 + Marginal;
                            //Surcharge = ((point12 - 5000000) * 70) / 100;
                            Surcharge = Marginal;
                        }
                        else { ////normal\
                            point15 = point15 + ((point13 * parseFloat($("[id*=hdnSurchargePercentage]").val())) / 100);
                            Surcharge = point13 * parseFloat($("[id*=hdnSurchargePercentage]").val()) / 100;
                        }
                        Surcharge = Math.round(Surcharge);

                    }
                    else { ////// 20_21 onwards

                        var diffAmt = 0;
                        var basicAddTax = 0;
                        var basicTax = 0;
                        var mRelif = 0;

                        if (parseFloat(SurSlab[0].SurchargeSalary) < parseFloat(point12)) {
                            ///// Calculating Basic Tax for Marginal surcharge 
                            basicTax = IncometaxSlabCalculation(SurSlab[0].SurchargeSalary);
                            diffAmt = parseFloat(point12) - parseFloat(SurSlab[0].SurchargeSalary);
                            basicAddTax = parseFloat(basicTax) + parseFloat(diffAmt);
                        }
                        //// Calculating surcharge 
                        var Marginal = 0;
                        $("[id*=hdnSurchargePercentage]").val(0);
                        if (point12 >= SurSlab[0].SurchargeSalary && point12 < SurSlab[1].SurchargeSalary) {
                            $("[id*=hdnSurchargePercentage]").val(SurSlab[1].SurchargePer);
                        }
                        else if (point12 >= SurSlab[1].SurchargeSalary && point12 < SurSlab[2].SurchargeSalary) {

                            $("[id*=hdnSurchargePercentage]").val(SurSlab[2].SurchargePer);
                        }
                        else if (point12 >= SurSlab[2].SurchargeSalary && point12 < SurSlab[3].SurchargeSalary) {

                            $("[id*=hdnSurchargePercentage]").val(SurSlab[3].SurchargePer);
                        }
                        else if (point12 > SurSlab[3].SurchargeSalary && point12 < SurSlab[4].SurchargeSalary) {

                            $("[id*=hdnSurchargePercentage]").val(SurSlab[4].SurchargePer);
                        }
                        else if (point12 > SurSlab[4].SurchargeSalary) {

                            $("[id*=hdnSurchargePercentage]").val(SurSlab[5].SurchargePer);
                        }

                        // point15 = point15 + ((point13 * parseFloat($("[id*=hdnSurchargePercentage]").val())) / 100);
                        Surcharge = point13 * parseFloat($("[id*=hdnSurchargePercentage]").val()) / 100;
                        if (SurSlab[0].SurchargeSalary < point12) {
                            ///// Calculating Basic Tax for Marginal surcharge 
                            var totSur = 0;
                            totSur = parseFloat(Surcharge) + parseFloat(point13);
                            mRelif = parseFloat(totSur) - parseFloat(basicAddTax);
                            //// Marginal Relif  appicable
                            if (parseFloat(mRelif) > 0 && parseFloat(mRelif) < Surcharge) {
                                Surcharge = parseFloat(Surcharge) - parseFloat(mRelif);
                                Surcharge = Math.round(Surcharge);
                            }
                            Surcharge = Math.round(Surcharge);
                           // point15 = point15 + parseFloat(Surcharge);
                            pointSur =  parseFloat(Surcharge);
                        }

                    }


                }
                else {

                  //  point15 = point15 + ((point13 * parseFloat($("[id*=hdnSurchargePercentage]").val())) / 100);
                    pointSur = ((point13 * parseFloat($("[id*=hdnSurchargePercentage]").val())) / 100);
                   
                }

                point15 = Math.round(point15);

                //////////point 16 (a) Health & Education Cess
                var CAmt = 0;
                CAmt = Math.round((parseFloat(point15) * parseFloat(hdnCessPer)) / 100);

                /////////point 17 (b)Higher Education Cess
                var Cess = 0;
                Cess = parseFloat(hdnHcessper) + parseFloat(hdnHealthPer)
                CAmt = CAmt +  Math.round((parseFloat(point15) * parseFloat(Cess)) / 100);
                //HeathCess = hdnHealthPer;
                point16 = CAmt;
                /////////point 17(b) Health Cess
                //point17 = point17 + Math.round((parseFloat(point15) * parseFloat(hdnHealthPer)) / 100);
                point17 = (returnNumeric(point15) + returnNumeric(pointSur) + returnNumeric(point16));
                point21 = (returnNumeric(point17)) - (returnNumeric(point18) + returnNumeric(point19) + returnNumeric(point20));

                ////////////set values
                $("[id*=txtTaxableBalance]").html(point3); ///point 3
                $("[id*=txtIncomecharge]").html(point5); ///point 5
                $("[id*=txtGrossTotalIncome]").html(point8); ///point 8
                $("[id*=lblAggregateoftax]").html(point11); ///point 11
                $("[id*=txtNetIncome]").html(point12); ///point 12
                $("[id*=txtTaxonTotalIncome]").html(point13); ///point 13
                $("[id*=txtRebate87A]").html(point14); ///point 14
                //$("[id*=txtTaxPayableAndSurcharge]").html(point15); ///point 15
                $("[id*=txtEducationCess]").html(point16); ///point 16
                $("[id*=txtTaxPay]").html(point17); ///point 17
                $("[id*=lastpayabletax]").html(point21); ///point 21
                $("[id*=txtTaxPayableAndSurcharge]").html(point15); ///point 15
                $("[id*=txtSurcharge]").html(pointSur); ///point 15

                TDSComputation_115BAC_Calculation();

                if (Rfsh == 'True') {
                    if ($('.MastermodalBackground2').is(":visible") == false) {
                        SaveEmployeeComputation();
                    }
                }

            }
        }

        function TDSComputation_115BAC_Calculation() {
            var Err = 0;
            var point1 = $("[id*=txtGrossSalarySH]").html(); ///point 1
            var point2 = $("[id*=txtSection10SH]").html(); ///point 2
            var point3 = $("[id*=txtTaxableBalanceSH]").html(); ///point 3
            var point4 = $("[id*=txtDeductionsSH]").html(); ///point 4
            var point5 = $("[id*=txtIncomechargeSH]").html(); ///point 5
            var point6 = $("[id*=txtOtherIncome]").val(); ///point 6
            var point7 = $("[id*=txtHousingLoan]").val(); ///point 7
            var point8 = $("[id*=txtGrossTotalIncomeSH]").html(); ///point 8
            if (parseFloat(point1) == 0) {
                PointZero_I115(1);
                return;
            }
            ////////////point 3 calculation (Balance)
            point3 = (returnNumeric(point1) - returnNumeric(point2)) + returnNumeric($("[id*=txtPreviousTaxableSalary]").val());
            ///////////point 5 Income chargeable under the head Salaries

            point5 = returnNumeric(point3) - returnNumeric(point4);

            if (parseFloat(point5) < 0) {
                PointZero_I115(5);
                return;
            }
            $("[id*=txtIncomechargeSH]").html(point5);
            ///////////point  8 Gross Total Income
            point8 = (returnNumeric(point5) + returnNumeric(point6)) - returnNumeric(point7);



            if (parseFloat(point8) < 0) {
                PointZero_I115(8);
                return;
            }
            else {
                $("[id*=txtGrossTotalIncomeSH]").html(point8);
                var point9 = $("[id*=txtSection80CVariousInvestmentsSH]").html(); ///point 9
                if ($("[id*=txtNetIncomeSH]").html() < 0) {
                    $("[id*=lblAggregateoftaxSH]").html(0);
                    $("[id*=txtNetIncomeSH]").html(0);
                    PointZero_I115(8);
                }




                var point10 = $("[id*=txtAggregateoftaxrebatesSH]").html(); ///point 10
                var point11 = $("[id*=lblAggregateoftaxSH]").html(); ///point 11\
                //////////point 12 Net Income
                point12 = returnNumeric(point8) - returnNumeric(point11);
                $("[id*=txtNetIncomeSH]").html(point12);
                //var point12 = $("[id*=txtNetIncomeSH]").html(); ///point 12
                var point13 = $("[id*=txtTaxonTotalIncomeSH]").html(); ///point 13
                var point14 = $("[id*=txtRebate87ASH]").html(); ///point 14
                var point15 = $("[id*=txtTaxPayableAndSurchargeSH]").html(); ///point 15
                var pointSur = $("[id*=txtSurchargeSH]").html(); ///point 15
                var point16 = $("[id*=txtEducationCessSH]").html(); ///point 16
                var point17 = $("[id*=txtTaxPaySH]").html(); ///point 17
                var point18 = $("[id*=txtUnderSection89]").val(); ///point 18
                var point19 = $("[id*=txtTaxDeductedAtSourceSH]").html(); ///point 19
                var point20 = $("[id*=txtTaxDeductedbyPreEmployer]").val(); ///point 20
                var point21 = $("[id*=lastpayabletaxSH]").html(); ///point 21

            }
            if (point15 == undefined) {
                point15 = 0;
            }
            if (point16 == undefined) {
                point16 = 0;
            }
            if (point17 == undefined) {
                point17 = 0;
            }
            if (point18 == undefined) {
                point18 = 0;
            }
            if (point19 == undefined) {
                point19 = 0;
            }
            if (point20 == undefined) {
                point20 = 0;
            }
            ///////////point 11 Aggregate of tax rebates and relief
            point11 = returnNumeric(point9) + returnNumeric(point10);

            //////////point 12 Net Income
            point12 = returnNumeric(point8) - returnNumeric(point11);

            /////////////point 13 income tax slab calcaluation
            point13 = Incometax_115_Calculation(point12);

            //////////point 14 87 A
            var RebateLimits = jQuery.parseJSON($("[id*=hdnAllRebateLimits]").val());
            var limitfor87A = 0;
            var sded = 0;
            var Sallimitfor87A = 0;
            $.each(RebateLimits, function (i, va) {
                if (va.Rebate_Name == "Rebate87A") {
                    limitfor87A = va.Rebate_Limit;
                    Sallimitfor87A = va.Salary_Limit;
                }

            });

            if (parseFloat(point12) <= Sallimitfor87A) {
                if (parseFloat(point13) >= parseFloat(limitfor87A))
                { point14 = limitfor87A; }
                else { point14 = point13; }
            } else { point14 = 0; }
            point14 = Math.round(point14);

            ///////////point 15 16 17 18 calculation related details
            var hdnSurcharge = 0, hdnCessPer = 0, hdnHcessper = 0, hdnHealthPer = 0;
            $.each(Emp.LtblEmployeeTDSReletatedOtherDetails, function (i, va) { hdnSurcharge = va.SurchargePer; hdnCessPer = va.Cessper; hdnHcessper = va.HCessper; hdnHealthPer = va.HealthPer });

            //////////point 15 Tax payable and surcharge
            point15 = parseFloat(point13) - parseFloat(point14);
            var Fyr = '';
            var surchargeType = '';
            if (point12 > 0) {
                Fyr = $("[id*=ddlFinancialYear] :selected").text();
                if (parseFloat(Fyr.substring(0, 4)) > 2016) {
                    if (parseFloat(Fyr.substring(0, 4)) < 2019) {
                        var sslab1 = SurSlab[0];
                        var sslab2 = SurSlab[1];
                        $("[id*=hdnSurchargePercentage]").val(0);
                        if (point12 >= SurSlab[0].SurchargeSalary && point12 < SurSlab[1].SurchargeSalary) {
                            $("[id*=hdnSurchargePercentage]").val(SurSlab[0].SurchargePer);

                        }
                        else if (point12 > sslab2.SurchargeSalary) {
                            $("[id*=hdnSurchargePercentage]").val(SurSlab[1].SurchargePer);

                        }
                    }
                    else if (parseFloat(Fyr.substring(0, 4)) == 2019) {
                        var Marginal = 0;
                        $("[id*=hdnSurchargePercentage]").val(0);
                        if (point12 >= SurSlab[0].SurchargeSalary && point12 < SurSlab[1].SurchargeSalary) {
                            if (SurSlab[1].Surchargetype == 'Marginal') {
                                surchargeType = 'Marginal';
                                Marginal = SurSlab[1].Marginal_Surcharge;

                            }
                            else {
                                $("[id*=hdnSurchargePercentage]").val(SurSlab[1].SurchargePer);
                            }

                        }
                        else if (point12 >= SurSlab[1].SurchargeSalary && point12 < SurSlab[2].SurchargeSalary) {
                            if (SurSlab[2].Surchargetype == 'Marginal') {
                                Marginal = SurSlab[2].Marginal_Surcharge;
                                surchargeType = 'Marginal';

                            }
                            else {
                                $("[id*=hdnSurchargePercentage]").val(SurSlab[2].SurchargePer);
                            }

                        }
                        else if (point12 >= SurSlab[2].SurchargeSalary && point12 < SurSlab[3].SurchargeSalary) {
                            if (SurSlab[3].Surchargetype == 'Marginal') {
                                Marginal = SurSlab[3].Marginal_Surcharge;
                                surchargeType = 'Marginal';
                            }
                            else {
                                $("[id*=hdnSurchargePercentage]").val(SurSlab[3].SurchargePer);
                            }

                        }
                        else if (point12 > SurSlab[3].SurchargeSalary && point12 < SurSlab[4].SurchargeSalary) {
                            if (SurSlab[4].Surchargetype == 'Marginal') {
                                Marginal = SurSlab[4].Marginal_Surcharge;
                                surchargeType = 'Marginal';
                            }
                            else {
                                $("[id*=hdnSurchargePercentage]").val(SurSlab[4].SurchargePer);
                            }

                        }
                        else if (point12 > SurSlab[4].SurchargeSalary && point12 < SurSlab[5].SurchargeSalary) {
                            if (SurSlab[5].Surchargetype == 'Marginal') {
                                Marginal = SurSlab[5].Marginal_Surcharge;
                                surchargeType = 'Marginal';
                            }
                            else {
                                $("[id*=hdnSurchargePercentage]").val(SurSlab[5].SurchargePer);
                            }

                        }


                        Surcharge115 = 0;
                        //// var surchargeType = $("[id*=hdnSurchargeType]").val();
                        //var surchargeType = Emp.sur_type;;
                        //////////// Surcharge Type Normal or Marginal
                        if (surchargeType == "Marginal") {
                            //  point15 = point15 + (((point12 - 5000000) * 70) / 100);
                            point15 = point15 + Marginal;
                            //Surcharge = ((point12 - 5000000) * 70) / 100;
                            Surcharge115 = Marginal;
                        }
                        else { ////normal\
                            //point15 = point15 + ((point13 * parseFloat($("[id*=hdnSurchargePercentage]").val())) / 100);
                            Surcharge115 = point13 * parseFloat($("[id*=hdnSurchargePercentage]").val()) / 100;
                        }


                    }
                    else { ////// 20_21 onwards

                        var diffAmt = 0;
                        var basicAddTax = 0;
                        var basicTax = 0;
                        var mRelif = 0;

                        if (parseFloat(SurSlab[0].SurchargeSalary) < parseFloat(point12)) {
                            ///// Calculating Basic Tax for Marginal surcharge 
                            basicTax = Incometax_115_Calculation(SurSlab[0].SurchargeSalary);
                            diffAmt = parseFloat(point12) - parseFloat(SurSlab[0].SurchargeSalary);
                            basicAddTax = parseFloat(basicTax) + parseFloat(diffAmt);
                        }
                        //// Calculating surcharge 
                        var Marginal = 0;
                        $("[id*=hdnSurchargePercentage]").val(0);
                        if (point12 >= SurSlab[0].SurchargeSalary && point12 < SurSlab[1].SurchargeSalary) {
                            $("[id*=hdnSurchargePercentage]").val(SurSlab[1].SurchargePer);
                        }
                        else if (point12 >= SurSlab[1].SurchargeSalary && point12 < SurSlab[2].SurchargeSalary) {

                            $("[id*=hdnSurchargePercentage]").val(SurSlab[2].SurchargePer);
                        }
                        else if (point12 >= SurSlab[2].SurchargeSalary && point12 < SurSlab[3].SurchargeSalary) {

                            $("[id*=hdnSurchargePercentage]").val(SurSlab[3].SurchargePer);
                        }
                        else if (point12 > SurSlab[3].SurchargeSalary && point12 < SurSlab[4].SurchargeSalary) {

                            $("[id*=hdnSurchargePercentage]").val(SurSlab[4].SurchargePer);
                        }
                        else if (point12 > SurSlab[4].SurchargeSalary) {

                            $("[id*=hdnSurchargePercentage]").val(SurSlab[5].SurchargePer);
                        }

                        // point15 = point15 + ((point13 * parseFloat($("[id*=hdnSurchargePercentage]").val())) / 100);
                        Surcharge115 = point13 * parseFloat($("[id*=hdnSurchargePercentage]").val()) / 100;
                        if (SurSlab[0].SurchargeSalary < point12) {
                            ///// Calculating Basic Tax for Marginal surcharge 
                            var totSur = 0;
                            totSur = parseFloat(Surcharge115) + parseFloat(point13);
                            mRelif = parseFloat(totSur) - parseFloat(basicAddTax);
                            //// Marginal Relif  appicable
                            if (parseFloat(mRelif) > 0 && parseFloat(mRelif) < Surcharge115) {
                                Surcharge115 = parseFloat(Surcharge115) - parseFloat(mRelif);
                                Surcharge115 = Math.round(Surcharge115);
                            }
                            //point15 = point15 + parseFloat(Surcharge115);
                            pointSur =  parseFloat(Surcharge115);
                        }

                    }


                }
                else {
                    //var surchargeType = $("[id*=hdnSurchargeType]").val();
                    //if (surchargeType == "Marginal") {
                    //    point15 = point15 + (((point12 - 5000000) * 70) / 100);
                    //}
                    //else { ////normal
                    //point15 = point15 + ((point13 * parseFloat($("[id*=hdnSurchargePercentage]").val())) / 100);
                    pointSur = ((point13 * parseFloat($("[id*=hdnSurchargePercentage]").val())) / 100);
                    //}
                }

                point15 = Math.round(point15);

                //////////point 16 (a)Health & Education Cess
                var CAmt = 0

                CAmt = Math.round((parseFloat(point15) * parseFloat(hdnCessPer)) / 100);

                /////////point 17 (b)Higher Education Cess
                var Cess = 0;

                Cess = parseFloat(hdnHcessper) + parseFloat(hdnHealthPer)
                CAmt = CAmt + Math.round((parseFloat(point15) * parseFloat(Cess)) / 100);
                //HeathCess = hdnHealthPer;

                point16 = CAmt;

                point17 = (returnNumeric(point15) + returnNumeric(pointSur) + returnNumeric(point16))
                /////////point 17(b) Health Cess
                //point17 = point17 + Math.round((parseFloat(point15) * parseFloat(hdnHealthPer)) / 100);

                point21 = (returnNumeric(point17)) - (returnNumeric(point18) + returnNumeric(point19) + returnNumeric(point20));

                ////////////set values
                $("[id*=txtTaxableBalanceSH]").html(point3); ///point 3
                $("[id*=txtIncomechargeSH]").html(point5); ///point 5
                $("[id*=txtGrossTotalIncomeSH]").html(point8); ///point 8
                $("[id*=lblAggregateoftaxSH]").html(point11); ///point 11
                $("[id*=txtNetIncomeSH]").html(point12); ///point 12
                $("[id*=txtTaxonTotalIncomeSH]").html(point13); ///point 13
                $("[id*=txtRebate87ASH]").html(point14); ///point 14
                $("[id*=txtTaxPayableAndSurchargeSH]").html(point15); ///point 15
                $("[id*=txtSurchargeSH]").html(pointSur); ///point 15
                $("[id*=txtEducationCessSH]").html(point16); ///point 16
                $("[id*=txtTaxPaySH]").html(point17); ///point 17
                $("[id*=lastpayabletaxSH]").html(point21); ///point 21

                if (Rfsh == 'True') {
                    if ($('.MastermodalBackground2').is(":visible") == false) {
                        SaveEmployeeComputation();
                    }
                }

            }
        }

        function PointZero(i)
        {
            if (i == 1)
            {
                $("[id*=txtGrossSalary]").html(0); ///point 1
                $("[id*=txtSection10]").html(0); ///point 2
                $("[id*=txtTaxableBalance]").html(0); ///point 3
                $("[id*=txtDeductions]").html(0);
                $("[id*=txtIncomecharge]").html(0)
                $("[id*=txtOtherIncome]").val(0);
                $("[id*=txtHousingLoan]").val(0);
                $("[id*=txtGrossTotalIncome]").html(0);
            }
            if (i == 5) {

                $("[id*=txtIncomecharge]").html(0)
                $("[id*=txtOtherIncome]").val(0);
                $("[id*=txtHousingLoan]").val(0);
                $("[id*=txtGrossTotalIncome]").html(0); ///point 8
            }

            //}
            if (i == 7)
            {
                $("[id*=txtOtherIncome]").val(0);
                $("[id*=txtHousingLoan]").val(0);
                $("[id*=txtGrossTotalIncome]").html(0); ///point 8
            }
            else if (i == 8)
            {
                $("[id*=txtGrossTotalIncome]").html(0); ///point 8
            }

            $("[id*=lblAggregateoftax]").html(0); ///point 11
            $("[id*=txtNetIncome]").html(0); ///point 12
            $("[id*=txtTaxonTotalIncome]").html(0); ///point 13
            $("[id*=txtRebate87A]").html(0); ///point 14
            $("[id*=txtTaxPayableAndSurcharge]").html(0); ///point 15
            $("[id*=txtEducationCess]").html(0); ///point 16
            $("[id*=txtTaxPay]").html(0); ///point 17
            $("[id*=lastpayabletax]").html(0); ///point 21
            return;
        }

        function PointZero_I115(i) {
            if (i == 1) {
                $("[id*=txtGrossSalarySH]").html(0); ///point 1
                $("[id*=txtSection10SH]").html(0); ///point 2
                $("[id*=txtTaxableBalanceSH]").html(0); ///point 3
                $("[id*=txtDeductionsSH]").html(0);
                $("[id*=txtIncomechargeSH]").html(0)
                $("[id*=txtOtherIncomeSH]").val(0);
                $("[id*=txtHousingLoanSH]").val(0);
                $("[id*=txtGrossTotalIncomeSH]").html(0);
            }
            if (i == 5) {

                $("[id*=txtIncomechargeSH]").html(0)
                $("[id*=txtOtherIncomeSH]").val(0);
                $("[id*=txtHousingLoanSH]").val(0);
                $("[id*=txtGrossTotalIncomeSH]").html(0); ///point 8
            }

            //}
            if (i == 7) {
                $("[id*=txtOtherIncomeSH]").val(0);
                $("[id*=txtHousingLoanSH]").val(0);
                $("[id*=txtGrossTotalIncomeSH]").html(0); ///point 8
            }
            else if (i == 8) {
                $("[id*=txtGrossTotalIncomeSH]").html(0); ///point 8
            }

            $("[id*=lblAggregateoftaxSH]").html(0); ///point 11
            $("[id*=txtNetIncomeSH]").html(0); ///point 12
            $("[id*=txtTaxonTotalIncomeSH]").html(0); ///point 13
            $("[id*=txtRebate87ASH]").html(0); ///point 14
            $("[id*=txtTaxPayableAndSurchargeSH]").html(0); ///point 15
            $("[id*=txtEducationCessSH]").html(0); ///point 16
            $("[id*=txtTaxPaySH]").html(0); ///point 17
            $("[id*=lastpayabletaxSH]").html(0); ///point 21
            return;
        }
        ///////////////////////////////////////////////////////TDS Front Calculation end


        function MonthsalaryEnterKeypressedEvent(curr) {
            if (curr.data("headid") != '' && curr.data('month') != '' && curr.data("headid") != '0' && curr.data('month') != '0') {
                var thisheadid = curr.data("headid");
                var thismonth = curr.data("month");
                var currentRowno = curr.closest('tr').index();
                //var thisheadnm = curr.data("headnm");
                var i = 0;
                var rIndex = 0;
                var IndR = 0;
                $("#tblMonthlySalary input[type=text]").each(function () {
                    IndR = $(this).closest('tr').index();
                    if ($(this).data("headid") == thisheadid && $(this).closest('tr').index() > currentRowno) {

                        $(this).val(parseFloat((curr.val() == '' || curr.val() == undefined || curr.val() == null) ? '0' : curr.val()));
                        if ($(this).data("headnm") == 'Basic') {

                            $("input[name=txtHrr]").each(function () {
                                var row = $(this).closest("tr");
                                rIndex = row.closest('tr').index();
                                if (rIndex == IndR + 1) {
                                    row.find('td:eq(1)').html(curr.val());
                                    return false;
                                }
                            });
                        }
                        if ($(this).data("headnm") == 'DA') {

                            $("input[name=txtHrr]").each(function () {
                                var row = $(this).closest("tr");
                                rIndex = row.closest('tr').index();
                                if (rIndex == IndR + 1) {
                                    row.find('td:eq(2)').html(curr.val());
                                    return false;
                                }
                            });
                        }
                        if ($(this).data("headnm") == 'HRA') {

                            $("input[name=txtHrr]").each(function () {
                                var row = $(this).closest("tr");
                                rIndex = row.closest('tr').index();
                                if (rIndex == IndR + 1) {
                                    row.find('td:eq(3)').html(curr.val());
                                    return false;
                                }
                            });
                        }

                    }
                    else if ($(this).data("headid") == thisheadid && $(this).closest('tr').index() == currentRowno) {
                        if ($(this).data("headnm") == 'Basic') {

                            $("input[name=txtHrr]").each(function () {
                                var row = $(this).closest("tr");
                                rIndex = row.closest('tr').index();
                                if (rIndex == IndR + 1) {
                                    row.find('td:eq(1)').html(curr.val());
                                    return false;
                                }
                            });
                        }
                        if ($(this).data("headnm") == 'DA') {

                            $("input[name=txtHrr]").each(function () {
                                var row = $(this).closest("tr");
                                rIndex = row.closest('tr').index();
                                if (rIndex == IndR + 1) {
                                    row.find('td:eq(2)').html(curr.val());
                                    return false;
                                }
                            });
                        }
                        if ($(this).data("headnm") == 'HRA') {

                            $("input[name=txtHrr]").each(function () {
                                var row = $(this).closest("tr");
                                rIndex = row.closest('tr').index();
                                if (rIndex == IndR + 1) {
                                    row.find('td:eq(3)').html(curr.val());
                                    return false;
                                }
                            });
                        }

                    }

                    i += 1;
                });
                AllTextBoxCal();
            }
        }


        function AddnewRebate() {
            //if (I115 == 1) {
            //    alert('Rebates are not applicable in New Tax Regime I115BAC')
            //}
            //else {
                if ($("[id*=ddlSection80C]").val() == "0")
                { alert("Please select rebate name."); return false; }
                if ($("#txtSection80CAmt").val() == '' || $("#txtSection80CAmt").val() == '0')
                { alert("Please enter rebate amount."); return false; }
                if ($("[id*=ddlSection80C]").val() != '2' && $("[id*=ddlSection80C]").val() != '' && $("[id*=ddlSection80C]").val() != undefined && $("[id*=ddlSection80C]").val() != null) {
                    var makeInsert = true;
                    $("#tblAddedRebeats tbody tr").each(function () {
                        var id = $(this).find("input[type=hidden]").val();
                        if (id == $("[id*=ddlSection80C]").val())
                        { makeInsert = false; }
                    });
                    if (makeInsert) {
                        var currow = '';
                        currow += '<tr>'
                        currow += '<td width="80%"><input type="hidden" value="' + $("[id*=ddlSection80C]").val() + '">' + $("[id*=ddlSection80C] :selected").text() + '</td>'
                        currow += '<td><span class="spanwithno rebatamt">' + $("#txtSection80CAmt").val() + '</span></td>'
                        currow += '<td style="text-align:center;"><img src="../Images/Delete_icon.png" onclick="removeRebate(this)"></td>';
                        currow += '</tr>'
                        $("#tblAddedRebeats tbody").append(currow);
                        //alert($("[id*=ddlSection80C] :selected").text() + 'rebate added successfully.');
                        $("[id*=ddlSection80C]").val('0');
                        $("#txtSection80CAmt").val('0');
                        AllTextBoxCal();
                    }
                    else { alert($("[id*=ddlSection80C] :selected").text() + 'rebate already exists...'); }
                } else { alert($("[id*=ddlSection80C] :selected").text() + 'rebate already exists...'); }
            //}
        }

        function getGrossMonthlySalaryInArray() {

            var custarr = {
                grossmonthlyList: []
            };
            $("#tblMonthlySalary").find("input[type=text]").each(function () {
                if ($(this).data("headid") != "" && $(this).data("headid") != undefined && $(this).data("month") != "" && $(this).data("month") != undefined) {
                    if (parseFloat($(this).val()) > 0)
                        custarr.grossmonthlyList.push({
                            "headid": $(this).data("headid"),
                            "month": $(this).data("month"),
                            "amount": parseFloat($(this).val())
                        });
                }
            });
            return custarr.grossmonthlyList;
        }


        function HrrCalculationTable(grMonSal) {
            //////hrr calculation
            ///get hrr first
            var BasicDAHraHrrarrya = {
                list: []
            };

            $.each(Emp.LHRARentReceipt, function (i, va) {

                BasicDAHraHrrarrya.list.push({
                    "month": va.Month_No,
                    "HRR": va.Amount,
                    "HRA": 0,
                    "DA": 0,
                    "Basic": 0
                });
            });
            BasicDAHraHrrarrya = BasicDAHraHrrarrya.list;
            var BasicID = 0, DAID = 0, HRAID = 0;
            var hrrrCalIDs = $("[id*=hdnHRRCalHeadID]").val().split(',');
            $.each(hrrrCalIDs, function (i, calID) {
                var ExactCalid = calID.trim().split(':');
                if (ExactCalid[0] == "Basic")
                { BasicID = ExactCalid[1]; }
                if (ExactCalid[0] == "DA")
                { DAID = ExactCalid[1]; }
                if (ExactCalid[0] == "HRA")
                { HRAID = ExactCalid[1]; }
            });
            ///////sort by basic, da and hra
            $.each(grMonSal, function (i, va) {
                //$("input[name=txtHrr]").each(function () {
                //    var row = $(this).closest("tr");
                //    rIndex = row.closest('tr').index();
                //    var CurrVal = Currrow.find("input[name=txtHrr]").val();
                $.each(BasicDAHraHrrarrya, function (k, currAmt) {
                    if (va.month == currAmt.month) {
                        if (BasicID == va.headid)
                        { currAmt.Basic = parseFloat(va.amount); }
                        if (HRAID == va.headid)
                        { currAmt.HRA = parseFloat(va.amount); }
                        if (DAID == va.headid)
                        { currAmt.DA = parseFloat(va.amount); }
                    }
                });
            });
            return BasicDAHraHrrarrya;
        }

        ///////point 13 tax slab calculation
        function IncometaxSlabCalculation(NetIncome) {
            ///////////point12
            var txtNetIncome = NetIncome; //label

            /////////tax on total income tax Calculation

            var lblSlab1 = $('[id*=lblSlab1]').html();
            var lblSlab2 = $('[id*=lblSlab2]').html();
            var lblSlab3 = $('[id*=lblSlab3]').html();
            var lblSlab4 = $('[id*=lblSlab4]').html();

            var lblSlabPer1 = $('[id*=lblSlabPer1]').html();
            var lblSlabPer2 = $('[id*=lblSlabPer2]').html();
            var lblSlabPer3 = $('[id*=lblSlabPer3]').html();
            var lblSlabPer4 = $('[id*=lblSlabPer4]').html();



            var IncomeTax = "0";

            var lblIncome1 = 0;
            var lblIncome2 = 0;
            var lblIncome3 = 0;
            var lblIncome4 = 0;
            var lblIncome5 = 0;
            var lblIncome6 = 0;
            var lblIncome7 = 0;

            var lblIncomeTax1 = 0;
            var lblIncomeTax2 = 0;
            var lblIncomeTax3 = 0;
            var lblIncomeTax4 = 0;
            var lblIncomeTax5 = 0;
            var lblIncomeTax6 = 0;
            var lblIncomeTax7 = 0;
            

            if (parseFloat(txtNetIncome) <= parseFloat(lblSlab1)) {
                IncomeTax = txtNetIncome;
                lblIncome1 = txtNetIncome;
            }



                ///////////10%
                if (parseFloat(txtNetIncome) > parseFloat(lblSlab1) && parseFloat(txtNetIncome) <= parseFloat(lblSlab2)) {
                    lblIncome1 = lblSlab1;
                    lblIncome2 = parseFloat(txtNetIncome) - parseFloat(lblSlab1);
                    lblIncomeTax2 = (parseFloat(lblIncome2) * lblSlabPer2) / 100;
                }
                ///////////20%
                if (parseFloat(txtNetIncome) > parseFloat(lblSlab2) && parseFloat(txtNetIncome) <= parseFloat(lblSlab3)) {
                    lblIncome1 = lblSlab1;
                    lblIncome2 = parseFloat(lblSlab2) - parseFloat(lblSlab1);
                    lblIncomeTax2 = (parseFloat(lblIncome2) * lblSlabPer2) / 100;
                    lblIncome3 = parseFloat(txtNetIncome) - parseFloat(lblSlab2);
                    lblIncomeTax3 = (parseFloat(lblIncome3) * lblSlabPer3) / 100;
                }
                ///////////30%
                if (parseFloat(txtNetIncome) > parseFloat(lblSlab3) && parseFloat(txtNetIncome) <= parseFloat(lblSlab4)) {
                    lblIncome1 = lblSlab1;
                    lblIncome2 = parseFloat(lblSlab2) - parseFloat(lblSlab1);
                    lblIncomeTax2 = (parseFloat(lblIncome2) * lblSlabPer2) / 100;
                    lblIncome3 = parseFloat(lblSlab3) - parseFloat(lblSlab2);
                    lblIncomeTax3 = (parseFloat(lblIncome3) * lblSlabPer3) / 100;
                    lblIncome4 = parseFloat(txtNetIncome) - parseFloat(lblSlab3);
                    lblIncomeTax4 = (parseFloat(lblIncome4) * lblSlabPer4) / 100;
                }


                $('[id*=lblIncome1]').html(Math.round(lblIncome1));
                $('[id*=lblIncome2]').html(Math.round(lblIncome2));
                $('[id*=lblIncome3]').html(Math.round(lblIncome3));
                $('[id*=lblIncome4]').html(Math.round(lblIncome4));

                $('[id*=lblIncomeTotal]').html(Math.round(parseFloat(lblIncome1) + parseFloat(lblIncome2) + parseFloat(lblIncome3) + parseFloat(lblIncome4)));

                $('[id*=lblIncomeTax1]').html('Nil');
                $('[id*=lblIncomeTax2]').html(Math.round(lblIncomeTax2));
                $('[id*=lblIncomeTax3]').html(Math.round(lblIncomeTax3));
                $('[id*=lblIncomeTax4]').html(Math.round(lblIncomeTax4));


                $('[id*=lblIncomeTaxTotal]').html(Math.round(parseFloat(lblIncomeTax2) + parseFloat(lblIncomeTax3) + parseFloat(lblIncomeTax4)));
    

            return $('[id*=lblIncomeTaxTotal]').html();
        }
        function Incometax_115_Calculation(NetIncome) {
            ///////////point12
            var txtNetIncome = NetIncome; //label

            /////////tax on total income tax Calculation

            var lblSlab1 = $('[id*=lblSlab1SH]').html();
            var lblSlab2 = $('[id*=lblSlab2SH]').html();
            var lblSlab3 = $('[id*=lblSlab3SH]').html();
            var lblSlab4 = $('[id*=lblSlab4SH]').html();

            var lblSlabPer1 = $('[id*=lblSlabPer1SH]').html();
            var lblSlabPer2 = $('[id*=lblSlabPer2SH]').html();
            var lblSlabPer3 = $('[id*=lblSlabPer3SH]').html();
            var lblSlabPer4 = $('[id*=lblSlabPer4SH]').html();


            var lblSlab5 = $('[id*=lblSlab5SH]').html();
            var lblSlab6 = $('[id*=lblSlab6SH]').html();
            var lblSlabPer5 = $('[id*=lblSlabPer5SH]').html();
            var lblSlabPer6 = $('[id*=lblSlabPer6SH]').html();
            

            var IncomeTax = "0";

            var lblIncome1 = 0;
            var lblIncome2 = 0;
            var lblIncome3 = 0;
            var lblIncome4 = 0;
            var lblIncome5 = 0;
            var lblIncome6 = 0;
            var lblIncome7 = 0;

            var lblIncomeTax1 = 0;
            var lblIncomeTax2 = 0;
            var lblIncomeTax3 = 0;
            var lblIncomeTax4 = 0;
            var lblIncomeTax5 = 0;
            var lblIncomeTax6 = 0;
            var lblIncomeTax7 = 0;


            if (parseFloat(txtNetIncome) <= parseFloat(lblSlab1)) {
                IncomeTax = txtNetIncome;
                lblIncome1 = txtNetIncome;
            }


                ///////////5%
                if (parseFloat(txtNetIncome) > parseFloat(lblSlab1) && parseFloat(txtNetIncome) <= parseFloat(lblSlab2)) {
                    lblIncome1 = lblSlab1;
                    lblIncome2 = parseFloat(txtNetIncome) - parseFloat(lblSlab1);
                    lblIncomeTax2 = (parseFloat(lblIncome2) * lblSlabPer1) / 100;
                }
                ///////////10%
                if (parseFloat(txtNetIncome) > parseFloat(lblSlab2) && parseFloat(txtNetIncome) <= parseFloat(lblSlab3)) {
                    lblIncome1 = lblSlab1;
                    lblIncome2 = parseFloat(lblSlab2) - parseFloat(lblSlab1);
                    lblIncomeTax2 = (parseFloat(lblIncome2) * lblSlabPer1) / 100;
                    lblIncome3 = parseFloat(txtNetIncome) - parseFloat(lblSlab2);
                    lblIncomeTax3 = (parseFloat(lblIncome3) * lblSlabPer2) / 100;
                }
                ///////////15%
                if (parseFloat(txtNetIncome) > parseFloat(lblSlab3) && parseFloat(txtNetIncome) <= parseFloat(lblSlab4)) {
                    lblIncome1 = lblSlab1;
                    lblIncome2 = parseFloat(lblSlab2) - parseFloat(lblSlab1);
                    lblIncomeTax2 = (parseFloat(lblIncome2) * lblSlabPer1) / 100;
                    lblIncome3 = parseFloat(lblSlab3) - parseFloat(lblSlab2);
                    lblIncomeTax3 = (parseFloat(lblIncome3) * lblSlabPer2) / 100;
                    lblIncome4 = parseFloat(txtNetIncome) - parseFloat(lblSlab3);
                    lblIncomeTax4 = (parseFloat(lblIncome4) * lblSlabPer3) / 100;
                }

                ///////////20%
                if (parseFloat(txtNetIncome) > parseFloat(lblSlab4) && parseFloat(txtNetIncome) <= parseFloat(lblSlab5)) {
                    lblIncome1 = lblSlab1;
                    lblIncome2 = parseFloat(lblSlab2) - parseFloat(lblSlab1);
                    lblIncomeTax2 = (parseFloat(lblIncome2) * lblSlabPer1) / 100;
                    lblIncome3 = parseFloat(lblSlab3) - parseFloat(lblSlab2);
                    lblIncomeTax3 = (parseFloat(lblIncome3) * lblSlabPer2) / 100;
                    lblIncome4 = parseFloat(lblSlab4) - parseFloat(lblSlab3);
                    lblIncomeTax4 = (parseFloat(lblIncome4) * lblSlabPer3) / 100;
                    lblIncome5 = parseFloat(txtNetIncome) - parseFloat(lblSlab4);
                    lblIncomeTax5 = (parseFloat(lblIncome5) * lblSlabPer4) / 100;
                }

                ///////////25%
                if (parseFloat(txtNetIncome) > parseFloat(lblSlab5) && parseFloat(txtNetIncome) <= parseFloat(lblSlab6)) {
                    lblIncome1 = lblSlab1;
                    lblIncome2 = parseFloat(lblSlab2) - parseFloat(lblSlab1);
                    lblIncomeTax2 = (parseFloat(lblIncome2) * lblSlabPer1) / 100;
                    lblIncome3 = parseFloat(lblSlab3) - parseFloat(lblSlab2);
                    lblIncomeTax3 = (parseFloat(lblIncome3) * lblSlabPer2) / 100;
                    lblIncome4 = parseFloat(lblSlab4) - parseFloat(lblSlab3);
                    lblIncomeTax4 = (parseFloat(lblIncome4) * lblSlabPer3) / 100;
                    lblIncome5 = parseFloat(lblSlab5) - parseFloat(lblSlab4);
                    lblIncomeTax5 = (parseFloat(lblIncome5) * lblSlabPer4) / 100;
                    lblIncome6 = parseFloat(txtNetIncome) - parseFloat(lblSlab5);
                    lblIncomeTax6 = (parseFloat(lblIncome6) * lblSlabPer5) / 100;
                }

                ///////////30%
                if (parseFloat(txtNetIncome) > parseFloat(lblSlab6)) {
                    lblIncome1 = lblSlab1;
                    lblIncome2 = parseFloat(lblSlab2) - parseFloat(lblSlab1);
                    lblIncomeTax2 = (parseFloat(lblIncome2) * lblSlabPer1) / 100;
                    lblIncome3 = parseFloat(lblSlab3) - parseFloat(lblSlab2);
                    lblIncomeTax3 = (parseFloat(lblIncome3) * lblSlabPer2) / 100;
                    lblIncome4 = parseFloat(lblSlab4) - parseFloat(lblSlab3);
                    lblIncomeTax4 = (parseFloat(lblIncome4) * lblSlabPer3) / 100;
                    lblIncome5 = parseFloat(lblSlab5) - parseFloat(lblSlab4);
                    lblIncomeTax5 = (parseFloat(lblIncome5) * lblSlabPer4) / 100;
                    lblIncome6 = parseFloat(lblSlab6) - parseFloat(lblSlab5);
                    lblIncomeTax6 = (parseFloat(lblIncome6) * lblSlabPer5) / 100;
                    lblIncome7 = parseFloat(txtNetIncome) - parseFloat(lblSlab6);
                    lblIncomeTax7 = (parseFloat(lblIncome7) * lblSlabPer6) / 100;
                }

                $('[id*=lblIncome1SH]').html(Math.round(lblIncome2));
                $('[id*=lblIncome2SH]').html(Math.round(lblIncome3));
                $('[id*=lblIncome3SH]').html(Math.round(lblIncome4));
                $('[id*=lblIncome4SH]').html(Math.round(lblIncome5));
                $('[id*=lblIncome5SH]').html(Math.round(lblIncome6));
                $('[id*=lblIncome6SH]').html(Math.round(lblIncome7));
                $('[id*=lblIncomeTax1SH]').html(Math.round(lblIncomeTax2));
                $('[id*=lblIncomeTax2SH]').html(Math.round(lblIncomeTax3));
                $('[id*=lblIncomeTax3SH]').html(Math.round(lblIncomeTax4));
                $('[id*=lblIncomeTax4SH]').html(Math.round(lblIncomeTax5));
                $('[id*=lblIncomeTax5SH]').html(Math.round(lblIncomeTax6));
                $('[id*=lblIncomeTax6SH]').html(Math.round(lblIncomeTax7));
                $('[id*=lblIncomeTaxTotalSH]').html(Math.round(parseFloat(lblIncomeTax2) + parseFloat(lblIncomeTax3) + parseFloat(lblIncomeTax4) + parseFloat(lblIncomeTax5) + parseFloat(lblIncomeTax6) + parseFloat(lblIncomeTax7)));
            

                return $('[id*=lblIncomeTaxTotalSH]').html();
        }

        ///point 9 Rebate remove from table
        function removeRebate(curr) {
            if (confirm('Are you sure you want to delete?')) {
                curr.closest("tr").remove();
                AllTextBoxCal();
            }
        }



        /////////////numeric validation
        function returnNumeric(num) {
            if (num == null || num == undefined || num == '' || isNaN(num)) num = 0;
            return parseFloat(num);
        }


        function ReturnMonthname(i) {
            if (isNaN(i) || i == '' || i == undefined || i == null) return "Invalid Monthid";
            i = parseInt(i);
            if (i == 1) return "Jan";
            if (i == 2) return "Feb";
            if (i == 3) return "Mar";
            if (i == 4) return "Apr";
            if (i == 5) return "May";
            if (i == 6) return "Jun";
            if (i == 7) return "Jul";
            if (i == 8) return "Aug";
            if (i == 9) return "Sep";
            if (i == 10) return "Oct";
            if (i == 11) return "Nov";
            if (i == 12) return "Dec";
        }

        function SaveEmployeeComputation() {

            var i = $("[id*=chkBAC]");
            var Emply = '';
            var chkprop = i.is(':checked');
            if (chkprop) {
                Save115Computation();
            }
            else {
                removeComma();
                /////////point 1 monthly salary data
                var allList = { grossmonthlyList: [], perqusiteslist: [], SectiontenList: [], ProfessionTaxList: [], TDSRebated: [] };
                $("#tblMonthlySalary").find("input[type=text]").each(function () {
                    if ($(this).data("headid") != "" && $(this).data("headid") != undefined && $(this).data("month") != "" && $(this).data("month") != undefined) {
                        allList.grossmonthlyList.push({
                            "Head_ID": $(this).data("headid"),
                            "SalaryMonth": $(this).data("month"),
                            "Amount": parseFloat($(this).val())
                        });
                    }
                });
                var pq = '';
                /////////point 1 perquisites
                //$("#tblPerquisites tbody tr").each(function () {
                $('#tblPerquisites > tbody  > tr').each(function () {
                    row = $(this).closest("tr");
                    var d = row.find('td:eq(1)').html();
                    if ($(this).find("input[type=hidden]").val() != undefined) {
                        var EmployeePaid_Amt = 0, Taxable_Amt = 0, Perquisites_Value = 0;
                        $(this).find("input[type=text]").each(function () {
                            if ($(this).data('name') == "EmployeePaid_Amt")
                                EmployeePaid_Amt = $(this).val();
                            if ($(this).data('name') == "Taxable_Amt")
                                Taxable_Amt = $(this).val();
                            if ($(this).data('name') == "Perquisites_Value")
                                Perquisites_Value = $(this).val();
                        });
         
                            pq = pq + d  + '~' + EmployeePaid_Amt + '~' + Perquisites_Value + '~' + Taxable_Amt + '^';

                        //allList.perqusiteslist.push({
                        //    "Perq_ID": $(this).find("input[type=hidden]").val(),
                        //    "EmployeePaid_Amt": EmployeePaid_Amt,
                        //    "Perquisites_Value": Perquisites_Value,
                        //    "Taxable_Amt": Taxable_Amt,
                        //    "Employee_ID": Emp.Employee_ID,
                        //    "Company_ID": $("[id*=hdnCompanyID]").val()
                        //});
                    }
                });


                ///////point 2 section 10
                //$("#tblSectionten tbody tr").each(function () {
                //    if ($(this).find("input[type=hidden]").val() != undefined)
                //        allList.SectiontenList.push({
                //            "Head_ID": $(this).find("input[type=hidden]").val(),
                //            "Amount": $(this).find("span").text()
                //        });
                //});

                /////////point 4 deductions
                //$("#tblProfesstionTax tbody tr").each(function () {
                //    if ($(this).find("input[type=hidden]").val() != undefined)
                //        allList.ProfessionTaxList.push({
                //            "SalaryMonth": $(this).find("input[type=hidden]").val(),
                //            "Amount": $(this).find("input[type=text]").val()
                //        });
                //});

                //////////point 9  tds rebates
                $("#tblAddedRebeats tbody tr").each(function () {
                    if ($(this).find("input[type=hidden]").val() != undefined)
                        allList.TDSRebated.push({
                            "Rebate_ID": $(this).find("input[type=hidden]").val(),
                            "Amount": $(this).find("span").text()
                        });
                });

                var aDns = '';
                $("input[name=txtHrr]").each(function () {
                    var row = $(this).closest("tr");
                    var rIndex = $(this).closest("tr")[0].sectionRowIndex;
                    var mname = row.find('td:eq(0)').html();
                    var mth = row.find("input[name=hdnMth]").val();
                    var Hrr = $(this).val();
                    if (Hrr != undefined) {

                        aDns = aDns + Hrr + "," + mth + "," + mname + "^";
                    }

                });


                var M = false;
                if ($("#chkPM").is(':checked')) {
                    M = true;
                }
                var H = false;
                if ($("#chkHRA").is(':checked')) {
                    H = true;
                }
                var pf = false;
                var pt = false;
                if ($("[id*=chkCalcProvidendFund]").is(':checked')) {
                    pf = true;
                }
                else {
                    pf = false;
                }
                if ($("[id*=chkCalcProfessionalTax]").is(':checked')) {
                    pt = true;
                }
                else {
                    pt = false;
                }
                var st = 0;
                if ($("[id*=drpState]").val() == undefined || $("[id*=drpState]").val() == '') {
                    st = 0;
                }
                else {
                    st = parseFloat($("[id*=drpState]").val());
                }
                if (isNaN(st) == true) {
                    st = 0;
                }

                var nc = 0;
                if ($("[id*=drpChild]").val() == undefined || $("[id*=drpChild]").val() == '') {
                    nc = 0;
                }
                else {
                    nc = parseFloat($("[id*=drpChild]").val());
                }
                if (isNaN(nc) == true) {
                    nc = 0;
                }


                var tobj = {
                    Employee_ID: Emp.Employee_ID,
                    Company_ID: $("[id*=hdnCompanyID]").val(),
                    FirstName: Emp.FirstName,
                    Designation_Name: Emp.Designation_Name,
                    Department_Name: Emp.Department_Name,
                    Gender: Emp.Gender,
                    Senior_CTZN_Type: Emp.Senior_CTZN_Type,
                    Metro_Cities: $("[id*=ddlMetrocities]").val(),
                    No_Of_Child: nc,
                    Senior_CTZN_Type: $("[id*=drpCtzn]").val(),
                    state_id: st,
                    CALC_PF: pf,
                    CALC_PT: pt,
                    /////point 1
                    Total_Earnings: $("#txtSalaryAsPerProvisions").text(),
                    GrossPerks_B: $("#txtValueOfPerquisites").text(),
                    GrossProfits_C: $("#txtSalaryUnderSection").val(),
                    GrossTotal_D: $("#txtGrossSalaryTotal").text(),
                    GrossEarn1: $("#txtGrossSalary").text(),
                    LMonthlySalaryBreakup: allList.grossmonthlyList,
                    //LPerquisites: allList.perqusiteslist,
                    Perk:pq,

                    ///////////point 2
                    LSection10: allList.SectiontenList,
                    Section_10: $("#txtSection10").text(),

                    //////////////////point3
                    PreSal: $("#txtPreviousTaxableSalary").val(),
                    GrossEarn3: $("#txtTaxableBalance").text(),

                    //////////////////point4
                    StandardDeductions: $("#txtStandardDeductions").val(),
                    Entertainment: $("#txtEntertainmentAllowance").val(),
                    LProfessionTax: allList.ProfessionTaxList,
                    PTax: $("#txtTaxonEmployeement").text(),
                    TotalDeduction: $("#txtDeductions").text(),

                    //////////////////point5
                    GrossEarn5: $("#txtIncomecharge").text(),

                    //////////////////point6
                    OtherIncome: $("#txtOtherIncome").val(),

                    //////////////////point7
                    IntHouseLoan: $("#txtHousingLoan").val(),

                    /////////////////point8
                    GrossEarn8: $("#txtGrossTotalIncome").text(),

                    /////////////////point9
                    LTDSRebate: allList.TDSRebated,
                    Rebate80C: $("#txtPFSubTotal").text(),
                    // Rebate80QlfySal = (Convert.ToDouble(txtRebate80CCC.Text) + Convert.ToDouble(txtReb80CCD.Text));
                    //                if (Rebate80QlfySal > 150000)
                    //                {
                    //                    Rebate80QlfySal = 150000;
                    //                }
                    Rebate80NetSal: $("#txAggregateOfTaxRebateAndRelief").text(),

                    Rebate80CCC: $("#txtRebate80CCC").val(),
                    Rebate80CCD: $("#txtReb80CCD").val(),
                    Rebate80CCD2: $("#txtRebate80CCD2").val(),
                    Rebate80CCD1B: $("#txtRebate80CCD21b").val(),

                    /////////////////point10
                    Rebate88D: $("#txtRebate80D").val(),
                    Rebate80DD: $("#txtRebate80DD").val(),
                    Rebate80DDB: $("#txtRebate80DDB").val(),
                    Rebate80QQB: $("#txtRebate80QQB").val(),
                    Rebate80E: $("#txtRebate80E").val(),
                    Rebate80EE: $("#txtRebate80EE").val(),
                    Rebate80G: $("#txtRebate80G").val(),
                    Rebate80GG: $("#txtRebate80GG").val(),
                    Rebate80GGA: $("#txtRebate80GGA").val(),
                    Rebate80GGC: $("#txtRebate80GGC").val(),
                    Rebate80RRB: $("#txtRebate80RRB").val(),
                    Rebate80U: $("#txtRebate80U").val(),
                    Rebate80CCG: $("#txtRebate80CCG").val(),
                    Rebate80TTA: $("#txtRebate80TTA").val(),

                    /////// Rebate deduction
                    Rebate80C_Ded: $("#txtRebate80C_Ded").val(),
                    Rebate80CCC_Ded: $("#txtRebate80CCC_Ded").val(),
                    Rebate80CCD_Ded: $("#txtReb80CCD_Ded").val(),
                    Rebate80CCD2_Ded: $("#txtRebate80CCD2_Ded").val(),
                    Rebate80CCD1B_Ded: $("#txtRebate80CCD21b_Ded").val(),

                    /////////////////point10
                    Rebate88D_Ded: $("#txtRebate80D_Ded").val(),
                    Rebate80DD_Ded: $("#txtRebate80DD_Ded").val(),
                    Rebate80DDB_Ded: $("#txtRebate80DDB_Ded").val(),
                    Rebate80QQB_Ded: $("#txtRebate80QQB_Ded").val(),
                    Rebate80E_Ded: $("#txtRebate80E_Ded").val(),
                    Rebate80EE_Ded: $("#txtRebate80EE_Ded").val(),
                    Rebate80G_Ded: $("#txtRebate80G_Ded").val(),
                    Rebate80GG_Ded: $("#txtRebate80GG_Ded").val(),
                    Rebate80GGA_Ded: $("#txtRebate80GGA_Ded").val(),
                    Rebate80GGC_Ded: $("#txtRebate80GGC_Ded").val(),
                    Rebate80RRB_Ded: $("#txtRebate80RRB_Ded").val(),
                    Rebate80U_Ded: $("#txtRebate80U_Ded").val(),
                    Rebate80CCG_Ded: $("#txtRebate80CCG_Ded").val(),
                    Rebate80TTA_Ded: $("#txtRebate80TTA_Ded").val(),
                    ///////////// Qlfy
                    Rebate80G_Qlfy: $("#txtRebate80G_Qlfy").val(),
                    Rebate80GG_Qlfy: $("#txtRebate80GG_Qlfy").val(),
                    Rebate80GGA_Qlfy: $("#txtRebate80GGA_Qlfy").val(),
                    Rebate80GGC_Qlfy: $("#txtRebate80GGC_Qlfy").val(),
                    Rebate80RRB_Qlfy: $("#txtRebate80RRB_Qlfy").val(),
                    Rebate80U_Qlfy: $("#txtRebate80U_Qlfy").val(),
                    Rebate80CCG_Qlfy: $("#txtRebate80CCG_Qlfy").val(),
                    Rebate80TTA_Qlfy: $("#txtRebate80TTA_Qlfy").val(),

                    ////////////////point11
                    TotalRebate: $("#lblAggregateoftax").text(),

                    ////////////////point12
                    Grossnet: $("#txtNetIncome").text(),

                    ////////////////point13
                    Itax1: $("#txtTaxonTotalIncome").text(),

                    ////////////////point14
                    Rebatetds: $("#txtRebate87A").text(),

                    ////////////////point15
                    Itax2: $("#txtTaxPayableAndSurcharge").text(),

                    Surcharge: Surcharge,

                    ////////////////point16
                    EducationCess: $("#txtEducationCess").text(),

                    ////////////////point17
                    HighEduCess: 0, //$("#txtHigherEducationCess").text(),

                    /////////////Heath Cess

                    HeathCess: HeathCess,

                    ////////////////point 18
                    Rebate89: $("#txtUnderSection89").val(),

                    ///////////////point 19
                    Challan_Tax: $("#txtTaxDeductedAtSource").text(),

                    ///////////////point 20
                    PreTds: $("#txtTaxDeductedbyPreEmployer").val(),

                    ///////////////point 21
                    FinalTax: $("#lastpayabletax").text(),

                    HRate: ($("#PAN_NO").text().trim() != "PANNOTAVBL" && $("#PAN_NO").text().trim() != "") ? "0" : $("#ddlHrate").val(),

                    LastName: $("[id*=hdnConnString]").val(),
                    Manual: M,
                    ManualHRA: H,
                    I115BAC: I115,
                    HrrRec: aDns
                };
                tobj = JSON.stringify({ 'tobj': tobj });
                setNumericFormat();
                ServerServiceToGetData(tobj, baseUrl + 'setEmployeeComputation', 'false', saveEmployeeSuccess);
            }
        }


        function Save115Computation() {
            removeComma();
            I115 = 1;
            /////////point 1 monthly salary data
            var allList = { grossmonthlyList: [], perqusiteslist: [], SectiontenList: [], ProfessionTaxList: [], TDSRebated: [] };
            $("#tblMonthlySalary").find("input[type=text]").each(function () {
                if ($(this).data("headid") != "" && $(this).data("headid") != undefined && $(this).data("month") != "" && $(this).data("month") != undefined) {
                    allList.grossmonthlyList.push({
                        "Head_ID": $(this).data("headid"),
                        "SalaryMonth": $(this).data("month"),
                        "Amount": parseFloat($(this).val())
                    });
                }
            });
            var pq = '';
            /////////point 1 perquisites
            $('#tblPerquisites > tbody  > tr').each(function () {
                row = $(this).closest("tr");
                var d = row.find('td:eq(1)').html();
                if ($(this).find("input[type=hidden]").val() != undefined) {
                    var EmployeePaid_Amt = 0, Taxable_Amt = 0, Perquisites_Value = 0;
                    $(this).find("input[type=text]").each(function () {
                        if ($(this).data('name') == "EmployeePaid_Amt")
                            EmployeePaid_Amt = $(this).val();
                        if ($(this).data('name') == "Taxable_Amt")
                            Taxable_Amt = $(this).val();
                        if ($(this).data('name') == "Perquisites_Value")
                            Perquisites_Value = $(this).val();
                    });

                        pq = pq + d + '~' + EmployeePaid_Amt + '~' + Perquisites_Value + '~' + Taxable_Amt + '^';
                }
            });
            ///////point 2 section 10
            //$("#tblSectionten tbody tr").each(function () {
            //    if ($(this).find("input[type=hidden]").val() != undefined)
            //        allList.SectiontenList.push({
            //            "Head_ID": $(this).find("input[type=hidden]").val(),
            //            "Amount": $(this).find("span").text()
            //        });
            //});



            var aDns = '';
            $("input[name=txtHrr]").each(function () {
                var row = $(this).closest("tr");
                var rIndex = $(this).closest("tr")[0].sectionRowIndex;
                var mname = row.find('td:eq(0)').html();
                var mth = row.find("input[name=hdnMth]").val();
                var Hrr = $(this).val();
                if (Hrr != undefined) {

                    aDns = aDns + Hrr + "," + mth + "," + mname + "^";
                }

            });


            var M = false;
            if ($("#chkPM").is(':checked')) {
                M = true;
            }
            var H = false;
            if ($("#chkHRA").is(':checked')) {
                H = true;
            }
            var pf = false;
            var pt = false;
            if ($("[id*=chkCalcProvidendFund]").is(':checked')) {
                pf = true;
            }
            else {
                pf = false;
            }
            if ($("[id*=chkCalcProfessionalTax]").is(':checked')) {
                pt = true;
            }
            else {
                pt = false;
            }
            var st = 0;
            if ($("[id*=drpState]").val() == undefined || $("[id*=drpState]").val() == '') {
                st = 0;
            }
            else {
                st = parseFloat($("[id*=drpState]").val());
            }
            if (isNaN(st) == true) {
                st = 0;
            }

            var nc = 0;
            if ($("[id*=drpChild]").val() == undefined || $("[id*=drpChild]").val() == '') {
                nc = 0;
            }
            else {
                nc = parseFloat($("[id*=drpChild]").val());
            }
            if (isNaN(nc) == true) {
                nc = 0;
            }
            
 

            var tobj = {
                Employee_ID: Emp.Employee_ID,
                Company_ID: $("[id*=hdnCompanyID]").val(),
                FirstName: Emp.FirstName,
                Designation_Name: Emp.Designation_Name,
                Department_Name: Emp.Department_Name,
                Gender: Emp.Gender,
                Senior_CTZN_Type: Emp.Senior_CTZN_Type,
                Metro_Cities: $("[id*=ddlMetrocities]").val(),
                No_Of_Child: nc,
                Senior_CTZN_Type: $("[id*=drpCtzn]").val(),
                state_id: st,
                CALC_PF: pf,
                CALC_PT: pt,
                /////point 1
                Total_Earnings: $("#txtSalaryAsPerProvisions").text(),
                GrossPerks_B: $("#txtValueOfPerquisites").text(),
                GrossProfits_C: $("#txtSalaryUnderSection").val(),
                GrossTotal_D: $("#txtGrossSalaryTotal").text(),
                GrossEarn1: $("#txtGrossSalarySH").text(),
                LMonthlySalaryBreakup: allList.grossmonthlyList,
                // LPerquisites: allList.perqusiteslist,
                Perk : pq,

                ///////////point 2
                LSection10: allList.SectiontenList,
                Section_10: $("#txtSection10SH").text(),

                //////////////////point3
                PreSal: $("#txtPreviousTaxableSalarySH").val(),
                GrossEarn3: $("#txtTaxableBalanceSH").text(),

                //////////////////point4
                StandardDeductions: 0, //$("#txtStandardDeductions").val(),
                Entertainment: 0,//$("#txtEntertainmentAllowance").val(),
                LProfessionTax: allList.ProfessionTaxList,
                PTax: 0,//$("#txtTaxonEmployeement").text(),
                TotalDeduction: 0, //$("#txtDeductions").text(),

                //////////////////point5
                GrossEarn5: $("#txtIncomechargeSH").text(),

                //////////////////point6
                OtherIncome: $("#txtOtherIncomeSH").val(),

                //////////////////point7
                IntHouseLoan: $("#txtHousingLoanSH").val(),

                /////////////////point8
                GrossEarn8: $("#txtGrossTotalIncomeSH").text(),

                /////////////////point9
                LTDSRebate: allList.TDSRebated,
                Rebate80C: 0, //$("#txtPFSubTotal").text(),
                // Rebate80QlfySal = (Convert.ToDouble(txtRebate80CCC.Text) + Convert.ToDouble(txtReb80CCD.Text));
                //                if (Rebate80QlfySal > 150000)
                //                {
                //                    Rebate80QlfySal = 150000;
                //                }

                Rebate80NetSal: $("#txtSection80CVariousInvestmentsSH").html(),

                Rebate80CCC:  0, //$("#txtRebate80CCC").val(),
                Rebate80CCD: 0, // $("#txtReb80CCD").val(),
                Rebate80CCD2: $("#txtRebate80CCD2").val(),
                Rebate80CCD1B: 0,  //$("#txtRebate80CCD21b").val(),

                /////////////////point10
                Rebate88D: 0,  //$("#txtRebate80D").val(),
                Rebate80DD: 0,  //$("#txtRebate80DD").val(),
                Rebate80DDB: 0,  // $("#txtRebate80DDB").val(),
                Rebate80QQB: 0,  // $("#txtRebate80QQB").val(),
                Rebate80E: 0,  //$("#txtRebate80E").val(),
                Rebate80EE: 0,  // $("#txtRebate80EE").val(),
                Rebate80G: 0,  //$("#txtRebate80G").val(),
                Rebate80GG: 0,  //$("#txtRebate80GG").val(),
                Rebate80GGA: 0,  // $("#txtRebate80GGA").val(),
                Rebate80GGC: 0,  // $("#txtRebate80GGC").val(),
                Rebate80RRB: 0,  //$("#txtRebate80RRB").val(),
                Rebate80U: 0,  //$("#txtRebate80U").val(),
                Rebate80CCG: 0,  // $("#txtRebate80CCG").val(),
                Rebate80TTA: 0,  //$("#txtRebate80TTA").val(),

                /////// Rebate deduction
                Rebate80C_Ded: 0,  //$("#txtRebate80C_Ded").val(),
                Rebate80CCC_Ded: 0,  //$("#txtRebate80CCC_Ded").val(),
                Rebate80CCD_Ded: 0,  //$("#txtReb80CCD_Ded").val(),
                Rebate80CCD2_Ded: $("#txtRebate80CCD2_Ded").val(),
                Rebate80CCD1B_Ded: 0,  //$("#txtRebate80CCD21b_Ded").val(),

                /////////////////point10
                Rebate88D_Ded: 0,  //$("#txtRebate80D_Ded").val(),
                Rebate80DD_Ded: 0,  //$("#txtRebate80DD_Ded").val(),
                Rebate80DDB_Ded: 0,  // $("#txtRebate80DDB_Ded").val(),
                Rebate80QQB_Ded: 0,  // $("#txtRebate80QQB_Ded").val(),
                Rebate80E_Ded: 0,  // $("#txtRebate80E_Ded").val(),
                Rebate80EE_Ded: 0,  // $("#txtRebate80EE_Ded").val(),
                Rebate80G_Ded: 0,  //$("#txtRebate80G_Ded").val(),
                Rebate80GG_Ded: 0,  //$("#txtRebate80GG_Ded").val(),
                Rebate80GGA_Ded: 0,  // $("#txtRebate80GGA_Ded").val(),
                Rebate80GGC_Ded: 0,  // $("#txtRebate80GGC_Ded").val(),
                Rebate80RRB_Ded: 0,  // $("#txtRebate80RRB_Ded").val(),
                Rebate80U_Ded: 0,  //$("#txtRebate80U_Ded").val(),
                Rebate80CCG_Ded: 0,  // $("#txtRebate80CCG_Ded").val(),
                Rebate80TTA_Ded: 0,  //$("#txtRebate80TTA_Ded").val(),
                ///////////// Qlfy
                Rebate80G_Qlfy: 0,  //$("#txtRebate80G_Qlfy").val(),
                Rebate80GG_Qlfy: 0,  // $("#txtRebate80GG_Qlfy").val(),
                Rebate80GGA_Qlfy: 0,  // $("#txtRebate80GGA_Qlfy").val(),
                Rebate80GGC_Qlfy: 0,  // $("#txtRebate80GGC_Qlfy").val(),
                Rebate80RRB_Qlfy: 0,  // $("#txtRebate80RRB_Qlfy").val(),
                Rebate80U_Qlfy: 0,  // $("#txtRebate80U_Qlfy").val(),
                Rebate80CCG_Qlfy: 0,  // $("#txtRebate80CCG_Qlfy").val(),
                Rebate80TTA_Qlfy: 0,  // $("#txtRebate80TTA_Qlfy").val(),

                ////////////////point11
                TotalRebate: $("#lblAggregateoftaxSH").text(),

                ////////////////point12
                Grossnet: $("#txtNetIncomeSH").text(),

                ////////////////point13
                Itax1: $("#txtTaxonTotalIncomeSH").text(),

                ////////////////point14
                Rebatetds: $("#txtRebate87ASH").text(),

                ////////////////point15
                Itax2: $("#txtTaxPayableAndSurchargeSH").text(),

                Surcharge: Surcharge115,

                ////////////////point16
                EducationCess: $("#txtEducationCessSH").text(),

                ////////////////point17
                HighEduCess: 0,// $("#txtHigherEducationCessSH").text(),

                /////////////Heath Cess

                HeathCess: HeathCess,

                ////////////////point 18
                Rebate89: $("#txtUnderSection89SH").val(),

                ///////////////point 19
                Challan_Tax: $("#txtTaxDeductedAtSourceSH").text(),

                ///////////////point 20
                PreTds: $("#txtTaxDeductedbyPreEmployerSH").val(),

                ///////////////point 21
                FinalTax: $("#lastpayabletaxSH").text(),

                HRate: ($("#PAN_NO").text().trim() != "PANNOTAVBL" && $("#PAN_NO").text().trim() != "") ? "0" : $("#ddlHrate").val(),

                LastName: $("[id*=hdnConnString]").val(),
                Manual: M,
                ManualHRA: H,
                I115BAC: I115,
                HrrRec: aDns
            };
            tobj = JSON.stringify({ 'tobj': tobj });
            setNumericFormat();
            ServerServiceToGetData(tobj, baseUrl + 'setEmployeeComputation', 'false', saveEmployeeSuccess);

        }

 

        function saveEmployeeSuccess(data) {
            if (parseFloat(data.d) > 0) {
                btnTDSSummarySearchClick();
                showSuccess('Saved Successfully.');
                TDSCancel();
                if (Rfsh == 'True') {
                    iRfsh = parseFloat(iRfsh) + 1;
                    var j = Eid_Rfsh[iRfsh];
                    if (j > 0) {
                        goforComputatioin(j);
                    }
                    else {
                        Rfsh = '';
                        Eid_Rfsh = [];
                        iRfsh = 0;
                        alert('Refresh for Current Page done')
                    }
                }
            }
            else
                showError('Error while saving.......');
        }

        function PT() {
            location.replace('ManageProfessionalTaxSlab_Master.aspx')
        }
        function Slab10() {
            location.replace('Head_Name.aspx')
        }

        function getEmployeeFormsixteen(FormEmployeeID) {
            var tobj = {
                Employee_ID: FormEmployeeID,
                Company_ID: $("[id*=hdnCompanyID]").val(),
                LastName: $("[id*=ddlFinancialYear] :selected").text(),
                ConnectionString: $("[id*=ddlFinancialYear]").val()
            };
            tobj = JSON.stringify({ 'tobj': tobj });
            ServerServiceToGetData(tobj, baseUrl + 'getEmployeeFormSixteen', 'false', successForFormSixteen);
        }

        function successForFormSixteen(data) {

            var newWin = window.open("DownloadForm16.aspx", "_blank", "toolbar=no,scrollbars=no,resizable=no,top=500,left=500,width=400,height=400");

            if (!newWin || newWin.closed || typeof newWin.closed == 'undefined') {
                //POPUP BLOCKED
                alert('please allow popup window in your browser ');
            }

        }

        function setNumericFormat() {
            $(".spanwithno").each(function () {
                $(this).html(AddComma($(this).html()));
            });
            $(".cssTextboxInt").each(function () {
                $(this).val(AddComma($(this).val()));
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

        function removeComma() {
            $(".spanwithno").each(function () {
                var mystring = $(this).html();
                var newchar = '';
                mystring = mystring.split(',').join(newchar);
                $(this).html(mystring);
            });
            $(".cssTextboxInt").each(function () {
                var mystring = $(this).val();
                var newchar = '';
                mystring = mystring.split(',').join(newchar);
                $(this).val(mystring);
            });
        }

        function showSuccess(msg) {
            $("#MasterPage_ucMessageControl_msgBx").html(msg);
            $("#MasterPage_ucMessageControl_msgBx").attr('class', '');
            $("#MasterPage_ucMessageControl_msgBx").attr('class', 'success');
            disappearControl('MasterPage_ucMessageControl_msgBx');
        }

        function showError(msg) {
            $("#MasterPage_ucMessageControl_msgBx").html(msg);
            $("#MasterPage_ucMessageControl_msgBx").attr('class', '');
            $("#MasterPage_ucMessageControl_msgBx").attr('class', 'error');
            disappearControl('MasterPage_ucMessageControl_msgBx');
        }

        function ChallanShow() {
            var i = $("[id*=hdnTaxShow]").val();
            if (i == '0') {
                $("[id*=tbltr]").hide();
                $("[id*=hdnTaxShow]").val(1);
            }
            else {
                $("[id*=tbltr]").show();
                $("[id*=hdnTaxShow]").val(0);
            }
        }

        function tblColor()
        {
            var ocss = '';
            var cIndex = 0;
            var ccol = 3;
            $('#tblEmployeeTDScomputation > tbody  > tr').each(function () {
                row = $(this).closest("tr");
                var rIndex = $(this).closest("tr")[0].sectionRowIndex;
                cIndex = 5;
                if (rIndex > 0) {
                    
                    var chkprop = $("[id*=chkBAC]").is(':checked');
                    if (chkprop) {
                       // ocss = row.css('background-color', 'white');
                        ocss = row.find(':nth-child(' + (ccol) + ')').css('background-color');
                        row.find(':nth-child(' + (cIndex + 1) + ')').css('background-color', '#f1f8e9');
                        row.find(':nth-child(' + (cIndex ) + ')').css('background-color', ocss);
                    }
                    else {
                        ocss = row.find(':nth-child(' + (ccol) + ')').css('background-color');
                        row.find(':nth-child(' + (cIndex) + ')').css('background-color', '#f1f8e9');
                        row.find(':nth-child(' + (cIndex + 1) + ')').css('background-color', ocss);
                        //row.find("td:eq(5)").style.background-color(ocss);
                    }
                }
            });
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:HiddenField ID="hdnCompanyID" runat="server" />
    <asp:HiddenField ID="hdnConnString" runat="server" />
    <asp:HiddenField ID="hdnAllRebateLimits" runat="server" />
    <asp:HiddenField ID="hdnPFCalHeadID" runat="server" />
    <asp:HiddenField ID="hdnPTCalHeadID" runat="server" />
    <asp:HiddenField ID="hdnHRRCalHeadID" runat="server" />
    <asp:HiddenField ID="hdnPFPercentage" runat="server" />
    <asp:HiddenField ID="hdnPFLimit" runat="server" />
    <asp:HiddenField ID="hdnSurchargeType" runat="server" />
    <asp:HiddenField ID="hdnSurchargePercentage" runat="server" />
    <asp:HiddenField ID="hdnTaxShow" runat="server" />

    <asp:HiddenField runat="server" ID="hbnEmployee_ID" />
    <asp:HiddenField runat="server" ID="hdnHRA_Rent_Receipt_ID" />
    <table width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td style="height: 5px; width: 60%" class="cssPageTitle">
                <asp:Label ID="Label43" runat="server"> Manage TDS Computation</asp:Label>
            </td>
            <td style="height: 5px; width: 20%" class="cssPageTitle">
            </td>
            <td style="height: 5px; width: 20%" class="cssPageTitle">
                <div id="dvBtns">
                    <input type="button" value="Save" class="cssButton" onclick="SaveEmployeeComputation()"
                        id="btnSave" />&nbsp;&nbsp;
                    <input type="button" onclick="TDSCancel()" value="Cancel" class="cssButton" id="btncancel" />
                </div>
            </td>
        </tr>
    </table>
    <UC:MessageControl runat="server" ID="ucMessageControl" />
    <div class="tdsbody" onkeypress="return event.keyCode!=13">
        <div id="divEmployeeComputationSummary" style="margin-top: 5px;">
            <div class="indicates">
                <span style="color: Red">Note</span> : *TDS Computation
                <img src="../Images/Computation.png" />
                *Rent Details
                <img src="../Images/Rent_Home-512.png" />
                *Form 16 Part B
                <img src="../Images/form.png" />
            </div>
            <table style="border: 1px solid #BCBCBC; border-bottom: none; background-color: rgba(219,219,219,0.54);"
                cellpadding="2" cellspacing="0" width="100%">
                <tr>
                    <td>&nbsp;&nbsp;<b>Filter By :</b>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlsearch" Width="230px" CssClass="cssDropDownList" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td>&nbsp;&nbsp;<b>Employee Name</b>
                    </td>
                    <td>
                        <input type="text" onkeypress="return event.keyCode!=13" class="cssTextbox" id="txtTdsSummarysearch" />
                    </td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="button" onclick="btnTDSSummarySearchClick()" value="Search" class="cssButtonForSearch"
                            id="btnTDSSummarySearch" />
                    </td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button id="btnExportXL" runat="server" cssclass="cssButtonForSearch" text="Export XL" OnClick="btnExportXL_Click"></asp:Button>
                    </td>
                    <td>
                        <input id="RefreshAll" name="RefreshAll" type="button" cssclass="cssButtonForSearch"  value="Refresh All" />
                    </td>
                    <td style="text-align: right;">&nbsp;&nbsp;Pg Size&nbsp;
                        <asp:DropDownList ID="ddlperpage" CssClass="cssDropDownList" onchange='btnTDSSummarySearchClick()'
                            Width="60px" runat="server">
                            <asp:ListItem Value="25" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="150"></asp:ListItem>
                            <asp:ListItem Value="350"></asp:ListItem>
                            <asp:ListItem Value="1000"></asp:ListItem>
                            <asp:ListItem Value="2500"></asp:ListItem>
                            <asp:ListItem Value="5000"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
            <table id="tblPager" style="border: 1px solid #BCBCBC; border-bottom: none; background-color: rgba(219,219,219,0.54); text-align: right;"
                cellpadding="2" cellspacing="0" width="100%">
                <tr>
                    <td>
                        <div class="Pager">
                        </div>
                    </td>
                </tr>
            </table>
            <table id="tblComputationSummary" class="tbl" width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <th></th>
                    <th>#
                    </th>
                    <th width='35%'>Employee Name
                    </th>
                    <th width='10%'>Gross Salary
                    </th>
                    <th width='10%'>Agg. Chap VI A
                    </th>
                    <th width='10%'>Net Income
                    </th>
                    <th width='10%'>Tax on total income
                    </th>
                    <th width='10%'>Total Tax Deducted
                    </th>
                    <th width='10%'>Balance Tax Payable
                    </th>
                    <th>

                    </th>
                    <th></th>
                    <th></th>
                </tr>
            </table>
        </div>

        <div id="divEmployeeComputation" style="margin-top: 5px; display: block;">

            <table class="tbl dtbl" width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <th>Employee
                    </th>
                    <td colspan="5">
                        <%--<span id="FirstName">
                        </span>--%>
                        <input type="text" class="cssTextbox" onkeypress="return event.keyCode!=13" id="txtemployeesearch" />
                    </td>
                    <th style="width:60px;">Sex
                    </th>
                    <td style="width:120px;">
                        <span id="Gender" style="text-transform: uppercase;"></span>
                    </td>
                    <th style="width:120px;">PAN NO
                    </th>
                    <td style="width:120px;">
                        <span id="PAN_NO" style="text-transform: uppercase;"></span>
                    </td>
                    <td style="width:260px;">Non PAN Higher Rate(20%)</td>
                     <td  style="width:60px;"><select name="ddlHrate" id="ddlHrate">
                            <option selected="selected" value="0">No</option>
                            <option value="1">Yes</option>
                        </select>

                    </td>
                </tr>
            </table>

            <div style="height: 10px;"></div>
            <cc:TabContainer ID="TabContainer1" runat="server" CssClass="Tab" ActiveTabIndex="0" style="font-size:14px ; ">
                <cc:TabPanel ID="TabPanel1" runat="server" Width="100%"  HeaderText="Computation Details">
                    <ContentTemplate>
                        <table id="tblEmployeeTDScomputation" class="tbl maketds" width="100%" cellpadding="0"
                            cellspacing="0">
                            <tr>
                                <th></th>
                                <th>#
                                </th>
                                <th width="60%">Salary Details
                                </th>
                                <th width="10%">Amount
                                </th>
                                <th width="15%"><input type="checkbox" id="chkNrl" name="chkNrl" />&nbsp;&nbsp; Old Calculation
                                </th>
                                <th width="15%"><input type="checkbox" id="chkBAC" name="chkBAC" />&nbsp;&nbsp; 115 BAC
                                </th>

                            </tr>
                            <tr>
                                <td>
                                    <img alt="modal_GrossSalary" src="../Images/greenplus.jpg" onclick="ShowModalPopups('modal_GrossSalary')"
                                        style="height: 20px; width: 20px;" />
                                    <div id="modal_GrossSalary" data-modalheader='Gross Salary' class="modalScreen" style="display: none"
                                        data-height="180" data-width="830">
                                        <table id="tblGrossDalary" runat="server" width="100%">
                                            <tr runat="server">
                                                <td runat="server">
                                                    <asp:Label ID="Label6" runat="server" CssClass="cssLabel" Text=" (a) Salary as per provisions contained in sec. 17(1)"></asp:Label>
                                                </td>
                                                <td width="120px" style="padding-right: 16px;" runat="server">
                                                    <span class="spanwithno getTotalCal1 grosssalarytotal" data-getclasstotal="monthlysalarytotal"
                                                        id="txtSalaryAsPerProvisions"></span>
                                                </td>
                                                <td width="70px" runat="server">
                                                    <input type="button" class="cssButton" onclick="ShowModalPopups('modal_dialog_MonthlySalary')"
                                                        value="Click" />
                                                </td>
                                            </tr>
                                            <tr runat="server">
                                                <td runat="server">
                                                    <asp:Label ID="Label9" runat="server" CssClass="cssLabel" Text=" (b) Value of perquisites u/s 17(2)
                                            (as per Form No. 12BA, wherever applicable)"></asp:Label>
                                                </td>
                                                <td style="padding-right: 16px;" runat="server">
                                                    <span class="spanwithno getTotalCal2 grosssalarytotal" id="txtValueOfPerquisites"
                                                        data-getclasstotal="perquisitesAllTotal"></span>
                                                </td>
                                                <td runat="server">
                                                    <input type="button" class="cssButton" onclick="ShowModalPopups('modal_dialog_Pretiquites')"
                                                        value="Click" />
                                                </td>
                                            </tr>
                                            <tr runat="server">
                                                <td runat="server">
                                                    <asp:Label ID="Label10" runat="server" CssClass="cssLabel" Text=" (c) Profits in lieu of salary under section 17(3)
                                             (as per Form No. 12BA, wherever applicable)"></asp:Label>
                                                </td>
                                                <td style="padding-right: 16px; text-align: right;" runat="server">
                                                    <input type="text" style="width: 128px;" class="cssTextboxInt grosssalarytotal" id="txtSalaryUnderSection" />
                                                </td>
                                            </tr>
                                            <tr runat="server">
                                                <td runat="server">
                                                    <asp:Label ID="Label11" Font-Bold="True" runat="server" CssClass="cssLabel" Text=" (d) Total"></asp:Label>
                                                </td>
                                                <td style="font-weight: bold; text-align: right; padding-right: 16px;" runat="server">
                                                    <span class="spanwithno getTotalCal3" id="txtGrossSalaryTotal" data-getclasstotal="grosssalarytotal"></span>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="modal_dialog_MonthlySalary" data-modalheader="Salary Details" style="display: none;"
                                        data-height="548" data-width="1000">
                                        <table id="Table2" runat="server">
                                            <tr runat="server">
                                                <td runat="server">
                                                    <div style="overflow: auto;">
                                                        <asp:Label ID="lblColumnCount" runat="server" CssClass="cssLabel"></asp:Label>
                                                        <asp:Label ID="lblDgMonthlySalaryMSG" runat="server" CssClass="cssLabel"></asp:Label>
                                                        <div style="overflow: auto; max-width: 960px;">
                                                            <table id="tblMonthlySalary" class="tbl" width="100%">
                                                            </table>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="modal_dialog_Pretiquites" data-modalheader="Perquisites" style="display: none"
                                        data-height="600" data-width="800">
                                        <table id="tblPerquisites" class="tbl" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>No </th>
                                                    <th width="60%">Perquisites Name </th>
                                                    <th>Perquisites Value </th>
                                                    <th>Paid Amount </th>
                                                    <th>Tax Amount </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>

                                </td>
                                <td>1
                                </td>
                                <td style="font-weight: bold;">Gross Total Salary.
                                </td>
                                <td></td>
                                <td><span class="spanwithno  getTotalCal3" id="txtGrossSalary"></span></td>
                                <td><span class="spanwithno  getTotalCal3" id="txtGrossSalarySH"></span></td>

                            </tr>
                            <tr>
                                <td>
                                    <img src="../Images/greenplus.jpg" style="height: 20px; width: 20px;" onclick="ShowModalPopups('modal_dialog_Section10')" />
                                    <div id="modal_dialog_Section10" data-modalheader="Section 10" style="display: none"
                                        data-height="auto" data-width="500">

                                        <table id="tblSectionten" class="tbl" width="100%">
                                            <thead>
                                                <tr>
                                                    <th># </th>
                                                    <th>Heads Name </th>
                                                    <th>Amount </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>

                                                    <td>1    
                                                    </td>
                                                    <td>a) House Rent Allowance</td>
                                                    <td><input type="text"  id="txtHRA"  class="cssTextboxInt" /></td>


                                                </tr>
                                                <tr>
                                                    <td>2 
                                                    </td>
                                                    <td>b) Travel Concession</td>
                                                    <td><input type="text"  id="txtTravel"  class="cssTextboxInt" /></td>


                                                </tr>
                                                <tr>

                                                    <td>3 
                                                    </td>
                                                    <td>c) Pension </td>
                                                    <td><input type="text"  id="txtPension"  class="cssTextboxInt" /></td>


                                                </tr>
                                                <tr>

                                                    <td>4
                                                    </td>
                                                    <td>d) Gratuity</td>
                                                    <td><input type="text"  id="txtGratuity"  class="cssTextboxInt" /></td>


                                                </tr>
                                                <tr>

                                                    <td>4
                                                    </td>
                                                    <td>e) Leave Encashment</td>
                                                    <td><input type="text"  id="txtLeave"  class="cssTextboxInt" /></td>


                                                </tr>
                                                <tr>
                                                    <td>5 
                                                    </td>
                                                    <td>f) Others </td>
                                                    <td><input type="text"  id="txtSOthers"  class="cssTextboxInt" /></td>


                                                </tr>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <th></th>
                                                    <th>Total </th>
                                                    <th><span class="spanwithno getTotalCal4" data-getclasstotal="sectiontenAmountPerheadid">0 </span></th>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                </td>
                                <td>2
                                </td>
                                <td>Less:Allowance to the extent exempt under section 10
                                </td>
                                <td></td>
                                <td>
                                    <span id="txtSection10" class="spanwithno getTotalCal4"></span>
                                </td>
                                <td>
                                    <span id="txtSection10SH" class="spanwithno"></span>
                                </td>

                            </tr>


                            <tr>
                                <td>
                                </td>
                                <td>3
                                </td>
                                <td style="font-weight: bold;">BALANCE (1-2) / Previous Employer Taxable Salary
                                </td>
                                <td><input type="text" style="width: 128px;" class="cssTextboxInt" id="txtPreviousTaxableSalary" /></td>
                                <td style="font-weight: bold;">
                                    <span id="txtTaxableBalance" class="spanwithno" ></span>
                                </td>
                                <td style="font-weight: bold;">
                                    <span id="txtTaxableBalanceSH" class="spanwithno" ></span>
                                </td>

                            </tr>
                            <tr>
                                <td>
                                    <img src="../Images/greenplus.jpg" style="height: 20px; width: 20px;" onclick="ShowModalPopups('modal_dialog_Deductions')" />
                                    <div id="modal_dialog_Deductions" data-modalheader="Deductions" style="display: none"
                                        data-height="200" data-width="380">
                                        <table width="100%">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label2" runat="server" Text="(a) Standard Deduction" CssClass="cssLabel"></asp:Label>
                                                </td>
                                                <td>
                                                    <input type="text" style="width: 100px;" class="cssTextboxInt getdeductionstotal"
                                                        id="txtStandardDeductions" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label78" runat="server" Text="(a) Entertainment Allowance" CssClass="cssLabel"></asp:Label>
                                                </td>
                                                <td>
                                                    <input type="text" style="width: 100px;" class="cssTextboxInt getdeductionstotal"
                                                        id="txtEntertainmentAllowance" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label79" runat="server" Text="(b) Tax on Employeement" CssClass="cssLabel"></asp:Label>
                                                </td>
                                                <td style="padding-right: 6px;">
                                                    <input type="text" style="width: 100px;" class="cssTextboxInt getdeductionstotal"
                                                        id="txtTaxonEmployeement"></input>
                                                </td>
                                                <td>

                                                </td>
                                            </tr>
                                            <tr>
                                                <th>
                                                    <asp:Label ID="Label80" runat="server" Text="Total" CssClass="cssLabel"></asp:Label>
                                                </th>
                                                <th style="padding-right: 6px;">
                                                    <span class="spanwithno getTotalCal7" data-getclasstotal="getdeductionstotal" id="txtDeductionTotal">0 </span>
                                                </th>
                                            </tr>
                                        </table>
                                    </div>

                                </td>
                                <td>4
                                </td>
                                <td>Deductions (a),(b)
                                </td>
                                <td></td>
                                <td>
                                    <span id="txtDeductions" class="spanwithno getTotalCal8" data-getclasstotal="getTotalCal7"></span>
                                </td>
                                <td>
                                    <span id="txtDeductionsSH" class="spanwithno " ></span>
                                </td>

                            </tr>
                            <tr>
                                <td></td>
                                <td>5
                                </td>
                                <td style="font-weight: bold;">Income chargeable under the head Salaries (3-4)
                                </td>
                                <td></td>
                                <td style="font-weight: bold;">
                                    <span id="txtIncomecharge" class="spanwithno" ></span>
                                </td>
                                <td style="font-weight: bold;">
                                    <span id="txtIncomechargeSH" class="spanwithno"></span>
                                </td>

                            </tr>
                            <tr>
                                <td></td>
                                <td>6
                                </td>
                                <td>Other Income
                                </td>
                                <td>
                                    <input type="text" id="txtOtherIncome" class="cssTextboxInt" />
                                </td>
                                <td>

                                </td>
                                <td>
                                  <%-- <span id="txtOtherIncomeSH" class="spanwithno" ></span>  --%>
                                </td>

                            </tr>
                            <tr>
                                <td></td>
                                <td>7
                                </td>
                                <td>Less: Int. on Housing Loan
                                </td>
                                <td>
                                    <input type="text" id="txtHousingLoan" class="cssTextboxInt" />
                                </td>
                                <td>

                                </td>
                                <td>
                                   <%-- <span  id="txtHousingLoanSH" class="spanwithno" />--%>
                                </td>

                            </tr>
                            <tr>
                                <td></td>
                                <td>8
                                </td>
                                <td style="font-weight: bold;">Gross total income(5+6-7)
                                </td>
                                <td>

                                </td>
                                <td style="font-weight: bold;">
                                    <span id="txtGrossTotalIncome" class="spanwithno"></span>
                                </td>
                                <td style="font-weight: bold;">
                                   <span id="txtGrossTotalIncomeSH" class="spanwithno"></span>  
                                </td>

                            </tr>
                            <tr>
                                <td>
                                    <img src="../Images/greenplus.jpg" style="height: 20px; width: 20px;" onclick="ShowModalPopups('modal_dialog_Section80C')" />
                                    <div id="modal_dialog_Section80C" data-modalheader="Investment Under Section 80C, CCC, CCD, CCD2"
                                        style="display: none" data-height="480" data-width="800">
                                        <table width="100%">

                                            <tr>
                                                <td align="right">
                                                    <table id="Table1" width="100%">
                                                        <tr>
                                                            <td style="width: 10px;"></td>
                                                            <td style="width: 380px;"></td>
                                                            <td width="20%" style="padding-left: 80px;">
                                                                <asp:Label ID="Label19" runat="server" Text="Investment" Style="font-weight: bold;" CssClass="cssLabel"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label21" runat="server" Text="Deduction" Style="width: 120px; font-weight: bold;" CssClass="cssLabel"></asp:Label>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td style="width: 10px;"></td>
                                                            <td style="width: 380px;">
                                                                <asp:Label ID="Label90" runat="server" Text="Section 80C" CssClass="cssLabel"></asp:Label>
                                                            </td>
                                                            <td width="20%" style="padding-left: 80px;">
                                                                <input type="text" id="txtRebate80C" style="width: 90px;" value="0" class="cssTextboxInt Rblur" />
                                                            </td>
                                                            <td width="120px">
                                                                <input type="text" id="txtRebate80C_Ded" style="width: 90px;" value="0" class="cssTextboxInt section80candsection80c Rblur_ded" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 10px;"></td>
                                                            <td style="width: 380px;">
                                                                <asp:Label ID="Label89" runat="server" Text="Section 80CCC" CssClass="cssLabel"></asp:Label>
                                                            </td>
                                                            <td width="20%" style="padding-left: 80px;">
                                                                <input type="text" id="txtRebate80CCC" style="width: 90px;" value="0" class="cssTextboxInt Rblur" />
                                                            </td>
                                                            <td width="120px">
                                                                <input type="text" id="txtRebate80CCC_Ded" style="width: 90px;" value="0" class="cssTextboxInt section80ccandsection80ccd Rblur_ded" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 10px;"></td>
                                                            <td style="width: 380px;">
                                                                <asp:Label ID="Label91" runat="server" Text="Section 80CCD(1)" CssClass="cssLabel"></asp:Label>
                                                            </td>
                                                            <td width="20%" style="padding-left: 80px;">
                                                                <input type="text" id="txtReb80CCD" style="width: 90px;" value="0" class="cssTextboxInt Rblur" />
                                                            </td>
                                                            <td width="120px">
                                                                <input type="text" id="txtReb80CCD_Ded" style="width: 90px;" value="0" class="cssTextboxInt section80ccandsection80ccd Rblur_ded" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 10px;"></td>
                                                            <td style="text-align: left; width: 380px;">
                                                                <asp:Label ID="Label92" Font-Bold="True" runat="server" Text="Qualifying Amount"
                                                                    CssClass="cssLabel"></asp:Label>
                                                            </td>
                                                            <td></td>
                                                            <td style="text-align: right; font-weight: bold; padding-right: 60px;">
                                                                <span class="spanwithno" id="txtRebate80QlfySalLimit">150000</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 10px;"></td>
                                                            <td style="text-align: left; width: 380px; font-weight: bold">Total
                                                            </td>
                                                            <td></td>
                                                            <td style="text-align: right; font-weight: bold; padding-right: 60px;">
                                                                <span id="lblpftotalgrid" class="spanwithno getTotalCal10 point9total" data-getclasstotal="section80ccandsection80ccd">0</span>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td style="width: 10px;"></td>
                                                            <td style="width: 380px;">
                                                                <asp:Label ID="Label1" runat="server" Text="Section 80CCD(1B)" CssClass="cssLabel"></asp:Label>
                                                            </td>
                                                            <td width="30%" style="padding-left: 80px;">
                                                                <input type="text" id="txtRebate80CCD21b" style="width: 90px;" value="0" class="cssTextboxInt Rblur" />
                                                            </td>
                                                            <td>
                                                                <input type="text" id="txtRebate80CCD21b_Ded" style="width: 90px;" value="0" class="cssTextboxInt point9total Rblur_ded" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 10px;"></td>

                                                            <td style="width: 380px;">
                                                                <asp:Label ID="Label13" runat="server" Text="Section 80CCD2" CssClass="cssLabel"></asp:Label>
                                                            </td>
                                                            <td width="20%" style="padding-left: 80px;">
                                                                <input type="text" id="txtRebate80CCD2" style="width: 90px;" value="0" class="cssTextboxInt Rblur" />
                                                            </td>
                                                            <td>
                                                                <input type="text" id="txtRebate80CCD2_Ded" style="width: 90px;" value="0" class="cssTextboxInt point9total Rblur_ded" />
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td style="width: 10px;"></td>

                                                            <td style="width: 380px;">
                                                                <asp:Label ID="Label26" runat="server" Text="Rebate  80D (Medical insurance premia)"
                                                                    CssClass="cssLabel"></asp:Label>
                                                            </td>
                                                            <td width="20%" style="padding-left: 80px;">
                                                                <input type="text" style="width: 100px;" id="txtRebate80D" class="cssTextboxInt Rblur"
                                                                    data-limit="0" />
                                                            </td>
                                                           
                                                            <td>
                                                                <input type="text" style="width: 100px;" id="txtRebate80D_Ded" class="cssTextboxInt  pointtentotaldeduction Rblur_ded"
                                                                    data-limit="0" />
                                                            </td>

                                                        </tr>
                                                         <tr>
                                                            <td style="width: 10px;"></td>

                                                            <td style="width: 380px;">
                                                                <asp:Label ID="Label4" runat="server" Text="Rebate 80E" CssClass="cssLabel"></asp:Label>
                                                            </td>
                                                            <td width="20%" style="padding-left: 80px;">
                                                                <input type="text" style="width: 100px;" id="txtRebate80E" class="cssTextboxInt Rblur"
                                                                    data-limit="0" />
                                                            </td>
                                                            
                                                            <td>
                                                                <input type="text" style="width: 100px;" id="txtRebate80E_Ded" class="cssTextboxInt pointtentotaldeduction Rblur_ded"
                                                                    data-limit="0" />
                                                            </td>

                                                        </tr>
                                                       <tr>
                                                            <td style="width: 10px;"></td>

                                                            <td style="width: 380px;">
                                                                <asp:Label ID="Label5" runat="server" Text="Rebate 80G" CssClass="cssLabel"></asp:Label>
                                                            </td>
                                                            <td width="20%" style="padding-left: 80px;">
                                                                <input type="text" style="width: 100px;" id="txtRebate80G" class="cssTextboxInt RqlBr"
                                                                    data-limit="0" />
                                                            </td>

                                                            <td>
                                                                <input type="text" style="width: 100px;" id="txtRebate80G_Ded" class="cssTextboxInt pointtentotaldeduction Rblur_ded"
                                                                    data-limit="0" />
                                                            </td>

                                                        </tr>

                                                        <tr>
                                                            <td style="width: 10px;"></td>

                                                            <td style="width: 380px;">
                                                                <asp:Label ID="Label12" runat="server" Text="Rebate  80TTA (Saving Bank Interest.)"
                                                                    CssClass="cssLabel"></asp:Label>
                                                            </td>
                                                            <td width="20%" style="padding-left: 80px;">
                                                                <input type="text" style="width: 100px;" id="txtRebate80TTA" data-limit="0" class="cssTextboxInt " />
                                                            </td>

                                                            <td>
                                                                <input type="text" style="width: 100px;" id="txtRebate80TTA_Ded" data-limit="0" class="cssTextboxInt pointtentotaldeduction Rblur_ded" />
                                                            </td>

                                                        </tr>

                                                        <tr>
                                                            <td style="width: 10px;"></td>

                                                            <td style="width: 380px;">
                                                            <asp:Label ID="Label7" runat="server" Text="Rebate 80U (Physical disability)" CssClass="cssLabel"></asp:Label>
                                                            </td>
                                                            <td width="20%" style="padding-left: 80px;">
                                                            <input type="text" style="width: 100px;" id="txtRebate80U" class="cssTextboxInt RqlBr" />
                                                            </td>

                                                            <td>
                                                            <input type="text" style="width: 100px;" id="txtRebate80U_Ded" class="cssTextboxInt pointtentotaldeduction Rblur_ded" />
                                                            </td>

                 
                                                        </tr>


                                                        <tr>
                                                            <td style="width: 10px;"></td>
                                                            <td style="text-align: left; width: 380px;">
                                                                <asp:Label ID="Label94" runat="server" Font-Bold="True" Text="Aggregate of Tax Rebate and Relief"
                                                                    CssClass="cssLabel" ClientIDMode="Static"></asp:Label>
                                                            </td>
                                                            <td></td>
                                                            <td style="text-align: right; font-weight: bold; padding-right: 60px;">
                                                                <span id="txAggregateOfTaxRebateAndRelief" class="spanwithno getTotalCal11" data-getclasstotal="point9total">0</span>
                                                            </td>

                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td>9
                                </td>
                                <td>Section 80C (Various investments)
                                </td>
                                <td></td>
                                <td>
                                    <span id="txtSection80CVariousInvestments" class="spanwithno getTotalCal11"></span>
                                </td>
                                <td>
                                    <span id="txtSection80CVariousInvestmentsSH" class="spanwithRB"></span>
                                </td>

                            </tr>
                            <tr>
                                <td>

                                </td>
                                <td>10
                                </td>
                                <td  style="font-weight: bold;">Total Deductions U/S VI(A)
                                </td>
                                <td></td>
                                <td style="font-weight: bold;">
                                    <span id="txtAggregateoftaxrebates" class="spanwithno getTotalCal12" data-getclasstotal="pointtentotaldeduction"></span>
                                </td>
                                <td style="font-weight: bold;">
                                    <span id="txtAggregateoftaxrebatesSH" class="spanwithRB "></span>
                                </td>

                            </tr>
                            <tr>
                                <td></td>
                                <td>11
                                </td>
                                <td style="font-weight: bold;">Aggregate of tax rebates and relief
                                </td>
                                <td>

                                </td>
                                <td style="font-weight: bold;">
                                    <span id="lblAggregateoftax" class="spanwithno"></span>
                                </td>
                                <td style="font-weight: bold;">
                                    <span id="lblAggregateoftaxSH" class="spanwithno"></span>
                                </td>

                            </tr>
                            <tr>
                                <td></td>
                                <td>12
                                </td>
                                <td>Net Income
                                </td>
                                <td>

                                </td>
                                <td>
                                    <span id="txtNetIncome" class="spanwithno"></span>
                                </td>
                                <td>
                                    <span id="txtNetIncomeSH" class="spanwithno"></span>
                                </td>

                            </tr>
                            <tr>
                                <td></td>
                                <td>13
                                </td>
                                <td  style="font-weight: bold;">Tax on total income
                                   <input type="button" class="cssButton" value="Tax Slab" onclick="ShowModalPopups('modal_dialog_Liability')" />
                                    <div id="modal_dialog_Liability" data-modalheader="Tax on total income" style="display: none;"
                                        data-height="285" data-width="800">
                                        <table border="1" style="border-collapse: collapse; border: 1px solid #dbdbdb;" cellpadding="5"
                                            width="100%" cellspacing="5">
                                            <tr class="cssGridHeader">
                                                <th style="text-align: left;">Description
                                                </th>
                                                <th style="text-align: right;">Slab
                                                </th>
                                                <th style="text-align: right;">Income
                                                </th>
                                                <th style="text-align: right;">Income Tax
                                                </th>
                                            </tr>
                                            <tr class="cssGridAlternatingItemStyle">
                                                <td>Exempt Income
                                        <asp:Label ID="lblSlabPer1" runat="server"></asp:Label>%
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblSlab1" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncome1" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncomeTax1" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr class="cssGridAlternatingItemStyle">
                                                <td>Income chargeable at
                                        <asp:Label ID="lblSlabPer2" runat="server"></asp:Label>%
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblSlab2" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncome2" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncomeTax2" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr class="cssGridAlternatingItemStyle">
                                                <td>Income chargeable at
                                        <asp:Label ID="lblSlabPer3" runat="server"></asp:Label>%
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblSlab3" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncome3" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncomeTax3" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr class="cssGridAlternatingItemStyle">
                                                <td>Income chargeable at
                                                <asp:Label ID="lblSlabPer4" runat="server"></asp:Label>%
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblSlab4" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncome4" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncomeTax4" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                            </tr>
 <%--                                           <tr class="cssGridAlternatingItemStyle" id="iTaxTr5">
                                                <td>Income chargeable at
                                        <asp:Label ID="lblSlabPer5" runat="server"></asp:Label>%
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblSlab5" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncome5" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncomeTax5" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                            </tr>--%>
<%--                                            <tr class="cssGridAlternatingItemStyle" id="iTaxTr6">
                                                <td>Income chargeable at
                                        <asp:Label ID="lblSlabPer6" runat="server"></asp:Label>%
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblSlab6" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncome6" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncomeTax6" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                            </tr>--%>
                                            <tr class="cssGridHeader" style="font-weight: bold;">
                                                <td>Total
                                                </td>
                                                <td></td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncomeTotal" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncomeTaxTotal" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td>
                                   <input type="button" class="cssButton" value="115 BAC Tax Slab" onclick="ShowModalPopups('modal_115')" />
                                    <div id="modal_115" data-modalheader="Tax on total income" style="display: none;"
                                        data-height="285" data-width="800">
                                        <table border="1" style="border-collapse: collapse; border: 1px solid #dbdbdb;" cellpadding="5"
                                            width="100%" cellspacing="5">
                                            <tr class="cssGridHeader">
                                                <th style="text-align: left;">Description
                                                </th>
                                                <th style="text-align: right;">Slab
                                                </th>
                                                <th style="text-align: right;">Income
                                                </th>
                                                <th style="text-align: right;">Income Tax
                                                </th>
                                            </tr>
                                            <tr class="cssGridAlternatingItemStyle">
                                                <td>Exempt Income
                                                <asp:Label ID="lblSlabPer1SH" runat="server"></asp:Label>%
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblSlab1SH" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncome1SH" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncomeTax1SH" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr class="cssGridAlternatingItemStyle">
                                                <td>Income chargeable at
                                                 <asp:Label ID="lblSlabPer2SH" runat="server"></asp:Label>%
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblSlab2SH" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncome2SH" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncomeTax2SH" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr class="cssGridAlternatingItemStyle">
                                                <td>Income chargeable at
                                                <asp:Label ID="lblSlabPer3SH" runat="server"></asp:Label>%
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblSlab3SH" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncome3SH" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncomeTax3SH" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr class="cssGridAlternatingItemStyle">
                                                <td>Income chargeable at
                                                <asp:Label ID="lblSlabPer4SH" runat="server"></asp:Label>%
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblSlab4SH" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncome4SH" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncomeTax4SH" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr class="cssGridAlternatingItemStyle" id="iTaxTr5">
                                                <td>Income chargeable at
                                                <asp:Label ID="lblSlabPer5SH" runat="server"></asp:Label>%
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblSlab5SH" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncome5SH" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncomeTax5SH" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr class="cssGridAlternatingItemStyle" id="iTaxTr6">
                                                <td>Income chargeable at
                                                <asp:Label ID="lblSlabPer6SH" runat="server"></asp:Label>%
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblSlab6SH" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncome6SH" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncomeTax6SH" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr class="cssGridHeader" style="font-weight: bold;">
                                                <td>Total
                                                </td>
                                                <td></td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncomeTotalSH" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblIncomeTaxTotalSH" CssClass="spanwithno" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td style="font-weight: bold;">
                                    <span id="txtTaxonTotalIncome" class="spanwithno"></span>
                                </td>
                                <td style="font-weight: bold;">
                                    <span id="txtTaxonTotalIncomeSH" class="spanwithno"></span>
                                </td>

                            </tr>
                            <tr>
                                <td></td>
                                <td>14
                                </td>
                                <td>Rebate 87A
                                </td>
                                <td></td>
                                <td>
                                    <span id="txtRebate87A" ></span>
                                </td>
                                <td>
                                    <span id="txtRebate87ASH" ></span>
                                </td>

                            </tr>
                            <tr>
                                <td></td>
                                <td>15
                                </td>
                                <td  style="font-weight: bold;">Tax payable 
                                </td>
                                <td></td>
                                <td style="font-weight: bold;">
                                    <span id="txtTaxPayableAndSurcharge" ></span>
                                </td>
                                <td style="font-weight: bold;">
                                    <span id="txtTaxPayableAndSurchargeSH" ></span>
                                </td>

                            </tr>

                            <tr>
                                <td></td>
                                <td>16
                                </td>
                                <td  style="font-weight: bold;">Surcharge
                                </td>
                                <td></td>
                                <td style="font-weight: bold;">
                                    <span id="txtSurcharge" ></span>
                                </td>
                                <td style="font-weight: bold;">
                                    <span id="txtSurchargeSH" ></span>
                                </td>

                            </tr>


                            <tr>
                                <td></td>
                                <td>17
                                </td>
                                <td>Health and Education Cess
                                </td>
                                <td></td>
                                <td>
                                    <span id="txtEducationCess"></span>
                                </td>
                                <td>
                                    <span id="txtEducationCessSH" ></span>
                                </td>

                            </tr>
                            <tr>
                                <td></td>
                                <td>18
                                </td>
                                <td  style="font-weight: bold;">Tax Payable
                                </td>
                                <td></td>
                                <td style="font-weight: bold;">
                                    <span id="txtTaxPay"  ></span>
                                </td>
                                <td style="font-weight: bold;">
                                    <span id="txtTaxPaySH" c></span>
                                </td>

                            </tr>
                            <tr>
                                <td></td>
                                <td>19
                                </td>
                                <td>Under Section 89
                                </td>
                                <td>
                                    <input type="text" id="txtUnderSection89" class="cssTextboxInt" />
                                </td>
                                <td>
                                    <%--<span id="txtUnderSection89" class="spanwithno"></span>--%>
                                </td>
                                <td>
                                    <%--<span id="txtUnderSection89SH" class="spanwithno"></span>   --%>                                 
                                </td>

                            </tr>
                            <tr>
                                <td>
                                    <img src="../Images/greenplus.jpg" style="height: 20px; width: 20px;" onclick="ChallanShow()" /></td>
                                <td>20
                                </td>
                                <td>Less:a.Tax deducted at source U/s 192(1)
                                </td>
                                <td>

                                </td>
                                <td style="font-weight: bold;">
                                    <span id="txtTaxDeductedAtSource" class="spanwithno"></span>
                                </td>
                                <td style="font-weight: bold;">
                                    <span id="txtTaxDeductedAtSourceSH" class="spanwithno"></span>
                                </td>

                            </tr>
                            <tr id="tbltr">
                                <td></td>
                                <td></td>
                                <td>
                                    <table id="tblChnl" name="tblChnl">
                                        <tr>
                                            <td></td>
                                        </tr>
                                    </table>
                                </td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>21
                                </td>
                                <td>b.Tax deducted by Pre Employer
                                </td>
                                <td>
                                    <input type="text" id="txtTaxDeductedbyPreEmployer" class="cssTextboxInt" />
                                </td>
                                <td>

                                </td>
                                <td>
                                    <%--<span  id="txtTaxDeductedbyPreEmployerSH" class="cssTextboxInt" />--%>
                                </td>

                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <b>22</b>
                                </td>
                                <td>
                                    <b>Tax payable/refundable</b>
                                </td>
                                <td></td>
                                <td>
                                    <b><span id="lastpayabletax" class="spanwithno"></span></b>
                                </td>
                                <td>
                                    <b><span id="lastpayabletaxSH" class="spanwithno"></span></b>
                                </td>
                                
                            </tr>

                            <tr >
                               <td><img src="../Images/greenplus.jpg" style="height: 20px; width: 20px;" onclick="ShowModalPopups('modal_dialog_LLRent')" />
                                    <div id="modal_dialog_LLRent" data-modalheader="LandLord Rent" style="display: none"
                                        data-height="auto" data-width="500">
                                        <table class="tbl" width="100%" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <th width="80%">Description
                                            </th>
                                            <th width="20%">Details
                                            </th>
                                        </tr>
                                        <tr style="color: Red;">
                                            <td>Whether aggregate rent(HRR) payment exceeds <u>rupees one lakh (Rs.100000/-)</u>
                                                during previous year
                                            </td>
                                            <td>
                                                <select id="Rent_Payment" class="cssDropDownList" data-hideclass="partone">
                                                    <option value="true">Yes</option>
                                                    <option selected value="false">No</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr class="partone">
                                            <td>PAN of landlord 1<span class="showPanError"></span><span class="showPanSuccess"></span>
                                            </td>
                                            <td>
                                                <input id="PAN_landlord1" maxlength="10" style="text-transform: uppercase;" type="text"
                                                    class="cssTextbox" />
                                            </td>
                                        </tr>
                                        <tr class="partone">
                                            <td>Name of landlord 1
                                            </td>
                                            <td>
                                                <input id="Name_landlord1" type="text" class="cssTextbox" />
                                            </td>
                                        </tr>
                                        <tr class="partone">
                                            <td>PAN of landlord 2<span class="showPanError"></span><span class="showPanSuccess"></span>
                                            </td>
                                            <td>
                                                <input id="PAN_landlord2" maxlength="10" style="text-transform: uppercase;" type="text"
                                                    class="cssTextbox" />
                                            </td>
                                        </tr>
                                        <tr class="partone">
                                            <td>Name of landlord 2
                                            </td>
                                            <td>
                                                <input id="Name_landlord2" type="text" class="cssTextbox" />
                                            </td>
                                        </tr>
                                        <tr class="partone">
                                            <td>PAN of landlord 3<span class="showPanError"></span><span class="showPanSuccess"></span>
                                            </td>
                                            <td>
                                                <input id="PAN_landlord3" maxlength="10" style="text-transform: uppercase;" type="text"
                                                    class="cssTextbox" />
                                            </td>
                                        </tr>
                                        <tr class="partone">
                                            <td>Name of landlord 3
                                            </td>
                                            <td>
                                                <input id="Name_landlord3" type="text" class="cssTextbox" />
                                            </td>
                                        </tr>
                                        <tr class="partone">
                                            <td>PAN of landlord 4<span class="showPanError"></span><span class="showPanSuccess"></span>
                                            </td>
                                            <td>
                                                <input id="PAN_landlord4" maxlength="10" style="text-transform: uppercase;" type="text"
                                                    class="cssTextbox" />
                                            </td>
                                        </tr>
                                        <tr class="partone">
                                            <td>Name of landlord 4
                                            </td>
                                            <td>
                                                <input id="Name_landlord4" type="text" class="cssTextbox" />
                                            </td>
                                        </tr>
                                    </table>
                                    </div> 
                               </td>
                                <td>
                                    <b>23</b>
                                </td>
                                <td>Whether aggregate rent(HRR) payment exceeds <u>rupees one lakh (Rs.100000/-)</u>
                                    during previous year
                                </td>
                                <td>                                   
                                </td>
                                <td>                                   
                                </td>
                                <td>                                   
                                </td>
                            </tr>

                            <tr>
                               <td><img src="../Images/greenplus.jpg" style="height: 20px; width: 20px;" onclick="ShowModalPopups('modal_dialog_LLIncome')" />
                                    <div id="modal_dialog_LLIncome" data-modalheader="Income from house property" style="display: none"
                                        data-height="auto" data-width="500">
                                        <table class="tbl" width="100%" cellpadding="0" cellspacing="0">
                                            <tr style="color: Red;">
                                                <td>Whether Interest paid to the lender under the head 'Income from house property'
                                                </td>
                                                <td>
                                                    <select id="Interest_lender" class="cssDropDownList" data-hideclass="parttwo">
                                                        <option value="true">Yes</option>
                                                        <option selected value="false">No</option>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr class="parttwo">
                                                <td>Deduction of interest under the head income from house property - PAN of lender
                                                    1<span class="showPanError"></span><span class="showPanSuccess"></span>
                                                </td>
                                                <td>
                                                    <input id="PAN_lender1" maxlength="10" style="text-transform: uppercase;" type="text"
                                                        class="cssTextbox" />
                                                </td>
                                            </tr>
                                            <tr class="parttwo">
                                                <td>Deduction of interest under the head income from house property - Name of lender
                                                    1
                                                </td>
                                                <td>
                                                    <input id="Name_lender1" type="text" class="cssTextbox" />
                                                </td>
                                            </tr>
                                            <tr class="parttwo">
                                                <td>Deduction of interest under the head income from house property - PAN of lender
                                                    2<span class="showPanError"></span><span class="showPanSuccess"></span>
                                                </td>
                                                <td>
                                                    <input id="PAN_lender2" maxlength="10" style="text-transform: uppercase;" type="text"
                                                        class="cssTextbox" />
                                                </td>
                                            </tr>
                                            <tr class="parttwo">
                                                <td>Deduction of interest under the head income from house property - Name of lender
                                                    2
                                                </td>
                                                <td>
                                                    <input id="Name_lender2" type="text" class="cssTextbox" />
                                                </td>
                                            </tr>
                                            <tr class="parttwo">
                                                <td>Deduction of interest under the head income from house property - PAN of lender
                                                    3<span class="showPanError"></span><span class="showPanSuccess"></span>
                                                </td>
                                                <td>
                                                    <input id="PAN_lender3" maxlength="10" style="text-transform: uppercase;" type="text"
                                                        class="cssTextbox" />
                                                </td>
                                            </tr>
                                            <tr class="parttwo">
                                                <td>Deduction of interest under the head income from house property - Name of lender
                                                    3
                                                </td>
                                                <td>
                                                    <input id="Name_lender3" type="text" class="cssTextbox" />
                                                </td>
                                            </tr>
                                            <tr class="parttwo">
                                                <td>Deduction of interest under the head income from house property - PAN of lender
                                                    4<span class="showPanError"></span><span class="showPanSuccess"></span>
                                                </td>
                                                <td>
                                                    <input id="PAN_lender4" maxlength="10" style="text-transform: uppercase;" type="text"
                                                        class="cssTextbox" />
                                                </td>
                                            </tr>
                                            <tr class="parttwo">
                                                <td>Deduction of interest under the head income from house property - Name of lender
                                                    4
                                                </td>
                                                <td>
                                                    <input id="Name_lender4" type="text" class="cssTextbox" />
                                                </td>
                                            </tr>

                                        </table>
                                    </div>                                    
                                </td>
                                <td>                                   
                                 24
                                </td>
                                <td>Whether Interest paid to the lender under the head 'Income from house property'
                                </td>
                                <td>                                   
                                </td>
                                <td>                                   
                                </td>
                                <td>                                   
                                </td>
                            </tr>

                            <tr >
                                <td><img src="../Images/greenplus.jpg" style="height: 20px; width: 20px;" onclick="ShowModalPopups('modal_dialog_superannuation')" />
                                    <div id="modal_dialog_superannuation" data-modalheader="Superannuation Fund" style="display: none"
                                        data-height="auto" data-width="500">
                                        <table class="tbl" width="100%" cellpadding="0" cellspacing="0">
                                            <tr style="color: Red;">
                                                <td>Whether contributions paid by the trustees of an approved superannuation fund
                                                </td>
                                                <td>
                                                    <select id="Contributions_superannuation_fund" class="cssDropDownList" data-hideclass="partthree">
                                                        <option value="true">Yes</option>
                                                        <option selected value="false">No</option>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr class="partthree">
                                                <td>Name of the superannuation fund
                                                </td>
                                                <td>
                                                    <input id="Name_superannuation_fund" type="text" class="cssTextbox" />
                                                </td>
                                            </tr>
                                            <tr class="partthree">
                                                <td>Date from which the employee has contributed to the superannuation fund
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="Frm_DT_superannuation_fund" ClientIDMode="Static" ReadOnly="true"
                                                        Width="100px" CssClass="cssTextbox" runat="server"></asp:TextBox>
                                                    <asp:ImageButton ID="ImageButton2" ImageUrl="~/Images/calendar.gif" runat="server"
                                                        CausesValidation="false" />
                                                    <cc:CalendarExtender ID="CalendarExtender3" runat="server" PopupButtonID="ImageButton2"
                                                        TargetControlID="Frm_DT_superannuation_fund" Format="dd/MM/yyyy" PopupPosition="Left">
                                                    </cc:CalendarExtender>
                                                </td>
                                            </tr>
                                            <tr class="partthree">
                                                <td>Date to which the employee has contributed to the superannuation fund
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="TO_DT_superannuation_fund" ClientIDMode="Static" ReadOnly="true"
                                                        Width="100px" CssClass="cssTextbox" runat="server"></asp:TextBox>
                                                    <asp:ImageButton ID="ImageButton1" ImageUrl="~/Images/calendar.gif" runat="server"
                                                        CausesValidation="false" />
                                                    <cc:CalendarExtender ID="CalendarExtender1" runat="server" PopupButtonID="ImageButton1"
                                                        TargetControlID="TO_DT_superannuation_fund" Format="dd/MM/yyyy" PopupPosition="Left">
                                                    </cc:CalendarExtender>
                                                </td>
                                            </tr>
                                            <tr class="partthree">
                                                <td>The amount of contribution repaid on account of principal and interest from superannuation
                                                    fund
                                                </td>
                                                <td>
                                                    <input id="principal_interest_superannuation_fund" type="text" class="cssTextbox txtRentInt" />
                                                </td>
                                            </tr>
                                            <tr class="partthree">
                                                <td>The average rate of deduction of tax during the preceding three years 0
                                                </td>
                                                <td>
                                                    <input id="Rate_deduction_tax_3yrs" type="text" class="cssTextbox txtRentInt" />
                                                </td>
                                            </tr>
                                            <tr class="partthree">
                                                <td>The amount of tax deducted on repayment of superannuation fund 0
                                                </td>
                                                <td>
                                                    <input id="Repayment_superannuation_fund" type="text" class="cssTextbox txtRentInt" />
                                                </td>
                                            </tr>
                                            <tr class="partthree">
                                                <td>Gr. Total income including contribution repaid on account of principal & interest
                                                    from superannuatic
                                                </td>
                                                <td>
                                                    <input id="Total_Income_superannuation_fund" type="text" class="cssTextbox txtRentInt" />
                                                </td>
                                            </tr>

                                        </table>
                                    </div>    
                                                                       
                                </td>
                                <td>                                   
                                 25
                                </td>
                                <td>Whether contributions paid by the trustees of an approved superannuation fund
                                </td>
                                <td>                                   
                                </td>
                                <td>                                   
                                </td>
                                <td>                                   
                                </td>
                            </tr>

                        </table>
                    </ContentTemplate>
                </cc:TabPanel>
                <cc:TabPanel ID="TabPanel2" Width="150%" runat="server" HeaderText="Employee Rent Paid Details">
                    <ContentTemplate>

                        <table runat="server" id="tdHRAGrid" width="100%">
                            <tr>
                                <td>
                                    <asp:Label ID="lblGridMessage" runat="server" CssClass="cssLabel"></asp:Label>
                                    <asp:Label ID="lblEmployeeName" runat="server" Font-Bold="true" CssClass="cssLabel"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table id="tblHrr" style="width: 550px; padding-bottom: 50px;">
                                    </table>
                                </td>
                                <td style="padding-bottom: 50px;">
                                    <table width="100%" class="tbl">

                                        <tr>
                                            <td>
                                                <label id="Label29" class="cssLabel" style="font-weight: bold;">How is Exemption on HRA calculated ?</label><br />
                                                <label id="Label30" class="cssLabel">The exemption on HRA is calculated as per 2A of income Tax Rules.</label><br />
                                                <label id="Label33" class="cssLabel">As per Rule 2A , the list of the following is exempted from salary under section 10(13A) and does not form part of the taxable income :-</label><br />
                                                &nbsp;
                                                <img src="../Images/bullet-img.png" style="height: 5px; padding-bottom: 5px;" />
                                                &nbsp;<label id="Label34" class="cssLabel">Actual HRA received from employer</label><br />
                                                &nbsp;
                                                <img src="../Images/bullet-img.png" style="height: 5px; padding-bottom: 5px;" />&nbsp;
                                                <label id="Label35" class="cssLabel">For those living in metro cities : 50% of (Basic salary + Dearness allowance)</label><br />
                                                &nbsp;&nbsp;<img src="../Images/bullet-img.png" style="height: 5px; padding-bottom: 5px;" />&nbsp;<label id="Label36" class="cssLabel"> For those living in non-metro cities : 40% of (Basic salary + Dearness allowance)</label><br />
                                                &nbsp;
                                                <img src="../Images/bullet-img.png" style="height: 5px; padding-bottom: 5px;" />&nbsp;
                                                <label id="Label39" class="cssLabel">Actual rent paid minus 10% of (Basic salary + Dearness allowance)</label><br />
                                            </td>
                                        </tr>

                                        <%--                                    <tr style="height:20px;" >
                                        <td></td>
                                    </tr>--%>
                                        <tr>
                                            <td style="text-align: center; font-size: 16px; font-weight: bold;">HRA Calculation as per the Salary.
                                            </td>
                                        </tr>

                                    </table>
                                    <table id="tblclac" width="100%" class="tbl">
                                        <tr class="cssGridHeader">
                                            <%-- <th style="text-align: left;">Sr.
                                        </th>--%>
                                            <th style="text-align: left;">Description
                                            </th>
                                            <th style="text-align: right;">Amount
                                            </th>

                                        </tr>
                                        <tr style="height: 35px;">

                                            <td style="width: 300px;">
                                                <asp:Label ID="lblMetro" runat="server" CssClass="cssLabel" Font-Bold="true" Font-Size="12px" Text="Metro Cities"></asp:Label>

                                            </td>
                                            <td style="width: 100px; text-align: right;">
                                                <asp:Label ID="lblMetroC" runat="server" Font-Bold="true" CssClass="cssLabel" Text=""></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <%--<td style="width:30px;">1.</td>--%>
                                            <td>
                                                <asp:Label ID="lbTBasic" runat="server" CssClass="cssLabel" Font-Bold="true" Font-Size="12px" Text="Basic Salary + DA (p.a)"></asp:Label>

                                            </td>
                                            <td style="width: 100px; text-align: right;">
                                                <asp:Label ID="lbTBasicAmt" runat="server" Font-Bold="true" CssClass="cssLabel" Text=""></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <%--<td>2.</td>--%>
                                            <td>
                                                <asp:Label ID="lblTHra" runat="server" CssClass="cssLabel" Font-Bold="true" Font-Size="12px" Text="HRA Received  (p.a)"></asp:Label>

                                            </td>
                                            <td style="width: 100px; text-align: right;">
                                                <asp:Label ID="lblTHraAmt" runat="server" Font-Bold="true" CssClass="cssLabel" Text=""></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <%--<td>3.</td>--%>
                                            <td>
                                                <asp:Label ID="lblTHrr" runat="server" CssClass="cssLabel" Font-Bold="true" Font-Size="12px" Text="Total Rent Paid  (p.a)"></asp:Label>

                                            </td>
                                            <td style="width: 100px; text-align: right;">
                                                <asp:Label ID="lblTHrrAmt" runat="server" Font-Bold="true" CssClass="cssLabel" Text=""></asp:Label>
                                            </td>
                                        </tr>
                                        <%--   <tr>
                                        <td>4.</td>
                                        <td>
                                            <asp:Label ID="lblbasic10" runat="server" CssClass="cssLabel" Font-Bold ="true" Font-Size="12px" Text="10% Basic - Rent Paid"></asp:Label>
  
                                        </td>
                                        <td style="width:100px;text-align: right;">
                                            <asp:Label ID="lbl10Amt" runat="server" Font-Bold="true" CssClass="cssLabel" text=""></asp:Label>
                                        </td>
                                    </tr>--%>

                                        <%--    <tr>
                                       <td>6.</td>
                                        <td>
                                            <asp:Label ID="lblper" runat="server" CssClass="cssLabel" Font-Bold ="true" Font-Size="12px" Text="40% Basic"></asp:Label>
  
                                        </td>
                                        <td style="width:100px;text-align: right;">
                                            <asp:Label ID="lblperVal" runat="server" Font-Bold="true" CssClass="cssLabel" text=""></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>7.</td>
                                        <td>
                                            <asp:Label ID="Label26" runat="server" CssClass="cssLabel" Font-Bold ="true" Font-Size="12px" Text="Whichever amount is Less Point 2 or 4 or 6 will be considered as Final Hra for U/s 10"></asp:Label>
                                            
                                            <asp:Label ID="Label28" runat="server" CssClass="cssLabel" Font-Bold ="true" Font-Size="12px" Text="" ></asp:Label>  
                                        </td>
                                        <td style="width:100px;text-align: right;">
                                            <asp:Label ID="Label27" runat="server" Font-Bold="true" CssClass="cssLabel" text=""></asp:Label>
                                        </td>
                                    </tr>--%>
                                        <tr>
                                            <%--<td>8.</td>--%>
                                            <td>
                                                <asp:Label ID="lblFinal" runat="server" CssClass="cssLabel" Font-Bold="true" Font-Size="12px" Text="Exempted house Rent Allowance"></asp:Label>

                                            </td>
                                            <td style="width: 100px; text-align: right;">
                                                <asp:Label ID="lblFinalAmt" runat="server" Font-Bold="true" CssClass="cssLabel" Text=""></asp:Label>
                                            </td>
                                        </tr>


                                    </table>

                                </td>
                            </tr>

                        </table>
                    </ContentTemplate>
                </cc:TabPanel>
                <cc:TabPanel ID="TabPanel3" Width="150%" runat="server" HeaderText="Employee Details">
                    <ContentTemplate>
                        <table style="padding-left: 10px;">
                            <tr style="height: 40px;">
                                <td>
                                    <asp:Label ID="Label22" runat="server" Text="Metro Cities *" ForeColor="Red" CssClass="cssLabel">
                                    </asp:Label>
                                </td>
                                <td>
                                    <select id="ddlMetrocities" class="cssDropDownList" style="width: 150px;">
                                        <option selected value="Mumbai">Mumbai</option>
                                        <option value="Chennai">Chennai</option>
                                        <option value="Delhi">Delhi</option>
                                        <option value="Kolkata">Kolkata</option>
                                        <option value="Others">Others</option>
                                    </select>
                                </td>

                            </tr>
                            <tr style="height: 40px;">
                                <td>
                                    <asp:Label ID="Label24" runat="server" Text="No of Child" CssClass="cssLabel">
                                    </asp:Label>
                                </td>
                                <td>
                                    <select id="drpChild" class="cssDropDownList">
                                        <option value="0">0</option>
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                    </select>

                                </td>
                            </tr>
                            <tr style="height: 40px;">
                                <td width="150px">
                                    <asp:Label ID="Label25" runat="server" Text="Citizen Type" CssClass="cssLabel"></asp:Label>
                                </td>
                                <td>
                                    <select id="drpCtzn" class="cssDropDownList" style="width: 150px;">
                                        <option value="None">None</option>
                                        <option value="Senior Citizen">Senior Citizen</option>
                                        <option value="Super Senior Citizen">Super Senior Citizen</option>
                                    </select>
                                </td>

                            </tr>
                            <%--                            <tr style="height:40px;">
                                <td>
                                    Handicapped
                                </td>
                                <td>
                                  <input  type="radio" name="No" id="No" value="0">No&nbsp;&nbsp;
                                  <input type="radio" name="Yes" id="Yes" value="1" >Yes
                                </td>
                            </tr>--%>
                            <tr style="height: 40px;">
                                <td>
                                    <input id="chkCalcProvidendFund" type="checkbox" />
                                    <label id="Label31" class="labelstyle labelChange" style="font-weight: bold">Calc Providend Fund</label>

                                </td>
                                <td>
                                    <input id="chkCalcProfessionalTax" type="checkbox" />
                                    <label id="Label32" class="labelstyle labelChange" style="font-weight: bold">Calc Professional Tax</label>

                                </td>
                            </tr>
                            <tr style="height: 40px;">
                                <td width="150px">
                                    <asp:Label ID="Label23" runat="server" Text="State" CssClass="cssLabel"></asp:Label>
                                </td>
                                <td>
                                    <select id="drpState" class="cssDropDownList" style="width: 150px;">
                                        <option value="None">None</option>
                                    </select>

                                </td>

                            </tr>
                        </table>
                    </ContentTemplate>
                </cc:TabPanel>

            </cc:TabContainer>
        </div>
    </div>
    <script src="../Scripts/jquery1.11.2.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery1.7.2.min.js" type="text/javascript"></script>
    <!--Model Popup -->
    <script src="../Scripts/jquery-ui1.8.9.js" type="text/javascript"></script>
    <script src="../Scripts/Pager.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.auto-complete.min.js" type="text/javascript"></script>



</asp:Content>
