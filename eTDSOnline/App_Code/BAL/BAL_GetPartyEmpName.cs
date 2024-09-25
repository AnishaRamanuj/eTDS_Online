using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;
using CommonLibrary;
using System.Data.SqlClient;
using System.Globalization;

namespace BusinessLayer
{
    public class BAL_GetPartyEmpName : CommonFunctions
    {
        DAL_GetPartyEmpName obj_GetPartyEmpName = new DAL_GetPartyEmpName();

        public IEnumerable<PartyEmpName> Get_PartyEmpName(objPartyEmpName cobj)
        {
            List<PartyEmpName> PartyEmpName = new List<PartyEmpName>();
            using (SqlDataReader drrr = obj_GetPartyEmpName.DAL_getPartyEmp_Name(cobj))
            {
                while (drrr.Read())
                {
                    PartyEmpName.Add(new PartyEmpName()
                    {
                        DeducteeID = GetValue<int>(drrr["Deductee_ID"].ToString()),
                        Deductee_Name = GetValue<string>(drrr["Deductee_Name"].ToString()),
                        //PANNO = GetValue<string>(drrr["PAN_NO"].ToString()),
                        //FirstName = GetValue<string>(drrr["FirstName"].ToString()),
                        //EmployeeID = GetValue<int>(drrr["Employee_ID"].ToString())
                    });
                }
            }
            return PartyEmpName as IEnumerable<PartyEmpName>;
        }

        public IEnumerable<PartyEmpName> Get_EmpName(objPartyEmpName cobj)
        {
            List<PartyEmpName> EmpName = new List<PartyEmpName>();
            using (SqlDataReader drrr = obj_GetPartyEmpName.DAL_geEmp_Name(cobj))
            {
                while (drrr.Read())
                {
                    EmpName.Add(new PartyEmpName()
                    {
                       // PANNO = GetValue<string>(drrr["PAN_NO"].ToString()),
                        FirstName = GetValue<string>(drrr["FirstName"].ToString()),
                        EmployeeID = GetValue<int>(drrr["Employee_ID"].ToString()),
                    });
                }
            }
            return EmpName as IEnumerable<PartyEmpName>;
        }
    }

}
