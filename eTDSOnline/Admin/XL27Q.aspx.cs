using System.Web.UI.WebControls;
using BusinessLayer;
using DataLayer;
using System.Data;
using System.Drawing;
using System.Globalization;
using CommonLibrary;
using System.Diagnostics;
using System.Web.Services;
using System.Web.Script.Serialization;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;
using Microsoft.ApplicationBlocks.Data;
using Newtonsoft.Json;

public partial class Admin_XL27Q : System.Web.UI.Page
{
    CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
    BAL_Bank_Master objBAL_Bank_Master = new BAL_Bank_Master();
    BAL_NonSalaryChallan objBAL_NonSalaryChallan = new BAL_NonSalaryChallan();
    DataSet ds;
    int result = 0;
    CultureInfo ci = new CultureInfo("en-GB");

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["companyid"] != null)
        {//
         // hdnCompanyid.Value = Session["companyid"].ToString();
        }
        else
        {
            //  Response.Redirect("~/Default.aspx");
        }
        try
        {
            if (!Page.IsPostBack)
            {

            }
        }
        catch (Exception ex)
        {
            //   ErrorException.LogError(ex, hdnCompanyid.Value);
            //  ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Success);
        }
    }

    [WebMethod]
    public static string UpdateRecords(List<xl27Q> voucherDtls)
    {
        try
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Id", typeof(int));
            dt.Columns.Add("Deductee_Code", typeof(string));
            dt.Columns.Add("PAN_of_Deductee", typeof(string));
            dt.Columns.Add("Name_Of_Deductee", typeof(string));
            //dt.Columns.Add("Section_Code", typeof(string));
            dt.Columns.Add("Section_Description", typeof(string));
            dt.Columns.Add("Payment_CreditDate", typeof(string));
            dt.Columns.Add("TDS", typeof(string));
            dt.Columns.Add("Surcharge", typeof(string));
            dt.Columns.Add("Education_Cess", typeof(string));
            dt.Columns.Add("Total_Tax_Deducted", typeof(string));
            dt.Columns.Add("Reason_for_Non_deduction_Lower_Deduction", typeof(string));
            dt.Columns.Add("Certificate_number_for_Lower_NonDeduction", typeof(string));

            dt.Columns.Add("TDS_Rate_Code", typeof(string));
            dt.Columns.Add("Remittance", typeof(string));
            dt.Columns.Add("Country", typeof(string));
            dt.Columns.Add("Contact_no", typeof(string));
            dt.Columns.Add("Email", typeof(string));
            dt.Columns.Add("Tax_Identification", typeof(string));
            dt.Columns.Add("Nri_Address", typeof(string));
            dt.Columns.Add("Amount_Paid_Credited", typeof(string));


            foreach (xl27Q voucher in voucherDtls)
            {
                //dt.Rows.Add(voucher.Id, voucher.PAN_of_Deductee, voucher.Section_Code, voucher.Section_Description, voucher.Payment_CreditDate, 
                //    voucher.TDS, voucher.Surcharge, voucher.Education_Cess, voucher.Total_Tax_Deducted,
                //    voucher.Reason_for_Non_deduction_Lower_Deduction, voucher.Certificate_number_for_Lower_NonDeduction, voucher.TDS_Rate_Code, 
                //    voucher.Remittance, voucher.Country, voucher.Contact_no, voucher.Email, voucher.Tax_Identification, voucher.Nri_Address, voucher.Amount_Paid_Credited  );

                dt.Rows.Add(voucher.Id, voucher.Deductee_Code, voucher.PAN_of_Deductee, voucher.Name_Of_Deductee,  voucher.Section_Description, voucher.Payment_CreditDate,
                    voucher.TDS, voucher.Surcharge, voucher.Education_Cess, voucher.Total_Tax_Deducted,
                    voucher.Reason_for_Non_deduction_Lower_Deduction, voucher.Certificate_number_for_Lower_NonDeduction, voucher.TDS_Rate_Code,
                    voucher.Remittance, voucher.Country, voucher.Contact_no, voucher.Email, voucher.Tax_Identification, voucher.Nri_Address, voucher.Amount_Paid_Credited);


            }

            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@companyId", HttpContext.Current.Session["companyid"]);
            param[1] = new SqlParameter("@indication", 3);
            param[2] = new SqlParameter("@tvp", dt);
            DataLayer.DALCommon dAL = new DataLayer.DALCommon();
            DataSet ds = SqlHelper.ExecuteDataset(dAL._cnnString2, CommandType.StoredProcedure, "Usp_27Q_ExcelValidation", param);
            return JsonConvert.SerializeObject(ds);
        }
        catch (Exception ex)
        {
            return ex.Message;

        }
    }


}
public class xl27Q
{
    public string Id { get; set; }
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
    public string Reason_for_Non_deduction_Lower_Deduction { get; set; }
    public string Certificate_number_for_Lower_NonDeduction { get; set; }

    public string TDS_Rate_Code { get; set; }
    public string Remittance { get; set; }
    public string Country { get; set; }
    public string Contact_no { get; set; }
    public string Email { get; set; }
    public string Tax_Identification { get; set; }
    public string Nri_Address { get; set; }
    public string Amount_Paid_Credited { get; set; }
}