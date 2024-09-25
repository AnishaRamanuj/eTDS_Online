
using HtmlAgilityPack;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Net;
using System.Net.Configuration;
using System.Net.Security;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;

namespace PANVrf
{
    public class ConnectTraces
    {
        private bool bnlSessionExists = false;
        private Stream dataStream = null;
        private CookieContainer objContainer = new CookieContainer();
        private StreamReader reader = null;
        private HttpWebRequest request = null;
        private HttpWebResponse response = null;
        private string strBaseURL = "https://www.tdscpc.gov.in/app/";
        private string strCaptchBaseURL = "https://www.tdscpc.gov.in/app/srv/";
        private string strServerResponse = "";

        private static bool blnDownloadStaus = false;
        public bool blnFetchData = true;
        private static string DownloadedFileName = "";
        private static string GetPAN_Verification = "";

        private const uint NERR_Success = 0;
        private static string PANVerify = "";
        private static string strDownloadPath = "";

        private string strSQL = string.Empty;

        private string DownloadURLCheck(string strURL)
        {
            this.request = (HttpWebRequest)WebRequest.Create(strURL);
            this.request.KeepAlive = true;
            this.request.Timeout = 0x493e0;
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


        public Stream getCaptchaImage()
        {
            Cookie current;
            this.bnlSessionExists = false;
            this.request = (HttpWebRequest)WebRequest.Create(this.strCaptchBaseURL + "GetCaptchaImg");
            this.request.Method = "GET";
            this.request.Accept = "image/png,image/*;q=0.8,*/*;q=0.5";
            this.request.UserAgent = "Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0";
            this.request.ContentType = "text/html; charset=utf-8";
            this.request.KeepAlive = true;
            this.request.CookieContainer = this.objContainer;
            if ((this.response.Cookies != null) && (this.response.Cookies.Count > 0))
            {
                this.objContainer.Add(this.response.Cookies);
            }
            IEnumerator enumerator = this.response.Cookies.GetEnumerator();
            {
                while (enumerator.MoveNext())
                {
                    current = (Cookie)enumerator.Current;
                    this.objContainer.Add(new Cookie(current.Name.Trim(), current.Value.Trim(), "/", current.Domain));
                }
            }
            if (!string.IsNullOrEmpty(this.response.Headers["Set-Cookie"]))
            {
            }
            for (int i = 0; i < this.objContainer.GetCookies(this.request.RequestUri).Count; i++)
            {
                current = this.objContainer.GetCookies(this.request.RequestUri)[i];
            }
            return this.request.GetResponse().GetResponseStream();
        }

        public Stream GetPANVerify_with_Captcha()
        {
            Cookie current;
            this.Get_HTTPRequest("https://incometaxindiaefiling.gov.in/e-Filing/Services/KnowYourJurisdiction.html");
            this.request = (HttpWebRequest)WebRequest.Create("https://incometaxindiaefiling.gov.in/e-Filing/CreateCaptcha.do");
            this.request.Method = "GET";
            this.request.Accept = "image/png,image/*;q=0.8,*/*;q=0.5";
            this.request.UserAgent = "Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0";
            this.request.ContentType = "text/html; charset=utf-8";
            this.request.KeepAlive = true;
            this.request.CookieContainer = this.objContainer;
            if ((this.response.Cookies != null) && (this.response.Cookies.Count > 0))
            {
                this.objContainer.Add(this.response.Cookies);
            }
            IEnumerator enumerator = this.response.Cookies.GetEnumerator();
            {
                while (enumerator.MoveNext())
                {
                    current = (Cookie)enumerator.Current;
                    this.objContainer.Add(new Cookie(current.Name.Trim(), current.Value.Trim(), "/", current.Domain));
                }
            }
            for (int i = 0; i < this.objContainer.GetCookies(this.request.RequestUri).Count; i++)
            {
                current = this.objContainer.GetCookies(this.request.RequestUri)[i];
            }
            return this.request.GetResponse().GetResponseStream();
        }



        private string GetFileLocation(string strURL)
        {
            this.request = (HttpWebRequest)WebRequest.Create(strURL);
            this.request.KeepAlive = true;
            this.request.Timeout = 0x493e0;
            this.request.AllowWriteStreamBuffering = false;
            this.request.AllowAutoRedirect = false;
            this.request.UserAgent = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.57 Safari/537.17";
            this.request.CookieContainer = this.objContainer;
            this.request.CookieContainer.Add(this.response.Cookies);
            this.response = (HttpWebResponse)this.request.GetResponse();
            return this.response.Headers["Location"];
        }

        private string HTMLTagAttributeValue(string strHTML, string StrQuery, string strAttName)
        {
            HtmlDocument document = new HtmlDocument();
            document.LoadHtml(strHTML);
            HtmlNode node = document.DocumentNode.SelectNodes(StrQuery)[0];
            return node.Attributes[strAttName].Value;
        }

        private bool IsConditionMatch(string strResponse, string strPattern)
        {
            return Regex.IsMatch(strResponse, strPattern, RegexOptions.IgnoreCase);
        }

        private HttpStatusCode IsConnected(string strURL)
        {
            try
            {
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(strURL);
                request.AllowAutoRedirect = false;
                this.response = (HttpWebResponse)request.GetResponse();
                return this.response.StatusCode;
            }
            catch
            {
                return HttpStatusCode.Forbidden;
            }
        }

        private eResponse IsServerError(string strServerResponse, string strXQuery)
        {
            string str = "";
            eResponse response = new eResponse
            {
                Respons = eRes.Success
            };
            HtmlDocument document = new HtmlDocument();
            document.LoadHtml(strServerResponse);
            HtmlNodeCollection nodes = document.DocumentNode.SelectNodes(strXQuery);
            if (nodes != null)
            {
                for (int i = 0; i < nodes.Count; i++)
                {
                    str = nodes[i].InnerText.Replace("\t", "");
                }
                if (!string.IsNullOrEmpty(str))
                {
                    response.Message = str;
                    response.Respons = eRes.Failed;
                }
            }
            return response;
        }


        public Stream GetCaptchaforBulkPAN()
        {
            Stream responseStream;
            try
            {
                this.request = (HttpWebRequest)WebRequest.Create("https://incometaxindiaefiling.gov.in/e-Filing/CreateCaptcha.do");
                this.request.Method = "GET";
                this.request.Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8";
                this.request.UserAgent = "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.87 Safari/537.36";
                this.request.ContentType = "text/html; charset=utf-8";
                this.request.KeepAlive = true;
                this.request.CookieContainer = this.objContainer;
                responseStream = this.request.GetResponse().GetResponseStream();
            }
            catch (Exception exception)
            {
                throw exception;
            }
            return responseStream;
        }

        private eResponse IsServerError(string strServerResponse, List<string> strXQuery)
        {
            string str = "";
            eResponse response = new eResponse
            {
                Respons = eRes.Success
            };
            HtmlDocument document = new HtmlDocument();
            document.LoadHtml(strServerResponse);
            HtmlNode documentNode = document.DocumentNode;
            foreach (string str2 in strXQuery)
            {
                HtmlNodeCollection nodes = documentNode.SelectNodes(str2);
                GetCaptchaforBulkPAN();
                if (nodes == null)
                {
                    return response;
                }
                for (int i = 0; i < nodes.Count; i++)
                {
                    str = nodes[i].InnerText.Replace("\t", "");
                }
                if (!string.IsNullOrEmpty(str))
                {
                    response.Message = str;
                    response.Respons = eRes.Failed;
                }
            }
            return response;
        }

        private eResponse IsServerError1(string strServerResponse)
        {
            eResponse response = new eResponse
            {
                Respons = eRes.Success
            };

            return response;
        }

        private bool IsStringExists(string strServerResponse, string strXQuery)
        {
            eResponse response = new eResponse
            {
                Respons = eRes.Success
            };
            HtmlDocument document = new HtmlDocument();
            document.LoadHtml(strServerResponse);
            if (document.DocumentNode.SelectNodes(strXQuery) == null)
            {
                return false;
            }
            return true;
        }

        public bool IsPAN_Valid(string PAN_No)
        {
            try
            {
                this.strServerResponse = this.makeHTTPGetRequest("https://onlineservices.tin.egov-nsdl.com/etaxnew/tdsnontds.jsp");
                if (this.IsStringExists(this.strServerResponse, "//form[@name=\"selectform\"]"))
                {
                    string str = this.HTMLTagAttributeValue(this.strServerResponse, "//form[@name=\"selectform\"]", "action");
                    if (!string.IsNullOrEmpty(str))
                    {
                        StringBuilder strData = new StringBuilder();
                        strData.Append("browser_type=IE");
                        strData.Append("&from_tdsnontds=Y");
                        strData.Append("&R2=280");
                        this.strServerResponse = this.Post_HTTPRequest("https://onlineservices.tin.egov-nsdl.com/etaxnew/" + str, strData);
                        strData = new StringBuilder();
                        strData.Append("AssessYear=");
                        strData.Append("&Add_State=");
                        strData.Append("&Name=");
                        strData.Append("&Add_PIN=");
                        strData.Append("&Add_Line1=");
                        strData.Append("&Add_Line2=");
                        strData.Append("&Add_Line3=");
                        strData.Append("&Add_Line4=");
                        strData.Append("&Add_Line5=");
                        strData.Append("&PAN=" + PAN_No);
                        strData.Append("&ChallanNo=");
                        strData.Append("&MinorHeadRadio=");
                        strData.Append("&MajorHeadRadio=");
                        this.strServerResponse = this.Post_HTTPRequest("https://onlineservices.tin.egov-nsdl.com/etaxnew/PopulateBankServlet", strData);
                        if (Regex.IsMatch(this.strServerResponse, "Invalid PAN", RegexOptions.IgnoreCase))
                        {
                            return false;
                        }
                        return true;
                    }
                }
                return false;
            }
            catch
            {
                return false;
            }
        }



        private string Get_HTTPRequest(string strURL)
        {
            SetAllowUnsafeHeaderParsing();
            //ServicePointManager.ServerCertificateValidationCallback = (, , , ) => true;
            //ServicePointManager.ServerCertificateValidationCallback = new RemoteCertificateValidationCallback();


            ServicePointManager.ServerCertificateValidationCallback =
            System.Net.ServicePointManager.ServerCertificateValidationCallback =
            ((sender, certificate, chain, sslPolicyErrors) => true);
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12 | SecurityProtocolType.Tls11;
            this.request = (HttpWebRequest)WebRequest.Create(strURL);
            this.request.KeepAlive = false;
            this.request.Method = "GET";
            this.request.UserAgent = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.57 Safari/537.17";
            this.request.Accept = "text/html";
            this.request.Timeout = 0x3b9aca00;
            if (this.request.CookieContainer == null)
            {
                this.request.CookieContainer = this.objContainer;
            }
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

        private string Post_HTTPRequest(string strURL, StringBuilder strData)
        {
            this.request = (HttpWebRequest)WebRequest.Create(strURL);
            this.request.KeepAlive = false;
            byte[] bytes = null;
            string s = "";
            if (!string.IsNullOrEmpty(Convert.ToString(strData)))
            {
                s = strData.ToString();
                bytes = Encoding.UTF8.GetBytes(s);
            }
            if (!string.IsNullOrEmpty(Convert.ToString(strData)))
            {
                this.request.ContentLength = bytes.Length;
            }
            if (strData != null)
            {
                this.request.Method = "POST";
                this.request.Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8";
                this.request.UserAgent = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.57 Safari/537.17";
                this.request.ContentType = "application/x-www-form-urlencoded";
                this.request.Timeout = 0x3b9aca00;
            }
            if (this.request.CookieContainer == null)
            {
                this.request.CookieContainer = this.objContainer;
            }
            this.request.CookieContainer.Add(this.response.Cookies);
            if (!string.IsNullOrEmpty(Convert.ToString(strData)))
            {
                this.dataStream = this.request.GetRequestStream();
                this.dataStream.Write(bytes, 0, bytes.Length);
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



        public Stream First_Request()
        {
            this.Get_HTTPRequest("https://www.tdscpc.gov.in/app/login.xhtml");
            return this.getCaptchaImage();
        }


        private Dictionary<string, string> RetievePANStatus(string strHTML)
        {
            Dictionary<string, string> dictionary = new Dictionary<string, string>();
            HtmlDocument document = new HtmlDocument();
            document.LoadHtml(strHTML);
            HtmlNodeCollection nodes = document.DocumentNode.SelectNodes("//table[@class=\"userList w990 marginTop10\"]");
            if (nodes != null)
            {
                dictionary.Clear();
                if ((nodes != null) && (nodes.Count > 0))
                {
                    foreach (HtmlNode node2 in (IEnumerable<HtmlNode>)nodes)
                    {
                        int num;
                        HtmlNodeCollection nodes2 = node2.SelectNodes("//td[@id='status']");
                        if ((nodes2 != null) && (nodes2.Count > 0))
                        {
                            num = 0;
                            while (num < nodes2.Count)
                            {
                                dictionary.Add("Status", nodes2[num].InnerText);
                                num++;
                            }
                        }
                        nodes2 = node2.SelectNodes("//td[@id='name']");
                        if ((nodes2 != null) && (nodes2.Count > 0))
                        {
                            for (num = 0; num < nodes2.Count; num++)
                            {
                                dictionary.Add("name", nodes2[num].InnerText);
                            }
                        }
                    }
                }
            }
            return dictionary;
        }

        private string RetrieveElementValue(string strHTML, string StrQuery, string strNode, enmElementType enmElement)
        {
            string innerText = "";
            HtmlDocument document = new HtmlDocument();
            document.LoadHtml(strHTML);
            HtmlNodeCollection nodes = document.DocumentNode.SelectNodes(StrQuery);
            if ((nodes != null) && ((nodes != null) && (nodes.Count > 0)))
            {
                foreach (HtmlNode node2 in (IEnumerable<HtmlNode>)nodes)
                {
                    HtmlNodeCollection nodes2 = node2.SelectNodes(strNode);
                    if ((nodes2 != null) && (nodes2.Count > 0))
                    {
                        for (int i = 0; i < nodes2.Count; i++)
                        {
                            switch (enmElement)
                            {
                                case enmElementType.InnerText:
                                    innerText = nodes2[i].InnerText;
                                    break;

                                case enmElementType.InnerHTML:
                                    innerText = nodes2[i].InnerHtml;
                                    break;

                                case enmElementType.Value:
                                    innerText = nodes2[i].Attributes["value"].Value;
                                    break;

                                case enmElementType.Name:
                                    innerText = nodes2[i].Attributes["name"].Value;
                                    break;
                            }
                        }
                    }
                }
            }
            return innerText;
        }

        public static bool SetAllowUnsafeHeaderParsing()
        {

            return true;
        }

        private Dictionary<string, string> TraceHiddenField(string strHTML, string StrQuery)
        {
            Dictionary<string, string> dictionary = new Dictionary<string, string>();
            HtmlDocument document = new HtmlDocument();
            document.LoadHtml(strHTML);
            HtmlNodeCollection nodes = document.DocumentNode.SelectNodes(StrQuery);
            if (nodes != null)
            {
                dictionary.Clear();
                if ((nodes != null) && (nodes.Count > 0))
                {
                    foreach (HtmlNode node2 in (IEnumerable<HtmlNode>)nodes)
                    {
                        HtmlNodeCollection nodes2 = node2.SelectNodes("//input[@type='hidden']");
                        if ((nodes2 != null) && (nodes2.Count > 0))
                        {
                            for (int i = 0; i < nodes2.Count; i++)
                            {
                                if (!dictionary.ContainsKey(nodes2[i].Attributes["name"].Value))
                                {
                                    dictionary.Add(nodes2[i].Attributes["name"].Value, nodes2[i].Attributes["value"].Value);
                                }
                            }
                        }
                    }
                }
            }
            return dictionary;
        }

        private Dictionary<string, string> TraceViewStateData(string strHTML, string StrQuery)
        {
            Dictionary<string, string> dictionary = new Dictionary<string, string>();
            HtmlDocument document = new HtmlDocument();
            document.LoadHtml(strHTML);
            HtmlNodeCollection nodes = document.DocumentNode.SelectNodes(StrQuery);
            if (nodes != null)
            {
                dictionary.Clear();
                if ((nodes != null) && (nodes.Count > 0))
                {
                    foreach (HtmlNode node2 in (IEnumerable<HtmlNode>)nodes)
                    {
                        HtmlNodeCollection nodes2 = node2.SelectNodes("//input[@type='hidden']");
                        if ((nodes2 != null) && (nodes2.Count > 0))
                        {
                            for (int i = 0; i < nodes2.Count; i++)
                            {
                                if (!dictionary.ContainsKey(nodes2[i].Attributes["name"].Value))
                                {
                                    dictionary.Add(nodes2[i].Attributes["name"].Value, nodes2[i].Attributes["value"].Value);
                                }
                            }
                        }
                    }
                }
            }
            return dictionary;
        }

        public eResponse VerifyPANDetails(string strPan, string strCaptchaImage)
        {
            StringBuilder strData = new StringBuilder();
            eResponse response = new eResponse();
            PAN details = new PAN();
            strData.Append("requestId=");
            strData.Append("&panOfDeductee=" + strPan);
            strData.Append("&captchaCode=" + strCaptchaImage);
            string strServerResponse = this.Post_HTTPRequest("https://incometaxindiaefiling.gov.in/e-Filing/Services/KnowYourJurisdiction.html ", strData);
            response = this.IsServerError(strServerResponse, "//div[@class=\"error\"]");
            if (response.Respons == eRes.Failed)
            {
                response.Respons = eRes.Failed;
                return response;
            }
            HtmlDocument document = new HtmlDocument();
            document.LoadHtml(strServerResponse);
            if (Regex.IsMatch(strServerResponse, "PAN does not exist"))
            {
                response.Message = "PAN does not exist";
                response.Respons = eRes.Failed;
                return response;
            }
            HtmlNode documentNode = document.DocumentNode;
            string str2 = "";
            string str3 = "";
            response.Respons = eRes.Success;
            foreach (HtmlNode node2 in (IEnumerable<HtmlNode>)document.DocumentNode.SelectNodes("//table[@class='grid']//tr//td"))
            {
                if (str2 != "")
                {
                    str3 = node2.InnerText.Replace("\n", "").Replace("\r", "").Replace("\t", "");
                    if (str2.ToUpper() == "SURNAME")
                    {
                        details.Surname = str3;
                    }
                    if (str2.ToUpper() == "MIDDLE NAME")
                    {
                        details.MiddleName = str3;
                    }
                    if (str2.ToUpper() == "FIRST NAME")
                    {
                        details.FirstName = str3;
                    }
                    if (str2.ToUpper() == "AREA CODE")
                    {
                        details.AreaCode = str3;
                    }
                    if (str2.ToUpper() == "AO TYPE")
                    {
                        details.AOType = str3;
                    }
                    if (str2.ToUpper() == "RANGE CODE")
                    {
                        details.RangeCode = str3;
                    }
                    if (str2.ToUpper() == "AO NUMBER")
                    {
                        details.AONumber = str3;
                    }
                    if (str2.ToUpper() == "JURISDICTION")
                    {
                        details.Jurisdiction = str3;
                    }
                    if (str2.ToUpper() == "BUILDING NAME")
                    {
                        details.BuildingName = str3;
                    }
                }
                str2 = node2.InnerText.Replace("\n", "").Replace("\r", "").Replace("\t", "");
            }
            response.CustomeTypes = details;
            return response;
        }


        public TracesResponce RequestForOTPValidation(string strOTP, Dictionary<string, string> objNameval)
        {
            StringBuilder sbData = new StringBuilder();
            TracesResponce response = new TracesResponce();

            sbData.Append("mobilePin=" + strOTP);
            foreach (KeyValuePair<string, string> pair in objNameval)
            {
                sbData.Append("&" + pair.Key + "=" + HttpUtility.UrlEncode(pair.Value));
            }
            string strServerResponse = this.makeHTTPPostRequest("https://www1.incometaxindiaefiling.gov.in/e-FilingGS/Services/KnowYourTanVerifyOtp.html", sbData);
            if (this.IsStringExists(strServerResponse, "//form[@id=\"KnowYourTanVerify\"]"))
            {
                if (Regex.IsMatch(strServerResponse, "No records found."))
                {
                    response.Message = "No records found.";
                    response.eResps = eresposenum.Failed;
                    return response;
                }
                response.Message = "No records found. Please try again";
                response.eResps = eresposenum.SessionTimeout;
                return response;
            }
            if (Regex.IsMatch(strServerResponse, "Session has expired!"))
            {
                response.Message = "Session has expired! Please try again";
                response.eResps = eresposenum.SessionTimeout;
                return response;
            }
            //TanDetails details = new TanDetails();
            HtmlDocument document = new HtmlDocument();
            document.LoadHtml(strServerResponse);
            HtmlNode documentNode = document.DocumentNode;
            response.eResps = eresposenum.Success;
            foreach (HtmlNode node2 in (IEnumerable<HtmlNode>)document.DocumentNode.SelectNodes("//table[@class='grid ']//tr//td"))
            {
                string str2 = node2.ChildNodes[1].InnerText.Trim();
                if (str2 != "")
                {
                    string str3 = node2.ChildNodes[3].InnerText.Trim().Replace("\t", "").Replace("\r\n", " ");
                    //if (str2.ToUpper() == "TAN")
                    //{
                    //    details.TAN = str3;
                    //}
                    //if (str2.ToUpper() == "CATEGORY OF DEDUCTOR")
                    //{
                    //    details.DeducteeCategory = str3;
                    //}
                    //if (str2.ToUpper() == "NAME")
                    //{
                    //    details.Name = str3;
                    //}
                    //if (str2.ToUpper() == "ADDRESS")
                    //{
                    //    details.Address = str3;
                    //}
                    //if (str2.ToUpper() == "PAN")
                    //{
                    //    details.PAN = str3;
                    //}
                    //if (str2.ToUpper() == "STATUS OF TAN")
                    //{
                    //    details.StatusOfTAN = str3;
                    //}
                    //if (str2.ToUpper() == "EMAIL ID 1")
                    //{
                    //    details.EmailID1 = str3;
                    //}
                    //if (str2.ToUpper() == "EMAIL ID 2.")
                    //{
                    //    details.EmailID2 = str3;
                    //}
                    //if (str2.ToUpper() == "AREA CODE")
                    //{
                    //    details.AreaCode = str3;
                    //}
                    //if (str2.ToUpper() == "AO TYPE")
                    //{
                    //    details.AOType = str3;
                    //}
                    //if (str2.ToUpper() == "RANGE CODE")
                    //{
                    //    details.RangeCode = str3;
                    //}
                    //if (str2.ToUpper() == "AO NUMBER")
                    //{
                    //    details.AONumber = str3;
                    //}
                    //if (str2.ToUpper() == "AO DESCRIPTION")
                    //{
                    //    details.AODescription = str3;
                    //}
                    //if (str2.ToUpper() == "BUILDING NAME")
                    //{
                    //    details.BuildingName = str3;
                    //}
                    //if (str2.ToUpper() == "EMAIL ID")
                    //{
                    //    details.EmailID = str3;
                    //}
                }
            }
            //response.CustomeTypes = details;
            return response;
        }

        private string makeHTTPGetRequest(string strURL)
        {
            SetAllowUnsafeHeaderParsing();
            //if (<> c.<> 9__57_0 == null)
            //{
            //    RemoteCertificateValidationCallback callback1 = <> c.<> 9__57_0;
            //}
            //ServicePointManager.ServerCertificateValidationCallback = <> c.<> 9__57_0 = new RemoteCertificateValidationCallback(<> c.<> 9.< makeHTTPGetRequest > b__57_0);
            //ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12 | SecurityProtocolType.Tls11;

            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12 | SecurityProtocolType.Tls11;
            this.request = (HttpWebRequest)WebRequest.Create(strURL);
            this.request.KeepAlive = true;
            ServicePointManager.DefaultConnectionLimit = 100;
            ServicePointManager.MaxServicePointIdleTime = 0x1388;

            this.request = (HttpWebRequest)WebRequest.Create(strURL);
            this.request.KeepAlive = true;
            this.request.Method = "GET";
            this.request.UserAgent = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.57 Safari/537.17";
            this.request.Accept = "text/html";
            this.request.Timeout = 0x3b9aca00;
            if (this.request.CookieContainer == null)
            {
                this.request.CookieContainer = this.objContainer;
            }
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
                PAN details = new PAN();
                details.PAN_no = strPAN;
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


        private string RetrievePANName(string strHTML)
        {
            string innerText = "NOT AVAILABLE";
            HtmlDocument document = new HtmlDocument();
            document.LoadHtml(strHTML);
            HtmlNodeCollection nodes = document.DocumentNode.SelectNodes("//td[@id='name']");
            if ((nodes != null) && (nodes.Count > 0))
            {
                for (int i = 0; i < nodes.Count; i++)
                {
                    innerText = nodes[i].InnerText;
                }
            }
            return innerText;
        }

        private string makeHTTPPostRequest(string strURL, StringBuilder sbData)
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12 | SecurityProtocolType.Tls11;
            this.request = (HttpWebRequest)WebRequest.Create(strURL);
            this.request.KeepAlive = true;
            ServicePointManager.DefaultConnectionLimit = 100;
            ServicePointManager.MaxServicePointIdleTime = 0x1388;
            byte[] bytes = null;
            string s = "";
            if (!string.IsNullOrEmpty(Convert.ToString(sbData)))
            {
                s = sbData.ToString();
                bytes = Encoding.UTF8.GetBytes(s);
            }
            if (!string.IsNullOrEmpty(Convert.ToString(sbData)))
            {
                this.request.ContentLength = bytes.Length;
            }
            if (sbData != null)
            {
                this.request.Method = "POST";
                this.request.Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,*;q=0.8";
                this.request.UserAgent = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.57 Safari/537.17";
                this.request.ContentType = "application/x-www-form-urlencoded";
                this.request.Timeout = 0x3b9aca00;
            }
            if (this.request.CookieContainer == null)
            {
                this.request.CookieContainer = this.objContainer;
            }
            if (this.response != null)
            {
                this.request.CookieContainer.Add(this.response.Cookies);
            }
            if (!string.IsNullOrEmpty(Convert.ToString(sbData)))
            {
                this.dataStream = this.request.GetRequestStream();
                this.dataStream.Write(bytes, 0, bytes.Length);
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

        private string makeHTTPPostRequest1(string strURL, StringBuilder sbData)
        {
            this.request = (HttpWebRequest)WebRequest.Create(strURL);
            this.request.Method = "POST";
            this.request.Credentials = CredentialCache.DefaultCredentials;
            this.request.ServicePoint.Expect100Continue = false;
            byte[] bytes = new ASCIIEncoding().GetBytes(sbData.ToString());
            this.request.ContentType = "application/x-www-form-urlencoded";
            this.request.ContentLength = bytes.Length;
            if (sbData != null)
            {
                object[] args = new object[] { "Host", "www.tdscpc.gov.in" };
                this.request.Headers.GetType().InvokeMember("ChangeInternal", BindingFlags.InvokeMethod | BindingFlags.NonPublic | BindingFlags.Instance, null, this.request.Headers, args);
                this.request.Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,*;q=0.8";
                this.request.UserAgent = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.152 Safari/537.22";
                this.request.Headers.Add("Accept-Encoding: gzip,deflate,sdch");
                this.request.Headers.Add("Accept-Language: en-US,en;q=0.8");
                this.request.Headers.Add("Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.3");
                this.request.Headers.Add("Cache-Control: max-age=0");
                this.request.Headers.Add("Origin: https://www.tdscpc.gov.in");
                this.request.Referer = "https://www.tdscpc.gov.in/app/ded/panverify.xhtml";
                this.request.Timeout = 0x186a0;
                this.request.ReadWriteTimeout = 0x3b9aca00;
                object[] objArray2 = new object[] { "Connection", "Keep-Alive" };
                this.request.Headers.GetType().InvokeMember("ChangeInternal", BindingFlags.InvokeMethod | BindingFlags.NonPublic | BindingFlags.Instance, Type.DefaultBinder, this.request.Headers, objArray2);
            }
            if (this.request.CookieContainer == null)
            {
                this.request.CookieContainer = this.objContainer;
            }
            this.request.CookieContainer.Add(new Uri("https://www.tdscpc.gov.in/app/"), this.response.Cookies);
            this.request.GetRequestStream().Write(bytes, 0, bytes.Length);
            this.response = (HttpWebResponse)this.request.GetResponse();
            string str = this.response.ResponseUri.ToString();
            if (!string.IsNullOrEmpty(str))
            {
                str = str.Substring(str.LastIndexOf("/") + 1);
            }
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
        public string PAN_Verification(string PAN)
        {
            if (PAN.Trim() == "")
            {
                return "";
            }
            if (PAN.Length != 10)
            {
                return "";
            }
            if (PAN.Trim() == "PANNOTAVBL")
            {
                return "";
            }
            if (PAN.Trim() == "PANAPPLIED")
            {
                return "";
            }
            if (PAN.Trim() == "PANNOTREQD")
            {
                return "";
            }

            return PAN;
        }

        public bool Trace_CheckInternetConnectivty()
        {
            try
            {
                IPHostEntry hostEntry = Dns.GetHostEntry("www.google.co.in");
                return true;
            }
            catch
            {
                return false;

            }
        }



        public static string Trace_DownloadedFileName
        {
            get
            {
                return DownloadedFileName;
            }
            set
            {
                DownloadedFileName = value;
            }
        }

        public static string Trace_GetPAN_Verification
        {
            get
            {
                return GetPAN_Verification;
            }
            set
            {
                GetPAN_Verification = value;
            }
        }


        public static string Trace_PAN_Verify
        {
            get
            {
                return PANVerify;
            }
            set
            {
                PANVerify = value;
            }
        }



        public static string Trace_Download_File_Path
        {
            get
            {
                return strDownloadPath;
            }
            set
            {
                strDownloadPath = value;
            }
        }

        public static bool Trace_File_DownloadStatus
        {
            get
            {
                return blnDownloadStaus;
            }
            set
            {
                blnDownloadStaus = value;
            }
        }




        private enum enmElementType
        {
            InnerText,
            InnerHTML,
            Value,
            Name
        }
    }
}

