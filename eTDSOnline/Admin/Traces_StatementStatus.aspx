<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="Traces_StatementStatus.aspx.cs" Inherits="Admin_StatementStatus" %>
<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
   
     <table width="100%" style="margin-bottom: 0px;" cellpadding="0" cellspacing="0">
        <tr>
            <td class="cssPageTitle" height="5px">
                <label id= "lblHeader">Statement Status</label>

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
                <table width="100%" style="border:1px solid #dcdcdc;">
                    <tr>
                                        <td style="display:none;" >FA Year : <span class="req">*</span>
                                        </td>
                                        <td style="display:none;">

                                            <select id="ddlFAYear" style="width: 120px" class="cssDropDownList"  required="true">
                                            </select>
                                        </td>
                                        <td  style="width:130px;">&nbsp;&nbsp;&nbsp;&nbsp; Form No <span class="req">*</span>
                                        </td>
                                        <td  style="width:130px;">
                                            <select id="ddlForm" style="width: 120px" class="cssDropDownList" required="true" onchange="showcaptcha();" >
                                                <option></option>

                                            </select>
                                        </td>
                                        <td style="width:130px;">&nbsp; Quarter <span class="req">*</span>
                                        </td>
                                        <td style="width:110px;">
                                            <select id="ddlQuarter" style="width: 120px" class="cssDropDownList" required="true" >
                                                <option></option>
                                                <option value="3">Q1</option>
                                                <option value="4">Q2</option>
                                                <option value="5">Q3</option>
                                                <option value="6">Q4</option>
                                            </select>
                                        </td>
                       
                        <td valign="top" >
                          <table id="tblCaptcha" style="display:none;" >
                                    <tr>
                                        <td>
                                            <img id="captchaImg" class="captchaimg1" alt="Captcha" />
                                            <a href="#/" onclick="getCaptcha();" class="refreshimg" title="Refresh image"></a>&nbsp; &nbsp; &nbsp;<br />
                                            <label>Enter text as in above image</label>&nbsp;&nbsp; <span class="req">*</span><br />
                                            <input autocomplete="off" id="captcha" class="frmtxtbox" maxlength="5" required="true" value="" />

                                        </td>
                                        <td>
                                             <input type="submit" name="btnGetRequest" value="View Statement Status" id="btnGetRequest" class="cssButton" onclick="return RequestStatementStatus();" />
                                            &nbsp;&nbsp;
                                        </td>
                                        <td>
                                           

                                        </td>
                                    </tr>
                                </table>
                        </td>
                                    </tr>
                
                    

                </table>

            </td>
        </tr>
        <tr>
            <td style="vertical-align:top;">
                <div style="width: 100%; margin: auto;padding-top:20px;" id="divData">
                </div>
            </td>
        </tr>
            <tr> <td style="min-height:150px;"> </td>
                                    </tr>
    </table>
    <input type="text" style="display:none" id="txttraceuserid" />
    <input type="text" style="display:none" id="txttracepwd" />
        
    <%--Jquery Confirm--%>
    <link href="../css/jquery-confirm.min.css" rel="stylesheet" />
    <link href="../css/common.css" rel="stylesheet" />

    <!--JS File -->
        <script type="text/javascript" src="../customScript/jquery-confirm.min.js"></script>
    <script type="text/javascript" src="../customScript/common.js"></script>
    <script type="text/javascript" src="../customScript/StatementStatus.js"></script>
    
    
    </asp:Content>

