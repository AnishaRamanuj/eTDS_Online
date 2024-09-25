using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;
using System.Data;
using CommonLibrary;

namespace DataLayer
{
    public class DAL_ReportForm16 : DALCommon
    {
        public SqlDataReader DAL_GetEmployeeForSelection(CommonLibrary.tbl_Employee_Master obj)
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
                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_ReportForm16_GetEmployeeForSelection", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public SqlDataReader DAL_GetEmployeeComputationDetails(CommonLibrary.tbl_Employee_Master obj)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@CompanyID", obj.Company_ID);
                param[1] = new SqlParameter("@EmpIDS", obj.EmpName);
                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_ReportForm16_GetEmployeeComputationDetails", param);
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

        public SqlDataReader DAL_GetEmployeeSetion10Details(CommonLibrary.tbl_Employee_Master obj)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@CompanyID", obj.Company_ID);
                param[1] = new SqlParameter("@EmpIDS", obj.EmpName);
                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_ReportForm16_GetEmployeeSetion10Details", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public SqlDataReader DAL_GetEmployeeRebateDetails(CommonLibrary.tbl_Employee_Master obj)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@CompanyID", obj.Company_ID);
                param[1] = new SqlParameter("@EmpIDS", obj.EmpName);
                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_ReportForm16_GetEmployeeRebateDetails", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public SqlDataReader DAL_BindForm16Settings(CommonLibrary.tbl_Employee_Master obj)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@CompanyID", obj.Company_ID);
                return SqlHelper.ExecuteReader(_cnnString, CommandType.StoredProcedure, "usp_ReportForm16_BindForm16Settings", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int DAL_SaveFrom16Settings(CommonLibrary.tbl_Form16settings obj)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[6];
                param[0] = new SqlParameter("@CompanyID", obj.companyid);
                param[1] = new SqlParameter("@designation", obj.designation);
                param[2] = new SqlParameter("@location", obj.location);
                param[3] = new SqlParameter("@personname", obj.personname);
                param[4] = new SqlParameter("@releation", obj.releation);
                param[5] = new SqlParameter("@releationname", obj.releationname);
                return SqlHelper.ExecuteNonQuery(_cnnString, CommandType.StoredProcedure, "usp_ReportForm16_SaveFrom16Settings", param);
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
                return SqlHelper.ExecuteReader(_cnnString, CommandType.StoredProcedure, "usp_PaySlipReport_GetCompanyMaterDetails", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public SqlDataReader DAL_GetHeadDetails(tbl_Employee_Master obj)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@CompanyID", obj.Company_ID);
                param[1] = new SqlParameter("@EmpIDS", obj.EmpName);

                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_Computation_Head", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public SqlDataReader DAL_GetHeadtwoDetails(tbl_Employee_Master obj)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@CompanyID", obj.Company_ID);
                param[1] = new SqlParameter("@EmpIDS", obj.EmpName);

                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_Computation_Headtwo", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
