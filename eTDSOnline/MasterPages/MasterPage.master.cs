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
using PayrollProject;
using BusinessLayer;
using System.IO;
using System.Security.Cryptography;
using System.Text;

public partial class MasterPages_MasterPage : System.Web.UI.MasterPage
{
    CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
    BAL_Financial_Year objBAL_Financial_Year = new BAL_Financial_Year();
    int iRow1 = 0;
    int iRow2 = 0;
    int iRow3 = 0;
    int iRow4 = 0;

    private readonly DBAccess db = new DBAccess();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["companyid"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }
        if (!Page.IsPostBack)
        {
            this.BindFinancialYearCombos();

            if (Session["Financial_Year_ID"] == null)
            {
                objBAL_Financial_Year = new BAL_Financial_Year();
                objBAL_Financial_Year._Is_Current_Year = 1;
                DataSet ds = objBAL_Financial_Year.Get_Financial_Year_List();
                Session["Qtr"] = "";
                Session["frm"] = "26Q";
                if (ds.Tables[0].Rows.Count > 0)
                {
                    ddlFinancialYear.SelectedValue = ds.Tables[0].Rows[0]["Financial_Year_ID"].ToString();
                    Session["Financial_Year_ID"] = Convert.ToInt32(ddlFinancialYear.SelectedValue);
                    this.ddlFinancialYear_OnTextChanged(sender, e);
                }
            }
            else
            {
                ddlFinancialYear.SelectedValue = Session["Financial_Year_ID"].ToString();
            }

            Session["Financial_Year_Text"] = ddlFinancialYear.SelectedItem.Text;
            //this.ddlFinancialYear_OnTextChanged(sender, e);

            hdnMasterPageID.Value = ConfigurationManager.AppSettings["CompanyDashBoardMasterPageId"];
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
                    //lblrole.Text = "<div class=\"Font12px color85-85-85\" style=\"float:right;text-align:right;\">User : </div><div class=\"Font12px color85-85-85\" style=\"float:right;text-align:right;\">Admin</div>
                    lblrole_Accstat.Visible = true;
                    lblrole_Accstat.Text = "<div style=\"float:right;\">&nbsp;</div><div id=\"blink\" style=\"font-family:Verdana,Arial,Helvetica,sans-serif; color:#DE0A34; font-size:10px; font-weight:bold;float:right;text-align:right;\">" + Session["Accstat"].ToString() + "</div>";
                }
                else
                {
                    //lblrole.Text = "<div class=\"Font12px\">User :</div><div class=\"Font12px color85-85-85\" style=\"float:right;text-align:right;\">Admin</div>";
                }

                if (Session["Financial_Year_ID"] == null)
                {
                    objBAL_Financial_Year = new BAL_Financial_Year();
                    objBAL_Financial_Year._Is_Current_Year = 1;
                    DataSet ds = objBAL_Financial_Year.Get_Financial_Year_List();

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        ddlFinancialYear.SelectedValue = ds.Tables[0].Rows[0]["Financial_Year_ID"].ToString();
                        Session["Financial_Year_ID"] = Convert.ToInt32(ddlFinancialYear.SelectedValue);
                        this.ddlFinancialYear_OnTextChanged(sender, e);
                    }
                }
                else
                {
                    ddlFinancialYear.SelectedValue = Session["Financial_Year_ID"].ToString();
                }



                if (ViewState["compid"] == null)
                {
                    Response.Redirect("~/login.aspx");
                }

                cmpnylogo.Visible = true;



                if (ViewState["compid"] != null)
                {
                    lnkusrname.Text = Session["Name"].ToString();
                    ltrMaster.Text = Session["fulname1"].ToString();
                    string CompanyLogoName = Session["CompanyLogo"].ToString();

                    if (CompanyLogoName != string.Empty && CompanyLogoName != null)
                    {
                        string filePath = "";
                        filePath = Server.MapPath("~/CompanyLogo/" + CompanyLogoName);
                        FileInfo file = new FileInfo(filePath);
                        if (file.Exists)
                        {
                            cmpnylogo.Src = "~/CompanyLogo/" + CompanyLogoName;
                        }
                        file = new FileInfo(Server.MapPath(CompanyLogoName));
                        if (file.Exists)
                        {
                            cmpnylogo.Src = CompanyLogoName;
                        }
                    }


                    string pageName = Request.FilePath.Substring(Request.FilePath.LastIndexOf("/") + 1);
                    int roleid = Convert.ToInt32(Session["companyid"].ToString());
                    if (!IsPostBack)
                    {
                        CreateMainMenu(roleid);
                    }
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
            BindCompanyNameDropdown();
            ddlCompanyName.SelectedValue = Session["companyid"].ToString();
            string fy = ddlFinancialYear.SelectedItem.Text;
            string[] yr = fy.Split('_');
            int fyr = Convert.ToInt32(yr[1]);

            if (fyr > 24)
            {
                Response.Redirect("~/TDS/Regular/Dashboard.aspx");
            }
            //else
            //{
            //    Response.Redirect("../../Admin/Dashboards.aspx");
            //}
            
        }
    }
    protected void lnkusrname_Click(object sender, EventArgs e)
    {
        if (Session["companyid"] != null)
        {
            Response.Redirect("~/Admin/Dashboards.aspx?");
        }
    }

    //protected void lnklogout_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (Session["admin"] != null)
    //    {
    //        Session.Abandon();
    //        Session["admin"] = null;
    //        Response.Redirect("~/Default.aspx");
    //    }
    //    else if (Session["companyid"] != null)
    //    {
    //        Session.Abandon();
    //        Session["companyid"] = null;
    //        Response.Redirect("~/Default.aspx");
    //    }
    //    else
    //    {
    //        Response.Redirect("~/Default.aspx");
    //    }
    //}

    protected void lnklogin_Click(object sender, EventArgs e)
    {
        HttpContext.Current.Response.Cookies.Add(new HttpCookie("tdsuserInfo", ""));
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
            objBAL_Financial_Year = new BAL_Financial_Year();
            objBAL_Financial_Year.Company_ID = Convert.ToInt32(Session["companyid"].ToString());
            DataSet ds = objBAL_Financial_Year.BAL_BindFinancialYearCombos();
            ////ds = objBAL_Financial_Year.Get_Financial_Year_List();

            if (ds.Tables[0].Rows.Count > 0)
                CommonSettings.LoadCombo(ddlFinancialYear, ds.Tables[0], "Financial_Year", "Financial_Year_ID", false, "(Select Financial)");
            else
                ddlFinancialYear.Items.Add(new ListItem("2016_17", "4"));

        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex);
            throw ex;
        }
    }

    protected void ddlFinancialYear_OnTextChanged(object sender, EventArgs e)
    {
        try
        {
            if (!string.IsNullOrEmpty(ddlFinancialYear.SelectedValue))
            {
                Session["Financial_Year_ID"] = Convert.ToInt32(ddlFinancialYear.SelectedValue);
                Session["Financial_Year_Text"] = ddlFinancialYear.SelectedItem.Text;
            }

            Response.Redirect("~/Admin/Dashboards.aspx");
        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex);
            throw ex;
        }
    }

    private void CreateMainMenu(int roleid)
    {
        string subMnu = "";
        string subMnu1 = "";
        string strMenu = "<ul>";
        string submen = "Submenu";
        string subM = "";
        try
        {


            strMenu = "<ul> " +
               "<li><a href='Dashboards.aspx' >  Dashboard</a></li> " +
               "<li><a href='#' rel='Submenu1' >Non Salary</a></li> " +
               "<li><a href='#' rel='Submenu2' > Salary</a></li> " +
               //"<li><a href='#' rel='Submenu3' >Correction</a></li> " +
               "<li><a href='#' rel='Submenu4' >Utilites</a></li> " +
               "<li><a href='#' rel='Submenu5' >Traces</a></li> " +
           "</ul> " +



           "<ul id='Submenu1' class='ddsubmenustyle'>" +
                "<li><a href='Deductee_Master.aspx' >Deductee</a> </li> " +
                "<li><a href='Vouchers.aspx' >Voucher Entries </a> </li> " +
                "<li><a href='ManageNonSalary_ChallanList.aspx' >Challan Entries</a> </li> " +
                "<li><a href='EReturns_NonSalary.aspx' >eReturn</a> </li> " +
                "<li><a href='#' >Reports</a>" +
                   "<ul> " +
               /////////////////// Non salary Report
                       "<li><a href='#'>Deductee</a>" +
                           "<ul> " +
                               "<li><a href='DeducteeListReport.aspx' >Deductee List</a> </li> " +
                               "<li><a href='PANDetails.aspx' >Deductee PAN List</a> </li> " +
                               "<li><a href='DeducteeReport.aspx' >Deductee Summary</a> </li> " +
                            "</ul> " +
                        "</li>" +
                        "<li><a href='Report_tdsregister.aspx' >TDS Register</a> </li> " +

                        "<li><a href='TDSSummaryReport.aspx' >Tds Summary</a> </li> " +
                        "<li><a href='Report_ChallanDetails.aspx' >Challan Summary</a> </li> " +
                        "<li><a href='Form16A.aspx' >Form 16A</a> </li> " +
                        "<li><a href='#'>Form26Q</a>" +
                            "<ul> " +
                                "<li><a href='Report_Form26Q.aspx' >Form 26Q</a> </li> " +
                                "<li><a href='Form26Q_Annexure.aspx'>Form26Q Annexure</a> </li> " +
                             "</ul>" +
                        "</li>" +
                        "<li><a href='#'>Form27Q</a>" +
                             "<ul> " +
                                "<li><a href='Report_Form27Q.aspx'>Form 27Q</a> </li> " +
                                "<li><a href='Report_Form27Q_Annexure.aspx'>Form27Q Annexure</a> </li> " +
                             "</ul>" +
                        "</li>" +
                        "<li><a href='#' >Form 27EQ</a>" +
                            "<ul> " +
                                "<li><a href='Report_Form27EQ.aspx'>Form 27EQ</a> </li> " +
                                "<li><a href='ReportForm27EQ_Annexure.aspx'>Form 27EQ Annexure</a> </li> " +
                            "</ul> " +
                        "</li> " +
                        "<li><a href='Report_Form3CD.aspx' >Form 3CD</a> </li> " +
                        "<li><a href='#'>Manual Challan</a>" +
                            "<ul> " +
                                "<li><a href='New_Manual_Challan280.aspx' >Manual Challan 280</a> </li> " +
                                "<li><a href='NewManual_Challan.aspx' >Manual Challan</a> </li> " +
                            "</ul> " +
                        "</li> " +
                   "</ul> " +
               "</li> " + //////////// Reports
           "</ul> " + //////////////// Submenu1




           "<ul id='Submenu2' class='ddsubmenustyle'> " +
               "<li><a href='ManageEmployee_Master.aspx' >Employee</a> </li> " +
                "<li><a href='ManualProfesstionalTax.aspx' >Manual Professional Tax</a> </li> " +
                "<li><a href='ManageHRA_Rent_Receipt.aspx' >Hra Rent Reciept</a> </li> " +
                "<li><a href='ManageTdsComputation.aspx' >TDS Computation</a> </li> " +
                "<li><a href='ManageSalary_ChallanList.aspx' >Challan Entries</a> </li> " +
                "<li><a href='EReturns_Salary.aspx' >eReturn</a> </li> " +
                "<li><a href='#' >Reports</a>" +
                   "<ul> " +

                       "<li><a href='Report_tdsComputationStatement.aspx' >Computation Statement</a> </li> " +
                       "<li><a href='Report_Challan_Tax_DeductionStatement.aspx' >Tax Deduction Summary</a> </li> " +
                       "<li><a href='Report_Form16.aspx' >Form16 - Part B</a> </li> " +
                       "<li><a href='Report_Form16AA.aspx' >Form16 AA</a> </li> " +
                       "<li><a href='Report_From12BA.aspx' >Form12BA</a> </li> " +
                       "<li><a href='Report_EmployeeDetails.aspx' >Employee Profile</a> </li> " +
                       "<li><a href='Report_Employee_wiseTaxDeduction.aspx' >Employeewise Tax Deduction</a> </li> " +
                       "<li><a href='EmpPanDetails.aspx' >Employee PAN List</a> </li> " +
                       "<li><a href='ReportEmployeeDeductionDetails.aspx' >Employee Challan Details</a> </li> " +
                       "<li><a href='#'>Form 24Q</a>" +
                           "<ul> " +
                               "<li><a href='Form24Q.aspx' >Form24Q</a> </li> " +
                               "<li><a href='Report_Form24Q_Annexure.aspx' >Form24Q Annexure</a></li> " +
                           "</ul> " +
                       "</li> " +
                       "<li><a href='#'>Manual Challan</a>" +
                           "<ul> " +
                               "<li><a href='NewManual_Challan280.aspx' >Manual Challan 280</a> </li> " +
                               "<li><a href='NewManual_Challan_Salary.aspx' >Manual Challan 281</a> </li> " +
                           "</ul> " +
                       "</li> " +
                  "</ul> " +
                "</li> " + ///////////// Reports
           "</ul> " +  ///////////Submenu2

           //"<ul id='Submenu3' class='ddsubmenustyle'> " +
           //     "<li><a href='Correction/Import.aspx'>Correction Returns</a> </li> " +

           // "</ul> " +


           "<ul id='Submenu4' class='ddsubmenustyle'> " +

                "<li><a href='https://eportal.incometax.gov.in/iec/foservices/#/download-csi-file/tan-user-details' target='_blank'>Download CSI File</a> </li> " +
               "<li><a href='XL26Q.aspx' >26Q Excel Input</a> </li> " +
               "<li><a href='XL27Q.aspx' >27Q Excel Input</a> </li> " +
               "<li><a href='XL27EQ.aspx' >27EQ Excel Input</a> </li> " +
               "<li><a href='ManageCompany.aspx' >Manage Company</a> </li> " +
               "<li><a href='BulkPAN_Verification_AllVoucher.aspx' >Bulk PAN Verification Non Salary</a> </li> " +
               "<li><a href='BulkPAN_Salary.aspx' >Bulk PAN Verification Salary</a> </li> " +
                "<li><a href='#'>Masters</a>" +
                    "<ul> " +

                        "<li><a href='ManageBank_Master.aspx' >Bank</a> </li> " +
                        "<li><a href='#' >Salary Masters</a>" +
                            "<ul> " +
                                "<li><a href='ManageDepartment_Master.aspx' >Department</a> </li> " +
                                "<li><a href='ManageDesignation_Master.aspx' >Designation</a> </li> " +
                                "<li><a href='ManageBranch_Salary_Master.aspx' >Branch</a> </li> " +
                                "<li><a href='ManageIncometax_Master.aspx' >Income Tax</a> </li> " +
                                "<li><a href='ManageProfessionalTaxSlab_Master.aspx' >Professional Tax</a> </li> " +
                                "<li><a href='ManageSurcharge_Master.aspx' >Surcharge</a> </li> " +
                                "<li><a href='ManageEducationcess_Master.aspx' >Education Cess</a> </li> " +
                                "<li><a href='ManageRebate_Master.aspx' >Rebate</a> </li> " +
                                "<li><a href='ManagePF_Percentage.aspx' >Providend Fund</a> </li> " +
                                "<li><a href='Head_Name.aspx' >Heads Under Sec 10</a> </li> " +
                                "<li><a href='ManageState_Master.aspx' >State</a> </li> " +
                                "<li><a href='ManageCountry_Master.aspx' >Country</a> </li> " +
                                "<li><a href='ManageEmployee_Master.aspx' >Employee</a> </li> " +
                                "<li><a href='ManageResign_Master.aspx' >Employee Resign</a> </li> " +

                            "</ul> " +
                        "</li> " +
                        "<li><a href='#' >Non Salary Masters</a>" +
                            "<ul> " +
                                "<li><a href='ManageEducationcess_NSal_Master.aspx' >Education Cess</a> </li> " +
                                "<li><a href='ManageTds_Rate.aspx' >TDS Rate</a> </li> " +
                                "<li><a href='ManageSurcharge_NSal_Master.aspx' >Surcharge</a> </li> " +
                                "<li><a href='Deductee_Master.aspx' >Deductee</a> </li> " +

                            "</ul> " +
                        "</li> " +

                    "</ul> " +
                "</li> " + //////////////////// Masters
           "</ul> " +  ////////////////Submenu4

           //Traces Information submenu
           "<ul id='Submenu5' class='ddsubmenustyle'>" +
                       "<li><a href='TracesDetails.aspx' >Traces UserID/Password Details</a> </li> " +
                       "<li><a href='TracesRequest.aspx' >Request for TDS / Conso file Online</a> </li> " +
                       "<li><a href='TracesRequest.aspx?rt=FORM16A' >Request for Form 16A</a> </li> " +
                       "<li><a href='TracesRequest.aspx?rt=FORM16' >Request for Form 16 - Part A</a> </li> " +
                       "<li><a href='TracesRequest.aspx?rt=FORM27D' >Request for Form 27D</a> </li> " +
                       "<li><a href='TracesRequest.aspx?rt=DEFAULT'>Request for Defaults / Justification Report</a> </li> " +
                       "<li><a href='TracesDownloadReport.aspx'>Download Reports</a> </li> " +
                       "<li><a href='Traces_StatementStatus.aspx'>Statement Status</a> </li> " +
                       "<li><a href='Traces_DefaultSummary.aspx'>Default Summary</a> </li> " +
                       "<li><a href='Traces_TDS_TCS_Credit.aspx'>View TDS and TCS Credit</a> </li> " +
                       "<li><a href='197certiverfication.aspx'>Request 197A Certificate</a> </li> " +
                       "<li><a href='PANVerify.aspx' >PAN Verify</a> </li> " +
           "</ul> ";





             Session["LiteralMainMenu"] = strMenu;
            LiteralMainMenu.Text = strMenu;
        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex);
            subMnu1 = subMnu1 + " </ul>";
            strMenu = strMenu + "</ul>" + subMnu + subMnu1;
            LiteralMainMenu.Text = strMenu;
            throw ex;
        }
    }


    protected void BindCompanyNameDropdown()
    {
        BAL_CompanyHome obj = new BAL_CompanyHome();
        obj.Company_ID = Convert.ToInt32(Session["companyid"]);
        DataSet ds;
        if (Session["BindCompanyNameDropdown"] == null)
        {
            ds = obj.BindCompanyNameDropdown();
            Session["BindCompanyNameDropdown"] = ds;
        }
        else { ds = (DataSet)Session["BindCompanyNameDropdown"]; }

        if (ds.Tables[0].Rows.Count > 0)
        {
            ddlCompanyName.DataSource = ds.Tables[0];

            ddlCompanyName.DataTextField = "CompanyName";
            ddlCompanyName.DataValueField = "Company_ID";
            ddlCompanyName.DataBind();
        }
    }




    protected void ddlCompanyName_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCompanyName.SelectedValue == "0")
        {

        }
        else
        {
            Session["companyid"] = null;
            Session["companyid"] = ddlCompanyName.SelectedValue;
            Session["fulname1"] = null;
            Session["fulname1"] = ddlCompanyName.SelectedItem.Text;
            Response.Redirect("Dashboards.aspx");
        }
    }

    public DropDownList PropertyMasterDrpop
    {
        get { return ddlCompanyName; }
        set { ddlCompanyName = value; }
    }

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
    public string fdate
    {
        get { return ddlFinancialYear.SelectedItem.Text; }
        set
        {
            ddlFinancialYear.SelectedItem.Text = value;
        }
    }
}