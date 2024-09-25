using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.ComponentModel;
using System.Threading;

public partial class Admin_rererer : System.Web.UI.Page
{
    CommonLibrary.CommonFunctions ErrorException = new CommonLibrary.CommonFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        //string a = "2^BH^1^3^24Q^^^^^^^^MUML03492G^^AABCR2885E^201516^201415^Q1^PUNJAB CHEMICALS AND CROP PROTECTION LIMITED^^21^Access Centre^L. T. Road^Andheri^Mumbai^19^400072^accountspunjab@gmail.com^22^28547566^Y^K^Jyotsna Palek^accountant^21^Access Centre^L. T. Road^Andheri^Mumbai^19^400072^accountspunjab@gmail.com^9820154788^22^28547566^Y^11569.00^^^0^N^N^^^^^^^AAZPS0268D^^^^^^^^^^";
        //string s = "";
        //int i = 0, b = 0;
        //foreach (char c in a)
        //{

        //    if (c == '^')
        //    {
        //        i = i + 1;
        //        i++;
        //        s = s + c + "</td><td width='25px'>";
        //    }
        //    else { s = s + c; }
        //}
        //bdb.Text = "<table border=1><tr><td width='25px'>" + s + "</td></tr></table>" + i.ToString();

        //string a1 = "2^BH^1^3^24Q^^^^^^^^MUMP06741A^^AAATM5592P^201516^201415^Q4^PLASTINDIA FOUNDATION^^401-B, LANDMARK^209-A, SUREN ROAD,^ANDHERI (E)^MUMBAI - 400069^^19^400093^accounts@plastindia.org^0222^26832911^Y^T^MR. A N SAPTHAGIREESAN^ADVISOR & SECRETARY ^401-B^LANDMARK, SUREN ROAD^OFF ANDHERI KURLA ROAD^ANDHERI EAST^MUMBAI^19^400093^accounts@plastindia.org^9833794676^022^26832911^N^180147.00^^11^4113807.00^N^N^^^^^^^AERPA2752C^^^^^^^^^^";
        //string s1 = "";

        //foreach (char c in a1)
        //{

        //    if (c == '^')
        //    {
        //        b = b + 1;
        //        b++;
        //        s1 = s1 + c + "</td><td width='25px'>";
        //    }
        //    else { s1 = s1 + c; }
        //}
        //Label1.Text = "<table border=1><tr><td width='25px'>" + s1 + "</td></tr></table>" + b.ToString();
    }

    static BackgroundWorker _bw;
    public static int Percent { get; set; }

    protected void Button1_Click(object sender, EventArgs e)
    {
        _bw = new BackgroundWorker
        {
            WorkerReportsProgress = true,
            WorkerSupportsCancellation = true
        };
        _bw.DoWork += bw_DoWork;
        _bw.ProgressChanged += bw_ProgressChanged;
        _bw.RunWorkerCompleted += bw_RunWorkerCompleted;
        _bw.RunWorkerAsync("Hello world");
    }

    void bw_DoWork(object sender, DoWorkEventArgs e)
    {

        for (int i = 0; i <= 100; i += 20)
        {
            if (_bw.CancellationPending) { e.Cancel = true; return; }
            _bw.ReportProgress(i);
            Thread.Sleep(1000);
        }
        e.Result = 123;
    }

    void bw_RunWorkerCompleted(object sender,
                                       RunWorkerCompletedEventArgs e)
    {
        percentage.Text = "Complete: " + e.Result;      // from DoWork
    }

    void bw_ProgressChanged(object sender,
                                    ProgressChangedEventArgs e)
    {
        Percent = e.ProgressPercentage;
    }

    [WebMethod]
    public static int GetData()
    {
        return Percent;
    }
}