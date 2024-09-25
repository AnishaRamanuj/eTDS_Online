using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;
using System.Data;
using System.Data.SqlClient;

namespace BusinessLayer
{
    public class BAL_FeedBack
    {
        DAL_FeedBack obj = new DAL_FeedBack();

        public int Company_Id { get; set; }

        public string CreatedBy { get; set; }

        public string CompanyName { get; set; }

        public string YourName { get; set; }

        public string Email { get; set; }

        public string mobileno { get; set; }

        public string feedback { get; set; }

        public string extra { get; set; }

        public int BAL_InsertGetFeedback()
        {
            try
            {
                obj.Company_Id = Company_Id;
                obj.CompanyName = CompanyName;
                obj.YourName = YourName;
                obj.Email = Email;
                obj.mobileno = mobileno;
                obj.feedback = feedback;
                obj.extra = extra;
                obj.CreatedBy = CreatedBy;
                int result = obj.DAL_InsertGetFeedback();
                return result; 
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet BAl_GetAllFeedBack()
        {
            try
            {
                obj.Company_Id = Company_Id;
                DataSet dr = obj.DAl_GetAllFeedBack();
                return dr;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
