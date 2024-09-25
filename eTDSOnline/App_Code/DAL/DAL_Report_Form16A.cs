using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Microsoft.ApplicationBlocks1.Data;
using DataLayer;
using System.Data.SqlClient;
using CommonLibrary;
namespace DataLayer
{
  public  class DAL_Report_Form16A : DALCommon
  {
      public int _Company_ID { get; set; }
      public DateTime? fromDT { get; set; }
      public DateTime? toDT { get; set; }

      public SqlDataReader DAL_GetVouchers(tbl_Voucher obj)
      {
          try
          {
              SqlParameter[] param = new SqlParameter[4];
              param[0] = new SqlParameter("@Quarter", obj.Quarter);
              param[1] = new SqlParameter("@Deductee_ID", obj.Deductee_ID);
              param[2] = new SqlParameter("@Nature_ID", obj.Nature_ID );
              param[3] = new SqlParameter("@CompanyID", obj.Company_ID);
              return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_GetVouchers", param);
          }
          catch (Exception ex)
          {

              throw ex;
          }
      }

      public SqlDataReader Get_Form16AChallan_Details(tbl_Challan_Non_Salary obj)
      {
          DataSet ds = new DataSet();
          try
          {
              SqlParameter[] param = new SqlParameter[4];

              param[0] = new SqlParameter("@Quarter", obj.Quater);
              param[1] = new SqlParameter("@Deductee_ID", obj.Deductee_ID);
              param[2] = new SqlParameter("@Nature_ID", obj.Nature_ID);
              param[3] = new SqlParameter("@CompanyID", obj.Company_ID);

              return SqlHelper.ExecuteReader(_cnnString2, "usp_Get_Form16AChallan_Details", param);
          }
          catch (Exception)
          {

              throw;
          }

      }


      public SqlDataReader DAL_GetCompanyMaterDetails(tbl_Company_MAster obj)
      {
          try
          {
              SqlParameter[] param = new SqlParameter[1];
              param[0] = new SqlParameter("@CompanyID", obj.Company_ID);
              return SqlHelper.ExecuteReader(_cnnString, CommandType.StoredProcedure, "usp_PaySlipReport_GetCompanyMaterDetails", param);
          }
          catch (Exception ex)
          {
              throw ex;
          }
      }

      public DataSet DAL_GetNautre(tbl_Company_MAster obj)
      {
          DataSet ds = new DataSet();
          try
          {
              SqlParameter[] param = new SqlParameter[1];
              param[0] = new SqlParameter("@CompanyID", obj.Company_ID);
              ds = SqlHelper.ExecuteDataset(_cnnString2 , CommandType.StoredProcedure, "usp_getdetail", param);
          }
          catch (Exception ex)
          {
              throw ex;
          }

          return ds;
      }

      public DataSet DAL_GetParty(tbl_Voucher obj)
      {
          DataSet ds = new DataSet();
          try
          {
              SqlParameter[] param = new SqlParameter[4];

              param[0] = new SqlParameter("@Companyid", obj.Company_ID );
              param[1] = new SqlParameter("@nature", obj.Nature_ID );
              param[2] = new SqlParameter("@stdate", obj.fromDT);
              param[3] = new SqlParameter("@eddate", obj.toDT);
              ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_getclientdetail", param);
          }
          catch (Exception ex)
          {
              throw ex;
          }

          return ds;
      }

    }
}
