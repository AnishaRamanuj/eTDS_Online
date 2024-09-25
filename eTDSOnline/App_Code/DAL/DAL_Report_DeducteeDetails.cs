using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_Report_DeducteeDetails : DALCommon
    {
        public SqlDataReader DAL_GetDeducteesForSelection(CommonLibrary.tbl_Voucher obj)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[6];
                param[0] = new SqlParameter("@CompanyID", obj.Company_ID);
                param[1] = new SqlParameter("@Deductee_Name", obj.Deductee_Name);
                param[2] = new SqlParameter("@PANVerified", obj.PANVerified);
                param[3] = new SqlParameter("@Reason", obj.Reason);
                param[4] = new SqlParameter("@PageIndex", obj.PageIndex);
                param[5] = new SqlParameter("@PageSize", obj.PageSize);
                return SqlHelper.ExecuteReader(_cnnString, CommandType.StoredProcedure, "usp_Report_DeducteeDetails_GetDeducteesForSelection", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public SqlDataReader DAL_GetDeducteeMasterDetails(CommonLibrary.tbl_Voucher obj)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@CompanyID", obj.Company_ID);
                param[1] = new SqlParameter("@Deductee_Name", obj.Deductee_Name);
                return SqlHelper.ExecuteReader(_cnnString, CommandType.StoredProcedure, "usp_Report_DeducteeDetails_GetDeducteeMasterDetails", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
