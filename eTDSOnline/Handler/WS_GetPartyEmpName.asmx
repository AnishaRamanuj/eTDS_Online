<%@ WebService Language="C#" Class="WS_GetPartyEmpName" %>
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
public class WS_GetPartyEmpName : System.Web.Services.WebService
{
    BAL_GetPartyEmpName obj_BAL_GetPartyEmpName = new BAL_GetPartyEmpName();

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetPartyEmpName(objPartyEmpName cobj)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(cobj.ConnectionString))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = cobj.ConnectionString;
        }
        IEnumerable<PartyEmpName> tbl = obj_BAL_GetPartyEmpName.Get_PartyEmpName(cobj);
        return new JavaScriptSerializer().Serialize(tbl);
    }

   
}