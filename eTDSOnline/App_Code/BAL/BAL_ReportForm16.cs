using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;
using CommonLibrary;
using System.Data.SqlClient;
using System.IO;
using System.Configuration;
using System.Web;


namespace BusinessLayer
{
    public class BAL_ReportForm16 : CommonFunctions
    {
        List<tbl_salary_structure> tblEmp = new List<tbl_salary_structure>();
        DAL_ReportForm16 objDAL_ReportForm16 = new DAL_ReportForm16();

        public List<CommonLibrary.tbl_salary_structure> BAL_GetEmployeeForSelection(tbl_Employee_Master obj)
        {
            List<tbl_salary_structure> tbl = new List<tbl_salary_structure>();
            using (SqlDataReader drrr = objDAL_ReportForm16.DAL_GetEmployeeForSelection(obj))
            {
                while (drrr.Read())
                {
                    tbl.Add(new tbl_salary_structure()
                    {
                        RowNumber = GetValue<int>(drrr["SrNo"].ToString()),
                        Employee_ID = GetValue<int>(drrr["Employee_ID"].ToString()),
                        FirstName = GetValue<string>(drrr["FirstName"].ToString()),
                        Designation_Name = GetValue<string>(drrr["Designation_Name"].ToString()),
                        Department_Name = GetValue<string>(drrr["Department_Name"].ToString()),
                        Join_DT = GetValue<string>(drrr["Join_DT"].ToString()),
                        Mobile_No = GetValue<string>(drrr["Mobile_No"].ToString()),
                        PAN_NO = GetValue<string>(drrr["PAN_NO"].ToString()),
                        PANVerified = GetValue<string>(drrr["PANVerified"].ToString()),
                        TotalCount = GetValue<int>(drrr["TotalCount"].ToString())
                    });
                }
            }
            return tbl;
        }

        public List<tbl_TDS_Computation> BAL_GetEmployeeComputationDetails(tbl_Employee_Master obj)
        {
            List<tbl_TDS_Computation> tbl = new List<tbl_TDS_Computation>();
            using (SqlDataReader drrr = objDAL_ReportForm16.DAL_GetEmployeeComputationDetails(obj))
            {
                while (drrr.Read())
                {
                    tbl.Add(new tbl_TDS_Computation()
                    {
                        Employee_ID = GetValue<int>(drrr["Employee_ID"].ToString()),
                        EmpName = GetValue<string>(drrr["EmployeeName"].ToString()),
                        PanNo = GetValue<string>(drrr["PAN"].ToString()),
                        Designation_Name = GetValue<string>(drrr["Designation_Name"].ToString()),
                        Department_Name = GetValue<string>(drrr["Department_Name"].ToString()),
                        Grossnet = GetValue<double>(drrr["Grossnet"].ToString()),
                        EducationCess = GetValue<double>(drrr["EducationCess"].ToString()),
                        Entertainment = GetValue<double>(drrr["Entertainment"].ToString()),
                        FinalTax = GetValue<double>(drrr["FinalTax"].ToString()),
                        StandardDeductions = GetValue<double>(drrr["StandardDeductions"].ToString()),
                        GrossEarn1 = GetValue<double>(drrr["GrossEarn1"].ToString()),
                        GrossEarn3 = GetValue<double>(drrr["GrossEarn3"].ToString()),
                        GrossEarn5 = GetValue<double>(drrr["GrossEarn5"].ToString()),
                        GrossEarn8 = GetValue<double>(drrr["GrossEarn8"].ToString()),
                        GrossPerks_B = GetValue<double>(drrr["GrossPerks_B"].ToString()),
                        GrossProfits_C = GetValue<double>(drrr["GrossProfits_C"].ToString()),
                        GrossTotal_D = GetValue<double>(drrr["GrossTotal_D"].ToString()),
                        HighEduCess = GetValue<double>(drrr["HighEduCess"].ToString()),
                        HRate = GetValue<double>(drrr["HRate"].ToString()),
                        IntHouseLoan = GetValue<double>(drrr["IntHouseLoan"].ToString()),
                        Itax1 = GetValue<double>(drrr["Itax1"].ToString()),
                        Itax2 = GetValue<double>(drrr["Itax2"].ToString()),
                        Itax3 = GetValue<double>(drrr["Itax3"].ToString()),
                        OtherIncome = GetValue<double>(drrr["OtherIncome"].ToString()),
                        PF = GetValue<double>(drrr["PF"].ToString()),
                        PreSal = GetValue<double>(drrr["PreSal"].ToString()),
                        PreTds = GetValue<double>(drrr["PreTds"].ToString()),
                        PTax = GetValue<double>(drrr["PTax"].ToString()),
                        Rebate80C = GetValue<double>(drrr["Rebate80C_Ded"].ToString()),
                        Rebate80CCC = GetValue<double>(drrr["Rebate80CCC_Ded"].ToString()),
                        Rebate80CCD = GetValue<double>(drrr["Rebate80CCD_Ded"].ToString()),
                        Rebate80CCD2 = GetValue<double>(drrr["Rebate80CCD2_Ded"].ToString()),
                        Rebate80CCD21B = GetValue<double>(drrr["Rebate80CCD1B_Ded"].ToString()),
                        Rebate80CCG = GetValue<double>(drrr["Rebate80CCG_Ded"].ToString()),
                        Rebate80DD = GetValue<double>(drrr["Rebate80DD_Ded"].ToString()),
                        Rebate80DDB = GetValue<double>(drrr["Rebate80DDB_Ded"].ToString()),
                        Rebate80E = GetValue<double>(drrr["Rebate80E_Ded"].ToString()),
                        Rebate80EE = GetValue<double>(drrr["Rebate80EE_Ded"].ToString()),
                        Rebate80G = GetValue<double>(drrr["Rebate80G_Ded"].ToString()),
                        Rebate80GG = GetValue<double>(drrr["Rebate80GG_Ded"].ToString()),
                        Rebate80GGA = GetValue<double>(drrr["Rebate80GGA_Ded"].ToString()),
                        Rebate80GGC = GetValue<double>(drrr["Rebate80GGC_Ded"].ToString()),
                        Rebate80NetSal = GetValue<double>(drrr["Rebate80NetSal"].ToString()),
                        Rebate80QlfySal = GetValue<double>(drrr["Rebate80QlfySal"].ToString()),
                        Rebate80QQB = GetValue<double>(drrr["Rebate80QQB_Ded"].ToString()),
                        Rebate80RRB = GetValue<double>(drrr["Rebate80RRB_Ded"].ToString()),
                        Rebate80TTA = GetValue<double>(drrr["Rebate80TTA_Ded"].ToString()),
                        Rebate80U = GetValue<double>(drrr["Rebate80U_Ded"].ToString()),
                        Rebate88D = GetValue<double>(drrr["Rebate88D_Ded"].ToString()),
                        Rebate89 = GetValue<double>(drrr["Rebate89"].ToString()),
                        RebateBonds = GetValue<double>(drrr["RebateBonds"].ToString()),
                        Rebatetds = GetValue<double>(drrr["Rebatetds"].ToString()),
                        Section_10 = GetValue<double>(drrr["Section_10"].ToString()),
                        Surcharge = GetValue<double>(drrr["Surcharge"].ToString()),
                        Total_Earnings = GetValue<double>(drrr["Total_Earnings"].ToString()),
                        TotalDeduction = GetValue<double>(drrr["TotalDeduction"].ToString()),
                        TotalRebate = GetValue<double>(drrr["TotalRebate"].ToString()),
                        Challan_Tax = GetValue<double>(drrr["Challan_Tax"].ToString())
                    });
                }
            }
            return tbl;
        }

        public List<tbl_Monthly_SAlary_For_Employee_Salary> BAL_GetEmployeeSetion10Details(tbl_Employee_Master obj)
        {
            List<tbl_Monthly_SAlary_For_Employee_Salary> tbl = new List<tbl_Monthly_SAlary_For_Employee_Salary>();
            using (SqlDataReader drrr = objDAL_ReportForm16.DAL_GetEmployeeSetion10Details(obj))
            {
                while (drrr.Read())
                {
                    tbl.Add(new tbl_Monthly_SAlary_For_Employee_Salary()
                    {
                        Employee_ID = GetValue<int>(drrr["Employee_ID"].ToString()),
                        Head_ID = GetValue<int>(drrr["Head_ID"].ToString()),
                        Amount = GetValue<double>(drrr["Amount"].ToString()),
                        Head_Name = GetValue<string>(drrr["Head_Name"].ToString())
                    });
                }
            }
            return tbl;
        }

        public List<tbl_Monthly_SAlary_For_Employee_Salary> BAL_GetEmployeeRebateDetails(tbl_Employee_Master obj)
        {
            List<tbl_Monthly_SAlary_For_Employee_Salary> tbl = new List<tbl_Monthly_SAlary_For_Employee_Salary>();
            using (SqlDataReader drrr = objDAL_ReportForm16.DAL_GetEmployeeRebateDetails(obj))
            {
                while (drrr.Read())
                {
                    tbl.Add(new tbl_Monthly_SAlary_For_Employee_Salary()
                    {
                        Employee_ID = GetValue<int>(drrr["Employee_ID"].ToString()),
                        Head_ID = GetValue<int>(drrr["Rebate_ID"].ToString()),
                        Amount = GetValue<double>(drrr["Amount"].ToString()),
                        Head_Name = GetValue<string>(drrr["Rebate_Name"].ToString())
                    });
                }
            }
            return tbl;
        }

        public string generateFrom16(string Empid, int Companyid, string fin_year, string date)
        {
            tbl_Employee_Master tblEmp = new tbl_Employee_Master();

            ///get company Details
            tblEmp.Company_ID = Companyid;
            List<tbl_Company_MAster> tblCompany = BAL_GetCompanyMaterDetails(tblEmp);

            //////get form16 settings
            List<tbl_Form16settings> tblform16 = BAL_BindForm16Settings(tblEmp);

            ///get Employee Details
            tblEmp.EmpName = Empid;
            List<tbl_TDS_Computation> tblComputation = BAL_GetEmployeeComputationDetails(tblEmp);

            ///get Employee Section 10 details
            List<tbl_Monthly_SAlary_For_Employee_Salary> tblSection10 = BAL_GetEmployeeSetion10Details(tblEmp);

            ///get Employee Rebate 80c Details
            List<tbl_Monthly_SAlary_For_Employee_Salary> tblRebate = BAL_GetEmployeeRebateDetails(tblEmp);

            ////////////delcarations and inistialize objects
            string CompanyName = "", CompanyAddress = "", AssesmentYear = "", Fromdate = "", Todate = "";
            string mergedBody = "", form16table = "";

            if (tblComputation.Count > 0)
            {
                AssesmentYear = "";

                string[] finyer = fin_year.Split('_');
                Fromdate = finyer[0];
                Todate = "20" + finyer[1];
                AssesmentYear = (Convert.ToInt32(Fromdate) + 1).ToString() + "-" + (Convert.ToInt32(Todate) + 1).ToString();

                /////////set Company Details
                CompanyName = tblCompany.Select(x => x.CompanyName).FirstOrDefault().ToString();

                if (!string.IsNullOrEmpty(tblCompany.Select(x => x.Flat_No).FirstOrDefault().ToString()))
                {
                    if (!string.IsNullOrEmpty(CompanyAddress))
                        CompanyAddress += ",<br>";

                    CompanyAddress += tblCompany.Select(x => x.Flat_No).FirstOrDefault().ToString();
                }



                if (!string.IsNullOrEmpty(tblCompany.Select(x => x.Name_Of_Building).FirstOrDefault().ToString()))
                {
                    if (!string.IsNullOrEmpty(CompanyAddress))
                        CompanyAddress += ",<br>";

                    CompanyAddress += tblCompany.Select(x => x.Name_Of_Building).FirstOrDefault().ToString();
                }



                if (!string.IsNullOrEmpty(tblCompany.Select(x => x.Street).FirstOrDefault().ToString()))
                {
                    if (!string.IsNullOrEmpty(CompanyAddress))
                        CompanyAddress += ",<br>";

                    CompanyAddress += tblCompany.Select(x => x.Street).FirstOrDefault().ToString();
                }



                if (!string.IsNullOrEmpty(tblCompany.Select(x => x.Area_Location).FirstOrDefault().ToString()))
                {
                    if (!string.IsNullOrEmpty(CompanyAddress))
                        CompanyAddress += ",<br>";

                    CompanyAddress += tblCompany.Select(x => x.Area_Location).FirstOrDefault().ToString();
                }



                {
                    if (!string.IsNullOrEmpty(tblCompany.Select(x => x.Town_City).FirstOrDefault().ToString()))
                        if (!string.IsNullOrEmpty(CompanyAddress))
                            CompanyAddress += ",<br>";

                    CompanyAddress += tblCompany.Select(x => x.Town_City).FirstOrDefault().ToString();
                }

                if (!string.IsNullOrEmpty(CompanyAddress))
                    CompanyAddress += ".";

                string getForm16 = HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings["GetFrom16Body"].ToString());

                getForm16 = ReturnHTML(getForm16);

                foreach (var row in tblComputation)
                {
                    form16table = getForm16;
                    ///set employee details
                    form16table = form16table.Replace("[XNameandAddressoftheEmployerX]", CompanyName + "</br>" + CompanyAddress);
                    form16table = form16table.Replace("[XNameanddesignationoftheEmployeeX]", row.EmpName);
                    form16table = form16table.Replace("[XXPANNoofTheDeducteeXXXX]", tblCompany.Select(x => x.PANNo).FirstOrDefault().ToString().ToUpper());
                    form16table = form16table.Replace("[XXXTANNooftheDeducteeXXX]", tblCompany.Select(x => x.TANNo).FirstOrDefault().ToString().ToUpper());
                    form16table = form16table.Replace("[XXXPANNooftheEmployeeXXX]", row.PanNo.ToUpper());
                    form16table = form16table.Replace("[XXXAssessmentYearXXX]", AssesmentYear);
                    form16table = form16table.Replace("[XXXFromXXX]", "01/04/" + Fromdate);
                    form16table = form16table.Replace("[XXXToXXX]", "31/03/" + Todate);
                    ///computation details
                    form16table = form16table.Replace("[XXXXXTotal_EarningsXXXXXXX]", row.Total_Earnings.ToString());
                    form16table = form16table.Replace("[XXXXXGrossPerks_BXXXXXXX]", row.GrossPerks_B.ToString());
                    form16table = form16table.Replace("[XXXXXGrossProfits_CXXXXXXX]", row.GrossProfits_C.ToString());
                    form16table = form16table.Replace("[XXXXGrossEarn1XXXXXXXX]", row.GrossEarn1.ToString());


                    //////////////make table from section 10
                    string Section10Table = "";
                    foreach (var section10 in tblSection10.Where(x => x.Employee_ID == row.Employee_ID).ToList())
                    {
                        Section10Table += "<tr>";
                        Section10Table += "<td class='bottomborder rightborder'>";
                        Section10Table += section10.Head_Name;
                        Section10Table += "</td>";
                        Section10Table += "<td class='bottomborder makeright'>";
                        Section10Table += section10.Amount;
                        Section10Table += "</td>";
                        Section10Table += "</tr>";
                    }
                    form16table = form16table.Replace("[XXXXXSection_10XXXXX]", row.Section_10.ToString());
                    form16table = form16table.Replace("[XXXXXXXSection10HeadsXXXXXXXX]", Section10Table);
                    form16table = form16table.Replace("[XXXXGrossEarn3XXXXXXXX]", row.GrossEarn3.ToString());

                    form16table = form16table.Replace("[XXXXSTDedXXXXXXXX]", row.StandardDeductions.ToString());
                    form16table = form16table.Replace("[XXXXEntertainmentXXXXXXXX]", row.Entertainment.ToString());
                    form16table = form16table.Replace("[XXXXPTaxXXXXXXXX]", row.PTax.ToString());
                    form16table = form16table.Replace("[XXXXTotalDeductionXXXXXXXX]", row.TotalDeduction.ToString());
                    form16table = form16table.Replace("[XXXXGrossEarn5XXXXXXXX]", row.GrossEarn5.ToString());
                    form16table = form16table.Replace("[XXXXOtherIncomeXXXXXXXX]", row.OtherIncome.ToString());
                    form16table = form16table.Replace("[XXXXIntHouseLoanXXXXXXXX]", row.IntHouseLoan.ToString());
                    form16table = form16table.Replace("[XXXXGrossEarn8XXXXXXXX]", row.GrossEarn8.ToString());

                    string Section80C = "";
                    foreach (var rebate in tblRebate.Where(x => x.Employee_ID == row.Employee_ID).ToList())
                    {
                        Section80C += "<tr>";
                        Section80C += "<td class='bottomborder rightborder'>";
                        Section80C += rebate.Head_Name;
                        Section80C += "</td>";
                        Section80C += "<td class='bottomborder makeright'>";
                        Section80C += rebate.Amount;
                        Section80C += "</td>";
                        Section80C += "</tr>";
                    }
                    form16table = form16table.Replace("[XXXXXXXSection80CXXXXXXXX]", Section80C);

                    form16table = form16table.Replace("[XXXXsection80CCCXXXXXXXX]", row.Rebate80CCC.ToString());
                    form16table = form16table.Replace("[XXXXsection80CCDXXXXXXXX]", row.Rebate80CCD.ToString());
                    form16table = form16table.Replace("[XXXXsection80CCD2XXXXXXXX]", row.Rebate80CCD2.ToString());
                    form16table = form16table.Replace("[XXXXsection80CCD21BXXXXXXXX]", row.Rebate80CCD21B.ToString());
                    form16table = form16table.Replace("[XXXXXSection80CCGXXXXXXX]", row.Rebate80CCG.ToString());
                    form16table = form16table.Replace("[XXXXXSection80DXXXXXXX]", row.Rebate88D.ToString());
                    form16table = form16table.Replace("[XXXXXSection80DDXXXXXXX]", row.Rebate80DD.ToString());
                    form16table = form16table.Replace("[XXXXXSection80DDBXXXXXXX]", row.Rebate80DDB.ToString());
                    form16table = form16table.Replace("[XXXXXSection80EXXXXXXX]", row.Rebate80E.ToString());
                    form16table = form16table.Replace("[XXXXXSection80EEXXXXXXX]", row.Rebate80EE.ToString());
                    form16table = form16table.Replace("[XXXXXSection80GXXXXXXX]", row.Rebate80G.ToString());
                    form16table = form16table.Replace("[XXXXXSection80GGXXXXXXX]", row.Rebate80GG.ToString());
                    form16table = form16table.Replace("[XXXXXSection80GGAXXXXXXX]", row.Rebate80GGA.ToString());
                    form16table = form16table.Replace("[XXXXXSection80GGCXXXXXXX]", row.Rebate80GGC.ToString());
                    form16table = form16table.Replace("[XXXXXSection80QQBXXXXXXX]", row.Rebate80QQB.ToString());
                    form16table = form16table.Replace("[XXXXXSection80RRBXXXXXXX]", row.Rebate80RRB.ToString());
                    form16table = form16table.Replace("[XXXXXSection80UXXXXXXX]", row.Rebate80U.ToString());
                    form16table = form16table.Replace("[XXXXXSection80TTAXXXXXXX]", row.Rebate80TTA.ToString());

                    ////set all qulifiying amt
                    form16table = form16table.Replace("[XXXXXXXXXXXX]", "0");

                    form16table = form16table.Replace("[XXXXXTotalRebateXXXXXXX]", row.TotalRebate.ToString());

                    form16table = form16table.Replace("[XXXXXGrossnetXXXXXXX]", row.Grossnet.ToString());
                    /////12
                    //if (row.Grossnet > 4999999)
                    //{ form16table = form16table.Replace("[XXXXXItax1XXXXXXX]", row.Itax2.ToString()); }
                    //else
                    //{ form16table = form16table.Replace("[XXXXXItax1XXXXXXX]", ((row.Itax1 - row.Rebatetds) + row.Surcharge).ToString()); }
                    /////13
                    //form16table = form16table.Replace("[XXXXXEducationCessandHighEduCessXXXXXXX]", (row.EducationCess + row.HighEduCess).ToString());
                    /////14
                    //if (row.Grossnet > 4999999)
                    //{ form16table = form16table.Replace("[XXXXXItax2XXXXXXX]", (row.Itax2 + row.EducationCess + row.HighEduCess).ToString()); }
                    //else
                    //{ form16table = form16table.Replace("[XXXXXItax2XXXXXXX]", (row.EducationCess + row.HighEduCess + (row.Itax1 - row.Rebatetds)).ToString()); }

                    /////15
                    //form16table = form16table.Replace("[XXXXXrebate89XXXXXXX]", row.Rebate89.ToString());
                    /////16
                    //if (row.Grossnet > 4999999)
                    //{ form16table = form16table.Replace("[XXXXXitax2andrebate89XXXXXXX]", ((row.EducationCess + row.HighEduCess + row.Itax2) - row.Rebate89).ToString()); }
                    //else
                    //{ form16table = form16table.Replace("[XXXXXitax2andrebate89XXXXXXX]", ((row.EducationCess + row.HighEduCess + (row.Itax1 - row.Rebatetds)) - row.Rebate89).ToString()); }

                    form16table = form16table.Replace("[XXXXXItax1XXXXXXX]", row.Itax1.ToString());

                    form16table = form16table.Replace("[XXXXXRebate87AXXXXXXX]", row.Rebatetds.ToString());

                    form16table = form16table.Replace("[XXXXXItax2XXXXXXX]", row.Itax2.ToString());
                    ///13
                    form16table = form16table.Replace("[XXXXXEducationCessandHighEduCessXXXXXXX]", (row.EducationCess + row.HighEduCess).ToString());
                    ///14

                    form16table = form16table.Replace("[XXXXXSurchargeXXXXXXX]", row.Surcharge.ToString());

                    form16table = form16table.Replace("[XXXXXItaxPayXXXXXXX]", (row.Itax2 + row.EducationCess + row.HighEduCess + row.Surcharge).ToString());

                    /////15
                    //form16table = form16table.Replace("[XXXXXrebate89XXXXXXX]", row.Rebate89.ToString());
                    /////16

                    //form16table = form16table.Replace("[XXXXXChallanXXXXXXX]", (row.Challan_Tax).ToString());


                    ///////17.
                    //form16table = form16table.Replace("[XXXXXPreTaxXXXXXXX]", (row.PreTds).ToString());

                    ///////18
                    //form16table = form16table.Replace("[XXXXXFinalXXXXXXX]", (row.FinalTax).ToString());




                    ///certification
                    form16table = form16table.Replace("[XXXXdesignation]", tblform16.Select(x => x.designation).FirstOrDefault().ToString());
                    form16table = form16table.Replace("[XXXXXXPlace]", tblform16.Select(x => x.location).FirstOrDefault().ToString());
                    form16table = form16table.Replace("[XXXPersoname]", tblform16.Select(x => x.personname).FirstOrDefault().ToString());
                    form16table = form16table.Replace("[XXXreleation]", tblform16.Select(x => x.releation).FirstOrDefault().ToString());
                    form16table = form16table.Replace("[XXXrelationname]", tblform16.Select(x => x.releationname).FirstOrDefault().ToString());
                    form16table = form16table.Replace("[XXXXCompanyName]", CompanyName);
                    form16table = form16table.Replace("[XXXXDate]", date);
                    BAL_ConvertCurrency ConCurrency = new BAL_ConvertCurrency();
                    form16table = form16table.Replace("[XXXXXamountinwords]", row.Challan_Tax.ToString() + " " + ConCurrency.RupeeInWords(Convert.ToDouble(row.Challan_Tax)));
                    mergedBody += form16table;

                    if (tblComputation.IndexOf(row) != tblComputation.Count - 1)
                        mergedBody += "<div style='width:100%; page-break-after:always;'></div><br><br>";
                }

                string GetHtmlBody = HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings["GetFrom16"].ToString());

                ///////get template body
                string templatebody = ReturnHTML(GetHtmlBody);
                templatebody = templatebody.Replace("[XXXXTAblbodyXXXXX]", mergedBody);
                ////write pdf
                WriteDocument("Form16(Part B).pdf", "application/pdf", templatebody, "Inline");
                return "";
            }
            else { return "Error"; }
        }

        public string generateComputationSummary(string Empid, int Companyid, string fin_year, string date)
        {
            tbl_Employee_Master tblEmp = new tbl_Employee_Master();

            ///get company Details
            tblEmp.Company_ID = Companyid;
            List<tbl_Company_MAster> tblCompany = BAL_GetCompanyMaterDetails(tblEmp);

            //////get form16 settings
            List<tbl_Form16settings> tblform16 = BAL_BindForm16Settings(tblEmp);

            ///get Employee Details
            tblEmp.EmpName = Empid;
            List<tbl_TDS_Computation> tblComputation = BAL_GetEmployeeComputationDetails(tblEmp);

            ///get Employee Section 10 details
            List<tbl_Monthly_SAlary_For_Employee_Salary> tblSection10 = BAL_GetEmployeeSetion10Details(tblEmp);

            ///get Employee Rebate 80c Details
            List<tbl_Monthly_SAlary_For_Employee_Salary> tblRebate = BAL_GetEmployeeRebateDetails(tblEmp);

            ////////////delcarations and inistialize objects
            string CompanyName = "", CompanyAddress = "", AssesmentYear = "", Fromdate = "", Todate = "";
            string mergedBody = "", form16table = "";

            if (tblComputation.Count > 0)
            {
                AssesmentYear = "";

                string[] finyer = fin_year.Split('_');
                Fromdate = finyer[0];
                Todate = "20" + finyer[1];
                AssesmentYear = (Convert.ToInt32(Fromdate) + 1).ToString() + "-" + (Convert.ToInt32(Todate) + 1).ToString();

                /////////set Company Details
                CompanyName = tblCompany.Select(x => x.CompanyName).FirstOrDefault().ToString();

                if (!string.IsNullOrEmpty(tblCompany.Select(x => x.Flat_No).FirstOrDefault().ToString()))
                {
                    if (!string.IsNullOrEmpty(CompanyAddress))
                        CompanyAddress += ",<br>";

                    CompanyAddress += tblCompany.Select(x => x.Flat_No).FirstOrDefault().ToString();
                }



                if (!string.IsNullOrEmpty(tblCompany.Select(x => x.Name_Of_Building).FirstOrDefault().ToString()))
                {
                    if (!string.IsNullOrEmpty(CompanyAddress))
                        CompanyAddress += ",<br>";

                    CompanyAddress += tblCompany.Select(x => x.Name_Of_Building).FirstOrDefault().ToString();
                }



                if (!string.IsNullOrEmpty(tblCompany.Select(x => x.Street).FirstOrDefault().ToString()))
                {
                    if (!string.IsNullOrEmpty(CompanyAddress))
                        CompanyAddress += ",<br>";

                    CompanyAddress += tblCompany.Select(x => x.Street).FirstOrDefault().ToString();
                }



                if (!string.IsNullOrEmpty(tblCompany.Select(x => x.Area_Location).FirstOrDefault().ToString()))
                {
                    if (!string.IsNullOrEmpty(CompanyAddress))
                        CompanyAddress += ",<br>";

                    CompanyAddress += tblCompany.Select(x => x.Area_Location).FirstOrDefault().ToString();
                }



                {
                    if (!string.IsNullOrEmpty(tblCompany.Select(x => x.Town_City).FirstOrDefault().ToString()))
                        if (!string.IsNullOrEmpty(CompanyAddress))
                            CompanyAddress += ",<br>";

                    CompanyAddress += tblCompany.Select(x => x.Town_City).FirstOrDefault().ToString();
                }

                if (!string.IsNullOrEmpty(CompanyAddress))
                    CompanyAddress += ".";

                string getForm16 = HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings["GetFormComputation"].ToString());

                getForm16 = ReturnHTML(getForm16);

                foreach (var row in tblComputation)
                {
                    form16table = getForm16;
                    ///set employee details
                    form16table = form16table.Replace("[XNameandAddressoftheEmployerX]", CompanyName + "</br>" + CompanyAddress);
                    form16table = form16table.Replace("[XNameanddesignationoftheEmployeeX]", row.EmpName);
                    form16table = form16table.Replace("[XXXXEmployeedesignation]", row.Designation_Name);
                    form16table = form16table.Replace("[XXPANNoofTheDeducteeXXXX]", tblCompany.Select(x => x.PANNo).FirstOrDefault().ToString().ToUpper());
                    form16table = form16table.Replace("[XXXTANNooftheDeducteeXXX]", tblCompany.Select(x => x.TANNo).FirstOrDefault().ToString().ToUpper());
                    form16table = form16table.Replace("[XXXPANNooftheEmployeeXXX]", row.PanNo.ToUpper());
                    form16table = form16table.Replace("[XXXAssessmentYearXXX]", AssesmentYear);
                    form16table = form16table.Replace("[XXXFromXXX]", "01/04/" + Fromdate);
                    form16table = form16table.Replace("[XXXToXXX]", "31/03/" + Todate);
                    ///computation details
                    form16table = form16table.Replace("[XXXXXTotal_EarningsXXXXXXX]", row.Total_Earnings.ToString());
                    form16table = form16table.Replace("[XXXXXGrossPerks_BXXXXXXX]", row.GrossPerks_B.ToString());
                    form16table = form16table.Replace("[XXXXXGrossProfits_CXXXXXXX]", row.GrossProfits_C.ToString());
                    form16table = form16table.Replace("[XXXXGrossEarn1XXXXXXXX]", row.GrossEarn1.ToString());


                    //////////////make table from section 10
                    string Section10Table = "";
                    foreach (var section10 in tblSection10.Where(x => x.Employee_ID == row.Employee_ID).ToList())
                    {
                        Section10Table += "<tr>";
                        Section10Table += "<td class='bottomborder rightborder'>";
                        Section10Table += section10.Head_Name;
                        Section10Table += "</td>";
                        Section10Table += "<td class='bottomborder makeright'>";
                        Section10Table += section10.Amount;
                        Section10Table += "</td>";
                        Section10Table += "</tr>";
                    }
                    form16table = form16table.Replace("[XXXXXSection_10XXXXX]", row.Section_10.ToString());
                    form16table = form16table.Replace("[XXXXXXXSection10HeadsXXXXXXXX]", Section10Table);
                    form16table = form16table.Replace("[XXXXGrossEarn3XXXXXXXX]", row.GrossEarn3.ToString());

                    form16table = form16table.Replace("[XXXXSTDedXXXXXXXX]", row.StandardDeductions.ToString());
                    form16table = form16table.Replace("[XXXXEntertainmentXXXXXXXX]", row.Entertainment.ToString());
                    form16table = form16table.Replace("[XXXXPTaxXXXXXXXX]", row.PTax.ToString());
                    form16table = form16table.Replace("[XXXXTotalDeductionXXXXXXXX]", row.TotalDeduction.ToString());
                    form16table = form16table.Replace("[XXXXGrossEarn5XXXXXXXX]", row.GrossEarn5.ToString());
                    form16table = form16table.Replace("[XXXXOtherIncomeXXXXXXXX]", row.OtherIncome.ToString());
                    form16table = form16table.Replace("[XXXXIntHouseLoanXXXXXXXX]", row.IntHouseLoan.ToString());
                    form16table = form16table.Replace("[XXXXGrossEarn8XXXXXXXX]", row.GrossEarn8.ToString());

                    string Section80C = "";
                    foreach (var rebate in tblRebate.Where(x => x.Employee_ID == row.Employee_ID).ToList())
                    {
                        Section80C += "<tr>";
                        Section80C += "<td class='bottomborder rightborder'>";
                        Section80C += rebate.Head_Name;
                        Section80C += "</td>";
                        Section80C += "<td class='bottomborder makeright'>";
                        Section80C += rebate.Amount;
                        Section80C += "</td>";
                        Section80C += "</tr>";
                    }
                    form16table = form16table.Replace("[XXXXXXXSection80CXXXXXXXX]", Section80C);

                    form16table = form16table.Replace("[XXXXsection80CCCXXXXXXXX]", row.Rebate80CCC.ToString());
                    form16table = form16table.Replace("[XXXXsection80CCDXXXXXXXX]", row.Rebate80CCD.ToString());
                    form16table = form16table.Replace("[XXXXsection80CCD2XXXXXXXX]", row.Rebate80CCD2.ToString());
                    form16table = form16table.Replace("[XXXXsection80CCD21BXXXXXXXX]", row.Rebate80CCD21B.ToString());
                    form16table = form16table.Replace("[XXXXXSection80CCGXXXXXXX]", row.Rebate80CCG.ToString());
                    form16table = form16table.Replace("[XXXXXSection80DXXXXXXX]", row.Rebate88D.ToString());
                    form16table = form16table.Replace("[XXXXXSection80DDXXXXXXX]", row.Rebate80DD.ToString());
                    form16table = form16table.Replace("[XXXXXSection80DDBXXXXXXX]", row.Rebate80DDB.ToString());
                    form16table = form16table.Replace("[XXXXXSection80EXXXXXXX]", row.Rebate80E.ToString());
                    form16table = form16table.Replace("[XXXXXSection80EEXXXXXXX]", row.Rebate80EE.ToString());
                    form16table = form16table.Replace("[XXXXXSection80GXXXXXXX]", row.Rebate80G.ToString());
                    form16table = form16table.Replace("[XXXXXSection80GGXXXXXXX]", row.Rebate80GG.ToString());
                    form16table = form16table.Replace("[XXXXXSection80GGAXXXXXXX]", row.Rebate80GGA.ToString());
                    form16table = form16table.Replace("[XXXXXSection80GGCXXXXXXX]", row.Rebate80GGC.ToString());
                    form16table = form16table.Replace("[XXXXXSection80QQBXXXXXXX]", row.Rebate80QQB.ToString());
                    form16table = form16table.Replace("[XXXXXSection80RRBXXXXXXX]", row.Rebate80RRB.ToString());
                    form16table = form16table.Replace("[XXXXXSection80UXXXXXXX]", row.Rebate80U.ToString());
                    form16table = form16table.Replace("[XXXXXSection80TTAXXXXXXX]", row.Rebate80TTA.ToString());

                    ////set all qulifiying amt
                    form16table = form16table.Replace("[XXXXXXXXXXXX]", "0");

                    form16table = form16table.Replace("[XXXXXTotalRebateXXXXXXX]", row.TotalRebate.ToString());

                    form16table = form16table.Replace("[XXXXXGrossnetXXXXXXX]", row.Grossnet.ToString());
                    ///12
                   
                    form16table = form16table.Replace("[XXXXXItax1XXXXXXX]", row.Itax1.ToString()); 
                    
                    form16table = form16table.Replace("[XXXXXRebate87AXXXXXXX]", row.Rebatetds.ToString());

                    form16table = form16table.Replace("[XXXXXItax2XXXXXXX]", row.Itax2.ToString());
                    ///13
                    form16table = form16table.Replace("[XXXXXEducationCessandHighEduCessXXXXXXX]", (row.EducationCess + row.HighEduCess ).ToString());
                    ///14

                    form16table = form16table.Replace("[XXXXXSurchargeXXXXXXX]", row.Surcharge.ToString());  
            
                    form16table = form16table.Replace("[XXXXXItaxPayXXXXXXX]", (row.Itax2 + row.EducationCess + row.HighEduCess  + row.Surcharge).ToString()); 

                    ///15
                    form16table = form16table.Replace("[XXXXXrebate89XXXXXXX]", row.Rebate89.ToString());
                    ///16

                    form16table = form16table.Replace("[XXXXXChallanXXXXXXX]", (row.Challan_Tax).ToString()); 


                    /////17.
                    form16table = form16table.Replace("[XXXXXPreTaxXXXXXXX]", (row.PreTds).ToString());

                    /////18
                    form16table = form16table.Replace("[XXXXXFinalXXXXXXX]", (row.FinalTax).ToString());

                    ///certification
                    form16table = form16table.Replace("[XXXXdesignation]", tblform16.Select(x => x.designation).FirstOrDefault().ToString());
                    form16table = form16table.Replace("[XXXXXXPlace]", tblform16.Select(x => x.location).FirstOrDefault().ToString());
                    form16table = form16table.Replace("[XXXPersoname]", tblform16.Select(x => x.personname).FirstOrDefault().ToString());
                    form16table = form16table.Replace("[XXXreleation]", tblform16.Select(x => x.releation).FirstOrDefault().ToString());
                    form16table = form16table.Replace("[XXXrelationname]", tblform16.Select(x => x.releationname).FirstOrDefault().ToString());
                    form16table = form16table.Replace("[XXXXCompanyName]", CompanyName);
                    form16table = form16table.Replace("[XXXXDate]", date);
                    BAL_ConvertCurrency ConCurrency = new BAL_ConvertCurrency();
                    form16table = form16table.Replace("[XXXXXamountinwords]", row.Challan_Tax.ToString() + " " + ConCurrency.RupeeInWords(Convert.ToDouble(row.Challan_Tax)));
                    mergedBody += form16table;

                    if (tblComputation.IndexOf(row) != tblComputation.Count - 1)
                        mergedBody += "<div style='width:100%; page-break-after:always;'></div><br><br>";
                }

                string GetHtmlBody = HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings["GetFrom16"].ToString());

                ///////get template body
                string templatebody = ReturnHTML(GetHtmlBody);
                templatebody = templatebody.Replace("[XXXXTAblbodyXXXXX]", mergedBody);
                ////write pdf
                WriteDocument("TdsComputationReport.pdf", "application/pdf", templatebody, "Inline");
                return "";
            }
            else { return "Error"; }
        }

        public string generateComputationDetail(string Empid, int Companyid, string fin_year, string date)
        {
            tbl_Employee_Master tblEmp = new tbl_Employee_Master();
            
            
            ///get company Details
            tblEmp.Company_ID = Companyid;
            List<tbl_Company_MAster> tblCompany = BAL_GetCompanyMaterDetails(tblEmp);

            //////get form16 settings
            List<tbl_Form16settings> tblform16 = BAL_BindForm16Settings(tblEmp);

            ///get Employee Details
            tblEmp.EmpName = Empid;
            List<tbl_TDS_Computation> tblComputation = BAL_GetEmployeeComputationDetails(tblEmp);

            ///get Employee Section 10 details
            List<tbl_Monthly_SAlary_For_Employee_Salary> tblSection10 = BAL_GetEmployeeSetion10Details(tblEmp);

            ///////Heads Name
            List<tbl_Computationdetaion_Report> tblHead = BAL_GetHeadDetails(tblEmp);
            List<tbl_HeadName_Report> tblHeadtwo = BAL_GetHeadtwoDetails(tblEmp);

            ///get Employee Rebate 80c Details
            List<tbl_Monthly_SAlary_For_Employee_Salary> tblRebate = BAL_GetEmployeeRebateDetails(tblEmp);

            ////////////delcarations and inistialize objects
            string CompanyName = "", CompanyAddress = "", AssesmentYear = "", Fromdate = "", Todate = "";
            string mergedBody = "", form16table = "";

            if (tblComputation.Count > 0)
            {
                AssesmentYear = "";

                string[] finyer = fin_year.Split('_');
                Fromdate = finyer[0];
                Todate = "20" + finyer[1];
                AssesmentYear = (Convert.ToInt32(Fromdate) + 1).ToString() + "-" + (Convert.ToInt32(Todate) + 1).ToString();

                /////////set Company Details
                CompanyName = tblCompany.Select(x => x.CompanyName).FirstOrDefault().ToString();

                if (!string.IsNullOrEmpty(tblCompany.Select(x => x.Flat_No).FirstOrDefault().ToString()))
                {
                    if (!string.IsNullOrEmpty(CompanyAddress))
                        CompanyAddress += ",<br>";

                    CompanyAddress += tblCompany.Select(x => x.Flat_No).FirstOrDefault().ToString();
                }



                if (!string.IsNullOrEmpty(tblCompany.Select(x => x.Name_Of_Building).FirstOrDefault().ToString()))
                {
                    if (!string.IsNullOrEmpty(CompanyAddress))
                        CompanyAddress += ",<br>";

                    CompanyAddress += tblCompany.Select(x => x.Name_Of_Building).FirstOrDefault().ToString();
                }



                if (!string.IsNullOrEmpty(tblCompany.Select(x => x.Street).FirstOrDefault().ToString()))
                {
                    if (!string.IsNullOrEmpty(CompanyAddress))
                        CompanyAddress += ",<br>";

                    CompanyAddress += tblCompany.Select(x => x.Street).FirstOrDefault().ToString();
                }



                if (!string.IsNullOrEmpty(tblCompany.Select(x => x.Area_Location).FirstOrDefault().ToString()))
                {
                    if (!string.IsNullOrEmpty(CompanyAddress))
                        CompanyAddress += ",<br>";

                    CompanyAddress += tblCompany.Select(x => x.Area_Location).FirstOrDefault().ToString();
                }



                {
                    if (!string.IsNullOrEmpty(tblCompany.Select(x => x.Town_City).FirstOrDefault().ToString()))
                        if (!string.IsNullOrEmpty(CompanyAddress))
                            CompanyAddress += ",<br>";

                    CompanyAddress += tblCompany.Select(x => x.Town_City).FirstOrDefault().ToString();
                }

                if (!string.IsNullOrEmpty(CompanyAddress))
                    CompanyAddress += ".";

                string getForm16 = HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings["GetFormDetailComputation"].ToString());

                getForm16 = ReturnHTML(getForm16);

                foreach (var row in tblComputation)
                {
                    form16table = getForm16;
                    ///set employee details
                    form16table = form16table.Replace("[XNameandAddressoftheEmployerX]", CompanyName + "</br>" + CompanyAddress);
                    form16table = form16table.Replace("[XNameanddesignationoftheEmployeeX]", row.EmpName);
                    form16table = form16table.Replace("[XXXXEmployeedesignation]", row.Designation_Name);
                    form16table = form16table.Replace("[XXPANNoofTheDeducteeXXXX]", tblCompany.Select(x => x.PANNo).FirstOrDefault().ToString().ToUpper());
                    form16table = form16table.Replace("[XXXTANNooftheDeducteeXXX]", tblCompany.Select(x => x.TANNo).FirstOrDefault().ToString().ToUpper());
                    form16table = form16table.Replace("[XXXPANNooftheEmployeeXXX]", row.PanNo.ToUpper());
                    form16table = form16table.Replace("[XXXAssessmentYearXXX]", AssesmentYear);
                    form16table = form16table.Replace("[XXXFromXXX]", "01/04/" + Fromdate);
                    form16table = form16table.Replace("[XXXToXXX]", "31/03/" + Todate);
                    ///computation details
                    form16table = form16table.Replace("[XXXXXTotal_EarningsXXXXXXX]", row.Total_Earnings.ToString());
                    form16table = form16table.Replace("[XXXXXGrossPerks_BXXXXXXX]", row.GrossPerks_B.ToString());
                    form16table = form16table.Replace("[XXXXXGrossProfits_CXXXXXXX]", row.GrossProfits_C.ToString());
                    form16table = form16table.Replace("[XXXXGrossEarn1XXXXXXXX]", row.GrossEarn1.ToString());


                    //////////////make table from section 10
                    string Section10Table = "";
                    foreach (var section10 in tblSection10.Where(x => x.Employee_ID == row.Employee_ID).ToList())
                    {
                        Section10Table += "<tr>";
                        Section10Table += "<td class='bottomborder rightborder'>";
                        Section10Table += section10.Head_Name;
                        Section10Table += "</td>";
                        Section10Table += "<td class='bottomborder makeright'>";
                        Section10Table += section10.Amount;
                        Section10Table += "</td>";
                        Section10Table += "</tr>";
                    }

                    string HeadNametable1 = "";
                    foreach(var headname in tblHead.Where(x => x.Employee_ID == row.Employee_ID).ToList())
                    {
                        HeadNametable1 += "<tr>";
                        HeadNametable1 += "<td  width='25% '>";
                        HeadNametable1 += headname.HeadName;
                        HeadNametable1 += "</td>";
                        HeadNametable1 += "<td class='makeright' width='25% '>";
                        HeadNametable1 += headname.Amt;
                        HeadNametable1 += "</td>";
                        HeadNametable1 += "</tr>";
                    }

                    string HeadNametable2 = "";
                    foreach (var headname in tblHeadtwo.Where(x => x.Employee_ID == row.Employee_ID).ToList())
                    {
                        HeadNametable2 += "<tr>";
                        HeadNametable2 += "<td width='25% '>";
                        HeadNametable2 += headname.HeadName;
                        HeadNametable2 += "</td>";
                        HeadNametable2 += "<td class='makeright' width='25% '>";
                        HeadNametable2 += headname.Amt;
                        HeadNametable2 += "</td>";
                        HeadNametable2 += "</tr>";
                    }

                    form16table = form16table.Replace("[XXXXXXXHeadNameXXXXXXXX]", HeadNametable1);
                    form16table = form16table.Replace("[XXXXXXXHeadNameTwoXXXXXXXX]", HeadNametable2);

                    form16table = form16table.Replace("[XXXXXSection_10XXXXX]", row.Section_10.ToString());
                    form16table = form16table.Replace("[XXXXXXXSection10HeadsXXXXXXXX]", Section10Table);
                    form16table = form16table.Replace("[XXXXGrossEarn3XXXXXXXX]", row.GrossEarn3.ToString());

                    form16table = form16table.Replace("[XXXXSTDedXXXXXXXX]", row.StandardDeductions.ToString());
                    form16table = form16table.Replace("[XXXXEntertainmentXXXXXXXX]", row.Entertainment.ToString());
                    form16table = form16table.Replace("[XXXXPTaxXXXXXXXX]", row.PTax.ToString());
                    form16table = form16table.Replace("[XXXXTotalDeductionXXXXXXXX]", row.TotalDeduction.ToString());
                    form16table = form16table.Replace("[XXXXGrossEarn5XXXXXXXX]", row.GrossEarn5.ToString());
                    form16table = form16table.Replace("[XXXXOtherIncomeXXXXXXXX]", row.OtherIncome.ToString());
                    form16table = form16table.Replace("[XXXXIntHouseLoanXXXXXXXX]", row.IntHouseLoan.ToString());
                    form16table = form16table.Replace("[XXXXGrossEarn8XXXXXXXX]", row.GrossEarn8.ToString());

                    string Section80C = "";
                    foreach (var rebate in tblRebate.Where(x => x.Employee_ID == row.Employee_ID).ToList())
                    {
                        Section80C += "<tr>";
                        Section80C += "<td class='bottomborder rightborder'>";
                        Section80C += rebate.Head_Name;
                        Section80C += "</td>";
                        Section80C += "<td class='bottomborder makeright'>";
                        Section80C += rebate.Amount;
                        Section80C += "</td>";
                        Section80C += "</tr>";
                    }

                    form16table = form16table.Replace("[XXXXXXXSection80CXXXXXXXX]", Section80C);

                    form16table = form16table.Replace("[XXXXsection80CCCXXXXXXXX]", row.Rebate80CCC.ToString());
                    form16table = form16table.Replace("[XXXXsection80CCDXXXXXXXX]", row.Rebate80CCD.ToString());
                    form16table = form16table.Replace("[XXXXsection80CCD2XXXXXXXX]", row.Rebate80CCD2.ToString());
                    form16table = form16table.Replace("[XXXXsection80CCD21BXXXXXXXX]", row.Rebate80CCD21B.ToString());
                    form16table = form16table.Replace("[XXXXXSection80CCGXXXXXXX]", row.Rebate80CCG.ToString());
                    form16table = form16table.Replace("[XXXXXSection80DXXXXXXX]", row.Rebate88D.ToString());
                    form16table = form16table.Replace("[XXXXXSection80DDXXXXXXX]", row.Rebate80DD.ToString());
                    form16table = form16table.Replace("[XXXXXSection80DDBXXXXXXX]", row.Rebate80DDB.ToString());
                    form16table = form16table.Replace("[XXXXXSection80EXXXXXXX]", row.Rebate80E.ToString());
                    form16table = form16table.Replace("[XXXXXSection80EEXXXXXXX]", row.Rebate80EE.ToString());
                    form16table = form16table.Replace("[XXXXXSection80GXXXXXXX]", row.Rebate80G.ToString());
                    form16table = form16table.Replace("[XXXXXSection80GGXXXXXXX]", row.Rebate80GG.ToString());
                    form16table = form16table.Replace("[XXXXXSection80GGAXXXXXXX]", row.Rebate80GGA.ToString());
                    form16table = form16table.Replace("[XXXXXSection80GGCXXXXXXX]", row.Rebate80GGC.ToString());
                    form16table = form16table.Replace("[XXXXXSection80QQBXXXXXXX]", row.Rebate80QQB.ToString());
                    form16table = form16table.Replace("[XXXXXSection80RRBXXXXXXX]", row.Rebate80RRB.ToString());
                    form16table = form16table.Replace("[XXXXXSection80UXXXXXXX]", row.Rebate80U.ToString());
                    form16table = form16table.Replace("[XXXXXSection80TTAXXXXXXX]", row.Rebate80TTA.ToString());

                    ////set all qulifiying amt
                    form16table = form16table.Replace("[XXXXXXXXXXXX]", "0");

                    form16table = form16table.Replace("[XXXXXTotalRebateXXXXXXX]", row.TotalRebate.ToString());

                    form16table = form16table.Replace("[XXXXXGrossnetXXXXXXX]", row.Grossnet.ToString());
                    ///12
                    if (row.Grossnet > 4999999)
                    { form16table = form16table.Replace("[XXXXXItax1XXXXXXX]", row.Itax2.ToString()); }
                    else
                    { form16table = form16table.Replace("[XXXXXItax1XXXXXXX]", ((row.Itax1 - row.Rebatetds) + row.Surcharge).ToString()); }
                    ///13
                    form16table = form16table.Replace("[XXXXXEducationCessandHighEduCessXXXXXXX]", (row.EducationCess + row.HighEduCess).ToString());
                    ///14
                    if (row.Grossnet > 4999999)
                    { form16table = form16table.Replace("[XXXXXItax2XXXXXXX]", (row.Itax2 + row.EducationCess + row.HighEduCess).ToString()); }
                    else
                    { form16table = form16table.Replace("[XXXXXItax2XXXXXXX]", (row.EducationCess + row.HighEduCess + (row.Itax1 - row.Rebatetds)).ToString()); }

                    ///15
                    form16table = form16table.Replace("[XXXXXrebate89XXXXXXX]", row.Rebate89.ToString());

                    ///16
                    form16table = form16table.Replace("[XXXXXChallanXXXXXXX]", (row.Challan_Tax).ToString());
                 
                    /////17.
                    form16table = form16table.Replace("[XXXXXPreTaxXXXXXXX]", (row.PreTds).ToString());

                    /////18
                    form16table = form16table.Replace("[XXXXXFinalXXXXXXX]", (row.FinalTax).ToString());

                    ///certification
                    form16table = form16table.Replace("[XXXXdesignation]", tblform16.Select(x => x.designation).FirstOrDefault().ToString());
                    form16table = form16table.Replace("[XXXXXXPlace]", tblform16.Select(x => x.location).FirstOrDefault().ToString());
                    form16table = form16table.Replace("[XXXPersoname]", tblform16.Select(x => x.personname).FirstOrDefault().ToString());
                    form16table = form16table.Replace("[XXXreleation]", tblform16.Select(x => x.releation).FirstOrDefault().ToString());
                    form16table = form16table.Replace("[XXXrelationname]", tblform16.Select(x => x.releationname).FirstOrDefault().ToString());
                    form16table = form16table.Replace("[XXXXCompanyName]", CompanyName);
                    form16table = form16table.Replace("[XXXXDate]", date);
                    BAL_ConvertCurrency ConCurrency = new BAL_ConvertCurrency();
                    form16table = form16table.Replace("[XXXXXamountinwords]", row.Challan_Tax.ToString() + " " + ConCurrency.RupeeInWords(Convert.ToDouble(row.Challan_Tax)));
                    mergedBody += form16table;

                    if (tblComputation.IndexOf(row) != tblComputation.Count - 1)
                        mergedBody += "<div style='width:100%; page-break-after:always;'></div><br><br>";
                }

                string GetHtmlBody = HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings["GetFrom16"].ToString());

                ///////get template body
                string templatebody = ReturnHTML(GetHtmlBody);
                templatebody = templatebody.Replace("[XXXXTAblbodyXXXXX]", mergedBody);
                ////write pdf
                WriteDocument("TdsComputationReport.pdf", "application/pdf", templatebody, "Inline");
                return "";
            }
            else { return "Error"; }
        }

        public string generateFrom16AA(string Empid, int Companyid, string fin_year, string date)
        {
            tbl_Employee_Master tblEmp = new tbl_Employee_Master();

            ///get company Details
            tblEmp.Company_ID = Companyid;
            List<tbl_Company_MAster> tblCompany = BAL_GetCompanyMaterDetails(tblEmp);

            //////get form16 settings
            List<tbl_Form16settings> tblform16 = BAL_BindForm16Settings(tblEmp);

            ///get Employee Details
            tblEmp.EmpName = Empid;
            List<tbl_TDS_Computation> tblComputation = BAL_GetEmployeeComputationDetails(tblEmp);

            ///get Employee Section 10 details
            List<tbl_Monthly_SAlary_For_Employee_Salary> tblSection10 = BAL_GetEmployeeSetion10Details(tblEmp);

            ///get Employee Rebate 80c Details
            List<tbl_Monthly_SAlary_For_Employee_Salary> tblRebate = BAL_GetEmployeeRebateDetails(tblEmp);

            ////////////delcarations and inistialize objects
            string CompanyName = "", CompanyAddress = "", AssesmentYear = "", Fromdate = "", Todate = "";
            string mergedBody = "", form16table = "";

            if (tblComputation.Count > 0)
            {
                AssesmentYear = "";

                string[] finyer = fin_year.Split('_');
                Fromdate = finyer[0];
                Todate = "20" + finyer[1];
                AssesmentYear = (Convert.ToInt32(Fromdate) + 1).ToString() + "-" + (Convert.ToInt32(Todate) + 1).ToString();

                /////////set Company Details
                CompanyName = tblCompany.Select(x => x.CompanyName).FirstOrDefault().ToString();

                if (!string.IsNullOrEmpty(tblCompany.Select(x => x.Flat_No).FirstOrDefault().ToString()))
                {
                    if (!string.IsNullOrEmpty(CompanyAddress))
                        CompanyAddress += ",<br>";

                    CompanyAddress += tblCompany.Select(x => x.Flat_No).FirstOrDefault().ToString();
                }



                if (!string.IsNullOrEmpty(tblCompany.Select(x => x.Name_Of_Building).FirstOrDefault().ToString()))
                {
                    if (!string.IsNullOrEmpty(CompanyAddress))
                        CompanyAddress += ",<br>";

                    CompanyAddress += tblCompany.Select(x => x.Name_Of_Building).FirstOrDefault().ToString();
                }



                if (!string.IsNullOrEmpty(tblCompany.Select(x => x.Street).FirstOrDefault().ToString()))
                {
                    if (!string.IsNullOrEmpty(CompanyAddress))
                        CompanyAddress += ",<br>";

                    CompanyAddress += tblCompany.Select(x => x.Street).FirstOrDefault().ToString();
                }



                if (!string.IsNullOrEmpty(tblCompany.Select(x => x.Area_Location).FirstOrDefault().ToString()))
                {
                    if (!string.IsNullOrEmpty(CompanyAddress))
                        CompanyAddress += ",<br>";

                    CompanyAddress += tblCompany.Select(x => x.Area_Location).FirstOrDefault().ToString();
                }



                {
                    if (!string.IsNullOrEmpty(tblCompany.Select(x => x.Town_City).FirstOrDefault().ToString()))
                        if (!string.IsNullOrEmpty(CompanyAddress))
                            CompanyAddress += ",<br>";

                    CompanyAddress += tblCompany.Select(x => x.Town_City).FirstOrDefault().ToString();
                }

                if (!string.IsNullOrEmpty(CompanyAddress))
                    CompanyAddress += ".";

                string getForm16 = HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings["GetFrom16Body"].ToString());

                getForm16 = ReturnHTML(getForm16);

                ///for form 16AA
                getForm16 = getForm16.Replace("FORM NO.16", "FORM NO.16AA");
                getForm16 = getForm16.Replace("[See rule 31(1)(a)]", "[ See third proviso to rule 12(1)(b) and rule 31(1)(a) ]");
                getForm16 = getForm16.Replace("PART B", "Certificate for tax deducted at source from income chargeable under the head");
                HtmlAgilityPack.HtmlDocument doc = new HtmlAgilityPack.HtmlDocument();
                doc.LoadHtml(getForm16);
                var abovetr = "<tr>";
                abovetr += "<td class='bottomborder makecenter  makebolder' colspan='2'>";
                abovetr += "\"Salaries\" - cum - Return of income";
                abovetr += "</td>";
                abovetr += "</tr>";
                abovetr += "<tr>";
                abovetr += "<td class='bottomborder' colspan='2'>";
                abovetr += "For an individual , resident in India , where -";
                abovetr += "<ol type='(a)'>";
                abovetr += "<li>his total income includes income chargeable to income-tax under the head \"Salaries\" </li>";
                abovetr += "<li>the income from salaries below allowing deductions under section 16 of the Income - tax Act, 1961 does not exceed rupeesone lakh fifty thousand</li>";
                abovetr += "<li>his total income does not include income chargeable to income - tax under the head \"Profits and gains of business\" or \"profession\" or \"Capital gains\" or agricultural income and</li>";
                abovetr += "<li>he is not in receipt of any other income from which tax has been deducted at source by any person other than the employer</li>";
                abovetr += "</ul>";
                abovetr += "</td>";
                abovetr += "</tr>";
                getForm16 = getForm16.Replace(doc.DocumentNode.SelectNodes("//*[@id='ForForm16AAChanges']")[0].OuterHtml, abovetr);

                foreach (var row in tblComputation)
                {
                    form16table = getForm16;

                    ///set employee details
                    form16table = form16table.Replace("[XNameandAddressoftheEmployerX]", CompanyName + "</br>" + CompanyAddress);
                    form16table = form16table.Replace("[XNameanddesignationoftheEmployeeX]", row.EmpName);
                    form16table = form16table.Replace("[XXPANNoofTheDeducteeXXXX]", tblCompany.Select(x => x.PANNo).FirstOrDefault().ToString().ToUpper());
                    form16table = form16table.Replace("[XXXTANNooftheDeducteeXXX]", tblCompany.Select(x => x.TANNo).FirstOrDefault().ToString().ToUpper());
                    form16table = form16table.Replace("[XXXPANNooftheEmployeeXXX]", row.PanNo.ToUpper());
                    form16table = form16table.Replace("[XXXAssessmentYearXXX]", AssesmentYear);
                    form16table = form16table.Replace("[XXXFromXXX]", "01/04/" + Fromdate);
                    form16table = form16table.Replace("[XXXToXXX]", "31/03/" + Todate);
                    ///computation details
                    form16table = form16table.Replace("[XXXXXTotal_EarningsXXXXXXX]", row.Total_Earnings.ToString());
                    form16table = form16table.Replace("[XXXXXGrossPerks_BXXXXXXX]", row.GrossPerks_B.ToString());
                    form16table = form16table.Replace("[XXXXXGrossProfits_CXXXXXXX]", row.GrossProfits_C.ToString());
                    form16table = form16table.Replace("[XXXXGrossEarn1XXXXXXXX]", row.GrossEarn1.ToString());


                    //////////////make table from section 10
                    string Section10Table = "";
                    foreach (var section10 in tblSection10.Where(x => x.Employee_ID == row.Employee_ID).ToList())
                    {
                        Section10Table += "<tr>";
                        Section10Table += "<td class='bottomborder rightborder'>";
                        Section10Table += section10.Head_Name;
                        Section10Table += "</td>";
                        Section10Table += "<td class='bottomborder makeright'>";
                        Section10Table += section10.Amount;
                        Section10Table += "</td>";
                        Section10Table += "</tr>";
                    }
                    form16table = form16table.Replace("[XXXXXSection_10XXXXX]", row.Section_10.ToString());
                    form16table = form16table.Replace("[XXXXXXXSection10HeadsXXXXXXXX]", Section10Table);
                    form16table = form16table.Replace("[XXXXGrossEarn3XXXXXXXX]", row.GrossEarn3.ToString());

                    form16table = form16table.Replace("[XXXXSTDedXXXXXXXX]", row.StandardDeductions.ToString());
     
                    form16table = form16table.Replace("[XXXXEntertainmentXXXXXXXX]", row.Entertainment.ToString());
                    form16table = form16table.Replace("[XXXXPTaxXXXXXXXX]", row.PTax.ToString());
                    form16table = form16table.Replace("[XXXXTotalDeductionXXXXXXXX]", row.TotalDeduction.ToString());
                    form16table = form16table.Replace("[XXXXGrossEarn5XXXXXXXX]", row.GrossEarn5.ToString());
                    form16table = form16table.Replace("[XXXXOtherIncomeXXXXXXXX]", row.OtherIncome.ToString());
                    form16table = form16table.Replace("[XXXXIntHouseLoanXXXXXXXX]", row.IntHouseLoan.ToString());
                    form16table = form16table.Replace("[XXXXGrossEarn8XXXXXXXX]", row.GrossEarn8.ToString());

                    string Section80C = "";
                    foreach (var rebate in tblRebate.Where(x => x.Employee_ID == row.Employee_ID).ToList())
                    {
                        Section80C += "<tr>";
                        Section80C += "<td class='bottomborder rightborder'>";
                        Section80C += rebate.Head_Name;
                        Section80C += "</td>";
                        Section80C += "<td class='bottomborder makeright'>";
                        Section80C += rebate.Amount;
                        Section80C += "</td>";
                        Section80C += "</tr>";
                    }
                    form16table = form16table.Replace("[XXXXXXXSection80CXXXXXXXX]", Section80C);
                                                       
                    form16table = form16table.Replace("[XXXXsection80CCCXXXXXXXX]", row.Rebate80C.ToString());
                    form16table = form16table.Replace("[XXXXsection80CCCXXXXXXXX]", row.Rebate80CCC.ToString());
                    form16table = form16table.Replace("[XXXXsection80CCDXXXXXXXX]", row.Rebate80CCD.ToString());
                    form16table = form16table.Replace("[XXXXsection80CCD2XXXXXXXX]", row.Rebate80CCD2.ToString());
                    form16table = form16table.Replace("[XXXXsection80CCD21BXXXXXXXX]", row.Rebate80CCD21B.ToString());
                    form16table = form16table.Replace("[XXXXXSection80CCGXXXXXXX]", row.Rebate80CCG.ToString());
                    form16table = form16table.Replace("[XXXXXSection80DXXXXXXX]", row.Rebate88D.ToString());
                    form16table = form16table.Replace("[XXXXXSection80DDXXXXXXX]", row.Rebate80DD.ToString());
                    form16table = form16table.Replace("[XXXXXSection80DDBXXXXXXX]", row.Rebate80DDB.ToString());
                    form16table = form16table.Replace("[XXXXXSection80EXXXXXXX]", row.Rebate80E.ToString());
                    form16table = form16table.Replace("[XXXXXSection80EEXXXXXXX]", row.Rebate80EE.ToString());
                    form16table = form16table.Replace("[XXXXXSection80GXXXXXXX]", row.Rebate80G.ToString());
                    form16table = form16table.Replace("[XXXXXSection80GGXXXXXXX]", row.Rebate80GG.ToString());
                    form16table = form16table.Replace("[XXXXXSection80GGAXXXXXXX]", row.Rebate80GGA.ToString());
                    form16table = form16table.Replace("[XXXXXSection80GGCXXXXXXX]", row.Rebate80GGC.ToString());
                    form16table = form16table.Replace("[XXXXXSection80QQBXXXXXXX]", row.Rebate80QQB.ToString());
                    form16table = form16table.Replace("[XXXXXSection80RRBXXXXXXX]", row.Rebate80RRB.ToString());
                    form16table = form16table.Replace("[XXXXXSection80UXXXXXXX]", row.Rebate80U.ToString());
                    form16table = form16table.Replace("[XXXXXSection80TTAXXXXXXX]", row.Rebate80TTA.ToString());

                    ////set all qulifiying amt
                    form16table = form16table.Replace("[XXXXXXXXXXXX]", "0");

                    form16table = form16table.Replace("[XXXXXTotalRebateXXXXXXX]", row.TotalRebate.ToString());

                    form16table = form16table.Replace("[XXXXXGrossnetXXXXXXX]", row.Grossnet.ToString());
                    ///12
                    if (row.Grossnet >= 10000000)
                    { form16table = form16table.Replace("[XXXXXItax1XXXXXXX]", row.Itax2.ToString()); }
                    else
                    { form16table = form16table.Replace("[XXXXXItax1XXXXXXX]", ((row.Itax1 - row.Rebatetds) + row.Surcharge).ToString()); }
                    ///13
                    form16table = form16table.Replace("[XXXXXEducationCessandHighEduCessXXXXXXX]", (row.EducationCess + row.HighEduCess).ToString());
                    ///14
                    if (row.Grossnet >= 10000000)
                    { form16table = form16table.Replace("[XXXXXItax2XXXXXXX]", (row.Itax2 + row.EducationCess + row.HighEduCess).ToString()); }
                    else
                    { form16table = form16table.Replace("[XXXXXItax2XXXXXXX]", (row.EducationCess + row.HighEduCess + (row.Itax1 - row.Rebatetds)).ToString()); }

                    ///15
                    form16table = form16table.Replace("[XXXXXrebate89XXXXXXX]", row.Rebate89.ToString());
                    ///16
                    if (row.Grossnet >= 10000000)
                    { form16table = form16table.Replace("[XXXXXitax2andrebate89XXXXXXX]", ((row.EducationCess + row.HighEduCess + row.Itax2) - row.Rebate89).ToString()); }
                    else
                    { form16table = form16table.Replace("[XXXXXitax2andrebate89XXXXXXX]", ((row.EducationCess + row.HighEduCess + (row.Itax1 - row.Rebatetds)) - row.Rebate89).ToString()); }


                    ///certification
                    form16table = form16table.Replace("[XXXXdesignation]", tblform16.Select(x => x.designation).FirstOrDefault().ToString());
                    form16table = form16table.Replace("[XXXXXXPlace]", tblform16.Select(x => x.location).FirstOrDefault().ToString());
                    form16table = form16table.Replace("[XXXPersoname]", tblform16.Select(x => x.personname).FirstOrDefault().ToString());
                    form16table = form16table.Replace("[XXXreleation]", tblform16.Select(x => x.releation).FirstOrDefault().ToString());
                    form16table = form16table.Replace("[XXXrelationname]", tblform16.Select(x => x.releationname).FirstOrDefault().ToString());
                    form16table = form16table.Replace("[XXXXCompanyName]", CompanyName);
                    form16table = form16table.Replace("[XXXXDate]", date);
                    BAL_ConvertCurrency ConCurrency = new BAL_ConvertCurrency();
                    form16table = form16table.Replace("[XXXXXamountinwords]", row.Challan_Tax.ToString() + " " + ConCurrency.RupeeInWords(Convert.ToDouble(row.Challan_Tax)));
                    mergedBody += form16table;

                    if (tblComputation.IndexOf(row) != tblComputation.Count - 1)
                        mergedBody += "<div style='width:100%; page-break-after:always;'></div><br><br>";
                }

                string GetHtmlBody = HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings["GetFrom16"].ToString());

                ///////get template body
                string templatebody = ReturnHTML(GetHtmlBody);
                templatebody = templatebody.Replace("[XXXXTAblbodyXXXXX]", mergedBody);
                ////write pdf
                WriteDocument("Form16AA.pdf", "application/pdf", templatebody, "Inline");
                return "";
            }
            else { return "Error"; }
        }

        public List<tbl_Company_MAster> BAL_GetCompanyMaterDetails(tbl_Employee_Master obj)
        {
            List<tbl_Company_MAster> tbl = new List<tbl_Company_MAster>();
            using (SqlDataReader drrr = objDAL_ReportForm16.DAL_GetCompanyMaterDetails(obj))
            {
                while (drrr.Read())
                {
                    tbl.Add(new tbl_Company_MAster()
                    {
                        CompanyName = GetValue<string>(drrr["CompanyName"].ToString()),
                        Flat_No = GetValue<string>(drrr["Flat_No"].ToString()),
                        Name_Of_Building = GetValue<string>(drrr["Name_Of_Building"].ToString()),
                        Street = GetValue<string>(drrr["Street"].ToString()),
                        Area_Location = GetValue<string>(drrr["Area_Location"].ToString()),
                        Town_City = GetValue<string>(drrr["Town_City"].ToString()),
                        CompanyLogoName = GetValue<string>(drrr["CompanyLogoName"].ToString()),
                        TANNo = GetValue<string>(drrr["TANNo"].ToString()),
                        PANNo = GetValue<string>(drrr["PANNo"].ToString())
                    });
                }
            }
            return tbl;
        }

        public List<tbl_Computationdetaion_Report> BAL_GetHeadDetails(tbl_Employee_Master obj)
        {
            List<tbl_Computationdetaion_Report> tbls = new List<tbl_Computationdetaion_Report>();
            using (SqlDataReader drrr = objDAL_ReportForm16.DAL_GetHeadDetails(obj))
            {
                while (drrr.Read())
                {
                    tbls.Add(new tbl_Computationdetaion_Report()
                    {
                        Employee_ID = GetValue<int>(drrr["Employee_ID"].ToString()),
                        HeadName = GetValue<string>(drrr["Head_Name"].ToString()),
                        Amt = GetValue<double>(drrr["amt"].ToString()),
                    });
                }
                return tbls;
            }       
        }

        public List<tbl_HeadName_Report> BAL_GetHeadtwoDetails(tbl_Employee_Master obj)
        {
            List<tbl_HeadName_Report> tbls = new List<tbl_HeadName_Report>();
            using (SqlDataReader drrr = objDAL_ReportForm16.DAL_GetHeadtwoDetails(obj))
            {
                while (drrr.Read())
                {
                    tbls.Add(new tbl_HeadName_Report()
                    {
                        Employee_ID = GetValue<int>(drrr["Employee_ID"].ToString()),
                        HeadName = GetValue<string>(drrr["Head_Name"].ToString()),
                        Amt = GetValue<double>(drrr["amt"].ToString()),
                    });
                }
                return tbls;
            }
        }

        public List<tbl_salary_structure> BAL_BindOnPageLoad(tbl_Employee_Master obj)
        {
            try
            {
                using (SqlDataReader drrr = objDAL_ReportForm16.DAL_BindOnPageLoad(obj))
                {
                    while (drrr.Read())
                    {
                        tblEmp.Add(new tbl_salary_structure()
                        {
                            Employee_ID = GetValue<int>(drrr["id"].ToString()),
                            FirstName = GetValue<string>(drrr["Name"].ToString()),
                            Grade_Name = GetValue<string>(drrr["Selection"].ToString())
                        });
                    }
                }
                return tblEmp;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<tbl_Form16settings> BAL_BindForm16Settings(tbl_Employee_Master obj)
        {
            List<tbl_Form16settings> tbl = new List<tbl_Form16settings>();
            using (SqlDataReader drrr = objDAL_ReportForm16.DAL_BindForm16Settings(obj))
            {
                while (drrr.Read())
                {
                    tbl.Add(new tbl_Form16settings()
                    {
                        designation = GetValue<string>(drrr["designation"].ToString()),
                        location = GetValue<string>(drrr["location"].ToString()),
                        personname = GetValue<string>(drrr["personname"].ToString()),
                        releation = GetValue<string>(drrr["releation"].ToString()),
                        releationname = GetValue<string>(drrr["releationname"].ToString()),
                    });
                }
            }
            return tbl;
        }

        public int BAL_SaveFrom16Settings(tbl_Form16settings tbl16)
        {
            return objDAL_ReportForm16.DAL_SaveFrom16Settings(tbl16);
        }
    }


}
