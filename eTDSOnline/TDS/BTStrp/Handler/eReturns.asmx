<%@ WebService Language="C#" Class="eReturns" %>


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
public class eReturns  : System.Web.Services.WebService {

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
    public string CreateTxt(int cid, int compid, string Qua, string frm, string Fy, string TAN)
    {
        List<Correction_Obj> objResult = new List<Correction_Obj>();

        string eReturnspath = Server.MapPath("~/eReturns/regular");
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

        string CsiErr = "";
        string csiSts = "";
        //csiSts = hdnCheckCSI.Value;
        if (csiSts == "0")
        {
            Session["CSI"] = "";
            CsiErr = "";
        }

        if (Session["CSIFilename"].ToString() == "")
        {
            CsiErr = "Err";
            //if (FileUploadCSI.FileName == "")
            //{
            //    CsiErr = "Err";
            //}
            //else
            //{
            //    CsiErr = "1";
            //}
        }
        else
        {
            CsiErr = Session["CSIFilename"].ToString();

        }

        if (CsiErr == "Err")
        {
            //ucMessageControl.SetMessage("Please Upload CSI File ." + Session["CSIFilename"].ToString(), MessageDisplay.DisplayStyles.Error);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "alertEmployee1", "CSIError();", true);
        }
        else if (CsiErr == "")
        {
            //ucMessageControl.SetMessage("Please Upload CSI File ." + Session["CSIFilename"].ToString(), MessageDisplay.DisplayStyles.Error);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "alertEmployee1", "CSIError();", true);
        }
        else
        {


            // fileformtype = QuaterPath + "\\" + ddlFromType.SelectedValue + ddlQuater.SelectedValue;
            generatetextfilename = fileformtype + ".txt";
            generatehtmlfile = fileformtype + ".html";


            string Csifile = "";
            string CsiPath = "";

            //if (FileUploadCSI.FileName != "")
            //{
            //    string cf = FileUploadCSI.FileName;
            //    if (cf.Length > 20)
            //    {
            //        ucMessageControl.SetMessage("CSI file name incorrect, Remove (1) from Name", MessageDisplay.DisplayStyles.Error);
            //        return;
            //    }
            //    //ScriptManager.RegisterStartupScript(this, this.GetType(), "alertEmployee", "CsiSaving()", true);
            //    FileUploadCSI.SaveAs(QuaterPath + "\\" + Path.GetFileName(FileUploadCSI.FileName));
            //    CSIName = FileUploadCSI.FileName;
            //    Csifile = QuaterPath + Path.GetFileName(FileUploadCSI.FileName);
            //    CsiPath = QuaterPath;
            //}
            //else
            //{
            //    string cf = Session["CSIFilename"].ToString();
            //    if (cf.Length > 20)
            //    {
            //        //ucMessageControl.SetMessage("CSI file name incorrect, Remove (1) from Name", MessageDisplay.DisplayStyles.Error);
            //        //return;
            //    }

            //    //ScriptManager.RegisterStartupScript(this, this.GetType(), "alertEmployee", "CsiSaving()", true);
            //    CSIName = Session["CSIFilename"].ToString();
            //    Csifile = QuaterPath + "\\" + Session["CSIFilename"].ToString();
            //    CsiPath = QuaterPath;
            //    string VCS = Session["CSI"].ToString();
            //    VCS = hdnCSIfile.Value;
            //    using (FileStream fileStream = new FileStream(Csifile, FileMode.OpenOrCreate, FileAccess.Write, FileShare.Write))
            //    {
            //        StreamWriter streamWriter = new StreamWriter((Stream)fileStream);
            //        streamWriter.Write(VCS);
            //        streamWriter.Flush();
            //        streamWriter.Close();
            //        fileStream.Close();
            //    }

            //}



            DataSet ds; // = obj_Bal_Correction.BAL_GenerateTextFile(obj);


            SqlParameter[] objSqlParameter = new SqlParameter[8];
            //objSqlParameter[0] = new SqlParameter("@Company_ID", Company_ID);
            //objSqlParameter[1] = new SqlParameter("@Formno", Formno);
            //objSqlParameter[2] = new SqlParameter("@Form", Form);
            //objSqlParameter[3] = new SqlParameter("@PreviousTkn", PreviousTkn);
            //objSqlParameter[4] = new SqlParameter("@PreviousRTN", PreviousRTN);
            //objSqlParameter[5] = new SqlParameter("@aYear", aYear);
            //objSqlParameter[6] = new SqlParameter("@fYear", fYear);
            //objSqlParameter[7] = new SqlParameter("@Quater", Quater);


            ds = SqlHelper.ExecuteDataset(objComm._cnnString, "usp_eReturnsNonSalary", objSqlParameter);

            string generatexmlfilename = fileformtype + ".xml";

            string eMudraname = Server.MapPath("~/eReturns/e-mudhra.cer");
            string eMudraDest = QuaterPath + "\\e-mudhra.cer";
            File.Copy(eMudraname, eMudraDest, true);


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
                    sw.WriteLine("start javaw -jar " + filename + " " + string.Format("\"{0}\"", generatetextfilename) + " " + string.Format("\"{0}\"", fileformtype + ".err") + " " + string.Format("\"{0}\"", fileformtype + ".fvu") + " " + @"""0""" + " " + @"""8.6""" + " " + @"""1""" + " " + string.Format("\"{0}\"", QuaterPath + "\\" + CSIName + ""));
                    //sw.WriteLine("start javaw -jar " + filename + " " + string.Format("\"{0}\"", generatetextfilename) + " " + string.Format("\"{0}\"", fileformtype + ".err") + " " + string.Format("\"{0}\"", fileformtype + ".fvu") + " " + @"""0""" + " " + @"""8.6""" + " " + @"""1""" + " " + CSIName + "  "));
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

        }
            IEnumerable<Correction_Obj> tbl = objResult;
            return new JavaScriptSerializer().Serialize(tbl);
    }

}