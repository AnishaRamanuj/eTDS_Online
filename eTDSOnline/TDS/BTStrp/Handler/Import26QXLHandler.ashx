<%@ WebHandler Language="C#" Class="Import26QXLHandler" %>
using System.Web.Services;

using System;
using System.Web;
using System.Net;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Data.SqlClient;
using System.Web.SessionState;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System.Drawing;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Newtonsoft.Json;
using Microsoft.ApplicationBlocks1.Data;
using System.Globalization;
using DataLayer;
using System.Threading;

using EntityLibrary;

public class Import26QXLHandler : DataLayer.DALCommon, IHttpHandler, IRequiresSessionState
{


    public void ProcessRequest(HttpContext context)
    {
        DataSet ds = new DataSet();
        DataSet dsExport = new DataSet();
        bool isEmptyExcel = true;
        try
        {
            //Check if Request is to Upload the File.

            if (context.Request.Files.Count > 0)
            {
                DataLayer.DALCommon dAL = new DataLayer.DALCommon();
                //Fetch the Uploaded File.
                HttpPostedFile postedFile = context.Request.Files[0];

                //Set the Folder Path.
                string folderPath = context.Server.MapPath("~/Uploads/");
                DeleteOldFiles(folderPath);
                //Set the File Name.
                string fileName = Path.GetFileName(postedFile.FileName);

                string fullPath = folderPath + fileName;
                //Save the File in Folder.
                postedFile.SaveAs(fullPath);

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

                    DataTable dtExcelData = new DataTable();

                    //[OPTIONAL]: It is recommended as otherwise the data will be considered as String by default.

                    DataTable dtSchema = excel_con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, new object[] { null, null, null, "TABLE" });

                    for (int i = 0; i < dtSchema.Rows.Count; i++)
                    {
                        string Sheet1 = dtSchema.Rows[i].Field<string>("TABLE_NAME");

                        if (Sheet1 == "'Challan Details$'")
                        {

                            using (OleDbDataAdapter oda = new OleDbDataAdapter(String.Format("SELECT * FROM [{0}]", Sheet1), excel_con))
                            {
                                oda.Fill(dtExcelData);
                            }

                            dtExcelData.Rows.RemoveAt(0);



                            if ((dtExcelData != null) && (dtExcelData.Rows != null) && (dtExcelData.Rows.Count > 0))
                            {
                                List<System.Data.DataRow> removeRowIndex = new List<System.Data.DataRow>();
                                int RowCounter = 0;
                                foreach (System.Data.DataRow dRow in dtExcelData.Rows)
                                {
                                    bool isEmpty = true;
                                    for (int index = 0; index < dtExcelData.Columns.Count; index++)
                                    {

                                        if (!string.IsNullOrEmpty(Convert.ToString(dRow[index])))
                                        {
                                            isEmpty = false;
                                            break;
                                        }

                                        if (index == dtSchema.Columns.Count - 1)
                                        {
                                            if (isEmpty)
                                            {
                                                removeRowIndex.Add(dRow);
                                            }
                                        }
                                    }
                                    RowCounter++;
                                }
                                // Remove all blank of in-valid rows
                                foreach (System.Data.DataRow rowIndex in removeRowIndex)
                                {
                                    dtExcelData.Rows.Remove(rowIndex);
                                }
                            }

                            DataColumn newColumn = new DataColumn("CompanyID", typeof(System.Int16));
                            newColumn.DefaultValue = HttpContext.Current.Session["companyid"];
                            dtExcelData.Columns.Add(newColumn);

                            newColumn = new DataColumn("FinancialYear", typeof(System.String));
                            newColumn.DefaultValue = HttpContext.Current.Session["Financial_Year_Text"];
                            dtExcelData.Columns.Add(newColumn);


                            newColumn = new DataColumn("FormType", typeof(System.String));
                            newColumn.DefaultValue = Convert.ToString(HttpContext.Current.Session["form"]);
                            dtExcelData.Columns.Add(newColumn);

                            newColumn = new DataColumn("UploadedDate", typeof(System.String));
                            newColumn.DefaultValue = DateTime.Now;
                            dtExcelData.Columns.Add(newColumn);



                            //remove existing data
                            if (dtExcelData.Rows.Count > 0)
                            {
                                string s = dtExcelData.Rows[0][0].ToString();
                                if (s == "(Mandatory)")
                                {
                                    dtExcelData.Rows.RemoveAt(0);
                                }
                                else if (s == "Deductee Code")
                                {
                                    dtExcelData.Rows.RemoveAt(0);
                                }
                                else
                                {
                                    s = dtExcelData.Rows[0][0].ToString();
                                    if (s == "(Mandatory)")
                                    {
                                        dtExcelData.Rows.RemoveAt(1);
                                    }
                                }
                            }
                            param[0] = new SqlParameter("@companyId", HttpContext.Current.Session["companyid"]);
                            param[1] = new SqlParameter("@indication", 2);
                            SqlHelper.ExecuteNonQuery(_cnnString2, CommandType.StoredProcedure, "BTS_ChallanExcelValidation", param);

                            if (dtExcelData.Rows.Count > 0)
                            {
                                isEmptyExcel = false;
                            }

                            using (SqlConnection con = new SqlConnection(_cnnString2))
                            {
                                using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(con))
                                {
                                    //Set the database table name
                                    sqlBulkCopy.DestinationTableName = "dbo.ExcelChallanValidation";
                                    sqlBulkCopy.ColumnMappings.Add("FinancialYear", "FinancialYear");
                                    sqlBulkCopy.ColumnMappings.Add("CompanyID", "CompanyID");
                                    sqlBulkCopy.ColumnMappings.Add("FormType", "FormType");
                                    sqlBulkCopy.ColumnMappings.Add("UploadedDate", "UploadedDate");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[0].ToString(), "Challan_Number");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[1].ToString() == "" ? "NULL" : dtExcelData.Columns[1].ToString(), "Date_on_Tax_Depo");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[2].ToString(), "BSRCode");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[3].ToString() == "" ? "0" : dtExcelData.Columns[9].ToString().Replace(",", ""), "TDS");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[4].ToString() == "" ? "0" : dtExcelData.Columns[4].ToString().Replace(",", ""), "Surcharge");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[5].ToString() == "" ? "0" : dtExcelData.Columns[5].ToString().Replace(",", ""), "education_Cess");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[6].ToString() == "" ? "0" : dtExcelData.Columns[6].ToString().Replace(",", "") == "" ? "0" : dtExcelData.Columns[6].ToString().Replace(",", ""), "Intrest");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[7].ToString() == "" ? "0" : dtExcelData.Columns[7].ToString().Replace(",", "") == "" ? "0" : dtExcelData.Columns[7].ToString().Replace(",", ""), "Fee");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[8].ToString() == "" ? "0" : dtExcelData.Columns[8].ToString().Replace(",", ""), "Others");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[9].ToString() == "" ? "0" : dtExcelData.Columns[9].ToString().Replace(",", ""), "TotalTaxDepo");
                                    //sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[10].ToString(), "quarter");
                                    con.Open();
                                    sqlBulkCopy.WriteToServer(dtExcelData);
                                    con.Close();
                                }
                            }
                            param = new SqlParameter[2];
                            param[0] = new SqlParameter("@companyId", HttpContext.Current.Session["companyid"]);
                            param[1] = new SqlParameter("@indication", 1);
                            ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "BTS_ChallanExcelValidation", param);

                            if (ds.Tables.Count == 2)
                            {
                                dsExport.Tables.Add(ds.Tables[0].Copy());
                                dsExport.Tables[0].TableName = "Challan_Count";
                                dsExport.Tables.Add(ds.Tables[1].Copy());
                                dsExport.Tables[1].TableName = "Challan";

                            }
                        }


                        Sheet1 = dtSchema.Rows[i].Field<string>("TABLE_NAME");


                        if (Sheet1 == "'Deductee Details$'")
                        {
                            dtExcelData = new DataTable();
                            using (OleDbDataAdapter oda = new OleDbDataAdapter(String.Format("SELECT * FROM [{0}]", Sheet1), excel_con))
                            {
                                oda.Fill(dtExcelData);
                            }
                            excel_con.Close();

                            //remove mandatory rows
                            dtExcelData.Rows.RemoveAt(0);


                            if ((dtExcelData != null) && (dtExcelData.Rows != null) && (dtExcelData.Rows.Count > 0))
                            {
                                List<System.Data.DataRow> removeRowIndex = new List<System.Data.DataRow>();
                                int RowCounter = 0;
                                foreach (System.Data.DataRow dRow in dtExcelData.Rows)
                                {
                                    bool isEmpty = true;
                                    for (int index = 0; index < dtExcelData.Columns.Count; index++)
                                    {

                                        if (!string.IsNullOrEmpty(Convert.ToString(dRow[index])))
                                        {
                                            isEmpty = false;
                                            break;
                                        }

                                        if (index == dtSchema.Columns.Count - 1)
                                        {
                                            if (isEmpty)
                                            {
                                                removeRowIndex.Add(dRow);
                                            }
                                        }
                                    }
                                    RowCounter++;
                                }
                                // Remove all blank of in-valid rows
                                foreach (System.Data.DataRow rowIndex in removeRowIndex)
                                {
                                    dtExcelData.Rows.Remove(rowIndex);
                                }
                            }

                            DataColumn newColumn = new DataColumn("CompanyID", typeof(System.Int16));
                            newColumn.DefaultValue = HttpContext.Current.Session["companyid"];
                            dtExcelData.Columns.Add(newColumn);

                            newColumn = new DataColumn("FinancialYear", typeof(System.String));
                            newColumn.DefaultValue = HttpContext.Current.Session["Financial_Year_Text"];
                            dtExcelData.Columns.Add(newColumn);

                            //remove existing data
                            if (dtExcelData.Rows.Count > 0)
                            {
                                string s = dtExcelData.Rows[0][0].ToString();
                                if (s == "(Mandatory)")
                                {
                                    dtExcelData.Rows.RemoveAt(0);
                                }
                                else if (s == "Deductee Code")
                                {
                                    dtExcelData.Rows.RemoveAt(0);
                                }
                                else
                                {
                                    s = dtExcelData.Rows[0][0].ToString();
                                    if (s == "(Mandatory)")
                                    {
                                        dtExcelData.Rows.RemoveAt(1);
                                    }
                                }
                            }
                            param = new SqlParameter[3];
                            param[0] = new SqlParameter("@companyId", HttpContext.Current.Session["companyid"]);
                            param[1] = new SqlParameter("@indication", 2);
                            param[2] = new SqlParameter("@formType", HttpContext.Current.Session["form"]);

                            SqlHelper.ExecuteNonQuery(_cnnString2, CommandType.StoredProcedure, "BTS_ExcelValidation", param);
                            if (dtExcelData.Rows.Count > 0)
                            {
                                isEmptyExcel = false;
                            }
                            using (SqlConnection con = new SqlConnection(_cnnString2))
                            {
                                using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(con))
                                {
                                    //Set the database table name
                                    sqlBulkCopy.DestinationTableName = "dbo.tbl_ExcelValidation";
                                    sqlBulkCopy.ColumnMappings.Add("FinancialYear", "FinancialYear");
                                    sqlBulkCopy.ColumnMappings.Add("CompanyID", "CompanyID");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[0].ToString(), "Challan_Number");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[1].ToString(), "Deductee_Code");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[2].ToString(), "PAN_of_Deductee");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[3].ToString(), "Name_Of_Deductee");
                                    // sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[3].ToString(), "Section_Code");

                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[4].ToString(), "Section_Description");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[5].ToString(), "Payment_CreditDate");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[6].ToString() == "" ? "0" : dtExcelData.Columns[6].ToString().Replace(",", ""), "Amount_Paid_Credited");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[7].ToString() == "" ? "0" : dtExcelData.Columns[7].ToString().Replace(",", ""), "TDS");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[8].ToString() == "" || dtExcelData.Columns[8].ToString() == DBNull.Value.ToString() ? "0" : dtExcelData.Columns[8].ToString().Replace(",", ""), "Surcharge");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[9].ToString() == "" ? "0" : dtExcelData.Columns[9].ToString().Replace(",", ""), "Education_Cess");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[10].ToString() == "" ? "0" : dtExcelData.Columns[10].ToString().Replace(",", ""), "Total_Tax_Deducted");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[11].ToString() == "" ? "0" : dtExcelData.Columns[11].ToString().Replace(",", ""), "Rate_at_which_deducted");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[12].ToString(), "Reason_for_Non_deduction_Lower_Deduction");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[13].ToString(), "Certificate_number_for_Lower_NonDeduction");
                                    if (Convert.ToString(HttpContext.Current.Session["form"]) != "26Q")
                                    {
                                        sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[14].ToString(), "Opt115BAC");
                                    }
                                    con.Open();
                                    sqlBulkCopy.WriteToServer(dtExcelData);
                                    con.Close();
                                }
                            }
                            param = new SqlParameter[3];
                            param[0] = new SqlParameter("@companyId", HttpContext.Current.Session["companyid"]);
                            param[1] = new SqlParameter("@indication", 1);
                            param[2] = new SqlParameter("@formType", HttpContext.Current.Session["form"]);
                            ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "BTS_ExcelValidation", param);
                            if (ds.Tables.Count > 2)
                            {
                                dsExport.Tables.Add(ds.Tables[0].Copy());
                                dsExport.Tables[2].TableName = "Voucher_Count";
                                dsExport.Tables.Add(ds.Tables[1].Copy());
                                dsExport.Tables[3].TableName = "Voucher";
                                dsExport.Tables.Add(ds.Tables[2].Copy());
                                dsExport.Tables[4].TableName = "Sections";

                            }
                        }
                    }

                }

                ResonseType resonseType = new ResonseType();
                if (isEmptyExcel)
                {
                    resonseType.isPass = false;
                    resonseType.errorMessage = "This Excel doesnt contain Data";
                }
                else if (dsExport.Tables.Count > 4)
                {
                    resonseType.isPass = true;
                    if (Convert.ToInt32(dsExport.Tables["Challan_Count"].Rows[0]["error"]) > 0)
                    {
                        resonseType.isPass = false;
                    }
                    if (Convert.ToInt32(dsExport.Tables["Voucher_Count"].Rows[0]["error"]) > 0)
                    {
                        resonseType.isPass = false;
                    }
                    if (Convert.ToInt32(dsExport.Tables["Challan_Count"].Rows[0]["error"]) == 0 && Convert.ToInt32(dsExport.Tables["Challan_Count"].Rows[0]["error"]) == 0)
                    {

                    }

                    if (!resonseType.isPass)
                    {
                        resonseType.filePath = DumpChallanVoucherExcel(dsExport, context, false);
                        string message = "File Upload Failed ";
                        message = " Challance error: " + Convert.ToInt32(dsExport.Tables["Challan_Count"].Rows[0]["error"]);
                        message = message + " Voucher error: " + Convert.ToInt32(dsExport.Tables["Voucher_Count"].Rows[0]["error"]);
                        // dAL.CreateLog("File uploaded For " + HttpContext.Current.Session["form"].ToString(), message, HttpContext.Current.Session["companyid"].ToString());

                    }
                    else
                    {
                        string message = "File Upload Success ";
                        message = "Challan Success: " + Convert.ToInt32(dsExport.Tables["Challan_Count"].Rows[0]["Success"]);
                        message = message + " Voucher Success: " + Convert.ToInt32(dsExport.Tables["Voucher_Count"].Rows[0]["Success"]);
                        // dAL.CreateLog("File uploaded For " + HttpContext.Current.Session["form"].ToString(), message, HttpContext.Current.Session["companyid"].ToString());
                        resonseType.errorMessage = "File Uploaded Successfully!! " + Convert.ToInt32(dsExport.Tables["Challan_Count"].Rows[0]["Success"]) + " Challans and " + Convert.ToInt32(dsExport.Tables["Voucher_Count"].Rows[0]["Success"]) + " Vouchers records imported";
                        param = new SqlParameter[2];
                        param[0] = new SqlParameter("@companyId", HttpContext.Current.Session["companyid"]);
                        param[1] = new SqlParameter("@formType", HttpContext.Current.Session["form"]);
                        SqlHelper.ExecuteNonQuery(_cnnString2, CommandType.StoredProcedure, "BTS_SyncChallanVoucherExcelInfo", param);

                    }
                }
                else
                {
                    resonseType.isPass = false;
                }
                context.Response.StatusCode = (int)HttpStatusCode.OK;
                context.Response.ContentType = "text/json";
                context.Response.Write(JsonConvert.SerializeObject(resonseType));
                context.Response.End();
            }
        }
        catch (Exception ex)
        {
            if (ex.Message != "Thread was being aborted.")
            {
                ResonseType resonseType = new ResonseType();
                resonseType.isPass = false;
                resonseType.errorMessage = ex.Message.ToString();


                context.Response.StatusCode = (int)HttpStatusCode.OK;
                context.Response.ContentType = "text/json";
                context.Response.Write(JsonConvert.SerializeObject(resonseType));
                context.Response.End();
            }
        }
    }

    private string DumpChallanVoucherExcel(DataSet ds, HttpContext context, bool isBackup)
    {
        Random rn = new Random();
        string folderPath = context.Server.MapPath("~/Uploads/");
        string templatefile = string.Empty;
        templatefile = HttpContext.Current.Server.MapPath("~/TDS/BTStrp/Templates/") + Convert.ToString(context.Session["form"]) + "_Error_XLSheet.xlsx";
        string exportFile = string.Empty;
        exportFile = folderPath + Convert.ToString(context.Session["TANNo"]) + "_" + Convert.ToString(context.Session["form"]) + "_Error.xlsx";

        if (isBackup)
        {
            templatefile = HttpContext.Current.Server.MapPath("~/TDS/BTStrp/Templates/") + Convert.ToString(context.Session["form"]) + "_Error_XLSheet.xlsx";
            exportFile = folderPath + rn.Next().ToString() + "2324_BackupTemplate.xlsx";
        }

        FileInfo file = new FileInfo(exportFile);
        try
        {


            File.Copy(templatefile, exportFile, true);
            using (ExcelPackage pck = new ExcelPackage(file))
            {
                ExcelWorkbook excelWorkBook = pck.Workbook;
                ExcelWorksheet excelWorksheet = excelWorkBook.Worksheets.First();

                if (ds.Tables[1].Rows.Count > 0)
                {
                    excelWorksheet.Cells["A4"].LoadFromDataTable(ds.Tables[1], false);
                    excelWorksheet.Cells.AutoFitColumns();
                }
                ExcelWorksheet excelWorksheet2 = excelWorkBook.Worksheets.ElementAt(1);

                if (ds.Tables[3].Rows.Count > 0)
                {
                    excelWorksheet2.Cells["A4"].LoadFromDataTable(ds.Tables[3], false);
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

    void DeleteOldFiles(string path)
    {
        foreach (string s in Directory.GetFiles(path, "*", SearchOption.TopDirectoryOnly))
        {
            DateTime modification = File.GetCreationTime(s);
            FileInfo fileInfo = new FileInfo(s);
            if (fileInfo.Name != "2324_BackupTemplate.xlsx" && fileInfo.Name != "2324_BlankTemplate.xlsx")
            {
                if (modification < DateTime.Now.AddHours(-24))
                {
                    Console.WriteLine(modification);
                    Console.WriteLine(s);
                    Console.WriteLine("File created in last 60 minutes");
                    try
                    {
                        File.Delete(s);
                    }
                    catch
                    {
                    }

                }
            }
        }
    }



    public bool IsReusable
    {
        get
        {
            return false;
        }
    }


}

