<%@ Page Title="" Language="C#" MasterPageFile="~/TDS/BTS_MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="BulkPAN_Verification_AllVoucher.aspx.cs" Inherits="Admin_BulkPAN_Verification_AllVoucher" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit"   TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../BTStrp/css/jquery-confirm.min.css" rel="stylesheet" />
    <link href="../BTStrp/css/common.css" rel="stylesheet" />
    <script src="../BTStrp/js/bootstrap_multiselect.js" type="text/javascript"></script>
    <script src="../BTStrp/js/moment.js" type="text/javascript" ></script>
    <script src="../BTStrp/js/form_select2.js" type="text/javascript"></script>
    <script src="../BTStrp/js/datatables_basic.js" type="text/javascript"></script>
    <script src="../BTStrp/js/Ajax_Pager.min.js" type="text/javascript"></script>
    <script src="../BTStrp/js/components_popups.js" type="text/javascript"></script>
    <script src="../BTStrp/js/components_modals.js" type="text/javascript"></script>
    <script src="../BTStrp/js/echarts.min.js" type="text/javascript"></script>
    <script src="../BTStrp/js/PopupAlert.js" type="text/javascript"></script>
    <script src="../BTStrp/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../BTStrp/js/bootstrap2.3.2.min.js"></script>

    <script type="text/javascript" language="javascript">
 
      $(document).ready(function () {

          $("[id*=lblSuccess]").hide();
          $("[id*=btnPanVerification]").hide();
          $("[id*=lblProcess]").hide();
          $("[id*=tblTracesLogin]").hide();
          $("[id*=ddlFromType]").val($("[id*=hdnForm]").val());
          $("[id*=ddlQuater]").val($("[id*=hdnQuater]").val());
          $("[id*=ddlstatus]").val('Non');
          $("[id*=hdnPages]").val(1);
          $("[id*=hdnSize]").val(500);
          $("[id*=tblrslt]").hide();
          $("[id*=txtTan]").attr("disabled", true);
          $("[id*=ddlstatus]").val('All');

          onLoad(1, 500);

          $("[id*=PnvVerfy]").click(function () {

              ShowModalPopup();
              loadLoginDetails();
              getCaptcha();
          });

          $("[id*=imgRsh]").click(function () {
              loadLoginDetails();
              getCaptcha();
          });
          $("[id*=ddlstatus]").change(function () {
              onLoad(1, 500);
          });
          $("[id*=ddlQuater]").change(function () {
              onLoad(1, 500);
          });
          $("[id*=ddlFromType]").change(function () {
              onLoad(1, 500);
          });

      });

      function HideModalPopup() {
          $(".MastermodalBackground2").hide();
          $find("programmaticModalPopupOrginalBehavior").hide();

      }
            ///// show modalpopup
      function ShowModalPopup() {
          $find("programmaticModalPopupOrginalBehavior").show();

      }

      function Verifystatus() {
          $("[id*=btnPanVerification]").hide();
      }

      function getCaptcha() {
          //get Captcha       
          $("#imgajaxLoader").show();
          $.ajax({
              type: "POST",
              url: "TService.asmx/tCaptcha",
              contentType: "application/json; charset=utf-8",
              dataType: "json",

              success: function (data) {
                  var result = JSON.parse(data.d);
                  Cookies = result[0]["Cookie"];
                  document.getElementById("captchaImg").src = result[0]["base64"];
                  $("#imgajaxLoader").hide();
                  $("#tblCaptcha").show();
              },
              failure: function (response) {
                  $("#imgajaxLoader").hide();
                  ShowErrorWindow(response.d);
              }
          });

      }
      function loadLoginDetails() {
          $("[id*=tblTracesLogin]").hide();
          $("#imgajaxLoader").show();
          $.ajax({
              type: "POST",
              url: "TService.asmx/Get_tracesLoginDetails",
              contentType: "application/json; charset=utf-8",
              dataType: "json",

              success: function (data) {
                  var result = JSON.parse(data.d);
                  if (result.error) {
                      ShowErrorWindow(result.error);
                      $("[id*=tblTracesLogin]").show();
                      $("[id*=tblver]").hide();
                      return false;
                  }
                  else {
                      //loop Challan Details
                      var dt_Login = JSON.parse(result["dt_Login"]);
                      if (dt_Login.length > 0) {
                          var Login_dtls = dt_Login[0];
                          $("#txtTan").val(Login_dtls["Tan"]);
                          $("#txtUserID").val(Login_dtls["User_ID"]);
                          $("#txtPassword").val(Login_dtls["Password"]);
                      }
                      else {

                          $("#txtTan").val($("[id*=txtTanNo]").val());
                          $("[id*=tblTracesLogin]").show();
                          $("[id*=tblver]").hide();
                      }
                      $("#imgajaxLoader").hide();

                  }
              },
              failure: function (response) {
                  $("#imgajaxLoader").hide();
                  ShowErrorWindow(response.d);
              }
          });

      }

      RequestTrace = function () {


          var UserID = $("#txtUserID").val();
          var Password = $("#txtPassword").val();
          var TAN_NO = $("#txtTan").val();

          var CaptchaCode = $("#captcha").val();
          var ddlForm = $('#ddlForm  option:selected').text();
          var PAN = $("[id*=ddlstatus]").val(); //$("#txtPAN").val();
          var compid = $("[id*=hdnCompanyID]").val();

          if ((UserID == null || UserID == "") || (Password == null || Password == "")) {
              ShowErrorWindow('Enter User Login Details');
              return false;
          }


          if (TAN_NO == null || TAN_NO == undefined) {
              ShowErrorWindow('TAN - Cannot be Blank');
              return false;
          }


          if (TAN_NO != "0" && TAN_NO != "") {
              if (TAN_NO != null || TAN_NO != undefined) {

                  //PAN check
                  var Pattern1 = /^([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}?$/;
                  //TAN check
                  var Pattern2 = /^([a-zA-Z]){4}([0-9]){5}([a-zA-Z]){1}?$/;
                  //AIN check
                  var Pattern3 = /^[0-9]{7}$/;

                  if (TAN_NO.match(Pattern1) || TAN_NO.match(Pattern2) || TAN_NO.match(Pattern3)) {
                      // ShowErrorWindow('correct Format of the TAN No.');
                      //return false;
                  } else {
                      ShowErrorWindow('Incorrect Format of the TAN No.');
                      return false;
                  }
              }
          }



          //if (PAN != null && PAN != undefined && PAN != "") {
          //    if (!PAN.match(/^([a-zA-Z]){4}([a-zA-Z]){1}([0-9]){4}([a-zA-Z]){1}?$/)) {
          //        ShowErrorWindow("PAN structure is not valid");
          //        return false;
          //    }
          //}


          var tracesData = {
              "objTraceData": {
                  Forms: ddlForm,
                  PAN1: PAN,
                  Compid: compid

              },
              "objLogin": {
                  UserID: UserID,
                  Password: Password,
                  TAN: TAN_NO,
                  CaptchaCode: CaptchaCode,
                  Cookie: Cookies
              }
          };
          $("[id*=lblProcess]").show();

          $(".MastermodalBackground2").show();
          document.getElementById("btnGetRequest").disabled = true;

          //debugger;
          $.ajax({
              type: "POST",
              url: "TService.asmx/BulkPANVerify_NonSal",
              contentType: "application/json; charset=utf-8",
              dataType: "json",
              data: JSON.stringify(tracesData),
              success: function (data) {
                  //  debugger;
                  var result = JSON.parse(data.d);
                  if (result.error) {
                      $("#captcha").val("");
                      //getCaptcha();
                      $(".MastermodalBackground2").hide();
                      ShowErrorWindow(result.error);
                      $("[id*=lblSuccess]").hide();
                      $("[id*=lblProcess]").hide();
                      document.getElementById("btnGetRequest").disabled = false;
                      return false;
                  }
                  else {
                      if (result.success) {
                          $("#captcha").val("");
                          //getCaptcha();
                          //var tbl_html_val = "<div><span style='padding-right:20px;'>PAN : <b>" + PAN + "</b> </span><span>Name : <b>" + result.success.Name + "</b> </span></div>";
                          //$("#divData").html(tbl_html_val);
                          $("[id*=hdnValid]").val('Valid PAN');
                          $(".MastermodalBackground2").hide();
                          $("[id*=lblSuccess]").show();
                          $("[id*=lblProcess]").hide();
                          Get_Details();
                          $("[id*=btnPanVerification]").show();
                          $("[id*=btnPanVerification]").click();
                          document.getElementById("btnGetRequest").disabled = false;
                          $(".MastermodalBackground2").hide();
                          return false;
                      }
                      if (result.timeout) {
                          $("#captcha").val("");
                          //getCaptcha();
                          //var tbl_html_val = "<div><span style='padding-right:20px;'>PAN : <b>" + PAN + "</b> </span><span>Name : <b>" + result.success.Name + "</b> </span></div>";
                          //$("#divData").html(tbl_html_val);
                          $("[id*=hdnValid]").val('Valid PAN');
                          $(".MastermodalBackground2").hide();
                          $("[id*=lblSuccess]").show();
                          $("[id*=lblSuccess]").html('Timeout occured, Few PAN no validated, retry');
                          $("[id*=lblProcess]").hide();
                          $("[id*=btnPanVerification]").show();
                          $("[id*=btnPanVerification]").click();
                          document.getElementById("btnGetRequest").disabled = false;
                          $(".MastermodalBackground2").hide();
                          return false;
                      }
                      if (result.Failed) {
                          $("[id*=btnPanVerification]").hide();
                      }
                  }
              },
              failure: function (response) {
                  $("#captcha").val("");
                  //getCaptcha();
                  document.getElementById("btnGetRequest").disabled = false;
                  $(".MastermodalBackground2").hide();
                  ShowErrorWindow(response.d);
              }
          });

          return false;
      }

            //reuestDownloads
      SaveTracesDetails = function () {
          debugger;
          var UserID = $("#txtUserID").val();
          var Password = $("#txtPassword").val();
          var TAN_NO = $("input[type=text][id*=txtTanNo]").val();
          var Compid = $("[id*=hdnCompid]").val();

          if (isValid(UserID) || isValid(Password)) {
              ShowWarningWindow('Enter User Login Details');
              return false;
          }


          //--POST REQUEST             
          $(".MastermodalBackground2").show();
          $.ajax({
              type: "POST",
              //url: "TService.asmx/reQList",
              url: "../../TDS/BTStrp/handler/Voucher.asmx/TracesDetailsSave",
              contentType: "application/json; charset=utf-8",

              data: '{Compid:' + Compid + ',UserID:"' + UserID + '",Password:"' + Password + '",TAN:"' + TAN_NO + '"}',
              dataType: "json",
              success: function (data) {

                  //bind requested downloads
                  var result = JSON.parse(data.d);
                  if (result[0].Compid > 0) {
                      ShowSuccessWindow('Successfully Saved!!!')
                      $("[id*=tblTracesLogin]").hide();
                      $("[id*=tblver]").show();
                      loadLoginDetails();
                      getCaptcha();
                  }

                  $(".MastermodalBackground2").hide();
              },
              failure: function (response) {
                  $(".MastermodalBackground2").hide();
                  ShowErrorWindow(response.d);
              }
          });


          return false;
      }

      isValid = function (value) {
          return !value
      }

      function onLoad(pageIndex, Pagesize) {

          ShowLoader();
          var sts = $("[id*=ddlstatus]").val();
          var F = $("[id*=ddlFromType]").val();
          var Q = $("[id*=ddlQuater]").val();
          
          var tc = 0;
          var RecordCount = 0;
          $.ajax({
              type: "POST",
              contentType: "application/json; charset=utf-8",
              url: "../../TDS/BTStrp/handler/Voucher.asmx/ListPANStatus",
              data: '{F:"' + F + '",Q:"' + Q + '", sts:"' + sts + '",pg:' + pageIndex + ',ps:' + Pagesize + '}',
              dataType: "json",
              success: function (msg) {

                  var myList = jQuery.parseJSON(msg.d);
                  if (myList.length > 0) {

                      var tbl = '';
                      $("[id*=tblPANLnk]").empty();
                      $("[id*=tblPANLnk] tbody").empty();

                      tbl = tbl + "<tr >";
                      tbl = tbl + "<th style='width:40%;' class='cssGridHeader'>Deductee</th>";
                      tbl = tbl + "<th style='width:10%;' class='cssGridHeader'>Date</th>";

                      tbl = tbl + "<th style='width:10%;' class='cssGridHeader'>Amount</th>";
                      tbl = tbl + "<th style='width:10%;' class='cssGridHeader'>Total TDS</th>";
                      tbl = tbl + "<th style='width:5%;' class='cssGridHeader'>Rate</th>";
                      tbl = tbl + "<th style='width:10%;' class='cssGridHeader'>Section</th>";
                      tbl = tbl + "<th style='width:5%;' class='cssGridHeader'>PAN</th>";
                      tbl = tbl + "<th style='width:10%;' class='cssGridHeader'>PAN_AAdhar_Status</th>";

                      tbl = tbl + "</tr>";
                      if (myList.length > 0) {
                          for (var i = 0; i < myList.length; i++) {
                              tbl = tbl + "<tr>";
                              tbl = tbl + "<td style='text-align: left;' class='cssGrdAlterItemStyle'  >" + myList[i].DName + "</td>";
                              tbl = tbl + "<td style='text-align: left;' class='cssGrdAlterItemStyle' >" + myList[i].PDate + "</td>";
                              tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' >" + myList[i].AmtPaid + '.00' + "</td>";
                              tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle'  >" + myList[i].Total + '.00' + "</td>";
                              tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' >" + myList[i].RT + "</td>";
                              tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' >" + myList[i].nsid + "</td>";
                              tbl = tbl + "<td style='text-align: left;' class='cssGrdAlterItemStyle'  >" + myList[i].PAN + "</td>";
                              var s = myList[i].PAN_AAdhar;
                              if (s == "Valid and Operative") {
                                  tbl = tbl + "<td style='text-align: center; color:Green;' class='cssGrdAlterItemStyle' >" + myList[i].PAN_AAdhar + "</td>";
                              }
                              if (s == "Active") {
                                  tbl = tbl + "<td style='text-align: center; color:blue;' class='cssGrdAlterItemStyle' >" + myList[i].PAN_AAdhar + "</td>";
                              }
                              if (s == "Not Verified") {
                                  tbl = tbl + "<td style='text-align: center; color:red;' class='cssGrdAlterItemStyle' >" + myList[i].PAN_AAdhar + "</td>";
                              }

                              if (s == "Invalid") {
                                  tbl = tbl + "<td style='text-align: center; color:yellow;' class='cssGrdAlterItemStyle' >" + myList[i].PAN_AAdhar + "</td>";
                              }
                              if (s == "Null") {
                                  tbl = tbl + "<td style='text-align: center; color:red;' class='cssGrdAlterItemStyle' >" + myList[i].PAN_AAdhar + "</td>";
                              }
                              if (s == "") {
                                  tbl = tbl + "<td style='text-align: center; color:red;' class='cssGrdAlterItemStyle' >" + myList[i].PAN_AAdhar + "</td>";
                              }
                              tbl = tbl + "</tr > ";
                              tc = myList[i].rid;
                          };
                          $("[id*=tblPANLnk]").append(tbl);

                          if (parseInt(tc) > 0) {
                              if (parseInt(tc) > 500) {
                                  RecordCount = parseFloat(tc);
                              } else {
                                  RecordCount = 0;
                              }
                          }
                          Pager(RecordCount);
                      }

                  }
                  else {
                      var tbl = '';
                      $("[id*=tblPANLnk]").empty();
                      $("[id*=tblPANLnk] tbody").empty();

                      tbl = tbl + "<tr >";
                      tbl = tbl + "<th style='width:40%;' class='cssGridHeader'>Deductee</th>";
                      tbl = tbl + "<th style='width:10%;' class='cssGridHeader'>Date</th>";

                      tbl = tbl + "<th style='width:10%;' class='cssGridHeader'>Amount</th>";
                      tbl = tbl + "<th style='width:10%;' class='cssGridHeader'>Total TDS</th>";
                      tbl = tbl + "<th style='width:5%;' class='cssGridHeader'>Rate</th>";
                      tbl = tbl + "<th style='width:10%;' class='cssGridHeader'>Section</th>";
                      tbl = tbl + "<th style='width:5%;' class='cssGridHeader'>PAN</th>";
                      tbl = tbl + "<th style='width:10%;' class='cssGridHeader'>PAN_AAdhar_Status</th>";

                      tbl = tbl + "</tr>";
                      $("[id*=tblPANLnk]").append(tbl);
                  }

                  hideloader();
              },
              failure: function (response) {
                  hideloader();
              },
              error: function (response) {
                  hideloader();
              }
          });
      }

      function Pager(RecordCount) {
          $(".Pager").ASPSnippets_Pager({
              ActiveCssClass: "current",
              PagerCssClass: "pager",
              PageIndex: parseInt($("[id*=hdnPages]").val()),
              PageSize: 500,
              RecordCount: parseInt(RecordCount)
          });

          ////pagging changed bind LeaveMater with new page index
          $(".Pager .page").on("click", function () {
              $("[id*=hdnPages]").val($(this).attr('page'));
              //p = $("[id*=ddlperpage]").val();

              onLoad($(this).attr('page'), 500);
          });
      }

      function ShowLoader() {

          $('.MastermodalBackground2').css("display", "block");
      }

      function hideloader() {

          $('.MastermodalBackground2').css("display", "none");
      }

      function Get_Details() {
          var sts = 'Non';
          var F = $("[id*=ddlFromType]").val();
          var Q = $("[id*=ddlQuater]").val();

          $("[id*=lblLK]").html(0);
          $("[id*=lblNL]").html(0);
          $("[id*=lblNV]").html(0);


          $.ajax({
              type: "POST",
              contentType: "application/json; charset=utf-8",
              url: "../../TDS/BTStrp/handler/Ws_PanNo.asmx/GetPANDetails",
              data: '{F:"' + F + '",Q:"' + Q + '", sts:"' + sts + '"}',
              dataType: "json",
              success: function (msg) {
                  var Pan = jQuery.parseJSON(msg.d);

                  if (Pan.length > 0) {
                      $("[id*=lblLK]").html(Pan[0].Active);
                      $("[id*=lblNL]").html(Pan[0].InActive);
                      $("[id*=lblNV]").html(Pan[0].NotVerified);

                  }
              },
              failure: function (response) {

              },
              error: function (response) {

              }
          });
      }


      function ShowErrorWindow(Message) {
          $.confirm({
              columnClass: 'large',
              icon: 'fa fa-exclamation-circle',
              title: 'Error from eTDS',
              content: Message,
              type: 'red',
              useBootstrap: false,
              width: 'auto',
              buttons: {
                  ok: function () {

                  }
              }
          });
      }
      //Success
      function ShowSuccessWindow(Message) {
          $.confirm({
              columnClass: 'meduim',
              icon: 'fa fa-check',
              title: 'Message from eTDS',
              content: Message,
              type: 'green',
              useBootstrap: false,
              width: 'auto',
              buttons: {
                  ok: function () {

                  }
              }
          });
      }
      //Message
      function ShowInfoWindow(Message) {
          $.confirm({
              columnClass: 'medium',
              width: 'auto',
              icon: 'fa fa-commenting',
              title: 'Message from eTDS',
              content: Message,
              type: 'blue',
              useBootstrap: false,
              width: 'auto',
              buttons: {
                  ok: function () {

                  }
              }
          });
      }
      //Warning
      function ShowWarningWindow(Message) {
          $.confirm({
              columnClass: 'medium',
              icon: 'fa fa-warning',
              title: 'Error',
              content: Message,
              type: 'orange',
              useBootstrap: false,
              width: 'auto',
              buttons: {
                  ok: function () {

                  }
              }
          });
      }
    </script>

    <style type="text/css">
        .Pager b {
            margin-top: 2px;
            margin-left: 5px;
            float: left;
            padding-right: 40%;
            padding-top: 8px;
            width: 60%;
            text-align: center !important;
        }

        .Pager span {
            background-color: #26A69A;
            z-index: 1;
            color: #fff;
            border-color: #26a69a;
            /*/*position: relative;*/ */ overflow: hidden;
            text-align: center;
            min-width: 2.8rem;
            transition: all ease-in-out .15s;
            /*display: block;*/
            padding: .5rem 1rem;
            line-height: 1.5385;
            border-radius: 10rem;
            margin-right: 3px;
            text-align: center !important;
        }

        .Pager a {
            background-color: #eee;
            z-index: 1;
            color: black;
            border-color: #26a69a;
            position: relative;
            overflow: hidden;
            text-align: center;
            min-width: 2.8rem;
            transition: all ease-in-out .15s;
            /*display: block;*/
            padding: .5rem 1rem;
            line-height: 1.5385;
            border-radius: 10rem;
            margin-right: 3px;
            text-align: center !important;
        }

        .Pager {
            margin-bottom: 0;
            border-color: #fff;
            margin-left: 2px;
            /*border-radius: 0.1875rem;*/
            display: flex;
            padding-left: 0;
            height: 40px;
            text-align: center !important;
        }

        .ShowPage {
            float: right;
            display: inline-block;
            margin: 0 0 0 1.25rem;
            width: 70px;
        }

        .Chkbox {
            height: 20px;
            width: 20px;
            margin-right: 5px;
        }

        .Spancount {
            height: 20px;
            width: 50px;
            font-size: 12px;
            font-weight: bold;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:HiddenField ID="hdnValid" runat="server" />
    <asp:HiddenField ID="hdnCompanyID" runat="server" />
    <asp:HiddenField ID="hdnQuater" runat="server" />
    <asp:HiddenField ID="hdnForm" runat="server" />    
    <asp:HiddenField ID="hdnDate" runat="server" />
    <asp:HiddenField ID="hdnPages" runat="server" />
    <asp:HiddenField ID="hdnSize" runat="server" />    

    <asp:UpdatePanel runat="server" ID="UpdatePanel2">
        <ContentTemplate>
            <table id="Table1" runat="server" width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="cssPageTitle">
                        <asp:Label ID="Label1" runat="server" Font-Bold="true" Text="Non Salary Pan Verification"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table style="width:100%;">
                            <tr>
                                <td id="tdfrm" name="tdfrm" runat="server" style="width:10%;">
                                    <asp:Label ID="Label3" runat="server">Form : </asp:Label>
                                    <asp:DropDownList ID="ddlFromType" CssClass="cssDropDownList" runat="server" Width="60px">
                                        <asp:ListItem Selected="True" Value="0" Text=" ( Select From Type ) "></asp:ListItem>
                                        <asp:ListItem Text="26Q"></asp:ListItem>
                                        <asp:ListItem Text="27Q"></asp:ListItem>
                                        <asp:ListItem Text="27EQ"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="ddlFromType"
                                        InitialValue="0" ValidationGroup="ValidateThisEreturns" Display="None" runat="server"
                                        ErrorMessage="Please Select FromType !"></asp:RequiredFieldValidator>
                                </td>
                                <td id="tdQrtr" name="tdQrtr" runat="server" style="width:10%;">
                                    <asp:Label ID="Label2" runat="server">Qtr : </asp:Label>
                                    <asp:DropDownList ID="ddlQuater" CssClass="cssDropDownList" runat="server" Width="60px">
                                        <asp:ListItem Selected="True" Value="0" Text=" ( select Quater )" />
                                        <asp:ListItem Text="Q1" />
                                        <asp:ListItem Text="Q2" />
                                        <asp:ListItem Text="Q3" />
                                        <asp:ListItem Text="Q4" />
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="ddlQuater"
                                        InitialValue="0" ValidationGroup="ValidateThisEreturns" Display="None" runat="server"
                                        ErrorMessage="Please Select Quater !"></asp:RequiredFieldValidator>
                                </td>

                                 <td style="width:12%;">
                                    <select id="ddlstatus" runat="server"  class="form-control form-control-border select-search" >
                                        <option value="All">All PAN</option>
                                        <option value="Valid">Valid & Operative PAN</option>
                                        <option  value="Inoperative">Valid & Inoperative PAN</option>
                                        <option  value="Invalid">Invalid</option>
                                        <option  value="Non">Non Verified</option>
                                    </select>

                                </td>      
                                <td>
                                    <input type="button" id="PnvVerfy" name="PnvVerfy" value="Traces PAN Verify" class="cssButton"  />
                                </td>

                                <td id="tblrslt">
                                    <table border="1" style="border: 1px solid #dbdbdb; border-width: thin; border-collapse: collapse;" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td  style="font-size:14px; font-weight:bold; ">Valid & Operative Pan</td>
                                            <td  style="font-size:14px; font-weight:bold;">Valid & Inoperative</td>
                                            <td  style="font-size:14px; font-weight:bold;" runat="server">Not Verified</td>
                                        </tr>
                                        <tr>
                                            <td><label id="lblLK" runat="server" style="font-size:14px; font-weight:bold; color:green; text-align:center" >0</label></td>
                                            <td><label id="lblNL"  runat="server" style="font-size:14px; font-weight:bold; color:red; cursor:grab; text-align:center" onclick='getPANList("Invalid")' >0</label></td>
                                            <td><label id='lblNV' runat="server"  style='font-size:14px; font-weight:bold; color:orange; text-align:center' onclick='BRedirect($(this).val())' >0</label></td>
                                        </tr>

                                    </table>
                                </td>
                            </tr>
                         </table>
                    </td>
                </tr>

                <tr>
                    <td runat="server" id="tdSearch" style="padding:10px;">
                        <center>
                            <asp:Label ID="lbldgVoucherModify" runat="server"></asp:Label>
                            <table id="tblPANLnk"></table>
                            <table id="tblPager" style="border: 1px solid #BCBCBC; height: 50px; width: 100%">
                                <tr>
                                    <td>
                                        <div class="Pager">
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </center>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>

   <asp:Button Style="display: none" ID="hideModalPopupViaClientOrginal" runat="server"></asp:Button><br />
    <cc1:ModalPopupExtender BackgroundCssClass="modalBackground" BehaviorID="programmaticModalPopupOrginalBehavior"
        RepositionMode="RepositionOnWindowScroll" DropShadow="False" ID="ModalPopupExtender2"
        TargetControlID="hideModalPopupViaClientOrginal" CancelControlID="imgBudgetdClose"
        PopupControlID="panel10" runat="server">
    </cc1:ModalPopupExtender>

    <asp:Panel ID="panel10" runat="server" Width="700px" Height="390px" BackColor="#FFFFFF">
        <div id="Div1" style="width: 100%; float: left; background-color: #55A0FF; color: #ffffff; font-weight: bold;">
            <div id="Div2" style="width: 90%; float: left; height: 20px; padding-left: 2%; padding-top: 1%">
                <asp:Label ID="lblpopup" runat="server" Font-Size="Larger" CssClass="subHead1 labelChange" Text=""></asp:Label>
            </div>
            <div id="Div3" class="ModalCloseButton">
                <img alt="" src="../images/error.png" id="imgBudgetdClose" border="0" name="imgClose"
                    onclick="return HideModalPopup()" />
            </div>
        </div>
        <div style="padding: 5px 5px 5px 5px; height:355px;" id="addtasks" runat="server" class="comprw">
            <div id="divJb" class="divedBlock" style="padding-top: 10px;height: 295px;">

                <div style="overflow: hidden; width: 680px; height: 290px; float: left; padding-left: 5px;">
                    <img alt="" src="../BTStrp/image/tds-logo.png" id="imgTraces" border="0" name="imgTraces"  />
                    <asp:Panel ID="pnljb" runat="server"  Height="290px" Width="680px">
                    <table width="100%" >
                        <tr>
                            <td valign="top" width="100%">

                                <div class="gridloader">
                                </div>
                                <table width="60%" id="tblTracesLogin">
                                    <tr>
                                        <td colspan="6">
                                            <span id="lblUserDetails" class="lblHeader" style="font-weight: 700;">Enter Traces Login Details</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border: 2px;">TAN : <span class="req">*</span>
                                        </td>
                                        <td>
                                            <input id="txtTan" class="cssTextbox" type="text" style="width: 120px;" value=""  autocomplete="none"  />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border: 2px;"> User ID : <span class="req">*</span>
                                        </td>
                                        <td>
                                            <input id="txtUserID" class="cssTextbox" style="width: 120px;" type="text" value=""  autocomplete="nope" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border: 2px;">Password : <span class="req">*</span>
                                        </td>
                                        <td>
                                            <input id="txtPassword" class="cssTextbox" style="width: 120px;" type="password" value="" />
                                        </td>

                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>
                                            <input type="submit" name="btnSaveRequest" value="Save" id="btnSaveRequest" class="cssButton" onclick="return SaveTracesDetails();" /></td>
                                    </tr>
                                </table>



                            </td>
                        </tr>
                    </table>
                        <table id="tblver" name="tblver" >

                            <tr id="trAuto1" name="trAuto1">
                                <td style="text-align:right;">
                                    <img id="captchaImg" class="captchaimg1" alt="Captcha" src="" /></td>
                                <td>
                                    <img id="imgRsh" src="../Images/refresh.png" style="width: 20px; padding-right: 10px; cursor: pointer;"  />
                                    <label style="font-weight: bold;">Click to refresh image</label>

                                </td>
                            </tr>
                            <tr style="height:15px;" >
                                <td>
                                    <label id="lblProcess" style="padding-right:20px;font-size:18px;  font-weight:bold; color:red;  border :none ;">Verifing PAN, Please wait .......</label>
                                </td>
                            </tr>
                            <tr id="trAuto2" name="trAuto2" >
                                <td style="text-align:left;">
                                   <input autocomplete="off" id="captcha" class="frmtxtbox" maxlength="5"  style="width:100px; " value="" />
                                </td>
                                <td style="font-weight: bold;font-size:14px; text-align:right;">Enter text as in above image</td>

                             </tr>
                            <tr style="height:15px;" >
                                <td>
                                    <label id="lblSuccess" style="padding-right:20px;font-size:18px; font-weight:bold; border:none ; color:green; ">PAN Verified Success</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="submit" name="btnGetRequest" value="Request" id="btnGetRequest" class="cssButton" onclick="return RequestTrace();" />
                                </td>
                                <td>
                                    <asp:Button ID="Button1" Text="Cancel" runat="server" CssClass="cssButton" OnClientClick="return HideModalPopup()"  />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">

                                    <div style="width: 100%; margin: auto; padding-left:15px;" id="divData">
                                       
                                    </div>

                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </asp:Panel>
</asp:Content>
