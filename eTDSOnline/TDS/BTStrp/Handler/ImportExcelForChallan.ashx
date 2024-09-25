<%@ WebHandler Language="C#" Class="ImportExcelForChallan" %>

using System;
using System.Web;
using System.Net;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Data.SqlClient;
using System.Web.SessionState;
using Newtonsoft.Json;
using Microsoft.ApplicationBlocks1.Data;

public class ImportExcelForChallan : DataLayer.DALCommon, IHttpHandler, IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        DataTable dtExcelData = new DataTable();
        DataSet ds = new DataSet();
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

                    //[OPTIONAL]: It is recommended as otherwise the data will be considered as String by default.

                    DataTable dtSchema = excel_con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, new object[] { null, null, null, "TABLE" });

                    string Sheet1 = dtSchema.Rows[0].Field<string>("TABLE_NAME");
                    if (Sheet1 == "Employee$")
                    {
                        using (OleDbDataAdapter oda = new OleDbDataAdapter(String.Format("SELECT * FROM [{0}]", Sheet1), excel_con))
                        {
                            //oda.Fill(dtExcelData);
                            oda.Fill(ds);
                        }
                        excel_con.Close();

                        //remove mandatory rows
                        //dtExcelData.Rows.RemoveAt(0);
                        ds.Tables[0].Rows.RemoveAt(0);

                        //dtExcelData = dtExcelData.Rows.Cast<DataRow>()
                        //.Where(row => !row.ItemArray.All(field => field is DBNull ||
                        //                 string.IsNullOrWhiteSpace(field as string)))
                        //.CopyToDataTable();                            
                    }
                }

                context.Response.StatusCode = (int)HttpStatusCode.OK;
                context.Response.ContentType = "text/json";
                context.Response.Write(JsonConvert.SerializeObject(ds.GetXml()));
                context.Response.End();
            }
        }

        catch (Exception ex)
        {
            throw ex;
        }
        //return dtExcelData.DataSet.GetXml();
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}