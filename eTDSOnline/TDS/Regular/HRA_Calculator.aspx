<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/TDS/BTS_MasterPages/MasterPage.master"
    CodeFile="HRA_Calculator.aspx.cs" Inherits="Admin_HRA_Calculator" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%--<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>--%>
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
        .cssButton {
            cursor: pointer;
            background-image: url(../Images/ButtonBG1.png);
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

        .tblBasicSalary th, .tblBasicSalary td {
            border: 1px solid black;
        }


        ************************************************************client job selection css***************
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

        *************************************************************Timesheet Input css*******************
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

        #outer {
            width: 100%;
            text-align: center;
        }

        .inner {
            display: inline-block;
        }

        .switch {
            position: relative;
            display: inline-block;
            width: 45px;
            height: 20px;
            vertical-align: middle;
            margin-top: 8px;
        }

            .switch input {
                display: none;
            }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #A1A6AB;
            -webkit-transition: .4s;
            transition: .4s;
        }

            .slider:before {
                position: absolute;
                content: "";
                height: 16px;
                width: 14px;
                left: 2px;
                bottom: 2px;
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

              .ManualEntry{
          width: 140px;
          padding: 6px;
          margin: 3px 0;
          box-sizing: border-box;
          border: 2px solid black;
          border-radius: 4px;
          background-color:white;
          text-align:right;
        }
    </style>
    <script language="javascript" type="text/javascript">
        var baseUrl = '<%=ResolveUrl("../Handler/TDSComputationV2.asmx/") %>';
        var ddid = 0;
        var UP = 0;
        var NT = '';
        var Mis = '';
        var deddrp = '';
        var vMod = '';
        var myTimer;
        var companyid = 0;
        var ddlFilterList = '';
        var EmployeeJsonList = '';
        var pgindex = 1;
        var empMainDetails = '';
        var closeButtonClicked = false;

        $(document).ready(function () {


            App.initBeforeLoad();
            App.initCore();
            App.initAfterLoad();
            companyid = $("[id*=hdnCompanyid]").val();
            $("[id*=hdnConnString]").val($("[id*=ddlFinancialYear] :selected").text());
            $("[id*=hdnPages]").val(1);

            GetAllEmployeeComputionSummary();

            $("[id*=chkMetro]").change(function () {
                console.log('ChkMEtro');
                CalculateHRA();
            });

            $("[id*=drpEmployeeName]").change(function () {
                var n = $("[id*=drpEmployeeName]").val();
                GetEmployeeDetails(n);
            });

        });

        $(document).on("change", ".ManualEntry", function () {
            console.log('Event');
            CalculateHRA();

        });

        $(document).on("keydown", ".ManualEntry", function (evt) {
            console.log('onkeypress');

            var txtQty = $(this).val().replace(/[^-0-9\.]/g, '');
            ;
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;

            if (evt.keyCode == 13) {
                closeButtonClicked = false;

                console.log('onEnter');
                if ($(this).data("info") == 'Basic') {
                    debugger
                    var currentRowno = $(this).closest('tr').index();
                    var currentValue = $(this).val();
                    $("input[name=txtMonthBasic]").each(function () {
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
                    CalculateHRA();
                }
                if ($(this).data("info") == 'DA') {
                    debugger
                    var currentRowno = $(this).closest('tr').index();
                    var currentValue = $(this).val();
                    $("input[name=txtMonthDA]").each(function () {
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

                    CalculateHRA();
                }
                if ($(this).data("info") == 'HRA') {
                    debugger
                    var currentRowno = $(this).closest('tr').index();
                    var currentValue = $(this).val();
                    $("input[name=txtMonthHRA]").each(function () {
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

                    CalculateHRA();
                }
                if ($(this).data("info") == 'HRR') {
                    debugger
                    var currentRowno = $(this).closest('tr').index();
                    var currentValue = $(this).val();
                    $("input[name=txtMonthHRR]").each(function () {
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

                    CalculateHRA();
                }
                closeButtonClicked = false;
                return false;

            }
            else if (charCode > 31 && (charCode < 46 || charCode > 57)) {
                return false;
            }
            return true;

        });

        function GetAllEmployeeComputionSummary() {
            var tobj = {
                CompanyID: companyid,
                PageIndex: pgindex,
                PageSize: 25,
                SearchVal: $('#txtTdsSummarysearch').val(),
                ConnectionString: $("[id*=hdnConnString]").val(),
                FilterById: (($('[id*=ddlsearch]').val() == '' || $('[id*=ddlsearch]').val() == undefined || $('[id*=ddlsearch]').val() == null) ? '0' : $('[id*=ddlsearch]').val())
            };
            tobj = JSON.stringify({ 'tobj': tobj });

            ServerServiceToGetData(tobj, baseUrl + 'GetAllEmployeeComputionSummaryV2', 'false', FillEmployeeName);
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

        function FillEmployeeName(response) {
            debugger;
            Blockloadershow();
            var tblAllEmpComputationGrid = jQuery.parseJSON(response.d);

            $("[id*=drpEmployeeName]").empty();
            $("[id*=drpEmployeeName]").append("<option value='0'>--Select Employee--</option>");
            $.each(tblAllEmpComputationGrid, function (i, v) {
                $("[id*=drpEmployeeName]").append("<option value='" + v.Employee_ID + "'>" + v.FirstName.toLocaleString().toLowerCase() + "</option>");
            });
            Blockloaderhide();
        }
        function GetEmployeeDetails(empId) {
            Blockloadershow();

            var tobj = {
                Company_ID: $("[id*=hdnCompanyid]").val(),
                Employee_ID: empId,
                ConnectionString: $("[id*=hdnConnString]").val()
            };
            tobj = JSON.stringify({ 'tobj': tobj });

            $.ajax({
                url: "../Handler/TDSComputationV2.asmx/getEmployeeComputationV2",
                data: tobj,
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (msg) {
                    var List = jQuery.parseJSON(msg.d);

                    if (List[0] != null) {
                        BindPrimaryDetails(List[0]);
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

       
        function BindPrimaryDetails(empDetails) {
            $("[id*=txtPanNo]").val(empDetails.PAN_NO);
            $("[id*=txt_FromDate]").val(empDetails.FromDate);
            empMainDetails = empDetails;
            debugger;
            $("[id*=txtGrossProfits_C]").val(empDetails.GrossProfits_C);
             
            if (empDetails.LSalaryForHRABreakup != null) {
                

                empDetails.LSalaryForHRABreakup.forEach(obj => {

                    $("[id*=txtMonthBasic" + obj.SalaryMonth + "]").val(obj.BasicAmount);

                    $("[id*=txtMonthDA" + obj.SalaryMonth + "]").val(obj.DAAmount);

                    $("[id*=txtMonthHRA" + obj.SalaryMonth + "]").val(obj.HRAAmount);

                    $("[id*=txtMonthHRR" + obj.SalaryMonth + "]").val(obj.HRRAmount);

                     
                });
               

            }

            CalculateHRA();


             
        }

        function CalculateHRA() {

            let BasicTotal = 0;
            let DATotal = 0;
            let HRATotal = 0;
            let HRRTotal = 0;
            let ExemptHRATotal = 0;
            let TaxableHRATotal = 0;
            let eachMonthBasic = 0;
            let eachMonthDA = 0;
            let eachMonthHRA = 0;
            let eachMonthHRR = 0;
            let eachMonthExemptHRA = 0;

            {
                $("input[name=txtMonthBasic]").each(function () {

                    let parent = this.id;
                    {
                        BasicTotal = BasicTotal + parseFloat($('#' + parent).val());
                        eachMonthBasic = parseFloat($('#' + parent).val());
                    }
                    let sibling = '#' + parent.replace("txtMonthBasic", "txtMonthDA");
                    {
                        DATotal = DATotal + parseFloat($(sibling).val());
                        eachMonthDA = parseFloat($(sibling).val());
                    }
                    sibling = '#' + parent.replace("txtMonthBasic", "txtMonthHRA");
                    {
                        HRATotal = HRATotal + parseFloat($(sibling).val());
                        eachMonthHRA = parseFloat($(sibling).val());
                    }
                    sibling = '#' + parent.replace("txtMonthBasic", "txtMonthHRR");
                    {
                        HRRTotal = HRRTotal + parseFloat($(sibling).val());
                        eachMonthHRR = parseFloat($(sibling).val());
                    }

                    eachMonthExemptHRA = CalculateTaxExemptHRA(eachMonthBasic, eachMonthDA, eachMonthHRA, eachMonthHRR);

                    sibling = '#' + parent.replace("txtMonthBasic", "txtMonthExemptedHRA");
                    {
                        $(sibling).text(eachMonthExemptHRA);
                    }
                    ExemptHRATotal = ExemptHRATotal + eachMonthExemptHRA;

                });
                TaxableHRATotal = HRATotal - ExemptHRATotal;

                $("[id*=lblBasicTotal]").text(BasicTotal);
                $("[id*=lblDATotal]").text(DATotal);
                $("[id*=lblHRATotal]").text(HRATotal);
                $("[id*=lblHRRTotal]").text(HRRTotal);
                $("[id*=lblMonthExemptedTotal]").text(ExemptHRATotal);

                $("[id*=lblRightBasicTotal]").text(BasicTotal);
                $("[id*=lblRightDATotal]").text(DATotal);
                $("[id*=lblRightHRATotal]").text(HRATotal);
                $("[id*=lblRightHRRTotal]").text(HRRTotal);
                $("[id*=lblRightExmptedHRATotal]").text(ExemptHRATotal);
                if (TaxableHRATotal < 0) {
                    $("[id*=lblRightTaxableHRATotal]").text("0.00");
                }
                else {
                    $("[id*=lblRightTaxableHRATotal]").text(TaxableHRATotal);
                }

            }

            function CalculateTaxExemptHRA(Basic, DA, HRA, HRR) {
                debugger;
                let HRAArray = [];
                let TaxHRA1 = 0;
                let TaxHRA2 = 0;
                let TaxHRA3 = 0;
                
                let finalHRA = 0;

                TaxHRA1 = HRA;

                if ($("#chkMetro").is(':checked')) {
                    if (Basic + DA > 0) {
                        TaxHRA2 = (Basic + DA) * (50 / 100)
                    }
                }
                else {
                    if (Basic + DA > 0) {
                        TaxHRA2 = (Basic + DA) * (40 / 100)
                    }
                }

                

                if (Basic > 0 && HRR>0) {
                    TaxHRA3 = HRR - ((Basic + DA) * (10 / 100))
                }

                if (TaxHRA1>0) {
                    HRAArray.push(TaxHRA1)
                }
                if (TaxHRA2 > 0) {
                    HRAArray.push(TaxHRA2)
                }
                if (TaxHRA3 > 0) {
                    HRAArray.push(TaxHRA3)
                }

                HRAArray.sort(function (a, b) { return a - b });

                if (HRAArray.length > 0) {
                    finalHRA = HRAArray[0];
                }
                return finalHRA;
            }
             
             
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <div class="row col-12">
        <div class="col-8" style="margin-top: 1%;">

            <div class="card">
                <div class="card-body">
                    <div class="row">
                    <div class="col-12" style="font-weight:bold; font-size: 21px">Monthly Salary Detail of Akshay R.</div>
                </div>
                     <%--<div class="row" style="padding-left:20px;padding-top:10px;">
                    <div class="col-1">
                        <label style="font-weight: bold; font-weight: bold; font-size: 15px;">Name</label>
                    </div>
                <div class="col-3 text-left ">
                        <select id="drpEmployeeName" name="drpEmployeeName" runat="server" class="form-control select-search" style="text-transform: Capitalize; width:100%; " >
                            <option value="Others">--Select Employee--</option>
                        </select>
                    </div>
                         </div>--%>
                    <div class="row" style="padding-top:0px;">
                    <table class="tblBasicSalary table-hover table-xs font-size-base" width="100%">
                        <tr style="text-align: center;background:#dcdcdc;">

                            <th width='10%'>Month
                            </th>
                            <th width='18%'>Basic
                            </th>
                            <th width='18%'>DA
                            </th>
                            <th width='18%'>HRA
                            </th>
                            <th width='18%'>HRR
                            </th>
                            <th width='18%'>Exempted HRA
                            </th>
                        </tr>
                        <tr>
                            <td style="text-align: left">April</td>
                           <td>
                                <input type="text" name="txtMonthBasic" id="txtMonthBasic4" class="ManualEntry cssGridTextboxInt" data-info="Basic" value="0.00" /></td>
                           <td>
                                <input type="text" name="txtMonthDA" id="txtMonthDA4" class="ManualEntry cssGridTextboxInt" data-info="DA" value="0.00" /></td>
                           <td>
                                <input type="text" name="txtMonthHRA" id="txtMonthHRA4" class="ManualEntry cssGridTextboxInt" data-info="HRA" value="0.00" /></td>
                      <td>
                                <input type="text" name="txtMonthHRR" id="txtMonthHRR4" class="ManualEntry cssGridTextboxInt" data-info="HRR" value="0.00" /></td>
                            <td style="text-align:right;padding-right:5px;"><span style="padding-left:5px;" >&#8377;  </span><label id="txtMonthExemptedHRA4" class="col-form-label font-weight-bold"  >0.00</label></td>
                        </tr>
                        <tr>
                            <td style="text-align: left">May</td>
                            <td>
                                <input type="text" name="txtMonthBasic" id="txtMonthBasic5" class="ManualEntry cssGridTextboxInt" data-info="Basic" value="0.00" /></td>
                            <td>
                                <input type="text" name="txtMonthDA" id="txtMonthDA5" class="ManualEntry cssGridTextboxInt" data-info="DA" value="0.00" /></td>
                             <td>
                                <input type="text" name="txtMonthHRA" id="txtMonthHRA5" class="ManualEntry cssGridTextboxInt" data-info="HRA" value="0.00" /></td>
                           <td>
                                <input type="text" name="txtMonthHRR" id="txtMonthHRR5" class="ManualEntry cssGridTextboxInt" data-info="HRR" value="0.00" /></td>
                            <td style="text-align:right;padding-right:5px;"><span style="padding-left:5px;" >&#8377;  </span><label id="txtMonthExemptedHRA5" class="col-form-label font-weight-bold"  >0.00</label></td>
                        </tr>
                        <tr>
                            <td style="text-align: left">June</td>
                             <td>
                                <input type="text" name="txtMonthBasic" id="txtMonthBasic6" class="ManualEntry cssGridTextboxInt" data-info="Basic" value="0.00" /></td>
                             <td>
                                <input type="text" name="txtMonthDA" id="txtMonthDA6" class="ManualEntry cssGridTextboxInt" data-info="DA" value="0.00" /></td>
                           <td>
                                <input type="text" name="txtMonthHRA" id="txtMonthHRA6" class="ManualEntry cssGridTextboxInt" data-info="HRA" value="0.00" /></td>
                            <td>
                                <input type="text" name="txtMonthHRR" id="txtMonthHRR6" class="ManualEntry cssGridTextboxInt" data-info="HRR" value="0.00" /></td>
                            <td style="text-align:right;padding-right:5px;"><span style="padding-left:5px;" >&#8377;  </span><label id="txtMonthExemptedHRA6" class="col-form-label font-weight-bold"  >0.00</label></td>
                        </tr>
                        <tr>
                            <td style="text-align: left">July</td>
                             <td>
                                <input type="text" name="txtMonthBasic" id="txtMonthBasic7" class="ManualEntry cssGridTextboxInt" data-info="Basic" value="0.00" /></td>
                          <td>
                                <input type="text" name="txtMonthDA" id="txtMonthDA7" class="ManualEntry cssGridTextboxInt" data-info="DA" value="0.00" /></td>
                            <td>
                                <input type="text" name="txtMonthHRA" id="txtMonthHRA7" class="ManualEntry cssGridTextboxInt" data-info="HRA" value="0.00" /></td>
                           <td>
                                <input type="text" name="txtMonthHRR" id="txtMonthHRR7" class="ManualEntry cssGridTextboxInt" data-info="HRR" value="0.00" /></td>
                            <td style="text-align:right;padding-right:5px;"><span style="padding-left:5px;" >&#8377;  </span><label id="txtMonthExemptedHRA7" class="col-form-label font-weight-bold"  >0.00</label></td>
                        </tr>
                        <tr>
                            <td style="text-align: left">August</td>
                             <td>
                                <input type="text" name="txtMonthBasic" id="txtMonthBasic8" class="ManualEntry cssGridTextboxInt" data-info="Basic" value="0.00" /></td>
                          <td>
                                <input type="text" name="txtMonthDA" id="txtMonthDA8" class="ManualEntry cssGridTextboxInt" data-info="DA" value="0.00" /></td>
                             <td>
                                <input type="text" name="txtMonthHRA" id="txtMonthHRA8" class="ManualEntry cssGridTextboxInt" data-info="HRA" value="0.00" /></td>
                           <td>
                                <input type="text" name="txtMonthHRR" id="txtMonthHRR8" class="ManualEntry cssGridTextboxInt" data-info="HRR" value="0.00" /></td>
                            <td style="text-align:right;padding-right:5px;"><span style="padding-left:5px;" >&#8377;  </span><label id="txtMonthExemptedHRA8" class="col-form-label font-weight-bold"  >0.00</label></td>
                        </tr>
                        <tr>
                            <td style="text-align: left">September</td>
                            <td>
                                <input type="text" name="txtMonthBasic" id="txtMonthBasic9" class="ManualEntry cssGridTextboxInt" data-info="Basic" value="0.00" /></td>
                             <td>
                                <input type="text" name="txtMonthDA" id="txtMonthDA9" class="ManualEntry cssGridTextboxInt" data-info="DA" value="0.00" /></td>
                          <td>
                                <input type="text" name="txtMonthHRA" id="txtMonthHRA9" class="ManualEntry cssGridTextboxInt" data-info="HRA" value="0.00" /></td>
                          <td>
                                <input type="text" name="txtMonthHRR" id="txtMonthHRR9" class="ManualEntry cssGridTextboxInt" data-info="HRR" value="0.00" /></td>
                            <td style="text-align:right;padding-right:5px;"><span style="padding-left:5px;" >&#8377;  </span><label id="txtMonthExemptedHRA9" class="col-form-label font-weight-bold"  >0.00</label></td>
                        </tr>
                        <tr>
                            <td style="text-align: left">October</td>
                           <td>
                                <input type="text" name="txtMonthBasic" id="txtMonthBasic10" class="ManualEntry cssGridTextboxInt" data-info="Basic" value="0.00" /></td>
                             <td>
                                <input type="text" name="txtMonthDA" id="txtMonthDA10" class="ManualEntry cssGridTextboxInt" data-info="DA" value="0.00" /></td>
                            <td>
                                <input type="text" name="txtMonthHRA" id="txtMonthHRA10" class="ManualEntry cssGridTextboxInt" data-info="HRA" value="0.00" /></td>
                           <td>
                                <input type="text" name="txtMonthHRR" id="txtMonthHRR10" class="ManualEntry cssGridTextboxInt" data-info="HRR" value="0.00" /></td>
                            <td style="text-align:right;padding-right:5px;"><span style="padding-left:5px;" >&#8377;  </span><label id="txtMonthExemptedHRA10" class="col-form-label font-weight-bold"  >0.00</label></td>
                        </tr>
                        <tr>
                            <td style="text-align: left">November</td>
                         <td>
                                <input type="text" name="txtMonthBasic" id="txtMonthBasic11" class="ManualEntry cssGridTextboxInt" data-info="Basic" value="0.00" /></td>
                            <td>
                                <input type="text" name="txtMonthDA" id="txtMonthDA11" class="ManualEntry cssGridTextboxInt" data-info="DA" value="0.00" /></td>
                            <td>
                                <input type="text" name="txtMonthHRA" id="txtMonthHRA11" class="ManualEntry cssGridTextboxInt" data-info="HRA" value="0.00" /></td>
                       <td>
                                <input type="text" name="txtMonthHRR" id="txtMonthHRR11" class="ManualEntry cssGridTextboxInt" data-info="HRR" value="0.00" /></td>
                            <td style="text-align:right;padding-right:5px;"><span style="padding-left:5px;" >&#8377;  </span><label id="txtMonthExemptedHRA11" class="col-form-label font-weight-bold"  >0.00</label></td>
                        </tr>
                        <tr>
                            <td style="text-align: left">December</td>
                            <td>
                                <input type="text" name="txtMonthBasic" id="txtMonthBasic12" class="ManualEntry cssGridTextboxInt" data-info="Basic" value="0.00" /></td>
                            <td>
                                <input type="text" name="txtMonthDA" id="txtMonthDA12" class="ManualEntry cssGridTextboxInt" data-info="DA" value="0.00" /></td>
                            <td>
                                <input type="text" name="txtMonthHRA" id="txtMonthHRA12" class="ManualEntry cssGridTextboxInt" data-info="HRA" value="0.00" /></td>
                            <td>
                                <input type="text" name="txtMonthHRR" id="txtMonthHRR12" class="ManualEntry cssGridTextboxInt" data-info="HRR" value="0.00" /></td>
                            <td style="text-align:right;padding-right:5px;"><span style="padding-left:5px;" >&#8377;  </span><label id="txtMonthExemptedHRA12" class="col-form-label font-weight-bold"  >0.00</label></td>
                        </tr>
                        <tr>
                            <td style="text-align: left">January</td>
                      <td>
                                <input type="text" name="txtMonthBasic" id="txtMonthBasic1" class="ManualEntry cssGridTextboxInt" data-info="Basic" value="0.00" /></td>
                <td>
                                <input type="text" name="txtMonthDA" id="txtMonthDA1" class="ManualEntry cssGridTextboxInt" data-info="DA" value="0.00" /></td>
                      <td>
                                <input type="text" name="txtMonthHRA" id="txtMonthHRA1" class="ManualEntry cssGridTextboxInt" data-info="HRA" value="0.00" /></td>
                           <td>
                                <input type="text" name="txtMonthHRR" id="txtMonthHRR1" class="ManualEntry cssGridTextboxInt" data-info="HRR" value="0.00" /></td>
                            <td style="text-align:right;padding-right:5px;"><span style="padding-left:5px;" >&#8377;  </span><label id="txtMonthExemptedHRA1" class="col-form-label font-weight-bold"  >0.00</label></td>
                        </tr>
                        <tr>

                            <td style="text-align: left">Februry</td>
                            <td>
                                <input type="text" name="txtMonthBasic" id="txtMonthBasic2" class="ManualEntry cssGridTextboxInt" data-info="Basic" value="0.00" /></td>
                           <td>
                                <input type="text" name="txtMonthDA" id="txtMonthDA2" class="ManualEntry cssGridTextboxInt" data-info="DA" value="0.00" /></td>
                            <td>
                                <input type="text" name="txtMonthHRA" id="txtMonthHRA2" class="ManualEntry cssGridTextboxInt" data-info="HRA" value="0.00" /></td>
                            <td>
                                <input type="text" name="txtMonthHRR" id="txtMonthHRR2" class="ManualEntry cssGridTextboxInt" data-info="HRR" value="0.00" /></td>
                            <td style="text-align:right;padding-right:5px;"><span style="padding-left:5px;" >&#8377;  </span><label id="txtMonthExemptedHRA2" class="col-form-label font-weight-bold"  >0.00</label></td>
                        </tr>
                        <tr>

                            <td style="text-align: left">March</td>
                          <td>
                                <input type="text" name="txtMonthBasic" id="txtMonthBasic3" class="ManualEntry cssGridTextboxInt" data-info="Basic" value="0.00" /></td>
                          <td>
                                <input type="text" name="txtMonthDA" id="txtMonthDA3" class="ManualEntry cssGridTextboxInt" data-info="DA" value="0.00" /></td>
                           <td>
                                <input type="text" name="txtMonthHRA" id="txtMonthHRA3" class="ManualEntry cssGridTextboxInt" data-info="HRA" value="0.00" /></td>
                         <td>
                                <input type="text" name="txtMonthHRR" id="txtMonthHRR3" class="ManualEntry cssGridTextboxInt" data-info="HRR" value="0.00" /></td>
                            <td style="text-align:right;padding-right:5px;"><span style="padding-left:5px;" >&#8377;  </span><label id="txtMonthExemptedHRA3" class="col-form-label font-weight-bold"  >0.00</label></td>
                        </tr>
                        <tr>

                            <td style="text-align:center"><b>Total</b></td>
                            <td style="text-align:right;padding-right:5px;"><span>&#8377;  </span>
                                <label  id="lblBasicTotal" class="col-form-label font-weight-bold">0.00</label></td>
                            <td style="text-align:right;padding-right:5px;"><span>&#8377;  </span>
                                <label id="lblDATotal" class="col-form-label font-weight-bold">0.00</label></td>
                            <td style="text-align:right;padding-right:5px;"><span>&#8377;  </span>
                                <label id="lblHRATotal" class="col-form-label font-weight-bold">0.00</label></td>
                            <td style="text-align:right;padding-right:5px;"><span>&#8377;  </span>
                               <label id="lblHRRTotal" class="col-form-label font-weight-bold">0.00</label></td>
                            <td style="text-align:right;padding-right:5px;"><span style="padding-left:5px;" >&#8377;  </span><label id="lblMonthExemptedTotal" class="col-form-label font-weight-bold"  >0.00</label></td>

                        </tr>
                    </table>
                        </div>
                </div>
            </div>
        </div>
        <div class="col-4" style="margin-top: 1%;">
            <div class="card">
                <div class="card-body">
                    <u>HRA Calculater</u>
                    <table style="width: 97%; margin: 3%; height:100%">
                        <tr>
                            <td>Residing in Metro</td>
                            <td style="text-align: right;">
                                <label class="switch">
                                    <input id="chkMetro" type="checkbox" checked >
                                    <span class="slider round"></span>
                                </label>
                            </td>
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

                                <asp:Button runat="server" ID="btnCalculate" CssClass="btn btn-success btn-labeled" Width="80%" Text="Calculate"></asp:Button>
                            </td>
                            <td style="text-align: center;">
                                <asp:Button runat="server" ID="btnReset" CssClass="btn btn-success btn-labeled" Width="100%" Text="Reset"></asp:Button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
     <asp:HiddenField ID="hdnConnString" runat="server" />
    <asp:HiddenField ID="hdnCompanyid" runat="server" />
</asp:Content>


