<%@ Page Title="" Language="C#" MasterPageFile="~/TDS/BTS_MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Admin_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/css/datepicker.min.css" rel="stylesheet" />
    <script src="../BTStrp/js/bootstrap_multiselect.js" type="text/javascript"></script>
    <script src="../BTStrp/js/moment.js" type="text/javascript"></script>
    <script src="../BTStrp/js/form_select2.js" type="text/javascript"></script>
    <script src="../BTStrp/js/datatables_basic.js" type="text/javascript"></script>
    <script src="../BTStrp/js/Ajax_Pager.min.js" type="text/javascript"></script>
    <script src="../BTStrp/js/components_popups.js" type="text/javascript"></script>
    <script src="../BTStrp/js/components_modals.js" type="text/javascript"></script>
    <script src="../BTStrp/js/echarts.min.js" type="text/javascript"></script>
    <script src="../BTStrp/js/PopupAlert.js" type="text/javascript"></script>
    <script src="../BTStrp/js/Chart.js" type="text/javascript"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
    <style type="text/css">
        @keyframes runningNotification {
            0% {
                transform: translateX(100%);
            }

            50% {
                transform: translateX(0%);
            }

            100% {
                transform: translateX(-100%);
            }
        }

        .card-body2 {
            animation: runningNotification 20s linear infinite;
        }

        .clsbold {
            font-weight: bold;
        }

        .button {
            border-color: green;
        }

        .crossed-row {
            position: relative;
        }

            .crossed-row::after {
                content: "";
                position: absolute;
                top: 50%;
                left: 0;
                width: 100%;
                height: 1px;
                background: red; /* Line color for the strikethrough effect */
                transform: translateY(-50%);
                z-index: 1;
            }

        #detail_table th,
        #detail_table td {
            padding: 0.50rem;
        }
    </style>
    <script language="javascript" type="text/javascript">
        var baseUrl = '<%=ResolveUrl("../BTStrp/Handler/Dashboard.asmx/") %>';
        var companyid = 0;
        $(document).ready(function () {

            companyid = $("[id*=hdnCompanyid]").val();

            $("[id*=btnAddVou]").click(function () {
                window.location.href = 'Deductions.aspx';
            });
            $("[id*=btnAddChl]").click(function () {
                window.location.href = 'Deductions.aspx';
            });
            $("[id*=ddlForm]").val("26Q");

            $("[id*=ddlForm]").trigger('change');

            $("[id*=ddltype]").val("Q1");

            $("[id*=ddltype]").trigger('change');
            GetPageSummary();

            $("[id*=ddlForm]").change(function () {

                GetPageSummary();
            });
            $("[id*=ddltype]").change(function () {
                GetPageSummary();
            });

            $("[id*=btnViewError]").click(function () {
                DownloadFile('ERROR');
            });
            $("[id*=btnDownload27A]").click(function () {

                DownloadFile('27A');
            });
            $("[id*=btnFVU]").click(function () {
                DownloadFile('FVU');
            });
            $("[id*=btnAll]").click(function () {
                DownloadFile('ALL');
            });

            $('.close').on('click', function () {
                closeButtonClicked = true;
                $('#modal_ViewDetails1').modal('hide');
            });

            $('#btnCancel').on('click', function () {
                closeButtonClicked = true;
                $('#modal_ViewDetails1').modal('hide');
            });
            $("[id*=btnEmail]").click(function () {
                openViewDetails1();
            });


            $("[id*=btnVerify]").click(function () {
                window.location.href = "BulkPAN_Verification_AllVoucher.aspx";
            });

            $("[id*=btnTraces]").click(function () {
                var T = $("[id*=TANID]").val();
                var L = $("[id*=txtUserID]").val();
                var P = $("[id*=txtPassword]").val();


                $.ajax({
                    type: "POST",
                    url: "../BTStrp/Handler/Dashboard.asmx/SaveTraces",
                    data: '{T:"' + T + '", L:"' + L + '",P:"' + P + '"}',
                    dataType: 'json',
                    contentType: "application/json; charset=utf-8",
                    success: function (msg) {
                        var myList = jQuery.parseJSON(msg.d);
                        if (myList.length > 0) {
                            showSuccessAlert('Traces details saved successfully');
                        }

                    },
                    failure: function (response) {

                        showDangerAlert('Cant Connect to Server' + response.d);
                    },
                    error: function (response) {

                        showDangerAlert('Error Occoured ' + response.d);
                    }
                });

            });

            $("[id*=btniTax]").click(function () {
                var T = $("[id*=TANID]").val();
                var L = '';
                var P = $("[id*=txt_Password]").val();


                $.ajax({
                    type: "POST",
                    url: "../BTStrp/Handler/Dashboard.asmx/SaveITax",
                    data: '{T:"' + T + '", P:"' + P + '"}',
                    dataType: 'json',
                    contentType: "application/json; charset=utf-8",
                    success: function (msg) {
                        var myList = jQuery.parseJSON(msg.d);
                        if (myList.length > 0) {
                            showSuccessAlert('Income Tax details saved successfully');
                        }

                    },
                    failure: function (response) {

                        showDangerAlert('Cant Connect to Server' + response.d);
                    },
                    error: function (response) {

                        showDangerAlert('Error Occoured ' + response.d);
                    }
                });
            });


            $("[id*=spnRtn]").click(function () {
                var fPath = $("[id*=hdnfPath]").val();
                if (fPath != undefined) {
                    if (fPath != '') {
                        //window.location.href = fPath;
                        window.open(fPath, '_blank');

                    }
                }
            });

            $("[id*=btnBackup]").click(function () {


                var F = $("[id*=drpBkpFrm]").val();
                var Q = $("[id*=drpBkpQtr]").val();
                $("[id*=hdnFrm]").val(F);
                $("[id*=hdnQtr]").val(Q);
                //var T = $("[id*=TANID]").val();
                //var L = '';
                //var P = $("[id*=txt_Password]").val();


                //$.ajax({
                //    type: "POST",
                //    url: "../BTStrp/Handler/Dashboard.asmx/BackupDetails",
                //    data: '{F: "' + F + '", Q: "' + Q + '"}',
                //    dataType: 'json',
                //    contentType: "application/json; charset=utf-8",
                //    success: function (msg) {
                //        BackupData();

                //    },
                //    failure: function (response) {

                //        showDangerAlert('Cant Connect to Server' + response.d);
                //    },
                //    error: function (response) {

                //        showDangerAlert('Error Occoured ' + response.d);
                //    }
                //});

            });


        });

        function BackupData() {
            const endDatestr = '';
            const startDateStr = '';
            $.ajax({
                url: '../BTStrp/Handler/Dashboard.asmx//ExportBackupExcel',
                type: 'POST',
                data: '{}',
                cache: false,
                contentType: false,
                processData: false,
                success: function (response) {
                    //var xmlDoc = $.parseXML(fileName.d);
                    //var xml = $(xmlDoc);
                    //var Cid = fileName.find("Table");
                    // debugger;

                    if (response.filePath == 'No records to export') {

                        alert('No records to export');
                    }
                    else {
                        GetBackupDate();
                        window.open(response.filePath, '_blank');
                    }
                    Blockloaderhide();

                },
                failure: function (response) {

                    showDangerAlert('Cant Connect to Server' + response.d);
                },
                error: function (response) {

                    showDangerAlert('Error Occoured ' + response.d);
                }

            });

        }

        function GetBackupDate() {
            // debugger;
            $.ajax({
                type: "POST",
                url: "../BTStrp/Handler/SalaryChallanDetails.asmx/GetBackupLogDate",
                /*data: '{compid:' + compid + '}',*/
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function (msg) {
                    // debugger;
                    var result = msg.d;
                    if (result == '') {
                        $("[id*=spBackupDate]").text("Last Backup Date: " + result);
                    }
                    else {
                        $("[id*=spBackupDate]").text("Last Backup Date: " + result);
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

        function GetPageSummary() {
            var f = $("[id*=ddlForm]").val();
            if (f == "24Q") {
                $("[id*=spnType]").html("Salary");
            }
            else {
                $("[id*=spnType]").html("Vouchers");
            }

            var tobj = {
                CompanyID: companyid,
                FormType: $("[id*=ddlForm]").val(),
                Quater: $("[id*=ddltype]").val(),
                TanNo: $("[id*=txtTanNo]").val(),
            };
            tobj = JSON.stringify({ 'tobj': tobj });

            ServerServiceToGetData(tobj, baseUrl + 'GetVoucherAndChallanDetails', 'false', FillData);
        }

        function DownloadFile(fileType) {
            var tobj = {
                CompanyID: companyid,
                FormType: $("[id*=ddlForm]").val(),
                Quater: $("[id*=ddltype]").val(),
                TanNo: $("[id*=txtTanNo]").val(),
            };
            tobj = JSON.stringify({ 'tobj': tobj });

            if (fileType == 'ERROR') {
                ServerServiceToGetData(tobj, baseUrl + 'ViewErrorZIP', 'false', Download);
            }
            if (fileType == '27A') {
                ServerServiceToGetData(tobj, baseUrl + 'View27APdfZIP', 'false', Download);
            }
            if (fileType == 'FVU') {
                ServerServiceToGetData(tobj, baseUrl + 'ViewfvuZIP', 'false', Download);
            }
            if (fileType == 'ALL') {
                ServerServiceToGetData(tobj, baseUrl + 'ViewDownloadAllZIP', 'false', Download);
            }

        }
        function Download(response) {

            var Dashboard = jQuery.parseJSON(response.d);
            if (Dashboard[0].Rfile == 'File does not exist') {

                alert('File does not exist');
            }
            else {
                window.open(Dashboard[0].Rfile, '_blank');
            }
        }

        function FillData(response) {

            var tblAllEmpComputationGrid = jQuery.parseJSON(response.d);


            $("[id*=lblVouchersOrDeductions]").text(Number(tblAllEmpComputationGrid.VouchersOrDeductions).toFixed(2));
            $("[id*=lblTaxDeducted]").text(Number(tblAllEmpComputationGrid.TaxDeducted).toFixed(2));
            $("[id*=lblChallansOrTaxDeposited]").text(Number(tblAllEmpComputationGrid.ChallansOrTaxDeposited).toFixed(2));
            $("[id*=lblDifferencePending]").text(Number(tblAllEmpComputationGrid.Diffrence).toFixed(2));

            $("[id*=lblDifferencePending]").text(Number(tblAllEmpComputationGrid.Diffrence).toFixed(2));

            $("[id*=lblReturnStatus]").text(tblAllEmpComputationGrid.ReturnStatus);

            $("[id*=lblReturnStatusDate]").text(tblAllEmpComputationGrid.ReturnDateStr);
            $("[id*=lblLK]").html(tblAllEmpComputationGrid.Active);
            $("[id*=lblNL]").html(tblAllEmpComputationGrid.InActive);
            $("[id*=lblNV]").html(tblAllEmpComputationGrid.NotVerified);
            $("[id*=lblIVL]").html(tblAllEmpComputationGrid.InValid);
            $("[id*=TANID]").val(tblAllEmpComputationGrid.LTAN);
            $("[id*=txtUserID]").val(tblAllEmpComputationGrid.TUser);
            $("[id*=txtPassword]").val(tblAllEmpComputationGrid.TPass);
            $("[id*=TAN_ID]").val(tblAllEmpComputationGrid.LTAN);
            $("[id*=txt_Password]").val(tblAllEmpComputationGrid.IPass);
            $("[id*=hdnfPath]").val(tblAllEmpComputationGrid.fPath);
            if (tblAllEmpComputationGrid.fPath == '') {
                $("[id*=hdrval]").html('Pending');
                $("[id*=hdrdt]").html('');
            }
            else if (tblAllEmpComputationGrid.fPath == null) {
                $("[id*=hdrval]").html('Pending');
                $("[id*=hdrdt]").html('');
            }
            else {
                var dt = moment(tblAllEmpComputationGrid.ReturnDate).format('MM/DD/YYYY');
                $("[id*=hdrval]").html(tblAllEmpComputationGrid.ReturnStatus);
                $("[id*=hdrdt]").html(dt);
            }
            CalculateDates();
            //-------------
            //- BAR CHART -
            //-------------

            var areaChartData = {
                labels: [$("[id*=ddltype]").val()],//, 'Q2', 'Q3', 'Q4'
                datasets: [
                    {
                        label: 'Tax Deducted',
                        backgroundColor: 'rgba(60,141,188,0.9)',
                        borderColor: 'rgba(60,141,188,0.8)',
                        pointRadius: false,
                        pointColor: '#3b8bba',
                        pointStrokeColor: 'rgba(60,141,188,1)',
                        pointHighlightFill: '#fff',
                        pointHighlightStroke: 'rgba(60,141,188,1)',
                        data: [tblAllEmpComputationGrid.TaxDeducted]
                    },
                    {
                        label: 'Challans / Tax Deposited',
                        backgroundColor: 'rgba(243, 156, 18,1)',
                        borderColor: 'rgba(243, 156, 18, 1)',
                        pointRadius: false,
                        pointColor: 'rgba(243, 156, 18, 1)',
                        pointStrokeColor: '#c1c7d1',
                        pointHighlightFill: '#fff',
                        pointHighlightStroke: 'rgba(243, 156, 18,1)',
                        data: [tblAllEmpComputationGrid.ChallansOrTaxDeposited]
                    },
                ]
            }

            var barChartCanvas = $('#barChart').get(0).getContext('2d')
            var barChartData = $.extend(true, {}, areaChartData)
            var temp0 = areaChartData.datasets[0]
            var temp1 = areaChartData.datasets[1]
            barChartData.datasets[0] = temp1
            barChartData.datasets[1] = temp0

            var barChartOptions = {
                responsive: true,
                maintainAspectRatio: false,
                datasetFill: false
            }

            new Chart(barChartCanvas, {
                type: 'bar',
                data: barChartData,
                options: barChartOptions
            })

        }

        function CalculateDates() {

            var i = 1;

            $("span[name=sp26Date]").each(function () {


                let sDueDate = $('#sp26QQ' + i + 'DueDt').text();
                let sRevisedDt = $('#sp26QQ' + i + 'RevisedDt').text();
                let DayPending = $('#sp26QQ' + i + 'DayPending').text();

                let DueDate = '';
                if (sRevisedDt == '-') {
                    DueDate = sDueDate;
                }
                else {
                    DueDate = sRevisedDt;
                }
                const today = moment();

                const dateA = moment(DueDate, 'DD/MM/YYYY');

                let diff = dateA.diff(today, 'days');

                if (diff > 0) {

                    $('#sp26QQ' + i + 'DayPending').text(diff);
                }
                else {
                    $('#sp26QQ' + i + 'DayPending').text('0');
                    $(this).closest('tr').addClass('crossed-row');
                }
                i = i + 1;

            });
        }

        function openViewDetails1() {
            console.log("button clicked");
            $('#modal_ViewDetails1').modal('show');
        }

        function ServerServiceToGetData(data, url, torf, successFun) {

            // debugger;


            $.ajax({
                url: url,
                data: data,
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: successFun,
                error: function (response) {
                    alert(response.responseText);
                },
                failure: function (response) {
                    alert(response.responseText);
                }
            });
            $("[id*=btnupdate]").click(function () {

                //var dt = $("[id*=hdnDate]").val();
                //$("[id*=txtChinDate]").val(dt);
                $('[id*=hdnchlid]').val(0);
                $('#modal_Addupdate').modal('show');
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
                url: "../BTStrp/Handler/Dashboard.asmx/GetReturns_details",
                data: '{compid:' + compid + ',Q:"' + Q + '", F:"' + F + '", TanNo:"' + t + '", Conn:"' + Conn + '"}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    if (myList.length > 0) {
                        if (F == '24Q') {
                            if (myList[0].ST != '') {
                                $("[id*=lblsrtn]").html(myList[0].ST);
                                $("[id*=lblsSts]").html(myList[0].Rstatus);
                            }
                        }
                        else {
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


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:HiddenField ID="hdnFrm" runat="server" />
    <asp:HiddenField ID="hdnQtr" runat="server" />

    <div class="row" style="height: 10px;"></div>
    <%--<div class="col-12">--%>
    <div class="content-header">
        <div class="content">
            <div class="card" style="height: 50px;">
                <%--<div class="card-body">--%>
                <div class="row mb-2" id="dvform" style="margin-left: 20px; font-size: 18px; align-items: center;">
                    <div class="col-sm-2" style="font-size: larger;">
                        <select id="ddlForm" class="form-control  form-control-border select select2-hidden-accessible">
                            <option value="26Q">26Q</option>
                            <option value="27Q">27Q(NRI)</option>
                            <option value="27EQ">27EQ(TCS)</option>
                            <option value="24Q">24Q</option>
                        </select>
                    </div>

                    <div class="col-sm-0.5" style="font-size: larger;">
                        <select id="ddltype" class="form-control form-control-border select select2-hidden-accessible col-lg-2">
                            <option value="Q1">Q1</option>
                            <option value="Q2">Q2</option>
                            <option value="Q3">Q3</option>
                            <option value="Q4">Q4</option>
                        </select>
                    </div>
                    <%-- <div style="margin-left: auto;">
                                    <button class="button btn" type="button"><a href="#" target="_blank"><i class="far fa-eye mr-1 fa-1x"></i>View Slab</a></button>
                                    <button class="button btn" type="button"><a href="https://eportal.incometax.gov.in/iec/foservices/#/download-csi-file/tan-user-details" target="_blank"><i class="icon-folder-download3 mr-1 icon-1x"></i>Download CSI</a></button>
                                </div>--%>

                    <div class="input-group-prepend" style="margin-left: 750px;">
                        <button type="button" class="btn btn-block bg-gradient-info dropdown-toggle" data-toggle="dropdown" fdprocessedid="e0r455" title="More Options" style="width: 140px;">
                            More
                        </button>
                        <div class="dropdown-menu dropdown-menu-right">
                            <a href="#" id="btnAddVou" class="dropdown-item"><i class="fas fa-plus mr-2 fa-1x "></i>Voucher/Deduction</a>
                            <a href="#" id="btnAddChl" class="dropdown-item"><i class="fas fa-plus mr-2 fa-1x "></i>Challan</a>
                            <a href="#" id="btnProcess" class="dropdown-item"><i class="icon-cog5 mr-2"></i>Porcess Return</a>
                            <a href="https://eportal.incometax.gov.in/iec/foservices/#/download-csi-file/tan-user-details" class="dropdown-item"><i class="icon-folder-download3 mr-1 icon-1x"></i>Download CSI</a>
                        </div>
                    </div>

                </div>
                <%--</div>--%>
            </div>
        </div>

    </div>

    <div class="content-header">
        <div class="content">
            <div class="row">
                <div class="col-md-7">
                    <div class="card card-outline card-warning">
                        <div class="card-header">
                            <h3 class="card-title">TDS Summary</h3>
                        </div>
                        <div class="card-body ">
                            <div class="row">
                                <div class="col-sm-3 col-6">
                                    <div class="description-block border-right">
                                        <h5 class="description-header" id="lblVouchersOrDeductions" style="color: green;"></h5>
                                        <span id="spnType" class="text">Vouchers</span>
                                    </div>
                                    <!-- /.description-block -->
                                </div>
                                <!-- /.col -->
                                <div class="col-sm-3 col-6">
                                    <div class="description-block border-right1">
                                        <h5 class="description-header" id="lblTaxDeducted" style="color: red;"></h5>
                                        <span class="text">TDS Deducted</span>
                                    </div>
                                    <!-- /.description-block -->
                                </div>
                                <!-- /.col -->

                                <!-- /.col -->
                                <div class="col-sm-3 col-6">
                                    <div class="description-block">
                                        <h5 class="description-header" id="lblChallansOrTaxDeposited" style="color: #007bff;"></h5>
                                        <span class="text">Challans / Tax Deposited</span>
                                    </div>
                                    <!-- /.description-block -->
                                </div>
                                <div class="col-sm-3 col-6">
                                    <div class="description-block">

                                        <h5 class="description-header" id="lblDifferencePending" style="color: orange;"></h5>
                                        <span class="text">Unconsumed Challan</span>
                                    </div>
                                    <!-- /.description-block -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-5">
                    <div class="card card-outline card-success">
                        <div class="card-header">
                            <h3 class="card-title">Return Summary</h3>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-4 col-6">
                                    <div class="description-block border-right">
                                        <h5 id="hdrval" class="description-header" style="color: green;"></h5>
                                        <span class="text" id="">Return Status</span>
                                    </div>
                                    <!-- /.description-block -->
                                </div>
                                <!-- /.col -->
                                <div class="col-sm-4 col-6">
                                    <div class="description-block border-right">
                                        <h5 id="hdrdt" class="description-header"></h5>
                                        <span class="text" id="spnRtn">FVU Date<img src="../../TDS/BTStrp/image/FVU.jpeg" alt="Download FVU" title="Download FVU File" /></span>
                                        <asp:HiddenField ID="hdnfPath" runat="server" />
                                    </div>
                                    <!-- /.description-block -->
                                </div>
                                <div class="col-sm-4 col-6">
                                    <div class="description-block ">
                                        <h5 id="" class="description-header" style="color: green;"></h5>
                                        <button id="btnupdate" type="button" class="btn btn-block bg-gradient-warning"><i class="fa-solid fa-rotate-right mr-2 fa-1x"></i>Update Token No.</button>
                                    </div>
                                    <!-- /.description-block -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="content-header">
        <div class="content">
            <div class="row">
                <div class="col-md-4">
                    <div class="card card-outline card-success">
                        <div class="card-body">
                            <div class="chart-container">
                                <div class="chart">
                                    <canvas id="barChart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block; width: 572px;" width="715" height="312" class="chartjs-render-monitor"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card card-outline card-danger">
                        <div class="card-body">
                            <table class="table-bordered table table-hover table-sm" style="margin-top: 23px;">
                                <thead>
                                    <tr>
                                        <th class="text-center ">Description</th>
                                        <th class="text-center">PAN Count</th>
                                    </tr>
                                </thead>
                                <tbody class="text-center ">
                                    <tr>
                                        <td>Valid & Operative Pan</td>
                                        <td><span id="lblLK" style="font-size: 17px; font-weight: bold; color: green;">0</span></td>

                                    </tr>
                                    <tr>
                                        <td>Valid & Inoperative</td>
                                        <td><span id="lblNL" style="font-size: 17px; font-weight: bold; color: red; cursor: grab;" onclick="getPANList(&quot;Invalid&quot;)">0</span></td>

                                    </tr>
                                    <tr>
                                        <td>InValid</td>
                                        <td><span id="lblIVL" style="font-size: 17px; font-weight: bold; color: crimson;" onclick="BRedirect($(this).val())">0</span></td>

                                    </tr>
                                    <tr>
                                        <td>Not Verified</td>
                                        <td><span id="lblNV" style="font-size: 17px; font-weight: bold; color: orange;" onclick="BRedirect($(this).val())">0</span> </td>

                                    </tr>

                                    <tr>
                                        <td colspan="2">
                                            <input id="btnVerify" class="btn btn-block bg-gradient-info" type="button" style="width: 105px; margin-left: 136px;" value="Verify Now" />
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class=" col-md-4">
                    <div class="card card-outline card-info">
                        <div class="card-body">
                            <h5 class="card-title" style="font-size: 18px; padding-bottom: 12px;">Return Filling Due Date</h5>
                            <table id="detail_table" class=" table-bordered table table-hover table-sm">
                                <thead>
                                    <tr>
                                        <th class="text-center ">Qtr</th>
                                        <th class="text-center">Due Dt</th>
                                        <th class="text-center">Revised Dt</th>
                                        <th class="text-center">Days Pend.</th>
                                    </tr>
                                </thead>
                                <tbody class="text-center ">
                                    <tr>
                                        <td><span name="sp26Date">Q1</span></td>
                                        <td><span id="sp26QQ1DueDt">31/07/2024</span></td>
                                        <td><span id="sp26QQ1RevisedDt">-</span></td>
                                        <td><span id="sp26QQ1DayPending">-</span></td>
                                    </tr>
                                    <tr>
                                        <td><span name="sp26Date">Q2</span></td>
                                        <td><span id="sp26QQ2DueDt">31/10/2024</span></td>
                                        <td><span id="sp26QQ2RevisedDt">-</span></td>
                                        <td><span id="sp26QQ2DayPending">-</span></td>
                                    </tr>
                                    <tr>
                                        <td><span name="sp26Date">Q3</span></td>
                                        <td><span id="sp26QQ3DueDt">31/01/2025</span></td>
                                        <td><span id="sp26QQ3RevisedDt">-</span></td>
                                        <td><span id="sp26QQ3DayPending">-</span></td>
                                    </tr>
                                    <tr>
                                        <td><span name="sp26Date">Q4</span></td>
                                        <td><span id="sp26QQ4DueDt">31/05/2025</span> </td>
                                        <td><span id="sp26QQ4RevisedDt">-</span></td>
                                        <td><span id="sp26QQ4DayPending">-</span></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="content-header">
        <div class="content">
            <div class="card card-primary card-outline card-outline-tabs">
                <div class="card-header p-0 border-bottom-0">
                    <ul class="nav nav-tabs" id="custom-tabs-four-tab" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="custom-tabs-four-home-tab" data-toggle="pill" href="#custom-tabs-four-home" role="tab" aria-controls="custom-tabs-four-home" style="font-size: 20px;" aria-selected="true">Backup&nbsp;&nbsp;</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="custom-tabs-four-profile-tab" data-toggle="pill" href="#custom-tabs-four-profile" role="tab" aria-controls="custom-tabs-four-profile" style="font-size: 20px;" aria-selected="false">Traces Login</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="custom-tabs-four-messages-tab" data-toggle="pill" href="#custom-tabs-four-messages" role="tab" aria-controls="custom-tabs-four-messages" style="font-size: 20px;" aria-selected="false">Income Tax Login</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="custom-tabs-four-settings-tab" data-toggle="pill" href="#custom-tabs-four-settings" role="tab" aria-controls="custom-tabs-four-settings" style="font-size: 20px;" aria-selected="false">Support</a>
                        </li>
                    </ul>
                </div>
                <div class="card-body">
                    <div class="tab-content" id="custom-tabs-four-tabContent">
                        <div class="tab-pane fade show active" id="custom-tabs-four-home" role="tabpanel" aria-labelledby="custom-tabs-four-home-tab">

                            <div class="col-md-6">

                                <div class="card-header">
                                    <h3 class="card-title">Backup To XL</h3>
                                </div>
                                <div class="card-body">
                                    <div class="row " id="">
                                        <div class="form-group">
                                            <div style="font-size: larger;">
                                                <label>Form Type:</label>
                                                <select id="drpBkpFrm" class="form-control select select2-hidden-accessible">
                                                    <option value="26Q">26Q</option>
                                                    <option value="27Q">27Q(NRI)</option>
                                                    <option value="27EQ">27EQ(TCS)</option>
                                                    <option value="24Q">24Q</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <div style="font-size: larger;">
                                                    <label>Quarter:</label>
                                                    <select id="drpBkpQtr" class="form-control select select2-hidden-accessible col-lg-2">
                                                        <option value="Q1">Q1</option>
                                                        <option value="Q2">Q2</option>
                                                        <option value="Q3">Q3</option>
                                                        <option value="Q4">Q4</option>
                                                    </select>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <asp:Button ID="btnBackup" runat="server" class="btn btn-block bg-gradient-info" type="button" Style="margin-left: 136px; margin-top: 38px;" Text="Backup Now" OnClick="btnBackup_Click" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="custom-tabs-four-profile" role="tabpanel" aria-labelledby="custom-tabs-four-profile-tab">
                            <div class="card">
                                <div class="col-md-7" style="margin-left: 325px;">
                                    <div class="login-card-body card-info">
                                        <img src="../../TDS/BTStrp/image/tds-logo.png" alt="Logo" />
                                        <div class="card-header">
                                            <h3 class="card-title">Traces Details</h3>
                                        </div>
                                    </div>
                                </div>



                                <div class="col-md-5" style="margin-left: 426px;">
                                    <div class=" card card-body">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">TAN:</label>
                                            <div class="col-6">
                                                <input type="text" class="form-control form-control-border" id="TANID" placeholder="Enter UserId" />
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">User ID:<span class="text-danger">*</span></label>
                                            <div class="col-6">
                                                <input type="text" class="form-control form-control-border" id="txtUserID" placeholder="Enter UserId" />
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Password<span class="text-danger">*</span></label>
                                            <div class="col-6">
                                                <input type="password" class="form-control form-control-border" id="txtPassword" placeholder="Enter Password" />
                                            </div>
                                        </div>
                                        <div class="card-footer">
                                            <input type="button" id="btnTraces" class="btn btn-outline-success legitRipple" value="Save" />
                                            <button class="btn btn-outline-success legitRipple">Cancel</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane fade" id="custom-tabs-four-messages" role="tabpanel" aria-labelledby="custom-tabs-four-messages-tab">
                            <div class="card">
                                <div class="col-md-7" style="margin-left: 325px;">
                                    <div class="login-card-body card-info">
                                        <img src="../../TDS/BTStrp/image/efiling_logo.svg" alt="Logo" />
                                        <div class="card-header" style="margin-top: 10px">
                                            <h3 class="card-title">Income Tax Login</h3>
                                        </div>
                                    </div>
                                </div>



                                <div class="col-md-5" style="margin-left: 426px;">
                                    <div class=" card card-body">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">TAN:</label>
                                            <div class="col-6">
                                                <input type="text" class=" form-control form-control-border" id="TAN_ID" placeholder="Enter UserId" />
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Password<span class="text-danger">*</span></label>
                                            <div class="col-6">
                                                <input type="password" class=" form-control form-control-border" id="txt_Password" placeholder="Enter Password" />
                                            </div>
                                        </div>
                                        <div class="card-footer">
                                            <input type="button" id="btniTax" class="btn btn-outline-success legitRipple" value="Save" />
                                            <button class="btn btn-outline-success legitRipple">Cancel</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="custom-tabs-four-settings" role="tabpanel" aria-labelledby="custom-tabs-four-settings-tab">
                            <div class="card">
                                <div class="card-header header-elements-inline">
                                    <h6 class="font-weight-bold"><i class="icon-reading mr-2"></i>Support</h6>
                                </div>
                                <div class="card-body">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <label class=" col-form-label col-12">Support Contact No.:</label>
                                                </td>
                                                <td>
                                                    <label class="text">9892606006, 9372893410, 9004466888, 9819458606</label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label class=" col-form-label col-12">Email:</label>
                                                </td>
                                                <td>
                                                    <label class="text">info@saibex.co.in</label>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div id="modal_ViewDetails1" class="modal fade" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-primary-1">
                        <h5 class="modal-title" id="lblpopup" name="lblpopup">Email Computation </h5>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>


                    <div class="modal-body">

                        <div class="form-group row">

                            <label class="col-lg-4 col-form-label font-weight-bold">From</label>
                            <div class="col-lg-11">
                                <input type="text" id="txtFrom" name="txtFrom" class="form-control form-control-border" placeholder="Enter Email" />
                            </div>
                        </div>

                        <div class="form-group row">

                            <label class="col-lg-4 col-form-label font-weight-bold">To</label>
                            <div class="col-lg-11">
                                <input type="text" id="txtTo" name="txtTo" class="form-control form-control-border" />
                            </div>
                        </div>

                        <div class="form-group row">

                            <label class="col-lg-4 col-form-label font-weight-bold">Email Subject</label>
                            <div class="col-lg-11">
                                <input type="text" id="txtSubject" name="txtSubject" class="form-control form-control-border" />
                            </div>
                        </div>

                        <div class="form-group">

                            <label class="col-lg-6 col-form-label font-weight-bold">Message</label>
                            <div class="col-lg-11">
                                <textarea rows="5" cols="5" id="txtMessage" name="txtMessage" class="form-control"></textarea>
                            </div>
                        </div>



                        <div style="padding-left: 273px;">
                            <button id="btnCancel" name="btnCancel" class=" btn btn-outline-primary legitRipple" type="button">Cancel</button>
                            <button id="btnSendMail" name="btnSendMail" class="btn btn-outline-primary legitRipple" type="button">Send Email</button>

                        </div>



                    </div>



                </div>
            </div>
        </div>
    </div>

    <div id="modal_Addupdate" class="modal fade" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary-1">
                    <h5 class="modal-title" id="lblpopup" name="lblpopup">Save filing details</h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>

                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="col-xs-4">
                                <label id="lblURN_CompanyName" data-toggle="tooltip" class="text-overflow" data-original-title="BALAJI GLOBAL MULTITRADE INDIA LIMTED (MUMB33963G)" title="">BALAJI GLOBAL MULTITRADE INDIA LIMTED (MUMB33963G)</label>


                            </div>

                            <input type="hidden" name="ctl00$ContentPlaceHolder1$HiddenField2" id="ctl00_ContentPlaceHolder1_HiddenField2" value="0">
                        </div>
                        <div class="form-group row">

                            <label class="col-lg-3 col-form-label font-weight-bold">Client:<span class="text-danger">*</span></label>
                            <div class="col-lg-6">
                                <input type="text" id="txtClient" name="txtClient" class="form-control form-control-border" placeholder="Name" fdprocessedid="fu58d">
                            </div>

                            <input type="hidden" name="ctl00$ContentPlaceHolder1$hdncode" id="ctl00_ContentPlaceHolder1_hdncode" value="0">
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group row">
                                    <label class="col-lg-5 col-form-label font-weight-bold">Country:</label>
                                    <div class="col-lg-7">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <input type="text" id="txtcntry" name="txtcntry" class="form-control form-control-border" placeholder="" fdprocessedid="4ydll6">
                                            </div>

                                        </div>
                                    </div>

                                </div>
                                <div class="form-group row">
                                    <label class="col-lg-5 col-form-label font-weight-bold">Contact Person:</label>
                                    <div class="col-lg-7">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <input type="text" id="txtCntName" name="txtCntName" class="form-control form-control-border" placeholder="" fdprocessedid="1b3mdc">
                                            </div>

                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group row">
                                    <label class="col-lg-3 col-form-label font-weight-bold">Email:</label>
                                    <div class="col-lg-7">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <input type="text" id="txtemail" name="txtemail" class="form-control form-control-border" placeholder="" fdprocessedid="md2poe">
                                            </div>

                                        </div>
                                    </div>

                                </div>
                                <div class="form-group row">
                                    <label class="col-lg-3 col-form-label font-weight-bold">Mob:</label>
                                    <div class="col-lg-7">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <input type="text" id="txtmob" name="txtmob" onkeypress="return isNumber(event)" maxlength="13" class="form-control form-control-border" placeholder="" fdprocessedid="3psmul">
                                            </div>

                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>

                        <div class="form-group row">

                            <label class="col-lg-3 font-weight-bold col-form-label">Client Group:</label>
                            <div class="col-lg-6">
                                <select id="ddlCG" name="ddlCG" class="form-control select select2-hidden-accessible" data-select2-id="ddlCG" tabindex="-1" aria-hidden="true">
                                    <option value="0" data-select2-id="5">--Select--</option>
                                </select><span class="select2 select2-container select2-container--default" dir="ltr" data-select2-id="3" style="width: 100%;"><span class="selection"><span class="select2-selection select2-selection--single" role="combobox" aria-haspopup="true" aria-expanded="false" tabindex="0" aria-disabled="false" aria-labelledby="select2-ddlCG-container"><span class="select2-selection__rendered" id="select2-ddlCG-container" role="textbox" aria-readonly="true" title="--Select--">--Select--</span><span class="select2-selection__arrow" role="presentation"><b role="presentation"></b></span></span></span><span class="dropdown-wrapper" aria-hidden="true"></span></span>

                            </div>

                            <input type="hidden" name="ctl00$ContentPlaceHolder1$HiddenField1" id="ctl00_ContentPlaceHolder1_HiddenField1" value="0">
                        </div>
                        <div class="form-group row">

                            <label class="col-lg-3 font-weight-bold col-form-label">Client Remark:</label>
                            <div class="col-lg-8">
                                <textarea id="txtRemark" name="txtRemark" rows="5" cols="5" class="form-control form-control-border" placeholder="Enter your Remark here"></textarea>

                            </div>


                        </div>

                    </div>
                    <div class="modal-footer">
                        <input id="btnURN_Update" type="button" value="Save" class="btn btn-primary btn-width-md">
                        <img id="imgURN_Loading" alt="Loading..." title="Loading..." src="images/ajax-loader-retrun.gif" style="display: none;">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

