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
    public partial class _ManageCountry_Master : System.Web.UI.Page
    {
        CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
        BAL_Country_Master objBAL_Country_Master = new BAL_Country_Master();

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
                objBAL_Country_Master = new BAL_Country_Master();
                //objBAL_Country_Master._Nature_Type = ddlSearchNatureType.SelectedValue;

                DataSet ds = objBAL_Country_Master.Get_Country_Master_List();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    gwCountry_Master.Visible = true;
                    gwCountry_Master.DataSource = ds;
                    gwCountry_Master.DataBind();

                    lblGridMessage.Text = "";
                }
                else
                {
                    gwCountry_Master.Visible = false;
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
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        #endregion

        #region Events

        protected void gwCountry_Master_OnPageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gwCountry_Master.PageIndex = e.NewPageIndex;
            this.ShowGrid();
        }

        protected void btnSearch_OnClick(object sender, EventArgs e)
        {
            this.ShowGrid();
        }

        #endregion
    }
}