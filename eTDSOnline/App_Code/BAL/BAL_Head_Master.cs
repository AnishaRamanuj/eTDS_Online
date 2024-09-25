using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_Head_Master
    {
        DAL_Head_Master objDAL_HeadMaster = new DAL_Head_Master();

        public int _Head_ID { get; set; }
        public string _Head_Name { get; set; }
        public string _Head_Group { get; set; }
        public bool _Mth1 { get; set; }
        public bool _Mth2 { get; set; }
        public bool _Mth3 { get; set; }
        public bool _Mth4 { get; set; }
        public bool _Mth5 { get; set; }
        public bool _Mth6 { get; set; }
        public bool _Mth7 { get; set; }
        public bool _Mth8 { get; set; }
        public bool _Mth9 { get; set; }
        public bool _Mth10 { get; set; }
        public bool _Mth11 { get; set; }
        public bool _Mth12 { get; set; }
        public bool _Section10 { get; set; }
        public bool _Conveyance_Type { get; set; }
        public int _Rounding_Modes { get; set; }
        public string _Calc_Gross { get; set; }
        public double _Calc_Gross_Percentage { get; set; }
        public bool _Manual_Entry { get; set; }
        public int _Reports_Type { get; set; }
        public bool _Computation { get; set; }
        public bool _Projection { get; set; }
        public int _Company_ID { get; set; }
        public int _Head_Calculated_ID { get; set; }
        public int _Head_Type_ID { get; set; }

        public DataSet Get_Head_Master_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_HeadMaster._Head_ID = _Head_ID;
                ds = objDAL_HeadMaster.Get_Head_Master_Details();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_HeadType_List()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = objDAL_HeadMaster.Get_HeadType_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Head_Master_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_HeadMaster._Head_Group = _Head_Group;
                objDAL_HeadMaster._Company_ID = _Company_ID;
                objDAL_HeadMaster._Head_Calculated_ID = _Head_Calculated_ID;
                objDAL_HeadMaster._Calc_Gross = _Calc_Gross;

                ds = objDAL_HeadMaster.Get_Head_Master_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Head_Master_List_For_PT()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_HeadMaster._Head_Group = _Head_Group;
                ds = objDAL_HeadMaster.Get_Head_Master_List_For_PT();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Delete_Head_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_HeadMaster._Head_ID = _Head_ID;
                ds = objDAL_HeadMaster.Delete_Head_Master();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }


        public DataSet Check_with_Grade_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_HeadMaster._Head_ID = _Head_ID;
                ds = objDAL_HeadMaster.Check_with_Grade_Master();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }
        
        public DataSet Insert_Head_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_HeadMaster._Head_Name = _Head_Name;
                objDAL_HeadMaster._Head_Group = _Head_Group;
                objDAL_HeadMaster._Mth1 = _Mth1;
                objDAL_HeadMaster._Mth2 = _Mth2;
                objDAL_HeadMaster._Mth3 = _Mth3;
                objDAL_HeadMaster._Mth4 = _Mth4;
                objDAL_HeadMaster._Mth5 = _Mth5;
                objDAL_HeadMaster._Mth6 = _Mth6;
                objDAL_HeadMaster._Mth7 = _Mth7;
                objDAL_HeadMaster._Mth8 = _Mth8;
                objDAL_HeadMaster._Mth9 = _Mth9;
                objDAL_HeadMaster._Mth10 = _Mth10;
                objDAL_HeadMaster._Mth11 = _Mth11;
                objDAL_HeadMaster._Mth12 = _Mth12;
                objDAL_HeadMaster._Section10 = _Section10;
                objDAL_HeadMaster._Conveyance_Type = _Conveyance_Type;
                objDAL_HeadMaster._Rounding_Modes = _Rounding_Modes;
                objDAL_HeadMaster._Calc_Gross = _Calc_Gross;
                objDAL_HeadMaster._Calc_Gross_Percentage = _Calc_Gross_Percentage;
                objDAL_HeadMaster._Manual_Entry = _Manual_Entry;
                objDAL_HeadMaster._Reports_Type = _Reports_Type;
                objDAL_HeadMaster._Computation = _Computation;
                objDAL_HeadMaster._Projection = _Projection;
                objDAL_HeadMaster._Company_ID = _Company_ID;
                objDAL_HeadMaster._Head_Type_ID = _Head_Type_ID; 

                ds = objDAL_HeadMaster.Insert_Head_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }

        public DataSet Update_Head_Master()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_HeadMaster._Head_ID = _Head_ID;
                objDAL_HeadMaster._Head_Name = _Head_Name;
                objDAL_HeadMaster._Head_Group = _Head_Group;
                objDAL_HeadMaster._Mth1 = _Mth1;
                objDAL_HeadMaster._Mth2 = _Mth2;
                objDAL_HeadMaster._Mth3 = _Mth3;
                objDAL_HeadMaster._Mth4 = _Mth4;
                objDAL_HeadMaster._Mth5 = _Mth5;
                objDAL_HeadMaster._Mth6 = _Mth6;
                objDAL_HeadMaster._Mth7 = _Mth7;
                objDAL_HeadMaster._Mth8 = _Mth8;
                objDAL_HeadMaster._Mth9 = _Mth9;
                objDAL_HeadMaster._Mth10 = _Mth10;
                objDAL_HeadMaster._Mth11 = _Mth11;
                objDAL_HeadMaster._Mth12 = _Mth12;
                objDAL_HeadMaster._Section10 = _Section10;
                objDAL_HeadMaster._Head_Type_ID = _Head_Type_ID;
                objDAL_HeadMaster._Conveyance_Type = _Conveyance_Type;
                objDAL_HeadMaster._Rounding_Modes = _Rounding_Modes;
                objDAL_HeadMaster._Calc_Gross = _Calc_Gross;
                objDAL_HeadMaster._Calc_Gross_Percentage = _Calc_Gross_Percentage;
                objDAL_HeadMaster._Manual_Entry = _Manual_Entry;
                objDAL_HeadMaster._Reports_Type = _Reports_Type;
                objDAL_HeadMaster._Computation = _Computation;
                objDAL_HeadMaster._Projection = _Projection;
                objDAL_HeadMaster._Company_ID = _Company_ID;
                //objDAL_HeadMaster._Head_Calculated_ID = _Head_Calculated_ID;   

                ds = objDAL_HeadMaster.Update_Head_Master();
            }
            catch (Exception)
            {
                throw;
            }
            return ds;
        }
    }
}
