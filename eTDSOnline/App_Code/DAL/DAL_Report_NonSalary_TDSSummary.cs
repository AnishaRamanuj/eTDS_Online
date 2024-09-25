using System;
using System.Collections.Generic;

using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;


namespace DataLayer
{
    public class DAL_Report_NonSalary_TDSSummary : DALCommon
    {
        public DateTime _Challan_Date { get; set; }
        public int _Company_ID { get; set; }
        public string sdate { get; set; }
        public string tdate { get; set; }


        public DataSet generatetdsSummery()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[3];
                objSqlParameter[0] = new SqlParameter("@compid", _Company_ID);

                objSqlParameter[1] = new SqlParameter("@startdate", sdate);
                objSqlParameter[2] = new SqlParameter("@enddate", tdate);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_getsectionwisevoucher", objSqlParameter);
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }
    }
}
