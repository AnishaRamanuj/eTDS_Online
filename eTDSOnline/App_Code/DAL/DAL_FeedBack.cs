using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.ApplicationBlocks1.Data;
using System.Data.SqlClient;
using System.Data;

namespace DataLayer
{
    public class DAL_FeedBack : DALCommon
    {
        public int Company_Id { get; set; }

        public string CreatedBy { get; set; }

        public string CompanyName { get; set; }

        public string YourName { get; set; }

        public string Email { get; set; }

        public string mobileno { get; set; }

        public string feedback { get; set; }

        public string extra { get; set; }


        public int DAL_InsertGetFeedback()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[8];
                param[0] = new SqlParameter("@CompanyID", Company_Id);
                param[1] = new SqlParameter("@CreatedBy", CreatedBy);
                param[2] = new SqlParameter("@CompanyName", CompanyName);
                param[3] = new SqlParameter("@YourName", YourName);
                param[4] = new SqlParameter("@Email", Email);
                param[5] = new SqlParameter("@mobileno", mobileno);
                param[6] = new SqlParameter("@feedback", feedback);
                param[7] = new SqlParameter("@extra", extra);
                int result = Convert.ToInt32(SqlHelper.ExecuteScalar(_cnnString2, "usp_InsertGetFeedback", param));
                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet DAl_GetAllFeedBack()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@CompanyID", Company_Id);
                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetAllFeedBack", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}
