using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLayer;
using System.Data;
using System.IO;
using System.Drawing;
using PANVrf;

public partial class Admin_ManageCompany : System.Web.UI.Page
{
    CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
    DataSet ds;
    int result = 0;
    BAL_ManageCompany objBAL_ManageCompany = new BAL_ManageCompany();
    BAL_Deductee_Master objBAL_Deductee_Master = new BAL_Deductee_Master();
    int Parent_ID = 0;
    Boolean ErrPan = false;
    ConnectTraces CT = new ConnectTraces();

    protected void Page_Load(object sender, EventArgs e)
    {
        this.Page.Form.Enctype = "multipart/form-data";
        if (!IsPostBack)
        {
            if (Session["companyid"] == null)
            {
                Response.Redirect("~/Default.aspx", false);
            }
            else
            {

                hdnCompanyid.Value = Session["companyid"].ToString();

                if (Session["Parent_Company_ID"] == null)
                { Response.Redirect("~/Default.aspx", true); }
                Parent_ID = int.Parse(Session["Parent_Company_ID"].ToString());
                getParentDetails();
                BindState_DropDown();
                BindCompanyGrid();
                if (Session["chkValidation"].ToString() != "")
                {
                    string msg = Session["chkValidation"].ToString();
                    ucMessageControl.SetMessage(msg, MessageDisplay.DisplayStyles.Error);
                }
                // txtFromDateFinancial.Attributes.Add("readonly", "readonly");
                // txtToDateFinancial.Attributes.Add("readonly", "readonly");
               lblPanVerified.Attributes.Add("readonly", "readonly");
                if (Request.QueryString["id"] != null && Request.QueryString["id"] == "Val")
                {
                    validateCompany();
                }
            }

        }
    }

    public void getParentDetails()
    {
        DataSet ds1;
        objBAL_ManageCompany.Parent_ID = Parent_ID;
        ds = objBAL_ManageCompany.BAL_ParentDetails();
        if (ds.Tables[0].Rows.Count > 0)
        {
            ds1 = objBAL_ManageCompany.BAL_CompanyCount();
            int i = int.Parse(ds1.Tables[0].Rows[0][0].ToString());
            int CompanyCount = 0;
            CompanyCount = int.Parse(ds.Tables[0].Rows[0]["Sub_Company_Count"].ToString());
            if (i >= CompanyCount)
            {
                Label2.Visible = false;
                BtnMulti.Visible = false;
            }
            else
            {
                Label2.Visible = true;
                BtnMulti.Visible = true;
            }
        }
    }


    protected void BindState_DropDown()
    {
        try
        {
            ds = objBAL_Deductee_Master.BAL_BindDropDown();
            #region State DropDown
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlState.DataSource = ds.Tables[0];
                ddlState.DataTextField = "State_Name";
                ddlState.DataValueField = "State_ID";
                ddlState.DataBind();
                ddlR_State.DataSource = ds.Tables[0];
                ddlR_State.DataTextField = "State_Name";
                ddlR_State.DataValueField = "State_ID";
                ddlR_State.DataBind();
            }

            ddlState.Items.Insert(0, new ListItem("(Select State)", "0"));
            ddlR_State.Items.Insert(0, new ListItem("(Select State)", "0"));
            #endregion
        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex, hdnCompanyid.Value);
            ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
        }

    }

    protected void BindCompanyGrid()
    {
        try
        {
            objBAL_ManageCompany.Company_ID = Convert.ToInt32(Session["companyid"]);
            ds = objBAL_ManageCompany.BAL_BindRegisterCompanyGrid();
            if (ds.Tables[0].Rows.Count > 0)
            {
                gvCompanyDetails.DataSource = ds;
                gvCompanyDetails.DataBind();
                tdCompanyEidt.Visible = false;
                tdCompanyDetais.Visible = true;
            }
        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex, hdnCompanyid.Value);

            ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
        }
    }
    protected void gvCompanyDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditCommand")
        {

            hdnCompanyid.Value = e.CommandArgument.ToString();
            Parent_ID = int.Parse(hdnCompanyid.Value.ToString());
            //Session["ParentID"] = Parent_ID; 
            BindOnEditCommand(Convert.ToInt32(e.CommandArgument));
            tdCompanyEidt.Visible = true;
            tdCompanyDetais.Visible = false;
            txtContactPAN_TextChanged(sender, e);
        }
    }

    protected void BindOnEditCommand(int CompId)
    {
        try
        {
            Clear();
            System.Threading.Thread.Sleep(500);
            objBAL_ManageCompany.Company_ID = CompId;
            objBAL_ManageCompany.Parent_ID = Parent_ID;
            ds = objBAL_ManageCompany.BAL_EditCompanyDetails();
            if (ds.Tables[0].Rows.Count > 0)
            {
                txtCompanyName.Text = ds.Tables[0].Rows[0]["CompanyName"].ToString();
                txtFlatNo.Text = ds.Tables[0].Rows[0]["Flat_No"].ToString();
                txt_Alias.Text = ds.Tables[0].Rows[0]["Alias"].ToString();
                txt_Branch.Text = ds.Tables[0].Rows[0]["Co_Branch"].ToString();
                txtName_Of_Building.Text = ds.Tables[0].Rows[0]["Name_Of_Building"].ToString();
                txtStreet.Text = ds.Tables[0].Rows[0]["Street"].ToString();
                txtArea_Location.Text = ds.Tables[0].Rows[0]["Area_Location"].ToString();
                txtTown_City.Text = ds.Tables[0].Rows[0]["Town_City"].ToString();
                txtEmailID.Text = ds.Tables[0].Rows[0]["EmailID"].ToString();

                if (ds.Tables[0].Rows[0]["Status"].ToString() != "")
                    ddlStatus.SelectedValue = ds.Tables[0].Rows[0]["Status"].ToString();

                if (ds.Tables[0].Rows[0]["IClass"].ToString() != "")
                    ddlClass.SelectedValue = ds.Tables[0].Rows[0]["IClass"].ToString();
                txtPincode.Text = ds.Tables[0].Rows[0]["Pincode"].ToString();
                txtSTD_code.Text = ds.Tables[0].Rows[0]["STD_code"].ToString();
                txtTel_NO.Text = ds.Tables[0].Rows[0]["Tel_NO"].ToString();
                txtFax.Text = ds.Tables[0].Rows[0]["Fax"].ToString();
                txtTANNo.Text = ds.Tables[0].Rows[0]["TANNo"].ToString();
                txtPANNo.Text = ds.Tables[0].Rows[0]["PANNo"].ToString();
                txtPlace.Text = ds.Tables[0].Rows[0]["Place"].ToString();
                txtAlt_EmailID.Text = ds.Tables[0].Rows[0]["Alt_EmailID"].ToString();
                txtAlt_Tel_NO.Text = ds.Tables[0].Rows[0]["Alt_Tel_NO"].ToString();
                txtAlt_STDcode.Text = ds.Tables[0].Rows[0]["Alt_STDcode"].ToString();

                if (ds.Tables[0].Rows[0]["Change_Deductor"].ToString() != "")
                    chkChange_Deductor.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["Change_Deductor"].ToString());

                txtR_Name.Text = ds.Tables[0].Rows[0]["R_Name"].ToString();
                txtR_Flat_No.Text = ds.Tables[0].Rows[0]["R_Flat_NO"].ToString();
                txtR_Building.Text = ds.Tables[0].Rows[0]["R_Building"].ToString();
                txtR_Street.Text = ds.Tables[0].Rows[0]["R_Street"].ToString();
                txtR_Area_Location.Text = ds.Tables[0].Rows[0]["R_Area_Location"].ToString();
                txtR_Town_City.Text = ds.Tables[0].Rows[0]["R_Town_City"].ToString();
                txtR_EmailID.Text = ds.Tables[0].Rows[0]["R_EmailID"].ToString();

                //if (ds.Tables[0].Rows[0]["R_Designation"].ToString() != "")
                //    ddlR_Designation.SelectedValue = ds.Tables[0].Rows[0]["R_Designation"].ToString();

                txt_Designation.Text = ds.Tables[0].Rows[0]["R_Designation"].ToString();

                if (ds.Tables[0].Rows[0]["R_StateID"].ToString() != "")
                    ddlR_State.SelectedValue = ds.Tables[0].Rows[0]["R_StateID"].ToString();

                txtR_MobileNo.Text = ds.Tables[0].Rows[0]["R_Mobile_NO"].ToString();
                txtR_Pincode.Text = ds.Tables[0].Rows[0]["R_Pincode"].ToString();
                txtR_STD_Code.Text = ds.Tables[0].Rows[0]["R_STD_Code"].ToString();
                txtR_Tel_NO.Text = ds.Tables[0].Rows[0]["R_Tel_NO"].ToString();
                txtR_Fax.Text = ds.Tables[0].Rows[0]["R_Fax"].ToString();

                if (ds.Tables[0].Rows[0]["Change_Responsible"].ToString() != "")
                    chkChange_Responsible.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["Change_Responsible"].ToString());

                txtALT_R_EmailID.Text = ds.Tables[0].Rows[0]["ALT_R_EmailID"].ToString();
                txtALT_R_Tel_NO.Text = ds.Tables[0].Rows[0]["ALT_R_Tel_NO"].ToString();
                txtALT_R_STD_Code.Text = ds.Tables[0].Rows[0]["ALT_R_STD_Code"].ToString();
                txtContactPAN.Text = ds.Tables[0].Rows[0]["ContacPersonPAN"].ToString();
                TxtGSTN.Text = ds.Tables[0].Rows[0]["GSTN"].ToString();
                
                if (ds.Tables[0].Rows[0]["StateID"].ToString() != "")
                    ddlState.SelectedValue = ds.Tables[0].Rows[0]["StateID"].ToString();


               // string CompanyLogoName = ds.Tables[0].Rows[0]["CompanyLogoName"].ToString();
                TxtUser.Text = ds.Tables[0].Rows[0]["CUserName"].ToString();
                txtContactperson.Text = ds.Tables[0].Rows[0]["ContactPerson"].ToString();
                TxtPassword.Text = ds.Tables[0].Rows[0]["CPassword"].ToString();
                txtContactnumber.Text = ds.Tables[0].Rows[0]["Tel_NO"].ToString();
      
                TxtEmail.Text = ds.Tables[0].Rows[0]["EmailID"].ToString();
                hdnUID.Value = ds.Tables[0].Rows[0]["UserID"].ToString();
               
            }

        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex, hdnCompanyid.Value);
            ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
        }

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            System.Threading.Thread.Sleep(500);
            Clear();
            tdCompanyEidt.Visible = false;
            tdCompanyDetais.Visible = true;
        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex, hdnCompanyid.Value);
            tdCompanyEidt.Visible = false;
            tdCompanyDetais.Visible = true;
            ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        try
        {
            string v = hdnValid.Value;
            if (v == "GSTN")
            {
                return;
            }
            //if (TxtGSTN.Text =="")
            //{
            //    ucMessageControl.SetMessage("GSTN No Required", MessageDisplay.DisplayStyles.Error);
            //    return;
            //}
            else
            {
               // if (txtPANNo.Text == txtContactPAN.Text)
               // {
               //     ucMessageControl.SetMessage("Responsible Person PAN incorrect", MessageDisplay.DisplayStyles.Error);
               //     return;
               // }
                string tl = txtTel_NO.Text;
                if (tl.Length ==0)
                {
                    ucMessageControl.SetMessage("Enter 8 digit Company telephone no", MessageDisplay.DisplayStyles.Error);
                    return;
                }
                string Atl = txtAlt_Tel_NO.Text;
                if (Atl.Length == 0)
                {
                    ucMessageControl.SetMessage("Enter 8 digit Alternate Company telephone no", MessageDisplay.DisplayStyles.Error);
                    return;
                }

 
                string Rtl = txtR_Tel_NO.Text;
                if (Rtl.Length == 0)
                {
                    ucMessageControl.SetMessage("Enter 8 digit Responsible Person telephone no", MessageDisplay.DisplayStyles.Error);
                    return;
                }
                string ARtl = txtAlt_Tel_NO.Text;
                if (ARtl.Length == 0)
                {
                    ucMessageControl.SetMessage("Enter 8 digit Alternate Responsible Person telephone no", MessageDisplay.DisplayStyles.Error);
                    return;
                }
                if (txt_Branch.Text != "")
                {
                    objBAL_ManageCompany.Branch = txt_Branch.Text;
                }

                string st = ddlStatus.SelectedValue;
                if (st == "")
                {
                    ucMessageControl.SetMessage("Select Company Status", MessageDisplay.DisplayStyles.Error);
                    return;
                }

                string cl = ddlClass.SelectedValue;
                if (cl=="")
                {
                    ucMessageControl.SetMessage("Select Company Class", MessageDisplay.DisplayStyles.Error);
                    return;
                }

                Parent_ID = int.Parse(Session["Parent_Company_ID"].ToString());
                objBAL_ManageCompany.Parent_ID = Parent_ID;
                objBAL_ManageCompany.CompanyName = txtCompanyName.Text;
                objBAL_ManageCompany.Flat_No = txtFlatNo.Text;
                objBAL_ManageCompany.Name_Of_Building = txtName_Of_Building.Text;
                objBAL_ManageCompany.Street = txtStreet.Text;
                objBAL_ManageCompany.Area_Location = txtArea_Location.Text;
                objBAL_ManageCompany.Town_City = txtTown_City.Text;
                objBAL_ManageCompany.EmailID = txtEmailID.Text;
                objBAL_ManageCompany.Status = ddlStatus.SelectedValue;
                objBAL_ManageCompany.IClass = ddlClass.SelectedValue;

                if (txtPincode.Text != "")
                    objBAL_ManageCompany.Pincode = Convert.ToInt32(txtPincode.Text);

                if (txtSTD_code.Text != "")
                    objBAL_ManageCompany.STD_code = txtSTD_code.Text;

                if (txtTel_NO.Text != "")
                    objBAL_ManageCompany.Tel_NO = txtTel_NO.Text;

                if (txtFax.Text != "")
                    objBAL_ManageCompany.Fax = txtFax.Text;

                objBAL_ManageCompany.TANNo = txtTANNo.Text;
                objBAL_ManageCompany.PANNo = txtPANNo.Text;
                objBAL_ManageCompany.Place = txtPlace.Text;
                objBAL_ManageCompany.Alt_EmailID = txtAlt_EmailID.Text;
                objBAL_ManageCompany.Alt_Tel_NO = txtAlt_Tel_NO.Text;
                objBAL_ManageCompany.Alt_STDcode = txtAlt_STDcode.Text;
                objBAL_ManageCompany.Change_Deductor = chkChange_Deductor.Checked;
                objBAL_ManageCompany.R_Name = txtR_Name.Text;
                objBAL_ManageCompany.R_Flat_NO = txtR_Flat_No.Text;
                objBAL_ManageCompany.R_Building = txtR_Building.Text;
                objBAL_ManageCompany.R_Street = txtR_Street.Text;
                objBAL_ManageCompany.R_Area_Location = txtR_Area_Location.Text;
                objBAL_ManageCompany.R_Town_City = txtR_Town_City.Text;
                objBAL_ManageCompany.R_EmailID = txtR_EmailID.Text;
                objBAL_ManageCompany.R_Designation = txt_Designation.Text;//ddlR_Designation.SelectedValue;
                objBAL_ManageCompany.R_StateID = Convert.ToInt32(ddlR_State.SelectedValue);

                if (txtR_MobileNo.Text != "")
                    objBAL_ManageCompany.R_Mobile_NO = txtR_MobileNo.Text;//Convert.ToInt32(txtR_MobileNo.Text);

                if (txtR_Pincode.Text != "")
                    objBAL_ManageCompany.R_Pincode = txtR_Pincode.Text;

                if (txtR_STD_Code.Text != "")
                    objBAL_ManageCompany.R_STD_Code = txtR_STD_Code.Text;

                if (txtR_Tel_NO.Text != "")
                    objBAL_ManageCompany.R_Tel_NO = txtR_Tel_NO.Text;

                if (txtR_Fax.Text != "")
                    objBAL_ManageCompany.R_Fax = txtR_Fax.Text;

                objBAL_ManageCompany.Change_Responsible = chkChange_Responsible.Checked;
                objBAL_ManageCompany.ALT_R_EmailID = txtALT_R_EmailID.Text;

                if (txtALT_R_Tel_NO.Text != "")
                    objBAL_ManageCompany.ALT_R_Tel_NO = txtALT_R_Tel_NO.Text;

                if (txtALT_R_STD_Code.Text != "")
                    objBAL_ManageCompany.ALT_R_STD_Code = txtALT_R_STD_Code.Text;
                objBAL_ManageCompany.FromDate = CommonSettings.ConvertToCulturedDateTime(DateTime.Now);
                objBAL_ManageCompany.ToDate = CommonSettings.ConvertToCulturedDateTime(DateTime.Now);


                objBAL_ManageCompany.StateID = Convert.ToInt32(ddlState.SelectedValue);

                objBAL_ManageCompany.Alias = txt_Alias.Text;


                if (TxtGSTN.Text != "")
                {
                    objBAL_ManageCompany.GSTN = TxtGSTN.Text;
                }
                //string FileName = ICompanyLogoPreview.ImageUrl;
                string filePath = "";

                objBAL_ManageCompany.CompanyLogoName = "";  // Filename;
                objBAL_ManageCompany.CompanyLogoPath = filePath;


                objBAL_ManageCompany.ContactPAN = txtContactPAN.Text;
                if (hdnCompanyid.Value != "" & hdnCompanyid.Value != null)
                {
                    objBAL_ManageCompany.Company_ID = Convert.ToInt32(hdnCompanyid.Value);
                    result = objBAL_ManageCompany.BAL_UpdateCompanyDetails();
                }
                else
                {
                    result = objBAL_ManageCompany.BAL_InsertCompanyDetails();
                }

                if (result > 0)
                {
                    ucMessageControl.SetMessage("Updated......", MessageDisplay.DisplayStyles.Success);
                    hdnCompanyid.Value = "";
                    tdCompanyDetais.Visible = true;
                    tdCompanyEidt.Visible = false;
                    Clear();
                }
                else
                {
                    ucMessageControl.SetMessage("Cannot Save, another company with same TAN No exists", MessageDisplay.DisplayStyles.Success);
                }
            }
        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex, hdnCompanyid.Value);
            ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
        }

    }


    protected void Clear()
    {
        txtCompanyName.Text = "";
        txtFlatNo.Text = "";
        txtName_Of_Building.Text = "";
        txtStreet.Text = "";
        txtArea_Location.Text = "";
        txtTown_City.Text = "";
        txtEmailID.Text = "";
        //ddlStatus.SelectedValue = "";
        //ddlClass.SelectedValue = "";
        txtPincode.Text = "";
        txtSTD_code.Text = "";
        txtTel_NO.Text = "";
        txtFax.Text = "";
        txtTANNo.Text = "";
        txtPANNo.Text = "";
        txtAlt_EmailID.Text = "";
        txtAlt_Tel_NO.Text = "";
        txtAlt_STDcode.Text = "";
        chkChange_Deductor.Checked = false;
        txtR_Name.Text = "";
        txtR_Flat_No.Text = "";
        txtR_Building.Text = "";
        txtR_Street.Text = "";
        txtR_Area_Location.Text = "";
        txtR_Town_City.Text = "";
        txtR_EmailID.Text = "";
        txt_Designation.Text = "";
        ddlR_State.SelectedIndex = -1;
        txtR_MobileNo.Text = "";
        txtR_Pincode.Text = "";
        txtR_STD_Code.Text = "";
        txtR_Tel_NO.Text = "";
        txtR_Fax.Text = "";
        chkChange_Responsible.Checked = false;
        txtALT_R_EmailID.Text = "";
        txtALT_R_Tel_NO.Text = "";
        txtALT_R_STD_Code.Text = "";
        TxtGSTN.Text = ""; 

    }
    protected void btnMulti_Click(object sender, EventArgs e)
    {
        Parent_ID = int.Parse(Session["Parent_Company_ID"].ToString());
        objBAL_ManageCompany.Parent_ID = Parent_ID;
        hdnCompanyid.Value = null;
        Session["hdnCompanyIDonpage"] = null;
        tdCompanyEidt.Visible = true;
        tdCompanyDetais.Visible = false;


    }
    protected void txtContactPAN_TextChanged(object sender, EventArgs e)
    {
        if (txtContactPAN.Text == "")
        {
            lblPanVerified.ForeColor = Color.Red;
            lblPanVerified.Text = "PAN Not Available";
        }
        else
        {
            if (txtContactPAN.Text.Length == 10)
            {
                string panno = txtContactPAN.Text;
                if (panno.Length == 10)
                {
                    ValidatePanVerification(txtContactPAN.Text);
                }
            }
            else
            {
                lblPanVerified.ForeColor = Color.Red;
                lblPanVerified.Text = "Please Enter 10 Digit PAN Number";
            }
        }
    }

    protected void ValidatePanVerification(string PANNO)
    {
        try
        {

        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex, hdnCompanyid.Value);

            ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
        }

    }

    public void validateCompany()
    {
        ucMessageControl.SetMessage("GSTN, Branch required", MessageDisplay.DisplayStyles.Error);
        hdnCompanyid.Value = Session["companyid"].ToString();
        Parent_ID = int.Parse(hdnCompanyid.Value.ToString());
        
        BindOnEditCommand(Convert.ToInt32(hdnCompanyid.Value));
        tdCompanyEidt.Visible = true;
        tdCompanyDetais.Visible = false;
        
    }


    protected void btnClose_Click(object sender, EventArgs e)
    {
        tdCompanyEidt.Visible = false;
        tdCompanyDetais.Visible = true;
    }
}