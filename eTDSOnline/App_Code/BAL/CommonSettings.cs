using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI.WebControls;
using System.Data;
using System.Globalization;
using System.IO;
using System.Net.Mail;
using System.Net;

namespace BusinessLayer
{
    public sealed class CommonSettings
    {
        public static void LoadCombo(DropDownList ComboToFill, DataTable dtSource, string DisplayMember, string ValueMember, bool AddSelect)
        {
            CommonSettings.LoadCombo(ComboToFill, dtSource, DisplayMember, ValueMember, AddSelect, "(Select)");
        }

        public static void LoadCombo(DropDownList ComboToFill, DataTable dtSource, string DisplayMember, string ValueMember, bool AddSelect, string SelectString)
        {
            ComboToFill.SelectedIndex = -1;
            ComboToFill.Items.Clear();

            ComboToFill.DataValueField = ValueMember;
            ComboToFill.DataTextField = DisplayMember;
            ComboToFill.DataSource = dtSource;
            ComboToFill.DataBind();

            if (AddSelect)
            {
                ListItem item = new ListItem(SelectString, string.Empty);
                ComboToFill.Items.Insert(0, item);
            }
        }

        public static DateTime ConvertToCulturedDateTime(object value)
        {
            try
            {
                DateTimeFormatInfo objDateTimeFormatInfo = new DateTimeFormatInfo();
                objDateTimeFormatInfo.ShortDatePattern = "dd/MM/yyyy";

                return Convert.ToDateTime(value, objDateTimeFormatInfo);
            }
            catch (Exception)
            {
                return DateTime.MinValue;
            }
        }

        public static string DateFormat()
        {
            return "dd/MM/yyyy";
        }

        public static DateTime GetMinDateTime()
        {
            try
            {
                DateTime dt = new DateTime(1900, 01, 01);

                return Convert.ToDateTime(dt);
            }
            catch (Exception)
            {
                return DateTime.MinValue;
            }
        }

        public static string RemoveLastCharacter(string str)
        {
            string ReturnString = str.Remove(str.Length - 1, 1);
            return ReturnString;
        }

        public static bool IsMinDateTime(DateTime dtDate)
        {
            try
            {
                if (dtDate == CommonSettings.GetMinDateTime())
                    return true;

                return false;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static string GetItemFolderPhysicalPath(int Employee_ID)
        {
            string strFolderPath = Path.Combine("~/EmployeeImage/", Employee_ID.ToString()).Replace("/", "\\");
            if (!Directory.Exists(strFolderPath))
                Directory.CreateDirectory(strFolderPath);

            return strFolderPath;
        }


        public static string SendEmial(string SMTP_Server, int SMTP_Port, bool SSL, string SMTP_Authenticate, string SMTP_User_Name, string User_Password, string strSubject, string ToEmailID, string strBody)
        {
            try
            {
                MailMessage objMailMessage = new MailMessage(SMTP_User_Name, ToEmailID);
                objMailMessage.Subject = strSubject;
                objMailMessage.Body = strBody;
                //if (fuAttachment.HasFile)
                //{
                //    string FileName = Path.GetFileName(fuAttachment.PostedFile.FileName);
                //    mm.Attachments.Add(new Attachment(fuAttachment.PostedFile.InputStream, FileName));
                //}
                objMailMessage.IsBodyHtml = true;
                SmtpClient objSmtpClient = new SmtpClient();
                objSmtpClient.Host = SMTP_Server;
                objSmtpClient.Port = SMTP_Port;
                objSmtpClient.EnableSsl = SSL;
                NetworkCredential NetworkCred = new NetworkCredential(SMTP_User_Name, User_Password);
                objSmtpClient.UseDefaultCredentials = true;
                objSmtpClient.Credentials = NetworkCred;
                objSmtpClient.Send(objMailMessage);

                //MailMessage objMailMessage = new MailMessage();
                //objMailMessage.From = new MailAddress(SMTP_User_Name);
                //objMailMessage.To.Add(ToEmail);
                //objMailMessage.Subject = Subject;
                //objMailMessage.Body = Comment;
                //objMailMessage.IsBodyHtml = true;

                //SmtpClient objSmtpClient = new SmtpClient(SMTP_Server, SMTP_Port);
                //objSmtpClient.Credentials = new System.Net.NetworkCredential(SMTP_User_Name, User_Password);

                //objSmtpClient.Send(objMailMessage);
                //objMailMessage.Dispose();

                return "Done"; // if Success

            }
            catch (Exception ex)
            {
                return ex.Message; // if Error
            }
        }
    }
}
