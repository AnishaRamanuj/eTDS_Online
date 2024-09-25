using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_Challan_Breakup
    {
        DAL_Challan_Breakup objDAL_Challan_Breakup = new DAL_Challan_Breakup();

        public int _Challan_Breakup_ID { get; set; }
        public int _Challan_ID { get; set; }
        public int _Challan_No { get; set; }
        public int _Company_ID { get; set; }
        public int _Employee_ID { get; set; }
        public double _Employee_Salary { get; set; }
        public string _Deduction_Type { get; set; }
        public string _PAN_No { get; set; }
        public string _Quater { get; set; }
        public double _TDS_Amount { get; set; }
        public double _Surcharge_Amount { get; set; }
        public double _EducationCess_Amount { get; set; }
        public double _High_EductionCess_Amount { get; set; }
        public double _Total_TDS_Amount { get; set; }
        public DateTime _Salary_Date { get; set; }
        public DateTime _Tds_Deduction_Date { get; set; }
        public bool _PAN_Verified { get; set; }

        public DataSet Insert_Challan_Breakup()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Challan_Breakup._Company_ID =  _Company_ID;
                objDAL_Challan_Breakup._Challan_ID= _Challan_ID;
                objDAL_Challan_Breakup._Employee_ID= _Employee_ID;
                objDAL_Challan_Breakup._Employee_Salary= _Employee_Salary;
                objDAL_Challan_Breakup._Deduction_Type= _Deduction_Type;
                objDAL_Challan_Breakup._PAN_No= _PAN_No;
                objDAL_Challan_Breakup._Quater= _Quater;
                objDAL_Challan_Breakup._TDS_Amount= _TDS_Amount;
                objDAL_Challan_Breakup._Surcharge_Amount= _Surcharge_Amount;
                objDAL_Challan_Breakup._EducationCess_Amount= _EducationCess_Amount;
                objDAL_Challan_Breakup._High_EductionCess_Amount= _High_EductionCess_Amount;
                objDAL_Challan_Breakup._Total_TDS_Amount= _Total_TDS_Amount;
                objDAL_Challan_Breakup._Salary_Date= _Salary_Date;
                objDAL_Challan_Breakup._Tds_Deduction_Date= _Tds_Deduction_Date;
                objDAL_Challan_Breakup._PAN_Verified= _PAN_Verified;

                ds = objDAL_Challan_Breakup.Insert_Challan_Breakup();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Update_Challan_Breakup()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Challan_Breakup._Challan_Breakup_ID = _Challan_Breakup_ID;
                objDAL_Challan_Breakup._Company_ID = _Company_ID;
                objDAL_Challan_Breakup._Challan_ID = _Challan_ID;
                objDAL_Challan_Breakup._Employee_ID = _Employee_ID;
                objDAL_Challan_Breakup._Employee_Salary = _Employee_Salary;
                objDAL_Challan_Breakup._Deduction_Type = _Deduction_Type;
                objDAL_Challan_Breakup._PAN_No = _PAN_No;
                objDAL_Challan_Breakup._Quater = _Quater;
                objDAL_Challan_Breakup._TDS_Amount = _TDS_Amount;
                objDAL_Challan_Breakup._Surcharge_Amount = _Surcharge_Amount;
                objDAL_Challan_Breakup._EducationCess_Amount = _EducationCess_Amount;
                objDAL_Challan_Breakup._High_EductionCess_Amount = _High_EductionCess_Amount;
                objDAL_Challan_Breakup._Total_TDS_Amount = _Total_TDS_Amount;
                objDAL_Challan_Breakup._Salary_Date = _Salary_Date;
                objDAL_Challan_Breakup._Tds_Deduction_Date = _Tds_Deduction_Date;
                objDAL_Challan_Breakup._PAN_Verified = _PAN_Verified;

                ds = objDAL_Challan_Breakup.Update_Challan_Breakup();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Challan_Breakup()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Challan_Breakup._Challan_Breakup_ID = _Challan_Breakup_ID;
                ds = objDAL_Challan_Breakup.Delete_Challan_Breakup();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Challan_Breakup_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Challan_Breakup._Challan_Breakup_ID = _Challan_Breakup_ID;
                ds = objDAL_Challan_Breakup.Get_Challan_Breakup_Details();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Challan_Breakup_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Challan_Breakup._Challan_ID = _Challan_ID;
                objDAL_Challan_Breakup._Challan_No = _Challan_No;
                objDAL_Challan_Breakup._Employee_ID = _Employee_ID;
                objDAL_Challan_Breakup._Company_ID = _Company_ID;

                ds = objDAL_Challan_Breakup.Get_Challan_Breakup_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }
    }
}
