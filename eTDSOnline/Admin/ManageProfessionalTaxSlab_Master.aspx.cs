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
    public partial class _manageprofessionaltaxslab : System.Web.UI.Page
    {
        CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
        BAL_State_Master objBAL_State_Master = new BAL_State_Master();
        BAL_Professionaltax_Master objBAL_Professionaltax_Master = new BAL_Professionaltax_Master();
        BAL_Head_Master objBAL_HeadMaster = new BAL_Head_Master();
        BAL_Percentage_Master objBAL_Percentage_Master = new BAL_Percentage_Master();
        BAL_Percentage_Breakup_Master objBAL_Percentage_Breakup_Master = new BAL_Percentage_Breakup_Master();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["companyid"] != null)
                {
                    this.BindStateCombos();
                    //this.BindAddition();
                    //this.BindVariable();

                    //this.BindSlabGrid();
                    ddlState.SelectedValue = "19";
                    this.ddlState_OnSelectedIndexChanged(sender, e);
                }
                else
                {
                    Response.Redirect("~/Default.aspx");
                }
            }
        }



        //protected void BindSlabGrid()
        //{
        //    DataTable dt = new DataTable();
        //    dt.Columns.Add("Slab", typeof(Int32));
        //    dt.Columns.Add("Tax", typeof(double));
        //    dt.Columns.Add("FromAmount", typeof(double));
        //    dt.Columns.Add("ToAmount", typeof(double));

        //    for (int intIndex = 0; intIndex < 10; intIndex++)
        //    {
        //        dt.Rows.Add((intIndex + 1), 0, 0, 0);
        //    }

        //    dgSlab.DataSource = dt;
        //    dgSlab.DataBind();

        //    foreach (DataGridItem item in dgSlab.Items)
        //    {
        //        item.Cells[0].Text = (item.ItemIndex + 1).ToString();
        //    }
        //}

        private void BindStateCombos()
        {
            DataSet ds = objBAL_State_Master.Get_State_Master_List();
            CommonSettings.LoadCombo(ddlState, ds.Tables[0], "State_Name", "State_ID", true, "(Select State)");
        }

        //protected void BindAddition()
        //{
        //    try
        //    {
        //        objBAL_HeadMaster = new BAL_Head_Master();
        //        objBAL_HeadMaster._Head_Group = HEAD_GROUP.ADDITION.ToString();
        //        objBAL_HeadMaster._Company_ID = int.Parse(Session["companyid"].ToString());

        //        DataSet ds = objBAL_HeadMaster.Get_Head_Master_List();

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            dgAddition.Visible = true;
        //            dgAddition.DataSource = ds;
        //            dgAddition.DataBind();

        //            foreach (DataGridItem item in dgAddition.Items)
        //            {
        //                item.Cells[0].Text = (item.ItemIndex + 1).ToString();
        //            }

        //            lblAdditionsGridMessage.Text = "";
        //        }
        //        else
        //        {
        //            dgAddition.Visible = false;
        //            lblAdditionsGridMessage.Text = "No record found.";
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
        //    }
        //}

        //protected void BindVariable()
        //{
        //    try
        //    {

        //        objBAL_HeadMaster = new BAL_Head_Master();
        //        objBAL_HeadMaster._Head_Group = HEAD_GROUP.VARIABLE.ToString();
        //        objBAL_HeadMaster._Company_ID = int.Parse(Session["companyid"].ToString());
        //        DataSet ds = objBAL_HeadMaster.Get_Head_Master_List();

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            dgVariable.Visible = true;
        //            dgVariable.DataSource = ds;
        //            dgVariable.DataBind();

        //            foreach (DataGridItem item in dgVariable.Items)
        //            {
        //                item.Cells[0].Text = (item.ItemIndex + 1).ToString();
        //            }

        //            lblVariableMessage.Text = "";
        //        }
        //        else
        //        {
        //            dgVariable.Visible = false;
        //            lblVariableMessage.Text = "No record found.";
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
        //    }
        //}


        protected void ddlState_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                DataSet ds;
                // Bind Slab Grid for Male & female
                if (!string.IsNullOrEmpty(ddlState.SelectedValue))
                {
                    objBAL_Professionaltax_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                    objBAL_Professionaltax_Master._State_ID = Convert.ToInt32(ddlState.SelectedValue);
                    ds = objBAL_Professionaltax_Master.Get_Professionaltax_Master_List();
                    dgSlab.DataSource = ds.Tables[0];
                    dgSlab.DataBind();
                    GrdFemale.DataSource = ds.Tables[1];
                    GrdFemale.DataBind();
                    ds = null;
                }
                //Hashtable hashtable = new Hashtable();
                //this.BindAddition();
                //this.BindVariable();


                // bind head Grid
                if (!string.IsNullOrEmpty(ddlState.SelectedValue))
                {
                    objBAL_Professionaltax_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                    objBAL_Professionaltax_Master._State_ID = Convert.ToInt32(ddlState.SelectedValue);

                    ds = objBAL_Professionaltax_Master.Get_Professionaltax_Heads();
                    dgAddition.DataSource = ds.Tables[0];
                    dgAddition.DataBind();
                    dgVariable.DataSource = ds.Tables[1];
                    dgVariable.DataBind();

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
                objBAL_Professionaltax_Master._State_ID = Convert.ToInt32(ddlState.SelectedValue);
                objBAL_Professionaltax_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                objBAL_Professionaltax_Master._CHead_ID = 6;
                DataSet pds = objBAL_Professionaltax_Master.Get_Professionaltax_HeadID();

                if (pds.Tables[0].Rows.Count > 0)
                {
                    int i = Convert.ToInt32(pds.Tables[0].Rows[0][0].ToString());
                    objBAL_Professionaltax_Master._Professionaltax_ID = i;
                }

                DataSet ds = objBAL_Professionaltax_Master.Delete_Professionaltax_Master_By_StateID();

                if (ds.Tables[0].Rows.Count <= 0)
                {
                    ucMessageControl.SetMessage("Error occured while delete professional tax.", MessageDisplay.DisplayStyles.Error);
                    return;
                }

                int Calculation_Head_ID = 6; // it is manual for PTax
                DataSet ds1 = new DataSet();
                objBAL_Percentage_Master._CHead_ID = Calculation_Head_ID;
                objBAL_Percentage_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                objBAL_Percentage_Master._Head_ID = objBAL_Professionaltax_Master._Professionaltax_ID;

                objBAL_Percentage_Master._Percent_Val = 0;
                objBAL_Percentage_Master._State_ID = Convert.ToInt32(ddlState.SelectedValue);



                ds = objBAL_Percentage_Master.Insert_Percentage_Master();
                int Percentage_ID = 0;
                if (ds.Tables[0].Rows.Count <= 0)
                {
                    ucMessageControl.SetMessage("Error occured while save professional tax.", MessageDisplay.DisplayStyles.Error);
                    return;
                }
                else
                {
                    objBAL_Percentage_Breakup_Master._Percentage_ID = Convert.ToInt32(ds.Tables[0].Rows[0][0].ToString());
                    Percentage_ID = Convert.ToInt32(ds.Tables[0].Rows[0][0].ToString());
                }

                //------Percentage Breakup Master----


                int Head_ID = 0;


                if (dgAddition.Items.Count > 0)
                {
                    foreach (DataGridItem item in dgAddition.Items)
                    {
                        Head_ID = Convert.ToInt32(dgAddition.DataKeys[item.ItemIndex]);
                        CheckBox chkCheck = (CheckBox)item.FindControl("chkCheckAddition");

                        if (chkCheck.Checked)
                        {
                            objBAL_Percentage_Breakup_Master._Percentage_ID = Percentage_ID;
                            objBAL_Percentage_Breakup_Master._Head_ID = Head_ID;
                            objBAL_Percentage_Breakup_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                            objBAL_Percentage_Breakup_Master._Calculation_Head_ID = 6;
                            //objBAL_Percentage_Breakup_Master._State_ID = 90;

                            ds = objBAL_Percentage_Breakup_Master.Insert_Percentage_Breakup_Master();
                        }
                    }
                }

                if (ds.Tables[0].Rows.Count <= 0)
                {
                    ucMessageControl.SetMessage("Error occured while save professional tax.", MessageDisplay.DisplayStyles.Error);
                    return;
                }

                if (dgVariable.Items.Count > 0)
                {
                    foreach (DataGridItem item in dgVariable.Items)
                    {
                        Head_ID = Convert.ToInt32(dgVariable.DataKeys[item.ItemIndex]);
                        CheckBox chkCheck = (CheckBox)item.FindControl("chkCheckVariable");

                        if (chkCheck.Checked)
                        {
                            objBAL_Percentage_Breakup_Master._Percentage_ID = Percentage_ID;
                            objBAL_Percentage_Breakup_Master._Head_ID = Head_ID;
                            objBAL_Percentage_Breakup_Master._Company_ID = int.Parse(Session["companyid"].ToString());
                            objBAL_Percentage_Breakup_Master._Calculation_Head_ID = 6;
                            ds = objBAL_Percentage_Breakup_Master.Insert_Percentage_Breakup_Master();
                        }
                    }
                }

                if (ds.Tables[0].Rows.Count <= 0)
                {
                    ucMessageControl.SetMessage("Error occured while save professional tax.", MessageDisplay.DisplayStyles.Error);
                    return;
                }
                ucMessageControl.SetMessage("Professional tax has been saved successfull.", MessageDisplay.DisplayStyles.Success);
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                ucMessageControl.SetMessage(ex.Message, MessageDisplay.DisplayStyles.Error);
            }
        }

    }
}