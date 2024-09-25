using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;



namespace DataLayer
{
    public class DAL_Import_Voucher : DALCommon
    {
        public int _Company_ID { get; set; }
        public string _Deductee_Name { get; set; }
        public string _Alias { get; set; }
        public string _PAN_NO { get; set; }
        public string _Flat_NO { get; set; }
        public string _Bldg_Name { get; set; }
        public string _Street { get; set; }
        public string _City { get; set; }
        public int _State_ID { get; set; }
        public uint _Pincode { get; set; }
        public int _Branch_ID { get; set; }
        public string _Email { get; set; }
        public uint _Mobile_No { get; set; }
        public int _Nature_ID { get; set; }
        public string _Deductee_Type { get; set; }
        public bool _IS_Individual { get; set; }
        public bool _Multi_Company { get; set; }
        public string _Reasons { get; set; }
        public string _Certificate_No { get; set; }
        public bool _IS_NRI { get; set; }
        public int _Country_ID { get; set; }
        public string _NRI_TDS_Rate { get; set; }
        public int _TDS_Rate_From { get; set; }
        public double _TDS_Rate { get; set; }
        public double _Surcharge { get; set; }
        public string _Nature_Sub_ID { get; set; }
        public string _PANVerified { get; set; }

        public int _Challan_ID { get; set; }
        public int _Deductee_ID { get; set; }
        public DateTime _Voucher_DT { get; set; }
        public double _Voucher_Amount { get; set; }
        public double _TDS_Amt { get; set; }
        public double _Surcharge_Amt { get; set; }
        public double _ECess_Amt { get; set; }
        public double _HECess_Amt { get; set; }
        public uint _TDS_Percentage { get; set; }
        public uint _Surchare_Percentage { get; set; }
        public uint _ECess_Percentage { get; set; }
        public uint _HECess_Percentage { get; set; }
        public double _Total_Tax_Amt { get; set; }
        public string _Reason { get; set; }
        public string _Quater { get; set; }
        public int _Sel { get; set; }
        public string _Section { get; set; }
        public string _From_Type { get; set; }
        public string _TDS_Certificate { get; set; }
        public int _Country_Code { get; set; }
        public string _NRI_Code { get; set; }
        public int _Remittance_ID { get; set; }
        public bool _Threshold_Limit { get; set; }
        public DateTime _Challan_Date { get; set; }
        public string _Challan_BankNo { get; set; }
        public string _InvORBillNo { get; set; }

        public string _State_Name { get; set; }

        public string _Nature_Name { get; set; }
        public string _Nature_Type { get; set; }

        public int _Voucher_Import_Error_Log_ID { get; set; }
        public int _Voucher_Import_Error_Log_Number { get; set; }
        public string _Name { get; set; }
        public string _StateName { get; set; }
        public string _Nature { get; set; }
        public DateTime _Payment_Date { get; set; }
        public DateTime _Deduction_Date { get; set; }
        public double _Invoice_Amount { get; set; }
        public double _TDS_Rate_Per { get; set; }
        public double _TDS_I_TAX { get; set; }
        public double _TDS_Surcharge_Amount { get; set; }
        public double _Net_TDS { get; set; }
        public string _Log_Error { get; set; }
        public int _Import_Id { get; set; }

        public DataSet Insert_Deductee_Master()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[27];

                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[1] = new SqlParameter("@Deductee_Name", _Deductee_Name);
                objSqlParameter[2] = new SqlParameter("@Alias", _Alias);
                objSqlParameter[3] = new SqlParameter("@PAN_NO", _PAN_NO);
                objSqlParameter[4] = new SqlParameter("@Flat_NO", _Flat_NO);
                objSqlParameter[5] = new SqlParameter("@Bldg_Name", _Bldg_Name);
                objSqlParameter[6] = new SqlParameter("@Street", _Street);
                objSqlParameter[7] = new SqlParameter("@City", _City);
                objSqlParameter[8] = new SqlParameter("@State_ID", _State_ID);
                objSqlParameter[9] = new SqlParameter("@Pincode", _Pincode);
                objSqlParameter[10] = new SqlParameter("@Branch_ID", _Branch_ID);
                objSqlParameter[11] = new SqlParameter("@Email", _Email);
                objSqlParameter[12] = new SqlParameter("@Mobile_No", _Mobile_No);
                objSqlParameter[13] = new SqlParameter("@Nature_ID", _Nature_ID);
                objSqlParameter[14] = new SqlParameter("@Deductee_Type", _Deductee_Type);
                objSqlParameter[15] = new SqlParameter("@IS_Individual", _IS_Individual);
                objSqlParameter[16] = new SqlParameter("@Multi_Company", _Multi_Company);
                objSqlParameter[17] = new SqlParameter("@Reasons", _Reasons);
                objSqlParameter[18] = new SqlParameter("@Certificate_NO", _Certificate_No);
                objSqlParameter[19] = new SqlParameter("@IS_NRI", _IS_NRI);
                objSqlParameter[20] = new SqlParameter("@Country_ID", _Country_ID);
                objSqlParameter[21] = new SqlParameter("@NRI_TDS_Rate", _NRI_TDS_Rate);
                objSqlParameter[22] = new SqlParameter("@TDS_Rate_From", _TDS_Rate_From);
                objSqlParameter[23] = new SqlParameter("@TDS_Rate", _TDS_Rate);
                objSqlParameter[24] = new SqlParameter("@Surcharge", _Surcharge);
                objSqlParameter[25] = new SqlParameter("@Nature_Sub_ID", _Nature_Sub_ID);
                objSqlParameter[26] = new SqlParameter("@PANVerified", _PANVerified);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Insert_Deductee_Master", objSqlParameter);

            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Deductee_Master_Details()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];

                objSqlParameter[0] = new SqlParameter("@Deductee_ID", _Deductee_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Deductee_Master_Details", objSqlParameter);

            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Deductee_Master_Details_By_Name()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];

                objSqlParameter[0] = new SqlParameter("@Deductee_Name", _Deductee_Name);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Deductee_Master_Details_By_Name", objSqlParameter);

            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_State_Master_Details_By_Name()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];
                objSqlParameter[0] = new SqlParameter("@State_Name", _State_Name);
                objSqlParameter[1] = new SqlParameter("@PAN_NO", _PAN_NO);
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_State_Master_Details_By_Name", objSqlParameter);

            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Voucher_Import_Error_Log_Number()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];

                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Voucher_Import_Error_Log_Number", objSqlParameter);

            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Voucher_Import_Error_Log_List()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];

                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[1] = new SqlParameter("@Voucher_Import_Error_Log_Number", _Voucher_Import_Error_Log_Number);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Voucher_Import_Error_Log_List", objSqlParameter);
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Insert_Voucher_Import_Error_Log()
        {
            DataSet ds = new DataSet();

            try
            {
                object Payment_Date = _Payment_Date;
                if (_Payment_Date == DateTime.MinValue)
                    Payment_Date = DBNull.Value;

                object Deduction_Date = _Deduction_Date;
                if (_Deduction_Date == DateTime.MinValue)
                    Deduction_Date = DBNull.Value;

                SqlParameter[] objSqlParameter = new SqlParameter[15];

                objSqlParameter[0] = new SqlParameter("@Voucher_Import_Error_Log_Number", _Voucher_Import_Error_Log_Number);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[2] = new SqlParameter("@Name", _Name);
                objSqlParameter[3] = new SqlParameter("@PAN_No", _PAN_NO);
                objSqlParameter[4] = new SqlParameter("@StateName", _StateName);
                objSqlParameter[5] = new SqlParameter("@Nature", _Nature);
                objSqlParameter[6] = new SqlParameter("@Section", _Section);
                objSqlParameter[7] = new SqlParameter("@Payment_Date", Payment_Date);
                objSqlParameter[8] = new SqlParameter("@Deduction_Date", Deduction_Date);
                objSqlParameter[9] = new SqlParameter("@Invoice_Amount", _Invoice_Amount);
                objSqlParameter[10] = new SqlParameter("@TDS_Rate_Per", _TDS_Rate_Per);
                objSqlParameter[11] = new SqlParameter("@TDS_I_TAX", _TDS_I_TAX);
                objSqlParameter[12] = new SqlParameter("@TDS_Surcharge_Amount", _TDS_Surcharge_Amount);
                objSqlParameter[13] = new SqlParameter("@Net_TDS", _Net_TDS);
                objSqlParameter[14] = new SqlParameter("@Log_Error", _Log_Error);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Insert_Voucher_Import_Error_Log", objSqlParameter);
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Get_Nature_List()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[3];

                objSqlParameter[0] = new SqlParameter("@Nature_Name", _Nature_Name);
                objSqlParameter[1] = new SqlParameter("@Section", _Section);
                objSqlParameter[2] = new SqlParameter("@Nature_Type", _Nature_Type);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Nature_List", objSqlParameter);

            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Insert_Voucher()
        {
            DataSet ds = new DataSet();

            try
            {
                object Voucher_DT = _Voucher_DT;
                if (_Voucher_DT == DateTime.MinValue)
                    Voucher_DT = DBNull.Value;

                object Challan_Date = _Challan_Date;
                if (_Challan_Date == DateTime.MinValue)
                    Challan_Date = DBNull.Value;

                SqlParameter[] objSqlParameter = new SqlParameter[35];

                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[1] = new SqlParameter("@Challan_ID", _Challan_ID);
                objSqlParameter[2] = new SqlParameter("@Deductee_ID", _Deductee_ID);
                objSqlParameter[3] = new SqlParameter("@Nature_ID", _Nature_ID);
                objSqlParameter[4] = new SqlParameter("@Nature_Sub_ID", _Nature_Sub_ID);
                objSqlParameter[5] = new SqlParameter("@Voucher_DT", Voucher_DT);
                objSqlParameter[6] = new SqlParameter("@Voucher_Amount", _Voucher_Amount);
                objSqlParameter[7] = new SqlParameter("@TDS_Amt", _TDS_Amt);
                objSqlParameter[8] = new SqlParameter("@Surcharge_Amt", _Surcharge_Amt);
                objSqlParameter[9] = new SqlParameter("@ECess_Amt", _ECess_Amt);
                objSqlParameter[10] = new SqlParameter("@HECess_Amt", _HECess_Amt);
                objSqlParameter[11] = new SqlParameter("@TDS_Percentage", _TDS_Percentage);
                objSqlParameter[12] = new SqlParameter("@Surchare_Percentage", _Surchare_Percentage);
                objSqlParameter[13] = new SqlParameter("@ECess_Percentage", _ECess_Percentage);
                objSqlParameter[14] = new SqlParameter("@HECess_Percentage", _HECess_Percentage);
                objSqlParameter[15] = new SqlParameter("@Total_Tax_Amt", _Total_Tax_Amt);
                objSqlParameter[16] = new SqlParameter("@Deductee_Type", _Deductee_Type);
                objSqlParameter[17] = new SqlParameter("@IS_NRI", _IS_NRI);
                objSqlParameter[18] = new SqlParameter("@Reason", _Reason);
                objSqlParameter[19] = new SqlParameter("@Deductee_Name", _Deductee_Name);
                objSqlParameter[20] = new SqlParameter("@Quater", _Quater);
                objSqlParameter[21] = new SqlParameter("@Sel", _Sel);
                objSqlParameter[22] = new SqlParameter("@Section", _Section);
                objSqlParameter[23] = new SqlParameter("@From_Type", _From_Type);
                objSqlParameter[24] = new SqlParameter("@PAN_NO", _PAN_NO);
                objSqlParameter[25] = new SqlParameter("@TDS_Certificate", _TDS_Certificate);
                objSqlParameter[26] = new SqlParameter("@Country_Code", _Country_Code);
                objSqlParameter[27] = new SqlParameter("@NRI_Code", _NRI_Code);
                objSqlParameter[28] = new SqlParameter("@Remittance_ID", _Remittance_ID);
                objSqlParameter[29] = new SqlParameter("@PANVerified", _PANVerified);
                objSqlParameter[30] = new SqlParameter("@Threshold_Limit", _Threshold_Limit);
                objSqlParameter[31] = new SqlParameter("@Challan_Date", Challan_Date);
                objSqlParameter[32] = new SqlParameter("@Challan_BankNo", _Challan_BankNo);
                objSqlParameter[33] = new SqlParameter("@Certificate_No", _Certificate_No);
                objSqlParameter[34] = new SqlParameter("@InvORBillNo", _InvORBillNo);

                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Insert_Voucher", objSqlParameter);
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataTable  _Vouchertable { get; set; }
        public string _VoucherData { get; set; }

        public DataSet DAL_InsertUpdateImportVoucherRecords()
        {
            try
            {

                DataSet ds;
                if (_Import_Id == 1)
                {
                    SqlParameter[] param = new SqlParameter[4];
                    param[0] = new SqlParameter("@Company_ID", _Company_ID);
                    param[1] = new SqlParameter("@Vouchertable", _Vouchertable);
                    param[2] = new SqlParameter("@FromDateFinacialYear", FromDateFinacialYear);
                    param[3] = new SqlParameter("@EndDateFinacialYear", EndDateFinacialYear);
                     ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_InsertUpdateImportVoucherRecords", param);
                    _Import_Id = _Import_Id + 1;
                return ds;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet DAL_InsertUpdateImportVoucherDataRecords()
        {
            try
            {

                DataSet ds;
                if (_Import_Id == 1)
                {
                    SqlParameter[] param = new SqlParameter[4];
                    param[0] = new SqlParameter("@Company_ID", _Company_ID);
                    param[1] = new SqlParameter("@Vouchertable", _VoucherData);
                    param[2] = new SqlParameter("@FromDateFinacialYear", FromDateFinacialYear);
                    param[3] = new SqlParameter("@EndDateFinacialYear", EndDateFinacialYear);
                    ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_InsertUpdateImportVoucherData", param);
                    _Import_Id = _Import_Id + 1;
                    return ds;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string FromDateFinacialYear { get; set; }

        public string EndDateFinacialYear { get; set; }

        public DataSet DAL_InsertUpdateImportDeducteeRecords()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[4];
                param[0] = new SqlParameter("@Company_ID", _Company_ID);
                param[1] = new SqlParameter("@Vouchertable", _Vouchertable);
                param[2] = new SqlParameter("@FromDateFinacialYear", FromDateFinacialYear);
                param[3] = new SqlParameter("@EndDateFinacialYear", EndDateFinacialYear);
                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_InsertUpdateImportDeducteeRecords", param);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
