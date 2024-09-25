using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_Designation_Master
    {
        DAL_Designation_Master objDAL_DesignationMaster = new DAL_Designation_Master();

        public int _Designation_ID { get; set; }
        public string _Designation_Name { get; set; }
        public int _Company_ID { get; set; }
        public string SearchTxt { get; set; }
        public string SearchTxtFld { get; set; }

        public DataSet Get_Designation_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_DesignationMaster._Designation_ID = _Designation_ID;
                ds = objDAL_DesignationMaster.Get_Designation_Master_Details();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Get_Designation_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_DesignationMaster._Designation_Name = _Designation_Name;
                objDAL_DesignationMaster._Company_ID = _Company_ID;
                ds = objDAL_DesignationMaster.Get_Designation_Master_List();
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
                objDAL_DesignationMaster._Designation_ID = _Designation_ID;
                ds = objDAL_DesignationMaster.Check_with_Employee_Master ();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Designation_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_DesignationMaster._Designation_ID = _Designation_ID;
                ds = objDAL_DesignationMaster.Delete_Designation_Master();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Insert_Designation_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_DesignationMaster._Designation_Name = _Designation_Name;
                objDAL_DesignationMaster._Company_ID = _Company_ID;
                
                ds = objDAL_DesignationMaster.Insert_Designation_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Update_Designation_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_DesignationMaster._Designation_ID = _Designation_ID;
                objDAL_DesignationMaster._Designation_Name = _Designation_Name;
                objDAL_DesignationMaster._Company_ID = _Company_ID;

                ds = objDAL_DesignationMaster.Update_Designation_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }
    }
}
