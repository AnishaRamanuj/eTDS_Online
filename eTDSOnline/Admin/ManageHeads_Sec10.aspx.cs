using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLayer;
using DataLayer;
using System.Data;
using System.Collections;

namespace Forms
{
    public partial class _ManageHeads_Sec10 : System.Web.UI.Page
    {
        CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
        BAL_Heads_Sec10 objBAL_Heads_Sec10 = new BAL_Heads_Sec10();

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
                this.BindAddition();
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        private void BindAddition()
        {
            try
            {
                objBAL_Heads_Sec10._Company_ID = int.Parse(Session["companyid"].ToString());
                objBAL_Heads_Sec10._Head_Group = HEAD_GROUP.ADDITION.ToString();

                DataSet ds = objBAL_Heads_Sec10.Get_Head_Master_List();

                gwHeads.DataSource = ds;
                gwHeads.DataBind();

            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        #endregion

        #region Events

        protected void btnSave_OnClick(object sender, EventArgs e)
        {
            try
            {
                int Head_ID = 0;
                string Head_IDs = "";
                DataSet ds = null;

                objBAL_Heads_Sec10._Company_ID = int.Parse(Session["companyid"].ToString());

                foreach (GridViewRow item in gwHeads.Rows)
                {
                    CheckBox chkCheckAddition = (CheckBox)item.FindControl("chkCheckAddition");
                    Head_ID = Convert.ToInt32(gwHeads.DataKeys[item.RowIndex].Value);

                    if (chkCheckAddition.Checked)
                    {
                        Head_IDs = Head_IDs + Head_ID.ToString() + ",";
                    }
                }

                if (Head_IDs != "")
                    Head_IDs = CommonSettings.RemoveLastCharacter(Head_IDs);

                //if (!string.IsNullOrEmpty(Head_IDs))
                {
                    objBAL_Heads_Sec10._Head_IDs = Head_IDs;
                    objBAL_Heads_Sec10._Company_ID = int.Parse(Session["companyid"].ToString());
                    ds = objBAL_Heads_Sec10.Update_Heads_Sec10();
                }

                if (ds.Tables[0].Rows.Count > 0)
                {
                    ucMessageControl.SetMessage("Heads Sec10 has been saved successfull.", MessageDisplay.DisplayStyles.Success);
                    this.ShowGrid();
                }
                else
                    ucMessageControl.SetMessage("Error occured while save Heads Sec10.", MessageDisplay.DisplayStyles.Error);

            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        protected void btnSearch_OnClick(object sender, EventArgs e)
        {
            this.ShowGrid();
        }

        #endregion
    }
}