namespace PANVrf
{
    using System;

    public class PAN
    {
        private string enmStatus = "";
        private string strName = "";
        private string strAONumber = "";
        private string strAOType = "";
        private string strAreaCode = "";
        private string strBuildingName = "";
        private string strFirstName = "";
        private string strJurisdiction = "";
        private string strMiddleName = "";
        private string strRangeCode = "";
        private string strSurname = "";
        private string PANNo = "";

        public string Name
        {
            get
            {
                return this.strName;
            }
            set
            {
                this.strName = value;
            }
        }

        public string Status
        {
            get
            {
                return this.enmStatus;
            }
            set
            {
                this.enmStatus = value;
            }
        }



        public string AONumber
        {
            get
            {
                return this.strAONumber;
            }
            set
            {
                this.strAONumber = value;
            }
        }

        public string AOType
        {
            get
            {
                return this.strAOType;
            }
            set
            {
                this.strAOType = value;
            }
        }

        public string AreaCode
        {
            get
            {
                return this.strAreaCode;
            }
            set
            {
                this.strAreaCode = value;
            }
        }

        public string BuildingName
        {
            get
            {
                return this.strBuildingName;
            }
            set
            {
                this.strBuildingName = value;
            }
        }

        public string FirstName
        {
            get
            {
                return this.strFirstName;
            }
            set
            {
                this.strFirstName = value;
            }
        }

        public string Jurisdiction
        {
            get
            {
                return this.strJurisdiction;
            }
            set
            {
                this.strJurisdiction = value;
            }
        }

        public string MiddleName
        {
            get
            {
                return this.strMiddleName;
            }
            set
            {
                this.strMiddleName = value;
            }
        }

        public string RangeCode
        {
            get
            {
                return this.strRangeCode;
            }
            set
            {
                this.strRangeCode = value;
            }
        }

        public string Surname
        {
            get
            {
                return this.strSurname;
            }
            set
            {
                this.strSurname = value;
            }
        }

        public string PAN_no
        {
            get
            {
                return this.PANNo;
            }
            set
            {
                this.PANNo = value;
            }
        }
    }
}

