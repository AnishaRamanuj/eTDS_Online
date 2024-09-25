using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;
using BusinessLayer;
using CommonLibrary;
using System.Data;
using PANVrf;
using System.Web.Services;
using System.Web.Script.Serialization;
using OfficeOpenXml;
using System.IO;
using Microsoft.ApplicationBlocks1.Data;
using OfficeOpenXml.Style;
using System.Drawing;

public partial class Admin_TDSComputation : System.Web.UI.Page
{
    CommonFunctions ErrorException = new CommonFunctions();
    DALCommon objDALCommon = new DALCommon();
    BAL_TDSComputation objBAL_TDSComputation = new BAL_TDSComputation();

    BAL_Employee_Master objBAL_Employee_Master = new BAL_Employee_Master();
    BAL_State_Master objBAL_State_Master = new BAL_State_Master();
    BAL_Department_Master objBAL_Department_Master = new BAL_Department_Master();
    BAL_Designation_Master objBAL_Designation_Master = new BAL_Designation_Master();
    BAL_Branch_Salary_Master objBAL_Branch_Salary_Master = new BAL_Branch_Salary_Master();
    ConnectTraces CT = new ConnectTraces();
    Boolean ErrPan = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {
                if (Session["companyid"] == null)
                {
                    Response.Redirect("~/Default.aspx");
                }
                string FinancialYearText = (string)HttpContext.Current.Session["Financial_Year_Text"];
                string[] fy = FinancialYearText.ToString().Split('_');
                int fyr = Convert.ToInt32(fy[0]); 
                //if (fyr >= 2021)
                //{
                //    Response.Redirect("TdsComputation.aspx", true);
                //}
                //else
                //{
                    hdnCompanyID.Value = Session["companyid"].ToString();
                    BindPageLoad();
                    //BindStateCombos();
                //}
            }
        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex, hdnCompanyID.Value);
            if (hdnCompanyID.Value == "")
            {
                Response.Redirect("~/Default.aspx");
            }
        }
    }


    protected void BindPageLoad()
    {
        try
        {
            IEnumerable<tbl_Rebate_Master> tRebate = objBAL_TDSComputation.GetComputationPage(Convert.ToInt32(hdnCompanyID.Value));
            //ddlSection80C.DataSource = tRebate;
            //ddlSection80C.DataValueField = "Rebate_ID";
            //ddlSection80C.DataTextField = "Rebate_Name";
            //ddlSection80C.DataBind();
            //ddlSection80C.Items.Insert(0, new ListItem(" ( Select Rebate ) ", "0"));

            IEnumerable<tbl_Rebate_Limits> tRebateLimits = objBAL_TDSComputation.GetRebateLimits();
            hdnAllRebateLimits.Value = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(tRebateLimits);

            IEnumerable<tbl_TDS_Computation> tblPageCommonIDs = objBAL_TDSComputation.GetComputationPageCommonIDs(hdnCompanyID.Value);
            hdnHRRCalHeadID.Value = tblPageCommonIDs.Select(x => x.EmpName).FirstOrDefault().ToString();
            ////////////pt ids are getting when employee Computation Call following ids are replaced
            hdnPTCalHeadID.Value = tblPageCommonIDs.Select(x => x.Department_Name).FirstOrDefault().ToString();
            hdnPFCalHeadID.Value = tblPageCommonIDs.Select(x => x.Designation_Name).FirstOrDefault().ToString();
            hdnPFPercentage.Value = tblPageCommonIDs.Select(x => x.PF).FirstOrDefault().ToString();
            hdnPFLimit.Value = tblPageCommonIDs.Select(x => x.PreSal).FirstOrDefault().ToString();
            ////surcharge Calcualtion
            BAL_Surcharge_Master objBAL_Surcharge_Master = new BAL_Surcharge_Master();
            objBAL_Surcharge_Master._Company_ID = int.Parse(Session["companyid"].ToString());
            objBAL_Surcharge_Master._App_Type = "Sal";
            DataSet ds = objBAL_Surcharge_Master.BAL_GetSurchargedetails();
            if (ds != null)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    hdnSurchargePercentage.Value = ds.Tables[0].Rows[0]["Surcharge_Percent"].ToString();
                    hdnSurchargeType.Value = ds.Tables[0].Rows[0]["Surchargetype"].ToString();
                }
            }
        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex);
        }
    }

    //private void BindStateCombos()
    //{
    //    DataSet ds = objBAL_State_Master.Get_State_Master_List();
    //    CommonSettings.LoadCombo(ddlState, ds.Tables[0], "State_Name", "State_ID", true, "(Select State)");
    //}
    [WebMethod]
    public static string Get_State(int compid)
    {
        tbl_State obj = new tbl_State();
        BAL_State_Master objBAL_State_Master = new BAL_State_Master();
        IEnumerable<tbl_State> tbl = objBAL_State_Master.Get_State_List();
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }



    protected void btnExportXL_Click(object sender, EventArgs e)
    {
        int Compid = Convert.ToInt16(Session["companyid"].ToString());
        string fy = hdnConnString.Value;
        DataSet ds = objBAL_TDSComputation.BAL_ExportXL(Compid, fy);
        if (ds != null)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataTable dts = ds.Tables[0];
                DumpExcel(dts); 
            }
        }
    }
    private void DumpExcel(DataTable tbl)
    {
        using (ExcelPackage pck = new ExcelPackage())
        {
            //Create the worksheet
            DropDownList ddlCom = (DropDownList)this.Master.FindControl("ddlCompanyName");
            ExcelWorksheet ws = pck.Workbook.Worksheets.Add("TdsComputation");
            string FinancialYearText = (string)HttpContext.Current.Session["Financial_Year_Text"];
            //Load the datatable into the sheet, starting from cell A1. Print the column names on row 1
            ws.Cells["A4"].LoadFromDataTable(tbl, true);
            ws.Cells.AutoFitColumns();

            ws.Cells["A1"].Value = "Company Name";
            ws.Cells["B1"].Value = ddlCom.SelectedItem.Text;
            ws.Cells["A1"].Style.Font.Bold = true;
            
            ws.Cells["A2"].Value = "Report Name";
            ws.Cells["B2"].Value = "Employee_Computation_" + FinancialYearText + "";
            ws.Cells["A2"].Style.Font.Bold = true;
            using (ExcelRange rng = ws.Cells["A4:Y4"])
            {
                rng.Style.Font.Bold = true;
                rng.Style.Fill.PatternType = ExcelFillStyle.Solid;                      //Set Pattern for the background to Solid
                rng.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(79, 129, 189));  //Set color to dark blue
                rng.Style.Font.Color.SetColor(Color.White);
            }

            using (var memoryStream = new MemoryStream())
            {
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;  filename=Employee_Computation_" + FinancialYearText + ".xlsx");
                pck.SaveAs(memoryStream);
                memoryStream.WriteTo(Response.OutputStream);
                Response.Flush();
                Response.End();

            }
            ucMessageControl.SetMessage("Excel Sheet Exported Successfully!!!", MessageDisplay.DisplayStyles.Success);
        }
    }
}