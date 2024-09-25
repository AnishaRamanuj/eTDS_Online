<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="ManageNonSalary_BranchMaster.aspx.cs" Inherits="Admin_ManageNonSalary_BranchMaster" %>

<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
        <ContentTemplate>
            <table width="100%">
                <tr>
                    <td class="cssPageTitle">
                        <asp:Label ID="Label3" runat="server" Text="Manage Non Salary Branch"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <UC:MessageControl runat="server" ID="ucMessageControl" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <table align="center">
                            <tr>
                                <td>
                                    Branch Name
                                </td>
                                <td>
                                    <asp:TextBox ID="txtBranchName" CssClass="cssTextbox" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ControlToValidate="txtBranchName" ID="RequiredFieldValidator1"
                                        ValidationGroup="valid" Display="None" runat="server" ErrorMessage="Please Enter Branch Name !"></asp:RequiredFieldValidator>
                                </td>
                                <td>
                                    <asp:HiddenField ID="hdnbranchid" runat="server" />
                                    <asp:ValidationSummary ID="ValidationSummary1" ShowMessageBox="true" ShowSummary="false" runat="server" ValidationGroup="valid" />
                                    <asp:Button ID="btnSubmit" runat="server" ValidationGroup="valid" CssClass="cssButton"
                                        Text="Submit" OnClick="btnSubmit_Click" />
                                    <asp:Button ID="btnCancle" runat="server" CssClass="cssButton"
                                        Text="Cancel" OnClick="btnCancle_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <br />
                                    <br />
                                    <asp:GridView ID="gvBranchNon" runat="server" AutoGenerateColumns="false" Width="100%"
                                        ShowHeaderWhenEmpty="true" EmptyDataText="No Records Found !" CellSpacing="2" EmptyDataRowStyle-ForeColor="Red"
                                        CellPadding="2" ShowHeader="true" PageSize="25" ShowFooter="false" AllowPaging="True"
                                        RowStyle-CssClass="cssGridAlternatingItemStyle" OnRowCommand="gvBranchNon_RowCommand">
                                        <PagerStyle CssClass="cssGridHeader" BorderColor="#dbdbdb" BorderWidth="0" HorizontalAlign="center" />
                                        <HeaderStyle CssClass="cssGridHeader" ForeColor="Black" />
                                        <FooterStyle CssClass="cssGridHeader" BorderColor="#dbdbdb" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="SrNo">
                                                <HeaderStyle BorderColor="#dbdbdb" Font-Size="11px" />
                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Left" Width="15px" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSerialNo" runat="server" Visible="true" CssClass="cssLabel" Text='<%#Container.DataItemIndex+1 %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Branch Name">
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="left" Width="80%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBranchName" runat="server" Text='<%# Eval("Branch_Name") %>' CssClass="cssLabel"
                                                        Visible="true"></asp:Label>
                                                    <asp:HiddenField ID="hdnBranch_ID" runat="server" Value='<%#Eval("Branch_ID") %>' />
                                                </ItemTemplate>
                                                <FooterStyle BorderColor="#dbdbdb" Font-Bold="true" HorizontalAlign="Right" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="20px" />
                                                <ItemTemplate>
                                                    <asp:ImageButton runat="server" ImageUrl="~/Images/edit_icon.png" ID="btnEdit" CssClass="cssEditDeleteImage"
                                                        CommandName="EditCommand" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="20px" />
                                                <ItemTemplate>
                                                    <asp:ImageButton runat="server" ID="btnDelete" ImageUrl="~/Images/Delete_icon.png"
                                                        CssClass="cssEditDeleteImage" CommandName="DeleteCommand" OnClientClick="return DeleteConfirmation('Branch')" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
