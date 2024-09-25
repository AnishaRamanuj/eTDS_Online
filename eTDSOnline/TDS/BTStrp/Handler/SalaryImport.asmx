<%@ WebService Language="C#" Class="SalaryImport" %>

using System;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
using System.Data;
using System.Web.Script.Serialization;
using System.IO;
using System.Net;
using System.Linq;
using System.Data.OleDb;
using System.Text.RegularExpressions;
using LibCommon;
using Microsoft.ApplicationBlocks1.Data;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class SalaryImport : System.Web.Services.WebService
{
    public const string UPLOAD_SALARY_STATUS_SUCCESS = "Success";
    public const string UPLOAD_SALARY_STATUS_FAILED = "Failed";
    public const string UPLOAD_SALARY_STATUS_PARTIAL_SUCCESS = "Partial Success";
    public const string UPLOAD_BULK_SALARY_RECORD_FOLDERPATH = "~/Uploads/";

    [WebMethod(EnableSession = true)]
    public string BulkUploadSalary()
    {
        BulkUploadSalaryResponse uploadSalaryResponse = new BulkUploadSalaryResponse() { IsBulkValidationSuccess = true, BulkUploadMessage = "", BulkValidationMessage = "" };
        HttpStatusCode statusCode = HttpStatusCode.OK;

        DataSet ds = new DataSet();
        HttpContext context = HttpContext.Current;
        try
        {
            if (context.Request.Files.Count > 0)
            {
                string compId = Session["companyid"].ToString();
                string month = HttpContext.Current.Request.Form["month"];
                string monthName = GetMonthName(Convert.ToInt32(month));

                HttpPostedFile postedFile = context.Request.Files[0];
                string folderPath = context.Server.MapPath("~/Uploads/");
                string fileName = Path.GetFileName(postedFile.FileName);
                string fullPath = folderPath + fileName;
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
                    DataTable dtSchema = excel_con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, new object[] { null, null, null, "TABLE" });

                    DataRow[] sheets = dtSchema.Select("TABLE_NAME LIKE '" + monthName + "%'");
                    if (sheets.Length > 0)
                    {
                        using (OleDbDataAdapter oda = new OleDbDataAdapter(String.Format("SELECT * FROM [{0}]", sheets[0]["TABLE_NAME"]), excel_con))
                        {
                            oda.Fill(dtExcelData);
                        }
                        excel_con.Close();

                        var dataRows = dtExcelData.Rows
                                    .Cast<DataRow>()
                                    .Where(row => !row.ItemArray.All(field => field is DBNull ||
                                                     string.IsNullOrWhiteSpace(field as string)));

                        if (dataRows.Any())
                        {
                            dtExcelData = dataRows.CopyToDataTable();
                            DataTable dtImportData = dtExcelData.Clone();
                            uploadSalaryResponse.IsBulkValidationSuccess = true;

                            foreach (DataRow drow in dtExcelData.Rows)
                            {
                                string validationMessage = string.Empty;

                                if (!isValidateRow(drow, out validationMessage))
                                {
                                    uploadSalaryResponse.IsBulkValidationSuccess = false;
                                    uploadSalaryResponse.BulkValidationMessage += validationMessage + "<br>";
                                }
                                else
                                {
                                    //dtImportData.Rows.Add(drow);
                                    dtImportData.ImportRow(drow);
                                }
                            }
                            if (dtImportData.Rows.Count > 0)
                            {
                                Guid importTransactionId = Guid.NewGuid();
                                DataColumn colImportTransactionId = new DataColumn("ImportTransactionId", typeof(Guid));
                                colImportTransactionId.DefaultValue = importTransactionId;
                                dtExcelData.Columns.Add(colImportTransactionId);

                                DataColumn colCompId = new DataColumn("CompId", typeof(int));
                                colCompId.DefaultValue = Convert.ToInt32(compId);
                                dtExcelData.Columns.Add(colCompId);

                                DataColumn colMonth = new DataColumn("Month", typeof(string));
                                colMonth.DefaultValue = month;
                                dtExcelData.Columns.Add(colMonth);

                                //bool result = objBAL_Import_Salary.ImportSalary(dtImportData, importTransactionId);
                                bool result = ImportSalaryDB(dtExcelData, importTransactionId, Convert.ToInt32(compId));
                                uploadSalaryResponse.BulkUploadMessage += "Salary file imported successfully";
                            }
                        }
                        else
                        {
                            uploadSalaryResponse.BulkUploadMessage += "No data found in the sheet";

                        }
                    }
                    else
                    {
                        uploadSalaryResponse.BulkUploadMessage += "Sheet not found for the selected month";
                        statusCode = HttpStatusCode.BadRequest;
                    }
                }
            }
            else
            {
                uploadSalaryResponse.BulkUploadMessage += "File not uploaded properly. Please re-upload the file.";
                statusCode = HttpStatusCode.BadRequest;
            }
        }
        catch (Exception ex)
        {
            statusCode = HttpStatusCode.InternalServerError;
            uploadSalaryResponse.BulkUploadMessage += ex.Message;
        }
        finally
        {
            //Send OK Response to Client.
            HttpContext.Current.Response.StatusCode = (int)statusCode;
            HttpContext.Current.Response.Write(new JavaScriptSerializer().Serialize(uploadSalaryResponse));
            HttpContext.Current.Response.Flush();
            //HttpContext.Current.ApplicationInstance.CompleteRequest();
            HttpContext.Current.Response.End();
        }
        return new JavaScriptSerializer().Serialize(uploadSalaryResponse);
    }

    public bool ImportSalaryDB(DataTable dtExcelData, Guid importTransactionId, int compId)
    {
        DALCommonLib objComm = new DALCommonLib();
        DataSet ds = new DataSet();
        try
        {
            using (SqlConnection con = new SqlConnection(objComm._cnnString2))
            {
                using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(con))
                {
                    sqlBulkCopy.DestinationTableName = "dbo.tbl_Import_MonthlySalary";

                    sqlBulkCopy.ColumnMappings.Add("ImportTransactionId", "ImportTransactionId");
                    sqlBulkCopy.ColumnMappings.Add("CompId", "CompId");
                    sqlBulkCopy.ColumnMappings.Add("Month", "Month");
                    sqlBulkCopy.ColumnMappings.Add("Employee", "Employee");
                    sqlBulkCopy.ColumnMappings.Add("PAN", "PAN");
                    sqlBulkCopy.ColumnMappings.Add("Basic", "Basic");
                    sqlBulkCopy.ColumnMappings.Add("DA", "DA");
                    sqlBulkCopy.ColumnMappings.Add("HRA", "HRA");
                    sqlBulkCopy.ColumnMappings.Add("Others", "Others");
                    sqlBulkCopy.ColumnMappings.Add("Net# Salary", "NetSalary");
                    con.Open();
                    sqlBulkCopy.WriteToServer(dtExcelData);
                    con.Close();
                }
            }

            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@ImportTransactionId", importTransactionId);
            param[1] = new SqlParameter("@CompId", compId);

            SqlHelper.ExecuteScalar(objComm._cnnString2, CommandType.StoredProcedure, "usp_Import_MonthlySalary", param);
        }
        catch (Exception)
        {

            throw;
        }
        return true;
    }

    private string GetMonthName(int month)
    {
        DateTime date = new DateTime(DateTime.Now.Year, month, 1);
        return date.ToString("MMM");
    }

    private bool isValidateRow(DataRow dataRow, out string message)
    {
        message = "<br>For Sr.No." + dataRow["Sr#No#"].ToString();

        bool valid = true;
        if (!isValidPanCardNo(dataRow["PAN"].ToString()))
        {
            message += "<br>- Invalid PAN No. '" + dataRow["PAN"].ToString() + "'";
            valid = false;
        }

        if (!IsEmptyOrNumeric(dataRow["Basic"].ToString()))
        {
            message += "<br>- Basic value is not a numeric. '" + dataRow["Basic"].ToString() + "'";
            valid = false;
        }

        if (!IsEmptyOrNumeric(dataRow["DA"].ToString()))
        {
            message += "<br>- DA value is not a numeric. '" + dataRow["DA"].ToString() + "'";
            valid = false;
        }

        if (!IsEmptyOrNumeric(dataRow["HRA"].ToString()))
        {
            message += "<br>- HRA value is not a numeric. '" + dataRow["HRA"].ToString() + "'";
            valid = false;
        }

        if (!IsEmptyOrNumeric(dataRow["Others"].ToString()))
        {
            message += "<br>- Others value is not a numeric. '" + dataRow["Others"].ToString() + "'";
            valid = false;
        }

        if (!IsEmptyOrNumeric(dataRow["Net# Salary"].ToString()))
        {
            message += "<br>- Net Salary value is not a numeric. '" + dataRow["Net# Salary"].ToString() + "'";
            valid = false;
        }

        return valid;
    }

    private bool IsEmptyOrNumeric(string value)
    {
        if (string.IsNullOrEmpty(value))
            return true;

        decimal parsedValue;
        return decimal.TryParse(value, out parsedValue);
    }

    private bool isValidPanCardNo(string str)
    {
        string strRegex = @"[A-Z]{5}[0-9]{4}[A-Z]{1}$";
        Regex re = new Regex(strRegex);
        if (re.IsMatch(str))
            return (true);
        else
            return (false);
    }
}

public class BulkUploadSalaryResponse
{
    public string BulkUploadMessage { get; set; }
    public bool IsBulkValidationSuccess { get; set; }
    public string BulkValidationMessage { get; set; }
}