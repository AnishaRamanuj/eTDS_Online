using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_HRA_Rent_Receipt
    {
        DAL_HRA_Rent_Receipt objDAL_HRA_Rent_Receipt = new DAL_HRA_Rent_Receipt();

        public int _HRA_Rent_Receipt_ID { get; set; }
        public int _Employee_ID { get; set; }
        public int _Month_No { get; set; }
        public string _Month_Name { get; set; }
        public double _Amount { get; set; }
        public int _Company_ID { get; set; }

        public DataSet Get_HRA_Rent_Receipt_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_HRA_Rent_Receipt._HRA_Rent_Receipt_ID = _HRA_Rent_Receipt_ID;
                ds = objDAL_HRA_Rent_Receipt.Get_HRA_Rent_Receipt_Details();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Get_HRA_Rent_Receipt_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_HRA_Rent_Receipt._Company_ID = _Company_ID;
                objDAL_HRA_Rent_Receipt._Employee_ID = _Employee_ID;
                objDAL_HRA_Rent_Receipt._Month_Name = _Month_Name;
                objDAL_HRA_Rent_Receipt._Month_No = _Month_No;

                ds = objDAL_HRA_Rent_Receipt.Get_HRA_Rent_Receipt_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_HRA_Rent_Receipt()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_HRA_Rent_Receipt._HRA_Rent_Receipt_ID = _HRA_Rent_Receipt_ID;
                ds = objDAL_HRA_Rent_Receipt.Delete_HRA_Rent_Receipt();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Insert_HRA_Rent_Receipt()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_HRA_Rent_Receipt._Company_ID = _Company_ID;
                objDAL_HRA_Rent_Receipt._Employee_ID = _Employee_ID;
                objDAL_HRA_Rent_Receipt._Month_No = _Month_No;
                objDAL_HRA_Rent_Receipt._Month_Name = _Month_Name;
                objDAL_HRA_Rent_Receipt._Amount = _Amount;
                
                ds = objDAL_HRA_Rent_Receipt.Insert_HRA_Rent_Receipt();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Update_HRA_Rent_Receipt()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_HRA_Rent_Receipt._HRA_Rent_Receipt_ID = _HRA_Rent_Receipt_ID;
                objDAL_HRA_Rent_Receipt._Company_ID = _Company_ID;
                objDAL_HRA_Rent_Receipt._Employee_ID = _Employee_ID;
                objDAL_HRA_Rent_Receipt._Month_No = _Month_No;
                objDAL_HRA_Rent_Receipt._Month_Name = _Month_Name;
                objDAL_HRA_Rent_Receipt._Amount = _Amount;

                ds = objDAL_HRA_Rent_Receipt.Update_HRA_Rent_Receipt();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Get_ProfesstionalTax_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_HRA_Rent_Receipt._Company_ID = _Company_ID;
                objDAL_HRA_Rent_Receipt._Employee_ID = _Employee_ID;

                ds = objDAL_HRA_Rent_Receipt.Get_Professtionatax();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Update_Professtional_Tax_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_HRA_Rent_Receipt._Company_ID = _Company_ID;
                objDAL_HRA_Rent_Receipt._Employee_ID = _Employee_ID;
                objDAL_HRA_Rent_Receipt._Month_No = _Month_No;
                objDAL_HRA_Rent_Receipt._Amount = _Amount;

                ds = objDAL_HRA_Rent_Receipt.DAL_Update_ProfesstionalTax();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }
    }
}
