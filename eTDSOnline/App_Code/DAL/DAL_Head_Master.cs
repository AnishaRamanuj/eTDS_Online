using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_Head_Master : DALCommon
    {

        public int _Head_ID { get; set; }
        public string _Head_Name { get; set; }
        public string _Head_Group { get; set; }
        public bool _Mth1 { get; set; }
        public bool _Mth2 { get; set; }
        public bool _Mth3 { get; set; }
        public bool _Mth4 { get; set; }
        public bool _Mth5 { get; set; }
        public bool _Mth6 { get; set; }
        public bool _Mth7 { get; set; }
        public bool _Mth8 { get; set; }
        public bool _Mth9 { get; set; }
        public bool _Mth10 { get; set; }
        public bool _Mth11 { get; set; }
        public bool _Mth12 { get; set; }
        public bool _Section10 { get; set; }
        public bool _Conveyance_Type { get; set; }
        public int _Rounding_Modes { get; set; }
        public string _Calc_Gross { get; set; }
        public double _Calc_Gross_Percentage { get; set; }
        public bool _Manual_Entry { get; set; }
        public int _Reports_Type { get; set; }
        public bool _Computation { get; set; }
        public bool _Projection { get; set; }
        public int _Company_ID { get; set; }
        public int _Head_Calculated_ID { get; set; }
        public int _Head_Type_ID { get; set; }

        public DataSet Get_Head_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Head_ID", _Head_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Head_Master_Details", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }


        public DataSet Get_HeadType_List()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_HeadType_List");
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

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
                dsHead = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Head_Master_List", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return dsHead;
        }

        public DataSet Get_Head_Master_List_For_PT()
        {
            DataSet dsHead = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Head_Group", _Head_Group);
                dsHead = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Head_Master_List_For_PT", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return dsHead;
        }

        public DataSet Insert_Head_Master()
        {
            DataSet ds = new DataSet();
            try
            {
              
                SqlParameter[] objSqlParameter = new SqlParameter[24];

                objSqlParameter[0] = new SqlParameter("@Head_Name", _Head_Name);
                objSqlParameter[1] = new SqlParameter("@Head_Group", _Head_Group);
                objSqlParameter[2] = new SqlParameter("@Mth1", _Mth1);
                objSqlParameter[3] = new SqlParameter("@Mth2", _Mth2);
                objSqlParameter[4] = new SqlParameter("@Mth3", _Mth3);
                objSqlParameter[5] = new SqlParameter("@Mth4", _Mth4);
                objSqlParameter[6] = new SqlParameter("@Mth5", _Mth5);
                objSqlParameter[7] = new SqlParameter("@Mth6", _Mth6);
                objSqlParameter[8] = new SqlParameter("@Mth7", _Mth7);
                objSqlParameter[9] = new SqlParameter("@Mth8", _Mth8);
                objSqlParameter[10] = new SqlParameter("@Mth9", _Mth9);
                objSqlParameter[11] = new SqlParameter("@Mth10", _Mth10);
                objSqlParameter[12] = new SqlParameter("@Mth11", _Mth11);
                objSqlParameter[13] = new SqlParameter("@Mth12", _Mth12);
                objSqlParameter[14] = new SqlParameter("@Section10", _Section10);
                objSqlParameter[15] = new SqlParameter("@Head_Type_ID", _Head_Type_ID);
                objSqlParameter[16] = new SqlParameter("@Rounding_Modes", _Rounding_Modes);
                objSqlParameter[17] = new SqlParameter("@Calc_Gross", _Calc_Gross);
                objSqlParameter[18] = new SqlParameter("@Calc_Gross_Percentage", _Calc_Gross_Percentage);
                objSqlParameter[19] = new SqlParameter("@Manual_Entry", _Manual_Entry);
                objSqlParameter[20] = new SqlParameter("@Reports_Type", _Reports_Type);
                objSqlParameter[21] = new SqlParameter("@Computation", _Computation);
                objSqlParameter[22] = new SqlParameter("@Projection", _Projection);
                objSqlParameter[23] = new SqlParameter("@Company_ID", _Company_ID);
                

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Insert_Head_Master", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Update_Head_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[25];

                objSqlParameter[0] = new SqlParameter("@Head_ID", _Head_ID);
                objSqlParameter[1] = new SqlParameter("@Head_Name", _Head_Name);
                objSqlParameter[2] = new SqlParameter("@Head_Group", _Head_Group);
                objSqlParameter[3] = new SqlParameter("@Mth1", _Mth1);
                objSqlParameter[4] = new SqlParameter("@Mth2", _Mth2);
                objSqlParameter[5] = new SqlParameter("@Mth3", _Mth3);
                objSqlParameter[6] = new SqlParameter("@Mth4", _Mth4);
                objSqlParameter[7] = new SqlParameter("@Mth5", _Mth5);
                objSqlParameter[8] = new SqlParameter("@Mth6", _Mth6);
                objSqlParameter[9] = new SqlParameter("@Mth7", _Mth7);
                objSqlParameter[10] = new SqlParameter("@Mth8", _Mth8);
                objSqlParameter[11] = new SqlParameter("@Mth9", _Mth9);
                objSqlParameter[12] = new SqlParameter("@Mth10", _Mth10);
                objSqlParameter[13] = new SqlParameter("@Mth11", _Mth11);
                objSqlParameter[14] = new SqlParameter("@Mth12", _Mth12);
                objSqlParameter[15] = new SqlParameter("@Section10", _Section10);
                objSqlParameter[16] = new SqlParameter("@Head_Type_ID", _Head_Type_ID);
                objSqlParameter[17] = new SqlParameter("@Rounding_Modes", _Rounding_Modes);
                objSqlParameter[18] = new SqlParameter("@Calc_Gross", _Calc_Gross);
                objSqlParameter[19] = new SqlParameter("@Calc_Gross_Percentage", _Calc_Gross_Percentage);
                objSqlParameter[20] = new SqlParameter("@Manual_Entry", _Manual_Entry);
                objSqlParameter[21] = new SqlParameter("@Reports_Type", _Reports_Type);
                objSqlParameter[22] = new SqlParameter("@Computation", _Computation);
                objSqlParameter[23] = new SqlParameter("@Projection", _Projection);
                objSqlParameter[24] = new SqlParameter("@Company_ID", _Company_ID);
                //objSqlParameter[25] = new SqlParameter("@Head_Calculated_ID", _Head_Calculated_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Update_Head_Master", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Delete_Head_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Head_ID", _Head_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Delete_Head_Master", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Check_with_Grade_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Head_ID", _Head_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Check_with_Grade_Master", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }
       
    }
}
