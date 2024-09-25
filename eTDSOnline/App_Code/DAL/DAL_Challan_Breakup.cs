using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_Challan_Breakup : DALCommon
    {
        public int _Challan_Breakup_ID { get; set; }
        public int _Challan_ID { get; set; }
        public int _Challan_No { get; set; }
        public int _Company_ID { get; set; }
        public int _Employee_ID { get; set; }
        public double _Employee_Salary { get; set; }
        public string _Deduction_Type { get; set; }
        public string _PAN_No { get; set; }
        public string _Quater { get; set; }
        public double _TDS_Amount { get; set; }
        public double _Surcharge_Amount { get; set; }
        public double _EducationCess_Amount { get; set; }
        public double _High_EductionCess_Amount { get; set; }
        public double _Total_TDS_Amount { get; set; }
        public DateTime _Salary_Date { get; set; }
        public DateTime _Tds_Deduction_Date { get; set; }
        public bool _PAN_Verified { get; set; }

        public DataSet Insert_Challan_Breakup()
        {
            DataSet ds = new DataSet();
            try
            {
                object Salary_Date = _Salary_Date;
                if (_Salary_Date == DateTime.MinValue)
                    Salary_Date = DBNull.Value;

                object Tds_Deduction_Date = _Tds_Deduction_Date;
                if (_Tds_Deduction_Date == DateTime.MinValue)
                    Tds_Deduction_Date = DBNull.Value;

                SqlParameter[] objSqlParameter = new SqlParameter[15];

                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[1] = new SqlParameter("@Challan_ID", _Challan_ID);
                objSqlParameter[2] = new SqlParameter("@Employee_ID", _Employee_ID);
                objSqlParameter[3] = new SqlParameter("@Employee_Salary", _Employee_Salary);
                objSqlParameter[4] = new SqlParameter("@Deduction_Type", _Deduction_Type);
                objSqlParameter[5] = new SqlParameter("@PAN_No", _PAN_No);
                objSqlParameter[6] = new SqlParameter("@Quater", _Quater);
                objSqlParameter[7] = new SqlParameter("@TDS_Amount", _TDS_Amount);
                objSqlParameter[8] = new SqlParameter("@Surcharge_Amount", _Surcharge_Amount);
                objSqlParameter[9] = new SqlParameter("@EducationCess_Amount", _EducationCess_Amount);
                objSqlParameter[10] = new SqlParameter("@High_EductionCess_Amount", _High_EductionCess_Amount);
                objSqlParameter[11] = new SqlParameter("@Total_TDS_Amount", _Total_TDS_Amount);
                objSqlParameter[12] = new SqlParameter("@Salary_Date", Salary_Date);
                objSqlParameter[13] = new SqlParameter("@Tds_Deduction_Date", Tds_Deduction_Date);
                objSqlParameter[14] = new SqlParameter("@PAN_Verified", _PAN_Verified);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Insert_Challan_Breakup", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Update_Challan_Breakup()
        {
            DataSet ds = new DataSet();
            try
            {
                object Salary_Date = _Salary_Date;
                if (_Salary_Date == DateTime.MinValue)
                    Salary_Date = DBNull.Value;

                object Tds_Deduction_Date = _Tds_Deduction_Date;
                if (_Tds_Deduction_Date == DateTime.MinValue)
                    Tds_Deduction_Date = DBNull.Value;

                SqlParameter[] objSqlParameter = new SqlParameter[16];

                objSqlParameter[0] = new SqlParameter("@Challan_Breakup_ID", _Challan_Breakup_ID);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[2] = new SqlParameter("@Challan_ID", _Challan_ID);
                objSqlParameter[3] = new SqlParameter("@Employee_ID", _Employee_ID);
                objSqlParameter[4] = new SqlParameter("@Employee_Salary", _Employee_Salary);
                objSqlParameter[5] = new SqlParameter("@Deduction_Type", _Deduction_Type);
                objSqlParameter[6] = new SqlParameter("@PAN_No", _PAN_No);
                objSqlParameter[7] = new SqlParameter("@Quater", _Quater);
                objSqlParameter[8] = new SqlParameter("@TDS_Amount", _TDS_Amount);
                objSqlParameter[9] = new SqlParameter("@Surcharge_Amount", _Surcharge_Amount);
                objSqlParameter[10] = new SqlParameter("@EducationCess_Amount", _EducationCess_Amount);
                objSqlParameter[11] = new SqlParameter("@High_EductionCess_Amount", _High_EductionCess_Amount);
                objSqlParameter[12] = new SqlParameter("@Total_TDS_Amount", _Total_TDS_Amount);
                objSqlParameter[13] = new SqlParameter("@Salary_Date", _Salary_Date);
                objSqlParameter[14] = new SqlParameter("@Tds_Deduction_Date", _Tds_Deduction_Date);
                objSqlParameter[15] = new SqlParameter("@PAN_Verified", _PAN_Verified);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Update_Challan_Breakup", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Delete_Challan_Breakup()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];

                objSqlParameter[0] = new SqlParameter("@Challan_Breakup_ID", _Challan_Breakup_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Delete_Challan_Breakup", objSqlParameter);
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Challan_Breakup_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];

                objSqlParameter[0] = new SqlParameter("@Challan_Breakup_ID", _Challan_Breakup_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Challan_Breakup_Details", objSqlParameter);
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Challan_Breakup_List()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[4];

                objSqlParameter[0] = new SqlParameter("@Challan_ID", _Challan_ID);
                objSqlParameter[1] = new SqlParameter("@Challan_No", _Challan_No);
                objSqlParameter[2] = new SqlParameter("@Employee_ID", _Employee_ID);
                objSqlParameter[3] = new SqlParameter("@Company_ID", _Company_ID);
                
                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Challan_Breakup_List", objSqlParameter);
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }
    }
}
