using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;
using System.Data;
using CommonLibrary;

using System.Data.SqlClient;
using System.Globalization;

namespace BusinessLayer
{
    public class BAL_ManageSalary_ChallanList : CommonFunctions
    {
        DAL_ManageSalary_ChallanList obj = new DAL_ManageSalary_ChallanList();
        DataSet ds;

        public int CompanyID { get; set; }

        public string FinancialStart { get; set; }

        public string FinancialEnd { get; set; }

        public string ChallanDate { get; set; }
        public int Challanid { get; set; }
        public string ChallanNo { get; set; }

        public string Quarter { get; set; }

        public string FromType { get; set; }
        public string Result { get; set; }


        public DataSet Get_Queter_Selection_Challan_Non_Salary_Grid()
        {
            try
            {
                obj.Quater = Quarter;
                obj.ChallanNo = ChallanNo;
                obj.ChallanDate = ChallanDate;
                obj.CompanyID = CompanyID;
                obj.FinancialStart = FinancialStart;
                obj.FinancialEnd = FinancialEnd;
                obj.FromType = FromType;
                ds = obj.Get_Queter_Selection_Challan_Non_Salary_Grid();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet Get_Challan_Non_Salary()
        {
            try
            {
                obj.CompanyID = CompanyID;
                obj.Quater = Quarter;
                obj.FromType = FromType;
                ds = obj.Get_Challan_Non_Salary();
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public DataSet Get_Challan_Salary()
        {
            try
            {
                obj.CompanyID = CompanyID;
                obj.Quater = Quarter;
                obj.FromType = FromType;
                ds = obj.Get_Challan_Salary();
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public DataSet BAL_Challan_Verify()
        {
            try
            {
                obj.CompanyID = CompanyID;
                obj.Result = Result;
                obj.FromType = FromType;

                ds = obj.DAL_Challan_Verify();
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet BAL_Compliance()
        {
            try
            {
                obj.CompanyID = CompanyID;
                obj.Result = Result;

                ds = obj.DAL_Compliance();
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int ChallanID { get; set; }

        public int DeleteNonSalaryChallanID()
        {
            try
            {
                obj.ChallanID = ChallanID;
                int result = obj.DeleteNonSalaryChallanID();
                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet BAL_GetAll_NonSalaryChallan_From_SP_Call()
        {
            try
            {
                obj.CompanyID = CompanyID;
                obj.FinancialStart = FinancialStart;
                obj.FinancialEnd = FinancialEnd;
                ds = obj.DAL_GetAll_NonSalaryChallan_From_SP_Call();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public IEnumerable<objChallanDetails> BAL_Dashboard_Challan(objChallanDetails tobj)
        {
            List<objChallanDetails> obj_Dash = new List<objChallanDetails>();
            try
            {

                using (SqlDataReader drrr = obj.DAL_GetChallanGridDashboard(tobj))
                {
                    while (drrr.Read())
                    {
                        obj_Dash.Add(new objChallanDetails()
                        {

                            ChallanNo = GetValue<int>(drrr["Challan_No"].ToString()),
                            ChallanDate = GetValue<string>(drrr["Challan_Date"].ToString()),
                            BSR = GetValue<string>(drrr["Bank_Bsrcode"].ToString()),
                            CAmount = GetValue<double>(drrr["Challan_Amount"].ToString()),
                            Verify = GetValue<string>(drrr["Trans_No"].ToString()),
                            Sec = GetValue<string>(drrr["Section"].ToString()),
                            Interest = GetValue<float>(drrr["Interest_Amt"].ToString()),
                            TDS = GetValue<float>(drrr["TDS_Amount"].ToString()),
                            CTotal  = GetValue<double >(drrr["TotalEmployee"].ToString()),
                            
                        });
                    }

                }
                
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return obj_Dash as IEnumerable<objChallanDetails>;
        }

    }
}
