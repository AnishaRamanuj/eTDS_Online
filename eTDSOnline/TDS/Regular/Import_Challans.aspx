<%@ Page Title="" Language="C#" MasterPageFile="~/TDS/BTS_MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="Import_Challans.aspx.cs" Inherits="Admin_Import_Challans" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <%--<script src="../Scripts/Jquery3.5.1.js" type="text/javascript"></script>--%>

<%--    <link href="../css/common.css" rel="stylesheet" />--%>


    <style type="text/css">
        #tblChln table {
          font-family: arial, sans-serif;
          border-collapse: collapse;
          width: 100%;
        }

        #tblChln td, th {
          border: 1px solid #dddddd;
          text-align: left;
          padding: 8px;
        }

        #tblChln tr:nth-child(even) {
          background-color: #dddddd;
        }
    </style>


    <script type="text/javascript">
        var link = '';
        var rowData;
        var editedChlnAmt;
        $(document).ready(function () {


            $("[id*=imgRsh]").click(function () {
                loadLoginDetails();
                getCaptcha();
            });

            $("[id*=btnVerify]").click(function () {
                ShowModalPopup();
                loadLoginDetails();
                getCaptcha();
                $("[id*=hdnReqst]").val('Con');
            });
        });

        $(document).on('click', '[id*=btnConsumption]', function (e) {
            ShowModalPopup();
            loadLoginDetails();
            getCaptcha();
            $("[id*=hdnReqst]").val('Search Challan');
        });

        function ShowLoader() {

            $('.MastermodalBackground2').css("display", "block");
        }

        function hideloader() {

            $('.MastermodalBackground2').css("display", "none");
        }

        function HideModalPopup() {
            $find("programmaticModalPopupOrginalBehavior").hide();
            hideloader();
            $("[id*=lblProcess]").hide();
            $("[id*=lblSuccess]").hide();
        }
        ///// show modalpopup
        function ShowModalPopup() {

            $find("programmaticModalPopupOrginalBehavior").show();
            $("[id*=lblProcess]").hide();
            $("[id*=lblSuccess]").hide();
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
                    alert(response.d);
                }
            });


            return false;
        }

        function getCaptcha() {
            //get Captcha       
            $("#imgajaxLoader").show();
            $.ajax({
                type: "POST",
                url: "TService.asmx/tCaptcha",
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                success: function (data) {
                    var result = JSON.parse(data.d);
                    Cookies = result[0]["Cookie"];
                    document.getElementById("captchaImg").src = result[0]["base64"];
                    $("#imgajaxLoader").hide();
                    $("#tblCaptcha").show();
                },
                failure: function (response) {
                    $("#imgajaxLoader").hide();
                    alert(response.d);
                }
            });

        }
        function loadLoginDetails() {
            $("[id*=tblTracesLogin]").hide();
            $("#imgajaxLoader").show();
            $.ajax({
                type: "POST",
                url: "TService.asmx/Get_tracesLoginDetails",
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                success: function (data) {
                    var result = JSON.parse(data.d);
                    if (result.error) {
                        alert(result.error);
                        $("[id*=tblTracesLogin]").show();
                        $("[id*=tblver]").hide();
                        return false;
                    }
                    else {
                        //loop Challan Details
                        var dt_Login = JSON.parse(result["dt_Login"]);
                        if (dt_Login.length > 0) {
                            var Login_dtls = dt_Login[0];
                            $("#txtTan").val(Login_dtls["Tan"]);
                            $("#txtUserID").val(Login_dtls["User_ID"]);
                            $("#txtPassword").val(Login_dtls["Password"]);
                        }
                        else {

                            $("#txtTan").val($("[id*=txtTanNo]").val());
                            $("[id*=tblTracesLogin]").show();
                            $("[id*=tblver]").hide();
                        }
                        $("#imgajaxLoader").hide();

                    }
                },
                failure: function (response) {
                    $("#imgajaxLoader").hide();
                    alert(response.d);
                }
            });

        }


        RequestTrace = function () {
            var rq = $("[id*=hdnReqst]").val();
            if (rq == 'Con') {
                GetConsumption(rowData, editedChlnAmt);
            }
            else {
                var UserID = $("#txtUserID").val();
                var Password = $("#txtPassword").val();
                var TAN_NO = $("#txtTan").val();
                var compid = $("[id*=hdnCompanyid]").val();
                var CaptchaCode = $("#captcha").val();

                var Currentdt = new Date();
                var dd = Currentdt.getDate();
                var mm = Currentdt.toLocaleString('en-US', { month: 'short' });
                var yy = Currentdt.getFullYear();
                var FY = $("[id*=ddlFinancialYear] :selected").text()
                var fyy = FY.split('_')[0];

                if (dd < 10) {
                    dd = '0' + dd;
                }
                //if (mm < 10) {
                //    mm = '0' + mm;
                //}
                // fyy = fyy.toString().slice(-2);
                var d = '01';
                var m = 'Apr';
                d = d.toString();
                m = m.toString();
                fyy = fyy.toString();
                dd = dd.toString();
                mm = mm.toString();
                yy = yy.toString();



                var frm = d + '-' + m + '-' + fyy; //  '01-Apr-2023';
                var to = dd + '-' + mm + '-' + yy;  //$("[id*=txt_to]").val();
                var sts = 'All'; //$("[id*=drpSts]").val();

                var Q = $("[id*=ddltype]").val();
                var F = $("[id*=ddlForm]").val();
                if ((UserID == null || UserID == "") || (Password == null || Password == "")) {
                    alert('Enter User Login Details');
                    return false;
                }


                if (TAN_NO == null || TAN_NO == undefined) {
                    alert('TAN - Cannot be Blank');
                    return false;
                }

                if (compid == "" || compid == null || compid == undefined) {
                    compid = 0;
                }


                var tracesData = {
                    "objTraceData": {
                        ChallanStatus: sts,
                        FromDT: frm,
                        ToDate: to,
                        Compid: compid,
                        Quarter: Q,
                        Forms: F

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
                $("[id*=lblSuccess]").hide();

                $(".MastermodalBackground2").show();
                document.getElementById("btnGetRequest").disabled = true;

                //debugger;
                $.ajax({
                    type: "POST",
                    /*url: "TService.asmx/Challan_Traces",*/
                    url: "TService.asmx/Import_Challan_Traces",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify(tracesData),
                    success: function (data) {
                        document.getElementById("btnGetRequest").disabled = false;
                        HideModalPopup();
                        hideloader();
                        var result = JSON.parse(data.d);
                        if (result.error) {
                            $("#captcha").val("");
                            //getCaptcha();

                            alert(result.error);
                            $("[id*=lblSuccess]").hide();
                            $("[id*=lblProcess]").hide();

                            return false;
                        }
                        else {
                            if (result.success) {
                                $("[id*=lblSuccess]").show();
                                $("#captcha").val("");

                                //var btn = document.getElementById("ctl00_MasterPage_btnGenerateTextFile");
                                //document.getElementById("ctl00_MasterPage_btnGenerateTextFile").style.display = "block";
                                //btn.click();

                                var tblData = result.success;
                                var tbody = $('#tblChln tbody');
                                tbody.empty();
                                var tr = "";
                                for (var i = 0; i < tblData.length; i++) {
                                    tr += "<tr>"
                                    tr += "<td style='text-align: center;'>" + (parseFloat(i) + 1) + "</td>";
                                    tr += "<td>" + tblData[i].bankCode + tblData[i].branchCode + "</td>";
                                    tr += "<td>" + tblData[i].dateOfDep + "</td>";
                                    tr += "<td>" + tblData[i].chlnSNo + "</td>";
                                    tr += "<td>" + tblData[i].chlnStatus + "</td>";
                                    tr += "<td>" + tblData[i].recptNum + "</td>";
                                    tr += "<td ><input type='checkbox' class='Chkbox' id='chkApp'  name='chkApp'  /></td>";
                                    tr += "<td style='text-align: right;' contenteditable='true' oninput='validateNumericInput(this)'></td>";
                                    tr += "<td><a href='#' onclick='matchChallanAmount(this, " + JSON.stringify(tblData[i]) + ", this.parentNode.previousElementSibling.textContent)'>Match Challan Amount</a></td>";
                                    //tr += "<td><a href='#' style='display:none;' onclick=''>Update To Database</a></td>";
                                    tr += "</tr>"
                                }
                                tbody.append(tr);

                            }
                            if (result.timeout) {
                                $("#captcha").val("");
                                $("[id*=lblProcess]").hide();
                                $("[id*=lblSuccess]").hide();
                                return false;
                            }
                            if (result.Failed) {
                                alert(response.d);
                                $("[id*=lblProcess]").hide();
                                $("[id*=lblSuccess]").hide();
                            }
                        }
                    },
                    failure: function (response) {
                        $("#captcha").val("");
                        //getCaptcha();
                        document.getElementById("btnGetRequest").disabled = false;
                        $(".MastermodalBackground2").hide();
                        alert(response.d);
                        $("[id*=lblProcess]").hide();
                        $("[id*=lblSuccess]").hide();
                    }
                });

                return false;
            }
        }

        function saveData() {

            $("input[name=chkApp]:checked").each(function () {
                var t = row.find("input[name=hdnStatus]").val();
            });
        }

        function validateNumericInput(element) {
            var value = element.innerText;
            var newValue = value.replace(/[^\d]/g, '');
            if (newValue !== value) {
                element.innerText = newValue;
            }
        }

        function matchChallanAmount(lnk, rd, echlamt) {
            ShowModalPopup();
            loadLoginDetails();
            getCaptcha();

            link = lnk;
            rowData = rd;
            editedChlnAmt = echlamt;
            $("[id*=hdnReqst]").val('Con');
            //var success = GetConsumption(rowData, editedChlnAmt);
            //if (success) {
            //    $(link).closest('tr').find('td:last-child a').show();
            //}
        }

        function ChallanAmt(link, rowData, editedChlnAmt) {
            var success = GetConsumption(rowData, editedChlnAmt);
            if (success) {
                $(link).closest('tr').find('td:last-child a').show();
            }

        }

        function GetConsumption(rowData, editedChlnAmt) {

            var UserID = $("#txtUserID").val();
            var Password = $("#txtPassword").val();
            var TAN_NO = $("#txtTan").val();
            var compid = $("[id*=hdnCompanyid]").val();
            var CaptchaCode = $("#captcha").val();

            var Currentdt = new Date();
            var dd = Currentdt.getDate();
            var mm = Currentdt.toLocaleString('en-US', { month: 'short' });
            var yy = Currentdt.getFullYear();
            var FY = $("[id*=ddlFinancialYear] :selected").text()
            var fyy = FY.split('_')[0];

            if (dd < 10) {
                dd = '0' + dd;
            }
            //if (mm < 10) {
            //    mm = '0' + mm;
            //}
            // fyy = fyy.toString().slice(-2);
            var d = '01';
            var m = 'Apr';
            d = d.toString();
            m = m.toString();
            fyy = fyy.toString();
            dd = dd.toString();
            mm = mm.toString();
            yy = yy.toString();



            var frm = d + '-' + m + '-' + fyy; //  '01-Apr-2023';
            var to = dd + '-' + mm + '-' + yy;  //$("[id*=txt_to]").val();
            var sts = 'All'; //$("[id*=drpSts]").val();

            var Q = $("[id*=ddltype]").val();
            var F = $("[id*=ddlForm]").val();
            if ((UserID == null || UserID == "") || (Password == null || Password == "")) {
                alert('Enter User Login Details');
                return false;
            }


            if (TAN_NO == null || TAN_NO == undefined) {
                alert('TAN - Cannot be Blank');
                return false;
            }



            if (editedChlnAmt == null || editedChlnAmt == undefined || editedChlnAmt == '') {
                alert('Please enter challan ammount.');
                return false;
            }

            var tempDate = new Date(rowData.dateOfDep);
            var tdd = tempDate.getDate();
            var tmm = tempDate.toLocaleString('en-US', { month: 'short' });
            var tyy = tempDate.getFullYear();

            var dateOfDep = tdd + '-' + tmm + '-' + tyy;
            var bsrCode = rowData.bankCode + rowData.branchCode

            var tracesData = {
                "objTraceData": {
                    PRN_NO: rowData.recptNum,
                    ChallanSerialNo: rowData.chlnSNo,
                    ChallanAmount: editedChlnAmt,
                    TaxDepositedDate: dateOfDep,
                    BSRCode: bsrCode,
                    ChallanStatus: sts,
                    FromDT: frm,
                    ToDate: to,
                    Compid: compid,
                    Quarter: Q,
                    Forms: F,
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
            $("[id*=lblSuccess]").hide();

            $(".MastermodalBackground2").show();
            document.getElementById("btnGetRequest").disabled = true;

            //debugger;
            $.ajax({
                type: "POST",
                url: "TService.asmx/Challan_Consumpution",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify(tracesData),
                success: function (data) {
                    document.getElementById("btnGetRequest").disabled = false;
                    HideModalPopup();
                    hideloader();
                    var result = JSON.parse(data.d);
                    if (result.error) {
                        $("#captcha").val("");
                        //getCaptcha();

                        alert(result.error);
                        $("[id*=lblSuccess]").hide();
                        $("[id*=lblProcess]").hide();

                        return false;
                    }
                    else {
                        if (result.success) {
                            $("[id*=lblSuccess]").show();
                            $("#captcha").val("");

                            var btn = document.getElementById("ctl00_MasterPage_btnGenerateTextFile");
                            document.getElementById("ctl00_MasterPage_btnGenerateTextFile").style.display = "block";
                            btn.click();

                        }
                        if (result.timeout) {
                            $("#captcha").val("");
                            $("[id*=lblProcess]").hide();
                            $("[id*=lblSuccess]").hide();
                            return false;
                        }
                        if (result.Failed) {
                            alert(response.d);
                            $("[id*=lblProcess]").hide();
                            $("[id*=lblSuccess]").hide();
                        }
                    }
                },
                failure: function (response) {
                    $("#captcha").val("");
                    //getCaptcha();
                    document.getElementById("btnGetRequest").disabled = false;
                    $(".MastermodalBackground2").hide();
                    alert(response.d);
                    $("[id*=lblProcess]").hide();
                    $("[id*=lblSuccess]").hide();
                }
            });

            return false;

        }

    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" Runat="Server">
    <asp:HiddenField ID="hdntanno" runat="server" />
    <asp:HiddenField ID="hdnfinancialyear" runat="server" />
    <asp:HiddenField ID="hdnCompanyid" runat="server" />
    <asp:HiddenField ID="hdnQuarter" runat="server" />
    <asp:HiddenField ID="hdnForm" runat="server" />
    <asp:HiddenField ID="hdnReqst" runat="server" />
    <asp:HiddenField ID="hdnPRN" runat="server" />

    <table width="100%">
        <tr class="cssPageTitle">
            <td valign="top" width="100%">
                <table width="40%">
                    <tr>
                        <td>
                            <label id="Label6" runat="server" font-bold="true">Form</label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlForm" runat="server" style="width: 120px" AutoPostBack="True" CssClass="cssDropDownList">
                                <asp:ListItem>24Q</asp:ListItem>
                                <asp:ListItem>26Q</asp:ListItem>
                                <asp:ListItem>27Q(NRI)</asp:ListItem>
                                <asp:ListItem>27EQ(TCS)</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>
                            <label id="Label7" runat="server" font-bold="true">Qtr</label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddltype" runat="server" style="width: 120px" AutoPostBack="True" CssClass="cssDropDownList">
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem>Q1</asp:ListItem>
                                <asp:ListItem>Q2</asp:ListItem>
                                <asp:ListItem>Q3</asp:ListItem>
                                <asp:ListItem>Q4</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td> 
                            <input type="button" id="btnConsumption" value="Import Challan" />
                        </td>
                        <td>
                            <input type="button" id="btnVerify" value="Verify" />
                        </td>
                    </tr>

                </table>
            </td>
        </tr>
    </table>
    <table width="100%">
        <tr>
            <td>
                <table id="tblChln" width="100%">
                    <thead>
                        <tr style="color:White;background-color:#5B8FBB;">
                            <th style="text-align: center;">Sr No</th>
                            <th style="text-align: center;">BSR Code</th>
                            <th style="text-align: center;">Date of Deposit</th>
                            <th style="text-align: center;">Challan Serial Number</th>
                            <th style="text-align: center;">Challan Status</th>
                            <th style="text-align: center;">Receipt Number</th>
                            <th style="text-align: center;">Sel</th>
                            <th style="text-align: center;">Challan Amount</th>

                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </td>
        </tr>
    </table>

    <asp:Button Style="display: none" ID="hideModalPopupViaClientOrginal" runat="server"></asp:Button><br />
    <cc1:ModalPopupExtender BackgroundCssClass="modalBackground" BehaviorID="programmaticModalPopupOrginalBehavior"
        RepositionMode="RepositionOnWindowScroll" DropShadow="False" ID="ModalPopupExtender2"
        TargetControlID="hideModalPopupViaClientOrginal" CancelControlID="imgBudgetdClose"
        PopupControlID="panel10" runat="server">
    </cc1:ModalPopupExtender>

    <asp:Panel ID="panel10" runat="server"   BackColor="#FFFFFF">
        <div id="Div1" style="width: 100%; float: left; background-color: #55A0FF; color: #ffffff; font-weight: bold;">
            <div id="Div2" style="width: 90%; float: left; height: 20px; padding-left: 2%; padding-top: 1%">
                <asp:Label ID="lblpopup" runat="server" Font-Size="Larger" CssClass="subHead1 labelChange" Text=""></asp:Label>
            </div>
            <div id="Div3" class="ModalCloseButton">
                <img alt="" src="../images/error.png" id="imgBudgetdClose" border="0" name="imgClose"
                    onclick="return HideModalPopup()" />
            </div>
        </div>
        <div style="padding: 5px 5px 5px 5px; " id="addtasks" runat="server" class="comprw">
            <div id="divJb" class="divedBlock" style="padding-top: 10px;">

                <div style="overflow: hidden;  float: left; padding-left: 5px;">
                    <img alt="" src="../images/tds-logo.png" id="imgTraces" border="0" name="imgTraces"  />
                    <asp:Panel ID="pnljb" runat="server" >
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
                                    <label id="lblProcess" style="padding-right:20px;font-size:18px;  font-weight:bold; color:red;  border :none ;">Verifing Challans, Please wait .......</label>
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
                                    <label id="lblSuccess" style="padding-right:20px;font-size:18px; font-weight:bold; border:none ; color:green; ">Verifiying</label>
                                </td>
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

