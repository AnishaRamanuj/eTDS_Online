

using BusinessLayer;
using HtmlAgilityPack;
using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Configuration;
using System.Net.Security;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using PANVrf;

public class ConnectTR
{
    private string strURL = "";
    private HttpWebRequest request = (HttpWebRequest)null;
    private HttpWebResponse response = (HttpWebResponse)null;
    private Stream dataStream = (Stream)null;
    private StreamReader reader = (StreamReader)null;
    private string strServerResponse = "";
    private CookieContainer objContainer = new CookieContainer();
    private List<RecData<int, string, string>> objMsgDictionary = new List<RecData<int, string, string>>();
    private string strBaseURL = "https://www.tdscpc.gov.in/app/";
    private string strCaptchBaseURL = "https://www.tdscpc.gov.in/app/srv/";
    private string strChallanBaseURL = "https://tin.tin.nsdl.com/oltas/servlet/";
    private bool bnlSessionExists = false;
    private StringBuilder objParam = new StringBuilder();
    private bool disposedValue = false;
    private Cookie cookie = new Cookie();
    public bool IsSessionExists
    {
        get
        {
            return this.bnlSessionExists;
        }
        set
        {
            this.bnlSessionExists = true;
        }
    }

    public TDSResponse IsChallanExistsInConsolidate(
      TracesData objTraceData,
      LoginTraces objLogin)
    {
        TDSResponse tracesResponse1 = new TDSResponse();
        tracesResponse1.Respons = eResponse.Success;
        if (!this.bnlSessionExists)
        {
            tracesResponse1 = this.makeLoginToTRACES(objLogin);
            if (tracesResponse1.Respons == eResponse.Failed)
                return tracesResponse1;
        }
        this.strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "ded/nsdlconsofile.xhtml");
        if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"requestnsdlconsoForm\"]"))
        {
            tracesResponse1.Message = "Server Error";
            tracesResponse1.Respons = eResponse.SessionTimeout;
            return tracesResponse1;
        }
        TDSResponse tracesResponse2 = this.IsServerError(this.strServerResponse, "//span[@id=\"err_Summary\"]");
        if (tracesResponse2.Respons == eResponse.Failed)
        {
            tracesResponse2.Message = "Server Error";
            tracesResponse2.Respons = eResponse.Failed;
            return tracesResponse2;
        }
        StringBuilder sbData = new StringBuilder();
        sbData.Append("finYr=" + objTraceData.FAYear);
        sbData.Append("&qrtr=" + objTraceData.Quarter);
        sbData.Append("&frmType=" + objTraceData.Forms);
        sbData.Append("&download_conso=Go");
        sbData.Append("&requestnsdlconsoForm_SUBMIT=1");
        Dictionary<string, string> dictionary1 = this.TraceViewStateData(this.strServerResponse, "//form[@id=\"requestnsdlconsoForm\"]");
        if (dictionary1.Count <= 0)
        {
            tracesResponse2.Message = "Server Error";
            tracesResponse2.Respons = eResponse.SessionTimeout;
            return tracesResponse2;
        }
        foreach (KeyValuePair<string, string> keyValuePair in dictionary1)
            sbData.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
        this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "ded/nsdlconsofile.xhtml", sbData);
        TDSResponse tracesResponse3 = this.IsServerError(this.strServerResponse, "//ul[@id=\"err_Summary\"]");
        if (tracesResponse3.Respons == eResponse.Failed)
        {
            this.Logoff();
            return tracesResponse3;
        }
        Dictionary<string, string> dictionary2 = this.TraceViewStateData(this.strServerResponse, "//form[@id=\"dedkyc\"]");
        tracesResponse3.CustomeTypes = (object)dictionary2;
        return tracesResponse3;
    }

    public TDSResponse IsChallanExistsInDefaults(
      TracesData objTraceData,
      LoginTraces objLogin)
    {
        TDSResponse tracesResponse1 = new TDSResponse();
        tracesResponse1.Respons = eResponse.Success;
        if (!this.bnlSessionExists)
        {
            tracesResponse1 = this.makeLoginToTRACES(objLogin);
            if (tracesResponse1.Respons == eResponse.Failed)
                return tracesResponse1;
        }
        this.strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "ded/justrepdwnld.xhtml");
        if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"justificationForm\"]"))
        {
            tracesResponse1.Message = "Server Error";
            tracesResponse1.Respons = eResponse.SessionTimeout;
            return tracesResponse1;
        }
        TDSResponse tracesResponse2 = this.IsServerError(this.strServerResponse, "//span[@id=\"err_Summary\"]");
        if (tracesResponse2.Respons == eResponse.Failed)
        {
            tracesResponse2.Message = "Server Error";
            tracesResponse2.Respons = eResponse.Failed;
            return tracesResponse2;
        }
        StringBuilder sbData = new StringBuilder();
        sbData.Append("finYr=" + objTraceData.FAYear);
        sbData.Append("&qrtr=" + objTraceData.Quarter);
        sbData.Append("&frmType=" + objTraceData.Forms);
        sbData.Append("&download_justReport=Go");
        Dictionary<string, string> dictionary1 = this.TraceViewStateData(this.strServerResponse, "//form[@id=\"justificationForm\"]");
        if (dictionary1.Count <= 0)
        {
            tracesResponse2.Message = "Server Error";
            tracesResponse2.Respons = eResponse.SessionTimeout;
            return tracesResponse2;
        }
        foreach (KeyValuePair<string, string> keyValuePair in dictionary1)
        {
            if (keyValuePair.Key == "javax.faces.ViewState")
                sbData.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
        }
        this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "ded/justrepdwnld.xhtml", sbData);
        TDSResponse tracesResponse3 = this.IsServerError(this.strServerResponse, "//ul[@id=\"err_Summary\"]");
        if (tracesResponse3.Respons == eResponse.Failed)
        {
            this.Logoff();
            return tracesResponse3;
        }
        Dictionary<string, string> dictionary2 = this.TraceViewStateData(this.strServerResponse, "//form[@id=\"justificationForm\"]");
        tracesResponse3.CustomeTypes = (object)dictionary2;
        return tracesResponse3;
    }

    public TDSResponse IsChallanExistsInForm16(
      TracesData objTraceData,
      LoginTraces objLogin)
    {
        TDSResponse tracesResponse1 = new TDSResponse();
        tracesResponse1.Respons = eResponse.Success;
        if (!this.IsSessionExists)
        {
            tracesResponse1 = this.makeLoginToTRACES(objLogin);
            if (tracesResponse1.Respons == eResponse.Failed)
                return tracesResponse1;
        }
        string request = this.makeHTTPGetRequest(this.strBaseURL + "ded/download16.xhtml");
        if (!this.IsStringExists(request, "//form[@id=\"bulkPan\"]"))
        {
            tracesResponse1.Message = "Server Error";
            tracesResponse1.Respons = eResponse.SessionTimeout;
            this.Logoff();
            return tracesResponse1;
        }
        StringBuilder sbData1 = new StringBuilder();
        sbData1.Append("dwnldFormBulkType=13");
        sbData1.Append("&bulkfinYr=" + objTraceData.FAYear);
        sbData1.Append("&bulkGo=Go");
        sbData1.Append("&bulkPan_SUBMIT=1");
        Dictionary<string, string> dictionary1 = this.TraceViewStateData(request, "//form[@id=\"bulkPan\"]");
        if (dictionary1.Count <= 0)
        {
            tracesResponse1.Message = "Server Error";
            tracesResponse1.Respons = eResponse.SessionTimeout;
            this.Logoff();
            return tracesResponse1;
        }
        foreach (KeyValuePair<string, string> keyValuePair in dictionary1)
        {
            if (keyValuePair.Key == "javax.faces.ViewState")
            {
                sbData1.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
                break;
            }
        }
        string str1 = this.makeHTTPPostRequest(this.strBaseURL + "ded/download16.xhtml", sbData1);
        TDSResponse tracesResponse2 = this.IsServerError(str1, "//ul[@id=\"err_Summary\"]");
        if (tracesResponse2.Respons == eResponse.Failed)
        {
            tracesResponse2.Respons = eResponse.Failed;
            return tracesResponse2;
        }
        if (!this.IsStringExists(str1, "//form[@id=\"deducteeDetails\"]") && !this.IsStringExists(this.strServerResponse, "//form[@id=\"tabContentForm\"]"))
        {
            tracesResponse2.Message = "Server Error";
            tracesResponse2.Respons = eResponse.Failed;
            return tracesResponse2;
        }
        if (this.IsStringExists(this.strServerResponse, "//form[@id=\"tabContentForm\"]"))
        {
            Dictionary<string, string> dictionary2 = this.TraceViewStateData(this.strServerResponse, "//form[@id=\"tabContentForm\"]");
            if (dictionary2.Count <= 0)
            {
                tracesResponse2.Message = "Server Error";
                tracesResponse2.Respons = eResponse.Failed;
                return tracesResponse2;
            }
            string str2 = "qr=6";
            StringBuilder stringBuilder = new StringBuilder();
            foreach (KeyValuePair<string, string> keyValuePair in dictionary2)
            {
                if (keyValuePair.Key == "frmType")
                    str2 = str2 + "&ft=" + HttpUtility.UrlEncode(keyValuePair.Value);
                else if (keyValuePair.Key == "finYear")
                    str2 = str2 + "&fy=" + HttpUtility.UrlEncode(keyValuePair.Value);
                else if (keyValuePair.Key == "dwnldType")
                    str2 = str2 + "&download=" + HttpUtility.UrlEncode(keyValuePair.Value);
            }
            this.strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "ded/form16adetls.xhtml?" + str2);
            if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"deducteeDetails\"]"))
            {
                tracesResponse2.Message = "Server Error";
                tracesResponse2.Respons = eResponse.Failed;
                this.Logoff();
                return tracesResponse2;
            }
            tracesResponse2 = this.IsServerError(this.strServerResponse, "//ul[@id=\"err_Summary\"]");
            str1 = this.strServerResponse;
            if (tracesResponse2.Respons == eResponse.Failed)
            {
                this.Logoff();
                return tracesResponse2;
            }
        }
        Dictionary<string, string> dictionary3 = this.TraceViewStateData(str1, "//form[@id=\"deducteeDetails\"]");
        if (dictionary3.Count <= 0)
        {
            tracesResponse2.Message = "Server Error";
            tracesResponse2.Respons = eResponse.SessionTimeout;
            return tracesResponse2;
        }
        StringBuilder sbData2 = new StringBuilder();
        sbData2.Append("j_id1972728517_7cc7de5f=submit");
        foreach (KeyValuePair<string, string> keyValuePair in dictionary3)
            sbData2.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
        string str3 = this.makeHTTPPostRequest(this.strBaseURL + "ded/form16adetls.xhtml", sbData2);
        if (!this.IsStringExists(str3, "//form[@id=\"dedkyc\"]"))
        {
            if (!this.IsStringExists(str3, "//form[@id=\"kycformdsc\"]"))
            {
                this.Logoff();
                this.bnlSessionExists = false;
                tracesResponse2.Message = "Server Error";
                tracesResponse2.Respons = eResponse.SessionTimeout;
                return tracesResponse2;
            }
            Dictionary<string, string> dictionary2 = this.TraceViewStateData(str3, "//form[@id=\"kycformdsc\"]");
            if (dictionary2.Count == 0)
            {
                this.bnlSessionExists = false;
                tracesResponse2.Message = "Server Error";
                tracesResponse2.Respons = eResponse.SessionTimeout;
                return tracesResponse2;
            }
            StringBuilder sbData3 = new StringBuilder();
            foreach (KeyValuePair<string, string> keyValuePair in dictionary2)
                sbData3.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            sbData3.Append("&search2=on");
            sbData3.Append("&kycFinYear=" + objTraceData.FAYear);
            sbData3.Append("&kycFormType=" + objTraceData.Forms);
            sbData3.Append("&kycQrtr=" + objTraceData.Quarter);
            sbData3.Append("&kycformdsc:_idcl=nxtSrcn");
            if (!this.IsStringExists(this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3formdsc.xhtml", sbData3), "//form[@id=\"dedkyc\"]"))
            {
                this.Logoff();
                this.bnlSessionExists = false;
                tracesResponse2.Message = "Server Error";
                tracesResponse2.Respons = eResponse.SessionTimeout;
                return tracesResponse2;
            }
        }
        if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"dedkyc1\"]"))
        {
            tracesResponse2.Message = "Server Error";
            tracesResponse2.Respons = eResponse.Failed;
            this.Logoff();
            return tracesResponse2;
        }
        TDSResponse tracesResponse3 = this.IsServerError(this.strServerResponse, "//ul[@id=\"err_Summary\"]");
        if (tracesResponse3.Respons == eResponse.Failed)
        {
            this.Logoff();
            return tracesResponse3;
        }
        Dictionary<string, string> dictionary4 = this.TraceViewStateData(this.strServerResponse, "//form[@id=\"dedkyc1\"]");
        tracesResponse3.CustomeTypes = (object)dictionary4;
        return tracesResponse3;
    }

    public TDSResponse IsChallanExistsInForm16A(
      TracesData objTraceData,
      LoginTraces objLogin)
    {
        TDSResponse tracesResponse1 = new TDSResponse();
        tracesResponse1.Respons = eResponse.Success;
        if (!this.bnlSessionExists)
        {
            tracesResponse1 = this.makeLoginToTRACES(objLogin);
            if (tracesResponse1.Respons == eResponse.Failed)
                return tracesResponse1;
        }
        this.strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "ded/download16a.xhtml");
        if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"bulkSearch\"]"))
        {
            tracesResponse1.Message = "Server Error";
            tracesResponse1.Respons = eResponse.SessionTimeout;
            return tracesResponse1;
        }
        TDSResponse tracesResponse2 = this.IsServerError(this.strServerResponse, "//span[@id=\"err_Summary\"]");
        if (tracesResponse2.Respons == eResponse.Failed)
        {
            tracesResponse2.Message = "Server Error";
            tracesResponse2.Respons = eResponse.Failed;
            return tracesResponse2;
        }
        StringBuilder sbData1 = new StringBuilder();
        sbData1.Append("dwnldFormBulkType=14");
        sbData1.Append("&bulkfinYr=" + objTraceData.FAYear);
        sbData1.Append("&bulkquarter=" + objTraceData.Quarter);
        sbData1.Append("&bulkformType=" + objTraceData.Forms);
        sbData1.Append("&bulkGo=Go");
        sbData1.Append("&bulkSearch_SUBMIT=1");
        Dictionary<string, string> dictionary1 = this.TraceViewStateData(this.strServerResponse, "//form[@id=\"bulkSearch\"]");
        if (dictionary1.Count <= 0)
        {
            tracesResponse2.Message = "Server Error";
            tracesResponse2.Respons = eResponse.SessionTimeout;
            return tracesResponse2;
        }
        foreach (KeyValuePair<string, string> keyValuePair in dictionary1)
        {
            if (keyValuePair.Key == "javax.faces.ViewState")
                sbData1.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
        }
        this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "ded/download16a.xhtml", sbData1);
        TDSResponse tracesResponse3 = this.IsServerError(this.strServerResponse, "//ul[@id=\"err_Summary\"]");
        if (tracesResponse3.Respons == eResponse.Failed)
        {
            tracesResponse3.Respons = eResponse.Failed;
            return tracesResponse3;
        }
        if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"deducteeDetails\"]"))
        {
            tracesResponse3.Message = "Server Error";
            tracesResponse3.Respons = eResponse.SessionTimeout;
            return tracesResponse3;
        }
        Dictionary<string, string> dictionary2 = this.TraceViewStateData(this.strServerResponse, "//form[@id=\"deducteeDetails\"]");
        if (dictionary2.Count <= 0)
        {
            tracesResponse3.Message = "Server Error";
            tracesResponse3.Respons = eResponse.SessionTimeout;
            return tracesResponse3;
        }
        StringBuilder sbData2 = new StringBuilder();
        sbData2.Append("j_id1972728517_7cc7de5f=submit");
        foreach (KeyValuePair<string, string> keyValuePair in dictionary2)
            sbData2.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
        this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "ded/form16adetls.xhtml", sbData2);
        if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"dedkyc\"]"))
        {
            if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"kycformdsc\"]"))
            {
                this.Logoff();
                this.bnlSessionExists = false;
                tracesResponse3.Message = "Server Error";
                tracesResponse3.Respons = eResponse.SessionTimeout;
                return tracesResponse3;
            }
            Dictionary<string, string> dictionary3 = this.TraceViewStateData(this.strServerResponse, "//form[@id=\"kycformdsc\"]");
            if (dictionary3.Count == 0)
            {
                this.bnlSessionExists = false;
                tracesResponse3.Message = "Server Error";
                tracesResponse3.Respons = eResponse.SessionTimeout;
                return tracesResponse3;
            }
            StringBuilder sbData3 = new StringBuilder();
            foreach (KeyValuePair<string, string> keyValuePair in dictionary3)
                sbData3.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            sbData3.Append("&search2=on");
            sbData3.Append("&kycFinYear=" + objTraceData.FAYear);
            sbData3.Append("&kycFormType=" + objTraceData.Forms);
            sbData3.Append("&kycQrtr=" + objTraceData.Quarter);
            sbData3.Append("&kycformdsc:_idcl=nxtSrcn");
            this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3formdsc.xhtml", sbData3);
            if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"dedkyc\"]"))
            {
                this.Logoff();
                this.bnlSessionExists = false;
                tracesResponse3.Message = "Server Error";
                tracesResponse3.Respons = eResponse.SessionTimeout;
                return tracesResponse3;
            }
        }
        if (tracesResponse3.Respons == eResponse.Failed)
        {
            this.Logoff();
            return tracesResponse3;
        }
        Dictionary<string, string> dictionary4 = this.TraceViewStateData(this.strServerResponse, "//form[@id=\"dedkyc\"]");
        tracesResponse3.CustomeTypes = (object)dictionary4;
        return tracesResponse3;
    }

    public TDSResponse IsChallanExistsIn27d(
      TracesData objTraceData,
      LoginTraces objLogin)
    {
        TDSResponse tracesResponse1 = new TDSResponse();
        tracesResponse1.Respons = eResponse.Success;
        if (!this.bnlSessionExists)
        {
            tracesResponse1 = this.makeLoginToTRACES(objLogin);
            if (tracesResponse1.Respons == eResponse.Failed)
                return tracesResponse1;
        }
        this.strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "ded/download27d.xhtml");
        if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"bulkSearch\"]"))
        {
            tracesResponse1.Message = "Server Error";
            tracesResponse1.Respons = eResponse.SessionTimeout;
            return tracesResponse1;
        }
        TDSResponse tracesResponse2 = this.IsServerError(this.strServerResponse, "//span[@id=\"err_Summary\"]");
        if (tracesResponse2.Respons == eResponse.Failed)
        {
            tracesResponse2.Message = "Server Error";
            tracesResponse2.Respons = eResponse.Failed;
            return tracesResponse2;
        }
        StringBuilder sbData = new StringBuilder();
        sbData.Append("dwnldFormBulkType=19");
        sbData.Append("&bulkfinYr=" + objTraceData.FAYear);
        sbData.Append("&bulkquarter=" + objTraceData.Quarter);
        sbData.Append("&bulkGo=Go");
        sbData.Append("&bulkSearch_SUBMIT=1");
        Dictionary<string, string> dictionary1 = this.TraceViewStateData(this.strServerResponse, "//form[@id=\"searchPAN\"]");
        if (dictionary1.Count <= 0)
        {
            tracesResponse2.Message = "Server Error";
            tracesResponse2.Respons = eResponse.SessionTimeout;
            return tracesResponse2;
        }
        foreach (KeyValuePair<string, string> keyValuePair in dictionary1)
        {
            if (keyValuePair.Key == "javax.faces.ViewState")
                sbData.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
        }
        this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "ded/download27d.xhtml", sbData);
        TDSResponse tracesResponse3 = this.IsServerError(this.strServerResponse, "//ul[@id=\"err_Summary\"]");
        if (tracesResponse3.Respons == eResponse.Failed)
        {
            this.Logoff();
            return tracesResponse3;
        }
        Dictionary<string, string> dictionary2 = this.TraceViewStateData(this.strServerResponse, "//form[@id=\"deducteeDetails\"]");
        tracesResponse3.CustomeTypes = (object)dictionary2;
        return tracesResponse3;
    }

    public TDSResponse NoValidPANdeductee(TracesData objTraceData)
    {
        TDSResponse tracesResponse1 = new TDSResponse();
        tracesResponse1.Respons = eResponse.Success;
        this.strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "ded/nsdlconsofile.xhtml");
        if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"requestnsdlconsoForm\"]"))
        {
            tracesResponse1.Message = "Server Error";
            tracesResponse1.Respons = eResponse.SessionTimeout;
            return tracesResponse1;
        }
        TDSResponse tracesResponse2 = this.IsServerError(this.strServerResponse, "//span[@id=\"err_Summary\"]");
        if (tracesResponse2.Respons == eResponse.Failed)
        {
            tracesResponse2.Message = "Server Error";
            tracesResponse2.Respons = eResponse.Failed;
            return tracesResponse2;
        }
        StringBuilder sbData = new StringBuilder();
        sbData.Append("finYr=" + objTraceData.FAYear);
        sbData.Append("&qrtr=" + objTraceData.Quarter);
        sbData.Append("&frmType=" + objTraceData.Forms);
        sbData.Append("&download_conso=Go");
        sbData.Append("&requestnsdlconsoForm_SUBMIT=1");
        Dictionary<string, string> dictionary1 = this.TraceViewStateData(this.strServerResponse, "//form[@id=\"requestnsdlconsoForm\"]");
        if (dictionary1.Count <= 0)
        {
            tracesResponse2.Message = "Server Error";
            tracesResponse2.Respons = eResponse.SessionTimeout;
            return tracesResponse2;
        }
        foreach (KeyValuePair<string, string> keyValuePair in dictionary1)
        {
            if (keyValuePair.Key == "javax.faces.ViewState")
                sbData.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
        }
        this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "ded/nsdlconsofile.xhtml", sbData);
        Dictionary<string, string> dictionary2 = this.TraceViewStateData(this.strServerResponse, "//form[@id=\"dedkyc\"]");
        tracesResponse2.CustomeTypes = (object)dictionary2;
        return tracesResponse2;
    }

    public TDSResponse RequestForAllDownloadList(out DataTable table)
    {
        table = (DataTable)null;
        string str1 = "";
        TDSResponse TDSResponse = new TDSResponse();
        try
        {
            str1 = this.makeHTTPGetRequest(this.strBaseURL + "ded/filedownload.xhtml");
            if (TDSResponse.Respons == eResponse.Failed)
                return TDSResponse;
            string str2 = this.makeHTTPJSONRequest(this.strBaseURL + "srv/GetReqListServlet?reqtype=0&rows=100&sord=asc");
            if (!string.IsNullOrEmpty(str2))
                table = this.JsonParser(str2);
            TDSResponse = this.IsServerError(str2, "//span[@id=\"err_Summary\"]");
            if (TDSResponse.Respons == eResponse.Failed)
                return TDSResponse;
        }
        catch (Exception ex)
        {
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = ex.Message;
        }
        return TDSResponse;
    }

    public TDSResponse RequestForAllDownloadList_SVC(LoginTraces objLogin, out DataTable table, out string cookie)
    {
        table = (DataTable)null;
        string str1 = string.Empty;
        cookie = string.Empty;
        TDSResponse TDSResponse = new TDSResponse();

        try
        {
            if (!this.IsSessionExists)
            {
                TDSResponse = this.makeLoginToTRACES_SVC(objLogin);
                if (TDSResponse.Respons == eResponse.Failed)
                    return TDSResponse;
            }

            str1 = this.makeHTTPGetRequest(this.strBaseURL + "ded/filedownload.xhtml");
            if (TDSResponse.Respons == eResponse.Failed)
                return TDSResponse;

            string str2 = this.makeHTTPJSONRequest_SVC(this.strBaseURL + "srv/GetReqListServlet?reqtype=0&rows=100&sord=asc");
            string[] split = str2.Split(new string[] { "@@@" }, StringSplitOptions.RemoveEmptyEntries);
            str2 = split[0];
            cookie = split[1];

            if (!string.IsNullOrEmpty(str2))
                table = this.JsonParser(str2);


            TDSResponse = this.IsServerError(str2, "//span[@id=\"err_Summary\"]");
            if (TDSResponse.Respons == eResponse.Failed)
                return TDSResponse;
        }
        catch (Exception ex)
        {
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = ex.Message;
        }
        //Insert Login Details
        if (table.Rows.Count > 0)
        {
            insertLoginDetails(objLogin);
        }
        return TDSResponse;
    }
    public TDSResponse RequestForDownloadListByReqNo(
      string ReqNo,
      out DataTable table)
    {
        table = (DataTable)null;
        string str1 = "";
        TDSResponse TDSResponse = new TDSResponse();
        try
        {
            str1 = this.makeHTTPGetRequest(this.strBaseURL + "ded/filedownload.xhtml");
            if (TDSResponse.Respons == eResponse.Failed)
                return TDSResponse;
            string str2 = this.makeHTTPJSONRequest(this.strBaseURL + "GetReqListServlet?reqtype=2&reqNo=" + ReqNo + "&rows=100&sord=asc");
            if (!string.IsNullOrEmpty(str2))
                table = this.JsonParser(str2);
            TDSResponse = this.IsServerError(str2, "//span[@id=\"err_Summary\"]");
            if (TDSResponse.Respons == eResponse.Failed)
                return TDSResponse;
        }
        catch (Exception ex)
        {
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = ex.Message;
        }
        return TDSResponse;
    }

    public TDSResponse RequestForDownloadListByDate(
      string FromDate,
      string ToDate,
      out DataTable table)
    {
        table = (DataTable)null;
        string str1 = "";
        TDSResponse TDSResponse = new TDSResponse();
        try
        {
            str1 = this.makeHTTPGetRequest(this.strBaseURL + "ded/filedownload.xhtml");
            if (TDSResponse.Respons == eResponse.Failed)
                return TDSResponse;
            string str2 = this.makeHTTPJSONRequest(this.strBaseURL + "GetReqListServlet?reqtype=1&frmDate=" + FromDate + "&toDate=" + ToDate + "&rows=100&sord=asc");
            if (!string.IsNullOrEmpty(str2))
                table = this.JsonParser(str2);
            TDSResponse = this.IsServerError(str2, "//span[@id=\"err_Summary\"]");
            if (TDSResponse.Respons == eResponse.Failed)
                return TDSResponse;
        }
        catch (Exception ex)
        {
            this.Logoff();
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = ex.Message;
        }
        return TDSResponse;
    }

    public TDSResponse RequestForDownloadFile_bak(string strReqNo, string strPath)
    {
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        try
        {
            string str = "srv/DownloadServlet";
            StringBuilder stringBuilder = new StringBuilder();
            stringBuilder.Append("reqNo=" + strReqNo);
            TDSResponse = this.IsServerError(this.GetFileLocation(this.strBaseURL + str, stringBuilder.ToString()), "//span[@id=\"infoMsg\"]");
            if (TDSResponse.Respons == eResponse.Failed)
            {
                this.Logoff();
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            string strURL = "";
            JsonTextReader jsonTextReader = new JsonTextReader((TextReader)new StringReader(this.strServerResponse));
            while (jsonTextReader.Read())
            {
                if (jsonTextReader.TokenType == JsonToken.String)
                {
                    strURL = Convert.ToString(jsonTextReader.Value);
                    break;
                }
                if (jsonTextReader.TokenType == JsonToken.Integer)
                {
                    strURL = Convert.ToString(jsonTextReader.Value);
                    break;
                }
            }
            if (!string.IsNullOrEmpty(strURL))
            {
                if (strURL == "2")
                {
                    TDSResponse.Respons = eResponse.Failed;
                    TDSResponse.Message = "Multiple File Download not available !!";
                    return TDSResponse;
                }
                if (!this.makeHttpDownloadRequest(strURL, strPath))
                    TDSResponse.Respons = eResponse.Failed;
                eTDS.T_DownloadedFileNameFromTraces = strURL.Substring(strURL.LastIndexOf("/") + 1, strURL.Length - 1 - strURL.LastIndexOf("/"));
            }
            else
            {
                TDSResponse.Respons = eResponse.Failed;
                TDSResponse.Message = "due to Traces server failure !!";
                return TDSResponse;
            }
        }
        catch (Exception ex)
        {
            TDSResponse.Message = ex.Message;
            TDSResponse.Respons = eResponse.Failed;
        }
        return TDSResponse;
    }

    public TDSResponse RequestForDownloadFile_bak_SVC(string strReqNo, string strCookie, out string base64, out string filename)
    {
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        string strPath = HttpContext.Current.Server.MapPath("~/Download/");
        base64 = string.Empty;
        filename = string.Empty;

        //Handle cookie 
        string[] split = strCookie.Split(new string[] { ";" }, StringSplitOptions.RemoveEmptyEntries);
        for (int i = 0; i < split.Length; i++)
        {
            string[] splitValue = split[i].Split(new string[] { " = " }, StringSplitOptions.RemoveEmptyEntries);
            Cookie mycookie = new Cookie();
            mycookie.Domain = "www.tdscpc.gov.in";
            mycookie.Name = splitValue[0];
            mycookie.HttpOnly = true;


            mycookie.Value = splitValue[1];
            if (splitValue[0].IndexOf("LtpaToken2") >= -1)
            {
                mycookie.Path = "/";
                mycookie.Secure = false;
            }
            else if (splitValue[0].IndexOf("JSESSIONID") >= -1)
            {
                mycookie.Path = "/app";
                mycookie.Secure = true;

            }
            else if (splitValue[0].IndexOf("oam.Flash.RENDERMAP.TOKEN") >= -1)
            {
                mycookie.Path = "/app";
                mycookie.Secure = false;
            }
            this.objContainer.Add(mycookie);
        }

        try
        {
            string str = "srv/DownloadServlet";
            StringBuilder stringBuilder = new StringBuilder();
            stringBuilder.Append("reqNo=" + strReqNo);
            TDSResponse = this.IsServerError(this.GetFileLocation_SVC(this.strBaseURL + str, stringBuilder.ToString()), "//span[@id=\"infoMsg\"]");
            if (TDSResponse.Respons == eResponse.Failed)
            {
                this.Logoff();
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            string strURL = "";
            JsonTextReader jsonTextReader = new JsonTextReader((TextReader)new StringReader(this.strServerResponse));
            while (jsonTextReader.Read())
            {
                if (jsonTextReader.TokenType == JsonToken.String)
                {
                    strURL = Convert.ToString(jsonTextReader.Value);
                    break;
                }
                if (jsonTextReader.TokenType == JsonToken.Integer)
                {
                    strURL = Convert.ToString(jsonTextReader.Value);
                    break;
                }
            }

            if (!string.IsNullOrEmpty(strURL))
            {
                if (strURL == "2")
                {
                    TDSResponse.Respons = eResponse.Failed;
                    TDSResponse.Message = "Multiple File Download not available !!";

                    return TDSResponse;
                }

                if (!this.makeHttpDownloadRequest_SVC(strURL, strPath, out filename, out base64))
                    TDSResponse.Respons = eResponse.Failed;
                eTDS.T_DownloadedFileNameFromTraces = strURL.Substring(strURL.LastIndexOf("/") + 1, strURL.Length - 1 - strURL.LastIndexOf("/"));

            }
            else
            {
                TDSResponse.Respons = eResponse.Failed;
                TDSResponse.Message = "due to Traces server failure !!";

                return TDSResponse;
            }
        }
        catch (Exception ex)
        {
            TDSResponse.Message = ex.Message;
            TDSResponse.Respons = eResponse.Failed;
            return TDSResponse;
        }
        return TDSResponse;
    }
    private bool makeHttpDownloadRequest_SVC(string strURL, string strPath, out string filename, out string base64)
    {
        bool flag = true;

        try
        {
            ConnectTR.SetAllowUnsafeHeaderParsing();
            ServicePointManager.ServerCertificateValidationCallback = (RemoteCertificateValidationCallback)((_param1, _param2, _param3, _param4) => true);
            this.request = (HttpWebRequest)WebRequest.Create(strURL);
            this.request.KeepAlive = true;
            this.request.Timeout = 300000;
            this.request.AllowWriteStreamBuffering = false;
            this.request.AllowAutoRedirect = true;
            this.request.UserAgent = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.57 Safari/537.17";
            this.request.Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8";
            this.request.Headers.Add("Upgrade-Insecure-Requests", "1");
            this.request.Headers.Add("Accept-Encoding", "gzip, deflate, sdch");
            this.request.Headers.Add("Accept-Language", "en-US,en;q=0.8");
            this.request.CookieContainer = this.objContainer;
            this.request.CookieContainer.Add(this.response.Cookies);
            this.response = (HttpWebResponse)this.request.GetResponse();
            long length = 120000;
            this.dataStream = this.response.GetResponseStream();
            string str = strURL.Substring(strURL.LastIndexOf("/") + 1);
            if (string.IsNullOrEmpty(str))
                str = "File.zip";
            /*
            FileStream fileStream = new FileStream(strPath + "\\" + str, FileMode.Create);
            byte[] buffer = new byte[length];
            for (int count = this.dataStream.Read(buffer, 0, buffer.Length); count > 0; count = this.dataStream.Read(buffer, 0, buffer.Length))
                fileStream.Write(buffer, 0, count);
            this.response.Close();
            fileStream.Close();
            */
            filename = str;
            byte[] bytes;
            using (var memoryStream = new MemoryStream())
            {
                dataStream.CopyTo(memoryStream);
                bytes = memoryStream.ToArray();
            }
            base64 = Convert.ToBase64String(bytes);








            this.dataStream.Close();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return flag;
    }
    public TDSResponse RequestForDownloadFile(string strReqNo, string strPath)
    {
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        try
        {
            string str1 = "srv/DownloadServlet";
            StringBuilder stringBuilder = new StringBuilder();
            stringBuilder.Append("reqNo=" + strReqNo);
            TDSResponse = this.IsServerError(this.GetFileLocation(this.strBaseURL + str1, stringBuilder.ToString()), "//span[@id=\"infoMsg\"]");
            if (TDSResponse.Respons == eResponse.Failed)
            {
                this.Logoff();
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            string strURL = "";
            JsonTextReader jsonTextReader = new JsonTextReader((TextReader)new StringReader(this.strServerResponse));
            while (jsonTextReader.Read())
            {
                if (jsonTextReader.TokenType == JsonToken.String)
                {
                    strURL = Convert.ToString(jsonTextReader.Value);
                    break;
                }
                if (jsonTextReader.TokenType == JsonToken.Integer)
                {
                    strURL = Convert.ToString(jsonTextReader.Value);
                    break;
                }
            }
            if (!string.IsNullOrEmpty(strURL))
            {
                if (strURL == "2")
                {
                    List<string> stringList = new List<string>();
                    List<string> downloadAnchorLink = this.getDownloadAnchorLink(this.makeHTTPGetRequest(this.strBaseURL + "ded/downloadmultiple.xhtml?reqNo=" + strReqNo));
                    foreach (string str2 in downloadAnchorLink)
                    {
                        this.strURL = this.GetFileLocation("https://www.tdscpc.gov.in" + str2);
                        if (string.IsNullOrEmpty(this.strURL))
                        {
                            TDSResponse.Respons = eResponse.Failed;
                            TDSResponse.Message = "due to Traces server failure !!";
                            return TDSResponse;
                        }
                        if (Regex.IsMatch(this.strURL, "ibm_security_logout"))
                        {
                            TDSResponse.Respons = eResponse.SessionTimeout;
                            TDSResponse.Message = "Session Timeout Login again !!";
                            return TDSResponse;
                        }
                        if (string.IsNullOrEmpty(this.strURL))
                        {
                            TDSResponse.Respons = eResponse.Failed;
                            return TDSResponse;
                        }
                        if (!this.makeHttpDownloadRequest(this.strURL, strPath))
                            TDSResponse.Respons = eResponse.Failed;
                        eTDS.T_DownloadedFileNameFromTraces = this.strURL.Substring(this.strURL.LastIndexOf("/") + 1, this.strURL.Length - 1 - this.strURL.LastIndexOf("/"));
                    }
                }
                else
                {
                    if (!this.makeHttpDownloadRequest(strURL, strPath))
                        TDSResponse.Respons = eResponse.Failed;
                    eTDS.T_DownloadedFileNameFromTraces = strURL.Substring(strURL.LastIndexOf("/") + 1, strURL.Length - 1 - strURL.LastIndexOf("/"));
                }
            }
            else
            {
                TDSResponse.Respons = eResponse.Failed;
                TDSResponse.Message = "due to Traces server failure !!";
                return TDSResponse;
            }
        }
        catch (Exception ex)
        {
            TDSResponse.Message = ex.Message;
            TDSResponse.Respons = eResponse.Failed;
        }
        return TDSResponse;
    }

    public TDSResponse RequestForStatusofStatementFile(
      TracesData objData,
      out DataTable table)
    {
        table = (DataTable)null;
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        try
        {
            this.strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "ded/stmtstatus.xhtml");
            if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"stmtFiledStatus\"]"))
            {
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            StringBuilder sbData = new StringBuilder();
            sbData.Append("_search=false");
            sbData.Append("&rows=100");
            sbData.Append("&page=1");
            sbData.Append("&sidx=");
            sbData.Append("&sord=asc");
            string s = this.makeHTTPPostRequest(this.strBaseURL + "ded/srv/DedStmtStatusServlet?financialYear=" + objData.FAYear + "&quarter=" + objData.Quarter + "&formType=" + objData.Forms + "&reqType=1", sbData);
            if (!string.IsNullOrEmpty(s))
            {
                table = new DataTable();
                table.Columns.Add("Token Number");
                table.Columns.Add("Finnancial Year");
                table.Columns.Add("Statement Type");
                table.Columns.Add("Form Type");
                table.Columns.Add("Quarter");
                table.Columns.Add("Date of Filling");
                table.Columns.Add("Date of Processing");
                table.Columns.Add("Status");
                string str = "Test";
                DataRow row = (DataRow)null;
                using (JsonTextReader jsonTextReader = new JsonTextReader((TextReader)new StringReader(s)))
                {
                    while (jsonTextReader.Read())
                    {
                        switch (jsonTextReader.TokenType)
                        {
                            case JsonToken.PropertyName:
                                str = jsonTextReader.Value.ToString();
                                break;
                            case JsonToken.Integer:
                            case JsonToken.Float:
                            case JsonToken.String:
                            case JsonToken.Null:
                                switch (str)
                                {
                                    case "dtoffiling":
                                        row["Date of Filling"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "dtofprcng":
                                        row["Date of Processing"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "finyear":
                                        row = table.NewRow();
                                        row["Finnancial Year"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "formtype":
                                        row["Form Type"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "quarter":
                                        row["Quarter"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "status":
                                        row["Status"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "stmnttype":
                                        row["Statement Type"] = (object)Convert.ToString(jsonTextReader.Value);
                                        table.Rows.Add(row);
                                        break;
                                    case "tokenno":
                                        row["Token Number"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                }
                                break;
                        }
                    }
                }
            }
            else
            {
                TDSResponse.Respons = eResponse.Failed;
                TDSResponse.Message = "Server error";
            }
        }
        catch (Exception ex)
        {
            TDSResponse.Respons = !Regex.IsMatch(ex.Message, "410") ? eResponse.Failed : eResponse.SessionTimeout;
            TDSResponse.Message = ex.Message;
        }
        return TDSResponse;
    }


    public TDSResponse RequestForStatusofStatementFile(LoginTraces objLogin, TracesData objData,
    out DataTable table)
    {
        table = (DataTable)null;
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        try
        {
            if (!this.bnlSessionExists)
            {
                TDSResponse = this.makeLoginToTRACES_SVC(objLogin);
                if (TDSResponse.Respons == eResponse.Failed)
                    return TDSResponse;
            }
            this.strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "ded/stmtstatus.xhtml");
            if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"stmtFiledStatus\"]"))
            {
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            StringBuilder sbData = new StringBuilder();
            sbData.Append("_search=false");
            sbData.Append("&rows=100");
            sbData.Append("&page=1");
            sbData.Append("&sidx=");
            sbData.Append("&sord=asc");
            string s = this.makeHTTPPostRequest_SVC(this.strBaseURL + "ded/srv/DedStmtStatusServlet?financialYear=" + objData.FAYear + "&quarter=" + objData.Quarter + "&formType=" + objData.Forms + "&reqType=1", sbData);
            if (!string.IsNullOrEmpty(s))
            {
                table = new DataTable();
                table.Columns.Add("Token Number");
                table.Columns.Add("Finnancial Year");
                table.Columns.Add("Statement Type");
                table.Columns.Add("Form Type");
                table.Columns.Add("Quarter");
                table.Columns.Add("Date of Filling");
                table.Columns.Add("Date of Processing");
                table.Columns.Add("Status");
                string str = "Test";
                DataRow row = (DataRow)null;
                using (JsonTextReader jsonTextReader = new JsonTextReader((TextReader)new StringReader(s)))
                {
                    while (jsonTextReader.Read())
                    {
                        switch (jsonTextReader.TokenType)
                        {
                            case JsonToken.PropertyName:
                                str = jsonTextReader.Value.ToString();
                                break;
                            case JsonToken.Integer:
                            case JsonToken.Float:
                            case JsonToken.String:
                            case JsonToken.Null:
                                switch (str)
                                {
                                    case "dtoffiling":
                                        row["Date of Filling"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "dtofprcng":
                                        row["Date of Processing"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "finyear":
                                        row = table.NewRow();
                                        row["Finnancial Year"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "formtype":
                                        row["Form Type"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "quarter":
                                        row["Quarter"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "status":
                                        row["Status"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "stmnttype":
                                        row["Statement Type"] = (object)Convert.ToString(jsonTextReader.Value);
                                        table.Rows.Add(row);
                                        break;
                                    case "tokenno":
                                        row["Token Number"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                }
                                break;
                        }
                    }
                }
            }
            else
            {
                TDSResponse.Respons = eResponse.Failed;
                TDSResponse.Message = "Server error";
            }
        }
        catch (Exception ex)
        {
            TDSResponse.Respons = !Regex.IsMatch(ex.Message, "410") ? eResponse.Failed : eResponse.SessionTimeout;
            TDSResponse.Message = ex.Message;
        }
        return TDSResponse;
    }

    public TDSResponse RequestForChallanStatusQuery1(TracesData objData)
    {
        DataTable dataTable = new DataTable();
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        try
        {
            this.strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "ded/challanstatusquery.xhtml");
            if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"chlnStatusForm1\"]"))
            {
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            StringBuilder sbData = new StringBuilder();
            sbData.Append("_search=false");
            sbData.Append("&rows=2000");
            sbData.Append("&page=1");
            sbData.Append("&sidx=");
            sbData.Append("&sord=");
            this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "ded/srv/ChlnStatusServlet?reqtype=0&sdate=" + objData.FromChallanDepositDate + "&edate=" + objData.ToChallanDepositDate + "&cstatus=" + objData.ChallanStatus, sbData);
            if (!string.IsNullOrEmpty(this.strServerResponse))
            {
                dataTable = new DataTable();
                dataTable.Columns.Add("Bank Code");
                dataTable.Columns.Add("Branch Code");
                dataTable.Columns.Add("Date of Deposit");
                dataTable.Columns.Add("Challan Serial Number");
                dataTable.Columns.Add("Challan Status");
                dataTable.Columns.Add("chllan Amount");
                dataTable.Columns.Add("Recipt Number");
                string str = "Test";
                DataRow row = (DataRow)null;
                using (JsonTextReader jsonTextReader = new JsonTextReader((TextReader)new StringReader(this.strServerResponse)))
                {
                    while (jsonTextReader.Read())
                    {
                        switch (jsonTextReader.TokenType)
                        {
                            case JsonToken.PropertyName:
                                str = jsonTextReader.Value.ToString();
                                break;
                            case JsonToken.Integer:
                            case JsonToken.Float:
                            case JsonToken.String:
                            case JsonToken.Null:
                                switch (str)
                                {
                                    case "bankCode":
                                        row["Bank Code"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "branchCode":
                                        row["Branch Code"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "chlnAmt":
                                        row["chllan Amount"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "chlnSNo":
                                        row["Challan Serial Number"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "chlnStatus":
                                        row["Challan Status"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "dateOfDep":
                                        row = dataTable.NewRow();
                                        row["Date of Deposit"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "recptNum":
                                        row["Recipt Number"] = (object)jsonTextReader.Value.ToString();
                                        dataTable.Rows.Add(row);
                                        break;
                                }
                                break;
                        }
                    }
                }
            }
            else
            {
                TDSResponse.Respons = eResponse.Failed;
                TDSResponse.Message = "Server error";
            }
            TDSResponse.CustomeTypes = (object)dataTable;
        }
        catch (Exception ex)
        {
            TDSResponse.Respons = !Regex.IsMatch(ex.Message, "410") ? eResponse.Failed : eResponse.SessionTimeout;
            TDSResponse.Message = ex.Message;
        }
        return TDSResponse;
    }

    public TDSResponse RequestForChallanStatusQuery2(TracesData objData)
    {
        StringBuilder sbData = new StringBuilder();
        DataTable dataTable = new DataTable();
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        try
        {
            this.strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "ded/challanstatusquery.xhtml");
            if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"chlnStatusForm2\"]"))
            {
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            sbData.Append("_search=false");
            sbData.Append("&rows=2000");
            sbData.Append("&page=1");
            sbData.Append("&sidx=");
            sbData.Append("&sord=");
            this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "ded/srv/ChlnStatusServlet?reqtype=1&bsrCode=" + objData.BSRCode + "&chlnSNo=" + objData.ChallanSerialNo + "&chlnAmt=" + objData.ChallanAmount + "&dateOfDep=" + objData.TaxDepositedDate, sbData);
            if (!string.IsNullOrEmpty(this.strServerResponse))
            {
                dataTable = new DataTable();
                dataTable.Columns.Add("Bank Code");
                dataTable.Columns.Add("Branch Code");
                dataTable.Columns.Add("Date of Deposit");
                dataTable.Columns.Add("Challan Serial Number");
                dataTable.Columns.Add("Challan Status");
                dataTable.Columns.Add("chllan Amount");
                dataTable.Columns.Add("Recipt Number");
                string str = "Test";
                DataRow row = (DataRow)null;
                using (JsonTextReader jsonTextReader = new JsonTextReader((TextReader)new StringReader(this.strServerResponse)))
                {
                    while (jsonTextReader.Read())
                    {
                        switch (jsonTextReader.TokenType)
                        {
                            case JsonToken.PropertyName:
                                str = jsonTextReader.Value.ToString();
                                break;
                            case JsonToken.Integer:
                            case JsonToken.Float:
                            case JsonToken.String:
                            case JsonToken.Null:
                                switch (str)
                                {
                                    case "bankCode":
                                        row["Bank Code"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "branchCode":
                                        row["Branch Code"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "chlnAmt":
                                        row["chllan Amount"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "chlnSNo":
                                        row["Challan Serial Number"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "chlnStatus":
                                        row["Challan Status"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "dateOfDep":
                                        row = dataTable.NewRow();
                                        row["Date of Deposit"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "recptNum":
                                        row["Recipt Number"] = (object)jsonTextReader.Value.ToString();
                                        dataTable.Rows.Add(row);
                                        break;
                                }
                                break;
                        }
                    }
                }
            }
            else
            {
                TDSResponse.Respons = eResponse.Failed;
                TDSResponse.Message = "Server error";
            }
            TDSResponse.CustomeTypes = (object)dataTable;
        }
        catch (Exception ex)
        {
            TDSResponse.Respons = !Regex.IsMatch(ex.Message, "410") ? eResponse.Failed : eResponse.SessionTimeout;
            TDSResponse.Message = ex.Message;
        }
        return TDSResponse;
    }

    public TDSResponse RequestForConsumptionDetails(TracesData objData)
    {
        StringBuilder sbData = new StringBuilder();
        DataTable dataTable = new DataTable();
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        try
        {
            sbData.Append("_search=false");
            sbData.Append("&rows=2000");
            sbData.Append("&page=1");
            sbData.Append("&sidx=tokenNum");
            sbData.Append("&sord=desc");
            this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "ded/srv/ChlnStatusServlet?reqtype=2&recptNum=" + objData.PRN_NO + "&chlnSNo=" + objData.ChallanSerialNo + "&chlnAmt=" + objData.ChallanAmount + "&dateOfDep=" + objData.FromChallanDepositDate + "&bsrCode=" + objData.BSRCode, sbData);
            if (this.IsStringExists(this.strServerResponse, "//form[@id=\"loginForm\"]"))
            {
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            if (!string.IsNullOrEmpty(this.strServerResponse))
            {
                int num1 = 0;
                dataTable = new DataTable();
                dataTable.Columns.Add("Token Number");
                dataTable.Columns.Add("Finnancial Year");
                dataTable.Columns.Add("Quarter");
                dataTable.Columns.Add("Form Type");
                dataTable.Columns.Add("Claimed Amount");
                dataTable.Columns.Add("Challan Status");
                dataTable.Columns.Add("Excess Amount Claimed");
                dataTable.Columns.Add("Available Amount");
                string str = "Test";
                DataRow row = (DataRow)null;
                using (JsonTextReader jsonTextReader = new JsonTextReader((TextReader)new StringReader(this.strServerResponse)))
                {
                    while (jsonTextReader.Read())
                    {
                        double num2 = 0.0;
                        switch (jsonTextReader.TokenType)
                        {
                            case JsonToken.PropertyName:
                                str = jsonTextReader.Value.ToString();
                                break;
                            case JsonToken.Integer:
                            case JsonToken.Float:
                            case JsonToken.String:
                            case JsonToken.Null:
                                switch (str)
                                {
                                    case "availAmt":
                                        if (num1 > 0)
                                        {
                                            if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                                num2 = Convert.ToDouble(jsonTextReader.Value.ToString());
                                            row["Available Amount"] = (object)string.Format("{0:0.00}", (object)num2);
                                            dataTable.Rows.Add(row);
                                            break;
                                        }
                                        break;
                                    case "chlnStatus":
                                        row["Challan Status"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "claimAmt":
                                        if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                            num2 = Convert.ToDouble(jsonTextReader.Value.ToString());
                                        row["Claimed Amount"] = (object)string.Format("{0:0.00}", (object)num2);
                                        break;
                                    case "excessAmt":
                                        if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                            num2 = Convert.ToDouble(jsonTextReader.Value.ToString());
                                        row["Excess Amount Claimed"] = (object)string.Format("{0:0.00}", (object)num2);
                                        break;
                                    case "finYr":
                                        row["Finnancial Year"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "formType":
                                        row["Form Type"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "qtr":
                                        row["Quarter"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "rowCount":
                                        num1 = Convert.ToInt32(jsonTextReader.Value);
                                        break;
                                    case "tokenNum":
                                        row = dataTable.NewRow();
                                        row["Token Number"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                }
                                break;
                        }
                    }
                }
            }
            else
            {
                TDSResponse.Respons = eResponse.Failed;
                TDSResponse.Message = "Server error";
            }
            TDSResponse.CustomeTypes = (object)dataTable;
        }
        catch (Exception ex)
        {
            if (Regex.IsMatch(ex.Message, "410"))
            {
                TDSResponse.Respons = eResponse.SessionTimeout;
                TDSResponse.Message = ex.Message;
            }
            else if (Regex.IsMatch(ex.Message, "406"))
            {
                TDSResponse.Message = "Invalid Challan Amount";
                TDSResponse.Respons = eResponse.Failed;
            }
            else if (Regex.IsMatch(ex.Message, "500"))
            {
                TDSResponse.Message = "System has encountered some technical problem. Please try after some time";
                TDSResponse.Respons = eResponse.Failed;
            }
        }
        return TDSResponse;
    }



    public TDSResponse RequestForNSDLConsoFile(
      LoginTraces objLogin,
      TracesData objTraceData)
    {
        TDSResponse tracesResponse1 = new TDSResponse();


        try
        {
            if (!this.IsSessionExists)
            {
                tracesResponse1 = this.makeLoginToTRACES_SVC(objLogin);
                if (tracesResponse1.Respons == eResponse.Failed)
                    return tracesResponse1;
            }
            string request = this.makeHTTPGetRequest(this.strBaseURL + "ded/nsdlconsofile.xhtml");
            if (!this.IsStringExists(request, "//form[@id=\"requestnsdlconsoForm\"]"))
            {
                string str = this.RetrieveElementValue(request, "//div[@class=\"padLeft5 margintop20\"]", "//span[@class=\"boldFont\"]", ConnectTR.enmElementType.InnerText);
                if (!string.IsNullOrEmpty(str))
                {
                    tracesResponse1.Message = str;
                    tracesResponse1.Respons = eResponse.Failed;
                    return tracesResponse1;
                }
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                return tracesResponse1;
            }
            tracesResponse1 = this.IsServerError(request, "//span[@id=\"err_Summary\"]");
            if (tracesResponse1.Respons == eResponse.Failed)
            {
                this.Logoff();
                tracesResponse1.Respons = eResponse.Failed;
                return tracesResponse1;
            }
            StringBuilder sbData1 = new StringBuilder();
            sbData1.Append("finYr=" + objTraceData.FAYear);
            sbData1.Append("&qrtr=" + objTraceData.Quarter);
            sbData1.Append("&frmType=" + objTraceData.Forms);
            sbData1.Append("&download_conso=Go");
            Dictionary<string, string> dictionary1 = this.TraceViewStateData(request, "//form[@id=\"requestnsdlconsoForm\"]");
            if (dictionary1.Count <= 0)
            {
                this.Logoff();
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                return tracesResponse1;
            }
            foreach (KeyValuePair<string, string> keyValuePair in dictionary1)
                sbData1.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            string str1 = this.makeHTTPPostRequest(this.strBaseURL + "ded/nsdlconsofile.xhtml", sbData1);
            tracesResponse1 = this.IsServerError(str1, "//ul[@id=\"err_Summary\"]");
            if (tracesResponse1.Respons == eResponse.Failed)
            {
                this.Logoff();
                tracesResponse1.Respons = eResponse.Failed;
                return tracesResponse1;
            }
            string str2 = "dedkyc";
            if (!this.IsStringExists(str1, "//form[@id=\"dedkyc\"]"))
            {
                if (!this.IsStringExists(str1, "//form[@id=\"kycformdsc\"]"))
                {
                    string str3 = this.AttributeValie(str1, "//div[@id='umchcase']", "Style");
                    this.Logoff();
                    this.bnlSessionExists = false;
                    tracesResponse1.Message = string.IsNullOrEmpty(str3) ? "Server Error" : "There are unmatched challans in the selected statement";
                    tracesResponse1.Respons = eResponse.SessionTimeout;
                    return tracesResponse1;
                }
                str2 = "dedkyc";
                Dictionary<string, string> dictionary2 = this.TraceViewStateData(str1, "//form[@id=\"kycformdsc\"]");
                if (dictionary2.Count == 0)
                {
                    this.bnlSessionExists = false;
                    tracesResponse1.Message = "Server Error";
                    tracesResponse1.Respons = eResponse.SessionTimeout;
                    return tracesResponse1;
                }
                StringBuilder sbData2 = new StringBuilder();
                foreach (KeyValuePair<string, string> keyValuePair in dictionary2)
                    sbData2.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
                sbData2.Append("&search2=on");
                sbData2.Append("&kycFinYear=" + objTraceData.FAYear);
                sbData2.Append("&kycFormType=" + objTraceData.Forms);
                sbData2.Append("&kycQrtr=" + objTraceData.Quarter);
                sbData2.Append("&kycformdsc:_idcl=nxtSrcn");
                str1 = this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3formdsc.xhtml", sbData2);
                if (!this.IsStringExists(str1, "//form[@id=\"dedkyc1\"]"))
                {
                    this.Logoff();
                    this.bnlSessionExists = false;
                    tracesResponse1.Message = "Server Error";
                    tracesResponse1.Respons = eResponse.SessionTimeout;
                    return tracesResponse1;
                }
            }
            StringBuilder sbData3 = new StringBuilder();
            sbData3.Append("authcode=" + objTraceData.AuthenticationCode);
            sbData3.Append("&stmtSpecKyc=1");
            sbData3.Append("&bforeLogin=3");
            sbData3.Append("&token=" + objTraceData.PRN_NO);
            bool flag;
            if (objTraceData.IsNoChallanCheck)
            {
                StringBuilder stringBuilder = sbData3;
                flag = objTraceData.IsNoChallanCheck;
                string str3 = "&cinbinCheck=" + flag.ToString();
                stringBuilder.Append(str3);
            }
            StringBuilder stringBuilder1 = sbData3;
            flag = objTraceData.IsNoChallan;
            string str4 = "&cinbinValue=" + flag.ToString();
            stringBuilder1.Append(str4);
            StringBuilder stringBuilder2 = sbData3;
            flag = objTraceData.IsPaymentByBookAdjustmentCheck;
            string str5 = "&bkEntryFlgChk=" + flag.ToString();
            stringBuilder2.Append(str5);
            StringBuilder stringBuilder3 = sbData3;
            flag = objTraceData.IsPaymentByBookAdjustment;
            string str6 = "&bkEntryValue=" + flag.ToString();
            stringBuilder3.Append(str6);
            if (objTraceData.panAmtValueCheck)
            {
                StringBuilder stringBuilder4 = sbData3;
                flag = objTraceData.panAmtValueCheck;
                string str3 = "&panAmtCheck=" + flag.ToString();
                stringBuilder4.Append(str3);
            }
            StringBuilder stringBuilder5 = sbData3;
            flag = objTraceData.panAmtValue;
            string str7 = "&panAmtValue=" + flag.ToString();
            stringBuilder5.Append(str7);
            if (!objTraceData.IsNoChallanCheck)
            {
                sbData3.Append("&bsr=" + objTraceData.BSRCode);
                sbData3.Append("&dtoftaxdep=" + objTraceData.TaxDepositedDate);
                sbData3.Append("&csn=" + objTraceData.ChallanSerialNo);
                sbData3.Append("&chlnamt=" + objTraceData.ChallanAmount);
                sbData3.Append("&cdrecnum=" + objTraceData.CDRecordNumber);
            }
            if (!objTraceData.panAmtValueCheck)
            {
                sbData3.Append("&pan1=" + objTraceData.PAN1);
                sbData3.Append("&amt1=" + objTraceData.PAN1Amount);
                sbData3.Append("&pan2=" + objTraceData.PAN2);
                sbData3.Append("&amt2=" + objTraceData.PAN2Amount);
                sbData3.Append("&pan3=" + objTraceData.PAN3);
                sbData3.Append("&amt3=" + objTraceData.PAN3Amount);
            }
            sbData3.Append("&clickKYC=Proceed");
            sbData3.Append("&dedkyc_SUBMIT=1");
            Dictionary<string, string> dictionary3 = this.TraceViewStateData(str1, "//form[@id=\"" + str2 + "\"]");
            foreach (KeyValuePair<string, string> keyValuePair in dictionary3)
                sbData3.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            if (dictionary3.Count <= 0)
            {
                this.Logoff();
                this.bnlSessionExists = false;
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                return tracesResponse1;
            }
            string str8 = this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3form.xhtml", sbData3);
            if (!this.IsStringExists(str8, "//form[@id=\"dedkyc\"]"))
            {
                this.bnlSessionExists = false;
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                return tracesResponse1;
            }
            tracesResponse1 = this.IsServerError(str8, "//div[@id=\"err_Summary\"]");
            if (tracesResponse1.Respons == eResponse.Failed)
            {
                this.Logoff();
                tracesResponse1.Respons = eResponse.Failed;
                return tracesResponse1;
            }
            string str9 = this.RetrieveElementValue(str8, "//form[@id=\"dedkyc\"]", "//input[@id=\"authcode\"]", ConnectTR.enmElementType.Value);
            Dictionary<string, string> dictionary4 = this.TraceViewStateData(str8, "//form[@id=\"dedkyc\"]");
            StringBuilder sbData4 = new StringBuilder();
            sbData4.Append("authcode=" + HttpUtility.UrlEncode(str9.Trim()));
            sbData4.Append("&redirect=" + HttpUtility.UrlEncode("Proceed with Transaction"));
            sbData4.Append("&dedkyc_SUBMIT=1");
            foreach (KeyValuePair<string, string> keyValuePair in dictionary4)
            {
                if (keyValuePair.Key == "javax.faces.ViewState")
                    sbData4.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            }
            Dictionary<string, string> dictionary5 = this.TraceViewStateData(this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3confirm.xhtml", sbData4), "//form[@id=\"downloadreqspec\"]");
            StringBuilder stringBuilder6 = new StringBuilder();
            foreach (KeyValuePair<string, string> keyValuePair in dictionary5)
            {
                if (keyValuePair.Key == "finYr")
                    stringBuilder6.Append("fy=" + keyValuePair.Value);
                if (keyValuePair.Key == "qrtr")
                {
                    if (keyValuePair.Value == "")
                        stringBuilder6.Append("&qr=0");
                    else
                        stringBuilder6.Append("&qr=" + keyValuePair.Value);
                }
                if (keyValuePair.Key == "formType")
                    stringBuilder6.Append("&ft=" + keyValuePair.Value);
                if (keyValuePair.Key == "dwldType")
                    stringBuilder6.Append("&dt=" + keyValuePair.Value);
            }
            string str10 = this.RetrieveElementValue(this.makeHTTPGetRequest(this.strBaseURL + "srv/CreateDwnldReqServlet?" + stringBuilder6.ToString()), "//div[@class='margintop20']", "//h5", ConnectTR.enmElementType.InnerText);

            ////Newly Added
            DataTable dtRequestDetails = constructRequestDtlsTbl();

            //get RequestNumber Details
            dtRequestDetails = Insert_Request_Details(str10, "NSDL Conso File", str9, objTraceData, dtRequestDetails);


            TDSResponse tracesResponse2 = new TDSResponse();
            string msg = string.Empty;
            int num = 0;
            if (!string.IsNullOrEmpty(str10))
            {
                msg = str10;
                if (objTraceData.AddlReqJustificationFile)
                {
                    tracesResponse2 = this.RequestForAddlJustificationReport(objTraceData);

                    if (tracesResponse2.Respons == eResponse.Success)
                    {
                        msg += "<br/><br/>" + tracesResponse2.Message;
                        str10 = "Consolidated Statement, Justification Report";

                        ++num;
                        dtRequestDetails = Insert_Request_Details(tracesResponse2.Message, "Justification Report", str9, objTraceData, dtRequestDetails);
                    }
                }
                if (objTraceData.AddlReqForm16AFile)
                {
                    tracesResponse2 = this.RequestForAddlForm16A(objTraceData);

                    if (tracesResponse2.Respons == eResponse.Success)
                    {
                        msg += "<br/><br/>" + tracesResponse2.Message;
                        str10 = num != 1 ? "Consolidated Statement, Form 16A" : str10 + ", Form 16A";

                        dtRequestDetails = Insert_Request_Details(tracesResponse2.Message, "Form 16A", str9, objTraceData, dtRequestDetails);
                        ++num;
                    }



                }
                if (objTraceData.AddlReqForm16File)
                {
                    tracesResponse2 = this.RequestForAddlForm16(objTraceData);

                    if (tracesResponse2.Respons == eResponse.Success)
                    {
                        msg += "<br/><br/>" + tracesResponse2.Message;
                        str10 = num != 1 ? "Consolidated Statement, Form 16 - Part A" : str10 + ", Form 16 - Part A";

                        dtRequestDetails = Insert_Request_Details(tracesResponse2.Message, "Form 16", str9, objTraceData, dtRequestDetails);

                        ++num;
                    }

                }
                if (objTraceData.AddlReqForm27DFile)
                {
                    tracesResponse2 = this.RequestForAddlForm27D(objTraceData);
                    if (tracesResponse2.Respons == eResponse.Success)
                    {
                        msg += "<br/><br/>" + tracesResponse2.Message;
                        dtRequestDetails = Insert_Request_Details(tracesResponse2.Message, "Form 27D", str9, objTraceData, dtRequestDetails);
                        str10 = num != 1 ? "Consolidated Statement, Form 27D" : str10 + ", Form 27D";
                        ++num;
                    }

                }
                if (num > 0)
                    str10 += " has been requested successfully";
                tracesResponse1.Message = msg;
                tracesResponse1.Respons = eResponse.Success;
            }
            this.Logoff();

            //Insert Record
            if (dtRequestDetails.Rows.Count > 0)
            {
                InsertRequestDetails(dtRequestDetails, objLogin, objTraceData);
            }
        }
        catch (Exception ex)
        {
            this.Logoff();
            this.bnlSessionExists = false;
            tracesResponse1.Respons = eResponse.Failed;
            tracesResponse1.Message = ex.Message;
        }
        return tracesResponse1;
    }

    public TDSResponse RequestForJustificationReportDownload(
      LoginTraces objLogin,
      TracesData objTraceData)
    {
        TDSResponse tracesResponse1 = new TDSResponse();
        try
        {
            if (!this.IsSessionExists)
            {
                tracesResponse1 = this.makeLoginToTRACES_SVC(objLogin);
                if (tracesResponse1.Respons == eResponse.Failed)
                    return tracesResponse1;
            }
            string request = this.makeHTTPGetRequest(this.strBaseURL + "ded/justrepdwnld.xhtml");
            if (!this.IsStringExists(request, "//form[@id=\"justificationForm\"]"))
            {
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return tracesResponse1;
            }
            tracesResponse1 = this.IsServerError(this.strServerResponse, "//span[@id=\"err_Summary\"]");
            if (tracesResponse1.Respons == eResponse.Failed)
            {
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.Failed;
                this.Logoff();
                return tracesResponse1;
            }
            StringBuilder sbData1 = new StringBuilder();
            sbData1.Append("finYr=" + objTraceData.FAYear);
            sbData1.Append("&qrtr=" + objTraceData.Quarter);
            sbData1.Append("&frmType=" + objTraceData.Forms);
            sbData1.Append("&download_justReport=Go");
            Dictionary<string, string> dictionary1 = this.TraceViewStateData(request, "//form[@id=\"justificationForm\"]");
            if (dictionary1.Count <= 0)
            {
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return tracesResponse1;
            }
            foreach (KeyValuePair<string, string> keyValuePair in dictionary1)
                sbData1.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            string str1 = this.makeHTTPPostRequest(this.strBaseURL + "ded/justrepdwnld.xhtml", sbData1);
            tracesResponse1 = this.IsServerError(str1, "//ul[@id=\"err_Summary\"]");
            if (tracesResponse1.Respons == eResponse.Failed)
            {
                this.Logoff();
                tracesResponse1.Respons = eResponse.Failed;
                return tracesResponse1;
            }
            if (!this.IsStringExists(str1, "//form[@id=\"dedkyc\"]"))
            {
                if (!this.IsStringExists(str1, "//form[@id=\"kycformdsc\"]"))
                {
                    this.Logoff();
                    this.bnlSessionExists = false;
                    tracesResponse1.Message = "Server Error";
                    tracesResponse1.Respons = eResponse.SessionTimeout;
                    return tracesResponse1;
                }
                Dictionary<string, string> dictionary2 = this.TraceViewStateData(str1, "//form[@id=\"kycformdsc\"]");
                if (dictionary2.Count == 0)
                {
                    this.bnlSessionExists = false;
                    tracesResponse1.Message = "Server Error";
                    tracesResponse1.Respons = eResponse.SessionTimeout;
                    return tracesResponse1;
                }
                StringBuilder sbData2 = new StringBuilder();
                foreach (KeyValuePair<string, string> keyValuePair in dictionary2)
                    sbData2.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
                sbData2.Append("&search2=on");
                sbData2.Append("&kycFinYear=" + objTraceData.FAYear);
                sbData2.Append("&kycFormType=" + objTraceData.Forms);
                sbData2.Append("&kycQrtr=" + objTraceData.Quarter);
                sbData2.Append("&kycformdsc:_idcl=nxtSrcn");
                str1 = this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3formdsc.xhtml", sbData2);
                if (!this.IsStringExists(str1, "//form[@id=\"dedkyc\"]"))
                {
                    this.Logoff();
                    this.bnlSessionExists = false;
                    tracesResponse1.Message = "Server Error";
                    tracesResponse1.Respons = eResponse.SessionTimeout;
                    return tracesResponse1;
                }
            }
            StringBuilder sbData3 = new StringBuilder();
            sbData3.Append("authcode=" + objTraceData.AuthenticationCode);
            sbData3.Append("&stmtSpecKyc=1");
            sbData3.Append("&bforeLogin=3");
            sbData3.Append("&token=" + objTraceData.PRN_NO);
            bool flag;
            if (objTraceData.IsNoChallanCheck)
            {
                StringBuilder stringBuilder = sbData3;
                flag = objTraceData.IsNoChallanCheck;
                string str2 = "&cinbinCheck=" + flag.ToString();
                stringBuilder.Append(str2);
            }
            StringBuilder stringBuilder1 = sbData3;
            flag = objTraceData.IsNoChallan;
            string str3 = "&cinbinValue=" + flag.ToString();
            stringBuilder1.Append(str3);
            StringBuilder stringBuilder2 = sbData3;
            flag = objTraceData.IsPaymentByBookAdjustmentCheck;
            string str4 = "&bkEntryFlgChk=" + flag.ToString();
            stringBuilder2.Append(str4);
            StringBuilder stringBuilder3 = sbData3;
            flag = objTraceData.IsPaymentByBookAdjustment;
            string str5 = "&bkEntryValue=" + flag.ToString();
            stringBuilder3.Append(str5);
            if (objTraceData.panAmtValueCheck)
            {
                StringBuilder stringBuilder4 = sbData3;
                flag = objTraceData.panAmtValueCheck;
                string str2 = "&panAmtCheck=" + flag.ToString();
                stringBuilder4.Append(str2);
            }
            StringBuilder stringBuilder5 = sbData3;
            flag = objTraceData.panAmtValue;
            string str6 = "&panAmtValue=" + flag.ToString();
            stringBuilder5.Append(str6);
            if (!objTraceData.IsNoChallanCheck)
            {
                sbData3.Append("&bsr=" + objTraceData.BSRCode);
                sbData3.Append("&dtoftaxdep=" + objTraceData.TaxDepositedDate);
                sbData3.Append("&csn=" + objTraceData.ChallanSerialNo);
                sbData3.Append("&chlnamt=" + objTraceData.ChallanAmount);
            }
            if (!objTraceData.panAmtValueCheck)
            {
                sbData3.Append("&pan1=" + objTraceData.PAN1);
                sbData3.Append("&amt1=" + objTraceData.PAN1Amount);
                sbData3.Append("&pan2=" + objTraceData.PAN2);
                sbData3.Append("&amt2=" + objTraceData.PAN2Amount);
                sbData3.Append("&pan3=" + objTraceData.PAN3);
                sbData3.Append("&amt3=" + objTraceData.PAN3Amount);
            }
            sbData3.Append("&clickKYC=Proceed");
            sbData3.Append("&dedkyc_SUBMIT=1");
            Dictionary<string, string> dictionary3 = this.TraceViewStateData(str1, "//form[@id=\"dedkyc\"]");
            foreach (KeyValuePair<string, string> keyValuePair in dictionary3)
                sbData3.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            if (dictionary3.Count <= 0)
            {
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return tracesResponse1;
            }
            string str7 = this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3form.xhtml", sbData3);
            if (!this.IsStringExists(str7, "//form[@id=\"dedkyc\"]"))
            {
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return tracesResponse1;
            }
            tracesResponse1 = this.IsServerError(str7, "//div[@id=\"err_Summary\"]");
            if (tracesResponse1.Respons == eResponse.Failed)
            {
                tracesResponse1.Respons = eResponse.Failed;
                this.Logoff();
                return tracesResponse1;
            }
            string str8 = this.RetrieveElementValue(str7, "//form[@id=\"dedkyc\"]", "//input[@id=\"authcode\"]", ConnectTR.enmElementType.Value);
            Dictionary<string, string> dictionary4 = this.TraceViewStateData(str7, "//form[@id=\"dedkyc\"]");
            StringBuilder sbData4 = new StringBuilder();
            sbData4.Append("authcode=" + HttpUtility.UrlEncode(str8.Trim()));
            sbData4.Append("&redirect=" + HttpUtility.UrlEncode("Proceed with Transaction"));
            sbData4.Append("&dedkyc_SUBMIT=1");
            foreach (KeyValuePair<string, string> keyValuePair in dictionary4)
            {
                if (keyValuePair.Key == "javax.faces.ViewState")
                    sbData4.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            }
            Dictionary<string, string> dictionary5 = this.TraceViewStateData(this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3confirm.xhtml", sbData4), "//form[@id=\"downloadreqspec\"]");
            StringBuilder stringBuilder6 = new StringBuilder();
            foreach (KeyValuePair<string, string> keyValuePair in dictionary5)
            {
                if (keyValuePair.Key == "finYr")
                    stringBuilder6.Append("fy=" + keyValuePair.Value);
                if (keyValuePair.Key == "qrtr")
                {
                    if (keyValuePair.Value == "")
                        stringBuilder6.Append("&qr=0");
                    else
                        stringBuilder6.Append("&qr=" + keyValuePair.Value);
                }
                if (keyValuePair.Key == "formType")
                    stringBuilder6.Append("&ft=" + keyValuePair.Value);
                if (keyValuePair.Key == "dwldType")
                    stringBuilder6.Append("&dt=" + keyValuePair.Value);
            }
            string str9 = this.RetrieveElementValue(this.makeHTTPGetRequest(this.strBaseURL + "srv/CreateDwnldReqServlet?" + stringBuilder6.ToString()), "//div[@class='margintop20']", "//h5", ConnectTR.enmElementType.InnerText);
            TDSResponse tracesResponse2 = new TDSResponse();
            int num = 0;
            ////Newly Added
            DataTable dtRequestDetails = constructRequestDtlsTbl();
            string msg = string.Empty;
            if (!string.IsNullOrEmpty(str9))
            {
                msg = str9;
                dtRequestDetails = Insert_Request_Details(str9, "Justification Report", str8, objTraceData, dtRequestDetails);


                if (objTraceData.AddlReqConsoFile)
                {
                    tracesResponse2 = this.RequestForAddlConsoFile(objTraceData);
                    if (tracesResponse2.Respons == eResponse.Success)
                    {
                        msg += "<br/><br/>" + tracesResponse2.Message;
                        dtRequestDetails = Insert_Request_Details(tracesResponse2.Message, "NSDL Conso File", str8, objTraceData, dtRequestDetails);
                        str9 = "Justification Report, Conso file";
                        ++num;
                    }
                }
                if (objTraceData.AddlReqForm16AFile)
                {
                    tracesResponse2 = this.RequestForAddlForm16A(objTraceData);
                    if (tracesResponse2.Respons == eResponse.Success)
                    {
                        msg += "<br/><br/>" + tracesResponse2.Message;
                        dtRequestDetails = Insert_Request_Details(tracesResponse2.Message, "Form 16A", str8, objTraceData, dtRequestDetails);
                        str9 = num != 1 ? "Justification Report, Form 16A" : str9 + ", Form 16A";
                        ++num;
                    }


                }
                if (objTraceData.AddlReqForm16File)
                {
                    tracesResponse2 = this.RequestForAddlForm16(objTraceData);
                    if (tracesResponse2.Respons == eResponse.Success)
                    {
                        msg += "<br/><br/>" + tracesResponse2.Message;
                        dtRequestDetails = Insert_Request_Details(tracesResponse2.Message, "Form 16", str8, objTraceData, dtRequestDetails);
                        str9 = num != 1 ? "Justification Report, Form 16 - Part A" : str9 + ", Form 16 - Part A";
                        ++num;
                    }
                }
                if (objTraceData.AddlReqForm27DFile)
                {
                    tracesResponse2 = this.RequestForAddlForm27D(objTraceData);
                    if (tracesResponse2.Respons == eResponse.Success)
                    {
                        msg += "<br/><br/>" + tracesResponse2.Message;
                        dtRequestDetails = Insert_Request_Details(tracesResponse2.Message, "Form 27D", str8, objTraceData, dtRequestDetails);

                        str9 = num != 1 ? "Justification Report, Form 27D" : str9 + ", Form 27D";
                        ++num;
                    }

                }
                if (num > 0)
                    str9 += " has been requested successfully";

                tracesResponse1.Message = msg;
                tracesResponse1.Respons = eResponse.Success;
            }
            this.Logoff();
            if (dtRequestDetails.Rows.Count > 0)
            {
                InsertRequestDetails(dtRequestDetails, objLogin, objTraceData);
            }
        }
        catch (Exception ex)
        {
            tracesResponse1.Respons = eResponse.Failed;
            tracesResponse1.Message = ex.Message;
            this.Logoff();
        }
        return tracesResponse1;
    }

    public TDSResponse RequestForDownloadForm16A(
      LoginTraces objLogin,
      TracesData objTraceData)
    {
        TDSResponse tracesResponse1 = new TDSResponse();
        try
        {
            if (!this.IsSessionExists)
            {
                tracesResponse1 = this.makeLoginToTRACES_SVC(objLogin);
                if (tracesResponse1.Respons == eResponse.Failed)
                    return tracesResponse1;
            }
            string request = this.makeHTTPGetRequest(this.strBaseURL + "ded/download16a.xhtml");
            if (!this.IsStringExists(request, "//form[@id=\"bulkSearch\"]"))
            {
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return tracesResponse1;
            }
            StringBuilder sbData1 = new StringBuilder();
            sbData1.Append("dwnldFormBulkType=14");
            sbData1.Append("&bulkfinYr=" + objTraceData.FAYear);
            sbData1.Append("&bulkquarter=" + objTraceData.Quarter);
            sbData1.Append("&bulkformType=" + objTraceData.Forms);
            sbData1.Append("&bulkGo=Go");
            sbData1.Append("&bulkSearch_SUBMIT=1");
            Dictionary<string, string> dictionary1 = this.TraceViewStateData(request, "//form[@id=\"bulkSearch\"]");
            if (dictionary1.Count <= 0)
            {
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return tracesResponse1;
            }
            foreach (KeyValuePair<string, string> keyValuePair in dictionary1)
            {
                if (keyValuePair.Key == "javax.faces.ViewState")
                {
                    sbData1.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
                    break;
                }
            }
            string str1 = this.makeHTTPPostRequest(this.strBaseURL + "ded/download16a.xhtml", sbData1);
            tracesResponse1 = this.IsServerError(str1, "//ul[@id=\"err_Summary\"]");
            if (tracesResponse1.Respons == eResponse.Failed)
            {
                tracesResponse1.Respons = eResponse.Failed;
                this.Logoff();
                return tracesResponse1;
            }
            if (!this.IsStringExists(str1, "//form[@id=\"deducteeDetails\"]"))
            {
                if (!this.IsStringExists(str1, "//form[@id=\"tabContentForm\"]"))
                {
                    tracesResponse1.Message = "Server Error";
                    tracesResponse1.Respons = eResponse.SessionTimeout;
                    this.Logoff();
                    return tracesResponse1;
                }
                Dictionary<string, string> dictionary2 = this.TraceViewStateData(str1, "//form[@id=\"tabContentForm\"]");
                string str2 = "";
                foreach (KeyValuePair<string, string> keyValuePair in dictionary2)
                {
                    if (keyValuePair.Key == "dwnldType")
                    {
                        str2 = keyValuePair.Value;
                        break;
                    }
                }
                str1 = this.makeHTTPGetRequest(this.strBaseURL + "ded/form16adetls.xhtml?qr=" + objTraceData.Quarter + "&ft=" + objTraceData.Forms + "&fy=" + objTraceData.FAYear + "&download=" + str2);
            }
            Dictionary<string, string> dictionary3 = this.TraceViewStateData(str1, "//form[@id=\"deducteeDetails\"]");
            if (dictionary3.Count <= 0)
            {
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return tracesResponse1;
            }
            StringBuilder sbData2 = new StringBuilder();
            sbData2.Append("j_id1972728517_7cc7de5f=submit");
            foreach (KeyValuePair<string, string> keyValuePair in dictionary3)
                sbData2.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            string str3 = this.makeHTTPPostRequest(this.strBaseURL + "ded/form16adetls.xhtml", sbData2);
            if (!this.IsStringExists(str3, "//form[@id=\"dedkyc\"]"))
            {
                if (!this.IsStringExists(str3, "//form[@id=\"kycformdsc\"]"))
                {
                    this.Logoff();
                    this.bnlSessionExists = false;
                    tracesResponse1.Message = "Server Error";
                    tracesResponse1.Respons = eResponse.SessionTimeout;
                    return tracesResponse1;
                }
                Dictionary<string, string> dictionary2 = this.TraceViewStateData(str3, "//form[@id=\"kycformdsc\"]");
                if (dictionary2.Count == 0)
                {
                    this.bnlSessionExists = false;
                    tracesResponse1.Message = "Server Error";
                    tracesResponse1.Respons = eResponse.SessionTimeout;
                    return tracesResponse1;
                }
                StringBuilder sbData3 = new StringBuilder();
                foreach (KeyValuePair<string, string> keyValuePair in dictionary2)
                    sbData3.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
                sbData3.Append("&search2=on");
                sbData3.Append("&kycFinYear=" + objTraceData.FAYear);
                sbData3.Append("&kycFormType=" + objTraceData.Forms);
                sbData3.Append("&kycQrtr=" + objTraceData.Quarter);
                sbData3.Append("&kycformdsc:_idcl=nxtSrcn");
                str3 = this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3formdsc.xhtml", sbData3);
                if (!this.IsStringExists(str3, "//form[@id=\"dedkyc\"]"))
                {
                    this.Logoff();
                    this.bnlSessionExists = false;
                    tracesResponse1.Message = "Server Error";
                    tracesResponse1.Respons = eResponse.SessionTimeout;
                    return tracesResponse1;
                }
            }
            StringBuilder sbData4 = new StringBuilder();
            sbData4.Append("authcode=" + objTraceData.AuthenticationCode);
            sbData4.Append("&stmtSpecKyc=1");
            sbData4.Append("&bforeLogin=3");
            sbData4.Append("&token=" + objTraceData.PRN_NO);
            bool flag;
            if (objTraceData.IsNoChallanCheck)
            {
                StringBuilder stringBuilder = sbData4;
                flag = objTraceData.IsNoChallanCheck;
                string str2 = "&cinbinCheck=" + flag.ToString();
                stringBuilder.Append(str2);
            }
            StringBuilder stringBuilder1 = sbData4;
            flag = objTraceData.IsNoChallan;
            string str4 = "&cinbinValue=" + flag.ToString();
            stringBuilder1.Append(str4);
            StringBuilder stringBuilder2 = sbData4;
            flag = objTraceData.IsPaymentByBookAdjustmentCheck;
            string str5 = "&bkEntryFlgChk=" + flag.ToString();
            stringBuilder2.Append(str5);
            StringBuilder stringBuilder3 = sbData4;
            flag = objTraceData.IsPaymentByBookAdjustment;
            string str6 = "&bkEntryValue=" + flag.ToString();
            stringBuilder3.Append(str6);
            if (objTraceData.panAmtValueCheck)
            {
                StringBuilder stringBuilder4 = sbData4;
                flag = objTraceData.panAmtValueCheck;
                string str2 = "&panAmtCheck=" + flag.ToString();
                stringBuilder4.Append(str2);
            }
            StringBuilder stringBuilder5 = sbData4;
            flag = objTraceData.panAmtValue;
            string str7 = "&panAmtValue=" + flag.ToString();
            stringBuilder5.Append(str7);
            if (!objTraceData.IsNoChallanCheck)
            {
                sbData4.Append("&bsr=" + objTraceData.BSRCode);
                sbData4.Append("&dtoftaxdep=" + objTraceData.TaxDepositedDate);
                sbData4.Append("&csn=" + objTraceData.ChallanSerialNo);
                sbData4.Append("&chlnamt=" + objTraceData.ChallanAmount);
            }
            if (!objTraceData.panAmtValueCheck)
            {
                sbData4.Append("&pan1=" + objTraceData.PAN1);
                sbData4.Append("&amt1=" + objTraceData.PAN1Amount);
                sbData4.Append("&pan2=" + objTraceData.PAN2);
                sbData4.Append("&amt2=" + objTraceData.PAN2Amount);
                sbData4.Append("&pan3=" + objTraceData.PAN3);
                sbData4.Append("&amt3=" + objTraceData.PAN3Amount);
            }
            sbData4.Append("&clickKYC=Proceed");
            sbData4.Append("&dedkyc_SUBMIT=1");
            Dictionary<string, string> dictionary4 = this.TraceViewStateData(str3, "//form[@id=\"dedkyc\"]");
            foreach (KeyValuePair<string, string> keyValuePair in dictionary4)
                sbData4.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            if (dictionary4.Count <= 0)
            {
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                return tracesResponse1;
            }
            string str8 = this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3form.xhtml", sbData4);
            if (!this.IsStringExists(str8, "//form[@id=\"dedkyc\"]"))
            {
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                return tracesResponse1;
            }
            tracesResponse1 = this.IsServerError(str8, "//div[@id=\"err_Summary\"]");
            if (tracesResponse1.Respons == eResponse.Failed)
            {
                tracesResponse1.Respons = eResponse.Failed;
                return tracesResponse1;
            }
            string str9 = this.RetrieveElementValue(str8, "//form[@id=\"dedkyc\"]", "//input[@id=\"authcode\"]", ConnectTR.enmElementType.Value);
            Dictionary<string, string> dictionary5 = this.TraceViewStateData(str8, "//form[@id=\"dedkyc\"]");
            StringBuilder sbData5 = new StringBuilder();
            sbData5.Append("authcode=" + HttpUtility.UrlEncode(str9.Trim()));
            sbData5.Append("&redirect=" + HttpUtility.UrlEncode("Proceed with Transaction"));
            sbData5.Append("&dedkyc_SUBMIT=1");
            foreach (KeyValuePair<string, string> keyValuePair in dictionary5)
            {
                if (keyValuePair.Key == "javax.faces.ViewState")
                    sbData5.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            }
            string str10 = this.RetrieveElementValue(this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3confirm.xhtml", sbData5), "//div[@class='margintop20']", "//h5", ConnectTR.enmElementType.InnerText);
            ////Newly Added
            DataTable dtRequestDetails = constructRequestDtlsTbl();
            string msg = string.Empty;

            int num = 0;
            if (!string.IsNullOrEmpty(str10))
            {
                msg = str10;
                dtRequestDetails = Insert_Request_Details(str10, "Form 16A", str9, objTraceData, dtRequestDetails);

                TDSResponse tracesResponse2 = new TDSResponse();

                if (objTraceData.AddlReqConsoFile)
                {
                    tracesResponse2 = this.RequestForAddlConsoFile(objTraceData);
                    if (tracesResponse2.Respons == eResponse.Success)
                    {
                        dtRequestDetails = Insert_Request_Details(tracesResponse2.Message, "NSDL Conso File", str9, objTraceData, dtRequestDetails);
                        msg += "<br/><br/>" + tracesResponse2.Message;
                        str10 = "Form 16A, Conso file";
                        ++num;
                    }


                }
                if (objTraceData.AddlReqJustificationFile)
                {
                    tracesResponse2 = this.RequestForAddlConsoFile(objTraceData);
                    if (tracesResponse2.Respons == eResponse.Success)
                    {
                        dtRequestDetails = Insert_Request_Details(tracesResponse2.Message, "Justification Report", str9, objTraceData, dtRequestDetails);
                        msg += "<br/><br/>" + tracesResponse2.Message;
                        str10 = num != 1 ? "Form 16A, Justification Report" : str10 + ", Justification Report";
                        ++num;
                    }

                }
                if (num > 0)
                    str10 += " has been requested successfully";

                if (dtRequestDetails.Rows.Count > 0)
                {
                    InsertRequestDetails(dtRequestDetails, objLogin, objTraceData);
                }
                tracesResponse1.Message = msg;
                tracesResponse1.Respons = eResponse.Success;
            }
            this.Logoff();
        }
        catch (Exception ex)
        {
            tracesResponse1.Respons = eResponse.Failed;
            tracesResponse1.Message = ex.Message;
            this.Logoff();
        }
        return tracesResponse1;
    }

    public TDSResponse RequestForDownloadForm16(
      LoginTraces objLogin,
      TracesData objTraceData)
    {
        TDSResponse tracesResponse1 = new TDSResponse();
        try
        {
            if (!this.IsSessionExists)
            {
                tracesResponse1 = this.makeLoginToTRACES_SVC(objLogin);
                if (tracesResponse1.Respons == eResponse.Failed)
                    return tracesResponse1;
            }
            string request = this.makeHTTPGetRequest(this.strBaseURL + "ded/download16.xhtml");
            if (!this.IsStringExists(request, "//form[@id=\"bulkPan\"]"))
            {
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return tracesResponse1;
            }
            StringBuilder sbData1 = new StringBuilder();
            sbData1.Append("dwnldFormBulkType=13");
            sbData1.Append("&bulkfinYr=" + objTraceData.FAYear);
            sbData1.Append("&bulkGo=Go");
            sbData1.Append("&bulkPan_SUBMIT=1");
            Dictionary<string, string> dictionary1 = this.TraceViewStateData(request, "//form[@id=\"bulkPan\"]");
            if (dictionary1.Count <= 0)
            {
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return tracesResponse1;
            }
            foreach (KeyValuePair<string, string> keyValuePair in dictionary1)
            {
                if (keyValuePair.Key == "javax.faces.ViewState")
                {
                    sbData1.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
                    break;
                }
            }
            string str1 = this.makeHTTPPostRequest(this.strBaseURL + "ded/download16.xhtml", sbData1);
            tracesResponse1 = this.IsServerError(str1, "//ul[@id=\"err_Summary\"]");
            if (tracesResponse1.Respons == eResponse.Failed)
            {
                tracesResponse1.Respons = eResponse.Failed;
                return tracesResponse1;
            }
            if (!this.IsStringExists(str1, "//form[@id=\"deducteeDetails\"]") && !this.IsStringExists(this.strServerResponse, "//form[@id=\"tabContentForm\"]"))
            {
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.Failed;
                return tracesResponse1;
            }
            if (this.IsStringExists(this.strServerResponse, "//form[@id=\"tabContentForm\"]"))
            {
                Dictionary<string, string> dictionary2 = this.TraceViewStateData(this.strServerResponse, "//form[@id=\"tabContentForm\"]");
                if (dictionary2.Count <= 0)
                {
                    tracesResponse1.Message = "Server Error";
                    tracesResponse1.Respons = eResponse.Failed;
                    return tracesResponse1;
                }
                string str2 = "qr=6";
                StringBuilder stringBuilder = new StringBuilder();
                foreach (KeyValuePair<string, string> keyValuePair in dictionary2)
                {
                    if (keyValuePair.Key == "frmType")
                        str2 = str2 + "&ft=" + HttpUtility.UrlEncode(keyValuePair.Value);
                    else if (keyValuePair.Key == "finYear")
                        str2 = str2 + "&fy=" + HttpUtility.UrlEncode(keyValuePair.Value);
                    else if (keyValuePair.Key == "dwnldType")
                        str2 = str2 + "&download=" + HttpUtility.UrlEncode(keyValuePair.Value);
                }
                this.strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "ded/form16adetls.xhtml?" + str2);
                if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"deducteeDetails\"]"))
                {
                    tracesResponse1.Message = "Server Error";
                    tracesResponse1.Respons = eResponse.Failed;
                    this.Logoff();
                    return tracesResponse1;
                }
                tracesResponse1 = this.IsServerError(this.strServerResponse, "//ul[@id=\"err_Summary\"]");
                str1 = this.strServerResponse;
                if (tracesResponse1.Respons == eResponse.Failed)
                {
                    this.Logoff();
                    return tracesResponse1;
                }
            }
            Dictionary<string, string> dictionary3 = this.TraceViewStateData(str1, "//form[@id=\"deducteeDetails\"]");
            if (dictionary3.Count <= 0)
            {
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                return tracesResponse1;
            }
            StringBuilder sbData2 = new StringBuilder();
            sbData2.Append("j_id1972728517_7cc7de5f=submit");
            foreach (KeyValuePair<string, string> keyValuePair in dictionary3)
                sbData2.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            string str3 = this.makeHTTPPostRequest(this.strBaseURL + "ded/form16adetls.xhtml", sbData2);
            if (!this.IsStringExists(str3, "//form[@id=\"dedkyc\"]"))
            {
                if (!this.IsStringExists(str3, "//form[@id=\"kycformdsc\"]"))
                {
                    this.Logoff();
                    this.bnlSessionExists = false;
                    tracesResponse1.Message = "Server Error";
                    tracesResponse1.Respons = eResponse.SessionTimeout;
                    return tracesResponse1;
                }
                Dictionary<string, string> dictionary2 = this.TraceViewStateData(str3, "//form[@id=\"kycformdsc\"]");
                if (dictionary2.Count == 0)
                {
                    this.bnlSessionExists = false;
                    tracesResponse1.Message = "Server Error";
                    tracesResponse1.Respons = eResponse.SessionTimeout;
                    return tracesResponse1;
                }
                StringBuilder sbData3 = new StringBuilder();
                foreach (KeyValuePair<string, string> keyValuePair in dictionary2)
                    sbData3.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
                sbData3.Append("&search2=on");
                sbData3.Append("&kycFinYear=" + objTraceData.FAYear);
                sbData3.Append("&kycFormType=" + objTraceData.Forms);
                sbData3.Append("&kycQrtr=" + objTraceData.Quarter);
                sbData3.Append("&kycformdsc:_idcl=nxtSrcn");
                str3 = this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3formdsc.xhtml", sbData3);
                if (!this.IsStringExists(str3, "//form[@id=\"dedkyc\"]"))
                {
                    this.Logoff();
                    this.bnlSessionExists = false;
                    tracesResponse1.Message = "Server Error";
                    tracesResponse1.Respons = eResponse.SessionTimeout;
                    return tracesResponse1;
                }
            }
            StringBuilder sbData4 = new StringBuilder();
            sbData4.Append("authcode=" + objTraceData.AuthenticationCode);
            sbData4.Append("&stmtSpecKyc=1");
            sbData4.Append("&bforeLogin=3");
            sbData4.Append("&token=" + objTraceData.PRN_NO);
            bool flag;
            if (objTraceData.IsNoChallanCheck)
            {
                StringBuilder stringBuilder = sbData4;
                flag = objTraceData.IsNoChallanCheck;
                string str2 = "&cinbinCheck=" + flag.ToString();
                stringBuilder.Append(str2);
            }
            StringBuilder stringBuilder1 = sbData4;
            flag = objTraceData.IsNoChallan;
            string str4 = "&cinbinValue=" + flag.ToString();
            stringBuilder1.Append(str4);
            StringBuilder stringBuilder2 = sbData4;
            flag = objTraceData.IsPaymentByBookAdjustmentCheck;
            string str5 = "&bkEntryFlgChk=" + flag.ToString();
            stringBuilder2.Append(str5);
            StringBuilder stringBuilder3 = sbData4;
            flag = objTraceData.IsPaymentByBookAdjustment;
            string str6 = "&bkEntryValue=" + flag.ToString();
            stringBuilder3.Append(str6);
            if (objTraceData.panAmtValueCheck)
            {
                StringBuilder stringBuilder4 = sbData4;
                flag = objTraceData.panAmtValueCheck;
                string str2 = "&panAmtCheck=" + flag.ToString();
                stringBuilder4.Append(str2);
            }
            StringBuilder stringBuilder5 = sbData4;
            flag = objTraceData.panAmtValue;
            string str7 = "&panAmtValue=" + flag.ToString();
            stringBuilder5.Append(str7);
            if (!objTraceData.IsNoChallanCheck)
            {
                sbData4.Append("&bsr=" + objTraceData.BSRCode);
                sbData4.Append("&dtoftaxdep=" + objTraceData.TaxDepositedDate);
                sbData4.Append("&csn=" + objTraceData.ChallanSerialNo);
                sbData4.Append("&chlnamt=" + objTraceData.ChallanAmount);
            }
            if (!objTraceData.panAmtValueCheck)
            {
                sbData4.Append("&pan1=" + objTraceData.PAN1);
                sbData4.Append("&amt1=" + objTraceData.PAN1Amount);
                sbData4.Append("&pan2=" + objTraceData.PAN2);
                sbData4.Append("&amt2=" + objTraceData.PAN2Amount);
                sbData4.Append("&pan3=" + objTraceData.PAN3);
                sbData4.Append("&amt3=" + objTraceData.PAN3Amount);
            }
            sbData4.Append("&clickKYC=Proceed");
            sbData4.Append("&dedkyc_SUBMIT=1");
            Dictionary<string, string> dictionary4 = this.TraceViewStateData(str3, "//form[@id=\"dedkyc\"]");
            foreach (KeyValuePair<string, string> keyValuePair in dictionary4)
                sbData4.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            if (dictionary4.Count <= 0)
            {
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return tracesResponse1;
            }
            string str8 = this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3form.xhtml", sbData4);
            if (!this.IsStringExists(str8, "//form[@id=\"dedkyc\"]"))
            {
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return tracesResponse1;
            }
            tracesResponse1 = this.IsServerError(str8, "//div[@id=\"err_Summary\"]");
            if (tracesResponse1.Respons == eResponse.Failed)
            {
                tracesResponse1.Respons = eResponse.Failed;
                this.Logoff();
                return tracesResponse1;
            }
            string str9 = this.RetrieveElementValue(str8, "//form[@id=\"dedkyc\"]", "//input[@id=\"authcode\"]", ConnectTR.enmElementType.Value);
            Dictionary<string, string> dictionary5 = this.TraceViewStateData(str8, "//form[@id=\"dedkyc\"]");
            StringBuilder sbData5 = new StringBuilder();
            sbData5.Append("authcode=" + HttpUtility.UrlEncode(str9.Trim()));
            sbData5.Append("&redirect=" + HttpUtility.UrlEncode("Proceed with Transaction"));
            sbData5.Append("&dedkyc_SUBMIT=1");
            foreach (KeyValuePair<string, string> keyValuePair in dictionary5)
            {
                if (keyValuePair.Key == "javax.faces.ViewState")
                    sbData5.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            }
            string str10 = this.RetrieveElementValue(this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3confirm.xhtml", sbData5), "//div[@class='margintop20']", "//h5", ConnectTR.enmElementType.InnerText);



            int num = 0;

            ////Newly Added
            DataTable dtRequestDetails = constructRequestDtlsTbl();
            string msg = string.Empty;

            if (!string.IsNullOrEmpty(str10))
            {
                msg = str10;

                dtRequestDetails = Insert_Request_Details(str10, "Form 16", str9, objTraceData, dtRequestDetails);

                TDSResponse tracesResponse2 = new TDSResponse();
                if (objTraceData.AddlReqConsoFile)
                {
                    tracesResponse2 = this.RequestForAddlConsoFile(objTraceData);
                    if (tracesResponse2.Respons == eResponse.Success)
                    {
                        dtRequestDetails = Insert_Request_Details(tracesResponse2.Message, "NSDL Conso File", str9, objTraceData, dtRequestDetails);
                        str10 = "Form 16 - Part A, Conso file";
                        msg += "<br/><br/>" + tracesResponse2.Message;
                        ++num;
                    }


                }
                if (objTraceData.AddlReqJustificationFile)
                {
                    tracesResponse2 = this.RequestForAddlJustificationReport(objTraceData);
                    if (tracesResponse2.Respons == eResponse.Success)
                    {
                        dtRequestDetails = Insert_Request_Details(tracesResponse2.Message, "Justification Report", str9, objTraceData, dtRequestDetails);
                        str10 = num != 1 ? "Form 16 - Part A, Justification Report" : str10 + ", Justification Report";
                        msg += "<br/><br/>" + tracesResponse2.Message;
                        ++num;
                    }

                }
                if (num > 0)
                    str10 += " has been requested successfully";
                tracesResponse1.Message = msg;
                tracesResponse1.Respons = eResponse.Success;
            }
            this.Logoff();
            //insert request details
            if (dtRequestDetails.Rows.Count > 0)
            {
                InsertRequestDetails(dtRequestDetails, objLogin, objTraceData);
            }
        }
        catch (Exception ex)
        {
            tracesResponse1.Respons = eResponse.Failed;
            tracesResponse1.Message = ex.Message;
            this.Logoff();
        }
        return tracesResponse1;
    }

    public TDSResponse RequestForDownloadForm27D(
      LoginTraces objLogin,
      TracesData objTraceData)
    {
        TDSResponse tracesResponse1 = new TDSResponse();
        try
        {
            if (!this.IsSessionExists)
            {
                tracesResponse1 = this.makeLoginToTRACES(objLogin);
                if (tracesResponse1.Respons == eResponse.Failed)
                    return tracesResponse1;
            }
            string request = this.makeHTTPGetRequest(this.strBaseURL + "ded/download27d.xhtml");
            if (!this.IsStringExists(request, "//form[@id=\"bulkSearch\"]"))
            {
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return tracesResponse1;
            }
            StringBuilder sbData1 = new StringBuilder();
            sbData1.Append("dwnldFormBulkType=19");
            sbData1.Append("&bulkfinYr=" + objTraceData.FAYear);
            sbData1.Append("&bulkquarter=" + objTraceData.Quarter);
            sbData1.Append("&bulkGo=Go");
            sbData1.Append("&bulkSearch_SUBMIT=1");
            Dictionary<string, string> dictionary1 = this.TraceViewStateData(request, "//form[@id=\"bulkSearch\"]");
            if (dictionary1.Count <= 0)
            {
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return tracesResponse1;
            }
            foreach (KeyValuePair<string, string> keyValuePair in dictionary1)
            {
                if (keyValuePair.Key == "javax.faces.ViewState")
                {
                    sbData1.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
                    break;
                }
            }
            string str1 = this.makeHTTPPostRequest(this.strBaseURL + "ded/download27d.xhtml", sbData1);
            tracesResponse1 = this.IsServerError(str1, "//ul[@id=\"err_Summary\"]");
            if (tracesResponse1.Respons == eResponse.Failed)
            {
                tracesResponse1.Respons = eResponse.Failed;
                this.Logoff();
                return tracesResponse1;
            }
            if (!this.IsStringExists(str1, "//form[@id=\"deducteeDetails\"]"))
            {
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return tracesResponse1;
            }
            Dictionary<string, string> dictionary2 = this.TraceViewStateData(str1, "//form[@id=\"deducteeDetails\"]");
            if (dictionary2.Count <= 0)
            {
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return tracesResponse1;
            }
            StringBuilder sbData2 = new StringBuilder();
            sbData2.Append("j_id2143335333_643da170=submit");
            foreach (KeyValuePair<string, string> keyValuePair in dictionary2)
                sbData2.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            string str2 = this.makeHTTPPostRequest(this.strBaseURL + "ded/form27ddetls.xhtml", sbData2);
            if (!this.IsStringExists(str2, "//form[@id=\"dedkyc1\"]"))
            {
                if (!this.IsStringExists(str2, "//form[@id=\"kycformdsc\"]"))
                {
                    this.Logoff();
                    this.bnlSessionExists = false;
                    tracesResponse1.Message = "Server Error";
                    tracesResponse1.Respons = eResponse.SessionTimeout;
                    return tracesResponse1;
                }
                Dictionary<string, string> dictionary3 = this.TraceViewStateData(str2, "//form[@id=\"kycformdsc\"]");
                if (dictionary3.Count == 0)
                {
                    this.bnlSessionExists = false;
                    tracesResponse1.Message = "Server Error";
                    tracesResponse1.Respons = eResponse.SessionTimeout;
                    return tracesResponse1;
                }
                StringBuilder sbData3 = new StringBuilder();
                foreach (KeyValuePair<string, string> keyValuePair in dictionary3)
                    sbData3.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
                sbData3.Append("&search2=on");
                sbData3.Append("&kycFinYear=" + objTraceData.FAYear);
                sbData3.Append("&kycFormType=" + objTraceData.Forms);
                sbData3.Append("&kycQrtr=" + objTraceData.Quarter);
                sbData3.Append("&kycformdsc:_idcl=nxtSrcn");
                str2 = this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3formdsc.xhtml", sbData3);
                if (!this.IsStringExists(str2, "//form[@id=\"dedkyc\"]"))
                {
                    this.Logoff();
                    this.bnlSessionExists = false;
                    tracesResponse1.Message = "Server Error";
                    tracesResponse1.Respons = eResponse.SessionTimeout;
                    return tracesResponse1;
                }
            }
            StringBuilder sbData4 = new StringBuilder();
            sbData4.Append("&stmtSpecKyc=1");
            sbData4.Append("&bforeLogin=3");
            sbData4.Append("&token=" + objTraceData.PRN_NO);
            bool flag;
            if (objTraceData.IsNoChallanCheck)
            {
                StringBuilder stringBuilder = sbData4;
                flag = objTraceData.IsNoChallanCheck;
                string str3 = "&cinbinCheck=" + flag.ToString();
                stringBuilder.Append(str3);
            }
            StringBuilder stringBuilder1 = sbData4;
            flag = objTraceData.IsNoChallan;
            string str4 = "&cinbinValue=" + flag.ToString();
            stringBuilder1.Append(str4);
            StringBuilder stringBuilder2 = sbData4;
            flag = objTraceData.IsPaymentByBookAdjustmentCheck;
            string str5 = "&bkEntryFlgChk=" + flag.ToString();
            stringBuilder2.Append(str5);
            StringBuilder stringBuilder3 = sbData4;
            flag = objTraceData.IsPaymentByBookAdjustment;
            string str6 = "&bkEntryValue=" + flag.ToString();
            stringBuilder3.Append(str6);
            if (objTraceData.panAmtValueCheck)
            {
                StringBuilder stringBuilder4 = sbData4;
                flag = objTraceData.panAmtValueCheck;
                string str3 = "&panAmtCheck=" + flag.ToString();
                stringBuilder4.Append(str3);
            }
            StringBuilder stringBuilder5 = sbData4;
            flag = objTraceData.panAmtValue;
            string str7 = "&panAmtValue=" + flag.ToString();
            stringBuilder5.Append(str7);
            if (!objTraceData.IsNoChallanCheck)
            {
                sbData4.Append("&bsr=" + objTraceData.BSRCode);
                sbData4.Append("&dtoftaxdep=" + objTraceData.TaxDepositedDate);
                sbData4.Append("&csn=" + objTraceData.ChallanSerialNo);
                sbData4.Append("&chlnamt=" + objTraceData.ChallanAmount);
            }
            if (!objTraceData.panAmtValueCheck)
            {
                sbData4.Append("&pan1=" + objTraceData.PAN1);
                sbData4.Append("&amt1=" + objTraceData.PAN1Amount);
                sbData4.Append("&pan2=" + objTraceData.PAN2);
                sbData4.Append("&amt2=" + objTraceData.PAN2Amount);
                sbData4.Append("&pan3=" + objTraceData.PAN3);
                sbData4.Append("&amt3=" + objTraceData.PAN3Amount);
            }
            sbData4.Append("&clickKYC=Proceed");
            sbData4.Append("&dedkyc_SUBMIT=1");
            Dictionary<string, string> dictionary4 = this.TraceViewStateData(str2, "//form[@id=\"dedkyc1\"]");
            foreach (KeyValuePair<string, string> keyValuePair in dictionary4)
                sbData4.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            if (dictionary4.Count <= 0)
            {
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return tracesResponse1;
            }
            string str8 = this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3form.xhtml", sbData4);
            if (!this.IsStringExists(str8, "//form[@id=\"dedkyc\"]"))
            {
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return tracesResponse1;
            }
            tracesResponse1 = this.IsServerError(str8, "//div[@id=\"err_Summary\"]");
            if (tracesResponse1.Respons == eResponse.Failed)
            {
                tracesResponse1.Respons = eResponse.Failed;
                this.Logoff();
                return tracesResponse1;
            }
            string str9 = this.RetrieveElementValue(str8, "//form[@id=\"dedkyc\"]", "//input[@id=\"authcode\"]", ConnectTR.enmElementType.Value);
            Dictionary<string, string> dictionary5 = this.TraceViewStateData(str8, "//form[@id=\"dedkyc\"]");
            StringBuilder sbData5 = new StringBuilder();
            sbData5.Append("authcode=" + HttpUtility.UrlEncode(str9.Trim()));
            sbData5.Append("&redirect=" + HttpUtility.UrlEncode("Proceed with Transaction"));
            sbData5.Append("&dedkyc_SUBMIT=1");
            foreach (KeyValuePair<string, string> keyValuePair in dictionary5)
            {
                if (keyValuePair.Key == "javax.faces.ViewState")
                    sbData5.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            }
            string str10 = this.RetrieveElementValue(this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3confirm.xhtml", sbData5), "//div[@class='margintop20']", "//h5[@id='Form16a']", ConnectTR.enmElementType.InnerText);
            TDSResponse tracesResponse2 = new TDSResponse();
            int num = 0;
            ////Newly Added
            DataTable dtRequestDetails = constructRequestDtlsTbl();
            string msg = string.Empty;
            if (!string.IsNullOrEmpty(str10))
            {
                msg = str10;
                dtRequestDetails = Insert_Request_Details(str10, "Form 27D", str9, objTraceData, dtRequestDetails);


                if (objTraceData.AddlReqConsoFile)
                {
                    tracesResponse2 = this.RequestForAddlConsoFile(objTraceData);
                    if (tracesResponse2.Respons == eResponse.Success)
                    {
                        dtRequestDetails = Insert_Request_Details(tracesResponse2.Message, "NSDL Conso File", str9, objTraceData, dtRequestDetails);
                        msg += "<br/><br/>" + tracesResponse2.Message;
                        str10 = "Form 27D, Conso file";
                        ++num;
                    }

                }
                if (objTraceData.AddlReqJustificationFile)
                {
                    tracesResponse2 = this.RequestForAddlJustificationReport(objTraceData);
                    if (tracesResponse2.Respons == eResponse.Success)
                    {
                        dtRequestDetails = Insert_Request_Details(tracesResponse2.Message, "Justification Report", str9, objTraceData, dtRequestDetails);
                        msg += "<br/><br/>" + tracesResponse2.Message;
                        str10 = num != 1 ? "Form 27D, Justification Report" : str10 + ", Justification Report";
                        ++num;
                    }

                }
                if (num > 0)
                    str10 += " has been requested successfully";
                tracesResponse1.Message = str10;
                tracesResponse1.Respons = eResponse.Success;
            }
            this.Logoff();
            if (dtRequestDetails.Rows.Count > 0)
                InsertRequestDetails(dtRequestDetails, objLogin, objTraceData);
        }
        catch (Exception ex)
        {
            tracesResponse1.Respons = eResponse.Failed;
            tracesResponse1.Message = ex.Message;
            this.Logoff();
        }
        return tracesResponse1;
    }

    public TDSResponse RequestForCertificate197(PAN_Fyear objCertData)
    {
        TDSResponse TDSResponse = new TDSResponse();
        DataTable dataTable = new DataTable();
        try
        {
            string request = this.makeHTTPGetRequest(this.strBaseURL + "ded/197certiverfication.xhtml");
            if (!this.IsStringExists(request, "//form[@id=\"certiValidation\"]"))
            {
                string str = this.RetrieveElementValue(request, "//div[@class=\"padLeft5 margintop20\"]", "//span[@class=\"boldFont\"]", ConnectTR.enmElementType.InnerText);
                if (!string.IsNullOrEmpty(str))
                {
                    TDSResponse.Message = str;
                    TDSResponse.Respons = eResponse.Failed;
                    return TDSResponse;
                }
                TDSResponse.Message = "Session Timeout";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            if (TDSResponse.Respons == eResponse.Failed)
            {
                TDSResponse.Respons = eResponse.Failed;
                return TDSResponse;
            }
            string sbData = "_search=false&nd=1396609417964&rows=100&page=1&sidx=&sord=asc";
            string s = this.makeHTTPJSONPostRequest(this.strBaseURL + "ded/srv/CertiVerifyServlet?certiNo=" + objCertData.CertificateNo + "&deducteePan=" + objCertData.PAN + "&financialYear=" + objCertData.FinYear + "&reqType=1", sbData);
            string strRowCount = "0";
            if (!string.IsNullOrEmpty(s))
                dataTable = this.JsonParserForCertificateValidation(s, out strRowCount);
            TDSResponse.CustomeTypes = (object)new ArrayList()
        {
          (object) strRowCount,
          (object) dataTable
        };
            TDSResponse.Respons = eResponse.Success;
        }
        catch (Exception ex)
        {
            this.Logoff();
            this.bnlSessionExists = false;
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = ex.Message;
        }
        return TDSResponse;
    }
    public TDSResponse RequestForAddlConsoFile_SVC(TracesData objTraceData, LoginTraces objLogin)
    {

        TDSResponse tracesResponse1 = new TDSResponse();
        try
        {
            this.IsSessionExists = false;
            if (!this.IsSessionExists)
            {
                tracesResponse1 = this.makeLoginToTRACES(objLogin);
                if (tracesResponse1.Respons == eResponse.Failed)
                    return tracesResponse1;
            }
            string request = this.makeHTTPGetRequest(this.strBaseURL + "ded/nsdlconsofile.xhtml");
            if (!this.IsStringExists(request, "//form[@id=\"requestnsdlconsoForm\"]"))
            {
                string str = this.RetrieveElementValue(request, "//div[@class=\"padLeft5 margintop20\"]", "//span[@class=\"boldFont\"]", ConnectTR.enmElementType.InnerText);
                if (!string.IsNullOrEmpty(str))
                {
                    tracesResponse1.Message = str;
                    tracesResponse1.Respons = eResponse.Failed;
                    return tracesResponse1;
                }
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                return tracesResponse1;
            }
            tracesResponse1 = this.IsServerError(request, "//span[@id=\"err_Summary\"]");
            if (tracesResponse1.Respons == eResponse.Failed)
            {
                this.Logoff();
                tracesResponse1.Respons = eResponse.Failed;
                return tracesResponse1;
            }
            StringBuilder sbData1 = new StringBuilder();
            sbData1.Append("finYr=" + objTraceData.FAYear);
            sbData1.Append("&qrtr=" + objTraceData.Quarter);
            sbData1.Append("&frmType=" + objTraceData.Forms);
            sbData1.Append("&download_conso=Go");
            Dictionary<string, string> dictionary1 = this.TraceViewStateData(request, "//form[@id=\"requestnsdlconsoForm\"]");
            if (dictionary1.Count <= 0)
            {
                this.Logoff();
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                return tracesResponse1;
            }
            foreach (KeyValuePair<string, string> keyValuePair in dictionary1)
                sbData1.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            string str1 = this.makeHTTPPostRequest(this.strBaseURL + "ded/nsdlconsofile.xhtml", sbData1);
            tracesResponse1 = this.IsServerError(str1, "//ul[@id=\"err_Summary\"]");
            if (tracesResponse1.Respons == eResponse.Failed)
            {
                this.Logoff();
                tracesResponse1.Respons = eResponse.Failed;
                return tracesResponse1;
            }
            string str2 = "dedkyc";
            if (!this.IsStringExists(str1, "//form[@id=\"dedkyc\"]"))
            {
                if (!this.IsStringExists(str1, "//form[@id=\"kycformdsc\"]"))
                {
                    string str3 = this.AttributeValie(str1, "//div[@id='umchcase']", "Style");
                    this.Logoff();
                    this.bnlSessionExists = false;
                    tracesResponse1.Message = string.IsNullOrEmpty(str3) ? "Server Error" : "There are unmatched challans in the selected statement";
                    tracesResponse1.Respons = eResponse.SessionTimeout;
                    return tracesResponse1;
                }
                str2 = "dedkyc";
                Dictionary<string, string> dictionary2 = this.TraceViewStateData(str1, "//form[@id=\"kycformdsc\"]");
                if (dictionary2.Count == 0)
                {
                    this.bnlSessionExists = false;
                    tracesResponse1.Message = "Server Error";
                    tracesResponse1.Respons = eResponse.SessionTimeout;
                    return tracesResponse1;
                }
                StringBuilder sbData2 = new StringBuilder();
                foreach (KeyValuePair<string, string> keyValuePair in dictionary2)
                    sbData2.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
                sbData2.Append("&search2=on");
                sbData2.Append("&kycFinYear=" + objTraceData.FAYear);
                sbData2.Append("&kycFormType=" + objTraceData.Forms);
                sbData2.Append("&kycQrtr=" + objTraceData.Quarter);
                sbData2.Append("&kycformdsc:_idcl=nxtSrcn");
                str1 = this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3formdsc.xhtml", sbData2);
                if (!this.IsStringExists(str1, "//form[@id=\"dedkyc1\"]"))
                {
                    this.Logoff();
                    this.bnlSessionExists = false;
                    tracesResponse1.Message = "Server Error";
                    tracesResponse1.Respons = eResponse.SessionTimeout;
                    return tracesResponse1;
                }
            }
            StringBuilder sbData3 = new StringBuilder();
            sbData3.Append("authcode=" + objTraceData.AuthenticationCode);
            sbData3.Append("&stmtSpecKyc=1");
            sbData3.Append("&bforeLogin=3");
            sbData3.Append("&token=" + objTraceData.PRN_NO);
            bool flag;
            if (objTraceData.IsNoChallanCheck)
            {
                StringBuilder stringBuilder = sbData3;
                flag = objTraceData.IsNoChallanCheck;
                string str3 = "&cinbinCheck=" + flag.ToString();
                stringBuilder.Append(str3);
            }
            StringBuilder stringBuilder1 = sbData3;
            flag = objTraceData.IsNoChallan;
            string str4 = "&cinbinValue=" + flag.ToString();
            stringBuilder1.Append(str4);
            StringBuilder stringBuilder2 = sbData3;
            flag = objTraceData.IsPaymentByBookAdjustmentCheck;
            string str5 = "&bkEntryFlgChk=" + flag.ToString();
            stringBuilder2.Append(str5);
            StringBuilder stringBuilder3 = sbData3;
            flag = objTraceData.IsPaymentByBookAdjustment;
            string str6 = "&bkEntryValue=" + flag.ToString();
            stringBuilder3.Append(str6);
            if (objTraceData.panAmtValueCheck)
            {
                StringBuilder stringBuilder4 = sbData3;
                flag = objTraceData.panAmtValueCheck;
                string str3 = "&panAmtCheck=" + flag.ToString();
                stringBuilder4.Append(str3);
            }
            StringBuilder stringBuilder5 = sbData3;
            flag = objTraceData.panAmtValue;
            string str7 = "&panAmtValue=" + flag.ToString();
            stringBuilder5.Append(str7);
            if (!objTraceData.IsNoChallanCheck)
            {
                sbData3.Append("&bsr=" + objTraceData.BSRCode);
                sbData3.Append("&dtoftaxdep=" + objTraceData.TaxDepositedDate);
                sbData3.Append("&csn=" + objTraceData.ChallanSerialNo);
                sbData3.Append("&chlnamt=" + objTraceData.ChallanAmount);
                sbData3.Append("&cdrecnum=" + objTraceData.CDRecordNumber);
            }
            if (!objTraceData.panAmtValueCheck)
            {
                sbData3.Append("&pan1=" + objTraceData.PAN1);
                sbData3.Append("&amt1=" + objTraceData.PAN1Amount);
                sbData3.Append("&pan2=" + objTraceData.PAN2);
                sbData3.Append("&amt2=" + objTraceData.PAN2Amount);
                sbData3.Append("&pan3=" + objTraceData.PAN3);
                sbData3.Append("&amt3=" + objTraceData.PAN3Amount);
            }
            sbData3.Append("&clickKYC=Proceed");
            sbData3.Append("&dedkyc_SUBMIT=1");
            Dictionary<string, string> dictionary3 = this.TraceViewStateData(str1, "//form[@id=\"" + str2 + "\"]");
            foreach (KeyValuePair<string, string> keyValuePair in dictionary3)
                sbData3.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            if (dictionary3.Count <= 0)
            {
                this.Logoff();
                this.bnlSessionExists = false;
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                return tracesResponse1;
            }
            string str8 = this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3form.xhtml", sbData3);
            if (!this.IsStringExists(str8, "//form[@id=\"dedkyc\"]"))
            {
                this.bnlSessionExists = false;
                tracesResponse1.Message = "Server Error";
                tracesResponse1.Respons = eResponse.SessionTimeout;
                return tracesResponse1;
            }
            tracesResponse1 = this.IsServerError(str8, "//div[@id=\"err_Summary\"]");
            if (tracesResponse1.Respons == eResponse.Failed)
            {
                this.Logoff();
                tracesResponse1.Respons = eResponse.Failed;
                return tracesResponse1;
            }
            string str9 = this.RetrieveElementValue(str8, "//form[@id=\"dedkyc\"]", "//input[@id=\"authcode\"]", ConnectTR.enmElementType.Value);
            Dictionary<string, string> dictionary4 = this.TraceViewStateData(str8, "//form[@id=\"dedkyc\"]");
            StringBuilder sbData4 = new StringBuilder();
            sbData4.Append("authcode=" + HttpUtility.UrlEncode(str9.Trim()));
            sbData4.Append("&redirect=" + HttpUtility.UrlEncode("Proceed with Transaction"));
            sbData4.Append("&dedkyc_SUBMIT=1");
            foreach (KeyValuePair<string, string> keyValuePair in dictionary4)
            {
                if (keyValuePair.Key == "javax.faces.ViewState")
                    sbData4.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            }
            Dictionary<string, string> dictionary5 = this.TraceViewStateData(this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3confirm.xhtml", sbData4), "//form[@id=\"downloadreqspec\"]");
            StringBuilder stringBuilder6 = new StringBuilder();
            foreach (KeyValuePair<string, string> keyValuePair in dictionary5)
            {
                if (keyValuePair.Key == "finYr")
                    stringBuilder6.Append("fy=" + keyValuePair.Value);
                if (keyValuePair.Key == "qrtr")
                {
                    if (keyValuePair.Value == "")
                        stringBuilder6.Append("&qr=0");
                    else
                        stringBuilder6.Append("&qr=" + keyValuePair.Value);
                }
                if (keyValuePair.Key == "formType")
                    stringBuilder6.Append("&ft=" + keyValuePair.Value);
                if (keyValuePair.Key == "dwldType")
                    stringBuilder6.Append("&dt=" + keyValuePair.Value);
            }
            string str10 = this.RetrieveElementValue(this.makeHTTPGetRequest(this.strBaseURL + "srv/CreateDwnldReqServlet?" + stringBuilder6.ToString()), "//div[@class='margintop20']", "//h5", ConnectTR.enmElementType.InnerText);
            TDSResponse tracesResponse2 = new TDSResponse();
            int num = 0;
            if (!string.IsNullOrEmpty(str10))
            {
                if (objTraceData.AddlReqJustificationFile && this.RequestForAddlJustificationReport(objTraceData).Respons == eResponse.Success)
                {
                    str10 = "Consolidated Statement, Justification Report";
                    ++num;
                }
                if (objTraceData.AddlReqForm16AFile && this.RequestForAddlForm16A(objTraceData).Respons == eResponse.Success)
                {
                    str10 = num != 1 ? "Consolidated Statement, Form 16A" : str10 + ", Form 16A";
                    ++num;
                }
                if (objTraceData.AddlReqForm16File && this.RequestForAddlForm16(objTraceData).Respons == eResponse.Success)
                {
                    str10 = num != 1 ? "Consolidated Statement, Form 16 - Part A" : str10 + ", Form 16 - Part A";
                    ++num;
                }
                if (objTraceData.AddlReqForm27DFile && this.RequestForAddlForm27D(objTraceData).Respons == eResponse.Success)
                {
                    str10 = num != 1 ? "Consolidated Statement, Form 27D" : str10 + ", Form 27D";
                    ++num;
                }
                if (num > 0)
                    str10 += " has been requested successfully";
                tracesResponse1.Message = str10;
                tracesResponse1.Respons = eResponse.Success;
            }
            this.Logoff();
        }
        catch (Exception ex)
        {
            this.Logoff();
            this.bnlSessionExists = false;
            tracesResponse1.Respons = eResponse.Failed;
            tracesResponse1.Message = ex.Message;
        }
        return tracesResponse1;

    }
    public TDSResponse RequestForAddlConsoFile(TracesData objTraceData)
    {

        TDSResponse TDSResponse = new TDSResponse();
        try
        {
            string request = this.makeHTTPGetRequest(this.strBaseURL + "ded/nsdlconsofile.xhtml");
            if (!this.IsStringExists(request, "//form[@id=\"requestnsdlconsoForm\"]"))
            {
                string str = this.RetrieveElementValue(request, "//div[@class=\"padLeft5 margintop20\"]", "//span[@class=\"boldFont\"]", ConnectTR.enmElementType.InnerText);
                if (!string.IsNullOrEmpty(str))
                {
                    TDSResponse.Message = str;
                    TDSResponse.Respons = eResponse.Failed;
                    return TDSResponse;
                }
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            TDSResponse = this.IsServerError(request, "//span[@id=\"err_Summary\"]");
            if (TDSResponse.Respons == eResponse.Failed)
            {
                this.Logoff();
                TDSResponse.Respons = eResponse.Failed;
                return TDSResponse;
            }
            StringBuilder sbData1 = new StringBuilder();
            sbData1.Append("finYr=" + objTraceData.FAYear);
            sbData1.Append("&qrtr=" + objTraceData.Quarter);
            sbData1.Append("&frmType=" + objTraceData.Forms);
            sbData1.Append("&download_conso=Go");
            Dictionary<string, string> dictionary1 = this.TraceViewStateData(request, "//form[@id=\"requestnsdlconsoForm\"]");
            if (dictionary1.Count <= 0)
            {
                this.Logoff();
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            foreach (KeyValuePair<string, string> keyValuePair in dictionary1)
                sbData1.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            string str1 = this.makeHTTPPostRequest(this.strBaseURL + "ded/nsdlconsofile.xhtml", sbData1);
            TDSResponse = this.IsServerError(str1, "//ul[@id=\"err_Summary\"]");
            if (TDSResponse.Respons == eResponse.Failed)
            {
                this.Logoff();
                TDSResponse.Respons = eResponse.Failed;
                return TDSResponse;
            }
            if (!this.IsStringExists(str1, "//form[@id=\"downloadreqspec\"]"))
            {
                if (!this.IsStringExists(str1, "//form[@id=\"kycformdsc\"]"))
                {
                    string str2 = this.AttributeValie(str1, "//div[@id='umchcase']", "Style");
                    this.Logoff();
                    this.bnlSessionExists = false;
                    TDSResponse.Message = string.IsNullOrEmpty(str2) ? "Server Error" : "There are unmatched challans in the selected statement";
                    TDSResponse.Respons = eResponse.SessionTimeout;
                    return TDSResponse;
                }
                Dictionary<string, string> dictionary2 = this.TraceViewStateData(str1, "//form[@id=\"kycformdsc\"]");
                if (dictionary2.Count == 0)
                {
                    this.bnlSessionExists = false;
                    TDSResponse.Message = "Server Error";
                    TDSResponse.Respons = eResponse.SessionTimeout;
                    return TDSResponse;
                }
                StringBuilder sbData2 = new StringBuilder();
                foreach (KeyValuePair<string, string> keyValuePair in dictionary2)
                    sbData2.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
                sbData2.Append("&search2=on");
                sbData2.Append("&kycFinYear=");
                sbData2.Append("&kycFormType=");
                sbData2.Append("&kycQrtr=");
                sbData2.Append("&kycformdsc:_idcl=nxtSrcn");
                str1 = this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3formdsc.xhtml", sbData2);
            }
            Dictionary<string, string> dictionary3 = this.TraceViewStateData(str1, "//form[@id=\"downloadreqspec\"]");
            if (dictionary3.Count == 0)
            {
                this.bnlSessionExists = false;
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            StringBuilder stringBuilder = new StringBuilder();
            foreach (KeyValuePair<string, string> keyValuePair in dictionary3)
            {
                if (keyValuePair.Key == "finYr")
                    stringBuilder.Append("fy=" + keyValuePair.Value);
                if (keyValuePair.Key == "qrtr")
                {
                    if (keyValuePair.Value == "")
                        stringBuilder.Append("&qr=0");
                    else
                        stringBuilder.Append("&qr=" + keyValuePair.Value);
                }
                if (keyValuePair.Key == "formType")
                    stringBuilder.Append("&ft=" + keyValuePair.Value);
                if (keyValuePair.Key == "dwldType")
                    stringBuilder.Append("&dt=" + keyValuePair.Value);
            }
            string str3 = this.RetrieveElementValue(this.makeHTTPGetRequest(this.strBaseURL + "srv/CreateDwnldReqServlet?" + stringBuilder.ToString()), "//div[@class='margintop20']", "//h5", ConnectTR.enmElementType.InnerText);
            if (!string.IsNullOrEmpty(str3))
            {
                TDSResponse.Message = str3;
                TDSResponse.Respons = eResponse.Success;
            }
        }
        catch (Exception ex)
        {
            this.Logoff();
            this.bnlSessionExists = false;
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = ex.Message;
        }
        return TDSResponse;

    }

    public TDSResponse RequestForAddlForm16A(TracesData objTraceData)
    {
        TDSResponse TDSResponse = new TDSResponse();
        try
        {
            string request = this.makeHTTPGetRequest(this.strBaseURL + "ded/download16a.xhtml");
            if (!this.IsStringExists(request, "//form[@id=\"bulkSearch\"]"))
            {
                TDSResponse.Message = "Form16A Submission failed";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            StringBuilder sbData1 = new StringBuilder();
            sbData1.Append("dwnldFormBulkType=14");
            sbData1.Append("&bulkfinYr=" + objTraceData.FAYear);
            sbData1.Append("&bulkquarter=" + objTraceData.Quarter);
            sbData1.Append("&bulkformType=" + objTraceData.Forms);
            sbData1.Append("&bulkGo=Go");
            sbData1.Append("&bulkSearch_SUBMIT=1");
            Dictionary<string, string> dictionary1 = this.TraceViewStateData(request, "//form[@id=\"bulkSearch\"]");
            if (dictionary1.Count <= 0)
            {
                TDSResponse.Message = "Form16A Submission failed";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            foreach (KeyValuePair<string, string> keyValuePair in dictionary1)
            {
                if (keyValuePair.Key == "javax.faces.ViewState")
                {
                    sbData1.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
                    break;
                }
            }
            string str1 = this.makeHTTPPostRequest(this.strBaseURL + "ded/download16a.xhtml", sbData1);
            TDSResponse = this.IsServerError(str1, "//ul[@id=\"err_Summary\"]");
            if (TDSResponse.Respons == eResponse.Failed)
            {
                TDSResponse.Respons = eResponse.Failed;
                return TDSResponse;
            }
            if (!this.IsStringExists(str1, "//form[@id=\"deducteeDetails\"]"))
            {
                TDSResponse.Message = "Form16A Submission failed";
                TDSResponse.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return TDSResponse;
            }
            Dictionary<string, string> dictionary2 = this.TraceViewStateData(str1, "//form[@id=\"deducteeDetails\"]");
            if (dictionary2.Count <= 0)
            {
                TDSResponse.Message = "Form16A Submission failed";
                TDSResponse.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return TDSResponse;
            }
            StringBuilder sbData2 = new StringBuilder();
            sbData2.Append("j_id1972728517_7cc7de5f=submit");
            foreach (KeyValuePair<string, string> keyValuePair in dictionary2)
                sbData2.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            string str2 = this.makeHTTPPostRequest(this.strBaseURL + "ded/form16adetls.xhtml", sbData2);
            if (!this.IsStringExists(str2, "//form[@id=\"requestConfirm\"]"))
            {
                if (!this.IsStringExists(str2, "//form[@id=\"kycformdsc\"]"))
                {
                    this.Logoff();
                    this.bnlSessionExists = false;
                    TDSResponse.Message = "Form16A Submission failed";
                    TDSResponse.Respons = eResponse.SessionTimeout;
                    return TDSResponse;
                }
                Dictionary<string, string> dictionary3 = this.TraceViewStateData(str2, "//form[@id=\"kycformdsc\"]");
                if (dictionary3.Count == 0)
                {
                    this.bnlSessionExists = false;
                    TDSResponse.Message = "Server Error";
                    TDSResponse.Respons = eResponse.SessionTimeout;
                    return TDSResponse;
                }
                StringBuilder sbData3 = new StringBuilder();
                foreach (KeyValuePair<string, string> keyValuePair in dictionary3)
                    sbData3.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
                sbData3.Append("&search2=on");
                sbData3.Append("&kycFinYear=" + objTraceData.FAYear);
                sbData3.Append("&kycFormType=" + objTraceData.Forms);
                sbData3.Append("&kycQrtr=" + objTraceData.Quarter);
                sbData3.Append("&kycformdsc:_idcl=nxtSrcn");
                str2 = this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3formdsc.xhtml", sbData3);
            }
            string str3 = this.RetrieveElementValue(str2, "//div[@class='margintop20']", "//h5", ConnectTR.enmElementType.InnerText);
            if (!string.IsNullOrEmpty(str3))
            {
                TDSResponse.Message = str3;
                TDSResponse.Respons = eResponse.Success;
            }
        }
        catch (Exception ex)
        {
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = ex.Message;
            this.Logoff();
        }
        return TDSResponse;
    }

    public TDSResponse RequestForAddlJustificationReport(TracesData objTraceData)
    {
        TDSResponse TDSResponse = new TDSResponse();
        try
        {
            string request = this.makeHTTPGetRequest(this.strBaseURL + "ded/justrepdwnld.xhtml");
            if (!this.IsStringExists(request, "//form[@id=\"justificationForm\"]"))
            {
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return TDSResponse;
            }
            TDSResponse = this.IsServerError(this.strServerResponse, "//span[@id=\"err_Summary\"]");
            if (TDSResponse.Respons == eResponse.Failed)
            {
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.Failed;
                this.Logoff();
                return TDSResponse;
            }
            StringBuilder sbData1 = new StringBuilder();
            sbData1.Append("finYr=" + objTraceData.FAYear);
            sbData1.Append("&qrtr=" + objTraceData.Quarter);
            sbData1.Append("&frmType=" + objTraceData.Forms);
            sbData1.Append("&download_justReport=Go");
            Dictionary<string, string> dictionary1 = this.TraceViewStateData(request, "//form[@id=\"justificationForm\"]");
            if (dictionary1.Count <= 0)
            {
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return TDSResponse;
            }
            foreach (KeyValuePair<string, string> keyValuePair in dictionary1)
                sbData1.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            string str1 = this.makeHTTPPostRequest(this.strBaseURL + "ded/justrepdwnld.xhtml", sbData1);
            TDSResponse = this.IsServerError(str1, "//ul[@id=\"err_Summary\"]");
            if (TDSResponse.Respons == eResponse.Failed)
            {
                this.Logoff();
                TDSResponse.Respons = eResponse.Failed;
                return TDSResponse;
            }
            if (!this.IsStringExists(str1, "//form[@id=\"downloadreqspec\"]"))
            {
                if (!this.IsStringExists(str1, "//form[@id=\"kycformdsc\"]"))
                {
                    this.Logoff();
                    this.bnlSessionExists = false;
                    TDSResponse.Message = "Server Error";
                    TDSResponse.Respons = eResponse.SessionTimeout;
                    return TDSResponse;
                }
                Dictionary<string, string> dictionary2 = this.TraceViewStateData(str1, "//form[@id=\"kycformdsc\"]");
                if (dictionary2.Count == 0)
                {
                    this.bnlSessionExists = false;
                    TDSResponse.Message = "Server Error";
                    TDSResponse.Respons = eResponse.SessionTimeout;
                    return TDSResponse;
                }
                StringBuilder sbData2 = new StringBuilder();
                foreach (KeyValuePair<string, string> keyValuePair in dictionary2)
                    sbData2.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
                sbData2.Append("&search2=on");
                sbData2.Append("&kycFinYear=" + objTraceData.FAYear);
                sbData2.Append("&kycFormType=" + objTraceData.Forms);
                sbData2.Append("&kycQrtr=" + objTraceData.Quarter);
                sbData2.Append("&kycformdsc:_idcl=nxtSrcn");
                str1 = this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3formdsc.xhtml", sbData2);
            }
            Dictionary<string, string> dictionary3 = this.TraceViewStateData(str1, "//form[@id=\"downloadreqspec\"]");
            StringBuilder stringBuilder = new StringBuilder();
            foreach (KeyValuePair<string, string> keyValuePair in dictionary3)
            {
                if (keyValuePair.Key == "finYr")
                    stringBuilder.Append("fy=" + keyValuePair.Value);
                if (keyValuePair.Key == "qrtr")
                {
                    if (keyValuePair.Value == "")
                        stringBuilder.Append("&qr=0");
                    else
                        stringBuilder.Append("&qr=" + keyValuePair.Value);
                }
                if (keyValuePair.Key == "formType")
                    stringBuilder.Append("&ft=" + keyValuePair.Value);
                if (keyValuePair.Key == "dwldType")
                    stringBuilder.Append("&dt=" + keyValuePair.Value);
            }
            string str2 = this.RetrieveElementValue(this.makeHTTPGetRequest(this.strBaseURL + "srv/CreateDwnldReqServlet?" + stringBuilder.ToString()), "//div[@class='margintop20']", "//h5", ConnectTR.enmElementType.InnerText);
            if (!string.IsNullOrEmpty(str2))
            {
                TDSResponse.Message = str2;
                TDSResponse.Respons = eResponse.Success;
            }
        }
        catch (Exception ex)
        {
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = ex.Message;
            this.Logoff();
        }
        return TDSResponse;
    }

    public TDSResponse RequestForAddlForm16(TracesData objTraceData)
    {
        TDSResponse TDSResponse = new TDSResponse();
        try
        {
            string request = this.makeHTTPGetRequest(this.strBaseURL + "ded/download16.xhtml");
            if (!this.IsStringExists(request, "//form[@id=\"bulkPan\"]"))
            {
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return TDSResponse;
            }
            StringBuilder sbData1 = new StringBuilder();
            sbData1.Append("dwnldFormBulkType=13");
            sbData1.Append("&bulkfinYr=" + objTraceData.FAYear);
            sbData1.Append("&bulkGo=Go");
            sbData1.Append("&bulkPan_SUBMIT=1");
            Dictionary<string, string> dictionary1 = this.TraceViewStateData(request, "//form[@id=\"bulkPan\"]");
            if (dictionary1.Count <= 0)
            {
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return TDSResponse;
            }
            foreach (KeyValuePair<string, string> keyValuePair in dictionary1)
            {
                if (keyValuePair.Key == "javax.faces.ViewState")
                {
                    sbData1.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
                    break;
                }
            }
            string str1 = this.makeHTTPPostRequest(this.strBaseURL + "ded/download16.xhtml", sbData1);
            TDSResponse = this.IsServerError(str1, "//ul[@id=\"err_Summary\"]");
            if (TDSResponse.Respons == eResponse.Failed)
            {
                TDSResponse.Respons = eResponse.Failed;
                return TDSResponse;
            }
            if (!this.IsStringExists(str1, "//form[@id=\"deducteeDetails\"]"))
            {
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            Dictionary<string, string> dictionary2 = this.TraceViewStateData(str1, "//form[@id=\"deducteeDetails\"]");
            if (dictionary2.Count <= 0)
            {
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            StringBuilder sbData2 = new StringBuilder();
            sbData2.Append("j_id1972728517_7cc7de5f=submit");
            foreach (KeyValuePair<string, string> keyValuePair in dictionary2)
                sbData2.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            string str2 = this.makeHTTPPostRequest(this.strBaseURL + "ded/form16adetls.xhtml", sbData2);
            if (!this.IsStringExists(str2, "//form[@id=\"requestConfirm\"]"))
            {
                if (!this.IsStringExists(str2, "//form[@id=\"kycformdsc\"]"))
                {
                    this.Logoff();
                    this.bnlSessionExists = false;
                    TDSResponse.Message = "Server Error";
                    TDSResponse.Respons = eResponse.SessionTimeout;
                    return TDSResponse;
                }
                Dictionary<string, string> dictionary3 = this.TraceViewStateData(str2, "//form[@id=\"kycformdsc\"]");
                if (dictionary3.Count == 0)
                {
                    this.bnlSessionExists = false;
                    TDSResponse.Message = "Server Error";
                    TDSResponse.Respons = eResponse.SessionTimeout;
                    return TDSResponse;
                }
                StringBuilder sbData3 = new StringBuilder();
                foreach (KeyValuePair<string, string> keyValuePair in dictionary3)
                    sbData3.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
                sbData3.Append("&search2=on");
                sbData3.Append("&kycFinYear=" + objTraceData.FAYear);
                sbData3.Append("&kycFormType=" + objTraceData.Forms);
                sbData3.Append("&kycQrtr=" + objTraceData.Quarter);
                sbData3.Append("&kycformdsc:_idcl=nxtSrcn");
                str2 = this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3formdsc.xhtml", sbData3);
            }
            string str3 = this.RetrieveElementValue(str2, "//div[@class='margintop20']", "//h5", ConnectTR.enmElementType.InnerText);
            if (!string.IsNullOrEmpty(str3))
            {
                TDSResponse.Message = str3;
                TDSResponse.Respons = eResponse.Success;
            }
        }
        catch (Exception ex)
        {
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = ex.Message;
            this.Logoff();
        }
        return TDSResponse;
    }

    public TDSResponse RequestForAddlForm27D(TracesData objTraceData)
    {
        TDSResponse TDSResponse = new TDSResponse();
        try
        {
            string request = this.makeHTTPGetRequest(this.strBaseURL + "ded/download27d.xhtml");
            if (!this.IsStringExists(request, "//form[@id=\"bulkSearch\"]"))
            {
                TDSResponse.Message = "Form 27D Request Failed";
                TDSResponse.Respons = eResponse.Failed;
                return TDSResponse;
            }
            StringBuilder sbData1 = new StringBuilder();
            sbData1.Append("dwnldFormBulkType=19");
            sbData1.Append("&bulkfinYr=" + objTraceData.FAYear);
            sbData1.Append("&bulkquarter=" + objTraceData.Quarter);
            sbData1.Append("&bulkGo=Go");
            sbData1.Append("&bulkSearch_SUBMIT=1");
            Dictionary<string, string> dictionary1 = this.TraceViewStateData(request, "//form[@id=\"bulkSearch\"]");
            if (dictionary1.Count <= 0)
            {
                TDSResponse.Message = "Form 27D Request Failed";
                TDSResponse.Respons = eResponse.Failed;
                return TDSResponse;
            }
            foreach (KeyValuePair<string, string> keyValuePair in dictionary1)
            {
                if (keyValuePair.Key == "javax.faces.ViewState")
                {
                    sbData1.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
                    break;
                }
            }
            string str1 = this.makeHTTPPostRequest(this.strBaseURL + "ded/download27d.xhtml", sbData1);
            TDSResponse = this.IsServerError(str1, "//ul[@id=\"err_Summary\"]");
            if (TDSResponse.Respons == eResponse.Failed)
            {
                TDSResponse.Respons = eResponse.Failed;
                return TDSResponse;
            }
            if (!this.IsStringExists(str1, "//form[@id=\"deducteeDetails\"]"))
            {
                TDSResponse.Message = "Form 27D Request Failed";
                TDSResponse.Respons = eResponse.Failed;
                return TDSResponse;
            }
            Dictionary<string, string> dictionary2 = this.TraceViewStateData(str1, "//form[@id=\"deducteeDetails\"]");
            if (dictionary2.Count <= 0)
            {
                TDSResponse.Message = "Form 27D Request Failed";
                TDSResponse.Respons = eResponse.Failed;
                return TDSResponse;
            }
            StringBuilder sbData2 = new StringBuilder();
            sbData2.Append("j_id2143335333_643da170=submit");
            foreach (KeyValuePair<string, string> keyValuePair in dictionary2)
                sbData2.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            string str2 = this.makeHTTPPostRequest(this.strBaseURL + "ded/form27ddetls.xhtml", sbData2);
            if (!this.IsStringExists(str2, "//form[@id=\"requestConfirm\"]"))
            {
                if (!this.IsStringExists(str2, "//form[@id=\"kycformdsc\"]"))
                {
                    TDSResponse.Message = "Form 27D Request Failed";
                    TDSResponse.Respons = eResponse.Failed;
                    return TDSResponse;
                }
                Dictionary<string, string> dictionary3 = this.TraceViewStateData(str2, "//form[@id=\"kycformdsc\"]");
                if (dictionary3.Count == 0)
                {
                    TDSResponse.Message = "Form 27D Request Failed";
                    TDSResponse.Respons = eResponse.Failed;
                    return TDSResponse;
                }
                StringBuilder sbData3 = new StringBuilder();
                foreach (KeyValuePair<string, string> keyValuePair in dictionary3)
                    sbData3.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
                sbData3.Append("&search2=on");
                sbData3.Append("&kycFinYear=" + objTraceData.FAYear);
                sbData3.Append("&kycFormType=" + objTraceData.Forms);
                sbData3.Append("&kycQrtr=" + objTraceData.Quarter);
                sbData3.Append("&kycformdsc:_idcl=nxtSrcn");
                str2 = this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3formdsc.xhtml", sbData3);
            }
            string str3 = this.RetrieveElementValue(str2, "//div[@class='margintop20']", "//h5", ConnectTR.enmElementType.InnerText);
            if (!string.IsNullOrEmpty(str3))
            {
                TDSResponse.CustomeTypes = (object)new RequestStatus()
                {
                    StatusMessage = str3
                };
                TDSResponse.Respons = eResponse.Success;
            }
        }
        catch (Exception ex)
        {
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = ex.Message;
            this.Logoff();
        }
        return TDSResponse;
    }

    private void ServerMessageRepository()
    {
        this.objMsgDictionary.Clear();
        this.objMsgDictionary.Add(new RecData<int, string, string>(1, "Invalid details", "Invalid details"));
        this.objMsgDictionary.Add(new RecData<int, string, string>(4, "You have 3 attempts left", "You have 3 attempts left"));
        this.objMsgDictionary.Add(new RecData<int, string, string>(6, "You have 2 attempts left", "You have 2 attempts left"));
        this.objMsgDictionary.Add(new RecData<int, string, string>(8, "You have 1 attempts left", "You have 1 attempts left"));
        this.objMsgDictionary.Add(new RecData<int, string, string>(10, "Statement is not available with TRACES at present", "Statement is not available with TRACES at present"));
        this.objMsgDictionary.Add(new RecData<int, string, string>(12, "Conso file will not be available temporarily. Inconvenience is regretted", "Conso file will not be available temporarily. Inconvenience is regretted"));
    }

    private TDSResponse IsServerError1(string strServerResponse)
    {
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        this.ServerMessageRepository();
        foreach (RecData<int, string, string> objMsg in this.objMsgDictionary)
        {
            if (Regex.IsMatch(strServerResponse, objMsg.KEY2, RegexOptions.IgnoreCase))
            {
                TDSResponse.Respons = eResponse.Failed;
                TDSResponse.Message = objMsg.KEY3;
            }
        }
        return TDSResponse;
    }

    private TDSResponse IsServerError(string strServerResponse, string strXQuery)
    {
        string str = "";
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        HtmlDocument htmlDocument = new HtmlDocument();
        htmlDocument.LoadHtml(strServerResponse);
        HtmlNodeCollection htmlNodeCollection = htmlDocument.DocumentNode.SelectNodes(strXQuery);
        if (htmlNodeCollection == null)
            return TDSResponse;
        for (int index = 0; index < htmlNodeCollection.Count; ++index)
            str = htmlNodeCollection[index].InnerText.Replace("\t", "");
        if (!string.IsNullOrEmpty(str.Trim()))
        {
            TDSResponse.Message = str;
            TDSResponse.Respons = eResponse.Failed;
        }
        return TDSResponse;
    }

    private TDSResponse IsServerError(
      string strServerResponse,
      List<string> strXQuery)
    {
        string str = "";
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        HtmlDocument htmlDocument = new HtmlDocument();
        htmlDocument.LoadHtml(strServerResponse);
        HtmlNode documentNode = htmlDocument.DocumentNode;
        foreach (string xpath in strXQuery)
        {
            HtmlNodeCollection htmlNodeCollection = documentNode.SelectNodes(xpath);
            if (htmlNodeCollection == null)
                return TDSResponse;
            for (int index = 0; index < htmlNodeCollection.Count; ++index)
                str = htmlNodeCollection[index].InnerText.Replace("\t", "");
            if (!string.IsNullOrEmpty(str.Trim()))
            {
                TDSResponse.Message = str;
                TDSResponse.Respons = eResponse.Failed;
            }
        }
        return TDSResponse;
    }

    private bool IsStringExists(string strServerResponse, string strXQuery)
    {
        new TDSResponse().Respons = eResponse.Success;
        HtmlDocument htmlDocument = new HtmlDocument();
        htmlDocument.LoadHtml(strServerResponse);
        return htmlDocument.DocumentNode.SelectNodes(strXQuery) != null;
    }

    private string makeLoginToTRACES1(LoginTraces login)
    {
        this.request = (HttpWebRequest)WebRequest.Create(this.strBaseURL + "login.xhtml");
        this.request.CookieContainer = this.objContainer;
        this.request.KeepAlive = true;
        this.request.Method = "GET";
        this.response = (HttpWebResponse)this.request.GetResponse();
        this.dataStream = this.response.GetResponseStream();
        this.reader = new StreamReader(this.dataStream);
        this.strServerResponse = this.reader.ReadToEnd();
        this.reader.Close();
        this.dataStream.Close();
        this.response.Close();
        StringBuilder sbData = new StringBuilder();
        sbData.Append("j_username=" + login.UserID);
        sbData.Append("&j_password=" + login.Password);
        this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "j_security_check", sbData);
        return this.strServerResponse;
    }

    private bool IsConditionMatch(string strResponse, string strPattern)
    {
        return Regex.IsMatch(strResponse, strPattern, RegexOptions.IgnoreCase);
    }

    public TDSResponse makeLoginToTRACES(LoginTraces login)
    {
        TDSResponse TDSResponse = new TDSResponse();
        StringBuilder sbData = new StringBuilder();
        try
        {
            sbData.Append("search1=on");
            sbData.Append("&username=" + HttpUtility.UrlEncode(login.UserID));
            sbData.Append("&j_username=" + HttpUtility.UrlEncode(login.UserID) + "^" + login.TAN);
            sbData.Append("&selradio=D");
            sbData.Append("&j_password=" + HttpUtility.UrlEncode(login.Password));
            sbData.Append("&j_tanPan=" + login.TAN);
            sbData.Append("&j_captcha=" + login.CaptchaCode);
            this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "j_security_check", sbData);
            if (string.IsNullOrEmpty(this.strServerResponse))
            {
                this.IsSessionExists = false;
                TDSResponse.Respons = eResponse.Failed;
                TDSResponse.Message = "Login Failed or Server Error";
                return TDSResponse;
            }
            TDSResponse = this.IsServerError(this.strServerResponse, "//form[@id=\"surveyForm\"]");
            if (TDSResponse.Respons == eResponse.Failed)
            {
                this.IsSessionExists = false;
                TDSResponse.Message = "Please log into your account by visiting www.tdscpc.gov.in and fill the survey form.";
                return TDSResponse;
            }
            TDSResponse = this.IsServerError(this.strServerResponse, "//span[@id=\"err_Summary\"]");
            if (TDSResponse.Respons == eResponse.Failed)
            {
                this.IsSessionExists = false;
                return TDSResponse;
            }
            if (!this.IsConditionMatch(this.strServerResponse, login.TAN))
            {
                TDSResponse.Respons = eResponse.Failed;
                TDSResponse.Message = "Login Failed or Server Error";
                return TDSResponse;
            }

            this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "j_security_check", sbData);
            this.IsSessionExists = true;
            TDSResponse.Respons = eResponse.Success;
            TDSResponse.Message = "";
            return TDSResponse;
        }
        catch (Exception ex)
        {
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = ex.Message;
            return TDSResponse;
        }
    }

    public TDSResponse makeLoginToTRACES_SVC(LoginTraces login)
    {
        TDSResponse TDSResponse = new TDSResponse();
        StringBuilder sbData = new StringBuilder();
        try
        {
            sbData.Append("search1=on");
            sbData.Append("&username=" + HttpUtility.UrlEncode(login.UserID));
            sbData.Append("&j_username=" + HttpUtility.UrlEncode(login.UserID) + "^" + login.TAN);
            sbData.Append("&selradio=D");
            sbData.Append("&j_password=" + HttpUtility.UrlEncode(login.Password));
            sbData.Append("&j_tanPan=" + login.TAN);
            sbData.Append("&j_captcha=" + login.CaptchaCode);
            cookie.Domain = "www.tdscpc.gov.in";
            cookie.Name = "JSESSIONID";
            cookie.Path = "/app";
            cookie.HttpOnly = true;
            cookie.Secure = true;
            cookie.Value = login.Cookie;

            this.strServerResponse = this.makeHTTPPostRequest_SVC(this.strBaseURL + "j_security_check", sbData);
            if (string.IsNullOrEmpty(this.strServerResponse))
            {
                this.IsSessionExists = false;
                TDSResponse.Respons = eResponse.Failed;
                TDSResponse.Message = "Login Failed or Server Error";
                return TDSResponse;
            }
            TDSResponse = this.IsServerError(this.strServerResponse, "//form[@id=\"surveyForm\"]");
            if (TDSResponse.Respons == eResponse.Failed)
            {
                this.IsSessionExists = false;
                TDSResponse.Message = "Please log into your account by visiting www.tdscpc.gov.in and fill the survey form.";
                return TDSResponse;
            }
            TDSResponse = this.IsServerError(this.strServerResponse, "//span[@id=\"err_Summary\"]");
            if (TDSResponse.Respons == eResponse.Failed)
            {
                this.IsSessionExists = false;
                return TDSResponse;
            }
            if (!this.IsConditionMatch(this.strServerResponse, login.TAN))
            {
                TDSResponse.Respons = eResponse.Failed;
                TDSResponse.Message = "Login Failed or Server Error";
                return TDSResponse;
            }

            this.IsSessionExists = true;
            TDSResponse.Respons = eResponse.Success;
            TDSResponse.Message = "";
            return TDSResponse;
        }
        catch (Exception ex)
        {
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = ex.Message;
            return TDSResponse;
        }
    }

    public void Logoff()
    {
        // TDSResponse TDSResponse = new TDSResponse();
        string msg = ".";
        try
        {
            this.makeHTTPGetRequest(this.strBaseURL + "logout.xhtml");
            this.bnlSessionExists = false;
            //TDSResponse.Respons = eResponse.Success;
            msg = "Success";
        }
        catch
        {
            //TDSResponse.Respons = eResponse.Failed;
            msg = "Failed";
        }
       // return msg;
    }

    public TDSResponse Logoff_bak()
    {
        TDSResponse TDSResponse = new TDSResponse();
        try
        {
            this.request = (HttpWebRequest)WebRequest.Create(this.strBaseURL + "/logout.xhtml");
            this.request.CookieContainer = this.objContainer;
            this.request.KeepAlive = true;
            this.response = (HttpWebResponse)this.request.GetResponse();
            this.dataStream = this.response.GetResponseStream();
            this.reader = new StreamReader(this.dataStream);
            this.strServerResponse = this.reader.ReadToEnd();
            this.reader.Close();
            this.dataStream.Close();
            this.response.Close();
            this.bnlSessionExists = false;
            TDSResponse.Respons = eResponse.Success;
        }
        catch
        {
            TDSResponse.Respons = eResponse.Failed;
        }
        return TDSResponse;
    }

    private string makeHTTPPostRequest1(string strURL, StringBuilder sbData)
    {
        this.request = (HttpWebRequest)WebRequest.Create(strURL);
        this.request.Method = "POST";
        this.request.Credentials = CredentialCache.DefaultCredentials;
        this.request.ServicePoint.Expect100Continue = false;
        byte[] bytes = new ASCIIEncoding().GetBytes(sbData.ToString());
        this.request.ContentType = "application/x-www-form-urlencoded";
        this.request.ContentLength = (long)bytes.Length;
        if (sbData != null)
        {
            this.request.Headers.GetType().InvokeMember("ChangeInternal", BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.InvokeMethod, (Binder)null, (object)this.request.Headers, new object[2]
        {
          (object) "Host",
          (object) "www.tdscpc.gov.in"
        });
            this.request.Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8";
            this.request.UserAgent = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.152 Safari/537.22";
            this.request.Headers.Add("Accept-Encoding: gzip,deflate,sdch");
            this.request.Headers.Add("Accept-Language: en-US,en;q=0.8");
            this.request.Headers.Add("Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.3");
            this.request.Headers.Add("Cache-Control: max-age=0");
            this.request.Headers.Add("Origin: https://www.tdscpc.gov.in");
            this.request.Referer = "https://www.tdscpc.gov.in/app/ded/panverify.xhtml";
            this.request.Timeout = 100000;
            this.request.ReadWriteTimeout = 1000000000;
            this.request.Headers.GetType().InvokeMember("ChangeInternal", BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.InvokeMethod, Type.DefaultBinder, (object)this.request.Headers, new object[2]
        {
          (object) "Connection",
          (object) "Keep-Alive"
        });
        }
        if (this.request.CookieContainer == null)
            this.request.CookieContainer = this.objContainer;
        this.request.CookieContainer.Add(new Uri("https://www.tdscpc.gov.in/app/"), this.response.Cookies);
        this.request.GetRequestStream().Write(bytes, 0, bytes.Length);
        this.response = (HttpWebResponse)this.request.GetResponse();
        string str = this.response.ResponseUri.ToString();
        if (!string.IsNullOrEmpty(str))
            str = str.Substring(str.LastIndexOf("/") + 1);
        if (str == "login.xhtml")
        {
            this.strServerResponse = str;
            return this.strServerResponse;
        }
        this.dataStream = this.response.GetResponseStream();
        this.reader = new StreamReader(this.dataStream);
        this.strServerResponse = this.reader.ReadToEnd();
        this.reader.Close();
        this.dataStream.Close();
        this.response.Close();
        return this.strServerResponse;
    }

    private string makeHTTPPostRequest(string strURL, StringBuilder sbData)
    {
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;
        this.request = (HttpWebRequest)WebRequest.Create(strURL);
        this.request.KeepAlive = true;
        byte[] buffer = (byte[])null;
        if (!string.IsNullOrEmpty(Convert.ToString((object)sbData)))
            buffer = Encoding.UTF8.GetBytes(sbData.ToString());
        if (!string.IsNullOrEmpty(Convert.ToString((object)sbData)))
            this.request.ContentLength = (long)buffer.Length;
        if (sbData != null)
        {
            this.request.Method = "POST";
            this.request.Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8";
            this.request.UserAgent = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.57 Safari/537.17";
            this.request.ContentType = "application/x-www-form-urlencoded";
            this.request.Timeout = 1000000000;
        }
        if (this.request.CookieContainer == null)
            this.request.CookieContainer = this.objContainer;
        if (this.response != null)
            this.request.CookieContainer.Add(this.response.Cookies);
        if (!string.IsNullOrEmpty(Convert.ToString((object)sbData)))
        {
            this.dataStream = this.request.GetRequestStream();
            this.dataStream.Write(buffer, 0, buffer.Length);
            this.dataStream.Close();
        }
        this.response = (HttpWebResponse)this.request.GetResponse();
        this.dataStream = this.response.GetResponseStream();
        this.reader = new StreamReader(this.dataStream);
        this.strServerResponse = this.reader.ReadToEnd();
        this.reader.Close();
        this.dataStream.Close();
        this.response.Close();
        return this.strServerResponse;
    }
    private string makeHTTPPostRequest_SVC(string strURL, StringBuilder sbData)
    {
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;
        this.request = (HttpWebRequest)WebRequest.Create(strURL);
        this.request.KeepAlive = true;
        byte[] buffer = (byte[])null;
        if (!string.IsNullOrEmpty(Convert.ToString((object)sbData)))
            buffer = Encoding.UTF8.GetBytes(sbData.ToString());
        if (!string.IsNullOrEmpty(Convert.ToString((object)sbData)))
            this.request.ContentLength = (long)buffer.Length;
        if (sbData != null)
        {
            this.request.Method = "POST";
            this.request.Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8";
            this.request.UserAgent = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.57 Safari/537.17";
            this.request.ContentType = "application/x-www-form-urlencoded";
            this.request.Timeout = 1000000000;
        }
        if (this.request.CookieContainer == null)
            this.request.CookieContainer = this.objContainer;
        if (this.response != null)
            this.request.CookieContainer.Add(this.response.Cookies);
        //NEWLY ADDED
        this.request.CookieContainer.Add(cookie);
        if (!string.IsNullOrEmpty(Convert.ToString((object)sbData)))
        {
            this.dataStream = this.request.GetRequestStream();
            this.dataStream.Write(buffer, 0, buffer.Length);
            this.dataStream.Close();
        }

        this.response = (HttpWebResponse)this.request.GetResponse();
        this.dataStream = this.response.GetResponseStream();
        this.reader = new StreamReader(this.dataStream);
        this.strServerResponse = this.reader.ReadToEnd();
        this.reader.Close();
        this.dataStream.Close();
        this.response.Close();
        return this.strServerResponse;
    }
    private string makeHTTPPostRequest_SVC1(string strURL, StringBuilder sbData)
    {
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;
        this.request = (HttpWebRequest)WebRequest.Create(strURL);
        this.request.KeepAlive = true;
        byte[] buffer = (byte[])null;
        if (!string.IsNullOrEmpty(Convert.ToString((object)sbData)))
            buffer = Encoding.UTF8.GetBytes(sbData.ToString());
        if (!string.IsNullOrEmpty(Convert.ToString((object)sbData)))
            this.request.ContentLength = (long)buffer.Length;
        if (sbData != null)
        {
            this.request.Method = "POST";
            this.request.Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8";
            this.request.UserAgent = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.57 Safari/537.17";
            this.request.ContentType = "application/x-www-form-urlencoded";
            this.request.Timeout = 1000000000;
        }
        if (this.request.CookieContainer == null)
            this.request.CookieContainer = this.objContainer;
        // if (this.response != null)
        //  this.request.CookieContainer.Add(this.response.Cookies);
        //NEWLY ADDED
        //this.request.CookieContainer.Add(cookie);
        if (!string.IsNullOrEmpty(Convert.ToString((object)sbData)))
        {
            this.dataStream = this.request.GetRequestStream();
            this.dataStream.Write(buffer, 0, buffer.Length);
            this.dataStream.Close();
        }

        this.response = (HttpWebResponse)this.request.GetResponse();
        this.dataStream = this.response.GetResponseStream();
        this.reader = new StreamReader(this.dataStream);
        this.strServerResponse = this.reader.ReadToEnd();
        this.reader.Close();
        this.dataStream.Close();
        this.response.Close();
        return this.strServerResponse;
    }

    private string makeHTTPPostRequest_SVC(string strURL, StringBuilder sbData, CookieContainer customCookie)
    {
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;
        this.request = (HttpWebRequest)WebRequest.Create(strURL);
        this.request.KeepAlive = true;
        byte[] buffer = (byte[])null;
        if (!string.IsNullOrEmpty(Convert.ToString((object)sbData)))
            buffer = Encoding.UTF8.GetBytes(sbData.ToString());
        if (!string.IsNullOrEmpty(Convert.ToString((object)sbData)))
            this.request.ContentLength = (long)buffer.Length;
        if (sbData != null)
        {
            this.request.Method = "POST";
            this.request.Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8";
            this.request.UserAgent = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.57 Safari/537.17";
            this.request.ContentType = "application/x-www-form-urlencoded";
            this.request.Timeout = 1000000000;
        }
        // if (this.request.CookieContainer == null)
        this.request.CookieContainer = customCookie;// this.objContainer;
        if (this.response != null)
            this.request.CookieContainer.Add(this.response.Cookies);
        //NEWLY ADDED
        // this.request.CookieContainer.Add(cookie);
        if (!string.IsNullOrEmpty(Convert.ToString((object)sbData)))
        {
            this.dataStream = this.request.GetRequestStream();
            this.dataStream.Write(buffer, 0, buffer.Length);
            this.dataStream.Close();
        }

        this.response = (HttpWebResponse)this.request.GetResponse();
        this.dataStream = this.response.GetResponseStream();
        this.reader = new StreamReader(this.dataStream);
        this.strServerResponse = this.reader.ReadToEnd();
        this.reader.Close();
        this.dataStream.Close();
        this.response.Close();
        return this.strServerResponse;
    }
    private string makeHTTPGetRequest(string strURL)
    {
        ConnectTR.SetAllowUnsafeHeaderParsing();
        ServicePointManager.ServerCertificateValidationCallback = (RemoteCertificateValidationCallback)((_param1, _param2, _param3, _param4) => true);
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;
        this.request = (HttpWebRequest)WebRequest.Create(strURL);
        this.request.KeepAlive = true;
        this.request.Method = "GET";
        this.request.UserAgent = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.57 Safari/537.17";
        this.request.Accept = "text/html";
        this.request.Timeout = 1000000000;
        if (this.request.CookieContainer == null)
            this.request.CookieContainer = this.objContainer;
        this.response = (HttpWebResponse)this.request.GetResponse();
        this.request.CookieContainer.Add(this.response.Cookies);
        this.dataStream = this.response.GetResponseStream();
        this.reader = new StreamReader(this.dataStream);
        this.strServerResponse = this.reader.ReadToEnd();
        this.reader.Close();
        this.dataStream.Close();
        this.response.Close();
        return this.strServerResponse;
    }

    public Stream getCaptchaCode()
    {
        this.bnlSessionExists = false;
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls;
        this.request = (HttpWebRequest)WebRequest.Create(this.strCaptchBaseURL + "GetCaptchaImg");
        this.request.Method = "GET";
        this.request.Accept = "image/png,image/*;q=0.8,*/*;q=0.5";
        this.request.UserAgent = "Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0";
        this.request.ContentType = "text/html; charset=utf-8";
        this.request.KeepAlive = true;
        this.request.CookieContainer = this.objContainer;
        if (this.response.Cookies != null && this.response.Cookies.Count > 0)
            this.objContainer.Add(this.response.Cookies);
        foreach (Cookie cookie in this.response.Cookies)
            this.objContainer.Add(new Cookie(cookie.Name.Trim(), cookie.Value.Trim(), "/", cookie.Domain));
        if (string.IsNullOrEmpty(this.response.Headers["Set-Cookie"]))

            for (int index = 0; index < this.objContainer.GetCookies(this.request.RequestUri).Count; ++index)
            {
                Cookie cookie = this.objContainer.GetCookies(this.request.RequestUri)[index];
            }
        return this.request.GetResponse().GetResponseStream();
    }

    private string makeHTTPJSONRequest(string strURL)
    {
        this.request = (HttpWebRequest)WebRequest.Create(strURL);
        string str = "";
        this.request.ServicePoint.Expect100Continue = false;
        this.request.Method = "GET";
        this.request.UserAgent = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.57 Safari/537.17";
        this.request.ContentType = "application/json";
        this.request.Headers.Add("Cache-Control", "no-cache");
        this.request.KeepAlive = true;
        if (this.request.CookieContainer == null)
            this.request.CookieContainer = this.objContainer;
        this.response = (HttpWebResponse)this.request.GetResponse();
        this.request.CookieContainer.Add(this.response.Cookies);
        using (Stream responseStream = this.response.GetResponseStream())
        {
            using (StreamReader streamReader = new StreamReader(responseStream))
                str = streamReader.ReadToEnd();
        }
        return str;
    }
    private string makeHTTPJSONRequest_SVC(string strURL)
    {
        this.request = (HttpWebRequest)WebRequest.Create(strURL);
        string str = "";
        this.request.ServicePoint.Expect100Continue = false;
        this.request.Method = "GET";
        this.request.UserAgent = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.57 Safari/537.17";
        this.request.ContentType = "application/json";
        this.request.Headers.Add("Cache-Control", "no-cache");
        this.request.KeepAlive = true;
        if (this.request.CookieContainer == null)
            this.request.CookieContainer = this.objContainer;
        this.response = (HttpWebResponse)this.request.GetResponse();
        this.request.CookieContainer.Add(this.response.Cookies);
        using (Stream responseStream = this.response.GetResponseStream())
        {
            using (StreamReader streamReader = new StreamReader(responseStream))
                str = streamReader.ReadToEnd();
        }
        StringBuilder DownloadCookie = new StringBuilder();
        for (int index = 0; index < this.objContainer.GetCookies(this.request.RequestUri).Count; ++index)
        {
            Cookie cookie = this.objContainer.GetCookies(this.request.RequestUri)[index];
            DownloadCookie.Append(cookie.Name + " = " + cookie.Value + ";");
        }
        return str + "@@@" + DownloadCookie.ToString().Trim(';');
    }
    private string makeHTTPJSONPostRequest(string strURL, string sbData)
    {
        this.request = (HttpWebRequest)WebRequest.Create(strURL);
        this.request.KeepAlive = true;
        byte[] buffer = (byte[])null;
        if (!string.IsNullOrEmpty(Convert.ToString(sbData)))
            buffer = Encoding.UTF8.GetBytes(sbData.ToString());
        if (!string.IsNullOrEmpty(Convert.ToString(sbData)))
            this.request.ContentLength = (long)buffer.Length;
        if (sbData != null)
        {
            this.request.Method = "POST";
            this.request.Accept = "application/json, text/javascript, */*; q=0.01";
            this.request.UserAgent = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.154 Safari/537.36";
            this.request.ContentType = "application/x-www-form-urlencoded";
            this.request.Headers.Add("X-Requested-With", "XMLHttpRequest");
            this.request.Timeout = 1000000000;
        }
        if (this.request.CookieContainer == null)
            this.request.CookieContainer = this.objContainer;
        this.request.CookieContainer.Add(this.response.Cookies);
        if (!string.IsNullOrEmpty(Convert.ToString(sbData)))
        {
            this.dataStream = this.request.GetRequestStream();
            this.dataStream.Write(buffer, 0, buffer.Length);
            this.dataStream.Close();
        }
        this.response = (HttpWebResponse)this.request.GetResponse();
        this.dataStream = this.response.GetResponseStream();
        this.reader = new StreamReader(this.dataStream);
        this.strServerResponse = this.reader.ReadToEnd();
        this.reader.Close();
        this.dataStream.Close();
        this.response.Close();
        return this.strServerResponse;
    }

    private bool makeHttpDownloadRequest(string strURL, string strPath)
    {
        bool flag = true;
        try
        {
            ConnectTR.SetAllowUnsafeHeaderParsing();
            ServicePointManager.ServerCertificateValidationCallback = (RemoteCertificateValidationCallback)((_param1, _param2, _param3, _param4) => true);
            this.request = (HttpWebRequest)WebRequest.Create(strURL);
            this.request.KeepAlive = true;
            this.request.Timeout = 300000;
            this.request.AllowWriteStreamBuffering = false;
            this.request.AllowAutoRedirect = true;
            this.request.UserAgent = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.57 Safari/537.17";
            this.request.Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8";
            this.request.Headers.Add("Upgrade-Insecure-Requests", "1");
            this.request.Headers.Add("Accept-Encoding", "gzip, deflate, sdch");
            this.request.Headers.Add("Accept-Language", "en-US,en;q=0.8");
            this.request.CookieContainer = this.objContainer;
            this.request.CookieContainer.Add(this.response.Cookies);
            this.response = (HttpWebResponse)this.request.GetResponse();
            long length = 120000;
            this.dataStream = this.response.GetResponseStream();
            string str = strURL.Substring(strURL.LastIndexOf("/") + 1);
            if (string.IsNullOrEmpty(str))
                str = "File.zip";
            FileStream fileStream = new FileStream(strPath + "\\" + str, FileMode.Create);
            byte[] buffer = new byte[length];
            for (int count = this.dataStream.Read(buffer, 0, buffer.Length); count > 0; count = this.dataStream.Read(buffer, 0, buffer.Length))
                fileStream.Write(buffer, 0, count);
            this.response.Close();
            fileStream.Close();
            this.dataStream.Close();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return flag;
    }

    private string GetFileLocation(string strURL)
    {
        this.request = (HttpWebRequest)WebRequest.Create(strURL);
        this.request.KeepAlive = true;
        this.request.Timeout = 300000;
        this.request.AllowWriteStreamBuffering = false;
        this.request.AllowAutoRedirect = false;
        this.request.UserAgent = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.57 Safari/537.17";
        this.request.CookieContainer = this.objContainer;
        this.request.CookieContainer.Add(this.response.Cookies);
        this.response = (HttpWebResponse)this.request.GetResponse();
        return this.response.Headers["Location"];
    }

    private string GetFileLocation(string strURL, string strReqNo)
    {
        ConnectTR.SetAllowUnsafeHeaderParsing();
        ServicePointManager.ServerCertificateValidationCallback = (RemoteCertificateValidationCallback)((_param1, _param2, _param3, _param4) => true);
        this.request = (HttpWebRequest)WebRequest.Create(strURL);
        this.request.KeepAlive = true;
        byte[] buffer = (byte[])null;
        string str = "";
        try
        {
            if (!string.IsNullOrEmpty(strReqNo))
            {
                str = strReqNo.ToString();
                buffer = Encoding.UTF8.GetBytes(strReqNo);
            }
            if (!string.IsNullOrEmpty(Convert.ToString(strReqNo)))
                this.request.ContentLength = (long)buffer.Length;
            if (strReqNo != null)
            {
                this.request.Method = "POST";
                this.request.UserAgent = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36";
                this.request.ContentType = "application/x-www-form-urlencoded";
                this.request.Headers.Add("X-Requested-With", "XMLHttpRequest");
            }
            if (this.request.CookieContainer == null)
                this.request.CookieContainer = this.objContainer;
            this.request.CookieContainer.Add(this.response.Cookies);
            if (!string.IsNullOrEmpty(Convert.ToString(strReqNo)))
            {
                this.dataStream = this.request.GetRequestStream();
                this.dataStream.Write(buffer, 0, buffer.Length);
                this.dataStream.Close();
            }
            this.response = (HttpWebResponse)this.request.GetResponse();
            this.dataStream = this.response.GetResponseStream();
            this.reader = new StreamReader(this.dataStream);
            this.strServerResponse = this.reader.ReadToEnd();
            this.reader.Close();
            this.dataStream.Close();
            this.response.Close();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return this.strServerResponse;
    }
    private string GetFileLocation_SVC(string strURL, string strReqNo)
    {
        ConnectTR.SetAllowUnsafeHeaderParsing();
        ServicePointManager.ServerCertificateValidationCallback = (RemoteCertificateValidationCallback)((_param1, _param2, _param3, _param4) => true);
        this.request = (HttpWebRequest)WebRequest.Create(strURL);
        this.request.KeepAlive = true;
        byte[] buffer = (byte[])null;
        string str = "";
        try
        {
            if (!string.IsNullOrEmpty(strReqNo))
            {
                str = strReqNo.ToString();
                buffer = Encoding.UTF8.GetBytes(strReqNo);
            }
            if (!string.IsNullOrEmpty(Convert.ToString(strReqNo)))
                this.request.ContentLength = (long)buffer.Length;
            if (strReqNo != null)
            {
                this.request.Method = "POST";
                this.request.UserAgent = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36";
                this.request.ContentType = "application/x-www-form-urlencoded";
                this.request.Headers.Add("X-Requested-With", "XMLHttpRequest");
            }
            if (this.request.CookieContainer == null)
                this.request.CookieContainer = this.objContainer;

            if (!string.IsNullOrEmpty(Convert.ToString(strReqNo)))
            {
                this.dataStream = this.request.GetRequestStream();
                this.dataStream.Write(buffer, 0, buffer.Length);
                this.dataStream.Close();
            }
            this.response = (HttpWebResponse)this.request.GetResponse();
            this.dataStream = this.response.GetResponseStream();
            this.reader = new StreamReader(this.dataStream);
            this.strServerResponse = this.reader.ReadToEnd();
            this.reader.Close();
            this.dataStream.Close();
            this.response.Close();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return this.strServerResponse;
    }

    private string CheckDownloadURL(string strURL)
    {
        this.request = (HttpWebRequest)WebRequest.Create(strURL);
        this.request.KeepAlive = true;
        this.request.Timeout = 300000;
        this.request.AllowWriteStreamBuffering = false;
        this.request.AllowAutoRedirect = false;
        this.request.UserAgent = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.57 Safari/537.17";
        this.request.CookieContainer = this.objContainer;
        this.request.CookieContainer.Add(this.response.Cookies);
        this.response = (HttpWebResponse)this.request.GetResponse();
        this.dataStream = this.response.GetResponseStream();
        this.reader = new StreamReader(this.dataStream);
        this.strServerResponse = this.reader.ReadToEnd();
        this.reader.Close();
        this.dataStream.Close();
        this.response.Close();
        return this.strServerResponse;
    }

    private DataTable JsonParser(string s)
    {
        DataTable dataTable = new DataTable();
        dataTable.Columns.Add("Request Date");
        dataTable.Columns.Add("Request Number");
        dataTable.Columns.Add("Finnancial Number");
        dataTable.Columns.Add("Quarter");
        dataTable.Columns.Add("Form Type");
        dataTable.Columns.Add("File Processed");
        dataTable.Columns.Add("Status");
        dataTable.Columns.Add("Remarks");
        string str = "Test";
        DataRow row = (DataRow)null;
        using (JsonTextReader jsonTextReader = new JsonTextReader((TextReader)new StringReader(s)))
        {
            while (jsonTextReader.Read())
            {
                switch (jsonTextReader.TokenType)
                {
                    case JsonToken.PropertyName:
                        str = jsonTextReader.Value.ToString();
                        break;
                    case JsonToken.Integer:
                    case JsonToken.Float:
                    case JsonToken.String:
                    case JsonToken.Null:
                        switch (str)
                        {
                            case "dntype":
                                row["File Processed"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "finYr":
                                row["Finnancial Number"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "frmType":
                                row["Form Type"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "qrtr":
                                row["Quarter"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "remarks":
                                row["Remarks"] = (object)Convert.ToString(jsonTextReader.Value);
                                dataTable.Rows.Add(row);
                                break;
                            case "reqDate":
                                row = dataTable.NewRow();
                                row["Request Date"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "reqNo":
                                row["Request Number"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "status":
                                row["Status"] = (object)jsonTextReader.Value.ToString();
                                break;
                        }
                        break;
                }
            }
        }
        return dataTable;
    }

    private DataTable JsonParserForCertificateValidation(string s, out string strRowCount)
    {
        strRowCount = "";
        DataTable dataTable = new DataTable();
        dataTable.Columns.Add("Sr.No.");
        dataTable.Columns.Add("Certificate Number");
        dataTable.Columns.Add("Financial Year");
        dataTable.Columns.Add("PAN of the Deductee");
        dataTable.Columns.Add("Name of Deductee");
        dataTable.Columns.Add("Valid From");
        dataTable.Columns.Add("Valid To");
        dataTable.Columns.Add("Section Code");
        dataTable.Columns.Add("Nature of Payment");
        dataTable.Columns.Add("Rate of TDS as per Certificate");
        dataTable.Columns.Add("Certificate Limit (Amount)(Rs.)");
        dataTable.Columns.Add("Amount Consumed(Rs.)");
        dataTable.Columns.Add("Date of Issue");
        string str = "Test";
        DataRow row = (DataRow)null;
        using (JsonTextReader jsonTextReader = new JsonTextReader((TextReader)new StringReader(s)))
        {
            while (jsonTextReader.Read())
            {
                switch (jsonTextReader.TokenType)
                {
                    case JsonToken.PropertyName:
                        str = jsonTextReader.Value.ToString();
                        break;
                    case JsonToken.Integer:
                    case JsonToken.Float:
                    case JsonToken.String:
                    case JsonToken.Null:
                        switch (str)
                        {
                            case "amtconsume":
                                row["Amount Consumed(Rs.)"] = (object)Convert.ToString(jsonTextReader.Value);
                                break;
                            case "certilimit":
                                row["Certificate Limit (Amount)(Rs.)"] = (object)Convert.ToString(jsonTextReader.Value);
                                break;
                            case "certino":
                                row["Certificate Number"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "dedname":
                                row["Name of Deductee"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "deducteepan":
                                row["PAN of the Deductee"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "finyear":
                                row["Financial Year"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "issuedate":
                                row["Date of Issue"] = (object)Convert.ToString(jsonTextReader.Value);
                                dataTable.Rows.Add(row);
                                break;
                            case "natofpayment":
                                row["Nature of Payment"] = (object)Convert.ToString(jsonTextReader.Value);
                                break;
                            case "rateoftds":
                                row["Rate of TDS as per Certificate"] = (object)Convert.ToString(jsonTextReader.Value);
                                break;
                            case "rowCount":
                                strRowCount = jsonTextReader.Value.ToString();
                                break;
                            case "seccode":
                                row["Section Code"] = (object)Convert.ToString(jsonTextReader.Value);
                                break;
                            case "serialno":
                                row = dataTable.NewRow();
                                row["Sr.No."] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "validfrm":
                                row["Valid From"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "validto":
                                row["Valid To"] = (object)jsonTextReader.Value.ToString();
                                break;
                        }
                        break;
                }
            }
        }
        return dataTable;
    }

    private HttpStatusCode IsConnected(string strURL)
    {
        try
        {
            HttpWebRequest httpWebRequest = (HttpWebRequest)WebRequest.Create(strURL);
            httpWebRequest.AllowAutoRedirect = false;
            this.response = (HttpWebResponse)httpWebRequest.GetResponse();
            return this.response.StatusCode;
        }
        catch
        {
            return HttpStatusCode.Forbidden;
        }
    }

    public static bool SetAllowUnsafeHeaderParsing()
    {
        Assembly assembly = Assembly.GetAssembly(typeof(SettingsSection));
        if (assembly != (Assembly)null)
        {
            Type type = assembly.GetType("System.Net.Configuration.SettingsSectionInternal");
            if (type != (Type)null)
            {
                object obj = type.InvokeMember("Section", BindingFlags.Static | BindingFlags.NonPublic | BindingFlags.GetProperty, (Binder)null, (object)null, new object[0]);
                if (obj != null)
                {
                    FieldInfo field = type.GetField("useUnsafeHeaderParsing", BindingFlags.Instance | BindingFlags.NonPublic);
                    if (field != (FieldInfo)null)
                    {
                        field.SetValue(obj, (object)true);
                        return true;
                    }
                }
            }
        }
        return false;
    }

    private Dictionary<string, string> TraceHiddenField(string strHTML, string xPathQuery)
    {
        Dictionary<string, string> dictionary = new Dictionary<string, string>();
        HtmlDocument htmlDocument = new HtmlDocument();
        htmlDocument.LoadHtml(strHTML);
        HtmlNodeCollection htmlNodeCollection1 = htmlDocument.DocumentNode.SelectNodes(xPathQuery);
        if (htmlNodeCollection1 == null)
            return dictionary;
        dictionary.Clear();
        if (htmlNodeCollection1 != null && htmlNodeCollection1.Count > 0)
        {
            foreach (HtmlNode htmlNode in (IEnumerable<HtmlNode>)htmlNodeCollection1)
            {
                HtmlNodeCollection htmlNodeCollection2 = htmlNode.SelectNodes("//input[@type='hidden']");
                if (htmlNodeCollection2 != null && htmlNodeCollection2.Count > 0)
                {
                    for (int index = 0; index < htmlNodeCollection2.Count; ++index)
                    {
                        if (!dictionary.ContainsKey(htmlNodeCollection2[index].Attributes["name"].Value))
                            dictionary.Add(htmlNodeCollection2[index].Attributes["name"].Value, htmlNodeCollection2[index].Attributes["value"].Value);
                    }
                }
            }
        }
        return dictionary;
    }

    private Dictionary<string, string> TraceViewStateData_Old(
      string strHTML,
      string xPathQuery)
    {
        Dictionary<string, string> dictionary = new Dictionary<string, string>();
        HtmlDocument htmlDocument = new HtmlDocument();
        htmlDocument.LoadHtml(strHTML);
        HtmlNodeCollection htmlNodeCollection1 = htmlDocument.DocumentNode.SelectNodes(xPathQuery);
        if (htmlNodeCollection1 == null)
            return dictionary;
        dictionary.Clear();
        if (htmlNodeCollection1 != null && htmlNodeCollection1.Count > 0)
        {
            foreach (HtmlNode htmlNode in (IEnumerable<HtmlNode>)htmlNodeCollection1)
            {
                HtmlNodeCollection htmlNodeCollection2 = htmlNode.SelectNodes("//input[@type='hidden']");
                if (htmlNodeCollection2 != null && htmlNodeCollection2.Count > 0)
                {
                    for (int index = 0; index < htmlNodeCollection2.Count; ++index)
                    {
                        if (!dictionary.ContainsKey(htmlNodeCollection2[index].Attributes["name"].Value))
                            dictionary.Add(htmlNodeCollection2[index].Attributes["name"].Value, htmlNodeCollection2[index].Attributes["value"].Value);
                    }
                }
            }
        }
        return dictionary;
    }

    private Dictionary<string, string> TraceViewStateData(string strHTML, string xPathQuery)
    {
        Dictionary<string, string> dictionary = new Dictionary<string, string>();
        HtmlNode.ElementsFlags.Remove("form");
        HtmlDocument htmlDocument1 = new HtmlDocument();
        htmlDocument1.LoadHtml(strHTML);
        HtmlNode htmlNode = htmlDocument1.DocumentNode.SelectSingleNode(xPathQuery);
        if (htmlNode == null)
            return dictionary;
        HtmlDocument htmlDocument2 = new HtmlDocument();
        htmlDocument2.LoadHtml(htmlNode.InnerHtml);
        dictionary.Clear();
        if (htmlNode != null)
        {
            foreach (HtmlNode selectNode in (IEnumerable<HtmlNode>)htmlDocument2.DocumentNode.SelectNodes("//input[@type='hidden']"))
            {
                if (!dictionary.ContainsKey(selectNode.Attributes["name"].Value))
                    dictionary.Add(selectNode.Attributes["name"].Value, selectNode.Attributes["value"].Value);
            }
        }
        return dictionary;
    }

    private string RetrieveElementValue(
      string strHTML,
      string xPathQuery,
      string strNode,
      ConnectTR.enmElementType enmElement)
    {
        string str = "";
        HtmlDocument htmlDocument = new HtmlDocument();
        htmlDocument.LoadHtml(strHTML);
        HtmlNodeCollection htmlNodeCollection1 = htmlDocument.DocumentNode.SelectNodes(xPathQuery);
        if (htmlNodeCollection1 == null || (htmlNodeCollection1 == null || htmlNodeCollection1.Count <= 0))
            return str;
        foreach (HtmlNode htmlNode in (IEnumerable<HtmlNode>)htmlNodeCollection1)
        {
            HtmlNodeCollection htmlNodeCollection2 = htmlNode.SelectNodes(strNode);
            if (htmlNodeCollection2 != null && htmlNodeCollection2.Count > 0)
            {
                for (int index = 0; index < htmlNodeCollection2.Count; ++index)
                {
                    switch (enmElement)
                    {
                        case ConnectTR.enmElementType.InnerText:
                            str = htmlNodeCollection2[index].InnerText;
                            break;
                        case ConnectTR.enmElementType.InnerHTML:
                            str = htmlNodeCollection2[index].InnerHtml;
                            break;
                        case ConnectTR.enmElementType.Value:
                            str = htmlNodeCollection2[index].Attributes["value"].Value;
                            break;
                        case ConnectTR.enmElementType.Name:
                            str = htmlNodeCollection2[index].Attributes["name"].Value;
                            break;
                    }
                }
            }
        }
        return str;
    }

    private void BugFix_CookieDomain(CookieContainer cookieContainer)
    {
        Hashtable hashtable = (Hashtable)typeof(CookieContainer).InvokeMember("m_domainTable", BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.GetField, (Binder)null, (object)cookieContainer, new object[0]);
        foreach (string str1 in new ArrayList(hashtable.Keys))
        {
            string str2 = str1;
            if (str2[0] == '.')
            {
                string str3 = str2.Remove(0, 1);
                hashtable[(object)str3] = hashtable[(object)str1];
            }
        }
    }
    //NEWLY ADDED
    public string MakeInitialRequest_SVC()
    {
        this.makeHTTPGetRequest("https://www.tdscpc.gov.in/app/login.xhtml");
        var stream = this.getCaptchaCode();
        byte[] bytes;
        using (var memoryStream = new MemoryStream())
        {
            stream.CopyTo(memoryStream);
            bytes = memoryStream.ToArray();
        }

        string base64 = Convert.ToBase64String(bytes);
        return JsonConvert.SerializeObject(new[] { new
{
    Cookie=this.response.Cookies[1].Value ,
         base64="data:image/png;base64,"+base64
}});
    }
    public Stream MakeInitialRequest()
    {
        this.makeHTTPGetRequest("https://www.tdscpc.gov.in/app/login.xhtml");
        return this.getCaptchaCode();
    }

    private string RetrievePANName(string strHTML)
    {
        string str = "NOT AVAILABLE";
        HtmlDocument htmlDocument = new HtmlDocument();
        htmlDocument.LoadHtml(strHTML);
        HtmlNodeCollection htmlNodeCollection = htmlDocument.DocumentNode.SelectNodes("//td[@id='name']");
        if (htmlNodeCollection != null && htmlNodeCollection.Count > 0)
        {
            for (int index = 0; index < htmlNodeCollection.Count; ++index)
                str = htmlNodeCollection[index].InnerText;
        }
        return str;
    }

    public Stream GetCaptchaForPANVerify()
    {
        this.makeHTTPGetRequest("https://incometaxindiaefiling.gov.in/e-Filing/Services/KnowYourJurisdiction.html");
        this.request = (HttpWebRequest)WebRequest.Create("https://incometaxindiaefiling.gov.in/e-Filing/CreateCaptcha.do");
        this.request.Method = "GET";
        this.request.Accept = "image/png,image/*;q=0.8,*/*;q=0.5";
        this.request.UserAgent = "Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0";
        this.request.ContentType = "text/html; charset=utf-8";
        this.request.KeepAlive = true;
        this.request.CookieContainer = this.objContainer;
        if (this.response.Cookies != null && this.response.Cookies.Count > 0)
            this.objContainer.Add(this.response.Cookies);
        foreach (Cookie cookie in this.response.Cookies)
            this.objContainer.Add(new Cookie(cookie.Name.Trim(), cookie.Value.Trim(), "/", cookie.Domain));
        for (int index = 0; index < this.objContainer.GetCookies(this.request.RequestUri).Count; ++index)
        {
            Cookie cookie = this.objContainer.GetCookies(this.request.RequestUri)[index];
        }
        return this.request.GetResponse().GetResponseStream();
    }

    //public TDSResponse VerifyPAN(string strPan, string strCaptchaCode)
    //{
    //  StringBuilder stringBuilder = new StringBuilder();
    //  TDSResponse tracesResponse1 = new TDSResponse();
    //  PANVerifierDetails panVerifierDetails = new PANVerifierDetails();
    //  string request = this.makeHTTPGetRequest("https://incometaxindiaefiling.gov.in/e-Filing/Services/KnowYourJurisdiction.html?requestId=&panOfDeductee=" + strPan + "&captchaCode=" + strCaptchaCode);
    //  TDSResponse tracesResponse2 = this.IsServerError(request, "//div[@class=\"error\"]");
    //  if (tracesResponse2.Respons == eResponse.Failed)
    //  {
    //    tracesResponse2.Respons = eResponse.Failed;
    //    return tracesResponse2;
    //  }
    //  HtmlDocument htmlDocument = new HtmlDocument();
    //  htmlDocument.LoadHtml(request);
    //  if (Regex.IsMatch(request, "PAN does not exist"))
    //  {
    //    tracesResponse2.Message = "PAN does not exist";
    //    tracesResponse2.Respons = eResponse.Failed;
    //    return tracesResponse2;
    //  }
    //  HtmlNode documentNode = htmlDocument.DocumentNode;
    //  string str1 = "";
    //  tracesResponse2.Respons = eResponse.Success;
    //  foreach (HtmlNode selectNode in (IEnumerable<HtmlNode>) htmlDocument.DocumentNode.SelectNodes("//table[@class='grid']//tr//td"))
    //  {
    //    if (str1 != "")
    //    {
    //      string str2 = selectNode.InnerText.Replace("\n", "").Replace("\r", "").Replace("\t", "");
    //      if (str1.ToUpper() == "SURNAME")
    //        panVerifierDetails.Surname = str2;
    //      if (str1.ToUpper() == "MIDDLE NAME")
    //        panVerifierDetails.MiddleName = str2;
    //      if (str1.ToUpper() == "FIRST NAME")
    //        panVerifierDetails.FirstName = str2;
    //      if (str1.ToUpper() == "AREA CODE")
    //        panVerifierDetails.AreaCode = str2;
    //      if (str1.ToUpper() == "AO TYPE")
    //        panVerifierDetails.AOType = str2;
    //      if (str1.ToUpper() == "RANGE CODE")
    //        panVerifierDetails.RangeCode = str2;
    //      if (str1.ToUpper() == "AO NUMBER")
    //        panVerifierDetails.AONumber = str2;
    //      if (str1.ToUpper() == "JURISDICTION")
    //        panVerifierDetails.Jurisdiction = str2;
    //      if (str1.ToUpper() == "BUILDING NAME")
    //        panVerifierDetails.BuildingName = str2;
    //    }
    //    str1 = selectNode.InnerText.Replace("\n", "").Replace("\r", "").Replace("\t", "");
    //  }
    //  tracesResponse2.CustomeTypes = (object) panVerifierDetails;
    //  return tracesResponse2;
    //}

    public TDSResponse DownloadConsoTAN_PANFile(
      LoginTraces objLogin,
      TracesData objTraceData)
    {
        TDSResponse TDSResponse = new TDSResponse();
        try
        {
            if (!this.IsSessionExists)
            {
                TDSResponse = this.makeLoginToTRACES(objLogin);
                if (TDSResponse.Respons == eResponse.Failed)
                    return TDSResponse;
            }
            string request = this.makeHTTPGetRequest(this.strBaseURL + "ded/panverify.xhtml");
            if (!this.IsStringExists(request, "//form[@id=\"pandetailsForm2\"]"))
            {
                string str = this.RetrieveElementValue(request, "//div[@class=\"padLeft5 margintop20\"]", "//span[@class=\"boldFont\"]", ConnectTR.enmElementType.InnerText);
                if (!string.IsNullOrEmpty(str))
                {
                    TDSResponse.Message = str;
                    TDSResponse.Respons = eResponse.Failed;
                    return TDSResponse;
                }
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            StringBuilder sbData1 = new StringBuilder();
            sbData1.Append("finYr=" + objTraceData.FAYear);
            sbData1.Append("&qrtr=" + objTraceData.Quarter);
            sbData1.Append("&frmType=" + objTraceData.Forms);
            sbData1.Append("&frmType2=" + objTraceData.Forms);
            sbData1.Append("&clickGo2=Go");
            Dictionary<string, string> dictionary1 = this.TraceViewStateData(request, "//form[@id=\"pandetailsForm2\"]");
            if (dictionary1.Count <= 0)
            {
                this.Logoff();
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            foreach (KeyValuePair<string, string> keyValuePair in dictionary1)
            {
                if (keyValuePair.Key != "pandetailsForm1_SUBMIT")
                    sbData1.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            }
            string str1 = this.makeHTTPPostRequest(this.strBaseURL + "ded/panverify.xhtml", sbData1);
            TDSResponse = this.IsServerError(str1, "//ul[@id=\"err_Summary\"]");
            if (TDSResponse.Respons == eResponse.Failed)
            {
                this.Logoff();
                TDSResponse.Respons = eResponse.Failed;
                return TDSResponse;
            }
            if (!this.IsStringExists(str1, "//form[@id=\"dedkyc\"]"))
            {
                this.Logoff();
                this.bnlSessionExists = false;
                TDSResponse.Message = "Please Enter Valid Financial Details";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            StringBuilder sbData2 = new StringBuilder();
            sbData2.Append("&stmtSpecKyc=1");
            sbData2.Append("&bforeLogin=3");
            sbData2.Append("&token=" + objTraceData.PRN_NO);
            if (objTraceData.IsNoChallanCheck)
                sbData2.Append("&cinbinCheck=" + objTraceData.IsNoChallanCheck.ToString());
            sbData2.Append("&cinbinValue=" + objTraceData.IsNoChallan.ToString());
            StringBuilder stringBuilder1 = sbData2;
            bool flag = objTraceData.IsPaymentByBookAdjustmentCheck;
            string str2 = "&bkEntryFlgChk=" + flag.ToString();
            stringBuilder1.Append(str2);
            StringBuilder stringBuilder2 = sbData2;
            flag = objTraceData.IsPaymentByBookAdjustment;
            string str3 = "&bkEntryValue=" + flag.ToString();
            stringBuilder2.Append(str3);
            if (objTraceData.panAmtValueCheck)
            {
                StringBuilder stringBuilder3 = sbData2;
                flag = objTraceData.panAmtValueCheck;
                string str4 = "&panAmtCheck=" + flag.ToString();
                stringBuilder3.Append(str4);
            }
            StringBuilder stringBuilder4 = sbData2;
            flag = objTraceData.panAmtValue;
            string str5 = "&panAmtValue=" + flag.ToString();
            stringBuilder4.Append(str5);
            if (!objTraceData.IsNoChallanCheck)
            {
                sbData2.Append("&bsr=" + objTraceData.BSRCode);
                sbData2.Append("&dtoftaxdep=" + objTraceData.TaxDepositedDate);
                sbData2.Append("&csn=" + objTraceData.ChallanSerialNo);
                sbData2.Append("&chlnamt=" + objTraceData.ChallanAmount);
            }
            if (!objTraceData.panAmtValueCheck)
            {
                sbData2.Append("&pan1=" + objTraceData.PAN1);
                sbData2.Append("&amt1=" + objTraceData.PAN1Amount);
                sbData2.Append("&pan2=" + objTraceData.PAN2);
                sbData2.Append("&amt2=" + objTraceData.PAN2Amount);
                sbData2.Append("&pan3=" + objTraceData.PAN3);
                sbData2.Append("&amt3=" + objTraceData.PAN3Amount);
            }
            sbData2.Append("&clickKYC=Proceed");
            Dictionary<string, string> dictionary2 = this.TraceViewStateData(str1, "//form[@id=\"dedkyc\"]");
            foreach (KeyValuePair<string, string> keyValuePair in dictionary2)
                sbData2.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            if (dictionary2.Count <= 0)
            {
                this.Logoff();
                this.bnlSessionExists = false;
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            string str6 = this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3form.xhtml", sbData2);
            if (!this.IsStringExists(str6, "//form[@id=\"dedkyc\"]"))
            {
                this.bnlSessionExists = false;
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            TDSResponse = this.IsServerError(str6, "//div[@id=\"err_Summary\"]");
            if (TDSResponse.Respons == eResponse.Failed)
            {
                string str4 = this.HTMLTagAttributeValue(this.strServerResponse, "//input[@id=\"frmType0\"]", "value");
                string str7 = this.HTMLTagAttributeValue(this.strServerResponse, "//input[@id=\"finYr0\"]", "value");
                string str8 = this.HTMLTagAttributeValue(this.strServerResponse, "//input[@id=\"qrtr0\"]", "value");
                if (TDSResponse.Message.Replace("\n", "") == "Token Number is not valid for Regular Statement")
                    TDSResponse.CustomeTypes = (object)new List<string>()
            {
              str7,
              str4,
              str8
            };
                this.Logoff();
                TDSResponse.Respons = eResponse.Failed;
                return TDSResponse;
            }
            string str9 = this.RetrieveElementValue(str6, "//form[@id=\"dedkyc\"]", "//input[@id=\"authcode\"]", ConnectTR.enmElementType.Value);
            Dictionary<string, string> dictionary3 = this.TraceViewStateData(str6, "//form[@id=\"dedkyc\"]");
            StringBuilder sbData3 = new StringBuilder();
            sbData3.Append("authcode=" + HttpUtility.UrlEncode(str9.Trim()));
            sbData3.Append("&redirect=" + HttpUtility.UrlEncode("Proceed with Transaction"));
            sbData3.Append("&dedkyc_SUBMIT=1");
            foreach (KeyValuePair<string, string> keyValuePair in dictionary3)
                sbData3.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            Dictionary<string, string> dictionary4 = this.TraceViewStateData(this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3confirm.xhtml", sbData3), "//form[@id=\"downloadreq\"]");
            if (dictionary4.Count <= 0)
            {
                this.Logoff();
                this.bnlSessionExists = false;
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            StringBuilder stringBuilder5 = new StringBuilder();
            foreach (KeyValuePair<string, string> keyValuePair in dictionary4)
            {
                if (keyValuePair.Key == "finYr")
                    stringBuilder5.Append("fy=" + keyValuePair.Value);
                if (keyValuePair.Key == "qrtr")
                {
                    if (keyValuePair.Value == "")
                        stringBuilder5.Append("&qr=0");
                    else
                        stringBuilder5.Append("&qr=" + keyValuePair.Value);
                }
                if (keyValuePair.Key == "formType")
                    stringBuilder5.Append("&ft=" + keyValuePair.Value);
                if (keyValuePair.Key == "dwldType")
                    stringBuilder5.Append("&dt=" + keyValuePair.Value);
            }
            string str10 = this.RetrieveElementValue(this.makeHTTPGetRequest(this.strBaseURL + "srv/CreateDwnldReqServlet?" + stringBuilder5.ToString()), "//div[@class='margintop20']", "//h5", ConnectTR.enmElementType.InnerText);
            if (!string.IsNullOrEmpty(str10))
            {
                TDSResponse.CustomeTypes = (object)new RequestStatus()
                {
                    AuthenticationCode = str9,
                    StatusMessage = str10
                };
                TDSResponse.Respons = eResponse.Success;
            }
            this.Logoff();
        }
        catch (Exception ex)
        {
            this.Logoff();
            this.bnlSessionExists = false;
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = ex.Message;
        }
        return TDSResponse;
    }

    private string HTMLTagAttributeValue(string strHTML, string xPathQuery, string strAttName)
    {
        HtmlDocument htmlDocument = new HtmlDocument();
        htmlDocument.LoadHtml(strHTML);
        return htmlDocument.DocumentNode.SelectNodes(xPathQuery)[0].Attributes[strAttName].Value;
    }

    public bool IsValidPAN(string PAN_No)
    {
        try
        {
            this.strServerResponse = this.makeHTTPGetRequest("https://onlineservices.tin.egov-nsdl.com/etaxnew/tdsnontds.jsp");
            if (!this.IsStringExists(this.strServerResponse, "//form[@name=\"selectform\"]"))
                return false;
            string str = this.HTMLTagAttributeValue(this.strServerResponse, "//form[@name=\"selectform\"]", "action");
            if (string.IsNullOrEmpty(str))
                return false;
            StringBuilder sbData1 = new StringBuilder();
            sbData1.Append("browser_type=IE");
            sbData1.Append("&from_tdsnontds=Y");
            sbData1.Append("&R2=280");
            this.strServerResponse = this.makeHTTPPostRequest("https://onlineservices.tin.egov-nsdl.com/etaxnew/" + str, sbData1);
            StringBuilder sbData2 = new StringBuilder();
            sbData2.Append("AssessYear=");
            sbData2.Append("&Add_State=");
            sbData2.Append("&Name=");
            sbData2.Append("&Add_PIN=");
            sbData2.Append("&Add_Line1=");
            sbData2.Append("&Add_Line2=");
            sbData2.Append("&Add_Line3=");
            sbData2.Append("&Add_Line4=");
            sbData2.Append("&Add_Line5=");
            sbData2.Append("&PAN=" + PAN_No);
            sbData2.Append("&ChallanNo=");
            sbData2.Append("&MinorHeadRadio=");
            sbData2.Append("&MajorHeadRadio=");
            this.strServerResponse = this.makeHTTPPostRequest("https://onlineservices.tin.egov-nsdl.com/etaxnew/PopulateBankServlet", sbData2);
            return !Regex.IsMatch(this.strServerResponse, "Invalid PAN", RegexOptions.IgnoreCase);
        }
        catch
        {
            return false;
        }
    }

    public bool IsValidPAN(string strPan, string strCaptchaCode, out bool IsError)
    {
        IsError = false;
        StringBuilder stringBuilder = new StringBuilder();
        TDSResponse TDSResponse = new TDSResponse();
        try
        {
            string request = this.makeHTTPGetRequest("https://incometaxindiaefiling.gov.in/e-Filing/Services/KnowYourJurisdiction.html?requestId=&panOfDeductee=" + strPan + "&captchaCode=" + strCaptchaCode);
            if (this.IsServerError(request, "//div[@class=\"error\"]").Respons == eResponse.Failed)
            {
                IsError = Regex.IsMatch(request, "Invalid Code") || (Regex.IsMatch(request, "Invalid PAN") || true);
                return false;
            }
            new HtmlDocument().LoadHtml(request);
            return !Regex.IsMatch(request, "PAN does not exist");
        }
        catch (Exception ex)
        {
            IsError = true;
            return false;
        }
    }

    public bool IsValidCaptcha(string strPan, string strCaptchaCode, out bool IsError)
    {
        IsError = false;
        StringBuilder stringBuilder = new StringBuilder();
        TDSResponse TDSResponse = new TDSResponse();
        try
        {
            string request = this.makeHTTPGetRequest("https://incometaxindiaefiling.gov.in/e-Filing/Services/KnowYourJurisdiction.html?requestId=&panOfDeductee=" + strPan + "&captchaCode=" + strCaptchaCode);
            if (this.IsServerError(request, "//div[@class=\"error\"]").Respons == eResponse.Failed)
                return (Regex.IsMatch(request, "Invalid Code") || !Regex.IsMatch(request, "Invalid PAN")) && false;
        }
        catch (Exception ex)
        {
            IsError = true;
            return false;
        }
        return true;
    }

    private List<string> getDownloadAnchorLink(string strHTML)
    {
        HtmlDocument htmlDocument = new HtmlDocument();
        htmlDocument.LoadHtml(strHTML);
        List<string> stringList = new List<string>();
        HtmlNodeCollection htmlNodeCollection = htmlDocument.DocumentNode.SelectNodes("//a");
        if (htmlNodeCollection != null)
        {
            foreach (HtmlNode htmlNode in (IEnumerable<HtmlNode>)htmlNodeCollection)
            {
                HtmlAttribute attribute = htmlNode.Attributes["href"];
                stringList.Add(attribute.Value.ToString().Replace("&amp;", "&").Replace("\r\n", ""));
            }
        }
        return stringList;
    }

    //public TDSResponse RequestForPANValidation(string strPAN)
    //{
    //  TDSResponse TDSResponse = new TDSResponse();
    //  string str = "";
    //  try
    //  {
    //    string request = this.makeHTTPGetRequest(this.strBaseURL + "ded/panverify.xhtml");
    //    if (!this.IsStringExists(request, "//form[@id=\"pandetailsForm1\"]"))
    //    {
    //      TDSResponse.Respons = eResponse.SessionTimeout;
    //      return TDSResponse;
    //    }
    //    StringBuilder sbData = new StringBuilder();
    //    sbData.Append("pannumber=" + strPAN.Trim());
    //    sbData.Append("&frmType1=24Q");
    //    sbData.Append("&clickGo1=Go");
    //    sbData.Append("&pandetailsForm1_SUBMIT=1");
    //    Dictionary<string, string> dictionary = this.TraceViewStateData(request, "//form[@id=\"pandetailsForm1\"]");
    //    foreach (KeyValuePair<string, string> keyValuePair in dictionary)
    //    {
    //      if ("javax.faces.ViewState" == keyValuePair.Key)
    //        sbData.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
    //    }
    //    str = this.makeHTTPPostRequest(this.strBaseURL + "ded/panverify.xhtml", sbData);
    //    if (TDSResponse.Respons == eResponse.Failed)
    //      return TDSResponse;
    //    PANDetails panDetails = new PANDetails();
    //    panDetails.PAN = strPAN;
    //    foreach (KeyValuePair<string, string> keyValuePair in dictionary)
    //    {
    //      if (keyValuePair.Key.ToString().ToUpper() == "STATUS")
    //        panDetails.Status = keyValuePair.Value;
    //      if (keyValuePair.Key.ToString().ToUpper() == "NAME")
    //        panDetails.Name = keyValuePair.Value;
    //    }
    //    TDSResponse.CustomeTypes = (object) panDetails;
    //    TDSResponse.Respons = eResponse.Success;
    //  }
    //  catch (Exception ex)
    //  {
    //    TDSResponse.Message = ex.Message;
    //    TDSResponse.Respons = eResponse.Failed;
    //  }
    //  return TDSResponse;
    //}

    //public TDSResponse RequestForPANValidation(string strPAN, out string strName)
    //{
    //  TDSResponse TDSResponse = new TDSResponse();
    //  strName = "";
    //  try
    //  {
    //    string request = this.makeHTTPGetRequest(this.strBaseURL + "ded/panverify.xhtml");
    //    if (!this.IsStringExists(request, "//form[@id=\"pandetailsForm1\"]"))
    //    {
    //      TDSResponse.Respons = eResponse.SessionTimeout;
    //      return TDSResponse;
    //    }
    //    StringBuilder sbData = new StringBuilder();
    //    sbData.Append("pannumber=" + strPAN.Trim());
    //    sbData.Append("&frmType1=24Q");
    //    sbData.Append("&clickGo1=Go");
    //    sbData.Append("&pandetailsForm1_SUBMIT=1");
    //    foreach (KeyValuePair<string, string> keyValuePair in this.TraceViewStateData(request, "//form[@id=\"pandetailsForm1\"]"))
    //    {
    //      if ("javax.faces.ViewState" == keyValuePair.Key)
    //      {
    //        sbData.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
    //        break;
    //      }
    //    }
    //    string strHTML = this.makeHTTPPostRequest(this.strBaseURL + "ded/panverify.xhtml", sbData);
    //    if (TDSResponse.Respons == eResponse.Failed)
    //      return TDSResponse;
    //    strName = this.RetrievePANName(strHTML);
    //    TDSResponse.Respons = eResponse.Success;
    //  }
    //  catch (Exception ex)
    //  {
    //    TDSResponse.Message = ex.Message;
    //    TDSResponse.Respons = eResponse.Failed;
    //  }
    //  return TDSResponse;
    //}

    public TDSResponse CIN_Period_Payment(TracesData objData)
    {
        DataTable dataTable = new DataTable();
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        try
        {
            this.strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "ded/challanstatusquery.xhtml");
            TDSResponse.ChlResponce = this.strServerResponse;
            if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"chlnStatusForm1\"]"))
            {
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            StringBuilder sbData = new StringBuilder();
            sbData.Append("_search=false");
            sbData.Append("&rows=2000");
            sbData.Append("&page=1");
            sbData.Append("&sidx=");
            sbData.Append("&sord=");
            this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "ded/srv/ChlnStatusServlet?reqtype=0&sdate=" + objData.FromDT + "&edate=" + objData.ToDate + "&cstatus=" + objData.ChallanStatus, sbData);
            if (!string.IsNullOrEmpty(this.strServerResponse))
            {
                dataTable = new DataTable();
                dataTable.Columns.Add("bankCode");
                dataTable.Columns.Add("branchCode");
                dataTable.Columns.Add("dateOfDep");
                dataTable.Columns.Add("chlnSNo");
                dataTable.Columns.Add("chlnStatus");
                dataTable.Columns.Add("recptNum");
                dataTable.Columns.Add("chlnAmt");
                string str = "Test";
                DataRow row = (DataRow)null;
                using (JsonTextReader jsonTextReader = new JsonTextReader((TextReader)new StringReader(this.strServerResponse)))
                {
                    while (jsonTextReader.Read())
                    {
                        switch (jsonTextReader.TokenType)
                        {
                            case JsonToken.PropertyName:
                                str = jsonTextReader.Value.ToString();
                                break;
                            case JsonToken.Integer:
                            case JsonToken.Float:
                            case JsonToken.String:
                            case JsonToken.Null:
                                switch (str)
                                {
                                    case "bankCode":
                                        row["bankCode"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "branchCode":
                                        row["branchCode"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "chlnAmt":
                                        if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                        {
                                            double num = Convert.ToDouble(jsonTextReader.Value.ToString());
                                            row["chlnAmt"] = (object)string.Format("{0:0.00}", (object)num);
                                            break;
                                        }
                                        row["chlnAmt"] = (object)"";
                                        break;
                                    case "chlnSNo":
                                        row["chlnSNo"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "chlnStatus":
                                        row["chlnStatus"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "dateOfDep":
                                        row = dataTable.NewRow();
                                        row["dateOfDep"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "recptNum":
                                        row["recptNum"] = (object)jsonTextReader.Value.ToString();
                                        dataTable.Rows.Add(row);
                                        break;
                                }
                                break;
                        }
                    }
                }
            }
            else
            {
                TDSResponse.Respons = eResponse.Failed;
                TDSResponse.Message = "Server error";
            }
            TDSResponse.DTable = dataTable;
            TDSResponse.CustomeTypes = (object)dataTable;
        }
        catch (Exception ex)
        {
            if (Regex.IsMatch(ex.Message, "410"))
            {
                TDSResponse.Respons = eResponse.SessionTimeout;
                TDSResponse.Respons = eResponse.Failed;
            }
            else if (Regex.IsMatch(ex.Message, "406"))
            {
                TDSResponse.Message = "Invalid Challan Amount";
                TDSResponse.Respons = eResponse.Failed;
            }
            TDSResponse.Message = ex.Message;
        }
        return TDSResponse;
    }

    public TDSResponse SearchChallanDetails(
      Challan objData,
      string strCaptchaCode,
      out string strRetHtml)
    {
        strRetHtml = "";
        TDSResponse TDSResponse = new TDSResponse();
        try
        {
            TDSResponse.Respons = eResponse.Success;
            StringBuilder sbData1 = new StringBuilder();
            sbData1.Append("TAN_NO=" + objData.TAN_NO.ToString());
            sbData1.Append("&TAN_FROM_DT_DD=" + objData.TAN_FROM_DT_DD);
            sbData1.Append("&TAN_FROM_DT_MM=" + objData.TAN_FROM_DT_MM);
            sbData1.Append("&TAN_FROM_DT_YY=" + objData.TAN_FROM_DT_YY);
            sbData1.Append("&TAN_TO_DT_DD=" + objData.TAN_TO_DT_DD);
            sbData1.Append("&TAN_TO_DT_MM=" + objData.TAN_TO_DT_MM);
            sbData1.Append("&TAN_TO_DT_YY=" + objData.TAN_TO_DT_YY);
            sbData1.Append("&HID_IMG_TXT=" + strCaptchaCode);
            sbData1.Append("&HIDDEN_TAN_FROM_DT_DD=01");
            sbData1.Append("&HIDDEN_TAN_FROM_DT_MM=04");
            sbData1.Append("&HIDDEN_TAN_TO_DT_DD=31");
            sbData1.Append("&HIDDEN_TAN_TO_DT_MM=03");
            sbData1.Append("&HIDDEN_TAN_TO_DT_YY=");
            sbData1.Append("&submit=View Challan details");
            sbData1.Append("&appUser=T");
            sbData1.Append("&appUser=T");
            string str1 = this.makeHTTPPostRequest("https://tin.tin.nsdl.com/oltas/servlet/TanSearch", sbData1);
            if (Regex.IsMatch(str1, "Error - Text does not match. Please enter new text.", RegexOptions.IgnoreCase))
            {
                TDSResponse.Respons = eResponse.Failed;
                TDSResponse.Message = "Invalid Captcha Code";
                return TDSResponse;
            }
            if (Regex.IsMatch(str1, "SITE UNDER MAINTENANCE", RegexOptions.IgnoreCase))
            {
                TDSResponse.Respons = eResponse.Failed;
                TDSResponse.Message = "Server Error";
                return TDSResponse;
            }
            if (Regex.IsMatch(str1, "Record Not Found", RegexOptions.IgnoreCase))
            {
                TDSResponse.Respons = eResponse.Failed;
                TDSResponse.Message = "Record Not Found";
                return TDSResponse;
            }
            Dictionary<string, string> dictionary = this.TraceallInputFields(str1, "//form[@name=\"TanSearch\"]");
            StringBuilder sbData2 = new StringBuilder();
            bool flag = false;
            if (dictionary.ContainsKey("NO_OF_ROWS"))
            {
                int int32 = Convert.ToInt32(dictionary["NO_OF_ROWS"]);
                for (int index = 1; index <= int32; ++index)
                {
                    flag = true;
                    dictionary["RS_AMT_" + index.ToString()] = "0.00";
                }
            }
            if (!flag)
                return (TDSResponse)null;
            foreach (KeyValuePair<string, string> keyValuePair in dictionary)
                sbData2.Append(keyValuePair.Key + "=" + keyValuePair.Value + "&");
            sbData2.Append("submit=Confirm Amount");
            string html = this.makeHTTPPostRequest("https://tin.tin.nsdl.com/oltas/servlet/TanSearch", sbData2);
            DataTable dataTable = new DataTable();
            dataTable.Columns.Add("No.");
            dataTable.Columns.Add("Challan Tender Date");
            dataTable.Columns.Add("Challan Serial No.");
            dataTable.Columns.Add("BSR Code");
            dataTable.Columns.Add("Received Date");
            dataTable.Columns.Add("Major Head code");
            dataTable.Columns.Add("Minor Head Code");
            dataTable.Columns.Add("Nature of Payment");
            HtmlDocument htmlDocument = new HtmlDocument();
            htmlDocument.LoadHtml(html);
            HtmlNodeCollection htmlNodeCollection1 = htmlDocument.DocumentNode.SelectNodes("//table[1]");
            if (htmlNodeCollection1 != null)
            {
                int num = 1;
                HtmlNodeCollection htmlNodeCollection2 = htmlNodeCollection1[0].SelectNodes(".//tr");
                for (int index = 1; index < htmlNodeCollection2.Count; ++index)
                {
                    HtmlNodeCollection htmlNodeCollection3 = htmlNodeCollection2[index].SelectNodes(".//td");
                    if (htmlNodeCollection3 != null && htmlNodeCollection3.Count > 5)
                    {
                        string str2 = "RS_BSR_CD_" + num.ToString();
                        string str3 = htmlNodeCollection2[index].SelectSingleNode("//input[@type='HIDDEN' and @name='" + str2 + "']").Attributes["value"].Value;
                        DataRow row = dataTable.NewRow();
                        row["No."] = (object)Convert.ToString(htmlNodeCollection3[0].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
                        row["Challan Tender Date"] = (object)Convert.ToString(htmlNodeCollection3[1].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
                        row["Challan Serial No."] = (object)Convert.ToString(htmlNodeCollection3[2].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
                        row["BSR Code"] = (object)str3;
                        row["Received Date"] = (object)Convert.ToString(htmlNodeCollection3[3].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
                        row["Major Head code"] = (object)Convert.ToString(htmlNodeCollection3[4].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
                        row["Minor Head Code"] = (object)Convert.ToString(htmlNodeCollection3[5].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
                        row["Nature of Payment"] = (object)Convert.ToString(htmlNodeCollection3[6].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
                        dataTable.Rows.Add(row);
                        ++num;
                    }
                }
            }
            TDSResponse.CustomeTypes = (object)dataTable;
            strRetHtml = html;
        }
        catch (Exception ex)
        {
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = "Processing of challan request failed";
        }
        return TDSResponse;
    }

  
    public TDSResponse CIN_CIN_BINParticulars(TracesData objData, string cr)
    {
        StringBuilder sbData = new StringBuilder();
        DataTable dataTable = new DataTable();
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        try
        {
            //if (cr != "")
            //{
            //    this.strServerResponse = cr;
            //}
            //this.strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "ded/dashboard.xhtml");  

            this.strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "ded/challanstatusquery.xhtml");
            //this.strServerResponse =objData.ChlResponce;

            if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"chlnStatusForm3\"]"))
            {
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            sbData.Append("_search=false");
            sbData.Append("&rows=2000");
            sbData.Append("&page=1");
            sbData.Append("&sidx=");
            sbData.Append("&sord=");
            this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "ded/srv/ChlnStatusServlet?reqtype=1&bsrCode=" + objData.BSRCode + "&chlnSNo=" + objData.ChallanSerialNo + "&chlnAmt=" + objData.ChallanAmount + "&dateOfDep=" + objData.TaxDepositedDate, sbData);
            //reqtype = 1 & bsrCode = 0510349 & chlnSNo = 96385 & chlnAmt = 23063.00 & dateOfDep = 05 - May - 2023"


            if (!string.IsNullOrEmpty(this.strServerResponse))
            {
                dataTable = new DataTable();
                dataTable.Columns.Add("Bank Code");
                dataTable.Columns.Add("Branch Code");
                dataTable.Columns.Add("Date of Deposit");
                dataTable.Columns.Add("Challan Serial Number");
                dataTable.Columns.Add("Challan Status");
                dataTable.Columns.Add("Recipt Number");
                dataTable.Columns.Add("Chllan Amount");
                string str = "Test";
                DataRow row = (DataRow)null;
                using (JsonTextReader jsonTextReader = new JsonTextReader((TextReader)new StringReader(this.strServerResponse)))
                {
                    while (jsonTextReader.Read())
                    {
                        switch (jsonTextReader.TokenType)
                        {
                            case JsonToken.PropertyName:
                                str = jsonTextReader.Value.ToString();
                                break;
                            case JsonToken.Integer:
                            case JsonToken.Float:
                            case JsonToken.String:
                            case JsonToken.Null:
                                switch (str)
                                {
                                    case "bankCode":
                                        row["Bank Code"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "branchCode":
                                        row["Branch Code"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "chlnAmt":
                                        if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                        {
                                            double num = Convert.ToDouble(jsonTextReader.Value.ToString());
                                            row["chllan Amount"] = (object)string.Format("{0:0.00}", (object)num);
                                            break;
                                        }
                                        row["chllan Amount"] = (object)"";
                                        break;
                                    case "chlnSNo":
                                        row["Challan Serial Number"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "chlnStatus":
                                        row["Challan Status"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "dateOfDep":
                                        row = dataTable.NewRow();
                                        row["Date of Deposit"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "recptNum":
                                        row["Recipt Number"] = (object)jsonTextReader.Value.ToString();
                                        dataTable.Rows.Add(row);
                                        break;
                                }
                                break;
                        }
                    }
                }
            }
            else
            {
                TDSResponse.Respons = eResponse.Failed;
                TDSResponse.Message = "No data available for the specified search criteria";
            }
            TDSResponse.CustomeTypes = (object)dataTable;
        }
        catch (Exception ex)
        {
            if (Regex.IsMatch(ex.Message, "410"))
            {
                TDSResponse.Respons = eResponse.SessionTimeout;
                TDSResponse.Respons = eResponse.Failed;
            }
            else if (Regex.IsMatch(ex.Message, "406"))
            {
                TDSResponse.Message = "Invalid Challan Amount";
                TDSResponse.Respons = eResponse.Failed;
            }
            TDSResponse.Message = ex.Message;
        }
        return TDSResponse;
    }

    public TDSResponse BIN_Period_Payment(TracesData objData)
    {
        DataTable dataTable = new DataTable();
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        try
        {
            this.strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "ded/challanstatusquery.xhtml");
            if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"chlnStatusForm1\"]"))
            {
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            StringBuilder sbData = new StringBuilder();
            sbData.Append("_search=false");
            sbData.Append("&rows=2000");
            sbData.Append("&page=1");
            sbData.Append("&sidx=");
            sbData.Append("&sord=");
            this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "ded/srv/ChlnStatusServlet?reqtype=6&tvsdate=" + objData.FromChallanDepositDate + "&tvedate=" + objData.ToChallanDepositDate + "&tvstatus=" + objData.ChallanStatus, sbData);
            if (!string.IsNullOrEmpty(this.strServerResponse))
            {
                dataTable = new DataTable();
                dataTable.Columns.Add("Transfer Voucher Date");
                dataTable.Columns.Add("DDO Serial Number");
                dataTable.Columns.Add("Status");
                dataTable.Columns.Add("Chllan Amount");
                dataTable.Columns.Add("Recipt Number");
                dataTable.Columns.Add("Record ID");
                string str1 = "Test";
                DataRow row = (DataRow)null;
                using (JsonTextReader jsonTextReader = new JsonTextReader((TextReader)new StringReader(this.strServerResponse)))
                {
                    while (jsonTextReader.Read())
                    {
                        switch (jsonTextReader.TokenType)
                        {
                            case JsonToken.PropertyName:
                                str1 = jsonTextReader.Value.ToString();
                                break;
                            case JsonToken.Integer:
                            case JsonToken.Float:
                            case JsonToken.String:
                            case JsonToken.Null:
                                string str2 = str1;
                                if (!(str2 == "dateOfDep"))
                                {
                                    if (!(str2 == "ddoSlNum"))
                                    {
                                        if (!(str2 == "chlnStatus"))
                                        {
                                            if (!(str2 == "chlnAmt"))
                                            {
                                                if (!(str2 == "rcptNo"))
                                                {
                                                    if (str2 == "recordId")
                                                    {
                                                        row["Record ID"] = (object)jsonTextReader.Value.ToString();
                                                        dataTable.Rows.Add(row);
                                                        break;
                                                    }
                                                    break;
                                                }
                                                row["Recipt Number"] = (object)jsonTextReader.Value.ToString();
                                                break;
                                            }
                                            if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                            {
                                                double num = Convert.ToDouble(jsonTextReader.Value.ToString());
                                                row["chllan Amount"] = (object)string.Format("{0:0.00}", (object)num);
                                                break;
                                            }
                                            row["chllan Amount"] = (object)"";
                                            break;
                                        }
                                        row["Status"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    }
                                    row["DDO Serial Number"] = (object)jsonTextReader.Value.ToString();
                                    break;
                                }
                                row = dataTable.NewRow();
                                row["Transfer Voucher Date"] = (object)jsonTextReader.Value.ToString();
                                break;
                        }
                    }
                }
            }
            else
            {
                TDSResponse.Respons = eResponse.Failed;
                TDSResponse.Message = "Server error";
            }
            TDSResponse.CustomeTypes = (object)dataTable;
        }
        catch (Exception ex)
        {
            if (Regex.IsMatch(ex.Message, "410"))
            {
                TDSResponse.Respons = eResponse.SessionTimeout;
                TDSResponse.Respons = eResponse.Failed;
            }
            else if (Regex.IsMatch(ex.Message, "406"))
            {
                TDSResponse.Message = "Invalid Challan Amount";
                TDSResponse.Respons = eResponse.Failed;
            }
            TDSResponse.Message = ex.Message;
        }
        return TDSResponse;
    }

    public TDSResponse BIN_Particulars(TracesData objData)
    {
        DataTable dataTable = new DataTable();
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        try
        {
            this.strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "ded/challanstatusquery.xhtml");
            if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"chlnStatusForm1\"]"))
            {
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            StringBuilder sbData = new StringBuilder();
            sbData.Append("_search=false");
            sbData.Append("&rows=2000");
            sbData.Append("&page=1");
            sbData.Append("&sidx=");
            sbData.Append("&sord=");
            this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "ded/srv/ChlnStatusServlet?reqtype=4&rcptNo=" + objData.BSRCode + "&ddoSNo=" + objData.ChallanSerialNo + "&chlnAmt=" + objData.ChallanAmount + "&dateOfDep=" + objData.TaxDepositedDate, sbData);
            if (!string.IsNullOrEmpty(this.strServerResponse))
            {
                dataTable = new DataTable();
                dataTable.Columns.Add("Transfer Voucher Date");
                dataTable.Columns.Add("DDO Serial Number");
                dataTable.Columns.Add("Status");
                dataTable.Columns.Add("Transfer Voucher Amount");
                dataTable.Columns.Add("Recipt Number");
                dataTable.Columns.Add("Record ID");
                string str1 = "Test";
                DataRow row = (DataRow)null;
                double num = 0.0;
                using (JsonTextReader jsonTextReader = new JsonTextReader((TextReader)new StringReader(this.strServerResponse)))
                {
                    while (jsonTextReader.Read())
                    {
                        switch (jsonTextReader.TokenType)
                        {
                            case JsonToken.PropertyName:
                                str1 = jsonTextReader.Value.ToString();
                                break;
                            case JsonToken.Integer:
                            case JsonToken.Float:
                            case JsonToken.String:
                            case JsonToken.Null:
                                string str2 = str1;
                                if (!(str2 == "dateOfDep"))
                                {
                                    if (!(str2 == "ddoSlNum"))
                                    {
                                        if (!(str2 == "chlnStatus"))
                                        {
                                            if (!(str2 == "chlnAmt"))
                                            {
                                                if (!(str2 == "rcptNo"))
                                                {
                                                    if (str2 == "recordId")
                                                    {
                                                        row["Record ID"] = (object)jsonTextReader.Value.ToString();
                                                        dataTable.Rows.Add(row);
                                                        break;
                                                    }
                                                    break;
                                                }
                                                row["Recipt Number"] = (object)jsonTextReader.Value.ToString();
                                                break;
                                            }
                                            if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                                num = Convert.ToDouble(jsonTextReader.Value.ToString());
                                            row["Transfer Voucher Amount"] = (object)string.Format("{0:0.00}", (object)num);
                                            break;
                                        }
                                        row["Status"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    }
                                    row["DDO Serial Number"] = (object)jsonTextReader.Value.ToString();
                                    break;
                                }
                                row = dataTable.NewRow();
                                row["Transfer Voucher Date"] = (object)jsonTextReader.Value.ToString();
                                break;
                        }
                    }
                }
            }
            else
            {
                TDSResponse.Respons = eResponse.Failed;
                TDSResponse.Message = "No data available for the specified search criteria";
            }
            TDSResponse.CustomeTypes = (object)dataTable;
        }
        catch (Exception ex)
        {
            if (Regex.IsMatch(ex.Message, "410"))
            {
                TDSResponse.Respons = eResponse.SessionTimeout;
                TDSResponse.Respons = eResponse.Failed;
            }
            else if (Regex.IsMatch(ex.Message, "406"))
            {
                TDSResponse.Message = "Invalid Challan Amount";
                TDSResponse.Respons = eResponse.Failed;
            }
            TDSResponse.Message = ex.Message;
        }
        return TDSResponse;
    }

    //public enmChallanStatus ChallanStatusQuery(ChallanQuery objData)
    //{
    //  try
    //  {
    //    string str1 = "";
    //    enmChallanStatus enmChallanStatus = enmChallanStatus.PROCESSING_FAILED;
    //    StringBuilder sbData1 = new StringBuilder();
    //    sbData1.Append("firstTime=yes");
    //    sbData1.Append("&submit=TAN Based View");
    //    str1 = this.makeHTTPPostRequest("https://tin.tin.nsdl.com/oltas/servlet/TanSearch", sbData1);
    //    if (string.IsNullOrEmpty(this.HTMLTagAttributeValue(this.strServerResponse, "//form[@name=\"TanSearch\"]", "action")))
    //      return enmChallanStatus;
    //    StringBuilder sbData2 = new StringBuilder();
    //    sbData2.Append("TAN_NO=" + objData.TAN);
    //    sbData2.Append("&TAN_FROM_DT_DD=" + objData.FromDate.Substring(0, 2));
    //    sbData2.Append("&TAN_FROM_DT_MM=" + objData.FromDate.Substring(3, 2));
    //    sbData2.Append("&TAN_FROM_DT_YY=" + objData.FromDate.Substring(6, 4));
    //    sbData2.Append("&TAN_TO_DT_DD=" + objData.ToDate.Substring(0, 2));
    //    sbData2.Append("&TAN_TO_DT_MM=" + objData.ToDate.Substring(3, 2));
    //    sbData2.Append("&TAN_TO_DT_YY=" + objData.ToDate.Substring(6, 4));
    //    sbData2.Append("&HIDDEN_TAN_FROM_DT_DD=" + this.HTMLTagAttributeValue(this.strServerResponse, "//input[@name=\"HIDDEN_TAN_FROM_DT_DD\"]", "value"));
    //    sbData2.Append("&HIDDEN_TAN_FROM_DT_MM=" + this.HTMLTagAttributeValue(this.strServerResponse, "//input[@name=\"HIDDEN_TAN_FROM_DT_MM\"]", "value"));
    //    sbData2.Append("&HIDDEN_TAN_TO_DT_DD=" + this.HTMLTagAttributeValue(this.strServerResponse, "//input[@name=\"HIDDEN_TAN_TO_DT_DD\"]", "value"));
    //    sbData2.Append("&HIDDEN_TAN_TO_DT_MM=" + this.HTMLTagAttributeValue(this.strServerResponse, "//input[@name=\"HIDDEN_TAN_TO_DT_MM\"]", "value"));
    //    sbData2.Append("&HIDDEN_TAN_TO_DT_YY=" + this.HTMLTagAttributeValue(this.strServerResponse, "//input[@name=\"HIDDEN_TAN_TO_DT_YY\"]", "value"));
    //    sbData2.Append("&submit=" + this.HTMLTagAttributeValue(this.strServerResponse, "//input[@id=\"VIEWDETAILS\"]", "value"));
    //    sbData2.Append("&appUser=" + this.HTMLTagAttributeValue(this.strServerResponse, "//input[@name=\"appUser\"]", "value"));
    //    sbData2.Append("&appUser=" + this.HTMLTagAttributeValue(this.strServerResponse, "//input[@name=\"appUser\"]", "value"));
    //    string str2 = this.makeHTTPPostRequest("https://tin.tin.nsdl.com/oltas/servlet/TanSearch", sbData2);
    //    if (Regex.IsMatch(str2, "Record Not Found", RegexOptions.IgnoreCase))
    //      return enmChallanStatus.RECORD_NOT_FOUND;
    //    Dictionary<string, string> dictionary = this.TraceallInputFields(str2, "//form[@name=\"TanSearch\"]");
    //    StringBuilder sbData3 = new StringBuilder();
    //    string str3 = objData.ChallanDate.Substring(0, 2) + objData.ChallanDate.Substring(3, 2) + objData.ChallanDate.Substring(8, 2);
    //    bool flag = false;
    //    foreach (KeyValuePair<string, string> keyValuePair in dictionary)
    //    {
    //      string s = keyValuePair.Key.Substring(keyValuePair.Key.LastIndexOf("_") + 1);
    //                int num;
    //      if (int.TryParse(s, out num))
    //      {
    //        if (str3 == keyValuePair.Value)
    //          flag = true;
    //        if (keyValuePair.Key != "RS_CHK_" + s)
    //          sbData3.Append(keyValuePair.Key + "=" + keyValuePair.Value + "&");
    //        if (keyValuePair.Key == "RS_CHALLAN_SQ_NO_" + s && Convert.ToInt32(objData.ChallanNo) == Convert.ToInt32(keyValuePair.Value) & flag)
    //        {
    //          sbData3.Append("RS_CHK_" + s + "=1&");
    //          sbData3.Append("RS_AMT_" + s + "=" + objData.ChallanAmount + "&");
    //          flag = false;
    //        }
    //      }
    //      else
    //        sbData3.Append(keyValuePair.Key + "=" + keyValuePair.Value + "&");
    //    }
    //    sbData3.Append("submit=Confirm Amount");
    //    string input = this.makeHTTPPostRequest("https://tin.tin.nsdl.com/oltas/servlet/TanSearch", sbData3);
    //    return !Regex.IsMatch(input, "Amount Matched", RegexOptions.IgnoreCase) ? (!Regex.IsMatch(input, "Amount Not Matched") ? enmChallanStatus.RECORD_NOT_FOUND : enmChallanStatus.AMOUNT_NOT_MATCHED) : enmChallanStatus.AMOUNT_MATCHED;
    //  }
    //  catch (Exception ex)
    //  {
    //    throw ex;
    //  }
    //}

    private Dictionary<string, string> TraceallInputFields(
      string strHTML,
      string xPathQuery)
    {
        Dictionary<string, string> dictionary = new Dictionary<string, string>();
        HtmlDocument htmlDocument = new HtmlDocument();
        htmlDocument.LoadHtml(strHTML);
        HtmlNodeCollection htmlNodeCollection1 = htmlDocument.DocumentNode.SelectNodes(xPathQuery);
        if (htmlNodeCollection1 == null)
            return dictionary;
        dictionary.Clear();
        if (htmlNodeCollection1 != null && htmlNodeCollection1.Count > 0)
        {
            foreach (HtmlNode htmlNode in (IEnumerable<HtmlNode>)htmlNodeCollection1)
            {
                HtmlNodeCollection htmlNodeCollection2 = htmlNode.SelectNodes("//input");
                if (htmlNodeCollection2 != null && htmlNodeCollection2.Count > 0)
                {
                    for (int index = 0; index < htmlNodeCollection2.Count; ++index)
                    {
                        if (!dictionary.ContainsKey(htmlNodeCollection2[index].Attributes["name"].Value))
                            dictionary.Add(htmlNodeCollection2[index].Attributes["name"].Value, htmlNodeCollection2[index].Attributes["value"].Value);
                    }
                }
            }
        }
        return dictionary;
    }

    public TDSResponse RequestForBIN_Details(List<string> strVal)
    {
        StringBuilder sbData = new StringBuilder();
        DataTable dataTable = new DataTable();
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        try
        {
            sbData.Append("_search=false");
            sbData.Append("&rows=2000");
            sbData.Append("&page=1");
            sbData.Append("&sidx=tokenNum");
            sbData.Append("&sord=desc");
            this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "ded/srv/ChlnStatusServlet?reqtype=5&recordId=" + strVal[0] + "&rcptNo=" + strVal[1] + "&ddoSNo=" + strVal[2] + "&chlnAmt=" + strVal[3] + "&dateOfDep=" + strVal[4], sbData);
            if (this.IsStringExists(this.strServerResponse, "//form[@id=\"loginForm\"]"))
            {
                TDSResponse.Message = "Session Timeout";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            if (!string.IsNullOrEmpty(this.strServerResponse))
            {
                int num1 = 0;
                dataTable = new DataTable();
                dataTable.Columns.Add("Token Number");
                dataTable.Columns.Add("Finnancial Year");
                dataTable.Columns.Add("Quarter");
                dataTable.Columns.Add("Form Type");
                dataTable.Columns.Add("Claimed Amount");
                dataTable.Columns.Add("Status");
                dataTable.Columns.Add("Excess Amount Claimed");
                dataTable.Columns.Add("Available Amount");
                string str = "Test";
                DataRow row = (DataRow)null;
                double num2 = 0.0;
                using (JsonTextReader jsonTextReader = new JsonTextReader((TextReader)new StringReader(this.strServerResponse)))
                {
                    while (jsonTextReader.Read())
                    {
                        switch (jsonTextReader.TokenType)
                        {
                            case JsonToken.PropertyName:
                                str = jsonTextReader.Value.ToString();
                                break;
                            case JsonToken.Integer:
                            case JsonToken.Float:
                            case JsonToken.String:
                            case JsonToken.Null:
                                switch (str)
                                {
                                    case "availAmt":
                                        if (num1 > 0)
                                        {
                                            if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                                num2 = Convert.ToDouble(jsonTextReader.Value.ToString());
                                            row["Available Amount"] = (object)string.Format("{0:0.00}", (object)num2);
                                            dataTable.Rows.Add(row);
                                            break;
                                        }
                                        break;
                                    case "chlnStatus":
                                        row["Status"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "claimAmt":
                                        if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                            num2 = Convert.ToDouble(jsonTextReader.Value.ToString());
                                        row["Claimed Amount"] = (object)string.Format("{0:0.00}", (object)num2);
                                        break;
                                    case "excessAmt":
                                        if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                            num2 = Convert.ToDouble(jsonTextReader.Value.ToString());
                                        row["Excess Amount Claimed"] = (object)string.Format("{0:0.00}", (object)num2);
                                        break;
                                    case "finYr":
                                        row["Finnancial Year"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "formType":
                                        row["Form Type"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "qtr":
                                        row["Quarter"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "rowCount":
                                        num1 = Convert.ToInt32(jsonTextReader.Value);
                                        break;
                                    case "tokenNum":
                                        row = dataTable.NewRow();
                                        row["Token Number"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                }
                                break;
                        }
                    }
                }
            }
            else
            {
                TDSResponse.Respons = eResponse.Failed;
                TDSResponse.Message = "Server error";
            }
            TDSResponse.CustomeTypes = (object)dataTable;
        }
        catch (Exception ex)
        {
            if (Regex.IsMatch(ex.Message, "410"))
            {
                TDSResponse.Respons = eResponse.SessionTimeout;
                TDSResponse.Respons = eResponse.Failed;
            }
            else if (Regex.IsMatch(ex.Message, "406"))
            {
                TDSResponse.Message = "Invalid Challan Amount";
                TDSResponse.Respons = eResponse.Failed;
            }
            else if (Regex.IsMatch(ex.Message, "500"))
            {
                TDSResponse.Message = "System has encountered some technical problem. Please try after some time";
                TDSResponse.Respons = eResponse.Failed;
            }
        }
        return TDSResponse;
    }

    public TDSResponse RequestForDefaultSummary(LoginTraces objLogin)
    {
        TDSResponse TDSResponse = new TDSResponse();
        try
        {
            if (!this.IsSessionExists)
            {
                TDSResponse = this.makeLoginToTRACES(objLogin);
                if (TDSResponse.Respons == eResponse.Failed)
                    return TDSResponse;
            }
            string request = this.makeHTTPGetRequest(this.strBaseURL + "ded/viewdemandsum.xhtml");
            if (this.IsStringExists(request, "//form[@id=\"viewdemandsumForm\"]"))
                ;
            HtmlDocument htmlDocument = new HtmlDocument();
            HtmlNode.ElementsFlags.Remove("option");
            htmlDocument.LoadHtml(request);
            SortedDictionary<string, string> sortedDictionary1 = new SortedDictionary<string, string>();
            SortedDictionary<string, string> sortedDictionary2 = new SortedDictionary<string, string>();
            foreach (HtmlNode selectNode in (IEnumerable<HtmlNode>)htmlDocument.DocumentNode.SelectNodes("//select[@id='financialYear']//option"))
                sortedDictionary1.Add(selectNode.Attributes["value"].Value, selectNode.InnerText);
            foreach (HtmlNode selectNode in (IEnumerable<HtmlNode>)htmlDocument.DocumentNode.SelectNodes("//select[@id='quarter']//option"))
                sortedDictionary2.Add(selectNode.Attributes["value"].Value, selectNode.InnerText);
            DataTable dTable = new DataTable();
            dTable.Columns.Add("FA Year Code");
            dTable.Columns.Add("Quarter Code");
            dTable.Columns.Add("FA Year");
            dTable.Columns.Add("Quarter");
            dTable.Columns.Add("Form Type");
            dTable.Columns.Add("Net Payable(Rounded-Off)");
            foreach (KeyValuePair<string, string> keyValuePair1 in sortedDictionary1)
            {
                if (!string.IsNullOrEmpty(keyValuePair1.Key))
                {
                    foreach (KeyValuePair<string, string> keyValuePair2 in sortedDictionary2)
                    {
                        if (!string.IsNullOrEmpty(keyValuePair2.Key))
                        {
                            StringBuilder sbData = new StringBuilder();
                            sbData.Append("finyear=" + keyValuePair1.Key);
                            sbData.Append("&quarter=" + keyValuePair2.Key);
                            sbData.Append("&finYr=" + keyValuePair1.Value);
                            this.getDefaultSummaryDetails(this.makeHTTPPostRequest(this.strBaseURL + "ded/demandsum.xhtml", sbData), keyValuePair1.Key, keyValuePair2.Key, keyValuePair1.Value, keyValuePair2.Value, ref dTable);
                        }
                    }
                }
            }
            TDSResponse.Respons = eResponse.Success;
            TDSResponse.CustomeTypes = (object)dTable;
        }
        catch (Exception ex)
        {
            this.Logoff();
            this.bnlSessionExists = false;
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = ex.Message;
        }
        return TDSResponse;
    }

    public TDSResponse RequestForDefaultSummary(LoginTraces objLogin, TracesData objTraceData, out DataTable dTable)
    {
        TDSResponse TDSResponse = new TDSResponse();
        dTable = new DataTable();
        try
        {
            if (!this.IsSessionExists)
            {
                TDSResponse = this.makeLoginToTRACES_SVC(objLogin);
                if (TDSResponse.Respons == eResponse.Failed)
                    return TDSResponse;
            }
            string request = this.makeHTTPGetRequest(this.strBaseURL + "ded/viewdemandsum.xhtml");
            if (this.IsStringExists(request, "//form[@id=\"viewdemandsumForm\"]"))
                ;
            HtmlDocument htmlDocument = new HtmlDocument();
            HtmlNode.ElementsFlags.Remove("option");
            htmlDocument.LoadHtml(request);
            SortedDictionary<string, string> sortedDictionary1 = new SortedDictionary<string, string>();
            SortedDictionary<string, string> sortedDictionary2 = new SortedDictionary<string, string>();
            foreach (HtmlNode selectNode in (IEnumerable<HtmlNode>)htmlDocument.DocumentNode.SelectNodes("//select[@id='financialYear']//option"))
                sortedDictionary1.Add(selectNode.Attributes["value"].Value, selectNode.InnerText);
            foreach (HtmlNode selectNode in (IEnumerable<HtmlNode>)htmlDocument.DocumentNode.SelectNodes("//select[@id='quarter']//option"))
                sortedDictionary2.Add(selectNode.Attributes["value"].Value, selectNode.InnerText);
            //DataTable dTable = new DataTable();
            dTable.Columns.Add("FA Year Code");
            dTable.Columns.Add("Quarter Code");
            dTable.Columns.Add("FA Year");
            dTable.Columns.Add("Quarter");
            dTable.Columns.Add("Form Type");
            dTable.Columns.Add("Net Payable(Rounded-Off)");

            StringBuilder sbData = new StringBuilder();
            string finyear = objTraceData.FAYear.Substring(0, objTraceData.FAYear.IndexOf("-"));
            sbData.Append("finyear=" + finyear);
            sbData.Append("&quarter=" + objTraceData.Quarter);
            sbData.Append("&finYr=" + objTraceData.FAYear);
            this.getDefaultSummaryDetails(this.makeHTTPPostRequest_SVC(this.strBaseURL + "ded/demandsum.xhtml", sbData), finyear,
                objTraceData.Quarter, objTraceData.FAYear, objTraceData.Quarter, ref dTable);

            TDSResponse.Respons = eResponse.Success;
            TDSResponse.CustomeTypes = (object)dTable;
        }
        catch (Exception ex)
        {
            this.Logoff();
            this.bnlSessionExists = false;
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = ex.Message;
        }
        return TDSResponse;
    }

    private void getDefaultSummaryDetails(
      string strResp,
      string strFACode,
      string QtrCode,
      string strFAYear,
      string Qtr,
      ref DataTable dTable)
    {
        HtmlDocument htmlDocument = new HtmlDocument();
        htmlDocument.LoadHtml(strResp);
        HtmlNodeCollection htmlNodeCollection1 = htmlDocument.DocumentNode.SelectNodes("//table");
        if (htmlNodeCollection1 == null)
            return;
        HtmlNodeCollection htmlNodeCollection2 = htmlNodeCollection1[0].SelectNodes(".//tr");
        for (int index = 1; index < htmlNodeCollection2.Count; ++index)
        {
            HtmlNodeCollection htmlNodeCollection3 = htmlNodeCollection2[index].SelectNodes(".//td");
            if (htmlNodeCollection3 != null)
            {
                DataRow row = dTable.NewRow();
                row["FA Year Code"] = (object)strFACode;
                row["Quarter Code"] = (object)QtrCode;
                row["FA Year"] = (object)strFAYear;
                row["Quarter"] = (object)Convert.ToString(htmlNodeCollection3[0].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
                row["Form Type"] = (object)Convert.ToString(htmlNodeCollection3[1].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
                row["Net Payable(Rounded-Off)"] = (object)Convert.ToString(htmlNodeCollection3[2].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
                dTable.Rows.Add(row);
            }
        }
    }



    public TDSResponse RequestDefaultSummaryDetails(ArrayList objData)
    {
        DataTable table1 = new DataTable();
        DataTable table2 = new DataTable();
        DataTable table3 = new DataTable();
        DataTable table4 = new DataTable();
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        try
        {
            this.strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "ded/viewdemandsum.xhtml");
            if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"viewdemandsumForm\"]"))
            {
                TDSResponse.Message = "Session Timeout";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            this.strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "ded/demsummary.xhtml?fy=" + Convert.ToString(objData[0]) + "&quarterdesc=" + Convert.ToString(objData[3]) + "&qr=" + Convert.ToString(objData[1]) + "&ft=" + Convert.ToString(objData[4]) + "&finyrdesc=" + Convert.ToString(objData[2]));
            if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"demandsumForm\"]"))
            {
                TDSResponse.Message = "Session Timeout";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            HtmlDocument htmlDocument = new HtmlDocument();
            htmlDocument.LoadHtml(this.strServerResponse);
            HtmlNodeCollection htmlNodeCollection1 = htmlDocument.DocumentNode.SelectNodes("//table[@class=\"userList w550\"]");
            if (htmlNodeCollection1 != null)
            {
                HtmlNodeCollection htmlNodeCollection2 = htmlNodeCollection1[0].SelectNodes(".//tr");
                table2.Columns.Add("Statement");
                table2.Columns.Add("Token Number");
                table2.Columns.Add("Order Passed Date");
                for (int index = 0; index < htmlNodeCollection2.Count; ++index)
                {
                    HtmlNodeCollection htmlNodeCollection3 = htmlNodeCollection2[index].SelectNodes(".//td");
                    if (htmlNodeCollection3 != null)
                    {
                        DataRow row = table2.NewRow();
                        row["Statement"] = (object)Convert.ToString(htmlNodeCollection3[0].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
                        row["Token Number"] = (object)Convert.ToString(htmlNodeCollection3[1].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
                        row["Order Passed Date"] = (object)Convert.ToString(htmlNodeCollection3[2].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
                        table2.Rows.Add(row);
                    }
                }
                table3.Columns.Add("Count of Correction Statement(s)");
                table3.Columns.Add("Net Payable (Rounded-Off)(Rs.)");
                HtmlNodeCollection htmlNodeCollection4 = htmlNodeCollection1[1].SelectNodes(".//tr");
                for (int index = 0; index < htmlNodeCollection4.Count; ++index)
                {
                    HtmlNodeCollection htmlNodeCollection3 = htmlNodeCollection4[index].SelectNodes(".//td");
                    if (htmlNodeCollection3 != null)
                    {
                        DataRow row = table3.NewRow();
                        row["Count of Correction Statement(s)"] = (object)Convert.ToString(htmlNodeCollection3[0].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
                        row["Net Payable (Rounded-Off)(Rs.)"] = (object)Convert.ToString(htmlNodeCollection3[1].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
                        table3.Rows.Add(row);
                    }
                }
            }
            HtmlNodeCollection htmlNodeCollection5 = htmlDocument.DocumentNode.SelectNodes("//table[@class=\"userList w750\"]");
            if (htmlNodeCollection5 != null)
            {
                table1.Columns.Add("Sr.No.");
                table1.Columns.Add("Type of Default");
                table1.Columns.Add("Default Amount");
                table1.Columns.Add("Amount Reported As 'Interest / Others' Claimed in the Statement(Rs.)");
                table1.Columns.Add("Payable(Rs.)");
                HtmlNodeCollection htmlNodeCollection2 = htmlNodeCollection5[0].SelectNodes(".//tr");
                for (int index = 1; index < htmlNodeCollection2.Count; ++index)
                {
                    HtmlNodeCollection htmlNodeCollection3 = htmlNodeCollection2[index].SelectNodes(".//td");
                    if (htmlNodeCollection3 != null)
                    {
                        DataRow row = table1.NewRow();
                        row["Sr.No."] = (object)Convert.ToString(htmlNodeCollection3[0].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
                        row["Type of Default"] = (object)Convert.ToString(htmlNodeCollection3[1].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
                        row["Default Amount"] = (object)Convert.ToString(htmlNodeCollection3[2].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
                        row["Amount Reported As 'Interest / Others' Claimed in the Statement(Rs.)"] = (object)Convert.ToString(htmlNodeCollection3[3].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
                        row["Payable(Rs.)"] = (object)Convert.ToString(htmlNodeCollection3[4].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
                        table1.Rows.Add(row);
                    }
                }
            }
            HtmlNodeCollection htmlNodeCollection6 = htmlDocument.DocumentNode.SelectNodes("//table[@class=\"userList marginTop10 w398\"]");
            if (htmlNodeCollection6 != null)
            {
                HtmlNodeCollection htmlNodeCollection2 = htmlNodeCollection6[0].SelectNodes(".//tr");
                table4.Columns.Add("Deductees Without PAN");
                table4.Columns.Add("Deductees With Invalid PAN");
                for (int index = 1; index < htmlNodeCollection2.Count; ++index)
                {
                    HtmlNodeCollection htmlNodeCollection3 = htmlNodeCollection2[index].SelectNodes(".//td");
                    if (htmlNodeCollection3 != null)
                    {
                        DataRow row = table4.NewRow();
                        row["Deductees Without PAN"] = (object)Convert.ToString(htmlNodeCollection3[0].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
                        row["Deductees With Invalid PAN"] = (object)Convert.ToString(htmlNodeCollection3[1].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
                        table4.Rows.Add(row);
                    }
                }
            }
            DataSet dataSet = new DataSet();
            dataSet.Tables.Add(table2);
            dataSet.Tables.Add(table3);
            dataSet.Tables.Add(table1);
            dataSet.Tables.Add(table4);
            TDSResponse.Respons = eResponse.Success;
            TDSResponse.CustomeTypes = (object)dataSet;
            if (string.IsNullOrEmpty(this.strServerResponse))
            {
                TDSResponse.Respons = eResponse.Failed;
                TDSResponse.Message = "Server error";
            }
        }
        catch (Exception ex)
        {
            TDSResponse.Respons = !Regex.IsMatch(ex.Message, "410") ? eResponse.Failed : eResponse.SessionTimeout;
            TDSResponse.Message = ex.Message;
        }
        return TDSResponse;
    }

    private string AttributeValie(string strHTML, string strXPath, string strAttrib)
    {
        HtmlDocument htmlDocument = new HtmlDocument();
        htmlDocument.LoadHtml(strHTML);
        return htmlDocument.DocumentNode.SelectSingleNode(strXPath).Attributes[strAttrib].Value;
    }

    public Stream GetCaptchaforBulkPAN()
    {
        try
        {
            this.request = (HttpWebRequest)WebRequest.Create("https://incometaxindiaefiling.gov.in/e-Filing/CreateCaptcha.do");
            this.request.Method = "GET";
            this.request.Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8";
            this.request.UserAgent = "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.87 Safari/537.36";
            this.request.ContentType = "text/html; charset=utf-8";
            this.request.KeepAlive = true;
            this.request.CookieContainer = this.objContainer;
            return this.request.GetResponse().GetResponseStream();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public Stream getTINNSDLCaptchaForBin()
    {
        Stream stream = (Stream)null;
        try
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
            this.request = (HttpWebRequest)WebRequest.Create("https://onlineservices.tin.egov-nsdl.com/TIN/CaptchaEtbafServlet");
            this.request.Method = "GET";
            this.request.Accept = "image/png,image/*;q=0.8,*/*;q=0.5";
            this.request.UserAgent = "Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0";
            this.request.ContentType = "text/html; charset=utf-8";
            this.request.KeepAlive = true;
            this.request.Timeout = 1000000000;
            this.request.CookieContainer = this.objContainer;
            stream = this.request.GetResponse().GetResponseStream();
        }
        catch (Exception ex)
        {
        }
        return stream;
    }

    public Stream getTINNSDLCaptcha()
    {
        Stream stream = (Stream)null;
        try
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
            this.request = (HttpWebRequest)WebRequest.Create("https://tin.tin.nsdl.com/oltas/servlet/CaptchaServicetansearch");
            this.request.Method = "GET";
            this.request.Accept = "image/png,image/*;q=0.8,*/*;q=0.5";
            this.request.UserAgent = "Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0";
            this.request.ContentType = "text/html; charset=utf-8";
            this.request.KeepAlive = true;
            this.request.Timeout = 1000000000;
            this.request.CookieContainer = this.objContainer;
            stream = this.request.GetResponse().GetResponseStream();
        }
        catch (Exception ex)
        {
        }
        return stream;
    }

    //public List<ChallanQuery> ChallanStatusQueryInBulk(
    //  List<ChallanQuery> objData,
    //  string strCaptchaCode)
    //{
    //    try
    //    {
    //        StringBuilder sbData1 = new StringBuilder();
    //        sbData1.Append("TAN_NO=" + objData[0].TAN.ToString());
    //        sbData1.Append("&TAN_FROM_DT_DD=" + objData[0].FromDate.Substring(0, 2));
    //        sbData1.Append("&TAN_FROM_DT_MM=" + objData[0].FromDate.Substring(3, 2));
    //        sbData1.Append("&TAN_FROM_DT_YY=" + objData[0].FromDate.Substring(6, 4));
    //        sbData1.Append("&TAN_TO_DT_DD=" + objData[objData.Count - 1].ToDate.Substring(0, 2));
    //        sbData1.Append("&TAN_TO_DT_MM=" + objData[objData.Count - 1].ToDate.Substring(3, 2));
    //        sbData1.Append("&TAN_TO_DT_YY=" + objData[objData.Count - 1].ToDate.Substring(6, 4));
    //        sbData1.Append("&HID_IMG_TXT=" + strCaptchaCode);
    //        sbData1.Append("&HIDDEN_TAN_FROM_DT_DD=01");
    //        sbData1.Append("&HIDDEN_TAN_FROM_DT_MM=04");
    //        sbData1.Append("&HIDDEN_TAN_TO_DT_DD=31");
    //        sbData1.Append("&HIDDEN_TAN_TO_DT_MM=03");
    //        sbData1.Append("&HIDDEN_TAN_TO_DT_YY=");
    //        sbData1.Append("&submit=View Challan details");
    //        sbData1.Append("&appUser=T");
    //        sbData1.Append("&appUser=T");
    //        string str1 = this.makeHTTPPostRequest("https://tin.tin.nsdl.com/oltas/servlet/TanSearch", sbData1);
    //        if (Regex.IsMatch(str1, "Error - Text does not match. Please enter new text.", RegexOptions.IgnoreCase))
    //            return new List<ChallanQuery>()
    //      {
    //        new ChallanQuery()
    //        {
    //          Message = enmChallanStatus.WRONG_CAPTCHA
    //        }
    //      };
    //        if (Regex.IsMatch(str1, "SITE UNDER MAINTENANCE", RegexOptions.IgnoreCase))
    //            return new List<ChallanQuery>()
    //      {
    //        new ChallanQuery()
    //        {
    //          Message = enmChallanStatus.SERVER_MAINTENANCE_ERROR
    //        }
    //      };
    //        if (Regex.IsMatch(str1, "Record Not Found", RegexOptions.IgnoreCase))
    //        {
    //            List<ChallanQuery> challanQueryList = new List<ChallanQuery>()
    //      {
    //        new ChallanQuery()
    //        {
    //          Message = enmChallanStatus.RECORD_NOT_FOUND
    //        }
    //      };
    //            return (List<ChallanQuery>)null;
    //        }
    //        Dictionary<string, string> dictionary = this.TraceallInputFields(str1, "//form[@name=\"TanSearch\"]");
    //        StringBuilder sbData2 = new StringBuilder();
    //        bool flag = false;
    //        if (dictionary.ContainsKey("NO_OF_ROWS"))
    //        {
    //            int int32 = Convert.ToInt32(dictionary["NO_OF_ROWS"]);
    //            for (int index = 1; index <= int32; ++index)
    //            {
    //                foreach (ChallanQuery challanQuery in objData)
    //                {
    //                    string str2 = challanQuery.ChallanDate.Substring(0, 2) + challanQuery.ChallanDate.Substring(3, 2) + challanQuery.ChallanDate.Substring(8, 2);
    //                    if (Convert.ToString(dictionary["RS_CHALLAN_DATE_" + (object)index]) == str2 && Convert.ToString(dictionary["RS_BSR_CD_" + (object)index]) == challanQuery.BSRCode && Convert.ToString(dictionary["RS_CHALLAN_SQ_NO_" + (object)index]) == challanQuery.ChallanNo)
    //                    {
    //                        flag = true;
    //                        dictionary["RS_AMT_" + (object)index] = challanQuery.ChallanAmount;
    //                        challanQuery.AmountID = "RS_AMT_" + (object)index;
    //                    }
    //                }
    //            }
    //        }
    //        if (!flag)
    //            return (List<ChallanQuery>)null;
    //        foreach (KeyValuePair<string, string> keyValuePair in dictionary)
    //            sbData2.Append(keyValuePair.Key + "=" + keyValuePair.Value + "&");
    //        sbData2.Append("submit=Confirm Amount");
    //        string html = this.makeHTTPPostRequest("https://tin.tin.nsdl.com/oltas/servlet/TanSearch", sbData2);
    //        foreach (ChallanQuery challanQuery in objData)
    //        {
    //            if (challanQuery.AmountID != "")
    //            {
    //                switch (this.getInnerText(html, "//tr[td/input[@name=\"" + challanQuery.AmountID + "\"]]/following-sibling::tr[position() <= 1]/td"))
    //                {
    //                    case enmChallanStatus.AMOUNT_MATCHED:
    //                        challanQuery.Message = enmChallanStatus.AMOUNT_MATCHED;
    //                        break;
    //                    case enmChallanStatus.AMOUNT_NOT_MATCHED:
    //                        challanQuery.Message = enmChallanStatus.AMOUNT_NOT_MATCHED;
    //                        break;
    //                    default:
    //                        challanQuery.Message = enmChallanStatus.RECORD_NOT_FOUND;
    //                        break;
    //                }
    //            }
    //        }
    //        return objData;
    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }
    //}

    //public List<ChallanQuery> BIN_ChallanStatusQueryInBulk(
    //  List<ChallanQuery> objData,
    //  string strFormType,
    //  string strAINNo,
    //  string strCaptchaCode)
    //{
    //    try
    //    {
    //        StringBuilder sbData1 = new StringBuilder();
    //        sbData1.Append("tan=" + objData[0].TAN.ToString());
    //        sbData1.Append("&formtype=" + strFormType);
    //        sbData1.Append("&ain=" + strAINNo);
    //        sbData1.Append("&fmonth=" + (object)Convert.ToInt32(objData[0].FromDate.Substring(3, 2)));
    //        sbData1.Append("&fyear=" + objData[0].FromDate.Substring(6, 4));
    //        sbData1.Append("&tmonth=" + (object)Convert.ToInt32(objData[objData.Count - 1].ToDate.Substring(3, 2)));
    //        sbData1.Append("&tyear=" + objData[objData.Count - 1].ToDate.Substring(6, 4));
    //        sbData1.Append("&captcha=" + strCaptchaCode);
    //        string str1 = this.makeHTTPPostRequest("https://onlineservices.tin.egov-nsdl.com/TIN/tBAFViewBookIdDTLSUnauth.do", sbData1);
    //        string str2 = "";
    //        if (Regex.IsMatch(str1, "Following errors occured while processing", RegexOptions.IgnoreCase))
    //        {
    //            HtmlDocument htmlDocument = new HtmlDocument();
    //            htmlDocument.LoadHtml(this.strServerResponse);
    //            HtmlNode htmlNode = htmlDocument.DocumentNode.SelectSingleNode("//center");
    //            if (htmlNode != null)
    //                str2 = htmlNode.InnerText;
    //            return new List<ChallanQuery>()
    //      {
    //        new ChallanQuery()
    //        {
    //          Message = enmChallanStatus.PROCESSING_FAILED,
    //          ErrorMessage = str2
    //        }
    //      };
    //        }
    //        if (Regex.IsMatch(str1, "Text does not match. Please enter new text.", RegexOptions.IgnoreCase))
    //            return new List<ChallanQuery>()
    //      {
    //        new ChallanQuery()
    //        {
    //          Message = enmChallanStatus.WRONG_CAPTCHA
    //        }
    //      };
    //        if (Regex.IsMatch(str1, "SITE UNDER MAINTENANCE", RegexOptions.IgnoreCase))
    //            return new List<ChallanQuery>()
    //      {
    //        new ChallanQuery()
    //        {
    //          Message = enmChallanStatus.SERVER_MAINTENANCE_ERROR
    //        }
    //      };
    //        if (Regex.IsMatch(str1, "Record Not Found", RegexOptions.IgnoreCase))
    //            return new List<ChallanQuery>()
    //      {
    //        new ChallanQuery()
    //        {
    //          Message = enmChallanStatus.RECORD_NOT_FOUND
    //        }
    //      };
    //        DataTable dTable = new DataTable();
    //        dTable.Columns.Add("ReceiptNumber");
    //        dTable.Columns.Add("DDOSerialNo");
    //        dTable.Columns.Add("Date");
    //        this.ProcessHtmlData(str1, ref dTable);
    //        Dictionary<string, string> dictionary = this.TraceViewStateData(str1, "//form[@name=\"tBAFBINAmtFormUnauth\"]");
    //        StringBuilder sbData2 = new StringBuilder();
    //        int num = 0;
    //        bool flag = false;
    //        if (dictionary.ContainsKey("noOfObj"))
    //        {
    //            foreach (DataRow row in (InternalDataCollectionBase)dTable.Rows)
    //            {
    //                foreach (ChallanQuery challanQuery in objData)
    //                {
    //                    string str3 = challanQuery.ChallanDate.Substring(0, 2) + "/" + challanQuery.ChallanDate.Substring(3, 2) + "/" + challanQuery.ChallanDate.Substring(6, 4);
    //                    if (Convert.ToString(row["Date"]).Trim() == str3 && Convert.ToInt32(row["ReceiptNumber"]) == Convert.ToInt32(challanQuery.BSRCode == "" ? "0" : challanQuery.BSRCode) && Convert.ToInt32(row["DDOSerialNo"]) == Convert.ToInt32(challanQuery.ChallanNo == "" ? "0" : challanQuery.ChallanNo))
    //                    {
    //                        flag = true;
    //                        dictionary.Add("amt" + (object)num, challanQuery.ChallanAmount);
    //                        dictionary.Add("chk" + (object)num, "on");
    //                        challanQuery.AmountID = "amt" + (object)num;
    //                    }
    //                }
    //                ++num;
    //            }
    //        }
    //        if (!flag)
    //            return (List<ChallanQuery>)null;
    //        foreach (KeyValuePair<string, string> keyValuePair in dictionary)
    //            sbData2.Append(keyValuePair.Key + "=" + keyValuePair.Value + "&");
    //        string html = this.makeHTTPPostRequest("https://onlineservices.tin.egov-nsdl.com/TIN/tBAFBINDTLSAmtVerifierUnauth.do", sbData2);
    //        foreach (ChallanQuery challanQuery in objData)
    //        {
    //            if (challanQuery.AmountID != "")
    //            {
    //                switch (this.getInnerText(html, "//tr[td/input[@name=\"" + challanQuery.AmountID + "\"]]/td[10]"))
    //                {
    //                    case enmChallanStatus.AMOUNT_MATCHED:
    //                        challanQuery.Message = enmChallanStatus.AMOUNT_MATCHED;
    //                        break;
    //                    case enmChallanStatus.AMOUNT_NOT_MATCHED:
    //                        challanQuery.Message = enmChallanStatus.AMOUNT_NOT_MATCHED;
    //                        break;
    //                    default:
    //                        challanQuery.Message = enmChallanStatus.RECORD_NOT_FOUND;
    //                        break;
    //                }
    //            }
    //        }
    //        return objData;
    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }
    //}

    private void ProcessHtmlData(string strHTML, ref DataTable dTable)
    {
        HtmlDocument htmlDocument = new HtmlDocument();
        htmlDocument.LoadHtml(strHTML);
        HtmlNodeCollection htmlNodeCollection1 = htmlDocument.DocumentNode.SelectNodes("//table");
        if (htmlNodeCollection1 == null)
            return;
        HtmlNodeCollection htmlNodeCollection2 = htmlNodeCollection1[0].SelectNodes(".//tr[@class='tabledetails']");
        for (int index = 0; index < htmlNodeCollection2.Count; ++index)
        {
            HtmlNodeCollection htmlNodeCollection3 = htmlNodeCollection2[index].SelectNodes(".//td");
            if (htmlNodeCollection3 != null)
            {
                DataRow row = dTable.NewRow();
                row["ReceiptNumber"] = (object)Convert.ToString(htmlNodeCollection3[3].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
                row["DDOSerialNo"] = (object)Convert.ToString(htmlNodeCollection3[4].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
                row["Date"] = (object)Convert.ToString(htmlNodeCollection3[5].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
                dTable.Rows.Add(row);
            }
        }
    }

    //public TDSResponse GetChallanDetails(
    //  ChallanQuery objData,
    //  string strCaptchaCode)
    //{
    //  TDSResponse TDSResponse = new TDSResponse();
    //  try
    //  {
    //    TDSResponse.Respons = eResponse.Success;
    //    StringBuilder sbData = new StringBuilder();
    //    sbData.Append("TAN_NO=" + objData.TAN.ToString());
    //    sbData.Append("&TAN_FROM_DT_DD=" + objData.FromDate.Substring(0, 2));
    //    sbData.Append("&TAN_FROM_DT_MM=" + objData.FromDate.Substring(3, 2));
    //    sbData.Append("&TAN_FROM_DT_YY=" + objData.FromDate.Substring(6, 4));
    //    sbData.Append("&TAN_TO_DT_DD=" + objData.ToDate.Substring(0, 2));
    //    sbData.Append("&TAN_TO_DT_MM=" + objData.ToDate.Substring(3, 2));
    //    sbData.Append("&TAN_TO_DT_YY=" + objData.ToDate.Substring(6, 4));
    //    sbData.Append("&HID_IMG_TXT=" + strCaptchaCode);
    //    sbData.Append("&HIDDEN_TAN_FROM_DT_DD=01");
    //    sbData.Append("&HIDDEN_TAN_FROM_DT_MM=04");
    //    sbData.Append("&HIDDEN_TAN_TO_DT_DD=31");
    //    sbData.Append("&HIDDEN_TAN_TO_DT_MM=03");
    //    sbData.Append("&HIDDEN_TAN_TO_DT_YY=");
    //    sbData.Append("&submit=View Challan details");
    //    sbData.Append("&appUser=T");
    //    sbData.Append("&appUser=T");
    //    string str = this.makeHTTPPostRequest("https://tin.tin.nsdl.com/oltas/servlet/TanSearch", sbData);
    //    if (Regex.IsMatch(str, "Error - Text does not match. Please enter new text.", RegexOptions.IgnoreCase))
    //    {
    //      TDSResponse.Respons = eResponse.Failed;
    //      TDSResponse.Message = "Invalid Captcha Code";
    //      return TDSResponse;
    //    }
    //    if (Regex.IsMatch(str, "SITE UNDER MAINTENANCE", RegexOptions.IgnoreCase))
    //    {
    //      TDSResponse.Respons = eResponse.Failed;
    //      TDSResponse.Message = "Server Error";
    //      return TDSResponse;
    //    }
    //    if (Regex.IsMatch(str, "Record Not Found", RegexOptions.IgnoreCase))
    //    {
    //      TDSResponse.Respons = eResponse.Failed;
    //      TDSResponse.Message = "Record Not Found";
    //      return TDSResponse;
    //    }
    //    DataTable dataTable = new DataTable();
    //    dataTable.Columns.Add("No");
    //    dataTable.Columns.Add("ChallanTenderDate");
    //    dataTable.Columns.Add("ChallanSerialNo");
    //    dataTable.Columns.Add("ReceivedData");
    //    dataTable.Columns.Add("MajorHeadcode");
    //    dataTable.Columns.Add("MinorHeadCode");
    //    dataTable.Columns.Add("NatureofPayment");
    //    HtmlDocument htmlDocument = new HtmlDocument();
    //    htmlDocument.LoadHtml(str);
    //    HtmlNodeCollection htmlNodeCollection1 = htmlDocument.DocumentNode.SelectNodes("//table[1]");
    //    if (htmlNodeCollection1 != null)
    //    {
    //      HtmlNodeCollection htmlNodeCollection2 = htmlNodeCollection1[0].SelectNodes(".//tr");
    //      for (int index = 1; index < htmlNodeCollection2.Count; ++index)
    //      {
    //        HtmlNodeCollection htmlNodeCollection3 = htmlNodeCollection2[index].SelectNodes(".//td");
    //        if (htmlNodeCollection3 != null && htmlNodeCollection3.Count > 5)
    //        {
    //          DataRow row = dataTable.NewRow();
    //          row["No"] = (object) Convert.ToString(htmlNodeCollection3[0].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
    //          row["ChallanTenderDate"] = (object) Convert.ToString(htmlNodeCollection3[1].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
    //          row["ChallanSerialNo"] = (object) Convert.ToString(htmlNodeCollection3[2].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
    //          row["ReceivedData"] = (object) Convert.ToString(htmlNodeCollection3[3].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
    //          row["MajorHeadcode"] = (object) Convert.ToString(htmlNodeCollection3[4].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
    //          row["MinorHeadCode"] = (object) Convert.ToString(htmlNodeCollection3[5].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
    //          row["NatureofPayment"] = (object) Convert.ToString(htmlNodeCollection3[6].InnerText).Replace("\t", "").Replace("\t", "").Replace("\n", "");
    //          dataTable.Rows.Add(row);
    //        }
    //      }
    //    }
    //    TDSResponse.CustomeTypes = (object) dataTable;
    //  }
    //  catch (Exception ex)
    //  {
    //    TDSResponse.Respons = eResponse.Failed;
    //    TDSResponse.Message = "Processing of challan request failed";
    //  }
    //  return TDSResponse;
    //}

    //private enmChallanStatus getInnerText(string html, string strQuery)
    //{
    //  enmChallanStatus enmChallanStatus = enmChallanStatus.RECORD_NOT_FOUND;
    //  HtmlDocument htmlDocument = new HtmlDocument();
    //  htmlDocument.LoadHtml(html);
    //  HtmlNodeCollection htmlNodeCollection = htmlDocument.DocumentNode.SelectNodes(strQuery);
    //  if (htmlNodeCollection == null)
    //    return enmChallanStatus.RECORD_NOT_FOUND;
    //  foreach (HtmlNode htmlNode in (IEnumerable<HtmlNode>) htmlNodeCollection)
    //  {
    //    if (htmlNode.InnerText.ToUpper().Trim() == "AMOUNT MATCHED")
    //      enmChallanStatus = enmChallanStatus.AMOUNT_MATCHED;
    //    else if (htmlNode.InnerText.ToUpper().Trim() == "MISMATCH IN AMOUNT")
    //      enmChallanStatus = enmChallanStatus.AMOUNT_NOT_MATCHED;
    //    else if (htmlNode.InnerText.ToUpper().Trim() == "AMOUNT NOT MATCHED")
    //      enmChallanStatus = enmChallanStatus.AMOUNT_NOT_MATCHED;
    //  }
    //  return enmChallanStatus;
    //}

    public Stream GetCaptchaForPANNAme1()
    {
        this.makeHTTPGetRequest("https://onlineservices.tin.egov-nsdl.com/etaxnew/tdsnontds.jsp");
        if (!this.IsStringExists(this.strServerResponse, "//form[@name=\"selectform\"]"))
            return (Stream)null;
        StringBuilder sbData = new StringBuilder();
        sbData.Append("browser_type=IE");
        sbData.Append("&from_tdsnontds=Y");
        sbData.Append("&R2=280");
        this.strServerResponse = this.makeHTTPPostRequest("https://onlineservices.tin.egov-nsdl.com/etaxnew/" + this.HTMLTagAttributeValue(this.strServerResponse, "//form[@name=\"selectform\"]", "action"), sbData);
        this.request = (HttpWebRequest)WebRequest.Create("https://onlineservices.tin.egov-nsdl.com/etaxnew/Captcha1Servlet");
        this.request.Method = "GET";
        this.request.Accept = "image/png,image/*;q=0.8,*/*;q=0.5";
        this.request.UserAgent = "Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0";
        this.request.ContentType = "text/html; charset=utf-8";
        this.request.KeepAlive = true;
        this.request.CookieContainer = this.objContainer;
        if (this.response.Cookies != null && this.response.Cookies.Count > 0)
            this.objContainer.Add(this.response.Cookies);
        foreach (Cookie cookie in this.response.Cookies)
            this.objContainer.Add(new Cookie(cookie.Name.Trim(), cookie.Value.Trim(), "/", cookie.Domain));
        for (int index = 0; index < this.objContainer.GetCookies(this.request.RequestUri).Count; ++index)
        {
            Cookie cookie = this.objContainer.GetCookies(this.request.RequestUri)[index];
        }
        return this.request.GetResponse().GetResponseStream();
    }

    public Stream GetCaptchaForPANNAme()
    {
        ConnectTR.SetAllowUnsafeHeaderParsing();
        ServicePointManager.ServerCertificateValidationCallback = (RemoteCertificateValidationCallback)((_param1, _param2, _param3, _param4) => true);
        this.request = (HttpWebRequest)WebRequest.Create("https://onlineservices.tin.egov-nsdl.com/etaxnew/tdsnontds.jsp");
        this.request.KeepAlive = true;
        this.request.Method = "GET";
        this.request.UserAgent = "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36";
        this.request.Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8";
        this.request.Timeout = 1000000000;
        if (this.request.CookieContainer == null)
            this.request.CookieContainer = this.objContainer;
        this.response = (HttpWebResponse)this.request.GetResponse();
        this.request.CookieContainer.Add(this.response.Cookies);
        this.dataStream = this.response.GetResponseStream();
        this.reader = new StreamReader(this.dataStream);
        this.strServerResponse = this.reader.ReadToEnd();
        this.reader.Close();
        this.dataStream.Close();
        this.response.Close();
        if (!this.IsStringExists(this.strServerResponse, "//form[@name=\"selectform\"]"))
            return (Stream)null;
        StringBuilder sbData = new StringBuilder();
        sbData.Append("browser_type=IE");
        sbData.Append("&from_tdsnontds=Y");
        sbData.Append("&R2=280");
        this.strServerResponse = this.makeHTTPPostRequest("https://onlineservices.tin.egov-nsdl.com/etaxnew/" + this.HTMLTagAttributeValue(this.strServerResponse, "//form[@name=\"selectform\"]", "action"), sbData);
        this.request = (HttpWebRequest)WebRequest.Create("https://onlineservices.tin.egov-nsdl.com/etaxnew/Captcha1Servlet");
        this.request.Method = "GET";
        this.request.Accept = "image/png,image/*;q=0.8,*/*;q=0.5";
        this.request.UserAgent = "Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0";
        this.request.ContentType = "text/html; charset=utf-8";
        this.request.KeepAlive = true;
        this.request.CookieContainer = this.objContainer;
        if (this.response.Cookies != null && this.response.Cookies.Count > 0)
            this.objContainer.Add(this.response.Cookies);
        foreach (Cookie cookie in this.response.Cookies)
            this.objContainer.Add(new Cookie(cookie.Name.Trim(), cookie.Value.Trim(), "/", cookie.Domain));
        for (int index = 0; index < this.objContainer.GetCookies(this.request.RequestUri).Count; ++index)
        {
            Cookie cookie = this.objContainer.GetCookies(this.request.RequestUri)[index];
        }
        return this.request.GetResponse().GetResponseStream();
    }

    public bool ExtractPANName(string PAN_No, string Captcha, out string strName)
    {
        strName = "";
        string str = "";
        bool flag;
        try
        {
            if (PAN_No.Trim().Length == 10)
                str = PAN_No.Substring(3, 1);
            StringBuilder stringBuilder = new StringBuilder();
            StringBuilder sbData = new StringBuilder();
            sbData.Append("AssessYear=2016-17");
            sbData.Append("&AssessYear_1=2016-17");
            sbData.Append("&Add_Line1=");
            sbData.Append("&Add_Line2=");
            sbData.Append("&Add_Line3=");
            sbData.Append("&Add_Line4=");
            sbData.Append("&Add_Line5=city");
            sbData.Append("&Add_State=KARNATAKA");
            sbData.Append("&Add_State_1=KARNATAKA");
            sbData.Append("&Add_PIN=111000");
            sbData.Append("&Add_EMAIL=");
            sbData.Append("&Add_MOBILE=");
            sbData.Append("&PAN=" + PAN_No);
            sbData.Append("&captchaText=" + Captcha);
            sbData.Append("&MinorHead_1=300");
            sbData.Append("&MinorHead=300");
            sbData.Append("&BankName_c=State Bank of India|https://merchant.onlinesbi.com/merchant/merchantprelogin.htm?merchant_code=OLTAS");
            sbData.Append("&Submit=Proceed");
            sbData.Append("&errorMsg=");
            sbData.Append("&actualAmt=");
            sbData.Append("&browser_type=IE");
            sbData.Append("&date=");
            sbData.Append("&flag=280");
            sbData.Append("&flag_var=null");
            sbData.Append("&inputarray=");
            sbData.Append("&inputrequest=Y");
            if (str.ToUpper() == "C")
            {
                sbData.Append("&MajorHead=0020");
                sbData.Append("&MajorHead_1=0020");
            }
            else
            {
                sbData.Append("&MajorHead=0021");
                sbData.Append("&MajorHead_1=0021");
            }
            sbData.Append("&PDF=online");
            sbData.Append("&Submit=Proceed");
            this.strServerResponse = this.makeHTTPPostRequest("https://onlineservices.tin.egov-nsdl.com/etaxnew/SubmitTdsn", sbData);
            if (Regex.IsMatch(this.strServerResponse, "Text does not match. Please enter new text", RegexOptions.IgnoreCase))
            {
                strName = "Invalid Captcha Code";
                return false;
            }
            if (Regex.IsMatch(this.strServerResponse, "ERROR -Invalid PAN", RegexOptions.IgnoreCase))
            {
                strName = "Invalid PAN Number";
                return false;
            }
            HtmlDocument htmlDocument = new HtmlDocument();
            htmlDocument.LoadHtml(this.strServerResponse);
            HtmlNode htmlNode = htmlDocument.DocumentNode.SelectSingleNode("//tr[td[1]='Full Name']/td[2]");
            if (htmlNode != null)
            {
                strName = htmlNode.InnerText;
                flag = !string.IsNullOrEmpty(strName);
            }
            else
                flag = false;
        }
        catch
        {
            strName = "Server Error::";
            flag = false;
        }
        return flag;
    }

    public TDSResponse RequestForCorrection(TracesData objData, string strStatus)
    {
        DataTable dataTable = new DataTable();
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        try
        {
            this.strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "ded/crrctnwelcome.xhtml");
            Dictionary<string, string> dictionary = this.TraceViewStateData(this.strServerResponse, "//form[@id=\"filecorrn\"]");
            if (dictionary.Count <= 0)
            {
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return TDSResponse;
            }
            StringBuilder sbData = new StringBuilder();
            sbData.Append("finYr=" + objData.FAYear);
            sbData.Append("&qrtr=" + objData.Quarter);
            sbData.Append("&frmType=" + objData.Forms);
            sbData.Append("&status=" + strStatus);
            sbData.Append("&clickfilecorrn=Submit Request");
            foreach (KeyValuePair<string, string> keyValuePair in dictionary)
                sbData.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "ded/crrctnwelcome.xhtml", sbData);
            TDSResponse = this.IsServerError(this.strServerResponse, "//ul[@id=\"err_Summary\"]");
            if (TDSResponse.Respons == eResponse.Failed)
            {
                TDSResponse.Respons = eResponse.Requested;
                return TDSResponse;
            }
            TDSResponse = this.IsServerError(this.strServerResponse, "//div[@id=\"content\"]");
            if (!TDSResponse.Message.Contains("Request Number is"))
            {
                TDSResponse.Respons = eResponse.Requested;
                return TDSResponse;
            }
            this.strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "ded/corrdownload.xhtml");
            if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"filedownload\"]"))
            {
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            TDSResponse = this.RequestFoCorrectionRequest();
        }
        catch (Exception ex)
        {
            TDSResponse.Respons = !Regex.IsMatch(ex.Message, "410") ? eResponse.Failed : eResponse.SessionTimeout;
            TDSResponse.Message = ex.Message;
        }
        return TDSResponse;
    }

    public TDSResponse GetCaptchaFromTraces()
    {
        TDSResponse TDSResponse = new TDSResponse();
        try
        {
            TDSResponse.Respons = eResponse.Success;
            TDSResponse.CustomeTypes = (object)this.getCaptchaCode();
            if (TDSResponse.CustomeTypes == null)
                TDSResponse.Respons = eResponse.Failed;
        }
        catch (WebException ex)
        {
            this.objContainer = (CookieContainer)null;
            TDSResponse.Respons = eResponse.Failed;
        }
        return TDSResponse;
    }

    public TDSResponse makeFakeLoginToTRACES()
    {
        TDSResponse TDSResponse = new TDSResponse();
        StringBuilder sbData = new StringBuilder();
        try
        {
            sbData.Append("search1=on");
            sbData.Append("&username=" + HttpUtility.UrlEncode("ctcstyp"));
            sbData.Append("&j_username=" + HttpUtility.UrlEncode("ctcstyp") + "^CALS00777B");
            sbData.Append("&selradio=D");
            sbData.Append("&j_password=" + HttpUtility.UrlEncode("testPwd"));
            sbData.Append("&j_tanPan=CALS00777B");
            sbData.Append("&j_captcha=244123");
            this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "j_security_check", sbData);
            if (string.IsNullOrEmpty(this.strServerResponse))
            {
                this.IsSessionExists = false;
                TDSResponse.Respons = eResponse.Failed;
                TDSResponse.Message = "Login Failed or Server Error";
                return TDSResponse;
            }
            TDSResponse = this.IsServerError(this.strServerResponse, "//form[@id=\"surveyForm\"]");
            if (TDSResponse.Respons == eResponse.Failed)
            {
                this.IsSessionExists = false;
                TDSResponse.Message = "Please log into your account by visiting www.tdscpc.gov.in and fill the survey form.";
                return TDSResponse;
            }
            TDSResponse = this.IsServerError(this.strServerResponse, "//span[@id=\"err_Summary\"]");
            if (TDSResponse.Respons == eResponse.Failed)
            {
                this.IsSessionExists = false;
                return TDSResponse;
            }
            if (!this.IsConditionMatch(this.strServerResponse, ""))
            {
                TDSResponse.Respons = eResponse.Failed;
                TDSResponse.Message = "Login Failed or Server Error";
                return TDSResponse;
            }
            this.IsSessionExists = true;
            TDSResponse.Respons = eResponse.Success;
            TDSResponse.Message = "";
            return TDSResponse;
        }
        catch (Exception ex)
        {
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = ex.Message;
            return TDSResponse;
        }
    }

    public TDSResponse RequestFoCorrectionRequest()
    {
        DataTable dataTable = new DataTable();
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        StringBuilder sbData = new StringBuilder();
        sbData.Append("_search=false");
        sbData.Append("&rows=2000");
        sbData.Append("&page=1");
        sbData.Append("&sidx=");
        sbData.Append("&sord=asc");
        this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "cor/srv/CorrDwnldServlet?reqtype=0", sbData);
        if (!string.IsNullOrEmpty(this.strServerResponse))
        {
            dataTable = new DataTable();
            dataTable.Columns.Add("Request Date");
            dataTable.Columns.Add("Request Number");
            dataTable.Columns.Add("Finnancial Year");
            dataTable.Columns.Add("Quarter");
            dataTable.Columns.Add("Form Type");
            dataTable.Columns.Add("Latest Token Number");
            dataTable.Columns.Add("Status");
            dataTable.Columns.Add("Correction Category");
            dataTable.Columns.Add("Remarks");
            dataTable.Columns.Add("New Token Number");
            dataTable.Columns.Add("Assigned To");
            dataTable.Columns.Add("Processed Date");
            dataTable.Columns.Add("Download");
            dataTable.Columns.Add("Upload");
            dataTable.Columns.Add("dwnldid");
            string str = "Test";
            DataRow row = (DataRow)null;
            using (JsonTextReader jsonTextReader = new JsonTextReader((TextReader)new StringReader(this.strServerResponse)))
            {
                while (jsonTextReader.Read())
                {
                    switch (jsonTextReader.TokenType)
                    {
                        case JsonToken.PropertyName:
                            str = jsonTextReader.Value.ToString();
                            break;
                        case JsonToken.Integer:
                        case JsonToken.Float:
                        case JsonToken.String:
                        case JsonToken.Null:
                            switch (str)
                            {
                                case "assign":
                                    row["Assigned To"] = (object)jsonTextReader.Value.ToString();
                                    break;
                                case "dwnldid":
                                    row["dwnldid"] = (object)jsonTextReader.Value.ToString();
                                    dataTable.Rows.Add(row);
                                    break;
                                case "dwnload":
                                    row["Download"] = (object)jsonTextReader.Value.ToString();
                                    break;
                                case "finYr":
                                    row["Finnancial Year"] = (object)jsonTextReader.Value.ToString();
                                    break;
                                case "frmType":
                                    row["Form Type"] = (object)jsonTextReader.Value.ToString();
                                    break;
                                case "ltokenno":
                                    row["Latest Token Number"] = (object)jsonTextReader.Value.ToString();
                                    break;
                                case "ntokenno":
                                    row["New Token Number"] = (object)jsonTextReader.Value.ToString();
                                    break;
                                case "prsdDate":
                                    row["Processed Date"] = (object)jsonTextReader.Value.ToString();
                                    break;
                                case "qrtr":
                                    row["Quarter"] = (object)jsonTextReader.Value.ToString();
                                    break;
                                case "recptNum":
                                    row["Remarks"] = (object)jsonTextReader.Value.ToString();
                                    break;
                                case "reqDate":
                                    row = dataTable.NewRow();
                                    row["Request Date"] = (object)jsonTextReader.Value.ToString();
                                    break;
                                case "reqNo":
                                    row["Request Number"] = (object)jsonTextReader.Value.ToString();
                                    break;
                                case "status":
                                    row["Status"] = (object)jsonTextReader.Value.ToString();
                                    break;
                                case "type":
                                    row["Correction Category"] = (object)jsonTextReader.Value.ToString();
                                    break;
                                case "upload":
                                    row["Upload"] = (object)jsonTextReader.Value.ToString();
                                    break;
                            }
                            break;
                    }
                }
            }
        }
        else
        {
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = "Server error";
        }
        TDSResponse.Respons = eResponse.Success;
        TDSResponse.CustomeTypes = (object)dataTable;
        return TDSResponse;
    }

    public TDSResponse RequestKYCFormRequest(
      TracesData objTraceData,
      string strReqID)
    {
        TDSResponse TDSResponse = new TDSResponse();
        DataTable dataTable = new DataTable();
        try
        {
            string request = this.makeHTTPGetRequest(this.strBaseURL + "ded/filecorrnkyc.xhtml?fy=" + objTraceData.FAYear + "&ft=" + objTraceData.Forms + "&qr=" + objTraceData.Quarter + "&reqId=" + strReqID);
            if (!this.IsStringExists(request, "//form[@id=\"kycformdsc\"]"))
            {
                string str = this.RetrieveElementValue(request, "//div[@class=\"padLeft5 margintop20\"]", "//span[@class=\"boldFont\"]", ConnectTR.enmElementType.InnerText);
                if (!string.IsNullOrEmpty(str))
                {
                    TDSResponse.Message = str;
                    TDSResponse.Respons = eResponse.Failed;
                    return TDSResponse;
                }
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            TDSResponse = this.IsServerError(request, "//span[@id=\"err_Summary\"]");
            if (TDSResponse.Respons == eResponse.Failed)
            {
                this.Logoff();
                TDSResponse.Respons = eResponse.Failed;
                return TDSResponse;
            }
            StringBuilder sbData1 = new StringBuilder();
            sbData1.Append("kycformdsc:_idcl=nxtSrcn");
            sbData1.Append("&search2=on");
            Dictionary<string, string> dictionary1 = this.TraceViewStateData(request, "//form[@id=\"kycformdsc\"]");
            if (dictionary1.Count <= 0)
            {
                this.Logoff();
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            foreach (KeyValuePair<string, string> keyValuePair in dictionary1)
                sbData1.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            string str1 = this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3formdsc.xhtml", sbData1);
            TDSResponse = this.IsServerError(str1, "//ul[@id=\"err_Summary\"]");
            if (TDSResponse.Respons == eResponse.Failed)
            {
                this.Logoff();
                TDSResponse.Respons = eResponse.Failed;
                return TDSResponse;
            }
            string str2 = "dedkyc";
            if (!this.IsStringExists(str1, "//form[@id=\"dedkyc\"]") && !this.IsStringExists(str1, "//form[@id=\"corrnType\"]"))
            {
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            StringBuilder sbData2 = new StringBuilder();
            sbData2.Append("&token=" + objTraceData.PRN_NO);
            if (!objTraceData.IsNoChallanCheck)
            {
                sbData2.Append("&bsr=" + objTraceData.BSRCode);
                sbData2.Append("&dtoftaxdep=" + objTraceData.TaxDepositedDate);
                sbData2.Append("&csn=" + objTraceData.ChallanSerialNo);
                sbData2.Append("&chlnamt=" + objTraceData.ChallanAmount);
                sbData2.Append("&cdrecnum=" + objTraceData.CDRecordNumber);
            }
            if (!objTraceData.panAmtValueCheck)
            {
                sbData2.Append("&pan1=" + objTraceData.PAN1);
                sbData2.Append("&amt1=" + objTraceData.PAN1Amount);
                sbData2.Append("&pan2=" + objTraceData.PAN2);
                sbData2.Append("&amt2=" + objTraceData.PAN2Amount);
                sbData2.Append("&pan3=" + objTraceData.PAN3);
                sbData2.Append("&amt3=" + objTraceData.PAN3Amount);
            }
            sbData2.Append("&clickKYC=Proceed");
            Dictionary<string, string> dictionary2 = this.TraceViewStateData(str1, "//form[@id=\"" + str2 + "\"]");
            foreach (KeyValuePair<string, string> keyValuePair in dictionary2)
                sbData2.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            if (dictionary2.Count <= 0)
            {
                this.Logoff();
                this.bnlSessionExists = false;
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            string str3 = this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3form.xhtml", sbData2);
            if (!this.IsStringExists(str3, "//form[@id=\"dedkyc\"]"))
            {
                this.bnlSessionExists = false;
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            TDSResponse = this.IsServerError(str3, "//div[@id=\"err_Summary\"]");
            if (TDSResponse.Respons == eResponse.Failed)
            {
                TDSResponse.Respons = eResponse.Failed;
                return TDSResponse;
            }
            string str4 = this.RetrieveElementValue(str3, "//form[@id=\"dedkyc\"]", "//input[@id=\"authcode\"]", ConnectTR.enmElementType.Value);
            Dictionary<string, string> dictionary3 = this.TraceViewStateData(str3, "//form[@id=\"dedkyc\"]");
            StringBuilder sbData3 = new StringBuilder();
            sbData3.Append("authcode=" + HttpUtility.UrlEncode(str4.Trim()));
            sbData3.Append("&redirect=" + HttpUtility.UrlEncode("Proceed with Transaction"));
            foreach (KeyValuePair<string, string> keyValuePair in dictionary3)
                sbData3.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            string str5 = this.makeHTTPPostRequest(this.strBaseURL + "ded/kyc3confirm.xhtml", sbData3);
            if (!this.IsStringExists(str5, "//form[@id=\"corrnType\"]"))
            {
                this.bnlSessionExists = false;
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            Dictionary<string, string> dictionary4 = this.TraceViewStateData(str5, "//form[@id=\"corrnType\"]");
            StringBuilder sbData4 = new StringBuilder();
            sbData4.Append("correctionType=9");
            sbData4.Append("&clickcorrnTyp=" + HttpUtility.UrlEncode("View Details"));
            foreach (KeyValuePair<string, string> keyValuePair in dictionary4)
                sbData4.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            string str6 = this.makeHTTPPostRequest(this.strBaseURL + "ded/filecorrectn.xhtml", sbData4);
            if (!this.IsStringExists(str6, "//form[@id=\"addchallan\"]"))
            {
                this.bnlSessionExists = false;
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            DataTable addedChallanList = this.getAddedChallanList();
            if (addedChallanList.Rows.Count > 0)
            {
                this.objParam.Clear();
                Dictionary<string, string> dictionary5 = this.TraceViewStateData(str6, "//form[@id=\"corrnActn\"]");
                this.objParam.Append("j_id834593793_7d61b6c5=Submit Correction Statement");
                foreach (KeyValuePair<string, string> keyValuePair in dictionary5)
                    this.objParam.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            }
            TDSResponse.CustomeTypes = (object)addedChallanList;
        }
        catch (Exception ex)
        {
            this.bnlSessionExists = false;
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = ex.Message;
        }
        return TDSResponse;
    }

    public TDSResponse RequestFAYearWiseChallanRequest(string strFAYear)
    {
        DataTable dataTable = new DataTable();
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        StringBuilder sbData = new StringBuilder();
        sbData.Append("_search=false");
        sbData.Append("&rows=2000");
        sbData.Append("&page=1");
        sbData.Append("&sidx=");
        sbData.Append("&sord=asc");
        this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "cor/srv/AddChallanServlet?reqtype=2&fyear=" + strFAYear, sbData);
        if (!string.IsNullOrEmpty(this.strServerResponse))
        {
            dataTable = new DataTable();
            dataTable.Columns.Add("bsr");
            dataTable.Columns.Add("dtofdep");
            dataTable.Columns.Add("chlnno");
            dataTable.Columns.Add("tdsinc");
            dataTable.Columns.Add("surchrge");
            dataTable.Columns.Add("educess");
            dataTable.Columns.Add("intrst");
            dataTable.Columns.Add("lvy");
            dataTable.Columns.Add("othrs");
            dataTable.Columns.Add("totamt");
            dataTable.Columns.Add("ddno");
            dataTable.Columns.Add("balance");
            dataTable.Columns.Add("seccode");
            dataTable.Columns.Add("id");
            dataTable.Columns.Add("bookadj");
            string str = "Test";
            DataRow row = (DataRow)null;
            using (JsonTextReader jsonTextReader = new JsonTextReader((TextReader)new StringReader(this.strServerResponse)))
            {
                while (jsonTextReader.Read())
                {
                    switch (jsonTextReader.TokenType)
                    {
                        case JsonToken.PropertyName:
                            str = jsonTextReader.Value.ToString();
                            break;
                        case JsonToken.Integer:
                        case JsonToken.Float:
                        case JsonToken.String:
                        case JsonToken.Null:
                            switch (str)
                            {
                                case "balance":
                                    if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                    {
                                        double num = Convert.ToDouble(jsonTextReader.Value.ToString());
                                        row["balance"] = (object)string.Format("{0:0.00}", (object)num);
                                        break;
                                    }
                                    row["balance"] = (object)"0.00";
                                    break;
                                case "bookadj":
                                    row["bookadj"] = (object)jsonTextReader.Value.ToString();
                                    dataTable.Rows.Add(row);
                                    break;
                                case "bsr":
                                    row = dataTable.NewRow();
                                    row["bsr"] = (object)jsonTextReader.Value.ToString();
                                    break;
                                case "chlnno":
                                    row["chlnno"] = (object)jsonTextReader.Value.ToString();
                                    break;
                                case "ddno":
                                    row["ddno"] = (object)jsonTextReader.Value.ToString();
                                    break;
                                case "dtofdep":
                                    row["dtofdep"] = (object)jsonTextReader.Value.ToString();
                                    break;
                                case "educess":
                                    if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                    {
                                        double num = Convert.ToDouble(jsonTextReader.Value.ToString());
                                        row["educess"] = (object)string.Format("{0:0.00}", (object)num);
                                        break;
                                    }
                                    row["educess"] = (object)"0.00";
                                    break;
                                case "id":
                                    row["id"] = (object)jsonTextReader.Value.ToString();
                                    break;
                                case "intrst":
                                    if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                    {
                                        double num = Convert.ToDouble(jsonTextReader.Value.ToString());
                                        row["intrst"] = (object)string.Format("{0:0.00}", (object)num);
                                        break;
                                    }
                                    row["intrst"] = (object)"0.00";
                                    break;
                                case "lvy":
                                    if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                    {
                                        double num = Convert.ToDouble(jsonTextReader.Value.ToString());
                                        row["lvy"] = (object)string.Format("{0:0.00}", (object)num);
                                        break;
                                    }
                                    row["lvy"] = (object)"0.00";
                                    break;
                                case "othrs":
                                    if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                    {
                                        double num = Convert.ToDouble(jsonTextReader.Value.ToString());
                                        row["othrs"] = (object)string.Format("{0:0.00}", (object)num);
                                        break;
                                    }
                                    row["othrs"] = (object)"0.00";
                                    break;
                                case "seccode":
                                    row["seccode"] = (object)jsonTextReader.Value.ToString();
                                    break;
                                case "surchrge":
                                    if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                    {
                                        double num = Convert.ToDouble(jsonTextReader.Value.ToString());
                                        row["surchrge"] = (object)string.Format("{0:0.00}", (object)num);
                                        break;
                                    }
                                    row["surchrge"] = (object)"0.00";
                                    break;
                                case "tdsinc":
                                    if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                    {
                                        double num = Convert.ToDouble(jsonTextReader.Value.ToString());
                                        row["tdsinc"] = (object)string.Format("{0:0.00}", (object)num);
                                        break;
                                    }
                                    row["tdsinc"] = (object)"0.00";
                                    break;
                                case "totamt":
                                    if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                    {
                                        double num = Convert.ToDouble(jsonTextReader.Value.ToString());
                                        row["totamt"] = (object)string.Format("{0:0.00}", (object)num);
                                        break;
                                    }
                                    row["totamt"] = (object)"0.00";
                                    break;
                            }
                            break;
                    }
                }
            }
            TDSResponse.CustomeTypes = (object)dataTable;
        }
        else
        {
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = "Server error";
        }
        TDSResponse.Respons = eResponse.Success;
        TDSResponse.CustomeTypes = (object)dataTable;
        return TDSResponse;
    }

    public TDSResponse GetAvailableBalance(string receiptId)
    {
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "cor/srv/AddChallanServlet?reqtype=14&receiptId=" + receiptId + "&bookadj=N", new StringBuilder());
        if (string.IsNullOrWhiteSpace(this.strServerResponse))
            TDSResponse.Respons = eResponse.Failed;
        int startIndex = this.strServerResponse.IndexOf(":") + 1;
        int length = this.strServerResponse.LastIndexOf("}") - startIndex;
        string str = this.strServerResponse.Substring(startIndex, length);
        TDSResponse.CustomeTypes = (object)str;
        return TDSResponse;
    }

    public TDSResponse AddChallanToList(string strParam)
    {
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        try
        {
            this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "cor/srv/AddChallanServlet?" + strParam, new StringBuilder());
            TDSResponse.CustomeTypes = (object)this.getAddedChallanList();
            this.strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "ded/addchallan.xhtml");
            this.objParam.Clear();
            Dictionary<string, string> dictionary = this.TraceViewStateData(this.strServerResponse, "//form[@id=\"corrnActn\"]");
            this.objParam.Append("j_id834593793_7d61b6c5=Submit Correction Statement");
            foreach (KeyValuePair<string, string> keyValuePair in dictionary)
                this.objParam.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
        }
        catch
        {
            TDSResponse.Respons = eResponse.Failed;
        }
        return TDSResponse;
    }

    public TDSResponse RemoveChallanFromList(string strParam)
    {
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        try
        {
            this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "cor/srv/AddChallanServlet?" + strParam, new StringBuilder());
            TDSResponse.CustomeTypes = (object)this.getAddedChallanList();
        }
        catch (Exception ex)
        {
            TDSResponse.Respons = eResponse.Failed;
            return TDSResponse;
        }
        return TDSResponse;
    }

    protected virtual void Dispose(bool disposing)
    {
        if (this.disposedValue)
            return;
        if (!disposing)
            ;
        this.objContainer = (CookieContainer)null;
        this.disposedValue = true;
    }

    public void Dispose()
    {
        this.Dispose(true);
        GC.SuppressFinalize((object)this);
    }

    private DataTable getAddedChallanList()
    {
        DataTable dataTable1 = new DataTable();
        StringBuilder sbData = new StringBuilder();
        sbData.Append("_search=false");
        sbData.Append("&rows=2000");
        sbData.Append("&page=1");
        sbData.Append("&sidx=");
        sbData.Append("&sord=asc");
        this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "cor/srv/AddChallanServlet?&defTyp=AC", sbData);
        if (string.IsNullOrEmpty(this.strServerResponse))
            return (DataTable)null;
        DataTable dataTable2 = new DataTable();
        dataTable2.Columns.Add("bsr");
        dataTable2.Columns.Add("dtofdep");
        dataTable2.Columns.Add("chlnno");
        dataTable2.Columns.Add("tdsinc");
        dataTable2.Columns.Add("surchrge");
        dataTable2.Columns.Add("educess");
        dataTable2.Columns.Add("intrst");
        dataTable2.Columns.Add("lvy");
        dataTable2.Columns.Add("othrs");
        dataTable2.Columns.Add("totamt");
        dataTable2.Columns.Add("ddno");
        dataTable2.Columns.Add("bookadj");
        dataTable2.Columns.Add("clttd");
        dataTable2.Columns.Add("clinterest");
        dataTable2.Columns.Add("clothers");
        dataTable2.Columns.Add("balance");
        dataTable2.Columns.Add("balanceavlbl");
        dataTable2.Columns.Add("match");
        dataTable2.Columns.Add("chlndetlId");
        dataTable2.Columns.Add("scchlndetlId");
        dataTable2.Columns.Add("id");
        dataTable2.Columns.Add("seccode");
        dataTable2.Columns.Add("intlsurchrge");
        dataTable2.Columns.Add("intleducess");
        dataTable2.Columns.Add("intlintrst");
        dataTable2.Columns.Add("intllvy");
        dataTable2.Columns.Add("intlothrs");
        dataTable2.Columns.Add("intlclinterest");
        dataTable2.Columns.Add("intlclothers");
        dataTable2.Columns.Add("intlclttd");
        string str = "Test";
        DataRow row = (DataRow)null;
        using (JsonTextReader jsonTextReader = new JsonTextReader((TextReader)new StringReader(this.strServerResponse)))
        {
            while (jsonTextReader.Read())
            {
                switch (jsonTextReader.TokenType)
                {
                    case JsonToken.PropertyName:
                        str = jsonTextReader.Value.ToString();
                        break;
                    case JsonToken.Integer:
                    case JsonToken.Float:
                    case JsonToken.String:
                    case JsonToken.Null:
                        switch (str)
                        {
                            case "balance":
                                if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                {
                                    double num = Convert.ToDouble(jsonTextReader.Value.ToString());
                                    row["balance"] = (object)string.Format("{0:0.00}", (object)num);
                                    break;
                                }
                                row["balance"] = (object)"0.00";
                                break;
                            case "balanceavlbl":
                                if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                {
                                    double num = Convert.ToDouble(jsonTextReader.Value.ToString());
                                    row["balanceavlbl"] = (object)string.Format("{0:0.00}", (object)num);
                                    break;
                                }
                                row["balanceavlbl"] = (object)"0.00";
                                break;
                            case "bookadj":
                                row["bookadj"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "bsr":
                                row = dataTable2.NewRow();
                                row["bsr"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "chlndetlId":
                                row["chlndetlId"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "chlnno":
                                row["chlnno"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "clinterest":
                                if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                {
                                    double num = Convert.ToDouble(jsonTextReader.Value.ToString());
                                    row["clinterest"] = (object)string.Format("{0:0.00}", (object)num);
                                    break;
                                }
                                row["clinterest"] = (object)"0.00";
                                break;
                            case "clothers":
                                if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                {
                                    double num = Convert.ToDouble(jsonTextReader.Value.ToString());
                                    row["clothers"] = (object)string.Format("{0:0.00}", (object)num);
                                    break;
                                }
                                row["clothers"] = (object)"0.00";
                                break;
                            case "clttd":
                                if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                {
                                    double num = Convert.ToDouble(jsonTextReader.Value.ToString());
                                    row["clttd"] = (object)string.Format("{0:0.00}", (object)num);
                                    break;
                                }
                                row["clttd"] = (object)"0.00";
                                break;
                            case "ddno":
                                row["ddno"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "dtofdep":
                                row["dtofdep"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "educess":
                                if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                {
                                    double num = Convert.ToDouble(jsonTextReader.Value.ToString());
                                    row["educess"] = (object)string.Format("{0:0.00}", (object)num);
                                    break;
                                }
                                row["educess"] = (object)"0.00";
                                break;
                            case "id":
                                row["id"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "intlclinterest":
                                row["intlclinterest"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "intlclothers":
                                row["intlclothers"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "intlclttd":
                                row["intlclttd"] = (object)Convert.ToString(jsonTextReader.Value);
                                break;
                            case "intleducess":
                                row["intleducess"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "intlintrst":
                                row["intlintrst"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "intllvy":
                                row["intllvy"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "intlothrs":
                                row["intlothrs"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "intlsurchrge":
                                row["intlsurchrge"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "intrst":
                                if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                {
                                    double num = Convert.ToDouble(jsonTextReader.Value.ToString());
                                    row["intrst"] = (object)string.Format("{0:0.00}", (object)num);
                                    break;
                                }
                                row["intrst"] = (object)"0.00";
                                break;
                            case "lvy":
                                if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                {
                                    double num = Convert.ToDouble(jsonTextReader.Value.ToString());
                                    row["lvy"] = (object)string.Format("{0:0.00}", (object)num);
                                    break;
                                }
                                row["lvy"] = (object)"0.00";
                                break;
                            case "match":
                                row["match"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "othrs":
                                if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                {
                                    double num = Convert.ToDouble(jsonTextReader.Value.ToString());
                                    row["othrs"] = (object)string.Format("{0:0.00}", (object)num);
                                    break;
                                }
                                row["othrs"] = (object)"0.00";
                                break;
                            case "scchlndetlId":
                                row["scchlndetlId"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "seccode":
                                row["seccode"] = (object)jsonTextReader.Value.ToString();
                                dataTable2.Rows.Add(row);
                                break;
                            case "surchrge":
                                if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                {
                                    double num = Convert.ToDouble(jsonTextReader.Value.ToString());
                                    row["surchrge"] = (object)string.Format("{0:0.00}", (object)num);
                                    break;
                                }
                                row["surchrge"] = (object)"0.00";
                                break;
                            case "tdsinc":
                                if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                {
                                    double num = Convert.ToDouble(jsonTextReader.Value.ToString());
                                    row["tdsinc"] = (object)string.Format("{0:0.00}", (object)num);
                                    break;
                                }
                                row["tdsinc"] = (object)"0.00";
                                break;
                            case "totamt":
                                if (!string.IsNullOrEmpty(jsonTextReader.Value.ToString()))
                                {
                                    double num = Convert.ToDouble(jsonTextReader.Value.ToString());
                                    row["totamt"] = (object)string.Format("{0:0.00}", (object)num);
                                    break;
                                }
                                row["totamt"] = (object)"0.00";
                                break;
                        }
                        break;
                }
            }
        }
        return dataTable2;
    }

    public TDSResponse RequestSubmitCorrection()
    {
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        StringBuilder stringBuilder = new StringBuilder();
        this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "ded/addchallan.xhtml", this.objParam);
        if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"submitLinks\"]"))
        {
            this.bnlSessionExists = false;
            TDSResponse.Message = "Server Error";
            TDSResponse.Respons = eResponse.SessionTimeout;
            return TDSResponse;
        }
        Dictionary<string, string> dictionary = this.TraceViewStateData(this.strServerResponse, "//form[@id=\"submitLinks\"]");
        StringBuilder sbData = new StringBuilder();
        sbData.Append("j_id823565703_1_5be56de4=" + HttpUtility.UrlEncode("Confirm"));
        foreach (KeyValuePair<string, string> keyValuePair in dictionary)
            sbData.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
        this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "ded/actionsummary.xhtml", sbData);
        if (!this.IsStringExists(this.strServerResponse, "//div[@id=\"content\"]"))
        {
            this.bnlSessionExists = false;
            TDSResponse.Message = "Server Error";
            TDSResponse.Respons = eResponse.SessionTimeout;
            return TDSResponse;
        }
        TDSResponse.Message = "Correction statement has been submitted and will be available in Corrections Ready For Submission Page";
        TDSResponse.Respons = eResponse.SessionTimeout;
        return TDSResponse;
    }

    public TDSResponse RequestFinalSubmission(ArrayList listData)
    {
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        string request = this.makeHTTPGetRequest(this.strBaseURL + "dea/correadysub.xhtml");
        if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"substmt\"]"))
        {
            this.bnlSessionExists = false;
            TDSResponse.Message = "Server Error";
            TDSResponse.Respons = eResponse.SessionTimeout;
            return TDSResponse;
        }
        StringBuilder sbData = new StringBuilder();
        sbData.Append("_search=false");
        sbData.Append("&rows=2000");
        sbData.Append("&page=1");
        sbData.Append("&sidx=");
        sbData.Append("&sord=asc");
        DataRow dataRow = this.getProcessData(this.makeHTTPPostRequest(this.strBaseURL + "cor/srv/CorxnServlt?reqtype=0&status=RDYSUB", sbData)).AsEnumerable().Where<DataRow>((Func<DataRow, bool>)(r => r.Field<string>("finyr").Contains(Convert.ToString(listData[1])) && r.Field<string>("quar").Contains(Convert.ToString(listData[2])) && r.Field<string>("frmtp").Contains(Convert.ToString(listData[3])))).FirstOrDefault<DataRow>();
        Dictionary<string, string> dictionary1 = this.TraceViewStateData(request, "//form[@id=\"substmt\"]");
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.Append("view=" + HttpUtility.UrlEncode("View Statement"));
        stringBuilder.Append("&corrid=" + HttpUtility.UrlEncode(Convert.ToString(dataRow["corrid"])));
        stringBuilder.Append("&stmtid=" + HttpUtility.UrlEncode(Convert.ToString(dataRow["stmtid"])));
        stringBuilder.Append("&year=" + HttpUtility.UrlEncode(Convert.ToString(dataRow["finyr"])));
        stringBuilder.Append("&formtype=" + HttpUtility.UrlEncode(Convert.ToString(dataRow["frmtp"])));
        stringBuilder.Append("&quarter=" + HttpUtility.UrlEncode(Convert.ToString(dataRow["quar"])));
        stringBuilder.Append("&dscChk=" + HttpUtility.UrlEncode(Convert.ToString(dataRow["dschk"])));
        stringBuilder.Append("&substmt_SUBMIT=1");
        foreach (KeyValuePair<string, string> keyValuePair in dictionary1)
        {
            if (keyValuePair.Key == "javax.faces.ViewState")
                stringBuilder.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
        }
        this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "dea/correadysub.xhtml", stringBuilder);
        if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"submitLinks\"]"))
        {
            this.bnlSessionExists = false;
            TDSResponse.Message = "Server Error";
            TDSResponse.Respons = eResponse.SessionTimeout;
            return TDSResponse;
        }
        Dictionary<string, string> dictionary2 = this.TraceViewStateData(this.strServerResponse, "//form[@id=\"submitLinks\"]");
        stringBuilder.Clear();
        string str1 = "";
        string str2 = "";
        string str3 = "";
        string str4 = "";
        string str5 = "";
        string str6 = "";
        string str7 = "";
        string str8 = "";
        string str9 = "";
        string str10 = "";
        string str11 = "";
        string str12 = "";
        string str13 = "";
        string str14 = "";
        string str15 = "";
        string str16 = "";
        string str17 = "";
        foreach (KeyValuePair<string, string> keyValuePair in dictionary2)
        {
            if (keyValuePair.Key == "signedData")
                str1 = keyValuePair.Value;
            if (keyValuePair.Key == "corr")
                str2 = keyValuePair.Value;
            if (keyValuePair.Key == "signData")
                str3 = keyValuePair.Value;
            if (keyValuePair.Key == "isDscRegd")
                str4 = keyValuePair.Value;
            if (keyValuePair.Key == "isDscExpired")
                str5 = keyValuePair.Value;
            if (keyValuePair.Key == "currUser")
                str6 = keyValuePair.Value;
            if (keyValuePair.Key == "dscChk")
                str7 = keyValuePair.Value;
            if (keyValuePair.Key == "tanRegPan")
                str8 = keyValuePair.Value;
            if (keyValuePair.Key == "pan")
                str9 = keyValuePair.Value;
            if (keyValuePair.Key == "adChFlag")
                str10 = keyValuePair.Value;
            if (keyValuePair.Key == "peChFlag")
                str11 = keyValuePair.Value;
            if (keyValuePair.Key == "piChFlag")
                str12 = keyValuePair.Value;
            if (keyValuePair.Key == "ccChFlag")
                str13 = keyValuePair.Value;
            if (keyValuePair.Key == "spSdChFlag")
                str14 = keyValuePair.Value;
            if (keyValuePair.Key == "salaryFlag")
                str15 = keyValuePair.Value;
            if (keyValuePair.Key == "ocpgchk")
                str17 = keyValuePair.Value;
            if (keyValuePair.Key != "dscPass")
                stringBuilder.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
        }
        string str18 = this.makeHTTPPostRequest(this.strBaseURL + "cor/srv/CorxnServlt?reqtype=4", new StringBuilder());
        if (str6.Trim().ToUpper() != "Y")
        {
            int startIndex = str18.IndexOf(":") + 1;
            int length = str18.LastIndexOf("}") - startIndex;
            string str19 = str18.Substring(startIndex, length);
            if (str19 == "1")
            {
                if (str7 == "Y")
                {
                    stringBuilder.Append("&dscPass=Y");
                    this.SubmitCorrection(stringBuilder);
                }
                else if (str8 == str9)
                {
                    if (str11 == "Y" || str12 == "Y" || str10 == "Y" && str16 == "N" || str14 == "Y" && str15 == "Y")
                    {
                        string str20 = "";
                        if (str4 == "1" && str5 == "0")
                        {
                            if (!(str1 == ""))
                                ;
                            string str21 = str1;
                            str20 = str3;
                            if (str21 != "")
                            {
                                stringBuilder.Append("&dscPass=");
                                this.SubmitCorrection(stringBuilder);
                            }
                        }
                        if (str4 == "1" && str5 == "1")
                        {
                            this.bnlSessionExists = false;
                            TDSResponse.Message = "You are yet to register your Digital Signature Certificate with TRACES. Click on 'Register DSC' to start. Click on Help menu to know more about DSC registration process";
                            TDSResponse.Respons = eResponse.Failed;
                            return TDSResponse;
                        }
                        if (str4 == "0")
                        {
                            this.bnlSessionExists = false;
                            TDSResponse.Message = "You have not registered your Digital Signature Certificate (DSC) with TRACES. Income Tax Department encourages the use of DSC for faster submission and processing of statements on TRACES.";
                            TDSResponse.Respons = eResponse.Failed;
                            return TDSResponse;
                        }
                    }
                    else
                    {
                        stringBuilder.Append("&dscPass=Y");
                        this.SubmitCorrection(stringBuilder);
                    }
                }
                else
                {
                    this.bnlSessionExists = false;
                    TDSResponse.Message = "PAN of Authorised / Responsible Person as per Personal Information of the correction and as per TRACES Profile should be same. Please update the PAN of Authorised / Responsible Person in the correction file.";
                    TDSResponse.Respons = eResponse.Failed;
                    return TDSResponse;
                }
            }
            else
            {
                if (str19 == "0")
                {
                    this.bnlSessionExists = false;
                    TDSResponse.Message = "Unable to submit due to invalid data";
                    TDSResponse.Respons = eResponse.Failed;
                    return TDSResponse;
                }
                if (str19 == "2")
                {
                    this.bnlSessionExists = false;
                    TDSResponse.Message = "Unable to submit due to invalid data";
                    TDSResponse.Respons = eResponse.Failed;
                    return TDSResponse;
                }
            }
            return TDSResponse;
        }
        this.bnlSessionExists = false;
        TDSResponse.Message = "Unable to process your request polease try from browser";
        TDSResponse.Respons = eResponse.Failed;
        return TDSResponse;
    }

    private DataTable getProcessData(string strjson)
    {
        DataTable dataTable1 = new DataTable();
        StringBuilder stringBuilder = new StringBuilder();
        if (string.IsNullOrEmpty(strjson))
            return (DataTable)null;
        DataTable dataTable2 = new DataTable();
        dataTable2.Columns.Add("stmtid");
        dataTable2.Columns.Add("finyr");
        dataTable2.Columns.Add("quar");
        dataTable2.Columns.Add("userid");
        dataTable2.Columns.Add("dschk");
        dataTable2.Columns.Add("corrid");
        dataTable2.Columns.Add("frmtp");
        string str = "Test";
        DataRow row = (DataRow)null;
        using (JsonTextReader jsonTextReader = new JsonTextReader((TextReader)new StringReader(this.strServerResponse)))
        {
            while (jsonTextReader.Read())
            {
                switch (jsonTextReader.TokenType)
                {
                    case JsonToken.PropertyName:
                        str = jsonTextReader.Value.ToString();
                        break;
                    case JsonToken.Integer:
                    case JsonToken.Float:
                    case JsonToken.String:
                    case JsonToken.Null:
                        switch (str)
                        {
                            case "corrid":
                                row["corrid"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "dschk":
                                row["dschk"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "finyr":
                                row["finyr"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "frmtp":
                                row["frmtp"] = (object)jsonTextReader.Value.ToString();
                                dataTable2.Rows.Add(row);
                                break;
                            case "quar":
                                row["quar"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "stmtid":
                                row = dataTable2.NewRow();
                                row["stmtid"] = (object)jsonTextReader.Value.ToString();
                                break;
                            case "userid":
                                row["userid"] = (object)jsonTextReader.Value.ToString();
                                break;
                        }
                        break;
                }
            }
        }
        return dataTable2;
    }

    private TDSResponse SubmitCorrection(StringBuilder strParam)
    {
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        this.strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "dea/signCorxnData.xhtml", strParam);
        if (this.IsStringExists(this.strServerResponse, "//h2[@class=\"normalFont w775\"]"))
        {
            string str = this.RetrieveElementValue(this.strServerResponse, "//div[@id='content']", "//h2", ConnectTR.enmElementType.InnerText);
            TDSResponse.Message = str;
        }
        else
        {
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = "Request has been terminated or Failed . Please check from browser";
        }
        return TDSResponse;
    }

    public TDSResponse RequestForFillingStatus(out DataTable table)
    {
        table = (DataTable)null;
        TDSResponse TDSResponse = new TDSResponse();
        TDSResponse.Respons = eResponse.Success;
        try
        {
            this.strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "ded/dclrtnaddnonfiling.xhtml");
            if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"nonFiling\"]"))
            {
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }
            StringBuilder sbData = new StringBuilder();
            sbData.Append("_search=false");
            sbData.Append("&rows=100");
            sbData.Append("&page=1");
            sbData.Append("&sidx=");
            sbData.Append("&sord=asc");
            string s = this.makeHTTPPostRequest(this.strBaseURL + "ded/srv/DclrtnNonFilingServlet?reqtype=0&pCount=100", sbData);
            if (!string.IsNullOrEmpty(s))
            {
                table = new DataTable();
                table.Columns.Add("Finnancial Year");
                table.Columns.Add("Quarter");
                table.Columns.Add("Form Type");
                table.Columns.Add("Status");
                table.Columns.Add("Reason");
                table.Columns.Add("Date");
                table.Columns.Add("commId");
                table.Columns.Add("hidfinYr");
                table.Columns.Add("hidquat");
                table.Columns.Add("declId");
                string str = "Test";
                DataRow row = (DataRow)null;
                using (JsonTextReader jsonTextReader = new JsonTextReader((TextReader)new StringReader(s)))
                {
                    while (jsonTextReader.Read())
                    {
                        switch (jsonTextReader.TokenType)
                        {
                            case JsonToken.PropertyName:
                                str = jsonTextReader.Value.ToString();
                                break;
                            case JsonToken.Integer:
                            case JsonToken.Float:
                            case JsonToken.String:
                            case JsonToken.Null:
                                switch (str)
                                {
                                    case "commId":
                                        row["commId"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "date":
                                        row["Date"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "declId":
                                        row["declId"] = (object)Convert.ToString(jsonTextReader.Value);
                                        table.Rows.Add(row);
                                        break;
                                    case "finYr":
                                        row["Finnancial Year"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "formType":
                                        row["Form Type"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "hidfinYr":
                                        row = table.NewRow();
                                        row["hidfinYr"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "hidquat":
                                        row["hidquat"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "quarter":
                                        row["Quarter"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "reason":
                                        row["Reason"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                    case "status":
                                        row["Status"] = (object)jsonTextReader.Value.ToString();
                                        break;
                                }
                                break;
                        }
                    }
                }
            }
            else
            {
                TDSResponse.Respons = eResponse.Success;
                TDSResponse.Message = "No Data";
            }
        }
        catch (Exception ex)
        {
            TDSResponse.Respons = !Regex.IsMatch(ex.Message, "410") ? eResponse.Failed : eResponse.SessionTimeout;
            TDSResponse.Message = ex.Message;
        }
        return TDSResponse;
    }



    public TDSResponse RequestForKnowYouTAN(
      string strTAN,
      string strName,
      string strDeductor,
      string strState,
      string strMobileNo)
    {
        TDSResponse TDSResponse = new TDSResponse();
        string request = this.makeHTTPGetRequest("https://www1.incometaxindiaefiling.gov.in/e-FilingGS/Services/KnowYourTanVerify.html");
        if (!this.IsStringExists(this.strServerResponse, "//form[@id=\"KnowYourTanVerify\"]"))
        {
            TDSResponse.Message = "Server Error";
            TDSResponse.Respons = eResponse.SessionTimeout;
        }
        Dictionary<string, string> dictionary1 = this.TraceViewStateData(request, "//form[@id=\"KnowYourTanVerify\"]");
        StringBuilder sbData = new StringBuilder();
        string str1 = !string.IsNullOrWhiteSpace(strTAN) ? "tan" : "name";
        sbData.Append("searchCriteria.searchOption=" + str1);
        sbData.Append("&searchCriteria.category=" + strDeductor);
        sbData.Append("&searchCriteria.state=" + strState);
        sbData.Append("&searchCriteria.name=" + strName);
        sbData.Append("&searchCriteria.tan=" + strTAN);
        sbData.Append("&mobileOfDeductee=" + strMobileNo);
        foreach (KeyValuePair<string, string> keyValuePair in dictionary1)
            sbData.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
        string str2 = this.makeHTTPPostRequest("https://www1.incometaxindiaefiling.gov.in/e-FilingGS/Services/KnowYourTanVerify.html", sbData);
        if (!this.IsStringExists(str2, "//form[@id=\"KnowYourTanVerifyOtp\"]"))
        {
            TDSResponse.Message = "Server Error";
            TDSResponse.Respons = eResponse.SessionTimeout;
        }
        else if (Regex.IsMatch(str2, "Please provide the OTP sent to your Mobile Number"))
        {
            Dictionary<string, string> dictionary2 = this.TraceViewStateData(str2, "//form[@id=\"KnowYourTanVerifyOtp\"]");
            TDSResponse.Message = "Please provide the OTP sent to your Mobile Number";
            TDSResponse.Respons = eResponse.Success;
            TDSResponse.CustomeTypes = (object)dictionary2;
        }
        return TDSResponse;
    }



    private enum enmElementType
    {
        InnerText,
        InnerHTML,
        Value,
        Name,
    }

    private string GetQuarter(string value)
    {
        string returnString = string.Empty;
        switch (value)
        {
            case "3":
                returnString = "Q1";
                break;
            case "4":
                returnString = "Q2";
                break;
            case "5":
                returnString = "Q3";
                break;
            case "6":
                returnString = "Q4";
                break;
        }
        return returnString;
    }

    private DataTable constructRequestDtlsTbl()
    {
        DataTable dtRequestDtls = new DataTable();
        dtRequestDtls.Columns.Add("Company_ID", typeof(int));
        dtRequestDtls.Columns.Add("RequestNo", typeof(string));
        dtRequestDtls.Columns.Add("FinancialYear", typeof(string));
        dtRequestDtls.Columns.Add("Quarter", typeof(string));
        dtRequestDtls.Columns.Add("Forms", typeof(string));
        dtRequestDtls.Columns.Add("FileProcessed", typeof(string));
        dtRequestDtls.Columns.Add("Status", typeof(string));
        dtRequestDtls.Columns.Add("Remarks", typeof(string));
        dtRequestDtls.Columns.Add("Authcode", typeof(string));

        return dtRequestDtls;

    }
    private void InsertRequestDetails(DataTable dtRequestDetails, LoginTraces objTracesLogin, TracesData objTracesData)
    {
        try
        {
            BAL_Traces objBAL_Traces = new BAL_Traces();
            objBAL_Traces._dtRequestDetails = dtRequestDetails;
            objBAL_Traces._Company_ID = Convert.ToInt16(HttpContext.Current.Session["CompanyId"]);
            objBAL_Traces._User_ID = objTracesLogin.UserID;
            objBAL_Traces._Password = objTracesLogin.Password;
            objBAL_Traces._Tan = objTracesLogin.TAN;
            objBAL_Traces._PRN = objTracesData.PRN_NO;
            objBAL_Traces._Quarter = GetQuarter(objTracesData.Quarter);
            objBAL_Traces._FormType = objTracesData.Forms;
            objBAL_Traces.Insert_Traces_Reques_Dtls();
        }
        catch (Exception ex)
        {
            //do nothing
        }
    }

    private List<string> getRequestNumber(string requestMsg)
    {
        List<string> lstRequestNumber = new List<String>();
        try
        {

            requestMsg = requestMsg.Replace("  ", " ").Replace(" .", ".");
            Regex exp = new Regex("Request Number is (.*)?\\.", RegexOptions.IgnoreCase);
            Regex exp_RequestNo = new Regex("\\d+", RegexOptions.IgnoreCase);
            Match match = exp.Match(requestMsg);
            if (match.Success)
            {
                MatchCollection matches = exp_RequestNo.Matches(match.Value);
                foreach (Match m in matches)
                {

                    lstRequestNumber.Add(m.Value);

                }
            }
            return lstRequestNumber;
        }
        catch (Exception ex)
        {

        }
        return lstRequestNumber;
    }
    private DataTable Insert_Request_Details(string requestString, string RequestFor, string authCode, TracesData objTraceData, DataTable dtRequestDetails)
    {
        try
        {
            int Company_ID = Convert.ToInt16(HttpContext.Current.Session["companyid"]);

            List<string> lstRequestNumber = getRequestNumber(requestString);
            string type = RequestFor;
            for (int i = 0; i < lstRequestNumber.Count; i++)
            {
                if (lstRequestNumber.Count == 2)
                {
                    if (i == 0)
                    {
                        type += " Part A";
                    }
                    else if (i == 1) type += " Part B";
                }
                if (lstRequestNumber[i] != "0")
                {
                    //Insert Traces Request Details
                    DataRow drRequestDetails = dtRequestDetails.NewRow();
                    drRequestDetails["Company_ID"] = Company_ID;
                    drRequestDetails["RequestNo"] = lstRequestNumber[i];
                    drRequestDetails["FinancialYear"] = objTraceData.FAYear;
                    drRequestDetails["Quarter"] = GetQuarter(objTraceData.Quarter);
                    drRequestDetails["Forms"] = objTraceData.Forms;
                    drRequestDetails["FileProcessed"] = type;
                    drRequestDetails["Status"] = "Submitted";
                    drRequestDetails["Remarks"] = "";
                    drRequestDetails["Authcode"] = authCode;
                    dtRequestDetails.Rows.Add(drRequestDetails);
                }
            }
        }
        catch (Exception ex)
        {

        }
        return dtRequestDetails;
    }

    private void insertLoginDetails(LoginTraces objLogin)
    {
        try
        {
            BAL_Traces objBAL_Traces = new BAL_Traces();
            objBAL_Traces._Company_ID = Convert.ToInt16(HttpContext.Current.Session["CompanyId"]);
            objBAL_Traces._User_ID = objLogin.UserID;
            objBAL_Traces._Password = objLogin.Password;
            objBAL_Traces._Tan = objLogin.TAN;
            objBAL_Traces.Insert_Traces_Login();
        }
        catch (Exception ex)
        {

        }
    }

    public string MakeInitialRequest_Challan()
    {
        this.makeHTTPGetRequest(strChallanBaseURL + "TanSearch");
        var stream = this.GetCaptchaCode_Challan();
        byte[] bytes;
        using (var memoryStream = new MemoryStream())
        {
            stream.CopyTo(memoryStream);
            bytes = memoryStream.ToArray();
        }
        StringBuilder DownloadCookie = new StringBuilder();

        string base64 = Convert.ToBase64String(bytes);
        for (int i = 0; i < this.response.Cookies.Count; i++)
        {
            DownloadCookie.Append(this.response.Cookies[i].Name + " = " + this.response.Cookies[i].Value + ";");
        }
        return JsonConvert.SerializeObject(new[] { new
{
    Cookie=DownloadCookie.ToString().Trim(';'),
         base64="data:image/png;base64,"+base64
}});




    }

    public Stream GetCaptchaCode_Challan()
    {
        try
        {
            this.bnlSessionExists = false;
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls;
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12 | SecurityProtocolType.Tls | SecurityProtocolType.Ssl3;
            this.request = (HttpWebRequest)WebRequest.Create(this.strChallanBaseURL + "CaptchaServicetansearch");
            this.request.Method = "GET";
            this.request.Accept = "image/png,image/*;q=0.8,*/*;q=0.5";
            this.request.UserAgent = "Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0";
            this.request.ContentType = "text/html; charset=utf-8";
            this.request.KeepAlive = true;
            this.request.CookieContainer = this.objContainer;
            if (this.response.Cookies != null && this.response.Cookies.Count > 0)
                this.objContainer.Add(this.response.Cookies);
            foreach (Cookie cookie in this.response.Cookies)
                this.objContainer.Add(new Cookie(cookie.Name.Trim(), cookie.Value.Trim(), "/", cookie.Domain));
            if (string.IsNullOrEmpty(this.response.Headers["Set-Cookie"]))

                for (int index = 0; index < this.objContainer.GetCookies(this.request.RequestUri).Count; ++index)
                {
                    Cookie cookie = this.objContainer.GetCookies(this.request.RequestUri)[index];
                }
            this.response = (HttpWebResponse)this.request.GetResponse();
        }
        catch (Exception ex)
        {

        }

        return this.response.GetResponseStream();
    }

    public TDSResponse ChallanDownload(Challan challan, out string filename, out string base64)
    {
        TDSResponse tracesResponse1 = new TDSResponse();
        filename = string.Empty; base64 = string.Empty;
        try
        {

            StringBuilder sbData = new StringBuilder();
            sbData.Append("TAN_NO=" + challan.TAN_NO);
            sbData.Append("&TAN_FROM_DT_DD=" + challan.TAN_FROM_DT_DD);
            sbData.Append("&TAN_FROM_DT_MM=" + challan.TAN_FROM_DT_MM);
            sbData.Append("&TAN_FROM_DT_YY=" + challan.TAN_FROM_DT_YY);
            sbData.Append("&TAN_TO_DT_DD=" + challan.TAN_TO_DT_DD);
            sbData.Append("&TAN_TO_DT_MM=" + challan.TAN_TO_DT_MM);
            sbData.Append("&TAN_TO_DT_YY=" + challan.TAN_TO_DT_YY);
            sbData.Append("&HID_IMG_TXT=" + challan.HID_IMG_TXT);
            sbData.Append("&HIDDEN_TAN_FROM_DT_DD=" + challan.TAN_FROM_DT_DD);
            sbData.Append("&HIDDEN_TAN_FROM_DT_MM=" + challan.TAN_FROM_DT_MM);
            sbData.Append("&HIDDEN_TAN_TO_DT_DD=" + challan.TAN_TO_DT_DD);
            sbData.Append("&HIDDEN_TAN_TO_DT_MM=" + challan.TAN_TO_DT_MM);

            sbData.Append("&HIDDEN_TAN_TO_DT_YY=");
            sbData.Append("&appUser=T");
            sbData.Append("&submit=Download+Challan+file");
            sbData.Append("&appUser=T");
            string[] split = challan.Cookie.Split(new string[] { ";" }, StringSplitOptions.RemoveEmptyEntries);
            for (int i = 0; i < split.Length; i++)
            {
                string[] splitValue = split[i].Split(new string[] { " = " }, StringSplitOptions.RemoveEmptyEntries);
                Cookie mycookie = new Cookie();
                mycookie.Domain = "tin.tin.nsdl.com";
                mycookie.Name = splitValue[0];


                mycookie.Value = splitValue[1];
                if (splitValue[0].IndexOf("tin.tin_cookie") >= -1)
                {
                    mycookie.Path = "/";
                    mycookie.Secure = false;
                    mycookie.HttpOnly = false;
                }
                else if (splitValue[0].IndexOf("TS01b5f5b9") >= -1)
                {
                    mycookie.Path = "/";
                    mycookie.Secure = false;
                    mycookie.HttpOnly = false;

                }
                else if (splitValue[0].IndexOf("TS01fceb0a") >= -1)
                {
                    mycookie.Path = "/";
                    mycookie.Secure = false;
                    mycookie.HttpOnly = false;

                }
                else if (splitValue[0].IndexOf("captch") >= -1)
                {
                    mycookie.Path = "/";
                    mycookie.Secure = false;
                    mycookie.HttpOnly = false;

                }

                else if (splitValue[0].IndexOf("JSESSIONID") >= -1)
                {
                    mycookie.Path = "/";
                    mycookie.Secure = false;
                    mycookie.HttpOnly = false;

                }
                this.objContainer.Add(mycookie);
            }


            this.makeHTTPPostRequest_challan(this.strChallanBaseURL + "TanSearch", sbData, challan.TAN_NO, out filename, out base64);


            tracesResponse1.Respons = eResponse.Success;


        }
        catch (Exception ex)
        {
            tracesResponse1.Respons = eResponse.Failed;
            tracesResponse1.Message = ex.Message;

        }
        return tracesResponse1;
    }
    //// Challan Functionality
    private string makeHTTPGetRequest_challan(string strURL)
    {
        try
        {
            ConnectTR.SetAllowUnsafeHeaderParsing();
            ServicePointManager.ServerCertificateValidationCallback = (RemoteCertificateValidationCallback)((_param1, _param2, _param3, _param4) => true);
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;
            this.request = (HttpWebRequest)WebRequest.Create(strURL);
            this.request.KeepAlive = true;
            this.request.Method = "GET";
            this.request.UserAgent = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.57 Safari/537.17";
            this.request.Accept = "text/html";
            this.request.Timeout = 1000000000;
            if (this.request.CookieContainer == null)
                this.request.CookieContainer = this.objContainer;
            this.response = (HttpWebResponse)this.request.GetResponse();

            this.request.CookieContainer.Add(this.response.Cookies);
            this.dataStream = this.response.GetResponseStream();
            this.reader = new StreamReader(this.dataStream);
            this.strServerResponse = this.reader.ReadToEnd();
            this.reader.Close();
            this.dataStream.Close();
            this.response.Close();


            if (this.response.Cookies != null && this.response.Cookies.Count > 0)
                this.objContainer.Add(this.response.Cookies);

        }
        catch (Exception ex)
        {
            throw;
        }
        return this.strServerResponse;
    }
    private void makeHTTPPostRequest_challan(string strURL, StringBuilder sbData, string tanNo, out string filename, out string base64)
    {
        try
        {
            filename = string.Empty; base64 = string.Empty;
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;
            this.request = (HttpWebRequest)WebRequest.Create(strURL);
            this.request.KeepAlive = true;
            byte[] buffer = (byte[])null;
            if (!string.IsNullOrEmpty(Convert.ToString((object)sbData)))
                buffer = Encoding.UTF8.GetBytes(sbData.ToString());
            if (!string.IsNullOrEmpty(Convert.ToString((object)sbData)))
                this.request.ContentLength = (long)buffer.Length;
            if (sbData != null)
            {
                this.request.Method = "POST";
                this.request.Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8";
                this.request.UserAgent = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.57 Safari/537.17";
                this.request.ContentType = "application/x-www-form-urlencoded";
                this.request.Timeout = 1000000000;
            }
            if (this.request.CookieContainer == null)
                this.request.CookieContainer = this.objContainer;
            if (this.response != null)
                this.request.CookieContainer.Add(this.response.Cookies);


            if (!string.IsNullOrEmpty(Convert.ToString((object)sbData)))
            {
                this.dataStream = this.request.GetRequestStream();
                this.dataStream.Write(buffer, 0, buffer.Length);
                this.dataStream.Close();
            }
            using (HttpWebResponse httpRes = (HttpWebResponse)this.request.GetResponse())
            {
                if (httpRes.StatusCode == HttpStatusCode.OK)
                {

                    using (dataStream = httpRes.GetResponseStream())
                    {

                        StreamReader reader = new StreamReader(dataStream);
                        this.response = httpRes;
                        this.dataStream = this.response.GetResponseStream();


                        string str = tanNo + "" + DateTime.Now.ToString("ddMMyy") + ".csi";

                        filename = str;
                        byte[] bytes;
                        using (var memoryStream = new MemoryStream())
                        {
                            dataStream.CopyTo(memoryStream);
                            bytes = memoryStream.ToArray();
                        }
                        base64 = Convert.ToBase64String(bytes);
                        this.dataStream.Close();


                        this.response.Close();

                    }
                }
            }


            //return this.strServerResponse;
        }
        catch (Exception ex)
        {
            throw;
        }
    }

    ////TDS TCS Credit
    //public TDSResponse RequestTDSTCSCredit(LoginTraces objLogin, TracesData objTraceData, string date,
    //    out DataTable dtStatementdtls, out string deducteeDtls)
    //{
    //    TDSResponse TDSResponse = new TDSResponse();
    //    dtStatementdtls = new DataTable(); deducteeDtls = string.Empty;

    //    try
    //    {
    //        if (!this.IsSessionExists)
    //        {
    //            TDSResponse = this.makeLoginToTRACES_SVC(objLogin);
    //            if (TDSResponse.Respons == eResponse.Failed)
    //                return TDSResponse;
    //        }
    //        string request = this.makeHTTPGetRequest(this.strBaseURL + "ded/tdstcscredit.xhtml");

    //        Dictionary<string, string> dictionary4 = this.TraceViewStateData(request, "//form[@id=\"viewTdsTcsCredit\"]");
    //        StringBuilder sbData4 = new StringBuilder();

    //        string viewState = string.Empty;
    //        foreach (KeyValuePair<string, string> keyValuePair in dictionary4)
    //        {
    //            if (keyValuePair.Key == "javax.faces.ViewState")
    //            {
    //                viewState = HttpUtility.UrlEncode(keyValuePair.Value);
    //                break;
    //            }
    //        }

    //        if (this.IsStringExists(request, "//form[@id=\"viewTdsTcsCredit\"]"))
    //            ;

    //        string currQtr = GetQuarter(objTraceData.Quarter).Replace("Q", "");
    //        string quarter = objTraceData.Quarter;

    //        string financialYear = objTraceData.FAYear.Substring(0, objTraceData.FAYear.IndexOf("-"));
    //        string currYear = objTraceData.FAYear.Substring(objTraceData.FAYear.IndexOf("-") + 1, objTraceData.FAYear.Length - objTraceData.FAYear.IndexOf("-") - 1);
    //        currYear = objTraceData.FAYear.Substring(0, 2) + currYear;
    //        CookieContainer objContainer_old = this.objContainer;

    //        StringBuilder sbData = new StringBuilder();
    //        sbData.Append("tan=" + objTraceData.TAN);
    //        sbData.Append("&pan=" + objTraceData.PAN1);
    //        sbData.Append("&financialYear=" + financialYear);
    //        sbData.Append("&currYear=" + currYear);
    //        sbData.Append("&quarter=" + quarter);
    //        sbData.Append("&currQtr=" + currQtr);
    //        sbData.Append("&formType=" + objTraceData.Forms);
    //        sbData.Append("&clickGo=Go");
    //        sbData.Append("&viewTdsTcsCredit_SUBMIT=1");
    //        sbData.Append("&javax.faces.ViewState=" + viewState);

    //        string statementDtls = this.makeHTTPPostRequest_SVC(this.strBaseURL + "ded/tdstcscredit.xhtml", sbData);




    //        // this.objContainer = newCookie;

    //        Dictionary<string, string> dictionary = this.TraceHiddenField(statementDtls, "//form[@id=\"dispMsg\"]");

    //        string stmtMstrId = string.Empty;
    //        foreach (KeyValuePair<string, string> keyValuePair in dictionary)
    //        {
    //            if (keyValuePair.Key == "stmtMstrId")
    //            {
    //                stmtMstrId = HttpUtility.UrlEncode(keyValuePair.Value);
    //                break;
    //            }
    //        }

    //        // this.objContainer = newCookie;
    //        sbData = new StringBuilder();
    //        sbData.Append("pan=" + objTraceData.PAN1);
    //        sbData.Append("&stmtMstrId=" + stmtMstrId);
    //        sbData.Append("&finYear=" + financialYear);
    //        sbData.Append("&quarter=" + quarter);
    //        sbData.Append("&formType=" + objTraceData.Forms);

    //        sbData.Append("&_search=false");
    //        sbData.Append("&nd=" + date);

    //        sbData.Append("&rows=10");
    //        sbData.Append("&sidx=");
    //        sbData.Append("&sord=asc");

    //        //_search = false & nd = 1621235693740 & rows = 10 & page = 1 & sidx = &sord = asc
    //         deducteeDtls = this.makeHTTPPostRequest_SVC(this.strBaseURL + "ded/srv/DedTdsTcsSevlet", sbData);

            

    //        dtStatementdtls = TraceStatementDetails(statementDtls, "//div[@id=\"stmtdetail\"]");
    //        TDSResponse.Respons = eResponse.Success;
    //        TDSResponse.CustomeTypes = (object)dtStatementdtls;
    //    }
    //    catch (Exception ex)
    //    {
    //        this.Logoff();
    //        this.bnlSessionExists = false;
    //        TDSResponse.Respons = eResponse.Failed;
    //        TDSResponse.Message = ex.Message;
    //    }
    //    return TDSResponse;
    //}

    private DataTable TraceStatementDetails(string strHTML, string xPathQuery)
    {
        DataTable dt = new DataTable();
        try {

            HtmlDocument htmlDocument = new HtmlDocument();
            htmlDocument.LoadHtml(strHTML);
            HtmlNodeCollection htmlNodeCollection1 = htmlDocument.DocumentNode.SelectNodes(xPathQuery);

            string text = string.Empty;

         
            dt.Columns.Add("Field", typeof(string));
            dt.Columns.Add("Value", typeof(string));

            int knt = 0;
            DataRow dr = dt.NewRow();
            if (htmlNodeCollection1 != null && htmlNodeCollection1.Count > 0)
            {
                foreach (HtmlNode htmlNode in (IEnumerable<HtmlNode>)htmlNodeCollection1)
                {
                    string list = htmlNode.InnerHtml;

                    Regex pattern = new Regex("<li[^>]*>(.+?)</li\\s*>");
                    MatchCollection matches = pattern.Matches(list);


                    for (int index = 0; index < matches.Count; ++index)
                    {
                        if (knt % 2 == 0)
                        {
                            dr = dt.NewRow();
                        }
                        text = matches[index].Groups[1].Value ;
                        text= Regex.Replace(text, "<.*?>", String.Empty);

                        if (knt % 2 == 0)
                        {
                            dr["Field"] = text;
                            knt++;

                        }
                        else if (knt % 2 == 1)
                        {
                            dr["Value"] = text;
                            dt.Rows.Add(dr);
                            knt++;
                        }


                        //if (!dictionary.ContainsKey(htmlNodeCollection2[index].Attributes["name"].Value))
                        //  dictionary.Add(htmlNodeCollection2[index].Attributes["name"].Value, htmlNodeCollection2[index].Attributes["value"].Value);



                    }
                }
            }
            return dt;

        }
        catch (Exception ex)
        {
            throw;
        }
        return dt;
    }

    public TDSResponse RequestFor197CertificateVerification(LoginTraces objLogin, TracesData objTraceData)
    {
        TDSResponse tracesResponse = new TDSResponse();
        DataTable dataTable = new DataTable();
        try
        {
            if (!this.IsSessionExists)
            {
                tracesResponse = this.makeLoginToTRACES_SVC(objLogin);
                if (tracesResponse.Respons == eResponse.Failed)
                    return tracesResponse;
            }
            string request = this.makeHTTPGetRequest(this.strBaseURL + "ded/197certiverfication.xhtml");

            if (!this.IsStringExists(request, "//form[@id=\"certiValidation\"]"))
            {
                tracesResponse.Message = "Server Error";
                tracesResponse.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return tracesResponse;
            }

            StringBuilder sbData = new StringBuilder();
            sbData.Append("_search=false");
            sbData.Append("&nd=1396609417964");
            sbData.Append("&rows=100");
            sbData.Append("&page=1");
            sbData.Append("&sidx=");
            sbData.Append("&sord=asc");
            //string sbData = "_search=false&nd=1396609417964&rows=100&page=1&sidx=&sord=asc";
            string s = this.makeHTTPPostRequest_SVC(this.strBaseURL + "ded/srv/CertiVerifyServlet?deducteePan=" + objTraceData.PAN1 + "&financialYear=" + objTraceData.FAYear + "&reqType=1", sbData);

            string strRowCount = "0";
            if (!string.IsNullOrEmpty(s))
                dataTable = this.JsonParserForCertificateValidation(s, out strRowCount);

            tracesResponse.CustomeTypes = (object)new ArrayList()
        {
          (object) strRowCount,
          (object) dataTable
        };
            tracesResponse.Respons = eResponse.Success;

            this.Logoff();
        }
        catch (Exception ex)
        {
            tracesResponse.Respons = eResponse.Failed;
            tracesResponse.Message = ex.Message;
            this.Logoff();
        }
        return tracesResponse;
    }


    public TDSResponse RequestForPANVerify(LoginTraces objLogin,TracesData objTraceData)
    {
        TDSResponse TDSResponse = new TDSResponse();
        DataTable dataTable = new DataTable();
        string str = "";
        try
        {
            if (!this.IsSessionExists)
            {
                TDSResponse = this.makeLoginToTRACES_SVC(objLogin);
                if (TDSResponse.Respons == eResponse.Failed)
                    return TDSResponse;
            }
            string request = this.makeHTTPGetRequest(this.strBaseURL + "ded/panverify.xhtml");

            if (!this.IsStringExists(request, "//form[@id=\"pandetailsForm1\"]"))
            {
                TDSResponse.Message = "Server Error";
                TDSResponse.Respons = eResponse.SessionTimeout;
                this.Logoff();
                return TDSResponse;
            }

            StringBuilder sbData = new StringBuilder();
            sbData.Append("pannumber=" + objTraceData.PAN1.Trim());
            sbData.Append("&frmType1=24Q");
            sbData.Append("&clickGo1=Go");
            sbData.Append("&pandetailsForm1_SUBMIT=1");

            Dictionary<string, string> dictionary = this.TraceViewStateData(request, "//form[@id=\"pandetailsForm1\"]");

            foreach (KeyValuePair<string, string> keyValuePair in dictionary)
            {
                if ("javax.faces.ViewState" == keyValuePair.Key)
                    sbData.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            }

            str = this.makeHTTPPostRequest(this.strBaseURL + "ded/panverify.xhtml", sbData);

            if (TDSResponse.Respons == eResponse.Failed)
                return TDSResponse;

            PANDetails panDetails = new PANDetails();
            panDetails.PAN = objTraceData.PAN1;
            //div[@id='top']
            panDetails.Status = Regex.Match(str, "<td[^>]*id=\"status\">(.*?)</td").Groups[1].Value;
            panDetails.Name = Regex.Match(str, "<td[^>]*id=\"name\">(.*?)</td").Groups[1].Value;


            //foreach (KeyValuePair<string, string> keyValuePair in dictionary)
            //{
            //    if (keyValuePair.Key.ToString().ToUpper() == "STATUS")
            //        panDetails.Status = keyValuePair.Value;
            //    if (keyValuePair.Key.ToString().ToUpper() == "NAME")
            //        panDetails.Name = keyValuePair.Value;
            //}
            TDSResponse.CustomeTypes = (object)panDetails;
            TDSResponse.Respons = eResponse.Success;
            string sts = panDetails.Status;
            BAL_BulkPan_Verification_AllVoucher obj = new BAL_BulkPan_Verification_AllVoucher();
            DataSet Pds = obj.BAL_BulkSalaryPANVerification(sts);
            this.Logoff();
        }
        catch (Exception ex)
        {
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = ex.Message;
            this.Logoff();
        }
        return TDSResponse;
    }



    public TDSResponse RequestForBulKPANVerify_Salary(TracesData objTraceData, string PAN)
    {
        TDSResponse TDSResponse = new TDSResponse();
        DataTable dataTable = new DataTable();
        string str = "";
        HtmlDocument doc = new HtmlDocument();
        

        try
        {
       // repate:
            string request = this.makeHTTPGetRequest(this.strBaseURL + "ded/panverify.xhtml");
            if (!this.IsStringExists(request, "//form[@id=\"pandetailsForm1\"]"))
            {
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }


            PANDetails panDetails = new PANDetails();
            objTraceData.PAN1 = PAN;
            StringBuilder sbData = new StringBuilder();
            sbData.Append("pannumber=" + objTraceData.PAN1.Trim());
            sbData.Append("&frmType1=24Q");
            sbData.Append("&clickGo1=Go");
            sbData.Append("&pandetailsForm1_SUBMIT=1");
            Dictionary<string, string> dictionary = this.TraceViewStateData(request, "//form[@id=\"pandetailsForm1\"]");
            foreach (KeyValuePair<string, string> keyValuePair in dictionary)
            {
                if ("javax.faces.ViewState" == keyValuePair.Key)
                    sbData.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            }
            str = this.makeHTTPPostRequest(this.strBaseURL + "ded/panverify.xhtml", sbData);
            if (TDSResponse.Respons == eResponse.Failed)
            {
                BAL_BulkPan_Verification_AllVoucher obj = new BAL_BulkPan_Verification_AllVoucher();
                PAN = panDetails.PAN + "^Not Verified^";
                obj.Company_ID = objTraceData.Compid;
                DataSet Pds = obj.BAL_BulkSalaryPANVerification(PAN);
                return TDSResponse;
            }

            panDetails.PAN = objTraceData.PAN1.Trim();
            foreach (KeyValuePair<string, string> keyValuePair in dictionary)
            {
                if (keyValuePair.Key.ToString().ToUpper() == "STATUS")
                    panDetails.Status = keyValuePair.Value;
                if (keyValuePair.Key.ToString().ToUpper() == "NAME")
                    panDetails.Name = keyValuePair.Value;
            }
            panDetails.Status = Regex.Match(str, "<td[^>]*id=\"status\">(.*?)</td").Groups[1].Value;
            panDetails.Name = Regex.Match(str, "<td[^>]*id=\"name\">(.*?)</td").Groups[1].Value;

            TDSResponse.CustomeTypes = (object)panDetails;
            TDSResponse.Respons = eResponse.Success;
            if (panDetails.Status != "")
            {
                PAN = panDetails.PAN + '^' + panDetails.Status + '^';
                BAL_BulkPan_Verification_AllVoucher obj = new BAL_BulkPan_Verification_AllVoucher();
                obj.Company_ID = objTraceData.Compid;
                DataSet Pds = obj.BAL_BulkSalaryPANVerification(PAN);
            }
            else
            {

                doc.LoadHtml(str);

                // Find all div tags with a specific ID (e.g., 'myDiv')

                HtmlNodeCollection dNodes = doc.DocumentNode.SelectNodes("//td");

                if (dNodes != null)
                {
                    foreach (var dNode in dNodes)
                    {
                        if (dNode.ChildNodes.Count == 3)
                        {
                            var cNode = dNode.ChildNodes[1].Name;
                            var cSts = dNode.InnerText;
                            var cId = dNode.ChildNodes[2].Id;
                            if (cNode == "span" && cId == "status")
                            {
                                panDetails.Status = cSts;
                                PAN = panDetails.PAN + '^' + panDetails.Status + '^';
                                BAL_BulkPan_Verification_AllVoucher obj = new BAL_BulkPan_Verification_AllVoucher();
                                obj.Company_ID = objTraceData.Compid;
                                DataSet ds = obj.BAL_BulkSalaryPANVerification(PAN);
                                goto cmplt;
                            }

                        }

                    }
                }



               // goto repate;
            }
        cmplt:
            PAN = "";


        }
        catch (Exception ex)
        {
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = ex.Message;
            this.Logoff();
        }
        return TDSResponse;
    }

  
    public TDSResponse RequestForTraces_Login(LoginTraces objLogin  )
    {
        TDSResponse TDSResponse = new TDSResponse();

        try
        {


            if (!this.IsSessionExists)
            {
                TDSResponse = this.makeLoginToTRACES_SVC(objLogin);
                if (TDSResponse.Respons == eResponse.Failed)
                    return TDSResponse;
            }

        }
        catch (Exception ex)
        {
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = ex.Message;
            this.Logoff();
        }
        return TDSResponse;
    }



    public TDSResponse RequestForBulKPANStatus_NonSal( TracesData objTraceData, string PAN)
    {
        TDSResponse TDSResponse = new TDSResponse();
        DataTable dataTable = new DataTable();
        string str = "";
        HtmlDocument doc = new HtmlDocument();
        
        try
        {


 //       repate:
            string request = this.makeHTTPGetRequest(this.strBaseURL + "ded/panverify.xhtml");
            if (!this.IsStringExists(request, "//form[@id=\"pandetailsForm1\"]"))
            {
                TDSResponse.Respons = eResponse.SessionTimeout;
                return TDSResponse;
            }



            objTraceData.PAN1 = PAN;
            StringBuilder sbData = new StringBuilder();
            sbData.Append("pannumber=" + objTraceData.PAN1.Trim());
            sbData.Append("&frmType1=24Q");
            sbData.Append("&clickGo1=Go");
            sbData.Append("&pandetailsForm1_SUBMIT=1");
            Dictionary<string, string> dictionary = this.TraceViewStateData(request, "//form[@id=\"pandetailsForm1\"]");
            foreach (KeyValuePair<string, string> keyValuePair in dictionary)
            {
                if ("javax.faces.ViewState" == keyValuePair.Key)
                    sbData.Append("&" + keyValuePair.Key + "=" + HttpUtility.UrlEncode(keyValuePair.Value));
            }
            str = this.makeHTTPPostRequest(this.strBaseURL + "ded/panverify.xhtml", sbData);
            if (TDSResponse.Respons == eResponse.Failed)
                return TDSResponse;
            PANDetails panDetails = new PANDetails();
            panDetails.PAN = objTraceData.PAN1.Trim();
            foreach (KeyValuePair<string, string> keyValuePair in dictionary)
            {
                if (keyValuePair.Key.ToString().ToUpper() == "STATUS")
                    panDetails.Status = keyValuePair.Value;
                if (keyValuePair.Key.ToString().ToUpper() == "NAME")
                    panDetails.Name = keyValuePair.Value;
            }
            panDetails.Status = Regex.Match(str, "<td[^>]*id=\"status\">(.*?)</td").Groups[1].Value;
            panDetails.Name = Regex.Match(str, "<td[^>]*id=\"name\">(.*?)</td").Groups[1].Value;

            TDSResponse.CustomeTypes = (object)panDetails;
            TDSResponse.Respons = eResponse.Success;
            if (panDetails.Status != "")
            {
                PAN = panDetails.PAN + '^' + panDetails.Status + '^';
                BAL_BulkPan_Verification_AllVoucher obj = new BAL_BulkPan_Verification_AllVoucher();
                obj.Company_ID = objTraceData.Compid;
                DataSet Pds = obj.BAL_BulkNonSalaryPANVerification(PAN);
            }
            else
            {
               
                doc.LoadHtml(str);

                // Find all div tags with a specific ID (e.g., 'myDiv')

                HtmlNodeCollection dNodes = doc.DocumentNode.SelectNodes("//td");

                if (dNodes != null)
                {
                    foreach (var dNode in dNodes)
                    {
                        if (dNode.ChildNodes.Count == 3)
                        {
                            var cNode = dNode.ChildNodes[1].Name;
                            var cSts = dNode.InnerText;
                            var cId = dNode.ChildNodes[2].Id;
                            if (cNode == "span" && cId == "status" )
                            {
                                panDetails.Status = cSts;
                                PAN = panDetails.PAN + '^' + panDetails.Status + '^';
                                BAL_BulkPan_Verification_AllVoucher obj = new BAL_BulkPan_Verification_AllVoucher();
                                obj.Company_ID = objTraceData.Compid;
                                DataSet ds = obj.BAL_BulkNonSalaryPANVerification(PAN);
                                goto cmplt;
                            }
                            
                        }

                    }
                }



              //  goto repate;
            }
            cmplt:
            PAN = "";


        }
        catch (Exception ex)
        {
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = ex.Message;
            this.Logoff();
        }
        return TDSResponse;
    }




    public TDSResponse RequestTDSTCSCredit_DeduteeDetails(TracesData objTraceData, string stmtMstrId, int pageNo, string strCookie, out string deducteeDtls)
    {
        TDSResponse TDSResponse = new TDSResponse();
        deducteeDtls = string.Empty;
        try
        {
            string financialYear = objTraceData.FAYear.Substring(0, objTraceData.FAYear.IndexOf("-"));
            string currYear = objTraceData.FAYear.Substring(objTraceData.FAYear.IndexOf("-") + 1, objTraceData.FAYear.Length - objTraceData.FAYear.IndexOf("-") - 1);
            currYear = objTraceData.FAYear.Substring(0, 2) + currYear;

            string currQtr = GetQuarter(objTraceData.Quarter).Replace("Q", "");
            string quarter = objTraceData.Quarter;

            //Handle cookie 
            string[] split = strCookie.Split(new string[] { ";" }, StringSplitOptions.RemoveEmptyEntries);
            for (int i = 0; i < split.Length; i++)
            {
                string[] splitValue = split[i].Split(new string[] { " = " }, StringSplitOptions.RemoveEmptyEntries);
                Cookie mycookie = new Cookie();
                mycookie.Domain = "www.tdscpc.gov.in";
                mycookie.Name = splitValue[0];
                mycookie.HttpOnly = true;


                mycookie.Value = splitValue[1];
                if (splitValue[0].IndexOf("LtpaToken2") >= -1)
                {
                    mycookie.Path = "/";
                    mycookie.Secure = false;
                }
                else if (splitValue[0].IndexOf("JSESSIONID") >= -1)
                {
                    mycookie.Path = "/app";
                    mycookie.Secure = true;

                }
                else if (splitValue[0].IndexOf("oam.Flash.RENDERMAP.TOKEN") >= -1)
                {
                    mycookie.Path = "/app";
                    mycookie.Secure = false;
                }
                this.objContainer.Add(mycookie);
            }


            // this.objContainer = newCookie;
            StringBuilder sbData = new StringBuilder();
            sbData.Append("pan=" + objTraceData.PAN1);
            sbData.Append("&stmtMstrId=" + stmtMstrId);
            sbData.Append("&finYear=" + financialYear);
            sbData.Append("&quarter=" + quarter);
            sbData.Append("&formType=" + objTraceData.Forms);

            sbData.Append("&_search=false");
            sbData.Append("&nd=1621235693740");

            sbData.Append("&rows=10");
            sbData.Append("&sidx=");
            sbData.Append("&sord=asc");
            sbData.Append("&page=" + pageNo);

            //_search = false & nd = 1621235693740 & rows = 10 & page = 1 & sidx = &sord = asc
            deducteeDtls = this.makeHTTPPostRequest_SVC(this.strBaseURL + "ded/srv/DedTdsTcsSevlet", sbData);
            TDSResponse.Respons = eResponse.Success;
        }
        catch (Exception ex)
        {
            this.Logoff();
            this.bnlSessionExists = false;
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = ex.Message;
        }
        return TDSResponse;
    }

    public TDSResponse RequestTDSTCSCredit(LoginTraces objLogin, TracesData objTraceData, string date,
        out DataTable dtStatementdtls, out string deducteeDtls)
    {
        TDSResponse TDSResponse = new TDSResponse();
        dtStatementdtls = new DataTable(); deducteeDtls = string.Empty;

        try
        {
            if (!this.IsSessionExists)
            {
                TDSResponse = this.makeLoginToTRACES_SVC(objLogin);
                if (TDSResponse.Respons == eResponse.Failed)
                    return TDSResponse;
            }
            string request = this.makeHTTPGetRequest(this.strBaseURL + "ded/tdstcscredit.xhtml");

            Dictionary<string, string> dictionary4 = this.TraceViewStateData(request, "//form[@id=\"viewTdsTcsCredit\"]");
            StringBuilder sbData4 = new StringBuilder();

            string viewState = string.Empty;
            foreach (KeyValuePair<string, string> keyValuePair in dictionary4)
            {
                if (keyValuePair.Key == "javax.faces.ViewState")
                {
                    viewState = HttpUtility.UrlEncode(keyValuePair.Value);
                    break;
                }
            }

            if (this.IsStringExists(request, "//form[@id=\"viewTdsTcsCredit\"]"))
                ;

            string currQtr = GetQuarter(objTraceData.Quarter).Replace("Q", "");
            string quarter = objTraceData.Quarter;

            string financialYear = objTraceData.FAYear.Substring(0, objTraceData.FAYear.IndexOf("-"));
            string currYear = objTraceData.FAYear.Substring(objTraceData.FAYear.IndexOf("-") + 1, objTraceData.FAYear.Length - objTraceData.FAYear.IndexOf("-") - 1);
            currYear = objTraceData.FAYear.Substring(0, 2) + currYear;
            CookieContainer objContainer_old = this.objContainer;

            StringBuilder sbData = new StringBuilder();
            sbData.Append("tan=" + objTraceData.TAN);
            sbData.Append("&pan=" + objTraceData.PAN1);
            sbData.Append("&financialYear=" + financialYear);
            sbData.Append("&currYear=" + currYear);
            sbData.Append("&quarter=" + quarter);
            sbData.Append("&currQtr=" + currQtr);
            sbData.Append("&formType=" + objTraceData.Forms);
            sbData.Append("&clickGo=Go");
            sbData.Append("&viewTdsTcsCredit_SUBMIT=1");
            sbData.Append("&javax.faces.ViewState=" + viewState);

            string statementDtls = this.makeHTTPPostRequest_SVC(this.strBaseURL + "ded/tdstcscredit.xhtml", sbData);




            // this.objContainer = newCookie;

            Dictionary<string, string> dictionary = this.TraceHiddenField(statementDtls, "//form[@id=\"dispMsg\"]");

            string stmtMstrId = string.Empty;
            foreach (KeyValuePair<string, string> keyValuePair in dictionary)
            {
                if (keyValuePair.Key == "stmtMstrId")
                {
                    stmtMstrId = HttpUtility.UrlEncode(keyValuePair.Value);
                    break;
                }
            }

            // this.objContainer = newCookie;
            sbData = new StringBuilder();
            sbData.Append("pan=" + objTraceData.PAN1);
            sbData.Append("&stmtMstrId=" + stmtMstrId);
            sbData.Append("&finYear=" + financialYear);
            sbData.Append("&quarter=" + quarter);
            sbData.Append("&formType=" + objTraceData.Forms);

            sbData.Append("&_search=false");
            sbData.Append("&nd=" + date);

            sbData.Append("&rows=10");
            sbData.Append("&sidx=");
            sbData.Append("&sord=asc");
            sbData.Append("&page=1");

            //_search = false & nd = 1621235693740 & rows = 10 & page = 1 & sidx = &sord = asc
            deducteeDtls = this.makeHTTPPostRequest_SVC(this.strBaseURL + "ded/srv/DedTdsTcsSevlet", sbData);



            dtStatementdtls = TraceStatementDetails(statementDtls, "//div[@id=\"stmtdetail\"]");
            TDSResponse.Respons = eResponse.Success;
            TDSResponse.CustomeTypes = (object)dtStatementdtls;
        }
        catch (Exception ex)
        {
            this.Logoff();
            this.bnlSessionExists = false;
            TDSResponse.Respons = eResponse.Failed;
            TDSResponse.Message = ex.Message;
        }
        return TDSResponse;
    }


    public TracesResponce RequestForPANValidation(string strPAN)
    {
        TracesResponce response = new TracesResponce();
        string strServerResponse = "";
        try
        {
            strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "ded/panverify.xhtml");
            if (!this.IsStringExists(strServerResponse, "//form[@id=\"pandetailsForm1\"]"))
            {
                response.eResps = eresposenum.SessionTimeout;
                return response;
            }
            StringBuilder sbData = new StringBuilder();
            sbData.Append("pannumber=" + strPAN.Trim());
            sbData.Append("&frmType1=24Q");
            sbData.Append("&clickGo1=Go");
            sbData.Append("&pandetailsForm1_SUBMIT=1");
            Dictionary<string, string> dictionary = this.TraceViewStateData(strServerResponse, "//form[@id=\"pandetailsForm1\"]");
            foreach (KeyValuePair<string, string> pair in dictionary)
            {
                if ("javax.faces.ViewState" == pair.Key)
                {
                    sbData.Append("&" + pair.Key + "=" + HttpUtility.UrlEncode(pair.Value));
                }
            }
            strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "ded/panverify.xhtml", sbData);
            if (response.eResps == eresposenum.Failed)
            {
                return response;
            }
            PANDetails details = new PANDetails();
            details.PAN = strPAN;
            foreach (KeyValuePair<string, string> pair2 in dictionary)
            {
                if (pair2.Key.ToString().ToUpper() == "STATUS")
                {
                    details.Status = pair2.Value;
                }
                if (pair2.Key.ToString().ToUpper() == "NAME")
                {
                    details.Name = pair2.Value;
                }
            }
            response.CustomeTypes = details;
            response.eResps = eresposenum.Success;
        }
        catch (Exception exception)
        {
            response.Message = exception.Message;
            response.eResps = eresposenum.Failed;
        }
        return response;
    }

    public TracesResponce RequestForPANValidation(string strPAN, out string strName)
    {
        TracesResponce response = new TracesResponce();
        string strServerResponse = "";
        strName = "";
        try
        {
            strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "ded/panverify.xhtml");
            if (!this.IsStringExists(strServerResponse, "//form[@id=\"pandetailsForm1\"]"))
            {
                response.eResps = eresposenum.SessionTimeout;
                return response;
            }
            StringBuilder sbData = new StringBuilder();
            sbData.Append("pannumber=" + strPAN.Trim());
            sbData.Append("&frmType1=24Q");
            sbData.Append("&clickGo1=Go");
            sbData.Append("&pandetailsForm1_SUBMIT=1");
            Dictionary<string, string> dictionary = this.TraceViewStateData(strServerResponse, "//form[@id=\"pandetailsForm1\"]");
            foreach (KeyValuePair<string, string> pair in dictionary)
            {
                if ("javax.faces.ViewState" == pair.Key)
                {
                    sbData.Append("&" + pair.Key + "=" + HttpUtility.UrlEncode(pair.Value));
                    break;
                }
            }
            strServerResponse = this.makeHTTPPostRequest(this.strBaseURL + "ded/panverify.xhtml", sbData);
            if (response.eResps == eresposenum.Failed)
            {
                return response;
            }
            strName = this.RetrievePANName(strServerResponse);
            response.eResps = eresposenum.Success;
        }
        catch (Exception exception)
        {
            response.Message = exception.Message;
            response.eResps = eresposenum.Failed;
        }
        return response;
    }

    private enmChallanStatus getInnerText(string html, string strQuery)
    {
        enmChallanStatus innerText = enmChallanStatus.RECORD_NOT_FOUND;
        HtmlDocument htmlDocument = new HtmlDocument();
        htmlDocument.LoadHtml(html);
        HtmlNodeCollection htmlNodeCollection = htmlDocument.DocumentNode.SelectNodes(strQuery);
        if (htmlNodeCollection == null)
            return enmChallanStatus.RECORD_NOT_FOUND;
        foreach (HtmlNode htmlNode in (IEnumerable<HtmlNode>)htmlNodeCollection)
        {
            if (htmlNode.InnerText.ToUpper().Trim() == "AMOUNT MATCHED")
                innerText = enmChallanStatus.AMOUNT_MATCHED;
            else if (htmlNode.InnerText.ToUpper().Trim() == "MISMATCH IN AMOUNT")
                innerText = enmChallanStatus.AMOUNT_NOT_MATCHED;
            else if (htmlNode.InnerText.ToUpper().Trim() == "AMOUNT NOT MATCHED")
                innerText = enmChallanStatus.AMOUNT_NOT_MATCHED;
        }
        return innerText;
    }
    public class PANDetails
    {
        public string PAN { get; set; }
        public string Status { get; set; }
        public string Name { get; set; }
    }

}


