using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;
using System.Data.SqlClient;

namespace BusinessLayer
{
    public class BAL_Import_Employee
    {
        DAL_Import_Employee objDAL_Import_Employee = new DAL_Import_Employee();

        public int _Company_ID { get; set; }
        public string _tblName { get; set; }
        public string _FieldName { get; set; }
        public string _FieldValue { get; set; }

        //------- Employee

        public int _Employee_ID { get; set; }
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

        public DataSet Dynamic_Search()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Import_Employee._Company_ID = _Company_ID;
                objDAL_Import_Employee._tblName = _tblName;
                objDAL_Import_Employee._FieldName = _FieldName;
                objDAL_Import_Employee._FieldValue = _FieldValue;
                ds = objDAL_Import_Employee.Dynamic_Search();
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
                objDAL_Import_Employee._Company_ID = _Company_ID;
                objDAL_Import_Employee._FirstName = _FirstName;
                objDAL_Import_Employee._LastName = _LastName;
                objDAL_Import_Employee._Emp_Address = _Emp_Address;
                objDAL_Import_Employee._City = _City;
                objDAL_Import_Employee._State_ID = _State_ID;
                objDAL_Import_Employee._Gender = _Gender;
                objDAL_Import_Employee._Designation_ID = _Designation_ID;
                objDAL_Import_Employee._Birth_DT = _Birth_DT;
                objDAL_Import_Employee._Join_DT = _Join_DT;
                objDAL_Import_Employee._FATHER_HUSBAND_NAME = _FATHER_HUSBAND_NAME;
                objDAL_Import_Employee._PF_NO = _PF_NO;
                objDAL_Import_Employee._PAN_NO = _PAN_NO;
                objDAL_Import_Employee._Payment_Type = _Payment_Type;
                objDAL_Import_Employee._Branch_ID = _Branch_ID;
                objDAL_Import_Employee._Photo_path = _Photo_path;
                objDAL_Import_Employee._Resign_DT = _Resign_DT;
                objDAL_Import_Employee._ESIC_NO = _ESIC_NO;
                objDAL_Import_Employee._Calc_ESIC = _Calc_ESIC;
                objDAL_Import_Employee._CALC_PF = _CALC_PF;
                objDAL_Import_Employee._CALC_PT = _CALC_PT;
                objDAL_Import_Employee._Senior_CTZN_Type = _Senior_CTZN_Type;
                //objDAL_Import_Employee._Super_Senior_CTZN = _Super_Senior_CTZN;
                objDAL_Import_Employee._Reason_Of_Leaving = _Reason_Of_Leaving;
                objDAL_Import_Employee._Department_ID = _Department_ID;
                objDAL_Import_Employee._Tel_NO = _Tel_NO;
                objDAL_Import_Employee._Email_ID = _Email_ID;
                objDAL_Import_Employee._Bank_AC_NO = _Bank_AC_NO;
                objDAL_Import_Employee._Bank_Name = _Bank_Name;
                objDAL_Import_Employee._Category_ID = _Category_ID;
                objDAL_Import_Employee._Altcode = _Altcode;
                objDAL_Import_Employee._Shift_ID = _Shift_ID;
                objDAL_Import_Employee._Probation_DT = _Probation_DT;
                objDAL_Import_Employee._Confermation_DT = _Confermation_DT;
                objDAL_Import_Employee._PF_Percentage = _PF_Percentage;
                objDAL_Import_Employee._PF_Limit = _PF_Limit;
                objDAL_Import_Employee._Grade_ID = _Grade_ID;
                objDAL_Import_Employee._OT_ID = _OT_ID;
                objDAL_Import_Employee._Weeklyoff_ID = _Weeklyoff_ID;
                objDAL_Import_Employee._Handicapped = _Handicapped;
                objDAL_Import_Employee._Metro_Cities = _Metro_Cities;
                objDAL_Import_Employee._Govt_DA = _Govt_DA;
                objDAL_Import_Employee._Nominee = _Nominee;
                objDAL_Import_Employee._BloodGrp = _BloodGrp;
                objDAL_Import_Employee._Passport = _Passport;
                objDAL_Import_Employee._Visa_Info = _Visa_Info;
                objDAL_Import_Employee._Emp_Password = _Emp_Password;
                objDAL_Import_Employee._Wages = _Wages;
                objDAL_Import_Employee._Alais = _Alais;
                objDAL_Import_Employee._PF_MEM = _PF_MEM;
                objDAL_Import_Employee._Mobile_No = _Mobile_No;
                objDAL_Import_Employee._UserID = _UserID;
                objDAL_Import_Employee._Child = _Child;

                ds = objDAL_Import_Employee.Insert_Employee_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }


        public DataTable _Employeetable { get; set; }

        public DataSet BAL_InsertUpdateImportEmployeeRecords()
        {
            try
            {
                objDAL_Import_Employee._Company_ID = _Company_ID;
                objDAL_Import_Employee._Employeetable = _Employeetable;
                DataSet ds = objDAL_Import_Employee.DAL_InsertUpdateImportEmployeeRecords();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}
