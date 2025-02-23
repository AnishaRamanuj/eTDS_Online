﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;
using CommonLibrary;
namespace DataLayer
{
    public class DAL_Challan : DALCommon
    {
        public int _Challan_ID { get; set; }
        public int _Company_ID { get; set; }
        public DateTime _Challan_Date { get; set; }
        public int _Bank_ID { get; set; }
        public string _Bank_Bsrcode { get; set; }
        public int _Cheque_no { get; set; }
        public DateTime _Cheque_Date { get; set; }
        public string _Quater { get; set; }
        public double _TDS_Amount { get; set; }
        public double _Surcharge { get; set; }
        public double _Education_Cess { get; set; }
        public double _High_Education_Cess { get; set; }
        public double _Interest_Amt { get; set; }
        public double _Fees_Amount { get; set; }
        public double _Others_Amount { get; set; }
        public double _Challan_Amount { get; set; }
        public string _Challan_No { get; set; }
        public string _Trans_No { get; set; }
        public string _C_Entry { get; set; }
        public bool _Nil_Challan { get; set; }

        int result = 0;

        public int Insert_Challan()
        {
            try
            {
                object Challan_Date = _Challan_Date;
                if (_Challan_Date == DateTime.MinValue)
                    Challan_Date = DBNull.Value;

                object Cheque_Date = _Cheque_Date;
                if (_Cheque_Date == DateTime.MinValue)
                    Cheque_Date = DBNull.Value;

                SqlParameter[] objSqlParameter = new SqlParameter[21];

                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[1] = new SqlParameter("@Challan_Date", Challan_Date);
                objSqlParameter[2] = new SqlParameter("@Bank_ID", _Bank_ID);
                objSqlParameter[3] = new SqlParameter("@Bank_Bsrcode", _Bank_Bsrcode);
                objSqlParameter[4] = new SqlParameter("@Cheque_no", _Cheque_no);
                objSqlParameter[5] = new SqlParameter("@Cheque_Date", Cheque_Date);
                objSqlParameter[6] = new SqlParameter("@Quater", _Quater);
                objSqlParameter[7] = new SqlParameter("@TDS_Amount", _TDS_Amount);
                objSqlParameter[8] = new SqlParameter("@Surcharge", _Surcharge);
                objSqlParameter[9] = new SqlParameter("@Education_Cess", _Education_Cess);
                objSqlParameter[10] = new SqlParameter("@High_Education_Cess", _High_Education_Cess);
                objSqlParameter[11] = new SqlParameter("@Interest_Amt", _Interest_Amt);
                objSqlParameter[12] = new SqlParameter("@Fees_Amount", _Fees_Amount);
                objSqlParameter[13] = new SqlParameter("@Others_Amount", _Others_Amount);
                objSqlParameter[14] = new SqlParameter("@Challan_Amount", _Challan_Amount);
                objSqlParameter[15] = new SqlParameter("@Challan_No", _Challan_No);
                objSqlParameter[16] = new SqlParameter("@Trans_No", _Trans_No);
                objSqlParameter[17] = new SqlParameter("@C_Entry", _C_Entry);
                objSqlParameter[18] = new SqlParameter("@Nil_Challan", _Nil_Challan);
                objSqlParameter[19] = new SqlParameter("@ChallanDatatable", ChallanDatatable);
                objSqlParameter[20] = new SqlParameter("@ChallanType", ChallanType);
                result = SqlHelper.ExecuteNonQuery(_cnnString2, CommandType.StoredProcedure, "usp_Insert_Challan", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return result;
        }

        public DataSet Update_Challan()
        {
            DataSet ds = new DataSet();
            try
            {
                object Challan_Date = _Challan_Date;
                if (_Challan_Date == DateTime.MinValue)
                    Challan_Date = DBNull.Value;

                object Cheque_Date = _Cheque_Date;
                if (_Cheque_Date == DateTime.MinValue)
                    Cheque_Date = DBNull.Value;

                SqlParameter[] objSqlParameter = new SqlParameter[20];

                objSqlParameter[0] = new SqlParameter("@Challan_ID", _Challan_ID);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[2] = new SqlParameter("@Challan_Date", _Challan_Date);
                objSqlParameter[3] = new SqlParameter("@Bank_ID", _Bank_ID);
                objSqlParameter[4] = new SqlParameter("@Bank_Bsrcode", _Bank_Bsrcode);
                objSqlParameter[5] = new SqlParameter("@Cheque_no", _Cheque_no);
                objSqlParameter[6] = new SqlParameter("@Cheque_Date", _Cheque_Date);
                objSqlParameter[7] = new SqlParameter("@Quater", _Quater);
                objSqlParameter[8] = new SqlParameter("@TDS_Amount", _TDS_Amount);
                objSqlParameter[9] = new SqlParameter("@Surcharge", _Surcharge);
                objSqlParameter[10] = new SqlParameter("@Education_Cess", _Education_Cess);
                objSqlParameter[11] = new SqlParameter("@High_Education_Cess", _High_Education_Cess);
                objSqlParameter[12] = new SqlParameter("@Interest_Amt", _Interest_Amt);
                objSqlParameter[13] = new SqlParameter("@Fees_Amount", _Fees_Amount);
                objSqlParameter[14] = new SqlParameter("@Others_Amount", _Others_Amount);
                objSqlParameter[15] = new SqlParameter("@Challan_Amount", _Challan_Amount);
                objSqlParameter[16] = new SqlParameter("@Challan_No", _Challan_No);
                objSqlParameter[17] = new SqlParameter("@Trans_No", _Trans_No);
                objSqlParameter[18] = new SqlParameter("@C_Entry", _C_Entry);
                objSqlParameter[19] = new SqlParameter("@Nil_Challan", _Nil_Challan);
                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Update_Challan", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Delete_Challan()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];

                objSqlParameter[0] = new SqlParameter("@Challan_ID", _Challan_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Delete_Challan", objSqlParameter);
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Challan_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];

                objSqlParameter[0] = new SqlParameter("@Challan_ID", _Challan_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Challan_Details", objSqlParameter);
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }



        public DataSet Get_Challan_List()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[4];

                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[1] = new SqlParameter("@Bank_ID", _Bank_ID);
                objSqlParameter[2] = new SqlParameter("@Challan_No", _Challan_No);
                objSqlParameter[3] = new SqlParameter("@Trans_No", _Trans_No);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Challan_List", objSqlParameter);
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }


        public DataTable ChallanDatatable { get; set; }

        public string ChallanType { get; set; }

        public DataSet DAl_EditMode()
        {
            DataSet ds;
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];
                objSqlParameter[0] = new SqlParameter("@Challan_ID", _Challan_ID);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetChallanDetails", objSqlParameter);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public int DAL_DeleteChallanOld()
        {
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Challan_ID", _Challan_ID);
                result = SqlHelper.ExecuteNonQuery(_cnnString2, CommandType.StoredProcedure, "usp_DeletChallanDetails", objSqlParameter);
                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}

