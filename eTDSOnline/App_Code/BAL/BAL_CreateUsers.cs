using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;
using System.Data;

namespace BusinessLayer
{
    public class BAL_CreateUsers
    {
        DAL_CreateUsers objDAL_CreateUsers = new DAL_CreateUsers();
        DataSet ds;

        public int ParentCompany { get; set; }

        public DataSet BAL_GetCompanyNamesCreateUser()
        {
            try
            {
                objDAL_CreateUsers.ParentCompany = ParentCompany;
                ds = objDAL_CreateUsers.DAL_GetCompanyNamesCreateUser();
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
