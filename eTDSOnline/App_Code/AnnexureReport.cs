using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

/// <summary>
/// Summary description for AnnexureReport
/// </summary>
public class AnnexureReport : DevExpress.XtraReports.UI.XtraReport
{
    private DevExpress.DataAccess.Sql.SqlDataSource sqlDataSource1;
    private XRControlStyle Title;
    private XRControlStyle DetailCaption1;
    private XRControlStyle DetailData1;
    private XRControlStyle DetailData3_Odd;
    private XRControlStyle PageInfo;
    private TopMarginBand TopMargin;
    private BottomMarginBand BottomMargin;
    private XRPageInfo pageInfo1;
    private XRPageInfo pageInfo2;
    private ReportHeaderBand ReportHeader;
    private GroupHeaderBand GroupHeader1;
    private XRTable table1;
    private XRTableRow tableRow1;
    private XRTableCell tableCell1;
    private XRTableCell tableCell2;
    private XRTableCell tableCell3;
    private XRTableCell tableCell4;
    private XRTableCell tableCell5;
    private XRTableCell tableCell6;
    private XRTableCell tableCell7;
    private XRTableCell tableCell8;
    private XRTableCell tableCell9;
    private XRTableCell tableCell10;
    private XRTableCell tableCell11;
    private XRTableCell xrTableCell1;
    private XRTableCell tableCell12;
    private XRTableCell tableCell13;
    private XRTableCell tableCell14;
    private DetailBand Detail;
    private XRTable table2;
    private XRTableRow tableRow2;
    private XRTableCell tableCell15;
    private XRTableCell tableCell16;
    private XRTableCell tableCell17;
    private XRTableCell tableCell18;
    private XRTableCell tableCell19;
    private XRTableCell tableCell20;
    private XRTableCell tableCell21;
    private XRTableCell tableCell22;
    private XRTableCell tableCell23;
    private XRTableCell tableCell24;
    private XRTableCell xrTableCell2;
    private XRTableCell tableCell25;
    private XRTableCell tableCell26;
    private XRTableCell tableCell27;
    private XRTableCell tableCell28;
    private ReportFooterBand ReportFooter;
    private XRLabel xrLabel10;
    private XRLabel xrLabel9;
    private XRLabel xrLabel8;
    private XRLabel xrLabel7;
    private XRLabel xrLabel6;
    private XRLabel xrLabel5;
    private XRLabel xrLabel4;
    private XRLabel xrLabel3;
    private XRLabel xrLabel2;
    private XRLabel xrLabel1;
    private XRTableRow xrTableRow1;
    private XRTableCell xrTableCell3;
    private XRTableCell xrTableCell4;
    private XRTableCell xrTableCell5;
    private XRTableCell xrTableCell6;
    private XRTableCell xrTableCell7;
    private XRTableCell xrTableCell8;
    private XRTableCell xrTableCell9;
    private XRTableCell xrTableCell10;
    private XRTableCell xrTableCell11;
    private XRTableCell xrTableCell12;
    private XRTableCell xrTableCell13;
    private XRTableCell xrTableCell14;
    private XRTableCell xrTableCell15;
    private XRTableCell xrTableCell16;
    private XRTableCell xrTableCell17;
    private XRLabel xrLabel20;
    private XRLabel xrLabel19;
    private XRLabel xrLabel18;
    private XRLabel xrLabel17;
    private XRLabel xrLabel15;
    private XRLabel xrLabel14;
    private XRLabel xrLabel13;
    private DevExpress.XtraReports.Parameters.Parameter Challan_Date;
    private DevExpress.XtraReports.Parameters.Parameter Challan_No;
    private DevExpress.XtraReports.Parameters.Parameter Interest_Amt;
    private DevExpress.XtraReports.Parameters.Parameter TANNo;
    private XRLabel xrLabel31;
    private XRLabel xrLabel30;
    private XRLabel xrLabel29;
    private XRLabel xrLabel28;
    private XRLabel xrLabel27;
    private XRLabel xrLabel26;
    private XRLabel xrLabel25;
    private XRLabel xrLabel24;
    private XRLabel xrLabel23;
    private XRLabel xrLabel22;
    private DevExpress.XtraReports.Parameters.Parameter Form_Type;
    private XRLabel xrLabel11;
    private XRLabel xrLabel33;
    private DevExpress.XtraReports.Parameters.Parameter R_Designation;
    private XRLabel xrLabel34;
    private DevExpress.XtraReports.Parameters.Parameter ddate;
    private XRLabel xrLabel35;
    private DevExpress.XtraReports.Parameters.Parameter place;
    private XRLabel xrLabel36;
    private DevExpress.XtraReports.Parameters.Parameter R_Name;
    private XRLabel xrLabel37;
    private XRLabel xrLabel16;
    private DevExpress.XtraReports.Parameters.Parameter Bank_Bsrcode;
    private GroupFooterBand GroupFooter1;
    private XRLabel xrLabel39;
    private XRLabel xrLabel44;
    private XRLabel xrLabel43;
    private XRLabel xrLabel42;
    private XRLabel xrLabel41;
    private XRLabel xrLabel40;
    private XRLabel xrLabel38;
    private XRLine xrLine1;
    private XRLine xrLine2;
    private DevExpress.XtraReports.Parameters.Parameter Challan_Amount;
    private DevExpress.XtraReports.Parameters.Parameter qdate;
    private XRLabel xrLabel32;
    private DevExpress.XtraReports.Parameters.Parameter CompanyName;
    private DevExpress.XtraReports.Parameters.Parameter TDS_Amount;
    private XRLabel xrLabel48;
    private XRLabel xrLabel21;
    private XRLabel xrLabel45;
    private XRLabel xrLabel46;
    private DevExpress.XtraReports.Parameters.Parameter qStartdate;
    private XRLabel xrLabel49;
    private XRLabel xrLabel50;
    private XRLabel xrLabel51;
    private DevExpress.XtraReports.Parameters.Parameter totaltax;
    private DevExpress.XtraReports.Parameters.Parameter Others_Amount;
    private XRLabel xrLabel47;
    private XRLabel xrLabel12;

    /// <summary>
    /// Required designer variable.
    /// </summary>
    private System.ComponentModel.IContainer components = null;

    public AnnexureReport()
    {
        InitializeComponent();
        //
        // TODO: Add constructor logic here
        //
    }

    /// <summary> 
    /// Clean up any resources being used.
    /// </summary>
    /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
    protected override void Dispose(bool disposing)
    {
        if (disposing && (components != null))
        {
            components.Dispose();
        }
        base.Dispose(disposing);
    }

    #region Designer generated code

    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    private void InitializeComponent()
    {
            string resourceFileName = "AnnexureReport.resx";
            System.Resources.ResourceManager resources = global::Resources.AnnexureReport.ResourceManager;
            this.components = new System.ComponentModel.Container();
            DevExpress.DataAccess.ConnectionParameters.XmlFileConnectionParameters xmlFileConnectionParameters1 = new DevExpress.DataAccess.ConnectionParameters.XmlFileConnectionParameters();
            DevExpress.DataAccess.Sql.SelectQuery selectQuery1 = new DevExpress.DataAccess.Sql.SelectQuery();
            DevExpress.DataAccess.Sql.Column column1 = new DevExpress.DataAccess.Sql.Column();
            DevExpress.DataAccess.Sql.ColumnExpression columnExpression1 = new DevExpress.DataAccess.Sql.ColumnExpression();
            DevExpress.DataAccess.Sql.Table table3 = new DevExpress.DataAccess.Sql.Table();
            DevExpress.DataAccess.Sql.Column column2 = new DevExpress.DataAccess.Sql.Column();
            DevExpress.DataAccess.Sql.ColumnExpression columnExpression2 = new DevExpress.DataAccess.Sql.ColumnExpression();
            DevExpress.DataAccess.Sql.Column column3 = new DevExpress.DataAccess.Sql.Column();
            DevExpress.DataAccess.Sql.ColumnExpression columnExpression3 = new DevExpress.DataAccess.Sql.ColumnExpression();
            DevExpress.DataAccess.Sql.Column column4 = new DevExpress.DataAccess.Sql.Column();
            DevExpress.DataAccess.Sql.ColumnExpression columnExpression4 = new DevExpress.DataAccess.Sql.ColumnExpression();
            DevExpress.DataAccess.Sql.Column column5 = new DevExpress.DataAccess.Sql.Column();
            DevExpress.DataAccess.Sql.ColumnExpression columnExpression5 = new DevExpress.DataAccess.Sql.ColumnExpression();
            DevExpress.DataAccess.Sql.Column column6 = new DevExpress.DataAccess.Sql.Column();
            DevExpress.DataAccess.Sql.ColumnExpression columnExpression6 = new DevExpress.DataAccess.Sql.ColumnExpression();
            DevExpress.DataAccess.Sql.Column column7 = new DevExpress.DataAccess.Sql.Column();
            DevExpress.DataAccess.Sql.ColumnExpression columnExpression7 = new DevExpress.DataAccess.Sql.ColumnExpression();
            DevExpress.DataAccess.Sql.Column column8 = new DevExpress.DataAccess.Sql.Column();
            DevExpress.DataAccess.Sql.ColumnExpression columnExpression8 = new DevExpress.DataAccess.Sql.ColumnExpression();
            DevExpress.DataAccess.Sql.Column column9 = new DevExpress.DataAccess.Sql.Column();
            DevExpress.DataAccess.Sql.ColumnExpression columnExpression9 = new DevExpress.DataAccess.Sql.ColumnExpression();
            DevExpress.DataAccess.Sql.Column column10 = new DevExpress.DataAccess.Sql.Column();
            DevExpress.DataAccess.Sql.ColumnExpression columnExpression10 = new DevExpress.DataAccess.Sql.ColumnExpression();
            DevExpress.DataAccess.Sql.Column column11 = new DevExpress.DataAccess.Sql.Column();
            DevExpress.DataAccess.Sql.ColumnExpression columnExpression11 = new DevExpress.DataAccess.Sql.ColumnExpression();
            DevExpress.DataAccess.Sql.Column column12 = new DevExpress.DataAccess.Sql.Column();
            DevExpress.DataAccess.Sql.ColumnExpression columnExpression12 = new DevExpress.DataAccess.Sql.ColumnExpression();
            DevExpress.DataAccess.Sql.Column column13 = new DevExpress.DataAccess.Sql.Column();
            DevExpress.DataAccess.Sql.ColumnExpression columnExpression13 = new DevExpress.DataAccess.Sql.ColumnExpression();
            DevExpress.DataAccess.Sql.Column column14 = new DevExpress.DataAccess.Sql.Column();
            DevExpress.DataAccess.Sql.ColumnExpression columnExpression14 = new DevExpress.DataAccess.Sql.ColumnExpression();
            DevExpress.XtraReports.UI.XRSummary xrSummary1 = new DevExpress.XtraReports.UI.XRSummary();
            DevExpress.XtraReports.UI.XRSummary xrSummary2 = new DevExpress.XtraReports.UI.XRSummary();
            DevExpress.XtraReports.UI.XRSummary xrSummary3 = new DevExpress.XtraReports.UI.XRSummary();
            DevExpress.XtraReports.UI.XRSummary xrSummary4 = new DevExpress.XtraReports.UI.XRSummary();
            DevExpress.XtraReports.UI.XRSummary xrSummary5 = new DevExpress.XtraReports.UI.XRSummary();
            DevExpress.XtraReports.UI.XRSummary xrSummary6 = new DevExpress.XtraReports.UI.XRSummary();
            DevExpress.XtraReports.UI.XRSummary xrSummary7 = new DevExpress.XtraReports.UI.XRSummary();
            this.sqlDataSource1 = new DevExpress.DataAccess.Sql.SqlDataSource(this.components);
            this.Title = new DevExpress.XtraReports.UI.XRControlStyle();
            this.DetailCaption1 = new DevExpress.XtraReports.UI.XRControlStyle();
            this.DetailData1 = new DevExpress.XtraReports.UI.XRControlStyle();
            this.DetailData3_Odd = new DevExpress.XtraReports.UI.XRControlStyle();
            this.PageInfo = new DevExpress.XtraReports.UI.XRControlStyle();
            this.TopMargin = new DevExpress.XtraReports.UI.TopMarginBand();
            this.BottomMargin = new DevExpress.XtraReports.UI.BottomMarginBand();
            this.pageInfo1 = new DevExpress.XtraReports.UI.XRPageInfo();
            this.pageInfo2 = new DevExpress.XtraReports.UI.XRPageInfo();
            this.ReportHeader = new DevExpress.XtraReports.UI.ReportHeaderBand();
            this.xrLabel47 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel12 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel51 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel50 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel49 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel46 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel45 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel48 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel21 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel32 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel16 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel11 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel31 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel30 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel29 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel28 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel27 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel26 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel25 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel24 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel23 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel22 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel20 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel19 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel18 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel17 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel15 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel14 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel13 = new DevExpress.XtraReports.UI.XRLabel();
            this.GroupHeader1 = new DevExpress.XtraReports.UI.GroupHeaderBand();
            this.table1 = new DevExpress.XtraReports.UI.XRTable();
            this.tableRow1 = new DevExpress.XtraReports.UI.XRTableRow();
            this.tableCell1 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell2 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell3 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell4 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell5 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell6 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell7 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell8 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell9 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell10 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell11 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell1 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell12 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell13 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell14 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow1 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell3 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell4 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell5 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell6 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell7 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell8 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell9 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell10 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell11 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell12 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell13 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell14 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell15 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell16 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell17 = new DevExpress.XtraReports.UI.XRTableCell();
            this.Detail = new DevExpress.XtraReports.UI.DetailBand();
            this.table2 = new DevExpress.XtraReports.UI.XRTable();
            this.tableRow2 = new DevExpress.XtraReports.UI.XRTableRow();
            this.tableCell15 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell16 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell17 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell18 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell19 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell20 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell21 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell22 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell23 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell24 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell2 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell25 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell26 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell27 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell28 = new DevExpress.XtraReports.UI.XRTableCell();
            this.ReportFooter = new DevExpress.XtraReports.UI.ReportFooterBand();
            this.xrLabel37 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel36 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel35 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel34 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel33 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel10 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel9 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel8 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel7 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel6 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel5 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel4 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel3 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel2 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel1 = new DevExpress.XtraReports.UI.XRLabel();
            this.Challan_Date = new DevExpress.XtraReports.Parameters.Parameter();
            this.Challan_No = new DevExpress.XtraReports.Parameters.Parameter();
            this.Interest_Amt = new DevExpress.XtraReports.Parameters.Parameter();
            this.TANNo = new DevExpress.XtraReports.Parameters.Parameter();
            this.Form_Type = new DevExpress.XtraReports.Parameters.Parameter();
            this.R_Designation = new DevExpress.XtraReports.Parameters.Parameter();
            this.ddate = new DevExpress.XtraReports.Parameters.Parameter();
            this.place = new DevExpress.XtraReports.Parameters.Parameter();
            this.R_Name = new DevExpress.XtraReports.Parameters.Parameter();
            this.Bank_Bsrcode = new DevExpress.XtraReports.Parameters.Parameter();
            this.GroupFooter1 = new DevExpress.XtraReports.UI.GroupFooterBand();
            this.xrLine2 = new DevExpress.XtraReports.UI.XRLine();
            this.xrLine1 = new DevExpress.XtraReports.UI.XRLine();
            this.xrLabel44 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel43 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel42 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel41 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel40 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel38 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel39 = new DevExpress.XtraReports.UI.XRLabel();
            this.Challan_Amount = new DevExpress.XtraReports.Parameters.Parameter();
            this.qdate = new DevExpress.XtraReports.Parameters.Parameter();
            this.CompanyName = new DevExpress.XtraReports.Parameters.Parameter();
            this.TDS_Amount = new DevExpress.XtraReports.Parameters.Parameter();
            this.qStartdate = new DevExpress.XtraReports.Parameters.Parameter();
            this.totaltax = new DevExpress.XtraReports.Parameters.Parameter();
            this.Others_Amount = new DevExpress.XtraReports.Parameters.Parameter();
            ((System.ComponentModel.ISupportInitialize)(this.table1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.table2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // sqlDataSource1
            // 
            this.sqlDataSource1.ConnectionName = "Connection";
            xmlFileConnectionParameters1.FileName = "D:\\OnlineTds_Reports\\eTDSOnline\\App_Code\\DS_Annexure.xsd";
            this.sqlDataSource1.ConnectionParameters = xmlFileConnectionParameters1;
            this.sqlDataSource1.Name = "sqlDataSource1";
            columnExpression1.ColumnName = "Srno";
            table3.Name = "DT_Annexure";
            columnExpression1.Table = table3;
            column1.Expression = columnExpression1;
            columnExpression2.ColumnName = "Deductee_Type";
            columnExpression2.Table = table3;
            column2.Expression = columnExpression2;
            columnExpression3.ColumnName = "PAN_NO";
            columnExpression3.Table = table3;
            column3.Expression = columnExpression3;
            columnExpression4.ColumnName = "Deductee_Name";
            columnExpression4.Table = table3;
            column4.Expression = columnExpression4;
            columnExpression5.ColumnName = "Challan_Date";
            columnExpression5.Table = table3;
            column5.Expression = columnExpression5;
            columnExpression6.ColumnName = "Voucher_Amount";
            columnExpression6.Table = table3;
            column6.Expression = columnExpression6;
            columnExpression7.ColumnName = "paidbybook";
            columnExpression7.Table = table3;
            column7.Expression = columnExpression7;
            columnExpression8.ColumnName = "TDS_Amt";
            columnExpression8.Table = table3;
            column8.Expression = columnExpression8;
            columnExpression9.ColumnName = "Surcharge_Amt";
            columnExpression9.Table = table3;
            column9.Expression = columnExpression9;
            columnExpression10.ColumnName = "ECess_Amt";
            columnExpression10.Table = table3;
            column10.Expression = columnExpression10;
            columnExpression11.ColumnName = "TotalTaxdeposited";
            columnExpression11.Table = table3;
            column11.Expression = columnExpression11;
            columnExpression12.ColumnName = "dateofdeduction";
            columnExpression12.Table = table3;
            column12.Expression = columnExpression12;
            columnExpression13.ColumnName = "TDS_Percentage";
            columnExpression13.Table = table3;
            column13.Expression = columnExpression13;
            columnExpression14.ColumnName = "Section";
            columnExpression14.Table = table3;
            column14.Expression = columnExpression14;
            selectQuery1.Columns.Add(column1);
            selectQuery1.Columns.Add(column2);
            selectQuery1.Columns.Add(column3);
            selectQuery1.Columns.Add(column4);
            selectQuery1.Columns.Add(column5);
            selectQuery1.Columns.Add(column6);
            selectQuery1.Columns.Add(column7);
            selectQuery1.Columns.Add(column8);
            selectQuery1.Columns.Add(column9);
            selectQuery1.Columns.Add(column10);
            selectQuery1.Columns.Add(column11);
            selectQuery1.Columns.Add(column12);
            selectQuery1.Columns.Add(column13);
            selectQuery1.Columns.Add(column14);
            selectQuery1.Name = "DT_Annexure";
            selectQuery1.Tables.Add(table3);
            this.sqlDataSource1.Queries.AddRange(new DevExpress.DataAccess.Sql.SqlQuery[] {
            selectQuery1});
            this.sqlDataSource1.ResultSchemaSerializable = resources.GetString("sqlDataSource1.ResultSchemaSerializable");
            // 
            // Title
            // 
            this.Title.BackColor = System.Drawing.Color.Transparent;
            this.Title.BorderColor = System.Drawing.Color.Black;
            this.Title.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.Title.BorderWidth = 1F;
            this.Title.Font = new System.Drawing.Font("Arial", 14.25F);
            this.Title.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(70)))), ((int)(((byte)(80)))));
            this.Title.Name = "Title";
            // 
            // DetailCaption1
            // 
            this.DetailCaption1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(184)))), ((int)(((byte)(231)))), ((int)(((byte)(232)))));
            this.DetailCaption1.BorderColor = System.Drawing.Color.Gainsboro;
            this.DetailCaption1.Borders = DevExpress.XtraPrinting.BorderSide.Left;
            this.DetailCaption1.BorderWidth = 2F;
            this.DetailCaption1.Font = new System.Drawing.Font("Arial", 8.25F, System.Drawing.FontStyle.Bold);
            this.DetailCaption1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(70)))), ((int)(((byte)(80)))));
            this.DetailCaption1.Name = "DetailCaption1";
            this.DetailCaption1.Padding = new DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100F);
            this.DetailCaption1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft;
            // 
            // DetailData1
            // 
            this.DetailData1.BorderColor = System.Drawing.Color.Transparent;
            this.DetailData1.Borders = DevExpress.XtraPrinting.BorderSide.Left;
            this.DetailData1.BorderWidth = 2F;
            this.DetailData1.Font = new System.Drawing.Font("Arial", 8.25F);
            this.DetailData1.ForeColor = System.Drawing.Color.Black;
            this.DetailData1.Name = "DetailData1";
            this.DetailData1.Padding = new DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100F);
            this.DetailData1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft;
            // 
            // DetailData3_Odd
            // 
            this.DetailData3_Odd.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(245)))), ((int)(((byte)(248)))));
            this.DetailData3_Odd.BorderColor = System.Drawing.Color.Transparent;
            this.DetailData3_Odd.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.DetailData3_Odd.BorderWidth = 1F;
            this.DetailData3_Odd.Font = new System.Drawing.Font("Arial", 8.25F);
            this.DetailData3_Odd.ForeColor = System.Drawing.Color.Black;
            this.DetailData3_Odd.Name = "DetailData3_Odd";
            this.DetailData3_Odd.Padding = new DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100F);
            this.DetailData3_Odd.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft;
            // 
            // PageInfo
            // 
            this.PageInfo.Font = new System.Drawing.Font("Arial", 8.25F, System.Drawing.FontStyle.Bold);
            this.PageInfo.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(70)))), ((int)(((byte)(80)))));
            this.PageInfo.Name = "PageInfo";
            this.PageInfo.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            // 
            // TopMargin
            // 
            this.TopMargin.HeightF = 0F;
            this.TopMargin.Name = "TopMargin";
            // 
            // BottomMargin
            // 
            this.BottomMargin.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.pageInfo1,
            this.pageInfo2});
            this.BottomMargin.HeightF = 25.41669F;
            this.BottomMargin.Name = "BottomMargin";
            // 
            // pageInfo1
            // 
            this.pageInfo1.LocationFloat = new DevExpress.Utils.PointFloat(8.106232E-06F, 1.41658F);
            this.pageInfo1.Name = "pageInfo1";
            this.pageInfo1.PageInfo = DevExpress.XtraPrinting.PageInfo.DateTime;
            this.pageInfo1.SizeF = new System.Drawing.SizeF(438F, 23F);
            this.pageInfo1.StyleName = "PageInfo";
            // 
            // pageInfo2
            // 
            this.pageInfo2.LocationFloat = new DevExpress.Utils.PointFloat(632.9998F, 1.41658F);
            this.pageInfo2.Name = "pageInfo2";
            this.pageInfo2.SizeF = new System.Drawing.SizeF(438F, 23F);
            this.pageInfo2.StyleName = "PageInfo";
            this.pageInfo2.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            this.pageInfo2.TextFormatString = "Page {0} of {1}";
            // 
            // ReportHeader
            // 
            this.ReportHeader.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrLabel47,
            this.xrLabel12,
            this.xrLabel51,
            this.xrLabel50,
            this.xrLabel49,
            this.xrLabel46,
            this.xrLabel45,
            this.xrLabel48,
            this.xrLabel21,
            this.xrLabel32,
            this.xrLabel16,
            this.xrLabel11,
            this.xrLabel31,
            this.xrLabel30,
            this.xrLabel29,
            this.xrLabel28,
            this.xrLabel27,
            this.xrLabel26,
            this.xrLabel25,
            this.xrLabel24,
            this.xrLabel23,
            this.xrLabel22,
            this.xrLabel20,
            this.xrLabel19,
            this.xrLabel18,
            this.xrLabel17,
            this.xrLabel15,
            this.xrLabel14,
            this.xrLabel13});
            this.ReportHeader.HeightF = 326.3333F;
            this.ReportHeader.KeepTogether = true;
            this.ReportHeader.Name = "ReportHeader";
            // 
            // xrLabel47
            // 
            this.xrLabel47.Borders = ((DevExpress.XtraPrinting.BorderSide)((DevExpress.XtraPrinting.BorderSide.Right | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrLabel47.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel47.LocationFloat = new DevExpress.Utils.PointFloat(317.3651F, 188F);
            this.xrLabel47.Multiline = true;
            this.xrLabel47.Name = "xrLabel47";
            this.xrLabel47.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel47.SizeF = new System.Drawing.SizeF(133.3334F, 23F);
            this.xrLabel47.StylePriority.UseBorders = false;
            this.xrLabel47.StylePriority.UseFont = false;
            // 
            // xrLabel12
            // 
            this.xrLabel12.Borders = ((DevExpress.XtraPrinting.BorderSide)((DevExpress.XtraPrinting.BorderSide.Right | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrLabel12.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?Challan_Date")});
            this.xrLabel12.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel12.LocationFloat = new DevExpress.Utils.PointFloat(317.3651F, 119F);
            this.xrLabel12.Multiline = true;
            this.xrLabel12.Name = "xrLabel12";
            this.xrLabel12.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel12.SizeF = new System.Drawing.SizeF(133.3334F, 23F);
            this.xrLabel12.StylePriority.UseBorders = false;
            this.xrLabel12.StylePriority.UseFont = false;
            // 
            // xrLabel51
            // 
            this.xrLabel51.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel51.LocationFloat = new DevExpress.Utils.PointFloat(518.2916F, 25.99999F);
            this.xrLabel51.Multiline = true;
            this.xrLabel51.Name = "xrLabel51";
            this.xrLabel51.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel51.SizeF = new System.Drawing.SizeF(27.08347F, 23.00001F);
            this.xrLabel51.StylePriority.UseFont = false;
            this.xrLabel51.Text = "To";
            // 
            // xrLabel50
            // 
            this.xrLabel50.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?qdate")});
            this.xrLabel50.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel50.LocationFloat = new DevExpress.Utils.PointFloat(545.3751F, 25.99999F);
            this.xrLabel50.Multiline = true;
            this.xrLabel50.Name = "xrLabel50";
            this.xrLabel50.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel50.SizeF = new System.Drawing.SizeF(79.89209F, 23F);
            this.xrLabel50.StylePriority.UseFont = false;
            this.xrLabel50.Text = "xrLabel50";
            // 
            // xrLabel49
            // 
            this.xrLabel49.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?qStartdate")});
            this.xrLabel49.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel49.LocationFloat = new DevExpress.Utils.PointFloat(453.7083F, 25.99999F);
            this.xrLabel49.Multiline = true;
            this.xrLabel49.Name = "xrLabel49";
            this.xrLabel49.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel49.SizeF = new System.Drawing.SizeF(64.58331F, 23F);
            this.xrLabel49.StylePriority.UseFont = false;
            this.xrLabel49.Text = "xrLabel49";
            // 
            // xrLabel46
            // 
            this.xrLabel46.Borders = ((DevExpress.XtraPrinting.BorderSide)((DevExpress.XtraPrinting.BorderSide.Right | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrLabel46.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?totaltax")});
            this.xrLabel46.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel46.LocationFloat = new DevExpress.Utils.PointFloat(317.3651F, 211F);
            this.xrLabel46.Multiline = true;
            this.xrLabel46.Name = "xrLabel46";
            this.xrLabel46.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel46.SizeF = new System.Drawing.SizeF(133.3333F, 23F);
            this.xrLabel46.StylePriority.UseBorders = false;
            this.xrLabel46.StylePriority.UseFont = false;
            this.xrLabel46.Text = "xrLabel46";
            // 
            // xrLabel45
            // 
            this.xrLabel45.Borders = ((DevExpress.XtraPrinting.BorderSide)((DevExpress.XtraPrinting.BorderSide.Right | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrLabel45.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?Challan_Amount")});
            this.xrLabel45.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel45.LocationFloat = new DevExpress.Utils.PointFloat(317.3651F, 280.0001F);
            this.xrLabel45.Multiline = true;
            this.xrLabel45.Name = "xrLabel45";
            this.xrLabel45.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel45.SizeF = new System.Drawing.SizeF(133.3333F, 23F);
            this.xrLabel45.StylePriority.UseBorders = false;
            this.xrLabel45.StylePriority.UseFont = false;
            this.xrLabel45.Text = "xrLabel45";
            // 
            // xrLabel48
            // 
            this.xrLabel48.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.xrLabel48.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel48.LocationFloat = new DevExpress.Utils.PointFloat(317.3651F, 165F);
            this.xrLabel48.Multiline = true;
            this.xrLabel48.Name = "xrLabel48";
            this.xrLabel48.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel48.SizeF = new System.Drawing.SizeF(30.31943F, 23F);
            this.xrLabel48.StylePriority.UseBorders = false;
            this.xrLabel48.StylePriority.UseFont = false;
            this.xrLabel48.Text = "Form";
            // 
            // xrLabel21
            // 
            this.xrLabel21.Borders = ((DevExpress.XtraPrinting.BorderSide)((DevExpress.XtraPrinting.BorderSide.Right | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrLabel21.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?Form_Type")});
            this.xrLabel21.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel21.LocationFloat = new DevExpress.Utils.PointFloat(347.6845F, 165F);
            this.xrLabel21.Multiline = true;
            this.xrLabel21.Name = "xrLabel21";
            this.xrLabel21.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel21.SizeF = new System.Drawing.SizeF(103.0139F, 22.99998F);
            this.xrLabel21.StylePriority.UseBorders = false;
            this.xrLabel21.StylePriority.UseFont = false;
            this.xrLabel21.Text = "xrLabel21";
            // 
            // xrLabel32
            // 
            this.xrLabel32.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Top | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrLabel32.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?CompanyName")});
            this.xrLabel32.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel32.LocationFloat = new DevExpress.Utils.PointFloat(634.2361F, 96F);
            this.xrLabel32.Multiline = true;
            this.xrLabel32.Name = "xrLabel32";
            this.xrLabel32.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel32.SizeF = new System.Drawing.SizeF(321.875F, 23F);
            this.xrLabel32.StylePriority.UseBorders = false;
            this.xrLabel32.StylePriority.UseFont = false;
            this.xrLabel32.Text = "xrLabel32";
            // 
            // xrLabel16
            // 
            this.xrLabel16.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Top | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrLabel16.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?Bank_Bsrcode")});
            this.xrLabel16.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel16.KeepTogether = true;
            this.xrLabel16.LocationFloat = new DevExpress.Utils.PointFloat(317.3651F, 96F);
            this.xrLabel16.Multiline = true;
            this.xrLabel16.Name = "xrLabel16";
            this.xrLabel16.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel16.SizeF = new System.Drawing.SizeF(133.3333F, 23F);
            this.xrLabel16.StylePriority.UseBorders = false;
            this.xrLabel16.StylePriority.UseFont = false;
            this.xrLabel16.Text = "xrLabel16";
            // 
            // xrLabel11
            // 
            this.xrLabel11.Font = new System.Drawing.Font("Arial", 9F, System.Drawing.FontStyle.Bold);
            this.xrLabel11.LocationFloat = new DevExpress.Utils.PointFloat(3.973643E-05F, 3F);
            this.xrLabel11.Multiline = true;
            this.xrLabel11.Name = "xrLabel11";
            this.xrLabel11.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel11.SizeF = new System.Drawing.SizeF(1065F, 23F);
            this.xrLabel11.StylePriority.UseFont = false;
            this.xrLabel11.StylePriority.UseTextAlignment = false;
            this.xrLabel11.Text = "ANNEXURE-DEDUCTEE WISE BREAKUP-UP OF TDS";
            this.xrLabel11.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // xrLabel31
            // 
            this.xrLabel31.Borders = ((DevExpress.XtraPrinting.BorderSide)((DevExpress.XtraPrinting.BorderSide.Right | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrLabel31.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?TANNo")});
            this.xrLabel31.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel31.LocationFloat = new DevExpress.Utils.PointFloat(634.2361F, 119F);
            this.xrLabel31.Multiline = true;
            this.xrLabel31.Name = "xrLabel31";
            this.xrLabel31.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel31.SizeF = new System.Drawing.SizeF(321.875F, 23F);
            this.xrLabel31.StylePriority.UseBorders = false;
            this.xrLabel31.StylePriority.UseFont = false;
            this.xrLabel31.Text = "xrLabel31";
            // 
            // xrLabel30
            // 
            this.xrLabel30.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrLabel30.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel30.LocationFloat = new DevExpress.Utils.PointFloat(527.875F, 119F);
            this.xrLabel30.Multiline = true;
            this.xrLabel30.Name = "xrLabel30";
            this.xrLabel30.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel30.SizeF = new System.Drawing.SizeF(106.3611F, 23F);
            this.xrLabel30.StylePriority.UseBorders = false;
            this.xrLabel30.StylePriority.UseFont = false;
            this.xrLabel30.Text = "TAN";
            // 
            // xrLabel29
            // 
            this.xrLabel29.Borders = ((DevExpress.XtraPrinting.BorderSide)((((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrLabel29.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel29.LocationFloat = new DevExpress.Utils.PointFloat(527.875F, 96F);
            this.xrLabel29.Multiline = true;
            this.xrLabel29.Name = "xrLabel29";
            this.xrLabel29.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel29.SizeF = new System.Drawing.SizeF(106.3611F, 23F);
            this.xrLabel29.StylePriority.UseBorders = false;
            this.xrLabel29.StylePriority.UseFont = false;
            this.xrLabel29.Text = "Name of Deductor";
            // 
            // xrLabel28
            // 
            this.xrLabel28.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrLabel28.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel28.KeepTogether = true;
            this.xrLabel28.LocationFloat = new DevExpress.Utils.PointFloat(21F, 280.0001F);
            this.xrLabel28.Multiline = true;
            this.xrLabel28.Name = "xrLabel28";
            this.xrLabel28.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel28.SizeF = new System.Drawing.SizeF(296.3651F, 23F);
            this.xrLabel28.StylePriority.UseBorders = false;
            this.xrLabel28.StylePriority.UseFont = false;
            this.xrLabel28.Text = "Total of above";
            // 
            // xrLabel27
            // 
            this.xrLabel27.Borders = ((DevExpress.XtraPrinting.BorderSide)((DevExpress.XtraPrinting.BorderSide.Right | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrLabel27.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?Others_Amount")});
            this.xrLabel27.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel27.KeepTogether = true;
            this.xrLabel27.LocationFloat = new DevExpress.Utils.PointFloat(317.3651F, 257.0001F);
            this.xrLabel27.Multiline = true;
            this.xrLabel27.Name = "xrLabel27";
            this.xrLabel27.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel27.SizeF = new System.Drawing.SizeF(133.3333F, 22.99997F);
            this.xrLabel27.StylePriority.UseBorders = false;
            this.xrLabel27.StylePriority.UseFont = false;
            this.xrLabel27.StylePriority.UseTextAlignment = false;
            this.xrLabel27.Text = "xrLabel27";
            this.xrLabel27.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // xrLabel26
            // 
            this.xrLabel26.Borders = ((DevExpress.XtraPrinting.BorderSide)((DevExpress.XtraPrinting.BorderSide.Right | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrLabel26.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?Interest_Amt")});
            this.xrLabel26.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel26.KeepTogether = true;
            this.xrLabel26.LocationFloat = new DevExpress.Utils.PointFloat(317.3651F, 234F);
            this.xrLabel26.Multiline = true;
            this.xrLabel26.Name = "xrLabel26";
            this.xrLabel26.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel26.SizeF = new System.Drawing.SizeF(133.3333F, 22.99995F);
            this.xrLabel26.StylePriority.UseBorders = false;
            this.xrLabel26.StylePriority.UseFont = false;
            this.xrLabel26.StylePriority.UseTextAlignment = false;
            xrSummary1.Running = DevExpress.XtraReports.UI.SummaryRunning.Group;
            this.xrLabel26.Summary = xrSummary1;
            this.xrLabel26.Text = "xrLabel26";
            this.xrLabel26.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // xrLabel25
            // 
            this.xrLabel25.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrLabel25.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel25.KeepTogether = true;
            this.xrLabel25.LocationFloat = new DevExpress.Utils.PointFloat(21F, 257.0001F);
            this.xrLabel25.Multiline = true;
            this.xrLabel25.Name = "xrLabel25";
            this.xrLabel25.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel25.SizeF = new System.Drawing.SizeF(296.3651F, 23F);
            this.xrLabel25.StylePriority.UseBorders = false;
            this.xrLabel25.StylePriority.UseFont = false;
            this.xrLabel25.Text = "other :";
            // 
            // xrLabel24
            // 
            this.xrLabel24.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrLabel24.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel24.KeepTogether = true;
            this.xrLabel24.LocationFloat = new DevExpress.Utils.PointFloat(21.00001F, 234F);
            this.xrLabel24.Multiline = true;
            this.xrLabel24.Name = "xrLabel24";
            this.xrLabel24.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel24.SizeF = new System.Drawing.SizeF(296.3651F, 23F);
            this.xrLabel24.StylePriority.UseBorders = false;
            this.xrLabel24.StylePriority.UseFont = false;
            this.xrLabel24.Text = "Interest :";
            // 
            // xrLabel23
            // 
            this.xrLabel23.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrLabel23.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel23.KeepTogether = true;
            this.xrLabel23.LocationFloat = new DevExpress.Utils.PointFloat(21F, 211F);
            this.xrLabel23.Multiline = true;
            this.xrLabel23.Name = "xrLabel23";
            this.xrLabel23.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel23.SizeF = new System.Drawing.SizeF(296.3651F, 23F);
            this.xrLabel23.StylePriority.UseBorders = false;
            this.xrLabel23.StylePriority.UseFont = false;
            this.xrLabel23.Text = "in the vertical total of col 425 :";
            // 
            // xrLabel22
            // 
            this.xrLabel22.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrLabel22.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel22.KeepTogether = true;
            this.xrLabel22.LocationFloat = new DevExpress.Utils.PointFloat(21F, 188F);
            this.xrLabel22.Multiline = true;
            this.xrLabel22.Name = "xrLabel22";
            this.xrLabel22.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel22.SizeF = new System.Drawing.SizeF(296.3651F, 23F);
            this.xrLabel22.StylePriority.UseBorders = false;
            this.xrLabel22.StylePriority.UseFont = false;
            this.xrLabel22.Text = "Total TDS to be allowcated among deducties as";
            // 
            // xrLabel20
            // 
            this.xrLabel20.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrLabel20.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel20.KeepTogether = true;
            this.xrLabel20.LocationFloat = new DevExpress.Utils.PointFloat(21.00001F, 165F);
            this.xrLabel20.Multiline = true;
            this.xrLabel20.Name = "xrLabel20";
            this.xrLabel20.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel20.SizeF = new System.Drawing.SizeF(296.3651F, 23F);
            this.xrLabel20.StylePriority.UseBorders = false;
            this.xrLabel20.StylePriority.UseFont = false;
            this.xrLabel20.Text = "Seciton Under which Payment made :";
            // 
            // xrLabel19
            // 
            this.xrLabel19.Borders = ((DevExpress.XtraPrinting.BorderSide)((DevExpress.XtraPrinting.BorderSide.Right | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrLabel19.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?Challan_No")});
            this.xrLabel19.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel19.KeepTogether = true;
            this.xrLabel19.LocationFloat = new DevExpress.Utils.PointFloat(317.3651F, 142F);
            this.xrLabel19.Multiline = true;
            this.xrLabel19.Name = "xrLabel19";
            this.xrLabel19.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel19.SizeF = new System.Drawing.SizeF(133.3333F, 23F);
            this.xrLabel19.StylePriority.UseBorders = false;
            this.xrLabel19.StylePriority.UseFont = false;
            this.xrLabel19.Text = "xrLabel19";
            // 
            // xrLabel18
            // 
            this.xrLabel18.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrLabel18.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel18.KeepTogether = true;
            this.xrLabel18.LocationFloat = new DevExpress.Utils.PointFloat(21F, 142F);
            this.xrLabel18.Multiline = true;
            this.xrLabel18.Name = "xrLabel18";
            this.xrLabel18.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel18.SizeF = new System.Drawing.SizeF(296.3651F, 23F);
            this.xrLabel18.StylePriority.UseBorders = false;
            this.xrLabel18.StylePriority.UseFont = false;
            this.xrLabel18.Text = "Challan Serial No. : ";
            // 
            // xrLabel17
            // 
            this.xrLabel17.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrLabel17.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel17.KeepTogether = true;
            this.xrLabel17.LocationFloat = new DevExpress.Utils.PointFloat(21F, 119F);
            this.xrLabel17.Multiline = true;
            this.xrLabel17.Name = "xrLabel17";
            this.xrLabel17.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel17.SizeF = new System.Drawing.SizeF(296.3651F, 23F);
            this.xrLabel17.StylePriority.UseBorders = false;
            this.xrLabel17.StylePriority.UseFont = false;
            this.xrLabel17.Text = "Date on which tax deposited (dd-mm-yyyy) :";
            // 
            // xrLabel15
            // 
            this.xrLabel15.Borders = ((DevExpress.XtraPrinting.BorderSide)((((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrLabel15.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel15.KeepTogether = true;
            this.xrLabel15.LocationFloat = new DevExpress.Utils.PointFloat(21.00001F, 96F);
            this.xrLabel15.Multiline = true;
            this.xrLabel15.Name = "xrLabel15";
            this.xrLabel15.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel15.SizeF = new System.Drawing.SizeF(296.3651F, 23F);
            this.xrLabel15.StylePriority.UseBorders = false;
            this.xrLabel15.StylePriority.UseFont = false;
            this.xrLabel15.Text = "BSR code of the branch where tax is deposited :";
            // 
            // xrLabel14
            // 
            this.xrLabel14.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel14.KeepTogether = true;
            this.xrLabel14.LocationFloat = new DevExpress.Utils.PointFloat(625.2672F, 25.99999F);
            this.xrLabel14.Multiline = true;
            this.xrLabel14.Name = "xrLabel14";
            this.xrLabel14.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel14.SizeF = new System.Drawing.SizeF(293.7501F, 23F);
            this.xrLabel14.StylePriority.UseFont = false;
            this.xrLabel14.Text = "(DD-MM-YYYY) and of tax deducted at source ";
            // 
            // xrLabel13
            // 
            this.xrLabel13.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel13.KeepTogether = true;
            this.xrLabel13.LocationFloat = new DevExpress.Utils.PointFloat(157.3432F, 25.99999F);
            this.xrLabel13.Multiline = true;
            this.xrLabel13.Name = "xrLabel13";
            this.xrLabel13.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel13.SizeF = new System.Drawing.SizeF(296.3651F, 23F);
            this.xrLabel13.StylePriority.UseFont = false;
            this.xrLabel13.Text = "Details of amounts paid/credited during the quarter ended ";
            // 
            // GroupHeader1
            // 
            this.GroupHeader1.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.table1});
            this.GroupHeader1.GroupUnion = DevExpress.XtraReports.UI.GroupUnion.WithFirstDetail;
            this.GroupHeader1.HeightF = 56F;
            this.GroupHeader1.KeepTogether = true;
            this.GroupHeader1.Name = "GroupHeader1";
            this.GroupHeader1.RepeatEveryPage = true;
            // 
            // table1
            // 
            this.table1.Font = new System.Drawing.Font("Arial", 9F);
            this.table1.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.table1.Name = "table1";
            this.table1.Rows.AddRange(new DevExpress.XtraReports.UI.XRTableRow[] {
            this.tableRow1,
            this.xrTableRow1});
            this.table1.SizeF = new System.Drawing.SizeF(1071F, 56F);
            this.table1.StylePriority.UseFont = false;
            // 
            // tableRow1
            // 
            this.tableRow1.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.tableCell1,
            this.tableCell2,
            this.tableCell3,
            this.tableCell4,
            this.tableCell5,
            this.tableCell6,
            this.tableCell7,
            this.tableCell8,
            this.tableCell9,
            this.tableCell10,
            this.tableCell11,
            this.xrTableCell1,
            this.tableCell12,
            this.tableCell13,
            this.tableCell14});
            this.tableRow1.Name = "tableRow1";
            this.tableRow1.Weight = 1D;
            // 
            // tableCell1
            // 
            this.tableCell1.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.tableCell1.Name = "tableCell1";
            this.tableCell1.StyleName = "DetailCaption1";
            this.tableCell1.StylePriority.UseBorders = false;
            this.tableCell1.StylePriority.UseTextAlignment = false;
            this.tableCell1.Text = "Sr.No";
            this.tableCell1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            this.tableCell1.Weight = 0.03535264760955209D;
            // 
            // tableCell2
            // 
            this.tableCell2.Multiline = true;
            this.tableCell2.Name = "tableCell2";
            this.tableCell2.StyleName = "DetailCaption1";
            this.tableCell2.StylePriority.UseTextAlignment = false;
            this.tableCell2.Text = "Deductee code(01-company\r\n 02-other \r\nthan \r\ncompany";
            this.tableCell2.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            this.tableCell2.Weight = 0.081251538591337935D;
            // 
            // tableCell3
            // 
            this.tableCell3.Name = "tableCell3";
            this.tableCell3.StyleName = "DetailCaption1";
            this.tableCell3.StylePriority.UseTextAlignment = false;
            this.tableCell3.Text = "Pan of Deductee";
            this.tableCell3.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            this.tableCell3.Weight = 0.10856479000330244D;
            // 
            // tableCell4
            // 
            this.tableCell4.Name = "tableCell4";
            this.tableCell4.StyleName = "DetailCaption1";
            this.tableCell4.StylePriority.UseTextAlignment = false;
            this.tableCell4.Text = "Name of Deductee";
            this.tableCell4.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            this.tableCell4.Weight = 0.11731995164259856D;
            // 
            // tableCell5
            // 
            this.tableCell5.Multiline = true;
            this.tableCell5.Name = "tableCell5";
            this.tableCell5.StyleName = "DetailCaption1";
            this.tableCell5.StylePriority.UseTextAlignment = false;
            this.tableCell5.Text = "Date of Payment/\r\nCredit";
            this.tableCell5.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            this.tableCell5.Weight = 0.11180569684021138D;
            // 
            // tableCell6
            // 
            this.tableCell6.Multiline = true;
            this.tableCell6.Name = "tableCell6";
            this.tableCell6.StyleName = "DetailCaption1";
            this.tableCell6.StylePriority.UseTextAlignment = false;
            this.tableCell6.Text = "Amount paid/\r\ncredited";
            this.tableCell6.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            this.tableCell6.Weight = 0.092775789974345407D;
            // 
            // tableCell7
            // 
            this.tableCell7.Multiline = true;
            this.tableCell7.Name = "tableCell7";
            this.tableCell7.StyleName = "DetailCaption1";
            this.tableCell7.StylePriority.UseTextAlignment = false;
            this.tableCell7.Text = "Paid by \r\nbook \r\nentry or\r\notherwise";
            this.tableCell7.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            this.tableCell7.Weight = 0.057219615183923309D;
            // 
            // tableCell8
            // 
            this.tableCell8.Name = "tableCell8";
            this.tableCell8.StyleName = "DetailCaption1";
            this.tableCell8.StylePriority.UseTextAlignment = false;
            this.tableCell8.Text = "Tds";
            this.tableCell8.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            this.tableCell8.Weight = 0.077083401979391647D;
            // 
            // tableCell9
            // 
            this.tableCell9.Name = "tableCell9";
            this.tableCell9.StyleName = "DetailCaption1";
            this.tableCell9.StylePriority.UseTextAlignment = false;
            this.tableCell9.Text = "Sur";
            this.tableCell9.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            this.tableCell9.Weight = 0.078598297853039858D;
            // 
            // tableCell10
            // 
            this.tableCell10.Name = "tableCell10";
            this.tableCell10.StyleName = "DetailCaption1";
            this.tableCell10.StylePriority.UseTextAlignment = false;
            this.tableCell10.Text = "ECess";
            this.tableCell10.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            this.tableCell10.Weight = 0.0681803429435628D;
            // 
            // tableCell11
            // 
            this.tableCell11.Name = "tableCell11";
            this.tableCell11.StyleName = "DetailCaption1";
            this.tableCell11.StylePriority.UseTextAlignment = false;
            this.tableCell11.Text = "Total  tax deducted(421+422+423)";
            this.tableCell11.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            this.tableCell11.Weight = 0.091312187712486059D;
            // 
            // xrTableCell1
            // 
            this.xrTableCell1.Multiline = true;
            this.xrTableCell1.Name = "xrTableCell1";
            this.xrTableCell1.StyleName = "DetailCaption1";
            this.xrTableCell1.StylePriority.UseTextAlignment = false;
            this.xrTableCell1.Text = "Total \r\nTax Deposited";
            this.xrTableCell1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            this.xrTableCell1.Weight = 0.07277709863703534D;
            // 
            // tableCell12
            // 
            this.tableCell12.Name = "tableCell12";
            this.tableCell12.StyleName = "DetailCaption1";
            this.tableCell12.StylePriority.UseTextAlignment = false;
            this.tableCell12.Text = "Date of deduction ";
            this.tableCell12.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            this.tableCell12.Weight = 0.088282593637186574D;
            // 
            // tableCell13
            // 
            this.tableCell13.Name = "tableCell13";
            this.tableCell13.StyleName = "DetailCaption1";
            this.tableCell13.StylePriority.UseTextAlignment = false;
            this.tableCell13.Text = "Rate at which deducted ";
            this.tableCell13.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            this.tableCell13.Weight = 0.055285961331766706D;
            // 
            // tableCell14
            // 
            this.tableCell14.Name = "tableCell14";
            this.tableCell14.StyleName = "DetailCaption1";
            this.tableCell14.StylePriority.UseTextAlignment = false;
            this.tableCell14.Text = "Reason for non-deduction/lower deduction";
            this.tableCell14.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            this.tableCell14.Weight = 0.054190059480141356D;
            // 
            // xrTableRow1
            // 
            this.xrTableRow1.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell3,
            this.xrTableCell4,
            this.xrTableCell5,
            this.xrTableCell6,
            this.xrTableCell7,
            this.xrTableCell8,
            this.xrTableCell9,
            this.xrTableCell10,
            this.xrTableCell11,
            this.xrTableCell12,
            this.xrTableCell13,
            this.xrTableCell14,
            this.xrTableCell15,
            this.xrTableCell16,
            this.xrTableCell17});
            this.xrTableRow1.Name = "xrTableRow1";
            this.xrTableRow1.Weight = 1D;
            // 
            // xrTableCell3
            // 
            this.xrTableCell3.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrTableCell3.Multiline = true;
            this.xrTableCell3.Name = "xrTableCell3";
            this.xrTableCell3.StyleName = "DetailCaption1";
            this.xrTableCell3.StylePriority.UseBorders = false;
            this.xrTableCell3.StylePriority.UseTextAlignment = false;
            this.xrTableCell3.Text = "414";
            this.xrTableCell3.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell3.Weight = 0.03535264760955209D;
            // 
            // xrTableCell4
            // 
            this.xrTableCell4.Multiline = true;
            this.xrTableCell4.Name = "xrTableCell4";
            this.xrTableCell4.StyleName = "DetailCaption1";
            this.xrTableCell4.StylePriority.UseTextAlignment = false;
            this.xrTableCell4.Text = "415";
            this.xrTableCell4.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell4.Weight = 0.081251538591337935D;
            // 
            // xrTableCell5
            // 
            this.xrTableCell5.Multiline = true;
            this.xrTableCell5.Name = "xrTableCell5";
            this.xrTableCell5.StyleName = "DetailCaption1";
            this.xrTableCell5.StylePriority.UseTextAlignment = false;
            this.xrTableCell5.Text = "416";
            this.xrTableCell5.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell5.Weight = 0.10856475609488113D;
            // 
            // xrTableCell6
            // 
            this.xrTableCell6.Multiline = true;
            this.xrTableCell6.Name = "xrTableCell6";
            this.xrTableCell6.StyleName = "DetailCaption1";
            this.xrTableCell6.StylePriority.UseTextAlignment = false;
            this.xrTableCell6.Text = "417";
            this.xrTableCell6.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell6.Weight = 0.11731998555101987D;
            // 
            // xrTableCell7
            // 
            this.xrTableCell7.Multiline = true;
            this.xrTableCell7.Name = "xrTableCell7";
            this.xrTableCell7.StyleName = "DetailCaption1";
            this.xrTableCell7.StylePriority.UseTextAlignment = false;
            this.xrTableCell7.Text = "418";
            this.xrTableCell7.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell7.Weight = 0.11180569684021138D;
            // 
            // xrTableCell8
            // 
            this.xrTableCell8.Multiline = true;
            this.xrTableCell8.Name = "xrTableCell8";
            this.xrTableCell8.StyleName = "DetailCaption1";
            this.xrTableCell8.StylePriority.UseTextAlignment = false;
            this.xrTableCell8.Text = "419";
            this.xrTableCell8.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell8.Weight = 0.092775789974345407D;
            // 
            // xrTableCell9
            // 
            this.xrTableCell9.Multiline = true;
            this.xrTableCell9.Name = "xrTableCell9";
            this.xrTableCell9.StyleName = "DetailCaption1";
            this.xrTableCell9.StylePriority.UseTextAlignment = false;
            this.xrTableCell9.Text = "420";
            this.xrTableCell9.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell9.Weight = 0.057219615183923322D;
            // 
            // xrTableCell10
            // 
            this.xrTableCell10.Multiline = true;
            this.xrTableCell10.Name = "xrTableCell10";
            this.xrTableCell10.StyleName = "DetailCaption1";
            this.xrTableCell10.StylePriority.UseTextAlignment = false;
            this.xrTableCell10.Text = "421";
            this.xrTableCell10.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell10.Weight = 0.077083469796234261D;
            // 
            // xrTableCell11
            // 
            this.xrTableCell11.Multiline = true;
            this.xrTableCell11.Name = "xrTableCell11";
            this.xrTableCell11.StyleName = "DetailCaption1";
            this.xrTableCell11.StylePriority.UseTextAlignment = false;
            this.xrTableCell11.Text = "422";
            this.xrTableCell11.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell11.Weight = 0.078598297853039858D;
            // 
            // xrTableCell12
            // 
            this.xrTableCell12.Multiline = true;
            this.xrTableCell12.Name = "xrTableCell12";
            this.xrTableCell12.StyleName = "DetailCaption1";
            this.xrTableCell12.StylePriority.UseTextAlignment = false;
            this.xrTableCell12.Text = "423";
            this.xrTableCell12.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell12.Weight = 0.068180275126720175D;
            // 
            // xrTableCell13
            // 
            this.xrTableCell13.Multiline = true;
            this.xrTableCell13.Name = "xrTableCell13";
            this.xrTableCell13.StyleName = "DetailCaption1";
            this.xrTableCell13.StylePriority.UseTextAlignment = false;
            this.xrTableCell13.Text = "424";
            this.xrTableCell13.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell13.Weight = 0.091312187712486059D;
            // 
            // xrTableCell14
            // 
            this.xrTableCell14.Multiline = true;
            this.xrTableCell14.Name = "xrTableCell14";
            this.xrTableCell14.StyleName = "DetailCaption1";
            this.xrTableCell14.StylePriority.UseTextAlignment = false;
            this.xrTableCell14.Text = "425";
            this.xrTableCell14.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell14.Weight = 0.072777166453877967D;
            // 
            // xrTableCell15
            // 
            this.xrTableCell15.Multiline = true;
            this.xrTableCell15.Name = "xrTableCell15";
            this.xrTableCell15.StyleName = "DetailCaption1";
            this.xrTableCell15.StylePriority.UseTextAlignment = false;
            this.xrTableCell15.Text = "426";
            this.xrTableCell15.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell15.Weight = 0.088282636022713218D;
            // 
            // xrTableCell16
            // 
            this.xrTableCell16.Multiline = true;
            this.xrTableCell16.Name = "xrTableCell16";
            this.xrTableCell16.StyleName = "DetailCaption1";
            this.xrTableCell16.StylePriority.UseTextAlignment = false;
            this.xrTableCell16.Text = "427";
            this.xrTableCell16.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell16.Weight = 0.055285851129397434D;
            // 
            // xrTableCell17
            // 
            this.xrTableCell17.Multiline = true;
            this.xrTableCell17.Name = "xrTableCell17";
            this.xrTableCell17.StyleName = "DetailCaption1";
            this.xrTableCell17.StylePriority.UseTextAlignment = false;
            this.xrTableCell17.Text = "428";
            this.xrTableCell17.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell17.Weight = 0.054190059480141356D;
            // 
            // Detail
            // 
            this.Detail.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.table2});
            this.Detail.HeightF = 25F;
            this.Detail.MultiColumn.Layout = DevExpress.XtraPrinting.ColumnLayout.AcrossThenDown;
            this.Detail.Name = "Detail";
            // 
            // table2
            // 
            this.table2.Font = new System.Drawing.Font("Arial", 8F);
            this.table2.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.table2.Name = "table2";
            this.table2.OddStyleName = "DetailData3_Odd";
            this.table2.Rows.AddRange(new DevExpress.XtraReports.UI.XRTableRow[] {
            this.tableRow2});
            this.table2.SizeF = new System.Drawing.SizeF(1071F, 25F);
            this.table2.StylePriority.UseFont = false;
            // 
            // tableRow2
            // 
            this.tableRow2.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.tableCell15,
            this.tableCell16,
            this.tableCell17,
            this.tableCell18,
            this.tableCell19,
            this.tableCell20,
            this.tableCell21,
            this.tableCell22,
            this.tableCell23,
            this.tableCell24,
            this.xrTableCell2,
            this.tableCell25,
            this.tableCell26,
            this.tableCell27,
            this.tableCell28});
            this.tableRow2.Name = "tableRow2";
            this.tableRow2.Weight = 11.5D;
            // 
            // tableCell15
            // 
            this.tableCell15.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.tableCell15.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Srno]")});
            this.tableCell15.Name = "tableCell15";
            this.tableCell15.StyleName = "DetailData1";
            this.tableCell15.StylePriority.UseBorders = false;
            this.tableCell15.Weight = 0.037194946494666176D;
            // 
            // tableCell16
            // 
            this.tableCell16.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Deductee_Type]")});
            this.tableCell16.Name = "tableCell16";
            this.tableCell16.StyleName = "DetailData1";
            this.tableCell16.Weight = 0.085485721037605239D;
            // 
            // tableCell17
            // 
            this.tableCell17.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[PAN_NO]")});
            this.tableCell17.Name = "tableCell17";
            this.tableCell17.StyleName = "DetailData1";
            this.tableCell17.Weight = 0.11787386875043328D;
            // 
            // tableCell18
            // 
            this.tableCell18.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Deductee_Name]")});
            this.tableCell18.Name = "tableCell18";
            this.tableCell18.StyleName = "DetailData1";
            this.tableCell18.Weight = 0.1197821983652814D;
            // 
            // tableCell19
            // 
            this.tableCell19.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Challan_Date]")});
            this.tableCell19.Name = "tableCell19";
            this.tableCell19.StyleName = "DetailData1";
            this.tableCell19.Weight = 0.11763212235433676D;
            // 
            // tableCell20
            // 
            this.tableCell20.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Voucher_Amount]")});
            this.tableCell20.Name = "tableCell20";
            this.tableCell20.StyleName = "DetailData1";
            this.tableCell20.StylePriority.UseTextAlignment = false;
            this.tableCell20.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableCell20.Weight = 0.097610558976120032D;
            // 
            // tableCell21
            // 
            this.tableCell21.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[paidbybook]")});
            this.tableCell21.Name = "tableCell21";
            this.tableCell21.StyleName = "DetailData1";
            this.tableCell21.Weight = 0.071891651626701192D;
            // 
            // tableCell22
            // 
            this.tableCell22.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[TDS_Amt]")});
            this.tableCell22.Name = "tableCell22";
            this.tableCell22.StyleName = "DetailData1";
            this.tableCell22.StylePriority.UseTextAlignment = false;
            this.tableCell22.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableCell22.Weight = 0.085681751137574674D;
            // 
            // tableCell23
            // 
            this.tableCell23.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Surcharge_Amt]")});
            this.tableCell23.Name = "tableCell23";
            this.tableCell23.StyleName = "DetailData1";
            this.tableCell23.StylePriority.UseTextAlignment = false;
            this.tableCell23.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableCell23.Weight = 0.078112633623082822D;
            // 
            // tableCell24
            // 
            this.tableCell24.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[ECess_Amt]")});
            this.tableCell24.Font = new System.Drawing.Font("Arial", 9F);
            this.tableCell24.Name = "tableCell24";
            this.tableCell24.StyleName = "DetailData1";
            this.tableCell24.StylePriority.UseFont = false;
            this.tableCell24.StylePriority.UseTextAlignment = false;
            this.tableCell24.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableCell24.Weight = 0.060043360177688194D;
            // 
            // xrTableCell2
            // 
            this.xrTableCell2.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[TotalTaxdeposited]")});
            this.xrTableCell2.Multiline = true;
            this.xrTableCell2.Name = "xrTableCell2";
            this.xrTableCell2.StyleName = "DetailData1";
            this.xrTableCell2.StylePriority.UseTextAlignment = false;
            this.xrTableCell2.Text = "xrTableCell2";
            this.xrTableCell2.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.xrTableCell2.Weight = 0.096070556997048778D;
            // 
            // tableCell25
            // 
            this.tableCell25.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[TotalTaxdeposited]")});
            this.tableCell25.Name = "tableCell25";
            this.tableCell25.StyleName = "DetailData1";
            this.tableCell25.StylePriority.UseTextAlignment = false;
            this.tableCell25.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableCell25.Weight = 0.076569749802562481D;
            // 
            // tableCell26
            // 
            this.tableCell26.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[dateofdeduction]")});
            this.tableCell26.Name = "tableCell26";
            this.tableCell26.StyleName = "DetailData1";
            this.tableCell26.Weight = 0.0928832029359842D;
            // 
            // tableCell27
            // 
            this.tableCell27.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[TDS_Percentage]")});
            this.tableCell27.Name = "tableCell27";
            this.tableCell27.StyleName = "DetailData1";
            this.tableCell27.Weight = 0.058167054938911104D;
            // 
            // tableCell28
            // 
            this.tableCell28.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Section]")});
            this.tableCell28.Name = "tableCell28";
            this.tableCell28.StyleName = "DetailData1";
            this.tableCell28.Weight = 0.057013914298084424D;
            // 
            // ReportFooter
            // 
            this.ReportFooter.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrLabel37,
            this.xrLabel36,
            this.xrLabel35,
            this.xrLabel34,
            this.xrLabel33,
            this.xrLabel10,
            this.xrLabel9,
            this.xrLabel8,
            this.xrLabel7,
            this.xrLabel6,
            this.xrLabel5,
            this.xrLabel4,
            this.xrLabel3,
            this.xrLabel2,
            this.xrLabel1});
            this.ReportFooter.HeightF = 265.125F;
            this.ReportFooter.Name = "ReportFooter";
            // 
            // xrLabel37
            // 
            this.xrLabel37.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?R_Name")});
            this.xrLabel37.Font = new System.Drawing.Font("Arial", 8F, System.Drawing.FontStyle.Underline);
            this.xrLabel37.LocationFloat = new DevExpress.Utils.PointFloat(14.58334F, 22.99999F);
            this.xrLabel37.Multiline = true;
            this.xrLabel37.Name = "xrLabel37";
            this.xrLabel37.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel37.SizeF = new System.Drawing.SizeF(289.0734F, 23F);
            this.xrLabel37.StylePriority.UseFont = false;
            this.xrLabel37.Text = "xrLabel37";
            // 
            // xrLabel36
            // 
            this.xrLabel36.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?R_Name")});
            this.xrLabel36.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel36.LocationFloat = new DevExpress.Utils.PointFloat(303.6567F, 109.875F);
            this.xrLabel36.Multiline = true;
            this.xrLabel36.Name = "xrLabel36";
            this.xrLabel36.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel36.SizeF = new System.Drawing.SizeF(553.8612F, 23F);
            this.xrLabel36.StylePriority.UseFont = false;
            this.xrLabel36.Text = "xrLabel36";
            // 
            // xrLabel35
            // 
            this.xrLabel35.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?place")});
            this.xrLabel35.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel35.LocationFloat = new DevExpress.Utils.PointFloat(54.73405F, 108F);
            this.xrLabel35.Multiline = true;
            this.xrLabel35.Name = "xrLabel35";
            this.xrLabel35.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel35.SizeF = new System.Drawing.SizeF(151.0416F, 23.00001F);
            this.xrLabel35.StylePriority.UseFont = false;
            this.xrLabel35.Text = "xrLabel35";
            // 
            // xrLabel34
            // 
            this.xrLabel34.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?ddate")});
            this.xrLabel34.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel34.LocationFloat = new DevExpress.Utils.PointFloat(54.73406F, 131F);
            this.xrLabel34.Multiline = true;
            this.xrLabel34.Name = "xrLabel34";
            this.xrLabel34.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel34.SizeF = new System.Drawing.SizeF(151.0416F, 22.99998F);
            this.xrLabel34.StylePriority.UseFont = false;
            this.xrLabel34.Text = "xrLabel34";
            // 
            // xrLabel33
            // 
            this.xrLabel33.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?R_Designation")});
            this.xrLabel33.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel33.LocationFloat = new DevExpress.Utils.PointFloat(303.6566F, 132.875F);
            this.xrLabel33.Multiline = true;
            this.xrLabel33.Name = "xrLabel33";
            this.xrLabel33.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel33.SizeF = new System.Drawing.SizeF(360.4167F, 23F);
            this.xrLabel33.StylePriority.UseFont = false;
            this.xrLabel33.Text = "xrLabel33";
            // 
            // xrLabel10
            // 
            this.xrLabel10.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel10.LocationFloat = new DevExpress.Utils.PointFloat(0F, 241.1666F);
            this.xrLabel10.Multiline = true;
            this.xrLabel10.Name = "xrLabel10";
            this.xrLabel10.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel10.SizeF = new System.Drawing.SizeF(553.8611F, 23F);
            this.xrLabel10.StylePriority.UseFont = false;
            this.xrLabel10.Text = "Write \"B\" if no deduction is on account of declaration under section 197 A";
            // 
            // xrLabel9
            // 
            this.xrLabel9.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel9.LocationFloat = new DevExpress.Utils.PointFloat(0F, 218.1666F);
            this.xrLabel9.Multiline = true;
            this.xrLabel9.Name = "xrLabel9";
            this.xrLabel9.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel9.SizeF = new System.Drawing.SizeF(613.2361F, 23F);
            this.xrLabel9.StylePriority.UseFont = false;
            this.xrLabel9.Text = "Write \"A\" if \"Lower deduction\" or \"deduction\" is on account of a certification un" +
    "der section 197";
            // 
            // xrLabel8
            // 
            this.xrLabel8.Font = new System.Drawing.Font("Arial", 9.75F, System.Drawing.FontStyle.Bold);
            this.xrLabel8.LocationFloat = new DevExpress.Utils.PointFloat(7.947286E-06F, 195.1666F);
            this.xrLabel8.Multiline = true;
            this.xrLabel8.Name = "xrLabel8";
            this.xrLabel8.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel8.SizeF = new System.Drawing.SizeF(52.02301F, 22.99998F);
            this.xrLabel8.StylePriority.UseFont = false;
            this.xrLabel8.Text = "Note :";
            // 
            // xrLabel7
            // 
            this.xrLabel7.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel7.LocationFloat = new DevExpress.Utils.PointFloat(7.947286E-06F, 131F);
            this.xrLabel7.Multiline = true;
            this.xrLabel7.Name = "xrLabel7";
            this.xrLabel7.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel7.SizeF = new System.Drawing.SizeF(54.73405F, 22.99998F);
            this.xrLabel7.StylePriority.UseFont = false;
            this.xrLabel7.Text = "Date :";
            // 
            // xrLabel6
            // 
            this.xrLabel6.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel6.LocationFloat = new DevExpress.Utils.PointFloat(7.947286E-06F, 108F);
            this.xrLabel6.Multiline = true;
            this.xrLabel6.Name = "xrLabel6";
            this.xrLabel6.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel6.SizeF = new System.Drawing.SizeF(54.73404F, 22.99999F);
            this.xrLabel6.StylePriority.UseFont = false;
            this.xrLabel6.Text = "Place :";
            // 
            // xrLabel5
            // 
            this.xrLabel5.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel5.LocationFloat = new DevExpress.Utils.PointFloat(303.6566F, 155.875F);
            this.xrLabel5.Multiline = true;
            this.xrLabel5.Name = "xrLabel5";
            this.xrLabel5.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel5.SizeF = new System.Drawing.SizeF(553.8611F, 23F);
            this.xrLabel5.StylePriority.UseFont = false;
            this.xrLabel5.Text = "Name and designation of person responsible for deducting tax at source";
            // 
            // xrLabel4
            // 
            this.xrLabel4.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel4.LocationFloat = new DevExpress.Utils.PointFloat(303.6567F, 86.87502F);
            this.xrLabel4.Multiline = true;
            this.xrLabel4.Name = "xrLabel4";
            this.xrLabel4.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel4.SizeF = new System.Drawing.SizeF(553.8611F, 23F);
            this.xrLabel4.StylePriority.UseFont = false;
            this.xrLabel4.Text = "Signature of the person responsible for deducting tax at source";
            // 
            // xrLabel3
            // 
            this.xrLabel3.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel3.LocationFloat = new DevExpress.Utils.PointFloat(303.6567F, 22.99999F);
            this.xrLabel3.Multiline = true;
            this.xrLabel3.Name = "xrLabel3";
            this.xrLabel3.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel3.SizeF = new System.Drawing.SizeF(553.8611F, 23F);
            this.xrLabel3.StylePriority.UseFont = false;
            this.xrLabel3.Text = "hereby certify that all particulars furnished above are correct and complete";
            // 
            // xrLabel2
            // 
            this.xrLabel2.Font = new System.Drawing.Font("Arial", 9F);
            this.xrLabel2.LocationFloat = new DevExpress.Utils.PointFloat(7.947286E-06F, 22.99999F);
            this.xrLabel2.Multiline = true;
            this.xrLabel2.Name = "xrLabel2";
            this.xrLabel2.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel2.SizeF = new System.Drawing.SizeF(14.58333F, 23F);
            this.xrLabel2.StylePriority.UseFont = false;
            this.xrLabel2.Text = "I,";
            // 
            // xrLabel1
            // 
            this.xrLabel1.Font = new System.Drawing.Font("Arial", 10F, System.Drawing.FontStyle.Bold);
            this.xrLabel1.LocationFloat = new DevExpress.Utils.PointFloat(7.947286E-06F, 0F);
            this.xrLabel1.Multiline = true;
            this.xrLabel1.Name = "xrLabel1";
            this.xrLabel1.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel1.SizeF = new System.Drawing.SizeF(624.6667F, 23F);
            this.xrLabel1.StylePriority.UseFont = false;
            this.xrLabel1.StylePriority.UseTextAlignment = false;
            this.xrLabel1.Text = "Verification";
            this.xrLabel1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // Challan_Date
            // 
            this.Challan_Date.Description = "Parameter1";
            this.Challan_Date.Name = "Challan_Date";
            // 
            // Challan_No
            // 
            this.Challan_No.Description = "Parameter1";
            this.Challan_No.Name = "Challan_No";
            // 
            // Interest_Amt
            // 
            this.Interest_Amt.Description = "Parameter1";
            this.Interest_Amt.Name = "Interest_Amt";
            // 
            // TANNo
            // 
            this.TANNo.Description = "Parameter1";
            this.TANNo.Name = "TANNo";
            // 
            // Form_Type
            // 
            this.Form_Type.Description = "Parameter1";
            this.Form_Type.Name = "Form_Type";
            // 
            // R_Designation
            // 
            this.R_Designation.Description = "Parameter1";
            this.R_Designation.Name = "R_Designation";
            // 
            // ddate
            // 
            this.ddate.Description = "Parameter1";
            this.ddate.Name = "ddate";
            // 
            // place
            // 
            this.place.Description = "Parameter1";
            this.place.Name = "place";
            // 
            // R_Name
            // 
            this.R_Name.Description = "Parameter1";
            this.R_Name.Name = "R_Name";
            // 
            // Bank_Bsrcode
            // 
            this.Bank_Bsrcode.Description = "Parameter1";
            this.Bank_Bsrcode.Name = "Bank_Bsrcode";
            // 
            // GroupFooter1
            // 
            this.GroupFooter1.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrLine2,
            this.xrLine1,
            this.xrLabel44,
            this.xrLabel43,
            this.xrLabel42,
            this.xrLabel41,
            this.xrLabel40,
            this.xrLabel38,
            this.xrLabel39});
            this.GroupFooter1.HeightF = 37.49987F;
            this.GroupFooter1.Name = "GroupFooter1";
            // 
            // xrLine2
            // 
            this.xrLine2.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0.0002543131F);
            this.xrLine2.Name = "xrLine2";
            this.xrLine2.SizeF = new System.Drawing.SizeF(1071F, 7.249832F);
            // 
            // xrLine1
            // 
            this.xrLine1.LocationFloat = new DevExpress.Utils.PointFloat(3.973643E-05F, 30.25004F);
            this.xrLine1.Name = "xrLine1";
            this.xrLine1.SizeF = new System.Drawing.SizeF(1071F, 7.24983F);
            // 
            // xrLabel44
            // 
            this.xrLabel44.Font = new System.Drawing.Font("Arial", 9.75F, System.Drawing.FontStyle.Bold);
            this.xrLabel44.LocationFloat = new DevExpress.Utils.PointFloat(3.973643E-05F, 7.250088F);
            this.xrLabel44.Multiline = true;
            this.xrLabel44.Name = "xrLabel44";
            this.xrLabel44.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel44.SizeF = new System.Drawing.SizeF(100F, 23F);
            this.xrLabel44.StylePriority.UseFont = false;
            this.xrLabel44.Text = "Total";
            // 
            // xrLabel43
            // 
            this.xrLabel43.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "sumSum([TotalTaxdeposited])")});
            this.xrLabel43.Font = new System.Drawing.Font("Arial", 8F, System.Drawing.FontStyle.Bold);
            this.xrLabel43.LocationFloat = new DevExpress.Utils.PointFloat(827.5181F, 7.250088F);
            this.xrLabel43.Multiline = true;
            this.xrLabel43.Name = "xrLabel43";
            this.xrLabel43.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel43.SizeF = new System.Drawing.SizeF(65.49921F, 23F);
            this.xrLabel43.StylePriority.UseFont = false;
            this.xrLabel43.StylePriority.UseTextAlignment = false;
            xrSummary2.Running = DevExpress.XtraReports.UI.SummaryRunning.Group;
            this.xrLabel43.Summary = xrSummary2;
            this.xrLabel43.Text = "xrLabel43";
            this.xrLabel43.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // xrLabel42
            // 
            this.xrLabel42.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "sumSum([TotalTaxdeposited])")});
            this.xrLabel42.Font = new System.Drawing.Font("Arial", 9F, System.Drawing.FontStyle.Bold);
            this.xrLabel42.LocationFloat = new DevExpress.Utils.PointFloat(745.3369F, 7.250086F);
            this.xrLabel42.Multiline = true;
            this.xrLabel42.Name = "xrLabel42";
            this.xrLabel42.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel42.SizeF = new System.Drawing.SizeF(82.18097F, 23F);
            this.xrLabel42.StylePriority.UseFont = false;
            this.xrLabel42.StylePriority.UseTextAlignment = false;
            xrSummary3.Running = DevExpress.XtraReports.UI.SummaryRunning.Group;
            this.xrLabel42.Summary = xrSummary3;
            this.xrLabel42.Text = "xrLabel42";
            this.xrLabel42.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // xrLabel41
            // 
            this.xrLabel41.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "sumSum([ECess_Amt])")});
            this.xrLabel41.Font = new System.Drawing.Font("Arial", 9F, System.Drawing.FontStyle.Bold);
            this.xrLabel41.LocationFloat = new DevExpress.Utils.PointFloat(693.9744F, 7.250086F);
            this.xrLabel41.Multiline = true;
            this.xrLabel41.Name = "xrLabel41";
            this.xrLabel41.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel41.SizeF = new System.Drawing.SizeF(51.36249F, 23F);
            this.xrLabel41.StylePriority.UseFont = false;
            this.xrLabel41.StylePriority.UseTextAlignment = false;
            xrSummary4.Running = DevExpress.XtraReports.UI.SummaryRunning.Group;
            this.xrLabel41.Summary = xrSummary4;
            this.xrLabel41.Text = "xrLabel41";
            this.xrLabel41.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // xrLabel40
            // 
            this.xrLabel40.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "sumSum([Surcharge_Amt])")});
            this.xrLabel40.Font = new System.Drawing.Font("Arial", 9F, System.Drawing.FontStyle.Bold);
            this.xrLabel40.LocationFloat = new DevExpress.Utils.PointFloat(627.1552F, 7.250088F);
            this.xrLabel40.Multiline = true;
            this.xrLabel40.Name = "xrLabel40";
            this.xrLabel40.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel40.SizeF = new System.Drawing.SizeF(66.81927F, 23F);
            this.xrLabel40.StylePriority.UseFont = false;
            this.xrLabel40.StylePriority.UseTextAlignment = false;
            xrSummary5.Running = DevExpress.XtraReports.UI.SummaryRunning.Group;
            this.xrLabel40.Summary = xrSummary5;
            this.xrLabel40.Text = "xrLabel40";
            this.xrLabel40.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // xrLabel38
            // 
            this.xrLabel38.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "sumSum([TDS_Amt])")});
            this.xrLabel38.Font = new System.Drawing.Font("Arial", 9F, System.Drawing.FontStyle.Bold);
            this.xrLabel38.LocationFloat = new DevExpress.Utils.PointFloat(553.861F, 7.250088F);
            this.xrLabel38.Multiline = true;
            this.xrLabel38.Name = "xrLabel38";
            this.xrLabel38.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel38.SizeF = new System.Drawing.SizeF(73.29419F, 23F);
            this.xrLabel38.StylePriority.UseFont = false;
            this.xrLabel38.StylePriority.UseTextAlignment = false;
            xrSummary6.Running = DevExpress.XtraReports.UI.SummaryRunning.Group;
            this.xrLabel38.Summary = xrSummary6;
            this.xrLabel38.Text = "xrLabel38";
            this.xrLabel38.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // xrLabel39
            // 
            this.xrLabel39.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "sumSum([Voucher_Amount])")});
            this.xrLabel39.Font = new System.Drawing.Font("Arial", 9F, System.Drawing.FontStyle.Bold);
            this.xrLabel39.LocationFloat = new DevExpress.Utils.PointFloat(408.8651F, 7.250088F);
            this.xrLabel39.Multiline = true;
            this.xrLabel39.Name = "xrLabel39";
            this.xrLabel39.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel39.SizeF = new System.Drawing.SizeF(83.49814F, 23F);
            this.xrLabel39.StylePriority.UseFont = false;
            this.xrLabel39.StylePriority.UseTextAlignment = false;
            xrSummary7.Running = DevExpress.XtraReports.UI.SummaryRunning.Group;
            this.xrLabel39.Summary = xrSummary7;
            this.xrLabel39.Text = "xrLabel39";
            this.xrLabel39.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // Challan_Amount
            // 
            this.Challan_Amount.Description = "Parameter1";
            this.Challan_Amount.Name = "Challan_Amount";
            // 
            // qdate
            // 
            this.qdate.Description = "Parameter1";
            this.qdate.Name = "qdate";
            this.qdate.ValueInfo = "0";
            // 
            // CompanyName
            // 
            this.CompanyName.Description = "Parameter1";
            this.CompanyName.Name = "CompanyName";
            // 
            // TDS_Amount
            // 
            this.TDS_Amount.Description = "Parameter1";
            this.TDS_Amount.Name = "TDS_Amount";
            // 
            // qStartdate
            // 
            this.qStartdate.Description = "Parameter1";
            this.qStartdate.Name = "qStartdate";
            // 
            // totaltax
            // 
            this.totaltax.Description = "Parameter1";
            this.totaltax.Name = "totaltax";
            // 
            // Others_Amount
            // 
            this.Others_Amount.Description = "Parameter1";
            this.Others_Amount.Name = "Others_Amount";
            // 
            // AnnexureReport
            // 
            this.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
            this.TopMargin,
            this.BottomMargin,
            this.ReportHeader,
            this.GroupHeader1,
            this.Detail,
            this.ReportFooter,
            this.GroupFooter1});
            this.ComponentStorage.AddRange(new System.ComponentModel.IComponent[] {
            this.sqlDataSource1});
            this.DataMember = "DT_Annexure";
            this.DataSource = this.sqlDataSource1;
            this.Font = new System.Drawing.Font("Arial", 9.75F);
            this.Landscape = true;
            this.Margins = new System.Drawing.Printing.Margins(17, 12, 0, 25);
            this.PageHeight = 850;
            this.PageWidth = 1100;
            this.Parameters.AddRange(new DevExpress.XtraReports.Parameters.Parameter[] {
            this.Challan_Date,
            this.Challan_No,
            this.Interest_Amt,
            this.Others_Amount,
            this.TANNo,
            this.Form_Type,
            this.R_Designation,
            this.ddate,
            this.place,
            this.R_Name,
            this.Bank_Bsrcode,
            this.Challan_Amount,
            this.qdate,
            this.CompanyName,
            this.TDS_Amount,
            this.totaltax,
            this.qStartdate});
            this.StyleSheet.AddRange(new DevExpress.XtraReports.UI.XRControlStyle[] {
            this.Title,
            this.DetailCaption1,
            this.DetailData1,
            this.DetailData3_Odd,
            this.PageInfo});
            this.Version = "19.1";
            ((System.ComponentModel.ISupportInitialize)(this.table1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.table2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

    }

    #endregion
}
