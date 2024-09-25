<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="ManageCountry_Master.aspx.cs" Inherits="Forms._ManageCountry_Master" %>

<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:UpdatePanel runat="server" ID="UpdatePanel4">
        <ContentTemplate>
            <table id="Table1" runat="server" width="100%" height="600px" cellpadding="5" cellspacing="0">
                <tr height="5px">
                    <td class="cssPageTitle">
                        <asp:Label ID="Label1" runat="server" Text="Manage Country"></asp:Label>
                    </td>
                </tr>
                <tr height="5px">
                    <td>
                        <UC:MessageControl runat="server" ID="ucMessageControl" />
                    </td>
                </tr>
                <tr height="5px">
                    <td runat="server" id="tdGrid">
                        <asp:Label ID="lblGridMessage" runat="server" CssClass="cssLabel"></asp:Label>
                        <asp:GridView ID="gwCountry_Master" runat="server" AutoGenerateColumns="False" CellSpacing="2"
                            CellPadding="2" ShowHeader="true" Width="100%" AllowPaging="true" OnPageIndexChanging="gwCountry_Master_OnPageIndexChanging"
                            PageSize="25" PagerSettings-Position="Top">
                            <PagerStyle CssClass="GridPager1" BackColor="#F3F3f3" HorizontalAlign="Right" BorderColor="#dbdbdb" />
                            <HeaderStyle CssClass="cssGridHeader" />
                            <RowStyle CssClass="cssGridAlternatingItemStyle" />
                            <AlternatingRowStyle CssClass="cssGridAlternatingItemStyle" />
                            <FooterStyle />
                            <Columns>
                                <asp:BoundField HeaderText="No" DataField="SrNo" SortExpression="SrNo">
                                    <HeaderStyle BorderColor="#dbdbdb" HorizontalAlign="Center" />
                                    <ItemStyle BorderColor="#dbdbdb" Width="20px" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Country Name" DataField="Country_Name" SortExpression="Country_Name">
                                    <HeaderStyle BorderColor="#dbdbdb" HorizontalAlign="Left" />
                                    <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Left" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:HiddenField runat="server" ID="hdnDesignation_ID" />
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
