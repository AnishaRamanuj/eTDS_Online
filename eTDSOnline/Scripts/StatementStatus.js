/// <reference path="../scripts/jquery.min.js" />
/// <reference path="../scripts/angular.min.js" />


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


    var obj = {
        width: "100%",
        height: 400,
        colModel: [
            { title: "Token Number", dataIndx: "tokenno", editable: false, template: '{{rd.tokenno}}' },
            { title: "Finnancial Year", editable: false, dataType: "string", dataIndx: "finyear", template: '{{rd.finyear}}' },
            { title: "Statement Type", editable: false, dataType: "string", dataIndx: "stmnttype", template: '{{rd.stmnttype}}' },
            { title: "Form Type", editable: false, dataType: "string", dataIndx: "formtype", template: '{{rd.formtype}}' },
            { title: "Quarter", editable: false, dataType: "string", dataIndx: "quarter", template: '{{rd.quarter}}' },
            { title: "Date Of Filling", editable: false, dataType: "string", dataIndx: "dtoffiling", template: '{{rd.dtoffiling}}' },
            { title: "Date Of Processing", editable: false, dataType: "string", dataIndx: "dtofprcng", template: '{{rd.dtofprcng}}' },
            { title: "Status", editable: false, dataType: "string", dataIndx: "status", template: '{{rd.status}}' }

        ],
        resizable: false,
        pageModel: { type: "local", rPP: 20 },
        collapsible: false,
        title: "",
        scrollModel: { autoFit: true },
        dataModel: { data: 'vm.myData' }
    };

    var app = angular.module('downfile', ['pq.grid', 'ui.bootstrap']);

    app.controller('StatusCtrl', function ($http, $timeout) {
        var vm = this;
        var varURL = 'http://traces.onlinetds.in/';
        varURL = '';
        vm.RequestDisabled = false;
        //Added   on 14/09/2019
        if ($('#hdnMenuread').val() == "true") {
            vm.RequestDisabled = true;
        }
        vm.LoginDisplay = true;
        vm.GridDisplay = false;
        vm.gridOptions = obj;

        vm.GoDisabled = false;
        vm.Quarter = [{ Id: 3, Name: 'Q1' }, { Id: 4, Name: 'Q2' }, { Id: 5, Name: 'Q3' }, { Id: 6, Name: 'Q4' }];
        vm.Form = [{ Id: 1, Name: '24Q' }, { Id: 2, Name: '26Q' }, { Id: 3, Name: '27Q' }, { Id: 4, Name: '27EQ' }];

        angular.element(document).ready(function () {
            $("#lblHeader").text("Requested For Status Of Statement Filed");
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
              vm.error = "Something went wrong";
              vm.loading = false;
          });
        }
        //----------------------------------------------------
        // Commented   on 31-12-2016
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
        //Modify    on 31-12-2016
        //--------------------------------------------------------------------------------

        $http.post(varURL + "TService.asmx/TracesTan", { Form: 'status' }).success(function (response) {

            vm.Tan_Lists = response.getCompanyTanListResult;

        }).error(function (response) {
            //Second function handles error
            vm.error = "Something went wrong";
        });
        //--------------------------------------------------------------------------------
        //-----------------------------------------------------------------------------------

        $http.get("TService.asmx/tCaptcha")
           .then(function (response) {
               //First function handles success
               vm.captcha = response.data.getCaptchafromTracesSiteResult[0];
               vm.Cookies = response.data.getCaptchafromTracesSiteResult[1];

           }, function (response) {
               //Second function handles error
               alert("An Error has occured while connecting to the server! " + data);
           });

        $http.get(varURL + "TService.asmx/FAYear")
         .then(function (response) {
             vm.FAYear = response.data.getFAYearResult;

         }, function (response) {
             //Second function handles error
             vm.error = "Something went wrong";
         });

        vm.getUser = function () {
            //-------------------------------------
            // Added   on 28-12-2016
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

        vm.RequestLogin = function () {

            // if ((vm.TANNo == null || vm.TANNo == undefined) || (vm.UserID == null || vm.UserID == undefined) || (vm.Password == null || vm.Password == undefined)) {
            //---------------------------
            //---- Commented   on 28-12-2016
            //---------------------------
            // if (vm.isValid(vm.TANNo) || vm.isValid(vm.UserID) || vm.isValid(vm.Password)) {
            // alert('Enter User Login Details');
            //     return;
            // }
            //// if (vm.TANNo != null || vm.TANNo != undefined) {
            // if (!vm.isValid(vm.TANNo)) {
            //     var tp = vm.TANNo.TAN_NO;
            //     //PAN check
            //     var Pattern1 = /^([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}?$/;
            //     //TAN check
            //     var Pattern2 = /^([a-zA-Z]){4}([0-9]){5}([a-zA-Z]){1}?$/;
            //     //AIN check
            //     var Pattern3 = /^[0-9]{7}$/;

            //     if (tp.match(Pattern1) || tp.match(Pattern2) || tp.match(Pattern3)) {
            //         // alert('correct Format of the TAN No.');
            //         // return;
            //     } else {
            //         alert('Incorrect Format of the TAN No.');
            //         return;
            //     }
            // }

            // if (vm.isValid(vm.CaptchaCode)) {
            //     alert('Enter Captcha Code');
            //     return;
            // }

            // var TracesLogin = {
            //     "login": {
            //         UserID: vm.UserID, 
            //         Password: vm.Password, 
            //         Tan: vm.TANNo.TAN_NO,
            //         Captcha:vm.CaptchaCode,
            //         Cookies: vm.Cookies 
            //     }
            // };
            //---------------------------
            //---------------------------


            //---------------------------
            //---- Modify   on 28-12-2016
            //---------------------------
            if (vm.isValid(vm.UserID) || vm.isValid(vm.Password)) {
                alert('Enter User Login Details');
                return;
            }
            // Added   on 27-12-2016
            if (vm.isValid(vm.TANNo_Enter) && vm.isValid(vm.TANNo)) {
                alert('TAN - Cannot be Blank');
                return;
            }
            // added   on 27-12-2016
            var TAN_NO = vm.TANNo.TAN_NO;
            if (TAN_NO != "0") {
                // if (vm.TANNo != null || vm.TANNo != undefined) {
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

            if (vm.isValid(vm.CaptchaCode)) {
                alert('Enter Captcha Code');
                return;
            }

            // added   on 27-12-2016
            var CurrentTANNO = "";
            if (TAN_NO != "0") {
                CurrentTANNO = vm.TANNo.TAN_NO;
            }
            else {
                CurrentTANNO = $('#txtTanNo').val();
            }


            //---------------------------
            // Added    on 02-01-2017
            //---------------------------
            var Savepasswordcheck = false;
            if ($("#chkSavepPassword").is(":checked")) {
                Savepasswordcheck = true;
            }

            var TracesLogin = {
                "login": {
                    UserID: vm.UserID,
                    Password: vm.Password,
                    Tan: CurrentTANNO,
                    Save_password: Savepasswordcheck,
                    Captcha: vm.CaptchaCode,
                    Cookies: vm.Cookies
                }
            };

            //---------------------------
            //---------------------------



            //--POST REQUEST
            vm.loading = true;
            vm.RequestDisabled = true;
            $http.post(varURL + 'TService.asmx/LogIn', TracesLogin).success(function (data) {

                if (data.LoginToTracessResult.Response == "0") {
                    vm.GridDisplay = true;
                    vm.LoginDisplay = false;
                    vm.Cookies = data.LoginToTracessResult.Cookies;

                }
                else if (data.LoginToTracessResult.Response == "2") {
                    SessionLogoutDialog();
                }
                else {
                    vm.RefreshCaptcha();
                    vm.CaptchaCode = '';
                    alert(data.LoginToTracessResult.Message);
                }

                vm.loading = false;
                vm.RequestDisabled = false;
            }).error(function (data) {
                alert("An Error has occured while connecting to the server! " + data);
                vm.loading = false;
                vm.RefreshCaptcha();
                vm.CaptchaCode = '';
                vm.GridDisplay = false;
                vm.LoginDisplay = true;
                vm.RequestDisabled = false;

            });



        }


        vm.GetStatementFiled = function (rd) {

            if (vm.ddlFAYear == null || vm.ddlFAYear == undefined) {
                alert('Select FA Year');
                return;
            }
            if (vm.ddlQuarter == null || vm.ddlQuarter == undefined) {
                alert('Select Quarter');
                return;
            }
            if (vm.ddlForm == null || vm.ddlForm == undefined) {
                alert('Select Form');
                return;
            }

            var grid = obj.grid;

            grid.option("strLoading", "Downloading ..");
            grid.showLoading();
            vm.GoDisabled = true;
            $http.post(varURL + 'TService.asmx/reqStmFiled', { Cookies: vm.Cookies, Fy: vm.ddlFAYear.FAYear, Qtr: vm.ddlQuarter.Id, Form: vm.ddlForm.Name }).success(function (data) {

                vm.myData = JSON.parse(data.RequestStatementFiledResult.ResponseData).rows;

                $timeout(function () {
                    vm.gridOptions.grid.refresh();
                });

                grid.hideLoading();
                vm.GoDisabled = false;
            }).error(function (data) {
                alert("An Error has occured while connecting to the server! " + data);
                grid.hideLoading();
                vm.GoDisabled = false;
            });




        };



        vm.LogOut = function () {
            vm.TANNo = '';
            vm.UserID = '';
            vm.Password = '';

            // Added   on 28-12-2016
            vm.TANNo_Enter = '';

            //--------------------------------
            // Added   on 27-12-2016
            //--------------------------------
            $("#chkSavepPassword").prop("checked", false);

            $http.post(varURL + 'TService.asmx/LogOut', { strCookies: vm.Cookies }).success(function (data) {
                vm.RefreshCaptcha();
                vm.CaptchaCode = '';
                vm.GridDisplay = false;
                vm.LoginDisplay = true;

            }).error(function (data) {
                alert("An Error has occured while connecting to the server! " + data);
                grid.hideLoading();
            });
        }


        //------------------------------

        vm.isValid = function (value) {
            return !value
        }

        //------------------------------
        //------------------------------
        //---- Added   on 02-01-2017
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