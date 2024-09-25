using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

using CommonLibrary;
using System.Data.SqlClient;

namespace BusinessLayer
{
    public class BAL_State_Master : CommonFunctions
    {
        DAL_State_Master objDAL_State_Master = new DAL_State_Master();

        public int _State_ID { get; set; }
        public string _State_Name { get; set; }

        public DataSet Get_State_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = objDAL_State_Master.Get_State_Master_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public IEnumerable<tbl_State> Get_State_List()
        {
            List<tbl_State> Ltbl_State = new List<tbl_State>();
            using (SqlDataReader drrr = objDAL_State_Master.DAL_getState())
            {
                while (drrr.Read())
                {
                    Ltbl_State.Add(new tbl_State()
                    {
                        State_Id = GetValue<int>(drrr["State_ID"].ToString()),
                        StateName = GetValue<string>(drrr["State_Name"].ToString())

                    });
                }
            }
            return Ltbl_State as IEnumerable<tbl_State>;
        }
    }
}
