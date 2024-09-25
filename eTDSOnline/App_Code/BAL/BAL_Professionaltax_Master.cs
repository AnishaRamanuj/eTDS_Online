using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_Professionaltax_Master
    {
        DAL_Professionaltax_Master objDAL_Professionaltax_Master = new DAL_Professionaltax_Master();

        public int _Professionaltax_ID { get; set; }
        public int _State_ID { get; set; }
        public int _Company_ID { get; set; }
        public double _From_Tax_Amount { get; set; }
        public double _To_Tax_Amount { get; set; }
        public double _Slab { get; set; }
        public int _CHead_ID { get; set; }


        public DataSet Get_Professionaltax_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Professionaltax_Master._Professionaltax_ID = _Professionaltax_ID;
                ds = objDAL_Professionaltax_Master.Get_Professionaltax_Master_Details();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }


        public DataSet Get_Professionaltax_HeadID()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Professionaltax_Master._Professionaltax_ID = _CHead_ID;
                objDAL_Professionaltax_Master._Company_ID = _Company_ID;
                ds = objDAL_Professionaltax_Master.Get_Professionaltax_HeadID();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Professionaltax_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Professionaltax_Master._State_ID = _State_ID;
                objDAL_Professionaltax_Master._Company_ID = _Company_ID;

                ds = objDAL_Professionaltax_Master.Get_Professionaltax_Master_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }


        public DataSet Get_Professionaltax_Heads()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Professionaltax_Master._State_ID = _State_ID;
                objDAL_Professionaltax_Master._Company_ID = _Company_ID;

                ds = objDAL_Professionaltax_Master.Get_Professionaltax_Heads();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }


        public DataSet Delete_Professionaltax_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Professionaltax_Master._Professionaltax_ID = _Professionaltax_ID;
                ds = objDAL_Professionaltax_Master.Delete_Professionaltax_Master();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Professionaltax_Master_By_StateID()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Professionaltax_Master._State_ID = _State_ID;
                objDAL_Professionaltax_Master._Company_ID = _Company_ID;
                ds = objDAL_Professionaltax_Master.Delete_Professionaltax_Master_By_StateID();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }



        public DataSet Insert_Professionaltax_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Professionaltax_Master._State_ID = _State_ID;
                objDAL_Professionaltax_Master._Company_ID = _Company_ID;
                objDAL_Professionaltax_Master._From_Tax_Amount = _From_Tax_Amount;
                objDAL_Professionaltax_Master._To_Tax_Amount = _To_Tax_Amount;
                objDAL_Professionaltax_Master._Slab = _Slab;

                ds = objDAL_Professionaltax_Master.Insert_Professionaltax_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Update_Professionaltax_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Professionaltax_Master._Professionaltax_ID = _Professionaltax_ID;
                objDAL_Professionaltax_Master._State_ID = _State_ID;
                objDAL_Professionaltax_Master._Company_ID = _Company_ID;
                objDAL_Professionaltax_Master._From_Tax_Amount = _From_Tax_Amount;
                objDAL_Professionaltax_Master._To_Tax_Amount = _To_Tax_Amount;

                ds = objDAL_Professionaltax_Master.Update_Professionaltax_Master();

            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }
    }
}
