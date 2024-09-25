<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="ManageEmployee_Master.aspx.cs" Inherits="Forms._Manage_Employee_Master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit"   TagPrefix="cc1" %>

<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
        <script type="text/javascript" src="../Scripts/jquery-1.8.2.min.js"></script>
    <script src="../Scripts/Ajax_Pager.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../customScript/common.js"></script>

    <script type="text/javascript" src="../customScript/jquery-confirm.min.js"></script>
    <link href="../css/jquery-confirm.min.css" rel="stylesheet" />
    <link href="../css/common.css" rel="stylesheet" />

    <script type="text/javascript">
        var PanVrf = '';
        var BulkPAN = '';
        var Cookies = "";
        var RequestType = "";
        $(document).ready(function () {
            $("[id*=tblTracesLogin]").hide();
            $("[id*=PnvVerfy]").click(function () {
                var P = $("[id*=txtPan_NO]").val();
                var l = $("[id*=txtFirstName]").val();
                ShowModalPopup();
                loadLoginDetails();
                getCaptcha();
                $("[id*=lbldPAN]").html(l);
                $("[id*=txtPAN]").val(P);


            });

        });


        function VerifyPANGrd(i) {

            var row = i.closest("tr");
            var d = row.find("input[name=hdndid]").val();
            var P = row.find('td:eq(1)').html();
            var l = row.find('td:eq(2)').html();
            ShowModalPopup();
            loadLoginDetails();
            getCaptcha();
            $("[id*=lbldPAN]").html(l);
            $("[id*=txtPAN]").val(P);
        }

        function pageLoad() {
            $(':text').bind('keydown', function (e) { //on keydown for all textboxes

                if (e.keyCode == 13) //if this is enter key

                    e.preventDefault();

            });
        }

        $("[id*=txtBirthDate]").focus(function () { $(this).select(); });
        $("[id*=txtBirthDate]").live("click",function () { $(this).select(); });

        $("[id*=txtJoiningDate]").focus(function () { $(this).select(); });
        $("[id*=txtJoiningDate]").live("click", function () { $(this).select(); });

        function ShowModalPopup() {
            $find("programmaticModalPopupOrginalBehavior").show();
            return false;
        }

        function HideModalPopup() {
            $find("programmaticModalPopupOrginalBehavior").hide();
            return false;
        }



        RequestTrace = function () {


            var UserID = $("#txtUserID").val();
            var Password = $("#txtPassword").val();
            var TAN_NO = $("#txtTan").val();

            var CaptchaCode = $("#captcha").val();
            var ddlForm = $('#ddlForm  option:selected').text();
            var PAN = $("#txtPAN").val();
            var compid = $("[id*=hdnCompanyID]").val();

            if ((UserID == null || UserID == "") || (Password == null || Password == "")) {
                ShowErrorWindow('Enter User Login Details');
                return false;
            }


            if (TAN_NO == null || TAN_NO == undefined) {
                ShowErrorWindow('TAN - Cannot be Blank');
                return false;
            }


            if (TAN_NO != "0" && TAN_NO != "") {
                if (TAN_NO != null || TAN_NO != undefined) {

                    //PAN check
                    var Pattern1 = /^([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}?$/;
                    //TAN check
                    var Pattern2 = /^([a-zA-Z]){4}([0-9]){5}([a-zA-Z]){1}?$/;
                    //AIN check
                    var Pattern3 = /^[0-9]{7}$/;

                    if (TAN_NO.match(Pattern1) || TAN_NO.match(Pattern2) || TAN_NO.match(Pattern3)) {
                        // ShowErrorWindow('correct Format of the TAN No.');
                        //return false;
                    } else {
                        ShowErrorWindow('Incorrect Format of the TAN No.');
                        return false;
                    }
                }
            }





            if (PAN != null && PAN != undefined && PAN != "") {
                if (!PAN.match(/^([a-zA-Z]){4}([a-zA-Z]){1}([0-9]){4}([a-zA-Z]){1}?$/)) {
                    ShowErrorWindow("PAN structure is not valid");
                    return false;
                }
            }



            var tracesData = {
                "objTraceData": {
                    Forms: ddlForm,
                    PAN1: PAN,
                    Compid: compid

                },
                "objLogin": {
                    UserID: UserID,
                    Password: Password,
                    TAN: TAN_NO,
                    CaptchaCode: CaptchaCode,
                    Cookie: Cookies
                }
            };


            $(".MastermodalBackground2").show();
            document.getElementById("btnGetRequest").disabled = true;

            //debugger;
            $.ajax({
                type: "POST",
                url: "TService.asmx/reqPANVerify",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify(tracesData),
                success: function (data) {
                    //  debugger;
                    var result = JSON.parse(data.d);
                    if (result.error) {
                        $("#captcha").val("");
                        getCaptcha();
                        $(".MastermodalBackground2").hide();
                        ShowErrorWindow(result.error);
                        UpdatePAN(PAN, 'InValid PAN', result.success.Status );
                        document.getElementById("btnGetRequest").disabled = false;
                        return false;
                    }
                    else {
                        if (result.success) {
                            $("#captcha").val("");
                            getCaptcha();
                            var tbl_html_val = "<div><span style='padding-right:20px;'>PAN : <b>" + PAN + "</b> </span><span>Name : <b>" + result.success.Name + "</b> </span></div>";
                            $("#divData").html(tbl_html_val);
                           
                            $(".MastermodalBackground2").hide();
                            UpdatePAN(PAN, 'Valid PAN', result.success.Status );
                            document.getElementById("btnGetRequest").disabled = false;
                            $(".MastermodalBackground2").hide();
                            return false;
                        }
                    }
                },
                failure: function (response) {
                    $("#captcha").val("");
                    getCaptcha();
                    document.getElementById("btnGetRequest").disabled = false;
                    $(".MastermodalBackground2").hide();
                    ShowErrorWindow(response.d);
                }
            });




            return false;
        }

        function UpdatePAN(PAN, vrfy, Sts) {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../handler/Ws_Deductee.asmx/Update_PAN",
                data: '{PAN:"' + PAN + '", vrfy:"' + vrfy + '", sts:"' + Sts + '"}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);

                },
                failure: function (response) {
                    alert('Cant Connect to Server' + response.d);
                },
                error: function (response) {
                    alert('Error Occoured ' + response.d);
                }
            });

        }


        TracesDetails = function () {
            debugger;
            var UserID = $("#txtUserID").val();
            var Password = $("#txtPassword").val();
            var TAN_NO = $("input[type=text][id*=txtTanNo]").val();
            var Compid = $("[id*=hdnCompid]").val();

            if (isValid(UserID) || isValid(Password)) {
                ShowWarningWindow('Enter User Login Details');
                return false;
            }

            //--POST REQUEST             
            $(".MastermodalBackground2").show();
            $.ajax({
                type: "POST",
                //url: "TService.asmx/reQList",
                url: "../handler/Voucher.asmx/TracesDetailsSave",
                contentType: "application/json; charset=utf-8",

                data: '{Compid:' + Compid + ',UserID:"' + UserID + '",Password:"' + Password + '",TAN:"' + TAN_NO + '"}',
                dataType: "json",
                success: function (data) {

                    //bind requested downloads
                    var result = JSON.parse(data.d);
                    if (result[0].Compid > 0) {
                        ShowSuccessWindow('Successfully Saved!!!')
                    }

                    $(".MastermodalBackground2").hide();
                },
                failure: function (response) {
                    $(".MastermodalBackground2").hide();
                    ShowErrorWindow(response.d);
                }
            });


            return false;
        }



    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:HiddenField runat="server" ID="hdnCompanyID" />
            <asp:Timer ID="Timer1" runat="server" OnTick="TimerTick" Interval="700">
            </asp:Timer>
            <table id="Table3" runat="server" width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <table id="Table1" runat="server" width="100%" cellpadding="5" cellspacing="0">
                            <tr id="Tr1" runat="server">
                                <td class="cssPageTitle" height="5px">
                                    <asp:Label ID="Label1" runat="server" Text="Employee"></asp:Label>
                                </td>
                            </tr>
                            <tr id="Tr2" runat="server">
                                <td style="height: 0px;">
                                    <UC:MessageControl runat="server" ID="ucMessageControl" />
                                </td>
                            </tr>
                            <tr id="tdSearch" runat="server">
                                <td id="Td1" runat="server" valign="top">
                                    <table id="Table10" runat="server" width="100%" cellpadding="3" cellspacing="0">
                                        <tr runat="server" id="TableRow1">
                                            <td width="120px">
                                                <asp:Label ID="Label46" runat="server" CssClass="cssLabel" Text="Employee Name"></asp:Label>
                                            </td>
                                            <td colspan="3">
                                                <table id="Table11" runat="server" width="100%" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox runat="server" ID="txtSearchName" CssClass="cssTextbox" Width="300px"></asp:TextBox>
                                                        </td>
                                                        <td width="100px">
                                                            <asp:Button runat="server" ID="btnSearch" Text="Search" CssClass="cssButton" OnClick="btnSearch_OnClick" />
                                                        </td>
                                                        <td>
                                                            <asp:Button runat="server" ID="btnAddNew" CssClass="cssButton" Text="Add New Employee"
                                                                OnClick="btnAddNew_OnClick" />
                                                            <asp:Button runat="server" ID="btnBulkPAN" CssClass="cssButton" Text="Bulk Pan Verification"
                                                                OnClick="btnBulkPAN_Click" />
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
                                                <asp:DropDownList runat="server" ID="ddlSearchDepartment" CssClass="cssDropDownList">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlSearchBranch" CssClass="cssDropDownList">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlSearchDesignation" CssClass="cssDropDownList">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr runat="server" id="TableRow4">
                                            <td>
                                                <asp:Label ID="Label48" runat="server" CssClass="cssLabel" Text="Show"></asp:Label>
                                            </td>
                                            <td colspan="3">
                                                <asp:RadioButton runat="server" ID="rdoCurrentEmployee" Checked="true" Text="Current Employee"
                                                    CssClass="cssLabel" GroupName="Resignation" OnCheckedChanged="RadioButton_OnCheckedChanged"
                                                    AutoPostBack="true" />
                                                &nbsp;
                                                <asp:RadioButton runat="server" ID="rdoLeftEmployee" Text="Left Employee" CssClass="cssLabel"
                                                    GroupName="Resignation" OnCheckedChanged="RadioButton_OnCheckedChanged" AutoPostBack="true" />
                                                &nbsp;
                                                <asp:RadioButton runat="server" ID="rdoAllEmployee" Text="All Employee" CssClass="cssLabel"
                                                    GroupName="Resignation" OnCheckedChanged="RadioButton_OnCheckedChanged" AutoPostBack="true" />
                                            </td>
                                            <td>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="Tr4" runat="server" style="margin-top: 0px; padding-top: 0px;">
                                <td>
                                    <table runat="server" id="tblEmployee" style="margin-top: 0px; padding-top: 0px;"
                                        visible="false" width="100%">
                                        <tr>
                                            <td>
                                                <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="validEmployee" ShowMessageBox="true"
                                                    ShowSummary="false" runat="server" />
                                                <table id="Table2" runat="server" style="margin-top: 0px; padding-top: 0px;" width="98%"
                                                    cellspacing="0" cellpadding="2" borderwidth="0" horizontalalign="Center">
                                                    <tr>
                                                        <td>
                                                            <fieldset style="margin-top: 0px; padding-top: 0px;">
                                                                <legend>Personal Details</legend>
                                                                <table>
                                                                    <tr id="Tr3" runat="server" visible="false">
                                                                        <td width="120px">
                                                                            <asp:Label ID="ASPxLabel5" runat="server" Text="Employee ID" CssClass="cssLabel">
                                                                            </asp:Label>
                                                                        </td>
                                                                        <td width="400px">
                                                                            <asp:TextBox ID="txtECode" runat="server" CssClass="cssTextbox"></asp:TextBox>
                                                                        </td>
                                                                        <td>
                                                                        </td>
                                                                        <td>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="left" width="120px">
                                                                            <asp:Label ID="ASPxLabel13" runat="server" Text="Name *" ForeColor="Red" CssClass="cssLabel">
                                                                            </asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtFirstName" runat="server" CssClass="cssTextbox" Style="text-transform: capitalize"
                                                                                Width="300px">
                                                                            </asp:TextBox>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtFirstName"
                                                                                ErrorMessage="Please Enter name !" CssClass="cssRequiredFieldValidator" ValidationGroup="validEmployee"
                                                                                Display="None">
                                                                            </asp:RequiredFieldValidator>
                                                                        </td>
                                                                        <td align="left">
                                                                            <asp:Label ID="ASPxLabel15" runat="server" Text="Gender" CssClass="cssLabel">
                                                                            </asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:RadioButton ID="rdoMale" runat="server" GroupName="Gender" CssClass="cssLabel"
                                                                                Height="10px" Text="Male" Checked="true"></asp:RadioButton>
                                                                            <asp:RadioButton ID="rdoFemale" runat="server" GroupName="Gender" CssClass="cssLabel"
                                                                                Text="Female"></asp:RadioButton>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="left" verticalalign="Top" width="100px">
                                                                            <asp:Label ID="Label4" runat="server" Text="Address" CssClass="cssLabel">
                                                                            </asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtAddress" runat="server" CssClass="cssTextbox" TextMode="MultiLine"
                                                                                Width="250" Height="70"> </asp:TextBox>
                                                                        </td>
                                                                        <td align="left">
                                                                            <asp:Label ID="Label49" runat="server" Text="Birth Date" CssClass="cssLabel"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox runat="server" ID="txtBirthDate" CssClass="cssTextbox" Width="100px"></asp:TextBox>
                                                                            <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtBirthDate"
                                                                                Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" />
                                                                            <asp:ImageButton ID="ImageButton2" ImageUrl="~/Images/calendar.gif" runat="server"
                                                                                CausesValidation="false" />
                                                                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" PopupButtonID="ImageButton2"
                                                                                TargetControlID="txtBirthDate" Format="dd/MM/yyyy">
                                                                            </cc1:CalendarExtender>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="left">
                                                                            <asp:Label ID="Label44" runat="server" Text="PAN No *" ForeColor="Red" CssClass="cssLabel">
                                                                            </asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtPan_NO" runat="server" CssClass="cssTextbox" Style="text-transform: uppercase"
                                                                                AutoPostBack="True" MaxLength="10" OnTextChanged="txtPan_NO_TextChanged"></asp:TextBox>
                                                                                &nbsp;&nbsp;<input id="PnvVerfy" type="button" value="Pan Verify" title="Verify PAN with Traces" class="cssButton"/>
                                                                                                         
                                                                            <%--<asp:Label ID="lblPanVerify" name="lblPanVerify" runat="server" Text=""></asp:Label>--%>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPan_NO"
                                                                                ErrorMessage="Please Enter PAN NO !" CssClass="cssRequiredFieldValidator" ValidationGroup="validEmployee"
                                                                                Display="None">
                                                                            </asp:RequiredFieldValidator>
                                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ValidationGroup="validEmployee"
                                                                                runat="server" ControlToValidate="txtPan_NO" Display="None" ForeColor="Red" ErrorMessage="Please Enter 10 Digit PAN Number"
                                                                                ValidationExpression="^[\s\S]{10,10}$"></asp:RegularExpressionValidator>
                                                                        </td>
                                                                        <td align="left">
                                                                            <asp:Label ID="ASPxLabel14" runat="server" Text="Joining Date"
                                                                                CssClass="cssLabel"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox runat="server" ID="txtJoiningDate" CssClass="cssTextbox" Width="100px"></asp:TextBox>
                                                                            <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtJoiningDate"
                                                                                Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" />
                                                                            <asp:ImageButton ID="ImageButton1" ImageUrl="~/Images/calendar.gif" runat="server"
                                                                                CausesValidation="false" />
                                                                            <cc1:CalendarExtender ID="c1" runat="server" PopupButtonID="ImageButton1" TargetControlID="txtJoiningDate"
                                                                                Format="dd/MM/yyyy">
                                                                            </cc1:CalendarExtender>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="left">
                                                                            <asp:Label ID="ASPxLabel2" runat="server" Text="Mobile No" CssClass="cssLabel"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtMobile" runat="server" CssClass="cssTextbox">
                                                                            </asp:TextBox>
                                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ValidationGroup="validEmployee"
                                                                                Display="None" runat="server" ErrorMessage="Enter valid mobile no" ControlToValidate="txtMobile"
                                                                                CssClass="cssRequiredFieldValidator" ValidationExpression="^([\(]{1}[0-9]{3}[\)]{1}[\.| |\-]{0,1}|^[0-9]{3}[\.|\-| ]?)?[0-9]{3}(\.|\-| )?[0-9]{4}$"></asp:RegularExpressionValidator>
                                                                        </td>
                                                                        <td align="left">
                                                                            <asp:Label ID="Label43" runat="server" Text="Branch *" ForeColor="Red" CssClass="cssLabel">
                                                                            </asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList runat="server" ID="ddlBranch_Salary_Master" CssClass="cssDropDownList">
                                                                            </asp:DropDownList>
                                                                            &nbsp;
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator14" ValidationGroup="validEmployee"
                                                                                runat="server" ControlToValidate="ddlBranch_Salary_Master" ErrorMessage="Please Select branch !"
                                                                                CssClass="cssRequiredFieldValidator" Display="None">
                                                                            </asp:RequiredFieldValidator>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="left">
                                                                            <asp:Label ID="Label2" runat="server" Text="City" CssClass="cssLabel"></asp:Label>
                                                                        </td>
                                                                        <td width="300px">
                                                                            <asp:TextBox ID="txtCity" runat="server" CssClass="cssTextbox"></asp:TextBox>
                                                                        </td>
                                                                        <td align="left" width="200px">
                                                                            <asp:Label ID="Label8" runat="server" Text="State *" ForeColor="Red" CssClass="cssLabel">
                                                                            </asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList runat="server" ID="ddlState" CssClass="cssDropDownList" Font-Size="12px">
                                                                            </asp:DropDownList>
                                                                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddlState"
                                                                                ErrorMessage="Please Select State name !" ValidationGroup="validEmployee" CssClass="cssRequiredFieldValidator"
                                                                                Display="None">
                                                                            </asp:RequiredFieldValidator>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="left">
                                                                            <asp:Label ID="Label3" runat="server" Text="Designation" CssClass="cssLabel">
                                                                            </asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList runat="server" ID="ddlDesignation" CssClass="cssDropDownList">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td align="left">
                                                                            <asp:Label ID="ASPxLabel4" runat="server" Text="Department" CssClass="cssLabel">
                                                                            </asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList runat="server" ID="ddlDepartment" CssClass="cssDropDownList">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </fieldset>
                                                            <fieldset>
                                                                <legend>Other Details</legend>
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label5" runat="server" Text="Metro Cities *" ForeColor="Red" CssClass="cssLabel">
                                                                            </asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddlMetrocities" CssClass="cssDropDownList" runat="server">
                                                                                <asp:ListItem Selected="True" Text="Mumbai"></asp:ListItem>
                                                                                <asp:ListItem Text="Chennai"></asp:ListItem>
                                                                                <asp:ListItem Text="Delhi"></asp:ListItem>
                                                                                <asp:ListItem Text="Kolkata"></asp:ListItem>
                                                                                <asp:ListItem Text="Others"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlMetrocities"
                                                                                ErrorMessage="Please Select Metro City !" ValidationGroup="validEmployee" CssClass="cssRequiredFieldValidator"
                                                                                Display="None">
                                                                            </asp:RequiredFieldValidator>
                                                                        </td>
                                                                        <td>
                                                                            Handicapped
                                                                        </td>
                                                                        <td>
                                                                            <asp:RadioButtonList ID="rlist_Handicapped" runat="server" RepeatDirection="Horizontal">
                                                                                <asp:ListItem Selected="True" Text="No" Value="0"></asp:ListItem>
                                                                                <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label6" runat="server" Text="Father or Husband Name" CssClass="cssLabel">
                                                                            </asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtFATHER_HUSBAND_NAME" runat="server" CssClass="cssTextbox"></asp:TextBox>
                                                                        </td>
                                                                        <td runat="server" id="tdNoofChildlbl" class="gridpagesleft">
                                                                            <asp:Label ID="Label51" runat="server" Text="No of Child" CssClass="cssLabel">
                                                                            </asp:Label>
                                                                        </td>
                                                                        <td runat="server" id="tdNoofChildddl">
                                                                            <asp:DropDownList ID="drpChild" runat="server" CssClass="cssDropDownList">
                                                                                <asp:ListItem>0</asp:ListItem>
                                                                                <asp:ListItem>1</asp:ListItem>
                                                                                <asp:ListItem>2</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="200px">
                                                                            <asp:Label ID="Label10" runat="server" Text="Citizen Type" CssClass="cssLabel"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="drpCtzn" runat="server" CssClass="cssDropDownList">
                                                                                <asp:ListItem Value="None" Text="None"></asp:ListItem>
                                                                                <asp:ListItem Value="Senior Citizen" Text="Senior Citizen"></asp:ListItem>
                                                                                <asp:ListItem Value="Super Senior Citizen" Text="Super Senior Citizen"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td class="gridpagesleft">
                                                                        </td>
                                                                        <td style="font-weight: 700">
                                                                            <asp:CheckBox runat="server" ID="chkCalcProvidendFund" Text="Calc Providend Fund"
                                                                                CssClass="cssLabel" />
                                                                            <asp:CheckBox runat="server" ID="chkCalcProfessionalTax" Text="Calc Professional Tax"
                                                                                CssClass="cssLabel" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </fieldset>
                                                        </td>
                                                    </tr>
                                                    <tr runat="server" id="tr8">
                                                        <td>
                                                            <asp:Button runat="server" ValidationGroup="validEmployee" ID="btnSave" Text="Save"
                                                                CssClass="cssButton" OnClick="btnSave_OnClick" />
                                                            &nbsp;
                                                            <asp:Button runat="server" ID="btnCancel" Text="Cancel" CausesValidation="false"
                                                                CssClass="cssButton" OnClick="btnCancel_OnClick" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td runat="server" id="tdGrid" valign="top">
                        <asp:Label ID="lblGridMessage" runat="server" CssClass="cssLabel"></asp:Label>
                        <asp:DataGrid runat="server" ID="dgEmployee" AutoGenerateColumns="false" DataKeyField="Employee_ID"
                            Width="100%" CellSpacing="2" CellPadding="2" ShowHeader="true" OnItemCommand="dgEmployee_OnItemCommand"
                            OnPageIndexChanged="dgEmployee_PageIndexChanged" AllowPaging="true" PageSize="25"
                            ShowFooter="false">
                            <PagerStyle CssClass="GridPager1" BackColor="#F3F3f3" Position="Top" Mode="NumericPages" HorizontalAlign="Right" BorderColor="#dbdbdb" />
                            <HeaderStyle CssClass="cssGridHeader" />
                            <ItemStyle CssClass="cssGridItemStyle" />
                            <AlternatingItemStyle CssClass="cssGridAlternatingItemStyle" />
                            <FooterStyle CssClass="cssGridHeader" />
                            <Columns>
                                <asp:BoundColumn DataField="SrNo" HeaderText="No">
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" Width="20px" />
                                    <FooterStyle BorderColor="#dbdbdb" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="FirstName" HeaderText="Name">
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" />
                                    <FooterStyle BorderColor="#dbdbdb" HorizontalAlign="right" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="Join_DT" HeaderText="Join Date" DataFormatString="{0:dd/MM/yyyy}">
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" Width="80px" />
                                    <FooterStyle BorderColor="#dbdbdb" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="Mobile_No" HeaderText="Mobile No">
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" Width="100px" />
                                    <FooterStyle BorderColor="#dbdbdb" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="Designation_Name" HeaderText="Designation">
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" Width="150px" />
                                    <FooterStyle BorderColor="#dbdbdb" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="Department_Name" HeaderText="Department">
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" Width="150px" />
                                    <FooterStyle BorderColor="#dbdbdb" />
                                </asp:BoundColumn>
                                <asp:TemplateColumn HeaderText="PAN No">
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="15px" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblPAN" runat="server" CssClass="cssLabel" Text='<%#Eval("PAN_NO") %>'
                                            Visible="true"></asp:Label>
                                    </ItemTemplate>
                                    <FooterStyle BorderColor="#dbdbdb" HorizontalAlign="right" />
                                </asp:TemplateColumn>
                                <asp:TemplateColumn HeaderText="PANVerified">
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="15px" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblPANVerified" runat="server" CssClass="cssLabel" Text='<%#Eval("PANVerified") %>'
                                            ForeColor='<%# Convert.ToString(Eval("PANVerified"))==Convert.ToString("Valid PAN")?System.Drawing.Color.Green : System.Drawing.Color.Red%>'
                                            Visible="true"></asp:Label>
                                    </ItemTemplate>
                                    <FooterStyle BorderColor="#dbdbdb" HorizontalAlign="right" />
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="20px" />
                                    <ItemTemplate>
                                        <asp:ImageButton runat="server" ImageUrl="~/Images/edit_icon.png" ID="btnEdit" CssClass="cssEditDeleteImage"
                                            CommandName="EditCommand" ToolTip="Edit" />
                                    </ItemTemplate>
                                    <FooterStyle BorderColor="#dbdbdb" />
                                </asp:TemplateColumn>
<%--                                <asp:TemplateColumn>
                                    <HeaderStyle BorderColor="#dbdbdb" />
                                    <ItemStyle BorderColor="#dbdbdb" HorizontalAlign="Center" Width="20px" />
                                    <ItemTemplate>
                                        <asp:ImageButton runat="server" ID="btnDelete" ImageUrl="~/Images/Delete_icon.png"
                                            CssClass="cssEditDeleteImage" ToolTip="Delete" CommandName="DeleteCommand" OnClientClick="return DeleteConfirmation('employee')" />
                                    </ItemTemplate>
                                    <FooterStyle BorderColor="#dbdbdb" />
                                </asp:TemplateColumn>--%>
                            </Columns>
                        </asp:DataGrid>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:HiddenField runat="server" ID="hdnEmployee_ID" />
                    </td>
                </tr>
            </table>



    <asp:Button Style="display: none" ID="hideModalPopupViaClientOrginal" runat="server"></asp:Button><br />
    <cc1:ModalPopupExtender BackgroundCssClass="modalBackground" BehaviorID="programmaticModalPopupOrginalBehavior"
        RepositionMode="RepositionOnWindowScroll" DropShadow="False" ID="ModalPopupExtender2"
        TargetControlID="hideModalPopupViaClientOrginal" CancelControlID="imgBudgetdClose"
        PopupControlID="panel10" runat="server">
    </cc1:ModalPopupExtender>

    <asp:Panel ID="panel10" runat="server" Width="700px" Height="390px" BackColor="#FFFFFF">
        <div id="Div1" style="width: 100%; float: left; background-color: #55A0FF; color: #ffffff; font-weight: bold;">
            <div id="Div2" style="width: 90%; float: left; height: 20px; padding-left: 2%; padding-top: 1%">
                <asp:Label ID="lblpopup" runat="server" Font-Size="Larger" CssClass="subHead1 labelChange" Text=""></asp:Label>
            </div>
            <div id="Div3" class="ModalCloseButton">
                <img alt="" src="../images/error.png" id="imgBudgetdClose" border="0" name="imgClose"
                    onclick="return HideModalPopup()" />
            </div>
        </div>
        <div style="padding: 5px 5px 5px 5px; height:295px;" id="addtasks" runat="server" class="comprw">
            <div id="divJb" class="divedBlock" style="padding-top: 10px;height: 395px;">

                <div style="overflow: hidden; width: 680px; height: 390px; float: left; padding-left: 5px;">
                    <img alt="" src="../images/tds-logo.png" id="imgTraces" border="0" name="imgTraces"  />
                    <asp:Panel ID="pnljb" runat="server"  Height="290px" Width="680px">
                                <table width="60%" id="tblTracesLogin">
                                    <tr>
                                        <td colspan="6">
                                            <span id="lblUserDetails" class="lblHeader" style="font-weight: 700;">Enter Traces Login Details</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border: 2px;">TAN : <span class="req">*</span>
                                        </td>
                                        <td>
                                            <input id="txtTan" name="txtTan"  class="cssTextbox" type="text" style="width: 120px;" value=""  autocomplete="none" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border: 2px;"> User ID : <span class="req">*</span>
                                        </td>
                                        <td>
                                            <input id="txtUserID" class="cssTextbox" style="width: 120px;" type="text" value=""  autocomplete="nope" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border: 2px;">Password : <span class="req">*</span>
                                        </td>
                                        <td>
                                            <input id="txtPassword" class="cssTextbox" style="width: 120px;" type="password" value="" />
                                        </td>

                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>
                                            <input type="submit" name="btnSaveRequest" value="Save" id="btnSaveRequest" class="cssButton" onclick="return TracesDetails();" /></td>
                                    </tr>
                                </table>
                        <table id="tblver" name="tblver" >
                            <tr>
                                <td>
                                    PAN &nbsp;&nbsp;<input id="txtPAN" name="txtPAN" class="cssTextbox" style="width: 120px;" type="text" value="" />
                                    
                                </td>
                                <td>
                                    <label id="lbldPAN" style="font-weight: bold;"></label>
                                </td>
                            </tr>
                            <tr id="trAuto1" name="trAuto1">
                                <td style="text-align:right;">
                                    <img id="captchaImg" class="captchaimg1" alt="Captcha" src="" /></td>
                                <td>
                                    <img src="../Images/refresh.png" style="width: 20px; padding-right: 10px; cursor: pointer;" onclick="return getCaptcha();" />
                                    <label style="font-weight: bold;">Click to refresh image</label>

                                </td>
                            </tr>
                            <tr style="height:15px;" >
                                <td></td>
                            </tr>
                            <tr id="trAuto2" name="trAuto2" >
                                <td style="font-weight: bold;font-size:14px; text-align:right;">Enter text as in above image</td>
                                <td style="text-align:left;">
                                   <input autocomplete="off" id="captcha" name="captcha" class="frmtxtbox" maxlength="5"  style="width:100px; " value="" />
                                </td>
                             </tr>
                            <tr style="height:15px;" >
                                <td></td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="submit" name="btnGetRequest" value="Request" id="btnGetRequest" class="cssButton" onclick="return RequestTrace();" />
                                </td>
                                <td>
                                    <asp:Button ID="Button1" Text="Cancel" runat="server" CssClass="cssButton" OnClientClick="return HideModalPopup()"  />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">

                                    <div style="width: 100%; margin: auto; padding-left:15px;" id="divData">
                                    </div>

                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </asp:Panel>
</asp:Content>
