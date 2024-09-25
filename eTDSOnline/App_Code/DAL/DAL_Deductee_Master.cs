using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;
using System.Data;
using Microsoft.ApplicationBlocks1.Data;
using System.Data.SqlClient;

namespace DataLayer
{
    public class DAL_Deductee_Master : DALCommon
    {
        public int Company_ID { get; set; }
        public string Deductee_Type { get; set; }
        public string Deductee_Name { get; set; }
        public string Alias { get; set; }
        public string PAN_NO { get; set; }
        public string Flat_NO { get; set; }
        public string Bldg_Name { get; set; }
        public string Street { get; set; }
        public string City { get; set; }
        public int State_ID { get; set; }
        public int Pincode { get; set; }
        public int Branch_ID { get; set; }
        public string Email { get; set; }
        public string Mobile_No { get; set; }
        public int Nature_ID { get; set; }
        public bool IS_Individual { get; set; }
        public bool Multi_Company { get; set; }
        public string Reasons { get; set; }
        public string Certificate_NO { get; set; }
        public bool IS_NRI { get; set; }
        public int Country_ID { get; set; }
        public string NRI_TDS_Rate { get; set; }
        public double TDS_Rate { get; set; }
        public double Surcharge { get; set; }
        public string Nature_Sub_ID { get; set; }
        public string TDS_Rate_From { get; set; }

        DataSet ds;
        int result = 0;
        public DataSet DAL_BindDropDown()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_DeducteeDropDown", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet DAL_BindDetucteeGrid()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Deductee_ID", 0);
                ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_BindDetucteeGrid", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public int DAL_InsertDetucteeDetails()
        {

            try
            {
                SqlParameter[] param = new SqlParameter[30];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                param[1] = new SqlParameter("@Deductee_Name", Deductee_Name);
                param[2] = new SqlParameter("@Alias", Alias);
                param[3] = new SqlParameter("@PAN_NO", PAN_NO);
                param[4] = new SqlParameter("@Flat_NO", Flat_NO);
                param[5] = new SqlParameter("@Bldg_Name", Bldg_Name);
                param[6] = new SqlParameter("@Street    ", Street);
                param[7] = new SqlParameter("@City", City);
                param[8] = new SqlParameter("@State_ID", State_ID);
                param[9] = new SqlParameter("@Pincode", Pincode);
                param[10] = new SqlParameter("@Branch_ID", Branch_ID);
                param[11] = new SqlParameter("@Email", Email);
                param[12] = new SqlParameter("@Mobile_No", Mobile_No);
                param[13] = new SqlParameter("@Nature_ID", Nature_ID);
                param[14] = new SqlParameter("@Deductee_Type", Deductee_Type);
                param[15] = new SqlParameter("@IS_Individual", IS_Individual);
                param[16] = new SqlParameter("@Multi_Company", Multi_Company);
                param[17] = new SqlParameter("@Reasons", Reasons);
                param[18] = new SqlParameter("@Certificate_NO", Certificate_NO);
                param[19] = new SqlParameter("@IS_NRI", IS_NRI);
                param[20] = new SqlParameter("@Country_ID", Country_ID);
                param[21] = new SqlParameter("@NRI_TDS_Rate", NRI_TDS_Rate);
                param[22] = new SqlParameter("@TDS_Rate_From", TDS_Rate_From);
                param[23] = new SqlParameter("@TDS_Rate", TDS_Rate);
                param[24] = new SqlParameter("@Surcharge", Surcharge);
                param[25] = new SqlParameter("@Nature_Sub_ID", Nature_Sub_ID);
                param[26] = new SqlParameter("@Deductee_ID", Deductee_ID);
                param[27] = new SqlParameter("@PANVerified", PANVerified);
                param[28] = new SqlParameter("@ContactNo", ContactNo);
                param[29] = new SqlParameter("@TaxIdentificationNo", TaxIdentificationNo);
                result = SqlHelper.ExecuteNonQuery(_cnnString, CommandType.StoredProcedure, "usp_InsertDetucteeDetails", param);
                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }


        public int Deductee_ID { get; set; }

        public DataSet DAL_GetDeducteeEditDetails()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Deductee_ID", Deductee_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_BindDetucteeGrid", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public int DAL_DeleteDeducteeID()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Deductee_ID", Deductee_ID);
                result = SqlHelper.ExecuteNonQuery(_cnnString2, CommandType.StoredProcedure, "usp_DeteletDeducteeDetails", param);
                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }



        public string PANVerified { get; set; }


        public DataSet DAL_BindDetucteeGridOnSearch()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[5];
                param[0] = new SqlParameter("@Deductee_Name", Deductee_Name);
                param[1] = new SqlParameter("@Alias", Alias);
                param[2] = new SqlParameter("@PANVerified", PANVerified);
                param[3] = new SqlParameter("@Reasons", Reasons);
                param[4] = new SqlParameter("@Company_ID", Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_DeducteeSearchOnBindGrid", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet DAL_CheckDuplicateDeducteeName()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@Deductee_Name", Deductee_Name);
                param[1] = new SqlParameter("@Company_ID", Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_CheckDeducteeDuplicateName", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataTable DeduceteePanTable { get; set; }

        public int DAL_PANVerificationDetuctee()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                param[1] = new SqlParameter("@DeduceteePanTable", DeduceteePanTable);
                int result = SqlHelper.ExecuteNonQuery(_cnnString, CommandType.StoredProcedure, "usp_PANVerificationDetuctee", param);
                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public string TaxIdentificationNo { get; set; }

        public string ContactNo { get; set; }
    }
}
