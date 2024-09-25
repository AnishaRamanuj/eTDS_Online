using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_Tds_Rate : DALCommon
    {

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
                SqlParameter[] objSqlParameter = new SqlParameter[2];
                objSqlParameter[0] = new SqlParameter("@Nature_ID", _Nature_ID);
                objSqlParameter[1] = new SqlParameter("@Nature_Type", _Nature_Type);
                string[] financialyear = _Cnn.Split('_');
                int i = 0;
                _Cnn = "20" + financialyear[1];
                i = Convert.ToInt32(_Cnn);
                string SP = "";
                if (i == 2020)
                {
                    SP = "usp_Get_TDS_Rate_List_20";
                }
                else
                {
                    SP = "usp_Get_TDS_Rate_List";
                }
                ds = SqlHelper.ExecuteDataset(_cnnString2, SP, objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }
    }
}
