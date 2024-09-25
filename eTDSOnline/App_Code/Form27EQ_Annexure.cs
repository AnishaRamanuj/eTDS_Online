using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

/// <summary>
/// Summary description for Form27EQ_Annexure
/// </summary>
public class Form27EQ_Annexure : DevExpress.XtraReports.UI.XtraReport
{
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
    private XRLabel xrLabel4;
    private XRLabel xrLabel3;
    private XRLabel xrLabel1;
    private ReportFooterBand ReportFooter;
    private XRLabel xrLabel6;
    private XRLabel xrLabel5;
    private XRLabel xrLabel13;
    private XRLabel xrLabel12;
    private XRLabel xrLabel11;
    private XRLabel xrLabel10;
    private XRLabel xrLabel9;
    private XRLabel xrLabel8;
    private XRLabel xrLabel7;
    private XRLine xrLine1;
    private SubBand SubBand1;
    private XRTable xrTable3;
    private XRTableRow xrTableRow9;
    private XRTableCell xrTableCell17;
    private XRTableRow xrTableRow17;
    private XRTableCell xrTableCell25;
    private XRTableRow xrTableRow10;
    private XRTableCell xrTableCell18;
    private XRTableRow xrTableRow11;
    private XRTableCell xrTableCell19;
    private XRTableRow xrTableRow12;
    private XRTableCell xrTableCell20;
    private XRTableRow xrTableRow13;
    private XRTableCell xrTableCell21;
    private XRTableRow xrTableRow14;
    private XRTableCell xrTableCell22;
    private XRTableRow xrTableRow15;
    private XRTableCell xrTableCell23;
    private XRTableRow xrTableRow16;
    private XRTableCell xrTableCell24;
    private XRTableRow xrTableRow18;
    private XRTableCell xrTableCell26;
    private XRTableRow xrTableRow19;
    private XRTableCell xrTableCell27;
    private XRTableRow xrTableRow23;
    private XRTableCell xrTableCell31;
    private XRTableRow xrTableRow20;
    private XRTableCell xrTableCell28;
    private XRTableRow xrTableRow21;
    private XRTableCell xrTableCell29;
    private XRTableRow xrTableRow24;
    private XRTableCell xrTableCell32;
    private XRTableRow xrTableRow22;
    private XRTableCell xrTableCell30;
    private XRTableRow xrTableRow25;
    private XRTableCell xrTableCell33;
    private XRLabel xrLabel14;
    private SubBand SubBand2;
    private XRTable xrTable4;
    private XRTableRow xrTableRow26;
    private XRTableCell xrTableCell34;
    private XRTableCell xrTableCell35;
    private XRTableCell xrTableCell36;
    private XRTableRow xrTableRow39;
    private XRTableCell xrTableCell73;
    private XRTableCell xrTableCell74;
    private XRTableCell xrTableCell75;
    private XRTableRow xrTableRow38;
    private XRTableCell xrTableCell70;
    private XRTableCell xrTableCell71;
    private XRTableCell xrTableCell72;
    private XRTableRow xrTableRow37;
    private XRTableCell xrTableCell67;
    private XRTableCell xrTableCell68;
    private XRTableCell xrTableCell69;
    private XRTableRow xrTableRow36;
    private XRTableCell xrTableCell64;
    private XRTableCell xrTableCell65;
    private XRTableCell xrTableCell66;
    private XRTableRow xrTableRow35;
    private XRTableCell xrTableCell61;
    private XRTableCell xrTableCell62;
    private XRTableCell xrTableCell63;
    private XRTableRow xrTableRow34;
    private XRTableCell xrTableCell58;
    private XRTableCell xrTableCell59;
    private XRTableCell xrTableCell60;
    private XRTableRow xrTableRow33;
    private XRTableCell xrTableCell55;
    private XRTableCell xrTableCell56;
    private XRTableCell xrTableCell57;
    private XRTableRow xrTableRow32;
    private XRTableCell xrTableCell52;
    private XRTableCell xrTableCell53;
    private XRTableCell xrTableCell54;
    private XRTableRow xrTableRow31;
    private XRTableCell xrTableCell49;
    private XRTableCell xrTableCell50;
    private XRTableCell xrTableCell51;
    private XRTableRow xrTableRow29;
    private XRTableCell xrTableCell43;
    private XRTableCell xrTableCell44;
    private XRTableCell xrTableCell45;
    private XRTableRow xrTableRow30;
    private XRTableCell xrTableCell46;
    private XRTableCell xrTableCell47;
    private XRTableCell xrTableCell48;
    private XRTableRow xrTableRow28;
    private XRTableCell xrTableCell40;
    private XRTableCell xrTableCell41;
    private XRTableCell xrTableCell42;
    private XRTableRow xrTableRow27;
    private XRTableCell xrTableCell37;
    private XRTableCell xrTableCell38;
    private XRTableCell xrTableCell39;
    private XRTableRow xrTableRow40;
    private XRTableCell xrTableCell76;
    private XRTableCell xrTableCell77;
    private XRTableCell xrTableCell78;
    private XRLabel xrLabel16;
    private XRTable xrTable5;
    private XRTableRow xrTableRow41;
    private XRTableCell xrTableCell79;
    private XRTableCell xrTableCell80;
    private XRTableCell xrTableCell81;
    private XRTableRow xrTableRow45;
    private XRTableCell xrTableCell91;
    private XRTableCell xrTableCell92;
    private XRTableCell xrTableCell93;
    private XRTableRow xrTableRow44;
    private XRTableCell xrTableCell88;
    private XRTableCell xrTableCell89;
    private XRTableCell xrTableCell90;
    private XRTableRow xrTableRow42;
    private XRTableCell xrTableCell82;
    private XRTableCell xrTableCell83;
    private XRTableCell xrTableCell84;
    private XRTableRow xrTableRow43;
    private XRTableCell xrTableCell85;
    private XRTableCell xrTableCell86;
    private XRTableCell xrTableCell87;
    private XRLabel xrLabel15;
    private XRTable xrTable1;
    private XRTableRow xrTableRow1;
    private XRTableCell xrTableCell1;
    private XRTableRow xrTableRow2;
    private XRTableCell xrTableCell3;
    private XRTableRow xrTableRow3;
    private XRTableCell xrTableCell5;
    private XRTableCell xrTableCell6;
    private XRTableRow xrTableRow4;
    private XRTableCell xrTableCell7;
    private XRTableCell xrTableCell8;
    private XRTableRow xrTableRow5;
    private XRTableCell xrTableCell9;
    private XRTableCell xrTableCell10;
    private XRTableRow xrTableRow6;
    private XRTableCell xrTableCell11;
    private XRTable xrTable2;
    private XRTableRow xrTableRow7;
    private XRTableCell xrTableCell13;
    private XRTableCell xrTableCell14;
    private XRTableRow xrTableRow8;
    private XRTableCell xrTableCell15;
    private XRTableCell xrTableCell16;
    private XRTableCell xrTableCell2;
    private XRTableCell xrTableCell4;
    private XRTableCell xrTableCell12;
    private XRLabel xrLabel54;
    private XRLabel xrLabel53;
    private XRLabel xrLabel52;
    private XRLabel xrLabel51;
    private DevExpress.XtraReports.Parameters.Parameter Bank_Bsrcode;
    private DevExpress.XtraReports.Parameters.Parameter Challan_Date;
    private DevExpress.XtraReports.Parameters.Parameter Challan_No;
    private DevExpress.XtraReports.Parameters.Parameter Challan_Amount;
    private DevExpress.XtraReports.Parameters.Parameter Interest_Amt;
    private DevExpress.XtraReports.Parameters.Parameter CompanyName;
    private DevExpress.XtraReports.Parameters.Parameter TANNo;
    private DevExpress.XtraReports.Parameters.Parameter Place;
    private DevExpress.XtraReports.Parameters.Parameter R_Name;
    private DevExpress.XtraReports.Parameters.Parameter R_Designation;
    private XRLabel xrLabel57;
    private XRLabel xrLabel56;
    private XRLabel xrLabel55;
    private DevExpress.XtraReports.Parameters.Parameter qsdate;
    private DevExpress.XtraReports.Parameters.Parameter qedate;
    private DevExpress.XtraReports.Parameters.Parameter TDS_Amount;
    private XRLabel xrLabel58;
    private DevExpress.XtraReports.Parameters.Parameter dt;
    private DetailBand Detail;
    private DevExpress.DataAccess.Sql.SqlDataSource sqlDataSource1;
    private GroupHeaderBand GroupHeader1;
    private XRLabel xrLabel34;
    private XRLabel xrLabel33;
    private XRLabel xrLabel32;
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
    private XRLabel xrLabel21;
    private XRLabel xrLabel20;
    private XRLabel xrLabel19;
    private XRLabel xrLabel18;
    private XRLabel xrLabel17;
    private XRLabel xrLabel35;
    private XRLabel xrLabel36;
    private XRLabel xrLabel37;
    private XRLabel xrLabel38;
    private XRLabel xrLabel39;
    private XRLabel xrLabel40;
    private XRLabel xrLabel41;
    private XRLabel xrLabel42;
    private XRLabel xrLabel43;
    private XRLabel xrLabel44;
    private XRLabel xrLabel45;
    private XRLabel xrLabel46;
    private XRLabel xrLabel47;
    private XRLabel xrLabel48;
    private XRLabel xrLabel49;
    private XRLabel xrLabel50;
    private XRLabel xrLabel59;
    private XRLabel xrLabel60;
    private XRLabel xrLabel76;
    private XRLabel xrLabel75;
    private XRLabel xrLabel74;
    private XRLabel xrLabel73;
    private XRLabel xrLabel72;
    private XRLabel xrLabel71;
    private XRLabel xrLabel70;
    private XRLabel xrLabel69;
    private XRLabel xrLabel68;
    private XRLabel xrLabel67;
    private XRLabel xrLabel66;
    private XRLabel xrLabel65;
    private XRLabel xrLabel64;
    private XRLabel xrLabel63;
    private XRLabel xrLabel62;
    private XRLabel xrLabel61;
    private XRLabel xrLabel77;
    private XRLabel xrLabel78;

    //  private DS_Form27EQAnnexureCompany_detailsTableAdapters.Usp_Get_Form27EQ_Annexure_DetailsTableAdapter usp_Get_Form27EQ_Annexure_DetailsTableAdapter1;

    /// <summary>
    /// Required designer variable.
    /// </summary>
    private System.ComponentModel.IContainer components = null;

    public Form27EQ_Annexure()
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
            string resourceFileName = "Form27EQ_Annexure.resx";
            System.Resources.ResourceManager resources = global::Resources.Form27EQ_Annexure.ResourceManager;
            this.components = new System.ComponentModel.Container();
            DevExpress.DataAccess.ConnectionParameters.XmlFileConnectionParameters xmlFileConnectionParameters1 = new DevExpress.DataAccess.ConnectionParameters.XmlFileConnectionParameters();
            DevExpress.DataAccess.Sql.SelectQuery selectQuery1 = new DevExpress.DataAccess.Sql.SelectQuery();
            DevExpress.DataAccess.Sql.Column column1 = new DevExpress.DataAccess.Sql.Column();
            DevExpress.DataAccess.Sql.ColumnExpression columnExpression1 = new DevExpress.DataAccess.Sql.ColumnExpression();
            DevExpress.DataAccess.Sql.Table table1 = new DevExpress.DataAccess.Sql.Table();
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
            DevExpress.DataAccess.Sql.Column column15 = new DevExpress.DataAccess.Sql.Column();
            DevExpress.DataAccess.Sql.ColumnExpression columnExpression15 = new DevExpress.DataAccess.Sql.ColumnExpression();
            DevExpress.DataAccess.Sql.Column column16 = new DevExpress.DataAccess.Sql.Column();
            DevExpress.DataAccess.Sql.ColumnExpression columnExpression16 = new DevExpress.DataAccess.Sql.ColumnExpression();
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
            this.xrLabel57 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel56 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel55 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrTable1 = new DevExpress.XtraReports.UI.XRTable();
            this.xrTableRow1 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell1 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell2 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow2 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell3 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell4 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow3 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell5 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell6 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow4 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell7 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell8 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow5 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell9 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell10 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow6 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell11 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell12 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTable2 = new DevExpress.XtraReports.UI.XRTable();
            this.xrTableRow7 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell13 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell14 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow8 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell15 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell16 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrLabel4 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel3 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel1 = new DevExpress.XtraReports.UI.XRLabel();
            this.ReportFooter = new DevExpress.XtraReports.UI.ReportFooterBand();
            this.xrLabel58 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel54 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel53 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel52 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel51 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLine1 = new DevExpress.XtraReports.UI.XRLine();
            this.xrLabel13 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel12 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel11 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel10 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel9 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel8 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel7 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel6 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel5 = new DevExpress.XtraReports.UI.XRLabel();
            this.SubBand1 = new DevExpress.XtraReports.UI.SubBand();
            this.xrLabel14 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrTable3 = new DevExpress.XtraReports.UI.XRTable();
            this.xrTableRow9 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell17 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow17 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell25 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow10 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell18 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow11 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell19 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow12 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell20 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow13 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell21 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow14 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell22 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow15 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell23 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow16 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell24 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow18 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell26 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow19 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell27 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow23 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell31 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow20 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell28 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow21 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell29 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow24 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell32 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow22 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell30 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow25 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell33 = new DevExpress.XtraReports.UI.XRTableCell();
            this.SubBand2 = new DevExpress.XtraReports.UI.SubBand();
            this.xrLabel16 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrTable5 = new DevExpress.XtraReports.UI.XRTable();
            this.xrTableRow41 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell79 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell80 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell81 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow45 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell91 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell92 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell93 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow44 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell88 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell89 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell90 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow42 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell82 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell83 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell84 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow43 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell85 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell86 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell87 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrLabel15 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrTable4 = new DevExpress.XtraReports.UI.XRTable();
            this.xrTableRow26 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell34 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell35 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell36 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow39 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell73 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell74 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell75 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow38 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell70 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell71 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell72 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow37 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell67 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell68 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell69 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow36 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell64 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell65 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell66 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow35 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell61 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell62 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell63 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow34 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell58 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell59 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell60 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow33 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell55 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell56 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell57 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow32 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell52 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell53 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell54 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow31 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell49 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell50 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell51 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow29 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell43 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell44 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell45 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow30 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell46 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell47 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell48 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow28 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell40 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell41 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell42 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow27 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell37 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell38 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell39 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow40 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell76 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell77 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell78 = new DevExpress.XtraReports.UI.XRTableCell();
            this.Bank_Bsrcode = new DevExpress.XtraReports.Parameters.Parameter();
            this.Challan_Date = new DevExpress.XtraReports.Parameters.Parameter();
            this.Challan_No = new DevExpress.XtraReports.Parameters.Parameter();
            this.Challan_Amount = new DevExpress.XtraReports.Parameters.Parameter();
            this.Interest_Amt = new DevExpress.XtraReports.Parameters.Parameter();
            this.CompanyName = new DevExpress.XtraReports.Parameters.Parameter();
            this.TANNo = new DevExpress.XtraReports.Parameters.Parameter();
            this.Place = new DevExpress.XtraReports.Parameters.Parameter();
            this.R_Name = new DevExpress.XtraReports.Parameters.Parameter();
            this.R_Designation = new DevExpress.XtraReports.Parameters.Parameter();
            this.qsdate = new DevExpress.XtraReports.Parameters.Parameter();
            this.qedate = new DevExpress.XtraReports.Parameters.Parameter();
            this.TDS_Amount = new DevExpress.XtraReports.Parameters.Parameter();
            this.dt = new DevExpress.XtraReports.Parameters.Parameter();
            this.Detail = new DevExpress.XtraReports.UI.DetailBand();
            this.xrLabel78 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel77 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel76 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel75 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel74 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel73 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel72 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel71 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel70 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel69 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel68 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel67 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel66 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel65 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel64 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel63 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel62 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel61 = new DevExpress.XtraReports.UI.XRLabel();
            this.sqlDataSource1 = new DevExpress.DataAccess.Sql.SqlDataSource(this.components);
            this.GroupHeader1 = new DevExpress.XtraReports.UI.GroupHeaderBand();
            this.xrLabel35 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel36 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel37 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel38 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel39 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel40 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel41 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel42 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel43 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel44 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel45 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel46 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel47 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel48 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel49 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel50 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel59 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel60 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel34 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel33 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel32 = new DevExpress.XtraReports.UI.XRLabel();
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
            this.xrLabel21 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel20 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel19 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel18 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel17 = new DevExpress.XtraReports.UI.XRLabel();
            ((System.ComponentModel.ISupportInitialize)(this.xrTable1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.xrTable2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.xrTable3)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.xrTable5)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.xrTable4)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
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
            this.DetailCaption1.BorderColor = System.Drawing.Color.White;
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
            this.TopMargin.HeightF = 5.208333F;
            this.TopMargin.Name = "TopMargin";
            // 
            // BottomMargin
            // 
            this.BottomMargin.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.pageInfo1,
            this.pageInfo2});
            this.BottomMargin.HeightF = 30F;
            this.BottomMargin.Name = "BottomMargin";
            // 
            // pageInfo1
            // 
            this.pageInfo1.LocationFloat = new DevExpress.Utils.PointFloat(6F, 0F);
            this.pageInfo1.Name = "pageInfo1";
            this.pageInfo1.PageInfo = DevExpress.XtraPrinting.PageInfo.DateTime;
            this.pageInfo1.SizeF = new System.Drawing.SizeF(438F, 23F);
            this.pageInfo1.StyleName = "PageInfo";
            // 
            // pageInfo2
            // 
            this.pageInfo2.LocationFloat = new DevExpress.Utils.PointFloat(574.0001F, 0F);
            this.pageInfo2.Name = "pageInfo2";
            this.pageInfo2.SizeF = new System.Drawing.SizeF(438F, 23F);
            this.pageInfo2.StyleName = "PageInfo";
            this.pageInfo2.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            this.pageInfo2.TextFormatString = "Page {0} of {1}";
            // 
            // ReportHeader
            // 
            this.ReportHeader.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrLabel57,
            this.xrLabel56,
            this.xrLabel55,
            this.xrTable1,
            this.xrTable2,
            this.xrLabel4,
            this.xrLabel3,
            this.xrLabel1});
            this.ReportHeader.HeightF = 285F;
            this.ReportHeader.Name = "ReportHeader";
            // 
            // xrLabel57
            // 
            this.xrLabel57.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?qedate")});
            this.xrLabel57.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel57.LocationFloat = new DevExpress.Utils.PointFloat(564.2499F, 23.00002F);
            this.xrLabel57.Multiline = true;
            this.xrLabel57.Name = "xrLabel57";
            this.xrLabel57.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel57.SizeF = new System.Drawing.SizeF(74.99988F, 23F);
            this.xrLabel57.StylePriority.UseFont = false;
            this.xrLabel57.Text = "xrLabel57";
            // 
            // xrLabel56
            // 
            this.xrLabel56.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel56.LocationFloat = new DevExpress.Utils.PointFloat(543.4166F, 23F);
            this.xrLabel56.Multiline = true;
            this.xrLabel56.Name = "xrLabel56";
            this.xrLabel56.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel56.SizeF = new System.Drawing.SizeF(20.83331F, 23F);
            this.xrLabel56.StylePriority.UseFont = false;
            this.xrLabel56.Text = "To";
            // 
            // xrLabel55
            // 
            this.xrLabel55.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?qsdate")});
            this.xrLabel55.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel55.LocationFloat = new DevExpress.Utils.PointFloat(482.9999F, 23.00002F);
            this.xrLabel55.Multiline = true;
            this.xrLabel55.Name = "xrLabel55";
            this.xrLabel55.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel55.SizeF = new System.Drawing.SizeF(60.41669F, 23F);
            this.xrLabel55.StylePriority.UseFont = false;
            this.xrLabel55.Text = "xrLabel55";
            // 
            // xrTable1
            // 
            this.xrTable1.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Double;
            this.xrTable1.Font = new System.Drawing.Font("Arial", 8F);
            this.xrTable1.LocationFloat = new DevExpress.Utils.PointFloat(9.999974F, 84.37502F);
            this.xrTable1.Name = "xrTable1";
            this.xrTable1.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 96F);
            this.xrTable1.Rows.AddRange(new DevExpress.XtraReports.UI.XRTableRow[] {
            this.xrTableRow1,
            this.xrTableRow2,
            this.xrTableRow3,
            this.xrTableRow4,
            this.xrTableRow5,
            this.xrTableRow6});
            this.xrTable1.SizeF = new System.Drawing.SizeF(522.9059F, 169.7917F);
            this.xrTable1.StylePriority.UseBorderDashStyle = false;
            this.xrTable1.StylePriority.UseFont = false;
            // 
            // xrTableRow1
            // 
            this.xrTableRow1.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell1,
            this.xrTableCell2});
            this.xrTableRow1.Name = "xrTableRow1";
            this.xrTableRow1.Weight = 1D;
            // 
            // xrTableCell1
            // 
            this.xrTableCell1.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid;
            this.xrTableCell1.Borders = ((DevExpress.XtraPrinting.BorderSide)((((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrTableCell1.Multiline = true;
            this.xrTableCell1.Name = "xrTableCell1";
            this.xrTableCell1.StylePriority.UseBorderDashStyle = false;
            this.xrTableCell1.StylePriority.UseBorders = false;
            this.xrTableCell1.Text = "BSR Code of branch/Receipt Number of Form No. 24G";
            this.xrTableCell1.Weight = 1.5277407441559698D;
            // 
            // xrTableCell2
            // 
            this.xrTableCell2.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid;
            this.xrTableCell2.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Top | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrTableCell2.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?Bank_Bsrcode")});
            this.xrTableCell2.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrTableCell2.Multiline = true;
            this.xrTableCell2.Name = "xrTableCell2";
            this.xrTableCell2.StylePriority.UseBorderDashStyle = false;
            this.xrTableCell2.StylePriority.UseBorders = false;
            this.xrTableCell2.StylePriority.UseFont = false;
            this.xrTableCell2.Weight = 0.47225925584403D;
            // 
            // xrTableRow2
            // 
            this.xrTableRow2.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell3,
            this.xrTableCell4});
            this.xrTableRow2.Name = "xrTableRow2";
            this.xrTableRow2.Weight = 1D;
            // 
            // xrTableCell3
            // 
            this.xrTableCell3.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid;
            this.xrTableCell3.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrTableCell3.Multiline = true;
            this.xrTableCell3.Name = "xrTableCell3";
            this.xrTableCell3.StylePriority.UseBorderDashStyle = false;
            this.xrTableCell3.StylePriority.UseBorders = false;
            this.xrTableCell3.Text = "Date on which challan deposited/Transfer voucher";
            this.xrTableCell3.Weight = 1.5277407441559698D;
            // 
            // xrTableCell4
            // 
            this.xrTableCell4.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid;
            this.xrTableCell4.Borders = ((DevExpress.XtraPrinting.BorderSide)((DevExpress.XtraPrinting.BorderSide.Right | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrTableCell4.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?Challan_Date")});
            this.xrTableCell4.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrTableCell4.Multiline = true;
            this.xrTableCell4.Name = "xrTableCell4";
            this.xrTableCell4.StylePriority.UseBorderDashStyle = false;
            this.xrTableCell4.StylePriority.UseBorders = false;
            this.xrTableCell4.StylePriority.UseFont = false;
            this.xrTableCell4.Weight = 0.47225925584403D;
            // 
            // xrTableRow3
            // 
            this.xrTableRow3.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell5,
            this.xrTableCell6});
            this.xrTableRow3.Name = "xrTableRow3";
            this.xrTableRow3.Weight = 1D;
            // 
            // xrTableCell5
            // 
            this.xrTableCell5.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid;
            this.xrTableCell5.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrTableCell5.Multiline = true;
            this.xrTableCell5.Name = "xrTableCell5";
            this.xrTableCell5.StylePriority.UseBorderDashStyle = false;
            this.xrTableCell5.StylePriority.UseBorders = false;
            this.xrTableCell5.Text = "Challan Serial Number / DDO Serial No. of form No. 24G";
            this.xrTableCell5.Weight = 1.5277407441559698D;
            // 
            // xrTableCell6
            // 
            this.xrTableCell6.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid;
            this.xrTableCell6.Borders = ((DevExpress.XtraPrinting.BorderSide)((DevExpress.XtraPrinting.BorderSide.Right | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrTableCell6.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?Challan_No")});
            this.xrTableCell6.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrTableCell6.Multiline = true;
            this.xrTableCell6.Name = "xrTableCell6";
            this.xrTableCell6.StylePriority.UseBorderDashStyle = false;
            this.xrTableCell6.StylePriority.UseBorders = false;
            this.xrTableCell6.StylePriority.UseFont = false;
            this.xrTableCell6.Weight = 0.47225925584403D;
            // 
            // xrTableRow4
            // 
            this.xrTableRow4.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell7,
            this.xrTableCell8});
            this.xrTableRow4.Name = "xrTableRow4";
            this.xrTableRow4.Weight = 1D;
            // 
            // xrTableCell7
            // 
            this.xrTableCell7.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid;
            this.xrTableCell7.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrTableCell7.Multiline = true;
            this.xrTableCell7.Name = "xrTableCell7";
            this.xrTableCell7.StylePriority.UseBorderDashStyle = false;
            this.xrTableCell7.StylePriority.UseBorders = false;
            this.xrTableCell7.Text = "Amount as per Challan";
            this.xrTableCell7.Weight = 1.5277407441559698D;
            // 
            // xrTableCell8
            // 
            this.xrTableCell8.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid;
            this.xrTableCell8.Borders = ((DevExpress.XtraPrinting.BorderSide)((DevExpress.XtraPrinting.BorderSide.Right | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrTableCell8.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?Challan_Amount")});
            this.xrTableCell8.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrTableCell8.Multiline = true;
            this.xrTableCell8.Name = "xrTableCell8";
            this.xrTableCell8.StylePriority.UseBorderDashStyle = false;
            this.xrTableCell8.StylePriority.UseBorders = false;
            this.xrTableCell8.StylePriority.UseFont = false;
            this.xrTableCell8.Weight = 0.47225925584403D;
            // 
            // xrTableRow5
            // 
            this.xrTableRow5.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell9,
            this.xrTableCell10});
            this.xrTableRow5.Name = "xrTableRow5";
            this.xrTableRow5.Weight = 1D;
            // 
            // xrTableCell9
            // 
            this.xrTableCell9.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid;
            this.xrTableCell9.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrTableCell9.Multiline = true;
            this.xrTableCell9.Name = "xrTableCell9";
            this.xrTableCell9.StylePriority.UseBorderDashStyle = false;
            this.xrTableCell9.StylePriority.UseBorders = false;
            this.xrTableCell9.Text = "Total TCS to be allocated among deductees as in the vertical total of Col.677";
            this.xrTableCell9.Weight = 1.5277409776020188D;
            // 
            // xrTableCell10
            // 
            this.xrTableCell10.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid;
            this.xrTableCell10.Borders = ((DevExpress.XtraPrinting.BorderSide)((DevExpress.XtraPrinting.BorderSide.Right | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrTableCell10.Font = new System.Drawing.Font("Arial", 8F);
            this.xrTableCell10.Multiline = true;
            this.xrTableCell10.Name = "xrTableCell10";
            this.xrTableCell10.StylePriority.UseBorderDashStyle = false;
            this.xrTableCell10.StylePriority.UseBorders = false;
            this.xrTableCell10.StylePriority.UseFont = false;
            this.xrTableCell10.Weight = 0.47225902239798118D;
            // 
            // xrTableRow6
            // 
            this.xrTableRow6.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell11,
            this.xrTableCell12});
            this.xrTableRow6.Name = "xrTableRow6";
            this.xrTableRow6.Weight = 1D;
            // 
            // xrTableCell11
            // 
            this.xrTableCell11.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid;
            this.xrTableCell11.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrTableCell11.Multiline = true;
            this.xrTableCell11.Name = "xrTableCell11";
            this.xrTableCell11.StylePriority.UseBorderDashStyle = false;
            this.xrTableCell11.StylePriority.UseBorders = false;
            this.xrTableCell11.Text = "Total Interest to be allocated amoung the parties mentioned below ";
            this.xrTableCell11.Weight = 1.5277409776020188D;
            // 
            // xrTableCell12
            // 
            this.xrTableCell12.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid;
            this.xrTableCell12.Borders = ((DevExpress.XtraPrinting.BorderSide)((DevExpress.XtraPrinting.BorderSide.Right | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrTableCell12.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?Interest_Amt")});
            this.xrTableCell12.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrTableCell12.Multiline = true;
            this.xrTableCell12.Name = "xrTableCell12";
            this.xrTableCell12.StylePriority.UseBorderDashStyle = false;
            this.xrTableCell12.StylePriority.UseBorders = false;
            this.xrTableCell12.StylePriority.UseFont = false;
            this.xrTableCell12.Weight = 0.47225902239798118D;
            // 
            // xrTable2
            // 
            this.xrTable2.Font = new System.Drawing.Font("Arial", 8F);
            this.xrTable2.LocationFloat = new DevExpress.Utils.PointFloat(600F, 84.37502F);
            this.xrTable2.Name = "xrTable2";
            this.xrTable2.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 96F);
            this.xrTable2.Rows.AddRange(new DevExpress.XtraReports.UI.XRTableRow[] {
            this.xrTableRow7,
            this.xrTableRow8});
            this.xrTable2.SizeF = new System.Drawing.SizeF(402F, 56.59723F);
            this.xrTable2.StylePriority.UseFont = false;
            // 
            // xrTableRow7
            // 
            this.xrTableRow7.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell13,
            this.xrTableCell14});
            this.xrTableRow7.Name = "xrTableRow7";
            this.xrTableRow7.Weight = 1D;
            // 
            // xrTableCell13
            // 
            this.xrTableCell13.Borders = ((DevExpress.XtraPrinting.BorderSide)((((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrTableCell13.Multiline = true;
            this.xrTableCell13.Name = "xrTableCell13";
            this.xrTableCell13.StylePriority.UseBorders = false;
            this.xrTableCell13.Text = "Name of the Collector";
            this.xrTableCell13.Weight = 0.78233830845771146D;
            // 
            // xrTableCell14
            // 
            this.xrTableCell14.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Top | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrTableCell14.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?CompanyName")});
            this.xrTableCell14.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrTableCell14.Multiline = true;
            this.xrTableCell14.Name = "xrTableCell14";
            this.xrTableCell14.StylePriority.UseBorders = false;
            this.xrTableCell14.StylePriority.UseFont = false;
            this.xrTableCell14.Weight = 1.2176616915422887D;
            // 
            // xrTableRow8
            // 
            this.xrTableRow8.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell15,
            this.xrTableCell16});
            this.xrTableRow8.Name = "xrTableRow8";
            this.xrTableRow8.Weight = 1D;
            // 
            // xrTableCell15
            // 
            this.xrTableCell15.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrTableCell15.Multiline = true;
            this.xrTableCell15.Name = "xrTableCell15";
            this.xrTableCell15.StylePriority.UseBorders = false;
            this.xrTableCell15.Text = "TAN";
            this.xrTableCell15.Weight = 0.78233830845771146D;
            // 
            // xrTableCell16
            // 
            this.xrTableCell16.Borders = ((DevExpress.XtraPrinting.BorderSide)((DevExpress.XtraPrinting.BorderSide.Right | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrTableCell16.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?TANNo")});
            this.xrTableCell16.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrTableCell16.Multiline = true;
            this.xrTableCell16.Name = "xrTableCell16";
            this.xrTableCell16.StylePriority.UseBorders = false;
            this.xrTableCell16.StylePriority.UseFont = false;
            this.xrTableCell16.Weight = 1.2176616915422887D;
            // 
            // xrLabel4
            // 
            this.xrLabel4.Font = new System.Drawing.Font("Arial", 9F);
            this.xrLabel4.LocationFloat = new DevExpress.Utils.PointFloat(639.8864F, 23F);
            this.xrLabel4.Multiline = true;
            this.xrLabel4.Name = "xrLabel4";
            this.xrLabel4.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel4.SizeF = new System.Drawing.SizeF(300.8751F, 23F);
            this.xrLabel4.StylePriority.UseFont = false;
            this.xrLabel4.Text = "(dd/mm/yyyy) and of tax collected at source";
            // 
            // xrLabel3
            // 
            this.xrLabel3.Font = new System.Drawing.Font("Arial", 9F);
            this.xrLabel3.LocationFloat = new DevExpress.Utils.PointFloat(181.8748F, 23F);
            this.xrLabel3.Multiline = true;
            this.xrLabel3.Name = "xrLabel3";
            this.xrLabel3.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel3.SizeF = new System.Drawing.SizeF(301.1251F, 23F);
            this.xrLabel3.StylePriority.UseFont = false;
            this.xrLabel3.Text = "Details of amount received/debited during the quarter  ";
            // 
            // xrLabel1
            // 
            this.xrLabel1.Font = new System.Drawing.Font("Arial", 10F, System.Drawing.FontStyle.Bold);
            this.xrLabel1.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.xrLabel1.Multiline = true;
            this.xrLabel1.Name = "xrLabel1";
            this.xrLabel1.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel1.SizeF = new System.Drawing.SizeF(1012F, 23F);
            this.xrLabel1.StylePriority.UseFont = false;
            this.xrLabel1.StylePriority.UseTextAlignment = false;
            this.xrLabel1.Text = "ANNEXURE : PARTY WISE BREAK UP OD TCS";
            this.xrLabel1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // ReportFooter
            // 
            this.ReportFooter.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrLabel58,
            this.xrLabel54,
            this.xrLabel53,
            this.xrLabel52,
            this.xrLabel51,
            this.xrLine1,
            this.xrLabel13,
            this.xrLabel12,
            this.xrLabel11,
            this.xrLabel10,
            this.xrLabel9,
            this.xrLabel8,
            this.xrLabel7,
            this.xrLabel6,
            this.xrLabel5});
            this.ReportFooter.HeightF = 236.4173F;
            this.ReportFooter.Name = "ReportFooter";
            this.ReportFooter.SubBands.AddRange(new DevExpress.XtraReports.UI.SubBand[] {
            this.SubBand1,
            this.SubBand2});
            // 
            // xrLabel58
            // 
            this.xrLabel58.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?dt")});
            this.xrLabel58.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel58.LocationFloat = new DevExpress.Utils.PointFloat(63.54169F, 81.00008F);
            this.xrLabel58.Multiline = true;
            this.xrLabel58.Name = "xrLabel58";
            this.xrLabel58.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel58.SizeF = new System.Drawing.SizeF(100F, 23F);
            this.xrLabel58.StylePriority.UseFont = false;
            this.xrLabel58.Text = "xrLabel58";
            // 
            // xrLabel54
            // 
            this.xrLabel54.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?R_Name")});
            this.xrLabel54.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel54.LocationFloat = new DevExpress.Utils.PointFloat(539.8864F, 127F);
            this.xrLabel54.Multiline = true;
            this.xrLabel54.Name = "xrLabel54";
            this.xrLabel54.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel54.SizeF = new System.Drawing.SizeF(290.625F, 23F);
            this.xrLabel54.StylePriority.UseFont = false;
            this.xrLabel54.Text = "xrLabel54";
            // 
            // xrLabel53
            // 
            this.xrLabel53.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?R_Designation")});
            this.xrLabel53.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel53.LocationFloat = new DevExpress.Utils.PointFloat(539.8864F, 104.0001F);
            this.xrLabel53.Multiline = true;
            this.xrLabel53.Name = "xrLabel53";
            this.xrLabel53.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel53.SizeF = new System.Drawing.SizeF(290.625F, 23F);
            this.xrLabel53.StylePriority.UseFont = false;
            this.xrLabel53.Text = "xrLabel53";
            // 
            // xrLabel52
            // 
            this.xrLabel52.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?R_Name")});
            this.xrLabel52.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel52.LocationFloat = new DevExpress.Utils.PointFloat(19.79168F, 29F);
            this.xrLabel52.Multiline = true;
            this.xrLabel52.Name = "xrLabel52";
            this.xrLabel52.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel52.SizeF = new System.Drawing.SizeF(172.5833F, 23F);
            this.xrLabel52.StylePriority.UseFont = false;
            this.xrLabel52.Text = "xrLabel52";
            // 
            // xrLabel51
            // 
            this.xrLabel51.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?Place")});
            this.xrLabel51.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel51.LocationFloat = new DevExpress.Utils.PointFloat(63.54168F, 58.00006F);
            this.xrLabel51.Multiline = true;
            this.xrLabel51.Name = "xrLabel51";
            this.xrLabel51.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel51.SizeF = new System.Drawing.SizeF(100F, 23F);
            this.xrLabel51.StylePriority.UseFont = false;
            this.xrLabel51.Text = "xrLabel51";
            // 
            // xrLine1
            // 
            this.xrLine1.LocationFloat = new DevExpress.Utils.PointFloat(0F, 3.791618F);
            this.xrLine1.Name = "xrLine1";
            this.xrLine1.SizeF = new System.Drawing.SizeF(1012F, 2.208392F);
            // 
            // xrLabel13
            // 
            this.xrLabel13.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel13.LocationFloat = new DevExpress.Utils.PointFloat(0F, 184.125F);
            this.xrLabel13.Multiline = true;
            this.xrLabel13.Name = "xrLabel13";
            this.xrLabel13.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel13.SizeF = new System.Drawing.SizeF(803.1856F, 48.37506F);
            this.xrLabel13.StylePriority.UseFont = false;
            this.xrLabel13.Text = resources.GetString("xrLabel13.Text");
            // 
            // xrLabel12
            // 
            this.xrLabel12.Font = new System.Drawing.Font("Arial Narrow", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel12.LocationFloat = new DevExpress.Utils.PointFloat(0F, 154.6667F);
            this.xrLabel12.Multiline = true;
            this.xrLabel12.Name = "xrLabel12";
            this.xrLabel12.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel12.SizeF = new System.Drawing.SizeF(100F, 23F);
            this.xrLabel12.StylePriority.UseFont = false;
            this.xrLabel12.Text = "Notes:";
            // 
            // xrLabel11
            // 
            this.xrLabel11.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel11.LocationFloat = new DevExpress.Utils.PointFloat(539.8864F, 81.00006F);
            this.xrLabel11.Multiline = true;
            this.xrLabel11.Name = "xrLabel11";
            this.xrLabel11.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel11.SizeF = new System.Drawing.SizeF(472.1135F, 23F);
            this.xrLabel11.StylePriority.UseFont = false;
            this.xrLabel11.Text = "Name and designation of the person responsible for collecting tax at source";
            // 
            // xrLabel10
            // 
            this.xrLabel10.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel10.LocationFloat = new DevExpress.Utils.PointFloat(539.8864F, 58.00005F);
            this.xrLabel10.Multiline = true;
            this.xrLabel10.Name = "xrLabel10";
            this.xrLabel10.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel10.SizeF = new System.Drawing.SizeF(472.1136F, 23F);
            this.xrLabel10.StylePriority.UseFont = false;
            this.xrLabel10.Text = "Signature of the person responsible for collecting tax at source_________________" +
    "_____";
            // 
            // xrLabel9
            // 
            this.xrLabel9.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel9.LocationFloat = new DevExpress.Utils.PointFloat(0F, 81.00005F);
            this.xrLabel9.Multiline = true;
            this.xrLabel9.Name = "xrLabel9";
            this.xrLabel9.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel9.SizeF = new System.Drawing.SizeF(63.54167F, 23F);
            this.xrLabel9.StylePriority.UseFont = false;
            this.xrLabel9.Text = "Date :";
            // 
            // xrLabel8
            // 
            this.xrLabel8.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel8.LocationFloat = new DevExpress.Utils.PointFloat(0F, 58.00005F);
            this.xrLabel8.Multiline = true;
            this.xrLabel8.Name = "xrLabel8";
            this.xrLabel8.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel8.SizeF = new System.Drawing.SizeF(63.54167F, 23F);
            this.xrLabel8.StylePriority.UseFont = false;
            this.xrLabel8.Text = "Place :";
            // 
            // xrLabel7
            // 
            this.xrLabel7.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel7.LocationFloat = new DevExpress.Utils.PointFloat(192.375F, 29.00002F);
            this.xrLabel7.Multiline = true;
            this.xrLabel7.Name = "xrLabel7";
            this.xrLabel7.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel7.SizeF = new System.Drawing.SizeF(340.5309F, 23F);
            this.xrLabel7.StylePriority.UseFont = false;
            this.xrLabel7.Text = ",here certify that all the particulars above are correct and complete.";
            // 
            // xrLabel6
            // 
            this.xrLabel6.LocationFloat = new DevExpress.Utils.PointFloat(0F, 29.00002F);
            this.xrLabel6.Multiline = true;
            this.xrLabel6.Name = "xrLabel6";
            this.xrLabel6.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel6.SizeF = new System.Drawing.SizeF(19.79167F, 23F);
            this.xrLabel6.Text = "I,";
            // 
            // xrLabel5
            // 
            this.xrLabel5.Font = new System.Drawing.Font("Arial", 9.75F, System.Drawing.FontStyle.Bold);
            this.xrLabel5.LocationFloat = new DevExpress.Utils.PointFloat(0F, 6F);
            this.xrLabel5.Multiline = true;
            this.xrLabel5.Name = "xrLabel5";
            this.xrLabel5.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel5.SizeF = new System.Drawing.SizeF(1012F, 23F);
            this.xrLabel5.StylePriority.UseFont = false;
            this.xrLabel5.StylePriority.UseTextAlignment = false;
            this.xrLabel5.Text = "Verification";
            this.xrLabel5.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // SubBand1
            // 
            this.SubBand1.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrLabel14,
            this.xrTable3});
            this.SubBand1.HeightF = 460.4162F;
            this.SubBand1.Name = "SubBand1";
            this.SubBand1.PageBreak = DevExpress.XtraReports.UI.PageBreak.BeforeBand;
            // 
            // xrLabel14
            // 
            this.xrLabel14.Font = new System.Drawing.Font("Arial", 9F, System.Drawing.FontStyle.Bold);
            this.xrLabel14.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.xrLabel14.Multiline = true;
            this.xrLabel14.Name = "xrLabel14";
            this.xrLabel14.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel14.SizeF = new System.Drawing.SizeF(464.5833F, 23F);
            this.xrLabel14.StylePriority.UseFont = false;
            this.xrLabel14.Text = "Annexure 1 - Deductor Category";
            // 
            // xrTable3
            // 
            this.xrTable3.Borders = ((DevExpress.XtraPrinting.BorderSide)((((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrTable3.Font = new System.Drawing.Font("Arial", 8F);
            this.xrTable3.LocationFloat = new DevExpress.Utils.PointFloat(0F, 31F);
            this.xrTable3.Name = "xrTable3";
            this.xrTable3.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 96F);
            this.xrTable3.Rows.AddRange(new DevExpress.XtraReports.UI.XRTableRow[] {
            this.xrTableRow9,
            this.xrTableRow17,
            this.xrTableRow10,
            this.xrTableRow11,
            this.xrTableRow12,
            this.xrTableRow13,
            this.xrTableRow14,
            this.xrTableRow15,
            this.xrTableRow16,
            this.xrTableRow18,
            this.xrTableRow19,
            this.xrTableRow23,
            this.xrTableRow20,
            this.xrTableRow21,
            this.xrTableRow24,
            this.xrTableRow22,
            this.xrTableRow25});
            this.xrTable3.SizeF = new System.Drawing.SizeF(672.9167F, 425F);
            this.xrTable3.StylePriority.UseBorders = false;
            this.xrTable3.StylePriority.UseFont = false;
            // 
            // xrTableRow9
            // 
            this.xrTableRow9.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell17});
            this.xrTableRow9.Name = "xrTableRow9";
            this.xrTableRow9.Weight = 1D;
            // 
            // xrTableCell17
            // 
            this.xrTableCell17.Font = new System.Drawing.Font("Arial", 8F, System.Drawing.FontStyle.Bold);
            this.xrTableCell17.Multiline = true;
            this.xrTableCell17.Name = "xrTableCell17";
            this.xrTableCell17.StylePriority.UseFont = false;
            this.xrTableCell17.Text = "Deductor Category";
            this.xrTableCell17.Weight = 1D;
            // 
            // xrTableRow17
            // 
            this.xrTableRow17.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell25});
            this.xrTableRow17.Name = "xrTableRow17";
            this.xrTableRow17.Weight = 1D;
            // 
            // xrTableCell25
            // 
            this.xrTableCell25.Multiline = true;
            this.xrTableCell25.Name = "xrTableCell25";
            this.xrTableCell25.Text = "Central Government";
            this.xrTableCell25.Weight = 1D;
            // 
            // xrTableRow10
            // 
            this.xrTableRow10.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell18});
            this.xrTableRow10.Name = "xrTableRow10";
            this.xrTableRow10.Weight = 1D;
            // 
            // xrTableCell18
            // 
            this.xrTableCell18.Multiline = true;
            this.xrTableCell18.Name = "xrTableCell18";
            this.xrTableCell18.Text = "Body of Individuals";
            this.xrTableCell18.Weight = 1D;
            // 
            // xrTableRow11
            // 
            this.xrTableRow11.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell19});
            this.xrTableRow11.Name = "xrTableRow11";
            this.xrTableRow11.Weight = 1D;
            // 
            // xrTableCell19
            // 
            this.xrTableCell19.Multiline = true;
            this.xrTableCell19.Name = "xrTableCell19";
            this.xrTableCell19.Text = "statutory body (Central Govt.)";
            this.xrTableCell19.Weight = 1D;
            // 
            // xrTableRow12
            // 
            this.xrTableRow12.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell20});
            this.xrTableRow12.Name = "xrTableRow12";
            this.xrTableRow12.Weight = 1D;
            // 
            // xrTableCell20
            // 
            this.xrTableCell20.Multiline = true;
            this.xrTableCell20.Name = "xrTableCell20";
            this.xrTableCell20.Text = "Statutory body (State Govt.)";
            this.xrTableCell20.Weight = 1D;
            // 
            // xrTableRow13
            // 
            this.xrTableRow13.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell21});
            this.xrTableRow13.Name = "xrTableRow13";
            this.xrTableRow13.Weight = 1D;
            // 
            // xrTableCell21
            // 
            this.xrTableCell21.Multiline = true;
            this.xrTableCell21.Name = "xrTableCell21";
            this.xrTableCell21.Text = "firm";
            this.xrTableCell21.Weight = 1D;
            // 
            // xrTableRow14
            // 
            this.xrTableRow14.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell22});
            this.xrTableRow14.Name = "xrTableRow14";
            this.xrTableRow14.Weight = 1D;
            // 
            // xrTableCell22
            // 
            this.xrTableCell22.Multiline = true;
            this.xrTableCell22.Name = "xrTableCell22";
            this.xrTableCell22.Text = "Autonomus body (Central Govt.) ";
            this.xrTableCell22.Weight = 1D;
            // 
            // xrTableRow15
            // 
            this.xrTableRow15.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell23});
            this.xrTableRow15.Name = "xrTableRow15";
            this.xrTableRow15.Weight = 1D;
            // 
            // xrTableCell23
            // 
            this.xrTableCell23.Multiline = true;
            this.xrTableCell23.Name = "xrTableCell23";
            this.xrTableCell23.Text = "Autonomus body (State Govt.)";
            this.xrTableCell23.Weight = 1D;
            // 
            // xrTableRow16
            // 
            this.xrTableRow16.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell24});
            this.xrTableRow16.Name = "xrTableRow16";
            this.xrTableRow16.Weight = 1D;
            // 
            // xrTableCell24
            // 
            this.xrTableCell24.Multiline = true;
            this.xrTableCell24.Name = "xrTableCell24";
            this.xrTableCell24.Text = "Artificial Jurdical Person";
            this.xrTableCell24.Weight = 1D;
            // 
            // xrTableRow18
            // 
            this.xrTableRow18.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell26});
            this.xrTableRow18.Name = "xrTableRow18";
            this.xrTableRow18.Weight = 1D;
            // 
            // xrTableCell26
            // 
            this.xrTableCell26.Multiline = true;
            this.xrTableCell26.Name = "xrTableCell26";
            this.xrTableCell26.Text = "Company";
            this.xrTableCell26.Weight = 1D;
            // 
            // xrTableRow19
            // 
            this.xrTableRow19.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell27});
            this.xrTableRow19.Name = "xrTableRow19";
            this.xrTableRow19.Weight = 1D;
            // 
            // xrTableCell27
            // 
            this.xrTableCell27.Multiline = true;
            this.xrTableCell27.Name = "xrTableCell27";
            this.xrTableCell27.Text = "Local Authority (Central Govt.)";
            this.xrTableCell27.Weight = 1D;
            // 
            // xrTableRow23
            // 
            this.xrTableRow23.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell31});
            this.xrTableRow23.Name = "xrTableRow23";
            this.xrTableRow23.Weight = 1D;
            // 
            // xrTableCell31
            // 
            this.xrTableCell31.Multiline = true;
            this.xrTableCell31.Name = "xrTableCell31";
            this.xrTableCell31.Text = "Branch / Division of Company";
            this.xrTableCell31.Weight = 1D;
            // 
            // xrTableRow20
            // 
            this.xrTableRow20.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell28});
            this.xrTableRow20.Name = "xrTableRow20";
            this.xrTableRow20.Weight = 1D;
            // 
            // xrTableCell28
            // 
            this.xrTableCell28.Multiline = true;
            this.xrTableCell28.Name = "xrTableCell28";
            this.xrTableCell28.Text = "Local Authority(State Govt.)";
            this.xrTableCell28.Weight = 1D;
            // 
            // xrTableRow21
            // 
            this.xrTableRow21.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell29});
            this.xrTableRow21.Name = "xrTableRow21";
            this.xrTableRow21.Weight = 1D;
            // 
            // xrTableCell29
            // 
            this.xrTableCell29.Multiline = true;
            this.xrTableCell29.Name = "xrTableCell29";
            this.xrTableCell29.Text = "Association of Person (AOP)";
            this.xrTableCell29.Weight = 1D;
            // 
            // xrTableRow24
            // 
            this.xrTableRow24.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell32});
            this.xrTableRow24.Name = "xrTableRow24";
            this.xrTableRow24.Weight = 1D;
            // 
            // xrTableCell32
            // 
            this.xrTableCell32.Multiline = true;
            this.xrTableCell32.Name = "xrTableCell32";
            this.xrTableCell32.Text = "Individual/HUF";
            this.xrTableCell32.Weight = 1D;
            // 
            // xrTableRow22
            // 
            this.xrTableRow22.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell30});
            this.xrTableRow22.Name = "xrTableRow22";
            this.xrTableRow22.Weight = 1D;
            // 
            // xrTableCell30
            // 
            this.xrTableCell30.Multiline = true;
            this.xrTableCell30.Name = "xrTableCell30";
            this.xrTableCell30.Text = "State Government";
            this.xrTableCell30.Weight = 1D;
            // 
            // xrTableRow25
            // 
            this.xrTableRow25.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell33});
            this.xrTableRow25.Name = "xrTableRow25";
            this.xrTableRow25.Weight = 1D;
            // 
            // xrTableCell33
            // 
            this.xrTableCell33.Multiline = true;
            this.xrTableCell33.Name = "xrTableCell33";
            this.xrTableCell33.Text = "Association of Person (Trust)";
            this.xrTableCell33.Weight = 1D;
            // 
            // SubBand2
            // 
            this.SubBand2.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrLabel16,
            this.xrTable5,
            this.xrLabel15,
            this.xrTable4});
            this.SubBand2.HeightF = 612.5F;
            this.SubBand2.Name = "SubBand2";
            this.SubBand2.PageBreak = DevExpress.XtraReports.UI.PageBreak.BeforeBand;
            // 
            // xrLabel16
            // 
            this.xrLabel16.Font = new System.Drawing.Font("Arial", 9F, System.Drawing.FontStyle.Bold);
            this.xrLabel16.LocationFloat = new DevExpress.Utils.PointFloat(0F, 428.0833F);
            this.xrLabel16.Multiline = true;
            this.xrLabel16.Name = "xrLabel16";
            this.xrLabel16.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel16.SizeF = new System.Drawing.SizeF(627.0833F, 23F);
            this.xrLabel16.StylePriority.UseFont = false;
            this.xrLabel16.Text = "Annexure 3 - Remarks for lower / no /higher deduction";
            // 
            // xrTable5
            // 
            this.xrTable5.Borders = ((DevExpress.XtraPrinting.BorderSide)((((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrTable5.Font = new System.Drawing.Font("Arial", 8F);
            this.xrTable5.LocationFloat = new DevExpress.Utils.PointFloat(0F, 456.0833F);
            this.xrTable5.Name = "xrTable5";
            this.xrTable5.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 96F);
            this.xrTable5.Rows.AddRange(new DevExpress.XtraReports.UI.XRTableRow[] {
            this.xrTableRow41,
            this.xrTableRow45,
            this.xrTableRow44,
            this.xrTableRow42,
            this.xrTableRow43});
            this.xrTable5.SizeF = new System.Drawing.SizeF(757.25F, 124.9999F);
            this.xrTable5.StylePriority.UseBorders = false;
            this.xrTable5.StylePriority.UseFont = false;
            // 
            // xrTableRow41
            // 
            this.xrTableRow41.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell79,
            this.xrTableCell80,
            this.xrTableCell81});
            this.xrTableRow41.Name = "xrTableRow41";
            this.xrTableRow41.Weight = 1D;
            // 
            // xrTableCell79
            // 
            this.xrTableCell79.Borders = ((DevExpress.XtraPrinting.BorderSide)((((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrTableCell79.Font = new System.Drawing.Font("Arial", 8F, System.Drawing.FontStyle.Bold);
            this.xrTableCell79.Multiline = true;
            this.xrTableCell79.Name = "xrTableCell79";
            this.xrTableCell79.StylePriority.UseBorders = false;
            this.xrTableCell79.StylePriority.UseFont = false;
            this.xrTableCell79.Text = "Particulars ";
            this.xrTableCell79.Weight = 1.6220495375755717D;
            // 
            // xrTableCell80
            // 
            this.xrTableCell80.Font = new System.Drawing.Font("Arial", 8F, System.Drawing.FontStyle.Bold);
            this.xrTableCell80.Multiline = true;
            this.xrTableCell80.Name = "xrTableCell80";
            this.xrTableCell80.StylePriority.UseFont = false;
            this.xrTableCell80.Text = "Code";
            this.xrTableCell80.Weight = 0.37795046242442842D;
            // 
            // xrTableCell81
            // 
            this.xrTableCell81.Font = new System.Drawing.Font("Arial", 8F, System.Drawing.FontStyle.Bold);
            this.xrTableCell81.Multiline = true;
            this.xrTableCell81.Name = "xrTableCell81";
            this.xrTableCell81.StylePriority.UseFont = false;
            this.xrTableCell81.Text = "Whether PAN mandatory";
            this.xrTableCell81.Weight = 1D;
            // 
            // xrTableRow45
            // 
            this.xrTableRow45.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell91,
            this.xrTableCell92,
            this.xrTableCell93});
            this.xrTableRow45.Name = "xrTableRow45";
            this.xrTableRow45.Weight = 1D;
            // 
            // xrTableCell91
            // 
            this.xrTableCell91.Multiline = true;
            this.xrTableCell91.Name = "xrTableCell91";
            this.xrTableCell91.Text = "Normal";
            this.xrTableCell91.Weight = 1.6220495375755717D;
            // 
            // xrTableCell92
            // 
            this.xrTableCell92.Multiline = true;
            this.xrTableCell92.Name = "xrTableCell92";
            this.xrTableCell92.Weight = 0.37795046242442842D;
            // 
            // xrTableCell93
            // 
            this.xrTableCell93.Multiline = true;
            this.xrTableCell93.Name = "xrTableCell93";
            this.xrTableCell93.Text = "Yes";
            this.xrTableCell93.Weight = 1D;
            // 
            // xrTableRow44
            // 
            this.xrTableRow44.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell88,
            this.xrTableCell89,
            this.xrTableCell90});
            this.xrTableRow44.Name = "xrTableRow44";
            this.xrTableRow44.Weight = 1D;
            // 
            // xrTableCell88
            // 
            this.xrTableCell88.Multiline = true;
            this.xrTableCell88.Name = "xrTableCell88";
            this.xrTableCell88.Text = "Lower collection u/s 206C (9)";
            this.xrTableCell88.Weight = 1.6220495375755717D;
            // 
            // xrTableCell89
            // 
            this.xrTableCell89.Multiline = true;
            this.xrTableCell89.Name = "xrTableCell89";
            this.xrTableCell89.Text = "A";
            this.xrTableCell89.Weight = 0.37795046242442842D;
            // 
            // xrTableCell90
            // 
            this.xrTableCell90.Multiline = true;
            this.xrTableCell90.Name = "xrTableCell90";
            this.xrTableCell90.Text = "Yes";
            this.xrTableCell90.Weight = 1D;
            // 
            // xrTableRow42
            // 
            this.xrTableRow42.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell82,
            this.xrTableCell83,
            this.xrTableCell84});
            this.xrTableRow42.Name = "xrTableRow42";
            this.xrTableRow42.Weight = 1D;
            // 
            // xrTableCell82
            // 
            this.xrTableCell82.Multiline = true;
            this.xrTableCell82.Name = "xrTableCell82";
            this.xrTableCell82.Text = "Non Collection u/s 206C (1A)";
            this.xrTableCell82.Weight = 1.6220495375755717D;
            // 
            // xrTableCell83
            // 
            this.xrTableCell83.Multiline = true;
            this.xrTableCell83.Name = "xrTableCell83";
            this.xrTableCell83.Text = "B";
            this.xrTableCell83.Weight = 0.37795046242442842D;
            // 
            // xrTableCell84
            // 
            this.xrTableCell84.Multiline = true;
            this.xrTableCell84.Name = "xrTableCell84";
            this.xrTableCell84.Text = "Yes";
            this.xrTableCell84.Weight = 1D;
            // 
            // xrTableRow43
            // 
            this.xrTableRow43.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell85,
            this.xrTableCell86,
            this.xrTableCell87});
            this.xrTableRow43.Name = "xrTableRow43";
            this.xrTableRow43.Weight = 1D;
            // 
            // xrTableCell85
            // 
            this.xrTableCell85.Multiline = true;
            this.xrTableCell85.Name = "xrTableCell85";
            this.xrTableCell85.Text = "Higher Rate (Valid PAN not available)";
            this.xrTableCell85.Weight = 1.6220495375755717D;
            // 
            // xrTableCell86
            // 
            this.xrTableCell86.Multiline = true;
            this.xrTableCell86.Name = "xrTableCell86";
            this.xrTableCell86.Text = "C";
            this.xrTableCell86.Weight = 0.37795046242442842D;
            // 
            // xrTableCell87
            // 
            this.xrTableCell87.Multiline = true;
            this.xrTableCell87.Name = "xrTableCell87";
            this.xrTableCell87.Text = "No";
            this.xrTableCell87.Weight = 1D;
            // 
            // xrLabel15
            // 
            this.xrLabel15.Font = new System.Drawing.Font("Arial", 9F, System.Drawing.FontStyle.Bold);
            this.xrLabel15.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.xrLabel15.Multiline = true;
            this.xrLabel15.Name = "xrLabel15";
            this.xrLabel15.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel15.SizeF = new System.Drawing.SizeF(605.2083F, 23F);
            this.xrLabel15.StylePriority.UseFont = false;
            this.xrLabel15.Text = "Annexure 2 - section Code";
            // 
            // xrTable4
            // 
            this.xrTable4.Borders = ((DevExpress.XtraPrinting.BorderSide)((((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrTable4.Font = new System.Drawing.Font("Arial", 8F);
            this.xrTable4.LocationFloat = new DevExpress.Utils.PointFloat(0F, 29F);
            this.xrTable4.Name = "xrTable4";
            this.xrTable4.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 96F);
            this.xrTable4.Rows.AddRange(new DevExpress.XtraReports.UI.XRTableRow[] {
            this.xrTableRow26,
            this.xrTableRow39,
            this.xrTableRow38,
            this.xrTableRow37,
            this.xrTableRow36,
            this.xrTableRow35,
            this.xrTableRow34,
            this.xrTableRow33,
            this.xrTableRow32,
            this.xrTableRow31,
            this.xrTableRow29,
            this.xrTableRow30,
            this.xrTableRow28,
            this.xrTableRow27,
            this.xrTableRow40});
            this.xrTable4.SizeF = new System.Drawing.SizeF(747.25F, 375F);
            this.xrTable4.StylePriority.UseBorders = false;
            this.xrTable4.StylePriority.UseFont = false;
            // 
            // xrTableRow26
            // 
            this.xrTableRow26.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell34,
            this.xrTableCell35,
            this.xrTableCell36});
            this.xrTableRow26.Name = "xrTableRow26";
            this.xrTableRow26.Weight = 1D;
            // 
            // xrTableCell34
            // 
            this.xrTableCell34.Font = new System.Drawing.Font("Arial", 8F, System.Drawing.FontStyle.Bold);
            this.xrTableCell34.Multiline = true;
            this.xrTableCell34.Name = "xrTableCell34";
            this.xrTableCell34.StylePriority.UseFont = false;
            this.xrTableCell34.Text = "Section";
            this.xrTableCell34.Weight = 0.33490504371116514D;
            // 
            // xrTableCell35
            // 
            this.xrTableCell35.Font = new System.Drawing.Font("Arial", 8F, System.Drawing.FontStyle.Bold);
            this.xrTableCell35.Multiline = true;
            this.xrTableCell35.Name = "xrTableCell35";
            this.xrTableCell35.StylePriority.UseFont = false;
            this.xrTableCell35.Text = "Nature of Payment";
            this.xrTableCell35.Weight = 1.6650949562888349D;
            // 
            // xrTableCell36
            // 
            this.xrTableCell36.Font = new System.Drawing.Font("Arial", 8F, System.Drawing.FontStyle.Bold);
            this.xrTableCell36.Multiline = true;
            this.xrTableCell36.Name = "xrTableCell36";
            this.xrTableCell36.StylePriority.UseFont = false;
            this.xrTableCell36.Text = "Section Code";
            this.xrTableCell36.Weight = 0.35030785660656838D;
            // 
            // xrTableRow39
            // 
            this.xrTableRow39.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell73,
            this.xrTableCell74,
            this.xrTableCell75});
            this.xrTableRow39.Name = "xrTableRow39";
            this.xrTableRow39.Weight = 1D;
            // 
            // xrTableCell73
            // 
            this.xrTableCell73.Multiline = true;
            this.xrTableCell73.Name = "xrTableCell73";
            this.xrTableCell73.Text = "206CA";
            this.xrTableCell73.Weight = 0.33490504371116514D;
            // 
            // xrTableCell74
            // 
            this.xrTableCell74.Multiline = true;
            this.xrTableCell74.Name = "xrTableCell74";
            this.xrTableCell74.Text = "Alcholic liquid for human consumption & Tendu Leaves";
            this.xrTableCell74.Weight = 1.6650949562888349D;
            // 
            // xrTableCell75
            // 
            this.xrTableCell75.Multiline = true;
            this.xrTableCell75.Name = "xrTableCell75";
            this.xrTableCell75.Text = "A";
            this.xrTableCell75.Weight = 0.35030785660656838D;
            // 
            // xrTableRow38
            // 
            this.xrTableRow38.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell70,
            this.xrTableCell71,
            this.xrTableCell72});
            this.xrTableRow38.Name = "xrTableRow38";
            this.xrTableRow38.Weight = 1D;
            // 
            // xrTableCell70
            // 
            this.xrTableCell70.Multiline = true;
            this.xrTableCell70.Name = "xrTableCell70";
            this.xrTableCell70.Text = "206CB";
            this.xrTableCell70.Weight = 0.33490504371116514D;
            // 
            // xrTableCell71
            // 
            this.xrTableCell71.Multiline = true;
            this.xrTableCell71.Name = "xrTableCell71";
            this.xrTableCell71.Text = "Timber optained under a forest leave";
            this.xrTableCell71.Weight = 1.6650949562888349D;
            // 
            // xrTableCell72
            // 
            this.xrTableCell72.Multiline = true;
            this.xrTableCell72.Name = "xrTableCell72";
            this.xrTableCell72.Text = "B";
            this.xrTableCell72.Weight = 0.35030785660656838D;
            // 
            // xrTableRow37
            // 
            this.xrTableRow37.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell67,
            this.xrTableCell68,
            this.xrTableCell69});
            this.xrTableRow37.Name = "xrTableRow37";
            this.xrTableRow37.Weight = 1D;
            // 
            // xrTableCell67
            // 
            this.xrTableCell67.Multiline = true;
            this.xrTableCell67.Name = "xrTableCell67";
            this.xrTableCell67.Text = "206CC";
            this.xrTableCell67.Weight = 0.33490504371116514D;
            // 
            // xrTableCell68
            // 
            this.xrTableCell68.Multiline = true;
            this.xrTableCell68.Name = "xrTableCell68";
            this.xrTableCell68.Text = "Timber obtained under any other mode other than forest leave";
            this.xrTableCell68.Weight = 1.6650949562888349D;
            // 
            // xrTableCell69
            // 
            this.xrTableCell69.Multiline = true;
            this.xrTableCell69.Name = "xrTableCell69";
            this.xrTableCell69.Text = "C";
            this.xrTableCell69.Weight = 0.35030785660656838D;
            // 
            // xrTableRow36
            // 
            this.xrTableRow36.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell64,
            this.xrTableCell65,
            this.xrTableCell66});
            this.xrTableRow36.Name = "xrTableRow36";
            this.xrTableRow36.Weight = 1D;
            // 
            // xrTableCell64
            // 
            this.xrTableCell64.Multiline = true;
            this.xrTableCell64.Name = "xrTableCell64";
            this.xrTableCell64.Text = "206CD";
            this.xrTableCell64.Weight = 0.33490504371116514D;
            // 
            // xrTableCell65
            // 
            this.xrTableCell65.Multiline = true;
            this.xrTableCell65.Name = "xrTableCell65";
            this.xrTableCell65.Text = "Any other forest product not being timber or tendu leaves";
            this.xrTableCell65.Weight = 1.6650949562888349D;
            // 
            // xrTableCell66
            // 
            this.xrTableCell66.Multiline = true;
            this.xrTableCell66.Name = "xrTableCell66";
            this.xrTableCell66.Text = "D";
            this.xrTableCell66.Weight = 0.35030785660656838D;
            // 
            // xrTableRow35
            // 
            this.xrTableRow35.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell61,
            this.xrTableCell62,
            this.xrTableCell63});
            this.xrTableRow35.Name = "xrTableRow35";
            this.xrTableRow35.Weight = 1D;
            // 
            // xrTableCell61
            // 
            this.xrTableCell61.Multiline = true;
            this.xrTableCell61.Name = "xrTableCell61";
            this.xrTableCell61.Text = "206CE";
            this.xrTableCell61.Weight = 0.33490504371116514D;
            // 
            // xrTableCell62
            // 
            this.xrTableCell62.Multiline = true;
            this.xrTableCell62.Name = "xrTableCell62";
            this.xrTableCell62.Text = "Scrap";
            this.xrTableCell62.Weight = 1.6650949562888349D;
            // 
            // xrTableCell63
            // 
            this.xrTableCell63.Multiline = true;
            this.xrTableCell63.Name = "xrTableCell63";
            this.xrTableCell63.Text = "E";
            this.xrTableCell63.Weight = 0.35030785660656838D;
            // 
            // xrTableRow34
            // 
            this.xrTableRow34.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell58,
            this.xrTableCell59,
            this.xrTableCell60});
            this.xrTableRow34.Name = "xrTableRow34";
            this.xrTableRow34.Weight = 1D;
            // 
            // xrTableCell58
            // 
            this.xrTableCell58.Multiline = true;
            this.xrTableCell58.Name = "xrTableCell58";
            this.xrTableCell58.Text = "206CF";
            this.xrTableCell58.Weight = 0.33490504371116514D;
            // 
            // xrTableCell59
            // 
            this.xrTableCell59.Multiline = true;
            this.xrTableCell59.Name = "xrTableCell59";
            this.xrTableCell59.Text = "Parking lot ";
            this.xrTableCell59.Weight = 1.6650949562888349D;
            // 
            // xrTableCell60
            // 
            this.xrTableCell60.Multiline = true;
            this.xrTableCell60.Name = "xrTableCell60";
            this.xrTableCell60.Text = "F";
            this.xrTableCell60.Weight = 0.35030785660656838D;
            // 
            // xrTableRow33
            // 
            this.xrTableRow33.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell55,
            this.xrTableCell56,
            this.xrTableCell57});
            this.xrTableRow33.Name = "xrTableRow33";
            this.xrTableRow33.Weight = 1D;
            // 
            // xrTableCell55
            // 
            this.xrTableCell55.Multiline = true;
            this.xrTableCell55.Name = "xrTableCell55";
            this.xrTableCell55.Text = "206CG\t";
            this.xrTableCell55.Weight = 0.33490504371116514D;
            // 
            // xrTableCell56
            // 
            this.xrTableCell56.Multiline = true;
            this.xrTableCell56.Name = "xrTableCell56";
            this.xrTableCell56.Text = "Toll Plaza ";
            this.xrTableCell56.Weight = 1.6650949562888349D;
            // 
            // xrTableCell57
            // 
            this.xrTableCell57.Multiline = true;
            this.xrTableCell57.Name = "xrTableCell57";
            this.xrTableCell57.Text = "G";
            this.xrTableCell57.Weight = 0.35030785660656838D;
            // 
            // xrTableRow32
            // 
            this.xrTableRow32.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell52,
            this.xrTableCell53,
            this.xrTableCell54});
            this.xrTableRow32.Name = "xrTableRow32";
            this.xrTableRow32.Weight = 1D;
            // 
            // xrTableCell52
            // 
            this.xrTableCell52.Multiline = true;
            this.xrTableCell52.Name = "xrTableCell52";
            this.xrTableCell52.Text = "206CH";
            this.xrTableCell52.Weight = 0.33490504371116514D;
            // 
            // xrTableCell53
            // 
            this.xrTableCell53.Multiline = true;
            this.xrTableCell53.Name = "xrTableCell53";
            this.xrTableCell53.Text = "Mining and quarring ";
            this.xrTableCell53.Weight = 1.6650949562888349D;
            // 
            // xrTableCell54
            // 
            this.xrTableCell54.Multiline = true;
            this.xrTableCell54.Name = "xrTableCell54";
            this.xrTableCell54.Text = "H";
            this.xrTableCell54.Weight = 0.35030785660656838D;
            // 
            // xrTableRow31
            // 
            this.xrTableRow31.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell49,
            this.xrTableCell50,
            this.xrTableCell51});
            this.xrTableRow31.Name = "xrTableRow31";
            this.xrTableRow31.Weight = 1D;
            // 
            // xrTableCell49
            // 
            this.xrTableCell49.Multiline = true;
            this.xrTableCell49.Name = "xrTableCell49";
            this.xrTableCell49.Text = "206CI";
            this.xrTableCell49.Weight = 0.33490504371116514D;
            // 
            // xrTableCell50
            // 
            this.xrTableCell50.Multiline = true;
            this.xrTableCell50.Name = "xrTableCell50";
            this.xrTableCell50.Text = "Tendu Leaves";
            this.xrTableCell50.Weight = 1.6650949562888349D;
            // 
            // xrTableCell51
            // 
            this.xrTableCell51.Multiline = true;
            this.xrTableCell51.Name = "xrTableCell51";
            this.xrTableCell51.Text = "I";
            this.xrTableCell51.Weight = 0.35030785660656838D;
            // 
            // xrTableRow29
            // 
            this.xrTableRow29.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell43,
            this.xrTableCell44,
            this.xrTableCell45});
            this.xrTableRow29.Name = "xrTableRow29";
            this.xrTableRow29.Weight = 1D;
            // 
            // xrTableCell43
            // 
            this.xrTableCell43.Multiline = true;
            this.xrTableCell43.Name = "xrTableCell43";
            this.xrTableCell43.Text = "206CJ";
            this.xrTableCell43.Weight = 0.33490504371116514D;
            // 
            // xrTableCell44
            // 
            this.xrTableCell44.Multiline = true;
            this.xrTableCell44.Name = "xrTableCell44";
            this.xrTableCell44.Text = "Minerals";
            this.xrTableCell44.Weight = 1.6650949562888349D;
            // 
            // xrTableCell45
            // 
            this.xrTableCell45.Multiline = true;
            this.xrTableCell45.Name = "xrTableCell45";
            this.xrTableCell45.Text = "J";
            this.xrTableCell45.Weight = 0.35030785660656838D;
            // 
            // xrTableRow30
            // 
            this.xrTableRow30.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell46,
            this.xrTableCell47,
            this.xrTableCell48});
            this.xrTableRow30.Name = "xrTableRow30";
            this.xrTableRow30.Weight = 1D;
            // 
            // xrTableCell46
            // 
            this.xrTableCell46.Multiline = true;
            this.xrTableCell46.Name = "xrTableCell46";
            this.xrTableCell46.Text = "206CK";
            this.xrTableCell46.Weight = 0.33490504371116514D;
            // 
            // xrTableCell47
            // 
            this.xrTableCell47.Multiline = true;
            this.xrTableCell47.Name = "xrTableCell47";
            this.xrTableCell47.Text = "Bullion and Jewellery";
            this.xrTableCell47.Weight = 1.6650949562888349D;
            // 
            // xrTableCell48
            // 
            this.xrTableCell48.Multiline = true;
            this.xrTableCell48.Name = "xrTableCell48";
            this.xrTableCell48.Text = "K";
            this.xrTableCell48.Weight = 0.35030785660656838D;
            // 
            // xrTableRow28
            // 
            this.xrTableRow28.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell40,
            this.xrTableCell41,
            this.xrTableCell42});
            this.xrTableRow28.Name = "xrTableRow28";
            this.xrTableRow28.Weight = 1D;
            // 
            // xrTableCell40
            // 
            this.xrTableCell40.Multiline = true;
            this.xrTableCell40.Name = "xrTableCell40";
            this.xrTableCell40.Text = "206CL";
            this.xrTableCell40.Weight = 0.33490504371116514D;
            // 
            // xrTableCell41
            // 
            this.xrTableCell41.Multiline = true;
            this.xrTableCell41.Name = "xrTableCell41";
            this.xrTableCell41.Text = "Sale of Motor vehicle";
            this.xrTableCell41.Weight = 1.6650949562888349D;
            // 
            // xrTableCell42
            // 
            this.xrTableCell42.Multiline = true;
            this.xrTableCell42.Name = "xrTableCell42";
            this.xrTableCell42.Text = "L";
            this.xrTableCell42.Weight = 0.35030785660656838D;
            // 
            // xrTableRow27
            // 
            this.xrTableRow27.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell37,
            this.xrTableCell38,
            this.xrTableCell39});
            this.xrTableRow27.Name = "xrTableRow27";
            this.xrTableRow27.Weight = 1D;
            // 
            // xrTableCell37
            // 
            this.xrTableCell37.Multiline = true;
            this.xrTableCell37.Name = "xrTableCell37";
            this.xrTableCell37.Text = "206CM";
            this.xrTableCell37.Weight = 0.33490504371116514D;
            // 
            // xrTableCell38
            // 
            this.xrTableCell38.Multiline = true;
            this.xrTableCell38.Name = "xrTableCell38";
            this.xrTableCell38.Text = "Sale in cash of any goods (Other than bullion)";
            this.xrTableCell38.Weight = 1.6650949562888349D;
            // 
            // xrTableCell39
            // 
            this.xrTableCell39.Multiline = true;
            this.xrTableCell39.Name = "xrTableCell39";
            this.xrTableCell39.Text = " M";
            this.xrTableCell39.Weight = 0.35030785660656838D;
            // 
            // xrTableRow40
            // 
            this.xrTableRow40.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell76,
            this.xrTableCell77,
            this.xrTableCell78});
            this.xrTableRow40.Name = "xrTableRow40";
            this.xrTableRow40.Weight = 1D;
            // 
            // xrTableCell76
            // 
            this.xrTableCell76.Multiline = true;
            this.xrTableCell76.Name = "xrTableCell76";
            this.xrTableCell76.Text = "206CN";
            this.xrTableCell76.Weight = 0.33490504371116514D;
            // 
            // xrTableCell77
            // 
            this.xrTableCell77.Multiline = true;
            this.xrTableCell77.Name = "xrTableCell77";
            this.xrTableCell77.Text = "Providing of any services (Other than Ch-XVII-B)";
            this.xrTableCell77.Weight = 1.6650949562888349D;
            // 
            // xrTableCell78
            // 
            this.xrTableCell78.Multiline = true;
            this.xrTableCell78.Name = "xrTableCell78";
            this.xrTableCell78.Text = "N";
            this.xrTableCell78.Weight = 0.35030785660656838D;
            // 
            // Bank_Bsrcode
            // 
            this.Bank_Bsrcode.Description = "Parameter1";
            this.Bank_Bsrcode.Name = "Bank_Bsrcode";
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
            // Challan_Amount
            // 
            this.Challan_Amount.Description = "Parameter1";
            this.Challan_Amount.Name = "Challan_Amount";
            // 
            // Interest_Amt
            // 
            this.Interest_Amt.Description = "Parameter1";
            this.Interest_Amt.Name = "Interest_Amt";
            // 
            // CompanyName
            // 
            this.CompanyName.Description = "Parameter1";
            this.CompanyName.Name = "CompanyName";
            // 
            // TANNo
            // 
            this.TANNo.Description = "Parameter1";
            this.TANNo.Name = "TANNo";
            // 
            // Place
            // 
            this.Place.Description = "Parameter1";
            this.Place.Name = "Place";
            // 
            // R_Name
            // 
            this.R_Name.Description = "Parameter1";
            this.R_Name.Name = "R_Name";
            // 
            // R_Designation
            // 
            this.R_Designation.Description = "Parameter1";
            this.R_Designation.Name = "R_Designation";
            // 
            // qsdate
            // 
            this.qsdate.Description = "Parameter1";
            this.qsdate.Name = "qsdate";
            // 
            // qedate
            // 
            this.qedate.Description = "Parameter1";
            this.qedate.Name = "qedate";
            // 
            // TDS_Amount
            // 
            this.TDS_Amount.Description = "Parameter1";
            this.TDS_Amount.Name = "TDS_Amount";
            // 
            // dt
            // 
            this.dt.Description = "Parameter1";
            this.dt.Name = "dt";
            // 
            // Detail
            // 
            this.Detail.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrLabel78,
            this.xrLabel77,
            this.xrLabel76,
            this.xrLabel75,
            this.xrLabel74,
            this.xrLabel73,
            this.xrLabel72,
            this.xrLabel71,
            this.xrLabel70,
            this.xrLabel69,
            this.xrLabel68,
            this.xrLabel67,
            this.xrLabel66,
            this.xrLabel65,
            this.xrLabel64,
            this.xrLabel63,
            this.xrLabel62,
            this.xrLabel61});
            this.Detail.Font = new System.Drawing.Font("Arial", 9F);
            this.Detail.HeightF = 23F;
            this.Detail.Name = "Detail";
            this.Detail.StylePriority.UseFont = false;
            // 
            // xrLabel78
            // 
            this.xrLabel78.BorderColor = System.Drawing.Color.Black;
            this.xrLabel78.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel78.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel78.LocationFloat = new DevExpress.Utils.PointFloat(326.75F, 0F);
            this.xrLabel78.Multiline = true;
            this.xrLabel78.Name = "xrLabel78";
            this.xrLabel78.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel78.SizeF = new System.Drawing.SizeF(47.44696F, 23F);
            this.xrLabel78.StylePriority.UseBorderColor = false;
            this.xrLabel78.StylePriority.UseBorders = false;
            this.xrLabel78.StylePriority.UseFont = false;
            // 
            // xrLabel77
            // 
            this.xrLabel77.BorderColor = System.Drawing.Color.Black;
            this.xrLabel77.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel77.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel77.LocationFloat = new DevExpress.Utils.PointFloat(34.3752F, 0F);
            this.xrLabel77.Multiline = true;
            this.xrLabel77.Name = "xrLabel77";
            this.xrLabel77.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel77.SizeF = new System.Drawing.SizeF(55.20815F, 23F);
            this.xrLabel77.StylePriority.UseBorderColor = false;
            this.xrLabel77.StylePriority.UseBorders = false;
            this.xrLabel77.StylePriority.UseFont = false;
            // 
            // xrLabel76
            // 
            this.xrLabel76.BorderColor = System.Drawing.Color.Black;
            this.xrLabel76.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel76.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[TDS_Certificate]")});
            this.xrLabel76.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel76.LocationFloat = new DevExpress.Utils.PointFloat(948.7502F, 0F);
            this.xrLabel76.Multiline = true;
            this.xrLabel76.Name = "xrLabel76";
            this.xrLabel76.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel76.SizeF = new System.Drawing.SizeF(63.24951F, 23F);
            this.xrLabel76.StylePriority.UseBorderColor = false;
            this.xrLabel76.StylePriority.UseBorders = false;
            this.xrLabel76.StylePriority.UseFont = false;
            this.xrLabel76.Text = "xrLabel76";
            // 
            // xrLabel75
            // 
            this.xrLabel75.BorderColor = System.Drawing.Color.Black;
            this.xrLabel75.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel75.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Reason]")});
            this.xrLabel75.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel75.LocationFloat = new DevExpress.Utils.PointFloat(896.9585F, 0F);
            this.xrLabel75.Multiline = true;
            this.xrLabel75.Name = "xrLabel75";
            this.xrLabel75.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel75.SizeF = new System.Drawing.SizeF(51.79169F, 23F);
            this.xrLabel75.StylePriority.UseBorderColor = false;
            this.xrLabel75.StylePriority.UseBorders = false;
            this.xrLabel75.StylePriority.UseFont = false;
            this.xrLabel75.StylePriority.UseTextAlignment = false;
            this.xrLabel75.Text = "xrLabel75";
            this.xrLabel75.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel74
            // 
            this.xrLabel74.BorderColor = System.Drawing.Color.Black;
            this.xrLabel74.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel74.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[sel]")});
            this.xrLabel74.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel74.LocationFloat = new DevExpress.Utils.PointFloat(846.1365F, 0F);
            this.xrLabel74.Multiline = true;
            this.xrLabel74.Name = "xrLabel74";
            this.xrLabel74.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel74.SizeF = new System.Drawing.SizeF(50.82208F, 23F);
            this.xrLabel74.StylePriority.UseBorderColor = false;
            this.xrLabel74.StylePriority.UseBorders = false;
            this.xrLabel74.StylePriority.UseFont = false;
            this.xrLabel74.StylePriority.UseTextAlignment = false;
            this.xrLabel74.Text = "xrLabel74";
            this.xrLabel74.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel73
            // 
            this.xrLabel73.BorderColor = System.Drawing.Color.Black;
            this.xrLabel73.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel73.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Voucher_DT]")});
            this.xrLabel73.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel73.LocationFloat = new DevExpress.Utils.PointFloat(773.2196F, 0F);
            this.xrLabel73.Multiline = true;
            this.xrLabel73.Name = "xrLabel73";
            this.xrLabel73.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel73.SizeF = new System.Drawing.SizeF(72.91687F, 23F);
            this.xrLabel73.StylePriority.UseBorderColor = false;
            this.xrLabel73.StylePriority.UseBorders = false;
            this.xrLabel73.StylePriority.UseFont = false;
            this.xrLabel73.StylePriority.UseTextAlignment = false;
            this.xrLabel73.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel72
            // 
            this.xrLabel72.BorderColor = System.Drawing.Color.Black;
            this.xrLabel72.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel72.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Total_Tax_Amt]")});
            this.xrLabel72.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel72.LocationFloat = new DevExpress.Utils.PointFloat(708.6365F, 0F);
            this.xrLabel72.Multiline = true;
            this.xrLabel72.Name = "xrLabel72";
            this.xrLabel72.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel72.SizeF = new System.Drawing.SizeF(64.58325F, 23F);
            this.xrLabel72.StylePriority.UseBorderColor = false;
            this.xrLabel72.StylePriority.UseBorders = false;
            this.xrLabel72.StylePriority.UseFont = false;
            this.xrLabel72.StylePriority.UseTextAlignment = false;
            this.xrLabel72.Text = "xrLabel72";
            this.xrLabel72.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // xrLabel71
            // 
            this.xrLabel71.BorderColor = System.Drawing.Color.Black;
            this.xrLabel71.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel71.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Total_Tax_Amt]")});
            this.xrLabel71.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel71.LocationFloat = new DevExpress.Utils.PointFloat(652.3866F, 0F);
            this.xrLabel71.Multiline = true;
            this.xrLabel71.Name = "xrLabel71";
            this.xrLabel71.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel71.SizeF = new System.Drawing.SizeF(56.24994F, 23F);
            this.xrLabel71.StylePriority.UseBorderColor = false;
            this.xrLabel71.StylePriority.UseBorders = false;
            this.xrLabel71.StylePriority.UseFont = false;
            this.xrLabel71.StylePriority.UseTextAlignment = false;
            this.xrLabel71.Text = "xrLabel71";
            this.xrLabel71.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // xrLabel70
            // 
            this.xrLabel70.BorderColor = System.Drawing.Color.Black;
            this.xrLabel70.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel70.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[ECess_Amt]")});
            this.xrLabel70.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel70.LocationFloat = new DevExpress.Utils.PointFloat(605.9167F, 0F);
            this.xrLabel70.Multiline = true;
            this.xrLabel70.Name = "xrLabel70";
            this.xrLabel70.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel70.SizeF = new System.Drawing.SizeF(46.46985F, 23F);
            this.xrLabel70.StylePriority.UseBorderColor = false;
            this.xrLabel70.StylePriority.UseBorders = false;
            this.xrLabel70.StylePriority.UseFont = false;
            this.xrLabel70.StylePriority.UseTextAlignment = false;
            this.xrLabel70.Text = "xrLabel70";
            this.xrLabel70.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // xrLabel69
            // 
            this.xrLabel69.BorderColor = System.Drawing.Color.Black;
            this.xrLabel69.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel69.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Surcharge_Amt]")});
            this.xrLabel69.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel69.LocationFloat = new DevExpress.Utils.PointFloat(564.2499F, 0F);
            this.xrLabel69.Multiline = true;
            this.xrLabel69.Name = "xrLabel69";
            this.xrLabel69.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel69.SizeF = new System.Drawing.SizeF(41.66687F, 23F);
            this.xrLabel69.StylePriority.UseBorderColor = false;
            this.xrLabel69.StylePriority.UseBorders = false;
            this.xrLabel69.StylePriority.UseFont = false;
            this.xrLabel69.StylePriority.UseTextAlignment = false;
            this.xrLabel69.Text = "xrLabel69";
            this.xrLabel69.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // xrLabel68
            // 
            this.xrLabel68.BorderColor = System.Drawing.Color.Black;
            this.xrLabel68.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel68.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[TDS_Amt]")});
            this.xrLabel68.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel68.LocationFloat = new DevExpress.Utils.PointFloat(519.3643F, 0F);
            this.xrLabel68.Multiline = true;
            this.xrLabel68.Name = "xrLabel68";
            this.xrLabel68.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel68.SizeF = new System.Drawing.SizeF(44.88586F, 23F);
            this.xrLabel68.StylePriority.UseBorderColor = false;
            this.xrLabel68.StylePriority.UseBorders = false;
            this.xrLabel68.StylePriority.UseFont = false;
            this.xrLabel68.StylePriority.UseTextAlignment = false;
            this.xrLabel68.Text = "xrLabel68";
            this.xrLabel68.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // xrLabel67
            // 
            this.xrLabel67.BorderColor = System.Drawing.Color.Black;
            this.xrLabel67.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel67.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Section]")});
            this.xrLabel67.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel67.LocationFloat = new DevExpress.Utils.PointFloat(482.9999F, 0F);
            this.xrLabel67.Multiline = true;
            this.xrLabel67.Name = "xrLabel67";
            this.xrLabel67.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel67.SizeF = new System.Drawing.SizeF(36.36456F, 23F);
            this.xrLabel67.StylePriority.UseBorderColor = false;
            this.xrLabel67.StylePriority.UseBorders = false;
            this.xrLabel67.StylePriority.UseFont = false;
            this.xrLabel67.StylePriority.UseTextAlignment = false;
            this.xrLabel67.Text = "xrLabel67";
            this.xrLabel67.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel66
            // 
            this.xrLabel66.BorderColor = System.Drawing.Color.Black;
            this.xrLabel66.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel66.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Voucher_DT]")});
            this.xrLabel66.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel66.LocationFloat = new DevExpress.Utils.PointFloat(422.1137F, 0F);
            this.xrLabel66.Multiline = true;
            this.xrLabel66.Name = "xrLabel66";
            this.xrLabel66.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel66.SizeF = new System.Drawing.SizeF(60.88651F, 23F);
            this.xrLabel66.StylePriority.UseBorderColor = false;
            this.xrLabel66.StylePriority.UseBorders = false;
            this.xrLabel66.StylePriority.UseFont = false;
            this.xrLabel66.StylePriority.UseTextAlignment = false;
            this.xrLabel66.Text = "xrLabel66";
            this.xrLabel66.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel65
            // 
            this.xrLabel65.BorderColor = System.Drawing.Color.Black;
            this.xrLabel65.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel65.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Voucher_Amount]")});
            this.xrLabel65.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel65.LocationFloat = new DevExpress.Utils.PointFloat(374.1968F, 0F);
            this.xrLabel65.Multiline = true;
            this.xrLabel65.Name = "xrLabel65";
            this.xrLabel65.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel65.SizeF = new System.Drawing.SizeF(47.91687F, 23F);
            this.xrLabel65.StylePriority.UseBorderColor = false;
            this.xrLabel65.StylePriority.UseBorders = false;
            this.xrLabel65.StylePriority.UseFont = false;
            this.xrLabel65.StylePriority.UseTextAlignment = false;
            this.xrLabel65.Text = "xrLabel65";
            this.xrLabel65.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // xrLabel64
            // 
            this.xrLabel64.BorderColor = System.Drawing.Color.Black;
            this.xrLabel64.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel64.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Deductee_Name]")});
            this.xrLabel64.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel64.LocationFloat = new DevExpress.Utils.PointFloat(226.75F, 0F);
            this.xrLabel64.Multiline = true;
            this.xrLabel64.Name = "xrLabel64";
            this.xrLabel64.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel64.SizeF = new System.Drawing.SizeF(100F, 23F);
            this.xrLabel64.StylePriority.UseBorderColor = false;
            this.xrLabel64.StylePriority.UseBorders = false;
            this.xrLabel64.StylePriority.UseFont = false;
            this.xrLabel64.Text = "xrLabel64";
            // 
            // xrLabel63
            // 
            this.xrLabel63.BorderColor = System.Drawing.Color.Black;
            this.xrLabel63.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel63.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[PAN_NO]")});
            this.xrLabel63.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel63.LocationFloat = new DevExpress.Utils.PointFloat(142.7085F, 0F);
            this.xrLabel63.Multiline = true;
            this.xrLabel63.Name = "xrLabel63";
            this.xrLabel63.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel63.SizeF = new System.Drawing.SizeF(84.04169F, 23F);
            this.xrLabel63.StylePriority.UseBorderColor = false;
            this.xrLabel63.StylePriority.UseBorders = false;
            this.xrLabel63.StylePriority.UseFont = false;
            this.xrLabel63.Text = "xrLabel63";
            // 
            // xrLabel62
            // 
            this.xrLabel62.BorderColor = System.Drawing.Color.Black;
            this.xrLabel62.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel62.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Deductee_Type]")});
            this.xrLabel62.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel62.LocationFloat = new DevExpress.Utils.PointFloat(89.58334F, 0F);
            this.xrLabel62.Multiline = true;
            this.xrLabel62.Name = "xrLabel62";
            this.xrLabel62.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel62.SizeF = new System.Drawing.SizeF(53.12515F, 23F);
            this.xrLabel62.StylePriority.UseBorderColor = false;
            this.xrLabel62.StylePriority.UseBorders = false;
            this.xrLabel62.StylePriority.UseFont = false;
            this.xrLabel62.Text = "xrLabel62";
            // 
            // xrLabel61
            // 
            this.xrLabel61.BorderColor = System.Drawing.Color.Black;
            this.xrLabel61.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel61.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[srno]")});
            this.xrLabel61.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel61.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.xrLabel61.Multiline = true;
            this.xrLabel61.Name = "xrLabel61";
            this.xrLabel61.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel61.SizeF = new System.Drawing.SizeF(34.37518F, 23F);
            this.xrLabel61.StylePriority.UseBorderColor = false;
            this.xrLabel61.StylePriority.UseBorders = false;
            this.xrLabel61.StylePriority.UseFont = false;
            this.xrLabel61.Text = "xrLabel61";
            // 
            // sqlDataSource1
            // 
            this.sqlDataSource1.ConnectionName = "DS_Form27EQAnnexure_Voucherdetails";
            xmlFileConnectionParameters1.FileName = "D:\\OnlineTds_Reports\\eTDSOnline\\App_Code\\DS_Form27EQAnnexure_Voucherdetails.xsd";
            this.sqlDataSource1.ConnectionParameters = xmlFileConnectionParameters1;
            this.sqlDataSource1.Name = "sqlDataSource1";
            columnExpression1.ColumnName = "srno";
            table1.Name = "DT_DS_Form27EQAnnexure_Voucherdetails";
            columnExpression1.Table = table1;
            column1.Expression = columnExpression1;
            columnExpression2.ColumnName = "Deductee_Type";
            columnExpression2.Table = table1;
            column2.Expression = columnExpression2;
            columnExpression3.ColumnName = "PAN_NO";
            columnExpression3.Table = table1;
            column3.Expression = columnExpression3;
            columnExpression4.ColumnName = "Deductee_Name";
            columnExpression4.Table = table1;
            column4.Expression = columnExpression4;
            columnExpression5.ColumnName = "Voucher_Amount";
            columnExpression5.Table = table1;
            column5.Expression = columnExpression5;
            columnExpression6.ColumnName = "Voucher_DT";
            columnExpression6.Table = table1;
            column6.Expression = columnExpression6;
            columnExpression7.ColumnName = "Section";
            columnExpression7.Table = table1;
            column7.Expression = columnExpression7;
            columnExpression8.ColumnName = "TDS_Amt";
            columnExpression8.Table = table1;
            column8.Expression = columnExpression8;
            columnExpression9.ColumnName = "Surcharge_Amt";
            columnExpression9.Table = table1;
            column9.Expression = columnExpression9;
            columnExpression10.ColumnName = "ECess_Amt";
            columnExpression10.Table = table1;
            column10.Expression = columnExpression10;
            columnExpression11.ColumnName = "Total_Tax_Amt";
            columnExpression11.Table = table1;
            column11.Expression = columnExpression11;
            columnExpression12.ColumnName = "ttdeposited";
            columnExpression12.Table = table1;
            column12.Expression = columnExpression12;
            columnExpression13.ColumnName = "dateofcollection";
            columnExpression13.Table = table1;
            column13.Expression = columnExpression13;
            columnExpression14.ColumnName = "sel";
            columnExpression14.Table = table1;
            column14.Expression = columnExpression14;
            columnExpression15.ColumnName = "Reason";
            columnExpression15.Table = table1;
            column15.Expression = columnExpression15;
            columnExpression16.ColumnName = "TDS_Certificate";
            columnExpression16.Table = table1;
            column16.Expression = columnExpression16;
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
            selectQuery1.Columns.Add(column15);
            selectQuery1.Columns.Add(column16);
            selectQuery1.Name = "DT_DS_Form27EQAnnexure_Voucherdetails";
            selectQuery1.Tables.Add(table1);
            this.sqlDataSource1.Queries.AddRange(new DevExpress.DataAccess.Sql.SqlQuery[] {
            selectQuery1});
            this.sqlDataSource1.ResultSchemaSerializable = resources.GetString("sqlDataSource1.ResultSchemaSerializable");
            // 
            // GroupHeader1
            // 
            this.GroupHeader1.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrLabel35,
            this.xrLabel36,
            this.xrLabel37,
            this.xrLabel38,
            this.xrLabel39,
            this.xrLabel40,
            this.xrLabel41,
            this.xrLabel42,
            this.xrLabel43,
            this.xrLabel44,
            this.xrLabel45,
            this.xrLabel46,
            this.xrLabel47,
            this.xrLabel48,
            this.xrLabel49,
            this.xrLabel50,
            this.xrLabel59,
            this.xrLabel60,
            this.xrLabel34,
            this.xrLabel33,
            this.xrLabel32,
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
            this.xrLabel21,
            this.xrLabel20,
            this.xrLabel19,
            this.xrLabel18,
            this.xrLabel17});
            this.GroupHeader1.HeightF = 46.66672F;
            this.GroupHeader1.KeepTogether = true;
            this.GroupHeader1.Name = "GroupHeader1";
            this.GroupHeader1.RepeatEveryPage = true;
            // 
            // xrLabel35
            // 
            this.xrLabel35.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel35.BorderColor = System.Drawing.Color.Black;
            this.xrLabel35.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.xrLabel35.BorderWidth = 1F;
            this.xrLabel35.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel35.ForeColor = System.Drawing.Color.Black;
            this.xrLabel35.LocationFloat = new DevExpress.Utils.PointFloat(0.0001831055F, 23F);
            this.xrLabel35.Multiline = true;
            this.xrLabel35.Name = "xrLabel35";
            this.xrLabel35.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel35.SizeF = new System.Drawing.SizeF(34.375F, 23F);
            this.xrLabel35.StylePriority.UseBackColor = false;
            this.xrLabel35.StylePriority.UseBorderColor = false;
            this.xrLabel35.StylePriority.UseBorders = false;
            this.xrLabel35.StylePriority.UseBorderWidth = false;
            this.xrLabel35.StylePriority.UseFont = false;
            this.xrLabel35.StylePriority.UseForeColor = false;
            this.xrLabel35.StylePriority.UseTextAlignment = false;
            this.xrLabel35.Text = "[664]";
            this.xrLabel35.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel36
            // 
            this.xrLabel36.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel36.BorderColor = System.Drawing.Color.Black;
            this.xrLabel36.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.xrLabel36.BorderWidth = 1F;
            this.xrLabel36.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel36.ForeColor = System.Drawing.Color.Black;
            this.xrLabel36.LocationFloat = new DevExpress.Utils.PointFloat(34.37518F, 22.99999F);
            this.xrLabel36.Multiline = true;
            this.xrLabel36.Name = "xrLabel36";
            this.xrLabel36.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel36.SizeF = new System.Drawing.SizeF(55.20816F, 23F);
            this.xrLabel36.StylePriority.UseBackColor = false;
            this.xrLabel36.StylePriority.UseBorderColor = false;
            this.xrLabel36.StylePriority.UseBorders = false;
            this.xrLabel36.StylePriority.UseBorderWidth = false;
            this.xrLabel36.StylePriority.UseFont = false;
            this.xrLabel36.StylePriority.UseForeColor = false;
            this.xrLabel36.StylePriority.UseTextAlignment = false;
            this.xrLabel36.Text = "[665]";
            this.xrLabel36.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel37
            // 
            this.xrLabel37.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel37.BorderColor = System.Drawing.Color.Black;
            this.xrLabel37.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.xrLabel37.BorderWidth = 1F;
            this.xrLabel37.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel37.ForeColor = System.Drawing.Color.Black;
            this.xrLabel37.LocationFloat = new DevExpress.Utils.PointFloat(89.58334F, 22.99999F);
            this.xrLabel37.Multiline = true;
            this.xrLabel37.Name = "xrLabel37";
            this.xrLabel37.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel37.SizeF = new System.Drawing.SizeF(53.12512F, 23F);
            this.xrLabel37.StylePriority.UseBackColor = false;
            this.xrLabel37.StylePriority.UseBorderColor = false;
            this.xrLabel37.StylePriority.UseBorders = false;
            this.xrLabel37.StylePriority.UseBorderWidth = false;
            this.xrLabel37.StylePriority.UseFont = false;
            this.xrLabel37.StylePriority.UseForeColor = false;
            this.xrLabel37.StylePriority.UseTextAlignment = false;
            this.xrLabel37.Text = "[666]";
            this.xrLabel37.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel38
            // 
            this.xrLabel38.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel38.BorderColor = System.Drawing.Color.Black;
            this.xrLabel38.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.xrLabel38.BorderWidth = 1F;
            this.xrLabel38.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel38.ForeColor = System.Drawing.Color.Black;
            this.xrLabel38.LocationFloat = new DevExpress.Utils.PointFloat(142.8751F, 23F);
            this.xrLabel38.Multiline = true;
            this.xrLabel38.Name = "xrLabel38";
            this.xrLabel38.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel38.SizeF = new System.Drawing.SizeF(83.87512F, 23F);
            this.xrLabel38.StylePriority.UseBackColor = false;
            this.xrLabel38.StylePriority.UseBorderColor = false;
            this.xrLabel38.StylePriority.UseBorders = false;
            this.xrLabel38.StylePriority.UseBorderWidth = false;
            this.xrLabel38.StylePriority.UseFont = false;
            this.xrLabel38.StylePriority.UseForeColor = false;
            this.xrLabel38.StylePriority.UseTextAlignment = false;
            this.xrLabel38.Text = "[667]";
            this.xrLabel38.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel39
            // 
            this.xrLabel39.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel39.BorderColor = System.Drawing.Color.Black;
            this.xrLabel39.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.xrLabel39.BorderWidth = 1F;
            this.xrLabel39.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel39.ForeColor = System.Drawing.Color.Black;
            this.xrLabel39.LocationFloat = new DevExpress.Utils.PointFloat(226.7502F, 23F);
            this.xrLabel39.Multiline = true;
            this.xrLabel39.Name = "xrLabel39";
            this.xrLabel39.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel39.SizeF = new System.Drawing.SizeF(103.0417F, 23F);
            this.xrLabel39.StylePriority.UseBackColor = false;
            this.xrLabel39.StylePriority.UseBorderColor = false;
            this.xrLabel39.StylePriority.UseBorders = false;
            this.xrLabel39.StylePriority.UseBorderWidth = false;
            this.xrLabel39.StylePriority.UseFont = false;
            this.xrLabel39.StylePriority.UseForeColor = false;
            this.xrLabel39.StylePriority.UseTextAlignment = false;
            this.xrLabel39.Text = "[668]";
            this.xrLabel39.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel40
            // 
            this.xrLabel40.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel40.BorderColor = System.Drawing.Color.Black;
            this.xrLabel40.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.xrLabel40.BorderWidth = 1F;
            this.xrLabel40.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel40.ForeColor = System.Drawing.Color.Black;
            this.xrLabel40.LocationFloat = new DevExpress.Utils.PointFloat(329.7919F, 23F);
            this.xrLabel40.Multiline = true;
            this.xrLabel40.Name = "xrLabel40";
            this.xrLabel40.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel40.SizeF = new System.Drawing.SizeF(44.40509F, 23F);
            this.xrLabel40.StylePriority.UseBackColor = false;
            this.xrLabel40.StylePriority.UseBorderColor = false;
            this.xrLabel40.StylePriority.UseBorders = false;
            this.xrLabel40.StylePriority.UseBorderWidth = false;
            this.xrLabel40.StylePriority.UseFont = false;
            this.xrLabel40.StylePriority.UseForeColor = false;
            this.xrLabel40.StylePriority.UseTextAlignment = false;
            this.xrLabel40.Text = "[669]";
            this.xrLabel40.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel41
            // 
            this.xrLabel41.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel41.BorderColor = System.Drawing.Color.Black;
            this.xrLabel41.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.xrLabel41.BorderWidth = 1F;
            this.xrLabel41.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel41.ForeColor = System.Drawing.Color.Black;
            this.xrLabel41.LocationFloat = new DevExpress.Utils.PointFloat(374.197F, 23F);
            this.xrLabel41.Multiline = true;
            this.xrLabel41.Name = "xrLabel41";
            this.xrLabel41.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel41.SizeF = new System.Drawing.SizeF(47.91669F, 23F);
            this.xrLabel41.StylePriority.UseBackColor = false;
            this.xrLabel41.StylePriority.UseBorderColor = false;
            this.xrLabel41.StylePriority.UseBorders = false;
            this.xrLabel41.StylePriority.UseBorderWidth = false;
            this.xrLabel41.StylePriority.UseFont = false;
            this.xrLabel41.StylePriority.UseForeColor = false;
            this.xrLabel41.StylePriority.UseTextAlignment = false;
            this.xrLabel41.Text = "[670]";
            this.xrLabel41.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel42
            // 
            this.xrLabel42.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel42.BorderColor = System.Drawing.Color.Black;
            this.xrLabel42.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.xrLabel42.BorderWidth = 1F;
            this.xrLabel42.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel42.ForeColor = System.Drawing.Color.Black;
            this.xrLabel42.LocationFloat = new DevExpress.Utils.PointFloat(422.1137F, 23F);
            this.xrLabel42.Multiline = true;
            this.xrLabel42.Name = "xrLabel42";
            this.xrLabel42.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel42.SizeF = new System.Drawing.SizeF(60.88651F, 23F);
            this.xrLabel42.StylePriority.UseBackColor = false;
            this.xrLabel42.StylePriority.UseBorderColor = false;
            this.xrLabel42.StylePriority.UseBorders = false;
            this.xrLabel42.StylePriority.UseBorderWidth = false;
            this.xrLabel42.StylePriority.UseFont = false;
            this.xrLabel42.StylePriority.UseForeColor = false;
            this.xrLabel42.StylePriority.UseTextAlignment = false;
            this.xrLabel42.Text = "[671]";
            this.xrLabel42.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel43
            // 
            this.xrLabel43.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel43.BorderColor = System.Drawing.Color.Black;
            this.xrLabel43.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.xrLabel43.BorderWidth = 1F;
            this.xrLabel43.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel43.ForeColor = System.Drawing.Color.Black;
            this.xrLabel43.LocationFloat = new DevExpress.Utils.PointFloat(483.0002F, 23F);
            this.xrLabel43.Multiline = true;
            this.xrLabel43.Name = "xrLabel43";
            this.xrLabel43.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel43.SizeF = new System.Drawing.SizeF(36.36426F, 23F);
            this.xrLabel43.StylePriority.UseBackColor = false;
            this.xrLabel43.StylePriority.UseBorderColor = false;
            this.xrLabel43.StylePriority.UseBorders = false;
            this.xrLabel43.StylePriority.UseBorderWidth = false;
            this.xrLabel43.StylePriority.UseFont = false;
            this.xrLabel43.StylePriority.UseForeColor = false;
            this.xrLabel43.StylePriority.UseTextAlignment = false;
            this.xrLabel43.Text = "[672]";
            this.xrLabel43.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel44
            // 
            this.xrLabel44.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel44.BorderColor = System.Drawing.Color.Black;
            this.xrLabel44.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.xrLabel44.BorderWidth = 1F;
            this.xrLabel44.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel44.ForeColor = System.Drawing.Color.Black;
            this.xrLabel44.LocationFloat = new DevExpress.Utils.PointFloat(519.3644F, 23F);
            this.xrLabel44.Multiline = true;
            this.xrLabel44.Name = "xrLabel44";
            this.xrLabel44.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel44.SizeF = new System.Drawing.SizeF(44.88568F, 23F);
            this.xrLabel44.StylePriority.UseBackColor = false;
            this.xrLabel44.StylePriority.UseBorderColor = false;
            this.xrLabel44.StylePriority.UseBorders = false;
            this.xrLabel44.StylePriority.UseBorderWidth = false;
            this.xrLabel44.StylePriority.UseFont = false;
            this.xrLabel44.StylePriority.UseForeColor = false;
            this.xrLabel44.StylePriority.UseTextAlignment = false;
            this.xrLabel44.Text = "[673]";
            this.xrLabel44.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel45
            // 
            this.xrLabel45.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel45.BorderColor = System.Drawing.Color.Black;
            this.xrLabel45.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.xrLabel45.BorderWidth = 1F;
            this.xrLabel45.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel45.ForeColor = System.Drawing.Color.Black;
            this.xrLabel45.LocationFloat = new DevExpress.Utils.PointFloat(564.2501F, 23F);
            this.xrLabel45.Multiline = true;
            this.xrLabel45.Name = "xrLabel45";
            this.xrLabel45.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel45.SizeF = new System.Drawing.SizeF(41.66666F, 23F);
            this.xrLabel45.StylePriority.UseBackColor = false;
            this.xrLabel45.StylePriority.UseBorderColor = false;
            this.xrLabel45.StylePriority.UseBorders = false;
            this.xrLabel45.StylePriority.UseBorderWidth = false;
            this.xrLabel45.StylePriority.UseFont = false;
            this.xrLabel45.StylePriority.UseForeColor = false;
            this.xrLabel45.StylePriority.UseTextAlignment = false;
            this.xrLabel45.Text = "[674]";
            this.xrLabel45.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel46
            // 
            this.xrLabel46.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel46.BorderColor = System.Drawing.Color.Black;
            this.xrLabel46.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.xrLabel46.BorderWidth = 1F;
            this.xrLabel46.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel46.ForeColor = System.Drawing.Color.Black;
            this.xrLabel46.LocationFloat = new DevExpress.Utils.PointFloat(605.9168F, 23F);
            this.xrLabel46.Multiline = true;
            this.xrLabel46.Name = "xrLabel46";
            this.xrLabel46.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel46.SizeF = new System.Drawing.SizeF(46.46979F, 23F);
            this.xrLabel46.StylePriority.UseBackColor = false;
            this.xrLabel46.StylePriority.UseBorderColor = false;
            this.xrLabel46.StylePriority.UseBorders = false;
            this.xrLabel46.StylePriority.UseBorderWidth = false;
            this.xrLabel46.StylePriority.UseFont = false;
            this.xrLabel46.StylePriority.UseForeColor = false;
            this.xrLabel46.StylePriority.UseTextAlignment = false;
            this.xrLabel46.Text = "[675]";
            this.xrLabel46.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel47
            // 
            this.xrLabel47.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel47.BorderColor = System.Drawing.Color.Black;
            this.xrLabel47.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.xrLabel47.BorderWidth = 1F;
            this.xrLabel47.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel47.ForeColor = System.Drawing.Color.Black;
            this.xrLabel47.LocationFloat = new DevExpress.Utils.PointFloat(652.3866F, 23F);
            this.xrLabel47.Multiline = true;
            this.xrLabel47.Name = "xrLabel47";
            this.xrLabel47.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel47.SizeF = new System.Drawing.SizeF(56.24994F, 23F);
            this.xrLabel47.StylePriority.UseBackColor = false;
            this.xrLabel47.StylePriority.UseBorderColor = false;
            this.xrLabel47.StylePriority.UseBorders = false;
            this.xrLabel47.StylePriority.UseBorderWidth = false;
            this.xrLabel47.StylePriority.UseFont = false;
            this.xrLabel47.StylePriority.UseForeColor = false;
            this.xrLabel47.StylePriority.UseTextAlignment = false;
            this.xrLabel47.Text = "[676]";
            this.xrLabel47.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel48
            // 
            this.xrLabel48.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel48.BorderColor = System.Drawing.Color.Black;
            this.xrLabel48.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.xrLabel48.BorderWidth = 1F;
            this.xrLabel48.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel48.ForeColor = System.Drawing.Color.Black;
            this.xrLabel48.LocationFloat = new DevExpress.Utils.PointFloat(708.6365F, 23F);
            this.xrLabel48.Multiline = true;
            this.xrLabel48.Name = "xrLabel48";
            this.xrLabel48.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel48.SizeF = new System.Drawing.SizeF(64.58325F, 23F);
            this.xrLabel48.StylePriority.UseBackColor = false;
            this.xrLabel48.StylePriority.UseBorderColor = false;
            this.xrLabel48.StylePriority.UseBorders = false;
            this.xrLabel48.StylePriority.UseBorderWidth = false;
            this.xrLabel48.StylePriority.UseFont = false;
            this.xrLabel48.StylePriority.UseForeColor = false;
            this.xrLabel48.StylePriority.UseTextAlignment = false;
            this.xrLabel48.Text = "[677]";
            this.xrLabel48.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel49
            // 
            this.xrLabel49.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel49.BorderColor = System.Drawing.Color.Black;
            this.xrLabel49.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.xrLabel49.BorderWidth = 1F;
            this.xrLabel49.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel49.ForeColor = System.Drawing.Color.Black;
            this.xrLabel49.LocationFloat = new DevExpress.Utils.PointFloat(773.2198F, 23F);
            this.xrLabel49.Multiline = true;
            this.xrLabel49.Name = "xrLabel49";
            this.xrLabel49.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel49.SizeF = new System.Drawing.SizeF(72.91669F, 23F);
            this.xrLabel49.StylePriority.UseBackColor = false;
            this.xrLabel49.StylePriority.UseBorderColor = false;
            this.xrLabel49.StylePriority.UseBorders = false;
            this.xrLabel49.StylePriority.UseBorderWidth = false;
            this.xrLabel49.StylePriority.UseFont = false;
            this.xrLabel49.StylePriority.UseForeColor = false;
            this.xrLabel49.StylePriority.UseTextAlignment = false;
            this.xrLabel49.Text = "[678]";
            this.xrLabel49.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel50
            // 
            this.xrLabel50.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel50.BorderColor = System.Drawing.Color.Black;
            this.xrLabel50.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.xrLabel50.BorderWidth = 1F;
            this.xrLabel50.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel50.ForeColor = System.Drawing.Color.Black;
            this.xrLabel50.LocationFloat = new DevExpress.Utils.PointFloat(846.1365F, 23F);
            this.xrLabel50.Multiline = true;
            this.xrLabel50.Name = "xrLabel50";
            this.xrLabel50.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel50.SizeF = new System.Drawing.SizeF(50.82208F, 23F);
            this.xrLabel50.StylePriority.UseBackColor = false;
            this.xrLabel50.StylePriority.UseBorderColor = false;
            this.xrLabel50.StylePriority.UseBorders = false;
            this.xrLabel50.StylePriority.UseBorderWidth = false;
            this.xrLabel50.StylePriority.UseFont = false;
            this.xrLabel50.StylePriority.UseForeColor = false;
            this.xrLabel50.StylePriority.UseTextAlignment = false;
            this.xrLabel50.Text = "[679]";
            this.xrLabel50.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel59
            // 
            this.xrLabel59.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel59.BorderColor = System.Drawing.Color.Black;
            this.xrLabel59.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.xrLabel59.BorderWidth = 1F;
            this.xrLabel59.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel59.ForeColor = System.Drawing.Color.Black;
            this.xrLabel59.LocationFloat = new DevExpress.Utils.PointFloat(896.9587F, 23F);
            this.xrLabel59.Multiline = true;
            this.xrLabel59.Name = "xrLabel59";
            this.xrLabel59.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel59.SizeF = new System.Drawing.SizeF(51.7915F, 23F);
            this.xrLabel59.StylePriority.UseBackColor = false;
            this.xrLabel59.StylePriority.UseBorderColor = false;
            this.xrLabel59.StylePriority.UseBorders = false;
            this.xrLabel59.StylePriority.UseBorderWidth = false;
            this.xrLabel59.StylePriority.UseFont = false;
            this.xrLabel59.StylePriority.UseForeColor = false;
            this.xrLabel59.StylePriority.UseTextAlignment = false;
            this.xrLabel59.Text = "[680]";
            this.xrLabel59.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel60
            // 
            this.xrLabel60.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel60.BorderColor = System.Drawing.Color.Black;
            this.xrLabel60.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.xrLabel60.BorderWidth = 1F;
            this.xrLabel60.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel60.ForeColor = System.Drawing.Color.Black;
            this.xrLabel60.LocationFloat = new DevExpress.Utils.PointFloat(948.7502F, 23F);
            this.xrLabel60.Multiline = true;
            this.xrLabel60.Name = "xrLabel60";
            this.xrLabel60.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel60.SizeF = new System.Drawing.SizeF(63.24982F, 23F);
            this.xrLabel60.StylePriority.UseBackColor = false;
            this.xrLabel60.StylePriority.UseBorderColor = false;
            this.xrLabel60.StylePriority.UseBorders = false;
            this.xrLabel60.StylePriority.UseBorderWidth = false;
            this.xrLabel60.StylePriority.UseFont = false;
            this.xrLabel60.StylePriority.UseForeColor = false;
            this.xrLabel60.StylePriority.UseTextAlignment = false;
            this.xrLabel60.Text = "[681]";
            this.xrLabel60.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel34
            // 
            this.xrLabel34.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel34.BorderColor = System.Drawing.Color.Black;
            this.xrLabel34.Borders = DevExpress.XtraPrinting.BorderSide.Top;
            this.xrLabel34.BorderWidth = 1F;
            this.xrLabel34.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel34.ForeColor = System.Drawing.Color.Black;
            this.xrLabel34.LocationFloat = new DevExpress.Utils.PointFloat(948.75F, 0F);
            this.xrLabel34.Multiline = true;
            this.xrLabel34.Name = "xrLabel34";
            this.xrLabel34.Padding = new DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100F);
            this.xrLabel34.SizeF = new System.Drawing.SizeF(63.24982F, 23F);
            this.xrLabel34.StylePriority.UseBackColor = false;
            this.xrLabel34.StylePriority.UseBorderColor = false;
            this.xrLabel34.StylePriority.UseBorders = false;
            this.xrLabel34.StylePriority.UseBorderWidth = false;
            this.xrLabel34.StylePriority.UseFont = false;
            this.xrLabel34.StylePriority.UseForeColor = false;
            this.xrLabel34.StylePriority.UsePadding = false;
            this.xrLabel34.StylePriority.UseTextAlignment = false;
            this.xrLabel34.Text = "Certificate no\r\n";
            this.xrLabel34.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel33
            // 
            this.xrLabel33.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel33.BorderColor = System.Drawing.Color.Black;
            this.xrLabel33.Borders = DevExpress.XtraPrinting.BorderSide.Top;
            this.xrLabel33.BorderWidth = 1F;
            this.xrLabel33.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel33.ForeColor = System.Drawing.Color.Black;
            this.xrLabel33.LocationFloat = new DevExpress.Utils.PointFloat(896.9585F, 0F);
            this.xrLabel33.Multiline = true;
            this.xrLabel33.Name = "xrLabel33";
            this.xrLabel33.Padding = new DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100F);
            this.xrLabel33.SizeF = new System.Drawing.SizeF(51.7915F, 23F);
            this.xrLabel33.StylePriority.UseBackColor = false;
            this.xrLabel33.StylePriority.UseBorderColor = false;
            this.xrLabel33.StylePriority.UseBorders = false;
            this.xrLabel33.StylePriority.UseBorderWidth = false;
            this.xrLabel33.StylePriority.UseFont = false;
            this.xrLabel33.StylePriority.UseForeColor = false;
            this.xrLabel33.StylePriority.UsePadding = false;
            this.xrLabel33.StylePriority.UseTextAlignment = false;
            this.xrLabel33.Text = "Reason";
            this.xrLabel33.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel32
            // 
            this.xrLabel32.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel32.BorderColor = System.Drawing.Color.Black;
            this.xrLabel32.Borders = DevExpress.XtraPrinting.BorderSide.Top;
            this.xrLabel32.BorderWidth = 1F;
            this.xrLabel32.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel32.ForeColor = System.Drawing.Color.Black;
            this.xrLabel32.LocationFloat = new DevExpress.Utils.PointFloat(846.1363F, 0F);
            this.xrLabel32.Multiline = true;
            this.xrLabel32.Name = "xrLabel32";
            this.xrLabel32.Padding = new DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100F);
            this.xrLabel32.SizeF = new System.Drawing.SizeF(50.82208F, 23F);
            this.xrLabel32.StylePriority.UseBackColor = false;
            this.xrLabel32.StylePriority.UseBorderColor = false;
            this.xrLabel32.StylePriority.UseBorders = false;
            this.xrLabel32.StylePriority.UseBorderWidth = false;
            this.xrLabel32.StylePriority.UseFont = false;
            this.xrLabel32.StylePriority.UseForeColor = false;
            this.xrLabel32.StylePriority.UsePadding = false;
            this.xrLabel32.StylePriority.UseTextAlignment = false;
            this.xrLabel32.Text = "Rate at\r\nwhich collected";
            this.xrLabel32.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel31
            // 
            this.xrLabel31.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel31.BorderColor = System.Drawing.Color.Black;
            this.xrLabel31.Borders = DevExpress.XtraPrinting.BorderSide.Top;
            this.xrLabel31.BorderWidth = 1F;
            this.xrLabel31.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel31.ForeColor = System.Drawing.Color.Black;
            this.xrLabel31.LocationFloat = new DevExpress.Utils.PointFloat(773.2196F, 0F);
            this.xrLabel31.Multiline = true;
            this.xrLabel31.Name = "xrLabel31";
            this.xrLabel31.Padding = new DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100F);
            this.xrLabel31.SizeF = new System.Drawing.SizeF(72.91669F, 23F);
            this.xrLabel31.StylePriority.UseBackColor = false;
            this.xrLabel31.StylePriority.UseBorderColor = false;
            this.xrLabel31.StylePriority.UseBorders = false;
            this.xrLabel31.StylePriority.UseBorderWidth = false;
            this.xrLabel31.StylePriority.UseFont = false;
            this.xrLabel31.StylePriority.UseForeColor = false;
            this.xrLabel31.StylePriority.UsePadding = false;
            this.xrLabel31.StylePriority.UseTextAlignment = false;
            this.xrLabel31.Text = "Date of\r\ncollection";
            this.xrLabel31.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel30
            // 
            this.xrLabel30.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel30.BorderColor = System.Drawing.Color.Black;
            this.xrLabel30.Borders = DevExpress.XtraPrinting.BorderSide.Top;
            this.xrLabel30.BorderWidth = 1F;
            this.xrLabel30.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel30.ForeColor = System.Drawing.Color.Black;
            this.xrLabel30.LocationFloat = new DevExpress.Utils.PointFloat(708.6364F, 0F);
            this.xrLabel30.Multiline = true;
            this.xrLabel30.Name = "xrLabel30";
            this.xrLabel30.Padding = new DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100F);
            this.xrLabel30.SizeF = new System.Drawing.SizeF(64.58325F, 23F);
            this.xrLabel30.StylePriority.UseBackColor = false;
            this.xrLabel30.StylePriority.UseBorderColor = false;
            this.xrLabel30.StylePriority.UseBorders = false;
            this.xrLabel30.StylePriority.UseBorderWidth = false;
            this.xrLabel30.StylePriority.UseFont = false;
            this.xrLabel30.StylePriority.UseForeColor = false;
            this.xrLabel30.StylePriority.UsePadding = false;
            this.xrLabel30.StylePriority.UseTextAlignment = false;
            this.xrLabel30.Text = "Total Tax\r\nDeposited";
            this.xrLabel30.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel29
            // 
            this.xrLabel29.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel29.BorderColor = System.Drawing.Color.Black;
            this.xrLabel29.Borders = DevExpress.XtraPrinting.BorderSide.Top;
            this.xrLabel29.BorderWidth = 1F;
            this.xrLabel29.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel29.ForeColor = System.Drawing.Color.Black;
            this.xrLabel29.LocationFloat = new DevExpress.Utils.PointFloat(652.3864F, 0F);
            this.xrLabel29.Multiline = true;
            this.xrLabel29.Name = "xrLabel29";
            this.xrLabel29.Padding = new DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100F);
            this.xrLabel29.SizeF = new System.Drawing.SizeF(56.24994F, 23F);
            this.xrLabel29.StylePriority.UseBackColor = false;
            this.xrLabel29.StylePriority.UseBorderColor = false;
            this.xrLabel29.StylePriority.UseBorders = false;
            this.xrLabel29.StylePriority.UseBorderWidth = false;
            this.xrLabel29.StylePriority.UseFont = false;
            this.xrLabel29.StylePriority.UseForeColor = false;
            this.xrLabel29.StylePriority.UsePadding = false;
            this.xrLabel29.StylePriority.UseTextAlignment = false;
            this.xrLabel29.Text = "Total\r\nTax\r\nCollected";
            this.xrLabel29.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel28
            // 
            this.xrLabel28.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel28.BorderColor = System.Drawing.Color.Black;
            this.xrLabel28.Borders = DevExpress.XtraPrinting.BorderSide.Top;
            this.xrLabel28.BorderWidth = 1F;
            this.xrLabel28.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel28.ForeColor = System.Drawing.Color.Black;
            this.xrLabel28.LocationFloat = new DevExpress.Utils.PointFloat(605.9166F, 0F);
            this.xrLabel28.Multiline = true;
            this.xrLabel28.Name = "xrLabel28";
            this.xrLabel28.Padding = new DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100F);
            this.xrLabel28.SizeF = new System.Drawing.SizeF(46.46979F, 23F);
            this.xrLabel28.StylePriority.UseBackColor = false;
            this.xrLabel28.StylePriority.UseBorderColor = false;
            this.xrLabel28.StylePriority.UseBorders = false;
            this.xrLabel28.StylePriority.UseBorderWidth = false;
            this.xrLabel28.StylePriority.UseFont = false;
            this.xrLabel28.StylePriority.UseForeColor = false;
            this.xrLabel28.StylePriority.UsePadding = false;
            this.xrLabel28.StylePriority.UseTextAlignment = false;
            this.xrLabel28.Text = "ECess";
            this.xrLabel28.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel27
            // 
            this.xrLabel27.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel27.BorderColor = System.Drawing.Color.Black;
            this.xrLabel27.Borders = DevExpress.XtraPrinting.BorderSide.Top;
            this.xrLabel27.BorderWidth = 1F;
            this.xrLabel27.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel27.ForeColor = System.Drawing.Color.Black;
            this.xrLabel27.LocationFloat = new DevExpress.Utils.PointFloat(564.2499F, 0F);
            this.xrLabel27.Multiline = true;
            this.xrLabel27.Name = "xrLabel27";
            this.xrLabel27.Padding = new DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100F);
            this.xrLabel27.SizeF = new System.Drawing.SizeF(41.66666F, 23F);
            this.xrLabel27.StylePriority.UseBackColor = false;
            this.xrLabel27.StylePriority.UseBorderColor = false;
            this.xrLabel27.StylePriority.UseBorders = false;
            this.xrLabel27.StylePriority.UseBorderWidth = false;
            this.xrLabel27.StylePriority.UseFont = false;
            this.xrLabel27.StylePriority.UseForeColor = false;
            this.xrLabel27.StylePriority.UsePadding = false;
            this.xrLabel27.StylePriority.UseTextAlignment = false;
            this.xrLabel27.Text = "Sur";
            this.xrLabel27.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel26
            // 
            this.xrLabel26.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel26.BorderColor = System.Drawing.Color.Black;
            this.xrLabel26.Borders = DevExpress.XtraPrinting.BorderSide.Top;
            this.xrLabel26.BorderWidth = 1F;
            this.xrLabel26.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel26.ForeColor = System.Drawing.Color.Black;
            this.xrLabel26.LocationFloat = new DevExpress.Utils.PointFloat(519.3643F, 0F);
            this.xrLabel26.Multiline = true;
            this.xrLabel26.Name = "xrLabel26";
            this.xrLabel26.Padding = new DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100F);
            this.xrLabel26.SizeF = new System.Drawing.SizeF(44.88568F, 23F);
            this.xrLabel26.StylePriority.UseBackColor = false;
            this.xrLabel26.StylePriority.UseBorderColor = false;
            this.xrLabel26.StylePriority.UseBorders = false;
            this.xrLabel26.StylePriority.UseBorderWidth = false;
            this.xrLabel26.StylePriority.UseFont = false;
            this.xrLabel26.StylePriority.UseForeColor = false;
            this.xrLabel26.StylePriority.UsePadding = false;
            this.xrLabel26.StylePriority.UseTextAlignment = false;
            this.xrLabel26.Text = "Tax";
            this.xrLabel26.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel25
            // 
            this.xrLabel25.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel25.BorderColor = System.Drawing.Color.Black;
            this.xrLabel25.Borders = DevExpress.XtraPrinting.BorderSide.Top;
            this.xrLabel25.BorderWidth = 1F;
            this.xrLabel25.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel25.ForeColor = System.Drawing.Color.Black;
            this.xrLabel25.LocationFloat = new DevExpress.Utils.PointFloat(483F, 0F);
            this.xrLabel25.Multiline = true;
            this.xrLabel25.Name = "xrLabel25";
            this.xrLabel25.Padding = new DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100F);
            this.xrLabel25.SizeF = new System.Drawing.SizeF(36.36426F, 23F);
            this.xrLabel25.StylePriority.UseBackColor = false;
            this.xrLabel25.StylePriority.UseBorderColor = false;
            this.xrLabel25.StylePriority.UseBorders = false;
            this.xrLabel25.StylePriority.UseBorderWidth = false;
            this.xrLabel25.StylePriority.UseFont = false;
            this.xrLabel25.StylePriority.UseForeColor = false;
            this.xrLabel25.StylePriority.UsePadding = false;
            this.xrLabel25.StylePriority.UseTextAlignment = false;
            this.xrLabel25.Text = "Collection\r\nCode\r\n";
            this.xrLabel25.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel24
            // 
            this.xrLabel24.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel24.BorderColor = System.Drawing.Color.Black;
            this.xrLabel24.Borders = DevExpress.XtraPrinting.BorderSide.Top;
            this.xrLabel24.BorderWidth = 1F;
            this.xrLabel24.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel24.ForeColor = System.Drawing.Color.Black;
            this.xrLabel24.LocationFloat = new DevExpress.Utils.PointFloat(422.1135F, 0F);
            this.xrLabel24.Multiline = true;
            this.xrLabel24.Name = "xrLabel24";
            this.xrLabel24.Padding = new DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100F);
            this.xrLabel24.SizeF = new System.Drawing.SizeF(60.88651F, 23F);
            this.xrLabel24.StylePriority.UseBackColor = false;
            this.xrLabel24.StylePriority.UseBorderColor = false;
            this.xrLabel24.StylePriority.UseBorders = false;
            this.xrLabel24.StylePriority.UseBorderWidth = false;
            this.xrLabel24.StylePriority.UseFont = false;
            this.xrLabel24.StylePriority.UseForeColor = false;
            this.xrLabel24.StylePriority.UsePadding = false;
            this.xrLabel24.StylePriority.UseTextAlignment = false;
            this.xrLabel24.Text = "Date on\r\nwhich\r\namount\r\nreceived/\r\ndebited";
            this.xrLabel24.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel23
            // 
            this.xrLabel23.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel23.BorderColor = System.Drawing.Color.Black;
            this.xrLabel23.Borders = DevExpress.XtraPrinting.BorderSide.Top;
            this.xrLabel23.BorderWidth = 1F;
            this.xrLabel23.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel23.ForeColor = System.Drawing.Color.Black;
            this.xrLabel23.LocationFloat = new DevExpress.Utils.PointFloat(374.1968F, 0F);
            this.xrLabel23.Multiline = true;
            this.xrLabel23.Name = "xrLabel23";
            this.xrLabel23.Padding = new DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100F);
            this.xrLabel23.SizeF = new System.Drawing.SizeF(47.91669F, 23F);
            this.xrLabel23.StylePriority.UseBackColor = false;
            this.xrLabel23.StylePriority.UseBorderColor = false;
            this.xrLabel23.StylePriority.UseBorders = false;
            this.xrLabel23.StylePriority.UseBorderWidth = false;
            this.xrLabel23.StylePriority.UseFont = false;
            this.xrLabel23.StylePriority.UseForeColor = false;
            this.xrLabel23.StylePriority.UsePadding = false;
            this.xrLabel23.StylePriority.UseTextAlignment = false;
            this.xrLabel23.Text = "Amount\r\nreceived/\r\ndebited\r\nreceived";
            this.xrLabel23.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel22
            // 
            this.xrLabel22.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel22.BorderColor = System.Drawing.Color.Black;
            this.xrLabel22.Borders = DevExpress.XtraPrinting.BorderSide.Top;
            this.xrLabel22.BorderWidth = 1F;
            this.xrLabel22.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel22.ForeColor = System.Drawing.Color.Black;
            this.xrLabel22.LocationFloat = new DevExpress.Utils.PointFloat(329.7917F, 0F);
            this.xrLabel22.Multiline = true;
            this.xrLabel22.Name = "xrLabel22";
            this.xrLabel22.Padding = new DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100F);
            this.xrLabel22.SizeF = new System.Drawing.SizeF(44.40509F, 23F);
            this.xrLabel22.StylePriority.UseBackColor = false;
            this.xrLabel22.StylePriority.UseBorderColor = false;
            this.xrLabel22.StylePriority.UseBorders = false;
            this.xrLabel22.StylePriority.UseBorderWidth = false;
            this.xrLabel22.StylePriority.UseFont = false;
            this.xrLabel22.StylePriority.UseForeColor = false;
            this.xrLabel22.StylePriority.UsePadding = false;
            this.xrLabel22.StylePriority.UseTextAlignment = false;
            this.xrLabel22.Text = "Total\r\nvalue\r\nof the\r\ntransaction\r\ntransaction";
            this.xrLabel22.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel21
            // 
            this.xrLabel21.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel21.BorderColor = System.Drawing.Color.Black;
            this.xrLabel21.Borders = DevExpress.XtraPrinting.BorderSide.Top;
            this.xrLabel21.BorderWidth = 1F;
            this.xrLabel21.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel21.ForeColor = System.Drawing.Color.Black;
            this.xrLabel21.LocationFloat = new DevExpress.Utils.PointFloat(226.75F, 0F);
            this.xrLabel21.Multiline = true;
            this.xrLabel21.Name = "xrLabel21";
            this.xrLabel21.Padding = new DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100F);
            this.xrLabel21.SizeF = new System.Drawing.SizeF(103.0417F, 23F);
            this.xrLabel21.StylePriority.UseBackColor = false;
            this.xrLabel21.StylePriority.UseBorderColor = false;
            this.xrLabel21.StylePriority.UseBorders = false;
            this.xrLabel21.StylePriority.UseBorderWidth = false;
            this.xrLabel21.StylePriority.UseFont = false;
            this.xrLabel21.StylePriority.UseForeColor = false;
            this.xrLabel21.StylePriority.UsePadding = false;
            this.xrLabel21.StylePriority.UseTextAlignment = false;
            this.xrLabel21.Text = "Name\r\nof party";
            this.xrLabel21.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel20
            // 
            this.xrLabel20.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel20.BorderColor = System.Drawing.Color.Black;
            this.xrLabel20.Borders = DevExpress.XtraPrinting.BorderSide.Top;
            this.xrLabel20.BorderWidth = 1F;
            this.xrLabel20.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel20.ForeColor = System.Drawing.Color.Black;
            this.xrLabel20.LocationFloat = new DevExpress.Utils.PointFloat(142.8749F, 0F);
            this.xrLabel20.Multiline = true;
            this.xrLabel20.Name = "xrLabel20";
            this.xrLabel20.Padding = new DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100F);
            this.xrLabel20.SizeF = new System.Drawing.SizeF(83.87512F, 23F);
            this.xrLabel20.StylePriority.UseBackColor = false;
            this.xrLabel20.StylePriority.UseBorderColor = false;
            this.xrLabel20.StylePriority.UseBorders = false;
            this.xrLabel20.StylePriority.UseBorderWidth = false;
            this.xrLabel20.StylePriority.UseFont = false;
            this.xrLabel20.StylePriority.UseForeColor = false;
            this.xrLabel20.StylePriority.UsePadding = false;
            this.xrLabel20.StylePriority.UseTextAlignment = false;
            this.xrLabel20.Text = "PAN\r\nof the party";
            this.xrLabel20.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel19
            // 
            this.xrLabel19.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel19.BorderColor = System.Drawing.Color.Black;
            this.xrLabel19.Borders = DevExpress.XtraPrinting.BorderSide.Top;
            this.xrLabel19.BorderWidth = 1F;
            this.xrLabel19.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel19.ForeColor = System.Drawing.Color.Black;
            this.xrLabel19.LocationFloat = new DevExpress.Utils.PointFloat(89.58334F, 0F);
            this.xrLabel19.Multiline = true;
            this.xrLabel19.Name = "xrLabel19";
            this.xrLabel19.Padding = new DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100F);
            this.xrLabel19.SizeF = new System.Drawing.SizeF(53.12495F, 23F);
            this.xrLabel19.StylePriority.UseBackColor = false;
            this.xrLabel19.StylePriority.UseBorderColor = false;
            this.xrLabel19.StylePriority.UseBorders = false;
            this.xrLabel19.StylePriority.UseBorderWidth = false;
            this.xrLabel19.StylePriority.UseFont = false;
            this.xrLabel19.StylePriority.UseForeColor = false;
            this.xrLabel19.StylePriority.UsePadding = false;
            this.xrLabel19.StylePriority.UseTextAlignment = false;
            this.xrLabel19.Text = "Party\r\ncode";
            this.xrLabel19.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel18
            // 
            this.xrLabel18.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel18.BorderColor = System.Drawing.Color.Black;
            this.xrLabel18.Borders = DevExpress.XtraPrinting.BorderSide.Top;
            this.xrLabel18.BorderWidth = 1F;
            this.xrLabel18.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel18.ForeColor = System.Drawing.Color.Black;
            this.xrLabel18.LocationFloat = new DevExpress.Utils.PointFloat(34.37501F, 0F);
            this.xrLabel18.Multiline = true;
            this.xrLabel18.Name = "xrLabel18";
            this.xrLabel18.Padding = new DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100F);
            this.xrLabel18.SizeF = new System.Drawing.SizeF(55.20834F, 23F);
            this.xrLabel18.StylePriority.UseBackColor = false;
            this.xrLabel18.StylePriority.UseBorderColor = false;
            this.xrLabel18.StylePriority.UseBorders = false;
            this.xrLabel18.StylePriority.UseBorderWidth = false;
            this.xrLabel18.StylePriority.UseFont = false;
            this.xrLabel18.StylePriority.UseForeColor = false;
            this.xrLabel18.StylePriority.UsePadding = false;
            this.xrLabel18.StylePriority.UseTextAlignment = false;
            this.xrLabel18.Text = "Party\r\nreference\r\nno\r\nprovided\r\nby the\r\nCollector\r\nif\r\n available";
            this.xrLabel18.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel17
            // 
            this.xrLabel17.BackColor = System.Drawing.Color.Transparent;
            this.xrLabel17.BorderColor = System.Drawing.Color.Black;
            this.xrLabel17.Borders = DevExpress.XtraPrinting.BorderSide.Top;
            this.xrLabel17.BorderWidth = 1F;
            this.xrLabel17.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel17.ForeColor = System.Drawing.Color.Black;
            this.xrLabel17.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.xrLabel17.Multiline = true;
            this.xrLabel17.Name = "xrLabel17";
            this.xrLabel17.Padding = new DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100F);
            this.xrLabel17.SizeF = new System.Drawing.SizeF(34.375F, 23F);
            this.xrLabel17.StylePriority.UseBackColor = false;
            this.xrLabel17.StylePriority.UseBorderColor = false;
            this.xrLabel17.StylePriority.UseBorders = false;
            this.xrLabel17.StylePriority.UseBorderWidth = false;
            this.xrLabel17.StylePriority.UseFont = false;
            this.xrLabel17.StylePriority.UseForeColor = false;
            this.xrLabel17.StylePriority.UsePadding = false;
            this.xrLabel17.StylePriority.UseTextAlignment = false;
            this.xrLabel17.Text = "Sr\r\nNo.";
            this.xrLabel17.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // Form27EQ_Annexure
            // 
            this.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
            this.TopMargin,
            this.BottomMargin,
            this.ReportHeader,
            this.Detail,
            this.ReportFooter,
            this.GroupHeader1});
            this.ComponentStorage.AddRange(new System.ComponentModel.IComponent[] {
            this.sqlDataSource1});
            this.DataMember = "DT_DS_Form27EQAnnexure_Voucherdetails";
            this.DataSource = this.sqlDataSource1;
            this.Font = new System.Drawing.Font("Arial", 9.75F);
            this.Landscape = true;
            this.Margins = new System.Drawing.Printing.Margins(42, 46, 5, 30);
            this.PageHeight = 850;
            this.PageWidth = 1100;
            this.Parameters.AddRange(new DevExpress.XtraReports.Parameters.Parameter[] {
            this.Bank_Bsrcode,
            this.Challan_Date,
            this.Challan_No,
            this.Challan_Amount,
            this.Interest_Amt,
            this.CompanyName,
            this.TANNo,
            this.Place,
            this.R_Name,
            this.R_Designation,
            this.qsdate,
            this.qedate,
            this.TDS_Amount,
            this.dt});
            this.StyleSheet.AddRange(new DevExpress.XtraReports.UI.XRControlStyle[] {
            this.Title,
            this.DetailCaption1,
            this.DetailData1,
            this.DetailData3_Odd,
            this.PageInfo});
            this.Version = "19.1";
            ((System.ComponentModel.ISupportInitialize)(this.xrTable1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.xrTable2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.xrTable3)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.xrTable5)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.xrTable4)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

    }




    #endregion

   
}
