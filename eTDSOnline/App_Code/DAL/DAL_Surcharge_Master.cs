using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_Surcharge_Master : DALCommon
    {
        public int _Surcharge_ID { get; set; }
        public int _Company_ID { get; set; }
        public double _Surcharge_Percent { get; set; }
        public string _App_Type { get; set; }

        public DataSet Get_Surcharge_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Surcharge_ID", _Surcharge_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Surcharge_Master_Details", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Get_Surcharge_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];
                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[1] = new SqlParameter("@App_Type", _App_Type);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Surcharge_Master_List", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Insert_Surcharge_Master()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[3];

                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[1] = new SqlParameter("@Surcharge_Percent", _Surcharge_Percent);
                objSqlParameter[2] = new SqlParameter("@App_Type", _App_Type);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Insert_Surcharge_Master", objSqlParameter);

            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Update_Surcharge_Master()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[4];

                objSqlParameter[0] = new SqlParameter("@Surcharge_ID", _Surcharge_ID);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[2] = new SqlParameter("@Surcharge_Percent", _Surcharge_Percent);
                objSqlParameter[3] = new SqlParameter("@App_Type", _App_Type);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Update_Surcharge_Master", objSqlParameter);

            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Delete_Surcharge_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];

                objSqlParameter[0] = new SqlParameter("@Surcharge_ID", _Surcharge_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Delete_Surcharge_Master", objSqlParameter);
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }


        public DataSet DAL_GetSurchargedetails()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];
                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[1] = new SqlParameter("@App_Type", _App_Type);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetSurchargedetails", objSqlParameter);
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet DAL_GetSurchargedetailsnew()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetSurchargedetailsnew", objSqlParameter);
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public int DAL_SaveSurchargedetails()
        {
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[4];
                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[1] = new SqlParameter("@App_Type", _App_Type);
                objSqlParameter[2] = new SqlParameter("@Surcharge_Percent", _Surcharge_Percent);
                objSqlParameter[3] = new SqlParameter("@SurchargeType", _SurchargeType);
                return SqlHelper.ExecuteNonQuery(_cnnString2, CommandType.StoredProcedure, "usp_SaveSurchargedetails", objSqlParameter);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public string _SurchargeType { get; set; }
    }
}
