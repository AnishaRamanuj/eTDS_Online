using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_Perquisites
    {
        DAL_Perquisites objDAL_Perquisites = new DAL_Perquisites();

        public int _Perq_ID { get; set; }
        public int _Perquisites_ID { get; set; }
        public string _Perquisites_Name { get; set; }
        public double _Perquisites_Value { get; set; }
        public double _EmployeePaid_Amt { get; set; }
        public double _Taxable_Amt { get; set; }
        public int _Employee_ID { get; set; }
        public int _Company_ID { get; set; }

        public DataSet Get_Perquisites_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Perquisites._Perq_ID = _Perq_ID;
                ds = objDAL_Perquisites.Get_Perquisites_Details();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Perquisites_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Perquisites._Employee_ID = _Employee_ID;
                objDAL_Perquisites._Company_ID = _Company_ID;
                objDAL_Perquisites._Perquisites_ID = _Perquisites_ID;
                ds = objDAL_Perquisites.Get_Perquisites_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Update_Perquisites()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Perquisites._Perq_ID = _Perq_ID;
                //objDAL_Perquisites._Perquisites_ID = _Perquisites_ID;
                //objDAL_Perquisites._Perquisites_Name = _Perquisites_Name;
                objDAL_Perquisites._Perquisites_Value = _Perquisites_Value;
                objDAL_Perquisites._EmployeePaid_Amt = _EmployeePaid_Amt;
                objDAL_Perquisites._Taxable_Amt = _Taxable_Amt;
                //objDAL_Perquisites._Employee_ID = _Employee_ID;
                //objDAL_Perquisites._Company_ID = _Company_ID;
                
                ds = objDAL_Perquisites.Update_Perquisites();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }
    }
}
