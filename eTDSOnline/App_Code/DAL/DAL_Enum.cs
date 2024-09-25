using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace DataLayer
{
    public enum ROUNDING_MODES
    {
        RUPEES_1 = 0,
        PAISE_0_POINT_5 = 1,
        PAISE_0_POINT_05 = 2,
    }

    public enum HEAD_GROUP
    {
        ADDITION = 0,
        DEDUCTION = 1,
        YEARLY = 2,
        VARIABLE = 3,
    }

    public enum LOAN_STATUS
    {
        PENDING = 0,
        APPROVED = 1,
        REJECTED = -1,
    }

    public enum LEAVE_STATUS
    {
        ALL = 0,
        APPROVED = 1,
        REJECTED = -1,
        PENDING = 2,

    }
    public enum LIMITATION
    {
        PF = 0,
        PROVIDENET_FUND = 1,
        ESIC = 2,
    }
}
