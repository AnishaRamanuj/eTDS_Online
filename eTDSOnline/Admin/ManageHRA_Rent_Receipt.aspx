<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="ManageHRA_Rent_Receipt.aspx.cs" Inherits="Forms._ManageHRA_Rent_Receipt" %>

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
                        <asp:Label ID="Label1" runat="server" Text="Manage HRA Rent Receipt"></asp:Label>

                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow Height="5px">
                    <asp:TableCell>
                        <UC:MessageControl runat="server" ID="ucMessageControl" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow Height="5px">
                    <asp:TableCell ID="tblHraRantReceipt">
                        <table runat="server" width="100%">
                            <tr>
                                <td>
                                    <asp:TextBox runat="server" ID="txtFirstName" CssClass="cssTextbox"></asp:TextBox>
                                    <asp:Button runat="server" ID="btnSearch" CssClass="cssButton" Text="Search" OnClick="btnSearch_OnClick" />
                                </td>
                            </tr>
                            <tr>
                                <td width="400px" valign="top">
                                    <asp:Label ID="lblEmployeeGrideMessage" runat="server" CssClass="cssLabel"></asp:Label>
                                    <asp:DataGrid runat="server" ID="dgEmployee" AutoGenerateColumns="false" DataKeyField="Employee_ID"
                                        Width="100%" CellSpacing="2" CellPadding="2" ShowHeader="true" OnItemCommand="dgEmployee_OnItemCommand"
                                        OnPageIndexChanged="dgEmployee_PageIndexChanged" AllowPaging="true" PageSize="25">
                                        <PagerStyle Position="Top" CssClass="GridPager1" Mode="NumericPages" BorderColor="#dbdbdb"
                                            BorderWidth="0" HorizontalAlign="Right" BackColor="#F3F3F3" />
                                        <HeaderStyle CssClass="cssGridHeader" />
                                        <ItemStyle CssClass="cssGridItemStyle" />
                                        <AlternatingItemStyle CssClass="cssGridAlternatingItemStyle" />
                                        <FooterStyle />
                                        <Columns>
                                            <asp:TemplateColumn HeaderText="Employee Name">
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Left" />
                                                <ItemTemplate>
                                                    <asp:LinkButton runat="server" ID="lnlFirstName" Width="100%" CssClass="cssLabel"
                                                        Text='<%# Eval("FirstName") %>' CommandName="hracommand" Style="color: Black;
                                                        text-decoration: none;"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                        </Columns>
                                    </asp:DataGrid>
                                </td>
                                <td runat="server" id="tdGrid" valign="top">
                                    <asp:Label ID="lblGridMessage" runat="server" CssClass="cssLabel"></asp:Label>
                                    <table runat="server" id="tdHRAGrid" width="100%">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblEmployeeName" runat="server" Font-Bold="true" CssClass="cssLabel"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:DataGrid runat="server" ID="dgHRA_Rent_Receipt" AutoGenerateColumns="false"
                                                    DataKeyField="HRA_Rent_Receipt_ID" Width="100%" CellSpacing="2" CellPadding="2"
                                                    ShowHeader="true" OnItemCommand="dgHRA_Rent_Receipt_OnItemCommand">
                                                    <HeaderStyle CssClass="cssGridHeader" />
                                                    <ItemStyle CssClass="cssGridItemStyle" />
                                                    <AlternatingItemStyle CssClass="cssGridAlternatingItemStyle" />
                                                    <FooterStyle />
                                                    <Columns>
                                                        <asp:BoundColumn DataField="SrNo" HeaderText="No">
                                                            <HeaderStyle BorderColor="#dbdbdb" HorizontalAlign="Center" />
                                                            <ItemStyle BorderColor="#dbdbdb" Width="30px" HorizontalAlign="Center" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="Month_Name" HeaderText="Month">
                                                            <HeaderStyle BorderColor="#dbdbdb" />
                                                            <ItemStyle BorderColor="#dbdbdb" />
                                                        </asp:BoundColumn>
                                                        <asp:TemplateColumn HeaderText="Amount">
                                                            <HeaderStyle BorderColor="#dbdbdb" />
                                                            <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Left" Width="100px" />
                                                            <ItemTemplate>
                                                                <asp:TextBox runat="server" ID="txtAmount" CssClass="cssTextboxInt" Text='<%#Eval("Amount", "{0:N2}") %>'></asp:TextBox>
                                                                <asp:Label ID="lblMonthName" runat="server" Text='<%# Eval("Month_Name") %>' Visible="false"
                                                                    CssClass="cssLabel"></asp:Label>
                                                                <asp:Label ID="lblMonthNo" runat="server" Text='<%# Eval("Month_No") %>' Visible="false"
                                                                    CssClass="cssLabel"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                    </Columns>
                                                </asp:DataGrid>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Button runat="server" ID="btnSave" CssClass="cssButton" Text="Save" OnClick="btnSave_OnClick" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:HiddenField runat="server" ID="hbnEmployee_ID" />
                        <asp:HiddenField runat="server" ID="hdnHRA_Rent_Receipt_ID" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
