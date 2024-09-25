using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_ManageCompany : DALCommon
    {
        int result = 0;
        DataSet ds;
        public int Company_ID { get; set; }
        public int Parent_ID { get; set; }
        public string CompanyName { get; set; }

        public string Flat_No { get; set; }

        public string Name_Of_Building { get; set; }

        public string Street { get; set; }

        public string Area_Location { get; set; }

        public string Town_City { get; set; }

        public string EmailID { get; set; }

        public string Status { get; set; }

        public string IClass { get; set; }

        public int Pincode { get; set; }

        public string STD_code { get; set; }

        public string Tel_NO { get; set; }

        public string Fax { get; set; }

        public string TANNo { get; set; }

        public string PANNo { get; set; }

        public string Place { get; set; }

        public string Alt_EmailID { get; set; }

        public string Alt_Tel_NO { get; set; }

        public string Alt_STDcode { get; set; }

        public bool Change_Deductor { get; set; }

        public string R_Name { get; set; }

        public string R_Flat_NO { get; set; }

        public string R_Building { get; set; }

        public string R_Street { get; set; }

        public string R_Area_Location { get; set; }

        public string R_Town_City { get; set; }

        public string R_EmailID { get; set; }

        public string R_Designation { get; set; }

        public int R_StateID { get; set; }

        public string R_Mobile_NO { get; set; }

        public string R_Pincode { get; set; }

        public string R_STD_Code { get; set; }

        public string R_Tel_NO { get; set; }

        public string R_Fax { get; set; }

        public bool Change_Responsible { get; set; }

        public string ALT_R_EmailID { get; set; }

        public string ALT_R_Tel_NO { get; set; }

        public string ALT_R_STD_Code { get; set; }

        public string GSTN { get; set; }


        public DataSet DAL_BindCompanyGrid()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_GetCompanyDetails", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet DAL_BindRegisterCompanyGrid()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_GetRegisterdCompany", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet DAL_ParentDetails()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Parent_ID", Parent_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_Get_ParentDetails", param);
                return ds;


            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet DAL_CompanyCount()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Parent_ID", Parent_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_Get_CompanyCount", param);
                return ds;

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet DAL_EditCompanyDetails()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_GetCompanyDetails", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public int DAL_UpdateCompanyDetails()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[47];
                param[0] = new SqlParameter("@CompanyName", CompanyName);
                param[1] = new SqlParameter("@Flat_No", Flat_No);
                param[2] = new SqlParameter("@Name_Of_Building", Name_Of_Building);
                param[3] = new SqlParameter("@Street", Street);
                param[4] = new SqlParameter("@Area_Location", Area_Location);
                param[5] = new SqlParameter("@Town_City", Town_City);
                param[6] = new SqlParameter("@EmailID", EmailID);
                param[7] = new SqlParameter("@Status", Status);
                param[8] = new SqlParameter("@IClass", IClass);
                param[9] = new SqlParameter("@Pincode", Pincode);
                param[10] = new SqlParameter("@STD_code", STD_code);
                param[11] = new SqlParameter("@Tel_NO", Tel_NO);
                param[12] = new SqlParameter("@Fax", Fax);
                param[13] = new SqlParameter("@TANNo", TANNo);
                param[14] = new SqlParameter("@PANNo", PANNo);
                param[15] = new SqlParameter("@Alt_EmailID", Alt_EmailID);
                param[16] = new SqlParameter("@Alt_Tel_NO", Alt_Tel_NO);
                param[17] = new SqlParameter("@Alt_STDcode", Alt_STDcode);
                param[18] = new SqlParameter("@Change_Deductor", Change_Deductor);
                param[19] = new SqlParameter("@R_Name", R_Name);
                param[20] = new SqlParameter("@R_Flat_NO", R_Flat_NO);
                param[21] = new SqlParameter("@R_Building", R_Building);
                param[22] = new SqlParameter("@R_Street", R_Street);
                param[23] = new SqlParameter("@R_Area_Location", R_Area_Location);
                param[24] = new SqlParameter("@R_Town_City", R_Town_City);
                param[25] = new SqlParameter("@R_EmailID", R_EmailID);
                param[26] = new SqlParameter("@R_Designation", R_Designation);
                param[27] = new SqlParameter("@R_StateID", R_StateID);
                param[28] = new SqlParameter("@R_Mobile_NO", R_Mobile_NO);
                param[29] = new SqlParameter("@R_Pincode", R_Pincode);
                param[30] = new SqlParameter("@R_STD_Code", R_STD_Code);
                param[31] = new SqlParameter("@R_Tel_NO", R_Tel_NO);
                param[32] = new SqlParameter("@R_Fax", R_Fax);
                param[33] = new SqlParameter("@Change_Responsible", Change_Responsible);
                param[34] = new SqlParameter("@ALT_R_EmailID", ALT_R_EmailID);
                param[35] = new SqlParameter("@ALT_R_Tel_NO", ALT_R_Tel_NO);
                param[36] = new SqlParameter("@ALT_R_STD_Code", ALT_R_STD_Code);
                param[37] = new SqlParameter("@Place", Place);
                param[38] = new SqlParameter("@Company_ID", Company_ID);
                param[39] = new SqlParameter("@FromDate", FromDate);
                param[40] = new SqlParameter("@ToDate", ToDate);
                param[41] = new SqlParameter("@StateID", StateID);
                param[42] = new SqlParameter("@Branch", Branch);
                param[43] = new SqlParameter("@Alias", Alias);
                param[44] = new SqlParameter("@CompanyLogoName", CompanyLogoName);
                param[45] = new SqlParameter("@ContactPAN", ContactPAN);
                param[46] = new SqlParameter("@GSTN", GSTN );
                result = SqlHelper.ExecuteNonQuery(_cnnString, CommandType.StoredProcedure, "usp_UpdateCompanyDetails", param);
                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }


        public int DAL_InsertCompanyDetails()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[48];
                param[0] = new SqlParameter("@CompanyName", CompanyName);
                param[1] = new SqlParameter("@Flat_No", Flat_No);
                param[2] = new SqlParameter("@Name_Of_Building", Name_Of_Building);
                param[3] = new SqlParameter("@Street", Street);
                param[4] = new SqlParameter("@Area_Location", Area_Location);
                param[5] = new SqlParameter("@Town_City", Town_City);
                param[6] = new SqlParameter("@EmailID", EmailID);
                param[7] = new SqlParameter("@Status", Status);
                param[8] = new SqlParameter("@IClass", IClass);
                param[9] = new SqlParameter("@Pincode", Pincode);
                param[10] = new SqlParameter("@STD_code", STD_code);
                param[11] = new SqlParameter("@Tel_NO", Tel_NO);
                param[12] = new SqlParameter("@Fax", Fax);
                param[13] = new SqlParameter("@TANNo", TANNo);
                param[14] = new SqlParameter("@PANNo", PANNo);
                param[15] = new SqlParameter("@Alt_EmailID", Alt_EmailID);
                param[16] = new SqlParameter("@Alt_Tel_NO", Alt_Tel_NO);
                param[17] = new SqlParameter("@Alt_STDcode", Alt_STDcode);
                param[18] = new SqlParameter("@Change_Deductor", Change_Deductor);
                param[19] = new SqlParameter("@R_Name", R_Name);
                param[20] = new SqlParameter("@R_Flat_NO", R_Flat_NO);
                param[21] = new SqlParameter("@R_Building", R_Building);
                param[22] = new SqlParameter("@R_Street", R_Street);
                param[23] = new SqlParameter("@R_Area_Location", R_Area_Location);
                param[24] = new SqlParameter("@R_Town_City", R_Town_City);
                param[25] = new SqlParameter("@R_EmailID", R_EmailID);
                param[26] = new SqlParameter("@R_Designation", R_Designation);
                param[27] = new SqlParameter("@R_StateID", R_StateID);
                param[28] = new SqlParameter("@R_Mobile_NO", R_Mobile_NO);
                param[29] = new SqlParameter("@R_Pincode", R_Pincode);
                param[30] = new SqlParameter("@R_STD_Code", R_STD_Code);
                param[31] = new SqlParameter("@R_Tel_NO", R_Tel_NO);
                param[32] = new SqlParameter("@R_Fax", R_Fax);
                param[33] = new SqlParameter("@Change_Responsible", Change_Responsible);
                param[34] = new SqlParameter("@ALT_R_EmailID", ALT_R_EmailID);
                param[35] = new SqlParameter("@ALT_R_Tel_NO", ALT_R_Tel_NO);
                param[36] = new SqlParameter("@ALT_R_STD_Code", ALT_R_STD_Code);
                param[37] = new SqlParameter("@Place", Place);
                param[38] = new SqlParameter("@Company_ID", Company_ID);
                param[39] = new SqlParameter("@FromDate", FromDate);
                param[40] = new SqlParameter("@ToDate", ToDate);
                param[41] = new SqlParameter("@StateID", StateID);
                param[42] = new SqlParameter("@Branch", Branch);
                param[43] = new SqlParameter("@Alias", Alias);
                param[44] = new SqlParameter("@CompanyLogoName", CompanyLogoName);
                param[45] = new SqlParameter("@ParentID", Parent_ID);
                param[46] = new SqlParameter("@ContactPAN", ContactPAN);
                param[47] = new SqlParameter("@GSTN", GSTN);
                result = SqlHelper.ExecuteNonQuery(_cnnString, CommandType.StoredProcedure, "usp_InsertMultiCompanyDetails", param);
                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet DAL_GetCompanyParentID()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];

                param[0] = new SqlParameter("@ParentID", Parent_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_GetCompanyParentID", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet DAL_GetResponsible_PAN()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_Get_ResponsibleDetails", param);
                return ds;


            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DateTime ToDate { get; set; }

        public DateTime FromDate { get; set; }

        public int StateID { get; set; }

        public string Branch { get; set; }

        public string Alias { get; set; }

        public string CompanyLogoName { get; set; }

        public string CompanyLogoPath { get; set; }

        public string ContactPAN { get; set; }
    }
}
