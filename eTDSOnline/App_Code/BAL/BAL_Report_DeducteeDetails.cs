using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;
using CommonLibrary;
using System.Data.SqlClient;

namespace BusinessLayer
{
    public class BAL_Report_DeducteeDetails : CommonFunctions
    {
        DAL_Report_DeducteeDetails objDAL_Report_DeducteeDetails = new DAL_Report_DeducteeDetails();

        public List<tbl_Voucher> BAL_GetDeducteesForSelection(tbl_Voucher obj)
        {
            List<tbl_Voucher> tbl = new List<tbl_Voucher>();
            using (SqlDataReader drrr = objDAL_Report_DeducteeDetails.DAL_GetDeducteesForSelection(obj))
            {
                while (drrr.Read())
                {
                    tbl.Add(new tbl_Voucher()
                    {
                        Deductee_ID = GetValue<int>(drrr["Deductee_ID"].ToString()),
                        Deductee_Name = GetValue<string>(drrr["Deductee_Name"].ToString()),
                        Nature_Name = GetValue<string>(drrr["Nature_Name"].ToString()),
                        PAN_NO = GetValue<string>(drrr["PAN_No"].ToString()),
                        Reason = GetValue<string>(drrr["Reasons"].ToString()),
                        PANVerified = GetValue<string>(drrr["PANVerified"].ToString()),
                        TotalCount = GetValue<string>(drrr["TotalCount"].ToString()),
                        SrNo = GetValue<int>(drrr["SrNo"].ToString())
                    });
                }
            }
            return tbl;
        }

        public List<tbl_Voucher> BAL_GetDeducteeMasterDetails(tbl_Voucher obj)
        {
            List<tbl_Voucher> tbl = new List<tbl_Voucher>();
            using (SqlDataReader drrr = objDAL_Report_DeducteeDetails.DAL_GetDeducteeMasterDetails(obj))
            {
                while (drrr.Read())
                {
                    tbl.Add(new tbl_Voucher()
                    {
                        Deductee_ID = GetValue<int>(drrr["Deductee_ID"].ToString()),
                        Deductee_Name = GetValue<string>(drrr["Deductee_Name"].ToString()),
                        Flat_No = GetValue<string>(drrr["Flat_No"].ToString()),
                        Bldg_Name = GetValue<string>(drrr["Bldg_Name"].ToString()),
                        Street = GetValue<string>(drrr["Street"].ToString()),
                        City = GetValue<string>(drrr["City"].ToString()),
                        pincode = GetValue<string>(drrr["pincode"].ToString()),
                        Nature_Name = GetValue<string>(drrr["Nature_Name"].ToString()),
                        Deductee_Type = GetValue<string>(drrr["Deductee_Type"].ToString()),
                        is_Individual = GetValue<bool>(drrr["is_Individual"].ToString()),
                        Reason = GetValue<string>(drrr["Reasons"].ToString()),
                        IS_NRI = GetValue<bool>(drrr["is_nri"].ToString()),
                        Country_Name = GetValue<string>(drrr["Country_Name"].ToString()),
                        PAN_NO = GetValue<string>(drrr["PAN_No"].ToString()),
                        PANVerified = GetValue<string>(drrr["PANVerified"].ToString()),
                        Branch_Name = GetValue<string>(drrr["Branch_Name"].ToString())
                    });
                }
            }
            return tbl;
        }
    }
}
