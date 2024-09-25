using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;
using System.Data;
using CommonLibrary;
using System.Web; 

namespace DataLayer
{
    public class DAL_TDSComputation : DALCommon
    {
        public string _Cnn { get; set; }
        CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();

        public SqlDataReader DAL_GetAllEmployeeComputionSummary(tblGetColData tobj)
        {
     
            SqlParameter[] param = new SqlParameter[6];
            param[0] = new SqlParameter("@CompanyID", tobj.CompanyID);
            param[1] = new SqlParameter("@PageIndex", tobj.PageIndex);
            param[2] = new SqlParameter("@PageSize", tobj.PageSize);
            param[3] = new SqlParameter("@SearchVal", tobj.SearchVal);
            param[4] = new SqlParameter("@FilterById", tobj.FilterById);
            param[5] = new SqlParameter("@financialyr", tobj.ConnectionString);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_GetAllEmployeeComputionSummary", param);
        }

        //public SqlDataReader DAL_Check_Rebate(int Company_ID)
        //{
        //        SqlParameter[] param = new SqlParameter[1];
        //        param[0] = new SqlParameter("@Company_ID", Company_ID);

        //        return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_Check_Rebate", param);
        //}

        public DataSet DAL_Check_Rebate(int Company_ID)
        {
            DataSet ds = new DataSet();
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@Company_ID", Company_ID);

            return ds= SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_Check_Rebate", param);
        }

        public SqlDataReader DAL_getEmployeeComputation(Tbl_TDS_Computation tobj)
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@Company_ID", tobj.Company_ID);
            param[1] = new SqlParameter("@Employee_ID", tobj.Employee_ID);
        
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_getEmployeeComputation", param);
        }

        public SqlDataReader GetComputationPage(int compid)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@Company_ID", compid);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_GetComputationPage", param);
        }

        public SqlDataReader GetRebateLimits()
        {
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_GetRebateLimits");
        }

        public SqlDataReader GetComputationPageCommonIDs(string p)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@Company_ID", p);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_GetComputationPageCommonIDs", param);
        }

        public int DAL_SaveEmployeeComputation(Tbl_TDS_SaveComputation tobj)
        {
            try
            {
                ///point 1
                //string MthSal = "";

                DataTable MontlySalData = new DataTable();
                MontlySalData.Columns.Add("MonthID");
                MontlySalData.Columns.Add("Employee_ID");
                MontlySalData.Columns.Add("Company_ID");
                MontlySalData.Columns.Add("HeadID");
                MontlySalData.Columns.Add("Amount", typeof(double));
                foreach (var item in tobj.LMonthlySalaryBreakup)
                {
                    //MthSal = MthSal + item.SalaryMonth + "," + tobj.Employee_ID + "," + item.Head_ID + "," + item.Amount + "^";
                    DataRow drMonthsal;
                    drMonthsal = MontlySalData.NewRow();
                    drMonthsal["MonthID"] = item.SalaryMonth;
                    drMonthsal["Employee_ID"] = tobj.Employee_ID;
                    drMonthsal["Company_ID"] = tobj.Company_ID;
                    drMonthsal["HeadID"] = item.Head_ID;
                    drMonthsal["Amount"] = item.Amount;
                    MontlySalData.Rows.Add(drMonthsal);
                }
                //DataTable dtdgPerquisites_Master = CommonFunctions.ToDataTable(tobj.LPerquisites);
                ////Perquisites_Value  //  EmployeePaid_Amt             //    Taxable_Amt              //        Perq_ID
                //dtdgPerquisites_Master.Columns.Remove("Perquisites_ID");
                //dtdgPerquisites_Master.Columns.Remove("Perquisites_Name");
                ////dtdgPerquisites_Master.Columns.Remove("Employee_ID"); dtdgPerquisites_Master.Columns.Remove("Company_ID");
                //dtdgPerquisites_Master.Columns.Remove("FirstName"); dtdgPerquisites_Master.Columns.Remove("PAN_NO");
                //dtdgPerquisites_Master.Columns.Remove("Designation_Name"); dtdgPerquisites_Master.Columns.Remove("GrossEarn1");
                //dtdgPerquisites_Master.Columns.Remove("Itax2");
                //dtdgPerquisites_Master.AcceptChanges();
                ///point 2
                DataTable dtdgSection10 = CommonFunctions.ToDataTable(tobj.LSection10);
                ////////Head_ID  ////////        Amount 
                dtdgSection10.Columns.Remove("Employee_ID"); dtdgSection10.Columns.Remove("Company_ID");
                dtdgSection10.Columns.Remove("Head_Name"); dtdgSection10.Columns.Remove("Limit"); dtdgSection10.AcceptChanges();
                dtdgSection10.Columns.Remove("hname"); 
                ///point4    
                DataTable dtProfessionTax = new DataTable();
                dtProfessionTax.Columns.Add("MonthID");
                dtProfessionTax.Columns.Add("Amount");
                foreach (var item in tobj.LProfessionTax)
                {
                    DataRow drpf;
                    drpf = dtProfessionTax.NewRow();
                    drpf["Amount"] = item.Amount;
                    drpf["MonthID"] = item.SalaryMonth;
                    dtProfessionTax.Rows.Add(drpf);
                }
                ////point 9
                DataTable dtdgPF = new DataTable();
                dtdgPF.Columns.Add("lblAmount");
                dtdgPF.Columns.Add("hdid");
                foreach (var item in tobj.LTDSRebate)
                {
                    DataRow dr;
                    dr = dtdgPF.NewRow();
                    dr["lblAmount"] = item.Amount;
                    dr["hdid"] = item.Rebate_ID;
                    if (item.Rebate_ID > 0)
                    {
                        dtdgPF.Rows.Add(dr);
                    }
                }

                SqlParameter[] objSqlParameter = new SqlParameter[107];
                objSqlParameter[0] = new SqlParameter("@Employee_ID", tobj.Employee_ID);
                objSqlParameter[1] = new SqlParameter("@Company_ID", tobj.Company_ID);
                objSqlParameter[2] = new SqlParameter("@FirstName", tobj.FirstName);
                objSqlParameter[3] = new SqlParameter("@LastName", tobj.LastName);
                objSqlParameter[4] = new SqlParameter("@Designation_Name", tobj.Designation_Name);
                objSqlParameter[5] = new SqlParameter("@Department_Name", tobj.Department_Name);
                objSqlParameter[6] = new SqlParameter("@Gender", tobj.Gender);
                objSqlParameter[7] = new SqlParameter("@Senior_CTZN_Type", tobj.Senior_CTZN_Type);
                objSqlParameter[8] = new SqlParameter("@Surcharge", tobj.Surcharge);
                objSqlParameter[9] = new SqlParameter("@Total_Earnings", tobj.Total_Earnings);
                objSqlParameter[10] = new SqlParameter("@GrossPerks_B", tobj.GrossPerks_B);
                objSqlParameter[11] = new SqlParameter("@GrossProfits_C", tobj.GrossProfits_C);
                objSqlParameter[12] = new SqlParameter("@GrossTotal_D", tobj.GrossTotal_D);
                objSqlParameter[13] = new SqlParameter("@GrossEarn1", tobj.GrossEarn1);
                objSqlParameter[14] = new SqlParameter("@Section_10", tobj.Section_10);
                objSqlParameter[15] = new SqlParameter("@GrossEarn3", tobj.GrossEarn3);
                objSqlParameter[16] = new SqlParameter("@PreSal", tobj.PreSal);
                objSqlParameter[17] = new SqlParameter("@TotalDeduction", tobj.TotalDeduction);
                objSqlParameter[18] = new SqlParameter("@Entertainment", tobj.Entertainment);
                objSqlParameter[19] = new SqlParameter("@PTax", tobj.PTax);
                objSqlParameter[20] = new SqlParameter("@GrossEarn5", tobj.GrossEarn5);
                objSqlParameter[21] = new SqlParameter("@IntHouseLoan", tobj.IntHouseLoan);
                objSqlParameter[22] = new SqlParameter("@OtherIncome", tobj.OtherIncome);
                objSqlParameter[23] = new SqlParameter("@GrossEarn8", tobj.GrossEarn8);
                objSqlParameter[24] = new SqlParameter("@Rebate80C", tobj.Rebate80C);
                objSqlParameter[25] = new SqlParameter("@PF", tobj.PF);
                objSqlParameter[26] = new SqlParameter("@RebateBonds", tobj.RebateBonds);
                objSqlParameter[27] = new SqlParameter("@Rebate80CCC", tobj.Rebate80CCC);
                objSqlParameter[28] = new SqlParameter("@Rebate80CCD", tobj.Rebate80CCD);
                objSqlParameter[29] = new SqlParameter("@Rebate80CCD2", tobj.Rebate80CCD2);
                objSqlParameter[30] = new SqlParameter("@Rebate80QlfySal", tobj.Rebate80QlfySal);
                objSqlParameter[31] = new SqlParameter("@Rebate80NetSal", tobj.Rebate80NetSal);
                objSqlParameter[32] = new SqlParameter("@Rebate88D", tobj.Rebate88D);
                objSqlParameter[33] = new SqlParameter("@Rebate80DD", tobj.Rebate80DD);
                objSqlParameter[34] = new SqlParameter("@Rebate80DDB", tobj.Rebate80DDB);
                objSqlParameter[35] = new SqlParameter("@Rebate80QQB", tobj.Rebate80QQB);
                objSqlParameter[36] = new SqlParameter("@Rebate80E", tobj.Rebate80E);
                objSqlParameter[37] = new SqlParameter("@Rebate80EE", tobj.Rebate80EE);
                objSqlParameter[38] = new SqlParameter("@Rebate80G", tobj.Rebate80G);
                objSqlParameter[39] = new SqlParameter("@Rebate80GG", tobj.Rebate80GG);
                objSqlParameter[40] = new SqlParameter("@Rebate80GGA", tobj.Rebate80GGA);
                objSqlParameter[41] = new SqlParameter("@Rebate80GGC", tobj.Rebate80GGC);
                objSqlParameter[42] = new SqlParameter("@Rebate80RRB", tobj.Rebate80RRB);
                objSqlParameter[43] = new SqlParameter("@Rebate80U", tobj.Rebate80U);
                objSqlParameter[44] = new SqlParameter("@Rebate80CCG", tobj.Rebate80CCG);
                objSqlParameter[45] = new SqlParameter("@Rebate80TTA", tobj.Rebate80TTA);
                objSqlParameter[46] = new SqlParameter("@TotalRebate", tobj.TotalRebate);
                objSqlParameter[47] = new SqlParameter("@Grossnet", tobj.Grossnet);
                objSqlParameter[48] = new SqlParameter("@Itax1", tobj.Itax1);
                objSqlParameter[49] = new SqlParameter("@Rebatetds", tobj.Rebatetds);
                objSqlParameter[50] = new SqlParameter("@EducationCess", tobj.EducationCess);
                objSqlParameter[51] = new SqlParameter("@HighEduCess", tobj.HighEduCess);
                objSqlParameter[52] = new SqlParameter("@Itax2", tobj.Itax2);
                objSqlParameter[53] = new SqlParameter("@Rebate89", tobj.Rebate89);
                objSqlParameter[54] = new SqlParameter("@Itax3", tobj.Itax3);
                objSqlParameter[55] = new SqlParameter("@Itax4", 0);//tobj.Itax4);
                objSqlParameter[56] = new SqlParameter("@PreTds", tobj.PreTds);
                objSqlParameter[57] = new SqlParameter("@FinalTax", tobj.FinalTax);
                objSqlParameter[58] = new SqlParameter("@Manual", tobj.Manual);
                objSqlParameter[59] = new SqlParameter("@Rsinwords", tobj.Rsinwords);
                objSqlParameter[60] = new SqlParameter("@sel", tobj.sel);
                objSqlParameter[61] = new SqlParameter("@HRate", tobj.HRate);
                objSqlParameter[62] = new SqlParameter("@Perk", tobj.Perk);
                objSqlParameter[63] = new SqlParameter("@dtdgPF", dtdgPF);
                objSqlParameter[64] = new SqlParameter("@MontlySalData", MontlySalData);
                objSqlParameter[65] = new SqlParameter("@dtProfessionTax", dtProfessionTax);
                objSqlParameter[66] = new SqlParameter("@ChallanTAX", tobj.Challan_Tax);
                objSqlParameter[67] = new SqlParameter("@Rebate80CCD1B", tobj.Rebate80CCD1B);
                objSqlParameter[68] = new SqlParameter("@dtdgSection10", dtdgSection10);
                objSqlParameter[69] = new SqlParameter("@StandardDeductions", tobj.StandardDeductions);
                objSqlParameter[70] = new SqlParameter("@HeathCess", tobj.HeathCess);
                objSqlParameter[71] = new SqlParameter("@SurchargeType", tobj.sur_type);

                objSqlParameter[72] = new SqlParameter("@Rebate80C_Ded", tobj.Rebate80C_Ded);
                objSqlParameter[73] = new SqlParameter("@Rebate80CCC_Ded", tobj.Rebate80CCC_Ded);
                objSqlParameter[74] = new SqlParameter("@Rebate80CCD_Ded", tobj.Rebate80CCD_Ded);
                objSqlParameter[75] = new SqlParameter("@Rebate80CCD2_Ded", tobj.Rebate80CCD2_Ded);
                objSqlParameter[76] = new SqlParameter("@Rebate88D_Ded", tobj.Rebate88D_Ded);
                objSqlParameter[77] = new SqlParameter("@Rebate80DD_Ded", tobj.Rebate80DD_Ded);
                objSqlParameter[78] = new SqlParameter("@Rebate80DDB_Ded", tobj.Rebate80DDB_Ded);
                objSqlParameter[79] = new SqlParameter("@Rebate80QQB_Ded", tobj.Rebate80QQB_Ded);
                objSqlParameter[80] = new SqlParameter("@Rebate80E_Ded", tobj.Rebate80E_Ded);
                objSqlParameter[81] = new SqlParameter("@Rebate80EE_Ded", tobj.Rebate80EE_Ded);
                objSqlParameter[82] = new SqlParameter("@Rebate80G_Ded", tobj.Rebate80G_Ded);
                objSqlParameter[83] = new SqlParameter("@Rebate80GG_Ded", tobj.Rebate80GG_Ded);
                objSqlParameter[84] = new SqlParameter("@Rebate80GGA_Ded", tobj.Rebate80GGA_Ded);
                objSqlParameter[85] = new SqlParameter("@Rebate80GGC_Ded", tobj.Rebate80GGC_Ded);
                objSqlParameter[86] = new SqlParameter("@Rebate80RRB_Ded", tobj.Rebate80RRB_Ded);
                objSqlParameter[87] = new SqlParameter("@Rebate80U_Ded", tobj.Rebate80U_Ded);
                objSqlParameter[88] = new SqlParameter("@Rebate80CCG_Ded", tobj.Rebate80CCG_Ded);
                objSqlParameter[89] = new SqlParameter("@Rebate80TTA_Ded", tobj.Rebate80TTA_Ded);

                objSqlParameter[90] = new SqlParameter("@Rebate80G_Qlfy", tobj.Rebate80G_Qlfy);
                objSqlParameter[91] = new SqlParameter("@Rebate80GG_Qlfy", tobj.Rebate80GG_Qlfy);
                objSqlParameter[92] = new SqlParameter("@Rebate80GGA_Qlfy", tobj.Rebate80GGA_Qlfy);
                objSqlParameter[93] = new SqlParameter("@Rebate80GGC_Qlfy", tobj.Rebate80GGC_Qlfy);
                objSqlParameter[94] = new SqlParameter("@Rebate80RRB_Qlfy", tobj.Rebate80RRB_Qlfy);
                objSqlParameter[95] = new SqlParameter("@Rebate80U_Qlfy", tobj.Rebate80U_Qlfy);
                objSqlParameter[96] = new SqlParameter("@Rebate80CCG_Qlfy", tobj.Rebate80CCG_Qlfy);
                objSqlParameter[97] = new SqlParameter("@Rebate80TTA_Qlfy", tobj.Rebate80TTA_Qlfy);
                objSqlParameter[98] = new SqlParameter("@Rebate80CCD1B_Ded", tobj.Rebate80CCD1B_Ded);
                objSqlParameter[99] = new SqlParameter("@I115BAC", tobj.I115BAC);
                objSqlParameter[100] = new SqlParameter("@Multi", tobj.HrrRec);
                objSqlParameter[101] = new SqlParameter("@Metro_Cities", tobj.Metro_Cities);
                objSqlParameter[102] = new SqlParameter("@No_Of_Child", tobj.No_Of_Child);
                objSqlParameter[103] = new SqlParameter("@state_id", tobj.state_id);
                objSqlParameter[104] = new SqlParameter("@CALC_PF", tobj.CALC_PF);
                objSqlParameter[105] = new SqlParameter("@CALC_PT", tobj.CALC_PT);
                objSqlParameter[106] = new SqlParameter("@ManualHRA", tobj.ManualHRA );

                //DataSet ds = SqlHelper.ExecuteDataset(tobj.LastName, CommandType.StoredProcedure, "usp_Update_TDS_Computation", objSqlParameter);
                /////////tobj.LastName indicates connection string of current database as per financial year
                return SqlHelper.ExecuteNonQuery(_cnnString2, CommandType.StoredProcedure, "usp_Update_TDS_Computation", objSqlParameter);
                ///////////above sp used in new computation page TDSComputation 
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                return 0;
            }
        }

        public SqlDataReader DAL_getEmployeeRentDetails(int Employee_ID, int Company_ID, string Conn)
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@Employee_ID", Employee_ID);
            param[1] = new SqlParameter("@Company_ID", Company_ID);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_getEmployeeRentDetails", param);
        }


        public SqlDataReader DAL_getSurchargeSlab(int Company_ID, string Conn)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@Company_ID", Company_ID);
          //  DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_getSurchargeSlab", param);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_getSurchargeSlab", param);
        }

        public SqlDataReader DAL_getIncomeTax115(int Company_ID, string Emp, string Conn)
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@Employee_ID", Emp);
            param[1] = new SqlParameter("@Company_ID", Company_ID);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_Get_IncomeTax115", param);
        }

        public int DAL_setEmployeeRentDetails(Tbl_TDS_Computation tobj)
        {
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[30];
                objSqlParameter[0] = new SqlParameter("@Employee_ID", tobj.Employee_ID);
                objSqlParameter[1] = new SqlParameter("@Company_ID", tobj.Company_ID);
                objSqlParameter[2] = new SqlParameter("@Rent_Payment", tobj.Rent_Payment);
                objSqlParameter[3] = new SqlParameter("@Count_PAN_landlord", tobj.Count_PAN_landlord);
                objSqlParameter[4] = new SqlParameter("@PAN_landlord1", tobj.PAN_landlord1);
                objSqlParameter[5] = new SqlParameter("@Name_landlord1", tobj.Name_landlord1);
                objSqlParameter[6] = new SqlParameter("@PAN_landlord2", tobj.PAN_landlord2);
                objSqlParameter[7] = new SqlParameter("@Name_landlord2", tobj.Name_landlord2);
                objSqlParameter[8] = new SqlParameter("@PAN_landlord3", tobj.PAN_landlord3);
                objSqlParameter[9] = new SqlParameter("@Name_landlord3", tobj.Name_landlord3);
                objSqlParameter[10] = new SqlParameter("@PAN_landlord4", tobj.PAN_landlord4);
                objSqlParameter[11] = new SqlParameter("@Name_landlord4", tobj.Name_landlord4);
                objSqlParameter[12] = new SqlParameter("@Interest_lender", tobj.Interest_lender);
                objSqlParameter[13] = new SqlParameter("@Count_PAN_lender", tobj.Count_PAN_lender);
                objSqlParameter[14] = new SqlParameter("@PAN_lender1", tobj.PAN_lender1);
                objSqlParameter[15] = new SqlParameter("@Name_lender1", tobj.Name_lender1);
                objSqlParameter[16] = new SqlParameter("@PAN_lender2", tobj.PAN_lender2);
                objSqlParameter[17] = new SqlParameter("@Name_lender2", tobj.Name_lender2);
                objSqlParameter[18] = new SqlParameter("@PAN_lender3", tobj.PAN_lender3);
                objSqlParameter[19] = new SqlParameter("@Name_lender3", tobj.Name_lender3);
                objSqlParameter[20] = new SqlParameter("@PAN_lender4", tobj.PAN_lender4);
                objSqlParameter[21] = new SqlParameter("@Name_lender4", tobj.Name_lender4);
                objSqlParameter[22] = new SqlParameter("@Contributions_superannuation_fund", tobj.Contributions_superannuation_fund);
                objSqlParameter[23] = new SqlParameter("@Name_superannuation_fund", tobj.Name_superannuation_fund);
                objSqlParameter[24] = new SqlParameter("@Frm_DT_superannuation_fund", tobj.Frm_DT_superannuation_fund);
                objSqlParameter[25] = new SqlParameter("@TO_DT_superannuation_fund", tobj.TO_DT_superannuation_fund);
                objSqlParameter[26] = new SqlParameter("@principal_interest_superannuation_fund", tobj.principal_interest_superannuation_fund);
                objSqlParameter[27] = new SqlParameter("@Rate_deduction_tax_3yrs", tobj.Rate_deduction_tax_3yrs);
                objSqlParameter[28] = new SqlParameter("@Repayment_superannuation_fund", tobj.Repayment_superannuation_fund);
                objSqlParameter[29] = new SqlParameter("@Total_Income_superannuation_fund", tobj.Total_Income_superannuation_fund);
                return SqlHelper.ExecuteNonQuery(_cnnString2, CommandType.StoredProcedure, "usp_setEmployeeRentDetails", objSqlParameter);
            }
            catch (Exception ex)
            {
                ErrorException.LogError(ex);
                return 0;
            }
        }

        public SqlDataReader Get_Head_Master_with_Sec10(int Compid, string Conn)
        {
             
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];

                objSqlParameter[0] = new SqlParameter("@Company_ID", Compid);
                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_Get_Head_Section10", objSqlParameter);
                //dsHead = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_Head_Section10", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            //return dsHead;
        }

        public SqlDataReader DAL_HeadName(int Compid, string Conn)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Compid", Compid);
               // DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_Get_HeadName", param);
                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_Get_HeadName", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public SqlDataReader DAL_UpdateHead(int Compid, string Conn, string Multi)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@Compid", Compid);
                param[1] = new SqlParameter("@Multi", Multi);
               // DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_UpdateHeadName", param);
                return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_UpdateHeadName", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public SqlDataReader DAL_getHRR_Grd(int Employee_ID, string Conn)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@Employee_ID", Employee_ID);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_Get_HRA_Rent_Grd", param);
        }

        public SqlDataReader DAL_SaveHRR_Grd(int Compid,int Employee_ID, string Conn, string Multi)
        {
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@Employee_ID", Employee_ID);
            param[1] = new SqlParameter("@Compid", Compid);
            param[2] = new SqlParameter("@Multi", Multi);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_Update_HRA_RentReceipt", param);
        }

        public DataSet DAL_ExportXL(int Company_ID, string fy)
        {
            DataSet ds = new DataSet();
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@Company_ID", Company_ID);
            param[1] = new SqlParameter("@financialyr", fy);

            return ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_Get_TDSComputation_Reports", param);
        }
    }
}
