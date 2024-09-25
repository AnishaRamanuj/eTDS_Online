<%@ Page Title="" Language="C#" MasterPageFile="~/TDS/BTS_MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="Incometax.aspx.cs" Inherits="Incometax" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   
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
        @keyframes runningNotification {
            0% {
                transform: translateX(100%);
            }

            50% {
                transform: translateX(0%);
            }

            100% {
                transform: translateX(-100%);
            }
        }

        .card-body2 {
            animation: runningNotification 20s linear infinite;
        }

        .clsbold {
            font-weight: bold;
        }
        .button{
            border-color:green;

        }

    
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            GetUseridPassword();
        });

        function GetUseridPassword() {
            var Compid = $("[id*=hdnCompid]").val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../handler/Voucher.asmx/GetTracesDetails",
                data: '{Compid:' + Compid + '}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    if (myList.length > 0) {
                        $("[id*=txtUserID]").val(myList[0].Userid);
                        $("[id*=txtPassword]").val(myList[0].Password);
                    } else {
                        ShowWarningWindow('Enter IncomeTax Login Details!!!');
                    }


                },
                failure: function (response) {

                },
                error: function (response) {

                }
            });
        }


    </script>

        
</asp:Content>
        <asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" Runat="Server">
       


                    <div class="card">
                   <div  class="col-md-7"  style="margin-left:325px;">
                      <div class="login-card-body card-info">
                      <img src="../image/Incometaxlogo.jpeg" />
                       <div class="card-header">
                       <h3 class="card-title">Income Tax Login</h3>
                               </div>

                          </div>
                       </div>
                      


                           <div class="col-md-5"  style="margin-left:426px;">
                           <div class=" card card-body">
                                <div class="form-group row">
                               <label class="col-sm-3 col-form-label">TAN:</label>
                                      <div class="col-6">
                               <input type="text" class="form-control" id="TANID" placeholder="Enter UserId"/>
                                </div>
                                    </div>
                      
                               <div class="form-group row">
                      <label  class="col-sm-3 col-form-label">Password<span class="text-danger">*</span></label>
                         <div class="col-6">
                          <input type="password" class="form-control" id="txtPassword" placeholder="Enter Password"/>
                             </div>
                                  </div>
                                   
                                        

                                      <div class="">
                                 <button type="submit" class="btn btn-outline-success legitRipple">Save</button>
                                <button type="submit" id="btnGetRequest" class="btn btn-outline-success legitRipple" onclick="return TracesDetails()">Cancel</button>
                                    </div>
                          </div>
                    </div>
                              </div>
   
</asp:Content>





