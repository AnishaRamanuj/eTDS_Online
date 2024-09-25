using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

/// <summary>
/// Summary description for Dv_Form27QDetails
/// </summary>
public class Dv_Form27QDetails : DevExpress.XtraReports.UI.XtraReport
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
    private XRTableCell tableCell12;
    private DetailBand Detail;
    private XRTable table2;
    private XRTableRow tableRow2;
    private XRTableCell tableCell13;
    private XRTableCell tableCell14;
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
    private XRPanel xrPanel1;
    private XRLabel xrLabel131;
    private XRLabel xrLabel132;
    private XRLabel xrLabel133;
    private XRLabel xrLabel134;
    private XRLabel xrLabel135;
    private XRLabel xrLabel136;
    private XRLabel xrLabel137;
    private XRLabel xrLabel138;
    private XRLabel xrLabel139;
    private XRLabel xrLabel140;
    private XRLabel xrLabel141;
    private XRLabel xrLabel142;
    private XRLabel xrLabel143;
    private XRLabel xrLabel144;
    private XRLabel xrLabel145;
    private XRLabel xrLabel146;
    private XRLabel xrLabel147;
    private XRLabel xrLabel148;
    private XRLabel xrLabel149;
    private XRLabel xrLabel150;
    private XRLabel xrLabel151;
    private XRLabel xrLabel152;
    private XRLabel xrLabel153;
    private XRLabel xrLabel154;
    private XRLabel xrLabel155;
    private XRLabel xrLabel156;
    private XRLabel xrLabel157;
    private XRLabel xrLabel164;
    private XRLabel xrLabel165;
    private XRLabel xrLabel166;
    private XRLabel xrLabel167;
    private XRLabel xrLabel168;
    private XRLabel xrLabel169;
    private XRLabel xrLabel170;
    private XRLabel xrLabel171;
    private XRLabel xrLabel172;
    private XRLabel xrLabel173;
    private XRLabel xrLabel174;
    private XRLabel xrLabel175;
    private XRLabel xrLabel176;
    private XRLabel xrLabel177;
    private XRLabel xrLabel178;
    private XRLabel xrLabel179;
    private XRLabel xrLabel180;
    private XRLabel xrLabel181;
    private XRLabel xrLabel182;
    private XRLabel xrLabel183;
    private XRLabel xrLabel184;
    private XRLabel xrLabel185;
    private XRLabel xrLabel186;
    private XRLabel xrLabel187;
    private XRLabel xrLabel188;
    private XRLabel xrLabel189;
    private XRLabel xrLabel190;
    private XRLabel xrLabel191;
    private XRLabel xrLabel192;
    private XRLabel xrLabel193;
    private XRLabel xrLabel194;
    private XRLabel xrLabel202;
    private XRLabel xrLabel203;
    private XRLabel xrLabel204;
    private XRLabel xrLabel205;
    private XRLabel xrLabel206;
    private XRLabel xrLabel207;
    private XRLabel xrLabel208;
    private XRLabel xrLabel209;
    private XRLabel xrLabel210;
    private XRLabel xrLabel211;
    private XRLabel xrLabel212;
    private XRLabel xrLabel213;
    private XRLabel xrLabel214;
    private XRLabel xrLabel215;
    private XRLabel xrLabel216;
    private XRLabel xrLabel217;
    private XRLabel xrLabel218;
    private XRLabel xrLabel219;
    private XRLabel xrLabel220;
    private XRLabel xrLabel221;
    private XRLabel xrLabel222;
    private XRLabel xrLabel223;
    private XRLabel xrLabel224;
    private XRLabel xrLabel225;
    private XRLabel xrLabel226;
    private XRLabel xrLabel227;
    private XRLabel xrLabel228;
    private XRLabel xrLabel229;
    private XRLabel xrLabel230;
    private XRLabel xrLabel231;
    private XRLabel xrLabel232;
    private XRLabel xrLabel233;
    private XRLabel xrLabel126;
    private XRLabel xrLabel127;
    private XRLabel xrLabel128;
    private XRLabel xrLabel129;
    private XRLabel xrLabel158;
    private XRLabel xrLabel159;
    private XRLabel xrLabel160;
    private XRLabel xrLabel161;
    private XRLabel xrLabel162;
    private XRLabel xrLabel163;
    private XRLabel xrLabel195;
    private XRLabel xrLabel196;
    private XRLabel xrLabel197;
    private XRLabel xrLabel198;
    private XRLabel xrLabel199;
    private XRLabel xrLabel200;
    private XRLabel xrLabel201;
    private XRLabel xrLabel4;
    private XRLabel xrLabel3;
    private XRLabel xrLabel2;
    private XRLabel xrLabel1;
    private ReportFooterBand ReportFooter;
    private XRLabel xrLabel122;
    private XRLabel xrLabel119;
    private XRLabel xrLabel118;
    private XRLabel xrLabel117;
    private XRLabel xrLabel116;
    private XRLabel xrLabel79;
    private XRLabel xrLabel81;
    private XRLabel xrLabel82;
    private XRLabel xrLabel83;
    private XRLabel xrLabel84;
    private XRLabel xrLabel85;
    private XRLabel xrLabel87;
    private XRLabel xrLabel86;
    private XRLine xrLine1;
    private XRTableCell xrTableCell1;
    private XRTableRow xrTableRow1;
    private XRTableCell xrTableCell2;
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
    private XRTableRow xrTableRow2;
    private XRTableCell xrTableCell28;
    private DevExpress.XtraReports.Parameters.Parameter TANNo;
    private DevExpress.XtraReports.Parameters.Parameter PANNo;
    private DevExpress.XtraReports.Parameters.Parameter Cname;
    private DevExpress.XtraReports.Parameters.Parameter FlatNo;
    private DevExpress.XtraReports.Parameters.Parameter BuildingNo;
    private DevExpress.XtraReports.Parameters.Parameter Street;
    private DevExpress.XtraReports.Parameters.Parameter Area;
    private DevExpress.XtraReports.Parameters.Parameter Town;
    private DevExpress.XtraReports.Parameters.Parameter State_Name;
    private DevExpress.XtraReports.Parameters.Parameter Pincode;
    private DevExpress.XtraReports.Parameters.Parameter Tel_NO;
    private DevExpress.XtraReports.Parameters.Parameter EmailID;
    private DevExpress.XtraReports.Parameters.Parameter Alt_Tel_NO;
    private DevExpress.XtraReports.Parameters.Parameter Alt_EmailID;
    private DevExpress.XtraReports.Parameters.Parameter R_Name;
    private DevExpress.XtraReports.Parameters.Parameter ContacPersonPAN;
    private DevExpress.XtraReports.Parameters.Parameter R_Flat_NO;
    private DevExpress.XtraReports.Parameters.Parameter R_Building;
    private DevExpress.XtraReports.Parameters.Parameter R_Street;
    private DevExpress.XtraReports.Parameters.Parameter R_Area_Location;
    private DevExpress.XtraReports.Parameters.Parameter R_Town_City;
    private DevExpress.XtraReports.Parameters.Parameter R_Pincode;
    private DevExpress.XtraReports.Parameters.Parameter R_Tel_NO;
    private DevExpress.XtraReports.Parameters.Parameter ALT_R_Tel_NO;
    private DevExpress.XtraReports.Parameters.Parameter R_EmailID;
    private DevExpress.XtraReports.Parameters.Parameter ALT_R_EmailID;
    private DevExpress.XtraReports.Parameters.Parameter R_Mobile_NO;
    private DevExpress.XtraReports.Parameters.Parameter Place;
    private DevExpress.XtraReports.Parameters.Parameter R_Designation;
    private DevExpress.XtraReports.Parameters.Parameter qsdate;
    private DevExpress.XtraReports.Parameters.Parameter qedate;
    private DevExpress.XtraReports.Parameters.Parameter FY;
    private DevExpress.XtraReports.Parameters.Parameter dt;
    private XRLabel xrLabel5;
    private XRLabel xrLabel8;
    private XRLabel xrLabel7;
    private XRLabel xrLabel6;
    private DevExpress.XtraReports.Parameters.Parameter CompanyName;
    private XRLabel xrLabel9;
    private GroupFooterBand GroupFooter1;
    private XRLabel xrLabel11;
    private XRLabel xrLabel10;
    private XRLabel xrLabel17;
    private XRLabel xrLabel16;
    private XRLabel xrLabel15;
    private XRLabel xrLabel14;
    private XRLabel xrLabel13;
    private XRLabel xrLabel12;
    private XRLine xrLine2;

    /// <summary>
    /// Required designer variable.
    /// </summary>
    private System.ComponentModel.IContainer components = null;

    public Dv_Form27QDetails()
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
            string resourceFileName = "Dv_Form27QDetails.resx";
            System.Resources.ResourceManager resources = global::Resources.Dv_Form27QDetails.ResourceManager;
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
            this.xrPanel1 = new DevExpress.XtraReports.UI.XRPanel();
            this.xrLabel9 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel8 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel7 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel6 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel131 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel132 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel133 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel134 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel135 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel136 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel137 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel138 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel139 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel140 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel141 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel142 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel143 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel144 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel145 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel146 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel147 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel148 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel149 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel150 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel151 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel152 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel153 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel154 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel155 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel156 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel157 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel164 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel165 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel166 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel167 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel168 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel169 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel170 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel171 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel172 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel173 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel174 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel175 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel176 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel177 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel178 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel179 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel180 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel181 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel182 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel183 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel184 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel185 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel186 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel187 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel188 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel189 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel190 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel191 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel192 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel193 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel194 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel202 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel203 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel204 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel205 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel206 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel207 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel208 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel209 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel210 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel211 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel212 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel213 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel214 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel215 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel216 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel217 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel218 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel219 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel220 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel221 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel222 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel223 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel224 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel225 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel226 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel227 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel228 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel229 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel230 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel231 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel232 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel233 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel126 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel127 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel128 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel129 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel158 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel159 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel160 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel161 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel162 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel163 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel195 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel196 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel197 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel198 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel199 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel200 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel201 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel4 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel3 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel2 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel1 = new DevExpress.XtraReports.UI.XRLabel();
            this.GroupHeader1 = new DevExpress.XtraReports.UI.GroupHeaderBand();
            this.table1 = new DevExpress.XtraReports.UI.XRTable();
            this.xrTableRow2 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell28 = new DevExpress.XtraReports.UI.XRTableCell();
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
            this.tableCell12 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell1 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow1 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell2 = new DevExpress.XtraReports.UI.XRTableCell();
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
            this.Detail = new DevExpress.XtraReports.UI.DetailBand();
            this.table2 = new DevExpress.XtraReports.UI.XRTable();
            this.tableRow2 = new DevExpress.XtraReports.UI.XRTableRow();
            this.tableCell13 = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableCell14 = new DevExpress.XtraReports.UI.XRTableCell();
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
            this.xrTableCell15 = new DevExpress.XtraReports.UI.XRTableCell();
            this.ReportFooter = new DevExpress.XtraReports.UI.ReportFooterBand();
            this.xrLabel5 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel122 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel119 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel118 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel117 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel116 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel79 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel81 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel82 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel83 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel84 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel85 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel87 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel86 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLine1 = new DevExpress.XtraReports.UI.XRLine();
            this.TANNo = new DevExpress.XtraReports.Parameters.Parameter();
            this.PANNo = new DevExpress.XtraReports.Parameters.Parameter();
            this.Cname = new DevExpress.XtraReports.Parameters.Parameter();
            this.FlatNo = new DevExpress.XtraReports.Parameters.Parameter();
            this.BuildingNo = new DevExpress.XtraReports.Parameters.Parameter();
            this.Street = new DevExpress.XtraReports.Parameters.Parameter();
            this.Area = new DevExpress.XtraReports.Parameters.Parameter();
            this.Town = new DevExpress.XtraReports.Parameters.Parameter();
            this.State_Name = new DevExpress.XtraReports.Parameters.Parameter();
            this.Pincode = new DevExpress.XtraReports.Parameters.Parameter();
            this.Tel_NO = new DevExpress.XtraReports.Parameters.Parameter();
            this.EmailID = new DevExpress.XtraReports.Parameters.Parameter();
            this.Alt_Tel_NO = new DevExpress.XtraReports.Parameters.Parameter();
            this.Alt_EmailID = new DevExpress.XtraReports.Parameters.Parameter();
            this.R_Name = new DevExpress.XtraReports.Parameters.Parameter();
            this.ContacPersonPAN = new DevExpress.XtraReports.Parameters.Parameter();
            this.R_Flat_NO = new DevExpress.XtraReports.Parameters.Parameter();
            this.R_Building = new DevExpress.XtraReports.Parameters.Parameter();
            this.R_Street = new DevExpress.XtraReports.Parameters.Parameter();
            this.R_Area_Location = new DevExpress.XtraReports.Parameters.Parameter();
            this.R_Town_City = new DevExpress.XtraReports.Parameters.Parameter();
            this.R_Pincode = new DevExpress.XtraReports.Parameters.Parameter();
            this.R_Tel_NO = new DevExpress.XtraReports.Parameters.Parameter();
            this.ALT_R_Tel_NO = new DevExpress.XtraReports.Parameters.Parameter();
            this.R_EmailID = new DevExpress.XtraReports.Parameters.Parameter();
            this.ALT_R_EmailID = new DevExpress.XtraReports.Parameters.Parameter();
            this.R_Mobile_NO = new DevExpress.XtraReports.Parameters.Parameter();
            this.Place = new DevExpress.XtraReports.Parameters.Parameter();
            this.R_Designation = new DevExpress.XtraReports.Parameters.Parameter();
            this.qsdate = new DevExpress.XtraReports.Parameters.Parameter();
            this.qedate = new DevExpress.XtraReports.Parameters.Parameter();
            this.FY = new DevExpress.XtraReports.Parameters.Parameter();
            this.dt = new DevExpress.XtraReports.Parameters.Parameter();
            this.CompanyName = new DevExpress.XtraReports.Parameters.Parameter();
            this.GroupFooter1 = new DevExpress.XtraReports.UI.GroupFooterBand();
            this.xrLine2 = new DevExpress.XtraReports.UI.XRLine();
            this.xrLabel17 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel16 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel15 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel14 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel13 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel12 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel11 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel10 = new DevExpress.XtraReports.UI.XRLabel();
            ((System.ComponentModel.ISupportInitialize)(this.table1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.table2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // sqlDataSource1
            // 
            this.sqlDataSource1.ConnectionName = "DS_Form27QChallanDetails";
            xmlFileConnectionParameters1.FileName = "D:\\OnlineTds_Reports\\eTDSOnline\\App_Code\\DS_Form27QChallanDetails.xsd";
            this.sqlDataSource1.ConnectionParameters = xmlFileConnectionParameters1;
            this.sqlDataSource1.Name = "sqlDataSource1";
            columnExpression1.ColumnName = "Srno";
            table3.Name = "DT_Form27Q_ChallanDetails";
            columnExpression1.Table = table3;
            column1.Expression = columnExpression1;
            columnExpression2.ColumnName = "TDS_Amount";
            columnExpression2.Table = table3;
            column2.Expression = columnExpression2;
            columnExpression3.ColumnName = "Surcharge";
            columnExpression3.Table = table3;
            column3.Expression = columnExpression3;
            columnExpression4.ColumnName = "Education_Cess";
            columnExpression4.Table = table3;
            column4.Expression = columnExpression4;
            columnExpression5.ColumnName = "Interest_Amt";
            columnExpression5.Table = table3;
            column5.Expression = columnExpression5;
            columnExpression6.ColumnName = "Fees_Amount";
            columnExpression6.Table = table3;
            column6.Expression = columnExpression6;
            columnExpression7.ColumnName = "Others_Amount";
            columnExpression7.Table = table3;
            column7.Expression = columnExpression7;
            columnExpression8.ColumnName = "Challan_Amount";
            columnExpression8.Table = table3;
            column8.Expression = columnExpression8;
            columnExpression9.ColumnName = "Nil_Challan";
            columnExpression9.Table = table3;
            column9.Expression = columnExpression9;
            columnExpression10.ColumnName = "Bank_Bsrcode";
            columnExpression10.Table = table3;
            column10.Expression = columnExpression10;
            columnExpression11.ColumnName = "Challan_No";
            columnExpression11.Table = table3;
            column11.Expression = columnExpression11;
            columnExpression12.ColumnName = "Challan_Date";
            columnExpression12.Table = table3;
            column12.Expression = columnExpression12;
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
            selectQuery1.Name = "DT_Form27Q_ChallanDetails";
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
            this.TopMargin.HeightF = 0F;
            this.TopMargin.Name = "TopMargin";
            // 
            // BottomMargin
            // 
            this.BottomMargin.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.pageInfo1,
            this.pageInfo2});
            this.BottomMargin.HeightF = 29F;
            this.BottomMargin.Name = "BottomMargin";
            // 
            // pageInfo1
            // 
            this.pageInfo1.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.pageInfo1.Name = "pageInfo1";
            this.pageInfo1.PageInfo = DevExpress.XtraPrinting.PageInfo.DateTime;
            this.pageInfo1.SizeF = new System.Drawing.SizeF(438F, 23F);
            this.pageInfo1.StyleName = "PageInfo";
            // 
            // pageInfo2
            // 
            this.pageInfo2.LocationFloat = new DevExpress.Utils.PointFloat(570F, 0F);
            this.pageInfo2.Name = "pageInfo2";
            this.pageInfo2.SizeF = new System.Drawing.SizeF(438F, 23F);
            this.pageInfo2.StyleName = "PageInfo";
            this.pageInfo2.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            this.pageInfo2.TextFormatString = "Page {0} of {1}";
            // 
            // ReportHeader
            // 
            this.ReportHeader.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrPanel1});
            this.ReportHeader.HeightF = 645.8333F;
            this.ReportHeader.Name = "ReportHeader";
            // 
            // xrPanel1
            // 
            this.xrPanel1.Borders = ((DevExpress.XtraPrinting.BorderSide)((((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrPanel1.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrLabel9,
            this.xrLabel8,
            this.xrLabel7,
            this.xrLabel6,
            this.xrLabel131,
            this.xrLabel132,
            this.xrLabel133,
            this.xrLabel134,
            this.xrLabel135,
            this.xrLabel136,
            this.xrLabel137,
            this.xrLabel138,
            this.xrLabel139,
            this.xrLabel140,
            this.xrLabel141,
            this.xrLabel142,
            this.xrLabel143,
            this.xrLabel144,
            this.xrLabel145,
            this.xrLabel146,
            this.xrLabel147,
            this.xrLabel148,
            this.xrLabel149,
            this.xrLabel150,
            this.xrLabel151,
            this.xrLabel152,
            this.xrLabel153,
            this.xrLabel154,
            this.xrLabel155,
            this.xrLabel156,
            this.xrLabel157,
            this.xrLabel164,
            this.xrLabel165,
            this.xrLabel166,
            this.xrLabel167,
            this.xrLabel168,
            this.xrLabel169,
            this.xrLabel170,
            this.xrLabel171,
            this.xrLabel172,
            this.xrLabel173,
            this.xrLabel174,
            this.xrLabel175,
            this.xrLabel176,
            this.xrLabel177,
            this.xrLabel178,
            this.xrLabel179,
            this.xrLabel180,
            this.xrLabel181,
            this.xrLabel182,
            this.xrLabel183,
            this.xrLabel184,
            this.xrLabel185,
            this.xrLabel186,
            this.xrLabel187,
            this.xrLabel188,
            this.xrLabel189,
            this.xrLabel190,
            this.xrLabel191,
            this.xrLabel192,
            this.xrLabel193,
            this.xrLabel194,
            this.xrLabel202,
            this.xrLabel203,
            this.xrLabel204,
            this.xrLabel205,
            this.xrLabel206,
            this.xrLabel207,
            this.xrLabel208,
            this.xrLabel209,
            this.xrLabel210,
            this.xrLabel211,
            this.xrLabel212,
            this.xrLabel213,
            this.xrLabel214,
            this.xrLabel215,
            this.xrLabel216,
            this.xrLabel217,
            this.xrLabel218,
            this.xrLabel219,
            this.xrLabel220,
            this.xrLabel221,
            this.xrLabel222,
            this.xrLabel223,
            this.xrLabel224,
            this.xrLabel225,
            this.xrLabel226,
            this.xrLabel227,
            this.xrLabel228,
            this.xrLabel229,
            this.xrLabel230,
            this.xrLabel231,
            this.xrLabel232,
            this.xrLabel233,
            this.xrLabel126,
            this.xrLabel127,
            this.xrLabel128,
            this.xrLabel129,
            this.xrLabel158,
            this.xrLabel159,
            this.xrLabel160,
            this.xrLabel161,
            this.xrLabel162,
            this.xrLabel163,
            this.xrLabel195,
            this.xrLabel196,
            this.xrLabel197,
            this.xrLabel198,
            this.xrLabel199,
            this.xrLabel200,
            this.xrLabel201,
            this.xrLabel4,
            this.xrLabel3,
            this.xrLabel2,
            this.xrLabel1});
            this.xrPanel1.LocationFloat = new DevExpress.Utils.PointFloat(5.999994F, 0F);
            this.xrPanel1.Name = "xrPanel1";
            this.xrPanel1.SizeF = new System.Drawing.SizeF(1002F, 645.8333F);
            this.xrPanel1.StylePriority.UseBorders = false;
            // 
            // xrLabel9
            // 
            this.xrLabel9.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel9.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?Cname")});
            this.xrLabel9.Font = new System.Drawing.Font("Arial", 11F, System.Drawing.FontStyle.Bold);
            this.xrLabel9.LocationFloat = new DevExpress.Utils.PointFloat(11.37498F, 13.81043F);
            this.xrLabel9.Multiline = true;
            this.xrLabel9.Name = "xrLabel9";
            this.xrLabel9.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel9.SizeF = new System.Drawing.SizeF(971.1628F, 23F);
            this.xrLabel9.StylePriority.UseBorders = false;
            this.xrLabel9.StylePriority.UseFont = false;
            this.xrLabel9.StylePriority.UseTextAlignment = false;
            this.xrLabel9.Text = "xrLabel9";
            this.xrLabel9.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel8
            // 
            this.xrLabel8.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel8.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel8.LocationFloat = new DevExpress.Utils.PointFloat(492.3358F, 105.8104F);
            this.xrLabel8.Multiline = true;
            this.xrLabel8.Name = "xrLabel8";
            this.xrLabel8.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel8.SizeF = new System.Drawing.SizeF(24.51041F, 23F);
            this.xrLabel8.StylePriority.UseBorders = false;
            this.xrLabel8.StylePriority.UseFont = false;
            this.xrLabel8.StylePriority.UseTextAlignment = false;
            this.xrLabel8.Text = "To";
            this.xrLabel8.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel7
            // 
            this.xrLabel7.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel7.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?qedate")});
            this.xrLabel7.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel7.LocationFloat = new DevExpress.Utils.PointFloat(516.8463F, 105.8104F);
            this.xrLabel7.Multiline = true;
            this.xrLabel7.Name = "xrLabel7";
            this.xrLabel7.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel7.SizeF = new System.Drawing.SizeF(63.54166F, 23.00002F);
            this.xrLabel7.StylePriority.UseBorders = false;
            this.xrLabel7.StylePriority.UseFont = false;
            this.xrLabel7.StylePriority.UseTextAlignment = false;
            this.xrLabel7.Text = "xrLabel7";
            this.xrLabel7.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // xrLabel6
            // 
            this.xrLabel6.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel6.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?qsdate")});
            this.xrLabel6.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel6.LocationFloat = new DevExpress.Utils.PointFloat(426.1691F, 105.8104F);
            this.xrLabel6.Multiline = true;
            this.xrLabel6.Name = "xrLabel6";
            this.xrLabel6.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel6.SizeF = new System.Drawing.SizeF(66.16663F, 22.99998F);
            this.xrLabel6.StylePriority.UseBorders = false;
            this.xrLabel6.StylePriority.UseFont = false;
            this.xrLabel6.StylePriority.UseTextAlignment = false;
            this.xrLabel6.Text = "xrLabel6";
            this.xrLabel6.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // xrLabel131
            // 
            this.xrLabel131.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel131.LocationFloat = new DevExpress.Utils.PointFloat(260.3835F, 267.8104F);
            this.xrLabel131.Multiline = true;
            this.xrLabel131.Name = "xrLabel131";
            this.xrLabel131.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel131.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel131.StylePriority.UseBorders = false;
            this.xrLabel131.Text = ":";
            // 
            // xrLabel132
            // 
            this.xrLabel132.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel132.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?R_Mobile_NO")});
            this.xrLabel132.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel132.LocationFloat = new DevExpress.Utils.PointFloat(779.2697F, 590.6895F);
            this.xrLabel132.Multiline = true;
            this.xrLabel132.Name = "xrLabel132";
            this.xrLabel132.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel132.SizeF = new System.Drawing.SizeF(185.5217F, 23.00006F);
            this.xrLabel132.StylePriority.UseBorders = false;
            this.xrLabel132.StylePriority.UseFont = false;
            this.xrLabel132.Text = "xrLabel115";
            // 
            // xrLabel133
            // 
            this.xrLabel133.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel133.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?ALT_R_EmailID")});
            this.xrLabel133.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel133.LocationFloat = new DevExpress.Utils.PointFloat(779.2697F, 567.6893F);
            this.xrLabel133.Multiline = true;
            this.xrLabel133.Name = "xrLabel133";
            this.xrLabel133.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel133.SizeF = new System.Drawing.SizeF(185.5217F, 23F);
            this.xrLabel133.StylePriority.UseBorders = false;
            this.xrLabel133.StylePriority.UseFont = false;
            this.xrLabel133.Text = "xrLabel114";
            // 
            // xrLabel134
            // 
            this.xrLabel134.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel134.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?R_EmailID")});
            this.xrLabel134.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel134.LocationFloat = new DevExpress.Utils.PointFloat(779.2697F, 544.6892F);
            this.xrLabel134.Multiline = true;
            this.xrLabel134.Name = "xrLabel134";
            this.xrLabel134.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel134.SizeF = new System.Drawing.SizeF(185.5217F, 23F);
            this.xrLabel134.StylePriority.UseBorders = false;
            this.xrLabel134.StylePriority.UseFont = false;
            this.xrLabel134.Text = "xrLabel113";
            // 
            // xrLabel135
            // 
            this.xrLabel135.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel135.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?Alt_Tel_NO")});
            this.xrLabel135.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel135.LocationFloat = new DevExpress.Utils.PointFloat(779.2697F, 521.6893F);
            this.xrLabel135.Multiline = true;
            this.xrLabel135.Name = "xrLabel135";
            this.xrLabel135.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel135.SizeF = new System.Drawing.SizeF(185.5217F, 23F);
            this.xrLabel135.StylePriority.UseBorders = false;
            this.xrLabel135.StylePriority.UseFont = false;
            this.xrLabel135.Text = "xrLabel112";
            // 
            // xrLabel136
            // 
            this.xrLabel136.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel136.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?R_Tel_NO")});
            this.xrLabel136.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel136.LocationFloat = new DevExpress.Utils.PointFloat(779.2697F, 498.6892F);
            this.xrLabel136.Multiline = true;
            this.xrLabel136.Name = "xrLabel136";
            this.xrLabel136.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel136.SizeF = new System.Drawing.SizeF(185.5217F, 23F);
            this.xrLabel136.StylePriority.UseBorders = false;
            this.xrLabel136.StylePriority.UseFont = false;
            this.xrLabel136.Text = "xrLabel111";
            // 
            // xrLabel137
            // 
            this.xrLabel137.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel137.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?R_Pincode")});
            this.xrLabel137.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel137.LocationFloat = new DevExpress.Utils.PointFloat(779.2697F, 475.6892F);
            this.xrLabel137.Multiline = true;
            this.xrLabel137.Name = "xrLabel137";
            this.xrLabel137.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel137.SizeF = new System.Drawing.SizeF(185.5217F, 23F);
            this.xrLabel137.StylePriority.UseBorders = false;
            this.xrLabel137.StylePriority.UseFont = false;
            this.xrLabel137.Text = "xrLabel110";
            // 
            // xrLabel138
            // 
            this.xrLabel138.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel138.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?State_Name")});
            this.xrLabel138.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel138.LocationFloat = new DevExpress.Utils.PointFloat(779.2697F, 452.6892F);
            this.xrLabel138.Multiline = true;
            this.xrLabel138.Name = "xrLabel138";
            this.xrLabel138.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel138.SizeF = new System.Drawing.SizeF(185.5217F, 23F);
            this.xrLabel138.StylePriority.UseBorders = false;
            this.xrLabel138.StylePriority.UseFont = false;
            this.xrLabel138.Text = "xrLabel109";
            // 
            // xrLabel139
            // 
            this.xrLabel139.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel139.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?R_Town_City")});
            this.xrLabel139.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel139.LocationFloat = new DevExpress.Utils.PointFloat(779.2697F, 429.6892F);
            this.xrLabel139.Multiline = true;
            this.xrLabel139.Name = "xrLabel139";
            this.xrLabel139.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel139.SizeF = new System.Drawing.SizeF(185.5217F, 23F);
            this.xrLabel139.StylePriority.UseBorders = false;
            this.xrLabel139.StylePriority.UseFont = false;
            this.xrLabel139.Text = "xrLabel108";
            // 
            // xrLabel140
            // 
            this.xrLabel140.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel140.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?R_Area_Location")});
            this.xrLabel140.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel140.LocationFloat = new DevExpress.Utils.PointFloat(779.2697F, 406.6893F);
            this.xrLabel140.Multiline = true;
            this.xrLabel140.Name = "xrLabel140";
            this.xrLabel140.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel140.SizeF = new System.Drawing.SizeF(185.5217F, 23F);
            this.xrLabel140.StylePriority.UseBorders = false;
            this.xrLabel140.StylePriority.UseFont = false;
            this.xrLabel140.Text = "xrLabel107";
            // 
            // xrLabel141
            // 
            this.xrLabel141.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel141.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?R_Street")});
            this.xrLabel141.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel141.LocationFloat = new DevExpress.Utils.PointFloat(779.2697F, 383.6893F);
            this.xrLabel141.Multiline = true;
            this.xrLabel141.Name = "xrLabel141";
            this.xrLabel141.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel141.SizeF = new System.Drawing.SizeF(185.5217F, 23F);
            this.xrLabel141.StylePriority.UseBorders = false;
            this.xrLabel141.StylePriority.UseFont = false;
            this.xrLabel141.Text = "xrLabel106";
            // 
            // xrLabel142
            // 
            this.xrLabel142.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel142.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?R_Building")});
            this.xrLabel142.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel142.LocationFloat = new DevExpress.Utils.PointFloat(779.2697F, 360.6893F);
            this.xrLabel142.Multiline = true;
            this.xrLabel142.Name = "xrLabel142";
            this.xrLabel142.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel142.SizeF = new System.Drawing.SizeF(185.5217F, 23F);
            this.xrLabel142.StylePriority.UseBorders = false;
            this.xrLabel142.StylePriority.UseFont = false;
            this.xrLabel142.Text = "xrLabel105";
            // 
            // xrLabel143
            // 
            this.xrLabel143.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel143.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?R_Flat_NO")});
            this.xrLabel143.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel143.LocationFloat = new DevExpress.Utils.PointFloat(779.2697F, 337.6892F);
            this.xrLabel143.Multiline = true;
            this.xrLabel143.Name = "xrLabel143";
            this.xrLabel143.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel143.SizeF = new System.Drawing.SizeF(185.5217F, 23F);
            this.xrLabel143.StylePriority.UseBorders = false;
            this.xrLabel143.StylePriority.UseFont = false;
            this.xrLabel143.Text = "xrLabel104";
            // 
            // xrLabel144
            // 
            this.xrLabel144.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel144.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?ContacPersonPAN")});
            this.xrLabel144.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel144.LocationFloat = new DevExpress.Utils.PointFloat(779.2697F, 290.7044F);
            this.xrLabel144.Multiline = true;
            this.xrLabel144.Name = "xrLabel144";
            this.xrLabel144.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel144.SizeF = new System.Drawing.SizeF(185.5217F, 23F);
            this.xrLabel144.StylePriority.UseBorders = false;
            this.xrLabel144.StylePriority.UseFont = false;
            this.xrLabel144.Text = "xrLabel103";
            // 
            // xrLabel145
            // 
            this.xrLabel145.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel145.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?R_Name")});
            this.xrLabel145.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel145.LocationFloat = new DevExpress.Utils.PointFloat(779.2697F, 267.7043F);
            this.xrLabel145.Multiline = true;
            this.xrLabel145.Name = "xrLabel145";
            this.xrLabel145.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel145.SizeF = new System.Drawing.SizeF(212.7303F, 23F);
            this.xrLabel145.StylePriority.UseBorders = false;
            this.xrLabel145.StylePriority.UseFont = false;
            this.xrLabel145.Text = "xrLabel102";
            // 
            // xrLabel146
            // 
            this.xrLabel146.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel146.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?Alt_EmailID")});
            this.xrLabel146.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel146.LocationFloat = new DevExpress.Utils.PointFloat(275.9495F, 612.8333F);
            this.xrLabel146.Multiline = true;
            this.xrLabel146.Name = "xrLabel146";
            this.xrLabel146.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel146.SizeF = new System.Drawing.SizeF(223.2832F, 23F);
            this.xrLabel146.StylePriority.UseBorders = false;
            this.xrLabel146.StylePriority.UseFont = false;
            this.xrLabel146.Text = "xrLabel101";
            // 
            // xrLabel147
            // 
            this.xrLabel147.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel147.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?EmailID")});
            this.xrLabel147.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel147.LocationFloat = new DevExpress.Utils.PointFloat(275.9495F, 589.8333F);
            this.xrLabel147.Multiline = true;
            this.xrLabel147.Name = "xrLabel147";
            this.xrLabel147.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel147.SizeF = new System.Drawing.SizeF(223.2832F, 23F);
            this.xrLabel147.StylePriority.UseBorders = false;
            this.xrLabel147.StylePriority.UseFont = false;
            this.xrLabel147.Text = "xrLabel100";
            // 
            // xrLabel148
            // 
            this.xrLabel148.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel148.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?Alt_Tel_NO")});
            this.xrLabel148.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel148.LocationFloat = new DevExpress.Utils.PointFloat(275.9495F, 566.8331F);
            this.xrLabel148.Multiline = true;
            this.xrLabel148.Name = "xrLabel148";
            this.xrLabel148.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel148.SizeF = new System.Drawing.SizeF(223.2832F, 23.00003F);
            this.xrLabel148.StylePriority.UseBorders = false;
            this.xrLabel148.StylePriority.UseFont = false;
            this.xrLabel148.Text = "xrLabel99";
            // 
            // xrLabel149
            // 
            this.xrLabel149.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel149.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?Tel_NO")});
            this.xrLabel149.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel149.LocationFloat = new DevExpress.Utils.PointFloat(275.9495F, 543.8331F);
            this.xrLabel149.Multiline = true;
            this.xrLabel149.Name = "xrLabel149";
            this.xrLabel149.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel149.SizeF = new System.Drawing.SizeF(223.2832F, 23F);
            this.xrLabel149.StylePriority.UseBorders = false;
            this.xrLabel149.StylePriority.UseFont = false;
            this.xrLabel149.Text = "xrLabel98";
            // 
            // xrLabel150
            // 
            this.xrLabel150.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel150.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?Pincode")});
            this.xrLabel150.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel150.LocationFloat = new DevExpress.Utils.PointFloat(275.9494F, 520.8331F);
            this.xrLabel150.Multiline = true;
            this.xrLabel150.Name = "xrLabel150";
            this.xrLabel150.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel150.SizeF = new System.Drawing.SizeF(223.2832F, 23F);
            this.xrLabel150.StylePriority.UseBorders = false;
            this.xrLabel150.StylePriority.UseFont = false;
            this.xrLabel150.Text = "xrLabel97";
            // 
            // xrLabel151
            // 
            this.xrLabel151.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel151.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?BuildingNo")});
            this.xrLabel151.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel151.LocationFloat = new DevExpress.Utils.PointFloat(275.9494F, 405.8331F);
            this.xrLabel151.Multiline = true;
            this.xrLabel151.Name = "xrLabel151";
            this.xrLabel151.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel151.SizeF = new System.Drawing.SizeF(223.2832F, 23F);
            this.xrLabel151.StylePriority.UseBorders = false;
            this.xrLabel151.StylePriority.UseFont = false;
            this.xrLabel151.Text = "xrLabel96";
            // 
            // xrLabel152
            // 
            this.xrLabel152.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel152.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?State_Name")});
            this.xrLabel152.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel152.LocationFloat = new DevExpress.Utils.PointFloat(275.9494F, 497.8331F);
            this.xrLabel152.Multiline = true;
            this.xrLabel152.Name = "xrLabel152";
            this.xrLabel152.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel152.SizeF = new System.Drawing.SizeF(223.2832F, 23F);
            this.xrLabel152.StylePriority.UseBorders = false;
            this.xrLabel152.StylePriority.UseFont = false;
            this.xrLabel152.Text = "xrLabel95";
            // 
            // xrLabel153
            // 
            this.xrLabel153.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel153.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?Town")});
            this.xrLabel153.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel153.LocationFloat = new DevExpress.Utils.PointFloat(275.9494F, 474.8331F);
            this.xrLabel153.Multiline = true;
            this.xrLabel153.Name = "xrLabel153";
            this.xrLabel153.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel153.SizeF = new System.Drawing.SizeF(223.2832F, 23F);
            this.xrLabel153.StylePriority.UseBorders = false;
            this.xrLabel153.StylePriority.UseFont = false;
            this.xrLabel153.Text = "xrLabel94";
            // 
            // xrLabel154
            // 
            this.xrLabel154.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel154.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?Area")});
            this.xrLabel154.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel154.LocationFloat = new DevExpress.Utils.PointFloat(275.9495F, 451.8331F);
            this.xrLabel154.Multiline = true;
            this.xrLabel154.Name = "xrLabel154";
            this.xrLabel154.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel154.SizeF = new System.Drawing.SizeF(223.2832F, 23F);
            this.xrLabel154.StylePriority.UseBorders = false;
            this.xrLabel154.StylePriority.UseFont = false;
            this.xrLabel154.Text = "xrLabel93";
            // 
            // xrLabel155
            // 
            this.xrLabel155.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel155.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?Street")});
            this.xrLabel155.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel155.LocationFloat = new DevExpress.Utils.PointFloat(275.9494F, 428.8331F);
            this.xrLabel155.Multiline = true;
            this.xrLabel155.Name = "xrLabel155";
            this.xrLabel155.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel155.SizeF = new System.Drawing.SizeF(223.2832F, 23F);
            this.xrLabel155.StylePriority.UseBorders = false;
            this.xrLabel155.StylePriority.UseFont = false;
            this.xrLabel155.Text = "xrLabel92";
            // 
            // xrLabel156
            // 
            this.xrLabel156.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel156.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?FlatNo")});
            this.xrLabel156.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel156.LocationFloat = new DevExpress.Utils.PointFloat(275.9494F, 382.8331F);
            this.xrLabel156.Multiline = true;
            this.xrLabel156.Name = "xrLabel156";
            this.xrLabel156.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel156.SizeF = new System.Drawing.SizeF(223.2832F, 23F);
            this.xrLabel156.StylePriority.UseBorders = false;
            this.xrLabel156.StylePriority.UseFont = false;
            this.xrLabel156.Text = "xrLabel91";
            // 
            // xrLabel157
            // 
            this.xrLabel157.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel157.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?Cname")});
            this.xrLabel157.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel157.LocationFloat = new DevExpress.Utils.PointFloat(275.6411F, 267.8104F);
            this.xrLabel157.Multiline = true;
            this.xrLabel157.Name = "xrLabel157";
            this.xrLabel157.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel157.SizeF = new System.Drawing.SizeF(223.5915F, 23F);
            this.xrLabel157.StylePriority.UseBorders = false;
            this.xrLabel157.StylePriority.UseFont = false;
            this.xrLabel157.Text = "xrLabel90";
            // 
            // xrLabel164
            // 
            this.xrLabel164.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel164.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel164.LocationFloat = new DevExpress.Utils.PointFloat(17.61364F, 290.8104F);
            this.xrLabel164.Multiline = true;
            this.xrLabel164.Name = "xrLabel164";
            this.xrLabel164.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel164.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel164.StylePriority.UseBorders = false;
            this.xrLabel164.StylePriority.UseFont = false;
            this.xrLabel164.Text = "(b) If Central / state Government \r\n\r\n";
            // 
            // xrLabel165
            // 
            this.xrLabel165.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel165.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel165.LocationFloat = new DevExpress.Utils.PointFloat(17.61364F, 267.8104F);
            this.xrLabel165.Multiline = true;
            this.xrLabel165.Name = "xrLabel165";
            this.xrLabel165.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel165.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel165.StylePriority.UseBorders = false;
            this.xrLabel165.StylePriority.UseFont = false;
            this.xrLabel165.Text = "(a)Name of the collector ";
            // 
            // xrLabel166
            // 
            this.xrLabel166.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel166.Font = new System.Drawing.Font("Arial Narrow", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel166.LocationFloat = new DevExpress.Utils.PointFloat(23.28433F, 244.8103F);
            this.xrLabel166.Multiline = true;
            this.xrLabel166.Name = "xrLabel166";
            this.xrLabel166.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel166.SizeF = new System.Drawing.SizeF(299.8964F, 23F);
            this.xrLabel166.StylePriority.UseBorders = false;
            this.xrLabel166.StylePriority.UseFont = false;
            this.xrLabel166.Text = "Particulars of the Collector";
            // 
            // xrLabel167
            // 
            this.xrLabel167.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel167.Font = new System.Drawing.Font("Arial Narrow", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel167.LocationFloat = new DevExpress.Utils.PointFloat(5.670691F, 244.8103F);
            this.xrLabel167.Multiline = true;
            this.xrLabel167.Name = "xrLabel167";
            this.xrLabel167.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel167.SizeF = new System.Drawing.SizeF(17.61364F, 23F);
            this.xrLabel167.StylePriority.UseBorders = false;
            this.xrLabel167.StylePriority.UseFont = false;
            this.xrLabel167.Text = "2. ";
            // 
            // xrLabel168
            // 
            this.xrLabel168.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel168.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel168.LocationFloat = new DevExpress.Utils.PointFloat(34.2374F, 313.8103F);
            this.xrLabel168.Multiline = true;
            this.xrLabel168.Name = "xrLabel168";
            this.xrLabel168.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel168.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel168.StylePriority.UseBorders = false;
            this.xrLabel168.StylePriority.UseFont = false;
            this.xrLabel168.Text = "Name [See Note3]                                             ";
            // 
            // xrLabel169
            // 
            this.xrLabel169.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel169.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel169.LocationFloat = new DevExpress.Utils.PointFloat(34.2374F, 336.8103F);
            this.xrLabel169.Multiline = true;
            this.xrLabel169.Name = "xrLabel169";
            this.xrLabel169.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel169.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel169.StylePriority.UseBorders = false;
            this.xrLabel169.StylePriority.UseFont = false;
            this.xrLabel169.Text = "AIN Code of PAO/TO/CDDO";
            // 
            // xrLabel170
            // 
            this.xrLabel170.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel170.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel170.LocationFloat = new DevExpress.Utils.PointFloat(17.61364F, 359.833F);
            this.xrLabel170.Multiline = true;
            this.xrLabel170.Name = "xrLabel170";
            this.xrLabel170.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel170.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel170.StylePriority.UseBorders = false;
            this.xrLabel170.StylePriority.UseFont = false;
            this.xrLabel170.Text = "(c) Address";
            // 
            // xrLabel171
            // 
            this.xrLabel171.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel171.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel171.LocationFloat = new DevExpress.Utils.PointFloat(34.2374F, 382.8331F);
            this.xrLabel171.Multiline = true;
            this.xrLabel171.Name = "xrLabel171";
            this.xrLabel171.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel171.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel171.StylePriority.UseBorders = false;
            this.xrLabel171.StylePriority.UseFont = false;
            this.xrLabel171.Text = "Flat No.";
            // 
            // xrLabel172
            // 
            this.xrLabel172.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel172.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel172.LocationFloat = new DevExpress.Utils.PointFloat(34.2374F, 405.8331F);
            this.xrLabel172.Multiline = true;
            this.xrLabel172.Name = "xrLabel172";
            this.xrLabel172.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel172.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel172.StylePriority.UseBorders = false;
            this.xrLabel172.StylePriority.UseFont = false;
            this.xrLabel172.Text = "Name of the Premises/Building ";
            // 
            // xrLabel173
            // 
            this.xrLabel173.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel173.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel173.LocationFloat = new DevExpress.Utils.PointFloat(34.2374F, 428.8331F);
            this.xrLabel173.Multiline = true;
            this.xrLabel173.Name = "xrLabel173";
            this.xrLabel173.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel173.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel173.StylePriority.UseBorders = false;
            this.xrLabel173.StylePriority.UseFont = false;
            this.xrLabel173.Text = "Road / Street / Lane ";
            // 
            // xrLabel174
            // 
            this.xrLabel174.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel174.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel174.LocationFloat = new DevExpress.Utils.PointFloat(34.2374F, 451.8331F);
            this.xrLabel174.Multiline = true;
            this.xrLabel174.Name = "xrLabel174";
            this.xrLabel174.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel174.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel174.StylePriority.UseBorders = false;
            this.xrLabel174.StylePriority.UseFont = false;
            this.xrLabel174.Text = "Area / Location";
            // 
            // xrLabel175
            // 
            this.xrLabel175.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel175.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel175.LocationFloat = new DevExpress.Utils.PointFloat(34.2374F, 474.8331F);
            this.xrLabel175.Multiline = true;
            this.xrLabel175.Name = "xrLabel175";
            this.xrLabel175.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel175.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel175.StylePriority.UseBorders = false;
            this.xrLabel175.StylePriority.UseFont = false;
            this.xrLabel175.Text = "Town / City / District ";
            // 
            // xrLabel176
            // 
            this.xrLabel176.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel176.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel176.LocationFloat = new DevExpress.Utils.PointFloat(34.2374F, 497.8331F);
            this.xrLabel176.Multiline = true;
            this.xrLabel176.Name = "xrLabel176";
            this.xrLabel176.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel176.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel176.StylePriority.UseBorders = false;
            this.xrLabel176.StylePriority.UseFont = false;
            this.xrLabel176.Text = "State";
            // 
            // xrLabel177
            // 
            this.xrLabel177.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel177.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel177.LocationFloat = new DevExpress.Utils.PointFloat(34.2374F, 520.8331F);
            this.xrLabel177.Multiline = true;
            this.xrLabel177.Name = "xrLabel177";
            this.xrLabel177.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel177.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel177.StylePriority.UseBorders = false;
            this.xrLabel177.StylePriority.UseFont = false;
            this.xrLabel177.Text = "PIN Code";
            // 
            // xrLabel178
            // 
            this.xrLabel178.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel178.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel178.LocationFloat = new DevExpress.Utils.PointFloat(34.2374F, 543.8331F);
            this.xrLabel178.Multiline = true;
            this.xrLabel178.Name = "xrLabel178";
            this.xrLabel178.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel178.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel178.StylePriority.UseBorders = false;
            this.xrLabel178.StylePriority.UseFont = false;
            this.xrLabel178.Text = "Telephone No.";
            // 
            // xrLabel179
            // 
            this.xrLabel179.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel179.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel179.LocationFloat = new DevExpress.Utils.PointFloat(34.2374F, 566.8331F);
            this.xrLabel179.Multiline = true;
            this.xrLabel179.Name = "xrLabel179";
            this.xrLabel179.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel179.SizeF = new System.Drawing.SizeF(226.4545F, 22.99997F);
            this.xrLabel179.StylePriority.UseBorders = false;
            this.xrLabel179.StylePriority.UseFont = false;
            this.xrLabel179.Text = "Alternate Telephone No [See Note 4]";
            // 
            // xrLabel180
            // 
            this.xrLabel180.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel180.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel180.LocationFloat = new DevExpress.Utils.PointFloat(34.2374F, 589.8331F);
            this.xrLabel180.Multiline = true;
            this.xrLabel180.Name = "xrLabel180";
            this.xrLabel180.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel180.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel180.StylePriority.UseBorders = false;
            this.xrLabel180.StylePriority.UseFont = false;
            this.xrLabel180.Text = "Email";
            // 
            // xrLabel181
            // 
            this.xrLabel181.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel181.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel181.LocationFloat = new DevExpress.Utils.PointFloat(34.2374F, 612.8333F);
            this.xrLabel181.Multiline = true;
            this.xrLabel181.Name = "xrLabel181";
            this.xrLabel181.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel181.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel181.StylePriority.UseBorders = false;
            this.xrLabel181.StylePriority.UseFont = false;
            this.xrLabel181.Text = "Alternate email [See Note 4]";
            // 
            // xrLabel182
            // 
            this.xrLabel182.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel182.LocationFloat = new DevExpress.Utils.PointFloat(260.6919F, 313.8103F);
            this.xrLabel182.Multiline = true;
            this.xrLabel182.Name = "xrLabel182";
            this.xrLabel182.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel182.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel182.StylePriority.UseBorders = false;
            this.xrLabel182.Text = ":";
            // 
            // xrLabel183
            // 
            this.xrLabel183.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel183.LocationFloat = new DevExpress.Utils.PointFloat(260.6919F, 336.8103F);
            this.xrLabel183.Multiline = true;
            this.xrLabel183.Name = "xrLabel183";
            this.xrLabel183.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel183.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel183.StylePriority.UseBorders = false;
            this.xrLabel183.Text = ":";
            // 
            // xrLabel184
            // 
            this.xrLabel184.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel184.LocationFloat = new DevExpress.Utils.PointFloat(260.6919F, 382.8331F);
            this.xrLabel184.Multiline = true;
            this.xrLabel184.Name = "xrLabel184";
            this.xrLabel184.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel184.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel184.StylePriority.UseBorders = false;
            this.xrLabel184.Text = ":";
            // 
            // xrLabel185
            // 
            this.xrLabel185.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel185.LocationFloat = new DevExpress.Utils.PointFloat(260.6919F, 405.8331F);
            this.xrLabel185.Multiline = true;
            this.xrLabel185.Name = "xrLabel185";
            this.xrLabel185.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel185.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel185.StylePriority.UseBorders = false;
            this.xrLabel185.Text = ":";
            // 
            // xrLabel186
            // 
            this.xrLabel186.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel186.LocationFloat = new DevExpress.Utils.PointFloat(260.6919F, 428.8331F);
            this.xrLabel186.Multiline = true;
            this.xrLabel186.Name = "xrLabel186";
            this.xrLabel186.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel186.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel186.StylePriority.UseBorders = false;
            this.xrLabel186.Text = ":";
            // 
            // xrLabel187
            // 
            this.xrLabel187.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel187.LocationFloat = new DevExpress.Utils.PointFloat(260.6919F, 451.8331F);
            this.xrLabel187.Multiline = true;
            this.xrLabel187.Name = "xrLabel187";
            this.xrLabel187.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel187.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel187.StylePriority.UseBorders = false;
            this.xrLabel187.Text = ":";
            // 
            // xrLabel188
            // 
            this.xrLabel188.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel188.LocationFloat = new DevExpress.Utils.PointFloat(260.6919F, 474.8331F);
            this.xrLabel188.Multiline = true;
            this.xrLabel188.Name = "xrLabel188";
            this.xrLabel188.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel188.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel188.StylePriority.UseBorders = false;
            this.xrLabel188.Text = ":";
            // 
            // xrLabel189
            // 
            this.xrLabel189.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel189.LocationFloat = new DevExpress.Utils.PointFloat(260.6919F, 497.8331F);
            this.xrLabel189.Multiline = true;
            this.xrLabel189.Name = "xrLabel189";
            this.xrLabel189.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel189.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel189.StylePriority.UseBorders = false;
            this.xrLabel189.Text = ":";
            // 
            // xrLabel190
            // 
            this.xrLabel190.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel190.LocationFloat = new DevExpress.Utils.PointFloat(260.6919F, 520.8331F);
            this.xrLabel190.Multiline = true;
            this.xrLabel190.Name = "xrLabel190";
            this.xrLabel190.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel190.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel190.StylePriority.UseBorders = false;
            this.xrLabel190.Text = ":";
            // 
            // xrLabel191
            // 
            this.xrLabel191.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel191.LocationFloat = new DevExpress.Utils.PointFloat(260.6919F, 543.8331F);
            this.xrLabel191.Multiline = true;
            this.xrLabel191.Name = "xrLabel191";
            this.xrLabel191.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel191.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel191.StylePriority.UseBorders = false;
            this.xrLabel191.Text = ":";
            // 
            // xrLabel192
            // 
            this.xrLabel192.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel192.LocationFloat = new DevExpress.Utils.PointFloat(260.6919F, 566.8331F);
            this.xrLabel192.Multiline = true;
            this.xrLabel192.Name = "xrLabel192";
            this.xrLabel192.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel192.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel192.StylePriority.UseBorders = false;
            this.xrLabel192.Text = ":";
            // 
            // xrLabel193
            // 
            this.xrLabel193.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel193.LocationFloat = new DevExpress.Utils.PointFloat(260.6919F, 589.8333F);
            this.xrLabel193.Multiline = true;
            this.xrLabel193.Name = "xrLabel193";
            this.xrLabel193.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel193.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel193.StylePriority.UseBorders = false;
            this.xrLabel193.Text = ":";
            // 
            // xrLabel194
            // 
            this.xrLabel194.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel194.LocationFloat = new DevExpress.Utils.PointFloat(260.6919F, 612.8333F);
            this.xrLabel194.Multiline = true;
            this.xrLabel194.Name = "xrLabel194";
            this.xrLabel194.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel194.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel194.StylePriority.UseBorders = false;
            this.xrLabel194.Text = ":";
            // 
            // xrLabel202
            // 
            this.xrLabel202.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel202.Font = new System.Drawing.Font("Arial Narrow", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel202.LocationFloat = new DevExpress.Utils.PointFloat(499.2326F, 244.7043F);
            this.xrLabel202.Multiline = true;
            this.xrLabel202.Name = "xrLabel202";
            this.xrLabel202.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel202.SizeF = new System.Drawing.SizeF(17.61364F, 23F);
            this.xrLabel202.StylePriority.UseBorders = false;
            this.xrLabel202.StylePriority.UseFont = false;
            this.xrLabel202.Text = "3. ";
            // 
            // xrLabel203
            // 
            this.xrLabel203.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel203.Font = new System.Drawing.Font("Arial Narrow", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel203.LocationFloat = new DevExpress.Utils.PointFloat(516.8463F, 244.7043F);
            this.xrLabel203.Multiline = true;
            this.xrLabel203.Name = "xrLabel203";
            this.xrLabel203.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel203.SizeF = new System.Drawing.SizeF(299.8964F, 23F);
            this.xrLabel203.StylePriority.UseBorders = false;
            this.xrLabel203.StylePriority.UseFont = false;
            this.xrLabel203.Text = "Particulars of the person responsible for collection of tax";
            // 
            // xrLabel204
            // 
            this.xrLabel204.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel204.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel204.LocationFloat = new DevExpress.Utils.PointFloat(516.8463F, 267.7043F);
            this.xrLabel204.Multiline = true;
            this.xrLabel204.Name = "xrLabel204";
            this.xrLabel204.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel204.SizeF = new System.Drawing.SizeF(247.1659F, 23F);
            this.xrLabel204.StylePriority.UseBorders = false;
            this.xrLabel204.StylePriority.UseFont = false;
            this.xrLabel204.Text = "(a) Name";
            // 
            // xrLabel205
            // 
            this.xrLabel205.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel205.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel205.LocationFloat = new DevExpress.Utils.PointFloat(516.8463F, 290.7043F);
            this.xrLabel205.Multiline = true;
            this.xrLabel205.Name = "xrLabel205";
            this.xrLabel205.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel205.SizeF = new System.Drawing.SizeF(247.1658F, 22.99998F);
            this.xrLabel205.StylePriority.UseBorders = false;
            this.xrLabel205.StylePriority.UseFont = false;
            this.xrLabel205.Text = "(b) PAN of person responsible";
            // 
            // xrLabel206
            // 
            this.xrLabel206.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel206.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel206.LocationFloat = new DevExpress.Utils.PointFloat(516.8463F, 313.7043F);
            this.xrLabel206.Multiline = true;
            this.xrLabel206.Name = "xrLabel206";
            this.xrLabel206.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel206.SizeF = new System.Drawing.SizeF(247.1658F, 22.99998F);
            this.xrLabel206.StylePriority.UseBorders = false;
            this.xrLabel206.StylePriority.UseFont = false;
            this.xrLabel206.Text = "(c) Address";
            // 
            // xrLabel207
            // 
            this.xrLabel207.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel207.LocationFloat = new DevExpress.Utils.PointFloat(764.0121F, 544.6895F);
            this.xrLabel207.Multiline = true;
            this.xrLabel207.Name = "xrLabel207";
            this.xrLabel207.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel207.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel207.StylePriority.UseBorders = false;
            this.xrLabel207.Text = ":";
            // 
            // xrLabel208
            // 
            this.xrLabel208.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel208.LocationFloat = new DevExpress.Utils.PointFloat(764.0121F, 521.6892F);
            this.xrLabel208.Multiline = true;
            this.xrLabel208.Name = "xrLabel208";
            this.xrLabel208.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel208.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel208.StylePriority.UseBorders = false;
            this.xrLabel208.Text = ":";
            // 
            // xrLabel209
            // 
            this.xrLabel209.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel209.LocationFloat = new DevExpress.Utils.PointFloat(764.0121F, 498.6892F);
            this.xrLabel209.Multiline = true;
            this.xrLabel209.Name = "xrLabel209";
            this.xrLabel209.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel209.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel209.StylePriority.UseBorders = false;
            this.xrLabel209.Text = ":";
            // 
            // xrLabel210
            // 
            this.xrLabel210.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel210.LocationFloat = new DevExpress.Utils.PointFloat(764.0121F, 475.6892F);
            this.xrLabel210.Multiline = true;
            this.xrLabel210.Name = "xrLabel210";
            this.xrLabel210.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel210.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel210.StylePriority.UseBorders = false;
            this.xrLabel210.Text = ":";
            // 
            // xrLabel211
            // 
            this.xrLabel211.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel211.LocationFloat = new DevExpress.Utils.PointFloat(764.0121F, 452.6892F);
            this.xrLabel211.Multiline = true;
            this.xrLabel211.Name = "xrLabel211";
            this.xrLabel211.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel211.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel211.StylePriority.UseBorders = false;
            this.xrLabel211.Text = ":";
            // 
            // xrLabel212
            // 
            this.xrLabel212.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel212.LocationFloat = new DevExpress.Utils.PointFloat(764.0121F, 429.6892F);
            this.xrLabel212.Multiline = true;
            this.xrLabel212.Name = "xrLabel212";
            this.xrLabel212.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel212.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel212.StylePriority.UseBorders = false;
            this.xrLabel212.Text = ":";
            // 
            // xrLabel213
            // 
            this.xrLabel213.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel213.LocationFloat = new DevExpress.Utils.PointFloat(764.0121F, 406.6892F);
            this.xrLabel213.Multiline = true;
            this.xrLabel213.Name = "xrLabel213";
            this.xrLabel213.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel213.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel213.StylePriority.UseBorders = false;
            this.xrLabel213.Text = ":";
            // 
            // xrLabel214
            // 
            this.xrLabel214.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel214.LocationFloat = new DevExpress.Utils.PointFloat(764.0121F, 383.6892F);
            this.xrLabel214.Multiline = true;
            this.xrLabel214.Name = "xrLabel214";
            this.xrLabel214.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel214.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel214.StylePriority.UseBorders = false;
            this.xrLabel214.Text = ":";
            // 
            // xrLabel215
            // 
            this.xrLabel215.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel215.LocationFloat = new DevExpress.Utils.PointFloat(764.0121F, 360.6892F);
            this.xrLabel215.Multiline = true;
            this.xrLabel215.Name = "xrLabel215";
            this.xrLabel215.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel215.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel215.StylePriority.UseBorders = false;
            this.xrLabel215.Text = ":";
            // 
            // xrLabel216
            // 
            this.xrLabel216.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel216.LocationFloat = new DevExpress.Utils.PointFloat(764.0121F, 337.6892F);
            this.xrLabel216.Multiline = true;
            this.xrLabel216.Name = "xrLabel216";
            this.xrLabel216.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel216.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel216.StylePriority.UseBorders = false;
            this.xrLabel216.Text = ":";
            // 
            // xrLabel217
            // 
            this.xrLabel217.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel217.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel217.LocationFloat = new DevExpress.Utils.PointFloat(537.5577F, 544.6892F);
            this.xrLabel217.Multiline = true;
            this.xrLabel217.Name = "xrLabel217";
            this.xrLabel217.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel217.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel217.StylePriority.UseBorders = false;
            this.xrLabel217.StylePriority.UseFont = false;
            this.xrLabel217.Text = "Email";
            // 
            // xrLabel218
            // 
            this.xrLabel218.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel218.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel218.LocationFloat = new DevExpress.Utils.PointFloat(537.5577F, 521.6892F);
            this.xrLabel218.Multiline = true;
            this.xrLabel218.Name = "xrLabel218";
            this.xrLabel218.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel218.SizeF = new System.Drawing.SizeF(226.4545F, 22.99997F);
            this.xrLabel218.StylePriority.UseBorders = false;
            this.xrLabel218.StylePriority.UseFont = false;
            this.xrLabel218.Text = "Alternate Telephone No [See Note 4]";
            // 
            // xrLabel219
            // 
            this.xrLabel219.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel219.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel219.LocationFloat = new DevExpress.Utils.PointFloat(537.5577F, 498.6892F);
            this.xrLabel219.Multiline = true;
            this.xrLabel219.Name = "xrLabel219";
            this.xrLabel219.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel219.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel219.StylePriority.UseBorders = false;
            this.xrLabel219.StylePriority.UseFont = false;
            this.xrLabel219.Text = "Telephone No.";
            // 
            // xrLabel220
            // 
            this.xrLabel220.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel220.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel220.LocationFloat = new DevExpress.Utils.PointFloat(537.5577F, 475.6892F);
            this.xrLabel220.Multiline = true;
            this.xrLabel220.Name = "xrLabel220";
            this.xrLabel220.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel220.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel220.StylePriority.UseBorders = false;
            this.xrLabel220.StylePriority.UseFont = false;
            this.xrLabel220.Text = "PIN Code";
            // 
            // xrLabel221
            // 
            this.xrLabel221.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel221.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel221.LocationFloat = new DevExpress.Utils.PointFloat(537.5577F, 452.6892F);
            this.xrLabel221.Multiline = true;
            this.xrLabel221.Name = "xrLabel221";
            this.xrLabel221.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel221.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel221.StylePriority.UseBorders = false;
            this.xrLabel221.StylePriority.UseFont = false;
            this.xrLabel221.Text = "State";
            // 
            // xrLabel222
            // 
            this.xrLabel222.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel222.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel222.LocationFloat = new DevExpress.Utils.PointFloat(537.5577F, 429.6892F);
            this.xrLabel222.Multiline = true;
            this.xrLabel222.Name = "xrLabel222";
            this.xrLabel222.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel222.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel222.StylePriority.UseBorders = false;
            this.xrLabel222.StylePriority.UseFont = false;
            this.xrLabel222.Text = "Town / City / District ";
            // 
            // xrLabel223
            // 
            this.xrLabel223.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel223.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel223.LocationFloat = new DevExpress.Utils.PointFloat(537.5577F, 406.6892F);
            this.xrLabel223.Multiline = true;
            this.xrLabel223.Name = "xrLabel223";
            this.xrLabel223.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel223.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel223.StylePriority.UseBorders = false;
            this.xrLabel223.StylePriority.UseFont = false;
            this.xrLabel223.Text = "Area / Location";
            // 
            // xrLabel224
            // 
            this.xrLabel224.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel224.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel224.LocationFloat = new DevExpress.Utils.PointFloat(537.5577F, 383.6892F);
            this.xrLabel224.Multiline = true;
            this.xrLabel224.Name = "xrLabel224";
            this.xrLabel224.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel224.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel224.StylePriority.UseBorders = false;
            this.xrLabel224.StylePriority.UseFont = false;
            this.xrLabel224.Text = "Road / Street / Lane ";
            // 
            // xrLabel225
            // 
            this.xrLabel225.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel225.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel225.LocationFloat = new DevExpress.Utils.PointFloat(537.5577F, 360.6892F);
            this.xrLabel225.Multiline = true;
            this.xrLabel225.Name = "xrLabel225";
            this.xrLabel225.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel225.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel225.StylePriority.UseBorders = false;
            this.xrLabel225.StylePriority.UseFont = false;
            this.xrLabel225.Text = "Name of the Premises/Building ";
            // 
            // xrLabel226
            // 
            this.xrLabel226.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel226.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel226.LocationFloat = new DevExpress.Utils.PointFloat(537.5577F, 337.6892F);
            this.xrLabel226.Multiline = true;
            this.xrLabel226.Name = "xrLabel226";
            this.xrLabel226.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel226.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel226.StylePriority.UseBorders = false;
            this.xrLabel226.StylePriority.UseFont = false;
            this.xrLabel226.Text = "Flat No.";
            // 
            // xrLabel227
            // 
            this.xrLabel227.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel227.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel227.LocationFloat = new DevExpress.Utils.PointFloat(537.5577F, 567.6893F);
            this.xrLabel227.Multiline = true;
            this.xrLabel227.Name = "xrLabel227";
            this.xrLabel227.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel227.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel227.StylePriority.UseBorders = false;
            this.xrLabel227.StylePriority.UseFont = false;
            this.xrLabel227.Text = "Alternate email [See Note 4]";
            // 
            // xrLabel228
            // 
            this.xrLabel228.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel228.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel228.LocationFloat = new DevExpress.Utils.PointFloat(537.5577F, 590.6893F);
            this.xrLabel228.Multiline = true;
            this.xrLabel228.Name = "xrLabel228";
            this.xrLabel228.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel228.SizeF = new System.Drawing.SizeF(226.4545F, 23F);
            this.xrLabel228.StylePriority.UseBorders = false;
            this.xrLabel228.StylePriority.UseFont = false;
            this.xrLabel228.Text = "Mobile No.";
            // 
            // xrLabel229
            // 
            this.xrLabel229.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel229.LocationFloat = new DevExpress.Utils.PointFloat(764.0121F, 567.6893F);
            this.xrLabel229.Multiline = true;
            this.xrLabel229.Name = "xrLabel229";
            this.xrLabel229.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel229.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel229.StylePriority.UseBorders = false;
            this.xrLabel229.Text = ":";
            // 
            // xrLabel230
            // 
            this.xrLabel230.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel230.LocationFloat = new DevExpress.Utils.PointFloat(764.0121F, 590.6895F);
            this.xrLabel230.Multiline = true;
            this.xrLabel230.Name = "xrLabel230";
            this.xrLabel230.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel230.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel230.StylePriority.UseBorders = false;
            this.xrLabel230.Text = ":";
            // 
            // xrLabel231
            // 
            this.xrLabel231.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel231.LocationFloat = new DevExpress.Utils.PointFloat(764.0121F, 313.7043F);
            this.xrLabel231.Multiline = true;
            this.xrLabel231.Name = "xrLabel231";
            this.xrLabel231.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel231.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel231.StylePriority.UseBorders = false;
            this.xrLabel231.Text = ":";
            // 
            // xrLabel232
            // 
            this.xrLabel232.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel232.LocationFloat = new DevExpress.Utils.PointFloat(764.0121F, 290.7043F);
            this.xrLabel232.Multiline = true;
            this.xrLabel232.Name = "xrLabel232";
            this.xrLabel232.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel232.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel232.StylePriority.UseBorders = false;
            this.xrLabel232.Text = ":";
            // 
            // xrLabel233
            // 
            this.xrLabel233.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel233.LocationFloat = new DevExpress.Utils.PointFloat(764.0121F, 267.7043F);
            this.xrLabel233.Multiline = true;
            this.xrLabel233.Name = "xrLabel233";
            this.xrLabel233.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel233.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel233.StylePriority.UseBorders = false;
            this.xrLabel233.Text = ":";
            // 
            // xrLabel126
            // 
            this.xrLabel126.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel126.LocationFloat = new DevExpress.Utils.PointFloat(360.3835F, 210.8104F);
            this.xrLabel126.Multiline = true;
            this.xrLabel126.Name = "xrLabel126";
            this.xrLabel126.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel126.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel126.StylePriority.UseBorders = false;
            this.xrLabel126.Text = ":";
            // 
            // xrLabel127
            // 
            this.xrLabel127.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel127.LocationFloat = new DevExpress.Utils.PointFloat(360.3835F, 187.8104F);
            this.xrLabel127.Multiline = true;
            this.xrLabel127.Name = "xrLabel127";
            this.xrLabel127.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel127.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel127.StylePriority.UseBorders = false;
            this.xrLabel127.Text = ":";
            // 
            // xrLabel128
            // 
            this.xrLabel128.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel128.LocationFloat = new DevExpress.Utils.PointFloat(360.3835F, 164.8104F);
            this.xrLabel128.Multiline = true;
            this.xrLabel128.Name = "xrLabel128";
            this.xrLabel128.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel128.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel128.StylePriority.UseBorders = false;
            this.xrLabel128.Text = ":";
            // 
            // xrLabel129
            // 
            this.xrLabel129.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel129.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?FY")});
            this.xrLabel129.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel129.LocationFloat = new DevExpress.Utils.PointFloat(375.6411F, 210.8103F);
            this.xrLabel129.Multiline = true;
            this.xrLabel129.Name = "xrLabel129";
            this.xrLabel129.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel129.SizeF = new System.Drawing.SizeF(115.6947F, 23F);
            this.xrLabel129.StylePriority.UseBorders = false;
            this.xrLabel129.StylePriority.UseFont = false;
            this.xrLabel129.Text = "xrLabel121";
            // 
            // xrLabel158
            // 
            this.xrLabel158.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel158.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?PANNo")});
            this.xrLabel158.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel158.LocationFloat = new DevExpress.Utils.PointFloat(375.6411F, 187.8103F);
            this.xrLabel158.Multiline = true;
            this.xrLabel158.Name = "xrLabel158";
            this.xrLabel158.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel158.SizeF = new System.Drawing.SizeF(115.6947F, 22.99999F);
            this.xrLabel158.StylePriority.UseBorders = false;
            this.xrLabel158.StylePriority.UseFont = false;
            this.xrLabel158.Text = "xrLabel89";
            // 
            // xrLabel159
            // 
            this.xrLabel159.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel159.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?TANNo")});
            this.xrLabel159.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel159.LocationFloat = new DevExpress.Utils.PointFloat(375.6411F, 164.8104F);
            this.xrLabel159.Multiline = true;
            this.xrLabel159.Name = "xrLabel159";
            this.xrLabel159.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel159.SizeF = new System.Drawing.SizeF(115.6947F, 23F);
            this.xrLabel159.StylePriority.UseBorders = false;
            this.xrLabel159.StylePriority.UseFont = false;
            this.xrLabel159.Text = "xrLabel88";
            // 
            // xrLabel160
            // 
            this.xrLabel160.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel160.Font = new System.Drawing.Font("Arial Narrow", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel160.LocationFloat = new DevExpress.Utils.PointFloat(5.670691F, 164.8104F);
            this.xrLabel160.Multiline = true;
            this.xrLabel160.Name = "xrLabel160";
            this.xrLabel160.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel160.SizeF = new System.Drawing.SizeF(17.61364F, 23F);
            this.xrLabel160.StylePriority.UseBorders = false;
            this.xrLabel160.StylePriority.UseFont = false;
            this.xrLabel160.Text = "1. ";
            // 
            // xrLabel161
            // 
            this.xrLabel161.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel161.Font = new System.Drawing.Font("Arial Narrow", 9F, System.Drawing.FontStyle.Bold);
            this.xrLabel161.LocationFloat = new DevExpress.Utils.PointFloat(23.28434F, 164.8104F);
            this.xrLabel161.Multiline = true;
            this.xrLabel161.Name = "xrLabel161";
            this.xrLabel161.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel161.SizeF = new System.Drawing.SizeF(299.8964F, 23F);
            this.xrLabel161.StylePriority.UseBorders = false;
            this.xrLabel161.StylePriority.UseFont = false;
            this.xrLabel161.Text = "(a) Tax Deduction and Collection Account Number (TAN)                  ";
            // 
            // xrLabel162
            // 
            this.xrLabel162.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel162.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel162.LocationFloat = new DevExpress.Utils.PointFloat(17.61363F, 187.8104F);
            this.xrLabel162.Multiline = true;
            this.xrLabel162.Name = "xrLabel162";
            this.xrLabel162.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel162.SizeF = new System.Drawing.SizeF(305.5671F, 23F);
            this.xrLabel162.StylePriority.UseBorders = false;
            this.xrLabel162.StylePriority.UseFont = false;
            this.xrLabel162.Text = "(b) Parmanent Account Number (PAN) [See Note 1]                            ";
            // 
            // xrLabel163
            // 
            this.xrLabel163.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel163.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel163.LocationFloat = new DevExpress.Utils.PointFloat(17.61363F, 210.8104F);
            this.xrLabel163.Multiline = true;
            this.xrLabel163.Name = "xrLabel163";
            this.xrLabel163.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel163.SizeF = new System.Drawing.SizeF(305.5671F, 23F);
            this.xrLabel163.StylePriority.UseBorders = false;
            this.xrLabel163.StylePriority.UseFont = false;
            this.xrLabel163.Text = "(c) financial Year                                                               " +
    "                    ";
            // 
            // xrLabel195
            // 
            this.xrLabel195.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel195.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel195.LocationFloat = new DevExpress.Utils.PointFloat(502.0455F, 210.8103F);
            this.xrLabel195.Multiline = true;
            this.xrLabel195.Name = "xrLabel195";
            this.xrLabel195.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel195.SizeF = new System.Drawing.SizeF(328.3055F, 23F);
            this.xrLabel195.StylePriority.UseBorders = false;
            this.xrLabel195.StylePriority.UseFont = false;
            this.xrLabel195.Text = "(f) Type of Collector (See Note 2)";
            // 
            // xrLabel196
            // 
            this.xrLabel196.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel196.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel196.LocationFloat = new DevExpress.Utils.PointFloat(502.0455F, 187.8104F);
            this.xrLabel196.Multiline = true;
            this.xrLabel196.Name = "xrLabel196";
            this.xrLabel196.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel196.SizeF = new System.Drawing.SizeF(328.3055F, 22.99999F);
            this.xrLabel196.StylePriority.UseBorders = false;
            this.xrLabel196.StylePriority.UseFont = false;
            this.xrLabel196.Text = "(e) If answer to (d) is \"Yes\" then token No. of original statement";
            // 
            // xrLabel197
            // 
            this.xrLabel197.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel197.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel197.LocationFloat = new DevExpress.Utils.PointFloat(502.0455F, 164.8104F);
            this.xrLabel197.Multiline = true;
            this.xrLabel197.Name = "xrLabel197";
            this.xrLabel197.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel197.SizeF = new System.Drawing.SizeF(328.3055F, 23F);
            this.xrLabel197.StylePriority.UseBorders = false;
            this.xrLabel197.StylePriority.UseFont = false;
            this.xrLabel197.Text = "(d) Has the statement been filed earlier for this quarter (Yes/No)";
            // 
            // xrLabel198
            // 
            this.xrLabel198.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel198.LocationFloat = new DevExpress.Utils.PointFloat(830.351F, 164.8104F);
            this.xrLabel198.Multiline = true;
            this.xrLabel198.Name = "xrLabel198";
            this.xrLabel198.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel198.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel198.StylePriority.UseBorders = false;
            this.xrLabel198.Text = ":";
            // 
            // xrLabel199
            // 
            this.xrLabel199.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel199.LocationFloat = new DevExpress.Utils.PointFloat(830.3511F, 187.8104F);
            this.xrLabel199.Multiline = true;
            this.xrLabel199.Name = "xrLabel199";
            this.xrLabel199.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel199.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel199.StylePriority.UseBorders = false;
            this.xrLabel199.Text = ":";
            // 
            // xrLabel200
            // 
            this.xrLabel200.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel200.LocationFloat = new DevExpress.Utils.PointFloat(830.3511F, 210.8103F);
            this.xrLabel200.Multiline = true;
            this.xrLabel200.Name = "xrLabel200";
            this.xrLabel200.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel200.SizeF = new System.Drawing.SizeF(15.25757F, 23F);
            this.xrLabel200.StylePriority.UseBorders = false;
            this.xrLabel200.Text = ":";
            // 
            // xrLabel201
            // 
            this.xrLabel201.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel201.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel201.LocationFloat = new DevExpress.Utils.PointFloat(845.6088F, 210.8103F);
            this.xrLabel201.Multiline = true;
            this.xrLabel201.Name = "xrLabel201";
            this.xrLabel201.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel201.SizeF = new System.Drawing.SizeF(112.3911F, 23F);
            this.xrLabel201.StylePriority.UseBorders = false;
            this.xrLabel201.StylePriority.UseFont = false;
            this.xrLabel201.Text = "K- company";
            // 
            // xrLabel4
            // 
            this.xrLabel4.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel4.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel4.LocationFloat = new DevExpress.Utils.PointFloat(286.3892F, 105.8104F);
            this.xrLabel4.Multiline = true;
            this.xrLabel4.Name = "xrLabel4";
            this.xrLabel4.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel4.SizeF = new System.Drawing.SizeF(139.78F, 23F);
            this.xrLabel4.StylePriority.UseBorders = false;
            this.xrLabel4.StylePriority.UseFont = false;
            this.xrLabel4.StylePriority.UseTextAlignment = false;
            this.xrLabel4.Text = "quarter ended";
            this.xrLabel4.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // xrLabel3
            // 
            this.xrLabel3.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel3.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel3.LocationFloat = new DevExpress.Utils.PointFloat(11.37498F, 82.81043F);
            this.xrLabel3.Multiline = true;
            this.xrLabel3.Name = "xrLabel3";
            this.xrLabel3.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel3.SizeF = new System.Drawing.SizeF(971.1628F, 23F);
            this.xrLabel3.StylePriority.UseBorders = false;
            this.xrLabel3.StylePriority.UseFont = false;
            this.xrLabel3.StylePriority.UseTextAlignment = false;
            this.xrLabel3.Text = "Quarterly statement of collection of tax under sub-section(3) of section 200 of t" +
    "he Income-tax Act in respect of payments other than salary made to non residents" +
    " for  the";
            this.xrLabel3.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel2
            // 
            this.xrLabel2.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel2.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel2.LocationFloat = new DevExpress.Utils.PointFloat(11.37498F, 59.81044F);
            this.xrLabel2.Multiline = true;
            this.xrLabel2.Name = "xrLabel2";
            this.xrLabel2.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel2.SizeF = new System.Drawing.SizeF(971.1628F, 23F);
            this.xrLabel2.StylePriority.UseBorders = false;
            this.xrLabel2.StylePriority.UseFont = false;
            this.xrLabel2.StylePriority.UseTextAlignment = false;
            this.xrLabel2.Text = "[See sections 194E,194LB,194LC,195,196A,196B,196C,196D and rule 31A ]";
            this.xrLabel2.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel1
            // 
            this.xrLabel1.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabel1.Font = new System.Drawing.Font("Arial", 10F, System.Drawing.FontStyle.Bold);
            this.xrLabel1.LocationFloat = new DevExpress.Utils.PointFloat(11.37498F, 36.81042F);
            this.xrLabel1.Multiline = true;
            this.xrLabel1.Name = "xrLabel1";
            this.xrLabel1.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel1.SizeF = new System.Drawing.SizeF(971.1628F, 23F);
            this.xrLabel1.StylePriority.UseBorders = false;
            this.xrLabel1.StylePriority.UseFont = false;
            this.xrLabel1.StylePriority.UseTextAlignment = false;
            this.xrLabel1.Text = "Form No.27Q";
            this.xrLabel1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // GroupHeader1
            // 
            this.GroupHeader1.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.table1});
            this.GroupHeader1.GroupUnion = DevExpress.XtraReports.UI.GroupUnion.WithFirstDetail;
            this.GroupHeader1.HeightF = 84F;
            this.GroupHeader1.KeepTogether = true;
            this.GroupHeader1.Name = "GroupHeader1";
            this.GroupHeader1.RepeatEveryPage = true;
            // 
            // table1
            // 
            this.table1.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.table1.Name = "table1";
            this.table1.Rows.AddRange(new DevExpress.XtraReports.UI.XRTableRow[] {
            this.xrTableRow2,
            this.tableRow1,
            this.xrTableRow1});
            this.table1.SizeF = new System.Drawing.SizeF(1013F, 84F);
            this.table1.StylePriority.UseTextAlignment = false;
            this.table1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrTableRow2
            // 
            this.xrTableRow2.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell28});
            this.xrTableRow2.Name = "xrTableRow2";
            this.xrTableRow2.Weight = 1D;
            // 
            // xrTableCell28
            // 
            this.xrTableCell28.BackColor = System.Drawing.Color.Transparent;
            this.xrTableCell28.Font = new System.Drawing.Font("Arial Narrow", 9F, System.Drawing.FontStyle.Bold);
            this.xrTableCell28.Multiline = true;
            this.xrTableCell28.Name = "xrTableCell28";
            this.xrTableCell28.StyleName = "DetailCaption1";
            this.xrTableCell28.StylePriority.UseBackColor = false;
            this.xrTableCell28.StylePriority.UseFont = false;
            this.xrTableCell28.StylePriority.UseTextAlignment = false;
            this.xrTableCell28.Text = "4. Details of tax deducted and paid to the credit of the Government";
            this.xrTableCell28.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            this.xrTableCell28.Weight = 1.1255555141228846D;
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
            this.tableCell12,
            this.xrTableCell1});
            this.tableRow1.Name = "tableRow1";
            this.tableRow1.Weight = 1D;
            // 
            // tableCell1
            // 
            this.tableCell1.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.tableCell1.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableCell1.Multiline = true;
            this.tableCell1.Name = "tableCell1";
            this.tableCell1.StyleName = "DetailCaption1";
            this.tableCell1.StylePriority.UseBorders = false;
            this.tableCell1.StylePriority.UseFont = false;
            this.tableCell1.StylePriority.UseTextAlignment = false;
            this.tableCell1.Text = "Sr\r\nNo.";
            this.tableCell1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.tableCell1.Weight = 0.0408663092719184D;
            // 
            // tableCell2
            // 
            this.tableCell2.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableCell2.Multiline = true;
            this.tableCell2.Name = "tableCell2";
            this.tableCell2.StyleName = "DetailCaption1";
            this.tableCell2.StylePriority.UseFont = false;
            this.tableCell2.StylePriority.UseTextAlignment = false;
            this.tableCell2.Text = "TDS \r\nAmount";
            this.tableCell2.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.tableCell2.Weight = 0.0702448057347245D;
            // 
            // tableCell3
            // 
            this.tableCell3.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableCell3.Name = "tableCell3";
            this.tableCell3.StyleName = "DetailCaption1";
            this.tableCell3.StylePriority.UseFont = false;
            this.tableCell3.StylePriority.UseTextAlignment = false;
            this.tableCell3.Text = "Surcharge";
            this.tableCell3.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.tableCell3.Weight = 0.086595294023847552D;
            // 
            // tableCell4
            // 
            this.tableCell4.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableCell4.Name = "tableCell4";
            this.tableCell4.StyleName = "DetailCaption1";
            this.tableCell4.StylePriority.UseFont = false;
            this.tableCell4.StylePriority.UseTextAlignment = false;
            this.tableCell4.Text = "ECess";
            this.tableCell4.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.tableCell4.Weight = 0.080147115413090692D;
            // 
            // tableCell5
            // 
            this.tableCell5.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableCell5.Name = "tableCell5";
            this.tableCell5.StyleName = "DetailCaption1";
            this.tableCell5.StylePriority.UseFont = false;
            this.tableCell5.StylePriority.UseTextAlignment = false;
            this.tableCell5.Text = "Interest ";
            this.tableCell5.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.tableCell5.Weight = 0.06802846663159684D;
            // 
            // tableCell6
            // 
            this.tableCell6.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableCell6.Multiline = true;
            this.tableCell6.Name = "tableCell6";
            this.tableCell6.StyleName = "DetailCaption1";
            this.tableCell6.StylePriority.UseFont = false;
            this.tableCell6.StylePriority.UseTextAlignment = false;
            this.tableCell6.Text = "Fee\r\n(See Note 5)";
            this.tableCell6.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.tableCell6.Weight = 0.090447591200093824D;
            // 
            // tableCell7
            // 
            this.tableCell7.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableCell7.Multiline = true;
            this.tableCell7.Name = "tableCell7";
            this.tableCell7.StyleName = "DetailCaption1";
            this.tableCell7.StylePriority.UseFont = false;
            this.tableCell7.StylePriority.UseTextAlignment = false;
            this.tableCell7.Text = "Penalty /\r\nOthers";
            this.tableCell7.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.tableCell7.Weight = 0.071353793022907064D;
            // 
            // tableCell8
            // 
            this.tableCell8.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableCell8.Multiline = true;
            this.tableCell8.Name = "tableCell8";
            this.tableCell8.StyleName = "DetailCaption1";
            this.tableCell8.StylePriority.UseFont = false;
            this.tableCell8.StylePriority.UseTextAlignment = false;
            this.tableCell8.Text = "Total amount deposited as\r\nper Challan / Book\r\nAdjusment\r\n(702+703+704+705+706+70" +
    "7)\r\n(See Note 6)";
            this.tableCell8.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.tableCell8.Weight = 0.21361439432818585D;
            // 
            // tableCell9
            // 
            this.tableCell9.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableCell9.Multiline = true;
            this.tableCell9.Name = "tableCell9";
            this.tableCell9.StyleName = "DetailCaption1";
            this.tableCell9.StylePriority.UseFont = false;
            this.tableCell9.StylePriority.UseTextAlignment = false;
            this.tableCell9.Text = "Mode of\r\ndeposit\r\nthrough\r\nChallan(C)/\r\nBook\r\nAdjusment(B)\r\n(See 7)\r\n";
            this.tableCell9.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.tableCell9.Weight = 0.069950425782184411D;
            // 
            // tableCell10
            // 
            this.tableCell10.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableCell10.Multiline = true;
            this.tableCell10.Name = "tableCell10";
            this.tableCell10.StyleName = "DetailCaption1";
            this.tableCell10.StylePriority.UseFont = false;
            this.tableCell10.StylePriority.UseTextAlignment = false;
            this.tableCell10.Text = "BSR Code/\r\nReceipt No\r\nof Form No.\r\n24G\r\n(See Note 8)";
            this.tableCell10.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.tableCell10.Weight = 0.1030608455123227D;
            // 
            // tableCell11
            // 
            this.tableCell11.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableCell11.Multiline = true;
            this.tableCell11.Name = "tableCell11";
            this.tableCell11.StyleName = "DetailCaption1";
            this.tableCell11.StylePriority.UseFont = false;
            this.tableCell11.StylePriority.UseTextAlignment = false;
            this.tableCell11.Text = "Challan Serial\r\nNo./DDO \r\nSerial\r\nNo. of \r\nForm No.24 G\r\n(See Note 8)";
            this.tableCell11.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.tableCell11.Weight = 0.076339925157340283D;
            // 
            // tableCell12
            // 
            this.tableCell12.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableCell12.Multiline = true;
            this.tableCell12.Name = "tableCell12";
            this.tableCell12.StyleName = "DetailCaption1";
            this.tableCell12.StylePriority.UseFont = false;
            this.tableCell12.StylePriority.UseTextAlignment = false;
            this.tableCell12.Text = "Date on which\r\namount\r\ndeposited\r\nthrough\r\nChallan/\r\ndate of\r\ntransfer\r\nvoucher\r\n" +
    "(dd/mm/yyy)\r\n(See Note 8)";
            this.tableCell12.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.tableCell12.Weight = 0.08606404625109125D;
            // 
            // xrTableCell1
            // 
            this.xrTableCell1.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrTableCell1.Multiline = true;
            this.xrTableCell1.Name = "xrTableCell1";
            this.xrTableCell1.StyleName = "DetailCaption1";
            this.xrTableCell1.StylePriority.UseFont = false;
            this.xrTableCell1.StylePriority.UseTextAlignment = false;
            this.xrTableCell1.Text = "Minor\r\nHead of\r\nChallan\r\n(See Note 9)";
            this.xrTableCell1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell1.Weight = 0.068842501793581257D;
            // 
            // xrTableRow1
            // 
            this.xrTableRow1.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell2,
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
            this.xrTableCell14});
            this.xrTableRow1.Name = "xrTableRow1";
            this.xrTableRow1.Weight = 1D;
            // 
            // xrTableCell2
            // 
            this.xrTableCell2.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrTableCell2.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrTableCell2.Multiline = true;
            this.xrTableCell2.Name = "xrTableCell2";
            this.xrTableCell2.StyleName = "DetailCaption1";
            this.xrTableCell2.StylePriority.UseBorders = false;
            this.xrTableCell2.StylePriority.UseFont = false;
            this.xrTableCell2.StylePriority.UseTextAlignment = false;
            this.xrTableCell2.Text = "[701]";
            this.xrTableCell2.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell2.Weight = 0.0408663092719184D;
            // 
            // xrTableCell3
            // 
            this.xrTableCell3.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrTableCell3.Multiline = true;
            this.xrTableCell3.Name = "xrTableCell3";
            this.xrTableCell3.StyleName = "DetailCaption1";
            this.xrTableCell3.StylePriority.UseFont = false;
            this.xrTableCell3.StylePriority.UseTextAlignment = false;
            this.xrTableCell3.Text = "[702]";
            this.xrTableCell3.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell3.Weight = 0.0702448057347245D;
            // 
            // xrTableCell4
            // 
            this.xrTableCell4.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrTableCell4.Multiline = true;
            this.xrTableCell4.Name = "xrTableCell4";
            this.xrTableCell4.StyleName = "DetailCaption1";
            this.xrTableCell4.StylePriority.UseFont = false;
            this.xrTableCell4.StylePriority.UseTextAlignment = false;
            this.xrTableCell4.Text = "[703]";
            this.xrTableCell4.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell4.Weight = 0.086595294023847552D;
            // 
            // xrTableCell5
            // 
            this.xrTableCell5.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrTableCell5.Multiline = true;
            this.xrTableCell5.Name = "xrTableCell5";
            this.xrTableCell5.StyleName = "DetailCaption1";
            this.xrTableCell5.StylePriority.UseFont = false;
            this.xrTableCell5.StylePriority.UseTextAlignment = false;
            this.xrTableCell5.Text = "[704]";
            this.xrTableCell5.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell5.Weight = 0.080147115413090692D;
            // 
            // xrTableCell6
            // 
            this.xrTableCell6.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrTableCell6.Multiline = true;
            this.xrTableCell6.Name = "xrTableCell6";
            this.xrTableCell6.StyleName = "DetailCaption1";
            this.xrTableCell6.StylePriority.UseFont = false;
            this.xrTableCell6.StylePriority.UseTextAlignment = false;
            this.xrTableCell6.Text = "[705]";
            this.xrTableCell6.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell6.Weight = 0.06802846663159684D;
            // 
            // xrTableCell7
            // 
            this.xrTableCell7.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrTableCell7.Multiline = true;
            this.xrTableCell7.Name = "xrTableCell7";
            this.xrTableCell7.StyleName = "DetailCaption1";
            this.xrTableCell7.StylePriority.UseFont = false;
            this.xrTableCell7.StylePriority.UseTextAlignment = false;
            this.xrTableCell7.Text = "[706]";
            this.xrTableCell7.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell7.Weight = 0.090447591200093824D;
            // 
            // xrTableCell8
            // 
            this.xrTableCell8.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrTableCell8.Multiline = true;
            this.xrTableCell8.Name = "xrTableCell8";
            this.xrTableCell8.StyleName = "DetailCaption1";
            this.xrTableCell8.StylePriority.UseFont = false;
            this.xrTableCell8.StylePriority.UseTextAlignment = false;
            this.xrTableCell8.Text = "[707]";
            this.xrTableCell8.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell8.Weight = 0.071353793022907064D;
            // 
            // xrTableCell9
            // 
            this.xrTableCell9.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrTableCell9.Multiline = true;
            this.xrTableCell9.Name = "xrTableCell9";
            this.xrTableCell9.StyleName = "DetailCaption1";
            this.xrTableCell9.StylePriority.UseFont = false;
            this.xrTableCell9.StylePriority.UseTextAlignment = false;
            this.xrTableCell9.Text = "[708]";
            this.xrTableCell9.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell9.Weight = 0.21361439432818585D;
            // 
            // xrTableCell10
            // 
            this.xrTableCell10.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrTableCell10.Multiline = true;
            this.xrTableCell10.Name = "xrTableCell10";
            this.xrTableCell10.StyleName = "DetailCaption1";
            this.xrTableCell10.StylePriority.UseFont = false;
            this.xrTableCell10.StylePriority.UseTextAlignment = false;
            this.xrTableCell10.Text = "[709]";
            this.xrTableCell10.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell10.Weight = 0.069950425782184411D;
            // 
            // xrTableCell11
            // 
            this.xrTableCell11.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrTableCell11.Multiline = true;
            this.xrTableCell11.Name = "xrTableCell11";
            this.xrTableCell11.StyleName = "DetailCaption1";
            this.xrTableCell11.StylePriority.UseFont = false;
            this.xrTableCell11.StylePriority.UseTextAlignment = false;
            this.xrTableCell11.Text = "[710]";
            this.xrTableCell11.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell11.Weight = 0.1030608455123227D;
            // 
            // xrTableCell12
            // 
            this.xrTableCell12.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrTableCell12.Multiline = true;
            this.xrTableCell12.Name = "xrTableCell12";
            this.xrTableCell12.StyleName = "DetailCaption1";
            this.xrTableCell12.StylePriority.UseFont = false;
            this.xrTableCell12.StylePriority.UseTextAlignment = false;
            this.xrTableCell12.Text = "[711]";
            this.xrTableCell12.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell12.Weight = 0.076339925157340283D;
            // 
            // xrTableCell13
            // 
            this.xrTableCell13.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrTableCell13.Multiline = true;
            this.xrTableCell13.Name = "xrTableCell13";
            this.xrTableCell13.StyleName = "DetailCaption1";
            this.xrTableCell13.StylePriority.UseFont = false;
            this.xrTableCell13.StylePriority.UseTextAlignment = false;
            this.xrTableCell13.Text = "[712]";
            this.xrTableCell13.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell13.Weight = 0.08606404625109125D;
            // 
            // xrTableCell14
            // 
            this.xrTableCell14.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrTableCell14.Multiline = true;
            this.xrTableCell14.Name = "xrTableCell14";
            this.xrTableCell14.StyleName = "DetailCaption1";
            this.xrTableCell14.StylePriority.UseFont = false;
            this.xrTableCell14.StylePriority.UseTextAlignment = false;
            this.xrTableCell14.Text = "[713]";
            this.xrTableCell14.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell14.Weight = 0.068842501793581257D;
            // 
            // Detail
            // 
            this.Detail.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.table2});
            this.Detail.HeightF = 25F;
            this.Detail.Name = "Detail";
            // 
            // table2
            // 
            this.table2.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.table2.Name = "table2";
            this.table2.OddStyleName = "DetailData3_Odd";
            this.table2.Rows.AddRange(new DevExpress.XtraReports.UI.XRTableRow[] {
            this.tableRow2});
            this.table2.SizeF = new System.Drawing.SizeF(1013F, 25F);
            // 
            // tableRow2
            // 
            this.tableRow2.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.tableCell13,
            this.tableCell14,
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
            this.xrTableCell15});
            this.tableRow2.Name = "tableRow2";
            this.tableRow2.Weight = 11.5D;
            // 
            // tableCell13
            // 
            this.tableCell13.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.tableCell13.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Srno]")});
            this.tableCell13.Name = "tableCell13";
            this.tableCell13.StyleName = "DetailData1";
            this.tableCell13.StylePriority.UseBorders = false;
            this.tableCell13.StylePriority.UseTextAlignment = false;
            this.tableCell13.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            this.tableCell13.Weight = 0.0408663092719184D;
            // 
            // tableCell14
            // 
            this.tableCell14.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[TDS_Amount]")});
            this.tableCell14.Name = "tableCell14";
            this.tableCell14.StyleName = "DetailData1";
            this.tableCell14.StylePriority.UseTextAlignment = false;
            this.tableCell14.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableCell14.Weight = 0.070244806420765957D;
            // 
            // tableCell15
            // 
            this.tableCell15.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Surcharge]")});
            this.tableCell15.Name = "tableCell15";
            this.tableCell15.StyleName = "DetailData1";
            this.tableCell15.StylePriority.UseTextAlignment = false;
            this.tableCell15.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableCell15.Weight = 0.086595293337806092D;
            // 
            // tableCell16
            // 
            this.tableCell16.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Education_Cess]")});
            this.tableCell16.Name = "tableCell16";
            this.tableCell16.StyleName = "DetailData1";
            this.tableCell16.StylePriority.UseTextAlignment = false;
            this.tableCell16.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableCell16.Weight = 0.080147180003845991D;
            // 
            // tableCell17
            // 
            this.tableCell17.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Interest_Amt]")});
            this.tableCell17.Name = "tableCell17";
            this.tableCell17.StyleName = "DetailData1";
            this.tableCell17.StylePriority.UseTextAlignment = false;
            this.tableCell17.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableCell17.Weight = 0.06802846306268498D;
            // 
            // tableCell18
            // 
            this.tableCell18.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Fees_Amount]")});
            this.tableCell18.Name = "tableCell18";
            this.tableCell18.StyleName = "DetailData1";
            this.tableCell18.StylePriority.UseTextAlignment = false;
            this.tableCell18.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableCell18.Weight = 0.090447493604867216D;
            // 
            // tableCell19
            // 
            this.tableCell19.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Others_Amount]")});
            this.tableCell19.Name = "tableCell19";
            this.tableCell19.StyleName = "DetailData1";
            this.tableCell19.StylePriority.UseTextAlignment = false;
            this.tableCell19.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableCell19.Weight = 0.071353857903469514D;
            // 
            // tableCell20
            // 
            this.tableCell20.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Challan_Amount]")});
            this.tableCell20.Name = "tableCell20";
            this.tableCell20.StyleName = "DetailData1";
            this.tableCell20.StylePriority.UseTextAlignment = false;
            this.tableCell20.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableCell20.Weight = 0.21361433831070428D;
            // 
            // tableCell21
            // 
            this.tableCell21.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Nil_Challan]")});
            this.tableCell21.Name = "tableCell21";
            this.tableCell21.StyleName = "DetailData1";
            this.tableCell21.StylePriority.UseTextAlignment = false;
            this.tableCell21.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableCell21.Weight = 0.0699503073178618D;
            // 
            // tableCell22
            // 
            this.tableCell22.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Bank_Bsrcode]")});
            this.tableCell22.Name = "tableCell22";
            this.tableCell22.StyleName = "DetailData1";
            this.tableCell22.StylePriority.UseTextAlignment = false;
            this.tableCell22.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableCell22.Weight = 0.10306091284271043D;
            // 
            // tableCell23
            // 
            this.tableCell23.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Challan_No]")});
            this.tableCell23.Name = "tableCell23";
            this.tableCell23.StyleName = "DetailData1";
            this.tableCell23.StylePriority.UseTextAlignment = false;
            this.tableCell23.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableCell23.Weight = 0.07633988271755221D;
            // 
            // tableCell24
            // 
            this.tableCell24.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Challan_Date]")});
            this.tableCell24.Name = "tableCell24";
            this.tableCell24.StyleName = "DetailData1";
            this.tableCell24.StylePriority.UseTextAlignment = false;
            this.tableCell24.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft;
            this.tableCell24.Weight = 0.086064114013662485D;
            // 
            // xrTableCell15
            // 
            this.xrTableCell15.Multiline = true;
            this.xrTableCell15.Name = "xrTableCell15";
            this.xrTableCell15.StyleName = "DetailData1";
            this.xrTableCell15.StylePriority.UseTextAlignment = false;
            this.xrTableCell15.Text = "200";
            this.xrTableCell15.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.xrTableCell15.Visible = false;
            this.xrTableCell15.Weight = 0.068842502546694967D;
            this.xrTableCell15.BeforePrint += new System.Drawing.Printing.PrintEventHandler(this.xrTableCell15_BeforePrint);
            // 
            // ReportFooter
            // 
            this.ReportFooter.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrLabel5,
            this.xrLabel122,
            this.xrLabel119,
            this.xrLabel118,
            this.xrLabel117,
            this.xrLabel116,
            this.xrLabel79,
            this.xrLabel81,
            this.xrLabel82,
            this.xrLabel83,
            this.xrLabel84,
            this.xrLabel85,
            this.xrLabel87,
            this.xrLabel86,
            this.xrLine1});
            this.ReportFooter.HeightF = 333.0228F;
            this.ReportFooter.Name = "ReportFooter";
            // 
            // xrLabel5
            // 
            this.xrLabel5.Font = new System.Drawing.Font("Arial Narrow", 8.25F);
            this.xrLabel5.LocationFloat = new DevExpress.Utils.PointFloat(0F, 29.99999F);
            this.xrLabel5.Multiline = true;
            this.xrLabel5.Name = "xrLabel5";
            this.xrLabel5.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel5.SizeF = new System.Drawing.SizeF(14.13637F, 23.00001F);
            this.xrLabel5.StylePriority.UseFont = false;
            this.xrLabel5.Text = "I,";
            // 
            // xrLabel122
            // 
            this.xrLabel122.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?dt")});
            this.xrLabel122.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel122.LocationFloat = new DevExpress.Utils.PointFloat(51.70455F, 76.00001F);
            this.xrLabel122.Multiline = true;
            this.xrLabel122.Name = "xrLabel122";
            this.xrLabel122.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel122.SizeF = new System.Drawing.SizeF(100F, 23F);
            this.xrLabel122.StylePriority.UseFont = false;
            this.xrLabel122.Text = "xrLabel122";
            // 
            // xrLabel119
            // 
            this.xrLabel119.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?R_Name")});
            this.xrLabel119.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel119.LocationFloat = new DevExpress.Utils.PointFloat(334.6917F, 99F);
            this.xrLabel119.Multiline = true;
            this.xrLabel119.Name = "xrLabel119";
            this.xrLabel119.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel119.SizeF = new System.Drawing.SizeF(495.6593F, 23F);
            this.xrLabel119.StylePriority.UseFont = false;
            this.xrLabel119.Text = "xrLabel119";
            // 
            // xrLabel118
            // 
            this.xrLabel118.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?R_Designation")});
            this.xrLabel118.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel118.LocationFloat = new DevExpress.Utils.PointFloat(334.6917F, 122F);
            this.xrLabel118.Multiline = true;
            this.xrLabel118.Name = "xrLabel118";
            this.xrLabel118.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel118.SizeF = new System.Drawing.SizeF(495.6593F, 23.00001F);
            this.xrLabel118.StylePriority.UseFont = false;
            this.xrLabel118.Text = "xrLabel118";
            // 
            // xrLabel117
            // 
            this.xrLabel117.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?R_Name")});
            this.xrLabel117.Font = new System.Drawing.Font("Arial", 9F);
            this.xrLabel117.LocationFloat = new DevExpress.Utils.PointFloat(14.37497F, 30.00005F);
            this.xrLabel117.Multiline = true;
            this.xrLabel117.Name = "xrLabel117";
            this.xrLabel117.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel117.SizeF = new System.Drawing.SizeF(320.3167F, 23F);
            this.xrLabel117.StylePriority.UseFont = false;
            this.xrLabel117.Text = "xrLabel117";
            // 
            // xrLabel116
            // 
            this.xrLabel116.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?Place")});
            this.xrLabel116.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel116.LocationFloat = new DevExpress.Utils.PointFloat(51.70455F, 53.00003F);
            this.xrLabel116.Multiline = true;
            this.xrLabel116.Name = "xrLabel116";
            this.xrLabel116.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel116.SizeF = new System.Drawing.SizeF(177.0833F, 23F);
            this.xrLabel116.StylePriority.UseFont = false;
            this.xrLabel116.Text = "xrLabel116";
            // 
            // xrLabel79
            // 
            this.xrLabel79.Font = new System.Drawing.Font("Arial", 9.75F, System.Drawing.FontStyle.Bold);
            this.xrLabel79.LocationFloat = new DevExpress.Utils.PointFloat(0F, 6.999974F);
            this.xrLabel79.Multiline = true;
            this.xrLabel79.Name = "xrLabel79";
            this.xrLabel79.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel79.SizeF = new System.Drawing.SizeF(991F, 23F);
            this.xrLabel79.StylePriority.UseFont = false;
            this.xrLabel79.StylePriority.UseTextAlignment = false;
            this.xrLabel79.Text = "Verification";
            this.xrLabel79.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // xrLabel81
            // 
            this.xrLabel81.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel81.LocationFloat = new DevExpress.Utils.PointFloat(334.6917F, 30.00005F);
            this.xrLabel81.Multiline = true;
            this.xrLabel81.Name = "xrLabel81";
            this.xrLabel81.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel81.SizeF = new System.Drawing.SizeF(426.5846F, 23F);
            this.xrLabel81.StylePriority.UseFont = false;
            this.xrLabel81.Text = "hereby certify that all the particulars furnished above are correct and complete." +
    "\r\n";
            // 
            // xrLabel82
            // 
            this.xrLabel82.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel82.LocationFloat = new DevExpress.Utils.PointFloat(0F, 53.00005F);
            this.xrLabel82.Multiline = true;
            this.xrLabel82.Name = "xrLabel82";
            this.xrLabel82.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel82.SizeF = new System.Drawing.SizeF(51.70455F, 23F);
            this.xrLabel82.StylePriority.UseFont = false;
            this.xrLabel82.Text = "Place :";
            // 
            // xrLabel83
            // 
            this.xrLabel83.Font = new System.Drawing.Font("Arial Narrow", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel83.LocationFloat = new DevExpress.Utils.PointFloat(0F, 76.00001F);
            this.xrLabel83.Multiline = true;
            this.xrLabel83.Name = "xrLabel83";
            this.xrLabel83.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel83.SizeF = new System.Drawing.SizeF(51.70455F, 23F);
            this.xrLabel83.StylePriority.UseFont = false;
            this.xrLabel83.Text = "Date  :";
            // 
            // xrLabel84
            // 
            this.xrLabel84.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel84.LocationFloat = new DevExpress.Utils.PointFloat(334.6917F, 53.00005F);
            this.xrLabel84.Multiline = true;
            this.xrLabel84.Name = "xrLabel84";
            this.xrLabel84.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel84.SizeF = new System.Drawing.SizeF(559.3084F, 23F);
            this.xrLabel84.StylePriority.UseFont = false;
            this.xrLabel84.Text = "Signature of the person responsible for collecting tax at source_________________" +
    "_________";
            // 
            // xrLabel85
            // 
            this.xrLabel85.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel85.LocationFloat = new DevExpress.Utils.PointFloat(334.6917F, 76.00001F);
            this.xrLabel85.Multiline = true;
            this.xrLabel85.Name = "xrLabel85";
            this.xrLabel85.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel85.SizeF = new System.Drawing.SizeF(559.3084F, 23F);
            this.xrLabel85.StylePriority.UseFont = false;
            this.xrLabel85.Text = "Name and designation of the person responsible for collecting tax at source";
            // 
            // xrLabel87
            // 
            this.xrLabel87.Font = new System.Drawing.Font("Arial", 8F);
            this.xrLabel87.LocationFloat = new DevExpress.Utils.PointFloat(0F, 171.9245F);
            this.xrLabel87.Multiline = true;
            this.xrLabel87.Name = "xrLabel87";
            this.xrLabel87.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel87.SizeF = new System.Drawing.SizeF(974.9999F, 161.0983F);
            this.xrLabel87.StylePriority.UseFont = false;
            this.xrLabel87.Text = resources.GetString("xrLabel87.Text");
            // 
            // xrLabel86
            // 
            this.xrLabel86.Font = new System.Drawing.Font("Arial", 9F, System.Drawing.FontStyle.Bold);
            this.xrLabel86.LocationFloat = new DevExpress.Utils.PointFloat(0F, 148.9245F);
            this.xrLabel86.Multiline = true;
            this.xrLabel86.Name = "xrLabel86";
            this.xrLabel86.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel86.SizeF = new System.Drawing.SizeF(100F, 23F);
            this.xrLabel86.StylePriority.UseFont = false;
            this.xrLabel86.Text = "Notes :";
            // 
            // xrLine1
            // 
            this.xrLine1.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.xrLine1.Name = "xrLine1";
            this.xrLine1.SizeF = new System.Drawing.SizeF(1013F, 6.999969F);
            // 
            // TANNo
            // 
            this.TANNo.Description = "Parameter1";
            this.TANNo.Name = "TANNo";
            // 
            // PANNo
            // 
            this.PANNo.Description = "Parameter1";
            this.PANNo.Name = "PANNo";
            // 
            // Cname
            // 
            this.Cname.Description = "Parameter1";
            this.Cname.Name = "Cname";
            // 
            // FlatNo
            // 
            this.FlatNo.Description = "Parameter1";
            this.FlatNo.Name = "FlatNo";
            // 
            // BuildingNo
            // 
            this.BuildingNo.Description = "Parameter1";
            this.BuildingNo.Name = "BuildingNo";
            // 
            // Street
            // 
            this.Street.Description = "Parameter1";
            this.Street.Name = "Street";
            // 
            // Area
            // 
            this.Area.Description = "Parameter1";
            this.Area.Name = "Area";
            // 
            // Town
            // 
            this.Town.Description = "Parameter1";
            this.Town.Name = "Town";
            // 
            // State_Name
            // 
            this.State_Name.Description = "Parameter1";
            this.State_Name.Name = "State_Name";
            // 
            // Pincode
            // 
            this.Pincode.Description = "Parameter1";
            this.Pincode.Name = "Pincode";
            // 
            // Tel_NO
            // 
            this.Tel_NO.Description = "Parameter1";
            this.Tel_NO.Name = "Tel_NO";
            // 
            // EmailID
            // 
            this.EmailID.Description = "Parameter1";
            this.EmailID.Name = "EmailID";
            // 
            // Alt_Tel_NO
            // 
            this.Alt_Tel_NO.Description = "Parameter1";
            this.Alt_Tel_NO.Name = "Alt_Tel_NO";
            // 
            // Alt_EmailID
            // 
            this.Alt_EmailID.Description = "Parameter1";
            this.Alt_EmailID.Name = "Alt_EmailID";
            // 
            // R_Name
            // 
            this.R_Name.Description = "Parameter1";
            this.R_Name.Name = "R_Name";
            // 
            // ContacPersonPAN
            // 
            this.ContacPersonPAN.Description = "Parameter1";
            this.ContacPersonPAN.Name = "ContacPersonPAN";
            // 
            // R_Flat_NO
            // 
            this.R_Flat_NO.Description = "Parameter1";
            this.R_Flat_NO.Name = "R_Flat_NO";
            // 
            // R_Building
            // 
            this.R_Building.Description = "Parameter1";
            this.R_Building.Name = "R_Building";
            // 
            // R_Street
            // 
            this.R_Street.Description = "Parameter1";
            this.R_Street.Name = "R_Street";
            // 
            // R_Area_Location
            // 
            this.R_Area_Location.Description = "Parameter1";
            this.R_Area_Location.Name = "R_Area_Location";
            // 
            // R_Town_City
            // 
            this.R_Town_City.Description = "Parameter1";
            this.R_Town_City.Name = "R_Town_City";
            // 
            // R_Pincode
            // 
            this.R_Pincode.Description = "Parameter1";
            this.R_Pincode.Name = "R_Pincode";
            // 
            // R_Tel_NO
            // 
            this.R_Tel_NO.Description = "Parameter1";
            this.R_Tel_NO.Name = "R_Tel_NO";
            // 
            // ALT_R_Tel_NO
            // 
            this.ALT_R_Tel_NO.Description = "Parameter1";
            this.ALT_R_Tel_NO.Name = "ALT_R_Tel_NO";
            // 
            // R_EmailID
            // 
            this.R_EmailID.Description = "Parameter1";
            this.R_EmailID.Name = "R_EmailID";
            // 
            // ALT_R_EmailID
            // 
            this.ALT_R_EmailID.Description = "Parameter1";
            this.ALT_R_EmailID.Name = "ALT_R_EmailID";
            // 
            // R_Mobile_NO
            // 
            this.R_Mobile_NO.Description = "Parameter1";
            this.R_Mobile_NO.Name = "R_Mobile_NO";
            // 
            // Place
            // 
            this.Place.Description = "Parameter1";
            this.Place.Name = "Place";
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
            // FY
            // 
            this.FY.Description = "Parameter1";
            this.FY.Name = "FY";
            // 
            // dt
            // 
            this.dt.Description = "Parameter1";
            this.dt.Name = "dt";
            // 
            // CompanyName
            // 
            this.CompanyName.Description = "Parameter1";
            this.CompanyName.Name = "CompanyName";
            // 
            // GroupFooter1
            // 
            this.GroupFooter1.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrLine2,
            this.xrLabel17,
            this.xrLabel16,
            this.xrLabel15,
            this.xrLabel14,
            this.xrLabel13,
            this.xrLabel12,
            this.xrLabel11,
            this.xrLabel10});
            this.GroupFooter1.HeightF = 27.45833F;
            this.GroupFooter1.Name = "GroupFooter1";
            // 
            // xrLine2
            // 
            this.xrLine2.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.xrLine2.Name = "xrLine2";
            this.xrLine2.SizeF = new System.Drawing.SizeF(1013F, 4.458332F);
            // 
            // xrLabel17
            // 
            this.xrLabel17.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "sum([Challan_Amount])")});
            this.xrLabel17.Font = new System.Drawing.Font("Arial", 9F, System.Drawing.FontStyle.Bold);
            this.xrLabel17.LocationFloat = new DevExpress.Utils.PointFloat(456.9151F, 4.458332F);
            this.xrLabel17.Multiline = true;
            this.xrLabel17.Name = "xrLabel17";
            this.xrLabel17.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel17.SizeF = new System.Drawing.SizeF(192.2529F, 23F);
            this.xrLabel17.StylePriority.UseFont = false;
            this.xrLabel17.StylePriority.UseTextAlignment = false;
            xrSummary1.Running = DevExpress.XtraReports.UI.SummaryRunning.Group;
            this.xrLabel17.Summary = xrSummary1;
            this.xrLabel17.Text = "xrLabel17";
            this.xrLabel17.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // xrLabel16
            // 
            this.xrLabel16.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "sum([Others_Amount])")});
            this.xrLabel16.Font = new System.Drawing.Font("Arial", 9F, System.Drawing.FontStyle.Bold);
            this.xrLabel16.LocationFloat = new DevExpress.Utils.PointFloat(392.6966F, 4.458332F);
            this.xrLabel16.Multiline = true;
            this.xrLabel16.Name = "xrLabel16";
            this.xrLabel16.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel16.SizeF = new System.Drawing.SizeF(64.21854F, 23F);
            this.xrLabel16.StylePriority.UseFont = false;
            this.xrLabel16.StylePriority.UseTextAlignment = false;
            xrSummary2.Running = DevExpress.XtraReports.UI.SummaryRunning.Group;
            this.xrLabel16.Summary = xrSummary2;
            this.xrLabel16.Text = "xrLabel16";
            this.xrLabel16.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // xrLabel15
            // 
            this.xrLabel15.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "sum([Fees_Amount])")});
            this.xrLabel15.Font = new System.Drawing.Font("Arial", 9F, System.Drawing.FontStyle.Bold);
            this.xrLabel15.LocationFloat = new DevExpress.Utils.PointFloat(311.2939F, 4.458332F);
            this.xrLabel15.Multiline = true;
            this.xrLabel15.Name = "xrLabel15";
            this.xrLabel15.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel15.SizeF = new System.Drawing.SizeF(81.40271F, 23F);
            this.xrLabel15.StylePriority.UseFont = false;
            this.xrLabel15.StylePriority.UseTextAlignment = false;
            xrSummary3.Running = DevExpress.XtraReports.UI.SummaryRunning.Group;
            this.xrLabel15.Summary = xrSummary3;
            this.xrLabel15.Text = "xrLabel15";
            this.xrLabel15.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // xrLabel14
            // 
            this.xrLabel14.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "sum([Interest_Amt])")});
            this.xrLabel14.Font = new System.Drawing.Font("Arial", 9F, System.Drawing.FontStyle.Bold);
            this.xrLabel14.LocationFloat = new DevExpress.Utils.PointFloat(250.0683F, 4.458332F);
            this.xrLabel14.Multiline = true;
            this.xrLabel14.Name = "xrLabel14";
            this.xrLabel14.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel14.SizeF = new System.Drawing.SizeF(61.22557F, 23F);
            this.xrLabel14.StylePriority.UseFont = false;
            this.xrLabel14.StylePriority.UseTextAlignment = false;
            xrSummary4.Running = DevExpress.XtraReports.UI.SummaryRunning.Group;
            this.xrLabel14.Summary = xrSummary4;
            this.xrLabel14.Text = "xrLabel14";
            this.xrLabel14.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // xrLabel13
            // 
            this.xrLabel13.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "sum([Education_Cess])")});
            this.xrLabel13.Font = new System.Drawing.Font("Arial", 9F, System.Drawing.FontStyle.Bold);
            this.xrLabel13.LocationFloat = new DevExpress.Utils.PointFloat(177.9358F, 4.458332F);
            this.xrLabel13.Multiline = true;
            this.xrLabel13.Name = "xrLabel13";
            this.xrLabel13.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel13.SizeF = new System.Drawing.SizeF(72.13249F, 23F);
            this.xrLabel13.StylePriority.UseFont = false;
            this.xrLabel13.StylePriority.UseTextAlignment = false;
            xrSummary5.Running = DevExpress.XtraReports.UI.SummaryRunning.Group;
            this.xrLabel13.Summary = xrSummary5;
            this.xrLabel13.Text = "xrLabel13";
            this.xrLabel13.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // xrLabel12
            // 
            this.xrLabel12.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "sum([Surcharge])")});
            this.xrLabel12.Font = new System.Drawing.Font("Arial", 9F, System.Drawing.FontStyle.Bold);
            this.xrLabel12.LocationFloat = new DevExpress.Utils.PointFloat(100F, 4.458332F);
            this.xrLabel12.Multiline = true;
            this.xrLabel12.Name = "xrLabel12";
            this.xrLabel12.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel12.SizeF = new System.Drawing.SizeF(77.93579F, 23F);
            this.xrLabel12.StylePriority.UseFont = false;
            this.xrLabel12.StylePriority.UseTextAlignment = false;
            xrSummary6.Running = DevExpress.XtraReports.UI.SummaryRunning.Group;
            this.xrLabel12.Summary = xrSummary6;
            this.xrLabel12.Text = "xrLabel12";
            this.xrLabel12.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // xrLabel11
            // 
            this.xrLabel11.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "sum([TDS_Amount])")});
            this.xrLabel11.Font = new System.Drawing.Font("Arial", 9F, System.Drawing.FontStyle.Bold);
            this.xrLabel11.LocationFloat = new DevExpress.Utils.PointFloat(36.77966F, 4.458332F);
            this.xrLabel11.Multiline = true;
            this.xrLabel11.Name = "xrLabel11";
            this.xrLabel11.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel11.SizeF = new System.Drawing.SizeF(63.22034F, 23F);
            this.xrLabel11.StylePriority.UseFont = false;
            this.xrLabel11.StylePriority.UseTextAlignment = false;
            xrSummary7.Running = DevExpress.XtraReports.UI.SummaryRunning.Group;
            this.xrLabel11.Summary = xrSummary7;
            this.xrLabel11.Text = "xrLabel11";
            this.xrLabel11.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // xrLabel10
            // 
            this.xrLabel10.Font = new System.Drawing.Font("Arial", 9.75F, System.Drawing.FontStyle.Bold);
            this.xrLabel10.LocationFloat = new DevExpress.Utils.PointFloat(0F, 4.458332F);
            this.xrLabel10.Multiline = true;
            this.xrLabel10.Name = "xrLabel10";
            this.xrLabel10.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel10.SizeF = new System.Drawing.SizeF(36.77969F, 23F);
            this.xrLabel10.StylePriority.UseFont = false;
            this.xrLabel10.Text = "Total";
            // 
            // Dv_Form27QDetails
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
            this.DataMember = "DT_Form27Q_ChallanDetails";
            this.DataSource = this.sqlDataSource1;
            this.Font = new System.Drawing.Font("Arial", 9.75F);
            this.Landscape = true;
            this.Margins = new System.Drawing.Printing.Margins(48, 39, 0, 29);
            this.PageHeight = 850;
            this.PageWidth = 1100;
            this.Parameters.AddRange(new DevExpress.XtraReports.Parameters.Parameter[] {
            this.TANNo,
            this.PANNo,
            this.Cname,
            this.FlatNo,
            this.BuildingNo,
            this.Street,
            this.Area,
            this.Town,
            this.State_Name,
            this.Pincode,
            this.Tel_NO,
            this.EmailID,
            this.Alt_Tel_NO,
            this.Alt_EmailID,
            this.R_Name,
            this.ContacPersonPAN,
            this.R_Flat_NO,
            this.R_Building,
            this.R_Street,
            this.R_Area_Location,
            this.R_Town_City,
            this.R_Pincode,
            this.R_Tel_NO,
            this.ALT_R_Tel_NO,
            this.R_EmailID,
            this.ALT_R_EmailID,
            this.R_Mobile_NO,
            this.Place,
            this.R_Designation,
            this.qsdate,
            this.qedate,
            this.FY,
            this.dt,
            this.CompanyName});
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

    private void xrTableCell15_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
    {
        if(Detail.Report.RowCount > 0)
        {
            xrTableCell15.Visible = true;
        }
    }
}
