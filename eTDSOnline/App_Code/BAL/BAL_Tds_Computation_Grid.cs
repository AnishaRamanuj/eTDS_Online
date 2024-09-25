using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataLayer;

namespace BusinessLayer
{
    public class BAL_Tds_Computation_Grid
    {
        DAL_Tds_Computation_Grid objDAL_Tds_Computation_Grid = new DAL_Tds_Computation_Grid();

        public int _Grid_ID { get; set; }
        public string _Grid_Names { get; set; }
        public double _Grid_Val1 { get; set; }
        public double _Grid_Val2 { get; set; }
        public double _Grid_Val3 { get; set; }
        public bool _Colaspable { get; set; }
        public bool _Editable { get; set; }

        public int _Employee_ID { get; set; }
        public int _Company_ID { get; set; }

        public DataSet Get_Tds_Computation_Grid_List()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Tds_Computation_Grid._Grid_Names = _Grid_Names;
                objDAL_Tds_Computation_Grid._Colaspable = _Colaspable;
                objDAL_Tds_Computation_Grid._Editable = _Editable;

                ds = objDAL_Tds_Computation_Grid.Get_Tds_Computation_Grid_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Tds_Computation_Grid_Details()
        {
            DataSet ds = new DataSet();
            try
            {
                objDAL_Tds_Computation_Grid._Grid_ID = _Grid_ID;
                
                ds = objDAL_Tds_Computation_Grid.Get_Tds_Computation_Grid_Details();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Update_Tds_Computation_Grid()
        {
            DataSet ds = new DataSet();

            try
            {
                objDAL_Tds_Computation_Grid._Grid_ID = _Grid_ID;
                objDAL_Tds_Computation_Grid._Grid_Names = _Grid_Names;
                objDAL_Tds_Computation_Grid._Grid_Val1 = _Grid_Val1;
                objDAL_Tds_Computation_Grid._Grid_Val2 = _Grid_Val2;
                objDAL_Tds_Computation_Grid._Grid_Val3 = _Grid_Val3;
                objDAL_Tds_Computation_Grid._Colaspable = _Colaspable;
                objDAL_Tds_Computation_Grid._Editable = _Editable;

                ds = objDAL_Tds_Computation_Grid.Update_Tds_Computation_Grid();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public DataSet Get_Employee_ProfessionTax_List()
        {
            DataSet ds = new DataSet();

            try
            {
                objDAL_Tds_Computation_Grid._Employee_ID = _Employee_ID;
                objDAL_Tds_Computation_Grid._Company_ID = _Company_ID;

                ds = objDAL_Tds_Computation_Grid.Get_Employee_ProfessionTax_List();
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }
    }
}
