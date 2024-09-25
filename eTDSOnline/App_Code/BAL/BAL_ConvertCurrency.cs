using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI.WebControls;
using System.Data;
using System.Globalization;
using System.IO;

namespace BusinessLayer
{
    public sealed class BAL_ConvertCurrency
    {
        #region FunctionToConvertAmountToWord
        public string _Crores { get; set; }
        public string _Lacs { get; set; }
        public string _Thousand { get; set; }
        public string _Hundred { get; set; }
        public string _Tens { get; set; }
        public string _Units { get; set; }

        public string RupeeInWords(double value)
        {
            return Towords(value) + " Only";
        }
        private string Towords(double Num)
        {
            string stmp = ""; 
            string pointVlu = "";
            string[] sVlu = Convert.ToString(Num).Split('.');

            stmp = getInWord(Convert.ToInt32(sVlu[0]));
            if (sVlu.Length > 1) pointVlu = getInWord(Convert.ToInt32(sVlu[1]));

            if (!pointVlu.Equals(""))
            {
                if (stmp.Equals(""))
                    stmp = "Zero ";
                stmp += " and " + pointVlu + " Paisa";
            }
            return stmp.Trim();
        }
        string getInWord(int Num)
        {
            string stmp = ""; int i, leng, prevdigit = 0, digit = 0, pos = 0;
            string snum = "", laststr = "", rt ="", cr="";
            snum = Convert.ToString(Num);

            leng = snum.Length;

            #region Loop Process
            for (i = leng; i > 0; i--)
            {
                if (snum.Substring(i - 1, 1) == "-")
                {
                    continue;
                }
                digit = Convert.ToInt32(snum.Substring(i - 1, 1));
                pos = leng - i + 1;

                //'1 units
                //'3 hundreds
                //'4 thousands
                //'6 lakhs
                //'8 crores
                //'10 hundred crores
                //'11 thousand crores
                //'13 lakh crores
                //'15 crore crores
                //'sub groups
                //'1,8,15
                //'3,10
                //'4,11
                //'6,13
                switch (pos)
                {
                    case 1:
                    case 3:
                    case 4:
                    case 6:
                    case 8:
                   
                    case 10:
                    case 11:
                    case 13:
                    case 15:
                    case 16:

                        {
                            if (digit != 0)
                            {
                                //21151465
                                switch (pos)
                                {
                                    case 8:
                                    case 15:
                                        cr = "1";
                                        laststr = "Crore ";
                                        _Lacs  = rt;
                                        rt = "";
                                        break;
                                    case 6:
                                    case 13:
                                        laststr = "Lakh ";
                                        _Thousand = rt;
                                        rt = "";
                                        break;
                                    case 4:
                                    case 11:
                                        laststr = "Thousand ";
                                        _Hundred  = rt;
                                        rt = "";
                                        break;
                                    case 3:
                                    case 10:
                                        laststr = "Hundred ";
                                        _Tens  = rt;
                                        rt = "";
                                        break;
                                    case 2:
                                    case 16:
                                        laststr = "Tens ";
                                        _Units = rt;
                                        rt = "";
                                        break;

                                }

                                stmp = laststr + stmp;
                            }

                            switch (digit)
                            {
                                case 0:
                                    if (pos == 1)
                                        laststr = "Zero ";
                                    else
                                        laststr = "";
                                    break;
                                case 1:
                                    laststr = "One ";
                                    break;

                                case 2:
                                    laststr = "Two ";
                                    break;

                                case 3:
                                    laststr = "Three ";
                                    break;

                                case 4:
                                    laststr = "Four ";
                                    break;

                                case 5:
                                    laststr = "Five ";
                                    break;

                                case 6:
                                    laststr = "Six ";
                                    break;

                                case 7:
                                    laststr = "Seven ";
                                    break;

                                case 8:
                                    laststr = "Eight ";
                                    break;

                                case 9:
                                    laststr = "Nine ";
                                    break;

                            }
                            rt = laststr + rt;
                            stmp = laststr + stmp;
                        } break;
                    case 2:
                    case 5:
                    case 7:
                    case 9:
                    case 12:
                    case 14:
                        //'2 tens
                        //'5 ten thousands
                        //'7 ten lakhs
                        //'9 ten crore
                        //'12 ten thousand crore
                        //'14 ten lakh crores
                        {
                            if (prevdigit == 0)
                            {
                                switch (pos)
                                {
                                    case 9:
                                        laststr = "Crore ";
                                        break;
                                    case 7:
                                    case 14:
                                        if (digit != 0) laststr = "Lakh "; break;
                                    case 5:
                                    case 12:
                                        if (digit != 0) laststr = "Thousand "; break;
                                }
                                stmp = laststr + stmp;
                            }

                            switch (digit)
                            {
                                case 0:
                                    if (prevdigit != 0)
                                        laststr = "And ";
                                    else
                                        laststr = "";
                                    break;
                                case 1:
                                    switch (prevdigit)
                                    {
                                        case 0:
                                            laststr = "Ten ";
                                            break;
                                        case 1:
                                            stmp = "Eleven " + stmp.Substring(4);
                                            break;
                                        case 2:
                                            stmp = "Twelve " + stmp.Substring(4);
                                            //stmp = stmp.Replace("Two ", "Twelve ");
                                            break;
                                        case 3:
                                            stmp = "Thirteen " + stmp.Substring(6);
                                            //stmp = stmp.Replace("Three ", "Thirteen ");
                                            break;
                                        case 4:
                                            stmp = "Fourteen " + stmp.Substring(5);
                                            /// stmp = stmp.Replace("Four ", "Fourteen ");
                                            break;
                                        case 5:
                                            stmp = "Fifteen " + stmp.Substring(5);
                                            //stmp = stmp.Replace("Five ", "Fifteen ");
                                            break;
                                        case 6:
                                            stmp = "Sixteen " + stmp.Substring(4);
                                            //stmp = stmp.Replace("Six ", "Sixteen ");
                                            break;
                                        case 7:
                                            stmp = "Seventeen " + stmp.Substring(6);
                                            //stmp = stmp.Replace("Seven ", "Seventeen ");
                                            break;
                                        case 8:
                                            stmp = "Eighteen " + stmp.Substring(6);
                                            //stmp = stmp.Replace("Eight ", "Eighteen ");
                                            break;
                                        case 9:
                                            stmp = "Nineteen " + stmp.Substring(5);
                                            //stmp = stmp.Replace("Nine ", "Nineteen ");
                                            break;

                                    } break;
                                case 2:
                                    laststr = "Twenty "; break;
                                case 3:
                                    laststr = "Thirty "; break;
                                case 4:
                                    laststr = "Forty "; break;
                                case 5:
                                    laststr = "Fifty "; break;
                                case 6:
                                    laststr = "Sixty "; break;
                                case 7:
                                    laststr = "Seventy "; break;
                                case 8:
                                    laststr = "Eighty "; break;
                                case 9:
                                    laststr = "Ninty "; break;
                            }
                            //'if stmp contains "Zero " at the end, remove it
                            //if InStr(stmp, "Zero ") <> 0 Then stmp = Replace(stmp, "Zero ", "")
                            stmp = stmp.Replace("Zero ", "");
                            rt =  laststr + rt ;
                            stmp = laststr + stmp;
                        } break;
                }
                prevdigit = digit;
                laststr = "";
            }
            #endregion



            return stmp.Trim();
        }

        #endregion
    }
}