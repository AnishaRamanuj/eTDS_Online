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
  public  class Bal_Correction : CommonFunctions
    {
        Dal_Correction obj_Dal_Correction = new Dal_Correction();

        public IEnumerable<objforCorrection> Get_Deductee(objforCorrection cobj)
        {
            List<objforCorrection> Deductee = new List<objforCorrection>();
            using (SqlDataReader drrr = obj_Dal_Correction.DAL_getDedcutee(cobj))
            {
                while (drrr.Read())
                {
                    Deductee.Add(new objforCorrection()
                    {
                        NAME = GetValue<string>(drrr["NAME"].ToString()),
                        id = GetValue<int>(drrr["id"].ToString()),                        
                    });
                }
            }
            return Deductee as IEnumerable<objforCorrection>;
        }

        public IEnumerable<objforCorrection> Get_Correction(objforCorrection cobj)
        {
            List<objforCorrection> Deductee = new List<objforCorrection>();
            using (SqlDataReader drrr = obj_Dal_Correction.DAL_getCorrection(cobj))
            {
                while (drrr.Read())
                {
                    Deductee.Add(new objforCorrection()
                    {
                        Srno = GetValue<int>(drrr["Srno"].ToString()),
                        id = GetValue<int>(drrr["Id"].ToString()),
                        Voucher_DT = GetValue<string>(drrr["Voucher_DT"].ToString()),
                        Amount = GetValue<string>(drrr["Amount"].ToString()),
                        TDS = GetValue<string>(drrr["TDS"].ToString()),
                        PAN_No = GetValue<string>(drrr["PAN_No"].ToString()),
                        Tds_Certificate = GetValue<string>(drrr["Tds_Certificate"].ToString()),
                        Reason = GetValue<string>(drrr["Reason"].ToString()),
                        REMITTANCE_Id = GetValue<int>(drrr["REMITTANCE_id"].ToString()),
                    });
                }
                List<objforCorrection_Remiitance> Rem = new List<objforCorrection_Remiitance>();
                if (drrr.NextResult())
                {
                    while (drrr.Read())
                    {
                        Rem.Add(new objforCorrection_Remiitance()
                        {
                            remittance = GetValue<string>(drrr["REMITTANCE"].ToString()),
                            rcode = GetValue<int>(drrr["RCode"].ToString()),
                        });

                    }
                }
                foreach (var item in Deductee)
                {
                    item.list_Correction_Remiitance = Rem;
                 }
            }

            return Deductee as IEnumerable<objforCorrection>;
        }


        public IEnumerable<objforCorrection> Get_Correction_Update(objforCorrection cobj)
        {
            List<objforCorrection> Deductee = new List<objforCorrection>();
            using (SqlDataReader drrr = obj_Dal_Correction.DAL_UpadteCorrection(cobj))
            {
                while (drrr.Read())
                {
                    Deductee.Add(new objforCorrection()
                    {
                        id = GetValue<int>(drrr["id"].ToString()),
                    });
                }
            }
            return Deductee as IEnumerable<objforCorrection>;
        }
    }
}
