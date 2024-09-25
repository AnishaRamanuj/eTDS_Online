using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_ReportTDSRegister : DALCommon
    {
        public int Company_ID { get; set; }

        public DataSet DAl_GetAllReporstCompanyDetail()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] param = new SqlParameter[7];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                param[1] = new SqlParameter("@Section", Section);
                param[2] = new SqlParameter("@Nature_Name", Nature_Name);
                param[3] = new SqlParameter("@Branch_Name", Branch_Name);
                param[4] = new SqlParameter("@Deductee_Type", Deductee_Type);
                param[5] = new SqlParameter("@FromDate", FromDate);
                param[6] = new SqlParameter("@Todate", Todate);
                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_GetAllReporstCompanyDetail", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return ds;
        }

        public DataSet DAl_GetReportChallanDetails()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_GetReportChallanDetailsNonSalary", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return ds;
        }

        public string Section { get; set; }
        public string Nature_Name { get; set; }

        public string Branch_Name { get; set; }

        public string Deductee_Type { get; set; }

        public DateTime FromDate { get; set; }

        public DateTime Todate { get; set; }
    }
}
