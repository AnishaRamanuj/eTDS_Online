using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;


namespace DataLayer
{
    public class DAL_Designation_Master : DALCommon
    {
        public int _Designation_ID { get; set; }
        public string _Designation_Name { get; set; }
        public int _Company_ID { get; set; }
        public string SearchTxt { get; set; }
        public string SearchTxtFld { get; set; }

        public DataSet BindDesignationGrid()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Bind_Designation_Master");
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
                param[0] = new SqlParameter("@tblName", "tbl_Designation_Master");
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

        public DataSet Get_Designation_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Designation_ID", _Designation_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Designation_Master_Details", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Get_Designation_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];
                objSqlParameter[0] = new SqlParameter("@Designation_Name", _Designation_Name);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Designation_Master_List", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Insert_Designation_Master()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];

                objSqlParameter[0] = new SqlParameter("@Designation_Name", _Designation_Name);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Insert_Designation_Master", objSqlParameter);

            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Update_Designation_Master()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[3];

                objSqlParameter[0] = new SqlParameter("@Designation_ID", _Designation_ID);
                objSqlParameter[1] = new SqlParameter("@Designation_Name", _Designation_Name);
                objSqlParameter[2] = new SqlParameter("@Company_ID", _Company_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Update_Designation_Master", objSqlParameter);


            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Designation_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];

                objSqlParameter[0] = new SqlParameter("@Designation_ID", _Designation_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Delete_Designation_Master", objSqlParameter);
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
                objSqlParameter[0] = new SqlParameter("@ID", _Designation_ID);
                objSqlParameter[1] = new SqlParameter("@fld", "Designation_ID");
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
