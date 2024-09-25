using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_Module_Master
    {
        DAL_Module_Master objDAL_ModuleMaster = new DAL_Module_Master();

        public int _Module_ID { get; set; }
        public string _Module_Name { get; set; }
        public int _Company_ID { get; set; }
        public string SearchTxt { get; set; }
        public string SearchTxtFld { get; set; }

        public DataSet Get_Module_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_ModuleMaster._Module_ID = _Module_ID;
                ds = objDAL_ModuleMaster.Get_Module_Master_Details();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Get_Module_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_ModuleMaster._Module_Name = _Module_Name;
                objDAL_ModuleMaster._Company_ID = _Company_ID;
                ds = objDAL_ModuleMaster.Get_Module_Master_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Module_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_ModuleMaster._Module_ID = _Module_ID;
                ds = objDAL_ModuleMaster.Delete_Module_Master();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Insert_Module_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_ModuleMaster._Module_Name = _Module_Name;
                objDAL_ModuleMaster._Company_ID = _Company_ID;

                ds = objDAL_ModuleMaster.Insert_Module_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Update_Module_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_ModuleMaster._Module_ID = _Module_ID;
                objDAL_ModuleMaster._Module_Name = _Module_Name;
                objDAL_ModuleMaster._Company_ID = _Company_ID;

                ds = objDAL_ModuleMaster.Update_Module_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }
    }
}
