﻿


  public class LoginTraces
  {
    private string strUserID = "";
    private string strPassword = "";
    private string strTAN = "";
    private string strCaptchaCode = "";
    private string strCookie = "";

    public string UserID
    {
      get
      {
        return this.strUserID;
      }
      set
      {
        this.strUserID = value;
      }
    }

    public string Password
    {
      get
      {
        return this.strPassword;
      }
      set
      {
        this.strPassword = value;
      }
    }

    public string TAN
    {
      get
      {
        return this.strTAN;
      }
      set
      {
        this.strTAN = value;
      }
    }

    public string CaptchaCode
    {
      get
      {
        return this.strCaptchaCode;
      }
      set
      {
        this.strCaptchaCode = value;
      }
    }
    public string Cookie
    {
        get
        {
            return this.strCookie;
        }
        set
        {
            this.strCookie = value;
        }
    }
  }

