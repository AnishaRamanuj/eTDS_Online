﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="ManageDepartment_Master.aspx.cs" Inherits="Forms._ManageDepartment_Master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:UpdatePanel runat="server" ID="UpdatePanel4">
        <ContentTemplate>
            <table ID="Table1" runat="server" Width="100%" Height="600px" cellpadding="5"
                cellspacing="0">
                <tr Height="5px">
                    <td class="cssPageTitle">
                        <asp:Label ID="Label1" runat="server" Text="Manage Department"></asp:Label>
                    </td>
                </tr>
                <tr Height="5px">
                    <td>
                        <UC:MessageControl runat="server" ID="ucMessageControl" />
                    </td>
                </tr>
                <tr Height="5px">
                    <td runat="server" ID="tdSearch" Visible="true">
                        <fieldset class="login">
                            <legend>Search</legend>
                            <table id="Table3" runat="server" width="100%" cellpadding="3" cellspacing="0">
                                <tr runat="server" id="Tr1" visible="true">
                                    <td width="150px">
                                        <asp:Label ID="Label2" runat="server" CssClass="cssLabel" Text="Department Name : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtSearchDepartmentName" CssClass="cssTextbox"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:Button runat="server" ID="btnSearch" Text="Search" CssClass="cssButton" OnClick="btnSearch_OnClick" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr Height="5px">
                    <td>
                        <asp:Button runat="server" ID="btnAddNew" CssClass="cssButton" Text="Add New" OnClick="btnAddNew_OnClick" />
                    </td>
                </tr>
                <tr Height="5px">
                    <td ID="tblDepartment">
                        <fieldset class="login">
                            <%--<legend>Grade Allocate</legend>--%>
                            <table ID="tblDepartmentdf" runat="server" Width="100%" cellpadding="3" cellspacing="0">
                                <tr runat="server" ID="TableRow9" Visible="true">
                                    <td Width="150px">
                                        <asp:Label ID="Label14" runat="server" CssClass="cssLabel" Text="Department Name"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtDepartment_Name" class="cssTextboxLong"></asp:TextBox>
                                        &nbsp;&nbsp;&nbsp;
                                        <asp:Label ID="Label8" runat="server" class="cssLabel" Text="*" ForeColor="#FF3300"></asp:Label>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDepartment_Name"
                                            ErrorMessage="Please Enter Department Name" Display="Dynamic" CssClass="cssRequiredFieldValidator">
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
                        </fieldset>
                    </td>
                </tr>
                <tr Height="5px">
                    <td runat="server" ID="tdGrid">
                        <asp:Label ID="lblGridMessage" runat="server" CssClass="cssLabel"></asp:Label>
                        <asp:DataGrid runat="server" ID="dgDepartment_Master" AutoGenerateColumns="false"
                            DataKeyField="Department_ID" Width="100%" CellSpacing="2" CellPadding="2" ShowHeader="true"
                            OnItemCommand="dgDepartment_Master_OnItemCommand">
                            <HeaderStyle CssClass="cssGridHeader" />
                            <ItemStyle CssClass="cssGridItemStyle" />
                            <AlternatingItemStyle CssClass="cssGridAlternatingItemStyle" />
                            <FooterStyle />
                            <Columns>
                                <asp:BoundColumn DataField="" HeaderText="No">
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" Width="20px" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="Department_Name" HeaderText="Department Name">
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" />
                                </asp:BoundColumn>
                                <asp:TemplateColumn>
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="20px" />
                                    <ItemTemplate>
                                        <asp:ImageButton runat="server" ImageUrl="~/Images/edit_icon.png" ID="btnEdit" CssClass="cssEditDeleteImage"
                                            CommandName="EditCommand" />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="20px" />
                                    <ItemTemplate>
                                        <asp:ImageButton runat="server" ID="btnDelete" ImageUrl="~/Images/Delete_icon.png"
                                            CssClass="cssEditDeleteImage" CommandName="DeleteCommand" OnClientClick="return DeleteConfirmation('Department')" />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                            </Columns>
                        </asp:DataGrid>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:HiddenField runat="server" ID="hdnDepartment_ID" />
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>