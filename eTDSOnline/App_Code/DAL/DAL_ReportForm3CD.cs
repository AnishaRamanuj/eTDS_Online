using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Microsoft.ApplicationBlocks1.Data;
using System.Data.SqlClient;
using System.Reflection;
using System.Diagnostics;
using System.Globalization;
namespace DataLayer
{
    public class DAL_ReportForm3CD : DALCommon
    {
        public int Company_Id { get; set; }
        CultureInfo ci = new CultureInfo("en-GB");
        public DataSet DAL_GetForm3CD()
        {
            try
            {

                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Company_Id", Company_Id);
                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetReportForm3cd", param);

                return ds;


            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataTable ToDataTable<T>(List<T> items)
        {
            DataTable dataTable = new DataTable(typeof(T).Name);

            //Get all the properties
            PropertyInfo[] Props = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);
            foreach (PropertyInfo prop in Props)
            {
                //Setting column names as Property names
                dataTable.Columns.Add(prop.Name);
            }
            foreach (T item in items)
            {
                var values = new object[Props.Length];
                for (int i = 0; i < Props.Length; i++)
                {
                    //inserting property values to datatable rows
                    values[i] = Props[i].GetValue(item, null);
                }
                dataTable.Rows.Add(values);
            }
            //put a breakpoint here and check datatable
            return dataTable;
        }

    }

    public class Form3CDResultData
    {
        public string PayeeName { get; set; }

        public string Dateofitdeducted { get; set; }

        public string DueDate { get; set; }

        public string paidon { get; set; }

        public double amtpd1 { get; set; }

        public double Amtpd { get; set; }

        public string Lateby { get; set; }
    }
}
