using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_Department_Master
    {
        DAL_Department_Master objDAL_Department_Master = new DAL_Department_Master();

        public int _Department_ID { get; set; }
        public string _Department_Name { get; set; }
        public int _Company_ID { get; set; }
        public int _Created_by { get; set; }

        public string SearchTxt { get; set; }
        public string SearchTxtFld { get; set; }


        public DataSet BindDepartment()
        {
            DataSet ds = new DataSet();
            
            try
            {
                ds = objDAL_Department_Master.BindDepartmentGrid() ;
            }
            catch (Exception exception)
            {
                throw new Exception(exception.Message);
            }
            return ds;
        }

        public DataSet Get_Department_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Department_Master._Department_ID = _Department_ID;
                ds = objDAL_Department_Master.Get_Department_Master_Details();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Get_Department_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Department_Master._Department_Name = _Department_Name;
                objDAL_Department_Master._Company_ID = _Company_ID;
                ds = objDAL_Department_Master.Get_Department_Master_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Department_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Department_Master._Department_ID = _Department_ID;
                ds = objDAL_Department_Master.Delete_Department_Master();
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
                objDAL_Department_Master._Department_ID = _Department_ID;
                ds = objDAL_Department_Master.Check_with_Employee_Master();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }
        public DataSet Insert_Department_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Department_Master._Department_Name = _Department_Name;
                objDAL_Department_Master._Company_ID = _Company_ID;
                objDAL_Department_Master._Created_by = _Created_by;
                
                ds = objDAL_Department_Master.Insert_Department_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Update_Department_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Department_Master._Department_ID = _Department_ID;
                objDAL_Department_Master._Department_Name = _Department_Name;
                objDAL_Department_Master._Company_ID = _Company_ID;

                ds = objDAL_Department_Master.Update_Department_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }
    }
}
