using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_Heads_Sec10 : DALCommon
    {
        public string _Head_IDs { get; set; }
        public int _Company_ID { get; set; }
        public string _Head_Group { get; set; }
        public int _Head_Calculated_ID { get; set; }
        public string _Calc_Gross { get; set; }

        public DataSet Get_Head_Master_List()
        {
            DataSet dsHead = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[4];
                objSqlParameter[0] = new SqlParameter("@Head_Group", _Head_Group);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[2] = new SqlParameter("@Head_Calculated_ID", _Head_Calculated_ID);
                objSqlParameter[3] = new SqlParameter("@Calc_Gross", _Calc_Gross);
                dsHead = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Head_Master_List", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return dsHead;
        }


        public DataSet Get_Head_Master_with_Sec10()
        {
            DataSet dsHead = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];

                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);

                dsHead = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Head_Section10", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return dsHead;
        }

        public DataSet Update_Heads_Sec10()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];

                objSqlParameter[0] = new SqlParameter("@Head_IDs", _Head_IDs);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Update_Heads_Sec10", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

    }
}
