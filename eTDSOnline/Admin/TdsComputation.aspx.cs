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

public partial class Admin_TdsComputation : System.Web.UI.Page
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

                hdnCompanyID.Value = Session["companyid"].ToString();
                BindPageLoad();
                //BindStateCombos();
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
            ddlSection80C.DataSource = tRebate;
            ddlSection80C.DataValueField = "Rebate_ID";
            ddlSection80C.DataTextField = "Rebate_Name";
            ddlSection80C.DataBind();
            ddlSection80C.Items.Insert(0, new ListItem(" ( Select Rebate ) ", "0"));

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

    protected void btnExportXL_Click(object sender, EventArgs e)
    {
        int Compid = Convert.ToInt16(Session["companyid"].ToString());
        string fy = hdnConnString.Value;
 
    }
}