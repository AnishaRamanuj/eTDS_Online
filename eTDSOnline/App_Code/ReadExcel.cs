using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.IO;
using Excel;

/// <summary>
/// Summary description for ReadExcel
/// </summary>
namespace PayrollProject
{
    public partial class ReadExcel
    {
        DataSet result = new DataSet();



        public string ConvertnRead(string xlFile)
        {
            if (xlFile.EndsWith(".xlsx"))
            {

                // Reading from a binary Excel file (format; *.xlsx)
                FileStream stream = File.Open(xlFile, FileMode.Open, FileAccess.Read);

                IExcelDataReader excelReader = ExcelReaderFactory.CreateOpenXmlReader(stream);
                result = excelReader.AsDataSet();
                excelReader.Close();
            }

            if (xlFile.EndsWith(".xls"))
            {
                // Reading from a binary Excel file ('97-2003 format; *.xls)
                FileStream stream = File.Open(xlFile, FileMode.Open, FileAccess.Read);
                IExcelDataReader excelReader = ExcelReaderFactory.CreateBinaryReader(stream);
                result = excelReader.AsDataSet();
                excelReader.Close();
            }
            string ss = "";
            List<string> items = new List<string>();
            for (int i = 0; i < result.Tables.Count; i++)
            {
                items.Add(result.Tables[i].TableName.ToString());
                ss = result.Tables[i].TableName.ToString();

            }

            string a = "";
            int row_no = 0;
            //string ss = result.Tables[ind].TableName.ToString();
            while (row_no < result.Tables[ss].Rows.Count)
            {
                if (row_no >= 5)
                {
                    for (int i = 0; i < result.Tables[ss].Columns.Count; i++)
                    {
                        if (i == 1 )
                        {
                            a += result.Tables[ss].Rows[row_no][i].ToString() + ",";
                        }
                        if (i == 5)
                        {
                            a += result.Tables[ss].Rows[row_no][i].ToString() + "^";
                        }
                    }
                }
                row_no++;
            }

            return a;
        }

    }
}