<%@ WebService Language="C#" Class="TService" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Data;
using Microsoft.ApplicationBlocks1.Data;
using CommonLibrary;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using System.Globalization;
using DataLayer;
using BusinessLayer;
using System.Web.Security;
using System.Text;
using Newtonsoft.Json;
using System.IO;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class TService  : System.Web.Services.WebService {

    eTDS tds = new eTDS();
    private ConnectTR objConnect = new ConnectTR();
    private LoginTraces objLogin = new LoginTraces();
    private TracesData objTraceData = new TracesData();
    BAL_Traces objBAL_Traces = new BAL_Traces();
    CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string tCaptcha()
    {
        try
        {
            var json = this.objConnect.MakeInitialRequest_SVC();

            return json;


        }
        catch (Exception ex)
        {
            return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
        }
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Get_tracesLoginDetails()
    {
        try
        {
            DataSet ds = new DataSet();
            objBAL_Traces._Company_ID = Convert.ToInt32(HttpContext.Current.Session["companyid"]);


            ds = objBAL_Traces.Get_tracesLoginDetails();
            return JsonConvert.SerializeObject(new
            {
                dt_Login = DataTableToJSONWithStringBuilder(ds.Tables[0]),

            });
        }
        catch (Exception ex)
        {
            return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
        }

    }

    /************Challan functionality*/
    [System.Web.Services.WebMethod(EnableSession = true)]
    public string ChallanCaptcha()
    {
        try
        {
            var json = this.objConnect.MakeInitialRequest_Challan();

            return json;
        }
        catch (Exception ex)
        {
            return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
        }
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string DownloadChallan(Challan challan)
    {
        TDSResponse objTDSResponse = new TDSResponse();
        try
        {
            string base64 = string.Empty;
            string filename = string.Empty;
        Again:
            objTDSResponse = this.objConnect.ChallanDownload(challan, out filename, out base64);

            if (objTDSResponse.Respons == eResponse.Success)
            {
                //Commented and added by Sharmila Start Here - 11-10-2022
                //HttpContext.Current.Session["CSI"] = base64;
                HttpContext.Current.Session["CSIFilename"] = filename;

                string[] fy = challan.finacialYear.ToString().Split('_');
                var hdnfinancialyear = fy[0] + fy[1];
                string eReturnspath = System.Web.HttpContext.Current.Server.MapPath("~/eReturns/Regular");
                string tannoPath = (eReturnspath + "\\" + challan.TAN_NO + "\\" + hdnfinancialyear);

                string fromtypepath = tannoPath + "\\" + challan.fromType;
                string QuaterPath = (fromtypepath + "\\" + challan.quaterValue);

                try
                {
                    if (Directory.Exists(QuaterPath))
                    {
                        try
                        {
                            string mcer = QuaterPath + "\\e-mudhra.cer";
                            if (File.Exists(mcer))
                            {
                                File.Delete(mcer);
                            }
                            Directory.Delete(QuaterPath, true);
                        }
                        catch (Exception ex)
                        {
                            ErrorException.LogError(ex);
                        }
                    }
                    if (!Directory.Exists(QuaterPath))
                    {
                        Directory.CreateDirectory(QuaterPath);
                    }
                    else
                    {
                        try
                        {
                            Directory.Delete(QuaterPath, true);

                            Directory.CreateDirectory(QuaterPath);
                        }
                        catch (Exception ex)
                        {
                            ErrorException.LogError(ex);
                        }

                    }
                    if (!Directory.Exists(QuaterPath))
                    {
                        Directory.CreateDirectory(QuaterPath);
                    }
                }
                catch (Exception ex)
                {
                    ErrorException.LogError(ex);
                }

                File.WriteAllBytes(QuaterPath + "\\" + filename.ToString(), Convert.FromBase64String(base64));
                //Commented and added by Sharmila End Here - 11-10-2022


                var fileStream = new FileStream(QuaterPath + "\\" + filename.ToString(), FileMode.Open, FileAccess.Read);
                using (var streamReader = new StreamReader(fileStream, Encoding.UTF8))
                {
                    string line;
                    while ((line = streamReader.ReadLine()) != null)
                    {
                        if (line == "<HTML>")
                        {
                            goto Again;
                        }

                    }
                }

                base64 = string.Empty;
                filename = string.Empty;

                return JsonConvert.SerializeObject(new { data = base64, filename = filename });
            }
            else
            {
                return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });
            }
        }
        catch (Exception ex)
        {

            return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
        }
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string VerifyChallan(Challan challan)
    {
        TDSResponse objTDSResponse = new TDSResponse();
        try
        {
            string base64 = string.Empty;
            string filename = string.Empty;
        Again:
            objTDSResponse = this.objConnect.ChallanDownload(challan, out filename, out base64);

            if (objTDSResponse.Respons == eResponse.Success)
            {
                //Commented and added by Sharmila Start Here - 11-10-2022
                //HttpContext.Current.Session["CSI"] = base64;
                HttpContext.Current.Session["CSIFilename"] = filename;

                string[] fy = challan.finacialYear.ToString().Split('_');
                var hdnfinancialyear = fy[0] + fy[1];
                string eReturnspath = System.Web.HttpContext.Current.Server.MapPath("~/eReturns/Regular");
                string tannoPath = (eReturnspath + "\\" + challan.TAN_NO + "\\" + hdnfinancialyear);

                string fromtypepath = tannoPath + "\\" + challan.fromType;
                string QuaterPath = (fromtypepath + "\\" + challan.quaterValue);

                try
                {
                    if (Directory.Exists(QuaterPath))
                    {
                        try
                        {
                            string mcer = QuaterPath + "\\" + filename;
                            if (File.Exists(mcer))
                            {
                                File.Delete(mcer);
                            }
                            // Directory.Delete(QuaterPath, true);
                        }
                        catch (Exception ex)
                        {
                            ErrorException.LogError(ex);
                        }
                    }
                    if (!Directory.Exists(QuaterPath))
                    {
                        Directory.CreateDirectory(QuaterPath);
                    }
                    else
                    {
                        try
                        {
                            //Directory.Delete(QuaterPath, true);

                            //Directory.CreateDirectory(QuaterPath);
                        }
                        catch (Exception ex)
                        {
                            ErrorException.LogError(ex);
                        }

                    }
                    if (!Directory.Exists(QuaterPath))
                    {
                        Directory.CreateDirectory(QuaterPath);
                    }
                }
                catch (Exception ex)
                {
                    ErrorException.LogError(ex);
                }

                File.WriteAllBytes(QuaterPath + "\\" + filename.ToString(), Convert.FromBase64String(base64));
                //Commented and added by Sharmila End Here - 11-10-2022


                var fileStream = new FileStream(QuaterPath + "\\" + filename.ToString(), FileMode.Open, FileAccess.Read);
                using (var streamReader = new StreamReader(fileStream, Encoding.UTF8))
                {
                    string line;
                    while ((line = streamReader.ReadLine()) != null)
                    {
                        if (line == "<HTML>")
                        {
                            goto Again;
                        }

                    }
                }

                base64 = string.Empty;
                filename = string.Empty;

                return JsonConvert.SerializeObject(new { data = base64, filename = filename });
            }
            else
            {
                return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });
            }
        }
        catch (Exception ex)
        {

            return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
        }
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Get_chlnDetails(TracesData tracesData)
    {
        try
        {
            DataSet ds = new DataSet();
            objBAL_Traces._Company_ID = Convert.ToInt32(HttpContext.Current.Session["companyid"]);
            objBAL_Traces._FormType = tracesData.Forms;
            objBAL_Traces._Quarter = tracesData.Quarter;
            objBAL_Traces._FAYear = tracesData.FAYear;
            objBAL_Traces._Challan_ID = tracesData.ChallanId;

            ds = objBAL_Traces.Get_Challan_Details();
            return JsonConvert.SerializeObject(new
            {
                dt_Challan = DataTableToJSONWithStringBuilder(ds.Tables[0]),
                dt_Voucher = DataTableToJSONWithStringBuilder(ds.Tables[1]),
                dt_PRN = DataTableToJSONWithStringBuilder(ds.Tables[2])
            });
        }
        catch (Exception ex)
        {
            return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
        }

    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetChallan(TracesData tracesData)
    {
        try
        {
            DataSet ds = new DataSet();
            objBAL_Traces._Company_ID = Convert.ToInt32(HttpContext.Current.Session["companyid"]);
            objBAL_Traces._FormType = tracesData.Forms;
            objBAL_Traces._Quarter = tracesData.Quarter;
            objBAL_Traces._FAYear = tracesData.FAYear;

            ds = objBAL_Traces.Get_Challan();
            return JsonConvert.SerializeObject(new
            {
                dt_Challan = DataTableToJSONWithStringBuilder(ds.Tables[0])
            });
        }
        catch (Exception ex)
        {
            return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
        }

    }

    //reQTraces
    [System.Web.Services.WebMethod(EnableSession = true)]
    public string reQTraces(TracesData objTraceData, LoginTraces objLogin, string RequestType)
    {
        TDSResponse objTDSResponse = new TDSResponse();
        try
        {

            switch (RequestType)
            {
                case "FORM16A":
                    objTDSResponse = this.objConnect.RequestForDownloadForm16A(objLogin, objTraceData);
                    break;
                case "FORM16":
                    objTDSResponse = this.objConnect.RequestForDownloadForm16(objLogin, objTraceData);
                    break;
                case "FORM27D":
                    objTDSResponse = this.objConnect.RequestForDownloadForm27D(objLogin, objTraceData);
                    break;
                case "DEFAULT":
                    objTDSResponse = this.objConnect.RequestForJustificationReportDownload(objLogin, objTraceData);
                    break;
                default:
                    objTDSResponse = this.objConnect.RequestForNSDLConsoFile(objLogin, objTraceData);
                    break;
            }
            if (objTDSResponse.Respons == eResponse.Success)
            {
                return JsonConvert.SerializeObject(new { success = objTDSResponse.Message.ToString() });
            }
            else if (objTDSResponse.Respons == eResponse.Failed)
                return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });

        }
        catch (Exception ex)
        {
            return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
        }

        return JsonConvert.SerializeObject(new { error = "Failed" });

    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string reQList(LoginTraces objLogin)
    {
        try
        {
            if (!tds.T_CheckInternetConnectivty())
            {
                return JsonConvert.SerializeObject(new { error = "Internet Connectivity not found" });
            }

            TDSResponse objTDSResponse = new TDSResponse();
            DataTable dt_DownloadList = new DataTable();
            string cookie = objLogin.Cookie;

            objTDSResponse = this.objConnect.RequestForAllDownloadList_SVC(objLogin, out dt_DownloadList, out cookie);
            if (objTDSResponse.Respons == eResponse.Success)
            {
                return JsonConvert.SerializeObject(new { dt = DataTableToJSONWithStringBuilder(dt_DownloadList), cookie = cookie });
            }
            else if (objTDSResponse.Respons == eResponse.Failed)
            {
                return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });
            }

        }
        catch (Exception ex)
        {
            return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
        }
        return JsonConvert.SerializeObject(new { error = "error" });
    }

    //Requested List Download 
    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Download(string reqNo, string cookie)
    {
        try
        {
            TDSResponse objTDSResponse = new TDSResponse();
            string base64 = string.Empty;
            string filename = string.Empty;
            objTDSResponse = this.objConnect.RequestForDownloadFile_bak_SVC(reqNo, cookie, out base64, out filename);
            if (objTDSResponse.Respons == eResponse.Success)
            {
                return JsonConvert.SerializeObject(new { data = base64, filename = filename });
            }
            else
            {
                return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });
            }
        }
        catch (Exception ex)
        {
            return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
        }
    }


    /**** Status of Statement File****/
    [System.Web.Services.WebMethod(EnableSession = true)]
    public string reStatusofStatementFile(TracesData objTraceData, LoginTraces objLogin)
    {
        try
        {
            TDSResponse objTDSResponse = new TDSResponse();
            DataTable dt_DownloadList = new DataTable();
            string cookie = objLogin.Cookie;

            objTDSResponse = this.objConnect.RequestForStatusofStatementFile(objLogin, objTraceData, out dt_DownloadList);
            if (objTDSResponse.Respons == eResponse.Success)
            {
                return JsonConvert.SerializeObject(new { dt = DataTableToJSONWithStringBuilder(dt_DownloadList), cookie = cookie });
            }
            else
            {
                return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });
            }

        }
        catch (Exception ex)
        {
            return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
        }


    }
    /**** Default Summary ****/
    [System.Web.Services.WebMethod(EnableSession = true)]
    public string reDefaultSummary(TracesData objTraceData, LoginTraces objLogin)
    {
        try
        {
            TDSResponse objTDSResponse = new TDSResponse();
            DataTable dt_DownloadList = new DataTable();
            string cookie = objLogin.Cookie;

            objTDSResponse = this.objConnect.RequestForDefaultSummary(objLogin, objTraceData, out dt_DownloadList);
            if (objTDSResponse.Respons == eResponse.Success)
            {
                return JsonConvert.SerializeObject(new { dt = DataTableToJSONWithStringBuilder(dt_DownloadList), cookie = cookie });
            }
            else
            {
                return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });
            }

        }
        catch (Exception ex)
        {
            return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
        }


    }
    /**** Default Summary ****/
    [System.Web.Services.WebMethod(EnableSession = true)]
    public string reTCSTDSCredit(TracesData objTraceData, string date, LoginTraces objLogin)
    {
        try
        {
            TDSResponse objTDSResponse = new TDSResponse();
            string cookie = objLogin.Cookie;

            DataTable dtStatementdtls = new DataTable();
            string deducteeDtls = string.Empty;

            objTDSResponse = this.objConnect.RequestTDSTCSCredit(objLogin, objTraceData, date, out dtStatementdtls, out deducteeDtls);
            if (objTDSResponse.Respons == eResponse.Success)
            {
                return JsonConvert.SerializeObject(new
                {
                    dtStatementdtls = DataTableToJSONWithStringBuilder(dtStatementdtls),
                    dtDeducteeDetails = deducteeDtls,
                    cookie = cookie
                });
            }
            else
            {
                return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });
            }

        }
        catch (Exception ex)
        {
            return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
        }


    }

    public HttpContext Context
    {
        get
        {
            return HttpContext.Current;
        }
    }
    public HttpRequest Request
    {
        get
        {
            return HttpContext.Current.Request;
        }
    }
    public static string DataTableToJSONWithStringBuilder(DataTable table)
    {
        JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
        List<Dictionary<string, object>> parentRow = new List<Dictionary<string, object>>();
        Dictionary<string, object> childRow;
        foreach (DataRow row in table.Rows)
        {
            childRow = new Dictionary<string, object>();
            foreach (DataColumn col in table.Columns)
            {
                childRow.Add(col.ColumnName, row[col]);
            }
            parentRow.Add(childRow);
        }
        return jsSerializer.Serialize(parentRow);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string BulkPAN(string Pan)
    {

        try
        {

            bool VPan = false;
            VPan = this.objConnect.IsValidPAN(Pan);

            //if (objTDSResponse.Respons == eResponse.Success)
            //{
            //    HttpContext.Current.Session["CSI"] = base64;
            //    HttpContext.Current.Session["CSIFilename"] = filename;

            //    base64 = string.Empty;
            //    filename = string.Empty;

            return JsonConvert.SerializeObject(new { data = VPan });
            //}
            //else
            //{
            //    return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });
            //}
        }
        catch (Exception ex)
        {
            return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
        }


    }


    //197 certificate verification
    [System.Web.Services.WebMethod(EnableSession = true)]
    public string req197Certification(TracesData objTraceData, LoginTraces objLogin)
    {
        TDSResponse objTDSResponse = new TDSResponse();
        try
        {

            objTDSResponse = this.objConnect.RequestFor197CertificateVerification(objLogin, objTraceData);

            if (objTDSResponse.Respons == eResponse.Success)
            {
                return JsonConvert.SerializeObject(new { success = objTDSResponse.CustomeTypes });
            }
            else if (objTDSResponse.Respons == eResponse.Failed)
                return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });

        }
        catch (Exception ex)
        {
            return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
        }

        return JsonConvert.SerializeObject(new { error = "Failed" });

    }

    //PAN verify
    [System.Web.Services.WebMethod(EnableSession = true)]
    public string reqPANVerify(TracesData objTraceData, LoginTraces objLogin)
    {
        TDSResponse objTDSResponse = new TDSResponse();
        try
        {

            objTDSResponse = this.objConnect.RequestForPANVerify(objLogin, objTraceData);

            if (objTDSResponse.Respons == eResponse.Success)
            {
                return JsonConvert.SerializeObject(new { success = objTDSResponse.CustomeTypes });
            }
            else if (objTDSResponse.Respons == eResponse.Failed)
                return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });

        }
        catch (Exception ex)
        {
            return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
        }

        return JsonConvert.SerializeObject(new { error = "Failed" });

    }



    //PAN verify
    [System.Web.Services.WebMethod(EnableSession = true)]
    public string BulkPANVerify(TracesData objTraceData, LoginTraces objLogin)
    {
        TDSResponse objTDSResponse = new TDSResponse();
        try
        {
            BAL_BulkPan_Verification_AllVoucher obj = new BAL_BulkPan_Verification_AllVoucher();
            obj.Company_ID = objTraceData.Compid;
            obj.Verfy = objTraceData.PAN1;
            DataSet ds = obj.BAL_SalaryPANVerification();
            if (ds.Tables[0].Rows.Count > 0)
            {
                objTDSResponse = this.objConnect.RequestForTraces_Login(objLogin );
                if (objTDSResponse.Respons == eResponse.Success)

                    foreach (DataRow dr in ds.Tables[0].Rows)
                    { string PAN = "";
                        PAN = dr["PAN"].ToString();
                        objTDSResponse = this.objConnect.RequestForBulKPANVerify_Salary(objTraceData, PAN);
                        if (objTDSResponse.Respons == eResponse.Failed)
                        {
                            return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });
                        }
                        if (objTDSResponse.Respons == eResponse.SessionTimeout)
                        {
                            return JsonConvert.SerializeObject(new { timeout = objTDSResponse.Respons });
                        }
                    }

                if (objTDSResponse.Respons == eResponse.Success)
                {
                    return JsonConvert.SerializeObject(new { success = objTDSResponse.CustomeTypes });
                }
                if (objTDSResponse.Respons == eResponse.SessionTimeout)
                {
                    return JsonConvert.SerializeObject(new { timeout = objTDSResponse.Respons });
                }
                else if (objTDSResponse.Respons == eResponse.Failed)
                {
                    return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });
                }
            }

        }
        catch (Exception ex)
        {
            return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
        }

        return JsonConvert.SerializeObject(new { error = "Failed" });

    }




    [System.Web.Services.WebMethod(EnableSession = true)]
    public string BulkPANVerify_NonSal(TracesData objTraceData, LoginTraces objLogin)
    {
        TDSResponse objTDSResponse = new TDSResponse();
        try
        {
            BAL_BulkPan_Verification_AllVoucher obj = new BAL_BulkPan_Verification_AllVoucher();
            obj.Company_ID = objTraceData.Compid;
            obj.Verfy = objTraceData.PAN1;
            DataSet ds = obj.BAL_GetAllCompanyVoucherVerification();
            if (ds.Tables[0].Rows.Count > 0)
            {
                objTDSResponse = this.objConnect.RequestForTraces_Login(objLogin );
                if (objTDSResponse.Respons == eResponse.Success)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    { string PAN = "";
                        PAN = dr["Pan"].ToString();
                        objTDSResponse = this.objConnect.RequestForBulKPANStatus_NonSal(objTraceData, PAN);
                        if (objTDSResponse.Respons == eResponse.Failed)
                        {
                            return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });
                        }
                        if (objTDSResponse.Respons == eResponse.SessionTimeout)
                        {
                            return JsonConvert.SerializeObject(new { timeout = objTDSResponse.Respons });
                        }
                    }

                    if (objTDSResponse.Respons == eResponse.Success)
                    {
                        return JsonConvert.SerializeObject(new { success = objTDSResponse.CustomeTypes });
                    }
                    if (objTDSResponse.Respons == eResponse.SessionTimeout)
                    {
                        return JsonConvert.SerializeObject(new { timeout = objTDSResponse.Respons });
                    }
                    else if (objTDSResponse.Respons == eResponse.Failed)
                    {
                        return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });
                    }
                }

            }
        }
        catch (Exception ex)
        {
            return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
        }

        return JsonConvert.SerializeObject(new { error = objTDSResponse.Respons + " " + objTDSResponse.Message.ToString() });

    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Challan_Traces(TracesData objTraceData, LoginTraces objLogin)
    {
        BAL_ManageSalary_ChallanList obj = new BAL_ManageSalary_ChallanList();
        TDSResponse objTDSResponse = new TDSResponse();
        try
        {
            //BAL_BulkPan_Verification_AllVoucher obj = new BAL_BulkPan_Verification_AllVoucher();
            obj.CompanyID = objTraceData.Compid;
            obj.Quarter = objTraceData.Quarter;
            obj.FromType = objTraceData.Forms;
            //obj.Verfy = "InValid PAN";
            DataSet ds;
            if (objTraceData.Forms != "24Q")
            {
                if (objTraceData.Forms == "27Q(NRI)")
                {
                    obj.FromType = "27Q";
                }
                if (objTraceData.Forms == "27EQ(TCS)")
                {
                    obj.FromType = "27EQ";
                }


                ds = obj.Get_Challan_Non_Salary();
            }
            else
            {
                ds = obj.Get_Challan_Salary();
            }
            if (ds.Tables[0].Rows.Count > 0)
            {
                objTDSResponse = this.objConnect.RequestForTraces_Login(objLogin);
                if (objTDSResponse.Respons == eResponse.Success)
                {

                    objTDSResponse = this.objConnect.CIN_Period_Payment(objTraceData);
                    string chlsts = "";
                    if (objTDSResponse.Respons == eResponse.Success)
                    {
                        if (objTDSResponse.DTable != null)
                        {
                            foreach (DataRow dr in ds.Tables[0].Rows)
                            {
                                string cdt = "";
                                string s = dr["Challan_id"].ToString();
                                string c = dr["Challan_no"].ToString();
                                cdt = dr["Cdate"].ToString();

                                string bsr = dr["Bank_Bsrcode"].ToString();
                                string cm = dr["Challan_amount"].ToString();
                                string ccl = "";
                                foreach (DataRow ddr in objTDSResponse.DTable.Rows)
                                {
                                    string bc = ddr["bankCode"].ToString();
                                    string bsc = ddr["branchCode"].ToString();
                                    string camt = ddr["chlnAmt"].ToString();
                                    string csn = ddr["chlnSNo"].ToString();
                                    string cst = ddr["chlnStatus"].ToString();
                                    string cdd = ddr["dateOfDep"].ToString();
                                    string obsr = bc + bsc;
                                    if (c == csn && cdt == cdd && bsr == obsr)
                                    {
                                        cst = "Matched " + cst;

                                        if (obj.FromType == "24Q")
                                        {
                                            ccl = "Sal";
                                        }
                                        else
                                        {
                                            ccl = "Non";
                                        }
                                        chlsts = chlsts + s + "," + cst + "," + ccl + "^";
                                        break;
                                    }
                                }

                            }
                            obj.Result = chlsts;
                            DataSet dset = obj.BAL_Challan_Verify();

                            return JsonConvert.SerializeObject(new { success = objTDSResponse.CustomeTypes });
                        }
                        else
                        {
                            objTDSResponse.Message = "Cannot connect to traces or no records found";
                            return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });
                        }
                    }

                    if (objTDSResponse.Respons == eResponse.SessionTimeout)
                    {
                        return JsonConvert.SerializeObject(new { timeout = objTDSResponse.Respons });
                    }
                    else if (objTDSResponse.Respons == eResponse.Failed)
                    {
                        return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });
                    }
                }

            }
        }
        catch (Exception ex)
        {
            return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
        }

        return JsonConvert.SerializeObject(new { error = objTDSResponse.Respons + " " + objTDSResponse.Message.ToString() });

    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Import_Challan_Traces(TracesData objTraceData, LoginTraces objLogin)
    {
        BAL_ManageSalary_ChallanList obj = new BAL_ManageSalary_ChallanList();
        TDSResponse objTDSResponse = new TDSResponse();
         
        try
        {
            //BAL_BulkPan_Verification_AllVoucher obj = new BAL_BulkPan_Verification_AllVoucher();
            obj.CompanyID = objTraceData.Compid;
            obj.Quarter = objTraceData.Quarter;
            obj.FromType = objTraceData.Forms;
            //obj.Verfy = "InValid PAN";


            objTDSResponse = this.objConnect.RequestForTraces_Login(objLogin);
            if (objTDSResponse.Respons == eResponse.Success)
            {
                objTDSResponse = this.objConnect.CIN_Period_Payment(objTraceData);
                string chlsts = "";
                if (objTDSResponse.Respons == eResponse.Success)
                {
                    if (objTDSResponse.DTable != null)
                    {
                        //foreach (DataRow ddr in objTDSResponse.DTable.Rows)
                        //{
                        //    string bc = ddr["bankCode"].ToString();
                        //    string bsc = ddr["branchCode"].ToString();
                        //    string camt = ddr["chlnAmt"].ToString();
                        //    string csn = ddr["chlnSNo"].ToString();
                        //    string cst = ddr["chlnStatus"].ToString();
                        //    string cdd = ddr["dateOfDep"].ToString();
                        //    string obsr = bc + bsc;


                        //    //chlsts = chlsts + s + "," + cst + "," + ccl + "^";


                        //}

                        this.objConnect.Logoff();
                        return JsonConvert.SerializeObject(new { success = objTDSResponse.CustomeTypes });

                    }
                    else
                    {
                        objTDSResponse.Message = "Cannot connect to traces or no records found";
                        return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });
                    }
                }

                if (objTDSResponse.Respons == eResponse.SessionTimeout)
                {
                    return JsonConvert.SerializeObject(new { timeout = objTDSResponse.Respons });
                }
                else if (objTDSResponse.Respons == eResponse.Failed)
                {
                    return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });
                }
            }


        }
        catch (Exception ex)
        {
            return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
        }

        return JsonConvert.SerializeObject(new { error = objTDSResponse.Respons + ", " + objTDSResponse.Message.ToString() });

    }


    /// /////////////////////////////////////Challan Consumpution

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Challan_Consumpution(TracesData objTraceData, LoginTraces objLogin)
    {
        BAL_ManageSalary_ChallanList obj = new BAL_ManageSalary_ChallanList();
        TDSResponse objTDSResponse = new TDSResponse();
        try
        {
            //BAL_BulkPan_Verification_AllVoucher obj = new BAL_BulkPan_Verification_AllVoucher();
            obj.CompanyID = objTraceData.Compid;
            obj.Quarter = objTraceData.Quarter;
            obj.FromType = objTraceData.Forms;



            string chlsts = "";

            objTDSResponse = this.objConnect.RequestForTraces_Login(objLogin);
            if (objTDSResponse.Respons == eResponse.Success)
            {

                objTDSResponse = this.objConnect.CIN_CIN_BINParticulars(objTraceData, chlsts);
                if (objTDSResponse.Respons == eResponse.Success)
                {
                }


                obj.Result = chlsts;
                DataSet dset = obj.BAL_Challan_Verify();
            }
            return JsonConvert.SerializeObject(new { success = objTDSResponse.CustomeTypes });






            //if (objTDSResponse.Respons == eResponse.SessionTimeout)
            //{
            //    return JsonConvert.SerializeObject(new { timeout = objTDSResponse.Respons });
            //}
            //else if (objTDSResponse.Respons == eResponse.Failed)
            //{
            //    return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });
            //}

        }
        catch (Exception ex)
        {
            return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
        }

        return JsonConvert.SerializeObject(new { error = objTDSResponse.Respons + " " + objTDSResponse.Message.ToString() });

    }





    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Validate_Certificate_Traces(PAN_Fyear objCertData, LoginTraces objLogin)
    {
        BAL_ManageSalary_ChallanList obj = new BAL_ManageSalary_ChallanList();
        TDSResponse objTDSResponse = new TDSResponse();
        try
        {
            //BAL_BulkPan_Verification_AllVoucher obj = new BAL_BulkPan_Verification_AllVoucher();
            obj.CompanyID = objTraceData.Compid;

            objTDSResponse = this.objConnect.RequestForTraces_Login(objLogin);
            if (objTDSResponse.Respons == eResponse.Success)
            {
                objTDSResponse = this.objConnect.RequestForCertificate197(objCertData);
                if (objTDSResponse.Respons == eResponse.Failed)
                {
                    return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });
                }
                if (objTDSResponse.Respons == eResponse.SessionTimeout)
                {
                    return JsonConvert.SerializeObject(new { timeout = objTDSResponse.Respons });
                }


                if (objTDSResponse.Respons == eResponse.Success)
                {
                    return JsonConvert.SerializeObject(new { success = objTDSResponse.CustomeTypes });
                }
                if (objTDSResponse.Respons == eResponse.SessionTimeout)
                {
                    return JsonConvert.SerializeObject(new { timeout = objTDSResponse.Respons });
                }
                else if (objTDSResponse.Respons == eResponse.Failed)
                {
                    return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });
                }
            }


        }
        catch (Exception ex)
        {
            return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
        }

        return JsonConvert.SerializeObject(new { error = objTDSResponse.Respons + " " + objTDSResponse.Message.ToString() });

    }



    [System.Web.Services.WebMethod(EnableSession = true)]
    public string ITAXDownChallan(Challan challan)
    {
        TDSResponse objTDSResponse = new TDSResponse();
        IncomeTAX_Service CSIChallan = new IncomeTAX_Service();
        try
        {
            string base64 = string.Empty;
            string filename = string.Empty;
        Again:

            objTDSResponse = CSIChallan.DownloadCSI(challan.TAN_NO, challan.appUser, challan.FrDT, challan.ToDT, out filename, out base64);

            if (objTDSResponse.Respons == eResponse.Success)
            {
                //Commented and added by Sharmila Start Here - 11-10-2022
                //HttpContext.Current.Session["CSI"] = base64;
                HttpContext.Current.Session["CSIFilename"] = filename;

                string[] fy = challan.finacialYear.ToString().Split('_');
                var hdnfinancialyear = fy[0] + fy[1];
                string eReturnspath = System.Web.HttpContext.Current.Server.MapPath("~/eReturns/Regular");
                string tannoPath = (eReturnspath + "\\" + challan.TAN_NO + "\\" + hdnfinancialyear);

                string fromtypepath = tannoPath + "\\" + challan.fromType;
                string QuaterPath = (fromtypepath + "\\" + challan.quaterValue);

                try
                {
                    if (Directory.Exists(QuaterPath))
                    {
                        try
                        {
                            string mcer = QuaterPath + "\\e-mudhra.cer";
                            if (File.Exists(mcer))
                            {
                                File.Delete(mcer);
                            }
                            Directory.Delete(QuaterPath, true);
                        }
                        catch (Exception ex)
                        {
                            ErrorException.LogError(ex);
                        }
                    }
                    if (!Directory.Exists(QuaterPath))
                    {
                        Directory.CreateDirectory(QuaterPath);
                    }
                    else
                    {
                        try
                        {
                            Directory.Delete(QuaterPath, true);

                            Directory.CreateDirectory(QuaterPath);
                        }
                        catch (Exception ex)
                        {
                            ErrorException.LogError(ex);
                        }

                    }
                    if (!Directory.Exists(QuaterPath))
                    {
                        Directory.CreateDirectory(QuaterPath);
                    }
                }
                catch (Exception ex)
                {
                    ErrorException.LogError(ex);
                }

                File.WriteAllBytes(QuaterPath + "\\" + filename.ToString(), Convert.FromBase64String(base64));
                //Commented and added by Sharmila End Here - 11-10-2022


                var fileStream = new FileStream(QuaterPath + "\\" + filename.ToString(), FileMode.Open, FileAccess.Read);
                using (var streamReader = new StreamReader(fileStream, Encoding.UTF8))
                {
                    string line;
                    while ((line = streamReader.ReadLine()) != null)
                    {
                        if (line == "<HTML>")
                        {
                            goto Again;
                        }

                    }
                }

                base64 = string.Empty;
                filename = string.Empty;

                return JsonConvert.SerializeObject(new { data = base64, filename = filename });
            }
            else
            {
                return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });
            }
        }
        catch (Exception ex)
        {

            return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
        }
    }



    [System.Web.Services.WebMethod(EnableSession = true)]
    public string ITAXChallanOTP(Challan challan)
    {
        TDSResponse objTDSResponse = new TDSResponse();
        IncomeTAX_Service CSIChallan = new IncomeTAX_Service();

        try
        {
            objTDSResponse = CSIChallan.DownloadCSIOTP(challan.TAN_NO, challan.MobileN);

            if (objTDSResponse.Respons == eResponse.Success)
            {
                return JsonConvert.SerializeObject(new { objTDSResponse});
            }
            else
            {
                objTDSResponse.URefid = "";
                objTDSResponse.URqid = "";
                return JsonConvert.SerializeObject(new { error = objTDSResponse });
            }
        }
        catch (Exception ex)
        {

            objTDSResponse.URefid = "";
            objTDSResponse.URqid = "";
            objTDSResponse.Respons = eResponse.Failed;
            objTDSResponse.Message = "Error";
            return JsonConvert.SerializeObject(new { error = objTDSResponse });
        }
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string ITAXOtpChallanValidation(Challan challan)
    {
        TDSResponse objTDSResponse = new TDSResponse();
        IncomeTAX_Service CSIChallan = new IncomeTAX_Service();
        try
        {
            objTDSResponse = CSIChallan.DownloadCSIOTPValidation(challan.OTPN, challan.TAN_NO, challan.RefId, challan.ReQId);

            if (objTDSResponse.Respons == eResponse.Success)
            {
                string base64 = string.Empty;
                string filename = string.Empty;

                string TAN = challan.TAN_NO;
                filename = TAN + DateTime.Now.ToString("ddMMyy") + ".csi";
                objTDSResponse = CSIChallan.DownloadCSIFileByOTP(challan.TAN_NO, challan.FrDT, challan.ToDT, challan.ReQId ) ;
                HttpContext.Current.Session["CSIFilename"] = filename;
                HttpContext.Current.Session["CSI"] = objTDSResponse.Message.ToString();
                //string[] fy = challan.finacialYear.ToString().Split('_');
                //var hdnfinancialyear = fy[0] + fy[1];
                //string eReturnspath = System.Web.HttpContext.Current.Server.MapPath("~/eReturns/Regular");
                //string tannoPath = (eReturnspath + "\\" + challan.TAN_NO + "\\" + hdnfinancialyear);

                //string fromtypepath = tannoPath + "\\" + challan.fromType;
                //string QuaterPath = (fromtypepath + "\\" + challan.quaterValue);

                //try
                //{
                //    if (Directory.Exists(QuaterPath))
                //    {
                //        try
                //        {
                //            string mcer = QuaterPath + "\\e-mudhra.cer";
                //            if (File.Exists(mcer))
                //            {
                //                File.Delete(mcer);
                //            }
                //            Directory.Delete(QuaterPath, true);
                //        }
                //        catch (Exception ex)
                //        {
                //            ErrorException.LogError(ex);
                //        }
                //    }
                //    if (!Directory.Exists(QuaterPath))
                //    {
                //        Directory.CreateDirectory(QuaterPath);
                //    }
                //    else
                //    {
                //        try
                //        {
                //            Directory.Delete(QuaterPath, true);

                //            Directory.CreateDirectory(QuaterPath);
                //        }
                //        catch (Exception ex)
                //        {
                //            ErrorException.LogError(ex);
                //        }

                //    }
                //    if (!Directory.Exists(QuaterPath))
                //    {
                //        Directory.CreateDirectory(QuaterPath);
                //    }
                //}
                //catch (Exception ex)
                //{
                //    ErrorException.LogError(ex);
                //}

                //using (FileStream fileStream = new FileStream(QuaterPath, FileMode.OpenOrCreate, FileAccess.Write, FileShare.Write))
                //{
                //    StreamWriter streamWriter = new StreamWriter((Stream)fileStream);
                //    streamWriter.Write(objTDSResponse.Message);
                //    streamWriter.Flush();
                //    streamWriter.Close();
                //    fileStream.Close();
                //}

                return JsonConvert.SerializeObject(new { data = objTDSResponse.Message, filename = filename });


            }
            else
            {
                return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });
            }
        }
        catch (Exception ex)
        {

            return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
        }
    }


    //[OperationContract]
    //public string ITAXDownOTPChallan(Challan challan)
    //{
    //    TDSResponse objTDSResponse = new TDSResponse();
    //    IncomeTAX_Service CSIChallan = new IncomeTAX_Service();
    //    try
    //    {
    //        string base64 = string.Empty;
    //        string filename = string.Empty;
    //    Again:

    //        objTDSResponse = CSIChallan.DownloadCSIFileByOTP(challan.TAN_NO, challan.FrDT, challan.ToDT );

    //        if (objTDSResponse.Respons == eResponse.Success)
    //        {
    //            //Commented and added by Sharmila Start Here - 11-10-2022
    //            //HttpContext.Current.Session["CSI"] = base64;
    //            HttpContext.Current.Session["CSIFilename"] = filename;

    //            string[] fy = challan.finacialYear.ToString().Split('_');
    //            var hdnfinancialyear = fy[0] + fy[1];
    //            string eReturnspath = System.Web.HttpContext.Current.Server.MapPath("~/eReturns/Regular");
    //            string tannoPath = (eReturnspath + "\\" + challan.TAN_NO + "\\" + hdnfinancialyear);

    //            string fromtypepath = tannoPath + "\\" + challan.fromType;
    //            string QuaterPath = (fromtypepath + "\\" + challan.quaterValue);

    //            try
    //            {
    //                if (Directory.Exists(QuaterPath))
    //                {
    //                    try
    //                    {
    //                        string mcer = QuaterPath + "\\e-mudhra.cer";
    //                        if (File.Exists(mcer))
    //                        {
    //                            File.Delete(mcer);
    //                        }
    //                        Directory.Delete(QuaterPath, true);
    //                    }
    //                    catch (Exception ex)
    //                    {
    //                        ErrorException.LogError(ex);
    //                    }
    //                }
    //                if (!Directory.Exists(QuaterPath))
    //                {
    //                    Directory.CreateDirectory(QuaterPath);
    //                }
    //                else
    //                {
    //                    try
    //                    {
    //                        Directory.Delete(QuaterPath, true);

    //                        Directory.CreateDirectory(QuaterPath);
    //                    }
    //                    catch (Exception ex)
    //                    {
    //                        ErrorException.LogError(ex);
    //                    }

    //                }
    //                if (!Directory.Exists(QuaterPath))
    //                {
    //                    Directory.CreateDirectory(QuaterPath);
    //                }
    //            }
    //            catch (Exception ex)
    //            {
    //                ErrorException.LogError(ex);
    //            }

    //            File.WriteAllBytes(QuaterPath + "\\" + filename.ToString(), Convert.FromBase64String(base64));
    //            //Commented and added by Sharmila End Here - 11-10-2022


    //            var fileStream = new FileStream(QuaterPath + "\\" + filename.ToString(), FileMode.Open, FileAccess.Read);
    //            using (var streamReader = new StreamReader(fileStream, Encoding.UTF8))
    //            {
    //                string line;
    //                while ((line = streamReader.ReadLine()) != null)
    //                {
    //                    if (line == "<HTML>")
    //                    {
    //                        goto Again;
    //                    }

    //                }
    //            }

    //            base64 = string.Empty;
    //            filename = string.Empty;

    //            return JsonConvert.SerializeObject(new { data = base64, filename = filename });
    //        }
    //        else
    //        {
    //            return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });
    //        }
    //    }
    //    catch (Exception ex)
    //    {

    //        return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
    //    }
    //}



    //[OperationContract]
    //public string BulkPANVerify_NonSal(TracesData objTraceData, LoginTraces objLogin)
    //{
    //    TDSResponse objTDSResponse = new TDSResponse();
    //    try
    //    {
    //        BAL_BulkPan_Verification_AllVoucher obj = new BAL_BulkPan_Verification_AllVoucher();
    //        obj.Company_ID = objTraceData.Compid;
    //        obj.Verfy = "InValid PAN";
    //        DataSet ds = obj.BAL_GetAllCompanyVoucherVerification();
    //        if (ds.Tables[0].Rows.Count > 0)
    //        {
    //            objTDSResponse = this.objConnect.RequestForBulKPANVerify_NonSal(objLogin, objTraceData, ds);

    //            if (objTDSResponse.Respons == eResponse.Success)
    //            {
    //                return JsonConvert.SerializeObject(new { success = objTDSResponse.CustomeTypes });
    //            }
    //            if (objTDSResponse.Respons == eResponse.SessionTimeout)
    //            {
    //                return JsonConvert.SerializeObject(new { timeout = objTDSResponse.Respons });
    //            }
    //            else if (objTDSResponse.Respons == eResponse.Failed)
    //            {
    //                return JsonConvert.SerializeObject(new { error = objTDSResponse.Message.ToString() });
    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        return JsonConvert.SerializeObject(new { error = ex.Message.ToString() });
    //    }

    //    return JsonConvert.SerializeObject(new { error = "Failed" });

    //}


}
