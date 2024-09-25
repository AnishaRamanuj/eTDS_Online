<%@ WebService Language="C#" Class="Ws_Form26Q" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using BusinessLayer;
using CommonLibrary;
using System.Collections.Generic;
using System.Web.Script.Serialization;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class Ws_Form26Q : System.Web.Services.WebService
{

    Bal_Form26Q obj_Bal_Form26Q = new Bal_Form26Q();

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetchallannAmt(objChallanDatenamt cobj)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(cobj.ConnectionString))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = cobj.ConnectionString;
        }
        IEnumerable<ChallanDatenamt> tbl = obj_Bal_Form26Q.Get_Challan_Amt(cobj);
        return new JavaScriptSerializer().Serialize(tbl);
    }
}