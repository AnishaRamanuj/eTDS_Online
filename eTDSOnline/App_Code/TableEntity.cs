using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;
using System.IO;
using System.Web;
using NReco.PdfGenerator;
using System.Data;
using System.Reflection;

namespace CommonLibrary
{
    /// <summary>
    /// class declaations
    /// </summary>
    public class TableEntity
    {

    }
    public class CommonFunctions
    {
        /// <summary>
        /// tryparse used like function
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="str"></param>
        /// <param name="value"></param>
        /// <returns></returns>
        delegate bool TryParse<T>(string str, out T value);
        /// <summary>
        /// sql reader handler for null values
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="value"></param>
        /// <returns></returns>
        public T GetValue<T>(object value)
        {
            if ((value == null || (string)value == "") && typeof(T).Name.ToLower() != "datetime")
            {
                value = 0;
                if (typeof(T).Name == "String")
                { value = ""; }
            }


            if (typeof(T).Name == "DateTime" && (string)value == "")
            {
                value = default(DateTime);
            }
            var ret_Val = (T)Convert.ChangeType(value, typeof(T));
            return ret_Val;
        }

        public void LogError(Exception ex)
        {
            string message = string.Format("Time: {0}", DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
            message += Environment.NewLine;
            message += "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------";
            message += (Environment.NewLine);
            StackFrame Frame = new StackFrame(1, true);
            message += string.Format("Method Name: {0}", Frame.GetMethod());
            message += Environment.NewLine;
            message += string.Format("Filename: {0}", Frame.GetFileName());
            message += Environment.NewLine;
            message += string.Format("Line: {0}", Frame.GetFileLineNumber());
            message += Environment.NewLine;
            message += string.Format("Column: {0}", Frame.GetFileColumnNumber());
            message += Environment.NewLine;
            message += string.Format("Message: {0}", ex.Message);
            message += Environment.NewLine;
            message += string.Format("StackTrace: {0}", ex.StackTrace);
            message += Environment.NewLine;
            message += string.Format("Source: {0}", ex.Source);
            message += Environment.NewLine;
            message += string.Format("TargetSite: {0}", ex.TargetSite.ToString());
            message += Environment.NewLine;

            ///////////if inner exception found
            Exception innerEx = ex.InnerException;
            while (innerEx != null)
            {
                message += "-----------------inner Exception----------------------------------------------------------------------------------------------------------------------------------------------------------------";
                message += (Environment.NewLine);
                message += (Environment.NewLine);
                message += ("Exception Type : " + innerEx.GetType().Name);
                message += (Environment.NewLine);
                message += ("Error Message : " + innerEx.Message);
                message += (Environment.NewLine);
                message += ("Error Source : " + innerEx.Source);
                message += (Environment.NewLine);
                if (ex.StackTrace != null)
                {
                    message += ("Error Trace : " + innerEx.StackTrace);
                    message += (Environment.NewLine);
                }
                innerEx = innerEx.InnerException;
            }



            message += "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------";
            message += Environment.NewLine;
            message += Environment.NewLine;
            message += Environment.NewLine;

            var appDomain = System.AppDomain.CurrentDomain;

            string path = appDomain.BaseDirectory + "ErrorLogs";
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }

            string ErrorFilename = path + "\\ErrorLogs" + DateTime.Now.ToString("ddMMyyyy") + ".txt";
            if (!File.Exists(ErrorFilename))
            {
                FileStream fs = null;
                fs = File.Create(ErrorFilename);
                fs.Close();
            }

            using (StreamWriter writer = new StreamWriter(ErrorFilename, true))
            {
                writer.WriteLine(message);
                writer.Close();
            }
        }

        public void LogError(Exception ex, string CompanyID)
        {
            string message = string.Format("Time: {0}", DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
            message += Environment.NewLine;
            message += "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------";
            message += (Environment.NewLine);
            StackFrame Frame = new StackFrame(1, true);
            message += string.Format("Company ID: {0}", CompanyID);
            message += Environment.NewLine;
            message += string.Format("Method Name: {0}", Frame.GetMethod());
            message += Environment.NewLine;
            message += string.Format("Filename: {0}", Frame.GetFileName());
            message += Environment.NewLine;
            message += string.Format("Line: {0}", Frame.GetFileLineNumber());
            message += Environment.NewLine;
            message += string.Format("Column: {0}", Frame.GetFileColumnNumber());
            message += Environment.NewLine;
            message += string.Format("Message: {0}", ex.Message);
            message += Environment.NewLine;
            message += string.Format("StackTrace: {0}", ex.StackTrace);
            message += Environment.NewLine;
            message += string.Format("Source: {0}", ex.Source);
            message += Environment.NewLine;
            message += string.Format("TargetSite: {0}", ex.TargetSite.ToString());
            message += Environment.NewLine;

            ///////////if inner exception found
            Exception innerEx = ex.InnerException;
            while (innerEx != null)
            {
                message += "-----------------inner Exception----------------------------------------------------------------------------------------------------------------------------------------------------------------";
                message += (Environment.NewLine);
                message += (Environment.NewLine);
                message += ("Exception Type : " + innerEx.GetType().Name);
                message += (Environment.NewLine);
                message += ("Error Message : " + innerEx.Message);
                message += (Environment.NewLine);
                message += ("Error Source : " + innerEx.Source);
                message += (Environment.NewLine);
                if (ex.StackTrace != null)
                {
                    message += ("Error Trace : " + innerEx.StackTrace);
                    message += (Environment.NewLine);
                }
                innerEx = innerEx.InnerException;
            }



            message += "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------";
            message += Environment.NewLine;
            message += Environment.NewLine;
            message += Environment.NewLine;

            var appDomain = System.AppDomain.CurrentDomain;

            string path = appDomain.BaseDirectory + "ErrorLogs";
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }

            string ErrorFilename = path + "\\ErrorLogs" + DateTime.Now.ToString("ddMMyyyy") + ".txt";
            if (!File.Exists(ErrorFilename))
            {
                FileStream fs = null;
                fs = File.Create(ErrorFilename);
                fs.Close();
            }

            using (StreamWriter writer = new StreamWriter(ErrorFilename, true))
            {
                writer.WriteLine(message);
                writer.Close();
            }
        }
        /// <summary>
        /// Convert Html Convert html string to pdf content in byte[] using nerco 
        /// </summary>
        /// <param name="html">html page source code</param>
        /// <returns></returns>
        /// 
        public byte[] ConvertHtmlToPDF_Landscape(string html)
        {
            HtmlToPdfConverter nRecohtmltoPdfObj = new HtmlToPdfConverter();
            nRecohtmltoPdfObj.Orientation = PageOrientation.Landscape;
            nRecohtmltoPdfObj.PageFooterHtml = CreatePDFFooter();
            //nRecohtmltoPdfObj.CustomWkHtmlArgs = "--margin-top 8 --header-spacing 8 --margin-left 8 --margin-right 8";
            nRecohtmltoPdfObj.Margins = new PageMargins { Top = 8, Right = 8, Bottom = 8, Left = 8 };
            return nRecohtmltoPdfObj.GeneratePdf(CreatePDFScript() + html + "</body></html>");
        }

        public byte[] ConvertHtmlToPDF(string html)
        {
            HtmlToPdfConverter nRecohtmltoPdfObj = new HtmlToPdfConverter();
            nRecohtmltoPdfObj.Orientation = PageOrientation.Portrait;
            nRecohtmltoPdfObj.PageFooterHtml = CreatePDFFooter();
            //nRecohtmltoPdfObj.CustomWkHtmlArgs = "--margin-top 8 --header-spacing 8 --margin-left 8 --margin-right 8";
            nRecohtmltoPdfObj.Margins = new PageMargins { Top = 8, Right = 8, Bottom = 8, Left = 8 };
            return nRecohtmltoPdfObj.GeneratePdf(CreatePDFScript() + html + "</body></html>");
        }
        private string CreatePDFScript()
        {
            return "<html><head><style>td,th{line-height:20px;} tr { page-break-inside: avoid }</style><script>function subst() {var vars={};var x=document.location.search.substring(1).split('&');for(var i in x) {var z=x[i].split('=',2);vars[z[0]] = unescape(z[1]);}" +
            "var x=['frompage','topage','page','webpage','section','subsection','subsubsection'];for(var i in x) {var y = document.getElementsByClassName(x[i]);" +
            "for(var j=0; j<y.length; ++j) y[j].textContent = vars[x[i]];}}</script></head><body onload=\"subst()\">";
        }
        private string CreatePDFFooter()
        {
            return "<div style='text-align:right; line-height:20px; font-family:Tahoma; font-size:15px;'>Page <span class=\"page\"></span> of <span class=\"topage\"></span></div>";
        }
        /// <summary>
        ///Convert Html string into PDF Content with No cache.
        /// <para>Returns pdf format in Browser with open or download  </para></summary>
        /// <param name="fileName">Note:make sure extension eg. Form16.pdf </param>
        /// <param name="contentType">Conntet type like application type eg. aplication/pdf</param>
        /// <param name="content">Output content in response</param>
        /// <param name="responseType">eg. Inline or attachment</param>
        public void WriteDocument(string fileName, string contentType, string html, string responseType)
        {
            if (fileName == "Report_Deductee_PAN_Details.pdf")
            {
                byte[] content = ConvertHtmlToPDF_Landscape(html);
                responseType = responseType + "; filename=" + fileName;
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.ContentType = contentType;
                HttpContext.Current.Response.AddHeader("content-disposition", responseType);
                HttpContext.Current.Response.CacheControl = "No-cache";
                HttpContext.Current.Response.BinaryWrite(content);
                HttpContext.Current.Response.Flush();
                HttpContext.Current.Response.SuppressContent = true;
                HttpContext.Current.ApplicationInstance.CompleteRequest();
            }
            else
            {
                byte[] content = ConvertHtmlToPDF(html);

                responseType = responseType + "; filename=" + fileName;
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.ContentType = contentType;
                HttpContext.Current.Response.AddHeader("content-disposition", responseType);
                HttpContext.Current.Response.CacheControl = "No-cache";
                HttpContext.Current.Response.BinaryWrite(content);
                HttpContext.Current.Response.Flush();
                HttpContext.Current.Response.SuppressContent = true;
                HttpContext.Current.ApplicationInstance.CompleteRequest();
            }
        }
        public string ReturnHTML(string Path)
        {
            string strBody = "";
            try
            {
                StreamReader objReader = new StreamReader(Path);
                strBody = objReader.ReadToEnd();
                objReader.Close();
            }
            catch (Exception ex)
            {
                strBody = "";
                throw ex;
            }
            return strBody;
        }

        /// <summary>
        /// Convert List to Datatable
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="items"></param>
        /// <returns></returns>
        public static DataTable ToDataTable<T>(List<T> items)
        {
            DataTable dataTable = new DataTable(typeof(T).Name);

            //Get all the properties
            PropertyInfo[] Props = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);
            foreach (PropertyInfo prop in Props)
            {
                //Defining type of data column gives proper data table 
                var type = (prop.PropertyType.IsGenericType && prop.PropertyType.GetGenericTypeDefinition() == typeof(Nullable<>) ? Nullable.GetUnderlyingType(prop.PropertyType) : prop.PropertyType);
                //Setting column names as Property names
                dataTable.Columns.Add(prop.Name, type);
            }
            foreach (T item in items)
            {
                var values = new object[Props.Length];
                for (int i = 0; i < Props.Length; i++)
                {
                    //inserting property values to datatable rows
                    values[i] = Props[i].GetValue(item, null);
                }
                dataTable.Rows.Add(values);
            }
            //put a breakpoint here and check datatable
            return dataTable;
        }
    }
    public class tbl_salary_structure
    {
        public int SalaryStructure_ID { get; set; }

        public int? Company_ID { get; set; }

        public int? Employee_ID { get; set; }

        public int? Salary_Month { get; set; }

        public int? Head_ID { get; set; }

        public float? Salary_Amount { get; set; }

        public float? Percent_Val { get; set; }

        public string FirstName { get; set; }

        public int? Grade_ID { get; set; }

        public string Grade_Name { get; set; }

        public string Designation_Name { get; set; }

        public string Department_Name { get; set; }

        public string Head_Name { get; set; }

        public string Head_Group { get; set; }

        public string Calc_Gross { get; set; }

        public int? Head_Calculated_ID { get; set; }

        public string Amount { get; set; }

        public string CalcuatedHeadIDs { get; set; }

        public string slab { get; set; }

        public string Join_DT { get; set; }

        public string Mobile_No { get; set; }

        public string Is_Salary_Allocated { get; set; }

        public string PAN_NO { get; set; }

        public string PANVerified { get; set; }

        public int TotalCount { get; set; }

        public int RowNumber { get; set; }

        public string EmpName { get; set; }
    }
    public class tbl_TDS_Computation
    {
        public int? Employee_ID { get; set; }

        public int? Company_ID { get; set; }

        public string EmpName { get; set; }

        public string Designation_Name { get; set; }

        public string Department_Name { get; set; }

        public string Gender { get; set; }

        public string Senior_CTZN_Type { get; set; }

        public double? Surcharge { get; set; }

        public double? Total_Earnings { get; set; }

        public double? GrossPerks_B { get; set; }

        public double? GrossProfits_C { get; set; }

        public double? GrossTotal_D { get; set; }

        public double? GrossEarn1 { get; set; }

        public double? Section_10 { get; set; }

        public double? GrossEarn3 { get; set; }

        public double? PreSal { get; set; }

        public double? TotalDeduction { get; set; }

        public double? StandardDeductions { get; set; }

        public double? Entertainment { get; set; }

        public double? PTax { get; set; }

        public double? GrossEarn5 { get; set; }

        public double? IntHouseLoan { get; set; }

        public double? OtherIncome { get; set; }

        public double? GrossEarn8 { get; set; }

        public double? Rebate80C { get; set; }

        public double? PF { get; set; }

        public double? RebateBonds { get; set; }

        public double? Rebate80CCC { get; set; }

        public double? Rebate80CCD { get; set; }

        public double? Rebate80CCD2 { get; set; }

        public double? Rebate80CCD21B { get; set; }

        public double? Rebate80QlfySal { get; set; }

        public double? Rebate80NetSal { get; set; }

        public double? Rebate88D { get; set; }

        public double? Rebate80DD { get; set; }

        public double? Rebate80DDB { get; set; }

        public double? Rebate80QQB { get; set; }

        public double? Rebate80E { get; set; }

        public double? Rebate80EE { get; set; }

        public double? Rebate80G { get; set; }

        public double? Rebate80GG { get; set; }

        public double? Rebate80GGA { get; set; }

        public double? Rebate80GGC { get; set; }

        public double? Rebate80RRB { get; set; }

        public double? Rebate80U { get; set; }

        public double? Rebate80CCG { get; set; }

        public double? Rebate80TTA { get; set; }

        public double? TotalRebate { get; set; }

        public double? Grossnet { get; set; }

        public double? Itax1 { get; set; }

        public double? Rebatetds { get; set; }

        public double? EducationCess { get; set; }

        public double? HighEduCess { get; set; }

        public double? Itax2 { get; set; }

        public double? Rebate89 { get; set; }

        public double? Itax3 { get; set; }

        public double? Challan_Tax { get; set; }

        public double? PreTds { get; set; }

        public double? FinalTax { get; set; }

        public bool? Manual { get; set; }

        public string Rsinwords { get; set; }

        public int? sel { get; set; }

        public double? HRate { get; set; }

        public string PanNo { get; set; }

        public double? Rebate80CCD1B { get; set; }

    }
    public class tbl_Challan_Salary_Breakup
    {
        public int Challan_Breakup_ID { get; set; }

        public int? Challan_ID { get; set; }

        public int? Company_ID { get; set; }

        public int? Employee_ID { get; set; }

        public float? Employee_Salary { get; set; }

        public string Deduction_Type { get; set; }

        public string PAN_No { get; set; }

        public string Quater { get; set; }

        public float? TDS_Amount { get; set; }

        public float? Surcharge_Amount { get; set; }

        public float? EducationCess_Amount { get; set; }

        public float? High_EductionCess_Amount { get; set; }

        public float? Total_TDS_Amount { get; set; }

        public DateTime? Salary_Date { get; set; }

        public DateTime? Tds_Deduction_Date { get; set; }

        public bool? PAN_Verified { get; set; }

        public string RType { get; set; }

        public string CertNo { get; set; }


        public DateTime Challan_Date { get; set; }

        public string EmpName { get; set; }
    }

    public class tbl_Deductee_Master
    {
        public int Deductee_id { get; set; }

        public int Company_ID { get; set; }

        public string dedName { get; set; }

        public string DedAddress { get; set; }

        public string PAN_NO { get; set; }

    }

    public class tbl_Report_Challan
    {
        public int Natureid { get; set; }
        public string Section { get; set; }
        public string Nature_nature { get; set; }
        public int Compid { get; set; }
        public string Bank_Name { get; set; }
        public int Bank_id { get; set; }
    }
    public class Pan_No
    {
        public int Compid { get; set; }
        public string panno { get; set; }
        public string Gstn { get; set; }
    }

    public class Co_Admin
    {
        public int Compid { get; set; }
        public string UName { get; set; }
        public string Pass { get; set; }
        public string CPass { get; set; }
        public string email { get; set; }
        public string mobile { get; set; }
        public string Cperson { get; set; }
        public string UID { get; set; }

    }

    public class tbl_DeducteeList
    {
        public int compaid { get; set; }
        public string Dname { get; set; }
        public int deducteeid { get; set; }
        public string Form { get; set; }
    }
    public class ChallanDatenamt
    {

        public int Compid { get; set; }
        public string ChallanDetails { get; set; }
        public string quarter { get; set; }
        public string ConnectionString { get; set; }
        public string tobj { get; set; }
        public int ChallanID { get; set; }
        public string ischecked { get; set; }

    }

    public class PartyEmpName
    {

        public int Compid { get; set; }
        public string formno { get; set; }
        public string type { get; set; }
        public string ConnectionString { get; set; }
        public string tobj { get; set; }
        public int EmployeeID { get; set; }
        public string ischecked { get; set; }
        public string Deductee_Name { get; set; }
        public string PANNO { get; set; }
        public string FirstName { get; set; }
        public int DeducteeID { get; set; }


    }

    public class objChallanDetails
    {

        public int Compid { get; set; }
        public string quarter { get; set; }
        public string ConnectionString { get; set; }
        public int ChallanNo { get; set; }
        public string ChallanDate { get; set; }
        public int ChallanAmount { get; set; }
        public string ChallanDetails { get; set; }
        public int ChallanID { get; set; }
        public double CAmount { get; set; }
        public double CTotal { get; set; }
        public double Others { get; set; }
        public string BSR { get; set; }
        public string Sec { get; set; }
        public double? TDS { get; set; }
        public double? Sur { get; set; }
        public double? Cess { get; set; }
        public double? HCess { get; set; }
        public double? Interest { get; set; }
        public string Verify { get; set; }
        public string ndVrfy { get; set; }
        public string FormType { get; set; }
        public double? Diff { get; set; }
        public double? Vtds { get; set; }
        public double VouchersCount { get; set; }

    }

    public class objChallanDetails_27Q
    {

        public int Compid { get; set; }
        public string quarter { get; set; }
        public string ConnectionString { get; set; }

        public string ChallanDetails { get; set; }
        public int ChallanID { get; set; }
    }

    public class objChallanDetails_24Q
    {

        public int Compid { get; set; }
        public string quarter { get; set; }
        public string ConnectionString { get; set; }
        public string empname { get; set; }
        public int empid { get; set; }
        public string ChallanDetails { get; set; }
        public int ChallanID { get; set; }
    }
    public class objPartyEmpName
    {

        public int Compid { get; set; }
        public string formno { get; set; }
        public string type { get; set; }
        public string ConnectionString { get; set; }

    }
    public class objChallanDatenamt
    {

        public int Compid { get; set; }
        public string quarter { get; set; }
        public string ConnectionString { get; set; }

    }


    public class objbankconn
    {

        public string conn { get; set; }
        public string ConnectionString { get; set; }
        public int _Bank_ID { get; set; }
        public string _compid { get; set; }
        public string _dbname { get; set; }
        public int msg { get; set; }
    }
    public class tbl_HeadName
    {
        public string ConnectionString { get; set; }
        public int Compid { get; set; }
        public int Head_id { get; set; }
        public string Head_Name { get; set; }
        public string Multi { get; set; }
        public string Head_Section { get; set; }
        public int Head_Sec { get; set; }
    }

    public class tbl_DeductionStatment
    {
        public string CompanyName { get; set; }
        public string TdsStamnet { get; set; }
        public string Company { get; set; }
        public string OtherCompany { get; set; }
        public string Head { get; set; }
        public double Tds { get; set; }
        public double Surcharge { get; set; }
        public double Total { get; set; }
        public double OtherTDS { get; set; }
        public double OtherSur { get; set; }
        public double OtherEdu { get; set; }
        public double OtherTotal { get; set; }
        public double GrandTotal { get; set; }
        public int Companyid { get; set; }
        public string Qua { get; set; }
        public string Fdate { get; set; }
        public string Tdate { get; set; }
        public string CompanyID { get; set; }
        public string NName { get; set; }
        public double cTds { get; set; }
        public double csur { get; set; }
        public double ccess { get; set; }
        public double cTTax { get; set; }
        public double oTds { get; set; }
        public double oSur { get; set; }
        public double Ocess { get; set; }
        public double otax { get; set; }
        public double otds { get; set; }
        public string Nature_Name { get; set; }
    }


    public class tbl_CompanyDetail
    {
        public int Company_id { get; set; }
        public string Add1 { get; set; }
        public string Add2 { get; set; }
        public string TeleNo { get; set; }
        public string TAN { get; set; }
        public string PAN { get; set; }
    }
    public class tbl_Employee_Master
    {
        public int Employee_ID { get; set; }

        public int Company_ID { get; set; }

        public string EmpName { get; set; }

        public string Emp_Address { get; set; }

        public string City { get; set; }

        public int State_ID { get; set; }

        public string Gender { get; set; }

        public int Designation_ID { get; set; }

        public DateTime? Birth_DT { get; set; }

        public DateTime Join_DT { get; set; }

        public string FATHER_HUSBAND_NAME { get; set; }

        public string PF_NO { get; set; }

        public string PAN_NO { get; set; }

        public string Payment_Type { get; set; }

        public int Branch_ID { get; set; }

        public string Photo_path { get; set; }

        public DateTime? Resign_DT { get; set; }

        public string ESIC_NO { get; set; }

        public bool? Calc_ESIC { get; set; }

        public bool? CALC_PF { get; set; }

        public bool? CALC_PT { get; set; }

        public string Senior_CTZN_Type { get; set; }

        public string Reason_Of_Leaving { get; set; }

        public int Department_ID { get; set; }

        public long? Tel_NO { get; set; }

        public string Email_ID { get; set; }

        public string Bank_AC_NO { get; set; }

        public string Bank_Name { get; set; }

        public int? Category_ID { get; set; }

        public string Altcode { get; set; }

        public int? Shift_ID { get; set; }

        public DateTime? Probation_DT { get; set; }

        public DateTime? Confermation_DT { get; set; }

        public float? PF_Percentage { get; set; }

        public float? PF_Limit { get; set; }

        public int? Grade_ID { get; set; }

        public int? OT_ID { get; set; }

        public int? Weeklyoff_ID { get; set; }

        public bool? Handicapped { get; set; }

        public string Metro_Cities { get; set; }

        public int? Govt_DA { get; set; }

        public string Nominee { get; set; }

        public string BloodGrp { get; set; }

        public string Passport { get; set; }

        public string Visa_Info { get; set; }

        public string Emp_Password { get; set; }

        public bool? Wages { get; set; }

        public string Alais { get; set; }

        public string PF_MEM { get; set; }

        public decimal? Mobile_No { get; set; }

        public Guid UserID { get; set; }

        public string PANVerified { get; set; }

        public int? No_Of_Child { get; set; }

        public bool Is_Leave_Allocated { get; set; }

        public bool Is_Salary_Allocated { get; set; }

        public int? Logins { get; set; }

        public DateTime? Last_Login { get; set; }


        public int PageIndex { get; set; }

        public int PageSize { get; set; }

        public string Designation_Name { get; set; }

        public string Department_Name { get; set; }

        public string Branch_Name { get; set; }

        public int Head_ID { get; set; }

        public string Head_Group { get; set; }

        public string Head_Name { get; set; }

        public double Amount { get; set; }

        public string StringJoinDate { get; set; }

        public double Esic_ON_Heads { get; set; }

        public double EmployersContribution { get; set; }

        public double Total { get; set; }

        public Boolean IS_NRI { get; set; }

        public double Tds_Amt { get; set; }

        public double Voucher_Amt { get; set; }

        public string State_Name { get; set; }

        public int Nature_id { get; set; }

        public string Nature_Name { get; set; }

        public string Quater { get; set; }

        public string Section { get; set; }
    }

    public class tbl_Company_MAster
    {
        public int Company_ID { get; set; }

        public string CompanyName { get; set; }

        public string Flat_No { get; set; }

        public string Name_Of_Building { get; set; }

        public string Street { get; set; }

        public string Area_Location { get; set; }

        public string Town_City { get; set; }

        public string EmailID { get; set; }

        public string Status { get; set; }

        public string IClass { get; set; }

        public string Pincode { get; set; }

        public string STD_code { get; set; }

        public string Tel_NO { get; set; }

        public string Fax { get; set; }

        public string CUserName { get; set; }

        public string CPassword { get; set; }

        public string ContactPerson { get; set; }

        public Guid CreatedBy { get; set; }

        public DateTime? CreatedDate { get; set; }

        public Guid ModifiedBy { get; set; }

        public DateTime? ModifiedDate { get; set; }

        public bool? IsDemoVersion { get; set; }

        public int? DemoDays { get; set; }

        public DateTime? DemoStartDate { get; set; }

        public string TANNo { get; set; }

        public string PANNo { get; set; }

        public string Place { get; set; }

        public string Alt_EmailID { get; set; }

        public string Alt_Tel_NO { get; set; }

        public string Alt_STDcode { get; set; }

        public bool? Change_Deductor { get; set; }

        public string R_Name { get; set; }

        public string R_Flat_NO { get; set; }

        public string R_Building { get; set; }

        public string R_Street { get; set; }

        public string R_Area_Location { get; set; }

        public string R_Town_City { get; set; }

        public string R_EmailID { get; set; }

        public string R_Designation { get; set; }

        public int? R_StateID { get; set; }

        public string R_Mobile_NO { get; set; }

        public string R_Pincode { get; set; }

        public string R_STD_Code { get; set; }

        public string R_Tel_NO { get; set; }

        public string R_Fax { get; set; }

        public bool? Change_Responsible { get; set; }

        public string ALT_R_EmailID { get; set; }

        public string ALT_R_Tel_NO { get; set; }

        public string ALT_R_STD_Code { get; set; }

        public int? Parent_Company_ID { get; set; }

        public Guid UserID { get; set; }

        public bool? Sub_Companys { get; set; }

        public int? Sub_Company_Count { get; set; }

        public bool? IsApproved { get; set; }

        public string Role { get; set; }

        public int? Logins { get; set; }

        public DateTime? LastLogin { get; set; }

        public int? StateID { get; set; }

        public string Co_Branch { get; set; }

        public string Alias { get; set; }

        public string CompanyLogoName { get; set; }

        public string Company_Registration { get; set; }

        public string ContactPersonPAN { get; set; }

    }
    public class tbl_Monthly_SAlary_For_Employee_Salary
    {
        public int Head_ID { get; set; }
        public string Head_Name { get; set; }
        public string Head_Group { get; set; }
        public double Amount { get; set; }
        public string Manual_Entry { get; set; }

        public int Employee_ID { get; set; }
    }

    public class tbl_Computationdetaion_Report
    {
        public string HeadName { get; set; }
        public double Amt { get; set; }
        public int Employee_ID { get; set; }

    }
    public class tbl_HeadName_Report
    {
        public string HeadName { get; set; }
        public double Amt { get; set; }
        public int Employee_ID { get; set; }
    }

    public class tbl_Nature
    {
        public string NatureName { get; set; }
        public int Nature_ID { get; set; }
        public string ChallanType { get; set; }
        public string Nature_Sub_Id { get; set; }
        public List<tbl_Section> Lst_Sec { get; set; }

    }

    public class tbl_Voucher
    {
        public int Voucher_ID { get; set; }

        public int? Company_ID { get; set; }

        public int? Challan_ID { get; set; }

        public Int64? Deductee_ID { get; set; }

        public int? Nature_ID { get; set; }

        public string Nature_Sub_ID { get; set; }

        public string fromDT { get; set; }

        public string toDT { get; set; }

        public DateTime? Voucher_DT { get; set; }
        public string V_DT { get; set; }

        public float? Voucher_Amount { get; set; }

        public float? TDS_Amt { get; set; }

        public float? Surcharge_Amt { get; set; }

        public float? ECess_Amt { get; set; }

        public float? HECess_Amt { get; set; }

        public decimal? TDS_Percentage { get; set; }

        public decimal? Surchare_Percentage { get; set; }

        public decimal? ECess_Percentage { get; set; }

        public decimal? HECess_Percentage { get; set; }

        public float? Total_Tax_Amt { get; set; }

        public string Deductee_Type { get; set; }

        public bool? IS_NRI { get; set; }

        public string Reason { get; set; }

        public string Deductee_Name { get; set; }

        public string Quarter { get; set; }

        public int? Sel { get; set; }

        public string Section { get; set; }

        public string From_Type { get; set; }

        public string PAN_NO { get; set; }

        public string TDS_Certificate { get; set; }

        public int? Country_Code { get; set; }

        public string NRI_Code { get; set; }

        public int? Remittance_ID { get; set; }

        public string PANVerified { get; set; }

        public bool? Threshold_Limit { get; set; }

        public DateTime? Challan_Date { get; set; }

        public string Challan_BankNo { get; set; }

        public string Certificate_No { get; set; }

        public string InvORBillNo { get; set; }

        public int? BranchID { get; set; }


        public int? TotalIndex { get; set; }
        public object PageIndex { get; set; }

        public object PageSize { get; set; }

        public int SrNo { get; set; }

        public string TotalCount { get; set; }

        public string Nature_Name { get; set; }

        public string Country_Name { get; set; }

        public bool is_Individual { get; set; }

        public string pincode { get; set; }

        public string City { get; set; }

        public string Street { get; set; }

        public string Bldg_Name { get; set; }

        public string Flat_No { get; set; }

        public string Branch_Name { get; set; }
    }

    public class tbl_Voucher_List
    {
        public int Voucher_ID { get; set; }

        public int? Company_ID { get; set; }

        public int? Challan_ID { get; set; }

        public Int64? Deductee_ID { get; set; }

        public int? Nature_ID { get; set; }

        public string Nature_Sub_ID { get; set; }

        public string fromDT { get; set; }

        public string toDT { get; set; }

        public DateTime? Voucher_DT { get; set; }
        public string V_DT { get; set; }

        public DateTime? Challan_Date { get; set; }

        public float? Voucher_Amount { get; set; }

        public float? TDS_Amt { get; set; }

        public float? Surcharge_Amt { get; set; }

        public float? ECess_Amt { get; set; }

        public float? HECess_Amt { get; set; }

        public float? Total_Tax_Amt { get; set; }

        public string Deductee_Type { get; set; }

        public string Deductee_Name { get; set; }

        public string Quarter { get; set; }

        public int? Sel { get; set; }

        public string Section { get; set; }

        public string PAN_NO { get; set; }


        public int? TotalIndex { get; set; }
        public object PageIndex { get; set; }

        public object PageSize { get; set; }

        public int SrNo { get; set; }

        public string TotalCount { get; set; }

        public string Nature_Name { get; set; }

    }


    public class tbl_Challan_Non_Salary
    {
        public int Challan_ID { get; set; }

        public int? Company_ID { get; set; }

        public DateTime? Challan_Date { get; set; }
        public string C_Date { get; set; }
        public int? Bank_ID { get; set; }

        public string Bank_Bsrcode { get; set; }

        public int? Cheque_no { get; set; }

        public DateTime? Cheque_Date { get; set; }

        public string Quater { get; set; }

        public float? TDS_Amount { get; set; }

        public float? Surcharge { get; set; }

        public float? Education_Cess { get; set; }

        public float? High_Education_Cess { get; set; }

        public float? Interest_Amt { get; set; }

        public float? Fees_Amount { get; set; }

        public float? Others_Amount { get; set; }

        public float? Challan_Amount { get; set; }

        public string Challan_No { get; set; }

        public string Trans_No { get; set; }

        public string C_Entry { get; set; }

        public bool? Nil_Challan { get; set; }

        public string Challan_Type { get; set; }

        public string Form_Type { get; set; }

        public float? Total_Tax_Amt { get; set; }

        public Int64 Deductee_ID { get; set; }

        public int? Nature_ID { get; set; }

        public int? Srno { get; set; }

        public float? Total_DTax { get; set; }
    }

    public class tbl_Form16settings
    {
        public int? companyid { get; set; }

        public string releation { get; set; }

        public string personname { get; set; }

        public string releationname { get; set; }

        public string location { get; set; }

        public string designation { get; set; }

    }
    public class tbl_Perquisites
    {
        public double? Perquisites_Value { get; set; }

        public double? EmployeePaid_Amt { get; set; }

        public double? Taxable_Amt { get; set; }

        public int Perq_ID { get; set; }

        public int? Perquisites_ID { get; set; }

        public string Perquisites_Name { get; set; }

        public int? Employee_ID { get; set; }

        public int? Company_ID { get; set; }

        public string FirstName { get; set; }

        public string PAN_NO { get; set; }

        public string Designation_Name { get; set; }

        public double GrossEarn1 { get; set; }

        public double Itax2 { get; set; }
    }

    public class tblTDSComputationSummary
    {
        public int RecordCount { get; set; }

        public int RowNumber { get; set; }

        public int Employee_ID { get; set; }

        public string FirstName { get; set; }

        public string Gender { get; set; }

        public double SumofSalary { get; set; }

        public double GrossEarn1 { get; set; }

        public double Grossnet { get; set; }

        public double TotalRebate { get; set; }

        public double Itax1 { get; set; }

        public double PreTds { get; set; }

        public double FinalTax { get; set; }

        public List<tblGetColData> FilterList { get; set; }

        public List<tblChallanSummary> ChallanSummary { get; set; }
    }

    public class tblGetColData
    {
        public int CompanyID { get; set; }

        public int PageIndex { get; set; }

        public int PageSize { get; set; }

        public string SearchVal { get; set; }

        public int FilterById { get; set; }

        public string FilterByVal { get; set; }

        public string ConnectionString { get; set; }
    }

    public class tblChallanSummary
    {
        public int Employee_ID { get; set; }
        public string Quater { get; set; }
        public string Challan_NO { get; set; }
        public string Challan_Date { get; set; }
        public string TDS_Deduction_Date { get; set; }
        public string Employee_Salary { get; set; }
        public string TDS_Amount { get; set; }
        public string Surcharge_Amount { get; set; }
        public string EducationCess_Amount { get; set; }
        public string High_EductionCess_Amount { get; set; }
        public string Total_TDS_Amount { get; set; }
    }

    public class tbl_Rebate_Limits
    {
        public string Rebate_Name { get; set; }

        public double? Rebate_Limit { get; set; }

        public double? Salary_Limit { get; set; }

    }

    public class tbl_Monthly_Salary_BreakUp
    {
        public int? Employee_ID { get; set; }

        public int? Company_ID { get; set; }

        public string Head_Type { get; set; }

        public int? Head_ID { get; set; }

        public int? SalaryMonth { get; set; }

        public float? Amount { get; set; }

        public string Quater { get; set; }


        public string Head_Name { get; set; }
    }
    public class tbl_Monthly_Salary
    {
        public int? Employee_ID { get; set; }

        public int? Company_ID { get; set; }

        public float? Net_Additions { get; set; }

        public float? Net_Deductions { get; set; }

        public float? Net_Salary { get; set; }

        public float? Total_PF { get; set; }

        public int? SalaryMonth { get; set; }

        public int? Branch_ID { get; set; }

        public string Employee_Name { get; set; }

        public string RsInWords { get; set; }

        public string PF_No { get; set; }

        public float? Days_Present { get; set; }

        public float? Days_Absent { get; set; }

        public int? Total_Month_Days { get; set; }

        public float? PF_ON_Heads { get; set; }

        public float? Esic_ON_Heads { get; set; }

        public string Department_Name { get; set; }

        public string Designation_Name { get; set; }

        public string Quater { get; set; }

        public int? Grade_ID { get; set; }

        public DateTime? Salary_Date { get; set; }

        public bool? Hold_Salary { get; set; }

    }
    public class tbl_Incometax_Master
    {
        public int Incometax_ID { get; set; }

        public string Gender { get; set; }

        public double Tax_Amount { get; set; }

        public float Slab { get; set; }

        public string SlabTitle { get; set; }

        public string SlabSubTitle { get; set; }

    }

    public class tbl_Incometax_Master_Multi
    {
        public int Incometax_ID { get; set; }

        public string Gender { get; set; }

        public double Tax_Amount { get; set; }

        public float Slab { get; set; }

        public string SlabTitle { get; set; }

        public string SlabSubTitle { get; set; }

    }

    public class tbl_HRA_Rent_Receipt
    {
        public int HRA_Rent_Receipt_ID { get; set; }

        public int Employee_ID { get; set; }

        public int? Month_No { get; set; }

        public string Month_Name { get; set; }

        public float Amount { get; set; }

        public int Company_ID { get; set; }

    }

    public class tbl_TDS_Rebate
    {
        public int? Employee_ID { get; set; }

        public int? Company_ID { get; set; }

        public int? Rebate_ID { get; set; }

        public float? Amount { get; set; }

        public string Rebate_Name { get; set; }
    }

    public class Tbl_TDS_Computation
    {
        public int? Employee_ID { get; set; }

        public int? Company_ID { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string Designation_Name { get; set; }

        public string Department_Name { get; set; }

        public string Gender { get; set; }

        public string Senior_CTZN_Type { get; set; }

        public float? Surcharge { get; set; }

        public float? Total_Earnings { get; set; }

        public float? GrossPerks_B { get; set; }

        public float? GrossProfits_C { get; set; }

        public float? GrossTotal_D { get; set; }

        public float? GrossEarn1 { get; set; }

        public float? Section_10 { get; set; }

        public float? GrossEarn3 { get; set; }

        public float? PreSal { get; set; }

        public float? TotalDeduction { get; set; }

        public float? Entertainment { get; set; }

        public float? StandardDeductions { get; set; }

        public float? PTax { get; set; }

        public float? GrossEarn5 { get; set; }

        public float? IntHouseLoan { get; set; }

        public float? OtherIncome { get; set; }

        public float? GrossEarn8 { get; set; }

        public float? PF { get; set; }

        public float? RebateBonds { get; set; }

        public float? Rebate80QlfySal { get; set; }

        public float? Rebate80NetSal { get; set; }

        public float? TotalRebate { get; set; }

        public float? Grossnet { get; set; }

        public float? Itax1 { get; set; }

        public float? Rebatetds { get; set; }

        public float? EducationCess { get; set; }

        public float? HighEduCess { get; set; }

        public float? HeathCess { get; set; }

        public float? Itax2 { get; set; }

        public float? Rebate89 { get; set; }

        public float? Itax3 { get; set; }

        public float? Challan_Tax { get; set; }

        public float? PreTds { get; set; }

        public float? FinalTax { get; set; }

        public bool? Manual { get; set; }

        public string Rsinwords { get; set; }

        public int? sel { get; set; }

        public float? HRate { get; set; }

        public string PAN_NO { get; set; }

        public float? Rebate80CCD1B { get; set; }

        public bool? Rent_Payment { get; set; }

        public int? Count_PAN_landlord { get; set; }

        public string PAN_landlord1 { get; set; }

        public string Name_landlord1 { get; set; }

        public string PAN_landlord2 { get; set; }

        public string Name_landlord2 { get; set; }

        public string PAN_landlord3 { get; set; }

        public string Name_landlord3 { get; set; }

        public string PAN_landlord4 { get; set; }

        public string Name_landlord4 { get; set; }

        public bool? Interest_lender { get; set; }

        public int? Count_PAN_lender { get; set; }

        public string PAN_lender1 { get; set; }

        public string Name_lender1 { get; set; }

        public string PAN_lender2 { get; set; }

        public string Name_lender2 { get; set; }

        public string PAN_lender3 { get; set; }

        public string Name_lender3 { get; set; }

        public string PAN_lender4 { get; set; }

        public string Name_lender4 { get; set; }

        public bool? Contributions_superannuation_fund { get; set; }

        public string Name_superannuation_fund { get; set; }

        public DateTime? Frm_DT_superannuation_fund { get; set; }

        public DateTime? TO_DT_superannuation_fund { get; set; }

        public string Frm_DT_superannuation_fund_string { get; set; }

        public string TO_DT_superannuation_fund_string { get; set; }


        public double? principal_interest_superannuation_fund { get; set; }

        public double? Rate_deduction_tax_3yrs { get; set; }

        public double? Repayment_superannuation_fund { get; set; }

        public double? Total_Income_superannuation_fund { get; set; }

        public double? SurchargePer { get; set; }

        public double? SurchargeSalary { get; set; }

        public string ConnectionString { get; set; }

        public DateTime? Join_DT { get; set; }


        public List<tbl_Monthly_Salary_BreakUp> LMonthlySalaryBreakup { get; set; }

        public List<tbl_Perquisites> LPerquisites { get; set; }

        public List<tbl_Section_10> LSection10 { get; set; }

        public List<tbl_Monthly_Salary_BreakUp> LProfessionTax { get; set; }

        public List<tbl_TDS_Rebate> LTDSRebate { get; set; }

        public string Metro_Cities { get; set; }

        public string HraType { get; set; }

        public int No_Of_Child { get; set; }

        public int state_id { get; set; }

        public List<tbl_HRA_Rent_Receipt> LHRARentReceipt { get; set; }

        public List<tbl_Professionaltax_Master> LProfessiontaxMaster { get; set; }

        public List<tbl_Incometax_Master> LIncomeTaxMaster { get; set; }

        public List<tblEmployeeTDSReletatedOtherDetails> LtblEmployeeTDSReletatedOtherDetails { get; set; }

        public bool CALC_PF { get; set; }

        public bool CALC_PT { get; set; }

        public string sur_type { get; set; }

        public List<tbl_Rebates_Computation> TRebates { get; set; }

        public List<tblChallanSummary> TChallanDtls { get; set; }

        public int I115BAC { get; set; }
        public bool? ManualHRA { get; set; }

        public List<tbl_Incometax_Master_Multi> IncomeTaxM { get; set; }
    }

    public class tbl_Surcharge_Slab
    {
        public double? SurchargePer { get; set; }
        public double? SurchargeSalary { get; set; }
        public string App_Type { get; set; }
        public string Surchargetype { get; set; }
        public double? Marginal_Amount { get; set; }
        public double? Marginal_Surcharge { get; set; }
    }

    public class tbl_Rebates_Computation
    {
        public float? Rebate80C { get; set; }

        public float? Rebate80CCC { get; set; }

        public float? Rebate80CCD { get; set; }

        public float? Rebate80CCD1B { get; set; }

        public float? Rebate80CCD2 { get; set; }

        public float? Rebate80QlfySal { get; set; }

        public float? Rebate80NetSal { get; set; }

        public float? Rebate88D { get; set; }

        public float? Rebate80DD { get; set; }

        public float? Rebate80DDB { get; set; }

        public float? Rebate80QQB { get; set; }

        public float? Rebate80E { get; set; }

        public float? Rebate80EE { get; set; }

        public float? Rebate80G { get; set; }

        public float? Rebate80GG { get; set; }

        public float? Rebate80GGA { get; set; }

        public float? Rebate80GGC { get; set; }

        public float? Rebate80RRB { get; set; }

        public float? Rebate80U { get; set; }

        public float? Rebate80CCG { get; set; }

        public float? Rebate80TTA { get; set; }


        public float? Rebate80C_Ded { get; set; }

        public float? Rebate80CCC_Ded { get; set; }

        public float? Rebate80CCD1B_Ded { get; set; }

        public float? Rebate80CCD_Ded { get; set; }

        public float? Rebate80CCD2_Ded { get; set; }

        public float? Rebate88D_Ded { get; set; }

        public float? Rebate80DD_Ded { get; set; }

        public float? Rebate80DDB_Ded { get; set; }

        public float? Rebate80QQB_Ded { get; set; }

        public float? Rebate80E_Ded { get; set; }

        public float? Rebate80EE_Ded { get; set; }

        public float? Rebate80G_Ded { get; set; }

        public float? Rebate80GG_Ded { get; set; }

        public float? Rebate80GGA_Ded { get; set; }

        public float? Rebate80GGC_Ded { get; set; }

        public float? Rebate80RRB_Ded { get; set; }

        public float? Rebate80U_Ded { get; set; }

        public float? Rebate80CCG_Ded { get; set; }

        public float? Rebate80TTA_Ded { get; set; }



        public float? Rebate80G_Qlfy { get; set; }

        public float? Rebate80GG_Qlfy { get; set; }

        public float? Rebate80GGA_Qlfy { get; set; }

        public float? Rebate80GGC_Qlfy { get; set; }

        public float? Rebate80RRB_Qlfy { get; set; }

        public float? Rebate80U_Qlfy { get; set; }

        public float? Rebate80CCG_Qlfy { get; set; }

        public float? Rebate80TTA_Qlfy { get; set; }

    }

    public class Tbl_TDS_SaveComputation
    {
        public int? Employee_ID { get; set; }

        public int? Company_ID { get; set; }

        public string FirstName { get; set; }

        public string Perk { get; set; }

        public string LastName { get; set; }

        public string Designation_Name { get; set; }

        public string Department_Name { get; set; }

        public string Gender { get; set; }

        public string Senior_CTZN_Type { get; set; }

        public float? Surcharge { get; set; }

        public double? Total_Earnings { get; set; }

        public double? GrossPerks_B { get; set; }

        public double? GrossProfits_C { get; set; }

        public double? GrossTotal_D { get; set; }

        public double? GrossEarn1 { get; set; }

        public double? Section_10 { get; set; }

        public double? GrossEarn3 { get; set; }

        public double? PreSal { get; set; }

        public double? TotalDeduction { get; set; }

        public double? Entertainment { get; set; }

        public double? StandardDeductions { get; set; }

        public double? PTax { get; set; }

        public double? GrossEarn5 { get; set; }

        public double? IntHouseLoan { get; set; }

        public double? OtherIncome { get; set; }

        public double? GrossEarn8 { get; set; }

        public double? PF { get; set; }

        public double? RebateBonds { get; set; }

        public double? Rebate80QlfySal { get; set; }

        public double? Rebate80NetSal { get; set; }

        public double? TotalRebate { get; set; }

        public double? Grossnet { get; set; }

        public double? Itax1 { get; set; }

        public double? Rebatetds { get; set; }

        public double? EducationCess { get; set; }

        public double? HighEduCess { get; set; }

        public double? HeathCess { get; set; }

        public double? Itax2 { get; set; }

        public double? Rebate89 { get; set; }

        public double? Itax3 { get; set; }

        public double? Challan_Tax { get; set; }

        public double? PreTds { get; set; }

        public double? FinalTax { get; set; }

        public bool? Manual { get; set; }

        public string Rsinwords { get; set; }

        public int? sel { get; set; }

        public float? HRate { get; set; }

        public string PAN_NO { get; set; }

        public bool? ManualHRA { get; set; }
        public bool? Rent_Payment { get; set; }

        public int? Count_PAN_landlord { get; set; }

        public string PAN_landlord1 { get; set; }

        public string Name_landlord1 { get; set; }

        public string PAN_landlord2 { get; set; }

        public string Name_landlord2 { get; set; }

        public string PAN_landlord3 { get; set; }

        public string Name_landlord3 { get; set; }

        public string PAN_landlord4 { get; set; }

        public string Name_landlord4 { get; set; }

        public bool? Interest_lender { get; set; }

        public int? Count_PAN_lender { get; set; }

        public string PAN_lender1 { get; set; }

        public string Name_lender1 { get; set; }

        public string PAN_lender2 { get; set; }

        public string Name_lender2 { get; set; }

        public string PAN_lender3 { get; set; }

        public string Name_lender3 { get; set; }

        public string PAN_lender4 { get; set; }

        public string Name_lender4 { get; set; }

        public bool? Contributions_superannuation_fund { get; set; }

        public string Name_superannuation_fund { get; set; }

        public DateTime? Frm_DT_superannuation_fund { get; set; }

        public DateTime? TO_DT_superannuation_fund { get; set; }

        public string Frm_DT_superannuation_fund_string { get; set; }

        public string TO_DT_superannuation_fund_string { get; set; }


        public double? principal_interest_superannuation_fund { get; set; }

        public double? Rate_deduction_tax_3yrs { get; set; }

        public double? Repayment_superannuation_fund { get; set; }

        public double? Total_Income_superannuation_fund { get; set; }

        public double? SurchargePer { get; set; }

        public double? SurchargeSalary { get; set; }

        public string ConnectionString { get; set; }

        public DateTime? Join_DT { get; set; }

        public string Metro_Cities { get; set; }

        public string HraType { get; set; }

        public int No_Of_Child { get; set; }


        public int state_id { get; set; }


        public bool CALC_PF { get; set; }

        public bool CALC_PT { get; set; }

        public string sur_type { get; set; }

        public List<tbl_Monthly_Salary_BreakUp> LMonthlySalaryBreakup { get; set; }

        public List<tbl_Perquisites> LPerquisites { get; set; }

        public List<tbl_Section_10> LSection10 { get; set; }

        public List<tbl_Monthly_Salary_BreakUp> LProfessionTax { get; set; }

        public List<tbl_TDS_Rebate> LTDSRebate { get; set; }

        public List<tbl_HRA_Rent_Receipt> LHRARentReceipt { get; set; }

        public List<tbl_Professionaltax_Master> LProfessiontaxMaster { get; set; }

        public List<tbl_Incometax_Master> LIncomeTaxMaster { get; set; }

        public List<tblEmployeeTDSReletatedOtherDetails> LtblEmployeeTDSReletatedOtherDetails { get; set; }

        public float? Rebate80C { get; set; }

        public float? Rebate80CCC { get; set; }

        public float? Rebate80CCD { get; set; }

        public float? Rebate80CCD1B { get; set; }

        public float? Rebate80CCD2 { get; set; }



        public float? Rebate88D { get; set; }

        public float? Rebate80DD { get; set; }

        public float? Rebate80DDB { get; set; }

        public float? Rebate80QQB { get; set; }

        public float? Rebate80E { get; set; }

        public float? Rebate80EE { get; set; }

        public float? Rebate80G { get; set; }

        public float? Rebate80GG { get; set; }

        public float? Rebate80GGA { get; set; }

        public float? Rebate80GGC { get; set; }

        public float? Rebate80RRB { get; set; }

        public float? Rebate80U { get; set; }

        public float? Rebate80CCG { get; set; }

        public float? Rebate80TTA { get; set; }


        public float? Rebate80C_Ded { get; set; }

        public float? Rebate80CCC_Ded { get; set; }

        public float? Rebate80CCD1B_Ded { get; set; }

        public float? Rebate80CCD_Ded { get; set; }

        public float? Rebate80CCD2_Ded { get; set; }

        public float? Rebate88D_Ded { get; set; }

        public float? Rebate80DD_Ded { get; set; }

        public float? Rebate80DDB_Ded { get; set; }

        public float? Rebate80QQB_Ded { get; set; }

        public float? Rebate80E_Ded { get; set; }

        public float? Rebate80EE_Ded { get; set; }

        public float? Rebate80G_Ded { get; set; }

        public float? Rebate80GG_Ded { get; set; }

        public float? Rebate80GGA_Ded { get; set; }

        public float? Rebate80GGC_Ded { get; set; }

        public float? Rebate80RRB_Ded { get; set; }

        public float? Rebate80U_Ded { get; set; }

        public float? Rebate80CCG_Ded { get; set; }

        public float? Rebate80TTA_Ded { get; set; }



        public float? Rebate80G_Qlfy { get; set; }

        public float? Rebate80GG_Qlfy { get; set; }

        public float? Rebate80GGA_Qlfy { get; set; }

        public float? Rebate80GGC_Qlfy { get; set; }

        public float? Rebate80RRB_Qlfy { get; set; }

        public float? Rebate80U_Qlfy { get; set; }

        public float? Rebate80CCG_Qlfy { get; set; }

        public float? Rebate80TTA_Qlfy { get; set; }

        public int I115BAC { get; set; }

        public string HrrRec { get; set; }
    }

    public class tbl_Surcharge_Master
    {
        public int Surcharge_ID { get; set; }

        public int? Company_ID { get; set; }

        public float? Surcharge_Percent { get; set; }

        public string App_Type { get; set; }

    }

    public class tbl_Section_10
    {
        public int? Employee_ID { get; set; }

        public int? Company_ID { get; set; }

        public int? Head_ID { get; set; }

        public float? Amount { get; set; }

        public string hname { get; set; }
        public string Head_Name { get; set; }

        public string Limit { get; set; }
    }

    public class tbl_Rebate_Err
    {
        public string Rebate_Name { get; set; }

        public string Employee { get; set; }
        public int? Company_ID { get; set; }
        public double Investment { get; set; }
        public double Deduction { get; set; }
        public string ConnectionString { get; set; }
        public List<tbl_Salary_Returns> list_Salary_Err { get; set; }
    }

    public class tbl_Salary_Returns
    {
        public string Employee { get; set; }
        public int? Company_ID { get; set; }
        public double Tax { get; set; }

    }

    public class tbl_Providend_Fund
    {
        public int? PF_Tax_ID { get; set; }

        public int? Company_ID { get; set; }

        public float PF_Percentage { get; set; }

        public float PF_Limit { get; set; }

    }


    public class tbl_Professionaltax_Master
    {
        public int Professionaltax_ID { get; set; }

        public int? State_ID { get; set; }

        public int? Company_ID { get; set; }

        public float? From_Tax_Amount { get; set; }

        public float? To_Tax_Amount { get; set; }

        public float? Slab { get; set; }

        public string Gender { get; set; }

    }

    public class tbl_Educationcess_Master
    {
        public int Educationcess_ID { get; set; }

        public int? Company_ID { get; set; }

        public float Cess_Percent { get; set; }

        public string App_Type { get; set; }

        public float HCess_Percent { get; set; }

    }

    public class tbl_Voucher_Details
    {
        public int Voucher_ID { get; set; }

        public int? Company_ID { get; set; }

        public float VAmt { get; set; }

        public string VDate { get; set; }
        public string DName { get; set; }
        public string Sec { get; set; }
        public string PAN { get; set; }

        public float TdsAmt { get; set; }

    }


    public class tbl_Rebate_Master
    {
        public int Rebate_ID { get; set; }

        public string Rebate_Name { get; set; }

        public int? Company_ID { get; set; }
        public string ConnectionString { get; set; }
    }

    public class objforCorrection_Remiitance
    {
        public string remittance { get; set; }
        public int rcode { get; set; }
    }

    public class objforCorrection
    {
        public int Srno { get; set; }
        public int Compid { get; set; }
        public string quarter { get; set; }
        public string ConnectionString { get; set; }
        public string Form_Type { get; set; }
        public string NAME { get; set; }
        public int id { get; set; }
        public string ddid { get; set; }

        public string Voucher_DT { get; set; }
        public string Amount { get; set; }
        public string TDS { get; set; }
        public string PAN_No { get; set; }
        public string Tds_Certificate { get; set; }
        public string Reason { get; set; }
        public string REMITTANCE { get; set; }
        public int REMITTANCE_Id { get; set; }
        public string correctionid { get; set; }
        public List<objforCorrection_Remiitance> list_Correction_Remiitance { get; set; }
    }

    public class tblEmployeeTDSReletatedOtherDetails
    {
        public string SurchargePer { get; set; }
        public string Cessper { get; set; }
        public string HCessper { get; set; }
        public string ChallanTDS { get; set; }
        public string HealthPer { get; set; }
        public string ProfessionTaxIDS { get; set; }
    }

    public class tbl_VoucherDropDowns
    {
        public int compid { get; set; }
        public string Conn { get; set; }
        public string ST { get; set; }
        public string ED { get; set; }
        public int did { get; set; }
        public string FormType { get; set; }
        public string Quater { get; set; }
        public List<tbl_DeducteeList> Deductee { get; set; }
        public List<tbl_Nature> Nature { get; set; }
        public List<objforCorrection_Remiitance> Remitance { get; set; }
        public List<tbl_VoucherGrd> Grd { get; set; }
        public List<tbl_Branch> Branch { get; set; }
        public List<tbl_Section> Section { get; set; }
        public List<Tbl_Country> Country { get; set; }
        public List<objChallanDetails> Challan { get; set; }
    }

    public class tbl_VoucherGrd
    {
        public string mth { get; set; }
        public double Amt { get; set; }
        public int Entries { get; set; }
        public int Upaid { get; set; }
        public int Tup { get; set; }
        public double Tds { get; set; }
        public int mthno { get; set; }
        public int compid { get; set; }
        public string Conn { get; set; }
        public string ST { get; set; }
        public string ED { get; set; }
        public string did { get; set; }
        public int Tent { get; set; }
        public double TAmt { get; set; }
        public double TTds { get; set; }
        public string Tokenid { get; set; }
        public string Qtr { get; set; }
        public string Ftyp { get; set; }

    }

    public class tbl_AmtTDSVoucher
    {
        public string Amt { get; set; }
        public string TDS { get; set; }

    }

    public class tbl_VoucherModifyGrd
    {
        public int compid { get; set; }
        public string Conn { get; set; }
        public string ST { get; set; }
        public string ED { get; set; }
        public string mth { get; set; }
        public string sec { get; set; }
        public string inv { get; set; }
        public string PDate { get; set; }
        public int mthno { get; set; }
        public string DName { get; set; }
        public string CPaid { get; set; }
        public int did { get; set; }
        public int vid { get; set; }
        public string nsid { get; set; }
        public int nid { get; set; }
        public int BnkChl { get; set; }
        public int pageIndex { get; set; }
        public int pageSize { get; set; }
        public double AmtPaid { get; set; }
        public double TdsAmt { get; set; }
        public int Totalcount { get; set; }
        public int UPaid { get; set; }
        public string TdsRate { get; set; }
        public string form_type { get; set; }
        public string Quater { get; set; }
        public int Chid { get; set; }

        public List<tbl_AmtTDSVoucher> LTDSgrid { get; set; }
    }
    public class tbl_Dashboard
    {
        public string Quater { get; set; }
        public string Formtype { get; set; }
        public int compid { get; set; }
        public string Rstatus { get; set; }
        public string Rfile { get; set; }
        public string Pfile { get; set; }
        public string ST { get; set; }
        public string ED { get; set; }
        public string XLPath { get; set; }
        public string RToken { get; set; }
        public List<tbl_VoucherModifyGrd> VoucherGrd { get; set; }
        public List<tbl_VoucherModify> VoucherModify { get; set; }
        public List<objChallanDetails> Challan { get; set; }
        public List<tbl_Section> Section { get; set; }

        public List<PANNo> lstPanno { get; set; }

    }

    public class tbl_VoucherModify
    {
        public int compid { get; set; }
        public string Conn { get; set; }
        public string ST { get; set; }
        public string ED { get; set; }
        public string mth { get; set; }
        public string PDate { get; set; }
        public DateTime VDT { get; set; }
        public int mthno { get; set; }
        public string DName { get; set; }
        public int sel { get; set; }
        public bool isNri { get; set; }
        public string formType { get; set; }
        public bool Thold { get; set; }
        public string Quater { get; set; }
        public int CPaid { get; set; }
        public int did { get; set; }
        public int nid { get; set; }
        public string nsid { get; set; }
        public int rid { get; set; }
        public int vid { get; set; }
        public string rsid { get; set; }
        public string tid { get; set; }
        public string sec { get; set; }
        public string Cert { get; set; }
        public string PAN { get; set; }
        public int Bid { get; set; }
        public string Invid { get; set; }
        public bool chk { get; set; }
        public double AmtPaid { get; set; }
        public double VTds { get; set; }
        public float ChlTDS { get; set; }
        public double TdsAmt { get; set; }
        public string Rate { get; set; }
        public float Sur { get; set; }
        public float Cess { get; set; }
        public double Total { get; set; }
        public string RT { get; set; }
        public string Add1 { get; set; }
        public string Contactno { get; set; }
        public string Emailid { get; set; }
        public string NriTDSRT { get; set; }
        public string TaxId { get; set; }
        public int CountryId { get; set; }
        public int VCCA { get; set; }
        public int UVCCA { get; set; }
        public string RToken { get; set; }
        public string eqNri { get; set; }
        public string eqInd { get; set; }
        public string ChlDtls { get; set; }
        public string BAC1A { get; set; }
        public string PAN_AAdhar { get; set; }
        public string PChar { get; set; }
        public int pageSize { get; set; }
        public int pageIndex { get; set; }
        public List<tbl_VoucherModifyGrd> Grd { get; set; }
        public List<tbl_Section> Lst_Sec { get; set; }
    }

    public class tbl_DeducteeDetails
    {
        public int compid { get; set; }
        public string Conn { get; set; }
        public string DName { get; set; }
        public bool isNri { get; set; }
        public int did { get; set; }
        public int nid { get; set; }
        public string nsid { get; set; }
        public string rsid { get; set; }
        public string tid { get; set; }
        public bool isInd { get; set; }
        public string sec { get; set; }
        public string Cert { get; set; }
        public string PAN { get; set; }
        public string RT { get; set; }
        public string Rate { get; set; }
        public string ST { get; set; }
        public string ED { get; set; }
        public string formType { get; set; }
        public int RemId { get; set; }
        public int Countryid { get; set; }
        public string TaxId { get; set; }
        public string Add1 { get; set; }
        public string Cnumber { get; set; }
        public string Email { get; set; }
        public string BAC_1A { get; set; }
        public string PAN_AAdhar { get; set; }
        public int Compliance { get; set; }
        public List<tbl_Branch> Lst_Br { get; set; }
        public List<tbl_Section> Lst_Sec { get; set; }
        public List<tbl_Nature> Lst_Nature { get; set; }

    }
    public class tbl_DeducteeRate
    {
        public int compid { get; set; }
        public string Conn { get; set; }
        public string Rate { get; set; }
        public string ST { get; set; }
        public string ED { get; set; }
        public int did { get; set; }
        public int nid { get; set; }
        public string nsid { get; set; }
        public string PDate { get; set; }
        public DateTime VDT { get; set; }
    }

    public class tbl_Branch
    {
        public int compid { get; set; }
        public string Bname { get; set; }
        public int bid { get; set; }

    }

    public class tbl_Section
    {
        public string Section { get; set; }
        public string Section_Id { get; set; }
        public double Tds_Amt { get; set; }

        public double PAS { get; set; }
    }

    public class tbl_HRR
    {
        public int Employee_ID { get; set; }
        public double Sbasic { get; set; }
        public double HRA { get; set; }
        public double HRR { get; set; }
        public int Month_no { get; set; }
        public string Month_Name { get; set; }
        public int Hrrid { get; set; }

    }

    public class tbl_TracesDetail
    {
        public int Compid { get; set; }
        public string TAN { get; set; }
        public string Userid { get; set; }
        public string Password { get; set; }
    }


    public class tbl_watsnew
    {
        public int ID { get; set; }

    }

    public class tbl_watsnewrecord
    {
        public int Wid { get; set; }
        public string Updatedate { get; set; }
        public string Subject { get; set; }
        public string Descriptn { get; set; }
    }

    public class tbl_State
    {
        public int State_Id { get; set; }
        public string StateName { get; set; }
    }

    public class MisMatch_Vouchers
    {
        public int Compid { get; set; }
        public string Quater { get; set; }
        public string FromType { get; set; }
        public List<Nri_MisMatch> Lst_Nri { get; set; }
        public List<MisMatch_PAN> Lst_PAN { get; set; }
        public List<MisMatch_Trans> Lst_Tr { get; set; }
        public List<MisMatch_BAC> Lst_BACIA { get; set; }
        public List<MisMatch_DType> Lst_DType { get; set; }
    }

    public class MisMatch_BAC
    {
        public string DName { get; set; }
        public int Did { get; set; }
        public int Compid { get; set; }
        public string Quater { get; set; }
        public string FromType { get; set; }
        public string TBAC { get; set; }
    }

    public class MisMatch_DType
    {
        public string DName { get; set; }
        public int Did { get; set; }
        public int Compid { get; set; }
        public string Quater { get; set; }
        public string FromType { get; set; }
        public string DType { get; set; }
        public string PAN { get; set; }
    }

    public class Nri_MisMatch
    {
        public string Email { get; set; }
        public string DName { get; set; }
        public string Tel { get; set; }
        public string Tax { get; set; }
        public string Add { get; set; }
    }
    public class MisMatch_PAN
    {
        public string PDate { get; set; }
        public string DName { get; set; }
        public float AmtPaid { get; set; }
        public string VPAN { get; set; }
        public string DPAN { get; set; }
        public int Vid { get; set; }
    }

    public class MisMatch_Trans
    {

        public string PDate { get; set; }
        public string DName { get; set; }
        public float AmtPaid { get; set; }
        public float TdsAmt { get; set; }
        public float CTdsAmt { get; set; }
        public string RT { get; set; }
        public string Cert { get; set; }
        public string Error { get; set; }
        public int Vid { get; set; }
    }


    public class TracesInfo
    {
        public int Compid { get; set; }
        public string FormType { get; set; }
        public string Quarter { get; set; }
    }


    public class PANNo
    {
        public string PAN { get; set; }
        public string Active { get; set; }
        public string InActive { get; set; }
        public string InValid { get; set; }
        public string NotVerified { get; set; }
        public bool PVerify { get; set; }
        public int Compid { get; set; }
        public string FormType { get; set; }
        public string Quarter { get; set; }
        public string PAN_AAdhar { get; set; }
    }



    public class tbl_DeducteeReport
    {
        public string DName { get; set; }
        public string AmtPaid { get; set; }
        public string PAN { get; set; }
        public string Section { get; set; }
        public string TDS { get; set; }
        public string Paid { get; set; }
        public string Unpiad { get; set; }
        public int Compid { get; set; }
        public DateTime From { get; set; }
        public DateTime To { get; set; }
        public string FromType { get; set; }
        public int rdio { get; set; }
    }

    public class DeducteeGrid
    {
        public int compid { get; set; }
        public string Conn { get; set; }
        public string DName { get; set; }
        public bool isNri { get; set; }
        public int did { get; set; }
        public string PAN { get; set; }
        public string DType { get; set; }
        public string PANVerified { get; set; }
        public int Totalcount { get; set; }
        public int Comp206 { get; set; }
        public int Srno { get; set; }
    }

    public class Tbl_Deductee
    {
        public int compid { get; set; }
        public string Conn { get; set; }
        public string DName { get; set; }
        public bool isNri { get; set; }
        public int did { get; set; }
        public string PAN { get; set; }
        public string DType { get; set; }
        public string DReason { get; set; }
        public string Add1 { get; set; }
        public string Add2 { get; set; }
        public string Contactno { get; set; }
        public string Emailid { get; set; }
        public string NriTDSRT { get; set; }
        public string TaxId { get; set; }
        public int Countryid { get; set; }
        public double TDSRT { get; set; }
        public double Surcharge { get; set; }
        public int TDSRT_FR { get; set; }
        public bool Multi_Co { get; set; }
        public string isInd { get; set; }
        public string BAC_1A { get; set; }
    }


    public class Tbl_Country
    {
        public int Countryid { get; set; }
        public string Country { get; set; }
    }

    public class ResonseType
    {
        public bool isPass { get; set; }
        public string filePath { get; set; }
        public string errorMessage { get; set; }

    }
}