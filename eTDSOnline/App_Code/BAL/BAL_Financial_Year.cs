using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_Financial_Year
    {
        DAL_Financial_Year objDAL_Financial_Year = new DAL_Financial_Year();

        public int _Financial_Year_ID { get; set; }
        public string _Financial_Year { get; set; }
        public int _From_Year { get; set; }
        public int _To_Year { get; set; }
        public DateTime _Financial_From_Date { get; set; }
        public DateTime _Financial_To_Date { get; set; }
        public string _DB_User_ID { get; set; }
        public string _DB_Password { get; set; }
        public string _DB_Database { get; set; }
        public string _DB_Server { get; set; }
        public int _Is_Current_Year { get; set; }
        public string _DB_Connection_String { get; set; }

        public DataSet Get_Financial_Year_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Financial_Year._Financial_Year_ID = _Financial_Year_ID;
                ds = objDAL_Financial_Year.Get_Financial_Year_Details();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Get_Financial_Year_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Financial_Year._Is_Current_Year = _Is_Current_Year;
                ds = objDAL_Financial_Year.Get_Financial_Year_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Insert_Financial_Year()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Financial_Year._Financial_Year = _Financial_Year;
                objDAL_Financial_Year._From_Year = _From_Year;
                objDAL_Financial_Year._To_Year = _To_Year;
                objDAL_Financial_Year._Financial_From_Date = _Financial_From_Date;
                objDAL_Financial_Year._Financial_To_Date = _Financial_To_Date;
                objDAL_Financial_Year._DB_User_ID = _DB_User_ID;
                objDAL_Financial_Year._DB_Password = _DB_Password;
                objDAL_Financial_Year._DB_Database = _DB_Database;
                objDAL_Financial_Year._DB_Server = _DB_Server;

                ds = objDAL_Financial_Year.Insert_Financial_Year();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }


        public DataSet BAL_BindFinancialYearCombos()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Financial_Year.Company_ID = Company_ID;
                ds = objDAL_Financial_Year.DAL_BindFinancialYearCombos();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public int Company_ID { get; set; }
    }
}
