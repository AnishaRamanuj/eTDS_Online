


using System.Data;

public class TDSResponse
  {
    private eResponse Response;
    private string strMessage;
    private TracesData objTraceData;
    private object CustomTypes;
    private DataTable DT;
    private string RefId;
    private string ReQId;
    private string challanResponce;
    public eResponse Respons
    {
      get
      {
        return this.Response;
      }
      set
      {
        this.Response = value;
      }
    }

    public string Message
    {
      get
      {
        return this.strMessage;
      }
      set
      {
        this.strMessage = value;
      }
    }

    public TracesData UserData
    {
      get
      {
        return this.objTraceData;
      }
      set
      {
        this.objTraceData = value;
      }
    }

    public object CustomeTypes
    {
      get
      {
        return this.CustomTypes;
      }
      set
      {
        this.CustomTypes = value;
      }
    }

    public DataTable DTable
    {
        get
        {
            return this.DT;
        }
        set
        {
            this.DT = value;
        }
    }

    public string URefid
    {
        get
        {
            return this.RefId;
        }
        set
        {
            this.RefId = value;
        }
    }

    public string URqid
    {
        get
        {
            return this.ReQId;
        }
        set
        {
            this.ReQId = value;
        }
    }

    public string ChlResponce
    {
        get
        {
            return this.challanResponce;
        }
        set
        {
            this.challanResponce = value;
        }
    }

}

