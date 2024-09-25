using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using CommonLibrary;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using LibCommon;
using BusinessLayer;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

public partial class MasterPages_MasterPage : System.Web.UI.MasterPage
{
    CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();

    int iRow1 = 0;
    int iRow2 = 0;
    int iRow3 = 0;
    int iRow4 = 0;

    DALCommonLib objComm = new DALCommonLib();
    CommonFunctions Comm = new CommonFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["companyid"] == null)
        {
            Response.Redirect("~/login.aspx");
        }
        if (!Page.IsPostBack)
        {
            //this.BindFinancialYearCombos();
            hdnusername.Value = Session["Name"].ToString();
            try
            {
                if (Session["companyid"] != null)
                {
                    ViewState["compid"] = Session["companyid"].ToString();
                    hdnCompid.Value = Session["companyid"].ToString();


                }
                else if (Session["staffid"] != null)
                {
                    ViewState["compid"] = Session["cltcomp"].ToString();
                }
                if (Session["Accstat"] != null && Session["Accstat"].ToString() != "Active")
                {
                    ////lblrole.Text = "<div class=\"Font12px color85-85-85\" style=\"float:right;text-align:right;\">User : </div><div class=\"Font12px color85-85-85\" style=\"float:right;text-align:right;\">Admin</div>
                    //lblrole_Accstat.Visible = true;
                    //lblrole_Accstat.Text = "<div style=\"float:right;\">&nbsp;</div><div id=\"blink\" style=\"font-family:Verdana,Arial,Helvetica,sans-serif; color:#DE0A34; font-size:10px; font-weight:bold;float:right;text-align:right;\">" + Session["Accstat"].ToString() + "</div>";
                }


                if (ViewState["compid"] == null)
                {
                    Response.Redirect("~/login.aspx");
                }

                if (ViewState["compid"] != null)
                {


                }
                else
                {
                    Response.Redirect("~/login.aspx");
                }

            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                throw ex;
            }
            //BindCompanyNameDropdown();

        }
    }


    protected void lnkusrname_Click(object sender, EventArgs e)
    {
        if (Session["companyid"] != null)
        {
            Response.Redirect("~/Regular/Dashboard.aspx?");
        }
    }

    //protected void lnklogout_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (Session["admin"] != null)
    //    {
    //        Session.Abandon();
    //        Session["admin"] = null;
    //        Response.Redirect("~/Login.aspx");
    //    }
    //    else if (Session["companyid"] != null)
    //    {
    //        Session.Abandon();
    //        Session["companyid"] = null;
    //        Response.Redirect("~/Login.aspx");
    //    }
    //    else
    //    {
    //        Response.Redirect("~/Login.aspx");
    //    }
    //}

    protected void lnklogin_Click(object sender, EventArgs e)
    {
        Session["Financial_Year_ID"] = null;
        if (Session["admin"] != null)
        {
            Session.Abandon();
            Session["admin"] = null;
            Response.Redirect("~/Login.aspx");
        }
        else if (Session["companyid"] != null)
        {
            Session.Abandon();
            Session["companyid"] = null;
            Response.Redirect("~/Login.aspx");
        }
        else
        {
            Response.Redirect("~/Login.aspx");
        }

    }
    //protected void lnkfeedback_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("~/Admin/FeedBack.aspx");
    //}


    private void BindFinancialYearCombos()
    {
        try
        {
            SqlParameter[] objSqlParameter = new SqlParameter[1];
            objSqlParameter[0] = new SqlParameter("@companyid", Session["companyid"]);
            DataSet ds = SqlHelper.ExecuteDataset(objComm._cnnString, CommandType.StoredProcedure, "bindddlfinacial_year", objSqlParameter);


        }
        catch (Exception ex)
        {
            throw ex;
        }
    }





    protected void BindCompanyNameDropdown()
    {

        DataSet ds;
        if (Session["BindCompanyNameDropdown"] == null)
        {
            //ds = obj.BindCompanyNameDropdown();
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@companyID", Session["companyid"]);
            ds = SqlHelper.ExecuteDataset(objComm._cnnString, CommandType.StoredProcedure, "usp_GetCompanyName", param);
            Session["BindCompanyNameDropdown"] = ds;
        }
        else { ds = (DataSet)Session["BindCompanyNameDropdown"]; }

        //if (ds.Tables[0].Rows.Count > 0)
        //{
        //    ddlCompanyName.DataSource = ds.Tables[0];

        //    ddlCompanyName.DataTextField = "CompanyName";
        //    ddlCompanyName.DataValueField = "Company_ID";
        //    ddlCompanyName.DataBind();
        //}
    }




    //protected void ddlCompanyName_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (ddlCompanyName.SelectedValue == "0")
    //    {

    //    }
    //    else
    //    {
    //        Session["companyid"] = null;
    //        Session["companyid"] = ddlCompanyName.SelectedValue;
    //        Session["fulname1"] = null;
    //        Session["fulname1"] = ddlCompanyName.SelectedItem.Text;
    //        Response.Redirect("Dashboards.aspx");
    //    }
    //}

    //public DropDownList PropertyMasterDrpop
    //{
    //    get { return ddlCompanyName; }
    //    set { ddlCompanyName = value; }
    //}

    private string Encrypt(string clearText)
    {
        string EncryptionKey = "MAKV2SPBNI99212";
        byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
        using (Aes encryptor = Aes.Create())
        {
            Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
            encryptor.Key = pdb.GetBytes(32);
            encryptor.IV = pdb.GetBytes(16);
            using (MemoryStream ms = new MemoryStream())
            {
                using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                {
                    cs.Write(clearBytes, 0, clearBytes.Length);
                    cs.Close();
                }
                clearText = Convert.ToBase64String(ms.ToArray());
            }
        }
        return clearText;
    }
    private string Decrypt(string cipherText)
    {
        string EncryptionKey = "MAKV2SPBNI99212";
        byte[] cipherBytes = Convert.FromBase64String(cipherText);
        using (Aes encryptor = Aes.Create())
        {
            Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
            encryptor.Key = pdb.GetBytes(32);
            encryptor.IV = pdb.GetBytes(16);
            using (MemoryStream ms = new MemoryStream())
            {
                using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                {
                    cs.Write(cipherBytes, 0, cipherBytes.Length);
                    cs.Close();
                }
                cipherText = Encoding.Unicode.GetString(ms.ToArray());
            }
        }
        return cipherText;
    }
    //public string fdate
    //{

    //    get { return ddlFinancialYear.SelectedItem.Text; }
    //    set
    //    {
    //        ddlFinancialYear.SelectedItem.Text = value;
    //    }
    //}

    //protected void btnLogout_Click(object sender, EventArgs e)
    //{
    //    Session.Abandon();
    //    Session["companyid"] = null;
    //    Response.Redirect("~/Login.aspx");
    //}



    protected void LogOut_Click(object sender, EventArgs e)
    {
        Session["companyid"] = null;
    }

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        Session["companyid"] = hdnCompid.Value;
        this.BindFinancialYearCombos();
        hdnusername.Value = Session["Name"].ToString();
        BindCompanyNameDropdown();
    }

    protected void btnyr_Click(object sender, EventArgs e)
    {
        try
        {

            Session["Financial_Year_ID"] = hdnIds.Value;
            Session["Financial_Year_Text"] = hdnYr.Value;


            string fy = hdnYr.Value;
            string[] yr = fy.Split('_');
            int fyr = Convert.ToInt32(yr[1]);

            if (fyr < 25)
            {
            //    Response.Redirect("../../TDS/Regular/Dashboard.aspx");
            //}
            //else
            //{
                Response.Redirect("../../Admin/Dashboards.aspx");
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
}