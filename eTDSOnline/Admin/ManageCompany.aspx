<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="ManageCompany.aspx.cs" Inherits="Admin_ManageCompany" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<script src="../Scripts/jquery-1.8.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" runat="server">
    </script>
    <style type="text/css">
        .modal
        {
            position: fixed;
            z-index: 999;
            height: 100%;
            width: 100%;
            top: 0;
            filter: alpha(opacity=60);
            opacity: 0.6;
            -moz-opacity: 0.8;
        }
        .center
        {
            z-index: 1000;
            margin: 300px auto;
            padding: 10px;
            width: 64px;
            border-radius: 10px;
            filter: alpha(opacity=100);
            opacity: 1;
            -moz-opacity: 1;
        }
        .center img
        {
            height: 64px;
            width: 64px;
        }
        .modalBackground
        {
            background-color: Black;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }
        .modalPopup
        {
            background-color: #FFFFFF;
            border-width: 3px;
            border-style: solid;
            border-color: black;
            padding-top: 10px;
            padding-left: 10px;
            width: 300px;
            height: 120px;
        }
        .Tab .ajax__tab_header {
            color: #4682b4;
            font-family: Calibri;
            font-size: 14px;
            font-weight: bold;
            background-color: #ffffff;
            margin-left: 0px;
            cursor: pointer;
        }
        /*Body*/
        .Tab .ajax__tab_body {
            border: 1px solid #b4cbdf;
            padding-top: 0px;
            cursor: pointer;
        }
        /*Tab Active*/
        .Tab .ajax__tab_active .ajax__tab_tab {
            color: #ffffff;
            background: url("../tabb/tab_active.gif") repeat-x;
            height: 20px;
            cursor: pointer;
        }

        .Tab .ajax__tab_active .ajax__tab_inner {
            color: #ffffff;
            background: url("../tabb/tab_left_active.gif") no-repeat left;
            padding-left: 10px;
            cursor: pointer;
        }

        .Tab .ajax__tab_active .ajax__tab_outer {
            color: #ffffff;
            background: url("../tabb/tab_right_active.gif") no-repeat right;
            padding-right: 6px;
            cursor: pointer;
        }
        /*Tab Hover*/
        .Tab .ajax__tab_hover .ajax__tab_tab {
            color: #000000;
            background: url("../tabb/tab_hover.gif") repeat-x;
            height: 20px;
            cursor: pointer;
        }

        .Tab .ajax__tab_hover .ajax__tab_inner {
            color: #000000;
            background: url("../tabb/tab_left_hover.gif") no-repeat left;
            padding-left: 10px;
            cursor: pointer;
        }

        .Tab .ajax__tab_hover .ajax__tab_outer {
            color: #000000;
            background: url("../tabb/tab_right_hover.gif") no-repeat right;
            padding-right: 6px;
            cursor: pointer;
        }
        /*Tab Inactive*/
        .Tab .ajax__tab_tab {
            color: #666666;
            background: url("../tabb/tab_Inactive.gif") repeat-x;
            height: 20px;
            cursor: pointer;
            width: 100%;
            font-size:16px;
        }

        .Tab .ajax__tab_inner {
            color: #666666;
            background: url("../tabb/tab_left_inactive.gif") no-repeat left;
            padding-left: 10px;
            cursor: pointer;
        }

        .Tab .ajax__tab_outer {
            color: #666666;
            background: url("../tabb/tab_right_inactive.gif") no-repeat right;
            padding-right: 6px;
            margin-right: 2px;
            cursor: pointer;
        }
    </style>

    <script type="text/javascript" src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            
            $(document).on('change','input[type="checkbox"][id*=chk_SameAs]',function (e) {
                sameas();
            });
            $("[id*=TxtGSTN]").blur(function () {

                Gstn_Check();
            });

            $("[id*=btnAdmin]").click(function () {
                try {
                    var u = $("[id*=TxtUser]").val();
                    var cp = $("[id*=txtContactperson]").val();
                    var e = $("[id*=TxtEmail]").val();
                    var n = $("[id*=txtContactnumber]").val();
                    var p = $("[id*=TxtPassword]").val();
                    //var pp = $("[id*=txtConfirm]").val();
                    var uid = $("[id*=hdnUID]").val();
                    var compid = $("[id*=hdnCompanyid]").val();
                    if (u == '' || u == undefined) {
                        alert('UserId not Entered');
                    }
                    if (cp == '' || cp == undefined)
                    { alert('Contact Person not Entered'); }
                    if (e == '' || e == undefined)
                    { alert('Email not Entered'); }
                    if (n == '' || n == undefined)
                    { alert('Mobile not Entered'); }
                    if (p == '' || p == undefined)
                    { alert('Password not Entered'); }
                     
                    //if (pp == '' || pp == undefined)
                    //{ alert('Confirm Password not Entered'); }
                    //if (p != pp)
                    //{ alert('Password & Confirm Password not Equal'); }
                    var d = u + ',' + cp + ',' + e + ',' + n + ',' + p + ',' + uid;
                    if (d != '') {

                        $.ajax({
                            type: "POST",
                            url: "../handler/Ws_PanNo.asmx/SaveAdmin",
                            data: "{compid:" + compid + ",d:'" + d + "'}",
                            dataType: 'json',
                            contentType: "application/json",
                            success: function (msg) {
                                var myList = jQuery.parseJSON(msg.d);
                                var tbl = "";
                                if (parseFloat(myList.length) > 0) {
                                    alert('Record saved successfull ');
                                }

                            },
                            failure: function (response) {
                                alert('Cant Connect to Server' + response.d);
                            },
                            error: function (response) {
                                alert('Error Occoured ' + response.d);
                            }
                        });

                    }

                } catch (e) {
                    ErrorShow(e);
                }

            });

        });

        function Gstn_Check()
        {
            $("[id*=hdnValid]").val('');
            var Gstn = $("[id*=TxtGSTN]").val();
            var i = Gstn.length();
            if (i != 15) {
                alert('Gstn No should be 15 digit');
                $("[id*=hdnValid]").val('GSTN');
            }
        }

        function isNumberKey(evt) {
            var charCode=(evt.which)?evt.which:event.keyCode
            if(charCode>31&&(charCode<48||charCode>57))
                return false;

            return true;
        }
        function sameas() {
            
            try {

                var isChecked=$("input[type=checkbox][id*=chk_SameAs]").is(':checked');

                if(isChecked) {
                    var parm=document.getElementById('<%=ddlState.ClientID%>');
                    var sel=parm.options[parm.selectedIndex].value;
                    $('#<%=ddlR_State.ClientID %>').val(sel);
                    $('#<%=txtR_Flat_No.ClientID %>').val($('#<%=txtFlatNo.ClientID %>').val());
                    $('#<%=txtR_Building.ClientID %>').val($('#<%=txtName_Of_Building.ClientID %>').val());
                    $('#<%=txtR_Street.ClientID %>').val($('#<%=txtStreet.ClientID %>').val());
                    $('#<%=txtR_Area_Location.ClientID %>').val($('#<%=txtArea_Location.ClientID %>').val());
                    $('#<%=txtR_Town_City.ClientID %>').val($('#<%=txtTown_City.ClientID %>').val());
                    $('#<%=txtR_EmailID.ClientID %>').val($('#<%=txtEmailID.ClientID %>').val());
                    $('#<%=txtR_Pincode.ClientID %>').val($('#<%=txtPincode.ClientID %>').val());
                    $('#<%=txtR_STD_Code.ClientID %>').val($('#<%=txtSTD_code.ClientID %>').val());
                    $('#<%=txtR_Tel_NO.ClientID %>').val($('#<%=txtTel_NO.ClientID %>').val());
                    $('#<%=txtR_Fax.ClientID %>').val($('#<%=txtFax.ClientID %>').val());
                    $('#<%=txtALT_R_EmailID.ClientID %>').val($('#<%=txtAlt_EmailID.ClientID %>').val());
                    $('#<%=txtALT_R_Tel_NO.ClientID %>').val($('#<%=txtAlt_Tel_NO.ClientID %>').val());
                    $('#<%=txtALT_R_STD_Code.ClientID %>').val($('#<%=txtAlt_STDcode.ClientID %>').val());
                    $('#<%=chk_SameAs.ClientID%>').prop('checked',false);
                    alert("Copied Successfully.........");
                }

            } catch(e) {
                alert("Error Msg :"+e);
            }

        }

        function previewFile() {
           <%-- var preview=document.querySelector('#<%=ICompanyLogoPreview.ClientID %>');
            var file=document.querySelector('#<%=FileUpload1.ClientID %>').files[0];
            var reader=new FileReader();

            reader.onloadend=function () {
                preview.src=reader.result;
            }

            if(file) {
                reader.readAsDataURL(file);
            } else {
                preview.src="";
            }--%>
        }

        function ValidatePANNo(sender,args) {
            
<%--            var IsValid=false;

            var panmsg=$('#<%=lblPanVerified.ClientID %>').val();;
            if(panmsg=="Valid PAN")--%>
            //{
                IsValid = true;
            //}

            args.IsValid=IsValid;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">

    <table width="100%">
        <tr>
            <td class="cssPageTitle">
                <asp:Label ID="Label1" runat="server" Text="Company Details"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <UC:MessageControl runat="server" ID="ucMessageControl" />
            </td>
        </tr>
    </table>
<%--    <asp:UpdatePanel runat="server" ID="UpdatePanel2" ChildrenAsTriggers="true" UpdateMode="Conditional">
        <ContentTemplate>--%>

            <asp:ValidationSummary ID="ValidationSummary1" EnableTheming="True" DisplayMode="List"
                ShowMessageBox="True" ShowSummary="False" ValidationGroup="validThis" runat="server" ></asp:ValidationSummary>
            <table width="100%">
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="Add Multi-Company"></asp:Label>
                        <asp:Button ID="BtnMulti" runat="server" CssClass="cssButton" Text="Create Multi Company"
                            OnClick="btnMulti_Click" />
                    </td>
                </tr>
                <tr>
                    <td id="tdCompanyDetais" style="margin-top: 0px;" runat="server">
                        <br>
                        <asp:Label ID="lblGridMsg" runat="server"></asp:Label>
                        <asp:GridView ID="gvCompanyDetails" runat="server" AutoGenerateColumns="False" Width="100%"
                            CellSpacing="2" CellPadding="2" OnRowCommand="gvCompanyDetails_RowCommand">
                            <PagerStyle CssClass="cssGridHeader" BorderColor="#DBDBDB" BorderWidth="0px" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="cssGridHeader" ForeColor="Black" />
                            <FooterStyle CssClass="cssGridHeader" />
                            <Columns>
                                <asp:TemplateField HeaderText="Company Name">
                                    <ItemStyle CssClass="cssGridItemStyle" BorderColor="#DBDBDB" HorizontalAlign="Left" Width="40%" />
                                    <HeaderStyle BorderColor="#DBDBDB" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblCompanyName" runat="server" Text='<%#Eval("CompanyName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterStyle BorderColor="#DBDBDB" Font-Bold="True" HorizontalAlign="Right" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Contact Person">
                                    <ItemStyle CssClass="cssGridItemStyle" BorderColor="#DBDBDB" HorizontalAlign="Left" Width="20%" />
                                    <HeaderStyle BorderColor="#DBDBDB" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblContactPerson" runat="server" Text='<%#Eval("[ContactP]") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterStyle BorderColor="#DBDBDB" Font-Bold="True" HorizontalAlign="Right" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Contact No">
                                    <ItemStyle CssClass="cssGridItemStyle" BorderColor="#DBDBDB" HorizontalAlign="Left" Width="10%" />
                                    <HeaderStyle BorderColor="#DBDBDB" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblContactNo" runat="server" Text='<%#Eval("Tel") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterStyle BorderColor="#DBDBDB" Font-Bold="True" HorizontalAlign="Right" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Email ID">
                                    <ItemStyle CssClass="cssGridItemStyle" BorderColor="#DBDBDB" HorizontalAlign="Left" Width="10%" />
                                    <HeaderStyle BorderColor="#DBDBDB" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblEmailID" runat="server" Text='<%#Eval("Email") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterStyle BorderColor="#DBDBDB" Font-Bold="True" HorizontalAlign="Right" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="UserName">
                                    <ItemStyle CssClass="cssGridItemStyle" BorderColor="#DBDBDB" HorizontalAlign="Left" Width="10%" />
                                    <HeaderStyle BorderColor="#DBDBDB" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblUserName" runat="server" Text='<%#Eval("CUserName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterStyle BorderColor="#DBDBDB" Font-Bold="True" HorizontalAlign="Right" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderStyle BorderColor="#DBDBDB" />
                                    <ItemStyle BorderColor="#DBDBDB" HorizontalAlign="Center" Width="5%" />
                                    <ItemTemplate>
                                        <asp:ImageButton runat="server" ImageUrl="~/Images/edit_icon.png" ID="btnEdit" CssClass="cssEditDeleteImage"
                                            CommandName="EditCommand" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Company_ID") %>'
                                            ToolTip="Edit" />
                                    </ItemTemplate>
                                    <FooterStyle BorderColor="#DBDBDB" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
            </table>

            <table>
                <tr>
                    <td id="tdCompanyEidt" runat="server">
                        <cc1:TabContainer ID="TabContainer1" runat="server" CssClass="Tab" ActiveTabIndex="0"  >
                            <cc1:TabPanel ID="TabPanel1" runat="server" Width="100%" HeaderText="Company Details">
                                <ContentTemplate>

                                     <table width="100%" style="margin-top: 22px">
                                         <tr>
                                            <td>
                                                <fieldset style="margin: 0px;">
                                                <legend>Deductor Details</legend>
                                                <table width="100%">
                                                    <tr>
                                                <td>
                                                    Company Name
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="txtCompanyName" runat="server" CssClass="cssTextboxRed" Width="300px"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Enter Company Name !"
                                                        ControlToValidate="txtCompanyName" ForeColor="Red" ValidationGroup="validThis">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                                    <tr>
                                                <td>
                                                    Alias
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_Alias" runat="server" CssClass="cssTextbox"></asp:TextBox>
                                                </td>
                                                <td>
                                                    Branch
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_Branch" CssClass="cssTextboxRed" runat="server" maxlength="30"  style="border-color:#FF5733;"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator29" runat="server" ErrorMessage="Branch Required !"
                                                        ControlToValidate="txt_Branch" ForeColor="Red" ValidationGroup="validThis" InitialValue="0">*</asp:RequiredFieldValidator>                                                
                                                </td>
                                            </tr>
                                                    <tr>
                                                <td>
                                                    Flat No.
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="txtFlatNo" runat="server" CssClass="cssTextbox" maxlength="25"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtFlatNo"
                                                        ErrorMessage="Please Enter Deductor Flat No !" ForeColor="Red" ValidationGroup="validThis">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                                    <tr>
                                                <td>
                                                    Name Of Building
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="txtName_Of_Building" runat="server" CssClass="cssTextbox" maxlength="25" Width="300px"></asp:TextBox>
                                                </td>
                                            </tr>
                                                    <tr>
                                                <td>
                                                    Road/Street
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="txtStreet" runat="server" CssClass="cssTextbox" Width="300px" maxlength="25"></asp:TextBox>
                                                </td>
                                            </tr>
                                                    <tr>
                                                <td>
                                                    Area/Location
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="txtArea_Location" runat="server" CssClass="cssTextbox" Width="300px" maxlength="25"></asp:TextBox>
                                                </td>
                                            </tr>
                                                    <tr>
                                                <td>
                                                    Town/City
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="txtTown_City" runat="server" CssClass="cssTextbox" Width="300px" maxlength="25"></asp:TextBox>
                                                </td>
                                            </tr>
                                                    <tr>
                                                <td>
                                                    E-mail ID
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox runat="server" ID="txtEmailID" CssClass="cssTextbox"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please Enter Deductor Email ID !"
                                                        ControlToValidate="txtEmailID" ForeColor="Red" ValidationGroup="validThis">*</asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtEmailID"
                                                        ErrorMessage="Please Enter Deductor Valid Email ID !" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                        ValidationGroup="validThis">*</asp:RegularExpressionValidator>
                                                </td>
                                            </tr>
                                                    <tr>
                                                <td>
                                                    Status
                                                </td>
                                                <td colspan="3">
                                                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="cssDropDownList">
                                                        <asp:ListItem Text="(Select Status)"></asp:ListItem>
                                                        <asp:ListItem Text="A Central Government" Value="A Central Government"></asp:ListItem>
                                                        <asp:ListItem Text="S State Government" Value="S State Government"></asp:ListItem>
                                                        <asp:ListItem Text="D Statutory body (Central Govt.)" Value="D Statutory body (Central Govt.)"></asp:ListItem>
                                                        <asp:ListItem Text="E Statutory body (State Govt.)" Value="E Statutory body (State Govt.)"></asp:ListItem>
                                                        <asp:ListItem Text="G Autonomous body (Central Govt.)" Value="G Autonomous body (Central Govt.)"></asp:ListItem>
                                                        <asp:ListItem Text="H Autonomous body (State Govt.)" Value="H Autonomous body (State Govt.)"></asp:ListItem>
                                                        <asp:ListItem Text="L Local Authority (Central Govt.)" Value="L Local Authority (Central Govt.)"></asp:ListItem>
                                                        <asp:ListItem Text="N Local Authority (State Govt.)" Value="N Local Authority (State Govt.)"></asp:ListItem>
                                                        <asp:ListItem Text="K Company" Value="K Company"></asp:ListItem>
                                                        <asp:ListItem Text="M Branch / Division of Company" Value="M Branch / Division of Company"></asp:ListItem>
                                                        <asp:ListItem Text="P Association of Person (AOP)" Value="P Association of Person (AOP)"></asp:ListItem>
                                                        <asp:ListItem Text="T Association of Person (Trust)" Value="T Association of Person (Trust)"></asp:ListItem>
                                                        <asp:ListItem Text="J Artificial Juridical Person" Value="J Artificial Juridical Person"></asp:ListItem>
                                                        <asp:ListItem Text="B Body of Individuals" Value="B Body of Individuals"></asp:ListItem>
                                                        <asp:ListItem Text="Q Individual/HUF" Value="Q Individual/HUF"></asp:ListItem>
                                                        <asp:ListItem Text="F Firm" Value="F Firm"></asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please Select Status !"
                                                        ControlToValidate="ddlStatus" ForeColor="Red" ValidationGroup="validThis" InitialValue="0">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                                    <tr>
                                                <td>
                                                    Class
                                                </td>
                                                <td colspan="3">
                                                    <asp:DropDownList ID="ddlClass" runat="server" CssClass="cssDropDownList">
                                                        <asp:ListItem Text="(Select Class)"></asp:ListItem>
                                                        <asp:ListItem Text="01 Central Govt. / Union Territory" Value="01 Central Govt. / Union Territory"></asp:ListItem>
                                                        <asp:ListItem Text="02 State Goverment" Value="02 State Goverment"></asp:ListItem>
                                                        <asp:ListItem Text="03 Local Authority" Value="03 Local Authority"></asp:ListItem>
                                                        <asp:ListItem Text="04 Central Govt. Co. / Corp.Estb.Central Act" Value="04 Central Govt. Co. / Corp.Estb.Central Act"></asp:ListItem>
                                                        <asp:ListItem Text="05 State Govt. Co. / Corp.Estb. by State" Value="05 State Govt. Co. / Corp.Estb. by State"></asp:ListItem>
                                                        <asp:ListItem Text="06 Other Company" Value="06 Other Company"></asp:ListItem>
                                                        <asp:ListItem Text="07 Firm" Value="07 Firm"></asp:ListItem>
                                                        <asp:ListItem Text="08 Individual" Value="08 Individual"></asp:ListItem>
                                                        <asp:ListItem Text="09 Others" Value="09 Others"></asp:ListItem>
                                                        <asp:ListItem Text="10 Commission &amp; Progress" Value="10 Commission &amp; Progress"></asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please Select Class !"
                                                        ControlToValidate="ddlClass" ForeColor="Red" ValidationGroup="validThis" InitialValue="0">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                                    <tr>
                                                <td>
                                                    State
                                                </td>
                                                <td colspan="3">
                                                    <asp:DropDownList ID="ddlState" runat="server" CssClass="cssDropDownList">
                                                    </asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Please Select Deductor State !"
                                                        ForeColor="Red" ControlToValidate="ddlState" ValidationGroup="validThis" InitialValue="0">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                                    <tr>
                                                <td>
                                                    Pincode
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtPincode" runat="server" CssClass="cssTextbox" MaxLength="6" onkeypress="return isNumberKey(event)"
                                                        Width="100px"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Please Enter Deductor Pincode !"
                                                        ControlToValidate="txtPincode" ForeColor="Red" ValidationGroup="validThis">*</asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    STD-Code
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtSTD_code" runat="server" CssClass="cssTextbox" onkeypress="return isNumberKey(event)"
                                                        Width="100px" MaxLength="4"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Please Enter Deductor STD Code !"
                                                        ForeColor="Red" ControlToValidate="txtSTD_code" ValidationGroup="validThis">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                                    <tr>
                                                <td>
                                                    Tel
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtTel_NO" runat="server" CssClass="cssTextbox" Width="100px" onkeypress="return isNumberKey(event)"
                                                        MaxLength="11"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="Please Enter Deductor Tel No. !"
                                                        ControlToValidate="txtTel_NO" ForeColor="Red" ValidationGroup="validThis">*</asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    Fax
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFax" runat="server" CssClass="cssTextbox" onkeypress="return isNumberKey(event)"
                                                        Width="100px"></asp:TextBox>

                                                </td>
                                            </tr>
                                                    <tr>
                                                <td>
                                                    TAN No.
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox runat="server" ID="txtTANNo" Style="text-transform: uppercase;" CssClass="cssTextbox"
                                                        MaxLength="10"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="txtTANNo"
                                                        ErrorMessage="Please Enter TAN No. !" ForeColor="Red" ValidationGroup="validThis">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                                    <tr>
                                                <td>
                                                    PAN No.
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox runat="server" ID="txtPANNo" Style="text-transform: uppercase;" CssClass="cssTextbox"
                                                        MaxLength="10"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ErrorMessage="Please Enter PAN No. !"
                                                        ControlToValidate="txtPANNo" ForeColor="Red" ValidationGroup="validThis">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                                    <tr>
                                                <td>
                                                    Place
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox runat="server" ID="txtPlace" CssClass="cssTextboxRed"></asp:TextBox>
                                                </td>
                                            </tr>
                                                    <tr>
                                                <td>
                                                    GSTN
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox runat="server" ID="TxtGSTN" CssClass="cssTextboxRed" style="border-color:#FF5733;" maxlength="15"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="Please Enter GSTN Number !"
                                                        ControlToValidate="TxtGSTN" ForeColor="Red" ValidationGroup="validThis" InitialValue="0">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                                    <tr>
                                                <td colspan="4">
                                                    <asp:CheckBox ID="chkChange_Deductor" runat="server" CssClass="cssLabel" Text="Change address deduction since last return" />
                                                </td>
                                            </tr>
                                                    <tr>
                                                <td colspan="4">
                                                    <fieldset>
                                                        <legend>Alternate Details</legend>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    Email ID
                                                                </td>
                                                                <td colspan="3">
                                                                    <asp:TextBox runat="server" ID="txtAlt_EmailID" CssClass="cssTextbox" Width="270px"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator14" ControlToValidate="txtAlt_EmailID"
                                                                        runat="server" ErrorMessage="Please Enter Deductor Alternate Email ID !" ForeColor="Red"
                                                                        ValidationGroup="validThis">*</asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtAlt_EmailID"
                                                                        ErrorMessage="Please Enter Deductor Altername Valid Email ID !" ForeColor="Red"
                                                                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="validThis">*</asp:RegularExpressionValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Tel
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox runat="server" ID="txtAlt_Tel_NO" Width="100px" onkeypress="return isNumberKey(event)"
                                                                        CssClass="cssTextbox" MaxLength="11"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ControlToValidate="txtAlt_Tel_NO"
                                                                        ErrorMessage="Please Deductor Enter Alternate Tel No. !" ForeColor="Red" ValidationGroup="validThis">*</asp:RequiredFieldValidator>
                                                                </td>
                                                                <td>
                                                                    STD-Code
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox runat="server" ID="txtAlt_STDcode" onkeypress="return isNumberKey(event)"
                                                                        Width="100px" CssClass="cssTextbox" MaxLength="4"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ControlToValidate="txtAlt_STDcode"
                                                                        ErrorMessage="Please Deductor Enter Alternate STD Code !" ForeColor="Red" ValidationGroup="validThis">*</asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                               </table>
                                            </fieldset>
                                           </td>
                                            <td>
                                                <fieldset style="margin: 0px;">
                                                    <legend>Responsible Person Details</legend>
                                                    <table width="100%">
                                                        <tr>
                                                            <td colspan="4">
                                                                <asp:CheckBox ID="chk_SameAs" onclick="return (Are You sure);" Text="Same As Deductor Details"
                                                                    runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                Name
                                                            </td>
                                                            <td colspan="3">
                                                                <asp:TextBox ID="txtR_Name" runat="server" CssClass="cssTextbox" Width="300px"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator28" runat="server" ControlToValidate="txtR_Name"
                                                                    ErrorMessage="Please Enter Responsible Responsible Name !" ForeColor="Red" ValidationGroup="validThis">*</asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                Flat No
                                                            </td>
                                                            <td colspan="3">
                                                                <asp:TextBox ID="txtR_Flat_No" runat="server" CssClass="cssTextbox"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator27" runat="server" ControlToValidate="txtR_Flat_No"
                                                                    ErrorMessage="Please Enter Responsible  Flat No !" ForeColor="Red" ValidationGroup="validThis">*</asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                Name Of Building
                                                            </td>
                                                            <td colspan="3">
                                                                <asp:TextBox ID="txtR_Building" runat="server" CssClass="cssTextbox" Width="300px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                Road/Street
                                                            </td>
                                                            <td colspan="3">
                                                                <asp:TextBox ID="txtR_Street" runat="server" CssClass="cssTextbox" Width="300px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                Area/Location
                                                            </td>
                                                            <td colspan="3">
                                                                <asp:TextBox ID="txtR_Area_Location" runat="server" CssClass="cssTextbox" Width="300px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                Town/City
                                                            </td>
                                                            <td colspan="3">
                                                                <asp:TextBox ID="txtR_Town_City" runat="server" CssClass="cssTextbox" Width="300px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                Email ID
                                                            </td>
                                                            <td colspan="3">
                                                                <asp:TextBox ID="txtR_EmailID" runat="server" CssClass="cssTextbox"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator26" runat="server" ControlToValidate="txtR_EmailID"
                                                                    ErrorMessage="Please Enter Responsible Responsible Email ID !" ForeColor="Red"
                                                                    ValidationGroup="validThis">*</asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtR_EmailID"
                                                                    ErrorMessage="Please Enter Responsible  Valid Email ID !" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                                    ValidationGroup="validThis">*</asp:RegularExpressionValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                Designation
                                                            </td>
                                                            <td colspan="3">
                                                                <asp:TextBox runat="server" ID="txt_Designation" CssClass="cssTextbox"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator25" runat="server" ControlToValidate="txt_Designation"
                                                                    ErrorMessage="Please Enter Responsible Designation !" ForeColor="Red" ValidationGroup="validThis">*</asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                PAN No
                                                            </td>
                                                            <td colspan="3">
                                                                <asp:TextBox runat="server" AutoPostBack="True" MaxLength="10" Style="text-transform: uppercase;"
                                                                    ID="txtContactPAN" CssClass="cssTextbox" OnTextChanged="txtContactPAN_TextChanged"></asp:TextBox>
                                                                <asp:TextBox runat="server" Style="border-style:hidden; text-transform: uppercase;" ID="lblPanVerified"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtContactPAN"
                                                                    ErrorMessage="Please Enter Responsible PAN Number !" ForeColor="Red" ValidationGroup="validThis">*</asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                State
                                                            </td>
                                                            <td colspan="3">
                                                                <asp:DropDownList ID="ddlR_State" runat="server" CssClass="cssDropDownList">
                                                                    <asp:ListItem Text="(Select State)" Value="0"></asp:ListItem>
                                                                    <asp:ListItem Text="Maharastra" Value="99"></asp:ListItem>
                                                                    <asp:ListItem Text="Gujarat" Value="100"></asp:ListItem>
                                                                </asp:DropDownList>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator24" runat="server" ControlToValidate="ddlR_State"
                                                                    ErrorMessage="Please Enter Responsible  State !" ForeColor="Red" ValidationGroup="validThis"
                                                                    InitialValue="0">*</asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                Mobile No
                                                            </td>
                                                            <td colspan="3">
                                                                <asp:TextBox ID="txtR_MobileNo" runat="server" CssClass="cssTextbox" onkeypress="return isNumberKey(event)"
                                                                    MaxLength="10"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator23" runat="server" ControlToValidate="txtR_MobileNo"
                                                                    ErrorMessage="Please Enter Responsible  Mobile No. !" ForeColor="Red" ValidationGroup="validThis">*</asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                Pincode
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtR_Pincode" runat="server" CssClass="cssTextbox" onkeypress="return isNumberKey(event)"
                                                                    Width="100px" MaxLength="6"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" ControlToValidate="txtR_Pincode"
                                                                    ErrorMessage="Please Enter Responsible  Pincode !" ForeColor="Red" ValidationGroup="validThis">*</asp:RequiredFieldValidator>
                                                            </td>
                                                            <td>
                                                                STD-Code
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtR_STD_Code" runat="server" CssClass="cssTextbox" onkeypress="return isNumberKey(event)"
                                                                    Width="100px" MaxLength="4"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" ControlToValidate="txtR_STD_Code"
                                                                    ErrorMessage="Please Enter Responsible  STD Code !" ForeColor="Red" ValidationGroup="validThis">*</asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                Tel
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtR_Tel_NO" runat="server" CssClass="cssTextbox" onkeypress="return isNumberKey(event)"
                                                                    Width="100px" MaxLength="11"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" ControlToValidate="txtR_Tel_NO"
                                                                    ErrorMessage="Please Enter Responsible  Tel No. !" ForeColor="Red" ValidationGroup="validThis">*</asp:RequiredFieldValidator>
                                                            </td>
                                                            <td>
                                                                Fax
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtR_Fax" runat="server" CssClass="cssTextbox" onkeypress="return isNumberKey(event)"
                                                                    Width="100px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4">
                                                                <asp:CheckBox ID="chkChange_Responsible" runat="server" CssClass="cssLabel" Text="Change address of Resp. Person since last return" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4">
                                                                <fieldset>
                                                                    <legend>Alternate Responsible Details</legend>
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                Email-ID
                                                                            </td>
                                                                            <td colspan="3">
                                                                                <asp:TextBox ID="txtALT_R_EmailID" Width="270px" runat="server" CssClass="cssTextbox"></asp:TextBox>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" ControlToValidate="txtALT_R_EmailID"
                                                                                    ErrorMessage="Please Enter Responsible Alternate Email ID !" ForeColor="Red"
                                                                                    ValidationGroup="validThis">*</asp:RequiredFieldValidator>
                                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtALT_R_EmailID"
                                                                                    ErrorMessage="Please Enter Responsible Alternate Valid Email ID !" ForeColor="Red"
                                                                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="validThis">*</asp:RegularExpressionValidator>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                Tel
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtALT_R_Tel_NO" runat="server" CssClass="cssTextbox" onkeypress="return isNumberKey(event)"
                                                                                    Width="100px" MaxLength="11"></asp:TextBox>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ControlToValidate="txtALT_R_Tel_NO"
                                                                                    ErrorMessage="Please Enter Responsible Alternate Tel No. !" ForeColor="Red" ValidationGroup="validThis">*</asp:RequiredFieldValidator>
                                                                            </td>
                                                                            <td>
                                                                                STD-Code
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtALT_R_STD_Code" runat="server" CssClass="cssTextbox" onkeypress="return isNumberKey(event)"
                                                                                    Width="100px" MaxLength="4"></asp:TextBox>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" ControlToValidate="txtALT_R_STD_Code"
                                                                                    ErrorMessage="Please Enter Responsible Alternate STDCode !" ForeColor="Red" ValidationGroup="validThis">*</asp:RequiredFieldValidator>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </fieldset>
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </fieldset>
                                                <fieldset style="height: 62px; text-align: center; border-color: White; margin: 0px;">
                                                    <br />
                                                    <asp:CustomValidator ID="CustomValidator1" ClientValidationFunction="ValidatePANNo"
                                                        ValidationGroup="validThis" runat="server" ErrorMessage="Please Enter Valid PAN No. !"></asp:CustomValidator>
                                                    <asp:Button ID="btnSubmit" runat="server" ValidationGroup="validThis" CssClass="cssButton"
                                                        Text="Submit" OnClick="btnSubmit_Click" />
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <asp:Button ID="btnCancel" runat="server" CssClass="cssButton" Text="Cancel" OnClick="btnCancel_Click" />
                                                    <br />
                                                </fieldset>
                                            </td>
                                         </tr>
                                     </table>
                                </ContentTemplate>
                            </cc1:TabPanel>
                            <cc1:TabPanel  ID="TabPanel2" Width="100%" runat="server" HeaderText="Admin Details">
                                <ContentTemplate>
                                    <table id="Table10" runat="server" style="margin-top: 0px; padding-top: 0px; width: 1182px;">
                                        <tr style="height:15px;">
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr >
                                            <td align="left" style="width:160px;">
                                                <asp:Label ID="Label5" runat="server" CssClass="cssLabel" Text="UserID"></asp:Label>
                                            </td>
                                            <td align="left" width="300px">
                                                <asp:TextBox runat="server" ID="TxtUser" Width="250px" CssClass="cssTextbox"></asp:TextBox>
                                                &nbsp;&nbsp;&nbsp;
                                                <asp:Label ID="Label12" runat="server" CssClass="cssLabel" Text="*" ForeColor="#FF3300"></asp:Label>
                                                <asp:HiddenField ID="hdnUID" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="width:160px">
                                                <asp:Label ID="Label6" runat="server" CssClass="cssLabel" Text="Password"></asp:Label>
                                            </td>
                                            <td align="left" width="300px" runat="server">
                                                <asp:TextBox runat="server" ID="TxtPassword" Width="150px" CssClass="cssTextbox"></asp:TextBox>
                                                &nbsp;&nbsp;&nbsp;
                                                <asp:Label ID="Label13" runat="server" CssClass="cssLabel" Text="*" ForeColor="#FF3300"></asp:Label>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="width:160px;">
                                                
                                                <asp:Label ID="Label3" runat="server" CssClass="cssLabel" Text="Contact Person"></asp:Label>
                                            </td>
                                            <td align="left" >
                                                <asp:TextBox runat="server" ID="txtContactperson" Width="250px" CssClass="cssTextbox"></asp:TextBox>
                                                &nbsp;&nbsp;&nbsp;
                                                <asp:Label ID="Label9" runat="server" CssClass="cssLabel" Text="*" ForeColor="#FF3300"></asp:Label>

                                            </td>


                                        </tr>
                                        <tr>
                                            <td align="left" style="width:160px;">
                                               <asp:Label ID="Label7" runat="server" CssClass="cssLabel" Text="Email"></asp:Label>
                                            </td>
                                            <td align="left" runat="server" >
                                                <asp:TextBox runat="server" ID="TxtEmail" Width="250px" CssClass="cssTextbox"></asp:TextBox>
                                                &nbsp;&nbsp;&nbsp;
                                                <asp:Label ID="Label11" runat="server" CssClass="cssLabel" Text="*" ForeColor="#FF3300"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="width:160px;">
                                                <asp:Label ID="Label4" runat="server" CssClass="cssLabel" Text="Mobile"></asp:Label>
                                            </td>
                                            <td align="left" runat="server">
                                                <asp:TextBox runat="server" ID="txtContactnumber" MaxLength="10" Width="250px" onkeypress="return isNumberKey(event)"
                                                    CssClass="cssTextbox"></asp:TextBox>
                                                &nbsp;&nbsp;&nbsp;
                                                <asp:Label ID="Label10" runat="server" CssClass="cssLabel" Text="*" ForeColor="#FF3300"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr  >
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td runat="server">
                                                <fieldset style="height: 32px; text-align: center; border-color: White; margin: 0px; width: 297px;">
                                                    <br />
                                                    <input id="btnAdmin" type="button"  class="cssButton" value="Submit" />
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <asp:Button id="btnClose" runat="server"  Cssclass="cssButton" text="Cancel" OnClick="btnClose_Click" />
                                                    <br />
                                                </fieldset>

                                            </td>
                                        </tr>

                                    </table> 
                                </ContentTemplate>     
                            </cc1:TabPanel>
                        </cc1:TabContainer> 
                    </td>
                </tr>
            </table>



            <asp:HiddenField ID="hdnCompanyid" runat="server" />
            <asp:HiddenField ID="hdnValid" runat="server" />
<%--        --%>
<%--        <Triggers>
            <asp:PostBackTrigger ControlID="btnSubmit" />
        </Triggers>
    </asp:UpdatePanel>--%>
</asp:Content>
