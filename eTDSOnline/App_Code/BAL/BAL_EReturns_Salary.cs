using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;
using System.Data;

namespace BusinessLayer
{
    public class BAL_EReturns_Salary
    {
        DAL_EReturns_Salary objDAL_EReturns_Salary = new DAL_EReturns_Salary();
        public int Company_ID { get; set; }
        public string Quater { get; set; }

        DataSet ds;

        public DataSet BAL_GetEreturnsDetails()
        {
            try
            {
                objDAL_EReturns_Salary.Quater = Quater;
                objDAL_EReturns_Salary.Company_ID = Company_ID;
                ds = objDAL_EReturns_Salary.DAL_GetEreturnsDetails();
                return ds;
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }

        public int Formno { get; set; }

        public string Form { get; set; }

        public string PreviousTkn { get; set; }

        public string PreviousRTN { get; set; }

        public string aYear { get; set; }

        public string fYear { get; set; }

        public DataSet BAL_GenerateTextFile(bool nilreturns)
        {
            try
            {
                objDAL_EReturns_Salary.Company_ID = Company_ID;
                objDAL_EReturns_Salary.Formno = Formno;
                objDAL_EReturns_Salary.Form = Form;
                objDAL_EReturns_Salary.PreviousTkn = PreviousTkn;
                objDAL_EReturns_Salary.PreviousRTN =PreviousRTN;
                objDAL_EReturns_Salary.aYear = aYear;
                objDAL_EReturns_Salary.fYear=fYear;
                objDAL_EReturns_Salary.Quater = Quater;
                ds = objDAL_EReturns_Salary.DAL_GenerateTextFile(nilreturns);
                return ds;
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }

    }
}
