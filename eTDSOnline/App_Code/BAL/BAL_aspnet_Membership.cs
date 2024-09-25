using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_aspnet_Membership
    {
        DAL_aspnet_Membership objDAL_aspnet_Membership = new DAL_aspnet_Membership();

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
                objDAL_aspnet_Membership._Password = _Password;
                objDAL_aspnet_Membership._PasswordFormat = _PasswordFormat;
                objDAL_aspnet_Membership._PasswordSalt = _PasswordSalt;
                objDAL_aspnet_Membership._MobilePIN = _MobilePIN;
                objDAL_aspnet_Membership._Email = _Email;
                objDAL_aspnet_Membership._LoweredEmail = _LoweredEmail;
                objDAL_aspnet_Membership._PasswordQuestion = _PasswordQuestion;
                objDAL_aspnet_Membership._PasswordAnswer = _PasswordAnswer;
                objDAL_aspnet_Membership._IsApproved = _IsApproved;
                objDAL_aspnet_Membership._IsLockedOut = _IsLockedOut;
                objDAL_aspnet_Membership._CreateDate = _CreateDate;
                objDAL_aspnet_Membership._LastLoginDate = _LastLoginDate;
                objDAL_aspnet_Membership._LastPasswordChangedDate = _LastPasswordChangedDate;
                objDAL_aspnet_Membership._LastLockoutDate = _LastLockoutDate;
                objDAL_aspnet_Membership._FailedPasswordAttemptCount = _FailedPasswordAttemptCount;
                objDAL_aspnet_Membership._FailedPasswordAttemptWindowStart = _FailedPasswordAttemptWindowStart;
                objDAL_aspnet_Membership._FailedPasswordAnswerAttemptCount = _FailedPasswordAnswerAttemptCount;
                objDAL_aspnet_Membership._FailedPasswordAnswerAttemptWindowStart = _FailedPasswordAnswerAttemptWindowStart;
                objDAL_aspnet_Membership._Comment = _Comment;

                ds = objDAL_aspnet_Membership.Insert_aspnet_Membership();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

    }
}
