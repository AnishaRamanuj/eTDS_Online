<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="ManageRebate_Master.aspx.cs" Inherits="Forms._ManageRebate_Master" %>

<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:UpdatePanel runat="server" ID="UpdatePanel4">
        <ContentTemplate>
            <asp:Table ID="Table1" runat="server" Width="100%" Height="600px" CellPadding="5"
                CellSpacing="0">
                <asp:TableRow Height="5px">
                    <asp:TableCell CssClass="cssPageTitle">
                        <asp:Label ID="Label1" runat="server" Text="Manage Rebate"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow Height="5px">
                    <asp:TableCell>
                        <UC:MessageControl runat="server" ID="ucMessageControl" />
                    </asp:TableCell>
                </asp:TableRow>
                <%--<asp:TableRow Height="5px">
                    <asp:TableCell runat="server" ID="tdSearch" Visible="true">
                        <fieldset class="login">
                            <legend>Search</legend>
                            <asp:Table ID="Table3" runat="server" Width="100%" CellPadding="3" CellSpacing="0">
                                <asp:TableRow runat="server" ID="TableRow9" Visible="true">
                                    <asp:TableCell Width="100px">
                                        <asp:Label ID="Label14" runat="server" CssClass="cssLabel" Text="Search Type"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList runat="server" ID="ddlSearchGroupHead" CssClass="cssDropDownList">
                                            <asp:ListItem Value="" Text="(Select Head)"></asp:ListItem>
                                            <asp:ListItem Value="Addition" Text="Addition"></asp:ListItem>
                                            <asp:ListItem Value="Deduction" Text="Deduction"></asp:ListItem>
                                            <asp:ListItem Value="Yearly" Text="Yearly"></asp:ListItem>
                                            <asp:ListItem Value="Variable" Text="Variable"></asp:ListItem>
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableCell>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Button runat="server" ID="btnSearch" Text="Search" CssClass="cssButton" OnClick="btnSearch_OnClick" />
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </fieldset>
                    </asp:TableCell>
                </asp:TableRow>--%>
                <asp:TableRow ID="TableRow3" Height="5px" runat="server" Visible="false">
                    <asp:TableCell>
                        <asp:Button runat="server" ID="btnAddNew" CssClass="cssButton" Text="Add New" OnClick="btnAddNew_OnClick" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow Height="5px">
                    <asp:TableCell ID="tblRebate">
                        <fieldset class="login">
                            <%--<legend>Grade Allocate</legend>--%>
                            <asp:Table ID="tblRebatedf" runat="server" Width="100%" CellPadding="3" CellSpacing="0">
                                <asp:TableRow runat="server" ID="TableRow9" Visible="true">
                                    <asp:TableCell Width="150px">
                                        <asp:Label ID="Label14" runat="server" CssClass="cssLabel" Text="Rebate Name"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox runat="server" ID="txtRebate_Name" CssClass="cssTextbox"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtRebate_Name"
                                            ErrorMessage="*" Display="Dynamic" CssClass="cssRequiredFieldValidator">
                                        </asp:RequiredFieldValidator>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableCell>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Button runat="server" ID="btnSave" Text="Save" CssClass="cssButton" OnClick="btnSave_OnClick" />
                                        &nbsp;
                                        <asp:Button runat="server" ID="btnCancel" Text="Cancel" CssClass="cssButton" OnClick="btnCancel_OnClick"
                                            CausesValidation="false" />
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </fieldset>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow Height="5px">
                    <asp:TableCell runat="server" ID="tdGrid">
                        <asp:Label ID="lblGridMessage" runat="server" CssClass="cssLabel"></asp:Label>
                        <asp:DataGrid runat="server" ID="dgRebate_Master" AutoGenerateColumns="false" DataKeyField="Rebate_ID"
                            Width="100%" CellSpacing="2" CellPadding="2" ShowHeader="true" OnItemCommand="dgRebate_Master_OnItemCommand">
                            <HeaderStyle CssClass="cssGridHeader" />
                            <ItemStyle CssClass="cssGridItemStyle" />
                            <AlternatingItemStyle CssClass="cssGridAlternatingItemStyle" />
                            <FooterStyle />
                            <Columns>
                                <asp:BoundColumn DataField="" HeaderText="No">
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" Width="20px" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="Rebate_Name" HeaderText="Rebate Name">
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" />
                                </asp:BoundColumn>
                                <asp:TemplateColumn Visible="false">
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="20px" />
                                    <ItemTemplate>
                                        <asp:ImageButton runat="server" ImageUrl="~/Images/edit_icon.png" ID="btnEdit" CssClass="cssEditDeleteImage"
                                            CommandName="EditCommand" />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn Visible="false">
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="20px" />
                                    <ItemTemplate>
                                        <asp:ImageButton runat="server" ID="btnDelete" ImageUrl="~/Images/Delete_icon.png"
                                            CssClass="cssEditDeleteImage" CommandName="DeleteCommand" OnClientClick="return DeleteConfirmation('Rebate')" />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                            </Columns>
                        </asp:DataGrid>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:HiddenField runat="server" ID="hdnRebate_ID" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
