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
    public partial class _ManageBranch_Salary_Master : System.Web.UI.Page
    {
        CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
        BAL_Branch_Salary_Master objBAL_Branch_Salary_Master = new BAL_Branch_Salary_Master();
        BAL_State_Master objBAL_State_Master = new BAL_State_Master();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["companyid"] != null)
                {

                    this.BindStateCombos();
                    this.ShowGrid();
                }
                else
                {
                    Response.Redirect("~/Default.aspx");
                }
            }
        }

        #region Methods

        private void BindGrid()
        {
            try
            {
                objBAL_Branch_Salary_Master = new BAL_Branch_Salary_Master();
                objBAL_Branch_Salary_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                DataSet ds = objBAL_Branch_Salary_Master.Get_Branch_Salary_Master_List();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    dgBranch_Master.Visible = true;
                    dgBranch_Master.DataSource = ds;
                    dgBranch_Master.DataBind();

                    foreach (DataGridItem item in dgBranch_Master.Items)
                    {
                        item.Cells[0].Text = (item.ItemIndex + 1).ToString();
                    }

                    lblGridMessage.Text = "";
                }
                else
                {
                    dgBranch_Master.Visible = false;
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

        private void FullFillValue(int Branch_ID)
        {
            try
            {
                objBAL_Branch_Salary_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                objBAL_Branch_Salary_Master._Branch_ID = Branch_ID;
                DataSet ds = objBAL_Branch_Salary_Master.Get_Branch_Salary_Master_Details();

                hdnBranch_ID.Value = ds.Tables[0].Rows[0]["Branch_ID"].ToString();
                txtBranch_Name.Text = ds.Tables[0].Rows[0]["Branch_Name"].ToString();
                ddlState.SelectedValue = ds.Tables[0].Rows[0]["State_ID"].ToString();

                tblBranch.Visible = true;
                tdGrid.Visible = false;
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        private void DeleteBranch(int Branch_ID)
        {
            try
            {
                objBAL_Branch_Salary_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                objBAL_Branch_Salary_Master._Branch_ID = Branch_ID;
                DataSet ds = objBAL_Branch_Salary_Master.Delete_Branch_Salary_Master();
                if (ds.Tables[0].Rows[0][0].ToString() == "1")
                {
                    ucMessageControl.SetMessage("Branch has been deleted successfull.", MessageDisplay.DisplayStyles.Success);
                    this.ClearValues();
                    this.ShowGrid();
                }
                else
                    ucMessageControl.SetMessage("Error occured while delete Branch.", MessageDisplay.DisplayStyles.Error);

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
                hdnBranch_ID.Value = "";
                txtBranch_Name.Text = "";
                ddlState.SelectedIndex = 0;
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
                this.ClearValues();
                this.BindGrid();
                tdGrid.Visible = true;
                tblBranch.Visible = false;
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
                tblBranch.Visible = true;
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

        protected void dgBranch_Master_OnItemCommand(object sender, DataGridCommandEventArgs e)
        {
            int Branch_ID = 0;

            switch (e.CommandName)
            {
                case "EditCommand":
                    Branch_ID = Convert.ToInt32(dgBranch_Master.DataKeys[e.Item.ItemIndex]);
                    this.FullFillValue(Branch_ID);
                    break;
                case "DeleteCommand":
                    Branch_ID = Convert.ToInt32(dgBranch_Master.DataKeys[e.Item.ItemIndex]);
                    this.DeleteBranch(Branch_ID);
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

                if (string.IsNullOrEmpty(hdnBranch_ID.Value))
                {
                    objBAL_Branch_Salary_Master._Branch_Name = txtBranch_Name.Text;
                    objBAL_Branch_Salary_Master._State_ID = Convert.ToInt32(ddlState.SelectedValue);
                    objBAL_Branch_Salary_Master._Company_ID = int.Parse(Session["companyid"].ToString()); // Manual Company
                    objBAL_Branch_Salary_Master._Created_by = 111; // Manual Company

                    ds = objBAL_Branch_Salary_Master.Insert_Branch_Salary_Master();
                }
                else
                {
                    objBAL_Branch_Salary_Master._Branch_ID = Convert.ToInt32(hdnBranch_ID.Value);
                    objBAL_Branch_Salary_Master._Branch_Name = txtBranch_Name.Text;
                    objBAL_Branch_Salary_Master._State_ID = Convert.ToInt32(ddlState.SelectedValue);
                    objBAL_Branch_Salary_Master._Company_ID = int.Parse(Session["companyid"].ToString()); // Manual Company
                    objBAL_Branch_Salary_Master._Created_by = 111; // Manual Company

                    ds = objBAL_Branch_Salary_Master.Update_Branch_Salary_Master();
                }

                if (ds.Tables[0].Rows.Count > 0)
                {
                    ucMessageControl.SetMessage("Branch has been saved successfull.", MessageDisplay.DisplayStyles.Success);
                    this.ClearValues();
                    this.ShowGrid();
                }
                else
                    ucMessageControl.SetMessage("Error occured while save Branch.", MessageDisplay.DisplayStyles.Error);

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