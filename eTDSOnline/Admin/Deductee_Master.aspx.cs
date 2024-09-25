using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Deductee_Master : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                if (Session["companyid"] == null)
                {
                    Response.Redirect("~/Default.aspx");
                }
                hdnCompanyID.Value = Session["companyid"] as string;
            }
            catch (Exception)
            {
                Response.Redirect("~/Default.aspx");
            }
        }
    }
}