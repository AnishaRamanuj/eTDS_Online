<%@ WebHandler Language="C#" Class="Dedutee_Details" %>

using System;
using System.Web;
using System.Web.Script.Serialization;
public class Dedutee_Details : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";

        TDSResponse objTDSResponse = new TDSResponse();
        ConnectTR objConnect = new ConnectTR();
        JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
        TracesData objTraceData = jsSerializer.Deserialize<TracesData>(context.Request.Form["objTraceData"]);
        string stmtMstrId = Convert.ToString(context.Request.Form["stmtMstrId"]);
        string cookie = Convert.ToString(context.Request.Form["cookie"]);
        int page = Convert.ToInt32(context.Request.Form["page"]);

        // , string stmtMstrId, string cookie
        string deducteeDtls = string.Empty;
        objTDSResponse = objConnect.RequestTDSTCSCredit_DeduteeDetails(objTraceData, stmtMstrId, page, cookie, out deducteeDtls);
        context.Response.Write(deducteeDtls);
    }


    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}