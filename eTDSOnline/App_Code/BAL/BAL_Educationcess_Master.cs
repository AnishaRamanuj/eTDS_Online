using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_Educationcess_Master
    {
        DAL_Educationcess_Master objDAL_Educationcess_Master = new DAL_Educationcess_Master();

        public int _Educationcess_ID { get; set; }
        public int _Company_ID { get; set; }
        public double _Cess_Percent { get; set; }
        public string _App_Type { get; set; }
        public double _HCess_Percent { get; set; }

        public DataSet Get_Educationcess_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Educationcess_Master._Educationcess_ID = _Educationcess_ID;
                ds = objDAL_Educationcess_Master.Get_Educationcess_Master_Details();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Get_Educationcess_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Educationcess_Master._Company_ID = _Company_ID;
                objDAL_Educationcess_Master._App_Type = _App_Type;
                ds = objDAL_Educationcess_Master.Get_Educationcess_Master_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Educationcess_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Educationcess_Master._Educationcess_ID = _Educationcess_ID;
                ds = objDAL_Educationcess_Master.Delete_Educationcess_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Insert_Educationcess_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Educationcess_Master._Company_ID = _Company_ID;
                objDAL_Educationcess_Master._Cess_Percent = _Cess_Percent;
                objDAL_Educationcess_Master._App_Type = _App_Type;
                objDAL_Educationcess_Master._HCess_Percent = _HCess_Percent;
                
                ds = objDAL_Educationcess_Master.Insert_Educationcess_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Update_Educationcess_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Educationcess_Master._Educationcess_ID = _Educationcess_ID;
                objDAL_Educationcess_Master._Company_ID = _Company_ID;
                objDAL_Educationcess_Master._Cess_Percent = _Cess_Percent;
                objDAL_Educationcess_Master._App_Type = _App_Type;
                objDAL_Educationcess_Master._HCess_Percent = _HCess_Percent;

                ds = objDAL_Educationcess_Master.Update_Educationcess_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }
    }
}
