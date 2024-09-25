using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_Incometax_Master
    {
        DAL_Incometax_Master objDAL_Incometax_Master = new DAL_Incometax_Master();

        public int _Incometax_ID { get; set; }
        public string _Gender { get; set; }
        public double _Tax_Amount { get; set; }
        public double _Slab { get; set; }
        public string _SlabTitle { get; set; }

        public string SearchTxt { get; set; }
        public string SearchTxtFld { get; set; }

        public DataSet Get_Incometax_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Incometax_Master._Incometax_ID = _Incometax_ID;
                ds = objDAL_Incometax_Master.Get_Incometax_Master_Details();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Get_Incometax_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = objDAL_Incometax_Master.Get_Incometax_Master_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Incometax_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Incometax_Master._Incometax_ID = _Incometax_ID;
                ds = objDAL_Incometax_Master.Delete_Incometax_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Insert_Incometax_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Incometax_Master._Gender = _Gender;
                objDAL_Incometax_Master._Tax_Amount = _Tax_Amount;
                objDAL_Incometax_Master._Slab = _Slab;
                objDAL_Incometax_Master._SlabTitle = _SlabTitle;
                
                ds = objDAL_Incometax_Master.Insert_Incometax_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Update_Incometax_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Incometax_Master._Incometax_ID = _Incometax_ID;
                objDAL_Incometax_Master._Gender = _Gender;
                objDAL_Incometax_Master._Tax_Amount = _Tax_Amount;
                objDAL_Incometax_Master._Slab = _Slab;
                objDAL_Incometax_Master._SlabTitle = _SlabTitle;

                ds = objDAL_Incometax_Master.Update_Incometax_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }
    }
}
