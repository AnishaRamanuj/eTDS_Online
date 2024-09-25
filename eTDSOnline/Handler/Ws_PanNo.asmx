<%@ WebService Language="C#" Class="Ws_PanNo" %>
using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Data;
using Microsoft.ApplicationBlocks1.Data;
using CommonLibrary;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using System.Globalization;
using DataLayer;
using BusinessLayer;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class Ws_PanNo  : System.Web.Services.WebService
{
    DAL_TDSComputation objDAL_TDSComputation = new DAL_TDSComputation();
    BAL_TDSComputation objBAL_TDSComputation = new BAL_TDSComputation();
    public SqlConnection sqlConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());
    public static CultureInfo ci = new CultureInfo("en-GB");
    [WebMethod]

    public string GetPanNo(int compid)
    {
        CommonLibrary.CommonFunctions objComm = new CommonLibrary.CommonFunctions();
        List<Pan_No> obj_Pan = new List<Pan_No>();
        try
        {
            //Common ob = new Common();
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@Companyid", compid);
            using (SqlDataReader drrr = SqlHelper.ExecuteReader(sqlConn, CommandType.StoredProcedure, "Usp_Get_PANNo", param))
            {
                while (drrr.Read())
                {
                    obj_Pan.Add(new Pan_No()
                    {
                        panno = objComm.GetValue<string>(drrr["TANNo"].ToString()),
                        Gstn = objComm.GetValue<string>(drrr["GSTN"].ToString()),
                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<Pan_No> tbl = obj_Pan as IEnumerable<Pan_No>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }


    [System.Web.Services.WebMethod(EnableSession = true)]

    public string Get_NatureSubId(string n, string t)
    {
        CommonLibrary.CommonFunctions objComm = new CommonLibrary.CommonFunctions();
        List<tbl_Nature> obj_Pan = new List<tbl_Nature>();
        try
        { string Proc = "";
            string FinancialYearText = "";
            if (HttpContext.Current.Session["Financial_Year_Text"] != null)
            {
                FinancialYearText = (string)HttpContext.Current.Session["Financial_Year_Text"];
            }
            if (FinancialYearText == "2023_24")
            {
                Proc = "usp_Get_NatureSubId_23";
            }
            else
            {
                Proc ="Usp_Get_NatureSubId";
            }
            //Common ob = new Common();
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@natureid", n);
            param[1] = new SqlParameter("@typeid", t);
            using (SqlDataReader drrr = SqlHelper.ExecuteReader(sqlConn, CommandType.StoredProcedure, Proc, param))
            {
                while (drrr.Read())
                {
                    obj_Pan.Add(new tbl_Nature()
                    {
                        Nature_Sub_Id = objComm.GetValue<string>(drrr["Nature_Sub_Id"].ToString()),

                    });
                }

                List<tbl_Section> listSec = new List<tbl_Section>();

                if (drrr.NextResult())
                {
                    if (drrr.HasRows)
                    {
                        while (drrr.Read())
                        {
                            listSec.Add(new tbl_Section()
                            {
                                Section = objComm.GetValue<string>(drrr["Section_Name"].ToString()),
                                Section_Id = objComm.GetValue<string>(drrr["Section_Id"].ToString()),

                            });
                        }
                    }
                }
                foreach (var item in obj_Pan)
                {
                    item.Lst_Sec = listSec;
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<tbl_Nature> tbl = obj_Pan as IEnumerable<tbl_Nature>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }



    [WebMethod]
    public string SaveAdmin(int compid, string d)
    {
        CommonLibrary.CommonFunctions objComm = new CommonLibrary.CommonFunctions();
        List<Co_Admin> obj_Pan = new List<Co_Admin>();
        try
        {
            //Common ob = new Common();
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@Companyid", compid);
            param[1] = new SqlParameter("@Dts", d);
            using (SqlDataReader drrr = SqlHelper.ExecuteReader(sqlConn, CommandType.StoredProcedure, "usp_Insert_AdminCompany", param))
            {
                while (drrr.Read())
                {
                    obj_Pan.Add(new Co_Admin()
                    {
                        UID = objComm.GetValue<string>(drrr["UserID"].ToString()),

                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<Co_Admin> tbl = obj_Pan as IEnumerable<Co_Admin>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }

    [WebMethod]
    public string GetPANDetails(string F, string Q, string sts)
    {
        CommonLibrary.CommonFunctions objComm = new CommonLibrary.CommonFunctions();
        List<PANNo> obj_Pan = new List<PANNo>();
        try
        {
            DALCommon Lib = new DALCommon();
                
            //Common ob = new Common();
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@Companyid", Session["companyid"].ToString());
            param[1] = new SqlParameter("@Quarter", Q);
            param[2] = new SqlParameter("@FormType", F);
            param[3] = new SqlParameter("@indication", sts);
            using (SqlDataReader drrr = SqlHelper.ExecuteReader(Lib._cnnString2, CommandType.StoredProcedure, "usp_Voucher_PANSummary", param))
            {
                while (drrr.Read())
                {
                    obj_Pan.Add(new PANNo()
                    {
                        Active = objComm.GetValue<string>(drrr["Active"].ToString()),
                        InActive = objComm.GetValue<string>(drrr["InActive"].ToString()),
                        NotVerified = objComm.GetValue<string>(drrr["NotVerified"].ToString()),

                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<PANNo> tbl = obj_Pan as IEnumerable<PANNo>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }
}