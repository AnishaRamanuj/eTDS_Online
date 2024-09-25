<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>eTDS Online</title>
    <link href="../../TDS/BTStrp/css/all.min.css" rel="stylesheet" type="text/css" />
    <link href="../../TDS/BTStrp/icons/icomoon/styles.min.css" rel="stylesheet" type="text/css" />
    <link href="../../TDS/BTStrp/icons/fontawesome/styles.min.css" rel="stylesheet" type="text/css" />
    <link href="../../TDS/BTStrp/icons/material/styles.min.css" rel="stylesheet" type="text/css" />
    <link href="../../TDS/BTStrp/css/adminlte.min.css" rel="stylesheet" type="text/css" />
    <link href="../../TDS/BTStrp/css/colors.min.css" rel="stylesheet" type="text/css" />
    <link href="../../TDS/BTStrp/css/spinkit.css" rel="stylesheet" type="text/css" />
    <link href="../../TDS/BTStrp/css/components.css" rel="stylesheet" type="text/css" />
     
    <link rel="Stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback" />
     <!-- Core JS files -->
    <script src="../../TDS/BTStrp/js/jquery.min.js" type="text/javascript"></script>
    <script src="../../TDS/BTStrp/js/bootstrap.bundle.js" type="text/javascript"></script>
    <script src="../../TDS/BTStrp/js/adminlte.js" type="text/javascript"></script>
    <script src="../../TDS/BTStrp/js/blockui.min.js" type="text/javascript"></script>
    <script src="../../TDS/BTStrp/js/pnotify.min.js" type="text/javascript"></script>
    <script src="../../TDS/BTStrp/js/noty.min.js" type="text/javascript"></script>
    <script src="../../TDS/BTStrp/js/PopupAlert.js" type="text/javascript"></script>
    <script src="../../TDS/BTStrp/js/select2.min.js" type="text/javascript"></script>


    <script type="text/javascript">
        $(document).ready(function () {

            $("[id*=btnSubmit]").on('click', function () {
                Blockloadershow();
                Login();
            });


            $("#txtPassword").keypress(function (event) {
                if (event.keyCode === 13) {
                    Blockloadershow();
                    Login();
                }
            });

        });

        function Login() {
            var usr = $("[id*=txtUsername]").val();
            var pss = $("[id*=txtPassword]").val();

            $.ajax({
                type: "POST",
                url: "../Handler/Login.asmx/CheckLogin",
                data: '{usr:"' + usr + '", pass:"' + pss + '"}',
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    if (myList.length > 0) {
                        var msg = myList[0].Msg;
                        if (msg == 'Invalid Username or Password') {
                            showDangerAlert('Invalid Username or Password');
                        }
                        else {
                            if (myList[0].url == '') {
                                showDangerAlert(myList[0].Msg);
                            }
                            else {
                                var mod = myList[0].Msg
                                //if (mod == 'Both') {
                                //    $('#modal_Select').modal('show');
                                //}
                                //else {
                                window.location.href = myList[0].url;
                                //}
                            }
                        }
                    }
                    Blockloaderhide();
                },
                failure: function (response) {
                    Blockloaderhide();
                },
                error: function (response) {
                    Blockloaderhide();
                }
            });
        }
    </script>

</head>
<body class="login-page" style="min-height: 496.781px;">
    <!-- Content area -->
    <div class="login-box">
        <!-- Login form -->
        <form class="login-form" runat="server" >
            <div class="card">
                <div class="card-body login-card-body">
                  
                    <div class="text-center mb-2">
                        <div class="text-center">
                            <h5 class="card-title" style="margin-bottom: -1rem;"></h5>
                            <span class="font-weight-bold mb-0">Support Number</span>
                            <br />
                            <span class="mb-0" style="font-weight: 700;">9892606006, 9372893410</span>
                        </div>
                        <img src="images/logo.gif" class="rounded-round p-3 mb-3 mt-1" alt=""></img>
                        <h2 class="mb-0">Online TDS</h2>
                        <span class="d-block text-muted">Enter your credentials below</span>
                    </div>

                    <div class="input-group mb-3">
                        <input id="txtUsername" runat="server" type="text" class="form-control form-control-border" placeholder="Username" />
                        <%--<asp:TextBox ID="txtUsername"  runat="server" ForeColor="Black" Style="margin-top: 10px;" Width="150px"  placeholder="Username" ></asp:TextBox>--%>
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <i class="icon-user text-muted"></i>
                            </div>
                        </div>
                    </div>

                    <div class="input-group mb-3">
                        <input id="txtPassword" type="password" runat="server" class="form-control form-control-border" placeholder="Password" />
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <i class="icon-lock2 text-muted"></i>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <%--<asp:Button id="btnSubmit" runat="server"  Cssclass="btn btn-outline-success legitRipple" text="Sign In" OnClick="btnSubmit_Click" ></asp:Button>--%>
                         <button id="btnSubmit" type="button" class="btn btn-primary btn-block" >Login<i class="icon-circle-right2 ml-2"></i></button>
                    </div>

                    <div class="text-center">
                        <a href="login_password_recover.html">Forgot password?</a>
                    </div>
                </div>
            </div>
        </form>
        <!-- /login form -->

    </div>
    <!-- /content area -->
</body>
</html>
