using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLayer;
using DataLayer;
using System.Data;
using System.Drawing;
using System.Globalization;
using CommonLibrary;
using System.Diagnostics;
using System.Web.Services;
using System.Web.Script.Serialization;
using Microsoft.ApplicationBlocks1.Data;
using System.Data.SqlClient;


namespace Forms
{
    public partial class _ManageNonSalary_Challan : System.Web.UI.Page
    {
        CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
        BAL_Bank_Master objBAL_Bank_Master = new BAL_Bank_Master();
        BAL_NonSalaryChallan objBAL_NonSalaryChallan = new BAL_NonSalaryChallan();
        BAL_EReturns_NonSalary objBAL_EReturns_NonSalary = new BAL_EReturns_NonSalary();
        DataSet ds;
        int result = 0;
        CultureInfo ci = new CultureInfo("en-GB");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["companyid"] != null)
            {
                hdnCompanyid.Value = Session["companyid"].ToString();
            }
            else
            {
                Response.Redirect("~/Default.aspx");
            }

            if (!Page.IsPostBack)
            {
                this.BindBankDetails();
                if (Session["companyid"] != null)
                {
                    if (Session["FromType"] != null && Session["SelectedQuarter"] != null)
                    {
                        Session["WhereNonSalaryCheck"] = Session["FromType"].ToString();
                        ddlQuaterType.SelectedValue = Session["SelectedQuarter"].ToString();
                        ddlReturnType.SelectedValue = Session["FromType"].ToString();
                        lblHeader.Text = lblHeader.Text + " : Form " + Session["FromType"].ToString();
                        if (ddlReturnType.SelectedValue != "0")
                        {
                            ddlReturnType_SelectedIndexChanged(sender, e);
                        }
                        lblSelectdReturnType.Text = Session["FromType"].ToString();
                        ddlReturnType.Enabled = false;
                    }
                    else if (Request.QueryString["D"] != null && Request.QueryString["D"] != "")
                    {

                        var d = Request.QueryString["D"];
                        string[] dd = d.Split(',');
                        Session["WhereNonSalaryCheck"] = dd[0];
                        Session["FromType"] = dd[0];
                        ddlQuaterType.SelectedValue = dd[1];
                        ddlReturnType.SelectedValue = dd[0];
                        lblHeader.Text = lblHeader.Text + " : Form " + dd[0]; ;
                        if (ddlReturnType.SelectedValue != "0")
                        {
                            ddlReturnType_SelectedIndexChanged(sender, e);
                        }
                        lblSelectdReturnType.Text = Session["FromType"].ToString();
                        ddlReturnType.Enabled = false;

                    }
                    else { Response.Redirect("ManageNonSalary_ChallanList.aspx", true); }
                }
                else
                {
                    Response.Redirect("~/Default.aspx");
                }

                txtChinDate.Text = CommonSettings.ConvertToCulturedDateTime(DateTime.Now.Date).ToString("dd/MM/yyyy");
                if (Session["SalaryNonChallanID"] != null && Session["SalaryNonChallanID"].ToString() != "")
                {
                    /////////////if edit challan
                    string CID = Session["SalaryNonChallanID"].ToString();
                    Session["SalaryNonChallanID"] = null;
                    if (CID != "" && CID != string.Empty && CID != null)
                    {
                        EditMode(CID);
                        hdnChallanID.Value = CID;
                    }
                }
                else
                {
                    /////////////if created new challan open nature selection
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "openpopups", "$(function(){  $('#opener').click(); });", true);
                }

            }
            ddlReturnType.Attributes.Add("readonly", "readonly");
            txtTotalTaxDeposited.Attributes.Add("readonly", "readonly");
            txtBranch.Attributes.Add("readonly", "readonly");
            txtTDSAdjAmount.Attributes.Add("readonly", "readonly");
            txtAdjSurcharge.Attributes.Add("readonly", "readonly");
            txtAdjECess.Attributes.Add("readonly", "readonly");
            txtAdjHECess.Attributes.Add("readonly", "readonly");
            txtActualDeposite.Attributes.Add("readonly", "readonly");
            txtAdjDeposite.Attributes.Add("readonly", "readonly");
            txtBalance.Attributes.Add("readonly", "readonly");
            lblSelectedQuarter.Attributes.Add("readonly", "readonly");
            lblSelectdReturnType.Attributes.Add("readonly", "readonly");
            txtfilterFromDate.Attributes.Add("readonly", "readonly");
            txtfilterTodate.Attributes.Add("readonly", "readonly");


        }

        protected void BindBankDetails()
        {
            try
            {
                if (Session["companyid"] == null)
                {
                    Response.Redirect("~/Default.aspx", true);
                }
                ds = null;
                objBAL_Bank_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                ds = objBAL_Bank_Master.Get_Bank_Master_List();
                ddlBankName.DataSource = null;
                ddlBankName.DataBind();
                //objBAL_NonSalaryChallan.CompanyID = Convert.ToInt32(Session["companyid"]);
                //ds = objBAL_NonSalaryChallan.BAL_GetBankDetial();
                if (ds.Tables[0].Rows.Count > 0)
                {
                    ddlBankName.DataSource = ds.Tables[0];
                    ddlBankName.DataTextField = "Bank_Branch_Name";
                    ddlBankName.DataValueField = "bid_bsr";
                    ddlBankName.DataBind();
                }
                ddlBankName.Items.Insert(0, new ListItem("( Select )", "0"));
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex, hdnCompanyid.Value);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Success);
            }
        }

        protected void ddlReturnType_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                hdnNatureList.Value = "";
                if (ddlReturnType.SelectedValue == "0")
                {
                    //chkNatures.Visible = false;
                }
                else
                {
                    //chkNatures.Visible = true;
                    objBAL_NonSalaryChallan.ChallanType = ddlReturnType.SelectedValue;
                    ds = objBAL_NonSalaryChallan.BAL_GetNatureFilterByChallanType();
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        chknaturesselectall.Visible = true;
                        //chkNatures.DataSource = ds.Tables[0];
                        //chkNatures.DataTextField = "Nature_Name";
                        //chkNatures.DataValueField = "Nature_ID";
                        //chkNatures.DataBind();

                        List<tbl_Nature> tbl = new List<tbl_Nature>();
                        CommonFunctions o = new CommonFunctions();
                        foreach (DataRow drrr in ds.Tables[0].Rows)
                        {
                            tbl.Add(new tbl_Nature()
                            {

                                NatureName = o.GetValue<string>(drrr["Nature_Name"].ToString()),
                                Nature_ID = o.GetValue<int>(drrr["Nature_ID"].ToString()),

                            });
                        }

                        IEnumerable<tbl_Nature> itbl = tbl as IEnumerable<tbl_Nature>;
                        var obbbbb = itbl;
                        hdnNatureList.Value = new JavaScriptSerializer().Serialize(tbl);
                        //gvVoucherDetails.DataSource = ds.Tables[1];
                        //gvVoucherDetails.DataBind();
                        ScriptManager.RegisterClientScriptBlock(btnSubmitNatures, this.GetType(), "checkall", " $(document).ready(function () {OnNatureList();   }); ", true);


                    }
                    else { chknaturesselectall.Visible = false; }
                }
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex, hdnCompanyid.Value);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }
        //protected void btnSubmitNatures_Click(object sender, EventArgs e)
        //{
        //    if (hdnjavascriptcheckbalues.Value == "" && !string.IsNullOrEmpty(hdnjavascriptcheckbalues.Value))
        //    {
        //        return;
        //    }
        //    hdnjavascriptcheckbalues.Value = hdnjavascriptcheckbalues.Value.TrimEnd(',');
        //    string[] selectedvalue = hdnjavascriptcheckbalues.Value.Split(',');
        //    DataTable dt = new DataTable();
        //    dt.Columns.Add("Nature_Id");
        //    DataRow dr;
        //    lblSelectdReturnType.Text = ddlReturnType.SelectedItem.Text;
        //    lblSelectedQuarter.Text = ddlQuaterType.SelectedValue;
        //    try
        //    {
        //        //foreach (ListItem chk in chkNatures.Items)
        //        foreach (string check in selectedvalue)
        //        {
        //            {
        //                dr = dt.NewRow();
        //                dr["Nature_Id"] = check;
        //                dt.Rows.Add(dr);
        //            }
        //        }
        //        objBAL_NonSalaryChallan.CompanyID = Convert.ToInt32(Session["companyid"]);
        //        objBAL_NonSalaryChallan.Quater = ddlQuaterType.SelectedValue;
        //        objBAL_NonSalaryChallan.dtNatureId = dt;
        //        ds = objBAL_NonSalaryChallan.BAL_GetVoucherListOnNatureSelection();
        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            gvVoucherDetails.DataSource = ds.Tables[0];
        //            gvVoucherDetails.DataBind();
        //            gvVoucherDetails.Visible = true;
        //            if (ds.Tables.Count > 2)
        //            {
        //                if (ds.Tables[3].Rows.Count > 0)
        //                {
        //                    txtfilterFromDate.Text = ds.Tables[3].Rows[0]["From"].ToString();
        //                    txtfilterTodate.Text = ds.Tables[3].Rows[0]["To"].ToString();
        //                }
        //            }
        //        }
        //        else
        //        {
        //            ds.Tables[0].Rows.Add(ds.Tables[0].NewRow());
        //            gvVoucherDetails.DataSource = ds;
        //            gvVoucherDetails.DataBind();
        //            int columncount = gvVoucherDetails.Rows[0].Cells.Count;
        //            gvVoucherDetails.Rows[0].Cells.Clear();
        //            gvVoucherDetails.Rows[0].Cells.Add(new TableCell());
        //            gvVoucherDetails.Rows[0].Cells[0].ColumnSpan = columncount;
        //            gvVoucherDetails.Rows[0].Cells[0].Text = "No Records Found";
        //            gvVoucherDetails.Rows[0].Cells[0].ForeColor = Color.Red;
        //        }
        //        gvVoucherDetails.Visible = true;
        //    }
        //    catch (Exception ex)
        //    {
        //        ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Success);
        //    }
        //}
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = new DataTable();
                DataRow dr;
                dt.Columns.Add("Voucher_ID");

                //if (hdnCheckedVoucherID.Value == "" && ddlNilChallan.SelectedValue == "0" && txtActualFees.Text == "0" && txtActualInterest.Text == "0")
                //{

                //    ucMessageControl.SetMessage("Please Select At Least One Record From List of TDS Deduction Paid In This Challan !", MessageDisplay.DisplayStyles.Error);
                //    return;
                //}

                string ChallanT = hdnCheckedVoucherID.Value;
                if (ChallanT == "IntersetChallan")
                { hdnCheckedVoucherID.Value = ""; }

                string[] voucherids = hdnCheckedVoucherID.Value.Split(',');
                foreach (string item in voucherids)
                {
                    dr = dt.NewRow();
                    dr["Voucher_ID"] = item;
                    if (!string.IsNullOrEmpty(item))
                        dt.Rows.Add(dr);
                }

                objBAL_NonSalaryChallan.dtVoucherID = dt;
                objBAL_NonSalaryChallan.CompanyID = Convert.ToInt32(Session["companyid"]);

                objBAL_NonSalaryChallan.Bank_ID = 0;
                string bid = "";
                bid = ddlBankName.SelectedValue.ToString();
                string[] bsr_bid = bid.Split(',');
                string bsrcode = bsr_bid[1].ToString();
                if (bsrcode.Length != 7)
                {
                    ucMessageControl.SetMessage("Bsrcode should be 7 digit", MessageDisplay.DisplayStyles.Error);
                    return;
                }
                objBAL_NonSalaryChallan.Bank_ID = Convert.ToInt32(bsr_bid[0].ToString());
                objBAL_NonSalaryChallan.Bank_Bsrcode = "";
                //objBAL_NonSalaryChallan.Bank_ID = Convert.ToInt32(ddlBankName.SelectedValue.ToString()) ;
                objBAL_NonSalaryChallan.Bank_Bsrcode = bsr_bid[1].ToString();
                if (txtChequeNo.Text != "0" && txtChequeNo.Text != "")
                {
                    objBAL_NonSalaryChallan.Cheque_no = Convert.ToInt32(txtChequeNo.Text);
                }
                else
                { objBAL_NonSalaryChallan.Cheque_no = 0; }
                if (txtChaqueDate.Text == "")
                {
                    objBAL_NonSalaryChallan.Cheque_Date = CommonSettings.ConvertToCulturedDateTime("01/01/2001");
                }
                else { objBAL_NonSalaryChallan.Cheque_Date = CommonSettings.ConvertToCulturedDateTime(txtChaqueDate.Text); }
                objBAL_NonSalaryChallan.Quater = lblSelectedQuarter.Text;
                objBAL_NonSalaryChallan.TDS_Amount = Convert.ToDouble(txtTDSActualAmount.Text);
                objBAL_NonSalaryChallan.Surcharge = Convert.ToDouble(txtActualSurcharge.Text);
                objBAL_NonSalaryChallan.Education_Cess = Convert.ToDouble(txtActualECess.Text);
                objBAL_NonSalaryChallan.High_Education_Cess = Convert.ToDouble(txtActualHECess.Text);
                objBAL_NonSalaryChallan.Interest_Amt = Convert.ToDouble(txtActualInterest.Text);
                objBAL_NonSalaryChallan.Fees_Amount = Convert.ToDouble(txtActualFees.Text);
                objBAL_NonSalaryChallan.Others_Amount = Convert.ToDouble(txtActualOthers.Text);
                objBAL_NonSalaryChallan.Challan_Amount = Convert.ToDouble(txtActualDeposite.Text);

                if (txtChinDate.Text == "")
                { objBAL_NonSalaryChallan.Challan_Date = CommonSettings.ConvertToCulturedDateTime("1/01/2001"); }
                else { objBAL_NonSalaryChallan.Challan_Date = CommonSettings.ConvertToCulturedDateTime(txtChinDate.Text); }

                if (txtBankChinNo.Text == "")
                    objBAL_NonSalaryChallan.Challan_No = "0";
                else
                    objBAL_NonSalaryChallan.Challan_No = txtBankChinNo.Text;

                objBAL_NonSalaryChallan.Trans_No = "";
                objBAL_NonSalaryChallan.C_Entry = ddlselectedfilter.SelectedValue;
                objBAL_NonSalaryChallan.Nil_Challan = Convert.ToBoolean(Convert.ToInt32(ddlNilChallan.SelectedValue));
                objBAL_NonSalaryChallan.Challan_Type = ddlselectedfilter.SelectedValue;
                objBAL_NonSalaryChallan.Form_Type = ddlReturnType.SelectedValue;
                if (hdnChallanID.Value == "")
                { objBAL_NonSalaryChallan._Challan_ID = 0; }
                else
                { objBAL_NonSalaryChallan._Challan_ID = Convert.ToInt32(hdnChallanID.Value); }
                result = objBAL_NonSalaryChallan.BAL_InsertNonSalary();
                this.Clear();
                if (result > 0)
                {
                    ucMessageControl.SetMessage("Challan Saved Successfully ... Please Wait", MessageDisplay.DisplayStyles.Success);
                    ScriptManager.RegisterClientScriptBlock(btnUpdate, this.GetType(), "redir", " redidrectomainpage();", true);
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
            txtActualDeposite.Text = "0";
            txtTDSActualAmount.Text = "0";
            txtActualSurcharge.Text = "0";
            txtActualECess.Text = "0";
            txtActualHECess.Text = "0";
            txtActualInterest.Text = "0";
            txtActualOthers.Text = "0";
            txtActualFees.Text = "0";
            txtTDSAdjAmount.Text = "0";
            txtAdjSurcharge.Text = "0";
            txtAdjECess.Text = "0";
            txtAdjHECess.Text = "0";
            txtAdjDeposite.Text = "0";
            txtBalance.Text = "0";
            txtChinDate.Text = "";
            txtBankChinNo.Text = "";
            ddlBankName.SelectedIndex = -1;
            txtBranch.Text = "";
            txtChaqueDate.Text = "";
            txtChequeNo.Text = "";
            ddlNilChallan.SelectedIndex = 1;
            txtChinDate.Text = CommonSettings.ConvertToCulturedDateTime(DateTime.Now.Date).ToString("dd/MM/yyyy");
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            try
            {
                if (Request.QueryString["D"] != null && Request.QueryString["D"] != "")
                {
                    string d = "";
                    if (ddlReturnType.SelectedValue == "26Q")
                    {
                        d = "26Q";
                    }
                    else if (ddlReturnType.SelectedValue == "27Q")
                    {
                        d = "27Q(NRI)";
                    }
                    else if (ddlReturnType.SelectedValue == "27EQ")
                    {
                        d = "27EQ(TCS)";
                    }
                    else
                    {
                        d = "All";
                    }

                    string F = d;
                    string Q = ddlQuaterType.SelectedValue;



                    Response.Redirect("ManageNonSalary_ChallanList.aspx?D=" + F + "," + Q, false);
                }
                else
                {
                    Response.Redirect("ManageNonSalary_ChallanList.aspx", false);
                }
                return;
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex, hdnCompanyid.Value);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Success);
            }

        }

        protected void EditMode(string ID)
        {
            hdnNatureList.Value = "";
            objBAL_NonSalaryChallan.CompanyID = Convert.ToInt32(Session["companyid"].ToString());
            objBAL_NonSalaryChallan._Challan_ID = Convert.ToInt32(ID);
            DataSet ds = objBAL_NonSalaryChallan.BAl_EditNonSalaryMode();
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlReturnType.SelectedValue = ds.Tables[0].Rows[0]["Form_Type"].ToString();
                ddlQuaterType.SelectedValue = ds.Tables[0].Rows[0]["Quater"].ToString();
                ///ddlselectedfilter.SelectedValue = ds.Tables[0].Rows[0]["C_Entry"].ToString();
                //trfilter.Visible = false;
                if (Convert.ToBoolean(ds.Tables[0].Rows[0]["Nil_Challan"]))
                { ddlNilChallan.SelectedValue = "1"; }
                else { ddlNilChallan.SelectedValue = "0"; }
                txtBankChinNo.Text = ds.Tables[0].Rows[0]["Bank_Bsrcode"].ToString();
                txtChinDate.Text = CommonSettings.ConvertToCulturedDateTime(ds.Tables[0].Rows[0]["Challan_Date"]).ToString("dd/MM/yyyy");
                if (ds.Tables[0].Rows[0]["Cheque_no"].ToString() != "0" && !string.IsNullOrEmpty(ds.Tables[0].Rows[0]["Cheque_no"].ToString()))
                {
                    txtChequeNo.Text = ds.Tables[0].Rows[0]["Cheque_no"].ToString();
                }

                if (CommonSettings.ConvertToCulturedDateTime(ds.Tables[0].Rows[0]["Cheque_Date"]).ToString("dd/MM/yyyy") != "01/01/2001")
                    txtChaqueDate.Text = CommonSettings.ConvertToCulturedDateTime(ds.Tables[0].Rows[0]["Cheque_Date"]).ToString("dd/MM/yyyy");

                ddlBankName.SelectedValue = ds.Tables[0].Rows[0]["bid_bsr"].ToString();
                txtBranch.Text = ds.Tables[0].Rows[0]["Bank_Bsrcode"].ToString();
                txtBankChinNo.Text = ds.Tables[0].Rows[0]["Challan_No"].ToString();
                txtTDSActualAmount.Text = ds.Tables[0].Rows[0]["TDS_Amount"].ToString();
                txtActualSurcharge.Text = ds.Tables[0].Rows[0]["Surcharge"].ToString();
                txtActualECess.Text = ds.Tables[0].Rows[0]["Education_Cess"].ToString();
                txtActualHECess.Text = ds.Tables[0].Rows[0]["High_Education_Cess"].ToString();
                txtActualInterest.Text = ds.Tables[0].Rows[0]["Interest_Amt"].ToString();
                txtActualFees.Text = ds.Tables[0].Rows[0]["Fees_Amount"].ToString();
                txtActualOthers.Text = ds.Tables[0].Rows[0]["Others_Amount"].ToString();
                txtActualDeposite.Text = ds.Tables[0].Rows[0]["Challan_Amount"].ToString();
                ddlReturnType_SelectedIndexChanged(ddlReturnType, EventArgs.Empty);

                ddlReturnType.Enabled = false;
                lblSelectdReturnType.Text = ddlReturnType.SelectedItem.Text;
                lblSelectedQuarter.Text = ddlQuaterType.SelectedValue;
            }
            if (ds.Tables[1].Rows.Count > 0)
            {
                //for (int i = 0; i < ds.Tables[2].Rows.Count; i++)
                //{
                //    foreach (ListItem item in chkNatures.Items)
                //    {
                //        if (item.Value == ds.Tables[2].Rows[i][0].ToString())
                //        {
                //            item.Selected = true;
                //        }
                //    }
                //}
                //if (ds.Tables[2].Rows.Count > 2)
                //{
                //    //if (ds.Tables[3].Rows.Count > 0)
                //    //{
                //    //    //txtfilterFromDate.Text = ds.Tables[3].Rows[0]["From"].ToString();
                //    //    //txtfilterTodate.Text = ds.Tables[3].Rows[0]["To"].ToString();
                //    //}

                //    List<tbl_Nature> tbl2 = new List<tbl_Nature>();
                //    CommonFunctions co = new CommonFunctions();
                //    foreach (DataRow drrr2 in ds.Tables[2].Rows)
                //    {
                //        tbl2.Add(new tbl_Nature()
                //        {

                //            NatureName = co.GetValue<string>(drrr2["Nature_Name"].ToString()),
                //            Nature_ID = co.GetValue<int>(drrr2["Nature_ID"].ToString()),

                //        });
                //    }

                //    IEnumerable<tbl_Nature> itbl2 = tbl2 as IEnumerable<tbl_Nature>;
                //    var obbbbb2 = itbl2;
                //    hdnNatureList.Value = new JavaScriptSerializer().Serialize(tbl2);

                //}

                List<tbl_Voucher> tbl = new List<tbl_Voucher>();
                CommonFunctions o = new CommonFunctions();
                foreach (DataRow drrr in ds.Tables[1].Rows)
                {
                    tbl.Add(new tbl_Voucher()
                    {
                        Voucher_DT = o.GetValue<DateTime>(drrr["Voucher_DT"].ToString()),
                        Voucher_ID = o.GetValue<int>(drrr["Voucher_ID"].ToString()),
                        Deductee_Name = o.GetValue<string>(drrr["Deductee_Name"].ToString()),
                        Section = o.GetValue<string>(drrr["Section"].ToString()),
                        Voucher_Amount = o.GetValue<float>(drrr["Voucher_Amount"].ToString()),
                        TDS_Amt = o.GetValue<float>(drrr["TDS_Amt"].ToString()),
                        Surcharge_Amt = o.GetValue<float>(drrr["Surcharge_Amt"].ToString()),
                        ECess_Amt = o.GetValue<float>(drrr["ECess_Amt"].ToString()),
                        HECess_Amt = o.GetValue<float>(drrr["HECess_Amt"].ToString()),
                        Total_Tax_Amt = o.GetValue<float>(drrr["Total_Tax_Amt"].ToString()),
                        Nature_Sub_ID = Convert.ToDateTime(o.GetValue<DateTime>(drrr["Voucher_DT"].ToString())).ToString("dd/MM/yyyy"),////////set Foramated Date Format
                        Nature_ID = o.GetValue<int>(drrr["Nature_ID"].ToString()),
                        Deductee_Type = o.GetValue<string>(drrr["Deductee_Type"].ToString()),
                        PAN_NO = o.GetValue<string>(drrr["PAN_NO"].ToString())
                    });
                }

                IEnumerable<tbl_Voucher> itbl = tbl as IEnumerable<tbl_Voucher>;
                var obbbbb = itbl;
                hdnOnEditVOucherJsonVlaues.Value = new JavaScriptSerializer().Serialize(tbl);
                //gvVoucherDetails.DataSource = ds.Tables[1];
                //gvVoucherDetails.DataBind();
                ScriptManager.RegisterClientScriptBlock(btnSubmitNatures, this.GetType(), "checkall", " $(document).ready(function () {OnEditGetSetVOucherList();   }); ", true);
            }
            else
            {
            }
        }
        //protected void btnFilterDateOnSubmit_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        DataSet ds = null;
        //        if (hdnChallanID.Value == "" && string.IsNullOrEmpty(hdnChallanID.Value))
        //        {
        //            if (hdnjavascriptcheckbalues.Value == "" && !string.IsNullOrEmpty(hdnjavascriptcheckbalues.Value))
        //            {
        //                return;
        //            }
        //            hdnjavascriptcheckbalues.Value = hdnjavascriptcheckbalues.Value.TrimEnd(',');
        //            string[] selectedvalue = hdnjavascriptcheckbalues.Value.Split(',');
        //            lblHeader.Text = lblHeader.Text + " : Quarter " + ddlQuaterType.SelectedValue;
        //            //string sssss = ddlselectedfilter.SelectedValue;
        //            this.Clear();
        //            //ddlselectedfilter.SelectedValue = sssss;
        //            DataTable dt = new DataTable();
        //            dt.Columns.Add("Nature_Id");
        //            DataRow dr;
        //            lblSelectdReturnType.Text = ddlReturnType.SelectedItem.Text;
        //            lblSelectedQuarter.Text = ddlQuaterType.SelectedValue;
        //            foreach (string check in selectedvalue)
        //            {
        //                {
        //                    dr = dt.NewRow();
        //                    dr["Nature_Id"] = check;
        //                    dt.Rows.Add(dr);
        //                }
        //            }

        //            objBAL_NonSalaryChallan.CompanyID = Convert.ToInt32(Session["companyid"]);
        //            objBAL_NonSalaryChallan.Quater = ddlQuaterType.SelectedValue;
        //            objBAL_NonSalaryChallan.dtNatureId = dt;
        //            objBAL_NonSalaryChallan.Challan_Date = Convert.ToDateTime(txtfilterFromDate.Text, ci);
        //            objBAL_NonSalaryChallan.Cheque_Date = Convert.ToDateTime(txtfilterTodate.Text, ci);
        //            objBAL_NonSalaryChallan.Form_Type = ddlselectedfilter.SelectedValue;
        //            ds = objBAL_NonSalaryChallan.BAL_GetVoucherListOnNatureSelectionFilter();
        //        }
        //        DataTable dtt = ds.Tables[0];
        //        if (dtt != null)
        //        {
        //            //gvVoucherDetails.DataSource = dtt;
        //            //gvVoucherDetails.DataBind();
        //            //gvVoucherDetails.Visible = true;
        //        }

        //        txtTotalTaxDeposited.Text = "0";
        //        txtTDSAdjAmount.Text = "0";
        //        txtAdjECess.Text = "0";
        //        txtAdjHECess.Text = "0";
        //        txtAdjSurcharge.Text = "0";
        //        txtAdjDeposite.Text = "0";
        //        txtBalance.Text = "0";

        //    }
        //    catch (Exception ex)
        //    {
        //        ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
        //    }
        //}

        public static BAL_NonSalaryChallan obj_Stat_Nonsal = new BAL_NonSalaryChallan();
        [WebMethod]
        public static string GetVoucherList(int compid, string NatureList, string Quarter, int PageIndex, string challanType, string hdnOnPagePresentVoucherIDs, string FromDate, string todate, int PageSize)
        {
            CultureInfo ci = new CultureInfo("en-GB");
            tbl_Voucher_List obj = new tbl_Voucher_List();
            if (PageIndex == 0)
            {
                PageIndex = 1;
            }
            obj.Company_ID = Convert.ToInt32(compid);
            obj.Quarter = Quarter;
            obj.Nature_Sub_ID = NatureList.TrimEnd(',');
            obj.PageIndex = PageIndex;/////////set page index
            obj.Deductee_Type = challanType;
            obj.Deductee_Name = hdnOnPagePresentVoucherIDs;
            obj.Challan_Date = Convert.ToDateTime(FromDate, ci);///from
            obj.Voucher_DT = Convert.ToDateTime(todate, ci);///to
            obj.PageSize = PageSize;
            //obj.Street = Convert.ToDateTime(FromDate, ci).ToString();///from
            //obj.TDS_Certificate = Convert.ToDateTime(todate, ci).ToString();///to
            IEnumerable<tbl_Voucher_List> tbl = obj_Stat_Nonsal.BAL_GetVoucherList_IEnumrable(obj);
            var obbbbb = tbl;
            return new JavaScriptSerializer().Serialize(tbl);
        }



        [WebMethod]
        public static string GetVoucherCount(int compid, string NatureList, string Quarter,  string Deductee_Type)
        {
            CultureInfo ci = new CultureInfo("en-GB");

            tbl_Voucher obj = new tbl_Voucher();
            obj.Company_ID = Convert.ToInt32(compid);
            obj.Quarter = Quarter;
            obj.Nature_Sub_ID = NatureList.TrimEnd(',');

            obj.Deductee_Type = Deductee_Type;


            IEnumerable<tbl_Voucher> tbl = obj_Stat_Nonsal.BAL_GetVoucherList_Count(obj);
            var obbbbb = tbl;
            return new JavaScriptSerializer().Serialize(tbl);
  
        }


        protected void btnExprecd_Click(object sender, EventArgs e)
        {
            //tbl_Voucher_List obj = new tbl_Voucher_List();
            //obj.Company_ID = Convert.ToInt32(Session["companyid"].ToString());
            //obj.Quarter = Session["SelectedQuarter"].ToString();
            //obj.Nature_Sub_ID = NatureList.TrimEnd(',');
             
            //obj.Deductee_Type = challanType;
            //obj.Deductee_Name = hdnOnPagePresentVoucherIDs;
            //obj.Challan_Date = Convert.ToDateTime(txtfilterFromDate.Text, ci);///from
            //obj.Voucher_DT = Convert.ToDateTime(txtfilterTodate.Text, ci);///to
             
            //DataSet ds = new DataSet();
            //ds = obj_Stat_Nonsal.BAL_GetVoucherList_IEnumrable(obj);
        }
    }


}
