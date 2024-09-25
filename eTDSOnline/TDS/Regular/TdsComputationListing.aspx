<%@ Page Title="" Language="C#" MasterPageFile="~/TDS/BTS_MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="TdsComputationListing.aspx.cs" Inherits="Admin_TdsComputationListing" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <!-------------------------------------- Tabulator CSS and JS ------------------------------------------------>
    <link href="https://unpkg.com/tabulator-tables@5.0.7/dist/css/tabulator_modern.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="https://unpkg.com/tabulator-tables@5.0.7/dist/js/tabulator.min.js"></script>
    <!-------------------------------------- Tabulator CSS and JS ------------------------------------------------>

    <!-------------------------------------- SweetAlert CSS and JS ------------------------------------------------>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"/>
    <!-------------------------------------- SweetAlert CSS and JS ------------------------------------------------>

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
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/emailjs-com@3/dist/email.min.js"></script>
    <script src="../BTStrp/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../BTStrp/js/bootstrap2.3.2.min.js"></script>
    <script src="../../TDS/BTStrp/js/email.js" type="text/javascript"></script>
    <script type="text/javascript" src="../BTStrp/js/TDScomputation.js"></script>
    
    <script type="text/javascript">
            emailjs.init('9ptpXB8x4iMvLy91B')
        </script>

    <script language="javascript" type="text/javascript">
        var baseUrl = '<%=ResolveUrl("../../TDS/BTStrp/Handler/TDSComputationV2.asmx/") %>';
        var TDSURL = '<%=ResolveUrl("../regular/TdsComputationV2.aspx") %>';
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
           
            companyid = $("[id*=hdnCompanyid]").val();
            $("[id*=hdnConnString]").val($("[id*=ddlFinancialYear] :selected").text());
            $("[id*=hdnPages]").val(1);
            
            GetAllEmployeeComputionSummary();

            $("[id*=ddlsearch]").change(function () {
                var n = $("[id*=ddlsearch]").val();
                GetAllEmployeeComputionSummary();
            });


            $('.close').on('click', function () {

                closeButtonClicked = true;
                $('#modal_ViewDetails1').modal('hide');
            });

            $('#btnCancel').on('click', function () {
                closeButtonClicked = true;
                $('#modal_ViewDetails1').modal('hide');
            });
            

           
        });

        function openViewDetails1() {
            var Empid = "3";
            $.ajax({
                url: "../../TDS/BTStrp/Handler/TDSComputationV2.asmx/generateFrom16",
                data: '{Empid:' + Empid + '}',
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (msg) {

                    var tempparams = {
                        from_name: 'OnlineTDS Enquiry',
                        Company: 'Test Report',
                        Name: 'Test',
                        Phone: 'Form16',
                        Email: 'CTEmail',
                        reply_to: 'mufaddal@saibex.co.in',
                        PDFMail: 'http://login.onlinetds.com/eReturns/Mailing/TDSComputation.PDF',
                      
                    }

                    emailjs.send("service_nbqwp3f", "template_96z8uvg", tempparams)
                        .then(function (res) {
                            //console.log("success", res.status);
                            if (res.text == 'OK') {
                                alert('Your Message has been send successfully!!!');
                            } else {
                                alert('Mail not send');
                            }

                        })

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

        function isEmail(email) {
            var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            return regex.test(email);
        }


        function GetAllEmployeeComputionSummary() {
            var tobj = {
                CompanyID: companyid,
                PageIndex: pgindex,
                PageSize: 300,
                SearchVal: $('#txtEmployeeName').val(),
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
                    debugger
                    alert(response.responseText);
                },
                failure: function (response) {
                    alert(response.responseText);
                }
            });
        }

        function makeFrontFormat() {
            $(".frontMakeFormat").each(function () {
                $(this).html(AddComma($(this).html()));
            });
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

        var table;
        function FillEmployeeName(response) {
            debugger
            Blockloadershow();
            var tblAllEmpComputationGrid = jQuery.parseJSON(response.d);

            if (table) {
                // Clear existing data and update with new data
                table.setData(tblAllEmpComputationGrid);
            } else {
                // Define Tabulator columns
                var columns = [
                    { title: "Sr.No", field: "SrNo", frozen: true, formatter: "rownum", headerSort: false, hozAlign: "center" },
                    { title: "Employee", field: "FirstName", frozen: true, minWidth: 120, headerSort: false, formatter: function (cell, formatterParams) { return `<a href="${TDSURL}?Emp_Id=${cell.getData().Employee_ID}" target="_blank">${cell.getValue()}</a>`; } },
                    //{ title: "<input type='checkbox' class='Chkbox' onclick='CheckAll($(this))' id='chkCheckAll' name='chkCheckAll' />", frozen: true,field: "checkbox", formatter: "rowSelection", hozAlign: "center", headerSort: false, cellClick: function (e, cell) { cell.getRow().toggleSelect(); }},
                    { title: "PanNo", field: "PanNumber", editor: "input", minWidth: 120, headerSort: false, frozen: true, editor: panEditor },
                    { title: "Email", field: "EmailAdd", editor: "input", minWidth: 120, headerSort: false, editor: emailEditor  },
                    { title: "Compute tax 115BAC", field: "I115BAC", hozAlign: "right", editor: "input", minWidth: 120, headerSort: false, editor: numericEditor},
                    { title: "Salary", field: "Total_Earnings", minWidth: 120, hozAlign: "right", editor: "input", headerSort: false, editor: numEditor},
                    { title: "Perquisites", field: "GrossPerks_B", minWidth: 120, hozAlign: "right", editor: "input", headerSort: false, editor: numEditor},
                    { title: "Profits in lieu of salary", field: "GrossProfits_C", hozAlign: "right", minWidth: 120, editor: "input", headerSort: false, editor: numEditor },
                    { title: "Travel Concession", field: "GrossTotal_D", minWidth: 120, hozAlign: "right", hozAlign: "right", editor: "input", headerSort: false, editor: numEditor },
                    { title: "Death-Cum-Retirement Gratuity", field: "", minWidth: 120, hozAlign: "right", editor: "input", headerSort: false, editor: numEditor },
                    { title: "Value of Pension", field: "", minWidth: 120, hozAlign: "right", editor: "input", headerSort: false, editor: numEditor},
                    { title: "Cash Equivalent of Leave", field: "", editor: "input", hozAlign: "right", minWidth: 120, headerSort: false, editor: numEditor},
                    { title: "HRA", field: "", editor: "input", minWidth: 120, hozAlign: "right", headerSort: false, editor: numEditor},
                    { title: "Other exemption", field: "", editor: "input", hozAlign: "right", minWidth: 120, headerSort: false, editor: numEditor},
                    { title: "Gross Salary", field: "PreSal", editor: "input", minWidth: 120, hozAlign: "right", headerSort: false, editor: numEditor},
                    { title: "Standard Deduction", field: "StandardDeductions", editor: "input", hozAlign: "right", minWidth: 120, headerSort: false, editor: numEditor },
                    { title: "Entertainment allowance", field: "Entertainment", editor: "input", hozAlign: "right", minWidth: 120, headerSort: false, editor: numEditor},
                    { title: "Employment Tax", field: "PTax", editor: "input", minWidth: 120, hozAlign: "right", headerSort: false, editor: numEditor},
                    { title: "Int House Loan", field: "IntHouseLoan", editor: "input", minWidth: 120, hozAlign: "right", headerSort: false, editor: numEditor},
                    { title: "Other Income", field: "OtherIncome", editor: "input", minWidth: 120, hozAlign: "right", headerSort: false, editor: numEditor},
                    { title: "Investment u/s 80C", field: "Rebate80C", editor: "input", minWidth: 120, hozAlign: "right", headerSort: false, headerSort: false, editor: numEditor},
                    { title: "Deduction u/s 80CCC", field: "Rebate80CCC", editor: "input", minWidth: 120, hozAlign: "right", headerSort: false, editor: numEditor},
                    { title: "Deductions u/s 80CCD(1)", field: "Rebate80CCD", editor: "input", minWidth: 120, hozAlign: "right", headerSort: false, editor: numEditor},
                    { title: "Deductions u/s 80CCD (1B)", field: "Rebate80CCD1B", editor: "input", minWidth: 120, hozAlign: "right", headerSort: false, editor: numEditor},
                    { title: "Deductions u/s 80CCD (2)", field: "Rebate80CCD2", editor: "input", minWidth: 120, hozAlign: "right", headerSort: false, editor: numEditor},
                    { title: "MediClaim Premium", field: "Rebate88D", editor: "input", headerSort: false, hozAlign: "right", editor: numEditor},
                    { title: "Deductions u/s 80G (Donations)", field: "Rebate80G", editor: "input", hozAlign: "right", headerSort: false, minWidth: 120, editor: numEditor},
                    { title: "Loan Interest for Higher Education", field: "Rebate80E", editor: "input", hozAlign: "right", headerSort: false, minWidth: 120, editor: numEditor},
                    { title: "Loan Interest for Residential House", field: "Rebate80EE", editor: "input", hozAlign: "right", headerSort: false, minWidth: 120, editor: numEditor},
                    { title: "Interest on Savings Bank Account", field: "Rebate80TTA", editor: "input", hozAlign: "right", headerSort: false, minWidth: 120, editor: numEditor},
                    { title: "Other Deductions U/C VI A", field: "Rebate80Others", editor: "input", hozAlign: "right", headerSort: false, minWidth: 120, editor: numEditor},
                    { title: "Relief U/S 89", field: "Rebate89", editor: "input", minWidth: 120, hozAlign: "right", headerSort: false, editor: numEditor },
                    { title: "Tax Ded.", field: "PreTds", editor: "input", minWidth: 120, hozAlign: "right", headerSort: false, editor: numEditor},
                    //{ title: "Actions", field: "actions", hozAlign: "center", formatter: function (cell) { return `<button class="btn btn-sm" onclick="deleteRow(${cell.getData().Employee_ID})"><i class="fas fa-trash-alt"></i></button>`; }, headerSort: false, minWidth: 120 }
                    {
                        title: "Actions", field: "actions", hozAlign: "center",
                        headerSort: false, minWidth: 120,
                        //formatter: function (cell) { return `<button  id="alert-show" class="btn btn-danger"</button>`; },
                        formatter: "buttonCross", align: "center", title: "Delete", headerSort: false, cellClick: function (e, cell) {
                            Swal.fire({
                                title: 'Are you sure?',
                                //text: `Do you really want to delete employee with ID ${employeeId}? This action cannot be undone!`,
                                text: `Are you sure you want to delete this entry? This action cannot be undone!`,
                                //icon: 'warning',
                                showCancelButton: true,
                                confirmButtonColor: '#3085d6',
                                cancelButtonColor: '#d33',
                                confirmButtonText: 'Yes, delete it!',
                                cancelButtonText: 'Cancel'
                                
                            }).then((result) => {
                                
                                if (result.isConfirmed) {
                                    var rowData = cell.getRow().getData();
                                    var employeeId = rowData.Employee_ID;

                                    if (!employeeId) {
                                        return;
                                    }
                                    
                                    $.ajax({
                                        type: "POST",
                                        contentType: "application/json; charset=utf-8",
                                        url: "../../TDS/BTStrp/handler/TDSComputationV2.asmx/DeleteEmployee",
                                        data: JSON.stringify({ employeeId: employeeId }),
                                        dataType: "json",
                                        success: function (response) {
                                            //var result = jQuery.parseJSON(response.message);
                                            //if (result == 'Employee deleted successfully.') {

                                            //}
                                            cell.getRow().delete(); // Delete the row from the table
                                            Swal.fire(
                                                'Deleted!',
                                                'Employee has been deleted.',
                                                'success'
                                            );
                                        },
                                        failure: function (response) {
                                        },
                                        error: function (response) {
                                            Swal.fire({
                                                icon: 'error',
                                                title: 'Something went wrong!',
                                                //text: 'Please enter a valid PAN number.',
                                                confirmButtonText: 'OK'
                                            });
                                        }
                                    });
                                   

                                   
                                }
                            });
                        }
                    }
                ];

                // Initialize Tabulator
                table = new Tabulator("#Employee_table", {
                    frozenRows: 2,
                    data: tblAllEmpComputationGrid,
                    columns: columns,
                    addRowPos: "top",
                    history: true,
                    layout: "fitDataStretch",
                    //selectable: true,
                    pagination: "local",
                    tooltips: true,
                    debugEventsExternal: true,
                    height: "400px",
                    rowHeight: 40,
                    renderHorizontal: "basic",
                    pagination: "remote",
                    paginationSize: 10,
                    paginationSizeSelector: [100, 350, 1000, 2500, 5000],
                    movableColumns: true,
                    paginationCounter: "rows",
                    paginationElement: document.getElementById("custom-pagination"),
                    virtualDom: true,  // Enable virtual DOM for better performance on large data sets
                    virtualDomBuffer: 300,
                });
              
                table.on("cellEdited", function (cell) {
                    var field = cell.getField(); // Get the field name of the edited cell
                    SaveEmployeeInfo(field, cell);
                });

            }

            document.getElementById("txtEmployeeName").addEventListener("keyup", function () {
                
                var searchTerm = this.value;
                var ddlSerachID = $('[id*=ddlsearch]').val()
                table.clearFilter();
                if (searchTerm) {
                    if (ddlSerachID == '9') {
                        table.setFilter([
                            { field: "FirstName", type: "like", value: searchTerm }
                        ]);
                    } else if (ddlSerachID == '10') {
                        table.setFilter([
                            { field: "PanNumber", type: "like", value: searchTerm }
                        ]);
                    } else {

                    }

                }
            });

            // Populate the dropdown if it's empty
            if ($("[id*=ddlsearch]").children('option').length == 0) {
                $("[id*=ddlsearch]").empty();
                $.each(tblAllEmpComputationGrid[0].FilterList, function (i, v) {
                    $("[id*=ddlsearch]").append("<option value='" + v.FilterById + "'>" + v.FilterByVal + "</option>");
                });
            }

            Blockloaderhide();
        }

        function SaveEmployeeInfo(field, cell) {
            var rowData = cell.getRow().getData(); 
            var eid = rowData.Employee_ID;         
            var value = cell.getValue();

            if (!eid || !value) {
                return;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/TDSComputationV2.asmx/UpdateEmployeeInfo",
                data: JSON.stringify({ eid: eid, fieldName: field, value: value }),
                dataType: "json",
                success: function (response) {
                    var myList = jQuery.parseJSON(response.d);
                },
                failure: function (response) {
                },
                error: function (response) {
                    console.error("AJAX Error: ", response);
                }
            });
        }

        function ResetFilters()
        {
            $('input[type="text"], input[type="number"], textarea').val('');
            
            var select = document.getElementById("ddlsearch");
            var length = select.options.length;
            for (i = 0; i < length; i++) {
                select.options[i].remove();
            }
           
            var table = Tabulator.findTable("#Employee_table")[0];

            // Clear filters and reload the table to show all records
            table.clearFilter();
        }
      
    </script>
	
    <style type="text/css">
   
    #custom-pagination {
        margin-bottom: 10px;
        padding: 10px 15px;
        border-top: 1px solid #ddd;
        background-color: #f9f9f9;
        text-align: right;
        color: #3759d7;
        font-weight: 600;
        white-space: nowrap;
        user-select: none;
        -moz-user-select: none;
        -khtml-user-select: none;
        -webkit-user-select: none;
        -o-user-select: none;
        display: flex;
       justify-content: flex-end; 
       align-items: center;
    }

    #custom-pagination select {
        padding: 5px;
        border-radius: 4px;
        border: 1px solid #ccc;
        background-color: #fff;
        font-weight: 400;
        color: #333;
        outline: none;
    }

    #custom-pagination button {
        padding: 6px 12px;
        margin-left: 5px;
        border-radius: 4px;
        border: 1px solid #ccc;
        background-color: #3759d7;
        color: #fff;
        font-weight: 600;
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
        font-weight: 600;
        margin-right: 10px;
        color: #333;
    }

        .form-group {
            margin-bottom: 0.25em !important;
        }

        .padding5 {
            padding: 5px;
        }
         
        .parent-color {
            background-color:#EBF4FD;
            font-weight:bolder !important;
            font-size :16px;
        }
        .card {
           padding-top : 0%;
           margin-left : 1%;
           margin-right : 1%;
        }
        .PopupEntryEntry{
          width: 95%;
          padding: 6px;
          margin: 3px 0;
          box-sizing: border-box;
          border: 2px solid black;
          border-radius: 4px;
          background-color:#f4f5f7;
          text-align:left;
        }
        .AutoEntry{
         text-align:right;
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
  width:60px;
  height:33px;
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

/*body {
    margin: 0;
    font-family: Roboto,-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol","Noto Color Emoji";
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5715;
    color: #333;
    text-align: left;
    background-color: #eeeded
}*/
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
    <asp:HiddenField ID="hdnLnk" runat="server" />

    
    
    <div class="content-header">
        <div class="container-fluid" style="float: right;">
            <div class="row mb-0">
                <h5>
                    <%--<span class="font-weight-bold" style="font-size: 20px; padding-left: 12px;">Employee Details</span></h5>--%>
                    <span class="font-weight-bold" style="font-size: 20px; padding-left: 12px;">Details for Income and tax calculation</span></h5>
                <div class="col-sm-10">
                    <div id="dvButton" style="float: right; padding-bottom: 10px;">
                        <button id="btnBack" type="button" class="btn btn-outline-success legitRipple  btn-sm"><i class="fa fa-arrow-left mr-2 fa-1x"></i>Back</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="card card-body" style="padding-bottom: 7px;">
        <div class="row">
            <div class="col-3 text-left ">
                <input id="txtEmployeeName" type="text" class="form-control form-control-border" style="width: 100%;" placeholder="Search All Employee" />
            </div>
            <div class="col-3 text-left ">
                <select id="ddlsearch" name="ddlsearch" runat="server" class="form-control form-control-border select-search" style="text-transform: Capitalize; width: 100%;">
                </select>
            </div>
            <%--<div class="col-3 text-left ">
                <button id="resetButton" class="btn btn-outline-success btn-sm" type="button" onclick="ResetFilters()">Reset</button>
            </div>--%>
            <div class="text-right" style="padding-top: 3px;">
                <button id="btnViewDetails1" name="btnViewDetails1" onclick="openViewDetails1()" class="btn btn-outline-success btn-sm" style="padding-right: 10px;" type="button"><i class="mi-mail-outline mr-1 mi-1x"></i>Email</button>
                <span id="ok" style="width: 10px;">&nbsp; </span>
                <button id="btnDownload" type="button" class="btn btn-outline-success btn-sm"><i class="icon-file-download mr-1 icon-1x"></i>Download PDF</button>
            </div>
        </div>
    </div>
             
   
    <div class="card">
           <%-- <div class="card-header">
                    <h3 class="card-title" style=" font-size:21px;">Details for Income and tax calculation</h3>                    
            </div>--%>
         <div class="table-responsive" >
            <%--<table id="Employee_table" name="Employee_table" class="table table-hover table-xs font-size-base">
               
                   <%-- <tr>

                        <th width='3%' class="text-center border border-dark border-3">Sr.N.</th>
                        <th width='25%' class="text-center border border-dark border-3">Employee</th>
                        <th width='10%' class="text-center  border border-dark border-3">Email</th>
                        <th width='8%' class="text-center   border border-dark border-3">Pan</th>
                        <th width='10%' class="text-center border border-dark border-3">Gross Salary</th>
                        <th width='10%' class="text-center border border-dark border-3">Chp. VI-A</th>
                        <th width='10%' class="text-center border border-dark border-3">Net Income</th>
                        <th width='10%' class="text-center border border-dark border-3">Tax On Tot.Income</th>
                        <th width='10%' class="text-center border border-dark border-3">Tax Ded.</th>
                        <th width='10%' class="text-center border border-dark border-3">Sortfall/Excess</th>
                    </tr>--%>
              
            
             
            <%--</table>--%>
             <div id="custom-pagination"></div>
            <div id="Employee_table" class="table table-hover table-xs font-size-base"></div>
        </div>
    </div>
    <div id="modal_dialog_MonthlySalary" data-modalheader="Salary Details" style="display: none;"
        data-height="548" data-width="1000">
        <table id="ctl00_MasterPage_TabContainer1_TabPanel1_Table2">
            <tr>
                <td>
                    <div style="overflow: auto;">
                        <span id="ctl00_MasterPage_TabContainer1_TabPanel1_lblColumnCount" class="cssLabel"></span>
                        <span id="ctl00_MasterPage_TabContainer1_TabPanel1_lblDgMonthlySalaryMSG" class="cssLabel"></span>
                        <div style="overflow: auto; max-width: 960px;">
                            <table id="tblMonthlySalary" class="tbl" width="100%">
                            </table>
                        </div>
                    </div>
                </td>
            </tr>
        </table>

    </div>
    
    <div id="modal_ViewDetails1" class="modal fade" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary-1">
                    <h5 class="modal-title" id="lblpopup" name="lblpopup">Email Computation </h5>
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

    <div id="modal_ViewDetails2" class="modal fade" tabindex="-1">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h5 class="modal-title" id="lblpopup1" name="lblpopup">Perquisites </h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body" style="height:600px;overflow-y:auto;scrollbar-width: thin;">
                    <table id="tblPerquisites">
                    </table>
                </div>
            </div>
        </div>
    </div>

    <%-- **************** Modal Popups *****************************************--%>
</asp:Content>

