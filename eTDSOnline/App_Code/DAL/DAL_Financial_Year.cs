using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_Financial_Year : DALCommon
    {
        public int _Financial_Year_ID { get; set; }
        public int Company_ID { get; set; }
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
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Financial_Year_ID", _Financial_Year_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Financial_Year_Details", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Get_Financial_Year_List()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Is_Current_Year", _Is_Current_Year);
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Financial_Year_List", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Insert_Financial_Year()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[9];

                objSqlParameter[0] = new SqlParameter("@Financial_Year", _Financial_Year);
                objSqlParameter[1] = new SqlParameter("@From_Year", _From_Year);
                objSqlParameter[2] = new SqlParameter("@To_Year", _To_Year);
                objSqlParameter[3] = new SqlParameter("@Financial_From_Date", _Financial_From_Date);
                objSqlParameter[4] = new SqlParameter("@Financial_To_Date", _Financial_To_Date);
                objSqlParameter[5] = new SqlParameter("@DB_User_ID", _DB_User_ID);
                objSqlParameter[6] = new SqlParameter("@DB_Password", _DB_Password);
                objSqlParameter[7] = new SqlParameter("@DB_Database", _DB_Database);
                objSqlParameter[8] = new SqlParameter("@DB_Server", _DB_Server);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Insert_Financial_Year", objSqlParameter);
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet DAL_BindFinancialYearCombos()
        {
            SqlParameter[] objSqlParameter = new SqlParameter[1];
            objSqlParameter[0] = new SqlParameter("@companyid", Company_ID);
            DataSet ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "bindddlfinacial_year", objSqlParameter);
            return ds;
        }
    }
}
