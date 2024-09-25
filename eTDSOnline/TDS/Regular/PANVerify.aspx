<%@ Page Title="" Language="C#" MasterPageFile="~/TDS/BTS_MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="PANVerify.aspx.cs" Inherits="Admin_PANVerify" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%--<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>--%>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="Server">

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
    <script type="text/javascript" src="../BTStrp/js/common.js"></script>
    <script type="text/javascript" src="../BTStrp/js/PANVerify.js"></script>
    <script type="text/javascript" src="../BTStrp/js/jquery-confirm.min.js"></script>
    <%--<link href="../css/jquery-confirm.min.css" rel="stylesheet" />
    <link href="../css/common.css" rel="stylesheet" />--%>

    <style type="text/css">
        #divData th, #divData td {
            border: 1px solid #d3d3d3;
        }
    </style>
    <script type="text/javascript" language="javascript">
        var PanVrf = '';
        var BulkPAN = '';
        $(document).ready(function () {
            var P = $("[id*=hdnPAN]").val();
            $("[id*=txtPAN]").val(P);
        });
    </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:HiddenField ID="hdnPAN" runat="server" />
    <asp:HiddenField ID="hdnDid" runat="server" />
    <table width="100%" style="margin-bottom: 0px;" cellpadding="0" cellspacing="0">
        <tr>
            <td class="cssPageTitle" height="5px">
                <asp:Label ID="lblHeader" runat="server" Text="PAN Verification"></asp:Label>

            </td>
        </tr>
        <tr>
            <td>
                <div style="width: 99%; padding-right: 2px; padding-left: 2px">
                    <%-- <UC:MessageControl runat="server" ID="ucMessageControl" />--%>
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
                <fieldset style="background-color: White; margin-top: 0px; margin-bottom: 0px; padding: 5px;">
                    <legend>&nbsp;&nbsp;Trace Details&nbsp;&nbsp;</legend>
                    <table width="100%">
                        <tr>
                            <td valign="top" width="100%">

                                <div class="gridloader">
                                </div>
                                <table width="60%">
                                    <tr style="display: none;">
                                        <td colspan="6">
                                            <span id="lblUserDetails" class="lblHeader" style="font-weight: 700;">Enter User Details</span>
                                        </td>
                                    </tr>
                                    <tr style="display: none;">
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

                                    </tr>
                                    <tr style="display: none;">
                                        <td colspan="6">&nbsp;&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="6">
                                            <span id="lblReturn" class="lblHeader" style="font-weight: 700;">PAN Details</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;&nbsp;&nbsp;&nbsp; PAN No <span class="req">*</span>
                                        </td>
                                        <td>
                                            <input id="txtPAN" class="cssTextbox" style="width: 120px;" type="text" value="" required="true" />
                                        </td>
                                        <td colspan="4"></td>

                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
        <tr>
            <td valign="top" width="100%" colspan="2">
                <table style="width: 50%; display: none;" id="tblCaptcha">
                    <tr>
                        <td>
                            <img id="captchaImg" class="captchaimg1" alt="Captcha" src="" />
                            <a href="#/" onclick="getCaptcha();" class="refreshimg" title="Refresh image"></a>&nbsp; &nbsp; &nbsp;<br />
                            <label>Enter text as in above image</label>&nbsp;&nbsp; <span class="req">*</span><br />
                            <input autocomplete="off" id="captcha" class="frmtxtbox" maxlength="5" required="true" value="" />

                        </td>
                        <td>
                            <input type="submit" name="btnGetRequest" value="Request" id="btnGetRequest" class="cssButton" onclick="return RequestTrace();" />
                            &nbsp;&nbsp;
                        </td>
                        <td></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2">

                <div style="width: 100%; margin: auto; padding: 15px; border: 1px solid #0003; background-color: #d3d3d363;" id="divData">
                </div>

            </td>
        </tr>
    </table>

    <asp:HiddenField ID="hdnCompanyid" runat="server" />
</asp:Content>

