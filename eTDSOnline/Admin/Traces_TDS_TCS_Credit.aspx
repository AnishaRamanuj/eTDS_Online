<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="Traces_TDS_TCS_Credit.aspx.cs" Inherits="Admin_Traces_TDS_TCS_Credit" %>

<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">

    <table width="100%" style="margin-bottom: 0px;" cellpadding="0" cellspacing="0">
        <tr>
            <td class="cssPageTitle" height="5px">
                <label id="lblHeader">View Deduction Details for Deductee </label>

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
    <table width="100%">
        <tr>
            <td valign="top" width="100%">

                <div class="gridloader">
                </div>
                <table width="100%" style="border: 1px solid #dcdcdc;">
                    <tr>
                        <td style="display: none;">FA Year : <span class="req">*</span>
                        </td>
                        <td style="display: none;">

                            <select id="ddlFAYear" style="width: 120px" class="cssDropDownList" required="true">
                            </select>
                        </td>
                        <td style="width: 130px;">&nbsp;&nbsp;&nbsp;&nbsp; Form No <span class="req">*</span>
                        </td>
                        <td style="width: 130px;">
                            <select id="ddlForm" style="width: 120px" class="cssDropDownList" required="true" onchange="getparam();">
                                <option></option>

                            </select>
                        </td>
                        <td style="width: 130px;">&nbsp; Quarter <span class="req">*</span>
                        </td>
                        <td style="width: 110px;">
                            <select id="ddlQuarter" style="width: 120px" class="cssDropDownList" required="true" onchange="getparam();">
                                <option></option>
                                <option value="3">Q1</option>
                                <option value="4">Q2</option>
                                <option value="5">Q3</option>
                                <option value="6">Q4</option>
                            </select>
                        </td>
                        <td style="width: 130px;">&nbsp; PAN <span class="req">*</span>
                        </td>
                        <td style="width: 110px;">
                            <select id="ddlPAN" style="width: 120px" class="cssDropDownList" required="true">
                                <option></option>
                            </select>
                        </td>

                        <td valign="top">&nbsp;&nbsp;
                            <table id="tblCaptcha" style="display: none;">
                                <tr>
                                    <td>
                                        <img id="captchaImg" class="captchaimg1" alt="Captcha" />
                                        <a href="#/" onclick="getCaptcha();" class="refreshimg" title="Refresh image"></a>&nbsp; &nbsp; &nbsp;<br />
                                        <label>Enter text as in above image</label>&nbsp;&nbsp; <span class="req">*</span><br />
                                        <input autocomplete="off" id="captcha" class="frmtxtbox" maxlength="5" required="true" value="" style="text-transform: uppercase;" />

                                    </td>
                                    <td></td>
                                    <td>
                                        <input type="submit" name="btnGetRequest" value="GO" id="btnGetRequest" class="cssButton" onclick="return RequestTDSStatus();" /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>



                </table>

            </td>
        </tr>
        <tr>
            <td style="vertical-align: top;">
                <div style="width: 100%; margin: auto; padding-top: 20px;" id="divStatementDtls">
                </div>
                <%-- <div style="width: 100%; margin: auto;padding-top:20px;" id="divDeducteeDtls">
                </div>--%>

                <div id="dedDetail">
                    <table class="userList w990" id="dedPAN" style="display:none;">
                        <tbody>
                            <tr>
                                <th class="w195 whiteFont leftAlign">PAN</th>
                                <td class="even width340"><span id="DedDetail_pan"></span></td>
                                <th class="w195 whiteFont leftAlign">Name of Deductee</th>
                                <td class="even"><span id="DedDetail_DedName"></span></td>
                            </tr>
                        </tbody>
                    </table>
                    <table id="dedDetailTab"></table>
                    <div id="pagernav"></div>
                </div>
            </td>
        </tr>
        <tr>
            <td style="min-height: 150px;"></td>
        </tr>
    </table>
    <input type="text" style="display: none" id="txttraceuserid" />
    <input type="text" style="display: none" id="txttracepwd" />

    <%--Jquery Confirm--%>
    <link href="../css/jquery-confirm.min.css" rel="stylesheet" />
    <link href="../css/common.css" rel="stylesheet" />
    <link href="../css/ui.jqgrid.css" rel="stylesheet" />


    <!--JS File -->
    <script type="text/javascript" src="../customScript/jquery-confirm.min.js"></script>
    <script type="text/javascript" src="../customScript/common.js"></script>
    <script type="text/javascript" src="../customScript/TDSTCSCredit.js"></script>

    <script type="text/javascript" src="../Scripts/jqgrid.min1.js"></script>
    <style type="text/css">
       .ui-jqgrid .ui-jqgrid-htable th div {
    height: auto;
    overflow: hidden;
    padding-right: 4px;
    padding-top: 2px;
    position: relative;
    vertical-align: text-top;
    white-space: normal !important;
}
    </style>
</asp:Content>

