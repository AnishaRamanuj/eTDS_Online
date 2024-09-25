<%@ Page Title="" Language="C#" MasterPageFile="~/TDS/BTS_MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="SalaryImport.aspx.cs" Inherits="BTStrp_Regular_SalaryImport" %>

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


    <script language="javascript" type="text/javascript">
        $(document).ready(function () {

            $("[id*=btnAdd]").click(function () {
                $("[id*=dvOutputResults]").html('');
                $("[id*=drpMonth]").val(0);
            });

            $("body").on("click", "#btnUpload", function () {
                $('[id*=dvOutputResults]').html('');
                if ($("#drpMonth").val() == 0) {
                    showDangerAlert("Please select month");
                    return false;
                }
                var file = $("#fileTemplate")[0].files[0];

                if (!file) {
                    showDangerAlert("No file selected");
                    return false;
                }
                var Conn = $("[id*=hdnConnString]").val();
                var formData = new FormData();
                formData.append("fileName", $("#fileTemplate").val());
                formData.append("file", $("#fileTemplate")[0].files[0]);
                formData.append("compId", $("[id*=hdnCompanyid]").val());
                formData.append("month", $("[id*=drpMonth]").val());
                formData.append("Conn", Conn);

                $("#fileTemplate").val("");

                $.ajax({
                    url: '../../TDS/BTStrp/handler/SalaryImport.asmx/BulkUploadSalary',
                    type: 'POST',
                    contentType: false,
                    processData: false,
                    dataType: 'json',
                    data: formData,
                    success: function (msg) {
                        var message = msg;

                        if (message.BulkUploadMessage != null && message.BulkUploadMessage != "")
                            showSuccessAlert(message.BulkUploadMessage);

                        if (message.IsBulkValidationSuccess == false)
                            //showDangerAlert(message.BulkValidationMessage);
                            $('[id*=dvOutputResults]').html("Failed to upload monthly salary for below records, please correct the data and re-upload." + "<br>" + message.BulkValidationMessage);
                    },
                    failure: function (response) {
                        showDangerAlert(response.responseText);
                    },
                    error: function (response) {
                        showDangerAlert(response.responseText);
                    }
                });

            });
        });

        
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:HiddenField ID="hdnCompanyid" runat="server" />
    <asp:HiddenField ID="hdnConnString" runat="server" />
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
            </div>
        </div>
    </div>
    <div class="page-header " style="height: 50px;">
        <div class="page-header-content header-elements-md-inline" style="padding-top: -13px; padding-left: 1rem;">
            <div class="page-title d-flex" style="padding-top: 0px; padding-bottom: 0px;">
                <h5><i class="icon-arrow-left52 mr-2"></i><span class="font-weight-bold">TDS Salary</span></h5>
                <a href="#" class="header-elements-toggle text-default d-md-none"><i class="icon-more"></i></a>
            </div>
        </div>
    </div>
    <div class="content">
        <div id="dvGrid" class="card">
            <div class="datatable-header">
                <div id="DataTables_Table_1_filter" class="form-group row">

                    <div class="col-5">

                        <button type="button" id="btnImportExcel" data-toggle="modal" data-target="#modal_ImportExcel" style="float: left;" class="btn btn-outline-success legitRipple "><i class="fas fa-plus mr-2 fa-1x"></i>Import Excel</button>
                        &nbsp;&nbsp;&nbsp;&nbsp;     
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /main content -->

    <!-- Basic modal -->
    <div id="modal_ImportExcel" class="modal fade" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary-1">
                    <h5 class="modal-title">Import Excel</h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="form-group row">
                        <label class="col-lg-3 font-weight-bold col-form-label">Template:</label>
                        <%-- <div class="col-lg-3">
                            <input type="text" class="form-control" value="" id="txtFileTemplate" placeholder="File Name" />
                        </div>--%>
                        <div class="col-lg-3">
                            <%--<input type="button" class="btn btn-outline-success legitRipple" value="Download Template" onclick="DownloadFile('DrawingsUpload.xlsx')" />--%>
                            <a href="../Templates/Salary-ImportXL-2024.xlsx">Download Template File</a>
                        </div>
                        <br />
                    </div>
                    <div class="form-group row">
                        <label class="col-lg-3 font-weight-bold col-form-label">Upload Template:</label>
                        <div class="col-lg-3">
                            <input
                                type="file"
                                id="fileTemplate"
                                name="fileTemplate"
                                accept=".csv, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" class="btn btn-outline-success legitRipple" />
                        </div>
                        <br />
                    </div>
                    <div class="form-group row">
                        <label class="col-lg-3 font-weight-bold col-form-label">Month:</label>
                        <div class="col-lg-3">
                            <select id="drpMonth" name="drpMonth" class="form-control select select2-hidden-accessible">
                                <option value="0">--Select--</option>
                                <option value="1">Jan</option>
                                <option value="2">Feb</option>
                                <option value="3">Mar</option>
                                <option value="4">Apr</option>
                                <option value="5">May</option>
                                <option value="6">Jun</option>
                                <option value="7">Jul</option>
                                <option value="8">Aug</option>
                                <option value="9">Sep</option>
                                <option value="10">Oct</option>
                                <option value="11">Nov</option>
                                <option value="12">Dec</option>
                            </select>
                        </div>
                        <br />
                    </div>
                    <div class="col-lg-8 row" style="float: left">
                        <input type="button" value="Upload" id="btnUpload" class="btn bg-success legitRipple" />
                        <br />
                    </div>
                    <div class="col-lg-12 row" id="dvOutputResults" style="color: red">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="btnClose"  class="btn btn-outline-success legitRipple" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <!-- /basic modal -->
</asp:Content>

