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
   public class Bal_Form26Q : CommonFunctions
    {
      
        Dal_Form26Q objDa_Dal_Form26Q = new Dal_Form26Q();

        public IEnumerable<ChallanDatenamt> Get_Challan_Amt(objChallanDatenamt cobj)
        {
            List<ChallanDatenamt> ChallannDatenamt = new List<ChallanDatenamt>();
            using (SqlDataReader drrr = objDa_Dal_Form26Q.DAL_getChallan_Amount(cobj))
            {
                while (drrr.Read())
                {
                    ChallannDatenamt.Add(new ChallanDatenamt()
                    {
                        ChallanDetails = GetValue<string>(drrr["ChallanDetails"].ToString()),
                        ChallanID = GetValue<int>(drrr["Challan_ID"].ToString()),
                        //ischecked = GetValue<string>(drrr["ischecked"].ToString()),
                    });
                }
            }
            return ChallannDatenamt as IEnumerable<ChallanDatenamt>;
        }
    }
}
