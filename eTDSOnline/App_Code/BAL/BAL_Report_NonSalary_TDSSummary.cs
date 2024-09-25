using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;
using System.Data.SqlClient;

namespace BusinessLayer
{
  public  class BAL_Report_NonSalary_TDSSummary
    {
      DAL_Report_NonSalary_TDSSummary objDAL_Tds = new DAL_Report_NonSalary_TDSSummary();

      public DateTime _Challan_Date { get; set; }
      public int _Company_ID { get; set; }
      public string sdate { get; set; }
      public string tdate { get; set; }


      public DataSet gettdssummery()
      {
          DataSet ds = new DataSet();
          try
          {
              objDAL_Tds._Company_ID = _Company_ID;

              objDAL_Tds.sdate = sdate;
              objDAL_Tds.tdate = tdate;

              ds = objDAL_Tds.generatetdsSummery();

          }
          catch (Exception)
          {
              throw;
          }
          return ds;
      }

    }
}
