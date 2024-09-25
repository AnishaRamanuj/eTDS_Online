using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLayer;
using DataLayer;
using System.Data;

namespace Forms
{
    public partial class _ManageResign_Master : System.Web.UI.Page
    {
        CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
        BAL_Employee_Master objBAL_Employee_Master = new BAL_Employee_Master();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["companyid"] != null)
                {
                //this.BindEmployeeCombos();
                this.ShowGrid();
                }
                else
                {
                    Response.Redirect("~/Default.aspx");
                }
            }
        }

        #region Methods

        private void BindEmployeeCombos(int Employee_ID)
        {
            objBAL_Employee_Master = new BAL_Employee_Master();
            //objBAL_Employee_Master._ResignStatus = 1;
            objBAL_Employee_Master._Company_ID = int.Parse(Session["companyid"].ToString());

            if (Employee_ID > 0)
                objBAL_Employee_Master._Employee_ID = Employee_ID;
            else
                objBAL_Employee_Master._ResignStatus = 1;

            DataSet ds = objBAL_Employee_Master.Get_Employee_Master_List();
            CommonSettings.LoadCombo(ddlEmployee, ds.Tables[0], "FirstName", "Employee_ID", true, "(Select Employee)");
        }

        private void BindGrid()
        {
            try
            {
                objBAL_Employee_Master = new BAL_Employee_Master();
                objBAL_Employee_Master._ResignStatus = -1;
                objBAL_Employee_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                objBAL_Employee_Master._FirstName = txtSearchName.Text;
                DataSet ds = objBAL_Employee_Master.Get_Employee_Master_List();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    dgEmployee_Master.Visible = true;
                    dgEmployee_Master.DataSource = ds;
                    dgEmployee_Master.DataBind();

                    foreach (DataGridItem item in dgEmployee_Master.Items)
                    {
                        item.Cells[0].Text = (item.ItemIndex + 1).ToString();
                    }

                    lblGridMessage.Text = "";
                }
                else
                {
                    dgEmployee_Master.Visible = false;
                    lblGridMessage.Text = "No record found.";
                }
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        private void FullFillValue(int Employee_ID)
        {
            try
            {
                this.HideGrid();
                this.BindEmployeeCombos(Employee_ID);

                objBAL_Employee_Master._Employee_ID = Employee_ID;
                DataSet ds = objBAL_Employee_Master.Get_Employee_Master_DetailsByID();

                //hdnEmployee_ID.Value = ds.Tables[0].Rows[0]["Employee_ID"].ToString();
                ddlEmployee.SelectedValue = ds.Tables[0].Rows[0]["Employee_ID"].ToString();
                txtResign_DT.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["Resign_DT"]).ToShortDateString();
                txtReasion.Text = ds.Tables[0].Rows[0]["Reason_Of_Leaving"].ToString();

                tblEmployee.Visible = true;
                tdGrid.Visible = false;
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
                DataSet ds = null;

                //if (string.IsNullOrEmpty(hdnEmployee_ID.Value))
                //{
                //    objBAL_Employee_Master._Employee_ID = Convert.ToInt32(ddlEmployee.SelectedValue);
                //    ds = objBAL_Employee_Master.Insert_Employee_Master();
                //}
                //else
                //{
                objBAL_Employee_Master._Employee_ID = Employee_ID;
                objBAL_Employee_Master._Reason_Of_Leaving = null;
                objBAL_Employee_Master._Resign_DT = DateTime.Now;

                ds = objBAL_Employee_Master.Update_Resign_Employee_Master();
                //}

                if (ds.Tables[0].Rows.Count > 0)
                {
                    ucMessageControl.SetMessage("Resignation has been deleted successfull.", MessageDisplay.DisplayStyles.Success);
                    this.ClearValues();
                    this.ShowGrid();
                }
                else
                    ucMessageControl.SetMessage("Error occured while delete Resignation.", MessageDisplay.DisplayStyles.Error);
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        private void ClearValues()
        {
            try
            {
                hdnEmployee_ID.Value = "";
                txtReasion.Text = "";
                txtResign_DT.Text = "";
                ddlEmployee.SelectedIndex = 0;

            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        private void ShowGrid()
        {
            try
            {
                this.BindEmployeeCombos(0);
                this.ClearValues();
                this.BindGrid();
                tdGrid.Visible = true;
                tdSearch.Visible = true;
                tblEmployee.Visible = false;
                btnAddNew.Visible = true;
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
                this.ClearValues();
                tdGrid.Visible = false;
                tdSearch.Visible = false;
                tblEmployee.Visible = true;
                btnAddNew.Visible = false;
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        #endregion

        #region Events

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

        protected void dgEmployee_Master_OnItemCommand(object sender, DataGridCommandEventArgs e)
        {
            int Employee_ID = 0;

            switch (e.CommandName)
            {
                case "EditCommand":
                    Employee_ID = Convert.ToInt32(dgEmployee_Master.DataKeys[e.Item.ItemIndex]);
                    this.FullFillValue(Employee_ID);
                    break;
                case "DeleteCommand":
                    Employee_ID = Convert.ToInt32(dgEmployee_Master.DataKeys[e.Item.ItemIndex]);
                    this.DeleteEmployee(Employee_ID);
                    break;
                default:
                    break;
            }
        }

        protected void btnAddNew_OnClick(object sender, EventArgs e)
        {
            try
            {
                this.HideGrid();
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        protected void btnCancel_OnClick(object sender, EventArgs e)
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

        protected void btnSave_OnClick(object sender, EventArgs e)
        {
            try
            {
                DataSet ds = null;

                //if (string.IsNullOrEmpty(hdnEmployee_ID.Value))
                //{
                //    objBAL_Employee_Master._Employee_ID = Convert.ToInt32(ddlEmployee.SelectedValue);
                //    ds = objBAL_Employee_Master.Insert_Employee_Master();
                //}
                //else
                //{
                objBAL_Employee_Master._Employee_ID = Convert.ToInt32(ddlEmployee.SelectedValue);
                objBAL_Employee_Master._Reason_Of_Leaving = txtReasion.Text;
                objBAL_Employee_Master._Resign_DT = CommonSettings.ConvertToCulturedDateTime(txtResign_DT.Text);

                ds = objBAL_Employee_Master.Update_Resign_Employee_Master();
                //}

                if (ds.Tables[0].Rows.Count > 0)
                {
                    ucMessageControl.SetMessage("Resignation has been saved successfull.", MessageDisplay.DisplayStyles.Success);
                    this.ClearValues();
                    this.ShowGrid();
                }
                else
                    ucMessageControl.SetMessage("Error occured while save Resignation.", MessageDisplay.DisplayStyles.Error);

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