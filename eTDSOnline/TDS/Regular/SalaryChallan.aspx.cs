using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using OfficeOpenXml;
using System.IO;
using System.Data.OleDb;
using LibCommon;
using Microsoft.ApplicationBlocks1.Data;
using System.Data.SqlClient;
using CommonLibrary;
public partial class Admin_SalaryChallan : System.Web.UI.Page
{
    DALCommonLib objComm = new DALCommonLib();
    CommonFunctions Comm = new CommonFunctions();
    string xlErr = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["companyid"] == null)
        { Response.Redirect("~/Login.aspx", false); }
        else
        {
            hdnQuater.Value = "";
            hdnForm.Value = "26Q";

            if (Request.QueryString["id"] != null && Request.QueryString["id"] != "")
            {
                hdnMis.Value = Request.QueryString["id"];
            }
            else if (Request.QueryString["D"] != null && Request.QueryString["D"] != "")
            {
                var d = Request.QueryString["D"];
                string[] dd = d.Split(',');

                hdnQuater.Value = dd[1];
                hdnForm.Value = dd[0];
            }
            else
            {
                DateTime baseDate = DateTime.Today;
                var thisWeekStart = baseDate;


                int mm = Convert.ToInt16(thisWeekStart.ToString("MM"));
                if (mm >= 4 && mm <= 6)
                {
                    hdnQuater.Value = "Q1";
                }
                else if (mm >= 7 && mm <= 9)
                {
                    hdnQuater.Value = "Q2";
                }
                else if (mm >= 10 && mm <= 12)
                {
                    hdnQuater.Value = "Q3";
                }
                else if (mm >= 1 && mm <= 3)
                {
                    hdnQuater.Value = "Q4";
                }

                hdnForm.Value = "26Q";
                hdnMis.Value = "";
            }

            hdnCompanyid.Value = Session["companyid"].ToString();
            hdnDate.Value = DateTime.Now.ToString("dd/MM/yyyy").Substring(0, 10);
        }
        if (!IsPostBack)
        {
            Session["CheckRefresh"] = Server.UrlDecode(System.DateTime.Now.ToString());
            //GetDropdowns();

        }
    }

    protected void btnExprecd_Click(object sender, EventArgs e)
    {
        try
        {

            DataSet dts = (DataSet)Session["EmpTable"];
            if (dts.Tables[0].Rows.Count > 0)
            {
                DumpExcel(dts.Tables[0]);
            }
            else
            {
                MessageBox.Show("No Records To EXPORT.");
            }

        }
        catch (Exception ex)
        {
            Comm.LogError(ex);
            //ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
        }
    }

    private void DumpExcel(DataTable tbl)
    {
        using (ExcelPackage pck = new ExcelPackage())
        {
            //Create the worksheet
            ExcelWorksheet ws = pck.Workbook.Worksheets.Add("Employee");

            //Load the datatable into the sheet, starting from cell A1. Print the column names on row 1
            ws.Cells["A1"].LoadFromDataTable(tbl, true);
            ws.Cells.AutoFitColumns();
            ////Format the header for column 1-3
       
            string ds = "G2:G" + (tbl.Rows.Count + 100).ToString();
            using (ExcelRange rn = ws.Cells[ds])
            {
                rn.Style.Numberformat.Format = "dd/MM/yyyy";
            }

            for (int i = 2; i < tbl.Rows.Count; i++)
            {

                ws.Cells["M" + i].Formula = "SUM(I" + i + ":L" + i + ")";
            }


            xlErr = "1";
            using (var memoryStream = new MemoryStream())
            {
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;  filename=Employee_Records_" + hdnQuater.Value + "_" + Convert.ToDateTime(hdnDate.Value).Month + ".xlsx");
                pck.SaveAs(memoryStream);
                memoryStream.WriteTo(Response.OutputStream);
                Response.Flush();
                Response.End();

            }
           // ucMessageControl.SetMessage("Excel Sheet Exported Successfully!!!", MessageDisplay.DisplayStyles.Success);
        }
    }

  
}