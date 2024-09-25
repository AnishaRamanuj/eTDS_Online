using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Traces_TDS_TCS_Credit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public string reTCSTDSCredit_DeduteeDetails()
    {
        return HttpContext.Current.Request.Form["page"];
    }
}