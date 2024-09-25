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
    public partial class _ManageHRA_Rent_Receipt : System.Web.UI.Page
    {
        CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
        BAL_Employee_Master objBAL_Employee_Master = new BAL_Employee_Master();
        BAL_HRA_Rent_Receipt objBAL_HRA_Rent_Receipt = new BAL_HRA_Rent_Receipt();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.BindEmployeeGrid();
                //this.ShowGrid();
            }
        }

        #region Methods

        private void BindEmployeeGrid()
        {
            try
            {
                objBAL_Employee_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                objBAL_Employee_Master._FirstName = txtFirstName.Text;
                DataSet ds = objBAL_Employee_Master.Get_Employee_Master_List();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    dgEmployee.Visible = true;
                    dgEmployee.DataSource = ds.Tables[0];
                    dgEmployee.DataBind();

                    lblEmployeeGrideMessage.Text = "";
                }
                else
                {
                    dgEmployee.Visible = false;
                    lblEmployeeGrideMessage.Text = "No record found.";
                }
                tdHRAGrid.Visible = false;
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        private void BindHRAGrid(int Employee_ID)
        {
            try
            {
                //objBAL_HRA_Rent_Receipt = new BAL_HRA_Rent_Receipt();
                objBAL_HRA_Rent_Receipt._Company_ID = int.Parse(Session["companyid"].ToString());
                objBAL_HRA_Rent_Receipt._Employee_ID = Employee_ID;

                DataSet ds = objBAL_HRA_Rent_Receipt.Get_HRA_Rent_Receipt_List();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    lblEmployeeName.Text = ds.Tables[0].Rows[0]["FirstName"].ToString();

                    dgHRA_Rent_Receipt.Visible = true;
                    dgHRA_Rent_Receipt.DataSource = ds;
                    dgHRA_Rent_Receipt.DataBind();

                    lblGridMessage.Text = "";
                }
                else
                {
                    dgHRA_Rent_Receipt.Visible = false;
                    lblGridMessage.Text = "No record found.";
                }
                tdHRAGrid.Visible = true;
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
                hdnHRA_Rent_Receipt_ID.Value = "";
                
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
                //this.BindGrid();
                tdGrid.Visible = true;
                tblHraRantReceipt.Visible = false;
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
                tblHraRantReceipt.Visible = true;
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        #endregion

        #region Events

        protected void dgEmployee_OnItemCommand(object sender, DataGridCommandEventArgs e)
        {
            int Employee_ID = 0;

            switch (e.CommandName)
            {
                case "hracommand":
                    Employee_ID = Convert.ToInt32(dgEmployee.DataKeys[e.Item.ItemIndex]);
                    hbnEmployee_ID.Value = Employee_ID.ToString();
                    this.BindHRAGrid(Employee_ID);

                    break;
                default:
                    break;
            }
        }

        protected void dgEmployee_PageIndexChanged(object sender, DataGridPageChangedEventArgs e)
        {
            dgEmployee.CurrentPageIndex = e.NewPageIndex;
            this.BindEmployeeGrid();
        }

        protected void dgHRA_Rent_Receipt_OnItemCommand(object sender, DataGridCommandEventArgs e)
        {
            //int HRA_Rent_Receipt_ID = 0;

            //switch (e.CommandName)
            //{
            //    case "EditCommand":
            //        HRA_Rent_Receipt_ID = Convert.ToInt32(dgHRA_Rent_Receipt.DataKeys[e.Item.ItemIndex]);
            //        this.FullFillValue(HRA_Rent_Receipt_ID);
            //        break;
            //    case "DeleteCommand":
            //        HRA_Rent_Receipt_ID = Convert.ToInt32(dgHRA_Rent_Receipt.DataKeys[e.Item.ItemIndex]);
            //        this.DeleteHRA_Rent_Receipt(HRA_Rent_Receipt_ID);
            //        break;
            //    default:
            //        break;
            //}
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

        protected void btnSearch_OnClick(object sender, EventArgs e)
        {
            try
            {
                dgEmployee.CurrentPageIndex = 0;
                this.BindEmployeeGrid();
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
                int HRA_Rent_Receipt_ID = 0;
                foreach (DataGridItem item in dgHRA_Rent_Receipt.Items)
                {

                    HRA_Rent_Receipt_ID = Convert.ToInt32(dgHRA_Rent_Receipt.DataKeys[item.ItemIndex]);

                    TextBox txtAmount = (TextBox)item.FindControl("txtAmount");
                    Label lblMonthName = (Label)item.FindControl("lblMonthName");
                    Label lblMonthNo = (Label)item.FindControl("lblMonthNo");

                    objBAL_HRA_Rent_Receipt._HRA_Rent_Receipt_ID = HRA_Rent_Receipt_ID;
                    objBAL_HRA_Rent_Receipt._Company_ID = int.Parse(Session["companyid"].ToString());
                    objBAL_HRA_Rent_Receipt._Amount = Convert.ToDouble(txtAmount.Text);
                    objBAL_HRA_Rent_Receipt._Employee_ID = Convert.ToInt32(hbnEmployee_ID.Value);
                    objBAL_HRA_Rent_Receipt._Month_No = Convert.ToInt32(lblMonthNo.Text);
                    objBAL_HRA_Rent_Receipt._Month_Name = lblMonthName.Text;

                    ds = objBAL_HRA_Rent_Receipt.Update_HRA_Rent_Receipt();
                }

                if (ds.Tables[0].Rows.Count > 0)
                {
                    ucMessageControl.SetMessage("Hra Rent Receipt has been saved successfull.", MessageDisplay.DisplayStyles.Success);
                    tdHRAGrid.Visible = false;
                    //this.ClearValues();
                    //this.ShowGrid();
                }
                else
                    ucMessageControl.SetMessage("Error occured while save hra Rent Receipt.", MessageDisplay.DisplayStyles.Error);

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