<%@ WebService Language="C#" Class="Voucher" %>

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
using System.Web.Security;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class Voucher : System.Web.Services.WebService
{
    public SqlConnection sqlConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());
    public static CultureInfo ci = new CultureInfo("en-GB");
    BAL_VoucherEntries_Master objBAL_VoucherEntries = new BAL_VoucherEntries_Master();
    DAL_VoucherEntries_Master objDAL_Voucher = new DAL_VoucherEntries_Master();

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetDropdowns(int compid, string Conn, string F, string Q)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        tbl_VoucherDropDowns obj = new tbl_VoucherDropDowns();
        obj.compid = compid;
        obj.Conn = Conn;
        string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
        obj.ST = financialyear[0];
        obj.ED = "20" + financialyear[1];
        obj.FormType = F;
        obj.Quater = Q;
        IEnumerable<tbl_VoucherDropDowns> tbl = objBAL_VoucherEntries.BAL_GetDropdowns(obj);

        return new JavaScriptSerializer().Serialize(tbl);
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Get_TypeAhead(int compid, string Conn, string F, string D)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        tbl_DeducteeList obj = new tbl_DeducteeList();
        obj.compaid = compid;
        obj.Form = F;
        obj.Dname = D;
        string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
        IEnumerable<tbl_DeducteeList> tbl = objBAL_VoucherEntries.BAL_GetTypeAhead(obj);
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
        //return new JavaScriptSerializer().Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Get_Nature_Branch_Drp(int compid, string Conn, string F)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        tbl_VoucherDropDowns obj = new tbl_VoucherDropDowns();
        obj.compid = compid;
        obj.Conn = Conn;
        string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
        obj.ST = financialyear[0];
        obj.ED = "20" + financialyear[1];
        obj.FormType  = F;
        IEnumerable<tbl_VoucherDropDowns> tbl = objBAL_VoucherEntries.BAL_Get_Nature_Branch_Drp(obj);

        return new JavaScriptSerializer().Serialize(tbl);
    }



    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Challan_VoucherGrd(int c,  int pI, int pS, string Conn, int d, string n, int Chid)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        tbl_VoucherModifyGrd obj = new tbl_VoucherModifyGrd();
        obj.compid = c;

        obj.pageIndex = pI;
        obj.pageSize = pS;

        obj.Chid = Chid;


        obj.did = d;
        if (n == "")
        {
            n = "0";
        }

        obj.nid = Convert.ToInt32(n);
        string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
        obj.ST = financialyear[0];
        obj.ED = "20" + financialyear[1];


        IEnumerable<tbl_VoucherModifyGrd> tbl = objBAL_VoucherEntries.BAL_Modify_Chln_Vch_Grd(obj);

        return new JavaScriptSerializer().Serialize(tbl);
    }




    [System.Web.Services.WebMethod(EnableSession = true)]
    public string ModifyGrd(int c, int mth, int pI, int pS, string Conn, string d, string n, string ch, int U, string fltr, string F, string Q)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        tbl_VoucherModifyGrd obj = new tbl_VoucherModifyGrd();
        obj.compid = c;
        obj.mthno = mth;
        obj.pageIndex = pI;
        obj.pageSize = pS;
        obj.CPaid = ch;

        obj.form_type = fltr;
        if (d == "")
        {
            d = "0";
        }
        obj.did = Convert.ToInt32(d);
        if (n == "")
        {
            n = "0";
        }
        obj.UPaid = U;
        obj.nid = Convert.ToInt32(n);
        string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
        obj.ST = financialyear[0];
        obj.ED = "20" + financialyear[1];
        obj.form_type = F;
        obj.Quater = Q;

        IEnumerable<tbl_VoucherModifyGrd> tbl = objBAL_VoucherEntries.BAL_ModifyGrd(obj);

        return new JavaScriptSerializer().Serialize(tbl);
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string EditRecords(int compid, int vid, string Conn)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        tbl_VoucherModify obj = new tbl_VoucherModify();
        obj.compid = compid;
        obj.vid = vid;
        string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
        obj.ST = financialyear[0];
        obj.ED = "20" + financialyear[1];

        IEnumerable<tbl_VoucherModify> tbl = objBAL_VoucherEntries.BAL_Modify(obj);

        return new JavaScriptSerializer().Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string SaveRecords(int compid, double va, string vr, float tds, float sur, float ces, float net, string Conn, string rec)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        tbl_VoucherModify obj = new tbl_VoucherModify();
        obj.compid = compid;
        //var rec = dt + '^' + did + '^' + n + '^' + r + '^' + ct + '^' + ty + '^' + p + '^' + ib + '^' + b + '^' + rt ;
        //          0           1          2         3         4           5         6          7         8         9  
        //rec = rec  + '^' + vid + '^' + nsid + '^' + nri + '^' + sel + '^' + fr + '^' + chk + '^' + q;
        //                    10          11           12          13          14         15         16

        string type = "";

        string[] val = rec.Split('^');

        string[] d = val[0].Split('/');
        var _VDT = new DateTime(1900, 1, 1);
        var info = new CultureInfo("en-US", false);
        String _dateFormat = "dd/MM/yyyy";
        string dtxt = val[0].Trim();
        if (dtxt.Trim() != "" && !DateTime.TryParseExact(dtxt.Trim(), _dateFormat, info, DateTimeStyles.AllowWhiteSpaces, out _VDT))
        {
        }
        obj.VDT = _VDT;
        //obj.PDate = d[1] + '/' + d[0] + '/' + d[2];
        //String sDate = val[0].ToString();
        //DateTime datevalue = (Convert.ToDateTime(obj.PDate.ToString()));

        int mn = _VDT.Month;

        if (mn == 1 || mn == 2 || mn == 3)
            type = "Q4";

        if (mn == 4 || mn == 5 || mn == 6)
            type = "Q1";

        if (mn == 7 || mn == 8 || mn == 9)
            type = "Q2";

        if (mn == 10 || mn == 11 || mn == 12)
            type = "Q3";

        obj.Quater = type;


        obj.did = Convert.ToInt32(val[1]);
        obj.nid = Convert.ToInt32(val[2]);
        obj.rsid = val[3];
        obj.Cert = val[4];
        obj.tid = val[5];
        obj.PAN = val[6];
        obj.Invid = val[7];
        if (val[8] == "")
        {
            obj.Bid = 0;
        }
        else
        {
            obj.Bid = Convert.ToInt32(val[8]);
        }
        obj.rid = Convert.ToInt32(val[9]);
        if (val[10] == "")
        {
            obj.vid = 0;
        }
        else
        {
            obj.vid = Convert.ToInt32(val[10]);
        }
        obj.nsid = val[11];
        obj.isNri = Convert.ToBoolean(val[15]);
        obj.sel = 0; //Convert.ToInt32(val[13]);
        obj.formType = val[14];
        obj.Thold = Convert.ToBoolean(val[15]);
        obj.DName = val[17];
        obj.Add1 = val[19];
        obj.Emailid = val[20];
        obj.Contactno = val[21];
        obj.NriTDSRT = val[18];
        obj.TaxId=  val[22];
        obj.CountryId = Convert.ToInt32(val[23]);
        obj.AmtPaid = va;
        obj.TdsAmt = tds;
        obj.Rate = vr;
        obj.Sur = sur;
        obj.Cess = ces;
        obj.Total = net;
        obj.eqNri = val[24];
        obj.eqInd = val[25];
        obj.BAC1A =val[26];
        obj.PChar = val[27];
        string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
        obj.ST = financialyear[0];
        obj.ED = "20" + financialyear[1];

        IEnumerable<tbl_VoucherModify> tbl = objBAL_VoucherEntries.BAL_SaveRecords(obj);

        return new JavaScriptSerializer().Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Deductee_Details(int compid, int did, string Conn, string F)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        tbl_DeducteeDetails obj = new tbl_DeducteeDetails();
        obj.compid = compid;
        obj.Conn = Conn;
        obj.did = did;
        obj.formType = F;
        string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
        obj.ST = financialyear[0];
        obj.ED = "20" + financialyear[1];
        IEnumerable<tbl_DeducteeDetails> tbl = objBAL_VoucherEntries.BAL_Deductee_Details(obj);

        return new JavaScriptSerializer().Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Deductee_Rate(int compid, string nsid, string dT, string Conn, int nid)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        tbl_DeducteeRate obj = new tbl_DeducteeRate();
        obj.compid = compid;
        obj.Conn = Conn;
        obj.nsid = nsid;
        obj.nid = nid;
        // string[] d = dT.Split('/');
        var _VDT = new DateTime(1900, 1, 1);
        var _CDT = new DateTime(1900, 1, 1);
        var info = new CultureInfo("en-US", false);
        String _dateFormat = "dd/MM/yyyy";
        string dtxt = dT.Trim();
        if (dtxt.Trim() != "" && !DateTime.TryParseExact(dtxt.Trim(), _dateFormat, info, DateTimeStyles.AllowWhiteSpaces, out _CDT))
        {
        }
        obj.VDT = _CDT;
        dtxt = "15/05/2020";
        if (dtxt.Trim() != "" && !DateTime.TryParseExact(dtxt.Trim(), _dateFormat, info, DateTimeStyles.AllowWhiteSpaces, out _VDT))
        {
        }


        if (_VDT < _CDT && nid == 13)
        {
            IEnumerable<tbl_DeducteeRate> tbl = null;

            return new JavaScriptSerializer().Serialize(tbl);
        }
        else
        {
            string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
            obj.ST = financialyear[0];
            obj.ED = "20" + financialyear[1];
            IEnumerable<tbl_DeducteeRate> tbl = objBAL_VoucherEntries.BAL_Deductee_Rate(obj);

            return new JavaScriptSerializer().Serialize(tbl);
        }

    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string FillLstGrd(int compid, int did, string Conn)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        tbl_VoucherModifyGrd obj = new tbl_VoucherModifyGrd();
        obj.compid = compid;
        obj.Conn = Conn;
        obj.did = did;
        string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
        obj.ST = financialyear[0];
        obj.ED = "20" + financialyear[1];
        IEnumerable<tbl_VoucherModifyGrd> tbl = objBAL_VoucherEntries.BAL_LastGrd(obj);

        return new JavaScriptSerializer().Serialize(tbl);
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string FillGrd(int compid, string did, string Conn, string F, string Q)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        tbl_VoucherGrd obj = new tbl_VoucherGrd();
        obj.compid = compid;
        obj.Conn = Conn;
        obj.did = did;
        string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
        obj.ST = financialyear[0];
        obj.Ftyp = F;
        obj.Qtr = Q;
        obj.ED = "20" + financialyear[1];
        IEnumerable<tbl_VoucherGrd> tbl = objBAL_VoucherEntries.BAL_FillGrd(obj);

        return new JavaScriptSerializer().Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string DeleteRecords(int compid, string paidids, string nonpaid, string Conn)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        tbl_VoucherModifyGrd obj = new tbl_VoucherModifyGrd();
        obj.compid = compid;
        obj.CPaid = paidids;
        obj.nsid = nonpaid;
        string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
        obj.ST = financialyear[0];
        obj.ED = "20" + financialyear[1];

        IEnumerable<tbl_VoucherModifyGrd> tbl = objBAL_VoucherEntries.BAL_Delete_Voucher(obj);

        return new JavaScriptSerializer().Serialize(tbl);
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Section_Modify(int compid, string Conn, string all)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        tbl_VoucherModify obj = new tbl_VoucherModify();
        obj.compid = compid;
        obj.Conn = Conn;
        obj.RT = all;
        string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
        obj.ST = financialyear[0];
        obj.ED = "20" + financialyear[1];
        IEnumerable<tbl_VoucherModify> tbl = objBAL_VoucherEntries.BAL_Section_Modify(obj);

        return new JavaScriptSerializer().Serialize(tbl);
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string SaveToken(int Compid, string TokenNo, string Qtr, string Ftyp, string Conn)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        tbl_VoucherGrd obj = new tbl_VoucherGrd();
        obj.compid = Compid;
        obj.Conn = Conn;
        obj.Tokenid = TokenNo;
        obj.Qtr = Qtr;
        obj.Ftyp = Ftyp;
        string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
        obj.ST = financialyear[0];
        obj.ED = "20" + financialyear[1];
        IEnumerable<tbl_VoucherGrd> tbl = objBAL_VoucherEntries.BAL_SaveToken(obj);

        return new JavaScriptSerializer().Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetTracesDetails(int Compid)
    {

        tbl_TracesDetail obj = new tbl_TracesDetail();
        obj.Compid = Compid;


        IEnumerable<tbl_TracesDetail> tbl = objBAL_VoucherEntries.BAL_GetTracesDetails(obj);

        return new JavaScriptSerializer().Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string TracesDetailsSave(int Compid, string UserID, string Password, string TAN)
    {

        tbl_TracesDetail obj = new tbl_TracesDetail();
        obj.Compid = Compid;
        obj.TAN = TAN;
        obj.Userid = UserID;
        obj.Password = Password;

        IEnumerable<tbl_TracesDetail> tbl = objBAL_VoucherEntries.BAL_TracesDetailsSave(obj);

        return new JavaScriptSerializer().Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string MisMatch_Vouchers(int compid, string f, string q, string Conn)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        MisMatch_Vouchers obj = new MisMatch_Vouchers();
        obj.Compid = compid;
        obj.Quater = q;
        obj.FromType = f;

        IEnumerable<MisMatch_Vouchers> tbl = objBAL_VoucherEntries.BAL_MisMatch(obj);

        return new JavaScriptSerializer().Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string UpdateBAC(int compid, string Conn, string F, string Q, string B)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        MisMatch_BAC obj = new MisMatch_BAC();
        obj.Compid = compid;
        obj.Quater = Q;
        obj.FromType = F;
        obj.TBAC = B;
        IEnumerable<MisMatch_BAC> tbl = objBAL_VoucherEntries.BAL_BACUpdate(obj);

        return new JavaScriptSerializer().Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string UpdateDeducteeType(int compid, string Conn, string F, string Q, string B)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        MisMatch_DType obj = new MisMatch_DType();
        obj.Compid = compid;
        obj.Quater = Q;
        obj.FromType = F;
        obj.DType = B;
        IEnumerable<MisMatch_DType> tbl = objBAL_VoucherEntries.BAL_DTUpdate(obj);

        return new JavaScriptSerializer().Serialize(tbl);
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Deductee_ReportGrid(int compid, string Fromdt, string Todate, string Conn,string Formtype)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        tbl_DeducteeReport obj = new tbl_DeducteeReport();
        DateTime strdate = Convert.ToDateTime(Fromdt, ci);
        DateTime todate = Convert.ToDateTime(Todate, ci);


        obj.Compid = compid;
        obj.FromType = Formtype;
        obj.From =strdate;
        obj.To =todate;
        IEnumerable<tbl_DeducteeReport> tbl = objBAL_VoucherEntries.BAL_Deductee_ReportGrid(obj);

        return new JavaScriptSerializer().Serialize(tbl);
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string TDS_ReportGrid(int compid, string Fromdt, string Todate, string Conn,string Formtype,int rdio)
    {
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        tbl_DeducteeReport obj = new tbl_DeducteeReport();
        DateTime strdate = Convert.ToDateTime(Fromdt, ci);
        DateTime todate = Convert.ToDateTime(Todate, ci);


        obj.Compid = compid;
        obj.FromType = Formtype;
        obj.From =strdate;
        obj.To =todate;
        obj.rdio = rdio;
        IEnumerable<tbl_DeducteeReport> tbl = objBAL_VoucherEntries.BAL_TDS_ReportGrid(obj);

        return new JavaScriptSerializer().Serialize(tbl);
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Validate(string U, string P)
    {
        if (Membership.ValidateUser(U,P))
        {

        }
        else
        {

        }
        return  "Yes";
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Get_PANNo_List(TracesInfo tracesInfo)
    {

        TracesInfo obj = new TracesInfo();
        obj.Compid = tracesInfo.Compid ;
        obj.Quarter = tracesInfo.Quarter;
        obj.FormType =tracesInfo. FormType;

        IEnumerable<PANNo> tbl = objBAL_VoucherEntries.BAL_PANNOList(obj);

        return new JavaScriptSerializer().Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string ListPANStatus(string F, string Q, string sts, int pg, int ps )
    {
        tbl_VoucherModify obj = new tbl_VoucherModify();

        obj.compid = Convert.ToInt32(Session["companyid"].ToString());
        obj.Quater = Q;
        obj.formType =F;
        obj.PAN_AAdhar = sts;
        obj.pageIndex = pg;
        obj.pageSize = ps;
        IEnumerable<tbl_VoucherModify> tbl = objBAL_VoucherEntries.BAL_ListPANStatus(obj);

        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string ListPANSummary(string F, string Q, string sts )
    {
        PANNo obj = new PANNo();

        obj.Compid = Convert.ToInt32(Session["companyid"].ToString());
        obj.Quarter = Q;
        obj.FormType =F;
        obj.PAN_AAdhar = sts;

        IEnumerable<PANNo> tbl = objBAL_VoucherEntries.BAL_ListPANSummary(obj);

        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }

}