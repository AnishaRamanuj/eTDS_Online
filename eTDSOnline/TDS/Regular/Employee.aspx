<%@ Page Title="" Language="C#" MasterPageFile="~/TDS/BTS_MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="Employee.aspx.cs" Inherits="Admin_Employee" %>

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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <div class="row" style="height: 10px;"></div>
    <div class="content">
        <div class="card">
            <div class="content-header">
                <div class="container-fluid" style="padding-top: 0px;">
                    <div class="row" style="align-items: center;">
                        <div class="col-sm-2">
                            <h5><span class="font-weight-bold">Employee Details</span></h5>
                        </div>
                        <div style="margin-left: auto; padding-bottom: 7px;">
                            <button id="btnSave" name="btnSave" class="btn btn-outline-success legitRipple" type="button"><b><i class="mi-save"></i></b>Save</button>
                            <button id="btnVoucherCancel" name="btnVoucherCancel" class="btn btn-outline-success legitRipple" type="button"><b><i class="mi-save"></i></b>Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="card">
            <div class="card-body">
                <div class="form-group row" style="height: 25px;">
                    <div class="col-lg-1.5" style="padding-left: 0px; padding-top: 12px;">
                        <label class="col-form-label">Employee Name</label>
                    </div>
                    <div style="padding-top: 12px; margin-left: 20px;">:</div>
                    <div class="col-lg-3">
                        <input id="txtEmpName" type="text" class="form-control form-control-border" />
                    </div>
                </div>

                <div class="form-group row" style="height: 25px;">
                    <div class="col-lg-1.5" style="padding-left: 0px; padding-top: 12px;">
                        <label class="col-form-label">PAN</label>
                    </div>
                    <div style="padding-top: 12px; margin-left: 103px;">:</div>
                    <div class="col-lg-2">
                        <input id="txtPANNo" type="text" class="form-control form-control-border" />
                    </div>
                    <div style="margin-left: 20px;">
                        <button id="btnPANVal" type="button" class="btn btn-outline-success legitRipple">Validate</button>
                    </div>
                </div>

                <div class="form-group row" style="height: 25px;">
                    <div class="col-lg-1.5" style="padding-left: 0px; padding-top: 12px;">
                        <label class="col-form-label">Category</label>
                    </div>
                    <div style="padding-top: 12px; margin-left: 66px;">:</div>
                    <div class="col-lg-2">
                        <select id="drpCate" class="form-control select select2-hidden-accessible">
                            <option value="0">Select</option>
                            <option value="General">General</option>
                            <option value="Female">Female</option>
                            <option value="Senior">Senior Citizen</option>
                            <option value="Very Senior">Very Senior Citizen</option>
                        </select>
                    </div>
                </div>

                <div class="form-group row" style="height: 25px;">
                    <div class="col-lg-1.5" style="padding-left: 0px; padding-top: 12px;">
                        <label class="col-form-label">Metro City</label>
                    </div>
                    <div style="padding-top: 12px; margin-left: 57px;">:</div>
                    <div class="col-lg-2">
                        <select id="drpMetro" class="form-control select select2-hidden-accessible">
                            <option value="0">Select</option>
                            <option value="YES">Yes</option>
                            <option value="NO">No</option>

                        </select>
                    </div>
                </div>

                <div class="form-group row" style="height: 20px;">
                    <div class="col-lg-1.5" style="padding-left: 0px; padding-top: 12px;">
                        <label class="col-form-label">Dt of Joining</label>
                    </div>
                    <div style="padding-top: 12px; margin-left: 40px;">:</div>
                    <div class="col-lg-2">
                        <input id="txtJoinDate" type="date" class="form-control form-control-border" placeholder="dd/MM/yyyy" />
                    </div>
                </div>

                <div class="form-group row" style="height: 20px;">
                    <div class="col-lg-1.5" style="padding-left: 0px; padding-top: 12px;">
                        <label class="col-form-label">Dt of Resign</label>
                    </div>
                    <div style="padding-top: 12px; margin-left: 45px;">:</div>
                    <div class="col-lg-2">
                        <input id="txtResDate" type="date" class="form-control form-control-border" placeholder="dd/MM/yyyy" />
                    </div>
                </div>

            </div>
        </div>

        <div class="card">
            <div class="card-body">
                <div class="card-header" style="padding-left: 0px; padding-top: 0px; padding-bottom: 0px;">
                    <div class="card-title">
                        <h5 class="col-form-label font-weight-bold">Optional</h5>
                    </div>
                </div>

                <div class="form-group row" style="height: 25px;">
                    <div class="col-lg-1" style="padding-left: 0px; padding-top: 12px;">
                        <label class="col-form-label">Designation</label>
                    </div>
                    <div style="padding-top: 12px; margin-left: 29px;">:</div>
                    <div class="col-lg-2">
                        <select id="drpDesg" class="form-control select select2-hidden-accessible">
                            <option value="0">Select</option>
                        </select>
                    </div>
                </div>

                <div class="form-group row" style="height: 25px;">
                    <div class="col-lg-1" style="padding-left: 0px; padding-top: 12px;">
                        <label class="col-form-label ">Email</label>
                    </div>
                    <div style="padding-top: 12px; margin-left: 27px;">:</div>
                    <div class="col-lg-2">
                        <input id="txtEmail" type="text" class="form-control form-control-border" />
                    </div>
                </div>

                <div class="form-group row" style="height: 25px;">
                    <div class="col-lg-1" style="padding-left: 0px; padding-top: 12px;">
                        <label class="col-form-label">Mobile No</label>
                    </div>
                    <div style="padding-top: 12px; margin-left: 27px;">:</div>
                    <div class="col-lg-2">
                        <input id="txtMobNo" type="text" class="form-control form-control-border" />
                    </div>
                </div>

                <div class="form-group row" style="height: 25px;">
                    <div class="col-lg-1" style="padding-left: 0px; padding-top: 12px;">
                        <label class="col-form-label">Branch</label>
                    </div>
                    <div style="padding-top: 12px; margin-left: 26px;">:</div>
                    <div class="col-lg-2">
                        <select id="drpBranch" class="form-control select select2-hidden-accessible">
                            <option value="0">Select</option>
                        </select>
                    </div>
                </div>

                <div class="form-group row" style="height: 25px;">
                    <div class="col-lg-1" style="padding-left: 0px; padding-top: 12px;">
                        <label class="col-form-label">Address</label>
                    </div>
                    <div style="padding-top: 12px; margin-left: 27px;">:</div>
                    <div class="col-lg-2">
                        <input id="txtAddress" type="text" class="form-control form-control-border" />
                    </div>
                </div>

            </div>
        </div>
    </div>

</asp:Content>

