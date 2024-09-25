<%@ Page Title="" Language="C#" MasterPageFile="~/TDS/BTS_MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="SalaryChallan.aspx.cs" Inherits="Admin_SalaryChallan" %>

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


    <style type="text/css">
        .form-group {
            margin-bottom: 0.25em !important;
        }

        .padding5 {
            padding-bottom: 5px;
            padding-top: 5px;
            padding-left: 5px;
            padding-right: 5px;
        }

        #tblChallanList tr:hover,
        #tblEmployeeList tr:hover {
            background-color: #f5f5f5;
        }
    </style>
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            SetDefaultDate();
            onLoad(1, $("[id*=ddlperpage]").val());
            $("[id*=ExportImportExcel_").hide();
            $("[id*=NewChallanCriteria_").hide();
            $("[id*=AddChallanDetails").hide();
            $("[id*=ChallanDetails1").hide();
            $("[id*=ChallanDetails").hide();
            $("[id*=btnSave]").hide();
            $("[id*=btnCancel]").hide();
            $("[id*=btnNext]").hide();
            $("[id*=hdnPages]").val(1);
            $("[id*=hdnConnString]").val($("[id*=ddlFinancialYear] :selected").text());
            document.getElementById("txtDateOfAmount").valueAsDate = new Date();
            //$("[id*=txtDateOfAmount]").val($("[id*=hdnDate]").val());

            $("[id*=ddlperpage]").change(function () {
                var p = $("[id*=ddlperpage]").val();
                $("[id*=hdnPages]").val(1);
                onLoad(1, p);
            });

            $("[id*=ddlMonth]").change(function () {
                var month = $("[id*=ddlMonth]").val();

                if (month == 'Apr' || month == 'May' || month == 'June') {
                    $("[id*=ddlQuarter]").val('Q1');
                    $("[id*=hdnQuarter]").val('Q1');
                } else if (month == 'July' || month == 'Aug' || month == 'Sept') {
                    $("[id*=ddlQuarter]").val('Q2');
                    $("[id*=hdnQuarter]").val('Q2');
                }
                else if (month == 'Oct' || month == 'Nov' || month == 'Dec') {
                    $("[id*=ddlQuarter]").val('Q3');
                    $("[id*=hdnQuarter]").val('Q3');
                }
                else if (month == 'Jan' || month == 'Feb' || month == 'Mar') {
                    $("[id*=ddlQuarter]").val('Q4');
                    $("[id*=hdnQuarter]").val('Q4');
                }
            });

            $("[id*=txtChallanNoSearch_]").on("keyup", function () {
                onLoad(1, $("[id*=ddlperpage]").val());
            });
            $('#txtChallanNoSearch_').keyup(function () {
                onLoad(1, $("[id*=ddlperpage]").val());
            });

            $("[id*=ddSearchQuarter_]").change(function () {
                var p = $("[id*=ddlperpage]").val();
                $("[id*=hdnPages]").val(1);
                onLoad(1, $("[id*=ddlperpage]").val());
            });

            $("[id*=btnAddnew]").click(function () {
                $("[id*=NewChallanCriteria_").show();
                $("[id*=AddChallanDetails").hide();
                $("[id*=ChallanDetails1").hide();
                $("[id*=ChallanDetails").hide();
                $("[id*=tdSearch").hide();
                $("[id*=btnCancel]").show();
                $("[id*=QtrSelect]").hide();
                $("[id*=btnNext]").show();
                $("[id*=ExportImportExcel_").show();
                document.getElementById("<%=chkShowOnlyTaxableEmployees.ClientID %>").checked = true;
                document.getElementById("txtDateOfAmount").valueAsDate = new Date();
                $("[id*=ddlMonth]").val('Select');
                $("[id*=ddlQuarter]").val('0');


                FillBSRCodes();
            });

            $("[id*=btnNext]").click(function () {
                var month = $("[id*=ddlMonth]").val();
                if (month == "Select") {
                    showInfoAlert('Please Select Month !');
                    Blockloaderhide()
                    return;
                }

                var Quarter = $("[id*=ddlQuarter]").val();
                if (Quarter == "Select") {
                    showInfoAlert('Please Select Quarter!');
                    Blockloaderhide()
                    return;
                }
                if (document.getElementById("txtDateOfAmount").value == "") {
                    showInfoAlert('Please Select date of Salary	!');
                    Blockloaderhide()
                    return;
                }
                if (!DateValidationWithSelectdQuarter()) {
                    showInfoAlert('Please check  Dt. of Amt Paid with in the selected Quarter !');
                    Blockloaderhide()
                    return;
                }
                //$("[id*=EmpTDS").hide();
                $("[id*=ChallanDetails").show();
                $("[id*=btnNext]").hide();
                $("[id*=btnSave]").show();
                $("[id*=btnCancel]").show();
                $("[id*=txtChallanDate]").val("");
                $("[id*=ddlBranchCode]").val("0");
                $("[id*=ddlBranchCode]").trigger('change');
                //$("[id*=txtBranchCode]").val("");
                $("[id*=ddSearchQuarter_]").val("");
                $("[id*=txtTDS]").val("0");
                $("[id*=txtSurcharge]").val("0");
                $("[id*=txtECess]").val("0");
                $("[id*=txtHECess]").val("0");
                $("[id*=txtInterest]").val("0");
                $("[id*=txtFees]").val("0");
                $("[id*=txtOthers]").val("0");
                $("[id*=txtTotal]").val("0");
                $("[id*=txtChallanNo]").val("");
                $("[id*=hdnChallan_ID]").val("0");
                var compid = $("[id*=hdnCompanyid]").val();
                var txt1 = $("[id*=txtDateOfAmount").val();
                var m1 = txt1.split('-');

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../TDS/BTStrp/handler/SalaryChallanDetails.asmx/GetEmployee",
                    data: '{compid:' + compid + ', MonthID:"' + m1[1] + '", ChallanDate:"' + $("[id*=txtDateOfAmount").val() + '",chkShowOnlyTaxableEmployees:' + document.getElementById("<%=chkShowOnlyTaxableEmployees.ClientID %>").checked + '}',
                    dataType: "json",
                    success: function (msg) {
                        var xmlDoc = $.parseXML(msg.d);
                        var xml = $(xmlDoc);
                        var EmployeeList = xml.find("Table");
                        if (EmployeeList.length > 0) {
                            //tblEmployeeList
                            var j = 0;
                            $("[id*=tblEmployeeList] tr").empty();
                            $("[id*=tblEmployeeList] tbody").empty();
                            var TotalDeposite = 0;
                            var Challan_date;
                            var tbl = '';
                            tbl = tbl + "<tr style='background-color:#F2F2F2;'>";
                            tbl = tbl + "<th style='text-align: center; padding-left: 0px; padding-top: 17px;'><input type='checkbox' id='chkAll' name='chkAll' onclick='chkAllselect($(this))'></th>";
                            tbl = tbl + "<th style='text-align: Left;' >Name</th>";
                            //tbl = tbl + "<th style='text-align: Center;'>Date</th>";
                            tbl = tbl + "<th style='text-align: Center;'>Pan No</th>";
                            tbl = tbl + "<th style='text-align: Center;'>Vld</th>";
                            tbl = tbl + "<th style='text-align: right;' >Amount</th>";
                            tbl = tbl + "<th style='text-align: Right;'>TDS</th>";
                            tbl = tbl + "<th style='text-align: Right;'>Sur</th>";
                            tbl = tbl + "<th style='text-align: Right;'>E Cess</th>";
                            //tbl = tbl + "<th style='text-align: Right;'>H Cass</th>";
                            tbl = tbl + "<th style='text-align: Right;'>Total Tax</th>";
                            tbl = tbl + "<th style='text-align: Right;'>Total Depo</th>";
                            //tbl = tbl + "<th style='text-align: Right; width:6%;'>R Type</th>";
                            //tbl = tbl + "<th style='text-align: Right; width:8%;'>Cert No</th>";
                            tbl = tbl + "</tr>";

                            $.each(EmployeeList, function () {
                                Challan_date = moment($(this).find("CDate").text()).format('DD/MM/YYYY');
                                tbl = tbl + "<tr >";
                                tbl = tbl + "<td style='text-align: center;padding-left: 0px; padding-top: 21px;'><input type='checkbox' id='chkEmployeeID' name='chkEmployeeID' value='" + $(this).find("Employee_ID").text() + "' ><input type='hidden' id='hdnCid' value='" + $(this).find("Employee_ID").text() + "' name='hdnCid'></td>"
                                tbl = tbl + "<td style='text-align: Left; padding-top:21px;' >" + $(this).find("FirstName").text() + "</td>";
                                //tbl = tbl + "<td style='text-align: Center; text-wrap:nowrap;' >" + Challan_date + "</td>";
                                tbl = tbl + "<td style='text-align: Center; padding-top:21px;' >" + $(this).find("PAN_NO").text() + "</td>";
                                if ($(this).find("PanVerified").text() == "Valid_PAN") {
                                    tbl = tbl + "<td style='text-align: center; padding-top:21px;' class='padding5'><i class='icon-checkmark2 mr-3 icon-2x' style='cursor:pointer; height:18px; width:18px; color:green;' id='imgCPaid' name='imgCPaid'></td>";
                                }
                                else {
                                    tbl = tbl + "<td style='text-align: center; padding-top:21px;' class='padding5'><i class='icon-cross3 mr-3 icon-2x' style='cursor:pointer; height:18px; width:18px; color:red;' id='imgCNot' name='imgCNot'></td>";
                                }
                                tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtAmount_' name='txtAmount_' class='form-control form-control-border clsAmount' style='text-align: right;'  value='" + $(this).find("Amount").text() + "' disabled='disabled'  /></td>";
                                tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtTDS_' onkeyup='txt(this)' name='txtTDS_' class='form-control form-control-border clstds' style='text-align: right;'  value='0.00' disabled='disabled'  /></td>";
                                tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtSurcharge_' onkeyup='txt(this)' name='txtSurcharge_' class='form-control form-control-border clsSur' style='text-align: right;'  value='0.00' disabled='disabled'  /></td>";
                                tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtEducationCess_' onkeyup='txt(this)' name='txtEducationCess_' class='form-control form-control-border clsEcess' style='text-align: right;'  value='0.00' disabled='disabled'  /></td>";
                                //tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtHigh_EductionCess_' onkeyup='txt(this)' name='txtHigh_EductionCess_' class='form-control form-control-border clshcess' style='text-align: right;'  value='0.00'  disabled='disabled' /></td>";
                                tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtTotal_TDS_' name='txtTotal_TDS_' class='form-control form-control-border clsTax' style='text-align: right;'  value='0.00' disabled='disabled'  /></td>";
                                tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtTotal_TDS_Amount_' name='txtTotal_TDS_Amount_' class='form-control form-control-border clsTotalTDS' style='text-align: right;'  value='0.00' disabled='disabled'  /></td>";
                                //tbl = tbl + "<td style='text-align: right;' ><select id='ddlRType" + j + "' class='form-control'><option value='Reguler'>Reguler</option><option value='LowerDeduction A'>Lower Deduction A</option>";
                                //tbl = tbl + "<option value='NoDeduction B'>No Deduction B</option><option value='PANnotAvalable C'>PAN not Avalable C</option></select></td>";
                                //tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtCertNo' name='txtCertNo' class='form-control' style='text-align: left;'  value='' disabled='disabled'  /></td>";
                                tbl = tbl + "</tr>";
                                j++;
                            });

                            tbl = tbl + "<tr >";
                            tbl = tbl + "<td style='text-align: center;font-weight:bold;'>&nbsp;</td>"
                            tbl = tbl + "<td style='text-align: Left;font-weight:bold;' >Total</td>";
                            //tbl = tbl + "<td style='text-align: Center;font-weight:bold;' >&nbsp;</td>";
                            tbl = tbl + "<td style='text-align: Center;font-weight:bold;' >&nbsp;</td>";
                            tbl = tbl + "<td style='text-align: center;font-weight:bold;'>&nbsp;</td>";
                            tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalAmount'>0.00</span></td>";
                            tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalTDS'>0.00</span></td>";
                            tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalSur'>0.00</span></td>";
                            tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalEcess'>0.00</span></td>";
                            //tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalHcess'>0.00</span></td>";
                            tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalTax'>0.00</span></td>";
                            tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalDeposite'>0.00</span></td>";
                            // tbl = tbl + "<td style='text-align: right;font-weight:bold;' >&nbsp;</td>";
                            // tbl = tbl + "<td style='text-align: right;font-weight:bold;' >&nbsp;</td>";
                            tbl = tbl + "</tr>";

                            $("[id*=tblEmployeeList]").append(tbl);
                            $("[id*=txtTotalDepoAmount_]").val(TotalDeposite);
                        }
                    },
                    failure: function (response) {
                        showDangerAlert('Challan data not found');
                        Blockloaderhide();
                    },
                    error: function (response) {
                        showDangerAlert('Challan data not found');
                        Blockloaderhide();
                    }
                });
            });

            $("[id*=chkShowOnlyTaxableEmployees]").change(function () {
                Blockloadershow();
                var compid = $("[id*=hdnCompanyid]").val();
                var txt1 = $("[id*=txtDateOfAmount").val();
                var m1 = txt1.split('-');

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../TDS/BTStrp/handler/SalaryChallanDetails.asmx/GetEmployee",
                    data: '{compid:' + compid + ', MonthID:"' + m1[1] + '", ChallanDate:"' + $("[id*=txtDateOfAmount").val() + '",chkShowOnlyTaxableEmployees:' + document.getElementById("<%=chkShowOnlyTaxableEmployees.ClientID %>").checked + '}',
                    dataType: "json",
                    success: function (msg) {
                        var xmlDoc = $.parseXML(msg.d);
                        var xml = $(xmlDoc);
                        var EmployeeList = xml.find("Table");
                        if (EmployeeList.length > 0) {
                            var j = 0;
                            $("[id*=tblEmployeeList] tr").empty();
                            $("[id*=tblEmployeeList] tbody").empty();
                            var TotalDeposite = 0;
                            var Challan_date;
                            var tbl = '';
                            tbl = tbl + "<tr style='background-color:#F2F2F2;' >";
                            tbl = tbl + "<th style='text-align: center; padding-left: 0px; padding-top: 17px;'><input type='checkbox' id='chkAll' name='chkAll' onclick='chkAllselect($(this))'></th>";
                            tbl = tbl + "<th style='text-align: Left;' >Name</th>";
                            //tbl = tbl + "<th style='text-align: Center;'>Date</th>";
                            tbl = tbl + "<th style='text-align: Center;'>Pan No</th>";
                            tbl = tbl + "<th style='text-align: Center;'>Vld</th>";
                            tbl = tbl + "<th style='text-align: right;' >Amount</th>";
                            tbl = tbl + "<th style='text-align: Right;'>TDS</th>";
                            tbl = tbl + "<th style='text-align: Right;'>Sur</th>";
                            tbl = tbl + "<th style='text-align: Right;'>E Cess</th>";
                            //tbl = tbl + "<th style='text-align: Right;'>H Cass</th>";
                            tbl = tbl + "<th style='text-align: Right;'>Total Tax</th>";
                            tbl = tbl + "<th style='text-align: Right;'>Total Depo</th>";
                            //tbl = tbl + "<th style='text-align: Right;'>R Type</th>";
                            //tbl = tbl + "<th style='text-align: Right; width:8%;'>Cert No</th>";
                            tbl = tbl + "</tr>";

                            $.each(EmployeeList, function () {
                                Challan_date = moment($(this).find("CDate").text()).format('DD/MM/YYYY');
                                tbl = tbl + "<tr >";
                                tbl = tbl + "<td style='text-align: center; padding-left: 0px; padding-top: 21px;'><input type='checkbox' id='chkEmployeeID' name='chkEmployeeID' value='" + $(this).find("Employee_ID").text() + "' ><input type='hidden' id='hdnCid' value='" + $(this).find("Employee_ID").text() + "' name='hdnCid'></td>"
                                tbl = tbl + "<td style='text-align: Left padding-top:21px;;' >" + $(this).find("FirstName").text() + "</td>";
                                //tbl = tbl + "<td style='text-align: Center; text-wrap:nowrap;' >" + Challan_date + "</td>";
                                tbl = tbl + "<td style='text-align: Center; padding-top:21px;' >" + $(this).find("PAN_NO").text() + "</td>";
                                if ($(this).find("PanVerified").text() == "Valid_PAN") {
                                    tbl = tbl + "<td style='text-align: center;  padding-top:21px;' class='padding5'><i class='icon-checkmark2 mr-3 icon-2x' style='cursor:pointer; height:18px; width:18px;color:green;' id='imgCPaid' name='imgCPaid'></td>";
                                }
                                else {
                                    tbl = tbl + "<td style='text-align: center; padding-top:21px;' class='padding5'><i class='icon-cross3 mr-3 icon-2x' style='cursor:pointer; height:18px; width:18px;color:red;' id='imgCNot' name='imgCNot'></td>";
                                }
                                tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtAmount_' name='txtAmount_' class='form-control form-control-border clsAmount' style='text-align: right;'  value='" + $(this).find("Amount").text() + "' disabled='disabled'  /></td>";
                                tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtTDS_'   onkeyup='txt(this)' name='txtTDS_' class='form-control form-control-border clstds' style='text-align: right;'  value='0.00' disabled='disabled'  /></td>";
                                tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtSurcharge_' name='txtSurcharge_' onkeyup='txt(this)' class='form-control form-control-border clsSur' style='text-align: right;'  value='0.00' disabled='disabled'  /></td>";
                                tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtEducationCess_' name='txtEducationCess_' onkeyup='txt(this)' class='form-control form-control-border clsEcess' style='text-align: right;'  value='0.00' disabled='disabled'  /></td>";
                                //tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtHigh_EductionCess_' name='txtHigh_EductionCess_' onkeyup='txt(this)' class='form-control form-control-border clshcess' style='text-align: right;'  value='0.00' disabled='disabled'  /></td>";
                                tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtTotal_TDS_' name='txtTotal_TDS_' class='form-control form-control-border clsTax' style='text-align: right;'  value='0.00' disabled='disabled'  /></td>";
                                tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtTotal_TDS_Amount_' name='txtTotal_TDS_Amount_' class='form-control form-control-border clsTotalTDS' style='text-align: right;'  value='0.00' disabled='disabled'  /></td>";
                                //tbl = tbl + "<td style='text-align: right;' ><select id='ddlRType" + j + "' class='form-control'><option value='Reguler'>Reguler</option><option value='LowerDeduction A'>Lower Deduction A</option>";
                                //tbl = tbl + "<option value='NoDeduction B'>No Deduction B</option><option value='PANnotAvalable C'>PAN not Avalable C</option></select></td>";
                                //tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtCertNo' name='txtCertNo' class='form-control' style='text-align: left;'  value=''  disabled='disabled' /></td>";
                                tbl = tbl + "</tr>";
                                j++;
                            });

                            tbl = tbl + "<tr >";
                            tbl = tbl + "<td style='text-align: center;font-weight:bold;'>&nbsp;</td>"
                            tbl = tbl + "<td style='text-align: Left;font-weight:bold;' >Total</td>";
                            //tbl = tbl + "<td style='text-align: Center;font-weight:bold;' >&nbsp;</td>";
                            tbl = tbl + "<td style='text-align: Center;font-weight:bold;' >&nbsp;</td>";
                            tbl = tbl + "<td style='text-align: center;font-weight:bold;'>&nbsp;</td>";
                            tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalAmount'>0.00</span></td>";
                            tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalTDS'>0.00</span></td>";
                            tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalSur'>0.00</span></td>";
                            tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalEcess'>0.00</span></td>";
                            //tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalHcess'>0.00</span></td>";
                            tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalTax'>0.00</span></td>";
                            tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalDeposite'>0.00</span></td>";
                            //tbl = tbl + "<td style='text-align: right;font-weight:bold;' >&nbsp;</td>";
                            //tbl = tbl + "<td style='text-align: right;font-weight:bold;' >&nbsp;</td>";
                            tbl = tbl + "</tr>";

                            $("[id*=tblEmployeeList]").append(tbl);
                            $("[id*=txtTotalDepoAmount_]").val(TotalDeposite);
                            Blockloaderhide();
                        }
                    },
                    failure: function (response) {
                        showDangerAlert('Challan data not found');
                        Blockloaderhide();
                    },
                    error: function (response) {
                        showDangerAlert('Challan data not found');
                        Blockloaderhide();
                    }
                });
            });
            function SetDefaultDate() {
                var date = new Date();
                var day = date.getDate();
                var month = date.getMonth() + 1;
                var year = date.getFullYear();

                if (month < 10) month = "0" + month;
                if (day < 10) day = "0" + day;

                //var today = day + "/" + month + "/" + year;
                var today = month + "/" + day + "/" + year;
                $("[id*=txtDateOfAmount]").val(today);
            }

            $("[id*=btnCancel]").click(function () {
                $("[id*=NewChallanCriteria_").hide();
                $("[id*=AddChallanDetails").hide();
                $("[id*=ChallanDetails1").hide();
                $("[id*=ChallanDetails").hide();
                $("[id*=btnSave]").hide();
                $("[id*=btnCancel]").hide();
                $("[id*=btnNext]").hide();
                $("[id*=QtrSelect]").show();
                //$("[id*=ChallanNoLabel_]").hide();
                //$("[id*=txtChallanNoSearch_]").hide();
                //$("[id*=ChallanDateLabel_]").hide();
                //$("[id*=txtChallanDateSearch_]").hide();
                $("[id*=tdSearch").show();
            });

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

            function DateValidationWithSelectdQuarter() {
                var ValidDate = false;
                var result = 0;
                var parm = $("[id*=ddlQuarter]").val();
                var sel = parm;// parm.options[parm.selectedIndex].value;
                var txt1 = document.getElementById("txtDateOfAmount").value;

                var m1 = txt1.split('-');
                if (sel == 'Q1') {
                    if (m1[1] == '04' || m1[1] == '05' || m1[1] == '06') { result = parseFloat(result) + 1; }
                }
                if (sel == 'Q2') {
                    if (m1[1] == '07' || m1[1] == '08' || m1[1] == '09') { result = parseFloat(result) + 1; }
                }
                if (sel == 'Q3') {
                    if (m1[1] == '10' || m1[1] == '11' || m1[1] == '12') { result = parseFloat(result) + 1; }
                }
                if (sel == 'Q4') {
                    if (m1[1] == '01' || m1[1] == '02' || m1[1] == '03') { result = parseFloat(result) + 1; }
                }

                if (result == 1) { ValidDate = true; }
                else { ValidDate = false; }

                if (sel == "0") { ValidDate = true; }

                return ValidDate;
            }

            function ValidationForChallanDateWithinFinacial() {
                var ChallanDate = document.getElementById("txtChallanDate").value;//$("[id*=txtChallanDate]").val();
                var ChallanDateSplit = ChallanDate.split('/');
                var financialyears = $("#ddlFinancialYear option:selected").text();
                var startfin = financialyears.split('_');
                var res = fn_DateCompare('04/01/' + startfin[0], ChallanDateSplit[1] + '/' + ChallanDateSplit[0] + '/' + ChallanDateSplit[2]);
                var ValidDate = false;
                if ('04/01/' + startfin[0] == ChallanDateSplit[1] + '/' + ChallanDateSplit[0] + '/' + ChallanDateSplit[2]) { res = 0; }

                if (res == 0) {
                    ValidDate = true;
                }
                else { aValidDate = false; }
                return ValidDate;
            }

            function ValidationCustomforTotalDe() {
                var ValidData = false;
                var tds = $("input[type=text][id*=txtTDSAmount]").val();
                var surcharge = $("input[type=text][id*=txt_Surcharge]").val();
                var ECess = $("input[type=text][id*=txtEducationCess]").val();
                var Hecss = $("input[type=text][id*=txtHECess]").val();
                var Int = $("input[type=text][id*=txtInterest]").val();

                if (isNaN(tds) || tds == "") { tds = 0; }
                if (isNaN(surcharge) || surcharge == "") { surcharge = 0; }
                if (isNaN(ECess) || ECess == "") { ECess = 0; }
                if (isNaN(Hecss) || Hecss == "") { Hecss = 0; }

                var result = 0;

                result = parseFloat(tds) + parseFloat(surcharge) + parseFloat(ECess) + parseFloat(Hecss) + parseFloat(Int);

                var total = $("input[type=text][id*=txtTotalDepoAmount_]").val();

                var gridt = $("[id*=hdnRowsOfGrid]").val();

                if (gridt != '0') {
                    if (parseFloat(result) >= parseFloat(total)) {
                        ValidData = true;
                    }
                    else {
                        ValidData = false;
                    }
                }
            }

            function ValidateTotalIsNoZero() {
                var ValidData = false;
                var status = $('#rdoNo').attr('checked') ? true : false;
                var total = $("input[type=text][id*=txtTotalDepoAmount_]").val();
                if (status == true) {
                    if (total == "0") {
                        ValidData = false;
                    }
                }
                else { ValidData = true; }
            }


            $("[id*=btnSave]").click(function () {
                var Bank = $("[id*=ddlBranchCode]").val();
                if (Bank == "Select") {
                    showInfoAlert('Please Select Bank !');
                    Blockloaderhide();
                    return;
                }

                if (!ValidationForChallanDateWithinFinacial()) {
                    showInfoAlert('Invalid Challan Date With in Selected Financial Year Or Challan Date Must be Equal or less than Current Date !');
                    Blockloaderhide();
                    return;
                }

                if (ValidationCustomforTotalDe()) {
                    showInfoAlert('Total Of (TDS + Surcharge + E.Cess + HE Cess) Greate Than OR Equal To Total Deposit Amount');
                    Blockloaderhide();
                    return;
                }


                var fn = $("[id*=hdnConnString]").val();
                var fy = fn.split('_');
                var st = '04/01/' + fy[0];
                var ed = '03/31/20' + fy[1];

                var vd = new Date;
                var s = new Date;
                var e = new Date;
                var d = document.getElementById("txtChallanDate").value;//$("[id*=txtChallanDate]").val();
                vd = moment(d).format('MM/DD/YYYY');
                s = moment(st);
                e = moment(ed);
                if (moment(vd) < moment(s)) {
                    showInfoAlert('Challan date cannot be outside the Financial year');
                    Blockloaderhide();
                    return;
                }
                if (moment(vd) > moment(e)) {
                    showInfoAlert('Challan date cannot be outside the Financial year');
                    Blockloaderhide();
                    return;
                }

                //var result = 0;
                ////var d = document.getElementById("txtChallanDate").value;//$("[id*=txtChallanDate]").val();
                //vd = moment(d).format('DD/MM/YYYY');
                //var m1 = vd.split('/');
                //var parm = $("[id*=ddlQuarter]").val();
                //var sel = parm;

                //if (sel == 'Q1') {
                //    if (m1[1] == '04' || m1[1] == '05' || m1[1] == '06') { result = parseFloat(result) + 1; }
                //}
                //if (sel == 'Q2') {
                //    if (m1[1] == '07' || m1[1] == '08' || m1[1] == '09') { result = parseFloat(result) + 1; }
                //}
                //if (sel == 'Q3') {
                //    if (m1[1] == '10' || m1[1] == '11' || m1[1] == '12') { result = parseFloat(result) + 1; }
                //}
                //if (sel == 'Q4') {
                //    if (m1[1] == '01' || m1[1] == '02' || m1[1] == '03') { result = parseFloat(result) + 1; }
                //}
                //if (result != 1) {
                //    showInfoAlert('Please check  Dt. of Amt Paid with in the selected Quarter !');
                //    return;
                //}
                var tableData = [];
                var chk = "";//, row = "";
                var k = 0;
                var tableData1 = [];
                var salaryDate;
                $("input[name=chkEmployeeID]").each(function () {
                    row = $(this).closest("tr");
                    chk = $(this).is(':checked');
                    if (chk == true) {
                        var rowData1 = [];
                        var rowData = [];
                        rowData.push("{ _Employee_ID: " + row.find("input[name=hdnCid]").val() + ", _Employee_Salary: " + row.find("input[name=txtAmount_]").val() + ",_Deduction_Type:'" + $("[id*=ddlRType" + k + "]").val() + "'," +
                            " _PAN_No:'" + row.find("td").eq(4).text() + "',_Quater:'Monthly', _TDS_Amount:" + row.find("input[name=txtTDS_]").val() + ",_Surcharge_Amount:" + row.find("input[name=txtSurcharge_]").val() + "," +
                            " _EducationCess_Amount:'" + row.find("input[name=txtEducationCess_]").val() + "',_High_EductionCess_Amount:" + row.find("input[name=txtHigh_EductionCess_]").val() + ", _Total_TDS_Amount:" + row.find("input[name=txtTotal_TDS_]").val() + ",_Salary_Date:'" + row.find("td").eq(3).text() + "'," +
                            " _Tds_Deduction_Date:'" + row.find("td").eq(3).text() + "',_PAN_Verified:1}");
                        salaryDate = moment(row.find("td").eq(3).text()).format('MM-DD-yyyy');
                        rowData1 = {
                            _Employee_ID: row.find("input[name=hdnCid]").val(),
                            _Employee_Salary: row.find("input[name=txtAmount_]").val(),
                            _Deduction_Type: $("[id*=ddlRType" + k + "]").val(),
                            _PAN_No: row.find("td").eq(4).text(),
                            _Quater: 'Monthly',
                            _TDS_Amount: row.find("input[name=txtTDS_]").val(),
                            _Surcharge_Amount: row.find("input[name = txtSurcharge_]").val(),
                            _EducationCess_Amount: row.find("input[name=txtEducationCess_]").val(),
                            _High_EductionCess_Amount: row.find("input[name=txtHigh_EductionCess_]").val(),
                            _Total_TDS_Amount: row.find("input[name=txtTotal_TDS_]").val(),
                            _Salary_Date: salaryDate,
                            _Tds_Deduction_Date: salaryDate,
                            _PAN_Verified: true,
                            //CertNo: row.find("input[name = txtCertNo]").val(),
                        };
                        tableData1.push(rowData1);
                    }
                    k++;
                });
                var Challandate = moment(document.getElementById("txtChallanDate").value).format('MM-DD-YYYY');//moment($("[id*=txtChallanDate]").val()).format('MM-DD-YYYY');
                var dataToSend = {
                    objbalChallan: {
                        _Challan_ID: $("[id*=hdnChallan_ID]").val(),
                        _Company_ID: $("[id*=hdnCompanyid]").val(),
                        _Challan_Date: Challandate, //$("[id*=txtChallanDate]").val(),
                        //_Bank_ID: $("[id*=ddlBank]").val(),
                        _Bank_Bsrcode: $("[id*=ddlBranchCode]").val(),
                        _Quater: $("[id*=ddlQuarter]").val(),
                        _TDS_Amount: $("[id*=txtTDS]").val(),
                        _Surcharge: $("[id*=txtSurcharge]").val(),
                        _Education_Cess: $("[id*=txtECess]").val(),
                        _High_Education_Cess: $("[id*=txtHECess]").val(),
                        _Interest_Amt: $("[id*=txtInterest]").val(),
                        _Fees_Amount: $("[id*=txtFees]").val(),
                        _Others_Amount: $("[id*=txtOthers]").val(),
                        _Challan_Amount: $("[id*=txtTotal]").val(),
                        _Challan_No: $("[id*=txtChallanNo]")[1].val,//$("[id*=txtChallanNo]").val(),
                        dataTable: tableData1
                    },
                };

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../TDS/BTStrp/handler/SalaryChallanDetails.asmx/InssertSalaryChallan",
                    data: JSON.stringify(dataToSend),
                    dataType: "json",
                    success: function (msg) {
                        Blockloaderhide();
                        onLoad(1, $("[id*=ddlperpage]").val());
                        $("[id*=ExportImportExcel_").hide();
                        $("[id*=NewChallanCriteria_").hide();
                        $("[id*=AddChallanDetails").hide();
                        $("[id*=ChallanDetails1").hide();
                        $("[id*=ChallanDetails").hide();
                        $("[id*=btnSave]").hide();
                        $("[id*=btnCancel]").hide();
                        $("[id*=btnNext]").hide();
                        //$("[id*=ChallanNoLabel_]").hide();
                        //$("[id*=txtChallanNoSearch_]").hide();
                        //$("[id*=ChallanDateLabel_]").hide();
                        //$("[id*=txtChallanDateSearch_]").hide();
                        $("[id*=hdnPages]").val(1);
                        $("[id*=hdnConnString]").val($("[id*=ddlFinancialYear] :selected").text());
                        document.getElementById("txtDateOfAmount").valueAsDate = new Date();
                        $("[id*=tdSearch").show();
                        showSuccessAlert('Challan has been saved successfull.');
                    },
                    failure: function (response) {
                        showDangerAlert('Challan data not found');
                        Blockloaderhide();
                    },
                    error: function (response) {
                        showDangerAlert('Challan data not found');
                        Blockloaderhide();
                    }
                });
            });

            $("[id*=txtChallanDate]").blur(function () {
                var did = $("[id*=hdnDedId]").val();
                var fn = $("[id*=hdnConnString]").val();
                var fy = fn.split('_');
                var st = '04/01/' + fy[0];
                var ed = '03/31/20' + fy[1];

                var vd = new Date;
                var s = new Date;
                var e = new Date;
                var d = document.getElementById("txtChallanDate").value;//$("[id*=txtChallanDate]").val();
                var dt = d.split('/');
                d = dt[1] + '/' + dt[0] + '/' + dt[2];

                vd = moment(d);
                s = moment(st);
                e = moment(ed);
                if (moment(vd) < moment(s)) {
                    //$("[id*=txtChallanDate]").val('');
                    showInfoAlert('Challan date cannot be outside the Financial year');
                    return;
                }
                if (moment(vd) > moment(e)) {
                    //$("[id*=txtChallanDate]").val('');
                    showInfoAlert('Challan date cannot be outside the Financial year');
                    return;
                }
                //var qua = $("[id*=ddltype]").val();
                //var q = qua.substring(1);
                //if (q == 1) {
                //    if (dt[1] < 4 || dt[1] > 6) {
                //        $("[id*=txtChallanDate]").val('');
                //        showInfoAlert('Challan date cannot be outside the Quarter');
                //        return;
                //    }
                //}
                //else if (q == 2) {
                //    if (dt[1] < 7 || dt[1] > 9) {
                //        $("[id*=txtChallanDate]").val('');
                //        showInfoAlert('Challan date cannot be outside the Quarter');
                //        return;
                //    }
                //}
                //else if (q == 3) {
                //    if (dt[1] < 10 || dt[1] > 13) {
                //        $("[id*=txtChallanDate]").val('');
                //        showInfoAlert('Challan date cannot be outside the Quarter');
                //        return;
                //    }
                //}
                //else if (q == 4) {
                //    if (dt[1] < 1 || dt[1] > 3) {
                //        $("[id*=txtChallanDate]").val('');
                //        showInfoAlert('Challan date cannot be outside the Quarter');
                //        return;
                //    }
                //}
            });

            //$("[id*=txtChallanDate]").keyup(function (e) {
            //    if (e.which == 13) {
            //        e.preventDefault();
            //        return false;

            //    }
            //});

            //FillBSRCodes();


            //$("[id*=ddlBank]").change(function () {
            //    $("[id*=txtBranchCode]").val($("[id*=ddlBank]").val());
            //});

            $("[id*=txtTDS]").keyup(function () {
                CalculateTotal();
            });

            $("[id*=txtSurcharge]").keyup(function () {
                CalculateTotal($(this));
            });

            $("[id*=txtECess]").keyup(function () {
                CalculateTotal($(this));
            });

            $("[id*=txtHECess]").keyup(function () {
                CalculateTotal($(this));
            });

            $("[id*=txtInterest]").keyup(function () {
                CalculateTotal($(this));
            });

            $("[id*=txtOthers]").keyup(function () {
                CalculateTotal($(this));
            });

            $("[id*=txtFees]").keyup(function () {
                CalculateTotal($(this));
            });

            $(document).on('change', '[id*=chkEmployeeID]', function (e) {

                //Find and reference the GridView.
                var grid = $(this).closest("table");

                //Find and reference the Header CheckBox.
                var chkAll = $("[id*=chkAll]");
                //If the CheckBox is Checked then enable the TextBoxes in thr Row.
                if (!$(this).is(":checked")) {
                    var td = $("td", $(this).closest("tr"));

                    $("input[type=text][id*=txtAmount_]", td).attr("disabled", "disabled");
                    $("input[type=text][id*=txtTDS_]", td).attr("disabled", "disabled");
                    $("input[type=text][id*=txtSurcharge_]", td).attr("disabled", "disabled");
                    $("input[type=text][id*=txtEducationCess_]", td).attr("disabled", "disabled");
                    $("input[type=text][id*=txtHigh_EductionCess_]", td).attr("disabled", "disabled");
                    $("input[type=text][id*=txtTotal_TDS_]", td).attr("disabled", "disabled");
                    $("input[type=text][id*=txtTotal_TDS_Amount_]", td).attr("disabled", "disabled");
                    //$("input[type=text][id*=txtCertNo]", td).attr("disabled", "disabled");
                    $("input[type=text][id*=txtTDS_]", td).val(0);
                    $("input[type=text][id*=txtSurcharge_]", td).val(0);
                    $("input[type=text][id*=txtEducationCess_]", td).val(0);
                    $("input[type=text][id*=txtHigh_EductionCess_]", td).val(0);
                    $("input[type=text][id*=txtTotal_TDS_]", td).val(0);
                    $("input[type=text][id*=txtTotal_TDS_Amount_]", td).val(0);
                } else {
                    var td = $("td", $(this).closest("tr"));
                    $("input[type=text][id*=txtAmount_]", td).removeAttr("disabled");
                    $("input[type=text][id*=txtTDS_]", td).removeAttr("disabled");
                    $("input[type=text][id*=txtSurcharge_]", td).removeAttr("disabled");
                    $("input[type=text][id*=txtEducationCess_]", td).removeAttr("disabled");
                    $("input[type=text][id*=txtHigh_EductionCess_]", td).removeAttr("disabled");
                    $("input[type=text][id*=txtTotal_TDS_]", td).removeAttr("disabled");
                    $("input[type=text][id*=txtTotal_TDS_Amount_]", td).removeAttr("disabled");
                    //$("input[type=text][id*=txtCertNo]", td).removeAttr("disabled");                    
                }

                //Enable Header Row CheckBox if all the Row CheckBoxes are checked and vice versa.
                if ($("[id*=chkRow]", grid).length == $("[id*=chkRow]:checked", grid).length) {
                    chkAll.attr("checked", "checked");
                } else {
                    chkAll.removeAttr("checked");
                }
            });

            $("#tblEmployeeList").on('input', '.clsAmount', function () {
                var calculated_total_sum = 0;

                $("#tblEmployeeList .clsAmount").each(function () {
                    var get_textbox_value = $(this).val();
                    if ($.isNumeric(get_textbox_value)) {
                        calculated_total_sum += parseFloat(get_textbox_value);
                    }
                });
                $("[id*=FooterTotalAmount]").html(calculated_total_sum);
            });

            $("#tblEmployeeList").on('input', '.clstds', function () {
                var calculated_total_sum = 0;

                $("#tblEmployeeList .clstds").each(function () {
                    var get_textbox_value = $(this).val();
                    if ($.isNumeric(get_textbox_value)) {
                        calculated_total_sum += parseFloat(get_textbox_value);
                    }
                });
                $("[id*=FooterTotalTDS]").html(calculated_total_sum);
                //alert(calculated_total_sum);
                //$("[id*=txtTDS]").val(calculated_total_sum);
                //$("input[type=text][id*=txtTDS]").val(calculated_total_sum);
                document.getElementById('<%=txtTDS.ClientID%>').value = calculated_total_sum;
            });

            $("#tblEmployeeList").on('input', '.clsSur', function () {
                var calculated_total_sum = 0;

                $("#tblEmployeeList .clsSur").each(function () {
                    var get_textbox_value = $(this).val();
                    if ($.isNumeric(get_textbox_value)) {
                        calculated_total_sum += parseFloat(get_textbox_value);
                    }
                });
                $("[id*=FooterTotalSur]").html(calculated_total_sum);
                document.getElementById('<%=txtSurcharge.ClientID%>').value = calculated_total_sum;
            });

            $("#tblEmployeeList").on('input', '.clsEcess', function () {
                var calculated_total_sum = 0;

                $("#tblEmployeeList .clsEcess").each(function () {
                    var get_textbox_value = $(this).val();
                    if ($.isNumeric(get_textbox_value)) {
                        calculated_total_sum += parseFloat(get_textbox_value);
                    }
                });
                $("[id*=FooterTotalEcess]").html(calculated_total_sum);
                document.getElementById('<%=txtECess.ClientID%>').value = calculated_total_sum;
            });

            $("#tblEmployeeList").on('input', '.clshcess', function () {
                var calculated_total_sum = 0;

                $("#tblEmployeeList .clshcess").each(function () {
                    var get_textbox_value = $(this).val();
                    if ($.isNumeric(get_textbox_value)) {
                        calculated_total_sum += parseFloat(get_textbox_value);
                    }
                });
                $("[id*=FooterTotalHcess]").html(calculated_total_sum);
                <%--document.getElementById('<%=txtHECess.ClientID%>').value = calculated_total_sum;--%>
            });

            $("#tblEmployeeList").on('input', '.clsTax', function () {
                var calculated_total_sum = 0;

                $("#tblEmployeeList .clsTax").each(function () {
                    var get_textbox_value = $(this).val();
                    if ($.isNumeric(get_textbox_value)) {
                        calculated_total_sum += parseFloat(get_textbox_value);
                    }
                });
                $("[id*=FooterTotalTax]").html(calculated_total_sum);
            });

            $("#tblEmployeeList").on('input', '.clsTotalTDS', function () {
                var calculated_total_sum = 0;

                $("#tblEmployeeList .clsTotalTDS").each(function () {
                    var get_textbox_value = $(this).val();
                    if ($.isNumeric(get_textbox_value)) {
                        calculated_total_sum += parseFloat(get_textbox_value);
                    }
                });
                $("[id*=FooterTotalDeposite]").html(calculated_total_sum);
            });
        });

        function EditRecord(i) {
            var row = i.closest("tr");
            var Cid = row.find("input[name=hdnSCid]").val();
            Grid_SalaryChallan(Cid);
        }


        function chkAllselect(i) {
            var chkprop = i.is(':checked');

            $("input[name=chkEmployeeID]").each(function () {
                if (chkprop) {
                    $(this).attr('checked', 'checked');
                    var td = $("td", $(this).closest("tr"));
                    $("input[type=text][id*=txtAmount_]", td).removeAttr("disabled");
                    $("input[type=text][id*=txtTDS_]", td).removeAttr("disabled");
                    $("input[type=text][id*=txtSurcharge_]", td).removeAttr("disabled");
                    $("input[type=text][id*=txtEducationCess_]", td).removeAttr("disabled");
                    $("input[type=text][id*=txtHigh_EductionCess_]", td).removeAttr("disabled");
                    $("input[type=text][id*=txtTotal_TDS_]", td).removeAttr("disabled");
                    $("input[type=text][id*=txtTotal_TDS_Amount_]", td).removeAttr("disabled");

                }
                else {
                    $(this).removeAttr('checked');
                    var td = $("td", $(this).closest("tr"));

                    $("input[type=text][id*=txtAmount_]", td).attr("disabled", "disabled");
                    $("input[type=text][id*=txtTDS_]", td).attr("disabled", "disabled");
                    $("input[type=text][id*=txtSurcharge_]", td).attr("disabled", "disabled");
                    $("input[type=text][id*=txtEducationCess_]", td).attr("disabled", "disabled");
                    $("input[type=text][id*=txtHigh_EductionCess_]", td).attr("disabled", "disabled");
                    $("input[type=text][id*=txtTotal_TDS_]", td).attr("disabled", "disabled");
                    $("input[type=text][id*=txtTotal_TDS_Amount_]", td).attr("disabled", "disabled");
                    //$("input[type=text][id*=txtCertNo]", td).attr("disabled", "disabled");
                    $("input[type=text][id*=txtTDS_]", td).val(0);
                    $("input[type=text][id*=txtSurcharge_]", td).val(0);
                    $("input[type=text][id*=txtEducationCess_]", td).val(0);
                    $("input[type=text][id*=txtHigh_EductionCess_]", td).val(0);
                    $("input[type=text][id*=txtTotal_TDS_]", td).val(0);
                    $("input[type=text][id*=txtTotal_TDS_Amount_]", td).val(0);
                }
            });
        }

        function Grid_SalaryChallan(Cid) {
            Blockloadershow();
            $("[id*=NewChallanCriteria_").show();
            $("[id*=AddChallanDetails").hide();
            $("[id*=ChallanDetails1").hide();
            $("[id*=tdSearch").hide();
            $("[id*=ChallanDetails").show();
            $("[id*=QtrSelect]").hide();
            $("[id*=btnNext]").hide();
            $("[id*=btnSave]").show();
            $("[id*=btnCancel]").show();
            $("[id*=ExportImportExcel_").hide();
            var compid = $("[id*=hdnCompanyid]").val();
           
            //Ajax start
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/SalaryChallanDetails.asmx/Edit_SalaryChallan",
                data: '{Company_ID:' + compid + ', Challan_ID:' + Cid + '}',
                dataType: "json",
                success: function (msg) {
                    var xmlDoc = $.parseXML(msg.d);
                    var xml = $(xmlDoc);
                    var myList = xml.find("Table");
                    var EmployeeList = xml.find("Table1");
                    if (myList.length > 0) {

                        $.each(myList, function () {
                            //if ($(this).find("Bank_Name").text() == false)
                            //    $("#radio1").prop("checked", true);
                            //else
                            //    $("#radio1").prop("checked", true);
                            $("[id*=ddlBranchCode]").val($(this).find("Bsrcode").text());
                            $("[id*=ddlBranchCode]").trigger('change');
                            $("[id*=txtChallanNo]").val($(this).find("Challan_No").text());
                            $("[id*=txtTDS]").val($(this).find("TDS_Amount").text());
                            $("[id*=txtSurcharge]").val($(this).find("Surcharge").text());
                            $("[id*=txtECess]").val($(this).find("Education_Cess").text());
                            $("[id*=txtHECess]").val($(this).find("High_Education_Cess").text());
                            $("[id*=txtInterest]").val($(this).find("Interest_Amt").text());
                            $("[id*=txtFees]").val($(this).find("Fees_Amount").text());
                            $("[id*=txtOthers]").val($(this).find("Others_Amount").text());
                            $("[id*=txtTotal]").val($(this).find("Challan_Amount").text());
                            //$("[id*=txtChallanDate]").val($(this).find("Challan_Date").text());
                            document.getElementById("txtChallanDate").valueAsDate = new Date($(this).find("Challan_Date").text());
                            $("[id*=ddlQuarter]").val($(this).find("Quater").text());
                            //$("[id*=ddSearchQuarter_]").val($(this).find("Quater").text());
                            $("[id*=ddlMonth]").val(xml.find("Table5").find("cdate").text());
                            $("[id*=hdnChallan_ID]").val($(this).find("Challan_ID").text());
                            //$("[id*=txtDateOfAmount]").val(moment(xml.find("Table4").find("Column1").text()).format('yyyy-MM-dd'));
                            document.getElementById("txtDateOfAmount").valueAsDate = new Date(xml.find("Table4").find("Column1").text());
                        });
                    }
                    if (EmployeeList.length > 0) {
                        //tblEmployeeList
                        var j = 0;
                        $("[id*=tblEmployeeList] tr").empty();
                        $("[id*=tblEmployeeList] tbody").empty();
                        var TotalDeposite = 0, Amount = 0, TDS = 0, Sur = 0, Ecess = 0, HCess = 0, TotalTax = 0;
                        var Challan_date;
                        var tbl = '';
                        tbl = tbl + "<tr style='background-color:#F2F2F2;'>";
                        tbl = tbl + "<th style='text-align: center;padding-left: 0px;padding-top: 17px;'><input type='checkbox' id='chkAll' name='chkAll' onclick='chkAllselect($(this))'></th>";
                        tbl = tbl + "<th style='text-align: Left;' >Name</th>";
                        //tbl = tbl + "<th style='text-align: Center;'>Date</th>";
                        tbl = tbl + "<th style='text-align: Center;'>Pan No</th>";
                        tbl = tbl + "<th style='text-align: Center;'>Vld</th>";
                        tbl = tbl + "<th style='text-align: right;' >Amount</th>";
                        tbl = tbl + "<th style='text-align: Right;'>TDS</th>";
                        tbl = tbl + "<th style='text-align: Right;'>Sur</th>";
                        tbl = tbl + "<th style='text-align: Right;'>E Cess</th>";
                        //tbl = tbl + "<th style='text-align: Right;'>H Cass</th>";
                        tbl = tbl + "<th style='text-align: Right;'>Total Tax</th>";
                        tbl = tbl + "<th style='text-align: Right;'>Total Depo</th>";
                        //tbl = tbl + "<th style='text-align: Right;'>R Type</th>";
                        //tbl = tbl + "<th style='text-align: Right;'>Cert No</th>";
                        tbl = tbl + "</tr>";

                        $.each(EmployeeList, function () {
                            Challan_date = moment($(this).find("CDate").text()).format('DD/MM/YYYY');
                            tbl = tbl + "<tr >";
                            tbl = tbl + "<td style='text-align: center;padding-left: 0px;padding-top:21px;'><input type='checkbox' id='chkEmployeeID' checked='checked' name='chkEmployeeID' value='" + $(this).find("Employee_ID").text() + "' ><input type='hidden' id='hdnCid' value='" + $(this).find("Employee_ID").text() + "' name='hdnCid'></td>"
                            tbl = tbl + "<td style='text-align: Left;padding-top:21px;' >" + $(this).find("FirstName").text() + "</td>";
                            //tbl = tbl + "<td style='text-align: Center; text-wrap:nowrap;' >" + Challan_date + "</td>";
                            tbl = tbl + "<td style='text-align: Center;padding-top:21px;' >" + $(this).find("PAN_NO").text() + "</td>";
                            if ($(this).find("PanVerified").text() == "Valid_PAN") {
                                tbl = tbl + "<td style='text-align: center;padding-top:21px;' class='padding5'><i class='icon-checkmark2 mr-3 icon-2x' style='cursor:pointer; height:18px; width:18px;color:green;' id='imgCPaid' name='imgCPaid'></td>";
                            }
                            else {
                                tbl = tbl + "<td style='text-align: center;padding-top:21px;' class='padding5'><i class='icon-cross3 mr-3 icon-2x' style='cursor:pointer; height:18px; width:18px;color:red;' id='imgCNot' name='imgCNot'></td>";
                            }
                            tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtAmount_' name='txtAmount_' class='form-control form-control-border clsAmount' style='text-align: right;'  value='" + $(this).find("Amount").text() + "'  /></td>";
                            tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtTDS_'   onkeyup='txt(this)' name='txtTDS_' class='form-control form-control-border clstds' style='text-align: right;'  value='" + $(this).find("TDS_Amount").text() + "'  /></td>";
                            tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtSurcharge_' name='txtSurcharge_' onkeyup='txt(this)' class='form-control form-control-border clsSur' style='text-align: right;'  value='" + $(this).find("Surcharge_Amount").text() + "'  /></td>";
                            tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtEducationCess_' name='txtEducationCess_' onkeyup='txt(this)' class='form-control form-control-border clsEcess' style='text-align: right;'  value='" + $(this).find("EducationCess_Amount").text() + "'  /></td>";
                            //tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtHigh_EductionCess_' name='txtHigh_EductionCess_' onkeyup='txt(this)' class='form-control form-control-border clshcess' style='text-align: right;'  value='" + $(this).find("High_EductionCess_Amount").text() + "'  /></td>";
                            tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtTotal_TDS_' name='txtTotal_TDS_' class='form-control form-control-border clsTax' style='text-align: right;'  value='" + $(this).find("Total_TDS_Amount").text() + "'  /></td>";
                            tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtTotal_TDS_Amount_' name='txtTotal_TDS_Amount_' class='form-control form-control-border clsTotalTDS' style='text-align: right;'  value='" + $(this).find("Total_TDS_Amount").text() + "'  /></td>";
                            //tbl = tbl + "<td style='text-align: right;' ><select id='ddlRType" + j + "' class='form-control'><option value='Reguler'>Reguler</option><option value='LowerDeduction A'>Lower Deduction A</option>";
                            //tbl = tbl + "<option value='NoDeduction B'>No Deduction B</option><option value='PANnotAvalable C'>PAN not Avalable C</option></select></td>";
                            //tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtCertNo' name='txtCertNo' class='form-control' style='text-align: left;'  value='" + $(this).find("CertNo").text() + "'  /></td>";
                            tbl = tbl + "</tr>";
                            $("[id*=ddlRType" + j + "]").val($(this).find("Deduction_Type").text());
                            Amount = Amount + parseFloat($(this).find("Amount").text());
                            TDS = TDS + parseFloat($(this).find("TDS_Amount").text());
                            TotalDeposite = TotalDeposite + parseFloat($(this).find("Total_TDS_Amount").text());
                            Sur = Sur + parseFloat($(this).find("Surcharge_Amount").text());
                            Ecess = Ecess + parseFloat($(this).find("EducationCess_Amount").text());
                            HCess = HCess + parseFloat($(this).find("High_EductionCess_Amount").text());
                            TotalTax = TotalTax + parseFloat($(this).find("Total_TDS_Amount").text());
                            j++;
                        });

                        tbl = tbl + "<tr >";
                        tbl = tbl + "<td style='text-align: center;font-weight:bold;'>&nbsp;</td>"
                        tbl = tbl + "<td style='text-align: Left;font-weight:bold;' >Total</td>";
                        //tbl = tbl + "<td style='text-align: Center;font-weight:bold;' >&nbsp;</td>";
                        tbl = tbl + "<td style='text-align: Center;font-weight:bold;' >&nbsp;</td>";
                        tbl = tbl + "<td style='text-align: center;font-weight:bold;'>&nbsp;</td>";
                        tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalAmount'>" + Amount + "</span></td>";
                        tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalTDS'>" + TDS + "</span></td>";
                        tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalSur'>" + Sur + "</span></td>";
                        tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalEcess'>" + Ecess + "</span></td>";
                        //tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalHcess'>" + HCess + "</span></td>";
                        tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalTax'>" + TotalTax + "</span></td>";
                        tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalDeposite'>" + TotalDeposite + "</span></td>";
                        //tbl = tbl + "<td style='text-align: right;font-weight:bold;' >&nbsp;</td>";
                        //tbl = tbl + "<td style='text-align: right;font-weight:bold;' >&nbsp;</td>";
                        tbl = tbl + "</tr>";

                        $("[id*=tblEmployeeList]").append(tbl);
                        $("[id*=txtTotalDepoAmount__]").val(TotalDeposite);
                    }
                    Blockloaderhide();
                },
                failure: function (response) {
                    showDangerAlert('Challan data not found');
                    Blockloaderhide();
                },
                error: function (response) {
                    showDangerAlert('Challan data not found');
                    Blockloaderhide();
                }
            });
        }

        function CalculateTotal(objref) {
            if (isNaN(parseInt(objref.val()))) {
                objref.val('0');
            } else {
                objref.val(parseFloat(objref.val()).toString());
            }

            var tds = $("input[type=text][id*=txtTDSAmount]").val();
            var surcharge = $("input[type=text][id*=txt_Surcharge]").val();
            var ECess = $("input[type=text][id*=txtEducationCess]").val();
            var Hecss = $("input[type=text][id*=txtHECess]").val();
            var Interest = $("input[type=text][id*=txtInterest]").val();
            var Others = $("input[type=text][id*=txtOthers]").val();
            var Fees = $("input[type=text][id*=txtFees]").val();

            if (isNaN(tds) || tds == "") { tds = 0; }
            if (isNaN(surcharge) || surcharge == "") { surcharge = 0; }
            if (isNaN(ECess) || ECess == "") { ECess = 0; }
            if (isNaN(Hecss) || Hecss == "") { Hecss = 0; }
            if (isNaN(Interest) || Interest == "") { Interest = 0; }
            if (isNaN(Others) || Others == "") { Others = 0; }
            if (isNaN(Fees) || Fees == "") { Fees = 0; }

            var result = 0;

            result = parseFloat(tds) + parseFloat(surcharge) + parseFloat(ECess) + parseFloat(Hecss) + parseFloat(Interest) + parseFloat(Others) + parseFloat(Fees);
            $(document.getElementById('<%=txtTotal.ClientID %>')).val(result);

        }

        //function getBank() {
        //    // ShowLoader();
        //    var compid = $("[id*=hdnCompanyid]").val();
        //    var Conn = $("[id*=hdnConnString]").val();
        //    var F = $("[id*=hdnForm]").val();
        //    //Ajax start
        //    $.ajax({
        //        type: "POST",
        //        contentType: "application/json; charset=utf-8",
        //        url: "../handler/Bank.asmx/onLoad",
        //        data: '{compid:' + compid + ', Conn:"' + Conn + '"}',
        //        dataType: "json",
        //        success: function (msg) {
        //            var xmlDoc = $.parseXML(msg.d);
        //            var xml = $(xmlDoc);
        //            var myList = xml.find("Table");
        //            if (myList.length > 0) {
        //                $("[id*=ddlBank]").empty();
        //                $("[id*=ddlBank]").append("<option value=0>--Select--</option>");

        //                $.each(myList, function () {
        //                    $("[id*=ddlBank]").append("<option value='" + $(this).find("Bsrcode").text() + "'>" + $(this).find("Bank_Name").text() + "</option>");
        //                });
        //            }
        //        },
        //        failure: function (response) {

        //        },
        //        error: function (response) {

        //        }
        //    });
        //}

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
                        $("[id*=ddlBranchCode]").empty();
                        $("[id*=ddlBranchCode]").append("<option value='0'>--Select--</option>");
                        for (var i = 0; i < outputBSRCodes.length; i++) {
                            $("[id*=ddlBranchCode]").append("<option value='" + outputBSRCodes[i].BankId + "'>" + outputBSRCodes[i].BSRCode + "</option>");
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

        function onLoad(pageIndex, Pagesize) {
            Blockloadershow();
            var compid = $("[id*=hdnCompanyid]").val();
            var Conn = $("[id*=hdnConnString]").val();
            var Q = $("[id*=ddSearchQuarter_]").val();
            var F = $("[id*=hdnForm]").val();
            var n = $("[id*=ddllSalarySearchby]").val();
            var RecordCount = 0;
            if (n == 1) {
                if ($("[id*=txtChallanNoSearch_]").val() == "") {
                    showInfoAlert('Enter challan no to search');
                    Blockloaderhide();
                    return;
                }
            }

            if (n == 2) {
                if ($("[id*=txtChallanDate]").val() == "") {
                    showInfoAlert('Enter challan date to search');
                    Blockloaderhide();
                    return;
                }
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/SalaryChallanDetails.asmx/onLoad",
                data: '{compid:' + compid + ', Quater:"' + Q + '", SalarySearchby: "' + $("[id*=ddllSalarySearchby]").val() + '", ChallanNo: "' + $("[id*=txtChallanNoSearch_]").val() + '",ChallanDate:"' + $("[id*=txtChallanDate]").val() + '",pageIndex:' + pageIndex + ',Pagesize:' + Pagesize + '}',
                dataType: "json",
                success: function (msg) {
                    var xmlDoc = $.parseXML(msg.d);
                    var xml = $(xmlDoc);
                    var myList = xml.find("Table");
                    var myList1 = xml.find("Table1");

                    $("[id*=tblChallanList] tr").empty();
                    $("[id*=tblChallanList] tbody").empty();
                    var Challan_date;

                    var tbl = '';
                    tbl = tbl + "<tr style='background-color:#F2F2F2;'>";
                    tbl = tbl + "<th style='text-align: Right; '>Sr No</th>";
                    tbl = tbl + "<th style='text-align: Center;' >Qtr</th>";
                    tbl = tbl + "<th style='text-align: right;' >Challan No.</th>";
                    tbl = tbl + "<th style='text-align: right;'>Total Employee</th>";
                    tbl = tbl + "<th style='text-align: Left;'>Bank Name</th>";
                    tbl = tbl + "<th style='text-align: Left;'>BSR Code</th>";
                    tbl = tbl + "<th style='text-align: Center;'>Payment Date</th>";
                    tbl = tbl + "<th style='text-align: Right;'>TDS</th>";
                    tbl = tbl + "<th style='text-align: Right;'>Other</th>";
                    tbl = tbl + "<th style='text-align: Right;'>Amount</th>";
                    tbl = tbl + "<th style='text-align: Right;'>Verified</th>";
                    tbl = tbl + "<th style='text-align: Left;'>Edit</th>";
                    tbl = tbl + "<th style='text-align: Left;'>Delete</th>";

                    tbl = tbl + "</tr>";
                    var i = 1;
                    if (myList.length > 0) {
                        $.each(myList, function () {
                            Challan_date = moment($(this).find("Challan_Date").text()).format('DD/MM/YYYY');
                            tbl = tbl + "<tr >";
                            tbl = tbl + "<td style='text-align: center; '>" + $(this).find("sino").text() + "</td>";
                            tbl = tbl + "<td style='text-align: Center;' >" + $(this).find("Quater").text() + "</td>";
                            tbl = tbl + "<td style='text-align: center;' >" + $(this).find("Challan_No").text() + "</td>";
                            tbl = tbl + "<td style='text-align: center;'>" + $(this).find("TotalEmployee").text() + "</td>";
                            tbl = tbl + "<td style='text-align: Left;'>" + $(this).find("Bank_Name").text() + "</td>";
                            tbl = tbl + "<td style='text-align: Left;'>" + $(this).find("Bank_Bsrcode").text() + "</td>";
                            tbl = tbl + "<td style='text-align: Center;'>" + Challan_date + "</td>";
                            tbl = tbl + "<td style='text-align: Right;'>" + $(this).find("TDS_Amount").text() + "</td>";
                            tbl = tbl + "<td style='text-align: Right;'>" + $(this).find("Others_Amount").text() + "</td>";
                            tbl = tbl + "<td style='text-align: Right;'>" + $(this).find("Challan_Amount").text() + "</td>";
                            tbl = tbl + "<td style='text-align: Right;'>" + $(this).find("Trans_No").text() + "</td>";
                            tbl = tbl + "<td style='text-align: center;'><a href='#'  onclick='EditRecord($(this))'><i class='far fa-edit mr-1 fa-1x'></i></a><input type='hidden' id='hdnSCid' value='" + $(this).find("Challan_ID").text() + "' name='hdnSCid'></td>";
                            tbl = tbl + "<td style='text-align: center;'><a class='list-icons-item '><i class='icon-trash text-danger-600'  onclick='Delete_Show($(this))'></i></a></td></tr>";

                            tbl = tbl + "</tr>";

                            i++;
                        });
                        if (parseFloat(myList1.length) > 0) {
                            RecordCount = parseFloat(myList1.find("TotalCount").text());
                        }
                        Pager(RecordCount);
                        $("[id*=tblChallanList]").append(tbl);
                        Blockloaderhide();
                    }

                    else {
                        tbl = tbl + "<tr>";
                        tbl = tbl + "<td colspan='13' style='text-align: center;' >No Record Found !!!</td>";
                        tbl = tbl + "</tr>";
                        $("[id*=tblChallanList]").append(tbl);
                        Pager(0);
                        Blockloaderhide();
                    }
                },
                failure: function (response) {
                    showDangerAlert('Challan data not found');
                    Blockloaderhide();
                },
                error: function (response) {
                    showDangerAlert('Challan data not found');
                    Blockloaderhide();
                }
            });
        }

        function CalculateTotal() {

            var tds = $("input[type=text][id*=txtTDS]").val();
            var surcharge = $("input[type=text][id*=txtSurcharge]").val();
            var ECess = $("input[type=text][id*=txtECess]").val();
            var Hecss = $("input[type=text][id*=txtHECess]").val();
            var Interest = $("input[type=text][id*=txtInterest]").val();
            var Others = $("input[type=text][id*=txtOthers]").val();
            var Fees = $("input[type=text][id*=txtFees]").val();

            if (isNaN(tds) || tds == "") { tds = 0; }
            if (isNaN(surcharge) || surcharge == "") { surcharge = 0; }
            if (isNaN(ECess) || ECess == "") { ECess = 0; }
            if (isNaN(Hecss) || Hecss == "") { Hecss = 0; }
            if (isNaN(Interest) || Interest == "") { Interest = 0; }
            if (isNaN(Others) || Others == "") { Others = 0; }
            if (isNaN(Fees) || Fees == "") { Fees = 0; }

            var result = 0;

            result = parseFloat(tds) + parseFloat(surcharge) + parseFloat(ECess) + parseFloat(Hecss) + parseFloat(Interest) + parseFloat(Others) + parseFloat(Fees);
            $(document.getElementById('<%=txtTotal.ClientID %>')).val(result);

        }

        function txt(objref) {
            //If the CheckBox is Checked then enable the TextBoxes in thr Row.
            // if (!objref.is(":checked")) {
            var result = 0;
            var td = $("td", objref.parentElement.parentElement);
            var txt1 = $("input[type=text][id*=txtTDS_]", td).val();
            var txt2 = $("input[type=text][id*=txtSurcharge_]", td).val();
            var txt3 = $("input[type=text][id*=txtEducationCess_]", td).val();
            var txt4 = $("input[type=text][id*=txtHigh_EductionCess_]", td).val();
            if (!isNaN(parseFloat(txt1)))
                result += parseFloat(txt1);

            if (!isNaN(parseFloat(txt2)))
                result += parseFloat(txt2);

            if (!isNaN(parseFloat(txt3)))
                result += parseFloat(txt3);

            if (!isNaN(parseFloat(txt4)))
                result += parseFloat(txt4);

            $("input[type=text][id*=txtTotal_TDS_]", td).val(result);
            $("input[type=text][id*=txtTotal_TDS_Amount_]", td).val(result);

            var calculated_total_sum = 0;

            $("#tblEmployeeList .clsTax").each(function () {
                var get_textbox_value = $(this).val();
                if ($.isNumeric(get_textbox_value)) {
                    calculated_total_sum += parseFloat(get_textbox_value);
                }
            });
            $("[id*=FooterTotalTax]").html(calculated_total_sum);
            document.getElementById('<%=txtTotal.ClientID%>').value = calculated_total_sum;
            document.getElementById('<%=txtTotalDepoAmount_.ClientID%>').value = calculated_total_sum;
            calculated_total_sum = 0;
            $("#tblEmployeeList .clsTotalTDS").each(function () {
                var get_textbox_value = $(this).val();
                if ($.isNumeric(get_textbox_value)) {
                    calculated_total_sum += parseFloat(get_textbox_value);
                }
            });
            $("[id*=FooterTotalDeposite]").html(calculated_total_sum);


        }

        function Pager(RecordCount) {
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
                p = $("[id*=ddlperpage]").val();
                onLoad(($(this).attr('page')), p);
            });
        }

        function ExcelExport() {
            $("#tblEmployeeList").table2excel({
                filename: "Employee_Records",
                name: "Employee"
            });

            //var copyTable = $("#tblEmployeeList").clone(true);
            //copyTable.find('input').remove();

            //copyTable.table2excel({
            //    filename: "Employee_Records",
            //    name: "Employee"
            //});
            //copyTable.remove();
        }

        function SelectFileToImport() {
            var files = document.getElementById('myFile').files;
            if (files.length == 0) {
                showDangerAlert("Please choose any file...");
                return;
            }
            var filename = files[0].name;
            var extension = filename.substring(filename.lastIndexOf(".")).toUpperCase();
            if (extension == '.XLS' || extension == '.XLSX') {
                //Here calling another method to read excel file into json
                excelFileToJSON(files[0]);
            } else {
                showDangerAlert("Please select a valid excel file.");
            }
        }
        function ExcelUpload() {
            if ($('#myFile').get(0).files.length === 0) {
                showDangerAlert("Please upload a file.");
                return false;
            }
            Blockloadershow();
            //var formData = new FormData(); //var formData = new FormData($('form')[0]);

            /////get the file and append it to the FormData object
            //formData.append('file', $('#myFile')[0].files[0]);

            var fileInput = document.getElementById('myFile');
            var file = fileInput.files[0];

            var formData = new FormData();
            formData.append('file', file);

            $.ajax(
                {
                    ///server script to process data
                    url: "../../TDS/BTStrp/handler/SalaryChallanDetails.asmx/ImportExcel",
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false, // Use 'false' to let the browser set the correct content type
                    enctype: 'multipart/form-data', // Set the enctype explicitly
                    success: function (msg) {
                        var xmlDoc = $.parseXML(msg.d);
                        var xml = $(xmlDoc);
                        var EmployeeList = xml.find("Table");

                        //success event
                        $("#myFile").val('');
                        if (EmployeeList.length > 0) {
                            var j = 0;
                            $("[id*=tblEmployeeList] tr").empty();
                            $("[id*=tblEmployeeList] tbody").empty();
                            var TotalDeposite = 0, Amount = 0, TDS = 0, Sur = 0, Ecess = 0, HCess = 0, TotalTax = 0;
                            var Challan_date;
                            var tbl = '';
                            tbl = tbl + "<tr style='background-color:#F2F2F2;'>";
                            tbl = tbl + "<th style='text-align: center;padding-left: 0px;padding-top: 17px;'><input type='checkbox' id='chkAll' name='chkAll' onclick='chkAllselect($(this))'></th>";
                            tbl = tbl + "<th style='text-align: Left;' >Name</th>";
                            //tbl = tbl + "<th style='text-align: Center; width:8%;'>Date</th>";
                            tbl = tbl + "<th style='text-align: Center;'>Pan No</th>";
                            tbl = tbl + "<th style='text-align: Center;'>Vld</th>";
                            tbl = tbl + "<th style='text-align: right;' >Amount</th>";
                            tbl = tbl + "<th style='text-align: Right;'>TDS</th>";
                            tbl = tbl + "<th style='text-align: Right;'>Sur</th>";
                            tbl = tbl + "<th style='text-align: Right;'>E Cess</th>";
                            //tbl = tbl + "<th style='text-align: Right;'>H Cass</th>";
                            tbl = tbl + "<th style='text-align: Right;'>Total Tax</th>";
                            tbl = tbl + "<th style='text-align: Right;'>Total Depo</th>";
                            //tbl = tbl + "<th style='text-align: Right;'>R Type</th>";
                            //tbl = tbl + "<th style='text-align: Right;'>Cert No</th>";
                            tbl = tbl + "</tr>";

                            $.each(EmployeeList, function () {
                                Challan_date = moment($(this).find("Date").text()).format('DD/MM/YYYY');
                                tbl = tbl + "<tr >";
                                tbl = tbl + "<td style='text-align: center;padding-left: 0px; padding-top:21px;'><input type='checkbox' id='chkEmployeeID' checked='checked' name='chkEmployeeID' value='" + $(this).find("Employee_ID").text() + "' ><input type='hidden' id='hdnCid' value='" + $(this).find("Employee_ID").text() + "' name='hdnCid'></td>"
                                tbl = tbl + "<td style='text-align: Left;padding-top:21px;' >" + $(this).find("Name").text() + "</td>";
                                //tbl = tbl + "<td style='text-align: Center; text-wrap:nowrap;' >" + Challan_date + "</td>";
                                tbl = tbl + "<td style='text-align: Center;padding-top:21px;' >" + $(this).find("Pan No").text() + "</td>";
                                if ($(this).find("PanVerified").text() == "Valid_PAN") {
                                    tbl = tbl + "<td style='text-align: center;padding-top:21px;' class='padding5'><i class='icon-checkmark2 mr-3 icon-2x' style='cursor:pointer; height:18px; width:18px; color:green;' id='imgCPaid' name='imgCPaid'></td>";
                                }
                                else {
                                    tbl = tbl + "<td style='text-align: center;padding-top:21px;' class='padding5'><i class='icon-cross3 mr-3 icon-2x' style='cursor:pointer; height:18px; width:18px; color:red;' id='imgCNot' name='imgCNot'></td>";
                                }
                                tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtAmount_' name='txtAmount_' class='form-control form-control-border clsAmount' style='text-align: right;'  value='" + $(this).find("Amount").text() + "'  /></td>";
                                tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtTDS_'   onkeyup='txt(this)' name='txtTDS_' class='form-control form-control-border clstds' style='text-align: right;'  value='" + $(this).find("TDS").text() + "'  /></td>";
                                tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtSurcharge_' name='txtSurcharge_' onkeyup='txt(this)' class='form-control form-control-border clsSur' style='text-align: right;'  value='" + $(this).find("Sur").text() + "'  /></td>";
                                tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtEducationCess_' name='txtEducationCess_' onkeyup='txt(this)' class='form-control form-control-border clsEcess' style='text-align: right;'  value='" + $(this).find("E Cess").text() + "'  /></td>";
                                //tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtHigh_EductionCess_' name='txtHigh_EductionCess_' onkeyup='txt(this)' class='form-control form-control-border clshcess' style='text-align: right;'  value='" + $(this).find("H Cass").text() + "'  /></td>";
                                tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtTotal_TDS_' name='txtTotal_TDS_' class='form-control form-control-border clsTax' style='text-align: right;'  value='" + $(this).find("Total Tax").text() + "'  /></td>";
                                tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtTotal_TDS_Amount_' name='txtTotal_TDS_Amount_' class='form-control form-control-border clsTotalTDS' style='text-align: right;'  value='" + $(this).find("Total Depo").text() + "'  /></td>";
                                //tbl = tbl + "<td style='text-align: right;' ><select id='ddlRType" + j + "' class='form-control'><option value='Reguler'>Reguler</option><option value='LowerDeduction A'>Lower Deduction A</option>";
                                //tbl = tbl + "<option value='NoDeduction B'>No Deduction B</option><option value='PANnotAvalable C'>PAN not Avalable C</option></select></td>";
                                //tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtCertNo' name='txtCertNo' class='form-control' style='text-align: left;'  value='" + $(this).find("Cert No").text() + "'  /></td>";
                                tbl = tbl + "</tr>";
                                $("[id*=ddlRType" + j + "]").val($(this).find("R Type").text());
                                Amount = Amount + parseFloat($(this).find("Amount").text());
                                TDS = TDS + parseFloat($(this).find("TDS").text());
                                TotalDeposite = TotalDeposite + parseFloat($(this).find("Total Tax").text());
                                Sur = Sur + parseFloat($(this).find("Sur").text());
                                Ecess = Ecess + parseFloat($(this).find("E Cess").text());
                                HCess = HCess + parseFloat($(this).find("H Cass").text());
                                TotalTax = TotalTax + parseFloat($(this).find("Total Depo").text());
                                j++;
                            });

                            tbl = tbl + "<tr >";
                            tbl = tbl + "<td style='text-align: center;font-weight:bold;'>&nbsp;</td>"
                            tbl = tbl + "<td style='text-align: Left;font-weight:bold;' >Total</td>";
                            //tbl = tbl + "<td style='text-align: Center;font-weight:bold;' >&nbsp;</td>";
                            tbl = tbl + "<td style='text-align: Center;font-weight:bold;' >&nbsp;</td>";
                            tbl = tbl + "<td style='text-align: center;font-weight:bold;'>&nbsp;</td>";
                            tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalAmount'>" + Amount + "</span></td>";
                            tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalTDS'>" + TDS + "</span></td>";
                            tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalSur'>" + Sur + "</span></td>";
                            tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalEcess'>" + Ecess + "</span></td>";
                            //tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalHcess'>" + HCess + "</span></td>";
                            tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalTax'>" + TotalTax + "</span></td>";
                            tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalDeposite'>" + TotalDeposite + "</span></td>";
                            //tbl = tbl + "<td style='text-align: right;font-weight:bold;' >&nbsp;</td>";
                            //tbl = tbl + "<td style='text-align: right;font-weight:bold;' >&nbsp;</td>";
                            tbl = tbl + "</tr>";

                            $("[id*=tblEmployeeList]").append(tbl);
                            $("[id*=txtTotalDepoAmount__]").val(TotalDeposite);
                        }
                        Blockloaderhide();

                    },
                    error: function (e) {
                        //alert(e.responseText);
                        $("#file").val('');
                        showDangerAlert(e.responseText);
                        Blockloaderhide();
                        return false;
                    }
                });
        }

        function ExcelImport() {

            if ($('#myFile').get(0).files.length === 0) {
                showWarningAlert("Please upload a file.");
                return false;
            }

            Blockloadershow();
            ///create a new FormData object
            var formData = new FormData(); //var formData = new FormData($('form')[0]);

            ///get the file and append it to the FormData object
            formData.append('file', $('#myFile')[0].files[0]);

            ///AJAX request
            $.ajax(
                {
                    ///server script to process data
                    url: '../Handler/ImportExcelForChallan.ashx', //web service
                    type: 'POST',
                    complete: function () {
                        //on complete event    

                    },
                    progress: function (evt) {
                        //progress event    
                    },
                    ///Ajax events
                    beforeSend: function (e) {
                        //before event  
                    },
                    success: function (msg) {
                        //success event

                        $("#myFile").val('');
                        var xmlDoc = $.parseXML(msg);
                        var xml = $(xmlDoc);
                        var EmployeeList = xml.find("Table");

                        //success event
                        $("#myFile").val('');
                        if (EmployeeList.length > 0) {
                            var j = 0;
                            $("[id*=tblEmployeeList] tr").empty();
                            $("[id*=tblEmployeeList] tbody").empty();
                            var TotalDeposite = 0, Amount = 0, TDS = 0, Sur = 0, Ecess = 0, HCess = 0, TotalTax = 0;
                            var Challan_date;
                            var tbl = '';
                            tbl = tbl + "<tr style='background-color:#F2F2F2;'>";
                            tbl = tbl + "<th style='text-align: center;padding-left: 0px;padding-top: 17px;'><input type='checkbox' id='chkAll' name='chkAll' onclick='chkAllselect($(this))'></th>";
                            tbl = tbl + "<th style='text-align: Left;' >Name</th>";
                            //tbl = tbl + "<th style='text-align: Center;'>Date</th>";
                            tbl = tbl + "<th style='text-align: Center;'>Pan No</th>";
                            tbl = tbl + "<th style='text-align: Center;'>Vld</th>";
                            tbl = tbl + "<th style='text-align: right;' >Amount</th>";
                            tbl = tbl + "<th style='text-align: Right;'>TDS</th>";
                            tbl = tbl + "<th style='text-align: Right;'>Sur</th>";
                            tbl = tbl + "<th style='text-align: Right;'>E Cess</th>";
                            //tbl = tbl + "<th style='text-align: Right;'>H Cass</th>";
                            tbl = tbl + "<th style='text-align: Right;'>Total Tax</th>";
                            tbl = tbl + "<th style='text-align: Right;'>Total Depo</th>";
                            //tbl = tbl + "<th style='text-align: Right;'>R Type</th>";
                            //tbl = tbl + "<th style='text-align: Right;'>Cert No</th>";
                            tbl = tbl + "</tr>";

                            $.each(EmployeeList, function () {
                                if ($(this).find("Employee_ID").text() != "") {
                                    Challan_date = moment($(this).find("CDate").text()).format('DD/MM/YYYY');
                                    tbl = tbl + "<tr >";
                                    tbl = tbl + "<td style='text-align: center;padding-left: 0px; padding-top: 21px;'><input type='checkbox' id='chkEmployeeID' checked='checked' name='chkEmployeeID' value='" + $(this).find("Employee_ID").text() + "' ><input type='hidden' id='hdnCid' value='" + $(this).find("Employee_ID").text() + "' name='hdnCid'></td>"
                                    tbl = tbl + "<td style='text-align: Left;padding-top:21px;' >" + $(this).find("FirstName").text() + "</td>";
                                    //tbl = tbl + "<td style='text-align: Center; text-wrap:nowrap;' >" + Challan_date + "</td>";
                                    tbl = tbl + "<td style='text-align: Center;padding-top:21px;' >" + $(this).find("PAN_NO").text() + "</td>";
                                    if ($(this).find("PanVerified").text() == "Valid_PAN") {
                                        tbl = tbl + "<td style='text-align: center;padding-top:21px;' class='padding5'><i class='icon-checkmark2 mr-3 icon-2x' style='cursor:pointer; height:18px; width:18px;color:green;' id='imgCPaid' name='imgCPaid'></td>";
                                    }
                                    else {
                                        tbl = tbl + "<td style='text-align: center;padding-top:21px;' class='padding5'><i class='icon-cross3 mr-3 icon-2x' style='cursor:pointer; height:18px; width:18px;color:red;' id='imgCNot' name='imgCNot'></td>";
                                    }
                                    tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtAmount_' name='txtAmount_' class='form-control form-control-border clsAmount' style='text-align: right;'  value='" + $(this).find("Amount").text() + "'  /></td>";
                                    tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtTDS_'   onkeyup='txt(this)' name='txtTDS_' class='form-control form-control-border clstds' style='text-align: right;'  value='" + $(this).find("TDS_Amount").text() + "'  /></td>";
                                    tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtSurcharge_' name='txtSurcharge_' onkeyup='txt(this)' class='form-control form-control-border clsSur' style='text-align: right;'  value='" + $(this).find("Surcharge_Amount").text() + "'  /></td>";
                                    tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtEducationCess_' name='txtEducationCess_' onkeyup='txt(this)' class='form-control form-control-border clsEcess' style='text-align: right;'  value='" + $(this).find("EducationCess_Amount").text() + "'  /></td>";
                                    //tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtHigh_EductionCess_' name='txtHigh_EductionCess_' onkeyup='txt(this)' class='form-control form-control-border clshcess' style='text-align: right;'  value='" + $(this).find("High_EductionCess_Amount").text() + "'  /></td>";
                                    tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtTotal_TDS_' name='txtTotal_TDS_' class='form-control form-control-border clsTax' style='text-align: right;'  value='" + $(this).find("Total_TDS_Amount").text() + "'  /></td>";
                                    tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtTotal_TDS_Amount_' name='txtTotal_TDS_Amount_' class='form-control form-control-border clsTotalTDS' style='text-align: right;'  value='" + $(this).find("Total_TDS_Amount").text() + "'  /></td>";
                                    //tbl = tbl + "<td style='text-align: right;' ><select id='ddlRType" + j + "' class='form-control'><option value='Reguler'>Reguler</option><option value='LowerDeduction A'>Lower Deduction A</option>";
                                    //tbl = tbl + "<option value='NoDeduction B'>No Deduction B</option><option value='PANnotAvalable C'>PAN not Avalable C</option></select></td>";
                                    //tbl = tbl + "<td style='text-align: right;' ><input type='text' id='txtCertNo' name='txtCertNo' class='form-control' style='text-align: left;'  value='" + $(this).find("Cert No").text() + "'  /></td>";
                                    tbl = tbl + "</tr>";
                                    $("[id*=ddlRType" + j + "]").val($(this).find("R Type").text());
                                    Amount = Amount + parseFloat($(this).find("Amount").text());
                                    TDS = TDS + parseFloat($(this).find("TDS_Amount").text());
                                    TotalDeposite = TotalDeposite + parseFloat($(this).find("Total_TDS_Amount").text());
                                    Sur = Sur + parseFloat($(this).find("Surcharge_Amount").text());
                                    Ecess = Ecess + parseFloat($(this).find("EducationCess_Amount").text());
                                    HCess = HCess + parseFloat($(this).find("High_EductionCess_Amount").text());
                                    TotalTax = TotalTax + parseFloat($(this).find("Total_TDS_Amount").text());
                                    j++;
                                }
                            });

                            tbl = tbl + "<tr >";
                            tbl = tbl + "<td style='text-align: center;font-weight:bold;'>&nbsp;</td>"
                            tbl = tbl + "<td style='text-align: Left;font-weight:bold;' >Total</td>";
                            //tbl = tbl + "<td style='text-align: Center;font-weight:bold;' >&nbsp;</td>";
                            tbl = tbl + "<td style='text-align: Center;font-weight:bold;' >&nbsp;</td>";
                            tbl = tbl + "<td style='text-align: center;font-weight:bold;'>&nbsp;</td>";
                            tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalAmount'>" + Amount + "</span></td>";
                            tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalTDS'>" + TDS + "</span></td>";
                            tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalSur'>" + Sur + "</span></td>";
                            tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalEcess'>" + Ecess + "</span></td>";
                            //tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalHcess'>" + HCess + "</span></td>";
                            tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalTax'>" + TotalTax + "</span></td>";
                            tbl = tbl + "<td style='text-align: right;font-weight:bold;' ><span id='FooterTotalDeposite'>" + TotalDeposite + "</span></td>";
                            //tbl = tbl + "<td style='text-align: right;font-weight:bold;' >&nbsp;</td>";
                            //tbl = tbl + "<td style='text-align: right;font-weight:bold;' >&nbsp;</td>";
                            tbl = tbl + "</tr>";

                            $("[id*=tblEmployeeList]").append(tbl);
                            $("[id*=txtTotalDepoAmount__]").val(TotalTax);
                            $("[id*=txtTDS]").val(TDS);
                            $("[id*=txtSurcharge]").val(Sur);
                            $("[id*=txtECess]").val(Ecess);
                            $("[id*=txtHECess]").val(HCess);
                            $("[id*=txtTotal]").val(TotalTax);
                        }
                        Blockloaderhide();
                    },
                    error: function (e) {
                        //errorHandler
                        Blockloaderhide();
                        showWarningAlert('Excel Sheet column mismatch or invalid date format');
                    },
                    ///Form data
                    data: formData,
                    ///Options to tell JQuery not to process data or worry about content-type
                    cache: false,
                    contentType: false,
                    processData: false
                });
            ///end AJAX request
            return false;
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:HiddenField ID="hdnCompanyid" runat="server" />
    <asp:HiddenField ID="hdnisNri" runat="server" />
    <asp:HiddenField ID="hdnQuater" runat="server" />
    <asp:HiddenField ID="hdnNatureID" runat="server" />
    <asp:HiddenField ID="hdnSection" runat="server" />
    <asp:HiddenField ID="hdnConnString" runat="server" />
    <asp:HiddenField ID="hdnPages" runat="server" />
    <asp:HiddenField ID="hdnDSrch" runat="server" />
    <asp:HiddenField ID="hdnDate" runat="server" />
    <asp:HiddenField ID="hdnDrps" runat="server" />
    <asp:HiddenField ID="hdnMis" runat="server" />
    <asp:HiddenField ID="hdnForm" runat="server" />
    <asp:HiddenField ID="hdnLnk" runat="server" />
    <asp:HiddenField runat="server" ID="hdnChallan_ID" />
    <!-- Main content -->
    <div class="row" style="height: 10px;"></div>
    <div class="content">

        <div class="card">
            <div class="form-group row">
                <div class="col-lg-1" style="padding-left: 30px; padding-top: 14px;">
                    <h5><span style="font-size: large;">24Q</span></h5>
                </div>
                <div id="QtrSelect" class="form-group row col-lg-11" style="padding-bottom: 2px;">
                    <div class="col-lg-0.7" style="font-size: large;">
                        <select id="ddSearchQuarter_" name="ddSearchQuarter_" class="form-control select">
                            <option value="0">Qtr</option>
                            <option value="Q1">Q1</option>
                            <option value="Q2">Q2</option>
                            <option value="Q3">Q3</option>
                            <option value="Q4">Q4</option>
                        </select>
                    </div>

                    <div class="col-lg-2">
                        <input id="txtChallanNoSearch_" type="text" class="form-control form-control-border" placeholder="Search Challan" />
                    </div>

                    <%--<div class="col-1.5">
                        <select id="ddllSalarySearchby" class="form-control">
                            <option value="0" selected="selected">--Search--</option>
                            <option value="1">Challan No</option>
                            <option value="2">Challan Date</option>
                        </select>
                    </div>--%>
                    <%--<div class="col-lg-1" id="the-basics" style="padding-right: 0;">
                            <label id="ChallanNoLabel_" class="col-form-label font-weight-bold text-right">Challan No</label>
                            <label id="ChallanDateLabel_" class="col-form-label font-weight-bold text-right">Challan Date</label>
                        </div>--%>
                    <%-- <div class="col-lg-1" id="the-basics" style="padding-right: 0;">
                        <input id="txtChallanNoSearch_" name="txtChallanNoSearch_" tabindex="2" type="text" class="typeahead form-control" value="" placeholder="Challan No" style="padding-right: 0; padding-left: 0;" />
                        <input type="date" placeholder="DD/MM/YYYY" id="txtChallanDateSearch_" class="form-control " style="padding-right: 0; padding-left: 0;" />
                    </div>--%>

                    <div style="margin-left: auto;">
                        <%-- <button id="btnSearch" name="btnSearch" class="btn btn-success btn-labeled btn-labeled-left " type="button"><b><i class="icon-search4"></i></b>Search</button>&nbsp;--%>
                        <button id="btnAddnew" name="btnAddnew" class="btn btn-outline-success legitRipple" type="button"><i class="fas fa-plus mr-2 fa-1x"></i>Add New</button>
                        &nbsp;&nbsp;
                        <button id="btnVerification" name="btnVerification" class="btn btn-outline-success legitRipple" type="button"><i class="far fa-check-circle mr-2 fa-1x"></i>Verify Now</button>
                        &nbsp;&nbsp;
                    </div>
                    <div class="col-lg-0.7">
                        <select id="ddlperpage" class="form-control select">
                            <option value="200">200</option>
                            <option value="300">300</option>
                            <option value="400">400</option>
                            <option value="500">500</option>
                        </select>
                    </div>
                </div>

                <div class="col-lg-11" id="NewChallanCriteria_" style="padding-bottom: 5px;">
                    <div class="row">
                        <div class="col-lg-1.5" style="font-size: large;">
                            <select id="ddlMonth" class="form-control select">
                                <option value="Select">Month</option>
                                <option value="Apr">Apr</option>
                                <option value="May">May</option>
                                <option value="June">June</option>
                                <option value="July">July</option>
                                <option value="Aug">Aug</option>
                                <option value="Sept">Sept</option>
                                <option value="Oct">Oct</option>
                                <option value="Nov">Nov</option>
                                <option value="Dec">Dec</option>
                                <option value="Jan">Jan</option>
                                <option value="Feb">Feb</option>
                                <option value="Mar">Mar</option>
                            </select>
                        </div>
                        &nbsp; &nbsp;
                        <div class="col-lg-1" style="font-size: large;">
                            <select id="ddlQuarter" name="ddlQuarter" class="form-control form-control-border" disabled="disabled">
                                <option value="0">Qtr</option>
                                <option value="Q1">Q1</option>
                                <option value="Q2">Q2</option>
                                <option value="Q3">Q3</option>
                                <option value="Q4">Q4</option>
                            </select>
                        </div>
                        &nbsp;&nbsp;
                        <div style="padding-top: 8px;">
                            <label class="col-form-label">Dt of Salary :</label>
                        </div>
                        &nbsp;&nbsp;
                        <div class="col-lg-1.5">
                            <input type="date" placeholder="dd/MM/yyyy" id="txtDateOfAmount" class="form-control form-control-border " style="font-size: large;" />
                        </div>
                        <div class="col-lg-2" style="margin-left: auto;">
                            <button id="btnNext" name="btnNext" class="btn btn-outline-success legitRipple" type="button"><b><i class="mi-arrow-forward"></i></b>Next</button>
                            <button id="btnSave" name="btnSave" class="btn btn-outline-success legitRipple" type="button"><b><i class="mi-save"></i></b>Save</button>
                            <input id="btnCancel" tabindex="19" class="btn btn-outline-success legitRipple" value="Cancel" type="button" />
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- Content area -->

        <div id="Content">
            <div class="row" id="tdSearch" style="padding-left: 0px; padding-right: 0px;">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-body" style="padding-top: 5px;">
                            <div>
                                <h5>
                                    <label class="col-form-label" style="padding-top: 5px; padding-left: 10px; font-size: large;">List of Challans</label>
                                </h5>
                            </div>
                            <div class="row">
                                <div class="table-responsive">
                                    <table id="tblChallanList" class="table-bordered table table-hover table-xs font-size-base"></table>
                                </div>
                            </div>
                            <div class="row">
                                <table id="tblPager" class="col-12" style="border-top: 1px solid #BCBCBC;">
                                    <tr>
                                        <td>
                                            <div class="Pager">
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="AddChallanDetails">
                <div class="row">
                    <div class="col-md-9">
                        <div class="card" id="EmpTDS">
                            <div class="card-body">
                                <div>
                                    <h5>
                                        <label class="col-form-label" style="font-size: large; padding-top: 8px;">TDS Details</label>
                                    </h5>
                                </div>

                                <div class="row" id="ExportImportExcel_">
                                    <div class="col-3 " style="padding-top: 5px;">
                                        <input id="chkShowOnlyTaxableEmployees" tabindex="7" runat="server" class="form-check-inline" type="checkbox" />
                                        <label id="Label31" class="col-form-label">Show Taxable Employees</label>
                                    </div>
                                    <label class="col-lg-1 col-form-label" style="padding-right: 0; padding-top: 5px;">Step 1</label>
                                    <div class="col-2">
                                        <%--<input type="button" class="btn btn-outline-success rounded-round legitRipple" onclick="ExcelExport();" value="Export to Excel" id="btnExportToExcel" name="btnExportToExcel" />--%>
                                        <asp:Button ID="btnExprecd" OnClick="btnExprecd_Click" runat="server" Class="btn btn-outline-success legitRipple" Text="Export to Excel" />
                                    </div>
                                    <label class="col-lg-0.5 col-form-label" style="padding-right: 0; padding-top: 5px;">Step 2</label>
                                    <div class="col-3">
                                        <input type="file" id="myFile" class="file-input" name="filename" style="padding-top: 5px;" />
                                    </div>
                                    <div class="col-2">
                                        <input type="button" class="btn btn-outline-success legitRipple" onclick="ExcelImport()" value="Import from Excel" id="btnImportToExcel" name="btnImportToExcel" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12 table-responsive" style="height: 480px; overflow-y: auto; padding-left: 0px;">
                                        <table id="tblEmployeeList" class="table table-hover table-xs font-size-base"></table>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        &nbsp;
                                    </div>
                                    <label class="col-lg-3 col-form-label font-weight-bold text-right">
                                        Total Deposit Amount</label>
                                    <div class="col-lg-1 text-left">
                                        <input id="txtTotalDepoAmount_" runat="server" autocomplete="off" class="form-control form-control-border "
                                            value="0" style="text-align: right; font-weight: bold;" />
                                    </div>
                                    <div class="col-lg-2">
                                        &nbsp;
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="card">
                            <div class="card-body" style="height: 636px">
                                <div>
                                    <h5>
                                        <label class="col-form-label" style="font-size: large; padding-top: 8px;">Challan Details</label>
                                    </h5>
                                </div>
                                <div class="form-group row">
                                    <label class="col-lg-4 col-form-label">Nil Challan</label>
                                    <div class="col-lg-7 col-form-label" style="padding-right: 0;">
                                        <div class="form-check-inline">
                                            <input class="form-check-input" type="radio" name="radio1" />
                                            <label class="form-check-label">Yes</label>
                                        </div>
                                        <div class="form-check-inline">
                                            <input class="form-check-input" type="radio" name="radio1" checked="checked" />
                                            <label class="form-check-label">No </label>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-lg-4 col-form-label" style="padding-top: 10px;">Challan No</label>
                                    <div style="padding-top: 10px;">:</div>
                                    <div class="col-lg-6" id="the-basics">
                                        <input id="txtChallanNo" name="txtChallanNo" tabindex="2" type="text" class="typeahead form-control form-control-border" value="" placeholder="Challan No" />
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-lg-4 col-form-label" style="padding-top: 12px;">Date</label>
                                    <div style="padding-top: 12px;">:</div>
                                    <div class="col-lg-6">
                                        <input type="date" placeholder="DD/MM/YYYY" id="txtChallanDate" class="form-control form-control-border " />
                                    </div>
                                </div>

                                <%-- <div class="form-group row">
                                    <label class="col-lg-4 col-form-label" style="padding-top: 12px;">Bank</label>
                                    <div style="padding-top: 12px;">:</div>
                                    <div class="col-lg-6">
                                        <select id="ddlBank" runat="server" class="form-control select" tabindex="4" data-fouc>
                                            <option value="Select">Select</option>
                                        </select>
                                    </div>
                                </div>--%>

                                <div class="form-group row">
                                    <label class="col-lg-4 col-form-label" style="padding-top: 12px;">BSR Code</label>
                                    <div style="padding-top: 12px;">:</div>
                                    <div class="col-lg-6" id="the-basics">
                                        <select id="ddlBranchCode" name="ddlBranchCode" tabindex="2" class="form-control select-search"></select>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-lg-4 col-form-label " style="padding-top: 12px;">TDS</label>
                                    <div style="padding-top: 12px;">:</div>
                                    <div class="col-lg-6 text-right">
                                        <input id="txtTDS" runat="server" tabindex="8" autocomplete="off" class="form-control form-control-border "
                                            value="0.00" style="text-align: right;" />
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-lg-4 col-form-label" style="padding-top: 12px;">Surcharge</label>
                                    <div style="padding-top: 12px;">:</div>
                                    <div class="col-lg-6 text-right">
                                        <input id="txtSurcharge" runat="server" tabindex="8" autocomplete="off" class="form-control form-control-border "
                                            value="0.00" style="text-align: right;" />
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-lg-4 col-form-label" style="padding-top: 12px;">E.Cess</label>
                                    <div style="padding-top: 12px;">:</div>
                                    <div class="col-lg-6 text-right">
                                        <input id="txtECess" runat="server" tabindex="8" autocomplete="off" class="form-control form-control-border"
                                            value="0.00" style="text-align: right;" />
                                    </div>
                                </div>
                                <%-- <div class="form-group row">
                                    <label class="col-lg-4 col-form-label" style="padding-left: 0;">HE Cess</label>
                                    <div class="col-lg-6 text-right">
                                        <input id="txtHECess" runat="server" tabindex="8" autocomplete="off" class="form-control "
                                            value="0" style="text-align: right;" />
                                    </div>

                                </div>--%>
                                <div class="form-group row">
                                    <label class="col-lg-4 col-form-label" style="padding-top: 12px;">Interest</label>
                                    <div style="padding-top: 12px;">:</div>
                                    <div class="col-lg-6 text-right">
                                        <input id="txtInterest" runat="server" tabindex="8" autocomplete="off" class="form-control form-control-border "
                                            value="0.00" style="text-align: right;" />
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-lg-4 col-form-label" style="padding-top: 12px;">Fees</label>
                                    <div style="padding-top: 12px;">:</div>
                                    <div class="col-lg-6 text-right">
                                        <input id="txtFees" runat="server" tabindex="8" autocomplete="off" class="form-control form-control-border "
                                            value="0.00" style="text-align: right;" />
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-lg-4 col-form-label" style="padding-top: 12px;">Others</label>
                                    <div style="padding-top: 12px;">:</div>
                                    <div class="col-lg-6 text-right">
                                        <input id="txtOthers" runat="server" tabindex="8" autocomplete="off" class="form-control form-control-border "
                                            value="0.00" style="text-align: right;" />
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-lg-4 col-form-label" style="padding-top: 12px;">Total</label>
                                    <div style="padding-top: 12px;">:</div>
                                    <div class="col-lg-6 text-right">
                                        <input id="txtTotal" runat="server" tabindex="8" autocomplete="off" class="form-control form-control-border "
                                            value="0.00" style="text-align: right;" />
                                    </div>
                                    <div class="col-lg-3 text-right">&nbsp;</div>
                                </div>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </div>

</asp:Content>

