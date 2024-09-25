using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using PANVrf;
using System.Drawing;
using BusinessLayer;
using System.Threading;

public partial class Admin_Deductee_Master : System.Web.UI.Page
{
    CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
    BAL_Deductee_Master objBAL_Deductee_Master = new BAL_Deductee_Master();
    DataSet ds;
    int result = 0;
    Boolean ErrPan = false;
    ConnectTraces CT = new ConnectTraces();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            this.BindDropDown();
            this.ShowGrid();
            //chk_IsPayeeNri.Enabled = false;
            //drp_Country.Enabled = false;
            //drp_TdsRateNRI.Enabled = false;
            //// PayeeIndividual.Visible = false;
            //chk_PayeeIndividual.Enabled = false;
            //txt_TDSRate.Enabled = false;
            //txt_SurCharge.Enabled = false;
        }
    }


    #region BindALLDropDown
    protected void BindDropDown()
    {
        try
        {
            try
            {
                objBAL_Deductee_Master.Company_ID = int.Parse(Session["companyid"].ToString());
                ds = objBAL_Deductee_Master.BAL_BindDropDown();
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
            drp_Branch.Items.Clear();
            //while (drp_Branch.Items.Count > 0)
            //    drp_Branch.Items.RemoveAt(0);
            #region State DropDown
            if (ds.Tables[0].Rows.Count > 0)
            {
                drp_State.DataSource = ds.Tables[0];
                drp_State.DataTextField = "State_Name";
                drp_State.DataValueField = "State_ID";
                drp_State.DataBind();
            }
            #endregion

            #region Branch DropDown
            if (ds.Tables[1].Rows.Count > 0)
            {
                drp_Branch.DataSource = ds.Tables[1];
                drp_Branch.DataTextField = "Branch_Name";
                drp_Branch.DataValueField = "Branch_ID";
                drp_Branch.DataBind();

            }
            #endregion

            #region Nature DropDown
            if (ds.Tables[2].Rows.Count > 0)
            {
                drp_Nature.DataSource = ds.Tables[2];
                drp_Nature.DataTextField = "Nature_Name";
                drp_Nature.DataValueField = "Nature_ID";
                drp_Nature.DataBind();

            }
            #endregion

            #region Country DropDown
            if (ds.Tables[3].Rows.Count > 0)
            {
                drp_Country.DataSource = ds.Tables[3];
                drp_Country.DataTextField = "Country_Name";
                drp_Country.DataValueField = "Country_ID";
                drp_Country.DataBind();
            }
            #endregion


            drp_State.Items.Insert(0, new ListItem("(Select State)", "0"));
            drp_Branch.Items.Insert(0, new ListItem("(Select Branch)", "0"));
            drp_Nature.Items.Insert(0, new ListItem("(Select Nature)", "0"));
            drp_Country.Items.Insert(0, new ListItem("(Select Country)", "0"));
            if (txt_PanNo.Text == "")
            {
                drp_Reasons.SelectedValue = "Non-Availability of PAN C";
            }
        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex);
            ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
        }

    }
    #endregion
    protected void btnAddNew_OnClick(object sender, EventArgs e)
    {
        this.HideGrid();
        hdnDeducteeID.Value = "";
        ScriptManager.RegisterStartupScript(this, typeof(Page), "Focus", "document.getElementById(\"" + txt_Name.ClientID.ToString() + "\").focus();", true);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "Alltogo();", true);
    }
    #region Save Button For Insert & Update
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            bool isTrue = true;
            if (hdnDeducteeID.Value == "")
            {
                objBAL_Deductee_Master.Deductee_Name = txt_Name.Text;
                objBAL_Deductee_Master.Company_ID = int.Parse(Session["companyid"].ToString());
                ds = objBAL_Deductee_Master.BAL_CheckDuplicateDeducteeName();
                if (ds.Tables[0].Rows.Count > 0)
                {
                    lblduplicateError.Text = "Deductee Name Already Exist ! Please Change Decuctee Name !";
                    lblduplicateError.ForeColor = Color.Red;
                    isTrue = false;
                }
            }
            if (isTrue)
            {
                lblduplicateError.Text = "";
                objBAL_Deductee_Master.Company_ID = int.Parse(Session["companyid"].ToString());
                objBAL_Deductee_Master.Deductee_Name = txt_Name.Text;
                objBAL_Deductee_Master.Alias = "";

                objBAL_Deductee_Master.Flat_NO = txt_FlatNo.Text;
                objBAL_Deductee_Master.Bldg_Name = txt_BldgName.Text;
                objBAL_Deductee_Master.Alias = txt_Alias.Text;
                objBAL_Deductee_Master.Street = txt_Street.Text;
                objBAL_Deductee_Master.City = txt_City.Text;
                objBAL_Deductee_Master.State_ID = Convert.ToInt32(drp_State.SelectedValue);

                if (txt_PinCode.Text == "")
                { }
                else
                {
                    objBAL_Deductee_Master.Pincode = Convert.ToInt32(txt_PinCode.Text);
                }
                if (drp_Branch.SelectedValue == "0")
                {
                    objBAL_Deductee_Master.Branch_ID = 0;
                }
                else
                {
                    objBAL_Deductee_Master.Branch_ID = Convert.ToInt32(drp_Branch.SelectedValue);
                }
                objBAL_Deductee_Master.Email = txt_Email.Text;
                objBAL_Deductee_Master.ContactNo = txtContact.Text;
                objBAL_Deductee_Master.Mobile_No = txt_MobileNo.Text;
                objBAL_Deductee_Master.Nature_ID = Convert.ToInt32(drp_Nature.SelectedValue);
                objBAL_Deductee_Master.Deductee_Type = drp_Type.SelectedItem.Text;
                if (drp_Type.SelectedValue == "Others")
                {
                    objBAL_Deductee_Master.IS_Individual = Convert.ToBoolean(Convert.ToInt32(hdnCheckindivisulchecked.Value));
                }
                objBAL_Deductee_Master.Multi_Company = Convert.ToBoolean(chk_ApplicationToAll.Checked ? 1 : 0);

                if (txt_PanNo.Text == "")
                {
                    objBAL_Deductee_Master.Reasons = "Non-Availability of PAN C";
                    objBAL_Deductee_Master.PAN_NO = "PANNOTAVBL";
                }
                else
                {
                    if (txt_PanNo.Text == "PANNOTAVBL")
                        objBAL_Deductee_Master.Reasons = "Non-Availability of PAN C";
                    else
                        objBAL_Deductee_Master.Reasons = drp_Reasons.SelectedValue;

                    objBAL_Deductee_Master.PAN_NO = txt_PanNo.Text.ToUpper();
                }
                objBAL_Deductee_Master.Certificate_NO = txt_Certificate.Text;
                if (drp_State.SelectedValue == "99")
                {
                    objBAL_Deductee_Master.IS_NRI = true;
                    objBAL_Deductee_Master.Country_ID = Convert.ToInt32(drp_Country.SelectedValue);
                    objBAL_Deductee_Master.NRI_TDS_Rate = drp_TdsRateNRI.SelectedValue;
                    objBAL_Deductee_Master.TDS_Rate = 0;
                    objBAL_Deductee_Master.Surcharge = 0;
                    objBAL_Deductee_Master.TDS_Rate_From = "0";

                }
                else
                {
                    objBAL_Deductee_Master.IS_NRI = false;
                    objBAL_Deductee_Master.Country_ID = 0;
                    objBAL_Deductee_Master.NRI_TDS_Rate = "";
                }
                objBAL_Deductee_Master.TDS_Rate_From = radio_TDSRateFrom.SelectedValue;
                if (hdnRadiovalue.Value == "1")
                {
                    if (txt_TDSRate.Text == "")
                    { }
                    else
                    {
                        objBAL_Deductee_Master.TDS_Rate = Convert.ToDouble(txt_TDSRate.Text);
                    }
                    if (txt_SurCharge.Text == "")
                    { }
                    else
                    {
                        objBAL_Deductee_Master.Surcharge = Convert.ToDouble(txt_SurCharge.Text);
                    }
                    objBAL_Deductee_Master.TDS_Rate_From = "1";
                }
                else
                {
                    objBAL_Deductee_Master.TDS_Rate = 0;
                    objBAL_Deductee_Master.Surcharge = 0;
                    objBAL_Deductee_Master.TDS_Rate_From = "0";
                }
                objBAL_Deductee_Master.TaxIdentificationNo = txtTaxIdentificationno.Text;
                objBAL_Deductee_Master.Nature_Sub_ID = drp_Nature.SelectedValue;
                if (hdnDeducteeID.Value == "")
                {
                    objBAL_Deductee_Master.Deductee_ID = 0;
                }
                else
                {
                    objBAL_Deductee_Master.Deductee_ID = Convert.ToInt32(hdnDeducteeID.Value);
                }
                if (lblPanVerified.Text == "")
                { objBAL_Deductee_Master.PANVerified = "PAN Not Available"; }
                else
                {
                    objBAL_Deductee_Master.PANVerified = lblPanVerified.Text;
                }

                result = objBAL_Deductee_Master.BAL_InsertDetucteeDetails();
                if (result > 0)
                {
                    ucMessageControl.SetMessage("Submitted Successfully....", MessageDisplay.DisplayStyles.Success);
                    hdnDeducteeID.Value = "";
                    this.BindDropDown();
                    this.ShowGrid();
                    this.Clear();
                    hdnRadiovalue.Value = "";
                    hdnRadiovalue1.Value = "";
                }
            }
        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex);
            ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
        }
    }
    #endregion

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        this.ShowGrid();
        this.Clear();
    }

    #region Bind Deductee Grid
    protected void BindGrid()
    {
        try
        {
            dgDetucteeGrid.DataSource = null;
            dgDetucteeGrid.DataBind();

            objBAL_Deductee_Master.Deductee_Name = txtSearchName.Text;

            objBAL_Deductee_Master.Alias = "";

            if (ddlSearchPAN.SelectedValue != "0")
                objBAL_Deductee_Master.PANVerified = ddlSearchPAN.SelectedValue.Trim();
            else
                objBAL_Deductee_Master.PANVerified = "";

            if (ddlSearchReasons.SelectedValue != "0")
                objBAL_Deductee_Master.Reasons = ddlSearchReasons.SelectedValue.Trim();
            else
                objBAL_Deductee_Master.Reasons = "";

            objBAL_Deductee_Master.Company_ID = int.Parse(Session["companyid"].ToString());
            ds = objBAL_Deductee_Master.BAL_BindDetucteeGridOnSearch();

            if (ds.Tables[0].Rows.Count > 0)
            {
                dgDetucteeGrid.DataSource = ds.Tables[0];
                dgDetucteeGrid.AllowPaging = true;
                dgDetucteeGrid.DataBind();
                lblGridMessage.Text = "";
            }
            else
            {
                dgDetucteeGrid.DataSource = null;
                dgDetucteeGrid.DataBind();
                lblGridMessage.Text = "No Record Found !";
                lblGridMessage.ForeColor = Color.Red;
            }
        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex);
            ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
        }

    }
    #endregion
    protected void dgDetucteeGrid_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
    {
        dgDetucteeGrid.CurrentPageIndex = e.NewPageIndex;
        this.BindGrid();
    }
    #region Data Grid Item Command
    protected void dgDetucteeGrid_ItemCommand(object source, DataGridCommandEventArgs e)
    {
        try
        {
            switch (e.CommandName)
            {
                case "EditCommand":
                    hdnDeducteeID.Value = e.CommandArgument.ToString();
                    dgDetucteeGrid_ItemCommand_Edit(Convert.ToInt32(e.CommandArgument));
                    //Convert.ToInt32(dgEmployee.DataKeys[e.Item.ItemIndex]);
                    break;
                case "DeleteCommand":
                    dgDetucteeGrid_ItemCommand_Delete(Convert.ToInt32(e.CommandArgument));
                    break;
                default:
                    break;
            }
        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex);
            ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);

        }

    }
    #endregion

    #region Edit
    protected void dgDetucteeGrid_ItemCommand_Edit(int DeducteeID)
    {
        try
        {
            this.HideGrid();
            this.Clear();
            objBAL_Deductee_Master.Deductee_ID = DeducteeID;
            ds = objBAL_Deductee_Master.BAL_GetDeducteeEditDetails();
            if (ds.Tables[0].Rows.Count > 0)
            {
                txt_Name.Text = ds.Tables[0].Rows[0]["Deductee_Name"].ToString();
                txt_PanNo.Text = ds.Tables[0].Rows[0]["PAN_NO"].ToString().ToUpper();
                txt_FlatNo.Text = ds.Tables[0].Rows[0]["Flat_NO"].ToString();
                txt_BldgName.Text = ds.Tables[0].Rows[0]["Bldg_Name"].ToString();
                txt_Alias.Text = ds.Tables[0].Rows[0]["Alias"].ToString();
                txt_Street.Text = ds.Tables[0].Rows[0]["Street"].ToString();
                txt_City.Text = ds.Tables[0].Rows[0]["City"].ToString();
                drp_State.SelectedValue = ds.Tables[0].Rows[0]["State_ID"].ToString();
                string pincode = ds.Tables[0].Rows[0]["Pincode"].ToString();
                if (pincode != "0")
                {
                    txt_PinCode.Text = pincode;
                }
                drp_Branch.SelectedValue = ds.Tables[0].Rows[0]["Branch_ID"].ToString();
                txt_Email.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                txtContact.Text = ds.Tables[0].Rows[0]["ContactNo"].ToString();
                string mobileno = ds.Tables[0].Rows[0]["Mobile_No"].ToString();
                if (mobileno != "0")
                {
                    txt_MobileNo.Text = mobileno;
                }
                drp_Nature.SelectedValue = ds.Tables[0].Rows[0]["Nature_ID"].ToString();
                drp_Type.SelectedValue = ds.Tables[0].Rows[0]["Deductee_Type"].ToString();
                chk_PayeeIndividual.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["IS_Individual"].ToString());
                chk_ApplicationToAll.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["Multi_Company"].ToString());
                string resoms = ds.Tables[0].Rows[0]["Reasons"].ToString();

                txt_Certificate.Text = ds.Tables[0].Rows[0]["Certificate_NO"].ToString();
                chk_IsPayeeNri.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["IS_NRI"].ToString());

                drp_Country.SelectedValue = ds.Tables[0].Rows[0]["Country_ID"].ToString();
                string Nrt = "";
                if (ds.Tables[0].Rows[0]["NRI_TDS_Rate"].ToString() !="")
                {
                    Nrt = ds.Tables[0].Rows[0]["NRI_TDS_Rate"].ToString();
                    drp_TdsRateNRI.SelectedValue = Nrt;
                }
                

                txtTaxIdentificationno.Text = ds.Tables[0].Rows[0]["TaxIdentificationNo"].ToString();
                radio_TDSRateFrom.SelectedValue = ds.Tables[0].Rows[0]["TDS_Rate_From"].ToString();
                if (radio_TDSRateFrom.SelectedValue == "1")
                {
                    string TDSRate = ds.Tables[0].Rows[0]["TDS_Rate"].ToString();
                    if (TDSRate != "0")
                    {
                        txt_TDSRate.Text = TDSRate;
                    }
                    string SurCharge = ds.Tables[0].Rows[0]["SurCharge"].ToString();
                    if (SurCharge != "0")
                    {
                        txt_SurCharge.Text = SurCharge;
                    }
                }
                if (txt_TDSRate.Text != "" && txt_SurCharge.Text != "")
                {
                    hdnRadiovalue1.Value = "1";
                    txt_SurCharge.Enabled = true;
                    txt_TDSRate.Enabled = true;
                }
                else
                {
                    hdnRadiovalue1.Value = "0";
                    txt_SurCharge.Enabled = false;
                    txt_TDSRate.Enabled = false;
                }


                if (txt_PanNo.Text == "")
                {
                    lblPanVerified.Text = "PAN Not Available";
                    lblPanVerified.ForeColor = Color.Red;
                }
                else
                {
                    ValidatePanVerification(txt_PanNo.Text);
                }
                drp_Reasons.SelectedValue = resoms;
                if (drp_State.SelectedValue == "99")
                {
                    drp_Country.Enabled = true;
                    drp_TdsRateNRI.Enabled = true;
                    radio_TDSRateFrom.Enabled = false;
                }
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "Alltogo();", true);
        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex);
            ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
        }

    }
    #endregion

    #region Delete
    protected void dgDetucteeGrid_ItemCommand_Delete(int DeducteeID)
    {
        try
        {
            objBAL_Deductee_Master.Deductee_ID = DeducteeID;
            result = objBAL_Deductee_Master.BAL_DeleteDeducteeID();
            this.ShowGrid();
            if (result > 0)
            {
                ucMessageControl.SetMessage("Deleted Successfully....", MessageDisplay.DisplayStyles.Success);
            }
            else
            {
                ucMessageControl.SetMessage("Cant Delete Deductee....", MessageDisplay.DisplayStyles.Success);
            }

        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex);
            ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
        }

    }
    #endregion

    private void ShowGrid()
    {
        try
        {
            tdGrid.Visible = true;
            tblDeducteeDetails.Visible = false;
            btnAddNew.Visible = true;
            tblSearch.Visible = true;
            this.Clear();
            this.BindGrid();
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
            this.Clear();
            tdGrid.Visible = false;
            tblDeducteeDetails.Visible = true;
            btnAddNew.Visible = false;
            tblSearch.Visible = false;
        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex);
            ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
        }
    }

    #region Button Click Bulk Pan Verification
    protected void btnBulkPAN_Click(object sender, EventArgs e)
    {
        ErrPan = CT.Trace_CheckInternetConnectivty();
        if (ErrPan == true)
        {
            objBAL_Deductee_Master.Deductee_Name = txtSearchName.Text;

            objBAL_Deductee_Master.Alias = "";

            if (ddlSearchPAN.SelectedValue != "0")
                objBAL_Deductee_Master.PANVerified = ddlSearchPAN.SelectedValue.Trim();
            else
                objBAL_Deductee_Master.PANVerified = "";

            if (ddlSearchReasons.SelectedValue != "0")
                objBAL_Deductee_Master.Reasons = ddlSearchReasons.SelectedValue.Trim();
            else
                objBAL_Deductee_Master.Reasons = "";

            objBAL_Deductee_Master.Company_ID = int.Parse(Session["companyid"].ToString());
            ds = objBAL_Deductee_Master.BAL_BindDetucteeGridOnSearch();

            if (ds.Tables[0].Rows.Count > 0)
            {
                dgDetucteeGrid.DataSource = ds.Tables[0];
                dgDetucteeGrid.AllowPaging = false;
                dgDetucteeGrid.DataBind();
                lblGridMessage.Text = "";
            }

            objBAL_Deductee_Master.Company_ID = int.Parse(Session["companyid"].ToString());
            string PANVrf = "";
            DataTable dt = new DataTable();
            DataRow dr;
            dt.Columns.Add("ID");
            dt.Columns.Add("Verification");
            foreach (DataGridItem item in dgDetucteeGrid.Items)
            {
                Label lblPAN = (Label)item.FindControl("lblPANNO");
                if (lblPAN.Text.ToLower() != "PANNOTAVBL".ToLower())
                {
                    HiddenField hdnDeducteeNO = (HiddenField)item.FindControl("hdnDeducteeNO");
                    int id = Convert.ToInt32(hdnDeducteeNO.Value);//;Convert.ToInt32(dgEmployee.DataKeys[item.ItemIndex]);
                    Label lblPANVerified = (Label)item.FindControl("lblPANVerified");
                    PANVrf = lblPANVerified.Text;
                    if (lblPAN.Text == "")
                    {
                        //j = j + 1;
                    }
                    else
                    {
                        if (PANVrf == "Valid PAN")
                        { }
                        else
                        {
                            dr = dt.NewRow();
                            ErrPan = CT.IsPAN_Valid(lblPAN.Text);
                            if (ErrPan == false)
                            {
                                dr["Verification"] = "InValid PAN";
                            }
                            else
                            {
                                dr["Verification"] = "Valid PAN";
                            }
                            dr["ID"] = id.ToString();
                            dt.Rows.Add(dr);
                        }
                    }
                }
            }
            if (dt.Rows.Count > 0)
            {
                objBAL_Deductee_Master.Company_ID = int.Parse(Session["companyid"].ToString());
                objBAL_Deductee_Master.DeduceteePanTable = dt;
                result = objBAL_Deductee_Master.BAL_PANVerificationDetuctee();
            }
            ShowGrid();
            ucMessageControl.SetMessage("PAN Verification complete", MessageDisplay.DisplayStyles.Success);

            //MessageBox.Show();
        }
        else
        {
            ucMessageControl.SetMessage("Internet Connectivity not found", MessageDisplay.DisplayStyles.Error);
            //MessageBox.Show();
        }

    }
    #endregion

    #region txtPAN Changed
    protected void txt_PanNo_TextChanged(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, typeof(Page), "Focus", "document.getElementById(\"" + txt_PanNo.ClientID.ToString() + "\").focus();", true);
        if (txt_PanNo.Text == "")
        {
            lblPanVerified.ForeColor = Color.Red;
            lblPanVerified.Text = "PAN Not Available";
            txt_PanNo.Text = "PANNOTAVBL";
            objBAL_Deductee_Master.Reasons = "Non-Availability of PAN C";
        }
        else
        {
            if (txt_PanNo.Text.Length == 10)
            {
                string panno = txt_PanNo.Text;
                if (panno.Length == 10)
                {
                    ValidatePanVerification(txt_PanNo.Text);
                }
            }
            else
            {
                lblPanVerified.ForeColor = Color.Red;
                drp_Reasons.SelectedValue = "Non-Availability of PAN C";
                lblPanVerified.Text = "Please Enter 10 Digit PAN Number";
            }
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert2", "Alltogo();", true);
    }
    #endregion

    protected void ValidatePanVerification(string PANNO)
    {
        try
        {
            if (PANNO.Trim().ToLower() != "PANNOTAVBL".Trim().ToLower())
            {
                ErrPan = CT.Trace_CheckInternetConnectivty();
                if (ErrPan)
                {
                    ErrPan = CT.IsPAN_Valid(PANNO);
                    if (ErrPan == false)
                    {
                        lblPanVerified.Text = "InValid PAN";
                        lblPanVerified.ForeColor = Color.Red;

                    }
                    else
                    {
                        lblPanVerified.Text = "Valid PAN";
                        lblPanVerified.ForeColor = Color.Green;
                    }
                    drp_Reasons.SelectedValue = "Presc.Rt.";
                }
            }
            else
            {
                lblPanVerified.Text = "PAN Not Available";
                lblPanVerified.ForeColor = Color.Red;
            }
        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex);

            ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
        }

    }

    #region btnSearch
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            this.BindGrid();
        }
        catch (Exception ex)
        {

            ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
        }
    }
    #endregion

    #region Clear All Fields
    protected void Clear()
    {
        txt_Name.Text = string.Empty;
        txt_PanNo.Text = string.Empty;
        txt_FlatNo.Text = string.Empty;
        txt_BldgName.Text = string.Empty;
        txt_Alias.Text = string.Empty;
        txt_Street.Text = string.Empty;
        txt_City.Text = string.Empty;
        drp_State.SelectedIndex = 0;
        txt_PinCode.Text = string.Empty;
        drp_Branch.SelectedIndex = 0;
        drp_Branch.SelectedIndex = 0;
        txt_Email.Text = string.Empty;
        txt_MobileNo.Text = string.Empty;
        drp_Nature.SelectedIndex = 0;
        drp_Type.SelectedIndex = 0;
        drp_Branch.SelectedIndex = 0;
        drp_Reasons.SelectedIndex = 0;
        txt_Certificate.Text = string.Empty;
        drp_Country.SelectedIndex = 0;
        drp_TdsRateNRI.SelectedIndex = 0;
        txt_TDSRate.Text = string.Empty;
        txt_SurCharge.Text = string.Empty;
        drp_Nature.SelectedIndex = 0;
        lblPanVerified.Text = string.Empty;
        chk_ApplicationToAll.Checked = false;
        chk_IsPayeeNri.Checked = false;
        chk_PayeeIndividual.Checked = false;
    }
    #endregion

    #region WebMethod
    #endregion


}