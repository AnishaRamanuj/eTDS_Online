
using Microsoft.Win32;
using System;
using System.Collections;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Management;
using System.Net;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Security.Principal;
using System.Text;
using System.Text.RegularExpressions;
using System.Xml;



  public class eTDS
  {
    private static int GroupId = 0;
    private static long ViewCompanyId = 0;


    private static string TAN = "";
    private static string TokenNo = "";

    private static bool ServerDisconnectedMessage = true;
    private static bool VerifyPANNewDeductee = false;
    private static string TracesFAYear = "";
    private static string TracesPRN_NO = "";
    private static string TracesQuarter = "";

    private static string strTDSFilePath = "";
    private static string strHashvalue = "";
    private static string strDownloadPath = "";
    private static bool blnDownloadStaus = false;
    private static bool blnShowUpdateMessage = false;

    private static string TracesPassword = "";

    private static int ClientServerMachine = 1;
    private static string TracesTAN = "";
    private static string ProxySettings = "";
    private static string ProxyAddress = "";
    private static string ProxyPort = "";
    private static string ProxyUsername = "";
    private static string ProxyPassword = "";
    private static string DownloadedFileName = "";
    private static string GetPANforVerification = "";
    private static string GetTANLoadTRACES = "";
    private static string Password = "";
    private static string TracesUserID = "";
    private static bool EnableDeducteeFirst = false;
    private static bool AutoCalculateTdsRate = false;
    private static bool EnableBrowserLoginTraces = false;
    private static string XmlConnectionFileNameServer = "ConnectionInfo.xml";

    private string strSQL = string.Empty;

    public bool blnFetchData = true;
    private string[,] strArray;
    private const uint NERR_Success = 0;
    //private static Form frmCurrentForm;

    [DllImport("netapi32.dll")]
    private static extern uint NetApiBufferFree(IntPtr Buffer);

    [DllImport("netapi32.dll", CharSet = CharSet.Unicode)]
    private static extern uint NetRemoteTOD(string UncServerName, ref IntPtr BufferPtr);




    public string T_WriteField(string str)
    {
      return str.Trim() + "^";
    }

    public string T_WriteField(string str, string strFormat)
    {
      return string.Format("{0:" + strFormat + "}", (object) Convert.ToDouble(str.Trim() == "" ? "0" : str.Trim())) + "^";
    }

    public string T_WriteBlankField(int intOccurence, string strRepeatCharacter)
    {
      string str = "";
      if (intOccurence == 0)
        return "";
      for (int index = 1; index <= intOccurence; ++index)
        str += strRepeatCharacter;
      return str;
    }

    public bool J_IsProcessOpen(string ProcessName)
    {
      foreach (Process process in Process.GetProcesses())
      {
        if (process.ProcessName.Contains(ProcessName))
          return true;
      }
      return false;
    }

    //public string J_ConvertToIntDDMMYYYY(MaskedTextBox DateMaskedTextBox)
    //{
    //  return this.J_ConvertToIntDDMMYYYY(DateMaskedTextBox.Text);
    //}

    public string J_ConvertToIntDDMMYYYY(string date)
    {
      return date == "" || date == null ? "" : Convert.ToString(date.Substring(0, 2) + date.Substring(3, 2) + date.Substring(6, 4));
    }



    public string T_ReplaceSpecialCharacters(string StrText, string StrReplaceText)
    {
      string[] strArray = new string[21]
      {
        ",",
        ".",
        "/",
        "!",
        "@",
        "#",
        "$",
        "%",
        "^",
        "&",
        "*",
        "'",
        "\"",
        ";",
        "_",
        "(",
        ")",
        ":",
        "|",
        "[",
        "]"
      };
      for (int index = 0; index < strArray.Length; ++index)
      {
        if (StrText.Contains(strArray[index]))
          StrText = StrText.Replace(strArray[index], StrReplaceText);
      }
      return StrText;
    }

    public string RemoveSpecialCharacters(string str)
    {
      return Regex.Replace(str, "[^a-zA-Z0-9_. ]", "", RegexOptions.Compiled);
    }

    private static string[] SplitWords(string s)
    {
      return Regex.Split(s, "\\W+");
    }

    public string T_ReplaceAmpersand(string StrText)
    {
      return StrText.Replace("&", "&&");
    }

    public bool T_DetectCaret(string StrText, string FindChar)
    {
      return StrText.IndexOf(FindChar) >= 0;
    }

    public bool T_CheckJREInstalled()
    {
      try
      {
        Process process = new Process();
        process.StartInfo.UseShellExecute = false;
        process.StartInfo.RedirectStandardOutput = true;
        process.StartInfo.RedirectStandardError = true;
        process.StartInfo.CreateNoWindow = true;
        process.StartInfo.FileName = "java";
        process.StartInfo.Arguments = "-version";
        process.Start();
        process.StandardOutput.ReadToEnd();
        process.StandardError.ReadToEnd();
        process.WaitForExit();
        return true;
      }
      catch
      {
        return false;
      }
    }

 

    public DateTime GetFirstDayOfMonth(DateTime dtDate)
    {
      DateTime dateTime = dtDate;
      dateTime = dateTime.AddDays((double) -(dateTime.Day - 1));
      return dateTime;
    }

    public DateTime GetFirstDayOfMonth(int iMonth)
    {
      DateTime dateTime = new DateTime(DateTime.Now.Year, iMonth, 1);
      dateTime = dateTime.AddDays((double) -(dateTime.Day - 1));
      return dateTime;
    }

    public DateTime GetFirstDayOfMonth(int iMonth, int Year)
    {
      DateTime dateTime = new DateTime(Year, iMonth, 1);
      dateTime = dateTime.AddDays((double) -(dateTime.Day - 1));
      return dateTime;
    }

    public DateTime GetLastDayOfMonth(DateTime dtDate)
    {
      DateTime dateTime = dtDate;
      dateTime = dateTime.AddMonths(1);
      dateTime = dateTime.AddDays((double) -dateTime.Day);
      return dateTime;
    }

    public DateTime GetLastDayOfMonth(int iMonth, int Year)
    {
      DateTime dateTime = new DateTime(Year, iMonth, 1);
      dateTime = dateTime.AddMonths(1);
      dateTime = dateTime.AddDays((double) -dateTime.Day);
      return dateTime;
    }

    public DateTime GetLastDayOfMonth(int iMonth)
    {
      DateTime dateTime = new DateTime(DateTime.Now.Year, iMonth, 1);
      dateTime = dateTime.AddMonths(1);
      dateTime = dateTime.AddDays((double) -dateTime.Day);
      return dateTime;
    }

    public static bool T_BROWSER_LOGIN_TRACES
    {
        get
        {
            return EnableBrowserLoginTraces;
        }
        set
        {
            EnableBrowserLoginTraces = value;
        }
    }

    public static string T_TracesUserID
    {
        get
        {
            return TracesUserID;
        }
        set
        {
            TracesUserID = value;
        }
    }

    public static string T_TracesPassword
    {
        get
        {
            return TracesPassword;
        }
        set
        {
            TracesPassword = value;
        }
    }

    public static string T_TracesFAYear
    {
        get
        {
            return TracesFAYear;
        }
        set
        {
            TracesFAYear = value;
        }
    }
    public static string T_TracesPRN_NO
    {
        get
        {
            return TracesPRN_NO;
        }
        set
        {
            TracesPRN_NO = value;
        }
    }

    public static string T_TracesQuarter
    {
        get
        {
            return TracesQuarter;
        }
        set
        {
            TracesQuarter = value;
        }
    }
    public static string T_TracesTAN
    {
        get
        {
            return TracesTAN;
        }
        set
        {
            TracesTAN = value;
        }
    }

    public bool T_ValidateEmail(string Email)
    {
      return true;
    }



    public string T_GetMotherBoardID()
    {
      return "";
    }



    public string T_GeneratePassword(string strCurrentDate)
    {
      char[] charArray = strCurrentDate.ToCharArray();
      Array.Reverse((Array) charArray);
      return new string(charArray);
    }



    public bool T_CheckChallanAmount(string Amount)
    {
      return Convert.ToDouble(Amount) % 1.0 == 0.0;
    }

    public string T_GenerateRandomNumbers()
    {
      return new Random((int) DateTime.Now.Ticks).Next(10000000, 99999999).ToString();
    }


    public void CreateZIPFile(string InputFilePath, string ZIPFilePath)
    {
    }


    public static int T_pGroupId
    {
      get
      {
        return  eTDS.GroupId;
      }
      set
      {
         eTDS.GroupId = value;
      }
    }

    public static long T_pCompanyId
    {
      get
      {
        return  eTDS.ViewCompanyId;
      }
      set
      {
         eTDS.ViewCompanyId = value;
      }
    }



 
    public bool T_CheckInternetConnectivty()
    {
        try
        {
            Dns.GetHostEntry("www.google.com");
            return true;
        }
        catch
        {
            return eTDS.T_ProxySettings == "Yes" && this.T_CheckPROXY();
        }
    }

    public bool T_CheckPROXY()
    {
        try
        {
            if (WebRequest.DefaultWebProxy.GetProxy(new Uri("http://www.eTDS.com")).ToString() == "http://www.eTDS.com/")
                return false;
            if (eTDS.T_ProxySettings == "Yes")
                return this.T_ConnectWebProxy() && this.T_ConnectFileTransferProxy();
            //int num = (int)new TrnProxySettings().ShowDialog();
            return false;
        }
        catch (Exception ex)
        {
            return false;
        }
    }

    public bool T_ConnectWebProxy()
    {
        try
        {
            WebProxy webProxy = new WebProxy("http://" + eTDS.T_ProxyAddress + "/", this.J_ReturnInt32Value(eTDS.T_ProxyPort));
            if (eTDS.T_ProxyUsername != "")
                webProxy.Credentials = (ICredentials)new NetworkCredential(eTDS.T_ProxyUsername, eTDS.T_ProxyPassword);
            else
                webProxy.UseDefaultCredentials = true;
            WebRequest webRequest = WebRequest.Create("http://www.eTDS.com");
            webRequest.Credentials = (ICredentials)new NetworkCredential(eTDS.T_ProxyUsername, eTDS.T_ProxyPassword);
            webRequest.Proxy.Credentials = (ICredentials)new NetworkCredential(eTDS.T_ProxyUsername, eTDS.T_ProxyPassword);
            webRequest.Proxy = (IWebProxy)webProxy;
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
    }

    public bool T_ConnectFileTransferProxy()
    {
        try
        {
            WebProxy webProxy = new WebProxy("http://" + eTDS.T_ProxyAddress + "/", this.J_ReturnInt32Value(eTDS.T_ProxyPort));
            if (eTDS.T_ProxyUsername != "")
                webProxy.Credentials = (ICredentials)new NetworkCredential(eTDS.T_ProxyUsername, eTDS.T_ProxyPassword);
            else
                webProxy.UseDefaultCredentials = true;
            WebRequest.Create("http://www.eTDS.com").Proxy = (IWebProxy)webProxy;
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
    }

    public int J_ReturnInt32Value(string strText)
    {
        return strText == "" || strText == null || strText == "-" ? 0 : Convert.ToInt32(strText.Trim() == "" ? "0" : strText.Trim());
    }




    

    public static string T_pTDSFilePath
    {
      get
      {
        return  eTDS.strTDSFilePath;
      }
      set
      {
         eTDS.strTDSFilePath = value;
      }
    }

    public static string T_pHashValue
    {
      get
      {
        return  eTDS.strHashvalue;
      }
      set
      {
         eTDS.strHashvalue = value;
      }
    }

    //public static Form T_pCurrentForm
    //{
    //  get
    //  {
    //    return  eTDS.frmCurrentForm;
    //  }
    //  set
    //  {
    //     eTDS.frmCurrentForm = value;
    //  }
    //}



    public static string T_pDownloadPath
    {
      get
      {
        return  eTDS.strDownloadPath;
      }
      set
      {
         eTDS.strDownloadPath = value;
      }
    }

    public static bool T_pDownloadStatus
    {
      get
      {
        return  eTDS.blnDownloadStaus;
      }
      set
      {
         eTDS.blnDownloadStaus = value;
      }
    }

    public static bool T_pShowUpdateMessage
    {
      get
      {
        return  eTDS.blnShowUpdateMessage;
      }
      set
      {
         eTDS.blnShowUpdateMessage = value;
      }
    }



    

    public static string T_ProxySettings
    {
      get
      {
        return  eTDS.ProxySettings;
      }
      set
      {
         eTDS.ProxySettings = value;
      }
    }

    public static string T_ProxyAddress
    {
      get
      {
        return  eTDS.ProxyAddress;
      }
      set
      {
         eTDS.ProxyAddress = value;
      }
    }

    public static string T_ProxyPort
    {
      get
      {
        return  eTDS.ProxyPort;
      }
      set
      {
         eTDS.ProxyPort = value;
      }
    }

    public static string T_ProxyUsername
    {
      get
      {
        return  eTDS.ProxyUsername;
      }
      set
      {
         eTDS.ProxyUsername = value;
      }
    }

    public static string T_ProxyPassword
    {
      get
      {
        return  eTDS.ProxyPassword;
      }
      set
      {
         eTDS.ProxyPassword = value;
      }
    }

    public static string T_Password
    {
      get
      {
        return  eTDS.Password;
      }
      set
      {
         eTDS.Password = value;
      }
    }


    public static string T_GetPANforVerification
    {
      get
      {
        return  eTDS.GetPANforVerification;
      }
      set
      {
         eTDS.GetPANforVerification = value;
      }
    }

    public static string T_GetTANLoadTRACES
    {
      get
      {
        return  eTDS.GetTANLoadTRACES;
      }
      set
      {
         eTDS.GetTANLoadTRACES = value;
      }
    }



    public static string T_DownloadedFileNameFromTraces
    {
      get
      {
        return  eTDS.DownloadedFileName;
      }
      set
      {
         eTDS.DownloadedFileName = value;
      }
    }


    public static string T_pTAN
    {
      get
      {
        return  eTDS.TAN;
      }
      set
      {
         eTDS.TAN = value;
      }
    }

    public static bool T_pVerifyPANNewDeductee
    {
      get
      {
        return  eTDS.VerifyPANNewDeductee;
      }
      set
      {
         eTDS.VerifyPANNewDeductee = value;
      }
    }


    public static bool T_EnableDeducteeFirst
    {
      get
      {
        return  eTDS.EnableDeducteeFirst;
      }
      set
      {
         eTDS.EnableDeducteeFirst = value;
      }
    }


    public static int T_ClientServerMachine
    {
      get
      {
        return  eTDS.ClientServerMachine;
      }
      set
      {
         eTDS.ClientServerMachine = value;
      }
    }


    public static string T_XmlConnectionFileNameServer
    {
      get
      {
        return  eTDS.XmlConnectionFileNameServer;
      }
      set
      {
         eTDS.XmlConnectionFileNameServer = value;
      }
    }


    public static bool T_ServerDisconnectedMessage
    {
      get
      {
        return  eTDS.ServerDisconnectedMessage;
      }
      set
      {
         eTDS.ServerDisconnectedMessage = value;
      }
    }

    public static bool T_EnableAutoCalculateTdsRate
    {
      get
      {
        return  eTDS.AutoCalculateTdsRate;
      }
      set
      {
         eTDS.AutoCalculateTdsRate = value;
      }
    }


    private struct TIME_OF_DAY_INFO
    {
      public uint tod_elapsedt;
      public uint tod_msecs;
      public uint tod_hours;
      public uint tod_mins;
      public uint tod_secs;
      public uint tod_hunds;
      public uint tod_timezone;
      public uint tod_tinterval;
      public uint tod_day;
      public uint tod_month;
      public uint tod_year;
      public uint tod_weekday;
    }
  }

