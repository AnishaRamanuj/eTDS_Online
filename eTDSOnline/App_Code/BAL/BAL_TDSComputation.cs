using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;
using CommonLibrary;
using System.Data.SqlClient;
using System.Globalization;
using System.Data; 

namespace BusinessLayer
{
    public class BAL_TDSComputation : CommonFunctions
    {
        DAL_TDSComputation objDAL_TDSComputation = new DAL_TDSComputation();

        public IEnumerable<tblTDSComputationSummary> BAL_GetAllEmployeeComputionSummary(tblGetColData tobj)
        {
            List<tblTDSComputationSummary> LTDS = new List<tblTDSComputationSummary>();
            using (SqlDataReader drrr = objDAL_TDSComputation.DAL_GetAllEmployeeComputionSummary(tobj))
            {
                while (drrr.Read())
                {
                    LTDS.Add(new tblTDSComputationSummary()
                    {
                        RecordCount = GetValue<int>(drrr["RecordCount"].ToString()),
                        RowNumber = GetValue<int>(drrr["RowNumber"].ToString()),
                        Employee_ID = GetValue<int>(drrr["Employee_ID"].ToString()),
                        FirstName = GetValue<string>(drrr["FirstName"].ToString()),
                        SumofSalary = GetValue<double>(drrr["SumofSalary"].ToString()),
                        GrossEarn1 = GetValue<double>(drrr["GrossEarn1"].ToString()),
                        Grossnet = GetValue<double>(drrr["Grossnet"].ToString()),
                        TotalRebate = GetValue<double>(drrr["TotalRebate"].ToString()),
                        Itax1 = GetValue<double>(drrr["Itax1"].ToString()),
                        PreTds = GetValue<double>(drrr["PreTds"].ToString()),
                        FinalTax = GetValue<double>(drrr["FinalTax"].ToString())
                    });
                }
                List<tblGetColData> LFilterList = new List<tblGetColData>();
                if (drrr.NextResult())
                {
                    while (drrr.Read())
                    {
                        LFilterList.Add(new tblGetColData()
                        {
                            FilterById = GetValue<int>(drrr["FilterById"].ToString()),
                            FilterByVal = GetValue<string>(drrr["FilterByVal"].ToString())
                        });
                    }
                }
                List<tblChallanSummary> LtblChallan = new List<tblChallanSummary>();
                if (drrr.NextResult())
                {
                    while (drrr.Read())
                    {
                        LtblChallan.Add(new tblChallanSummary()
                        {
                            Quater = GetValue<string>(drrr["Quater"].ToString()),
                            Challan_NO = GetValue<string>(drrr["Challan_NO"].ToString()),
                            Challan_Date = GetValue<string>(drrr["Challan_Date"].ToString() == "" ? "" : Convert.ToDateTime(drrr["Challan_Date"].ToString()).ToString("dd/MM/yyyy")),
                            TDS_Deduction_Date = GetValue<string>(drrr["TDS_Deduction_Date"].ToString() == "" ? "" : Convert.ToDateTime(drrr["TDS_Deduction_Date"].ToString()).ToString("dd/MM/yyyy")),
                            Employee_Salary = GetValue<string>(drrr["Employee_Salary"].ToString()),
                            TDS_Amount = GetValue<string>(drrr["TDS_Amount"].ToString()),
                            Surcharge_Amount = GetValue<string>(drrr["Surcharge_Amount"].ToString()),
                            EducationCess_Amount = GetValue<string>(drrr["EducationCess_Amount"].ToString()),
                            High_EductionCess_Amount = GetValue<string>(drrr["High_EductionCess_Amount"].ToString()),
                            Total_TDS_Amount = GetValue<string>(drrr["Total_TDS_Amount"].ToString()),
                            Employee_ID = GetValue<int>(drrr["Employee_ID"].ToString()),
                        });
                    }
                }
                foreach (tblTDSComputationSummary i in LTDS)
                {
                    i.ChallanSummary = LtblChallan.Where(x => x.Employee_ID == i.Employee_ID).OrderBy(x => x.Quater).ToList();
                    i.FilterList = LFilterList;
                }
            }
            return LTDS as IEnumerable<tblTDSComputationSummary>;
        }

        public IEnumerable<Tbl_TDS_Computation> BAL_getEmployeeComputation(Tbl_TDS_Computation tobj)
        {
            List<Tbl_TDS_Computation> LTDSComputation = new List<Tbl_TDS_Computation>();
            List<tbl_Monthly_Salary_BreakUp> LMonthlySalaryBreakup = new List<tbl_Monthly_Salary_BreakUp>();
            List<tbl_Rebates_Computation> Rebates = new List<tbl_Rebates_Computation>();
            List<tbl_Perquisites> Lperquisites = new List<tbl_Perquisites>();
            List<tbl_Section_10> Lsection10 = new List<tbl_Section_10>();
            List<tbl_Monthly_Salary_BreakUp> LProfessionTax = new List<tbl_Monthly_Salary_BreakUp>();
            List<tbl_TDS_Rebate> LTDSRebate = new List<tbl_TDS_Rebate>();
            List<tbl_HRA_Rent_Receipt> LHRARentReceipt = new List<tbl_HRA_Rent_Receipt>();
            List<tbl_Professionaltax_Master> LProfessiontaxMaster = new List<tbl_Professionaltax_Master>();
            List<tbl_Incometax_Master> LIncomeTaxMaster = new List<tbl_Incometax_Master>();
            List<tblChallanSummary> LChallanDts = new List<tblChallanSummary>();
            List<tblEmployeeTDSReletatedOtherDetails> LtblEmployeeTDSReletatedOtherDetails = new List<tblEmployeeTDSReletatedOtherDetails>();
            List<tbl_Incometax_Master_Multi> IncomeTaxMaster_Multi = new List<tbl_Incometax_Master_Multi>();

            using (SqlDataReader drrr = objDAL_TDSComputation.DAL_getEmployeeComputation(tobj))
            {
                while (drrr.Read())
                {
                    #region tblComputation
                    LTDSComputation.Add(new Tbl_TDS_Computation()
                    {
                        Employee_ID = GetValue<int>(drrr["Employee_ID"].ToString()),
                        FirstName = GetValue<string>(drrr["FirstName"].ToString()),
                        PAN_NO = GetValue<string>(drrr["PAN_NO"].ToString()),
                        Gender = GetValue<string>(drrr["Gender"].ToString()),
                        Senior_CTZN_Type = GetValue<string>(drrr["Senior_CTZN_Type"].ToString()),
                        Join_DT = GetValue<DateTime>(drrr["Join_DT"].ToString()),
                        Designation_Name = GetValue<string>(drrr["Designation_Name"].ToString()),
                        Department_Name = GetValue<string>(drrr["Department_Name"].ToString()),
                        Metro_Cities = GetValue<string>(drrr["Metro_Cities"].ToString()),
                        HraType = GetValue<string>(drrr["HraType"].ToString()),
                        No_Of_Child = GetValue<int>(drrr["No_Of_Child"].ToString()),
                        state_id = GetValue<int>(drrr["state_id"].ToString()),
                        Surcharge = GetValue<float>(drrr["Surcharge"].ToString()),
                        Total_Earnings = GetValue<float>(drrr["Total_Earnings"].ToString()),
                        GrossPerks_B = GetValue<float>(drrr["GrossPerks_B"].ToString()),
                        GrossProfits_C = GetValue<float>(drrr["GrossProfits_C"].ToString()),
                        GrossTotal_D = GetValue<float>(drrr["GrossTotal_D"].ToString()),
                        GrossEarn1 = GetValue<float>(drrr["GrossEarn1"].ToString()),
                        Section_10 = GetValue<float>(drrr["Section_10"].ToString()),
                        GrossEarn3 = GetValue<float>(drrr["GrossEarn3"].ToString()),
                        PreSal = GetValue<float>(drrr["PreSal"].ToString()),
                        TotalDeduction = GetValue<float>(drrr["TotalDeduction"].ToString()),
                        StandardDeductions = GetValue<float>(drrr["StandardDeductions"].ToString()),
                        Entertainment = GetValue<float>(drrr["Entertainment"].ToString()),
                        PTax = GetValue<float>(drrr["PTax"].ToString()),
                        GrossEarn5 = GetValue<float>(drrr["GrossEarn5"].ToString()),
                        IntHouseLoan = GetValue<float>(drrr["IntHouseLoan"].ToString()),
                        OtherIncome = GetValue<float>(drrr["OtherIncome"].ToString()),
                        GrossEarn8 = GetValue<float>(drrr["GrossEarn8"].ToString()),
                        PF = GetValue<float>(drrr["PF"].ToString()),
                        RebateBonds = GetValue<float>(drrr["RebateBonds"].ToString()),
                        TotalRebate = GetValue<float>(drrr["TotalRebate"].ToString()),
                        Grossnet = GetValue<float>(drrr["Grossnet"].ToString()),
                        Itax1 = GetValue<float>(drrr["Itax1"].ToString()),
                        Rebatetds = GetValue<float>(drrr["Rebatetds"].ToString()),
                        EducationCess = GetValue<float>(drrr["EducationCess"].ToString()),
                        HighEduCess = GetValue<float>(drrr["HighEduCess"].ToString()),
                        Itax2 = GetValue<float>(drrr["Itax2"].ToString()),
                        Rebate89 = GetValue<float>(drrr["Rebate89"].ToString()),
                        Itax3 = GetValue<float>(drrr["Itax3"].ToString()),
                        Challan_Tax = GetValue<float>(drrr["Challan_Tax"].ToString()),
                        PreTds = GetValue<float>(drrr["PreTds"].ToString()),
                        FinalTax = GetValue<float>(drrr["FinalTax"].ToString()),
                        Manual = GetValue<bool>(drrr["Manual"].ToString()),
                        Rsinwords = GetValue<string>(drrr["Rsinwords"].ToString()),
                        sel = GetValue<int>(drrr["sel"].ToString()),
                        HRate = GetValue<float>(drrr["HRate"].ToString()),
                        CALC_PF = GetValue<bool>(drrr["CALC_PF"].ToString()),
                        CALC_PT = GetValue<bool>(drrr["CALC_PT"].ToString()),
                        sur_type = GetValue<string>(drrr["Surcharge_Type"].ToString()),
                        I115BAC = GetValue<int>(drrr["I115BAC"].ToString()),
                        ManualHRA = GetValue<bool>(drrr["ManualHRA"].ToString()),
                    });
                    #endregion



                    if (drrr.NextResult())
                        while (drrr.Read())
                            Rebates.Add(new tbl_Rebates_Computation()
                            {
                                Rebate80C = GetValue<float>(drrr["Rebate80C"].ToString()),
                                Rebate80CCC = GetValue<float>(drrr["Rebate80CCC"].ToString()),
                                Rebate80CCD = GetValue<float>(drrr["Rebate80CCD"].ToString()),
                                Rebate80CCD2 = GetValue<float>(drrr["Rebate80CCD2"].ToString()),
                                Rebate80QlfySal = GetValue<float>(drrr["Rebate80QlfySal"].ToString()),
                                Rebate80NetSal = GetValue<float>(drrr["Rebate80NetSal"].ToString()),
                                Rebate88D = GetValue<float>(drrr["Rebate88D"].ToString()),
                                Rebate80DD = GetValue<float>(drrr["Rebate80DD"].ToString()),
                                Rebate80DDB = GetValue<float>(drrr["Rebate80DDB"].ToString()),
                                Rebate80QQB = GetValue<float>(drrr["Rebate80QQB"].ToString()),
                                Rebate80E = GetValue<float>(drrr["Rebate80E"].ToString()),
                                Rebate80EE = GetValue<float>(drrr["Rebate80EE"].ToString()),
                                Rebate80G = GetValue<float>(drrr["Rebate80G"].ToString()),
                                Rebate80GG = GetValue<float>(drrr["Rebate80GG"].ToString()),
                                Rebate80GGA = GetValue<float>(drrr["Rebate80GGA"].ToString()),
                                Rebate80GGC = GetValue<float>(drrr["Rebate80GGC"].ToString()),
                                Rebate80RRB = GetValue<float>(drrr["Rebate80RRB"].ToString()),
                                Rebate80U = GetValue<float>(drrr["Rebate80U"].ToString()),
                                Rebate80CCG = GetValue<float>(drrr["Rebate80CCG"].ToString()),
                                Rebate80TTA = GetValue<float>(drrr["Rebate80TTA"].ToString()),
                                Rebate80CCD1B = GetValue<float>(drrr["Rebate80CCD1B"].ToString()),


                                Rebate80C_Ded = GetValue<float>(drrr["Rebate80C_Ded"].ToString()),
                                Rebate80CCC_Ded = GetValue<float>(drrr["Rebate80CCC_Ded"].ToString()),
                                Rebate80CCD_Ded = GetValue<float>(drrr["Rebate80CCD_Ded"].ToString()),
                                Rebate80CCD2_Ded = GetValue<float>(drrr["Rebate80CCD2_Ded"].ToString()),
                                Rebate88D_Ded = GetValue<float>(drrr["Rebate88D_Ded"].ToString()),
                                Rebate80DD_Ded = GetValue<float>(drrr["Rebate80DD_Ded"].ToString()),
                                Rebate80DDB_Ded = GetValue<float>(drrr["Rebate80DDB_Ded"].ToString()),
                                Rebate80QQB_Ded = GetValue<float>(drrr["Rebate80QQB_Ded"].ToString()),
                                Rebate80E_Ded = GetValue<float>(drrr["Rebate80E_Ded"].ToString()),
                                Rebate80EE_Ded = GetValue<float>(drrr["Rebate80EE_Ded"].ToString()),
                                Rebate80G_Ded = GetValue<float>(drrr["Rebate80G_Ded"].ToString()),
                                Rebate80GG_Ded = GetValue<float>(drrr["Rebate80GG_Ded"].ToString()),
                                Rebate80GGA_Ded = GetValue<float>(drrr["Rebate80GGA_Ded"].ToString()),
                                Rebate80GGC_Ded = GetValue<float>(drrr["Rebate80GGC_Ded"].ToString()),
                                Rebate80RRB_Ded = GetValue<float>(drrr["Rebate80RRB_Ded"].ToString()),
                                Rebate80U_Ded = GetValue<float>(drrr["Rebate80U_Ded"].ToString()),
                                Rebate80CCG_Ded = GetValue<float>(drrr["Rebate80CCG_Ded"].ToString()),
                                Rebate80TTA_Ded = GetValue<float>(drrr["Rebate80TTA_Ded"].ToString()),
                                Rebate80CCD1B_Ded = GetValue<float>(drrr["Rebate80CCD1B_Ded"].ToString()),


                                Rebate80G_Qlfy = GetValue<float>(drrr["Rebate80G_Qlfy"].ToString()),
                                Rebate80GG_Qlfy = GetValue<float>(drrr["Rebate80GG_Qlfy"].ToString()),
                                Rebate80GGA_Qlfy = GetValue<float>(drrr["Rebate80GGA_Qlfy"].ToString()),
                                Rebate80GGC_Qlfy = GetValue<float>(drrr["Rebate80GGC_Qlfy"].ToString()),
                                Rebate80RRB_Qlfy = GetValue<float>(drrr["Rebate80RRB_Qlfy"].ToString()),
                                Rebate80U_Qlfy = GetValue<float>(drrr["Rebate80U_Qlfy"].ToString()),
                                Rebate80CCG_Qlfy = GetValue<float>(drrr["Rebate80CCG_Qlfy"].ToString()),
                                Rebate80TTA_Qlfy = GetValue<float>(drrr["Rebate80TTA_Qlfy"].ToString()),
                              
                            });



                    ////////////point 1 
                    /////monthly salary gird
                    #region MonthlySalaryBreakup

                    if (drrr.NextResult())
                        while (drrr.Read())
                            LMonthlySalaryBreakup.Add(new tbl_Monthly_Salary_BreakUp()
                            {
                                Employee_ID = GetValue<int>(drrr["Employee_ID"].ToString()),
                                Head_Type = GetValue<string>(drrr["Head_Type"].ToString()),
                                Head_Name = GetValue<string>(drrr["Head_Name"].ToString()),
                                Head_ID = GetValue<int>(drrr["Head_ID"].ToString()),
                                SalaryMonth = GetValue<int>(drrr["SalaryMonth"].ToString()),
                                Amount = GetValue<float>(drrr["Amount"].ToString()),
                            });

                    #endregion

                    //////perquisites
                    #region PErquisites
                    if (drrr.NextResult())
                        while (drrr.Read())
                            Lperquisites.Add(new tbl_Perquisites()
                            {
                                Employee_ID = GetValue<int>(drrr["Employee_ID"].ToString()),
                                Perquisites_ID = GetValue<int>(drrr["Perquisites_ID"].ToString()),
                                Perquisites_Name = GetValue<string>(drrr["Perquisites_Name"].ToString()),
                                Perquisites_Value = GetValue<double>(drrr["Perquisites_Value"].ToString()),
                                EmployeePaid_Amt = GetValue<double>(drrr["EmployeePaid_Amt"].ToString()),
                                Taxable_Amt = GetValue<double>(drrr["Taxable_Amt"].ToString()),
                            });
                    #endregion

                    /////////point 2
                    ////////section 10
                    #region Section 10
                    if (drrr.NextResult())
                    {
                        while (drrr.Read())
                        {
                            Lsection10.Add(new tbl_Section_10
                            {
                                Head_ID = GetValue<int>(drrr["Head_ID"].ToString()),
                                Employee_ID = GetValue<int>(drrr["Employee_ID"].ToString()),
                                Amount = GetValue<float>(drrr["Amount"].ToString()),
                                Head_Name = GetValue<string>(drrr["Head_Name"].ToString()),
                                hname = GetValue<string>(drrr["hname"].ToString()),
                                Limit = GetValue<string>(drrr["Limit"].ToString())
                            });
                        }
                    }
                    #endregion

                    ////////point 4
                    ///////deductions profession tax
                    #region PT

                    if (drrr.NextResult())
                        while (drrr.Read())
                            LProfessionTax.Add(new tbl_Monthly_Salary_BreakUp()
                            {
                                Employee_ID = GetValue<int>(drrr["Employee_ID"].ToString()),
                                Head_Type = GetValue<string>(drrr["Head_Type"].ToString()),
                                Head_Name = GetValue<string>(drrr["Head_Name"].ToString()),
                                Head_ID = GetValue<int>(drrr["Head_ID"].ToString()),
                                SalaryMonth = GetValue<int>(drrr["SalaryMonth"].ToString()),
                                Amount = GetValue<float>(drrr["Amount"].ToString()),
                            });

                    #endregion


                    /////point 9
                    #region Section80c tds rebate
                    if (drrr.NextResult())
                        while (drrr.Read())
                        {
                            LTDSRebate.Add(new tbl_TDS_Rebate()
                            {
                                Rebate_ID = GetValue<int>(drrr["Rebate_ID"].ToString()),
                                Rebate_Name = GetValue<string>(drrr["Rebate_Name"].ToString()),
                                Amount = GetValue<float>(drrr["Amount"].ToString())
                            });
                        }
                    #endregion

                    ////////point 2 section 10 calculation related table
                    #region HRA Rent receipt
                    if (drrr.NextResult())
                        while (drrr.Read())
                        {
                            LHRARentReceipt.Add(new tbl_HRA_Rent_Receipt()
                            {
                                Amount = GetValue<float>(drrr["Amount"].ToString()),
                                Month_No = GetValue<int>(drrr["Month_No"].ToString()),
                            });
                        }
                    #endregion

                    ////////point 4 deductions tax on employeement calculation related table
                    if (drrr.NextResult())
                        while (drrr.Read())
                        {
                            LProfessiontaxMaster.Add(new tbl_Professionaltax_Master()
                            {
                                From_Tax_Amount = GetValue<float>(drrr["From_Tax_Amount"].ToString()),
                                To_Tax_Amount = GetValue<float>(drrr["To_Tax_Amount"].ToString()),
                                Slab = GetValue<float>(drrr["Slab"].ToString()),
                            });
                        }

                    ////////point 13 Incometax Slab Calculation
                    if (drrr.NextResult())
                        while (drrr.Read())
                        {
                            LIncomeTaxMaster.Add(new tbl_Incometax_Master()
                            {
                                SlabTitle = GetValue<string>(drrr["SlabTitle"].ToString()),
                                SlabSubTitle = GetValue<string>(drrr["SlabSubTitle"].ToString()),
                                Slab = GetValue<float>(drrr["Slab"].ToString()),
                                Tax_Amount = GetValue<double>(drrr["Tax_Amount"].ToString()),
                            });
                        }

                    ////////point 15 16 17 calculation related
                    if (drrr.NextResult())
                        while (drrr.Read())
                        {
                            LtblEmployeeTDSReletatedOtherDetails.Add(new tblEmployeeTDSReletatedOtherDetails()
                            {
                                SurchargePer = GetValue<string>(drrr["SurchargePer"].ToString()),
                                Cessper = GetValue<string>(drrr["Cessper"].ToString()),
                                HCessper = GetValue<string>(drrr["HCessper"].ToString()),
                                HealthPer = GetValue<string>(drrr["HealthPer"].ToString()),
                                ChallanTDS = GetValue<string>(drrr["ChallanTDS"].ToString()),
                                ProfessionTaxIDS = GetValue<string>(drrr["ProfessionTaxIDS"].ToString())
                            });
                        }


                    ////////point 13 Incometax Slab Calculation
                    if (drrr.NextResult())
                        while (drrr.Read())
                        {
                            LChallanDts.Add(new tblChallanSummary()
                            {
                                Quater = GetValue<string>(drrr["Quater"].ToString()),
                                Challan_NO = GetValue<string>(drrr["Challan_NO"].ToString()),
                                Challan_Date = GetValue<string>(drrr["Challan_Date"].ToString() == "" ? "" : Convert.ToDateTime(drrr["Challan_Date"].ToString()).ToString("dd/MM/yyyy")),
                                TDS_Deduction_Date = GetValue<string>(drrr["TDS_Deduction_Date"].ToString() == "" ? "" : Convert.ToDateTime(drrr["TDS_Deduction_Date"].ToString()).ToString("dd/MM/yyyy")),
                                Employee_Salary = GetValue<string>(drrr["Employee_Salary"].ToString()),
                                TDS_Amount = GetValue<string>(drrr["TDS_Amount"].ToString()),
                                Surcharge_Amount = GetValue<string>(drrr["Surcharge_Amount"].ToString()),
                                EducationCess_Amount = GetValue<string>(drrr["EducationCess_Amount"].ToString()),
                                High_EductionCess_Amount = GetValue<string>(drrr["High_EductionCess_Amount"].ToString()),
                                Total_TDS_Amount = GetValue<string>(drrr["Total_TDS_Amount"].ToString()),
                                Employee_ID = GetValue<int>(drrr["Employee_ID"].ToString()),
                            });
                        }

                    if (drrr.NextResult())
                        while (drrr.Read())
                        {
                            IncomeTaxMaster_Multi.Add(new tbl_Incometax_Master_Multi()
                            {
                                SlabTitle = GetValue<string>(drrr["SlabTitle"].ToString()),
                                SlabSubTitle = GetValue<string>(drrr["SlabSubTitle"].ToString()),
                                Slab = GetValue<float>(drrr["Slab"].ToString()),
                                Tax_Amount = GetValue<double>(drrr["Tax_Amount"].ToString()),
                            });
                        }
                }

                foreach (Tbl_TDS_Computation t in LTDSComputation)
                {
                    t.LMonthlySalaryBreakup = LMonthlySalaryBreakup;
                    t.TRebates = Rebates;
                    t.LPerquisites = Lperquisites;
                    t.LSection10 = Lsection10;
                    t.LProfessionTax = LProfessionTax;
                    t.LTDSRebate = LTDSRebate;
                    t.LHRARentReceipt = LHRARentReceipt;
                    t.LProfessiontaxMaster = LProfessiontaxMaster;
                    t.LIncomeTaxMaster = LIncomeTaxMaster;
                    t.LtblEmployeeTDSReletatedOtherDetails = LtblEmployeeTDSReletatedOtherDetails;
                    t.TChallanDtls = LChallanDts;
                    t.IncomeTaxM = IncomeTaxMaster_Multi;
                }


            }
            return LTDSComputation as IEnumerable<Tbl_TDS_Computation>;
        }

        public IEnumerable<tbl_Rebate_Master> GetComputationPage(int compid)
        {
            List<tbl_Rebate_Master> Ltbl_Rebate_Master = new List<tbl_Rebate_Master>();
            using (SqlDataReader drrr = objDAL_TDSComputation.GetComputationPage(compid))
            {
                while (drrr.Read())
                {
                    Ltbl_Rebate_Master.Add(new tbl_Rebate_Master()
                    {
                        Rebate_Name = GetValue<string>(drrr["Rebate_Name"].ToString()),
                        Rebate_ID = GetValue<int>(drrr["Rebate_ID"].ToString())
                    });
                }
            }
            return Ltbl_Rebate_Master as IEnumerable<tbl_Rebate_Master>;
        }

        public IEnumerable<tbl_Rebate_Limits> GetRebateLimits()
        {
            List<tbl_Rebate_Limits> Ltbl_Rebate_Limits = new List<tbl_Rebate_Limits>();
            using (SqlDataReader drrr = objDAL_TDSComputation.GetRebateLimits())
            {
                while (drrr.Read())
                {
                    Ltbl_Rebate_Limits.Add(new tbl_Rebate_Limits()
                    {
                        Rebate_Name = GetValue<string>(drrr["Rebate_Name"].ToString()),
                        Rebate_Limit = GetValue<double>(drrr["Rebate_Limit"].ToString()),
                        Salary_Limit = GetValue<double>(drrr["Salary_Limit"].ToString())
                    });
                }
            }
            return Ltbl_Rebate_Limits as IEnumerable<tbl_Rebate_Limits>;
        }

        public IEnumerable<tbl_TDS_Computation> GetComputationPageCommonIDs(string p)
        {
            List<tbl_TDS_Computation> tblCommonIDS = new List<tbl_TDS_Computation>();
            using (SqlDataReader drrr = objDAL_TDSComputation.GetComputationPageCommonIDs(p))
            {
                while (drrr.Read())
                {
                    tblCommonIDS.Add(new tbl_TDS_Computation()
                    {
                        EmpName = GetValue<string>(drrr["basicdahraids"].ToString()),
                        Department_Name = GetValue<string>(drrr["ptaxids"].ToString()),
                        Designation_Name = GetValue<string>(drrr["pfids"].ToString()),
                        PF = GetValue<double>(drrr["PFPercentage"].ToString()),
                        PreSal = GetValue<double>(drrr["PF_Limit"].ToString())
                    });
                }
            }
            return tblCommonIDS as IEnumerable<tbl_TDS_Computation>;
        }

        public int BAL_SaveEmployeeComputation(Tbl_TDS_SaveComputation tobj)
        {
            return objDAL_TDSComputation.DAL_SaveEmployeeComputation(tobj);
        }

        public IEnumerable<tbl_Surcharge_Slab> BAL_getSurchargeSlab( int Company_ID, string Conn)
        {
            List<tbl_Surcharge_Slab> tblsurcharge = new List<tbl_Surcharge_Slab>();
            try
            {
                using (SqlDataReader drrr = objDAL_TDSComputation.DAL_getSurchargeSlab(Company_ID, Conn))
                {
                    while (drrr.Read())
                    {
                        tblsurcharge.Add(new tbl_Surcharge_Slab()
                        {
                            SurchargePer = GetValue<double>(drrr["Surcharge_Percent"].ToString()),
                            SurchargeSalary = GetValue<double>(drrr["Taxable_Salary"].ToString()),
                            Marginal_Surcharge = GetValue<double>(drrr["Marginal_Amount"].ToString()),
                            App_Type = GetValue<string>(drrr["App_Type"].ToString()),
                            Surchargetype = GetValue<string>(drrr["Surchargetype"].ToString()),
                        });
                    }
                }
            }
            catch (Exception ex)
            {

            }
            return tblsurcharge as IEnumerable<tbl_Surcharge_Slab>;
        }


        public IEnumerable<tbl_Incometax_Master> BAL_getIncomeTax115(int Company_ID, string Emp, string Conn)
        {
            List<tbl_Incometax_Master> tblIncomeTax115 = new List<tbl_Incometax_Master>();
            using (SqlDataReader drrr = objDAL_TDSComputation.DAL_getIncomeTax115(Company_ID, Emp, Conn))
            {
                while (drrr.Read())
                {
                    tblIncomeTax115.Add(new tbl_Incometax_Master()
                    {
                        SlabTitle = GetValue<string>(drrr["SlabTitle"].ToString()),
                        SlabSubTitle = GetValue<string>(drrr["SlabSubTitle"].ToString()),
                        Slab = GetValue<float>(drrr["Slab"].ToString()),
                        Tax_Amount = GetValue<double>(drrr["Tax_Amount"].ToString()),
                    });
                }
            }
            return tblIncomeTax115 as IEnumerable<tbl_Incometax_Master>;
        }


        public IEnumerable<Tbl_TDS_Computation> BAL_getEmployeeRentDetails(int Emplolyee_ID, int Company_ID, string Conn)
        {
            List<Tbl_TDS_Computation> tblCommonIDS = new List<Tbl_TDS_Computation>();
            using (SqlDataReader drrr = objDAL_TDSComputation.DAL_getEmployeeRentDetails(Emplolyee_ID, Company_ID, Conn))
            {
                while (drrr.Read())
                {
                    tblCommonIDS.Add(new Tbl_TDS_Computation()
                    {
                        Employee_ID = GetValue<int>(drrr["Employee_ID"].ToString()),
                        FirstName = GetValue<string>(drrr["FirstName"].ToString()),
                        Rent_Payment = GetValue<bool>(drrr["Rent_Payment"].ToString()),
                        Count_PAN_landlord = GetValue<int>(drrr["Count_PAN_landlord"].ToString()),
                        PAN_landlord1 = GetValue<string>(drrr["PAN_landlord1"].ToString()),
                        Name_landlord1 = GetValue<string>(drrr["Name_landlord1"].ToString()),
                        PAN_landlord2 = GetValue<string>(drrr["PAN_landlord2"].ToString()),
                        Name_landlord2 = GetValue<string>(drrr["Name_landlord2"].ToString()),
                        PAN_landlord3 = GetValue<string>(drrr["PAN_landlord3"].ToString()),
                        Name_landlord3 = GetValue<string>(drrr["Name_landlord3"].ToString()),
                        PAN_landlord4 = GetValue<string>(drrr["PAN_landlord4"].ToString()),
                        Name_landlord4 = GetValue<string>(drrr["Name_landlord4"].ToString()),
                        Interest_lender = GetValue<bool>(drrr["Interest_lender"].ToString()),
                        Count_PAN_lender = GetValue<int>(drrr["Count_PAN_lender"].ToString()),
                        PAN_lender1 = GetValue<string>(drrr["PAN_lender1"].ToString()),
                        Name_lender1 = GetValue<string>(drrr["Name_lender1"].ToString()),
                        PAN_lender2 = GetValue<string>(drrr["PAN_lender2"].ToString()),
                        Name_lender2 = GetValue<string>(drrr["Name_lender2"].ToString()),
                        PAN_lender3 = GetValue<string>(drrr["PAN_lender3"].ToString()),
                        Name_lender3 = GetValue<string>(drrr["Name_lender3"].ToString()),
                        PAN_lender4 = GetValue<string>(drrr["PAN_lender4"].ToString()),
                        Name_lender4 = GetValue<string>(drrr["Name_lender4"].ToString()),
                        Contributions_superannuation_fund = GetValue<bool>(drrr["Contributions_superannuation_fund"].ToString()),
                        Name_superannuation_fund = GetValue<string>(drrr["Name_superannuation_fund"].ToString()),
                        Frm_DT_superannuation_fund = GetValue<DateTime>(drrr["Frm_DT_superannuation_fund"].ToString()),
                        TO_DT_superannuation_fund = GetValue<DateTime>(drrr["TO_DT_superannuation_fund"].ToString()),
                        principal_interest_superannuation_fund = GetValue<double>(drrr["principal_interest_superannuation_fund"].ToString()),
                        Rate_deduction_tax_3yrs = GetValue<double>(drrr["Rate_deduction_tax_3yrs"].ToString()),
                        Repayment_superannuation_fund = GetValue<double>(drrr["Repayment_superannuation_fund"].ToString()),
                        Total_Income_superannuation_fund = GetValue<double>(drrr["Total_Income_superannuation_fund"].ToString())
                    });
                }
            }
            return tblCommonIDS as IEnumerable<Tbl_TDS_Computation>;
        }

        public int BAL_setEmployeeRentDetails(Tbl_TDS_Computation tobj)
        {
            return objDAL_TDSComputation.DAL_setEmployeeRentDetails(tobj);
        }

        public IEnumerable<tbl_HeadName> Gt_HeadName(int Compid, string Conn)
        {

            List<tbl_HeadName> Ltbl_Head_Master = new List<tbl_HeadName>();
            try
            {
                using (SqlDataReader drrr = objDAL_TDSComputation.Get_Head_Master_with_Sec10(Compid, Conn))
                {
                    while (drrr.Read())
                    {
                        Ltbl_Head_Master.Add(new tbl_HeadName()
                        {
                            Head_id = GetValue<int>(drrr["Head_ID"].ToString()),
                            Head_Name = GetValue<string>(drrr["Head_Name"].ToString()),
                            Head_Section = GetValue<string>(drrr["Head_Section"].ToString()),
                            Head_Sec = GetValue<int>(drrr["Section10"].ToString()),
                        });
                    }
                }
                
            }
            catch (Exception ex)
            {

            }
            return Ltbl_Head_Master as IEnumerable<tbl_HeadName>;
        }

        
        public IEnumerable<tbl_HeadName> BAL_UpdateHead(int Compid, string Conn, string Multi)
        {

            List<tbl_HeadName> update_Head_Master = new List<tbl_HeadName>();
            try
            {
                using (SqlDataReader drrr = objDAL_TDSComputation.DAL_UpdateHead(Compid, Conn, Multi))
                {
                    while (drrr.Read())
                    {
                        update_Head_Master.Add(new tbl_HeadName()
                        {
                            Head_id = GetValue<int>(drrr["Headid"].ToString()),
                        });
                    }
                }
            }
            catch (Exception ex)
            {

            }
            return update_Head_Master as IEnumerable<tbl_HeadName>;
        }

        //public IEnumerable<tbl_Rebate_Err> BAL_CheckRebate(int Company_ID)
        //{
        //    List<tbl_Rebate_Err> LTDS = new List<tbl_Rebate_Err>();
        //    try
        //    {
        //        using (SqlDataReader drrr = objDAL_TDSComputation.DAL_Check_Rebate(Company_ID))
        //        {
        //            while (drrr.Read())
        //            {
        //                LTDS.Add(new tbl_Rebate_Err()
        //                {
        //                    Employee = GetValue<string>(drrr["FirstName"].ToString()),
        //                    Rebate_Name = GetValue<string>(drrr["Rebate"].ToString()),
        //                    Investment = GetValue<double>(drrr["i"].ToString()),
        //                    Deduction = GetValue<double>(drrr["j"].ToString()),
        //                });
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {

        //    }
        //    return LTDS as IEnumerable<tbl_Rebate_Err>;
        //}

        public IEnumerable<tbl_HRR> BAL_getHRR_Grd(int Employee_ID, string Conn)
        {

           List<tbl_HRR> tblHrr = new List<tbl_HRR>();
            try
            {
                using (SqlDataReader drrr = objDAL_TDSComputation.DAL_getHRR_Grd(Employee_ID, Conn))
                {
                    while (drrr.Read())
                    {
                        tblHrr.Add(new tbl_HRR()
                        {
                            Sbasic = GetValue<double>(drrr["SBasic"].ToString()),
                            Employee_ID = GetValue<int>(drrr["Employee_ID"].ToString()),
                            HRA = GetValue<double>(drrr["HRA"].ToString()),
                            HRR = GetValue<double>(drrr["Amount"].ToString()),
                            Month_no = GetValue<int>(drrr["Month_No"].ToString()),
                            Month_Name = GetValue<string>(drrr["Month_Name"].ToString()),

                        });
                    }
                }
            }
            catch (Exception ex)
            {

            }
            return tblHrr as IEnumerable<tbl_HRR>;
        }


        public IEnumerable<tbl_HRR> BAL_SaveHRR(int Compid, int Employee_ID, string Conn, string Multi )
        {
            List<tbl_HRR> tblHrr = new List<tbl_HRR>();
            using (SqlDataReader drrr = objDAL_TDSComputation.DAL_SaveHRR_Grd(Compid, Employee_ID, Conn, Multi))
            {
                while (drrr.Read())
                {
                    tblHrr.Add(new tbl_HRR()
                    {
                        Hrrid = GetValue<int>(drrr["HrrId"].ToString()),
                    });
                }
            }
            return tblHrr as IEnumerable<tbl_HRR>;
        }

        public DataSet BAL_CheckRebate(int Company_ID)  
        {
            DataSet ds = new DataSet();
            try
            {
                ds = objDAL_TDSComputation.DAL_Check_Rebate(Company_ID);

            }
            catch (Exception ex)
            {

            }
            return ds;
        }

        public DataSet BAL_ExportXL(int Company_ID, string fy)
        {

            DataSet ds = new DataSet();
            try
            {
                ds = objDAL_TDSComputation.DAL_ExportXL(Company_ID, fy);

            }
            catch (Exception ex)
            {

            }
            return ds;
        }

    }
}
