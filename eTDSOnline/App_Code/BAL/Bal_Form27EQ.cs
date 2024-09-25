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
    public class Bal_Form27EQ : CommonFunctions
    {
        Dal_Form27EQ obj_Dal_Form27EQ = new Dal_Form27EQ();

        public IEnumerable<objChallanDetails> Get_Challan_Detail(objChallanDetails obj)
        {
            List<objChallanDetails> ChallanDetails = new List<objChallanDetails>();
            using (SqlDataReader drrr = obj_Dal_Form27EQ.DAL_getChallanDetails(obj))
            {
                while (drrr.Read())
                {
                    ChallanDetails.Add(new objChallanDetails()
                    {
                        ChallanDetails = GetValue<string>(drrr["ChallanDetails"].ToString()),
                        ChallanID = GetValue<int>(drrr["Challan_ID"].ToString()),
                    });
                }
            }
            return ChallanDetails as IEnumerable<objChallanDetails>;
        }
    }
}





