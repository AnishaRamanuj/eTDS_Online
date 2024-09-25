using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_Surcharge_Master
    {
        DAL_Surcharge_Master objDAL_Surcharge_Master = new DAL_Surcharge_Master();

        public int _Surcharge_ID { get; set; }
        public int _Company_ID { get; set; }
        public double _Surcharge_Percent { get; set; }
        public string _App_Type { get; set; }

        public DataSet Get_Surcharge_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Surcharge_Master._Surcharge_ID = _Surcharge_ID;
                ds = objDAL_Surcharge_Master.Get_Surcharge_Master_Details();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Get_Surcharge_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Surcharge_Master._Company_ID = _Company_ID;
                objDAL_Surcharge_Master._App_Type = _App_Type;
                ds = objDAL_Surcharge_Master.Get_Surcharge_Master_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Surcharge_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Surcharge_Master._Surcharge_ID = _Surcharge_ID;
                ds = objDAL_Surcharge_Master.Delete_Surcharge_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Insert_Surcharge_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Surcharge_Master._Company_ID = _Company_ID;
                objDAL_Surcharge_Master._Surcharge_Percent = _Surcharge_Percent;
                objDAL_Surcharge_Master._App_Type = _App_Type;

                ds = objDAL_Surcharge_Master.Insert_Surcharge_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Update_Surcharge_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Surcharge_Master._Surcharge_ID = _Surcharge_ID;
                objDAL_Surcharge_Master._Company_ID = _Company_ID;
                objDAL_Surcharge_Master._Surcharge_Percent = _Surcharge_Percent;
                objDAL_Surcharge_Master._App_Type = _App_Type;

                ds = objDAL_Surcharge_Master.Update_Surcharge_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet BAL_GetSurchargedetails()
        {
            objDAL_Surcharge_Master._Company_ID = _Company_ID;
            objDAL_Surcharge_Master._App_Type = _App_Type;
            DataSet ds = objDAL_Surcharge_Master.DAL_GetSurchargedetails();
            return ds;
        }

        public DataSet BAL_GetSurchargedetailsnew()
        {
            objDAL_Surcharge_Master._Company_ID = _Company_ID;
            DataSet ds = objDAL_Surcharge_Master.DAL_GetSurchargedetailsnew();
            return ds;
        }

        public string _SurchargeType { get; set; }

        public int BAL_SaveSurchargedetails()
        {
            objDAL_Surcharge_Master._Company_ID = _Company_ID;
            objDAL_Surcharge_Master._App_Type = _App_Type;
            objDAL_Surcharge_Master._Surcharge_Percent = _Surcharge_Percent;
            objDAL_Surcharge_Master._SurchargeType = _SurchargeType;
            return objDAL_Surcharge_Master.DAL_SaveSurchargedetails();
        }
    }
}
