<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="ManageNonSalary_ChallanList.aspx.cs" Inherits="Admin_ManageSalary_ChallanList" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../Scripts/Jquery3.5.1.js" type="text/javascript"></script>

    <link href="../css/common.css" rel="stylesheet" />
    <script type="text/javascript">

        $(document).ready(function () {


            $("[id*=imgRsh]").click(function () {
                loadLoginDetails();
                getCaptcha();
            });

            document.getElementById("ctl00_MasterPage_btnGenerateTextFile").style.display = "none";
            //btn.hide();
        });

        $(document).on('click', '[id*=btnVerification]', function (e) {
            ShowModalPopup();
            loadLoginDetails();
            getCaptcha();
            $("[id*=hdnReqst]").val('Verify');

        });

        $(document).on('click', '[id*=btnConsumption]', function (e) {

            getPRNDetails();
        });

        function getPRNDetails() {
            var Q = $("[id*=ddltype]").val();
            var F = $("[id*=ddlForm]").val();
            var compid = $("[id*=hdnCompanyid]").val();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../handler/Challan.asmx/GetPRN",
                data: '{compid:' + compid + ',Q:"' + Q + '", F:"' + F + '"}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    if (myList == undefined) {

                    }
                    else if (myList.length > 0) {
                        $("[id*=hdnPRN]").val(myList[0].RToken);

                        ShowModalPopup();
                        loadLoginDetails();
                        getCaptcha();
                        $("[id*=hdnReqst]").val('Con');
                    }
                },
                failure: function (response) {

                },
                error: function (response) {

                }
            });
        }


        function ShowLoader() {

            $('.MastermodalBackground2').css("display", "block");
        }

        function hideloader() {

            $('.MastermodalBackground2').css("display", "none");
        }

        function Download() {

            if ($("[id*=HID_IMG_TXT1]").val() == '') {
                return false
            }
            if ($("[id*=HID_IMG_TXT1]").val() == undefined) {
                return false
            }
            var Currentdt = new Date();
            var Cap = $("[id*=HID_IMG_TXT1]").val()
            var dd = Currentdt.getDate();
            var mm = Currentdt.getMonth() + 1;
            var yy = Currentdt.getFullYear();

            var TAN = $("[id*=txtTanNo]").val();
            var FY = $("[id*=ddlFinancialYear] :selected").text()
            var fyy = FY.split('_')[0];

            if (dd < 10) {
                dd = '0' + dd;
            }
            if (mm < 10) {
                mm = '0' + mm;
            }
            // fyy = fyy.toString().slice(-2);
            var d = '01';
            var m = '04';
            d = d.toString();
            m = m.toString();
            fyy = fyy.toString();
            dd = dd.toString();
            mm = mm.toString();
            yy = yy.toString();
            var tanSearchData = {
                "challan": {
                    TAN_NO: TAN,

                    TAN_FROM_DT_DD: d,
                    TAN_FROM_DT_MM: m,
                    TAN_FROM_DT_YY: fyy,



                    TAN_TO_DT_DD: dd,
                    TAN_TO_DT_MM: mm,
                    TAN_TO_DT_YY: yy,

                    appUser: "T",
                    HID_IMG_TXT: Cap,
                    Cookie: Cookies,

                    //Added by Sharmila - 16-12-2022
                    fromType: $("[id*=ddlForm]").val(),
                    quaterValue: $("[id*=ddltype]").val(),
                    finacialYear: $("[id*=ddlFinancialYear] :selected").text()
                }
            };

            $.ajax({
                type: "POST",
                url: "TService.asmx/VerifyChallan",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify(tanSearchData),
                success: function (data) {
                    debugger;
                    var result = JSON.parse(data.d);

                    if (result["error"] != undefined || result["error"] != null) {
                        // $(".MastermodalBackground2").hide();
                        // alert(result["error"]);
                        return false;
                    }
                    var fName = result["filename"];
                    var data = result["data"];

                    //Commented by Sharmila
                    //var binary_string = window.atob(data);
                    //var len = binary_string.length;
                    //var bytes = new Uint8Array(len);
                    //for (var i = 0; i < len; i++) {
                    //    bytes[i] = binary_string.charCodeAt(i);
                    //}

                    if (fName != "") {
                        var blob = new Blob([bytes], { 'type': "application/x-csi" });
                        var link = document.createElement('a');
                        link.href = window.URL.createObjectURL(blob);
                        link.download = fName.substring(fName.indexOf("=") + 1);
                        document.body.appendChild(link);
                        link.click();
                        document.body.removeChild(link);

                    } else {
                        $("#captcha").val("");
                        getCaptcha();
                    }
                },
                failure: function (response) {

                }
            });

            return false;
        }

        /////////////26Q
        function GetQuater() {
            var re = "";
            var d = new Date();
            var i = d.getMonth();

            if (i == 4 || i == 5 || i == 6) { re = "Q1"; }
            if (i == 7 || i == 8 || i == 9) { re = "Q2"; }
            if (i == 10 || i == 11 || i == 12) { re = "Q3"; }
            if (i == 1 || i == 2 || i == 3) { re = "Q4"; }
            return re;
        }
        $(document).on('change', '[id*=ddl_Searchby26Q]', function (e) {
            chch();
        });
        $(document).on('change', '[id*=btnSearch26Q]', function (e) {
            chch();
        });


        function chch() {

            var parm = document.getElementById('<%=ddl_Searchby26Q.ClientID%>');
            var sel = parm.options[parm.selectedIndex].value;

            if (sel == "1") {
                $('#ChallanNo26Q').show();
                $('#ChallanDate26Q').hide();
                $("[id*=txt_SearchDate26Q]").val('');
            }
            else if (sel == "2") {
                $('#ChallanDate26Q').show(); $('#ChallanNo26Q').hide();
                $("[id*=txt_SearchChallano26Q]").val('');
            }
            else {
                $("[id*=txt_SearchChallano26Q]").val('');
                $("[id*=txt_SearchDate26Q]").val('');
                $('#ChallanNo26Q').hide();
                $('#ChallanDate26Q').hide();
            }
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

        RequestTrace = function () {
            var rq = $("[id*=hdnReqst]").val();
            if (rq == 'Con') {
                GetConsumption();
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
                    url: "TService.asmx/Challan_Traces",
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

        function GetConsumption() {

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
            var rTkn = $("[id*=hdnPRN]").val();
            if (rTkn == '') {
                alert('Provisional Reciept Number Required');
                return false;
            }
            var tracesData = {
                "objTraceData": {
                    PRN_NO: rTkn,
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
    <style type="text/css">
        .cssButtonForSearch {
            cursor: pointer; /*background-image: url(../Images/ButtonBG1.png);*/
            background-color: White;
            border: 0px;
            padding: 4px 15px 4px 15px;
            color: Black;
            border: 1px solid #c4c5c6;
            border-radius: 3px;
            font: bold 12px verdana, arial, "Trebuchet MS", sans-serif;
            text-decoration: none;
        }

            .cssButtonForSearch:focus {
                background-color: #69b506;
                border: 1px solid #3f6b03;
                color: White;
                opacity: 0.8;
            }

            .cssButtonForSearch:hover {
                background-color: #69b506;
                border: 1px solid #3f6b03;
                color: White;
                opacity: 0.8;
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
            width: 50px;
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

        .rightSave {
            position: absolute;
            right: 200px;
            height: 27px;
            padding-left: 15px;
            padding-left: 15px;
            padding-top: 2px;
            top: 122px;
        }

        .rightCancel {
            position: absolute;
            right: 100px;
            height: 27px;
            padding-left: 15px;
            padding-left: 15px;
            top: 122px;
        }

        .rightdrp {
            position: absolute;
            right: 300px;
            height: 27px;
            padding-left: 15px;
            padding-left: 15px;
            top: 148px;
            width: 300px;
        }

        .verifydrp {
            position: absolute;
            right: 200px;
            height: 27px;
            padding-left: 15px;
            padding-left: 15px;
            top: 148px;
            width: 300px;
        }

        .drpright {
            position: absolute;
            right: 500px;
            height: 27px;
            padding-left: 15px;
            padding-left: 15px;
            top: 148px;
            width: 300px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:HiddenField ID="hdntanno" runat="server" />
    <asp:HiddenField ID="hdnfinancialyear" runat="server" />
    <asp:HiddenField ID="hdnCompanyid" runat="server" />
    <asp:HiddenField ID="hdnQuarter" runat="server" />
    <asp:HiddenField ID="hdnForm" runat="server" />
    <asp:HiddenField ID="hdnReqst" runat="server" />
    <asp:HiddenField ID="hdnPRN" runat="server" />

    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
        <ContentTemplate>
            <table width="100%">
                <tr>
                    <td class="cssPageTitle">
                        <asp:Label ID="Label1" runat="server" Text="Challan Entries"></asp:Label>
                        <%--<input ID="btnValid" type="button"  runat="server" value="Verify with OLTAS" class="cssButton" />--%>
                        <label id="Label6" runat="server" font-bold="true" style="position: absolute; right: 820px;">Form</label>
                        <div class="drpright " style="position: absolute; top: 146px;">
                            <asp:DropDownList ID="ddlForm" runat="server" AutoPostBack="True" Style="width: 100px; height: 25px;" CssClass="cssDropDownList" OnSelectedIndexChanged="ddlForm_SelectedIndexChanged">

                                <asp:ListItem>26Q</asp:ListItem>
                                <asp:ListItem>27Q(NRI)</asp:ListItem>
                                <asp:ListItem>27EQ(TCS)</asp:ListItem>

                            </asp:DropDownList>
                        </div>
                        <label id="Label7" runat="server" font-bold="true" style="position: absolute; right: 610px;">Qtr</label>
                        <div class="rightdrp " style="position: absolute; top: 146px;">
                            <asp:DropDownList ID="ddltype" runat="server" AutoPostBack="True" Style="width: 50px; height: 25px;" CssClass="cssDropDownList" OnSelectedIndexChanged="ddltype_SelectedIndexChanged">

                                <asp:ListItem>Q1</asp:ListItem>
                                <asp:ListItem>Q2</asp:ListItem>
                                <asp:ListItem>Q3</asp:ListItem>
                                <asp:ListItem>Q4</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="verifydrp" style="position: absolute; top: 146px;">
                            <asp:Button ID="btnVerification" runat="server" Text="Verify Now" CssClass="cssButtonForSearch" />
                            <asp:Button runat="server" ID="btnGenerateTextFile" OnClick="btnGenerateTextFile_Click" Width="1px" />
                            <input type="button" id="btnConsumption" value="Consumption details" />
                        </div>

                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <UC:MessageControl runat="server" ID="ucMessageControl" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="100%" cellpadding="5" cellspacing="0">
                            <tr>
                                <td>
                                    <table class="cssGridHeader" style="background-color: #5B8FBB; color: White;" cellpadding="0"
                                        cellspacing="0" width="100%">
                                        <tr>

                                            <td>Search By
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddl_Searchby26Q" runat="server" Width="150px" CssClass="cssDropDownList">
                                                    <asp:ListItem Selected="True">( Select Search By ) </asp:ListItem>
                                                    <asp:ListItem Value="1">Challan No</asp:ListItem>
                                                    <asp:ListItem Value="2">Challan Date</asp:ListItem>
                                                </asp:DropDownList>
                                                &nbsp;&nbsp;&nbsp;&nbsp;
                                            </td>
                                            <td>
                                                <div id="ChallanNo26Q" style="display: none;">
                                                    Challan No&nbsp;&nbsp;
                                                    <asp:TextBox ID="txt_SearchChallano26Q" runat="server" Width="100px" CssClass="cssTextbox"></asp:TextBox>
                                                </div>
                                                <div id="ChallanDate26Q" style="display: none;">
                                                    Challan Date &nbsp;&nbsp;<asp:TextBox ID="txt_SearchDate26Q" Width="100px" CssClass="cssTextbox"
                                                        runat="server"></asp:TextBox>
                                                    <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txt_SearchDate26Q"
                                                        Mask="99/99/9999" MaskType="Date" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder=""
                                                        CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                        CultureTimePlaceholder="" Enabled="True" />
                                                    <asp:ImageButton ID="ImageButton1" ImageUrl="~/Images/calendar.gif" runat="server" />
                                                    <cc1:CalendarExtender
                                                        runat="server" ID="cal1" PopupButtonID="ImageButton1" TargetControlID="txt_SearchDate26Q"
                                                        Format="dd/MM/yyyy" Enabled="True">
                                                    </cc1:CalendarExtender>
                                                </div>
                                            </td>
                                            <td>&nbsp;&nbsp;&nbsp;&nbsp;
                                                <asp:Button ID="btnSearch26Q" runat="server" OnClick="btnSearch26Q_Click" Text="Search"
                                                    CssClass="cssButtonForSearch" />&nbsp;&nbsp; &nbsp;
                                                <asp:Button ID="btnAddnew26Q" runat="server" Text="Add New Challan" CssClass="cssButtonForSearch" OnClick="btnAddnew26Q_Click" />

                                            </td>

                                            <td>&nbsp;&nbsp;Pg Size&nbsp;
                                                <asp:DropDownList ID="ddl26Qperpage" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddl26Qperpage_SelectedIndexChanged">
                                                    <asp:ListItem Value="25" Selected="True"></asp:ListItem>
                                                    <asp:ListItem Value="50"></asp:ListItem>
                                                    <asp:ListItem Value="75"></asp:ListItem>
                                                    <asp:ListItem Value="100"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:GridView ID="gv26Q" EmptyDataText="No Records Found" runat="server" AutoGenerateColumns="False"
                                        Width="100%" CellSpacing="2" CellPadding="2" ShowFooter="True" ShowHeaderWhenEmpty="True"
                                        AllowPaging="True" OnDataBound="gv26Q_DataBound" OnRowCommand="gv26Q_RowCommand"
                                        OnPageIndexChanging="gv26Q_PageIndexChanging" OnRowDataBound="gv26Q_RowDataBound">
                                        <PagerSettings Position="Top" />
                                        <PagerStyle CssClass="GridPager1" BackColor="#5B8FBB" VerticalAlign="Middle" BorderColor="#DBDBDB"
                                            HorizontalAlign="Right" />
                                        <HeaderStyle CssClass="cssGridHeader" BackColor="#5B8FBB" ForeColor="White" />
                                        <FooterStyle CssClass="cssGridHeader" BackColor="#5B8FBB" ForeColor="White" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sr No">
                                                <HeaderStyle BorderColor="#DBDBDB" />
                                                <ItemStyle BorderColor="#DBDBDB" HorizontalAlign="Right" Width="5%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSerial" runat="server" Visible="true" CssClass="cssLabel" Text='<%#Container.DataItemIndex+1 %>'></asp:Label>
                                                    <footerstyle bordercolor="#DBDBDB" font-bold="True" horizontalalign="Right" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Quater">
                                                <HeaderStyle BorderColor="#DBDBDB" />
                                                <ItemStyle BorderColor="#DBDBDB" HorizontalAlign="Center" Width="5%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblQuater" runat="server" Text='<%#Eval("Quater") %>' CssClass="cssLabel"
                                                        Visible="true"></asp:Label>
                                                </ItemTemplate>
                                                <FooterStyle BorderColor="#DBDBDB" Font-Bold="True" HorizontalAlign="Right" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Challan No.">
                                                <HeaderStyle BorderColor="#DBDBDB" />
                                                <ItemStyle BorderColor="#DBDBDB" HorizontalAlign="Right" Width="8%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblChallanNO" runat="server" Text='<%#Eval("Challan_No") %>' CssClass="cssLabel"
                                                        Visible="true"></asp:Label>
                                                </ItemTemplate>
                                                <FooterStyle BorderColor="#DBDBDB" Font-Bold="True" HorizontalAlign="Right" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Total Deductee">
                                                <HeaderStyle BorderColor="#DBDBDB" />
                                                <ItemStyle BorderColor="#DBDBDB" HorizontalAlign="Right" Width="8%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEmployee" runat="server" Text='<%#Eval("TotalEmployee") %>' CssClass="cssLabel"
                                                        Visible="true"></asp:Label>
                                                </ItemTemplate>
                                                <FooterStyle BorderColor="#DBDBDB" Font-Bold="True" HorizontalAlign="Right" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Bank Name">
                                                <HeaderStyle BorderColor="#DBDBDB" />
                                                <ItemStyle BorderColor="#DBDBDB" HorizontalAlign="Left" Width="40%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBankame" runat="server" Text='<%#Eval("Bank_Name") %>' CssClass="cssLabel"
                                                        Visible="true"></asp:Label>
                                                </ItemTemplate>
                                                <FooterStyle BorderColor="#DBDBDB" Font-Bold="True" HorizontalAlign="Right" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="BSR Code">
                                                <HeaderStyle BorderColor="#DBDBDB" />
                                                <ItemStyle BorderColor="#DBDBDB" HorizontalAlign="Left" Width="20px" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBSRCode" runat="server" Text='<%#Eval("Bank_Bsrcode") %>' CssClass="cssLabel"
                                                        Visible="true"></asp:Label>
                                                </ItemTemplate>
                                                <FooterStyle BorderColor="#DBDBDB" Font-Bold="True" HorizontalAlign="Right" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Payment Date">
                                                <HeaderStyle BorderColor="#DBDBDB" />
                                                <ItemStyle BorderColor="#DBDBDB" HorizontalAlign="Center" Width="10%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPaymentDate" runat="server" Text='<%# Eval("Challan_Date", "{0:dd/MM/yyyy}") %>'
                                                        CssClass="cssLabel" Visible="true"></asp:Label>
                                                </ItemTemplate>
                                                <FooterStyle BorderColor="#DBDBDB" Font-Bold="True" HorizontalAlign="Right" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Section">
                                                <HeaderStyle BorderColor="#DBDBDB" />
                                                <ItemStyle BorderColor="#DBDBDB" HorizontalAlign="Right" Width="10%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSec" runat="server" Text='<%#Eval("Section") %>' CssClass="cssLabel"
                                                        Visible="true"></asp:Label>
                                                </ItemTemplate>
                                                <FooterStyle BorderColor="#DBDBDB" Font-Bold="True" HorizontalAlign="Right" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="TDS">
                                                <HeaderStyle BorderColor="#DBDBDB" />
                                                <ItemStyle BorderColor="#DBDBDB" HorizontalAlign="Right" Width="15%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTds" runat="server" Text='<%#Eval("TDS_Amount","{0:N2}") %>' CssClass="cssLabel"
                                                        Visible="true"></asp:Label>
                                                </ItemTemplate>
                                                <FooterStyle BorderColor="#DBDBDB" Font-Bold="True" HorizontalAlign="Right" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Other">
                                                <HeaderStyle BorderColor="#DBDBDB" />
                                                <ItemStyle BorderColor="#DBDBDB" HorizontalAlign="Right" Width="10%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblOther" runat="server" Text='<%#Eval("Others_Amount","{0:N2}") %>' CssClass="cssLabel"
                                                        Visible="true"></asp:Label>
                                                </ItemTemplate>
                                                <FooterStyle BorderColor="#DBDBDB" Font-Bold="True" HorizontalAlign="Right" />
                                            </asp:TemplateField>
                                            <%-- <asp:TemplateField HeaderText="Surcharge">
                                                <HeaderStyle BorderColor="#DBDBDB" />
                                                <ItemStyle BorderColor="#DBDBDB" HorizontalAlign="Right" Width="10%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSurcharge" runat="server" Text='<%#Eval("Surcharge") %>' CssClass="cssLabel"
                                                        Visible="true"></asp:Label></ItemTemplate>
                                                <FooterStyle BorderColor="#DBDBDB" Font-Bold="True" HorizontalAlign="Right" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="ECess">
                                                <HeaderStyle BorderColor="#DBDBDB" />
                                                <ItemStyle BorderColor="#DBDBDB" HorizontalAlign="Right" Width="10%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEducation" runat="server" Text='<%#Eval("Education_Cess") %>' CssClass="cssLabel"
                                                        Visible="true"></asp:Label></ItemTemplate>
                                                <FooterStyle BorderColor="#DBDBDB" Font-Bold="True" HorizontalAlign="Right" />
                                            </asp:TemplateField>--%>
                                            <%--  <asp:TemplateField HeaderText="Interest">
                                                <HeaderStyle BorderColor="#DBDBDB" />
                                                <ItemStyle BorderColor="#DBDBDB" HorizontalAlign="Right" Width="10%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblinterest" runat="server" Text='<%#Eval("Interest_Amt") %>' CssClass="cssLabel"
                                                        Visible="true"></asp:Label></ItemTemplate>
                                                <FooterStyle BorderColor="#DBDBDB" Font-Bold="True" HorizontalAlign="Right" />
                                            </asp:TemplateField>--%>
                                            <asp:TemplateField HeaderText="Amount">
                                                <HeaderStyle BorderColor="#DBDBDB" />
                                                <ItemStyle BorderColor="#DBDBDB" HorizontalAlign="Right" Width="15%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAmount" runat="server" Text='<%#Eval("Challan_Amount","{0:N2}") %>' CssClass="cssLabel"
                                                        Visible="true"></asp:Label>
                                                </ItemTemplate>
                                                <FooterStyle BorderColor="#DBDBDB" Font-Bold="True" HorizontalAlign="Right" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Verified">
                                                <HeaderStyle BorderColor="#DBDBDB" />
                                                <ItemStyle BorderColor="#DBDBDB" HorizontalAlign="Right" Width="15%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblverify" runat="server" Text='<%#Eval("Trans_No") %>' CssClass="cssLabel"
                                                        Visible="true" Font-Bold="True"></asp:Label>
                                                </ItemTemplate>
                                                <FooterStyle BorderColor="#DBDBDB" Font-Bold="True" HorizontalAlign="Right" />
                                            </asp:TemplateField>

                                            <asp:TemplateField>
                                                <HeaderStyle BorderColor="#DBDBDB" />
                                                <ItemStyle BorderColor="#DBDBDB" HorizontalAlign="Center" Width="5px" />
                                                <ItemTemplate>
                                                    <asp:ImageButton runat="server" ImageUrl="~/Images/edit_icon.png" ID="btnEdit" CssClass="cssEditDeleteImage"
                                                        CommandName="EditCommand" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Challan_ID") %>'
                                                        ToolTip="Edit" />
                                                </ItemTemplate>
                                                <FooterStyle BorderColor="#DBDBDB" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderStyle BorderColor="#DBDBDB" />
                                                <ItemStyle BorderColor="#DBDBDB" HorizontalAlign="Center" Width="5px" />
                                                <ItemTemplate>
                                                    <asp:ImageButton runat="server" ID="btnDelete" ImageUrl="~/Images/Delete_icon.png"
                                                        CssClass="cssEditDeleteImage" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Challan_ID") %>'
                                                        ToolTip="Delete" CommandName="DeleteCommand" OnClientClick="return DeleteConfirmation('Challan')" />
                                                </ItemTemplate>
                                                <FooterStyle BorderColor="#DBDBDB" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <RowStyle CssClass="cssGridAlternatingItemStyle" />
                                    </asp:GridView>
                                </td>

                            </tr>
                        </table>


                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>



    <asp:Button Style="display: none" ID="hideModalPopupViaClientOrginal" runat="server"></asp:Button><br />
    <cc1:ModalPopupExtender BackgroundCssClass="modalBackground" BehaviorID="programmaticModalPopupOrginalBehavior"
        RepositionMode="RepositionOnWindowScroll" DropShadow="False" ID="ModalPopupExtender2"
        TargetControlID="hideModalPopupViaClientOrginal" CancelControlID="imgBudgetdClose"
        PopupControlID="panel10" runat="server">
    </cc1:ModalPopupExtender>

    <asp:Panel ID="panel10" runat="server" BackColor="#FFFFFF">
        <div id="Div1" style="width: 100%; float: left; background-color: #55A0FF; color: #ffffff; font-weight: bold;">
            <div id="Div2" style="width: 90%; float: left; height: 20px; padding-left: 2%; padding-top: 1%">
                <asp:Label ID="lblpopup" runat="server" Font-Size="Larger" CssClass="subHead1 labelChange" Text=""></asp:Label>
            </div>
            <div id="Div3" class="ModalCloseButton">
                <img alt="" src="../images/error.png" id="imgBudgetdClose" border="0" name="imgClose"
                    onclick="return HideModalPopup()" />
            </div>
        </div>
        <div style="padding: 5px 5px 5px 5px;" id="addtasks" runat="server" class="comprw">
            <div id="divJb" class="divedBlock" style="padding-top: 10px;">

                <div style="overflow: hidden; float: left; padding-left: 5px;">
                    <img alt="" src="../images/tds-logo.png" id="imgTraces" border="0" name="imgTraces" />
                    <asp:Panel ID="pnljb" runat="server">
                        <table width="100%">
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
                                                <input id="txtTan" class="cssTextbox" type="text" style="width: 120px;" value="" autocomplete="none" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="border: 2px;">User ID : <span class="req">*</span>
                                            </td>
                                            <td>
                                                <input id="txtUserID" class="cssTextbox" style="width: 120px;" type="text" value="" autocomplete="nope" />
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
                        <table id="tblver" name="tblver">

                            <tr id="trAuto1" name="trAuto1">
                                <td style="text-align: right;">
                                    <img id="captchaImg" class="captchaimg1" alt="Captcha" src="" /></td>
                                <td>
                                    <img id="imgRsh" src="../Images/refresh.png" style="width: 20px; padding-right: 10px; cursor: pointer;" />
                                    <label style="font-weight: bold;">Click to refresh image</label>

                                </td>
                            </tr>
                            <tr style="height: 15px;">
                                <td>
                                    <label id="lblProcess" style="padding-right: 20px; font-size: 18px; font-weight: bold; color: red; border: none;">Verifing Challans, Please wait .......</label>
                                </td>
                            </tr>
                            <tr id="trAuto2" name="trAuto2">
                                <td style="text-align: left;">
                                    <input autocomplete="off" id="captcha" class="frmtxtbox" maxlength="5" style="width: 100px;" value="" />
                                </td>
                                <td style="font-weight: bold; font-size: 14px; text-align: right;">Enter text as in above image</td>

                            </tr>
                            <tr style="height: 15px;">
                                <td>
                                    <label id="lblSuccess" style="padding-right: 20px; font-size: 18px; font-weight: bold; border: none; color: green;">Verifiying</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="submit" name="btnGetRequest" value="Request" id="btnGetRequest" class="cssButton" onclick="return RequestTrace();" />
                                </td>
                                <td>
                                    <asp:Button ID="Button1" Text="Cancel" runat="server" CssClass="cssButton" OnClientClick="return HideModalPopup()" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">

                                    <div style="width: 100%; margin: auto; padding-left: 15px;" id="divData">
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
