using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;
using System.Data.SqlClient;

namespace BusinessLayer
{
   public class BAL_Register_Company
    {
       DAL_Register_Company objDal = new DAL_Register_Company();

       public string ContactP { get; set; }
       public string Company_Name { get; set; }
       public string Contact_Tel { get; set; }
       public string Email { get; set; }
       public int Company_ID { get; set; }
       public string SearchTxt { get; set; }
       public string SearchTxtFld { get; set; }
       public string UserName { get; set; }
       public string Password { get; set; }
       public Guid userid { get; set; }
       public Guid Role_ID { get; set; }
       public string Role_Name { get; set; }
       public SqlTransaction _Trans { get; set; }

       public DataSet Get_Company_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDal.Company_ID = Company_ID;
                ds = objDal.Get_Company_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

       public DataSet Get_Role_ID()
       {
           DataSet ds = new DataSet();
           try
           {
               objDal.Role_Name = Role_Name;
               ds = objDal.Get_Role_ID();
           }
           catch (Exception)
           {
               throw;
           }
           return ds;
       }
       
       public DataSet Get_Company_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDal.Company_Name = Company_Name;
                objDal.Company_ID = Company_ID;
                ds = objDal.Get_Company_Master_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Company_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDal.Company_ID = Company_ID;
                //ds = objDal.Delete_Bank_Master();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Insert_Company_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDal.Company_Name = Company_Name;
                objDal.ContactP = ContactP;
                objDal.Contact_Tel = Contact_Tel;
                objDal.Email = Email;
                objDal.UserName = UserName;
                objDal.Password = Password;
                objDal.userid = userid;
                objDal._Trans = _Trans;
                objDal.Company_ID = Company_ID;
                ds = objDal.Insert_Register_Company_Master();
                Company_ID = objDal.Company_ID; 
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }


        public DataSet Insert_Company_RoleMapping()
        {
            DataSet ds = new DataSet();
            try
            {
                objDal.Company_ID = Company_ID;
                objDal.Role_ID = Role_ID;
                objDal.Role_Name = Role_Name;
                objDal.userid = userid;

                ds = objDal.Insert_Company_RoleMapping ();
                Company_ID = objDal.Company_ID;
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }


        public DataSet Insert_Admin_Company_Mapping()
        {
            DataSet ds = new DataSet();
            try
            {
                objDal.Company_ID = Company_ID;
                objDal.userid = userid;

                ds = objDal.Insert_Admin_Company_Mapping ();
                //Company_ID = objDal.Company_ID;
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        //public DataSet Update_Bank_Master()
        //{
        //    DataSet ds = new DataSet();
        //    try
        //    {
        //        objDal._Bank_ID = _Bank_ID;
        //        objDal._Bank_Name = _Bank_Name;
        //        objDal._Bank_Branch = _Bank_Branch;
        //        objDal._Bsrcode = _Bsrcode;
        //        objDal._Company_ID = _Company_ID;

        //        ds = objDal.Update_Bank_Master();
        //    }
        //    catch (Exception)
        //    {
        //        throw;
        //    }
        //    return ds;
        //}
    
    }
}
