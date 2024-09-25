using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Import_Challans : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["companyid"] == null)
        { Response.Redirect("~/Default.aspx", true); }

        string Q = "";
        string F = "";


        if (!IsPostBack)
        {
            Q = Session["Qtr"].ToString();
            F = Session["frm"].ToString();
            //ddltype.SelectedValue = Q;
            //ddlForm.SelectedValue = F;
            hdnForm.Value = F;
            hdnQuarter.Value = Q;

            if (Session["Financial_Year_Text"] != null)
            {

                string[] fy = Session["Financial_Year_Text"].ToString().Split('_');
                hdnfinancialyear.Value = fy[0] + fy[1];
            }
            hdnCompanyid.Value = Session["companyid"].ToString();

 

        }
        else
        {
            //Q = ddltype.SelectedValue;
            //F = ddlForm.SelectedValue;
            Session["Qtr"] = Q;
            Session["frm"] = F;
            hdnForm.Value = F;
            hdnQuarter.Value = Q;
            hdnCompanyid.Value = Session["companyid"].ToString();


        }
    }
}