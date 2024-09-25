using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Microsoft.ApplicationBlocks1.Data;
using System.Data.SqlClient;

namespace DataLayer
{
    public class DAL_BulkPan_Verification_AllVoucher : DALCommon
    {
        public DataSet DAL_GetAllCompanyVoucherVerification()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                //param[1] = new SqlParameter("@Verfy", Verfy);
                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetAllCompanyVoucherVerification", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }


        public DataSet DAL_SalaryPANVerification()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                param[1] = new SqlParameter("@Verfy", Verfy);
                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetSalaryPANVerification", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }


        public DataSet DAL_BulkSalaryPANVerification(string PAN)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                param[1] = new SqlParameter("@PanV", PAN);

                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_UpdateSalaryPANVerification", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }


        public DataSet DAL_BulkNonSalaryPANVerification(string PAN)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                param[1] = new SqlParameter("@PanV", PAN);

                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_UpdateNonSalaryPANVerification", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public int Company_ID { get; set; }
        public string Verfy { get; set; }

        public DataTable PANVerificaionDataTable { get; set; }

        public int DAL_UpdatePANVerification()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                param[1] = new SqlParameter("@PANVerificaionDataTable", PANVerificaionDataTable);
                int reuslt = SqlHelper.ExecuteNonQuery(_cnnString2, CommandType.StoredProcedure, "usp_UpdatePANVerification", param);
                return reuslt;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
