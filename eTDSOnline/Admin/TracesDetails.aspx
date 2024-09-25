<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="TracesDetails.aspx.cs" Inherits="Admin_TracesDetails" %>

<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">

    <script type="text/javascript" src="../customScript/jquery-confirm.min.js"></script>
    <script type="text/javascript" src="../customScript/Download_Traces_Rpt.js"></script>    
    <script type="text/javascript" src="../customScript/common.js"></script>
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
                            $("[id*=txtUserID]").val(myList[0].Userid);
                            $("[id*=txtPassword]").val(myList[0].Password);
                        } else {
                            ShowWarningWindow('Enter Traces Login Details!!!');
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
    <table width="100%" style="margin-bottom: 0px;" cellpadding="0" cellspacing="0">
        <tr>
            <td class="cssPageTitle" height="5px">
                <asp:Label ID="lblHeader" runat="server" Text="Traces UserID/Password Details"></asp:Label>

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
                        <td style="width:100px;" class="cssGrdAlterItemStyle">User ID : <span class="req">*</span>
                        </td>
                        <td>
                            <input  autocomplete="off" id="txtUserID" class="cssTextbox" style="width: 200px;" type="text" value="" required="true" />
                        </td>
                    </tr>
                    <tr>
                        <td class="">Password : <span class="req">*</span>
                        </td>
                        <td>
                            <input  autocomplete="off" id="txtPassword" class="cssTextbox" style="width: 200px;" type="password" value="" required="true" />
                        </td>

                    </tr>
        

                    <tr>
                        <td></td>
                        <td>
                            <input type="submit" name="btnGetRequest" value="Save" id="btnGetRequest" class="cssButton" onclick="return TracesDetails();" /></td>
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

