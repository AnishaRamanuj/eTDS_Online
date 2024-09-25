using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_Percentage_Master
    {
        DAL_Percentage_Master objDAL_Percentage_Master = new DAL_Percentage_Master();

        public int _Percentage_ID { get; set; }
        public int _Head_ID { get; set; }
        public int _CHead_ID { get; set; }
        public double _Percent_Val { get; set; }
        public int _Company_ID { get; set; }
        public int _State_ID { get; set; }

        public DataSet Get_Percentage_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Percentage_Master._Percentage_ID = _Percentage_ID;
                ds = objDAL_Percentage_Master.Get_Percentage_Master_Details();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Head_ID()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Percentage_Master._Head_ID = _Head_ID;
                objDAL_Percentage_Master._CHead_ID = _CHead_ID;
                objDAL_Percentage_Master._Company_ID = _Company_ID;
                ds = objDAL_Percentage_Master.Get_Head_ID();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Percentage_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Percentage_Master._Head_ID = _Head_ID;
                objDAL_Percentage_Master._Company_ID = _Company_ID;
                objDAL_Percentage_Master._State_ID = _State_ID;
                
                ds = objDAL_Percentage_Master.Get_Percentage_Master_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Percentage_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Percentage_Master._Percentage_ID = _Percentage_ID;
                ds = objDAL_Percentage_Master.Delete_Percentage_Master();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Percentage_Master_By_Head_ID()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Percentage_Master._Head_ID = _Head_ID;
                ds = objDAL_Percentage_Master.Delete_Percentage_Master_By_Head_ID();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Percentage_Master_By_State_ID()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Percentage_Master._State_ID = _State_ID;
                objDAL_Percentage_Master._Head_ID = _Head_ID;
                objDAL_Percentage_Master._Company_ID = _Company_ID;
                ds = objDAL_Percentage_Master.Delete_Percentage_Master_By_State_ID();
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
                objDAL_Percentage_Master._Head_ID = _Head_ID;
                objDAL_Percentage_Master._Company_ID = _Company_ID;
                objDAL_Percentage_Master._Percent_Val = _Percent_Val;
                objDAL_Percentage_Master._State_ID = _State_ID;

                ds = objDAL_Percentage_Master.Insert_Percentage_Master();
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
                objDAL_Percentage_Master._Percentage_ID = _Percentage_ID;
                objDAL_Percentage_Master._Head_ID = _Head_ID;
                objDAL_Percentage_Master._Company_ID = _Company_ID;
                objDAL_Percentage_Master._Percent_Val = _Percent_Val;
                objDAL_Percentage_Master._State_ID = _State_ID;

                ds = objDAL_Percentage_Master.Update_Percentage_Master();

            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }
    }
}
