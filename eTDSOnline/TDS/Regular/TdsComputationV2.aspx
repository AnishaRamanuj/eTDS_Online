<%@ Page Title="" Language="C#" MasterPageFile="~/TDS/BTS_MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="TdsComputationV2.aspx.cs" Inherits="Admin_TdsComputationV2" %>

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
     <!-------------------------------------- Tabulator CSS and JS ------------------------------------------------>
    <link href="https://unpkg.com/tabulator-tables@5.0.7/dist/css/tabulator_modern.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="https://unpkg.com/tabulator-tables@5.0.7/dist/js/tabulator.min.js"></script>
    <!-------------------------------------- Tabulator CSS and JS ------------------------------------------------>

    <script language="javascript" type="text/javascript">
        var baseUrl = '<%=ResolveUrl("../../TDS/BTStrp/Handler/TDSComputationV2.asmx/") %>';
        var companyid = 0;
        var hRRchange = 0;

        var pgindex = 1;

        var closeButtonClicked = false;
        var kyprss = '';
        var SurSlab = '';
        $(document).ready(function () {
            $('tr.parent')
                .css("cursor", "pointer")
                .attr("title", "Click to expand/collapse")
                .click(function () {
                    $(this).siblings('.child-' + this.id).toggle();
                });
            companyid = $("[id*=hdnCompanyid]").val();
            $("[id*=hdnConnString]").val($("[id*=ddlFinancialYear] :selected").text());
            $("[id*=hdnPages]").val(1);

            Fill_defaults();

            getEmployeeList();

            $("[id*=chkUSBAC]").on('change', function () {

                var hdr = $('#chkUSBAC').prop("checked");
                if (hdr == true) {
                    $("[id*=txtTravel]").val(0);
                    $("[id*=txtGratuity]").val(0);
                    $("[id*=txtPension]").val(0);
                    $("[id*=txtLeave]").val(0);
                    $("[id*=txtSOthers]").val(0);
                    //$("[id*=txtOthers]").val(0);
                    $("#txtRebate80C_Ded").val(0);
                    $("#txtRebate80CCC_Ded").val(0);
                    $("#txtRebate80CCD_Ded").val(0);
                    $("#spanRebate80CTotal").html(0);
                    $("#txtRebate80CCD1B_Ded").val(0);
                    $("#txtRebate80D_Ded").val(0);
                    $("#txtRebate80G").val(0);
                    $("#txtRebate80E_Ded").val(0);
                    $("#txtRebate80EE_Ded").val(0);

                    $("#txtRebate80TTA_Ded").val(0);
                    $("#txtRebateOthers_Ded").val(0);
                    $("#spanRebateTotal").html(0);
                    $("#txtEntertainment").val(0);
                    $("#txtPTax").val(0);




                    //var tt = parseFloat(t) + parseFloat(g) + parseFloat(p) + parseFloat(l) + parseFloat(o);
                    $("[id*=spanSection10Total]").html(0);
                    tt = 0;
                    //tt = parseFloat(pt) + parseFloat(et);
                    tt = parseFloat($("[id*=txtSded]").val());
                    $("[id*=spanDeduction]").html(tt);


                    RebateCalculation();
                }
                else {
                    Calculate_Computation();
                }

            });

            ///////////// On Keypress event
            $(".ManualEntry").on('keydown', function (evt) {
                var GrossSalaryTotal = 0;
                evt = (evt) ? evt : window.event;
                var sN = '';
                sN = evt.currentTarget.name;
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                if (evt.keyCode == 13) {
                    closeButtonClicked = false;


                    if ($(this).data("info") == 'Salary') {
                        kyprss = '1';
                        var currentRowno = $(this).closest('tr').index();
                        var currentValue = $(this).val();


                        $("input[name=" + sN + "]").each(function () {
                            var i = 0;
                            var rIndex = 0;
                            var IndR = 0;
                            IndR = $(this).closest('tr').index();
                            if (IndR > currentRowno) {
                                var row = $(this).closest("tr");
                                rIndex = row.closest('tr').index();

                                $(this).val(currentValue);

                                if (rIndex == IndR + 1) {

                                    closeButtonClicked = false;
                                    return false;
                                }
                            }
                        });

                        for (var i = 1; i <= 12; i++) {
                            var rTot = 0;
                            var b = $("[id*=txtBasic" + i + "]").val();
                            var d = $("[id*=txtDA" + i + "]").val();
                            var h = $("[id*=txtHRA" + i + "]").val();
                            var o = $("[id*=txtOthers" + i + "]").val();
                            if (b == '' || b == undefined) {
                                b = 0;
                            }
                            if (d == '' || d == undefined) {
                                d = 0;
                            }
                            if (h == '' || h == undefined) {
                                h = 0;
                            }
                            if (o == '' || o == undefined) {
                                o = 0;
                            }
                            rtot = parseFloat(b) + parseFloat(d) + parseFloat(h) + parseFloat(o);
                            $("[id*=txtMonth" + i + "]").val(rtot);
                            GrossSalaryTotal = GrossSalaryTotal + parseFloat(rtot);
                        };

                        $("[id*=lblGrossTotal]").html(GrossSalaryTotal);
                        $("[id*=spanTotalEarn]").html(GrossSalaryTotal);
                        var TE = 0;
                        var pf = $("[id*=txtGrossProfits_C]").val();
                        if (pf == '' || pf == undefined) {
                            pf = 0;
                        }
                        var pk = $("[id*=spanTotalPerk]").html();
                        if (pk == undefined || pk == '') {
                            pk = 0;
                        }

                        TE = GrossSalaryTotal + parseFloat(pk) + parseFloat(pf);
                        $("[id*=spanGrossEarn1]").html(TE);
                    }
                    if ($(this).data("info") == 'Perquisites_Value' || $(this).data("info") == 'EmployeePaid_Amt' || $(this).data("info") == 'Taxable_Amt') {
                        kyprss = '1';
                        var currentRowno = $(this).closest('tr').index();
                        var currentValue = $(this).val();
                        //$("input[name=hdnPerquisites_ID]").each(function () {
                        $('#tblPerquisites > tbody  > tr').each(function () {
                            row = $(this).closest("tr");
                            var sr = row.find('td:eq(0)').text();
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

                                if (EmployeePaid_Amt == '') {
                                    EmployeePaid_Amt = 0;
                                }
                                if (Perquisites_Value == '') {
                                    Perquisites_Value = 0;
                                }
                                if (Taxable_Amt == '') {
                                    Taxable_Amt = 0;
                                }

                                pq = pq + sr + '~' + d + '~' + EmployeePaid_Amt + '~' + Perquisites_Value + '~' + Taxable_Amt + '^';

                            }
                        });
                        $("[id*=spanPerquisites_Value]").text(Perquisites_Value);
                        $("[id*=spanEmployeePaid_Amt]").text(EmployeePaid_Amt);
                        $("[id*=spanTaxable_Amt]").text(Taxable_Amt);
                        $("[id*=spanTotalPerk]").text(Taxable_Amt);


                        var TE = 0;
                        var pf = $("[id*=txtGrossProfits_C]").val();
                        if (pf == '' || pf == undefined) {
                            pf = 0;
                        }
                        var pk = $("[id*=spanTotalPerk]").html();
                        if (pk == undefined || pk == '') {
                            pk = 0;
                        }
                        TE = parseFloat($("[id*=lblGrossTotal]").html()) + parseFloat(pk) + parseFloat(pf);
                        $("[id*=spanGrossEarn1]").html(TE);
                    }
                    
                    if ($(this).data("info") == 'HRR') {

                        kyprss = '1';
                        var currentRowno = $(this).closest('tr').index();
                        var currentValue = $(this).val();


                        $("input[name=" + sN + "]").each(function () {
                            var i = 0;
                            var rIndex = 0;
                            var IndR = 0;
                            IndR = $(this).closest('tr').index();
                            if (IndR > currentRowno) {
                                var row = $(this).closest("tr");
                                rIndex = row.closest('tr').index();

                                $(this).val(currentValue);

                                if (rIndex == IndR + 1) {

                                    closeButtonClicked = false;
                                    return false;
                                }
                            }
                        });

                        for (var i = 1; i <= 12; i++) {

                            var b = $("[id*=txtHRR" + i + "]").val();

                            if (b == '' || b == undefined) {
                                b = 0;
                            }

                            $("[id*=hdnHrr" + i + "]").val(b);
                        };
                    }

                    closeButtonClicked = false;

                    var hdr = $('#chkUSBAC').prop("checked");
                    if (hdr == true) {
                        Calculation_BAC115();
                    }
                    else {
                        Calculate_Computation();
                    }


                }
                else if (charCode > 31 && (charCode < 46 || charCode > 57)) {
                    return false;
                }


            });

            $(".ManualEntry").on('blur', function () {
                var GrossSalaryTotal = 0;
                if (kyprss == "") {
                    if ($(this).data("info") == 'Salary') {

                        var currentRowno = $(this).closest('tr').index();
                        var currentValue = $(this).val();
                        var ridx = 3;
                        $('#tblMonthlySalary > tbody  > tr').each(function () {
                            var row = $(this).closest("tr");
                            var rIndex = $(this).closest("tr")[0].sectionRowIndex;
                            var IndR = 0;
                            IndR = $(this).closest('tr').index();
                            ridx = ridx + 1;
                            //if (IndR == currentRowno) {

                            //}
                            //if (rIndex > 9) {
                            //    ridx = ridx + 1;
                            //}
                            var Mth = $("#hdnMthSal" + ridx, row).val();
                            var B = $("#txtBasic" + ridx, row).val();
                            var D = $("#txtDA" + ridx, row).val();
                            var H = $("#txtHRA" + ridx, row).val();
                            var O = $("#txtOthers" + ridx, row).val();
                            var T = $("#txtMonth" + ridx, row).val();

                            //////////////////// ************************* Pass HRR values
                            if (Mth > 0) {
                                T = parseFloat(B) + parseFloat(D) + parseFloat(H) + parseFloat(O)
                                $("#txtMonth" + ridx, row).val(T);
                                GrossSalaryTotal = GrossSalaryTotal + parseFloat(T);
                            }
                            //return false;
                            //}
                            if (rIndex == 8) {///// reset for Jan month
                                ridx = 0;
                            }

                        });
                        $("[id*=lblGrossTotal]").html(GrossSalaryTotal);
                        $("[id*=spanTotalEarn]").html(GrossSalaryTotal);
                        var TE = 0;
                        var pf = $("[id*=txtGrossProfits_C]").val();
                        if (pf == '' || pf == undefined) {
                            pf = 0;
                        }
                        var pk = $("[id*=spanTotalPerk]").html();
                        if (pk == undefined || pk == '') {
                            pk = 0;
                        }
                        TE = GrossSalaryTotal + parseFloat(pk) + parseFloat(pf);
                        $("[id*=spanGrossEarn1]").html(TE);

                    }
                    if ($(this).data("info") == 'Perquisites_Value' || $(this).data("info") == 'EmployeePaid_Amt' || $(this).data("info") == 'Taxable_Amt') {

                        var currentRowno = $(this).closest('tr').index();
                        var currentValue = $(this).val();
                        //$("input[name=hdnPerquisites_ID]").each(function () {
                        $('#tblPerquisites > tbody  > tr').each(function () {
                            row = $(this).closest("tr");
                            var sr = row.find('td:eq(0)').text();
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

                                if (EmployeePaid_Amt == '') {
                                    EmployeePaid_Amt = 0;
                                }
                                if (Perquisites_Value == '') {
                                    Perquisites_Value = 0;
                                }
                                if (Taxable_Amt == '') {
                                    Taxable_Amt = 0;
                                }

                                pq = pq + sr + '~' + d + '~' + EmployeePaid_Amt + '~' + Perquisites_Value + '~' + Taxable_Amt + '^';

                            }
                        });
                        $("[id*=spanPerquisites_Value]").text(Perquisites_Value);
                        $("[id*=spanEmployeePaid_Amt]").text(EmployeePaid_Amt);
                        $("[id*=spanTaxable_Amt]").text(Taxable_Amt);
                        $("[id*=spanTotalPerk]").text(Taxable_Amt);


                        var TE = 0;
                        var pf = $("[id*=txtGrossProfits_C]").val();
                        if (pf == '' || pf == undefined) {
                            pf = 0;
                        }
                        var pk = $("[id*=spanTotalPerk]").html();
                        if (pk == undefined || pk == '') {
                            pk = 0;
                        }

                        TE = parseFloat($("[id*=lblGrossTotal]").html()) + parseFloat(pk) + parseFloat(pf);
                        $("[id*=spanGrossEarn1]").html(TE);






                    }


                    var hdr = $('#chkUSBAC').prop("checked");
                    if (hdr == true) {
                        Calculation_BAC115();
                    }
                    else {
                        Calculate_Computation();
                    }
                }
                kyprss = '';
            });


            $(".Rebate").on('blur', function () {
                RebateCalculation();
            });

            $("[id*=txtGrossProfits_C]").on('blur', function () {
                var TE = 0;
                var pf = $("[id*=txtGrossProfits_C]").val();
                if (pf == '' || pf == undefined) {
                    pf = 0;
                }
                TE = parseFloat($("[id*=lblGrossTotal]").html()) + parseFloat($("[id*=spanTotalPerk]").html()) + parseFloat(pf);
                $("[id*=spanGrossEarn1]").html(TE);

                Calculate_Computation();
            });

            $("[id*=txtPreviousSal]").on('blur', function () {
                var hdr = $('#chkUSBAC').prop("checked");
                if (hdr == true) {
                    RebateCalculation();
                }
            });


            ////////////////////////***************** Section 10
            $("[id*=txtTravel]").on('blur', function () {
                var hdr = $('#chkUSBAC').prop("checked");
                if (hdr == true) {
                    $("[id*=spanSection10Total]").html(0);
                    $("[id*=txtTravel]").val(0);
                    RebateCalculation();
                }
                else {
                    CalculateSection10();

                }
            });
            $("[id*=txtGratuity]").on('blur', function () {
                var hdr = $('#chkUSBAC').prop("checked");
                if (hdr == true) {
                    $("[id*=spanSection10Total]").html(0);
                    $("[id*=txtGratuity]").val(0);
                    RebateCalculation();
                }
                else {
                    CalculateSection10();

                }
            });
            $("[id*=txtPension]").on('blur', function () {
                var hdr = $('#chkUSBAC').prop("checked");
                if (hdr == true) {
                    $("[id*=spanSection10Total]").html(0);
                    $("[id*=txtPension]").val(0);
                    RebateCalculation();
                }
                else {
                    CalculateSection10();

                }
            });
            $("[id*=txtLeave]").on('blur', function () {
                var hdr = $('#chkUSBAC').prop("checked");
                if (hdr == true) {
                    $("[id*=spanSection10Total]").html(0);
                    $("[id*=txtLeave]").val(0);
                    RebateCalculation();
                }
                else {
                    CalculateSection10();

                }
            });
            $("[id*=txtSOthers]").on('blur', function () {
                var hdr = $('#chkUSBAC').prop("checked");
                if (hdr == true) {
                    $("[id*=spanSection10Total]").html(0);
                    $("[id*=txtSOthers]").val(0);
                    RebateCalculation();
                }
                else {
                    CalculateSection10();

                }
            });
            ///////////////////////////// ********************** End of Section


            $("[id*=txtIntHome]").on('blur', function () {
                var h = $("[id*=txtIntHome]").val();
                $("[id*=spanIntHome]").html(h);

                    RebateCalculation();
               
            });

            $("[id*=txtOthInc]").on('blur', function () {
                var o = $("[id*=txtOthInc]").val();
                $("[id*=spanOthInc]").html(o);

                    RebateCalculation();
            });

            $("[id*=txtSded]").on('blur', function () {
                var o = $("[id*=txtSded]").val();
                CalculateDeduction();
            });

            $("[id*=txtPTax]").on('blur', function () {
                var o = $("[id*=txtPTax]").val();
                CalculateDeduction();
            });

            $("[id*=txtEntertainment]").on('blur', function () {
                var o = $("[id*=txtEntertainment]").val();
                CalculateDeduction();
            });

      
            $("[id*=txtHRAEXMPT]").on('blur', function () {
                var o = $("[id*=txtHRAEXMPT]").val();
                CalculateSection10();
            });

            $("[id*=txtRebate89]").on('blur', function () {

                var hdr = $('#chkUSBAC').prop("checked");
                if (hdr == true) {

                    Calculation_BAC115();
                }
                else {
                    Calculate_Computation();
                }
            });


            $("[id*=drpEmployeeName]").on('change', function () {
                var e = $("[id*=drpEmployeeName]").val();
                $("[id*=hdnEmpID]").val(e);
                GetEmployeeDetails(e);
            });
            $("[id*=btnBack]").on('click', function () {
                window.location.href = "TdsComputationListing.aspx";

            });
            $("[id*=btnCalculate]").on('click', function () {
                var sal = '';
                var ridx = 3;
                var TotHrr = 0;
                var TotBas = 0;
                var TotDa = 0;
                var TotHra = 0;
                var TotHrr = 0;
                var TotExp = 0;
                 
                var mtr = $("[id*=chkMetro]").prop("checked");
                $('#tblHRRSalary > tbody  > tr').each(function () {
                    var row = $(this).closest("tr");
                    var rIndex = $(this).closest("tr")[0].sectionRowIndex;

                    //if (rIndex < 10) {
                    ridx = ridx + 1;
                    //}
                    //if (rIndex > 9) {
                    //    ridx = ridx + 1;
                    //}
                    var Mth = $("#hdnHrrMthSal" + ridx, row).val();
                    var B = $("#spnBasic" + ridx, row).html();
                    var D = $("#spnDA" + ridx, row).html();
                    var H = $("#spnHRA" + ridx, row).html();


                    var hr = $("#txtHRR" + ridx, row).val();
                    var BasicAmt = 0, HraAmt = 0, HrrAmt = 0, HRA1 = 0, HRA2 = 0, HRA3 = 0;
                    var FinalHRAamount = 0;
                    //////////////////// ************************* Pass HRR values
                    if (Mth > 0) {
                        BasicAmt = parseFloat(B) + parseFloat(D);
                        /// Condition 1              
                        var HRA1 = H;


                        /// condition 2 
                        var Amt = 0;
                        ////Onetenth of Basic              
                        Amt = (BasicAmt * 10) / 100;
                        if (H > 0 && hr > Amt) {
                            HRA2 = parseFloat(hr) - parseFloat(Amt);
                        }
                        else {
                            HRA2 = parseFloat(Amt) - parseFloat(hr);
                        }

                        //-- Condition 3               
                        if (mtr == true) {  ///////////////////// Checking for Metro cities true or false
                            HRA3 = BasicAmt / 2;
                            //$("[id*=lblMetroC]").html(Metro);
                            //$("[id*=lblper]").html('Half of Basic');
                            //$("[id*=lblperVal]").html(HRA3);
                        }
                        else {
                            HRA3 = (BasicAmt * 40) / 100;
                            //$("[id*=lblMetroC]").html('Others');
                            //$("[id*=lblper]").html('40% of Basic');
                            //$("[id*=lblperVal]").html(HRA3);

                        }

                        if (HRA1 <= HRA2 && HRA1 <= HRA3) {
                            FinalHRAamount = HRA1;
                        }
                        else if (HRA2 <= HRA3) {
                            FinalHRAamount = HRA2;
                        }
                        else {
                            FinalHRAamount = HRA3;
                        }
                        $("#txtExempt" + ridx, row).val(FinalHRAamount);
                        TotExp = parseFloat(TotExp) + parseFloat(FinalHRAamount);
                        TotHra = parseFloat(TotHra) + parseFloat(H);
                        TotDa = parseFloat(TotDa) + parseFloat(D);
                        TotBas = parseFloat(TotBas) + parseFloat(B);
                        TotHrr = parseFloat(TotHrr) + parseFloat(hr);
                    }
                    if (rIndex == 8) {///// reset for Jan month
                        ridx = 0;
                    }
                });
                $("[id*=lblRightExmptedHRATotal]").html(TotExp);
                $("[id*=txtHRAEXMPT]").val(TotExp);
                $("[id*=lblRightBasicTotal]").html(TotBas);
                $("[id*=lblRightDATotal]").html(TotDa);
                $("[id*=lblRightHRATotal]").html(TotHra);
                $("[id*=lblRightHRRTotal]").html(TotHrr);



                CalculateSection10();
                //var hdr = $('#chkUSBAC').prop("checked");
                //if (hdr == true) {

                //    Calculation_BAC115();
                //}
                //else {
                //    Calculate_Computation();
                //}
            });

            $(".cssDropDownList").change(function () {
                cssDropDownListToggleClass();
            });

            $("[id*=btnReset]").on('click', function () {

               //var  ridx = 3;
               // $('#tblHRRSalary > tbody  > tr').each(function () {
               //     var row = $(this).closest("tr");
               //     var rIndex = $(this).closest("tr")[0].sectionRowIndex;
               //     ridx = ridx + 1;

               //     $("#spnBasic" + ridx, row).html(0);
               //     $("#spnDA" + ridx, row).html(0);
               //     $("#spnHRA" + ridx, row).html(0);
               //     $("#txtHRR" + ridx, row).val(0);

               //     if (rIndex == 8) {///// reset for Jan month
               //         ridx = 0;
               //     }
               // });
                $("[id*=lblRightBasicTotal]").val(0);
                $("[id*=lblRightDATotal]").val(0);
                $("[id*=lblRightHRATotal]").val(0);
                $("[id*=lblRightHRRTotal]").val(0);
                $("[id*=lblRightExmptedHRATotal]").val(0);
            });
        });

        function cssDropDownListToggleClass() {
            $(".cssDropDownList").each(function () {
                var clName = $(this).data('hideclass');
                if (clName != "" && clName != undefined && clName != null) {
                    if ($(this).val() == 'yes') {
                        $("." + clName).each(function () {
                            $(this).show();
                        });
                    }
                    else {
                        $("." + clName).each(function () {
                            $(this).hide();
                        });
                    }
                }
            });
        }

        function resetAll() {
            $("[id*=spanGrossEarn1]").html(0); ///point 1
            $("[id*=spanTotalEarn]").html(0); ///point 1
            $("[id*=spanTotalPerk]").html(0); ///point 1
            $("[id*=txtGrossProfits_C]").html(0); ///point 1

            $("[id*=spanSection10Total]").html(0); ///point 2
            $("[id*=txtTravel]").val(0);
            $("[id*=txtGratuity]").val(0);
            $("[id*=txtPension]").val(0);
            $("[id*=txtLeave]").val(0);
            $("[id*=txtSOthers]").val(0);
            $("[id*=txtHRAEXMPT]").val(0);
            $("#txtRebate80C").val(0);
            $("#txtRebate80C_Ded").val(0);
            $("#txtRebate80CCC").val(0);
            $("#txtRebate80CCC_Ded").val(0);

            $("#txtRebate80CCD").val(0);
            $("#txtRebate80CCD_Ded").val(0);
            $("#txtRebate80CCD1B").val(0);
            $("#txtRebate80CCD1B_Ded").val(0);

            $("#txtRebate80CCD2").val(0);
            $("#txtRebate80CCD2_Ded").val(0);
            $("#txtRebate80D").val(0);
            $("#txtRebate80D_Ded").val(0);
            $("#txtRebate80G").val(0);
            $("#txtRebate80G_Ded").val(0);
            $("#txtRebate80E").val(0);
            $("#txtRebate80E_Ded").val(0);
            $("#txtRebate80EE").val(0);
            $("#txtRebate80EE_Ded").val(0);
            $("#txtRebate80TTA").val(0);
            $("#txtRebate80TTA_Ded").val(0);
            $("#txtRebateOthers").val(0)
            $("#txtRebateOthers_Ded").val(0)



            $("[id*=spanGross3]").html(0); ///point 3
            $("[id*=txtEntertainment]").val(0);
            $("[id*=txtPTax]").val(0);
            $("[id*=txtSded]").val(0);
            $("[id*=spanDeduction]").html(0);
            $("[id*=spanGross5]").html(0); ///point 5
            $("[id*=txtIntHome]").val(0);
            $("[id*=txtOthInc]").val(0);
            $("[id*=spanGross8]").html(0); ///point 8
            $("[id*=spanRebateTotal]").html(0);

            $("[id*=spanNetIncTax]").html(0); ///point 12
            $("[id*=spanOnTaxTotalIncome]").html(0); ///point 13
            $("[id*=spanRebate87A]").html(0); ///point 14
            $("[id*=spanRebateTAX]").html(0); ///point 15
            $("[id*=spanSurcharge]").html(0); ///point 15
            $("[id*=spanCess]").html(0); ///point 16
            $("[id*=txtRebate89]").val(0);
            $("[id*=spanTax]").html(0); ///point 17
            $("[id*=spanTDS]").html(0);
            $("[id*=txtPreTDS]").val(0);
            $("[id*=spanFinalTax]").html(0); ///point 21
            var ridx = 3;
            $('#tblMonthlySalary > tbody  > tr').each(function () {
                var row = $(this).closest("tr");
                var rIndex = $(this).closest("tr")[0].sectionRowIndex;
                ridx = ridx + 1;

                $("#txtBasic" + ridx, row).val(0);
                $("#txtDA" + ridx, row).val(0);
                $("#txtHRA" + ridx, row).val(0);
                $("#txtOthers" + ridx, row).val(0);
                $("#txtMonth" + ridx, row).val(0);
                $("#hdnHrr" + ridx, row).val(0);

                if (rIndex == 8) {///// reset for Jan month
                    ridx = 0;
                }
            });

            /////// Section 10

            /////////point 1 perquisites
            //$("#tblPerquisites tbody tr").each(function () {

            $('#tblPerquisites > tbody  > tr').each(function () {
                row = $(this).closest("tr");
                var sr = row.find('td:eq(0)').text();
                var d = row.find('td:eq(1)').html();
                if ($(this).find("input[type=hidden]").val() != undefined) {

                    $(this).find("input[type=text]").each(function () {
                        if ($(this).data('name') == "EmployeePaid_Amt")
                            $(this).val(0);
                        if ($(this).data('name') == "Taxable_Amt")
                            $(this).val(0);
                        if ($(this).data('name') == "Perquisites_Value")
                            $(this).val(0);
                    });
                }
            });

            ///// HRR TABLE
            ridx = 3;
            $('#tblHRRSalary > tbody  > tr').each(function () {
                var row = $(this).closest("tr");
                var rIndex = $(this).closest("tr")[0].sectionRowIndex;
                ridx = ridx + 1;

                $("#spnBasic" + ridx, row).html(0);
                $("#spnDA" + ridx, row).html(0);
                $("#spnHRA" + ridx, row).html(0);
                $("#txtHRR" + ridx, row).val(0);

                if (rIndex == 8) {///// reset for Jan month
                    ridx = 0;
                }
            });
            $("[id*=lblRightBasicTotal]").val(0);
            $("[id*=lblRightDATotal]").val(0);
            $("[id*=lblRightHRATotal]").val(0);
            $("[id*=lblRightHRRTotal]").val(0);
            $("[id*=lblRightExmptedHRATotal]").val(0);


        }

        function Fill_defaults() {

            Blockloadershow();
            var cp = 0;

            $.ajax({
                url: "../../TDS/BTStrp/Handler/TDSComputationV2.asmx/getDefaultValues",
                data: '{ids:' + cp + '}',
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (msg) {
                    var slb = jQuery.parseJSON(msg.d);
                    /*var myIT = myList[0].IncomeTaxMaster;*/
                    var BAC = slb[0].IBacTax;
                    var myRbLts = slb[0].Rebate_Limits;
                    var mySur = slb[0].SurchargeSlab;
                    var myPer = slb[0].LtblEmployeeTDSReletatedOtherDetails;
                    SurSlab = mySur;
                    /////////// Reset Slab InComeTax 

                    for (var i = 0; i < 6; i++) {
                        var slabperName = 'lblSlabPer' + (i + 1);
                        var slabName = 'lblSlab' + (i + 1);
                        $('[id*=' + slabperName + ']').html(0);
                        $('[id*=' + slabName + ']').html(0);
                    }

                    for (var i = 0; i < 6; i++) {
                        var SHlblPer = 'SH' + 'lblPer' + (i + 1);
                        var SHlblBACSlab = 'SH' + 'lblBACSlab' + (i + 1);
                        $('[id*=' + SHlblPer + ']').html(0);
                        $('[id*=' + SHlblBACSlab + ']').html(0);
                    }
                    //////////////// End of Reset


                    ////////////// Insert I115 BAC income tax Slab
                    if (BAC.length > 0) {

                        $.each(BAC, function (j, va) {
                            var SHlblPer = 'SH' + 'lblPer' + (j + 1);
                            var SHlblBACSlab = 'SH' + 'lblBACSlab' + (j + 1);
                            $('[id*=' + SHlblPer + ']').html(va.Slab);
                            $('[id*=' + SHlblBACSlab + ']').html(va.Tax_Amount);
                        });
                    }
                    /////////////// Rebate Limits
                    if (myRbLts.length > 0) {
                        for (var i = 0; i < myRbLts.length; i++) {

                            if (myRbLts[i].Rebate_Name == 'Rebate80C') {
                                $("[id*=hdnR80C_lmt]").val(myRbLts[i].Rebate_Limit);
                            }
                            if (myRbLts[i].Rebate_Name == 'Rebate80CCC') {
                                $("[id*=hdnR80CCC_lmt]").val(myRbLts[i].Rebate_Limit);
                            }
                            /*if ($(this).find("Rebate_Name").text() == 4) {*/
                            $("[id*=hdnR80CCD_lmt]").val(9999999);
                            //}
                            if (myRbLts[i].Rebate_Name == 'Rebate80CCD21b') {
                                $("[id*=hdnR80CCD1B_lmt]").val(myRbLts[i].Rebate_Limit);
                            }
                            if (myRbLts[i].Rebate_Name == 'Rebate80CCD2') {
                                $("[id*=hdnR80CCD2_lmt]").val(myRbLts[i].Rebate_Limit);
                            }
                            //if ($(this).find("Rebate_Name").text() == 4) {
                            $("[id*=hdnR80Qly_lmt]").val(150000);
                            //}
                            if (myRbLts[i].Rebate_Name == 'Rebate80D') {
                                $("[id*=hdnR80D_lmt]").val(myRbLts[i].Rebate_Limit);
                            }
                            if (myRbLts[i].Rebate_Name == 'Rebate80G') {
                                $("[id*=hdnR80G_lmt]").val(myRbLts[i].Rebate_Limit);
                            }
                            if (myRbLts[i].Rebate_Name == 'Rebate80E') {
                                $("[id*=hdnR80E_lmt]").val(myRbLts[i].Rebate_Limit);
                            }
                            if (myRbLts[i].Rebate_Name == 'Rebate80EE') {
                                $("[id*=hdnR80EE_lmt]").val(myRbLts[i].Rebate_Limit);
                            }
                            if (myRbLts[i].Rebate_Name == 'Rebate80TTA') {
                                $("[id*=hdnR80T_lmt]").val(myRbLts[i].Rebate_Limit);
                            }
                            //if ($(this).find("Rebate_Name").text() == 4) {
                            $("[id*=hdnR80OTh_lmt]").val(9999999);
                            //}
                            if (myRbLts[i].Rebate_Name == 'Rebate87A') {
                                $("[id*=hdnlimitfor87A]").val(myRbLts[i].Rebate_Limit);
                            }

                        }
                    }

                    ///////////////// Other Percentage


                    if (myPer.length > 0) {

                        $("[id*=hdnCessPer]").val(myPer[0].Cessper);
                        $("[id*=hdnHcessper]").val(myPer[0].HCessper);
                        $("[id*=hdnHealthPer]").val(myPer[0].HealthPer);
                    }

                    Blockloaderhide();
                },
                error: function (response) {
                    alert(response.responseText);
                    Blockloaderhide();
                },
                failure: function (response) {
                    alert(response.responseText);
                    Blockloaderhide();
                }
            });


        }

        function CalculateSection10() {
            var t = $("[id*=txtTravel]").val();
            var g = $("[id*=txtGratuity]").val();
            var p = $("[id*=txtPension]").val();
            var l = $("[id*=txtLeave]").val();
            var o = $("[id*=txtSOthers]").val();
            var h = $("[id*=txtHRAEXMPT]").val();
            var tt = parseFloat(t) + parseFloat(g) + parseFloat(p) + parseFloat(l) + parseFloat(o) + parseFloat(h);
            $("[id*=spanSection10Total]").html(tt);
            var hdr = $('#chkUSBAC').prop("checked");
            if (hdr == true) {
                Calculation_BAC115();
            }
            else {
                Calculate_Computation();
            }
        }

        function CalculateDeduction() {
            var t = $("[id*=txtEntertainment]").val();
            var g = $("[id*=txtPTax]").val();
            var p = $("[id*=txtSded]").val();
            
            var tt = parseFloat(t) + parseFloat(g) + parseFloat(p);
            $("[id*=spanDeduction]").html(tt);
             
            var hdr = $('#chkUSBAC').prop("checked");
            if (hdr == true) {
                Calculation_BAC115();
            }
            else {
                Calculate_Computation();
            }
        }

        function GetEmployeeDetails(empId) {
            Blockloadershow();
            resetAll();
            var tobj = {
                Employee_ID: empId

            };
            tobj = JSON.stringify({ 'tobj': tobj });

            $.ajax({
                url: "../../TDS/BTStrp/Handler/TDSComputationV2.asmx/getEmployeeComputationV2",
                data: tobj,
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (msg) {
                    var xmlDoc = $.parseXML(msg.d);
                    var xml = $(xmlDoc);
                    var List = xml.find("Table")
                    var list_Rebate = xml.find("Table1")
                    //var list_Salary = xml.find("Table2")
                    var list_SalBrkup = xml.find("Table2")
                    var list_Sec10 = xml.find("Table3")
                    var list_Perk = xml.find("Table4")
                    var list_RentBrkup = xml.find("Table5")
                    var list_ITax = xml.find("Table6")
                    var list_Chln = xml.find("Table7")


                    if (List.length > 0) {
                        $.each(List, function () {
                            setValuesoflabelTextSpan('txtEmployee', $(this).find("FirstName").text());
                            setValuesoflabelTextSpan('txtPanNo', $(this).find("PAN_NO").text());
                            setValuesoflabelTextSpan('spanTotalEarn', $(this).find("Total_Earnings").text(), null, null);
                            setValuesoflabelTextSpan('spanTotalPerk', $(this).find("GrossPerks_B").text(), null, null);
                            setValuesoflabelTextSpan('spanGrossEarn1', $(this).find("GrossEarn1").text(), null, null);
                            setValuesoflabelTextSpan('txtGrossProfits_C', $(this).find("GrossProfits_C").text());
                            setValuesoflabelTextSpan('lblGrossTotal', $(this).find("Total_Earnings").text(), null, null);
                            setValuesoflabelTextSpan('txtSalaryUnderSection', $(this).find("GrossProfits_C").text(), null, null);

                            setValuesoflabelTextSpan('spanSection10Total', $(this).find("Section_10").text(), null, null);

                            setValuesoflabelTextSpan('txtPreviousSal', $(this).find("PreSal").text(), null, null);
                            setValuesoflabelTextSpan('spanGross3', $(this).find("GrossEarn3").text(), null, null);
                            setValuesoflabelTextSpan('spanDeduction', $(this).find("TotalDeduction").text(), null, null);
                            setValuesoflabelTextSpan('txtEntertainment', $(this).find("Entertainment").text(), null, null);
                            setValuesoflabelTextSpan('txtPTax', $(this).find("PTax").text(), null, null);
                            setValuesoflabelTextSpan('txtSded', $(this).find("StandardDeductions").text(), null, null);
                            setValuesoflabelTextSpan('spanGross5', $(this).find("GrossEarn5").text(), null, null);
                            setValuesoflabelTextSpan('spanIntHome', $(this).find("IntHouseLoan").text(), null, null);
                            setValuesoflabelTextSpan('txtIntHome', $(this).find("IntHouseLoan").text(), null, null);
                            setValuesoflabelTextSpan('spanOthInc', $(this).find("OtherIncome").text(), null, null);
                            setValuesoflabelTextSpan('txtOthInc', $(this).find("OtherIncome").text(), null, null);
                            setValuesoflabelTextSpan('spanGross8', $(this).find("GrossEarn8").text(), null, null);
                            setValuesoflabelTextSpan('spanRebateTotal', $(this).find("TotalRebate").text(), null, null);
                            setValuesoflabelTextSpan('spanNetIncTax', $(this).find("Grossnet").text(), null, null);
                            setValuesoflabelTextSpan('spanOnTaxTotalIncome', $(this).find("Itax1").text(), null, null);
                            setValuesoflabelTextSpan('spanRebate87A', $(this).find("Rebatetds").text(), null, null);
                            setValuesoflabelTextSpan('spanRebateTAX', $(this).find("Itax2").text(), null, null);
                            setValuesoflabelTextSpan('spanSurcharge', $(this).find("Surcharge").text(), null, null);
                            setValuesoflabelTextSpan('spanCess', $(this).find("EducationCess").text(), null, null);

                            ///////////////////////////// *************************** Rebate 89 
                            setValuesoflabelTextSpan('txtRebate89', $(this).find("Rebate89").text(), null, null);
                            setValuesoflabelTextSpan('spanTax', $(this).find("Itax3").text(), null, null);
                            setValuesoflabelTextSpan('spanTDS', $(this).find("Challan_Tax").text(), null, null);
                            setValuesoflabelTextSpan('txtPreTDS', $(this).find("PreTds").text(), null, null);
                            setValuesoflabelTextSpan('spanFinalTax', $(this).find("FinalTax").text(), null, null);
                            var gen = $(this).find("Gender").text();
                            var cT = '';
                            var Ctzn = $(this).find("Senior_CTZN_Type").text();
                            if (Ctzn == 'Super Senior Citizen' || Ctzn == 'Senior Citizen')
                            {
                                cT = Ctzn;
                            }
                            else  {
                                cT = gen;
                            }

                            $("[id*=ddlCategory]").val(cT);
                            $("[id*=ddlCategory]").trigger('change');

                            ////////////////////////////////// Landlord

                            //setValuesoflabelTextSpan('Rent_Payment', RentEmp.Rent_Payment.toString(), null, null);
                            var tval = $(this).find("Rent_Payment").text();
                            if (tval == 'true') {
                                tval = 'yes';
                            }
                            else {
                                tval = 'no';
                            }
                            $("[id*=Rent_Payment]").val(tval);
                            $("[id*=Rent_Payment]").trigger('change');
                            tval = $(this).find("Interest_lender").text();
                            if (tval == 'true') {
                                tval = 'yes';
                            }
                            else {
                                tval = 'no';
                            }
                            $("[id*=Interest_lender]").val(tval);
                            $("[id*=Interest_lender]").trigger('change');
                            tval = $(this).find("Contributions_superannuation_fund").text();
                            if (tval == 'true') {
                                tval = 'yes';
                            }
                            else {
                                tval = 'no';
                            }
                            $("[id*=Contributions_superannuation_fund]").val(tval);
                            $("[id*=Contributions_superannuation_fund]").trigger('change');

                            //    Count_PAN_landlord
                            //    PAN_landlord1
                            setValuesoflabelTextSpan('PAN_landlord1', $(this).find("PAN_landlord1").text(), null, null);
                            //    Name_landlord1
                            setValuesoflabelTextSpan('Name_landlord1', $(this).find("Name_landlord1").text(), null, null);
                            //    PAN_landlord2
                            setValuesoflabelTextSpan('PAN_landlord2', $(this).find("PAN_landlord2").text(), null, null);
                            //    Name_landlord2
                            setValuesoflabelTextSpan('Name_landlord2', $(this).find("Name_landlord2").text(), null, null);
                            //    PAN_landlord3
                            setValuesoflabelTextSpan('PAN_landlord3', $(this).find("PAN_landlord3").text(), null, null);
                            //    Name_landlord3
                            setValuesoflabelTextSpan('Name_landlord3', $(this).find("Name_landlord3").text(), null, null);
                            //    PAN_landlord4
                            setValuesoflabelTextSpan('PAN_landlord4', $(this).find("PAN_landlord4").text(), null, null);
                            //    Name_landlord4
                            setValuesoflabelTextSpan('Name_landlord4', $(this).find("Name_landlord4").text(), null, null);
                            //    Interest_lender bool

                            //setValuesoflabelTextSpan('Interest_lender', $(this).find("Interest_lender").text(), null, null);

                            //    Count_PAN_lender
                            //    PAN_lender1
                            setValuesoflabelTextSpan('PAN_lender1', $(this).find("PAN_lender1").text(), null, null);
                            //    Name_lender1
                            setValuesoflabelTextSpan('Name_lender1', $(this).find("Name_lender1").text(), null, null);
                            //    PAN_lender2
                            setValuesoflabelTextSpan('PAN_lender2', $(this).find("PAN_lender2").text(), null, null);
                            //    Name_lender2
                            setValuesoflabelTextSpan('Name_lender2', $(this).find("Name_lender2").text(), null, null);
                            //    PAN_lender3
                            setValuesoflabelTextSpan('PAN_lender3', $(this).find("PAN_lender3").text(), null, null);
                            //    Name_lender3
                            setValuesoflabelTextSpan('Name_lender3', $(this).find("Name_lender3").text(), null, null);
                            //    PAN_lender4
                            setValuesoflabelTextSpan('PAN_lender4', $(this).find("PAN_lender4").text(), null, null);
                            //    Name_lender4
                            setValuesoflabelTextSpan('Name_lender4', $(this).find("Name_lender4").text(), null, null);
                            //    Contributions_superannuation_fund bit

                            //setValuesoflabelTextSpan('Contributions_superannuation_fund', $(this).find("Contributions_superannuation_fund").text(), null, null);

                            //    Name_superannuation_fund
                            setValuesoflabelTextSpan('Name_superannuation_fund', $(this).find("Name_superannuation_fund").text(), null, null);
                            //    Frm_DT_superannuation_fund
                            setValuesoflabelTextSpan('Frm_DT_superannuation_fund', $(this).find("Frm_DT_superannuation_fund").text(), null, null);
                            //    TO_DT_superannuation_fund
                            setValuesoflabelTextSpan('TO_DT_superannuation_fund', $(this).find("TO_DT_superannuation_fund").text(), null, null);
                            //    principal_interest_superannuation_fund
                            setValuesoflabelTextSpan('principal_interest_superannuation_fund', $(this).find("principal_interest_superannuation_fund").text(), null, null);
                            //    Rate_deduction_tax_3yrs
                            setValuesoflabelTextSpan('Rate_deduction_tax_3yrs', $(this).find("Rate_deduction_tax_3yrs").text(), null, null);
                            //    Repayment_superannuation_fund
                            setValuesoflabelTextSpan('Repayment_superannuation_fund', $(this).find("Repayment_superannuation_fund").text(), null, null);
                            //    Total_Income_superannuation_fund
                            setValuesoflabelTextSpan('Total_Income_superannuation_fund', $(this).find("Total_Income_superannuation_fund").text(), null, null);

                            //cssDropDownListToggleClass();
                        });
                    }
                    var amount = 0;
                    if (list_SalBrkup.length > 0) {
                        $.each(list_SalBrkup, function () {
                            if ($(this).find("SalaryMonth").text() == 4) {
                                $("[id*=hdnHrr4]").val($(this).find("Amount").text());
                                setValuesoflabelTextSpan('txtBasic4', $(this).find("Basic_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtDA4', $(this).find("DA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtHRA4', $(this).find("HRA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtOthers4', $(this).find("others").text(), null, null);
                                setValuesoflabelTextSpan('txtMonth4', $(this).find("Net_Additions").text(), null, null);

                            }
                            if ($(this).find("SalaryMonth").text() == 5) {
                                $("[id*=hdnHrr5]").val($(this).find("Amount").text());
                                setValuesoflabelTextSpan('txtBasic5', $(this).find("Basic_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtDA5', $(this).find("DA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtHRA5', $(this).find("HRA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtOthers5', $(this).find("others").text(), null, null);
                                setValuesoflabelTextSpan('txtMonth5', $(this).find("Net_Additions").text(), null, null);

                            }
                            if ($(this).find("SalaryMonth").text() == 6) {
                                $("[id*=hdnHrr6]").val($(this).find("Amount").text());
                                setValuesoflabelTextSpan('txtBasic6', $(this).find("Basic_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtDA6', $(this).find("DA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtHRA6', $(this).find("HRA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtOthers6', $(this).find("others").text(), null, null);
                                setValuesoflabelTextSpan('txtMonth6', $(this).find("Net_Additions").text(), null, null);

                            }
                            if ($(this).find("SalaryMonth").text() == 7) {
                                $("[id*=hdnHrr7]").val($(this).find("Amount").text());
                                setValuesoflabelTextSpan('txtBasic7', $(this).find("Basic_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtDA7', $(this).find("DA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtHRA7', $(this).find("HRA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtOthers7', $(this).find("others").text(), null, null);
                                setValuesoflabelTextSpan('txtMonth7', $(this).find("Net_Additions").text(), null, null);

                            }
                            if ($(this).find("SalaryMonth").text() == 8) {
                                $("[id*=hdnHrr8]").val($(this).find("Amount").text());
                                setValuesoflabelTextSpan('txtBasic8', $(this).find("Basic_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtDA8', $(this).find("DA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtHRA8', $(this).find("HRA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtOthers8', $(this).find("others").text(), null, null);
                                setValuesoflabelTextSpan('txtMonth8', $(this).find("Net_Additions").text(), null, null);

                            }
                            if ($(this).find("SalaryMonth").text() == 9) {
                                $("[id*=hdnHrr9]").val($(this).find("Amount").text());
                                setValuesoflabelTextSpan('txtBasic9', $(this).find("Basic_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtDA9', $(this).find("DA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtHRA9', $(this).find("HRA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtOthers9', $(this).find("others").text(), null, null);
                                setValuesoflabelTextSpan('txtMonth9', $(this).find("Net_Additions").text(), null, null);

                            }
                            if ($(this).find("SalaryMonth").text() == 10) {
                                $("[id*=hdnHrr10]").val($(this).find("Amount").text());
                                setValuesoflabelTextSpan('txtBasic10', $(this).find("Basic_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtDA10', $(this).find("DA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtHRA10', $(this).find("HRA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtOthers10', $(this).find("others").text(), null, null);
                                setValuesoflabelTextSpan('txtMonth10', $(this).find("Net_Additions").text(), null, null);

                            }
                            if ($(this).find("SalaryMonth").text() == 11) {
                                $("[id*=hdnHrr11]").val($(this).find("Amount").text());
                                setValuesoflabelTextSpan('txtBasic11', $(this).find("Basic_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtDA11', $(this).find("DA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtHRA11', $(this).find("HRA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtOthers11', $(this).find("others").text(), null, null);
                                setValuesoflabelTextSpan('txtMonth11', $(this).find("Net_Additions").text(), null, null);

                            }
                            if ($(this).find("SalaryMonth").text() == 12) {
                                $("[id*=hdnHrr12]").val($(this).find("Amount").text());
                                setValuesoflabelTextSpan('txtBasic12', $(this).find("Basic_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtDA12', $(this).find("DA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtHRA12', $(this).find("HRA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtOthers12', $(this).find("others").text(), null, null);
                                setValuesoflabelTextSpan('txtMonth12', $(this).find("Net_Additions").text(), null, null);

                            }
                            if ($(this).find("SalaryMonth").text() == 1) {
                                $("[id*=hdnHrr1]").val($(this).find("Amount").text());
                                setValuesoflabelTextSpan('txtBasic1', $(this).find("Basic_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtDA1', $(this).find("DA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtHRA1', $(this).find("HRA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtOthers1', $(this).find("others").text(), null, null);
                                setValuesoflabelTextSpan('txtMonth1', $(this).find("Net_Additions").text(), null, null);

                            }
                            if ($(this).find("SalaryMonth").text() == 2) {
                                $("[id*=hdnHrr2]").val($(this).find("Amount").text());
                                setValuesoflabelTextSpan('txtBasic2', $(this).find("Basic_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtDA2', $(this).find("DA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtHRA2', $(this).find("HRA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtOthers2', $(this).find("others").text(), null, null);
                                setValuesoflabelTextSpan('txtMonth2', $(this).find("Net_Additions").text(), null, null);

                            }
                            if ($(this).find("SalaryMonth").text() == 3) {
                                $("[id*=hdnHrr3]").val($(this).find("Amount").text());
                                setValuesoflabelTextSpan('txtBasic3', $(this).find("Basic_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtDA3', $(this).find("DA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtHRA3', $(this).find("HRA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtOthers3', $(this).find("others").text(), null, null);
                                setValuesoflabelTextSpan('txtMonth3', $(this).find("Net_Additions").text(), null, null);

                            }


                        });

                    }

                    /////////////////////// Perquisites
                    var tbl = '';
                    $("[id*=tblPerquisites] tbody").empty();
                    $("[id*=tblPerquisites] thead").empty();
                    tbl = tbl + "<thead><tr>";
                    tbl = tbl + "<th style='text-align: center;font-weight: bold;width:5%'>Sr.No</th>";
                    tbl = tbl + "<th  style='text-align: center;font-weight: bold;width:35%'>Perquisites Name</th>";
                    tbl = tbl + "<th  style='text-align: center;font-weight: bold;width:20%'>Perquisites Value</th>";
                    tbl = tbl + "<th  style='text-align: center;font-weight: bold;width:20%'>Paid Amount</th>";
                    tbl = tbl + "<th  style='text-align: center;font-weight: bold;width:20%'>Tax Amount</th>";
                    tbl = tbl + "</tr></thead>";
                    var tc = '';

                    if (list_Perk.length > 0) {

                        let Perquisites_Value_amount = 0;
                        let EmployeePaid_Amt_amount = 0;
                        let Taxable_Amt_amount = 0;

                        $.each(list_Perk, function () {
                            Perquisites_Value_amount = Perquisites_Value_amount + $(this).find("Perquisites_Value").text();

                            EmployeePaid_Amt_amount = EmployeePaid_Amt_amount + $(this).find("EmployeePaid_Amt").text();
                            Taxable_Amt_amount = Taxable_Amt_amount + $(this).find("Taxable_Amt").text();

                            tbl = tbl + " <tr>";
                            tbl = tbl + "<td> " + $(this).find("SrNo").text() + "<input type='hidden' id='hdnPerquisites_ID  value='" + $(this).find("Perquisites_ID").text() + "' name='hdnPerquisites_ID'></td>";
                            tbl = tbl + "<td>" + $(this).find("Perquisites_Name").text() + "</td>";
                            tbl = tbl + "<td><span style='padding-left: 5px;' >&#8377;</span><input type='text' id='txtPerquisites_Value'  data-info='Perquisites_Value' class='ManualEntry' value='" + $(this).find("Perquisites_Value").text() + "' /></td>";
                            tbl = tbl + "<td><span style='padding-left: 5px;' >&#8377;</span><input type='text' id='txtEmployeePaid_Amt' data-info='EmployeePaid_Amt' class='ManualEntry' value='" + $(this).find("EmployeePaid_Amt").text() + "' /></td>";
                            tbl = tbl + "<td><span style='padding-left: 5px;' >&#8377;</span><input type='text' id='txtTaxable_Amt' data-info='Taxable_Amt' class='ManualEntry' value='" + $(this).find("Taxable_Amt").text() + "' /></td>";
                            tbl = tbl + "</tr>";
                        });

                        tbl = tbl + " <tr>";
                        tbl = tbl + "<td></td>";
                        tbl = tbl + "<td>Total</td>";
                        tbl = tbl + "<td>&#8377; <span id='spanPerquisites_Value'>" + Perquisites_Value_amount + "</span></td>";
                        tbl = tbl + "<td>&#8377; <span id='spanEmployeePaid_Amt'>" + EmployeePaid_Amt_amount + "</span></td>";
                        tbl = tbl + "<td>&#8377; <span id='spanTaxable_Amt'>" + Taxable_Amt_amount + "</span></td>";
                        tbl = tbl + "</tr>";

                        //$("[id*=spanSec1Child2]").text(Taxable_Amt_amount);

                        $("[id*=tblPerquisites]").append(tbl);
                    }

                    ///////////////////////// Section 10

                    if (list_Sec10.length > 0) {
                        $.each(list_Sec10, function () {

                            if ($(this).find("AllownaceKey").text() == 'HRA') {
                                setValuesoflabelTextSpan('txtHRAEXMPT', $(this).find("Amount").text(), null, null);
                            }

                            if ($(this).find("AllownaceKey").text() == 'Travel_Concession') {
                                setValuesoflabelTextSpan('txtTravel', $(this).find("Amount").text(), null, null);
                            }

                            if ($(this).find("AllownaceKey").text() == 'Gratuity') {
                                setValuesoflabelTextSpan('txtGratuity', $(this).find("Amount").text(), null, null);
                            }

                            if ($(this).find("AllownaceKey").text() == 'Pension') {
                                setValuesoflabelTextSpan('txtPension', $(this).find("Amount").text(), null, null);
                            }

                            if ($(this).find("AllownaceKey").text() == 'Leave_Cash') {
                                setValuesoflabelTextSpan('txtLeave', $(this).find("Amount").text(), null, null);
                            }

                            if ($(this).find("AllownaceKey").text() == 'Others') {
                                setValuesoflabelTextSpan('txtSOthers', $(this).find("Amount").text(), null, null);
                            }


                        });

                    }


                    if (list_Rebate.length > 0) {
                        $.each(list_Rebate, function () {
                            setValuesoflabelTextSpan('txtRebate80C', $(this).find("Rebate80C").text(), null, null);
                            setValuesoflabelTextSpan('txtRebate80CCC', $(this).find("Rebate80CCC").text(), null, null);
                            setValuesoflabelTextSpan('txtRebate80CCD', $(this).find("Rebate80CCD").text(), null, null);
                            setValuesoflabelTextSpan('txtRebate80CCD1B', $(this).find("Rebate80CCD1B").text(), null, null);
                            setValuesoflabelTextSpan('txtRebate80CCD2', $(this).find("Rebate80CCD2").text(), null, null);

                            setValuesoflabelTextSpan('txtRebate80C_Ded', $(this).find("Rebate80C_Ded").text(), null, null);
                            setValuesoflabelTextSpan('txtRebate80CCC_Ded', $(this).find("Rebate80CCC_Ded").text(), null, null);
                            setValuesoflabelTextSpan('txtRebate80CCD_Ded', $(this).find("Rebate80CCD_Ded").text(), null, null);
                            setValuesoflabelTextSpan('txtRebate80CCD1B_Ded', $(this).find("Rebate80CCD1B_Ded").text(), null, null);
                            setValuesoflabelTextSpan('txtRebate80CCD2_Ded', $(this).find("Rebate80CCD2_Ded").text(), null, null);

                            setValuesoflabelTextSpan('spanRebate80CQly', $(this).find("Rebate80QlfySal").text(), null, null);
                            setValuesoflabelTextSpan('spanRebate80CTotal', $(this).find("Rebate80CTotal").text(), null, null);

                            setValuesoflabelTextSpan('txtRebate80D', $(this).find("Rebate88D").text(), null, null);
                            setValuesoflabelTextSpan('txtRebate80D_Ded', $(this).find("Rebate88D_Ded").text(), null, null);
                            setValuesoflabelTextSpan('txtRebate80G', $(this).find("Rebate80G").text(), null, null);
                            setValuesoflabelTextSpan('txtRebate80G_Ded', $(this).find("Rebate80G_Ded").text(), null, null);
                            setValuesoflabelTextSpan('txtRebate80E', $(this).find("Rebate80E").text(), null, null);
                            setValuesoflabelTextSpan('txtRebate80E_Ded', $(this).find("Rebate80E_Ded").text(), null, null);
                            setValuesoflabelTextSpan('txtRebate80EE', $(this).find("Rebate80EE").text(), null, null);
                            setValuesoflabelTextSpan('txtRebate80EE_Ded', $(this).find("Rebate80EE_Ded").text(), null, null);
                            setValuesoflabelTextSpan('txtRebate80TTA', $(this).find("Rebate80TTA").text(), null, null);
                            setValuesoflabelTextSpan('txtRebate80TTA_Ded', $(this).find("Rebate80TTA_Ded").text(), null, null);
                            setValuesoflabelTextSpan('txtRebateOthers', $(this).find("Rebate80Others").text(), null, null);
                            setValuesoflabelTextSpan('txtRebateOthers_Ded', $(this).find("Rebate80Others_Ded").text(), null, null);


                        });
                    }

                    for (var i = 0; i < 6; i++) {
                        var slabperName = 'lblSlabPer' + (i + 1);
                        var slabName = 'lblSlab' + (i + 1);
                        $('[id*=' + slabperName + ']').html(0);
                        $('[id*=' + slabName + ']').html(0);
                    }

                    if (list_ITax.length > 0) {
                        var i = 0;
                        $.each(list_ITax, function () {


                            setValuesoflabelTextSpan('lblSlabPer' + (i + 1), $(this).find("Slab").text(), null, null);
                            setValuesoflabelTextSpan('lblSlab' + (i + 1), $(this).find("Tax_Amount").text(), null, null);
                            //setValuesoflabelTextSpan('lblIncome' + (i + 1), $(this).find("Amount").text(), null, null);
                            //setValuesoflabelTextSpan('lblIncomeTax' + (i + 1), $(this).find("Amount").text(), null, null);

                            i = i + 1;

                        });

                    }

                    if (list_Chln.length > 0) {
                        tbl = "";
                        $("[id*=tbl_Challan] tbody").empty();
                        $("[id*=tbl_Challan] thead").empty();

                        tbl = tbl + "<thead><tr>";
                        tbl += "<th>#</th>";
                        tbl += "<th>Quarter</th>";
                        tbl += "<th>Challan NO</th>";
                        tbl += "<th>Challan Date</th>";
                        tbl += "<th>TDS Deduction Date</th>";
                        tbl += "<th>Salary</th>";
                        tbl += "<th>TDS Amount</th>";
                        tbl += "<th>Surcharge Amount</th>";
                        tbl += "<th>EducationCess Amount</th>";
                        tbl += "<th>Total TDS Amount</th>";
                        tbl = tbl + "</tr></thead>";

                        $("#tbl_Challan").append(tbl);
                        var j = 0;
                        var chlAmt = 0;
                        tbl += "<tbody>";
                        $.each(list_Chln, function () {
                            tbl += "<tr>";
                            tbl += "<td style='text-align:right;'>" + (j + 1) + "</td>";
                            tbl += "<td width='10%'>" + $(this).find("Quater").text() + "</td>";
                            tbl += "<td width='10%' style='text-align:right;'>" + $(this).find("Challan_No").text() + "</td>";
                            tbl += "<td width='10%' style='text-align:center;'>" + $(this).find("Challan_Date").text() + "</td>";
                            tbl += "<td width='10%' style='text-align:center;'>" + $(this).find("Salary_Date").text() + "</td>";
                            tbl += "<td width='10%' class='frontMakeFormat' style='text-align:right;'>" + $(this).find("Employee_Salary").text() + "</td>";
                            tbl += "<td width='10%' class='frontMakeFormat' style='text-align:right;'>" + $(this).find("Employee_Salary").text() + "</td>";
                            tbl += "<td width='10%' class='frontMakeFormat' style='text-align:right;'>" + $(this).find("Surcharge_Amount").text() + "</td>";
                            tbl += "<td width='10%' class='frontMakeFormat' style='text-align:right;'>" + $(this).find("EducationCess_Amount").text() + "</td>";
                            tbl += "<td width='10%' class='frontMakeFormat' style='text-align:right;'>" + $(this).find("Total_TDS_Amount").text() + "</td>";

                            tbl += "</tr>";
                            chlAmt = parseFloat(chlAmt) + parseFloat($(this).find("Total_TDS_Amount").text());
                        });
                        tbl += "</tbody>";
                        $("#tbl_Challan").append(tbl);

                        setValuesoflabelTextSpan('spanTDS', chlAmt, null, null);
                        var tds = 0;
                        var final = 0;
                        var Sal = 0;
                        tds = $(this).find("PreTds").text();
                        if (tds == '' || tds == undefined) {
                            tds = 0;
                        }
                        tds = parseFloat(chlAmt) + parseFloat(tds);
                        Sal = $(this).find("Itax3").text();
                        if (Sal == '' || Sal == undefined) {
                            Sal = 0;
                        }
                        Sal = parseFloat(Sal) - parseFloat(tds);
                        setValuesoflabelTextSpan('spanFinalTax', Sal, null, null);
                    }


                    var hdr = $('#chkUSBAC').prop("checked");
                    if (hdr == true) {
                        Calculation_BAC115();
                    }
                    else {
                        Calculate_Computation();
                    }

                    Blockloaderhide();
                },
                error: function (response) {
                    alert(response.responseText);
                    Blockloaderhide();
                },
                failure: function (response) {
                    alert(response.responseText);
                    Blockloaderhide();
                }
            });

        }

        function IncometaxSlabCalculation(NetIncome) {
            ///////////point12
            var txtNetIncome = NetIncome; //label

            /////////tax on total income tax Calculation

            var lblSlab1 = $('[id*=lblSlab1]').html();
            var lblSlab2 = $('[id*=lblSlab2]').html();
            var lblSlab3 = $('[id*=lblSlab3]').html();
            var lblSlab4 = $('[id*=lblSlab4]').html();
            var lblSlab5 = $('[id*=lblSlab5]').html();
            var lblSlab6 = $('[id*=lblSlab6]').html();

            var lblSlabPer1 = $('[id*=lblSlabPer1]').html();
            var lblSlabPer2 = $('[id*=lblSlabPer2]').html();
            var lblSlabPer3 = $('[id*=lblSlabPer3]').html();
            var lblSlabPer4 = $('[id*=lblSlabPer4]').html();
            var lblSlabPer5 = $('[id*=lblSlabPer5]').html();
            var lblSlabPer6 = $('[id*=lblSlabPer6]').html();

            $('[id*=lblIncome1]').html(0);
            $('[id*=lblIncome2]').html(0);
            $('[id*=lblIncome3]').html(0);
            $('[id*=lblIncome4]').html(0);
            $('[id*=lblIncome5]').html(0);
            $('[id*=lblIncome6]').html(0);

            $('[id*=lblIncomeTax2]').html(0);
            $('[id*=lblIncomeTax3]').html(0);
            $('[id*=lblIncomeTax4]').html(0);
            $('[id*=lblIncomeTax5]').html(0);
            $('[id*=lblIncomeTax6]').html(0);



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

            ///////////30%
            if (parseFloat(txtNetIncome) > parseFloat(lblSlab4) && parseFloat(txtNetIncome) <= parseFloat(lblSlab5)) {
                lblIncome1 = lblSlab1;
                lblIncome2 = parseFloat(lblSlab2) - parseFloat(lblSlab1);
                lblIncomeTax2 = (parseFloat(lblIncome2) * lblSlabPer2) / 100;
                lblIncome3 = parseFloat(lblSlab3) - parseFloat(lblSlab2);
                lblIncomeTax3 = (parseFloat(lblIncome3) * lblSlabPer3) / 100;
                lblIncome4 = parseFloat(txtNetIncome) - parseFloat(lblSlab3);
                lblIncomeTax4 = (parseFloat(lblIncome4) * lblSlabPer4) / 100;
                lblIncome5 = parseFloat(txtNetIncome) - parseFloat(lblSlab4);
                lblIncomeTax5 = (parseFloat(lblIncome5) * lblSlabPer5) / 100;
                lblIncome6 = parseFloat(txtNetIncome) - parseFloat(lblSlab5);
                lblIncomeTax6 = (parseFloat(lblIncome6) * lblSlabPer6) / 100;
            }

            ///////////30%
            if (parseFloat(txtNetIncome) > parseFloat(lblSlab5) && parseFloat(txtNetIncome) <= parseFloat(lblSlab6)) {
                lblIncome1 = lblSlab1;
                lblIncome2 = parseFloat(lblSlab2) - parseFloat(lblSlab1);
                lblIncomeTax2 = (parseFloat(lblIncome2) * lblSlabPer2) / 100;
                lblIncome3 = parseFloat(lblSlab3) - parseFloat(lblSlab2);
                lblIncomeTax3 = (parseFloat(lblIncome3) * lblSlabPer3) / 100;
                lblIncome4 = parseFloat(txtNetIncome) - parseFloat(lblSlab3);
                lblIncomeTax4 = (parseFloat(lblIncome4) * lblSlabPer4) / 100;
                lblIncome5 = parseFloat(txtNetIncome) - parseFloat(lblSlab4);
                lblIncomeTax5 = (parseFloat(lblIncome5) * lblSlabPer5) / 100;
                lblIncome6 = parseFloat(txtNetIncome) - parseFloat(lblSlab5);
                lblIncomeTax6 = (parseFloat(lblIncome6) * lblSlabPer6) / 100;
            }

            $('[id*=lblIncome1]').html(Math.round(lblIncome1));
            $('[id*=lblIncome2]').html(Math.round(lblIncome2));
            $('[id*=lblIncome3]').html(Math.round(lblIncome3));
            $('[id*=lblIncome4]').html(Math.round(lblIncome4));
            $('[id*=lblIncome5]').html(Math.round(lblIncome5));
            $('[id*=lblIncome6]').html(Math.round(lblIncome6));

            $('[id*=lblIncomeTotal]').html(Math.round(parseFloat(lblIncome1) + parseFloat(lblIncome2) + parseFloat(lblIncome3) + parseFloat(lblIncome4) + parseFloat(lblIncome5) + parseFloat(lblIncome6)));

            $('[id*=lblIncomeTax1]').html('Nil');
            $('[id*=lblIncomeTax2]').html(Math.round(lblIncomeTax2));
            $('[id*=lblIncomeTax3]').html(Math.round(lblIncomeTax3));
            $('[id*=lblIncomeTax4]').html(Math.round(lblIncomeTax4));
            $('[id*=lblIncomeTax5]').html(Math.round(lblIncomeTax5));
            $('[id*=lblIncomeTax6]').html(Math.round(lblIncomeTax6));




            var ITax = 0;
            ITax = Math.round(parseFloat(lblIncomeTax2) + parseFloat(lblIncomeTax3) + parseFloat(lblIncomeTax4) + parseFloat(lblIncomeTax5) + parseFloat(lblIncomeTax6));


            return ITax;

        }

        function Incometax_115_Calculation(NetIncome) {
            ///////////point12
            var txtNetIncome = NetIncome; //label

            /////////tax on total income tax Calculation

            var lblSlab1 = $('[id*=SHlblBACSlab1]').html();
            var lblSlab2 = $('[id*=SHlblBACSlab2]').html();
            var lblSlab3 = $('[id*=SHlblBACSlab3]').html();
            var lblSlab4 = $('[id*=SHlblBACSlab4]').html();
            var lblSlab5 = $('[id*=SHlblBACSlab5]').html();
            var lblSlab6 = $('[id*=SHlblBACSlab6]').html();
            var lblSlab7 = $('[id*=SHlblBACSlab7]').html();

            var lblSlabPer1 = $('[id*=SHlblPer1]').html();
            var lblSlabPer2 = $('[id*=SHlblPer2]').html();
            var lblSlabPer3 = $('[id*=SHlblPer3]').html();
            var lblSlabPer4 = $('[id*=SHlblPer4]').html();
            var lblSlabPer5 = $('[id*=SHlblPer5]').html();
            var lblSlabPer6 = $('[id*=SHlblPer6]').html();
            var lblSlabPer7 = $('[id*=SHlblPer7]').html();

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




            //////////////0
            if (parseFloat(txtNetIncome) <= parseFloat(lblSlab1)) {
                IncomeTax = txtNetIncome;
                lblIncome1 = txtNetIncome;
            }


            ///////////5%
            if (parseFloat(txtNetIncome) > parseFloat(lblSlab1) && parseFloat(txtNetIncome) <= parseFloat(lblSlab2)) {
                lblIncome1 = lblSlab1;
                lblIncome2 = parseFloat(txtNetIncome) - parseFloat(lblSlab1);
                lblIncomeTax2 = (parseFloat(lblIncome2) * lblSlabPer2) / 100;
            }
            ///////////10%
            if (parseFloat(txtNetIncome) > parseFloat(lblSlab2) && parseFloat(txtNetIncome) <= parseFloat(lblSlab3)) {
                lblIncome1 = lblSlab1;
                lblIncome2 = parseFloat(lblSlab2) - parseFloat(lblSlab1);
                lblIncomeTax2 = (parseFloat(lblIncome2) * lblSlabPer2) / 100;
                lblIncome3 = parseFloat(txtNetIncome) - parseFloat(lblSlab2);
                lblIncomeTax3 = (parseFloat(lblIncome3) * lblSlabPer3) / 100;
            }
            ///////////15%
            if (parseFloat(txtNetIncome) > parseFloat(lblSlab3) && parseFloat(txtNetIncome) <= parseFloat(lblSlab4)) {
                lblIncome1 = lblSlab1;
                lblIncome2 = parseFloat(lblSlab2) - parseFloat(lblSlab1);
                lblIncomeTax2 = (parseFloat(lblIncome2) * lblSlabPer2) / 100;
                lblIncome3 = parseFloat(lblSlab3) - parseFloat(lblSlab2);
                lblIncomeTax3 = (parseFloat(lblIncome3) * lblSlabPer3) / 100;
                lblIncome4 = parseFloat(txtNetIncome) - parseFloat(lblSlab3);
                lblIncomeTax4 = (parseFloat(lblIncome4) * lblSlabPer4) / 100;
            }

            ///////////20%
            if (parseFloat(txtNetIncome) > parseFloat(lblSlab4) && parseFloat(txtNetIncome) <= parseFloat(lblSlab5)) {
                lblIncome1 = lblSlab1;
                lblIncome2 = parseFloat(lblSlab2) - parseFloat(lblSlab1);
                lblIncomeTax2 = (parseFloat(lblIncome2) * lblSlabPer2) / 100;
                lblIncome3 = parseFloat(lblSlab3) - parseFloat(lblSlab2);
                lblIncomeTax3 = (parseFloat(lblIncome3) * lblSlabPer3) / 100;
                lblIncome4 = parseFloat(lblSlab4) - parseFloat(lblSlab3);
                lblIncomeTax4 = (parseFloat(lblIncome4) * lblSlabPer4) / 100;
                lblIncome5 = parseFloat(txtNetIncome) - parseFloat(lblSlab4);
                lblIncomeTax5 = (parseFloat(lblIncome5) * lblSlabPer5) / 100;
            }

            ///////////25%
            if (parseFloat(txtNetIncome) > parseFloat(lblSlab5) && parseFloat(txtNetIncome) <= parseFloat(lblSlab6)) {
                lblIncome1 = lblSlab1;
                lblIncome2 = parseFloat(lblSlab2) - parseFloat(lblSlab1);
                lblIncomeTax2 = (parseFloat(lblIncome2) * lblSlabPer2) / 100;
                lblIncome3 = parseFloat(lblSlab3) - parseFloat(lblSlab2);
                lblIncomeTax3 = (parseFloat(lblIncome3) * lblSlabPer3) / 100;
                lblIncome4 = parseFloat(lblSlab4) - parseFloat(lblSlab3);
                lblIncomeTax4 = (parseFloat(lblIncome4) * lblSlabPer4) / 100;
                lblIncome5 = parseFloat(lblSlab5) - parseFloat(lblSlab4);
                lblIncomeTax5 = (parseFloat(lblIncome5) * lblSlabPer5) / 100;
                lblIncome6 = parseFloat(txtNetIncome) - parseFloat(lblSlab5);
                lblIncomeTax6 = (parseFloat(lblIncome6) * lblSlabPer6) / 100;
            }


            ///////////30%
            if (parseFloat(txtNetIncome) > parseFloat(lblSlab6) && parseFloat(txtNetIncome) <= parseFloat(lblSlab7)) {
                lblIncome1 = lblSlab1;
                lblIncome2 = parseFloat(lblSlab2) - parseFloat(lblSlab1);
                lblIncomeTax2 = (parseFloat(lblIncome2) * lblSlabPer2) / 100;
                lblIncome3 = parseFloat(lblSlab3) - parseFloat(lblSlab2);
                lblIncomeTax3 = (parseFloat(lblIncome3) * lblSlabPer3) / 100;
                lblIncome4 = parseFloat(lblSlab4) - parseFloat(lblSlab3);
                lblIncomeTax4 = (parseFloat(lblIncome4) * lblSlabPer4) / 100;
                lblIncome5 = parseFloat(lblSlab5) - parseFloat(lblSlab4);
                lblIncomeTax5 = (parseFloat(lblIncome5) * lblSlabPer5) / 100;
                lblIncome6 = parseFloat(lblSlab6) - parseFloat(lblSlab5);
                lblIncomeTax6 = (parseFloat(lblIncome6) * lblSlabPer6) / 100;
                lblIncome7 = parseFloat(txtNetIncome) - parseFloat(lblSlab6);
                lblIncomeTax7 = (parseFloat(lblIncome7) * lblSlabPer7) / 100;

            }
            var ITax = 0;
            ITax = Math.round(parseFloat(lblIncomeTax2) + parseFloat(lblIncomeTax3) + parseFloat(lblIncomeTax4) + parseFloat(lblIncomeTax5) + parseFloat(lblIncomeTax6) + parseFloat(lblIncomeTax7));


            return ITax;
        }


        function setValuesoflabelTextSpan(nameOfcontrol, controlvalue, datakeyname, datakeyvalue) {
            nameOfcontrol = '#' + nameOfcontrol;
            var currobj = $(nameOfcontrol);
            if (currobj.length > 0) {
                if (currobj[0].nodeName == 'SPAN') { currobj.text(controlvalue); }
                if (currobj[0].nodeName == 'INPUT') { currobj.val(controlvalue); }
                if (currobj[0].nodeName == 'SELECT') { currobj.val(controlvalue); }
            }
        }

        function openViewDetails1() {
            console.log("button clicked");
            $('#modal_ViewDetails1').modal('show');
        }


        function getHra_Values() {
            Blockloadershow();
            var eid = $("[id*=hdnEmpID]").val();
            var tobj = {
                Employee_ID: eid

            };
            tobj = JSON.stringify({ 'tobj': tobj });

            $.ajax({
                url: "../../TDS/BTStrp/Handler/TDSComputationV2.asmx/getEmployeeHraDetails",
                data: tobj,
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (msg) {
                    var xmlDoc = $.parseXML(msg.d);
                    var xml = $(xmlDoc);

                    var list_Metro = xml.find("Table")
                    var list_SalBrkup = xml.find("Table1")

                    if (list_Metro.length > 0) {
                        $.each(list_Metro, function () {
                            Metro = $(this).find("Metro_Cities").text();
                        });
                    }

                    var amount = 0;
                    if (list_SalBrkup.length > 0) {
                        $.each(list_SalBrkup, function () {

                            if ($(this).find("SalaryMonth").text() == 4) {

                                setValuesoflabelTextSpan('spnBasic4', $(this).find("Basic_Amount").text(), null, null);
                                setValuesoflabelTextSpan('spnDA4', $(this).find("DA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('spnHRA4', $(this).find("HRA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtHRR4', $(this).find("Amount").text(), null, null);

                            }
                            if ($(this).find("SalaryMonth").text() == 5) {

                                setValuesoflabelTextSpan('spnBasic5', $(this).find("Basic_Amount").text(), null, null);
                                setValuesoflabelTextSpan('spnDA5', $(this).find("DA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('spnHRA5', $(this).find("HRA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtHRR5', $(this).find("Amount").text(), null, null);
                            }
                            if ($(this).find("SalaryMonth").text() == 6) {

                                setValuesoflabelTextSpan('spnBasic6', $(this).find("Basic_Amount").text(), null, null);
                                setValuesoflabelTextSpan('spnDA6', $(this).find("DA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('spnHRA6', $(this).find("HRA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtHRR6', $(this).find("Amount").text(), null, null);
                            }
                            if ($(this).find("SalaryMonth").text() == 7) {

                                setValuesoflabelTextSpan('spnBasic7', $(this).find("Basic_Amount").text(), null, null);
                                setValuesoflabelTextSpan('spnDA7', $(this).find("DA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('spnHRA7', $(this).find("HRA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtHRR7', $(this).find("Amount").text(), null, null);
                            }
                            if ($(this).find("SalaryMonth").text() == 8) {

                                setValuesoflabelTextSpan('spnBasic8', $(this).find("Basic_Amount").text(), null, null);
                                setValuesoflabelTextSpan('spnDA8', $(this).find("DA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('spnHRA8', $(this).find("HRA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtHRR8', $(this).find("Amount").text(), null, null);
                            }
                            if ($(this).find("SalaryMonth").text() == 9) {

                                setValuesoflabelTextSpan('spnBasic9', $(this).find("Basic_Amount").text(), null, null);
                                setValuesoflabelTextSpan('spnDA9', $(this).find("DA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('spnHRA9', $(this).find("HRA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtHRR9', $(this).find("Amount").text(), null, null);
                            }
                            if ($(this).find("SalaryMonth").text() == 10) {

                                setValuesoflabelTextSpan('spnBasic10', $(this).find("Basic_Amount").text(), null, null);
                                setValuesoflabelTextSpan('spnDA10', $(this).find("DA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('spnHRA10', $(this).find("HRA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtHRR10', $(this).find("Amount").text(), null, null);
                            }
                            if ($(this).find("SalaryMonth").text() == 11) {

                                setValuesoflabelTextSpan('spnBasic11', $(this).find("Basic_Amount").text(), null, null);
                                setValuesoflabelTextSpan('spnDA11', $(this).find("DA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('spnHRA11', $(this).find("HRA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtHRR11', $(this).find("Amount").text(), null, null);
                            }
                            if ($(this).find("SalaryMonth").text() == 12) {

                                setValuesoflabelTextSpan('spnBasic12', $(this).find("Basic_Amount").text(), null, null);
                                setValuesoflabelTextSpan('spnDA12', $(this).find("DA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('spnHRA12', $(this).find("HRA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtHRR12', $(this).find("Amount").text(), null, null);
                            }
                            if ($(this).find("SalaryMonth").text() == 1) {

                                setValuesoflabelTextSpan('spnBasic1', $(this).find("Basic_Amount").text(), null, null);
                                setValuesoflabelTextSpan('spnDA1', $(this).find("DA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('spnHRA1', $(this).find("HRA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtHRR1', $(this).find("Amount").text(), null, null);
                            }
                            if ($(this).find("SalaryMonth").text() == 2) {

                                setValuesoflabelTextSpan('spnBasic2', $(this).find("Basic_Amount").text(), null, null);
                                setValuesoflabelTextSpan('spnDA2', $(this).find("DA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('spnHRA2', $(this).find("HRA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtHRR2', $(this).find("Amount").text(), null, null);
                            }
                            if ($(this).find("SalaryMonth").text() == 3) {

                                setValuesoflabelTextSpan('spnBasic3', $(this).find("Basic_Amount").text(), null, null);
                                setValuesoflabelTextSpan('spnDA3', $(this).find("DA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('spnHRA3', $(this).find("HRA_Amount").text(), null, null);
                                setValuesoflabelTextSpan('txtHRR3', $(this).find("Amount").text(), null, null);
                            }

                        });

                    }
                    Blockloaderhide();
                },
                error: function (response) {
                    alert(response.responseText);
                    Blockloaderhide();
                },
                failure: function (response) {
                    alert(response.responseText);
                    Blockloaderhide();
                }
            });

        }

        function openViewHra() {
            $('#modal_Hra').modal('show');
            getHra_Values();

        }

        function openViewDetails2() {
            $('#modal_ViewDetails2').modal('show');
        }

        function openViewDetails3() {
            var hdr = $('#chkUSBAC').prop("checked");
            if (hdr == false) {
                $('#modal_iTax').modal('show');
            }
            else {
                $('#modal_BAC_iTax').modal('show');
            }
        }

        function returnNumeric(num) {
            if (num == null || num == undefined || num == '' || isNaN(num)) num = 0;
            return parseFloat(num);
        }

        function Calculate_Computation() {

            var Err = 0;
            var point1 = $("[id*=spanGrossEarn1]").html(); ///point 1
            var point2 = $("[id*=spanSection10Total]").html(); ///point 2
            var point3 = $("[id*=spanGross3]").html(); ///point 3
            var point4 = $("[id*=spanDeduction]").html(); ///point 4
            var point5 = $("[id*=spanGross5]").html(); ///point 5
            var point6 = $("[id*=spanOthInc]").html(); ///point 6
            var point7 = $("[id*=spanIntHome]").html(); ///point 7
            var point8 = $("[id*=spanGross8]").html(); ///point 8
            $('[id*=lblIncome1]').html(0);
            $('[id*=lblIncome2]').html(0);
            $('[id*=lblIncome3]').html(0);
            $('[id*=lblIncome4]').html(0);
            $('[id*=lblIncomeTax2]').html(0);
            $('[id*=lblIncomeTax3]').html(0);
            $('[id*=lblIncomeTax4]').html(0);



            if (parseFloat(point1) == 0) {
                PointZero(1);
                return;
            }

            ////////////point 3 calculation (Balance)
            point3 = (returnNumeric(point1) - returnNumeric(point2)) + returnNumeric($("[id*=txtPreviousSal]").val());
            ///////////point 5 Income chargeable under the head Salaries

            point5 = returnNumeric(point3) - returnNumeric(point4);

            if (parseFloat(point5) <= 0) {
                PointZero(5);
                $("[id*=spanGross3]").html(point3);
                return;
            }
            $("[id*=spanGross5]").html(point5);
            ///////////point  8 Gross Total Income
            point8 = (returnNumeric(point5) + returnNumeric(point6)) - returnNumeric(point7);

            if (parseFloat(point8) <= 0) {
                PointZero(8);

                return;
            }
            else {

                $("[id*=spanGross8]").html(point8);

                var point9 = $("[id*=spanRebateTotal]").html(); ///point 9
                if ($("[id*=spanNetIncTax]").html() <= 0) {
                    $("[id*=spanTAX]").html(0);
                    $("[id*=spanTax]").html(0);
                    $("[id*=spanNetIncTax]").html(0);
                    PointZero(8);

                }
                //var point10 = $("[id*=spanRebateTotal]").html(); ///point 10
                //var point11 = $("[id*=lblAggregateoftax]").html(); ///point 11

                var point18 = $("[id*=txtRebate89]").val(); ///point 18
                var point19 = $("[id*=spanTDS]").html(); ///point 19
                var point20 = $("[id*=txtPreTDS]").val(); ///point 20


                var point12 = 0;
                var point13 = 0;
                var point14 = 0;
                var point15 = 0;
                var point16 = 0;
                var point17 = 0;

                var point21 = 0;
                var pointSur = 0;
            }

            if (point9 == '') {
                point9 = 0;
            }

            //if (point10 == '') {
            //    point10 = 0;
            //}

            ///////////point 11 Aggregate of tax rebates and relief
            //point10 = returnNumeric(point9) + returnNumeric(point10);

            //////////point 12 Net Income
            point12 = returnNumeric(point8) - returnNumeric(point9);

            /////////////********************** Calculate Income Tax **************************************////////////////////

            var txtNetIncome = point12; //label

            /////////tax on total income tax Calculation

            var lblSlab1 = $('[id*=lblSlab1]').html();
            var lblSlab2 = $('[id*=lblSlab2]').html();
            var lblSlab3 = $('[id*=lblSlab3]').html();
            var lblSlab4 = $('[id*=lblSlab4]').html();
            var lblSlab5 = $('[id*=lblSlab5]').html();
            var lblSlab6 = $('[id*=lblSlab6]').html();

            var lblSlabPer1 = $('[id*=lblSlabPer1]').html();
            var lblSlabPer2 = $('[id*=lblSlabPer2]').html();
            var lblSlabPer3 = $('[id*=lblSlabPer3]').html();
            var lblSlabPer4 = $('[id*=lblSlabPer4]').html();
            var lblSlabPer5 = $('[id*=lblSlabPer5]').html();
            var lblSlabPer6 = $('[id*=lblSlabPer6]').html();

            $('[id*=lblIncome1]').html(0);
            $('[id*=lblIncome2]').html(0);
            $('[id*=lblIncome3]').html(0);
            $('[id*=lblIncome4]').html(0);
            $('[id*=lblIncome5]').html(0);
            $('[id*=lblIncome6]').html(0);

            $('[id*=lblIncomeTax2]').html(0);
            $('[id*=lblIncomeTax3]').html(0);
            $('[id*=lblIncomeTax4]').html(0);
            $('[id*=lblIncomeTax5]').html(0);
            $('[id*=lblIncomeTax6]').html(0);

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

            ///////////30%
            if (parseFloat(txtNetIncome) > parseFloat(lblSlab4) && parseFloat(txtNetIncome) <= parseFloat(lblSlab5)) {
                lblIncome1 = lblSlab1;
                lblIncome2 = parseFloat(lblSlab2) - parseFloat(lblSlab1);
                lblIncomeTax2 = (parseFloat(lblIncome2) * lblSlabPer2) / 100;
                lblIncome3 = parseFloat(lblSlab3) - parseFloat(lblSlab2);
                lblIncomeTax3 = (parseFloat(lblIncome3) * lblSlabPer3) / 100;
                lblIncome4 = parseFloat(txtNetIncome) - parseFloat(lblSlab3);
                lblIncomeTax4 = (parseFloat(lblIncome4) * lblSlabPer4) / 100;
                lblIncome5 = parseFloat(txtNetIncome) - parseFloat(lblSlab4);
                lblIncomeTax5 = (parseFloat(lblIncome5) * lblSlabPer5) / 100;
                lblIncome6 = parseFloat(txtNetIncome) - parseFloat(lblSlab5);
                lblIncomeTax6 = (parseFloat(lblIncome6) * lblSlabPer6) / 100;
            }

            ///////////30%
            if (parseFloat(txtNetIncome) > parseFloat(lblSlab5) && parseFloat(txtNetIncome) <= parseFloat(lblSlab6)) {
                lblIncome1 = lblSlab1;
                lblIncome2 = parseFloat(lblSlab2) - parseFloat(lblSlab1);
                lblIncomeTax2 = (parseFloat(lblIncome2) * lblSlabPer2) / 100;
                lblIncome3 = parseFloat(lblSlab3) - parseFloat(lblSlab2);
                lblIncomeTax3 = (parseFloat(lblIncome3) * lblSlabPer3) / 100;
                lblIncome4 = parseFloat(txtNetIncome) - parseFloat(lblSlab3);
                lblIncomeTax4 = (parseFloat(lblIncome4) * lblSlabPer4) / 100;
                lblIncome5 = parseFloat(txtNetIncome) - parseFloat(lblSlab4);
                lblIncomeTax5 = (parseFloat(lblIncome5) * lblSlabPer5) / 100;
                lblIncome6 = parseFloat(txtNetIncome) - parseFloat(lblSlab5);
                lblIncomeTax6 = (parseFloat(lblIncome6) * lblSlabPer6) / 100;
            }

            $('[id*=lblIncome1]').html(Math.round(lblIncome1));
            $('[id*=lblIncome2]').html(Math.round(lblIncome2));
            $('[id*=lblIncome3]').html(Math.round(lblIncome3));
            $('[id*=lblIncome4]').html(Math.round(lblIncome4));
            $('[id*=lblIncome5]').html(Math.round(lblIncome5));
            $('[id*=lblIncome6]').html(Math.round(lblIncome6));

            $('[id*=lblIncomeTotal]').html(Math.round(parseFloat(lblIncome1) + parseFloat(lblIncome2) + parseFloat(lblIncome3) + parseFloat(lblIncome4) + parseFloat(lblIncome5) + parseFloat(lblIncome6)));

            $('[id*=lblIncomeTax1]').html('Nil');
            $('[id*=lblIncomeTax2]').html(Math.round(lblIncomeTax2));
            $('[id*=lblIncomeTax3]').html(Math.round(lblIncomeTax3));
            $('[id*=lblIncomeTax4]').html(Math.round(lblIncomeTax4));
            $('[id*=lblIncomeTax5]').html(Math.round(lblIncomeTax5));
            $('[id*=lblIncomeTax6]').html(Math.round(lblIncomeTax6));

            $('[id*=lblIncomeTaxTotal]').html(Math.round(parseFloat(lblIncomeTax2) + parseFloat(lblIncomeTax3) + parseFloat(lblIncomeTax4) + parseFloat(lblIncomeTax5) + parseFloat(lblIncomeTax6)));


            point13 = $('[id*=lblIncomeTaxTotal]').html();



            /////////////////////////////// ************************************* End of IncomeTax Calculation ******************////////////////////////////////



            //////////point 14 87 A
            var Sallimitfor87A = 500000;
            var limitfor87A = 0;
            limitfor87A = parseFloat($("[id*=hdnlimitfor87A]").val());

            if (parseFloat(point12) <= Sallimitfor87A) {
                if (parseFloat(point13) >= parseFloat(limitfor87A)) { point14 = limitfor87A; }
                else { point14 = point13; }
            } else { point14 = 0; }
            point14 = Math.round(point14);

            point15 = parseFloat(point13) - parseFloat(point14);
            ///////////point 15 16 17 18 calculation related details
            var hdnSurcharge = 0, hdnCessper = 0, hdnHcessper = 0, hdnHealthPer = 0;
            hdnCessper = $("[id*=hdnCessPer]").val();
            hdnHcessper = $("[id*=hdnHcessper]").val();
            hdnHealthPer = $("[id*=hdnHealthPer]").val();


            //////////point 15 Tax payable and surcharge

            var Fyr = '';
            var surchargeType = '';
            Surcharge = 0;
            Surcharge115 = 0;
            if (point12 > 0) {
                Fyr = $("[id*=ddlFinancialYear] :selected").text();
                if (parseFloat(Fyr.substring(0, 4)) > 2016) {

                    ////// 20_21 onwards

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
                        //point15 = point15 + parseFloat(Surcharge);
                        pointSur = parseFloat(Surcharge);
                    }

                    //2022


                }
                else {
                    //  point15 = point15 + ((point13 * parseFloat($("[id*=hdnSurchargePercentage]").val())) / 100);
                    pointSur = ((point13 * parseFloat($("[id*=hdnSurchargePercentage]").val())) / 100);
                }

                point15 = Math.round(point15);
                var p15 = 0;
                p15 = parseFloat(point15) + parseFloat(pointSur)
                //////////point 16 (a) Health & Education Cess
                var CAmt = 0;
                hdnCessper = parseFloat(hdnCessper) + parseFloat(hdnHcessper) + parseFloat(hdnHealthPer);
                //CAmt = Math.round((parseFloat(point15) * parseFloat(hdnCessPer)) / 100);
                CAmt = Math.round((parseFloat(p15) * parseFloat(hdnCessper)) / 100);
                /////////point 17 (b)Higher Education Cess
                //var Cess = 0;

                //Cess = parseFloat(hdnHcessper) + parseFloat(hdnHealthPer)
                ////CAmt = CAmt +  Math.round((parseFloat(point15) * parseFloat(Cess)) / 100);
                //CAmt = CAmt + Math.round((parseFloat(p15) * parseFloat(Cess)) / 100);
                //HeathCess = hdnHealthPer;
                point16 = CAmt;
                p15 = 0;
                CAmt = 0;
                Cess = 0;
                /////////point 17(b) Health Cess
                //point17 = point17 + Math.round((parseFloat(point15) * parseFloat(hdnHealthPer)) / 100);
                point17 = (returnNumeric(point15) + returnNumeric(pointSur) + returnNumeric(point16)) - returnNumeric(point17);
                point18 = (returnNumeric(point17) - returnNumeric(point18))
                point21 = returnNumeric(point18) - (returnNumeric(point19) + returnNumeric(point20));


                ////////////set values
                $("[id*=spanGross3]").html(point3); ///point 3
                $("[id*=spanGross5]").html(point5); ///point 5
                $("[id*=spanGross8]").html(point8); ///point 8
                //$("[id*=spanNetIncTax]").html(point11); ///point 11
                $("[id*=spanNetIncTax]").html(point12); ///point 12
                $("[id*=spanOnTaxTotalIncome]").html(point13); ///point 13
                $("[id*=spanRebate87A]").html(point14); ///point 14
                $("[id*=spanRebateTAX]").html(point15); ///point 15
                $("[id*=spanSurcharge]").html(pointSur); ///point 15
                $("[id*=spanCess]").html(point16); ///point 16
                 
                $("[id*=spanTax]").html(point18); ///point 17


                $("[id*=spanFinalTax]").html(point21); ///point 21




            }

            Auto_Saving();
        }

        function PointZero(i) {
            if (i == 1) {

                $("[id*=spanGrossEarn1]").html(0); ///point 1
                $("[id*=spanSection10Total]").html(0); ///point 2
                $("[id*=txtTravel]").val(0);
                $("[id*=txtGratuity]").val(0);
                $("[id*=txtPension]").val(0);
                $("[id*=txtLeave]").val(0);
                $("[id*=txtSOthers]").val(0);

                $("[id*=spanGross3]").html(0); ///point 3
                $("[id*=spanDeduction]").html(0);
                $("[id*=spanGross5]").html(0);
                $("[id*=spanGross8]").html(0)
                $("[id*=spanOthInc]").html(0);
                $("[id*=txtOthInc]").val(0);
                $("[id*=spanIntHome]").html(0);
                $("[id*=txtIntHome]").val(0);
                $("[id*=spanNetIncTax]").html(0);




                $("#txtRebate80C").val(0);
                $("#txtRebate80C_Ded").val(0);
                $("#txtRebate80CCC").val(0);
                $("#txtRebate80CCC_Ded").val(0);
                $("#txtRebate80CCD").val(0);
                $("#txtRebate80CCD_Ded").val(0);
                $("#spanRebate80CTotal").html(0);

                $("#txtRebate80CCD1B").val(0);
                $("#txtRebate80CCD1B_Ded").val(0);
                $("#txtRebate80CCD2").val(0);
                $("#txtRebate80CCD2_Ded").val(0);
                $("#txtRebate80D").val(0);
                $("#txtRebate80D_Ded").val(0);
                $("#txtRebate80G").val(0);
                $("#txtRebate80G_Ded").val(0);
                $("#txtRebate80E").val(0);
                $("#txtRebate80E_Ded").val(0);
                $("#txtRebate80EE").val(0);
                $("#txtRebate80EE_Ded").val(0);
                $("#txtRebate80TTA").val(0);
                $("#txtRebate80TTA_Ded").val(0);
                $("#txtRebateOthers").val(0);
                $("#txtRebateOthers_Ded").val(0);


                $("[id*=spanOnTaxTotalIncome]").html(0);
                $("[id*=spanRebate87A]").html(0); ///point 14
                $("[id*=spanRebateTAX]").html(0); ///point 15
                $("[id*=spanSurcharge]").html(0); ///point 15
                $("[id*=spanCess]").html(0); ///point 16
                $("[id*=txtRebate89]").val(0);
                $("[id*=spanTax]").html(0); ///point 17


                $("[id*=spanFinalTax]").html(0); ///point 21
            }
            if (i == 5) {

                $("[id*=spanGross5]").html(0);
                $("[id*=spanGross8]").html(0)
                $("[id*=spanOthInc]").html(0);
                $("[id*=txtOthInc]").val(0);
                $("[id*=spanIntHome]").html(0);
                $("[id*=txtIntHome]").val(0);
                $("[id*=spanNetIncTax]").html(0);




                $("#txtRebate80C").val(0);
                $("#txtRebate80C_Ded").val(0);
                $("#txtRebate80CCC").val(0);
                $("#txtRebate80CCC_Ded").val(0);
                $("#txtRebate80CCD").val(0);
                $("#txtRebate80CCD_Ded").val(0);
                $("#spanRebate80CTotal").html(0);

                $("#txtRebate80CCD1B").val(0);
                $("#txtRebate80CCD1B_Ded").val(0);
                $("#txtRebate80CCD2").val(0);
                $("#txtRebate80CCD2_Ded").val(0);
                $("#txtRebate80D").val(0);
                $("#txtRebate80D_Ded").val(0);
                $("#txtRebate80G").val(0);
                $("#txtRebate80G_Ded").val(0);
                $("#txtRebate80E").val(0);
                $("#txtRebate80E_Ded").val(0);
                $("#txtRebate80EE").val(0);
                $("#txtRebate80EE_Ded").val(0);
                $("#txtRebate80TTA").val(0);
                $("#txtRebate80TTA_Ded").val(0);
                $("#txtRebateOthers").val(0);
                $("#txtRebateOthers_Ded").val(0);


                $("[id*=spanOnTaxTotalIncome]").html(0);
                $("[id*=spanRebate87A]").html(0); ///point 14
                $("[id*=spanRebateTAX]").html(0); ///point 15
                $("[id*=spanSurcharge]").html(0); ///point 15
                $("[id*=spanCess]").html(0); ///point 16
                $("[id*=txtRebate89]").val(0);
                $("[id*=spanTax]").html(0); ///point 17


                $("[id*=spanFinalTax]").html(0); ///point 21
            }

            //}
            if (i == 7) {
                $("[id*=spanGross8]").html(0)
                $("[id*=spanOthInc]").html(0);
                $("[id*=txtOthInc]").val(0);
                $("[id*=spanIntHome]").html(0);
                $("[id*=txtIntHome]").val(0);
                $("[id*=spanNetIncTax]").html(0);

                $("#txtRebate80C").val(0);
                $("#txtRebate80C_Ded").val(0);
                $("#txtRebate80CCC").val(0);
                $("#txtRebate80CCC_Ded").val(0);
                $("#txtRebate80CCD").val(0);
                $("#txtRebate80CCD_Ded").val(0);
                $("#spanRebate80CTotal").html(0);

                $("#txtRebate80CCD1B").val(0);
                $("#txtRebate80CCD1B_Ded").val(0);
                $("#txtRebate80CCD2]").val(0);
                $("#txtRebate80CCD2_Ded").val(0);
                $("#txtRebate80D").val(0);
                $("#txtRebate80D_Ded").val(0);
                $("#txtRebate80G").val(0);
                $("#txtRebate80G_Ded").val(0);
                $("#txtRebate80E").val(0);
                $("#txtRebate80E_Ded").val(0);
                $("#txtRebate80EE").val(0);
                $("#txtRebate80EE_Ded").val(0);
                $("#txtRebate80TTA").val(0);
                $("#txtRebate80TTA_Ded").val(0);
                $("#txtRebateOthers").val(0);
                $("#txtRebateOthers_Ded").val(0);


                $("[id*=spanOnTaxTotalIncome]").html(0);
                $("[id*=spanRebate87A]").html(0); ///point 14
                $("[id*=spanRebateTAX]").html(0); ///point 15
                $("[id*=spanSurcharge]").html(0); ///point 15
                $("[id*=spanCess]").html(0); ///point 16
                $("[id*=txtRebate89]").val(0);
                $("[id*=spanTax]").html(0); ///point 17


                $("[id*=spanFinalTax]").html(0); ///point 21
            }
            else if (i == 8) {
                $("[id*=spanGross8]").html(0)
                $("[id*=spanNetIncTax]").html(0);

                $("#txtRebate80C").val(0);
                $("#txtRebate80C_Ded").val(0);
                $("#txtRebate80CCC").val(0);
                $("#txtRebate80CCC_Ded").val(0);
                $("#txtRebate80CCD").val(0);
                $("#txtRebate80CCD_Ded").val(0);
                $("#spanRebate80CTotal").html(0);

                $("#txtRebate80CCD1B").val(0);
                $("#txtRebate80CCD1B_Ded").val(0);
                $("#txtRebate80CCD2").val(0);
                $("#txtRebate80CCD2_Ded").val(0);
                $("#txtRebate80D").val(0);
                $("#txtRebate80D_Ded").val(0);
                $("#txtRebate80G").val(0);
                $("#txtRebate80G_Ded").val(0);
                $("#txtRebate80E").val(0);
                $("#txtRebate80E_Ded").val(0);
                $("#txtRebate80EE").val(0);
                $("#txtRebate80EE_Ded").val(0);
                $("#txtRebate80TTA").val(0);
                $("#txtRebate80TTA_Ded").val(0);
                $("#txtRebateOthers").val(0);
                $("#txtRebateOthers_Ded").val(0);


                $("[id*=spanOnTaxTotalIncome]").html(0);
                $("[id*=spanRebate87A]").html(0); ///point 14
                $("[id*=spanRebateTAX]").html(0); ///point 15
                $("[id*=spanSurcharge]").html(0); ///point 15
                $("[id*=spanCess]").html(0); ///point 16
                $("[id*=txtRebate89]").val(0);
                $("[id*=spanTax]").html(0); ///point 17


                $("[id*=spanFinalTax]").html(0); ///point 21
            }



        }

        function RebateCalculation() {


            var CC = $("#txtRebate80C").val();
            $("#txtRebate80C_Ded").val(CC);
            var onev = returnNumeric($("#txtRebate80C_Ded").val());
            var R80Qly = $("[id*=hdnR80Qly_lmt]").val();
            if (onev > returnNumeric(R80Qly)) {
                onev = 150000;
                $("#txtRebate80C_Ded").val(onev);
            }
            CC = 0;
            CC = $("#txtRebate80CCC").val();
            if (returnNumeric($("[id*=hdnR80CCC_lmt]").val()) > 0) {
                if (CC > returnNumeric($("[id*=hdnR80CCC_lmt]").val())) {
                    CC = $("[id*=hdnR80CCC_lmt]").val();
                }
            }
            $("#txtRebate80CCC_Ded").val(CC);
            CC = 0;
            CC = $("#txtRebate80CCD").val();
            $("#txtRebate80CCD_Ded").val(CC);
            var twov = returnNumeric($("#txtRebate80CCC_Ded").val());
            var thr = returnNumeric($("#txtRebate80CCD_Ded").val());
            var q = onev + twov;

            if (returnNumeric($("[id*=hdnR80Qly_lmt]").val()) < returnNumeric(q)) {
                $("#spanRebate80CTotal").html($("[id*=hdnR80Qly_lmt]").val());
                q = returnNumeric($("[id*=hdnR80Qly_lmt]").val()) - onev;

                $("#txtRebate80CCC_Ded").val(q);
                //q = returnNumeric($("#txtRebate80QlfySalLimit").html());
            }
            else {
                $("#spanRebate80CTotal").html(q);
                //$("[id*=hdnR80Qly_lmt]").val(q)
            }
            var j = 0;
            var j = q + thr;
            if (returnNumeric($("#spanRebate80CTotal").html()) < returnNumeric(j)) {

                q = returnNumeric($("#spanRebate80CTotal").html()) - q;

                $("#txtReb80CCD_Ded").val(q);
            }
            else {
                $("#spanRebate80CTotal").html(j);
            }

            ////////////////////// CCD1B & CCD2 Calculation
            onev = 0;
            twov = 0;
            CC = 0;
            CC = $("#txtRebate80CCD1B").val();
            if (CC > 50000) {
                CC = 50000;
            }
            $("#txtRebate80CCD1B_Ded").val(CC);
            CC = 0;
            CC = $("#txtRebate80CCD2").val();
            $("#txtRebate80CCD2_Ded").val(CC);
            onev = returnNumeric($("#txtRebate80CCD1B_Ded").val());
            twov = returnNumeric($("#txtRebate80CCD2_Ded").val());
            //q = returnNumeric($(".getTotalCal10").html()) + onev + twov;
            ////$(".getTotalCal11").html(q);
            //$("#txtSection80CVariousInvestments").html(q);
            //$("#txtSection80CVariousInvestmentsSH").html(twov);


            onev = 0;
            twov = 0;
            CC = 0;
            CC = $("#txtRebate80D").val();
            if (CC <= parseFloat($("#txtRebate80D_Ded").val())) {
                $("#txtRebate80D_Ded").val(CC);
            }

            onev = 0;
            twov = 0;
            CC = 0;
            CC = $("#txtRebate80G").val();
            q = 0;
            q = $("[id*=hdnR80G_lmt]").val();
            if (CC <= parseFloat(q)) { $("#txtRebate80G_Ded").val(CC); }

            onev = 0;
            twov = 0;
            CC = 0;
            CC = $("#txtRebate80E").val();
            q = 0;
            q = $("[id*=hdnR80E_lmt]").val();
            if (CC <= parseFloat(q)) { $("#txtRebate80E_Ded").val(CC); }

            onev = 0;
            twov = 0;
            CC = 0;
            CC = $("#txtRebate80EE").val();
            q = 0;
            q = $("[id*=hdnR80EE_lmt]").val();
            if (CC <= parseFloat(q)) { $("#txtRebate80EE_Ded").val(CC); }

            onev = 0;
            twov = 0;
            CC = 0;
            CC = $("#txtRebate80TTA").val();
            q = 0;
            q = $("[id*=hdnR80T_lmt]").val();
            if (CC <= parseFloat(q)) { $("#txtRebate80TTA_Ded").val(CC); }

            //onev = 0;
            //twov = 0;
            //CC = 0;
            //CC = $("#txtRebate80EE").val();
            //if (CC < parseFloat($("#txtRebate80EE").val())) { $("#txtRebate80EE_Ded").val(CC); }

            CC = 0
            var r = $("#spanRebate80CTotal").html();
            if (r == '' || r == undefined) {
                r = 0;
            }
            var rcdb = $("#txtRebate80CCD1B_Ded").val();
            if (rcdb == '' || rcdb == undefined) {
                rcdb = 0;
            }
            var rccd = $("#txtRebate80CCD2_Ded").val();
            if (rccd == '' || rccd == undefined) {
                rccd = 0;
            }
            var rd = $("#txtRebate80D_Ded").val();
            if (rd == '' || rd == undefined) {
                rd = 0;
            }



            var rg = $("#txtRebate80G_Ded").val();
            if (rg == '' || rg == undefined) {
                rg = 0;
            }
            var res = $("#txtRebate80E_Ded").val();
            if (res == '' || res == undefined) {
                res = 0;
            }
            var ree = $("#txtRebate80EE_Ded").val();
            if (ree == '' || ree == undefined) {
                ree = 0;
            }
            var rt = $("#txtRebate80TTA_Ded").val();
            if (rt == '' || rt == undefined) {
                rt = 0;
            }
            var ro = $("#txtRebateOthers_Ded").val();
            if (ro == '' || ro == undefined) {
                ro = 0;
            }

            CC = parseFloat(r) + parseFloat(rcdb);
            CC = CC + parseFloat(rccd) + parseFloat(rd);
            CC = CC + parseFloat(rg) + parseFloat(res);
            CC = CC + parseFloat(ree) + parseFloat(rt);
            CC = CC + parseFloat(ro);


            $("#spanRebateTotal").html(CC);
            var hdr = $('#chkUSBAC').prop("checked");
            if (hdr == true) {
                Calculation_BAC115();
            }
            else {
                Calculate_Computation();
            }
        }

        function Calculation_BAC115() {

            var Err = 0;
            var point1 = $("[id*=spanGrossEarn1]").html(); ///point 1
            var point2 = $("[id*=spanSection10Total]").html(); ///point 2
            var point3 = $("[id*=spanGross3]").html(); ///point 3
            var point4 = $("[id*=spanDeduction]").html(); ///point 4
            var point5 = $("[id*=spanGross5]").html(); ///point 5
            var point6 = $("[id*=spanOthInc]").html(); ///point 6
            var point7 = $("[id*=spanIntHome]").html(); ///point 7
            var point8 = $("[id*=spanGross8]").html(); ///point 8

            $('[id*=SHlblBACiNc1]').html(0);
            $('[id*=SHlblBACiNc2]').html(0);
            $('[id*=SHlblBACiNc3]').html(0);
            $('[id*=SHlblBACiNc4]').html(0);
            $('[id*=SHlblBACiNc5]').html(0);
            $('[id*=SHlblBACiNc6]').html(0);
            $('[id*=SHlblBACiNc7]').html(0);

            $('[id*=SHlblBACTax1]').html(0);
            $('[id*=SHlblBACTax2]').html(0);
            $('[id*=SHlblBACTax3]').html(0);
            $('[id*=SHlblBACTax4]').html(0);
            $('[id*=SHlblBACTax5]').html(0);
            $('[id*=SHlblBACTax6]').html(0);
            $('[id*=SHlblBACTax7]').html(0);



            if (parseFloat(point1) == 0) {
                PointZero(1);
                return;
            }

            ////////////point 3 calculation (Balance)
            point3 = (returnNumeric(point1) - returnNumeric(point2)) + returnNumeric($("[id*=txtPreviousSal]").val());
            ///////////point 5 Income chargeable under the head Salaries

            point5 = returnNumeric(point3) - returnNumeric(point4);

            if (parseFloat(point5) <= 0) {
                PointZero(5);
                $("[id*=spanGross3]").html(point3);
                return;
            }
            $("[id*=spanGross5]").html(point5);
            ///////////point  8 Gross Total Income
            point8 = (returnNumeric(point5) + returnNumeric(point6)) - returnNumeric(point7);

            if (parseFloat(point8) <= 0) {
                PointZero(8);

                return;
            }
            else {

                $("[id*=spanGross8]").html(point8);

                var point9 = $("[id*=spanRebateTotal]").html(); ///point 9
                if ($("[id*=spanNetIncTax]").html() <= 0) {
                    $("[id*=spanTAX]").html(0);
                    $("[id*=spanTax]").html(0);
                    $("[id*=spanNetIncTax]").html(0);
                    PointZero(8);

                }
                //var point10 = $("[id*=spanRebateTotal]").html(); ///point 10
                //var point11 = $("[id*=lblAggregateoftax]").html(); ///point 11

                var point18 = $("[id*=txtRebate89]").val(); ///point 18
                var point19 = $("[id*=spanTDS]").html(); ///point 19
                var point20 = $("[id*=txtPreTDS]").val(); ///point 20


                var point12 = 0;
                var point13 = 0;
                var point14 = 0;
                var point15 = 0;
                var point16 = 0;
                var point17 = 0;

                var point21 = 0;
                var pointSur = 0;
            }

            if (point9 == '') {
                point9 = 0;
            }

            //if (point10 == '') {
            //    point10 = 0;
            //}

            ///////////point 11 Aggregate of tax rebates and relief
            //point10 = returnNumeric(point9) + returnNumeric(point10);

            //////////point 12 Net Income
            point12 = returnNumeric(point8) - returnNumeric(point9);

            /////////////********************** Calculate Income Tax **************************************////////////////////

            var txtNetIncome = point12; //label

            /////////tax on total income tax Calculation

            var lblSlab1 = $('[id*=SHlblBACSlab1]').html();
            var lblSlab2 = $('[id*=SHlblBACSlab2]').html();
            var lblSlab3 = $('[id*=SHlblBACSlab3]').html();
            var lblSlab4 = $('[id*=SHlblBACSlab4]').html();
            var lblSlab5 = $('[id*=SHlblBACSlab5]').html();
            var lblSlab6 = $('[id*=SHlblBACSlab6]').html();
            var lblSlab7 = $('[id*=SHlblBACSlab7]').html();

            var lblSlabPer1 = $('[id*=SHlblPer1]').html();
            var lblSlabPer2 = $('[id*=SHlblPer2]').html();
            var lblSlabPer3 = $('[id*=SHlblPer3]').html();
            var lblSlabPer4 = $('[id*=SHlblPer4]').html();
            var lblSlabPer5 = $('[id*=SHlblPer5]').html();
            var lblSlabPer6 = $('[id*=SHlblPer6]').html();
            var lblSlabPer7 = $('[id*=SHlblPer7]').html();



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


            //////////////0
            if (parseFloat(txtNetIncome) <= parseFloat(lblSlab1)) {
                IncomeTax = txtNetIncome;
                lblIncome1 = txtNetIncome;
            }


            ///////////5%
            if (parseFloat(txtNetIncome) > parseFloat(lblSlab1) && parseFloat(txtNetIncome) <= parseFloat(lblSlab2)) {
                lblIncome1 = lblSlab1;
                lblIncome2 = parseFloat(txtNetIncome) - parseFloat(lblSlab1);
                lblIncomeTax2 = (parseFloat(lblIncome2) * lblSlabPer2) / 100;
            }
            ///////////10%
            if (parseFloat(txtNetIncome) > parseFloat(lblSlab2) && parseFloat(txtNetIncome) <= parseFloat(lblSlab3)) {
                lblIncome1 = lblSlab1;
                lblIncome2 = parseFloat(lblSlab2) - parseFloat(lblSlab1);
                lblIncomeTax2 = (parseFloat(lblIncome2) * lblSlabPer2) / 100;
                lblIncome3 = parseFloat(txtNetIncome) - parseFloat(lblSlab2);
                lblIncomeTax3 = (parseFloat(lblIncome3) * lblSlabPer3) / 100;
            }
            ///////////15%
            if (parseFloat(txtNetIncome) > parseFloat(lblSlab3) && parseFloat(txtNetIncome) <= parseFloat(lblSlab4)) {
                lblIncome1 = lblSlab1;
                lblIncome2 = parseFloat(lblSlab2) - parseFloat(lblSlab1);
                lblIncomeTax2 = (parseFloat(lblIncome2) * lblSlabPer2) / 100;
                lblIncome3 = parseFloat(lblSlab3) - parseFloat(lblSlab2);
                lblIncomeTax3 = (parseFloat(lblIncome3) * lblSlabPer3) / 100;
                lblIncome4 = parseFloat(txtNetIncome) - parseFloat(lblSlab3);
                lblIncomeTax4 = (parseFloat(lblIncome4) * lblSlabPer4) / 100;
            }

            ///////////20%
            if (parseFloat(txtNetIncome) > parseFloat(lblSlab4) && parseFloat(txtNetIncome) <= parseFloat(lblSlab5)) {
                lblIncome1 = lblSlab1;
                lblIncome2 = parseFloat(lblSlab2) - parseFloat(lblSlab1);
                lblIncomeTax2 = (parseFloat(lblIncome2) * lblSlabPer2) / 100;
                lblIncome3 = parseFloat(lblSlab3) - parseFloat(lblSlab2);
                lblIncomeTax3 = (parseFloat(lblIncome3) * lblSlabPer3) / 100;
                lblIncome4 = parseFloat(lblSlab4) - parseFloat(lblSlab3);
                lblIncomeTax4 = (parseFloat(lblIncome4) * lblSlabPer4) / 100;
                lblIncome5 = parseFloat(txtNetIncome) - parseFloat(lblSlab4);
                lblIncomeTax5 = (parseFloat(lblIncome5) * lblSlabPer5) / 100;
            }

            ///////////25%
            if (parseFloat(txtNetIncome) > parseFloat(lblSlab5) && parseFloat(txtNetIncome) <= parseFloat(lblSlab6)) {
                lblIncome1 = lblSlab1;
                lblIncome2 = parseFloat(lblSlab2) - parseFloat(lblSlab1);
                lblIncomeTax2 = (parseFloat(lblIncome2) * lblSlabPer2) / 100;
                lblIncome3 = parseFloat(lblSlab3) - parseFloat(lblSlab2);
                lblIncomeTax3 = (parseFloat(lblIncome3) * lblSlabPer3) / 100;
                lblIncome4 = parseFloat(lblSlab4) - parseFloat(lblSlab3);
                lblIncomeTax4 = (parseFloat(lblIncome4) * lblSlabPer4) / 100;
                lblIncome5 = parseFloat(lblSlab5) - parseFloat(lblSlab4);
                lblIncomeTax5 = (parseFloat(lblIncome5) * lblSlabPer5) / 100;
                lblIncome6 = parseFloat(txtNetIncome) - parseFloat(lblSlab5);
                lblIncomeTax6 = (parseFloat(lblIncome6) * lblSlabPer6) / 100;
            }


            ///////////30%
            if (parseFloat(txtNetIncome) > parseFloat(lblSlab6) && parseFloat(txtNetIncome) <= parseFloat(lblSlab7)) {
                lblIncome1 = lblSlab1;
                lblIncome2 = parseFloat(lblSlab2) - parseFloat(lblSlab1);
                lblIncomeTax2 = (parseFloat(lblIncome2) * lblSlabPer2) / 100;
                lblIncome3 = parseFloat(lblSlab3) - parseFloat(lblSlab2);
                lblIncomeTax3 = (parseFloat(lblIncome3) * lblSlabPer3) / 100;
                lblIncome4 = parseFloat(lblSlab4) - parseFloat(lblSlab3);
                lblIncomeTax4 = (parseFloat(lblIncome4) * lblSlabPer4) / 100;
                lblIncome5 = parseFloat(lblSlab5) - parseFloat(lblSlab4);
                lblIncomeTax5 = (parseFloat(lblIncome5) * lblSlabPer5) / 100;
                lblIncome6 = parseFloat(lblSlab6) - parseFloat(lblSlab5);
                lblIncomeTax6 = (parseFloat(lblIncome6) * lblSlabPer6) / 100;
                lblIncome7 = parseFloat(txtNetIncome) - parseFloat(lblSlab6);
                lblIncomeTax7 = (parseFloat(lblIncome7) * lblSlabPer7) / 100;

            }


            $('[id*=SHlblBACiNc1]').html(Math.round(lblIncome1));
            $('[id*=SHlblBACiNc2]').html(Math.round(lblIncome2));
            $('[id*=SHlblBACiNc3]').html(Math.round(lblIncome3));
            $('[id*=SHlblBACiNc4]').html(Math.round(lblIncome4));
            $('[id*=SHlblBACiNc5]').html(Math.round(lblIncome5));
            $('[id*=SHlblBACiNc6]').html(Math.round(lblIncome6));
            $('[id*=SHlblBACiNc7]').html(Math.round(lblIncome7));
            $('[id*=SHlblBACTax1]').html(Math.round(lblIncomeTax1));
            $('[id*=SHlblBACTax2]').html(Math.round(lblIncomeTax2));
            $('[id*=SHlblBACTax3]').html(Math.round(lblIncomeTax3));
            $('[id*=SHlblBACTax4]').html(Math.round(lblIncomeTax4));
            $('[id*=SHlblBACTax5]').html(Math.round(lblIncomeTax5));
            $('[id*=SHlblBACTax6]').html(Math.round(lblIncomeTax6));
            $('[id*=SHlblBACTax7]').html(Math.round(lblIncomeTax7));

            $('[id*=SHlblBACIncomeTaxTotal]').html(Math.round(parseFloat(lblIncomeTax2) + parseFloat(lblIncomeTax3) + parseFloat(lblIncomeTax4) + parseFloat(lblIncomeTax5) + parseFloat(lblIncomeTax6) + parseFloat(lblIncomeTax7)));


            point13 = $('[id*=SHlblBACIncomeTaxTotal]').html();



            /////////////////////////////// ************************************* End of IncomeTax Calculation ******************////////////////////////////////



            //////////point 14 87 A
            var Sallimitfor87A = 500000;
            var limitfor87A = 0;
            limitfor87A = parseFloat($("[id*=hdnlimitfor87A]").val());

            if (parseFloat(point13) <= Sallimitfor87A) {
                if (parseFloat(point13) >= parseFloat(limitfor87A)) { point14 = limitfor87A; }
                else { point14 = point13; }
            } else { point14 = 0; }
            point14 = Math.round(point14);

            point15 = parseFloat(point13) - parseFloat(point14);
            ///////////point 15 16 17 18 calculation related details
            var hdnSurcharge = 0, hdnCessper = 0, hdnHcessper = 0, hdnHealthPer = 0;
            hdnCessper = $("[id*=hdnCessPer]").val();
            hdnHcessper = $("[id*=hdnHcessper]").val();
            hdnHealthPer = $("[id*=hdnHealthPer]").val();


            //////////point 15 Tax payable and surcharge

            var Fyr = '';
            var surchargeType = '';
            Surcharge = 0;
            Surcharge115 = 0;
            if (point12 > 0) {
                Fyr = $("[id*=ddlFinancialYear] :selected").text();
                if (parseFloat(Fyr.substring(0, 4)) > 2016) {

                    ////// 20_21 onwards

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
                        //point15 = point15 + parseFloat(Surcharge);
                        pointSur = parseFloat(Surcharge);
                    }

                    //2022


                }
                else {
                    //  point15 = point15 + ((point13 * parseFloat($("[id*=hdnSurchargePercentage]").val())) / 100);
                    pointSur = ((point13 * parseFloat($("[id*=hdnSurchargePercentage]").val())) / 100);
                }

                point15 = Math.round(point15);
                var p15 = 0;
                p15 = parseFloat(point15) + parseFloat(pointSur)
                //////////point 16 (a) Health & Education Cess
                var CAmt = 0;
                hdnCessper = hdnCessper + hdnHcessper + hdnHealthPer;
                //CAmt = Math.round((parseFloat(point15) * parseFloat(hdnCessPer)) / 100);
                CAmt = Math.round((parseFloat(p15) * parseFloat(hdnCessper)) / 100);
                /////////point 17 (b)Higher Education Cess
                //var Cess = 0;

                //Cess = parseFloat(hdnHcessper) + parseFloat(hdnHealthPer)
                ////CAmt = CAmt +  Math.round((parseFloat(point15) * parseFloat(Cess)) / 100);
                //CAmt = CAmt + Math.round((parseFloat(p15) * parseFloat(Cess)) / 100);
                //HeathCess = hdnHealthPer;
                point16 = CAmt;
                p15 = 0;
                CAmt = 0;
                Cess = 0;
                /////////point 17(b) Health Cess
                //point17 = point17 + Math.round((parseFloat(point15) * parseFloat(hdnHealthPer)) / 100);
                point17 = (returnNumeric(point15) + returnNumeric(pointSur) + returnNumeric(point16)) - returnNumeric(point17);
                point18 = (returnNumeric(point17)) - (returnNumeric(point18));
                point21 = returnNumeric(point18) - (returnNumeric(point19) + returnNumeric(point20));


                ////////////set values
                $("[id*=spanGross3]").html(point3); ///point 3
                $("[id*=spanGross5]").html(point5); ///point 5
                $("[id*=spanGross8]").html(point8); ///point 8
                //$("[id*=spanNetIncTax]").html(point11); ///point 11
                $("[id*=spanNetIncTax]").html(point12); ///point 12
                $("[id*=spanOnTaxTotalIncome]").html(point13); ///point 13
                $("[id*=spanRebate87A]").html(point14); ///point 14
                $("[id*=spanRebateTAX]").html(point15); ///point 15
                $("[id*=spanSurcharge]").html(pointSur); ///point 15
                $("[id*=spanCess]").html(point16); ///point 16

                $("[id*=spanTax]").html(point18); ///point 17


                $("[id*=spanFinalTax]").html(point21); ///point 21




            }
            Auto_Saving();
        }

        function Auto_Saving() {
            var p1 = $("[id*=spanGrossEarn1]").html(); ///point 1
            var pp11 = $("[id*=spanTotalEarn]").html(); ///point 1
            var pp12 = $("[id*=spanTotalPerk]").html(); ///point 1
            var pp13 = $("[id*=txtGrossProfits_C]").html(); ///point 1

            var p2 = $("[id*=spanSection10Total]").html(); ///point 2
            var tr = $("[id*=txtTravel]").val();
            var gy = $("[id*=txtGratuity]").val();
            var ps = $("[id*=txtPension]").val();
            var lv = $("[id*=txtLeave]").val();
            var os = $("[id*=txtSOthers]").val();
            var hra = $("[id*=txtHRAEXMPT]").val();
            var R80C = $("#txtRebate80C").val();
            var R80C_D = $("#txtRebate80C_Ded").val();
            var R80C3 = $("#txtRebate80CCC").val();
            var R80C3_D = $("#txtRebate80CCC_Ded").val();

            var R80CD = $("#txtRebate80CCD").val();
            var R80CD_D = $("#txtRebate80CCD_Ded").val();
            var R80CB = $("#txtRebate80CCD1B").val();
            var R80CB_D = $("#txtRebate80CCD1B_Ded").val();

            var R80C2 = $("#txtRebate80CCD2").val();
            var R80C2_D = $("#txtRebate80CCD2_Ded").val();
            var R80D = $("#txtRebate80D").val();
            var R80D_D = $("#txtRebate80D_Ded").val()
            var R80G = $("#txtRebate80G").val();
            var R80G_D = $("#txtRebate80G_Ded").val();
            var R80E = $("#txtRebate80E").val();
            var R80E_D = $("#txtRebate80E_Ded").val();
            var R80EE = $("#txtRebate80EE").val();
            var R80EE_D = $("#txtRebate80EE_Ded").val();
            var R80T = $("#txtRebate80TTA").val();
            var R80T_D = $("#txtRebate80TTA_Ded").val();
            var R80O = $("#txtRebateOthers").val()
            var R80O_D = $("#txtRebateOthers_Ded").val()



            var p3 = $("[id*=spanGross3]").html(); ///point 3
            var p31 = $("[id*=txtEntertainment]").val();
            var p32 = $("[id*=txtPTax]").val();
            var p33 = $("[id*=txtSded]").val();
            var p4 = $("[id*=spanDeduction]").html();
            var p5 = $("[id*=spanGross5]").html(); ///point 5
            var p6 = $("[id*=txtIntHome]").val();
            var p7 = $("[id*=txtOthInc]").val();
            var p8 = $("[id*=spanGross8]").html(); ///point 8
            var p9 = $("[id*=spanRebateTotal]").html();

            var p12 = $("[id*=spanNetIncTax]").html(); ///point 12
            var p13 = $("[id*=spanOnTaxTotalIncome]").html(); ///point 13
            var p14 = $("[id*=spanRebate87A]").html(); ///point 14
            var p15 = $("[id*=spanRebateTAX]").html(); ///point 15
            var pSur = $("[id*=spanSurcharge]").html(); ///point 15
            var p16 = $("[id*=spanCess]").html(); ///point 16
            var p17 = $("[id*=txtRebate89]").val();
            var p18 = $("[id*=spanTax]").html(); ///point 17
            var p19 = $("[id*=spanTDS]").html();
            var p20 = $("[id*=txtPreTDS]").val();
            var p21 = $("[id*=spanFinalTax]").html(); ///point 21

            if (pp13 == '') {
                pp13 = 0;
            }
            if (pp12 == '') {
                pp12 = 0;
            }

            if (p13 == '') {
                p13 = 0;
            }

            if (p2 == '') {
                p2 = 0;
            }
            if (p4 == '') {
                p4 = 0;
            }

            if (p6 == '') {
                p6 = 0;
            }

            if (p7 == '') {
                p7 = 0;
            }

            if (p9 == '') {
                p9 = 0;
            }

            if (tr == '') {
                tr = 0;
            }
            if (gy == '') {
                gy = 0;
            }
            if (ps == '') {
                ps = 0;
            }
            if (os == '') {
                os = 0;
            }
            if (hra == '') {
                hra = 0;
            }
            if (p31 == '') {
                p31 = 0;
            }
            if (p32 == '') {
                p32 = 0;
            }
            if (p33 == '') {
                p33 = 0;
            }
            if (p20 == '') {
                p20 = 0;
            }
            if (p16 == '') {
                p16 = 0;
            }
            if (p17 == '') {
                p17 = 0;
            }
            if (p19 == '') {
                p19 = 0;
            }
            if (pSur == '') {
                pSur = 0;
            }


            /////////// Rebates

            if (R80C == '') {
                R80C = 0;
            }
            if (R80C_D == '') {
                R80C_D = 0;
            }
            if (R80C3 == '') {
                R80C3 = 0;
            }
            if (R80C3_D == '') {
                R80C3_D = 0;
            }
            if (R80CD == '') {
                R80CD = 0;
            }
            if (R80CD_D == '') {
                R80CD_D = 0;
            }
            if (R80CB == '') {
                R80CB = 0;
            }
            if (R80CB_D == '') {
                R80CB_D = 0;
            }
            if (R80C2 == '') {
                R80C2 = 0;
            }
            if (R80C2_D == '') {
                R80C2_D = 0;
            }
            if (R80D == '') {
                R80D = 0;
            }
            if (R80D_D == '') {
                R80D_D = 0;
            }
            if (R80G == '') {
                R80G = 0;
            }
            if (R80G_D == '') {
                R80G_D = 0;
            }
            if (R80E == '') {
                R80E = 0;
            }
            if (R80E_D == '') {
                R80E_D = 0;
            }
            if (R80EE == '') {
                R80EE = 0;
            }
            if (R80EE_D == '') {
                R80EE_D = 0;
            }
            if (R80T == '') {
                R80T = 0;
            }
            if (R80T_D == '') {
                R80T_D = 0;
            }
            if (R80O == '') {
                R80O = 0;
            }
            if (R80O_D == '') {
                R80O_D = 0;
            }


            var eid = $("[id*=hdnEmpID]").val();
            // var allList = { grossmonthlyList: [], perqusiteslist: [] };
            var sal = '';
            var ridx = 3;
            $('#tblMonthlySalary > tbody  > tr').each(function () {
                var row = $(this).closest("tr");
                var rIndex = $(this).closest("tr")[0].sectionRowIndex;

                //if (rIndex < 10) {
                ridx = ridx + 1;
                //}
                //if (rIndex > 9) {
                //    ridx = ridx + 1;
                //}
                var Mth = $("#hdnMthSal" + ridx, row).val();
                var B = $("#txtBasic" + ridx, row).val();
                var D = $("#txtDA" + ridx, row).val();
                var H = $("#txtHRA" + ridx, row).val();
                var O = $("#txtOthers" + ridx, row).val();
                var T = $("#txtMonth" + ridx, row).val();
                var hr = $("#hdnHrr" + ridx, row).val();
                //////////////////// ************************* Pass HRR values
                if (B == '') {
                    B = 0;
                }
                if (D == '') {
                    D = 0;
                }
                if (H == '') {
                    H = 0;
                }
                if (O == '') {
                    O = 0;
                }
                if (T == '') {
                    T = 0;
                }
                if (hr == '') {
                    hr = 0;
                }

                if (Mth > 0) {
                    sal = sal + Mth + '~' + B + '~' + D + '~' + H + '~' + O + '~' + T + '~' + hr + '^'
                }
                if (rIndex == 8) {///// reset for Jan month
                    ridx = 0;
                }
            });

            /////// Section 10

            var sec = tr + '~' + ps + '~' + gy + '~' + lv + '~' + os + '~' + hra

            var pq = '';
            /////////point 1 perquisites
            //$("#tblPerquisites tbody tr").each(function () {
            $('#tblPerquisites > tbody  > tr').each(function () {
                row = $(this).closest("tr");
                var sr = row.find('td:eq(0)').text();
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

                    if (EmployeePaid_Amt == '') {
                        EmployeePaid_Amt = 0;
                    }
                    if (Perquisites_Value == '') {
                        Perquisites_Value = 0;
                    }
                    if (Taxable_Amt == '') {
                        Taxable_Amt = 0;
                    }

                    pq = pq + sr + '~' + d + '~' + EmployeePaid_Amt + '~' + Perquisites_Value + '~' + Taxable_Amt + '^';

                }
            });


            var Rent = $("[id*=Rent_Payment]").val();
            var Pl1 = $("[id*=PAN_landlord1]").val();
            var Nl1 = $("[id*=Name_landlord1]").val();
            var Pl2 = $("[id*=PAN_landlord2]").val();
            var Nl2 = $("[id*=Name_landlord2]").val();
            var Pl3 = $("[id*=PAN_landlord3]").val();
            var Nl3 = $("[id*=Name_landlord3]").val();
            var Pl4 = $("[id*=PAN_landlord4]").val();
            var Nl4 = $("[id*=Name_landlord4]").val();
            var Il = $("[id*=Interest_lender]").val();
            var Pld1 = $("[id*=PAN_lender1]").val();
            var Nld1 = $("[id*=Name_lender1]").val();
            var Pld2 = $("[id*=PAN_lender2]").val();
            var Nld2 = $("[id*=Name_lender2]").val();
            var Pld3 = $("[id*=PAN_lender3]").val();
            var Nld3 = $("[id*=Name_lender3]").val();
            var Pld4 = $("[id*=PAN_lender4]").val();
            var Nld4 = $("[id*=Name_lender4]").val();
            var Csf = $("[id*=Contributions_superannuation_fund]").val();
            var Nsf = $("[id*=Name_superannuation_fund]").val();
            var FDT_sf = $("[id*=Frm_DT_superannuation_fund]").val();
            var TDT_sf = $("[id*=TO_DT_superannuation_fund]").val();
            var pi_sf = $("[id*=principal_interest_superannuation_fund]").val();
            var Rdt_3yrs = $("[id*=Rate_deduction_tax_3yrs]").val();
            var Rpy_sf = $("[id*=Repayment_superannuation_fund]").val();
            var TI_sf = $("[id*=Total_Income_superannuation_fund]").val()

            var rec = p1 + '~' + pp11 + '~' + pp12 + '~' + pp13 + '~' + p2 + '~' + p3 + '~' + p31 + '~' + p32 + '~' + p33 + '~' + p4 + '~' + p5 + '~' + p6 + '~' + p7 + '~' + p8 + '~' + p9
            //// '6006060~1200000.00~5803560~1553568~                    300000.00~5706060~0.00~         2500.00~    50000.00~   52500.00~   5653560~    0.00~   0.00~       5653560~-150000.00
            rec = rec + '~' + p12 + '~' + p13 + '~' + p14 + '~' + p15 + '~' + pSur + '~' + p16 + '~' + p17 + '~' + p18 + '~' + p19 + '~' + p20 + '~' + p21
            //// ~5803560~                   1553568~    0~          1553568~~~                          0.00        ~1553568~   11000.00~       0.00~1542568'

            var rb = R80C + '~' + R80C_D + '~' + R80C3 + '~' + R80C3_D + '~' + R80CD + '~' + R80CD_D + '~' + R80CB + '~' + R80CB_D + '~' + R80C2 + '~' + R80C2_D + '~' + R80D + '~' + R80D_D + '~' + R80G + '~' + R80G_D;
            rb = rb + '~' + R80E + '~' + R80E_D + '~' + R80EE + '~' + R80EE_D + '~' + R80T + '~' + R80T_D + '~' + R80O + '~' + R80O_D;

            $.ajax({
                type: "POST",
                url: "../../TDS/BTStrp/Handler/TDSComputationV2.asmx/SaveComputation",
                data: '{rec:"' + rec + '",rb:"' + rb + '", sal:"' + sal + '", pq:"' + pq + '", sec:"' + sec + '", Eid:' + eid + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {

                    var xmlDoc = $.parseXML(msg.d);
                    var xml = $(xmlDoc);
                    var myList = xml.find("Table")

                },
                failure: function (response) {
                    showWarningAlert('Cant Connect to Server' + response.d);

                    Blockloaderhide();
                },
                error: function (response) {
                    showWarningAlert('Error Occoured ' + response.d);

                    Blockloaderhide();
                }
            });
        }
        function getEmployeeList() {
            var tobj = {
                CompanyID: companyid,
                PageIndex: pgindex,
                PageSize: 300,
                SearchVal: $('#txtEmployeeName').val(),
                ConnectionString: $("[id*=hdnConnString]").val(),
                FilterById: (($('[id*=ddlsearch]').val() == '' || $('[id*=ddlsearch]').val() == undefined || $('[id*=ddlsearch]').val() == null) ? '0' : $('[id*=ddlsearch]').val())
            };
            tobj = JSON.stringify({ 'tobj': tobj });

            ServerServiceToGetData(tobj, baseUrl + 'GetAllEmployeeComputionSummaryV2');
        }

        function ServerServiceToGetData(data, url) {
            $.ajax({
                url: url,
                data: data,
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (response) {
                    getEmployeeName(response);
                },
                error: function (response) {
                    alert(response.responseText);
                },
                failure: function (response) {
                    alert(response.responseText);
                }
            });
        }
        var empTable;
        function getEmployeeName(response) {
            Blockloadershow();
            var tblAllEmpComputationGrid = jQuery.parseJSON(response.d);
            var TDSURL = '<%=ResolveUrl("../regular/TdsComputationV2.aspx") %>';
            var hiddenEmpID = $("[id*=hdnEmpID]").val();

            if (empTable) {
                // Clear existing data and update with new data
                empTable.setData(tblAllEmpComputationGrid);
            } else {
                // Initialize Tabulator
                empTable = new Tabulator("#EmployeeListTable", {
                    frozenRows: 2,
                    data: tblAllEmpComputationGrid,
                    columns: [
                        { title: "No.", field: "SrNo", hozAlign: "center", formatter: "rownum", width: 70 },
                        { title: "Employee", field: "FirstName", width: 200 },
                        { title: "PanNo", field: "PanNumber" }
                    ],
                    addRowPos: "top",
                    history: true,
                    layout: "fitDataStretch",
                    pagination: "local",
                    tooltips: true,
                    debugEventsExternal: true,
                    height: "1700px",
                    rowHeight: 60,
                    renderHorizontal: "basic",
                    paginationSize: 10,
                    selectable: 1,
                    paginationSizeSelector: [100, 350, 1000, 2500, 5000],
                    movableColumns: true,
                    selectableRows: true, //make rows selectable
                    paginationCounter: "rows",
                    paginationElement: document.getElementById("custom-pagination"),
                    virtualDom: true,  // Enable virtual DOM for better performance on large data sets
                    virtualDomBuffer: 300,
                    rowClick: function (e, row) {
                        row.toggleSelect(); //toggle row selected state on row click
                    }
                });
              
                empTable.on("rowClick", function (e, row) {
                    $(".tabulator-row").removeClass("selected-row");
                    row.getElement().classList.add("selected-row");
                    var employeeId = row.getData().Employee_ID;
                    $("[id*=hdnEmpID]").val(employeeId);  // Set the hidden field value
                    GetEmployeeDetails(employeeId);  // Call function to get employee details
                });
            }
            //empTable.on("dataLoaded", function () {
            //    var employeeIDToSelect = $("[id*=hdnEmpID]").val();
            //    for (let i = 0; i < tblAllEmpComputationGrid.length; i++) {
            //        let employeeIdString = String(tblAllEmpComputationGrid[i].Employee_ID);
            //        if (employeeIdString === employeeIDToSelect) {
            //            empTable.selectRow(i); // Select the row by index
            //            GetEmployeeDetails(employeeIDToSelect); // Fetch employee details
            //            break; // Exit loop once found
            //        }
            //    }
            //});

            document.getElementById("txtEmployeeName").addEventListener("keyup", function () {
                var searchTerm = this.value;
                empTable.clearFilter();
                empTable.setFilter([
                    { field: "FirstName", type: "like", value: searchTerm }
                ]);
            });
            //document.getElementById("resetBtn").addEventListener("click", function () {
            //    $("txtEmployeeName").value = ''; // Clear the input field
            //    console.log("Resetting search input.");
            //});
            Blockloaderhide();
        }
     
        ///////////////////////////// Pending work

        ///// Save rebate others & qualifing amount.
        ///// save last 3 rows of rent.
        ///// Get Sec10 val from Old to New
       

    </script>

    <style type="text/css">

         #custom-pagination {
        margin-bottom: 10px;
        padding: 4px 2px;
        border-top: 1px solid #ddd;
        background-color: #f9f9f9;
        text-align: right;
        color: #3759d7;
        font-weight: 600;
        white-space: nowrap;
        display: flex;
       justify-content: flex-end; 
       align-items: center;
    }

    #custom-pagination select {
        padding: 3px;
        border-radius: 4px;
        border: 1px solid #ccc;
        background-color: #fff;
        font-weight: 400;
        color: #333;
        outline: none;
    }

    #custom-pagination button {
        padding: 2px 6px;
        margin-left: 0px;
        border-radius: 4px;
        border: 1px solid #ccc;
        background-color: #3759d7;
        color: #fff;
        font-weight: 400;
        cursor: pointer;
        transition: background-color 0.2s ease;
    }

    #custom-pagination button:disabled {
        background-color: #ddd;
        cursor: not-allowed;
    }

    #custom-pagination button:hover:not(:disabled) {
        background-color: #2b4bb1;
    }

    #custom-pagination .tabulator-page.active {
        background-color: #ffdc34;
        color: #333;
    }

    #custom-pagination label {
        font-weight: 300;
        margin-right: 6px;
        color: #333;
    }
   
        .form-group {
            margin-bottom: 0.25em !important;
        }

        .padding5 {
            padding: 5px;
        }

        .parent-color {
            background-color: #EBF4FD;
            font-weight: bolder !important;
            font-size: 18px;
        }

        .card {
            padding-top: 0%;
            margin-left: 1%;
            margin-right: 1%;
        }



        .AutoEntry {
            text-align: right;
        }


        switch {
            position: relative;
            display: inline-block;
            width: 60px;
            height: 34px;
        }

        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            -webkit-transition: .4s;
            transition: .4s;
            width: 60px;
            height: 33px;
        }

            .slider:before {
                position: absolute;
                content: "";
                height: 26px;
                width: 26px;
                left: 4px;
                bottom: 4px;
                background-color: white;
                -webkit-transition: .4s;
                transition: .4s;
            }

        input:checked + .slider {
            background-color: #2196F3;
        }

        input:focus + .slider {
            box-shadow: 0 0 1px #2196F3;
        }

        input:checked + .slider:before {
            -webkit-transform: translateX(26px);
            -ms-transform: translateX(26px);
            transform: translateX(26px);
        }

        /* Rounded sliders */
        .slider.round {
            border-radius: 34px;
        }

            .slider.round:before {
                border-radius: 50%;
            }


.Leftcard {
    padding: 10px; /* Padding inside the card */
    border: 1px solid #ccc; /* Light border for the card */
    border-radius: 5px; /* Rounded corners for the card */
    background-color: #fff; /* White background for the card */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Slight shadow for depth */
}

.form {
    display: flex; /* Use flexbox for alignment */
    align-items: center; /* Center items vertically */
    margin-bottom: 20px; /* Space below the form */
}

.input-container {
    position: relative; /* Allows positioning of the icon inside the input */
    flex: 1; /* Allow input container to take available space */
}

.input-container i {
    position: absolute; /* Position the icon absolutely within the input container */
    left: 10px; /* Distance from the left side of the input */
    top: 50%; /* Center vertically */
    transform: translateY(-50%); /* Adjust for vertical centering */
    color: #999; /* Color of the search icon */
    pointer-events: none; /* Prevents mouse events on the icon */
}

.form-control {
    width: 100%; /* Make input take full width of the container */
    padding: 10px 10px 10px 40px; /* Add left padding for space for the icon */
    border: 1px solid #ccc; /* Border for the input */
    border-radius: 4px; /* Rounded corners for the input */
    font-size: 16px; /* Font size for input */
}

.btn {
    margin-left: 10px; /* Space between input and button */
}

.btn:hover {
    background-color: #353131; /* Darker red on hover */
}

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:HiddenField ID="hdnCompanyid" runat="server" />
    <asp:HiddenField ID="hdnPanVerified" runat="server" />
    <asp:HiddenField ID="hdnisNri" runat="server" />
    <asp:HiddenField ID="hdnQuater" runat="server" />
    <asp:HiddenField ID="hdnSel" runat="server" />
    <asp:HiddenField ID="hdnConnString" runat="server" />
    <asp:HiddenField ID="hdnPages" runat="server" />
    <asp:HiddenField ID="hdnMis" runat="server" />
    <asp:HiddenField ID="hdnForm" runat="server" />
    <asp:HiddenField ID="hdnLnk" runat="server" />
    <asp:HiddenField ID="hdnCessPer" runat="server" />
    <asp:HiddenField ID="hdnHcessper" runat="server" />
    <asp:HiddenField ID="hdnHealthPer" runat="server" />
    <asp:HiddenField ID="hdnlimitfor87A" runat="server" />
    <asp:HiddenField ID="hdnEmpID" runat="server" />
    <asp:HiddenField ID="hdnR80Qly_lmt" runat="server" Value="150000" />
    <asp:HiddenField ID="hdnDate" runat="server" />


    <div class="content-header">

        <div class="container-fluid">
            <div class="row mb-0">

                <h5>

                    <span class="font-weight-bold" style="font-size: 20px; padding-left: 12px;">TDS Computations</span></h5>
                <div class="col-sm-10">
                    <div id="dvButton" style="float: right;">
                        <button id="btnBack" type="button" class="btn btn-outline-success legitRipple  btn-sm"><i class="fa fa-arrow-left mr-2 fa-1x"></i>Back</button>
                    </div>
                    <!-- /.col -->
                </div>

            </div>

        </div>

    </div>

    <div class="row">
        <div class="col-4">
            <div class="card Leftcard">
    <div class="form">
        <div class="input-container">
            <i class="fa fa-search"></i>
            <input type="text" id="txtEmployeeName" class="form-control form-input" placeholder="Search employee..." />
        </div>
        <button id="resetBtn" class="btn btn-secondary">Reset</button>
    </div>
    <div id="custom-pagination"></div>
    <div id="EmployeeListTable" class="table table-hover table-xs font-size-base"></div>
</div>

        </div>

    <div class="col-8">


   <div class="card card-body" style="padding: 10px; max-width: 100%;">
    <div class="row mb-2">
        <div class="col-md-6 d-flex align-items-center">
            <h5 class="mb-0 font-weight-bold">Employee Details</h5> <!-- Bold and slightly larger -->
        </div>
        <div class="col-md-6 text-right">
            <button id="btnImport" type="button" class="btn btn-outline-success btn-sm">
                Export to PDF
            </button>
            <button id="btnUpload" name="btnUpload" onclick="modal_Viewemail()" class="btn btn-outline-success btn-sm ml-2" type="button">
                Email Computation
            </button>
        </div>
    </div>

    <div class="row mb-2">
        <div class="col-md-6 d-flex align-items-center">
            <label for="txtEmployee" class="col-form-label mr-2 font-weight-bold h6">Employee:</label> <!-- Bold and larger -->
            <input id="txtEmployee" type="text" class="form-control form-control-border" style="max-width: 350px;" readonly />
        </div>
        <div class="col-md-6 d-flex align-items-center">
            <label for="txtPanNo" class="col-form-label mr-2 font-weight-bold h6">Pan No:</label> <!-- Bold and larger -->
            <input id="txtPanNo" type="text" class="form-control form-control-border" style="max-width: 350px;" readonly />
        </div>
    </div>

    <div class="row mb-2">
        <div class="col-md-6 d-flex align-items-center">
            <label for="txt_FromDate" class="col-form-label mr-2 font-weight-bold h6">From dt:</label> <!-- Bold and larger -->
            <input type="date" id="txt_FromDate" class="form-control form-control-border" style="max-width: 350px;" />
        </div>
        <div class="col-md-6 d-flex align-items-center">
            <label for="txt_ToDate" class="col-form-label mr-2 font-weight-bold h6">To dt:</label> <!-- Bold and larger -->
            <input type="date" id="txt_ToDate" class="form-control form-control-border" style="max-width: 350px;" />
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 d-flex align-items-center justify-content-end">
            <input id="chkUSBAC" type="checkbox" class="mr-2" />
            <label for="chkUSBAC" class="font-weight h6 text-white" style="background-color:forestgreen;">U/s 115BAC - New Regime</label> <!-- Bold, white, and aligned -->
        </div>
    </div>
</div>


                <div class="card">

                    <div class="card-header">
                        <h3 class="card-title" style="font-size: 21px;">Details for Income and tax calculation</h3>
                    </div>




                    <table id="detail_table" class="table table-hover table-xs font-size-base" style="width: 100%;">
                        <thead>
                            <tr style="background: #dcdcdc;">
                                <th width='5%' class="text-center ">Sr.N.</th>
                                <th width='65%' class="text-center">Details</th>
                                <th width='10%' class="text-center"></th>
                                <th width='10%' class="text-center">Amount</th>
                                <th width='10%' class="text-center ">Amount</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="parent-color parent" id="row1">
                                <td style="text-align: center">1</td>
                                <td>Gross Annual Salary (Salary(U/s 17 1) + Perquisite + Profits (335)</td>
                                <td>
                                    <h6>+</h6>
                                </td>
                                <td></td>
                                <td class="AutoEntry"><span id="spanGrossEarn1" name="spanGrossEarn1">0.00</span></td>
                            </tr>
                            <tr class="child-row1" style="display: none;">
                                <td></td>
                                <td>
                                    <table style="width: 100%;" class="table-hover1">
                                        <tr>
                                            <td>(a) Salary as per provisions contained in sec. 17(1)</td>
                                            <td style="width: 30%;">
                                                <button id="btnViewDetails1" name="btnViewDetails1" onclick="openViewDetails1()" class="btn btn-success" type="button">View Details </button>
                                            </td>
                                            <td class="AutoEntry"><span id="spanTotalEarn">0.00</span></td>
                                        </tr>
                                        <tr>
                                            <td>(b) Value of perquisites u/s 17(2) (as per Form No. 12BA, wherever applicable)</td>

                                            <td>
                                                <button id="btnViewDetails2" name="btnViewDetails2" onclick="openViewDetails2()" class="btn btn-success btn-labeled" type="button">View Details </button>
                                            </td>
                                            <td class="AutoEntry"><span id="spanTotalPerk">0.00</span> </td>
                                        </tr>
                                        <tr>
                                            <td>(c) Profits in lieu of salary under section 17(3) (as per Form No. 12BA, wherever applicable)</td>
                                            <td class="AutoEntry"></td>
                                            <td style="text-align: right">
                                                <input type="text" class=" form-control form-control-border" style="text-align: right;" id="txtGrossProfits_C" value="0.00" /></td>

                                        </tr>
                                    </table>
                                </td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr class="parent" id="row2" title="Click to expand/collapse" style="cursor: pointer;">
                                <td style="text-align: center">2</td>
                                <td><span style="font-weight: bold">Less : </span>Allowance U/s 10 (347)</td>
                                <td>+</td>
                                <td class="AutoEntry"><span id="spanSection10Total" name="spanSection10Total">0.00</span> </td>
                                <td></td>
                            </tr>
                            <tr class="child-row2" style="display: none;">
                                <td></td>
                                <td>
                                    <table style="width: 100%; background-color: #F2F2F2;">

                                        <tr>
                                            <td>a) Section 10(5)-Travel Concession or Assistance</td>
                                            <td style="text-align: right;">
                                                <input type="text" class=" form-control form-control-border" name="txtTravel" id="txtTravel" value="0.00" style="text-align: right;" /></td>
                                        </tr>
                                        <tr>
                                            <td>b) Section 10(10)-Death-Cum-Retirement Gratuity</td>
                                            <td style="text-align: right;">
                                                <input type="text" class=" form-control form-control-border" name="txtGratuity" id="txtGratuity" value="0.00" style="text-align: right;" /></td>

                                        </tr>
                                        <tr>
                                            <td>c) Section 10(10A)-Commuted Value of Pension</td>
                                            <td style="text-align: right;">
                                                <input type="text" class=" form-control form-control-border" name="txtPension" id="txtPension" value="0.00" style="text-align: right;" /></td>

                                        </tr>
                                        <tr>

                                            <td>d) Section 10(10AA)-Cash Equivalent of Leave</td>
                                            <td style="text-align: right;">
                                                <input type="text" class=" form-control form-control-border" name="txtLeave" id="txtLeave" value="0.00" style="text-align: right;" /></td>

                                        </tr>
                                        <tr>

                                            <td>f) Amount of any other exemption under Section 10</td>
                                            <td style="text-align: right;">
                                                <input type="text" class=" form-control form-control-border" name="txtSOthers" id="txtSOthers" value="0.00" style="text-align: right;" /></td>


                                        </tr>
                                    </table>
                                </td>
                                <td></td>
                                <td></td>
                                <td></td>

                            </tr>
                            <tr class="parent" id="row2_1">
                                <td style="text-align: center">2A</td>
                                <td><span style="font-weight: bold">Less : </span>House Rent Allowance </td>
                                <td>
                                    <button id="btnHRA" name="btnHRA" onclick="openViewHra()" class="btn btn-success" type="button">HRA Calc</button></td>
                                <td class="AutoEntry">
                                    <input type="text" class=" form-control form-control-border" name="txtHRAEXMPT" id="txtHRAEXMPT" value="0.00" style="text-align: right;" /></td>
                                <td></td>
                            </tr>
                            <tr class="parent parent-color" id="row3" title="Click to expand/collapse" style="cursor: pointer;">
                                <td style="text-align: center">3</td>
                                <td><span style="font-weight: bold">Add : </span>BALANCE (1-2) + Previous Employer Taxable Salary</td>
                                <td>+</td>
                                <td></td>
                                <td class="AutoEntry"><span id="spanGross3" name="spanGross3">0.00</span> </td>
                            </tr>
                            <tr class="child-row3" style="display: none;">
                                <td></td>
                                <td>
                                    <table style="width: 100%; background-color: #F2F2F2;">

                                        <tr>
                                            <td>Previous Taxable Salary</td>
                                            <td style="text-align: right;">
                                                <input type="text" name="txtPreviousSal" id="txtPreviousSal" class=" form-control form-control-border" style="text-align: right;" value="0.00" /></td>
                                        </tr>
                                    </table>
                                </td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr class="parent" id="row4" title="Click to expand/collapse" style="cursor: pointer;">
                                <td style="text-align: center">4</td>
                                <td><span style="font-weight: bold">Less : </span>Deductions U/s 16 (350)</td>
                                <td>+</td>
                                <td class="AutoEntry"><span id="spanDeduction">0.00</span></td>
                                <td></td>
                            </tr>
                            <tr class="child-row4" style="display: none;">
                                <td></td>
                                <td>
                                    <table style="width: 100%;" class="table-hover1">

                                        <tr>
                                            <td>a. Entertainment Allowance (16ii)</td>
                                            <td style="text-align: right;">
                                                <input type="text" name="txtEntertainment" id="txtEntertainment" class=" form-control form-control-border" style="text-align: right;" value="0.00" /></td>
                                        </tr>
                                        <tr>
                                            <td>b. Tax on Employement (16iii)</td>
                                            <td style="text-align: right;">
                                                <input type="text" name="txtPTax" id="txtPTax" class=" form-control form-control-border" style="text-align: right;" value="0.00" /></td>
                                        </tr>
                                        <tr>
                                            <td>c. Standard Deductions (16ia)</td>
                                            <td style="text-align: right;">
                                                <input type="text" name="txtSded" id="txtSded" class=" form-control form-control-border" style="text-align: right;" value="0.00" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>

                            <tr id="row5" class="parent-color">
                                <td style="text-align: center">5</td>
                                <td>Income Chargeable U/h Salaries (351)  (1 - 2 + 3 - 4)</td>
                                <td>
                                    <h6></h6>
                                </td>
                                <td></td>
                                <td class="AutoEntry"><span id="spanGross5" name="spanGross5">0.00</span></td>
                            </tr>
                            <tr class="parent" title="Click to expand/collapse" style="cursor: pointer;" id="row6">
                                <td style="text-align: center">6</td>
                                <td><span style="font-weight: bold">Less : </span>(Interset on House Property(352)</td>
                                <td>+</td>
                                <td class="AutoEntry"><span id="spanIntHome" name="spanIntHome">0.00</span></td>
                                <td></td>
                            </tr>
                            <tr class="child-row6" style="display: none;">
                                <td></td>
                                <td>
                                    <table style="width: 100%;" class="table-hover1">

                                        <tr>
                                            <td>Interest on House Property</td>
                                            <td style="text-align: right;">
                                                <input type="text" name="txtIntHome" id="txtIntHome" class=" form-control form-control-border" value="0.00" /></td>
                                        </tr>
                                    </table>
                                </td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr class="parent" title="Click to expand/collapse" style="cursor: pointer;" id="row7">
                                <td style="text-align: center">7</td>
                                <td><span style="font-weight: bold">Add : </span>Income U/h Other Sources (354)</td>
                                <td>+</td>
                                <td class="AutoEntry"><span id="spanOthInc" name="spanOthInc">0.00</span></td>
                                <td></td>
                            </tr>
                            <tr class="child-row7" style="display: none;">
                                <td></td>
                                <td>
                                    <table style="width: 100%;" class="table-hover1">

                                        <tr>
                                            <td>Income U/h Other Sources (354)</td>
                                            <td style="text-align: right;">
                                                <input type="text" name="txtOthInc" id="txtOthInc" class=" form-control form-control-border" style="text-align: right;" value="0.00" /></td>
                                        </tr>
                                    </table>
                                </td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr id="row8" class="parent-color">
                                <td style="text-align: center">8</td>
                                <td>Gross Total Income (355) ( 5 + 6 + 7)</td>
                                <td>
                                    <h6></h6>
                                </td>
                                <td></td>
                                <td class="AutoEntry"><span id="spanGross8" name="spanGross8">0.00</span></td>
                            </tr>
                            <tr class="parent" id="row9" title="Click to expand/collapse" style="cursor: pointer;">
                                <td style="text-align: center">9</td>
                                <td><span style="font-weight: bold">Less : </span>Total Amt. Deduction U/s VI_A (366)</td>
                                <td>+</td>
                                <td class="AutoEntry"><span id="spanRebateTotal" name="spanRebateTotal">0.00</span></td>
                                <td></td>
                            </tr>
                            <tr class="child-row9" style="display: none">
                                <td></td>
                                <td>
                                    <table style="width: 100%;" class="table-hover1">
                                        <tr>
                                            <td style="text-align: left; padding-left: 10px; font-weight: bold">Rebate</td>
                                            <td style="text-align: center; padding-left: 15px; font-weight: bold">Investment
                                            </td>
                                            <td style="text-align: center; padding-left: 15px; font-weight: bold">Deduction
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Deductions u/s 80C<br />
                                                (LIC, PF, PPF, NSC, Repayment of Housing Loan, etc.)</td>
                                            <td style="text-align: right">
                                                <input type="text" name="txtRebate80C" id="txtRebate80C" class=" form-control form-control-border Rebate" style="text-align: right;" value="0.00" />
                                            </td>
                                            <td style="text-align: right;">
                                                <input type="text" name="txtRebate80C_Ded" id="txtRebate80C_Ded" class=" form-control form-control-border Rebate" style="text-align: right;" value="0.00" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Deduction u/s 80CCC
                                                <br />
                                                (Payment in respect Pension Fund)</td>
                                            <td style="text-align: right">
                                                <input type="text" name="txtRebate80CCC" id="txtRebate80CCC" class=" form-control form-control-border Rebate" style="text-align: right;" value="0.00" />
                                            </td>
                                            <td style="text-align: right">
                                                <input type="text" name="txtRebate80CCC_Ded" id="txtRebate80CCC_Ded" class=" form-control form-control-border Rebate" style="text-align: right;" value="0.00" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Deductions u/s 80CCD(1)<br />
                                                (Employee’s / Self-employed contribution towards NPS)</td>
                                            <td style="text-align: right">
                                                <input type="text" name="txtRebate80CCD" id="txtRebate80CCD" class=" form-control form-control-border Rebate" style="text-align: right;" value="0.00" />
                                            </td>
                                            <td style="text-align: right">
                                                <input type="text" name="txtRebate80CCD_Ded" id="txtRebate80CCD_Ded" class=" form-control form-control-border Rebate" style="text-align: right;" value="0.00" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Deductions u/s 80CCD (1B)<br />
                                                (Additional Employee’s contribution towards NPS)</td>
                                            <td style="text-align: right">
                                                <input type="text" name="txtRebate80CCD1B" id="txtRebate80CCD1B" class=" form-control form-control-border Rebate" style="text-align: right;" value="0.00" />
                                            </td>
                                            <td style="text-align: right">
                                                <input type="text" name="txtRebate80CCD1B_Ded" id="txtRebate80CCD1B_Ded" class=" form-control form-control-border Rebate" style="text-align: right;" value="0.00" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Deductions u/s 80CCD (2)<br />
                                                (Additional Employee’s contribution towards NPS)</td>
                                            <td style="text-align: right">
                                                <input type="text" name="txtRebate80CCD2" id="txtRebate80CCD2" class=" form-control form-control-border Rebate" style="text-align: right;" value="0.00" />
                                            </td>
                                            <td style="text-align: right">
                                                <input type="text" class=" form-control form-control-border Rebate" name="txtRebate80CCD2_Ded" id="txtRebate80CCD2_Ded" style="text-align: right;" value="0.00" />
                                            </td>
                                        </tr>
                                        <tr style="padding: 6px; margin: 3px 0; font-weight: bold;">
                                            <td style="padding-left: 10px;"><span style="padding-left: 5px;" id="spanRebate80CQly" name="spanRebate80CQly">150000.00</span></td>
                                            <td>Total</td>
                                            <td style="text-align: right; font-weight: bold;"><span id="spanRebate80CTotal" name="spanRebate80CTotal">0.00</span></td>
                                        </tr>
                                        <tr>
                                            <td>Deductions u/s 80D<br />
                                                (MediClaim Premium)	</td>
                                            <td style="text-align: right">
                                                <input type="text" name="txtRebate80D" id="txtRebate80D" class=" form-control form-control-border Rebate" style="text-align: right;" value="0.00" />
                                            </td>
                                            <td style="text-align: right">
                                                <input type="text" name="txtRebate80D_Ded" id="txtRebate80D_Ded" class=" form-control form-control-border Rebate" style="text-align: right;" value="0.00" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Deductions u/s 80G
                                                <br />
                                                (Donations)	</td>
                                            <td style="text-align: right">
                                                <input type="text" name="txtRebate80G" id="txtRebate80G" class=" form-control form-control-border Rebate" style="text-align: right;" value="0.00" />
                                            </td>
                                            <td style="text-align: right">
                                                <input type="text" name="txtRebate80G_Ded" id="txtRebate80G_Ded" class=" form-control form-control-border Rebate" style="text-align: right;" value="0.00" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Deductions u/s 80E
                                                <br />
                                                (Interest on Loan for Higher Education)</td>
                                            <td style="text-align: right">
                                                <input type="text" name="txtRebate80E" id="txtRebate80E" class=" form-control form-control-border Rebate" style="text-align: right;" value="0.00" />
                                            </td>
                                            <td style="text-align: right">
                                                <input type="text" name="txtRebate80E_Ded" id="txtRebate80E_Ded" class=" form-control form-control-border Rebate" style="text-align: right;" value="0.00" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Deductions u/s 80EE<br />
                                                (Interest on Loan taken for Residential House)	</td>
                                            <td style="text-align: right">
                                                <input type="text" name="txtRebate80EE" id="txtRebate80EE" class=" form-control form-control-border Rebate" style="text-align: right;" value="0.00" />
                                            </td>
                                            <td style="text-align: right">
                                                <input type="text" name="txtRebate80EE_Ded" id="txtRebate80EE_Ded" class=" form-control form-control-border Rebate" style="text-align: right;" value="0.00" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Deductions u/s 80TTA<br />
                                                (Interest on Savings Bank Account)</td>
                                            <td style="text-align: right">
                                                <input type="text" name="txtRebate80TTA" id="txtRebate80TTA" class=" form-control form-control-border Rebate" style="text-align: right;" value="0.00" />
                                            </td>
                                            <td style="text-align: right">
                                                <input type="text" name="txtRebate80TTA_Ded" id="txtRebate80TTA_Ded" class=" form-control form-control-border Rebate" style="text-align: right;" value="0.00" />
                                            </td>
                                        </tr>
                                        <%--                                <tr>
                                                <td>Deductions u/s 80TTB<br />(Interest on Deposits)</td>
                                                <td style="text-align:right">
                                                     <span style="padding-left:5px;" >  </span><input type="text" name="txtRebate80TTB" id="txtRebate80TTB" class=" form-control form-control-border"    value="0.00"/>
                                                </td>   
                                                <td style="text-align:right">
                                                     <span style="padding-left:5px;" >  </span><input type="text" name="txtRebate80TTB_Ded" id="txtRebate80TTB_Ded" class=" form-control form-control-border"    value="0.00"/>
                                                </td>                                   
                                            </tr>--%>
                                        <tr>
                                            <td>Any other deduction</td>
                                            <td style="text-align: right">
                                                <input type="text" name="txtRebateOthers" id="txtRebateOthers" class=" form-control form-control-border Rebate" value="0.00" style="text-align: right;" />
                                            </td>
                                            <td style="text-align: right">
                                                <input type="text" name="txtRebateOthers_Ded" id="txtRebateOthers_Ded" class=" form-control form-control-border Rebate" style="text-align: right;" value="0.00" />
                                            </td>
                                        </tr>
                                    </table>

                                </td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr id="row10" class="parent">
                                <td style="text-align: center">10</td>
                                <td>Total Taxable Income (367) ( 8 - 9 )</td>
                                <td></td>
                                <td></td>
                                <td class="AutoEntry"><span id="spanNetIncTax" name="spanNetIncTax">0.00</span></td>
                            </tr>
                            <tr id="row10_1" class="parent">
                                <td style="text-align: center"></td>
                                <td>Tax on Total Income</td>
                                <td>
                                    <button id="btnViewDetails3" name="btnViewDetails3" onclick="openViewDetails3()" class="btn btn-success" type="button">View</button>
                                </td>
                                <td class="AutoEntry"><span id="spanOnTaxTotalIncome" name="spanOnTaxTotalIncome">0.00</span></td>
                                <td></td>
                            </tr>
                            <tr id="row10_2" class="parent">
                                <td></td>
                                <td>Rebate U/s 87A if applicable</td>
                                <td></td>
                                <td class="AutoEntry"><span id="spanRebate87A" name="spanRebate87A">0.00</span></td>
                                <td></td>
                            </tr>
                            <tr id="row11" class="parent-color">
                                <td style="text-align: center">11</td>
                                <td>Income Tax on Total Income (368)</td>
                                <td></td>
                                <td></td>
                                <td class="AutoEntry"><span id="spanRebateTAX" name="spanRebateTAX">0.00</span></td>
                            </tr>
                            <tr id="row12" class="parent">
                                <td style="text-align: center">12</td>
                                <td>Surcharge (370)</td>
                                <td></td>
                                <td class="AutoEntry"><span id="spanSurcharge" name="spanSurcharge">0.00</span></td>
                                <td></td>
                            </tr>
                            <tr id="row13" class="parent">
                                <td style="text-align: center">13</td>
                                <td>Health & Education Cess @ 4%   (371)</td>
                                <td></td>
                                <td class="AutoEntry"><span id="spanCess" name="spanCess">0.00</span></td>
                                <td></td>
                            </tr>
                            <tr id="row14" class="parent">
                                <td style="text-align: center">14</td>
                                <td>Income Tax Relief under section 89 (372)</td>
                                <td></td>
                                <td><span style="padding-left: 5px;"></span>
                                    <input type="text" name="txtRebate89" id="txtRebate89" class="form-control form-control-border" value="0.00" /></td>
                                <td></td>
                            </tr>
                            <tr id="row15" class="parent">
                                <td style="text-align: center">15</td>
                                <td>Net Tax Liability (373)</td>
                                <td></td>
                                <td></td>
                                <td class="AutoEntry"><span id="spanTax" name="spanTax">0.00</span></td>
                            </tr>
                            <tr id="row18" class="parent">
                                <td style="text-align: center">16</td>
                                <td>Total TDS deducted (374)</td>
                                <td>+</td>
                                <td></td>
                                <td class="AutoEntry"><span id="spanTDS" name="spanTDS">0.00</span></td>
                            </tr>
                            <tr class="child-row18" style="display: none;">
                                <td></td>
                                <td>
                                    <table id="tbl_Challan" style="width: 100%;" class="table-hover1">
                                    </table>
                                </td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr id="row19" class="parent">
                                <td style="text-align: center">17</td>
                                <td>Reported Amt.of TDS by Other Emp.(375)</td>
                                <td></td>
                                <td class="AutoEntry">
                                    <input type="text" id="txtPreTDS" name="txtPreTDS" class="form-control form-control-border" value="0.00" /></td>
                                <td></td>
                            </tr>
                            <tr id="row20" class="parent-color">
                                <td style="text-align: center">18</td>
                                <td>Shortfall / Excess in Tax Deductions (377)</td>
                                <td></td>
                                <td></td>
                                <td class="AutoEntry"><span id="spanFinalTax" name="spanFinalTax">0.00</span></td>
                            </tr>

                            <tr>

                                <td style="text-align: center" class="parent">19</td>
                                <td class="parent">TDS deducted in Higher Rate due to invalid PAN</td>
                                <td></td>
                                <td></td>
                                <td>
                                    <select class="form-control">
                                        <option value="yes">Yes</option>
                                        <option value="no">No</option>
                                    </select>
                                </td>
                            </tr>



                            <tr class="parent-color parent" id="row22">
                                <td style="text-align: center">20</td>
                                <td>Whether aggregate rent payment exceeds rupees one lakh during previous year
                       
                          
                                </td>

                                <td>
                                    <h6>+</h6>
                                </td>
                                <td></td>
                                <td>
                                    <select id="Rent_Payment" name="Rent_Payment" class="form-control " data-hideclass="partone">
                                        <option value="yes">Yes</option>
                                        <option value="no">No</option>
                                    </select></td>

                            </tr>
                            <tr class="child-row22" style="display: none;">
                                <td></td>
                                <td>
                                    <table style="width: 100%; background-color: #F2F2F2;">
                                        <tbody>
                                            <tr>
                                                <td>PAN of landlord 1</td>
                                                <td style="text-align: left;">
                                                    <input id="PAN_landlord1" maxlength="10" style="text-transform: uppercase; text-align: right;" type="text" class=" form-control form-control-border" name="PAN_landlord1" /></td>
                                            </tr>
                                            <tr>
                                                <td>Name of landlord 1</td>
                                                <td style="text-align: left;">
                                                    <input type="text" class=" form-control form-control-border" id="Name_landlord1" name="Name_landlord1" style="text-align: right;" /></td>
                                            </tr>
                                            <tr>
                                                <td>PAN of landlord 2</td>
                                                <td style="text-align: left;">
                                                    <input type="text" class=" form-control form-control-border" id="PAN_landlord2" name="PAN_landlord2" maxlength="10" style="text-align: right; text-transform: uppercase;" /></td>

                                            </tr>
                                            <tr>
                                                <td>Name of landlord 2</td>
                                                <td style="text-align: left;">
                                                    <input type="text" class=" form-control form-control-border" id="Name_landlord2" name="Name_landlord2" style="text-align: right;" /></td>

                                            </tr>
                                            <tr>

                                                <td>PAN of landlord 3</td>
                                                <td style="text-align: left;">
                                                    <input type="text" class=" form-control form-control-border" id="PAN_landlord3" name="PAN_landlord3" maxlength="10" style="text-align: right; text-transform: uppercase;" /></td>

                                            </tr>
                                            <tr>

                                                <td>Name of landlord 3</td>
                                                <td style="text-align: left;">
                                                    <input type="text" class=" form-control form-control-border" id="Name_landlord3" name="Name_landlord3" style="text-align: right;" /></td>


                                            </tr>
                                            <tr>

                                                <td>PAN of landlord 4</td>
                                                <td style="text-align: left;">
                                                    <input type="text" class=" form-control form-control-border" id="PAN_landlord4" name="PAN_landlord4" maxlength="10" style="text-align: right; text-transform: uppercase;" /></td>


                                            </tr>
                                            <tr>

                                                <td>Name of landlord 4</td>
                                                <td style="text-align: left;">
                                                    <input type="text" class=" form-control form-control-border" id="Name_landlord4" name="Name_landlord4" style="text-align: right;" /></td>


                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>


                            <tr class="parent-color parent" id="row23">
                                <td style="text-align: center">21</td>
                                <td>Whether Interest paid to the lender under the head 'Income from house property'
                       
                          
                                </td>

                                <td>
                                    <h6>+</h6>
                                </td>
                                <td></td>
                                <td>
                                    <select id="Interest_lender" name="Interest_lender" class="form-control" data-hideclass="parttwo">
                                        <option value="yes">Yes</option>
                                        <option value="no">No</option>
                                    </select></td>

                            </tr>

                            <tr class="child-row23" style="display: none;">
                                <td></td>
                                <td>
                                    <table style="width: 100%; background-color: #F2F2F2;">
                                        <tbody>
                                            <tr>
                                                <td>Deduction of interest under the head income from house property - PAN of lender 1</td>
                                                <td style="text-align: left;">
                                                    <input type="text" class=" form-control form-control-border" id="PAN_lender1" name="PAN_lender1" maxlength="10" style="text-transform: uppercase;" /></td>
                                            </tr>
                                            <tr>
                                                <td>Deduction of interest under the head income from house property - Name of lender 1</td>
                                                <td style="text-align: left;">
                                                    <input type="text" class=" form-control form-control-border" id="Name_lender1" name="Name_lender1" /></td>
                                            </tr>
                                            <tr>
                                                <td>Deduction of interest under the head income from house property - PAN of lender 2</td>
                                                <td style="text-align: left;">
                                                    <input type="text" class=" form-control form-control-border" id="PAN_lender2" name="PAN_lender2" maxlength="10" style="text-transform: uppercase;" /></td>

                                            </tr>
                                            <tr>
                                                <td>Deduction of interest under the head income from house property - Name of lender 2</td>
                                                <td style="text-align: left;">
                                                    <input type="text" class=" form-control form-control-border" id="Name_lender2" name="Name_lender2" /></td>

                                            </tr>
                                            <tr>

                                                <td>Deduction of interest under the head income from house property - PAN of lender 3</td>
                                                <td style="text-align: left;">
                                                    <input type="text" class=" form-control form-control-border" id="PAN_lender3" name="PAN_lender3" maxlength="10" style="text-transform: uppercase;" /></td>

                                            </tr>
                                            <tr>

                                                <td>Deduction of interest under the head income from house property - Name of lender 3</td>
                                                <td style="text-align: left;">
                                                    <input type="text" class=" form-control form-control-border" id="Name_lender3" name="Name_lender3" /></td>


                                            </tr>
                                            <tr>

                                                <td>Deduction of interest under the head income from house property - PAN of lender 4</td>
                                                <td style="text-align: left;">
                                                    <input type="text" class=" form-control form-control-border" id="PAN_lender4" name="PAN_lender4" maxlength="10" style="text-transform: uppercase;" /></td>


                                            </tr>
                                            <tr>

                                                <td>Deduction of interest under the head income from house property - Name of lender 4</td>
                                                <td style="text-align: left;">
                                                    <input type="text" class=" form-control form-control-border" id="Name_lender4" name="Name_lender4" /></td>


                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>

                            <tr class="parent-color parent" id="row24">
                                <td style="text-align: center">22</td>
                                <td>Whether contributions paid by trustees of an approved superannuation fund
                       
                          
                                </td>

                                <td>
                                    <h6>+</h6>
                                </td>
                                <td></td>
                                <td>
                                    <select id="Contributions_superannuation_fund" name="Contributions_superannuation_fund" class="form-control" data-hideclass="partthree">
                                        <option value="yes">Yes</option>
                                        <option value="no">No</option>
                                    </select></td>

                            </tr>

                            <tr class="child-row24" style="display: none;">
                                <td></td>
                                <td>
                                    <table style="width: 100%; background-color: #F2F2F2;">
                                        <tbody>
                                            <tr>
                                                <td>Name of the superannuation fund</td>
                                                <td style="text-align: left;">
                                                    <input type="text" class=" form-control form-control-border" name="Name_superannuation_fund" id="Name_superannuation_fund" /></td>
                                            </tr>
                                            <tr>
                                                <td>Date from which the employee has contributed to the superannuation fund</td>
                                                <td style="text-align: left;">
                                                    <input type="date" class=" form-control form-control-border" name="Frm_DT_superannuation_fund" id="Frm_DT_superannuation_fund" /></td>
                                            </tr>
                                            <tr>
                                                <td>Date to which the employee has contributed to the superannuation fund</td>
                                                <td style="text-align: left;">
                                                    <input type="date" class=" form-control form-control-border" name="TO_DT_superannuation_fund" id="TO_DT_superannuation_fund" /></td>

                                            </tr>
                                            <tr>
                                                <td>The amount of contribution repaid on account of principal and interest from superannuation fund</td>
                                                <td style="text-align: left;">
                                                    <input type="text" class=" form-control form-control-border" name="principal_interest_superannuation_fund" id="principal_interest_superannuation_fund" value="0.00" /></td>

                                            </tr>
                                            <tr>

                                                <td>The average rate of deduction of tax during the preceding three years 0</td>
                                                <td style="text-align: left;">
                                                    <input type="text" class=" form-control form-control-border" id="Rate_deduction_tax_3yrs" name="Rate_deduction_tax_3yrs" value="0.00" /></td>

                                            </tr>
                                            <tr>

                                                <td>The amount of tax deducted on repayment of superannuation fund 0</td>
                                                <td style="text-align: left;">
                                                    <input type="text" class=" form-control form-control-border" name="Repayment_superannuation_fund" id="Repayment_superannuation_fund" value="0.00" /></td>


                                            </tr>
                                            <tr>

                                                <td>Gr. Total income including contribution repaid on account of principal & interest from superannuatic</td>
                                                <td style="text-align: left;">
                                                    <input type="text" class=" form-control form-control-border" name="Total_Income_superannuation_fund" id="Total_Income_superannuation_fund" value="0.00" /></td>


                                            </tr>

                                        </tbody>
                                    </table>
                                </td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>





                        </tbody>
                    </table>

                </div>


    </div>


 </div>
    <%-- ///////////////////// Monthly Salary Breakup--%>
    <div id="modal_ViewDetails1" class="modal fade" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary-1">
                    <h5 class="modal-title" id="lblpopup" name="lblpopup">Gross Salary </h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>


                <div class="modal-body">
                    <div class="table-responsive">
                        <table id="tblMonthlySalary" name="tblMonthlySalary" class="table datatable-js">
                            <thead>
                                <tr>
                                    <th class="col-1">Sr.N.
                                    </th>
                                    <th class="col-1">Month
                                    </th>
                                    <th style="text-align: center;" class="col-1">Basic
                                    </th>
                                    <th style="text-align: center;" class="col-1">DA
                                    </th>
                                    <th style="text-align: center;" class="col-1">HRA
                                    </th>
                                    <th style="text-align: center;" class="col-1">Others
                                    </th>
                                    <th style="text-align: center;" class="col-1">GrossTotal
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1
                                        <input type="hidden" id="hdnMthSal4" name="hdnMthSal" value="4" /><input type="hidden" id="hdnHrr4" name="hdnHrr" value="0" /></td>
                                    <td>April </td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px; " class="col-1">
                                        <input type="text" name="txtBasic" id="txtBasic4" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtDA" id="txtDA4" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtHRA" id="txtHRA4" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtOthers" id="txtOthers4" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtMonth" id="txtMonth4" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" readonly="" /></td>

                                </tr>
                                <tr>
                                    <td>2<input type="hidden" id="hdnMthSal5" name="hdnMthSal" value="5" /><input type="hidden" id="hdnHrr5" name="hdnHrr" value="0" /></td>
                                    <td>May</td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtBasic" class="form-control form-control-border ManualEntry col-12 " id="txtBasic5" data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtDA" id="txtDA5" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtHRA" id="txtHRA5" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtOthers" id="txtOthers5" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtMonth" id="txtMonth5" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" readonly="" /></td>

                                </tr>
                                <tr>
                                    <td>3<input type="hidden" id="hdnMthSal6" name="hdnMthSal" value="6" /><input type="hidden" id="hdnHrr6" name="hdnHrr" value="0" /></td>
                                    <td>June</td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtBasic" class="form-control form-control-border ManualEntry col-12 " id="txtBasic6" data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtDA" id="txtDA6" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtHRA" id="txtHRA6" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtOthers" id="txtOthers6" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtMonth" id="txtMonth6" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" readonly="" /></td>

                                </tr>
                                <tr>
                                    <td>4<input type="hidden" id="hdnMthSal7" name="hdnMthSal" value="7" /><input type="hidden" id="hdnHrr7" name="hdnHrr" value="0" /></td>
                                    <td>July</td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtBasic" class="form-control form-control-border ManualEntry col-12 " id="txtBasic7" data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtDA" id="txtDA7" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtHRA" id="txtHRA7" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtOthers" id="txtOthers7" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtMonth" id="txtMonth7" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" readonly="" /></td>

                                </tr>
                                <tr>
                                    <td>5<input type="hidden" id="hdnMthSal8" name="hdnMthSal" value="8" /><input type="hidden" id="hdnHrr8" name="hdnHrr" value="0" /></td>
                                    <td>August</td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtBasic" class="form-control form-control-border ManualEntry col-12 " id="txtBasic8" data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtDA" id="txtDA8" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtHRA" id="txtHRA8" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtOthers" id="txtOthers8" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtMonth" id="txtMonth8" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" readonly="" /></td>

                                </tr>
                                <tr>
                                    <td>6<input type="hidden" id="hdnMthSal9" name="hdnMthSal" value="9" /><input type="hidden" id="hdnHrr9" name="hdnHrr" value="0" /></td>
                                    <td>September</td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtBasic" class="form-control form-control-border ManualEntry col-12 " id="txtBasic9" data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtDA" id="txtDA9" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtHRA" id="txtHRA9" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtOthers" id="txtOthers9" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtMonth" id="txtMonth9" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" readonly="" /></td>

                                </tr>
                                <tr>
                                    <td>7<input type="hidden" id="hdnMthSal10" name="hdnMthSal" value="10" /><input type="hidden" id="hdnHrr10" name="hdnHrr" value="0" /></td>
                                    <td>October</td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtBasic" class="form-control form-control-border ManualEntry col-12 " id="txtBasic10" data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtDA" id="txtDA10" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtHRA" id="txtHRA10" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtOthers" id="txtOthers10" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtMonth" id="txtMonth10" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" readonly="" /></td>

                                </tr>
                                <tr>
                                    <td>8<input type="hidden" id="hdnMthSal11" name="hdnMthSal" value="11" /><input type="hidden" id="hdnHrr11" name="hdnHrr" value="0" /></td>
                                    <td>November</td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtBasic" class="form-control form-control-border ManualEntry col-12 " id="txtBasic11" data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtDA" id="txtDA11" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtHRA" id="txtHRA11" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtOthers" id="txtOthers11" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtMonth" id="txtMonth11" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" readonly="" /></td>

                                </tr>
                                <tr>
                                    <td>9<input type="hidden" id="hdnMthSal12" name="hdnMthSal" value="12" /><input type="hidden" id="hdnHrr12" name="hdnHrr" value="0" /></td>
                                    <td>December</td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtBasic" class="form-control form-control-border ManualEntry col-12 " id="txtBasic12" data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtDA" id="txtDA12" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtHRA" id="txtHRA12" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtOthers" id="txtOthers12" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;" class="col-1">
                                        <input type="text" name="txtMonth" id="txtMonth12" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" readonly="" /></td>

                                </tr>
                                <tr>
                                    <td>10<input type="hidden" id="hdnMthSal1" name="hdnMthSal" value="1" /><input type="hidden" id="hdnHrr1" name="hdnHrr" value="0" /></td>
                                    <td>January</td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;">
                                        <input type="text" name="txtBasic" class="form-control form-control-border ManualEntry col-12 " id="txtBasic1" data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;">
                                        <input type="text" name="txtDA" id="txtDA1" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;">
                                        <input type="text" name="txtHRA" id="txtHRA1" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;">
                                        <input type="text" name="txtOthers" id="txtOthers1" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;">
                                        <input type="text" name="txtMonth" id="txtMonth1" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" readonly="" /></td>

                                </tr>
                                <tr>
                                    <td>11<input type="hidden" id="hdnMthSal2" name="hdnMthSal" value="2" /><input type="hidden" id="hdnHrr2" name="hdnHrr" value="0" /></td>
                                    <td>Februry</td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;">
                                        <input type="text" name="txtBasic" class="form-control form-control-border ManualEntry col-12 " id="txtBasic2" data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;">
                                        <input type="text" name="txtDA" id="txtDA2" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;">
                                        <input type="text" name="txtHRA" id="txtHRA2" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;">
                                        <input type="text" name="txtOthers" id="txtOthers2" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;">
                                        <input type="text" name="txtMonth" id="txtMonth2" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" readonly="" /></td>

                                </tr>
                                <tr>
                                    <td>12<input type="hidden" id="hdnMthSal3" name="hdnMthSal" value="3" /><input type="hidden" id="hdnHrr3" name="hdnHrr" value="0" /></td>
                                    <td>March</td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;">
                                        <input type="text" name="txtBasic" class="form-control form-control-border ManualEntry col-12 " id="txtBasic3" data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;">
                                        <input type="text" name="txtDA" id="txtDA3" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;">
                                        <input type="text" name="txtHRA" id="txtHRA3" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;">
                                        <input type="text" name="txtOthers" id="txtOthers3" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" /></td>
                                    <td style="text-align: right; padding-top:5px; padding-bottom :5px;">
                                        <input type="text" name="txtMonth" id="txtMonth3" class="form-control form-control-border ManualEntry col-12 " data-info="Salary" value="0.00" readonly="" /></td>

                                </tr>
                                <tr>
                                    <td></td>
                                    <td><b>Total</b></td>
                                    <td style="text-align: right;"><span id="lblGrossTotal" class="col-form-label font-weight-bold">0.00</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%--    ///////////////////// Perquisites--%>
    <div id="modal_ViewDetails2" class="modal fade" tabindex="-1">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h5 class="modal-title" id="lblpopup1" name="lblpopup">Perquisites </h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body" style="height: 600px; overflow-y: auto; scrollbar-width: thin;">
                    <table id="tblPerquisites">
                    </table>
                </div>
            </div>
        </div>
    </div>
    <%--/////////////////////////// BAC TAX--%>
    <div id="modal_BAC_iTax" class="modal fade" tabindex="-1">
        <div class="modal-dialog" style="max-width: 900px;">
            <div class="modal-content">
                <div class="modal-header bg-primary-1">
                    <h5 class="modal-title" id="lblBACItaxSlab" name="lblBACItaxSlab">IncomeTax Slab </h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <table id="tbl_BACItaxSlab" class="table table-hover table-bordered  table-xs font-size-base">
                        <tr class="cssGridHeader">
                            <th class="text-center" width="30%">Description
                            </th>
                            <th class="text-center">Slab
                            </th>
                            <th class="text-center">Income
                            </th>
                            <th class="text-center">Income Tax
                            </th>
                        </tr>
                        <tr class="cssGridAlternatingItemStyle">
                            <td>Exempt Income
                                <span id="SHlblPer1" name="SHlblPer1"></span>

                            </td>
                            <td style="text-align: right;">
                                <span id="SHlblBACSlab1" class="spanwithno"></span>%
                            </td>
                            <td style="text-align: right;">
                                <span id="SHlblBACiNc1" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="SHlblBACTax1"></span>
                            </td>
                        </tr>
                        <tr class="cssGridAlternatingItemStyle">
                            <td>Income chargeable at
                                <span id="SHlblPer2"></span>%
                            </td>
                            <td style="text-align: right;">
                                <span id="SHlblBACSlab2" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="SHlblBACiNc2" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="SHlblBACTax2" class="spanwithno"></span>
                            </td>
                        </tr>
                        <tr class="cssGridAlternatingItemStyle">
                            <td>Income chargeable at
                            <span id="SHlblPer3"></span>%
                            </td>
                            <td style="text-align: right;">
                                <span id="SHlblBACSlab3" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="SHlblBACiNc3" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="SHlblBACTax3" class="spanwithno"></span>
                            </td>
                        </tr>
                        <tr class="cssGridAlternatingItemStyle">
                            <td>Income chargeable at
                            <span id="SHlblPer4"></span>%
                            </td>
                            <td style="text-align: right;">
                                <span id="SHlblBACSlab4" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="SHlblBACiNc4" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="SHlblBACTax4" class="spanwithno"></span>
                            </td>
                        </tr>
                        <tr class="cssGridAlternatingItemStyle" id="iTaxSHTr5">
                            <td>Income chargeable at
                            <span id="SHlblPer5"></span>%
                            </td>
                            <td style="text-align: right;">
                                <span id="SHlblBACSlab5" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="SHlblBACiNc5" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="SHlblBACTax5" class="spanwithno"></span>
                            </td>
                        </tr>
                        <tr class="cssGridAlternatingItemStyle" id="iTaxSHTr6">
                            <td>Income chargeable at
                            <span id="SHlblPer6"></span>%
                            </td>
                            <td style="text-align: right;">
                                <span id="SHlblBACSlab6" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="SHlblBACiNc6" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="SHlblBACTax6" class="spanwithno"></span>
                            </td>
                        </tr>
                        <tr class="cssGridAlternatingItemStyle" id="iTaxSHTr7">
                            <td>Income chargeable at
                            <span id="SHlblPer7"></span>%
                            </td>
                            <td style="text-align: right;">
                                <span id="SHlblBACSlab7" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="SHlblBACiNc7" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="SHlblBACTax7" class="spanwithno"></span>
                            </td>
                        </tr>
                        <tr class="cssGridHeader" style="font-weight: bold;">
                            <td>Total
                            </td>
                            <td></td>
                            <td style="text-align: right;">
                                <span id="SHlblBACIncomeTotal" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="SHlblBACIncomeTaxTotal" class="spanwithno"></span>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>


    <%--//////////////////////// Itax--%>
    <div id="modal_iTax" class="modal fade" tabindex="-1">
        <div class="modal-dialog" style="max-width: 900px;">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h5 class="modal-title" id="lblItaxSlab" name="lblItaxSlab">IncomeTax Slab </h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <table id="tbl_ItaxSlab" class="table table-hover table-bordered  table-xs font-size-base">
                        <tr class="cssGridHeader">
                            <th class="text-center" width="30%">Description
                            </th>
                            <th class="text-center">Slab
                            </th>
                            <th class="text-center">Income
                            </th>
                            <th class="text-center">Income Tax
                            </th>
                        </tr>
                        <tr class="cssGridAlternatingItemStyle">
                            <td>Exempt Income
                                <span id="lblSlabPer1"></span>%
                            </td>
                            <td style="text-align: right;">
                                <span id="lblSlab1" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="lblIncome1" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="lblIncomeTax1"></span>
                            </td>
                        </tr>
                        <tr class="cssGridAlternatingItemStyle">
                            <td>Income chargeable at
                                <span id="lblSlabPer2"></span>%
                            </td>
                            <td style="text-align: right;">
                                <span id="lblSlab2" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="lblIncome2" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="lblIncomeTax2" class="spanwithno"></span>
                            </td>
                        </tr>
                        <tr class="cssGridAlternatingItemStyle">
                            <td>Income chargeable at
                                <span id="lblSlabPer3"></span>%
                            </td>
                            <td style="text-align: right;">
                                <span id="lblSlab3" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="lblIncome3" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="lblIncomeTax3" class="spanwithno"></span>
                            </td>
                        </tr>
                        <tr class="cssGridAlternatingItemStyle">
                            <td>Income chargeable at
                                <span id="lblSlabPer4"></span>%
                            </td>
                            <td style="text-align: right;">
                                <span id="lblSlab4" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="lblIncome4" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="lblIncomeTax4" class="spanwithno"></span>
                            </td>
                        </tr>
                        <tr class="cssGridAlternatingItemStyle" id="iTaxTr5">
                            <td>Income chargeable at
                                <span id="lblSlabPer5"></span>%
                            </td>
                            <td style="text-align: right;">
                                <span id="lblSlab5" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="lblIncome5" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="lblIncomeTax5" class="spanwithno"></span>
                            </td>
                        </tr>
                        <tr class="cssGridAlternatingItemStyle" id="iTaxTr6">
                            <td>Income chargeable at
                                <span id="lblSlabPer6"></span>%
                            </td>
                            <td style="text-align: right;">
                                <span id="lblSlab6" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="lblIncome6" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="lblIncomeTax6" class="spanwithno"></span>
                            </td>
                        </tr>
                        <tr class="cssGridHeader" style="font-weight: bold;">
                            <td>Total
                            </td>
                            <td></td>
                            <td style="text-align: right;">
                                <span id="lblIncomeTotal" class="spanwithno"></span>
                            </td>
                            <td style="text-align: right;">
                                <span id="lblIncomeTaxTotal" class="spanwithno"></span>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <%--////////////////// Email--%>
    <div id="modal_Viewemail" class="modal fade" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary-1">
                    <h5 class="modal-title" id="" name="lblpopup">Email Computation </h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>


                <div class="modal-body">

                    <div class="form-group row">

                        <label class="col-lg-4 col-form-label font-weight-bold">From</label>
                        <div class="col-lg-11">
                            <input type="text" id="txtFrom" name="txtFrom" class="form-control form-control-border" placeholder="Enter Email" />
                        </div>
                    </div>

                    <div class="form-group row">

                        <label class="col-lg-4 col-form-label font-weight-bold">Selected Employee</label>
                        <div class="col-lg-11">
                            <input type="text" id="txtSelectedEmploee" name="txtSelectedEmploee" class="form-control form-control-border" />
                        </div>
                    </div>

                    <div class="form-group row">

                        <label class="col-lg-4 col-form-label font-weight-bold">Email Subject</label>
                        <div class="col-lg-11">
                            <input type="text" id="txtSubject" name="txtSubject" class="form-control form-control-border" />
                        </div>
                    </div>

                    <div class="form-group">

                        <label class="col-lg-6 col-form-label font-weight-bold">Message</label>
                        <div class="col-lg-11">
                            <textarea rows="5" cols="5" id="txtMessage" name="txtMessage" class="form-control"></textarea>
                        </div>
                    </div>



                    <div style="padding-left: 273px;">
                        <button id="btnCancel" name="btnCancel" class=" btn btn-outline-primary legitRipple" type="button">Cancel</button>
                        <button id="btnSendMail" name="btnSendMail" class="btn btn-outline-primary legitRipple" type="button">Send Email</button>

                    </div>



                </div>



            </div>
        </div>
    </div>

    <%--////////////////////// Hra Breakup--%>
    <div id="modal_Hra" class="modal fade" tabindex="-1">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header bg-primary-1">
                    <h5 class="modal-title" id="lblHraCalc" name="lblHraCalc">Hra Calculation </h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="row col-12">
                        <div class="col-6" style="margin-top: 1%;">
                            <div class="table-responsive">
                                <table id="tblHRRSalary" name="tblHRRSalary" class="table table-bordered" style="font-size: 18px;">
                                    <thead>
                                        <tr style="background: #dcdcdc;">
                                            <th class="col-1">Sr.N.
                                            </th>
                                            <th class="col-1">Month
                                            </th>
                                            <th style="text-align: center;" class="col-1">Basic
                                            </th>
                                            <th style="text-align: center;" class="col-1">DA
                                            </th>
                                            <th style="text-align: center;" class="col-1">HRA
                                            </th>
                                            <th style="text-align: center;" class="col-2">HRR
                                            </th>
                                            <th style="text-align: center;" class="col-1">Exempt Amt
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>1
                                                <input type="hidden" id="hdnHrrMthSal4" name="hdnHrrMthSal" value="4" /></td>
                                            <td>Apr </td>
                                            <td style="text-align: right;" class="col-2"><span name="spnBasic" id="spnBasic4" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-2"><span name="spnDA" id="spnDA4" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1"><span name="spnHRA" id="spnHRA4" data-info="Salary" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1">
                                                <input type="text" name="txtHRR" id="txtHRR4" class="form-control form-control-border ManualEntry" data-info="HRR" style="text-align: right;" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1"><span name="txtExempt" id="txtExempt4" value="0.00" /></td>

                                        </tr>
                                        <tr>
                                            <td>2
                                                <input type="hidden" id="hdnHrrMthSal5" name="hdnHrrMthSal" value="4" /></td>
                                            <td>May</td>
                                            <td style="text-align: right;" class="col-2"><span name="spnBasic" id="spnBasic5" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-2"><span name="spnDA" id="spnDA5" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1"><span name="spnHRA" id="spnHRA5" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1">
                                                <input type="text" name="txtHRR" id="txtHRR5" class="form-control form-control-border ManualEntry" data-info="HRR" style="text-align: right;" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1"><span name="txtExempt" id="txtExempt5" value="0.00" /></td>

                                        </tr>
                                        <tr>
                                            <td>3<input type="hidden" id="hdnHrrMthSal6" name="hdnHrrMthSal" value="4" /></td>
                                            <td>June</td>
                                            <td style="text-align: right;" class="col-2"><span name="spnBasic" id="spnBasic6" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-2"><span name="spnDA" id="spnDA6" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1"><span name="spnHRA" id="spnHRA6" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1">
                                                <input type="text" name="txtHRR" id="txtHRR6" class="form-control form-control-border ManualEntry" data-info="HRR" style="text-align: right;" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1"><span name="txtExempt" id="txtExempt6" value="0.00" /></td>

                                        </tr>
                                        <tr>
                                            <td>4<input type="hidden" id="hdnHrrMthSal7" name="hdnHrrMthSal" value="4" /></td>
                                            <td>July</td>
                                            <td style="text-align: right;" class="col-2"><span name="spnBasic" id="spnBasic7" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-2"><span name="spnDA" id="spnDA7" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1"><span name="spnHRA" id="spnHRA7" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1">
                                                <input type="text" name="txtHRR" id="txtHRR7" class="form-control form-control-border ManualEntry" data-info="HRR" style="text-align: right;" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1"><span name="txtExempt" id="txtExempt7" value="0.00" /></td>

                                        </tr>
                                        <tr>
                                            <td>5<input type="hidden" id="hdnHrrMthSal8" name="hdnHrrMthSal" value="4" /></td>
                                            <td>Aug</td>
                                            <td style="text-align: right;" class="col-2"><span name="spnBasic" id="spnBasic8" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-2"><span name="spnDA" id="spnDA8" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1"><span name="spnHRA" id="spnHRA8" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1">
                                                <input type="text" name="txtHRR" id="txtHRR8" class="form-control form-control-border ManualEntry" data-info="HRR" style="text-align: right;" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1"><span name="txtExempt" id="txtExempt8" value="0.00" /></td>

                                        </tr>
                                        <tr>
                                            <td>6<input type="hidden" id="hdnHrrMthSal9" name="hdnHrrMthSal" value="4" /></td>
                                            <td>Sept</td>
                                            <td style="text-align: right;" class="col-1"><span name="spnBasic" id="spnBasic9" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1"><span name="spnDA" id="spnDA9" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1"><span name="spnHRA" id="spnHRA9" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1">
                                                <input type="text" name="txtHRR" id="txtHRR9" class="form-control form-control-border ManualEntry" data-info="HRR" style="text-align: right;" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1"><span name="txtExempt" id="txtExempt9" value="0.00" /></td>

                                        </tr>
                                        <tr>
                                            <td>7<input type="hidden" id="hdnHrrMthSal10" name="hdnHrrMthSal" value="4" /></td>
                                            <td>Oct</td>
                                            <td style="text-align: right;" class="col-1"><span name="spnBasic" id="spnBasic10" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1"><span name="spnDA" id="spnDA10" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1"><span name="spnHRA" id="spnHRA10" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1">
                                                <input type="text" name="txtHRR" id="txtHRR10" class="form-control form-control-border ManualEntry" data-info="HRR" style="text-align: right;" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1"><span name="txtExempt" id="txtExempt10" value="0.00" /></td>

                                        </tr>
                                        <tr>
                                            <td>8<input type="hidden" id="hdnHrrMthSal11" name="hdnHrrMthSal" value="4" /></td>
                                            <td>Nov</td>
                                            <td style="text-align: right;" class="col-1"><span name="spnBasic" id="spnBasic11" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1"><span name="spnDA" id="spnDA11" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1"><span name="spnHRA" id="spnHRA11" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1">
                                                <input type="text" name="txtHRR" id="txtHRR11" class="form-control form-control-border ManualEntry" data-info="HRR" style="text-align: right;" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1"><span name="txtExempt" id="txtExempt11" value="0.00" /></td>

                                        </tr>
                                        <tr>
                                            <td>9<input type="hidden" id="hdnHrrMthSal12" name="hdnHrrMthSal" value="4" /></td>
                                            <td>Dec</td>
                                            <td style="text-align: right;" class="col-1"><span name="spnBasic" id="spnBasic12" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1"><span name="spnDA" id="spnDA12" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1"><span name="spnHRA" id="spnHRA12" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1">
                                                <input type="text" name="txtHRR" id="txtHRR12" class="form-control form-control-border ManualEntry" data-info="HRR" style="text-align: right;" value="0.00" /></td>
                                            <td style="text-align: right;" class="col-1"><span name="txtExempt" id="txtExempt12" value="0.00" /></td>

                                        </tr>
                                        <tr>
                                            <td>10<input type="hidden" id="hdnHrrMthSal1" name="hdnHrrMthSal" value="4" /></td>
                                            <td>Jan</td>
                                            <td style="text-align: right;"><span name="spnBasic" id="spnBasic1" value="0.00" /></td>
                                            <td style="text-align: right;"><span name="spnDA" id="spnDA1" value="0.00" /></td>
                                            <td style="text-align: right;"><span name="spnHRA" id="spnHRA1" value="0.00" /></td>
                                            <td style="text-align: right;">
                                                <input type="text" name="txtHRR" id="txtHRR1" class="form-control form-control-border ManualEntry" data-info="HRR" style="text-align: right;" value="0.00" /></td>
                                            <td style="text-align: right;"><span name="txtExempt" id="txtExempt1" value="0.00" /></td>

                                        </tr>
                                        <tr>
                                            <td>11<input type="hidden" id="hdnHrrMthSal2" name="hdnHrrMthSal" value="4" /></td>
                                            <td>Feb</td>
                                            <td style="text-align: right;"><span name="spnBasic" id="spnBasic2" value="0.00" /></td>
                                            <td style="text-align: right;"><span name="spnDA" id="spnDA2" value="0.00" /></td>
                                            <td style="text-align: right;"><span name="spnHRA" id="spnHRA2" value="0.00" /></td>
                                            <td style="text-align: right;">
                                                <input type="text" name="txtHRR" id="txtHRR2" class="form-control form-control-border ManualEntry" data-info="HRR" style="text-align: right;" value="0.00" /></td>
                                            <td style="text-align: right;"><span name="txtExempt" id="txtExempt2" value="0.00" /></td>

                                        </tr>
                                        <tr>
                                            <td>12<input type="hidden" id="hdnHrrMthSal3" name="hdnHrrMthSal" value="4" /></td>
                                            <td>March</td>
                                            <td style="text-align: right;"><span name="spnBasic" id="spnBasic3" value="0.00" /></td>
                                            <td style="text-align: right;"><span name="spnDA" id="spnDA3" value="0.00" /></td>
                                            <td style="text-align: right;"><span name="spnHRA" id="spnHRA3" value="0.00" /></td>
                                            <td style="text-align: right;">
                                                <input type="text" name="txtHRR" id="txtHRR3" class="form-control form-control-border ManualEntry" data-info="HRR" style="text-align: right;" value="0.00" /></td>
                                            <td style="text-align: right;"><span name="txtExempt" id="txtExempt3" value="0.00" /></td>

                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td><b>Total</b></td>
                                            <td style="text-align: right;"><span id="spnGrossTotal" class="col-form-label font-weight-bold">0.00</span></td>
                                            <td colspan="4"></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="col-6" style="margin-top: 1%;">
                            <div class="card card-primary">
                                <div class="card-header">
                                    <h3 class="card-title">HRA Calculator</h3>
                                </div>
                                <div class="table-responsive">
                                    <table class="table  text-nowrap" style="font-size: 18px;">
                                        <tr>
                                            <td><b>Residing in Metro</b>
                                                <span>
                                                    <input class="" id="chkMetro" type="checkbox" checked/></span>
                                            </td>
                                            <%--<td style="text-align: right;">
                                                <label class="switch">
                                                    <input id="chkMetro" type="checkbox" checked />
                                                    <span class="slider round"></span>
                                                </label>
                                            </td>--%>
                                        </tr>
                                        <tr>
                                            <td>Basic Salary</td>
                                            <td style="text-align: right;" class="font-weight-bold"><span>&#8377;  </span>
                                                <label id="lblRightBasicTotal" class="col-form-label font-weight-bold">0.00</label></td>
                                        </tr>
                                        <tr>
                                            <td>DA forming part of Salary</td>
                                            <td style="text-align: right;" class="font-weight-bold"><span>&#8377;  </span>
                                                <label id="lblRightDATotal" class="col-form-label font-weight-bold">0.00</label></td>
                                        </tr>
                                        <tr>
                                            <td>HRA (Rent paid by Deductee)</td>
                                            <td style="text-align: right;" class="font-weight-bold"><span>&#8377;  </span>
                                                <label id="lblRightHRATotal" class="col-form-label font-weight-bold">0.00</label></td>
                                        </tr>
                                        <tr>
                                            <td>HRR (Rent paid by Employee)</td>
                                            <td style="text-align: right;" class="font-weight-bold"><span>&#8377;  </span>
                                                <label id="lblRightHRRTotal" class="col-form-label font-weight-bold">0.00</label></td>
                                        </tr>
                                        <tr>
                                            <td>Exempted House Rent Allowance</td>
                                            <td style="text-align: right;" class="font-weight-bold"><span>&#8377;  </span>
                                                <label id="lblRightExmptedHRATotal" class="col-form-label font-weight-bold">0.00</label></td>
                                        </tr>
                                        <tr>
                                            <td>Taxable House Rent Allowance</td>
                                            <td style="text-align: right;" class="font-weight-bold"><span>&#8377;  </span>
                                                <label id="lblRightTaxableHRATotal" class="col-form-label font-weight-bold">0.00</label></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center;">

                                                <button type="button" id="btnCalculate" class="btn btn-success btn-labeled">Calculate</button>
                                            </td>
                                            <td style="text-align: center;">
                                                <button id="btnReset" class="btn btn-success btn-labeled" type="button">Reset</button>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <%-- **************** Modal Popups *****************************************--%>
</asp:Content>

