using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
   public class BAL_Company_Module_Mapping
    {
       DAL_Company_Module_Mapping objDAL_ModuleMaster = new DAL_Company_Module_Mapping();

        public int Module_ID { get; set; }
        public int Mapping_ID { get; set; }
        public string Module_Name { get; set; }
        public int Company_ID { get; set; }
        public Boolean isActive { get; set; }
        public string Company_Name { get; set; }
        public string SearchTxt { get; set; }
        public string SearchTxtFld { get; set; }

        public DataSet BindModuleCompany()
        {
            DataSet ds = new DataSet();
            try
            {
              
                ds = objDAL_ModuleMaster.BindModuleCompany();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet BindModuleList()
        {
            DataSet ds = new DataSet();
            try
            {

                ds = objDAL_ModuleMaster.BindModuleList ();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet BindCompanyModuleList()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_ModuleMaster.Company_ID = Company_ID;
                ds = objDAL_ModuleMaster.BindCompanyModuleList();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

       public DataSet Get_ModuleMapping_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_ModuleMaster.Mapping_ID  = Mapping_ID ;
                ds = objDAL_ModuleMaster.Get_ModuleMapping_Master_Details ();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Get_ModuleMapping_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_ModuleMaster.Module_Name = Module_Name;
                objDAL_ModuleMaster.Company_ID = Company_ID;
                ds = objDAL_ModuleMaster.Get_ModuleMapping_Master_List ();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_ModuleMapping_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_ModuleMaster.Module_ID = Module_ID;
                objDAL_ModuleMaster.Mapping_ID  = Mapping_ID ;
                objDAL_ModuleMaster.Company_ID  = Company_ID ;
                ds = objDAL_ModuleMaster.Delete_ModuleMapping_Master();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Insert_ModuleMapping_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_ModuleMaster.Module_ID = Module_ID;
                objDAL_ModuleMaster.Mapping_ID = Mapping_ID;
                objDAL_ModuleMaster.Company_ID = Company_ID;
                objDAL_ModuleMaster.isActive  = isActive ;
                ds = objDAL_ModuleMaster.Insert_ModuleMapping_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Update_ModuleMapping_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_ModuleMaster.Module_ID = Module_ID;
                objDAL_ModuleMaster.Mapping_ID = Mapping_ID;
                objDAL_ModuleMaster.Company_ID = Company_ID;
                objDAL_ModuleMaster.isActive = isActive;
                ds = objDAL_ModuleMaster.Update_ModuleMapping_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }
    }
}
