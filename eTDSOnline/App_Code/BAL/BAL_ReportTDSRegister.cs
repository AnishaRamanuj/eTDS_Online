using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;
using System.Data;

namespace BusinessLayer
{
    public class BAL_ReportTDSRegister
    {
        DAL_ReportTDSRegister objDAL_ReportTDSRegister = new DAL_ReportTDSRegister();

        public int Company_ID { get; set; }

        public DataSet BAl_GetAllReporstCompanyDetails()
        {
            try
            {
                objDAL_ReportTDSRegister.Section = Section;
                objDAL_ReportTDSRegister.Nature_Name = Nature_Name;
                objDAL_ReportTDSRegister.Branch_Name = Branch_Name;
                objDAL_ReportTDSRegister.Deductee_Type = Deductee_Type;
                objDAL_ReportTDSRegister.FromDate = FromDate;
                objDAL_ReportTDSRegister.Todate = Todate;
                objDAL_ReportTDSRegister.Company_ID = Company_ID;
                DataSet ds = objDAL_ReportTDSRegister.DAl_GetAllReporstCompanyDetail();
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet BAl_GetReportChallanDetails()
        {
            try
            {
                objDAL_ReportTDSRegister.Company_ID = Company_ID;
                DataSet ds = objDAL_ReportTDSRegister.DAl_GetReportChallanDetails();
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string Section { get; set; }
        public string Nature_Name { get; set; }
        public string Branch_Name { get; set; }

        public string Deductee_Type { get; set; }

        public DateTime FromDate { get; set; }

        public DateTime Todate { get; set; }
    }
}
