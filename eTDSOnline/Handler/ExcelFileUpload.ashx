<%@ WebHandler Language="C#" Class="ExcelFileUpload" %>
using System.Web.Services;

using System;
using System.Web;
using System.Net;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Data.SqlClient;
using System.Web.SessionState;

using System.Collections.Generic;
using System.Linq;
using System.Text;
using Newtonsoft.Json;
using Microsoft.ApplicationBlocks1.Data;
using DataLayer;
using System.Threading;

using CommonLibrary;

public class ExcelFileUpload : DataLayer.DALCommon, IHttpHandler, IRequiresSessionState
{

    public void ProcessRequest(HttpContext context)
    {
        DataSet ds = new DataSet();
        string df = "";
        try
        {
            //Check if Request is to Upload the File.
            if (context.Request.Files.Count > 0)
            {
                //Fetch the Uploaded File.
                HttpPostedFile postedFile = context.Request.Files[0];

                //Set the Folder Path.
                string folderPath = context.Server.MapPath("~/Uploads/");

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

                    string Sheet1 = "";
                    foreach (DataRow dr in dtSchema.Rows)
                    {
                        Sheet1 = dr["TABLE_NAME"].ToString(); ////// dtSchema.Rows[0].Field<string>("TABLE_NAME");
                        if (Sheet1 == "'Deductee Details$'")
                        {
                            df = "Deductee Details$";
                            using (OleDbDataAdapter oda = new OleDbDataAdapter(String.Format("SELECT * FROM [{0}]", Sheet1), excel_con))
                            {
                                oda.Fill(dtExcelData);
                            }
                            excel_con.Close();

                            //remove mandatory rows
                            dtExcelData.Rows.RemoveAt(0);

                            dtExcelData = dtExcelData.Rows
                            .Cast<DataRow>()
                            .Where(row => !row.ItemArray.All(field => field is DBNull ||
                                             string.IsNullOrWhiteSpace(field as string)))
                            .CopyToDataTable();

                            DataColumn newColumn = new DataColumn("CompanyID", typeof(System.Int16));
                            newColumn.DefaultValue = HttpContext.Current.Session["companyid"];
                            dtExcelData.Columns.Add(newColumn);

                            newColumn = new DataColumn("FinancialYear", typeof(System.String));
                            newColumn.DefaultValue = HttpContext.Current.Session["Financial_Year_Text"];
                            dtExcelData.Columns.Add(newColumn);

                            //remove existing data
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

                            param[0] = new SqlParameter("@companyId", HttpContext.Current.Session["companyid"]);
                            param[1] = new SqlParameter("@indication", 2);
                            SqlHelper.ExecuteNonQuery(_cnnString2, CommandType.StoredProcedure, "DBP_ExcelValidation", param);
                            using (SqlConnection con = new SqlConnection(_cnnString2))
                            {
                                using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(con))
                                {
                                    //Set the database table name
                                    sqlBulkCopy.DestinationTableName = "dbo.tbl_ExcelValidation";
                                    sqlBulkCopy.ColumnMappings.Add("FinancialYear", "FinancialYear");
                                    sqlBulkCopy.ColumnMappings.Add("CompanyID", "CompanyID");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[0].ToString(), "Deductee_Code");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[1].ToString(), "PAN_of_Deductee");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[2].ToString(), "Name_Of_Deductee");
                                    // sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[3].ToString(), "Section_Code");

                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[3].ToString(), "Section_Description");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[4].ToString(), "Payment_CreditDate");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[5].ToString() == "" ? "0" : dtExcelData.Columns[5].ToString(), "Amount_Paid_Credited");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[6].ToString() == "" ? "0" : dtExcelData.Columns[6].ToString(), "TDS");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[7].ToString() == "" || dtExcelData.Columns[7].ToString() == DBNull.Value.ToString() ? "0" : dtExcelData.Columns[7].ToString(), "Surcharge");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[8].ToString() == "" ? "0" : dtExcelData.Columns[8].ToString(), "Education_Cess");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[9].ToString() == "" ? "0" : dtExcelData.Columns[9].ToString(), "Total_Tax_Deducted");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[10].ToString() == "" ? "0" : dtExcelData.Columns[10].ToString(), "Rate_at_which_deducted");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[11].ToString(), "Reason_for_Non_deduction_Lower_Deduction");
                                    sqlBulkCopy.ColumnMappings.Add(dtExcelData.Columns[12].ToString(), "Certificate_number_for_Lower_NonDeduction");

                                    con.Open();
                                    sqlBulkCopy.WriteToServer(dtExcelData);
                                    con.Close();
                                }
                            }
                            goto lbl10;
                        }
                    }  //// end of for Loop Schema

                }
            lbl10:

                param = new SqlParameter[2];
                param[0] = new SqlParameter("@companyId", HttpContext.Current.Session["companyid"]);
                param[1] = new SqlParameter("@indication", 1);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "DBP_ExcelValidation", param);

                context.Response.StatusCode = (int)HttpStatusCode.OK;
                context.Response.ContentType = "text/json";
                context.Response.Write(JsonConvert.SerializeObject(ds));
                context.Response.End();
            }
        }
        catch (Exception ex)
        {
            if (df == "")
            {
                context.Response.StatusCode = (int)HttpStatusCode.NotFound ;
                context.Response.ContentType = "text/json";
                context.Response.Write(JsonConvert.SerializeObject("Sheet Name Not Proper"));
                context.Response.End();
            }


            else if (ex.Message == "Conversion failed when converting date and/or time.")
            {
                context.Response.StatusCode = (int)HttpStatusCode.NotFound ;
                context.Response.ContentType = "text/json";
                context.Response.Write(JsonConvert.SerializeObject(ex.Message));
                context.Response.End();
            }
            else if (ex.Message =="The given value of type String from the data source cannot be converted to type datetime of the specified target column.")
            {
                context.Response.StatusCode = (int)HttpStatusCode.NotFound ;
                context.Response.ContentType = "text/json";
                context.Response.Write(JsonConvert.SerializeObject("Value of Date is in incorrect format"));
                context.Response.End();
            }           
            else if (ex.Message != "Thread was being aborted.")
            {
                context.Response.StatusCode = (int)HttpStatusCode.OK;
                context.Response.ContentType = "text/json";
                context.Response.Write(JsonConvert.SerializeObject(ex.Message));
                context.Response.End();
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