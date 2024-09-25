using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;
using CommonLibrary;
using System.Data.SqlClient;

namespace BusinessLayer
{
    public class BAL_ReportPANDetails : CommonFunctions
    {
        DAL_ReportPANDetails objDAL_ReportPANDetails = new DAL_ReportPANDetails();

        public List<tbl_Employee_Master> BAL_GetEmployeeList(tbl_Employee_Master obj)
        {
            List<tbl_Employee_Master> tbl = new List<tbl_Employee_Master>();
            using (SqlDataReader drrr = objDAL_ReportPANDetails.DAL_GetEmployeeList(obj))
            {
                while (drrr.Read())
                {
                    tbl.Add(new tbl_Employee_Master()
                    {
                        EmpName = GetValue<string>(drrr["FirstName"].ToString()),
                        PAN_NO = GetValue<string>(drrr["PAN_NO"].ToString()),
                        PANVerified = GetValue<string>(drrr["PANVerified"].ToString())
                    });
                }
            }
            return tbl;
        }

        public List<tbl_Employee_Master> BAL_GetEmployeeList_ForNonSalary(tbl_Employee_Master obj)
        {
            List<tbl_Employee_Master> tbl = new List<tbl_Employee_Master>();
            using (SqlDataReader drrr = objDAL_ReportPANDetails.DAL_GetEmployeeList_ForNonSalary(obj))
            {
                while (drrr.Read())
                {
                    tbl.Add(new tbl_Employee_Master()
                    {
                        EmpName = GetValue<string>(drrr["Deductee_Name"].ToString()),
                        PAN_NO = GetValue<string>(drrr["PAN_NO"].ToString()),
                        PANVerified = GetValue<string>(drrr["PANVerified"].ToString())
                    });
                }
            }
            return tbl;
        }


        public List<tbl_DeductionStatment> BAL_GetDeduction_Salary(tbl_DeductionStatment obj)
        {
            List<tbl_DeductionStatment> tbl = new List<tbl_DeductionStatment>();
            using (SqlDataReader drrr = objDAL_ReportPANDetails.DAL_GetDeduction_Salary(obj))
            {
                while (drrr.Read())
                {
                    tbl.Add(new tbl_DeductionStatment()
                    {
                        NName = GetValue<string>(drrr["NatureName"].ToString()),
                        cTds = GetValue<double>(drrr["CTds"].ToString()),
                        ccess = GetValue<double>(drrr["Ccess"].ToString()),
                        cTTax = GetValue<double>(drrr["CTTax"].ToString()),
                        oTds = GetValue<double>(drrr["OTds"].ToString()),
                        oSur = GetValue<double>(drrr["OSur"].ToString()),
                        Ocess = GetValue<double>(drrr["Ocess"].ToString()),
                        otax = GetValue<double>(drrr["OTtax"].ToString())
                    });
                }
            }
            return tbl;
        }

        public List<CommonLibrary.tbl_salary_structure> BAL_GetEmployeeForSelection(tbl_Employee_Master obj)
        {
            List<tbl_salary_structure> tbl = new List<tbl_salary_structure>();
            using (SqlDataReader drrr = objDAL_ReportPANDetails.DAL_GetEmployeeForSelection(obj))
            {
                while (drrr.Read())
                {
                    tbl.Add(new tbl_salary_structure()
                    {
                        RowNumber = GetValue<int>(drrr["SrNo"].ToString()),
                        Employee_ID = GetValue<int>(drrr["Employee_ID"].ToString()),
                        EmpName = GetValue<string>(drrr["EmpName"].ToString()),
                        Designation_Name = GetValue<string>(drrr["Designation_Name"].ToString()),
                        Department_Name = GetValue<string>(drrr["Department_Name"].ToString()),
                        Join_DT = GetValue<string>(drrr["Join_DT"].ToString()),
                        Mobile_No = GetValue<string>(drrr["Mobile_No"].ToString()),
                        PAN_NO = GetValue<string>(drrr["PAN_NO"].ToString()),
                        PANVerified = GetValue<string>(drrr["PANVerified"].ToString()),
                        TotalCount = GetValue<int>(drrr["TotalCount"].ToString())
                    });
                }
            }
            return tbl;
        }

        public List<tbl_Employee_Master> BAL_GetEmployeeMasterDetails(tbl_Employee_Master obj)
        {
            List<tbl_Employee_Master> tbl = new List<tbl_Employee_Master>();
            using (SqlDataReader drrr = objDAL_ReportPANDetails.DAL_GetEmployeeMasterDetails(obj))
            {
                while (drrr.Read())
                {
                    tbl.Add(new tbl_Employee_Master()
                    {
                        Employee_ID = GetValue<int>(drrr["Employee_ID"].ToString()),
                        EmpName = GetValue<string>(drrr["EmpName"].ToString()),
                        Emp_Address = GetValue<string>(drrr["Emp_Address"].ToString()),
                        City = GetValue<string>(drrr["City"].ToString()),
                        State_Name = GetValue<string>(drrr["State_Name"].ToString()),
                        Gender = GetValue<string>(drrr["Gender"].ToString()),
                        Department_Name = GetValue<string>(drrr["Department_Name"].ToString()),
                        Birth_DT = GetValue<DateTime>(drrr["Birth_DT"].ToString()),
                        Join_DT = GetValue<DateTime>(drrr["Join_DT"].ToString()),
                        FATHER_HUSBAND_NAME = GetValue<string>(drrr["FATHER_HUSBAND_NAME"].ToString()),
                        PF_NO = GetValue<string>(drrr["PF_NO"].ToString()),
                        PAN_NO = GetValue<string>(drrr["PAN_NO"].ToString()),
                        PANVerified = GetValue<string>(drrr["PANVerified"].ToString()),
                        Branch_Name = GetValue<string>(drrr["Branch_Name"].ToString()),
                        Resign_DT = GetValue<DateTime>(drrr["Resign_DT"].ToString()),
                        Senior_CTZN_Type = GetValue<string>(drrr["Senior_CTZN_Type"].ToString()),
                        Designation_Name = GetValue<string>(drrr["Designation_Name"].ToString()),
                        Email_ID = GetValue<string>(drrr["Email_ID"].ToString()),
                        Handicapped = GetValue<bool>(drrr["Handicapped"].ToString()),
                        Mobile_No = GetValue<decimal>(drrr["Mobile_No"].ToString())
                    });
                }
            }
            return tbl;
        }
    }
}
