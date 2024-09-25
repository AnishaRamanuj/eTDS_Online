<%@ WebHandler Language="C#" Class="XL" %>
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

public class XL : DataLayer.DALCommon, IHttpHandler, IRequiresSessionState {

    public void ProcessRequest(HttpContext context)
    {
        DataSet ds = new DataSet();
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
                string Sheet1 = dtSchema.Rows[0].Field<string>("TABLE_NAME");

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

                //remove existing data

                //param[0] = new SqlParameter("@companyId", HttpContext.Current.Session["companyid"]);
                //param[1] = new SqlParameter("@indication", 2);
                //SqlHelper.ExecuteNonQuery(_cnnString, CommandType.StoredProcedure, "DBP_ExcelValidation", param);

                using (SqlConnection con = new SqlConnection(_cnnString))
                {


                    using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(con))
                    {
                        //Set the database table name
                        sqlBulkCopy.DestinationTableName = "dbo.tbl_HC";
                        sqlBulkCopy.ColumnMappings.Add("Staffcode", "Staffcode");
                        sqlBulkCopy.ColumnMappings.Add("Staffname", "Staffname");
                        sqlBulkCopy.ColumnMappings.Add("dateofleaving", "dateofleaving");
                        sqlBulkCopy.ColumnMappings.Add("Hourly", "Hourly");



                        con.Open();
                        sqlBulkCopy.WriteToServer(dtExcelData);
                        con.Close();


                    }
                }
            }

            //param = new SqlParameter[2];
            //param[0] = new SqlParameter("@companyId", HttpContext.Current.Session["companyid"]);
            //param[1] = new SqlParameter("@indication", 1);
            //ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "DBP_ExcelValidation", param);





            context.Response.StatusCode = (int)HttpStatusCode.OK;
            context.Response.ContentType = "text/json";
            context.Response.Write(JsonConvert.SerializeObject(ds));
            context.Response.End();
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