<%@ WebService Language="C#" Class="Dashboard" %>

using System;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
using System.Data;
//using CommonLibrary;
using LibCommon;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using System.Globalization;
using System.IO;
using Ionic.Zip;
using Microsoft.ApplicationBlocks1.Data;
using System.Web.Services.Protocols;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Data.OleDb;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System.Net;
using EntityLibrary;




[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class Dashboard : System.Web.Services.WebService
{

    public static CultureInfo ci = new CultureInfo("en-GB");

    DALCommonLib objComm = new DALCommonLib();
    Functions4evr Comm = new Functions4evr();

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetonLoad(int compid, string Q, string F, string Conn)
    {
        List<tbl_Dashboard> obj = new List<tbl_Dashboard>();
        try
        {

            if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
            {
                HttpContext.Current.Session["Financial_Year_Text"] = Conn;
            }
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@Company_ID", compid);
            param[1] = new SqlParameter("@Quarter", Q);
            param[2] = new SqlParameter("@Form", F );
            string sp = "";
            if (F == "24Q")
            {
                sp = "Usp_Dashboard_Sal";
            }
            else
            {
                sp = "Usp_Dashboard_NonSal";
            }

            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, sp, param))
            {

                while (drrr.Read())
                {
                    obj.Add(new tbl_Dashboard()
                    {

                        compid = Comm.GetValue<int>(drrr["Company_id"].ToString()),

                    });
                }

                List<tbl_VoucherModifyGrd> listGrd = new List<tbl_VoucherModifyGrd>();

                if (drrr.NextResult())
                {
                    if (drrr.HasRows)
                    {
                        while (drrr.Read())
                        {
                            listGrd.Add(new tbl_VoucherModifyGrd()
                            {
                                AmtPaid = Comm.GetValue<double>(drrr["Voucher_Amount"].ToString()),
                                sec = Comm.GetValue<string>(drrr["section"].ToString()),
                                TdsAmt = Comm.GetValue<double>(drrr["TDS_Amt"].ToString()),
                                TdsRate = Comm.GetValue<string>(drrr["TRate"].ToString()),
                                Totalcount = Comm.GetValue<int>(drrr["vCount"].ToString()),

                            });
                        }
                    }
                }


                List<tbl_VoucherModify> listVoucher = new List<tbl_VoucherModify>();

                if (drrr.NextResult())
                {
                    if (drrr.HasRows)
                    {
                        while (drrr.Read())
                        {
                            listVoucher.Add(new tbl_VoucherModify()
                            {
                                AmtPaid = Comm.GetValue<double>(drrr["Amt"].ToString()),
                                TdsAmt = Comm.GetValue<double>(drrr["TDS"].ToString()),
                                nid = Comm.GetValue<int>(drrr["Invalid"].ToString()),
                                Total = Comm.GetValue<double>(drrr["UPaid"].ToString()),
                                did = Comm.GetValue<int>(drrr["did"].ToString()),
                                VCCA = Comm.GetValue<int>(drrr["CCA"].ToString()),
                                UVCCA = Comm.GetValue<int>(drrr["UCCA"].ToString()),
                                RToken = Comm.GetValue<string>(drrr["RToken"].ToString()),
                            });
                        }
                    }
                }

                List<objChallanDetails> listChallan = new List<objChallanDetails>();

                if (drrr.NextResult())
                {
                    if (drrr.HasRows)
                    {
                        while (drrr.Read())
                        {
                            listChallan.Add(new objChallanDetails()
                            {
                                ChallanID = Comm.GetValue<int>(drrr["Cid"].ToString()),
                                CAmount = Comm.GetValue<double>(drrr["Camt"].ToString()),
                                Verify = Comm.GetValue<string>(drrr["Verify"].ToString()),
                                ndVrfy = Comm.GetValue<string>(drrr["NeedVerfy"].ToString()),
                            });
                        }
                    }
                }

                List<tbl_Section> listSection = new List<tbl_Section>();

                if (drrr.NextResult())
                {
                    if (drrr.HasRows)
                    {
                        while (drrr.Read())
                        {
                            listSection.Add(new tbl_Section()
                            {
                                Section = Comm.GetValue<string>(drrr["section"].ToString()),
                                Tds_Amt = Comm.GetValue<double >(drrr["tds"].ToString()),
                            });
                        }
                    }
                }

                foreach (var item in obj)
                {
                    item.VoucherGrd = listGrd;
                    item.VoucherModify = listVoucher;
                    item.Challan = listChallan;
                    item.Section = listSection;
                }
            }



        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        IEnumerable<tbl_Dashboard> tbl =  obj;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetReturns_details(int compid, string Q, string F, string TanNo, string Conn)
    {
        string path, SuccessFilePath, ErrorFilePath, ZipFilePath, xlPath;
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
                result[2] = "../../eReturns/Regular/" + TanNo + "/" + obj.ST + "/" + F + "/" + Q + "/" + TanNo + "_" + obj.ST + F + Q + ".zip";
                FileInfo info = new FileInfo(ZipFilePath);
                result[1] = info.CreationTime.ToString("dd/MM/yyyy");
                result[3] = "../../eReturns/Regular/" + TanNo + "/" + obj.ST + "/" + F + "/" + Q + "/" + "27A_" + TanNo + "_" + F + "_" + Q + "_" + obj.ST + ".pdf";
            }
            else if (File.Exists(ErrorFilePath))
            {
                result[0] = "Error";
                result[2] = "../../eReturns/Regular/" + TanNo + "/" + obj.ST + "/" + F + "/" + Q + "/" + TanNo + "_" + obj.ST + F + Q + ".zip";
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
        List<tbl_Dashboard> obj_Dash = new List<tbl_Dashboard>();

        obj_Dash.Add(new tbl_Dashboard()
        {

            Rstatus = Comm.GetValue<string>(result[0].ToString()),
            ST = Comm.GetValue<string>(result[1].ToString()),
            Rfile = Comm.GetValue<string>(result[2].ToString()),
            Pfile = Comm.GetValue<string>(result[3].ToString()),
            XLPath = Comm.GetValue<string>(xlPath.ToString()),
        });


        IEnumerable<tbl_Dashboard> tbl =  obj_Dash;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Get_VerifiedChallans(int compid, string Q, string F, string Conn)
    {
            List<objChallanDetails> obj_Dash = new List<objChallanDetails>();
 
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        objChallanDetails tobj = new objChallanDetails();

        string ChallanNo = "";
        string ChallanDate = "";
        int Challanid = 0;
        string FinancialStart = "";
        string FinancialEnd = "";


        string sp = "";
        if (tobj.FormType == "24Q")
        {
            sp = "usp_Challan_Salary_Verify";
        }
        else
        {
            sp = "usp_Get_Queter_Selection_Challan_Non_Salary_Grid";
        }
        SqlParameter[] param = new SqlParameter[7];
        param[0] = new SqlParameter("@CompanyID", compid);
        param[1] = new SqlParameter("@FinancialStart", FinancialStart);
        param[2] = new SqlParameter("@FinancialEnd", FinancialEnd);
        param[3] = new SqlParameter("@ChallanDate", ChallanDate);
        param[4] = new SqlParameter("@ChallanNo", ChallanNo);
        param[5] = new SqlParameter("@Quater", Q);
        param[6] = new SqlParameter("@Form_Type", F);

        using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, sp, param))
        {
            while (drrr.Read())
            {
                obj_Dash.Add(new objChallanDetails()
                {

                    ChallanNo = Comm.GetValue<string>(drrr["Challan_No"].ToString()),
                    ChallanDate = Comm.GetValue<string>(drrr["Challan_Date"].ToString()),
                    BSR = Comm.GetValue<string>(drrr["Bank_Bsrcode"].ToString()),
                    CAmount = Comm.GetValue<double>(drrr["Challan_Amount"].ToString()),
                    Verify = Comm.GetValue<string>(drrr["Trans_No"].ToString()),
                    Sec = Comm.GetValue<string>(drrr["Section"].ToString()),
                    Interest = Comm.GetValue<float>(drrr["Interest_Amt"].ToString()),
                    TDS = Comm.GetValue<float>(drrr["TDS_Amount"].ToString()),
                    CTotal  = Comm.GetValue<double >(drrr["TotalEmployee"].ToString()),

                });
            }

        }

        IEnumerable<objChallanDetails> tbl =  obj_Dash;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string SaveToken(int compid, string Q, string F, string T, string Conn)
    {
 
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        tbl_Dashboard tobj = new tbl_Dashboard();
        tobj.Formtype = F;
        tobj.Quater = Q;
        tobj.RToken = T;
        tobj.compid = compid;
 
        List<tbl_Dashboard> obj_Dash = new List<tbl_Dashboard>();
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@compid", tobj.compid);
            param[1] = new SqlParameter("@TokenNo", tobj.RToken);
            param[2] = new SqlParameter("@Qtr", tobj.Quater);
            param[3] = new SqlParameter("@ftype", tobj.Formtype);


        using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "usp_Insert_TokenNo", param))
        {
            while (drrr.Read())
            {
                obj_Dash.Add(new tbl_Dashboard()
                {

                    compid = Comm.GetValue<int>(drrr["Compid"].ToString()),

                });
            }
        }


        IEnumerable<tbl_Dashboard> tbl =  obj_Dash;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }



    [System.Web.Services.WebMethod(EnableSession = true)]
    public string ViewfvuZIP(tblGetColData tobj)
    {
        string[] result = new string[4];
        string path, ZipFilePath, ZipPath, ZFile;
        string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
        tbl_Dashboard obj = new tbl_Dashboard();
        obj.ST = financialyear[0];
        obj.ED = financialyear[1];
        obj.ST = obj.ST + obj.ED;
        path = Server.MapPath("~/eReturns/Regular");
        try
        {
            ZipFilePath = path + "\\" + tobj.TanNo + "\\" + obj.ST + "\\" + tobj.FormType + "\\" + tobj.Quater + "\\" + tobj.FormType + tobj.Quater + ".fvu";
            ZFile = path + "\\" + tobj.TanNo + "\\" + obj.ST + "\\" + tobj.FormType + "\\" + tobj.Quater + "\\" + tobj.FormType + tobj.Quater + "_Fvu.zip";
            //../eReturns/Regular/MUMA09455F/202122/26Q/Q1/MUMA09455F_20212226QQ1.zip
            ZipPath = "../../eReturns/Regular/" + tobj.TanNo + "/" + obj.ST + "/" + tobj.FormType + "/" + tobj.Quater + "/" + tobj.FormType + tobj.Quater + "_Fvu.zip";
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

        List<tbl_Dashboard> obj_Dash = new List<tbl_Dashboard>();
        obj_Dash.Add(new tbl_Dashboard()
        {
            Rfile = Comm.GetValue<string>(ZipPath),
        });

        IEnumerable<tbl_Dashboard> tbl =  obj_Dash;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);

    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string ViewErrorZIP(tblGetColData tobj)
    {
        string[] result = new string[4];
        string path, ZipFilePath, ZipPath, ZFile;
        string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
        tbl_Dashboard obj = new tbl_Dashboard();
        obj.ST = financialyear[0];
        obj.ED = financialyear[1];
        obj.ST = obj.ST + obj.ED;
        path = Server.MapPath("~/eReturns/Regular");
        try
        {
            ZipFilePath = path + "\\" + tobj.TanNo + "\\" + obj.ST + "\\" + tobj.FormType + "\\" + tobj.Quater + "\\" + tobj.FormType + tobj.Quater + "err.html";

            ZFile = path + "\\" + tobj.TanNo + "\\" + obj.ST + "\\" + tobj.FormType + "\\" + tobj.Quater + "\\" + tobj.FormType + tobj.Quater + "_err.zip";
            //../eReturns/Regular/MUMA09455F/202122/26Q/Q1/MUMA09455F_20212226QQ1.zip
            ZipPath = "../../eReturns/Regular/" + tobj.TanNo + "/" + obj.ST + "/" + tobj.FormType + "/" + tobj.Quater + "/" + tobj.FormType + tobj.Quater + "_err.zip";
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
 
        List<tbl_Dashboard> obj_Dash = new List<tbl_Dashboard>();
        obj_Dash.Add(new tbl_Dashboard()
        {
            Rfile = Comm.GetValue<string>(ZipPath),
        });
        IEnumerable<tbl_Dashboard> tbl =  obj_Dash;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);

    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string ViewDownloadAllZIP(tblGetColData tobj)
    {
        string[] result = new string[4];
        string path, FVUFilePath, ZipPath, ZFile, SuccessFilePath, ErrorFilePath;
        string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
        tbl_Dashboard obj = new tbl_Dashboard();
        obj.ST = financialyear[0];
        obj.ED = financialyear[1];
        obj.ST = obj.ST + obj.ED;
        path = Server.MapPath("~/eReturns/Regular");


        try
        {
            ErrorFilePath = path + "\\" + tobj.TanNo + "\\" + obj.ST + "\\" + tobj.FormType + "\\" + tobj.Quater + "\\" + tobj.FormType + tobj.Quater + "err.html";
            FVUFilePath = path + "\\" + tobj.TanNo + "\\" + obj.ST + "\\" + tobj.FormType + "\\" + tobj.Quater + "\\" + tobj.FormType + tobj.Quater + ".fvu";
            SuccessFilePath = path + "\\" + tobj.TanNo + "\\" + obj.ST + "\\" + tobj.FormType + "\\" + tobj.Quater + @"\27A_" + tobj.TanNo + "_" + tobj.FormType + "_" + tobj.Quater + "_" + obj.ST + ".pdf";

            ZFile = path + "\\" + tobj.TanNo + "\\" + obj.ST + "\\" + tobj.FormType + "\\" + tobj.Quater + "\\" + tobj.FormType + tobj.Quater + "_All.zip";
            //../eReturns/Regular/MUMA09455F/202122/26Q/Q1/MUMA09455F_20212226QQ1.zip
            ZipPath = "../../eReturns/Regular/" + tobj.TanNo + "/" + obj.ST + "/" + tobj.FormType + "/" + tobj.Quater + "/" + tobj.FormType + tobj.Quater + "_All.zip";

            if (File.Exists(ZFile) == false)
            {
                using (ZipFile zip = new ZipFile())
                {
                    if (File.Exists(ErrorFilePath) == true)
                    {
                        zip.AddFile(ErrorFilePath, "Files");
                    }
                    if (File.Exists(FVUFilePath) == true)
                    {
                        zip.AddFile(FVUFilePath, "Files");
                    }
                    if (File.Exists(SuccessFilePath) == true)
                    {
                        zip.AddFile(SuccessFilePath, "Files");
                    }
                    zip.Save(ZFile);
                }
            }


            if (File.Exists(ZFile) == false)
            {
                ZipPath = "File does not exist";
            }

        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
 
        List<tbl_Dashboard> obj_Dash = new List<tbl_Dashboard>();
        obj_Dash.Add(new tbl_Dashboard()
        {
            Rfile = Comm.GetValue<string>(ZipPath),
        });

        IEnumerable<tbl_Dashboard> tbl =  obj_Dash;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);

    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string View27APdfZIP(tblGetColData tobj)
    {
        string[] result = new string[4];
        string path, ZipFilePath, ZipPath, ZFile;
        string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
        tbl_Dashboard obj = new tbl_Dashboard();
        obj.ST = financialyear[0];
        obj.ED = financialyear[1];
        obj.ST = obj.ST + obj.ED;
        path = Server.MapPath("~/eReturns/Regular");
        try
        {

            if (string.IsNullOrEmpty(tobj.TanNo))
            {
                tobj.TanNo = GetPanNo(Convert.ToInt32(Convert.ToInt32(Session["companyid"].ToString()))).panno;
            }

            ZipFilePath = path + "\\" + tobj.TanNo + "\\" + obj.ST + "\\" + tobj.FormType + "\\" + tobj.Quater  + @"\27A_" + tobj.TanNo + "_" + tobj.FormType + "_" + tobj.Quater + "_" + obj.ST + ".pdf";
            ZFile = path + "\\" + tobj.TanNo + "\\" + obj.ST + "\\" + tobj.FormType + "\\" + tobj.Quater + "\\" + tobj.FormType + tobj.Quater + "_27A.zip";
            //../eReturns/Regular/MUMA09455F/202122/26Q/Q1/MUMA09455F_20212226QQ1.zip
            ZipPath = "../../eReturns/Regular/" + tobj.TanNo + "/" + obj.ST + "/" + tobj.FormType + "/" + tobj.Quater + "/" + tobj.FormType + tobj.Quater + "_27A.zip";
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
 
        List<tbl_Dashboard> obj_Dash = new List<tbl_Dashboard>();
        obj_Dash.Add(new tbl_Dashboard()
        {
            Rfile = Comm.GetValue<string>(ZipPath),
        });
        IEnumerable<tbl_Dashboard> tbl =  obj_Dash;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);

    }



    [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetVoucherAndChallanDetails(tblGetColData tobj)
    {
        DataSet ds;
        VoucChallWithRetuDeta VoucChallWithRetuDeta = new VoucChallWithRetuDeta();

        string path, SuccessFilePath, ErrorFilePath, ZipFilePath, xlPath;
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@Quater", tobj.Quater);
        param[1] = new SqlParameter("@companyId", Convert.ToInt32(Session["companyid"].ToString()));
        param[2] = new SqlParameter("@formType", tobj.FormType);
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(tobj.ConnectionString))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = tobj.ConnectionString;
        }

        string SP = "";
        if (tobj.FormType == "24Q")
        {
            SP = "usp_BootStrap_Dashboard_Sal";
        }
        else
        {
            SP = "usp_BootStrap_Dashboard_NonSal";
        }

        ds = SqlHelper.ExecuteDataset(objComm._cnnString2, CommandType.StoredProcedure, SP, param);
        if (ds.Tables[0].Rows.Count > 0)
        {
            VoucChallWithRetuDeta.VouchersOrDeductions = Convert.ToDouble(ds.Tables[0].Rows[0]["VoucherAmount"].ToString());
            VoucChallWithRetuDeta.TaxDeducted = Convert.ToDouble(ds.Tables[0].Rows[0]["TdsAmountDedu"].ToString());
            VoucChallWithRetuDeta.ChallansOrTaxDeposited = Convert.ToDouble(ds.Tables[0].Rows[0]["TdsAmountDepo"].ToString());
            VoucChallWithRetuDeta.Diffrence = VoucChallWithRetuDeta.ChallansOrTaxDeposited - VoucChallWithRetuDeta.TaxDeducted;
        }
        if (tobj.FormType != "24Q")
        {
            if (ds.Tables[1].Rows.Count > 0)
            {
                VoucChallWithRetuDeta.Active = Convert.ToInt32(ds.Tables[1].Rows[0]["Active"].ToString());
                VoucChallWithRetuDeta.InActive = Convert.ToInt32(ds.Tables[1].Rows[0]["InActive"].ToString());
                VoucChallWithRetuDeta.NotVerified = Convert.ToInt32(ds.Tables[1].Rows[0]["NotVerified"].ToString());
                VoucChallWithRetuDeta.InValid = Convert.ToInt32(ds.Tables[1].Rows[0]["Invalid"].ToString());
            }

            if (ds.Tables[2].Rows.Count > 0)
            {
                VoucChallWithRetuDeta.LTAN = ds.Tables[2].Rows[0]["TAN"].ToString();
                VoucChallWithRetuDeta.TUser = ds.Tables[2].Rows[0]["User_ID"].ToString();
                VoucChallWithRetuDeta.TPass = ds.Tables[2].Rows[0]["Password"].ToString();

            }
            if (ds.Tables[3].Rows.Count > 0)
            {
                //VoucChallWithRetuDeta.LTAN = Convert.ToInt32(ds.Tables[3].Rows[0]["TAN"].ToString());
                //VoucChallWithRetuDeta.IUser = Convert.ToInt32(ds.Tables[3].Rows[0]["IUser_ID"].ToString());
                VoucChallWithRetuDeta.IPass = ds.Tables[3].Rows[0]["IPassword"].ToString();

            }

        }
        else
        {
            if (ds.Tables[1].Rows.Count > 0)
            {
                VoucChallWithRetuDeta.LTAN = ds.Tables[1].Rows[0]["TAN"].ToString();
                VoucChallWithRetuDeta.TUser = ds.Tables[1].Rows[0]["User_ID"].ToString();
                VoucChallWithRetuDeta.TPass = ds.Tables[1].Rows[0]["Password"].ToString();

            }
            if (ds.Tables[2].Rows.Count > 0)
            {
                //VoucChallWithRetuDeta.LTAN = Convert.ToInt32(ds.Tables[3].Rows[0]["TAN"].ToString());
                //VoucChallWithRetuDeta.IUser = Convert.ToInt32(ds.Tables[3].Rows[0]["IUser_ID"].ToString());
                VoucChallWithRetuDeta.IPass = ds.Tables[2].Rows[0]["IPassword"].ToString();

            }

        }


        string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
        tbl_Dashboard obj = new tbl_Dashboard();
        obj.ST = financialyear[0];
        obj.ED = financialyear[1];
        obj.ST = obj.ST + obj.ED;
        path = Server.MapPath("~/eReturns/Regular");
        xlPath = "";

        if (string.IsNullOrEmpty(tobj.TanNo))
        {
            tobj.TanNo = GetPanNo(Convert.ToInt32(Convert.ToInt32(Session["companyid"].ToString())) ).panno;
        }
        string fPath = "../../eReturns/Regular";
        SuccessFilePath = path + "\\" + tobj.TanNo + "\\" + obj.ST + "\\" + tobj.FormType + "\\" + tobj.Quater + @"\27A_" + tobj.TanNo + "_" + tobj.FormType + "_" + tobj.Quater + "_" + obj.ST + ".pdf";
        ZipFilePath = path + "\\" + tobj.TanNo + "\\" + obj.ST + "\\" + tobj.FormType + "\\" + tobj.Quater + @"\" + tobj.TanNo.ToUpper() + "_" + obj.ST +  tobj.FormType + tobj.Quater + ".zip";
        ErrorFilePath = path + "\\" + tobj.TanNo + "\\" + obj.ST + "\\" + tobj.FormType + "\\" + tobj.Quater + @"\" +  tobj.FormType + tobj.Quater + "err.html";
        if (Directory.Exists(path))
        {
            if (File.Exists(SuccessFilePath))
            {
                VoucChallWithRetuDeta.ReturnStatus = "Success";
                FileInfo info = new FileInfo(SuccessFilePath);
                VoucChallWithRetuDeta.fPath = fPath +  "/" + tobj.TanNo + "/" + obj.ST + "/" + tobj.FormType + "/" + tobj.Quater + "/" + tobj.TanNo.ToUpper() + "_" + obj.ST +  tobj.FormType + tobj.Quater + ".zip";
                VoucChallWithRetuDeta.ReturnDate = info.CreationTime;
                VoucChallWithRetuDeta.ReturnDateStr = info.CreationTime.ToString("dd/MM/yyyy");

            }
            else if (File.Exists(ErrorFilePath))
            {
                VoucChallWithRetuDeta.ReturnStatus = "Error";
                FileInfo info = new FileInfo(ErrorFilePath);
                VoucChallWithRetuDeta.fPath =fPath +  "/" + tobj.TanNo + "/" + obj.ST + "/" + tobj.FormType + "/" + tobj.Quater + "/" + tobj.TanNo.ToUpper() + "_" + obj.ST +  tobj.FormType + tobj.Quater + ".zip"; //ZipFilePath;
                VoucChallWithRetuDeta.ReturnDate = info.CreationTime;
                VoucChallWithRetuDeta.ReturnDateStr = info.CreationTime.ToString("dd/MM/yyyy");
            }

        }


        ////  obj_Bal_Correction.Get_Details(Challan);
        return new JavaScriptSerializer().Serialize(VoucChallWithRetuDeta);

    }

    private Pan_No GetPanNo(int compid)
    {
         Functions4evr objComm = new  Functions4evr();

        DALCommonLib objCom = new DALCommonLib();
        Pan_No obj_Pan = new Pan_No();
        try
        {
            //Common ob = new Common();
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@Companyid", compid);
            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objCom.cnnstring, CommandType.StoredProcedure, "Usp_Get_PANNo", param))
            {
                while (drrr.Read())
                {

                    obj_Pan.panno = objComm.GetValue<string>(drrr["TANNo"].ToString());
                    obj_Pan.Gstn = objComm.GetValue<string>(drrr["GSTN"].ToString());

                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

        return obj_Pan;
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string SaveTraces(string T, string L, string P)
    {
         Functions4evr objComm = new  Functions4evr();
        List<tbl_Dashboard> obj = new List<tbl_Dashboard>();
        DALCommonLib objCom = new DALCommonLib();

        try
        {
            //Common ob = new Common();
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@Compid", Session["companyid"]);
            param[1] = new SqlParameter("@Tan", T);
            param[2] = new SqlParameter("@Userid", L);
            param[3] = new SqlParameter("@Pass", P);
            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objCom.cnnstring, CommandType.StoredProcedure, "usp_Bootstrap_Insert_TracesDetails", param))
            {
                while (drrr.Read())
                {
                    obj.Add(new tbl_Dashboard()
                    {
                        LTAN = objComm.GetValue<string>(drrr["TAN"].ToString()),
                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

        IEnumerable<tbl_Dashboard> tbl = obj;
        return new JavaScriptSerializer().Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string SaveITax(string T, string P)
    {
         Functions4evr objComm = new  Functions4evr();
        List<tbl_Dashboard> obj = new List<tbl_Dashboard>();
        DALCommonLib objCom = new DALCommonLib();

        try
        {
            //Common ob = new Common();
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@compid",  Session["companyid"]);
            param[1] = new SqlParameter("@Tan",  T);
            param[2] = new SqlParameter("@Pass",  P);
            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objCom.cnnstring, CommandType.StoredProcedure, "Usp_Get_PANNo", param))
            {
                while (drrr.Read())
                {
                    obj.Add(new tbl_Dashboard()
                    {
                        LTAN = objComm.GetValue<string>(drrr["TAN"].ToString()),
                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

        IEnumerable<tbl_Dashboard> tbl = obj;
        return new JavaScriptSerializer().Serialize(tbl);
    }




    [System.Web.Services.WebMethod(EnableSession = true)]
    public string BackupDetails(string F, string Q)
    {
         Functions4evr objComm = new  Functions4evr();
        List<tbl_Dashboard> obj = new List<tbl_Dashboard>();
        DALCommonLib objCom = new DALCommonLib();

        try
        {
            HttpContext.Current.Session["Form"] = F;
            HttpContext.Current.Session["Quater"] = Q;
        }
        catch (Exception ex)
        {
            throw ex;
        }

        IEnumerable<tbl_Dashboard> tbl = obj;
        return new JavaScriptSerializer().Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public void ExportBackupExcel()
    {

        DALCommonLib obj = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
         Functions4evr objComm = new  Functions4evr();
        DataTable reportDataTable = new DataTable();


        DateTime? startDate = null;
        DateTime? endDate = null;
        ResonseType resonseType = new ResonseType();
        string startDateStr = "", endDatestr = "";
        string results = "";
        try
        {
            if (!string.IsNullOrEmpty(startDateStr))
            {
                startDate = Convert.ToDateTime(startDateStr);
            }
            if (!string.IsNullOrEmpty(endDatestr))
            {
                endDate = Convert.ToDateTime(endDatestr);
            }



            int Compid = Convert.ToInt32(Session["companyid"].ToString());
            string formType  = Session["Form"].ToString();
            string Qtr = Session["Quater"].ToString();

            SqlParameter[] objSqlParameter = new SqlParameter[3];
            objSqlParameter[0] = new SqlParameter("@companyId", Compid);
            objSqlParameter[1] = new SqlParameter("@formType", formType);
            objSqlParameter[2] = new SqlParameter("@Qtr", Qtr);

            DataSet  ds = SqlHelper.ExecuteDataset(obj._cnnString2, "usp_Bootstrap_BackupforVoucherChallance_Qtr", objSqlParameter);

            if (ds.Tables[1].Rows.Count > 0 || ds.Tables[0].Rows.Count > 0)
            {

                SqlParameter[] LogSqlParameter = new SqlParameter[2];


                LogSqlParameter[0] = new SqlParameter("@companyId", Compid);
                LogSqlParameter[1] = new SqlParameter("@formType", formType);

                DataSet dsLg = SqlHelper.ExecuteDataset(obj._cnnString2, "BTS_CreateBackupEntryLog", LogSqlParameter);
                resonseType.filePath = DumpChallanVoucherExcel(ds, true, Context);
                resonseType.isPass = true;
            }
            else
            {
                resonseType.filePath = "No records to export";
            }

            HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
            HttpContext.Current.Response.ContentType = "text/json";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(resonseType));
        }
        catch (Exception ex)
        {

        }

    }

    private string DumpChallanVoucherExcel(DataSet ds, bool isBackup,HttpContext context)
    {
        Random rn = new Random();
        string folderPath = HttpContext.Current.Server.MapPath("~/Uploads/");
        string templatefile = string.Empty;
        templatefile = HttpContext.Current.Server.MapPath("~/BTStrp/Templates/")+Convert.ToString(context.Session["form"]) + "_Blank_XLSheet.xlsx";
        string exportFile = string.Empty;
        exportFile = folderPath + rn.Next().ToString() + "2324_BlankTemplate.xlsx";
        if (isBackup)
        {
            templatefile = HttpContext.Current.Server.MapPath("~/BTStrp/Templates/")+Convert.ToString(context.Session["form"]) + "_Blank_XLSheet.xlsx";
            exportFile = folderPath +Convert.ToString(context.Session["TANNo"])+"_"+ Convert.ToString(context.Session["form"]) +"_"+ DateTime.Now.ToString("dd-MMM-yyyy").Replace("-", "_") + ".xlsx";
        }

        FileInfo file = new FileInfo(exportFile);
        try
        {


            File.Copy(templatefile, exportFile,true);
            using (ExcelPackage pck = new ExcelPackage(file))
            {
                ExcelWorkbook excelWorkBook = pck.Workbook;
                ExcelWorksheet excelWorksheet = excelWorkBook.Worksheets[1];

                if (ds.Tables[0].Rows.Count > 0)
                {

                    excelWorksheet.Cells["A4"].LoadFromDataTable(ds.Tables[0], false);
                    excelWorksheet.Cells.AutoFitColumns();
                }
                ExcelWorksheet excelWorksheet2 = excelWorkBook.Worksheets[2];
                if (ds.Tables[1].Rows.Count > 0)
                {
                    excelWorksheet2.Cells["A4"].LoadFromDataTable(ds.Tables[1], false);
                    excelWorksheet2.Cells.AutoFitColumns();
                }
                pck.Save();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {


        }
        return "../../Uploads/" + file.Name;
    }

}