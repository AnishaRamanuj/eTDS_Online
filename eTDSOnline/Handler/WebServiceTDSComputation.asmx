﻿<%@ WebService Language="C#" Class="WebServiceTDSComputation" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using BusinessLayer;
using CommonLibrary;
using System.Collections.Generic;
using System.Web.Script.Serialization;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class WebServiceTDSComputation : System.Web.Services.WebService
{
    BAL_TDSComputation objBAL_TDSComputation = new BAL_TDSComputation();

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetAllEmployeeComputionSummary(tblGetColData tobj)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(tobj.ConnectionString))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = tobj.ConnectionString;
        }
        IEnumerable<tblTDSComputationSummary> tbl = objBAL_TDSComputation.BAL_GetAllEmployeeComputionSummary(tobj);
        return new JavaScriptSerializer().Serialize(tbl);
    }



    [System.Web.Services.WebMethod(EnableSession = true)]
    public string getEmployeeComputation(Tbl_TDS_Computation tobj)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(tobj.ConnectionString))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = tobj.ConnectionString;
        }
        IEnumerable<Tbl_TDS_Computation> tbl = objBAL_TDSComputation.BAL_getEmployeeComputation(tobj);
        return new JavaScriptSerializer().Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public int setEmployeeComputation(Tbl_TDS_SaveComputation tobj)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(tobj.ConnectionString))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = tobj.ConnectionString;
        }
         HttpContext.Current.Session["companyid"] = tobj.Company_ID.ToString();
        return objBAL_TDSComputation.BAL_SaveEmployeeComputation(tobj);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string getEmployeeRentDetails(int Emplolyee_ID, int Company_ID, string Conn)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        IEnumerable<Tbl_TDS_Computation> tbl = objBAL_TDSComputation.BAL_getEmployeeRentDetails(Emplolyee_ID, Company_ID, Conn);
        foreach (var item in tbl)
        {
            if (item.Frm_DT_superannuation_fund != DateTime.MinValue)
            {
                item.Frm_DT_superannuation_fund_string = Convert.ToDateTime(item.Frm_DT_superannuation_fund).ToString("dd/MM/yyyy");
            }
            if (item.TO_DT_superannuation_fund != DateTime.MinValue)
            {
                item.TO_DT_superannuation_fund_string = Convert.ToDateTime(item.TO_DT_superannuation_fund).ToString("dd/MM/yyyy");
            }
        }
        return new JavaScriptSerializer().Serialize(tbl);
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string getSurchargeSlab(int Company_ID, string Conn)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        IEnumerable<tbl_Surcharge_Slab> tbl = objBAL_TDSComputation.BAL_getSurchargeSlab(Company_ID, Conn);

        return new JavaScriptSerializer().Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string getIncomeTAX115(int Company_ID, string Emp, string Conn)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        IEnumerable<tbl_Incometax_Master> tbl = objBAL_TDSComputation.BAL_getIncomeTax115(Company_ID,Emp, Conn);

        return new JavaScriptSerializer().Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public int setEmployeeRentDetails(Tbl_TDS_Computation tobj)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(tobj.ConnectionString))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = tobj.ConnectionString;
        }
        if (tobj.Rent_Payment == false)
        {
            tobj.PAN_landlord1 = "";
            tobj.PAN_landlord2 = "";
            tobj.PAN_landlord3 = "";
            tobj.PAN_landlord4 = "";
            tobj.Name_landlord1 = "";
            tobj.Name_landlord2 = "";
            tobj.Name_landlord3 = "";
            tobj.Name_landlord4 = "";
        }
        if (tobj.Interest_lender == false)
        {
            tobj.PAN_lender1 = "";
            tobj.PAN_lender2 = "";
            tobj.PAN_lender3 = "";
            tobj.PAN_lender4 = "";
            tobj.Name_lender1 = "";
            tobj.Name_lender2 = "";
            tobj.Name_lender3 = "";
            tobj.Name_lender4 = "";
        }
        if (tobj.Contributions_superannuation_fund == false)
        {
            tobj.Name_superannuation_fund = "";
            tobj.Frm_DT_superannuation_fund = null;
            tobj.TO_DT_superannuation_fund = null;
            tobj.principal_interest_superannuation_fund = 0;
            tobj.Rate_deduction_tax_3yrs = 0;
            tobj.Repayment_superannuation_fund = 0;
            tobj.Total_Income_superannuation_fund = 0;
        }

        int count = 4;
        if (string.IsNullOrEmpty(tobj.PAN_landlord1) && string.IsNullOrEmpty(tobj.Name_landlord1))
        { count -= 1; }
        if (string.IsNullOrEmpty(tobj.PAN_landlord2) && string.IsNullOrEmpty(tobj.Name_landlord2))
        { count -= 1; }
        if (string.IsNullOrEmpty(tobj.PAN_landlord3) && string.IsNullOrEmpty(tobj.Name_landlord3))
        { count -= 1; }
        if (string.IsNullOrEmpty(tobj.PAN_landlord4) && string.IsNullOrEmpty(tobj.Name_landlord4))
        { count -= 1; }
        tobj.Count_PAN_landlord = count;

        if (count == 0)
        { tobj.Rent_Payment = false; }

        count = 4;
        if (string.IsNullOrEmpty(tobj.PAN_lender1) && string.IsNullOrEmpty(tobj.Name_lender1))
        { count -= 1; }
        if (string.IsNullOrEmpty(tobj.PAN_lender2) && string.IsNullOrEmpty(tobj.Name_lender2))
        { count -= 1; }
        if (string.IsNullOrEmpty(tobj.PAN_lender3) && string.IsNullOrEmpty(tobj.Name_lender3))
        { count -= 1; }
        if (string.IsNullOrEmpty(tobj.PAN_lender4) && string.IsNullOrEmpty(tobj.Name_lender4))
        { count -= 1; }
        tobj.Count_PAN_lender = count;

        if (count == 0)
        { tobj.Interest_lender = false; }

        count = 7;
        if (string.IsNullOrEmpty(tobj.Name_superannuation_fund))
        { count -= 1; }
        if (tobj.Frm_DT_superannuation_fund == null)
        { count -= 1; }
        if (tobj.TO_DT_superannuation_fund == null)
        { count -= 1; }
        if (tobj.principal_interest_superannuation_fund == 0)
        { count -= 1; }
        if (tobj.Rate_deduction_tax_3yrs == 0)
        { count -= 1; }
        if (tobj.Repayment_superannuation_fund == 0)
        { count -= 1; }
        if (tobj.Total_Income_superannuation_fund == 0)
        { count -= 1; }

        if (count == 0)
        { tobj.Contributions_superannuation_fund = false; }

        return objBAL_TDSComputation.BAL_setEmployeeRentDetails(tobj);
    }

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

    [System.Web.Services.WebMethod(EnableSession = true)]
    public void getEmployeeFormSixteen(Tbl_TDS_Computation tobj)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(tobj.ConnectionString))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = tobj.ConnectionString;
        }
        HttpContext.Current.Session["ReportFormSixteenFromTDSComputationEmployeeID"] = tobj.Employee_ID + "," + tobj.Company_ID + "," + tobj.LastName;
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string getHRARentReciept_Grd(int empid, string Conn)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        IEnumerable<tbl_HRR> tbl = objBAL_TDSComputation.BAL_getHRR_Grd(empid, Conn);

        return new JavaScriptSerializer().Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string UpadteHRR(int Compid, string Conn, int empid, string Multi)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        IEnumerable<tbl_HRR> tbl = objBAL_TDSComputation.BAL_SaveHRR(Compid,empid, Conn, Multi);

        return new JavaScriptSerializer().Serialize(tbl);
    }

    public class PANs
    {
        public string textBoxID { get; set; }

        public string PANNO { get; set; }

        public string PANStatus { get; set; }
    }
}