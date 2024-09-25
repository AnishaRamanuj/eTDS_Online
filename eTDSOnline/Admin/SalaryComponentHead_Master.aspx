<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="SalaryComponentHead_Master.aspx.cs" Inherits="Forms._salarycomponenthead" %>

<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <%--<script type="text/javascript" src="../tab/jquery.min.js"></script>
    <script type="text/javascript" src="../tab/jquery-ui.min.js"></script>
    <link type="text/css" href="../tab/jquery-ui.css" rel="Stylesheet" />
    <script type="text/javascript">
        $(function () {
            $("#myTabs").tabs();
        });
    </script>--%>
    <asp:UpdatePanel runat="server" ID="UpdatePanel4">
        <ContentTemplate>
            <asp:Table ID="Table1" runat="server" Width="100%" Height="600px" CellPadding="5"
                CellSpacing="0">
                <asp:TableRow Height="5px">
                    <asp:TableCell CssClass="cssPageTitle">
                        <asp:Label ID="Label1" runat="server" Text="Salary Head"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow Height="5px">
                    <asp:TableCell>
                        <UC:MessageControl runat="server" ID="ucMessageControl" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow Height="5px">
                    <asp:TableCell runat="server" ID="tdSearch" Visible="true">
                        <fieldset class="login">
                            <legend>Search</legend>
                            <asp:Table ID="Table3" runat="server" Width="100%" CellPadding="3" CellSpacing="0">
                                <asp:TableRow runat="server" ID="TableRow9" Visible="true">
                                    <asp:TableCell Width="100px">
                                        <asp:Label ID="Label14" runat="server" CssClass="cssLabel" Text="Search Type"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList runat="server" ID="ddlSearchGroupHead" CssClass="cssDropDownList">
                                            <asp:ListItem Value="" Text="(Select Head)"></asp:ListItem>
                                            <asp:ListItem Value="Addition" Text="Addition"></asp:ListItem>
                                            <asp:ListItem Value="Deduction" Text="Deduction"></asp:ListItem>
                                            <asp:ListItem Value="Yearly" Text="Yearly"></asp:ListItem>
                                            <asp:ListItem Value="Variable" Text="Variable"></asp:ListItem>
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableCell>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Button runat="server" ID="btnSearch" Text="Search" CssClass="cssButton" OnClick="btnSearch_OnClick" />
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </fieldset>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow Height="5px">
                    <asp:TableCell>
                        <asp:Button runat="server" ID="btnAddNew" CssClass="cssButton" Text="Add New" OnClick="btnAddNew_OnClick" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow Height="5px">
                    <asp:TableCell runat="server" ID="tdGrid">
                        <fieldset class="login">
                            <legend>Salary Head Component Type List</legend>
                            <asp:Label runat="server" ID="lblGridMessage" CssClass="cssLabel"></asp:Label>
                            <asp:DataGrid runat="server" ID="dgHeadMaster" AutoGenerateColumns="false" DataKeyField="Head_ID"
                                Width="100%" CellSpacing="0" CellPadding="2" ShowHeader="true" OnItemCommand="dgHeadMaster_OnItemCommand">
                                <HeaderStyle CssClass="cssGridHeader" />
                                <ItemStyle CssClass="cssGridItemStyle" />
                                <AlternatingItemStyle CssClass="cssGridAlternatingItemStyle" />
                                <FooterStyle />
                                <Columns>
                                    <asp:BoundColumn DataField="" HeaderText="No">
                                        <HeaderStyle BorderColor="#dbdbdb" Width="30px" HorizontalAlign="Center" />
                                        <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" />
                                    </asp:BoundColumn>
                                    <asp:BoundColumn DataField="Head_Name" HeaderText="Head Name">
                                        <HeaderStyle BorderColor="#dbdbdb" />
                                        <ItemStyle BorderColor="#dbdbdb" />
                                    </asp:BoundColumn>
                                    <asp:BoundColumn DataField="Head_Group" HeaderText="Head Type">
                                        <HeaderStyle BorderColor="#dbdbdb" />
                                        <ItemStyle BorderColor="#dbdbdb" Width="100px" />
                                    </asp:BoundColumn>
                                    <asp:BoundColumn DataField="Calc_Gross" HeaderText="Calc Gross">
                                        <HeaderStyle BorderColor="#dbdbdb" />
                                        <ItemStyle BorderColor="#dbdbdb" Width="100px" />
                                    </asp:BoundColumn>
                                    <asp:TemplateColumn HeaderText="Computation">
                                        <HeaderStyle BorderColor="#dbdbdb" />
                                        <ItemStyle BorderColor="#dbdbdb" Width="15px" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:CheckBox runat="server" ID="chkCheckComputation" Enabled="false" Checked='<%# Convert.ToBoolean(Eval("Computation")) %>' />
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn HeaderText="Section10">
                                        <HeaderStyle BorderColor="#dbdbdb" />
                                        <ItemStyle BorderColor="#dbdbdb" Width="15px" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:CheckBox runat="server" ID="chkCheckSection10" Enabled="false" Checked='<%# Convert.ToBoolean(Eval("Section10")) %>' />
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn HeaderText="Cnyce Type">
                                        <HeaderStyle BorderColor="#dbdbdb" />
                                        <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="80px" />
                                        <ItemTemplate>
                                            <asp:CheckBox runat="server" ID="chkCheckConveyance_Type" Enabled="false" Checked='<%# Convert.ToBoolean(Eval("Conveyance_Type")) %>' />
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn HeaderText="Head_Calculated_ID" Visible="false">
                                        <HeaderStyle BorderColor="#dbdbdb" />
                                        <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="80px" />
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblHead_Calculated_ID" Text='<%# Eval("Head_Calculated_ID") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
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
                                                CssClass="cssEditDeleteImage" CommandName="DeleteCommand" OnClientClick="return DeleteConfirmation('head')" />
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                </Columns>
                            </asp:DataGrid>
                        </fieldset>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow Height="5px">
                    <asp:TableCell runat="server" ID="tdAddorEdit">
                        <fieldset class="login">
                            <legend>Add or Edit</legend>
                            <asp:Table ID="tbladd" runat="server" Width="100%" CellPadding="2" CellSpacing="0">
                                <asp:TableRow runat="server" ID="TableRow1" Height="30px">
                                    <asp:TableCell Width="300px">
                                        <asp:Label ID="Label13" runat="server" CssClass="cssLabel" Text="Salary Head Component type"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList runat="server" ID="ddlGroupHead" CssClass="cssDropDownList">
                                            <asp:ListItem Value="" Text="(Select Head)"></asp:ListItem>
                                            <asp:ListItem Value="Addition" Text="Addition" Selected="True"></asp:ListItem>
                                            <asp:ListItem Value="Deduction" Text="Deduction"></asp:ListItem>
                                            <asp:ListItem Value="Yearly" Text="Yearly"></asp:ListItem>
                                            <asp:ListItem Value="Variable" Text="Variable"></asp:ListItem>
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow runat="server" ID="TableRow2" Height="30px">
                                    <asp:TableCell>
                                        <asp:Label ID="Label2" runat="server" CssClass="cssLabel" Text="Salary Head"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox runat="server" ID="txtHeadName" CssClass="cssTextbox"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell Width="30px" RowSpan="6">
                                    </asp:TableCell>
                                    <asp:TableCell RowSpan="6" VerticalAlign="Top">
                                        <br />
                                        <br />
                                        <fieldset class="login">
                                            <legend>Head is applicable in following months</legend>
                                            <%--<asp:Label ID="Label3" runat="server" CssClass="cssLabel" Font-Bold="true" Text="Head is applicable in following months"></asp:Label>--%>
                                            <asp:Table ID="Table2" runat="server" Width="100%">
                                                <asp:TableRow>
                                                    <asp:TableCell Width="33%">
                                                        <asp:CheckBox runat="server" ID="chkApril" Checked="True" Text="April" />
                                                    </asp:TableCell>
                                                    <asp:TableCell Width="33%">
                                                        <asp:CheckBox runat="server" ID="chkAugust" Checked="True" Text="August" />
                                                    </asp:TableCell>
                                                    <asp:TableCell Width="33%">
                                                        <asp:CheckBox runat="server" ID="chkDecember" Checked="True" Text="December" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow>
                                                    <asp:TableCell>
                                                        <asp:CheckBox runat="server" ID="chkMay" Checked="True" Text="May" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:CheckBox runat="server" ID="chkSeptember" Checked="True" Text="September" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:CheckBox runat="server" ID="chkJanuary" Checked="True" Text="January" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow>
                                                    <asp:TableCell>
                                                        <asp:CheckBox runat="server" ID="chkJune" Checked="True" Text="June" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:CheckBox runat="server" ID="chkOctober" Checked="True" Text="October" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:CheckBox runat="server" ID="chkFebruary" Checked="True" Text="February" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow Visible="true">
                                                    <asp:TableCell Width="33%">
                                                        <asp:CheckBox runat="server" ID="chkJuly" Checked="True" Text="July" />
                                                    </asp:TableCell>
                                                    <asp:TableCell Width="33%">
                                                        <asp:CheckBox runat="server" ID="chkNovember" Checked="True" Text="November" />
                                                    </asp:TableCell>
                                                    <asp:TableCell Width="33%">
                                                        <asp:CheckBox runat="server" ID="chkMarch" Checked="True" Text="March" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                            </asp:Table>
                                        </fieldset>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow runat="server" ID="TableRow3" Height="30px">
                                    <asp:TableCell>
                                        <asp:Label ID="Label4" runat="server" CssClass="cssLabel" Text="Head Name Represents as  "></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <%-- <asp:CheckBox runat="server" ID="chkConveyance_Type" />--%>
                                        <asp:DropDownList ID="drpSectionType" runat="server" CssClass="cssDropDownList">
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow runat="server" ID="TableRow4" Height="30px">
                                    <asp:TableCell>
                                        <asp:Label ID="Label5" runat="server" CssClass="cssLabel" Text="Allow Manual Change in Payslip "></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:CheckBox runat="server" ID="chkManual" />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow runat="server" ID="TableRow5" Height="30px">
                                    <asp:TableCell>
                                        <asp:Label ID="Label6" runat="server" CssClass="cssLabel" Text="Show as Allowance U/S Section 10"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:CheckBox runat="server" ID="chkSection10" />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow runat="server" ID="TableRow6" Height="30px">
                                    <asp:TableCell>
                                        <asp:Label ID="Label9" runat="server" CssClass="cssLabel" Text="Is Head Taxable"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:CheckBox runat="server" ID="chkComputation" />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow runat="server" ID="TableRow7" Height="30px" Visible="false">
                                    <asp:TableCell>
                                        <asp:Label ID="Label10" runat="server" CssClass="cssLabel" Text="Allowance Projection"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:CheckBox runat="server" ID="chkProjection" Checked="true" />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow runat="server" ID="TableRow8" Height="30px">
                                    <asp:TableCell>
                                        <asp:Label ID="Label8" runat="server" CssClass="cssLabel" Text="Round to "></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList runat="server" ID="ddlRounding_Modes" CssClass="cssDropDownList">
                                            <asp:ListItem Value="" Text="(Select Round Mode)"></asp:ListItem>
                                            <asp:ListItem Value="0" Text="Rupees 1"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="Paise 0.5"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="Paise 0.05"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="ddlRounding_Modes"
                                            ErrorMessage="Please mode" CssClass="cssRequiredFieldValidator" Display="Dynamic">
                                        </asp:RequiredFieldValidator>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow runat="server" ID="TableRow10" Height="30px">
                                    <asp:TableCell>
                                        <asp:Label ID="Label15" runat="server" CssClass="cssLabel" Text="Show the above head in "></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList runat="server" ID="ddlReport" CssClass="cssDropDownList">
                                            <asp:ListItem Value="" Text="(Select Report Type)"></asp:ListItem>
                                            <asp:ListItem Value="0" Text="Payslip"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="Salary ST"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="Payslip and Salary ST"></asp:ListItem>
                                            <asp:ListItem Value="3" Text="None"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlReport"
                                            ErrorMessage="Please select report" CssClass="cssRequiredFieldValidator" Display="Dynamic">
                                        </asp:RequiredFieldValidator>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableCell VerticalAlign="Top">
                                        <asp:Label ID="Label7" runat="server" CssClass="cssLabel" Text="Calculate above head on "></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell ColumnSpan="3">
                                        <asp:Table runat="server" Width="100%">
                                            <asp:TableRow>
                                                <asp:TableCell>
                                                    <asp:DropDownList runat="server" ID="ddlCalculationHead" CssClass="cssDropDownList"
                                                        OnTextChanged="grpCalculareAboveHead_OnCheckedChanged" AutoPostBack="true">
                                                        <asp:ListItem Text="No Formula" Value="Normal"></asp:ListItem>
                                                        <asp:ListItem Text="Gross Salary" Value="Gross"></asp:ListItem>
                                                        <asp:ListItem Text="Percentage" Value="Percentage"></asp:ListItem>
                                                    </asp:DropDownList>
                                                    &nbsp;
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ControlToValidate="ddlCalculationHead"
                                                        ErrorMessage="Please choose calculation above head on" CssClass="cssRequiredFieldValidator"
                                                        Display="Dynamic">
                                                    </asp:RequiredFieldValidator>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow>
                                                <asp:TableCell>
                                                    <asp:Table runat="server" Width="100%" ID="tblGrid">
                                                        <asp:TableRow>
                                                            <asp:TableCell ColumnSpan="2">
                                                                <asp:Label ID="lblHeadNameOnCalculation" runat="server" CssClass="cssLabel"></asp:Label>
                                                                <asp:TextBox runat="server" ID="txtCalculatePercentage" Height="20px" BorderColor="Gray"
                                                                    BackColor="White" Width="50px" CssClass="cssTextbox"></asp:TextBox>
                                                                <asp:Label ID="lblHeadNameOnCalculationMessage" runat="server" CssClass="cssLabel"></asp:Label>
                                                                <asp:TextBox runat="server" ID="txtLimit" Height="20px" BorderColor="Gray" BackColor="White"
                                                                    Width="50px" CssClass="cssTextbox" Visible="false"></asp:TextBox>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtLimit"
                                                                    CssClass="cssRequiredFieldValidator" ValidationExpression="\d+" Display="Static"
                                                                    EnableClientScript="true" ErrorMessage="Numbers only" runat="server" />
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow>
                                                            <asp:TableCell ColumnSpan="2">
                                                                <asp:Label runat="server" ID="lblGrid" CssClass="cssLabel"></asp:Label>
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow runat="server" ID="trGrid">
                                                            <asp:TableCell VerticalAlign="Top">
                                                                <fieldset class="login">
                                                                    <legend>Additions Head</legend>
                                                                    <asp:DataGrid runat="server" ID="dgAddition" AutoGenerateColumns="false" DataKeyField="Head_ID"
                                                                        Width="100%" CellSpacing="0" CellPadding="0" ShowHeader="false" OnItemCommand="dgAddition_OnItemCommand">
                                                                        <HeaderStyle CssClass="cssGridHeader" />
                                                                        <ItemStyle CssClass="cssGridItemStyle" />
                                                                        <AlternatingItemStyle CssClass="cssGridAlternatingItemStyle" />
                                                                        <FooterStyle />
                                                                        <Columns>
                                                                            <asp:BoundColumn DataField="Head_Name" HeaderText="Head Name">
                                                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                                                <ItemStyle BorderColor="#dbdbdb" />
                                                                            </asp:BoundColumn>
                                                                            <%-- <asp:BoundColumn DataField="Head_Group" HeaderText="Group">
                                                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                                                <ItemStyle BorderColor="#dbdbdb" />
                                                                            </asp:BoundColumn>--%>
                                                                            <asp:TemplateColumn>
                                                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                                                <ItemStyle BorderColor="#dbdbdb" Width="15px" HorizontalAlign="Center" />
                                                                                <ItemTemplate>
                                                                                    <asp:CheckBox runat="server" ID="chkCheckAddition" />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateColumn>
                                                                        </Columns>
                                                                    </asp:DataGrid>
                                                                </fieldset>
                                                            </asp:TableCell>
                                                            <asp:TableCell VerticalAlign="Top">
                                                                <fieldset class="login">
                                                                    <legend>Variables Head</legend>
                                                                    <asp:DataGrid runat="server" ID="dgVariable" AutoGenerateColumns="false" DataKeyField="Head_ID"
                                                                        Width="100%" CellSpacing="2" CellPadding="2" ShowHeader="false" OnItemCommand="dgVariable_OnItemCommand">
                                                                        <HeaderStyle CssClass="cssGridHeader" />
                                                                        <ItemStyle CssClass="cssGridItemStyle" />
                                                                        <AlternatingItemStyle CssClass="cssGridAlternatingItemStyle" />
                                                                        <FooterStyle />
                                                                        <Columns>
                                                                            <asp:BoundColumn DataField="Head_Name" HeaderText="Head Name">
                                                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                                                <ItemStyle BorderColor="#dbdbdb" />
                                                                            </asp:BoundColumn>
                                                                            <%--<asp:BoundColumn DataField="Head_Group" HeaderText="Group">
                                                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                                                <ItemStyle BorderColor="#dbdbdb" />
                                                                            </asp:BoundColumn>--%>
                                                                            <asp:TemplateColumn>
                                                                                <HeaderStyle BorderColor="#dbdbdb" Width="15px" />
                                                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" />
                                                                                <ItemTemplate>
                                                                                    <asp:CheckBox runat="server" ID="chkCheckVariable" />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateColumn>
                                                                        </Columns>
                                                                    </asp:DataGrid>
                                                                </fieldset>
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableCell>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Button runat="server" ID="btnSave" Text="Save" CssClass="cssButton" OnClick="btnSave_OnClick" />
                                        &nbsp;
                                        <asp:Button runat="server" ID="btnCancel" Text="Cancel" CssClass="cssButton" OnClick="btnCancel_OnClick"
                                            CausesValidation="false" />
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </fieldset>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:HiddenField runat="server" ID="hdnHeadID" />
                        <asp:HiddenField runat="server" ID="hdnPercentage_ID" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
