using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Microsoft.ApplicationBlocks1.Data;
using DataLayer;
using System.Data.SqlClient;
using CommonLibrary;
namespace DataLayer
{
    public class DAL_Traces : DALCommon
    {
        public int Company_ID { get; set; }
        public string Quarter { get; set; }
        public string FormType { get; set; }
        public string FAYear { get; set; }
        public int Challan_ID {  get; set; }

        //Traces Request Details
        public string RequestNo { get; set; }
        public string FileProcessed { get; set; }
        public string Status { get; set; }
        public string Remarks { get; set; }
        public string authcode { get; set; }

        public DataTable dtRequestDetails { get; set; }
        public string User_ID { get; set; }
        public string Password { get; set; }
        public string Tan { get; set; }
        public string PRN { get; set; }
        

        DataSet ds = new DataSet();
        public DataSet DAL_Get_Challan_Details()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[5];
                param[0] = new SqlParameter("@strMode", "Select");
                param[1] = new SqlParameter("@Company_ID", Company_ID);
                param[2] = new SqlParameter("@Quarter", Quarter);
                param[3] = new SqlParameter("@FormType", FormType);
                param[4] = new SqlParameter("@challanID", Challan_ID);

              //  string conString = Connection_String_Traces(FormType);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_Bind_ChallenDetails_For_Traces_V2", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet DAL_Get_Challan()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@Company_ID", Company_ID);
                param[1] = new SqlParameter("@Quarter", Quarter);
                param[2] = new SqlParameter("@FormType", FormType);

                //  string conString = Connection_String_Traces(FormType);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_Bind_ChallanDetails", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet DAL_Get_tracesLoginDetails()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Company_ID", Company_ID);              

                
                ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "Usp_Traces_Get_Traces_Login", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        
        public DataSet DAL_Insert_Challan_Details()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[9];
                param[0] = new SqlParameter("@Mode", "Insert");
                param[1] = new SqlParameter("@Company_ID", Company_ID);
                param[2] = new SqlParameter("@UserID", User_ID);
                param[3] = new SqlParameter("@password", Password);
                param[4] = new SqlParameter("@Tan", Tan);
                param[5] = new SqlParameter("@Quarter", Quarter);
                param[6] = new SqlParameter("@PRNNo", PRN);
                param[7] = new SqlParameter("@tvp", dtRequestDetails);
                param[8] = new SqlParameter("@FormType", FormType);
                
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "Usp_Traces_Request_dtls", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataSet DAL_Insert_Traces_Login()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[5];
                param[0] = new SqlParameter("@mode", "INsert");
                param[1] = new SqlParameter("@Company_ID", Company_ID);                
                param[2] = new SqlParameter("@UserID", User_ID);
                param[3] = new SqlParameter("@password", Password);
                param[4] = new SqlParameter("@Tan", Tan);
                ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.StoredProcedure, "usp_TracesLogin_Master", param);
                return ds;
            }
            catch(Exception ex)
            {
                throw;
            }
        }
        public DataSet DAL_Insert_Login_Details()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[4];
                param[0] = new SqlParameter("@strMode", "Select");
                param[1] = new SqlParameter("@Company_ID", Company_ID);
                param[2] = new SqlParameter("@Quarter", Quarter);
                param[3] = new SqlParameter("@FormType", FormType);

               // string conString = Connection_String_Traces(FormType);
                ds = SqlHelper.ExecuteDataset(_cnnString2, CommandType.StoredProcedure, "usp_TracesLogin_Master", param);
                return ds;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }


    }
}
