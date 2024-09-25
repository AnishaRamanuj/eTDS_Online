<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="ManageProfessionalTaxSlab_Master.aspx.cs" Inherits="Forms._manageprofessionaltaxslab" %>

<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:UpdatePanel runat="server" ID="UpdatePanel4">
        <ContentTemplate>
            <table id="Table1" runat="server" width="100%" height="600px" cellpadding="5" cellspacing="0">
                <tr height="5px">
                    <td class="cssPageTitle">
                        <asp:Label ID="Label1" runat="server" Text="Manage Professional Tax"></asp:Label>
                    </td>
                </tr>
                <tr height="5px">
                    <td>
                        <UC:MessageControl runat="server" ID="ucMessageControl" />
                    </td>
                </tr>
                <tr height="5px">
                    <td>
                        <table id="Table3" runat="server" width="100%" cellpadding="3" cellspacing="0">
                            <tr>
                                <td>
                                    <asp:Label ID="Label14" runat="server" CssClass="cssLabel" Text="State"></asp:Label>
                                    <asp:DropDownList runat="server" ID="ddlState" CssClass="cssDropDownList" OnSelectedIndexChanged="ddlState_OnSelectedIndexChanged"
                                        AutoPostBack="true">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr runat="server" id="TableRow9" visible="true">
                                <%-- <td width="70px" valign="Top">
                                </td>--%>
                                <td valign="Top">
                                    <fieldset class="login">
                                        <legend>Professional Tax Slab</legend>
                                        <asp:GridView runat="server" ID="dgSlab" AutoGenerateColumns="false" DataKeyNames="Professionaltax_ID"
                                            Width="400px" CellSpacing="2" CellPadding="2" ShowHeader="true">
                                            <HeaderStyle CssClass="cssGridHeader" />
                                            <FooterStyle />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Slab">
                                                    <HeaderStyle BorderColor="#dbdbdb" />
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblSlab" Text='<%# Eval("Slab") %>' Width="90px"
                                                            CssClass="cssLabel"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="From Amount">
                                                    <HeaderStyle BorderColor="#dbdbdb" />
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblFromAmount" Text='<%# Eval("From_Tax_Amount") %>'
                                                            Width="90px" CssClass="cssLabel"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="To Amount">
                                                    <HeaderStyle BorderColor="#dbdbdb" />
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblToAmount" Text='<%# Eval("To_Tax_Amount") %>'
                                                            Width="90px" CssClass="cssLabel"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                            </Columns>
                                        </asp:GridView>
                                        <div style ="height:30px;"></div>

                                        <legend>Female Professional Tax Slab</legend>
                                        <asp:GridView runat="server" ID="GrdFemale" AutoGenerateColumns="false" DataKeyNames="Professionaltax_ID"
                                            Width="400px" CellSpacing="2" CellPadding="2" ShowHeader="true">
                                            <HeaderStyle CssClass="cssGridHeader" />
                                            <FooterStyle />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Slab">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblSlab" Text='<%# Eval("Slab") %>' Width="90px"
                                                            CssClass="cssLabel"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="From Amount">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblFromAmount" Text='<%# Eval("From_Tax_Amount") %>'
                                                            Width="90px" CssClass="cssLabel"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="To Amount">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblToAmount" Text='<%# Eval("To_Tax_Amount") %>'
                                                            Width="90px" CssClass="cssLabel"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                            </Columns>
                                        </asp:GridView>
                                    </fieldset>
                                </td>
                                <td valign="Top" width="250px">
                                    <table id="Table2" runat="server" width="100%">
                                        <tr>
                                            <td valign="Top" width="300px">
                                                <fieldset class="login">
                                                    <legend>Additions Heads</legend>
                                                    <asp:Label runat="server" ID="lblAdditionsGridMessage" CssClass="cssLabel"></asp:Label>
                                                    <asp:DataGrid runat="server" ID="dgAddition" AutoGenerateColumns="false" DataKeyField="Head_ID"
                                                        Width="300px" CellSpacing="2" CellPadding="2" ShowHeader="true">
                                                        <HeaderStyle CssClass="cssGridHeader" />
                                                        <ItemStyle CssClass="cssGridItemStyle" />
                                                        <AlternatingItemStyle CssClass="cssGridAlternatingItemStyle" />
                                                        <FooterStyle />
                                                        <Columns>
                                                            <asp:BoundColumn DataField="" HeaderText="#">
                                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                                <ItemStyle BorderColor="#dbdbdb" Width="20px" HorizontalAlign="Center" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="Head_Name" HeaderText="Head Name">
                                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                                <ItemStyle BorderColor="#dbdbdb" />
                                                            </asp:BoundColumn>

                                                            <asp:TemplateColumn>
                                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="15px" />
                                                                <HeaderTemplate>
                                                                    <asp:CheckBox ID="checkAll" runat="server" onclick="checkAll(this);"/>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="chkCheckAddition" runat="server" Checked='<%#Convert.ToBoolean(Eval("isChecked")) %>' onclick="Check_Click(this)"  />
                                                                </ItemTemplate>
                                                            </asp:TemplateColumn>
                                                        </Columns>
                                                    </asp:DataGrid>
                                                </fieldset>
                                            </td>
                                            <td valign="Top" width="300px">
                                                <fieldset class="login">
                                                    <legend>Variable Heads</legend>
                                                    <asp:Label runat="server" ID="lblVariableMessage" CssClass="cssLabel"></asp:Label>
                                                    <asp:DataGrid runat="server" ID="dgVariable" AutoGenerateColumns="false" DataKeyField="Head_ID"
                                                        Width="300px" CellSpacing="2" CellPadding="2" ShowHeader="true">
                                                        <HeaderStyle CssClass="cssGridHeader" />
                                                        <ItemStyle CssClass="cssGridItemStyle" />
                                                        <AlternatingItemStyle CssClass="cssGridAlternatingItemStyle" />
                                                        <FooterStyle />
                                                        <Columns>
                                                            <asp:BoundColumn DataField="" HeaderText="#">
                                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                                <ItemStyle BorderColor="#dbdbdb" Width="20px" HorizontalAlign="Center" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="Head_Name" HeaderText="Head Name">
                                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                                <ItemStyle BorderColor="#dbdbdb" />
                                                            </asp:BoundColumn>
                                                            <asp:TemplateColumn>
                                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="15px" />
                                                                <HeaderTemplate>
                                                                    <asp:CheckBox ID="checkAll" runat="server" onclick="checkAll(this);" />
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="chkCheckVariable" runat="server" Checked='<%#Convert.ToBoolean(Eval("isChecked")) %>' onclick="Check_Click(this)"/>
                                                                </ItemTemplate>
                                                            </asp:TemplateColumn>
                                                        </Columns>
                                                    </asp:DataGrid>
                                                </fieldset>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:Button runat="server" ID="btnSave" Text="Save" CssClass="cssButton" OnClick="btnSave_OnClick"
                                        />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr height="5px">
                    <td runat="server" id="tdGrid">
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:HiddenField runat="server" ID="hdnHeadID" />
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
