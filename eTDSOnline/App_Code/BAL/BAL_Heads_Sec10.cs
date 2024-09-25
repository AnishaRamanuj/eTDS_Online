using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_Heads_Sec10
    {
        DAL_Heads_Sec10 objDAL_Heads_Sec10 = new DAL_Heads_Sec10();

        public string _Head_IDs { get; set; }
        public int _Company_ID { get; set; }
        public string _Head_Group { get; set; }
        public int _Head_Calculated_ID { get; set; }
        public string _Calc_Gross { get; set; }

        public DataSet Get_Head_Master_List()
        {
            DataSet dsHead = new DataSet();
            try
            {
                objDAL_Heads_Sec10._Head_Group = _Head_Group;
                objDAL_Heads_Sec10._Company_ID = _Company_ID;
                objDAL_Heads_Sec10._Head_Calculated_ID = _Head_Calculated_ID;
                objDAL_Heads_Sec10._Calc_Gross = _Calc_Gross;

                dsHead = objDAL_Heads_Sec10.Get_Head_Master_List();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return dsHead;
        }

        public DataSet Get_Head_Master_with_Sec10()
        {
            DataSet dsHead = new DataSet();
            try
            {
                objDAL_Heads_Sec10._Company_ID = _Company_ID;
                dsHead = objDAL_Heads_Sec10.Get_Head_Master_with_Sec10();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return dsHead;
        }

        public DataSet Update_Heads_Sec10()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Heads_Sec10._Head_IDs = _Head_IDs;
                objDAL_Heads_Sec10._Company_ID = _Company_ID;

                ds = objDAL_Heads_Sec10.Update_Heads_Sec10();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }
    }
}
