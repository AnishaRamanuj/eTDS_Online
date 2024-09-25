using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLayer;
using System.Data;

public partial class Admin_ManageNonSalary_BranchMaster : System.Web.UI.Page
{
    CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
    BAL_Branch_Salary_Master objBAL_Branch_Salary_Master = new BAL_Branch_Salary_Master();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["companyid"] == null)
        {
            Response.Redirect("~/Default.aspx");
        }
        if (!IsPostBack)
        {
            hdnbranchid.Value = "0";
            objBAL_Branch_Salary_Master._Branch_ID = 0;
            objBAL_Branch_Salary_Master._Branch_Name = "";
            objBAL_Branch_Salary_Master._Company_ID = Convert.ToInt32(Session["companyid"]);
            DataSet ds = objBAL_Branch_Salary_Master.BAL_InsertGetNonSalaryBranchMaster();
            BindBranchMaster(ds.Tables[0]);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = null;
            objBAL_Branch_Salary_Master._Company_ID = Convert.ToInt32(Session["companyid"]);
            objBAL_Branch_Salary_Master._Branch_Name = txtBranchName.Text;
            if (hdnbranchid.Value == "0" || hdnbranchid.Value == "")
            {
                objBAL_Branch_Salary_Master._Branch_ID = 0;
                ds = objBAL_Branch_Salary_Master.BAL_InsertGetNonSalaryBranchMaster();
                BindBranchMaster(ds.Tables[0]);
            }
            else
            {
                objBAL_Branch_Salary_Master._Branch_ID = Convert.ToInt32(hdnbranchid.Value);
                ds = objBAL_Branch_Salary_Master.BAL_InsertGetNonSalaryBranchMaster();
                BindBranchMaster(ds.Tables[0]);
            }
            ucMessageControl.SetMessage("Details Submitted Successfully", MessageDisplay.DisplayStyles.Success);
            txtBranchName.Text = "";
            hdnbranchid.Value = "0";
        }
        catch (Exception ex)
        {
            ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
        }
    }
    protected void BindBranchMaster(DataTable ds)
    {
        gvBranchNon.Visible = true;
        gvBranchNon.DataSource = ds;
        gvBranchNon.DataBind();
    }
    protected void gvBranchNon_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        DataSet ds = null;
        if (e.CommandName == "EditCommand")
        {
            GridViewRow row = (GridViewRow)(((Control)e.CommandSource).NamingContainer);
            Label lblBranchName = (Label)row.FindControl("lblBranchName");
            HiddenField hdnBranch_ID = (HiddenField)row.FindControl("hdnBranch_ID");
            txtBranchName.Text = lblBranchName.Text;
            hdnbranchid.Value = hdnBranch_ID.Value;
            gvBranchNon.Visible = false;
        }
        if (e.CommandName == "DeleteCommand")
        {
            GridViewRow row = (GridViewRow)(((Control)e.CommandSource).NamingContainer);
            HiddenField hdnBranch_ID = (HiddenField)row.FindControl("hdnBranch_ID");
            objBAL_Branch_Salary_Master._Branch_Name = "Delete";
            objBAL_Branch_Salary_Master._Branch_ID = Convert.ToInt32(hdnBranch_ID.Value);
            objBAL_Branch_Salary_Master._Company_ID = Convert.ToInt32(Session["companyid"]);
            ds = objBAL_Branch_Salary_Master.BAL_InsertGetNonSalaryBranchMaster();
            if (gvBranchNon.Rows.Count > ds.Tables[0].Rows.Count)
            { ucMessageControl.SetMessage("Details Deleted Successfully ", MessageDisplay.DisplayStyles.Success); }
            else { ucMessageControl.SetMessage("Can't Delete Details ", MessageDisplay.DisplayStyles.Error); }
            BindBranchMaster(ds.Tables[0]);
        }
    }
    protected void btnCancle_Click(object sender, EventArgs e)
    {
        txtBranchName.Text = "";
        hdnbranchid.Value = "0";
        gvBranchNon.Visible = true;
    }
}