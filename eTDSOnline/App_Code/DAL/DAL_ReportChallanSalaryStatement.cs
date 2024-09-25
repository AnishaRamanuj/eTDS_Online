using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using Microsoft.ApplicationBlocks1.Data;
using CommonLibrary;

namespace DataLayer
{
    public class DAL_ReportChallanSalaryStatement : DALCommon
    {
        public SqlDataReader DAL_GetChallanSalaryBreakup(tbl_Employee_Master obj)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@CompanyID", obj.Company_ID);
                param[1] = new SqlParameter("@Quarter", obj.EmpName);
                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_ReportChallanSalaryStatement_EmployeeTAXDeduction_GetChallanSalaryBreakup", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public SqlDataReader DAL_GetCompanyMaterDetails(tbl_Employee_Master obj)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@CompanyID", obj.Company_ID);
                return SqlHelper.ExecuteReader(_cnnString, CommandType.StoredProcedure, "usp_GetCompanyMaterDetails", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public SqlDataReader DAL_BindOnPageLoad(tbl_Employee_Master obj)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Company_ID", obj.Company_ID);
                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_ManageBonus_BindOnPageLoad", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public SqlDataReader DAL_EmployeeTAxDeduction_GetChallanSalaryBreakup(tbl_Employee_Master obj)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@CompanyID", obj.Company_ID);
                param[1] = new SqlParameter("@Quarter", obj.EmpName);
                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_ReportChallanSalaryStatement_Employee_TAx_Deduction_GetChallanSalaryBreakup", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public SqlDataReader DAL_ReportEmployeeDeduction_BindEmployee(tbl_Employee_Master obj)
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
                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_ReportChallanSalaryStatement_ReportEmployeeDeduction_BindEmployee", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
