using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLayer;
using DataLayer;
using System.Data;
using System.Web.Services;
using CommonLibrary;
using System.Web.Script.Serialization;
using PayrollProject;
using System.IO;
using System.Configuration;
using System.Text;
using NReco.PdfGenerator;
using System.Globalization;
namespace Forms
{
    public partial class _ManageBank_Master : System.Web.UI.Page
    {
        private readonly DBAccess db = new DBAccess();
        CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
        BAL_Bank_Master objBAL_Bank_Master = new BAL_Bank_Master();
        DAL_Bank_Master objDAL_Bank_Master = new DAL_Bank_Master();
        DALCommon objDal_DalCommon = new DALCommon();
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
                objBAL_Bank_Master = new BAL_Bank_Master();
                objBAL_Bank_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                DataSet ds = objBAL_Bank_Master.Get_Bank_Master_List();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    dgBank_Master.Visible = true;
                    dgBank_Master.DataSource = ds;
                    dgBank_Master.DataBind();

                    foreach (DataGridItem item in dgBank_Master.Items)
                    {
                        item.Cells[0].Text = (item.ItemIndex + 1).ToString();
                    }

                    lblGridMessage.Text = "";
                }
                else
                {
                    dgBank_Master.Visible = false;
                    lblGridMessage.Text = "No record found.";
                }
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }


        private void FullFillValue(int Bank_ID)
        {
            try
            {
                objBAL_Bank_Master._Bank_ID = Bank_ID;
                DataSet ds = objBAL_Bank_Master.Get_Bank_Master_Details();

                hdnBank_ID.Value = ds.Tables[0].Rows[0]["Bank_ID"].ToString();
                txtBank_Name.Text = ds.Tables[0].Rows[0]["Bank_Name"].ToString();
                txtBank_Branch.Text = ds.Tables[0].Rows[0]["Bank_Branch"].ToString();
                txtBsrcode.Text = ds.Tables[0].Rows[0]["Bsrcode"].ToString();
                
                tblBank.Visible = true;
                tdGrid.Visible = false;
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        private void DeleteBank(int Bank_ID)
        {
            try
            {
                objbankconn conn = new objbankconn();
                if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(conn.ConnectionString)) 
                {
                    HttpContext.Current.Session["Financial_Year_Text"] =conn.ConnectionString;
                }
                string dbname = "";
                objDal_DalCommon.Connection_String_2();
                dbname = objDal_DalCommon.dbname ;
                string compid = Session["companyid"].ToString();
               
                objBAL_Bank_Master._Bank_ID = Bank_ID;
                objBAL_Bank_Master._compid = compid;             
                objBAL_Bank_Master._dbname = dbname;
                DataSet ds = objBAL_Bank_Master.Delete_Bank_Master();

                if (ds.Tables[0].Rows.Count > 0)
                {
                   string ms = ds.Tables[0].Rows[0]["msg"].ToString();
                    if (ms == "1")
                    {
                        ucMessageControl.SetMessage("Bank is already selected in challan, So it can not delete.", MessageDisplay.DisplayStyles.Error);
                    }
                    else
                    {
                        ucMessageControl.SetMessage("Bank has been deleted successfull.", MessageDisplay.DisplayStyles.Success);
                        this.ClearValues();
                        this.ShowGrid();
                    }
                }
                else
                    ucMessageControl.SetMessage("Error occured while delete Bank.", MessageDisplay.DisplayStyles.Error);


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
                hdnBank_ID.Value = "";
                txtBank_Name.Text = "";
                txtBank_Branch.Text = "";
                txtBsrcode.Text = "";
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
                tblBank.Visible = false;
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
                tblBank.Visible = true;
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

        protected void dgBank_Master_OnItemCommand(object sender, DataGridCommandEventArgs e)
        {
            int Bank_ID = 0;
            //int msg = 0;
            switch (e.CommandName)
            {
                case "EditCommand":
                    Bank_ID = Convert.ToInt32(dgBank_Master.DataKeys[e.Item.ItemIndex]);
                    this.FullFillValue(Bank_ID);
                    break;
                case "DeleteCommand":
                    Bank_ID = Convert.ToInt32(dgBank_Master.DataKeys[e.Item.ItemIndex]);
           
                    this.DeleteBank(Bank_ID);
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
                if (txtBsrcode.Text.Length != 7)
                {
                    ucMessageControl.SetMessage("Incorrect BSR Code", MessageDisplay.DisplayStyles.Error);
                    return ;
                }
                if (string.IsNullOrEmpty(hdnBank_ID.Value))
                {
                    objBAL_Bank_Master._Bank_Name = txtBank_Name.Text;
                    objBAL_Bank_Master._Bank_Branch = txtBank_Branch.Text;
                    objBAL_Bank_Master._Bsrcode = txtBsrcode.Text;
                    objBAL_Bank_Master._Company_ID = int.Parse(Session["companyid"].ToString());       // Manual Company ID

                    ds = objBAL_Bank_Master.Insert_Bank_Master();
                }
                else
                {
                    objBAL_Bank_Master._Bank_ID = Convert.ToInt32(hdnBank_ID.Value);
                    objBAL_Bank_Master._Bank_Name = txtBank_Name.Text;
                    objBAL_Bank_Master._Bank_Branch = txtBank_Branch.Text;
                    objBAL_Bank_Master._Bsrcode = txtBsrcode.Text;
                    objBAL_Bank_Master._Company_ID = int.Parse(Session["companyid"].ToString());  // Manual Company ID

                    ds = objBAL_Bank_Master.Update_Bank_Master();
                }

                if (ds.Tables[0].Rows.Count > 0)
                {
                    ucMessageControl.SetMessage("Bank has been saved successfull.", MessageDisplay.DisplayStyles.Success);
                    this.ClearValues();
                    this.ShowGrid();
                }
                else
                    ucMessageControl.SetMessage("Error occured while save Bank.", MessageDisplay.DisplayStyles.Error);

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