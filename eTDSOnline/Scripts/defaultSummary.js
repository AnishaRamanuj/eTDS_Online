

(function () {


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

    var obj1 = {
        width: "100%",
        //  height: 400,
        colModel: [
            {
                title: "FA Year", dataIndx: "FAYear", editable: false,
                template: '{{rd.FAYear}}'
            },
            { title: "Quarter", editable: false, dataType: "string", dataIndx: "QtrCode", template: '{{rd.Qtr}}' },
            { title: "Form Type", editable: false, dataType: "string", dataIndx: "FAYear", template: '{{rd.frmType}}' },
            { title: "Net Payable(Rounded Off)", editable: false, align: "right", dataIndx: "NetPayable", template: '{{rd.NetPayable}}' },
            {
                title: "", align: 'center', editable: false,
                render: function (ui) {
                    var width = ui.column.outerWidth, ci = ui.colIndx
                    return '<button  type="button"  class="btnCss btn btn-warning" ng-click="vm.ViewDetails(rd)">View Details</button>  ';
                }
            }
        ],
        resizable: false,
        pageModel: { type: "local", rPP: 20 },
        collapsible: false,
        title: "",
        scrollModel: { autoFit: true },
        dataModel: { data: 'vm.myData1' }
    };
    //---------------------------------------------------
    var obj2 = {
        width: "100%",
        height: 140,
        colModel: [
            { title: "Statement", dataIndx: "Statement", editable: false, template: '{{rd.Statement}}' },
            { title: "Token Number", editable: false, dataType: "string", dataIndx: "TokenNumber", template: '{{rd.TokenNumber}}' },
            { title: "Order Passed Date", editable: false, dataType: "string", dataIndx: "OrderPassedDate", template: '{{rd.OrderPassedDate}}' },

        ],
        resizable: false,
        pageModel: { type: "local", rPP: 20 },
        collapsible: false,
        title: "",
        scrollModel: { autoFit: true },
        dataModel: { data: 'vm.myData2' }
    };
    //-------------------------------------------
    var obj3 = {
        width: "100%",
        height: 400,
        colModel: [
            { title: "Sr.No.", dataIndx: "SrNo", editable: false, width: 50, template: '{{rd.SrNo}}' },
            { title: "Type Of Default", editable: false, dataType: "string", width: 300, dataIndx: "TypeofDefault", template: '{{rd.TypeofDefault}}' },
            { title: "Default Amount", editable: false, align: "right", width: 100, dataIndx: "DefaultAmount", template: '{{rd.DefaultAmount}}' },
            { title: "Amount Reported As 'Interest/ Others Claimed in the Statement(Rs.)", width: 300, editable: false, align: "right", dataIndx: "AmountReported", template: '{{rd.AmountReported}}' },
            { title: "Payable(Rs.)", editable: false, align: "right", dataIndx: "Payable", width: 100, template: '{{rd.Payable}}' },
        ],
        resizable: false,
        pageModel: { type: "local", rPP: 20 },
        collapsible: false,
        title: "",
        scrollModel: { autoFit: true },
        dataModel: { data: 'vm.myData3' }
    };
    //-------------------------------------------
    var obj4 = {
        width: "100%",
        height: 100,
        colModel: [
            { title: "Deductees Without PAN", dataIndx: "DeducteesWithoutPAN", editable: false, template: '{{rd.DeducteesWithoutPAN}}' },
            { title: "Deductees With Invalid PAN", editable: false, dataType: "string", dataIndx: "DeducteesWithInvalidPAN", template: '{{rd.DeducteesWithInvalidPAN}}' },

        ],
        resizable: false,
        pageModel: { type: "local", rPP: 20 },
        collapsible: false,
        title: "",
        scrollModel: { autoFit: true },
        dataModel: { data: 'vm.myData4' }
    };
    //-------------------------------------------

    var app = angular.module('downfile', ['pq.grid', 'ui.bootstrap']);

    app.controller('downCtrl', function ($http, $timeout) {
        var vm = this;
        var varURL = 'http://traces.onlinetds.in/';
        varURL = '';

        vm.RequestDisabled = false;
        //Added   14/09/2019
        if ($('#hdnMenuread').val() == "true") {
            vm.RequestDisabled = true;
        }
        vm.LoginDisplay = true;
        vm.Summary1 = false;
        vm.Summary2 = false;

        vm.gridOptions1 = obj1;
        vm.gridOptions2 = obj2;
        vm.gridOptions3 = obj3;
        vm.gridOptions4 = obj4;

        angular.element(document).ready(function () {
            $("#lblHeader").text("Default Summary");
        });

        vm.RefreshCaptcha = function () {
            vm.loading = true;
            $http.get("TService.asmx/tCaptcha")
          .then(function (response) {
              //First function handles success
              vm.captcha = response.data.getCaptchafromTracesSiteResult[0];
              vm.Cookies = response.data.getCaptchafromTracesSiteResult[1];
              vm.loading = false;
          }, function (response) {
              //Second function handles error
              vm.error = "An Error has occured while connecting to the server!";
              vm.loading = false;
          });
        }

        $http.get("TService.asmx/tCaptcha")
           .then(function (response) {
               //First function handles success
               vm.captcha = response.data.getCaptchafromTracesSiteResult[0];
               vm.Cookies = response.data.getCaptchafromTracesSiteResult[1];

           }, function (response) {
               //Second function handles error
               alert("An Error has occured while connecting to the server! " + data);
           });

        //----------------------------------------------------
        // Commented   31-12-2016
        //----------------------------------------------------
        //$http.get(varURL + "TService.asmx/TracesTan")
        // .then(function (response) {
        //     vm.Tan_Lists = response.data.getCompanyTanListResult;
        // }, function (response) {
        //     //Second function handles error
        //     vm.error = "Something went wrong";
        // });

        //--------------------------------------------------------------------------------
        //-----------------------------------------------------------------------------------

        //--------------------------------------------------------------------------------
        //Modify    31-12-2016
        //--------------------------------------------------------------------------------
        $http.post(varURL + "TService.asmx/TracesTan", { IsAddOtherTAN: false }).success(function (response) {

            vm.Tan_Lists = response.getCompanyTanListResult;

        }).error(function (response) {
            //Second function handles error
            vm.error = "Something went wrong";
        });
        //--------------------------------------------------------------------------------
        //-----------------------------------------------------------------------------------

        vm.getUser = function () {
            //-------------------------------------
            // Added   28-12-2016
            //-------------------------------------
            var TAN_NO = vm.TANNo.TAN_NO;
            if (TAN_NO == "0") {
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

            vm.UserID = vm.TANNo.LOGIN_ID;
            if (vm.TANNo.SAVE_PASSWORD_FLAG == true) {
                $("#chkSavepPassword").prop("checked", true);
                $("#divSavePassword").show();
                $("#ancSavepassword").show();
                vm.Password = vm.TANNo.USER_PASSWORD;

            }
            else {
                vm.Password = '';
                $("#chkSavepPassword").prop("checked", false);
            }
            //----------------------------
            //----------------------------


        }

        vm.RequestDefaultSummary = function () {

            //-------------------------------------
            //----- Commented   28-12-2016
            //-------------------------------------
            //if (vm.isValid(vm.TANNo) || vm.isValid(vm.UserID) || vm.isValid(vm.Password)) {
            //    //  if ((vm.TANNo == null || vm.TANNo == undefined) || (vm.UserID == null || vm.UserID == undefined) || (vm.Password == null || vm.Password == undefined)) {
            //    alert('Enter User Login Details');
            //    return;
            //}
            //// if (vm.TANNo != null || vm.TANNo != undefined) {
            //if (!vm.isValid(vm.TANNo)) {
            //    var tp = vm.TANNo.TAN_NO;
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

            //if (vm.isValid(vm.CaptchaCode)) {
            //    alert('Enter Captcha Code');
            //    return;
            //}

            //var TracesLogin = {
            //    "objLogin": {
            //        UserID: vm.UserID,
            //        Password: vm.Password,
            //        Tan: vm.TANNo.TAN_NO,
            //        Captcha: vm.CaptchaCode,
            //        Cookies: vm.Cookies
            //    }
            //};
            //-------------------------------------
            //-------------------------------------

            //-------------------------------------
            //---- Modify   28-12-2016
            //-------------------------------------
            if (vm.isValid(vm.UserID) || vm.isValid(vm.Password)) {
                //  if ((vm.TANNo == null || vm.TANNo == undefined) || (vm.UserID == null || vm.UserID == undefined) || (vm.Password == null || vm.Password == undefined)) {
                alert('Enter User Login Details');
                return;
            }
            if ((vm.TANNoEnter == null || vm.TANNoEnter == undefined) && (vm.TANNo == null || vm.TANNo == undefined)) {
                alert('TAN - Cannot be Blank');
                return;
            }
            // added   27-12-2016
            var TAN_NO = vm.TANNo.TAN_NO;
            // if (vm.TANNo != null || vm.TANNo != undefined) {
            if (TAN_NO != "0") {
                if (!vm.isValid(vm.TANNo)) {
                    var tp = vm.TANNo.TAN_NO;
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
                var tp = $("#txtTanNo").val();
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
            if (vm.isValid(vm.CaptchaCode)) {
                alert('Enter Captcha Code');
                return;
            }

            // added by bashir
            var CurrentTANNO = "";
            if (TAN_NO != "0") {
                CurrentTANNO = vm.TANNo.TAN_NO;
            }
            else {
                CurrentTANNO = $('#txtTanNo').val();
            }

            //-------------------------------------
            // Modify   02-01-2017
            //-------------------------------------
            var Savepasswordcheck = false;
            if ($("#chkSavepPassword").is(":checked")) {
                Savepasswordcheck = true;
            }

            var TracesLogin = {
                "objLogin": {
                    UserID: vm.UserID,
                    Password: vm.Password,
                    Tan: CurrentTANNO,
                    Save_password: Savepasswordcheck,
                    Captcha: vm.CaptchaCode,
                    Cookies: vm.Cookies
                }
            };
            //-------------------------------------
            //-------------------------------------



            //--POST REQUEST
            vm.loading = true;
            vm.RequestDisabled = true;
            $http.post(varURL + 'TService.asmx/reDSummary', TracesLogin).success(function (data) {

                if (data.RequestDefaultSummaryResult.Response == "0") {
                    vm.Summary1 = true;
                    vm.LoginDisplay = false;

                    vm.Cookies = data.RequestDefaultSummaryResult.Cookies;
                    var jsonData = JSON.parse(data.RequestDefaultSummaryResult.ResponseData);

                    vm.myData1 = jsonData.DefaultSummary;

                    if (jsonData.DefaultSummary.length == 0) {
                        alert("No Defaults found for the entered TAN");
                    }

                    $timeout(function () {
                        vm.gridOptions1.grid.refresh();

                    });


                }
                else if (data.RequestDefaultSummaryResult.Response == "2") {
                    SessionLogoutDialog();
                }
                else {
                    vm.RefreshCaptcha();
                    vm.CaptchaCode = '';
                    alert(data.RequestDefaultSummaryResult.Message);
                }

                vm.loading = false;
                vm.RequestDisabled = false;
            }).error(function (data) {
                alert("An Error has occured while connecting to the server! " + data);
                vm.loading = false;
                vm.RequestDisabled = false;
            });





        }


        vm.ViewDetails = function (rd) {
            //alert(" Request No: " + rd.reqNo);

            var grid = obj1.grid;

            grid.option("strLoading", "Downloading ..");
            grid.showLoading();

            $http.post(varURL + 'TService.asmx/reDSumDetail', { strCookies: vm.Cookies, strFy: rd.FAYearCode, strQrtDesc: rd.Qtr, strQr: rd.QtrCode, strFt: rd.frmType, strFinyrdesc: rd.FAYear }).success(function (data) {

                if (data.RequestDefaultSummaryDetailsResult.Response == "0") {

                    var jsonGrid = JSON.parse(data.RequestDefaultSummaryDetailsResult.ResponseData);

                    vm.myData2 = jsonGrid.SummaryDetails.StatementDetail;
                    vm.myData3 = jsonGrid.SummaryDetails.DetailSummary;
                    vm.myData4 = jsonGrid.SummaryDetails.SummaryPanError;
                    vm.count_Corr = jsonGrid.SummaryDetails.CountofCorrectionStatement;
                    vm.Net_Payable = jsonGrid.SummaryDetails.NetPayable;
                    vm.TotalPayable = jsonGrid.SummaryDetails.TotalPayable;

                    vm.Summary1 = false;
                    vm.Summary2 = true;

                    $timeout(function () {
                        vm.gridOptions2.grid.refresh();
                        vm.gridOptions3.grid.refresh();
                        vm.gridOptions4.grid.refresh();

                    });

                }
                else if (data.RequestDefaultSummaryDetailsResult.Response == "2") {
                    SessionLogoutDialog();
                }
                else {
                    vm.Summary2 = false;
                    vm.Summary1 = false;
                    vm.LoginDisplay = true;
                }

                grid.hideLoading();



            }).error(function (data) {
                alert("An Error has occured while connecting to the server! " + data);
                grid.hideLoading();
            });
        };



        vm.LogOut = function () {

            vm.RefreshCaptcha();
            vm.CaptchaCode = '';
            vm.Summary2 = false;
            vm.Summary1 = false;
            vm.LoginDisplay = true;
            vm.TANNo = '';
            vm.UserID = '';
            vm.Password = '';

            //----------------------------
            // Added   27-12-2016
            //----------------------------
            vm.TANNo_Enter = '';
            if (vm.TANNo == "0") {
                $("#txtTanNo").show();
            }
            else {
                $('#txtTanNo').val('');
                $("#txtTanNo").hide();
            }
            $("#chkSavepPassword").prop("checked", false);
            //----------------------------
            //----------------------------

            $http.post(varURL + 'TService.asmx/LogOut', { strCookies: vm.Cookies }).success(function (data) {

            }).error(function (data) {
                alert("An Error has occured while connecting to the server! " + data);
                grid.hideLoading();
            });
        }


        vm.BacktoGrid = function () {
            vm.LoginDisplay = false;
            vm.Summary2 = false;
            vm.Summary1 = true;

        }

        //---For Auto Suggest -----------
        vm.getTANList = function (val) {
            return $http.get('TService.asmx/tanList', {
                params: {
                    Tan: val
                }
            }).then(function (res) {
                var TanList = [];
                var ss = JSON.parse(res.data);
                angular.forEach(ss, function (item) {
                    TanList.push(item);
                });
                return TanList;
            });
        };

        vm.onSelect = function ($item, $model, $label) {
            vm.UserID = $item.__LOGIN_ID;
            vm.Password = $item.__USER_PASSWORD;
        };
        //------------------------------
        vm.isValid = function (value) {
            return !value
        }

        //------------------------------
        //------------------------------
        //---- Added   02-01-2017
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
            $("#divSavePassword").show();
        });
        //-----------------------------------------
        //-----------------------------------------



    });


}());