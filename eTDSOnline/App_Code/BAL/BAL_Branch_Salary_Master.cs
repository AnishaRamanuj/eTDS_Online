using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_Branch_Salary_Master
    {
        DAL_Branch_Salary_Master objDAL_Branch_Salary_Master = new DAL_Branch_Salary_Master();

        public int _Branch_ID { get; set; }
        public string _Branch_Name { get; set; }
        public int _Company_ID { get; set; }
        public int _State_ID { get; set; }
        public int _Created_by { get; set; }
        public string SearchTxt { get; set; }
        public string SearchTxtFld { get; set; }

        public DataSet Get_Branch_Salary_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Branch_Salary_Master._Branch_ID = _Branch_ID;
                objDAL_Branch_Salary_Master._Company_ID = _Company_ID;
                ds = objDAL_Branch_Salary_Master.Get_Branch_Salary_Master_Details();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Get_Branch_Salary_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Branch_Salary_Master._Branch_Name = _Branch_Name;
                objDAL_Branch_Salary_Master._Company_ID = _Company_ID;
                objDAL_Branch_Salary_Master._State_ID = _State_ID;
                ds = objDAL_Branch_Salary_Master.Get_Branch_Salary_Master_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Branch_Salary_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Branch_Salary_Master._Branch_ID = _Branch_ID;
                objDAL_Branch_Salary_Master._Company_ID = _Company_ID;
                ds = objDAL_Branch_Salary_Master.Delete_Branch_Salary_Master();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Check_with_Employee_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Branch_Salary_Master._Branch_ID = _Branch_ID;
                ds = objDAL_Branch_Salary_Master.Check_with_Employee_Master ();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }
        public DataSet Insert_Branch_Salary_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Branch_Salary_Master._Branch_Name = _Branch_Name;
                objDAL_Branch_Salary_Master._Company_ID = _Company_ID;
                objDAL_Branch_Salary_Master._State_ID = _State_ID;
                objDAL_Branch_Salary_Master._Created_by = _Created_by;
                
                ds = objDAL_Branch_Salary_Master.Insert_Branch_Salary_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Update_Branch_Salary_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Branch_Salary_Master._Branch_ID = _Branch_ID;
                objDAL_Branch_Salary_Master._Branch_Name = _Branch_Name;
                objDAL_Branch_Salary_Master._Company_ID = _Company_ID;
                objDAL_Branch_Salary_Master._State_ID = _State_ID;

                ds = objDAL_Branch_Salary_Master.Update_Branch_Salary_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet BAL_InsertGetNonSalaryBranchMaster()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Branch_Salary_Master._Company_ID = _Company_ID;
                objDAL_Branch_Salary_Master._Branch_ID = _Branch_ID;
                objDAL_Branch_Salary_Master._Branch_Name = _Branch_Name;
                ds = objDAL_Branch_Salary_Master.DAL_InsertGetNonSalaryBranchMaster();
                return ds;
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }
    }
}
