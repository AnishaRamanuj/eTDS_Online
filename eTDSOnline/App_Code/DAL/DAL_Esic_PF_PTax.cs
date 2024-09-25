using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;


namespace DataLayer
{
    public class DAL_Esic_PF_PTax : DALCommon
    {
        public int _Esic_ID { get; set; }
        public int _Company_ID { get; set; }
        public string _Esic_Percentage { get; set; }
        public ulong _Esic_Limit { get; set; }

        public int _Employee_ID { get; set; }
        public int _Head_ID { get; set; }
        public double _Amount { get; set; }
        public double _Percentage { get; set; }

        public DataSet Get_Esic_List()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];

                objSqlParameter[0] = new SqlParameter("@Esic_ID", _Esic_ID);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Esic_List", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Get_DeductionAmount()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[5];

                objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);
                objSqlParameter[1] = new SqlParameter("@Head_ID", _Head_ID);
                objSqlParameter[2] = new SqlParameter("@Percentage", _Percentage);
                objSqlParameter[3] = new SqlParameter("@Amount", _Amount);
                objSqlParameter[4] = new SqlParameter("@Company_ID", _Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_DeductionAmount", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }
    }
}
