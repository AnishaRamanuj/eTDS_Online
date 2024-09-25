using System.Web.UI.WebControls;
using BusinessLayer;
using DataLayer;
using System.Data;
using System.Drawing;
using System.Globalization;
using CommonLibrary;
using System.Diagnostics;
using System.Web.Services;
using System.Web.Script.Serialization;
using System;

public partial class Admin_TracesRequest : System.Web.UI.Page
{
    CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
    BAL_Bank_Master objBAL_Bank_Master = new BAL_Bank_Master();
    BAL_NonSalaryChallan objBAL_NonSalaryChallan = new BAL_NonSalaryChallan();
    DataSet ds;
    int result = 0;
    CultureInfo ci = new CultureInfo("en-GB");
    protected void Page_Load(object sender, EventArgs e)
    {
        {
            if (Session["companyid"] != null)
            {

                hdnCompid.Value = Session["companyid"].ToString();
                if (Session["Financial_Year_Text"] != null)
                {
                    string[] fy = Session["Financial_Year_Text"].ToString().Split('_');
                    hdnFY.Value = fy[0] ;
                }
            }
            else
            {
                Response.Redirect("~/Default.aspx");
            }


        }

    }
}