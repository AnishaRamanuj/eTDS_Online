<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="ManageChallan_Entries.aspx.cs" Inherits="Admin_ManageChallan_Entries" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
<center>
<br />
<br />
<br />
<br />
<br />
<asp:GridView ID="gvChallanEntryQuaterWise" runat="server" AutoGenerateColumns="false"
         CellSpacing="2" CellPadding="2" ShowHeader="true" PageSize="5"
        ShowFooter="true" AllowPaging="True" AllowSorting="True" 
        ondatabound="gvChallanEntryQuaterWise_DataBound">
        <PagerStyle CssClass="GridPager" BackColor="#5B8FBB" BorderColor="#DBDBDB" HorizontalAlign="Right" />
        <HeaderStyle CssClass="cssGridHeader" ForeColor="Black" />
        <FooterStyle CssClass="cssGridHeader" />
        <Columns>
            <asp:TemplateField HeaderText="Quarter">
                <ItemStyle CssClass="cssGridItemStyle" />
                <HeaderStyle BorderColor="#dbdbdb" />
                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Height="50px" Width="24.5%" />
                <ItemTemplate>
                    <asp:Button ID="btnQuarter" runat="server" CssClass="cssButton" Text='<%#Eval("Quater") %>' />
                </ItemTemplate>
                <FooterStyle BorderColor="#dbdbdb" Font-Bold="true" HorizontalAlign="Right" />
          </asp:TemplateField>
            <asp:TemplateField HeaderText="Paid">
                <ItemStyle CssClass="cssGridItemStyle" />
                <HeaderStyle BorderColor="#dbdbdb" />
                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="24.5%" />
                <ItemTemplate>
                    <asp:Button ID="btnPaid" runat="server" CssClass="cssButton"  Text='<%#Eval("Paid") %>'/>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Button ID="btnFooterPaid" runat="server" CssClass="cssButton" Text="Button" />
                </FooterTemplate>
                <FooterStyle BorderColor="#dbdbdb" Font-Bold="true" HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Unpaid">
                <ItemStyle CssClass="cssGridItemStyle" />
                <HeaderStyle BorderColor="#dbdbdb" />
                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="24.5%" />
                <ItemTemplate>
                    <asp:Button ID="btnUnpaid" runat="server" CssClass="cssButton"  Text='<%#Eval("Unpaid") %>' />
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Button ID="btnFooterUnpaid" runat="server" CssClass="cssButton" Text="Button" />
                </FooterTemplate>
                <FooterStyle BorderColor="#dbdbdb" Font-Bold="true" HorizontalAlign="Right" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</center>
    
</asp:Content>
