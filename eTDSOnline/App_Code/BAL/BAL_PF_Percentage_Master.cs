using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_PF_Percentage_Master
    {
        DAL_PF_Percentage_Master objDAL_PF_Percentage_Master = new DAL_PF_Percentage_Master();

        public int _Percentage_ID { get; set; }
        public int _Head_ID { get; set; }
        public string _Head_IDs { get; set; }
        public int _CHead_ID { get; set; }
        public double _Percent_Val { get; set; }
        public int _Company_ID { get; set; }
        public int _State_ID { get; set; }
        public string _Head_Group { get; set; }
        public int _Head_Calculated_ID { get; set; }
        public int _Calculation_Head_ID { get; set; }
        public string _Calc_Gross { get; set; }

        public double _PF_Percentage { get; set; }
        public double _PF_Limit { get; set; }

        public DataSet Get_Head_Master_List()
        {
            DataSet dsHead = new DataSet();
            try
            {
                objDAL_PF_Percentage_Master._Head_Group = _Head_Group;
                objDAL_PF_Percentage_Master._Company_ID = _Company_ID;
                objDAL_PF_Percentage_Master._Head_Calculated_ID = _Head_Calculated_ID;
                objDAL_PF_Percentage_Master._Calc_Gross = _Calc_Gross;

                dsHead = objDAL_PF_Percentage_Master.Get_Head_Master_List();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return dsHead;
        }

        public DataSet Get_Percentage_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_PF_Percentage_Master._Head_ID = _Head_ID;
                objDAL_PF_Percentage_Master._Company_ID = _Company_ID;
                objDAL_PF_Percentage_Master._State_ID = _State_ID;

                ds = objDAL_PF_Percentage_Master.Get_Percentage_Master_List();
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
                objDAL_PF_Percentage_Master._Calculation_Head_ID = _Calculation_Head_ID;
                objDAL_PF_Percentage_Master._Company_ID = _Company_ID;
                objDAL_PF_Percentage_Master._State_ID = _State_ID;

                ds = objDAL_PF_Percentage_Master.Get_Percentage_Breakup_Master_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Insert_Percentage_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_PF_Percentage_Master._Head_ID = _Head_ID;
                objDAL_PF_Percentage_Master._Company_ID = _Company_ID;
                objDAL_PF_Percentage_Master._Percent_Val = _Percent_Val;
                objDAL_PF_Percentage_Master._State_ID = _State_ID;

                ds = objDAL_PF_Percentage_Master.Insert_Percentage_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Update_Percentage_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_PF_Percentage_Master._Percentage_ID = _Percentage_ID;
                objDAL_PF_Percentage_Master._Head_ID = _Head_ID;
                objDAL_PF_Percentage_Master._Company_ID = _Company_ID;
                objDAL_PF_Percentage_Master._Percent_Val = _Percent_Val;
                objDAL_PF_Percentage_Master._State_ID = _State_ID;

                ds = objDAL_PF_Percentage_Master.Update_Percentage_Master();

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
                objDAL_PF_Percentage_Master._Percentage_ID = _Percentage_ID;
                objDAL_PF_Percentage_Master._Head_IDs = _Head_IDs;
                objDAL_PF_Percentage_Master._Company_ID = _Company_ID;
                objDAL_PF_Percentage_Master._Calculation_Head_ID = _Calculation_Head_ID;
                //objDAL_Percentage_Breakup_Master._State_ID = _State_ID;

                ds = objDAL_PF_Percentage_Master.Insert_Update_Percentage_Breakup_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Get_Providend_Fund_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_PF_Percentage_Master._Company_ID = _Company_ID;
                ds = objDAL_PF_Percentage_Master.Get_Providend_Fund_Details();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Insert_Update_Providend_Fund()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_PF_Percentage_Master._Company_ID = _Company_ID;
                objDAL_PF_Percentage_Master._PF_Percentage = _PF_Percentage;
                objDAL_PF_Percentage_Master._PF_Limit = _PF_Limit;

                ds = objDAL_PF_Percentage_Master.Insert_Update_Providend_Fund();

            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }
    }
}
