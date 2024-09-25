<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="XL27Q.aspx.cs" Inherits="Admin_XL27Q" %>


<%@ Register Src="../Controls/MessageControl.ascx" TagName="MessageControl" TagPrefix="UC" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MasterPage" runat="Server">

    <table id="Table1" width="100%" height="600px" cellpadding="5" cellspacing="0">
        <tr height="5px" valign="top">
            <td class="cssPageTitle">
                <asp:Label ID="Label1" runat="server" Text="Form 27Q Voucher Excel Import"></asp:Label>
            </td>
        </tr>
        <tr height="5px">
            <td>
                <UC:MessageControl runat="server" ID="MessageControl1" />
            </td>
        </tr>
        <tr height="5px">
            <td>
                <label style="font-weight: bold">Step 1</label>

                <a style="padding-right: 50px;" href="../XL File/27Q_2223_Blank.xlsx">
                    <input type="button" class="cssButton" value="Download Blank Excel Sheet" />
                    <%-- <img alt="" src="../images/icons8-microsoft-excel-48.png" class="imageEx" />--%>
                </a>

                <label style="font-weight: bold">Step 2</label>
                <input type="file" name="postedFile" id="file"/>
                <input type="submit" id="btnUpload" value="Upload" onclick="return ExcelUpload();" class="cssButton" />
                &nbsp;
                <input id="btnUpdate" name="btnUpdate" type="button" class="cssButton" value="Update Record(s)" onclick="return ExcelUpdate();" style="display: none;" />
            </td>
        </tr>
        <tr>
            <td style="vertical-align: top; display: none; padding-top: 10px;" id="tdTotal">

                <label style="font-weight: bold; color: green;">Imported Successfully Records :</label>


                <label id="lblSucc" style="font-weight: bold; color: green;">0</label>

                <label style="font-weight: bold; color: red; padding-left: 10px;">Error Found Records :</label>



                <label id="lblError" style="font-weight: bold; color: red;">0</label>
            </td>
        </tr>

        <tr>
            <td style="vertical-align: top; padding-top: 20px;">
                <div style="width: 1200px; margin: auto; white-space: nowrap; overflow-x: auto;" id="divData">
                </div>
            </td>
        </tr>

    </table>

    <%-- <input type="text" style="display: none" id="txttraceuserid" />
    <input type="text" style="display: none" id="txttracepwd" />--%>


    <%--Jquery Confirm--%>

    <link href="../css/jquery-confirm.min.css" rel="stylesheet" />
    <link href="../css/common.css" rel="stylesheet" />

    <!--JS File -->
    <script type="text/javascript" src="../customScript/jquery-confirm.min.js"></script>
    <script type="text/javascript" src="../customScript/common.js"></script>


    <script type="text/javascript">

        function ExcelUpload() {

            if ($('#file').get(0).files.length === 0) {
                ShowErrorWindow("Please upload a file.");
                return false;
            }

            $(".MastermodalBackground2").show();
            ///create a new FormData object
            var formData = new FormData(); //var formData = new FormData($('form')[0]);

            ///get the file and append it to the FormData object
            formData.append('file', $('#file')[0].files[0]);

            ///AJAX request
            $.ajax(
                {
                    ///server script to process data
                    url: '../Handler/xl27Q.ashx', //web service
                    type: 'POST',
                    complete: function () {
                        //on complete event    

                    },
                    progress: function (evt) {
                        //progress event    
                    },
                    ///Ajax events
                    beforeSend: function (e) {
                        //before event  
                    },
                    success: function (data) {
                        //success event

                        $("#file").val('');
                        BindData(data);


                        $(".MastermodalBackground2").hide();
                    },
                    error: function (e) {
                        //errorHandler
                        $(".MastermodalBackground2").hide();
                        ShowErrorWindow('Excel Sheet column mismatch or invalid date format');
                    },
                    ///Form data
                    data: formData,
                    ///Options to tell JQuery not to process data or worry about content-type
                    cache: false,
                    contentType: false,
                    processData: false
                });
            ///end AJAX request
            return false;
        }


        function BindData(ds) {
            if (ds.Table1 == undefined) {
                ShowErrorWindow('Connectivity Error, Upload again');
                return false;
            }
            $("#tdTotal").css("display", "");
            $("#lblSucc").html(ds.Table[0]["Success"]);
            $("#lblError").html(ds.Table[0]["error"]);
            if (ds.Table1.length <= 0) {
                $("#btnUpdate").css("display", "none");
                ShowSuccessWindow("Successfully uploaded, No errors found!");
                $("#divData").html('');
                return false;

                //  ShowErrorWindow("Invalid Details!");

            }


            $("#btnUpdate").css("display", "");
            dt = ds.Table1;

            var tbl_html_val = "<table id=\"tblRequestedDownloads\"  cellpadding=\"0\" cellspacing=\"0\" style=' width: 1200px; margin:auto; border:1px solid #dcdcdc;'>";
            tbl_html_val = tbl_html_val +
                "<thead>" +
                "<tr style='background-color: rgba(194, 226, 250, 1);height:25px;'>" +
                "<th ><b>Error Message</b></th>" +
                "<th style='width:120;'><b>Deductee Code</b></th>" +
                "<th style='width:120;'><b>PAN No</b></th>" +
                "<th ><b>Deductee Name</b></th>" +
                //"<th style='width:120;'><b>Section Code</b></th>" +
                "<th ><b>Section Description</b></th>" +
                "<th ><b>Payment /Credit Date (dd/mm/yyyy)</b></th>" +
                "<th ><b>Amount Paid/Credited</b></th>" +
                "<th ><b>TDS</b></th>" +
                "<th ><b>Surcharge</b></th>" +
                "<th ><b>Education Cess</b></th>" +
                "<th ><b>Total Tax Deducted</b></th>" +
                "<th ><b>Rate at which deducted</b></th>" +
                "<th ><b>Reason </b></th>" +
                "<th ><b>Certificate No</b></th>" +
                "<th ><b>Tax Identification</b></th>" +
                "<th ><b>TDS Rate Code</b></th>" +
                "<th ><b>Country</b></th>" +
                "<th ><b>Remitance</b></th>" +
                "<th ><b>Email</b></th>" +
                "<th ><b>Contact No</b></th>" +
                "<th ><b>Nri Address</b></th>" +

                "</tr>" +
                "</thead>" +
                "<tbody>";

            var errorNumber = "", errorColorStartTag = "<span style='color:red; word-wrap: break-word;'>", errorColorEndTag = "</span>",
                contentEditable = " contenteditable =\"true\"";

            for (var i = 0; i < dt.length; i++) {

                if (i == 0) {
                    FDate = dt[i]["FDate"];
                    TDate = dt[i]["TDate"];                 
                }

                errorNumber = dt[i]["errorNumber"];

                tbl_html_val += "<tr>";
                tbl_html_val += "<td style='font-size:11px; word-wrap: break-word; width:220px;'>" + errorColorStartTag + dt[i]["ErrorMessage"] + errorColorEndTag + "</td>";
                 
                //tbl_html_val += "<td >" + dt[i]["Deductee_Code"] + "<input type='hidden' id='hdnID_" + i + "' value='" + dt[i]["ID"] + "' /></td>";
                tbl_html_val += BindRow_DeducteeCode(dt[i]["Deductee_Code"], 1, "Deductee_Code" + i, dt[i]["ID"], i);

                if (errorNumber.indexOf("1") > -1 || errorNumber.indexOf("2") > -1  || errorNumber.indexOf("5") > -1) {
                    // tbl_html_val += "<td" + contentEditable + ">" + errorColorStartTag + dt[i]["PAN_of_Deductee"] + errorColorEndTag + "</td>"
                    tbl_html_val += BindRow(dt[i]["PAN_of_Deductee"], 1, "PAN_of_Deductee_" + i);
                }
                else {
                    tbl_html_val += BindRow(dt[i]["PAN_of_Deductee"], 0, "PAN_of_Deductee_" + i);
                }

                //tbl_html_val += "<td style='word-wrap: break-word; width:220px;'>" + dt[i]["Name_Of_Deductee"] + "</td>"
                if (errorNumber.indexOf("6") > -1) {
                    tbl_html_val += BindRow(dt[i]["Name_Of_Deductee"], 1, "Name_Of_Deductee" + i);
                }
                else {
                    tbl_html_val += BindRow(dt[i]["Name_Of_Deductee"], 0, "Name_Of_Deductee" + i);
                }
                //tbl_html_val += BindRow_Section_Code(dt[i]["Section_Code"], 0, "Section_Code_" + i, ds); ////  "<td>" + dt[i]["Section_Code"] + "</td>"
                tbl_html_val += BindRow_Section(dt[i]["Section_Description"], 0, "Section_Description_" + i, ds); ////"<td>" + dt[i]["Section_Description"] + "</td>"

                if (errorNumber.indexOf("8") > -1) {
                    /// tbl_html_val += "<td" + contentEditable + ">" + errorColorStartTag + dt[i]["Payment_CreditDate"] + errorColorEndTag + "</td>"
                    tbl_html_val += BindRow(dt[i]["Payment_CreditDate"], 1, "Payment_CreditDate_" + i);
                }
                else {
                    tbl_html_val += BindRow(dt[i]["Payment_CreditDate"], 0, "Payment_CreditDate_" + i);
                }

                tbl_html_val += BindRow(dt[i]["Amount_Paid_Credited"], 1, "Amount_Paid_Credited_" + i);


                if (errorNumber.indexOf("3") > -1 || errorNumber.indexOf("4") > -1) {
                    //tbl_html_val += "<td" + contentEditable + ">" + errorColorStartTag + dt[i]["TDS"] + errorColorEndTag + "</td>"
                    tbl_html_val += BindRow(dt[i]["TDS"], 1, "TDS_" + i);
                }
                else {
                    tbl_html_val += BindRow(dt[i]["TDS"], 0, "TDS_" + i);
                }



                if (errorNumber.indexOf("3") > -1) {
                    //tbl_html_val += "<td" + contentEditable + ">" + errorColorStartTag + dt[i]["Surcharge"] + errorColorEndTag + "</td>"
                    tbl_html_val += BindRow(dt[i]["Surcharge"], 1, "Surcharge_" + i);
                }
                else {
                    tbl_html_val += BindRow(dt[i]["Surcharge"], 0, "Surcharge_" + i);
                }



                if (errorNumber.indexOf("3") > -1) {
                    tbl_html_val += BindRow(dt[i]["Education_Cess"], 1, "Education_Cess_" + i);
                }
                else {
                    tbl_html_val += BindRow(dt[i]["Education_Cess"], 0, "Education_Cess_" + i);
                }

                if (errorNumber.indexOf("3") > -1) {
                    tbl_html_val += BindRow(dt[i]["Total_Tax_Deducted"], 1, "Total_Tax_Deducted_" + i);
                }
                else {
                    tbl_html_val += BindRow(dt[i]["Total_Tax_Deducted"], 1, "Total_Tax_Deducted_" + i);
                }


                tbl_html_val += BindRow(dt[i]["Rate_at_which_deducted"], 0, "Rate_at_which_deducted_" + i);

                if (errorNumber.indexOf("2") > -1 || errorNumber.indexOf("6") > -1 || errorNumber.indexOf("5") > -1 || errorNumber.indexOf("7") > -1) {
                    tbl_html_val += BindRow_Reason(dt[i]["Reason_for_Non_deduction_Lower_Deduction"], 1, "Reason_for_Non_deduction_Lower_Deduction_" + i);
                }
                else {

                    tbl_html_val += BindRow_Reason(dt[i]["Reason_for_Non_deduction_Lower_Deduction"], 0, "Reason_for_Non_deduction_Lower_Deduction_" + i);
                }


                if (dt[i]["Certificate_number_for_Lower_NonDeduction"] !='') {
                    tbl_html_val += BindRow(dt[i]["Certificate_number_for_Lower_NonDeduction"], 1, "Certificate_number_for_Lower_NonDeduction_" + i);
                }
                else {

                    tbl_html_val += BindRow(dt[i]["Certificate_number_for_Lower_NonDeduction"], 1, "Certificate_number_for_Lower_NonDeduction_" + i);
                }

                ////////////////


                tbl_html_val += BindRow(dt[i]["Tax_Identification"], 1, "Tax_Identification_" + i);
                tbl_html_val += BindRow_NriCode(dt[i]["TDS_Rate_Code"], 1, "TDS_Rate_Code_" + i);
                tbl_html_val += BindRow_Country(dt[i]["Country"], 1, "Country_" + i, ds);
                tbl_html_val += BindRow_Remittance(dt[i]["Remittance"], 1, "Remittance_" + i, ds);
                tbl_html_val += BindRow(dt[i]["email"], 1, "email_" + i);
                tbl_html_val += BindRow(dt[i]["Contact_no"], 1, "Contact_no_" + i);
                tbl_html_val += BindRow(dt[i]["Nri_Address"], 1, "Nri_Address_" + i);


                tbl_html_val += "</tr>";
            }
            tbl_html_val += "</tbody>";
            tbl_html_val += "</table>";
            $("#divData").html(tbl_html_val);
            $('#tblRequestedDownloads > tbody  > tr').each(function () {
                row = $(this).closest("tr");
                var rIndex = $(this).closest("tr")[0].sectionRowIndex;

                var rr = $("#hdn", row).val();
                //var sc = $("#hdnscode", row).val();
                var sd = $("#hdnSdrc", row).val();

                var rm = $("#hdnRem", row).val();
                var ct = $("#hdnCnt", row).val();
                var nr = $("#hdnNri", row).val();
                
                //sd = sd.split(' ');
                //var dsc = sd[0];
                //$("#Section_Code_" + rIndex, row).val(sc);
                $("#Section_Description_" + rIndex, row).val(sd);
                $("#Reason_for_Non_deduction_Lower_Deduction_" + rIndex, row).val(rr);
                $("#Remittance_" + rIndex, row).val(rm);
                $("#TDS_Rate_Code_" + rIndex, row).val(nr);
                $("#Country_" + rIndex, row).val(ct);


            });

            $(".MastermodalBackground2").hide();
            fnBlur();
        }


        function ExcelUpdate() {
            //   $("#btnUpdate").css("display", "none");

            var datas = [];
            var i;


            $("#divData tr").each(function (j, v) {
                if (j > 0) {
                    i = j - 1;
                    //  data[i] = Array();
                    var s = $(this).find("#Payment_CreditDate_" + i).val();
                    if (s.length > 0) {
                        s = s.split('/');
                        s = s[2] + '-' + s[1] + '-' + s[0];
                    }
                    data = {
                        Id: $(this).find("#hdnID_" + i).val(),
                        Deductee_Code: $(this).find("#Deductee_Code" + i).val(),
                        PAN_of_Deductee: $(this).find("#PAN_of_Deductee_" + i).val(),
                        Name_Of_Deductee: $(this).find("#Name_Of_Deductee" + i).val(),
                        //Section_Code: $(this).find("#Section_Code_" + i).val(),
                        Section_Description: $(this).find("#Section_Description_" + i).val(),

                        Payment_CreditDate: s,
                        TDS: $(this).find("#TDS_" + i).val(),
                        Surcharge: $(this).find("#Surcharge_" + i).val(),
                        Education_Cess: $(this).find("#Education_Cess_" + i).val(),
                        Total_Tax_Deducted: $(this).find("#Total_Tax_Deducted_" + i).val(),
                        Reason_for_Non_deduction_Lower_Deduction: $(this).find("#Reason_for_Non_deduction_Lower_Deduction_" + i).val(),
                        Certificate_number_for_Lower_NonDeduction: $(this).find("#Certificate_number_for_Lower_NonDeduction_" + i).val(),
                        Tax_Identification: $(this).find("#Tax_Identification_" + i).val(),
                        TDS_Rate_Code: $(this).find("#TDS_Rate_Code_" + i).val(),
                        Country: $(this).find("#Country_" + i).val(),
                        Remittance: $(this).find("#Remittance_" + i).val(),
                        email: $(this).find("#email_" + i).val(),
                        Contact_no: $(this).find("#Contact_no_" + i).val(),
                        Nri_Address: $(this).find("#Nri_Address_" + i).val(),
                        Amount_Paid_Credited: $(this).find("#Amount_Paid_Credited_" + i).val()
                    };

                    datas.push(data);
                }
            })

            var dataarr = {
                "voucherDtls": data
            };

            //debugger;
            $.ajax({
                type: "POST",
                url: "XL27Q.aspx/UpdateRecords",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{voucherDtls:" + JSON.stringify(datas) + "}",
                success: function (data) {
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

        var FDate = "", TDate = "";

        function BindRow(value, error, id) {
            var htm = "";
            if (error == 1) {
                htm = "<td  style='width:120;'><input id='" + id + "' style=' border: 1px solid red; width:100px;' value='" + value + "'/></td>";
            }
            else {
                //htm = "<td  style='width:120;'><input id='" + id + "' style='width:100px;' value='" + value + "' disabled /></td>";//Comment by Krutika on 3 July 2023
                htm = "<td  style='width:120;'><input id='" + id + "' style='width:100px;' value='" + value + "'  /></td>";//Added by Krutika on 3 July 2023
            }
            return htm;
        }


        function BindRow_Reason(value, error, id) {
            var htm = "";
            var opt = "";

            opt = "Select~Presc.Rt.~Lower Rt. Under Section 197 A~No Tax only for sec 194, 194A, 194EE, 193, 194DA, 192A, 194I(a), 194I(b) & 194D B~";
            opt = opt + "Non-Availability of PAN C~Transporter transaction and valid PAN is provided T~For software acquired under section 194J S~";
            opt = opt + "No Tax on A/c of pmt under sec 197A Z~Deduction upto Rs. 50000/- in respect of interest income from deposits held by Senior Citizens u/s 80TTB R~";
            opt = opt + "No Deduction on account of payment made to a person under section 194N N~No Deduction or lower deduction is on account of payment made to a person  under sub-section (5) of section 194A D~";
            opt = opt + "No Deduction is as per the provisions of sub-section (2A) of section 194LBA O~No Deduction or lower deduction under second provison to section 194N M~";
            opt = opt + "No deduction  being made to a person referred In Board Circular no. 3 of 2002 or Circular 11 of 2002 E~";
            opt = opt + "No deduction is on account of payment of dividend made to a business trust 194 P~No deduction in view of payment made to an entity referred to in clause (x) of sub-section (3) of section 194A Q~";
            opt = opt + "Deduction is on higher rate in view of section 206AB for non-filing of return of income U";
            var M = opt.split('~');

            var drp = "<select id='" + id + "' name='" + id + "' class='Dropdown' style='width:250px; height:25px; font-size: 12px;'>"
            for (var i = 0; i < M.length; i++) {
                drp = drp + "<option value='" + M[i] + "'>" + M[i] + "</option>"
            }
            drp = drp + "</select>"
 



            if (error == 1) {
                htm = "<td>" + drp + " <input id=hdn type='hidden' name=hdn value='" + value + "'/></td>";
            }
            else {
                htm = "<td>" + drp + " <input id=hdn type='hidden' name=hdn value='" + value + "' disabled /></td>";
            }
            return htm;
        }

        function BindRow_Section_Code(value, error, id , ds) {
            var htm = "";
            var dt = '';
            dt = ds.Table2;
            var drp = "<select id='" + id + "' name='" + id + "' class='Dropdown' style='width:100px; height:25px; font-size: 12px;'>"
            drp = drp + "<option value=''>--Select--</option>"
            for (var i = 0; i < dt.length; i++) {
                drp = drp + "<option value='" + dt[i]["Section"] + "'>" + dt[i]["Section"] + "</option>"
            }
            drp = drp + "</select>"

            if (error == 1) {
                htm = "<td style='width:120;'>" + drp + " <input id=hdnscode type='hidden' name=hdnscode value='" + value + "'/></td>";
            }
            else {
                htm = "<td style='width:120;'>" + drp + " <input id=hdnscode type='hidden' name=hdnscode value='" + value + "' disabled /></td>";
            }
            return htm;
        }

        function BindRow_DeducteeCode(value, error, id, Rid, j) {
            var htm = "";
            var opt = "";
            opt = "Select~Company~Others~Individual";
            var M = opt.split('~');

            var drp = "<select id='" + id + "' name='" + id + "' class='Dropdown' style='width:250px; height:25px; font-size: 12px;'>"
            for (var i = 0; i < M.length; i++) {
                if (M[i] == value)
                    drp = drp + "<option value='" + M[i] + "' selected='selected'>" + M[i] + "</option>"
                else
                    drp = drp + "<option value='" + M[i] + "'>" + M[i] + "</option>"
            }
            drp = drp + "</select>"

            if (error == 1) {
                htm = "<td>" + drp + " <input type='hidden' id='hdnID_" + j + "' value='" + Rid + "' /></td>";
            }
            else {
                htm = "<td>" + drp + " <input type='hidden' id='hdnID_" + j + "' value='" + Rid + "' /></td>";
            }
            return htm;
        }

        function BindRow_Section (value, error, id, ds) {
            var htm = "";
            var dt = '';
            dt = ds.Table2;
            var drp = "<select id='" + id + "' name='" + id + "' class='Dropdown' style='width:250px; height:25px; font-size: 12px;'>"
            drp = drp + "<option value=''>--Select--</option>"
            for (var i = 0; i < dt.length; i++) {
                drp = drp + "<option value='" + dt[i]["Nature_Name"] + "'>" + dt[i]["Nature_Name"] + "</option>"
            }
            drp = drp + "</select>"

            if (error == 1) {
                htm = "<td>" + drp + " <input id=hdnSdrc type='hidden' name=hdnSdrc value='" + value + "'/></td>";
            }
            else {
                htm = "<td>" + drp + " <input id=hdnSdrc type='hidden' name=hdnSdrc value='" + value + "' disabled /></td>";
            }
            return htm;
        }

        function BindRow_Country(value, error, id, ds) {
            var htm = "";
            var dt = '';
            dt = ds.Table4;
            var drp = "<select id='" + id + "' name='" + id + "' class='Dropdown' style='width:250px; height:25px; font-size: 12px;'>"
            drp = drp + "<option value=''>--Select--</option>"
            for (var i = 0; i < dt.length; i++) {
                drp = drp + "<option value='" + dt[i]["Country_Name"] + "'>" + dt[i]["Country_Name"] + "</option>"
            }
            drp = drp + "</select>"


            htm = "<td>" + drp + " <input id=hdnCnt type='hidden' name=hdnCnt value='" + value + "'/></td>";

            return htm;
        }

        function BindRow_Remittance(value, error, id, ds) {
            var htm = "";
            var dt = '';
            dt = ds.Table3;
            var drp = "<select id='" + id + "' name='" + id + "' class='Dropdown' style='width:250px; height:25px; font-size: 12px;'>"
            drp = drp + "<option value=''>--Select--</option>"
            for (var i = 0; i < dt.length; i++) {
                drp = drp + "<option value='" + dt[i]["REMITTANCE"] + "'>" + dt[i]["REMITTANCE"] + "</option>"
            }
            drp = drp + "</select>"

            
            htm = "<td>" + drp + " <input id=hdnRem type='hidden' name=hdnRem value='" + value + "'/></td>";
            return htm;
        }

        function BindRow_NriCode(value, error, id) {
            var htm = "";
            var opt = "";
            opt = "If TDS rate is as per Income TaxAct A~If TDS rate is as per DTAA B~";

            var M = opt.split('~');

            var drp = "<select id='" + id + "' name='" + id + "' class='Dropdown' style='width:250px; height:25px; font-size: 12px;'>"
            drp = drp + "<option value=''>--Select--</option>"
            for (var i = 0; i < M.length; i++) {
                drp = drp + "<option value='" + M[i] + "'>" + M[i] + "</option>"
            }
            drp = drp + "</select>"


            htm = "<td>" + drp + " <input id=hdnNri type='hidden' name=hdnNri value='" + value + "'/></td>";

            return htm;
        }

        function fnBlur() {


            $('#divData :input').on('blur', function (e) {


                var id = $(this).attr("id");
                var rowno = id.substring( id.lastIndexOf("_") + 1);
                var value = $("#" + id).val();
                var PANid = "PAN_of_Deductee_" + rowno;
                var PAN = $("#" + PANid).val();
                var drpid = "Reason_for_Non_deduction_Lower_Deduction_" + rowno;
                var drp = $("#" + drpid).val();

                if (id.indexOf("PAN_of_Deductee") > -1) {
                    var regex = /[A-Z]{5}[0-9]{4}[A-Z]{1}$/;

                    if (value == "PANNOTAVBL" && drp != "Non-Availability of PAN C") {
                        $(this)[0].style.border = '1px solid red';
                    }
                    else if (!regex.test(value)) {
                        $(this)[0].style.border = '1px solid green';
                    }
                    else {

                        $(this)[0].style.border = '1px solid green';
                    }
                }

                else if (id.indexOf("TDS") > -1 || id.indexOf("Surcharge") > -1
                    || id.indexOf("Education_Cess") > -1 || id.indexOf("Total_Tax_Deducted") > -1) {

                    var tdsid = "TDS_" + rowno;
                    var TDS = $("#" + tdsid).val();

                    var Surchargeid = "Surcharge_" + rowno;
                    var Surcharge = $("#" + Surchargeid).val();

                    var Education_Cessid = "Education_Cess_" + rowno;
                    var Education_Cess = $("#" + Education_Cessid).val();

                    var Total_Tax_Deductedid = "Total_Tax_Deducted_" + rowno;
                    var Total_Tax_Deducted = parseInt($("#" + Total_Tax_Deductedid).val());

                    var total = parseInt(TDS) + parseInt(Surcharge) + parseInt(Education_Cess);

                    if (total != Total_Tax_Deducted) {

                        $("#" + tdsid).css("border", '1px solid red');
                        $("#" + Surchargeid).css("border", '1px solid red');
                        $("#" + Education_Cessid).css("border", '1px solid red');
                        $("#" + Total_Tax_Deductedid).css("border", '1px solid red');
                    }
                    else {

                        $("#" + tdsid).css("border", '1px solid green');
                        $("#" + Surchargeid).css("border", '1px solid green');
                        $("#" + Education_Cessid).css("border", '1px solid green');
                        $("#" + Total_Tax_Deductedid).css("border", '1px solid green');
                    }

                    if (TDS.indexOf(".") > -1) {
                        $("#" + tdsid).css("border", '1px solid red');
                    }

                }
                    //Column M : is equal to  "Lower Rt. Under Section 197 A"   then Column  N Should have Certificate No.  of 10 digit
                    //Column M is equal to "Presc. Rt." then column N should be blank.
                else if (id.indexOf("Reason_for_Non_deduction_Lower_Deduction") > -1 || id.indexOf("Certificate_number_for_Lower_NonDeduction") > -1) {
                    var dedid = "Reason_for_Non_deduction_Lower_Deduction_" + rowno;
                    var ded = $("#" + dedid).val();

                    var cerid = "Certificate_number_for_Lower_NonDeduction_" + rowno;
                    var cer = $("#" + cerid).val();
                    if (ded == "Lower Rt. Under Section 197 A" && cer.trim().length == 10) {
                        $("#" + dedid).css("border", '1px solid green');
                        $("#" + cerid).css("border", '1px solid green');
                    }

                    else if (PAN == "PANNOTAVBL" && drp != "Non-Availability of PAN C") {
                        $("#" + dedid).css("background-color", '1px solid red');
                        $("#" + PANid).css("border", '1px solid red');

                    }
                    else if (PAN == "PANNOTAVBL" && drp == "Non-Availability of PAN C") {
                        $("#" + dedid).css("background-color", '1px solid green');
                        $("#" + PANid).css("border", '1px solid green');

                    }
                    else if (ded == "Lower Rt. Under Section 197 A" && cer.trim().length != 10) {
                        $("#" + dedid).css("border", '1px solid red');
                        $("#" + cerid).css("border", '1px solid red');
                    }

                    else if (ded == "Presc.Rt." && cer.trim().length != 0) {
                        $("#" + dedid).css("border", '1px solid red');
                        $("#" + cerid).css("border", '1px solid red');
                    }

                    else if (ded == "Presc.Rt." && cer.trim().length == 0) {
                        $("#" + dedid).css("border", '1px solid green');
                        $("#" + cerid).css("border", '1px solid green');
                    }
                }
                else if (id.indexOf("Payment_CreditDate") > -1) {
                    if (dateCheck(FDate, TDate, value)) {
                        $("#" + id).css("border", '1px solid green');

                    }
                    else {

                        $("#" + id).css("border", '1px solid red');
                    }
                }
                else {

                }
            });


        }

        function dateCheck(from, to, check) {

            var fDate, lDate, cDate;
            fDate = Date.parse(from);
            lDate = Date.parse(to);
            cDate = Date.parse(check);

            if ((cDate <= lDate && cDate >= fDate)) {
                return true;
            }
            return false;
        }
    </script>
    <style type="text/css">
        #divData th, #divData td {
            border: 1px solid #d3d3d380;
            padding: 5px;
        }

        #divData th {
            padding-left: 10px;
            padding-right: 10px;
        }
    </style>
</asp:Content>



