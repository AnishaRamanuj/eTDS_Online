using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;
using System.Data;

namespace BusinessLayer
{
    public class BAL_CompanyHome
    {
        DAL_CompanyHome objDAL_CompanyHome = new DAL_CompanyHome();

        DataSet ds;

        public System.Data.DataSet BindPieMaleFemaleChart()
        {
            try
            {
                objDAL_CompanyHome.Company_ID = Company_ID;
                ds = objDAL_CompanyHome.DAL_BindPieMaleFemaleChart();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public int Company_ID { get; set; }

        public DataSet BAl_BindEmployeeLeve()
        {
            try
            {
                objDAL_CompanyHome.Company_ID = Company_ID;
                ds = objDAL_CompanyHome.DAl_BindEmployeeLeve();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet BAl_EmployeeBirthDay()
        {
            try
            {
                objDAL_CompanyHome.Company_ID = Company_ID;
                objDAL_CompanyHome.Employee_ID = Employee_ID;
                ds = objDAL_CompanyHome.DAl_EmployeeBirthDay();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet BAl_BindSalaryChart()
        {
            try
            {
                objDAL_CompanyHome.Company_ID = Company_ID;
                ds = objDAL_CompanyHome.DAl_BindSalaryChart();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet BindCompanyNameDropdown()
        {
            try
            {
                objDAL_CompanyHome.Company_ID = Company_ID;
                ds = objDAL_CompanyHome.DAL_BindCompanyNameDropdown();
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
                objDAL_CompanyHome.Company_ID = Company_ID;
                ds = objDAL_CompanyHome.Get_Company_Master_DetailsByID();
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
                objDAL_CompanyHome.Company_ID = Company_ID;
                ds = objDAL_CompanyHome.Get_Dashboard_Details();
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
