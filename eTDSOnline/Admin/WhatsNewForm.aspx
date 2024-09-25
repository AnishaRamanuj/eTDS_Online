<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="WhatsNewForm.aspx.cs" Inherits="Admin_WatsNewForm" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../Scripts/moment.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-2.1.3.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../Scripts/jquery1.7.2.min.js"></script>
    <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>
    <link href="../css/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            GetRecord();

            $("[id*=btnAdd]").click(function () {
                $("[id*=hdnWid]").val(0);
                $("[id*=txtarea]").val('');
                $("[id*=txtUpdatedate]").val('');
                $("[id*=txtsubj]").val('');
                $find("mailingListModalPopupBehavior").show();
            });

            $("[id*=btnSave]").click(function () {
                SaveUpdate();
            });

        });

        function Del_Rec(i) {
            var row = i.closest("tr");
            var wid = row.find("input[name=hdnID]").val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../handler/WhatsNew.asmx/GetDelwhatnew",
                data: '{Wid:' + wid + '}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    if (myList[0].Id > 0) {
                        alert("Deleted Successfully!!!");

                        GetRecord();
                    }
                }
            });
        }


        function SaveUpdate() {
            var Wid = $("[id*=hdnWid]").val();
            var Update = $("[id*=txtUpdatedate]").val();
            var Subj = $("[id*=txtsubj]").val();
            var Descrp = $("[id*=txtarea]").val();
            //Ajax start
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../handler/WhatsNew.asmx/GetSaveUpdatewhatnew",
                data: '{Wid:' + Wid + ',Update:"' + Update + '",Subj:"' + Subj + '",Despt:"' + Descrp + '"}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    if (myList[0].Id > 0) {
                        alert("Saved Successfully!!!");
                    } else {
                        alert("Updated Successfully!!!");
                    }
                    $find("mailingListModalPopupBehavior").hide();
                    GetRecord();
                }
            });
        }

        function GetRecord() {
            //Ajax start
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../handler/WhatsNew.asmx/Getwhatnew",
                //data: '{}',
                dataType: "json",
                success: function (msg) {
                    var myList = jQuery.parseJSON(msg.d);
                    var tbody = "";
                    var Minutable = "";
                    var totaly = "";
                    var trL = $("[id*=tbl_recd] tbody tr:last-child");
                    $("[id*=tbl_recd] tbody").empty();
                    tbody = tbody + "<tr>";
                    tbody = tbody + "<th class='cssGridHeader' style='width:50px;'></th>";
                    tbody = tbody + '<th class="cssGridHeader" style="width:280px;">Updated Date</th>';
                    tbody = tbody + '<th class="cssGridHeader" style="width:550px;">Subject</th>';
                    tbody = tbody + '<th class="cssGridHeader" style="width:100px;">Delete</th>';
                    tbody = tbody + "</tr>";
                    if (myList.length > 0) {
                        for (var i = 0; i < myList.length; i++) {
                            tbody = tbody + "<tr '>";
                            tbody = tbody + "<td onclick='plusClick($(this))' style='text-align: center;'><input type='hidden' id='hdnID' value='" + myList[i].Wid + "' name='hdnID'></td>";
                            tbody = tbody + "<td onclick='plusClick($(this))'>" + myList[i].Updatedate + "</td>";
                            tbody = tbody + "<td onclick='plusClick($(this))'>" + myList[i].Subject + "<input type='hidden' id='hdndesp' value='" + myList[i].Descriptn + "' name='hdndesp'></td>";
                            tbody = tbody + "<td style='text-align: center;'><img src='../images/delete.png' style='cursor:pointer; height:18px; width:18px;' onclick='Del_Rec($(this))' id='stfDel' name='stfDel'></td>";
                            tbody = tbody + "</tr>";
                        }
                    }
                    $("[id*=tbl_recd]").append(tbody);
                }
            });
        }

        function plusClick(i) {
            var row = i.closest("tr");
            var mth = row.find("input[name=hdndesp]").val();
            var wid = row.find("input[name=hdnID]").val();
            $("[id*=hdnWid]").val(wid);
            var DateUp = row.find('td:eq(1)').text();
            var dt = DateUp.split('/')[0];
            var mn = DateUp.split('/')[1];
            var yr = DateUp.split('/')[2];
            //DateUp = moment(DateUp).format('YYYY-MM-DD');
            DateUp = yr + '-' + mn + '-' + dt;
            var subj = row.find('td:eq(2)').text();
            $("[id*=txtarea]").val(mth);
            $("[id*=txtUpdatedate]").val(DateUp);
            $("[id*=txtsubj]").val(subj);
            $find("mailingListModalPopupBehavior").show();
        }

    </script>


    <style type="text/css">
        .modal {
            position: fixed;
            z-index: 999;
            height: 100%;
            width: 100%;
            top: 0;
            filter: alpha(opacity=60);
            opacity: 0.6;
            -moz-opacity: 0.8;
        }

        .center {
            z-index: 1000;
            margin: 300px auto;
            padding: 10px;
            width: 64px;
            border-radius: 10px;
            filter: alpha(opacity=100);
            opacity: 1;
            -moz-opacity: 1;
        }

            .center img {
                height: 64px;
                width: 64px;
            }

        .rightSave {
            position: absolute;
            right: 200px;
            height: 27px;
            padding-left: 15px;
            padding-left: 15px;
            padding-top: 2px;
            top: 135px;
        }

        .rightCancel {
            position: absolute;
            right: 100px;
            height: 27px;
            padding-left: 15px;
            padding-left: 15px;
            top: 135px;
        }

        .Pager b {
            margin-top: 2px;
            float: left;
        }

        .Pager span {
            text-align: center;
            display: inline-block;
            width: 20px;
            margin-right: 3px;
            line-height: 150%;
            border: 1px solid #BCBCBC;
        }

        .Pager a {
            text-align: center;
            display: inline-block;
            width: 20px;
            background-color: #BCBCBC;
            color: #fff;
            border: 1px solid #BCBCBC;
            margin-right: 3px;
            line-height: 150%;
            text-decoration: none;
        }

        .txt_grds {
        }

        .Head1 {
            font-size: 14px;
            font-family: Verdana,Arial,Helvetica,sans-serif;
            color: #3D80E8;
            font-weight: bold;
            overflow: hidden;
            border-bottom-color: White;
        }

        .divspace {
            height: 20px;
        }

        .headerpage {
            height: 23px;
            width: 100%;
        }

        .Button {
            font-family: Verdana,Arial,Helvetica,sans-serif;
            font-size: 11px;
            font-weight: 600;
            height: 25px;
            color: #1464F4;
            -webkit-border-radius: 4px;
            -moz-border-radius: 4px;
            border-radius: 4px;
            cursor: pointer;
        }

        .modalganesh {
            z-index: 999999;
        }

        .cssPageTitle {
            font: bold 14px verdana, arial, "Trebuchet MS", sans-serif;
            border-bottom: 2px solid #0b9322;
            color: #0b9322;
        }

        .cssButton {
            cursor: pointer; /*background-image: url(../Images/ButtonBG1.png);*/
            background-color: #d3d3d3;
            border: 0px;
            padding: 4px 15px 4px 15px;
            color: Black;
            border: 1px solid #c4c5c6;
            border-radius: 3px;
            font: bold 12px verdana, arial, "Trebuchet MS", sans-serif;
            text-decoration: none;
            opacity: 0.8;
        }

            .cssButton:focus {
                background-color: #69b506;
                border: 1px solid #3f6b03;
                color: White;
                opacity: 0.8;
            }

            .cssButton:hover {
                background-color: #69b506;
                border: 1px solid #3f6b03;
                color: White;
                opacity: 0.8;
            }

        .cssPageTitle2 {
            font: bold 14px verdana, arial, "Trebuchet MS", sans-serif;
            /*border-bottom: 2px solid #0b9322;*/
            padding: 7px;
            color: #0b9322;
        }

        .allTimeSheettle tr:hover {
            cursor: inherit;
            background: #F2F2F2;
            border: 1px solid #ccc;
            padding: 5px;
            color: #474747;
        }

        .allTimeSheettle {
            cursor: pointer;
        }

        .property_tab .ajax__tab_tab {
            background: none repeat scroll 0 0 rgba(0, 0, 0, 0);
            font-weight: bold;
            height: 35px !important;
            margin: 0;
            padding: 8px 15px !important;
        }

        .tbl {
            border-collapse: collapse;
            background-color: #fff;
        }

            .tbl img {
                margin: -3px;
                cursor: pointer;
            }

            .tbl tbody tr td {
                background-color: inherit;
                font: normal 12px verdana, arial, "Trebuchet MS", sans-serif;
                padding: 5px;
                border: 1px solid #BCBCBC;
            }

            .tbl thead tr th {
                background: rgba(219,219,219,0.54);
                padding: 5px;
                border: 1px solid #BCBCBC;
                font: 12px verdana, arial, "Trebuchet MS", sans-serif;
                font-weight: bold;
            }

            .tbl tfoot tr th {
                background: rgba(219,219,219,0.54);
                padding: 5px;
                border: 1px solid #BCBCBC;
                font: 12px verdana, arial, "Trebuchet MS", sans-serif;
                font-weight: bold;
            }

            .tbl tbody tr th {
                background: rgba(219,219,219,0.54);
                padding: 5px;
                border: 1px solid #BCBCBC;
            }

        .cssGrdAlterItemStyle {
            font: normal 12px verdana, arial, "Trebuchet MS", sans-serif;
            background-color: #fefefe;
            height: 18px;
        }

            .cssGrdAlterItemStyle:hover {
                background-color: #f7f7f7;
            }

        .thead {
            font-family: "Courier New", Courier, monospace;
            font-size: 30px;
            font-style: italic;
            font-weight: bold;
            text-decoration: underline;
            text-align: center;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">
    <asp:HiddenField runat="server" id="hdnWid" Value ="0"/>
    <label class="thead">
        What's New Form
    </label>
    <div>
        <input type="button" id="btnAdd" value="Add" class="cssButton" />
    </div>
    <%-- <form id="form1" style="padding-top: 30px;" runat="server">--%>
    <%--     <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="360000"
            ScriptMode="Release">
        </asp:ScriptManager>--%>
    <div id="Div20" class="comprw">
        <cc1:ModalPopupExtender runat="server" ID="ModalPopupExtender1" BehaviorID="mailingListModalPopupBehavior"
            TargetControlID="hiddenLargeImage" PopupControlID="panelupgrade" BackgroundCssClass="modalBackground"
            OkControlID="imgClose" DropShadow="false" RepositionMode="RepositionOnWindowScroll">
        </cc1:ModalPopupExtender>
        <asp:Panel ID="panelupgrade" runat="server" Width="600px" Height="420px" BackColor="#FFFFFF">
            <asp:Button ID="hiddenLargeImage" runat="server" Style="display: none" />
            <div id="Div59" style="width: 100%; float: left; background-color: #55A0FF; color: #ffffff; font-weight: bold;">
                <div id="Div23" style="width: 90%; float: left; height: 20px; padding-left: 2%; padding-top: 10px">
                    <label class="ui-dialog-title">Input Details</label>

                </div>
                <div id="Div60" style="width: 8%; float: left; padding-top: 1%; text-align: right;">
                    <img src="../images/error.png" alt="image" id="imgClose" border="0" name="imgClose" />
                </div>
            </div>

            <div style="width: 590px; float: left; overflow: hidden; height: 380px; padding-top: 5px; padding-bottom: 5px;">
                <table>
                    <tr>
                        <td style="width: 100px;">
                            <label style="font-weight: bold;">Updated Date</label></td>
                        <td>
                        <input type="Date" id="txtUpdatedate" name="txtUpdatedate"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label style="font-weight: bold;">Subject</label>
                        </td>
                        <td>
                            <input type="text" class="cssTextbox" id="txtsubj" style="width: 200px" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label style="font-weight: bold;">Description</label></td>
                        <td>
                            <textarea id="txtarea" class="cssTextbox" style="height: 214px; width: 417px">
              </textarea>
                        </td>
                    </tr>
                    <tr><td></td>
                        <td><input type="button" class="cssButton" id="btnSave" name="btnSave" value="Save" /></td>
                    </tr>
                </table>


            </div>
        </asp:Panel>

    </div>
    <div>
        <table id="tbl_recd" class="norecordTble tbl allTimeSheettle" style="border-collapse: collapse; width: 100%; font-family: Verdana;">
        </table>
    </div>
    <%--</form>--%>
</asp:Content>

