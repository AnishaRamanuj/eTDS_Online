using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;
using System.Data;

namespace BusinessLayer
{
    public class BAL_EReturns_NonSalary
    {
        DAL_EReturns_NonSalary objDAL_EReturns_NonSalary = new DAL_EReturns_NonSalary();

        public int Company_ID { get; set; }

        public string Quater { get; set; }

        public string FromType { get; set; }
        public DateTime CurDate { get; set; }


        public DataSet BAL_GetNonSalaryNRI()
        {
            try
            {
                objDAL_EReturns_NonSalary.Company_ID = Company_ID;
                objDAL_EReturns_NonSalary.Quater = Quater;
                objDAL_EReturns_NonSalary.FromType = FromType;
                DataSet ds = objDAL_EReturns_NonSalary.DAL_GetNonSalaryNRI();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet BAL_GetNonSalaryEreturnsDetails()
        {
            try
            {
                objDAL_EReturns_NonSalary.Company_ID = Company_ID;
                objDAL_EReturns_NonSalary.Quater = Quater;
                objDAL_EReturns_NonSalary.FromType = FromType;
                DataSet ds = objDAL_EReturns_NonSalary.DAL_GetNonSalaryEreturnsDetails();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }




        public DataSet BAL_NonSalaryValidation()
        {
            try
            {
                objDAL_EReturns_NonSalary.Company_ID = Company_ID;
                objDAL_EReturns_NonSalary.Quater = Quater;
                objDAL_EReturns_NonSalary.FromType = FromType;

                DataSet ds = objDAL_EReturns_NonSalary.DAL_NonSalaryValidation();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        public DataSet BAL_getTotalChallan_NonSalary()
        {
            try
            {
                objDAL_EReturns_NonSalary.Company_ID = Company_ID;
                objDAL_EReturns_NonSalary.Quater = Quater;
                objDAL_EReturns_NonSalary.FromType = FromType;
                DataSet ds = objDAL_EReturns_NonSalary.DAL_getTotalChallan_NonSalary();
                return ds;
            }
            catch(Exception ex)
            {
                throw ex;

            }
        }
        public DataSet BAL_getnonsalarychallangedetails()
        {
            try
            {
                objDAL_EReturns_NonSalary.Company_ID = Company_ID;
                DataSet ds = objDAL_EReturns_NonSalary.DAL_getnonsalarydetails();
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public DataSet BAL_getsalarychallangedetails()
        {
            try
            {
                objDAL_EReturns_NonSalary.Company_ID = Company_ID;
                DataSet ds = objDAL_EReturns_NonSalary.DAL_getsalarydetails();
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        

        public int Formno { get; set; }

        public string Form { get; set; }

        public string PreviousRTN { get; set; }

        public string PreviousTkn { get; set; }

        public string fYear { get; set; }

        public string aYear { get; set; }

        public DataSet BAL_GenerateTextFile()
        {
            try
            {
                objDAL_EReturns_NonSalary.Company_ID = Company_ID;
                objDAL_EReturns_NonSalary.Formno = Formno;
                objDAL_EReturns_NonSalary.Form = Form;
                objDAL_EReturns_NonSalary.PreviousTkn = PreviousTkn;
                objDAL_EReturns_NonSalary.PreviousRTN = PreviousRTN;
                objDAL_EReturns_NonSalary.aYear = aYear;
                objDAL_EReturns_NonSalary.fYear = fYear;
                objDAL_EReturns_NonSalary.Quater = Quater;
                DataSet ds = objDAL_EReturns_NonSalary.DAL_GenerateTextFile();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet BAL_NonSalaryEretursDetailsOnPageLoad()
        {
            try
            {
                objDAL_EReturns_NonSalary.Company_ID = Company_ID;
                DataSet ds = objDAL_EReturns_NonSalary.DAL_NonSalaryEretursDetailsOnPageLoad();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }


        public DataSet BAL_EretursDates()
        {
            try
            {
                objDAL_EReturns_NonSalary.CurDate = CurDate;
                DataSet ds = objDAL_EReturns_NonSalary.DAL_EretursDates();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        /// <summary>
        /// Forcasting
        /// </summary>
        public string filetype { get; set; }
        public string Fcreatdate { get; set; }
        public string TAN { get; set; }
        public string Challancnt { get; set; }
        public string FormNo { get; set; }
        public string PANNo { get; set; }
        public string Period { get; set; }
        public string CompanyName { get; set; }
        public string TokenNo { get; set; }
        public string Dectuctor { get; set; }
        public string FinYear { get; set; }
        public string CDRecNo { get; set; }
        public string BnkChlNo { get; set; }
        public string BSR { get; set; }
        public string ToDepoAmt { get; set; }
        public string TDepodeductee { get; set; }
        public string IntDed { get; set; }
        public string ChallaneDate { get; set; }
        public string isChallaneMatch { get; set; }

        public string LineNo { get; set; }
        public string DDRecNo { get; set; }
        public string DedCode { get; set; }
        public string PAN { get; set; }
        public string PartyName { get; set; }
        public string Itax { get; set; }
        public string Surcharge { get; set; }
        public string Cess { get; set; }
        public string TaxDed { get; set; }
        public string TaxDepo { get; set; }
        public string AmtPaid { get; set; }
        public string PaidDate { get; set; }
        public string DedDate { get; set; }
        public string Rate { get; set; }
        public string Remarks1 { get; set; }
        public string TDSSECTION { get; set; }
        public string Challan_DueDate { get; set; }
        public string isPANValidationReq { get; set; }
        public string PAN_Status { get; set; }
        public string DelayedDedMonth { get; set; }
        public string DelayedDepMonth { get; set; }
        public string Total_Interest { get; set; }
        public string DelayedDedAmt { get; set; }
        public string Chl_date { get; set; }
        public string Deductee_Status { get; set; }
        public string Prescribed_Rate { get; set; }
        public int Short_DedAmt { get; set; }
        public int jAmt { get; set; }
        public int id { get; set; }
        public string Reason1 { get; set; }

        public string StrForm { get; set; }
        public string Quarter { get; set; }


        public DataSet BAL_DNFFileHeader()
        {
            try
            {
                objDAL_EReturns_NonSalary.filetype = filetype;
                objDAL_EReturns_NonSalary.Fcreatdate = Fcreatdate;
                objDAL_EReturns_NonSalary.TAN = TAN;
                DataSet ds = objDAL_EReturns_NonSalary.DAL_DNFHeader();
                return ds;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        public DataSet BAL_DNFBatch()
        {
            try
            {
                objDAL_EReturns_NonSalary.Challancnt = Challancnt;
                objDAL_EReturns_NonSalary.FormNo = FormNo;
                objDAL_EReturns_NonSalary.TAN = TAN;
                objDAL_EReturns_NonSalary.PANNo = PANNo;
                objDAL_EReturns_NonSalary.FinYear = FinYear;
                objDAL_EReturns_NonSalary.Period = Period;
                objDAL_EReturns_NonSalary.CompanyName = CompanyName;
                objDAL_EReturns_NonSalary.TokenNo = TokenNo;
                objDAL_EReturns_NonSalary.Dectuctor = Dectuctor;
                DataSet ds = objDAL_EReturns_NonSalary.DAL_DNFBatch();
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet BAL_DNFChallan()
        {
            try
            {
                objDAL_EReturns_NonSalary.CDRecNo = CDRecNo;
                objDAL_EReturns_NonSalary.BnkChlNo = BnkChlNo;
                objDAL_EReturns_NonSalary.ToDepoAmt = ToDepoAmt;
                objDAL_EReturns_NonSalary.TDepodeductee = TDepodeductee;
                objDAL_EReturns_NonSalary.BSR = BSR;
                objDAL_EReturns_NonSalary.IntDed = IntDed;
                objDAL_EReturns_NonSalary.ChallaneDate = ChallaneDate;
                objDAL_EReturns_NonSalary.isChallaneMatch = isChallaneMatch;
                DataSet ds = objDAL_EReturns_NonSalary.DAL_DNFChallan();
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet BAL_DNFDedDetail()
        {
            try
            {
                objDAL_EReturns_NonSalary.LineNo = LineNo;
                objDAL_EReturns_NonSalary.CDRecNo = CDRecNo;
                objDAL_EReturns_NonSalary.DDRecNo = DDRecNo;
                objDAL_EReturns_NonSalary.DedCode = DedCode;
                objDAL_EReturns_NonSalary.PAN = PAN;
                objDAL_EReturns_NonSalary.PartyName = PartyName;
                objDAL_EReturns_NonSalary.Itax = Itax;
                objDAL_EReturns_NonSalary.Surcharge = Surcharge;
                objDAL_EReturns_NonSalary.Cess = Cess;
                objDAL_EReturns_NonSalary.TaxDed = TaxDed;
                objDAL_EReturns_NonSalary.TaxDepo = TaxDepo;
                objDAL_EReturns_NonSalary.AmtPaid = AmtPaid;
                objDAL_EReturns_NonSalary.PaidDate = PaidDate;
                objDAL_EReturns_NonSalary.DedDate = DedDate;
                objDAL_EReturns_NonSalary.Rate = Rate;
                objDAL_EReturns_NonSalary.Remarks1 = Remarks1;
                objDAL_EReturns_NonSalary.TDSSECTION = TDSSECTION;
                objDAL_EReturns_NonSalary.Challan_DueDate = Challan_DueDate;
                objDAL_EReturns_NonSalary.isPANValidationReq = isPANValidationReq;
                objDAL_EReturns_NonSalary.PAN_Status = PAN_Status;
                objDAL_EReturns_NonSalary.Deductee_Status = Deductee_Status;
                objDAL_EReturns_NonSalary.DelayedDedMonth = DelayedDedMonth;
                objDAL_EReturns_NonSalary.DelayedDepMonth = DelayedDepMonth;
                objDAL_EReturns_NonSalary.Total_Interest = Total_Interest;
                objDAL_EReturns_NonSalary.DelayedDedAmt = DelayedDedAmt;
                objDAL_EReturns_NonSalary.Chl_date = Chl_date;
                DataSet ds = objDAL_EReturns_NonSalary.DAL_DNFDedDetail();
                return ds;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        public DataSet BAL_DNFCalc()
        {
            try
            {
                DataSet ds = objDAL_EReturns_NonSalary.DAL_DNFCalc();
                return ds;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        public DataSet BAL_DNFUpdatePR()
        {
            try
            {
                objDAL_EReturns_NonSalary.Prescribed_Rate = Prescribed_Rate;
                objDAL_EReturns_NonSalary.LineNo = LineNo;
                objDAL_EReturns_NonSalary.id = id;
                objDAL_EReturns_NonSalary.Short_DedAmt = Short_DedAmt;
                objDAL_EReturns_NonSalary.jAmt = jAmt;
                objDAL_EReturns_NonSalary.Reason1 = Reason1;
                DataSet ds = objDAL_EReturns_NonSalary.DAL_DNFUpdatePR();
                return ds;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        public DataSet BAL_DNF_SummaryXL()
        {
            try
            {
                objDAL_EReturns_NonSalary.StrForm = StrForm;
                objDAL_EReturns_NonSalary.Quarter = Period;
                DataSet ds = objDAL_EReturns_NonSalary.DAL_DNF_SummaryXL();
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
