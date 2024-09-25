using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BusinessLayer;
using System.Drawing;
using System.Globalization;
using CommonLibrary;
using DataLayer;

using Microsoft.ApplicationBlocks1.Data;

public partial class Admin_Deductions : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["companyid"] == null)
        { Response.Redirect("~/login.aspx", false); }
        else
        {
            hdnQuater.Value = "";
            hdnForm.Value = "26Q";

            if (Request.QueryString["id"] != null && Request.QueryString["id"] != "")
            {
                hdnMis.Value = Request.QueryString["id"];
            }
            else if (Request.QueryString["D"] != null && Request.QueryString["D"] != "")
            {
                var d = Request.QueryString["D"];
                string[] dd = d.Split(',');

                hdnQuater.Value = dd[1];
                hdnForm.Value = dd[0];
            }
            else
            {
                DateTime baseDate = DateTime.Today;
                var thisWeekStart = baseDate;
                int mm = Convert.ToInt16(thisWeekStart.ToString("MM"));
                if (mm >= 4 && mm <= 6)
                {
                    hdnQuater.Value = "Q1";
                }
                else if (mm >= 7 && mm <= 9)
                {
                    hdnQuater.Value = "Q2";
                }
                else if (mm >= 10 && mm <= 12)
                {
                    hdnQuater.Value = "Q3";
                }
                else if (mm >= 1 && mm <= 3)
                {
                    hdnQuater.Value = "Q4";
                }

                hdnForm.Value = "26Q";
                hdnMis.Value = "";
            }

            hdnCompanyid.Value = Session["companyid"].ToString();
            hdnDate.Value = DateTime.Now.ToString("yyyy-MM-dd").Substring(0, 10);

        }
        if (!IsPostBack)
        {
            Session["CheckRefresh"] = Server.UrlDecode(System.DateTime.Now.ToString());
            //GetDropdowns();

        }
    }
}