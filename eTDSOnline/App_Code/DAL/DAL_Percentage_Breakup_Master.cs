using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_Percentage_Breakup_Master : DALCommon
    {
        public int _Percent_Brk_ID { get; set; }
        public int _Percentage_ID { get; set; }
        public int _Head_ID { get; set; }
        public int _Company_ID { get; set; }
        public int _Calculation_Head_ID { get; set; }
        public int _State_ID { get; set; }

        public string _Head_IDs { get; set; }


        public DataSet Get_Percentage_Breakup_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Percent_Brk_ID", _Percent_Brk_ID);
                
                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Percentage_Breakup_Master_Details", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Get_Percentage_Breakup_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[3];
                objSqlParameter[0] = new SqlParameter("@Calculation_Head_ID", _Calculation_Head_ID);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[2] = new SqlParameter("@State_ID", _State_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Percentage_Breakup_Master_List", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Insert_Update_Percentage_Breakup_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[4];

                objSqlParameter[0] = new SqlParameter("@Percentage_ID", _Percentage_ID);
                objSqlParameter[1] = new SqlParameter("@Head_IDs", _Head_IDs);
                objSqlParameter[2] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[3] = new SqlParameter("@Calculation_Head_ID", _Calculation_Head_ID);
                //objSqlParameter[4] = new SqlParameter("@State_ID", _State_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Insert_Update_Percentage_Breakup_Master", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Insert_Percentage_Breakup_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[4];

                objSqlParameter[0] = new SqlParameter("@Percentage_ID", _Percentage_ID);
                objSqlParameter[1] = new SqlParameter("@Head_ID", _Head_ID);
                objSqlParameter[2] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[3] = new SqlParameter("@Calculation_Head_ID", _Calculation_Head_ID);
                //objSqlParameter[4] = new SqlParameter("@State_ID", _State_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Insert_Percentage_Breakup_Master", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Update_Percentage_Breakup_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[6];

                objSqlParameter[0] = new SqlParameter("@Percent_Brk_ID", _Percent_Brk_ID);
                objSqlParameter[1] = new SqlParameter("@Percentage_ID", _Percentage_ID);
                objSqlParameter[2] = new SqlParameter("@Head_ID", _Head_ID);
                objSqlParameter[3] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[4] = new SqlParameter("@Calculation_Head_ID", _Calculation_Head_ID);
                //objSqlParameter[5] = new SqlParameter("@State_ID", _State_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Update_Percentage_Breakup_Master", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Delete_Percentage_Breakup_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Percent_Brk_ID", _Percent_Brk_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Delete_Percentage_Breakup_Master", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Delete_Percentage_Breakup_Master_By_HeadID()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Head_ID", _Head_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Delete_Percentage_Breakup_Master_By_HeadID", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Delete_Percentage_Breakup_Master_By_Percentage_ID()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Percentage_ID", _Percentage_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Delete_Percentage_Breakup_Master_By_Percentage_ID", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }
    }
}
