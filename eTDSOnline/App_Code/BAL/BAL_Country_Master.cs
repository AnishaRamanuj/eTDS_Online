using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_Country_Master
    {
        DAL_Country_Master objDAL_Country_Master = new DAL_Country_Master();

        public int _Country_ID { get; set; }
        public string _Country_Name { get; set; }

        public DataSet Get_Country_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = objDAL_Country_Master.Get_Country_Master_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }
    }
}
