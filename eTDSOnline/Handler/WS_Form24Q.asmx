<%@ WebService Language="C#" Class="WS_Form24Q" %>
using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using BusinessLayer;
using CommonLibrary;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using System.Data.SqlClient;
using System.Data;
using Microsoft.ApplicationBlocks1.Data;


[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class WS_Form24Q : System.Web.Services.WebService
{

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string GetChallanDetails(objChallanDetails_24Q obj)
    {

        Bal_Form24Q obj_Bal_Form24Q = new Bal_Form24Q();

        if (HttpContext.Current.Session["Financial_Year_Text"] == null && !string.IsNullOrEmpty(obj.ConnectionString))
        {
            HttpContext.Current.Session["Financial_Year_Text"] = obj.ConnectionString;
        }
        IEnumerable<objChallanDetails_24Q> tbl = obj_Bal_Form24Q.Get_Challan_Detail(obj);
        return new JavaScriptSerializer().Serialize(tbl);
    }

    public SqlConnection sqlConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());
    [WebMethod]

    public string Get_Emp_List(int compid)
    {
        CommonLibrary.CommonFunctions objComm = new CommonLibrary.CommonFunctions();
        List<objChallanDetails_24Q> obj_Emp = new List<objChallanDetails_24Q>();
        try
        {
            //Common ob = new Common();
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@Company_id", compid);
            using (SqlDataReader drrr = SqlHelper.ExecuteReader(sqlConn, CommandType.StoredProcedure, "Usp_Get_Emp_List", param))
            {
                while (drrr.Read())
                {
                    obj_Emp.Add(new objChallanDetails_24Q()
                    {
                        empname = objComm.GetValue<string>(drrr["FirstName"].ToString()),
                        empid = objComm.GetValue<int>(drrr["Employee_ID"].ToString()),
                    });
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        IEnumerable<objChallanDetails_24Q> tbl = obj_Emp as IEnumerable<objChallanDetails_24Q>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);
    }
}