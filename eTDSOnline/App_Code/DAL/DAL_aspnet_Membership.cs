using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;


namespace DataLayer
{
    public class DAL_aspnet_Membership : DALCommon
    {
        public string _ApplicationId { get; set; }
        public string _UserId { get; set; }
        public string _Password { get; set; }
        public int _PasswordFormat { get; set; }
        public string _PasswordSalt { get; set; }
        public string _MobilePIN { get; set; }
        public string _Email { get; set; }
        public string _LoweredEmail { get; set; }
        public string _PasswordQuestion { get; set; }
        public string _PasswordAnswer { get; set; }
        public bool _IsApproved { get; set; }
        public bool _IsLockedOut { get; set; }
        public DateTime _CreateDate { get; set; }
        public DateTime _LastLoginDate { get; set; }
        public DateTime _LastPasswordChangedDate { get; set; }
        public DateTime _LastLockoutDate { get; set; }
        public int _FailedPasswordAttemptCount { get; set; }
        public DateTime _FailedPasswordAttemptWindowStart { get; set; }
        public int _FailedPasswordAnswerAttemptCount { get; set; }
        public DateTime _FailedPasswordAnswerAttemptWindowStart { get; set; }
        public string _Comment { get; set; }

        public DataSet Insert_aspnet_Membership()
        {
            DataSet ds = new DataSet();

            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[19];

                objSqlParameter[0] = new SqlParameter("@Password", _Password);
                objSqlParameter[1] = new SqlParameter("@PasswordFormat", _PasswordFormat);
                objSqlParameter[2] = new SqlParameter("@PasswordSalt", _PasswordSalt);
                objSqlParameter[3] = new SqlParameter("@MobilePIN", _MobilePIN);
                objSqlParameter[4] = new SqlParameter("@Email", _Email);
                objSqlParameter[5] = new SqlParameter("@LoweredEmail", _LoweredEmail);
                objSqlParameter[6] = new SqlParameter("@PasswordQuestion", _PasswordQuestion);
                objSqlParameter[7] = new SqlParameter("@PasswordAnswer", _PasswordAnswer);
                objSqlParameter[8] = new SqlParameter("@IsApproved", _IsApproved);
                objSqlParameter[9] = new SqlParameter("@IsLockedOut", _IsLockedOut);
                objSqlParameter[10] = new SqlParameter("@CreateDate", _CreateDate);
                objSqlParameter[11] = new SqlParameter("@LastLoginDate", _LastLoginDate);
                objSqlParameter[12] = new SqlParameter("@LastPasswordChangedDate", _LastPasswordChangedDate);
                objSqlParameter[13] = new SqlParameter("@LastLockoutDate", _LastLockoutDate);
                objSqlParameter[14] = new SqlParameter("@FailedPasswordAttemptCount", _FailedPasswordAttemptCount);
                objSqlParameter[15] = new SqlParameter("@FailedPasswordAttemptWindowStart", _FailedPasswordAttemptWindowStart);
                objSqlParameter[16] = new SqlParameter("@FailedPasswordAnswerAttemptCount", _FailedPasswordAnswerAttemptCount);
                objSqlParameter[17] = new SqlParameter("@FailedPasswordAnswerAttemptWindowStart", _FailedPasswordAnswerAttemptWindowStart);
                objSqlParameter[18] = new SqlParameter("@Comment", _Comment);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Insert_aspnet_Membership", objSqlParameter);
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

    }
}
