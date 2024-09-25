using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks1.Data;

namespace DataLayer
{
   public class DAL_Register_Company : DALCommon 
    {
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

        public DataSet BindCompanyGrid()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Bind_Company_Master");
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Search4Txt()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] param = new SqlParameter[4];
                param[0] = new SqlParameter("@tblName", "tbl_Bank_Master");
                param[1] = new SqlParameter("@fldName", SearchTxtFld);
                param[2] = new SqlParameter("@Companyid", "1");
                param[3] = new SqlParameter("@flddetails", SearchTxt);

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Search", param);
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Company_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[1];
                objSqlParameter[0] = new SqlParameter("@Company_ID", Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Company_Master", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Get_Company_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                SqlParameter[] objSqlParameter = new SqlParameter[2];
                objSqlParameter[0] = new SqlParameter("@Company_Name", Company_Name);
                objSqlParameter[1] = new SqlParameter("@Company_ID", Company_ID);
                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Get_Company_Master_List", objSqlParameter);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

        public DataSet Insert_Register_Company_Master()
        {
            DataSet ds = new DataSet();

            try
            {

                SqlParameter[] objParameter = new SqlParameter[8];


                objParameter[0] = new SqlParameter("@Company_ID", SqlDbType.Int);
                objParameter[0].Direction = ParameterDirection.InputOutput;
                objParameter[0].Value = Company_ID;

                objParameter[1] = new SqlParameter("@Company_Name", SqlDbType.Char);
                objParameter[1].Value = Company_Name;

                objParameter[2] = new SqlParameter("@ContactP", SqlDbType.Char);
                objParameter[2].Value = ContactP;

                objParameter[3] = new SqlParameter("@Tel", SqlDbType.Char);
                objParameter[3].Value = Contact_Tel;

                objParameter[4] = new SqlParameter("@Email", SqlDbType.Char);
                objParameter[4].Value = Email;

                objParameter[5] = new SqlParameter("@UserName", SqlDbType.Char);
                objParameter[5].Value = UserName;

                objParameter[6] = new SqlParameter("@Password", SqlDbType.Char);
                objParameter[6].Value = Password;

                objParameter[7] = new SqlParameter("@Userid", SqlDbType.UniqueIdentifier);
                objParameter[7].Value = userid;

                SqlHelper.ExecuteScalar(_cnnString, CommandType.StoredProcedure, "usp_Insert_Register_Company_Master", objParameter);
                //ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Insert_Register_Company_Master", objParameter);

                Company_ID = Convert.ToInt32(objParameter[0].Value);

                //string sql = "select * from tbl_company_Master where UserID='" + userid + "'";
                //ds = SqlHelper.ExecuteDataset(_cnnString, CommandType.Text, sql);

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

                SqlParameter[] objParameter = new SqlParameter[4];

                //objParameter[0] = new SqlParameter("@Role_ID", Role_ID);
                
                //objParameter[1] = new SqlParameter("@Role_Name", Role_Name);
               
                //objParameter[2] = new SqlParameter("@Company_ID", Company_ID);
               
                //objParameter[3] = new SqlParameter("@Userid", userid);


                objParameter[0] = new SqlParameter("@Role_ID", SqlDbType.UniqueIdentifier);
                objParameter[0].Direction = ParameterDirection.InputOutput;
                objParameter[0].Value = Role_ID;

                objParameter[1] = new SqlParameter("@Role_Name", SqlDbType.Char);
                objParameter[1].Value = Role_Name;


                objParameter[2] = new SqlParameter("@Company_ID", SqlDbType.Int);
                objParameter[2].Value = Company_ID;


                objParameter[3] = new SqlParameter("@Userid", SqlDbType.UniqueIdentifier);
                objParameter[3].Value = userid;

                SqlHelper.ExecuteScalar(_cnnString, "usp_Insert_Company_RoleMapping", objParameter);

                //Role_ID =new Guid(objParameter[0].Value.ToString());

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

                SqlParameter[] objParameter = new SqlParameter[1];


                objParameter[0] = new SqlParameter("@Role_Name", Role_Name);
                

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_GetRoleId", objParameter);

                //Role_ID = new Guid(objParameter[0].Value.ToString());

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

                SqlParameter[] objParameter = new SqlParameter[2];



                objParameter[0] = new SqlParameter("@Company_ID", SqlDbType.Char);
                objParameter[0].Value = Company_ID;


                objParameter[1] = new SqlParameter("@Userid", SqlDbType.UniqueIdentifier);
                objParameter[1].Value = userid;

                ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Insert_Admin_Company_Mapping", objParameter);

                //Role_ID = new Guid(objParameter[0].Value.ToString());

            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }


        //public DataSet Update_Company_Master()
        //{
        //    DataSet ds = new DataSet();

        //    try
        //    {
        //        SqlParameter[] objSqlParameter = new SqlParameter[5];

        //        objSqlParameter[0] = new SqlParameter("@Bank_ID", _Bank_ID);
        //        objSqlParameter[1] = new SqlParameter("@Bank_Name", _Bank_Name);
        //        objSqlParameter[2] = new SqlParameter("@Bank_Branch", _Bank_Branch);
        //        objSqlParameter[3] = new SqlParameter("@Bsrcode", _Bsrcode);
        //        objSqlParameter[4] = new SqlParameter("@Company_ID", _Company_ID);

        //        ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Update_Bank_Master", objSqlParameter);


        //    }
        //    catch (Exception)
        //    {

        //        throw;
        //    }
        //    return ds;
        //}

        //public DataSet Delete_Company_Master()
        //{
        //    DataSet ds = new DataSet();
        //    try
        //    {
        //        SqlParameter[] objSqlParameter = new SqlParameter[1];

        //        objSqlParameter[0] = new SqlParameter("@Bank_ID", _Bank_ID);

        //        ds = SqlHelper.ExecuteDataset(_cnnString, "usp_Delete_Bank_Master", objSqlParameter);
        //    }
        //    catch (Exception)
        //    {

        //        throw;
        //    }
        //    return ds;
        //}

    }
}
