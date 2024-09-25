using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_Professionaltax_Master : DALCommon
    {

        public int _Professionaltax_ID { get; set; }
        public int _State_ID { get; set; }
        public int _Company_ID { get; set; }
        public double _From_Tax_Amount { get; set; }
        public double _To_Tax_Amount { get; set; }
        public double _Slab { get; set; }
        public int _CHead_ID { get; set; }

        public DataSet Get_Professionaltax_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Professionaltax_ID", _Professionaltax_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Professionaltax_Master_Details", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Get_Professionaltax_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@State_ID", _State_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Professionaltax_Master_List", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }


        public DataSet Get_Professionaltax_Heads()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];

                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[1] = new SqlParameter("@State_ID", _State_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_ProfessionalTax_Heads", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }


        public DataSet Get_Professionaltax_HeadID()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];

                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[1] = new SqlParameter("@CHead_ID", _CHead_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_ProfessionalTax_HeadId", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }


        public DataSet Insert_Professionaltax_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[5];

                objSqlParameter[0] = new SqlParameter("@State_ID", _State_ID);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[2] = new SqlParameter("@From_Tax_Amount", _From_Tax_Amount);
                objSqlParameter[3] = new SqlParameter("@To_Tax_Amount", _To_Tax_Amount);
                objSqlParameter[4] = new SqlParameter("@Slab", _Slab);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Insert_Professionaltax_Master", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Update_Professionaltax_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[5];

                objSqlParameter[0] = new SqlParameter("@Professionaltax_ID", _Professionaltax_ID);
                objSqlParameter[1] = new SqlParameter("@State_ID", _State_ID);
                objSqlParameter[2] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[3] = new SqlParameter("@From_Tax_Amount", _From_Tax_Amount);
                objSqlParameter[4] = new SqlParameter("@To_Tax_Amount", _To_Tax_Amount);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Update_Professionaltax_Master", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Delete_Professionaltax_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Professionaltax_ID", _Professionaltax_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Delete_Professionaltax_Master", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Delete_Professionaltax_Master_By_StateID()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];
                objSqlParameter[0] = new SqlParameter("@State_ID", _State_ID);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Delete_ProfessionalTax_By_State_ID", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }
    }
}
