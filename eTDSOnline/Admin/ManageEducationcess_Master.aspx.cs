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
    public partial class _ManageEducationcess_Master : System.Web.UI.Page
    {
        CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
        BAL_Educationcess_Master objBAL_Educationcess_Master = new BAL_Educationcess_Master();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.ShowGrid();
            }
        }

        #region Methods

        private void BindGrid()
        {
            try
            {
                objBAL_Educationcess_Master = new BAL_Educationcess_Master();
                //objBAL_Educationcess_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                objBAL_Educationcess_Master._App_Type = "Sal";

                DataSet ds = objBAL_Educationcess_Master.Get_Educationcess_Master_List();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    dgEducationcess_Master.Visible = true;
                    dgEducationcess_Master.DataSource = ds;
                    dgEducationcess_Master.DataBind();

                    foreach (DataGridItem item in dgEducationcess_Master.Items)
                    {
                        item.Cells[0].Text = (item.ItemIndex + 1).ToString();
                    }

                    lblGridMessage.Text = "";
                }
                else
                {
                    dgEducationcess_Master.Visible = false;
                    lblGridMessage.Text = "No record found.";
                }
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }


        private void FullFillValue(int Educationcess_ID)
        {
            try
            {
                objBAL_Educationcess_Master._Educationcess_ID = Educationcess_ID;
                DataSet ds = objBAL_Educationcess_Master.Get_Educationcess_Master_Details();

                hdnEducationcess_ID.Value = ds.Tables[0].Rows[0]["Educationcess_ID"].ToString();
                txtcess_Percent.Text = ds.Tables[0].Rows[0]["Cess_Percent"].ToString();
                txtApp_Type.Text = ds.Tables[0].Rows[0]["App_Type"].ToString();
                txtHCess_Percent.Text = ds.Tables[0].Rows[0]["HCess_Percent"].ToString();
                
                tblEducationcess.Visible = true;
                tdGrid.Visible = false;
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        private void DeleteEducationcess(int Educationcess_ID)
        {
            try
            {
                objBAL_Educationcess_Master._Educationcess_ID = Educationcess_ID;
                DataSet ds = objBAL_Educationcess_Master.Delete_Educationcess_Master();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    ucMessageControl.SetMessage("Educationcess has been deleted successfull.", MessageDisplay.DisplayStyles.Success);
                    this.ClearValues();
                    this.ShowGrid();
                }
                else
                    ucMessageControl.SetMessage("Error occured while delete Educationcess.", MessageDisplay.DisplayStyles.Error);


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
                hdnEducationcess_ID.Value = "";
                txtcess_Percent.Text = "";
                txtApp_Type.Text = "";
                txtHCess_Percent.Text = "";
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
                tblEducationcess.Visible = false;
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
                tblEducationcess.Visible = true;
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

        protected void dgEducationcess_Master_OnItemCommand(object sender, DataGridCommandEventArgs e)
        {
            int Educationcess_ID = 0;

            switch (e.CommandName)
            {
                case "EditCommand":
                    Educationcess_ID = Convert.ToInt32(dgEducationcess_Master.DataKeys[e.Item.ItemIndex]);
                    this.FullFillValue(Educationcess_ID);
                    break;
                case "DeleteCommand":
                    Educationcess_ID = Convert.ToInt32(dgEducationcess_Master.DataKeys[e.Item.ItemIndex]);
                    this.DeleteEducationcess(Educationcess_ID);
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

                if (string.IsNullOrEmpty(hdnEducationcess_ID.Value))
                {
                    objBAL_Educationcess_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                    objBAL_Educationcess_Master._Cess_Percent = Convert.ToDouble(txtcess_Percent.Text);
                    objBAL_Educationcess_Master._App_Type = txtApp_Type.Text;
                    objBAL_Educationcess_Master._HCess_Percent = Convert.ToDouble(txtHCess_Percent.Text);

                    ds = objBAL_Educationcess_Master.Insert_Educationcess_Master();
                }
                else
                {
                    objBAL_Educationcess_Master._Educationcess_ID = Convert.ToInt32(hdnEducationcess_ID.Value);
                    objBAL_Educationcess_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                    objBAL_Educationcess_Master._Cess_Percent = Convert.ToDouble(txtcess_Percent.Text);
                    objBAL_Educationcess_Master._App_Type = txtApp_Type.Text;
                    objBAL_Educationcess_Master._HCess_Percent = Convert.ToDouble(txtHCess_Percent.Text);

                    ds = objBAL_Educationcess_Master.Update_Educationcess_Master();
                }

                if (ds.Tables[0].Rows.Count > 0)
                {
                    ucMessageControl.SetMessage("Educationcess has been saved successfull.", MessageDisplay.DisplayStyles.Success);
                    this.ClearValues();
                    this.ShowGrid();
                }
                else
                    ucMessageControl.SetMessage("Error occured while save Educationcess.", MessageDisplay.DisplayStyles.Error);

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