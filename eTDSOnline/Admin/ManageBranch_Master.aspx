<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPages/MasterPage.master"  CodeFile="ManageBranch_Master.aspx.cs" Inherits="Admin_ManageBranch_Master" %>

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
                        <asp:Label ID="Label1" runat="server" Text="Manage Branch"></asp:Label>
                        
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow Height="5px">
                    <asp:TableCell>
                        <UC:MessageControl runat="server" ID="ucMessageControl" />
                    </asp:TableCell>
                </asp:TableRow>

                <asp:TableRow Height="5px">
                    <asp:TableCell>
                        <asp:Button runat="server" ID="btnAddNew" CssClass="cssButton" Text="Add New" OnClick="btnAddNew_OnClick" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow Height="5px">
                    <asp:TableCell ID="tblBranch">
                        <fieldset class="login">
                            <%--<legend>Grade Allocate</legend>--%>
                            <asp:Table ID="tblBranchdf" runat="server" Width="100%" CellPadding="3" CellSpacing="0">
                                <asp:TableRow runat="server" ID="TableRow9" Visible="true">
                                    <asp:TableCell Width="150px">
                                        <asp:Label ID="Label14" runat="server" CssClass="cssLabel" Text="Branch Name"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox runat="server" ID="txtBranch_Name"  Width="350px"></asp:TextBox>
                                        &nbsp;&nbsp;&nbsp;
                                        <asp:Label ID="Label8" runat="server" class="cssLabel" Text="*" ForeColor="#FF3300"></asp:Label>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtBranch_Name"
                                            ErrorMessage="Please Enter Branch Name" Display="Dynamic" CssClass="cssRequiredFieldValidator">
                                        </asp:RequiredFieldValidator>
                                    </asp:TableCell>
                                </asp:TableRow>

                                <asp:TableRow>
                                    <asp:TableCell>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Button runat="server" ID="btnSave" Text="Save" CssClass="cssButton" OnClick="btnSave_OnClick" />
                                        &nbsp;
                                        <asp:Button runat="server" ID="btnCancel" Text="Cancel" CssClass="cssButton" OnClick="btnCancel_OnClick" CausesValidation="false"/>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </fieldset>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow Height="5px">
                    <asp:TableCell runat="server" ID="tdGrid">
                        <asp:Label ID="lblGridMessage" runat="server" CssClass="cssLabel"></asp:Label>
                        <asp:DataGrid runat="server" ID="dgBranch_Master" AutoGenerateColumns="false" DataKeyField="Branch_ID"
                            Width="100%" CellSpacing="2" CellPadding="2" ShowHeader="true" OnItemCommand="dgBranch_Master_OnItemCommand">
                            <HeaderStyle CssClass="cssGridHeader" />
                            <ItemStyle CssClass="cssGridItemStyle" />
                            <AlternatingItemStyle CssClass="cssGridAlternatingItemStyle" />
                            <FooterStyle />
                            <Columns>
                                <asp:BoundColumn DataField="" HeaderText="No">
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" Width="20px" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="Branch_Name" HeaderText="Branch Name">
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
                                            CssClass="cssEditDeleteImage" CommandName="DeleteCommand" OnClientClick="return DeleteConfirmation('Branch')" />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                            </Columns>
                        </asp:DataGrid>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:HiddenField runat="server" ID="hdnBranch_ID" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
