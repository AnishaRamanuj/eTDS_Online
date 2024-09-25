<%@ WebService Language="C#" Class="DeducteeXLImport" %>
using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Data;
using Microsoft.ApplicationBlocks1.Data;
using CommonLibrary;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using System.Globalization;
using DataLayer;
using BusinessLayer;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class DeducteeXLImport : System.Web.Services.WebService
{
    public SqlConnection sqlConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());
    public static CultureInfo ci = new CultureInfo("en-GB");
    BAL_VoucherEntries_Master objBAL_VoucherEntries = new BAL_VoucherEntries_Master();
    DAL_VoucherEntries_Master objDAL_Voucher = new DAL_VoucherEntries_Master();


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string InsertDeductee(int Compid, string rd,string Conn)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }

        tbl_VoucherModify obj = new tbl_VoucherModify();
        obj.compid = Compid ;
        obj.DName = rd;
        string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
        obj.ST  = financialyear[0];
        obj.ED = "20" + financialyear[1];

        IEnumerable<tbl_VoucherModify> tbl = objBAL_VoucherEntries.BAL_ImportDeductee(obj);

        return new JavaScriptSerializer().Serialize(tbl);
    }

    [WebMethod]
    public string DumyDeductee(int Compid)
    {
        string com = Convert.ToString(Compid);
        return com;
    }

}