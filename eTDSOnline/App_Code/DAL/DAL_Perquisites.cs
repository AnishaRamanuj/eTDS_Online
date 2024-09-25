using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_Perquisites : DALCommon
    {
        public int _Perq_ID { get; set; }
        public int _Perquisites_ID { get; set; }
        public string _Perquisites_Name { get; set; }
        public double _Perquisites_Value { get; set; }
        public double _EmployeePaid_Amt { get; set; }
        public double _Taxable_Amt { get; set; }
        public int _Employee_ID { get; set; }
        public int _Company_ID { get; set; }

        public DataSet Get_Perquisites_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Perq_ID", _Perq_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Perquisites_Details", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Get_Perquisites_List()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[3];

                objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[2] = new SqlParameter("@Perquisites_ID", _Perquisites_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Perquisites_List", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Update_Perquisites()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[4];

                objSqlParameter[0] = new SqlParameter("@Perq_ID", _Perq_ID);
                //objSqlParameter[1] = new SqlParameter("@Perquisites_ID", _Perquisites_ID);
                //objSqlParameter[2] = new SqlParameter("@Perquisites_Name", _Perquisites_Name);
                objSqlParameter[1] = new SqlParameter("@Perquisites_Value", _Perquisites_Value);
                objSqlParameter[2] = new SqlParameter("@EmployeePaid_Amt", _EmployeePaid_Amt);
                objSqlParameter[3] = new SqlParameter("@Taxable_Amt", _Taxable_Amt);
                //objSqlParameter[6] = new SqlParameter("@Employee_ID", _Employee_ID);
                //objSqlParameter[7] = new SqlParameter("@Company_ID", _Company_ID);


                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Update_Perquisites", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }
    }
}
