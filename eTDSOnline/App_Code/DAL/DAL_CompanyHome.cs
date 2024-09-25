using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_CompanyHome:DALCommon
    {
        public int Company_ID { get; set; }
        DataSet ds;

        public System.Data.DataSet DAL_BindPieMaleFemaleChart()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_GetMaleFemale", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet DAl_BindEmployeeLeve()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetEmployeeLeaveTaker", param);
                return ds;
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }

        public DataSet DAl_EmployeeBirthDay()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                param[1] = new SqlParameter("@Employee_ID", Employee_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_GetEmployeeBirthDay", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet DAl_BindSalaryChart()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@companyID", Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_SalaryChartTDS", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet DAL_BindCompanyNameDropdown()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@companyID", Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_GetCompanyName", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
      
        public object Employee_ID { get; set; }



        public DataSet Get_Company_Master_DetailsByID()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@companyID", Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_Get_Company_Master_DetailsByID", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet Get_Dashboard_Details()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_Get_Dashboard_Details", param);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
