using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_Challan
    {
        DAL_Challan objDAL_Challan = new DAL_Challan();

        public int _Challan_ID { get; set; }
        public int _Company_ID { get; set; }
        public DateTime _Challan_Date { get; set; }
        public int _Bank_ID { get; set; }
        public string _Bank_Bsrcode { get; set; }
        public int _Cheque_no { get; set; }
        public DateTime _Cheque_Date { get; set; }
        public string _Quater { get; set; }
        public double _TDS_Amount { get; set; }
        public double _Surcharge { get; set; }
        public double _Education_Cess { get; set; }
        public double _High_Education_Cess { get; set; }
        public double _Interest_Amt { get; set; }
        public double _Fees_Amount { get; set; }
        public double _Others_Amount { get; set; }
        public double _Challan_Amount { get; set; }
        public string _Challan_No { get; set; }
        public string _Trans_No { get; set; }
        public string _C_Entry { get; set; }
        public bool _Nil_Challan { get; set; }

        int result = 0;

        public int Insert_Challan()
        {
           
            try
            {
                objDAL_Challan._Company_ID = _Company_ID;
                objDAL_Challan._Challan_Date = _Challan_Date;
                objDAL_Challan._Bank_ID = _Bank_ID;
                objDAL_Challan._Bank_Bsrcode = _Bank_Bsrcode;
                objDAL_Challan._Cheque_no = _Cheque_no;
                objDAL_Challan._Cheque_Date = _Cheque_Date;
                objDAL_Challan._Quater = _Quater;
                objDAL_Challan._TDS_Amount = _TDS_Amount;
                objDAL_Challan._Surcharge = _Surcharge;
                objDAL_Challan._Education_Cess = _Education_Cess;
                objDAL_Challan._High_Education_Cess = _High_Education_Cess;
                objDAL_Challan._Interest_Amt = _Interest_Amt;
                objDAL_Challan._Fees_Amount = _Fees_Amount;
                objDAL_Challan._Others_Amount = _Others_Amount;
                objDAL_Challan._Challan_Amount = _Challan_Amount;
                objDAL_Challan._Challan_No = _Challan_No;
                objDAL_Challan._Trans_No = _Trans_No;
                objDAL_Challan._C_Entry = _C_Entry;
                objDAL_Challan._Nil_Challan = _Nil_Challan;
                objDAL_Challan.ChallanDatatable = ChallanDatatable;
                objDAL_Challan.ChallanType = ChallanType;
                result = objDAL_Challan.Insert_Challan();
            }
            catch (Exception)
            {
                throw;
            }
            return result;
        }

        public DataSet Update_Challan()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Challan._Challan_ID = _Challan_ID;
                objDAL_Challan._Company_ID = _Company_ID;
                objDAL_Challan._Challan_Date = _Challan_Date;
                objDAL_Challan._Bank_ID = _Bank_ID;
                objDAL_Challan._Bank_Bsrcode = _Bank_Bsrcode;
                objDAL_Challan._Cheque_no = _Cheque_no;
                objDAL_Challan._Cheque_Date = _Cheque_Date;
                objDAL_Challan._Quater = _Quater;
                objDAL_Challan._TDS_Amount = _TDS_Amount;
                objDAL_Challan._Surcharge = _Surcharge;
                objDAL_Challan._Education_Cess = _Education_Cess;
                objDAL_Challan._High_Education_Cess = _High_Education_Cess;
                objDAL_Challan._Interest_Amt = _Interest_Amt;
                objDAL_Challan._Fees_Amount = _Fees_Amount;
                objDAL_Challan._Others_Amount = _Others_Amount;
                objDAL_Challan._Challan_Amount = _Challan_Amount;
                objDAL_Challan._Challan_No = _Challan_No;
                objDAL_Challan._Trans_No = _Trans_No;
                objDAL_Challan._C_Entry = _C_Entry;
                objDAL_Challan._Nil_Challan = _Nil_Challan;
                objDAL_Challan.ChallanType = ChallanType;
                ds = objDAL_Challan.Update_Challan();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Challan()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Challan._Challan_ID = _Challan_ID;
                ds = objDAL_Challan.Delete_Challan();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Challan_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Challan._Challan_ID = _Challan_ID;
                ds = objDAL_Challan.Get_Challan_Details();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Challan_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Challan._Company_ID = _Company_ID;
                objDAL_Challan._Bank_ID = _Bank_ID;
                objDAL_Challan._Challan_No = _Challan_No;
                objDAL_Challan._Trans_No = _Trans_No;

                ds = objDAL_Challan.Get_Challan_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataTable ChallanDatatable { get; set; }

        public string ChallanType { get; set; }

        public DataSet BAl_EditMode()
        {
            DataSet ds;
            try
            {
                objDAL_Challan._Challan_ID=_Challan_ID;
                objDAL_Challan._Company_ID = _Company_ID;
                ds = objDAL_Challan.DAl_EditMode();
                return ds;
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }


        public int BAL_DeleteChallanOld()
        {
            try
            {
                objDAL_Challan._Challan_ID = _Challan_ID;
                result = objDAL_Challan.DAL_DeleteChallanOld();
                return result;
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }
    }
}
