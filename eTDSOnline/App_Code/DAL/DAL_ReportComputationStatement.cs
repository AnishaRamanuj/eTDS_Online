using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_ReportComputationStatement : DALCommon
    {
        public int Company_ID { get; set; }

        public DataSet DAL_GetReportComputationStatement()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Company_Id", Company_ID);
                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetReportComputationStatement", param);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
