/// <reference path="../Scripts/jquery.min.js" />
/// <reference path="../Scripts/angular.min.js" />


(function () {

    var obj = {
        width: "100%",
        //  height: 400,
        colModel: [
            {
                title: "Request Date", dataIndx: "reqDate", editable: false,
                template: '<span   ng-class="ri%2==0?\'bold_cls\':\'\'">{{rd.reqDate}}</span>'
            },
            { title: "Request Number", editable: false, dataType: "integer", dataIndx: "reqNo", template: '{{rd.reqNo}}' },
            { title: "Finnancial Year", editable: false, dataType: "string", dataIndx: "finYr", template: '{{rd.finYr}}' },
            { title: "Quarter", editable: false, dataType: "string", dataIndx: "qrtr", template: '{{rd.qrtr}}' },
            { title: "Form Type", editable: false, dataType: "string", dataIndx: "frmType", template: '{{rd.frmType}}' },
            { title: "File Processed", editable: false, dataType: "string", dataIndx: "dntype", template: '{{rd.dntype}}' },
            { title: "Status", editable: false, dataType: "string", dataIndx: "status", template: '{{rd.status}}' },
            { title: "Remarks", editable: false, dataType: "string", dataIndx: "remarks", template: '{{rd.remarks}}' },
             {
                 title: "", align: 'center', editable: false,
                 render: function (ui) {
                     var width = ui.column.outerWidth, ci = ui.colIndx
                     return '<button ng-show="{{rd.status ==\'Available\'}}" type="button"  class="btnCss btn btn-warning" ng-click="vm.showMe(rd)">Download</button>  ';
                 }
             }

        ],
        resizable: false,
        pageModel: { type: "local", rPP: 20 },
        collapsible: false,
        title: "",
        scrollModel: { autoFit: true },
        dataModel: { data: 'vm.myData' }
    };

    var app = angular.module('downfile', ['pq.grid', 'ui.bootstrap']);

    app.controller('downCtrl', function ($http, $timeout) {
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

        angular.element(document).ready(function () {
            $("#lblHeader").text("Requested Download");
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
        $http.post(varURL + "TService.asmx/TracesTan", { IsAddOtherTAN: true }).success(function (response) {

            vm.Tan_Lists = response.getCompanyTanListResult;
        }).error(function (response) {
            //Second function handles error
            vm.error = "Something went wrong";
        });
        //--------------------------------------------------------------------------------
        //-----------------------------------------------------------------------------------

        vm.getUser = function () {

            //----------------------------
            // added   on 27-12-2016
            //----------------------------
            var TAN_NO = vm.TANNo.TAN_NO;
            if (TAN_NO == "0") {
                $('#txtTanNo').val('');
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

        vm.RequestDownloads = function () {

            //---- Commented   on 28-12-2016
            //if (vm.isValid(vm.TANNo) || vm.isValid(vm.UserID) || vm.isValid(vm.Password)) {

            ////if ((vm.TANNo == null || vm.TANNo == undefined) || (vm.UserID == null || vm.UserID == undefined) || (vm.Password == null || vm.Password == undefined)) {
            //    alert('Enter User Login Details');
            //    return;
            //}
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

            //--------------------------------------------
            // Modify   on 27-12-2016
            //--------------------------------------------
            if (vm.isValid(vm.UserID) || vm.isValid(vm.Password)) {

                //if ((vm.TANNo == null || vm.TANNo == undefined) || (vm.UserID == null || vm.UserID == undefined) || (vm.Password == null || vm.Password == undefined)) {
                alert('Enter User Login Details');
                return;
            }

            if ((vm.TANNo_Enter == null || vm.TANNo_Enter == undefined) && (vm.TANNo == null || vm.TANNo == undefined)) {
                alert('TAN - Cannot be Blank');
                return;
            }

            var TAN_NO = vm.TANNo.TAN_NO;


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
            //--------------------------------------------
            //--------------------------------------------

            if (vm.isValid(vm.CaptchaCode)) {
                alert('Enter Captcha Code');
                return;
            }

            //----------------------------
            // Added   on 27-12-2016
            //----------------------------
            var CurrentTANNO = "";
            if (TAN_NO != "0") {
                CurrentTANNO = vm.TANNo.TAN_NO;
            }
            else {
                CurrentTANNO = $('#txtTanNo').val();
            }
            //----------------------------
            //----------------------------

            //----------------------------
            //added    on 02-01-2017
            //----------------------------
            var Savepasswordcheck = false;
            if ($("#chkSavepPassword").is(":checked")) {
                Savepasswordcheck = true;
            }
            //----------------------------
            //----------------------------


            //----------------------------
            // Commented   on 27-12-2016
            //----------------------------
            //var TracesLogin = {
            //    "objLogin": {
            //        UserID: vm.UserID, 
            //        Password: vm.Password, 
            //        Tan: vm.TANNo.TAN_NO,
            //        Captcha:vm.CaptchaCode,
            //        Cookies: vm.Cookies 
            //    }
            //};
            //----------------------------
            //----------------------------


            //----------------------------
            // Modify   on 02-01-2011
            //----------------------------
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
            //----------------------------
            //----------------------------

            //--POST REQUEST
            vm.loading = true;
            vm.RequestDisabled = true;
            $http.post(varURL + 'TService.asmx/reQList', TracesLogin).success(function (data) {

                if (data.RequestDownloadListResult.Response == "0") {
                    vm.GridDisplay = true;
                    vm.LoginDisplay = false;

                    vm.Cookies = data.RequestDownloadListResult.Cookies;
                    var jsonData = JSON.parse(data.RequestDownloadListResult.ResponseData);

                    vm.myData = jsonData.rows;

                    $timeout(function () {
                        vm.gridOptions.grid.refresh();
                    });

                } else {
                    vm.RefreshCaptcha();
                    vm.CaptchaCode = '';
                    alert(data.RequestDownloadListResult.Message);
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


        vm.showMe = function (rd) {

            var PWD = '';
            var Message = "";
            if (vm.TANNo.TAN_NO != "0")
                PWD = vm.TANNo.TAN_NO
            else
                PWD = vm.TANNo_Enter

            if (rd.dntype == 'NSDL Conso File') {
                Message = "The ZIP file containing the ‘Conso File’ is being downloaded.<br/>\
                           The password to extract the ‘Conso File’ is as under:<br /><br />\
                           &lt;TAN&gt;_&lt;RequestNumber&gt;<br/><b>" + PWD + "_" + rd.reqNo + "</b>";

                alert(Message, "html", "TRACES Download – Conso File");

            } else if (rd.dntype == 'Justification Report') {

                Message = "The ZIP file containing the ‘Justification Report’ is being downloaded.<br/>\
                           The password to extract the ‘Justification Report’ is as under:<br /><br />\
                           &lt;JR&gt_&lt;TAN&gt_&lt;FormType&gt_&lt;Quarter&gt_&lt;FY&gt<br/><b>JR_" + PWD + "_" + rd.frmType + "_" + rd.qrtr + "_" + rd.finYr + "</b>";

                alert(Message, "html", "TRACES Download – Justification Report");


            } else if (rd.dntype == 'Bulk Form 27D File' ||
                rd.dntype == 'Bulk Form 16A File' ||
                rd.dntype == 'Bulk Form 16 File') {

                Message = "The data file containing the requested TDS Certificates is being downloaded.<br/>\
                           Use this file through the TRACES PDF Convertor to generate the TDS Certificates in PDF format";

                alert(Message, "html", "TRACES Download – TDS Certificates");

            }




            //   alert(" Request No: " + rd.reqNo);




            var grid = obj.grid;

            grid.option("strLoading", "Downloading ..");
            grid.showLoading();
            //$http.post(varURL + 'TService.asmx/reQDownload', { strReqNo: rd.reqNo, strCookies: vm.Cookies }, { responseType: 'arraybuffer' }).success(function (data, status, headers, config) {
            $http.post(varURL + 'TService.asmx/checkDowl', { strReqNo: rd.reqNo, strCookies: vm.Cookies }).success(function (data) {

                var varCount = data.CheckDownloadStatusResult[0];

                if (parseInt(varCount) == -1) {

                    vm.RefreshCaptcha();
                    vm.CaptchaCode = '';
                    vm.GridDisplay = false;
                    vm.LoginDisplay = true;

                }
                else if (parseInt(varCount) == 0) {
                    DownloadFile(rd.reqNo, "");
                } else {

                    for (i = 1; i <= parseInt(varCount) ; i++) {
                        DownloadFile(data.CheckDownloadStatusResult[i], "Multiple");
                    }
                }
                grid.hideLoading();
                // grid.option("strLoading", $.paramquery.pqGrid.prototype.options.strLoading);

                // vm.loading = false;
            }).error(function (data) {
                alert("An Error has occured while connecting to the server! " + data);
                grid.hideLoading();
            });




        };

        function DownloadFile(strReq, Mode) {


            $http.post(varURL + 'TService.asmx/reQDownload', { strReqNo: strReq, strMode: Mode, strCookies: vm.Cookies }, { responseType: 'arraybuffer' }).success(function (data, status, headers, config) {
                var fName = headers()['content-disposition'];
                fName = fName.substring(fName.indexOf("=") + 1);

                if (fName != "") {
                    var blob = new Blob([data], { 'type': "application/octet-stream" });
                    var link = document.createElement('a');
                    link.href = window.URL.createObjectURL(blob);
                    link.download = fName.substring(fName.indexOf("=") + 1);
                    document.body.appendChild(link);
                    link.click();
                    document.body.removeChild(link);

                } else {
                    vm.RefreshCaptcha();
                    vm.CaptchaCode = '';
                    vm.GridDisplay = false;
                    vm.LoginDisplay = true;
                }


            }).error(function (data) {
                alert("An Error has occured while connecting to the server! " + data);
                // vm.loading = false;
            });
        }

        vm.LogOut = function () {
            vm.TANNo = '';
            vm.UserID = '';
            vm.Password = '';

            //--------------------------------
            // Added   on 27-12-2016
            //--------------------------------
            vm.TANNo_Enter = '';
            if (vm.TANNo == "0") {
                $("#txtTanNo").show();
            }
            else {
                $("#txtTanNo").hide();
            }

            $("#chkSavepPassword").prop("checked", false);

            //--------------------------------
            //--------------------------------

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
            $("#divSavePassword").show();
        });
        //-----------------------------------------
        //-----------------------------------------


    });


}());