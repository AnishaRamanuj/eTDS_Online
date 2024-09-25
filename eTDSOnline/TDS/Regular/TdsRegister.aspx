<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/TDS/BTS_MasterPages/MasterPage.master" CodeFile="TdsRegister.aspx.cs" Inherits="TdsRegister" %>

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

    <script language="javascript" type="text/javascript">

        $(document).ready(function () {
            
        });


      
    </script>

</asp:Content>


 <asp:Content ID="Content2" ContentPlaceHolderID="masterpage" runat="Server">
     <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
            </div>
        </div>
    </div>
    <!-- Page header -->
    <div class="page-header">
        <div class="page-header-content header-elements-md-inline" style="padding-top: -13px; padding-left: 1rem;">
            <div class="page-title d-flex" style="padding-top: 0px; padding-bottom: 0px;">
                <h5><span class="font-weight-bold labelChange">TDS Register</span></h5>
            </div>
        </div>
    </div>


     <div class="content">
         <div class="card">

             <div class="form-group row">
                <label class="col-lg-1 col-form-label fon " style="padding-left: 47px; padding-top:5px;">From:</label>

                <div class="col-lg-1.5 ">
                    <input id="txt_FromDate" type="date" class="form-control  form-control-border" placeholder="dd/MM/yyyy"/>
                </div>
                <label class=" col-lg-1 col-form-label " style="padding-left: 70px; padding-top:5px;">To:</label>
                <div class="col-lg-1.5">
                    <input id="txt_ToDate" type="date" placeholder="dd/MM/yyyy" class="form-control form-control-border"/>
                </div>
                <div class="header-elements" style="margin:auto;">
                    <div class="list-icons">
                        <button type="button" id="btnsubmit"  onclick="btnsubmit_Click" class="btn btn-outline-success legitRipple"><i class="mi-library-books mr-2 fa-1x"></i>Generate Report</button>
                    </div>
                </div>
         </div>
        <div class="row">


            <div class="col-md-3">
                <div class="card card-primary">
                   <div class="card-header">
                       <h3 class="card-title">Nature</h3>
                       </div>
                       <div class="card-body">
                           <div class="form-group">
                               <div class="custom-control custom-radio custom-control-inline">
                            <input type="radio" class="custom-control-input" name="custom-inline-radio" id="radiobtnAll" checked=""/>
                            <label class="custom-control-label" for="radiobtnAll">All</label>
                        </div>

                                <div class="custom-control custom-radio">
                            <input type="radio" class="custom-control-input" name="custom-inline-radio" id="radiobtnSection"/>
                            <label class="custom-control-label" for="radiobtnSection">Section Wise</label>
                        </div>

                    
                    <div id="" class=" filter-container" style="display: none;">
                        <select id="ddlSection" name="ddlSection" class="form-control select select2-hidden-accessible">
                        </select>
                    </div>
                       </div>
                    </div>
                    </div>
                      
                </div>
         

             <div class="col-md-3">
                <div class="card card-warning">
                   <div class="card-header">
                       <h3 class="card-title">Branch</h3>
                       </div>
                       <div class="card-body">
                           <div class="form-group">
                               <div class="custom-control custom-radio custom-control-inline">
                               <input type="radio" class="custom-control-input" name="custom-inline-radio1" id="radio_AllBranch" checked=""/>
                          <label for="radio_AllBranch" class="custom-control-label">All Branch</label>
                               </div>


                               <div class="custom-control custom-radio">
                          <input type="radio" class="custom-control-input" name="custom-inline-radio1" id="radio_Branch" />
                                 <label for="radio_Branch" class="custom-control-label">Praticular Branch</label>

                                    <div style="text-align: center">
                                                                    <select id="ddlbrnach" enabled="false" class="form-control select select2-hidden-accessible" runat="server">
                                                                    </select>
                                                                </div>
                                         </div>
                       </div>


                      </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card card-success">
                   <div class="card-header">
                       <h3 class="card-title">Company Type</h3>
                       </div>
                       <div class="card-body">
                           <div class="form-group">
                               <div class="custom-control custom-radio">
                               <input class="custom-control-input" type="radio" id="radio_CompanyAll" name="custom-inline-radio2" checked=""  oncheckedchanged="radiobtnAll_CheckedChanged" />
                          <label for="radio_CompanyAll" class="custom-control-label">All</label>
                               </div>

                               <table>
                                   <tbody>
                                   <tr class="custom-control custom-radio">
                               <td>
                        <input class="custom-control-input" type="radio" id="radio_Company" name="custom-inline-radio2"  checked="" />
                                 <label for="radio_Company" class="custom-control-label">Company</label>
                                   </td>
                                       </tr>
                                       <tr class="custom-control custom-radio">
                                       <td>
                                    <input class="custom-control-input" type="radio" id="radio_Indivisual" name="custom-inline-radio2" checked=""/>
                                 <label for="radio_Indivisual" class="custom-control-label">Individual</label>
                                           </td>
                                           </tr>

                                       <tr class="custom-control custom-radio">
                                       <td>
                                     <input class="custom-control-input" type="radio" id="radio_other" name="custom-inline-radio2" checked="" />
                                 <label for="radio_other" class="custom-control-label">Others</label>
                                     
                                         </td>
                       </tr>
                                       </tbody>
                                   </table>


                      </div>
                </div>
            </div>

        </div>



             <div class="col-md-3">
                <div class="card card-secondary">
                   <div class="card-header">
                       <h3 class="card-title">Sorting</h3>
                       </div>
                       <div class="card-body">
                           <div class="form-group">
                               <div class="custom-control custom-radio">
                               <input class="custom-control-input" type="radio" id="radiobtnAllDates" name="custom-inline-radio3" oncheckedchanged="radiobtnAll_CheckedChanged" />
                          <label for="radiobtnAllDates" class="custom-control-label">All Dates</label>
                               </div>


                               <div class="custom-control custom-radio">
                        <input class="custom-control-input" type="radio" id="radiobtnpartywise" name="custom-inline-radio3" checked="" oncheckedchanged="radiobtnSection_CheckedChanged"/>
                                 <label for="radiobtnpartywise" class="custom-control-label">Party Date Wise</label>

                                   
                                                                </div>
                                       
                       </div>


                      </div>
                </div>
            </div>
    </div>
        </div>
         </div>
</asp:Content>
