<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="TracesDownloadReport.aspx.cs" Inherits="Admin_TracesDownloadReport" %>

<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">

    <script type="text/javascript" src="../customScript/jquery-confirm.min.js"></script>
    <script type="text/javascript" src="../customScript/Download_Traces_Rpt.js"></script>
    
    <script type="text/javascript" src="../customScript/common.js"></script>
    <%--Jquery Confirm--%>
    <link href="../css/jquery-confirm.min.css" rel="stylesheet" />
    <link href="../css/common.css" rel="stylesheet" />
    
    

    <table width="100%" style="margin-bottom: 0px;" cellpadding="0" cellspacing="0">
        <tr>
            <td class="cssPageTitle" height="5px">
                <asp:Label ID="lblHeader" runat="server" Text="Justification Report Download"></asp:Label>

            </td>
        </tr>
        <tr>
            <td valign="top">
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
    <table width="100%" style=" min-height: 450px;">
        <tr>
            <td valign="top" width="100%">

                <div class="gridloader">
                </div>
                <table width="60%">
                    <tr>
                        <td colspan="3">
                            <span id="lblUserDetails" class="lblHeader" style="font-weight: 700;">Enter User Details</span>
                        </td>
                    </tr>
                    <tr>
                        <td style="border: 2px;">TAN : <span class="req">*</span>
                        </td>
                        <td>
                            <input  autocomplete="off" id="txtTan" class="cssTextbox" type="text" style="width: 200px;" value="" required="true" />
                        </td>
                    </tr>
                    <tr>
                        <td>User ID : <span class="req">*</span>
                        </td>
                        <td>
                            <input  autocomplete="off" id="txtUserID" class="cssTextbox" style="width: 200px;" type="text" value="" required="true" />
                        </td>
                    </tr>
                    <tr>
                        <td>Password : <span class="req">*</span>
                        </td>
                        <td>
                            <input  autocomplete="off" id="txtPassword" class="cssTextbox" style="width: 200px;" type="password" value="" required="true" />
                        </td>

                    </tr>
                    <tr id="tblCaptcha" style="display: none;">
                        <td>Verification Code : <span class="req">*</span>
                        </td>
                        <td>
                            <img id="captchaImg" class="captchaimg1" alt="Captcha" />
                            <a href="#" onclick="getCaptcha();" class="refreshimg" title="Refresh image"></a>&nbsp; &nbsp; &nbsp;
                                <span class="captchaLabel">Click to refresh image</span><br />
                            <label>Enter text as in above image</label><span class="mandatory">*</span><br />
                            <input autocomplete="off" id="captcha" maxlength="5" required="true" class="cssTextbox" />
                        </td>

                    </tr>

                    <tr>
                        <td></td>
                        <td>
                            <input type="submit" name="btnGetRequest" value="Request" id="btnGetRequest" class="cssButton" onclick="return RequestDownloads();" /></td>
                    </tr>

                </table>



            </td>
        </tr>
        <tr>
            <td>
                <div style="width: 100%; margin: auto;" id="divData">
                </div>
            </td>
        </tr>
    </table>
    
</asp:Content>

