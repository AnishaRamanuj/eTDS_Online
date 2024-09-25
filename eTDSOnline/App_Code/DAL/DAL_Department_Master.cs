using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_Department_Master : DALCommon
    {

        public int _Department_ID { get; set; }
        public string _Department_Name { get; set; }
        public int _Company_ID { get; set; }
        public int _Created_by { get; set; }

        public string SearchTxt { get; set; }
        public string SearchTxtFld { get; set; }


        public DataSet BindDepartmentGrid()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Bind_Department_Master");
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
                param[0] = new SqlParameter("@tblName", "tbl_Department_Master");
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

        public DataSet Get_Department_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Department_ID", _Department_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Department_Master_Details", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Get_Department_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];
                objSqlParameter[0] = new SqlParameter("@Department_Name", _Department_Name);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Department_Master_List", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Insert_Department_Master()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[3];

                objSqlParameter[0] = new SqlParameter("@Department_Name", _Department_Name);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[2] = new SqlParameter("@Created_by", _Created_by);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Insert_Department_Master", objSqlParameter);

            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Update_Department_Master()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[3];

                objSqlParameter[0] = new SqlParameter("@Department_ID", _Department_ID);
                objSqlParameter[1] = new SqlParameter("@Department_Name", _Department_Name);
                objSqlParameter[2] = new SqlParameter("@Company_ID", _Company_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Update_Department_Master", objSqlParameter);

            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Department_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];

                objSqlParameter[0] = new SqlParameter("@Department_ID", _Department_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Delete_Department_Master", objSqlParameter);
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Check_with_Employee_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];
                objSqlParameter[0] = new SqlParameter("@ID", _Department_ID);
                objSqlParameter[1] = new SqlParameter("@fld", "Department_ID");
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Check_with_Employee_Master", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }
    }
}
