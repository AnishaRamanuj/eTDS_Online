using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_EReturns_NonSalary : DALCommon
    {
        public int Company_ID { get; set; }

        public string Quater { get; set; }

        public string FromType { get; set; }
        public DateTime CurDate { get; set; }

        public DataSet DAL_GetNonSalaryNRI()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                param[1] = new SqlParameter("@Quater", Quater);
                param[2] = new SqlParameter("@FromType", FromType);
                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetNonSalary_NRI", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet DAL_GetNonSalaryEreturnsDetails()
        {
            try
            {

                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                param[1] = new SqlParameter("@Quater", Quater);
                param[2] = new SqlParameter("@FromType", FromType);
                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetNonSalaryEreturnsDetails", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet DAL_GetNonSalaryEreturnsDetails_27EQ()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                param[1] = new SqlParameter("@Quater", Quater);
                param[2] = new SqlParameter("@FromType", FromType);
                //DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetNonSalaryEreturnsDetails", param);
                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_eReturnsNonSalary27EQ", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet DAL_NonSalaryValidation()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                param[1] = new SqlParameter("@Quater", Quater);
                param[2] = new SqlParameter("@FromType", FromType);

                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetNonSalaryValidation", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet DAL_getTotalChallan_NonSalary()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                param[1] = new SqlParameter("@Quater", Quater);
                param[2] = new SqlParameter("@FromType", FromType);
                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_NonSalary_TotalChallan", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet DAL_getnonsalarydetails()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@companyID", Company_ID);
                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_challan_voucher", param);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet DAL_getsalarydetails()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@companyID", Company_ID);
                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_challan_salary", param);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public int Formno { get; set; }

        public string Form { get; set; }

        public string PreviousTkn { get; set; }

        public string aYear { get; set; }

        public string PreviousRTN { get; set; }

        public string fYear { get; set; }

        public DataSet DAL_GenerateTextFile()
        {
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[8];
                objSqlParameter[0] = new SqlParameter("@Company_ID", Company_ID);
                objSqlParameter[1] = new SqlParameter("@Formno", Formno);
                objSqlParameter[2] = new SqlParameter("@Form", Form);
                objSqlParameter[3] = new SqlParameter("@PreviousTkn", PreviousTkn);
                objSqlParameter[4] = new SqlParameter("@PreviousRTN", PreviousRTN);
                objSqlParameter[5] = new SqlParameter("@aYear", aYear);
                objSqlParameter[6] = new SqlParameter("@fYear", fYear);
                objSqlParameter[7] = new SqlParameter("@Quater", Quater);
                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_eReturnsNonSalary" + Form, objSqlParameter);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet DAL_NonSalaryEretursDetailsOnPageLoad()
        {
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Company_ID", Company_ID);
                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_NonSalaryEretursDetailsOnPageLoad" + Form, objSqlParameter);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public DataSet DAL_EretursDates()
        {
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Curdt", CurDate);
                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_EReturn_QuarterFY", objSqlParameter);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string filetype { get; set; }
        public string Fcreatdate { get; set; }
        public string TAN { get; set; }
        public string Challancnt { get; set; }
        public string FormNo { get; set; }
        public string PANNo { get; set; }
        public string Period { get; set; }
        public string CompanyName { get; set; }
        public string TokenNo { get; set; }
        public string Dectuctor { get; set; }
        public string FinYear { get; set; }
        public string CDRecNo { get; set; }
        public string BnkChlNo { get; set; }
        public string BSR { get; set; }
        public string ToDepoAmt { get; set; }
        public string TDepodeductee { get; set; }
        public string IntDed { get; set; }
        public string ChallaneDate { get; set; }
        public string isChallaneMatch { get; set; }

        public string LineNo { get; set; }
        public string DDRecNo { get; set; }
        public string DedCode { get; set; }
        public string PAN { get; set; }
        public string PartyName { get; set; }
        public string Itax { get; set; }
        public string Surcharge { get; set; }
        public string Cess { get; set; }
        public string TaxDed { get; set; }
        public string TaxDepo { get; set; }
        public string AmtPaid { get; set; }
        public string PaidDate { get; set; }
        public string DedDate { get; set; }
        public string Rate { get; set; }
        public string Remarks1 { get; set; }
        public string TDSSECTION { get; set; }
        public string isPANValidationReq { get; set; }
        public string Challan_DueDate { get; set; }
        public string PAN_Status { get; set; }
        public string DelayedDedMonth { get; set; }
        public string DelayedDepMonth { get; set; }
        public string Total_Interest { get; set; }
        public string DelayedDedAmt { get; set; }
        public string Chl_date { get; set; }
        public string Deductee_Status { get; set; }
        public string Prescribed_Rate { get; set; }
        public int Short_DedAmt { get; set; }
        public int jAmt { get; set; }
        public int id { get; set; }
        public string Reason1 { get; set; }
        public string StrForm { get; set; }
        public string Quarter { get; set; }

        public DataSet DAL_DNFHeader()
        {
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[3];
                objSqlParameter[0] = new SqlParameter("@Filetype", filetype);
                objSqlParameter[1] = new SqlParameter("@FCreationDate", Fcreatdate);
                objSqlParameter[2] = new SqlParameter("@Tan", TAN);
                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_Insert_DNF_FileHeader" + Form, objSqlParameter);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet DAL_DNFBatch()
        {
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[9];
                objSqlParameter[0] = new SqlParameter("@Challancnt", Challancnt);
                objSqlParameter[1] = new SqlParameter("@FormNo", FormNo);
                objSqlParameter[2] = new SqlParameter("@TAN", TAN);
                objSqlParameter[3] = new SqlParameter("@PANNo", PANNo);
                objSqlParameter[4] = new SqlParameter("@FinYear", FinYear);
                objSqlParameter[5] = new SqlParameter("@Period", Period);
                objSqlParameter[6] = new SqlParameter("@CompanyName", CompanyName);
                objSqlParameter[7] = new SqlParameter("@TokenNo", TokenNo);
                objSqlParameter[8] = new SqlParameter("@Deductor_Type", Dectuctor);
                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_Insert_DNF_Batch" + Form, objSqlParameter);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet DAL_DNFChallan()
        {
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[8];
                objSqlParameter[0] = new SqlParameter("@CDRecNo", CDRecNo);
                objSqlParameter[1] = new SqlParameter("@BnkChlNo", BnkChlNo);
                objSqlParameter[2] = new SqlParameter("@ToDepoAmt", ToDepoAmt);
                objSqlParameter[3] = new SqlParameter("@TDepodeductee", TDepodeductee);
                objSqlParameter[4] = new SqlParameter("@BSR", BSR);
                objSqlParameter[5] = new SqlParameter("@IntDed", IntDed);
                objSqlParameter[6] = new SqlParameter("@ChallaneDate", ChallaneDate);
                objSqlParameter[7] = new SqlParameter("@isChallaneMatch", isChallaneMatch);
                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_Insert_DNF_Challan" + Form, objSqlParameter);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet DAL_DNFDedDetail()
        {
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[26];
                objSqlParameter[0] = new SqlParameter("@LineNo", LineNo);
                objSqlParameter[1] = new SqlParameter("@CDRecNo", CDRecNo);
                objSqlParameter[2] = new SqlParameter("@DDRecNo", DDRecNo);
                objSqlParameter[3] = new SqlParameter("@DedCode", DedCode);
                objSqlParameter[4] = new SqlParameter("@PAN", PAN);
                objSqlParameter[5] = new SqlParameter("@PartyName", PartyName);
                objSqlParameter[6] = new SqlParameter("@Itax", Itax);
                objSqlParameter[7] = new SqlParameter("@Surcharge", Surcharge);
                objSqlParameter[8] = new SqlParameter("@Cess", Cess);
                objSqlParameter[9] = new SqlParameter("@TaxDed", TaxDed);
                objSqlParameter[10] = new SqlParameter("@TaxDepo", TaxDepo);
                objSqlParameter[11] = new SqlParameter("@AmtPaid", AmtPaid);
                objSqlParameter[12] = new SqlParameter("@PaidDate", PaidDate);
                objSqlParameter[13] = new SqlParameter("@DedDate", DedDate);
                objSqlParameter[14] = new SqlParameter("@Rate", Rate);
                objSqlParameter[15] = new SqlParameter("@Remarks1", Remarks1);
                objSqlParameter[16] = new SqlParameter("@TDSSECTION", TDSSECTION);
                objSqlParameter[17] = new SqlParameter("@Challan_DueDate", Challan_DueDate);
                objSqlParameter[18] = new SqlParameter("@isPANValidationReq", isPANValidationReq);
                objSqlParameter[19] = new SqlParameter("@PAN_Status", PAN_Status);
                objSqlParameter[20] = new SqlParameter("@Deductee_Status", Deductee_Status);
                objSqlParameter[21] = new SqlParameter("@DelayedDedMonth", DelayedDedMonth);
                objSqlParameter[22] = new SqlParameter("@DelayedDepMonth", DelayedDepMonth);
                objSqlParameter[23] = new SqlParameter("@Total_Interest", Total_Interest);
                objSqlParameter[24] = new SqlParameter("@DelayedDedAmt", DelayedDedAmt);
                objSqlParameter[25] = new SqlParameter("@Chl_date", Chl_date);
                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_Insert_DNF_DedDetail", objSqlParameter);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet DAL_DNFCalc()
        {
            try
            {
                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_Insert_DNF_DedDetailCalc");
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet DAL_DNFUpdatePR()
        {
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[6];
                objSqlParameter[0] = new SqlParameter("@id", id);
                objSqlParameter[1] = new SqlParameter("@LineNo", LineNo);
                objSqlParameter[2] = new SqlParameter("@Prescribed_Rate", Prescribed_Rate);
                objSqlParameter[3] = new SqlParameter("@Short_DedAmt", Short_DedAmt);
                objSqlParameter[4] = new SqlParameter("@jAmt", jAmt);
                objSqlParameter[5] = new SqlParameter("@Reason1", Reason1);
                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_Insert_DNF_UpdatePR", objSqlParameter);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet DAL_DNF_SummaryXL()
        {
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];
                objSqlParameter[0] = new SqlParameter("@StrForm", StrForm);
                objSqlParameter[1] = new SqlParameter("@Quarter", Quarter);
                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_DNFSummaryXL", objSqlParameter);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
