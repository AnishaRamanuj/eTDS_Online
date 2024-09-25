using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
   public class DAL_Module_Master : DALCommon
    {
        public int _Module_ID { get; set; }
        public string _Module_Name { get; set; }
        public int _Company_ID { get; set; }
        public string SearchTxt { get; set; }
        public string SearchTxtFld { get; set; }

        public DataSet BindModuleGrid()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Bind_Module_Master");
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
                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@tblName", "tbl_Module_Master");
                param[1] = new SqlParameter("@fldName", SearchTxtFld);
                param[2] = new SqlParameter("@flddetails", SearchTxt);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Search", param);
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Module_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Module_ID", _Module_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Module_Master_Details", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Get_Module_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Module_Name", _Module_Name);
                
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Module_Master_List", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Insert_Module_Master()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];

                objSqlParameter[0] = new SqlParameter("@Module_Name", _Module_Name);
                

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Insert_Module_Master", objSqlParameter);

            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Update_Module_Master()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];

                objSqlParameter[0] = new SqlParameter("@Module_ID", _Module_ID);
                objSqlParameter[1] = new SqlParameter("@Module_Name", _Module_Name);
               

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Update_Module_Master", objSqlParameter);


            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Module_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];

                objSqlParameter[0] = new SqlParameter("@Module_ID", _Module_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Delete_Module_Master", objSqlParameter);
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

    }
}
