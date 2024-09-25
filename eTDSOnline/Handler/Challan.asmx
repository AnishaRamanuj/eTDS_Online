<%@ WebService Language="C#" Class="Challan" %>

using System;
using System.Web;
using System.Web.Services;
using System.Data;
using CommonLibrary;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using System.Globalization;
using DataLayer;
using BusinessLayer;
using System.IO;
using Ionic.Zip;
using System.Data.SqlClient;

using Microsoft.ApplicationBlocks1.Data;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class Challan  : System.Web.Services.WebService {

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetPRN(int compid, string Q, string F)
    {
        DALCommon obj = new DALCommon();
        CommonFunctions Comm = new CommonFunctions();
        List<tbl_VoucherModify> listVoucher = new List<tbl_VoucherModify>();
        DataSet ds;
        try
        {

            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@Company_ID", compid);
            param[1] = new SqlParameter("@Quarter", Q);
            param[2] = new SqlParameter("@Form", F );

            ds = SqlHelper.ExecuteDataset(obj._cnnString2, CommandType.StoredProcedure, "usp_Get_RToken", param);
            using (SqlDataReader drrr = SqlHelper.ExecuteReader(obj._cnnString2, CommandType.StoredProcedure, "usp_Get_RToken", param))
            {

                while (drrr.Read())
                {
                    listVoucher.Add(new tbl_VoucherModify()
                    {
                        RToken = Comm.GetValue<string>(drrr["PRN_No"].ToString()),

                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

        IEnumerable<tbl_VoucherModify> tbl =  listVoucher;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);



    }


}