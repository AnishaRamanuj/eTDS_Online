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
  public  class DAL_GetPartyEmpName :DALCommon
    {
        CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
        public SqlDataReader DAL_getPartyEmp_Name(objPartyEmpName cobj)
        {
            DataSet ds = new DataSet();
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@companyid", cobj.Compid);
            param[1] = new SqlParameter("@form_type", cobj.formno);
            param[2] = new SqlParameter("@type", cobj.type);
             //ds = SqlHelper.ExecuteDataset(_cnnString2, "Usp_Get_Deductee_Emp_NamenPan", param);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "Usp_Get_Deductee_Emp_NamenPan", param);
         }


        public SqlDataReader DAL_geEmp_Name(objPartyEmpName cobj)
        {
            DataSet ds = new DataSet();
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@companyid", cobj.Compid);
            param[1] = new SqlParameter("@type", cobj.type);          
            //ds = SqlHelper.ExecuteDataset(_cnnString2, "Usp_Get_Emp_NamenPan", param);
            return SqlHelper.ExecuteReader(_cnnString2, CommandType.StoredProcedure, "Usp_Get_Emp_NamenPan", param);
        }
    }
}
