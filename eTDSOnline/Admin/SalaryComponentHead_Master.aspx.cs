using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BusinessLayer;
using DataLayer;
using System.Collections;

namespace Forms
{
    public partial class _salarycomponenthead : System.Web.UI.Page
    {
        CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
        BAL_Head_Master objBAL_HeadMaster = new BAL_Head_Master();
        BAL_Percentage_Breakup_Master objBAL_Percentage_Breakup_Master = new BAL_Percentage_Breakup_Master();
        BAL_Percentage_Master objBAL_Percentage_Master = new BAL_Percentage_Master();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["companyid"] != null)
                {
                    this.ShowGrid();

                    this.BindHeadMaster();
                    this.BindHeadTypeCombos();
                    this.grpCalculareAboveHead_OnCheckedChanged(sender, e);
                }
                else
                {
                    Response.Redirect("~/Default.aspx");
                }
            }
        }

        #region Methods


        private void BindHeadTypeCombos()
        {
            DataSet ds = objBAL_HeadMaster.Get_HeadType_List();
            CommonSettings.LoadCombo(drpSectionType, ds.Tables[0], "H_Name", "HeadType_ID", true, "(Select Head Type)");
        }
        private void BindGrid()
        {
            objBAL_HeadMaster = new BAL_Head_Master();
            objBAL_HeadMaster._Head_Group = ddlSearchGroupHead.SelectedValue.ToString();
            objBAL_HeadMaster._Company_ID = int.Parse(Session["companyid"].ToString());
            DataSet ds = objBAL_HeadMaster.Get_Head_Master_List();

            //ds.Tables[0].DefaultView.RowFilter = "Head_Group = '" + HEAD_GROUP.ADDITION.ToString().ToLower() + "'";
            if (ds.Tables[0].Rows.Count > 0)
            {
                dgHeadMaster.Visible = true;
                dgHeadMaster.DataSource = ds;
                dgHeadMaster.DataBind();

                foreach (DataGridItem item in dgHeadMaster.Items)
                {
                    item.Cells[0].Text = (item.ItemIndex + 1).ToString();
                }

                lblGridMessage.Text = "";
            }
            else
            {
                dgHeadMaster.Visible = false;
                lblGridMessage.Text = "No record found.";
            }
        }

        private void BindHeadMasterTag()
        {
            objBAL_HeadMaster._Company_ID = int.Parse(Session["companyid"].ToString());
            DataSet ds = objBAL_HeadMaster.Get_Head_Master_List();
            dgAddition.DataSource = ds;
            dgAddition.DataBind();

            if (ds.Tables[0].Rows.Count > 0)
            {
                ds.Tables[0].DefaultView.RowFilter = "Head_Group = '" + HEAD_GROUP.ADDITION.ToString() + "'";

                dgAddition.Visible = true;
                dgAddition.DataSource = ds.Tables[0].DefaultView;
                dgAddition.DataBind();

                //foreach (DataGridItem item in dgAddition.Items)
                //{
                //    item.Cells[0].Text = (item.ItemIndex + 1).ToString();
                //}

                ds.Tables[0].DefaultView.RowFilter = "Head_Group = '" + HEAD_GROUP.VARIABLE.ToString() + "'";

                dgVariable.Visible = true;
                dgVariable.DataSource = ds.Tables[0].DefaultView;
                dgVariable.DataBind();

                lblGrid.Text = "";
            }
            else
            {
                dgAddition.Visible = false;
                lblGrid.Text = "No records found";
            }

        }

        //private void BindStateCombos()
        //{
        //    DataSet ds = objBAL_HeadMaster.Get_HeadType_List ();
        //    CommonSettings.LoadCombo(drpSectionType, ds.Tables[0], "H_Name", "HeadType_ID", true, "(None of ALL)");
        //}
        private void BindHeadMaster()
        {
            objBAL_HeadMaster._Company_ID = int.Parse(Session["companyid"].ToString());
            DataSet ds = objBAL_HeadMaster.Get_Head_Master_List();
            dgAddition.DataSource = ds;
            dgAddition.DataBind();

            if (ds.Tables[0].Rows.Count > 0)
            {
                ds.Tables[0].DefaultView.RowFilter = "Head_Group = '" + HEAD_GROUP.ADDITION.ToString() + "'";

                dgAddition.Visible = true;
                dgAddition.DataSource = ds.Tables[0].DefaultView;
                dgAddition.DataBind();

                //foreach (DataGridItem item in dgAddition.Items)
                //{
                //    item.Cells[0].Text = (item.ItemIndex + 1).ToString();
                //}

                ds.Tables[0].DefaultView.RowFilter = "Head_Group = '" + HEAD_GROUP.VARIABLE.ToString() + "'";

                dgVariable.Visible = true;
                dgVariable.DataSource = ds.Tables[0].DefaultView;
                dgVariable.DataBind();

                lblGrid.Text = "";
            }
            else
            {
                dgAddition.Visible = false;
                lblGrid.Text = "No records found";
            }

        }

        private void ClearValues()
        {
            txtHeadName.Text = "";
            //chkConveyance_Type.Checked = false;

            chkManual.Checked = false;
            chkSection10.Checked = false;
            drpSectionType.SelectedIndex = 0;
            chkComputation.Checked = false;
            ddlCalculationHead.SelectedIndex = 0;
            grpCalculareAboveHead_OnCheckedChanged(null, null);
            ddlRounding_Modes.SelectedIndex = 0;
            ddlGroupHead.SelectedIndex = 1;
            ddlReport.SelectedIndex = 0;
            txtCalculatePercentage.Text = "";
            txtLimit.Text = string.Empty;
            lblHeadNameOnCalculation.Text = string.Empty;
            hdnHeadID.Value = string.Empty;
            hdnPercentage_ID.Value = string.Empty;
            this.BindHeadMaster();
        }

        private void ShowGrid()
        {
            tdGrid.Visible = true;
            btnAddNew.Visible = true;
            tdAddorEdit.Visible = false;
            tdSearch.Visible = true;
            this.ClearValues();
            this.BindGrid();
            this.BindHeadMaster();

        }

        private void HideGrid()
        {
            tdGrid.Visible = false;
            btnAddNew.Visible = false;
            tdAddorEdit.Visible = true;
            tdSearch.Visible = false;
        }

        private void FullFillValue(int intHead_ID)
        {
            try
            {
                this.HideGrid();

                Hashtable hashtable = new Hashtable();
                int intCalculation_Head_ID = 0;
                objBAL_HeadMaster._Head_ID = intHead_ID;
                objBAL_HeadMaster._Company_ID = int.Parse(Session["companyid"].ToString());
                DataSet ds = objBAL_HeadMaster.Get_Head_Master_Details();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    intCalculation_Head_ID = Convert.ToInt32(ds.Tables[0].Rows[0]["Head_ID"]);
                    hdnHeadID.Value = ds.Tables[0].Rows[0]["Head_ID"].ToString();
                    txtHeadName.Text = ds.Tables[0].Rows[0]["Head_Name"].ToString();

                    ddlGroupHead.SelectedValue = ds.Tables[0].Rows[0]["Head_Group"].ToString();
                    chkMarch.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["Mth1"]);
                    chkApril.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["Mth2"]);
                    chkMay.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["Mth3"]);
                    chkJune.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["Mth4"]);
                    chkJuly.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["Mth5"]);
                    chkAugust.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["Mth6"]);
                    chkSeptember.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["Mth7"]);
                    chkOctober.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["Mth8"]);
                    chkNovember.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["Mth9"]);
                    chkDecember.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["Mth10"]);
                    chkJanuary.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["Mth11"]);
                    chkFebruary.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["Mth12"]);
                    chkSection10.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["Section10"]);
                    //int i = Convert.ToInt32(ds.Tables[0].Rows[0]["HeadType_ID"].ToString());
                    if (Convert.ToInt32(ds.Tables[0].Rows[0]["HeadType_ID"]) > 0)
                        drpSectionType.SelectedValue = ds.Tables[0].Rows[0]["HeadType_ID"].ToString();
                    ddlRounding_Modes.SelectedValue = ds.Tables[0].Rows[0]["Rounding_Modes"].ToString();
                    chkManual.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["Manual_Entry"]);
                    ddlReport.SelectedValue = ds.Tables[0].Rows[0]["Reports_Type"].ToString();
                    chkComputation.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["Computation"]);
                    chkProjection.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["Projection"]);
                    objBAL_HeadMaster._Company_ID = int.Parse(Session["companyid"].ToString());


                    //if (ds.Tables[0].Rows[0]["Calc_Gross"].ToString() == "Normal")
                    //    rdoNormal.Checked = true;
                    //else if (ds.Tables[0].Rows[0]["Calc_Gross"].ToString() == "Percentage")
                    //    rdoPercentage.Checked = true;
                    //else
                    //    rdoGross.Checked = true;

                    ddlCalculationHead.SelectedValue = ds.Tables[0].Rows[0]["Calc_Gross"].ToString();

                    this.grpCalculareAboveHead_OnCheckedChanged(null, null);

                    objBAL_Percentage_Master._Head_ID = intHead_ID;
                    objBAL_Percentage_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                    ds = objBAL_Percentage_Master.Get_Percentage_Master_List();

                    int intPercentage_ID = 0;

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        intPercentage_ID = Convert.ToInt32(ds.Tables[0].Rows[0]["Percentage_ID"]);
                        hdnPercentage_ID.Value = intPercentage_ID.ToString();

                        //if (rdoPercentage.Checked)
                        if (ddlCalculationHead.SelectedValue == "Percentage")
                        {
                            txtCalculatePercentage.Text = ds.Tables[0].Rows[0]["Percent_Val"].ToString();

                            objBAL_Percentage_Breakup_Master._Percentage_ID = intPercentage_ID;
                            objBAL_Percentage_Breakup_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                            objBAL_Percentage_Breakup_Master._Calculation_Head_ID = intCalculation_Head_ID;
                            ds = objBAL_Percentage_Breakup_Master.Get_Percentage_Breakup_Master_List();

                            for (int index = 0; index < ds.Tables[0].Rows.Count; index++)
                            {
                                hashtable.Add(Convert.ToInt32(ds.Tables[0].Rows[index]["Head_ID"]), ds.Tables[0].Rows[index]["Head_ID"].ToString());
                            }

                            foreach (DataGridItem item in dgAddition.Items)
                            {
                                intHead_ID = Convert.ToInt32(dgAddition.DataKeys[item.ItemIndex]);
                                CheckBox chkCheckAddition = (CheckBox)item.FindControl("chkCheckAddition");

                                if (hashtable.Contains(intHead_ID))
                                    chkCheckAddition.Checked = true;
                                else
                                    chkCheckAddition.Checked = false;

                                if (intHead_ID == intCalculation_Head_ID)
                                {
                                    chkCheckAddition.Checked = false;
                                    chkCheckAddition.Enabled = false;
                                }
                            }

                            foreach (DataGridItem item in dgVariable.Items)
                            {
                                intHead_ID = Convert.ToInt32(dgVariable.DataKeys[item.ItemIndex]);
                                CheckBox chkCheckVariable = (CheckBox)item.FindControl("chkCheckVariable");

                                if (hashtable.Contains(intHead_ID))
                                    chkCheckVariable.Checked = true;
                                else
                                    chkCheckVariable.Checked = false;

                                if (intHead_ID == intCalculation_Head_ID)
                                {
                                    chkCheckVariable.Checked = false;
                                    chkCheckVariable.Enabled = false;
                                }
                            }
                        }
                        else if (ddlCalculationHead.SelectedValue == "Gross")
                        {
                            txtCalculatePercentage.Text = ds.Tables[0].Rows[0]["Percent_Val"].ToString();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        private void DeleteHead(int Head_ID)
        {
            try
            {
                objBAL_HeadMaster._Head_ID = Head_ID;
                // Check 4 data exist against this head before delete
                //DataSet ds1 = objBAL_HeadMaster.Delete_Head_Master();
                //if (ds1.Tables[0].Rows.Count > 0)
                //{
                //    ucMessageControl.SetMessage("Delete Grade First, Data Exist", MessageDisplay.DisplayStyles.Error);
                //}
                //else
                //{
                    DataSet ds = objBAL_HeadMaster.Delete_Head_Master();

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        ucMessageControl.SetMessage("Salary head has been deleted successfull.", MessageDisplay.DisplayStyles.Success);
                        this.ClearValues();
                        this.ShowGrid();
                    }
                    else
                        ucMessageControl.SetMessage("Error occured while save salary head component.", MessageDisplay.DisplayStyles.Error);
                //}
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        #endregion

        #region Events

        protected void btnSearch_OnClick(object sender, EventArgs e)
        {
            this.BindGrid();
        }

        protected void txtHeadName_OnTextChanged(object sender, EventArgs e)
        {
            try
            {
                if (txtHeadName.Text.ToLower() == "pf" || txtHeadName.Text.ToLower() == "provident fund" || txtHeadName.Text.ToLower() == "esic")
                    txtLimit.Enabled = true;
                else
                    txtLimit.Enabled = false;
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        protected void dgHeadMaster_OnItemCommand(object sender, DataGridCommandEventArgs e)
        {
            int Head_ID = 0;
            Label lblHead_Calculated_ID = (Label)e.Item.FindControl("lblHead_Calculated_ID");
            objBAL_HeadMaster._Head_Calculated_ID = int.Parse(lblHead_Calculated_ID.Text.ToString());
            switch (e.CommandName)
            {
                case "EditCommand":
                    Head_ID = Convert.ToInt32(dgHeadMaster.DataKeys[e.Item.ItemIndex]);
                    this.FullFillValue(Head_ID);
                    break;

                case "DeleteCommand":
                    Head_ID = Convert.ToInt32(dgHeadMaster.DataKeys[e.Item.ItemIndex]);

                    if (objBAL_HeadMaster._Head_Calculated_ID > 8)
                    {
                        this.DeleteHead(Head_ID);
                    }
                    else
                    {
                        ucMessageControl.SetMessage("Cannot delete default Heads", MessageDisplay.DisplayStyles.Error);
                    }
                    break;
                default:
                    break;
            }
        }

        protected void grpCalculareAboveHead_OnCheckedChanged(object sender, EventArgs e)
        {
            try
            {
                //if (rdoPercentage.Checked)

                if (ddlCalculationHead.SelectedValue == "Percentage")
                {
                    tblGrid.Visible = true;
                    dgAddition.Visible = true;
                    dgVariable.Visible = true;
                    lblHeadNameOnCalculation.Text = txtHeadName.Text;
                    lblHeadNameOnCalculationMessage.Text = " % On Percentage";
                    txtCalculatePercentage.Visible = true;
                    tblGrid.Visible = true;
                    //txtLimit.Visible = true;
                    trGrid.Visible = true;
                }
                else
                {
                    trGrid.Visible = false;
                    //txtLimit.Visible = false;

                    //if (rdoGross.Checked)
                    if (ddlCalculationHead.SelectedValue == "Gross")
                    {
                        //tblGrid.Visible = false;
                        dgAddition.Visible = false;
                        dgVariable.Visible = false;
                        lblHeadNameOnCalculation.Text = txtHeadName.Text;
                        lblHeadNameOnCalculationMessage.Text = " % On Gross Salary";
                        txtCalculatePercentage.Visible = true;
                        tblGrid.Visible = true;
                    }
                    else
                    {
                        dgAddition.Visible = false;
                        dgVariable.Visible = false;
                        lblHeadNameOnCalculation.Text = string.Empty;
                        lblHeadNameOnCalculationMessage.Text = string.Empty;
                        txtCalculatePercentage.Visible = false;
                        txtCalculatePercentage.Text = string.Empty;
                        tblGrid.Visible = false;
                    }

                    foreach (DataGridItem item in dgAddition.Items)
                    {
                        CheckBox chkCheckAddition = (CheckBox)item.FindControl("chkCheckAddition");
                        chkCheckAddition.Checked = false;
                    }

                    foreach (DataGridItem item in dgVariable.Items)
                    {
                        CheckBox chkCheckVariable = (CheckBox)item.FindControl("chkCheckVariable");
                        chkCheckVariable.Checked = false;
                    }
                }

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
                int Calculation_Head_ID = 0;
                int Percentage_ID = 0;
                string Head_IDs = "";
                double dblPercentageValue = 0;
                DataSet ds = null;

                string strCalc_Gross = "";

                if (ddlCalculationHead.SelectedValue == "Gross")
                {
                    strCalc_Gross = "Gross";
                    if (!string.IsNullOrEmpty(txtCalculatePercentage.Text))
                        dblPercentageValue = Convert.ToDouble(txtCalculatePercentage.Text);
                    else
                        dblPercentageValue = 0;
                }
                else if (ddlCalculationHead.SelectedValue == "Normal")
                {
                    strCalc_Gross = "Normal";
                }
                else if (ddlCalculationHead.SelectedValue == "Percentage")
                {
                    strCalc_Gross = "Percentage";
                    if (!string.IsNullOrEmpty(txtCalculatePercentage.Text))
                        dblPercentageValue = Convert.ToDouble(txtCalculatePercentage.Text);
                    else
                        dblPercentageValue = 0;
                }

                objBAL_HeadMaster._Head_Name = txtHeadName.Text;
                objBAL_HeadMaster._Head_Group = ddlGroupHead.SelectedItem.Text;
                objBAL_HeadMaster._Mth1 = chkMarch.Checked;
                objBAL_HeadMaster._Mth2 = chkApril.Checked;
                objBAL_HeadMaster._Mth3 = chkMay.Checked;
                objBAL_HeadMaster._Mth4 = chkJune.Checked;
                objBAL_HeadMaster._Mth5 = chkJuly.Checked;
                objBAL_HeadMaster._Mth6 = chkAugust.Checked;
                objBAL_HeadMaster._Mth7 = chkSeptember.Checked;
                objBAL_HeadMaster._Mth8 = chkOctober.Checked;
                objBAL_HeadMaster._Mth9 = chkNovember.Checked;
                objBAL_HeadMaster._Mth10 = chkDecember.Checked;
                objBAL_HeadMaster._Mth11 = chkJanuary.Checked;
                objBAL_HeadMaster._Mth12 = chkFebruary.Checked;
                objBAL_HeadMaster._Section10 = chkSection10.Checked;
                if (!string.IsNullOrEmpty(drpSectionType.SelectedValue))
                {
                    objBAL_HeadMaster._Head_Type_ID = Convert.ToInt32(drpSectionType.SelectedValue);
                }
                else
                {
                    objBAL_HeadMaster._Head_Type_ID = 0;
                }
                objBAL_HeadMaster._Rounding_Modes = Convert.ToInt32(ddlRounding_Modes.SelectedValue);
                objBAL_HeadMaster._Calc_Gross = strCalc_Gross;
                objBAL_HeadMaster._Manual_Entry = chkManual.Checked;
                objBAL_HeadMaster._Reports_Type = Convert.ToInt32(ddlReport.SelectedValue);
                objBAL_HeadMaster._Computation = chkComputation.Checked;
                objBAL_HeadMaster._Projection = chkProjection.Checked;
                objBAL_HeadMaster._Company_ID = int.Parse(Session["companyid"].ToString());

                if (string.IsNullOrEmpty(hdnHeadID.Value))
                {
                    ds = objBAL_HeadMaster.Insert_Head_Master();
                }
                else
                {
                    objBAL_HeadMaster._Head_ID = Convert.ToInt32(hdnHeadID.Value);

                    ds = objBAL_HeadMaster.Update_Head_Master();
                }

                Calculation_Head_ID = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

                //if (!rdoNormal.Checked)     // if not normal then save in percentage and percentage breakup
                if (ddlCalculationHead.SelectedValue != "Normal")
                {
                    objBAL_Percentage_Master._Head_ID = Calculation_Head_ID;
                    objBAL_Percentage_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                    objBAL_Percentage_Master._Percent_Val = dblPercentageValue;

                    if (string.IsNullOrEmpty(hdnHeadID.Value))
                    {
                        ds = objBAL_Percentage_Master.Insert_Percentage_Master();
                    }
                    else
                    {
                        if (!string.IsNullOrEmpty(hdnPercentage_ID.Value))
                        {
                            objBAL_Percentage_Master._Percentage_ID = Convert.ToInt32(hdnPercentage_ID.Value);
                            ds = objBAL_Percentage_Master.Update_Percentage_Master();
                        }
                        else
                        {
                            ds = objBAL_Percentage_Master.Insert_Percentage_Master();
                        }

                    }

                    Percentage_ID = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

                    //if (rdoPercentage.Checked)  // if percentage only then save in percentage breakup
                    if (ddlCalculationHead.SelectedValue == "Percentage")
                    {
                        int Head_ID = 0;

                        if (dgAddition.Items.Count > 0)
                        {
                            foreach (DataGridItem item in dgAddition.Items)
                            {
                                Head_ID = Convert.ToInt32(dgAddition.DataKeys[item.ItemIndex]);
                                CheckBox chkCheck = (CheckBox)item.FindControl("chkCheckAddition");

                                if (chkCheck.Checked)
                                {
                                    Head_IDs = Head_IDs + Head_ID.ToString() + ",";
                                }
                            }
                        }

                        if (dgVariable.Items.Count > 0)
                        {
                            foreach (DataGridItem item in dgVariable.Items)
                            {
                                Head_ID = Convert.ToInt32(dgVariable.DataKeys[item.ItemIndex]);
                                CheckBox chkCheck = (CheckBox)item.FindControl("chkCheckVariable");

                                if (chkCheck.Checked)
                                {
                                    Head_IDs = Head_IDs + Head_ID.ToString() + ",";
                                }
                            }
                        }

                        Head_IDs = CommonSettings.RemoveLastCharacter(Head_IDs);

                        if (!string.IsNullOrEmpty(Head_IDs))
                        {
                            objBAL_Percentage_Breakup_Master._Percentage_ID = Percentage_ID;
                            objBAL_Percentage_Breakup_Master._Head_IDs = Head_IDs;
                            objBAL_Percentage_Breakup_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                            objBAL_Percentage_Breakup_Master._Calculation_Head_ID = Calculation_Head_ID;
                            //objBAL_Percentage_Breakup_Master._State_ID = 90;
                            ds = objBAL_Percentage_Breakup_Master.Insert_Update_Percentage_Breakup_Master();
                        }
                    }

                }
                else
                {
                    //objBAL_Percentage_Breakup_Master._Percentage_ID = Convert.ToInt32(hdnPercentage_ID.Value);
                    //ds = objBAL_Percentage_Breakup_Master.Delete_Percentage_Breakup_Master_By_Percentage_ID();

                    //objBAL_Percentage_Master._Percentage_ID = Convert.ToInt32(hdnPercentage_ID.Value);
                    //ds = objBAL_Percentage_Master.Delete_Percentage_Master();
                }

                if (ds.Tables[0].Rows.Count > 0)
                {
                    ucMessageControl.SetMessage("Salary head component type has been saved successfull.", MessageDisplay.DisplayStyles.Success);
                    this.ClearValues();
                    this.ShowGrid();
                }
                else
                    ucMessageControl.SetMessage("Error occured while save salary head component.", MessageDisplay.DisplayStyles.Error);
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

        protected void btnCancel_OnClick(object sender, EventArgs e)
        {
            this.ShowGrid();
        }

        protected void btnAddNew_OnClick(object sender, EventArgs e)
        {
            this.HideGrid();
        }

        protected void dgVariable_OnItemCommand(object sender, DataGridCommandEventArgs e)
        {

        }

        protected void dgAddition_OnItemCommand(object sender, DataGridCommandEventArgs e)
        {
            //int EmployeeID = 0;

            //switch (e.CommandName)
            //{
            //    case "EditCommand":
            //        EmployeeID = Utils.N2Int(dgEmployee.DataKeys[e.Item.ItemIndex]);
            //        this.FullFillValue(EmployeeID);
            //        break;
            //    case "DeleteCommand":
            //        EmployeeID = Utils.N2Int(dgEmployee.DataKeys[e.Item.ItemIndex]);
            //        this.DeleteEmployee(EmployeeID);
            //        break;
            //    default:
            //        break;
            //}
        }
        #endregion
    }
}
