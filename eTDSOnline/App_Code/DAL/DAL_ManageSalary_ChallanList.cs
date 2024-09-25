using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Microsoft.ApplicationBlocks1.Data;
using DataLayer;
using System.Data.SqlClient;
using CommonLibrary;

namespace DataLayer
{
    public class DAL_ManageSalary_ChallanList : DALCommon
    {
        DataSet ds;
        public string Quater { get; set; }

        public string ChallanNo { get; set; }

        public string ChallanDate { get; set; }

        public int CompanyID { get; set; }
        public int Challanid { get; set; }

        public string FinancialStart { get; set; }

        public string FinancialEnd { get; set; }

        public string Result { get; set; }


        public DataSet Get_Queter_Selection_Challan_Non_Salary_Grid()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[7];
                param[0] = new SqlParameter("@CompanyID", CompanyID);
                param[1] = new SqlParameter("@FinancialStart", FinancialStart);
                param[2] = new SqlParameter("@FinancialEnd", FinancialEnd);
                param[3] = new SqlParameter("@ChallanDate", ChallanDate);
                param[4] = new SqlParameter("@ChallanNo", ChallanNo);
                param[5] = new SqlParameter("@Quater", Quater);
                param[6] = new SqlParameter("@Form_Type", FromType);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_Get_Queter_Selection_Challan_Non_Salary_Grid", param);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet Get_Challan_Non_Salary()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@CompanyID", CompanyID);
                param[1] = new SqlParameter("@Quater", Quater);
                param[2] = new SqlParameter("@Form_Type", FromType);

                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_Get_Challan4Verify_NonSAL", param);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet Get_Challan_Salary()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@CompanyID", CompanyID);
                param[1] = new SqlParameter("@Quater", Quater);
                param[2] = new SqlParameter("@Form_Type", FromType);

                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_Get_Challan4Verify_Sal", param);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public DataSet DAL_Challan_Verify()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@CompanyID", CompanyID);
                param[1] = new SqlParameter("@Result", Result);
                param[2] = new SqlParameter("@FromType", FromType);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_Challan_Verify", param);
                return ds;
           
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet DAL_Compliance()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@CompanyID", CompanyID);
                param[1] = new SqlParameter("@Result", Result);

                ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_Compliance_Deductee", param);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public SqlDataReader DAL_GetChallanGridDashboard(objChallanDetails tobj)
        {
            string sp = "";
            if (tobj.FormType == "24Q")
            {
                sp = "usp_Challan_Salary_Verify";
            }
            else
            {
                sp = "usp_Get_Queter_Selection_Challan_Non_Salary_Grid";
            }
                SqlParameter[] param = new SqlParameter[7];
                param[0] = new SqlParameter("@CompanyID", tobj.Compid);
                param[1] = new SqlParameter("@FinancialStart", FinancialStart);
                param[2] = new SqlParameter("@FinancialEnd", FinancialEnd);
                param[3] = new SqlParameter("@ChallanDate", ChallanDate);
                param[4] = new SqlParameter("@ChallanNo", ChallanNo);
                param[5] = new SqlParameter("@Quater", tobj.quarter);
                param[6] = new SqlParameter("@Form_Type", tobj.FormType);

                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, sp, param);
        }


        public string FromType { get; set; }

        public int ChallanID { get; set; }

        public int DeleteNonSalaryChallanID()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@ChallanID", ChallanID);
                int result = SqlHelper.ExecuteNonQuery(_cnnString2, CommandType.StoredProcedure, "usp_DeleteNonSalaryChallan", param);
                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet DAL_GetAll_NonSalaryChallan_From_SP_Call()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@CompanyID", CompanyID);
                param[1] = new SqlParameter("@FinancialStart", FinancialStart);
                param[2] = new SqlParameter("@FinancialEnd", FinancialEnd);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetAll_NonSalaryChallan_From_SP_Call", param);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
