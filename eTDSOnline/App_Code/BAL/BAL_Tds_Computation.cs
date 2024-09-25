using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;
using System.Data.SqlClient;
using CommonLibrary;

namespace BusinessLayer
{
    public class BAL_Tds_Computation : CommonFunctions
    {
        DAL_Tds_Computation objDAL_Tds_Computation = new DAL_Tds_Computation();

        public int _Employee_ID { get; set; }
        public int _Company_ID { get; set; }
        public string _FirstName { get; set; }
        public string _LastName { get; set; }
        public string _Designation_Name { get; set; }
        public string _Department_Name { get; set; }
        public string _Gender { get; set; }
        public string _Senior_CTZN_Type { get; set; }
        public double _Surcharge { get; set; }
        public double _Total_Earnings { get; set; }
        public double _GrossPerks_B { get; set; }
        public double _GrossProfits_C { get; set; }
        public double _GrossTotal_D { get; set; }
        public double _GrossEarn1 { get; set; }
        public double _Section_10 { get; set; }
        public double _GrossEarn3 { get; set; }
        public double _PreSal { get; set; }
        public double _TotalDeduction { get; set; }
        public double _StandardDeductions { get; set; }
        public double _Entertainment { get; set; }
        public double _PTax { get; set; }
        public double _GrossEarn5 { get; set; }
        public double _IntHouseLoan { get; set; }
        public double _OtherIncome { get; set; }
        public double _GrossEarn8 { get; set; }
        public double _Rebate80C { get; set; }
        public double _PF { get; set; }
        public double _RebateBonds { get; set; }
        public double _Rebate80CCC { get; set; }
        public double _Rebate80CCD { get; set; }
        public double _Rebate80CCD2 { get; set; }
        public double _Rebate80QlfySal { get; set; }
        public double _Rebate80NetSal { get; set; }
        public double _Rebate88D { get; set; }
        public double _Rebate80DD { get; set; }
        public double _Rebate80DDB { get; set; }
        public double _Rebate80QQB { get; set; }
        public double _Rebate80E { get; set; }
        public double _Rebate80EE { get; set; }
        public double _Rebate80G { get; set; }
        public double _Rebate80GG { get; set; }
        public double _Rebate80GGA { get; set; }
        public double _Rebate80GGC { get; set; }
        public double _Rebate80RRB { get; set; }
        public double _Rebate80U { get; set; }
        public double _Rebate80CCG { get; set; }
        public double _Rebate80TTA { get; set; }
        public double _TotalRebate { get; set; }
        public double _Grossnet { get; set; }
        public double _Itax1 { get; set; }
        public double _Rebatetds { get; set; }
        public double _EducationCess { get; set; }
        public double _HighEduCess { get; set; }
        public double _Itax2 { get; set; }
        public double _Rebate89 { get; set; }
        public double _Itax3 { get; set; }
        public double _Itax4 { get; set; }
        public double _PreTds { get; set; }
        public double _FinalTax { get; set; }
        public double _Manual { get; set; }
        public string _Rsinwords { get; set; }
        public int _sel { get; set; }
        public double _HRate { get; set; }

        //public DataSet Get_TDS_Computation_Details()
        //{
        //    DataSet ds = new DataSet();
        //    try
        //    {
        //        objDAL_Tds_Computation._Company_ID = _Company_ID;
        //        objDAL_Tds_Computation._Employee_ID = _Employee_ID;
        //        ds = objDAL_Tds_Computation.Get_TDS_Computation_Details();
        //    }
        //    catch (Exception)
        //    {

        //        throw;
        //    }
        //    return ds;
        //}

        //public DataSet Insert_TDS_Computation()
        //{
        //    DataSet ds = new DataSet();
        //    try
        //    {
        //        objDAL_Tds_Computation._Employee_ID = _Employee_ID;
        //        ds = objDAL_Tds_Computation.Insert_TDS_Computation();
        //    }
        //    catch (Exception)
        //    {
        //        throw;
        //    }
        //    return ds;
        //}

        //public int Update_TDS_Computation()
        //{
        //    int ds = 0;

        //    try
        //    {
        //        objDAL_Tds_Computation._Employee_ID = _Employee_ID;
        //        objDAL_Tds_Computation._Company_ID = _Company_ID;
        //        objDAL_Tds_Computation._FirstName = _FirstName;
        //        objDAL_Tds_Computation._LastName = _LastName;
        //        objDAL_Tds_Computation._Designation_Name = _Designation_Name;
        //        objDAL_Tds_Computation._Department_Name = _Department_Name;
        //        objDAL_Tds_Computation._Gender = _Gender;
        //        objDAL_Tds_Computation._Senior_CTZN_Type = _Senior_CTZN_Type;
        //        objDAL_Tds_Computation._Surcharge = _Surcharge;
        //        objDAL_Tds_Computation._Total_Earnings = _Total_Earnings;
        //        objDAL_Tds_Computation._GrossPerks_B = _GrossPerks_B;
        //        objDAL_Tds_Computation._GrossProfits_C = _GrossProfits_C;
        //        objDAL_Tds_Computation._GrossTotal_D = _GrossTotal_D;
        //        objDAL_Tds_Computation._GrossEarn1 = _GrossEarn1;
        //        objDAL_Tds_Computation._Section_10 = _Section_10;
        //        objDAL_Tds_Computation._GrossEarn3 = _GrossEarn3;
        //        objDAL_Tds_Computation._PreSal = _PreSal;
        //        objDAL_Tds_Computation._TotalDeduction = _TotalDeduction;
        //        objDAL_Tds_Computation._Entertainment = _Entertainment;
        //        objDAL_Tds_Computation._StandardDeductions = _StandardDeductions;
        //        objDAL_Tds_Computation._PTax = _PTax;
        //        objDAL_Tds_Computation._GrossEarn5 = _GrossEarn5;
        //        objDAL_Tds_Computation._IntHouseLoan = _IntHouseLoan;
        //        objDAL_Tds_Computation._OtherIncome = _OtherIncome;
        //        objDAL_Tds_Computation._GrossEarn8 = _GrossEarn8;
        //        objDAL_Tds_Computation._Rebate80C = _Rebate80C;
        //        objDAL_Tds_Computation._PF = _PF;
        //        objDAL_Tds_Computation._RebateBonds = _RebateBonds;
        //        objDAL_Tds_Computation._Rebate80CCC = _Rebate80CCC;
        //        objDAL_Tds_Computation._Rebate80CCD = _Rebate80CCD;
        //        objDAL_Tds_Computation._Rebate80CCD2 = _Rebate80CCD2;
        //        objDAL_Tds_Computation._Rebate80QlfySal = _Rebate80QlfySal;
        //        objDAL_Tds_Computation._Rebate80NetSal = _Rebate80NetSal;
        //        objDAL_Tds_Computation._Rebate88D = _Rebate88D;
        //        objDAL_Tds_Computation._Rebate80DD = _Rebate80DD;
        //        objDAL_Tds_Computation._Rebate80DDB = _Rebate80DDB;
        //        objDAL_Tds_Computation._Rebate80QQB = _Rebate80QQB;
        //        objDAL_Tds_Computation._Rebate80E = _Rebate80E;
        //        objDAL_Tds_Computation._Rebate80EE = _Rebate80EE;
        //        objDAL_Tds_Computation._Rebate80G = _Rebate80G;
        //        objDAL_Tds_Computation._Rebate80GG = _Rebate80GG;
        //        objDAL_Tds_Computation._Rebate80GGA = _Rebate80GGA;
        //        objDAL_Tds_Computation._Rebate80GGC = _Rebate80GGC;
        //        objDAL_Tds_Computation._Rebate80RRB = _Rebate80RRB;
        //        objDAL_Tds_Computation._Rebate80U = _Rebate80U;
        //        objDAL_Tds_Computation._Rebate80CCG = _Rebate80CCG;
        //        objDAL_Tds_Computation._Rebate80TTA = _Rebate80TTA;
        //        objDAL_Tds_Computation._TotalRebate = _TotalRebate;
        //        objDAL_Tds_Computation._Grossnet = _Grossnet;
        //        objDAL_Tds_Computation._Itax1 = _Itax1;
        //        objDAL_Tds_Computation._Rebatetds = _Rebatetds;
        //        objDAL_Tds_Computation._EducationCess = _EducationCess;
        //        objDAL_Tds_Computation._HighEduCess = _HighEduCess;
        //        objDAL_Tds_Computation._Itax2 = _Itax2;
        //        objDAL_Tds_Computation._Rebate89 = _Rebate89;
        //        objDAL_Tds_Computation._Itax3 = _Itax3;
        //        objDAL_Tds_Computation._Itax4 = _Itax4;
        //        objDAL_Tds_Computation._PreTds = _PreTds;
        //        objDAL_Tds_Computation._FinalTax = _FinalTax;
        //        objDAL_Tds_Computation._Manual = _Manual;
        //        objDAL_Tds_Computation._Rsinwords = _Rsinwords;
        //        objDAL_Tds_Computation._sel = _sel;
        //        objDAL_Tds_Computation._HRate = _HRate;
        //        objDAL_Tds_Computation._dtdgPerquisites_Master = _dtdgPerquisites_Master;
        //        objDAL_Tds_Computation._dtdgPF = _dtdgPF;
        //        objDAL_Tds_Computation.MontlySalData = MontlySalData;
        //        objDAL_Tds_Computation.dtProfessionTax = dtProfessionTax;
        //        objDAL_Tds_Computation._ChallanTAX = _ChallanTAX;
        //        objDAL_Tds_Computation._Rebate80CCD1B = _Rebate80CCD1B;
        //        objDAL_Tds_Computation.dtdgSection10 = dtdgSection10;
        //        ds = objDAL_Tds_Computation.Update_TDS_Computation();
        //    }
        //    catch (Exception)
        //    {

        //        throw;
        //    }
        //    return ds;
        //}



        //public DataSet BAL_BindRebateMasterDropdown()
        //{
        //    try
        //    {

        //        DataSet ds = objDAL_Tds_Computation.DAL_BindRebateMasterDropdown();
        //        return ds;
        //    }
        //    catch (Exception ex)
        //    {

        //        throw ex;
        //    }
        //}

        public int ddlSection80Ctext { get; set; }

        public double Section80CAmt { get; set; }

        //public int BAL_InsertRebateMaster()
        //{
        //    try
        //    {
        //        int result = 0;
        //        objDAL_Tds_Computation._Company_ID = _Company_ID;
        //        objDAL_Tds_Computation._Employee_ID = _Employee_ID;
        //        objDAL_Tds_Computation.ddlSection80Ctext = ddlSection80Ctext;
        //        objDAL_Tds_Computation.Section80CAmt = Section80CAmt;
        //        result = objDAL_Tds_Computation.DAL_InsertRebateMaster();
        //        return result;
        //    }
        //    catch (Exception ex)
        //    {

        //        throw ex;
        //    }
        //}

        //public DataSet BAL_BindRebateMasterdgPFGrid()
        //{
        //    try
        //    {
        //        objDAL_Tds_Computation._Employee_ID = _Employee_ID;
        //        objDAL_Tds_Computation._Company_ID = _Company_ID;
        //        DataSet ds = objDAL_Tds_Computation.DAL_BindRebateMasterdgPFGrid();
        //        return ds;
        //    }
        //    catch (Exception ex)
        //    {

        //        throw ex;
        //    }

        //}

        public double _GrossIncome { get; set; }

        //public DataSet BAL_GetTaxOnTotalIncome()
        //{
        //    try
        //    {
        //        objDAL_Tds_Computation._Employee_ID = _Employee_ID;
        //        objDAL_Tds_Computation._Company_ID = _Company_ID;
        //        objDAL_Tds_Computation._GrossIncome = _GrossIncome;
        //        objDAL_Tds_Computation._PreTds = _PreTds;
        //        objDAL_Tds_Computation._Rebate89 = _Rebate89;
        //        DataSet ds = objDAL_Tds_Computation.DAL_GetTaxOnTotalIncome();
        //        return ds;
        //    }
        //    catch (Exception ex)
        //    {

        //        throw ex;
        //    }
        //}

        //public DataSet Get_Monthly_Head_Summary()
        //{
        //    DataSet ds = new DataSet();
        //    try
        //    {
        //        objDAL_Tds_Computation._Employee_ID = _Employee_ID;
        //        objDAL_Tds_Computation._Company_ID = _Company_ID;
        //        ds = objDAL_Tds_Computation.Get_Monthly_Head_Summary();
        //    }
        //    catch (Exception)
        //    {

        //        throw;
        //    }
        //    return ds;
        //}

        //public DataSet Get_Perquisites_List()
        //{
        //    DataSet ds = new DataSet();
        //    try
        //    {
        //        objDAL_Tds_Computation._Employee_ID = _Employee_ID;
        //        objDAL_Tds_Computation._Company_ID = _Company_ID;
        //        objDAL_Tds_Computation._Perquisites_ID = _Perquisites_ID;
        //        ds = objDAL_Tds_Computation.Get_Perquisites_List();
        //    }
        //    catch (Exception)
        //    {

        //        throw;
        //    }
        //    return ds;
        //}

        //public DataSet Get_Section_10_List()
        //{
        //    DataSet ds = new DataSet();
        //    try
        //    {
        //        objDAL_Tds_Computation._Employee_ID = _Employee_ID;
        //        objDAL_Tds_Computation._Company_ID = _Company_ID;
        //        objDAL_Tds_Computation._Head_ID = _Head_ID;
        //        ds = objDAL_Tds_Computation.Get_Section_10_List();
        //    }
        //    catch (Exception)
        //    {
        //        throw;
        //    }
        //    return ds;
        //}

        //public DataSet Get_Employee_ProfessionTax_List()
        //{
        //    DataSet ds = new DataSet();

        //    try
        //    {
        //        objDAL_Tds_Computation._Employee_ID = _Employee_ID;
        //        objDAL_Tds_Computation._Company_ID = _Company_ID;
        //        objDAL_Tds_Computation.MontlySalData = MontlySalData;
        //        objDAL_Tds_Computation.PFCalData = PFCalData;
        //        ds = objDAL_Tds_Computation.Get_Employee_ProfessionTax_List();
        //    }
        //    catch (Exception)
        //    {

        //        throw;
        //    }
        //    return ds;
        //}

        //public DataSet Get_Employee_Master_List()
        //{
        //    DataSet ds = new DataSet();
        //    try
        //    {
        //        objDAL_Tds_Computation._Company_ID = _Company_ID;
        //        objDAL_Tds_Computation._FirstName = _FirstName;
        //        objDAL_Tds_Computation._City = _City;
        //        objDAL_Tds_Computation._State_ID = _State_ID;
        //        objDAL_Tds_Computation._Designation_ID = _Designation_ID;
        //        objDAL_Tds_Computation._Branch_ID = _Branch_ID;
        //        objDAL_Tds_Computation._Department_ID = _Department_ID;
        //        objDAL_Tds_Computation._Email_ID = _Email_ID;
        //        objDAL_Tds_Computation._Category_ID = _Category_ID;
        //        objDAL_Tds_Computation._Grade_ID = _Grade_ID;
        //        objDAL_Tds_Computation._ResignStatus = _ResignStatus;
        //        objDAL_Tds_Computation._Is_Salary_Allocated = _Is_Salary_Allocated;
        //        objDAL_Tds_Computation._Employee_ID = _Employee_ID;
        //        objDAL_Tds_Computation._Is_Leave_Allocated = _Is_Leave_Allocated;

        //        ds = objDAL_Tds_Computation.Get_Employee_Master_List();
        //    }
        //    catch (Exception)
        //    {

        //        throw;
        //    }
        //    return ds;
        //}


        //public IEnumerable<tbl_HeadName> Gt_HeadName(int Compid, string Conn)
        //{
        
        //    List<tbl_HeadName> Ltbl_Head_Master = new List<tbl_HeadName>();
        //    using (SqlDataReader drrr = objDAL_Tds_Computation.DAL_HeadName(Compid, Conn))
        //    {
        //        while (drrr.Read())
        //        {
        //            Ltbl_Head_Master.Add(new tbl_HeadName()
        //            {
        //                Head_id = GetValue<int>(drrr["Head_ID"].ToString()),
        //                Head_Name = GetValue<string>(drrr["Head_Name"].ToString()),
        //                Head_Section = GetValue<string>(drrr["Head_Section"].ToString()),
        //            });
        //        }
        //    }
        //    return Ltbl_Head_Master as IEnumerable<tbl_HeadName>;
        //}





        //public IEnumerable<tbl_HeadName> BAL_UpdateHead(int Compid, string Conn, string Multi)
        //{

        //    List<tbl_HeadName> update_Head_Master = new List<tbl_HeadName>();
        //    using (SqlDataReader drrr = objDAL_Tds_Computation.DAL_UpdateHead(Compid, Conn, Multi))
        //    {
        //        while (drrr.Read())
        //        {
        //            update_Head_Master.Add(new tbl_HeadName()
        //            {
        //                Head_id = GetValue<int>(drrr["Headid"].ToString()),
        //            });
        //        }
        //    }
        //    return update_Head_Master as IEnumerable<tbl_HeadName>;
        //}

        public double _Rebate80E80EE { get; set; }

        public DataTable _dtdgPerquisites_Master { get; set; }

        public DataTable _dtdgPF { get; set; }

        public int _Perquisites_ID { get; set; }

        public int _Head_ID { get; set; }
        public int _Branch_ID { get; set; }

        public string _City { get; set; }

        public int _State_ID { get; set; }

        public int _Designation_ID { get; set; }

        public int _Department_ID { get; set; }

        public string _Email_ID { get; set; }

        public int _Category_ID { get; set; }

        public int _Grade_ID { get; set; }

        public int _ResignStatus { get; set; }

        public bool _Is_Salary_Allocated { get; set; }

        public int _Is_Leave_Allocated { get; set; }

        public DataTable MontlySalData { get; set; }


        //public DataSet BAL_CalcualteHRA()
        //{
        //    try
        //    {
        //        objDAL_Tds_Computation.Hra = Hra;
        //        objDAL_Tds_Computation._Employee_ID = _Employee_ID;
        //        objDAL_Tds_Computation._Company_ID = _Company_ID;
        //        DataSet ds = objDAL_Tds_Computation.DAL_CalcualteHRA();
        //        return ds;
        //    }
        //    catch (Exception ex)
        //    {

        //        throw ex;
        //    }
        //}

        public DataTable Hra { get; set; }

        //public DataSet BAL_GETALLHEADID()
        //{
        //    try
        //    {
        //        objDAL_Tds_Computation._Company_ID = _Company_ID;
        //        DataSet ds = objDAL_Tds_Computation.DAL_GETALLHEADID();
        //        return ds;
        //    }
        //    catch (Exception ex)
        //    {
                
        //        throw ex;            }
        //}

        public DataTable dtProfessionTax { get; set; }

        public double _ChallanTAX { get; set; }

        //public DataSet BAL_GetComputaionAllPageLoadControlsData()
        //{
        //    try
        //    {
        //        objDAL_Tds_Computation._Company_ID = _Company_ID;
        //        DataSet ds = objDAL_Tds_Computation.DAL_GetComputaionAllPageLoadControlsData();
        //        return ds;
        //    }
        //    catch (Exception ex)
        //    {

        //        throw ex;
        //    }
        //}

        public DataTable PFCalData { get; set; }

        public double _Rebate80CCD1B { get; set; }

        public DataTable dtdgSection10 { get; set; }
    }
}

