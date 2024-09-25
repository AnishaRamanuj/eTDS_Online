using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_PF_Percentage_Master : DALCommon
    {
        public int _Percentage_ID{ get; set; }
        public int _Head_ID { get; set; }
        public string _Head_IDs { get; set; }
        public int _CHead_ID { get; set; }
        public double _Percent_Val { get; set; }
        public int _Company_ID { get; set; }
        public int _State_ID { get; set; }
        public string _Head_Group { get; set; }
        public int _Head_Calculated_ID { get; set; }
        public int _Calculation_Head_ID { get; set; }
        public string _Calc_Gross { get; set; }

        public double _PF_Percentage { get; set; }
        public double _PF_Limit { get; set; }

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

        public DataSet Get_Percentage_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[3];
                objSqlParameter[0] = new SqlParameter("@Head_ID", _Head_ID);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[2] = new SqlParameter("@State_ID", _State_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Percentage_Master_List", objSqlParameter);
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

        public DataSet Insert_Percentage_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[4];

                objSqlParameter[0] = new SqlParameter("@Head_ID", _Head_ID);
                objSqlParameter[1] = new SqlParameter("@Percent_Val", _Percent_Val);
                objSqlParameter[2] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[3] = new SqlParameter("@State_ID", _State_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Insert_Percentage_Master", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Update_Percentage_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[5];

                objSqlParameter[0] = new SqlParameter("@Percentage_ID", _Percentage_ID);
                objSqlParameter[1] = new SqlParameter("@Head_ID", _Head_ID);
                objSqlParameter[2] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[3] = new SqlParameter("@Percent_Val", _Percent_Val);
                objSqlParameter[4] = new SqlParameter("@State_ID", _State_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Update_Percentage_Master", objSqlParameter);
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

        public DataSet Get_Providend_Fund_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];

                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Providend_Fund_Details", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Insert_Update_Providend_Fund()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[3];

                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[1] = new SqlParameter("@PF_Percentage", _PF_Percentage);
                objSqlParameter[2] = new SqlParameter("@PF_Limit", _PF_Limit);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Insert_Update_Providend_Fund", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }
        
    }
}
