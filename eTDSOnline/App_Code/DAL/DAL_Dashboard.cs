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
    public class DAL_Dashboard : DALCommon
    {
        public int _Company_ID { get; set; }
        public string _Quater { get; set; }
        public bool _IsChallan { get; set; }

        public SqlDataReader DAL_DashboardDetails(tbl_Dashboard tobj)
        {
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@Company_ID", tobj.compid);
            param[1] = new SqlParameter("@Quarter", tobj.Quater);
            param[2] = new SqlParameter("@Form", tobj.Formtype );
            string sp = "";
            if (tobj.Formtype == "24Q")
            {
                sp = "Usp_Dashboard_Sal";
            }
            else
            {
                sp = "Usp_Dashboard_NonSal";
            }
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, sp, param);
           
        }


        public SqlDataReader DAL_SaveToken(tbl_Dashboard tobj)
        {
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@compid", tobj.compid);
            param[1] = new SqlParameter("@TokenNo", tobj.RToken);
            param[2] = new SqlParameter("@Qtr", tobj.Quater);
            param[3] = new SqlParameter("@ftype", tobj.Formtype);

            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "usp_Insert_TokenNo", param);

        }
        /////////////////////////////////////// Old Code/
        public DataSet Get_Dashboard_Details()
        {
            DataSet ds = null;
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Company_ID", _Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_Get_Dashboard_Details", param);
                return ds;
                
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet Get_Summary_Statements()
        {
            DataSet ds = null;
            try
            {
                SqlParameter[] param = new SqlParameter[3];

                param[0] = new SqlParameter("@Company_ID", _Company_ID);
                param[1] = new SqlParameter("@Quater", _Quater);
                param[2] = new SqlParameter("@IsChallan", _IsChallan);

                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_Get_Summary_Statements", param);
                return ds;
               
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet Get_Company_Master_DetailsByID()
        {
            DataSet ds = null;
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@companyID", _Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_Get_Company_Master_DetailsByID", param);
                return ds;
                
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet DAL_GetChartQuaterSmmary()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Company_ID", _Company_ID);
                DataSet ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_GetChartQuaterSmmary", param);
                return ds;
                
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
