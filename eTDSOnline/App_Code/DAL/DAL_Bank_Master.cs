using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;
using DataLayer;
using CommonLibrary;
using System.Globalization;

namespace DataLayer
{
    public class DAL_Bank_Master : DALCommon
    {
        public int _Bank_ID { get; set; }
        public String _compid { get; set; }
        public string _dbname { get; set; }
        public int msg { get; set; }
        public string _Bank_Name { get; set; }
        public string _Bank_Branch { get; set; }
        public string _Bsrcode { get; set; }
        public int _Company_ID { get; set; }
        public string SearchTxt { get; set; }
        public string SearchTxtFld { get; set; }
        public string conn { get; set; }

        public DataSet BindBankGrid()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Bind_Bank_Master");
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Search4Txt()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] param = new SqlParameter[4];
                param[0] = new SqlParameter("@tblName", "tbl_Bank_Master");
                param[1] = new SqlParameter("@fldName", SearchTxtFld);
                param[2] = new SqlParameter("@Companyid", "1");
                param[3] = new SqlParameter("@flddetails", SearchTxt);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Search", param);
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Bank_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Bank_ID", _Bank_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Bank_Master_Details", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Get_Bank_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];
                objSqlParameter[0] = new SqlParameter("@Bank_Name", _Bank_Name);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Bank_Master_List", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Insert_Bank_Master()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[4];

                objSqlParameter[0] = new SqlParameter("@Bank_Name", _Bank_Name);
                objSqlParameter[1] = new SqlParameter("@Bank_Branch", _Bank_Branch);
                objSqlParameter[2] = new SqlParameter("@Bsrcode", _Bsrcode);
                objSqlParameter[3] = new SqlParameter("@Company_ID", _Company_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Insert_Bank_Master", objSqlParameter);

            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Update_Bank_Master()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[5];

                objSqlParameter[0] = new SqlParameter("@Bank_ID", _Bank_ID);
                objSqlParameter[1] = new SqlParameter("@Bank_Name", _Bank_Name);
                objSqlParameter[2] = new SqlParameter("@Bank_Branch", _Bank_Branch);
                objSqlParameter[3] = new SqlParameter("@Bsrcode", _Bsrcode);
                objSqlParameter[4] = new SqlParameter("@Company_ID", _Company_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Update_Bank_Master", objSqlParameter);


            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Bank_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[3];

                objSqlParameter[0] = new SqlParameter("@Bank_ID", _Bank_ID);
                objSqlParameter[1] = new SqlParameter("@dbname", _dbname);
                objSqlParameter[2] = new SqlParameter("@compid", _compid);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Delete_Bank_Master", objSqlParameter);
            }
            catch (Exception ex)
            {

                throw new Exception(ex.Message);
            }
            return ds;
        }

    }
}
