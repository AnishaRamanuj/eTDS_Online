using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;
using CommonLibrary;
using System.Data.SqlClient;
using System.Globalization;
using System.Data;

namespace BusinessLayer
{

    public class BAL_Deductee_Master : CommonFunctions
    {
        DAL_Deductee_Master objDAL_Deductee_Master = new DAL_Deductee_Master();
        PANNo objPan = new PANNo();
        DataSet ds;

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

        int result = 0;

        public DataSet BAL_BindDropDown()
        {
            try
            {
                objDAL_Deductee_Master.Company_ID = Company_ID;
                ds = objDAL_Deductee_Master.DAL_BindDropDown();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet BAL_BindDetucteeGrid()
        {
            try
            {
                ds = objDAL_Deductee_Master.DAL_BindDetucteeGrid();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public int BAL_InsertDetucteeDetails()
        {

            try
            {
                objDAL_Deductee_Master.Company_ID = Company_ID;
                objDAL_Deductee_Master.Deductee_Name = Deductee_Name;
                objDAL_Deductee_Master.Alias = Alias;
                objDAL_Deductee_Master.PAN_NO = PAN_NO;
                objDAL_Deductee_Master.Flat_NO = Flat_NO;
                objDAL_Deductee_Master.Bldg_Name = Bldg_Name;
                objDAL_Deductee_Master.Street = Street;
                objDAL_Deductee_Master.City = City;
                objDAL_Deductee_Master.State_ID = State_ID;
                objDAL_Deductee_Master.Pincode = Pincode;
                objDAL_Deductee_Master.Branch_ID = Branch_ID;
                objDAL_Deductee_Master.Email = Email;
                objDAL_Deductee_Master.Mobile_No = Mobile_No;
                objDAL_Deductee_Master.Nature_ID = Nature_ID;
                objDAL_Deductee_Master.Deductee_Type = Deductee_Type;
                objDAL_Deductee_Master.IS_Individual = IS_Individual;
                objDAL_Deductee_Master.Multi_Company = Multi_Company;
                objDAL_Deductee_Master.Reasons = Reasons;
                objDAL_Deductee_Master.Certificate_NO = Certificate_NO;
                objDAL_Deductee_Master.IS_NRI = IS_NRI;
                objDAL_Deductee_Master.Country_ID = Country_ID;
                objDAL_Deductee_Master.NRI_TDS_Rate = NRI_TDS_Rate;
                objDAL_Deductee_Master.TDS_Rate = TDS_Rate;
                objDAL_Deductee_Master.Surcharge = Surcharge;
                objDAL_Deductee_Master.Nature_Sub_ID = Nature_Sub_ID;
                objDAL_Deductee_Master.TDS_Rate_From = TDS_Rate_From;
                objDAL_Deductee_Master.Deductee_ID = Deductee_ID;
                objDAL_Deductee_Master.PANVerified = PANVerified;
                objDAL_Deductee_Master.TaxIdentificationNo = TaxIdentificationNo;
                objDAL_Deductee_Master.ContactNo = ContactNo;
                result = objDAL_Deductee_Master.DAL_InsertDetucteeDetails();
                return result;
            }
            catch (Exception)
            {

                throw;
            }
        }


        public int Deductee_ID { get; set; }

        public DataSet BAL_GetDeducteeEditDetails()
        {
            try
            {
                objDAL_Deductee_Master.Deductee_ID = Deductee_ID;
                ds = objDAL_Deductee_Master.DAL_GetDeducteeEditDetails();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public int BAL_DeleteDeducteeID()
        {
            try
            {
                objDAL_Deductee_Master.Deductee_ID = Deductee_ID;
                result = objDAL_Deductee_Master.DAL_DeleteDeducteeID();
                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public string PANVerified { get; set; }


        public DataSet BAL_BindDetucteeGridOnSearch()
        {
            try
            {
                objDAL_Deductee_Master.Deductee_Name = Deductee_Name;
                objDAL_Deductee_Master.Alias = Alias;
                objDAL_Deductee_Master.PANVerified = PANVerified;
                objDAL_Deductee_Master.Reasons = Reasons;
                objDAL_Deductee_Master.Company_ID = Company_ID;
                ds = objDAL_Deductee_Master.DAL_BindDetucteeGridOnSearch();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet BAL_CheckDuplicateDeducteeName()
        {
            try
            {
                objDAL_Deductee_Master.Deductee_Name = Deductee_Name;
                objDAL_Deductee_Master.Company_ID = Company_ID;
                ds = objDAL_Deductee_Master.DAL_CheckDuplicateDeducteeName();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public int BAL_PANVerificationDetuctee()
        {
            try
            {
                objDAL_Deductee_Master.Company_ID = Company_ID;
                objDAL_Deductee_Master.DeduceteePanTable = DeduceteePanTable;
                int result = objDAL_Deductee_Master.DAL_PANVerificationDetuctee();
                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public IEnumerable<PANNo> BAL_PANVerfy(bool VPan, string r1)
        {
            List<PANNo> obj_PAN = new List<PANNo>();
            try
            {
                obj_PAN.Add(new PANNo()
                {
                    PAN = GetValue<string>(r1.ToString()),
                    PVerify = GetValue<bool>(VPan.ToString()),
                });

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return obj_PAN as IEnumerable<PANNo>;
        }

        public DataTable DeduceteePanTable { get; set; }

        public string ContactNo { get; set; }

        public string TaxIdentificationNo { get; set; }
    }
}
