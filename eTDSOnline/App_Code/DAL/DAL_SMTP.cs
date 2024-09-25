using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;


namespace DataLayer
{
    public class DAL_SMTP : DALCommon
    {
        public int _Company_ID { get; set; }
        public string _SMTP_Server { get; set; }
        public int _SMTP_Port { get; set; }
        public bool _SSL { get; set; }
        public string _SMTP_Authenticate { get; set; }
        public string _SMTP_User_Name { get; set; }
        public string _User_Password { get; set; }

        public DataSet Get_SMTP_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_SMTP_Details", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Get_SMTP_List()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_SMTP_List");
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Insert_SMTP()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[7];

                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[1] = new SqlParameter("@SMTP_Server", _SMTP_Server);
                objSqlParameter[2] = new SqlParameter("@SMTP_Port", _SMTP_Port);
                objSqlParameter[3] = new SqlParameter("@SSL", _SSL);
                objSqlParameter[4] = new SqlParameter("@SMTP_Authenticate", _SMTP_Authenticate);
                objSqlParameter[5] = new SqlParameter("@SMTP_User_Name", _SMTP_User_Name);
                objSqlParameter[6] = new SqlParameter("@User_Password", _User_Password);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Insert_SMTP", objSqlParameter);

            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Update_SMTP()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[7];

                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[1] = new SqlParameter("@SMTP_Server", _SMTP_Server);
                objSqlParameter[2] = new SqlParameter("@SMTP_Port", _SMTP_Port);
                objSqlParameter[3] = new SqlParameter("@SSL", _SSL);
                objSqlParameter[4] = new SqlParameter("@SMTP_Authenticate", _SMTP_Authenticate);
                objSqlParameter[5] = new SqlParameter("@SMTP_User_Name", _SMTP_User_Name);
                objSqlParameter[6] = new SqlParameter("@User_Password", _User_Password);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Update_SMTP", objSqlParameter);
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_SMTP()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];

                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Delete_SMTP", objSqlParameter);
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

    }
}
