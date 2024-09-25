using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;
using CommonLibrary;

namespace BusinessLayer
{
    public class BAL_Bank_Master
    {
        DAL_Bank_Master objDAL_BankMaster = new DAL_Bank_Master();

        public int _Bank_ID { get; set; }
        public string _compid { get; set; }
        public string _dbname { get; set; }
        public int msg { get; set; }
        public string _Bank_Name { get; set; }
        public string _Bank_Branch { get; set; }
        public string _Bsrcode { get; set; }
        public int _Company_ID { get; set; }
        public string SearchTxt { get; set; }
        public string SearchTxtFld { get; set; }

        public DataSet Get_Bank_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_BankMaster._Bank_ID = _Bank_ID;
                ds = objDAL_BankMaster.Get_Bank_Master_Details();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Get_Bank_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_BankMaster._Bank_Name = _Bank_Name;
                objDAL_BankMaster._Company_ID = _Company_ID;
                ds = objDAL_BankMaster.Get_Bank_Master_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Bank_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_BankMaster._Bank_ID = _Bank_ID;
                objDAL_BankMaster._compid = _compid;
                objDAL_BankMaster._dbname = _dbname;
                ds = objDAL_BankMaster.Delete_Bank_Master();
            }
            catch (Exception ex)
            {

                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Insert_Bank_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_BankMaster._Bank_Name = _Bank_Name;
                objDAL_BankMaster._Bank_Branch = _Bank_Branch;
                objDAL_BankMaster._Bsrcode = _Bsrcode;
                objDAL_BankMaster._Company_ID = _Company_ID;

                ds = objDAL_BankMaster.Insert_Bank_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Update_Bank_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_BankMaster._Bank_ID = _Bank_ID;
                objDAL_BankMaster._Bank_Name = _Bank_Name;
                objDAL_BankMaster._Bank_Branch = _Bank_Branch;
                objDAL_BankMaster._Bsrcode = _Bsrcode;
                objDAL_BankMaster._Company_ID = _Company_ID;

                ds = objDAL_BankMaster.Update_Bank_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        
    }
}
