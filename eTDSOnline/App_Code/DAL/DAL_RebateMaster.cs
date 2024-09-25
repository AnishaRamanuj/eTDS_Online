using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;
namespace DataLayer
{
   public class DAL_RebateMaster : DALCommon
    {
       public int RebateId { get; set; }
       public string RebateName { get; set; }
        public int CreatedBy { get; set; }
        public int CompanyID { get; set; }
        public string SearchTxt { get; set; }
        public string SearchTxtFld { get; set; }


        public DataSet BindRebateGrid()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Bind_Rebate_Master");
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
                param[0] = new SqlParameter("@tblName", "tbl_Rebate_Master");
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


        public DataSet InsertRebateMaster()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] sqlParams = new SqlParameter[4];
                sqlParams[0] = new SqlParameter("@RebateID", SqlDbType.Int);
                sqlParams[0].Direction = ParameterDirection.InputOutput;
                sqlParams[0].Value = RebateId;
                sqlParams[1] = new SqlParameter("@RebateName", SqlDbType.NVarChar);
                sqlParams[1].Value = RebateName;
                sqlParams[2] = new SqlParameter("@Companyid", SqlDbType.Char);
                sqlParams[2].Value = 1;
                sqlParams[3] = new SqlParameter("@createdby", SqlDbType.Char);
                sqlParams[3].Value = 1;
                SqlHelper.ExecuteScalar(_cnnString, CommandType.StoredProcedure, "usp_Insert_Rebate_Master", sqlParams);
                //SqlHelper.ExecuteScalar(_cnnString, "usp_Insert_Department_Master", sqlParams);
                RebateId = Convert.ToInt32(sqlParams[0].Value);

            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }



        public DataSet UpdateRebateMaster()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] sqlParams = new SqlParameter[4];
                sqlParams[0] = new SqlParameter("@RebateID", SqlDbType.Int);
                sqlParams[0].Direction = ParameterDirection.InputOutput;
                sqlParams[0].Value = RebateId;
                sqlParams[1] = new SqlParameter("@RebateName", SqlDbType.NVarChar);
                sqlParams[1].Value = RebateName;
                sqlParams[2] = new SqlParameter("@Companyid", SqlDbType.Char);
                sqlParams[2].Value = 1;
                sqlParams[3] = new SqlParameter("@createdby", SqlDbType.Char);
                sqlParams[3].Value = 1;
                SqlHelper.ExecuteScalar(_cnnString, CommandType.StoredProcedure, "usp_Update_Rebate_Master", sqlParams);
                //SqlHelper.ExecuteScalar(_cnnString, "usp_Insert_Department_Master", sqlParams);
                RebateId = Convert.ToInt32(sqlParams[0].Value);

            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet DeleteRebateMaster()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] sqlParams = new SqlParameter[4];
                sqlParams[0] = new SqlParameter("@RebateID", SqlDbType.Int);
                sqlParams[0].Direction = ParameterDirection.InputOutput;
                sqlParams[0].Value = RebateId;
                sqlParams[1] = new SqlParameter("@RebateName", SqlDbType.NVarChar);
                sqlParams[1].Value = RebateName;
                sqlParams[2] = new SqlParameter("@Companyid", SqlDbType.Char);
                sqlParams[2].Value = 1;
                sqlParams[3] = new SqlParameter("@createdby", SqlDbType.Char);
                sqlParams[3].Value = 1;
                SqlHelper.ExecuteScalar(_cnnString, CommandType.StoredProcedure, "usp_Delete_Rebate_Master", sqlParams);
                //SqlHelper.ExecuteScalar(_cnnString, "usp_Insert_Department_Master", sqlParams);
                RebateId = Convert.ToInt32(sqlParams[0].Value);

            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

    }
}
