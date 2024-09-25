using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_Percentage_Breakup_Master
    {
        DAL_Percentage_Breakup_Master objDAL_Percentage_Breakup_Master = new DAL_Percentage_Breakup_Master();

        public int _Percent_Brk_ID { get; set; }
        public int _Percentage_ID { get; set; }
        public int _Head_ID { get; set; }
        public int _Company_ID { get; set; }
        public int _Calculation_Head_ID { get; set; }
        public int _State_ID { get; set; }

        public string _Head_IDs { get; set; }

        public DataSet Get_Percentage_Breakup_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Percentage_Breakup_Master._Percent_Brk_ID = _Percent_Brk_ID;
                ds = objDAL_Percentage_Breakup_Master.Get_Percentage_Breakup_Master_Details();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Percentage_Breakup_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Percentage_Breakup_Master._Calculation_Head_ID = _Calculation_Head_ID;
                objDAL_Percentage_Breakup_Master._Company_ID = _Company_ID;
                objDAL_Percentage_Breakup_Master._State_ID = _State_ID;

                ds = objDAL_Percentage_Breakup_Master.Get_Percentage_Breakup_Master_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Percentage_Breakup_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Percentage_Breakup_Master._Percent_Brk_ID = _Percent_Brk_ID;
                ds = objDAL_Percentage_Breakup_Master.Delete_Percentage_Breakup_Master();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Percentage_Breakup_Master_By_HeadID()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Percentage_Breakup_Master._Head_ID = _Head_ID;
                ds = objDAL_Percentage_Breakup_Master.Delete_Percentage_Breakup_Master_By_HeadID();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Percentage_Breakup_Master_By_Percentage_ID()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Percentage_Breakup_Master._Percentage_ID = _Percentage_ID;
                ds = objDAL_Percentage_Breakup_Master.Delete_Percentage_Breakup_Master_By_Percentage_ID();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Insert_Update_Percentage_Breakup_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Percentage_Breakup_Master._Percentage_ID = _Percentage_ID;
                objDAL_Percentage_Breakup_Master._Head_IDs = _Head_IDs;
                objDAL_Percentage_Breakup_Master._Company_ID = _Company_ID;
                objDAL_Percentage_Breakup_Master._Calculation_Head_ID = _Calculation_Head_ID;
                //objDAL_Percentage_Breakup_Master._State_ID = _State_ID;

                ds = objDAL_Percentage_Breakup_Master.Insert_Update_Percentage_Breakup_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Insert_Percentage_Breakup_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Percentage_Breakup_Master._Percentage_ID = _Percentage_ID;
                objDAL_Percentage_Breakup_Master._Head_ID = _Head_ID;
                objDAL_Percentage_Breakup_Master._Company_ID = _Company_ID;
                objDAL_Percentage_Breakup_Master._Calculation_Head_ID = _Calculation_Head_ID;
                //objDAL_Percentage_Breakup_Master._State_ID = _State_ID;

                ds = objDAL_Percentage_Breakup_Master.Insert_Percentage_Breakup_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Update_Percentage_Breakup_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Percentage_Breakup_Master._Percent_Brk_ID = _Percent_Brk_ID;
                objDAL_Percentage_Breakup_Master._Percentage_ID = _Percentage_ID;
                objDAL_Percentage_Breakup_Master._Head_ID = _Head_ID;
                objDAL_Percentage_Breakup_Master._Company_ID = _Company_ID;
                objDAL_Percentage_Breakup_Master._Calculation_Head_ID = _Calculation_Head_ID;
                //objDAL_Percentage_Breakup_Master._State_ID = _State_ID;

                ds = objDAL_Percentage_Breakup_Master.Update_Percentage_Breakup_Master();

            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }
    }
}
