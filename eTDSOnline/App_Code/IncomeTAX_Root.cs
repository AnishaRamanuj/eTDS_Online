using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for IncomeTAX_Root
/// </summary>
public class IncomeTAX_Root
{
    public IncomeTAX_Headers header { get; set; }

    public List<IncomeTAX_Message> messages { get; set; }

    public List<object> errors { get; set; }

    public string reqId { get; set; }

    public string entity { get; set; }

    public string entityType { get; set; }

    public string role { get; set; }

    public string userType { get; set; }

    public string uidValdtnFlg { get; set; }

    public string passValdtnFlg { get; set; }

    public string mobileNo { get; set; }

    public string email { get; set; }

    public string aadhaarMobileValidated { get; set; }

    public string secAccssMsg { get; set; }

    public string secLoginOptions { get; set; }

    public string contactPan { get; set; }

    public string contactEmail { get; set; }

    public string contactMobile { get; set; }

    public string lastLoginSuccessFlag { get; set; }

    public string clientIp { get; set; }

    public string exemptedPan { get; set; }

    public string userConsent { get; set; }

    public string imgByte { get; set; }

    public string csiResponse { get; set; }

    public string userId { get; set; }

    public string isActive { get; set; }

    public string transactionNo { get; set; }

    public string type { get; set; }

    public string RefId { get; set; }
}