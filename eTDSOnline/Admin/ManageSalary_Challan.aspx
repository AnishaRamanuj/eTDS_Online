<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="ManageSalary_Challan.aspx.cs" Inherits="Forms._ManageChallan_Salary" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>
<%@ Import Namespace="System" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="../Scripts/jquery-1.8.2.min.js"></script>
    <script type="text/javascript" language="javascript">

        $(document).ready(function () {
            $(document).on('change', '[id*=txtDateOfAmount]', function (e) {
                $("[id*=hdnDate]").val($("[id*=txtDateOfAmount]").val());
                //dateselection();
            });

            /////////////////////
            if ($("[id*=ddl_Quater]").val() != '') {
                $("[id*=hdnQuarter]").val($("[id*=ddl_Quater]").val());
            }

            if ($("[id*=ddl_month]").val() == 'Apr' || $("[id*=ddl_month]").val() == 'May' || $("[id*=ddl_month]").val() == 'June') {
                $("[id*=ddl_Quater]").val('Q1');
                $("[id*=hdnQuarter]").val('Q1');
            } else if ($("[id*=ddl_month]").val() == 'July' || $("[id*=ddl_month]").val() == 'Aug' || $("[id*=ddl_month]").val() == 'Sept') {
                $("[id*=ddl_Quater]").val('Q2');
                $("[id*=hdnQuarter]").val('Q2');
            }
            else if ($("[id*=ddl_month]").val() == 'Oct' || $("[id*=ddl_month]").val() == 'Nov' || $("[id*=ddl_month]").val() == 'Dec') {
                $("[id*=ddl_Quater]").val('Q3');
                $("[id*=hdnQuarter]").val('Q3');
            }
            else if ($("[id*=ddl_month]").val() == 'Jan' || $("[id*=ddl_month]").val() == 'Feb' || $("[id*=ddl_month]").val() == 'Mar') {
                $("[id*=ddl_Quater]").val('Q4');
                $("[id*=hdnQuarter]").val('Q4');
            }
            ////////////////////////////////////////////////////
            $(document).on('change', '[id*=ddl_month]', function (e) {
                var month = $("[id*=ddl_month]").val();

                if (month == 'Apr' || month == 'May' || month == 'June') {
                    $("[id*=ddl_Quater]").val('Q1');
                    $("[id*=hdnQuarter]").val('Q1');
                } else if (month == 'July' || month == 'Aug' || month == 'Sept') {
                    $("[id*=ddl_Quater]").val('Q2');
                    $("[id*=hdnQuarter]").val('Q2');
                }
                else if (month == 'Oct' || month == 'Nov' || month == 'Dec') {
                    $("[id*=ddl_Quater]").val('Q3');
                    $("[id*=hdnQuarter]").val('Q3');
                }
                else if (month == 'Jan' || month == 'Feb' || month == 'Mar') {
                    $("[id*=ddl_Quater]").val('Q4');
                    $("[id*=hdnQuarter]").val('Q4');
                }
            });


            $("[id*=btnAddEmployee]").live("click", function () {

                var hei = screen.availHeight;
                $("#divAddEmployeee").css("display", "block");
                if (parseFloat(hei) < 650) {
                    $("#divAddEmployeee").css("padding-top", "40px");
                }
                if (parseFloat(hei) < 750) {
                    $("#divAddEmployeee").css("padding-top", "60px");
                }
                if (parseFloat(hei) > 751) {
                    $("#divAddEmployeee").css("padding-top", "150px");
                }
            });

            $("[id*=btnSave]").live("click", function () {
                var empsal = $("[id*=txtTotalDepoAmount]").val();
                var int = $("[id*=txtInterest]").val();
                $("[id*=hdnError]").val('');
                if (empsal == 0 && int == 0) {
                    $("[id*=hdnError]").val('Error');
                }
                
                var err = 0;

                //validate_Values();
                //$("input[id=chkRow]:checked").each(function () {
                //    var row = $(this).closest("tr");
                //    var A = row.find("input[id=txtAmount]").val();
                //    if (A <= 0)
                //    {
                //        err = err + 1;
                //    }
                //    var eid = row.find("input[name=hdnEmployeeID]").val();
                //    var t = row.find("input[id=txtTds]").val();
                //    var s = row.find("input[id=txtSur]").val();
                //    var e = row.find("input[id=txtECess]").val();
                //    var h = row.find("input[id=txtHCess]").val();
                //    var tt = row.find("input[id=txtTotalTax]").val();
                //    if (t == '')
                //    { row.find("input[id=txtTds]").val('0'); }
                //    if (s == '') {
                //        s = '0';
                //        row.find("input[id=txtSur]").val('0');
                //    }
                //    if (e == '') {
                //        e = '0';
                //        row.find("input[id=txtECess]").val('0');
                //    }
                //    if (h == '') {
                //        h = '0';
                //        row.find("input[id=txtHCess]").val('0');
                //    }
                //    if (tt == '') {
                //        tt = '0';
                //        row.find("input[id=txtTotalTax]").val('0');
                //    }
                //    var rs = parseFloat(t) + parseFloat(s) + parseFloat(e) + parseFloat(h)
                //    if (parseFloat(tt) == parseFloat(rs))
                //    { }
                //    else {
                //        row.find("input[id=txtTotalTax]").val(rs);
                //    }
                //});

                if (err > 0 )
                {
                    alert('Salary Amount cannot be Zero');
                    $("[id*=hdnError]").val('Error');
                }
            });

            $("[id*=btnSubmitAddEmployee]").live("click", function () {
                $("#divAddEmployeee").css("display", "none");

                var IsValid = false;
                var gridView = document.getElementById("<%=gvAddEmployeeGrid.ClientID %>");
                var checkBoxes = gridView.getElementsByTagName("input");
                for (var i = 0; i < checkBoxes.length; i++) {
                    if (checkBoxes[i].type == "checkbox" && checkBoxes[i].checked) {
                        IsValid = true;
                        return;
                    }
                }
                return IsValid;
            });
            $("[id*=btnClose]").live("click", function () {
                $("#divAddEmployeee").css("display", "none");

                var gridView = document.getElementById("<%=gvAddEmployeeGrid.ClientID %>");
                var checkBoxes = gridView.getElementsByTagName("input");
                for (var i = 0; i < checkBoxes.length; i++) {
                    if (checkBoxes[i].type == "checkbox" && checkBoxes[i].checked) {
                        checkBoxes[i].checked = false;
                    }
                }
                return false;
            });

            $("[id*=ddlBank]").live("change", function () {
                var parm = document.getElementById("<%=ddlBank.ClientID %>");
                // Get Dropdownlist selected value itemMasterPage_
                if (parm.options[parm.selectedIndex].value != '0') {
                    $('[id*=txtBranch_Code]').val(parm.options[parm.selectedIndex].value);
                }
                else { $('[id*=txtBranch_Code]').val(''); }
            });

           

            $("[id*=txtTds]").live("keyup", function () {
                txt($(this));
            });

            ///////////////////sur
            $("[id*=txtSur]").live("keyup", function () {
                txt($(this));
            });

            /////////////eaa
            $("[id*=txtECess]").live("keyup", function () {
                txt($(this));
            });

            /////////////hess
            $("[id*=txtHCess]").live("keyup", function () {

                txt($(this));
            });




            $("[id*=txtAmount]").live("keyup", function () {
                var val = $(this).val();
                if (isNaN(val)) {
                    val = val.replace(/[^0-9\.]/g, '');
                    if (val.split('.').length > 2)
                        val = val.replace(/\.+$/, "");
                }
                $(this).val(val);
            });

            $("[id*=txtChallanNo]").live("keyup", function () {
                var val = $(this).val();
                if (isNaN(val)) {
                    val = val.replace(/[^0-9\.]/g, '');
                    if (val.split('.').length > 2)
                        val = val.replace(/\.+$/, "");
                }
                $(this).val(val);

            });

            $("[id*=txtTDSAmount]").live("keyup", function () {
                valTextbox($(this));
            });

            $("[id*=txt_Surcharge]").live("keyup", function () {
                valTextbox($(this));
            });

            $("[id*=txtEducationCess]").live("keyup", function () {
                valTextbox($(this));
            });

            $("[id*=txtHECess]").live("keyup", function () {
                valTextbox($(this));
            });

            $("[id*=txtInterest]").live("keyup", function () {
                valTextbox($(this));
            });

            $("[id*=txtOthers]").live("keyup", function () {
                valTextbox($(this));
            });

            $("[id*=txtFees]").live("keyup", function () {
                valTextbox($(this));
            });


            $(document).on('change', '[id*=chkHeader]', function (e) {

                var chkHeader = $(this);
                var i = $(this);
                var chkprop = i.is(':checked');
                //Find and reference the GridView.
                //var grid = $(this).closest("table");
                var grid = $("[id*=dgEmployee]");

                //Loop through the CheckBoxes in each Row.

                if (chkprop) {
                    $("[id*=chkRow]").attr('checked', 'checked');
                    $("[id*=txtAmount]").attr("readonly", false);
                    $("[id*=txtTds]").attr("readonly", false);
                    $("[id*=txtSur]").attr("readonly", false);
                    $("[id*=txtECess]").attr("readonly", false);
                    $("[id*=xtHCess]").attr("readonly", false);
                    caltotalDepo();
                    //$("[id*=dvextdt]").show();
                }
                else {
                    $("[id*=chkRow]").removeAttr('checked');
                    $("[id*=txtAmount]").attr("readonly", true);
                    $("[id*=txtTds]").attr("readonly", true);
                    $("[id*=txtSur]").attr("readonly", true);
                    $("[id*=txtECess]").attr("readonly", true);
                    $("[id*=xtHCess]").attr("readonly", true);
                    caltotalDepo();

                }


                FillFooter();
            });

            //Enable Disable TextBoxes in a Row when the Row CheckBox is checked.
            $(document).on('change', '[id*=chkRow]', function (e) {

                //Find and reference the GridView.
                var grid = $(this).closest("table");

                //Find and reference the Header CheckBox.
                var chkHeader = $("[id*=chkHeader]");

                //If the CheckBox is Checked then enable the TextBoxes in thr Row.
                if (!$(this).is(":checked")) {
                    var td = $("td", $(this).closest("tr"));
                    $("input[type=text]", td).attr("readonly", "readonly");
                    $("input[type=text][id*=txtTotalDepo]", td).attr("readonly", "readonly");
                    $("input[type=text][id*=txtTotalTax]", td).attr("readonly", "readonly");
                    $("input[type=text][id*=txtTds]", td).val(0);
                    $("input[type=text][id*=txtSur]", td).val(0);
                    $("input[type=text][id*=txtECess]", td).val(0);
                    $("input[type=text][id*=txtHCess]", td).val(0);
                    $("input[type=text][id*=txtTotalTax]", td).val(0);
                    $("input[type=text][id*=txtTotalDepo]", td).val(0);
                    FillFooter();
                    caltotalDepo();
                } else {
                    var td = $("td", $(this).closest("tr"));
                    $("input[type=text]", td).removeAttr("readonly");
                    $("input[type=text][id*=txtTotalDepo]", td).attr("readonly", "readonly");
                    $("input[type=text][id*=txtTotalTax]", td).attr("readonly", "readonly");
                    caltotalDepo();
                }

                //Enable Header Row CheckBox if all the Row CheckBoxes are checked and vice versa.
                if ($("[id*=chkRow]", grid).length == $("[id*=chkRow]:checked", grid).length) {
                    chkHeader.attr("checked", "checked");
                    caltotalDepo();
                } else {
                    chkHeader.removeAttr("checked");
                    caltotalDepo();
                }
                FillFooter();
            });




            $("[id*=chkHeaderAddEmp]").live("click", function () {
                var chkHeader = $(this);
                var grid = $(this).closest("table");
                $("input[type=checkbox]", grid).each(function () {
                    if (chkHeader.is(":checked")) {
                        $(this).attr("checked", "checked");
                        $("td", $(this).closest("tr")).addClass("selected");
                    } else {
                        $(this).removeAttr("checked");
                        $("td", $(this).closest("tr")).removeClass("selected");
                    }
                });
            });
            $("[id*=chkRowAddEmp]").live("click", function () {
                var grid = $(this).closest("table");
                var chkHeader = $("[id*=chkHeaderAddEmp]", grid);
                if (!$(this).is(":checked")) {
                    $("td", $(this).closest("tr")).removeClass("selected");
                    chkHeader.removeAttr("checked");
                } else {
                    $("td", $(this).closest("tr")).addClass("selected");
                    if ($("[id*=chkRowAddEmp]", grid).length == $("[id*=chkRowAddEmp]:checked", grid).length) {
                        chkHeader.attr("checked", "checked");
                    }
                }
            });
 
        });


        function CalcuTextbox() {
             var tds = $("input[type=text][id*=txtTDSAmount]").val();
            var surcharge = $("input[type=text][id*=txt_Surcharge]").val();
            var ECess = $("input[type=text][id*=txtEducationCess]").val();
            var Hecss = $("input[type=text][id*=txtHECess]").val();
            var Interest = $("input[type=text][id*=txtInterest]").val();
            var Others = $("input[type=text][id*=txtOthers]").val();
            var Fees = $("input[type=text][id*=txtFees]").val();

            if (isNaN(tds) || tds == "")
            {
                tds = 0;
                $("input[type=text][id*=txtTDSAmount]").val('0');
            }
            if (isNaN(surcharge) || surcharge == "")
            {
                surcharge = 0;
                $("input[type=text][id*=txt_Surcharge]").val('0');
            }
            if (isNaN(ECess) || ECess == "")
            {
                ECess = 0;
                $("input[type=text][id*=txtEducationCess]").val('0');
            }
            if (isNaN(Hecss) || Hecss == "")
            {
                Hecss = 0;
                $("input[type=text][id*=txtHECess]").val('0');
            }
            if (isNaN(Interest) || Interest == "")
            {
                Interest = 0;
                $("input[type=text][id*=txtInterest]").val('0');
            }
            if (isNaN(Others) || Others == "")
            {
                Others = 0;
                $("input[type=text][id*=txtOthers]").val('0');
            }
            if (isNaN(Fees) || Fees == "")
            {
                Fees = 0;
                $("input[type=text][id*=txtFees]").val('0');
            }

            var result = 0;

            result = parseFloat(tds) + parseFloat(surcharge) + parseFloat(ECess) + parseFloat(Hecss) + parseFloat(Interest) + parseFloat(Others) + parseFloat(Fees);
            $(document.getElementById('<%=txtTotal.ClientID %>')).val(result);

        }

        function valTextbox(objref) {

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

            if (isNaN(tds) || tds == "")
            { tds = 0; }
            if (isNaN(surcharge) || surcharge == "")
            { surcharge = 0; }
            if (isNaN(ECess) || ECess == "")
            { ECess = 0; }
            if (isNaN(Hecss) || Hecss == "")
            { Hecss = 0; }
            if (isNaN(Interest) || Interest == "")
            { Interest = 0; }
            if (isNaN(Others) || Others == "")
            { Others = 0; }
            if (isNaN(Fees) || Fees == "")
            { Fees = 0; }

            var result = 0;

            result = parseFloat(tds) + parseFloat(surcharge) + parseFloat(ECess) + parseFloat(Hecss) + parseFloat(Interest) + parseFloat(Others) + parseFloat(Fees);
            $(document.getElementById('<%=txtTotal.ClientID %>')).val(result);

        }

        function MakeFixedTableFooter() {

            FillFooter();
        }


        function FillFooter() {
            var TotalfinalAmt = 0, totalfinalTds = 0, totalfinalsur = 0, totalfinalecess = 0, totoalfinalhcess = 0, totalfinaltoaltax = 0, totalfinaltotaldepo = 0;
            $("[id*=chkRow]:checked").each(function () {
                var row = $(this).closest("tr");
                var amt = $("[id*=txtAmount]", $(this).closest("tr")).val();
                var tds = $("[id*=txtTds]", $(this).closest("tr")).val();
                var sur = $("[id*=txtSur]", $(this).closest("tr")).val();
                var ecess = $("[id*=txtECess]", $(this).closest("tr")).val();
                var hcess = $("[id*=txtHCess]", $(this).closest("tr")).val();
                var tTax = $("[id*=txtTotalTax]", $(this).closest("tr")).val();
                var tdepo = $("[id*=txtTotalDepo]", $(this).closest("tr")).val();
			   if (amt == '')
			   {
			       $("[id*=txtAmount]", $(this).closest("tr")).val(0);
			     amt =0;
			   }
			   if (tds == ''|| tds==NaN)
			   {
			       $("[id*=txtTds]", $(this).closest("tr")).val(0);
			      tds =0;
			   }
			   if (sur =='')
			   {
			       $("[id*=txtSur]", $(this).closest("tr")).val(0);
			      sur =0; 
			   }
			   if (ecess == '')
			   {
			       $("[id*=txtECess]", $(this).closest("tr")).val(0);
			      ecess=0;
			   }
			   if (hcess == '')
			   {
			       $("[id*=txtHCess]", $(this).closest("tr")).val(0);
			      hcess =0;
			   }
			   if (tTax =='')
			   {
			       $("[id*=txtTotalTax]", $(this).closest("tr")).val(0);
			       tTax =0;
			   }
			   if (tdepo == '')
			   {
			       $("[id*=txtTotalDepo]", $(this).closest("tr")).val(0);
				   tdepo =0;	 
			   }
			   var rr = parseFloat(tds) + parseFloat(sur) + parseFloat(ecess) + parseFloat(hcess);
			   $("[id*=txtTotalDepo]", $(this).closest("tr")).val(rr);
                TotalfinalAmt += parseFloat(amt);
                totalfinalTds += parseFloat(tds);
                totalfinalsur += parseFloat(sur);
                totalfinalecess += parseFloat(ecess);
                totoalfinalhcess += parseFloat(hcess);
                totalfinaltoaltax += parseFloat(tdepo);
                totalfinaltotaldepo += parseFloat(tTax);
            });
            caltotalDepo();


            $("[id*=Label518]").html(TotalfinalAmt);
            $("[id*=Label512]").html(totalfinalTds);
            $("[id*=Label513]").html(totalfinalsur);
            $("[id*=Label514]").html(totalfinalecess);
            $("[id*=Label515]").html(totoalfinalhcess);
            $("[id*=Label516]").html(totalfinaltoaltax);
            $("[id*=Label517]").html(totalfinaltotaldepo);

            $("[id*=txtTDSAmount]").val(totalfinalTds);
            $("[id*=txt_Surcharge]").val(totalfinalsur);
            $("[id*=txtEducationCess]").val(totalfinalecess);
            $("[id*=txtHECess]").val(totoalfinalhcess);

            var t = $("[id*=Label512]").html();
            var s = $("[id*=Label513]").html();
            var e = $("[id*=Label514]").html();
            var h = $("[id*=Label515]").html();
            var f = $("[id*=Label516]").html();
            var ltl = $("[id*=Label517]").html();
            var rr = parseFloat(t) + parseFloat(s) + parseFloat(e) + parseFloat(h);
            f = rr;
            ltl = rr
            $("[id*=Label516]").html(f);
            $("[id*=Label517]").html(ltl);

            CalcuTextbox();
        }




        function txt(objref) {
            var row = objref.closest("tr");
            if (isNaN(parseInt(objref.val()))) {
                objref.val('0');
            } else {
                objref.val(parseFloat(objref.val()).toString());
            }
            var grid = objref.closest("table");

            //Find and reference the Header CheckBox.
            var chkHeader = $("[id*=chkHeader]", grid);

            //If the CheckBox is Checked then enable the TextBoxes in thr Row.
            if (!objref.is(":checked")) {
                var result = 0;
                var td = $("td", objref.closest("tr"));
                td.css({ "background-color": "#FFF" });
                var amt = $("input[type=text][id*=txtAmount]", td).val();
                var txt1 = $("input[type=text][id*=txtTds]", td).val();
                var txt2 = $("input[type=text][id*=txtSur]", td).val();
                var txt3 = $("input[type=text][id*=txtECess]", td).val();
                var txt4 = $("input[type=text][id*=txtHCess]", td).val();
                 
                if (amt != "" && amt != "0" && amt != "0.00") {


                    if (!isNaN(parseFloat(txt1)))
                        result += parseFloat(txt1);

                    if (!isNaN(parseFloat(txt2)))
                        result += parseFloat(txt2);

                    if (!isNaN(parseFloat(txt3)))
                        result += parseFloat(txt3);

                    if (!isNaN(parseFloat(txt4)))
                        result += parseFloat(txt4);

                    if (amt <= result) {
                        $("input[type=text][id*=txtTds]", td).val(0);
                        $("input[type=text][id*=txtSur]", td).val(0);
                        $("input[type=text][id*=txtECess]", td).val(0);
                        $("input[type=text][id*=txtHCess]", td).val(0);
                        result = 0;
                        alert('Salary Amount cannot be less or equal to total tds amount')
                        return;
                    }
                    else {
                        $("input[type=text][id*=txtTotalTax]", td).val(result);
                        $("input[type=text][id*=txtTotalDepo]", td).val(result);
                    }
                }

                else {
                    $("input[type=text][id*=txtTds]", td).val(0);
                    $("input[type=text][id*=txtSur]", td).val(0);
                    $("input[type=text][id*=txtECess]", td).val(0);
                    $("input[type=text][id*=txtHCess]", td).val(0);
                }

                caltotalDepo();
            }
            FillFooter();
        }

        function caltotalDepo() {
            var grandTotal = 0;
            $(".TextboxInt").each(function () {
                grandTotal = grandTotal + parseFloat($(this).val());
            });
            $("input[type=text][id*=txtTotalDepoAmount]").val(grandTotal);
            $(".totalDeposit").val(grandTotal);

            
            var t =$("[id*=Label512]").html();
            var s =$("[id*=Label513]").html();
            var e =$("[id*=Label514]").html();
            var h =$("[id*=Label515]").html();
            var f =$("[id*=Label516]").html();
            var ltl = $("[id*=Label517]").html();
            var rr = parseFloat(t) + parseFloat(s) + parseFloat(e) + parseFloat(h);
            f = rr;
            ltl = rr
            $("[id*=Label516]").html(f);
            $("[id*=Label517]").html(ltl);
        }

        function validate_Values()
        {
            var tds = $("input[type=text][id*=txtTDSAmount]").val();
            var surcharge = $("input[type=text][id*=txt_Surcharge]").val();
            var ECess = $("input[type=text][id*=txtEducationCess]").val();
            var H = $("input[type=text][id*=txtHECess]").val();
            var I = $("input[type=text][id*=txtInterest]").val();
            var O = $("input[type=text][id*=txtOthers]").val();
                if (tds == "" || tds== undefined)
                { tds = '0'; }
                if (surcharge == '' || surcharge == undefined)
                { surcharge = '0'; }
                if (ECess == '' || ECess == undefined)
                { ECess = '0'; }
                if (H == '' || H == undefined)
                { H = '0'; }
                if (I == '' || I == undefined)
                { I = '0'; }
                if (O == '' || O == undefined)
                { O = '0'; }
                var rr = '0';
                rr = parseFloat(tds) + parseFloat(surcharge) + parseFloat(ECess);
                rr = parseFloat(rr) + parseFloat(H) + parseFloat(I);
                var ttl = $("input[type=text][id*=txtTotalDepoAmount]").val();
               
        }

 

        function ValidationCustomforTotalDe(sender, args) {
            var tds = $("input[type=text][id*=txtTDSAmount]").val();
            var surcharge = $("input[type=text][id*=txt_Surcharge]").val();
            var ECess = $("input[type=text][id*=txtEducationCess]").val();
            var Hecss = $("input[type=text][id*=txtHECess]").val();
            var Int = $("input[type=text][id*=txtInterest]").val();

            if (isNaN(tds) || tds == "")
            { tds = 0; }
            if (isNaN(surcharge) || surcharge == "")
            { surcharge = 0; }
            if (isNaN(ECess) || ECess == "")
            { ECess = 0; }
            if (isNaN(Hecss) || Hecss == "")
            { Hecss = 0; }

            var result = 0;

            result = parseFloat(tds) + parseFloat(surcharge) + parseFloat(ECess) + parseFloat(Hecss) + parseFloat(Int);

            var total = $("input[type=text][id*=txtTotalDepoAmount]").val();

            var gridt = $("[id*=hdnRowsOfGrid]").val();

            if (gridt != '0') {
                if (parseFloat(result) >= parseFloat(total)) {
                    args.IsValid = true;
                }
                else {
                    args.IsValid = false;
                }
            }
        }

        function ValidateTotalIsNoZero(sender, args) {

            var status = $('#rdoNo').attr('checked') ? true : false;
            var total = $("input[type=text][id*=txtTotalDepoAmount]").val();
            if (status == true) {
                if (total == "0") {
                    args.IsValid = false;
                }
            }
            var s = $("[id*=txt_Surcharge]").val();
            var e = $("[id*=txtEducationCess]").val();
            var i = $("[id*=txtInterest]").val();
            var ise = parseFloat(s) + parseFloat(e) + parseFloat(i);
            var t = $("[id*=txtTDSAmount]").val();

            if (parseFloat(t) == 0 && ise > 0) {
                args.IsValid = true;
                return;
            }
            else { args.IsValid = true; }
        }


        function ValidationCh(sender, args) {
            var le = $("[id*=txtChallanNo]").val();
            //if (le.length == 5) {
                args.IsValid = true;
            //}
            //else { args.IsValid = false; }
        }

        function DateValidationWithSelectdQuarter(sender, args) {

            var result = 0;
            var parm = document.getElementById('<%=ddl_Quater.ClientID%>');
            var sel = parm.options[parm.selectedIndex].value;
            var txt1 = document.getElementById('<%=txtDateOfAmount.ClientID%>').value;
            var fy = $("[id*=hdnfinYear]").val();
            fy = fy.split('_');
            fy[1] = '20' + fy[1];
            var m1 = txt1.split('/');
            //var m2 = txt2.split('/');
            if (sel == 'Q1') {
                if (m1[1] == '04' || m1[1] == '05' || m1[1] == '06')
                {
                    if (fy[0] == m1[2]) {
                        result = parseFloat(result) + 1;
                    }
                }
                //if (m2[1] == '04' || m2[1] == '05' || m2[1] == '06')
                //{ result = parseFloat(result) + 1; }
            }
            if (sel == 'Q2') {
                if (m1[1] == '07' || m1[1] == '08' || m1[1] == '09')
                {
                    if (fy[0] == m1[2]) {
                        result = parseFloat(result) + 1;
                    }
                }
                //if (m2[1] == '07' || m2[1] == '08' || m2[1] == '09')
                //{ result = parseFloat(result) + 1; }
            }
            if (sel == 'Q3') {
                if (m1[1] == '10' || m1[1] == '11' || m1[1] == '12')
                {
                    if (fy[0] == m1[2]) {
                        result = parseFloat(result) + 1;
                    }
                }
                //if (m2[1] == '10' || m2[1] == '11' || m2[1] == '12')
                //{ result = parseFloat(result) + 1; }
            }
            if (sel == 'Q4') {
                if (m1[1] == '01' || m1[1] == '02' || m1[1] == '03')
                {
                    if (fy[1] == m1[2]) {
                        result = parseFloat(result) + 1;
                    }
                }
                //if (m2[1] == '01' || m2[1] == '02' || m2[1] == '03')
                //{ result = parseFloat(result) + 1; }
            }

            if (result == 1)
            { args.IsValid = true; }
            else { args.IsValid = false; }

            if (sel == "0")
            { args.IsValid = true; }

        }

        function ValidateGridViewCheckbox(sender, args) {
            var gridView = document.getElementById("<%=dgEmployee.ClientID %>");
            var checkBoxes = gridView.getElementsByTagName("input");
            for (var i = 0; i < checkBoxes.length; i++) {
                if (checkBoxes[i].type == "checkbox" && checkBoxes[i].checked) {
                    args.IsValid = true;
                    return;
                }

            }
            var s = $("[id*=txt_Surcharge]").val();
            var e = $("[id*=txtEducationCess]").val();
            var i = $("[id*=txtInterest]").val();
            var ise = parseFloat(s) + parseFloat(e) + parseFloat(i);
            var t = $("[id*=txtTDSAmount]").val();

            if (parseFloat(t) == 0 && ise > 0)
            {
                args.IsValid = true;
                return;
            }

            args.IsValid = false;
        }

        function ValidationForChallanDateWithinFinacial(sender, args) {

            var ChallanDate = $("[id*=txtChallanDate]").val();
            var ChallanDateSplit = ChallanDate.split('/');
            var financialyears = $("#ddlFinancialYear option:selected").text();
            var startfin = financialyears.split('_');
            var res = fn_DateCompare('04/01/' + startfin[0], ChallanDateSplit[1] + '/' + ChallanDateSplit[0] + '/' + ChallanDateSplit[2]);

            if ('04/01/' + startfin[0] == ChallanDateSplit[1] + '/' + ChallanDateSplit[0] + '/' + ChallanDateSplit[2])
            { res = 0; }

            if (res == 0) {
                args.IsValid = true;
            }
            else { args.IsValid = false; }
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
            //            if(parseInt(DateB.replace(/-/g,""),10)>parseInt(DateA.replace(/-/g,""),10)) {
            //                return 0;
            //            } else if(parseInt(DateB.replace(/-/g,""),10)>parseInt(DateA.replace(/-/g,""),10)) {
            //                return 1;
            //            }

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


        //function ValidationBSRCODE(sender, args) {

        //    var bsr = $("[id*=txtBranch_Code]").val();

        //    if (bsr.length != 7) {
        //        args.IsValid = false;
        //        return;

        //    } else {
        //        args.IsValid = true;
        //    }

        //}

    </script>
    <style type="text/css">
        #tblfixedHeaderFor {
            border-collapse: collapse;
        }

            #tblfixedHeaderFor th {
                margin: 0;
                border-collapse: collapse;
                border: 1px solid #DBDBDB;
                height: 25px;
            }

        #fixedBorderfordgEmployee {
            border-collapse: collapse;
        }

            #fixedBorderfordgEmployee td {
                margin: 0;
                border-collapse: collapse;
                border: 1px solid #DBDBDB;
                height: 25px;
                background-color: #f3f3f3;
            }

        .scrollDisabled {
            position: fixed;
            margin-top: 0;
            width: 100%;
        }

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

        .CssForHideDiv {
            position: fixed;
            z-index: 999;
            height: 100%;
            width: 1000px;
            top: 0;
            background-color: rgba(0,0,0,.2);
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

        .TextboxInt {
            font: normal 12px verdana, arial, "Trebuchet MS", sans-serif;
            text-align: right;
            border-radius: 4px;
            height: 25px;
            border: 1px solid #b5b5b5;
        }

        .aligntoright {
            text-align: right;
        }

        .masterwhole {
            min-height: 500px;
        }

        .cssTextboxInt {
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
            font-size:16px;
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:ValidationSummary ID="ValidationSummary1" ShowMessageBox="true" ShowSummary="false"
        ValidationGroup="ValidThis" runat="server" />
 
   <asp:HiddenField ID="hdnError" runat="server" />
   <asp:HiddenField ID="hdnfinYear" runat="server" />
    <table id="Table3" runat="server" width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td class="cssPageTitle">
                <asp:Label ID="lblHeaer" runat="server" Text="Challan ITNS 281 : Form 24Q  "></asp:Label>
                <table style="width: 104%;">
                    <tr>
                        <td>
                            <asp:Label ID="Label14" runat="server" Text="Month:"></asp:Label></td>
                        <td>
                            <asp:DropDownList ID="ddl_month" runat="server" CssClass="cssDropDownList">
                                <asp:ListItem Value="0" Selected="True">( Select )</asp:ListItem>
                                <asp:ListItem Value="Apr">Apr</asp:ListItem>
                                <asp:ListItem Value="May">May</asp:ListItem>
                                <asp:ListItem Value="June">June</asp:ListItem>
                                <asp:ListItem Value="July">July</asp:ListItem>
                                <asp:ListItem Value="Aug">Aug</asp:ListItem>
                                <asp:ListItem Value="Sept">Sept</asp:ListItem>
                                <asp:ListItem Value="Oct">Oct</asp:ListItem>
                                <asp:ListItem Value="Nov">Nov</asp:ListItem>
                                <asp:ListItem Value="Dec">Dec</asp:ListItem>
                                <asp:ListItem Value="Jan">Jan</asp:ListItem>
                                <asp:ListItem Value="Feb">Feb</asp:ListItem>
                                <asp:ListItem Value="Mar">Mar</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddl_month"
                                Display="None" InitialValue="0" ErrorMessage="Please Select Month !" ValidationGroup="ValidThis1"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:Label ID="Label5" runat="server" Text="Quarter:"></asp:Label></td>
                        <td>
                            <asp:DropDownList ID="ddl_Quater" runat="server" CssClass="cssDropDownList" disabled>
                                <asp:ListItem Value="0" Selected="True">( Select )</asp:ListItem>
                                <asp:ListItem>Q1</asp:ListItem>
                                <asp:ListItem>Q2</asp:ListItem>
                                <asp:ListItem>Q3</asp:ListItem>
                                <asp:ListItem>Q4</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddl_Quater"
                                Display="None" InitialValue="0" ErrorMessage="Please Select Quarter !" ValidationGroup="ValidThis1"></asp:RequiredFieldValidator>
                        </td>

                        <td>
                            <asp:Label ID="Label2" runat="server" Text="Dt. of Salary"></asp:Label>
                            <%--<asp:Label ID="Label19" runat="server" Text="Dt. of Amt Paid" CssClass="cssLabel"></asp:Label>--%>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDateOfAmount" runat="server" Width="80px" CssClass="cssTextbox"></asp:TextBox>
                            <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtDateOfAmount"
                                Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" />
                            <asp:ImageButton ID="ImageButton1" ImageUrl="~/Images/calendar.gif" runat="server" />
                            <cc1:CalendarExtender runat="server" ID="cal1" PopupButtonID="ImageButton1" TargetControlID="txtDateOfAmount"
                                Format="dd/MM/yyyy">
                            </cc1:CalendarExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddl_Quater"
                                Display="None" InitialValue="0" ErrorMessage="Please Select Quarter !" ValidationGroup="ValidThis1"></asp:RequiredFieldValidator>
                        </td>
                        <td colspan="2">
                            <asp:CustomValidator ID="CustomValidator3" Display="None" runat="server" ValidationGroup="ValidThis1"
                                ClientValidationFunction="DateValidationWithSelectdQuarter" ErrorMessage="Please check  Dt. of Amt Paid with in the selected Quarter !"></asp:CustomValidator>
                            <center>
                                <asp:Button runat="server" ID="btnGetChallanList" CssClass="cssButton" Text="Next"
                                    OnClick="btnGetChallanList_OnClick" ValidationGroup="ValidThis1" />
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <asp:Button ID="btnCancel0" runat="server" CssClass="cssButton" Text="Cancel" PostBackUrl="~/Admin/ManageSalary_ChallanList.aspx" />
                            </center>
                        </td>

                        <td style="text-align: right">
                            <asp:CustomValidator ID="CustomValidator4" ValidationGroup="ValidThis" runat="server"
                                ErrorMessage="Please Select At Least One Record From Name of TDS Paid Employees In This Challan !"
                                ClientValidationFunction="ValidateGridViewCheckbox" Display="None"></asp:CustomValidator>
                            <asp:CustomValidator ID="CustomValidator6" ValidationGroup="ValidThis" runat="server"
                                Display="None" ClientValidationFunction="ValidationForChallanDateWithinFinacial"
                                Enabled="false" ErrorMessage="Invalid Challan Date With in Selected Financial Year Or Challan Date Must be Equal or less than Current Date !"></asp:CustomValidator>
                            <asp:Button runat="server" ID="btnSave" CssClass="cssButton" Text="Save" ValidationGroup="ValidThis"
                                OnClick="btnSave_OnClick" />

                            <asp:CustomValidator ID="CustomValidator1" runat="server" Display="None" ClientValidationFunction="ValidationCustomforTotalDe"
                                ValidationGroup="ValidThis" ErrorMessage="Total Of (TDS + Surcharge + E.Cess + HE Cess) Greate Than OR Equal To Total Deposit Amount"></asp:CustomValidator>
                            <asp:CustomValidator ID="CustomValidator5" runat="server" Display="None" ClientValidationFunction="ValidateTotalIsNoZero"
                                ValidationGroup="ValidThis" ErrorMessage="Total Deposit Amount Must Be Greater than Zero,it's NOT a NIL Challan"></asp:CustomValidator>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                           <asp:Button runat="server" ID="btnCancel" CssClass="cssButton" Text="Cancel" PostBackUrl="~/Admin/ManageSalary_ChallanList.aspx" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>
                </table>
                <asp:HiddenField ID="hdnCompanyID" runat="server" />
                 <asp:HiddenField ID="hdnQuarter" runat="server" />
                 <asp:HiddenField ID="hdnDate" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <UC:MessageControl runat="server" ID="ucMessageControl" />
            </td>
        </tr>
        <tr>
            <td runat="server" id="tdGrid" style="margin-top: 0px; padding-top: 0px;">
                <table id="tbl_Start" runat="server" align="center" style="margin-top: 0px; padding-top: 0px;">
                    <tr>
                        <td>
                            <asp:ValidationSummary ValidationGroup="ValidThis1" ID="Challan" runat="server" ShowMessageBox="true"
                                ShowSummary="false" />
                            <%--    <fieldset style="margin-top: 0px; padding-top: 0px; margin-bottom: 0px;">
                                        <legend>Challan Pay Type</legend>--%>
                            <table id="Table7" runat="server" width="100%">
                            </table>
                            <%--</fieldset>--%>
                        </td>
                    </tr>
                </table>
                <table id="tbl_Data" runat="server" visible="false" style="margin-top: 0px; padding-top: 10px;"
                    width="100%">
                    <tr>
                        <td valign="top" style="margin-top: 0px; padding-top: 0px;">
                            <asp:TabContainer ID="TabContainer1" runat="server" CssClass="Tab" ActiveTabIndex="0"  >
                                <asp:TabPanel ID="TabPanel1" runat="server" Width="100%" HeaderText="Challan Details">
                                    <ContentTemplate>
                                        <table id="Table15" runat="server" width="100%" style="margin-top: 0px; padding-top: 0px;">
                                            <tr>
                                                <td>

                                                    <%--<legend>Challan Pay Type</legend>--%>
                                                    <table id="Table4" runat="server" width="100%" cellpadding="2" cellspacing="0">
      <%--                                                  <tr>
                                                            <td>
                                                                <asp:Label ID="Label4" runat="server" Font-Bold="true" Text="Nil Challan"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:RadioButton runat="server" ID="rdoYes" CssClass="cssLabel" GroupName="IsChallan"
                                                                    Text="Yes" />
                                                                <asp:RadioButton runat="server" ID="rdoNo" ClientIDMode="Static" CssClass="cssLabel"
                                                                    GroupName="IsChallan" Text="No" Checked="true" />
                                                            </td>

                                                        </tr>--%>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label6" runat="server" Font-Bold="true" Text="Bank Name"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList runat="server" ID="ddlBank" CssClass="cssDropDownList" Width="500px">
                                                                </asp:DropDownList>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" InitialValue="" ControlToValidate="ddlBank"
                                                                    Display="None" ValidationGroup="ValidThis" runat="server" ErrorMessage="Please Select Bank Name !"></asp:RequiredFieldValidator>
                                                            </td>

                                                        </tr>
                                                    </table>

                                                </td>
                                            </tr>
                                            <tr>
                                                <td>

                                                    <%--<legend>Challan Pay Type</legend>--%>
                                                    <table runat="server" id="Table2" cellpadding="3" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td style="width: 145px;">
                                                                <asp:Label ID="Label3" runat="server" Font-Bold="true" Text="Challan No"></asp:Label>
                                                            </td>
                                                            <td style="width: 270px;">
                                                                <asp:TextBox ID="txtChallanNo" oncopy="return false" onpaste="return false" oncut="return false"
                                                                    runat="server" CssClass="cssTextbox" MaxLength="5" Width="60"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtChallanNo"
                                                                    Display="None" ValidationGroup="ValidThis" runat="server" ErrorMessage="Please Enter Challan No. !"></asp:RequiredFieldValidator>
<%--                                                                <asp:CustomValidator ID="CustomValidator2" ValidationGroup="ValidThis" runat="server"
                                                                    ControlToValidate="txtChallanNo" ErrorMessage="Please Enter 5 Digit Challan No !"
                                                                    ClientValidationFunction="ValidationCh" Display="None"></asp:CustomValidator>--%>
                                                            </td>
                                                            <td style="width: 100px;">
                                                                <asp:Label ID="Label1" runat="server" Font-Bold="true" Text="Challan Date"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtChallanDate" runat="server" Width="100px" CssClass="cssTextbox"></asp:TextBox>
                                                                <asp:MaskedEditExtender ID="MaskedEditExtender3" runat="server" TargetControlID="txtChallanDate"
                                                                    Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" />
                                                                <asp:ImageButton ID="ImageButton3" ImageUrl="~/Images/calendar.gif" runat="server" />
                                                                <cc1:CalendarExtender ID="CalendarExtender2" TargetControlID="txtChallanDate" PopupButtonID="ImageButton3"
                                                                    Format="dd/MM/yyyy" runat="server">
                                                                </cc1:CalendarExtender>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtChallanDate"
                                                                    Display="None" ValidationGroup="ValidThis" runat="server" ErrorMessage="Please Select Challan Date !"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label7" runat="server" Font-Bold="true" Text="Branch Code"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtBranch_Code" Width="60" runat="server" CssClass="cssTextbox"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label8" runat="server" Font-Bold="true" Text="TDS"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtTDSAmount" oncopy="return false" onpaste="return false" oncut="return false"
                                                                    runat="server" CssClass="cssTextbox aligntoright" Width="100px"></asp:TextBox>
                                                            </td>
                                                            <td style="width: 100px;">
                                                                <asp:Label ID="Label9" runat="server" Font-Bold="true" Text="Surcharge"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txt_Surcharge" oncopy="return false" onpaste="return false" oncut="return false"
                                                                    runat="server" CssClass="cssTextbox aligntoright" Width="100px"></asp:TextBox>
                                                            </td>

                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label10" runat="server" Font-Bold="true" Text="E.Cess"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtEducationCess" oncopy="return false" onpaste="return false" oncut="return false"
                                                                    runat="server" CssClass="cssTextbox aligntoright" Width="100px"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label11" runat="server" Font-Bold="true" Text="HE Cess"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtHECess" oncopy="return false" onpaste="return false" oncut="return false"
                                                                    runat="server" CssClass="cssTextbox aligntoright" Width="100px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                                                                                        <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label12" runat="server" Font-Bold="true" Text="Interest"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtInterest" oncopy="return false" onpaste="return false" oncut="return false"
                                                                            runat="server" CssClass="cssTextbox aligntoright" Width="100px"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label15" runat="server" Font-Bold="true" Text="Fees"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtFees" oncopy="return false" onpaste="return false" oncut="return false"
                                                                            runat="server" CssClass="cssTextbox aligntoright" Width="100px"></asp:TextBox>
                                                                    </td>

                                                                </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label13" runat="server" Font-Bold="true" Text="Others"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtOthers" oncopy="return false" onpaste="return false" oncut="return false"
                                                                    runat="server" CssClass="cssTextbox aligntoright" Width="100px"></asp:TextBox>
                                                            </td>

                                                            <td>
                                                                <asp:Label ID="Label16" Font-Bold="true" runat="server" Text="Total"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtTotal" Font-Bold="true" runat="server" CssClass="cssTextbox aligntoright"
                                                                    Width="100px" BackColor="LightBlue"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>

                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:TabPanel>
                                <asp:TabPanel ID="TabPanel2" Width="150%" runat="server" HeaderText="Emp TDS Deduction Details">
                                    <ContentTemplate>
                                        <table id="Table10" runat="server" width="100%" style="margin-top: 0px; padding-top: 0px;">

                                            <tr>
                                                <td>
                                                    <%--<fieldset style="margin-top: 0px; padding-top: 0px;">--%>
                                                    <%--  <legend>Select Employees For Challan</legend>--%>
                                                    <table id="Table14" runat="server" width="100%">
                                                        <tr>
                                                            <td valign="top">
                                                                <table width="100%">
                                                                    <tr>
                                                                        <td>
                                                                            <table>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:CheckBox runat="server" ID="chkShowOnlyTaxableEmployees" Text="Show Only Taxable Employees"
                                                                                            CssClass="cssLabel" Checked="True" AutoPostBack="true" OnCheckedChanged="chkShowOnlyTaxableEmployees_CheckedChanged" />
                                                                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
                                                                                    </td>
                                                                                    <div  id="divImpExp" runat="server">
                                                                                    <td style="width: 218px;">
                                                                                        <label style="font-weight:bold">Step 1</label>
                                                                                        <asp:Button ID="btnExprecd" OnClick="btnExprecd_Click" runat="server" CssClass="cssButton" Text="Export to Excel" />

                                                                                    </td>
                                                                                    <td>
                                                                                        <label style="font-weight:bold">Step 2</label>
                                                                                        <asp:FileUpload ID="FileUpload1" runat="server" Width="195px" />
                                                                                    </td>
                                                                                             <td>
                                                                                            <asp:Button ID="btnImport" OnClick="btnImport_Click" runat="server" CssClass="cssButton" Text="Import from Excel" />
                                                                                        </td>
                                                                                        </div>
                                                                                    <td>
                                                                                        <div id="divShowaddEmployee" runat="server">
                                                                                            <input id="btnAddEmployee" type="button" class="cssButton" value="Add Employee" />
                                                                                        </div>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>

                                                                    </tr>
                                                                </table>
                                                                <div style="width: 100%; height: 30px; font-weight: bold;">
                                                                    <table id="tblfixedHeaderFor" cellpadding="0" cellspacing="0">
                                                                    </table>
                                                                </div>
                                                                <div id="divchigrid" style="overflow: auto; max-height: 500px;">
                                                                    <asp:GridView runat="server" ID="dgEmployee" AutoGenerateColumns="false" EmptyDataRowStyle-ForeColor="Red" Width="100%"
                                                                        EmptyDataText="No Records Found!" CellSpacing="0" ShowHeaderWhenEmpty="true"
                                                                        RowStyle-CssClass="cssGridAlternatingItemStyle" CellPadding="0" ShowFooter="false"
                                                                        ShowHeader="true" OnDataBound="dgEmployee_DataBound">
                                                                        <HeaderStyle CssClass="cssGridHeader" />
                                                                        <FooterStyle />
                                                                        <Columns>
                                                                            <asp:TemplateField>
                                                                                <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" Width="21px" />
                                                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="21px" />
                                                                                <HeaderTemplate>
                                                                                    <asp:CheckBox ID="chkHeader" ClientIDMode="Static" runat="server" />
                                                                                </HeaderTemplate>
                                                                                <ItemTemplate>
                                                                                    <asp:CheckBox ID="chkRow" name="chkRow" ClientIDMode="Static" runat="server" />
                                                                                    <asp:HiddenField runat="server" ID="hdnEmployeeID" Value='<%#Eval("Employee_ID") %>' />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="#">
                                                                                <HeaderStyle BorderColor="#dbdbdb" Font-Size="10px" Width="40px" />
                                                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Right" Width="40px" />
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblSerial" runat="server" Visible="true" CssClass="cssLabel" Text='<%#Container.DataItemIndex+1 %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField DataField="FirstName" HeaderText="Name">
                                                                                <HeaderStyle BorderColor="#dbdbdb" Font-Size="9px" Width="160px" />
                                                                                <ItemStyle BorderColor="#dbdbdb" Font-Size="9px" Width="160px" CssClass="cssGridItemStyle" />
                                                                            </asp:BoundField>
                                                                            <asp:TemplateField HeaderText="Amount">
                                                                                <ItemStyle CssClass="cssGridItemStyle" />
                                                                                <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" Width="87px" HorizontalAlign="Center" />
                                                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="87px" />
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox runat="server" oncopy="return false" onpaste="return false" oncut="return false"
                                                                                        ID="txtAmount" CssClass="cssTextboxInt" Width="80px" Font-Size="11px" Text='<%#Eval("Amount") %>'></asp:TextBox>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField DataField="CDate" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}">
                                                                                <HeaderStyle BorderColor="#dbdbdb" Width="70px" Font-Size="11px" HorizontalAlign="Center" />
                                                                                <ItemStyle BorderColor="#dbdbdb" Width="70px" HorizontalAlign="Center" Font-Size="11px" />
                                                                            </asp:BoundField>
                                                                            <asp:TemplateField HeaderText="Pan No">
                                                                                <HeaderStyle BorderColor="#dbdbdb" Width="87px" Font-Size="11px" HorizontalAlign="Center" />
                                                                                <ItemStyle BorderColor="#dbdbdb" Width="87px" HorizontalAlign="Center" />
                                                                                <ItemTemplate>
                                                                                    <asp:Label runat="server" ID="lblPanNo" Style="text-transform: uppercase" CssClass="cssLabel"
                                                                                        Text='<%# Eval("PAN_NO") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Vld">
                                                                                <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" Width="20px" HorizontalAlign="Center" />
                                                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="20px" />
                                                                                <ItemTemplate>
                                                                                    <asp:Image runat="server" ID="btnValidPan" Height="15px" ImageUrl='<%# Convert.ToString(Eval("PanVerified")) == Convert.ToString("Valid_PAN") ? Convert.ToString("~/Images/valid.png") : Convert.ToString("~/Images/invalid.png")  %>'
                                                                                        Visible="true" />
                                                                                    <asp:CheckBox runat="server" Visible="false" ID="chkValidPan" CssClass="cssLabel"
                                                                                        Checked='<%# Convert.ToString(Eval("PanVerified")) == Convert.ToString("Valid_PAN") ? Convert.ToBoolean("true") : Convert.ToBoolean("false")  %>'
                                                                                        Enabled="false" />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="TDS">
                                                                                <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" HorizontalAlign="Center" Width="57px" />
                                                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="57px" />
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox runat="server" ID="txtTds"
                                                                                        CssClass="cssTextboxInt" Width="50px" Font-Size="11px" Text='<%#Eval("TDS_Amount") %>'></asp:TextBox>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Sur">
                                                                                <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" HorizontalAlign="Center" Width="57px" />
                                                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="57px" />
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox runat="server" ID="txtSur"
                                                                                        CssClass="cssTextboxInt" Width="50px" Font-Size="11px" Text='<%#Eval("Surcharge_Amount") %>'></asp:TextBox>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="E Cess">
                                                                                <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" HorizontalAlign="Center" Width="57px" />
                                                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="57px" />
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox runat="server" ID="txtECess"
                                                                                        CssClass="cssTextboxInt" Width="50px" Font-Size="11px" Text='<%#Eval("EducationCess_Amount") %>'></asp:TextBox>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="H Cass">
                                                                                <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" HorizontalAlign="Center" Width="57px" />
                                                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="57px" />
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox runat="server" ID="txtHCess"
                                                                                        CssClass="cssTextboxInt" Width="50px" Font-Size="11px" Text='<%#Eval("High_EductionCess_Amount") %>'></asp:TextBox>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Total Tax">
                                                                                <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" HorizontalAlign="Center" Width="87px" />
                                                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="87px" />
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox runat="server" ID="txtTotalTax" CssClass="cssTextboxInt" Width="77px"
                                                                                        Font-Size="11px" Text='<%#Eval("Total_TDS_Amount") %>'></asp:TextBox>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Total Depo">
                                                                                <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" HorizontalAlign="Center" Width="87px" />
                                                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="87px" />
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox runat="server" ID="txtTotalDepo" CssClass="TextboxInt" Width="77px"
                                                                                        Font-Size="11px" Text='<%#Eval("Total_TDS_Amount") %>'></asp:TextBox>
                                                                                </ItemTemplate>
                                                                                <FooterTemplate>
                                                                                    <asp:Label ID="lbltotalDeposit" CssClass="totalDeposit" runat="server"></asp:Label>
                                                                                </FooterTemplate>
                                                                                <FooterStyle HorizontalAlign="Right" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="R Type">
                                                                                <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" HorizontalAlign="Center" Width="82px" />
                                                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="82px" />
                                                                                <ItemTemplate>
                                                                                    <asp:HiddenField ID="hdnDeduction_Type" runat="server" Value='<%#Eval("Deduction_Type") %>' />
                                                                                    <asp:DropDownList runat="server" ID="ddlRType" CssClass="cssDropDownList" Width="80px"
                                                                                        Font-Size="10px">
                                                                                        <asp:ListItem Text="Reguler" Value="Reguler"></asp:ListItem>
                                                                                        <asp:ListItem Text="PAN not Avalable C" Value="PANnotAvalable C"></asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Cert No">
                                                                                <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" HorizontalAlign="Center" Width="57px" />
                                                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="57px" />
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox runat="server" ID="txtCertNo" CssClass="cssTextboxInt" Width="50px"
                                                                                        Font-Size="11px" Text='<%#Eval("CertNo") %>'></asp:TextBox>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </div>
                                                                <div style="width: 100%; height: 30px; font-weight: bold;">
                                                                    <table id="fixedBorderfordgEmployee" cellpadding="0" cellspacing="0" width="100%">
                                                                        <tr>
                                                                            <td style="width: 21px;"></td>
                                                                            <td style="width: 40px;"></td>
                                                                            <td style="width: 160px;">Total</td>
                                                                            <td style="width: 87px; text-align: center;">
                                                                                <asp:Label ID="Label518" Width="80px" align="right" runat="server" Text=""></asp:Label></td>
                                                                            <td style="width: 70px;"></td>
                                                                            <td style="width: 87px;"></td>
                                                                            <td style="width: 20px;"></td>
                                                                            <td style="width: 57px; text-align: center;">
                                                                                <asp:Label ID="Label512" Width="50px" align="right" runat="server" Text=""></asp:Label></td>
                                                                            <td style="width: 57px; text-align: center;">
                                                                                <asp:Label ID="Label513" Width="50px" align="right" runat="server" Text=""></asp:Label></td>
                                                                            <td style="width: 57px; text-align: center;">
                                                                                <asp:Label ID="Label514" Width="50px" align="right" runat="server" Text=""></asp:Label></td>
                                                                            <td style="width: 57px; text-align: center;">
                                                                                <asp:Label ID="Label515" Width="50px" align="right" runat="server" Text=""></asp:Label></td>
                                                                            <td style="width: 87px; text-align: center;">
                                                                                <asp:Label ID="Label516" Width="77px" align="right" runat="server" Text=""></asp:Label></td>
                                                                            <td style="width: 87px; text-align: center;">
                                                                                <asp:Label ID="Label517" Width="77px" align="right" runat="server" Text=""></asp:Label></td>
                                                                            <td style="width: 82px;"></td>
                                                                            <td style="width: 57px;"></td>

                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <%--</fieldset>--%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <br />
                                                    <table align="right">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label34" Font-Bold="true" runat="server" Text="Total Deposit Amount"
                                                                    CssClass="cssLabel"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox runat="server" Font-Bold="true" Style="margin-right: 190px;" ID="txtTotalDepoAmount"
                                                                    ReadOnly="true" CssClass="cssTextboxInt" Text="0"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:TabPanel>

                            </asp:TabContainer></td>

                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <asp:HiddenField runat="server" ID="hdnChallan_ID" />
                <asp:HiddenField runat="server" ID="hdnRowsOfGrid" Value="0" />
            </td>
        </tr>
    </table>
    <div id="divAddEmployeee" style="display: none; vertical-align: middle;" class="CssForHideDiv">
        <div style="background-color: White; width: 950px; margin: 0 auto; padding: 10px;">
            <table width="100%" style="font-size: 18px; color: White; padding: 3px 10px 3px 10px; height: 20px; background-color: #5B8FBB; border: 1px Solid #dbdbdb; border-radius: 5px;">
                <tr>
                    <td>Select Employee
                    </td>
                    <td style="text-align: right;">
                        <asp:Button runat="server" ID="btnSubmitAddEmployee" CssClass="cssButtonForSearch"
                            Text="Submit" OnClick="btnfromserverAddEmployee_Click" />
                        <asp:Button runat="server" ID="btnClose" CssClass="cssButtonForSearch" Text="Close" />
                    </td>
                </tr>
            </table>

            <div style="max-height: 450px; overflow: auto;">
                <asp:GridView runat="server" ID="gvAddEmployeeGrid" AutoGenerateColumns="false" Width="100%"
                    EmptyDataRowStyle-ForeColor="Red" EmptyDataText="No Records Found!" CellSpacing="2"
                    RowStyle-CssClass="cssGridAlternatingItemStyle" CellPadding="2" ShowFooter="false"
                    ShowHeaderWhenEmpty="true" ShowHeader="true">
                    <PagerStyle CssClass="cssGridHeader" BorderColor="#DBDBDB" BorderWidth="0px" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="cssGridHeader" BackColor="#5B8FBB" ForeColor="White" />
                    <FooterStyle CssClass="cssGridHeader" BackColor="#5B8FBB" ForeColor="White" />
                    <FooterStyle />
                    <Columns>
                        <asp:TemplateField>
                            <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" />
                            <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="15px" />
                            <HeaderTemplate>
                                <asp:CheckBox ID="chkHeaderAddEmp" runat="server" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkRowAddEmp" runat="server" />
                                <asp:HiddenField runat="server" ID="hdnEmployeeID" Value='<%#Eval("Employee_ID") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="SrNo">
                            <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" />
                            <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="15px" />
                            <ItemTemplate>
                                <asp:Label ID="lblSerialNo" runat="server" Visible="true" CssClass="cssLabel" Text='<%#Container.DataItemIndex+1 %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="FirstName" HeaderText="Name">
                            <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" />
                            <ItemStyle BorderColor="#dbdbdb" Width="35%" Font-Size="11px" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Amount">
                            <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" HorizontalAlign="Center" />
                            <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Right" />
                            <ItemTemplate>
                                <asp:Label ID="lblAmount" runat="server" Visible="true" CssClass="cssLabel" Text='<%#Eval("Amount") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="CDate" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}">
                            <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" HorizontalAlign="Center" />
                            <ItemStyle BorderColor="#dbdbdb" Width="60px" HorizontalAlign="Center" Font-Size="11px" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Pan No">
                            <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" HorizontalAlign="Center" />
                            <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblPanNo" Style="text-transform: uppercase" CssClass="cssLabel"
                                    Text='<%# Eval("PAN_NO") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Vld">
                            <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" HorizontalAlign="Center" />
                            <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Image runat="server" ID="btnValidPan" Height="15px" ImageUrl='<%# Convert.ToString(Eval("PanVerified")) == Convert.ToString("Valid_PAN") ? Convert.ToString("~/Images/valid.png") : Convert.ToString("~/Images/invalid.png")  %>'
                                    Visible="true" />
                                <asp:CheckBox runat="server" Visible="false" ID="chkValidPan" CssClass="cssLabel"
                                    Checked='<%# Convert.ToString(Eval("PanVerified")) == Convert.ToString("Valid_PAN") ? Convert.ToBoolean("true") : Convert.ToBoolean("false")  %>'
                                    Enabled="false" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="TDS">
                            <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" HorizontalAlign="Center" />
                            <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Left" />
                            <ItemTemplate>
                                <asp:Label ID="lblTDS" runat="server" Visible="true" CssClass="cssLabel" Text='<%#Eval("TDS_Amount") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Sur">
                            <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" HorizontalAlign="Center" />
                            <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Left" />
                            <ItemTemplate>
                                <asp:Label ID="lblsur" runat="server" Visible="true" CssClass="cssLabel" Text='<%#Eval("Surcharge_Amount") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="E Cess">
                            <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" HorizontalAlign="Center" />
                            <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Left" />
                            <ItemTemplate>
                                <asp:Label ID="lblECess" runat="server" Visible="true" CssClass="cssLabel" Text='<%#Eval("EducationCess_Amount") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="H Cess">
                            <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" HorizontalAlign="Center" />
                            <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Left" />
                            <ItemTemplate>
                                <asp:Label ID="lblHcess" runat="server" Visible="true" CssClass="cssLabel" Text='<%#Eval("High_EductionCess_Amount") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total Tax">
                            <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" HorizontalAlign="Center" />
                            <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Left" />
                            <ItemTemplate>
                                <asp:Label ID="lbltotalTax" runat="server" Visible="true" CssClass="cssLabel" Text='<%#Eval("Total_TDS_Amount") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total Depo">
                            <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" HorizontalAlign="Center" />
                            <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Left" />
                            <ItemTemplate>
                                <asp:Label ID="lblTotalDepo" runat="server" Visible="true" CssClass="cssLabel" Text='<%#Eval("Total_TDS_Amount") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lbltotalDeposit" CssClass="totalDeposit" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="R Type">
                            <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" HorizontalAlign="Center" />
                            <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblrType" runat="server" Visible="true" CssClass="cssLabel" Text='<%#Eval("Deduction_Type") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Cert No">
                            <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" HorizontalAlign="Center" />
                            <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblCertno" runat="server" Visible="true" CssClass="cssLabel" Text='<%#Eval("CertNo") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

        </div>
    </div>
    <%--        </ContentTemplate>
    </asp:UpdatePanel>--%>

</asp:Content>
