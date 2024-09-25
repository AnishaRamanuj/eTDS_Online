using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
   public class DAL_SurchargeMaster : DALCommon 
    {
        public int SurchargeId { get; set; }
        public string SurchargePercent { get; set; }
        public int CreatedBy { get; set; }
        public int CompanyID { get; set; }
        public string App_Type { get; set; }
        public string SearchTxt { get; set; }
        public string SearchTxtFld { get; set; }


        public DataSet BindSurchargeGrid()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Bind_Surcharge_Master");
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
                param[0] = new SqlParameter("@tblName", "tbl_Surcharge_Master");
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


        public DataSet InsertSurchargeMaster()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] sqlParams = new SqlParameter[4];
                sqlParams[0] = new SqlParameter("@SurchargeID", SqlDbType.Int);
                sqlParams[0].Direction = ParameterDirection.InputOutput;
                sqlParams[0].Value = SurchargeId;
                sqlParams[1] = new SqlParameter("@SurchargePercent", SqlDbType.NVarChar);
                sqlParams[1].Value = SurchargePercent;
                sqlParams[2] = new SqlParameter("@Companyid", SqlDbType.Char);
                sqlParams[2].Value = 1;
                sqlParams[3] = new SqlParameter("@createdby", SqlDbType.Char);
                sqlParams[3].Value = 1;
                sqlParams[4] = new SqlParameter("@App_Type", SqlDbType.Char);
                sqlParams[4].Value = "SAL";
                SqlHelper.ExecuteScalar(_cnnString, CommandType.StoredProcedure, "usp_Insert_Surcharge_Master", sqlParams);
                //SqlHelper.ExecuteScalar(_cnnString, "usp_Insert_Department_Master", sqlParams);
                SurchargeId = Convert.ToInt32(sqlParams[0].Value);

            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }



        public DataSet UpdateSurchargeMaster()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] sqlParams = new SqlParameter[4];
                sqlParams[0] = new SqlParameter("@SurchargeID", SqlDbType.Int);
                sqlParams[0].Direction = ParameterDirection.InputOutput;
                sqlParams[0].Value = SurchargeId;
                sqlParams[1] = new SqlParameter("@SurchargePercent", SqlDbType.NVarChar);
                sqlParams[1].Value = SurchargePercent;
                sqlParams[2] = new SqlParameter("@Companyid", SqlDbType.Char);
                sqlParams[2].Value = 1;
                sqlParams[3] = new SqlParameter("@createdby", SqlDbType.Char);
                sqlParams[3].Value = 1;
                sqlParams[4] = new SqlParameter("@App_Type", SqlDbType.Char);
                sqlParams[4].Value = "SAL";
                SqlHelper.ExecuteScalar(_cnnString, CommandType.StoredProcedure, "usp_Update_Surcharge_Master", sqlParams);
                //SqlHelper.ExecuteScalar(_cnnString, "usp_Insert_Department_Master", sqlParams);
                SurchargeId = Convert.ToInt32(sqlParams[0].Value);

            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet DeleteSurchargeMaster()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] sqlParams = new SqlParameter[4];
                sqlParams[0] = new SqlParameter("@SurchargeID", SqlDbType.Int);
                sqlParams[0].Direction = ParameterDirection.InputOutput;
                sqlParams[0].Value = SurchargeId;
                sqlParams[1] = new SqlParameter("@SurchargePercent", SqlDbType.NVarChar);
                sqlParams[1].Value = SurchargePercent;
                sqlParams[2] = new SqlParameter("@Companyid", SqlDbType.Char);
                sqlParams[2].Value = 1;
                sqlParams[3] = new SqlParameter("@createdby", SqlDbType.Char);
                sqlParams[3].Value = 1;
                sqlParams[4] = new SqlParameter("@App_Type", SqlDbType.Char);
                sqlParams[4].Value = "SAL";
                SqlHelper.ExecuteScalar(_cnnString, CommandType.StoredProcedure, "usp_Delete_Surcharge_Master", sqlParams);
                //SqlHelper.ExecuteScalar(_cnnString, "usp_Insert_Department_Master", sqlParams);
                SurchargeId = Convert.ToInt32(sqlParams[0].Value);

            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

    }
}
