using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLayer;
using System.Data;
using System.Web.Security;
using System.Data.SqlClient;
using DataLayer;
using System.IO;
using System.Globalization;
using PANVrf;
using System.Drawing;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel;

namespace Forms
{
    public partial class _Manage_Employee_Master : System.Web.UI.Page
    {
        private int Module_ID
        {
            get
            {
                return (Convert.ToInt32(Session["Module_ID"]));
            }
            set
            {
                Session["Module_ID"] = value;
            }
        }

        DALCommon objDALCommon = new DALCommon();
        CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
        BAL_Employee_Master objBAL_Employee_Master = new BAL_Employee_Master();
        BAL_State_Master objBAL_State_Master = new BAL_State_Master();
        BAL_Department_Master objBAL_Department_Master = new BAL_Department_Master();
        BAL_Designation_Master objBAL_Designation_Master = new BAL_Designation_Master();
        BAL_Branch_Salary_Master objBAL_Branch_Salary_Master = new BAL_Branch_Salary_Master();
        ConnectTraces CT = new ConnectTraces();
        Boolean ErrPan = false;

        const string UploadDirectory = "~/EmployeeImage/";
        const string ThumbnailFileName = "ThumbnailImage.jpg";

        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!Page.IsPostBack)
            {
                
                if (Session["companyid"] != null)
                {   
                    hdnCompanyID.Value = Session["companyid"].ToString();
                    objBAL_Employee_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                    this.Module_ID = 1;
                    this.BindBranchCombos();
                    this.BindDepartmentCombos();
                    this.BindDesignationCombos();

                    //this.ShowGrid();
                }
                else
                {
                    Response.Redirect("~/Default.aspx");
                }
            }
        }
        protected void TimerTick(object sender, EventArgs e)
        {
            this.ShowGrid();
            this.BindStateCombos();
            Timer1.Enabled = false;
        }
        #region Methods

        private void BindGrid()
        {
            try
            {
                DataSet ds = new DataSet();
               
                    objBAL_Employee_Master = new BAL_Employee_Master();
                    objBAL_Employee_Master._FirstName = txtSearchName.Text;

                    objBAL_Employee_Master._Company_ID = int.Parse(Session["companyid"].ToString());

                    if (!string.IsNullOrEmpty(ddlSearchDepartment.SelectedValue))
                        objBAL_Employee_Master._Department_ID = Convert.ToInt32(ddlSearchDepartment.SelectedValue);

                    if (!string.IsNullOrEmpty(ddlSearchDesignation.SelectedValue))
                        objBAL_Employee_Master._Designation_ID = Convert.ToInt32(ddlSearchDesignation.SelectedValue);

                    if (!string.IsNullOrEmpty(ddlSearchBranch.SelectedValue))
                        objBAL_Employee_Master._Branch_ID = Convert.ToInt32(ddlSearchBranch.SelectedValue);

                    if (rdoCurrentEmployee.Checked)
                        objBAL_Employee_Master._ResignStatus = Convert.ToInt32(1);
                    else if (rdoLeftEmployee.Checked)
                        objBAL_Employee_Master._ResignStatus = Convert.ToInt32(-1);
                    else
                        objBAL_Employee_Master._ResignStatus = Convert.ToInt32(0);

                    ds = objBAL_Employee_Master.Get_Employee_Master_List();
                    
                
                if (ds.Tables[0].Rows.Count > 0)
                {
                    dgEmployee.Visible = true;
                    dgEmployee.DataSource = ds;
                    dgEmployee.AllowPaging = true;
                    //dgEmployee.Columns[1].FooterText = "Total Employee :" + ds.Tables[1].Rows[0][0].ToString();
                    dgEmployee.DataBind();

                    rdoAllEmployee.Text = "All Employee (" + ds.Tables[1].Rows[0]["TotalCount"].ToString() + ")";
                    rdoCurrentEmployee.Text = "Current Employee (" + ds.Tables[1].Rows[0]["CurrentCount"].ToString() + ")";
                    rdoLeftEmployee.Text = "Left Employee (" + ds.Tables[1].Rows[0]["LeftCount"].ToString() + ")";
                    lblGridMessage.Text = string.Empty;
                }
                else
                {
                    dgEmployee.Visible = false;
                    lblGridMessage.Text = "No record found.";
                }
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        private void BindStateCombos()
        {
            DataSet ds = objBAL_State_Master.Get_State_Master_List();
            CommonSettings.LoadCombo(ddlState, ds.Tables[0], "State_Name", "State_ID", true, "(Select State)");
        }

        private void BindBranchCombos()
        {
            objBAL_Branch_Salary_Master._Company_ID = int.Parse(Session["companyid"].ToString());
            DataSet ds = objBAL_Branch_Salary_Master.Get_Branch_Salary_Master_List();
            CommonSettings.LoadCombo(ddlBranch_Salary_Master, ds.Tables[0], "Branch_Name", "Branch_ID", true, "(Select Branch)");
            CommonSettings.LoadCombo(ddlSearchBranch, ds.Tables[0], "Branch_Name", "Branch_ID", true, "(Select Branch)");
        }

        private void BindDepartmentCombos()
        {
            objBAL_Department_Master._Company_ID = int.Parse(Session["companyid"].ToString());
            DataSet ds = objBAL_Department_Master.Get_Department_Master_List();
            CommonSettings.LoadCombo(ddlDepartment, ds.Tables[0], "Department_Name", "Department_ID", true, "(Select Department)");
            CommonSettings.LoadCombo(ddlSearchDepartment, ds.Tables[0], "Department_Name", "Department_ID", true, "(Select Department)");
        }

        private void BindDesignationCombos()
        {
            objBAL_Designation_Master._Company_ID = int.Parse(Session["companyid"].ToString());
            DataSet ds = objBAL_Designation_Master.Get_Designation_Master_List();
            CommonSettings.LoadCombo(ddlDesignation, ds.Tables[0], "Designation_Name", "Designation_ID", true, "(Select Designation)");
            CommonSettings.LoadCombo(ddlSearchDesignation, ds.Tables[0], "Designation_Name", "Designation_ID", true, "(Select Designation)");
        }

        private void ShowGrid()
        {
            try
            {
                tdGrid.Visible = true;
                tblEmployee.Visible = false;
                btnAddNew.Visible = true;
                tdSearch.Visible = true;
                this.ClearAll();
                this.BindGrid();
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        private void HideGrid()
        {
            try
            {
                this.ClearAll();
                tdGrid.Visible = false;
                tblEmployee.Visible = true;
                btnAddNew.Visible = false;
                tdSearch.Visible = false;
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        private void ClearAll()
        {
            hdnEmployee_ID.Value = string.Empty;
            txtFirstName.Text = string.Empty;
            txtAddress.Text = string.Empty;
            txtCity.Text = "Mumbai";
            ddlState.SelectedValue = "19";
            rdoMale.Checked = true;
            ddlDepartment.SelectedIndex = 0;
            ddlDesignation.SelectedIndex = 0;
            ddlBranch_Salary_Master.SelectedIndex = 0;

            txtBirthDate.Text = "";
            txtPan_NO.Text = string.Empty;
            txtJoiningDate.Text = "";
            txtFATHER_HUSBAND_NAME.Text = string.Empty;
            //chkCalcESIC.Checked = false;
            chkCalcProvidendFund.Checked = true;
            chkCalcProfessionalTax.Checked = true;
            drpCtzn.SelectedValue = "None";
           // lblPanVerify.Text = "";
            //txtTelNo.Text = string.Empty;
            //txtPF_Percentage.Text = string.Empty;
            //txtPF_Limit.Text = string.Empty;
            //chkHandicapped.Checked = false;
            //cmbMetroCities.SelectedIndex = 0;
            //txtNominee.Text = string.Empty;
            //txtBloodGrp.Text = string.Empty;
            rlist_Handicapped.SelectedValue = "0";
            txtMobile.Text = string.Empty;
            ddlMetrocities.SelectedValue = "Mumbai";
            drpChild.Text = "0";

        }

        private void FullFillValue(int Employee_ID)
        {
            try
            {
                this.HideGrid();

                objBAL_Employee_Master._Employee_ID = Employee_ID;
                DataSet ds = objBAL_Employee_Master.Get_Employee_Master_DetailsByID();
                Page.SetFocus(txtFirstName);
                hdnEmployee_ID.Value = Employee_ID.ToString();
                txtFirstName.Text = ds.Tables[0].Rows[0]["FirstName"].ToString();
                txtAddress.Text = ds.Tables[0].Rows[0]["Emp_Address"].ToString();
                txtCity.Text = ds.Tables[0].Rows[0]["City"].ToString();
                ddlState.SelectedValue = ds.Tables[0].Rows[0]["State_ID"].ToString();

                if (ds.Tables[0].Rows[0]["Gender"].ToString().ToLower() == "male")
                    rdoMale.Checked = true;
                else
                    rdoFemale.Checked = true;

                if (Convert.ToInt32(ds.Tables[0].Rows[0]["Designation_ID"]) > 0)
                    ddlDesignation.SelectedValue = ds.Tables[0].Rows[0]["Designation_ID"].ToString();

                if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["Birth_DT"].ToString()) && !CommonSettings.IsMinDateTime(Convert.ToDateTime(ds.Tables[0].Rows[0]["Birth_DT"])))
                    txtBirthDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["Birth_DT"]).ToString(CommonSettings.DateFormat());

                if (ds.Tables[0].Rows[0]["Join_DT"].ToString() != null && !string.IsNullOrEmpty(ds.Tables[0].Rows[0]["Join_DT"].ToString()))
                {
                    txtJoiningDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["Join_DT"]).ToString(CommonSettings.DateFormat());
                }

                txtFATHER_HUSBAND_NAME.Text = ds.Tables[0].Rows[0]["FATHER_HUSBAND_NAME"].ToString();
                txtPan_NO.Text = ds.Tables[0].Rows[0]["PAN_NO"].ToString().ToUpper();
                txtPan_NO_TextChanged(txtPan_NO, EventArgs.Empty);
                ddlBranch_Salary_Master.SelectedValue = ds.Tables[0].Rows[0]["Branch_ID"].ToString();
                chkCalcProvidendFund.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["CALC_PF"].ToString());
                chkCalcProfessionalTax.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["CALC_PT"].ToString());
                drpCtzn.SelectedValue = ds.Tables[0].Rows[0]["Senior_CTZN_Type"].ToString();

                txtMobile.Text = ds.Tables[0].Rows[0]["Mobile_No"].ToString();

                ddlMetrocities.SelectedValue = ds.Tables[0].Rows[0]["Metro_Cities"].ToString();
                rlist_Handicapped.SelectedValue = (Convert.ToBoolean(ds.Tables[0].Rows[0]["Handicapped"]) ? 1 : 0).ToString();

                if (Convert.ToInt32(ds.Tables[0].Rows[0]["Department_ID"]) > 0)
                    ddlDepartment.SelectedValue = Convert.ToInt32(ds.Tables[0].Rows[0]["Department_ID"]).ToString();

                drpChild.SelectedValue = ds.Tables[0].Rows[0]["No_of_Child"].ToString();

                //txtTelNo.Text = ds.Tables[0].Rows[0]["Tel_NO"].ToString();
                //txtPF_Percentage.Text = ds.Tables[0].Rows[0]["PF_Percentage"].ToString();
                //txtPF_Limit.Text = ds.Tables[0].Rows[0]["PF_Limit"].ToString();

                //if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["Metro_Cities"].ToString()))


                //txtNominee.Text = ds.Tables[0].Rows[0]["Nominee"].ToString();

                //txtBloodGrp.Text = ds.Tables[0].Rows[0]["BloodGrp"].ToString();


                //this.BindGrid();
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        private void DeleteEmployee(int Employee_ID)
        {
            try
            {
                objBAL_Employee_Master._Employee_ID = Employee_ID;
                DataSet ds = objBAL_Employee_Master.Delete_Employee_Master();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    
                    ucMessageControl.SetMessage("Employee has been deleted successfull.", MessageDisplay.DisplayStyles.Success);
                    this.ShowGrid();
                }
                else
                    throw new Exception("Error occure while delete employee");

            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        #endregion

        #region Events

        protected void RadioButton_OnCheckedChanged(object sender, EventArgs e)
        {
            try
            {
                
                this.ShowGrid();
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        protected void btnYes_OnClick(object sender, EventArgs e)
        {
            Response.Redirect("ManageSalaryAllocation_Master.aspx?emp_id=" + hdnEmployee_ID.Value);
        }

        protected void btnAddNew_OnClick(object sender, EventArgs e)
        {
            this.HideGrid();
            Page.SetFocus(txtFirstName);
        }

        protected void btnCancel_OnClick(object sender, EventArgs e)
        {
            this.ShowGrid();
        }

        protected void btnSave_OnClick(object sender, EventArgs e)
        {

            try
            {
               
                string Gender = "Male";

                if (rdoFemale.Checked)
                    Gender = "Female";

                if (txtJoiningDate.Text != "")
                {
                    if (CommonSettings.ConvertToCulturedDateTime(txtJoiningDate.Text) < DateTime.Now.AddYears(-100) || CommonSettings.ConvertToCulturedDateTime(txtJoiningDate.Text) > DateTime.Now)
                    {
                        ucMessageControl.SetMessage("Joining date is invalid, Please try again.", MessageDisplay.DisplayStyles.Error);
                        Page.SetFocus(txtJoiningDate);
                        return;
                    }
                }
                if (txtBirthDate.Text != "")
                {
                    if (CommonSettings.ConvertToCulturedDateTime(txtBirthDate.Text) < DateTime.Now.AddYears(-150) || CommonSettings.ConvertToCulturedDateTime(txtBirthDate.Text) > DateTime.Now)
                    {
                        ucMessageControl.SetMessage("Birth date is invalid, Please try again.", MessageDisplay.DisplayStyles.Error);
                        Page.SetFocus(txtBirthDate);
                        return;
                    }
                }
                txtPan_NO_TextChanged(txtPan_NO, EventArgs.Empty);
                //objBAL_Employee_Master._PANVerified = lblPanVerify.Text;
                if (string.IsNullOrEmpty(hdnEmployee_ID.Value))
                {
                    objBAL_Employee_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                    objBAL_Employee_Master._FirstName = txtFirstName.Text;
                    objBAL_Employee_Master._Emp_Address = txtAddress.Text;
                    objBAL_Employee_Master._City = txtCity.Text;
                    objBAL_Employee_Master._State_ID = Convert.ToInt32(ddlState.SelectedValue);
                    objBAL_Employee_Master._Gender = Gender;
                    objBAL_Employee_Master._Designation_ID = Convert.ToInt32(ddlDesignation.SelectedValue == "" ? "0" : ddlDesignation.SelectedValue);

                    objBAL_Employee_Master._Birth_DT = CommonSettings.ConvertToCulturedDateTime(txtBirthDate.Text);
                    objBAL_Employee_Master._Join_DT = CommonSettings.ConvertToCulturedDateTime(txtJoiningDate.Text);
                    objBAL_Employee_Master._FATHER_HUSBAND_NAME = txtFATHER_HUSBAND_NAME.Text;
                    objBAL_Employee_Master._PAN_NO = txtPan_NO.Text.ToUpper();
                    objBAL_Employee_Master._Branch_ID = Convert.ToInt32(ddlBranch_Salary_Master.SelectedValue);
                    objBAL_Employee_Master._Resign_DT = DateTime.MinValue;
                    // objBAL_Employee_Master._Calc_ESIC = Convert.ToBoolean(chkCalcESIC.Checked);
                    objBAL_Employee_Master._CALC_PF = Convert.ToBoolean(chkCalcProvidendFund.Checked);
                    objBAL_Employee_Master._CALC_PT = Convert.ToBoolean(chkCalcProfessionalTax.Checked);
                    objBAL_Employee_Master._Senior_CTZN_Type = drpCtzn.SelectedValue.ToString();
                    objBAL_Employee_Master._Department_ID = Convert.ToInt32(ddlDepartment.SelectedValue == "" ? "0" : ddlDepartment.SelectedValue);
                    objBAL_Employee_Master._Child = Convert.ToInt32(drpChild.Text);

                    //if (!string.IsNullOrEmpty(txtTelNo.Text))
                    // objBAL_Employee_Master._Tel_NO = Convert.ToUInt32(txtTelNo.Text);

                    objBAL_Employee_Master._Probation_DT = DateTime.MinValue;
                    objBAL_Employee_Master._Confermation_DT = DateTime.MinValue;
                    
                    //  if (!string.IsNullOrEmpty(txtPF_Percentage.Text))
                    //   objBAL_Employee_Master._PF_Percentage = Convert.ToDouble(txtPF_Percentage.Text);
                    // if (!string.IsNullOrEmpty(txtPF_Limit.Text))
                    //     objBAL_Employee_Master._PF_Limit = Convert.ToDouble(txtPF_Limit.Text);

                    objBAL_Employee_Master._Handicapped = Convert.ToBoolean(rlist_Handicapped.SelectedValue == "1" ? "true" : "false");

                    objBAL_Employee_Master._Metro_Cities = ddlMetrocities.SelectedValue;

                    //  objBAL_Employee_Master._Nominee = txtNominee.Text;
                    // objBAL_Employee_Master._BloodGrp = txtBloodGrp.Text;

                    if (!string.IsNullOrEmpty(txtMobile.Text))
                        objBAL_Employee_Master._Mobile_No = txtMobile.Text;

                    DataSet ds = objBAL_Employee_Master.Insert_Employee_Master();
                    int intEmployeeID = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

                    ucMessageControl.SetMessage("Employee has been submited successfull.", MessageDisplay.DisplayStyles.Success);

                    this.ShowGrid();

                    hdnEmployee_ID.Value = intEmployeeID.ToString();

                }
                else
                {
                    objBAL_Employee_Master._Employee_ID = Convert.ToInt32(hdnEmployee_ID.Value);
                    objBAL_Employee_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                    objBAL_Employee_Master._FirstName = txtFirstName.Text;
                    objBAL_Employee_Master._Emp_Address = txtAddress.Text;
                    objBAL_Employee_Master._City = txtCity.Text;
                    objBAL_Employee_Master._State_ID = Convert.ToInt32(ddlState.SelectedValue);
                    objBAL_Employee_Master._Gender = Gender;
                    objBAL_Employee_Master._Designation_ID = Convert.ToInt32(ddlDesignation.SelectedValue == "" ? "0" : ddlDesignation.SelectedValue);

                    objBAL_Employee_Master._Birth_DT = CommonSettings.ConvertToCulturedDateTime(txtBirthDate.Text);
                    objBAL_Employee_Master._Join_DT = CommonSettings.ConvertToCulturedDateTime(txtJoiningDate.Text);

                    objBAL_Employee_Master._FATHER_HUSBAND_NAME = txtFATHER_HUSBAND_NAME.Text;
                    objBAL_Employee_Master._PAN_NO = txtPan_NO.Text;
                    objBAL_Employee_Master._Branch_ID = Convert.ToInt32(ddlBranch_Salary_Master.SelectedValue);
                    objBAL_Employee_Master._Resign_DT = DateTime.MinValue;

                    //objBAL_Employee_Master._Calc_ESIC = Convert.ToBoolean(chkCalcESIC.Checked);
                    objBAL_Employee_Master._CALC_PF = Convert.ToBoolean(chkCalcProvidendFund.Checked);
                    objBAL_Employee_Master._CALC_PT = Convert.ToBoolean(chkCalcProfessionalTax.Checked);
                    objBAL_Employee_Master._Senior_CTZN_Type = drpCtzn.SelectedValue.ToString();
                    objBAL_Employee_Master._Department_ID = Convert.ToInt32(ddlDepartment.SelectedValue == "" ? "0" : ddlDepartment.SelectedValue);
                    objBAL_Employee_Master._Child = Convert.ToInt32(drpChild.Text);
                    //if (!string.IsNullOrEmpty(txtTelNo.Text))
                    //    objBAL_Employee_Master._Tel_NO = Convert.ToUInt32(txtTelNo.Text);
                    objBAL_Employee_Master._Probation_DT = DateTime.MinValue;
                    objBAL_Employee_Master._Confermation_DT = DateTime.MinValue;

                    //if (!string.IsNullOrEmpty(txtPF_Percentage.Text))
                    //   objBAL_Employee_Master._PF_Percentage = Convert.ToDouble(txtPF_Percentage.Text);
                    // if (!string.IsNullOrEmpty(txtPF_Limit.Text))
                    //    objBAL_Employee_Master._PF_Limit = Convert.ToDouble(txtPF_Limit.Text);

                    objBAL_Employee_Master._Handicapped = Convert.ToBoolean(rlist_Handicapped.SelectedValue == "1" ? "true" : "false");

                    objBAL_Employee_Master._Metro_Cities = ddlMetrocities.SelectedValue;

                    //objBAL_Employee_Master._Nominee = txtNominee.Text;
                    // objBAL_Employee_Master._BloodGrp = txtBloodGrp.Text;
                    objBAL_Employee_Master._Employee_ID = Convert.ToInt32(hdnEmployee_ID.Value);

                    if (!string.IsNullOrEmpty(txtMobile.Text))
                        objBAL_Employee_Master._Mobile_No = txtMobile.Text;

                    DataSet ds = objBAL_Employee_Master.Update_Employee_Master();

                    ucMessageControl.SetMessage("Employee has been submited successfull.", MessageDisplay.DisplayStyles.Success);
                    this.ShowGrid();

                }
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        protected void dgEmployee_OnItemCommand(object sender, DataGridCommandEventArgs e)
        {
            int Employee_ID = 0;

            switch (e.CommandName)
            {
                case "EditCommand":
                    Employee_ID = Convert.ToInt32(dgEmployee.DataKeys[e.Item.ItemIndex]);
                    this.FullFillValue(Employee_ID);
                    break;
                case "DeleteCommand":
                    Employee_ID = Convert.ToInt32(dgEmployee.DataKeys[e.Item.ItemIndex]);
                    this.DeleteEmployee(Employee_ID);
                    break;
                default:
                    break;
            }
        }

        protected void btnSearch_OnClick(object sender, EventArgs e)
        {
            try
            {
                
                this.ShowGrid();
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        protected void dgEmployee_PageIndexChanged(object sender, DataGridPageChangedEventArgs e)
        {
            dgEmployee.CurrentPageIndex = e.NewPageIndex;
            this.BindGrid();
        }

        protected void btnBulkPAN_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/BulkPAN_Salary.aspx");
        }

        #endregion


        #region txtPAN Changed
        protected void txtPan_NO_TextChanged(object sender, EventArgs e)
        {
            //if (txtPan_NO.Text == "")
            //{
            //    lblPanVerify.ForeColor = Color.Red;
            //    lblPanVerify.Text = "PAN Not Available";
            //}
            //else
            //{
            if (txtPan_NO.Text.Length == 10)
                {
                    string panno = txtPan_NO.Text;
                    if (panno.Length == 10)
                    {
                        ValidatePanVerification(txtPan_NO.Text);
                    }
                }
                //else
                //{
                //    lblPanVerify.ForeColor = Color.Red;
                //    lblPanVerify.Text = "Please Enter 10 Digit PAN Number";
                //}
            //}
           // ScriptManager.RegisterStartupScript(this, this.GetType(), "alert2", "Alltogo();", true);
        }
        protected void ValidatePanVerification(string PANNO)
        {
            try
            {
                Page.SetFocus(txtPan_NO);
                if (PANNO.Trim().ToLower() != "PANNOTAVBL".Trim().ToLower())
                {
                    ErrPan = CT.Trace_CheckInternetConnectivty();
                    if (ErrPan)
                    {
                        ErrPan = CT.IsPAN_Valid(PANNO);
                        //if (ErrPan == false)
                        //{
                        //    lblPanVerify.Text = "InValid PAN";
                        //    lblPanVerify.ForeColor = Color.Red;

                        //}
                        //else
                        //{
                        //    lblPanVerify.Text = "Valid PAN";
                        //    lblPanVerify.ForeColor = Color.Green;

                        //}
                    }
                }
                //else
                //{
                //    lblPanVerify.Text = "PAN Not Available";
                //    lblPanVerify.ForeColor = Color.Red;
                //}
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);

                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }

        }
        #endregion
    }
}