using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_HRA_Calculator : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["companyid"] == null)
        { Response.Redirect("~/Login.aspx", false); }
        else
        {
            hdnCompanyid.Value = Session["companyid"].ToString();
        }
    }
}