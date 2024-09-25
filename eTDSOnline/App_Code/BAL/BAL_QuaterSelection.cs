using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;
using System.Data;

namespace BusinessLayer
{
    public class BAL_QuaterSelection
    {
        DataSet ds;
        DAL_QuaterSelection objDAL_QuaterSelection = new DAL_QuaterSelection();
        int result = 0;
        public string ChallanDate { get; set; }
        public string ChallanNo { get; set; }
        public string Quater { get; set; }
        public string StarYear { get; set; }
        public int CompanyID { get; set; }
        public string EndYear { get; set; }

        public DataSet BAL_bindGirdGvChallanEntries()
        {
            try
            {
                objDAL_QuaterSelection.StarYear = StarYear;
                objDAL_QuaterSelection.CompanyID = CompanyID;
                objDAL_QuaterSelection.EndYear = EndYear;
                ds = objDAL_QuaterSelection.DAL_bindGirdGvChallanEntries();
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet BAL_BindGridQuater()
        {
            try
            {
                objDAL_QuaterSelection.Quater = Quater;
                objDAL_QuaterSelection.ChallanNo = ChallanNo;
                objDAL_QuaterSelection.ChallanDate = ChallanDate;
                objDAL_QuaterSelection.CompanyID = CompanyID;
                objDAL_QuaterSelection.FinancialStart = FinancialStart;
                objDAL_QuaterSelection.FinancialEnd = FinancialEnd;
                ds = objDAL_QuaterSelection.DAL_BindGridQuater();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }



        public string FinancialStart { get; set; }

        public string FinancialEnd { get; set; }


        public DataSet Get_Queter_Selection_Challan_Non_Salary_Grid()
        {
            try
            {
                objDAL_QuaterSelection.Quater = Quater;
                objDAL_QuaterSelection.ChallanNo = ChallanNo;
                objDAL_QuaterSelection.ChallanDate = ChallanDate;
                objDAL_QuaterSelection.CompanyID = CompanyID;
                objDAL_QuaterSelection.FinancialStart = FinancialStart;
                objDAL_QuaterSelection.FinancialEnd = FinancialEnd;
                ds = objDAL_QuaterSelection.Get_Queter_Selection_Challan_Non_Salary_Grid();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public int DeleteChallanID()
        {
            try
            {
                objDAL_QuaterSelection.ChallanID = ChallanID;
                result = objDAL_QuaterSelection.DeleteChallanID();
                return result;
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }

        public int ChallanID { get; set; }

        public int DeleteSalaryChallanID()
        {
            try
            {
                objDAL_QuaterSelection.ChallanID = ChallanID;
                result = objDAL_QuaterSelection.DeleteSalaryChallanID();
                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}
