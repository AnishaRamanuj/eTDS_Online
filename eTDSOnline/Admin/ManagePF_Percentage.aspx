<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="ManagePF_Percentage.aspx.cs" Inherits="Forms._ManagePF_Percentage" %>

<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:UpdatePanel runat="server" ID="UpdatePanel4">
        <ContentTemplate>
            <table id="Table1" runat="server" width="100%" height="600px" cellpadding="5" cellspacing="0">
                <tr height="5px">
                    <td class="cssPageTitle">
                        <asp:Label ID="Label1" runat="server" Text="Manage PF Percentage"></asp:Label>
                    </td>
                </tr>
                <tr height="5px">
                    <td>
                        <UC:MessageControl runat="server" ID="ucMessageControl" />
                    </td>
                </tr>
                <tr height="5px">
                    <td runat="server" id="tdSearch" visible="true">
                        <table id="Table3" runat="server" width="100%" cellpadding="3" cellspacing="0">
                            <%--<tr runat="server" id="TableRow9" visible="true">
                                <td width="150px">
                                    <asp:Label ID="Label14" runat="server" CssClass="cssLabel"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label2" runat="server" CssClass="cssLabel" Text="Provident Fund (PF)"></asp:Label>
                                </td>
                            </tr>--%>
                            <tr>
                                <td width="150px">
                                    <asp:Label ID="Label3" runat="server" CssClass="cssLabel" Text="PF Percentage"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtPFPercentage" Height="20px" BorderColor="Gray"
                                        BackColor="White" Width="50px" CssClass="cssTextboxInt" Visible="true"></asp:TextBox>
                                    <asp:Label ID="Label5" runat="server" CssClass="cssLabel" Text="*"></asp:Label>
                                   <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ControlToValidate="txtPFPercentage"
                                        CssClass="cssRequiredFieldValidator" ValidationExpression="\d+" Display="Static"
                                        EnableClientScript="true" ErrorMessage="Numbers only" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td width="150px">
                                    <asp:Label ID="Label2" runat="server" CssClass="cssLabel" Text="PF Limit"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtPFLimit" Height="20px" BorderColor="Gray"
                                        BackColor="White" Width="100px" CssClass="cssTextboxInt" Visible="true"></asp:TextBox>
                                    <asp:Label ID="Label4" runat="server" CssClass="cssLabel" Text="*"></asp:Label>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtPFLimit"
                                        CssClass="cssRequiredFieldValidator" ValidationExpression="\d+" Display="Static"
                                        EnableClientScript="true" ErrorMessage="Invalid amount" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td valign="top">
                                    <table runat="server">
                                        <tr>
                                            <td valign="top">
                                                <asp:GridView ID="gwAddition" runat="server" AutoGenerateColumns="False" CellSpacing="2"
                                                    CellPadding="2" ShowHeader="true" Width="250px" DataKeyNames="Head_ID">
                                                    <HeaderStyle CssClass="cssGridHeader" />
                                                    <RowStyle CssClass="cssGridAlternatingItemStyle" />
                                                    <AlternatingRowStyle CssClass="cssGridAlternatingItemStyle" />
                                                    <FooterStyle />
                                                    <Columns>
                                                        <asp:BoundField HeaderText="Addition" DataField="Head_Name" SortExpression="Head_Name">
                                                            <HeaderStyle BorderColor="#dbdbdb" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Left" />
                                                        </asp:BoundField>
                                                        <asp:TemplateField>
                                                            <HeaderStyle BorderColor="#dbdbdb" HorizontalAlign="Right" />
                                                            <ItemStyle BorderColor="#dbdbdb" Width="20px" HorizontalAlign="Right" />
                                                            <ItemTemplate>
                                                                <asp:CheckBox runat="server" ID="chkCheckAddition" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                            <td valign="top">
                                                <asp:GridView ID="gwVariable" runat="server" AutoGenerateColumns="False" CellSpacing="2" EmptyDataRowStyle-BorderColor="#dbdbdb" ShowHeaderWhenEmpty="true" EmptyDataText="No Records Found !"
                                                    CellPadding="2" ShowHeader="true" Width="250px" DataKeyNames="Head_ID">
                                                    <HeaderStyle CssClass="cssGridHeader" BorderColor="#dbdbdb" />
                                                    <RowStyle CssClass="cssGridAlternatingItemStyle" BorderColor="#dbdbdb" />
                                                    <AlternatingRowStyle CssClass="cssGridAlternatingItemStyle" BorderColor="#dbdbdb" />
                                                    <FooterStyle BorderColor="#dbdbdb"/>
                                                    <Columns>
                                                        <asp:BoundField HeaderText="Variable" DataField="Head_Name" SortExpression="Head_Name">
                                                            <HeaderStyle BorderColor="#dbdbdb" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Left" />
                                                        </asp:BoundField>
                                                        <asp:TemplateField>
                                                            <HeaderStyle BorderColor="#dbdbdb" HorizontalAlign="Right" />
                                                            <ItemStyle BorderColor="#dbdbdb" Width="20px" HorizontalAlign="Right" />
                                                            <ItemTemplate>
                                                                <asp:CheckBox runat="server" ID="chkCheckVariable" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:Button runat="server" ID="btnSave" Text="Save" CssClass="cssButton" OnClick="btnSave_OnClick" />
                                </td>
                            </tr>
                        </table>
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
