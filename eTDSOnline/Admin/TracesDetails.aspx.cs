using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_TracesDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["companyid"] != null)
            {

                hdnCompid.Value = Session["companyid"].ToString();
            }
            else
            {
                Response.Redirect("~/Default.aspx");
            }


        }
    }
}