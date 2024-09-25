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
    public partial class _ManageRebate_Master : System.Web.UI.Page
    {
        CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
        BAL_Rebate_Master objBAL_Rebate_Master = new BAL_Rebate_Master();

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
                objBAL_Rebate_Master = new BAL_Rebate_Master();
                //objBAL_Rebate_Master._Company_ID = int.Parse(Session["companyid"].ToString());

                DataSet ds = objBAL_Rebate_Master.Get_Rebate_Master_List();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    dgRebate_Master.Visible = true;
                    dgRebate_Master.DataSource = ds;
                    dgRebate_Master.DataBind();

                    foreach (DataGridItem item in dgRebate_Master.Items)
                    {
                        item.Cells[0].Text = (item.ItemIndex + 1).ToString();
                    }

                    lblGridMessage.Text = "";
                }
                else
                {
                    dgRebate_Master.Visible = false;
                    lblGridMessage.Text = "No record found.";
                }
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }


        private void FullFillValue(int Rebate_ID)
        {
            try
            {
                objBAL_Rebate_Master._Rebate_ID = Rebate_ID;
                DataSet ds = objBAL_Rebate_Master.Get_Rebate_Master_Details();

                hdnRebate_ID.Value = ds.Tables[0].Rows[0]["Rebate_ID"].ToString();
                txtRebate_Name.Text = ds.Tables[0].Rows[0]["Rebate_Name"].ToString();
                
                tblRebate.Visible = true;
                tdGrid.Visible = false;
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        private void DeleteRebate(int Rebate_ID)
        {
            try
            {
                objBAL_Rebate_Master._Rebate_ID = Rebate_ID;
                DataSet ds = objBAL_Rebate_Master.Delete_Rebate_Master();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    ucMessageControl.SetMessage("Rebate has been deleted successfull.", MessageDisplay.DisplayStyles.Success);
                    this.ClearValues();
                    this.ShowGrid();
                }
                else
                    ucMessageControl.SetMessage("Error occured while delete Rebate.", MessageDisplay.DisplayStyles.Error);


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
                hdnRebate_ID.Value = "";
                txtRebate_Name.Text = "";
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
                tblRebate.Visible = false;
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
                tblRebate.Visible = true;
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

        protected void dgRebate_Master_OnItemCommand(object sender, DataGridCommandEventArgs e)
        {
            int Rebate_ID = 0;

            switch (e.CommandName)
            {
                case "EditCommand":
                    Rebate_ID = Convert.ToInt32(dgRebate_Master.DataKeys[e.Item.ItemIndex]);
                    this.FullFillValue(Rebate_ID);
                    break;
                case "DeleteCommand":
                    Rebate_ID = Convert.ToInt32(dgRebate_Master.DataKeys[e.Item.ItemIndex]);
                    this.DeleteRebate(Rebate_ID);
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

                if (string.IsNullOrEmpty(hdnRebate_ID.Value))
                {
                    objBAL_Rebate_Master._Rebate_Name = txtRebate_Name.Text;

                    ds = objBAL_Rebate_Master.Insert_Rebate_Master();
                }
                else
                {
                    objBAL_Rebate_Master._Rebate_ID = Convert.ToInt32(hdnRebate_ID.Value);
                    objBAL_Rebate_Master._Rebate_Name = txtRebate_Name.Text;
                    

                    ds = objBAL_Rebate_Master.Update_Rebate_Master();
                }

                if (ds.Tables[0].Rows.Count > 0)
                {
                    ucMessageControl.SetMessage("Rebate has been saved successfull.", MessageDisplay.DisplayStyles.Success);
                    this.ClearValues();
                    this.ShowGrid();
                }
                else
                    ucMessageControl.SetMessage("Error occured while save Rebate.", MessageDisplay.DisplayStyles.Error);

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