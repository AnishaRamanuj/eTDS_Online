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
  public  class Dal_Form26Q : DALCommon
    {        
        CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
        public SqlDataReader DAL_getChallan_Amount(objChallanDatenamt cobj)
        {
            DataSet ds = new DataSet();
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@Company_id", cobj.Compid);
            param[1] = new SqlParameter("@Quarter", cobj.quarter);
            // ds = SqlHelper.ExecuteDataset(_cnnString2, "usp_Get_ChallanDate_And_Amount", param);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "Usp_Bind_ChallanDetails_For_Annexure26Q", param);
        }
    }
}
