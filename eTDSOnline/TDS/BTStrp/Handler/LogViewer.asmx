<%@ WebService Language="C#" Class="LogViewer" %>

using System;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
using System.Data;
using CommonLibrary;
using LibCommon;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using Microsoft.ApplicationBlocks1.Data;
using System.Globalization;
using DataLayer;
using BusinessLayer;
using System.IO;
using Ionic.Zip;



[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class LogViewer : System.Web.Services.WebService
{

    public static CultureInfo ci = new CultureInfo("en-GB");

    [WebMethod]
    public string GetonLoad(int compid, int lastMinutes,string startDate,string endDate)
    {
        DataSet ds;
        int pageIndex = 0; int pageSize = 100;

        try
        {
            DALCommonLib objComm = new DALCommonLib();
            CommonFunctions Comm = new CommonFunctions();

            SqlParameter[] param = new SqlParameter[6];
            param[0] = new SqlParameter("@Company_ID", compid);
            param[1] = new SqlParameter("@lastMinutes", lastMinutes);
            param[2] = new SqlParameter("@pageindex", pageIndex);
            param[3] = new SqlParameter("@pagesize", pageSize);
            param[4] = new SqlParameter("@startDate", startDate);
            param[5] = new SqlParameter("@endDate", endDate);

            ds = SqlHelper.ExecuteDataset(objComm._cnnString, CommandType.StoredProcedure, "usp_BTSGetEventLogs", param);

        }
        catch (Exception ex)
        {
            throw ex;
        }
        return ds.GetXml();

    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Get_CompanyList()
    {

        List<tbl_Company_MAster> Cmaster = new List<tbl_Company_MAster>();

        try
        {
            DALCommonLib objComm = new DALCommonLib();
            CommonFunctions Comm = new CommonFunctions();
            Cmaster.Add(new tbl_Company_MAster()
            {
                CompanyName = "All",
                Company_ID = 0,
            });

            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString, CommandType.StoredProcedure, "usp_bootstrap_bind_CompanyForAdmin"))
            {
                while (drrr.Read())
                {
                    Cmaster.Add(new tbl_Company_MAster()
                    {
                        CompanyName = Comm.GetValue<string>(drrr["CompanyName"].ToString()),
                        Company_ID = Comm.GetValue<int>(drrr["Company_ID"].ToString()),
                    });
                }
            }
        }

        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<tbl_Company_MAster> tbl = Cmaster as IEnumerable<tbl_Company_MAster>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }



}