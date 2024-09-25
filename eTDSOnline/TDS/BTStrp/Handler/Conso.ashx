<%@ WebHandler Language="C#" Class="Conso" %>

using System.Web.Services;

using System;
using System.Web;
using System.Net;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Data.SqlClient;
using System.Web.SessionState;

using System.Collections.Generic;
using System.Linq;
using System.Text;
using Newtonsoft.Json;
using Microsoft.ApplicationBlocks1.Data;
using DataLayer;

public class Conso : DataLayer.DALCommon, IHttpHandler, IRequiresSessionState {

    public void ProcessRequest(HttpContext context)
    {
        try
        {
            DataSet ds = new DataSet();
            //Check if Request is to Upload the File.
            if (context.Request.Files.Count > 0)
            {
                //Fetch the Uploaded File.
                HttpPostedFile postedFile = context.Request.Files[0];

                //Set the Folder Path.
                string folderPath = context.Server.MapPath("~/Uploads/");

                //Set the File Name.
                string fileName = Path.GetFileName(postedFile.FileName);


                string fullPath = folderPath + fileName;
                string extension = Path.GetExtension(fullPath);
                int j = fileName.Length;
                fileName = fileName.Substring(0, j - 4) + ".txt";
                fullPath = folderPath + fileName;
                //Save the File in Folder.
                postedFile.SaveAs(fullPath);
                string header = "No";


                OleDbConnection connection = new OleDbConnection();
                connection.ConnectionString = @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + folderPath + ";Extended Properties='Text;HDR=NO;FMT=Delimited(^);IMEX=1';Persist Security Info=False";
                OleDbDataAdapter da = new OleDbDataAdapter("SELECT * FROM [" + fileName + "]", connection);
                DataTable dTtxt = new DataTable();
                DataColumn newColumn = new DataColumn("Id", typeof(System.Int32));
                newColumn.AutoIncrement = true;
                newColumn.AutoIncrementSeed = 1;
                newColumn.AutoIncrementStep = 1;
                dTtxt.Columns.Add(newColumn);

                da.Fill(dTtxt);
                int iCol = dTtxt.Columns.Count;
                string s = "";

                /////////////////// if datatable has multiple columns due to tab separtion
                ///////////  read data from all col and update in 1st col
                if (iCol > 2)
                {
                    for (int i = 1; i < iCol; i++)
                    {
                        string st = "";
                        st = dTtxt.Rows[1][i].ToString();
                        if (i == 1)
                        {
                            s = s + st;
                        }
                        else
                        {
                            s = s + " " + st;
                        }
                    }
                    dTtxt.Rows[1][1] = s;
                    s = "";
                    /////////////////////////////////// remove unwanted cols
                    for (int i = 2; i < iCol; i++)
                    {
                        s = "F" + (i);
                        dTtxt.Columns.Remove(s);
                    }

                }
                //////////////////////// End

                string Cid = HttpContext.Current.Session["companyid"].ToString();

                //newColumn = new DataColumn("CompanyID", typeof(System.Int16));
                //newColumn.DefaultValue = Cid;
                //dTtxt.Columns.Add(newColumn);

                //newColumn = new DataColumn("Uploaded_DT", typeof(System.String));
                //newColumn.DefaultValue = DateTime.Now.ToString();
                //dTtxt.Columns.Add(newColumn);

                //newColumn = new DataColumn("RecType", typeof(System.String));
                //newColumn.DefaultValue = "";
                //dTtxt.Columns.Add(newColumn);


                DataTable dtChln = new DataTable();
                DataTable dtDed = new DataTable();
                string rec, ff = "";
                string Qua = "";
                string QHash = "";

                /////////////////////// Creating Cols in Datatable for challan 

                for (int i = 1; i < 29; i++)
                {
                    rec = "C" + i;
                    newColumn = new DataColumn(rec, typeof(System.String));
                    newColumn.DefaultValue = "";
                    dtChln.Columns.Add(newColumn);
                }
                rec = "";

                /////////////////////// Creating Cols in Datatable for deductee 
                for (int i = 1; i < 40; i++)
                {
                    rec = "D" + i;
                    newColumn = new DataColumn(rec, typeof(System.String));
                    newColumn.DefaultValue = "";
                    dtDed.Columns.Add(newColumn);
                }
                rec = "";
                string strBH = "";
                /////////////////////// Splitting records 
                foreach (DataRow row in dTtxt.AsEnumerable())
                {
                    string[] splitData = row.Field<string>(1).Split(new char[] { '^' });
                    //row[4] = splitData[1];

                    rec = splitData[1].ToString();
                    if (rec == "FH")
                    {
                        QHash = splitData[14].ToString();
                    }
                    if (rec == "BH")
                    {
                        strBH = row.Field<string>(1);
                        ff = splitData[4].ToString();
                        Qua = splitData[17].ToString();

                    }
                    if (rec == "CD")
                    {
                        DataRow dr = dtChln.NewRow();
                        dr[0] = splitData[0].ToString(); // dbo.SplitIndex('^', @Sq, 1)
                        dr[1] = splitData[1].ToString(); //  dbo.SplitIndex('^', @Sq, 2)
                        dr[2] = splitData[3].ToString(); // dbo.SplitIndex('^', @Sq, 4)
                        dr[3] = splitData[4].ToString(); // dbo.SplitIndex('^', @Sq, 5)
                        dr[4] = splitData[5].ToString();//  dbo.SplitIndex('^', @Sq, 6)
                        dr[5] = splitData[8].ToString(); //  dbo.SplitIndex('^', @Sq, 9)
                        dr[6] = splitData[11].ToString(); //  dbo.SplitIndex('^', @Sq, 12)
                        dr[7] = splitData[15].ToString(); //  dbo.SplitIndex('^', @Sq, 16)
                        dr[8] = splitData[17].ToString(); //  dbo.SplitIndex('^', @Sq, 18)
                        dr[9] = splitData[20].ToString(); //  dbo.SplitIndex('^', @Sq, 21)
                        dr[10] = splitData[21].ToString();//  dbo.SplitIndex('^', @Sq, 22)
                        dr[11] = splitData[22].ToString();//  dbo.SplitIndex('^', @Sq, 23)
                        dr[12] = splitData[23].ToString();//  dbo.SplitIndex('^', @Sq, 24)
                        dr[13] = splitData[24].ToString();//  dbo.SplitIndex('^', @Sq, 25)
                        dr[14] = splitData[25].ToString();//  dbo.SplitIndex('^', @Sq, 26)
                        dr[15] = splitData[26].ToString();//  dbo.SplitIndex('^', @Sq, 27)
                        dr[16] = splitData[28].ToString();//  dbo.SplitIndex('^', @Sq, 29)
                        dr[17] = splitData[29].ToString();//  dbo.SplitIndex('^', @Sq, 30)
                        dr[18] = splitData[30].ToString();//  dbo.SplitIndex('^', @Sq, 31)
                        dr[19] = splitData[31].ToString();//  dbo.SplitIndex('^', @Sq, 32)
                        dr[20] = splitData[32].ToString();//  dbo.SplitIndex('^', @Sq, 33)
                        dr[21] = splitData[33].ToString();//  dbo.SplitIndex('^', @Sq, 34)
                        dr[22] = splitData[34].ToString();//  dbo.SplitIndex('^', @Sq, 35)
                        dr[23] = splitData[35].ToString();//  dbo.SplitIndex('^', @Sq, 36)
                        dr[24] = splitData[36].ToString();//  dbo.SplitIndex('^', @Sq, 37)
                        dr[25] = 0;//splitData[37].ToString();//  dbo.SplitIndex('^', @Sq, 38)
                        dr[26] = 0;// splitData[39].ToString();//  dbo.SplitIndex('^', @Sq, 40)
                        dr[27] = 0;//splitData[40].ToString();//  dbo.SplitIndex('^', @Sq, 41)
                        dtChln.Rows.Add(dr);
                    }
                    else if (rec == "DD")
                    {
                        DataRow ddr = dtDed.NewRow();
                        if (ff == "26Q")
                        {
                            ddr[0] = splitData[0].ToString(); // dbo.SplitIndex('^', @Sq, 1)
                            ddr[1] = splitData[1].ToString(); // dbo.SplitIndex('^', @Sq, 2)
                            ddr[2] = splitData[2].ToString(); // dbo.SplitIndex('^', @Sq, 3)
                            ddr[3] = splitData[3].ToString(); // dbo.SplitIndex('^', @Sq, 4)
                            ddr[4] = splitData[4].ToString(); // dbo.SplitIndex('^', @Sq, 5)
                            ddr[5] = splitData[5].ToString(); // dbo.SplitIndex('^', @Sq, 6)

                            ddr[6] = 0;
                            ddr[7] = splitData[7].ToString(); //isnull(dbo.SplitIndex('^', @Sq, 8),'.')
                            ddr[8] = splitData[9].ToString(); // dbo.SplitIndex('^', @Sq, 10)
                            ddr[9] = splitData[11].ToString(); // dbo.SplitIndex('^', @Sq, 12)
                            ddr[10] = splitData[12].ToString(); // dbo.SplitIndex('^', @Sq, 13)
                            ddr[11] = splitData[13].ToString(); // dbo.SplitIndex('^', @Sq, 14)


                            ddr[12] = splitData[14].ToString(); // dbo.SplitIndex('^', @Sq, 15)
                            ddr[13] = splitData[15].ToString(); // dbo.SplitIndex('^', @Sq, 16)
                            ddr[14] = splitData[16].ToString(); // dbo.SplitIndex('^', @Sq, 17)
                            ddr[15] = splitData[18].ToString(); // dbo.SplitIndex('^', @Sq, 19)
                            ddr[16] = 0;
                            ddr[17] = splitData[21].ToString(); // dbo.SplitIndex('^', @Sq, 22)


                            ddr[18] = splitData[22].ToString(); // dbo.SplitIndex('^', @Sq, 23)
                            ddr[19] = splitData[23].ToString(); // dbo.SplitIndex('^', @Sq, 24)
                            ddr[20] = splitData[24].ToString(); // dbo.SplitIndex('^', @Sq, 25)
                            ddr[21] = splitData[25].ToString(); // dbo.SplitIndex('^', @Sq, 26)
                            ddr[22] = splitData[26].ToString(); // dbo.SplitIndex('^', @Sq, 27)
                            ddr[23] = splitData[27].ToString(); // dbo.SplitIndex('^', @Sq, 28)
                            ddr[24] = splitData[29].ToString(); // dbo.SplitIndex('^', @Sq, 30)


                            ddr[25] = splitData[30].ToString(); // dbo.SplitIndex('^', @Sq, 31)
                            ddr[26] = splitData[31].ToString(); // dbo.SplitIndex('^', @Sq, 32)
                            ddr[27] = splitData[33].ToString(); // dbo.SplitIndex('^', @Sq, 34)  TDS Section
                            ddr[28] = splitData[34].ToString(); // dbo.SplitIndex('^', @Sq, 35)  Certi

                            ////////////////////// Checking Nri Records
                            string str = "";
                            str = splitData[35].ToString();
                            if (str == "")
                            {
                                ddr[29] = 0;
                            }
                            else
                            {
                                ddr[29] = splitData[35].ToString(); // dbo.SplitIndex('^', @Sq, 31)  NRICode
                            }
                            str = splitData[36].ToString();
                            if (str == "")
                            {
                                ddr[30] = 0;
                            }
                            else
                            {
                                ddr[30] = splitData[36].ToString(); // dbo.SplitIndex('^', @Sq, 32)  RemittanceCode
                            }
                            str = splitData[37].ToString();
                            if (str == "")
                            {
                                ddr[31] = 0;
                            }
                            else
                            {
                                ddr[31] = splitData[37].ToString(); // dbo.SplitIndex('^', @Sq, 34)  Nri_TaxIdentification
                            }

                            str =splitData[38].ToString();
                            if (str == "")
                            {
                                ddr[32] = 0;
                            }
                            else
                            {
                                ddr[32] = splitData[38].ToString(); // dbo.SplitIndex('^', @Sq, 35)  CountryCode
                            }
                            ddr[33] = 0;
                            ddr[34] = 0;
                            ddr[35] = 0;
                            ddr[36] = 0;
                            ddr[37] = 0;
                            ddr[38] = Cid;

                            dtDed.Rows.Add(ddr);
                        }
                        else
                        {
                            ddr[0] = splitData[0].ToString(); // dbo.SplitIndex('^', @Sq, 1)
                            ddr[1] = splitData[1].ToString(); // dbo.SplitIndex('^', @Sq, 2)
                            ddr[2] = splitData[2].ToString(); // dbo.SplitIndex('^', @Sq, 3)
                            ddr[3] = splitData[3].ToString(); // dbo.SplitIndex('^', @Sq, 4)
                            ddr[4] = splitData[4].ToString(); // dbo.SplitIndex('^', @Sq, 5)
                            ddr[5] = splitData[5].ToString(); // dbo.SplitIndex('^', @Sq, 6)
                            ddr[6] = splitData[6].ToString();

                            ddr[7] = ""; //isnull(dbo.SplitIndex('^', @Sq, 8),'.')
                            ddr[8] = splitData[9].ToString(); // dbo.SplitIndex('^', @Sq, 10)
                            ddr[9] = ""; // dbo.SplitIndex('^', @Sq, 12)
                            ddr[10] = splitData[12].ToString(); // dbo.SplitIndex('^', @Sq, 13)
                            ddr[11] = splitData[13].ToString(); // dbo.SplitIndex('^', @Sq, 14)


                            ddr[12] = splitData[14].ToString(); // dbo.SplitIndex('^', @Sq, 15)
                            ddr[13] = splitData[15].ToString(); // dbo.SplitIndex('^', @Sq, 16)
                            ddr[14] = splitData[16].ToString(); // dbo.SplitIndex('^', @Sq, 17)
                            ddr[15] = splitData[18].ToString(); // dbo.SplitIndex('^', @Sq, 19)
                            ddr[16] = 0;
                            ddr[17] = splitData[21].ToString(); // dbo.SplitIndex('^', @Sq, 22)


                            ddr[18] = splitData[22].ToString(); // dbo.SplitIndex('^', @Sq, 23)
                            ddr[19] = splitData[23].ToString(); // dbo.SplitIndex('^', @Sq, 24)
                            ddr[20] = splitData[24].ToString(); // dbo.SplitIndex('^', @Sq, 25)
                            ddr[21] = 0; // dbo.SplitIndex('^', @Sq, 26)
                            ddr[22] = ""; // dbo.SplitIndex('^', @Sq, 27)
                            ddr[23] = ""; // dbo.SplitIndex('^', @Sq, 28)
                            ddr[24] = ""; // dbo.SplitIndex('^', @Sq, 30)


                            ddr[25] = splitData[30].ToString(); // dbo.SplitIndex('^', @Sq, 31)
                            ddr[26] = splitData[31].ToString(); // dbo.SplitIndex('^', @Sq, 32)
                            ddr[27] = splitData[33].ToString();//splitData[33].ToString(); // dbo.SplitIndex('^', @Sq, 34)  TDS Section
                            ddr[28] = ""; // dbo.SplitIndex('^', @Sq, 35)  Certi

                            ddr[29] = 0;
                            ddr[30] = 0;
                            ddr[31] = 0;
                            ddr[32] = 0;
                            ddr[33] = 0;
                            ddr[34] = 0;
                            ddr[35] = 0;
                            ddr[36] = 0;
                            ddr[37] = 0;
                            ddr[38] = Cid;

                            dtDed.Rows.Add(ddr);

                        }
                    }
                }
                ////////////////////////////////// Inserting Batch header & correction details
                SqlParameter[] param = new SqlParameter[6];
                //param = new SqlParameter[1];
                param[0] = new SqlParameter("@Company_ID", HttpContext.Current.Session["companyid"]);
                param[1] = new SqlParameter("@Formno", ff);
                param[2] = new SqlParameter("@Quater", Qua);
                param[3] = new SqlParameter("@BH", strBH);
                param[4] = new SqlParameter("@Conso", fileName);
                param[5] = new SqlParameter("@QHash", QHash);
                ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_Correction_Import", param);
                int Conso_id = 0;
                Conso_id = Convert.ToInt16(ds.Tables[0].Rows[0][0].ToString());
                if (Conso_id == -2)
                {

                }
                newColumn = new DataColumn("CompanyID", typeof(System.Int16));
                newColumn.DefaultValue = Cid;
                dtChln.Columns.Add(newColumn);

                newColumn = new DataColumn("Company_ID", typeof(System.Int16));
                newColumn.DefaultValue = Cid;

                dtDed.Columns.Add(newColumn);

                newColumn = new DataColumn("Conso_id", typeof(System.Int16));
                newColumn.DefaultValue = Conso_id;
                dtChln.Columns.Add(newColumn);

                newColumn = new DataColumn("Consoid", typeof(System.Int16));
                newColumn.DefaultValue = Conso_id;
                dtDed.Columns.Add(newColumn);
                ////////////////////////////// Bulk Copy Challan & deductee records from datatable to SQL
                using (SqlConnection con = new SqlConnection(_cnnString))
                {
                    using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(con))
                    {
                        sqlBulkCopy.BulkCopyTimeout = 0;

                        ////Set the database table name
                        sqlBulkCopy.DestinationTableName = "dbo.tbl_Correction_Challan";
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[0].ToString(), "Line_No");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[1].ToString(), "Record_Type");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[2].ToString(), "CDRecNo");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[3].ToString(), "CountDed");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[4].ToString(), "NIL_Challan");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[5].ToString(), "Challan_Matched");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[6].ToString(), "Bank_Challan_no");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[7].ToString(), "Bank_BSRCode");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[8].ToString(), "Challan_Date");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[9].ToString(), "Section");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[10].ToString(), "TDS");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[11].ToString(), "Surcharge");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[12].ToString(), "Cess");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[13].ToString(), "Interest");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[14].ToString(), "Others");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[15].ToString(), "Total_Deposit_Amt");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[16].ToString(), "Total_Deductee_Deposit");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[17].ToString(), "Dedutee_Tds");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[18].ToString(), "Deductee_Surcharge");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[19].ToString(), "Deductee_Cess");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[20].ToString(), "Total_deductee_TDS_Amt");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[21].ToString(), "Deductee_Interest");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[22].ToString(), "Deductee_Others");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[23].ToString(), "Cheque_No");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[24].ToString(), "BookCash");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[25].ToString(), "Pending_Amt");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[26].ToString(), "Late_fee");
                        sqlBulkCopy.ColumnMappings.Add(dtChln.Columns[27].ToString(), "MinorHead");
                        sqlBulkCopy.ColumnMappings.Add("CompanyID", "Company_id");
                        sqlBulkCopy.ColumnMappings.Add("Conso_id", "Correction_id");
                        con.Open();
                        sqlBulkCopy.WriteToServer(dtChln);
                        con.Close();
                    }
                    using (SqlBulkCopy sqlBCopy = new SqlBulkCopy(con))
                    {
                        sqlBCopy.BulkCopyTimeout = 0;

                        sqlBCopy.DestinationTableName = "dbo.tbl_Correction_Deductee";
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[0].ToString(), "Line_No");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[1].ToString(), "Record_Type");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[2].ToString(), "BatchNo");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[3].ToString(), "CDRecNo");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[4].ToString(), "DDRecNo");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[5].ToString(), "RMode");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[6].ToString(), "EmpSerNo");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[7].ToString(), "Deductee_Code");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[8].ToString(), "PAN");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[9].ToString(), "PANRef");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[10].ToString(), "DeducteeName");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[11].ToString(), "Tds");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[12].ToString(), "Surcharge");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[13].ToString(), "Cess");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[14].ToString(), "Tds_Deducted");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[15].ToString(), "Total_Tds_Deposited");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[16].ToString(), "Purchase_Value");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[17].ToString(), "Voucher_Amt");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[18].ToString(), "PaidDate");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[19].ToString(), "DeductionDate");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[20].ToString(), "ChallanDate");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[21].ToString(), "TDS_Rate");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[22].ToString(), "GIndicator");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[23].ToString(), "BookCash");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[24].ToString(), "Reason");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[25].ToString(), "PANFlag");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[26].ToString(), "PANCounter");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[27].ToString(), "Tds_Section");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[28].ToString(), "TDSCert_No");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[29].ToString(), "NRICode");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[30].ToString(), "RemittanceCode");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[31].ToString(), "Nri_TaxIdentification");
                        sqlBCopy.ColumnMappings.Add(dtDed.Columns[32].ToString(), "CountryCode");
                        sqlBCopy.ColumnMappings.Add("Company_ID", "Company_id");
                        sqlBCopy.ColumnMappings.Add("Consoid", "Correction_id");
                        con.Open();
                        sqlBCopy.WriteToServer(dtDed);
                        con.Close();

                    }
                }
                ////SqlParameter[] param = new SqlParameter[2];
                ////param = new SqlParameter[2];
                ////param[0] = new SqlParameter("@companyId", HttpContext.Current.Session["companyid"]);
                ////param[1] = new SqlParameter("@indication", 1);
                ////ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "Usp_27Q_ExcelValidation", param);



                context.Response.StatusCode = (int)HttpStatusCode.OK;
                context.Response.ContentType = "text/json";
                context.Response.Write(JsonConvert.SerializeObject(ds));
                context.Response.End();
            }
        }
        catch (Exception ex)
        {
            //throw new Exception(ex.Message);
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}