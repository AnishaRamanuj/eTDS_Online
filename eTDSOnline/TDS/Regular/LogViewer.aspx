<%@ Page Title="" Language="C#" MasterPageFile="~/TDS/BTS_MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="LogViewer.aspx.cs" Inherits="LogViewer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../BTStrp/css/datepicker.min.css" rel="stylesheet" />
    <script src="../BTStrp/js/bootstrap_multiselect.js" type="text/javascript"></script>
    <script type="text/javascript" src="../BTStrp/js/moment.js"></script>
    <script src="../BTStrp/js/form_select2.js" type="text/javascript"></script>
    <script src="../BTStrp/js/datatables_basic.js" type="text/javascript"></script>
    <script src="../BTStrp/js/Ajax_Pager.min.js" type="text/javascript"></script>
    <script src="../BTStrp/js/components_popups.js" type="text/javascript"></script>
    <script src="../BTStrp/js/components_modals.js" type="text/javascript"></script>
    <script src="../BTStrp/js/echarts.min.js" type="text/javascript"></script>
    <script src="../BTStrp/js/PopupAlert.js" type="text/javascript"></script>
    <script src="../BTStrp/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../BTStrp/js/bootstrap2.3.2.min.js"></script>

    <style type="text/css">
        .tblChallan {
            table-layout: fixed;
            width: 100%;
        }

        #thErrorMsg {
            min-width: 250px;
        }
        input[type="radio"]{
          margin: 0 10px 0 10px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            //App.initBeforeLoad();
            //App.initCore();
            //App.initAfterLoad();
            $("[id*=btnUpdate]").hide();
            $("[id*=gridcard]").show();
            $("[id*=btnTxt]").hide();
            $("[id*=dv_grd]").show();
            $("[id*=compdetail]").hide();
            $("[id*=actionform]").hide();
            $("[id*=importsumm]").hide();
            FillCompanyDropdown();
            RefreshGrid(0, 0);
            $("[id*=btnBack]").click(function () {
                window.location.href = '../regular/dashboard.aspx';
            });

            $("[id*=btnUpload]").click(function () {
                RefreshGrid();
            });

            $("[id*=btnCancel]").click(function () {
                $("[id*=gridcard]").show();

                $("[id*=importconso]").show();
                $("[id*=compdetail]").hide();
                $("[id*=actionform]").hide();
                $("[id*=importsumm]").hide();
            });

            $("[id*=btnRefresh]").click(function () {
                var compid = $("[id*=ddlCompName2]").val();
                var lastMinutes = $("[id*=txtTimer]").val();
                RefreshGrid(compid, lastMinutes);
            });

            $("[id*=btnErrorLogDownload]").click(function () {
                $("[id*=btnExcel]").click();

            });



            $("[id*=ddlCompName2]").change(function () {
                var compid = $("[id*=ddlCompName2]").val();
                var lastMinutes = $("[id*=txtTimer]").val();
                RefreshGrid(compid, lastMinutes);
            });


            $("[id*=btnError]").click(function () {
                var s = $("[id*=hdnError]").val();
                window.location.href = s;
            });



        });

        function RefreshGrid(compId, lastMinutes) {

            Blockloadershow();


            debugger
            let startDate = '';
            let endDate = '';
            let pageIndex = 1;
            let pageSize = 1000;
            if ($("#range").is(":checked")) {
                // do something
                startDate = $('#txtStartDate').val();
                endDate = $('#txtEndDate').val();
                lastMinutes = 0;
            }
            else {
                lastMinutes = $("[id*=txtTimer]").val();
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/LogViewer.asmx/GetonLoad",
                data: '{compid:' + compId + ',lastMinutes:' + lastMinutes + ',startDate:"' + startDate + '",endDate:"' + endDate + '"}',
                dataType: "json",
                success: function (response) {
                    //+ ',startDate:"' + startDate + '", endDate:"' + endDate + '",pageIndex:' + pageIndex + ',pageSize:' + pageSize + 

                    //var xmlDoc = $.parseXML(fileName.d);
                    //var xml = $(xmlDoc);
                    //var Cid = fileName.find("Table");
                    debugger;
                    BindData(response);

                    //$("#lblMessage").html("<b>" + fileName + "</b> has been uploaded.");
                },
                failure: function (response) {
                    Blockloaderhide();
                    alert(response);
                },
                error: function (response) {
                    Blockloaderhide();
                    alert(response);
                },
                xhr: function () {
                    var fileXhr = $.ajaxSettings.xhr();
                    if (fileXhr.upload) {
                        $("progress").show();
                        fileXhr.upload.addEventListener("progress", function (e) {
                            if (e.lengthComputable) {
                                $("#fileProgress").attr({
                                    value: e.loaded,
                                    max: e.total
                                });
                            }
                        }, false);
                    }
                    return fileXhr;
                }

            });


        }

        function BindData(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var empRecords = xml.find("Table");
            var RecordCount = 0;
            var tbl = '';
            $("[id*=tblEventView] tbody").empty();
            $("[id*=tblEventView] thead").empty();
            tbl = tbl + "<thead style='background-color:#F2F2F2;'><tr>";
            tbl = tbl + "<th  style='text-align: center;font-weight: bold;'>Sr</th>";
            tbl = tbl + "<th style='font-weight: bold;text-align:left;padding-left:20px;' id='thErrorMsg'>Date</th>";
            tbl = tbl + "<th  style='font-weight: bold;text-align: center;'>TAN</th>";
            tbl = tbl + "<th  style='font-weight: bold;text-align: center;'>Deductee</th>";
            tbl = tbl + "<th  style='font-weight: bold;text-align: left;'>Action</th>";

            tbl = tbl + "</tr></thead>";

            if (empRecords.length > 0) {

                let counter = 1;
                $.each(empRecords, function () {
                    tbl = tbl + "<tr>";
                    tbl = tbl + "<td >" + counter + "</td>";
                    tbl = tbl + "<td >" + $(this).find("LogDateFormat").text() + "</td>";
                    tbl = tbl + "<td >" + $(this).find("TANNo").text() + "</td>";
                    tbl = tbl + "<td style='text-align: center;'>" + $(this).find("CompanyName").text() + "</td>";
                    tbl = tbl + "<td >" + $(this).find("PageName").text() + "-" + $(this).find("ProcessName").text() + "</td>";
                    tbl = tbl + "</tr>";
                    counter++;

                });

                $("[id*=tblEventView]").append(tbl);
            }
            else {
                tbl = tbl + "<tr>";
                tbl = tbl + "<td ></td>";
                tbl = tbl + "<td ></td>";
                tbl = tbl + "<td ></td>";
                tbl = tbl + "<td >No Record Found !!!</td>";
                tbl = tbl + "<td ></td>";
                tbl = tbl + "<td ></td>";
                tbl = tbl + "</tr>";
                $("[id*=tblEventView]").append(tbl);
            }
            Blockloaderhide();
        }



        function Deductee() {

            var compid = $("[id*=hdnCompanyid]").val();
            var Cid = $("[id*=hdnCorrectionId]").val();

            var CO = $("[id*=hdnCompanyid]").val();
            var q = $("[id*=txtQtr]").val();
            var f = $("[id*=txtFrm]").val();
            var t = $("[id*=txtTan]").val();
            var yr = $("[id*=txtFy]").val();
            var cn = $("[id*=txtCompany]").val();

            $("[id*=BtnSalary]").hide();

            if (f == '24Q') {
                $("[id*=BtnSalary]").show();
            }

            $.ajax({
                type: "POST",
                url: "../../TDS/BTStrp/handler/Correction.asmx/OpenDeducteePage",
                data: '{Compid:' + compid + ',Cid:' + Cid + ', q:"' + q + '",f:"' + f + '", t: "' + t + '",yr:"' + yr + '", cn: "' + cn + '"}',
                contentType: "application/json; charset=utf-8",
                success: function (msg) {
                    window.location.href = "DeducteeCorrections.aspx";
                },
                failure: function (response) {

                },
                error: function (response) {
                    Blockloaderhide();
                }
            });
        }

        function getShortErrorMessage(message) {
            if (message.length > 30) {
                return $.trim(message).substring(0, 30);
            }
            else {
                return $.trim(message);
            }
        }

        function eReturns() {
            var compid = $("[id*=hdnCompanyid]").val();
            var Cid = $("[id*=hdnCorrectionId]").val();
            var q = $("[id*=txtQtr]").val();
            var f = $("[id*=txtFrm]").val();
            var t = $("[id*=txtTan]").val();
            var yr = $("[id*=txtFy]").val();
            var cn = $("[id*=txtCompany]").val();

            $.ajax({
                type: "POST",
                url: "../../TDS/BTStrp/handler/Correction.asmx/CreateTxt",
                data: '{cid:' + Cid + ',compid:' + compid + ', Qua:"' + q + '",frm:"' + f + '",Fy:"' + yr + '", TAN: "' + t + '"}',
                contentType: "application/json; charset=utf-8",
                success: function (msg) {
                    var myList = jQuery.parseJSON(response.d);
                    if (myList.length > 0) {
                        if (myList[0].CSuccess != '') {
                            // Show Success
                            var s = myList[0].CSuccess;
                            $("[id*=hdnSuccess]").val(s);
                            $("[id*=btnSuccess]").show();
                            $("[id*=btnError]").hide();
                            $("[id*=hdnSuccess]").val(myList[0].CSuccess);
                            $("[id*=hdnFVU]").val(myList[0].CSuccessFVU);

                        }
                        else {
                            //Show Error
                            var s = myList[0].CError;
                            $("[id*=btnError]").show(s);
                            $("[id*=btnSuccess]").hide();
                            $("[id*=hdnError]").val(myList[0].CError);
                        }
                    }
                },
                failure: function (response) {

                },
                error: function (response) {
                    Blockloaderhide();
                }
            });

        }

        function ChangeFilterMode() {

            $("#divRange").hide();
            $("#divTimer").hide();

            if ($("#range").is(":checked")) {
                // do something
                $("#divRange").show();
            }
            else {
                $("#divTimer").show();
            }
        }

        function FillCompanyDropdown() {
            debugger;
            $.ajax({
                type: "POST",
                url: "../../TDS/BTStrp/handler/LogViewer.asmx/Get_CompanyList",
                contentType: "application/json; charset=utf-8",
                success: function (response) {
                    debugger;
                    var myList = jQuery.parseJSON(response.d);
                    if (myList.length > 0) {

                        for (var i = 0; i < myList.length; i++) {
                            $("[id*=ddlCompName2]").append("<option value='" + myList[i].Company_ID + "'>" + myList[i].CompanyName + "</option>");
                        }
                    }
                },
                failure: function (response) {

                },
                error: function (response) {
                    Blockloaderhide();
                }
            });

        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <!-- Main content -->

    <asp:HiddenField runat="server" ID="hdnCompanyid" />
    <asp:HiddenField runat="server" ID="hdnCo" />
    <asp:HiddenField runat="server" ID="hdnCorrectionId" />
    <asp:HiddenField ID="hdnfrm" runat="server" />
    <asp:HiddenField ID="hdntanno" runat="server" />
    <asp:HiddenField ID="hdnGSTN" runat="server" />
    <asp:HiddenField ID="hdnToken" runat="server" />
    <asp:HiddenField ID="hdnCheckCSI" runat="server" Value="1" />
    <asp:HiddenField ID="hdnCid" runat="server" />
    <asp:HiddenField ID="hdnQua" runat="server" />
    <asp:HiddenField ID="hdnFy" runat="server" />
    <asp:HiddenField ID="hdnCn" runat="server" />
    <asp:HiddenField ID="hdnSuccess" runat="server" />
    <asp:HiddenField ID="hdnFVU" runat="server" />
    <asp:HiddenField ID="hdnError" runat="server" />
    <asp:HiddenField ID="hdnRChngs" runat="server" />

    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-0">
                <div class="col-sm-3">
                    <h5>
                        <span class="font-weight-bold">Application Logs</span></h5>
                </div>
                   <div class="col-sm-3" style="margin-left: auto;">
                        <button id="btnBack" class="btn btn-outline-primary" type="button" style=" float: right;"><i class="fa fa-arrow-left mr-1 fa-1x"></i>Back</button>

                    </div>
            </div>
        </div>
    </div>

    <!-- Page header -->
    <!-- Content area -->
    <div class="content">
        <div class="card">
            <div class="card-body" style="padding-top: 0px; padding-bottom: 0px;">
                <div class="form-group row col-lg-12" style="margin-bottom: 5px;" id="importconso">
                    <div class="col-lg-1" style="padding-top: 5px; font-weight: bold">
                        Company
                        
                    </div>
                    <div class="col-lg-3">
                        <select id="ddlCompName2" name="ddlCompName2" class="form-control select-search">
                        </select>
                    </div>
                    <div class="col-lg-3" style="padding-top: 5px; font-weight: bold; text-align: right;">
                        Filter :
                    
                        <input type="radio" id="range" name="filter" value="Range"  onclick="ChangeFilterMode()" checked="checked"/><label for="range">Range</label>
                        <input type="radio" id="timer" name="filter" value="CSS"  onclick="ChangeFilterMode()" /><label for="timer">Timer</label>
                    </div>
                    <div class="row col-lg-4" style="font-weight: bold; text-align:left;" id="divRange">
                        <div class="col-lg-6" id="divDate">
                            <input id="txtStartDate" name="txtStartDate" class="form-control form-control-border" type="date"  />
                        </div>
                        <div class="col-lg-1" style="font-weight: bold; ">
                            To
                        </div>
                        <div class="col-lg-5">
                            <input id="txtEndDate" name="txtEndDate" class="form-control form-control-border " type="date" />
                        </div>
                    </div>
                    <div class="row col-lg-4" style="display:none" id="divTimer">
                        <div class="col-lg-4" style="font-weight: bold; text-align:right">
                            Last
                        </div>
                        <div class="col-lg-4" >
                            <input id="txtTimer" name="txtTimer" class="form-control form-control-border " type="number" step="10" min="0" value="0" />
                        </div>
                        <div class="col-lg-4" style="font-weight: bold; text-align: left;">
                            Minutes
                        </div>
                    </div>
                    <div class="col-lg-1">
                        <button type="button" id="btnRefresh" class="btn btn-outline-primary">Refresh</button>
                    </div>

                 
                   
                </div>

            </div>
        </div>


        <div class="card">
            
                <table id="tblEventView" class="table-bordered table table-hover ">
                </table>
        
        </div>


    </div>


</asp:Content>

