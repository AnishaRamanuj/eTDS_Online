using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_Section_10 : DALCommon
    {
        public int _Employee_ID { get; set; }
        public int _Company_ID { get; set; }
        public int _Head_ID { get; set; }
        public double _Amount { get; set; }

        public DataSet Get_Section_10_List()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[3];
                objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[2] = new SqlParameter("@Head_ID", _Head_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Section_10_List", objSqlParameter);

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Insert_Section_10()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[4];

                objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[2] = new SqlParameter("@Head_ID", _Head_ID);
                objSqlParameter[3] = new SqlParameter("@Amount", _Amount);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Insert_Section_10", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Delete_Section_10()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Delete_Section_10_List", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }
    }
}
