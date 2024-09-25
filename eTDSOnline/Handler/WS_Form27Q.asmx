<%@ WebService Language="C#" Class="WS_Form27Q" %>

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
public class WS_Form27Q  : System.Web.Services.WebService {

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetChallanDetails(objChallanDetails_27Q obj)
    {

        Bal_Form27Q obj_Bal_Form27Q = new Bal_Form27Q();

        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(obj.ConnectionString))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = obj.ConnectionString;
        }
        IEnumerable<objChallanDetails_27Q> tbl = obj_Bal_Form27Q.Get_Challan_Detail(obj);
        return new JavaScriptSerializer().Serialize(tbl);
    }

}