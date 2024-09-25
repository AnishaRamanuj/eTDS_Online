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
    public class DAL_ReportPANDetails:DALCommon
    {
        public SqlDataReader DAL_GetEmployeeList(tbl_Employee_Master obj)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@CompanyID", obj.Company_ID);
                return SqlHelper.ExecuteReader(_cnnString, CommandType.StoredProcedure, "usp_ReportPANDetails_GetEmployeeList", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public SqlDataReader DAL_GetEmployeeList_ForNonSalary(tbl_Employee_Master obj)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@CompanyID", obj.Company_ID);
                param[1] = new SqlParameter("@Nature_ID", obj.Nature_id);
                param[2] = new SqlParameter("@Quater", obj.Quater);
                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_GetEmployeeList_ForNonSalary", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet DAl_SectionnNature()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_GetSectionnNature");
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return ds;
        }

        public SqlDataReader DAL_GetDeduction_Salary(CommonLibrary.tbl_DeductionStatment obj)
        {
            try
            {
                DataSet ds = new DataSet();
                SqlParameter[] param = new SqlParameter[4];
                param[0] = new SqlParameter("@CompanyID", obj.Companyid);
                param[1] = new SqlParameter("@Quater", obj.Qua);
                param[2] = new SqlParameter("@FrDT", obj.Fdate);
                param[3] = new SqlParameter("@ToDT", obj.Tdate);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_Get_DeductionStatement", param);
                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_Get_DeductionStatement", param);

            }
            catch(Exception ex)
            {
                throw ex;
            }
        }
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
                return SqlHelper.ExecuteReader(_cnnString, CommandType.StoredProcedure, "usp_ReportPANDetails_GetEmployeeForSelection", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public SqlDataReader DAL_GetEmployeeMasterDetails(tbl_Employee_Master obj)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@CompanyID", obj.Company_ID);
                param[1] = new SqlParameter("@Empids", obj.EmpName);
                return SqlHelper.ExecuteReader(_cnnString, CommandType.StoredProcedure, "usp_ReportPANDetails_GetEmployeeMasterDetails", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
