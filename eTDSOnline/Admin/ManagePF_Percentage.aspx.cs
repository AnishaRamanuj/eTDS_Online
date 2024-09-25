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
    public partial class _ManagePF_Percentage : System.Web.UI.Page
    {
        CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
        BAL_PF_Percentage_Master objBAL_PF_Percentage_Master = new BAL_PF_Percentage_Master();

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
                this.BindVariable();
                this.FullFillValue();
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
                objBAL_PF_Percentage_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                objBAL_PF_Percentage_Master._Head_Group = HEAD_GROUP.ADDITION.ToString();

                DataSet ds = objBAL_PF_Percentage_Master.Get_Head_Master_List();

                gwAddition.DataSource = ds;
                gwAddition.DataBind();

            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        private void BindVariable()
        {
            try
            {
                objBAL_PF_Percentage_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                objBAL_PF_Percentage_Master._Head_Group = HEAD_GROUP.VARIABLE.ToString();

                DataSet ds = objBAL_PF_Percentage_Master.Get_Head_Master_List();

                gwVariable.DataSource = ds;
                gwVariable.DataBind();

            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        private void FullFillValue()
        {
            try
            {
                int Calculation_Head_ID = 0;
                int Percentage_ID = 0;
                int Head_ID = 0;

                objBAL_PF_Percentage_Master = new BAL_PF_Percentage_Master();
                objBAL_PF_Percentage_Master._Head_Calculated_ID = 5;    // PF id manual
                objBAL_PF_Percentage_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                DataSet ds = objBAL_PF_Percentage_Master.Get_Head_Master_List();

                Calculation_Head_ID = Convert.ToInt32(ds.Tables[0].Rows[0]["Head_ID"]);

                objBAL_PF_Percentage_Master = new BAL_PF_Percentage_Master();
                objBAL_PF_Percentage_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                ds = objBAL_PF_Percentage_Master.Get_Providend_Fund_Details();

                if (ds.Tables[0].Rows.Count > 0)
                    txtPFLimit.Text = ds.Tables[0].Rows[0]["PF_Limit"].ToString();

                Hashtable hashtable = new Hashtable();

                objBAL_PF_Percentage_Master = new BAL_PF_Percentage_Master();
                objBAL_PF_Percentage_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                objBAL_PF_Percentage_Master._Head_ID = Calculation_Head_ID;
                ds = objBAL_PF_Percentage_Master.Get_Percentage_Master_List();

                if (ds.Tables[0].Rows.Count >= 1)
                {
                    Percentage_ID = Convert.ToInt32(ds.Tables[0].Rows[0]["Percentage_ID"]);
                    hdnPercentage_ID.Value = Percentage_ID.ToString();
                    txtPFPercentage.Text = ds.Tables[0].Rows[0]["Percent_Val"].ToString();

                    objBAL_PF_Percentage_Master = new BAL_PF_Percentage_Master();
                    objBAL_PF_Percentage_Master._Percentage_ID = Percentage_ID;
                    objBAL_PF_Percentage_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                    objBAL_PF_Percentage_Master._Calculation_Head_ID = 5;
                    ds = objBAL_PF_Percentage_Master.Get_Percentage_Breakup_Master_List();

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        for (int index = 0; index < ds.Tables[0].Rows.Count; index++)
                        {
                            if (!hashtable.Contains(Convert.ToInt32(ds.Tables[0].Rows[index]["Head_ID"])))
                                hashtable.Add(Convert.ToInt32(ds.Tables[0].Rows[index]["Head_ID"]), ds.Tables[0].Rows[index]["Head_ID"].ToString());
                        }

                        foreach (GridViewRow item in gwAddition.Rows)
                        {
                            CheckBox chkCheckAddition = (CheckBox)item.FindControl("chkCheckAddition");
                            Head_ID = Convert.ToInt32(gwAddition.DataKeys[item.RowIndex].Value);

                            if (hashtable.Contains(Head_ID))
                                chkCheckAddition.Checked = true;
                            else
                                chkCheckAddition.Checked = false;

                            if (Head_ID == Calculation_Head_ID)
                            {
                                chkCheckAddition.Checked = false;
                                chkCheckAddition.Enabled = false;
                            }
                        }

                        foreach (GridViewRow item in gwVariable.Rows)
                        {
                            CheckBox chkCheckVariable = (CheckBox)item.FindControl("chkCheckVariable");
                            Head_ID = Convert.ToInt32(gwVariable.DataKeys[item.RowIndex].Value);

                            if (hashtable.Contains(Head_ID))
                                chkCheckVariable.Checked = true;
                            else
                                chkCheckVariable.Checked = false;

                            if (Head_ID == Calculation_Head_ID)
                            {
                                chkCheckVariable.Checked = false;
                                chkCheckVariable.Enabled = false;
                            }
                        }
                    }
                }
                //else
                //    throw new Exception("Multiple value in percentage");
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
                int Calculation_Head_ID = 0;
                int Percentage_ID = 0;

                int Head_ID = 0;
                string Head_IDs = "";
                DataSet ds = null;

                objBAL_PF_Percentage_Master = new BAL_PF_Percentage_Master();
                objBAL_PF_Percentage_Master._Head_Calculated_ID = 5;    // PF id manual
                objBAL_PF_Percentage_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                ds = objBAL_PF_Percentage_Master.Get_Head_Master_List();

                Calculation_Head_ID = Convert.ToInt32(ds.Tables[0].Rows[0]["Head_ID"]);

                objBAL_PF_Percentage_Master = new BAL_PF_Percentage_Master();
                objBAL_PF_Percentage_Master._Head_ID = Calculation_Head_ID;
                objBAL_PF_Percentage_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                objBAL_PF_Percentage_Master._Percent_Val = Convert.ToDouble(txtPFPercentage.Text);

                if (!string.IsNullOrEmpty(hdnPercentage_ID.Value))
                {
                    objBAL_PF_Percentage_Master._Percentage_ID = Convert.ToInt32(hdnPercentage_ID.Value);
                    ds = objBAL_PF_Percentage_Master.Update_Percentage_Master();
                }
                else
                {
                    ds = objBAL_PF_Percentage_Master.Insert_Percentage_Master();
                }

                Percentage_ID = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

                objBAL_PF_Percentage_Master = new BAL_PF_Percentage_Master();
                objBAL_PF_Percentage_Master._PF_Percentage = Convert.ToDouble(txtPFPercentage.Text);
                objBAL_PF_Percentage_Master._PF_Limit = Convert.ToDouble(txtPFLimit.Text);
                objBAL_PF_Percentage_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                ds = objBAL_PF_Percentage_Master.Insert_Update_Providend_Fund();

                foreach (GridViewRow item in gwAddition.Rows)
                {
                    CheckBox chkCheckAddition = (CheckBox)item.FindControl("chkCheckAddition");
                    Head_ID = Convert.ToInt32(gwAddition.DataKeys[item.RowIndex].Value);

                    if (chkCheckAddition.Checked)
                    {
                        Head_IDs = Head_IDs + Head_ID.ToString() + ",";
                    }
                }

                foreach (GridViewRow item in gwVariable.Rows)
                {
                    CheckBox chkCheckVariable = (CheckBox)item.FindControl("chkCheckVariable");
                    Head_ID = Convert.ToInt32(gwVariable.DataKeys[item.RowIndex].Value);

                    if (chkCheckVariable.Checked)
                    {
                        Head_IDs = Head_IDs + Head_ID.ToString() + ",";
                    }
                }

                if (Head_IDs != "")
                    Head_IDs = CommonSettings.RemoveLastCharacter(Head_IDs);

                objBAL_PF_Percentage_Master = new BAL_PF_Percentage_Master();
                objBAL_PF_Percentage_Master._Percentage_ID = Percentage_ID;
                objBAL_PF_Percentage_Master._Head_IDs = Head_IDs;
                objBAL_PF_Percentage_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                objBAL_PF_Percentage_Master._Calculation_Head_ID = 5;
                //objBAL_Percentage_Breakup_Master._State_ID = 90;
                ds = objBAL_PF_Percentage_Master.Insert_Update_Percentage_Breakup_Master();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    ucMessageControl.SetMessage("PF Percentage has been saved successfull.", MessageDisplay.DisplayStyles.Success);
                    this.ShowGrid();
                }
                else
                    ucMessageControl.SetMessage("Error occured while save PF Percentage.", MessageDisplay.DisplayStyles.Error);

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