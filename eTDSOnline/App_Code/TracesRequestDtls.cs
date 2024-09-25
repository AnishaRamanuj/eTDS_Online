


public class TracesRequestDtls
{
    private int strCompany_ID = 0;
    private string strRequestNo = string.Empty;
    private string strFinancialYear = string.Empty;
    private string strQuarter = string.Empty;
    private string strFormType = string.Empty;
    private string strFileProcessed = string.Empty;
    private string strStatus = string.Empty;
    private string strRemarks = string.Empty;
    private string strAuthcode = string.Empty;

    public int Company_ID
    {
        get
        {
            return this.strCompany_ID;
        }
        set
        {
            this.strCompany_ID = value;
        }
    }
    public string RequestNo
    {
        get
        {
            return this.strRequestNo;
        }
        set
        {
            this.strRequestNo = value;
        }
    }

    public string FinancialYear
    {
        get
        {
            return this.strFinancialYear;
        }
        set
        {
            this.strFinancialYear = value;
        }
    }

    public string Quarter
    {
        get
        {
            return this.strQuarter;
        }
        set
        {
            this.strQuarter = value;
        }
    }

    public string Forms
    {
        get
        {
            return this.strFormType;
        }
        set
        {
            this.strFormType = value;
        }
    }

    public string FileProcessed
    {
        get
        {
            return this.strFileProcessed;
        }
        set
        {
            this.strFileProcessed = value;
        }
    }

    public string Status
    {
        get
        {
            return this.strStatus;
        }
        set
        {
            this.strStatus = value;
        }
    }
    public string Remarks
    {
        get
        {
            return this.strRemarks;
        }
        set
        {
            this.strRemarks = value;
        }
    }
    public string Authcode
    {
        get
        {
            return this.strAuthcode;
        }
        set
        {
            this.strAuthcode = value;
        }
    }

}