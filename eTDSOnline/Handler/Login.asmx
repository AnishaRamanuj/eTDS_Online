<%@ WebService Language="C#" Class="Login" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Data;
//using BusinessLayer;
using CommonLibrary;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using Microsoft.ApplicationBlocks1.Data;
using LibCommon;
using System.Web.Security;
using PayrollProject;
using EntityLibrary;


[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class Login  : System.Web.Services.WebService {
    private readonly DBAccess db = new DBAccess();


    [System.Web.Services.WebMethod(EnableSession = true)]
    public string CheckLogin(string usr,string pass)
    {
        DALCommonLib objComm = new DALCommonLib();
        CommonFunctions Comm = new CommonFunctions();

        List<Tbl_Login> obj = new List<Tbl_Login>();
        try
        {
            //Common ob = new Common();
            if (Membership.ValidateUser(usr, pass))
            {
                if (Roles.IsUserInRole(usr, "superadmin"))
                {
                    HttpContext.Current.Session["roleid"] = "superadmin";
                    HttpContext.Current.Session["admin"] = "Mainuser";
                    obj.Add(new Tbl_Login()
                    {
                        Msg = Comm.GetValue<string>("Active"),
                        url = Comm.GetValue<string>("Admin/AdminHome.aspx"),
                        UsrRole = Comm.GetValue<string>("Admin"),

                    });

                    int log = db.CreateLog("Login", "SuperUser Login", "0");
                }

                else if (Roles.IsUserInRole(usr, "Company-Admin"))
                {
                    HttpContext.Current.Session["roleid"] = "company";
                    SqlParameter[] param = new SqlParameter[3];
                    param[0] = new SqlParameter("@username", usr);
                    param[1] = new SqlParameter("@password", pass);
                    param[2] = new SqlParameter("@IsApproved", "true");
                    DataSet ds = SqlHelper.ExecuteDataset(objComm._cnnString, CommandType.StoredProcedure, "usp_Company_Login", param);
                    if (ds.Tables[0].Rows.Count > 0)
                    {

                        HttpContext.Current.Session["Name"] = ds.Tables[0].Rows[0]["Name"].ToString();
                        HttpContext.Current.Session["fulname1"] = ds.Tables[0].Rows[0]["CompanyName"].ToString();
                        HttpContext.Current.Session["CompanyLogo"] = ds.Tables[0].Rows[0]["CompanyLogoName"].ToString();
                        HttpContext.Current.Session["fulname"] = ds.Tables[0].Rows[0]["CompanyName"].ToString();
                        HttpContext.Current.Session["companyid"] = ds.Tables[0].Rows[0]["Company_Id"].ToString();
                        HttpContext.Current.Session.Add("usertype", "company");
                        HttpContext.Current.Session.Add("cltcomp", ds.Tables[0].Rows[0]["Company_Id"].ToString());
                        HttpContext.Current.Session.Add("companyname", ds.Tables[0].Rows[0]["cusername"].ToString());
                        HttpContext.Current.Session.Add("Parent_Company_ID", ds.Tables[0].Rows[0]["Parent_Company_Id"].ToString());
                        HttpContext.Current.Session["ParentCompanyid"] = ds.Tables[0].Rows[0]["Company_Id"].ToString();

                        //int log = db.CreateLog("Login", "Company-Admin Login", Session["companyid"].ToString());

                        SqlParameter[] objSqlParameter = new SqlParameter[1];
                        objSqlParameter[0] = new SqlParameter("@companyid", ds.Tables[0].Rows[0]["Company_Id"].ToString());
                        DataSet dst = SqlHelper.ExecuteDataset(objComm._cnnString, CommandType.StoredProcedure, "bindddlfinacial_year", objSqlParameter);
                        if (dst.Tables[0].Rows.Count > 0)
                        {
                            HttpContext.Current.Session["Financial_Year_ID"] = Convert.ToInt32(dst.Tables[0].Rows[0]["Financial_Year_ID"]);
                            HttpContext.Current.Session["Financial_Year_Text"] = dst.Tables[0].Rows[0]["Financial_Year"];
                        }
                        else
                        {
                            HttpContext.Current.Session["Financial_Year_ID"] = "4";
                            HttpContext.Current.Session["Financial_Year_Text"] = "2016_17";
                        }
                        HttpContext.Current.Session["Qtr"] = "";
                        HttpContext.Current.Session["frm"] = "26Q";
                        int logins = 0;
                        if (ds.Tables[0].Rows[0]["Logins"].ToString() != "" && ds.Tables[0].Rows[0]["Logins"].ToString() != null)
                        {
                            logins = int.Parse(ds.Tables[0].Rows[0]["Logins"].ToString());
                        }

                        Session["logins"] = logins;
                        string lastupdate = "";
                        if (ds.Tables[0].Rows[0]["LastLogin1"].ToString() != "" && ds.Tables[0].Rows[0]["LastLogin1"].ToString() != null)
                        {
                            //lastup = DateTime.Parse(dtUserInfo.Rows[0]["LastLogin1"].ToString());
                            lastupdate = ds.Tables[0].Rows[0]["LastLogin1"].ToString();
                        }
                        else
                        {
                            //lastup = DateTime.Parse(dtUserInfo.Rows[0]["CreatedDate1"].ToString());
                            lastupdate = ds.Tables[0].Rows[0]["CreatedDate1"].ToString();
                        }


                        string stat = "";
                        string schemes = "";


                        //stat = ds.Tables[0].Rows[0]["DayRemaing"].ToString();
                        //schemes = ds.Tables[0].Rows[0]["Schemes"].ToString();


                        //if (schemes == "Free Version")
                        //{
                        //    string q11 = "select cm.CreatedDate,cm.Company_Id,sp.DayCount,sp.Schemes,case when ((getdate()> (dateadd(day,sp.DayCount,cm.CreatedDate))) and (sp.Schemes='Free Version')) then 'Account Expired' when ((getdate()< (dateadd(day,sp.DayCount,cm.CreatedDate))) and (sp.Schemes='Free Version'))  then 'Free Trail will Expire in '+ convert(varchar(3),datediff(day,getdate(),(dateadd(day,sp.DayCount,cm.CreatedDate))))+' days' else 'Active' end as DayRemaing,convert(varchar(3),datediff(day,getdate(),(dateadd(day,sp.DayCount,cm.CreatedDate))))as days  from dbo.tbl_Company_Master  as cm inner join ( select DayCount,Company_Id,Schemes from dbo.SecurityPermission)sp on sp.Company_Id=cm.Company_Id where cm.Company_Id='" + Session["companyid"].ToString() + "' and sp.Schemes='Free Version'";
                        //    DataTable dt11 = db.GetDataTable(q11);
                        //    int days = 0;
                        //    if (dt11.Rows.Count != 0 && dt11 != null)
                        //    {
                        //        days = Convert.ToInt32(dt11.Rows[0]["days"].ToString());
                        //        Session["days"] = days;
                        //    }
                        //    //if (days == 15 || days == 20 || days == 25)
                        //    //{
                        //    //    SendNotificationEmail(emailid);
                        //    //}
                        //}
                        //else
                        //{
                        obj.Add(new Tbl_Login()
                        {
                            Msg = "",
                            url = Comm.GetValue<string>("TDS/Regular/Dashboard.aspx"),
                            UsrRole = Comm.GetValue<string>("Company"),

                        });
                        //}


                    }
                    else
                    {
                        obj.Add(new Tbl_Login()
                        {
                            Msg = Comm.GetValue<string>("Invalid Username or Password"),
                            url = "",
                            UsrRole = Comm.GetValue<string>("Company"),

                        });
                    }



                }

            }
            else
            {
                obj.Add(new Tbl_Login()
                {
                    Msg = Comm.GetValue<string>("Invalid Username or Password"),
                    url = "",
                });

            }

        }
        catch (Exception ex)
        {
            //throw ex;

        }

        IEnumerable<Tbl_Login> tbl = obj as IEnumerable<Tbl_Login>;
        var obbbbb = tbl;
        return new JavaScriptSerializer().Serialize(tbl);

    }


}