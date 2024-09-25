using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLayer;
using System.Data;
using System.IO;
using System.Text;
using System.Security.Cryptography;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;
using DevExpress.Pdf;

public partial class Admin_ManageSalary_ChallanList : System.Web.UI.Page
{
    CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
    BAL_QuaterSelection objBAL_QuaterSelection = new BAL_QuaterSelection();
    BAL_ManageSalary_ChallanList obj = new BAL_ManageSalary_ChallanList();
    protected void Page_Load(object sender, EventArgs e)
    {

        string Q = "";
        string F = "";
        if (Session["companyid"] == null)
        { Response.Redirect("~/Default.aspx", true); }

        if (!IsPostBack)
        {
            Q = Session["Qtr"].ToString();
            F = Session["frm"].ToString();
            ddlSalaryQuater.SelectedValue = Q;
            hdnForm.Value = F;
            hdnQuarter.Value = Q;
            hdnCompanyid.Value = Session["companyid"].ToString();
            if (Session["Financial_Year_Text"] != null)
            {

                string[] fy = Session["Financial_Year_Text"].ToString().Split('_');
                hdnfinancialyear.Value = fy[0] + fy[1];
            }
            BAL_EReturns_NonSalary objBAL_EReturns_NonSalary = new BAL_EReturns_NonSalary();
            objBAL_EReturns_NonSalary.Company_ID = Convert.ToInt32(Session["companyid"].ToString());
            DataSet ds = objBAL_EReturns_NonSalary.BAL_NonSalaryEretursDetailsOnPageLoad();
            if (ds != null)
            {
                hdntanno.Value = ds.Tables[0].Rows[0]["Tanno"].ToString();
            }

            
         }
        else
        {
            //Q = Session["Qtr"].ToString();
            F = "24Q";
            Q = ddlSalaryQuater.SelectedValue;
            Session["Qtr"] = Q;
            hdnForm.Value = F;
            hdnQuarter.Value = Q;
            hdnCompanyid.Value = Session["companyid"].ToString();
            btnGenerateTextFile.Style["display"] = "none";
        }
    }

    protected void BindTimeTric(object sender, EventArgs e)
    {
        Timer1.Enabled = false;
        BindGridQuaterSalary();
    }
    protected void BindGridQuaterSalary()
    {
        DataSet ds = new DataSet();
        try
        {
            objBAL_QuaterSelection.Quater = ddlSalaryQuater.SelectedValue;

            if (ddlSalary_Searchby.SelectedValue == "0")
            {
                objBAL_QuaterSelection.ChallanNo = "";
                objBAL_QuaterSelection.ChallanDate = "";
            }
            else if (ddlSalary_Searchby.SelectedValue == "1")
            {
                objBAL_QuaterSelection.ChallanDate = "";

                if (txtSalarySearchChallano.Text != "")
                    objBAL_QuaterSelection.ChallanNo = txtSalarySearchChallano.Text;
                else
                    objBAL_QuaterSelection.ChallanNo = "";
            }
            else if (ddlSalary_Searchby.SelectedValue == "2")
            {
                objBAL_QuaterSelection.ChallanDate = "";

                if (txtSalarChallanDate.Text != "")
                    objBAL_QuaterSelection.ChallanDate = CommonSettings.ConvertToCulturedDateTime(txtSalarChallanDate.Text).ToString("MM/dd/yyyy");
                else
                    objBAL_QuaterSelection.ChallanDate = "";
            }

            int month = DateTime.Now.Month;
            int year = DateTime.Now.Year;
            string sfin, efin;
            if (month <= 3)
            {
                sfin = (year - 1).ToString();
                efin = year.ToString();
            }
            else
            {
                sfin = year.ToString();
                efin = (year + 1).ToString();
            }

            objBAL_QuaterSelection.CompanyID = Convert.ToInt32(Session["companyid"]);
            objBAL_QuaterSelection.FinancialStart = sfin;
            objBAL_QuaterSelection.FinancialEnd = efin;
            ds = objBAL_QuaterSelection.BAL_BindGridQuater();

            if (ds.Tables[0].Rows.Count > 0)
            {
                gvSalaryDetails.PageSize = Convert.ToInt32(ddlperpage.SelectedValue);
                gvSalaryDetails.DataSource = ds.Tables[0];
                gvSalaryDetails.DataBind();
            }
            else
            {
                gvSalaryDetails.DataSource = ds;
                gvSalaryDetails.DataBind();
            }
        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex);
            ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
        }
    }
    protected void ddlperpage_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGridQuaterSalary();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindGridQuaterSalary();
    }
    protected void gvSalaryDetails_DataBound(object sender, EventArgs e)
    {
        double res = 0;
        foreach (GridViewRow row in gvSalaryDetails.Rows)
        {
            Label lblAmount = (Label)row.FindControl("lblAmount");
            if (lblAmount.Text != "" && !string.IsNullOrEmpty(lblAmount.Text))
                res += Convert.ToDouble(lblAmount.Text);
        }
        if (gvSalaryDetails.Rows.Count > 0)
        {
            gvSalaryDetails.FooterRow.Cells[8].Text = "Total";
            gvSalaryDetails.FooterRow.Cells[9].Text = string.Format("{0:N2}", res);
        }
    }
    protected void gvSalaryDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvSalaryDetails.PageIndex = e.NewPageIndex;
        BindGridQuaterSalary();
    }
    protected void gvSalaryDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            bool istrue = false;
            if (e.CommandName == "EditCommand")
            {
                Session["Salary24QQuarter"] = ddlSalaryQuater.SelectedValue;
                Session["SalaryChallanID"] = e.CommandArgument.ToString();
                Response.Redirect("ManageSalary_Challan.aspx", false);
            }
            if (e.CommandName == "DeleteCommand")
            {
                objBAL_QuaterSelection.ChallanID = Convert.ToInt32(e.CommandArgument);
                int result = objBAL_QuaterSelection.DeleteSalaryChallanID();

                if (result > 0)
                { istrue = true; }
                if (result < 0)
                { istrue = true; }
                if (istrue)
                {
                    BindGridQuaterSalary();
                    ucMessageControl.SetMessage("Deleted Successfully", MessageDisplay.DisplayStyles.Success);
                }
            }
        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex);
            ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
        }
    }
    protected void btnAddnew_Click(object sender, EventArgs e)
    {
        try
        {
            Session["Salary24QQuarter"] = ddlSalaryQuater.SelectedValue;
            Response.Redirect("ManageSalary_Challan.aspx", true);
            return;
        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex);
            ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
        }
    }


    protected void gvSalaryDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
           
            Label lblother = (e.Row.FindControl("lblOther") as Label);

            double otherAmt = Convert.ToDouble(lblother.Text);

            if (otherAmt > 0)
            {
                e.Row.BackColor = System.Drawing.Color.LightYellow;
            }

            Label lbl = (e.Row.FindControl("lblverify") as Label);
            if (lbl.Text == "UnMatched")
            {
                lbl.ForeColor = System.Drawing.Color.Red;
            }
            else if (lbl.Text == "")
            {
                lbl.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                lbl.ForeColor = System.Drawing.Color.Green;
            }

        }
    }


    protected void btnGenerateTextFile_Click(object sender, EventArgs e)
    {

            BindGridQuaterSalary();
            ucMessageControl.SetMessage("Verification done successfully.", MessageDisplay.DisplayStyles.Success);
            return;
       
    }

}