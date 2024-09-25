using DataLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace BusinessLayer
{
    public class BAL_Traces
    {
        DAL_Traces objDAL_Traces = new DAL_Traces();

        public int _Company_ID { get; set; }
        public string _FAYear { get; set; }
        public string _Quarter { get; set; }
        public string _FormType { get; set; }
        public int _Challan_ID { get; set; }

        //Traces Request Details
        public string _RequestNo { get; set; }
        public string _FileProcessed { get; set; }
        public string _Status { get; set; }
        public string _Remarks { get; set; }
        public string _authcode { get; set; }
        public DataTable _dtRequestDetails { get; set; }
                

        public string _User_ID { get; set; }
        public string _Password { get; set; }
        public string _Tan { get; set; }
        public string _PRN { get; set; }        

        //To fill challan details in forms
        public DataSet Get_Challan_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Traces.Company_ID = _Company_ID;
                objDAL_Traces.Quarter = _Quarter;
                objDAL_Traces.FormType = _FormType;
                objDAL_Traces.FAYear = _FAYear;
                objDAL_Traces.Challan_ID = _Challan_ID;
                ds = objDAL_Traces.DAL_Get_Challan_Details();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }
        public DataSet Get_Challan()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Traces.Company_ID = _Company_ID;
                objDAL_Traces.Quarter = _Quarter;
                objDAL_Traces.FormType = _FormType;
                objDAL_Traces.FAYear = _FAYear;
                ds = objDAL_Traces.DAL_Get_Challan();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }
        public DataSet Get_tracesLoginDetails()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Traces.Company_ID = _Company_ID;

                ds = objDAL_Traces.DAL_Get_tracesLoginDetails();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }
        //insert traces Request details
        public DataSet Insert_Traces_Reques_Dtls()
        {
            DataSet ds = new DataSet();
            try
            {
                //objDAL_Traces.Company_ID = _CompanyID;
                //objDAL_Traces.RequestNo = _RequestNo;
                //objDAL_Traces.FAYear = _FAYear;
                //objDAL_Traces.Quarter = _Quarter;
                //objDAL_Traces.FormType = _FormType;
                //objDAL_Traces.FileProcessed = _FileProcessed;
                //objDAL_Traces.Status = _Status;
                //objDAL_Traces.Remarks = _Remarks;
                //objDAL_Traces.authcode = _authcode;

                objDAL_Traces.dtRequestDetails = _dtRequestDetails;
                objDAL_Traces.Company_ID =_Company_ID ;
                objDAL_Traces.User_ID = _User_ID;
                objDAL_Traces.Password = _Password;
                objDAL_Traces.Tan = _Tan;
                objDAL_Traces.PRN = _PRN;
                objDAL_Traces.Quarter = _Quarter;
                objDAL_Traces.FormType = _FormType;
                ds = objDAL_Traces.DAL_Insert_Challan_Details();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }
        //insert traces Request details
        public DataSet Insert_Traces_Login()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Traces.Company_ID = _Company_ID;
                objDAL_Traces.User_ID = _User_ID;
                objDAL_Traces.Password = _Password;
                objDAL_Traces.Tan = _Tan;

                ds = objDAL_Traces.DAL_Insert_Traces_Login();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

    }
}
