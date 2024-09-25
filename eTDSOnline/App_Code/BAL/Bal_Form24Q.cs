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
   public class Bal_Form24Q : CommonFunctions
    {
        Dal_Form24Q obj_Dal_Form24Q = new Dal_Form24Q();

        public IEnumerable<objChallanDetails_24Q> Get_Challan_Detail(objChallanDetails_24Q obj)
        {
            List<objChallanDetails_24Q> ChallanDetails = new List<objChallanDetails_24Q>();
            using (SqlDataReader drrr = obj_Dal_Form24Q.DAL_getChallanDetails(obj))
            {
                while (drrr.Read())
                {
                    ChallanDetails.Add(new objChallanDetails_24Q()
                    {
                        ChallanDetails = GetValue<string>(drrr["ChallanDetails"].ToString()),
                        ChallanID = GetValue<int>(drrr["ChallanID"].ToString()),
                    });
                }
            }
            return ChallanDetails as IEnumerable<objChallanDetails_24Q>;
        }       
    }
}
