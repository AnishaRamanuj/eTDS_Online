using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CommonLibrary;
using System.Data.SqlClient;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_ReportChallanSalaryStatement : CommonFunctions
    {

        DAL_ReportChallanSalaryStatement objDAL_ReportChallanSalaryStatement = new DAL_ReportChallanSalaryStatement();
        public List<tbl_Challan_Salary_Breakup> BAL_GetChallanSalaryBreakup(tbl_Employee_Master obj)
        {
            List<tbl_Challan_Salary_Breakup> tbl = new List<tbl_Challan_Salary_Breakup>();
            using (SqlDataReader drrr = objDAL_ReportChallanSalaryStatement.DAL_GetChallanSalaryBreakup(obj))
            {
                while (drrr.Read())
                {
                    tbl.Add(new tbl_Challan_Salary_Breakup()
                    {
                        Employee_ID = GetValue<int>(drrr["Employee_ID"].ToString()),
                        EmpName = GetValue<string>(drrr["firstName"].ToString()),
                        Employee_Salary = GetValue<float>(drrr["Employee_Salary"].ToString()),
                        Challan_Date = GetValue<DateTime>(drrr["Challan_Date"].ToString()),
                        TDS_Amount = GetValue<float>(drrr["TDS_Amount"].ToString()),
                        Surcharge_Amount = GetValue<float>(drrr["Surcharge_Amount"].ToString()),
                        EducationCess_Amount = GetValue<float>(drrr["EducationCess_Amount"].ToString()),
                        High_EductionCess_Amount = GetValue<float>(drrr["High_EductionCess_Amount"].ToString()),
                        Total_TDS_Amount = GetValue<float>(drrr["Total_TDS_Amount"].ToString()),
                    });
                }
            }
            return tbl;
        }
        public List<tbl_Company_MAster> BAL_GetCompanyMaterDetails(tbl_Employee_Master obj)
        {
            List<tbl_Company_MAster> tbl = new List<tbl_Company_MAster>();
            using (SqlDataReader drrr = objDAL_ReportChallanSalaryStatement.DAL_GetCompanyMaterDetails(obj))
            {
                while (drrr.Read())
                {
                    tbl.Add(new tbl_Company_MAster()
                    {
                        CompanyName = GetValue<string>(drrr["CompanyName"].ToString()),
                        Flat_No = GetValue<string>(drrr["Flat_No"].ToString()),
                        Name_Of_Building = GetValue<string>(drrr["Name_Of_Building"].ToString()),
                        Street = GetValue<string>(drrr["Street"].ToString()),
                        Area_Location = GetValue<string>(drrr["Area_Location"].ToString()),
                        Town_City = GetValue<string>(drrr["Town_City"].ToString()),
                        CompanyLogoName = GetValue<string>(drrr["CompanyLogoName"].ToString()),
                        TANNo = GetValue<string>(drrr["TANNo"].ToString()),
                        PANNo = GetValue<string>(drrr["PANNo"].ToString())
                    });
                }
            }
            return tbl;
        }
        public List<tbl_salary_structure> BAL_ReportEmployeeDeduction_BindEmployee(tbl_Employee_Master obj)
        {
            List<tbl_salary_structure> tbl = new List<tbl_salary_structure>();
            using (SqlDataReader drrr = objDAL_ReportChallanSalaryStatement.DAL_ReportEmployeeDeduction_BindEmployee(obj))
            {
                while (drrr.Read())
                {
                    tbl.Add(new tbl_salary_structure()
                    {
                        RowNumber = GetValue<int>(drrr["SrNo"].ToString()),
                        Employee_ID = GetValue<int>(drrr["Employee_ID"].ToString()),
                        EmpName = GetValue<string>(drrr["firstName"].ToString()),
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
        public List<tbl_Challan_Salary_Breakup> BAL_EmployeeTAxDeduction_GetChallanSalaryBreakup(tbl_Employee_Master obj)
        {
            List<tbl_Challan_Salary_Breakup> tbl = new List<tbl_Challan_Salary_Breakup>();
            using (SqlDataReader drrr = objDAL_ReportChallanSalaryStatement.DAL_EmployeeTAxDeduction_GetChallanSalaryBreakup(obj))
            {
                while (drrr.Read())
                {
                    tbl.Add(new tbl_Challan_Salary_Breakup()
                    {
                        Employee_ID = GetValue<int>(drrr["Employee_ID"].ToString()),
                        EmpName = GetValue<string>(drrr["firstName"].ToString()),
                        Employee_Salary = GetValue<float>(drrr["Employee_Salary"].ToString()),
                        Challan_Date = GetValue<DateTime>(drrr["Challan_Date"].ToString()),
                        TDS_Amount = GetValue<float>(drrr["TDS_Amount"].ToString()),
                        Surcharge_Amount = GetValue<float>(drrr["Surcharge_Amount"].ToString()),
                        EducationCess_Amount = GetValue<float>(drrr["EducationCess_Amount"].ToString()),
                        High_EductionCess_Amount = GetValue<float>(drrr["High_EductionCess_Amount"].ToString()),
                        Total_TDS_Amount = GetValue<float>(drrr["Total_TDS_Amount"].ToString()),
                    });
                }
            }
            return tbl;
        }
        public List<tbl_salary_structure> BAL_BindOnPageLoad(tbl_Employee_Master obj)
        {
            try
            {
                List<tbl_salary_structure> tblEmp = new List<tbl_salary_structure>();
                using (SqlDataReader drrr = objDAL_ReportChallanSalaryStatement.DAL_BindOnPageLoad(obj))
                {
                    while (drrr.Read())
                    {
                        tblEmp.Add(new tbl_salary_structure()
                        {
                            Employee_ID = GetValue<int>(drrr["id"].ToString()),
                            EmpName = GetValue<string>(drrr["Name"].ToString()),
                            Grade_Name = GetValue<string>(drrr["Selection"].ToString())
                        });
                    }
                }
                return tblEmp;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
