namespace PANVrf
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;

    /// <summary>
    /// Summary description for RequestStatus
    /// </summary>
    public class RequestStatus
    {

        private string strAuthenCode = "";
        private string strFinalResponse = "";

        public string AuthenticationCode
        {
            get
            {
                return this.strAuthenCode;
            }
            set
            {
                this.strAuthenCode = value;
            }
        }

        public string StatusMessage
        {
            get
            {
                return this.strFinalResponse;
            }
            set
            {
                this.strFinalResponse = value;
            }
        }

    }
}