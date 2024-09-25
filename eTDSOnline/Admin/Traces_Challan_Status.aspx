<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" 
    CodeFile="Traces_Challan_Status.aspx.cs" Inherits="Admin_Traces_Challan_Status" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit"   TagPrefix="asp" %>
<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../Scripts/Jquery3.5.1.js" type="text/javascript"></script>
 
 

        <script type="text/javascript" language="javascript">

            $(document).ready(function () {

                $("[id*=lblSuccess]").hide();
                $("[id*=btnPanVerification]").hide();
                $("[id*=lblProcess]").hide();
                $("[id*=tblTracesLogin]").hide();
                $("[id*=ddlFromType]").val($("[id*=hdnForm]").val());
                $("[id*=ddlQuater]").val($("[id*=hdnQuater]").val());
                $("[id*=ddlstatus]").val('Non');
                $("[id*=hdnPages]").val(1);
                $("[id*=hdnSize]").val(500);
                $("[id*=tblrslt]").hide();
                $("[id*=txtTan]").attr("disabled", true);
                $("[id*=ddlstatus]").val('All');

                

                //$("[id*=PnvVerfy]").click(function () {

                //    ShowModalPopup();
                //    loadLoginDetails();
                //    getCaptcha();
                //});

                $("[id*=imgRsh]").click(function () {
                    loadLoginDetails();
                    getCaptcha();
                });

                $("[id*=btnGetRequest]").click(function () {
                    ChallanRequestTrace();
                });

            });

            function HideModalPopup() {
                $(".MastermodalBackground2").hide();
                $find("programmaticModalPopupOrginalBehavior").hide();

            }
            ///// show modalpopup
            function ShowModalPopup() {
                $find("programmaticModalPopupOrginalBehavior").show();

            }

            function Verifystatus() {
                $("[id*=btnPanVerification]").hide();
            }


           function ChallanRequestTrace () {


                var UserID = $("#txtUserID").val();
                var Password = $("#txtPassword").val();
                var TAN_NO = $("#txtTan").val();

                var CaptchaCode = $("#captcha").val();
                var frm = '01-04-2023'; //$("[id*=txt_frm]").val();
                var to = '20-02-2024';//$("[id*=txt_to]").val();
                var sts = $("[id*=drpSts]").val();
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
                        ChallanStatus: sts,
                        FromDT: frm,
                        ToDate: to,
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
                $("[id*=lblProcess]").show();

                $(".MastermodalBackground2").show();
                document.getElementById("btnGetRequest").disabled = true;

                //debugger;
                $.ajax({
                    type: "POST",
                    url: "TService.asmx/Challan_Verification",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify(tracesData),
                    success: function (data) {
                        //  debugger;
                        var result = JSON.parse(data.d);
                        if (result.error) {
                            $("#captcha").val("");
                            //getCaptcha();
                            $(".MastermodalBackground2").hide();
                            ShowErrorWindow(result.error);
                            $("[id*=lblSuccess]").hide();
                            $("[id*=lblProcess]").hide();
                            document.getElementById("btnGetRequest").disabled = false;
                            return false;
                        }
                        else {
                            if (result.success) {
                                $("#captcha").val("");
                                //getCaptcha();
                                //var tbl_html_val = "<div><span style='padding-right:20px;'>PAN : <b>" + PAN + "</b> </span><span>Name : <b>" + result.success.Name + "</b> </span></div>";
                                //$("#divData").html(tbl_html_val);
                                $("[id*=hdnValid]").val('Valid PAN');
                                $(".MastermodalBackground2").hide();
                                $("[id*=lblSuccess]").show();
                                $("[id*=lblProcess]").hide();
                                Get_Details();
                                $("[id*=btnPanVerification]").show();
                                $("[id*=btnPanVerification]").click();
                                document.getElementById("btnGetRequest").disabled = false;
                                $(".MastermodalBackground2").hide();
                                return false;
                            }
                            if (result.timeout) {
                                $("#captcha").val("");
                                //getCaptcha();
                                //var tbl_html_val = "<div><span style='padding-right:20px;'>PAN : <b>" + PAN + "</b> </span><span>Name : <b>" + result.success.Name + "</b> </span></div>";
                                //$("#divData").html(tbl_html_val);
                                $("[id*=hdnValid]").val('Valid PAN');
                                $(".MastermodalBackground2").hide();
                                $("[id*=lblSuccess]").show();
                                $("[id*=lblSuccess]").html('Timeout occured, Few PAN no validated, retry');
                                $("[id*=lblProcess]").hide();
                                $("[id*=btnPanVerification]").show();
                                $("[id*=btnPanVerification]").click();
                                document.getElementById("btnGetRequest").disabled = false;
                                $(".MastermodalBackground2").hide();
                                return false;
                            }
                            if (result.Failed) {
                                $("[id*=btnPanVerification]").hide();
                            }
                        }
                    },
                    failure: function (response) {
                        $("#captcha").val("");
                        //getCaptcha();
                        document.getElementById("btnGetRequest").disabled = false;
                        $(".MastermodalBackground2").hide();
                        ShowErrorWindow(response.d);
                    }
                });

                return false;
            }


            //reuestDownloads
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
            //reuestDownloads
            SaveTracesDetails = function () {
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


            function focusfrm() {
                $get('<%= txt_frm.ClientID %>').focus();
            }
            function focusto() {
                $get('<%= txt_To.ClientID %>').focus();
            }
        </script>

 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:HiddenField ID="hdnValid" runat="server" />
    <asp:HiddenField ID="hdnCompanyID" runat="server" />
    <asp:HiddenField ID="hdnQuater" runat="server" />
    <asp:HiddenField ID="hdnForm" runat="server" />    
    <asp:HiddenField ID="hdnDate" runat="server" />
    <asp:HiddenField ID="hdnPages" runat="server" />
    <asp:HiddenField ID="hdnSize" runat="server" />    

    <asp:UpdatePanel runat="server" ID="UpdatePanel2">
        <ContentTemplate>
            <table id="Table1" runat="server" width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="cssPageTitle">
                        <asp:Label ID="Label1" runat="server" Font-Bold="true" Text="Non Salary Pan Verification"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table>
                            <tr>
                                <td style="font-family: Verdana; font-weight:bold; ">Date
                                </td>
                                <td id="tdQrtr" name="tdQrtr" runat="server" >
                                    <input ID="txt_frm"  runat="server" placeholder="DD/MM/YYYY" class="cssTextbox"
                                         type="date"></input>
                                </td>
                                <td id="tdfrm" name="tdfrm" runat="server" >To Date
                                </td>
                                    <td>

                                    <input ID="txt_To" runat="server" placeholder="DD/MM/YYYY" class="cssTextbox"
                                        type="date"></input>
                                    
                                </td>      
                                <td>Status

                                </td>
                                <td>
                                    <select runat="server" id="drpSts" class="cssDropDownList" style="width: 100px; height: 25px;">
                                        <option value="">Select</option>
                                        <option value="A">All</option>
                                        <option value="M">Claimed</option>
                                        <option value="U">UnClaimed</option>
                                         
                                    </select>
                                </td>
                                <td>
                                    <input id="btnSearch" name="btnSave" tabindex="18" class="cssButton rightSave" value="Search" type="button" />
                                </td>
                            </tr>
   
                            </table>
                    </td>
                </tr>

                <tr>
                    <td runat="server" id="tdSearch" style="padding:10px;">
                        <center>
                            <asp:Label ID="lbldgVoucherModify" runat="server"></asp:Label>
                            <table id="tblPANLnk"></table>
                            <table id="tblPager" style="border: 1px solid #BCBCBC; height: 50px; width: 100%">
                                <tr>
                                    <td>
                                        <div class="Pager">
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </center>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>

   <asp:Button Style="display: none" ID="hideModalPopupViaClientOrginal" runat="server"></asp:Button><br />
    <asp:ModalPopupExtender BackgroundCssClass="modalBackground" BehaviorID="programmaticModalPopupOrginalBehavior"
        RepositionMode="RepositionOnWindowScroll" DropShadow="False" ID="ModalPopupExtender2"
        TargetControlID="hideModalPopupViaClientOrginal" CancelControlID="imgBudgetdClose"
        PopupControlID="panel10" runat="server">
    </asp:ModalPopupExtender>

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
        <div style="padding: 5px 5px 5px 5px; height:355px;" id="addtasks" runat="server" class="comprw">
            <div id="divJb" class="divedBlock" style="padding-top: 10px;height: 295px;">

                <div style="overflow: hidden; width: 680px; height: 290px; float: left; padding-left: 5px;">
                    <img alt="" src="../images/tds-logo.png" id="imgTraces" border="0" name="imgTraces"  />
                    <asp:Panel ID="pnljb" runat="server"  Height="290px" Width="680px">
                    <table width="100%" >
                        <tr>
                            <td valign="top" width="100%">

                                <div class="gridloader">
                                </div>
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
                                            <input id="txtTan" class="cssTextbox" type="text" style="width: 120px;" value=""  autocomplete="none"  />
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
                                            <input id="txtPassword" class="cssTextbox" style="width: 120px;" type="text" value="" />
                                        </td>

                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>
                                            <input type="submit" name="btnSaveRequest" value="Save" id="btnSaveRequest" class="cssButton" onclick="return SaveTracesDetails();" /></td>
                                    </tr>
                                </table>



                            </td>
                        </tr>
                    </table>
                        <table id="tblver" name="tblver" >

                            <tr id="trAuto1" name="trAuto1">
                                <td style="text-align:right;">
                                    <img id="captchaImg" class="captchaimg1" alt="Captcha" src="" /></td>
                                <td>
                                    <img id="imgRsh" src="../Images/refresh.png" style="width: 20px; padding-right: 10px; cursor: pointer;"  />
                                    <label style="font-weight: bold;">Click to refresh image</label>

                                </td>
                            </tr>
                            <tr style="height:15px;" >
                                <td>
                                    <label id="lblProcess" style="padding-right:20px;font-size:18px;  font-weight:bold; color:red;  border :none ;">Verifing PAN, Please wait .......</label>
                                </td>
                            </tr>
                            <tr id="trAuto2" name="trAuto2" >
                                <td style="text-align:left;">
                                   <input autocomplete="off" id="captcha" class="frmtxtbox" maxlength="5"  style="width:100px; " value="" />
                                </td>
                                <td style="font-weight: bold;font-size:14px; text-align:right;">Enter text as in above image</td>

                             </tr>
                            <tr style="height:15px;" >
                                <td>
                                    <label id="lblSuccess" style="padding-right:20px;font-size:18px; font-weight:bold; border:none ; color:green; ">PAN Verified Success</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="submit" name="btnGetRequest" value="Request" id="btnGetRequest" class="cssButton"   />
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


