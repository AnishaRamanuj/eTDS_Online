using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;
using System.Data;

namespace BusinessLayer
{
    public class BAL_ManageCompany
    {
        int result = 0;
        DAL_ManageCompany objDAL_ManageCompany = new DAL_ManageCompany();
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


        public DataSet BAL_BindRegisterCompanyGrid()
        {
            try
            {
                objDAL_ManageCompany.Company_ID = Company_ID;
                ds = objDAL_ManageCompany.DAL_BindRegisterCompanyGrid();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }


        public DataSet BAL_BindCompanyGrid()
        {
            try
            {
                objDAL_ManageCompany.Company_ID = Company_ID;
                ds = objDAL_ManageCompany.DAL_BindCompanyGrid();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet BAL_ParentDetails()
        {
            try
            {
                objDAL_ManageCompany.Parent_ID = Parent_ID; 
                ds = objDAL_ManageCompany.DAL_ParentDetails();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet BAL_CompanyCount()
        {
            try
            {
                objDAL_ManageCompany.Parent_ID = Parent_ID;
                ds = objDAL_ManageCompany.DAL_CompanyCount();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        public DataSet BAL_EditCompanyDetails()
        {
            try
            {
                objDAL_ManageCompany.Company_ID = Company_ID;
                ds = objDAL_ManageCompany.DAL_EditCompanyDetails();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet BAL_GetCompanyParentID()
        {
            try
            {
                objDAL_ManageCompany.Parent_ID = Parent_ID ;
                ds = objDAL_ManageCompany.DAL_GetCompanyParentID();  
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        

        public int BAL_UpdateCompanyDetails()
        {
            try
            {
                objDAL_ManageCompany.CompanyName = CompanyName;
                objDAL_ManageCompany.Flat_No = Flat_No;
                objDAL_ManageCompany.Name_Of_Building = Name_Of_Building;
                objDAL_ManageCompany.Street = Street;
                objDAL_ManageCompany.Area_Location = Area_Location;
                objDAL_ManageCompany.Town_City = Town_City;
                objDAL_ManageCompany.EmailID = EmailID; ;
                objDAL_ManageCompany.Status = Status;
                objDAL_ManageCompany.IClass = IClass;
                objDAL_ManageCompany.Pincode = Pincode;
                objDAL_ManageCompany.STD_code = STD_code;
                objDAL_ManageCompany.Tel_NO = Tel_NO;
                objDAL_ManageCompany.Fax = Fax;
                objDAL_ManageCompany.TANNo = TANNo;
                objDAL_ManageCompany.PANNo = PANNo;
                objDAL_ManageCompany.Place = Place;
                objDAL_ManageCompany.Alt_EmailID = Alt_EmailID;
                objDAL_ManageCompany.Alt_Tel_NO = Alt_Tel_NO;
                objDAL_ManageCompany.Alt_STDcode = Alt_STDcode;
                objDAL_ManageCompany.Change_Deductor = Change_Deductor;
                objDAL_ManageCompany.R_Name = R_Name;
                objDAL_ManageCompany.R_Flat_NO = R_Flat_NO;
                objDAL_ManageCompany.R_Building = R_Building;
                objDAL_ManageCompany.R_Street = R_Street;
                objDAL_ManageCompany.R_Area_Location = R_Area_Location;
                objDAL_ManageCompany.R_Town_City = R_Town_City;
                objDAL_ManageCompany.R_EmailID = R_EmailID;
                objDAL_ManageCompany.R_Designation = R_Designation;
                objDAL_ManageCompany.R_StateID = R_StateID;
                objDAL_ManageCompany.R_Mobile_NO = R_Mobile_NO;
                objDAL_ManageCompany.R_Pincode = R_Pincode;
                objDAL_ManageCompany.R_STD_Code = R_STD_Code;
                objDAL_ManageCompany.R_Tel_NO = R_Tel_NO;
                objDAL_ManageCompany.R_Fax = R_Fax;
                objDAL_ManageCompany.Change_Responsible = Change_Responsible;
                objDAL_ManageCompany.ALT_R_EmailID = ALT_R_EmailID;
                objDAL_ManageCompany.ALT_R_Tel_NO = ALT_R_Tel_NO;
                objDAL_ManageCompany.ALT_R_STD_Code = ALT_R_STD_Code;
                objDAL_ManageCompany.Company_ID = Company_ID;
                objDAL_ManageCompany.FromDate = FromDate;
                objDAL_ManageCompany.ToDate = ToDate;
                objDAL_ManageCompany.StateID = StateID;
                objDAL_ManageCompany.Branch = Branch;
                objDAL_ManageCompany.Alias = Alias;
                objDAL_ManageCompany.CompanyLogoName = CompanyLogoName;
                objDAL_ManageCompany.CompanyLogoPath = CompanyLogoPath;
                objDAL_ManageCompany.ContactPAN = ContactPAN;
                objDAL_ManageCompany.GSTN = GSTN ;
                result = objDAL_ManageCompany.DAL_UpdateCompanyDetails();
                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public int BAL_InsertCompanyDetails()
        {
            try
            {
                objDAL_ManageCompany.CompanyName = CompanyName;
                objDAL_ManageCompany.Flat_No = Flat_No;
                objDAL_ManageCompany.Name_Of_Building = Name_Of_Building;
                objDAL_ManageCompany.Street = Street;
                objDAL_ManageCompany.Area_Location = Area_Location;
                objDAL_ManageCompany.Town_City = Town_City;
                objDAL_ManageCompany.EmailID = EmailID; ;
                objDAL_ManageCompany.Status = Status;
                objDAL_ManageCompany.IClass = IClass;
                objDAL_ManageCompany.Pincode = Pincode;
                objDAL_ManageCompany.STD_code = STD_code;
                objDAL_ManageCompany.Tel_NO = Tel_NO;
                objDAL_ManageCompany.Fax = Fax;
                objDAL_ManageCompany.TANNo = TANNo;
                objDAL_ManageCompany.PANNo = PANNo;
                objDAL_ManageCompany.Place = Place;
                objDAL_ManageCompany.Alt_EmailID = Alt_EmailID;
                objDAL_ManageCompany.Alt_Tel_NO = Alt_Tel_NO;
                objDAL_ManageCompany.Alt_STDcode = Alt_STDcode;
                objDAL_ManageCompany.Change_Deductor = Change_Deductor;
                objDAL_ManageCompany.R_Name = R_Name;
                objDAL_ManageCompany.R_Flat_NO = R_Flat_NO;
                objDAL_ManageCompany.R_Building = R_Building;
                objDAL_ManageCompany.R_Street = R_Street;
                objDAL_ManageCompany.R_Area_Location = R_Area_Location;
                objDAL_ManageCompany.R_Town_City = R_Town_City;
                objDAL_ManageCompany.R_EmailID = R_EmailID;
                objDAL_ManageCompany.R_Designation = R_Designation;
                objDAL_ManageCompany.R_StateID = R_StateID;
                objDAL_ManageCompany.R_Mobile_NO = R_Mobile_NO;
                objDAL_ManageCompany.R_Pincode = R_Pincode;
                objDAL_ManageCompany.R_STD_Code = R_STD_Code;
                objDAL_ManageCompany.R_Tel_NO = R_Tel_NO;
                objDAL_ManageCompany.R_Fax = R_Fax;
                objDAL_ManageCompany.Change_Responsible = Change_Responsible;
                objDAL_ManageCompany.ALT_R_EmailID = ALT_R_EmailID;
                objDAL_ManageCompany.ALT_R_Tel_NO = ALT_R_Tel_NO;
                objDAL_ManageCompany.ALT_R_STD_Code = ALT_R_STD_Code;
                objDAL_ManageCompany.Company_ID = Company_ID;
                objDAL_ManageCompany.FromDate = FromDate;
                objDAL_ManageCompany.ToDate = ToDate;
                objDAL_ManageCompany.StateID = StateID;
                objDAL_ManageCompany.Branch = Branch;
                objDAL_ManageCompany.Alias = Alias;
                objDAL_ManageCompany.CompanyLogoName = CompanyLogoName;
                objDAL_ManageCompany.CompanyLogoPath = CompanyLogoPath;
                objDAL_ManageCompany.Parent_ID  = Parent_ID ;
                objDAL_ManageCompany.ContactPAN = ContactPAN;
                objDAL_ManageCompany.GSTN = GSTN;
                result = objDAL_ManageCompany.DAL_InsertCompanyDetails();
                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet BAL_GetResponsible_PAN()
        {
            try
            {
                objDAL_ManageCompany.Company_ID = Company_ID;
                ds = objDAL_ManageCompany.DAL_GetResponsible_PAN();

                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DateTime FromDate { get; set; }

        public DateTime ToDate { get; set; }

        public int StateID { get; set; }

        public string Branch { get; set; }

        public string Alias { get; set; }

        public string CompanyLogoName { get; set; }

        public string CompanyLogoPath { get; set; }

        public string ContactPAN { get; set; }
        public string GSTN { get; set; }
    }
}
