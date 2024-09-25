using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_Educationcess_Master : DALCommon
    {
        public int _Educationcess_ID { get; set; }
        public int _Company_ID { get; set; }
        public double _Cess_Percent { get; set; }
        public string _App_Type { get; set; }
        public double _HCess_Percent { get; set; }

        public DataSet Get_Educationcess_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Educationcess_ID", _Educationcess_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Educationcess_Master_Details", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Get_Educationcess_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];
                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[1] = new SqlParameter("@App_Type", _App_Type);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Educationcess_Master_List", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Insert_Educationcess_Master()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[4];

                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[1] = new SqlParameter("@Cess_Percent", _Cess_Percent);
                objSqlParameter[2] = new SqlParameter("@App_Type", _App_Type);
                objSqlParameter[3] = new SqlParameter("@HCess_Percent", _HCess_Percent);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Insert_Educationcess_Master", objSqlParameter);

            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Update_Educationcess_Master()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[5];

                objSqlParameter[0] = new SqlParameter("@Educationcess_ID", _Educationcess_ID);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[2] = new SqlParameter("@Cess_Percent", _Cess_Percent);
                objSqlParameter[3] = new SqlParameter("@App_Type", _App_Type);
                objSqlParameter[4] = new SqlParameter("@HCess_Percent", _HCess_Percent);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Update_Educationcess_Master", objSqlParameter);

            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Delete_Educationcess_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];

                objSqlParameter[0] = new SqlParameter("@Educationcess_ID", _Educationcess_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Delete_Educationcess_Master", objSqlParameter);
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

    }
}
