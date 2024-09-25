using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;
using System.Data.SqlClient;

namespace BusinessLayer
{
    public class BAL_Employee_Master
    {
        DAL_Employee_Master objDAL_EmployeeMaster = new DAL_Employee_Master();

        public int _Employee_ID { get; set; }
        public int _Company_ID { get; set; }
        public string _FirstName { get; set; }
        public string _LastName { get; set; }
        public string _Emp_Address { get; set; }
        public string _City { get; set; }
        public int _State_ID { get; set; }
        public string _Gender { get; set; }
        public int _Designation_ID { get; set; }
        public DateTime _Birth_DT { get; set; }
        public DateTime _Join_DT { get; set; }
        public string _FATHER_HUSBAND_NAME { get; set; }
        public string _PF_NO { get; set; }
        public string _PAN_NO { get; set; }
        public string _Payment_Type { get; set; }
        public int _Branch_ID { get; set; }
        public string _Photo_path { get; set; }
        public DateTime _Resign_DT { get; set; }
        public string _ESIC_NO { get; set; }
        public bool _Calc_ESIC { get; set; }
        public bool _CALC_PF { get; set; }
        public bool _CALC_PT { get; set; }
        public string _Senior_CTZN_Type { get; set; }
        //public bool _Super_Senior_CTZN { get; set; }
        public string _Reason_Of_Leaving { get; set; }
        public int _Department_ID { get; set; }
        public ulong _Tel_NO { get; set; }
        public string _Email_ID { get; set; }
        public string _Bank_AC_NO { get; set; }
        public string _Bank_Name { get; set; }
        public int _Category_ID { get; set; }
        public string _Altcode { get; set; }
        public int _Shift_ID { get; set; }
        public DateTime _Probation_DT { get; set; }
        public DateTime _Confermation_DT { get; set; }
        public double _PF_Percentage { get; set; }
        public double _PF_Limit { get; set; }
        public int _Grade_ID { get; set; }
        public int _OT_ID { get; set; }
        public int _Weeklyoff_ID { get; set; }
        public bool _Handicapped { get; set; }
        public string _Metro_Cities { get; set; }
        public int _Govt_DA { get; set; }
        public string _Nominee { get; set; }
        public string _BloodGrp { get; set; }
        public string _Passport { get; set; }
        public string _Visa_Info { get; set; }
        public string _Emp_Password { get; set; }
        public string _Password { get; set; }
        public bool _Wages { get; set; }
        public string _Alais { get; set; }
        public string _PF_MEM { get; set; }
        public string _Mobile_No { get; set; }
        public int _ResignStatus { get; set; }
        public bool _Is_Salary_Allocated { get; set; }
        public int _Is_Leave_Allocated { get; set; }
        public string _PANVerified { get; set; }
        public Guid _UserID { get; set; }
        public Guid _Roleid { get; set; }
        public SqlTransaction _objSqlTransaction { get; set; }
        public int _Child { get; set; }
        public DateTime _Challan_Date { get; set; }

        public DataSet Get_Employee_Master_DetailsByID()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_EmployeeMaster._Employee_ID = _Employee_ID;
                ds = objDAL_EmployeeMaster.Get_Employee_Master_DetailsByID();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Employee_Master_DetailsByEmailID()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_EmployeeMaster._Email_ID= _Email_ID;
                ds = objDAL_EmployeeMaster.Get_Employee_Master_DetailsByEmailID();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Employee_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_EmployeeMaster._Company_ID = _Company_ID;
                objDAL_EmployeeMaster._FirstName = _FirstName;
                objDAL_EmployeeMaster._City = _City;
                objDAL_EmployeeMaster._State_ID = _State_ID;
                objDAL_EmployeeMaster._Designation_ID = _Designation_ID;
                objDAL_EmployeeMaster._Branch_ID = _Branch_ID;
                objDAL_EmployeeMaster._Department_ID = _Department_ID;
                objDAL_EmployeeMaster._Email_ID = _Email_ID;
                objDAL_EmployeeMaster._Category_ID = _Category_ID;
                objDAL_EmployeeMaster._Grade_ID = _Grade_ID;
                objDAL_EmployeeMaster._ResignStatus = _ResignStatus;
                objDAL_EmployeeMaster._Is_Salary_Allocated = _Is_Salary_Allocated;
                objDAL_EmployeeMaster._Employee_ID = _Employee_ID;
                objDAL_EmployeeMaster._Is_Leave_Allocated = _Is_Leave_Allocated;

                ds = objDAL_EmployeeMaster.Get_Employee_Master_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Monthly_Head_Summary()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_EmployeeMaster._Employee_ID = _Employee_ID;

                ds = objDAL_EmployeeMaster.Get_Monthly_Head_Summary();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Employee_Master_Challan_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_EmployeeMaster._Company_ID = _Company_ID;
                objDAL_EmployeeMaster._Challan_Date = _Challan_Date;
                objDAL_EmployeeMaster._Bank_Name = _Bank_Name;
                ds = objDAL_EmployeeMaster.Get_Employee_Master_Challan_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_RoleMapping()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = objDAL_EmployeeMaster.Get_RoleMapping();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Employee_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_EmployeeMaster._Employee_ID = _Employee_ID;
                ds = objDAL_EmployeeMaster.Delete_Employee_Master();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }


        public int UpdatePANVerification()
        {
            
            try
            {
                objDAL_EmployeeMaster._Company_ID = _Company_ID;
                objDAL_EmployeeMaster._PANVerifiedDataTable = _PANVerifiedDataTable;
                int result = objDAL_EmployeeMaster.UpdatePANVerification();
                return result;
            }
            catch (Exception)
            {

                throw;
            }
            
        }
        
        public DataSet Update_Employee_Master_Grade()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_EmployeeMaster._Employee_ID = _Employee_ID;
                objDAL_EmployeeMaster._Grade_ID = _Grade_ID;
                ds = objDAL_EmployeeMaster.Update_Employee_Master_Grade();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Update_Resign_Employee_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_EmployeeMaster._Employee_ID = _Employee_ID;
                objDAL_EmployeeMaster._Resign_DT = _Resign_DT;
                objDAL_EmployeeMaster._Reason_Of_Leaving = _Reason_Of_Leaving;
                ds = objDAL_EmployeeMaster.Update_Resign_Employee_Master();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Update_Employee_RoleUser()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_EmployeeMaster._Employee_ID = _Employee_ID;
                objDAL_EmployeeMaster._Roleid = _Roleid;
                objDAL_EmployeeMaster._Password = _Password;
                objDAL_EmployeeMaster._objSqlTransaction = _objSqlTransaction;

                ds = objDAL_EmployeeMaster.Update_Employee_RoleUser();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Insert_Employee_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_EmployeeMaster._Company_ID = _Company_ID;
                objDAL_EmployeeMaster._FirstName= _FirstName;
                objDAL_EmployeeMaster._LastName= _LastName;
                objDAL_EmployeeMaster._Emp_Address = _Emp_Address;
                objDAL_EmployeeMaster._City = _City;
                objDAL_EmployeeMaster._State_ID = _State_ID;
                objDAL_EmployeeMaster._Gender = _Gender;
                objDAL_EmployeeMaster._Designation_ID = _Designation_ID;
                objDAL_EmployeeMaster._Birth_DT = _Birth_DT;
                objDAL_EmployeeMaster._Join_DT = _Join_DT;
                objDAL_EmployeeMaster._FATHER_HUSBAND_NAME = _FATHER_HUSBAND_NAME;
                objDAL_EmployeeMaster._PF_NO = _PF_NO;
                objDAL_EmployeeMaster._PAN_NO = _PAN_NO;
                objDAL_EmployeeMaster._Payment_Type = _Payment_Type;
                objDAL_EmployeeMaster._Branch_ID = _Branch_ID;
                objDAL_EmployeeMaster._Photo_path = _Photo_path;
                objDAL_EmployeeMaster._Resign_DT = _Resign_DT;
                objDAL_EmployeeMaster._ESIC_NO = _ESIC_NO;
                objDAL_EmployeeMaster._Calc_ESIC = _Calc_ESIC;
                objDAL_EmployeeMaster._CALC_PF = _CALC_PF;
                objDAL_EmployeeMaster._CALC_PT= _CALC_PT;
                objDAL_EmployeeMaster._Senior_CTZN_Type = _Senior_CTZN_Type;
                //objDAL_EmployeeMaster._Super_Senior_CTZN = _Super_Senior_CTZN;
                objDAL_EmployeeMaster._Reason_Of_Leaving = _Reason_Of_Leaving;
                objDAL_EmployeeMaster._Department_ID = _Department_ID;
                objDAL_EmployeeMaster._Tel_NO = _Tel_NO;
                objDAL_EmployeeMaster._Email_ID = _Email_ID;
                objDAL_EmployeeMaster._Bank_AC_NO = _Bank_AC_NO;
                objDAL_EmployeeMaster._Bank_Name = _Bank_Name;
                objDAL_EmployeeMaster._Category_ID = _Category_ID;
                objDAL_EmployeeMaster._Altcode = _Altcode;
                objDAL_EmployeeMaster._Shift_ID = _Shift_ID;
                objDAL_EmployeeMaster._Probation_DT = _Probation_DT;
                objDAL_EmployeeMaster._Confermation_DT= _Confermation_DT;
                objDAL_EmployeeMaster._PF_Percentage = _PF_Percentage;
                objDAL_EmployeeMaster._PF_Limit = _PF_Limit;
                objDAL_EmployeeMaster._Grade_ID = _Grade_ID;
                objDAL_EmployeeMaster._OT_ID = _OT_ID;
                objDAL_EmployeeMaster._Weeklyoff_ID = _Weeklyoff_ID;
                objDAL_EmployeeMaster._Handicapped = _Handicapped;
                objDAL_EmployeeMaster._Metro_Cities = _Metro_Cities;
                objDAL_EmployeeMaster._Govt_DA = _Govt_DA;
                objDAL_EmployeeMaster._Nominee = _Nominee;
                objDAL_EmployeeMaster._BloodGrp = _BloodGrp;
                objDAL_EmployeeMaster._Passport = _Passport;
                objDAL_EmployeeMaster._Visa_Info = _Visa_Info;
                objDAL_EmployeeMaster._Emp_Password = _Emp_Password;
                objDAL_EmployeeMaster._Wages = _Wages;
                objDAL_EmployeeMaster._Alais = _Alais;
                objDAL_EmployeeMaster._PF_MEM = _PF_MEM;
                objDAL_EmployeeMaster._Mobile_No = _Mobile_No;
                objDAL_EmployeeMaster._UserID = _UserID;
                objDAL_EmployeeMaster._Child = _Child;
                objDAL_EmployeeMaster._PANVerified = _PANVerified;
                ds = objDAL_EmployeeMaster.Insert_Employee_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }




        public DataSet Update_Employee_Master()
        {
            DataSet ds = new DataSet();
            try
            {

                objDAL_EmployeeMaster._Employee_ID = _Employee_ID;
                objDAL_EmployeeMaster._Company_ID = _Company_ID;
                objDAL_EmployeeMaster._FirstName = _FirstName;
                objDAL_EmployeeMaster._LastName = _LastName;
                objDAL_EmployeeMaster._Emp_Address = _Emp_Address;
                objDAL_EmployeeMaster._City = _City;
                objDAL_EmployeeMaster._State_ID = _State_ID;
                objDAL_EmployeeMaster._Gender = _Gender;
                objDAL_EmployeeMaster._Designation_ID = _Designation_ID;
                objDAL_EmployeeMaster._Birth_DT = _Birth_DT;
                objDAL_EmployeeMaster._Join_DT = _Join_DT;
                objDAL_EmployeeMaster._FATHER_HUSBAND_NAME = _FATHER_HUSBAND_NAME;
                objDAL_EmployeeMaster._PF_NO = _PF_NO;
                objDAL_EmployeeMaster._PAN_NO = _PAN_NO;
                objDAL_EmployeeMaster._Payment_Type = _Payment_Type;
                objDAL_EmployeeMaster._Branch_ID = _Branch_ID;
                objDAL_EmployeeMaster._Photo_path = _Photo_path;
                objDAL_EmployeeMaster._Resign_DT = _Resign_DT;
                objDAL_EmployeeMaster._ESIC_NO = _ESIC_NO;
                objDAL_EmployeeMaster._Calc_ESIC = _Calc_ESIC;
                objDAL_EmployeeMaster._CALC_PF = _CALC_PF;
                objDAL_EmployeeMaster._CALC_PT = _CALC_PT;
                objDAL_EmployeeMaster._Senior_CTZN_Type = _Senior_CTZN_Type;
                //objDAL_EmployeeMaster._Super_Senior_CTZN = _Super_Senior_CTZN;
                objDAL_EmployeeMaster._Reason_Of_Leaving = _Reason_Of_Leaving;
                objDAL_EmployeeMaster._Department_ID = _Department_ID;
                objDAL_EmployeeMaster._Tel_NO = _Tel_NO;
                objDAL_EmployeeMaster._Email_ID = _Email_ID;
                objDAL_EmployeeMaster._Bank_AC_NO = _Bank_AC_NO;
                objDAL_EmployeeMaster._Bank_Name = _Bank_Name;
                objDAL_EmployeeMaster._Category_ID = _Category_ID;
                objDAL_EmployeeMaster._Altcode = _Altcode;
                objDAL_EmployeeMaster._Shift_ID = _Shift_ID;
                objDAL_EmployeeMaster._Probation_DT = _Probation_DT;
                objDAL_EmployeeMaster._Confermation_DT = _Confermation_DT;
                objDAL_EmployeeMaster._PF_Percentage = _PF_Percentage;
                objDAL_EmployeeMaster._PF_Limit = _PF_Limit;
                objDAL_EmployeeMaster._Grade_ID = _Grade_ID;
                objDAL_EmployeeMaster._OT_ID = _OT_ID;
                objDAL_EmployeeMaster._Weeklyoff_ID = _Weeklyoff_ID;
                objDAL_EmployeeMaster._Handicapped = _Handicapped;
                objDAL_EmployeeMaster._Metro_Cities = _Metro_Cities;
                objDAL_EmployeeMaster._Govt_DA = _Govt_DA;
                objDAL_EmployeeMaster._Nominee = _Nominee;
                objDAL_EmployeeMaster._BloodGrp = _BloodGrp;
                objDAL_EmployeeMaster._Passport = _Passport;
                objDAL_EmployeeMaster._Visa_Info = _Visa_Info;
                objDAL_EmployeeMaster._Wages = _Wages;
                objDAL_EmployeeMaster._Alais = _Alais;
                objDAL_EmployeeMaster._PF_MEM = _PF_MEM;
                objDAL_EmployeeMaster._Mobile_No = _Mobile_No;
                objDAL_EmployeeMaster._Child = _Child; 
                objDAL_EmployeeMaster._objSqlTransaction = _objSqlTransaction;
                objDAL_EmployeeMaster._PANVerified = _PANVerified;
                ds = objDAL_EmployeeMaster.Update_Employee_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataTable _PANVerifiedDataTable { get; set; }
    }
}
