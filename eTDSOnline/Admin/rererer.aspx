<%@ Page Title="" Async="true" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="rererer.aspx.cs" Inherits="Admin_rererer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .modalBackground2
        {
            background-color: Black;
            filter: alpha(opacity=60);
            opacity: 0.3;
            min-height: 400px;
            padding-top: 100px;
            display: none;
        }
        .modalPopup
        {
            margin: auto;
            width: 280px;
            background-color: #FFFFFF;
            border-radius: 10px;
            font-family: Calibri;
            font-size: 15px;
            font-weight: bold;
            text-align: center;
            color: red;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            // TODO: revert the line below in your actual code
            //$("#progressbar").progressbar();
            setTimeout(updateProgress,100);
        });

        function updateProgress() {
            $.ajax({
                type: "POST",
                url: "rererer.aspx/GetData",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function (msg) {
                    // TODO: revert the line below in your actual code
                    //$("#progressbar").progressbar("option", "value", msg.d);
                    $("#percentage").text(msg.d);
                    if(msg.d<100) {
                        setTimeout(updateProgress,100);
                    }
                }
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:Button ID="Button1" runat="server" Text="Button1" OnClick="Button1_Click" />
    Percentage:<asp:Label ID="percentage" runat="server"></asp:Label>
    <div class="modalBackground2">
        <div class="modalPopup">
            <table align="center">
                <tr>
                    <td>
                        <div class="loading">
                            <table align="center">
                                <tr>
                                    <td>
                                        <img src="../Images/loader.gif" alt="" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="itwilltakefewmin">
                            <table align="center">
                                <tr>
                                    <td>
                                        It Will Take Few Minutes. Please Wait !
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="divtextgenerate" style="display: none">
                            <table align="center">
                                <tr>
                                    <td>
                                        Generating Text File Please Wait !
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="divtextgenerated" style="display: none">
                            <table align="center">
                                <tr>
                                    <td>
                                        <img src="../Images/valid.png" alt="" />
                                    </td>
                                    <td>
                                        Text File Generated Successfully
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="divvalidataing" style="display: none">
                            <table align="center">
                                <tr>
                                    <td>
                                        Validating Text File Please Wait !
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <asp:Label runat="server" ID="bdb"></asp:Label>
    <asp:Label runat="server" ID="Label1"></asp:Label>
</asp:Content>
