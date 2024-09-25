using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_Section_10
    {
        DAL_Section_10 objDAL_Section_10 = new DAL_Section_10();

        public int _Employee_ID { get; set; }
        public int _Company_ID { get; set; }
        public int _Head_ID { get; set; }
        public double _Amount { get; set; }

        public DataSet Get_Section_10_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Section_10._Employee_ID = _Employee_ID;
                objDAL_Section_10._Company_ID = _Company_ID;
                objDAL_Section_10._Head_ID = _Head_ID;
                ds = objDAL_Section_10.Get_Section_10_List();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Insert_Section_10()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Section_10._Employee_ID = _Employee_ID;
                objDAL_Section_10._Company_ID = _Company_ID;
                objDAL_Section_10._Head_ID = _Head_ID;
                objDAL_Section_10._Amount = _Amount;
                ds = objDAL_Section_10.Insert_Section_10();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Delete_Section_10()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Section_10._Employee_ID = _Employee_ID;
                ds = objDAL_Section_10.Delete_Section_10();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }
    }
}
