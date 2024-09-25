<%@ Page Title="" Language="C#" MasterPageFile="~/TDS/BTS_MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="CompanyMaster.aspx.cs" Inherits="Admin_CompanyMaster" %>

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
    
    <script language="javascript" type="text/javascript">

    $(document).ready(function () {
        $("[id*=divCompList]").show();
        $("[id*=dvCompDetails]").hide();
        $("[id*=btnSave]").hide();
        $("[id*=btnCancel]").hide();

        BindStates();
        PopulateCompanyList(0, 25);

        $("[id*=btnCancel]").on('click', function () {
            $("[id*=divCompList]").show();
            $("[id*=dvCompDetails]").hide();
            $("[id*=btnSave]").hide();
            $("[id*=btnCancel]").hide();
            $("[id*=btnAddNewCompany]").show();
            ClearControls();
        });

        $("[id*=btnAddNewCompany]").on('click', function () {
            $("[id*=divCompList]").hide();
            $("[id*=dvCompDetails]").show();
            $("[id*=btnSave]").show();
            $("[id*=btnCancel]").show();
            $("[id*=btnAddNewCompany]").hide();

            ClearControls();
        });

        $("[id*=btnSave]").on('click', function () {
            var isValid = ValidateCompanyForm();

            if (!isValid)
                return false;

            // var isTanValid = ValidateTAN();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../TDS/BTStrp/handler/Company.asmx/CheckTanNoExists",
                dataType: "json",
                data: '{compId:' + $("[id*=hdnCompanyid]").val() + ', tanNo:"' + $("[id*=txtTAN]").val() + '"}',
                success: function (msg) {
                    var data = jQuery.parseJSON(msg.d);
                    if (msg.d == 'true') {
                        showWarningAlert("TAN No exists already");
                        return false;
                    }
                    else
                        SaveCompany();
                },
                failure: function (response) {
                    showDangerAlert(response.responseText);
                },
                error: function (response) {
                    showDangerAlert(response.responseText);
                }
            });

        });

        $('#txtTAN').on('keyup', function () {
            // Get the input value
            var inputValue = $(this).val();

            // Convert the input value to uppercase
            var uppercaseValue = inputValue.toUpperCase();

            // Set the input value to the uppercase version
            $(this).val(uppercaseValue);
        });

        $('#txtPAN').on('keyup', function () {
            // Get the input value
            var inputValue = $(this).val();

            // Convert the input value to uppercase
            var uppercaseValue = inputValue.toUpperCase();

            // Set the input value to the uppercase version
            $(this).val(uppercaseValue);
        });

        $('#txtGSTIN').on('keyup', function () {
            // Get the input value
            var inputValue = $(this).val();

            // Convert the input value to uppercase
            var uppercaseValue = inputValue.toUpperCase();

            // Set the input value to the uppercase version
            $(this).val(uppercaseValue);
        });

        $('#txtResPAN').on('keyup', function () {
            // Get the input value
            var inputValue = $(this).val();

            // Convert the input value to uppercase
            var uppercaseValue = inputValue.toUpperCase();

            // Set the input value to the uppercase version
            $(this).val(uppercaseValue);
        });

        $('#ChkCompDet').on('click', function () {
            if ($(this).prop('checked')) {
                $('#txtResFlat').val($('#txtFlat').val());
                $('#txtResBuild').val($('#txtBuild').val());
                $('#txtResRoad').val($('#txtRoad').val());
                $('#txtResArea').val($('#txtArea').val());
                $('#txtResTown').val($('#txtTown').val());
                $('#txtResEmail').val($('#txtEmail').val());
                $('#drpResState').val($('#drpState').val());
                $('#drpResState').trigger('change');
                $('#txtResPin').val($('#txtPin').val());
                $('#txtResStd').val($('#txtStd').val());
                $('#txtResPhone').val($('#txtPhone').val());
                $('#txtResAltEmail').val($('#txtAltEmail').val());
                $('#txtResAltPhone').val($('#txtAltPhone').val());
                $('#txtResAltStd').val($('#txtAltStd').val());

            } else {
                $('#txtResFlat').val("");
                $('#txtResBuild').val("");
                $('#txtResRoad').val("");
                $('#txtResArea').val("");
                $('#txtResTown').val("");
                $('#txtResEmail').val("");
                $('#drpResState').val(0);
                $('#drpResState').trigger('change');
                $('#txtResPin').val("");
                $('#txtResStd').val("");
                $('#txtResPhone').val("");
                $('#txtResAltEmail').val("");
                $('#txtResAltPhone').val("");
                $('#txtResAltStd').val("");
            }
        });
    });

    function SaveCompany() {
        var companyData = {};
        companyData.Company_ID = $("[id*=hdnCompanyid]").val();
        companyData.CompanyName = $('#txtCompName').val();
        companyData.Flat_No = $('#txtFlat').val();
        companyData.Name_Of_Building = $('#txtBuild').val();
        companyData.Street = $('#txtRoad').val();
        companyData.Area_Location = $('#txtArea').val();
        companyData.Town_City = $('#txtTown').val();
        companyData.EmailID = $('#txtEmail').val();
        companyData.Status = $('#drpDedType option:selected').text()
        companyData.IClass = $('#drpIClass').val();
        companyData.Pincode = $('#txtPin').val();
        companyData.STD_code = $('#txtStd').val();
        companyData.Tel_NO = $('#txtPhone').val();
        //companyData.CUserName = $('#txtTaxUser').val();
        //companyData.CPassword = $('#txtTaxPass').val();
        companyData.TANNo = $('#txtTAN').val();
        companyData.PANNo = $('#txtPAN').val();
        companyData.StateID = $('#drpState').val();
        companyData.Alt_EmailID = $('#txtAltEmail').val();
        companyData.Alt_Tel_NO = $('#txtAltPhone').val();
        companyData.Alt_STDcode = $('#txtAltStd').val();
        companyData.R_Name = $('#txtResName').val();
        companyData.R_Flat_NO = $('#txtResFlat').val();
        companyData.R_Building = $('#txtResBuild').val();
        companyData.R_Street = $('#txtResRoad').val();
        companyData.R_Area_Location = $('#txtResArea').val();
        companyData.R_Town_City = $('#txtResTown').val();
        companyData.R_EmailID = $('#txtResEmail').val();
        companyData.R_Designation = $('#txtResDesg').val();
        companyData.R_StateID = $('#drpResState').val();
        companyData.R_Mobile_NO = $('#txtMobNo').val();
        companyData.R_Pincode = $('#txtResPin').val();
        companyData.R_STD_Code = $('#txtResStd').val();
        companyData.R_Tel_NO = $('#txtResPhone').val();
        companyData.ALT_R_EmailID = $('#txtResAltEmail').val();
        companyData.ALT_R_Tel_NO = $('#txtAltPhone').val();
        companyData.ALT_R_STD_Code = $('#txtAltStd').val();
        companyData.IsApproved = true;
        companyData.StateID = $('#drpState').val();
        companyData.Co_Branch = $('#txtBranch').val();
        companyData.GSTN = $('#txtGSTIN').val();
        companyData.ContactPersonPAN = $('#txtResPAN').val();

        var tracesData = {};
        tracesData.Userid = $('#txtTraceUser').val();
        tracesData.Password = $('#txtTracePass').val();

        var incomeTaxData = {};
        incomeTaxData.IUser = $('#txtTaxUser').val();
        incomeTaxData.IPass = $('#txtTaxPass').val();

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../handler/Company.asmx/InsertCompany",
            data: JSON.stringify({ "companyMaster": companyData, "tracesDetail": tracesData, "incomeTaxDetail": incomeTaxData }),
            dataType: "json",
            success: function (msg) {
                var compId = msg.d;
                if (companyData.Company_ID > 0) {
                    showSuccessAlert('Updated Successfully!!!');
                }
                else {
                    showSuccessAlert('Added Successfully!!!');
                }
                $("[id*=divCompList]").show();
                $("[id*=dvCompDetails]").hide();
                $("[id*=btnSave]").hide();
                $("[id*=btnCancel]").hide();
                $("[id*=btnAddNewCompany]").show();
                PopulateCompanyList(0, 25);
            },
            failure: function (response) {
                showDangerAlert(response.responseText);
            },
            error: function (response) {
                showDangerAlert(response.responseText);
            }
        });

    }

    function View_EditCompany(compId) {
        $("[id*=divCompList]").hide();
        $("[id*=dvCompDetails]").show();

        if (compId > 0) {
            $("[id*=hdnCompanyid]").val(compId);
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../handler/Company.asmx/GetCompanyDeatilsById",
                dataType: "json",
                data: '{compId:' + compId + ', parentCompId:' + 0 + '}',
                success: function (msg) {
                    var companyDetails = jQuery.parseJSON(msg.d);
                    BindCompanyDetails(companyDetails);
                    $("[id*=btnSave]").show();
                    $("[id*=btnCancel]").show();
                    $("[id*=btnAddNewCompany]").hide();
                },
                failure: function (response) {
                    showDangerAlert(response.responseText);
                },
                error: function (response) {
                    showDangerAlert(response.responseText);
                }
            });
        }
    }

    function ClearControls() {
        $("[id*=hdnCompanyid]").val();
        $('#txtCompName').val("");
        $('#txtFlat').val("");
        $('#txtBuild').val("");
        $('#txtRoad').val("");
        $('#txtArea').val("");
        $('#txtTown').val("");
        $('#txtEmail').val("");
        $("#drpDedType").val(0);
        $('#drpDedType').trigger('change');
        $('#drpIClass').val(0);
        $('#drpIClass').trigger('change');
        $('#txtPin').val("");
        $('#txtStd').val("");
        $('#txtPhone').val("");
        $('#txtTaxUser').val("");
        $('#txtTaxPass').val("");
        $('#txtTAN').val("");
        $('#drpState').val(0);
        $('#drpState').trigger('change');
        $('#txtAltEmail').val("");
        $('#txtAltPhone').val("");
        $('#txtAltStd').val("");
        $('#txtResName').val("");
        $('#txtResFlat').val("");
        $('#txtResBuild').val("");
        $('#txtResRoad').val("");
        $('#txtResArea').val("");
        $('#txtResTown').val("");
        $('#txtResEmail').val("");
        $('#txtResDesg').val("");
        $('#drpResState').val(0);
        $('#drpResState').trigger('change');
        $('#txtMobNo').val("");
        $('#txtResPin').val("");
        $('#txtResStd').val("");
        $('#txtResPhone').val("");
        $('#txtResAltEmail').val("");
        $('#txtResAltPhone').val("");
        $('#txtResAltStd').val("");
        //companyData.Parent_Company_ID = $('#txtCompName').val(); // TODO: Check with Komal
        $('#txtBranch').val("");
        $('#txtResPAN').val("");
        $('#txtGSTIN').val("");
        $('#txtTraceUser').val("");
        $('#txtTracePass').val("");
        $('#txtTaxUser').val("");
        $('#txtTaxPass').val("");
    }

    function BindCompanyDetails(companyData) {
        if (companyData != null && companyData != undefined) {
            $('#txtCompName').val(companyData.CompanyName);
            $('#txtFlat').val(companyData.Flat_No);
            $('#txtBuild').val(companyData.Name_Of_Building);
            $('#txtRoad').val(companyData.Street);
            $('#txtArea').val(companyData.Area_Location);
            $('#txtTown').val(companyData.Town_City);
            $('#txtEmail').val(companyData.EmailID);
            if (companyData.Status != null && companyData.Status != undefined && companyData.Status != "") {
                $("#drpDedType").val(companyData.Status);
                $('#drpDedType').trigger('change');
            }

            if (companyData.IClass != null && companyData.IClass != undefined && companyData.IClass != "") {
                $('#drpIClass').val(companyData.IClass);
                $('#drpIClass').trigger('change');
            }
            $('#txtPin').val(companyData.Pincode);
            $('#txtStd').val(companyData.STD_code);
            $('#txtPhone').val(companyData.Tel_NO);
            $('#txtTaxUser').val(companyData.CUserName);
            $('#txtTaxPass').val(companyData.CPassword);
            $('#txtTAN').val(companyData.TANNo);
            $('#txtPAN').val(companyData.PANNo);
            $('#drpState').val(companyData.StateID);
            $('#drpState').trigger('change');
            $('#txtAltEmail').val(companyData.Alt_EmailID);
            $('#txtAltPhone').val(companyData.Alt_Tel_NO);
            $('#txtAltStd').val(companyData.Alt_STDcode);
            $('#txtResName').val(companyData.R_Name);
            $('#txtResFlat').val(companyData.R_Flat_NO);
            $('#txtResBuild').val(companyData.R_Building);
            $('#txtResRoad').val(companyData.R_Street);
            $('#txtResArea').val(companyData.R_Area_Location);
            $('#txtResTown').val(companyData.R_Town_City);
            $('#txtResEmail').val(companyData.R_EmailID);
            $('#txtResDesg').val(companyData.R_Designation);
            $('#drpResState').val(companyData.R_StateID);
            $('#drpResState').trigger('change');
            $('#txtMobNo').val(companyData.R_Mobile_NO);
            $('#txtResPin').val(companyData.R_Pincode);
            $('#txtResStd').val(companyData.R_STD_Code);
            $('#txtResPhone').val(companyData.R_Tel_NO);
            $('#txtResAltEmail').val(companyData.ALT_R_EmailID);
            $('#txtResAltPhone').val(companyData.ALT_R_Tel_NO);
            $('#txtResAltStd').val(companyData.ALT_R_STD_Code);
            $('#txtBranch').val(companyData.Co_Branch);
            $('#txtResPAN').val(companyData.ContactPersonPAN);
            $('#txtGSTIN').val(companyData.GSTN);
            $('#txtTraceUser').val(companyData.TraceUserName);
            $('#txtTracePass').val(companyData.TracePassword);
            $('#txtTaxUser').val(companyData.IncomeTaxUserName);
            $('#txtTaxPass').val(companyData.IncomeTaxPassword);
        }
    }

    function BindStates() {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../TDS/BTStrp/handler/Company.asmx/GetStates",
            dataType: "json",
            success: function (msg) {
                var statesList = jQuery.parseJSON(msg.d);

                if (statesList != null && statesList != undefined) {
                    $("[id*=drpState]").empty();
                    $("[id*=drpState]").append("<option value='0'>--Select State--</option>");
                    for (var i = 0; i < statesList.length; i++) {
                        $("[id*=drpState]").append("<option value='" + statesList[i].State_Id + "'>" + statesList[i].StateName + "</option>");
                    }

                    $("[id*=drpResState]").empty();
                    $("[id*=drpResState]").append("<option value='0'>--Select State--</option>");
                    for (var i = 0; i < statesList.length; i++) {
                        $("[id*=drpResState]").append("<option value='" + statesList[i].State_Id + "'>" + statesList[i].StateName + "</option>");
                    }
                }
            },
            failure: function (response) {
                showDangerAlert(response.responseText);
            },
            error: function (response) {
                showDangerAlert(response.responseText);
            }
        });
    }

    function PopulateCompanyList(pageIndex, pageSize) {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../TDS/BTStrp/handler/Company.asmx/GetCompanyList",
            data: '{ parentCompId:"' + 0 + '", pageIndex:"' + pageIndex + '", pageSize:"' + pageSize + '" }',
            dataType: "json",
            success: function (msg) {
                var companyList = jQuery.parseJSON(msg.d);
                BindCompanyList(companyList);
            },
            failure: function (response) {
                showDangerAlert(response.responseText);
            },
            error: function (response) {
                showDangerAlert(response.responseText);
            }
        });
    }

    function BindCompanyList(companyList) {
        Blockloadershow();
        var tbl = "";
        $("#tblCompanyList tbody").empty();
        $("#tblCompanyList thead").empty();
        $("[id*=tblCompanyList] tr").remove();

        tbl = tbl + "<thead><tr style='background:#dcdcdc;'>";

        tbl = tbl + "<th class='labelChange' style='font-weight: bold; padding-left:5px; padding-right:5px;'>Sr.No </th>";
        tbl = tbl + "<th class='labelChange' style='font-weight: bold; padding-left:5px; padding-right:5px;'>Name </th>";
        tbl = tbl + "<th class='labelChange' style='font-weight: bold; padding-left:5px; padding-right:5px;'>TAN</th>";
        tbl = tbl + "<th class='labelChange' style='font-weight: bold; padding-left:5px; padding-right:5px;'>PAN</th>";
        tbl = tbl + "<th class='labelChange' style='font-weight: bold; padding-left:5px; padding-right:5px;'>Traces UserName</th>";
        tbl = tbl + "<th class='labelChange' style='font-weight: bold; padding-left:5px; padding-right:5px;'>Traces Password</th>";
        tbl = tbl + "</tr></thead>";
        $("[id*=tblCompanyList]").append(tbl);
        tbl = '';

        if (companyList != null && companyList.length > 0) {
            for (var i = 0; i < companyList.length; i++) {
                var row = companyList[i];
                tbl = tbl + "<tr>";
                tbl = tbl + "<td style='text-align: centre; padding-left:5px; padding-right:5px;'>" + (i + 1).toString() + "</td>";
                tbl = tbl + "<td style='text-align: left; padding-left:5px; padding-right:5px;'><a href='#' onclick='View_EditCompany(" + row.Company_ID + ");' >" + row.CompanyName + "</a></td>";
                tbl = tbl + "<td style='text-align: left; padding-left:5px; padding-right:5px;'>" + row.TANNo + "</td>";
                tbl = tbl + "<td style='text-align: left; padding-left:5px; padding-right:5px;'>" + row.PANNo + "</td>";
                tbl = tbl + "<td style='text-align: left; padding-left:5px; padding-right:5px;'>" + row.TracesUserName + "</td> ";
                tbl = tbl + "<td style='text-align: left; padding-left:5px; padding-right:5px;'>" + row.TracesPassword + "</td>";
                tbl = tbl + "</tr>";
                tc = row.Totalcount;
            }

            $("[id*=tblCompanyList]").append(tbl);
            //if (parseFloat(tc) > 0) {
            //    if (parseInt(tc) > parseInt($("[id*=drpPageSize]").val())) {
            //        RecordCount = parseFloat(tc);
            //    } else {
            //        RecordCount = 0;
            //    }
            //}
            //Pager(RecordCount);
        }
        else {
            tbl = tbl + "<tr>";
            tbl = tbl + "<td colspan='4'>No Record Found !!!</td>";
            tbl = tbl + "</tr>";
            $("#tblCompanyList").append(tbl);
        }
        Blockloaderhide();
    }

    function ValidateCompanyForm() {
        //comapny name  special chars not allowed
        var inputValue = $('#txtCompName').val();
        var regex = /^[a-zA-Z0-9\s]+$/;

        //TAN validation 
        var tanValue = $('#txtTAN').val();
        var tanRegex = /^[A-Z]{4}[0-9]{5}[A-Z]$/;

        //PAN validation 
        var panValue = $('#txtPAN').val();
        var panRegex = /[A-Z]{5}[0-9]{4}[A-Z]{1}$/;

        if (inputValue == "") {
            showWarningAlert('Please enter company name');
            return false;
        }

        if (tanValue == "") {
            showWarningAlert('Please enter Tan No');
            return false;
        }

        if (panValue == "") {
            showWarningAlert('Please enter Pan No for company');
            return false;
        }

        //GSTIN 
        var gstinValue = $('#txtGSTIN').val();
        //if (gstinValue != "GSTNOTAVAILABLE") {
        //    showWarningAlert('Please enter GSTN IN');
        //    return false;
        //}

        if ($('#drpDedType').val() == 0) {
            showWarningAlert('Please select deductor type');
            return false;
        }
        if ($('#drpIClass').val() == 0) {
            showWarningAlert('Please select class');
            return false;
        }

        if ($('#txtFlat').val() == "") {
            showWarningAlert('Please enter flat no');
            return false;
        }

        if ($('#txtPin').val() == "") {
            showWarningAlert('Please enter pin no');
            return false;
        }

        if ($('#drpState').val() == 0) {
            showWarningAlert('Please select state');
            return false;
        }

        if ($('#txtEmail').val() == "") {
            showWarningAlert('Please enter email');
            return false;
        }

        if ($('#txtResName').val() == "") {
            showWarningAlert('Please enter responsible person name');
            return false;
        }

        if ($('#txtResDesg').val() == "") {
            showWarningAlert('Please enter responsible person designation');
            return false;
        }

        if ($('#txtMobNo').val() == "") {
            showWarningAlert('Please enter responsible person mobile no');
            return false;
        }

        if ($('#txtResPAN').val() == "") {
            showWarningAlert('Please enter Pan No for responsible person');
            return false;
        }

        if (((!regex.test(inputValue)) && (inputValue != ""))
            && ((!regex.test($('#txtBranch').val())) && ($('#txtBranch').val() != ""))
            && ((!regex.test($('#txtFlat').val())) && ($('#txtFlat').val() != ""))
            && ((!regex.test($('#txtBuild').val())) && ($('#txtBuild').val() != ""))
            && ((!regex.test($('#txtRoad').val())) && ($('#txtBuild').val() != ""))
            && ((!regex.test($('#txtArea').val())) && ($('#txtBuild').val() != ""))
            && ((!regex.test($('#txtTown').val())) && ($('#txtBuild').val() != ""))
            && ((!regex.test($('#txtResFlat').val())) && ($('#txtBuild').val() != ""))
            && ((!regex.test($('#txtResBuild').val())) && ($('#txtBuild').val() != ""))
            && ((!regex.test($('#txtResRoad').val())) && ($('#txtBuild').val() != ""))
            && ((!regex.test($('#txtResArea').val())) && ($('#txtBuild').val() != ""))
            && ((!regex.test($('#txtResTown').val())) && ($('#txtBuild').val() != ""))) {
            showWarningAlert('Special characters are not allowed. Please enter only letters, numbers, and spaces for branch, flat, building, road, area, town');
            return false;
        }

        if (!tanRegex.test(tanValue)) {
            showWarningAlert('Invalid TAN Number. Please enter a valid TAN Number.');
            return false;
        }

        if (!panRegex.test(panValue)) {
            showWarningAlert('Invalid PAN Number. Please enter a valid PAN Number.');
            return false;
        }

        var resPanValue = $('#txtResPAN').val();
        if (!panRegex.test(resPanValue)) {
            showWarningAlert('Invalid Responsible Person PAN Number. Please enter a valid PAN Number.');
            return false;
        }

        // Regular expression for email validation
        var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test($('#txtEmail').val())) {
            showWarningAlert('Invalid Email. Please enter a valid GSTIN.');
            return false;
        }

        // GSTIN Validation Regular Expression
        var gstinRegex = /^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}[Z]{1}[0-9A-Z]{1}$/;

        if ((!gstinRegex.test(gstinValue)) && gstinValue != "GSTNOTAVAILABLE") {
            showWarningAlert('Invalid GSTIN. Please enter a valid GSTIN. or please enter GSTNOTAVAILABLE');
            return false;
        }

        var intRegex = /^\d+$/;
        var pinText = $('#txtPin').val();
        var rpinText = $('#txtResPin').val();
        if (((!intRegex.test(pinText) && pinText != "")) && ((!intRegex.test(rpinText) && rpinText != ""))
            && ((!intRegex.test($('#txtStd').val())) && $('#txtStd').val() != "")
            && ((!intRegex.test($('#txtAltStd').val())) && $('#txtAltStd').val() != "")
            && ((!intRegex.test($('#txtResStd').val())) && $('#txtResStd').val() != "")
            && ((!intRegex.test($('#txtResAltStd').val())) && $('#txtResAltStd').val() != "")
            && ((!!intRegex.test($('#txtPhone').val())) && $('#txtPhone').val() != "")
            && ((!intRegex.test($('#txtAltPhone').val())) && $('#txtAltPhone').val() != "")
            && ((!intRegex.test($('#txtResPhone').val())) && $('#txtResPhone').val() != "")
            && ((!intRegex.test($('#txtResAltPhone').val())) && ('#txtResAltPhone').val())) {
            showWarningAlert('Invalid only intergers in PIN Or STD Or Phone No');
            return false;
        }

        return true;
    }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:HiddenField ID="hdnCompanyid" runat="server" Value="0" />

    <div class="row" style="height: 10px;"></div>
    <div class="content">
        <div class="card">
            <div class="content-header">
                <div class="container-fluid" style="padding-top: 0px;">
                    <div class="row" style="align-items: center;">
                        <div class="col-sm-2">
                            <h5><span style="font-size: x-large;">Company Details</span></h5>
                        </div>
                        <div style="margin-left: auto; padding-bottom: 7px;">
                            <button id="btnAddNewCompany" name="btnAddNewCompany" class="btn btn-outline-success" data-toggle="tooltip" title="Add Company" type="button"><i class="fas fa-plus mr-1 fa-1x"></i>Add</button>
                        </div>
                        <div style="margin-left: auto; padding-bottom: 7px;">
                            <button id="btnSave" name="btnSave" class="btn btn-outline-success legitRipple" type="button"><b><i class="far fa-save mr-1 fa-1x"></i></b>Save</button>
                            <button id="btnCancel" name="btnCancel" class="btn btn-outline-success legitRipple" type="button"><b><i class="icon-cross3 mr-1 icon-1x"></i></b>Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="dvCompDetails">
            <div class="row">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body" style="padding-top: 0px;">

                            <div class="form-group row" style="height: 25px;">
                                <div class="col-lg-1.5" style="padding-left: 0px; padding-top: 15px;">
                                    <label class="col-form-label ">Company Name</label>
                                </div>
                                <div style="padding-top: 15px; margin-left: 18px;">:</div>
                                <div class="col-lg-8">
                                    <input id="txtCompName" type="text" class="form-control form-control-border" maxlength="75" />
                                </div>
                            </div>

                            <div class="form-group row" style="height: 25px;">
                                <div class="col-lg-1" style="padding-left: 0px; padding-top: 15px;">
                                    <label class="col-form-label ">TAN</label>
                                </div>
                                <div style="padding-top: 15px; margin-left: 73px;">:</div>
                                <div class="col-lg-4">
                                    <input id="txtTAN" type="text" class="form-control form-control-border" maxlength="10" />
                                </div>
                            </div>

                            <div class="form-group row" style="height: 25px;">
                                <div class="col-lg-1" style="padding-left: 0px; padding-top: 15px;">
                                    <label class="col-form-label ">PAN</label>
                                </div>
                                <div style="padding-top: 15px; margin-left: 73px;">:</div>
                                <div class="col-lg-4">
                                    <input id="txtPAN" type="text" class="form-control form-control-border"  maxlength="10"/>
                                </div>
                            </div>

                            <div class="form-group row" style="height: 25px;">
                                <div class="col-lg-1" style="padding-left: 0px; padding-top: 15px;">
                                    <label class="col-form-label ">GSTIN</label>
                                </div>
                                <div style="padding-top: 15px; margin-left: 73px;">:</div>
                                <div class="col-lg-4">
                                    <input id="txtGSTIN" type="text" class="form-control form-control-border" maxlength="15" />
                                </div>
                            </div>

                            <div class="form-group row" style="height: 25px;">
                                <div class="col-lg-1" style="padding-left: 0px; padding-top: 15px;">
                                    <label class="col-form-label ">Branch</label>
                                </div>
                                <div style="padding-top: 15px; margin-left: 73px;">:</div>
                                <div class="col-lg-4">
                                    <input id="txtBranch" type="text" class="form-control form-control-border" maxlength="75" />
                                </div>
                            </div>

                            <div class="form-group row" style="height: 25px;">
                                <div class="col-lg-1.5" style="padding-left: 0px; padding-top: 15px;">
                                    <label class="col-form-label ">Deductor Type</label>
                                </div>
                                <div style="padding-top: 15px; margin-left: 24px;">:</div>
                                <div class="col-lg-5">
                                    <select id="drpDedType" name="drpDedType" class="form-control select-search">
                                        <option value="0">Select</option>
                                        <option value="A Central Government">A Central Government</option>
                                        <option value="B Body of Individuals">B Body of Individuals</option>
                                        <option value="D Statutory body (Central Govt.)">D Statutory body (Central Govt.)</option>
                                        <option value="E Statutory body (State Govt.)">E Statutory body (State Govt.)</option>
                                        <option value="F Firm">F - Firm</option>
                                        <option value="G Autonomous body (Central Govt.)">G Autonomous body (Central Govt.)</option>
                                        <option value="H Autonomous body (State Govt.)">H Autonomous body (State Govt.)</option>
                                        <option value="J Artificial Juridical Person">J Artificial Juridical Person</option>
                                        <option value="K Company">K - Company</option>
                                        <option value="L Local Authority (Central Govt.)">L Local Authority (Central Govt.)</option>
                                        <option value="M Branch / Division of Company">M Branch / Division of Company</option>
                                        <option value="N Local Authority (State Govt.)">N Local Authority (State Govt.)</option>
                                        <option value="P Association of Person (AOP)">P Association of Person (AOP)</option>
                                        <option value="Q Individual/HUF">Q Individual/HUF</option>
                                        <option value="S State Government">S State Government</option>
                                        <option value="T Association of Person (Trust)">T Association of Person (Trust)</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group row" style="height: 25px;">
                                <div class="col-lg-1.5" style="padding-left: 0px; padding-top: 15px;">
                                    <label class="col-form-label ">Class</label>
                                </div>
                                <div style="padding-top: 15px; margin-left: 24px;">:</div>
                                <div class="col-lg-5">
                                    <select name="drpIClass" id="drpIClass" class="form-control select-search">
                                        <option selected="selected" value="0">Select</option>
                                        <option value="01 Central Govt. / Union Territory">01 Central Govt. / Union Territory</option>
                                        <option value="02 State Goverment">02 State Goverment</option>
                                        <option value="03 Local Authority">03 Local Authority</option>
                                        <option value="04 Central Govt. Co. / Corp.Estb.Central Act">04 Central Govt. Co. / Corp.Estb.Central Act</option>
                                        <option value="05 State Govt. Co. / Corp.Estb. by State">05 State Govt. Co. / Corp.Estb. by State</option>
                                        <option value="06 Other Company">06 Other Company</option>
                                        <option value="07 Firm">07 Firm</option>
                                        <option value="08 Individual">08 Individual</option>
                                        <option value="09 Others">09 Others</option>
                                        <option value="10 Commission &amp; Progress">10 Commission &amp; Progress</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body" style="padding-top: 0px;">
                            <div class="card-header" style="padding-left: 0px; padding-top: 5px; padding-bottom: 0px;">
                                <%--<div class="card-title">
                                    <h5 class="col-form-label" style="font-size: x-large;">Traces Login Details</h5>
                                </div>--%>
                                <div class="row" style="margin-top: 0px;">
                                    <div class="">
                                        <img src="../../Images/tds-logo.png" alt="Logo" style="max-height: 35px;" />
                                    </div>
                                </div>
                            </div>

                            <div class="form-group row" style="height: 25px;">
                                <div class="col-lg-2" style="padding-left: 0px; padding-top: 15px;">
                                    <label class="col-form-label ">User Name</label>
                                </div>
                                <div style="padding-top: 15px; margin-left: 45px;">:</div>
                                <div class="col-lg-4">
                                    <input id="txtTraceUser" type="text" class="form-control form-control-border" />
                                </div>
                            </div>

                            <div class="form-group row" style="height: 25px;">
                                <div class="col-lg-2" style="padding-left: 0px; padding-top: 15px;">
                                    <label class="col-form-label ">Password</label>
                                </div>
                                <div style="padding-top: 15px; margin-left: 45px;">:</div>
                                <div class="col-lg-4">
                                    <input id="txtTracePass" type="text" class="form-control form-control-border" />
                                </div>
                            </div>
                            <div class="card-header" style="padding-left: 0px; padding-top: 5px; padding-bottom: 2px;">
                                <%--<div class="card-title">
                                    <h5 class="col-form-label" style="font-size: x-large;">Income Tax Login Details</h5>
                                </div>--%>
                                <div class="row" style="margin-top: 0px;">
                                    <div class="">
                                        <img src="../../Images/efiling_logo.svg" alt="Logo" style="max-height: 35px;" />
                                    </div>
                                </div>
                            </div>

                            <div class="form-group row" style="height: 25px;">
                                <div class="col-lg-2" style="padding-left: 0px; padding-top: 15px;">
                                    <label class="col-form-label ">User Name</label>
                                </div>
                                <div style="padding-top: 15px; margin-left: 45px;">:</div>
                                <div class="col-lg-4">
                                    <input id="txtTaxUser" type="text" class="form-control form-control-border" />
                                </div>
                            </div>

                            <div class="form-group row" style="height: 25px;">
                                <div class="col-lg-2" style="padding-left: 0px; padding-top: 15px;">
                                    <label class="col-form-label ">Password</label>
                                </div>
                                <div style="padding-top: 15px; margin-left: 45px;">:</div>
                                <div class="col-lg-4">
                                    <input id="txtTaxPass" type="text" class="form-control form-control-border" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-body">
                    <div class="card-header" style="padding-left: 0px; padding-top: 0px; padding-bottom: 0px;">
                        <div class="card-title">
                            <h5 class="col-form-label" style="font-size: x-large;">Company Contact Details</h5>
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">Flat No</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 20px;">:</div>
                        <div class="col-lg-2">
                            <input id="txtFlat" type="text" class="form-control form-control-border" maxlength="25" />
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">Building</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 20px;">:</div>
                        <div class="col-lg-3">
                            <input id="txtBuild" type="text" class="form-control form-control-border" maxlength="25" />
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">Road / Street</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 20px;">:</div>
                        <div class="col-lg-3">
                            <input id="txtRoad" type="text" class="form-control form-control-border" maxlength="25" />
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1.5" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">Area / Locality</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 26px;">:</div>
                        <div class="col-lg-3">
                            <input id="txtArea" type="text" class="form-control form-control-border" maxlength="25" />
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1.5" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">Town / District</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 26px;">:</div>
                        <div class="col-lg-3">
                            <input id="txtTown" type="text" class="form-control form-control-border" maxlength="25" />
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">PIN</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 20px;">:</div>
                        <div class="col-lg-1">
                            <input id="txtPin" type="text" class="form-control form-control-border" maxlength="6"/>
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">State</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 20px;">:</div>
                        <div class="col-lg-2">
                            <select id="drpState" name="drpState" class="form-control select-search">
                                <option value="0">Select</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">STD</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 20px;">:</div>
                        <div class="col-lg-1">
                            <input id="txtStd" type="text" class="form-control form-control-border" maxlength="5"/>
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">Phone No</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 20px;">:</div>
                        <div class="col-lg-2">
                            <input id="txtPhone" type="text" class="form-control form-control-border"  maxlength="10"/>
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">Alternate STD</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 20px;">:</div>
                        <div class="col-lg-1">
                            <input id="txtAltStd" type="text" class="form-control form-control-border" maxlength="5"/>
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1.5" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">Alternate Phone</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 16px;">:</div>
                        <div class="col-lg-2">
                            <input id="txtAltPhone" type="text" class="form-control form-control-border" maxlength="10" />
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">Email</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 20px;">:</div>
                        <div class="col-lg-3">
                            <input id="txtEmail" type="text" class="form-control form-control-border" />
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1.5" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">Alternate Email</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 20px;">:</div>
                        <div class="col-lg-3">
                            <input id="txtAltEmail" type="text" class="form-control form-control-border" />
                        </div>
                    </div>

                </div>
            </div>

            <div class="card">
                <div class="card-body">
                    <div class="card-header" style="padding-left: 0px; padding-top: 0px; padding-bottom: 0px;">
                        <div class="card-title">
                            <h5 class="col-form-label" style="font-size: x-large;">Responsible Person Details</h5>
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1.5" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">Name</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 75px;">:</div>
                        <div class="col-lg-3">
                            <input id="txtResName" type="text" class="form-control form-control-border" maxlength="75" />
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1.5" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">Designation</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 33px;">:</div>
                        <div class="col-lg-2">
                            <input id="txtResDesg" type="text" class="form-control form-control-border" maxlength="20"/>
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1.5" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">Father's Name</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 17px;">:</div>
                        <div class="col-lg-3">
                            <input id="txtFathereName" type="text" class="form-control form-control-border" />
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1.5" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">Mobile No</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 43px;">:</div>
                        <div class="col-lg-2">
                            <input id="txtMobNo" type="text" class="form-control form-control-border" maxlength="10" />
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1.5" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">PAN</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 81px;">:</div>
                        <div class="col-lg-2">
                            <input id="txtResPAN" type="text" class="form-control form-control-border"  maxlength="10"/>
                        </div>
                    </div>

                </div>
            </div>

            <div class="card" id="crdResperDet">
                <div class="card-body">
                    <div class="card-header" style="padding-left: 0px; padding-top: 0px; padding-bottom: 0px;">
                        <div class="card-title">
                            <h5 class="col-form-label" style="font-size: x-large;">Responsible Person Contact Details</h5>
                        </div>
                    </div>

                    <div class="form-group row" style="padding-top: 10px; height: 15px;">
                        <div class="col-lg-0.5" style="padding-top: 6px;">
                            <input type="checkbox" id="ChkCompDet" name="ChkCompDet" class="Chkbox" />
                        </div>
                        <label class="col-lg-6 col-form-label">Copy Company Details</label>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">Flat No</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 20px;">:</div>
                        <div class="col-lg-2">
                            <input id="txtResFlat" type="text" class="form-control form-control-border" maxlength="25" />
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">Building</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 20px;">:</div>
                        <div class="col-lg-3">
                            <input id="txtResBuild" type="text" class="form-control form-control-border" maxlength="25" />
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">Road / Street</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 20px;">:</div>
                        <div class="col-lg-3">
                            <input id="txtResRoad" type="text" class="form-control form-control-border" maxlength="25" />
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1.5" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">Area / Locality</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 26px;">:</div>
                        <div class="col-lg-3">
                            <input id="txtResArea" type="text" class="form-control form-control-border" maxlength="25" />
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1.5" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">Town / District</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 26px;">:</div>
                        <div class="col-lg-3">
                            <input id="txtResTown" type="text" class="form-control form-control-border" maxlength="25" />
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">PIN</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 20px;">:</div>
                        <div class="col-lg-1">
                            <input id="txtResPin" type="text" class="form-control form-control-border" />
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">State</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 20px;">:</div>
                        <div class="col-lg-2">
                            <select id="drpResState" name="drpResState" class="form-control select-search">
                                <option value="0">Select</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">STD</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 20px;">:</div>
                        <div class="col-lg-1">
                            <input id="txtResStd" type="text" class="form-control form-control-border" maxlength="5" />
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">Phone No</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 20px;">:</div>
                        <div class="col-lg-2">
                            <input id="txtResPhone" type="text" class="form-control form-control-border" maxlength="10" />
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">Alternate STD</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 20px;">:</div>
                        <div class="col-lg-1">
                            <input id="txtResAltStd" type="text" class="form-control form-control-border" maxlength="5" />
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1.5" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">Alternate Phone</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 16px;">:</div>
                        <div class="col-lg-2">
                            <input id="txtResAltPhone" type="text" class="form-control form-control-border"  maxlength="10"/>
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">Email</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 20px;">:</div>
                        <div class="col-lg-3">
                            <input id="txtResEmail" type="text" class="form-control form-control-border" />
                        </div>
                    </div>

                    <div class="form-group row" style="height: 25px;">
                        <div class="col-lg-1.5" style="padding-left: 0px; padding-top: 15px;">
                            <label class="col-form-label ">Alternate Email</label>
                        </div>
                        <div style="padding-top: 15px; margin-left: 20px;">:</div>
                        <div class="col-lg-3">
                            <input id="txtResAltEmail" type="text" class="form-control form-control-border" />
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div id="divCompList">
            <div class="card">
                <div class="table-responsive">
                    <table id="tblCompanyList" class="table table-hover table-xs font-size-base"></table>
                    <table id="tblPager" style="border: 1px solid #BCBCBC; height: 50px; width: 100%">
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

    </div>
</asp:Content>

