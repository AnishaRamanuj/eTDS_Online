<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="Dashboards.aspx.cs" Inherits="Dashboard_TDS_Salary" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit"   TagPrefix="cc1" %>
<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<%--    <script src="../Scripts/jquery-1.8.2.min.js" type="text/javascript"></script>--%>
    <script src="../Scripts/Jquery3.5.1.js" type="text/javascript"></script>
    <script src="../Scripts/bootstrap3.4.1.js"  type="text/javascript"></script>
    
    <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>

    <script type="text/javascript" src="../customScript/jquery-confirm.min.js"></script>
    <script type="text/javascript" src="../customScript/common.js"></script>
    <script type="text/javascript" src="../Scripts/echarts.min.js"></script>
    <script type="text/javascript" src="../Scripts/d3.min.js"></script>
    <script type="text/javascript" src="../Scripts/d3_tooltip.js"></script>
    <%--Jquery Confirm--%>
    <link href="../css/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="../css/jquery-confirm.min.css" rel="stylesheet" />
    <link href="../css/common.css" rel="stylesheet" />


<style type="text/css">
.cssButton {
    cursor: pointer; background-image: url(../Images/ButtonBG1.png);
    background-color: #d3d3d3;
    border: 0px;
    padding: 4px 15px 4px 15px;
    color: Black;
    border: 1px solid #c4c5c6;
    border-radius: 3px;
    font: bold 12px verdana, arial, "Trebuchet MS", sans-serif;
    text-decoration: none;
    opacity: 0.8;
}

.cssButton:focus {
    background-color: #69b506;
    border: 1px solid #3f6b03;
    color: White;
    opacity: 0.8;
}

.cssButton:hover {
    background-color: #69b506;
    border: 1px solid #3f6b03;
    color: White;
    opacity: 0.8;
}
.Pager b {
    margin-top: 2px;
    float: left;
}

.Pager span {
    text-align: center;
    display: inline-block;
    width: 20px;
    margin-right: 3px;
    line-height: 150%;
    border: 1px solid #BCBCBC;
}

.Pager a {
    text-align: center;
    display: inline-block;
    width: 20px;
    background-color: #BCBCBC;
    color: #fff;
    border: 1px solid #BCBCBC;
    margin-right: 3px;
    line-height: 150%;
    text-decoration: none;
}
.tdsm {
    font-size: small;
}

input[type=text], select {
    min-height: 25px;
}

th {
    color: #474747;
}

td {
    vertical-align: top;
}
************************************************************client job selection css***************
.tblClientJobSelection td, .tblClientJobSelection th {
    padding: 5px;
    text-align: left;
}

.tblClientJobSelection .DropDown {
    width: 412px;
}

.ajax__calendar_days td, .ajax__calendar_months td {
    padding: 0px;
}

*************************************************************Timesheet Input css*******************
.tblBorderClass {
    border-collapse: collapse;
}

.tblBorderClass th {
    background: #F2F2F2;
}

.tblBorderClass td, .tblBorderClass th {
    padding: 5px;
    margin: 0px;
    border: 1px solid #bcbcbc;
}

.tblBorderClass tr td:nth-child(1), .tblBorderClass tr td:nth-child(2), .tblBorderClass tr td:nth-child(3) {
    text-align: center;
}

.tblBorderClass input[type=text] {
    max-width: 42px;
    min-height: 20px;
}

.tblBorderClass tr:hover td {
    background: #c7d4dd !important;
}

.TbleBtns {
float: right;
display: inherit;
}

.tbl {
border-collapse: collapse;
background-color: #fff;
}

.tbl img {
margin: -3px;
cursor: pointer;
}

.tbl tbody tr td {
background-color: inherit;
font: normal 12px verdana, arial, "Trebuchet MS", sans-serif;
padding: 5px;
border: 1px solid #BCBCBC;
}

.tbl thead tr th {
background: rgba(219,219,219,0.54);
padding: 5px;
border: 1px solid #BCBCBC;
font: 12px verdana, arial, "Trebuchet MS", sans-serif;
font-weight: bold;
}

.tbl tfoot tr th {
background: rgba(219,219,219,0.54);
padding: 5px;
border: 1px solid #BCBCBC;
font: 12px verdana, arial, "Trebuchet MS", sans-serif;
font-weight: bold;
}

.tbl tbody tr th {
background: rgba(219,219,219,0.54);
padding: 5px;
border: 1px solid #BCBCBC;
}



.PopHeaderTitle {
    width: 97.8%;
}

.holidays {
    background: #99CCFF;
}

.nonholidays {
    background: White;
}

img#close {
    position: absolute;
    right: -14px;
    top: -14px;
    cursor: pointer;
}

div#popupContact {
    position: absolute;
    left: 50%;
    top: 17%;
    margin-left: -202px;
    font-family: 'Raleway',sans-serif;
    display: none;
    width: 480px;
    height: 400px;
    opacity: .95;
    background-color: White;
    overflow: auto;
}

.ajax__calendar_container {
    z-index: 4;
}

.auto-style1 {
    position: absolute;
    right: 0;
    top: 1px;
    cursor: pointer;
    height: 34px;
}
#outer
{
    width:100%;
    text-align: center;
}
.inner
{
    display: inline-block;
}
</style>
<script type="text/javascript">
    $(document).ready(function () {
        $("[id*=hdnConnString]").val($("[id*=ddlFinancialYear] :selected").text());
        //document.getElementById("lbl1").style.backgroundColor = "#add8e6";
        var compid = $("[id*=hdnCompanyid]").val();
        var F = $("[id*=ddlForm]").val();
        $("[id*=ddlQuater]").val($("[id*=hdnQuarter]").val());
        //$("[id*=lbldwn]").html(F);
        $("[id*=btnDwn]").val(F);
        $("[id*=lblvw]").html('View Form 27A');
        $("[id*=trChln]").hide();
        $("[id*=trsChln]").hide();
        $("[id*=Nontbs]").show();
        $("[id*=Saltbs]").hide();
        Get_TAN(compid)
      
        if ($("[id*=hdntblChln]").val() == '1')
        {
            $("[id*=Nontbs]").show();
            $("[id*=Saltbs]").hide();
            $("[id*=Tabmenu3]").click();
            ChallanTable();
            $("[id*=hdntblChln]").val(0);
            GetonLoad();
        }

        if ($("[id*=hdntblChln]").val() == '2') {
            $("[id*=Saltbs]").show();
            $("[id*=Nontbs]").hide();
            $("[id*=Tabmenu3]").click();
            ChallanTableSAL();
            $("[id*=hdntblChln]").val(0);
            GetonLoadSal();
        }

        $("[id*=ddlQuater]").change(function () {
            ChartSec('');
            var f = $("[id*=ddlForm]").val();
            $("[id*=trChln]").hide();
            $("[id*=trsChln]").hide();
            if (f == '24Q')
            {
                $("[id*=Saltbs]").show();
                $("[id*=Nontbs]").hide();
                GetonLoadSal();
            }
            else
            {
                $("[id*=Nontbs]").show();
                $("[id*=Saltbs]").hide();
                GetonLoad();
            }
        });

        $("[id*=ddlForm]").change(function () {
            ChartSec('');
            var f = $("[id*=ddlForm]").val();
            $("[id*=trChln]").hide();
            $("[id*=trsChln]").hide();
            if (f == '24Q')
            {
                $("[id*=Saltbs]").show();
                $("[id*=Nontbs]").hide();
                GetonLoadSal();
            }
            else
            {
                $("[id*=Nontbs]").show();
                $("[id*=Saltbs]").hide();
                GetonLoad();
            }
            //$("[id*=lbldwn]").html(f);
            $("[id*=btnDwn]").val(f);
        });

        $("[id*=txtToken]").blur(function () {
            var F = $("[id*=ddlForm]").val();
            var Q = $("[id*=ddlQuater]").val();
            var T = $("[id*=txtToken]").val();
            SaveToken(F, Q, T);
        });

        $("[id*=txtSToken]").blur(function () {
            var F = $("[id*=ddlForm]").val();
            var Q = $("[id*=ddlQuater]").val();
            var T = $("[id*=txtSToken]").val();
            SaveToken(F, Q, T);
        });

        $("[id*=btnAded]").click(function () {

            window.location.href = "Deductee_Master.aspx";
        });

        $("[id*=btnCompliance]").click(function () {
            window.location.href = "DeducteeCompliance.aspx";
        });

        $("[id*=btnProcess]").click(function () {
            window.location.href = "Onlinefilingreturn.aspx";
        });

        $("[id*=btn27Rtn]").click(function () {
            var lbl = $("[id*=lblSts]").html();
            if (lbl != 'Success') {
                alert('Error or  Returns not Prepared');
                return;
            }
            var hdnrtn = $("[id*=hdnPDF]").val();
            window.open(hdnrtn, '_blank');
            return false;
       
        });

        $("[id*=btnImp]").click(function () {
            var f = $("[id*=ddlForm]").val();
            if (f == '26Q') {
                window.location.href = "XL26Q.aspx?";
            }
            else if (f == '27Q') {
                window.location.href = "XL27Q.aspx?";
            }
            else if (f == '27EQ') {
                window.location.href = "XL27EQ.aspx?";
            }
             
        });

        $("[id*=btnVoucher]").click(function () {
            var F = $("[id*=ddlForm]").val();
            var Q = $("[id*=ddlQuater]").val();
            window.location.href = "Vouchers.aspx?D=" + F + ',' + Q;
        });
        $("[id*=btnXL]").click(function () {
            var f = $("[id*=ddlForm]").val();
            if (f == '26Q') {
                var hdnrtn = '../XL File/26Q_2122_Blank.xls';
            }
            else if (f == '27Q')
            {
                var hdnrtn = '../XL File/27Q_2122_Blank.xls';
            }
            else if (f == '27EQ') {
                var hdnrtn = '../XL File/27EQ_2122_Blank.xls';
            }

            window.open(hdnrtn, '_blank');
            return false;
               
        });

        ////// Salary
 

        $("[id*=btnsAddComp]").click(function () {
            window.location.href = "ManageTdsComputation.aspx";
        });


        $("[id*=btnSRtn]").click(function () {
            var lbl = $("[id*=lblsSts]").html();
            if (lbl == 'Success') {
                alert('Returns already Processed');

            }
            var Q = $("[id*=ddlQuater]").val();
            var F = $("[id*=ddlForm]").val();
            $("[id*=hdnForm]").val(F);
            $("[id*=hdnQuarter]").val(Q);
        });

        $("[id*=btnSDwn]").click(function () {
            var lbl = $("[id*=lblsSts]").html();
            if (lbl != 'Success') {
                alert('Error or  Returns not Prepared');
                return;
            }
            var hdnrtn = $("[id*=hdnRtn]").val();
            window.open(hdnrtn, '_blank');
            return false;
        });

        $("[id*=btnS27Rtn]").click(function () {
            var lbl = $("[id*=lblsSts]").html();
            if (lbl != 'Success') {
                alert('Error or  Returns not Prepared');
                return;
            }
            var hdnrtn = $("[id*=hdnPDF]").val();
            window.open(hdnrtn, '_blank');
            return false;
        });

        $("[id*=btnSProcess]").click(function () {
            window.location.href = "Onlinefilingreturn.aspx";
        });

        $("[id*=btnEmployee]").click(function () {
            window.location.href = "ManageEmployee_Master.aspx?";
        });
 
        $("[id*=btnsChallan]").click(function () {
            var F = $("[id*=ddlForm]").val();
            var Q = $("[id*=ddlQuater]").val();
            window.location.href = "ManageSalary_ChallanList.aspx";
        });

        $("[id*=btnsValid]").click(function () {
            $("[id*=lblSuccess]").hide();
            ShowModalPopup();
            loadLoginDetails();
            getCaptcha();
        });


        ///////////////////// End Salary

        $("[id*=btnDwn]").click(function () {
            var lbl = $("[id*=lblSts]").html();
            if (lbl != 'Success') {
                alert('Error or  Returns not Prepared');
                return;
            }
            var hdnrtn = $("[id*=hdnRtn]").val();
            window.open(hdnrtn, '_blank');
            return false;
        });

        $("[id*=btnChallan]").click(function () {
            var F = $("[id*=ddlForm]").val();
            var Q = $("[id*=ddlQuater]").val();
            window.location.href = "ManageNonSalary_ChallanList.aspx?D=" + F + ',' + Q;
        });

        $("[id*=btnRtn]").click(function () {
            var lbl = $("[id*=lblSts]").html();
            if (lbl == 'Success')
            {
                alert('Returns already Processed');
            }
            var Q = $("[id*=ddlQuater]").val();
            var F = $("[id*=ddlForm]").val();
            $("[id*=hdnForm]").val(F);
            $("[id*=hdnQuarter]").val(Q);
        });

        $("[id*=btnGenerateTextFile]").click(function () {
            if (HID_IMG_TXT1 = ! "") {
                Download();
            }
            else {
                alert("Enter the valid Captacha");
                return false;
            }
        });

        $("[id*=btnValid]").click(function () {
            $("[id*=lblSuccess]").hide();
            ShowModalPopup();
            loadLoginDetails();
            getCaptcha();
        });

        $("[id*=btnGenerateTextFile]").click(function () {
            HideModalPopup();
        });

        $("[id*=btnVerify]").click(function () {
            ShowModalPopup();
            loadLoginDetails();
            getCaptcha();
        });

        $("[id*=imgRsh]").click(function () {
            loadLoginDetails();
            getCaptcha();
        });

        $("[id*=btnBackup]").click(function () {


            var F = $("[id*=drpBkpFrm]").val();
            var Q = $("[id*=drpBkpQtr]").val();
            $("[id*=hdnForm]").val(F);
            $("[id*=hdnQuarter]").val(Q);

        });

        $("[id*=btnVouchers]").click(function () {
            window.location.href = "Vouchers.aspx";

        });
        $("[id*=btnChallans]").click(function () {
            var F = $("[id*=ddlForm]").val();
            if (F == '24Q') {
                window.location.href = "ManageSalary_ChallanList.aspx";
            }
            else {
                window.location.href = "ManageNonSalary_ChallanList.aspx";
            }


        });
        $("[id*=btnReturns]").click(function () {
            var F = $("[id*=ddlForm]").val();
            if (F == '24Q') {
                window.location.href = "EReturns_Salary.aspx";
            }
            else {
                window.location.href = "EReturns_NonSalary.aspx";
            }
        });

    });

    function GetonLoad()
    {
        GetDetails();
        var Q = $("[id*=ddlQuater]").val();
        var F = $("[id*=ddlForm]").val();
        var Conn = $("[id*=hdnConnString]").val();
        var compid = $("[id*=hdnCompanyid]").val();
        $("[id*=lblCntD]").html(0);
        $("[id*=lblVPan]").html(0);
        $("[id*=lblAmtP]").html('0.00');
        $("[id*=lblTDS]").html('0.00');
        $("[id*=lblUPaid]").html(0);
        $("[id*=lblMis]").html(0);
        $("[id*=lblNo]").html(0);
        $("[id*=lblAB]").html(0);
        $("[id*=lblunVerify]").html(0);
        $("[id*=lblCAmt]").html('0.00');
        $("[id*=lblRCamt]").html('0.00'); 
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../handler/Dashboard.asmx/GetonLoad",
            data: '{compid:' + compid + ',Q:"' + Q + '", F:"' + F + '",Conn:"' + Conn + '"}',
            dataType: "json",
            success: function (msg) {
                var myList = jQuery.parseJSON(msg.d);
                myList = myList[0];
                var Grd = myList.VoucherGrd;   //Fill Sec
                var Sec = myList.Section;
                var Vchr = myList.VoucherModify;
                var Pan = myList.lstPanno;
                var tbl = '';
                $("[id*=tblSec]").empty();

                tbl = tbl + "<thead><tr >";
                tbl = tbl + "<th style='text-align: center;font-size:16px;background-color:#d3d3d3;' class='cssGridHeader' >Sec</th>";
                tbl = tbl + "<th style='width:10%;font-size:16px;background-color:#d3d3d3;' class='cssGridHeader' >Rate</th>";
                tbl = tbl + "<th style='width:10%;font-size:16px;background-color:#d3d3d3;' class='cssGridHeader' >Records</th>";
                tbl = tbl + "<th style='width:20%;font-size:16px;background-color:#d3d3d3;' class='cssGridHeader' >Amount Paid</th>";
                tbl = tbl + "<th style='width:20%;font-size:16px;background-color:#d3d3d3;' class='cssGridHeader' >TDS</th>";

                tbl = tbl + "</tr></thead>";
                 
                    if (Grd.length > 0) {
                        tbl = tbl + "<tbody>";
                        for (var i = 0; i < Grd.length; i++) {
                            tbl = tbl + "<tr>";
                            tbl = tbl + "<td style='text-align: left;' class='cssGrdAlterItemStyle'  onclick='Edit_Show($(this))'>" + Grd[i].sec + "</td>";
                            tbl = tbl + "<td style='text-align: left;' class='cssGrdAlterItemStyle'  onclick='Edit_Show($(this))'>" + Grd[i].TdsRate + "</td>";
                            tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' onclick='Edit_Show($(this))'>" + Grd[i].Totalcount + "</td>";
                            var a = Grd[i].AmtPaid + '.00';
                            a = a.split('.');
                            if (a[1] > 0) {
                                tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' onclick='Edit_Show($(this))'>" + Grd[i].AmtPaid + "</td>";
                            }
                            else {
                                tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' onclick='Edit_Show($(this))'>" + Grd[i].AmtPaid + '.00' + "</td>";
                            }
                            tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' ><label id='lblup' onclick='Edit_ShowUP($(this))'> " + Grd[i].TdsAmt + '.00' + "</label></td></tr>";
                        };
                        tbl = tbl + "</tbody>";
                        $("[id*=tblSec]").append(tbl);
                        //// fill voucher details
                    }
                    if (Vchr.length > 0) {
                        $("[id*=lblCntD]").html(Vchr[0].did);
                        $("[id*=lblVPan]").html(Vchr[0].nid);


                        //$("[id*=lblAmtP]").html(Vchr[0].AmtPaid + '.00');
                        var a = Vchr[0].AmtPaid + '.00';
                        a = a.split('.');
                        if (a[1] > 0) {
                            $("[id*=lblAmtP]").html(Vchr[0].AmtPaid);
                        }
                        else {
                            $("[id*=lblAmtP]").html(Vchr[0].AmtPaid + '.00');
                        }
                        $("[id*=lblTDS]").html(Vchr[0].TdsAmt + '.00');
                        $("[id*=lblUPaid]").html(Vchr[0].Total);
                        $("[id*=lblsCntCT]").html();
                        $("[id*=lblVr]").html(Vchr[0].UVCCA);
                        $("[id*=txtToken]").val(Vchr[0].RToken);

                        $("[id*=lblAB]").html(Vchr[0].VCCA);

                        $("[id*=lblMis]").html(0);
                    }
                    ChartSec(Sec);

                    //// fill challan details
                    var Chl = myList.Challan;
                    if (Chl.length > 0) {
                        $("[id*=lblNo]").html(Chl[0].ChallanID);
                        $("[id*=lblCAmt]").html(Chl[0].CAmount + '.00');
                        $("[id*=lblunVerify]").html(Chl[0].Verify);
                        $("[id*=lblvry]").html(Chl[0].ndVrfy);
                        $("[id*=lblRCamt]").html(Chl[0].CAmount + '.00');
                    }
                    //// Returns
                  
                    if (Pan.length > 0) {
                        $("[id*=lblLK]").html(Pan[0].Active);
                        $("[id*=lblNL]").html(Pan[0].InActive);
                        $("[id*=lblNV]").html(Pan[0].NotVerified);
                        $("[id*=lblIVL]").html(Pan[0].InValid);
                    }
                 
                
            },
            failure: function (response) {

            },
            error: function (response) {

            }
        });
    }

    function GetonLoadSal() {
        GetDetails();
        var Q = $("[id*=ddlQuater]").val();
        var F = $("[id*=ddlForm]").val();
        var Conn = $("[id*=hdnConnString]").val();
        var compid = $("[id*=hdnCompanyid]").val();
        $("[id*=lblsCntD]").html(0);
        $("[id*=lblsVPan]").html(0);
        $("[id*=lblsAmtP]").html('0.00');
        $("[id*=lblsTDS]").html('0.00');
        $("[id*=lblsUPaid]").html(0);
        $("[id*=lblsMis]").html(0);
        $("[id*=lblsNo]").html(0);
        $("[id*=lblsAB]").html(0);
        $("[id*=lblsunVerify]").html(0);
        $("[id*=lblsCAmt]").html('0.00');
        $("[id*=lblsRCamt]").html('0.00');
        $("[id*=txtSToken]").val('');
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../handler/Dashboard.asmx/GetonLoad",
            data: '{compid:' + compid + ',Q:"' + Q + '", F:"' + F + '",Conn:"' + Conn + '"}',
            dataType: "json",
            success: function (msg) {
                var myList = jQuery.parseJSON(msg.d);
                myList = myList[0];
                var Grd = myList.VoucherGrd;   //Fill Sec
                var Sec = myList.Section;
                var Vchr = myList.VoucherModify;
                var tbl = '';
                $("[id*=tblSec]").empty();

                tbl = tbl + "<thead><tr >";
                tbl = tbl + "<th style='text-align: center; width:40%;font-size:16px;background-color:lightblue;' class='cssGridHeader' >Sec</th>";
                tbl = tbl + "<th style='width:10%;font-size:16px;background-color:lightblue;' class='cssGridHeader' >Rate</th>";
                tbl = tbl + "<th style='width:10%;font-size:16px;background-color:lightblue;' class='cssGridHeader' >Records</th>";
                tbl = tbl + "<th style='width:20%;font-size:16px;background-color:lightblue;' class='cssGridHeader' >Amount Paid</th>";
                tbl = tbl + "<th style='width:20%;font-size:16px;background-color:lightblue;' class='cssGridHeader' >TDS</th>";

                tbl = tbl + "</tr></thead>";

                if (Grd.length > 0) {
                    tbl = tbl + "<tbody>";
                    for (var i = 0; i < Grd.length; i++) {
                        tbl = tbl + "<tr>";
                        tbl = tbl + "<td style='text-align: left;' class='cssGrdAlterItemStyle'  onclick='Edit_Show($(this))'>" + Grd[i].sec + "</td>";
                        tbl = tbl + "<td style='text-align: left;' class='cssGrdAlterItemStyle'  onclick='Edit_Show($(this))'>" + Grd[i].TdsRate + "</td>";
                        tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' onclick='Edit_Show($(this))'>" + Grd[i].Totalcount + "</td>";
                        var a = Grd[i].AmtPaid + '.00';
                        a = a.split('.');
                        if (a[1] > 0) {
                            tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' onclick='Edit_Show($(this))'>" + Grd[i].AmtPaid + "</td>";
                        }
                        else {
                            tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' onclick='Edit_Show($(this))'>" + Grd[i].AmtPaid + '.00' + "</td>";
                        }
                        //tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' onclick='Edit_Show($(this))'>" + Grd[i].AmtPaid + '.00' + "</td>";
                        tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' ><label id='lblup' onclick='Edit_ShowUP($(this))'> " + Grd[i].TdsAmt + '.00' + "</label></td></tr>";
                    };
                    tbl = tbl + "</tbody>";
                    $("[id*=tblSec]").append(tbl);
                    //// fill voucher details
                }
                if (Vchr.length > 0) {
                    $("[id*=lblsCntD]").html(Vchr[0].did);
                    $("[id*=lblsVPan]").html(Vchr[0].nid);
                    var a = Vchr[0].AmtPaid + '.00';
                    a = a.split('.');
                    if (a[1] > 0) {
                        $("[id*=lblsAmtP]").html(Vchr[0].AmtPaid);
                    }
                    else {
                        $("[id*=lblsAmtP]").html(Vchr[0].AmtPaid + '.00');
                    }
                    //$("[id*=lblsAmtP]").html(Vchr[0].AmtPaid + '.00');
                    $("[id*=lblsTDS]").html(Vchr[0].TdsAmt + '.00');
                    $("[id*=lblsUPaid]").html(Vchr[0].Total);
                    $("[id*=txtToken]").html(Vchr[0].RToken);
                    $("[id*=lblsUPaid]").html(Vchr[0].UVCCA + '.00');
                    $("[id*=txtSToken]").val(Vchr[0].RToken);
                    $("[id*=lblsCntCT]").html(Vchr[0].VCCA);

                    //$("[id*=lblMis]").html(0);
                }
                //// fill challan details
                var Chl = myList.Challan;
                if (Chl.length > 0) {
                    $("[id*=lblsNo]").html(Chl[0].ChallanID);
                    $("[id*=lblsCAmt]").html(Chl[0].CAmount + '.00');
                    $("[id*=lblsunVerify]").html(Chl[0].Verify);
                    $("[id*=lblsvry]").html(Chl[0].ndVrfy);
                    $("[id*=lblsRCamt]").html(Chl[0].CAmount + '.00');
                }
                //// Returns
                //$("[id*=lblSts]").html();
                //$("[id*=lblGen]").html();

                ChartSec(Sec);

            },
            failure: function (response) {

            },
            error: function (response) {

            }
        });
    }

    function ChartSec(Sec)
    {

        //var element = '', size = '';
        //element = '#Pie', size = 200;
        var dataSec = '';
        var SecData = [];

        if (Sec.length > 0) {


            for (var i = 0; i < Sec.length; i++) {
                dataSec = "'"+ Sec[i].Section +"'" +',' + dataSec;
                var item = "{value:" + parseInt(Sec[i].Tds_Amt) + ",name:'" + Sec[i].Section + "'}";
                SecData.push({
                    value: parseInt(Sec[i].Tds_Amt),
                    name: Sec[i].Section
                });
            }
            //// Remove last Comma
            var i = dataSec.lastIndexOf(",");
            dataSec = dataSec.substring(0, i)

        }
        else
        {
            SecData.push({
                value: 0,
                name: 'No Data'
            });

        }
        //  $("[id*=Pie]").html('');
        // Charts configuration

        var pie_basic_element = document.getElementById('Pie');
        var myChart = echarts.init(pie_basic_element);
        var option;

            // Options
        option ={

                // Colors
                color: [
                    '#228B22', '#FFA500', '#5ab1ef', '#ff80df', '#d87a80',
                    '#8d98b3', '#e5cf0d', '#97b552', '#95706d', '#dc69aa',
                    '#07a2a4', '#9a7fd1', '#588dd5', '#f5994e', '#c05050',
                    '#59678c', '#c9ab00', '#7eb00a', '#6f5553', '#c14089',

                    '#228B22', '#FFA500', '#5ab1ef', '#ff80df', '#d87a80',
                    '#8d98b3', '#e5cf0d', '#97b552', '#95706d', '#dc69aa',
                    '#07a2a4', '#9a7fd1', '#588dd5', '#f5994e', '#c05050',
                    '#59678c', '#c9ab00', '#7eb00a', '#6f5553', '#c14089'
                ],

                // Global text styles
                textStyle: {
                    fontFamily: 'Roboto, Arial, Verdana, sans-serif',
                    fontSize: 13
                },

                //// Add title
                //title: {
                //    text: '',
                //    subtext: '',
                //    left: 'center',
                //    textStyle: {
                //        fontSize: 17,
                //        fontWeight: 500
                //    },
                //    subtextStyle: {
                //        fontSize: 12
                //    }
                //},

                // Add tooltip
                tooltip: {
                    trigger: 'item',
                    backgroundColor: 'rgba(0,0,0,0.75)',
                    padding: [10, 15],
                    textStyle: {
                        fontSize: 13,
                        fontFamily: 'Roboto, sans-serif'
                    },
                    formatter: "{a} <br/>{b}: {c} ({d}%)"
                },

                // Add legend
                legend: {
                    orient: 'vertical',
                    top: 'center',
                    left: 0,
                    // data: ['IE', 'Opera', 'Safari', 'Firefox', 'Chrome'],
                    data: [dataSec],
                    itemHeight: 8,
                    itemWidth: 8
                },

                // Add series
                series: [
                    {
                        name: 'Section',
                        type: 'pie',
                        radius: '70%',
                        center: ['50%', '57.5%'],
                        itemStyle: {
                            normal: {
                                borderWidth: 1,
                                borderColor: '#fff'
                            }
                        },

                        data:SecData
                    }


                ]
            }
             
        option && myChart.setOption(option);
           
    }
    function chkCSI(i) {
        var chkprop = i.is(':checked');
        if (chkprop) {
            $("[id*=trAuto1]").show();
            $("[id*=trAuto2]").show();

            $("[id*=trMenu1]").hide();
            $("[id*=trMenu2]").hide();
            $("[id*=hdnCheckCSI]").val(1);
        } else {
            $("[id*=trAuto1]").hide();
            $("[id*=trAuto2]").hide();

            $("[id*=trMenu1]").show();
            $("[id*=trMenu2]").show();
            $("[id*=hdnCheckCSI]").val(0);
        }
    }

    function SaveToken(F, Q, T)
    {
        var Conn = $("[id*=hdnConnString]").val();
        var compid = $("[id*=hdnCompanyid]").val();
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../handler/Dashboard.asmx/SaveToken",
            data: '{compid:' + compid + ',Q:"' + Q + '", F:"' + F + '", T:"' + T + '", Conn:"' + Conn + '"}',
            dataType: "json",
            success: function (msg) {
                var myList = jQuery.parseJSON(msg.d);
                if (myList.length > 0) {

                }
            },
            failure: function (response) {

            },
            error: function (response) {

            }
        });


    }

    function GetDetails() {
        var Q = $("[id*=ddlQuater]").val();
        var F = $("[id*=ddlForm]").val();
        var Conn = $("[id*=hdnConnString]").val();
        var compid = $("[id*=hdnCompanyid]").val();
        var t = $("[id*=txtTanNo]").val();
        //$("[id*=btnDwn]").attr("disabled", "true");
        //$("[id*=btnRtn]").attr("disabled", "true");
        //$("[id*=btn27Rtn]").attr("disabled", "true");
        $("[id*=lblsrtn]").html('../../....');
        $("[id*=lblsSts]").html('Not Generated');
        $("[id*=lblrtn]").html('../../....');
        $("[id*=lblSts]").html('Not Generated');
        $("[id*=hdnRtn]").val('');
        $("[id*=hdnPDF]").val('');

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../handler/Dashboard.asmx/GetReturns_details",
            data: '{compid:' + compid + ',Q:"' + Q + '", F:"' + F + '", TanNo:"' + t + '", Conn:"' + Conn + '"}',
            dataType: "json",
            success: function (msg) {
                var myList = jQuery.parseJSON(msg.d);
                if (myList.length > 0) {
                    if (F == '24Q')
                    {
                        if (myList[0].ST != '') {
                            $("[id*=lblsrtn]").html(myList[0].ST);
                            $("[id*=lblsSts]").html(myList[0].Rstatus);
                        }
                    }
                    else
                    {
                        if (myList[0].ST != '') {
                            $("[id*=lblrtn]").html(myList[0].ST);
                            $("[id*=lblSts]").html(myList[0].Rstatus);
                        }
                    }

                    $("[id*=hdnRtn]").val(myList[0].Rfile);
                    $("[id*=hdnPDF]").val(myList[0].Pfile);
                    $("[id*=hdnXlPath]").val(myList[0].XLPath);
                }
            },
            failure: function (response) {

            },
            error: function (response) {

            }
        });
    }

    function Get_TAN(temp) {
    
        var compid = temp;

        $.ajax({
            type: "POST",
            url: "../Handler/Ws_PanNo.asmx/GetPanNo",
            data: '{compid:' + compid + '}',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function (msg) {
                var myList = jQuery.parseJSON(msg.d);
                if (myList == null) {
                }
                else {
                    if (myList.length > 0) {
                        var tan = myList[0].panno;
                        if (myList[0].Gstn == '')
                        {
                            alert('Update Gstn no in company details' + response.d);
                        }
                        $("[id*=txtTanNo]").val(tan);
                    }
                    $("[id*=hdntanno]").val(tan);
                       
                    GetonLoad();
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

    function ShowLoader() {

        $('.MastermodalBackground2').css("display", "block");
    }

    function hideloader() {

        $('.MastermodalBackground2').css("display", "none");
    }



    function HideModalPopup() {
        $find("programmaticModalPopupOrginalBehavior").hide();
        $("[id*=lblProcess]").hide();
        $("[id*=lblSuccess]").hide();
        return false;
    }
    ///// show modalpopup
    function ShowModalPopup() {
        $find("programmaticModalPopupOrginalBehavior").show();
        $("[id*=lblProcess]").hide();
        $("[id*=lblSuccess]").hide();
        return false;
    }

    function ChallanTable()
    {
        var Q = $("[id*=ddlQuater]").val();
        var F = $("[id*=ddlForm]").val();
        var Conn = $("[id*=hdnConnString]").val();
        var compid = $("[id*=hdnCompanyid]").val();

        $.ajax({
            type: "POST",
            url: "../Handler/Dashboard.asmx/Get_VerifiedChallans",
            data: '{compid:' + compid + ',Q:"' + Q + '", F:"' + F + '",Conn:"' + Conn + '"}',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function (msg) {
                var myList = jQuery.parseJSON(msg.d);
                $("[id*=trChln]").show();
                var tbl = '';
                $("[id*=tblChln] tbody").empty();

                tbl = tbl + "<tr >";
                tbl = tbl + "<th style='font-size:14px;background-color:lightblue; width:100px;' class='cssGridHeader' >Challan No</th>";
                tbl = tbl + "<th style='font-size:14px;background-color:lightblue; width:100px;' class='cssGridHeader' >Date</th>";
                tbl = tbl + "<th style='font-size:14px;background-color:lightblue; width:120px;' class='cssGridHeader' >BSR Code</th>";
                tbl = tbl + "<th style='font-size:14px;background-color:lightblue; width:120px;' class='cssGridHeader' >Deductee Tot</th>";
                tbl = tbl + "<th style='font-size:14px;background-color:lightblue; width:100px;' class='cssGridHeader' >Sec</th>";
                tbl = tbl + "<th style='font-size:14px;background-color:lightblue;' class='cssGridHeader' >TDS</th>";
                tbl = tbl + "<th style='font-size:14px;background-color:lightblue;' class='cssGridHeader' >Interest</th>";
                tbl = tbl + "<th style='font-size:14px;background-color:lightblue;' class='cssGridHeader' >Amount</th>";
                tbl = tbl + "<th style='font-size:14px;background-color:lightblue;' class='cssGridHeader' >Verify</th>";
                tbl = tbl + "</tr>";

                if (myList.length > 0) {
                    for (var i = 0; i < myList.length; i++) {
                        tbl = tbl + "<tr>";
                        tbl = tbl + "<td style='text-align: left;' class='cssGrdAlterItemStyle'  >" + myList[i].ChallanNo + "</td>";
                        tbl = tbl + "<td style='text-align: left;' class='cssGrdAlterItemStyle'  >" + myList[i].ChallanDate + "</td>";
                        tbl = tbl + "<td style='text-align: center;' class='cssGrdAlterItemStyle' >" + myList[i].BSR + "</td>";
                        tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' >" + myList[i].CTotal + "</td>";
                        tbl = tbl + "<td style='text-align: center;' class='cssGrdAlterItemStyle'  >" + myList[i].Sec + "</td>";
                        tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle'  >" + myList[i].TDS + "</td>";
                        tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' >" + myList[i].Interest + "</td>";
                        tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' >" + myList[i].CAmount + "</td>";
                        var v = myList[i].Verify;
                        if (v == 'Matched')
                        { tbl = tbl + "<td style='text-align: center; class='cssGrdAlterItemStyle' > <label style='color:Green;font-bold:true; ' class='cssLabel'>" + myList[i].Verify + "</label></td>"; }
                        else
                        {
                            tbl = tbl + "<td style='text-align: center; class='cssGrdAlterItemStyle' > <label style='color:Red;font-bold:true; ' class='cssLabel'>" + myList[i].Verify + "</label></td>";
                        }
                    };
                    $("[id*=tblChln]").append(tbl);

                }
            },
            failure: function (response) {
                $("[id*=trChln]").hide();
                alert('Cant Connect to Server' + response.d);
            },
            error: function (response) {
                $("[id*=trChln]").hide();
                alert('Error Occoured ' + response.d);
            }
        });
    }

    function ChallanTableSAL() {
        var Q = $("[id*=ddlQuater]").val();
        var F = $("[id*=ddlForm]").val();
        var Conn = $("[id*=hdnConnString]").val();
        var compid = $("[id*=hdnCompanyid]").val();

        $.ajax({
            type: "POST",
            url: "../Handler/Dashboard.asmx/Get_VerifiedChallans",
            data: '{compid:' + compid + ',Q:"' + Q + '", F:"' + F + '",Conn:"' + Conn + '"}',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function (msg) {
                var myList = jQuery.parseJSON(msg.d);
                $("[id*=trsChln]").show();
                var tbl = '';
                $("[id*=tblsChln] tbody").empty();

                tbl = tbl + "<tr >";
                tbl = tbl + "<th style='font-size:14px;background-color:lightblue; width:100px;' class='cssGridHeader' >Challan No</th>";
                tbl = tbl + "<th style='font-size:14px;background-color:lightblue; width:100px;' class='cssGridHeader' >Date</th>";
                tbl = tbl + "<th style='font-size:14px;background-color:lightblue; width:120px;' class='cssGridHeader' >BSR Code</th>";
                tbl = tbl + "<th style='font-size:14px;background-color:lightblue; width:120px;' class='cssGridHeader' >Deductee Tot</th>";
                tbl = tbl + "<th style='font-size:14px;background-color:lightblue; width:100px;' class='cssGridHeader' >Sec</th>";
                tbl = tbl + "<th style='font-size:14px;background-color:lightblue;' class='cssGridHeader' >TDS</th>";
                tbl = tbl + "<th style='font-size:14px;background-color:lightblue;' class='cssGridHeader' >Interest</th>";
                tbl = tbl + "<th style='font-size:14px;background-color:lightblue;' class='cssGridHeader' >Amount</th>";
                tbl = tbl + "<th style='font-size:14px;background-color:lightblue;' class='cssGridHeader' >Verify</th>";
                tbl = tbl + "</tr>";

                if (myList.length > 0) {
                    for (var i = 0; i < myList.length; i++) {
                        tbl = tbl + "<tr>";
                        tbl = tbl + "<td style='text-align: left;' class='cssGrdAlterItemStyle'  >" + myList[i].ChallanNo + "</td>";
                        tbl = tbl + "<td style='text-align: left;' class='cssGrdAlterItemStyle'  >" + myList[i].ChallanDate + "</td>";
                        tbl = tbl + "<td style='text-align: center;' class='cssGrdAlterItemStyle' >" + myList[i].BSR + "</td>";
                        tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' >" + myList[i].CTotal + "</td>";
                        tbl = tbl + "<td style='text-align: center;' class='cssGrdAlterItemStyle'  >" + myList[i].Sec + "</td>";
                        tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle'  >" + myList[i].TDS + "</td>";
                        tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' >" + myList[i].Interest + "</td>";
                        tbl = tbl + "<td style='text-align: right;' class='cssGrdAlterItemStyle' >" + myList[i].CAmount + "</td>";
                        var v = myList[i].Verify;
                        if (v == 'Matched')
                        { tbl = tbl + "<td style='text-align: center; class='cssGrdAlterItemStyle' > <label style='color:Green;font-bold:true; ' class='cssLabel'>" + myList[i].Verify + "</label></td>"; }
                        else
                        {
                            tbl = tbl + "<td style='text-align: center; class='cssGrdAlterItemStyle' > <label style='color:Red;font-bold:true; ' class='cssLabel'>" + myList[i].Verify + "</label></td>";
                        }
                    };
                    $("[id*=tblsChln]").append(tbl);

                }
            },
            failure: function (response) {
                $("[id*=trsChln]").hide();
                alert('Cant Connect to Server' + response.d);
            },
            error: function (response) {
                $("[id*=trsChln]").hide();
                alert('Error Occoured ' + response.d);
            }
        });
    }

    function getPANList(i) {
        var sts = i;
        if (parseFloat(i) > 0) {
            window.location.href = "BulkPAN_Verification_AllVoucher.aspx";
        }
        var lblNL = $("[id*=lblNL]").html();
        var lblIVL = $("[id*=lblIVL]").html();
        if (parseFloat(lblNL) > 0) {
            window.location.href = "BulkPAN_Verification_AllVoucher.aspx";
        }
        else if (parseFloat(lblIVL) > 0) {
            window.location.href = "BulkPAN_Verification_AllVoucher.aspx";
        }
        else {
            alert('No Records found');
        }
    }

    function BRedirect(i) {
        if (parseFloat(i) > 0) {
            window.location.href = "BulkPAN_Verification_AllVoucher.aspx";
        }
        var lblNV = $("[id*=lblNV]").html();
        var lblIVL = $("[id*=lblIVL]").html();
        if (parseFloat(lblNV) > 0) {
            window.location.href = "BulkPAN_Verification_AllVoucher.aspx";
        }
        else if (parseFloat(lblIVL) > 0) {
            window.location.href = "BulkPAN_Verification_AllVoucher.aspx";
        }
        else {
            window.location.href = "BulkPAN_Verification_AllVoucher.aspx";
        }
    }


    RequestTrace = function () {


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
         
        var Q = $("[id*=ddlQuater]").val();
        var F = $("[id*=ddlForm]").val();
        if ((UserID == null || UserID == "") || (Password == null || Password == "")) {
            ShowErrorWindow('Enter User Login Details');
            return false;
        }


        if (TAN_NO == null || TAN_NO == undefined) {
            ShowErrorWindow('TAN - Cannot be Blank');
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
                HideModalPopup();
                hideloader();
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
                        $("[id*=lblSuccess]").show();
                        $("#captcha").val("");
                         
                        window.location.href = "Challan_Status.aspx";
                        return false;
                    }
                    if (result.timeout) {
                        $("#captcha").val("");

                        return false;
                    }
                    if (result.Failed) {
                        
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
                ShowErrorWindow(response.d);
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
                    ShowErrorWindow(result.error);
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
                ShowErrorWindow(response.d);
            }
        });

    }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
           <asp:HiddenField ID="hdnval" runat="server" />
            <asp:HiddenField ID="hdnfinancialyear" runat="server" />
            <asp:HiddenField ID="hdntanno" runat="server" />
            <asp:HiddenField ID="hdntblChln" runat="server" />
            <asp:HiddenField ID="hdnCompanyid" runat="server" />
            <asp:HiddenField ID="hdnConnString" runat="server" />
            <asp:HiddenField ID="hdnXlPath" runat="server" />
            <asp:HiddenField ID="hdnRtn" runat="server" />
            <asp:HiddenField ID="hdnPDF" runat="server" />
            <asp:HiddenField ID="hdnSRtn" runat="server" />
            <asp:HiddenField ID="hdnSPDF" runat="server" />
            <asp:HiddenField ID="hdnQuarter" runat="server" />
            <asp:HiddenField ID="hdnForm" runat="server" />
<table id="Table1" runat="server" width="100%" cellpadding="5" cellspacing="0">
    <tr>
        <td>
            <UC:MessageControl runat="server" ID="ucMessageControl" />
        </td>
    </tr>
    <tr>
        <td>
            <table>
                <tr>
                    <td style="width:1078px;height:50px;">
                        <table>
                            <tr>
                                <td style="font-weight:bold; width:3%; padding-left:15px;padding-top:10px;font-weight:bold; font-size:14px; ">Form

                                </td>
                                <td  style="width:8%; padding-top:5px; " >
                                    <select id="ddlForm" class="cssDropDownList" >
                                        <option value="26Q">26Q</option>
                                        <option value="27Q">27Q</option>
                                        <option value="27EQ">27EQ</option>
                                        <option value="24Q">24Q</option>
                                    </select>
                                </td>
                                <td style="font-weight:bold; width:3%; padding-left:15px;padding-top:10px; font-weight:bold; font-size:14px; ">Qtr

                                </td>
                                <td style="width:10%; padding-top:5px; ">
                                    <select id="ddlQuater" class="cssDropDownList"  >
                                        <option value="Q1">Q1</option>
                                        <option value="Q2">Q2</option>
                                        <option value="Q3">Q3</option>
                                        <option value="Q4">Q4</option>
                                    </select>
                                </td>
                                <td style="width:10%;">
                                    <asp:Button id="btnBackup" runat="server" cssclass="btn btn-block bg-gradient-info whats" type="button"  text ="Backup Your Data Now" OnClick="btnBackup_Click" />
                                </td>
                                <td style="width:10%;">
                                    <input id="btnVouchers" runat="server" class="btn btn-block bg-gradient-info whats" type="button"  value ="Step 1. Vouchers" />
                                </td>
                                <td style="width:10%;">
                                    <input id="btnChallans" runat="server" class="btn btn-block bg-gradient-info whats" type="button" value ="Step 2. Challans" />
                                </td>

                                <td style="width:10%;">
                                    <input id="btnVerify" type="button" class="btn btn-block bg-gradient-info whats" value="Step 3. Challan Verify" />
                                </td>
                                <td style="width:10%;">
                                    <input id="btnReturns" runat="server" class="btn btn-block bg-gradient-info whats" type="button" value ="Step 4. Returns" />
                                </td>
                            </tr>
                        </table>

                    </td>
                    <td>

                    </td>
                </tr>
<%--                <tr style="height:5px;" >
                    <td></td>
                </tr>--%>
                <tr>
                    <td>
                       <fieldset style=" padding: 10px;">
                          <legend style="font-size:14px;">Section Summary</legend>
                        <table  style="width:100%;" >
                            <tr>
                                <td>
                                     <div >
                                        <div >
                                            <div >
                                                <div class="chart has-fixed-height col-md-12 " style="height: 200px;width:370px;" id="Pie"></div>
                                            </div> 
                                         </div> 
                                      </div>
                                </td>
                                <td>
                                    <div style="max-height: 200px; width: 100%; overflow: auto; padding-right: -15px;">
                                        <table id="tblSec" class="tblBorderClass" style="width:100%;">

                                        </table>
                                    </div>
                                </td>

                            </tr>
                        </table>
                        </fieldset> 
                    </td>
                    <td style="text-align:center;">
                       <fieldset style=" padding: 10px;">
                          <legend style="font-size:14px; color:red;">PAN Summary</legend>
                         <div style="max-height: 200px; width: 100%; overflow: auto; padding-right: -15px;">

                            <table class="tblBorderClass" >
                                <tr style="height:30px;">
                                    <td style="font-size:14px; font-weight:bold; background-color:#d3d3d3;">Description</td>
                                    <td style="font-size:14px; font-weight:bold;background-color:#d3d3d3;">PAN Count</td>
                                </tr>
                                <tr style="height:30px;">
                                    <td  style="font-size:13px;  ">Valid & Operative Pan</td>
                                    <td><label id="lblLK" runat="server" style="font-size:14px; font-weight:bold; color:green; "  >0</label></td>
                             
                                </tr>
                                <tr style="height:30px;">

                                    <td  style="font-size:13px;  ">Valid & Inoperative</td>
                                    <td><label id="lblNL"  runat="server" style="font-size:14px; font-weight:bold; color:red; cursor:grab;" onclick='getPANList("Invalid")' >0</label></td>
                             
                                </tr>
                                <tr style="height:30px;">

                                    <td  style="font-size:13px;  ">InValid</td>
                                    <td><label id='lblIVL' runat="server"  style='font-size:14px; font-weight:bold; color:crimson;' onclick='BRedirect($(this).val())' >0</label></td>
                                </tr>
                                <tr style="height:30px;">

                                    <td  style="font-size:13px;  ">Not Verified</td>
                                    <td><label id='lblNV' runat="server"  style='font-size:14px; font-weight:bold; color:orange;' onclick='BRedirect($(this).val())' >0</label></td>
                                </tr>
                                <tr style="height:30px;">
                                   
                                    <td colspan="2">
                                   <input type="button" id ="btnPvr"  value="Verify PAN Now"  class="whats" onclick='BRedirect(0)' /></td>
                                     
                                </tr>
                                
                            </table>

                        </div>

                        </fieldset> 
                            
                    </td>
                </tr>
            </table>

        </td>
    </tr>
    <tr style="height:15px;">
        <td></td>
    </tr>
    <tr>
        <td>
            <div id="Nontbs">
              <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#home" style="font-weight:bold; font-size:14px; ">eReturns</a></li>
                <li><a data-toggle="tab" href="#menu1"  style="font-weight:bold; font-size:14px;">Deductee</a></li>
                <li><a data-toggle="tab" href="#menu2"  style="font-weight:bold; font-size:14px;">Voucher Details</a></li>
                <li><a data-toggle="tab" id="Tabmenu3" href="#menu3" style="font-weight:bold; font-size:14px;">Challan</a></li>
            </ul>
              <div class="tab-content">
                <div id="home" class="tab-pane fade in active">

                            <table style="width:100%;" class="tbl">
<%--                            <tr>
                    
                                <td style=" width:20%; text-align:center;font-weight:bold; font-size:16px;">eReturns</td>
                            </tr>--%>
                            <tr>
                                <td>
                                    <table style="width:100%;" class="tbl">
                                        <tr>
                                            <td style=" text-align:center;font-weight:bold;  height:30px; ">Status</td>
                                            <td style=" text-align:center;font-weight:bold;  height:30px; width:150px; ">Prepared DT.</td>
                                            <td style=" text-align:center;font-weight:bold;  height:30px; width:150px; ">Challan Amt</td>
                                            <td style=" text-align:center;font-weight:bold;  height:30px; width:150px; ">Token No</td>
                                            <td style=" text-align:center;font-weight:bold;  height:30px; ">Prepare eReturns</td>
                                            <td style=" text-align:center;font-weight:bold;  height:30px; ">
<%--                                                <label id="lbldwn" style="font-size:12px; font-weight:bold; background-color:#ffffff; border:none ;" runat="server" class="cssLabel">Download</label>--%>
                                                <label id="lbldwn" style="font-size:12px; font-weight:bold; background-color:#ffffff; border:none ;" runat="server" class="cssLabel">Download</label>
                                            </td>
                                            <td style=" text-align:center;font-weight:bold;  height:30px; ">File Returns</td>
                                            <td style=" text-align:center;font-weight:bold;  height:30px; ">
                                                <label id="lblvw" style="font-size:12px; font-weight:bold; background-color:#ffffff; border:none ;" runat="server" class="cssLabel">View</label></td>

                                        </tr>
                                        <tr style="height:40px;" >
                                            <td style=" padding-top :10px;text-align:center;">
                                                <label id="lblSts" style="font-size:14px; background-color:#ffffff; border:none ;" runat="server" class="cssLabel">Not Generated</label>
                                            </td>

                                            <td style=" padding-top :10px;text-align:center;">
                                                <label id="lblrtn" style="font-size:14px;background-color:#ffffff; border:none ; " runat="server" class="cssLabel">../../....</label>
                                            </td>
                                            <td style=" padding-top :10px; text-align:center ;">
                                                <label id="lblRCamt" style="font-size:14px; background-color:#ffffff; border:none ;" runat="server" class="cssLabel">0</label>
                                            </td>
                                            <td style=" padding-top :10px; text-align:center ;">
                                                <input id="txtToken" runat="server" style="width:150px" class="cssTextbox" maxlength="15"/>
                                            </td>
                                            <td style="text-align:center;">
                                                
                                                <asp:Button runat="server" ID="btnRtn" CssClass="cssButton" Width="90px" Text="Process" OnClick="btnRtn_Click"  ></asp:Button>
                                            </td>
                                            <td style="text-align:center;">
                                                <input type="button" id="btnDwn" value="Download"  class="cssButton"/>
                                            </td>
                                            <td style="text-align:center;">
                                                <input type="button" id="btnProcess" value="ITR"  class="cssButton"/>
                                            </td>
                                            <td style="text-align:center;">
                                                <input type="button" id="btn27Rtn" value="View"  class="cssButton"/>
                                            </td>

                                        </tr>
                                    </table>
                                </td>
                            </tr>

                            </table>   
                </div>
                <div id="menu1" class="tab-pane fade">
                            <table style="width:100%;" class="tbl">
<%--                                <tr>
                                    <td style=" width:60%; text-align:center;font-weight:bold; font-size:16px;">Deductee</td>
                                </tr>--%>
                                <tr>
                                    <td>
                                        <table  style="width:100%;" class="tbl">
                                            <tr>
                                                <td style=" text-align:center;font-weight:bold;  height:30px;  ">Total Deductee</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">Invalid Pan</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">Not Verified for u/s 206AB & 206CCA</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px;  ">Specified Person u/s 206AB & 206CCA</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">Compliance</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">Deductee</td>
                                            </tr>
                                            <tr style="height:40px; ">
                                                <td style=" padding-top :10px; text-align:center; ">
                                                    <label id="lblCntD"  style=" font-size:14px; background-color:#ffffff; border:none ; "  class="cssLabel"></label>
                                                </td>
                                                <td style=" padding-top :10px; text-align:center; ">
                                                    <label id="lblVPan"  style=" font-size:14px; background-color:#ffffff; border:none ;  "  class="cssLabel"></label>
                                                </td>
                                                <td style=" padding-top :10px; text-align:center; ">
                                                    <label id="lblVr"  style=" font-size:14px; background-color:#ffffff; border:none ; "  class="cssLabel"></label>
                                                </td>

                                                <td style=" padding-top :10px; text-align:center; ">
                                                    <label id="lblAB"  style=" font-size:14px; background-color:#ffffff; border:none ; "  class="cssLabel"></label>
                                                </td>
                                                <td style=" text-align:center; ">
                                                    <input type="button" id="btnCompliance"   value="Compliance Check"  class="cssButton"/>
                                                </td>
                                                 <td style=" text-align:center;">
                                                    <input type="button" id="btnAded" value="Add Deductee" class="cssButton"/>
                                                </td>

                                            </tr>
                                        </table>
                                    </td>
                                </tr>

                            </table>         
                </div>
                <div id="menu2" class="tab-pane fade">

                            <table style="width:100%;" class="tbl">
<%--                                <tr>
                                    <td style=" width:20%; text-align:center;font-weight:bold; font-size:16px;">Voucher Details</td>
                                </tr>--%>
                                <tr>
                                    <td>
                                        <table  style="width:100%;" class="tbl">
                                            <tr>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">Amt Paid</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">TDS Deducted</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">Unpaid Vouchers</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">Mismatch Entries</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">Voucher</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">Download</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">Upload</td>
                                            </tr>
                                            <tr style="height:40px;">                       
                        
                                                <td style=" padding-top :10px; text-align:center ; ">
                                                    <label id="lblAmtP"  style="font-size:14px; background-color:#ffffff; border:none ;"  class="cssLabel"   ></label>
                                                </td>
                                                <td style=" padding-top :10px; text-align:center ;">
                                                    <label id="lblTDS"  style="font-size:14px; background-color:#ffffff; border:none ;"  class="cssLabel" ></label>
                                                </td>
                                                <td style=" padding-top :10px; text-align:center ;">
                                                    <label id="lblUPaid"  style="font-size:14px; background-color:#ffffff; border:none ;"  class="cssLabel" ></label>
                                                </td>
                                                <td style=" padding-top :10px; text-align:center ;">
                                                    <label id="lblMis"  style="font-size:14px; background-color:#ffffff; border:none ;" class="cssLabel"  ></label>
                                                </td>
                                                <td style="  text-align:center;">
                                                   <input type="button" id="btnVoucher"   value="Add Voucher"  class="cssButton"/>
                                                </td>
                                                <td style="  text-align:center;">
                                                    <input type="button" id="btnXL"  value="Excel File"  class="cssButton"/>
                                                </td>
                                                <td style="  text-align:center;">
                                                    <input type="button" id="btnImp"value="Excel File"  class="cssButton"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>

                            </table>        
                </div>
                <div id="menu3" class="tab-pane fade">

                             <table style="width:100%;" class="tbl">
<%--                                <tr>
                                    <td style=" width:20%; text-align:center;font-weight:bold; font-size:16px;">Challan</td>
                                </tr>--%>
                                <tr>
                                    <td>
                                        <table style="width:100%;" class="tbl">
                                            <tr>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">No</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">Amount</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">Challan</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">Need to Verify</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">Verify</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">OLTAS UnMatched</td>

                                            </tr>
                                            <tr style="height:40px;">
                                                <td style=" text-align:center ">
                                                    <label id="lblNo"  style="font-size:14px; background-color:#ffffff; border:none ;  "  class="cssLabel" ></label>
                                                </td>
                                                <td style=" padding-top :10px; text-align:center ;">
                                                    <label id="lblCAmt"  style="font-size:14px; background-color:#ffffff; border:none ;" class="cssLabel"></label>
                                                </td>
                                                <td style="text-align:center">
                                                    <input type="button" id="btnChallan" value="Add Challan"  class="cssButton"/>
                                                </td>
                                                <td style="  text-align:center;">
                                                    <label id="lblvry"  style="font-size:14px; background-color:#ffffff; border:none ;" class="cssLabel"></label>
                                                </td>
                                                <td style="  text-align:center;">
                                                    <input ID="btnValid" type="button"  runat="server" value="Verify with OLTAS" class="cssButton" />
                                                </td>
                                                <td style=" padding-top :10px; text-align:center;">
                                                    <label id="lblunVerify"  style="font-size:14px; background-color:#ffffff; border:none ;  " class="cssLabel"  ></label>
                                                </td>

                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="trChln">
                                    <td style="text-align:center;">List of Challan verified with OLTAS</td>
                                </tr>
                            </table> 
                            <table id="tblChln" style="width:100%; " class="tblBorderClass"></table>        
                </div>
              </div>
        
            </div>
            <div id="Saltbs">
              <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#shome" style="font-weight:bold; font-size:14px; ">eReturns</a></li>
                <li><a data-toggle="tab" href="#smenu1"  style="font-weight:bold; font-size:14px;">Employees</a></li>
                <li><a data-toggle="tab" href="#smenu2"  style="font-weight:bold; font-size:14px;">Salary Details</a></li>
                <li><a data-toggle="tab" id="sTabmenu3" href="#smenu3" style="font-weight:bold; font-size:14px;">Challan</a></li>
            </ul>
              <div class="tab-content">
                <div id="shome" class="tab-pane fade in active">

                            <table style="width:100%;" class="tbl">
<%--                            <tr>
                    
                                <td style=" width:20%; text-align:center;font-weight:bold; font-size:16px;">eReturns</td>
                            </tr>--%>
                            <tr>
                                <td>
                                    <table style="width:100%;" class="tbl">
                                        <tr>
                                            <td style=" text-align:center;font-weight:bold;  height:30px; ">Status</td>
                                            <td style=" text-align:center;font-weight:bold;  height:30px; width:150px; ">Prepared DT.</td>
                                            <td style=" text-align:center;font-weight:bold;  height:30px; width:150px; ">Challan Amt</td>
                                            <td style=" text-align:center;font-weight:bold;  height:30px; width:150px; ">Token No</td>
                                            <td style=" text-align:center;font-weight:bold;  height:30px; ">Prepare eReturns</td>
                                            <td style=" text-align:center;font-weight:bold;  height:30px; ">
                                                <label id="Label1" style="font-size:12px; font-weight:bold; background-color:#ffffff; border:none ;" runat="server" class="cssLabel">Download</label></td>
                                            <td style=" text-align:center;font-weight:bold;  height:30px; ">File Returns</td>                                            
                                            <td style=" text-align:center;font-weight:bold;  height:30px; ">
                                                <label id="Label2" style="font-size:12px; font-weight:bold; background-color:#ffffff; border:none ;" runat="server" class="cssLabel">View</label></td>

                                        </tr>
                                        <tr style="height:40px;" >
                                            <td style=" padding-top :10px; text-align:center;">
                                                <label id="lblsSts" style="font-size:14px; background-color:#ffffff; border:none ;" runat="server" class="cssLabel">Not Generated</label>
                                            </td>

                                            <td style=" padding-top :10px;text-align:center;">
                                                <label id="lblsrtn" style="font-size:14px;background-color:#ffffff; border:none ; " runat="server" class="cssLabel">../../....</label>
                                            </td>
                                            <td style=" padding-top :10px; text-align:center ;">
                                                <label id="lblsRCamt" style="font-size:14px; background-color:#ffffff; border:none ;" runat="server" class="cssLabel">0</label>
                                            </td>
                                            <td style=" padding-top :10px; text-align:center ;">
                                                <input id="txtSToken" runat="server" style="width:150px" class="cssTextbox" maxlength="15"/>
                                            </td>

                                            <td style="text-align:center;">
                                                <%--<input type="button" id="btnRtn" value="Process"  class="cssButton"/>--%>
                                                <asp:Button runat="server" ID="btnSRtn" CssClass="cssButton" Width="90px" Text="Process" OnClick="btnRtn_Click"  ></asp:Button>
                                            </td>
                                            <td style="text-align:center;">
                                                <input type="button" id="btnSDwn" value="24Q"  class="cssButton"/>
                                            </td>
                                            <td style="text-align:center;">
                                                <input type="button" id="btnSProcess" value="ITE"  class="cssButton"/>
                                            </td>
                                            <td style="text-align:center;">
                                                <input type="button" id="btnS27Rtn" value="View"  class="cssButton"/>
                                            </td>

                                        </tr>
                                    </table>
                                </td>
                            </tr>

                            </table>   
                </div>
                <div id="smenu1" class="tab-pane fade">
                            <table style="width:100%;" class="tbl">
                                <tr>
                                    <td>
                                        <table  style="width:100%;" class="tbl">
                                            <tr>
                                                <td style=" text-align:center;font-weight:bold;  height:30px;  ">Employee</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px;  ">Total Employee</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">Invalid Pan</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">Computation</td>

                                            </tr>
                                            <tr style="height:40px; ">
                                                <td style=" text-align:center; ">
                                                    <input type="button" id="btnEmployee"   value="Add Employee"  class="cssButton"/>
                                                </td>
                                                <td style=" padding-top :10px; text-align:center; ">
                                                    <label id="lblsCntD"  style=" font-size:14px; background-color:#ffffff; border:none ; "  class="cssLabel"></label>
                                                </td>
                                                <td style=" padding-top :10px; text-align:center; ">
                                                    <label id="lblsVPan"  style=" font-size:14px; background-color:#ffffff; border:none ;  "  class="cssLabel"></label>
                                                </td>
                                                <td style=" padding-top :10px; text-align:center; ">
                                                    <label id="lblsCntCT"  style=" font-size:14px; background-color:#ffffff; border:none ; "  class="cssLabel"></label>
                                                </td>


                                            </tr>
                                        </table>
                                    </td>
                                </tr>

                            </table>         
                </div>
                <div id="smenu2" class="tab-pane fade">

                            <table style="width:100%;" class="tbl">
                                <tr>
                                    <td>
                                        <table  style="width:100%;" class="tbl">
                                            <tr>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">Total Gross Salary</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">Total Tax Deducted</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">Balance Tax Payable</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">Computation</td>

                                            </tr>
                                            <tr style="height:40px;">                       
                        
                                                <td style=" padding-top :10px; text-align:center ; ">
                                                    <label id="lblsAmtP"  style="font-size:14px; background-color:#ffffff; border:none ;"  class="cssLabel"   ></label>
                                                </td>
                                                <td style=" padding-top :10px; text-align:center ;">
                                                    <label id="lblsTDS"  style="font-size:14px; background-color:#ffffff; border:none ;"  class="cssLabel" ></label>
                                                </td>
                                                <td style=" padding-top :10px; text-align:center ;">
                                                    <label id="lblsUPaid"  style="font-size:14px; background-color:#ffffff; border:none ;"  class="cssLabel" ></label>
                                                </td>
                                                <td style=" padding-top :10px; text-align:center ;">
                                                    <input type="button" id="btnsAddComp" value="Add Computation"  class="cssButton"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>

                            </table>        
                </div>
                <div id="smenu3" class="tab-pane fade">

                             <table style="width:100%;" class="tbl">
                                <tr>
                                    <td>
                                        <table style="width:100%;" class="tbl">
                                            <tr>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">No</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">Amount</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">Challan</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">Need to Verify</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">Verify</td>
                                                <td style=" text-align:center;font-weight:bold;  height:30px; ">OLTAS UnMatched</td>

                                            </tr>
                                            <tr style="height:40px;">
                                                <td style=" text-align:center ">
                                                    <label id="lblsNo"  style="font-size:14px; background-color:#ffffff; border:none ;  "  class="cssLabel" ></label>
                                                </td>
                                                <td style=" padding-top :10px; text-align:center ;">
                                                    <label id="lblsCAmt"  style="font-size:14px; background-color:#ffffff; border:none ;" class="cssLabel"></label>
                                                </td>
                                                <td style="text-align:center">
                                                    <input type="button" id="btnsChallan" value="Add Challan"  class="cssButton"/>
                                                </td>
                                                <td style="  text-align:center;">
                                                    <label id="lblsvry"  style="font-size:14px; background-color:#ffffff; border:none ;" class="cssLabel"></label>
                                                </td>
                                                <td style="  text-align:center;">
                                                    <input ID="btnsValid" type="button"  runat="server" value="Verify with OLTAS" class="cssButton" />
                                                </td>
                                                <td style=" padding-top :10px; text-align:center;">
                                                    <label id="lblsunVerify"  style="font-size:14px; background-color:#ffffff; border:none ;  " class="cssLabel"  ></label>
                                                </td>

                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="trsChln">
                                    <td style="text-align:center;">List of Challan verified with OLTAS</td>
                                </tr>
                            </table> 
                            <table id="tblsChln" style="width:100%; " class="tblBorderClass"></table>        
                </div>
              </div>
        
            </div>
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


