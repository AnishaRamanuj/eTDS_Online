<%@ WebService Language="C#" Class="SalaryChallanDetails" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;

using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Data.OleDb;
using System.IO;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System.Web.Script.Serialization;
using EntityLibrary;
using System.Net;
using LibCommon;
using BusinessLayer;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class SalaryChallanDetails : System.Web.Services.WebService
{
    DALCommonLib objComm = new DALCommonLib();
    Functions4evr Comm = new Functions4evr();

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string onLoad(int compid, string Quater, string SalarySearchby, string ChallanNo, string ChallanDate, int pageIndex, int Pagesize)
    {
        DataSet ds = new DataSet();


        int month = DateTime.Now.Month;
        int year = DateTime.Now.Year;
        string sfin, efin;
        if (month <= 3)
        {
            sfin = (year - 1).ToString();
            efin = year.ToString();
        }
        else
        {
            sfin = year.ToString();
            efin = (year + 1).ToString();
        }

        SqlParameter[] param=new SqlParameter[8];
        param[0] = new SqlParameter("@CompanyID", compid);
        param[1] = new SqlParameter("@FinancialStart", sfin);
        param[2] = new SqlParameter("@FinancialEnd", efin);
        param[3] = new SqlParameter("@ChallanDate", ChallanDate);
        param[4] = new SqlParameter("@ChallanNo", ChallanNo);
        param[5] = new SqlParameter("@Quater", Quater);
        param[6] = new SqlParameter("@pageIndex", pageIndex);
        param[7] = new SqlParameter("@pageSize", Pagesize);
        ds = SqlHelper.ExecuteDataset(objComm._cnnString2, CommandType.StoredProcedure, "usp_Bootstrap_GetQueterSelectionGrid", param);


        return ds.GetXml();
    }
    [WebMethod(EnableSession = true)]
    public string GetEmployee(int compid, string MonthID, string ChallanDate, Boolean chkShowOnlyTaxableEmployees)
    {

        DataSet ds; 

        SqlParameter[] objSqlParameter = new SqlParameter[3];
        objSqlParameter[0] = new SqlParameter("@Company_ID", compid);
        objSqlParameter[1] = new SqlParameter("@Challan_Date", ChallanDate);
        objSqlParameter[2] = new SqlParameter("@Months", MonthID);
        ds = SqlHelper.ExecuteDataset(objComm._cnnString2, "usp_Get_Employee_Master_Challan_List", objSqlParameter);

        ds.Tables[0].DefaultView.RowFilter = "GrossSalary <> 0";
        System.Data.DataView dataView = ds.Tables[0].DefaultView;
        DataSet ds1 = new DataSet();
        if (chkShowOnlyTaxableEmployees)
            ds1.Tables.Add(dataView.ToTable());
        else
            ds1 = ds.Copy();

        Session["EmpTable"] = ds1;
        return ds1.GetXml();
    }

    [WebMethod(EnableSession = true)]
    public string Edit_SalaryChallan(int Company_ID, int Challan_ID)
    {
        BAL_Challan objBAL_Challan = new BAL_Challan();
        objBAL_Challan._Company_ID = Convert.ToInt32(Company_ID);
        objBAL_Challan._Challan_ID = Convert.ToInt32(Challan_ID);
        DataSet ds; 

        SqlParameter[] objSqlParameter = new SqlParameter[2];
        objSqlParameter[0] = new SqlParameter("@Challan_ID", Challan_ID);
        objSqlParameter[1] = new SqlParameter("@Company_ID", Company_ID);
        ds = SqlHelper.ExecuteDataset(objComm._cnnString2, CommandType.StoredProcedure, "usp_GetChallanDetails", objSqlParameter);

        return ds.GetXml();
    }

    [WebMethod(EnableSession = true)]
    public int InssertSalaryChallan(BAL_SalaryChallan objbalChallan)
    {
        int result = 0;
        try
        {
            //// Convert the table data to a JSON string
            string jsonData = JsonConvert.SerializeObject(objbalChallan.dataTable);
            //Array myarr;

            // Deserialize the JSON string to a DataTable
            DataTable dt = JsonConvert.DeserializeObject<DataTable>(jsonData);

            BAL_SalaryChallan objBAL_Challan = new BAL_SalaryChallan();
            objBAL_Challan = objbalChallan;
            objBAL_Challan.ChallanDatatable = dt;
            //result = objBAL_Challan.Insert_Challan();

            object Challan_Date = objBAL_Challan._Challan_Date;
            if (objBAL_Challan._Challan_Date == DateTime.MinValue)
                Challan_Date = DBNull.Value;

            object Cheque_Date =objBAL_Challan. _Cheque_Date;
            if (objBAL_Challan._Cheque_Date == DateTime.MinValue)
                Cheque_Date = DBNull.Value;

            SqlParameter[] objSqlParameter = new SqlParameter[21];

            objSqlParameter[0] = new SqlParameter("@Company_ID", objbalChallan._Company_ID);
            objSqlParameter[1] = new SqlParameter("@Challan_Date", Challan_Date);
            objSqlParameter[2] = new SqlParameter("@Bank_ID", objbalChallan._Bank_ID);
            objSqlParameter[3] = new SqlParameter("@Bank_BsrcoobjbalChallan.de",objbalChallan._Bank_Bsrcode);
            objSqlParameter[4] = new SqlParameter("@Cheque_no", objbalChallan._Cheque_no);
            objSqlParameter[5] = new SqlParameter("@Cheque_Date", Cheque_Date);
            objSqlParameter[6] = new SqlParameter("@Quater", objbalChallan._Quater);
            objSqlParameter[7] = new SqlParameter("@TDS_Amount", objbalChallan._TDS_Amount);
            objSqlParameter[8] = new SqlParameter("@Surcharge",objbalChallan. _Surcharge);
            objSqlParameter[9] = new SqlParameter("@Education_Cess", objbalChallan._Education_Cess);
            objSqlParameter[10] = new SqlParameter("@High_Education_Cess", objbalChallan._High_Education_Cess);
            objSqlParameter[11] = new SqlParameter("@Interest_Amt",objbalChallan._Interest_Amt);
            objSqlParameter[12] = new SqlParameter("@Fees_Amount", objbalChallan._Fees_Amount);
            objSqlParameter[13] = new SqlParameter("@Others_Amount", objbalChallan._Others_Amount);
            objSqlParameter[14] = new SqlParameter("@Challan_Amount", objbalChallan._Challan_Amount);
            objSqlParameter[15] = new SqlParameter("@Challan_No", objbalChallan._Challan_No);
            objSqlParameter[16] = new SqlParameter("@Trans_No",objbalChallan. _Trans_No);
            objSqlParameter[17] = new SqlParameter("@C_Entry", objbalChallan._C_Entry);
            objSqlParameter[18] = new SqlParameter("@Nil_Challan",objbalChallan. _Nil_Challan);
            objSqlParameter[19] = new SqlParameter("@ChallanDatatable", dt);
            objSqlParameter[20] = new SqlParameter("@ChallanType", objbalChallan.ChallanType);
            result = SqlHelper.ExecuteNonQuery(objComm._cnnString2, CommandType.StoredProcedure, "usp_Bootstrap_Insert_Challan", objSqlParameter);

            if (result > 0)
            {
                if (objbalChallan._Challan_ID > 0)
                {
                    result = objBAL_Challan.BAL_DeleteChallanOld();
                }
            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        return result;
    }
    [WebMethod(EnableSession = true)]
    public string GetBackupLogDate()
    {
        BAL_SalaryChallan obj_BAL_Challan = new BAL_SalaryChallan();
        string result = string.Empty;
        try
        {
            DataSet ds; // = obj_BAL_Challan.GetLogEntryForBackupData(Convert.ToInt32(Session["companyid"].ToString()), Convert.ToString(Session["form"].ToString()));
            SqlParameter[] objSqlParameter = new SqlParameter[2];


            objSqlParameter[0] = new SqlParameter("@companyId", Session["companyid"]);
            objSqlParameter[1] = new SqlParameter("@formType", Session["form"]);

            ds = SqlHelper.ExecuteDataset(objComm._cnnString2, "BTS_GetLastBackupEntryLog", objSqlParameter);
            if (ds.Tables[0].Rows.Count > 0)
            {
                result = Convert.ToString(ds.Tables[0].Rows[0]["BackupDateDateFormat"]);
            }

        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        return result;
    }

    [WebMethod(EnableSession = true)]
    public string ImportExcel(string fileName1, byte[] fileContent)
    {
        DataTable dtExcelData = new DataTable();
        try
        {
            string filePath = Path.Combine(Server.MapPath("~/Uploads/"), fileName1);

            // Save the file to the specified directory
            File.WriteAllBytes(filePath, fileContent);
            //HttpContext context;
            //Check if Request is to Upload the File.
            //if (context.Request.Files.Count > 0)
            //{
            //    //Fetch the Uploaded File.
            //    HttpPostedFile postedFile = context.Request.Files[0];

            //    //Set the Folder Path.
            //    string folderPath = context.Server.MapPath("~/Uploads/");

            //    //Set the File Name.
            //    string fileName = Path.GetFileName(postedFile.FileName);

            //    string fullPath = folderPath + fileName;
            //    //Save the File in Folder.
            //    postedFile.SaveAs(fullPath);
            string fullPath = filePath;
            string conString = string.Empty;
            string extension = Path.GetExtension(fullPath);
            switch (extension)
            {
                case ".xls": //Excel 97-03
                    conString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + fullPath + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
                    break;
                case ".xlsx": //Excel 07 or higher
                    conString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + fullPath + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
                    break;

            }

            SqlParameter[] param = new SqlParameter[2];
            conString = string.Format(conString, fullPath);

            using (OleDbConnection excel_con = new OleDbConnection(conString))
            {
                excel_con.Open();

                //[OPTIONAL]: It is recommended as otherwise the data will be considered as String by default.

                DataTable dtSchema = excel_con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, new object[] { null, null, null, "TABLE" });

                string Sheet1 = dtSchema.Rows[0].Field<string>("TABLE_NAME");
                if (Sheet1 == "'Deductee Details$'")
                {
                    using (OleDbDataAdapter oda = new OleDbDataAdapter(String.Format("SELECT * FROM [{0}]", Sheet1), excel_con))
                    {
                        oda.Fill(dtExcelData);
                    }
                    excel_con.Close();

                    //remove mandatory rows
                    dtExcelData.Rows.RemoveAt(0);

                    //dtExcelData = dtExcelData.Rows.Cast<DataRow>()
                    //.Where(row => !row.ItemArray.All(field => field is DBNull ||
                    //                 string.IsNullOrWhiteSpace(field as string)))
                    //.CopyToDataTable();                            
                }
            }
            //}
        }
        catch (Exception ex)
        {

        }
        return dtExcelData.DataSet.GetXml();
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public void ExportBackupExcel()
    {


        DataTable reportDataTable = new DataTable();
        BAL_SalaryChallan obj_BAL_Challan = new BAL_SalaryChallan();
        int compid = 0;
        DateTime? startDate = null;
        DateTime? endDate = null;
        ResonseType resonseType = new ResonseType();
        string startDateStr = "", endDatestr = "";
        string results = "";
        try
        {
            if (!string.IsNullOrEmpty(startDateStr))
            {
                startDate = Convert.ToDateTime(startDateStr);
            }
            if (!string.IsNullOrEmpty(endDatestr))
            {
                endDate = Convert.ToDateTime(endDatestr);
            }
            //DataSet ds = obj_BAL_Challan.GetExcelBackupData(Convert.ToInt32(Session["companyid"].ToString()), startDate, endDate, Convert.ToString(Session["form"].ToString()));

            SqlParameter[] objSqlParameter = new SqlParameter[4];

            int Compid = Convert.ToInt32(Session["companyid"].ToString());
            string formType  = Session["form"].ToString();

            objSqlParameter[0] = new SqlParameter("@companyId", Compid);
            objSqlParameter[1] = new SqlParameter("@formType", formType);
            objSqlParameter[2] = new SqlParameter("@startDate", startDate);
            objSqlParameter[3] = new SqlParameter("@endDate", endDate);
            DataSet  ds = SqlHelper.ExecuteDataset(objComm._cnnString2, "DBP_GetBackupforVoucherChallance", objSqlParameter);

            if (ds.Tables[1].Rows.Count > 0 || ds.Tables[0].Rows.Count > 0)
            {
                //obj_BAL_Challan.LogBackupEntryLog(Convert.ToInt32(Session["companyid"].ToString()), Convert.ToString(Session["form"].ToString()));


                SqlParameter[] LSqlParameter = new SqlParameter[2];
                objSqlParameter[0] = new SqlParameter("@companyId", Session["companyid"]);
                objSqlParameter[1] = new SqlParameter("@formType", Session["form"]);

                ds = SqlHelper.ExecuteDataset(objComm._cnnString2, "BTS_CreateBackupEntryLog", LSqlParameter);

                resonseType.filePath = DumpChallanVoucherExcel(ds, true, Context);
                resonseType.isPass = true;
            }
            else
            {
                resonseType.filePath = "No records to export";
            }

            HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
            HttpContext.Current.Response.ContentType = "text/json";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(resonseType));
        }
        catch (Exception ex)
        {

        }

    }

    private string DumpChallanVoucherExcel(DataSet ds, bool isBackup,HttpContext context)
    {
        Random rn = new Random();
        string folderPath = HttpContext.Current.Server.MapPath("~/Uploads/");
        string templatefile = string.Empty;
        templatefile = HttpContext.Current.Server.MapPath("~/BTStrp/Templates/")+Convert.ToString(context.Session["form"]) + "_Blank_XLSheet.xlsx";
        string exportFile = string.Empty;
        exportFile = folderPath + rn.Next().ToString() + "2324_BlankTemplate.xlsx";
        if (isBackup)
        {
            templatefile = HttpContext.Current.Server.MapPath("~/BTStrp/Templates/")+Convert.ToString(context.Session["form"]) + "_Blank_XLSheet.xlsx";
            exportFile = folderPath +Convert.ToString(context.Session["TANNo"])+"_"+ Convert.ToString(context.Session["form"]) +"_"+ DateTime.Now.ToString("dd-MMM-yyyy").Replace("-", "_") + ".xlsx";
        }

        FileInfo file = new FileInfo(exportFile);
        try
        {


            File.Copy(templatefile, exportFile,true);
            using (ExcelPackage pck = new ExcelPackage(file))
            {
                ExcelWorkbook excelWorkBook = pck.Workbook;
                ExcelWorksheet excelWorksheet = excelWorkBook.Worksheets[1];

                if (ds.Tables[0].Rows.Count > 0)
                {

                    excelWorksheet.Cells["A4"].LoadFromDataTable(ds.Tables[0], false);
                    excelWorksheet.Cells.AutoFitColumns();
                }
                ExcelWorksheet excelWorksheet2 = excelWorkBook.Worksheets[2];
                if (ds.Tables[1].Rows.Count > 0)
                {
                    excelWorksheet2.Cells["A4"].LoadFromDataTable(ds.Tables[1], false);
                    excelWorksheet2.Cells.AutoFitColumns();
                }
                pck.Save();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {


        }
        return "../../Uploads/" + file.Name;
    }

    public class ResonseType
    {
        public bool isPass { get; set; }
        public string filePath { get; set; }
        public string errorMessage { get; set; }

    }

}

