using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web;
using Microsoft.ApplicationBlocks1.Data;


namespace DataLayer
{
    public class DALCommon
    {
        public DALCommon()
        {
           _cnnString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
            //_cnnString2 = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringDBePay_14_15"].ToString();
        }
        //Declare all your variables here 
        public string cnnstring = "";
        public string cnnstring2 = "";
        public string dbname = "";
        //variables declared above will be set into property in your each class. 
        public string _cnnString
        {
            get { return cnnstring; }
            set { cnnstring = value; }
        }

        public string _cnnString2
        {
            // get { return cnnstring2; }
            get { return this.Connection_String_2(); }
            set { cnnstring2 = value; }
        }

        public string _dbname
        {
            // get { return _dbname; }
            get { return this.Connection_String_2(); }
            set { dbname = value; }
        }

        public SqlConnection openConnection()
        {
            SqlConnection cnn = new SqlConnection();
            try
            {
                _cnnString = ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
                cnn.ConnectionString = _cnnString;
                cnn.Open();
            }
            catch (Exception ex)
            {
                if (cnn.State == ConnectionState.Open)
                    cnn.Close();
                throw ex;
            }
            return cnn;
        }

        public string Connection_String_2()
        {
            string returnConString = "eTDS16_17";
            try
            {
                if (HttpContext.Current.Session["Financial_Year_Text"] != null)
                {
                    string FinancialYearText = (string)HttpContext.Current.Session["Financial_Year_Text"];
                    switch (FinancialYearText)
                    {
                        case "2015_16":
                            returnConString = "eTDS15_16"; break;
                        case "2016_17":
                            returnConString = "eTDS16_17"; break;
                        case "2017_18":
                            returnConString = "eTDS17_18"; break;
                        case "2018_19":
                            returnConString = "eTDS18_19"; break;
                        case "2019_20":
                            returnConString = "eTDS19_20"; break;
                        case "2020_21":
                            returnConString = "eTDS20_21"; break;
                        case "2021_22":
                            returnConString = "eTDS21_22"; break;
                        case "2022_23":
                            returnConString = "eTDS22_23"; break;
                        case "2023_24":
                            returnConString = "eTDS23_24"; break;
                        case "2024_25":
                            returnConString = "eTDS24_25"; break;
                        default:
                            returnConString = "eTDS24_25"; break;

                    }
                }

                dbname = returnConString;
               returnConString = "Data Source=PCORE-LP-016\\MSSQLSERVER01;Integrated Security=true;MultipleActiveResultSets=true;Connect Timeout=30;" + "Database=" + returnConString;
               //returnConString = "User ID=tds;password=hn@#sa$%#rS$(9^j; Min Pool Size=20; Max Pool Size=1000; Database=" + returnConString + ";Server=49.50.86.154;";
              //returnConString = "User ID=sa;password=indmxabeais; Min Pool Size=20; Max Pool Size=1000; Database=" + returnConString + ";Server=DESKTOP-9492QVB\\SQL2019";

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return returnConString;
        }

        //For Traces Connectivity
        public string Connection_String_Traces(string FinancialYearText)
        {
            string returnConString = string.Empty;
            try
            {
                returnConString = Connection_String_2();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return returnConString;
        }

        //For Traces Connectivity
        public void closeConnection(SqlConnection cnn)
        {
            if (cnn.State == ConnectionState.Open)
                cnn.Close();
            cnn.Dispose();
        }

        public SqlConnection openConnection2()
        {
            SqlConnection cnn2 = new SqlConnection();
            try
            {
                _cnnString2 = ConfigurationManager.ConnectionStrings["ConnectionStringDBePay_14_15"].ToString();
                cnn2.ConnectionString = _cnnString2;
                cnn2.Open();
            }
            catch (Exception ex)
            {
                if (cnn2.State == ConnectionState.Open)
                    cnn2.Close();
                throw ex;
            }
            return cnn2;
        }

        public void closeConnection2(SqlConnection cnn2)
        {
            if (cnn2.State == ConnectionState.Open)
                cnn2.Close();
            cnn2.Dispose();
        }
    }
}
