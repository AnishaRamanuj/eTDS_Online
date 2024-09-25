using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_Employee_Master : DALCommon
    {
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
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Employee_Master_DetailsByID", objSqlParameter);
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
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Email_ID", _Email_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Employee_Master_DetailsByEmailID", objSqlParameter);
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
                SqlParameter[] objSqlParameter = new SqlParameter[2];
                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[1] = new SqlParameter("@PANVerifiedDataTable", _PANVerifiedDataTable);
                int result = SqlHelper.ExecuteNonQuery(_cnnString, CommandType.StoredProcedure,"usp_PANVerification_Employee_Master", objSqlParameter);
                return result;
            }
            catch (Exception)
            {

                throw;
            }
            
        }
        
        public DataSet Get_Employee_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[14];

                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[1] = new SqlParameter("@FirstName", _FirstName);
                objSqlParameter[2] = new SqlParameter("@City", _City);
                objSqlParameter[3] = new SqlParameter("@State_ID", _State_ID);
                objSqlParameter[4] = new SqlParameter("@Designation_ID", _Designation_ID);
                objSqlParameter[5] = new SqlParameter("@Branch_ID", _Branch_ID);
                objSqlParameter[6] = new SqlParameter("@Department_ID", _Department_ID);
                objSqlParameter[7] = new SqlParameter("@Email_ID", _Email_ID);
                objSqlParameter[8] = new SqlParameter("@Category_ID", _Category_ID);
                objSqlParameter[9] = new SqlParameter("@Grade_ID", _Grade_ID);
                objSqlParameter[10] = new SqlParameter("@ResignStatus", _ResignStatus);
                objSqlParameter[11] = new SqlParameter("@Is_Salary_Allocated", _Is_Salary_Allocated);
                objSqlParameter[12] = new SqlParameter("@Employee_ID", _Employee_ID);
                objSqlParameter[13] = new SqlParameter("@Is_Leave_Allocated", _Is_Leave_Allocated);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Employee_Master_List", objSqlParameter);
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
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Monthly_Head_Summary", objSqlParameter);
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
                SqlParameter[] objSqlParameter = new SqlParameter[3];
                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[1] = new SqlParameter("@Challan_Date", _Challan_Date);
                objSqlParameter[2] = new SqlParameter("@Months", _Bank_Name);
                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Employee_Master_Challan_List", objSqlParameter);
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
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_RoleMapping");
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
                object Birth_DT = _Birth_DT;
                if (_Birth_DT == DateTime.MinValue)
                    Birth_DT = DBNull.Value;

                object Join_DT = _Join_DT;
                if (_Join_DT == DateTime.MinValue)
                    Join_DT = DBNull.Value;

                object Resign_DT = _Resign_DT;
                if (_Resign_DT == DateTime.MinValue)
                    Resign_DT = DBNull.Value;

                object Probation_DT = _Probation_DT;
                if (_Probation_DT == DateTime.MinValue)
                    Probation_DT = DBNull.Value;

                object Confermation_DT = _Confermation_DT;
                if (_Confermation_DT == DateTime.MinValue)
                    Confermation_DT = DBNull.Value;

                SqlParameter[] objSqlParameter = new SqlParameter[53];

                objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[1] = new SqlParameter("@FirstName", _FirstName);
                objSqlParameter[2] = new SqlParameter("@LastName", _LastName);
                objSqlParameter[3] = new SqlParameter("@Emp_Address", _Emp_Address);
                objSqlParameter[4] = new SqlParameter("@City", _City);
                objSqlParameter[5] = new SqlParameter("@State_ID", _State_ID);
                objSqlParameter[6] = new SqlParameter("@Gender", _Gender);
                objSqlParameter[7] = new SqlParameter("@Designation_ID", _Designation_ID);
                objSqlParameter[8] = new SqlParameter("@Birth_DT", Birth_DT);
                objSqlParameter[9] = new SqlParameter("@Join_DT", Join_DT);
                objSqlParameter[10] = new SqlParameter("@FATHER_HUSBAND_NAME", _FATHER_HUSBAND_NAME);
                objSqlParameter[11] = new SqlParameter("@PF_NO", _PF_NO);
                objSqlParameter[12] = new SqlParameter("@PAN_NO", _PAN_NO);
                objSqlParameter[13] = new SqlParameter("@Payment_Type", _Payment_Type);
                objSqlParameter[14] = new SqlParameter("@Branch_ID", _Branch_ID);
                objSqlParameter[15] = new SqlParameter("@Photo_path", _Photo_path);
                objSqlParameter[16] = new SqlParameter("@Resign_DT", Resign_DT);
                objSqlParameter[17] = new SqlParameter("@ESIC_NO", _ESIC_NO);
                objSqlParameter[18] = new SqlParameter("@Calc_ESIC", _Calc_ESIC);
                objSqlParameter[19] = new SqlParameter("@CALC_PF", _CALC_PF);
                objSqlParameter[20] = new SqlParameter("@CALC_PT", _CALC_PT);
                objSqlParameter[21] = new SqlParameter("@Senior_CTZN", _Senior_CTZN_Type);
                //objSqlParameter[22] = new SqlParameter("@Super_Senior_CTZN", _Super_Senior_CTZN);
                objSqlParameter[22] = new SqlParameter("@Reason_Of_Leaving", _Reason_Of_Leaving);
                objSqlParameter[23] = new SqlParameter("@Department_ID", _Department_ID);
                objSqlParameter[24] = new SqlParameter("@Tel_NO", _Tel_NO);
                objSqlParameter[25] = new SqlParameter("@Email_ID", _Email_ID);
                objSqlParameter[26] = new SqlParameter("@Bank_AC_NO", _Bank_AC_NO);
                objSqlParameter[27] = new SqlParameter("@Bank_Name", _Bank_Name);
                objSqlParameter[28] = new SqlParameter("@Category_ID", _Category_ID);
                objSqlParameter[29] = new SqlParameter("@Altcode", _Altcode);
                objSqlParameter[30] = new SqlParameter("@Shift_ID", _Shift_ID);
                objSqlParameter[31] = new SqlParameter("@Probation_DT", Probation_DT);
                objSqlParameter[32] = new SqlParameter("@Confermation_DT", Confermation_DT);
                objSqlParameter[33] = new SqlParameter("@PF_Percentage", _PF_Percentage);
                objSqlParameter[34] = new SqlParameter("@PF_Limit", _PF_Limit);
                objSqlParameter[35] = new SqlParameter("@Grade_ID", _Grade_ID);
                objSqlParameter[36] = new SqlParameter("@OT_ID", _OT_ID);
                objSqlParameter[37] = new SqlParameter("@Weeklyoff_ID", _Weeklyoff_ID);
                objSqlParameter[38] = new SqlParameter("@Handicapped", _Handicapped);
                objSqlParameter[39] = new SqlParameter("@Metro_Cities", _Metro_Cities);
                objSqlParameter[40] = new SqlParameter("@Govt_DA", _Govt_DA);
                objSqlParameter[41] = new SqlParameter("@Nominee", _Nominee);
                objSqlParameter[42] = new SqlParameter("@BloodGrp", _BloodGrp);
                objSqlParameter[43] = new SqlParameter("@Passport", _Passport);
                objSqlParameter[44] = new SqlParameter("@Visa_Info", _Visa_Info);
                objSqlParameter[45] = new SqlParameter("@Emp_Password", _Emp_Password);
                objSqlParameter[46] = new SqlParameter("@Wages", _Wages);
                objSqlParameter[47] = new SqlParameter("@Alais", _Alais);
                objSqlParameter[48] = new SqlParameter("@PF_MEM", _PF_MEM);
                objSqlParameter[49] = new SqlParameter("@Mobile_No", _Mobile_No);
                objSqlParameter[50] = new SqlParameter("@PANVerified", _PANVerified);
                objSqlParameter[51] = new SqlParameter("@UserID", _UserID);
                objSqlParameter[52] = new SqlParameter("@Child", _Child);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Insert_Employee_Master", objSqlParameter);
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
                object Birth_DT = _Birth_DT;
                if (_Birth_DT == DateTime.MinValue)
                    Birth_DT = DBNull.Value;

                object Join_DT = _Join_DT;
                if (_Join_DT == DateTime.MinValue)
                    Join_DT = DBNull.Value;

                object Resign_DT = _Resign_DT;
                if (_Resign_DT == DateTime.MinValue)
                    Resign_DT = DBNull.Value;

                object Probation_DT = _Probation_DT;
                if (_Probation_DT == DateTime.MinValue)
                    Probation_DT = DBNull.Value;

                object Confermation_DT = _Confermation_DT;
                if (_Confermation_DT == DateTime.MinValue)
                    Confermation_DT = DBNull.Value;

                SqlParameter[] objSqlParameter = new SqlParameter[52];
                	
                objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);
                objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
                objSqlParameter[2] = new SqlParameter("@FirstName", _FirstName);
                objSqlParameter[3] = new SqlParameter("@LastName", _LastName);
                objSqlParameter[4] = new SqlParameter("@Emp_Address", _Emp_Address);
                objSqlParameter[5] = new SqlParameter("@City", _City);
                objSqlParameter[6] = new SqlParameter("@State_ID", _State_ID);
                objSqlParameter[7] = new SqlParameter("@Gender", _Gender);
                objSqlParameter[8] = new SqlParameter("@Designation_ID", _Designation_ID);
                objSqlParameter[9] = new SqlParameter("@Birth_DT", Birth_DT);
                objSqlParameter[10] = new SqlParameter("@Join_DT", Join_DT);
                objSqlParameter[11] = new SqlParameter("@FATHER_HUSBAND_NAME", _FATHER_HUSBAND_NAME);
                objSqlParameter[12] = new SqlParameter("@PF_NO", _PF_NO);
                objSqlParameter[13] = new SqlParameter("@PAN_NO", _PAN_NO);
                objSqlParameter[14] = new SqlParameter("@Payment_Type", _Payment_Type);
                objSqlParameter[15] = new SqlParameter("@Branch_ID", _Branch_ID);
                objSqlParameter[16] = new SqlParameter("@Photo_path", _Photo_path);
                objSqlParameter[17] = new SqlParameter("@Resign_DT", Resign_DT);
                objSqlParameter[18] = new SqlParameter("@ESIC_NO", _ESIC_NO);
                objSqlParameter[19] = new SqlParameter("@Calc_ESIC", _Calc_ESIC);
                objSqlParameter[20] = new SqlParameter("@CALC_PF", _CALC_PF);
                objSqlParameter[21] = new SqlParameter("@CALC_PT", _CALC_PT);
                objSqlParameter[22] = new SqlParameter("@Senior_CTZN", _Senior_CTZN_Type);
                //objSqlParameter[23] = new SqlParameter("@Super_Senior_CTZN", _Super_Senior_CTZN);
                objSqlParameter[23] = new SqlParameter("@Reason_Of_Leaving", _Reason_Of_Leaving);
                objSqlParameter[24] = new SqlParameter("@Department_ID", _Department_ID);
                objSqlParameter[25] = new SqlParameter("@Tel_NO", _Tel_NO);
                objSqlParameter[26] = new SqlParameter("@Email_ID", _Email_ID);
                objSqlParameter[27] = new SqlParameter("@Bank_AC_NO", _Bank_AC_NO);
                objSqlParameter[28] = new SqlParameter("@Bank_Name", _Bank_Name);
                objSqlParameter[29] = new SqlParameter("@Category_ID", _Category_ID);
                objSqlParameter[30] = new SqlParameter("@Altcode", _Altcode);
                objSqlParameter[31] = new SqlParameter("@Shift_ID", _Shift_ID);
                objSqlParameter[32] = new SqlParameter("@Probation_DT", Probation_DT);
                objSqlParameter[33] = new SqlParameter("@Confermation_DT", Confermation_DT);
                objSqlParameter[34] = new SqlParameter("@PF_Percentage", _PF_Percentage);
                objSqlParameter[35] = new SqlParameter("@PF_Limit", _PF_Limit);
                objSqlParameter[36] = new SqlParameter("@Grade_ID", _Grade_ID);
                objSqlParameter[37] = new SqlParameter("@OT_ID", _OT_ID);
                objSqlParameter[38] = new SqlParameter("@Weeklyoff_ID", _Weeklyoff_ID);
                objSqlParameter[39] = new SqlParameter("@Handicapped", _Handicapped);
                objSqlParameter[40] = new SqlParameter("@Metro_Cities", _Metro_Cities);
                objSqlParameter[41] = new SqlParameter("@Govt_DA", _Govt_DA);
                objSqlParameter[42] = new SqlParameter("@Nominee", _Nominee);
                objSqlParameter[43] = new SqlParameter("@BloodGrp", _BloodGrp);
                objSqlParameter[44] = new SqlParameter("@Passport", _Passport);
                objSqlParameter[45] = new SqlParameter("@Visa_Info", _Visa_Info);
                objSqlParameter[46] = new SqlParameter("@Wages", _Wages);
                objSqlParameter[47] = new SqlParameter("@Alais", _Alais);
                objSqlParameter[48] = new SqlParameter("@PF_MEM", _PF_MEM);
                objSqlParameter[49] = new SqlParameter("@PANVerified", _PANVerified);
                objSqlParameter[50] = new SqlParameter("@Mobile_No", _Mobile_No);
                objSqlParameter[51] = new SqlParameter("@Child", _Child);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Update_Employee_Master", objSqlParameter);
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }



        public DataSet Update_Employee_Master_Grade()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];
                objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);
                objSqlParameter[1] = new SqlParameter("@Grade_ID", _Grade_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Update_Employee_Master_Grade", objSqlParameter);
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
                SqlParameter[] objSqlParameter = new SqlParameter[3];
                objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);
                objSqlParameter[1] = new SqlParameter("@Resign_DT", _Resign_DT);
                objSqlParameter[2] = new SqlParameter("@Reason_Of_Leaving", _Reason_Of_Leaving);
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Update_Resign_Employee_Master", objSqlParameter);
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
                SqlParameter[] objSqlParameter = new SqlParameter[3];
                
                objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);
                objSqlParameter[1] = new SqlParameter("@RoleID", _Roleid);
                objSqlParameter[2] = new SqlParameter("@Password", _Password);

                ds = SqlHelper.ExecuteDataset(_objSqlTransaction, "USP_Update_Employee_RoleUser", objSqlParameter);

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
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Delete_Employee_Master", objSqlParameter);
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
