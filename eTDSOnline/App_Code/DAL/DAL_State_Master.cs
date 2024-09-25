using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_State_Master : DALCommon
    {
        public int _State_ID{ get; set; }
        public string _State_Name { get; set; }

        public DataSet Get_State_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@State_Name", _State_Name);
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_State_Master_List", objSqlParameter);

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public SqlDataReader DAL_getState()
        {
              return SqlHelper.ExecuteReader(_cnnString, CommandType.StoredProcedure, "usp_Get_State_Master");
        }

    }
}
