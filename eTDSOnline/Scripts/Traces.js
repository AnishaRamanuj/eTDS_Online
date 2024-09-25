/// <reference path="../Script/jquery.min.js" />
/// <reference path="../Script/angular.min.js" />

$(document).ready(function () {
    $('#txtDate').datetimepicker({
        format: 'DD/MM/YYYY',
        useCurrent: false
    })
});


(function () {


    function getParameterByName(name) {
        name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
        var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
        return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
    }

    var SessionLogoutDialog = function () {

        // Show confirm Message
        bootbox.dialog({
            closeButton: false,
            message: J_Message.__Session_Timeout,
            title: J_Message.__ProjectTitle,
            buttons: {
                Yes: {
                    label: "Close",
                    className: "btn btn-primary ",
                    callback: function () {
                        window.location = "../Login.aspx";
                    }
                }
            }
        });

    };


    var app = angular.module('consofile', ["ui.bootstrap"]);

    app.constant('ENUMS', {
        Forms: {
            1: 'FORM16',
            2: 'FORM16A',
            3: 'FORM27D',
            4: 'DEFAULT',
            5: 'TANPAN',
            6: 'CONSO'
        }
    });


    app.controller('ConfileCtrl', function ($scope, $http, ENUMS) {
        $scope.RequestDisabled = false;

        //Added   on 14/09/2019
        if ($('#hdnMenuread').val() == "true") {
            $scope.RequestDisabled = true;
        }
        $scope.ConsoFile = false;
        $scope.Justification = false;
        $scope.Form16A = false;
        $scope.Form16 = false;
        $scope.Form27D = false;
        $scope.Tan_Lists;
        $scope.TaxDeposited = "0.00";
        $scope.Amount1 = "0.00";
        $scope.Amount2 = "0.00";
        $scope.Amount3 = "0.00";
        $scope.NilReturnDisabled = false;

        var varURL = 'http://traces.onlinetds.in/';
        varURL = '';
        angular.element(document).ready(function () {

            var page = getParameterByName('pg').toUpperCase();
            $scope.RequestType = page;
            if (page == ENUMS.Forms['1']) {

                $scope.Title = 'Request for TDS Certificate (Form 16 - Part A)';
                $scope.ImpNotes = 'Request for TDS Certificates – Form 16 (Part A) to TRACES may be done here. This file is read by the TRACES PDF Convertor to generate the Form 16 (Part A) of Employees in PDF format.';

                //  $scope.Quarter = [{ Id: 1, Name: 'Q4' }];
                // $scope.Form = [{ Id: 1, Name: '24Q' }];

                //---------------
                $http.post(varURL + 'TService.asmx/forms', { Form: '16' }).success(function (data) {
                    $scope.Form = data.getFormsResult;

                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding Customer! " + data;
                });
                //---------------
                $http.post(varURL + 'TService.asmx/quarter', { Form: '16' }).success(function (data) {
                    $scope.Quarter = data.getQuarterResult;

                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding Customer! " + data;
                });
                //---------------

                $scope.ConsoFile = true;
                $scope.Justification = true;


            } else if (page == ENUMS.Forms['2']) {
                $scope.Title = 'Request for TDS Certificate (Form 16A)';
                $scope.ImpNotes = 'Request for TDS Certificates – Form 16A to TRACES may be done here. This file is read by the TRACES PDF Convertor to generate the Form 16A of Deductees in PDF format.';

                // $scope.Quarter = [{ Id: 1, Name: 'Q1' }, { Id: 2, Name: 'Q2' }, { Id: 3, Name: 'Q3' }, { Id: 4, Name: 'Q4' }];
                //$scope.Form = [{ Id: 2, Name: '26Q' }, { Id: 3, Name: '27Q' }];

                $http.post(varURL + 'TService.asmx/forms', { Form: '16A' }).success(function (data) {
                    $scope.Form = data.getFormsResult;

                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding Customer! " + data;
                });
                //---------------
                $http.post(varURL + 'TService.asmx/quarter', { Form: '16A' }).success(function (data) {
                    $scope.Quarter = data.getQuarterResult;

                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding Customer! " + data;
                });
                //---------------

                $scope.ConsoFile = true;
                $scope.Justification = true;
            }
            else if (page == ENUMS.Forms['3']) {
                $scope.Title = 'Request for Form 27D';
                $scope.ImpNotes = 'Request for TDS Certificates – Form 27D to TRACES may be done here. This file is read by the TRACES PDF Convertor to generate the Form 27D of Collectees in PDF format.';
                //---------------
                $http.post(varURL + 'TService.asmx/forms', { Form: '27D' }).success(function (data) {
                    $scope.Form = data.getFormsResult;

                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding Customer! " + data;
                });
                //---------------
                $http.post(varURL + 'TService.asmx/quarter', { Form: '27D' }).success(function (data) {
                    $scope.Quarter = data.getQuarterResult;

                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding Customer! " + data;
                });
                //---------------

                $scope.ConsoFile = true;
                $scope.Justification = true;

            }
            else if (page == ENUMS.Forms['4']) {
                $scope.Title = 'Request for Defaults/Justification Report';
                $scope.ImpNotes = 'To understand the error / defaults, one needs to request for the Defaults / Justification Report from TRACES which may be done here.';
                //---------------
                $http.post(varURL + 'TService.asmx/forms', { Form: 'Default' }).success(function (data) {
                    $scope.Form = data.getFormsResult;

                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding Customer! " + data;
                });
                //---------------
                $http.post(varURL + 'TService.asmx/quarter', { Form: 'Default' }).success(function (data) {
                    $scope.Quarter = data.getQuarterResult;

                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding Customer! " + data;
                });
                //---------------
                $scope.ConsoFile = true;
                $scope.Form16A = true;

            }
            else if (page == ENUMS.Forms['5']) {
                $scope.Title = 'Request for TAN - PAN File';
                //---------------
                $http.post(varURL + 'TService.asmx/forms', { Form: 'TANPAN' }).success(function (data) {
                    $scope.Form = data.getFormsResult;

                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding Customer! " + data;
                });
                //---------------
                $http.post(varURL + 'TService.asmx/quarter', { Form: 'TANPAN' }).success(function (data) {
                    $scope.Quarter = data.getQuarterResult;

                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding Customer! " + data;
                });

            } else {
                $scope.Title = 'Request for Consolidated Statement';

                $scope.ImpNotes = 'TDS / Conso file request to TRACES may be done here. This file contains the data required for preparing Correction Returns.';

                $http.post(varURL + 'TService.asmx/forms', { Form: 'Conso' }).success(function (data) {
                    $scope.Form = data.getFormsResult;

                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding Customer! " + data;
                });

                $http.post(varURL + 'TService.asmx/quarter', { Form: 'Conso' }).success(function (data) {
                    $scope.Quarter = data.getQuarterResult;

                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding Customer! " + data;
                });



                //}  

                $scope.Justification = true;
                $scope.Form16A = true;
            }

            $("#lblHeader").text($scope.Title);
        });


        $scope.RefreshCaptcha = function () {
            $scope.loading = true;
            $http.get(varURL + "TService.asmx/tCaptcha")
          .then(function (response) {
              //First function handles success
              $scope.captcha = response.data.getCaptchafromTracesSiteResult[0];
              $scope.Cookies = response.data.getCaptchafromTracesSiteResult[1];
              $scope.loading = false;
          }, function (response) {
              //Second function handles error
              $scope.error = "Something went wrong";
              $scope.loading = false;
          });
        }

        $http.get(varURL + "TService.asmx/tCaptcha")
           .then(function (response) {
               //First function handles success
               $scope.captcha = response.data.getCaptchafromTracesSiteResult[0];
               $scope.Cookies = response.data.getCaptchafromTracesSiteResult[1];

           }, function (response) {
               //Second function handles error
               $scope.error = "Something went wrong";
           });

        //----------------------------------------------------
        // Commented   on 31-12-2016
        //----------------------------------------------------
        //$http.get(varURL + "TService.asmx/TracesTan")
        //  .then(function (response) {
        //      $scope.Tan_Lists = response.data.getCompanyTanListResult;
        //  }, function (response) {
        //      //Second function handles error
        //      $scope.error = "Something went wrong";
        //  });

        //--------------------------------------------------------------------------------
        //-----------------------------------------------------------------------------------

        //--------------------------------------------------------------------------------
        //Modify    on 31-12-2016
        //--------------------------------------------------------------------------------

        //-------------------------------------------------------
        //---- For Add Other TAN in Drop Down Box
        //-------------------------------------------------------
        var QueryString_pg = getParameterByName('pg').toUpperCase();
        var IsPopulateOtherTAN = false;
        if (QueryString_pg == "") {
            IsPopulateOtherTAN = true;
        }
        //-------------------------------------------------------
        //-------------------------------------------------------


        $http.post(varURL + "TService.asmx/TracesTan", { IsAddOtherTAN: IsPopulateOtherTAN }).success(function (response) {

            $scope.Tan_Lists = response.getCompanyTanListResult;

        }).error(function (response) {
            //Second function handles error
            $scope.error = "Something went wrong";
        });
        //--------------------------------------------------------------------------------
        //-----------------------------------------------------------------------------------


        $http.get(varURL + "TService.asmx/FAYear")
          .then(function (response) {
              $scope.FAYear = response.data.getFAYearResult;
          }, function (response) {
              //Second function handles error
              $scope.error = "Something went wrong";
          });

        $scope.setDisable = function (nilValue) {

            if (nilValue) {
                $scope.NilReturnDisabled = true;
                $scope.BookAdjustment = false;
            }
            else
                $scope.NilReturnDisabled = false;
        }


        $scope.Clear = function () {
            $scope.TANNo = '';
            $scope.TANNo_Enter = '';
            $scope.UserID = '';
            $scope.Password = '';
            $scope.PRNNo = '';
            $scope.NIlChallan = false;
            $scope.BookAdjust = false;
            $scope.NoValidPAN = false;
            $scope.SlNo = '';
            $scope.ChallanNo = '',
            $scope.BSRCode = '';
            $scope.DateOfDeposit = '';
            $scope.TaxDeposited = '0.00';
            $scope.TANNo = '';
            $scope.PAN1 = '';
            $scope.Amount1 = '0.00';
            $scope.PAN2 = '';
            $scope.Amount2 = '0.00';
            $scope.PAN3 = '';
            $scope.Amount3 = '0.00';
            $scope.CaptchaCode = '';

        }

        $scope.UIModify = function () {

            if ($scope.ddlForm != null || $scope.ddlForm != undefined) {
                $scope.ConsoFile = false;
                $scope.Justification = false;
                $scope.Form16A = false;
                $scope.Form16 = false;
                $scope.Form27D = false;

                if ($scope.ddlForm.Name == "24Q")
                    $scope.ConsoFile = true;
                else if ($scope.ddlForm.Name == "26Q" || $scope.ddlForm.Name == "27Q") {
                    $scope.ConsoFile = true;
                    $scope.Form16A = true;
                }
                else if ($scope.ddlForm.Name == "27EQ") {
                    $scope.ConsoFile = true;
                    $scope.Form27D = true;
                }

            }
        }


        $scope.RequestTrace = function () {

            // alert('Request for NSDL Conso File has been submitted. Request Number is 45540343. The file will be available in <a href="TracesDownloadList.aspx"><b>Downloads</b></a> section','HTML');

            // return;

            //---- Commented   on 28-12-2016
            //if (($scope.TANNo == null || $scope.TANNo == undefined) || ($scope.UserID == null || $scope.UserID == undefined) || ($scope.Password == null || $scope.Password == undefined)) {
            //    alert('Enter User Login Details');
            //    return;
            //}

            //---- Modify   on 28-12-2016
            if (($scope.UserID == null || $scope.UserID == undefined) || ($scope.Password == null || $scope.Password == undefined)) {
                alert('Enter User Login Details');
                return;
            }

            //---- Added   on 28-12-2016
            if (($scope.TANNo_Enter == null || $scope.TANNo_Enter == undefined) && ($scope.TANNo == null || $scope.TANNo == undefined)) {
                alert('TAN - Cannot be Blank');
                return;
            }

            //---- Commented   on 28-12-2016
            //if ($scope.TANNo != null || $scope.TANNo != undefined) {

            //    var tp = $scope.TANNo.TAN_NO;
            //    //PAN check
            //    var Pattern1 = /^([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}?$/;
            //    //TAN check
            //    var Pattern2 = /^([a-zA-Z]){4}([0-9]){5}([a-zA-Z]){1}?$/;
            //    //AIN check
            //    var Pattern3 = /^[0-9]{7}$/;

            //    if (tp.match(Pattern1) || tp.match(Pattern2) || tp.match(Pattern3)) {
            //        // alert('correct Format of the TAN No.');
            //        // return;
            //    } else {
            //        alert('Incorrect Format of the TAN No.');
            //        return;
            //    }


            //}

            //----------------------------------------------
            // Modify   on 27-12-2016
            //----------------------------------------------
            var TAN_NO = $('#ddlTAN_NO').val();

            if (TAN_NO != "0") {
                if ($scope.TANNo != null || $scope.TANNo != undefined) {

                    var tp = $scope.TANNo.TAN_NO;
                    //PAN check
                    var Pattern1 = /^([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}?$/;
                    //TAN check
                    var Pattern2 = /^([a-zA-Z]){4}([0-9]){5}([a-zA-Z]){1}?$/;
                    //AIN check
                    var Pattern3 = /^[0-9]{7}$/;

                    if (tp.match(Pattern1) || tp.match(Pattern2) || tp.match(Pattern3)) {
                        // alert('correct Format of the TAN No.');
                        // return;
                    } else {
                        alert('Incorrect Format of the TAN No.');
                        return;
                    }


                }
            }
            else {
                //  TAN AND TAN FORMAT
                var tp = $('#txtTanNo').val();
                //PAN check
                var Pattern1 = /^([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}?$/;
                //TAN check
                var Pattern2 = /^([a-zA-Z]){4}([0-9]){5}([a-zA-Z]){1}?$/;
                //AIN check
                var Pattern3 = /^[0-9]{7}$/;

                if (tp.match(Pattern1) || tp.match(Pattern2) || tp.match(Pattern3)) {
                    // alert('correct Format of the TAN No.');
                    // return;
                } else {
                    alert('Incorrect Format of the TAN No.');
                    return;
                }
            }
            //----------------------------------------------
            //----------------------------------------------



            if ($scope.ddlFAYear == null || $scope.ddlFAYear == undefined) {
                alert('Select FA Year');
                return;
            }
            if ($scope.ddlQuarter == null || $scope.ddlQuarter == undefined) {
                alert('Select Quarter');
                return;
            }
            if ($scope.ddlForm == null || $scope.ddlForm == undefined) {
                alert('Select Form');
                return;
            }
            //----------------------------------------------
            //---- Commented   on 29-12-2016  RequestTrace
            //----------------------------------------------
            //if ($scope.PRNNo == null || $scope.PRNNo == undefined) {
            //    alert('Enter Token / PRN Number');
            //    return;

            //} else {
            //    if (isNaN($scope.PRNNo)) {
            //        alert('Token Number / PRN is a numerical field. Please ensure you enter only numerals');
            //        return;
            //    }
            //}
            //----------------------------------------------  
            //----------------------------------------------

            //----------------------------------------------
            // Modify   on 29-12-2016
            //----------------------------------------------
            if ($scope.PRNNo == null || $scope.PRNNo == undefined || $scope.PRNNo == "") {
                alert('Enter Token / PRN Number');
                return;

            } else {
                if (isNaN($scope.PRNNo)) {
                    alert('Token Number / PRN is a numerical field. Please ensure you enter only numerals');
                    return;
                }
            }
            //----------------------------------------------  
            //----------------------------------------------

            if ($('#txtDateOfDeposit').val() != "") {
                var reg = /(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d/;
                if (!$('#txtDateOfDeposit').val().match(reg)) {
                    alert("Please enter dd/mm/yyyy");
                    return;
                }
            }

            if ($scope.PAN1 != null && $scope.PAN1 != undefined && $scope.PAN1 != "") {
                if (!$scope.PAN1.match(/^([a-zA-Z]){4}([a-zA-Z]){1}([0-9]){4}([a-zA-Z]){1}?$/)) {
                    alert("PAN structure is not valid");
                    return;
                }
            }
            if ($scope.PAN2 != null && $scope.PAN2 != undefined && $scope.PAN2 != "") {
                if (!$scope.PAN2.match(/^([a-zA-Z]){4}([a-zA-Z]){1}([0-9]){4}([a-zA-Z]){1}?$/)) {
                    alert("PAN structure is not valid");
                    return;
                }
            }
            if ($scope.PAN3 != null && $scope.PAN3 != undefined && $scope.PAN3 != "") {
                if (!$scope.PAN3.match(/^([a-zA-Z]){4}([a-zA-Z]){1}([0-9]){4}([a-zA-Z]){1}?$/)) {
                    alert("PAN structure is not valid");
                    return;
                }
            }


            if ($scope.CaptchaCode == null || $scope.CaptchaCode == undefined) {
                alert('Enter Captcha Code');
                return;
            }
            var accountID = $("#hdnAccountID").val();

            //-----------------------------
            // Added   on 27-12-2016
            //-----------------------------
            var CurrentTANNO = "";
            if (TAN_NO != "0") {
                CurrentTANNO = $scope.TANNo.TAN_NO;
            }
            else {
                CurrentTANNO = $('#txtTanNo').val();
            }
            //-----------------------------
            //-----------------------------

            //--------------------------------------------------------------------------------
            // Added    on 02-01-2017
            //--------------------------------------------------------------------------------
            var Savepasswordcheck = false;
            if ($("#chkSavepPassword").is(":checked")) {
                Savepasswordcheck = true;
            }


            // Commented   on 28-12-2016
            //var TraceData = {
            //    "trsData": {
            //        FAYearID: $scope.ddlFAYear.FAYearID,
            //        FAYear: $scope.ddlFAYear.FAYear,
            //        QuarterID: $scope.ddlQuarter.QtrID,
            //        Quarter: $scope.ddlQuarter.Quarter,
            //        FormsID: $scope.ddlForm.FormID,
            //        Forms: $scope.ddlForm.Form,
            //        AuthenCode: '',
            //        PRN_No: $scope.PRNNo,
            //        NilChallanCheck: $scope.NIlChallan,
            //        BookAdjustCheck: $scope.BookAdjustment,
            //        NoValidPanCheck: $scope.NoValidPAN,
            //        SerialNo: $scope.SlNo,
            //        ChallanNo: $scope.ChallanNo,
            //        BSRCode: $scope.BSRCode,
            //        DateOfDeposit: $('#txtDateOfDeposit').val(),
            //        ChallanAmount: $scope.TaxDeposited,
            //        NoPanDeductee: false,
            //        TAN: $scope.TANNo.TAN_NO,
            //        PAN1: $scope.PAN1,
            //        PAN1Amount: $scope.Amount1,
            //        PAN2: $scope.PAN2,
            //        PAN2Amount: $scope.Amount2,
            //        PAN3: $scope.PAN3,
            //        PAN3Amount: $scope.Amount3,
            //        FromChallanDepositDate: '',
            //        ToChallanDepositDate: '',
            //        ChallanStatus: '',
            //        AddlConso: $scope.AddlConsoFile,
            //        AddljustificationRep: $scope.AddlJustification,
            //        AddlForm16A: $scope.AddlForm16A,
            //        AddlForm16: $scope.AddlForm16,
            //        AddlForm27D: $scope.AddlForm27D,
            //        Login: { UserID: $scope.UserID, Password: $scope.Password, Tan: $scope.TANNo.TAN_NO, Captcha: $scope.CaptchaCode, Cookies: $scope.Cookies },
            //        RequestType: $scope.RequestType,
            //        AccountId: accountID
            //    }

            //};

            //--------------------------------------------------------------------------------
            //Modify    on 02-01-2017
            //--------------------------------------------------------------------------------
            var TraceData = {
                "trsData": {
                    FAYearID: $scope.ddlFAYear.FAYearID,
                    FAYear: $scope.ddlFAYear.FAYear,
                    QuarterID: $scope.ddlQuarter.QtrID,
                    Quarter: $scope.ddlQuarter.Quarter,
                    FormsID: $scope.ddlForm.FormID,
                    Forms: $scope.ddlForm.Form,
                    AuthenCode: '',
                    PRN_No: $scope.PRNNo,
                    NilChallanCheck: $scope.NIlChallan,
                    BookAdjustCheck: $scope.BookAdjustment,
                    NoValidPanCheck: $scope.NoValidPAN,
                    SerialNo: $scope.SlNo,
                    ChallanNo: $scope.ChallanNo,
                    BSRCode: $scope.BSRCode,
                    DateOfDeposit: $('#txtDateOfDeposit').val(),
                    ChallanAmount: $scope.TaxDeposited,
                    NoPanDeductee: false,
                    TAN: CurrentTANNO,
                    Save_password: Savepasswordcheck,
                    PAN1: $scope.PAN1,
                    PAN1Amount: $scope.Amount1,
                    PAN2: $scope.PAN2,
                    PAN2Amount: $scope.Amount2,
                    PAN3: $scope.PAN3,
                    PAN3Amount: $scope.Amount3,
                    FromChallanDepositDate: '',
                    ToChallanDepositDate: '',
                    ChallanStatus: '',
                    AddlConso: $scope.AddlConsoFile,
                    AddljustificationRep: $scope.AddlJustification,
                    AddlForm16A: $scope.AddlForm16A,
                    AddlForm16: $scope.AddlForm16,
                    AddlForm27D: $scope.AddlForm27D,
                    Login: { UserID: $scope.UserID, Password: $scope.Password, Tan: CurrentTANNO, Save_password: Savepasswordcheck, Captcha: $scope.CaptchaCode, Cookies: $scope.Cookies },
                    RequestType: $scope.RequestType,
                    AccountId: accountID
                }

            };


            $scope.loading = true;
            $scope.RequestDisabled = true;

            $http.post(varURL + 'TService.asmx/reQTraces', TraceData).success(function (data) {

                // if Error 
                if (data.RequestToTracesResult.Response == "1") {
                    //  $scope.Clear();
                    $scope.CaptchaCode = '';
                    $scope.RefreshCaptcha();
                    alert(data.RequestToTracesResult.Message);

                } else if (data.RequestToTracesResult.Response == "2") {
                    $scope.loading = false;
                    $scope.RequestDisabled = false;
                    SessionLogoutDialog();
                }

                else {
                    $scope.CaptchaCode = '';
                    $scope.RefreshCaptcha();
                    alert(data.RequestToTracesResult.Message, 'html');

                }

                $scope.loading = false;
                $scope.RequestDisabled = false;
            }).error(function (data) {
                $scope.error = "An Error has occured while Adding Customer! " + data;
                $scope.loading = false;
                $scope.RequestDisabled = false;
            });



        }

        $scope.formatTaxAmount = function () {
            if ($scope.TaxDeposited == '' || isNaN($scope.TaxDeposited))
                $scope.TaxDeposited = '0.00';

            $scope.TaxDeposited = parseFloat($scope.TaxDeposited).toFixed(2);

        }

        $scope.formatAmount1 = function () {
            if ($scope.Amount1 == '' || isNaN($scope.Amount1))
                $scope.Amount1 = '0.00';
            $scope.Amount1 = parseFloat($scope.Amount1).toFixed(2);

        }
        $scope.formatAmount2 = function () {
            if ($scope.Amount2 == '' || isNaN($scope.Amount2))
                $scope.Amount2 = '0.00';
            $scope.Amount2 = parseFloat($scope.Amount2).toFixed(2);

        }
        $scope.formatAmount3 = function () {
            if ($scope.Amount3 == '' || isNaN($scope.Amount3))
                $scope.Amount3 = '0.00';
            $scope.Amount3 = parseFloat($scope.Amount3).toFixed(2);

        }

        $scope.getUser = function () {
            //--------------------------------------------------------------------------------
            //Modify    on 02-01-2017
            //--------------------------------------------------------------------------------
            var TAN_NO = $('#ddlTAN_NO').val();
            if (TAN_NO == "0") {
                $scope.TANNo_Enter = '';
                $("#txtTanNo").show();
            }
            else {
                $("#txtTanNo").hide();
            }

            if (TAN_NO != "0") {
                $("#divSavePassword").show();
                $("#ancSavepassword").hide();
            }
            else {
                $("#divSavePassword").hide();
                $("#ancSavepassword").hide();
            }



            $scope.UserID = $scope.TANNo.LOGIN_ID;
            if ($scope.TANNo.SAVE_PASSWORD_FLAG == true) {
                $("#chkSavepPassword").prop("checked", true);
                $("#divSavePassword").show();
                $("#ancSavepassword").show();
                $scope.Password = $scope.TANNo.USER_PASSWORD;

            }
            else {
                $scope.Password = '';
                $("#chkSavepPassword").prop("checked", false);
            }
            $scope.getparam();

            //--------------------------------------
            //--------------------------------------

        }

        $scope.getparam = function () {

            // Commented   on 28-12-2016
            //if (($scope.TANNo == null || $scope.TANNo == undefined) || ($scope.ddlFAYear == null || $scope.ddlFAYear == undefined) || ($scope.ddlQuarter == null || $scope.ddlQuarter == undefined) || ($scope.ddlForm == null || $scope.ddlForm == undefined)) {
            //    return;
            //}
            //------------------------------------------
            // Modify   on 28-12-2016
            //------------------------------------------
            if (($scope.ddlFAYear == null || $scope.ddlFAYear == undefined) || ($scope.ddlQuarter == null || $scope.ddlQuarter == undefined) || ($scope.ddlForm == null || $scope.ddlForm == undefined)) {
                return;
            }

            if (($scope.TANNo_Enter == null || $scope.TANNo_Enter == undefined) && ($scope.TANNo == null || $scope.TANNo == undefined)) {
                return;
            }
            //------------------------------------------
            //------------------------------------------

            var accountID = $("#hdnAccountID").val();

            //-----------------------
            // Added   on 27-12-2016
            //-----------------------
            var TAN_NO = $('#ddlTAN_NO').val();
            var CurrentTANNO = "";
            if (TAN_NO != "0") {
                CurrentTANNO = $scope.TANNo.TAN_NO;
            }
            else {
                CurrentTANNO = $('#txtTanNo').val();
            }
            //-----------------------
            //-----------------------

            //-----------------------
            //---- Commented   on 28-12-2016
            //-----------------------
            //var nsdlData = {
            //    "data": {
            //        __COMPANY_ID: $scope.TANNo.COMPANY_ID,
            //        __TAN_NO: $scope.TANNo.TAN_NO,
            //        __ASST_ID: $scope.ddlFAYear.FAYearID,
            //        __FORM_ID: $scope.ddlForm.FormID,
            //        __QTR_ID: $scope.ddlQuarter.QtrID
            //    }
            //};
            //-----------------------
            //-----------------------

            //-----------------------
            //---- Modify   on 28-12-2016
            //-----------------------
            var nsdlData = {
                "data": {
                    __COMPANY_ID: $scope.TANNo.COMPANY_ID,
                    __TAN_NO: CurrentTANNO,
                    __ASST_ID: $scope.ddlFAYear.FAYearID,
                    __FORM_ID: $scope.ddlForm.FormID,
                    __QTR_ID: $scope.ddlQuarter.QtrID
                }
            };

            //-----------------------------------------
            //-----------------------------------------


            $scope.PRNNo = '';
            $scope.NIlChallan = false;
            $scope.BookAdjust = false;
            $scope.NoValidPAN = false;
            $scope.SlNo = '';
            $scope.ChallanNo = '',
            $scope.BSRCode = '';
            $scope.DateOfDeposit = '';
            $scope.TaxDeposited = '0.00';
            $scope.PAN1 = '';
            $scope.Amount1 = '0.00';
            $scope.PAN2 = '';
            $scope.Amount2 = '0.00';
            $scope.PAN3 = '';
            $scope.Amount3 = '0.00';
            //------------------------------------------------------
            $http.post(varURL + 'TService.asmx/chlnDetails', nsdlData).success(function (data) {

                if (data.getChallanInputsResult == null) {


                } else {
                    $scope.PRNNo = data.getChallanInputsResult.__PREVIOUS_RRR_NO;
                    if (parseInt(data.getChallanInputsResult.__NIL_CHALLAN) == 1)
                        $scope.NIlChallan = true;

                    if (parseInt(data.getChallanInputsResult.__BOOK_ENTRY) == 1)
                        $scope.BookAdjust = true;

                    if (parseInt(data.getChallanInputsResult.__DEDUCTEE_PAN_INVALID) == 1)
                        $scope.NoValidPAN = true;

                    if (parseInt(data.getChallanInputsResult.__CHALLAN_SRL_NO) > 0)
                        $scope.SlNo = data.getChallanInputsResult.__CHALLAN_SRL_NO;

                    $scope.ChallanNo = data.getChallanInputsResult.__CHALLAN_NO,
                    $scope.BSRCode = data.getChallanInputsResult.__BSR_CODE;
                    $scope.DateOfDeposit = data.getChallanInputsResult.__DEPOSIT_DATE;
                    $scope.TaxDeposited = parseFloat(data.getChallanInputsResult.__TOT_TAX).toFixed(2);
                    $scope.PAN1 = data.getChallanInputsResult.__DEDUCTEE_PAN1;
                    $scope.Amount1 = parseFloat(data.getChallanInputsResult.__DEDUCTEE_AMT1).toFixed(2);
                    $scope.PAN2 = data.getChallanInputsResult.__DEDUCTEE_PAN2;
                    $scope.Amount2 = parseFloat(data.getChallanInputsResult.__DEDUCTEE_AMT2).toFixed(2);
                    $scope.PAN3 = data.getChallanInputsResult.__DEDUCTEE_PAN3;
                    $scope.Amount3 = parseFloat(data.getChallanInputsResult.__DEDUCTEE_AMT3).toFixed(2);

                    $scope.loading = false;
                }

            }).error(function (data) {
                $scope.error = "An Error has occured while Adding Customer! " + data;
                $scope.loading = false;

            });
        }


        //------------------------------



        //------------------------------
        //------------------------------
        //---- Added   on 01-01-2017
        //------------------------------
        $('#ancSavepassword').click(function () {
            alert(J_Message.__TracesPasswordDisclaimerMessage, "html", J_Message.__ProjectTitleDisclaimer);
        });
        $("#chkSavepPassword").click(function () {
            if ($(this).is(":checked")) {
                $("#ancSavepassword").show();
            } else {
                $("#ancSavepassword").hide();
            }
        });
        $("#txtTanNo").focusout(function () {
            //alert("hello");
            $("#divSavePassword").show();
            $scope.getparam();
        });
        //-----------------------------------------
        //-----------------------------------------






    });


}());