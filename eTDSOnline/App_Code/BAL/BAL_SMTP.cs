using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_SMTP
    {
        DAL_SMTP objDAL_SMTP = new DAL_SMTP();

        public int _Company_ID { get; set; }
        public string _SMTP_Server { get; set; }
        public int _SMTP_Port { get; set; }
        public bool _SSL { get; set; }
        public string _SMTP_Authenticate { get; set; }
        public string _SMTP_User_Name { get; set; }
        public string _User_Password { get; set; }

        public DataSet Get_SMTP_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_SMTP._Company_ID = _Company_ID;
                ds = objDAL_SMTP.Get_SMTP_Details();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Get_SMTP_List()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = objDAL_SMTP.Get_SMTP_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_SMTP()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_SMTP._Company_ID = _Company_ID;
                ds = objDAL_SMTP.Delete_SMTP();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Insert_SMTP()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_SMTP._Company_ID = _Company_ID;
                objDAL_SMTP._SMTP_Server = _SMTP_Server;
                objDAL_SMTP._SMTP_Port = _SMTP_Port;
                objDAL_SMTP._SSL = _SSL;
                objDAL_SMTP._SMTP_Authenticate = _SMTP_Authenticate;
                objDAL_SMTP._SMTP_User_Name = _SMTP_User_Name;
                objDAL_SMTP._User_Password = _User_Password;

                ds = objDAL_SMTP.Insert_SMTP();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Update_SMTP()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_SMTP._Company_ID = _Company_ID;
                objDAL_SMTP._SMTP_Server = _SMTP_Server;
                objDAL_SMTP._SMTP_Port = _SMTP_Port;
                objDAL_SMTP._SSL = _SSL;
                objDAL_SMTP._SMTP_Authenticate = _SMTP_Authenticate;
                objDAL_SMTP._SMTP_User_Name = _SMTP_User_Name;
                objDAL_SMTP._User_Password = _User_Password;

                ds = objDAL_SMTP.Update_SMTP();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }
    }
}
