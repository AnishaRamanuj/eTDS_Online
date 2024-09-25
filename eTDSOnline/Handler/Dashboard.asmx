<%@ WebService Language="C#" Class="Dashboard" %>

using System;
using System.Web;
using System.Web.Services;
using System.Data;
using CommonLibrary;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using System.Globalization;
using DataLayer;
using BusinessLayer;
using System.IO;
using Ionic.Zip;


[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class Dashboard : System.Web.Services.WebService {

    public static CultureInfo ci = new CultureInfo("en-GB");
    BAL_Dashboard objBAL = new BAL_Dashboard();


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetonLoad(int compid, string Q, string F, string Conn)
    {
        try
        {
            if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
            {
                HttpContext.Current.Session["Financial_Year_Text"] = Conn;
            }

            HttpContext.Current.Session["Qtr"] = Q;
            HttpContext.Current.Session["frm"] = F;

            string path = Server.MapPath("~/eReturns/Regular");
            if (Directory.Exists(path))
            {
            }
            tbl_Dashboard obj = new tbl_Dashboard();
            obj.Formtype = F;
            obj.Quater = Q;
            obj.compid = compid;

            IEnumerable<tbl_Dashboard> tbl = objBAL.BAL_DashBoard(obj);
            return new JavaScriptSerializer().Serialize(tbl);
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }

    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetReturns_details(int compid, string Q, string F, string TanNo, string Conn)
    { string path, SuccessFilePath, ErrorFilePath, ZipFilePath, xlPath;
        string[] result = new string[4];
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
        tbl_Dashboard obj = new tbl_Dashboard();
        obj.ST = financialyear[0];
        obj.ED = financialyear[1];
        obj.ST = obj.ST + obj.ED;
        path = Server.MapPath("~/eReturns/Regular");
        xlPath = "";

        SuccessFilePath = path + "\\" + TanNo + "\\" + obj.ST + "\\" + F + "\\" + Q + @"\27A_" + TanNo + "_" + F + "_" + Q + "_" + obj.ST + ".pdf";
        ZipFilePath = path + "\\" + TanNo + "\\" + obj.ST + "\\" + F + "\\" + Q + @"\" + TanNo.ToUpper() + "_" + obj.ST + F + Q + ".zip";
        ErrorFilePath = path + "\\" + TanNo + "\\" + obj.ST + "\\" + F + "\\" + Q + @"\" + F + Q + "err.html";
        if (Directory.Exists(path))
        {
            if (File.Exists(SuccessFilePath))
            {
                result[0] = "Success";
                result[2] = "../eReturns/Regular/" + TanNo + "/" + obj.ST + "/" + F + "/" + Q + "/" + TanNo + "_" + obj.ST + F + Q + ".zip";
                FileInfo info = new FileInfo(ZipFilePath);
                result[1] = info.CreationTime.ToString("dd/MM/yyyy");
                result[3] = "../eReturns/Regular/" + TanNo + "/" + obj.ST + "/" + F + "/" + Q + "/" + "27A_" + TanNo + "_" + F + "_" + Q + "_" + obj.ST + ".pdf";
            }
            else if (File.Exists(ErrorFilePath))
            {
                result[0] = "Error";
                result[2] = "../eReturns/Regular/" + TanNo + "/" + obj.ST + "/" + F + "/" + Q + "/" + TanNo + "_" + obj.ST + F + Q + ".zip";
                FileInfo info = new FileInfo(ErrorFilePath);
                result[1] = info.CreationTime.ToString("dd/MM/yyyy");
                result[3] = "";
            }
            else
            {
                result[0] = "";
                result[1] = "";
                result[2] = "";
                result[3] = "";
            }
        }
        else
        {
            result[0] = "";
            result[1] = "";
            result[2] = "";
            result[3] = "";
        }
        IEnumerable<tbl_Dashboard> tbl = objBAL.BAL_Status(result[0], result[1], result[2], result[3], xlPath);
        return new JavaScriptSerializer().Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Get_VerifiedChallans(int compid, string Q, string F, string Conn)
    { BAL_ManageSalary_ChallanList obj = new BAL_ManageSalary_ChallanList();
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        objChallanDetails tobj = new objChallanDetails();
        tobj.FormType = F;
        tobj.quarter = Q;
        tobj.Compid = compid;

        IEnumerable<objChallanDetails> tbl = obj.BAL_Dashboard_Challan(tobj);

        return new JavaScriptSerializer().Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string SaveToken(int compid, string Q, string F, string T, string Conn)
    { BAL_Dashboard obj = new BAL_Dashboard();
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        tbl_Dashboard tobj = new tbl_Dashboard();
        tobj.Formtype = F;
        tobj.Quater = Q;
        tobj.RToken = T;
        tobj.compid = compid;

        IEnumerable<tbl_Dashboard> tbl = obj.BAL_SaveToken(tobj);

        return new JavaScriptSerializer().Serialize(tbl);
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetZIP(int compid, string Q, string F, string TanNo, string Conn)
    {
        string[] result = new string[4];
        string path,  ZipFilePath, ZipPath, ZFile;
        string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
        tbl_Dashboard obj = new tbl_Dashboard();
        obj.ST = financialyear[0];
        obj.ED = financialyear[1];
        obj.ST = obj.ST + obj.ED;
        path = Server.MapPath("~/eReturns/Regular");
        try
        {
            ZipFilePath = path + "\\" + TanNo + "\\" + obj.ST + "\\" + F + "\\" + Q + "\\" + F + Q + ".fvu";
            ZFile =path + "\\" + TanNo + "\\" + obj.ST + "\\" + F + "\\" + Q + "\\" + F + Q + "_Fvu.zip";
            //../eReturns/Regular/MUMA09455F/202122/26Q/Q1/MUMA09455F_20212226QQ1.zip
            ZipPath = "../eReturns/Regular/" + TanNo + "/" + obj.ST + "/" + F + "/" + Q + "/" + F + Q + "_Fvu.zip";
            if (File.Exists(ZipFilePath) == true)
            {
                if (File.Exists(ZFile) == false)
                {
                    using (ZipFile zip = new ZipFile())
                    {
                        zip.AddFile(ZipFilePath, "Files");
                        zip.Save(ZFile);
                    }
                }
            }
            else
            {
                ZipPath = "File does not exist";
            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        IEnumerable<tbl_Dashboard> tbl = objBAL.BAL_ZipPath(ZipPath);
        return new JavaScriptSerializer().Serialize(tbl);

    }
}