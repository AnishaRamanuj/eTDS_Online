<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="ManageHeads_Sec10.aspx.cs" Inherits="Forms._ManageHeads_Sec10" %>

<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:UpdatePanel runat="server" ID="UpdatePanel4">
        <ContentTemplate>
            <table id="Table1" runat="server" width="100%" height="600px" cellpadding="5" cellspacing="0">
                <tr height="5px">
                    <td class="cssPageTitle">
                        <asp:Label ID="Label1" runat="server" Text="Manage Heads Sec10"></asp:Label>
                    </td>
                </tr>
                <tr height="5px">
                    <td>
                        <UC:MessageControl runat="server" ID="ucMessageControl" />
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:GridView ID="gwHeads" runat="server" AutoGenerateColumns="False" CellSpacing="2"
                            CellPadding="2" ShowHeader="true" Width="50%" DataKeyNames="Head_ID">
                            <HeaderStyle CssClass="cssGridHeader" />
                            <RowStyle CssClass="cssGridAlternatingItemStyle" />
                            <AlternatingRowStyle CssClass="cssGridAlternatingItemStyle" />
                            <FooterStyle />
                            <Columns>
                                <asp:BoundField HeaderText="Heads" DataField="Head_Name" SortExpression="Head_Name">
                                    <HeaderStyle BorderColor="#dbdbdb" HorizontalAlign="Left" />
                                    <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:TemplateField>
                                    <HeaderStyle BorderColor="#dbdbdb" HorizontalAlign="Right" />
                                    <ItemStyle BorderColor="#dbdbdb" Width="20px" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="chkCheckAddition" Checked='<%# Convert.ToBoolean(Eval("Section10")) %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button runat="server" ID="btnSave" Text="Save" CssClass="cssButton" OnClick="btnSave_OnClick" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:HiddenField runat="server" ID="hdnPercentage_ID" />
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
