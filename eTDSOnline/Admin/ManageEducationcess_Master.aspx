<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="ManageEducationcess_Master.aspx.cs" Inherits="Forms._ManageEducationcess_Master" %>

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
                        <asp:Label ID="Label1" runat="server" Text="Manage Education Cess"></asp:Label>

                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow Height="5px">
                    <asp:TableCell>
                        <UC:MessageControl runat="server" ID="ucMessageControl" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow ID="TableRow3" Height="5px" runat="server" Visible="false">
                    <asp:TableCell>
                        <asp:Button runat="server" ID="btnAddNew" CssClass="cssButton" Text="Add New" OnClick="btnAddNew_OnClick" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow Height="5px">
                    <asp:TableCell ID="tblEducationcess">
                        <fieldset class="login">
                            <%--<legend>Grade Allocate</legend>--%>
                            <asp:Table ID="tblEducationcessdf" runat="server" Width="100%" CellPadding="3" CellSpacing="0">
                                <asp:TableRow runat="server" ID="TableRow9" Visible="true">
                                    <asp:TableCell Width="150px">
                                        <asp:Label ID="Label14" runat="server" CssClass="cssLabel" Text="Cess Percent"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox runat="server" ID="txtcess_Percent" CssClass="cssTextbox"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtcess_Percent"
                                            ErrorMessage="*" Display="Dynamic" CssClass="cssRequiredFieldValidator">
                                        </asp:RequiredFieldValidator>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow runat="server" ID="TableRow1" Visible="true">
                                    <asp:TableCell>
                                        <asp:Label ID="Label2" runat="server" CssClass="cssLabel" Text="App type"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox runat="server" ID="txtApp_Type" CssClass="cssTextbox"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtApp_Type"
                                            ErrorMessage="*" Display="Dynamic" CssClass="cssRequiredFieldValidator">
                                        </asp:RequiredFieldValidator>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow runat="server" ID="TableRow2" Visible="true">
                                    <asp:TableCell>
                                        <asp:Label ID="Label3" runat="server" CssClass="cssLabel" Text="HCess Percent"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox runat="server" ID="txtHCess_Percent" CssClass="cssTextbox"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtHCess_Percent"
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
                                        <asp:Button runat="server" ID="btnCancel" Text="Cancel" CssClass="cssButton" OnClick="btnCancel_OnClick" CausesValidation="false" />
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </fieldset>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow Height="5px">
                    <asp:TableCell runat="server" ID="tdGrid">
                        <asp:Label ID="lblGridMessage" runat="server" CssClass="cssLabel"></asp:Label>
                        <asp:DataGrid runat="server" ID="dgEducationcess_Master" AutoGenerateColumns="false" DataKeyField="Educationcess_ID"
                            Width="100%" CellSpacing="2" CellPadding="2" ShowHeader="true" OnItemCommand="dgEducationcess_Master_OnItemCommand">
                            <HeaderStyle CssClass="cssGridHeader" />
                            <ItemStyle CssClass="cssGridItemStyle" />
                            <AlternatingItemStyle CssClass="cssGridAlternatingItemStyle" />
                            <FooterStyle />
                            <Columns>
                                <asp:BoundColumn DataField="SrNo" HeaderText="No">
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" Width="20px" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="cess_Percent" HeaderText="Education Cess %">
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" Width="180px" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="App_Type" HeaderText="App Type" Visible="false">
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="HCess_Percent" HeaderText="Higher Education Cess %">
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" Width="180px" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="Health_Percent" HeaderText="Health  Cess %">
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" Width="180px" />
                                </asp:BoundColumn>
                                 <asp:BoundColumn DataField="Total" HeaderText="Total">
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" Width="50px" />
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
                                            CssClass="cssEditDeleteImage" CommandName="DeleteCommand"  OnClientClick="return DeleteConfirmation('Educationcess')" />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                            </Columns>
                        </asp:DataGrid>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:HiddenField runat="server" ID="hdnEducationcess_ID" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
