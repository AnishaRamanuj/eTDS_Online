using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using PayrollProject;
using System.Web.UI.WebControls;

public partial class controls_userlisting_control : System.Web.UI.UserControl
{
    CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
    private readonly DBAccess db = new DBAccess();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            bindgrid();
            //bindroles();
            //bindusername();
            bindcompany();
        }
        this.Page.Form.DefaultFocus = txtsearch.UniqueID;
        //this.Page.Form.DefaultButton = Button2.UniqueID;
        txtsearch.Attributes.Add("onfocus", "SearchCheck();");
        txtsearch.Attributes.Add("onblur", "showsearch(this);");
    }
    public SqlDataSource userlist_data
    {
        get { return SqlDataSource1; }
    }
    //public SqlDataSource userroles
    //{
    //    get { return SqlDataSourcerole; }
    //}
    public SqlDataSource usernames
    {
        get { return SqlDataSourceusrname; }
    }
    public void bindgrid()
    {
        try
        {
            //userlist_data.SelectCommand = "select cpassword,Emailid,UserId,cUserName,dbo.fnUserStatus(IsApproved) as status,Role,CompanyName as fullname,Company_Id as mastid from tbl_Company_Master order by CompanyName asc";
            userlist_data.SelectCommand = "SELECT dbo.tbl_Company_Register.Company_ID as mastid, dbo.tbl_Company_Master.CompanyName  as fullname, dbo.tbl_Company_Master.CPassword," +
                   " dbo.tbl_Company_Master.CUserName, dbo.tbl_Company_Master.EmailID, dbo.tbl_Company_Master.UserID, dbo.tbl_Company_Master.Sub_Companys, " +
                   " dbo.tbl_Company_Master.Sub_Company_Count FROM  dbo.tbl_Company_Register INNER JOIN  dbo.tbl_Company_Master ON dbo.tbl_Company_Register.Company_ID = dbo.tbl_Company_Master.Company_ID  where dbo.fnUserStatus(IsApproved)='Active' order by dbo.tbl_Company_Register.CompanyName asc";
            Griddealers.DataBind();
        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex);
            throw ex;
        }
    }
    public void bindcompany()
    {
        try
        {
            usernames.SelectCommand = "select tbl_Company_Register.CompanyName,aspnet_Users.UserName from aspnet_Users inner join  tbl_Company_Register on aspnet_Users.UserId=tbl_Company_Register.UserId order by tbl_Company_Register.CompanyName";
            drpusername.DataBind();
        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex);
            throw ex;
        }
    }
    //public void bindroles()
    //{
    //    userroles.SelectCommand = "select RoleName from aspnet_Roles";
    //    drproles.DataBind();
    //}
    //public void bindusername()
    //{
    //    usernames.SelectCommand = "select UserName from aspnet_Users";
    //    drpusername.DataBind();
    //}
    protected void Griddealers_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Griddealers.PageIndex = e.NewPageIndex;
        bindgrid();
    }
    protected void Griddealers_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "view")
            {
                LinkButton btn = (LinkButton)e.CommandSource;
                GridViewRow row = (GridViewRow)btn.NamingContainer;
                // int compid = int.Parse(Griddealers.DataKeys[row.RowIndex].Value.ToString());
                Label lblstatus = (Label)row.FindControl("Label4");
                LinkButton lblfulname = (LinkButton)row.FindControl("Label2");
                Label lblid = (Label)row.FindControl("Label1");
                LinkButton usrname = (LinkButton)row.FindControl("lnkcmpName");
                //if (lblstatus.Text == "client")
                //{
                //    //Session["clientid"] = lblid.Text;
                //    Response.Redirect("ClientDetails.aspx?id=" + lblid.Text + "&username=" + btn.Text);
                //}
                //if (lblstatus.Text == "Company-Admin")
                //{
                    //Session["clientid"] = lblid.Text;
                    Session["fulname1"] = lblfulname.Text;
                    Response.Redirect("~/SuperAdmin/CompanyDetails.aspx?id=" + lblid.Text + "&username=" + usrname.Text);
                //}
                //else if (lblstatus.Text == "staff")
                //{
                //    //Session["clientid"] = lblid.Text;
                //    Response.Redirect("StaffDetails.aspx?id=" + lblid.Text + "&username=" + btn.Text);
                //}
            }
        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex);
            throw ex;
        }
    }

    protected void btnsearch_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            string username = "";
            string status = "";
            string str = "";
            string name = "";
            if (drpstatus.SelectedIndex != 0)
            {
                if (drpstatus.SelectedValue == "Active")
                {
                    status = "True";
                }
                else if (drpstatus.SelectedValue == "Suspended")
                {
                    status = "False";
                }
            }
            if (drpusername.SelectedIndex != 0)
                username = drpusername.SelectedValue;
            else if (txtsearch.Text != "search")
                name = txtsearch.Text;
            //else if (Session["text"] != null && Session["text1"] != null)
            //{
            //    username = Session["text"].ToString();
            //    name = Session["text1"].ToString();
            //}
            //else if (Session["text"] != null)
            //{
            //    username = Session["text"].ToString();
            //}
            if (name != "" && username != "" && status != "")
            {
                str = "select password,Email,UserId,UserName,dbo.fnUserStatus(IsApproved) as status,Role,CompanyName as fullname,CompId as mastid from tbl_Company_Master where username like '%" + username + "%' or CompanyName like '%" + name + "%' or tbl_Company_Master.IsApproved='" + status + "' order by UserName asc";
            }
            if (name != "" && status != "")
            {
                str = "select password,Email,UserId,UserName,dbo.fnUserStatus(IsApproved) as status,Role,CompanyName as fullname,CompId as mastid from tbl_Company_Master where username='" + name + "' or tbl_Company_Master.IsApproved='" + status + "' order by UserName asc";
            }
            if (username != "" && status != "")
            {
                //string str = "select convert(varchar(100),mem.password) as password,mem.Email,mem.UserId,u.UserName,dbo.fnUserStatus(mem.IsApproved) as status,dbo.UserRole(mem.UserId) as role,dbo.fnName(dbo.UserRole(mem.UserId),mem.UserId) as fullname,dbo.fnMasterId(dbo.UserRole(mem.UserId),mem.UserId) as mastid from aspnet_Membership as mem inner join aspnet_Users as u on u.UserId=mem.UserId where dbo.fnName(dbo.UserRole(mem.UserId),mem.UserId) like '%" + txtsearch.Text.Trim() + "%' or username='" + drpusername.SelectedItem.Text + "' or dbo.fnUserStatus(mem.IsApproved)='" + drpstatus.SelectedItem.Text + "' and dbo.UserRole(mem.UserId)='Company'";
                str = "select password,Email,UserId,UserName,dbo.fnUserStatus(IsApproved) as status,Role,CompanyName as fullname,CompId as mastid from tbl_Company_Master where username='" + username + "' or tbl_Company_Master.IsApproved='" + status + "' order by UserName asc";
            }
            else if (name != "" && username != "")
            {
                str = "select password,Email,UserId,UserName,dbo.fnUserStatus(IsApproved) as status,Role,CompanyName as fullname,CompId as mastid from tbl_Company_Master where username like '%" + username + "%' or CompanyName like '%" + name + "%' order by UserName asc";

            }
            else if (username != "")
            {
                str = "select password,Email,UserId,UserName,dbo.fnUserStatus(IsApproved) as status,Role,CompanyName as fullname,CompId as mastid from tbl_Company_Master where username like '%" + username + "%' order by UserName asc";

            }
            else if (name != "")
            {
                str = "select password,Email,UserId,UserName,dbo.fnUserStatus(IsApproved) as status,Role,CompanyName as fullname,CompId as mastid from tbl_Company_Master where CompanyName like '%" + name + "%' order by username";
            }
            else if (status != "")
            {
                str = "select Cpassword,EmailID,UserId,CUserName,dbo.fnUserStatus(IsApproved) as status,Role,CompanyName as fullname,Company_ID as mastid,Sub_Companys,Sub_Company_Count from tbl_Company_Master where tbl_Company_Master.IsApproved='" + status + "' order by CompanyName asc";

            }
            else
            {
                str = "select password,Email,UserId,UserName,dbo.fnUserStatus(IsApproved) as status,Role,CompanyName as fullname,CompId as mastid from tbl_Company_Master order by UserName asc";

            }
            userlist_data.SelectCommand = str;
            Griddealers.DataBind();
            Session["text"] = null;
        }
        catch (Exception ex)
        {
            ErrorException.LogError(ex);
            throw ex;
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("CompanyRegistration.aspx");
    }
}
