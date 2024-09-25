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
using System.Data; 

namespace BusinessLayer
{
   public class BAL_Report_Form16A : CommonFunctions
    {
        DAL_VoucherEntries_Master objDAL_Vouchers = new DAL_VoucherEntries_Master();
        DAL_Report_Form16A objDAL_ReportForm16 = new DAL_Report_Form16A();

        public int _Company_ID { get; set; }
        public DateTime? fromDT { get; set; }
        public DateTime? toDT { get; set; }

       
       public List<tbl_Company_MAster> BAL_GetCompanyMaterDetails(tbl_Company_MAster obj)
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


        public List<tbl_Voucher> BAL_GetVoucherEntries(tbl_Voucher obj)
        {
            List<tbl_Voucher> tbl = new List<tbl_Voucher>();

            using (SqlDataReader drrr = objDAL_ReportForm16.DAL_GetVouchers(obj))
            {
                while (drrr.Read())
                {
                    tbl.Add(new tbl_Voucher()
                    {

                        Voucher_Amount = GetValue<float>(drrr["AmountPaid"].ToString()),
                        Nature_Name = GetValue<string>(drrr["Nature_Name"].ToString()),
                        V_DT = GetValue<string>(drrr["Voucher_DT"].ToString()),
                        PAN_NO = GetValue<string>(drrr["PAN_NO"].ToString()),
                        Deductee_Name = GetValue<string>(drrr["Deductee_Name"].ToString()),
                    });
                }
            }
            return tbl;
        }


        public List<tbl_Challan_Non_Salary> BAL_GetChallanEntries(tbl_Challan_Non_Salary obj)
        {
            List<tbl_Challan_Non_Salary> tbl = new List<tbl_Challan_Non_Salary>();

            using (SqlDataReader drrr = objDAL_ReportForm16.Get_Form16AChallan_Details(obj))
            {
                while (drrr.Read())
                {
                    tbl.Add(new tbl_Challan_Non_Salary()
                    {
                        Srno = GetValue<int>(drrr["Srno"].ToString()),
                        Total_Tax_Amt = GetValue<float>(drrr["Total_Tax_Amt"].ToString()),
                        Bank_Bsrcode = GetValue<string>(drrr["Bank_Bsrcode"].ToString()),
                        C_Date = GetValue<string>(drrr["Challan_Date"].ToString()),
                        Challan_No = GetValue<string>(drrr["Challan_No"].ToString()),
                        Total_DTax = GetValue<float>(drrr["tax_amt"].ToString()),
                        Quater = GetValue<string>(drrr["Quater"].ToString()),
                    });
                }
            }
            return tbl;
        }

        public string generatNonForm16A(string Deducteeid, int Companyid, string Quarter, string fin_year, string date, int Nature_id, string a, string d, string p, string r, string dt)
        {
            tbl_Deductee_Master tblded = new tbl_Deductee_Master();
            tbl_Voucher tblVou = new tbl_Voucher();
            tbl_Company_MAster tblC = new tbl_Company_MAster();
            tbl_Challan_Non_Salary tblChl = new tbl_Challan_Non_Salary();
            ///get company Details
            tblC.Company_ID = Companyid;
            List<tbl_Company_MAster> tblCompany = BAL_GetCompanyMaterDetails(tblC);
            tblVou.Company_ID = Companyid;
            tblVou.Deductee_ID = Convert.ToInt64(Deducteeid);
            tblVou.Quarter = Quarter;
            tblVou.Nature_ID = Nature_id;
            ////////get form16 settings
            //List<tbl_Form16settings> tblform16 = BAL_BindForm16Settings(tblEmp);
            tblChl.Company_ID = Companyid;
            tblChl.Deductee_ID = Convert.ToInt64(Deducteeid);
            tblChl.Quater = Quarter;
            tblChl.Nature_ID = Nature_id;
            ///get Details
            tblded.dedName = Deducteeid;
            List<tbl_Voucher> tblV = BAL_GetVoucherEntries(tblVou);

            ///get Employee Section 10 details
            List<tbl_Challan_Non_Salary> tblCh = BAL_GetChallanEntries(tblChl);

            string CompanyName = "", CompanyAddress = "", AssesmentYear = "", Fromdate = "", Todate = "";
            string mergedBody = "", form16table = "";

            if (tblCompany.Count > 0)
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

                string getForm16 = HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings["GetFrom16ABody"].ToString());

                getForm16 = ReturnHTML(getForm16);

                //    form16table = getForm16;
                //foreach (var row in tblV)
                //{
                string Pan = "";
                string dname = "";
                string d_tax = "";
                string Q = "";

                    form16table = getForm16;
                    //////////////make table from section 10
                    string VoucherTable = "";
                    foreach (var Voucher in tblV)
                    {
                        VoucherTable += "<tr>";
                        VoucherTable += "<td class='bottomborder rightborder'>";
                        VoucherTable += Voucher.Voucher_Amount ;
                        VoucherTable += "</td>";
                        VoucherTable += "<td class='bottomborder rightborder'>";
                        VoucherTable += Voucher.Nature_Name ;
                        VoucherTable += "</td>";
                        VoucherTable += "<td class='bottomborder rightborder'>";
                        VoucherTable += Voucher.V_DT;
                        VoucherTable += "</td>";
                        VoucherTable += "</tr>";
                        dname = Voucher.Deductee_Name;
                        Pan = Voucher.PAN_NO;
                    }
//                    form16table = form16table.Replace("[XXXXXSection_10XXXXX]", row.Voucher.ToString());
                    form16table = form16table.Replace("[XXXXXXXSummaryPaymentXXXXXXXX]", VoucherTable);

                    string Challantbl = "";
                    foreach (var Chln in tblCh)
                    {
                        Challantbl += "<tr>";
                        Challantbl += "<td class='bottomborder rightborder'>";
                        Challantbl += Chln.Srno;
                        Challantbl += "</td>";
                        Challantbl += "<td class='bottomborder rightborder'>";
                        Challantbl += Chln.Total_Tax_Amt;
                        Challantbl += "</td>";
                        Challantbl += "<td class='bottomborder rightborder'>";
                        Challantbl += Chln.Bank_Bsrcode ;
                        Challantbl += "</td>";
                        Challantbl += "<td class='bottomborder rightborder'>";
                        Challantbl += Chln.C_Date ;
                        Challantbl += "</td>";
                        Challantbl += "<td class='bottomborder rightborder'>";
                        Challantbl += Chln.Challan_No;
                        Challantbl += "</td>";
                        Challantbl += "</tr>";

                        d_tax = Chln.Total_DTax.ToString() ;
                        Q = Chln.Quater.ToString(); 
                    }
                    form16table = form16table.Replace("[XXXXXXXTaxDetailsXXXXXXXX]", Challantbl);
                    string ChallanTotal = "";

                        ChallanTotal += "<td class='bottomborder rightborder'>";
                        ChallanTotal += Q;
                        ChallanTotal += "</td>";
                        ChallanTotal += "<td class='bottomborder rightborder'>";
                        ChallanTotal += "";
                        ChallanTotal += "</td>";
                        ChallanTotal += "<td class='bottomborder rightborder'>";
                        ChallanTotal += "";
                        ChallanTotal += "</td>";
                        ChallanTotal += "<td class='bottomborder rightborder'>";
                        ChallanTotal += d_tax;
                        ChallanTotal += "</td>";
                        ChallanTotal += "</tr>";
                        form16table = form16table.Replace("[XXXXXXXSummaryTaxXXXXXXXX]", ChallanTotal);
                    ///set employee details
                    form16table = form16table.Replace("[XNameandAddressoftheDeductorX]", CompanyName + "</br>" + CompanyAddress);
                    form16table = form16table.Replace("[XNameanddesignationoftheDeducteeX]", dname);
                    form16table = form16table.Replace("[XXPANNoofTheDeducteeXXXX]", tblCompany.Select(x => x.PANNo).FirstOrDefault().ToString().ToUpper());
                    form16table = form16table.Replace("[XXXTANNooftheDeducteeXXX]", tblCompany.Select(x => x.TANNo).FirstOrDefault().ToString().ToUpper());
                    form16table = form16table.Replace("[XXXPANNooftheDeducteeXXX]", Pan.ToUpper());
                    form16table = form16table.Replace("[XXXAssessmentYearXXX]", AssesmentYear);
                    form16table = form16table.Replace("[XXXFromXXX]", "01/04/" + Fromdate);
                    form16table = form16table.Replace("[XXXToXXX]", "31/03/" + Todate);
                    form16table = form16table.Replace("[XXXPersoname]", a);
                    form16table = form16table.Replace("[XXXXdesignation]", d);
                    form16table = form16table.Replace("[XXXXXXPlace]",  p);
                    form16table = form16table.Replace("[XXXXCompanyName]", CompanyName);
                    form16table = form16table.Replace("[XXXXDate]", dt);
                    form16table = form16table.Replace("[XXXreleation]", r);
                    BAL_ConvertCurrency ConCurrency = new BAL_ConvertCurrency();
                    form16table = form16table.Replace("[XXXXXamountinwords]", ConCurrency.RupeeInWords(Convert.ToDouble(d_tax)));
                    /////certification
                    //form16table = form16table.Replace("[XXXXdesignation]", tblform16.Select(x => x.designation).FirstOrDefault().ToString());
                    //form16table = form16table.Replace("[XXXXXXPlace]", tblform16.Select(x => x.location).FirstOrDefault().ToString());
                    //form16table = form16table.Replace("[XXXPersoname]", tblform16.Select(x => x.personname).FirstOrDefault().ToString());
                    //form16table = form16table.Replace("[XXXreleation]", tblform16.Select(x => x.releation).FirstOrDefault().ToString());
                    //form16table = form16table.Replace("[XXXrelationname]", tblform16.Select(x => x.releationname).FirstOrDefault().ToString());
                    //form16table = form16table.Replace("[XXXXCompanyName]", CompanyName);
                    //form16table = form16table.Replace("[XXXXDate]", date);
                    //BAL_ConvertCurrency ConCurrency = new BAL_ConvertCurrency();
                    //form16table = form16table.Replace("[XXXXXamountinwords]", row.Challan_Tax.ToString() + " " + ConCurrency.RupeeInWords(Convert.ToDouble(row.Challan_Tax)));
                   
                 mergedBody += form16table;

                    //if (tblV.IndexOf(row) != tblV.Count - 1)
                 mergedBody += "<div style='width:100%; page-break-after:always;'></div><br><br>";
                //}

                string GetHtmlBody = HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings["GetFrom16"].ToString());

                ///////get template body
                string templatebody = ReturnHTML(GetHtmlBody);
                templatebody = templatebody.Replace("[XXXXTAblbodyXXXXX]", mergedBody);
                ////write pdf
                WriteDocument("Form16A.pdf", "application/pdf", templatebody, "Inline");
                return "";
            }
               
            else { return "Error"; }
        }


        public DataSet Get_Natures(tbl_Company_MAster obj)
        {
            DataSet ds = new DataSet();
            try
            {
                ds = objDAL_ReportForm16.DAL_GetNautre(obj);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return ds;
        }

        public DataSet Get_Partyname(tbl_Voucher obj)
        {
            DataSet ds = new DataSet();
            try
            {
                ds = objDAL_ReportForm16.DAL_GetParty(obj);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return ds;
        }

    }
}
