using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLayer;
using System.Data;
using System.IO;
using System.Net;
using Ionic.Zip;
using Microsoft.Office.Interop.Excel;
using System.Windows.Forms;
using System.Text.RegularExpressions;
using System.Threading;
using System.Collections;
using System.Text;
using System.Security.Cryptography;
using CommonLibrary;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;
using DataLayer;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using DataTable = System.Data.DataTable;

public partial class Dashboard_TDS_Salary : System.Web.UI.Page
{
    BAL_ManageSalary_ChallanList obj = new BAL_ManageSalary_ChallanList();
    EnumerateOpenedWindows closeMessageWindow = new EnumerateOpenedWindows();
    string path, SuccessFilePath, ErrorFilePath, ZipFilePath;
    CommonFunctions ErrorException = new CommonFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {           
        hdnCompanyid.Value = Session["companyid"].ToString();
        string Q = Session["Qtr"].ToString();
        string F = Session["frm"].ToString();
        hdnForm.Value = F;
        hdnQuarter.Value = Q;

        if (!Page.IsPostBack)
        {
            if (Session["companyid"] != null)
            {
                hdntblChln.Value = "0";
                Session["CSI"] = "";
                Session["CSIFilename"] = "";
                Session["Sal"] = "";
                Session["Non"] = "";

                if (Session["Financial_Year_Text"] != null)
                {

                    string[] fy = Session["Financial_Year_Text"].ToString().Split('_');
                    hdnfinancialyear.Value = fy[0] + fy[1];

                    Q = Session["Qtr"].ToString();
                    if (Q == "")
                    {
                        DateTime baseDate = DateTime.Today;
                        var thisWeekStart = baseDate;


                        int mm = Convert.ToInt16(thisWeekStart.ToString("MM"));
                        if (mm >= 4 && mm <= 6)
                        {
                            hdnQuarter.Value = "Q1";
                        }
                        else if (mm >= 7 && mm <= 9)
                        {
                            hdnQuarter.Value = "Q2";
                        }
                        else if (mm >= 10 && mm <= 12)
                        {
                            hdnQuarter.Value = "Q3";
                        }
                        else if (mm >= 1 && mm <= 3)
                        {
                            hdnQuarter.Value = "Q4";
                        }

                        hdnForm.Value = "26Q";
                    }

                }

            }
            else
            {
                Response.Redirect("~/login.aspx");
            }
        }


    }    


    protected void btnGenerateTextFile_Click(object sender, EventArgs e)
    {
        ////HID_IMG_TXT1.Value = "";

        //string CSIName = "";
        //string CsiErr = "";
        

        //CSIName = Session["CSI"].ToString();
        //if (Session["CSI"].ToString() == "")
        //{
        //    CsiErr = "Err";
        //    if (FileUploadCSI.FileName == "")
        //    {
        //        CsiErr = "Err";
        //    }
        //    else
        //    {
        //        CsiErr = "1";
        //    }
        //}
        //else
        //{
        //    CsiErr = Session["CSI"].ToString();

        //}
        //// divUploadingCSI.Style.Value = "display:block";
        ////ScriptManager.RegisterStartupScript(this, this.GetType(), "alertEmployee", "Csistatus();", true);

        //string TanNo = hdntanno.Value;

        ////objBAL_EReturns_NonSalary.Company_ID = int.Parse(Session["companyid"].ToString());


        //string eReturnspath = Server.MapPath("~/eReturns/Regular");
        //if (!Directory.Exists(eReturnspath))
        //{
        //    Directory.CreateDirectory(eReturnspath);
        //}
        //string tannoPath = (eReturnspath + "\\" + TanNo + "\\" + hdnfinancialyear.Value);

        //string fromtypepath = tannoPath ;
        //if (!Directory.Exists(fromtypepath))
        //{
        //    Directory.CreateDirectory(fromtypepath);
        //}
        //string QuaterPath = (fromtypepath);
        //string CsiPath = "";
        ////DownloadCSIFile(TanNo, FromDate, DateTime.Now, QuaterPath);


        //if (FileUploadCSI.FileName != "")
        //{

        //    FileUploadCSI.SaveAs(QuaterPath + "\\" + Path.GetFileName(FileUploadCSI.FileName));
        //    CSIName = FileUploadCSI.FileName;
        //    CsiPath = QuaterPath + "\\" + CSIName;
        //    Session["CSIFilename"] = CSIName;
        //}
        //else
        //{
        //    if (Session["CSI"].ToString() != "")
        //    {
        //        File.WriteAllBytes(QuaterPath + "\\" + Session["CSIFilename"].ToString(), Convert.FromBase64String(Session["CSI"].ToString()));
        //        CSIName = Session["CSIFilename"].ToString();
        //        CsiPath = QuaterPath + "\\" + CSIName;
        //    }

        //}
        //CSIName = Session["CSIFilename"].ToString();
        //string Csi = QuaterPath + "\\" + CSIName;
        //if (CSIName == "")
        //{
        //    CsiErr = "Err";
        //}
        //CsiErr = checkCSI(Csi);



        //if (CsiErr == "Err")
        //{
        //    return;
        //}

        //    obj.Quarter = hdnQuarter.Value;
        //obj.FromType = hdnForm.Value;
        //obj.CompanyID = Convert.ToInt32(Session["companyid"]);

        //DataSet ds;
        //if (hdnForm.Value == "24Q")
        //{
        //    hdntblChln.Value = "2";
        //    ds = obj.Get_Challan_Salary();
        //}
        //else
        //{
        //    hdntblChln.Value = "1";
        //    ds = obj.Get_Challan_Non_Salary();
        //}
        //string chlsts = "";
        //if (ds.Tables[0].Rows.Count > 0)
        //{
        //    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        //    {
        //        string chid = ds.Tables[0].Rows[i]["Challan_ID"].ToString();
        //        string date1 = ds.Tables[0].Rows[i]["Challan_Date"].ToString();
        //        string bsr = ds.Tables[0].Rows[i]["Bank_Bsrcode"].ToString();
        //        int chlno = Convert.ToInt32(ds.Tables[0].Rows[i]["Challan_No"].ToString());
        //        string Amt = ds.Tables[0].Rows[i]["Challan_Amount"].ToString() + ".00";
        //        string Ctype = ds.Tables[0].Rows[i]["Ctype"].ToString();
        //        string str = "1qi5b63p", str1 = "9rtio7lb", str3 = "";
        //         Csi = QuaterPath + "\\" + Session["CSIFilename"].ToString();

        //        str3 = str + bsr + date1 + chlno + TanNo + Amt + str1;
        //        //str3 = "1qi5b63p05103080705202191488MUMA09455F279715.009rtio7lb";
        //        string result = GetCSIResult(str3, Csi);

        //        chlsts = chlsts + chid + "," + result + "," + Ctype + "^";
        //        //IEnumerable<objChallanDetails> tbl = obj.BAL_Dashboard_Challan(chlno, date1, bsr, Amt, result);
        //        //hdntblChln.Value = new JavaScriptSerializer().Serialize(tbl);
        //    }
        //    obj.CompanyID = Convert.ToInt32(Session["companyid"]);
        //    obj.Result = chlsts;
        //    DataSet dset = obj.BAL_Challan_Verify();
        //    //ScriptManager.RegisterStartupScript(this, this.GetType(), "alertEmployee", "ChallanTable();", true);
        //    //ucMessageControl.SetMessage("Challan Verification Complete", MessageDisplay.DisplayStyles.Success);
        //}
    }

    //public string GetCSIResult(string str3, string Csi)
    //{
    //    hdnCSi.Value = "";
    //   string result = "UnMatched";
    //    try
    //    {
    //        string MD = MD5Hash(str3);

    //        var fileStream = new FileStream(Csi, FileMode.Open, FileAccess.Read);
    //        using (var streamReader = new StreamReader(fileStream, Encoding.UTF8))
    //        {
    //            string line;
    //            while ((line = streamReader.ReadLine()) != null)
    //            {
    //                if (MD == line)
    //                {
    //                    result = "Matched";
    //                    break;
    //                }
    //            }
    //        }
    //    }
    //    catch
    //    {
    //        hdnCSi.Value = "Manual";
    //    }
    //    return result;
    //}

    //public string checkCSI(string CSI)
    //{
    //    string CsiErr = "";
    //    try
    //    {
    //        var fileStream = new FileStream(CSI, FileMode.Open, FileAccess.Read);
    //        using (var streamReader = new StreamReader(fileStream, Encoding.UTF8))
    //        {
    //            string line;
    //            while ((line = streamReader.ReadLine()) != null)
    //            {
    //                if (line == "<HTML>")
    //                {
    //                    CsiErr = "Err";
    //                    ucMessageControl.SetMessage("Download CSI file Mannualy or try again after some time.", MessageDisplay.DisplayStyles.Error);
    //                    break;
    //                }
    //                else
    //                {
    //                    CsiErr = "";
    //                    break;
    //                }
    //            }
    //        }
    //    }
    //    catch
    //    { }
    //    return CsiErr;
    //}

    ////Converting String into MD5 File
    //public static string MD5Hash(string input)
    //{
    //    StringBuilder hash = new StringBuilder();
    //    MD5CryptoServiceProvider md5provider = new MD5CryptoServiceProvider();
    //    byte[] bytes = md5provider.ComputeHash(new UTF8Encoding().GetBytes(input));

    //    for (int i = 0; i < bytes.Length; i++)
    //    {
    //        hash.Append(bytes[i].ToString("x2"));
    //    }
    //    return hash.ToString();
    //}



    protected void btnRtn_Click(object sender, EventArgs e)
    {
        string F = hdnForm.Value;
        string Q = hdnQuarter.Value;
        if (F =="24Q")
        {
            Session["Sal"] = "24Q," + Q;
            Response.Redirect("EReturns_Salary.aspx");
        }
        else
        {
            Session["Non"] = F + "," + Q;
            Response.Redirect("EReturns_NonSalary.aspx");
        }
    }



    protected void btnBackup_Click(object sender, EventArgs e)
    {
        DALCommon obj = new DALCommon();
        CommonFunctions Comm = new CommonFunctions();
        CommonLibrary.CommonFunctions objComm = new CommonLibrary.CommonFunctions();
        DataTable reportDataTable = new DataTable();
        //BAL_Challan obj_BAL_Challan = new BAL_Challan();

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
            //DataSet ds = obj_BAL_Challan.GetExcelBackupData(Convert.ToInt32(Session["companyid"].ToString()), startDate, endDate, Convert.ToString(Session["form"].ToString()));



            int Compid = Convert.ToInt32(Session["companyid"].ToString());
            string formType = hdnForm.Value;
            string Qtr = hdnQuarter.Value;

            SqlParameter[] objSqlParameter = new SqlParameter[3];
            objSqlParameter[0] = new SqlParameter("@companyId", Compid);
            objSqlParameter[1] = new SqlParameter("@formType", formType);
            objSqlParameter[2] = new SqlParameter("@Qtr", Qtr);

            DataSet ds = SqlHelper.ExecuteDataset(obj._cnnString2, "usp_Bootstrap_BackupforVoucherChallance_Qtr", objSqlParameter);

            if (ds.Tables[1].Rows.Count > 0 || ds.Tables[0].Rows.Count > 0)
            {
                // obj_BAL_Challan.LogBackupEntryLog(Convert.ToInt32(Session["companyid"].ToString()), Convert.ToString(Session["form"].ToString()));

                SqlParameter[] LogSqlParameter = new SqlParameter[2];


                LogSqlParameter[0] = new SqlParameter("@companyId", Compid);
                LogSqlParameter[1] = new SqlParameter("@formType", formType);

                //DataSet dsLg = SqlHelper.ExecuteDataset(obj._cnnString2, "BTS_CreateBackupEntryLog", LogSqlParameter);
                resonseType.filePath = DumpChallanVoucherExcel(ds, true, Context);
                resonseType.isPass = true;
            }
            else
            {
                resonseType.filePath = "No records to export";               
            }


        }
        catch (Exception ex)
        {


        }
    }

    private string DumpChallanVoucherExcel(DataSet ds, bool isBackup, HttpContext context)
    {
        string TanNo = hdntanno.Value;
        Random rn = new Random();
        string fName = "";
        string folderPath = HttpContext.Current.Server.MapPath("~/XLBackup/");
        string templatefile = string.Empty;
        templatefile = HttpContext.Current.Server.MapPath("~/Templates/") + hdnForm.Value + "_Blank_XLSheet.xlsx";
        string exportFile = string.Empty;
        exportFile = folderPath + rn.Next().ToString() + "2324_BlankTemplate.xlsx";
        if (isBackup)
        {
            templatefile = HttpContext.Current.Server.MapPath("~/Templates/") + hdnForm.Value + "_Blank_XLSheet.xlsx";
            exportFile = folderPath + Convert.ToString(TanNo + "_" + hdnForm.Value + "_" + DateTime.Now.ToString("dd-MMM-yyyy").Replace("-", "_") + ".xlsx");
            fName = Convert.ToString(TanNo + "_" + hdnForm.Value + "_" + DateTime.Now.ToString("dd-MMM-yyyy").Replace("-", "_") + ".xlsx");
        }

        FileInfo file = new FileInfo(exportFile);
        try
        {


            File.Copy(templatefile, exportFile, true);
            using (ExcelPackage pck = new ExcelPackage(file))
            {
                ExcelWorkbook excelWorkBook = pck.Workbook;
                ExcelWorksheet excelWorksheet = excelWorkBook.Worksheets[1];

                if (ds.Tables[0].Rows.Count > 0)
                {

                    excelWorksheet.Cells["A3"].LoadFromDataTable(ds.Tables[0], false);
                    excelWorksheet.Cells.AutoFitColumns();
                }
                ExcelWorksheet excelWorksheet2 = excelWorkBook.Worksheets[2];
                if (ds.Tables[1].Rows.Count > 0)
                {
                    excelWorksheet2.Cells["A3"].LoadFromDataTable(ds.Tables[1], false);
                    excelWorksheet2.Cells.AutoFitColumns();
                }

                using (var memoryStream = new MemoryStream())
                {
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("content-disposition", "attachment;  filename=" + fName);
                    pck.SaveAs(memoryStream);
                    memoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();

                }
                //pck.Save();
            }
        }
        catch (Exception ex)
        {

        }
        finally
        {


        }
        return exportFile;
    }
}
