using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_Rebate_Master
    {
        DAL_Rebate_Master objDAL_RebateMaster = new DAL_Rebate_Master();

        public int _Rebate_ID { get; set; }
        public string _Rebate_Name { get; set; }
        public int _Company_ID { get; set; }
        public string SearchTxt { get; set; }
        public string SearchTxtFld { get; set; }

        public DataSet Get_Rebate_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_RebateMaster._Rebate_ID = _Rebate_ID;
                ds = objDAL_RebateMaster.Get_Rebate_Master_Details();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Get_Rebate_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_RebateMaster._Rebate_Name = _Rebate_Name;
                objDAL_RebateMaster._Company_ID = _Company_ID;
                ds = objDAL_RebateMaster.Get_Rebate_Master_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Rebate_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_RebateMaster._Rebate_ID = _Rebate_ID;
                ds = objDAL_RebateMaster.Delete_Rebate_Master();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Insert_Rebate_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_RebateMaster._Rebate_Name = _Rebate_Name;
                objDAL_RebateMaster._Company_ID = _Company_ID;
                
                ds = objDAL_RebateMaster.Insert_Rebate_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Update_Rebate_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_RebateMaster._Rebate_ID = _Rebate_ID;
                objDAL_RebateMaster._Rebate_Name = _Rebate_Name;
                objDAL_RebateMaster._Company_ID = _Company_ID;

                ds = objDAL_RebateMaster.Update_Rebate_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }
    }
}
