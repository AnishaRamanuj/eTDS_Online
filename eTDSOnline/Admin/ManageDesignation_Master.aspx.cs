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
    public partial class _ManageDesignation_Master : System.Web.UI.Page
    {
        CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
        BAL_Designation_Master objBAL_Designation_Master = new BAL_Designation_Master();

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

        private void BindGrid()
        {
            try
            {
                objBAL_Designation_Master = new BAL_Designation_Master();
                objBAL_Designation_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                objBAL_Designation_Master._Designation_Name = txtSearchDesignationName.Text;

                DataSet ds = objBAL_Designation_Master.Get_Designation_Master_List();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    dgDesignation_Master.Visible = true;
                    dgDesignation_Master.DataSource = ds;
                    dgDesignation_Master.DataBind();

                    //foreach (DataGridItem item in dgDesignation_Master.Items)
                    //{
                    //    item.Cells[0].Text = (item.ItemIndex + 1).ToString();
                    //}

                    lblGridMessage.Text = "";
                }
                else
                {
                    dgDesignation_Master.Visible = false;
                    lblGridMessage.Text = "No record found.";
                }
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        private void FullFillValue(int Designation_ID)
        {
            try
            {
                this.HideGrid();

                objBAL_Designation_Master._Designation_ID = Designation_ID;
                DataSet ds = objBAL_Designation_Master.Get_Designation_Master_Details();

                hdnDesignation_ID.Value = ds.Tables[0].Rows[0]["Designation_ID"].ToString();
                txtDesignation_Name.Text = ds.Tables[0].Rows[0]["Designation_Name"].ToString();
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        private void DeleteDesignation(int Designation_ID)
        {
            try
            {
                //objBAL_Designation_Master._Designation_ID = Designation_ID;
                //DataSet ds1 = objBAL_Designation_Master.Check_with_Employee_Master();
                //if (ds1.Tables[0].Rows.Count > 0)
                //{
                //    ucMessageControl.SetMessage("Delete Employee First, Data Exist", MessageDisplay.DisplayStyles.Error);
                //}
                //else
                //{
                    objBAL_Designation_Master._Designation_ID = Designation_ID;
                    DataSet ds = objBAL_Designation_Master.Delete_Designation_Master();

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        ucMessageControl.SetMessage("Designation has been deleted successfull.", MessageDisplay.DisplayStyles.Success);
                        this.ClearValues();
                        this.ShowGrid();
                    }
                    else
                        ucMessageControl.SetMessage("Error occured while delete Designation.", MessageDisplay.DisplayStyles.Error);
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
                hdnDesignation_ID.Value = "";
                txtDesignation_Name.Text = "";
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
                tblDesignation.Visible = false;
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
                tblDesignation.Visible = true;
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

        protected void dgDesignation_Master_OnItemCommand(object sender, DataGridCommandEventArgs e)
        {
            int Designation_ID = 0;

            switch (e.CommandName)
            {
                case "EditCommand":
                    Designation_ID = Convert.ToInt32(dgDesignation_Master.DataKeys[e.Item.ItemIndex]);
                    this.FullFillValue(Designation_ID);
                    break;
                case "DeleteCommand":
                    Designation_ID = Convert.ToInt32(dgDesignation_Master.DataKeys[e.Item.ItemIndex]);
                    this.DeleteDesignation(Designation_ID);
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

                if (string.IsNullOrEmpty(hdnDesignation_ID.Value))
                {
                    objBAL_Designation_Master._Designation_Name = txtDesignation_Name.Text;
                    objBAL_Designation_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                    ds = objBAL_Designation_Master.Insert_Designation_Master();
                }
                else
                {
                    objBAL_Designation_Master._Designation_ID = Convert.ToInt32(hdnDesignation_ID.Value);
                    objBAL_Designation_Master._Designation_Name = txtDesignation_Name.Text;
                    objBAL_Designation_Master._Company_ID = int.Parse(Session["companyid"].ToString());

                    ds = objBAL_Designation_Master.Update_Designation_Master();
                }

                if (ds.Tables[0].Rows.Count > 0)
                {
                    ucMessageControl.SetMessage("Designation has been saved successfull.", MessageDisplay.DisplayStyles.Success);
                    this.ClearValues();
                    this.ShowGrid();
                }
                else
                    ucMessageControl.SetMessage("Error occured while save Designation.", MessageDisplay.DisplayStyles.Error);

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