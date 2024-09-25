using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Microsoft.ApplicationBlocks1.Data;
using DataLayer;
using System.Data.SqlClient;
using CommonLibrary;
namespace DataLayer
{
    public class DAL_VoucherEntries_Master : DALCommon
    {
        DataSet ds;
        int result = 0;

        public int Company_ID { get; set; }
        public int Deductee_ID { get; set; }
        public string Nature_Sub_ID { get; set; }
        public DateTime Voucher_DT { get; set; }
        public double Voucher_Amount { get; set; }
        public double TDS_Amt { get; set; }
        public double Surcharge_Amt { get; set; }
        public double ECess_Amt { get; set; }
        public double HECess_Amt { get; set; }
        public decimal TDS_Percentage { get; set; }
        public decimal Surchare_Percentage { get; set; }
        public decimal HECess_Percentage { get; set; }
        public double Total_Tax_Amt { get; set; }
        public string Deductee_Type { get; set; }
        public bool IS_NRI { get; set; }
        public string Reason { get; set; }
        public string Deductee_Name { get; set; }
        public string Quater { get; set; }
        public int Sel { get; set; }
        public string Section { get; set; }
        public string From_Type { get; set; }
        public string PAN_NO { get; set; }
        public string TDS_Certificate { get; set; }
        public string Country_Code { get; set; }
        public string NRI_Code { get; set; }
        public short Remittance_ID { get; set; }
        public string PANVerified { get; set; }
        public bool Threshold_Limit { get; set; }
        public decimal ECess_Percentage { get; set; }
        public int Nature_ID { get; set; }


        public DataSet DAL_BindDeducteeDropDown()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@Deductee_ID", Deductee_ID);
                param[1] = new SqlParameter("@Company_ID", Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_VoucherEntriesBindEditDropDown", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }


        public DataSet DAL_GetMonthNames()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[4];
                param[0] = new SqlParameter("@DeducteeID", Deductee_ID);
                param[1] = new SqlParameter("@Company_ID", Company_ID);
                param[2] = new SqlParameter("@fstart", fstart);
                param[3] = new SqlParameter("@fend", fend);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetMonthNames", param);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public int DAL_InsertVoucherDetails()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[33];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                param[1] = new SqlParameter("@Deductee_ID", Deductee_ID);
                param[2] = new SqlParameter("@Nature_Sub_ID", Nature_Sub_ID);
                param[3] = new SqlParameter("@Voucher_DT", Voucher_DT);
                param[4] = new SqlParameter("@Voucher_Amount", Voucher_Amount);
                param[5] = new SqlParameter("@TDS_Amt", TDS_Amt);
                param[6] = new SqlParameter("@Surcharge_Amt", Surcharge_Amt);
                param[7] = new SqlParameter("@ECess_Amt", ECess_Amt);
                param[8] = new SqlParameter("@HECess_Amt", HECess_Amt);
                param[9] = new SqlParameter("@TDS_Percentage", TDS_Percentage);
                param[10] = new SqlParameter("@Surchare_Percentage", Surchare_Percentage);
                param[11] = new SqlParameter("@ECess_Percentage", ECess_Percentage);
                param[12] = new SqlParameter("@HECess_Percentage", HECess_Percentage);
                param[13] = new SqlParameter("@Total_Tax_Amt", Total_Tax_Amt);
                param[14] = new SqlParameter("@Deductee_Type", Deductee_Type);
                param[15] = new SqlParameter("@IS_NRI", IS_NRI);
                param[16] = new SqlParameter("@Reason", Reason);
                param[17] = new SqlParameter("@Deductee_Name", Deductee_Name);
                param[18] = new SqlParameter("@Quater", Quater);
                param[19] = new SqlParameter("@Sel", Sel);
                param[20] = new SqlParameter("@Section", Section);
                param[21] = new SqlParameter("@From_Type", From_Type);
                param[22] = new SqlParameter("@PAN_NO", PAN_NO);
                param[23] = new SqlParameter("@TDS_Certificate", TDS_Certificate);
                param[24] = new SqlParameter("@Country_Code", Country_Code);
                param[25] = new SqlParameter("@NRI_Code", NRI_Code);
                param[26] = new SqlParameter("@Remittance_ID", Remittance_ID);
                param[27] = new SqlParameter("@PANVerified", PANVerified);
                param[28] = new SqlParameter("@Threshold_Limit", Threshold_Limit);
                param[29] = new SqlParameter("@Nature_ID", Nature_ID);
                param[30] = new SqlParameter("@InvORBillNo", InvORBillNo);
                param[31] = new SqlParameter("@Voucher_ID", Voucher_ID);
                param[32] = new SqlParameter("@BranchID", BranchID);
                result = SqlHelper.ExecuteNonQuery(_cnnString2, CommandType.StoredProcedure, "usp_InsertVoucherEntries", param);
                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }



        public DataSet DAL_BindRemittanceDropDown()
        {
            try
            {
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_BindVoucherEntriesRemittanceDropDown");
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public string InvORBillNo { get; set; }

        public DataSet DAL_Bind()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Deductee_ID", Deductee_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_BindLastVouncherEntries", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet DAL_BindSearchGrid()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[7];
                param[0] = new SqlParameter("@ChallanStatus", ChallanStatus);
                param[1] = new SqlParameter("@Nature_Sub_ID", Nature_Sub_ID);
                param[2] = new SqlParameter("@Section", Section);
                param[3] = new SqlParameter("@Deductee_Name", Deductee_Name);
                param[4] = new SqlParameter("@InvORBillNo", InvORBillNo);
                param[5] = new SqlParameter("@MonthValue", MonthValue);
                param[6] = new SqlParameter("@Company_ID", Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_VoucherEntriesBindSearchgrid", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public string ChallanStatus { get; set; }

        public DateTime FromDate { get; set; }

        public DateTime ToDate { get; set; }

        public DataSet DAL_GetVoucherEntries()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@MonthValue", MonthValue);
                param[1] = new SqlParameter("@Deductee_ID", Deductee_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetVoucherEntriesDetails", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }



        public int Voucher_ID { get; set; }

        public DataSet DAL_VoucherModifyONEdit()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@Voucher_ID", Voucher_ID);
                param[1] = new SqlParameter("@Company_ID", Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_VoucherModifyOnEdit", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public int DAL_DeleteVoucher()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Voucher_ID", Voucher_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_VoucherIDDelete", param);
                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public int MonthValue { get; set; }


        public DataSet DAL_GetSalbValues()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@NatureSunId", Nature_Sub_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_getSlabValuesVoucherEntries", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet DAL_GetSalbValues_20()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@NatureSunId", Nature_Sub_ID);
                param[1] = new SqlParameter("@CurrDate", Voucher_DT);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_getSlabValuesVoucherEntries_20", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet DAL_GetLastRec()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetLastRecords", param);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }



        public SqlDataReader DAL_GetDropDowns(tbl_VoucherDropDowns tobj)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[6];
                param[0] = new SqlParameter("@DeducteeID", tobj.did);
                param[1] = new SqlParameter("@Company_ID", tobj.compid);
                param[2] = new SqlParameter("@fstart", tobj.ST);
                param[3] = new SqlParameter("@fend", tobj.ED);
                param[4] = new SqlParameter("@form", tobj.FormType);
                param[5] = new SqlParameter("@Quater", tobj.Quater);
                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "Usp_Get_DropDowns1", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public SqlDataReader DAL_GetTypeAhead(tbl_DeducteeList tobj)
        {
            SqlParameter[] param = new SqlParameter[3];

            param[0] = new SqlParameter("@Company_ID", tobj.compaid);
            param[1] = new SqlParameter("@Deductee", tobj.Dname);
            param[2] = new SqlParameter("@Form", tobj.Form);

            return SqlHelper.ExecuteReader(_cnnString, CommandType.StoredProcedure, "Usp_Get_typeHead", param);
        }

        public SqlDataReader DAL_Get_Nature_Branch_Drp(tbl_VoucherDropDowns tobj)
        {
            SqlParameter[] param = new SqlParameter[5];
            param[0] = new SqlParameter("@DeducteeID", tobj.did);
            param[1] = new SqlParameter("@Company_ID", tobj.compid);
            param[2] = new SqlParameter("@fstart", tobj.ST);
            param[3] = new SqlParameter("@fend", tobj.ED);
            param[4] = new SqlParameter("@form", tobj.FormType);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "Usp_Get_Nature_Branch_Drp1", param);
        }

        public SqlDataReader DAL_Modify_Chln_Vchr_Grd(tbl_VoucherModifyGrd tobj)
        {
            SqlParameter[] param = new SqlParameter[6];

            param[0] = new SqlParameter("@Nature_ID", tobj.nid );
            param[1] = new SqlParameter("@Challan_ID", tobj.Chid);
            param[2] = new SqlParameter("@Company_ID", tobj.compid);
            param[3] = new SqlParameter("@pageIndex", tobj.pageIndex);
            param[4] = new SqlParameter("@pageSize", tobj.pageSize);
            param[5] = new SqlParameter("@Deductee_ID", tobj.did);


            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_Challan_Voucher_ModifyGrd", param);
        }

        public SqlDataReader DAL_ModifyGrd(tbl_VoucherModifyGrd tobj)
        {
            SqlParameter[] param = new SqlParameter[10];
            param[0] = new SqlParameter("@ChallanStatus", tobj.CPaid);
            param[1] = new SqlParameter("@Nature_ID", tobj.nid);
            param[2] = new SqlParameter("@Deductee_ID", tobj.did);
            param[3] = new SqlParameter("@MonthValue", tobj.mthno);
            param[4] = new SqlParameter("@Company_ID", tobj.compid);
            param[5] = new SqlParameter("@pageIndex", tobj.pageIndex);
            param[6] = new SqlParameter("@pageSize", tobj.pageSize);
            param[7] = new SqlParameter("@UP", tobj.UPaid);
            param[8] = new SqlParameter("@fltr", tobj.form_type);
            param[9] = new SqlParameter("@Q", tobj.Quater);

            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_Voucher_ModifyGrd1", param);
        }

        public SqlDataReader DAL_Modify(tbl_VoucherModify tobj)
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@Voucher_ID", tobj.vid);
            param[1] = new SqlParameter("@Company_ID", tobj.compid);

            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_VoucherModifyOnEdit1", param);
        }


        public SqlDataReader DAL_InsertVoucher(tbl_VoucherModify tobj)
        {
            try
            {
                // Voucher_DT = Convert.ToDateTime(tobj.PDate);
                SqlParameter[] param = new SqlParameter[36];
                param[0] = new SqlParameter("@Company_ID", tobj.compid);             //
                param[1] = new SqlParameter("@Deductee_ID", tobj.did);           //
                param[2] = new SqlParameter("@Nature_Sub_ID", tobj.nsid);       //
                param[3] = new SqlParameter("@Voucher_DT", tobj.VDT);             //    
                param[4] = new SqlParameter("@Voucher_Amount", tobj.AmtPaid);     //
                param[5] = new SqlParameter("@TDS_Amt", tobj.TdsAmt);                   //
                param[6] = new SqlParameter("@Surcharge_Amt", tobj.Sur);       //
                param[7] = new SqlParameter("@ECess_Amt", tobj.Cess);               //

                param[8] = new SqlParameter("@TDS_Percentage", tobj.Rate);     //

                param[9] = new SqlParameter("@Total_Tax_Amt", tobj.Total);       //
                param[10] = new SqlParameter("@Deductee_Type", tobj.tid);      //
                param[11] = new SqlParameter("@IS_NRI", tobj.isNri);                    //
                param[12] = new SqlParameter("@Reason", tobj.rsid);                    //    

                param[13] = new SqlParameter("@Quater", tobj.Quater);
                param[14] = new SqlParameter("@Sel", tobj.sel);                         //

                param[15] = new SqlParameter("@From_Type", tobj.formType);              //
                param[16] = new SqlParameter("@PAN_NO", tobj.PAN);                    //
                param[17] = new SqlParameter("@TDS_Certificate", tobj.Cert);  // 


                param[18] = new SqlParameter("@Remittance_ID", tobj.rid);      //

                param[19] = new SqlParameter("@Threshold_Limit", tobj.Thold);  //
                param[20] = new SqlParameter("@Nature_ID", tobj.nid);              //  
                param[21] = new SqlParameter("@InvORBillNo", tobj.Invid);          //
                param[22] = new SqlParameter("@Voucher_ID", tobj.vid);            //
                param[23] = new SqlParameter("@BranchID", tobj.Bid);                //
                param[24] = new SqlParameter("@DName", tobj.DName);
                param[25] = new SqlParameter("@Add1", tobj.Add1);
                param[26] = new SqlParameter("@Email", tobj.Emailid);
                param[27] = new SqlParameter("@Ctno", tobj.Contactno);
                param[28] = new SqlParameter("@NriTDSRT", tobj.NriTDSRT);
                param[29] = new SqlParameter("@TaxId", tobj.TaxId);
                param[30] = new SqlParameter("@CountryId", tobj.CountryId);
                param[31] = new SqlParameter("@eqNri", tobj.eqNri);
                param[32] = new SqlParameter("@eqInd", tobj.eqInd);
                param[33] = new SqlParameter("@Chl", tobj.ChlDtls);
                param[34] = new SqlParameter("@BAC1A", tobj.BAC1A);
                param[35] = new SqlParameter("@PChar", tobj.PChar);

                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_InsertVoucher_New", param);

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public SqlDataReader DAL_BindDeductee_Details(tbl_DeducteeDetails tobj)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@Deductee_ID", tobj.did);
                param[1] = new SqlParameter("@Company_ID", tobj.compid);
                param[2] = new SqlParameter("@formType", tobj.formType);
                //return SqlHelper.ExecuteReader(_cnnString, CommandType.StoredProcedure, "usp_VoucherEntriesBindEditDropDown", param);
                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_VoucherEntries_DeducteeDetails1", param);
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }


        public SqlDataReader DAL_Section_Modify(tbl_VoucherModify tobj)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@Company_ID", tobj.compid);
                param[1] = new SqlParameter("@RT", tobj.RT);
                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "Usp_Save_Sections", param);

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public SqlDataReader DAL_BindDeductee_Rate(tbl_DeducteeRate tobj)
        {
            try
            {
                // Voucher_DT = Convert.ToDateTime(tobj.PDate);  

                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@NatureSunId", tobj.nsid);
                param[1] = new SqlParameter("@CurrDate", tobj.VDT);
                int i = 0;
                i = Convert.ToInt32(tobj.ST);
                string SP = "";
                if (i >= 2020)
                {
                    SP = "usp_getSlabValuesVoucherEntries_20";
                }
                else
                {
                    SP = "usp_getSlabValuesVoucherEntries";
                }
                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, SP, param);

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }


        public SqlDataReader DAL_LastGrd(tbl_VoucherModifyGrd tobj)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@Company_ID", tobj.compid);
                param[1] = new SqlParameter("@DeducteeID", tobj.did);
                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_GetLastRecords", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public SqlDataReader DAL_FillGrd(tbl_VoucherGrd tobj)
        {
            SqlParameter[] param = new SqlParameter[6];
            param[0] = new SqlParameter("@DeducteeID", tobj.did);
            param[1] = new SqlParameter("@Company_ID", tobj.compid);
            param[2] = new SqlParameter("@fstart", tobj.ST);
            param[3] = new SqlParameter("@fend", tobj.ED);
            param[4] = new SqlParameter("@form", tobj.Ftyp);
            param[5] = new SqlParameter("@Quater", tobj.Qtr);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "Usp_Get_VoucherGrd1", param);
        }

        public SqlDataReader DAL_Delete_Voucher(tbl_VoucherModifyGrd tobj)
        {
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@PaidVoucher_ID", tobj.CPaid);
            param[1] = new SqlParameter("@NonPaidVoucher_ID", tobj.nsid);
            param[2] = new SqlParameter("@compid", tobj.compid);

            //return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_Voucher_Delete", param);
            //////// Remove Voucher from Challan
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_Voucher_Delete", param);
        }


        public SqlDataReader DAL_ImportDeductee(tbl_VoucherModify tobj)
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@Company_ID ", tobj.compid);
            param[1] = new SqlParameter("@Vouchertable ", tobj.DName);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_InsertUpdateImportVoucherData", param);
        }

        public SqlDataReader DAL_SaveToken(tbl_VoucherGrd tobj)
        {
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@compid", tobj.compid);
            param[1] = new SqlParameter("@TokenNo", tobj.Tokenid);
            param[2] = new SqlParameter("@Qtr", tobj.Qtr);
            param[3] = new SqlParameter("@ftype", tobj.Ftyp);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_Insert_TokenNo", param);
        }

        public SqlDataReader DAL_GetTracesDetails(tbl_TracesDetail tobj)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@compid", tobj.Compid);

            return SqlHelper.ExecuteReader(_cnnString, CommandType.StoredProcedure, "usp_GetTracesDetails", param);
        }

        public SqlDataReader DAL_TracesDetailsSave(tbl_TracesDetail tobj)
        {
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@compid", tobj.Compid);
            param[1] = new SqlParameter("@TAN", tobj.TAN);
            param[2] = new SqlParameter("@Userid", tobj.Userid);
            param[3] = new SqlParameter("@Password", tobj.Password);
            return SqlHelper.ExecuteReader(_cnnString, CommandType.StoredProcedure, "usp_Insert_TracesDetails", param);
        }

        public SqlDataReader DAL_NonSalaryValidation(MisMatch_Vouchers obj)
        {
            string proc = "";
            if (obj.FromType == "26Q")
            {
                proc = "usp_GetNonSalaryValidation";
            }
            if (obj.FromType == "27Q")
            {
                proc = "usp_GetNonSalaryValidation_27Q";
            }
            if (obj.FromType == "27EQ")
            {
                proc = "usp_GetNonSalaryValidation_27EQ";
            }
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@Company_ID", obj.Compid);
            param[1] = new SqlParameter("@Quater", obj.Quater);
            param[2] = new SqlParameter("@FromType", obj.FromType);

            //ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetNonSalaryValidation", param);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, proc, param);
        }

        public SqlDataReader DAL_UpdateBAC(MisMatch_BAC obj)
        {

            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@Company_ID", obj.Compid);
            param[1] = new SqlParameter("@Quater", obj.Quater);
            param[2] = new SqlParameter("@FromType", obj.FromType);
            param[3] = new SqlParameter("@TBac", obj.TBAC);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_Update_BAC1A", param);
        }

        public SqlDataReader DAL_UpdateDType(MisMatch_DType obj)
        {
            DataSet ds;
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@Company_ID", obj.Compid);
            param[1] = new SqlParameter("@Quater", obj.Quater);
            param[2] = new SqlParameter("@FromType", obj.FromType);
            param[3] = new SqlParameter("@TBac", obj.DType);
            ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_Update_DeducteeType", param);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_Update_DeducteeType", param);
        }

        public SqlDataReader DAL_Get_PANNoList(TracesInfo obj)
        {

            SqlParameter[] param = new SqlParameter[4];

            param[0] = new SqlParameter("@Company_id", obj.Compid);
            param[1] = new SqlParameter("@Quarter", obj.Quarter);
            param[2] = new SqlParameter("@FormType", obj.FormType);
            param[3] = new SqlParameter("@indication", 1);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_Get_PanNo", param);
        }

        public SqlDataReader DAL_Deductee_ReportGrid(tbl_DeducteeReport tobj)
        {
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@Company_ID", tobj.Compid);
            param[1] = new SqlParameter("@FromType", tobj.FromType);
            param[2] = new SqlParameter("@fromdate", tobj.From);
            param[3] = new SqlParameter("@todate", tobj.To);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_DeducteeReportGrid", param);
        }


        public SqlDataReader DAL_TDS_ReportGrid(tbl_DeducteeReport tobj)
        {
            SqlParameter[] param = new SqlParameter[5];
            param[0] = new SqlParameter("@Company_ID", tobj.Compid);
            param[1] = new SqlParameter("@FromType", tobj.FromType);
            param[2] = new SqlParameter("@fromdate", tobj.From);
            param[3] = new SqlParameter("@todate", tobj.To);
            param[4] = new SqlParameter("@rdio", tobj.rdio);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_TDSSummaryReportGrid", param);
        }


        public SqlDataReader DAL_ListPANStatus(tbl_VoucherModify obj)
        {

            SqlParameter[] param = new SqlParameter[6];

            param[0] = new SqlParameter("@Company_id", obj.compid);
            param[1] = new SqlParameter("@Quarter", obj.Quater);
            param[2] = new SqlParameter("@FormType", obj.formType);
            param[3] = new SqlParameter("@indication", obj.PAN_AAdhar);
            param[4] = new SqlParameter("@PageIndex", obj.pageIndex);
            param[5] = new SqlParameter("@PageSize", obj.pageSize);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_Voucher_PANStatus", param);
        }

        public SqlDataReader DAL_ListPANSummary(PANNo obj)
        {

            SqlParameter[] param = new SqlParameter[4];

            param[0] = new SqlParameter("@Company_id", obj.Compid);
            param[1] = new SqlParameter("@Quarter", obj.Quarter);
            param[2] = new SqlParameter("@FormType", obj.FormType);
            param[3] = new SqlParameter("@indication", obj.PAN_AAdhar);

            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_Voucher_PANSummary", param);
        }

        public string fstart { get; set; }

        public string fend { get; set; }

        public int BranchID { get; set; }
    }
}
