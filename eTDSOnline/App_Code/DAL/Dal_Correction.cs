using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;
using System.Data;
using CommonLibrary;

namespace DataLayer
{
 public class Dal_Correction :  DALCommon
    {
        CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
        public SqlDataReader DAL_getDedcutee(objforCorrection cobj)
        {
            DataSet ds = new DataSet();
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@company_id", cobj.Compid);
            param[1] = new SqlParameter("@Form_Type", cobj.Form_Type);
            param[2] = new SqlParameter("@Quarter", cobj.quarter);
            ds = SqlHelper.ExecuteDataset(_cnnString2, "Get_DeducteeList", param);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "Get_DeducteeList", param);
        }

      
        public SqlDataReader DAL_getCorrection(objforCorrection cobj)
        {
            DataSet ds = new DataSet();
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@company_id", cobj.Compid);
            param[1] = new SqlParameter("@SelectedForm_Type", cobj.Form_Type);
            param[2] = new SqlParameter("@SelectedQuarter", cobj.quarter);
            param[3] = new SqlParameter("@Selectedid", cobj.ddid);
         //   ds = SqlHelper.ExecuteDataset(_cnnString2, "Usp_Get_Correction_Detail", param);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "Usp_Get_Correction_Detail", param);
        }

        public SqlDataReader DAL_UpadteCorrection(objforCorrection cobj)
        {
            DataSet ds = new DataSet();
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@company_id", cobj.Compid);
            param[1] = new SqlParameter("@correction_id", cobj.correctionid);
            param[2] = new SqlParameter("@hdnformtype", cobj.Form_Type);
           
          // ds = SqlHelper.ExecuteDataset(_cnnString2, "Usp_Update_correction", param);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "Usp_Update_correction", param);
        }
    }
}
