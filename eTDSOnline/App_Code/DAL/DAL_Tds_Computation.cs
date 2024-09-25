using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
    public class DAL_Tds_Computation : DALCommon
    {
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
        public DataTable Hra { get; set; }
        public int ddlSection80Ctext { get; set; }
        public double Section80CAmt { get; set; }
        public double _GrossIncome { get; set; }
        public double _Rebate80E80EE { get; set; }
        public DataTable _dtdgPerquisites_Master { get; set; }
        public DataTable _dtdgPF { get; set; }
        public int _Branch_ID { get; set; }
        public int _Perquisites_ID { get; set; }
        public int _Head_ID { get; set; }
        public string _City { get; set; }
        public int _Department_ID { get; set; }
        public int _State_ID { get; set; }
        public int _Designation_ID { get; set; }
        public string _Email_ID { get; set; }
        public int _Is_Leave_Allocated { get; set; }
        public bool _Is_Salary_Allocated { get; set; }
        public int _ResignStatus { get; set; }
        public int _Grade_ID { get; set; }
        public int _Category_ID { get; set; }
        public DataTable MontlySalData { get; set; }


        //    public DataSet Get_TDS_Computation_Details()
        //    {
        //        DataSet ds = new DataSet();
        //        try
        //        {
        //            SqlParameter[] objSqlParameter = new SqlParameter[2];

        //            objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);
        //            objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
        //            ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_TDS_Computation_Details", objSqlParameter);
        //        }
        //        catch (Exception ex)
        //        {
        //            throw new Exception(ex.Message);
        //        }
        //        return ds;
        //    }

        //    public DataSet Insert_TDS_Computation()
        //    {
        //        DataSet ds = new DataSet();
        //        try
        //        {
        //            SqlParameter[] objSqlParameter = new SqlParameter[1];

        //            objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);

        //            ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Insert_TDS_Computation", objSqlParameter);
        //        }
        //        catch (Exception ex)
        //        {
        //            throw new Exception(ex.Message);
        //        }
        //        return ds;
        //    }

        //    public int Update_TDS_Computation()
        //    {
        //        int ds = 0;
        //        try
        //        {
        //            SqlParameter[] objSqlParameter = new SqlParameter[70];

        //            objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);
        //            objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
        //            objSqlParameter[2] = new SqlParameter("@FirstName", _FirstName);
        //            objSqlParameter[3] = new SqlParameter("@LastName", _LastName);
        //            objSqlParameter[4] = new SqlParameter("@Designation_Name", _Designation_Name);
        //            objSqlParameter[5] = new SqlParameter("@Department_Name", _Department_Name);
        //            objSqlParameter[6] = new SqlParameter("@Gender", _Gender);
        //            objSqlParameter[7] = new SqlParameter("@Senior_CTZN_Type", _Senior_CTZN_Type);
        //            objSqlParameter[8] = new SqlParameter("@Surcharge", _Surcharge);
        //            objSqlParameter[9] = new SqlParameter("@Total_Earnings", _Total_Earnings);
        //            objSqlParameter[10] = new SqlParameter("@GrossPerks_B", _GrossPerks_B);
        //            objSqlParameter[11] = new SqlParameter("@GrossProfits_C", _GrossProfits_C);
        //            objSqlParameter[12] = new SqlParameter("@GrossTotal_D", _GrossTotal_D);
        //            objSqlParameter[13] = new SqlParameter("@GrossEarn1", _GrossEarn1);
        //            objSqlParameter[14] = new SqlParameter("@Section_10", _Section_10);
        //            objSqlParameter[15] = new SqlParameter("@GrossEarn3", _GrossEarn3);
        //            objSqlParameter[16] = new SqlParameter("@PreSal", _PreSal);
        //            objSqlParameter[17] = new SqlParameter("@TotalDeduction", _TotalDeduction);
        //            objSqlParameter[18] = new SqlParameter("@Entertainment", _Entertainment);
        //            objSqlParameter[19] = new SqlParameter("@PTax", _PTax);
        //            objSqlParameter[20] = new SqlParameter("@GrossEarn5", _GrossEarn5);
        //            objSqlParameter[21] = new SqlParameter("@IntHouseLoan", _IntHouseLoan);
        //            objSqlParameter[22] = new SqlParameter("@OtherIncome", _OtherIncome);
        //            objSqlParameter[23] = new SqlParameter("@GrossEarn8", _GrossEarn8);
        //            objSqlParameter[24] = new SqlParameter("@Rebate80C", _Rebate80C);
        //            objSqlParameter[25] = new SqlParameter("@PF", _PF);
        //            objSqlParameter[26] = new SqlParameter("@RebateBonds", _RebateBonds);
        //            objSqlParameter[27] = new SqlParameter("@Rebate80CCC", _Rebate80CCC);
        //            objSqlParameter[28] = new SqlParameter("@Rebate80CCD", _Rebate80CCD);
        //            objSqlParameter[29] = new SqlParameter("@Rebate80CCD2", _Rebate80CCD2);
        //            objSqlParameter[30] = new SqlParameter("@Rebate80QlfySal", _Rebate80QlfySal);
        //            objSqlParameter[31] = new SqlParameter("@Rebate80NetSal", _Rebate80NetSal);
        //            objSqlParameter[32] = new SqlParameter("@Rebate88D", _Rebate88D);
        //            objSqlParameter[33] = new SqlParameter("@Rebate80DD", _Rebate80DD);
        //            objSqlParameter[34] = new SqlParameter("@Rebate80DDB", _Rebate80DDB);
        //            objSqlParameter[35] = new SqlParameter("@Rebate80QQB", _Rebate80QQB);
        //            objSqlParameter[36] = new SqlParameter("@Rebate80E", _Rebate80E);
        //            objSqlParameter[37] = new SqlParameter("@Rebate80EE", _Rebate80EE);
        //            objSqlParameter[38] = new SqlParameter("@Rebate80G", _Rebate80G);
        //            objSqlParameter[39] = new SqlParameter("@Rebate80GG", _Rebate80GG);
        //            objSqlParameter[40] = new SqlParameter("@Rebate80GGA", _Rebate80GGA);
        //            objSqlParameter[41] = new SqlParameter("@Rebate80GGC", _Rebate80GGC);
        //            objSqlParameter[42] = new SqlParameter("@Rebate80RRB", _Rebate80RRB);
        //            objSqlParameter[43] = new SqlParameter("@Rebate80U", _Rebate80U);
        //            objSqlParameter[44] = new SqlParameter("@Rebate80CCG", _Rebate80CCG);
        //            objSqlParameter[45] = new SqlParameter("@Rebate80TTA", _Rebate80TTA);
        //            objSqlParameter[46] = new SqlParameter("@TotalRebate", _TotalRebate);
        //            objSqlParameter[47] = new SqlParameter("@Grossnet", _Grossnet);
        //            objSqlParameter[48] = new SqlParameter("@Itax1", _Itax1);
        //            objSqlParameter[49] = new SqlParameter("@Rebatetds", _Rebatetds);
        //            objSqlParameter[50] = new SqlParameter("@EducationCess", _EducationCess);
        //            objSqlParameter[51] = new SqlParameter("@HighEduCess", _HighEduCess);
        //            objSqlParameter[52] = new SqlParameter("@Itax2", _Itax2);
        //            objSqlParameter[53] = new SqlParameter("@Rebate89", _Rebate89);
        //            objSqlParameter[54] = new SqlParameter("@Itax3", _Itax3);
        //            objSqlParameter[55] = new SqlParameter("@Itax4", _Itax4);
        //            objSqlParameter[56] = new SqlParameter("@PreTds", _PreTds);
        //            objSqlParameter[57] = new SqlParameter("@FinalTax", _FinalTax);
        //            objSqlParameter[58] = new SqlParameter("@Manual", _Manual);
        //            objSqlParameter[59] = new SqlParameter("@Rsinwords", _Rsinwords);
        //            objSqlParameter[60] = new SqlParameter("@sel", _sel);
        //            objSqlParameter[61] = new SqlParameter("@HRate", _HRate);
        //            objSqlParameter[62] = new SqlParameter("@dtdgPerquisites_Master", _dtdgPerquisites_Master);
        //            objSqlParameter[63] = new SqlParameter("@dtdgPF", _dtdgPF);
        //            objSqlParameter[64] = new SqlParameter("@MontlySalData", MontlySalData);
        //            objSqlParameter[65] = new SqlParameter("@dtProfessionTax", dtProfessionTax);
        //            objSqlParameter[66] = new SqlParameter("@ChallanTAX", _ChallanTAX);
        //            objSqlParameter[67] = new SqlParameter("@Rebate80CCD1B", _Rebate80CCD1B);
        //            objSqlParameter[68] = new SqlParameter("@dtdgSection10", dtdgSection10);
        //            objSqlParameter[69] = new SqlParameter("@StandardDeductions", _StandardDeductions);
        //            ds = SqlHelper.ExecuteNonQuery(_cnnString2, CommandType.StoredProcedure, "usp_Update_TDS_Computation", objSqlParameter);
        //            ///////////above sp used in new computation page TDSComputation 
        //        }
        //        catch (Exception ex)
        //        {
        //            throw new Exception(ex.Message);
        //        }
        //        return ds;
        //    }

        //    public DataSet DAL_BindRebateMasterDropdown()
        //    {
        //        try
        //        {
        //            DataSet ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_GetRebateMaster");
        //            return ds;
        //        }
        //        catch (Exception ex)
        //        {

        //            throw ex;
        //        }
        //    }

        //    public int DAL_InsertRebateMaster()
        //    {
        //        try
        //        {
        //            int result = 0;
        //            SqlParameter[] objSqlParameter = new SqlParameter[4];
        //            objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);
        //            objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
        //            objSqlParameter[2] = new SqlParameter("@ddlSection80Ctext", ddlSection80Ctext);
        //            objSqlParameter[3] = new SqlParameter("@Section80CAmt", Section80CAmt);
        //            result = SqlHelper.ExecuteNonQuery(_cnnString2, CommandType.StoredProcedure, "usp_InsertRebateMaster", objSqlParameter);
        //            return result;
        //        }
        //        catch (Exception ex)
        //        {

        //            throw ex;
        //        }
        //    }



        //    public DataSet DAL_BindRebateMasterdgPFGrid()
        //    {
        //        try
        //        {
        //            SqlParameter[] objSqlParameter = new SqlParameter[2];

        //            objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);
        //            objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
        //            DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetRebateMasterEmployeeWise", objSqlParameter);
        //            return ds;
        //        }
        //        catch (Exception ex)
        //        {

        //            throw ex;
        //        }
        //    }



        //    public DataSet DAL_GetTaxOnTotalIncome()
        //    {
        //        SqlParameter[] objSqlParameter = new SqlParameter[5];

        //        objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);
        //        objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
        //        objSqlParameter[2] = new SqlParameter("@GrossIncome", _GrossIncome);
        //        objSqlParameter[3] = new SqlParameter("@Rebate89", _Rebate89);
        //        objSqlParameter[4] = new SqlParameter("@PreTds", _PreTds);
        //        DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetTaxOnTotalIncome", objSqlParameter);
        //        return ds;
        //    }

        //    public DataSet Get_Monthly_Head_Summary()
        //    {
        //        DataSet ds = new DataSet();
        //        try
        //        {
        //            SqlParameter[] objSqlParameter = new SqlParameter[2];
        //            objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);
        //            objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
        //            ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Monthly_Head_Summary", objSqlParameter);
        //        }
        //        catch (Exception)
        //        {

        //            throw;
        //        }
        //        return ds;
        //    }

        //    public DataSet Get_Perquisites_List()
        //    {
        //        DataSet ds = new DataSet();
        //        try
        //        {
        //            SqlParameter[] objSqlParameter = new SqlParameter[3];

        //            objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);
        //            objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
        //            objSqlParameter[2] = new SqlParameter("@Perquisites_ID", _Perquisites_ID);

        //            ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Perquisites_List", objSqlParameter);
        //        }
        //        catch (Exception ex)
        //        {
        //            throw new Exception(ex.Message);
        //        }
        //        return ds;
        //    }


        //    public DataSet Get_Section_10_List()
        //    {
        //        DataSet ds = new DataSet();

        //        try
        //        {
        //            SqlParameter[] objSqlParameter = new SqlParameter[2];
        //            objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);
        //            objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
        //            ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Section_10_List", objSqlParameter);

        //        }
        //        catch (Exception ex)
        //        {
        //            throw new Exception(ex.Message);
        //        }
        //        return ds;
        //    }

        //    public DataSet Get_Employee_ProfessionTax_List()
        //    {
        //        DataSet ds = new DataSet();
        //        try
        //        {
        //            SqlParameter[] objSqlParameter = new SqlParameter[4];
        //            objSqlParameter[0] = new SqlParameter("@Employee_ID", _Employee_ID);
        //            objSqlParameter[1] = new SqlParameter("@Company_ID", _Company_ID);
        //            objSqlParameter[2] = new SqlParameter("@MontlySalData", MontlySalData);
        //            objSqlParameter[3] = new SqlParameter("@PFCalData", PFCalData);
        //            ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure,"usp_Get_Employee_ProfessionTax_List", objSqlParameter);
        //        }
        //        catch (Exception ex)
        //        {
        //            throw new Exception(ex.Message);
        //        }
        //        return ds;
        //    }

        //    public DataSet Get_Employee_Master_List()
        //    {
        //        DataSet ds = new DataSet();
        //        try
        //        {
        //            SqlParameter[] objSqlParameter = new SqlParameter[14];

        //            objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
        //            objSqlParameter[1] = new SqlParameter("@FirstName", _FirstName);
        //            objSqlParameter[2] = new SqlParameter("@City", _City);
        //            objSqlParameter[3] = new SqlParameter("@State_ID", _State_ID);
        //            objSqlParameter[4] = new SqlParameter("@Designation_ID", _Designation_ID);
        //            objSqlParameter[5] = new SqlParameter("@Branch_ID", _Branch_ID);
        //            objSqlParameter[6] = new SqlParameter("@Department_ID", _Department_ID);
        //            objSqlParameter[7] = new SqlParameter("@Email_ID", _Email_ID);
        //            objSqlParameter[8] = new SqlParameter("@Category_ID", _Category_ID);
        //            objSqlParameter[9] = new SqlParameter("@Grade_ID", _Grade_ID);
        //            objSqlParameter[10] = new SqlParameter("@ResignStatus", _ResignStatus);
        //            objSqlParameter[11] = new SqlParameter("@Is_Salary_Allocated", _Is_Salary_Allocated);
        //            objSqlParameter[12] = new SqlParameter("@Employee_ID", _Employee_ID);
        //            objSqlParameter[13] = new SqlParameter("@Is_Leave_Allocated", _Is_Leave_Allocated);

        //            ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Employee_Master_List", objSqlParameter);
        //        }
        //        catch (Exception)
        //        {

        //            throw;
        //        }
        //        return ds;
        //    }

        //    public SqlDataReader DAL_HeadName(int Compid, string Conn)
        //    {
        //        try
        //        {
        //            SqlParameter[] param = new SqlParameter[1];
        //            param[0] = new SqlParameter("@Compid", Compid);
        //            DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_Get_HeadName", param);
        //            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_Get_HeadName", param);
        //        }
        //        catch (Exception ex)
        //        {
        //            throw ex;
        //        }
        //    }


        //    public SqlDataReader DAL_UpdateHead(int Compid, string Conn, string Multi)
        //    {
        //        try
        //        {
        //            SqlParameter[] param = new SqlParameter[2];
        //            param[0] = new SqlParameter("@Compid", Compid);
        //            param[1] = new SqlParameter("@Multi", Multi);
        //            //DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "", param);
        //            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_UpdateHeadName", param);
        //        }
        //        catch (Exception ex)
        //        {
        //            throw ex;
        //        }
        //    }


        //    public DataSet DAL_CalcualteHRA()
        //    {
        //        try
        //        {
        //            SqlParameter[] objSqlParameter = new SqlParameter[3];
        //            objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
        //            objSqlParameter[1] = new SqlParameter("@Employee_ID", _Employee_ID);
        //            objSqlParameter[2] = new SqlParameter("@Hra", Hra);
        //            DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_CalCuateHRA", objSqlParameter);
        //            return ds;
        //        }
        //        catch (Exception ex)
        //        {

        //            throw ex;
        //        }
        //    }



        //    public DataSet DAL_GETALLHEADID()
        //    {
        //        try
        //        {
        //            SqlParameter[] objSqlParameter = new SqlParameter[1];
        //            objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
        //            DataSet ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_GetAllHeadIDsInTDSComputation", objSqlParameter);
        //            return ds;
        //        }
        //        catch (Exception ex)
        //        {
        //            throw ex;
        //        }
        //    }

        //    public DataTable dtProfessionTax { get; set; }

        //    public double _ChallanTAX { get; set; }

        //    public DataSet DAL_GetComputaionAllPageLoadControlsData()
        //    {
        //        try
        //        {
        //            SqlParameter[] objSqlParameter = new SqlParameter[1];
        //            objSqlParameter[0] = new SqlParameter("@Company_ID", _Company_ID);
        //            DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetComputaionAllPageLoadControlsData", objSqlParameter);
        //            return ds;
        //        }
        //        catch (Exception ex)
        //        {
        //            throw ex;
        //        }
        //    }

        //    public DataTable PFCalData { get; set; }

        //    public double _Rebate80CCD1B { get; set; }

        //    public DataTable dtdgSection10 { get; set; }
    }
}
