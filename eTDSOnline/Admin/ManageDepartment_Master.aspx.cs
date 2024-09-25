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
    public partial class _ManageDepartment_Master : System.Web.UI.Page
    {
        CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
        BAL_Department_Master objBAL_Department_Master = new BAL_Department_Master();

        // End of Search Code
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["companyid"] != null)
                {
                    this.ShowGrid();
                }
                else
                {
                    Response.Redirect("~/Default.aspx");
                }
            }
        }

        #region Methods

        //Search Code

        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            this.ShowGrid();
        }
        // End Search Code

        private void BindGrid()
        {
            try
            {
                objBAL_Department_Master = new BAL_Department_Master();
                objBAL_Department_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                objBAL_Department_Master._Department_Name = txtSearchDepartmentName.Text;

                DataSet ds = objBAL_Department_Master.Get_Department_Master_List();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    dgDepartment_Master.Visible = true;
                    dgDepartment_Master.DataSource = ds;
                    dgDepartment_Master.DataBind();

                    foreach (DataGridItem item in dgDepartment_Master.Items)
                    {
                        item.Cells[0].Text = (item.ItemIndex + 1).ToString();
                    }

                    lblGridMessage.Text = "";
                }
                else
                {
                    dgDepartment_Master.Visible = false;
                    lblGridMessage.Text = "No record found.";
                }
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }


        private void FullFillValue(int Department_ID)
        {
            try
            {
                this.HideGrid();

                objBAL_Department_Master._Department_ID = Department_ID;
                DataSet ds = objBAL_Department_Master.Get_Department_Master_Details();

                hdnDepartment_ID.Value = ds.Tables[0].Rows[0]["Department_ID"].ToString();
                txtDepartment_Name.Text = ds.Tables[0].Rows[0]["Department_Name"].ToString();
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        private void DeleteDepartment(int Department_ID)
        {
            try
            {
                //objBAL_Department_Master._Department_ID = Department_ID;
                //DataSet ds1 = objBAL_Department_Master.Check_with_Employee_Master();
                //if (ds1.Tables[0].Rows.Count > 0)
                //{
                //    ucMessageControl.SetMessage("Delete Employee First, Data Exist", MessageDisplay.DisplayStyles.Error);
                //}
                //else
                //{

                objBAL_Department_Master._Department_ID = Department_ID;
                DataSet ds = objBAL_Department_Master.Delete_Department_Master();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    ucMessageControl.SetMessage("Department has been deleted successfull.", MessageDisplay.DisplayStyles.Success);
                    this.ClearValues();
                    this.ShowGrid();
                }
                else
                    ucMessageControl.SetMessage("Error occured while delete Department.", MessageDisplay.DisplayStyles.Error);
                //}

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
                hdnDepartment_ID.Value = "";
                txtDepartment_Name.Text = "";
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
                tdSearch.Visible = true;
                tdGrid.Visible = true;
                tblDepartment.Visible = false;
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
                tdSearch.Visible = false;
                tdGrid.Visible = false;
                tblDepartment.Visible = true;
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

        protected void dgDepartment_Master_OnItemCommand(object sender, DataGridCommandEventArgs e)
        {
            int Department_ID = 0;

            switch (e.CommandName)
            {
                case "EditCommand":
                    Department_ID = Convert.ToInt32(dgDepartment_Master.DataKeys[e.Item.ItemIndex]);
                    this.FullFillValue(Department_ID);
                    break;
                case "DeleteCommand":
                    Department_ID = Convert.ToInt32(dgDepartment_Master.DataKeys[e.Item.ItemIndex]);
                    this.DeleteDepartment(Department_ID);
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

                if (string.IsNullOrEmpty(hdnDepartment_ID.Value))
                {
                    objBAL_Department_Master._Department_Name = txtDepartment_Name.Text;
                    objBAL_Department_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                    objBAL_Department_Master._Created_by = 111;

                    ds = objBAL_Department_Master.Insert_Department_Master();
                }
                else
                {
                    objBAL_Department_Master._Department_ID = Convert.ToInt32(hdnDepartment_ID.Value);
                    objBAL_Department_Master._Department_Name = txtDepartment_Name.Text;
                    objBAL_Department_Master._Company_ID = int.Parse(Session["companyid"].ToString());

                    ds = objBAL_Department_Master.Update_Department_Master();
                }

                if (ds.Tables[0].Rows.Count > 0)
                {
                    ucMessageControl.SetMessage("Department has been saved successfull.", MessageDisplay.DisplayStyles.Success);
                    this.ClearValues();
                    this.ShowGrid();
                }
                else
                    ucMessageControl.SetMessage("Error occured while save Department.", MessageDisplay.DisplayStyles.Error);

            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
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

        #endregion
    }
}