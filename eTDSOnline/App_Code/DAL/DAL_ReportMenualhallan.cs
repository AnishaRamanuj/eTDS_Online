using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using Microsoft.ApplicationBlocks1.Data;
using CommonLibrary;

namespace DataLayer
{
    public class DAL_ReportMenualhallan : DALCommon
    {
        public DataSet DAl_GetNatureSection()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_GetSectionnId");
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return ds;
        }

        public DataSet DAL_GetBankName(int Compid)
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Compid", Compid);
              
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_GetBankName",param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return ds;
        }

        public SqlDataReader DAL_GetCompanyDetail(tbl_CompanyDetail obj)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Compid", obj.Company_id);

                return SqlHelper.ExecuteReader(_cnnString, CommandType.StoredProcedure, "usp_Challan_CompDetail", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }

}
