<%@ WebService Language="C#" Class="WhatsNew" %>

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
public class WhatsNew : System.Web.Services.WebService
{
    public SqlConnection sqlConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());
    public static CultureInfo ci = new CultureInfo("en-GB");

    [WebMethod]
    public string Getwhatnew()
    {
        CommonLibrary.CommonFunctions objComm = new CommonLibrary.CommonFunctions();
        List<tbl_watsnewrecord> obj_Pan = new List<tbl_watsnewrecord>();
        try
        {
            //SqlParameter[] param = new SqlParameter[1];
            //param[0] = new SqlParameter("@Companyid", compid);
            using (SqlDataReader drrr = SqlHelper.ExecuteReader(sqlConn, CommandType.StoredProcedure, "usp_GetWhatsNew"))
            {
                while (drrr.Read())
                {
                    obj_Pan.Add(new tbl_watsnewrecord()
                    {
                        Wid = objComm.GetValue<int>(drrr["Wid"].ToString()),
                        Updatedate = objComm.GetValue<string>(drrr["UpdateDate"].ToString()),
                        Subject = objComm.GetValue<string>(drrr["Subject"].ToString()),
                        Descriptn = objComm.GetValue<string>(drrr["Description"].ToString()),

                    });
                }

            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<tbl_watsnewrecord> tbl = obj_Pan as IEnumerable<tbl_watsnewrecord>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }

    [WebMethod]
    public string GetSaveUpdatewhatnew(int Wid, string Update, string Subj, string Despt)
    {
        CommonLibrary.CommonFunctions objComm = new CommonLibrary.CommonFunctions();
        List<tbl_watsnew> obj_Pan = new List<tbl_watsnew>();
        try
        {
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@wid", Wid);
            param[1] = new SqlParameter("@updt", Update);
            param[2] = new SqlParameter("@subj", Subj);
            param[3] = new SqlParameter("@desptn", Despt);
            using (SqlDataReader drrr = SqlHelper.ExecuteReader(sqlConn, CommandType.StoredProcedure, "usp_Save_UpdateWhatsNew", param))
            {
                while (drrr.Read())
                {
                    obj_Pan.Add(new tbl_watsnew()
                    {
                        ID = objComm.GetValue<int>(drrr["Wid"].ToString()),


                    });
                }

            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<tbl_watsnew> tbl = obj_Pan as IEnumerable<tbl_watsnew>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }

          [WebMethod]
    public string GetDelwhatnew(int Wid)
    {
        CommonLibrary.CommonFunctions objComm = new CommonLibrary.CommonFunctions();
        List<tbl_watsnew> obj_Pan = new List<tbl_watsnew>();
        try
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@wid", Wid);
    
            using (SqlDataReader drrr = SqlHelper.ExecuteReader(sqlConn, CommandType.StoredProcedure, "usp_delete_WhatsNew", param))
            {
                while (drrr.Read())
                {
                    obj_Pan.Add(new tbl_watsnew()
                    {
                        ID = objComm.GetValue<int>(drrr["Wid"].ToString()),


                    });
                }

            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<tbl_watsnew> tbl = obj_Pan as IEnumerable<tbl_watsnew>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }

}