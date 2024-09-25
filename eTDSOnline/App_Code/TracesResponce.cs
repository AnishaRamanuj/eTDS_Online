using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
namespace PANVrf
{
    /// <summary>
    /// Summary description for TracesResponce
    /// </summary>
    public class TracesResponce
    {


        private object CustomTypes;
        private TracesData objTraceData;
 
        private eresposenum eRespo;
        private string strMessage;

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


        public eresposenum eResps
        {
            get
            {
                return this.eRespo;
            }
            set
            {
                this.eRespo = value;
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
    }
}

