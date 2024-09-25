using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_Tds_Computation_Grid : DALCommon
    {
        public int _Grid_ID { get; set; }
        public string _Grid_Names { get; set; }
        public double _Grid_Val1 { get; set; }
        public double _Grid_Val2 { get; set; }
        public double _Grid_Val3 { get; set; }
        public bool _Colaspable { get; set; }
        public bool _Editable { get; set; }


        public int _Employee_ID { get; set; }
        public int _Company_ID { get; set; }

        public DataSet Get_Tds_Computation_Grid_List()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[3];

                objSqlParameter[0] = new SqlParameter("@Grid_Names", _Grid_Names);
                objSqlParameter[1] = new SqlParameter("@Colaspable", _Colaspable);
                objSqlParameter[2] = new SqlParameter("@Editable", _Editable);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Tds_Computation_Grid_List", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Get_Tds_Computation_Grid_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];

                objSqlParameter[0] = new SqlParameter("@Grid_ID", _Grid_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Tds_Computation_Grid_Details", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Update_Tds_Computation_Grid()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[7];

                objSqlParameter[0] = new SqlParameter("@Grid_ID", _Grid_ID);
                objSqlParameter[1] = new SqlParameter("@Grid_Names", _Grid_Names);
                objSqlParameter[2] = new SqlParameter("@Grid_Val1", _Grid_Val1);
                objSqlParameter[3] = new SqlParameter("@Grid_Val2", _Grid_Val2);
                objSqlParameter[4] = new SqlParameter("@Grid_Val3", _Grid_Val3);
                objSqlParameter[5] = new SqlParameter("@Colaspable", _Colaspable);
                objSqlParameter[6] = new SqlParameter("@Editable", _Editable);
                
                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Update_Tds_Computation_Grid", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Get_Employee_ProfessionTax_List()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];

                objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Employee_ProfessionTax_List", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }
    }
}
