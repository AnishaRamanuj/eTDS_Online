<%@ Page Title="" Language="C#" MasterPageFile="~/TDS/BTS_MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="Bank.aspx.cs" Inherits="Company_Bank" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
 
    <script src="../BTStrp/js/bootstrap_multiselect.js" type="text/javascript"></script>
    <script type="text/javascript" src="../BTStrp/js/moment.js"></script>
    <script src="../BTStrp/js/form_select2.js" type="text/javascript"></script>
    <script src="../BTStrp/js/datatables_basic.js" type="text/javascript"></script>
    <script src="../BTStrp/js/Ajax_Pager.min.js" type="text/javascript"></script>
    <script src="../BTStrp/js/components_popups.js" type="text/javascript"></script>
    <script src="../BTStrp/js/components_modals.js" type="text/javascript"></script>
    <script src="../BTStrp/js/echarts.min.js" type="text/javascript"></script>
    <script src="../BTStrp/js/PopupAlert.js" type="text/javascript"></script>

 

 
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            $('.sidebar-main-toggle').click();
            $("[id*=hdnPages]").val(1);
            $("[id*=hdnSize]").val(200);
            GetBankList(1, 25);
            $("[id*= btnAddbank]").on('click', function () {
                ResetControls();
            });

            $("[id*= btnSave]").on('click', function () {
                if ($("[id*=txtBankName]").val() == '') {
                    showDangerAlert('Enter bank name');
                    $('#modal_Editbank').modal('show');
                    return false;
                }
                else if ($("[id*=txtBankBranch]").val() == '') {
                    showDangerAlert('Enter branch code');
                    $('#modal_Editbank').modal('show');
                    return false;
                }
                else if ($("[id*=txtBSRCode_]").val() == '') {
                    showDangerAlert('Enter BSR code');
                    $('#modal_Editbank').modal('show');
                    return false;
                }
                else
                    InsertUpdate();
            });

        });

        //Display Loan Grid
        function GetBankList(pageIndex, Pagesize) {
            Blockloadershow();
            var Srch = $("[id*=txtsrch]").val();
            var tbl = "";
            $.ajax({
                type: "POST",
                url: "../Handler/BankMaster.asmx/GetBankRecord",
                data: '{Srch:"' + Srch + '",pageIndex:' + pageIndex + ',pageSize:' + Pagesize + '}',
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function (msg) {
                    var xmlDoc = $.parseXML(msg.d);
                    var xml = $(xmlDoc);
                    var BankList = xml.find("Table");
                    var BankListCount = xml.find("Table1");
                    $("[id*=tbl_Bank_] tbody").empty();
                    $("[id*=tbl_Bank_] thead").empty();
                    tbl = tbl + "<thead><tr>";
                    tbl = tbl + "<th class='labelChange' style='text-align: center;font-weight: bold;'>Sr.No</th>";
                    tbl = tbl + "<th class='labelChange' style='font-weight: bold;text-align: left;'>Bank Name</th>";
                    tbl = tbl + "<th class='labelChange' style='font-weight: bold;text-align: left;'>Branch </th>";
                    tbl = tbl + "<th class='labelChange' style='font-weight: bold;text-align: left;'>BSR Code</th>";
                    tbl = tbl + "<th style='font-weight: bold; text-align: center;'>Delete</th>";
                    tbl = tbl + "</tr></thead>";
                    
                        if (BankList.length > 0) {

                            $.each(BankList, function () {
                                tbl = tbl + "<tr>";
                                tbl = tbl + "<td style='text-align: center;'>" + $(this).find("sino").text() + "<input type='hidden' id='hdnBank_ID_' value='" + $(this).find("Bank_ID").text() + "' name='hdnBank_ID_'></td>";
                                tbl = tbl + "<td style='text-align: left;'><a href='#'  data-toggle='modal' data-target='#modal_EditHourly'   onclick='View_Show($(this))' >" + $(this).find("Bank_Name").text() + "</a></td>";
                                tbl = tbl + "<td style='text-align: left;'>" + $(this).find("Bank_Branch").text() + "</td>";
                                tbl = tbl + "<td style='text-align: left;'>" + $(this).find("Bsrcode").text() + "</td>";
                                tbl = tbl + "<td style='text-align: center;'><a class='list-icons-item '><i onclick='Bank_Loan($(this))' style='cursor: pointer;' class='icon-trash text-danger-600'></i></a></td>";
                                tbl = tbl + "</tr>";
                            });
                            $("[id*=tbl_Bank_]").append(tbl);
                            if (parseFloat(BankListCount.find('totalcount').text()) !="") {
                                RecordCount = parseFloat(BankListCount.find('totalcount').text());
                            }
                            Pager(RecordCount);

                            Blockloaderhide();
                        }

                        else {
                            tbl = tbl + "<tr>";

                            tbl = tbl + "<td ></td>";
                            tbl = tbl + "<td >No Record Found !!!</td>";
                            tbl = tbl + "<td ></td>";
                            tbl = tbl + "<td ></td>";
                            tbl = tbl + "<td ></td>";
                            tbl = tbl + "</tr>";
                            $("[id*=tbl_Bank_]").append(tbl);

                            Pager(0);
                            Blockloaderhide();
                        }
                   
                },
                failure: function (response) {
                    alert('Cant Connect to Server' + response.d);
                },
                error: function (response) {
                    alert('Error Occoured ' + response.d);
                }
            });
        }

        function Pager(RecordCount) {
            $(".Pager").ASPSnippets_Pager({
                ActiveCssClass: "current",
                PagerCssClass: "pager",
                PageIndex: parseInt($("[id*=hdnPages]").val()),
                PageSize: parseInt($("[id*=hdnSize]").val()),
                RecordCount: parseInt(RecordCount)
            });

            ////pagging changed bind LeaveMater with new page index
            $(".Pager .page").on("click", function () {
                $("[id*=hdnPages]").val($(this).attr('page'));
                pg = parseInt($("[id*=hdnSize]").val()),
                    GetBankList(($(this).attr('page')), pg)
            });
        }

        function ResetControls() {
            $("[id*=hdnBankID_]").val('0');
            $("[id*=txtBankName]").val('');
            $("[id*=txtBankBranch]").val('');
            $("[id*=txtBSRCode_]").val('');
        }

        function View_Show(i) {
            ResetControls();

            var row = i.closest("tr");
            var Bank_ID = row.find("input[name=hdnBank_ID_]").val();

            $.ajax({
                type: "POST",
                url: "../Handler/BankMaster.asmx/GetBankEdit",
                data: '{Bank_ID:' + Bank_ID + '}',
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function (msg) {
                    var xmlDoc = $.parseXML(msg.d);
                    var xml = $(xmlDoc);
                    var BankList = xml.find("Table");

                    $("[id*=dvButton]").show();
                    $("[id*=dvDetail]").show();
                    $("[id*=dvlogin]").show();
                    $('#modal_Editbank').modal('show');
                    $.each(BankList, function () {
                        $("[id*=hdnBankID_]").val($(this).find("Bank_ID").text());
                        $("[id*=txtBankName]").val($(this).find("Bank_Name").text());
                        $("[id*=txtBankBranch]").val($(this).find("Bank_Branch").text());
                        $("[id*=txtBSRCode_]").val($(this).find("Bsrcode").text());
                    });
                },
                failure: function (response) {
                    alert('Cant Connect to Server' + response.d);
                },
                error: function (response) {
                    alert('Error Occoured ' + response.d);
                }
            });
        }

        function InsertUpdate() {
            var Bank_Name = $("[id*=txtBankName]").val();
            var Bank_Branch = $("[id*=txtBankBranch]").val();
            var Bsrcode = $("[id*=txtBSRCode_]").val();
            var Bank_ID = $("[id*=hdnBankID_]").val();

            $.ajax({
                type: "POST",
                url: "../Handler/BankMaster.asmx/InsertUpdateBank",
                data: '{Bank_Name:"' + Bank_Name + '",Bank_Branch:"' + Bank_Branch + '", Bsrcode:"' + Bsrcode + '", Bank_ID:' + Bank_ID + '}',
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function (msg) {
                    //var xmlDoc = $.parseXML(msg.d);
                    //var xml = $(xmlDoc);
                    //var BankList = xml.find("Table");
                    if (msg.d == "-1") {
                        showDangerAlert('Duplicate BSR Code found!');
                        $('#modal_Editbank').modal('show');
                        return false;
                    } else {
                        if (msg.d > 0) {
                            showSuccessAlert('Record Updated Successfully !!!');
                            $('#modal_Editbank').modal('hide');
                        } else {
                            showSuccessAlert('Record Inserted Successfully !!!');
                            $('#modal_Editbank').modal('hide');
                        }
                        GetBankList(1, 25);
                    }
                },
                failure: function (response) {
                    alert('Cant Connect to Server' + response.d);
                },
                error: function (response) {
                    alert('Error Occoured ' + response.d);
                }
            });
        }

        function Bank_Loan(i) {
            var Text = 'Are you sure want to Delete this bank name ?';
            var notyConfirm = new Noty({
                text: '<h5 class="mb-3">' + Text + '</h5>',
                timeout: false,
                modal: true,
                layout: 'center',
                closeWith: 'button',
                type: 'info',
                theme: 'alert alert-warning p-1',
                buttons: [
                    Noty.button('Delete', 'btn btn-outline-success legitRipple', function () {
                        notyConfirm.close();
                        DeleteButtonBank(i);
                    }),
                    Noty.button('Cancel', 'btn btn-outline-success legitRipple  ', function () {
                        notyConfirm.close();
                        return false;
                    },
                        { id: 'button1', 'data-status': 'ok' }
                    )
                ]
            }).show();
        }

        function DeleteButtonBank(i) {
            var row = i.closest("tr");
            var Bank_ID = row.find("input[name=hdnBank_ID_]").val();
            $.ajax({
                type: "POST",
                url: "../Handler/BankMaster.asmx/DeleteRecord",
                data: '{Bank_ID:' + Bank_ID + '}',
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function (msg) {
                    //var xmlDoc = $.parseXML(msg.d);
                    //var xml = $(xmlDoc);
                    //var BankList = xml.find("Table");
                    //if (BankList.find('BankID').text() == -1) {
                    //    showDangerAlert('Bank Name is already Aloocated can not Delete!!!');
                    //} else {
                    if (msg.d > 0) {
                            showSuccessAlert('Bank Deleted Successfully !!!');
                        GetBankList(1, 25);
                        }
                    //}
                },
                failure: function (response) {
                    alert('Cant Connect to Server' + response.d);
                },
                error: function (response) {
                    alert('Error Occoured ' + response.d);
                }
            });
        }
    </script>

    

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" Runat="Server">
     <asp:HiddenField ID="hdnPages" runat="server" />
    <asp:HiddenField ID="hdnSize" runat="server" />
    <asp:HiddenField ID="hdnBankID_" runat="server" Value="0" />
   <!-- Page header -->
    <div class="page-header " style="height: 50px;">
        <div class="page-header-content header-elements-md-inline" style=" padding-left: 1rem;">
            <div class="page-title d-flex" style="padding-top: 5px; padding-bottom: 0px;">
                <h4><span class="font-weight-bold">Manage Bank</span></h4>
                <a href="#" class="header-elements-toggle text-default d-md-none"><i class="icon-more"></i></a>
            </div>
        </div>
    </div>

     <div class="content">
           <div id="dvGrid" class="card">
               <div class="datatable-header">
                <div id="DataTables_Table_1_filter" class="form-group row">
                    <input id="txtsrchBank" type="text" class="form-control col-3 form-control-border" placeholder="Type to filter..." />
                    <button id="btnSrch" type="button" class="btn btn-outline-success  rounded-round text-primary-800 btn-icon legitRipple">
                        <i class="icon-search4"></i>
                    </button>
                    &nbsp;&nbsp;
                <div class="col-7">
                    <button type="button" id="btnAddbank" data-toggle="modal" data-target="#modal_Editbank" style="float: left;" class="btn btn-outline-success legitRipple"><i class="fas fa-plus mr-2 fa-1x"></i>Add Bank</button>
                </div>
                    <div class="ShowPage">
                        <select id="drpPageSize" name="drpPageSize" class="form-control select select2-hidden-accessible col-4" data-fouc>
                            <option value="25">25</option>
                            <option value="50">50</option>
                            <option value="100">100</option>
                            <option value="200" selected="selected">200</option>
                        </select>
                    </div>
                </div>
            </div>
               <div class="table-responsive">
                <table id="tbl_Bank_" class="table table-hover table-xs font-size-base ">
                </table>
                <table id="tblPager" style="border: 1px solid #BCBCBC; height: 50px; width: 100%">
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

     <div id="modal_Editbank" class="modal fade" tabindex="-1">
         <div class="modal-dialog">
             <div class="modal-content">
                  <div class="modal-header bg-primary-1">
                    <h5 class="modal-title">Add Bank</h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                 <div class="modal-body">
                      <div class="form-group row">
                        <label class="col-form-label col-sm-4 font-weight-bold">Bank Name</label>
                        <div class="col-sm-5">
                            <input id="txtBankName" name="txtBankName" type="text" placeholder="Bank Name" class="form-control form-control-border" />
                        </div>
                    </div>
                     <div class="form-group row">
                        <label class="col-form-label col-sm-4 font-weight-bold">Bank Branch</label>
                        <div class="col-sm-5">
                            <input id="txtBankBranch" name="txtBankBranch" type="text" placeholder="Bank Branch" class="form-control form-control-border" />
                        </div>
                    </div>
                     <div class="form-group row">
                        <label class="col-form-label col-sm-4 font-weight-bold">BSR Code</label>
                        <div class="col-sm-5">
                            <input id="txtBSRCode_" name="txtBSRCode_" type="text" placeholder="BSR Code" class="form-control form-control-border" />
                        </div>
                    </div>
                 </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-outline-success legitRipple" data-dismiss="modal">Close</button>
                    <button type="button" id="btnSave" class="btn btn-outline-success legitRipple" data-dismiss="modal"><i class="mi-save mr-2 mi-1x"></i>Save</button>
                </div>
             </div>
         </div>
     </div>
</asp:Content>

