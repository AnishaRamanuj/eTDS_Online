using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Security;
using System.Data;
using System.Net.Mail;
using System.Text;
using System.Configuration;


public partial class _Default : System.Web.UI.Page
{


    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            Session["txtUsername"] = txtUsername.Value.ToString();
            Session["txtPassword"] = txtPassword.Value.ToString();

        }
    }





    //protected void btnSubmit_Click(object sender, EventArgs e)
    //{
    //    string u = txtUsername.Value;
    //    string p = txtPassword.Value;
    //    Session["Username"] = u;
    //    Session["Password"] = p;
    //}
}
