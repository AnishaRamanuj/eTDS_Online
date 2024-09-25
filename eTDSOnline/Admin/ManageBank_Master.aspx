<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="ManageBank_Master.aspx.cs" Inherits="Forms._ManageBank_Master" %>

<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" src="../Scripts/jquery-1.8.2.min.js"></script>
     <script language="javascript" type="text/javascript">
         $(document).ready(function () {
             $("[id*=hdnConnString]").val($("[id*=ddlFinancialYear] :selected").text());
         });
         </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:UpdatePanel runat="server" ID="UpdatePanel4">
        <ContentTemplate>
            <table ID="Table1" runat="server" Width="100%" height="600px" cellpadding="5"
                cellspacing="0">
                <tr height="5px">
                    <td class="cssPageTitle">
                        <asp:Label ID="Label1" runat="server" Text="Manage Bank"></asp:Label>
                    </td>
                </tr>
                <tr height="5px">
                    <td>
                        <UC:MessageControl runat="server" ID="ucMessageControl" />
                    </td>
                </tr>
                <%--<tr height="5px">
                    <td runat="server" ID="tdSearch" Visible="true">
                        <fieldset class="login">
                            <legend>Search</legend>
                            <table ID="Table3" runat="server" Width="100%" cellpadding="3" cellspacing="0">
                                <tr runat="server" ID="TableRow9" Visible="true">
                                    <td Width="100px">
                                        <asp:Label ID="Label14" runat="server" class="cssLabel" Text="Search Type"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlSearchGroupHead" class="cssDropDownList">
                                            <asp:ListItem Value="" Text="(Select Head)"></asp:ListItem>
                                            <asp:ListItem Value="Addition" Text="Addition"></asp:ListItem>
                                            <asp:ListItem Value="Deduction" Text="Deduction"></asp:ListItem>
                                            <asp:ListItem Value="Yearly" Text="Yearly"></asp:ListItem>
                                            <asp:ListItem Value="Variable" Text="Variable"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:Button runat="server" ID="btnSearch" Text="Search" class="cssButton" OnClick="btnSearch_OnClick" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>--%>
                <tr height="5px">
                    <td>
                        <asp:Button runat="server" ID="btnAddNew" class="cssButton" Text="Add New" OnClick="btnAddNew_OnClick" />
                    </td>
                </tr>
                <tr height="5px">
                    <td ID="tblBank">
                        <fieldset class="login">
                            <%--<legend>Grade Allocate</legend>--%>
                            <table ID="tblBankdf" runat="server" Width="100%" cellpadding="3" CellSpacing="0">
                                <tr runat="server" ID="TableRow9" Visible="true">
                                    <td Width="150px">
                                        <asp:Label ID="Label14" runat="server" class="cssLabel" Text="Bank Name"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtBank_Name" class="cssTextboxLong" ></asp:TextBox>
                                        &nbsp;&nbsp;&nbsp;
                                        <asp:Label ID="Label8" runat="server" class="cssLabel" Text="*" ForeColor="#FF3300"></asp:Label>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtBank_Name"
                                            ErrorMessage="Please Enter Bank Name" Display="Dynamic" class="cssRequiredFieldValidator">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr runat="server" ID="TableRow1" Visible="true">
                                    <td Width="150px">
                                        <asp:Label ID="Label2" runat="server" class="cssLabel" Text="Bank Branch"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtBank_Branch" class="cssTextboxLong"></asp:TextBox>
                                           
                                        &nbsp;&nbsp;&nbsp;
                                        <asp:Label ID="Label4" runat="server" class="cssLabel" Text="*" ForeColor="#FF3300"></asp:Label>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtBank_Branch"
                                            ErrorMessage="Please Enter Bank Branch" Display="Dynamic" class="cssRequiredFieldValidator">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr runat="server" ID="TableRow2" Visible="true">
                                    <td Width="150px">
                                        <asp:Label ID="Label3" runat="server" class="cssLabel" Text="BSR Code"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtBsrcode" class="cssTextbox" MaxLength="7" 
                                           ></asp:TextBox>
                                        &nbsp;&nbsp;&nbsp;
                                        <asp:Label ID="Label5" runat="server" class="cssLabel" Text="*" ForeColor="#FF3300"></asp:Label>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtBsrcode"
                                            ErrorMessage="Please Enter Bsrcode" Display="Dynamic" class="cssRequiredFieldValidator">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:Button runat="server" ID="btnSave" Text="Save" class="cssButton" OnClick="btnSave_OnClick" />
                                        &nbsp;
                                        <asp:Button runat="server" ID="btnCancel" Text="Cancel" class="cssButton" OnClick="btnCancel_OnClick"
                                            CausesValidation="false" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr height="5px">
                    <td runat="server" ID="tdGrid">
                        <asp:Label ID="lblGridMessage" runat="server" class="cssLabel"></asp:Label>
                        <asp:DataGrid runat="server" ID="dgBank_Master" AutoGenerateColumns="false" DataKeyField="Bank_ID"
                            Width="100%" CellSpacing="2" cellpadding="2" ShowHeader="true" OnItemCommand="dgBank_Master_OnItemCommand">
                            <HeaderStyle CssClass="cssGridHeader" />
                            <ItemStyle CssClass="cssGridItemStyle" />
                            <AlternatingItemStyle CssClass="cssGridAlternatingItemStyle" />
                            <FooterStyle />
                            <Columns>
                                <asp:BoundColumn DataField="" HeaderText="No">
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" Width="20px" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="Bank_Name" HeaderText="Bank Name">
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="Bank_Branch" HeaderText="Branch">
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" Width="150px" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="BSRCode" HeaderText="BSR Code">
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" Width="150px" />
                                </asp:BoundColumn>
                                <asp:TemplateColumn>
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="20px" />
                                    <ItemTemplate>
                                        <asp:ImageButton runat="server" ImageUrl="~/Images/edit_icon.png" ID="btnEdit" class="cssEditDeleteImage"
                                            CommandName="EditCommand" />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="20px" />
                                    <ItemTemplate>
                                        <asp:ImageButton runat="server" ID="btnDelete" ImageUrl="~/Images/Delete_icon.png"
                                            class="cssEditDeleteImage" CommandName="DeleteCommand" OnClientClick="return DeleteConfirmation('Bank')" />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                            </Columns>
                        </asp:DataGrid>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:HiddenField  ID="hdnBank_ID" runat="server" />
                        <asp:HiddenField ID="hdnConnString" runat="server" />
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
