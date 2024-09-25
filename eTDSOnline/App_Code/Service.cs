using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Script.Services;
using CommonLibrary;
using System.Web.Script.Serialization;

/// <summary>
/// Summary description for Service_CS
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class Service : System.Web.Services.WebService
{

    public Service()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    [WebMethod(EnableSession = true)]
    public string[] getEmployee(string prefix)
    {
        List<string> customers = new List<string>();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                string[] para = prefix.Split(',');
                cmd.CommandText = "select FirstName,Employee_ID from tbl_Employee_Master where resign_DT is null and Company_ID= " + para[1] +
                " and FirstName like '%'+ @SearchText + '%' order by FirstName";
                cmd.Parameters.AddWithValue("@SearchText", para[0]);
                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        customers.Add(string.Format("{0}-{1}", sdr["FirstName"], sdr["Employee_ID"]));
                    }
                }
                conn.Close();
            }
            return customers.ToArray();
        }
    }
    [WebMethod]
    public string getAllEmployees(int Comp)
    {
        List<tbl_Employee_Master> lEmp = new List<tbl_Employee_Master>();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "select ";
                cmd.CommandText += " Employee_ID,";
                cmd.CommandText += " FirstName,";
                cmd.CommandText += " Gender,";
                cmd.CommandText += " Designation_Name,";
                cmd.CommandText += " Department_Name,";
                cmd.CommandText += " PAN_NO,";
                cmd.CommandText += " Branch_Name,";
                cmd.CommandText += " Resign_DT,";
                cmd.CommandText += " Senior_CTZN_Type,";
                cmd.CommandText += " Reason_Of_Leaving";
                cmd.CommandText += " from tbl_Employee_Master";
                cmd.CommandText += " left outer join tbl_Department_Master DM on tbl_Employee_Master.Department_ID=DM.Department_ID";
                cmd.CommandText += " left outer join tbl_Designation_Master DSG on tbl_Employee_Master.Designation_ID=DSG.Designation_ID";
                cmd.CommandText += " left outer join tbl_Branch_Salary_Master BM on tbl_Employee_Master.Branch_ID=BM.Branch_ID";
                cmd.CommandText += " where tbl_Employee_Master.Company_ID= " + Comp + " order by FirstName";
                cmd.Connection = conn;
                conn.Open();
                CommonFunctions o = new CommonFunctions();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        lEmp.Add(new tbl_Employee_Master()
                        {
                            Employee_ID = o.GetValue<int>(sdr["Employee_ID"].ToString()),
                            EmpName = o.GetValue<string>(sdr["FirstName"].ToString()).ToLower(),
                            Gender = o.GetValue<string>(sdr["Gender"].ToString()),
                            Designation_Name = o.GetValue<string>(sdr["Designation_Name"].ToString()),
                            Department_Name = o.GetValue<string>(sdr["Department_Name"].ToString()),
                            PAN_NO = o.GetValue<string>(sdr["PAN_NO"].ToString()),
                            Branch_Name = o.GetValue<string>(sdr["Branch_Name"].ToString()),
                            Senior_CTZN_Type = o.GetValue<string>(sdr["Senior_CTZN_Type"].ToString()),
                            Reason_Of_Leaving = o.GetValue<string>(sdr["Reason_Of_Leaving"].ToString()),
                        });
                    }
                }
                conn.Close();
            }
            return new JavaScriptSerializer().Serialize(lEmp as IEnumerable<tbl_Employee_Master>);
        }
    }

}
