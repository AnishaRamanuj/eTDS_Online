using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Microsoft.ApplicationBlocks1.Data;
using System.Data.SqlClient;

namespace DataLayer
{
    public class DAL_QuaterSelection : DALCommon
    {

        DataSet ds;
        int result = 0;
        public string Quater { get; set; }
        public string ChallanNo { get; set; }
        public string ChallanDate { get; set; }
        public string EndYear { get; set; }
        public int CompanyID { get; set; }
        public string StarYear { get; set; }

        public DataSet DAL_bindGirdGvChallanEntries()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@CompanyID", CompanyID);
                param[1] = new SqlParameter("@Years", StarYear);
                param[2] = new SqlParameter("@yeare", EndYear);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetQuaterWiseVoucher", param);
                return ds;
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }

        

        public DataSet DAL_BindGridQuater()
        {
            try
            {
                SqlParameter[] param=new SqlParameter[6];
                param[0] = new SqlParameter("@CompanyID", CompanyID);
                param[1] = new SqlParameter("@FinancialStart", FinancialStart);
                param[2] = new SqlParameter("@FinancialEnd", FinancialEnd);
                param[3] = new SqlParameter("@ChallanDate", ChallanDate);
                param[4] = new SqlParameter("@ChallanNo", ChallanNo);
                param[5] = new SqlParameter("@Quater", Quater);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetQueterSelectionGrid", param);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string FinancialStart { get; set; }

        public string FinancialEnd { get; set; }

        public DataSet Get_Queter_Selection_Challan_Non_Salary_Grid()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[6];
                param[0] = new SqlParameter("@CompanyID", CompanyID);
                param[1] = new SqlParameter("@FinancialStart", FinancialStart);
                param[2] = new SqlParameter("@FinancialEnd", FinancialEnd);
                param[3] = new SqlParameter("@ChallanDate", ChallanDate);
                param[4] = new SqlParameter("@ChallanNo", ChallanNo);
                param[5] = new SqlParameter("@Quater", Quater);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_Get_Queter_Selection_Challan_Non_Salary_Grid", param);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public int ChallanID { get; set; }

        public int DeleteChallanID()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@ChallanID", ChallanID);
                result = SqlHelper.ExecuteNonQuery(_cnnString2, CommandType.StoredProcedure, "usp_DeleteNonSalaryChallan", param);
                return result;
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }

        public int DeleteSalaryChallanID()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@ChallanID", ChallanID);
                result = SqlHelper.ExecuteNonQuery(_cnnString2, CommandType.StoredProcedure, "usp_DeleteSalaryChallan", param);
                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}
