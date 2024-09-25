<%@ WebService Language="C#" Class="GetMenual_Challan" %>

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
public class GetMenual_Challan  : System.Web.Services.WebService {
    DAL_TDSComputation objDAL_TDSComputation = new DAL_TDSComputation();
    BAL_TDSComputation objBAL_TDSComputation = new BAL_TDSComputation();
    public SqlConnection sqlConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());
    public static CultureInfo ci = new CultureInfo("en-GB");

    [WebMethod]
    public string GetNatureName(int Natureid)
    {
        CommonLibrary.CommonFunctions objComm = new CommonLibrary.CommonFunctions();
        List<tbl_Report_Challan> obj_Nature = new List<tbl_Report_Challan>();
        try
        {
            //Common ob = new Common();
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@Nature_Id", Natureid);
            using (SqlDataReader drrr = SqlHelper.ExecuteReader(sqlConn, CommandType.StoredProcedure, "usp_GetSelectedNature", param))
            {
                while (drrr.Read())
                {
                    obj_Nature.Add(new tbl_Report_Challan()
                    {
                        Nature_nature = objComm.GetValue<string>(drrr["Nature_Name"].ToString()),
                        Section = objComm.GetValue<string>(drrr["Section"].ToString()),
                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<tbl_Report_Challan> tbl = obj_Nature as IEnumerable<tbl_Report_Challan>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }

    [WebMethod]
    public string GetBankName(int Compid)
    {
        CommonLibrary.CommonFunctions objComm = new CommonLibrary.CommonFunctions();
        List<tbl_Report_Challan> obj_Bank = new List<tbl_Report_Challan>();
        try
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@Compid", Compid);
            using (SqlDataReader drrr = SqlHelper.ExecuteReader(sqlConn, CommandType.StoredProcedure, "usp_GetBankName", param))
            {
                while (drrr.Read())
                {
                    obj_Bank.Add(new tbl_Report_Challan()
                    {
                        Bank_Name = objComm.GetValue<string>(drrr["Bank_Name"].ToString()),
                        Bank_id = objComm.GetValue<int>(drrr["Bank_ID"].ToString()),
                    });
                }
            }   
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<tbl_Report_Challan> tbl = obj_Bank as IEnumerable<tbl_Report_Challan>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }

   [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetHeadName(int Compid, string Conn)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
            IEnumerable<tbl_HeadName> tbl = objBAL_TDSComputation.Gt_HeadName(Compid,Conn);
       
        return new JavaScriptSerializer().Serialize(tbl);
    }

    //update HeadName
   [System.Web.Services.WebMethod(EnableSession = true)]
   public string UpadteHeadName(int Compid, string Conn, string Multi)
   {
       if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
       {
           HttpContext.Current.Session["Financial_Year_Text"] = Conn;
       }
       IEnumerable<tbl_HeadName> tbl = objBAL_TDSComputation.BAL_UpdateHead(Compid, Conn, Multi);

       return new JavaScriptSerializer().Serialize(tbl);
   }
    
}