<%@ WebService Language="C#" Class="Company" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Data;
using Microsoft.ApplicationBlocks1.Data;

using System.Collections.Generic;
using System.Web.Script.Serialization;
using System.Globalization;
 using System.Web.Security;
using LibCommon;
using EntityLibrary;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class Company : System.Web.Services.WebService
{
    DALCommonLib objComm = new DALCommonLib();
    Functions4evr Comm = new Functions4evr();
 
    [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetBankNames(int compId)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
        tbl_BankMaster bankMaster = new tbl_BankMaster();
        bankMaster.CompId = compId;
        bankMaster.BankName = "";
        DataSet ds;
        SqlParameter[] objSqlParameter = new SqlParameter[2];
        objSqlParameter[0] = new SqlParameter("@Bank_Name", bankMaster.BankName);
        objSqlParameter[1] = new SqlParameter("@Company_ID", bankMaster.CompId);
        ds = SqlHelper.ExecuteDataset(objComm._cnnString, "usp_Get_Bank_Master_List", objSqlParameter);
        return ds.GetXml();
    }

    [WebMethod(EnableSession = true)]
    public string Get_Company()
    {
        List<tbl_Company_Mst> Cmaster = new List<tbl_Company_Mst>();

        try
        {

            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@companyid", Session["companyid"]);

            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString, CommandType.StoredProcedure, "usp_bootstrap_bind_Company_year", param))
            {
                while (drrr.Read())
                {
                    Cmaster.Add(new tbl_Company_Mst()
                    {
                        CompanyName = Comm.GetValue<string>(drrr["CompanyName"].ToString()),
                        Company_ID = Comm.GetValue<int>(drrr["Company_ID"].ToString()),
                    });
                }

                List<tbl_FinancialYear> listfy = new List<tbl_FinancialYear>();

                if (drrr.NextResult())
                {
                    if (drrr.HasRows)
                    {
                        while (drrr.Read())
                        {
                            listfy.Add(new tbl_FinancialYear()
                            {
                                Fyear = Comm.GetValue<string>(drrr["Financial_Year"].ToString()),
                                Finyear_id = Comm.GetValue<int>(drrr["Financial_Year_ID"].ToString()),

                            });
                        }
                    }
                }
                foreach (var item in Cmaster)
                {
                    item.Lst_Fy = listfy;
                }
            }
        }

        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<tbl_Company_Mst> tbl = Cmaster as IEnumerable<tbl_Company_Mst>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }

    [WebMethod(EnableSession = true)]
    public string InsertCompany(tbl_Company_Mst companyMaster, tbl_TracesDetail tracesDetail)
    {
        try
        {
            // TODO: Check with Komal

            //if (Session["companyid"] != null)
            //{
            //    companyMaster.CreatedBy = Convert.ToInt32(Session["companyid"].ToString());

            //}
            //else if (Session["staffid"] != null)
            //{
            //    companyMaster.CreatedBy = Convert.ToInt32(Session["cltcomp"].ToString());
            //}
            var spName = "";
            if (companyMaster.Company_ID != 0)
            {
                spName = "usp_Update_Company_Master";
            }
            else
                spName = "usp_Insert_Company_Master";
            DALCommonLib objComm = new DALCommonLib();
            Functions4evr Comm = new Functions4evr();
            SqlParameter[] param = new SqlParameter[60];
            param[0] = new SqlParameter("@CompanyId", companyMaster.Company_ID);
            param[1] = new SqlParameter("@CompanyName", companyMaster.CompanyName);
            param[2] = new SqlParameter("@Flat_No", companyMaster.Flat_No);
            param[3] = new SqlParameter("@Name_Of_Building", companyMaster.Name_Of_Building);
            param[4] = new SqlParameter("@Street", companyMaster.Street);
            param[5] = new SqlParameter("@Area_Location", companyMaster.Area_Location);
            param[6] = new SqlParameter("@Town_City", companyMaster.Town_City);
            param[7] = new SqlParameter("@EmailID", companyMaster.EmailID);
            param[8] = new SqlParameter("@Pincode", companyMaster.Pincode);
            param[9] = new SqlParameter("@STD_code", companyMaster.STD_code);
            param[10] = new SqlParameter("@Tel_NO", companyMaster.Tel_NO);
            param[11] = new SqlParameter("@CUserName", companyMaster.CUserName);
            param[12] = new SqlParameter("@CPassword", companyMaster.CPassword);
            param[13] = new SqlParameter("@ContactPerson", companyMaster.ContactPerson);
            param[14] = new SqlParameter("@CreatedBy", null);   // TODO: Check with Komal,    CreatedBy is guid in DB and  int in TableEntity.tbl_Company_MAster class
            param[15] = new SqlParameter("@IsDemoVersion", companyMaster.IsDemoVersion);
            param[16] = new SqlParameter("@DemoDays", companyMaster.DemoDays);
            param[17] = new SqlParameter("@DemoStartDate", companyMaster.DemoStartDate);
            param[18] = new SqlParameter("@TANNo", companyMaster.TANNo);
            param[19] = new SqlParameter("@PANNo", companyMaster.PANNo);
            param[20] = new SqlParameter("@Alt_EmailID", companyMaster.Alt_EmailID);
            param[21] = new SqlParameter("@Alt_Tel_NO", companyMaster.Alt_Tel_NO);
            param[22] = new SqlParameter("@Alt_STDcode", companyMaster.Alt_STDcode);
            param[23] = new SqlParameter("@Change_Deductor", companyMaster.Change_Deductor);
            param[24] = new SqlParameter("@R_Name", companyMaster.R_Name);
            param[25] = new SqlParameter("@R_Flat_NO", companyMaster.R_Flat_NO);
            param[26] = new SqlParameter("@R_Building", companyMaster.R_Building);
            param[27] = new SqlParameter("@R_Street", companyMaster.R_Street);
            param[28] = new SqlParameter("@R_Area_Location", companyMaster.R_Area_Location);
            param[29] = new SqlParameter("@R_Town_City", companyMaster.R_Town_City);
            param[30] = new SqlParameter("@R_EmailID", companyMaster.R_EmailID);
            param[31] = new SqlParameter("@R_Designation", companyMaster.R_Designation);
            param[32] = new SqlParameter("@R_StateID", companyMaster.R_StateID);
            param[33] = new SqlParameter("@R_Mobile_NO", companyMaster.R_Mobile_NO);
            param[34] = new SqlParameter("@R_Pincode", companyMaster.R_Pincode);
            param[35] = new SqlParameter("@R_STD_Code", companyMaster.R_STD_Code);
            param[36] = new SqlParameter("@R_Tel_NO", companyMaster.R_Tel_NO);
            param[37] = new SqlParameter("@ALT_R_EmailID", companyMaster.ALT_R_EmailID);
            param[38] = new SqlParameter("@ALT_R_Tel_NO", companyMaster.ALT_R_Tel_NO);
            param[39] = new SqlParameter("@ALT_R_STD_Code", companyMaster.ALT_R_STD_Code);
            param[40] = new SqlParameter("@Parent_Company_ID", Session["ParentCompanyid"]);
            param[41] = new SqlParameter("@IsApproved", companyMaster.IsApproved);
            param[42] = new SqlParameter("@StateID", companyMaster.StateID);
            param[43] = new SqlParameter("@Co_Branch", companyMaster.Co_Branch);
            param[44] = new SqlParameter("@ContacPersonPAN", companyMaster.ContactPersonPAN);
            param[45] = new SqlParameter("@GSTN", companyMaster.GSTN);
            param[46] = new SqlParameter("@UserID", companyMaster.UserID);
            param[47] = new SqlParameter("@Status", companyMaster.Status);
            param[48] = new SqlParameter("@IClass", companyMaster.IClass);
            param[49] = new SqlParameter("@TracesUserName", tracesDetail.Userid);
            param[50] = new SqlParameter("@TracesPassword", tracesDetail.Password);

            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString, CommandType.StoredProcedure, spName, param))
            {
                while (drrr.Read())
                {
                    companyMaster.Company_ID = Comm.GetValue<int>(drrr["CompanyId"].ToString());
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return new JavaScriptSerializer().Serialize("");
    }

    [WebMethod(EnableSession = true)]
    public string GetStates()
    {
        List<tbl_State> statesList = new List<tbl_State>();

        try
        {
            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString, CommandType.StoredProcedure, "usp_Get_State_Master"))
            {
                while (drrr.Read())
                {
                    statesList.Add(new tbl_State()
                    {
                        State_Id = Comm.GetValue<int>(drrr["State_ID"].ToString()),
                        StateName = Comm.GetValue<string>(drrr["State_Name"].ToString()),
                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return new JavaScriptSerializer().Serialize(statesList);
    }

    [WebMethod(EnableSession = true)]
    public string GetCompanyList(int parentCompId, int pageIndex, int pageSize)
    {
        List<CompanyMasterList_VM> companyList = new List<CompanyMasterList_VM>();

        try
        {
            SqlParameter[] param = new SqlParameter[6];

            param[0] = new SqlParameter("@ParentCompId", Session["ParentCompanyid"]);
            param[1] = new SqlParameter("@PageIndex", pageIndex);
            param[2] = new SqlParameter("@PageSize", pageSize);

            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString, CommandType.StoredProcedure, "usp_Bootstrap_GetCompanyMasterList", param))
            {
                while (drrr.Read())
                {
                    companyList.Add(new CompanyMasterList_VM()
                    {
                        Company_ID = Comm.GetValue<int>(drrr["Company_ID"].ToString()),
                        CompanyName = Comm.GetValue<string>(drrr["CompanyName"].ToString()),
                        TANNo = Comm.GetValue<string>(drrr["TANNo"].ToString()),
                        PANNo = Comm.GetValue<string>(drrr["PANNo"].ToString()),
                        TracesUserName = Comm.GetValue<string>(drrr["TracesUserName"].ToString()),
                        TracesPassword = Comm.GetValue<string>(drrr["TracesPassword"].ToString()),
                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return new JavaScriptSerializer().Serialize(companyList);
    }

    [WebMethod(EnableSession = true)]
    public string GetCompanyDeatilsbyId(int parentCompId, int compId)
    {
        tbl_Company_Mst companyDetails = new tbl_Company_Mst();
        try
        {
            SqlParameter[] param = new SqlParameter[6];

            param[0] = new SqlParameter("@ParentCompId", parentCompId);
            param[1] = new SqlParameter("@CompId", compId);

            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString, CommandType.StoredProcedure, "usp_Bootstrap_GetCompanyDetailsbyId", param))
            {
                while (drrr.Read())
                {
                    companyDetails.Company_ID = Comm.GetValue<int>(drrr["Company_ID"].ToString());
                    companyDetails.CompanyName = Comm.GetValue<string>(drrr["CompanyName"].ToString());
                    companyDetails.TANNo = Comm.GetValue<string>(drrr["TANNo"].ToString());
                    companyDetails.PANNo = Comm.GetValue<string>(drrr["PANNo"].ToString());
                    companyDetails.GSTN = Comm.GetValue<string>(drrr["GSTN"].ToString());
                    companyDetails.TraceUserName = Comm.GetValue<string>(drrr["TracesUserName"].ToString());
                    companyDetails.TracePassword = Comm.GetValue<string>(drrr["TracesPassword"].ToString());
                    companyDetails.Co_Branch = Comm.GetValue<string>(drrr["Branch"].ToString());
                    companyDetails.Status = Comm.GetValue<string>(drrr["Status"].ToString());
                    companyDetails.IClass = Comm.GetValue<string>(drrr["IClass"].ToString());
                    companyDetails.Flat_No = Comm.GetValue<string>(drrr["Flat_No"].ToString());
                    companyDetails.Name_Of_Building = Comm.GetValue<string>(drrr["Name_Of_Building"].ToString());
                    companyDetails.Street = Comm.GetValue<string>(drrr["Street"].ToString());
                    companyDetails.Area_Location = Comm.GetValue<string>(drrr["Area_Location"].ToString());
                    companyDetails.Town_City = Comm.GetValue<string>(drrr["Town_City"].ToString());
                    companyDetails.EmailID = Comm.GetValue<string>(drrr["EmailID"].ToString());
                    companyDetails.Pincode = Comm.GetValue<string>(drrr["Pincode"].ToString());
                    companyDetails.STD_code = Comm.GetValue<string>(drrr["STD_code"].ToString());
                    companyDetails.Tel_NO = Comm.GetValue<string>(drrr["Tel_NO"].ToString());
                    //companyDetails.Fax = Comm.GetValue<string>(drrr["Fax"].ToString());
                    companyDetails.CUserName = Comm.GetValue<string>(drrr["CUserName"].ToString());
                    companyDetails.CPassword = Comm.GetValue<string>(drrr["CPassword"].ToString());
                    companyDetails.Alt_EmailID = Comm.GetValue<string>(drrr["Alt_EmailID"].ToString());
                    companyDetails.Alt_Tel_NO = Comm.GetValue<string>(drrr["Alt_Tel_NO"].ToString());
                    companyDetails.Alt_STDcode = Comm.GetValue<string>(drrr["Alt_STDcode"].ToString());
                    companyDetails.R_Name = Comm.GetValue<string>(drrr["R_Name"].ToString());
                    companyDetails.R_Flat_NO = Comm.GetValue<string>(drrr["R_Flat_NO"].ToString());
                    companyDetails.R_Building = Comm.GetValue<string>(drrr["R_Building"].ToString());
                    companyDetails.R_Street = Comm.GetValue<string>(drrr["R_Street"].ToString());
                    companyDetails.R_Area_Location = Comm.GetValue<string>(drrr["R_Area_Location"].ToString());
                    companyDetails.R_Town_City = Comm.GetValue<string>(drrr["R_Town_City"].ToString());
                    companyDetails.R_EmailID = Comm.GetValue<string>(drrr["R_EmailID"].ToString());
                    companyDetails.R_StateID = Comm.GetValue<int>(drrr["R_StateID"].ToString());
                    companyDetails.R_Mobile_NO = Comm.GetValue<string>(drrr["R_Mobile_NO"].ToString());
                    companyDetails.R_Pincode = Comm.GetValue<string>(drrr["R_Pincode"].ToString());
                    companyDetails.R_STD_Code = Comm.GetValue<string>(drrr["R_STD_Code"].ToString());
                    companyDetails.R_Tel_NO = Comm.GetValue<string>(drrr["R_Tel_NO"].ToString());
                    //companyDetails.R_Fax = Comm.GetValue<string>(drrr["R_Fax"].ToString());
                    companyDetails.R_Mobile_NO = Comm.GetValue<string>(drrr["R_Mobile_NO"].ToString());
                    companyDetails.R_Mobile_NO = Comm.GetValue<string>(drrr["R_Mobile_NO"].ToString());
                    companyDetails.R_Mobile_NO = Comm.GetValue<string>(drrr["R_Mobile_NO"].ToString());
                    companyDetails.ALT_R_EmailID = Comm.GetValue<string>(drrr["ALT_R_EmailID"].ToString());
                    companyDetails.ALT_R_Tel_NO = Comm.GetValue<string>(drrr["ALT_R_Tel_NO"].ToString());
                    companyDetails.ALT_R_STD_Code = Comm.GetValue<string>(drrr["ALT_R_STD_Code"].ToString());
                    companyDetails.R_Mobile_NO = Comm.GetValue<string>(drrr["R_Mobile_NO"].ToString());
                    companyDetails.StateID = Comm.GetValue<int>(drrr["StateID"].ToString());
                    companyDetails.R_Designation = Comm.GetValue<string>(drrr["R_Designation"].ToString());
                    companyDetails.ContactPersonPAN = Comm.GetValue<string>(drrr["ContacPersonPAN"].ToString());
                };
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return new JavaScriptSerializer().Serialize(companyDetails);
    }

    [WebMethod(EnableSession = true)]
    public string CheckTanNoExists(int compId, string tanNo)
    {
        bool tanExists = false;
        try
        {
            SqlParameter[] param = new SqlParameter[6];

            param[0] = new SqlParameter("@CompId", compId);
            param[1] = new SqlParameter("@TanNo", tanNo);
            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString, CommandType.StoredProcedure, "usp_Bootstrap_CheckTanNoExists", param))
            {
                while (drrr.Read())
                {
                    tanExists = Comm.GetValue<bool>(drrr["IsTanAlreadyExists"].ToString());
                }
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
        return new JavaScriptSerializer().Serialize(tanExists);
    }

}