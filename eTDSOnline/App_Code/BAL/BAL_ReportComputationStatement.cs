using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;
using System.Data;

namespace BusinessLayer
{
    public class BAL_ReportComputationStatement
    {
        DAL_ReportComputationStatement obj = new DAL_ReportComputationStatement();

        public int Company_ID { get; set; }

        public DataSet BAL_GetReportComputationStatement()
        {
            try
            {
                obj.Company_ID=Company_ID;
                DataSet ds = obj.DAL_GetReportComputationStatement();
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            
        }
    }
}
