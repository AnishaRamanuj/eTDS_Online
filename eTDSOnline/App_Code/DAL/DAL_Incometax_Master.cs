using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_Incometax_Master : DALCommon
    {
        public int _Incometax_ID { get; set; }
        public string _Gender { get; set; }
        public double _Tax_Amount { get; set; }
        public double _Slab { get; set; }
        public string _SlabTitle { get; set; }

        public string SearchTxt { get; set; }
        public string SearchTxtFld { get; set; }

        public DataSet Get_Incometax_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Incometax_ID", _Incometax_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Incometax_Master_Details", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Get_Incometax_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                //SqlParameter[] objSqlParameter = new SqlParameter[2];
                //objSqlParameter[0] = new SqlParameter("@Department_Name", _Department_Name);
                //objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Incometax_Master_List");
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Insert_Incometax_Master()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[4];

                objSqlParameter[0] = new SqlParameter("@Gender", _Gender );
                objSqlParameter[1] = new SqlParameter("@Tax_Amount", _Tax_Amount);
                objSqlParameter[2] = new SqlParameter("@Slab", _Slab);
                objSqlParameter[3] = new SqlParameter("@SlabTitle", _SlabTitle);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Insert_Incometax_Master", objSqlParameter);

            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Update_Incometax_Master()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[5];

                objSqlParameter[0] = new SqlParameter("@Incometax_ID", _Incometax_ID);
                objSqlParameter[1] = new SqlParameter("@Gender", _Gender);
                objSqlParameter[2] = new SqlParameter("@Tax_Amount", _Tax_Amount);
                objSqlParameter[3] = new SqlParameter("@Slab", _Slab);
                objSqlParameter[4] = new SqlParameter("@SlabTitle", _SlabTitle);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Update_Incometax_Master", objSqlParameter);

            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Delete_Incometax_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];

                objSqlParameter[0] = new SqlParameter("@Incometax_ID", _Incometax_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Delete_Incometax_Master", objSqlParameter);
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

    }
}
