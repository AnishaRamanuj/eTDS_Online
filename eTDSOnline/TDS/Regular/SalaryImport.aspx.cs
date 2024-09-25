using System;

public partial class BTStrp_Regular_SalaryImport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["companyid"] != null) 
        { 
            hdnCompanyid.Value = Session["companyid"].ToString();
        }
    }
}