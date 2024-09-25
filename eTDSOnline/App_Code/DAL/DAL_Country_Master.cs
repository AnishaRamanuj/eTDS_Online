using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_Country_Master : DALCommon
    {
        public int _Country_ID{ get; set; }
        public string _Country_Name { get; set; }

        public DataSet Get_Country_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Country_Name", _Country_Name);
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Country_Master_List", objSqlParameter);

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

    }
}
