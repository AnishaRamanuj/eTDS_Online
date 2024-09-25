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
    BAL_ManageSalary_ChallanList obj = new BAL_ManageSalary_ChallanList();

    BAL_EReturns_NonSalary objBAL_EReturns_NonSalary = new BAL_EReturns_NonSalary();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["companyid"] == null)
        { Response.Redirect("~/Default.aspx", true);}

        string Q ="";
        string F ="";
        

        if (!IsPostBack)
        {
            Q = Session["Qtr"].ToString();
            F = Session["frm"].ToString();
            ddltype.SelectedValue = Q;
            ddlForm.SelectedValue = F;
            hdnForm.Value = F;
            hdnQuarter.Value = Q;
             
            if (Session["Financial_Year_Text"] != null)
            {

                string[] fy = Session["Financial_Year_Text"].ToString().Split('_');
                hdnfinancialyear.Value = fy[0] + fy[1];
            }
            hdnCompanyid.Value = Session["companyid"].ToString();
            objBAL_EReturns_NonSalary.Company_ID = Convert.ToInt32(Session["companyid"].ToString());
            DataSet ds = objBAL_EReturns_NonSalary.BAL_NonSalaryEretursDetailsOnPageLoad();
            if (ds != null)
            {
                hdntanno.Value = ds.Tables[0].Rows[0]["Tanno"].ToString();
            }

            Bind26Q();

        }
        else
        {
            Q = ddltype.SelectedValue;
            F = ddlForm.SelectedValue;
            Session["Qtr"] = Q;
            Session["frm"] = F;
            hdnForm.Value = F;
            hdnQuarter.Value = Q;
            hdnCompanyid.Value = Session["companyid"].ToString();
            btnGenerateTextFile.Style["display"] = "none";

        }
    }
    public void OnLoad()
    {
        try
        {

            if (Session["WhereNonSalaryCheck"] != null)
            {
                string ss = Session["WhereNonSalaryCheck"].ToString();

            }


            string fy = Session["Financial_Year_Text"].ToString();
            obj.CompanyID = Convert.ToInt32(Session["companyid"]);
            string[] splityear = fy.Split('_');  //ddlFinancialYear.SelectedItem.Text.Split('_');
            obj.FinancialStart = splityear[0];
            obj.FinancialEnd = "20" + splityear[1];
            DataSet ds = obj.BAL_GetAll_NonSalaryChallan_From_SP_Call();

            gv26Q.DataSource = ds.Tables[0];
            gv26Q.PageSize = Convert.ToInt32(ddl26Qperpage.SelectedValue);
            gv26Q.DataBind();

        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex); ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
        }
    }

    protected void Bind26Q()
    {
        try
        {
            obj.Quarter = ddltype.SelectedValue;
            if (ddl_Searchby26Q.SelectedValue == "0")
            {
                obj.ChallanNo = "";
                obj.ChallanDate = "";
            }
            else if (ddl_Searchby26Q.SelectedValue == "1")
            {
                obj.ChallanDate = "";

                if (txt_SearchChallano26Q.Text != "")
                    obj.ChallanNo = txt_SearchChallano26Q.Text;
                else
                    obj.ChallanNo = "";
            }
            else if (ddl_Searchby26Q.SelectedValue == "2")
            {
                obj.ChallanDate = "";

                if (txt_SearchDate26Q.Text != "")
                    obj.ChallanDate = CommonSettings.ConvertToCulturedDateTime(txt_SearchDate26Q.Text).ToString("MM/dd/yyyy");
                else
                    obj.ChallanDate = "";
            }
            string d = "";
            if (ddlForm.SelectedValue == "26Q")
            {
                d = "26Q";
            }
            else if (ddlForm.SelectedValue == "27Q(NRI)")
            {
                d = "27Q";
            }
            else if (ddlForm.SelectedValue == "27EQ(TCS)")
            {
                d = "27EQ";
            }
            else
            {
                d = "All";
            }
            BindAllGridView(obj.ChallanDate, obj.ChallanNo, obj.Quarter, d, gv26Q, Convert.ToInt32(ddl26Qperpage.SelectedValue));
        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex);
            ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
        }
    }


    protected void BindAllGridView(string challandate, string challanNo, string Quarter, string FromType, GridView GvGet, int PageSize)
    {
        DataSet ds = new DataSet();
        try
        {
            //DropDownList ddlFinancialYear = (DropDownList)Master.FindControl("ddlFinancialYear");
            string fy = Session["Financial_Year_Text"].ToString();
            obj.CompanyID = Convert.ToInt32(Session["companyid"]);
            string[] splityear = fy.Split('_');  //ddlFinancialYear.SelectedItem.Text.Split('_');
            obj.FinancialStart = splityear[0];
            obj.FinancialEnd = "20" + splityear[1];
            obj.ChallanDate = challandate;
            obj.ChallanNo = challanNo;
            obj.Quarter = Quarter;
            obj.FromType = FromType;

            ds = obj.Get_Queter_Selection_Challan_Non_Salary_Grid();

            GvGet.PageSize = PageSize;
            GvGet.DataSource = ds;
            GvGet.DataBind();

        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex);
            ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
        }
    }
    protected void gv26Q_DataBound(object sender, EventArgs e)
    {
        double res = 0;
        foreach (GridViewRow row in gv26Q.Rows)
        {
            Label lblAmount = (Label)row.FindControl("lblAmount");
            if (lblAmount.Text != "" && !string.IsNullOrEmpty(lblAmount.Text))
            {
                res += Convert.ToDouble(lblAmount.Text);
            }
        }
        if (gv26Q.Rows.Count > 0)
        {
            gv26Q.FooterRow.Cells[7].Text = "Total";
            gv26Q.FooterRow.Cells[8].Text = string.Format("{0:N2}", res);
        }



    }
    protected void gv26Q_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            bool istrue = false;
            if (e.CommandName == "EditCommand")
            {
                Session["FromType"] = "26Q";
                Session["SelectedQuarter"] = ddltype.SelectedValue;
                Session["SalaryNonChallanID"] = e.CommandArgument.ToString();
                Response.Redirect("ManageNonSalary_Challan.aspx", false);
            }
            if (e.CommandName == "DeleteCommand")
            {
                obj.ChallanID = Convert.ToInt32(e.CommandArgument);
                int result = obj.DeleteNonSalaryChallanID();

                if (result > 0)
                { istrue = true; }
                if (result < 0)
                { istrue = true; }
                if (istrue)
                {
                    Bind26Q();
                    ucMessageControl.SetMessage("Deleted Successfully", MessageDisplay.DisplayStyles.Success);
                }
            }
        }
        catch (Exception ex)
        { ErrorException.LogError(ex); ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error); }
    }


    protected void btnSearch26Q_Click(object sender, EventArgs e)
    {
        try
        {
            Bind26Q();
            ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "alert26Q", "chch();", true);
        }
        catch (Exception ex)
        { ErrorException.LogError(ex); ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error); }
    }



    protected void ddl26Qperpage_SelectedIndexChanged(object sender, EventArgs e)
    {
        Bind26Q();
    }

    protected void gv26Q_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gv26Q.PageIndex = e.NewPageIndex;
        Bind26Q();
    }

    protected string GetCurrentQuarter()
    {
        string re = "";
        int i = DateTime.Now.Month;
        if (i == 4 || i == 5 || i == 6)
        { re = "Q1"; }
        if (i == 7 || i == 8 || i == 9)
        { re = "Q2"; }
        if (i == 10 || i == 11 || i == 12)
        { re = "Q3"; }
        if (i == 1 || i == 2 || i == 3)
        { re = "Q4"; }
        return re;
    }



    protected void gv26Q_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
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

            Label lblother = (e.Row.FindControl("lblOther") as Label);

            double otherAmt = Convert.ToDouble(lblother.Text);

            if (otherAmt > 0)
            {
                e.Row.BackColor = System.Drawing.Color.LightYellow;
            }
        }
    }

    protected void ddlForm_SelectedIndexChanged(object sender, EventArgs e)
    {
        Bind26Q();
    }

    protected void ddltype_SelectedIndexChanged(object sender, EventArgs e)
    {
        Bind26Q();
    }

    protected void btnAddnew26Q_Click(object sender, EventArgs e)
    {
        try
        {
            string d = "";

            if (ddlForm.SelectedValue == "26Q")
            {
                d = "26Q";
            }
            else if (ddlForm.SelectedValue == "27Q(NRI)")
            {
                d = "27Q";
            }
            else if (ddlForm.SelectedValue == "27EQ(TCS)")
            {
                d = "27EQ";
            }
            else
            {
                d = "All";
            }

            Session["FromType"] = d;
            if (ddltype.SelectedIndex == 0)
            { Session["SelectedQuarter"] = GetCurrentQuarter(); }
            else
            { Session["SelectedQuarter"] = ddltype.SelectedValue; }
            Response.Redirect("ManageNonSalary_Challan.aspx", true);
        }
        catch (Exception ex)
        { ErrorException.LogError(ex); ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error); }

    }

    //Sharmila 15-12-2022 Start Here
    protected void btnGenerateTextFile_Click(object sender, EventArgs e)
    {

        Bind26Q();
        ucMessageControl.SetMessage("Verification done successfully.", MessageDisplay.DisplayStyles.Success);
        
        return;

    }


}