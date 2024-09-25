using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Microsoft.ApplicationBlocks1.Data;
using System.Data.SqlClient;
using CommonLibrary;

namespace DataLayer
{
    public class DAL_NonSalaryChallan : DALCommon
    {
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


        public System.Data.DataSet DAL_GetNatureFilterByChallanType()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@ChallanType", ChallanType);
                ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_GetNatureFilterByChallanType", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }





        public DataSet DAL_GetVoucherListOnNatureSelection()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@CompanyID", CompanyID);
                param[1] = new SqlParameter("@dtNatureId", dtNatureId);
                param[2] = new SqlParameter("@Quater", Quater);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetVoucherListOnNatureSelection", param);
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
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Company_ID", CompanyID);
                ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_GetBankDetial", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public int DAL_InsertNonSalary()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[23];
                param[0] = new SqlParameter("@dtVoucherID", dtVoucherID);
                param[1] = new SqlParameter("@CompanyID", CompanyID);
                param[2] = new SqlParameter("@Challan_Date", Challan_Date);
                param[3] = new SqlParameter("@Bank_ID", Bank_ID);
                param[4] = new SqlParameter("@Bank_Bsrcode", Bank_Bsrcode);
                param[5] = new SqlParameter("@Cheque_no", Cheque_no);
                param[6] = new SqlParameter("@Cheque_Date", Cheque_Date);
                param[7] = new SqlParameter("@Quater", Quater);
                param[8] = new SqlParameter("@TDS_Amount", TDS_Amount);
                param[9] = new SqlParameter("@Surcharge", Surcharge);
                param[10] = new SqlParameter("@Education_Cess", Education_Cess);
                param[11] = new SqlParameter("@High_Education_Cess", High_Education_Cess);
                param[12] = new SqlParameter("@Interest_Amt", Interest_Amt);
                param[13] = new SqlParameter("@Fees_Amount", Fees_Amount);
                param[14] = new SqlParameter("@Others_Amount", Others_Amount);
                param[15] = new SqlParameter("@Challan_Amount", Challan_Amount);
                param[16] = new SqlParameter("@Challan_No", Challan_No);
                param[17] = new SqlParameter("@Trans_No", Trans_No);
                param[18] = new SqlParameter("@C_Entry", C_Entry);
                param[19] = new SqlParameter("@Nil_Challan", Nil_Challan);
                param[20] = new SqlParameter("@Challan_Type", Challan_Type);
                param[21] = new SqlParameter("@Form_Type", Form_Type);
                param[22] = new SqlParameter("@Challan_ID", _Challan_ID);
                result = SqlHelper.ExecuteNonQuery(_cnnString2, CommandType.StoredProcedure, "usp_InsertNonSalary", param);
                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public int _Challan_ID { get; set; }

        public DataSet DAl_EditNonSalaryMode()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@Challan_ID", _Challan_ID);
                param[1] = new SqlParameter("@CompanyID", CompanyID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_EditNonSalaryMode", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        public DataSet DAL_GetVoucherListOnNatureSelectionFilter()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[6];
                param[0] = new SqlParameter("@CompanyID", CompanyID);
                param[1] = new SqlParameter("@dtNatureId", dtNatureId);
                param[2] = new SqlParameter("@Quater", Quater);
                param[3] = new SqlParameter("@from", Challan_Date);
                param[4] = new SqlParameter("@To", Cheque_Date);
                param[5] = new SqlParameter("@type", Form_Type);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetVoucherListOnNatureSelectionFilter", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }



        public SqlDataReader DAL_GetVoucherList_IEnumrable(tbl_Voucher_List obj)
        {
            try
            {
                DataSet ds;

                SqlParameter[] param = new SqlParameter[9];
                param[0] = new SqlParameter("@CompanyID", obj.Company_ID);
                param[1] = new SqlParameter("@Quater", obj.Quarter);
                param[2] = new SqlParameter("@NatureList", obj.Nature_Sub_ID);
                param[3] = new SqlParameter("@PageIndex", obj.PageIndex);/////set page index
                param[4] = new SqlParameter("@Deductee_Type", obj.Deductee_Type);
                param[5] = new SqlParameter("@PresentVoucherIDs", obj.Deductee_Name);
                param[6] = new SqlParameter("@fromdate", obj.Challan_Date);
                param[7] = new SqlParameter("@todate", obj.Voucher_DT);
                param[8] = new SqlParameter("@PageSize", obj.PageSize );

                //   ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetVoucherList_IEnumrable", param);
                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_Get_VoucherList_IEnumrable", param);

                
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public SqlDataReader DAL_GetVoucherList_Count(tbl_Voucher obj)
        {
            try
            {
                DataSet ds;

                SqlParameter[] param = new SqlParameter[4];
                param[0] = new SqlParameter("@compid", obj.Company_ID);
                param[1] = new SqlParameter("@Quater", obj.Quarter);
                param[2] = new SqlParameter("@NatureList", obj.Nature_Sub_ID);
                param[3] = new SqlParameter("@Deductee_Type", obj.Deductee_Type);

 
                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_GetVoucherList_Count", param);


            }
            catch (Exception)
            {
                throw;
            }
        }


    }
}
