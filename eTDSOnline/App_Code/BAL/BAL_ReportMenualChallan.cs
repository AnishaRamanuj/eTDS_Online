using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;
using CommonLibrary;
using System.Data.SqlClient;
using System.Data;

namespace BusinessLayer
{
    public class BAL_ReportMenualChallan : CommonFunctions
    {
        DAL_ReportMenualhallan objDAL_ReportMenualChallan = new DAL_ReportMenualhallan();
        //public string Naturesection { get; set; }
        //public string NatureName { get; set; }
        //public int Company_ID { get; set; }

        public DataSet BAl_GetNatureSection()
        {
            try
            {
                DataSet ds = objDAL_ReportMenualChallan.DAl_GetNatureSection();
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet BAL_GetBankName(int Compid)
        {
            try
            {
                DataSet ds = objDAL_ReportMenualChallan.DAL_GetBankName(Compid);
                    return ds;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        public List<tbl_CompanyDetail> BAL_GetCompanyDetail(tbl_CompanyDetail obj)
        {
            List<tbl_CompanyDetail> tbl = new List<tbl_CompanyDetail>();
            using (SqlDataReader drrr = objDAL_ReportMenualChallan.DAL_GetCompanyDetail(obj))
            {
                while (drrr.Read())
                {
                    tbl.Add(new tbl_CompanyDetail()
                    {
                        Add1 = GetValue<string>(drrr["Add1"].ToString()),
                        Add2 = GetValue<string>(drrr["Add2"].ToString()),
                        TeleNo = GetValue<string>(drrr["Tele"].ToString()),
                        TAN = GetValue<string>(drrr["TANNO"].ToString()),
                        PAN = GetValue<string>(drrr["PANNo"].ToString()),
                    });
                }
            }
            return tbl;
        }
        //public List<tbl_Report_Challan> BAL_GetNatureName(tbl_Report_Challan obj)
        //{
        //    List<tbl_Report_Challan> tbl = new List<tbl_Report_Challan>();
        //    using (SqlDataReader drrr = objDAL_ReportMenualChallan.DAL_GetNatureName(obj))
        //    {
        //        while (drrr.Read())
        //        {
        //            tbl.Add(new tbl_Report_Challan()
        //            {
        //                Nature_nature = GetValue<string>(drrr["Nature_Name"].ToString()),
        //                Section = GetValue<string>(drrr["Section"].ToString()),

        //            });
        //        }
        //    }
        //    return tbl;
        //}


    }
}
