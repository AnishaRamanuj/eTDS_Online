using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;
using System.Data;

namespace BusinessLayer
{
    public class BAL_ReportForm3CD
    {
        DAL_ReportForm3CD obj = new DAL_ReportForm3CD();

        public int Company_Id { get; set; }

        public DataSet BAL_GetForm3CD()
        {
            try
            {
                obj.Company_Id = Company_Id;
                DataSet ds = obj.DAL_GetForm3CD();
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
