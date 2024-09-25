using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.IO;
using System.Net;
using Ionic.Zip;

using System.Diagnostics;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System.Drawing;
using System.Data.SqlClient;
using Newtonsoft.Json;
using System.Web.Services;
using DevExpress.Xpo.Helpers;
using Microsoft.ApplicationBlocks1.Data;

public partial class Import27EQXL : System.Web.UI.Page
{

    string Compid = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["companyid"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }
        if (!Page.IsPostBack)
        {
            hdnCompanyid.Value = Session["companyid"].ToString();
            Session["form"] = "27EQ";
            //Session["Qua"] = "";
            Session["Cid"] = "";
            Session["CO"] = "";
        }
    }


    protected void btnProjectExcel_Click(object sender, EventArgs e)
    {
        
        CommonLibrary.CommonFunctions objComm = new CommonLibrary.CommonFunctions();
        DataTable reportDataTable = new DataTable();
        int compid = 0;
        DateTime? startDate = null;
        DateTime? endDate = null;
        try
        {

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public static string UpdateRecords(InputData inputData)
    {
        DataLayer.DALCommon dAL = new DataLayer.DALCommon();
        DataSet ds = new DataSet();
        DataSet dsExport = new DataSet();
        try
        {
            DataTable dtChallan = new DataTable();
            dtChallan.Columns.Add("Id", typeof(int));
            dtChallan.Columns.Add("Challan_Number", typeof(string));
            dtChallan.Columns.Add("BSRCodeOrReceiptNumber", typeof(string));
            dtChallan.Columns.Add("TDS", typeof(string));
            dtChallan.Columns.Add("Surcharge", typeof(string));
            dtChallan.Columns.Add("education_Cess", typeof(string));
            dtChallan.Columns.Add("Date_on_Tax_Depo", typeof(string));
            dtChallan.Columns.Add("Intrest", typeof(string));
            dtChallan.Columns.Add("Fee", typeof(string));
            dtChallan.Columns.Add("Others", typeof(string));
            dtChallan.Columns.Add("TotaTaxDepo", typeof(string));
            dtChallan.Columns.Add("Quarter", typeof(string));
            foreach (ChallanV3 challan in inputData.challanList)
            {

                dtChallan.Rows.Add(challan.Id, challan.Challan_Number, challan.BSRCodeOrReceiptNumber, challan.TDS, challan.Surcharge, challan.education_Cess, challan.Date_on_Tax_Depo, challan.Intrest
                    , challan.Fee, challan.Others, challan.TotalTaxDepo, challan.quarter);
            }

            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@companyId", HttpContext.Current.Session["companyid"]);
            param[1] = new SqlParameter("@indication", 3);
            param[2] = new SqlParameter("@tvp", dtChallan);

            ds = SqlHelper.ExecuteDataset(dAL._cnnString2, CommandType.StoredProcedure, "DBP_ChallanExcelValidation", param);

            if (ds.Tables.Count == 2)
            {
                dsExport.Tables.Add(ds.Tables[0].Copy());
                dsExport.Tables[0].TableName = "Challan_Count";
                dsExport.Tables.Add(ds.Tables[1].Copy());
                dsExport.Tables[1].TableName = "Challan";

            }

            DataTable dtVoucher = new DataTable();
            dtVoucher.Columns.Add("Id", typeof(int));
            dtVoucher.Columns.Add("Challan_Number", typeof(string));
            dtVoucher.Columns.Add("Deductee_Code", typeof(string));
            dtVoucher.Columns.Add("PAN_of_Deductee", typeof(string));
            dtVoucher.Columns.Add("Name_Of_Deductee", typeof(string));
            dtVoucher.Columns.Add("Section_Description", typeof(string));
            dtVoucher.Columns.Add("Payment_CreditDate", typeof(string));
            dtVoucher.Columns.Add("TDS", typeof(string));
            dtVoucher.Columns.Add("Surcharge", typeof(string));
            dtVoucher.Columns.Add("Education_Cess", typeof(string));
            dtVoucher.Columns.Add("Total_Tax_Deducted", typeof(string));
            dtVoucher.Columns.Add("Reason_for_Non_deduction_Lower_Deduction", typeof(string));
            dtVoucher.Columns.Add("Certificate_number_for_Lower_NonDeduction", typeof(string));
            dtVoucher.Columns.Add("Amount_Paid_Credited", typeof(string));
            dtVoucher.Columns.Add("Rate_at_which_deducted", typeof(string));
            dtVoucher.Columns.Add("Opt115BAC", typeof(string));

            foreach (VoucherV3 voucher in inputData.voucherList)
            {

                dtVoucher.Rows.Add(voucher.Id, voucher.Challan_Number, voucher.Deductee_Code, voucher.PAN_of_Deductee, voucher.Name_Of_Deductee, voucher.Section_Description, voucher.Payment_CreditDate, voucher.TDS, voucher.Surcharge, voucher.Education_Cess, voucher.Total_Tax_Deducted,
                    voucher.Reason_for_Non_deduction_Lower_Deduction, voucher.Certificate_number_for_Lower_NonDeduction, voucher.Amount_Paid_Credited, voucher.Rate_at_which_deducted, voucher.Opt115BAC);
            }

            SqlParameter[] param2 = new SqlParameter[4];
            param2[0] = new SqlParameter("@companyId", HttpContext.Current.Session["companyid"]);
            param2[1] = new SqlParameter("@indication", 3);
            param2[2] = new SqlParameter("@formType", HttpContext.Current.Session["form"]);
            param2[3] = new SqlParameter("@tvp", dtVoucher);

            ds = SqlHelper.ExecuteDataset(dAL._cnnString2, CommandType.StoredProcedure, "DBP_ExcelValidationV3", param2);
            if (ds.Tables.Count > 2)
            {
                dsExport.Tables.Add(ds.Tables[0].Copy());
                dsExport.Tables[2].TableName = "Voucher_Count";
                dsExport.Tables.Add(ds.Tables[1].Copy());
                dsExport.Tables[3].TableName = "Voucher";
                dsExport.Tables.Add(ds.Tables[2].Copy());
                dsExport.Tables[4].TableName = "Sections";

            }
            return JsonConvert.SerializeObject(dsExport);
        }
        catch (Exception ex)
        {
            return ex.Message;

        }
    }

    private void DumpChallanVoucherExcel(DataSet ds)
    {
        try
        {
            using (ExcelPackage pck = new ExcelPackage())
            {
                ExcelWorksheet ws = pck.Workbook.Worksheets.Add("Challan Details");

                //using (ExcelRange rng1 = ws.Cells["A1:E1"])
                //{
                //    rng1.Merge = true;
                //    rng1.Value = "Staff Approver Allocation Report";
                //    rng1.Style.Font.Bold = true;
                //    //rng1.Style.Font.Size = 18;
                //}

                int l = ds.Tables[0].Columns.Count;
                //Load the datatable into the sheet, starting from cell A1. Print the column names on row 1
                ws.Cells["A1"].LoadFromDataTable(ds.Tables[0], true);
                ws.Cells.AutoFitColumns();
                //Format the header for column 1-3
                using (ExcelRange rng = ws.Cells["A1:K1"])
                {
                    rng.Style.Font.Bold = true;
                    rng.Style.Fill.PatternType = ExcelFillStyle.Solid;                      //Set Pattern for the background to Solid
                    rng.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(79, 129, 189));  //Set color to dark blue
                    rng.Style.Font.Color.SetColor(Color.White);
                }

                ws = pck.Workbook.Worksheets.Add("Deductee Details");

                //using (ExcelRange rng1 = ws.Cells["A1:E1"])
                //{
                //    rng1.Merge = true;
                //    rng1.Value = "Staff Approver Allocation Report";
                //    rng1.Style.Font.Bold = true;
                //    //rng1.Style.Font.Size = 18;
                //}

                 l = ds.Tables[1].Columns.Count;
                //Load the datatable into the sheet, starting from cell A1. Print the column names on row 1
                ws.Cells["A1"].LoadFromDataTable(ds.Tables[1], true);
                ws.Cells.AutoFitColumns();
                //Format the header for column 1-3
                using (ExcelRange rng = ws.Cells["A1:O1"])
                {
                    rng.Style.Font.Bold = true;
                    rng.Style.Fill.PatternType = ExcelFillStyle.Solid;                      //Set Pattern for the background to Solid
                    rng.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(79, 129, 189));  //Set color to dark blue
                    rng.Style.Font.Color.SetColor(Color.White);
                }



                using (var memoryStream = new MemoryStream())
                {
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("content-disposition", "attachment;  filename=StaffWiseApproverAllocation.xls");
                    pck.SaveAs(memoryStream);
                    memoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public class InputData
    {

        public InputData() { }

        public List<VoucherV3> voucherList { get; set; }

        public List<ChallanV3> challanList { get; set; }

    }

    public class VoucherV3
    {
        public string Id { get; set; }
        public string Challan_Number { get; set; }
        public string Deductee_Code { get; set; }
        public string PAN_of_Deductee { get; set; }
        public string Name_Of_Deductee { get; set; }
        public string Payment_CreditDate { get; set; }
        public string Section_Code { get; set; }
        public string Section_Description { get; set; }
        public string TDS { get; set; }
        public string Surcharge { get; set; }
        public string Education_Cess { get; set; }
        public string Total_Tax_Deducted { get; set; }
        public string Rate_at_which_deducted { get; set; }
        public string Reason_for_Non_deduction_Lower_Deduction { get; set; }
        public string Certificate_number_for_Lower_NonDeduction { get; set; }
        public string Amount_Paid_Credited { get; set; }
        public string Opt115BAC { get; set; }
    }

    public class ChallanV3
    {
        public string Id { get; set; }
        public string Challan_Number { get; set; }
        public string Date_on_Tax_Depo { get; set; }
        public string BSRCodeOrReceiptNumber { get; set; }
        public string TDS { get; set; }
        public string Surcharge { get; set; }
        public string education_Cess { get; set; }
        public string Intrest { get; set; }
        public string Fee { get; set; }
        public string Others { get; set; }
        public string TotalTaxDepo { get; set; }
        public string quarter { get; set; }
        public string FormType { get; set; }
    }


    }