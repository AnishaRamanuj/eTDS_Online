using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Microsoft.ApplicationBlocks1.Data;
using System.Data.SqlClient;

namespace DataLayer
{
    public class DAL_EReturns_Salary : DALCommon
    {
        DataSet ds;
        public string Quater { get; set; }
        public int Company_ID { get; set; }

        public DataSet DAL_GetEreturnsDetails()
        {
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];
                objSqlParameter[0] = new SqlParameter("@Quater", Quater);
                objSqlParameter[1] = new SqlParameter("@CompanyId", Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2,CommandType.StoredProcedure,"usp_GetEreturnsSummary",objSqlParameter);
                return ds;
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
                    }

        public int Formno { get; set; }

        public string Form { get; set; }

        public string PreviousTkn { get; set; }

        public string PreviousRTN { get; set; }

        public string aYear { get; set; }

        public string fYear { get; set; }

        public DataSet DAL_GenerateTextFile(bool nilreturns)
        {
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[8];
                objSqlParameter[0] = new SqlParameter("@Company_ID", Company_ID);
                objSqlParameter[1] = new SqlParameter("@Formno", Formno);
                objSqlParameter[2] = new SqlParameter("@Form", Form);
                objSqlParameter[3] = new SqlParameter("@PreviousTkn", PreviousTkn);
                objSqlParameter[4] = new SqlParameter("@PreviousRTN", PreviousRTN);
                objSqlParameter[5] = new SqlParameter("@aYear", aYear);
                objSqlParameter[6] = new SqlParameter("@fYear", fYear);
                objSqlParameter[7] = new SqlParameter("@Quater", Quater);
                if (nilreturns)
                { ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_eReturns_nil", objSqlParameter); }
                else { ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_eReturns", objSqlParameter); }
                
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

    }
}
