using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Microsoft.ApplicationBlocks1.Data;
using System.Data.SqlClient;

namespace DataLayer
{
    public class DAL_CreateUsers : DALCommon
    {
        DataSet ds;

        public int ParentCompany { get; set; }

        public DataSet DAL_GetCompanyNamesCreateUser()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@ParentCompany", ParentCompany);
                ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_GetCompanyNamesCreateUser", param);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
