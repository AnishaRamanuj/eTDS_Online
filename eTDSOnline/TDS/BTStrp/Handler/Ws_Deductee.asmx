<%@ WebService Language="C#" Class="Ws_Deductee" %>

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
using Newtonsoft.Json;
using PANVrf;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class Ws_Deductee  : System.Web.Services.WebService {
    public SqlConnection sqlConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());
    public static CultureInfo ci = new CultureInfo("en-GB");
    BAL_Deductee_Master objBAL = new BAL_Deductee_Master();

    [WebMethod]
    public string GetDedcuteeName(int Compid)
    {
        CommonLibrary.CommonFunctions objComm = new CommonLibrary.CommonFunctions();
        List<tbl_DeducteeList> obj_Deductee = new List<tbl_DeducteeList>();
        try
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@Compid", Compid);
            using (SqlDataReader drrr = SqlHelper.ExecuteReader(sqlConn, CommandType.StoredProcedure, "Usp_Get_DeducteeList", param))
            {
                while (drrr.Read())
                {
                    obj_Deductee.Add(new tbl_DeducteeList()
                    {

                        Dname = objComm.GetValue<string>(drrr["Deductee_Name"].ToString()),
                        deducteeid = objComm.GetValue<int>(drrr["Deductee_ID"].ToString()),
                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<tbl_DeducteeList> tbl = obj_Deductee as IEnumerable<tbl_DeducteeList>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }

    [WebMethod]
    public string FillDeductee(int Compid, string pan, string reasons, string Dname,  int PageIndex, int PageSize)
    {
        CommonLibrary.CommonFunctions objComm = new CommonLibrary.CommonFunctions();
        List<DeducteeGrid> obj_Deductee = new List<DeducteeGrid>();
        try
        {

            SqlParameter[] param = new SqlParameter[6];
            param[0] = new SqlParameter("@Deductee_Name", Dname);
            param[1] = new SqlParameter("@PANVerified", pan);
            param[2] = new SqlParameter("@Reasons", reasons);
            param[3] = new SqlParameter("@Company_ID", Compid);
            param[4] = new SqlParameter("@PageIndex", PageIndex);
            param[5] = new SqlParameter("@PageSize", PageSize);


            using (SqlDataReader drrr = SqlHelper.ExecuteReader(sqlConn, CommandType.StoredProcedure, "usp_DeducteeGrid", param))
            {
                while (drrr.Read())
                {
                    obj_Deductee.Add(new DeducteeGrid()
                    {
                        DName = objComm.GetValue<string>(drrr["Deductee_Name"].ToString()),
                        did = objComm.GetValue<int>(drrr["Deductee_ID"].ToString()),
                        isNri = objComm.GetValue<bool>(drrr["IS_NRI"].ToString()),
                        PAN = objComm.GetValue<string>(drrr["PAN_NO"].ToString()),
                        DType = objComm.GetValue<string>(drrr["Deductee_Type"].ToString()),
                        Totalcount = objComm.GetValue<int>(drrr["Totalcount"].ToString()),
                        Srno = objComm.GetValue<int>(drrr["SrNo"].ToString()),
                        compid = objComm.GetValue<int>(drrr["compid"].ToString()),
                        PANVerified = objComm.GetValue<string>(drrr["PANVerified"].ToString()),
                        Comp206 = objComm.GetValue<int>(drrr["TR206"].ToString()),
                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<DeducteeGrid> tbl = obj_Deductee as IEnumerable<DeducteeGrid>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }


    [WebMethod]
    public string FillDeducteePAN(int Compid, string pan)
    {
        CommonLibrary.CommonFunctions objComm = new CommonLibrary.CommonFunctions();
        List<DeducteeGrid> obj_Deductee = new List<DeducteeGrid>();
        try
        {

            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@PAN", pan);
            param[1] = new SqlParameter("@Company_ID", Compid);

            using (SqlDataReader drrr = SqlHelper.ExecuteReader(sqlConn, CommandType.StoredProcedure, "usp_DeducteeGrid_PAN", param))
            {
                while (drrr.Read())
                {
                    obj_Deductee.Add(new DeducteeGrid()
                    {
                        DName = objComm.GetValue<string>(drrr["Deductee_Name"].ToString()),
                        did = objComm.GetValue<int>(drrr["Deductee_ID"].ToString()),
                        isNri = objComm.GetValue<bool>(drrr["IS_NRI"].ToString()),
                        PAN = objComm.GetValue<string>(drrr["PAN_NO"].ToString()),
                        DType = objComm.GetValue<string>(drrr["Deductee_Type"].ToString()),
                        Totalcount = objComm.GetValue<int>(drrr["Totalcount"].ToString()),
                        Srno = objComm.GetValue<int>(drrr["SrNo"].ToString()),
                        compid = objComm.GetValue<int>(drrr["compid"].ToString()),
                        PANVerified = objComm.GetValue<string>(drrr["PANVerified"].ToString()),
                        Comp206 = objComm.GetValue<int>(drrr["TR206"].ToString()),
                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<DeducteeGrid> tbl = obj_Deductee as IEnumerable<DeducteeGrid>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }

    [WebMethod]
    public string Edit_Deductee(int compid,  int did)
    {
        CommonLibrary.CommonFunctions objComm = new CommonLibrary.CommonFunctions();
        List<Tbl_Deductee> obj_Deductee = new List<Tbl_Deductee>();
        try
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@Company_ID", compid);
            param[1] = new SqlParameter("@did", did);


            using (SqlDataReader drrr = SqlHelper.ExecuteReader(sqlConn, CommandType.StoredProcedure, "usp_DeducteeEdit", param))
            {
                while (drrr.Read())
                {
                    obj_Deductee.Add(new Tbl_Deductee()
                    {
                        DName = objComm.GetValue<string>(drrr["Deductee_Name"].ToString()),
                        did = objComm.GetValue<int>(drrr["Deductee_ID"].ToString()),
                        isNri = objComm.GetValue<bool>(drrr["IS_NRI"].ToString()),
                        PAN = objComm.GetValue<string>(drrr["PAN_NO"].ToString()),
                        DType = objComm.GetValue<string>(drrr["Deductee_Type"].ToString()),
                        DReason = objComm.GetValue<string>(drrr["Reasons"].ToString()),
                        Add1 = objComm.GetValue<string>(drrr["Flat_NO"].ToString()),
                        Add2 = objComm.GetValue<string>(drrr["Bldg_Name"].ToString()),
                        Contactno = objComm.GetValue<string>(drrr["ContactNo"].ToString()),
                        NriTDSRT = objComm.GetValue<string>(drrr["NRI_TDS_Rate"].ToString()),
                        Emailid = objComm.GetValue<string>(drrr["Eml"].ToString()),
                        TaxId = objComm.GetValue<string>(drrr["TaxIdentificationNo"].ToString()),
                        Countryid = objComm.GetValue<int>(drrr["Country_ID"].ToString()),
                        TDSRT = objComm.GetValue<double>(drrr["TDS_Rate"].ToString()),
                        TDSRT_FR = objComm.GetValue<int>(drrr["TDS_Rate_From"].ToString()),
                        Surcharge = objComm.GetValue<int>(drrr["Surcharge"].ToString()),
                        Multi_Co = objComm.GetValue<bool>(drrr["Multi_Company"].ToString()),
                        isInd = objComm.GetValue<string>(drrr["IS_Individual"].ToString()),
                        BAC_1A = objComm.GetValue<string>(drrr["BAC_1A"].ToString()),
                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<Tbl_Deductee> tbl = obj_Deductee as IEnumerable<Tbl_Deductee>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }

    [WebMethod]
    public string Save_Deductee(int compid,  int did, string ii)
    {
        CommonLibrary.CommonFunctions objComm = new CommonLibrary.CommonFunctions();
        List<Tbl_Deductee> obj_Deductee = new List<Tbl_Deductee>();
        try
        {
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@Company_ID", compid);
            param[1] = new SqlParameter("@did", did);
            param[2] = new SqlParameter("@rec", ii);
            //DataSet ds = SqlHelper.ExecuteDataset(sqlConn, CommandType.StoredProcedure, "usp_DeducteeSave", param);
            using (SqlDataReader drrr = SqlHelper.ExecuteReader(sqlConn, CommandType.StoredProcedure, "usp_DeducteeSave", param))
            {
                while (drrr.Read())
                {
                    obj_Deductee.Add(new Tbl_Deductee()
                    {
                        did = objComm.GetValue<int>(drrr["Deductee_id"].ToString()),
                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<Tbl_Deductee> tbl = obj_Deductee as IEnumerable<Tbl_Deductee>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }

    [WebMethod]
    public string Fill_Country(int compid)
    {
        CommonLibrary.CommonFunctions objComm = new CommonLibrary.CommonFunctions();
        List<Tbl_Country> obj_Deductee = new List<Tbl_Country>();
        try
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@Company_ID", compid);


            using (SqlDataReader drrr = SqlHelper.ExecuteReader(sqlConn, CommandType.StoredProcedure, "usp_FillCountry", param))
            {
                while (drrr.Read())
                {
                    obj_Deductee.Add(new Tbl_Country()
                    {
                        Countryid = objComm.GetValue<int>(drrr["Country_ID"].ToString()),
                        Country = objComm.GetValue<string>(drrr["Country_Name"].ToString()),
                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<Tbl_Country> tbl = obj_Deductee as IEnumerable<Tbl_Country>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }


    [WebMethod]
    public string delete_Deductee(int compid,  int did )
    {
        CommonLibrary.CommonFunctions objComm = new CommonLibrary.CommonFunctions();
        List<Tbl_Deductee> obj_Deductee = new List<Tbl_Deductee>();
        try
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@Company_ID", compid);
            param[1] = new SqlParameter("@did", did);


            using (SqlDataReader drrr = SqlHelper.ExecuteReader(sqlConn, CommandType.StoredProcedure, "usp_Deductee_delete", param))
            {
                while (drrr.Read())
                {
                    obj_Deductee.Add(new Tbl_Deductee()
                    {
                        did = objComm.GetValue<int>(drrr["Deductee_id"].ToString()),
                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<Tbl_Deductee> tbl = obj_Deductee as IEnumerable<Tbl_Deductee>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }


    [WebMethod]
    public string Update_PAN_Verification(int compid, string BulkPAN)
    {
        CommonLibrary.CommonFunctions objComm = new CommonLibrary.CommonFunctions();
        List<DeducteeGrid> obj_Deductee = new List<DeducteeGrid>();
        try
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@BulkPAN", BulkPAN);
            param[1] = new SqlParameter("@Company_id", compid);


            using (SqlDataReader drrr = SqlHelper.ExecuteReader(sqlConn, CommandType.StoredProcedure, "usp_PANVerify", param))
            {
                while (drrr.Read())
                {
                    obj_Deductee.Add(new DeducteeGrid()
                    {
                        PAN = objComm.GetValue<string>(drrr["Pan"].ToString()),
                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<DeducteeGrid> tbl = obj_Deductee as IEnumerable<DeducteeGrid>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Update_PAN(string PAN, string vrfy, string sts)
    {
        CommonLibrary.CommonFunctions objComm = new CommonLibrary.CommonFunctions();
        List<DeducteeGrid> obj_Deductee = new List<DeducteeGrid>();
        try
        {
            string did = "0";  //HttpContext.Current.Session["didPan"].ToString();
            string compid = HttpContext.Current.Session["companyid"].ToString();
            SqlParameter[] param = new SqlParameter[5];
            param[0] = new SqlParameter("@PAN", PAN);
            param[1] = new SqlParameter("@did", did);
            param[2] = new SqlParameter("@vrfy",vrfy);
            param[3] = new SqlParameter("@Sts",sts);
            param[4] = new SqlParameter("@Company_id", compid);


            using (SqlDataReader drrr = SqlHelper.ExecuteReader(sqlConn, CommandType.StoredProcedure, "usp_PANVerify_Update", param))
            {
                while (drrr.Read())
                {
                    obj_Deductee.Add(new DeducteeGrid()
                    {
                        PAN = objComm.GetValue<string>(drrr["Pan"].ToString()),
                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<DeducteeGrid> tbl = obj_Deductee as IEnumerable<DeducteeGrid>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }

    [WebMethod]
    public string BulkPAN(string Pan)
    {

        try
        {  ConnectTraces CT = new ConnectTraces();
            //ConnectTR objConnect = new ConnectTR();
            bool VPan = false ;
            VPan = CT.IsPAN_Valid(Pan);

            IEnumerable<PANNo> tbl =  objBAL.BAL_PANVerfy(VPan, Pan);
            return new JavaScriptSerializer().Serialize(tbl);
        }
        catch (Exception ex)
        {
            return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
        }


    }
}