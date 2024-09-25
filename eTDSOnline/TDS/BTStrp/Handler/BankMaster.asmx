<%@ WebService Language="C#" Class="BankMaster" %>

using System;
using System.Web.Services;
using System.Data.SqlClient;
using System.Data;
//using BusinessLayer;
//using CommonLibrary;
using Microsoft.ApplicationBlocks1.Data;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using System.Globalization;
using LibCommon;
using EntityLibrary;


[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class BankMaster  : System.Web.Services.WebService {
    public static CultureInfo ci = new CultureInfo("en-GB");
    Functions4evr objComm = new  Functions4evr();


    [WebMethod (EnableSession =true)]
    public string GetBankRecord(string Srch, int pageIndex, int pageSize)
    {
        DataSet ds;
        try
        {
            DALCommonLib objComm = new DALCommonLib();
            Functions4evr Comm = new Functions4evr();

            SqlParameter[] param = new SqlParameter[5];
            param[0] = new SqlParameter("@compid", Session["companyid"]);
            param[1] = new SqlParameter("@search", Srch);
            param[3] = new SqlParameter("@pageindex", pageIndex);
            param[4] = new SqlParameter("@pagesize", pageSize);

            ds = SqlHelper.ExecuteDataset(objComm._cnnString, CommandType.StoredProcedure, "usp_BOOTSTRAP_Get_bank", param);

        }
        catch (Exception ex)
        {
            throw ex;
        }
        return ds.GetXml();
    }

    [WebMethod (EnableSession =true)]
    public string GetBankEdit( int Bank_ID)
    {
        DataSet ds;
        try
        {
            DALCommonLib objComm = new DALCommonLib();
            Functions4evr Comm = new Functions4evr();
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@compid", Session["companyid"]);
            param[1] = new SqlParameter("@Bank_ID", Bank_ID);

            ds = SqlHelper.ExecuteDataset(objComm._cnnString, CommandType.StoredProcedure, "usp_bootstrap_Get_Bank_Master_Details", param);

        }
        catch (Exception ex)
        {
            throw ex;
        }
        return ds.GetXml();
    }

    [WebMethod (EnableSession =true)]
    public int InsertUpdateBank(string Bank_Name,string Bank_Branch, string Bsrcode, int Bank_ID)
    {

        int BankID = 0;
        try
        {
            DALCommonLib LibComm = new DALCommonLib();
            Functions4evr Comm = new Functions4evr();
            SqlParameter[] param = new SqlParameter[7];
            param[0] = new SqlParameter("@Company_ID", Session["companyid"]);
            param[1] = new SqlParameter("@Bank_Name", Bank_Name);
            param[2] = new SqlParameter("@Bank_Branch", Bank_Branch);
            param[3] = new SqlParameter("@Bsrcode", Bsrcode);
            param[4] = new SqlParameter("@Bank_ID", Bank_ID);
            param[5] = new SqlParameter("@UserID", Session["UserID"]);
            param[6] = new SqlParameter("@UserType", Session["usertype"]);
            BankID = (int)SqlHelper.ExecuteScalar(LibComm._cnnString, CommandType.StoredProcedure, "usp_Bootstrap_Bank_InsertUpdate_new", param);

        }
        catch (Exception ex)
        {
            throw ex;
        }
        return BankID;
    }

    [WebMethod (EnableSession =true)]
    public int UpdateLoanApplication(string Bank_Name,string Bank_Branch, string Bsrcode, int Bank_ID)
    {

        int BankID = 0;
        try
        {
            DALCommonLib LibComm = new DALCommonLib();
            Functions4evr Comm = new Functions4evr();
            SqlParameter[] param = new SqlParameter[5];
            param[0] = new SqlParameter("@Company_ID", Session["companyid"]);
            param[1] = new SqlParameter("@Bank_Name", Bank_Name);
            param[2] = new SqlParameter("@Bank_Branch", Bank_Branch);
            param[3] = new SqlParameter("@Bsrcode", Bsrcode);
            param[4] = new SqlParameter("@Bank_ID", Bank_ID);
            BankID = (int)SqlHelper.ExecuteScalar(LibComm._cnnString, CommandType.StoredProcedure, "usp_Update_Bank_Master", param);

        }
        catch (Exception ex)
        {
            throw ex;
        }
        return BankID;
    }
    [WebMethod(EnableSession =true)]
    public string DeleteRecord(int Bank_ID)
    {

        int BankID = 0;

        try
        {
            DALCommonLib LibComm = new DALCommonLib();
            Functions4evr Comm = new Functions4evr();
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@Bank_ID", Bank_ID);

            BankID = (int)SqlHelper.ExecuteScalar(LibComm._cnnString, CommandType.StoredProcedure, "usp_boostrap_Delete_Bank_Master", param);

        }
        catch (Exception ex)
        {
            throw ex;
        }
        return BankID.ToString();
    }

}