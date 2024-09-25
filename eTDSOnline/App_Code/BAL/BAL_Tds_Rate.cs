using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_Tds_Rate
    {
        DAL_Tds_Rate objDAL_Tds_Nature  = new DAL_Tds_Rate();

        public int _TdsRate_ID { get; set; }
        public int _Nature_ID { get; set; }
        public string _Nature_Sub_ID { get; set; }
        public string _Section { get; set; }
        public double _TDS { get; set; }
        public double _Surcharge { get; set; }
        public string _Nature_Type { get; set; }
        public string _Cnn { get; set; }

        public DataSet Get_TDS_Rate_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Tds_Nature._Nature_ID = _Nature_ID;
                objDAL_Tds_Nature._Nature_Type = _Nature_Type;
                objDAL_Tds_Nature._Cnn = _Cnn; 
                ds = objDAL_Tds_Nature.Get_TDS_Rate_List();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }
    }
}
