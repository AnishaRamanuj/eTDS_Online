using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_Import_Voucher
    {
        DAL_Import_Voucher objDAL_Import_Voucher = new DAL_Import_Voucher();

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
                objDAL_Import_Voucher._Company_ID = _Company_ID;
                objDAL_Import_Voucher._Deductee_Name = _Deductee_Name;
                objDAL_Import_Voucher._Alias = _Alias;
                objDAL_Import_Voucher._PAN_NO = _PAN_NO;
                objDAL_Import_Voucher._Flat_NO = _Flat_NO;
                objDAL_Import_Voucher._Bldg_Name = _Bldg_Name;
                objDAL_Import_Voucher._Street = _Street;
                objDAL_Import_Voucher._City = _City;
                objDAL_Import_Voucher._State_ID = _State_ID;
                objDAL_Import_Voucher._Pincode = _Pincode;
                objDAL_Import_Voucher._Branch_ID = _Branch_ID;
                objDAL_Import_Voucher._Email = _Email;
                objDAL_Import_Voucher._Mobile_No = _Mobile_No;
                objDAL_Import_Voucher._Nature_ID = _Nature_ID;
                objDAL_Import_Voucher._Deductee_Type = _Deductee_Type;
                objDAL_Import_Voucher._IS_Individual = _IS_Individual;
                objDAL_Import_Voucher._Multi_Company = _Multi_Company;
                objDAL_Import_Voucher._Reasons = _Reasons;
                objDAL_Import_Voucher._Certificate_No = _Certificate_No;
                objDAL_Import_Voucher._IS_NRI = _IS_NRI;
                objDAL_Import_Voucher._Country_ID = _Country_ID;
                objDAL_Import_Voucher._NRI_TDS_Rate = _NRI_TDS_Rate;
                objDAL_Import_Voucher._TDS_Rate_From = _TDS_Rate_From;
                objDAL_Import_Voucher._TDS_Rate = _TDS_Rate;
                objDAL_Import_Voucher._Surcharge = _Surcharge;
                objDAL_Import_Voucher._Nature_Sub_ID = _Nature_Sub_ID;
                objDAL_Import_Voucher._PANVerified = _PANVerified;

                ds = objDAL_Import_Voucher.Insert_Deductee_Master();
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
                objDAL_Import_Voucher._Deductee_ID = _Deductee_ID;
                ds = objDAL_Import_Voucher.Get_Deductee_Master_Details();
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
                objDAL_Import_Voucher._Deductee_Name = _Deductee_Name;
                ds = objDAL_Import_Voucher.Get_Deductee_Master_Details_By_Name();
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
                objDAL_Import_Voucher._State_Name = _State_Name;
                objDAL_Import_Voucher._PAN_NO = _PAN_NO;
                ds = objDAL_Import_Voucher.Get_State_Master_Details_By_Name();
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
                objDAL_Import_Voucher._Company_ID = _Company_ID;
                ds = objDAL_Import_Voucher.Get_Voucher_Import_Error_Log_Number();
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
                objDAL_Import_Voucher._Company_ID = _Company_ID;
                objDAL_Import_Voucher._Voucher_Import_Error_Log_Number = _Voucher_Import_Error_Log_Number;
                ds = objDAL_Import_Voucher.Get_Voucher_Import_Error_Log_List();
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
                objDAL_Import_Voucher._Voucher_Import_Error_Log_Number = _Voucher_Import_Error_Log_Number;
                objDAL_Import_Voucher._Company_ID = _Company_ID;
                objDAL_Import_Voucher._Name =  _Name;
                objDAL_Import_Voucher._PAN_NO =  _PAN_NO;
                objDAL_Import_Voucher._StateName= _StateName;
                objDAL_Import_Voucher._Nature= _Nature;
                objDAL_Import_Voucher._Section= _Section;
                objDAL_Import_Voucher._Payment_Date= _Payment_Date;
                objDAL_Import_Voucher._Deduction_Date= _Deduction_Date;
                objDAL_Import_Voucher._Invoice_Amount= _Invoice_Amount;
                objDAL_Import_Voucher._TDS_Rate_Per= _TDS_Rate_Per;
                objDAL_Import_Voucher._TDS_I_TAX= _TDS_I_TAX;
                objDAL_Import_Voucher._TDS_Surcharge_Amount= _TDS_Surcharge_Amount;
                objDAL_Import_Voucher._Net_TDS= _Net_TDS;
                objDAL_Import_Voucher._Log_Error= _Log_Error;

                ds = objDAL_Import_Voucher.Insert_Voucher_Import_Error_Log();
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
                objDAL_Import_Voucher._Nature_Name = _Nature_Name;
                objDAL_Import_Voucher._Section = _Section;
                objDAL_Import_Voucher._Nature_Type = _Nature_Type;

                ds = objDAL_Import_Voucher.Get_Nature_List();
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
                objDAL_Import_Voucher._Deductee_Name = _Deductee_Name;
                objDAL_Import_Voucher._Company_ID = _Company_ID;
                objDAL_Import_Voucher._Challan_ID = _Challan_ID;
                objDAL_Import_Voucher._Deductee_ID = _Deductee_ID;
                objDAL_Import_Voucher._Nature_ID = _Nature_ID;
                objDAL_Import_Voucher._Nature_Sub_ID = _Nature_Sub_ID;
                objDAL_Import_Voucher._Voucher_DT = _Voucher_DT;
                objDAL_Import_Voucher._Voucher_Amount = _Voucher_Amount;
                objDAL_Import_Voucher._TDS_Amt = _TDS_Amt;
                objDAL_Import_Voucher._Surcharge_Amt = _Surcharge_Amt;
                objDAL_Import_Voucher._ECess_Amt = _ECess_Amt;
                objDAL_Import_Voucher._HECess_Amt = _HECess_Amt;
                objDAL_Import_Voucher._TDS_Percentage = _TDS_Percentage;
                objDAL_Import_Voucher._Surchare_Percentage = _Surchare_Percentage;
                objDAL_Import_Voucher._ECess_Percentage = _ECess_Percentage;
                objDAL_Import_Voucher._HECess_Percentage = _HECess_Percentage;
                objDAL_Import_Voucher._Total_Tax_Amt = _Total_Tax_Amt;
                objDAL_Import_Voucher._Deductee_Type = _Deductee_Type;
                objDAL_Import_Voucher._IS_NRI = _IS_NRI;
                objDAL_Import_Voucher._Reason = _Reason;
                objDAL_Import_Voucher._Deductee_Name = _Deductee_Name;
                objDAL_Import_Voucher._Quater = _Quater;
                objDAL_Import_Voucher._Sel = _Sel;
                objDAL_Import_Voucher._Section = _Section;
                objDAL_Import_Voucher._From_Type = _From_Type;
                objDAL_Import_Voucher._PAN_NO = _PAN_NO;
                objDAL_Import_Voucher._TDS_Certificate = _TDS_Certificate;
                objDAL_Import_Voucher._Country_Code = _Country_Code;
                objDAL_Import_Voucher._NRI_Code = _NRI_Code;
                objDAL_Import_Voucher._Remittance_ID = _Remittance_ID;
                objDAL_Import_Voucher._PANVerified = _PANVerified;
                objDAL_Import_Voucher._Threshold_Limit = _Threshold_Limit;
                objDAL_Import_Voucher._Challan_Date = _Challan_Date;
                objDAL_Import_Voucher._Challan_BankNo = _Challan_BankNo;
                objDAL_Import_Voucher._Certificate_No = _Certificate_No;
                objDAL_Import_Voucher._InvORBillNo = _InvORBillNo;

                ds = objDAL_Import_Voucher.Insert_Voucher();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet BAL_InsertUpdateImportVoucherRecords()
        {
            try
            {
                objDAL_Import_Voucher._Import_Id = 1;
                DataSet ds;
                objDAL_Import_Voucher._Company_ID = _Company_ID;
                objDAL_Import_Voucher._Vouchertable = _Vouchertable;
                objDAL_Import_Voucher.FromDateFinacialYear = FromDateFinacialYear;
                objDAL_Import_Voucher.EndDateFinacialYear = EndDateFinacialYear;

                ds = objDAL_Import_Voucher.DAL_InsertUpdateImportVoucherRecords();

                return ds;
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }

        public DataSet BAL_InsertUpdateImportVoucherDataRecords()
        {
            try
            {
                objDAL_Import_Voucher._Import_Id = 1;
                DataSet ds;
                objDAL_Import_Voucher._Company_ID = _Company_ID;
                objDAL_Import_Voucher._VoucherData = _VoucherData;
                objDAL_Import_Voucher.FromDateFinacialYear = FromDateFinacialYear;
                objDAL_Import_Voucher.EndDateFinacialYear = EndDateFinacialYear;

                ds = objDAL_Import_Voucher.DAL_InsertUpdateImportVoucherDataRecords();

                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataTable _Vouchertable { get; set; }
        public string _VoucherData { get; set; }

        public string FromDateFinacialYear { get; set; }

        public string EndDateFinacialYear { get; set; }

        public DataSet BAL_InsertUpdateImportDeducteeRecords()
        {
            try
            {
                objDAL_Import_Voucher._Company_ID = _Company_ID;
                objDAL_Import_Voucher._Vouchertable = _Vouchertable;
                objDAL_Import_Voucher.FromDateFinacialYear = FromDateFinacialYear;
                objDAL_Import_Voucher.EndDateFinacialYear = EndDateFinacialYear;
                DataSet ds = objDAL_Import_Voucher.DAL_InsertUpdateImportDeducteeRecords();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}
