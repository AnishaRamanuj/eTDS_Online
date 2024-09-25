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
    public class BAL_Dashboard : CommonFunctions
    {
        DAL_Dashboard objDAL_Dashboard = new DAL_Dashboard();
        
        public int _Company_ID { get; set; }
        public string _Quater { get; set; }
        public bool _IsChallan { get; set; }

        public IEnumerable<tbl_Dashboard> BAL_DashBoard(tbl_Dashboard tobj)
        {
            List<tbl_Dashboard> obj_Dash = new List<tbl_Dashboard>();
            try
            {
                using (SqlDataReader drrr = objDAL_Dashboard.DAL_DashboardDetails(tobj))
                {
                    while (drrr.Read())
                    {
                        obj_Dash.Add(new tbl_Dashboard()
                        {

                            compid = GetValue<int>(drrr["Company_id"].ToString()),

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
                                    AmtPaid = GetValue<double>(drrr["Voucher_Amount"].ToString()),
                                    sec = GetValue<string>(drrr["section"].ToString()),
                                    TdsAmt = GetValue<double>(drrr["TDS_Amt"].ToString()),
                                    TdsRate = GetValue<string>(drrr["TRate"].ToString()),
                                    Totalcount = GetValue<int>(drrr["vCount"].ToString()),

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
                                    AmtPaid = GetValue<double>(drrr["Amt"].ToString()),
                                    TdsAmt = GetValue<double>(drrr["TDS"].ToString()),
                                    nid = GetValue<int>(drrr["Invalid"].ToString()),
                                    Total = GetValue<double>(drrr["UPaid"].ToString()),
                                    did = GetValue<int>(drrr["did"].ToString()),
                                    VCCA = GetValue<int>(drrr["CCA"].ToString()),
                                    UVCCA = GetValue<int>(drrr["UCCA"].ToString()),
                                    RToken = GetValue<string>(drrr["RToken"].ToString()),
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
                                    ChallanID = GetValue<int>(drrr["Cid"].ToString()),
                                    CAmount = GetValue<double>(drrr["Camt"].ToString()),
                                    Verify = GetValue<string>(drrr["Verify"].ToString()),
                                    ndVrfy = GetValue<string>(drrr["NeedVerfy"].ToString()),
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
                                    Section = GetValue<string>(drrr["section"].ToString()),
                                    Tds_Amt = GetValue<double >(drrr["tds"].ToString()),
                                    //PAS = GetValue<double>(drrr["Active"].ToString()),
                                });
                            }
                        }
                    }

                    List<PANNo> listpan = new List<PANNo>();

                    if (drrr.NextResult())
                    {
                        if (drrr.HasRows)
                        {
                            while (drrr.Read())
                            {
                                listpan.Add(new PANNo()
                                {
                                    Active = GetValue<string>(drrr["Active"].ToString()),
                                    InActive = GetValue<string>(drrr["InActive"].ToString()),
                                    NotVerified = GetValue<string>(drrr["NotVerified"].ToString()),
                                    InValid = GetValue<string>(drrr["Invalid"].ToString()),
                                });
                            }
                        }
                    }

                    foreach (var item in obj_Dash)
                    {
                        item.VoucherGrd = listGrd;
                        item.VoucherModify = listVoucher;
                        item.Challan = listChallan;
                        item.Section = listSection;
                        item.lstPanno = listpan;
                    }
                }

            }
            catch (Exception ex)
            {
                
            }
            return obj_Dash as IEnumerable<tbl_Dashboard>;
        }

        public IEnumerable<tbl_Dashboard> BAL_Status(string r1, string r2, string r3, string r4, string XL)
        {
            List<tbl_Dashboard> obj_Dash = new List<tbl_Dashboard>();
            try
            {
                obj_Dash.Add(new tbl_Dashboard()
                {

                    Rstatus = GetValue<string>(r1.ToString()),
                    ST = GetValue<string>(r2.ToString()),
                    Rfile = GetValue<string>(r3.ToString()),
                    Pfile = GetValue<string>(r4.ToString()),
                    XLPath = GetValue<string>(XL.ToString()),
                });

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return obj_Dash as IEnumerable<tbl_Dashboard>;
        }


        public IEnumerable<tbl_Dashboard> BAL_ZipPath(string r1 )
        {
            List<tbl_Dashboard> obj_Dash = new List<tbl_Dashboard>();
            try
            {
                obj_Dash.Add(new tbl_Dashboard()
                {
                    Rfile = GetValue<string>(r1.ToString()),
                });

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return obj_Dash as IEnumerable<tbl_Dashboard>;
        }

        public IEnumerable<tbl_Dashboard> BAL_SaveToken(tbl_Dashboard tobj)
        {
            List<tbl_Dashboard> obj_Dash = new List<tbl_Dashboard>();
            try
            {
                using (SqlDataReader drrr = objDAL_Dashboard.DAL_SaveToken(tobj))
                {
                    while (drrr.Read())
                    {
                        obj_Dash.Add(new tbl_Dashboard()
                        {

                            compid = GetValue<int>(drrr["Compid"].ToString()),

                        });
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return obj_Dash as IEnumerable<tbl_Dashboard>;
        }

        //////////////////////////////////////////////////// Start of  Old  Code
        public DataSet Get_Dashboard_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Dashboard._Company_ID = _Company_ID;
                ds = objDAL_Dashboard.Get_Dashboard_Details();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return ds;
        }

        public DataSet Get_Summary_Statements()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Dashboard._Company_ID = _Company_ID;
                objDAL_Dashboard._Quater = _Quater;
                objDAL_Dashboard._IsChallan = _IsChallan;

                ds = objDAL_Dashboard.Get_Summary_Statements();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return ds;
        }

        public DataSet Get_Company_Master_DetailsByID()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Dashboard._Company_ID = _Company_ID;
                ds = objDAL_Dashboard.Get_Company_Master_DetailsByID();
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet BAL_GetChartQuaterSmmary()
        {
            try
            {
                objDAL_Dashboard._Company_ID = _Company_ID;
                DataSet ds = objDAL_Dashboard.DAL_GetChartQuaterSmmary();
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
