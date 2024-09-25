using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;
namespace DataLayer
{
    public class DAL_Company_Module_Mapping : DALCommon
    {
        public int Module_ID { get; set; }
        public int Mapping_ID { get; set; }
        public string Module_Name { get; set; }
        public int Company_ID { get; set; }
        public Boolean  isActive { get; set; }
        public string Company_Name { get; set; }
        public string SearchTxt { get; set; }
        public string SearchTxtFld { get; set; }

        public DataSet BindModuleGrid()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Bind_ModuleMapping_Master");
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }


        public DataSet BindModuleCompany()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Company_List");
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }


        public DataSet BindModuleList()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = SqlHelper.ExecuteDataset(_cnnString, "USP_BindModuleDropDown");
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet BindCompanyModuleList()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@CompanyID", Company_ID );

                ds = SqlHelper.ExecuteDataset(_cnnString, "USP_BindCompanyModuleDropDown",param);
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
                param[0] = new SqlParameter("@tblName", "tbl_CompanyModule_Mapping");
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

        public DataSet Get_ModuleMapping_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Mapping_ID", Mapping_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_ModuleMapping_Master_Details", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Get_ModuleMapping_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Module_Name", Module_Name);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_ModuleMapping_Master_List", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Insert_ModuleMapping_Master()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[3];

                objSqlParameter[0] = new SqlParameter("@Module_ID", Module_ID);
                objSqlParameter[1] = new SqlParameter("@Company_ID", Company_ID );
                objSqlParameter[2] = new SqlParameter("@isActive", isActive );


                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Insert_ModuleMapping_Master", objSqlParameter);

            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Update_ModuleMapping_Master()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[4];

                objSqlParameter[0] = new SqlParameter("@Mapping_ID", Mapping_ID );
                objSqlParameter[1] = new SqlParameter("@Module_ID", Module_ID);
                objSqlParameter[2] = new SqlParameter("@Company_ID", Company_ID);
                objSqlParameter[3] = new SqlParameter("@isActive", isActive);


                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Update_ModuleMapping_Master", objSqlParameter);


            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_ModuleMapping_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[3];

                objSqlParameter[0] = new SqlParameter("@Module_ID", Module_ID);
                objSqlParameter[1] = new SqlParameter("@Mapping_ID", Mapping_ID);
                objSqlParameter[2] = new SqlParameter("@Company_ID", Company_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Delete_ModuleMapping_Master", objSqlParameter);
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

    }

}