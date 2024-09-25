<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="ManageResign_Master.aspx.cs" Inherits="Forms._ManageResign_Master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <%--<asp:UpdatePanel runat="server" ID="UpdatePanel4">
        <ContentTemplate>--%>
    <table id="Table1" runat="server" width="100%" height="600px" cellpadding="5" cellspacing="0">
        <tr height="5px">
            <td class="cssPageTitle">
                <asp:Label ID="Label1" runat="server" Text="Manage Resignation"></asp:Label>
            </td>
        </tr>
        <tr height="5px">
            <td>
                <UC:MessageControl runat="server" ID="ucMessageControl" />
            </td>
        </tr>
        <tr height="5px">
            <td runat="server" id="tdSearch" valign="top" style="height: 0px;">
                <table id="Table5" runat="server" width="100%" cellpadding="3" cellspacing="0">
                    <tr runat="server" id="TableRow1">
                        <td width="120px">
                            <asp:Label ID="Label46" runat="server" CssClass="cssLabel" Text="Employee Name"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtSearchName" CssClass="cssTextbox" Width="300px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <asp:Button runat="server" ID="btnSearch" Text="Search" CssClass="cssButton" OnClick="btnSearch_OnClick" />
                            &nbsp;
                            <asp:Button runat="server" ID="btnAddNew" CssClass="cssButton" Text="Add Employee to Resign"
                                OnClick="btnAddNew_OnClick" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <%--<tr height="5px">
            <td>
            </td>
        </tr>--%>
        <tr height="5px">
            <td id="tblEmployee">
                <%--<fieldset class="login">
                    <legend>Add or Edit Resign</legend>--%>
                <table id="tblEmployeedf" runat="server" width="100%" cellpadding="3" cellspacing="0">
                    <tr runat="server" id="Tr1" visible="true">
                        <td width="150px">
                            <asp:Label ID="Label3" runat="server" CssClass="cssLabel" Text="Employee"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlEmployee" CssClass="cssDropDownList">
                            </asp:DropDownList>
                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlEmployee"
                                ErrorMessage="*" Display="Dynamic" CssClass="cssRequiredFieldValidator">
                            </asp:RequiredFieldValidator>
                            <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtResign_DT"
                                            Display="Dynamic" EnableClientScript="true" runat="server" ValidationExpression="^(0[1-9]|[12][0-9]|3[01])[/](0[1-9]|1[012])[/](19|20)\d\d$"
                                            SetFocusOnError="true" ErrorMessage="Invalid date">
                                        </asp:RegularExpressionValidator>--%>
                        </td>
                    </tr>
                    <tr runat="server" id="TableRow9" visible="true">
                        <td width="150px">
                            <asp:Label ID="Label2" runat="server" CssClass="cssLabel" Text="Resign Date"></asp:Label>
                        </td>
                        <td>
                            <%--<script type="text/javascript">
                                $(function () {
                                    $("#<%= txtResign_DT.ClientID %>").datepicker({ dateFormat: 'dd/mm/yy',
                                        changeMonth: true,
                                        changeYear: true,
                                        yearRange: 'c-200:c+20'
                                    });
                                });
                            </script>--%>
                            <asp:TextBox runat="server" ID="txtResign_DT" CssClass="cssTextbox" Width="100px"></asp:TextBox>
                            <%-- &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtResign_DT"
                                ErrorMessage="*" Display="Dynamic" CssClass="cssRequiredFieldValidator">
                            </asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="DateValidator" ControlToValidate="txtResign_DT"
                                Display="Dynamic" EnableClientScript="true" runat="server" ValidationExpression="^(0[1-9]|[12][0-9]|3[01])[/](0[1-9]|1[012])[/](19|20)\d\d$"
                                SetFocusOnError="true" ErrorMessage="Invalid date" CssClass="cssRequiredFieldValidator">
                            </asp:RegularExpressionValidator>--%>
                            <asp:ImageButton ID="ImageButton1" ImageUrl="~/Images/calendar.gif" runat="server"
                                CausesValidation="false" />
                            <asp:CalendarExtender ID="c1" runat="server" PopupButtonID="ImageButton1" TargetControlID="txtResign_DT"
                                Format="dd/MM/yyyy">
                            </asp:CalendarExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ControlToValidate="txtResign_DT"
                                Display="None" ErrorMessage="Please Select Date !" ValidationGroup="ValidThisV"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr runat="server" id="TableRodfw9" visible="true">
                        <td valign="top">
                            <asp:Label ID="Label14" runat="server" CssClass="cssLabel" Text="Reason of Resign"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtReasion" TextMode="MultiLine" Height="70px" Width="350px"
                                CssClass="cssTextbox"></asp:TextBox>
                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtReasion"
                                ErrorMessage="*" Display="Dynamic" CssClass="cssRequiredFieldValidator">
                            </asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <asp:Button runat="server" ID="btnSave" Text="Save" CssClass="cssButton" OnClick="btnSave_OnClick" />
                            &nbsp;
                            <asp:Button runat="server" ID="btnCancel" Text="Cancel" CssClass="cssButton" OnClick="btnCancel_OnClick"
                                CausesValidation="false" />
                        </td>
                    </tr>
                </table>
                <%--</fieldset>--%>
            </td>
        </tr>
        <tr height="5px">
            <td runat="server" id="tdGrid">
                <asp:Label ID="lblGridMessage" runat="server" CssClass="cssLabel"></asp:Label>
                <asp:DataGrid runat="server" ID="dgEmployee_Master" AutoGenerateColumns="false" DataKeyField="Employee_ID"
                    Width="100%" CellSpacing="2" CellPadding="2" ShowHeader="true" OnItemCommand="dgEmployee_Master_OnItemCommand">
                    <HeaderStyle CssClass="cssGridHeader" />
                    <ItemStyle CssClass="cssGridItemStyle" />
                    <AlternatingItemStyle CssClass="cssGridAlternatingItemStyle" />
                    <FooterStyle />
                    <Columns>
                        <asp:BoundColumn DataField="" HeaderText="No">
                            <HeaderStyle BorderColor="#dbdbdb" />
                            <ItemStyle BorderColor="#dbdbdb" Width="20px" />
                        </asp:BoundColumn>
                        <asp:BoundColumn DataField="FirstName" HeaderText="Name">
                            <HeaderStyle BorderColor="#dbdbdb" />
                            <ItemStyle BorderColor="#dbdbdb" />
                        </asp:BoundColumn>
                        <asp:BoundColumn DataField="Join_DT" HeaderText="Join Date" DataFormatString="{0:dd/MM/yyyy}">
                            <HeaderStyle BorderColor="#dbdbdb" />
                            <ItemStyle BorderColor="#dbdbdb" Width="80px" />
                            <FooterStyle BorderColor="#dbdbdb" />
                        </asp:BoundColumn>
                        <asp:BoundColumn DataField="Resign_DT" HeaderText="Resign Date" DataFormatString="{0:dd/MM/yyyy}">
                            <HeaderStyle BorderColor="#dbdbdb" />
                            <ItemStyle BorderColor="#dbdbdb" Width="80px" />
                            <FooterStyle BorderColor="#dbdbdb" />
                        </asp:BoundColumn>
                        <asp:BoundColumn DataField="Mobile_No" HeaderText="Mobile No">
                            <HeaderStyle BorderColor="#dbdbdb" />
                            <ItemStyle BorderColor="#dbdbdb" Width="100px" />
                            <FooterStyle BorderColor="#dbdbdb" />
                        </asp:BoundColumn>
                        <asp:BoundColumn DataField="Designation_Name" HeaderText="Designation">
                            <HeaderStyle BorderColor="#dbdbdb" />
                            <ItemStyle BorderColor="#dbdbdb" Width="150px" />
                            <FooterStyle BorderColor="#dbdbdb" />
                        </asp:BoundColumn>
                        <asp:BoundColumn DataField="Department_Name" HeaderText="Department">
                            <HeaderStyle BorderColor="#dbdbdb" />
                            <ItemStyle BorderColor="#dbdbdb" Width="150px" />
                            <FooterStyle BorderColor="#dbdbdb" />
                        </asp:BoundColumn>
                        <asp:TemplateColumn>
                            <HeaderStyle BorderColor="#dbdbdb" />
                            <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="20px" />
                            <ItemTemplate>
                                <asp:ImageButton runat="server" ImageUrl="~/Images/edit_icon.png" ID="btnEdit" CssClass="cssEditDeleteImage"
                                    CommandName="EditCommand" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn Visible="true">
                            <HeaderStyle BorderColor="#dbdbdb" />
                            <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="20px" />
                            <ItemTemplate>
                                <asp:ImageButton runat="server" ID="btnDelete" ImageUrl="~/Images/Delete_icon.png"
                                    CssClass="cssEditDeleteImage" CommandName="DeleteCommand" OnClientClick="return DeleteConfirmation('resign')" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                </asp:DataGrid>
            </td>
        </tr>
        <tr>
            <td>
                <asp:HiddenField runat="server" ID="hdnEmployee_ID" />
            </td>
        </tr>
    </table>
    <%--</ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>
