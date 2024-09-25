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
  public  class Dal_Form27Q :DALCommon
    {
        CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
        public SqlDataReader DAL_getChallanDetails(objChallanDetails_27Q obj)
        {
            DataSet ds = new DataSet();
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@Company_Id", obj.Compid);
            param[1] = new SqlParameter("@Quarter", obj.quarter);
            // ds = SqlHelper.ExecuteDataset(_cnnString2, "Usp_Bind_ChallanDetails_For_Annexure27EQ", param);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "Usp_Bind_ChallanDetails_For_Annexure27Q", param);
        }
    }
}
