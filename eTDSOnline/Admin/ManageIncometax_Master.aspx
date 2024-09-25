<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="ManageIncometax_Master.aspx.cs" Inherits="Forms._ManageIncometax_Master" %>

<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:UpdatePanel runat="server" ID="UpdatePanel4">
        <ContentTemplate>
            <table id="Table1" runat="server" width="100%" height="600px" cellpadding="5" cellspacing="0">
                <tr height="5px">
                    <td class="cssPageTitle">
                        <asp:Label ID="Label1" runat="server" Text="Manage Income Tax"></asp:Label>
                    </td>
                </tr>
                <tr height="5px">
                    <td>
                        <UC:MessageControl runat="server" ID="ucMessageControl" />
                    </td>
                </tr>
                <tr height="5px">
                    <td>
                        <asp:RadioButton runat="server" ID="rdoGeneral" OnCheckedChanged="rdoGeneral_OnCheckedChanged"
                            AutoPostBack="true" GroupName="rdoSlab" CssClass="cssLabel" Text="General" Checked="true" />
                        &nbsp;
                        <asp:RadioButton runat="server" ID="rdoFemale" OnCheckedChanged="rdoFemale_OnCheckedChanged"
                            AutoPostBack="true" GroupName="rdoSlab" CssClass="cssLabel" Text="Female" />
                        &nbsp;
                        <asp:RadioButton runat="server" ID="rdoSrCtzn" OnCheckedChanged="rdoSrCtzn_OnCheckedChanged"
                            AutoPostBack="true" GroupName="rdoSlab" CssClass="cssLabel" Text="Sr. Citizen" />
                        &nbsp;
                        <asp:RadioButton runat="server" ID="rdoSuperSrCtzn" OnCheckedChanged="rdoSuperSrCtzn_OnCheckedChanged"
                            AutoPostBack="true" GroupName="rdoSlab" CssClass="cssLabel" Text="Super Sr. Citizen" />
                        &nbsp;
                        <asp:RadioButton runat="server" ID="rbtn115BAC" 
                            AutoPostBack="true" GroupName="rdoSlab" CssClass="cssLabel" Text="115 BAC" OnCheckedChanged="rbtn115BAC_CheckedChanged" />
                    </td>
                </tr>
                <tr height="5px">
                    <td runat="server" id="tdGrid">
                        <asp:Label ID="lblGridMessage" runat="server" CssClass="cssLabel"></asp:Label>
                        <table runat="server" width="50%">
                            <tr>
                                <td runat="server" id="tdGeneral">
                                    <asp:DataGrid runat="server" ID="dgGeneralIncometax_Master" AutoGenerateColumns="false"
                                        DataKeyField="Incometax_ID" Width="100%" CellSpacing="2" CellPadding="2" ShowHeader="true">
                                        <HeaderStyle CssClass="cssGridHeader" />
                                        <ItemStyle CssClass="cssGridItemStyle" />
                                        <AlternatingItemStyle CssClass="cssGridAlternatingItemStyle" />
                                        <FooterStyle />
                                        <Columns>
                                            <asp:BoundColumn DataField="SlabSubTitle" HeaderText="">
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" />
                                            </asp:BoundColumn>
                                            <asp:TemplateColumn HeaderText="Tax Amount">
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" Width="100px" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="txtTax_Amount" ReadOnly="true" CssClass="cssTextboxInt" Text='<%# Eval("Tax_Amount") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Slab">
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" Width="100px" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="txtSlab" CssClass="cssTextboxInt" Text='<%# Eval("Slab") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                        </Columns>
                                    </asp:DataGrid>
                                </td>
                                <td runat="server" id="tdFemal">
                                    <asp:DataGrid runat="server" ID="dgFemaleIncometax_Master" AutoGenerateColumns="false"
                                        DataKeyField="Incometax_ID" Width="100%" CellSpacing="2" CellPadding="2" ShowHeader="true">
                                        <HeaderStyle CssClass="cssGridHeader" />
                                        <ItemStyle CssClass="cssGridItemStyle" />
                                        <AlternatingItemStyle CssClass="cssGridAlternatingItemStyle" />
                                        <FooterStyle />
                                        <Columns>
                                            <asp:BoundColumn DataField="SlabSubTitle" HeaderText="">
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" />
                                            </asp:BoundColumn>
                                            <asp:TemplateColumn HeaderText="Tax Amount">
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" Width="100px" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="txtTax_Amount" ReadOnly="true" CssClass="cssTextboxInt" Text='<%# Eval("Tax_Amount") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Slab">
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" Width="100px" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="txtSlab" CssClass="cssTextboxInt" Text='<%# Eval("Slab") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                        </Columns>
                                    </asp:DataGrid>
                                </td>
                                <td runat="server" id="tdSrCtzn">
                                    <asp:DataGrid runat="server" ID="dgSrCtznIncometax_Master" AutoGenerateColumns="false"
                                        DataKeyField="Incometax_ID" Width="100%" CellSpacing="2" CellPadding="2" ShowHeader="true">
                                        <HeaderStyle CssClass="cssGridHeader" />
                                        <ItemStyle CssClass="cssGridItemStyle" />
                                        <AlternatingItemStyle CssClass="cssGridAlternatingItemStyle" />
                                        <FooterStyle />
                                        <Columns>
                                            <asp:BoundColumn DataField="SlabSubTitle" HeaderText="">
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" />
                                            </asp:BoundColumn>
                                            <asp:TemplateColumn HeaderText="Tax Amount">
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" Width="100px" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="txtTax_Amount" ReadOnly="true" CssClass="cssTextboxInt" Text='<%# Eval("Tax_Amount") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Slab">
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" Width="100px" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="txtSlab" CssClass="cssTextboxInt" Text='<%# Eval("Slab") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                        </Columns>
                                    </asp:DataGrid>
                                </td>
                                <td runat="server" id="tdSuperSnCtzn">
                                    <asp:DataGrid runat="server" ID="dgSuperSrCtznIncometax_Master" AutoGenerateColumns="false"
                                        DataKeyField="Incometax_ID" Width="100%" CellSpacing="2" CellPadding="2" ShowHeader="true">
                                        <HeaderStyle CssClass="cssGridHeader" />
                                        <ItemStyle CssClass="cssGridItemStyle" />
                                        <AlternatingItemStyle CssClass="cssGridAlternatingItemStyle" />
                                        <FooterStyle />
                                        <Columns>
                                            <asp:BoundColumn DataField="SlabSubTitle" HeaderText="">
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" />
                                            </asp:BoundColumn>
                                            <asp:TemplateColumn HeaderText="Tax Amount">
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" Width="100px" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="txtTax_Amount" ReadOnly="true" CssClass="cssTextboxInt" Text='<%# Eval("Tax_Amount") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Slab">
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" Width="100px" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="txtSlab" CssClass="cssTextboxInt" Text='<%# Eval("Slab") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                        </Columns>
                                    </asp:DataGrid>
                                </td>
                                <td runat="server" id="td115BAC">
                                    <asp:DataGrid runat="server" ID="dg115" AutoGenerateColumns="false"
                                        DataKeyField="Incometax_ID" Width="100%" CellSpacing="2" CellPadding="2" ShowHeader="true">
                                        <HeaderStyle CssClass="cssGridHeader" />
                                        <ItemStyle CssClass="cssGridItemStyle" />
                                        <AlternatingItemStyle CssClass="cssGridAlternatingItemStyle" />
                                        <FooterStyle />
                                        <Columns>
                                            <asp:BoundColumn DataField="SlabSubTitle" HeaderText="">
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" />
                                            </asp:BoundColumn>
                                            <asp:TemplateColumn HeaderText="Tax Amount">
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" Width="100px" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="txtTax_Amount" ReadOnly="true" CssClass="cssTextboxInt" Text='<%# Eval("Tax_Amount") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Slab">
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" Width="100px" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="txtSlab" CssClass="cssTextboxInt" Text='<%# Eval("Slab") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                        </Columns>
                                    </asp:DataGrid>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="5px">
                        <asp:Button runat="server" ID="btnSave" CssClass="cssButton" Text="Save" OnClick="btnSave_OnClick" Visible="false" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:HiddenField runat="server" ID="hdnIncometax_ID" />
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
