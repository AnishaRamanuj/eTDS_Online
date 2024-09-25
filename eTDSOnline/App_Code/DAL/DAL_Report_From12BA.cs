using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;
using System.Data;

namespace DataLayer
{
    public class DAL_Report_From12BA : DALCommon
    {

        public System.Data.SqlClient.SqlDataReader DAL_GetEmployeeForSelection(CommonLibrary.tbl_Employee_Master obj)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[7];
                param[0] = new SqlParameter("@CompanyID", obj.Company_ID);
                param[1] = new SqlParameter("@Designation_ID", obj.Designation_ID);
                param[2] = new SqlParameter("@Branch_ID", obj.Branch_ID);
                param[3] = new SqlParameter("@Department_ID", obj.Department_ID);
                param[4] = new SqlParameter("@EmpName", obj.EmpName);
                param[5] = new SqlParameter("@PageIndex", obj.PageIndex);
                param[6] = new SqlParameter("@PageSize", obj.PageSize);
                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_Report_From12BA_GetEmployeeForSelection", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public SqlDataReader DAL_GetEmployeePerquisitesDetails(CommonLibrary.tbl_Employee_Master obj)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@CompanyID", obj.Company_ID);
                param[1] = new SqlParameter("@EmpName", obj.EmpName);
                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_Report_From12BA_GetEmployeePerquisitesDetails", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
