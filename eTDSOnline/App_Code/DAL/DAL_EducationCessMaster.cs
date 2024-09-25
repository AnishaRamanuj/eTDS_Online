using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;
namespace DataLayer
{
   public class DAL_EducationCessMaster : DALCommon 
    {

       public int EducationCessId { get; set; }
       public string EducationCessPercent { get; set; }
       public string HCessPercent { get; set; }
        public int CreatedBy { get; set; }
        public int CompanyID { get; set; }
        public string SearchTxt { get; set; }
        public string SearchTxtFld { get; set; }


        public DataSet BindEducationCessGrid()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Bind_EducationCess_Master");
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
                param[0] = new SqlParameter("@tblName", "tbl_EducationCess_Master");
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


        public DataSet InsertEducationCessMaster()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] sqlParams = new SqlParameter[4];
                sqlParams[0] = new SqlParameter("@EducationCessID", SqlDbType.Int);
                sqlParams[0].Direction = ParameterDirection.InputOutput;
                sqlParams[0].Value = EducationCessId;
                sqlParams[1] = new SqlParameter("@EducationCessPercent", SqlDbType.Char);
                sqlParams[1].Value = EducationCessPercent;
                sqlParams[2] = new SqlParameter("@Companyid", SqlDbType.Char);
                sqlParams[2].Value = 1;
                sqlParams[3] = new SqlParameter("@createdby", SqlDbType.Char);
                sqlParams[3].Value = 1;
                sqlParams[4] = new SqlParameter("@HCessPercent", SqlDbType.Char);
                sqlParams[4].Value = HCessPercent;

                SqlHelper.ExecuteScalar(_cnnString, CommandType.StoredProcedure, "usp_Insert_EducationCess_Master", sqlParams);
                //SqlHelper.ExecuteScalar(_cnnString, "usp_Insert_Department_Master", sqlParams);
                EducationCessId = Convert.ToInt32(sqlParams[0].Value);

            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }



        public DataSet UpdateEducationCessMaster()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] sqlParams = new SqlParameter[4];
                sqlParams[0] = new SqlParameter("@EducationCessID", SqlDbType.Int);
                sqlParams[0].Direction = ParameterDirection.InputOutput;
                sqlParams[0].Value = EducationCessId;
                sqlParams[1] = new SqlParameter("@EducationCessPercent", SqlDbType.NVarChar);
                sqlParams[1].Value = EducationCessPercent ;
                sqlParams[2] = new SqlParameter("@Companyid", SqlDbType.Char);
                sqlParams[2].Value = 1;
                sqlParams[3] = new SqlParameter("@createdby", SqlDbType.Char);
                sqlParams[3].Value = 1;
                sqlParams[4] = new SqlParameter("@HCessPercent", SqlDbType.Char);
                sqlParams[4].Value = HCessPercent;
                SqlHelper.ExecuteScalar(_cnnString, CommandType.StoredProcedure, "usp_Update_EducationCess_Master", sqlParams);
                //SqlHelper.ExecuteScalar(_cnnString, "usp_Insert_Department_Master", sqlParams);
                EducationCessId = Convert.ToInt32(sqlParams[0].Value);

            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet DeleteEducationCessMaster()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] sqlParams = new SqlParameter[4];
                sqlParams[0] = new SqlParameter("@EducationCessID", SqlDbType.Int);
                sqlParams[0].Direction = ParameterDirection.InputOutput;
                sqlParams[0].Value = EducationCessId;
                sqlParams[1] = new SqlParameter("@EducationCessPercent", SqlDbType.NVarChar);
                sqlParams[1].Value = EducationCessPercent ;
                sqlParams[2] = new SqlParameter("@Companyid", SqlDbType.Char);
                sqlParams[2].Value = 1;
                sqlParams[3] = new SqlParameter("@createdby", SqlDbType.Char);
                sqlParams[3].Value = 1;
                sqlParams[4] = new SqlParameter("@HCessPercent", SqlDbType.Char);
                sqlParams[4].Value = HCessPercent;
                SqlHelper.ExecuteScalar(_cnnString, CommandType.StoredProcedure, "usp_Delete_EducationCess_Master", sqlParams);
                //SqlHelper.ExecuteScalar(_cnnString, "usp_Insert_Department_Master", sqlParams);
                EducationCessId = Convert.ToInt32(sqlParams[0].Value);

            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

    }
}
