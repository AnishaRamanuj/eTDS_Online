<%@ WebService Language="C#" Class="Correction" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Data;
using Microsoft.ApplicationBlocks1.Data;
//using CommonLibrary;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using System.Globalization;
using EntityLibrary;
using System.Web.Security;
using System.IO;
using System.Diagnostics;
using Ionic.Zip;
using LibCommon;
 

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class Correction  : System.Web.Services.WebService {


    DALCommonLib objComm = new DALCommonLib();
    Functions4evr Comm = new Functions4evr();

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetDetails(int cid, string Qua, string frm, string Fy, string TAN)
    {
        List<Corr_Details> Challan = new List<Corr_Details>();

        string eReturnspath = Server.MapPath("~/eReturns/Correction");
        string tannoPath = (eReturnspath + "\\" + TAN + "\\" + Fy);
        string fromtypepath = tannoPath + "\\" + frm;

        string QuaterPath = (fromtypepath + "\\" + Qua);

        string financialyear = Fy;
        string[] newfyear = financialyear.Split('_');
        string a = "";
        string b = "";
        foreach (string s in newfyear)
        {
            b = (Convert.ToInt32(s) + 1).ToString();
            a = a + s;
        }
        string sucessfile = QuaterPath + @"\27A_" + TAN + "_" + frm + "_" + Qua + "_" + a + ".pdf";
        string SuccessFvu = "";
        string Successerr = "";
        if (File.Exists(sucessfile) == true)
        {
            SuccessFvu = QuaterPath + "/" + TAN + "_" + Fy + frm + Qua + "FVU.zip";
            sucessfile = QuaterPath + "/" + TAN + "_" + Fy + frm + Qua + ".zip";
            Successerr = "";
        }
        else
        {
            SuccessFvu = "";
            sucessfile = "";
            Successerr = QuaterPath + "/" + frm + Qua + "err.html";
        }


        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@Cid", cid);

        using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString, CommandType.StoredProcedure, "usp_Correction_Details", param))
        {
            while (drrr.Read())
            {
                Challan.Add(new Corr_Details()
                {
                    Form = Comm.GetValue<string>(drrr["Form"].ToString()),
                    Tan = Comm.GetValue<string>(drrr["TANno"].ToString()),
                    //CNAME = Comm.GetValue<string>(drrr["Bank_Challan_no"].ToString()),
                    FDown = Comm.GetValue<string>(drrr["FDown"].ToString()),
                    TotalChl = Comm.GetValue<string>(drrr["TotalChl"].ToString()),
                    TotalChlAmt = Comm.GetValue<string>(drrr["TotalChlamt"].ToString()),
                    FImpDT = Comm.GetValue<string>(drrr["FimpDT"].ToString()),
                    TotalDED = Comm.GetValue<string>(drrr["TotalDED"].ToString()),
                    TotalDedAmt = Comm.GetValue<string>(drrr["TotalDedAmt"].ToString()),
                    CompChange = Comm.GetValue<string>(drrr["CChanges"].ToString()),
                    CntDedEdit = Comm.GetValue<string>(drrr["CntDedEdit"].ToString()),
                    CntDedAdd = Comm.GetValue<string>(drrr["CntDEDAdd"].ToString()),
                    CntPAN = Comm.GetValue<string>(drrr["CntPAN"].ToString()),
                });

            }
            List<Correction_Obj> corded = new List<Correction_Obj>();
            if (drrr.NextResult())
            {
                while (drrr.Read())
                {
                    corded.Add(new Correction_Obj()
                    {
                        Srno = Comm.GetValue<int>(drrr["cnt"].ToString()),
                    });
                }
            }

            foreach (var item in Challan)
            {
                item.list_Cordet = corded;
            }

        }

        Challan.Add(new Corr_Details()
        {
            CSuccess = Convert.ToString(sucessfile.ToString()),
            CSuccessFVU = Convert.ToString(SuccessFvu.ToString()),
            CError = Convert.ToString(Successerr.ToString()),
        });


        IEnumerable<Corr_Details> tbl = Challan;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetChallan(int cid)
    {
        Corr_Challan_List cobj = new Corr_Challan_List();
        cobj.correctionid = cid;

        List<Corr_Challan_List> Challan = new List<Corr_Challan_List>();
        DataSet ds = new DataSet();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@Cid", cobj.correctionid);


        using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString, CommandType.StoredProcedure, "usp_Correction_ChallanList", param))
        {
            while (drrr.Read())
            {
                Challan.Add(new Corr_Challan_List()
                {
                    Form = Comm.GetValue<string>(drrr["Form"].ToString()),
                    Qua = Comm.GetValue<string>(drrr["Qua"].ToString()),
                    Bank_Challan_no = Comm.GetValue<string>(drrr["Bank_Challan_no"].ToString()),
                    Bank_BSRCode = Comm.GetValue<string>(drrr["Bank_BSRCode"].ToString()),
                    Challan_Date = Comm.GetValue<string>(drrr["Challan_Date"].ToString()),
                    TDS = Comm.GetValue<double>(drrr["TDS"].ToString()),
                    Surcharge = Comm.GetValue<double>(drrr["Surcharge"].ToString()),
                    Cess = Comm.GetValue<double>(drrr["Cess"].ToString()),
                    Interest = Comm.GetValue<double>(drrr["Interest"].ToString()),
                    Others = Comm.GetValue<double>(drrr["Others"].ToString()),
                    Total_Deposit_Amt = Comm.GetValue<double>(drrr["Total_Deposit_Amt"].ToString()),
                    Line_No = Comm.GetValue<int>(drrr["CDRecNo"].ToString()),
                    CMode = Comm.GetValue<string>(drrr["CMode"].ToString()),
                });
            }
        }

        IEnumerable<Corr_Challan_List> tbl = Challan;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string OpenDeducteePage( int Compid,  int Cid, string q, string f, string t,string yr, string cn )
    {
        Correction_Obj obj = new Correction_Obj();
        string tbl = "";
        // HttpContext.Current.Session["CO"] = CO;
        HttpContext.Current.Session["companyid"] = Compid;
        HttpContext.Current.Session["Cid"] = Cid;
        HttpContext.Current.Session["Qua"] = q;
        HttpContext.Current.Session["Frm"] = f;
        HttpContext.Current.Session["Tan"] = t;
        HttpContext.Current.Session["Yr"] = yr;
        HttpContext.Current.Session["CN"] = cn;


        var outputJsonResult = new JavaScriptSerializer();
        return outputJsonResult.Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string OpenImportPage(int Compid )
    {
        Correction_Obj obj = new Correction_Obj();
        string tbl = "";
        HttpContext.Current.Session["companyid"] = Compid;
        var outputJsonResult = new JavaScriptSerializer();
        return outputJsonResult.Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetDeductee(int c, int ln, int ccd, string rr)
    {
        List<Correction_Obj> Deductee = new List<Correction_Obj>();



        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@cid", c);
        param[1] = new SqlParameter("@ln", ln);
        param[2] = new SqlParameter("@cln", ccd);
        param[3] = new SqlParameter("@RecType", rr);

        using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString, CommandType.StoredProcedure, "usp_Get_CorrectionVouchers", param))
        {
            while (drrr.Read())
            {
                Deductee.Add(new Correction_Obj()
                {

                    id = Comm.GetValue<int>(drrr["DDRecNo"].ToString()),

                    DCode = Comm.GetValue<string>(drrr["Deductee_Code"].ToString()),
                    PAN = Comm.GetValue<string>(drrr["PAN"].ToString()),

                    DName = Comm.GetValue<string>(drrr["DeducteeName"].ToString()),
                    TdsAmt = Comm.GetValue<double>(drrr["Tds"].ToString()),
                    Sur = Comm.GetValue<float>(drrr["Surcharge"].ToString()),
                    Cess = Comm.GetValue<float>(drrr["Cess"].ToString()),
                    Total = Comm.GetValue<double>(drrr["Total_Tds_Deposited"].ToString()),
                    AmtPaid = Comm.GetValue<double>(drrr["Voucher_Amt"].ToString()),
                    Voucher_DT = Comm.GetValue<string>(drrr["PaidDate"].ToString()),
                    Deduction_DT = Comm.GetValue<string>(drrr["DeductionDate"].ToString()),
                    RT = Comm.GetValue<string>(drrr["TDS_Rate"].ToString()),
                    rsid = Comm.GetValue<string>(drrr["Reason"].ToString()),
                    sec = Comm.GetValue<string>(drrr["Tds_Section"].ToString()),
                    Cert = Comm.GetValue<string>(drrr["TDSCert_No"].ToString()),
                    CountryId = Comm.GetValue<int>(drrr["CountryCode"].ToString()),
                    NriTDSRT = Comm.GetValue<string>(drrr["NRICode"].ToString()),
                    REMITTANCE_Id = Comm.GetValue<int>(drrr["RemittanceCode"].ToString()),
                    Add1 = Comm.GetValue<string>(drrr["Nri_Address"].ToString()),
                    Emailid = Comm.GetValue<string>(drrr["Nri_Email"].ToString()),
                    Tel = Comm.GetValue<string>(drrr["Nri_Tel"].ToString()),
                    Nri_Identification = Comm.GetValue<string>(drrr["Nri_TaxIdentification"].ToString()),
                    eqNri = Comm.GetValue<string>(drrr["Nri_27Eq"].ToString()),
                    eqInd = Comm.GetValue<string>(drrr["Est_27EQ"].ToString()),
                    Form_Type = Comm.GetValue<string>(drrr["form"].ToString()),
                    BAC_1A = Comm.GetValue<string>(drrr["BAC_1A"].ToString()),
                });
            }

            List<Corr_Challan_List> Challan = new List<Corr_Challan_List>();
            if (drrr.NextResult())
            {
                while (drrr.Read())
                {
                    Challan.Add(new Corr_Challan_List()
                    {
                        //Form = Comm.GetValue<string>(drrr["Form"].ToString()),
                        //Qua = Comm.GetValue<string>(drrr["Qua"].ToString()),
                        Bank_Challan_no = Comm.GetValue<string>(drrr["Bank_Challan_no"].ToString()),
                        Bank_BSRCode = Comm.GetValue<string>(drrr["Bank_BSRCode"].ToString()),
                        Challan_Date = Comm.GetValue<string>(drrr["Challan_Date"].ToString()),
                        TDS = Comm.GetValue<double>(drrr["TDS"].ToString()),
                        Surcharge = Comm.GetValue<double>(drrr["Surcharge"].ToString()),
                        Cess = Comm.GetValue<double>(drrr["Cess"].ToString()),
                        Interest = Comm.GetValue<double>(drrr["Interest"].ToString()),
                        Others = Comm.GetValue<double>(drrr["Others"].ToString()),
                        Total_Deposit_Amt = Comm.GetValue<double>(drrr["Total_Deposit_Amt"].ToString()),
                        Line_No = Comm.GetValue<int>(drrr["CDRecNo"].ToString()),
                        Total_Deductee_Deposit = Comm.GetValue<double>(drrr["Total_Deductee_Deposit"].ToString()),
                    });

                }
            }

            foreach (var item in Deductee)
            {
                item.list_Challan = Challan;

            }
        }

        IEnumerable<Correction_Obj> tbl = Deductee;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);


    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Correction_Grd(Correction_Grd cobj)
    {

        List<Correction_Grd> Crlst = new List<Correction_Grd>();
        DataSet ds = new DataSet();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@company_id", cobj.Compid);


        using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString, CommandType.StoredProcedure, "usp_Correction_Grd", param))
        {
            while (drrr.Read())
            {
                Crlst.Add(new Correction_Grd()
                {
                    Srno = Comm.GetValue<int>(drrr["sino"].ToString()),
                    correctionid = Comm.GetValue<int>(drrr["Correction_id"].ToString()),
                    Form = Comm.GetValue<string>(drrr["Form_no"].ToString()),
                    TAN = Comm.GetValue<string>(drrr["tan_no"].ToString()),
                    ImportDT = Comm.GetValue<string>(drrr["Import_date"].ToString()),
                    Qtr = Comm.GetValue<string>(drrr["Quater"].ToString()),
                    UpdatedDT = Comm.GetValue<string>(drrr["Trans_DT"].ToString()),
                    Fyr = Comm.GetValue<string>(drrr["Fyear"].ToString()),
                    Updated = Comm.GetValue<string>(drrr["Data_Transfered"].ToString()),
                    CNAME = Comm.GetValue<string>(drrr["companyname"].ToString()),
                    Compid = Comm.GetValue<int>(drrr["Company_id"].ToString()),
                    Deductee = Comm.GetValue<int>(drrr["Deductee"].ToString()),
                    PAN = Comm.GetValue<int>(drrr["PAN"].ToString()),
                    Company = Comm.GetValue<int>(drrr["Company"].ToString()),
                    Computation = Comm.GetValue<int>(drrr["Computation"].ToString()),
                });
            }

        }
        IEnumerable<Correction_Grd> tbl = Crlst;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);

    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Get_CorrectionDropdowns(string f)
    {
        List<Correction_Dropdowns> Deductee = new List<Correction_Dropdowns>();

        DataSet ds = new DataSet();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@form", f);



        using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString, CommandType.StoredProcedure, "usp_Correction_Nature", param))
        {
            while (drrr.Read())
            {
                Deductee.Add(new Correction_Dropdowns()
                {
                    Form = Comm.GetValue<string>(drrr["Form"].ToString()),
                });
            }

            List<Correction_Remiitance> Rem = new List<Correction_Remiitance>();
            if (drrr.NextResult())
            {
                while (drrr.Read())
                {
                    Rem.Add(new Correction_Remiitance()
                    {
                        remittance = Comm.GetValue<string>(drrr["REMITTANCE"].ToString()),
                        rcode = Comm.GetValue<int>(drrr["RCode"].ToString()),
                    });

                }
            }
            List<Correction_Nature> Nat = new List<Correction_Nature>();
            if (drrr.NextResult())
            {
                while (drrr.Read())
                {
                    Nat.Add(new Correction_Nature()
                    {
                        Nature = Comm.GetValue<string>(drrr["Nature_Name"].ToString()),
                        Ncode = Comm.GetValue<string>(drrr["NCode"].ToString()),
                    });

                }
            }
            List<Correction_Section> Sec = new List<Correction_Section>();
            if (drrr.NextResult())
            {
                while (drrr.Read())
                {
                    Sec.Add(new Correction_Section()
                    {
                        Section = Comm.GetValue<string>(drrr["Section_Id"].ToString()),
                        Scode = Comm.GetValue<string>(drrr["SCode"].ToString()),
                    });

                }
            }
            List<Correction_Country> Cnt = new List<Correction_Country>();
            if (drrr.NextResult())
            {
                while (drrr.Read())
                {
                    Cnt.Add(new Correction_Country()
                    {
                        Country = Comm.GetValue<string>(drrr["Country_Name"].ToString()),
                        Ccode = Comm.GetValue<int>(drrr["Country_ID"].ToString()),
                    });

                }
            }
            foreach (var item in Deductee)
            {
                item.list_Correction_Remiitance = Rem;
                item.list_Correction_Nature = Nat;
                item.list_Correction_Section = Sec;
                item.list_Correction_Country = Cnt;
            }
        }

        IEnumerable<Correction_Dropdowns> tbl = Deductee;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }


    /// ///////////////////////// Redirecting to deductee page

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Deductee(int Compid, int Cid, string f, string q)
    {   List<Correction_Obj> obj_Deductee = new List<Correction_Obj>();

        HttpContext.Current.Session["form"] = f;
        HttpContext.Current.Session["Qua"] = q;
        HttpContext.Current.Session["Cid"] = Cid;
        HttpContext.Current.Session["CO"] = Compid;
        IEnumerable<Correction_Obj> tbl =obj_Deductee;
        return new JavaScriptSerializer().Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Challan_DeducteeGrd(int c, int ln, int pI, int pS)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
        List<Correction_Obj> Deductee = new List<Correction_Obj>();
        try
        {
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@cid", c);
            param[1] = new SqlParameter("@ln", ln);
            param[2] = new SqlParameter("@pageIndex", pI);
            param[3] = new SqlParameter("@pageSize", pS);
            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString, CommandType.StoredProcedure, "usp_Get_CorrectionVoucherGrd", param))
            {
                while (drrr.Read())
                {
                    Deductee.Add(new Correction_Obj()
                    {
                        Srno = Comm.GetValue<int>(drrr["sino"].ToString()),
                        id = Comm.GetValue<int>(drrr["DDRecNo"].ToString()),

                        DCode = Comm.GetValue<string>(drrr["Deductee_Code"].ToString()),
                        PAN = Comm.GetValue<string>(drrr["PAN"].ToString()),

                        DName = Comm.GetValue<string>(drrr["DeducteeName"].ToString()),
                        TdsAmt = Comm.GetValue<double>(drrr["Tds"].ToString()),
                        Sur = Comm.GetValue<int>(drrr["Surcharge"].ToString()),
                        Cess = Comm.GetValue<int>(drrr["Cess"].ToString()),
                        Total = Comm.GetValue<int>(drrr["Total_Tds_Deposited"].ToString()),
                        AmtPaid = Comm.GetValue<double>(drrr["Voucher_Amt"].ToString()),
                        Voucher_DT = Comm.GetValue<string>(drrr["PaidDate"].ToString()),

                        RT = Comm.GetValue<string>(drrr["TDS_Rate"].ToString()),

                        sec = Comm.GetValue<string>(drrr["Tds_Section"].ToString()),
                        RecType = Comm.GetValue<string>(drrr["RMode"].ToString()),
                        RecordCount = Comm.GetValue<int>(drrr["totalcount"].ToString()),
                    });
                }

                List<Corr_Challan_List> Challan = new List<Corr_Challan_List>();
                if (drrr.NextResult())
                {
                    while (drrr.Read())
                    {
                        Challan.Add(new Corr_Challan_List()
                        {
                            //Form = Comm.GetValue<string>(drrr["Form"].ToString()),
                            //Qua = Comm.GetValue<string>(drrr["Qua"].ToString()),
                            Bank_Challan_no = Comm.GetValue<string>(drrr["Bank_Challan_no"].ToString()),
                            Bank_BSRCode = Comm.GetValue<string>(drrr["Bank_BSRCode"].ToString()),
                            Challan_Date = Comm.GetValue<string>(drrr["Challan_Date"].ToString()),
                            TDS = Comm.GetValue<double>(drrr["TDS"].ToString()),
                            Surcharge = Comm.GetValue<double>(drrr["Surcharge"].ToString()),
                            Cess = Comm.GetValue<double>(drrr["Cess"].ToString()),
                            Interest = Comm.GetValue<double>(drrr["Interest"].ToString()),
                            Others = Comm.GetValue<double>(drrr["Others"].ToString()),
                            Total_Deposit_Amt = Comm.GetValue<double>(drrr["Total_Deposit_Amt"].ToString()),
                            Line_No = Comm.GetValue<int>(drrr["CDRecNo"].ToString()),
                            Total_Deductee_Deposit = Comm.GetValue<double>(drrr["Total_Deductee_Deposit"].ToString()),
                            Deductee_Total = Comm.GetValue<double>(drrr["tdsDepo"].ToString()),
                        });

                    }
                }

                foreach (var item in Deductee)
                {
                    item.list_Challan = Challan;

                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

        IEnumerable<Correction_Obj> tbl = Deductee; //obj_Bal_Correction.Get_DeducteeGrd(obj);
        return new JavaScriptSerializer().Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string DeleteRecord(int cid, int ln, int ccd )
    {

        List<Correction_Obj> Deductee = new List<Correction_Obj>();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@cid", cid);
        param[1] = new SqlParameter("@ln", ln);
        param[2] = new SqlParameter("@cln", ccd);



        using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString, CommandType.StoredProcedure, "usp_Correction_VoucherDelete", param))
        {
            while (drrr.Read())
            {
                Deductee.Add(new Correction_Obj()
                {

                    id = Comm.GetValue<int>(drrr["DDRecNo"].ToString()),

                });
            }

        }

        IEnumerable<Correction_Obj> tbl = Deductee;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string UndoRecord(int cid, int ln, int ccd )
    {
        List<Correction_Obj> Deductee = new List<Correction_Obj>();

        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@cid", cid);
        param[1] = new SqlParameter("@ln", ln);
        param[2] = new SqlParameter("@cln", ccd);


        using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString, CommandType.StoredProcedure, "usp_Correction_Undo", param))
        {
            while (drrr.Read())
            {
                Deductee.Add(new Correction_Obj()
                {

                    id = Comm.GetValue<int>(drrr["DDRecNo"].ToString()),

                });
            }

        }
        IEnumerable<Correction_Obj> tbl = Deductee;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string ReplaceRecord(int cid, int ln, int ccd )
    {

        List<Correction_Obj> Deductee = new List<Correction_Obj>();

        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@cid", cid);
        param[1] = new SqlParameter("@ln", ln);
        param[2] = new SqlParameter("@cln", ccd);


        using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString, CommandType.StoredProcedure, "usp_Correction_Undo", param))
        {
            while (drrr.Read())
            {
                Deductee.Add(new Correction_Obj()
                {

                    id = Comm.GetValue<int>(drrr["DDRecNo"].ToString()),

                });
            }

        }
        IEnumerable<Correction_Obj> tbl = Deductee;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string SaveRecords(double va, float vr, float tds, float sur, float ces, float net,  string rec)
    {
        List<Correction_Obj> objRec = new List<Correction_Obj>();
        Correction_Obj obj = new Correction_Obj();
        //obj.compid = compid;
        try
        {
            string type = "";
            //var rec = vd + '^' + n + '^' + r + '^' + ct + '^' + ty + '^' + P + '^' + rt+ '^' + frm + '^' + ln + '^' + Cid + '^' + dname
            //rec = rec + '^' + nd + '^' + nf + '^' + ne + '^' + nc + '^' + ni + '^' + nct + '^' + eqNri + '^' + eqInd + '^' + MM;

            string[] val = rec.Split('^');

            obj.PDate = val[0];

            int mn = Convert.ToInt32(val[19]); //_VDT.Month;

            if (mn == 1 || mn == 2 || mn == 3)
                type = "Q4";

            if (mn == 4 || mn == 5 || mn == 6)
                type = "Q1";

            if (mn == 7 || mn == 8 || mn == 9)
                type = "Q2";

            if (mn == 10 || mn == 11 || mn == 12)
                type = "Q3";

            obj.quarter = type;

            obj.REMITTANCE_Id = Convert.ToInt32(val[6]);

            obj.sec = val[1];
            obj.rsid = val[2];
            obj.Cert = val[3];
            obj.DCode = val[4];
            obj.PAN = val[5];


            obj.Line_No = Convert.ToInt32(val[8]);

            obj.correctionid = val[9];

            obj.DName = val[10];
            obj.Add1 = val[12];
            obj.Emailid = val[13];
            obj.Contactno = val[14];
            obj.NriTDSRT = val[11];
            obj.TaxId = val[15];
            obj.CountryId = Convert.ToInt32(val[16]);
            obj.AmtPaid = va;
            obj.TdsAmt = tds;
            obj.RT = vr.ToString();
            obj.Sur = sur;
            obj.Cess = ces;
            obj.Total = net;
            obj.eqNri = val[17];
            obj.eqInd = val[18];
            obj.RecType = val[20];
            obj.Challan_id = val[21];
            obj.BAC_1A = val[22];
            obj.Deduction_DT = val[23];

            DALCommonLib objComm = new DALCommonLib();
            Functions4evr Comm = new Functions4evr();

            SqlParameter[] param = new SqlParameter[28];

            param[0] = new SqlParameter("@DName", obj.DName);           //
            param[1] = new SqlParameter("@Voucher_DT", obj.PDate);             //    
            param[2] = new SqlParameter("@Voucher_Amount", obj.AmtPaid);     //
            param[3] = new SqlParameter("@TDS_Amt", obj.TdsAmt);                   //
            param[4] = new SqlParameter("@Surcharge_Amt", obj.Sur);       //
            param[5] = new SqlParameter("@ECess_Amt", obj.Cess);               //
            param[6] = new SqlParameter("@TDS_Percentage", obj.RT);     //
            param[7] = new SqlParameter("@Total_Tax_Amt", obj.Total);       //
            param[8] = new SqlParameter("@Deductee_Type", obj.DCode);      //

            param[9] = new SqlParameter("@Reason", obj.rsid);                    //    
            param[10] = new SqlParameter("@PAN_NO", obj.PAN);                    //
            param[11] = new SqlParameter("@TDS_Certificate", obj.Cert);  // 
            param[12] = new SqlParameter("@Remittance_ID", obj.REMITTANCE_Id);      //
            param[13] = new SqlParameter("@Nature_ID", obj.sec);              //  
            param[14] = new SqlParameter("@DDRec_ID", obj.Line_No);            //
            param[15] = new SqlParameter("@CID", obj.correctionid);                //

            param[16] = new SqlParameter("@Add1", obj.Add1);
            param[17] = new SqlParameter("@Email", obj.Emailid);
            param[18] = new SqlParameter("@Ctno", obj.Contactno);
            param[19] = new SqlParameter("@NriTDSRT", obj.NriTDSRT);
            param[20] = new SqlParameter("@TaxId", obj.TaxId);
            param[21] = new SqlParameter("@CountryId", obj.CountryId);
            param[22] = new SqlParameter("@eqNri", obj.eqNri);
            param[23] = new SqlParameter("@eqInd", obj.eqInd);
            param[24] = new SqlParameter("@Chl", obj.Challan_id);
            param[25] = new SqlParameter("@TransType", obj.RecType);
            param[26] = new SqlParameter("@BAC_1A", obj.BAC_1A);
            param[27] = new SqlParameter("@Deduction_DT", obj.Deduction_DT);
            //return SqlHelper.ExecuteReader(objComm._cnnString, CommandType.StoredProcedure, "usp_Correction_Insert_Deductee", param);

            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString, CommandType.StoredProcedure, "usp_Correction_Insert_Deductee", param))
            {
                while (drrr.Read())
                {
                    objRec.Add(new Correction_Obj()
                    {

                        Line_No = Comm.GetValue<int>(drrr["Line_no"].ToString()),

                    });

                }

            }


            // IEnumerable<Correction_Obj> tbl = obj_Bal_Correction.BAL_SaveRecords(obj);
        }

        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<Correction_Obj> tbl = objRec as IEnumerable<Correction_Obj>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string UpdatePAN(int cid, int ln, int ccd,string PRec, string PAN)
    {
        List<Correction_Obj> Deductee = new List<Correction_Obj>();
        SqlParameter[] param = new SqlParameter[5];
        param[0] = new SqlParameter("@cid", cid);
        param[1] = new SqlParameter("@ln", ln);
        param[2] = new SqlParameter("@cln", ccd);
        param[3] = new SqlParameter("@Pre", PRec);
        param[4] = new SqlParameter("@PAN", PAN );

        using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString, CommandType.StoredProcedure, "usp_Correction_PANUpdate", param))
        {
            while (drrr.Read())
            {
                Deductee.Add(new Correction_Obj()
                {

                    id = Comm.GetValue<int>(drrr["DDRecNo"].ToString()),
                    Challan_id = Comm.GetValue<string>(drrr["CDRecNo"].ToString()),
                });
            }

        }
        IEnumerable<Correction_Obj> tbl = Deductee;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string CreateTxt(int cid, int compid, string Qua, string frm, string Fy, string TAN)
    {
        List<Correction_Obj> objResult = new List<Correction_Obj>();

        string eReturnspath = Server.MapPath("~/eReturns/Correction");
        string tannoPath = (eReturnspath + "\\" + TAN + "\\" + Fy);
        string fromtypepath = tannoPath + "\\" + frm;


        string QuaterPath = (fromtypepath + "\\" + Qua);


        string fileformtype = QuaterPath + "\\" + frm + Qua;
        string generatetextfilename = fileformtype + ".txt";
        string generatehtmlfile = fileformtype + ".html";

        string financialyear = Fy;
        string[] newfyear = financialyear.Split('_');
        string a = "";
        string b = "";
        foreach (string s in newfyear)
        {
            b = (Convert.ToInt32(s) + 1).ToString();
            a = a + s;
        }

        ///////Create Directory
        try
        {
            if (Directory.Exists(QuaterPath))
            {
                try
                {
                    string mcer = QuaterPath + "\\e-mudhra.cer";
                    if (File.Exists(mcer))
                    {
                        File.Delete(mcer);
                    }
                    Directory.Delete(QuaterPath, true);
                }
                catch (Exception ex)
                {
                    //ErrorException.LogError(ex);
                }
            }
            if (!Directory.Exists(QuaterPath))
            {
                Directory.CreateDirectory(QuaterPath);
            }
            else
            {
                try
                {
                    Directory.Delete(QuaterPath, true);

                    Directory.CreateDirectory(QuaterPath);
                }
                catch (Exception ex)
                {
                    //ErrorException.LogError(ex);
                }

            }
            if (!Directory.Exists(QuaterPath))
            {
                Directory.CreateDirectory(QuaterPath);
            }
        }
        catch (Exception ex)
        {
            //ErrorException.LogError(ex);
        }
        string CSIName = " ";
        FileStream fs = null;

        DataSet ds; // = obj_Bal_Correction.BAL_GenerateTextFile(obj);

        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@CID", cid);


        ds = SqlHelper.ExecuteDataset(objComm._cnnString, "usp_Correction_Returns", param);

        string generatexmlfilename = fileformtype + ".xml";

        string eMudraname = Server.MapPath("~/eReturns/e-mudhra.cer");
        string eMudraDest = QuaterPath + "\\e-mudhra.cer";
        File.Copy(eMudraname, eMudraDest, true);

        string consoFilename = ds.Tables[1].Rows[0][0].ToString();
        string Conso = Server.MapPath("~/uploads/" + consoFilename);
        string Consodest = QuaterPath + "\\" + consoFilename;
        File.Copy(Conso, Consodest, true);


        if (!File.Exists(generatetextfilename))
        {
            fs = File.Create(generatetextfilename);
            fs.Close();

            ds.Tables[0].WriteXml(generatexmlfilename);
            var ss = File.ReadAllText(generatexmlfilename).ToString().Replace("<NewDataSet>", "").Replace("</NewDataSet>", "").Replace("<Table>", "").Replace("</Table>", "").Replace("<Column1>", "").Replace("</Column1>", "").Replace("<?xml version=\"1.0\" standalone=\"yes\"?>", "");
            var html = File.ReadAllText(generatexmlfilename).ToString().Replace("<Table />", "").Replace("<NewDataSet>", "<table width='100%' border='1' cellpadding='0' cellspacing='0'>").Replace("</NewDataSet>", "</table></body></html>").Replace("<Table>", "<tr>").Replace("</Table>", "</tr>").Replace("<Column1>", "<td>").Replace("</Column1>", "</td>").Replace("<?xml version=\"1.0\" standalone=\"yes\"?>", "<html><body><table align='center'><tr><td style='color: Red;'>Text File Form Type:- 26Q Quarter:- Q2 Date:- 04-11-2022</td></tr></table><br /><br />");
            File.WriteAllText(generatetextfilename, ss.Trim().Replace(" \r\n ", "").Replace("\r\n    ", "\r\n").Replace("<Table />", "").Replace("\n", "").Replace("amp;", ""));
            fs = File.Create(generatehtmlfile);
            fs.Close();
            File.WriteAllText(generatehtmlfile, html);


            string filename = Server.MapPath("~/eReturns/TDS_STANDALONE_FVU.jar");//"c:\\tds_fvu\\tds.jar";
                                                                                  //File.Copy(Server.MapPath("~/eReturns/NSDL-Root.cer"), QuaterPath + "\\NSDL-Root.cer");
            fs = File.Create(fileformtype + ".bat");

            ///////// Creating Batch file, Change this when the validation utility version changes.
            using (StreamWriter sw = new StreamWriter(fs))
            {
                Stopwatch sww = new Stopwatch();
                sww.Start();
                //sw.WriteLine("start javaw -jar " + filename + " " + string.Format("\"{0}\"", generatetextfilename) + " " + string.Format("\"{0}\"", fileformtype + ".err") + " " + string.Format("\"{0}\"", fileformtype + ".fvu") + " " + @"""0""" + " " + @"""7.5""" + " " + @"""1""" + " " + string.Format("\"{0}\"", QuaterPath + "\\" + CSIName + ""));
                sw.WriteLine("start javaw -jar " + filename + " " + string.Format("\"{0}\"", generatetextfilename) + " " + string.Format("\"{0}\"", fileformtype + ".err") + " " + string.Format("\"{0}\"", fileformtype + ".fvu") + " " + @"""0""" + " " + @"""8.0""" + " " + @"""1""" + " " + CSIName + "  " + string.Format("\"{0}\"", QuaterPath + "\\" + consoFilename + ""));
                sww.Stop();
                TimeSpan ts = sww.Elapsed;
                string elapsedTime = String.Format("{0:00}:{1:00}:{2:00}.{3:00}", ts.Hours, ts.Minutes, ts.Seconds, ts.Milliseconds / 10);
            }
            fs.Close();
            string sucessfile = "";
            string SuccessFvu = "";
            string Successerr = "";
            try
            {

                string vss = Server.MapPath("~/Validate");
                vss = vss + "\\" + TAN + ".txt";
                fs = File.Create(vss);
                ///////// Creating Batch file, Change this when the validation utility version changes.
                using (StreamWriter sw = new StreamWriter(fs))
                {
                    sw.Write(fileformtype + ".bat");
                }
                fs.Close();

                bool isexit = false;
                for (int i = 0; i <= 50; i++)
                {

                    string errfile = QuaterPath + @"\" + frm + Qua + "err.html";
                    sucessfile = QuaterPath + @"\27A_" + TAN + "_" + frm + "_" + Qua + "_" + a + ".pdf";

                    if (File.Exists(sucessfile) == true)
                    {
                        isexit = true;
                        break;
                    }


                    if (isexit)
                    {
                        break;
                    }
                    System.Threading.Thread.Sleep(5000);
                }
            }
            catch (Exception ex)
            {

            }

            System.Threading.Thread.Sleep(5000);
            using (ZipFile zip = new ZipFile())
            {

                int SuccessTrue = 0;
                string[] filePaths = Directory.GetFiles(QuaterPath);
                foreach (string filePath in filePaths)
                {
                    string errfile = QuaterPath + @"\" + frm + Qua + "err.html";
                    sucessfile = QuaterPath + @"\27A_" + TAN + "_" + frm + "_" + Qua + "_" + a + ".pdf";
                    if (filePath.ToLower() == errfile.ToLower())
                    {
                        Successerr = errfile;

                    }
                    if (filePath.ToLower() == sucessfile.ToLower())
                    {
                        SuccessTrue = 1;
                        SuccessFvu = @"\" + frm + Qua + ".fvu";
                        SuccessTrue = 1;

                    }
                    if (filePath.ToLower() == (fileformtype + ".bat").ToLower() || filePath.ToLower() == (QuaterPath + "\\NSDL-Root.cer").ToLower())
                    { }
                    else
                    {
                        if (File.Exists(filePath))
                            zip.AddFile(filePath, "Files");
                    }
                }
                //string[] close1msg = closeMessageWindow.ret("Message");
                zip.Save(QuaterPath + "/" + TAN + "_" + Fy + frm + Qua + ".zip");
                sucessfile = QuaterPath + "/" + TAN + "_" + Fy + frm + Qua + ".zip";
                if (SuccessTrue == 1)
                {
                    zip.AddFile(SuccessFvu, "Files");
                    zip.Save(QuaterPath + "/" + TAN + "_" + Fy + frm + Qua + "FVU.zip");
                }
                SuccessFvu = QuaterPath + "/" + TAN + "_" + Fy + frm + Qua + "FVU.zip";
                System.Threading.Thread.Sleep(2000);

            }

            objResult.Add(new Correction_Obj()
            {
                CSuccess = Convert.ToString(sucessfile.ToString()),
                CSuccessFVU = Convert.ToString(SuccessFvu.ToString()),
                CError = Convert.ToString(Successerr.ToString()),
            });

        }
        IEnumerable<Correction_Obj> tbl = objResult;
        return new JavaScriptSerializer().Serialize(tbl);
    }
}