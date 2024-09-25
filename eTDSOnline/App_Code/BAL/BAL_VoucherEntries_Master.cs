using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;
using CommonLibrary;
using System.Data.SqlClient;
using System.Globalization;
using System.Data;

namespace BusinessLayer
{
    public class BAL_VoucherEntries_Master : CommonFunctions
    {
        DAL_VoucherEntries_Master objDAL_VoucherEntries_Master = new DAL_VoucherEntries_Master();
        DataSet ds;
        int result = 0;

        public int Company_ID { get; set; }
        public int Deductee_ID { get; set; }
        public string Nature_Sub_ID { get; set; }
        public DateTime Voucher_DT { get; set; }
        public double Voucher_Amount { get; set; }
        public double TDS_Amt { get; set; }
        public double Surcharge_Amt { get; set; }
        public double ECess_Amt { get; set; }
        public double HECess_Amt { get; set; }
        public decimal TDS_Percentage { get; set; }
        public decimal Surchare_Percentage { get; set; }
        public decimal HECess_Percentage { get; set; }
        public double Total_Tax_Amt { get; set; }
        public string Deductee_Type { get; set; }
        public bool IS_NRI { get; set; }
        public string Reason { get; set; }
        public string Deductee_Name { get; set; }
        public string Quater { get; set; }
        public int Sel { get; set; }
        public string Section { get; set; }
        public string From_Type { get; set; }
        public string PAN_NO { get; set; }
        public string Alias { get; set; }
        public string TDS_Certificate { get; set; }
        public string Country_Code { get; set; }
        public string NRI_Code { get; set; }
        public short Remittance_ID { get; set; }
        public string PANVerified { get; set; }
        public bool Threshold_Limit { get; set; }
        public decimal ECess_Percentage { get; set; }
        public int Nature_ID { get; set; }

        public DataSet BAL_BindDeducteeDropDown()
        {
            try
            {
                objDAL_VoucherEntries_Master.Company_ID = Company_ID;
                objDAL_VoucherEntries_Master.Deductee_ID = Deductee_ID;
                ds = objDAL_VoucherEntries_Master.DAL_BindDeducteeDropDown();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet BAL_GetMonthNames()
        {
            try
            {
                objDAL_VoucherEntries_Master.Company_ID = Company_ID;
                objDAL_VoucherEntries_Master.Deductee_ID = Deductee_ID;
                objDAL_VoucherEntries_Master.fstart = fstart;
                objDAL_VoucherEntries_Master.fend = fend;
                ds = objDAL_VoucherEntries_Master.DAL_GetMonthNames();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }



        public int BAL_InsertVoucherDetails()
        {
            try
            {
                objDAL_VoucherEntries_Master.Company_ID = Company_ID;
                objDAL_VoucherEntries_Master.Deductee_ID = Deductee_ID;
                objDAL_VoucherEntries_Master.Nature_Sub_ID = Nature_Sub_ID;
                objDAL_VoucherEntries_Master.Voucher_DT = Voucher_DT;
                objDAL_VoucherEntries_Master.Voucher_Amount = Voucher_Amount;
                objDAL_VoucherEntries_Master.TDS_Amt = TDS_Amt;
                objDAL_VoucherEntries_Master.Surcharge_Amt = Surcharge_Amt;
                objDAL_VoucherEntries_Master.ECess_Amt = ECess_Amt;
                objDAL_VoucherEntries_Master.HECess_Amt = HECess_Amt;
                objDAL_VoucherEntries_Master.TDS_Amt = TDS_Amt;
                objDAL_VoucherEntries_Master.TDS_Percentage = TDS_Percentage;
                objDAL_VoucherEntries_Master.Surchare_Percentage = Surchare_Percentage;
                objDAL_VoucherEntries_Master.ECess_Percentage = ECess_Percentage;
                objDAL_VoucherEntries_Master.HECess_Percentage = HECess_Percentage;
                objDAL_VoucherEntries_Master.Total_Tax_Amt = Total_Tax_Amt;
                objDAL_VoucherEntries_Master.Deductee_Type = Deductee_Type;
                objDAL_VoucherEntries_Master.IS_NRI = IS_NRI;
                objDAL_VoucherEntries_Master.Reason = Reason;
                objDAL_VoucherEntries_Master.Deductee_Type = Deductee_Type;
                objDAL_VoucherEntries_Master.Quater = Quater;
                objDAL_VoucherEntries_Master.Sel = Sel;
                objDAL_VoucherEntries_Master.Section = Section;
                objDAL_VoucherEntries_Master.From_Type = From_Type;
                objDAL_VoucherEntries_Master.PAN_NO = PAN_NO;
                objDAL_VoucherEntries_Master.TDS_Certificate = TDS_Certificate;
                objDAL_VoucherEntries_Master.Country_Code = Country_Code;
                objDAL_VoucherEntries_Master.NRI_Code = NRI_Code;
                objDAL_VoucherEntries_Master.Remittance_ID = Remittance_ID;
                objDAL_VoucherEntries_Master.PANVerified = PANVerified;
                objDAL_VoucherEntries_Master.Threshold_Limit = Threshold_Limit;
                objDAL_VoucherEntries_Master.Nature_ID = Nature_ID;
                objDAL_VoucherEntries_Master.InvORBillNo = InvORBillNo;
                objDAL_VoucherEntries_Master.Deductee_Name = Deductee_Name;
                objDAL_VoucherEntries_Master.Voucher_ID = Voucher_ID;
                objDAL_VoucherEntries_Master.BranchID = BranchID;
                result = objDAL_VoucherEntries_Master.DAL_InsertVoucherDetails();
                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }



        public DataSet BAL_BindRemittanceDropDown()
        {
            try
            {
                ds = objDAL_VoucherEntries_Master.DAL_BindRemittanceDropDown();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public string InvORBillNo { get; set; }

        public DataSet BAL_Bind()
        {
            try
            {
                objDAL_VoucherEntries_Master.Deductee_ID = Deductee_ID;
                ds = objDAL_VoucherEntries_Master.DAL_Bind();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet BAL_BindSearchGrid()
        {
            try
            {
                objDAL_VoucherEntries_Master.ChallanStatus = ChallanStatus;
                objDAL_VoucherEntries_Master.Nature_Sub_ID = Nature_Sub_ID;
                objDAL_VoucherEntries_Master.Section = Section;
                objDAL_VoucherEntries_Master.Deductee_Name = Deductee_Name;
                objDAL_VoucherEntries_Master.InvORBillNo = InvORBillNo;
                objDAL_VoucherEntries_Master.MonthValue = MonthValue;
                objDAL_VoucherEntries_Master.Company_ID = Company_ID;
                ds = objDAL_VoucherEntries_Master.DAL_BindSearchGrid();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public string ChallanStatus { get; set; }

        public DateTime ToDate { get; set; }

        public DateTime FromDate { get; set; }

        public DataSet BAL_GetVoucherEntries()
        {
            try
            {
                objDAL_VoucherEntries_Master.MonthValue = MonthValue;
                objDAL_VoucherEntries_Master.Deductee_ID = Deductee_ID;
                ds = objDAL_VoucherEntries_Master.DAL_GetVoucherEntries();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet BAL_VoucherModifyONEdit()
        {
            try
            {
                objDAL_VoucherEntries_Master.Company_ID = Company_ID;
                objDAL_VoucherEntries_Master.Voucher_ID = Voucher_ID;
                ds = objDAL_VoucherEntries_Master.DAL_VoucherModifyONEdit();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public int Voucher_ID { get; set; }

        public int BAL_DeleteVoucher()
        {
            try
            {
                objDAL_VoucherEntries_Master.Voucher_ID = Voucher_ID;
                result = objDAL_VoucherEntries_Master.DAL_DeleteVoucher();
                return result;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public int MonthValue { get; set; }

        public DataSet BAL_GetSalbValues()
        {
            try
            {
                objDAL_VoucherEntries_Master.Nature_Sub_ID = Nature_Sub_ID;
                ds = objDAL_VoucherEntries_Master.DAL_GetSalbValues();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet BAL_GetSalbValues_20()
        {
            try
            {
                objDAL_VoucherEntries_Master.Nature_Sub_ID = Nature_Sub_ID;
                objDAL_VoucherEntries_Master.Voucher_DT = Voucher_DT;
                ds = objDAL_VoucherEntries_Master.DAL_GetSalbValues_20();
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet BAL_GetLastRecords()
        {
            try
            {
                objDAL_VoucherEntries_Master.Company_ID = Company_ID;
                ds = objDAL_VoucherEntries_Master.DAL_GetLastRec();
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string fend { get; set; }

        public string fstart { get; set; }

        public int BranchID { get; set; }


        public IEnumerable<tbl_VoucherDropDowns> BAL_GetDropdowns(tbl_VoucherDropDowns tobj)
        {
            List<tbl_VoucherDropDowns> obj_Drp = new List<tbl_VoucherDropDowns>();
            try
            {
                using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_GetDropDowns(tobj))
                {
                    while (drrr.Read())
                    {
                        obj_Drp.Add(new tbl_VoucherDropDowns()
                        {

                            compid = GetValue<int>(drrr["Compid"].ToString()),

                        });
                    }

                    List<tbl_DeducteeList> listDeductee = new List<tbl_DeducteeList>();

                    if (drrr.NextResult())
                    {
                        if (drrr.HasRows)
                        {
                            //while (drrr.Read())
                            //{
                            //    listDeductee.Add(new tbl_DeducteeList()
                            //    {
                            //        deducteeid = GetValue<int>(drrr["deductee_id"].ToString()),
                            //        Dname = GetValue<string>(drrr["Deductee_name"].ToString()),
                            //    });
                            //}
                        }
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
                                    mth = GetValue<string>(drrr["Particulars"].ToString()),
                                    Entries = GetValue<int>(drrr["Enteries"].ToString()),
                                    Amt = GetValue<double>(drrr["Voucher_Amount"].ToString()),
                                    Tds = GetValue<double>(drrr["TDS_Amt"].ToString()),
                                    mthno = GetValue<int>(drrr["mth"].ToString()),
                                    Tent = GetValue<int>(drrr["Tent"].ToString()),
                                    TAmt = GetValue<double>(drrr["Vamt"].ToString()),
                                    TTds = GetValue<double>(drrr["Tamt"].ToString()),
                                    Upaid = GetValue<int>(drrr["UP"].ToString()),
                                    Tup = GetValue<int>(drrr["TUP"].ToString()),
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
                                    ChallanID = GetValue<int>(drrr["Cid"].ToString()),
                                    ChallanNo = GetValue<int>(drrr["challan_no"].ToString()),
                                    ChallanDate = GetValue<string>(drrr["Challan_Date"].ToString()),
                                    CAmount = GetValue<float>(drrr["Challan_Amount"].ToString()),
                                    TDS = GetValue<double>(drrr["tds"].ToString()),
                                    Cess = GetValue<double>(drrr["ECess"].ToString()),
                                    HCess = GetValue<double>(drrr["HCess"].ToString()),
                                    Sur = GetValue<double>(drrr["Sur"].ToString()),
                                    Others = GetValue<double>(drrr["Coth"].ToString()),
                                    CTotal = GetValue<double>(drrr["Ctotal"].ToString()),
                                    Interest = GetValue<double>(drrr["Ints"].ToString()),
                                    Diff = GetValue<double>(drrr["diff"].ToString()),
                                    Vtds = GetValue<double>(drrr["Vtds"].ToString()),
                                    Sec = GetValue<string>(drrr["section"].ToString()),
                                    BSR = GetValue<string>(drrr["BSR"].ToString()),
                                    VouchersCount = GetValue<int>(drrr["VouchersCount"].ToString()),
                                    Verify = GetValue<string>(drrr["Verify"].ToString()),
                                });
                            }
                        }
                    }
                    foreach (var item in obj_Drp)
                    {
                        item.Deductee = listDeductee;
                        item.Grd = listGrd;
                        item.Challan = listChl;
                    }
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return obj_Drp as IEnumerable<tbl_VoucherDropDowns>;
        }

        public IEnumerable<tbl_DeducteeList> BAL_GetTypeAhead(tbl_DeducteeList tobj)
        {
            List<tbl_DeducteeList> listDeductee = new List<tbl_DeducteeList>();
            try
            {
                using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_GetTypeAhead(tobj))
                {

                    while (drrr.Read())
                    {
                        listDeductee.Add(new tbl_DeducteeList()
                        {
                            deducteeid = GetValue<int>(drrr["deductee_id"].ToString()),
                            Dname = GetValue<string>(drrr["Deductee_name"].ToString()),
                        });
                    }
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return listDeductee as IEnumerable<tbl_DeducteeList>;
        }


        public IEnumerable<tbl_VoucherDropDowns> BAL_Get_Nature_Branch_Drp(tbl_VoucherDropDowns tobj)
        {
            List<tbl_VoucherDropDowns> obj_Drp = new List<tbl_VoucherDropDowns>();
            try
            {
                using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_Get_Nature_Branch_Drp(tobj))
                {
                    while (drrr.Read())
                    {
                        obj_Drp.Add(new tbl_VoucherDropDowns()
                        {

                            compid = GetValue<int>(drrr["Compid"].ToString()),

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
                                    Nature_ID = GetValue<int>(drrr["nature_id"].ToString()),
                                    NatureName = GetValue<string>(drrr["Nature_Name"].ToString()),
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
                                    bid = GetValue<int>(drrr["Branch_ID"].ToString()),
                                    Bname = GetValue<string>(drrr["Branch_Name"].ToString()),
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
                                    rcode = GetValue<int>(drrr["RCode"].ToString()),
                                    remittance = GetValue<string>(drrr["REMITTANCE"].ToString()),


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
                                    Countryid = GetValue<int>(drrr["Country_ID"].ToString()),
                                    Country = GetValue<string>(drrr["Country_Name"].ToString()),
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
            return obj_Drp as IEnumerable<tbl_VoucherDropDowns>;
        }

        public IEnumerable<tbl_VoucherModifyGrd> BAL_Modify_Chln_Vch_Grd(tbl_VoucherModifyGrd tobj)
        {
            List<tbl_VoucherModifyGrd> obj_Drp = new List<tbl_VoucherModifyGrd>();
            try
            {
                using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_Modify_Chln_Vchr_Grd(tobj))
                {
                    while (drrr.Read())
                    {
                        obj_Drp.Add(new tbl_VoucherModifyGrd()
                        {

                            PDate = GetValue<string>(drrr["Voucher_DT"].ToString()),
                            DName = GetValue<string>(drrr["Deductee_Name"].ToString()),
                            CPaid = GetValue<string>(drrr["Challan_ID"].ToString()),
                            did = GetValue<int>(drrr["Deductee_ID"].ToString()),
                            vid = GetValue<int>(drrr["Voucher_ID"].ToString()),
                            AmtPaid = GetValue<double>(drrr["Voucher_Amount"].ToString()),
                            TdsAmt = GetValue<double>(drrr["Total_Tax_Amt"].ToString()),
                            sec = GetValue<string>(drrr["Section"].ToString()),
                            Totalcount = GetValue<int>(drrr["Totalcount"].ToString()),
                            BnkChl = GetValue<int>(drrr["Challan_No"].ToString()),
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
                                    Amt = GetValue<string>(drrr["Voucher_Amount"].ToString()),
                                    TDS = GetValue<string>(drrr["TDS_Amt"].ToString()),
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
            return obj_Drp as IEnumerable<tbl_VoucherModifyGrd>;
        }


        public IEnumerable<tbl_VoucherModifyGrd> BAL_ModifyGrd(tbl_VoucherModifyGrd tobj)
        {
            List<tbl_VoucherModifyGrd> obj_Drp = new List<tbl_VoucherModifyGrd>();
            try
            {
                using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_ModifyGrd(tobj))
                {
                    while (drrr.Read())
                    {
                        obj_Drp.Add(new tbl_VoucherModifyGrd()
                        {

                            PDate = GetValue<string>(drrr["Voucher_DT"].ToString()),
                            DName = GetValue<string>(drrr["Deductee_Name"].ToString()),
                            CPaid = GetValue<string>(drrr["Challan_ID"].ToString()),
                            did = GetValue<int>(drrr["Deductee_ID"].ToString()),
                            vid = GetValue<int>(drrr["Voucher_ID"].ToString()),
                            AmtPaid = GetValue<double>(drrr["Voucher_Amount"].ToString()),
                            TdsAmt = GetValue<double>(drrr["Total_Tax_Amt"].ToString()),
                            sec = GetValue<string>(drrr["Section"].ToString()),
                            Totalcount = GetValue<int>(drrr["Totalcount"].ToString()),
                            BnkChl = GetValue<int>(drrr["Challan_No"].ToString()),
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
                                    Amt = GetValue<string>(drrr["Voucher_Amount"].ToString()),
                                    TDS = GetValue<string>(drrr["TDS_Amt"].ToString()),
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
            return obj_Drp as IEnumerable<tbl_VoucherModifyGrd>;
        }


        public IEnumerable<tbl_VoucherModify> BAL_Modify(tbl_VoucherModify tobj)
        {
            List<tbl_VoucherModify> obj_Drp = new List<tbl_VoucherModify>();
            try
            {
                using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_Modify(tobj))
                {
                    while (drrr.Read())
                    {
                        obj_Drp.Add(new tbl_VoucherModify()
                        {

                            PDate = GetValue<string>(drrr["Voucher_DT"].ToString()),
                            did = GetValue<int>(drrr["Deductee_ID"].ToString()),
                            vid = GetValue<int>(drrr["Voucher_ID"].ToString()),
                            nid = GetValue<int>(drrr["Nature_ID"].ToString()),
                            rid = GetValue<int>(drrr["Remittance_ID"].ToString()),
                            nsid = GetValue<string>(drrr["Nature_Sub_ID"].ToString()),
                            DName = GetValue<string>(drrr["Deductee_Name"].ToString()),
                            rsid = GetValue<string>(drrr["Reason"].ToString()),
                            tid = GetValue<string>(drrr["Deductee_Type"].ToString()),
                            Cert = GetValue<string>(drrr["Certificate_NO"].ToString()),
                            PAN = GetValue<string>(drrr["PAN_NO"].ToString()),
                            Bid = GetValue<int>(drrr["BranchId"].ToString()),
                            Invid = GetValue<string>(drrr["InvORBillNo"].ToString()),
                            chk = GetValue<bool>(drrr["Threshold_Limit"].ToString()),
                            AmtPaid = GetValue<float>(drrr["Voucher_Amount"].ToString()),
                            TdsAmt = GetValue<float>(drrr["tds_AMt"].ToString()),
                            Rate = GetValue<string>(drrr["TDS_Percentage"].ToString()),
                            Sur = GetValue<float>(drrr["surcharge_amt"].ToString()),
                            Cess = GetValue<float>(drrr["ecess_amt"].ToString()),
                            Total = GetValue<float>(drrr["Total_Tax_Amt"].ToString()),
                            isNri = GetValue<bool>(drrr["IS_NRI"].ToString()),
                            sel = GetValue<int>(drrr["Sel"].ToString()),
                            formType = GetValue<string>(drrr["Form_Type"].ToString()),
                            Thold = GetValue<bool>(drrr["Threshold_Limit"].ToString()),
                            Quater = GetValue<string>(drrr["Quater"].ToString()),
                            RT = GetValue<string>(drrr["TDS_Rate_From"].ToString()),
                            ChlTDS = GetValue<float>(drrr["challantds"].ToString()),
                            VTds = GetValue<double>(drrr["challantds"].ToString()),
                            Add1 = GetValue<string>(drrr["Flat_NO"].ToString()),
                            Contactno = GetValue<string>(drrr["ContactNo"].ToString()),
                            Emailid = GetValue<string>(drrr["Email"].ToString()),
                            NriTDSRT = GetValue<string>(drrr["NRI_TDS_Rate"].ToString()),
                            TaxId = GetValue<string>(drrr["TaxIdentificationNo"].ToString()),
                            CountryId = GetValue<int>(drrr["Country_ID"].ToString()),
                            eqInd = GetValue<string>(drrr["Estb_in_India"].ToString()),
                            eqNri = GetValue<string>(drrr["Nri_27EQ"].ToString()),
                            BAC1A = GetValue<string>(drrr["BAC_1A"].ToString()),
                            PAN_AAdhar = GetValue<string>(drrr["PAN_AAdhar_Status"].ToString()),
                        });
                    }

                    //List<tbl_VoucherModifyGrd> listGrd = new List<tbl_VoucherModifyGrd>();

                    //if (drrr.NextResult())
                    //{
                    //    if (drrr.HasRows)
                    //    {
                    //        while (drrr.Read())
                    //        {
                    //            listGrd.Add(new tbl_VoucherModifyGrd()
                    //            {
                    //                PDate = GetValue<string>(drrr["Voucher_DT"].ToString()),
                    //                DName = GetValue<string>(drrr["Deductee_Name"].ToString()),
                    //                CPaid = GetValue<string>(drrr["Challan_BankNo"].ToString()),
                    //                //did = GetValue<int>(drrr["Compid"].ToString()),
                    //                //vid = GetValue<int>(drrr["Compid"].ToString()),

                    //                AmtPaid = GetValue<double>(drrr["Voucher_Amount"].ToString()),
                    //                TdsAmt = GetValue<double>(drrr["Total_Tax_Amt"].ToString()),

                    //            });
                    //        }
                    //    }
                    //}

                    List<tbl_Section> listSec = new List<tbl_Section>();

                    if (drrr.NextResult())
                    {
                        if (drrr.HasRows)
                        {
                            while (drrr.Read())
                            {
                                listSec.Add(new tbl_Section()
                                {
                                    Section = GetValue<string>(drrr["Section_Name"].ToString()),
                                    Section_Id = GetValue<string>(drrr["Section_Id"].ToString()),

                                });
                            }
                        }
                    }

                    foreach (var item in obj_Drp)
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
            return obj_Drp as IEnumerable<tbl_VoucherModify>;
        }

        public IEnumerable<tbl_DeducteeDetails> BAL_Deductee_Details(tbl_DeducteeDetails tobj)
        {
            List<tbl_DeducteeDetails> obj_Drp = new List<tbl_DeducteeDetails>();
            try
            {
                using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_BindDeductee_Details(tobj))
                {
                    while (drrr.Read())
                    {
                        obj_Drp.Add(new tbl_DeducteeDetails()
                        {
                            Cert = GetValue<string>(drrr["Certificate_NO"].ToString()),
                            RT = GetValue<string>(drrr["NRI_TDS_Rate"].ToString()),
                            tid = GetValue<string>(drrr["Deductee_Type"].ToString()),
                            sec = GetValue<string>(drrr["Reasons"].ToString()),
                            isNri = GetValue<bool>(drrr["IS_NRI"].ToString()),
                            Rate = GetValue<string>(drrr["TDS_Rate"].ToString()),
                            Email = GetValue<string>(drrr["Email"].ToString()),
                            PAN = GetValue<string>(drrr["PAN_NO"].ToString()),
                            TaxId = GetValue<string>(drrr["TaxIdentificationNo"].ToString()),
                            Countryid = GetValue<int>(drrr["Country_ID"].ToString()),
                            Add1 = GetValue<string>(drrr["add1"].ToString()),
                            Cnumber = GetValue<string>(drrr["ContactNo"].ToString()),
                            nid = GetValue<int>(drrr["Nature_ID"].ToString()),
                            Compliance = GetValue<int>(drrr["TR206"].ToString()),
                            isInd = GetValue<bool>(drrr["IS_Individual"].ToString()),
                            BAC_1A = GetValue<string>(drrr["BAC_1A"].ToString()),
                            PAN_AAdhar = GetValue<string>(drrr["PAN_AAdhar_Status"].ToString()),

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
                                    Bname = GetValue<string>(drrr["Branch_Name"].ToString()),
                                    bid = GetValue<int>(drrr["Branch_Id"].ToString()),

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
                                    Section = GetValue<string>(drrr["Section_Name"].ToString()),
                                    Section_Id = GetValue<string>(drrr["Section_Id"].ToString()),

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
                                    Nature_ID = GetValue<int>(drrr["Nature_ID"].ToString()),
                                    Nature_Sub_Id = GetValue<string>(drrr["Nature_Sub_ID"].ToString()),

                                });
                            }
                        }
                    }

                    foreach (var item in obj_Drp)
                    {
                        item.Lst_Br = listBr;
                        item.Lst_Sec = listSec;
                        item.Lst_Nature = listNat;
                    }

                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return obj_Drp as IEnumerable<tbl_DeducteeDetails>;
        }

        public IEnumerable<tbl_VoucherModify> BAL_Section_Modify(tbl_VoucherModify tobj)
        {
            List<tbl_VoucherModify> obj_Drp = new List<tbl_VoucherModify>();
            try
            {
                using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_Section_Modify(tobj))
                {
                    while (drrr.Read())
                    {
                        obj_Drp.Add(new tbl_VoucherModify()
                        {
                            vid = GetValue<int>(drrr["Voucher_id"].ToString()),
                        });
                    }
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return obj_Drp as IEnumerable<tbl_VoucherModify>;
        }

        public IEnumerable<tbl_DeducteeRate> BAL_Deductee_Rate(tbl_DeducteeRate tobj)
        {
            List<tbl_DeducteeRate> obj_Drp = new List<tbl_DeducteeRate>();
            try
            {
                using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_BindDeductee_Rate(tobj))
                {
                    while (drrr.Read())
                    {
                        obj_Drp.Add(new tbl_DeducteeRate()
                        {
                            Rate = GetValue<string>(drrr["TDS"].ToString()),
                        });
                    }
                }
                //obj_Drp.Add(new tbl_DeducteeRate()
                //{
                //    VDT = GetValue<DateTime>(tobj.VDT.ToString()),
                //});
                //obj_Drp.Add(new tbl_DeducteeRate()
                //{
                //    nid = GetValue<int>(tobj.nid),
                //});

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return obj_Drp as IEnumerable<tbl_DeducteeRate>;
        }


        public IEnumerable<tbl_VoucherModify> BAL_SaveRecords(tbl_VoucherModify tobj)
        {
            List<tbl_VoucherModify> obj_Drp = new List<tbl_VoucherModify>();

            using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_InsertVoucher(tobj))
            {
                while (drrr.Read())
                {
                    obj_Drp.Add(new tbl_VoucherModify()
                    {

                        vid = GetValue<int>(drrr["Voucher_ID"].ToString()),

                    });
                }

            }
            return obj_Drp as IEnumerable<tbl_VoucherModify>;
        }


        public IEnumerable<tbl_VoucherModifyGrd> BAL_LastGrd(tbl_VoucherModifyGrd tobj)
        {
            List<tbl_VoucherModifyGrd> obj_Drp = new List<tbl_VoucherModifyGrd>();

            using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_LastGrd(tobj))
            {
                while (drrr.Read())
                {
                    obj_Drp.Add(new tbl_VoucherModifyGrd()
                    {

                        PDate = GetValue<string>(drrr["Voucher_DT"].ToString()),
                        DName = GetValue<string>(drrr["Deductee_Name"].ToString()),
                        CPaid = GetValue<string>(drrr["Challan_BankNo"].ToString()),
                        //did = GetValue<int>(drrr["Compid"].ToString()),
                        //vid = GetValue<int>(drrr["Compid"].ToString()),

                        AmtPaid = GetValue<double>(drrr["Voucher_Amount"].ToString()),
                        TdsAmt = GetValue<double>(drrr["Total_Tax_Amt"].ToString()),

                    });
                }

            }
            return obj_Drp as IEnumerable<tbl_VoucherModifyGrd>;
        }


        public IEnumerable<tbl_VoucherGrd> BAL_FillGrd(tbl_VoucherGrd tobj)
        {
            List<tbl_VoucherGrd> listGrd = new List<tbl_VoucherGrd>();
            try
            {
                using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_FillGrd(tobj))
                {
                    while (drrr.Read())
                    {
                        listGrd.Add(new tbl_VoucherGrd()
                        {

                            mth = GetValue<string>(drrr["Particulars"].ToString()),
                            Entries = GetValue<int>(drrr["Enteries"].ToString()),
                            Amt = GetValue<double>(drrr["Voucher_Amount"].ToString()),
                            Tds = GetValue<double>(drrr["TDS_Amt"].ToString()),
                            mthno = GetValue<int>(drrr["mth"].ToString()),
                            Tent = GetValue<int>(drrr["Tent"].ToString()),
                            TAmt = GetValue<double>(drrr["Vamt"].ToString()),
                            TTds = GetValue<double>(drrr["Tamt"].ToString()),
                            Upaid = GetValue<int>(drrr["UP"].ToString()),
                            Tup = GetValue<int>(drrr["TUP"].ToString()),
                        });
                    }

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return listGrd as IEnumerable<tbl_VoucherGrd>;
        }

        public IEnumerable<tbl_VoucherModifyGrd> BAL_Delete_Voucher(tbl_VoucherModifyGrd tobj)
        {
            List<tbl_VoucherModifyGrd> obj_Drp = new List<tbl_VoucherModifyGrd>();
            try
            {
                using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_Delete_Voucher(tobj))
                {
                    while (drrr.Read())
                    {
                        obj_Drp.Add(new tbl_VoucherModifyGrd()
                        {
                            vid = GetValue<int>(drrr["Voucher_ID"].ToString()),

                        });
                    }

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return obj_Drp as IEnumerable<tbl_VoucherModifyGrd>;
        }


        public IEnumerable<tbl_VoucherModify> BAL_ImportDeductee(tbl_VoucherModify tobj)
        {
            List<tbl_VoucherModify> obj_Drp = new List<tbl_VoucherModify>();
            try
            {
                using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_ImportDeductee(tobj))
                {
                    while (drrr.Read())
                    {
                        obj_Drp.Add(new tbl_VoucherModify()
                        {
                            compid = GetValue<int>(drrr["compid"].ToString()),

                        });
                    }

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return obj_Drp as IEnumerable<tbl_VoucherModify>;
        }


        public IEnumerable<tbl_VoucherGrd> BAL_SaveToken(tbl_VoucherGrd tobj)
        {
            List<tbl_VoucherGrd> obj_Drp = new List<tbl_VoucherGrd>();
            try
            {
                using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_SaveToken(tobj))
                {
                    while (drrr.Read())
                    {
                        obj_Drp.Add(new tbl_VoucherGrd()
                        {
                            compid = GetValue<int>(drrr["compid"].ToString()),

                        });
                    }

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return obj_Drp as IEnumerable<tbl_VoucherGrd>;
        }

        public IEnumerable<tbl_TracesDetail> BAL_GetTracesDetails(tbl_TracesDetail tobj)
        {
            List<tbl_TracesDetail> obj_Drp = new List<tbl_TracesDetail>();
            try
            {
                using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_GetTracesDetails(tobj))
                {
                    while (drrr.Read())
                    {
                        obj_Drp.Add(new tbl_TracesDetail()
                        {
                            Userid = GetValue<string>(drrr["User_ID"].ToString()),
                            Password = GetValue<string>(drrr["Password"].ToString()),
                        });
                    }

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return obj_Drp as IEnumerable<tbl_TracesDetail>;
        }

        public IEnumerable<tbl_TracesDetail> BAL_TracesDetailsSave(tbl_TracesDetail tobj)
        {
            List<tbl_TracesDetail> obj_Drp = new List<tbl_TracesDetail>();
            try
            {
                using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_TracesDetailsSave(tobj))
                {
                    while (drrr.Read())
                    {
                        obj_Drp.Add(new tbl_TracesDetail()
                        {
                            Compid = GetValue<int>(drrr["compid"].ToString()),

                        });
                    }

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return obj_Drp as IEnumerable<tbl_TracesDetail>;
        }

        public IEnumerable<MisMatch_Vouchers> BAL_MisMatch(MisMatch_Vouchers tobj)
        {
            List<MisMatch_Vouchers> obj_Drp = new List<MisMatch_Vouchers>();
            try
            {
                if (tobj.FromType == "26Q")
                {
                    using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_NonSalaryValidation(tobj))
                    {//// Table 0
                        while (drrr.Read())
                        {
                            obj_Drp.Add(new MisMatch_Vouchers()
                            {
                                Compid = GetValue<int>(drrr["Compid"].ToString()),
                            });
                        }

                        List<MisMatch_PAN> listPAN = new List<MisMatch_PAN>();
                        //// Table 1
                        if (drrr.NextResult())
                        {
                            if (drrr.HasRows)
                            {
                                while (drrr.Read())
                                {
                                    listPAN.Add(new MisMatch_PAN()
                                    {
                                        PDate = GetValue<string>(drrr["Payment_Date"].ToString()),
                                        DName = GetValue<string>(drrr["Deductee"].ToString()),
                                        AmtPaid = GetValue<float>(drrr["Amount_Paid"].ToString()),
                                        VPAN = GetValue<string>(drrr["VPAN"].ToString()),
                                        DPAN = GetValue<string>(drrr["DPAN"].ToString()),
                                        Vid = GetValue<int>(drrr["Vid"].ToString()),
                                    });
                                }
                            }
                        }

                        List<Nri_MisMatch> listNri = new List<Nri_MisMatch>();
                        //// Table 2
                        //if (tobj.FromType == "27Q")
                        //{
                        if (drrr.NextResult())
                        {
                            if (drrr.HasRows)
                            {
                                while (drrr.Read())
                                {
                                    listNri.Add(new Nri_MisMatch()
                                    {
                                        DName = GetValue<string>(drrr["Deductee"].ToString()),
                                        Email = GetValue<string>(drrr["Email"].ToString()),
                                        Tel = GetValue<string>(drrr["Contact"].ToString()),
                                        Tax = GetValue<string>(drrr["Tax"].ToString()),
                                        Add = GetValue<string>(drrr["Address"].ToString()),

                                    });
                                }
                            }
                        }
                        //}

                        List<MisMatch_BAC> listBAC = new List<MisMatch_BAC>();
                        //// Table 3
                        if (drrr.NextResult())
                        {
                            if (drrr.HasRows)
                            {
                                while (drrr.Read())
                                {
                                    listBAC.Add(new MisMatch_BAC()
                                    {
                                        DName = GetValue<string>(drrr["Deductee"].ToString()),
                                        Did = GetValue<int>(drrr["Did"].ToString()),
                                    });
                                }
                            }
                        }

                        List<MisMatch_DType> listDt = new List<MisMatch_DType>();
                        //// Table 4
                        if (drrr.NextResult())
                        {
                            if (drrr.HasRows)
                            {
                                while (drrr.Read())
                                {
                                    listDt.Add(new MisMatch_DType()
                                    {
                                        DName = GetValue<string>(drrr["Deductee"].ToString()),
                                        Did = GetValue<int>(drrr["Did"].ToString()),
                                        PAN = GetValue<string>(drrr["Pan_no"].ToString()),
                                    });
                                }
                            }
                        }

                        List<MisMatch_Trans> listTR = new List<MisMatch_Trans>();
                        //// Table 5
                        if (drrr.NextResult())
                        {
                            if (drrr.HasRows)
                            {
                                while (drrr.Read())
                                {
                                    listTR.Add(new MisMatch_Trans()
                                    {
                                        PDate = GetValue<string>(drrr["Payment_Date"].ToString()),
                                        DName = GetValue<string>(drrr["Deductee"].ToString()),
                                        AmtPaid = GetValue<float>(drrr["VAmount"].ToString()),
                                        TdsAmt = GetValue<float>(drrr["TDS_Amt"].ToString()),
                                        CTdsAmt = GetValue<float>(drrr["Correct_TDS"].ToString()),
                                        RT = GetValue<string>(drrr["TDS_Percentage"].ToString()),
                                        Cert = GetValue<string>(drrr["tds_Certificate"].ToString()),
                                        Error = GetValue<string>(drrr["Error"].ToString()),
                                        Vid = GetValue<int>(drrr["Vid"].ToString()),
                                    });
                                }
                            }
                        }
                        foreach (var item in obj_Drp)
                        {
                            item.Lst_PAN = listPAN;
                            item.Lst_Nri = listNri;
                            item.Lst_BACIA = listBAC;
                            item.Lst_DType = listDt;
                            item.Lst_Tr = listTR;
                        }
                    }
                }
                /////////////////*****************************   27Q
                if (tobj.FromType == "27Q")
                {
                    using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_NonSalaryValidation(tobj))
                    {//// Table 0
                        while (drrr.Read())
                        {
                            obj_Drp.Add(new MisMatch_Vouchers()
                            {
                                Compid = GetValue<int>(drrr["Compid"].ToString()),
                            });
                        }

                        List<MisMatch_PAN> listPAN = new List<MisMatch_PAN>();
                        //// Table 1
                        if (drrr.NextResult())
                        {
                            if (drrr.HasRows)
                            {
                                while (drrr.Read())
                                {
                                    listPAN.Add(new MisMatch_PAN()
                                    {
                                        PDate = GetValue<string>(drrr["Payment_Date"].ToString()),
                                        DName = GetValue<string>(drrr["Deductee"].ToString()),
                                        AmtPaid = GetValue<float>(drrr["Amount_Paid"].ToString()),
                                        VPAN = GetValue<string>(drrr["VPAN"].ToString()),
                                        DPAN = GetValue<string>(drrr["DPAN"].ToString()),
                                        Vid = GetValue<int>(drrr["Vid"].ToString()),
                                    });
                                }
                            }
                        }

                        List<Nri_MisMatch> listNri = new List<Nri_MisMatch>();
                        //// Table 2
                        //if (tobj.FromType == "27Q")
                        //{
                        if (drrr.NextResult())
                        {
                            if (drrr.HasRows)
                            {
                                while (drrr.Read())
                                {
                                    listNri.Add(new Nri_MisMatch()
                                    {
                                        DName = GetValue<string>(drrr["Deductee"].ToString()),
                                        Email = GetValue<string>(drrr["Email"].ToString()),
                                        Tel = GetValue<string>(drrr["Contact"].ToString()),
                                        Tax = GetValue<string>(drrr["Tax"].ToString()),
                                        Add = GetValue<string>(drrr["Address"].ToString()),

                                    });
                                }
                            }
                        }
                        //}

                        List<MisMatch_BAC> listBAC = new List<MisMatch_BAC>();
                        //// Table 3
                        if (drrr.NextResult())
                        {
                            if (drrr.HasRows)
                            {
                                while (drrr.Read())
                                {
                                    listBAC.Add(new MisMatch_BAC()
                                    {
                                        DName = GetValue<string>(drrr["Deductee"].ToString()),
                                        Did = GetValue<int>(drrr["Did"].ToString()),
                                    });
                                }
                            }
                        }

                        List<MisMatch_DType> listDt = new List<MisMatch_DType>();
                        //// Table 4
                        if (drrr.NextResult())
                        {
                            if (drrr.HasRows)
                            {
                                while (drrr.Read())
                                {
                                    listDt.Add(new MisMatch_DType()
                                    {
                                        DName = GetValue<string>(drrr["Deductee"].ToString()),
                                        Did = GetValue<int>(drrr["Did"].ToString()),
                                        PAN = GetValue<string>(drrr["Pan_no"].ToString()),
                                    });
                                }
                            }
                        }

                        List<MisMatch_Trans> listTR = new List<MisMatch_Trans>();
                        //// Table 5
                        if (drrr.NextResult())
                        {
                            if (drrr.HasRows)
                            {
                                while (drrr.Read())
                                {
                                    listTR.Add(new MisMatch_Trans()
                                    {
                                        PDate = GetValue<string>(drrr["Payment_Date"].ToString()),
                                        DName = GetValue<string>(drrr["Deductee"].ToString()),
                                        AmtPaid = GetValue<float>(drrr["VAmount"].ToString()),
                                        TdsAmt = GetValue<float>(drrr["TDS_Amt"].ToString()),
                                        CTdsAmt = GetValue<float>(drrr["Correct_TDS"].ToString()),
                                        RT = GetValue<string>(drrr["TDS_Percentage"].ToString()),
                                        Cert = GetValue<string>(drrr["tds_Certificate"].ToString()),
                                        Error = GetValue<string>(drrr["Error"].ToString()),
                                        Vid = GetValue<int>(drrr["Vid"].ToString()),
                                    });
                                }
                            }
                        }
                        foreach (var item in obj_Drp)
                        {
                            item.Lst_PAN = listPAN;
                            item.Lst_Nri = listNri;
                            item.Lst_BACIA = listBAC;
                            item.Lst_DType = listDt;
                            item.Lst_Tr = listTR;
                        }
                    }
                }

                /////////////////*****************************   27EQ
                if (tobj.FromType == "27EQ")
                {
                    using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_NonSalaryValidation(tobj))
                    {//// Table 0
                        while (drrr.Read())
                        {
                            obj_Drp.Add(new MisMatch_Vouchers()
                            {
                                Compid = GetValue<int>(drrr["Compid"].ToString()),
                            });
                        }

                        List<MisMatch_PAN> listPAN = new List<MisMatch_PAN>();
                        //// Table 1
                        if (drrr.NextResult())
                        {
                            if (drrr.HasRows)
                            {
                                while (drrr.Read())
                                {
                                    listPAN.Add(new MisMatch_PAN()
                                    {
                                        PDate = GetValue<string>(drrr["Payment_Date"].ToString()),
                                        DName = GetValue<string>(drrr["Deductee"].ToString()),
                                        AmtPaid = GetValue<float>(drrr["Amount_Paid"].ToString()),
                                        VPAN = GetValue<string>(drrr["VPAN"].ToString()),
                                        DPAN = GetValue<string>(drrr["DPAN"].ToString()),
                                        Vid = GetValue<int>(drrr["Vid"].ToString()),
                                    });
                                }
                            }
                        }

                        List<Nri_MisMatch> listNri = new List<Nri_MisMatch>();
                        //// Table 2
                        //if (tobj.FromType == "27Q")
                        //{
                        if (drrr.NextResult())
                        {
                            if (drrr.HasRows)
                            {
                                while (drrr.Read())
                                {
                                    listNri.Add(new Nri_MisMatch()
                                    {
                                        DName = GetValue<string>(drrr["Deductee"].ToString()),
                                        Email = GetValue<string>(drrr["Email"].ToString()),
                                        Tel = GetValue<string>(drrr["Contact"].ToString()),
                                        Tax = GetValue<string>(drrr["Tax"].ToString()),
                                        Add = GetValue<string>(drrr["Address"].ToString()),

                                    });
                                }
                            }
                        }
                        //}

                        List<MisMatch_BAC> listBAC = new List<MisMatch_BAC>();
                        //// Table 3
                        if (drrr.NextResult())
                        {
                            if (drrr.HasRows)
                            {
                                while (drrr.Read())
                                {
                                    listBAC.Add(new MisMatch_BAC()
                                    {
                                        DName = GetValue<string>(drrr["Deductee"].ToString()),
                                        Did = GetValue<int>(drrr["Did"].ToString()),
                                    });
                                }
                            }
                        }

                        List<MisMatch_DType> listDt = new List<MisMatch_DType>();
                        //// Table 4
                        if (drrr.NextResult())
                        {
                            if (drrr.HasRows)
                            {
                                while (drrr.Read())
                                {
                                    listDt.Add(new MisMatch_DType()
                                    {
                                        DName = GetValue<string>(drrr["Deductee"].ToString()),
                                        Did = GetValue<int>(drrr["Did"].ToString()),
                                        PAN = GetValue<string>(drrr["Pan_no"].ToString()),
                                    });
                                }
                            }
                        }

                        List<MisMatch_Trans> listTR = new List<MisMatch_Trans>();
                        //// Table 5
                        if (drrr.NextResult())
                        {
                            if (drrr.HasRows)
                            {
                                while (drrr.Read())
                                {
                                    listTR.Add(new MisMatch_Trans()
                                    {
                                        PDate = GetValue<string>(drrr["Payment_Date"].ToString()),
                                        DName = GetValue<string>(drrr["Deductee"].ToString()),
                                        AmtPaid = GetValue<float>(drrr["VAmount"].ToString()),
                                        TdsAmt = GetValue<float>(drrr["TDS_Amt"].ToString()),
                                        CTdsAmt = GetValue<float>(drrr["Correct_TDS"].ToString()),
                                        RT = GetValue<string>(drrr["TDS_Percentage"].ToString()),
                                        Cert = GetValue<string>(drrr["tds_Certificate"].ToString()),
                                        Error = GetValue<string>(drrr["Error"].ToString()),
                                        Vid = GetValue<int>(drrr["Vid"].ToString()),
                                    });
                                }
                            }
                        }
                        foreach (var item in obj_Drp)
                        {
                            item.Lst_PAN = listPAN;
                            item.Lst_Nri = listNri;
                            item.Lst_BACIA = listBAC;
                            item.Lst_DType = listDt;
                            item.Lst_Tr = listTR;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return obj_Drp as IEnumerable<MisMatch_Vouchers>;
        }


        public IEnumerable<MisMatch_BAC> BAL_BACUpdate(MisMatch_BAC tobj)
        {
            List<MisMatch_BAC> obj_Drp = new List<MisMatch_BAC>();
            try
            {
                using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_UpdateBAC(tobj))
                {
                    while (drrr.Read())
                    {
                        obj_Drp.Add(new MisMatch_BAC()
                        {
                            Compid = GetValue<int>(drrr["Compid"].ToString()),
                        });
                    }


                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return obj_Drp as IEnumerable<MisMatch_BAC>;
        }

        public IEnumerable<MisMatch_DType> BAL_DTUpdate(MisMatch_DType tobj)
        {
            List<MisMatch_DType> obj_Drp = new List<MisMatch_DType>();
            try
            {
                using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_UpdateDType(tobj))
                {
                    while (drrr.Read())
                    {
                        obj_Drp.Add(new MisMatch_DType()
                        {
                            Compid = GetValue<int>(drrr["Compid"].ToString()),
                        });
                    }


                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return obj_Drp as IEnumerable<MisMatch_DType>;
        }


        public IEnumerable<PANNo> BAL_PANNOList(TracesInfo tobj)
        {
            List<PANNo> obj_PAN = new List<PANNo>();
            try
            {
                using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_Get_PANNoList(tobj))
                {
                    while (drrr.Read())
                    {
                        obj_PAN.Add(new PANNo() { PAN = GetValue<string>(drrr["PAN_NO"].ToString()) });
                    }
                }
            }

            catch (Exception ex)
            {
                throw ex;
            }
            return obj_PAN as IEnumerable<PANNo>;
        }


        public IEnumerable<tbl_DeducteeReport> BAL_Deductee_ReportGrid(tbl_DeducteeReport tobj)
        {
            List<tbl_DeducteeReport> obj_Drp = new List<tbl_DeducteeReport>();
            try
            {
                using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_Deductee_ReportGrid(tobj))
                {
                    while (drrr.Read())
                    {
                        obj_Drp.Add(new tbl_DeducteeReport()
                        {
                            DName = GetValue<string>(drrr["Deductee_Name"].ToString()),
                            PAN = GetValue<string>(drrr["PAN_NO"].ToString()),
                            Section = GetValue<string>(drrr["Section"].ToString()),
                            AmtPaid = GetValue<string>(drrr["AmtPaid"].ToString()),
                            TDS = GetValue<string>(drrr["TDS"].ToString()),
                            Paid = GetValue<string>(drrr["Paid"].ToString()),
                            Unpiad = GetValue<string>(drrr["unPaid"].ToString()),
                        });
                    }

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return obj_Drp as IEnumerable<tbl_DeducteeReport>;
        }


        public IEnumerable<tbl_DeducteeReport> BAL_TDS_ReportGrid(tbl_DeducteeReport tobj)
        {
            List<tbl_DeducteeReport> obj_Drp = new List<tbl_DeducteeReport>();
            try
            {
                using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_TDS_ReportGrid(tobj))
                {
                    while (drrr.Read())
                    {
                        obj_Drp.Add(new tbl_DeducteeReport()
                        {

                            PAN = GetValue<string>(drrr["Head"].ToString()),
                            Section = GetValue<string>(drrr["Section"].ToString()),
                            AmtPaid = GetValue<string>(drrr["AmtPaid"].ToString()),
                            TDS = GetValue<string>(drrr["TDS"].ToString()),
                            Paid = GetValue<string>(drrr["Paid"].ToString()),
                            Unpiad = GetValue<string>(drrr["unPaid"].ToString()),
                        });
                    }

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return obj_Drp as IEnumerable<tbl_DeducteeReport>;
        }


        public IEnumerable<tbl_VoucherModify> BAL_ListPANStatus(tbl_VoucherModify obj)
        {
            List<tbl_VoucherModify> obj_PAN = new List<tbl_VoucherModify>();
            try
            {
                using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_ListPANStatus(obj))
                {
                    while (drrr.Read())
                    {
                        obj_PAN.Add(new tbl_VoucherModify()
                        {
                            PDate = GetValue<string>(drrr["Voucher_DT"].ToString()),
                            vid = GetValue<int>(drrr["Voucher_ID"].ToString()),
                            nsid = GetValue<string>(drrr["Section"].ToString()),
                            DName = GetValue<string>(drrr["Deductee_Name"].ToString()),
                            PAN = GetValue<string>(drrr["PAN"].ToString()),
                            Rate = GetValue<string>(drrr["TDS_Percentage"].ToString()),
                            AmtPaid = GetValue<float>(drrr["Voucher_Amount"].ToString()),
                            Total = GetValue<float>(drrr["Total_Tax_Amt"].ToString()),
                            PAN_AAdhar = GetValue<string>(drrr["PAN_AAdhar_Status"].ToString()),
                            rid = GetValue<int>(drrr["RecordCount"].ToString()),
                        });
                    }
                }
            }

            catch (Exception ex)
            {
                throw ex;
            }
            return obj_PAN as IEnumerable<tbl_VoucherModify>;
        }


        public IEnumerable<PANNo> BAL_ListPANSummary(PANNo obj)
        {
            List<PANNo> obj_PAN = new List<PANNo>();
            try
            {
                using (SqlDataReader drrr = objDAL_VoucherEntries_Master.DAL_ListPANSummary(obj))
                {
                    while (drrr.Read())
                    {
                        obj_PAN.Add(new PANNo()
                        {
                            Active = GetValue<string>(drrr["Active"].ToString()),
                            InActive = GetValue<string>(drrr["InActive"].ToString()),
                            NotVerified = GetValue<string>(drrr["NotVerified"].ToString()),
                        });
                    }
                }
            }

            catch (Exception ex)
            {
                throw ex;
            }
            return obj_PAN as IEnumerable<PANNo>;
        }

    }

}
