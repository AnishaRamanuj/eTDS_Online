<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="ManageDeductee_Master.aspx.cs"
    Inherits="Admin_Deductee_Master" %>

<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl"
    TagPrefix="UC" %>
<%@ Import Namespace="System.Drawing" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            $(document).on('click', '[id*=btnAddNew]', function (e) {
                //Alltogo();
            });

            $(document).on('change', '[id*=drp_State]', function (e) {
                DropDown_State();
            });

            $(document).on('change', '[id*=drp_Type]', function (e) {
                DropDown_SelectType();
            });

            $(document).on('change', '[id*=drp_TdsRateNRI]', function (e) {
                DropDown_TDS_Rate_For_NRI();
            });
            $(document).on('change', '[id*=chk_IsPayeeNri]', function (e) {
                NRI();
            });

            $(document).on('change', '[id*=radio_TDSRateFrom]', function (e) {
                checkhiddenfiledRadiovalue();
            });

            $(document).on('click', '[id*=btnSave]', function (e) {
                if (document.getElementById("<%=chk_PayeeIndividual.ClientID %>").checked == true) {
                    $('#<%= hdnCheckindivisulchecked.ClientID %>').val('1');
                } else { $('#<%= hdnCheckindivisulchecked.ClientID %>').val('0'); }
            });           
        });

        function pageLoad() {
            $(':text').bind('keydown', function (e) { //on keydown for all textboxes

                if (e.keyCode == 13) //if this is enter key

                    e.preventDefault();

            });
        }

        function Alltogo() {

            DropDown_SelectType();
            checkhiddenfiledRadiovalue();
            DropDown_TDS_Rate_For_NRI();
            DropDown_State();
            NRI();
        }

        function DropDown_State() {
            var param = $('#<%= drp_State.ClientID %>').val();
            //$('#<%=chk_IsPayeeNri.ClientID%>').prop('disabled', true);
            if (param == "99") {
                $('#<%=chk_IsPayeeNri.ClientID%>').prop('checked', true);
<%--                $('#<%=drp_Country.ClientID%>').prop('disabled', false);
                $('#<%=drp_TdsRateNRI.ClientID%>').prop('disabled', false);
                $("*[name$='radio_TDSRateFrom']").attr("disabled", "disabled");--%>
            }
            else {
                $('#<%=chk_IsPayeeNri.ClientID%>').prop('checked', false);
<%--                $('#<%=drp_Country.ClientID%>').prop('disabled', true);
                $('#<%=drp_TdsRateNRI.ClientID%>').prop('disabled', true);
                $("*[name$='radio_TDSRateFrom']").removeAttr("disabled");--%>
            }
        }

        function NRI() {
            if (document.getElementById("<%=chk_IsPayeeNri.ClientID %>").checked == true) {
                $('#<%=drp_State.ClientID%>').val(99);
                $('#<%=fldNRI.ClientID%>').show();
                $('#<%=fldRT.ClientID%>').hide();
                var AspRadio = document.getElementById('<%= radio_TDSRateFrom.ClientID %>');
                var AspRadio_ListItem = document.getElementsByTagName('input');
                for (var i = 0; i < AspRadio_ListItem.length; i++) {

                    if (AspRadio_ListItem[i].checked) {

                        AspRadio_ListItem[i].value = 0;
                    }

                }
            }
            else {
                $('#<%=chk_IsPayeeNri.ClientID%>').prop('checked', false);
                $('#<%=fldNRI.ClientID%>').hide();
                $('#<%=fldRT.ClientID%>').show();
                var s = $('#<%=drp_State.ClientID%>').val();
                if (s == '99') {
                    $('#<%=drp_State.ClientID%>').val(0);
                }
            }
        }

        function DropDown_TDS_Rate_For_NRI() {
            var param = $('#<%= drp_TdsRateNRI.ClientID %>').val();
            if (param == "If TDS rate is as per DTAA B") {
                $('#MasterPage_radio_TDSRateFrom_1').prop('checked', true);
            }
            else {
                $('#MasterPage_radio_TDSRateFrom_0').prop('checked', true);
            }

            checkhiddenfiledRadiovalue();
        }



        function DropDown_SelectType() {

            var param = $('#<%= drp_Type.ClientID %>').val();
            if (param == "Others") {
                $('#<%=chk_PayeeIndividual.ClientID%>').prop('disabled', false);
            }
            else {
                $('#<%=chk_PayeeIndividual.ClientID%>').prop('disabled', true);
                $('#<%=chk_PayeeIndividual.ClientID%>').prop('checked', false);
            }
        }

        function checkhiddenfiledRadiovalue() {
            var param = $('#<%=radio_TDSRateFrom.ClientID %> input:checked').val();
            if (param == "0") {
                $('#<%=txt_TDSRate.ClientID%>').prop('disabled', true);
                $('#<%=txt_SurCharge.ClientID%>').prop('disabled', true);
            }
            else {
                $('#<%=txt_TDSRate.ClientID%>').prop('disabled', false);
                $('#<%=txt_SurCharge.ClientID%>').prop('disabled', false);
            }
            $('#<%= hdnRadiovalue.ClientID %>').val(param);

            var radio1 = $('#<%= hdnRadiovalue.ClientID %>').val();
            if (radio1 == "1") {
                $('#<%=txt_TDSRate.ClientID%>').prop('disabled', false);
                $('#<%=txt_SurCharge.ClientID%>').prop('disabled', false);
            }
            else {
                $('#<%=txt_TDSRate.ClientID%>').prop('disabled', true);
                $('#<%=txt_SurCharge.ClientID%>').prop('disabled', true);
            }
        }

        //Custom Validate Function For Country
        function ValidateCountryDropDown(sender, args) {

            var parm = document.getElementById('<%=drp_Country.ClientID%>');
            var sel = parm.options[parm.selectedIndex].value;
            if (document.getElementById("<%=chk_IsPayeeNri.ClientID %>").checked == true) {
                if (sel == "0")
                { args.IsValid = false; }
                else
                { args.IsValid = true; }
            }
        }
        //Custom Validate TDSRATEFORNRIDropDown Function For Country
        function ValidateTDSRATEFORNRIDropDown(sender, args) {

            var parm = document.getElementById('<%=drp_TdsRateNRI.ClientID%>');
            var sel = parm.options[parm.selectedIndex].value;
            if (document.getElementById("<%=chk_IsPayeeNri.ClientID %>").checked == true) {
                if (sel == "0")
                { args.IsValid = false; }
                else
                { args.IsValid = true; }
            }
        }

        function ValidateTDSRateSurcharge(sender, args) {


            var AspRadio = document.getElementById('<%= radio_TDSRateFrom.ClientID %>');
            var AspRadio_ListItem = document.getElementsByTagName('input');
            for (var i = 0; i < AspRadio_ListItem.length; i++) {

                if (AspRadio_ListItem[i].checked) {

                    var checkname = AspRadio_ListItem[i].value;

                    if (checkname == '1') {
                        var TDSRate = document.getElementById('<%=txt_TDSRate.ClientID%>').value;
                        var SurCharge = document.getElementById('<%=txt_SurCharge.ClientID%>').value;
                        if (TDSRate == "" || SurCharge == "") {
                            args.IsValid = false;
                        }
                        else
                        { args.IsValid = true; }
                    }
                } //end if

            } // end for
        }

        function GetRadioButtonSelectedValue() {


        } //end function
                
        //Function For Allow TextBox Only Numbers
        function isNumberKey(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 46 || charCode > 57)) {
                return false;
            }
            return true;
        }
        var specialChars = "<>@!#$%^&*()_+[]{}?:;|'\"\\,./~`-=";
        var check = function (string) {
            for (i = 0; i < specialChars.length; i++) {
                if (string.indexOf(specialChars[i]) > -1) {
                    return true
                }
            }
            return false;
        }
        function ValidateContactNo(sender, args) {
            var ContactNo = $("[id*=txtTaxIdentificationno]").val().split('');
            var sel = 0;
            if (ContactNo.length > 0) {
                if (check(ContactNo[0]) == true)
                { sel = '1'; }
            }


            if (sel == "1")
            { args.IsValid = false; }
            else
            { args.IsValid = true; }
        }
    
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage"
    runat="Server">
    <asp:UpdatePanel runat="server" ID="UpdatePanel2">
        <ContentTemplate>
            <table id="Table1" runat="server" width="100%" height="auto"
                cellpadding="5" cellspacing="0">
                <tr height="5px">
                    <td class="cssPageTitle">
                        <asp:Label ID="Label1" runat="server" Text="Deductee"></asp:Label>
                    </td>
                </tr>
                <tr height="0px">
                    <td>
                        <UC:MessageControl runat="server" ID="ucMessageControl" />
                    </td>
                </tr>
                <tr>
                    <td id="tblSearch" runat="server">
                        <table width="100%" cellpadding="3" cellspacing="0">
                            <tr runat="server" id="TableRow1">
                                <td width="120px">
                                    <asp:Label ID="Label46" runat="server" CssClass="cssLabel" Text="Deductee Name"></asp:Label>
                                </td>
                                <td colspan="3">
                                    <table id="Table11" runat="server" width="100%" cellpadding="0"
                                        cellspacing="0">
                                        <tr>
                                            <td>
                                                <asp:TextBox runat="server" ID="txtSearchName" CssClass="cssTextbox"
                                                    Width="300px"></asp:TextBox>
                                            </td>
                                            <td width="100px">
                                                <asp:Button runat="server" ID="btnSearch" Text="Search" CssClass="cssButton"
                                                    OnClick="btnSearch_Click" />
                                            </td>
                                            <td>
                                                <asp:Button runat="server" ID="btnAddNew" OnClick="btnAddNew_OnClick"
                                                    CssClass="cssButton" Text="Add New Deductee" />
                                                <asp:Button runat="server" ID="btnBulkPAN" CssClass="cssButton"
                                                    Text="Bulk Pan Verification" OnClick="btnBulkPAN_Click" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr runat="server" id="TableRow5">
                                <td>
                                    <asp:Label ID="Label47" runat="server" CssClass="cssLabel" Text="Filter By"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlSearchReasons" CssClass="cssDropDownList">
                                        <asp:ListItem Selected="True" Value="0">(Select Reasons)</asp:ListItem>
                                        <asp:ListItem>Presc.Rt</asp:ListItem>
                                        <asp:ListItem>Lower Rt. Under Section 197 A</asp:ListItem>
                                        <asp:ListItem>No Tax only for sec 194, 194A, 194EE And 193 B</asp:ListItem>
                                        <asp:ListItem>No Tax on A/c of pmt under sec 197A Z</asp:ListItem>
                                        <asp:ListItem>Non-Availability of PAN C</asp:ListItem>
                                        <asp:ListItem>Transporter and valid PAN T</asp:ListItem>
                                        <asp:ListItem>Software acquired under section 194J S</asp:ListItem>
                                    </asp:DropDownList>
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:DropDownList runat="server" ID="ddlSearchPAN" CssClass="cssDropDownList">
                                        <asp:ListItem Selected="True" Value="0">(Select PAN Status)</asp:ListItem>
                                        <asp:ListItem>InValid PAN</asp:ListItem>
                                        <asp:ListItem>Valid PAN</asp:ListItem>
                                        <asp:ListItem>PAN Not Available</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td id="tblDeducteeDetails" runat="server">
                        <table width="100%" cellpadding="3" cellspacing="0">
                            <tr>
                                <td>
                                    <asp:ValidationSummary ID="ValidationSummary1" ShowMessageBox="true"
                                        ShowSummary="false" ValidationGroup="ValidThisPage" runat="server" />
                                    <fieldset style="border: solid 1px black; padding: 10px;">
                                        <legend>Deductee Details</legend>
                                        <table width="100%">
                                            <tr>
                                                <td>
                                                    <span style="color: Red">
                                                        Name</span>
                                                </td>
                                                <td style="margin-left: 80px">
                                                    <asp:TextBox ID="txt_Name" runat="server" Width="300px" CssClass="cssTextbox"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="ValidThisPage"
                                                        runat="server" Display="None" ControlToValidate="txt_Name"
                                                        ErrorMessage="Please Enter Name !"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    Alias
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_Alias" runat="server" Width="300px" CssClass="cssTextbox"></asp:TextBox>
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblduplicateError"></asp:Label>
                                                </td>                                               
                                            </tr>
                                            <tr>
                                                <td>
                                                    Flat No
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_FlatNo" runat="server" Width="300px" CssClass="cssTextbox"></asp:TextBox>
                                                </td>
                                                <td>
                                                    Bldg Name
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_BldgName" runat="server" Width="300px" CssClass="cssTextbox"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Street
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_Street" runat="server" Width="300px" CssClass="cssTextbox"></asp:TextBox>
                                                </td>
                                                <td>
                                                    City
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_City" runat="server" Width="300px" CssClass="cssTextbox"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Is Payee NRI
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chk_IsPayeeNri" runat="server" CssClass="cssCheckBox" />
                                                </td>
                                                <td>
                                                    Pin Code
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_PinCode" runat="server" onkeypress="return isNumberKey(event)"
                                                        oncopy="return false" onpaste="return false" oncut="return false"
                                                        Width="100px" MaxLength="6" CssClass="cssTextbox"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Branch
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="drp_Branch" runat="server" Width="300px"
                                                        CssClass="cssDropDownList">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    Email
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_Email" runat="server" Width="300px" CssClass="cssTextbox"></asp:TextBox>
                                                    <asp:RegularExpressionValidator Display="None" ControlToValidate="txt_Email"
                                                        ValidationGroup="ValidThisPage" ID="RegularExpressionValidator1"
                                                        runat="server" ErrorMessage="Please Enter Valid Email ID !"
                                                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Contact No
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtContact" runat="server" Width="150px" MaxLength="15"
                                                        onkeypress="return isNumberKey(event)" CssClass="cssTextbox"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <span style="color: Red;">
                                                        PAN</span>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_PanNo" runat="server" Width="100px" AutoPostBack="true"
                                                        MaxLength="10" OnTextChanged="txt_PanNo_TextChanged" Style="text-transform: uppercase"
                                                        CssClass="cssTextbox"></asp:TextBox>
                                                    <asp:Label ID="lblPanVerified" runat="server" Text=""></asp:Label>
                                                    <asp:RegularExpressionValidator Display="None" ControlToValidate="txt_PanNo"
                                                        ValidationGroup="ValidThisPage" ID="RegularExpressionValidator2"
                                                        runat="server" ErrorMessage="Please Enter 10 Digit PAN Number"
                                                        ValidationExpression="^[\s\S]{10,10}$"></asp:RegularExpressionValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Mobile No
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_MobileNo" onkeypress="return isNumberKey(event)"
                                                        runat="server" Width="100px" MaxLength="10" CssClass="cssTextbox"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <span style="color: Red">
                                                        State</span>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="drp_State" runat="server" Width="300px"
                                                        CssClass="cssDropDownList">
                                                    </asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ValidationGroup="ValidThisPage"
                                                        runat="server" Display="None" ControlToValidate="drp_State"
                                                        ErrorMessage="Please Select State !" InitialValue="0"></asp:RequiredFieldValidator>
                                                </td>

                                            </tr>
                                        </table>
                                    </fieldset>
                                    <fieldset style="border: solid 1px black; padding: 10px;">
                                        <legend>TDS Details</legend>
                                        <table width="100%">
                                            <tr>
                                                <td>
                                                    <span style="color: Red">
                                                        Nature</span>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="drp_Nature" runat="server" Width="300px"
                                                        CssClass="cssDropDownList">
                                                    </asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="ValidThisPage"
                                                        runat="server" Display="None" ControlToValidate="drp_Nature"
                                                        InitialValue="0" ErrorMessage="Please Select Nature !"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <span style="color: Red">
                                                        Type</span>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="drp_Type" runat="server" Width="300px"
                                                        CssClass="cssDropDownList">
                                                        <asp:ListItem Value="0" Selected="True">Select Type</asp:ListItem>
                                                        <asp:ListItem>Others</asp:ListItem>
                                                        <asp:ListItem>Company</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="ValidThisPage"
                                                        runat="server" Display="None" ControlToValidate="drp_Type"
                                                        InitialValue="0" ErrorMessage="Please Select Type !"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                    <div id="PayeeIndividual" runat="server">
                                                        <asp:CheckBox ID="chk_PayeeIndividual" runat="server" Text="Is Payee Individual"
                                                            CssClass="cssCheckBox" />
                                                    </div>
                                                </td>
                                                <td>
                                                    Application For All Companies
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chk_ApplicationToAll" runat="server" CssClass="cssCheckBox" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span style="color: Red">
                                                        Reasons</span>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="drp_Reasons" runat="server" Width="300px"
                                                        CssClass="cssDropDownList">
                                                        <asp:ListItem Selected="True" Value="0">(Select Reasons)</asp:ListItem>
                                                        <asp:ListItem>Presc.Rt.</asp:ListItem>
                                                        <asp:ListItem>Lower Rt. Under Section 197 A</asp:ListItem>
                                                        <asp:ListItem>No Tax only for sec 194, 194A, 194EE And 193 B</asp:ListItem>
                                                        <asp:ListItem>No Tax on A/c of pmt under sec 197A Z</asp:ListItem>
                                                        <asp:ListItem>Non-Availability of PAN C</asp:ListItem>
                                                        <asp:ListItem>Transporter and valid PAN T</asp:ListItem>
                                                        <asp:ListItem>Software acquired under section 194J S</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ValidationGroup="ValidThisPage"
                                                        runat="server" Display="None" ControlToValidate="drp_Reasons"
                                                        InitialValue="0" ErrorMessage="Please Select Reasons !"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    Certificate
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_Certificate" runat="server" Width="300px"
                                                        CssClass="cssTextbox"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                    <fieldset  id="fldNRI" runat="server"  style="border: solid 1px black; padding: 10px;">
                                        <legend>NRI Details</legend>
                                        <table width="100%">
                                            <tr>
                                                
                                                <td>
                                                    <span style="color: Red">
                                                        Country</span>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="drp_Country" runat="server" Width="300px"
                                                        CssClass="cssDropDownList">
                                                    </asp:DropDownList>
                                                    <asp:CustomValidator ID="CustomValidator1" Display="None" runat="server"
                                                        ValidationGroup="ValidThisPage" ErrorMessage="Please Select Country !"
                                                        ClientValidationFunction="ValidateCountryDropDown"></asp:CustomValidator>
                                                </td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    TDS Rate For NRI
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="drp_TdsRateNRI" runat="server" Width="300px"
                                                        CssClass="cssDropDownList">
                                                        <asp:ListItem Selected="True" Value="0">( Select )</asp:ListItem>
                                                        <asp:ListItem>If TDS rate is as per Income TaxAct A</asp:ListItem>
                                                        <asp:ListItem>If TDS rate is as per DTAA B</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:CustomValidator ID="CustomValidator2" Display="None" runat="server"
                                                        ValidationGroup="ValidThisPage" ErrorMessage="Please Select TDS Rate For NRI !"
                                                        ClientValidationFunction="ValidateTDSRATEFORNRIDropDown"></asp:CustomValidator>
                                                </td>
                                                <td>
                                                    Tax Identification No
                                                </td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="txtTaxIdentificationno" MaxLength="25"
                                                        Width="300px" CssClass="cssTextbox"></asp:TextBox>
                                                    <asp:CustomValidator ID="CustomValidator4" Display="None" runat="server"
                                                        ControlToValidate="txtTaxIdentificationno" ValidationGroup="ValidThisPage"
                                                        ErrorMessage="Please Enter Valid Tax Identification No !" ClientValidationFunction="ValidateContactNo"></asp:CustomValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                    <fieldset id="fldRT" runat="server"  style="border: solid 1px black; padding: 10px;">
                                        <legend style="font-size: 11pt; color: #555; font-weight: bold;">
                                            TDS Rate From</legend>
                                        <table width="100%">
                                            <tr>
                                                <td>
                                                    <table width="100%">
                                                        <tr>
                                                            <td>
                                                                <asp:RadioButtonList ID="radio_TDSRateFrom" runat="server" RepeatDirection="Horizontal"
                                                                    CssClass="cssCheckBox">
                                                                    <asp:ListItem Selected="True" Value="0">Slab</asp:ListItem>
                                                                    <asp:ListItem Value="1">Deductee Master</asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                            <td style="text-align: right">
                                                                TDS Rate
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txt_TDSRate" onkeypress="return isNumberKey(event)"
                                                                    Width="50px" oncopy="return false" onpaste="return false"
                                                                    oncut="return false" runat="server" CssClass="cssTextbox"
                                                                    MaxLength="5"></asp:TextBox>
                                                                <asp:CustomValidator ID="CustomValidator3" Display="None" runat="server"
                                                                    ValidationGroup="ValidThisPage" ErrorMessage="Please Enter TDSRate AND SurCharge !"
                                                                    ClientValidationFunction="ValidateTDSRateSurcharge"></asp:CustomValidator>
                                                            </td>
                                                            <td style="text-align: right">
                                                                SurCharge
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txt_SurCharge" onkeypress="return isNumberKey(event)"
                                                                    runat="server" oncopy="return false" onpaste="return false"
                                                                    oncut="return false" Width="50px" CssClass="cssTextbox" MaxLength="5"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="5">
                                                                <hr />
                                                                <table width="100%">
                                                                    <tr style="text-align: center">
                                                                        <td>
                                                                            <b>Total Amt Paid :
                                                                                <asp:Label ID="lbl_TotalAmtPaid" runat="server" Text="0.00"></asp:Label></b>
                                                                        </td>
                                                                        <td>
                                                                            <b>Total TDS Amt :<asp:Label ID="lbl_TotalTDSAmt" runat="server"
                                                                                Text="0.00"></asp:Label></b>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                    <table width="100%">
                                        <tr>
                                            <td>
                                                <asp:Button runat="server" ID="btnSave" Text="Save" CssClass="cssButton"
                                                    OnClick="btnSave_Click" ValidationGroup="ValidThisPage" />
                                                &nbsp;
                                                <asp:Button runat="server" ID="btnCancel" Text="Cancel" CausesValidation="false"
                                                    CssClass="cssButton" OnClick="btnCancel_Click" />
                                                <asp:HiddenField ID="hdnDeducteeID" Value="" runat="server" />
                                                <asp:HiddenField ID="hdnRadiovalue" runat="server" />
                                                <asp:HiddenField ID="hdnRadiovalue1" runat="server" />
                                                <asp:HiddenField ID="hdnCheckindivisulchecked" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="100%">
                            <tr height="5px">
                                <td runat="server" id="tdGrid">
                                    <asp:Label ID="lblGridMessage" runat="server" CssClass="cssLabel"></asp:Label>
                                    <asp:DataGrid runat="server" ID="dgDetucteeGrid" AutoGenerateColumns="false"
                                        Width="100%" CellSpacing="2" CellPadding="2" ShowHeader="true"
                                        AllowPaging="true" PageSize="25" ShowFooter="false" OnItemCommand="dgDetucteeGrid_ItemCommand"
                                        OnPageIndexChanged="dgDetucteeGrid_PageIndexChanged">
                                        <%--DataKeyField="Employee_ID" --%>
                                        <PagerStyle Position="Top" CssClass="GridPager1" BackColor="#F3F3f3"
                                            HorizontalAlign="Right" Mode="NumericPages" BorderColor="#dbdbdb"
                                            BorderWidth="0" />
                                        <HeaderStyle CssClass="cssGridHeader" />
                                        <ItemStyle CssClass="cssGridItemStyle" />
                                        <AlternatingItemStyle CssClass="cssGridAlternatingItemStyle" />
                                        <FooterStyle CssClass="cssGridHeader" />
                                        <Columns>
                                            <asp:TemplateColumn HeaderText="SrNo">
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Right" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblsr" runat="server" CssClass="cssLabel" Text='<%#Eval("SrNo") %>'
                                                        Visible="true"></asp:Label>
                                                </ItemTemplate>
                                                <FooterStyle BorderColor="#dbdbdb" HorizontalAlign="Right" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Deductee Name">
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Left" Width="30%" />
                                                <ItemTemplate>
                                                    <asp:HiddenField ID="hdnDeducteeNO" Value='<%#Eval("Deductee_ID") %>'
                                                        runat="server" />
                                                    <asp:Label ID="lblName" runat="server" CssClass="cssLabel" Text='<%#Eval("Deductee_Name") %>'
                                                        Visible="true"></asp:Label>
                                                </ItemTemplate>
                                                <FooterStyle BorderColor="#dbdbdb" HorizontalAlign="Right" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Natrue">
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Left" Width="25%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAlias" runat="server" CssClass="cssLabel" Text='<%#Eval("Nature_Name") %>'
                                                        Visible="true"></asp:Label>
                                                </ItemTemplate>
                                                <FooterStyle BorderColor="#dbdbdb" HorizontalAlign="Right" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="PAN Number">
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Left" Width="9.5%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPANNO" runat="server" CssClass="cssLabel" Text='<%#Eval("PAN_NO") %>'
                                                        Visible="true"></asp:Label>
                                                </ItemTemplate>
                                                <FooterStyle BorderColor="#dbdbdb" HorizontalAlign="Right" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="PANVerified">
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Left" Width="12.5%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPANVerified" runat="server" CssClass="cssLabel"
                                                        Text='<%#Eval("PANVerified") %>' ForeColor='<%# Convert.ToString(Eval("PANVerified"))==Convert.ToString("Valid PAN")?System.Drawing.Color.Green : System.Drawing.Color.Red%>'
                                                        Visible="true"></asp:Label>
                                                </ItemTemplate>
                                                <FooterStyle BorderColor="#dbdbdb" HorizontalAlign="Right" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Reasons">
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Left" Width="25%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblReasons" runat="server" CssClass="cssLabel"
                                                        Text='<%#Eval("Reasons") %>' Visible="true"></asp:Label>
                                                </ItemTemplate>
                                                <FooterStyle BorderColor="#dbdbdb" HorizontalAlign="Right" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn>
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="5%" />
                                                <ItemTemplate>
                                                    <asp:ImageButton runat="server" ImageUrl="~/Images/edit_icon.png"
                                                        ID="btnEdit" CssClass="cssEditDeleteImage" CommandName="EditCommand"
                                                        CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Deductee_ID") %>'
                                                        ToolTip="Edit" />
                                                </ItemTemplate>
                                                <FooterStyle BorderColor="#dbdbdb" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn>
                                                <HeaderStyle BorderColor="#dbdbdb" />
                                                <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="20px" />
                                                <ItemTemplate>
                                                    <asp:ImageButton runat="server" ID="btnDelete" ImageUrl="~/Images/Delete_icon.png"
                                                        CssClass="cssEditDeleteImage" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Deductee_ID") %>'
                                                        ToolTip="Delete" CommandName="DeleteCommand" OnClientClick="return DeleteConfirmation('Deductee')" />
                                                </ItemTemplate>
                                                <FooterStyle BorderColor="#dbdbdb" />
                                            </asp:TemplateColumn>
                                        </Columns>
                                    </asp:DataGrid>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
