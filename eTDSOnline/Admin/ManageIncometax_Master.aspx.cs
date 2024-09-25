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
    public partial class _ManageIncometax_Master : System.Web.UI.Page
    {
        CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
        BAL_Incometax_Master objBAL_Incometax_Master = new BAL_Incometax_Master();

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
                objBAL_Incometax_Master = new BAL_Incometax_Master();
                //objBAL_Incometax_Master._Company_ID = int.Parse(Session["companyid"].ToString());

                DataSet ds = objBAL_Incometax_Master.Get_Incometax_Master_List();

                if (ds.Tables[0].Rows.Count > 0)
                {

                    ds.Tables[0].DefaultView.RowFilter = "SlabTitle = 'General'";
                    dgGeneralIncometax_Master.Visible = true;
                    dgGeneralIncometax_Master.DataSource = ds.Tables[0].DefaultView;
                    dgGeneralIncometax_Master.DataBind();

                    ds.Tables[0].DefaultView.RowFilter = "SlabTitle = 'Sr Ctzn'";
                    dgSrCtznIncometax_Master.Visible = true;
                    dgSrCtznIncometax_Master.DataSource = ds.Tables[0].DefaultView;
                    dgSrCtznIncometax_Master.DataBind();

                    ds.Tables[0].DefaultView.RowFilter = "SlabTitle = 'Female'";
                    dgFemaleIncometax_Master.Visible = true;
                    dgFemaleIncometax_Master.DataSource = ds.Tables[0].DefaultView;
                    dgFemaleIncometax_Master.DataBind();

                    ds.Tables[0].DefaultView.RowFilter = "SlabTitle = 'Super Sr Ctzn'";
                    dgSuperSrCtznIncometax_Master.Visible = true;
                    dgSuperSrCtznIncometax_Master.DataSource = ds.Tables[0].DefaultView;
                    dgSuperSrCtznIncometax_Master.DataBind();

                    ds.Tables[0].DefaultView.RowFilter = "SlabTitle = '115BAC'";
                    dg115.Visible = true;
                    dg115.DataSource = ds.Tables[0].DefaultView;
                    dg115.DataBind();

                    lblGridMessage.Text = "";
                }
                else
                {
                    dgGeneralIncometax_Master.Visible = false;
                    dgFemaleIncometax_Master.Visible = false;
                    dgSrCtznIncometax_Master.Visible = false;
                    dgSuperSrCtznIncometax_Master.Visible = false;
                    dg115.Visible = false;
                    lblGridMessage.Text = "No record found.";
                }



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

                this.BindGrid();
                tdGrid.Visible = true;
                rdoGeneral.Checked = true;
                this.rdoGeneral_OnCheckedChanged(null, null);
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
                tdGrid.Visible = false;

            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        #endregion

        #region Events

        protected void rdoGeneral_OnCheckedChanged(object sender, EventArgs e)
        {
            try
            {
                tdGeneral.Visible = true;

                tdFemal.Visible = false;
                tdSrCtzn.Visible = false;
                tdSuperSnCtzn.Visible = false;
                td115BAC.Visible = false;
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        protected void rdoSrCtzn_OnCheckedChanged(object sender, EventArgs e)
        {
            try
            {
                tdSrCtzn.Visible = true;

                tdFemal.Visible = false;
                tdGeneral.Visible = false;
                tdSuperSnCtzn.Visible = false;
                td115BAC.Visible = false;
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        protected void rdoFemale_OnCheckedChanged(object sender, EventArgs e)
        {
            try
            {
                tdFemal.Visible = true;

                tdGeneral.Visible = false;
                tdSrCtzn.Visible = false;
                tdSuperSnCtzn.Visible = false;
                td115BAC.Visible = false;
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        protected void rdoSuperSrCtzn_OnCheckedChanged(object sender, EventArgs e)
        {
            try
            {
                tdSuperSnCtzn.Visible = true;

                tdFemal.Visible = false;
                tdGeneral.Visible = false;
                tdSrCtzn.Visible = false;
                td115BAC.Visible = false;
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
                int Incometax_ID = 0;

                foreach (DataGridItem item in dgGeneralIncometax_Master.Items)
                {
                    Incometax_ID = Convert.ToInt32(dgGeneralIncometax_Master.DataKeys[item.ItemIndex]);
                    TextBox txtTax_Amount = (TextBox)item.FindControl("txtTax_Amount");
                    TextBox txtSlab = (TextBox)item.FindControl("txtSlab");

                    objBAL_Incometax_Master._Incometax_ID = Incometax_ID;
                    objBAL_Incometax_Master._Tax_Amount = Convert.ToDouble(txtTax_Amount.Text);
                    objBAL_Incometax_Master._Slab = Convert.ToDouble(txtSlab.Text);
                    ds = objBAL_Incometax_Master.Update_Incometax_Master();

                }

                foreach (DataGridItem item in dgFemaleIncometax_Master.Items)
                {
                    Incometax_ID = Convert.ToInt32(dgFemaleIncometax_Master.DataKeys[item.ItemIndex]);
                    TextBox txtTax_Amount = (TextBox)item.FindControl("txtTax_Amount");
                    TextBox txtSlab = (TextBox)item.FindControl("txtSlab");

                    objBAL_Incometax_Master._Incometax_ID = Incometax_ID;
                    objBAL_Incometax_Master._Tax_Amount = Convert.ToDouble(txtTax_Amount.Text);
                    objBAL_Incometax_Master._Slab = Convert.ToDouble(txtSlab.Text);
                    ds = objBAL_Incometax_Master.Update_Incometax_Master();

                }

                foreach (DataGridItem item in dgSrCtznIncometax_Master.Items)
                {
                    Incometax_ID = Convert.ToInt32(dgSrCtznIncometax_Master.DataKeys[item.ItemIndex]);
                    TextBox txtTax_Amount = (TextBox)item.FindControl("txtTax_Amount");
                    TextBox txtSlab = (TextBox)item.FindControl("txtSlab");

                    objBAL_Incometax_Master._Incometax_ID = Incometax_ID;
                    objBAL_Incometax_Master._Tax_Amount = Convert.ToDouble(txtTax_Amount.Text);
                    objBAL_Incometax_Master._Slab = Convert.ToDouble(txtSlab.Text);
                    ds = objBAL_Incometax_Master.Update_Incometax_Master();

                }

                foreach (DataGridItem item in dgSuperSrCtznIncometax_Master.Items)
                {
                    Incometax_ID = Convert.ToInt32(dgSuperSrCtznIncometax_Master.DataKeys[item.ItemIndex]);
                    TextBox txtTax_Amount = (TextBox)item.FindControl("txtTax_Amount");
                    TextBox txtSlab = (TextBox)item.FindControl("txtSlab");

                    objBAL_Incometax_Master._Incometax_ID = Incometax_ID;
                    objBAL_Incometax_Master._Tax_Amount = Convert.ToDouble(txtTax_Amount.Text);
                    objBAL_Incometax_Master._Slab = Convert.ToDouble(txtSlab.Text);
                    ds = objBAL_Incometax_Master.Update_Incometax_Master();

                }

                foreach (DataGridItem item in dg115.Items)
                {
                    Incometax_ID = Convert.ToInt32(dg115.DataKeys[item.ItemIndex]);
                    TextBox txtTax_Amount = (TextBox)item.FindControl("txtTax_Amount");
                    TextBox txtSlab = (TextBox)item.FindControl("txtSlab");

                    objBAL_Incometax_Master._Incometax_ID = Incometax_ID;
                    objBAL_Incometax_Master._Tax_Amount = Convert.ToDouble(txtTax_Amount.Text);
                    objBAL_Incometax_Master._Slab = Convert.ToDouble(txtSlab.Text);
                    ds = objBAL_Incometax_Master.Update_Incometax_Master();

                }

                if (ds.Tables[0].Rows.Count > 0)
                {
                    ucMessageControl.SetMessage("Incometax has been saved successfull.", MessageDisplay.DisplayStyles.Success);
                    this.ShowGrid();
                }
                else
                    ucMessageControl.SetMessage("Error occured while save Incometax.", MessageDisplay.DisplayStyles.Error);

            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        #endregion

        protected void rbtn115BAC_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                td115BAC.Visible = true;

                tdFemal.Visible = false;
                tdGeneral.Visible = false;
                tdSrCtzn.Visible = false;
                tdSuperSnCtzn.Visible = false;
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }
    }
}