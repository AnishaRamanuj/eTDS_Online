using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLayer;
using System.Data;
using System.Drawing;
using PANVrf;

public partial class Admin_BulkPAN_Verification_AllVoucher : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        string Q = "";
        string F = "";
        if (Session["companyid"] == null)
        { Response.Redirect("~/Default.aspx", false); }
        
        if (!IsPostBack)
        {
            hdnCompanyID.Value = Session["companyid"].ToString();
            hdnValid.Value = "Non";
            Q = Session["Qtr"].ToString();
            F = Session["frm"].ToString();
 
            hdnForm.Value = F;
            hdnQuater.Value = Q;
        }
        else
        {
            Q = ddlQuater.SelectedValue;
            F = ddlFromType.SelectedValue;
            Session["Qtr"] = Q;
            Session["frm"] = F;
            hdnForm.Value = F;
            hdnQuater.Value = Q;
            hdnCompanyID.Value = Session["companyid"].ToString();
        }
    }







}