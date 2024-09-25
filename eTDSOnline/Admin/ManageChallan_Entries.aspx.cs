using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BusinessLayer;

public partial class Admin_ManageChallan_Entries : System.Web.UI.Page
{
    CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
    DataSet ds;
    BAL_QuaterSelection objBAL_QuaterSelection = new BAL_QuaterSelection();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            bindGirdGvChallanEntries();
        }

    }

    protected void bindGirdGvChallanEntries()
    {
        objBAL_QuaterSelection.CompanyID = Convert.ToInt32(Session["companyid"]);
        objBAL_QuaterSelection.StarYear = "2014";
        objBAL_QuaterSelection.EndYear = "2015";
        ds = objBAL_QuaterSelection.BAL_bindGirdGvChallanEntries();
        gvChallanEntryQuaterWise.DataSource = ds;
        gvChallanEntryQuaterWise.DataBind();
    }
    protected void gvChallanEntryQuaterWise_DataBound(object sender, EventArgs e)
    {
        double paid = 0, unpaid = 0; ;
       foreach (GridViewRow row in gvChallanEntryQuaterWise.Rows)
        {

            Button btnPaid = (Button)row.FindControl("btnPaid");
            Button btnUnpaid = (Button)row.FindControl("btnUnpaid");

            paid += Convert.ToDouble(btnPaid.Text);
            unpaid += Convert.ToDouble(btnUnpaid.Text);
        }
       Button btnFooterPaid = (Button)gvChallanEntryQuaterWise.FooterRow.FindControl("btnFooterPaid");
       Button btnFooterUnpaid = (Button)gvChallanEntryQuaterWise.FooterRow.FindControl("btnFooterUnpaid");

       btnFooterPaid.Text = paid.ToString();
       btnFooterUnpaid.Text = unpaid.ToString();

    }
}