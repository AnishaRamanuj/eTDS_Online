<%@ WebService Language="C#" Class="WS_From27EQ" %>

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

public class WS_From27EQ  : System.Web.Services.WebService
{
    [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetChallanDetails(objChallanDetails obj)
    {
              Bal_Form27EQ obj_Bal_Form27EQ = new Bal_Form27EQ();
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(obj.ConnectionString))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = obj.ConnectionString;
        }
        IEnumerable<objChallanDetails> tbl = obj_Bal_Form27EQ.Get_Challan_Detail(obj);
        return new JavaScriptSerializer().Serialize(tbl);
    }

} 