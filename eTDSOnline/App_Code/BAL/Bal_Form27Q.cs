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
  public  class Bal_Form27Q : CommonFunctions
    {

        Dal_Form27Q obj_Dal_Form27Q = new Dal_Form27Q();

        public IEnumerable<objChallanDetails_27Q> Get_Challan_Detail(objChallanDetails_27Q obj)
        {
            List<objChallanDetails_27Q> ChallanDetails = new List<objChallanDetails_27Q>();
            using (SqlDataReader drrr = obj_Dal_Form27Q.DAL_getChallanDetails(obj))
            {
                while (drrr.Read())
                {
                    ChallanDetails.Add(new objChallanDetails_27Q()
                    {
                        ChallanDetails = GetValue<string>(drrr["ChallanDetails"].ToString()),
                        ChallanID = GetValue<int>(drrr["Challan_ID"].ToString()),
                    });
                }
            }
            return ChallanDetails as IEnumerable<objChallanDetails_27Q>;
        }
    }
}
