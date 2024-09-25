using HtmlAgilityPack;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Net;
using System.Net.Configuration;
using System.Net.Security;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;

/// <summary>
/// Summary description for IncomeTAX_Service
/// </summary>
public class IncomeTAX_Service
{
    private string strURL = "";
    private HttpWebRequest request = (HttpWebRequest)null;
    private HttpWebResponse response = (HttpWebResponse)null;
    private Stream dataStream = (Stream)null;
    private StreamReader reader = (StreamReader)null;
    private string strServerResponse = "";
    private CookieContainer objContainer = new CookieContainer();
    private List<RecData<int, string, string>> objMsgDictionary = new List<RecData<int, string, string>>();
    private string strBaseURL = "https://eportal.incometax.gov.in/iec/";
    private bool bnlSessionExists = false;
    private StringBuilder objParam = new StringBuilder();
    private string RefId = "";
    private string ReQId = "";


    public string ConvertBase64(string strText)
    {
        return Convert.ToBase64String(Encoding.ASCII.GetBytes(strText));
    }

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

    private TDSResponse IsServerError(string strServerResponse, string strXQuery)
    {
        string str = "";
        TDSResponse tracesResponse = new TDSResponse();
        tracesResponse.Respons = eResponse.Success;
        HtmlDocument htmlDocument = new HtmlDocument();
        htmlDocument.LoadHtml(strServerResponse);
        HtmlNodeCollection htmlNodeCollection = htmlDocument.DocumentNode.SelectNodes(strXQuery);
        if (htmlNodeCollection == null)
            return tracesResponse;
        for (int index = 0; index < htmlNodeCollection.Count; ++index)
            str = htmlNodeCollection[index].InnerText.Replace("\t", "");
        if (!string.IsNullOrEmpty(str.Trim()))
        {
            tracesResponse.Message = str;
            tracesResponse.Respons = eResponse.Failed;
        }
        return tracesResponse;
    }

    private bool IsStringExists(string strServerResponse, string strXQuery)
    {
        new TDSResponse().Respons = eResponse.Success;
        HtmlDocument htmlDocument = new HtmlDocument();
        htmlDocument.LoadHtml(strServerResponse);
        return htmlDocument.DocumentNode.SelectNodes(strXQuery) != null;
    }

    private bool IsConditionMatch(string strResponse, string strPattern)
    {
        return Regex.IsMatch(strResponse, strPattern, RegexOptions.IgnoreCase);
    }

    public TDSResponse makeLoginToIncomeTax(string Tan, string Pwd)
    {
        TDSResponse incomeTax = new TDSResponse();
        StringBuilder stringBuilder = new StringBuilder();
        try
        {
            this.strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "foservices/#/login");
            this.strServerResponse = this.makeHTTPJSONPostRequest(this.strBaseURL + "loginapi/login", "{\"entity\":\"" + Tan + "\",\"serviceName\":\"loginService\"}");
            if (string.IsNullOrEmpty(this.strServerResponse))
            {
                this.IsSessionExists = false;
                incomeTax.Respons = eResponse.Failed;
                incomeTax.Message = "Login Failed or Server Error";
                return incomeTax;
            }
            IncomeTAX_Root root1 = JsonConvert.DeserializeObject<IncomeTAX_Root>(this.strServerResponse);
            if (root1.messages.Count > 0)
            {
                foreach (IncomeTAX_Message message in root1.messages)
                {
                    if (message.type == "ERROR")
                    {
                        incomeTax.Respons = eResponse.Failed;
                        incomeTax.Message = message.desc;
                        return incomeTax;
                    }
                    if (message.desc.ToString().ToUpper().Contains("LOCKED"))
                    {
                        incomeTax.Respons = eResponse.Failed;
                        incomeTax.Message = message.desc;
                        return incomeTax;
                    }
                }
            }
            string str = this.ConvertBase64(Pwd);
            this.strServerResponse = this.makeHTTPJSONPostRequest(this.strBaseURL + "loginapi/login", "{\"errors\":[],\"reqId\":\"" + root1.reqId + "\",\"entity\":\"" + Tan + "\",\"entityType\":\"User ID\",\"pass\":\"" + str + "\",\"role\":\"TDS\",\"uidValdtnFlg\":\"true\",\"passValdtnFlg\":null,\"aadhaarMobileValidated\":\"false\",\"secAccssMsg\":\"\",\"secLoginOptions\":\"\",\"exemptedPan\":\"false\",\"userConsent\":\"\",\"imagePath\":null,\"imgByte\":null,\"serviceName\":\"loginService\"}");
            IncomeTAX_Root root2 = JsonConvert.DeserializeObject<IncomeTAX_Root>(this.strServerResponse);
            bool flag = false;
            if (root2.messages.Count > 0)
            {
                foreach (IncomeTAX_Message message in root2.messages)
                {
                    if (message.type == "INFO" && message.desc == "Invalid Password, Please retry.")
                    {
                        incomeTax.Respons = eResponse.Failed;
                        incomeTax.Message = message.desc;
                        return incomeTax;
                    }
                    if (message.code == "EF00177" && message.type == "ERROR" && message.desc == "Session already active")
                        flag = true;
                }
            }
            if (flag)
                this.strServerResponse = this.makeHTTPJSONPostRequest(this.strBaseURL + "loginapi/login", "{\"errors\":[],\"reqId\":\"" + root2.reqId + "\",\"entity\":\"" + Tan + "\",\"entityType\":\"" + root2.entityType + "\",\"role\":\"" + root2.role + "\",\"userType\":\"" + root2.userType + "\",\"uidValdtnFlg\":\"" + root2.uidValdtnFlg + "\",\"passValdtnFlg\":\"" + root2.passValdtnFlg + "\",\"mobileNo\":\"" + root2.mobileNo + "\",\"email\":\"" + root2.email + "\",\"aadhaarMobileValidated\":\"" + root2.aadhaarMobileValidated + "\",\"secAccssMsg\":\"\",\"secLoginOptions\":\"\",\"contactPan\":\"" + root2.contactPan + "\",\"contactEmail\":\"" + root2.contactEmail + " \",\"contactMobile\":\"" + root2.contactMobile + "\",\"lastLoginSuccessFlag\":\"" + root2.lastLoginSuccessFlag + "\",\"clientIp\":\"" + root2.clientIp + "\",\"exemptedPan\":\"" + root2.exemptedPan + "\",\"userConsent\":\"\",\"pass\":null,\"otpGenerationFlag\":\"true\",\"otpValdtnFlg\":\"true\",\"remark\":\"Continue\",\"serviceName\":\"loginService\"}");
            incomeTax.Respons = eResponse.Success;
            incomeTax.CustomeTypes = (object)root2;
        }
        catch (Exception ex)
        {
            incomeTax.Respons = eResponse.Failed;
            incomeTax.Message = ex.Message;
            return incomeTax;
        }
        return incomeTax;
    }

    public TDSResponse Logoff(string strPan)
    {
        TDSResponse tracesResponse = new TDSResponse();
        try
        {
            this.strServerResponse = this.makeHTTPJSONPostRequest(this.strBaseURL + "loginapi/login", "{\"serviceName\":\"logoutService\",\"entity\":\"" + strPan + "\",\"userType\":\"TDS\"}");
            this.bnlSessionExists = false;
            tracesResponse.Respons = eResponse.Success;
        }
        catch
        {
            tracesResponse.Respons = eResponse.Failed;
        }
        return tracesResponse;
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
            this.request.Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9";
            this.request.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36";
            this.request.ContentType = "application/x-www-form-urlencoded";
            this.request.Headers.Add("Accept-Language: en-US,en;q=0.9,bn;q=0.8");
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
        HttpStatusCode statusCode = this.response.StatusCode;
        this.strServerResponse = this.reader.ReadToEnd();
        this.reader.Close();
        this.dataStream.Close();
        this.response.Close();
        return this.strServerResponse;
    }

    private string makeHTTPGetRequest(string strURL)
    {
        IncomeTAX_Service.SetAllowUnsafeHeaderParsing();
        ServicePointManager.ServerCertificateValidationCallback = (RemoteCertificateValidationCallback)((_param1, _param2, _param3, _param4) => true);
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;
        this.request = (HttpWebRequest)WebRequest.Create(strURL);
        this.request.KeepAlive = true;
        this.request.Method = "GET";
        this.request.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36";
        this.request.Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9";
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

    private string makeHTTPJSONRequest(string strURL)
    {
        this.request = (HttpWebRequest)WebRequest.Create(strURL);
        string str = "";
        this.request.ServicePoint.Expect100Continue = false;
        this.request.Method = "GET";
        this.request.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36";
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
            this.request.Accept = "application/json, text/plain, */*";
            this.request.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36";
            this.request.ContentType = "application/json";
            this.request.Headers.Add("Accept-Language: en-US,en;q=0.9,bn;q=0.8");
            this.request.Headers.Add("X-Requested-With", "XMLHttpRequest");
            this.request.Headers.GetType().InvokeMember("ChangeInternal", BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.InvokeMethod, (Binder)null, (object)this.request.Headers, new object[2]
            {
          (object) "Host",
          (object) "eportal.incometax.gov.in"
            });
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
        Thread.Sleep(5000);
        this.response = (HttpWebResponse)this.request.GetResponse();
        this.dataStream = this.response.GetResponseStream();
        this.reader = new StreamReader(this.dataStream);
        this.strServerResponse = this.reader.ReadToEnd();
        this.reader.Close();
        this.dataStream.Close();
        this.response.Close();
        return this.strServerResponse;
    }
    private string ValidateOtp_makeHTTPJSONPostRequest(string strURL, string sbData)
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
            this.request.Accept = "application/json, text/plain, */*";
            this.request.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36";
            this.request.ContentType = "application/json";
            this.request.Headers.Add("Accept-Language: en-US,en;q=0.9,bn;q=0.8");
            this.request.Headers.Add("X-Requested-With", "XMLHttpRequest");
            this.request.Headers.GetType().InvokeMember("ChangeInternal", BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.InvokeMethod, (Binder)null, (object)this.request.Headers, new object[2]
            {
          (object) "Host",
          (object) "eportal.incometax.gov.in"
            });
            this.request.Timeout = 1000000000;
        }
        if (this.request.CookieContainer == null)
            this.request.CookieContainer = this.objContainer;
        //this.request.CookieContainer.Add(this.response.Cookies);
        if (!string.IsNullOrEmpty(Convert.ToString(sbData)))
        {
            this.dataStream = this.request.GetRequestStream();
            this.dataStream.Write(buffer, 0, buffer.Length);
            this.dataStream.Close();
        }
        Thread.Sleep(5000);
        this.response = (HttpWebResponse)this.request.GetResponse();
        this.dataStream = this.response.GetResponseStream();
        this.reader = new StreamReader(this.dataStream);
        this.strServerResponse = this.reader.ReadToEnd();
        this.reader.Close();
        this.dataStream.Close();
        this.response.Close();
        return this.strServerResponse;
    }

    private string DownloadChl_makeHTTPJSONPostRequest(string strURL, string sbData)
    {
 
        try
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
                this.request.Accept = "application/json, text/plain, */*";
                this.request.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36";
                this.request.ContentType = "application/json";
                this.request.Headers.Add("Accept-Language: en-US,en;q=0.9,bn;q=0.8");
                this.request.Headers.Add("X-Requested-With", "XMLHttpRequest");
                this.request.Headers.GetType().InvokeMember("ChangeInternal", BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.InvokeMethod, (Binder)null, (object)this.request.Headers, new object[2]
                {
          (object) "Host",
          (object) "eportal.incometax.gov.in"
                });
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
            Thread.Sleep(5000);

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

            return ex.Message.ToString();
        }
        return this.strServerResponse;
    }

    private string Challan_makeHTTPJSONPostRequest(string strURL, string sbData)
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
            this.request.Accept = "application/json, text/plain, */*";
            this.request.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36";
            this.request.ContentType = "application/json";
            this.request.Headers.Add("Accept-Language: en-US,en;q=0.9,bn;q=0.8");
            this.request.Headers.Add("X-Requested-With", "XMLHttpRequest");
            this.request.Headers.GetType().InvokeMember("ChangeInternal", BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.InvokeMethod, (Binder)null, (object)this.request.Headers, new object[2]
            {
          (object) "Host",
          (object) "eportal.incometax.gov.in"
            });
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
        Thread.Sleep(5000);
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
            IncomeTAX_Service.SetAllowUnsafeHeaderParsing();
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
      IncomeTAX_Service.enmElementType enmElement)
    {
        string str = "";
        HtmlDocument htmlDocument = new HtmlDocument();
        htmlDocument.LoadHtml(strHTML);
        HtmlNodeCollection htmlNodeCollection1 = htmlDocument.DocumentNode.SelectNodes(xPathQuery);
        if (htmlNodeCollection1 == null || htmlNodeCollection1 == null || htmlNodeCollection1.Count <= 0)
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
                        case IncomeTAX_Service.enmElementType.InnerText:
                            str = htmlNodeCollection2[index].InnerText;
                            break;
                        case IncomeTAX_Service.enmElementType.InnerHTML:
                            str = htmlNodeCollection2[index].InnerHtml;
                            break;
                        case IncomeTAX_Service.enmElementType.Value:
                            str = htmlNodeCollection2[index].Attributes["value"].Value;
                            break;
                        case IncomeTAX_Service.enmElementType.Name:
                            str = htmlNodeCollection2[index].Attributes["name"].Value;
                            break;
                    }
                }
            }
        }
        return str;
    }

    private string HTMLTagAttributeValue(string strHTML, string xPathQuery, string strAttName)
    {
        HtmlDocument htmlDocument = new HtmlDocument();
        htmlDocument.LoadHtml(strHTML);
        return htmlDocument.DocumentNode.SelectNodes(xPathQuery)[0].Attributes[strAttName].Value;
    }

    private Dictionary<string, string> TraceallInputFields(string strHTML, string xPathQuery)
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

    private string AttributeValie(string strHTML, string strXPath, string strAttrib)
    {
        HtmlDocument htmlDocument = new HtmlDocument();
        htmlDocument.LoadHtml(strHTML);
        return htmlDocument.DocumentNode.SelectSingleNode(strXPath).Attributes[strAttrib].Value;
    }

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

    public TDSResponse DownloadCSI(
      string strPan,
      string Pwd,
      string strFromDate,
      string strTodate,
      out string filename, out string base64)
    {
        TDSResponse tracesResponse = new TDSResponse();
        filename = string.Empty; base64 = string.Empty;
        try
        {
            tracesResponse = this.makeLoginToIncomeTax(strPan, Pwd);
            if (tracesResponse.Respons == eResponse.Failed)
                return tracesResponse;
            //this.strServerResponse = this.makeHTTPJSONPostRequest(this.strBaseURL + "PaymentAPI/auth/challan/downloadCSI", "{\"header\":{\"formName\":\"mat-tab-label-0-3\"},\"formData\":{\"pan\":\"" + strPan + "\",\"fromDate\":\"" + strFromDate + "\",\"toDate\":\"" + strTodate + "\",\"loggedInUserID\":\"" + strPan + "\",\"loggedInUserType\":\"TDS\"}}");
            this.strServerResponse =  Challan_makeHTTPJSONPostRequest(this.strBaseURL + "PaymentAPI/auth/challan/downloadCSI", "{\"header\":{\"formName\":\"mat-tab-label-0-3\"},\"formData\":{\"pan\":\"" + strPan + "\",\"fromDate\":\"" + strFromDate + "\",\"toDate\":\"" + strTodate + "\",\"loggedInUserID\":\"" + strPan + "\",\"loggedInUserType\":\"TDS\"}}");

            IncomeTAX_Root root = JsonConvert.DeserializeObject<IncomeTAX_Root>(this.strServerResponse);
            if (root.messages.Count > 0)
            {
                foreach (IncomeTAX_Message message in root.messages)
                {
                    if (message.type == "ERROR")
                    {
                        tracesResponse.Respons = eResponse.Failed;
                        tracesResponse.Message = message.desc;
                        return tracesResponse;
                    }
                }
            }
            tracesResponse.Respons = eResponse.Success;
            tracesResponse.Message = root.csiResponse;
            //this.strServerResponse = this.makeHTTPJSONPostRequest(this.strBaseURL + "loginapi/login", "{\"serviceName\":\"logoutService\",\"entity\":\"" + strPan + "\",\"userType\":\"TDS\"}");


         }
        catch (Exception ex)
        {
            tracesResponse.Respons = eResponse.Failed;
            tracesResponse.Message = "Server Error";
        }
        return tracesResponse;
    }

    public TDSResponse DownloadCSINoPassword(
      string strPan,
      string strFromDate,
      string strTodate)
    {
        TDSResponse tracesResponse = new TDSResponse();
        try
        {
            if (tracesResponse.Respons == eResponse.Failed)
                return tracesResponse;
            this.strServerResponse = this.makeHTTPJSONPostRequest(this.strBaseURL + "paymentAPI/auth/challan/downloadCSI", "{\"header\":{\"formName\":\"PO-03-PYMNT\"},\"formData\":{\"pan\":\"" + strPan + "\",\"fromDate\":\"" + strFromDate + "\",\"toDate\":\"" + strTodate + "\",\"loggedInUserID\":\"" + strPan + "\",\"loggedInUserType\":\"TDS\"}}");
            IncomeTAX_Root root = JsonConvert.DeserializeObject<IncomeTAX_Root>(this.strServerResponse);
            if (root.messages.Count > 0)
            {
                foreach (IncomeTAX_Message message in root.messages)
                {
                    if (message.type == "ERROR")
                    {
                        tracesResponse.Respons = eResponse.Failed;
                        tracesResponse.Message = message.desc;
                        return tracesResponse;
                    }
                }
            }
            tracesResponse.Respons = eResponse.Success;
            tracesResponse.Message = root.csiResponse;
            this.strServerResponse = this.makeHTTPJSONPostRequest(this.strBaseURL + "loginapi/login", "{\"serviceName\":\"logoutService\",\"entity\":\"" + strPan + "\",\"userType\":\"TDS\"}");
        }
        catch (Exception ex)
        {
            tracesResponse.Respons = eResponse.Failed;
            tracesResponse.Message = "Server Error";
        }
        return tracesResponse;
    }

    public TDSResponse DownloadCSIOTP(string strTan, string MobileNo)
    {
        this.strServerResponse = this.makeHTTPGetRequest(this.strBaseURL + "foservices/#/download-csi-file/tan-user-details");
        TDSResponse tracesResponse = new TDSResponse();
        this.strServerResponse = this.makeHTTPJSONPostRequest(this.strBaseURL + "guestservicesapi/saveEntity", "{\"tnNum\":\"" + strTan + "\",\"mbl\":\"" + MobileNo + "\",\"areaCd\":\"91\",\"name\":\"tan\",\"serviceName\":\"knowYourTanService\",\"formName\":\"PO-03-PYMNT\"}");
        IncomeTAX_Root root = JsonConvert.DeserializeObject<IncomeTAX_Root>(this.strServerResponse);

        try
        {
            if (root.messages.Count > 0)
            {
                foreach (IncomeTAX_Message message in root.messages)
                {
                    if (message.type == "ERROR")
                    {
                        tracesResponse.Respons = eResponse.Failed;
                        tracesResponse.Message = message.desc;
                        return tracesResponse;
                    }
                }
            }
            this.RefId = root.userId;
            this.ReQId = root.transactionNo;

            tracesResponse.URefid = root.userId;
            tracesResponse.URqid = root.transactionNo;
            tracesResponse.Respons = eResponse.Success;
            tracesResponse.Message = root.csiResponse;
        }
        catch (Exception ex)
        {
            tracesResponse.URefid = "0000";
            tracesResponse.URqid = "0000";
            tracesResponse.Respons = eResponse.Failed;
            tracesResponse.Message = "Server Error";
        }

        return tracesResponse;
    }

    public TDSResponse DownloadCSIOTPValidation(string strOTP, string strTan, string RefId , string ReQId)
    {
        TDSResponse tracesResponse = new TDSResponse();
        this.strServerResponse = this.ValidateOtp_makeHTTPJSONPostRequest(this.strBaseURL + "paymentapi/commapi/validateOtp", "{\"tnNum\":\"" + strTan + "\",\"serviceName\":\"knowYourTanService\",\"refId\":\"" + RefId + "\",\"otpValue\":\"" + strOTP + "\",\"formName\":\"PO-03-PYMNT\",\"reqId\":\"" + ReQId + "\"}");
        IncomeTAX_Root root = JsonConvert.DeserializeObject<IncomeTAX_Root>(this.strServerResponse);
        if (root.messages.Count > 0)
        {
            foreach (IncomeTAX_Message message in root.messages)
            {
                if (message.type == "ERROR")
                {
                    tracesResponse.Respons = eResponse.Failed;
                    tracesResponse.Message = message.desc;
                    return tracesResponse;
                }
            }
        }
        tracesResponse.Respons = eResponse.Success;
        tracesResponse.Message = root.reqId;
        return tracesResponse;
    }

    public TDSResponse DownloadCSIFileByOTP(string strTan, string strFromDate, string strTodate, string ReQId)
    {
 
        TDSResponse tracesResponse = new TDSResponse();
        // this.strServerResponse = this.DownloadChl_makeHTTPJSONPostRequest(this.strBaseURL + "paymentapi/challan/downloadCSI", "{\"formData\":{\"pan\":\"" + strTan + "\",\"fromDate\":\"" + strFromDate + "\",\"toDate\":\"" + strTodate + "\"},\"header\":{\"reqId\":\"" + ReQId + "\"}}");
        this.strServerResponse = this.DownloadChl_makeHTTPJSONPostRequest(this.strBaseURL + "paymentapi/challan/downloadCSI", "{\"formData\":{\"pan\":\"" + strTan + "\",\"fromDate\":\"" + strFromDate + "\",\"toDate\":\"" + strTodate + "\"},\"header\":{\"reqId\":\"" + ReQId + "\"}}");

        IncomeTAX_Root root = JsonConvert.DeserializeObject<IncomeTAX_Root>(this.strServerResponse);
        if (root.messages.Count > 0)
        {
            foreach (IncomeTAX_Message message in root.messages)
            {
                if (message.type == "ERROR")
                {
                    tracesResponse.Respons = eResponse.Failed;
                    tracesResponse.Message = message.desc;
                    return tracesResponse;
                }
            }
        }
        tracesResponse.Respons = eResponse.Success;
        tracesResponse.Message = root.csiResponse;
        return tracesResponse;
    
    }

    private enum enmElementType
    {
        InnerText,
        InnerHTML,
        Value,
        Name,
    }

}