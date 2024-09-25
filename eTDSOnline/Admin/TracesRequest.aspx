<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="TracesRequest.aspx.cs" Inherits="Admin_TracesRequest" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">

    <script type="text/javascript" src="../customScript/common.js"></script>
    <script type="text/javascript" src="../customScript/traceRequest.js"></script>
    <script type="text/javascript" src="../customScript/jquery-confirm.min.js"></script>
    <%--Jquery Confirm--%>
    <link href="../css/jquery-confirm.min.css" rel="stylesheet" />
    <link href="../css/common.css" rel="stylesheet" />
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
                            $("[id*=hdnUserid]").val(myList[0].Userid);
                            $("[id*=hdnPassword]").val(myList[0].Password);
                        } else {
                            ShowWarningWindow('Enter Traces Login Details!!!');
                            window.location = ('TracesDetails.aspx');
                        }


                    },
                    failure: function (response) {

                    },
                    error: function (response) {

                    }
                });
            }


            </script>
        <asp:HiddenField runat="server" ID="hdnCompid"/>
        <asp:HiddenField runat="server" ID="hdnUserid"/>
        <asp:HiddenField runat="server" ID="hdnPassword"/>
        <asp:HiddenField runat="server" ID="hdnFY" />
    <table width="100%" style="margin-bottom: 0px;" cellpadding="0" cellspacing="0">
        <tr>
            <td class="cssPageTitle" height="5px">
                <asp:Label ID="lblHeader" runat="server" Text="Request for TDS / Conso file Online" ></asp:Label>
           

                    </td>
        </tr>
        <tr>
            <td>
                <div style="width: 99%; padding-right: 2px; padding-left: 2px">
                    <UC:MessageControl runat="server" ID="ucMessageControl" />
                    <div class="tdMessageShow" style="border: 1px solid; margin-top: 3px; display: none; font: Tahoma; font-size: 13px; text-transform: capitalize;">
                        <table width="100%" align="center" style="height: 30px;" cellpadding="5" cellspacing="5">
                            <tr>
                                <td>
                                    <asp:Label ID="lblAllMessage" Font-Bold="true" runat="server" Text="Label"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
    </table>
    <table width="100%">
        <tr>
            <td valign="top" width="100%" colspan="2">
              
                  
                    <table width="100%">
                        <tr>
                            <td valign="top" width="100%">

                                <div class="gridloader">
                                </div>
                                <table width="60%">
                             
                                 <%--   <tr>
                                        <td style="border: 2px;">TAN : <span class="req">*</span>
                                        </td>
                                        <td>
                                            <input id="txtTan" class="cssTextbox" type="text" style="width: 120px;" value="" required="true" autocomplete="none" />
                                        </td>
                                        <td>&nbsp;&nbsp;&nbsp;&nbsp; User ID : <span class="req">*</span>
                                        </td>
                                        <td>
                                            <input id="txtUserID" class="cssTextbox" style="width: 120px;" type="text" value="" required="true" autocomplete="nope" />
                                        </td>
                                        <td>&nbsp; Password : <span class="req">*</span>
                                        </td>
                                        <td>
                                            <input id="txtPassword" class="cssTextbox" style="width: 120px;" type="password" value="" required="true" />
                                        </td>

                                    </tr>--%>
                        
                                    <tr>
                                        <td style="display:none;">FA Year : <span class="req">*</span>
                                        </td>
                                        <td style="display:none;">

                                            <select id="ddlFAYear" style="width: 120px" class="cssDropDownList" onchange="getChallan()" required="true">
                                            </select>
                                        </td>
                                        <td>&nbsp;&nbsp;&nbsp;&nbsp; Form No <span class="req">*</span>
                                        </td>
                                        <td>
                                            <select id="ddlForm" style="width: 120px" class="cssDropDownList" required="true" onchange="getChallan()">
                                                <option></option>

                                            </select>
                                        </td>
                                        <td>&nbsp; Quarter <span class="req">*</span>
                                        </td>
                                        <td>
                                            <select id="ddlQuarter" style="width: 120px" class="cssDropDownList" required="true" onchange="getChallan()">
                                                <option></option>
                                                <option value="3">Q1</option>
                                                <option value="4">Q2</option>
                                                <option value="5">Q3</option>
                                                <option value="6">Q4</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="display:none;"></td>
                                        <td style="display:none;"></td>
                                        <td>&nbsp;&nbsp;&nbsp;&nbsp; Challan <span class="req">*</span></td>
                                        <td colspan="3">
                                            <select id="ddlChallan" style="width: 400px" class="cssDropDownList" required="true" onchange="getparam()">
                                                <option></option>
                                            </select>
                                        </td>
                                    </tr>
                                </table>


                            </td>
                        </tr>
                    </table>
            
            </td>
        </tr>
        <tr>
            <td valign="top" width="100%" colspan="2">
                <fieldset style="background-color: White; margin-top: 0px; margin-bottom: 0px; padding-bottom: 0px; padding-top: 0px;">
                    <legend>&nbsp;&nbsp;Challan Details&nbsp;&nbsp;</legend>
                    <table width="100%">
                        <tr>
                            <td valign="top" width="100%" colspan="2">


                                <table width="70%">
                                    <tr>
                                        <td>
                                            <span class="lblHeader">Token Number /<br />
                                                Provisional Receipt Number (PRN)  <span class="req">*</span></span>
                                        </td>


                                        <td>
                                            <input id="txtPRN_No" class="cssTextbox" type="text" style="width: 120px;" value="" required="true" />
                                        </td>

                                        <td>
                                            <label>
                                                <input type="checkbox" id="chkNIlChallan" />
                                                NIlChallan
                                            </label>
                                        </td>
                                        <td>
                                            <label>
                                                <input type="checkbox" id="chkBookAdjustment" />
                                                BookAdjustment
                                            </label>
                                        </td>
                                        <td>
                                            <label>
                                                <input type="checkbox" id="chkNoValidPAN" />
                                                NoValidPAN
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <fieldset style="background-color: White; margin-top: 0px; margin-bottom: 0px; padding: 5px;">
                                    <legend>&nbsp;&nbsp;Provide any one challan information of that return&nbsp;&nbsp;</legend>
                                    <table style="width: 100%" cellpadding="3" cellspacing="0">
                                        <tr>
                                            <td style="background: #f2f2f2;">CD Record Number : </td>
                                            <td>
                                                <input id="txtSerialNo" class="cssTextbox" type="text" style="width: 250px;" /></td>
                                        </tr>
                                        <tr>
                                            <td style="background: #f2f2f2;">Challan Serial No./ DDO  :  <span class="req">*</span></td>
                                            <td>
                                                <input id="txtChallanNo" class="cssTextbox" type="text" style="width: 250px;" required="true" /></td>
                                        </tr>
                                        <tr>
                                            <td style="background: #f2f2f2;">BSR Code / Receipt No. : <span class="req">*</span> </td>
                                            <td>
                                                <input id="txtBSRCode" class="cssTextbox" type="text" style="width: 250px;" required="true" /></td>
                                        </tr>
                                        <tr>
                                            <td style="background: #f2f2f2;">Date of Tax Deposited : <span class="req">*</span> </td>
                                            <td>
                                                <asp:TextBox ID="txtDateOfDeposit" Width="250px" CssClass="cssTextbox" runat="server" required="true"></asp:TextBox>
                                                <asp:ImageButton ID="ImageButton2" ImageUrl="~/Images/calendar.gif" runat="server"
                                                    CausesValidation="false" />
                                                <asp:CalendarExtender ID="CalendarExtender3" runat="server" PopupButtonID="ImageButton2"
                                                    TargetControlID="txtDateOfDeposit" Format="dd/MMM/yyyy">
                                                </asp:CalendarExtender>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="background: #f2f2f2;">Challan Amount /
                                                <br />
                                                Transfer Voucher : <span class="req">*</span> </td>
                                            <td>
                                                <input id="txtTaxDeposit" class="cssTextbox" type="text" style="width: 250px;" required="true" /></td>
                                        </tr>
                                    </table>
                                </fieldset>

                            </td>
                            <td valign="top">
                                <fieldset style="background-color: White; margin-top: 0px; margin-bottom: 0px; padding: 5px; height: 195px;">
                                    <legend>&nbsp;&nbsp;Provide any three Deductee record's PAN and it's Tax Deudcted&nbsp;&nbsp;</legend>
                                    <table style="width: 100%" cellpadding="5">
                                        <tr>
                                            <td>Sl. No.</td>
                                            <td>Deductee PAN</td>
                                            <td>TDS Deducted</td>

                                        </tr>
                                        <tr>
                                            <td>1</td>
                                            <td>
                                                <%--<input id="txtPAN1" class="cssTextbox" type="text" style="width: 250px;" />--%>
                                                <select id="ddlPAN1" style="width: 250px" class="cssDropDownList" required="true" onchange="getTDSAmt(1)">
                                                    <option></option>
                                                </select>
                                            </td>
                                            <td>
                                                <input id="txtAmount1" class="cssTextbox" type="text" style="width: 250px;" /></td>
                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td>
                                                <%--<input id="txtPAN2" class="cssTextbox" type="text" style="width: 250px;" />--%>
                                                <select id="ddlPAN2" style="width: 250px" class="cssDropDownList" required="true" onchange="getTDSAmt(2)">
                                                    <option></option>
                                                </select>
                                            </td>
                                            <td>
                                                <input id="txtAmount2" class="cssTextbox" type="text" style="width: 250px;" /></td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td>
                                                <%--<input id="txtPAN3" class="cssTextbox" type="text" style="width: 250px;" />--%>
                                                <select id="ddlPAN3" style="width: 250px" class="cssDropDownList" required="true" onchange="getTDSAmt(3)">
                                                    <option></option>
                                                </select>
                                            </td>
                                            <td>
                                                <input id="txtAmount3" class="cssTextbox" type="text" style="width: 250px;" /></td>
                                        </tr>

                                    </table>
                                </fieldset>

                            </td>

                        </tr>
                        <tr>
                            <td>
                                <fieldset style="background-color: White; margin-top: 0px; margin-bottom: 0px; padding: 5px;">
                                    <legend>&nbsp;&nbsp;ADDITIONAL REQUEST&nbsp;&nbsp;</legend>
                                    <table style="width: 50%;">
                                        <tr>
                                            <td id="tdConsoFile" style="display: none;">
                                                <label>
                                                    <input type="checkbox" id="chkConsoFile" />
                                                    Conso File
                                                </label>
                                            </td>
                                            <td id="tdAddlJustification" style="display: none;">
                                                <label>
                                                    <input type="checkbox" id="chkAddlJustification" />
                                                    Justification Report
                                                </label>
                                            </td>
                                            <td id="tdAddlForm16A" style="display: none;">
                                                <label>
                                                    <input type="checkbox" id="chkAddlForm16A" />
                                                    Form 16A
                                                </label>
                                            </td>
                                            <td id="tdAddlForm16PartA" style="display: none;">
                                                <label>
                                                    <input type="checkbox" id="chkAddlForm16PartA" />
                                                    Form 16 - PartA
                                
                                                </label>
                                            </td>
                                            <td id="tdAddlForm27D" style="display: none;">
                                                <label>
                                                    <input type="checkbox" id="chkAddlForm27D" />
                                                    Form 27D
                                
                                                </label>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </td>
                            <td>

                                <table style="width: 50%; display: none;" id="tblCaptcha">
                                    <tr>
                                        <td>
                                            <img id="captchaImg" class="captchaimg1" alt="Captcha" />
                                            <a href="#/" onclick="getCaptcha();" class="refreshimg" title="Refresh image"></a>&nbsp; &nbsp; &nbsp;<br />
                                            <label>Enter text as in above image</label>&nbsp;&nbsp; <span class="req">*</span><br />
                                            <input autocomplete="off" id="captcha" class="frmtxtbox" maxlength="5" required="true" value="" />

                                        </td>
                                        <td>
                                             <input type="submit" name="btnGetRequest" value="Request" id="btnGetRequest" class="cssButton" onclick="return RequestTrace();" />
                                            &nbsp;&nbsp;
                                        </td>
                                        <td>
                                           

                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
    </table>
   
    <%--<asp:HiddenField ID="hdnCompanyid" runat="server" />--%>
</asp:Content>

