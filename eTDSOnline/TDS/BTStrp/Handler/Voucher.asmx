<%@ WebService Language="C#" Class="Voucher" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Data;
using Microsoft.ApplicationBlocks1.Data;
using EntityLibrary;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using System.Globalization;

//using BusinessLayer;
using System.Web.Security;
using LibCommon;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class Voucher : System.Web.Services.WebService
{
    public SqlConnection sqlConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());
    public static CultureInfo ci = new CultureInfo("en-GB");

    [WebMethod(EnableSession = true)]
    public string onLoad(int compid, string Conn, string F, string Q)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
        List<tbl_VoucherDropDowns> obj_Drp = new List<tbl_VoucherDropDowns>();
        tbl_VoucherDropDowns obj = new tbl_VoucherDropDowns();
        obj.compid = compid;
        obj.Conn = Conn;
        string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
        obj.ST = financialyear[0];
        obj.ED = "20" + financialyear[1];
        obj.FormType = F;
        obj.Quater = Q;
        int did = 0;
        try
        {
            SqlParameter[] param = new SqlParameter[6];
            param[0] = new SqlParameter("@DeducteeID", did);
            param[1] = new SqlParameter("@Company_ID", Session["companyid"]);
            param[2] = new SqlParameter("@fstart", obj.ST);
            param[3] = new SqlParameter("@fend", obj.ED);
            param[4] = new SqlParameter("@form", F);
            param[5] = new SqlParameter("@Quater", Q);
            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "Usp_BootStrap_Get_DropDowns", param))
            {
                while (drrr.Read())
                {
                    obj_Drp.Add(new tbl_VoucherDropDowns()
                    {
                        compid = Comm.GetValue<int>(drrr["Compid"].ToString()),
                    });
                }

                List<tbl_VoucherGrd> listGrd = new List<tbl_VoucherGrd>();

                if (drrr.NextResult())
                {
                    if (drrr.HasRows)
                    {
                        while (drrr.Read())
                        {
                            listGrd.Add(new tbl_VoucherGrd()
                            {
                                mth = Comm.GetValue<string>(drrr["Particulars"].ToString()),
                                Entries = Comm.GetValue<int>(drrr["Enteries"].ToString()),
                                Amt = Comm.GetValue<double>(drrr["Voucher_Amount"].ToString()),
                                Tds = Comm.GetValue<double>(drrr["TDS_Amt"].ToString()),
                                mthno = Comm.GetValue<int>(drrr["mth"].ToString()),
                                Tent = Comm.GetValue<int>(drrr["Tent"].ToString()),
                                TAmt = Comm.GetValue<double>(drrr["Vamt"].ToString()),
                                TTds = Comm.GetValue<double>(drrr["Tamt"].ToString()),
                                Upaid = Comm.GetValue<int>(drrr["UP"].ToString()),
                                Tup = Comm.GetValue<int>(drrr["TUP"].ToString()),
                            });
                        }
                    }
                }

                List<objChallanDetails> listChl = new List<objChallanDetails>();

                if (drrr.NextResult())
                {
                    if (drrr.HasRows)
                    {
                        while (drrr.Read())
                        {
                            listChl.Add(new objChallanDetails()
                            {
                                ChallanNo = Comm.GetValue<string>(drrr["challan_no"].ToString()),
                                ChallanDate = Comm.GetValue<string>(drrr["Challan_Date"].ToString()),
                                CDate = Comm.GetValue<string>(drrr["CDate"].ToString()),
                                CAmount = Comm.GetValue<float>(drrr["Challan_Amount"].ToString()),
                                CTotal = Comm.GetValue<double>(drrr["CTotal"].ToString()),
                                Others = Comm.GetValue<double>(drrr["Coth"].ToString()),
                                ChallanID = Comm.GetValue<int>(drrr["Cid"].ToString()),
                                VTds = Comm.GetValue<double>(drrr["vtds"].ToString()),
                                Interest = Comm.GetValue<double>(drrr["Ints"].ToString()),
                                TDS = Comm.GetValue<double>(drrr["TDS"].ToString()),
                                Sur = Comm.GetValue<double>(drrr["Sur"].ToString()),
                                Cess = Comm.GetValue<double>(drrr["ECess"].ToString()),
                                Sec = Comm.GetValue<string>(drrr["section"].ToString()),
                                BSR = Comm.GetValue<string>(drrr["BSR"].ToString()),
                                Difference = Comm.GetValue<double>(drrr["Diff"].ToString()),
                                VouchersCount = Comm.GetValue<int>(drrr["VouchersCount"].ToString()),
                                BankId = Comm.GetValue<string>(drrr["Bank_id"].ToString()),
                                Verify = Comm.GetValue<string>(drrr["Trans_No"].ToString()),
                            });
                        }
                    }
                }
                foreach (var item in obj_Drp)
                {
                    //item.Deductee = listDeductee;
                    item.Grd = listGrd;
                    item.Challan = listChl;
                }
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }

        IEnumerable<tbl_VoucherDropDowns> tbl = obj_Drp;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);


    }

    [System.Web.Services.WebMethod(EnableSession = true)]   ///////////////// *********
    public string Get_TypeAhead(string Conn, string F, string D)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();

        List<tbl_DeducteeList> listDeductee = new List<tbl_DeducteeList>();
        try
        {
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@Company_ID", Session["companyid"]);
            param[1] = new SqlParameter("@Deductee", D);
            param[2] = new SqlParameter("@Form", F);


            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "Usp_Get_typeHead", param))

            {

                while (drrr.Read())
                {
                    listDeductee.Add(new tbl_DeducteeList()
                    {
                        deducteeid = Comm.GetValue<int>(drrr["deductee_id"].ToString()),
                        Dname = Comm.GetValue<string>(drrr["Deductee_name"].ToString()),
                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

        IEnumerable<tbl_DeducteeList> tbl = listDeductee;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]  ///////////////// *********
    public string Get_Nature_Branch_Drp(string Conn, string F)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
        tbl_VoucherDropDowns obj = new tbl_VoucherDropDowns();
        List<tbl_VoucherDropDowns> obj_Drp = new List<tbl_VoucherDropDowns>();
        string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
        obj.ST = financialyear[0];
        obj.ED = "20" + financialyear[1];

        try
        {
            SqlParameter[] param = new SqlParameter[5];
            param[0] = new SqlParameter("@DeducteeID", obj.did);
            param[1] = new SqlParameter("@Company_ID", Session["companyid"]);
            param[2] = new SqlParameter("@fstart", obj.ST);
            param[3] = new SqlParameter("@fend", obj.ED);
            param[4] = new SqlParameter("@form", F);

            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "Usp_Bootstrap_Get_Nature_Branch_Drp", param))
            {
                while (drrr.Read())
                {
                    obj_Drp.Add(new tbl_VoucherDropDowns()
                    {

                        compid = Comm.GetValue<int>(drrr["Compid"].ToString()),

                    });
                }

                List<tbl_Nature> listNature = new List<tbl_Nature>();

                if (drrr.NextResult())
                {
                    if (drrr.HasRows)
                    {
                        while (drrr.Read())
                        {
                            listNature.Add(new tbl_Nature()
                            {
                                Nature_ID = Comm.GetValue<int>(drrr["nature_id"].ToString()),
                                NatureName = Comm.GetValue<string>(drrr["Nature_Name"].ToString()),
                            });
                        }
                    }
                }


                List<tbl_Branch> listbr = new List<tbl_Branch>();

                if (drrr.NextResult())
                {
                    if (drrr.HasRows)
                    {
                        while (drrr.Read())
                        {
                            listbr.Add(new tbl_Branch()
                            {
                                bid = Comm.GetValue<int>(drrr["Branch_ID"].ToString()),
                                Bname = Comm.GetValue<string>(drrr["Branch_Name"].ToString()),
                            });
                        }
                    }
                }

                List<objforCorrection_Remiitance> listRemitance = new List<objforCorrection_Remiitance>();

                if (drrr.NextResult())
                {
                    if (drrr.HasRows)
                    {
                        while (drrr.Read())
                        {
                            listRemitance.Add(new objforCorrection_Remiitance()
                            {
                                rcode = Comm.GetValue<int>(drrr["RCode"].ToString()),
                                remittance = Comm.GetValue<string>(drrr["REMITTANCE"].ToString()),


                            });
                        }
                    }
                }

                List<Tbl_Country> listCt = new List<Tbl_Country>();

                if (drrr.NextResult())
                {
                    if (drrr.HasRows)
                    {
                        while (drrr.Read())
                        {
                            listCt.Add(new Tbl_Country()
                            {
                                Countryid = Comm.GetValue<int>(drrr["Country_ID"].ToString()),
                                Country = Comm.GetValue<string>(drrr["Country_Name"].ToString()),
                            });
                        }
                    }
                }

                foreach (var item in obj_Drp)
                {
                    item.Nature = listNature;
                    item.Remitance = listRemitance;
                    item.Branch = listbr;
                    item.Country = listCt;
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<tbl_VoucherDropDowns> tbl = obj_Drp;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]  /////////////////////// ******************
    public string Deductee_Rate(string nsid, string dT, string Conn, int nid)
    {
        tbl_DeducteeRate obj = new tbl_DeducteeRate();

        obj.Conn = Conn;
        obj.nsid = nsid;
        obj.nid = nid;
        string[] d = dT.Split('-');
        var _VDT = new DateTime(1900, 1, 1);
        var _CDT = new DateTime(1900, 1, 1);
        var info = new CultureInfo("en-US", false);
        string _dateFormat = "dd/MM/yyyy";

        string dtxt = d[2] + "/" + d[1] + "/" + d[0];
        if (dtxt.Trim() != "" && !DateTime.TryParseExact(dtxt.Trim(), _dateFormat, info, DateTimeStyles.AllowWhiteSpaces, out _CDT))
        {
        }

        obj.VDT = _CDT;
        ////dtxt = "15/05/2020";

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
            DALCommonLib objComm = new DALCommonLib();
            Functions4evr Comm = new Functions4evr();
            List<tbl_DeducteeRate> obj_Drp = new List<tbl_DeducteeRate>();
            try
            {
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@NatureSunId", nsid);
                param[1] = new SqlParameter("@CurrDate", _VDT);
                int i = 0;
                i = Convert.ToInt32(obj.ST);
                string SP = "";
                if (i >= 2020)
                {
                    SP = "usp_Bootstrap_getSlabValuesVoucherEntries_20";
                }
                else
                {
                    SP = "usp_Bootstrap_getSlabValuesVoucherEntries";
                }

                using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, SP, param))
                {
                    while (drrr.Read())
                    {
                        obj_Drp.Add(new tbl_DeducteeRate()
                        {
                            Rate = Comm.GetValue<string>(drrr["TDS"].ToString()),
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

            IEnumerable<tbl_DeducteeRate> tbl = obj_Drp;
            return new JavaScriptSerializer().Serialize(tbl);
        }


    }



    [System.Web.Services.WebMethod(EnableSession = true)]
    public string get_SelectedVoucherChallan(int Cid, int Vid)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();

        List<objChallanDetails> listChl = new List<objChallanDetails>();
        try
        {

            string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');
            SqlParameter[] param = new SqlParameter[3];

            param[0] = new SqlParameter("@Company_ID", Session["companyid"]);
            param[1] = new SqlParameter("@Cid", Cid);
            param[2] = new SqlParameter("@Vid", Vid);

            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "usp_Bootstrap_Get_SelectedVoucherChallan", param))
            {
                while (drrr.Read())
                {
                    listChl.Add(new objChallanDetails()
                    {
                        ChallanNo = Comm.GetValue<string>(drrr["challan_no"].ToString()),
                        ChallanID = Comm.GetValue<int>(drrr["Challan_ID"].ToString()),
                        ChallanDate = Comm.GetValue<string>(drrr["Challan_Date"].ToString()),
                        CAmount = Comm.GetValue<double>(drrr["Challan_Amount"].ToString()),
                        Others = Comm.GetValue<double>(drrr["Others_Amount"].ToString()),
                        BankId = Comm.GetValue<string>(drrr["Bank_ID"].ToString()),
                        TDS = Comm.GetValue<double>(drrr["TDS_Amount"].ToString()),
                        Sur = Comm.GetValue<double>(drrr["Surcharge"].ToString()),
                        Cess = Comm.GetValue<double>(drrr["Cess"].ToString()),
                        Interest = Comm.GetValue<double>(drrr["Interest_Amt"].ToString()),
                        CTotal = Comm.GetValue<double>(drrr["ChallanTotal"].ToString()),
                        VoucherAmt = Comm.GetValue<double>(drrr["VoucherAmt"].ToString()),
                        VoucherTotal = Comm.GetValue<double>(drrr["VoucherTotal"].ToString())
                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<objChallanDetails> tbl = listChl;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);

    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string EditRecords(int vid, string Conn)
    {
        tbl_VoucherModify obj = new tbl_VoucherModify();


        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();

        List<tbl_VoucherModify> listVrh = new List<tbl_VoucherModify>();
        try
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@Voucher_ID", vid);
            param[1] = new SqlParameter("@Company_ID", Session["companyid"]);


            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "usp_Bootstrap_VoucherModifyOnEdit", param))
            {
                while (drrr.Read())
                {
                    listVrh.Add(new tbl_VoucherModify()
                    {
                        PDate = Comm.GetValue<string>(drrr["Voucher_DT"].ToString()),
                        DDate = Comm.GetValue<string>(drrr["Deduction_DT"].ToString()),
                        did = Comm.GetValue<int>(drrr["Deductee_ID"].ToString()),
                        vid = Comm.GetValue<int>(drrr["Voucher_ID"].ToString()),
                        nid = Comm.GetValue<int>(drrr["Nature_ID"].ToString()),
                        rid = Comm.GetValue<int>(drrr["Remittance_ID"].ToString()),
                        nsid = Comm.GetValue<string>(drrr["Nature_Sub_ID"].ToString()),
                        DName = Comm.GetValue<string>(drrr["Deductee_Name"].ToString()),
                        rsid = Comm.GetValue<string>(drrr["Reason"].ToString()),
                        tid = Comm.GetValue<string>(drrr["Deductee_Type"].ToString()),
                        Cert = Comm.GetValue<string>(drrr["Certificate_NO"].ToString()),
                        PAN = Comm.GetValue<string>(drrr["PAN_NO"].ToString()),
                        Bid = Comm.GetValue<int>(drrr["BranchId"].ToString()),
                        Invid = Comm.GetValue<string>(drrr["InvORBillNo"].ToString()),
                        chk = Comm.GetValue<bool>(drrr["Threshold_Limit"].ToString()),
                        AmtPaid = Comm.GetValue<float>(drrr["Voucher_Amount"].ToString()),
                        TdsAmt = Comm.GetValue<float>(drrr["tds_AMt"].ToString()),
                        Rate = Comm.GetValue<float>(drrr["TDS_Percentage"].ToString()),
                        Sur = Comm.GetValue<float>(drrr["surcharge_amt"].ToString()),
                        Cess = Comm.GetValue<float>(drrr["ecess_amt"].ToString()),
                        Total = Comm.GetValue<float>(drrr["Total_Tax_Amt"].ToString()),
                        isNri = Comm.GetValue<bool>(drrr["IS_NRI"].ToString()),
                        sel = Comm.GetValue<int>(drrr["Sel"].ToString()),
                        formType = Comm.GetValue<string>(drrr["Form_Type"].ToString()),
                        Thold = Comm.GetValue<bool>(drrr["Threshold_Limit"].ToString()),
                        Quater = Comm.GetValue<string>(drrr["Quater"].ToString()),
                        RT = Comm.GetValue<string>(drrr["TDS_Rate_From"].ToString()),
                        Add1 = Comm.GetValue<string>(drrr["Flat_NO"].ToString()),
                        Contactno = Comm.GetValue<string>(drrr["ContactNo"].ToString()),
                        Emailid = Comm.GetValue<string>(drrr["Email"].ToString()),
                        NriTDSRT = Comm.GetValue<string>(drrr["NRI_TDS_Rate"].ToString()),
                        TaxId = Comm.GetValue<string>(drrr["TaxIdentificationNo"].ToString()),
                        CountryId = Comm.GetValue<int>(drrr["Country_ID"].ToString()),
                        eqInd = Comm.GetValue<string>(drrr["Estb_in_India"].ToString()),
                        eqNri = Comm.GetValue<string>(drrr["Nri_27EQ"].ToString()),
                        Cid = Comm.GetValue<int>(drrr["Challan_ID"].ToString()),
                        BAC1A = Comm.GetValue<string>(drrr["BAC_1A"].ToString()),
                        PAN_AAdhar = Comm.GetValue<string>(drrr["PAN_AAdhar_Status"].ToString()),
                    });
                }

                List<tbl_Section> listSec = new List<tbl_Section>();

                if (drrr.NextResult())
                {
                    if (drrr.HasRows)
                    {
                        while (drrr.Read())
                        {
                            listSec.Add(new tbl_Section()
                            {
                                Section = Comm.GetValue<string>(drrr["Section_Name"].ToString()),
                                Section_Id = Comm.GetValue<string>(drrr["Section_Id"].ToString()),

                            });
                        }
                    }
                }
                foreach (var item in listVrh)
                {
                    //item.Grd = listGrd;
                    item.Lst_Sec = listSec;
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<tbl_VoucherModify> tbl = listVrh;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);

        //IEnumerable<tbl_VoucherModify> tbl = objBAL_VoucherEntries.BAL_Modify(obj);
        //return new JavaScriptSerializer().Serialize(tbl);
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string SaveDeduction(Deduction deduction, string Conn)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
        List<Deduction> listVrh = new List<Deduction>();
        try
        {

            string voucherDate = deduction.VoucherDate != "" ? Convert.ToDateTime(deduction.VoucherDate).ToString("MM/dd/yyyy") : null;
            string challanDate = deduction.ChallanDate != "" ? Convert.ToDateTime(deduction.ChallanDate).ToString("MM/dd/yyyy") : null;
            string deductedDate = deduction.DeductedDate != "" ? Convert.ToDateTime(deduction.DeductedDate).ToString("MM/dd/yyyy") : null;

            // Voucher_DT = Convert.ToDateTime(tobj.PDate);
            SqlParameter[] param = new SqlParameter[38];
            param[0] = new SqlParameter("@Company_ID", deduction.CompanyId);
            param[1] = new SqlParameter("@Deductee_ID", deduction.DeducteeId);
            param[2] = new SqlParameter("@Nature_Sub_ID", deduction.NatureSubId);
            param[3] = new SqlParameter("@Voucher_DT", voucherDate);
            param[4] = new SqlParameter("@Voucher_Amount", deduction.VoucherAmount);
            param[5] = new SqlParameter("@TDS_Amt", deduction.TdsAmt);
            param[6] = new SqlParameter("@Surcharge_Amt", deduction.SurchargeAmt);
            param[7] = new SqlParameter("@ECess_Amt", deduction.ECessAmt);
            param[8] = new SqlParameter("@TDS_Percentage", deduction.TDSPercentage);
            param[9] = new SqlParameter("@Total_Tax_Amt", deduction.TotalTaxAmt);
            param[10] = new SqlParameter("@Deductee_Type", deduction.DeducteeType);
            param[11] = new SqlParameter("@IS_NRI", deduction.IsNRI);
            param[12] = new SqlParameter("@Reason", deduction.Reason);
            param[13] = new SqlParameter("@Quarter", deduction.Quarter);
            param[14] = new SqlParameter("@Sel", deduction.Sel);
            param[15] = new SqlParameter("@From_Type", deduction.FormType);
            param[16] = new SqlParameter("@PAN_NO", deduction.PAN);
            param[17] = new SqlParameter("@TDS_Certificate", deduction.TDSCertificate);
            param[18] = new SqlParameter("@Remittance_ID", deduction.RemittanceId);
            param[19] = new SqlParameter("@Threshold_Limit", deduction.ThresholdLimit);
            param[20] = new SqlParameter("@Nature_ID", deduction.NatureId);
            param[21] = new SqlParameter("@InvORBillNo", deduction.InvOrBillNo);
            param[22] = new SqlParameter("@Voucher_ID", deduction.VoucherId);
            param[23] = new SqlParameter("@BranchID", deduction.BranchId);
            param[24] = new SqlParameter("@DName", deduction.DName);
            param[25] = new SqlParameter("@Add1", deduction.Add1);
            param[26] = new SqlParameter("@Email", deduction.Email);
            param[27] = new SqlParameter("@ContactNo", deduction.ContactNo);
            param[28] = new SqlParameter("@NriTDSRT", deduction.NriTDSRT);
            param[29] = new SqlParameter("@TaxId", deduction.TaxId);
            param[30] = new SqlParameter("@CountryId", deduction.CountryId);
            param[31] = new SqlParameter("@Nri_27EQ", deduction.Nri27EQ);   /////////
            param[32] = new SqlParameter("@Estb_in_India", deduction.EstbInIndia);
            param[33] = new SqlParameter("@Challan_ID", deduction.ChallanId);
            param[34] = new SqlParameter("@Challan_Date", challanDate);
            param[35] = new SqlParameter("@Challan_BankNo", deduction.ChallanBankNo);
            param[36] = new SqlParameter("@DeductedDate", deductedDate);
            param[37] = new SqlParameter("@BAC1A", deduction.BAC1A);


            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "usp_Bootstrap_UpsertDeduction", param))
            {
                while (drrr.Read())
                {
                    listVrh.Add(new Deduction()
                    {
                        VoucherId = Comm.GetValue<int>(drrr["Voucher_Id"].ToString()),
                    });
                }
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }

        IEnumerable<Deduction> tbl = listVrh;
        return new JavaScriptSerializer().Serialize(tbl);
    }



    [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetChallansByCompId(int compId, string formType, string quarter)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
        List<objChallanDetails> listChl = new List<objChallanDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[3];

            param[0] = new SqlParameter("@CompanyId", compId);
            param[1] = new SqlParameter("@FormType", formType);
            param[2] = new SqlParameter("@Quarter", quarter);

            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "Usp_BootStrap_GetChallansByCompId", param))
            {
                while (drrr.Read())
                {
                    listChl.Add(new objChallanDetails()
                    {
                        ChallanNo = Comm.GetValue<string>(drrr["challan_no"].ToString()),
                        ChallanID = Comm.GetValue<int>(drrr["Challan_ID"].ToString()),
                        ChallanDate = Comm.GetValue<string>(drrr["Challan_Date"].ToString()),
                        ChallanAmount = Comm.GetValue<double>(drrr["Challan_Amount"].ToString()),
                        Quarter = Comm.GetValue<string>(drrr["Quater"].ToString()),
                        FormType = Comm.GetValue<string>(drrr["Form_Type"].ToString()),
                        TDS = Comm.GetValue<float>(drrr["TDS_Amount"].ToString()),
                        BankId = Comm.GetValue<string>(drrr["Bank_ID"].ToString()),
                    });
                }

            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

        IEnumerable<objChallanDetails> tbl = listChl;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }



    [System.Web.Services.WebMethod(EnableSession = true)]
    public string DeleteChallan(int cid)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
        List<objChallanDetails> listChl = new List<objChallanDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[2];

            param[0] = new SqlParameter("@Company_ID", Session["companyid"]);
            param[1] = new SqlParameter("@Cid", cid);


            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "Usp_Bootstrap_Delete_VChallan", param))
            {
                while (drrr.Read())
                {
                    listChl.Add(new objChallanDetails()
                    {
                        Compid = Comm.GetValue<int>(drrr["Company_id"].ToString()),

                    });
                }

            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

        IEnumerable<objChallanDetails> tbl = listChl;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }



    [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetChallan(string F, string Q)
    {

        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
        List<objChallanDetails> listChl = new List<objChallanDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[3];

            param[0] = new SqlParameter("@Company_ID", Session["companyid"]);
            param[1] = new SqlParameter("@form", F);
            param[2] = new SqlParameter("@Quater", Q);

            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "usp_Bootstrap_Voucher_Challan", param))
            {
                while (drrr.Read())
                {
                    listChl.Add(new objChallanDetails()
                    {

                        ChallanNo = Comm.GetValue<string>(drrr["challan_no"].ToString()),
                        ChallanDate = Comm.GetValue<string>(drrr["Challan_Date"].ToString()),
                        CAmount = Comm.GetValue<float>(drrr["Challan_Amount"].ToString()),
                        CTotal = Comm.GetValue<double>(drrr["CTotal"].ToString()),
                        Others = Comm.GetValue<double>(drrr["Coth"].ToString()),
                        ChallanID = Comm.GetValue<int>(drrr["Cid"].ToString()),
                        VTds = Comm.GetValue<double>(drrr["vtds"].ToString()),
                        Interest = Comm.GetValue<double>(drrr["Ints"].ToString()),
                        TDS = Comm.GetValue<double>(drrr["TDS"].ToString()),
                        Sur = Comm.GetValue<double>(drrr["Sur"].ToString()),
                        Cess = Comm.GetValue<double>(drrr["ECess"].ToString()),
                        Sec = Comm.GetValue<string>(drrr["section"].ToString()),
                        BSR = Comm.GetValue<string>(drrr["BSR"].ToString()),
                        Difference = Comm.GetValue<double>(drrr["Diff"].ToString()),
                        VouchersCount = Comm.GetValue<int>(drrr["VouchersCount"].ToString()),
                        BankId = Comm.GetValue<string>(drrr["Bank_id"].ToString()),
                    });
                }
            }


        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<objChallanDetails> tbl = listChl;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);

    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Save_Challan(string chl, string vids)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
        List<tbl_Challan_Non_Salary> listChl = new List<tbl_Challan_Non_Salary>();
        try
        {

            SqlParameter[] param = new SqlParameter[3];

            param[0] = new SqlParameter("@Company_ID", Session["companyid"]);
            param[1] = new SqlParameter("@Chl", chl);
            param[2] = new SqlParameter("@Vids", vids);


            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "usp_Bootstrap_Save_VChallan", param))
            {

                while (drrr.Read())
                {
                    listChl.Add(new tbl_Challan_Non_Salary()
                    {
                        Challan_ID = Comm.GetValue<int>(drrr["Cid"].ToString()),
                    });
                }

                List<objChallanDetails> lstobjChl = new List<objChallanDetails>();

                if (drrr.NextResult())
                {
                    if (drrr.HasRows)
                    {
                        while (drrr.Read())
                        {
                            lstobjChl.Add(new objChallanDetails()
                            {
                                ChallanNo = Comm.GetValue<string>(drrr["challan_no"].ToString()),
                                ChallanDate = Comm.GetValue<string>(drrr["Challan_Date"].ToString()),
                                CAmount = Comm.GetValue<float>(drrr["Challan_Amount"].ToString()),
                                CTotal = Comm.GetValue<double>(drrr["CTotal"].ToString()),
                                Others = Comm.GetValue<double>(drrr["Coth"].ToString()),
                                ChallanID = Comm.GetValue<int>(drrr["Cid"].ToString()),
                                VTds = Comm.GetValue<double>(drrr["vtds"].ToString()),
                                Interest = Comm.GetValue<double>(drrr["Ints"].ToString()),
                                TDS = Comm.GetValue<double>(drrr["TDS"].ToString()),
                                Sur = Comm.GetValue<double>(drrr["Sur"].ToString()),
                                Cess = Comm.GetValue<double>(drrr["ECess"].ToString()),
                                Sec = Comm.GetValue<string>(drrr["section"].ToString()),
                                BSR = Comm.GetValue<string>(drrr["BSR"].ToString()),
                                Difference = Comm.GetValue<double>(drrr["Diff"].ToString()),
                                VouchersCount = Comm.GetValue<int>(drrr["VouchersCount"].ToString()),
                                BankId = Comm.GetValue<string>(drrr["Bank_id"].ToString()),
                                Verify = Comm.GetValue<string>(drrr["Trans_No"].ToString()),
                            });
                        }
                    }
                }
                foreach (var item in listChl)
                {
                    //item.Grd = listGrd;
                    item.LstChallan = lstobjChl;
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

        IEnumerable<tbl_Challan_Non_Salary> tbl = listChl;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string ModifyGrd(int mth, int pI, int pS, string Conn, string d, string n, string ch, int U, string fltr, string F, string Q, string st, string ed)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
        DataSet ds;

        if (d == "")
        {
            d = "0";
        }

        if (n == "")
        {
            n = "0";
        }

        List<tbl_VoucherModifyGrd> obj_Drp = new List<tbl_VoucherModifyGrd>();
        try
        {

            SqlParameter[] param = new SqlParameter[12];
            param[0] = new SqlParameter("@ChallanStatus", ch);
            param[1] = new SqlParameter("@Nature_ID", n);
            param[2] = new SqlParameter("@Deductee_ID", d);
            param[3] = new SqlParameter("@MonthValue", mth);
            param[4] = new SqlParameter("@Company_ID", Session["companyid"]);
            param[5] = new SqlParameter("@pageIndex", pI);
            param[6] = new SqlParameter("@pageSize", pS);
            param[7] = new SqlParameter("@UP", U);
            param[8] = new SqlParameter("@fltr", F);
            param[9] = new SqlParameter("@Q", Q);
            param[10] = new SqlParameter("@st", st);
            param[11] = new SqlParameter("@ed", ed);


            //ds = SqlHelper.ExecuteDataset(objComm._cnnString2, CommandType.StoredProcedure, "usp_Bootstrap_Voucher_ModifyGrd", param);

            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "usp_Bootstrap_Voucher_ModifyGrd", param))
            {
                while (drrr.Read())
                {
                    obj_Drp.Add(new tbl_VoucherModifyGrd()
                    {
                        SrNo = Comm.GetValue<string>(drrr["sino"].ToString()),
                        PDate = Comm.GetValue<string>(drrr["Voucher_DT"].ToString()),
                        DName = Comm.GetValue<string>(drrr["Deductee_Name"].ToString()),
                        PanNO = Comm.GetValue<string>(drrr["PAN_NO"].ToString()),
                        PanVer = Comm.GetValue<string>(drrr["PANVerified"].ToString()),
                        TdsRate = Comm.GetValue<string>(drrr["TDS_Percentage"].ToString()),
                        CPaid = Comm.GetValue<string>(drrr["Challan_ID"].ToString()),
                        did = Comm.GetValue<int>(drrr["Deductee_ID"].ToString()),
                        vid = Comm.GetValue<int>(drrr["Voucher_ID"].ToString()),
                        AmtPaid = Comm.GetValue<double>(drrr["Voucher_Amount"].ToString()),
                        TdsAmt = Comm.GetValue<double>(drrr["Total_Tax_Amt"].ToString()),
                        sec = Comm.GetValue<string>(drrr["Section"].ToString()),
                        Totalcount = Comm.GetValue<int>(drrr["Totalcount"].ToString()),
                        BnkChl = Comm.GetValue<int>(drrr["Challan_No"].ToString()),
                    });
                }
                List<tbl_AmtTDSVoucher> listGrd = new List<tbl_AmtTDSVoucher>();

                if (drrr.NextResult())
                {
                    if (drrr.HasRows)
                    {
                        while (drrr.Read())
                        {
                            listGrd.Add(new tbl_AmtTDSVoucher()
                            {
                                Amt = Comm.GetValue<string>(drrr["Voucher_Amount"].ToString()),
                                TDS = Comm.GetValue<string>(drrr["TDS_Amt"].ToString()),
                            });
                        }
                    }
                }
                foreach (var item in obj_Drp)
                {
                    item.LTDSgrid = listGrd;
                }
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<tbl_VoucherModifyGrd> tbl = obj_Drp;

        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);

    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Challan_VoucherGrd(int c, int mth, int pI, int pS, string Conn, int Chid, string n, string fltr, string F, string Q)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();


        List<tbl_VoucherModifyGrd> obj_Drp = new List<tbl_VoucherModifyGrd>();
        try
        {

            string d = "0";

            if (n == "")
            {
                n = "0";
            }

            SqlParameter[] param = new SqlParameter[6];

            param[0] = new SqlParameter("@Nature_ID", n);
            param[1] = new SqlParameter("@Challan_ID", Chid);
            param[2] = new SqlParameter("@Company_ID", Session["companyid"]);
            param[3] = new SqlParameter("@pageIndex", pI);
            param[4] = new SqlParameter("@pageSize", pS);
            param[5] = new SqlParameter("@Deductee_ID", d);

            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "usp_Bootstrap_Challan_Voucher_ModifyGrd", param))
            {
                while (drrr.Read())
                {
                    obj_Drp.Add(new tbl_VoucherModifyGrd()
                    {
                        SrNo = Comm.GetValue<string>(drrr["sino"].ToString()),
                        PDate = Comm.GetValue<string>(drrr["Voucher_DT"].ToString()),
                        DName = Comm.GetValue<string>(drrr["Deductee_Name"].ToString()),
                        PanNO = Comm.GetValue<string>(drrr["PAN_NO"].ToString()),
                        PanVer = Comm.GetValue<string>(drrr["PANVerified"].ToString()),
                        TdsRate = Comm.GetValue<string>(drrr["TDS_Percentage"].ToString()),
                        CPaid = Comm.GetValue<string>(drrr["Challan_ID"].ToString()),
                        did = Comm.GetValue<int>(drrr["Deductee_ID"].ToString()),
                        vid = Comm.GetValue<int>(drrr["Voucher_ID"].ToString()),
                        AmtPaid = Comm.GetValue<double>(drrr["Voucher_Amount"].ToString()),
                        TdsAmt = Comm.GetValue<double>(drrr["Total_Tax_Amt"].ToString()),
                        sec = Comm.GetValue<string>(drrr["Section"].ToString()),
                        Totalcount = Comm.GetValue<int>(drrr["Totalcount"].ToString()),
                        BnkChl = Comm.GetValue<int>(drrr["Challan_No"].ToString()),
                    });
                }
                List<tbl_AmtTDSVoucher> listGrd = new List<tbl_AmtTDSVoucher>();

                if (drrr.NextResult())
                {
                    if (drrr.HasRows)
                    {
                        while (drrr.Read())
                        {
                            listGrd.Add(new tbl_AmtTDSVoucher()
                            {
                                Amt = Comm.GetValue<string>(drrr["Voucher_Amount"].ToString()),
                                TDS = Comm.GetValue<string>(drrr["TDS_Amt"].ToString()),
                                // CPaid = GetValue<string>(drrr["Challan_BankNo"].ToString()),
                            });
                        }
                    }
                }
                foreach (var item in obj_Drp)
                {
                    item.LTDSgrid = listGrd;

                }
            }


        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<tbl_VoucherModifyGrd> tbl = obj_Drp;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Update_Challan(string S, string C)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();

        List<objChallanDetails> obj = new List<objChallanDetails>();
        try
        {
            int Compid = Convert.ToInt32(Session["companyid"].ToString());
            string Cid = C;

            string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');

            SqlParameter[] param = new SqlParameter[3];

            param[0] = new SqlParameter("@Company_ID", Compid);
            param[1] = new SqlParameter("@Cid", Cid);
            param[2] = new SqlParameter("@Vids", S);


            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "Usp_Bootstrap_Update_VoucherMapping", param))
            {
                while (drrr.Read())
                {
                    obj.Add(new objChallanDetails()
                    {
                        ChallanID = Comm.GetValue<int>(drrr["Challan_ID"].ToString()),
                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<objChallanDetails> tbl = obj;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);

    }



    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Search_Challan(string S, string f)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();

        List<objChallanDetails> obj = new List<objChallanDetails>();

        string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');

        SqlParameter[] param = new SqlParameter[3];

        int Compid = Convert.ToInt32(Session["companyid"].ToString());
        param[0] = new SqlParameter("@Company_ID", Compid);
        param[1] = new SqlParameter("@form", f);
        param[2] = new SqlParameter("@Srch", S);


        using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "usp_Bootstrap_Get_Voucher_Challan_Srch", param))
        {
            while (drrr.Read())
            {
                obj.Add(new objChallanDetails()
                {
                    ChallanNo = Comm.GetValue<string>(drrr["challan_no"].ToString()),
                    ChallanID = Comm.GetValue<int>(drrr["Challan_ID"].ToString()),
                    ChallanDate = Comm.GetValue<string>(drrr["Challan_Date"].ToString()),
                    CAmount = Comm.GetValue<float>(drrr["Challan_Amount"].ToString()),
                    Quarter = Comm.GetValue<string>(drrr["Quater"].ToString()),
                    BSR = Comm.GetValue<string>(drrr["Bank_Bsrcode"].ToString()),
                    TDS = Comm.GetValue<double>(drrr["TDS_Amount"].ToString()),
                    Sur = Comm.GetValue<double>(drrr["Surcharge"].ToString()),
                    Cess = Comm.GetValue<double>(drrr["Cess"].ToString()),
                    Others = Comm.GetValue<double>(drrr["Others_Amount"].ToString()),
                    Interest = Comm.GetValue<double>(drrr["Interest_Amt"].ToString()),
                    CTotal = Comm.GetValue<double>(drrr["VTDS"].ToString()),
                    Balance = Comm.GetValue<double>(drrr["bal"].ToString()),
                });
            }
        }
        IEnumerable<objChallanDetails> tbl = obj;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
        //return new JavaScriptSerializer().Serialize(tbl);
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string FillGrd(int compid, string did, string Conn, string F, string Q)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
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


        List<tbl_VoucherGrd> listGrd = new List<tbl_VoucherGrd>();
        try
        {
            SqlParameter[] param = new SqlParameter[6];
            param[0] = new SqlParameter("@DeducteeID", did);
            param[1] = new SqlParameter("@Company_ID", Session["companyid"]);
            param[2] = new SqlParameter("@fstart", obj.ST);
            param[3] = new SqlParameter("@fend", obj.ED);
            param[4] = new SqlParameter("@form", F);
            param[5] = new SqlParameter("@Quater", Q);
            //return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "Usp_Bootstrap_Get_VoucherGrd", param);
            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "Usp_Bootstrap_Get_VoucherGrd", param))
            {
                while (drrr.Read())
                {
                    listGrd.Add(new tbl_VoucherGrd()
                    {

                        mth = Comm.GetValue<string>(drrr["Particulars"].ToString()),
                        Entries = Comm.GetValue<int>(drrr["Enteries"].ToString()),
                        Amt = Comm.GetValue<double>(drrr["Voucher_Amount"].ToString()),
                        Tds = Comm.GetValue<double>(drrr["TDS_Amt"].ToString()),
                        mthno = Comm.GetValue<int>(drrr["mth"].ToString()),
                        Tent = Comm.GetValue<int>(drrr["Tent"].ToString()),
                        TAmt = Comm.GetValue<double>(drrr["Vamt"].ToString()),
                        TTds = Comm.GetValue<double>(drrr["Tamt"].ToString()),
                        Upaid = Comm.GetValue<int>(drrr["UP"].ToString()),
                        Tup = Comm.GetValue<int>(drrr["TUP"].ToString()),
                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

        IEnumerable<tbl_VoucherGrd> tbl = listGrd;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Deductee_Details(int compid, int did, string Conn, string F)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }

        List<tbl_DeducteeDetails> listGrd = new List<tbl_DeducteeDetails>();

        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@Deductee_ID", did);
        param[1] = new SqlParameter("@Company_ID", compid);
        param[2] = new SqlParameter("@formType", F);
        //return SqlHelper.ExecuteReader(_cnnString, CommandType.StoredProcedure, "usp_VoucherEntriesBindEditDropDown", param);

        using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "usp_Bootstrap_VoucherEntries_DeducteeDetails", param))
        {
            while (drrr.Read())
            {
                listGrd.Add(new tbl_DeducteeDetails()
                {
                    Cert = Comm.GetValue<string>(drrr["Certificate_NO"].ToString()),
                    RT = Comm.GetValue<string>(drrr["NRI_TDS_Rate"].ToString()),
                    tid = Comm.GetValue<string>(drrr["Deductee_Type"].ToString()),
                    sec = Comm.GetValue<string>(drrr["Reasons"].ToString()),
                    isNri = Comm.GetValue<bool>(drrr["IS_NRI"].ToString()),
                    Rate = Comm.GetValue<string>(drrr["TDS_Rate"].ToString()),
                    Email = Comm.GetValue<string>(drrr["Email"].ToString()),
                    PAN = Comm.GetValue<string>(drrr["PAN_NO"].ToString()),
                    TaxId = Comm.GetValue<string>(drrr["TaxIdentificationNo"].ToString()),
                    Countryid = Comm.GetValue<int>(drrr["Country_ID"].ToString()),
                    Add1 = Comm.GetValue<string>(drrr["add1"].ToString()),
                    Cnumber = Comm.GetValue<string>(drrr["ContactNo"].ToString()),
                    nid = Comm.GetValue<int>(drrr["Nature_ID"].ToString()),
                    Compliance = Comm.GetValue<int>(drrr["TR206"].ToString()),
                    isInd = Comm.GetValue<bool>(drrr["IS_Individual"].ToString()),
                    BAC_1A = Comm.GetValue<string>(drrr["BAC_1A"].ToString()),
                    PAN_AAdhar = Comm.GetValue<string>(drrr["PAN_AAdhar_Status"].ToString()),
                });
            }
            List<tbl_Branch> listBr = new List<tbl_Branch>();
            if (drrr.NextResult())
            {
                if (drrr.HasRows)
                {
                    while (drrr.Read())
                    {
                        listBr.Add(new tbl_Branch()
                        {
                            Bname = Comm.GetValue<string>(drrr["Branch_Name"].ToString()),
                            bid = Comm.GetValue<int>(drrr["Branch_Id"].ToString()),

                        });
                    }
                }
            }

            List<tbl_Section> listSec = new List<tbl_Section>();
            if (drrr.NextResult())
            {
                if (drrr.HasRows)
                {
                    while (drrr.Read())
                    {
                        listSec.Add(new tbl_Section()
                        {
                            Section = Comm.GetValue<string>(drrr["Section_Name"].ToString()),
                            Section_Id = Comm.GetValue<string>(drrr["Section_Id"].ToString()),
                        });
                    }
                }
            }

            List<tbl_Nature> listNat = new List<tbl_Nature>();

            if (drrr.NextResult())
            {
                if (drrr.HasRows)
                {
                    while (drrr.Read())
                    {
                        listNat.Add(new tbl_Nature()
                        {
                            Nature_ID = Comm.GetValue<int>(drrr["Nature_ID"].ToString()),
                            Nature_Sub_Id = Comm.GetValue<string>(drrr["Nature_Sub_ID"].ToString()),
                        });
                    }
                }
            }

            foreach (var item in listGrd)
            {
                item.Lst_Br = listBr;
                item.Lst_Sec = listSec;
                item.Lst_Nature = listNat;
            }

        }

        IEnumerable<tbl_DeducteeDetails> tbl = listGrd;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string DeleteRecords(int compid, string paidids, string nonpaid, string Conn)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }

        List<tbl_VoucherModifyGrd> obj = new List<tbl_VoucherModifyGrd>();

        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@PaidVoucher_ID", paidids);
        param[1] = new SqlParameter("@NonPaidVoucher_ID", nonpaid);
        param[2] = new SqlParameter("@compid", Session["companyid"]);

        using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "usp_Bootstrap_Voucher_Delete", param))
        {
            while (drrr.Read())
            {
                obj.Add(new tbl_VoucherModifyGrd()
                {
                    vid = Comm.GetValue<int>(drrr["Voucher_ID"].ToString()),

                });
            }
        }

        IEnumerable<tbl_VoucherModifyGrd> tbl = obj;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }



    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Section_Modify(int compid, string Conn, string all)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }
        List<tbl_VoucherModifyGrd> obj = new List<tbl_VoucherModifyGrd>();

        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@Company_ID", compid);
        param[1] = new SqlParameter("@RT", all);


        using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "Usp_Save_Sections", param))
        {
            while (drrr.Read())
            {
                obj.Add(new tbl_VoucherModifyGrd()
                {
                    vid = Comm.GetValue<int>(drrr["Voucher_id"].ToString()),

                });
            }
        }

        IEnumerable<tbl_VoucherModifyGrd> tbl = obj;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }



    [System.Web.Services.WebMethod(EnableSession = true)]
    public string SaveToken(int Compid, string TokenNo, string Qtr, string Ftyp, string Conn)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
        List<tbl_VoucherGrd> obj = new List<tbl_VoucherGrd>();

        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }



        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@compid", Compid);
        param[1] = new SqlParameter("@TokenNo", TokenNo);
        param[2] = new SqlParameter("@Qtr", Qtr);
        param[3] = new SqlParameter("@ftype", Ftyp);



        using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "usp_Insert_TokenNo", param))
        {
            while (drrr.Read())
            {
                obj.Add(new tbl_VoucherGrd()
                {
                    compid = Comm.GetValue<int>(drrr["compid"].ToString()),

                });
            }

        }

        IEnumerable<tbl_VoucherGrd> tbl = obj;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetTracesDetails(int Compid)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
        List<tbl_TracesDetail> obj = new List<tbl_TracesDetail>();

        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@compid", Compid);


        using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString, CommandType.StoredProcedure, "usp_GetTracesDetails", param))
        {
            while (drrr.Read())
            {
                obj.Add(new tbl_TracesDetail()
                {
                    Userid = Comm.GetValue<string>(drrr["User_ID"].ToString()),
                    Password = Comm.GetValue<string>(drrr["Password"].ToString()),
                });
            }

        }


        IEnumerable<tbl_TracesDetail> tbl = obj;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string TracesDetailsSave(int Compid, string UserID, string Password, string TAN)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
        List<tbl_TracesDetail> obj = new List<tbl_TracesDetail>();

        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@compid", Compid);
        param[1] = new SqlParameter("@TAN", TAN);
        param[2] = new SqlParameter("@Userid", UserID);
        param[3] = new SqlParameter("@Password", Password);


        using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "usp_Insert_TracesDetails", param))
        {
            while (drrr.Read())
            {
                obj.Add(new tbl_TracesDetail()
                {
                    Userid = Comm.GetValue<string>(drrr["User_ID"].ToString()),
                    Password = Comm.GetValue<string>(drrr["Password"].ToString()),
                });
            }

        }


        IEnumerable<tbl_TracesDetail> tbl = obj;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string MisMatch_Vouchers(int compid, string f, string q, string Conn)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
        List<MisMatch_Vouchers> obj = new List<MisMatch_Vouchers>();
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }

        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@Company_ID", compid);
        param[1] = new SqlParameter("@Quater", q);
        param[2] = new SqlParameter("@FromType", f);


        using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "usp_GetNonSalaryValidation", param))
        {
            while (drrr.Read())
            {
                obj.Add(new MisMatch_Vouchers()
                {
                    Compid = Comm.GetValue<int>(drrr["Compid"].ToString()),
                });
            }

            List<MisMatch_PAN> listPAN = new List<MisMatch_PAN>();

            if (drrr.NextResult())
            {
                if (drrr.HasRows)
                {
                    while (drrr.Read())
                    {
                        listPAN.Add(new MisMatch_PAN()
                        {
                            PDate = Comm.GetValue<string>(drrr["Payment_Date"].ToString()),
                            DName = Comm.GetValue<string>(drrr["Deductee"].ToString()),
                            AmtPaid = Comm.GetValue<float>(drrr["Amount_Paid"].ToString()),
                            VPAN = Comm.GetValue<string>(drrr["VPAN"].ToString()),
                            DPAN = Comm.GetValue<string>(drrr["DPAN"].ToString()),
                            Vid = Comm.GetValue<int>(drrr["Vid"].ToString()),
                        });
                    }
                }
            }

            List<Nri_MisMatch> listNri = new List<Nri_MisMatch>();

            if (drrr.NextResult())
            {
                if (drrr.HasRows)
                {
                    while (drrr.Read())
                    {
                        listNri.Add(new Nri_MisMatch()
                        {
                            DName = Comm.GetValue<string>(drrr["Deductee"].ToString()),
                            Email = Comm.GetValue<string>(drrr["Email"].ToString()),
                            Tel = Comm.GetValue<string>(drrr["Contact"].ToString()),
                            Tax = Comm.GetValue<string>(drrr["Tax"].ToString()),
                            Add = Comm.GetValue<string>(drrr["Address"].ToString()),

                        });
                    }
                }
            }



            List<MisMatch_Trans> listTR = new List<MisMatch_Trans>();

            if (drrr.NextResult())
            {
                if (drrr.HasRows)
                {
                    while (drrr.Read())
                    {
                        listTR.Add(new MisMatch_Trans()
                        {
                            PDate = Comm.GetValue<string>(drrr["Payment_Date"].ToString()),
                            DName = Comm.GetValue<string>(drrr["Deductee"].ToString()),
                            AmtPaid = Comm.GetValue<float>(drrr["VAmount"].ToString()),
                            TdsAmt = Comm.GetValue<float>(drrr["TDS_Amt"].ToString()),
                            CTdsAmt = Comm.GetValue<float>(drrr["Correct_TDS"].ToString()),
                            RT = Comm.GetValue<string>(drrr["TDS_Percentage"].ToString()),
                            Cert = Comm.GetValue<string>(drrr["tds_Certificate"].ToString()),
                            Error = Comm.GetValue<string>(drrr["Error"].ToString()),
                            Vid = Comm.GetValue<int>(drrr["Vid"].ToString()),
                        });
                    }
                }
            }
            foreach (var item in obj)
            {
                item.Lst_PAN = listPAN;
                item.Lst_Nri = listNri;
                item.Lst_Tr = listTR;
            }
        }



        IEnumerable<MisMatch_Vouchers> tbl = obj;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string TDS_ReportGrid(int compid, string Fromdt, string Todate, string Conn, string Formtype, int rdio)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
        List<tbl_DeducteeReport> obj = new List<tbl_DeducteeReport>();
        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(Conn))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = Conn;
        }

        DateTime strdate = Convert.ToDateTime(Fromdt, ci);
        DateTime todate = Convert.ToDateTime(Todate, ci);

        SqlParameter[] param = new SqlParameter[5];
        param[0] = new SqlParameter("@Company_ID", compid);
        param[1] = new SqlParameter("@FromType", Formtype);
        param[2] = new SqlParameter("@fromdate", strdate);
        param[3] = new SqlParameter("@todate", todate);
        param[4] = new SqlParameter("@rdio", rdio);


        using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "usp_TDSSummaryReportGrid", param))
        {
            while (drrr.Read())
            {
                obj.Add(new tbl_DeducteeReport()
                {

                    PAN = Comm.GetValue<string>(drrr["Head"].ToString()),
                    Section = Comm.GetValue<string>(drrr["Section"].ToString()),
                    AmtPaid = Comm.GetValue<string>(drrr["AmtPaid"].ToString()),
                    TDS = Comm.GetValue<string>(drrr["TDS"].ToString()),
                    Paid = Comm.GetValue<string>(drrr["Paid"].ToString()),
                    Unpiad = Comm.GetValue<string>(drrr["unPaid"].ToString()),
                });
            }

        }


        IEnumerable<tbl_DeducteeReport> tbl = obj;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Validate(string U, string P)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
        if (Membership.ValidateUser(U, P))
        {

        }
        else
        {

        }
        return "Yes";
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Get_PANNo_List(TracesInfo tracesInfo)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
        List<PANNo> obj = new List<PANNo>();

        SqlParameter[] param = new SqlParameter[4];

        param[0] = new SqlParameter("@Company_id", tracesInfo.Compid);
        param[1] = new SqlParameter("@Quarter", tracesInfo.Quarter);
        param[2] = new SqlParameter("@FormType", tracesInfo.FormType);
        param[3] = new SqlParameter("@indication", 1);


        using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "usp_Get_PanNo", param))
        {
            while (drrr.Read())
            {
                obj.Add(new PANNo()
                {
                    PAN = Comm.GetValue<string>(drrr["PAN_NO"].ToString())
                });
            }
        }


        IEnumerable<PANNo> tbl = obj;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string Remove_Vids_Challan(string S)
    {
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();
        List<objChallanDetails> obj = new List<objChallanDetails>();
        try
        {
            int Compid = Convert.ToInt32(Session["companyid"].ToString());


            string[] financialyear = Session["Financial_Year_Text"].ToString().Split('_');

            SqlParameter[] param = new SqlParameter[2];

            param[0] = new SqlParameter("@Company_ID", Compid);
            param[1] = new SqlParameter("@Vids", S);


            using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "Usp_Bootstrap_Remove_VoucherMapping", param))
            {
                while (drrr.Read())
                {
                    obj.Add(new objChallanDetails()
                    {
                        ChallanID = Comm.GetValue<int>(drrr["Challan_ID"].ToString()),
                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<objChallanDetails> tbl = obj;
        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);

    }



    [System.Web.Services.WebMethod(EnableSession = true)]
    public string ListPANStatus(string F, string Q, string sts, int pg, int ps)
    {
        List<tbl_VoucherModify> obj = new List<tbl_VoucherModify>();
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();

        SqlParameter[] param = new SqlParameter[6];

        param[0] = new SqlParameter("@Company_id", Session["companyid"].ToString());
        param[1] = new SqlParameter("@Quarter", Q);
        param[2] = new SqlParameter("@FormType", F);
        param[3] = new SqlParameter("@indication", sts);
        param[4] = new SqlParameter("@PageIndex", pg);
        param[5] = new SqlParameter("@PageSize", ps);

        using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "usp_Voucher_PANStatus", param))
        {
            while (drrr.Read())
            {
                obj.Add(new tbl_VoucherModify()
                {
                    PDate = Comm.GetValue<string>(drrr["Voucher_DT"].ToString()),
                    vid = Comm.GetValue<int>(drrr["Voucher_ID"].ToString()),
                    nsid = Comm.GetValue<string>(drrr["Section"].ToString()),
                    DName = Comm.GetValue<string>(drrr["Deductee_Name"].ToString()),
                    PAN = Comm.GetValue<string>(drrr["PAN"].ToString()),
                    RT = Comm.GetValue<string>(drrr["TDS_Percentage"].ToString()),
                    AmtPaid = Comm.GetValue<float>(drrr["Voucher_Amount"].ToString()),
                    Total = Comm.GetValue<float>(drrr["Total_Tax_Amt"].ToString()),
                    PAN_AAdhar = Comm.GetValue<string>(drrr["PAN_AAdhar_Status"].ToString()),
                    rid = Comm.GetValue<int>(drrr["RecordCount"].ToString()),
                });
            }
        }


        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(obj);
    }



    [System.Web.Services.WebMethod(EnableSession = true)]
    public string ListPANSummary(string F, string Q, string sts )
    {

        List<PANNo> obj = new List<PANNo>();
        DALCommonLib objComm = new DALCommonLib();
        Functions4evr Comm = new Functions4evr();

        SqlParameter[] param = new SqlParameter[4];

        param[0] = new SqlParameter("@Company_id", Session["companyid"].ToString());
        param[1] = new SqlParameter("@Quarter", Q);
        param[2] = new SqlParameter("@FormType", F);
        param[3] = new SqlParameter("@indication", sts);


        using (SqlDataReader drrr = SqlHelper.ExecuteReader(objComm._cnnString2, CommandType.StoredProcedure, "usp_Voucher_PANSummary", param))
        {
            while (drrr.Read())
            {

                obj.Add(new PANNo()
                {
                    Active = Comm.GetValue<string>(drrr["Active"].ToString()),
                    InActive = Comm.GetValue<string>(drrr["InActive"].ToString()),
                    NotVerified = Comm.GetValue<string>(drrr["NotVerified"].ToString()),
                });

            }
        }

        IEnumerable<PANNo> tbl = obj;

        var outputJsonResult = new JavaScriptSerializer();
        outputJsonResult.MaxJsonLength = 10 * 1024 * 1024;
        return outputJsonResult.Serialize(tbl);
    }



}