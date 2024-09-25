using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;
using System.Data;
using CommonLibrary;
using System.Data.SqlClient;
using System.Dynamic;
using System.Globalization;

namespace BusinessLayer
{
    public class BAL_NonSalaryChallan : CommonFunctions
    {
        DAL_NonSalaryChallan objDAL_NonSalaryChallan = new DAL_NonSalaryChallan();

        DataSet ds;
        int result = 0;

        public string ChallanType { get; set; }
        public int CompanyID { get; set; }
        public DataTable dtNatureId { get; set; }
        public string Form_Type { get; set; }
        public string Challan_Type { get; set; }
        public bool Nil_Challan { get; set; }
        public string Challan_No { get; set; }
        public string Trans_No { get; set; }
        public string C_Entry { get; set; }
        public double Interest_Amt { get; set; }
        public double Fees_Amount { get; set; }
        public double Others_Amount { get; set; }
        public double Challan_Amount { get; set; }
        public double High_Education_Cess { get; set; }
        public double Education_Cess { get; set; }
        public double Surcharge { get; set; }
        public double TDS_Amount { get; set; }
        public string Quater { get; set; }
        public int Cheque_no { get; set; }
        public DateTime Cheque_Date { get; set; }
        public string Bank_Bsrcode { get; set; }
        public DateTime Challan_Date { get; set; }
        public int Bank_ID { get; set; }
        public DataTable dtVoucherID { get; set; }

        public DataSet BAL_GetNatureFilterByChallanType()
        {
            try
            {
                objDAL_NonSalaryChallan.ChallanType = ChallanType;
                ds = objDAL_NonSalaryChallan.DAL_GetNatureFilterByChallanType();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }


        public DataSet BAL_GetVoucherListOnNatureSelection()
        {
            try
            {
                objDAL_NonSalaryChallan.CompanyID = CompanyID;
                objDAL_NonSalaryChallan.dtNatureId = dtNatureId;
                objDAL_NonSalaryChallan.Quater = Quater;
                ds = objDAL_NonSalaryChallan.DAL_GetVoucherListOnNatureSelection();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }







        public DataSet BAL_GetBankDetial()
        {
            try
            {
                objDAL_NonSalaryChallan.CompanyID = CompanyID;
                ds = objDAL_NonSalaryChallan.BAL_GetBankDetial();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public int BAL_InsertNonSalary()
        {
            try
            {
                objDAL_NonSalaryChallan.dtVoucherID = dtVoucherID;
                objDAL_NonSalaryChallan.CompanyID = CompanyID;
                objDAL_NonSalaryChallan.Challan_Date = Challan_Date;
                objDAL_NonSalaryChallan.Bank_ID = Bank_ID;
                objDAL_NonSalaryChallan.Bank_Bsrcode = Bank_Bsrcode;
                objDAL_NonSalaryChallan.Cheque_no = Cheque_no;
                objDAL_NonSalaryChallan.Cheque_Date = Cheque_Date;
                objDAL_NonSalaryChallan.Quater = Quater;
                objDAL_NonSalaryChallan.TDS_Amount = TDS_Amount;
                objDAL_NonSalaryChallan.Surcharge = Surcharge;
                objDAL_NonSalaryChallan.Education_Cess = Education_Cess;
                objDAL_NonSalaryChallan.High_Education_Cess = High_Education_Cess;
                objDAL_NonSalaryChallan.Interest_Amt = Interest_Amt;
                objDAL_NonSalaryChallan.Fees_Amount = Fees_Amount;
                objDAL_NonSalaryChallan.Others_Amount = Others_Amount;
                objDAL_NonSalaryChallan.Challan_Amount = Challan_Amount;
                objDAL_NonSalaryChallan.Challan_No = Challan_No;
                objDAL_NonSalaryChallan.Trans_No = Trans_No;
                objDAL_NonSalaryChallan.C_Entry = C_Entry;
                objDAL_NonSalaryChallan.Nil_Challan = Nil_Challan;
                objDAL_NonSalaryChallan.Challan_Type = Challan_Type;
                objDAL_NonSalaryChallan.Form_Type = Form_Type;
                objDAL_NonSalaryChallan._Challan_ID = _Challan_ID;
                result = objDAL_NonSalaryChallan.DAL_InsertNonSalary();
                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }


        public int _Challan_ID { get; set; }

        public DataSet BAl_EditNonSalaryMode()
        {
            try
            {
                objDAL_NonSalaryChallan.CompanyID = CompanyID;
                objDAL_NonSalaryChallan._Challan_ID = _Challan_ID;
                ds = objDAL_NonSalaryChallan.DAl_EditNonSalaryMode();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet BAL_GetVoucherListOnNatureSelectionFilter()
        {
            try
            {
                objDAL_NonSalaryChallan.CompanyID = CompanyID;
                objDAL_NonSalaryChallan.dtNatureId = dtNatureId;
                objDAL_NonSalaryChallan.Quater = Quater;
                objDAL_NonSalaryChallan.Challan_Date = Challan_Date;
                objDAL_NonSalaryChallan.Cheque_Date = Cheque_Date;
                objDAL_NonSalaryChallan.Form_Type = Form_Type;
                ds = objDAL_NonSalaryChallan.DAL_GetVoucherListOnNatureSelectionFilter();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }



        public IEnumerable<tbl_Voucher_List> BAL_GetVoucherList_IEnumrable(tbl_Voucher_List obj)
        {
            List<tbl_Voucher_List> tbl = new List<tbl_Voucher_List>();
            try
            {
                using (SqlDataReader drrr = objDAL_NonSalaryChallan.DAL_GetVoucherList_IEnumrable(obj))
                {
                    while (drrr.Read())
                    {
                        tbl.Add(new tbl_Voucher_List()
                        {
                            Voucher_DT = GetValue<DateTime>(drrr["Voucher_DT"].ToString()),
                            Voucher_ID = GetValue<int>(drrr["Voucher_ID"].ToString()),
                            Deductee_Name = GetValue<string>(drrr["Deductee_Name"].ToString()),
                            Section = GetValue<string>(drrr["Section"].ToString()),
                            Voucher_Amount = GetValue<float>(drrr["Voucher_Amount"].ToString()),
                            TDS_Amt = GetValue<float>(drrr["TDS_Amt"].ToString()),
                            Surcharge_Amt = GetValue<float>(drrr["Surcharge_Amt"].ToString()),
                            ECess_Amt = GetValue<float>(drrr["ECess_Amt"].ToString()),
                            HECess_Amt = GetValue<float>(drrr["HECess_Amt"].ToString()),
                            Total_Tax_Amt = GetValue<float>(drrr["Total_Tax_Amt"].ToString()),
                            Nature_Sub_ID = Convert.ToDateTime(GetValue<DateTime>(drrr["Voucher_DT"].ToString())).ToString("dd/MM/yyyy"),////////set Foramated Date Format
                            //TotalIndex = GetValue<int>(drrr["TotalIndex"].ToString()),///set total index count
                            //BranchID = GetValue<int>(drrr["RowNumber"].ToString()),////get row number
                            Nature_ID = GetValue<int>(drrr["Nature_ID"].ToString()),
                            Deductee_Type = GetValue<string>(drrr["Deductee_Type"].ToString()),
                            PAN_NO = GetValue<string>(drrr["PAN_NO"].ToString()),
                        });
                    }
                }
                return tbl as IEnumerable<tbl_Voucher_List>;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public IEnumerable<tbl_Voucher> BAL_GetVoucherList_Count(tbl_Voucher obj)
        {
            List<tbl_Voucher> tbl = new List<tbl_Voucher>();
            try
            {
                using (SqlDataReader drrr = objDAL_NonSalaryChallan.DAL_GetVoucherList_Count(obj))
                {
                    while (drrr.Read())
                    {
                        tbl.Add(new tbl_Voucher()
                        {
                            TotalCount = GetValue<string>(drrr["Totalcount"].ToString()),
                        });
                    }
                }
                return tbl as IEnumerable<tbl_Voucher>;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
    }
}
