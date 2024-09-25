using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;
using System.Data;

namespace BusinessLayer
{
    public class BAL_BulkPan_Verification_AllVoucher
    {
        DAL_BulkPan_Verification_AllVoucher obj = new DAL_BulkPan_Verification_AllVoucher();

        public DataSet BAL_GetAllCompanyVoucherVerification()
        {
            try
            {
                obj.Company_ID = Company_ID;
                obj.Verfy = Verfy;
                DataSet ds = obj.DAL_GetAllCompanyVoucherVerification();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }



        public DataSet BAL_SalaryPANVerification()
        {
            try
            {
                obj.Company_ID = Company_ID;
                obj.Verfy = Verfy;
                DataSet ds = obj.DAL_SalaryPANVerification();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet BAL_BulkSalaryPANVerification(string PAN)
        {
            try
            {
                obj.Company_ID = Company_ID;
                DataSet ds = obj.DAL_BulkSalaryPANVerification(PAN);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }


        public DataSet BAL_BulkNonSalaryPANVerification(string PAN)
        {
            try
            {
                obj.Company_ID = Company_ID;
                DataSet ds = obj.DAL_BulkNonSalaryPANVerification(PAN);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public int Company_ID { get; set; }
        public string Verfy { get; set; }
        public string PANSts { get; set; }

        public DataTable PANVerificaionDataTable { get; set; }

        public int BAL_UpdatePANVerification()
        {
            try
            {
                obj.Company_ID = Company_ID;
                obj.PANVerificaionDataTable = PANVerificaionDataTable;
                int result = obj.DAL_UpdatePANVerification();
                return result;
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }
    }
}
