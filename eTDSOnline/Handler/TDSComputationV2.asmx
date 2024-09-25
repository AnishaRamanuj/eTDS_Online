<%@ WebService Language="C#" Class="TDSComputationV2" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Data;

using EntityLibrary;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using Microsoft.ApplicationBlocks1.Data;
using LibCommon;
using System.Linq;
using System.Configuration;


[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class TDSComputationV2 : System.Web.Services.WebService
{


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string FillEmployeeName( int compid)
    {
        DataSet ds;
        try
        {
            DALCommonLib objComm = new DALCommonLib();
            Functions4evr Comm = new Functions4evr();

            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@compid", Session["companyid"]);

            ds = SqlHelper.ExecuteDataset(objComm._cnnString, CommandType.StoredProcedure, "usp_Bootstrap_Get_Employees", param);

        }
        catch (Exception ex)
        {
            throw ex;
        }
        return ds.GetXml();
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetAllEmployeeComputionSummaryV2(tblGetColData tobj)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
        string cid = Session["companyid"].ToString();
        List<tblTDSComputationSummary> LTDS = new List<tblTDSComputationSummary>();
        try
        {
            SqlParameter[] param = new SqlParameter[6];
            param[0] = new SqlParameter("@CompanyID", tobj.CompanyID);
            param[1] = new SqlParameter("@PageIndex", tobj.PageIndex);
            param[2] = new SqlParameter("@PageSize", tobj.PageSize);
            param[3] = new SqlParameter("@SearchVal", tobj.SearchVal);
            param[4] = new SqlParameter("@FilterById", tobj.FilterById);
            param[5] = new SqlParameter("@financialyr", tobj.ConnectionString);

            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "usp_BootStrap_EmployeeComputionSummaryV2", param))
            {
                while (drrr.Read())
                {
                    LTDS.Add(new tblTDSComputationSummary()
                    {
                        RecordCount = Comm.GetValue<int>(drrr["RecordCount"].ToString()),
                        RowNumber = Comm.GetValue<int>(drrr["RowNumber"].ToString()),
                        Employee_ID = Comm.GetValue<int>(drrr["Employee_ID"].ToString()),
                        FirstName = Comm.GetValue<string>(drrr["FirstName"].ToString()),
                        PanNumber = Comm.GetValue<string>(drrr["PanNumber"].ToString()),
                        SumofSalary = Comm.GetValue<double>(drrr["SumofSalary"].ToString()),
                        GrossEarn8 = Comm.GetValue<double>(drrr["GrossEarn8"].ToString()),
                        Grossnet = Comm.GetValue<double>(drrr["Grossnet"].ToString()),
                        TotalRebate = Comm.GetValue<double>(drrr["TotalRebate"].ToString()),
                        Itax3 = Comm.GetValue<double>(drrr["Itax3"].ToString()),
                        ChallanTDS = Comm.GetValue<double>(drrr["Challan_TAX"].ToString()),
                        FinalTax = Comm.GetValue<double>(drrr["FinalTax"].ToString()),
                        EmailAdd = Comm.GetValue<string>(drrr["Email_ID"].ToString()),

                    });
                }
                List<tblGetColData> LFilterList = new List<tblGetColData>();
                if (drrr.NextResult())
                {
                    while (drrr.Read())
                    {
                        LFilterList.Add(new tblGetColData()
                        {
                            FilterById = Comm.GetValue<int>(drrr["FilterById"].ToString()),
                            FilterByVal = Comm.GetValue<string>(drrr["FilterByVal"].ToString())
                        });
                    }
                }
                List<tblChallanSummary> LtblChallan = new List<tblChallanSummary>();
                foreach (tblTDSComputationSummary i in LTDS)
                {
                    i.ChallanSummary = LtblChallan.Where(x => x.Employee_ID == i.Employee_ID).OrderBy(x => x.Quater).ToList();
                    i.FilterList = LFilterList;
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<tblTDSComputationSummary> tbl =  LTDS;
        return new JavaScriptSerializer().Serialize(tbl);


    }



    [System.Web.Services.WebMethod(EnableSession = true)]
    public string getEmployeeComputationV2(Tbl_TDS_Computation tobj)
    {
        DataSet ds;
        try
        {
            DALCommonLib objComm = new DALCommonLib();
            Functions4evr Comm = new Functions4evr();
            string cid = Session["companyid"].ToString();
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@Company_ID", Session["companyid"]);
            param[1] = new SqlParameter("@Employee_ID", tobj.Employee_ID);

            ds = SqlHelper.ExecuteDataset(objComm._cnnString2, CommandType.StoredProcedure, "usp_Bootstrap_getEmployeeComputation", param);

        }
        catch (Exception ex)
        {
            throw ex;
        }
        return ds.GetXml();
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string getDefaultValues(int ids)
    {
        List<tbl_Slabs> Slabs = new List<tbl_Slabs>();

        try
        {
            DALCommonLib objComm = new DALCommonLib();
            Functions4evr Comm = new Functions4evr();
            string cid = Session["companyid"].ToString();
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@Company_ID", Session["companyid"]);


            using (SqlDataReader drrr =  SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "usp_BootStrap_DefaultSlabs", param))
            {
                while (drrr.Read())
                {
                    Slabs.Add(new tbl_Slabs()
                    {
                        Company_ID = Comm.GetValue<int>(drrr["Company_ID"].ToString()),
                    });
                }

                List<tbl_Rebate_Limits> Ltbl_Rebate_Limits = new List<tbl_Rebate_Limits>();
                if (drrr.NextResult())
                {

                    while (drrr.Read())
                    {
                        Ltbl_Rebate_Limits.Add(new tbl_Rebate_Limits()
                        {
                            Rebate_Name = Comm.GetValue<string>(drrr["Rebate_Name"].ToString()),
                            Rebate_Limit = Comm.GetValue<double>(drrr["Rebate_Limit"].ToString()),
                            Salary_Limit = Comm.GetValue<double>(drrr["Salary_Limit"].ToString())
                        });
                    }
                }

                List<tbl_Surcharge_Slab> tblsurcharge = new List<tbl_Surcharge_Slab>();
                if (drrr.NextResult())
                {
                    while (drrr.Read())
                    {
                        tblsurcharge.Add(new tbl_Surcharge_Slab()
                        {
                            SurchargePer = Comm.GetValue<double>(drrr["Surcharge_Percent"].ToString()),
                            SurchargeSalary = Comm.GetValue<double>(drrr["Taxable_Salary"].ToString()),
                            Marginal_Surcharge = Comm.GetValue<double>(drrr["Marginal_Amount"].ToString()),
                            App_Type = Comm.GetValue<string>(drrr["App_Type"].ToString()),
                            Surchargetype = Comm.GetValue<string>(drrr["Surchargetype"].ToString()),
                        });
                    }
                }
                List<tbl_Incometax_Master_Multi> tblIncomeTax115 = new List<tbl_Incometax_Master_Multi>();
                if (drrr.NextResult())
                {
                    while (drrr.Read())
                    {
                        tblIncomeTax115.Add(new tbl_Incometax_Master_Multi()
                        {
                            SlabTitle = Comm.GetValue<string>(drrr["SlabTitle"].ToString()),
                            SlabSubTitle = Comm.GetValue<string>(drrr["SlabSubTitle"].ToString()),
                            Slab = Comm.GetValue<float>(drrr["Slab"].ToString()),
                            Tax_Amount = Comm.GetValue<double>(drrr["Tax_Amount"].ToString()),
                        });
                    }
                }

                List<tblEmployeeTDSReletatedOtherDetails> LtblEmployeeTDSReletatedOtherDetails = new List<tblEmployeeTDSReletatedOtherDetails>();
                if (drrr.NextResult())
                {

                    while (drrr.Read())
                    {
                        LtblEmployeeTDSReletatedOtherDetails.Add(new tblEmployeeTDSReletatedOtherDetails()
                        {
                            SurchargePer = Comm.GetValue<string>(drrr["SurchargePer"].ToString()),
                            Cessper = Comm.GetValue<string>(drrr["Cessper"].ToString()),
                            HCessper = Comm.GetValue<string>(drrr["HCessper"].ToString()),
                            HealthPer = Comm.GetValue<string>(drrr["HealthPer"].ToString()),

                        });
                    }
                }
                foreach (var item in Slabs)
                {
                    item.IBacTax = tblIncomeTax115;
                    item.LtblEmployeeTDSReletatedOtherDetails = LtblEmployeeTDSReletatedOtherDetails;
                    item.Rebate_Limits = Ltbl_Rebate_Limits;
                    item.SurchargeSlab = tblsurcharge;
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<tbl_Slabs> tbl =  Slabs;
        return new JavaScriptSerializer().Serialize(tbl);
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string SaveComputation(string rec, string rb, string sal, string pq, string sec, int Eid)
    {
        DataSet ds;
        try
        {
            DALCommonLib objComm = new DALCommonLib();
            Functions4evr Comm = new Functions4evr();
            string cid = Session["companyid"].ToString();

            SqlParameter[] param = new SqlParameter[7];
            param[0] = new SqlParameter("@Company_ID", Session["companyid"]);
            param[1] = new SqlParameter("@rec", rec);
            param[2] = new SqlParameter("@rb", rb);
            param[3] = new SqlParameter("@sal", sal);
            param[4] = new SqlParameter("@sec", sec);

            param[5] = new SqlParameter("@pq", pq);
            param[6] = new SqlParameter("@eid", Eid);

            ds = SqlHelper.ExecuteDataset(objComm._cnnString2, CommandType.StoredProcedure, "usp_Bootstrap_Save_Computation", param);

        }
        catch (Exception ex)
        {
            throw ex;
        }
        return ds.GetXml();
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string getEmployeeHraDetails(Tbl_TDS_Computation tobj)
    {
        DataSet ds;
        try
        {
            DALCommonLib objComm = new DALCommonLib();
            Functions4evr Comm = new Functions4evr();
            string cid = Session["companyid"].ToString();
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@Company_ID", Session["companyid"]);
            param[1] = new SqlParameter("@Employee_ID", tobj.Employee_ID);

            ds = SqlHelper.ExecuteDataset(objComm._cnnString2, CommandType.StoredProcedure, "usp_BootStrap_getEmployee_Hra", param);

        }
        catch (Exception ex)
        {
            throw ex;
        }
        return ds.GetXml();
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string SaveHRR(string sal, int Hrr, int Eid)
    {
        DataSet ds;
        try
        {
            DALCommonLib objComm = new DALCommonLib();
            Functions4evr Comm = new Functions4evr();
            string cid = Session["companyid"].ToString();

            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@Company_ID", Session["companyid"]);

            param[1] = new SqlParameter("@sal", sal);

            param[2] = new SqlParameter("@Hrr", Hrr);

            param[3] = new SqlParameter("@eid", Eid);

            ds = SqlHelper.ExecuteDataset(objComm._cnnString2, CommandType.StoredProcedure, "usp_Bootstrap_Save_Hra_Rent_Calculation", param);

        }
        catch (Exception ex)
        {
            throw ex;
        }
        return ds.GetXml();
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string UpdateEmployeeEmailInfo(int eid, string em)

    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
        List<tblTDSComputationSummary> obj = new List<tblTDSComputationSummary>();
        try
        {
            SqlParameter[] param = new SqlParameter[3];

            param[0] = new SqlParameter("@eid", eid);
            param[1] = new SqlParameter("@em", em);
            param[2] = new SqlParameter("@Company_ID", Session["companyid"]);


            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString, CommandType.StoredProcedure, "usp_Bootstrap_Update_Employee_email", param))
            {
                while (drrr.Read())
                {
                    obj.Add(new tblTDSComputationSummary()
                    {
                        Employee_ID = Comm.GetValue<int>(drrr["Employee_ID"].ToString()),
                        EmailAdd =Comm.GetValue<string>(drrr["Email_ID"].ToString()),
                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<tblTDSComputationSummary> tbl = obj as IEnumerable<tblTDSComputationSummary>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }
    /// ///////////////////////////////////////////////////////////////////////////////////


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string getEmployeeRentDetails(int Emplolyee_ID, int Company_ID, string Conn)
    {

        List<Tbl_TDS_Computation> obj = new List<Tbl_TDS_Computation>();
        try
        {
            if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
            {
                HttpContext.Current.Session["Financial_Year_Text"] = Conn;
            }

            DALCommonLib objComm = new DALCommonLib();
            Functions4evr Comm = new Functions4evr();
            string cid = Session["companyid"].ToString();

            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@Employee_ID", Emplolyee_ID);
            param[1] = new SqlParameter("@Company_ID", Company_ID);


            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "usp_getEmployeeRentDetails", param))
            {
                while (drrr.Read())
                {
                    obj.Add(new Tbl_TDS_Computation()
                    {

                    });
                }

            }

            //IEnumerable<Tbl_TDS_Computation> tbl = objBAL_TDSComputation.BAL_getEmployeeRentDetails(Emplolyee_ID, Company_ID, Conn);
            //foreach (var item in tbl)
            //{
            //    if (item.Frm_DT_superannuation_fund != DateTime.MinValue)
            //    {
            //        item.Frm_DT_superannuation_fund_string = Convert.ToDateTime(item.Frm_DT_superannuation_fund).ToString("dd/MM/yyyy");
            //    }
            //    if (item.TO_DT_superannuation_fund != DateTime.MinValue)
            //    {
            //        item.TO_DT_superannuation_fund_string = Convert.ToDateTime(item.TO_DT_superannuation_fund).ToString("dd/MM/yyyy");
            //    }
            //}
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<Tbl_TDS_Computation> tbl =  obj;
        return new JavaScriptSerializer().Serialize(tbl);
    }


    //[System.Web.Services.WebMethod(EnableSession = true)]
    //public string getSurchargeSlab(int Company_ID, string Conn)
    //{
    //    if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
    //    {
    //        HttpContext.Current.Session["Financial_Year_Text"] = Conn;
    //    }
    //    IEnumerable<tbl_Surcharge_Slab> tbl = objBAL_TDSComputation.BAL_getSurchargeSlab(Company_ID, Conn);

    //    return new JavaScriptSerializer().Serialize(tbl);
    //}

    //[System.Web.Services.WebMethod(EnableSession = true)]
    //public string getIncomeTAX115(int Company_ID, string Emp, string Conn)
    //{
    //    if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
    //    {
    //        HttpContext.Current.Session["Financial_Year_Text"] = Conn;
    //    }
    //    IEnumerable<tbl_Incometax_Master> tbl = objBAL_TDSComputation.BAL_getIncomeTax115(Company_ID,Emp, Conn);

    //    return new JavaScriptSerializer().Serialize(tbl);
    //}

    //[System.Web.Services.WebMethod(EnableSession = true)]
    //public int setEmployeeRentDetails(Tbl_TDS_Computation tobj)
    //{
    //    if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(tobj.ConnectionString))
    //    {
    //        HttpContext.Current.Session["Financial_Year_Text"] = tobj.ConnectionString;
    //    }
    //    if (tobj.Rent_Payment == false)
    //    {
    //        tobj.PAN_landlord1 = "";
    //        tobj.PAN_landlord2 = "";
    //        tobj.PAN_landlord3 = "";
    //        tobj.PAN_landlord4 = "";
    //        tobj.Name_landlord1 = "";
    //        tobj.Name_landlord2 = "";
    //        tobj.Name_landlord3 = "";
    //        tobj.Name_landlord4 = "";
    //    }
    //    if (tobj.Interest_lender == false)
    //    {
    //        tobj.PAN_lender1 = "";
    //        tobj.PAN_lender2 = "";
    //        tobj.PAN_lender3 = "";
    //        tobj.PAN_lender4 = "";
    //        tobj.Name_lender1 = "";
    //        tobj.Name_lender2 = "";
    //        tobj.Name_lender3 = "";
    //        tobj.Name_lender4 = "";
    //    }
    //    if (tobj.Contributions_superannuation_fund == false)
    //    {
    //        tobj.Name_superannuation_fund = "";
    //        tobj.Frm_DT_superannuation_fund = null;
    //        tobj.TO_DT_superannuation_fund = null;
    //        tobj.principal_interest_superannuation_fund = 0;
    //        tobj.Rate_deduction_tax_3yrs = 0;
    //        tobj.Repayment_superannuation_fund = 0;
    //        tobj.Total_Income_superannuation_fund = 0;
    //    }

    //    int count = 4;
    //    if (string.IsNullOrEmpty(tobj.PAN_landlord1) && string.IsNullOrEmpty(tobj.Name_landlord1))
    //    { count -= 1; }
    //    if (string.IsNullOrEmpty(tobj.PAN_landlord2) && string.IsNullOrEmpty(tobj.Name_landlord2))
    //    { count -= 1; }
    //    if (string.IsNullOrEmpty(tobj.PAN_landlord3) && string.IsNullOrEmpty(tobj.Name_landlord3))
    //    { count -= 1; }
    //    if (string.IsNullOrEmpty(tobj.PAN_landlord4) && string.IsNullOrEmpty(tobj.Name_landlord4))
    //    { count -= 1; }
    //    tobj.Count_PAN_landlord = count;

    //    if (count == 0)
    //    { tobj.Rent_Payment = false; }

    //    count = 4;
    //    if (string.IsNullOrEmpty(tobj.PAN_lender1) && string.IsNullOrEmpty(tobj.Name_lender1))
    //    { count -= 1; }
    //    if (string.IsNullOrEmpty(tobj.PAN_lender2) && string.IsNullOrEmpty(tobj.Name_lender2))
    //    { count -= 1; }
    //    if (string.IsNullOrEmpty(tobj.PAN_lender3) && string.IsNullOrEmpty(tobj.Name_lender3))
    //    { count -= 1; }
    //    if (string.IsNullOrEmpty(tobj.PAN_lender4) && string.IsNullOrEmpty(tobj.Name_lender4))
    //    { count -= 1; }
    //    tobj.Count_PAN_lender = count;

    //    if (count == 0)
    //    { tobj.Interest_lender = false; }

    //    count = 7;
    //    if (string.IsNullOrEmpty(tobj.Name_superannuation_fund))
    //    { count -= 1; }
    //    if (tobj.Frm_DT_superannuation_fund == null)
    //    { count -= 1; }
    //    if (tobj.TO_DT_superannuation_fund == null)
    //    { count -= 1; }
    //    if (tobj.principal_interest_superannuation_fund == 0)
    //    { count -= 1; }
    //    if (tobj.Rate_deduction_tax_3yrs == 0)
    //    { count -= 1; }
    //    if (tobj.Repayment_superannuation_fund == 0)
    //    { count -= 1; }
    //    if (tobj.Total_Income_superannuation_fund == 0)
    //    { count -= 1; }

    //    if (count == 0)
    //    { tobj.Contributions_superannuation_fund = false; }

    //    return objBAL_TDSComputation.BAL_setEmployeeRentDetails(tobj);
    //}

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string PANValidation(List<PANs> tobj)
    {
        PANVrf.ConnectTraces CT = new PANVrf.ConnectTraces();

        foreach (var item in tobj)
        {
            bool ErrPan = CT.IsPAN_Valid(item.PANNO);

            if (ErrPan)
                item.PANStatus = "Valid PAN";
            else
                item.PANStatus = "Invalid PAN";
        }

        return new JavaScriptSerializer().Serialize(tobj);
    }

    //[System.Web.Services.WebMethod(EnableSession = true)]
    //public void getEmployeeFormSixteen(Tbl_TDS_Computation tobj)
    //{
    //    if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(tobj.ConnectionString))
    //    {
    //        HttpContext.Current.Session["Financial_Year_Text"] = tobj.ConnectionString;
    //    }
    //    HttpContext.Current.Session["ReportFormSixteenFromTDSComputationEmployeeID"] = tobj.Employee_ID + "," + tobj.Company_ID + "," + tobj.LastName;
    //}


    //[System.Web.Services.WebMethod(EnableSession = true)]
    //public string getHRARentReciept_Grd(int empid, string Conn)
    //{
    //    if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
    //    {
    //        HttpContext.Current.Session["Financial_Year_Text"] = Conn;
    //    }
    //    IEnumerable<tbl_HRR> tbl = objBAL_TDSComputation.BAL_getHRR_Grd(empid, Conn);

    //    return new JavaScriptSerializer().Serialize(tbl);
    //}

    //[System.Web.Services.WebMethod(EnableSession = true)]
    //public string UpadteHRR(int Compid, string Conn, int empid, string Multi)
    //{
    //    if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
    //    {
    //        HttpContext.Current.Session["Financial_Year_Text"] = Conn;
    //    }
    //    IEnumerable<tbl_HRR> tbl = objBAL_TDSComputation.BAL_SaveHRR(Compid,empid, Conn, Multi);

    //    return new JavaScriptSerializer().Serialize(tbl);
    //}



    ///////////////  for generating PDFs 


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string generateFrom16(int Empid)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
        DataSet ds;
        List<tbl_TDS_Computation> tblComputation = new List<tbl_TDS_Computation>();
        List<FileMailing> tblMail = new List<FileMailing>();
        try
        {
            //SqlParameter[] param = new SqlParameter[2];

            //param[0] = new SqlParameter("@eid", Empid);
            //param[1] = new SqlParameter("@Company_ID", Session["companyid"]);
            //ds = SqlHelper.ExecuteDataset(objComm._cnnString2, CommandType.StoredProcedure, "usp_ReportForm16_GetEmployeeComputationDetails", param);

            //////////////delcarations and inistialize objects
            //string CompanyName = "", CompanyAddress = "", AssesmentYear = "", Fromdate = "", Todate = "";
            string mergedBody = "", form16table = "";

            //if (ds.Tables[0].Rows.Count > 0)
            //{
            //    AssesmentYear = "";

            //    string[] finyer = fin_year.Split('_');
            //    Fromdate = finyer[0];
            //    Todate = "20" + finyer[1];
            //    AssesmentYear = (Convert.ToInt32(Fromdate) + 1).ToString() + "-" + (Convert.ToInt32(Todate) + 1).ToString();

            //    /////////set Company Details
            //    CompanyName = ds.Tables[0].Rows[0]["flat_no"].ToString();
            //    CompanyAddress += ds.Tables[0].Rows[0]["flat_no"].ToString();




            //    CompanyAddress += ",<br>";

            //    CompanyAddress += ds.Tables[0].Rows[0]["flat_no"].ToString();


            //    CompanyAddress += ds.Tables[0].Rows[0]["Street"].ToString();

            //    CompanyAddress += ds.Tables[0].Rows[0]["Area_Location"].ToString();




            //{
            //    if (!string.IsNullOrEmpty(tblCompany.Select(x => x.Town_City).FirstOrDefault().ToString()))
            //        if (!string.IsNullOrEmpty(CompanyAddress))
            //            CompanyAddress += ",<br>";

            //    CompanyAddress += tblCompany.Select(x => x.Town_City).FirstOrDefault().ToString();
            //}

            //if (!string.IsNullOrEmpty(CompanyAddress))
            //    CompanyAddress += ".";

            string getForm16 = HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings["GetFrom16Body"].ToString());

            getForm16 = objComm.ReturnHTML(getForm16);

            //foreach (var row in tblComputation)
            //{
            form16table = getForm16;
            //    ///set employee details
            //    form16table = form16table.Replace("[XNameandAddressoftheEmployerX]", CompanyName + "</br>" + CompanyAddress);
            //    form16table = form16table.Replace("[XNameanddesignationoftheEmployeeX]", row.EmpName);
            //    form16table = form16table.Replace("[XXPANNoofTheDeducteeXXXX]", tblCompany.Select(x => x.PANNo).FirstOrDefault().ToString().ToUpper());
            //    form16table = form16table.Replace("[XXXTANNooftheDeducteeXXX]", tblCompany.Select(x => x.TANNo).FirstOrDefault().ToString().ToUpper());
            //    form16table = form16table.Replace("[XXXPANNooftheEmployeeXXX]", row.PanNo.ToUpper());
            //    form16table = form16table.Replace("[XXXAssessmentYearXXX]", AssesmentYear);
            //    form16table = form16table.Replace("[XXXFromXXX]", "01/04/" + Fromdate);
            //    form16table = form16table.Replace("[XXXToXXX]", "31/03/" + Todate);
            //    ///computation details
            //    form16table = form16table.Replace("[XXXXXTotal_EarningsXXXXXXX]", row.Total_Earnings.ToString());
            //    form16table = form16table.Replace("[XXXXXGrossPerks_BXXXXXXX]", row.GrossPerks_B.ToString());
            //    form16table = form16table.Replace("[XXXXXGrossProfits_CXXXXXXX]", row.GrossProfits_C.ToString());
            //    form16table = form16table.Replace("[XXXXGrossEarn1XXXXXXXX]", row.GrossEarn1.ToString());


            //    //////////////make table from section 10
            //    string Section10Table = "";
            //    foreach (var section10 in tblSection10.Where(x => x.Employee_ID == row.Employee_ID).ToList())
            //    {
            //        Section10Table += "<tr>";
            //        Section10Table += "<td class='bottomborder rightborder'>";
            //        Section10Table += section10.Head_Name;
            //        Section10Table += "</td>";
            //        Section10Table += "<td class='bottomborder makeright'>";
            //        Section10Table += section10.Amount;
            //        Section10Table += "</td>";
            //        Section10Table += "</tr>";
            //    }
            //    form16table = form16table.Replace("[XXXXXSection_10XXXXX]", row.Section_10.ToString());
            //    form16table = form16table.Replace("[XXXXXXXSection10HeadsXXXXXXXX]", Section10Table);
            //    form16table = form16table.Replace("[XXXXGrossEarn3XXXXXXXX]", row.GrossEarn3.ToString());

            //    form16table = form16table.Replace("[XXXXSTDedXXXXXXXX]", row.StandardDeductions.ToString());
            //    form16table = form16table.Replace("[XXXXEntertainmentXXXXXXXX]", row.Entertainment.ToString());
            //    form16table = form16table.Replace("[XXXXPTaxXXXXXXXX]", row.PTax.ToString());
            //    form16table = form16table.Replace("[XXXXTotalDeductionXXXXXXXX]", row.TotalDeduction.ToString());
            //    form16table = form16table.Replace("[XXXXGrossEarn5XXXXXXXX]", row.GrossEarn5.ToString());
            //    form16table = form16table.Replace("[XXXXOtherIncomeXXXXXXXX]", row.OtherIncome.ToString());
            //    form16table = form16table.Replace("[XXXXIntHouseLoanXXXXXXXX]", row.IntHouseLoan.ToString());
            //    form16table = form16table.Replace("[XXXXGrossEarn8XXXXXXXX]", row.GrossEarn8.ToString());

            //    string Section80C = "";
            //    foreach (var rebate in tblRebate.Where(x => x.Employee_ID == row.Employee_ID).ToList())
            //    {
            //        Section80C += "<tr>";
            //        Section80C += "<td class='bottomborder rightborder'>";
            //        Section80C += rebate.Head_Name;
            //        Section80C += "</td>";
            //        Section80C += "<td class='bottomborder makeright'>";
            //        Section80C += rebate.Amount;
            //        Section80C += "</td>";
            //        Section80C += "</tr>";
            //    }
            //    form16table = form16table.Replace("[XXXXXXXSection80CXXXXXXXX]", Section80C);

            //    form16table = form16table.Replace("[XXXXsection80CCCXXXXXXXX]", row.Rebate80CCC.ToString());
            //    form16table = form16table.Replace("[XXXXsection80CCDXXXXXXXX]", row.Rebate80CCD.ToString());
            //    form16table = form16table.Replace("[XXXXsection80CCD2XXXXXXXX]", row.Rebate80CCD2.ToString());
            //    form16table = form16table.Replace("[XXXXsection80CCD21BXXXXXXXX]", row.Rebate80CCD21B.ToString());
            //    form16table = form16table.Replace("[XXXXXSection80CCGXXXXXXX]", row.Rebate80CCG.ToString());
            //    form16table = form16table.Replace("[XXXXXSection80DXXXXXXX]", row.Rebate88D.ToString());
            //    form16table = form16table.Replace("[XXXXXSection80DDXXXXXXX]", row.Rebate80DD.ToString());
            //    form16table = form16table.Replace("[XXXXXSection80DDBXXXXXXX]", row.Rebate80DDB.ToString());
            //    form16table = form16table.Replace("[XXXXXSection80EXXXXXXX]", row.Rebate80E.ToString());
            //    form16table = form16table.Replace("[XXXXXSection80EEXXXXXXX]", row.Rebate80EE.ToString());
            //    form16table = form16table.Replace("[XXXXXSection80GXXXXXXX]", row.Rebate80G.ToString());
            //    form16table = form16table.Replace("[XXXXXSection80GGXXXXXXX]", row.Rebate80GG.ToString());
            //    form16table = form16table.Replace("[XXXXXSection80GGAXXXXXXX]", row.Rebate80GGA.ToString());
            //    form16table = form16table.Replace("[XXXXXSection80GGCXXXXXXX]", row.Rebate80GGC.ToString());
            //    form16table = form16table.Replace("[XXXXXSection80QQBXXXXXXX]", row.Rebate80QQB.ToString());
            //    form16table = form16table.Replace("[XXXXXSection80RRBXXXXXXX]", row.Rebate80RRB.ToString());
            //    form16table = form16table.Replace("[XXXXXSection80UXXXXXXX]", row.Rebate80U.ToString());
            //    form16table = form16table.Replace("[XXXXXSection80TTAXXXXXXX]", row.Rebate80TTA.ToString());

            //    ////set all qulifiying amt
            //    form16table = form16table.Replace("[XXXXXXXXXXXX]", "0");

            //    form16table = form16table.Replace("[XXXXXTotalRebateXXXXXXX]", row.TotalRebate.ToString());

            //    form16table = form16table.Replace("[XXXXXGrossnetXXXXXXX]", row.Grossnet.ToString());
            //    ///12
            //    if (row.Grossnet > 4999999)
            //    { form16table = form16table.Replace("[XXXXXItax1XXXXXXX]", row.Itax2.ToString()); }
            //    else
            //    { form16table = form16table.Replace("[XXXXXItax1XXXXXXX]", ((row.Itax1 - row.Rebatetds) + row.Surcharge).ToString()); }
            //    ///13
            //    form16table = form16table.Replace("[XXXXXEducationCessandHighEduCessXXXXXXX]", (row.EducationCess + row.HighEduCess).ToString());
            //    ///14
            //    if (row.Grossnet > 4999999)
            //    { form16table = form16table.Replace("[XXXXXItax2XXXXXXX]", (row.Itax2 + row.EducationCess + row.HighEduCess).ToString()); }
            //    else
            //    { form16table = form16table.Replace("[XXXXXItax2XXXXXXX]", (row.EducationCess + row.HighEduCess + (row.Itax1 - row.Rebatetds)).ToString()); }

            //    ///15
            //    form16table = form16table.Replace("[XXXXXrebate89XXXXXXX]", row.Rebate89.ToString());
            //    ///16
            //    if (row.Grossnet > 4999999)
            //    { form16table = form16table.Replace("[XXXXXitax2andrebate89XXXXXXX]", ((row.EducationCess + row.HighEduCess + row.Itax2) - row.Rebate89).ToString()); }
            //    else
            //    { form16table = form16table.Replace("[XXXXXitax2andrebate89XXXXXXX]", ((row.EducationCess + row.HighEduCess + (row.Itax1 - row.Rebatetds)) - row.Rebate89).ToString()); }


            //    ///certification
            //    form16table = form16table.Replace("[XXXXdesignation]", tblform16.Select(x => x.designation).FirstOrDefault().ToString());
            //    form16table = form16table.Replace("[XXXXXXPlace]", tblform16.Select(x => x.location).FirstOrDefault().ToString());
            //    form16table = form16table.Replace("[XXXPersoname]", tblform16.Select(x => x.personname).FirstOrDefault().ToString());
            //    form16table = form16table.Replace("[XXXreleation]", tblform16.Select(x => x.releation).FirstOrDefault().ToString());
            //    form16table = form16table.Replace("[XXXrelationname]", tblform16.Select(x => x.releationname).FirstOrDefault().ToString());
            //    form16table = form16table.Replace("[XXXXCompanyName]", CompanyName);
            //    form16table = form16table.Replace("[XXXXDate]", date);
            //    BAL_ConvertCurrency ConCurrency = new BAL_ConvertCurrency();
            //    form16table = form16table.Replace("[XXXXXamountinwords]", row.Challan_Tax.ToString() + " " + ConCurrency.RupeeInWords(Convert.ToDouble(row.Challan_Tax)));
            mergedBody += form16table;

            //    if (tblComputation.IndexOf(row) != tblComputation.Count - 1)
            //        mergedBody += "<div style='width:100%; page-break-after:always;'></div><br><br>";
            //}

            string GetHtmlBody = HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings["GetFrom16"].ToString());

            /////////get template body
            string templatebody = objComm.ReturnHTML(GetHtmlBody);
            templatebody = templatebody.Replace("[XXXXTAblbodyXXXXX]", mergedBody);
            ////write pdf
            string PDFpath = "Http://:login.onlinetds.com/eReturns/Mailing";

            string fileName = objComm.WritePDF4Mail(templatebody);

            tblMail.Add(new FileMailing()
            {

                fileName = Comm.GetValue<string>(fileName),
                MailFilePath = Comm.GetValue<string>(PDFpath),
            });

            //objTDSResponse = this.objConnect.ChallanDownload(challan, out filename, out base64);
            //WriteDocument("Form16(Part B).pdf", "application/pdf", templatebody, "Inline");
            //    return "";
            //}
            //    else { return "Error"; }
        }

        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<FileMailing> tbl = tblMail as IEnumerable<FileMailing>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }



    public class PANs
    {
        public string textBoxID { get; set; }

        public string PANNO { get; set; }

        public string PANStatus { get; set; }
    }
}