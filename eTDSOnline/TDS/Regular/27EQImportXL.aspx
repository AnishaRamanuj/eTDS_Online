<%@ Page Title="" Language="C#" MasterPageFile="~/TDS/BTS_MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="27EQImportXL.aspx.cs" Inherits="Import27EQXL" %>



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
        .tblChallan
        {
            table-layout: fixed;
            width: 100%;            
        }
        #thErrorMsg {
            min-width: 250px;    
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            //App.initBeforeLoad();
            //App.initCore();
            //App.initAfterLoad();
            var compid = $("[id*=hdnCompanyid]").val();
            $("[id*=gridcard]").show();
            $("[id*=btnTxt]").hide();
            $("[id*=dv_grd]").show();
            $("[id*=compdetail]").hide();
            $("[id*=actionform]").hide();
            $("[id*=importsumm]").hide();
           // debugger;
            Get_TAN(compid);
            GetBackupDate();
            $("[id*=btnBack]").click(function () {
                window.location.href = 'Dashboard.aspx';
            });
            $("#file").change(function () {

                var validExtensions = ["xlsx", "xls"]
                var file = $(this).val().toLowerCase().split('.').pop();
                if (validExtensions.indexOf(file) == -1) {
                    $("#file").val(null);
                    alert("Only formats are allowed : " + validExtensions.join(', '));
                }

            });


            $("[id*=ddlForm]").change(function () {

                var F = $("[id*=ddlForm]").val();
                if (F == '26Q') {
                    window.location.href = '26QImportXL.aspx';
                }
                if (F == '27Q') {
                    window.location.href = '27QImportXL.aspx';
                }
                if (F == '27EQ(TCS)') {
                    window.location.href = '27EQImportXL.aspx';
                }

            });

            $("[id*=btnUpload]").click(function () {

                if ($("#file")[0].files.length == 0) {
                    alert("Please choose file to upload");
                    return;
                }
                Blockloadershow();

                var formData = new FormData();
                formData.append("fileName", $("#fileName").val());
                formData.append("file", $("#file")[0].files[0]);

                $.ajax({
                    url: '../Handler/Import27EQXLHandler.ashx/ProcessRequest',
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        //var xmlDoc = $.parseXML(fileName.d);
                        //var xml = $(xmlDoc);
                        //var Cid = fileName.find("Table");
                       // debugger;
                        $("#file").val('');
                        if (data.isPass) {
                            alert(data.errorMessage);
                        }
                        else {
                            if (data.filePath) {
                                alert('Excel file having some error records . please downloaded excel file for error info');
                                window.open(data.filePath, '_blank');
                            }
                            else {
                                alert(data.errorMessage);
                            }
                        }
                        Blockloaderhide();
                        //  BindData(data);
                        $("#fileProgress").hide();
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

            });

            $("[id*=btnDownloadBackup]").click(function () {


                Blockloadershow();

                //  var formData = new FormData();
                const endDatestr = '';
                const startDateStr = '';
               // debugger;
                $.ajax({
                    url: '../Handler/SalaryChallanDetails.asmx/ExportBackupExcel',
                    type: 'POST',
                    data: '{startDateStr:' + startDateStr + ', endDatestr:' + endDatestr + '}',
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (response) {
                        //var xmlDoc = $.parseXML(fileName.d);
                        //var xml = $(xmlDoc);
                        //var Cid = fileName.find("Table");
                      //  debugger;

                        if (response.filePath == 'No records to export') {

                            alert('No records to export');
                        }
                        else {
                            GetBackupDate();
                            window.open(response.filePath, '_blank');
                        }
                        Blockloaderhide();
                        //  BindData(data);
                        //  $("#fileProgress").hide();
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

            });

            $("[id*=btnCancel]").click(function () {
                $("[id*=gridcard]").show();

                $("[id*=importconso]").show();
                $("[id*=compdetail]").hide();
                $("[id*=actionform]").hide();
                $("[id*=importsumm]").hide();
            });

            $("[id*=btnSuccess]").click(function () {
                var s = $("[id*=hdnSuccess]").val();
                window.location.href = s;
            });

            $("[id*=btnErrorLogDownload]").click(function () {
                $("[id*=btnExcel]").click();

            });





            $("[id*=btnError]").click(function () {
                var s = $("[id*=hdnError]").val();
                window.location.href = s;
            });



        });

        function Get_TAN(temp) {

            var compid = temp;

            $.ajax({
                type: "POST",
                url: "../../TDS/BTStrp/Handler/Ws_PanNo.asmx/GetPanNo",
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
                            if (myList[0].Gstn == '') {
                                alert('Update Gstn no in company details' + response.d);
                            }

                        }
                        $("[id*=hdntanno]").val(tan);


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

        function GetBackupDate() {
           // debugger;
            $.ajax({
                type: "POST",
                url: "../../TDS/BTStrp/Handler/SalaryChallanDetails.asmx/GetBackupLogDate",
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

        function ExcelUpdate() {
            //   $("#btnUpdate").css("display", "none");

            var voucherList = [];
            var challanList = [];
            var i;
           // debugger;

            $("#tblChallan tbody tr").each(function (index, tr) {

                let i = index + 1;
                //  data[i] = Array();

                if ($(this).find("#Date_on_Tax_Depo_" + i).length > 0) {
                    var s = $(this).find("#Date_on_Tax_Depo_" + i).val();
                    if (s.length > 0) {
                        s = s.split('/');
                        s = s[2] + '-' + s[1] + '-' + s[0];
                    }
                    data = {
                        Id: $(this).find("#ID_" + i).val(),
                        Challan_Number: $(this).find("#Challan_Number_" + i).val(),
                        PAN_of_Deductee: $(this).find("#PAN_of_Deductee_" + i).val(),
                        Date_on_Tax_Depo: s,
                        //Section_Code: $(this).find("#Section_Code_" + i).val(),
                        BSRCodeOrReceiptNumber: $(this).find("#BSRCodeOrReceiptNumber_" + i).val(),

                        Payment_CreditDate: s,
                        TDS: $(this).find("#TDS_" + i).val(),
                        Surcharge: $(this).find("#Surcharge_" + i).val(),
                        education_Cess: $(this).find("#education_Cess_" + i).val(),
                        Intrest: $(this).find("#Intrest_" + i).val(),
                        Fee: $(this).find("#Fee_" + i).val(),
                        Others: $(this).find("#Others_" + i).val(),
                        TotalTaxDepo: $(this).find("#TotalTaxDepo_" + i).val(),
                        quarter: $(this).find("#quarter_" + i).val(),
                        FormType: '26Q'
                    };


                    challanList.push(data);
                }

            });

            $("#tblVoucher tbody tr").each(function (index, tr) {

                //  data[i] = Array();

                let i = index + 1;
                //  data[i] = Array();
                if ($(this).find("#Payment_CreditDate_" + i).length > 0) {
                    var s = $(this).find("#Payment_CreditDate_" + i).val();
                    if (s.length > 0) {
                        s = s.split('/');
                        s = s[2] + '-' + s[1] + '-' + s[0];
                    }

                    data = {
                        Id: $(this).find("#ID_" + i).val(),
                        Deductee_Code: $(this).find("#Deductee_Code_" + i).val(),
                        Challan_Number: $(this).find("#Challan_Number_" + i).val(),
                        PAN_of_Deductee: $(this).find("#PAN_of_Deductee_" + i).val(),
                        Name_Of_Deductee: $(this).find("#Name_Of_Deductee_" + i).val(),
                        Section_Description: $(this).find("#Section_Description_" + i).val(),
                        Payment_CreditDate: s,
                        Amount_Paid_Credited: $(this).find("#Amount_Paid_Credited_" + i).val(),
                        TDS: $(this).find("#TDS_" + i).val(),
                        Surcharge: $(this).find("#Surcharge_" + i).val(),
                        Education_Cess: $(this).find("#Education_Cess_" + i).val(),
                        Total_Tax_Deducted: $(this).find("#Total_Tax_Deducted_" + i).val(),
                        Reason_for_Non_deduction_Lower_Deduction: $(this).find("#Reason_for_Non_deduction_Lower_Deduction_" + i).val(),
                        Certificate_number_for_Lower_NonDeduction: $(this).find("#Certificate_number_for_Lower_NonDeduction_" + i).val(),
                        Amount_Paid_Credited: $(this).find("#Amount_Paid_Credited_" + i).val(),
                        Rate_at_which_deducted: $(this).find("#Rate_at_which_deducted_" + i).val()
                    };
                    voucherList.push(data);
                }

            });


            const InputData = {
                voucherList: voucherList,
                challanList: challanList
            };
            console.log(InputData);
            //debugger;
            $.ajax({
                type: "POST",
                url: "26QImportXL.aspx/UpdateRecords",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{inputData:" + JSON.stringify(InputData) + "}",
                success: function (data) {
                    //'Error converting data type varchar to numeric.';
                    var msg = data.d;
                    if (msg == 'Error converting data type varchar to numeric.') {
                        msg = 'Update 0 values in numeric columns'
                        ShowErrorWindow(msg);
                    }
                    else {
                        BindData(JSON.parse(data.d));
                    }
                },
                failure: function (response) {

                    $(".MastermodalBackground2").hide();
                    ShowErrorWindow(response.d);
                }
            });

        }

        function BindData(ds) {
          //  debugger;

            $("[id*=spChSuccess]").text("0");
            $("[id*=spChFail]").text("0");
            $("[id*=spVFail]").text("0");
            $("[id*=spVSuccess]").text("0");
            if (ds.Challan == undefined) {
                ShowErrorWindow(ds);
                return false;
            }
            dt = ds.Challan;

            if (ds.Challan_Count != undefined && ds.Challan_Count.length > 0) {
                $("[id*=spChSuccess]").text(ds.Challan_Count[0].Success);
                $("[id*=spChFail]").text(ds.Challan_Count[0].error);
            }
            if (ds.Voucher_Count != undefined && ds.Voucher_Count.length > 0) {
                $("[id*=spVSuccess]").text(ds.Voucher_Count[0].Success);
                $("[id*=spVFail]").text(ds.Voucher_Count[0].error);

            }
            $("[id*=importsumm]").show();

            var RecordCount = 0;
            var tbl = '';
            $("[id*=tblChallan] tbody").empty();
            $("[id*=tblChallan] thead").empty();
            tbl = tbl + "<thead style='background-color:#F2F2F2;'><tr>";
            tbl = tbl + "<th  style='text-align: center;font-weight: bold;'>Sr</th>";
            //tbl = tbl + "<th  style='font-weight: bold;'>Company</th>";
            tbl = tbl + "<th style='font-weight: bold;text-align: center;' id='thErrorMsg'>Error Msg.</th>";
            tbl = tbl + "<th  style='font-weight: bold;text-align: center;'>Challan No</th>";
            tbl = tbl + "<th  style='font-weight: bold;text-align: center;'>Tax Depo.</th>";
            tbl = tbl + "<th  style='font-weight: bold;text-align: center;'>BSR Code</th>";
            tbl = tbl + "<th  style='font-weight: bold;text-align: center;'>TDS</th>";
            tbl = tbl + "<th  style='font-weight: bold;text-align: center;'>Surcharge</th>";
            tbl = tbl + "<th  style='font-weight: bold;text-align: center;'>Edu. Cess</th>";
            tbl = tbl + "<th  style='font-weight: bold;text-align: center;'>Interest</th>";
            tbl = tbl + "<th  style='font-weight: bold;text-align: center;'>Fee</th>";
            tbl = tbl + "<th  style='font-weight: bold;text-align: center;'>Others</th>";
            tbl = tbl + "<th  style='font-weight: bold;text-align: center;'>Total Tax Depo.</th>";
            tbl = tbl + "<th  style='font-weight: bold;text-align: center;'>Quarter</th>";

            tbl = tbl + "</tr></thead>";

            if (ds.Challan.length > 0) {

                let counter = 1;
                for (var i = 0; i < ds.Challan.length; i++) {

                    if (i == 0) {
                        FDate = ds.Challan[i].FDate;
                        TDate = ds.Challan[i].TDate;
                    }

                    let errorNumber = ds.Challan[i].ErrorMessage;

                    tbl = tbl + "<tr>";
                    tbl = tbl + "<td style='text-align: center;'>" + counter + "<input type='hidden' id='ID_" + counter + "' value='" + ds.Challan[i].ID + "' name='hdnCid'></td>";
                    tbl = tbl + "<td style='text-align: left;'><span style='color:red; word-wrap: break-word;' title='" + ds.Challan[i].ErrorMessage.replace(/<br\s*\/?>/gi, ' ') + "' >" + getShortErrorMessage(ds.Challan[i].ErrorMessage.replace(/<br\s*\/?>/gi, ' ')) + "'</span></td>";
                    if (errorNumber.indexOf("15") > -1) {
                        tbl = tbl + "<td style='text-align: left;'><span style='color:red;'><input id='Challan_Number_" + counter + "' style=' border: 1px solid red; width:60px;text-align: center;' value='" + ds.Challan[i].Challan_Number + "''/></td>";
                    }
                    else {
                        tbl = tbl + "<td style='text-align: left;'><span style='color:red; word-wrap: break-word;'><input id='Challan_Number_" + counter + "' style='width:60px; border:none;text-align: center; ' value='" + ds.Challan[i].Challan_Number + "''/></td>";
                    }
                    if (errorNumber.indexOf("16") > -1) {
                        tbl = tbl + "<td style='text-align: left;'><span style='color:red; word-wrap: break-word;'><input id='Date_on_Tax_Depo_" + counter + "' style=' border: 1px solid red; width:100px;text-align: center;' value='" + ds.Challan[i].Date_on_Tax_Depo + "''/></td>";
                    }
                    else {
                        tbl = tbl + "<td style='text-align: left;'><span style='color:red; word-wrap: break-word;'><input id='Date_on_Tax_Depo_" + counter + "' style='width:100px; border:none;text-align: center;' value='" + ds.Challan[i].Date_on_Tax_Depo + "''/></td>";
                    }
                    if (errorNumber.indexOf("16") > -1) {
                        tbl = tbl + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='BSRCode_" + counter + "' style=' border: 1px solid red; width:70px;text-align: center;' value='" + ds.Challan[i].BSRCode + "''/></td>";
                    }
                    else {
                        tbl = tbl + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='BSRCode_" + counter + "' style='border:none; width:70px;text-align: center;' value='" + ds.Challan[i].BSRCode + "''/></td>";
                    }
                    if (errorNumber.indexOf("16") > -1) {
                        tbl = tbl + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='TDS_" + counter + "' style=' border: 1px solid red; width:80px;text-align: right;' value='" + ds.Challan[i].TDS + "''/></td>";
                    }
                    else {
                        tbl = tbl + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='TDS_" + counter + "' style='border:none;  width:80px;text-align: right;' value='" + ds.Challan[i].TDS + "''/></td>";
                    }
                    if (errorNumber.indexOf("16") > -1) {
                        tbl = tbl + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='Surcharge_" + counter + "' style=' border: 1px solid red; width:60px;text-align: right;' value='" + ds.Challan[i].Surcharge + "''/></td>";
                    }
                    else {
                        tbl = tbl + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='Surcharge_" + counter + "' style='border:none; width:60px;text-align: right;' value='" + ds.Challan[i].Surcharge + "''/></td>";
                    }
                    if (errorNumber.indexOf("16") > -1) {
                        tbl = tbl + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='education_Cess_" + counter + "' style=' border: 1px solid red; width:60px;text-align: right;' value='" + ds.Challan[i].education_Cess + "''/></td>";
                    }
                    else {
                        tbl = tbl + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='education_Cess_" + counter + "' style='border:none; width:60px;text-align: right;' value='" + ds.Challan[i].education_Cess + "''/></td>";
                    }
                    if (errorNumber.indexOf("16") > -1) {
                        tbl = tbl + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='Intrest_" + counter + "' style=' border: 1px solid red; width:60px;text-align: right;' value='" + ds.Challan[i].Intrest + "''/></td>";
                    }
                    else {
                        tbl = tbl + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='Intrest_" + counter + "' style='width:60px; border:none; text-align: right;' value='" + ds.Challan[i].Intrest + "''/></td>";
                    }
                    if (errorNumber.indexOf("16") > -1) {
                        tbl = tbl + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='Fee_" + counter + "' style=' border: 1px solid red; width:50px;text-align: right;' value='" + ds.Challan[i].Fee + "''/></td>";
                    }
                    else {
                        tbl = tbl + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='Fee_" + counter + "' style='border:none; width:50px;text-align: right;' value='" + ds.Challan[i].Fee + "''/></td>";
                    }
                    if (errorNumber.indexOf("16") > -1) {
                        tbl = tbl + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='Others_" + counter + "' style=' border: 1px solid red; width:50px;text-align: right;' value='" + ds.Challan[i].Others + "''/></td>";
                    }
                    else {
                        tbl = tbl + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='Others_" + counter + "' style='border:none; width:50px;text-align: right;' value='" + ds.Challan[i].Others + "''/></td>";
                    }
                    if (errorNumber.indexOf("16") > -1) {
                        tbl = tbl + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='TotalTaxDepo_" + counter + "' style='width:100px; border:none;text-align: right;' value='" + ds.Challan[i].TotalTaxDepo + "''/></td>";
                    }
                    else {
                        tbl = tbl + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='TotalTaxDepos_" + counter + "' style='width:100px; border:none;text-align: right;' value='" + ds.Challan[i].TotalTaxDepo + "''/></td>";
                    }
                    if (errorNumber.indexOf("16") > -1) {
                        tbl = tbl + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='quarter_" + counter + "' style='width:50px; border:none;' value='" + ds.Challan[i].quarter + "''/></td>";
                    }
                    else {
                        tbl = tbl + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='quarter_" + counter + "' style='width:50px; border:none;' value='" + ds.Challan[i].quarter + "''/></td>";
                    }

                    tbl = tbl + "</tr>";
                    //tbl = tbl + "<td style='text-align: center;'><a class='list-icons-item '><i onclick='Delete_Corr($(this))' style='cursor: pointer;' class='icon-trash text-danger-600'></i></a></td></tr>";
                    counter++;
                };
                $("[id*=tblChallan]").append(tbl);
            }
            else {
                tbl = tbl + "<tr>";
                tbl = tbl + "<td ></td>";
                tbl = tbl + "<td ></td>";
                tbl = tbl + "<td ></td>";
                tbl = tbl + "<td ></td>";
                tbl = tbl + "<td ></td>";
                tbl = tbl + "<td >No Record Found !!!</td>";
                tbl = tbl + "<td ></td>";
                tbl = tbl + "<td ></td>";
                tbl = tbl + "</tr>";
                $("[id*=tblChallan]").append(tbl);

            }



            if (ds.Voucher == undefined) {
                ShowErrorWindow(ds);
                return false;
            }

            //debugger;
            dtV = ds.Voucher;
            var tblV = '';
            $("[id*=tblVoucher] tbody").empty();
            $("[id*=tblVoucher] thead").empty();
            tblV = tblV + "<thead style='background-color:#F2F2F2;'><tr>";
            tblV = tblV + "<th  style='text-align: center;font-weight: bold;'>Sr</th>";
            tblV = tblV + "<th style='font-weight: bold;text-align: center;' id='thErrorMsg'>Error Message</th>";
            tblV = tblV + "<th  style='font-weight: bold;text-align: center;'>Challan No</th>";
            tblV = tblV + "<th  style='font-weight: bold;text-align: center;'>Ded. Code</th>";
            tblV = tblV + "<th  style='font-weight: bold;text-align: center;'>Ded. PAN</th>";
            tblV = tblV + "<th  style='font-weight: bold;text-align: center;'>Ded. Name</th>";
            tblV = tblV + "<th  style='font-weight: bold;text-align: center;'>Sec Desc.</th>";
            tblV = tblV + "<th  style='font-weight: bold;text-align: center;'>Credit Date</th>";
            tblV = tblV + "<th  style='font-weight: bold;text-align: center;'>Amount Paid</th>";
            tblV = tblV + "<th  style='font-weight: bold;text-align: center;'>TDS</th>";
            tblV = tblV + "<th  style='font-weight: bold;text-align: center;'>Surcharge</th>";
            tblV = tblV + "<th  style='font-weight: bold;text-align: center;'>Edu.Cess</th>";
            tblV = tblV + "<th  style='font-weight: bold;text-align: center;'>Total Tax Dedu.</th>";
            tblV = tblV + "<th  style='font-weight: bold;text-align: center;'>Rate</th>";
            tblV = tblV + "<th  style='font-weight: bold;text-align: center;'>Reason</th>";
            tblV = tblV + "<th  style='font-weight: bold;text-align: center;'>Cert. No.</th>";
            tblV = tblV + "<th  style='font-weight: bold;text-align: center;'>Opt 115</th>";
            tblV = tblV + "</tr></thead>";

            if (ds.Voucher.length > 0) {
                let counter = 1;

                for (var j = 0; j < ds.Voucher.length; j++) {

                    let errorNumber = ds.Voucher[j].ErrorMessage;

                    tblV = tblV + "<tr>";
                    tblV = tblV + "<td style='text-align: right;'>" + counter + "<input type='hidden' id='ID_" + counter + "' value='" + ds.Voucher[j].ID + "' name='hdnVid'></td>";
                    tblV = tblV + "<td style='text-align: left;'><span style='color:red; word-wrap: break-word;' title='" + ds.Voucher[j].ErrorMessage.replace(/<br\s*\/?>/gi, ' ') + "'>" + getShortErrorMessage(ds.Voucher[j].ErrorMessage.replace(/<br\s*\/?>/gi, ' ')) + "'</span></td>";
                    if (errorNumber.indexOf("15") > -1) {
                        tblV = tblV + "<td style='text-align: left;'><span style='color:red;'><input id='Challan_Number_" + counter + "' style=' border: 1px solid red; width:60px;text-align: center;' value='" + ds.Voucher[j].Challan_number + "''/></td>";
                    }
                    else {
                        tblV = tblV + "<td style='text-align: left;'><span style='color:red; word-wrap: break-word;'><input id='Challan_Number_" + counter + "' style='width:60px; border:none;text-align: center;' value='" + ds.Voucher[j].Challan_number + "''/></td>";
                    }
                    if (errorNumber.indexOf("16") > -1) {
                        tblV = tblV + "<td style='text-align: right;'><span style='color:red; word-wrap: break-word;'><input id='Deductee_Code_" + counter + "' style=' border: 1px solid red; width:70px;' value='" + ds.Voucher[j].Deductee_Code + "''/></td>";
                    }
                    else {
                        tblV = tblV + "<td style='text-align: right;'><span style='color:red; word-wrap: break-word;'><input id='Deductee_Code_" + counter + "' style='width:70px; border:none;' value='" + ds.Voucher[j].Deductee_Code + "''/></td>";
                    }
                    if (errorNumber.indexOf("16") > -1) {
                        tblV = tblV + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='PAN_of_Deductee_" + counter + "' style='width:100px; border:none;' value='" + ds.Voucher[j].PAN_of_Deductee + "''/></td>";
                    }
                    else {
                        tblV = tblV + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='PAN_of_Deductee_" + counter + "' style='width:100px; border:none;' value='" + ds.Voucher[j].PAN_of_Deductee + "''/></td>";
                    }
                    if (errorNumber.indexOf("16") > -1) {
                        tblV = tblV + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='Name_of_Deductee_" + counter + "' style='width:100px; border:none;' value='" + ds.Voucher[j].Name_Of_Deductee + "''/></td>";
                    }
                    else {
                        tblV = tblV + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='Name_of_Deductee_" + counter + "' style='width:100px; border:none;' value='" + ds.Voucher[j].Name_Of_Deductee + "''/></td>";
                    }
                    if (errorNumber.indexOf("16") > -1) {
                        tblV = tblV + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='Section_Description_" + counter + "' style='width:100px; border:none;' value='" + ds.Voucher[j].Section_Description + "''/></td>";
                    }
                    else {
                        tblV = tblV + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='Section_Description_" + counter + "' style='width:100px; border:none;' value='" + ds.Voucher[j].Section_Description + "''/></td>";
                    }

                    if (errorNumber.indexOf("16") > -1) {
                        tblV = tblV + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='Payment_CreditDate_" + counter + "' style='width:100px; border:none;' value='" + ds.Voucher[j].Payment_CreditDate + "''/></td>";
                    }
                    else {
                        tblV = tblV + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='Payment_CreditDate_" + counter + "' style='width:100px; border:none;' value='" + ds.Voucher[j].Payment_CreditDate + "''/></td>";
                    }
                    if (errorNumber.indexOf("16") > -1) {
                        tblV = tblV + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='Amount_Paid_Credited_" + counter + "' style='width:100px; border:none;text-align:right;' value='" + ds.Voucher[j].Amount_Paid_Credited + "''/></td>";
                    }
                    else {
                        tblV = tblV + "<td style='text-align: center;'><span style='color:red; word-wrap: break-word;'><input id='Amount_Paid_Credited_" + counter + "' style='width:100px; border:none;text-align:right;' value='" + ds.Voucher[j].Amount_Paid_Credited + "''/></td>";
                    }
                    if (errorNumber.indexOf("16") > -1) {
                        tblV = tblV + "<td style='text-align: right;'><span style='color:red; word-wrap: break-word;'><input id='TDS_" + counter + "' style=' width:100px; border:none;text-align:right;' value='" + ds.Voucher[j].TDS + "''/></td>";
                    }
                    else {
                        tblV = tblV + "<td style='text-align: right;'><span style='color:red; word-wrap: break-word;'><input id='TDS_" + counter + "' style='width:100px; border:none;text-align:right;' value='" + ds.Voucher[j].TDS + "''/></td>";
                    }
                    if (errorNumber.indexOf("16") > -1) {
                        tblV = tblV + "<td style='text-align: right;'><span style='color:red; word-wrap: break-word;'><input id='Surcharge_" + counter + "' style='width:60px; border:none;text-align:right;' value='" + ds.Voucher[j].Surcharge + "''/></td>";
                    }
                    else {
                        tblV = tblV + "<td style='text-align: right;'><span style='color:red; word-wrap: break-word;'><input id='Surcharge_" + counter + "' style='width:60px; border:none;text-align:right;' value='" + ds.Voucher[j].Surcharge + "''/></td>";
                    }
                    if (errorNumber.indexOf("16") > -1) {
                        tblV = tblV + "<td style='text-align: right;'><span style='color:red; word-wrap: break-word;'><input id='Education_Cess_" + counter + "' style='width:60px; border:none;text-align:right;' value='" + ds.Voucher[j].Education_Cess + "''/></td>";
                    }
                    else {
                        tblV = tblV + "<td style='text-align: right;'><span style='color:red; word-wrap: break-word;'><input id='Education_Cess_" + counter + "' style='width:60px; border:none;text-align:right;' value='" + ds.Voucher[j].Education_Cess + "''/></td>";
                    }
                    if (errorNumber.indexOf("16") > -1) {
                        tblV = tblV + "<td style='text-align: right;'><span style='color:red; word-wrap: break-word;'><input id='Total_Tax_Deducted_" + counter + "' style='width:100px; border:none;text-align:right;' value='" + ds.Voucher[j].Total_Tax_Deducted + "''/></td>";
                    }
                    else {
                        tblV = tblV + "<td style='text-align: right;'><span style='color:red; word-wrap: break-word;'><input id='Total_Tax_Deducted_" + counter + "' style='width:100px; border:none;text-align:right;' value='" + ds.Voucher[j].Total_Tax_Deducted + "''/></td>";
                    }
                    if (errorNumber.indexOf("16") > -1) {
                        tblV = tblV + "<td style='text-align: right;'><span style='color:red; word-wrap: break-word;'><input id='Rate_at_which_deducted_" + counter + "' style='width:50px; border:none;text-align:right;' value='" + ds.Voucher[j].Rate_at_which_deducted + "''/></td>";
                    }
                    else {
                        tblV = tblV + "<td style='text-align: right;'><span style='color:red; word-wrap: break-word;'><input id='Rate_at_which_deducted_" + counter + "' style='width:50px; border:none;text-align:right;' value='" + ds.Voucher[j].Rate_at_which_deducted + "''/></td>";
                    }
                    if (errorNumber.indexOf("16") > -1) {
                        tblV = tblV + "<td style='text-align: right;'><span style='color:red; word-wrap: break-word;'><input id='Reason_for_Non_deduction_Lower_Deduction_" + counter + "' style='width:100px; border:none;' value='" + ds.Voucher[j].Reason_for_Non_deduction_Lower_Deduction + "''/></td>";
                    }
                    else {
                        tblV = tblV + "<td style='text-align: right;'><span style='color:red; word-wrap: break-word;'><input id='Reason_for_Non_deduction_Lower_Deduction_" + counter + "' style='width:100px; border:none;' value='" + ds.Voucher[j].Reason_for_Non_deduction_Lower_Deduction + "''/></td>";
                    }
                    if (errorNumber.indexOf("16") > -1) {
                        tblV = tblV + "<td style='text-align: right;'><span style='color:red; word-wrap: break-word;'><input id='Certificate_number_for_Lower_NonDeduction_" + counter + "' style='width:100px; border:none;' value='" + ds.Voucher[j].Certificate_number_for_Lower_NonDeduction + "''/></td>";
                    }
                    else {
                        tblV = tblV + "<td style='text-align: right;'><span style='color:red; word-wrap: break-word;'><input id='Certificate_number_for_Lower_NonDeduction_" + counter + "' style='width:100px; border:none;' value='" + ds.Voucher[j].Certificate_number_for_Lower_NonDeduction + "''/></td>";
                    }
                    if (errorNumber.indexOf("16") > -1) {
                        tblV = tblV + "<td style='text-align: right;'><span style='color:red; word-wrap: break-word;'><input id='Opt115BAC_" + counter + "' style='width:50px; border:none;' value='" + ds.Voucher[j].Opt115BAC + "''/></td>";
                    }
                    else {
                        tblV = tblV + "<td style='text-align: right;'><span style='color:red; word-wrap: break-word;'><input id='Opt115BAC_" + counter + "' style='width:50px; border:none;' value='" + ds.Voucher[j].Opt115BAC + "''/></td>";
                    }


                    tblV = tblV + "</tr>";
                    //tblV = tblV + "<td style='text-align: center;'><a class='list-icons-item '><i onclick='Delete_Corr($(this))' style='cursor: pointer;' class='icon-trash text-danger-600'></i></a></td></tr>";
                    counter++;
                };
                $("[id*=tblVoucher]").append(tblV);
                Blockloaderhide();
            }

            else {


                tblV = tblV + "<tr>";
                tblV = tblV + "<td ></td>";
                tblV = tblV + "<td ></td>";
                tblV = tblV + "<td ></td>";
                tblV = tblV + "<td ></td>";
                tblV = tblV + "<td ></td>";
                tblV = tblV + "<td >No Record Found !!!</td>";
                tblV = tblV + "<td ></td>";
                tblV = tblV + "<td ></td>";
                tblV = tblV + "</tr>";
                $("[id*=tblVoucher]").append(tblV);

                Blockloaderhide();
            }



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
                url: "../handler/Correction.asmx/OpenDeducteePage",
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
                url: "../handler/Correction.asmx/CreateTxt",
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

        function updateFilleDate(dt) {
            $.ajax({
                type: "POST",
                url: "../handler/Correction.asmx/updateDT",
                data: '{cid:' + Cid + ', dt:"' + dt + '"}',
                contentType: "application/json; charset=utf-8",
                success: function (msg) {
                    var myList = jQuery.parseJSON(response.d);
                    if (myList.length > 0) {

                        var s = myList[0].CSuccess;
                        $("[id*=txtfDt]").val(s);
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
            <div class="row mb-2">
                <div class="col-sm-8">
                    <h5>
                        <span class="font-weight-bold">27EQ(TCS) - XL Import</span></h5>
                    </div>
                        <div class="col-sm-4">
                        <button id="btnBack" class="btn btn-outline-primary" type="button"  style="float: right;"><i class="fa fa-arrow-left mr-1 fa-1x"></i>Back</button>
</div>
              
            </div>
        </div>
    </div>

    <!-- Page header -->
    <!-- Content area -->
    <div class="content">
        <div class="row justify-content-center">
        <div class="col-md-12">
            <div class="card card-primary">
             <div class="card-header">
                  <h3 class="card-title">Import</h3>
                            </div>

            <div class="card-body" style="padding-top: 0px; padding-bottom: 0px;">
                 <div  class="form-group row " id="dvform" style="padding-top:12px;">
                     <label class="col-lg-1 col-form-label"  >Step 1.</label>
                                <div class="col-sm-2" style="font-size: larger;">
                                    <select id="ddlForm" class="form-control form-control-border select select2-hidden-accessible">
                                        <option value="26Q">26Q</option> 
                                        <option value="27Q">27Q(NRI)</option>
                                        <option value="27EQ(TCS)"selected>27EQ(TCS)</option>
                                      
                                    </select>
                                </div>
                               
                              <div class="col-sm-1" style="font-size: larger;">
                                    <select id="ddltype" class="form-control form-control-border select select2-hidden-accessible col-lg-2">
                                        <option value="Q1">Q1</option>
                                        <option value="Q2">Q2</option>
                                        <option value="Q3">Q3</option>
                                        <option value="Q4">Q4</option>
                                    </select>
                                </div>
                    </div>
                  <div class="form-group row " style="padding-top:12px;" id="importconso">

                       <label class="col-lg-1 col-form-label"  >Step 2.</label>
                                                        <div class="col-4">
                                                            <a href="../../Templates/26EQ_Blank_XLSheet.xlsx">
                  
                        
                        <button type="button" id="btnDownload" class="btn btn-block bg-gradient-warning " style="width: 209px;" title="Download blank excel"><i class="icon-file-download mr-2 fa-1x"></i>Download Blank sheet</button>
                        </a>
                        </div>
                    </div>
                    
                    
                    <div class="form-group row">
                        <label class="col-lg-1 col-form-label">Step 3.</label>
                         <div class="col-2">
                        <input type="file" style="padding-top: 5px;" accept=".xlsx" name="file" id="file" class="btn btn-outline-success legitRipple"/>
                    </div>
                        </div>
                         <div class="form-group row">
                        <label class="col-lg-1 col-form-label">Step 4.</label>
                    <div class="col-3">
                        <button type="button" id="btnUpload"  class="btn btn-block bg-gradient-info" style="width: 209px;"><i class="fas fa-file-upload mr-2 fa-1x"></i>Upload</button>
                    </div>
                    </div>
                </div>
            </div>
            </div>
    
           <%-- <div class="col-md-6">
                   <div class="card card-success">
             <div class="card-header">
                  <h3 class="card-title">Export/BackUp</h3>
                            </div>
                        <div class="card-body" style="padding-top: 12px; padding-bottom: 0px;">
                            <div class="form-group row">
                        <label class="col-lg-2 col-form-label"></label>
                         <div class="col-5">
                        <button type="button" id="btnDownloadBackup" class="btn btn btn-warning"  ><i class="icon-file-download mr-2 fa-1x"></i>Download Backup</button>
                    </div>
                                </div>
                     <div class="form-group row">
                         <label class=""></label>
                          <div class="col-5">
                        <span id="spBackupDate"></span>
                     </div>
                         </div>
                
                  
                    <span id="lblMessage" class="col-lg-2" style="color: Green; padding-top: 5px;"></span>
                            <div class="form-group row">
                         <label class=""></label>
                          <div class="col-5">
                        <span id=""></span>
                     </div>
                         </div>
</div>
                
    </div>
                

        </div>--%>
    </div>
   
   </div>

</asp:Content>


