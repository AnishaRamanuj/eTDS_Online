namespace PANVrf
{
    using System;


    public class eResponse
    {
        private string CsiPath = "";
        private string strAuthenCode = "";
        private string strFinalResponse = "";
        private object CustomTypes;
        private eRes Response;
        private string strMessage;

        public string CsiPathName
        {
            get
            {
                return this.CsiPath;
            }
            set
            {
                this.CsiPath = value;
            }
        }

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

        public eRes Respons
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
    }
    public enum eRes
    {
        Success,
        Failed,
        SessionTimeout
    }

    public enum Message
    {
        Valid,
        Invalid
    }


}

