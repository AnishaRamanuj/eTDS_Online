<%@ WebService Language="C#" Class="Correction" %>

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
public class Correction  : System.Web.Services.WebService {

    Bal_Correction obj_Bal_Correction = new Bal_Correction();

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetDeductee(objforCorrection cobj)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(cobj.ConnectionString))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = cobj.ConnectionString;
        }
        IEnumerable<objforCorrection> tbl = obj_Bal_Correction.Get_Deductee(cobj);
        return new JavaScriptSerializer().Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Get_Correction(objforCorrection cobj)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(cobj.ConnectionString))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = cobj.ConnectionString;
        }
        IEnumerable<objforCorrection> tbl = obj_Bal_Correction.Get_Correction(cobj);
        return new JavaScriptSerializer().Serialize(tbl);
    }

    //[System.Web.Services.WebMethod(EnableSession = true)]
    //public string Get_Challan_Correction(objforChallancorrection cobj)
    //{
    //    if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(cobj.ConnectionString))
    //    {
    //        HttpContext.Current.Session["Financial_Year_Text"] = cobj.ConnectionString;
    //    }
    //    IEnumerable<objforChallancorrection> tbl = obj_Bal_Correction.Get_Challan_Correction(cobj);
    //    return new JavaScriptSerializer().Serialize(tbl);
    //}

    //[System.Web.Services.WebMethod(EnableSession = true)]
    //public string Update_Correction(objforCorrection cobj)
    //{
    //    if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(cobj.ConnectionString))
    //    {
    //        HttpContext.Current.Session["Financial_Year_Text"] = cobj.ConnectionString;
    //    }
    //    IEnumerable<objforCorrection> tbl = obj_Bal_Correction.Get_Correction_Update(cobj);
    //    return new JavaScriptSerializer().Serialize(tbl);
    //}
}