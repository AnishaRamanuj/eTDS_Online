using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OfficeOpenXml;
using System.IO;
using Microsoft.ApplicationBlocks1.Data;
using OfficeOpenXml.Style;
using System.Drawing;
using CommonLibrary;
using LibCommon;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using System.Net;
public partial class Admin_Dashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnBackup_Click(object sender, EventArgs e)
    {
        DALCommonLib obj = new DALCommonLib();
        CommonFunctions Comm = new CommonFunctions();

        DataTable reportDataTable = new DataTable();


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



            int Compid = Convert.ToInt32(Session["companyid"].ToString());
            string formType = hdnFrm.Value;
            string Qtr = hdnQtr.Value;

            SqlParameter[] objSqlParameter = new SqlParameter[3];
            objSqlParameter[0] = new SqlParameter("@companyId", Compid);
            objSqlParameter[1] = new SqlParameter("@formType", formType);
            objSqlParameter[2] = new SqlParameter("@Qtr", Qtr);

            DataSet ds = SqlHelper.ExecuteDataset(obj._cnnString2, "usp_Bootstrap_BackupforVoucherChallance_Qtr", objSqlParameter);

            if (ds.Tables[1].Rows.Count > 0 || ds.Tables[0].Rows.Count > 0)
            {

                SqlParameter[] LogSqlParameter = new SqlParameter[2];


                LogSqlParameter[0] = new SqlParameter("@companyId", Compid);
                LogSqlParameter[1] = new SqlParameter("@formType", formType);

                //DataSet dsLg = SqlHelper.ExecuteDataset(obj._cnnString2, "BTS_CreateBackupEntryLog", LogSqlParameter);
                resonseType.filePath = DumpChallanVoucherExcel(ds, true, Context);
                resonseType.isPass = true;
            }
            else
            {
                resonseType.filePath = "No records to export";
            }


        }
        catch (Exception ex)
        {


        }
    }

    private string DumpChallanVoucherExcel(DataSet ds, bool isBackup, HttpContext context)
    {
        Random rn = new Random();
        string fName = "";
        string folderPath = HttpContext.Current.Server.MapPath("~/Uploads/");
        string templatefile = string.Empty;
        templatefile = HttpContext.Current.Server.MapPath("~/BTStrp/Templates/") + hdnFrm.Value  + "_Blank_XLSheet.xlsx";
        string exportFile = string.Empty;
        exportFile = folderPath + rn.Next().ToString() + "2324_BlankTemplate.xlsx";
        if (isBackup)
        {
            templatefile = HttpContext.Current.Server.MapPath("~/BTStrp/Templates/") + hdnFrm.Value + "_Blank_XLSheet.xlsx";
            exportFile = folderPath + Convert.ToString(context.Session["TANNo"]) + "_" + hdnFrm.Value + "_" + DateTime.Now.ToString("dd-MMM-yyyy").Replace("-", "_") + ".xlsx";
            fName = Convert.ToString(context.Session["TANNo"]) + "_" + hdnFrm.Value + "_" + DateTime.Now.ToString("dd-MMM-yyyy").Replace("-", "_") + ".xlsx";
        }

        FileInfo file = new FileInfo(exportFile);
        try
        {


            File.Copy(templatefile, exportFile, true);
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

                using (var memoryStream = new MemoryStream())
                {
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("content-disposition", "attachment;  filename=" + fName);
                    pck.SaveAs(memoryStream);
                    memoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();

                }
                //pck.Save();
            }
        }
        catch (Exception ex)
        {

        }
        finally
        {


        }
        return exportFile;
    }

}