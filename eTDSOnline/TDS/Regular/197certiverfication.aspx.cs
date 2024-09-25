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

public partial class Admin_197certiverfication : System.Web.UI.Page
{
    CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
    BAL_Bank_Master objBAL_Bank_Master = new BAL_Bank_Master();
    BAL_NonSalaryChallan objBAL_NonSalaryChallan = new BAL_NonSalaryChallan();
    DataSet ds;
    int result = 0;
    CultureInfo ci = new CultureInfo("en-GB");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["companyid"] != null)
        {//
           // hdnCompanyid.Value = Session["companyid"].ToString();
        }
        else
        {
          //  Response.Redirect("~/Default.aspx");
        }
        try
        {
            if (!Page.IsPostBack)
            {

            }
        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex, hdnCompanyid.Value);
            //ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Success);
        }

    }
}