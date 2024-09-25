using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_Branch_Master : DALCommon
    {
        public int _Branch_ID { get; set; }
        public string _Branch_Name { get; set; }
        public int _Company_ID { get; set; }
        
        public int _Created_by { get; set; }
        public string _SearchTxt { get; set; }
        public string _SearchTxtFld { get; set; }



        public DataSet Get_Branch_Salary_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];
                objSqlParameter[0] = new SqlParameter("@Branch_ID", _Branch_ID);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Branch_Master_Details", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Get_Branch_Salary_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];
                objSqlParameter[0] = new SqlParameter("@Branch_Name", _Branch_Name);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Branch_Master_List", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }



        public DataSet Insert_Branch_Salary_Master()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];

                objSqlParameter[0] = new SqlParameter("@Branch_Name", _Branch_Name);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);

               

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Insert_Branch_Master", objSqlParameter);

            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Update_Branch_Salary_Master()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[3];

                objSqlParameter[0] = new SqlParameter("@Branch_ID", _Branch_ID);
                objSqlParameter[1] = new SqlParameter("@Branch_Name", _Branch_Name);
                objSqlParameter[2] = new SqlParameter("@Company_ID", _Company_ID);


                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Update_Branch_Master", objSqlParameter);


            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Branch_Salary_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];

                objSqlParameter[0] = new SqlParameter("@Branch_ID", _Branch_ID);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Delete_Branch_Master", objSqlParameter);
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Check_with_Deductee_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[3];
                objSqlParameter[0] = new SqlParameter("@ID", _Branch_ID);
                objSqlParameter[1] = new SqlParameter("@fld", "Branch_ID");
                objSqlParameter[2] = new SqlParameter("@Company_ID", _Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Check_with_Deductee_Master", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }



    }
}
