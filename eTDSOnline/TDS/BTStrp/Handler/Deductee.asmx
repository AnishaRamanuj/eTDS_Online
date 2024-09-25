<%@ WebService Language="C#" Class="Deductee" %>

using System;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;
//using CommonLibrary;
using System.Globalization;
using System.Collections.Generic;
using EntityLibrary;
using System.Web.Script.Serialization;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class Deductee : System.Web.Services.WebService
{
    public SqlConnection sqlConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());
    public static CultureInfo ci = new CultureInfo("en-GB");
    Functions4evr objComm = new Functions4evr();
    [WebMethod(EnableSession = true)]
    public string Fill_Country()
    {
        DataSet ds = new DataSet();
        try
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@Company_ID", Session["companyid"]);

            ds = SqlHelper.ExecuteDataset(sqlConn, CommandType.StoredProcedure, "usp_Bootstrap_GetCountry", param);

        }
        catch (Exception ex)
        {
            throw ex;
        }

        return ds.GetXml();
    }
    [WebMethod(EnableSession = true)]
    public long InsertUpdateBank(int Deductee_ID, string Deductee_Name, string PAN_NO, string DeducteeType, string Remarks, string CertificateNo, bool OptingFor1A, bool IsNri, string NRI_TDSRate, int NRICountryID, string NRIAddress, string NRI_Tan, string NRI_Email, string NRI_ContactNo, string TDS_Rate_From, string TDSRate)
    {
        Functions4evr objComm = new Functions4evr();
        object DeducteeID = 0;
        try
        {
            SqlParameter[] param = new SqlParameter[17];
            param[0] = new SqlParameter("@CompanyId", Session["companyid"]);
            param[1] = new SqlParameter("@Deductee_ID", Deductee_ID);
            param[2] = new SqlParameter("@Deductee_Name", Deductee_Name);
            param[3] = new SqlParameter("@PAN_NO", PAN_NO);
            param[4] = new SqlParameter("@DeducteeType", DeducteeType);
            param[5] = new SqlParameter("@Remarks", Remarks);
            param[6] = new SqlParameter("@CertificateNo", CertificateNo);
            param[7] = new SqlParameter("@OptingFor1A", OptingFor1A);
            param[8] = new SqlParameter("@IsNri", IsNri);
            param[9] = new SqlParameter("@NRI_TDSRate", NRI_TDSRate);
            param[10] = new SqlParameter("@NRICountryID", NRICountryID);
            param[11] = new SqlParameter("@NRIAddress", NRIAddress);
            param[12] = new SqlParameter("@NRI_Tan", NRI_Tan);
            param[13] = new SqlParameter("@NRI_Email", NRI_Email);
            param[14] = new SqlParameter("@NRI_ContactNo", NRI_ContactNo);
            param[15] = new SqlParameter("@TDS_Rate_From", TDS_Rate_From);
            param[16] = new SqlParameter("@TDSRate", TDSRate);
            DeducteeID = SqlHelper.ExecuteScalar(sqlConn, CommandType.StoredProcedure, "usp_Bootstrap_Save_Deductee_Master", param);

        }
        catch (Exception ex)
        {
            throw ex;
        }
        return Convert.ToInt64(DeducteeID);
    }

    [WebMethod(EnableSession = true)]
    public string FillGridData(string PANVerified, string reasons, string Dname, int PageIndex, int PageSize)
    {
        DataSet ds = new DataSet();
        try
        {
            SqlParameter[] param = new SqlParameter[6];
            param[0] = new SqlParameter("@Company_ID", Session["companyid"]);
            param[1] = new SqlParameter("@Deductee_Name", Dname);
            param[2] = new SqlParameter("@PANVerified", PANVerified);
            param[3] = new SqlParameter("@Reasons", reasons);
            param[4] = new SqlParameter("@PageIndex", PageIndex);
            param[5] = new SqlParameter("@PageSize", PageSize);

            ds = SqlHelper.ExecuteDataset(sqlConn, CommandType.StoredProcedure, "usp_Bootstrap_GetDeductee_List", param);

        }
        catch (Exception ex)
        {
            throw ex;
        }

        return ds.GetXml();
    }

    [WebMethod(EnableSession = true)]
    public string GetDeducteeDetails(int DeducteeID)
    {
        DataSet ds = new DataSet();
        try
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@CompanyID", Session["companyid"]);
            param[1] = new SqlParameter("@DeducteeID", DeducteeID);

            ds = SqlHelper.ExecuteDataset(sqlConn, CommandType.StoredProcedure, "usp_Bootstrap_GetSelected_Deductee", param);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return ds.GetXml();
    }
    [WebMethod(EnableSession = true)]
    public string DeleteDeductee(int Deductee_ID)
    {
        object DeducteeID = "0";
        Functions4evr objComm = new Functions4evr();
        try
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@Company_ID", Session["companyid"]);
            param[1] = new SqlParameter("@Deductee_ID", Deductee_ID);

            DeducteeID = SqlHelper.ExecuteScalar(sqlConn, CommandType.StoredProcedure, "usp_Bootstrap_DeleteDeductee", param);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return DeducteeID.ToString();
    }

    [WebMethod(EnableSession = true)]
    public string GetBSRCodes()
    {
        List<BankBSR> bsrCodes = new List<BankBSR>();

        Functions4evr Comm = new Functions4evr();
        try
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@CompId", Session["companyid"]);

            using (SqlDataReader drrr = SqlHelper.ExecuteReader(sqlConn, CommandType.StoredProcedure, "usp_Bootstrap_GetBankBSRCode", param))
            {
                while (drrr.Read())
                {
                    bsrCodes.Add(new BankBSR()
                    {
                        BankId = Comm.GetValue<string>(drrr["Bank_ID"].ToString()),
                        BSRCode = Comm.GetValue<string>(drrr["Bsrcode"].ToString())
                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

        IEnumerable<BankBSR> tbl = bsrCodes as IEnumerable<BankBSR>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }
}

public class BankBSR
{
    public string BankId { get; set; }
    public string BSRCode { get; set; }
}