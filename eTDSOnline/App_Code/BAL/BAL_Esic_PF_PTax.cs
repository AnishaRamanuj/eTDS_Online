using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_Esic_PF_PTax
    {
        DAL_Esic_PF_PTax objDAL_Esic_PF_PTax = new DAL_Esic_PF_PTax();

        public int _Esic_ID { get; set; }
        public int _Company_ID { get; set; }
        public string _Esic_Percentage { get; set; }
        public ulong _Esic_Limit { get; set; }

        public int _Employee_ID { get; set; }
        public int _Head_ID { get; set; }
        public double _Amount { get; set; }
        public double _Percentage { get; set; }

        public DataSet Get_Esic_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Esic_PF_PTax._Esic_ID = _Esic_ID;
                objDAL_Esic_PF_PTax._Company_ID = _Company_ID;
                ds = objDAL_Esic_PF_PTax.Get_Esic_List();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Get_DeductionAmount()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Esic_PF_PTax._Employee_ID = _Employee_ID;
                objDAL_Esic_PF_PTax._Head_ID = _Head_ID;
                objDAL_Esic_PF_PTax._Percentage = _Percentage;
                objDAL_Esic_PF_PTax._Amount = _Amount;
                objDAL_Esic_PF_PTax._Company_ID = _Company_ID; 
                ds = objDAL_Esic_PF_PTax.Get_DeductionAmount();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }
    }
}
