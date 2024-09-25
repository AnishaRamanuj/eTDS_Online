using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;
using CommonLibrary;
using System.Data.SqlClient;

namespace BusinessLayer
{
    public class BAL_Report_From12BA : CommonFunctions
    {
        DAL_Report_From12BA objDAL_Report_From12BA = new DAL_Report_From12BA();

        public List<tbl_salary_structure> BAL_GetEmployeeForSelection(CommonLibrary.tbl_Employee_Master obj)
        {
            List<tbl_salary_structure> tbl = new List<tbl_salary_structure>();
            using (SqlDataReader drrr = objDAL_Report_From12BA.DAL_GetEmployeeForSelection(obj))
            {
                while (drrr.Read())
                {
                    tbl.Add(new tbl_salary_structure()
                    {
                        RowNumber = GetValue<int>(drrr["SrNo"].ToString()),
                        Employee_ID = GetValue<int>(drrr["Employee_ID"].ToString()),
                        FirstName = GetValue<string>(drrr["FirstName"].ToString()),
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

        public List<tbl_Perquisites> BAL_GetEmployeePerquisitesDetails(tbl_Employee_Master obj)
        {
            List<tbl_Perquisites> tbl = new List<tbl_Perquisites>();
            using (SqlDataReader drrr = objDAL_Report_From12BA.DAL_GetEmployeePerquisitesDetails(obj))
            {
                while (drrr.Read())
                {
                    tbl.Add(new tbl_Perquisites()
                    {
                        Employee_ID = GetValue<int>(drrr["Employee_ID"].ToString()),
                        Perquisites_Name = GetValue<string>(drrr["Perquisites_Name"].ToString()),
                        Perquisites_Value = GetValue<float>(drrr["Perquisites_Value"].ToString()),
                        EmployeePaid_Amt = GetValue<float>(drrr["EmployeePaid_Amt"].ToString()),
                        Taxable_Amt = GetValue<float>(drrr["Taxable_Amt"].ToString()),
                        FirstName = GetValue<string>(drrr["FirstName"].ToString()),
                        PAN_NO = GetValue<string>(drrr["PAN_NO"].ToString()),
                        Designation_Name = GetValue<string>(drrr["Designation_Name"].ToString()),
                        GrossEarn1 = GetValue<double>(drrr["GrossEarn1"].ToString()),
                        Itax2 = GetValue<double>(drrr["Itax2"].ToString())
                    });
                }
            }
            return tbl;
        }
    }
}
