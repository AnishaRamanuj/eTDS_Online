using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_HRA_Rent_Receipt : DALCommon
    {
        public int _HRA_Rent_Receipt_ID { get; set; }
        public int _Employee_ID { get; set; }
        public int _Month_No { get; set; }
        public string _Month_Name { get; set; }
        public double _Amount { get; set; }
        public int _Company_ID { get; set; }

        public DataSet Get_HRA_Rent_Receipt_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@HRA_Rent_Receipt_ID", _HRA_Rent_Receipt_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_HRA_Rent_Receipt_Details", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Get_HRA_Rent_Receipt_List()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[4];
                objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[2] = new SqlParameter("@Month_No", _Month_No);
                objSqlParameter[3] = new SqlParameter("@Month_Name", _Month_Name);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_HRA_Rent_Receipt_List", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Insert_HRA_Rent_Receipt()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[5];

                objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);
                objSqlParameter[1] = new SqlParameter("@Month_No", _Month_No);
                objSqlParameter[2] = new SqlParameter("@Month_Name", _Month_Name);
                objSqlParameter[3] = new SqlParameter("@Amount", _Amount);
                objSqlParameter[4] = new SqlParameter("@Company_ID", _Company_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Insert_HRA_Rent_Receipt", objSqlParameter);

            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Update_HRA_Rent_Receipt()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[6];

                objSqlParameter[0] = new SqlParameter("@HRA_Rent_Receipt_ID", _HRA_Rent_Receipt_ID);
                objSqlParameter[1] = new SqlParameter("@Employee_ID", _Employee_ID);
                objSqlParameter[2] = new SqlParameter("@Month_No", _Month_No);
                objSqlParameter[3] = new SqlParameter("@Month_Name", _Month_Name);
                objSqlParameter[4] = new SqlParameter("@Amount", _Amount);
                objSqlParameter[5] = new SqlParameter("@Company_ID", _Company_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Update_HRA_Rent_Receipt", objSqlParameter);

            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Delete_HRA_Rent_Receipt()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];

                objSqlParameter[0] = new SqlParameter("@HRA_Rent_Receipt_ID", _HRA_Rent_Receipt_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Delete_HRA_Rent_Receipt", objSqlParameter);
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Professtionatax()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];
                objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);


                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_ProfesstionTax_Salary", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet DAL_Update_ProfesstionalTax()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[4];
                objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);
                objSqlParameter[1] = new SqlParameter("@Month_No", _Month_No);
                objSqlParameter[2] = new SqlParameter("@Amount", _Amount);
                objSqlParameter[3] = new SqlParameter("@Company_ID", _Company_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Update_Professtion_Tax", objSqlParameter);
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

    }
}
