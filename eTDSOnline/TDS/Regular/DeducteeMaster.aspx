<%@ Page Title="" Language="C#" MasterPageFile="~/TDS/BTS_MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="DeducteeMaster.aspx.cs" Inherits="Admin_DeducteeMaster" %>
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

    <script type="text/javascript">

        $(document).ready(function () {
            $("[id*=ddlperpage]").val(25);
            $("[id*=ddlperpage]").trigger('change');
            fillDeducteeGrid(1, 25, $("[id*=txtSearchDeductee_]").val(), $("[id*=ddlSearchPAN]").val(), $("[id*=ddlSearchRemark_]").val());

            Fill_Country();
            $("[id*=ddlTDSRate_]").attr("disabled", true);
            $("[id*=ddlCountry_]").attr("disabled", true);
            $("[id*=txtAddress_]").attr("disabled", true);
            $("[id*=txtTIN_]").attr("disabled", true);
            $("[id*=txtEmail_]").attr("disabled", true);
            $("[id*=txtContactNo_]").attr("disabled", true);
            $("[id*=hdnPages]").val('1');
            if ($("[id*=ddlRemark_]").val() == "Lower Rt. Under Section 197 A") {
                $("[id*=txtCertificateNo_]").attr("disabled", false);
                $("[id*=txtCertificateNo_]").val('');
            }
            else
                $("[id*=txtCertificateNo_]").attr("disabled", true);

            if ($("[id*=ddlSlabDetails_]").val() == "0") {
                $("[id*=txtTDSRate]").attr("disabled", false);
                $("[id*=txtTDSRate]").val('');
            }
            else
                $("[id*=txtTDSRate]").attr("disabled", true);

            $("[id*=chkIsNRI_]").on("click", function () {
                var check = $(this).is(':checked');
                if (check) {
                    $("[id*=ddlTDSRate_]").attr("disabled", false);
                    $("[id*=ddlCountry_]").attr("disabled", false);
                    $("[id*=txtAddress_]").attr("disabled", false);
                    $("[id*=txtTIN_]").attr("disabled", false);
                    $("[id*=txtEmail_]").attr("disabled", false);
                    $("[id*=txtContactNo_]").attr("disabled", false);
                }
                else {
                    $("[id*=ddlTDSRate_]").attr("disabled", true);
                    $("[id*=ddlCountry_]").attr("disabled", true);
                    $("[id*=txtAddress_]").attr("disabled", true);
                    $("[id*=txtTIN_]").attr("disabled", true);
                    $("[id*=txtEmail_]").attr("disabled", true);
                    $("[id*=txtContactNo_]").attr("disabled", true);
                }
            });

            $("[id*=ddlRemark_]").change(function () {
                if ($("[id*=ddlRemark_]").val() == "Lower Rt. Under Section 197 A") {
                    $("[id*=txtCertificateNo_]").attr("disabled", false);
                    $("[id*=txtCertificateNo_]").val('');
                }
                else
                    $("[id*=txtCertificateNo_]").attr("disabled", true);

            });

            $("[id*=ddlSlabDetails_]").change(function () {
                if ($("[id*=ddlSlabDetails_]").val() == "0") {
                    $("[id*=txtTDSRate]").attr("disabled", false);
                    $("[id*=txtTDSRate]").val('');
                }
                else
                    $("[id*=txtTDSRate]").attr("disabled", true);
            });
            $("[id*=btnNew]").on('click', function () {
                ResetControls();
                $("[id*=divDeducteeDetails]").show();
                $("[id*=divDeducteeList]").hide();
                $("[id*=divSearch]").hide();
            });

            $("[id*=btnCancel]").on('click', function () {
                ResetControls();
                $("[id*=divDeducteeDetails]").hide();
                $("[id*=divDeducteeList]").show();
                $("[id*=divSearch]").show();
            });


            $("[id*=btnSave]").on('click', function () {
                if ($("[id*=txtPAN_]").val().length != 10) {
                    showInfoAlert('PAN no should be 10 digit');
                    return;
                }

                if ($("[id*=ddlCountry_]").val() > 0 && $("[id*=ddlTDSRate_]").val() == 0) {
                    showInfoAlert('Tds Rate as per GOVT cannot be blank');
                    return;
                }
                if ($("[id*=ddlRemark_]").val() == 0) {
                    sowInfoAlert('Reasons cannot be blank');
                    return;
                }

                if ($("[id*=ddlRemark_]").val() == "Lower Rt. Under Section 197 A" && $("[id*=txtCertificateNo_]").val() == "") {
                    showInfoAlert('Certificate number cannot be blank');
                    return;
                }

                if ($("[id*=ddlCode_]").val() == 0) {
                    showInfoAlert('Code cannot be blank');
                    return;
                }
                if ($("[id*=ddlCountry_]").val() > 0 && $("[id*=txtPAN_]").val() == 'PANNOTAVBL') {
                    if (f == '' && s == '') {
                        showInfoAlert('Address required for PANNOTAVBL');
                        return;
                    }
                    if ($("[id*=txtEmail_]").val() == '') {
                        showInfoAlert('Email required for PANNOTAVBL');
                        return;
                    }
                    if ($("[id*=txtContactNo_]").val() == '') {
                        showInfoAlert('Contact Number required for PANNOTAVBL');
                        return;
                    }
                }

                var s = $("[id*=txtContactNo_]").val();
                if (s != '') {
                    if (s.indexOf(' ') >= 0) {
                        showInfoAlert("Remove space and special chars from Contact Number ");
                        return;
                    }
                    var n = parseFloat($("[id*=txtContactNo_]").val());
                    if (isNaN(n)) {
                        showInfoAlert("Contact Number should be numeric");
                        return;
                    }
                }
                if ($("[id*=ddlSlabDetails_]").val() == "") {
                    showInfoAlert('Calculate TDS Rates cannot be blank');
                    return;
                }
                if ($("[id*=ddlSlabDetails_]").val() == "0" && $("[id*=txtTDSRate]").val() == "") {
                    showInfoAlert('TDS Rate cannot be blank');
                    return;
                }

                var IsNRI;
                if ($("[id*=chkIsNRI_]").is(':checked')) {
                    IsNRI = true;
                }
                else
                    IsNRI = false;

                var IsOpting1A;
                if ($("[id*=chkOpting1A_]").is(':checked')) {
                    IsOpting1A = true;
                }
                else
                    IsOpting1A = false;
                var CountryID = 0;
                if ($("[id*=ddlCountry_]")[1].value != "")
                    CountryID = $("[id*=ddlCountry_]")[1].value;

                var SlabDetails = "0";
                if ($("[id*=ddlSlabDetails_]")[1].value != "")
                    SlabDetails = $("[id*=ddlSlabDetails_]")[1].value;

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../TDS/BTStrp/handler/Deductee.asmx/InsertUpdateBank",
                    data: '{Deductee_ID:' + $("[id*=hdnid]").val() + ',Deductee_Name:"' + $("[id*=txtDeductee_]").val() + '", PAN_NO:"' + $("[id*=txtPAN_]").val() + '",DeducteeType:"' + $("[id*=ddlCode_]").val() + '",Remarks:"' + $("[id*=ddlRemark_]").val() + '",CertificateNo:"' + $("[id*=txtCertificateNo_]").val() + '",OptingFor1A:' + IsOpting1A + ',IsNri:' + IsNRI + ',NRI_TDSRate:"' + $("[id*=ddlTDSRate_]").val() + '", NRICountryID:' + CountryID + ', NRIAddress:"' + $("[id*=txtAddress_]").val() + '",NRI_Tan:"' + $("[id*=txtTIN_]").val() + '",NRI_Email:"' + $("[id*=txtEmail_]").val() + '",NRI_ContactNo:"' + $("[id*=txtContactNo_]").val() + '",TDS_Rate_From:' + SlabDetails + ',TDSRate:"' + $("[id*=txtTDSRate]").val() + '"}',
                    dataType: "json",
                    success: function (msg) {
                        var myList = jQuery.parseJSON(msg.d);
                        if (myList > 0) {
                            ResetControls();
                            showSuccessAlert('Deductee save success');
                            $("[id*=divDeducteeDetails]").hide();
                            $("[id*=divDeducteeList]").show();
                            $("[id*=divSearch]").show();
                            fillDeducteeGrid(1, 25, $("[id*=txtSearchDeductee_]").val(), $("[id*=ddlSearchPAN]").val(), $("[id*=ddlSearchRemark_]").val());
                        }
                    },
                    failure: function (response) {
                        alert('Cant Connect to Server' + response.d);
                    },
                    error: function (response) {
                        alert('Error Occoured ' + response.d);
                    }
                });
            });
            $("[id*=ddlSearchReasons]").change(function () {
                fillDeducteeGrid(1, 25, $("[id*=txtSearchDeductee_]").val(), $("[id*=ddlSearchPAN]").val(), $("[id*=ddlSearchRemark_]").val());
            });
            $("[id*=ddlSearchRemark_]").change(function () {
                fillDeducteeGrid(1, 25, $("[id*=txtSearchDeductee_]").val(), $("[id*=ddlSearchPAN]").val(), $("[id*=ddlSearchRemark_]").val());
            });
            $("[id*=txtSearchDeductee_]").blur(function () {
                fillDeducteeGrid(1, 25, $("[id*=txtSearchDeductee_]").val(), $("[id*=ddlSearchPAN]").val(), $("[id*=ddlSearchRemark_]").val());
            });

            $("[id*=ddlperpage]").change(function () {
                var pg = $("[id*= ddlperpage]").val();
                $("[id*=hdnPages]").val(1);
                fillDeducteeGrid(1, pg, $("[id*=txtSearchDeductee_]").val(), $("[id*=ddlSearchPAN]").val(), $("[id*=ddlSearchRemark_]").val());
            });
            
        });

        function Fill_Country() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/Deductee.asmx/Fill_Country",
                dataType: "json",
                success: function (msg) {
                    var xmlDoc = $.parseXML(msg.d);
                    var xml = $(xmlDoc);
                    var CountryList = xml.find("Table");

                    if (CountryList.length > 0) {
                        $("[id*=ddlCountry_]").empty();
                        $("[id*=ddlCountry_]").append("<option value='0'>--Select Country--</option>");
                        $.each(CountryList, function () {
                            $("[id*=ddlCountry_]").append("<option value='" + $(this).find("Country_ID").text() + "'>" + $(this).find("Country_Name").text() + "</option>");
                        });
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

        function ResetControls() {
            $("[id*=hdnid]").val('0');
            $("[id*=txtDeductee_]").val('');
            $("[id*=txtPAN_]").val('');
            $("[id*=ddlCode_]").val('0');
            $("[id*=ddlCode_]").trigger('change');
            $("[id*=ddlRemark_]").val('0');
            $("[id*=ddlRemark_]").trigger('change');
            $("[id*=chkOpting1A]").removeAttr('checked');
            $("[id*=txtCertificateNo_]").val('');
            $("[id*=chkIsNRI_]").removeAttr('checked');
            $("[id*=ddlTDSRate_]").val('0');
            $("[id*=ddlTDSRate_]").trigger('change');
            $("[id*=ddlCountry_]").val('0');
            $("[id*=ddlCountry_]").trigger('change');
            $("[id*=txtAddress_]").val('');
            $("[id*=txtEmail_]").val('');
            $("[id*=txtContactNo_]").val('');
            $("[id*=txtTIN_]").val('');
            $("[id*=ddlSlabDetails_]").val('');
            //$("[id*=hdnPages]").val('0');
            $("[id*=ddlSlabDetails_]").trigger('change');
            $("[id*=txtTDSRate]").val('');
        }

        function fillDeducteeGrid(PageIndex, PageSize, deductee, PANVerified, reason) {
            Blockloadershow();
            PageSize = $("[id*=ddlperpage]").val();
            var RecordCount = 0;
            $("[id*=divDeducteeDetails]").hide();
            $("[id*=divDeducteeList]").show();
            $("[id*=divSearch]").show();

            $.ajax({
                type: "POST",
                url: "../../TDS/BTStrp/Handler/Deductee.asmx/FillGridData",
                data: '{PANVerified: "' + PANVerified + '", reasons: "' + reason + '",Dname: "' + deductee + '", PageIndex: ' + PageIndex + ', PageSize: ' + PageSize + ' }',
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function (msg) {
                    var xmlDoc = $.parseXML(msg.d);
                    var xml = $(xmlDoc);
                    var myList = xml.find("Table");

                    var tbl = '';
                    $("[id*=tblDeductee]").empty();
                    $("[id*=tblDeductee] tr").empty();
                    $("[id*=tblDeductee] tbody").empty();
                    tbl = tbl + "<tr>";
                    tbl = tbl + "<th  style='text-align: center;'>Srno</th>";
                    tbl = tbl + "<th  style='text-align: center;'>PAN</th>";
                    tbl = tbl + "<th >Deductee</th>";
                    tbl = tbl + "<th >Type</th>";
                    tbl = tbl + "<th >Is NRI</th>";
                    tbl = tbl + "<th >PAN Verify </th>";
                    tbl = tbl + "<th >PANVerified</th>";
                    tbl = tbl + "<th style='text-align: center;'>206AB</th>";
                    tbl = tbl + "<th style='text-align: center;'>115BAC(1A)</th>";
                    tbl = tbl + "<th >Delete</th>";

                    tbl = tbl + "</tr>";

                    if (myList.length > 0) {
                        $.each(myList, function () {
                            tbl = tbl + "<tr>";
                            tbl = tbl + "<td style='text-align: center;' class='padding5'>" + $(this).find("SrNo").text() + "<input type='hidden' id='hdndid' value='" + $(this).find("Deductee_ID").text() + "' name='hdndid'></td>";
                            tbl = tbl + "<td style='text-align: left;' class='padding5'><a href='#'  onclick='Edit_Rec($(this))' >" + $(this).find("PAN_NO").text() + "</a></td>";
                            tbl = tbl + "<td style='text-align: left;' class='padding5'>" + $(this).find("Deductee_Name").text() + "</td>";

                            tbl = tbl + "<td >" + $(this).find("Deductee_Type").text() + "<input type='hidden' id='hdncid' value='" + $(this).find("compid").text() + "' name='hdncid'></td>";
                            var n = $(this).find("IS_NRI").text();
                            if (n == true) {
                                n = 'Yes';
                            }
                            else {
                                n = 'No'
                            }
                            tbl = tbl + "<td class='padding5' >" + n + "</td>";
                            tbl = tbl + "<td  style='text-align: center;' class='padding5'><input id='PnvVerfy' type='button' value='Traces' title='Verify PAN with Traces' onclick='VerifyPANGrd($(this))' class='cssButton'/></td>";
                            tbl = tbl + "<td class='padding5' >" + $(this).find("PANVerified").text() + "</td>";
                            var c = '';
                            if ($(this).find("TR206").text() == 0) {
                                c = 'N';
                            }
                            if ($(this).find("TR206").text() == 1) {
                                c = 'Y';
                            }
                            if ($(this).find("TR206").text() == 2) {
                                c = 'N';
                            }
                            var IsOPT = 'N';
                            if ($(this).find("OptingFor1A").text() == 1)
                                IsOPT = 'Y';
                            tbl = tbl + "<td style='text-align: center;' class='padding5'>" + c + "</td>";
                            tbl = tbl + "<td style='text-align: center;' class='padding5'>" + IsOPT + "</td>";
                            //tbl = tbl + "<td style='text-align: center;' class='padding5'><img src='../images/delete.png' style='cursor:pointer; height:18px; width:18px;' onclick='Del_Rec($(this))' id='stfDel' name='stfDel'></td>";
                            tbl = tbl + "<td style='text-align: left;' class='padding5'><a href='#'  onclick='Del_Rec($(this))' ><i class='fas fa-trash'></i></a></td>";
                        });
                        $("[id*=tblDeductee]").append(tbl);

                        if (parseInt(myList[0].children[6].textContent) > 0) {
                            RecordCount = parseInt(myList[0].children[6].textContent);
                        }

                        Pager(RecordCount, deductee, PANVerified, reason);
                        Blockloaderhide();
                    }

                    else {
                        tbl = tbl + "<tr>";
                        tbl = tbl + "<td ></td>";
                        tbl = tbl + "<td >No Record Found !!!</td>";
                        tbl = tbl + "<td ></td>";
                        tbl = tbl + "<td ></td>";
                        tbl = tbl + "<td ></td>";
                        tbl = tbl + "<td ></td>";
                        tbl = tbl + "<td ></td>";
                        tbl = tbl + "<td ></td>";
                        tbl = tbl + "<td ></td>";
                        tbl = tbl + "</tr>";
                        $("[id*=tblDeductee]").append(tbl);
                        Pager(0, deductee, PANVerified, reason);
                        Blockloaderhide();
                    }

                },
                failure: function (response) {
                    alert('Cant Connect to Server' + response.d);
                    Blockloaderhide();
                },
                error: function (response) {
                    alert('Error Occoured ' + response.d);
                    Blockloaderhide();
                }
            });

        }


        function Pager(RecordCount, p, r, d) {
            $(".Pager").ASPSnippets_Pager({
                ActiveCssClass: "current",
                PagerCssClass: "pager",
                PageIndex: parseInt($("[id*=hdnPages]").val()),
                PageSize: parseInt(25),
                RecordCount: parseInt(RecordCount)
            });


            $(".Pager .page").on("click", function () {
                $("[id*=hdnPages]").val($(this).attr('page'));
                var PageSize = parseInt($("[id*=ddlperpage]").val());
                fillDeducteeGrid(($(this).attr('page')), PageSize, p, r, d);
            });
        }

        function Edit_Rec(i) {
            var row = i.closest("tr");
            var Did = row.find("input[name=hdndid]").val();

            $("[id*=divDeducteeDetails]").show();
            $("[id*=divDeducteeList]").hide();
            $("[id*=divSearch]").hide();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/Deductee.asmx/GetDeducteeDetails",
                data: '{DeducteeID:' + Did + '}',
                dataType: "json",
                success: function (msg) {
                    var xmlDoc = $.parseXML(msg.d);
                    var xml = $(xmlDoc);
                    var myList = xml.find("Table");
                    if (myList.length > 0) {

                        $.each(myList, function () {
                            $("[id*=hdnid]").val($(this).find("Deductee_ID").text());
                            $("[id*=chkOpting1A]").removeAttr('checked');
                            if ($(this).find("OptingFor1A").text() == false)
                                $("#chkOpting1A").prop("checked", false);
                            else
                                $("#chkOpting1A").prop("checked", true);
                            $("[id*=txtDeductee_]").val($(this).find("Deductee_Name").text());
                            $("[id*=txtPAN_]").val($(this).find("PAN_NO").text());
                            $("[id*=ddlCode_]").val($(this).find("Deductee_Type").text());
                            $("[id*=ddlCode_]").trigger('change');
                            $("[id*=ddlRemark_]").val($(this).find("Reasons").text());
                            $("[id*=ddlRemark_]").trigger('change');

                            $("[id*=txtCertificateNo_]").val($(this).find("Certificate_NO").text());
                            $("[id*=chkIsNRI_]").removeAttr('checked');
                            $("[id*=ddlTDSRate_]").val($(this).find("NRI_TDS_rate").text());
                            $("[id*=ddlTDSRate_]").trigger('change');
                            $("[id*=ddlCountry_]").val($(this).find("Country_ID").text());
                            $("[id*=ddlCountry_]").trigger('change');
                            $("[id*=txtAddress_]").val($(this).find("Address").text());
                            $("[id*=txtEmail_]").val($(this).find("Email").text());
                            $("[id*=txtContactNo_]").val($(this).find("Mobile_No").text());
                            $("[id*=txtTIN_]").val($(this).find("TaxIdentificationNo").text());
                            $("[id*=ddlSlabDetails_]").val($(this).find("TDS_Rate_From").text());
                            $("[id*=hdnPages]").val('1');
                            $("[id*=ddlSlabDetails_]").trigger('change');
                            $("[id*=txtTDSRate]").val($(this).find("TDS_Rate").text());
                        });
                    }
                    Blockloaderhide();
                },
                failure: function (response) {
                    showDangerAlert('Challan data not found');
                    Blockloaderhide();
                },
                error: function (response) {
                    showDangerAlert('Challan data not found');
                    Blockloaderhide();
                }
            });
        }
        function Del_Rec(i) {
            var row = i.closest("tr");
            var Did = row.find("input[name=hdndid]").val();

            $("[id*=divDeducteeDetails]").hide();
            $("[id*=divDeducteeList]").show();
            $("[id*=divSearch]").show();
            if (confirm('Are you sure, you want to delete deductee?')) {

                DelDeductee(Did);
            }
            else {
                hideloader();
            }

        }

        function DelDeductee(Did) {
            showloader();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/Deductee.asmx/DeleteDeductee",
                data: '{Deductee_ID:' + Did + '}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    if (myList > 0) {
                        showSuccessAlert('Deductee Deleted');
                        fillDeducteeGrid(1, 25, $("[id*=txtSearchDeductee_]").val(), $("[id*=ddlSearchPAN]").val(), $("[id*=ddlSearchRemark_]").val());
                        hideloader();
                    }
                    else {
                        showDangerAlert('Deductee has dependant records. Cannot delete deductee');
                    }

                },
                failure: function (response) {
                    showDangerAlert('Cant Connect to Server' + response.d);
                },
                error: function (response) {
                    showDangerAlert('Error Occoured ' + response.d);
                }
            });
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:HiddenField ID="hdnid" Value="0" runat="server" />
    <asp:HiddenField ID="hdnPages" runat="server" />
    <div id="divSearch">
        <div class="content">
            <div class="card">
                <div class="card-body">
                    <div class="form-group row" style="padding-top: 10px;">
                        <div class="col-3">
                            <input id="txtSearchDeductee_" name="txtSearchDeductee_" tabindex="2" type="text" class="form-control form-control-border" value="" placeholder="Deductee/PAN No" style="padding-right: 0; padding-left: 0;" />
                        </div>
                        <div class="col-4">
                            <select id="ddlSearchRemark_" name="ddlSearchRemark_" class="form-control select" data-fouc>
                                <option value="">Select Remark</option>
                                <option value="Presc.Rt.">Presc.Rt.</option>
                                <option value="Lower Rt. Under Section 197 A">Lower Rt. Under Section 197 A</option>
                                <option value="No Tax only for sec 194, 194A, 194EE And 193 B">No Tax only for sec 194, 194A, 194EE And 193 B</option>
                                <option value="No Tax on A/c of pmt under sec 197A Z">No Tax on A/c of pmt under sec 197A Z</option>
                                <option value="Non-Availability of PAN C">Non-Availability of PAN C</option>
                                <option value="Transporter and valid PAN T">Transporter and valid PAN T</option>
                                <option value="Software acquired under section 194J S">Software acquired under section 194J S</option>

                            </select>
                        </div>
                        <div class="col-2">
                            <select id="ddlSearchPAN" class="form-control select">
                                <option value="">Select PAN Status</option>
                                <option value="InValid PAN">InValid PAN</option>
                                <option value="Valid PAN">Valid PAN</option>
                                <option value="PAN Not Available">PAN Not Available</option>
                            </select>
                        </div>

                        <div class="col-1 right">Pg Size</div>
                        <div class="col-1 right">
                            <select id="ddlperpage" class="form-control select select2-hidden-accessible" style="width: 80%;">
                                <option value="25">25</option>
                                <option value="75">75</option>
                                <option value="100">100</option>
                                <option value="200">200</option>
                                <option value="800">800</option>
                                <option value="1200">1200</option>
                                <option value="2000">2000</option>
                            </select>
                        </div>
                        <div class="col-1 right">
                            <button id="btnNew" name="btnNew" class="btn btn-outline-success legitRipple" type="button"><b><i class="fas fa-plus"></i></b>New</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="divDeducteeList">
        <div class="content">
            <div class="card">
                <div class="table-responsive">
                    <table id="tblDeductee" class="table table-hover table-xs font-size-base"></table>
                </div>
                <table id="tblPager" style="border: 1px solid #BCBCBC;">
                    <tr>
                        <td>
                            <div class="Pager">
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <div id="divDeducteeDetails">
        <div class="content">
            <div class="card">
                <div class="content-header">
                    <div class="container-fluid" style="padding-top: 0px;">
                        <div class="row mb-2" style="align-items: center;">
                            <div class="col-sm-2">
                                <h5><span class="font-weight-bold">Deductee Details</span></h5>
                            </div>
                            <div class="col-sm-8">
                            </div>
                            <div style="margin-left: auto;">
                                <button id="btnSave" name="btnSave" class="btn btn-outline-success legitRipple" type="button"><b><i class="mi-save"></i></b>Save</button>
                                <button id="btnCancel" name="btnCancel" class="btn btn-outline-success legitRipple" type="button"><b><i class="mi-save"></i></b>Cancel</button>
                            </div>
                        </div>
                        <div class="datatable-header">
                            <div class="form-group row">
                                <div class="col-2">
                                    <label class="col-form-label font-weight-bold">Deductee:</label>
                                </div>
                                <div class="col-2">
                                    <input id="txtDeductee_" name="txtDeductee_" tabindex="2" type="text" class="form-control form-control-border" value="" placeholder="Deductee" style="padding-right: 0; padding-left: 0;" />

                                </div>

                            </div>
                            <div class="form-group row">
                                <div class="col-2">
                                    <label class="col-form-label font-weight-bold">PAN:</label>
                                </div>
                                <div class="col-2">
                                    <input id="txtPAN_" name="txtPAN_" maxlength="10" tabindex="2" type="text" class="form-control form-control-border" value="" placeholder="PAN" style="padding-right: 0; padding-left: 0;" />

                                </div>
                                <div class="col-1">
                                    <button id="btnValidate_" name="btnValidate_" class="btn btn-outline-success legitRipple" style="width: 200px;" type="button"><b><i class="mi-save"></i></b>Validate</button>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-2">
                                    <label class="col-form-label font-weight-bold">Code:</label>
                                </div>
                                <div class="col-2">
                                    <select id="ddlCode_" name="ddlCode_" class="form-control select" data-fouc>
                                        <option value="0">Select Type</option>
                                        <option value="Company">Company</option>
                                        <option value="Non-Company">Non-Company</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-2">
                                    <label class="col-form-label font-weight-bold">Remarks:</label>
                                </div>
                                <div class="col-2">
                                    <select id="ddlRemark_" name="ddlRemark_" class="form-control select" data-fouc>
                                        <option value="0">Select Remark</option>
                                        <option value="Presc.Rt.">Presc.Rt.</option>
                                        <option value="Lower Rt. Under Section 197 A">Lower Rt. Under Section 197 A</option>
                                        <option value="No Tax only for sec 194, 194A, 194EE And 193 B">No Tax only for sec 194, 194A, 194EE And 193 B</option>
                                        <option value="No Tax on A/c of pmt under sec 197A Z">No Tax on A/c of pmt under sec 197A Z</option>
                                        <option value="Non-Availability of PAN C">Non-Availability of PAN C</option>
                                        <option value="Transporter and valid PAN T">Transporter and valid PAN T</option>
                                        <option value="Software acquired under section 194J S">Software acquired under section 194J S</option>

                                    </select>
                                </div>
                                <div class="col-6">
                                    <input id="txtCertificateNo_" name="txtCertificateNo_" maxlength="10" tabindex="2" type="text" class="form-control form-control-border" value="" placeholder="Enter Certificate No in Case of Lower Rt" style="padding-right: 0; padding-left: 0;" />
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-2">
                                    <label class="col-form-label font-weight-bold">Opting for 115BAC(1A):</label>
                                </div>
                                <div class="col-2">
                                    <input type='checkbox' id='chkOpting1A' name='chkOpting1A'>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-2">
                                    <label class="col-form-label font-weight-bold">Application For All Companies:</label>
                                </div>
                                <div class="col-2">
                                    <input type='checkbox' id='chkAppAllComp_' name='chkAppAllComp_'>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="content">
            <div class="card">
                <div class="content-header">
                    <div class="container-fluid" style="padding-top: 0px;">
                        <div class="row mb-2" style="align-items: center;">
                            <div class="col-sm-2">
                                <h5><span class="font-weight-bold">Details for 27Q Only</span></h5>
                            </div>
                        </div>
                        <div class="datatable-header">
                            <div class="form-group row">
                                <div class="col-2">
                                    <label class="col-form-label font-weight-bold">Is NRI:</label>
                                </div>
                                <div class="col-2">
                                    <input type='checkbox' id='chkIsNRI_' class="form-check-input" name='chkIsNRI_'>
                                </div>
                                <div class="col-2">
                                    <label class="col-form-label font-weight-bold">TDS Rate:</label>
                                </div>
                                <div class="col-2">
                                    <select id="ddlTDSRate_" name="ddlTDSRate_" class="form-control select" data-fouc>
                                        <option value="0">Select</option>
                                        <option value="If TDS rate is as per Income TaxAct A">If TDS rate is as per Income TaxAct A</option>
                                        <option value="If TDS rate is as per DTAA B">If TDS rate is as per DTAA B</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-2">
                                    <label class="col-form-label font-weight-bold">Country:</label>
                                </div>
                                <div class="col-2">
                                    <select id="ddlCountry_" name="ddlCountry_" class="form-control select" data-fouc>
                                    </select>
                                </div>

                            </div>
                            <div class="form-group row">
                                <div class="col-2">
                                    <label class="col-form-label font-weight-bold">Address:</label>
                                </div>
                                <div class="col-8">
                                    <input id="txtAddress_" name="txtAddress_" tabindex="2" type="text" class="form-control form-control-border" value="" placeholder="Address" style="padding-right: 0; padding-left: 0;" />
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-2">
                                    <label class="col-form-label font-weight-bold">Tax Identification No (TIN):</label>
                                </div>
                                <div class="col-2">
                                    <input id="txtTIN_" name="txtTIN_" tabindex="2" type="text" class="form-control form-control-border" value="" placeholder="Tax Identification No (TIN)" style="padding-right: 0; padding-left: 0;" />
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-2">
                                    <label class="col-form-label font-weight-bold">Email:</label>
                                </div>
                                <div class="col-2">
                                    <input id="txtEmail_" name="txtEmail_" tabindex="2" type="text" class="form-control form-control-border" value="" placeholder="Tax Identification No (TIN)" style="padding-right: 0; padding-left: 0;" />
                                </div>
                                <div class="col-2">
                                    <label class="col-form-label font-weight-bold">Contact No.:</label>
                                </div>
                                <div class="col-2">
                                    <input id="txtContactNo_" name="txtContactNo_" tabindex="2" type="text" class="form-control form-control-border" value="" placeholder="Tax Identification No (TIN)" style="padding-right: 0; padding-left: 0;" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="content">
            <div class="card">
                <div class="content-header">
                    <div class="container-fluid" style="padding-top: 0px;">
                        <div class="row mb-2" style="align-items: center;">
                            <div class="col-2">
                                <h5><span class="font-weight-bold">TDS Configuratation</span></h5>
                            </div>
                        </div>
                        <div class="datatable-header">
                            <div class="form-group row">
                                <div class="col-2">
                                    <label class="col-form-label font-weight-bold">Calculate TDS Rates Frm:</label>
                                </div>
                                <div class="col-2">
                                    <select id="ddlSlabDetails_" name="ddlSlabDetails_" class="form-control select" data-fouc>
                                        <option value="">Select TDS Rate</option>
                                        <option value="1">Slab</option>
                                        <option value="0">Deductee Master</option>
                                    </select>
                                </div>
                                <div class="col-2">
                                    <label class="col-form-label font-weight-bold">TDS Rate:</label>
                                </div>
                                <div class="col-2">
                                    <input id="txtTDSRate" runat="server" class="form-control" maxlength="5" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

