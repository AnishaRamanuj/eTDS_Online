using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLayer;
using DataLayer;
using System.Data;
using System.Drawing;
using Microsoft.ApplicationBlocks1.Data;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using CommonLibrary;
using System.Globalization;
using System.IO;
using System.Data.SqlClient;
using System.Configuration;
using System.Data.OleDb;

namespace Forms
{
    public partial class _ManageChallan_Salary : System.Web.UI.Page
    {
        CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
        BAL_Bank_Master objBAL_Bank_Master = new BAL_Bank_Master();
        BAL_Employee_Master objBAL_Employee_Master = new BAL_Employee_Master();
        BAL_Challan objBAL_Challan = new BAL_Challan();
        BAL_Challan_Breakup objBAL_Challan_Breakup = new BAL_Challan_Breakup();
        double calTotoalDeposite = 0;
        int result = 0;
        string xlErr = "";
        string[] CheckedEmployeeFromdgEmployeearray;
        protected void Page_Load(object sender, EventArgs e)
        {


            if (!Page.IsPostBack)
            {
                try
                {
                    if (Session["companyid"] == null)
                    {
                        Response.Redirect("~/Default.aspx");
                    }
                    hdnCompanyID.Value = Session["companyid"] as string;
                    hdnfinYear.Value = Session["Financial_Year_Text"].ToString();
                }
                catch (Exception)
                {
                    Response.Redirect("~/Default.aspx");
                }


                /////div for Add New Employee When Edit
                divShowaddEmployee.Visible = false;
                /////set date for challan
                txtDateOfAmount.Text = CommonSettings.ConvertToCulturedDateTime(DateTime.Now.Date).ToString("dd/MM/yyyy");
                //txtDateOfTaxDed.Text = CommonSettings.ConvertToCulturedDateTime(DateTime.Now.Date).ToString("dd/MM/yyyy");
                txtChallanDate.Text = CommonSettings.ConvertToCulturedDateTime(DateTime.Now.Date).ToString("dd/MM/yyyy");
                ////////text box read only
                txtBranch_Code.Attributes.Add("readonly", "readonly");
                txtDateOfAmount.Attributes.Add("readonly", "readonly");
                //txtDateOfTaxDed.Attributes.Add("readonly", "readonly");
                txtTotal.Attributes.Add("readonly", "readonly");
                btnSave.Visible = false; btnCancel.Visible = false;
                //////page salarychallanlist selected quater then set it's value on this page 
                /////Session["Salary24QQuarter"] created on page Admin/ManageSalary_ChallanList.aspx click on edit or add new
                if (Session["Salary24QQuarter"] != null)
                {
                    ddl_Quater.SelectedValue = Session["Salary24QQuarter"].ToString();
                }

                /////if challn is in edit mode 
                /////Session["SalaryChallanID"] created on page Admin/ManageSalary_ChallanList.aspx click on edit
                if (Session["SalaryChallanID"] != null && Session["SalaryChallanID"].ToString() != "")
                {
                    string CID = Session["SalaryChallanID"].ToString();
                    Session["SalaryChallanID"] = null;
                    if (CID != "" && CID != string.Empty && CID != null)
                    {
                        /////set Challan ID
                        hdnChallan_ID.Value = CID;
                        ////Bind Challan On Edit mode
                        EditMode(CID);
                        tbl_Data.Visible = true; tbl_Start.Visible = false;
                    }
                }
                else { this.BindBankCombos(); }
            }

            Session["companyid"] = hdnCompanyID.Value;

            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "checkalldsfasdfasdf", " $(document).ready(function () {MakeFixedTableFooter();  }); ", true);
        }

        #region Methods

        private void BindEmployeeGrid()
        {
            try
            {
                objBAL_Employee_Master._Company_ID = int.Parse(hdnCompanyID.Value);
                objBAL_Employee_Master._Challan_Date = CommonSettings.ConvertToCulturedDateTime(txtDateOfAmount.Text);
                //if (ddlChallan.SelectedValue == "Monthly")
                //{
                objBAL_Employee_Master._Bank_Name = objBAL_Employee_Master._Challan_Date.Month.ToString();
                //}
                //else if (ddlChallan.SelectedValue == "Monthly")
                //{  }
                DataSet ds = objBAL_Employee_Master.Get_Employee_Master_Challan_List();
                DataTable dtpass = ds.Tables[0];
                var grosssalary = ds.Tables[0].Select("GrossSalary <> 0");
                if (grosssalary.Length > 0)
                {
                    dtpass = grosssalary.CopyToDataTable();

                    dtpass.DefaultView.Sort = ("FirstName ASC"); //dtpass.Select("").CopyToDataTable();
                }
                int month = objBAL_Employee_Master._Challan_Date.Month;
                int year = objBAL_Employee_Master._Challan_Date.Year;

                DataTable dd= null;

                if (chkShowOnlyTaxableEmployees.Checked)
                {
                    //for (int i = ds.Tables[0].Rows.Count - 1; i >= 0; i--)
                    //{
                    //    if (ds.Tables[0].Rows[i]["GrossSalary"].ToString() == "0")
                    //        ds.Tables[0].Rows[i].Delete();
                    //}
                    //ds.Tables[0].AcceptChanges();
                    var result = ds.Tables[0].Select("GrossSalary > 250000");
                    if (result.Length > 0)
                    {
                        dd = result.CopyToDataTable();
                    }
                    else
                    {
                        chkShowOnlyTaxableEmployees.Checked = false;
                        dd = dtpass;
                    }
                }
                else
                {
                    dd = dtpass;
                }

                var newres = dd.Select("Resign = 0");
                if (newres.Length > 0)
                { dd = newres.CopyToDataTable(); }

                dd.DefaultView.Sort = "firstname asc";
                dd = dd.DefaultView.ToTable();
                dgEmployee.DataSource = dd;

                ViewState["EmpTable"] = dd;
                dgEmployee.DataBind();
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        private void BindBankCombos()
        {
            objBAL_Bank_Master._Company_ID = int.Parse(hdnCompanyID.Value);
            DataSet ds = objBAL_Bank_Master.Get_Bank_Master_List();
            CommonSettings.LoadCombo(ddlBank, ds.Tables[0], "Bank_Branch_Name", "Bsrcode", true, "(Select Bank)");
        }

        #endregion

        #region Events

        protected void btnGetChallanList_OnClick(object sender, EventArgs e)
        {
            try
            {
                if (hdnChallan_ID.Value != "" && hdnChallan_ID.Value != string.Empty && hdnChallan_ID.Value != null)
                {
                    string message = "alert('Cant Create This Challan , Only Edit This Challan !........')";
                    ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "alert", message, true);
                }
                else
                {
                    this.BindEmployeeGrid();
                    //lblHeaer.Text = lblHeaer.Text + ": Quarter :" + ddl_Quater.SelectedValue;
                    tbl_Data.Visible = true; tbl_Start.Visible = false; btnCancel0.Visible = false;
                    btnSave.Visible = true; btnCancel.Visible = true;
                }
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        #region Check Selected Date Quater
        protected string CheckQuater(DateTime dt)
        {
            string type = "";

            String sDate = dt.ToString();
            DateTime datevalue = (Convert.ToDateTime(sDate.ToString()));

            int mn = datevalue.Month;

            if (mn == 1 || mn == 2 || mn == 3)
                type = "Q4";

            if (mn == 4 || mn == 5 || mn == 6)
                type = "Q1";

            if (mn == 7 || mn == 8 || mn == 9)
                type = "Q2";

            if (mn == 10 || mn == 11 || mn == 12)
                type = "Q3";

            return type;
        }
        #endregion

        protected void btnSave_OnClick(object sender, EventArgs e)
        {
            try
            {
                if (Session["companyid"] == null)
                {
                    Response.Redirect("~/Default.aspx");
                }


                if (hdnError.Value == "")
                {
                    btnSave.Enabled = false;
                    DataTable dt = new DataTable();
                    dt.Columns.Add("_Employee_ID").DataType = typeof(Int32);
                    dt.Columns.Add("_Employee_Salary").DataType = typeof(double);
                    dt.Columns.Add("_Deduction_Type").DataType = typeof(string);
                    dt.Columns.Add("_PAN_No").DataType = typeof(string);
                    dt.Columns.Add("_Quater").DataType = typeof(string);
                    dt.Columns.Add("_TDS_Amount").DataType = typeof(double);
                    dt.Columns.Add("_Surcharge_Amount").DataType = typeof(double);
                    dt.Columns.Add("_EducationCess_Amount").DataType = typeof(double);
                    dt.Columns.Add("_High_EductionCess_Amount").DataType = typeof(double);
                    dt.Columns.Add("_Total_TDS_Amount").DataType = typeof(double);
                    dt.Columns.Add("_Salary_Date").DataType = typeof(DateTime);
                    dt.Columns.Add("_Tds_Deduction_Date").DataType = typeof(DateTime);
                    dt.Columns.Add("_PAN_Verified").DataType = typeof(Boolean);
                    dt.Columns.Add("CertNo").DataType = typeof(string);
                    DataRow dr;

                    objBAL_Challan._Company_ID = int.Parse(hdnCompanyID.Value);
                    objBAL_Challan._Challan_Date = CommonSettings.ConvertToCulturedDateTime(txtChallanDate.Text);

                    if (ddlBank.SelectedIndex > 0)
                    {
                        objBAL_Challan._Bank_ID = Convert.ToInt32(ddlBank.SelectedValue);
                    }
                    else
                    {
                        string message = "alert('Select Bank against challan !')";
                        ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "alerrt", message, true);
                        return;
                    }
                    string chl = txtChallanNo.Text;
                    //if ((chl.Length) < 5)
                    //{
                    //    string message = "alert('Challan no cannot be less than 5 digit ')";
                    //    ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "alerrt", message, true);
                    //    return;
                    //}
                     
                    string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
                    string ST = "04/01/" + financialyear[0];
                    string ED = "03/31/20" + financialyear[1];
                    //var _ChDate =  new DateTime(1900, 1, 1);
                    //var info = new CultureInfo("en-US", false);
                    //String _dateFormat = "dd/MM/yyyy";
                    //string ch = txtChallanDate.Text; 
                    //if (ch.Trim() != "" && !DateTime.TryParseExact(ch.Trim(), _dateFormat, info, DateTimeStyles.AllowWhiteSpaces, out _ChDate))
                    //{
                    //}
                    //DateTime ch = Convert.ToDateTime(txtChallanDate.Text);
                    DateTime CST = Convert.ToDateTime(ST);

                    string bsr = "";
                    bsr = txtBranch_Code.Text;
                    if (bsr == "")
                    {
                        string message = "alert('BSR Code cannot be blank ')";
                        ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "alerrt", message, true);
                        return;
                    }

                    
                    if (bsr.Length != 7)
                    {
                        ucMessageControl.SetMessage("Bsrcode should be 7 digit", MessageDisplay.DisplayStyles.Error);
                        return;
                    }

                    objBAL_Challan._Bank_Bsrcode = txtBranch_Code.Text;
                    //string type = CheckQuater(CommonSettings.ConvertToCulturedDateTime(txtDateOfAmount.Text));
                    //objBAL_Challan._Quater = ddl_Quater.SelectedValue;
                    
                    objBAL_Challan._Quater = hdnQuarter.Value;
                    //objBAL_Challan.ChallanType = ddlChallan.SelectedValue;

                    if (!string.IsNullOrEmpty(txtTDSAmount.Text))
                    {
                        objBAL_Challan._TDS_Amount = Convert.ToDouble(txtTDSAmount.Text);
                    }
                    else
                    {
                        string message = "alert('TDS Amount cannot be Zero/blank ')";
                        ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "alerrt", message, true);
                        return;
                    }
                    if (!string.IsNullOrEmpty(txt_Surcharge.Text))
                       objBAL_Challan._Surcharge = Convert.ToDouble(txt_Surcharge.Text);

                    if (!string.IsNullOrEmpty(txtEducationCess.Text))
                        objBAL_Challan._Education_Cess = Convert.ToDouble(txtEducationCess.Text);

                    if (!string.IsNullOrEmpty(txtHECess.Text))
                        objBAL_Challan._High_Education_Cess = Convert.ToDouble(txtHECess.Text);

                    if (!string.IsNullOrEmpty(txtInterest.Text))
                        objBAL_Challan._Interest_Amt = Convert.ToDouble(txtInterest.Text);

                    if (!string.IsNullOrEmpty(txtFees.Text))
                        objBAL_Challan._Fees_Amount = Convert.ToDouble(txtFees.Text);

                    if (!string.IsNullOrEmpty(txtOthers.Text))
                        objBAL_Challan._Others_Amount = Convert.ToDouble(txtOthers.Text);

                    if (!string.IsNullOrEmpty(txtTotal.Text))
                        objBAL_Challan._Challan_Amount = Convert.ToDouble(txtTotal.Text);

                    if (txtChallanNo.Text != "")
                    {
                        objBAL_Challan._Challan_No = txtChallanNo.Text;
                    }
                    else
                    {
                        string message = "alert('Challan No cannot be Zero/blank ')";
                        ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "alerrt", message, true);
                        return;
                    }
                    //objBAL_Challan._Trans_No = _Trans_No;
                    //objBAL_Challan._C_Entry = _C_Entry;

                    //if (rdoYes.Checked)
                    //    objBAL_Challan._Nil_Challan = true;
                    //else
                        objBAL_Challan._Nil_Challan = false;

                    bool isTrue = true, isAmountGreater = true;

                    //if (ds.Tables[0].Rows.Count > 0)
                    //    Challan_ID = Convert.ToInt32(ds.Tables[0].Rows[0][0]);
                    //else
                    //throw new Exception("Error occured while save challan");

                    //if (rdoNo.Checked)
                    //{
                        calTotoalDeposite = 0;
                        foreach (GridViewRow item in dgEmployee.Rows)
                        {
                            HiddenField hdnEmployeeID = (HiddenField)item.FindControl("hdnEmployeeID");
                            TextBox txtAmount = (TextBox)item.FindControl("txtAmount");
                            Label lblPanNo = (Label)item.FindControl("lblPanNo");
                            CheckBox chkValidPan = (CheckBox)item.FindControl("chkValidPan");
                            CheckBox chkChechked = (CheckBox)item.FindControl("chkRow");
                            DropDownList ddlRType = (DropDownList)item.FindControl("ddlRType");
                            TextBox txtTds = (TextBox)item.FindControl("txtTds");
                            TextBox txtSur = (TextBox)item.FindControl("txtSur");
                            TextBox txtECess = (TextBox)item.FindControl("txtECess");
                            TextBox txtHCess = (TextBox)item.FindControl("txtHCess");
                            TextBox txtTotalTax = (TextBox)item.FindControl("txtTotalTax");
                            TextBox txtTotalDepo = (TextBox)item.FindControl("txtTotalDepo");
                            TextBox txtCertNo = (TextBox)item.FindControl("txtCertNo");

                            if (chkChechked.Checked)
                            {
                                if (Convert.ToDouble(txtAmount.Text) == 0)
                                {
                                    isTrue = false;
                                    string message = "alert('Salary Amount cannot be Zero')";
                                    ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "alerte", message, true);

                                    return;
                                }
                                else
                                {

                                    txtTds.Attributes.Remove("readonly");
                                txtSur.Attributes.Remove("readonly");
                                txtECess.Attributes.Remove("readonly");
                                txtHCess.Attributes.Remove("readonly");
                                txtAmount.Attributes.Remove("readonly");
                                txtCertNo.Attributes.Remove("readonly");
                                calTotoalDeposite += Convert.ToDouble(txtTotalDepo.Text);
                                dr = dt.NewRow();
                                dr["_Employee_ID"] = Convert.ToInt32(hdnEmployeeID.Value);
                                dr["_Employee_Salary"] = Convert.ToDouble(txtAmount.Text);
                                dr["_Deduction_Type"] = ddlRType.SelectedValue;
                                dr["_PAN_No"] = lblPanNo.Text;
                                dr["_Quater"] = "Monthly";
                                dr["_TDS_Amount"] = Convert.ToDouble(txtTds.Text);
                                dr["_Surcharge_Amount"] = Convert.ToDouble(txtSur.Text);
                                dr["_EducationCess_Amount"] = Convert.ToDouble(txtECess.Text);
                                dr["_High_EductionCess_Amount"] = Convert.ToDouble(txtHCess.Text);
                                dr["_Total_TDS_Amount"] = Convert.ToDouble(txtTotalTax.Text);
                                dr["_Salary_Date"] = CommonSettings.ConvertToCulturedDateTime(txtDateOfAmount.Text);
                                dr["_Tds_Deduction_Date"] = CommonSettings.ConvertToCulturedDateTime(txtDateOfAmount.Text);
                                dr["_PAN_Verified"] = chkValidPan.Checked;
                                dr["CertNo"] = txtCertNo.Text;
                                dt.Rows.Add(dr);
                                double sal = Convert.ToDouble(txtAmount.Text);
                                double tds = Convert.ToDouble(txtTds.Text);
                                if (sal < tds)
                                {
                                    isAmountGreater = false;
                                }

                                if (lblPanNo.Text == "PANNOTAVBL")
                                {
                                    double cal = (sal * 20) / 100;
                                    if (tds < cal)
                                    {
                                        isTrue = false;
                                    }
                                    if (tds == cal)
                                    { isTrue = true; }
                                }
                                // ds = objBAL_Challan_Breakup.Insert_Challan_Breakup();

                            }

                            }
                        }
                        txtTotalDepoAmount.Text = calTotoalDeposite.ToString();
                    //}
                    if (isAmountGreater)
                    {
                        if (isTrue)
                        {
                            objBAL_Challan.ChallanDatatable = dt;
                            result = objBAL_Challan.Insert_Challan();
                            if (result > 0)
                            {
                                string message = "alert('Challan has been saved successfull.')";
                                ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "alerte", message, true);
                                if (hdnChallan_ID.Value != "" && hdnChallan_ID.Value != string.Empty && hdnChallan_ID.Value != null)
                                {// Incase of Update, New challan is inserted and old challan is deleted.
                                    objBAL_Challan._Challan_ID = Convert.ToInt32(hdnChallan_ID.Value);
                                    result = objBAL_Challan.BAL_DeleteChallanOld();
                                }
                                Response.Redirect("ManageSalary_ChallanList.aspx", false);
                            }
                            else
                                ucMessageControl.SetMessage("Error occured while save challan", MessageDisplay.DisplayStyles.Error);
                        }
                        else
                        {
                            string message = "alert('Please Check Employee PAN Number is PANNOTAVBL then TDS Deducted By 20% From Salary !')";
                            ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "alerrt", message, true);
                        }
                    }
                    else
                    {
                        string message = "alert('Tds Amount Cannot Be Greater Than Salary Amount !')";
                        ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "alerrt", message, true);
                    }
                    btnSave.Enabled = true;
                }
                else
                {
                    ucMessageControl.SetMessage("Salary Challan Cannot be Nil ", MessageDisplay.DisplayStyles.Error);
                    btnSave.Enabled = true;
                }
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        #endregion
        protected void dgEmployee_DataBound(object sender, EventArgs e)
        {
            try
            {
                //if (Session["CheckedEmployeeFromdgEmployee"] != null)
                //{
                //    CheckedEmployeeFromdgEmployeearray = Session["CheckedEmployeeFromdgEmployee"].ToString().Split(',');
                //}
                List<string> EmployeeChecked = null;
                if (CheckedEmployeeFromdgEmployeearray != null)
                {
                    EmployeeChecked = CheckedEmployeeFromdgEmployeearray.ToList();
                }
                calTotoalDeposite = 0;
                foreach (GridViewRow row in dgEmployee.Rows)
                {
                    TextBox txtTotalDepo = (TextBox)row.FindControl("txtTotalDepo");
                    if (txtTotalDepo.Text != "")
                    {
                        calTotoalDeposite += Convert.ToDouble(txtTotalDepo.Text);
                        HiddenField hdnEmployeeID = (HiddenField)row.FindControl("hdnEmployeeID");
                        TextBox txtTds = (TextBox)row.FindControl("txtTds");
                        TextBox txtSur = (TextBox)row.FindControl("txtSur");
                        TextBox txtECess = (TextBox)row.FindControl("txtECess");
                        TextBox txtHCess = (TextBox)row.FindControl("txtHCess");
                        TextBox txtTotalTax = (TextBox)row.FindControl("txtTotalTax");
                        TextBox txtAmount = (TextBox)row.FindControl("txtAmount");
                        TextBox txtCertNo = (TextBox)row.FindControl("txtCertNo");
                        CheckBox chkChechked = (CheckBox)row.FindControl("chkRow");

                        row.Cells[2].Text = row.Cells[2].Text.ToUpper();

                        txtTds.Attributes.Add("readonly", "readonly");
                        txtSur.Attributes.Add("readonly", "readonly");
                        txtECess.Attributes.Add("readonly", "readonly");
                        txtHCess.Attributes.Add("readonly", "readonly");
                        txtTotalTax.Attributes.Add("readonly", "readonly");
                        txtTotalDepo.Attributes.Add("readonly", "readonly");
                        txtAmount.Attributes.Add("readonly", "readonly");
                        txtCertNo.Attributes.Add("readonly", "readonly");

                        string CID = Convert.ToString(hdnChallan_ID.Value);
                        if (CID != "" && CID != string.Empty && CID != null)
                        {
                            if (CheckedEmployeeFromdgEmployeearray != null)
                            {
                                for (int i = 0; i < EmployeeChecked.Count; i++)
                                {
                                    if (EmployeeChecked[i].ToString() == hdnEmployeeID.Value)
                                    {
                                        chkChechked.Checked = true;
                                        EmployeeChecked.RemoveAt(i);
                                    }
                                    else { chkChechked.Checked = false; }
                                }
                            }
                            else { chkChechked.Checked = true; }

                            if (chkChechked.Checked)
                            {
                                DropDownList ddlRType = (DropDownList)row.FindControl("ddlRType");
                                HiddenField hdnDeduction_Type = (HiddenField)row.FindControl("hdnDeduction_Type");
                                ddlRType.SelectedValue = hdnDeduction_Type.Value;
                                txtTds.Attributes.Remove("readonly");
                                txtSur.Attributes.Remove("readonly");
                                txtECess.Attributes.Remove("readonly");
                                txtHCess.Attributes.Remove("readonly");
                                txtTotalTax.Attributes.Remove("readonly");
                                txtTotalDepo.Attributes.Remove("readonly");
                                txtAmount.Attributes.Remove("readonly");
                                txtCertNo.Attributes.Remove("readonly");
                            }
                        }
                        hdnRowsOfGrid.Value = dgEmployee.Rows.Count.ToString();
                    }
                    txtTotalDepoAmount.Text = calTotoalDeposite.ToString();

                    if (Session["SalaryChallanID"] != null)
                    {
                        string CcID = Session["SalaryChallanID"].ToString();
                        if (CcID != "" && CcID != string.Empty && CcID != null)
                        {
                            CheckBox chkHeader = (CheckBox)dgEmployee.HeaderRow.FindControl("chkHeader");
                            chkHeader.Checked = true;
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }


        protected void EditMode(string ID)
        {
            try
            {
                objBAL_Challan._Company_ID = Convert.ToInt32(hdnCompanyID.Value);
                objBAL_Challan._Challan_ID = Convert.ToInt32(ID);
                DataSet ds = objBAL_Challan.BAl_EditMode();

                chkShowOnlyTaxableEmployees.Visible = false;
                //divImpExp.Visible = false;
                btnCancel0.Visible = false;
                btnSave.Visible = true; btnCancel.Visible = true;
                if (ds.Tables[0].Rows.Count > 0)
                {
                    ddl_Quater.SelectedValue = ds.Tables[0].Rows[0]["Quater"].ToString();
                    divShowaddEmployee.Visible = true;
                    lblHeaer.Text = lblHeaer.Text + ": Quarter :" + ddl_Quater.SelectedValue;
                    CommonSettings.LoadCombo(ddlBank, ds.Tables[2], "Bank_Branch_Name", "Bsrcode", true, "(Select Bank)");
                    ddlBank.SelectedValue = ds.Tables[0].Rows[0]["Bank_Bsrcode"].ToString();
                    txtBranch_Code.Text = ds.Tables[0].Rows[0]["Bank_Bsrcode"].ToString();
                    txtTDSAmount.Text = ds.Tables[0].Rows[0]["TDS_Amount"].ToString();
                    txt_Surcharge.Text = ds.Tables[0].Rows[0]["Surcharge"].ToString();
                    txtEducationCess.Text = ds.Tables[0].Rows[0]["Education_Cess"].ToString();
                    txtHECess.Text = ds.Tables[0].Rows[0]["High_Education_Cess"].ToString();
                    txtInterest.Text = ds.Tables[0].Rows[0]["Interest_Amt"].ToString();
                    txtFees.Text = ds.Tables[0].Rows[0]["Fees_Amount"].ToString();
                    txtOthers.Text = ds.Tables[0].Rows[0]["Others_Amount"].ToString();
                    txtTotal.Text = ds.Tables[0].Rows[0]["Challan_Amount"].ToString();
                    txtChallanNo.Text = ds.Tables[0].Rows[0]["Challan_No"].ToString();
                    string s = (ds.Tables[0].Rows[0]["Nil_Challan"].ToString());
                    //if (s == "false")
                        //rdoNo.Checked = true;
                    //else
                    //    rdoYes.Checked = true;
                    //ddlChallan.SelectedValue = ds.Tables[0].Rows[0]["Challan_Type"].ToString();
                    txtChallanDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["Challan_Date"]).ToString("dd/MM/yyyy");
                }
                if (ds.Tables[1].Rows.Count > 0)
                {
                    dgEmployee.DataSource = ds.Tables[1];
                    dgEmployee.DataBind();
                    DataTable dtpass = ds.Tables[1].Clone();
                    
                    var grosssalary = ds.Tables[1].Select();
                    if (grosssalary.Length > 0)
                    {
                        dtpass = grosssalary.CopyToDataTable();

                        dtpass.DefaultView.Sort = ("FirstName ASC"); 
                        ViewState["EmpTable"] = dtpass;
                    }
                }
                DataTable dtNotAddedEmployee = ds.Tables[3];
                var result = ds.Tables[3].Select("Resign = 0");
                if (result.Length > 0)
                {
                    dtNotAddedEmployee = result.CopyToDataTable();
                }

                gvAddEmployeeGrid.DataSource = dtNotAddedEmployee;
                gvAddEmployeeGrid.DataBind();

                ddl_month.SelectedValue = ds.Tables[5].Rows[0][0].ToString();
                if (ds.Tables[4].Rows.Count > 0)
                {
                    string dd = ds.Tables[4].Rows[0][0].ToString() ;
                    if (dd != "")
                    {
                        txtDateOfAmount.Text = Convert.ToDateTime(ds.Tables[4].Rows[0][0]).ToString("dd/MM/yyyy");
                    }
                }

                //txtDateOfTaxDed.Text = Convert.ToDateTime(ds.Tables[4].Rows[0][0]).ToString("dd/MM/yyyy");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "checkall", " $(document).ready(function () { $('[id*=chkHeader]').attr('checked', 'checked'); $('[id*=chkHeaderAddEmp]').removeAttr('checked');}); ", true);
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }

        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageSalary_ChallanList.aspx", true);
        }
        protected void chkShowOnlyTaxableEmployees_CheckedChanged(object sender, EventArgs e)
        {
            string CID = hdnChallan_ID.Value;
            if (CID == "" || CID == string.Empty || CID == null)
            {
                this.BindEmployeeGrid();
            }
        }
        protected void btnfromserverAddEmployee_Click(object sender, EventArgs e)
        {
            try
            {
                if (gvAddEmployeeGrid.Rows.Count > 0)
                {
                    string FirstName = "", CDate = "";
                    DataTable dtdgEmployee = CreateTable();
                    DataTable dtgvAddEmployeeGrid = CreateTable();
                    DataRow drdgEmployee;
                    string CheckedEmployeeFromdgEmployee = "";
                    foreach (GridViewRow row in dgEmployee.Rows)
                    {
                        drdgEmployee = dtdgEmployee.NewRow();
                        CheckBox chkRow = (CheckBox)row.FindControl("chkRow");
                        HiddenField hdnEmployeeID = (HiddenField)row.FindControl("hdnEmployeeID");
                        FirstName = row.Cells[2].Text;
                        TextBox txtAmount = (TextBox)row.FindControl("txtAmount");
                        CDate = row.Cells[4].Text;
                        Label lblPanNo = (Label)row.FindControl("lblPanNo");
                        CheckBox chkValidPan = (CheckBox)row.FindControl("chkValidPan");
                        TextBox txtTds = (TextBox)row.FindControl("txtTds");
                        TextBox txtSur = (TextBox)row.FindControl("txtSur");
                        TextBox txtECess = (TextBox)row.FindControl("txtECess");
                        TextBox txtHCess = (TextBox)row.FindControl("txtHCess");
                        TextBox txtTotalTax = (TextBox)row.FindControl("txtTotalTax");
                        TextBox txtTotalDepo = (TextBox)row.FindControl("txtTotalDepo");
                        DropDownList ddlRType = (DropDownList)row.FindControl("ddlRType");
                        TextBox txtCertNo = (TextBox)row.FindControl("txtCertNo");

                        if (chkRow.Checked)
                        {
                            CheckedEmployeeFromdgEmployee = hdnEmployeeID.Value + "," + CheckedEmployeeFromdgEmployee;
                        }

                        drdgEmployee["Employee_ID"] = hdnEmployeeID.Value;
                        drdgEmployee["FirstName"] = FirstName;
                        drdgEmployee["PAN_NO"] = lblPanNo.Text;
                        drdgEmployee["CDate"] = CDate;
                        drdgEmployee["Amount"] = txtAmount.Text;
                        drdgEmployee["PanVerified"] = (chkValidPan.Checked ? "Valid_PAN" : "InValid_PAN");
                        drdgEmployee["TDS_Amount"] = txtTds.Text;
                        drdgEmployee["Surcharge_Amount"] = txtSur.Text;
                        drdgEmployee["EducationCess_Amount"] = txtECess.Text;
                        drdgEmployee["High_EductionCess_Amount"] = txtHCess.Text;
                        drdgEmployee["Total_TDS_Amount"] = txtTotalDepo.Text;
                        drdgEmployee["Deduction_Type"] = ddlRType.SelectedValue;
                        drdgEmployee["CertNo"] = txtCertNo.Text;
                        dtdgEmployee.Rows.Add(drdgEmployee);
                    }
                    CheckedEmployeeFromdgEmployee = CheckedEmployeeFromdgEmployee.TrimEnd(',');
                    CheckedEmployeeFromdgEmployeearray = CheckedEmployeeFromdgEmployee.Split(',');

                    foreach (GridViewRow row in gvAddEmployeeGrid.Rows)
                    {
                        CheckBox chkRowAddEmp = (CheckBox)row.FindControl("chkRowAddEmp");
                        HiddenField hdnEmployeeID = (HiddenField)row.FindControl("hdnEmployeeID");
                        FirstName = row.Cells[2].Text;
                        Label lblAmount = (Label)row.FindControl("lblAmount");
                        CDate = row.Cells[4].Text;
                        Label lblPanNo = (Label)row.FindControl("lblPanNo");
                        CheckBox chkValidPan = (CheckBox)row.FindControl("chkValidPan");
                        Label lblTDS = (Label)row.FindControl("lblTDS");
                        Label lblsur = (Label)row.FindControl("lblsur");
                        Label lblECess = (Label)row.FindControl("lblECess");
                        Label lblHcess = (Label)row.FindControl("lblHcess");
                        Label lbltotalTax = (Label)row.FindControl("lbltotalTax");
                        Label lblTotalDepo = (Label)row.FindControl("lblTotalDepo");
                        Label lblrType = (Label)row.FindControl("lblrType");
                        Label lblCertno = (Label)row.FindControl("lblCertno");

                        if (chkRowAddEmp.Checked)
                        {
                            drdgEmployee = dtdgEmployee.NewRow();
                            drdgEmployee["Employee_ID"] = hdnEmployeeID.Value;
                            drdgEmployee["FirstName"] = FirstName;
                            drdgEmployee["PAN_NO"] = lblPanNo.Text;
                            drdgEmployee["CDate"] = CDate;
                            drdgEmployee["Amount"] = lblAmount.Text;
                            drdgEmployee["PanVerified"] = (chkValidPan.Checked ? "Valid_PAN" : "InValid_PAN");
                            drdgEmployee["TDS_Amount"] = lblTDS.Text;
                            drdgEmployee["Surcharge_Amount"] = lblsur.Text;
                            drdgEmployee["EducationCess_Amount"] = lblECess.Text;
                            drdgEmployee["High_EductionCess_Amount"] = lblHcess.Text;
                            drdgEmployee["Total_TDS_Amount"] = lblTotalDepo.Text;
                            drdgEmployee["Deduction_Type"] = lblrType.Text;
                            drdgEmployee["CertNo"] = lblCertno.Text;
                            dtdgEmployee.Rows.Add(drdgEmployee);
                        }
                        else
                        {
                            drdgEmployee = dtgvAddEmployeeGrid.NewRow();
                            drdgEmployee["Employee_ID"] = hdnEmployeeID.Value;
                            drdgEmployee["FirstName"] = FirstName;
                            drdgEmployee["PAN_NO"] = lblPanNo.Text;
                            drdgEmployee["CDate"] = CDate;
                            drdgEmployee["Amount"] = lblAmount.Text;
                            drdgEmployee["PanVerified"] = (chkValidPan.Checked ? "Valid_PAN" : "InValid_PAN");
                            drdgEmployee["TDS_Amount"] = lblTDS.Text;
                            drdgEmployee["Surcharge_Amount"] = lblsur.Text;
                            drdgEmployee["EducationCess_Amount"] = lblECess.Text;
                            drdgEmployee["High_EductionCess_Amount"] = lblHcess.Text;
                            drdgEmployee["Total_TDS_Amount"] = lblTotalDepo.Text;
                            drdgEmployee["Deduction_Type"] = lblrType.Text;
                            drdgEmployee["CertNo"] = lblCertno.Text;
                            dtgvAddEmployeeGrid.Rows.Add(drdgEmployee);
                        }
                    }
                    dgEmployee.DataSource = dtdgEmployee;
                    ViewState["EmpTable"] = dtdgEmployee;

                    dgEmployee.DataBind();
                    gvAddEmployeeGrid.DataSource = dtgvAddEmployeeGrid;
                    gvAddEmployeeGrid.DataBind();
                }
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }
        static DataTable CreateTable()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Employee_ID");
            dt.Columns.Add("FirstName");
            dt.Columns.Add("PAN_NO");
            dt.Columns.Add("CDate");
            dt.Columns.Add("Amount");
            dt.Columns.Add("PanVerified");
            dt.Columns.Add("TDS_Amount");
            dt.Columns.Add("Surcharge_Amount");
            dt.Columns.Add("EducationCess_Amount");
            dt.Columns.Add("High_EductionCess_Amount");
            dt.Columns.Add("Total_TDS_Amount");
            dt.Columns.Add("Deduction_Type");
            dt.Columns.Add("CertNo");
            return dt;
        }

        protected void btnExprecd_Click(object sender, EventArgs e)
        {
            try
            {
                DataSet ds;

                //ds.DataSource = (DataTable)ViewState["EmpTable"];
                DataTable dts = (DataTable)ViewState["EmpTable"];
                //dts = ds.Tables[0];
                if (dts.Rows.Count > 0)
                {
                    DumpExcel(dts);
                }
                else
                {
                    MessageBox.Show("No Records To EXPORT.");
                }

            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        private void DumpExcel(DataTable tbl)
        {
            using (ExcelPackage pck = new ExcelPackage())
            {
                //Create the worksheet
                ExcelWorksheet ws = pck.Workbook.Worksheets.Add("Employee");

                //Load the datatable into the sheet, starting from cell A1. Print the column names on row 1
                ws.Cells["A1"].LoadFromDataTable(tbl, true);
                ws.Cells.AutoFitColumns();
                ////Format the header for column 1-3
                //using (ExcelRange rng = ws.Cells["A1:AI1"])
                //{
                //    rng.Style.Font.Bold = true;
                //    rng.Style.Fill.PatternType = ExcelFillStyle.Solid;                      //Set Pattern for the background to Solid
                //    rng.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(79, 129, 189));  //Set color to dark blue
                //    rng.Style.Font.Color.SetColor(Color.White);
                //}


                string ds = "G2:G" + (tbl.Rows.Count + 100).ToString();
                using (ExcelRange rn = ws.Cells[ds])
                {
                    //rn.Style.Numberformat.Format = "h:mm";
                    rn.Style.Numberformat.Format = "dd/MM/yyyy";
                }

                //ds = "M2:G" + (tbl.Rows.Count + 100).ToString();
                //ds = "M2";
                //using (ExcelRange rn = ws.Cells[ds])
                //{
                //    //rn.Style.Numberformat.Format = "h:mm";
                //    rn.Formula = "SUM(I2:L2)";
                //}
                for (int i = 2; i < tbl.Rows.Count; i++)
                {

                    ws.Cells["M" + i].Formula = "SUM(I" + i + ":L" + i + ")";
                }


                xlErr = "1";
                using (var memoryStream = new MemoryStream())
                {
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("content-disposition", "attachment;  filename=Employee_Records_"+ hdnQuarter.Value + "_"+ ddl_month.SelectedValue + ".xlsx");
                    pck.SaveAs(memoryStream);
                    memoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                  
                }
                ucMessageControl.SetMessage("Excel Sheet Exported Successfully!!!", MessageDisplay.DisplayStyles.Success);
            }
        }



        protected void btnImport_Click(object sender, EventArgs e)
        {
            try
            {
                string ConStr = "";
                string ext = Path.GetExtension(FileUpload1.FileName).ToLower();
                string path = Server.MapPath(FileUpload1.FileName);
                if (FileUpload1.FileName == "")
                {
                    ucMessageControl.SetMessage("Kindly Please select the Excel sheet!!!", MessageDisplay.DisplayStyles.Error);
                    //MessageControl1.SetMessage("Kindly Please select the Excel sheet!!!", MessageDisplay.DisplayStyles.Error);
                }
                else
                {
                    FileUpload1.SaveAs(path);


                    if (ext.Trim() == ".xls")
                    {
                        //connection string for that file which extantion is .xls  
                        ConStr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + path + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
                    }
                    else if (ext.Trim() == ".xlsx")
                    {
                        //connection string for that file which extantion is .xlsx  
                        ConStr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
                    }

                    ///Sheet1
                    string query = "SELECT * FROM [Employee$]";
                    OleDbConnection conn = new OleDbConnection(ConStr);
                    if (conn.State == ConnectionState.Closed)
                    {
                        conn.Open();
                    }
                    OleDbCommand cmd = new OleDbCommand(query, conn);
                    OleDbDataAdapter da = new OleDbDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    da.Fill(ds);

                    ////Sheet2


                    //dgEmployee.DataSource = ds.Tables[0];
                    DataTable dt = ds.Tables[0];
                    for (int i = dt.Rows.Count - 1; i >= 0; i--)
                    {
                        if (dt.Rows[i][1] == DBNull.Value)
                        {
                            dt.Rows[i].Delete();
                        }
                    }
                    dt.AcceptChanges();
                    dgEmployee.DataSource = dt;
                    dgEmployee.DataBind();



                    //dvFileupload.Visible = false;
                    //dvButton.Visible = true;
                    conn.Close();

                    if (File.Exists(path))
                    {
                        File.Delete(path);
                    }
                    ucMessageControl.SetMessage("Excel Sheet Imported Successfully!!!", MessageDisplay.DisplayStyles.Success);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}