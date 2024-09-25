using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net.Mail;
using System.Net.Mime;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI.WebControls;
using PayrollProject;
using System.Drawing;


namespace PayrollProject
{
    public enum UserPosition
    {
        First,
        Second,
        Third,
        Fourth,
        Fifth
    }
    public enum RLMLevel
    {
        Level1,
        Building,
        Organizing,
        Development
    }

    public class DBAccess : SqlPersisterBase
    {
        #region DisplayStyles enum

        public enum DisplayStyles
        {
            Info,
            Success,
            Warning,
            Error,
            Validation,
            None
        }

        #endregion

        #region Languages enum

        /// <summary>
        /// Various languages used in the website
        /// </summary>
        public enum Languages
        {
            English = 1,
            French = 2
        };

        #endregion

        #region QuestionStatus enum

        public enum QuestionStatus
        {
            /// <summary>
            /// Question is not answered by anybody.
            /// </summary>
            Unanswered = 1,
            /// <summary>
            /// Question is submitted by ministry users. This questions and "Forward2AdminByRegional" are displayed in admin Unanswered panel.
            /// </summary>
            SubmittedByMinistry = 2,
            /// <summary>
            /// Question is not answered by the ministry regional as usual. It is forwarded to admin for the answer.
            /// </summary>
            Forward2AdminByRegional = 3,
            /// <summary>
            /// Question is answered by ministry regional. so the answer is submitted to admin for approval.
            /// </summary>
            AnsweredByMinistry = 4,
            /// <summary>
            /// Question is forwarded to different partners by the admin.
            /// </summary>
            Forward2Partners = 5,
            /// <summary>
            /// Question is forwarded to expert
            /// </summary>
            Forward2Expert = 6,
            /// <summary>
            /// Question is answered and approved by admin. So it can be displayed while searching.
            /// </summary>
            Completed = 7,
            /// <summary>
            /// Answer is updated by a user
            /// </summary>
            AnswerUpdated = 8,
            /// <summary>
            /// The question is answered by expert and this has to be approved by admin
            /// </summary>
            AnsweredByExpert = 9,
            /// <summary>
            /// The question is answered by regional user and admin made the question as Public
            /// so that all the users can view the submitted question
            /// </summary>
            Approved4PublicView = 10,
            /// <summary>
            /// The question submitted by the regional user
            /// </summary>
            RegionalSubmittedQuestion
        };

        #endregion

        #region UserTypes enum

        /// <summary>
        /// Different type of users for the website
        /// </summary>
        public enum UserTypes
        {

            Administrator,

            User

        };

        #endregion

        private readonly List<string> strings2Exclude = new List<string>();

        /// <summary>
        /// Database connection string
        /// </summary>
        public string ConString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        public SqlConnection PublicCon = new SqlConnection();
        public SqlConnection PublicLogCon = new SqlConnection();

        public DBAccess()
        {
            PublicCon.ConnectionString = ConString;
            //PublicLogCon.ConnectionString = "data source=49.50.86.154;Initial Catalog=etdsLog_New;User ID=sa;Password=hn@#sa$%#rS$(9^j; Min Pool Size=20; Max Pool Size=1000; Connect Timeout=100000;";
            PublicLogCon.ConnectionString = @"data source=PCORE-LP-016\MSSQLSERVER01;Initial Catalog=etdsLog_New;Initial Catalog=etdsLog_New;Integrated Security=true;MultipleActiveResultSets=true;Connect Timeout=30;";
        }

        /// <summary>
        /// Gets if the user browser is IE version less than 8
        /// </summary>
        public bool IsOlderIE
        {
            get { return HttpContext.Current.Request.Browser.Browser == "IE" && HttpContext.Current.Request.Browser.MajorVersion < 7; }
        }

        /// <summary>
        /// Gets or sets the preferred language for the user 1 = English 2 = French
        /// </summary>
        public Languages Language
        {
            get
            {
                Languages language = Languages.English;
                if (HttpContext.Current.Session["language"] != null)
                    language = (Languages)HttpContext.Current.Session["language"];
                else HttpContext.Current.Session["language"] = language;
                return language;
            }
            set
            {
                if (value == Languages.English || value == Languages.French)
                    HttpContext.Current.Session["language"] = value;
            }
        }
        public Bitmap ResizeImage(Stream streamImage, int maxWidth, int maxHeight)
        {
            Bitmap originalImage = new Bitmap(streamImage);
            int newWidth = originalImage.Width;
            int newHeight = originalImage.Height;
            double aspectRatio = (double)originalImage.Width / (double)originalImage.Height;

            if (aspectRatio <= 1 && originalImage.Width > maxWidth)
            {
                newWidth = maxWidth;
                newHeight = (int)Math.Round(newWidth / aspectRatio);
            }
            else if (aspectRatio > 1 && originalImage.Height > maxHeight)
            {
                newHeight = maxHeight;
                newWidth = (int)Math.Round(newHeight * aspectRatio);
            }

            Bitmap newImage = new Bitmap(originalImage, newWidth, newHeight);

            Graphics g = Graphics.FromImage(newImage);
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBilinear;
            g.DrawImage(originalImage, 0, 0, newImage.Width, newImage.Height);

            originalImage.Dispose();

            return newImage;
        }
        public void ClearUploadedFiles()
        {
            List<Thumbnail> thumbnails = HttpContext.Current.Session["file_info"] as List<Thumbnail>;
            if (thumbnails != null)
            {
                string absPath = HttpContext.Current.Server.MapPath("~/upload/");
                foreach (Thumbnail thumbnail in thumbnails)
                    if (File.Exists(absPath + thumbnail.FileName))
                        File.Delete(absPath + thumbnail.FileName);
            }
            HttpContext.Current.Session["file_info"] = null;
        }
        /// <summary>
        /// Executes the given query and returns the sing data from the first column of the first row.
        /// </summary>
        /// <param name="sQuery">SQL Query to be executed</param>
        /// <returns></returns>
        public int GetCount(string sQuery)
        {
            int ret = 0;
            try
            {
                Open();
                object objCount;
                using (SqlCommand ObjCom = new SqlCommand(sQuery, PublicCon))
                {
                    objCount = ObjCom.ExecuteScalar();
                    ObjCom.Dispose();
                }
                if (objCount != null && objCount.ToString() != "")
                    int.TryParse(objCount.ToString(), out ret);
            }
            catch (Exception)
            {
                return 0;
            }
            finally
            {
                Close();
            }
            return ret;
        }

        /// <summary>
        /// The url of the website
        /// </summary>
        public string SiteURL
        {
            get
            {
                string path = HttpContext.Current.Request.Url.ToString();
                path =
                    path.Replace(
                        HttpContext.Current.Request.AppRelativeCurrentExecutionFilePath.Replace("~/", string.Empty),
                        string.Empty);
                return path;
            }
        }

        public static Guid ApplicationID
        {
            get { return new Guid("3729CD04-818A-492E-8EA7-7A23D29D73CE"); }
        }

        /// <summary>
        /// Role of the user who is currently logged in.
        /// </summary>
        public UserTypes CurrentRole
        {
            get
            {
                UserTypes userTypes = UserTypes.User;
                if (HttpContext.Current.User.IsInRole("Administrator")) userTypes = UserTypes.Administrator;
                return userTypes;
            }
        }

        public Guid currentRoleID
        {
            get
            {
                AspnetRoles aspnetRoles = new AspnetRoles(ApplicationID, "User");
                if (HttpContext.Current.User.IsInRole("Administrator"))
                    aspnetRoles = new AspnetRoles(ApplicationID, "administrator");
                return aspnetRoles.RoleId;
            }
        }



        /// <summary>
        /// Name of the current page requested
        /// </summary>
        public string currentPage
        {
            get
            {
                string absolutePath = HttpContext.Current.Request.Url.AbsolutePath;
                return absolutePath.Substring(absolutePath.LastIndexOf("/") + 1);
            }
        }


        public string GetUserRoleName(UserTypes usertype)
        {
            switch (usertype)
            {
                case UserTypes.User:
                    return "User";
                case UserTypes.Administrator:
                    return "Administrator";

            }
            return "";
        }
        public DateTime GetcurrentDate()
        {

            return DateTime.UtcNow.AddHours(5).AddMinutes(30);


        }
        public Boolean Open()
        {
            try
            {
                if (PublicCon.State != ConnectionState.Open)
                {
                    PublicCon.Open();
                    return true;
                }
                return false;
            }
            catch (Exception ex)
            {
                PrintError(ex, string.Empty);
                return false;
            }
        }

        public bool IsRowExists(string StrSQL)
        {
            try
            {
                Open();
                SqlCommand objCom = new SqlCommand(StrSQL, PublicCon);
                SqlDataReader objReader = objCom.ExecuteReader();
                if (objReader != null)
                    return objReader.Read();
            }
            catch (Exception ex)
            {
                PrintError(ex, string.Empty);
                return false;
            }
            finally
            {
                Close();
            }
            return false;
        }

        public Boolean Close()
        {
            try
            {
                if (PublicCon.State != ConnectionState.Closed)
                {
                    PublicCon.Close();
                    return true;
                }
                return false;
            }
            catch (Exception ex)
            {
                PrintError(ex, string.Empty);
                return false;
            }
        }

        public DataSet GetDataSet(string sQuery, string tblname)
        {
            try
            {
                Open();
                DataSet dt;
                using (SqlCommand objCom = new SqlCommand(sQuery, PublicCon))
                {
                    using (SqlDataAdapter objAdapter = new SqlDataAdapter(objCom))
                    {
                        dt = new DataSet();
                        objAdapter.Fill(dt, tblname);
                    }
                }
                return dt;
            }
            catch (Exception ex)
            {
                PrintError(ex, sQuery);

                return null;
            }
            finally
            {
                Close();
            }
        }

        public string EncryptData(string InputData)
        {
            try
            {
                //SHA1Managed shaM = new SHA1Managed();
                //Convert.ToBase64String(shaM.ComputeHash(Encoding.Unicode.GetBytes(InputData)));
                Byte[] eNC_data = Encoding.Unicode.GetBytes(InputData);
                string eNC_str = Convert.ToBase64String(eNC_data);
                return eNC_str;
            }
            catch
            {
                return InputData;
            }
        }

        public string DecryptData(string InputData)
        {
            try
            {
                Byte[] dEC_data = Convert.FromBase64String(InputData);
                string dEC_Str = Encoding.Unicode.GetString(dEC_data);
                return dEC_Str;
            }
            catch
            {
                return InputData;
            }
        }

        public DataTable GetDataTable(string sQuery)
        {
            using (SqlCommand sqlCommand = new SqlCommand(sQuery))
            {
                try
                {
                    // Attach command
                    AttachCommand(sqlCommand);
                    DataTable DtGrid = new DataTable();
                    using (SqlDataAdapter SQLAdapter = new SqlDataAdapter(sqlCommand))
                    {
                        SQLAdapter.Fill(DtGrid);
                        SQLAdapter.Dispose();
                    }
                    return DtGrid;
                }
                catch (Exception ex)
                {
                    PrintError(ex, "LogixLibrary::DBAcess.cs");
                    return null;
                }
                finally
                {
                    // Detach command
                    DetachCommand(sqlCommand);
                }
            }
        }

        public int ExecuteCommand(string sSQL)
        {
            int res = 0;

            using (SqlCommand sqlCommand = new SqlCommand(sSQL))
            {
                try
                {
                    // Attach command
                    AttachCommand(sqlCommand);

                    res = sqlCommand.ExecuteNonQuery();
                    sqlCommand.Dispose();
                }
                catch (Exception ex)
                {
                    PrintError(ex, "LogixLibrary::DBAcess.cs");
                }
                finally
                {
                    // Detach command
                    DetachCommand(sqlCommand);
                }
            }
            return res;
        }

        /// <summary>
        /// Executes the given query and returns the sing data from the first column of the first row.
        /// </summary>
        /// <param name="sQuery">SQL Query to be executed</param>
        /// <returns></returns>
        public object GetSingleData(string sQuery)
        {
            object ret;
            using (SqlCommand sqlCommand = new SqlCommand(sQuery))
            {
                try
                {
                    // Attach command
                    AttachCommand(sqlCommand);

                    ret = sqlCommand.ExecuteScalar();
                    sqlCommand.Dispose();
                }
                catch (Exception ex)
                {
                    PrintError(ex, sQuery);
                    return null;
                }
                finally
                {
                    // Detach command
                    DetachCommand(sqlCommand);
                }
            }
            return ret;
        }

        public static void PrintError(Exception ex, string PageName)
        {
            //write log to a text file

            FileInfo fi = new FileInfo(HttpContext.Current.Server.MapPath("~/Uploads/") + "ErrorLog.txt");
            if (!fi.Exists)
            {
                using (StreamWriter sw = fi.CreateText())
                {
                    sw.WriteLine("===================================================");
                    sw.WriteLine("This is a new exception from database access module : " + DateTime.Now);
                    sw.WriteLine("===================================================");
                    sw.WriteLine(ex.Message + ex.StackTrace + ex.Source + ex.HelpLink);
                    sw.WriteLine("===================================================");
                    sw.WriteLine("Page Name " + PageName);
                    sw.Close();
                }
            }
            else
            {
                fi.Refresh();
                if (!fi.IsReadOnly)
                {
                    using (StreamWriter sw = fi.AppendText())
                    {
                        sw.WriteLine("===================================================");
                        sw.WriteLine("This is a new exception from database access module : " + DateTime.Now);
                        sw.WriteLine("===================================================");
                        sw.WriteLine(ex.Message + ex.StackTrace + ex.Source + ex.HelpLink);
                        sw.WriteLine("===================================================");
                        sw.WriteLine("Page Name " + PageName);
                        sw.Close();
                    }
                }
            }
        }


        public static void PrintError(string Message)
        {
            //write log to a text file

            FileInfo fi = new FileInfo(HttpContext.Current.Server.MapPath("~/upload/") + "ErrorLog.txt");
            if (!fi.Exists)
            {
                using (StreamWriter sw = fi.CreateText())
                {
                    sw.WriteLine("===================================================");
                    sw.WriteLine("This is a new exception from database access module : " + DateTime.Now);
                    sw.WriteLine("===================================================");
                    sw.WriteLine(Message);
                    sw.WriteLine("===================================================");
                    sw.WriteLine("Page Name " + Message);
                    sw.Close();
                }
            }
            else
            {
                fi.Refresh();
                if (!fi.IsReadOnly)
                {
                    using (StreamWriter sw = fi.AppendText())
                    {
                        sw.WriteLine("===================================================");
                        sw.WriteLine("This is a new exception from database access module : " + DateTime.Now);
                        sw.WriteLine("===================================================");
                        sw.WriteLine(Message);
                        sw.WriteLine("===================================================");
                        sw.WriteLine("Page Name " + Message);
                        sw.Close();
                    }
                }
            }
        }
        public Boolean SendMailAsync(string from, string f_name, string to, string t_name, string subject,
                                     string message)
        {
            try
            {
                using (MailMessage message1 = new MailMessage(new MailAddress(from, f_name), new MailAddress(to)))
                {
                    SmtpClient smtp1 = new SmtpClient();

                    List<Thumbnail> thumbnails = HttpContext.Current.Session["file_info"] as List<Thumbnail>;
                    if (thumbnails != null)
                    {
                        foreach (Thumbnail thumbnail in thumbnails)
                        {
                            string FilePath = HttpContext.Current.Server.MapPath("~/upload/" + thumbnail.FileName);

                            // Create  the file attachment for this e-mail message.
                            using (Attachment data = new Attachment(FilePath, MediaTypeNames.Application.Octet))
                            {
                                ContentDisposition disposition = data.ContentDisposition;
                                disposition.CreationDate = File.GetCreationTime(FilePath);
                                disposition.ModificationDate = File.GetLastWriteTime(FilePath);
                                disposition.ReadDate = File.GetLastAccessTime(FilePath);

                                // Add the file attachment to this e-mail message.
                                message1.Attachments.Add(data);
                            }
                        }
                        HttpContext.Current.Session["file_info"] = null;
                    }

                    message1.IsBodyHtml = true;
                    message1.Subject = subject;
                    message1.Body = message;
                    smtp1.Send(message1);
                }

                return true;
            }
            catch (Exception ex)
            {
                PrintError(ex, "News Letter.aspx");
                return false;
            }
        }

        public Boolean SendMailAsync(string from, string f_name, string to, string t_name, string subject,
                                     string message, long answerid)
        {
            try
            {
                using (MailMessage message1 = new MailMessage(new MailAddress(from, f_name), new MailAddress(to)))
                {
                    SmtpClient smtp1 = new SmtpClient();

                    try
                    {
                        DataTable dtAttachments = GetDataTable("SELECT * FROM Attachments WHERE AnswerID = " + answerid);

                        if (dtAttachments != null && dtAttachments.Rows.Count > 0)
                        {
                            foreach (DataRow drAttachment in dtAttachments.Rows)
                            {
                                string FilePath =
                                    HttpContext.Current.Server.MapPath("~/upload/" + drAttachment["AttachmentName"]);

                                // Create  the file attachment for this e-mail message.
                                Attachment data = new Attachment(FilePath, MediaTypeNames.Application.Octet);

                                ContentDisposition disposition = data.ContentDisposition;
                                disposition.FileName = drAttachment["ActualName"].ToString();
                                disposition.CreationDate = File.GetCreationTime(FilePath);
                                disposition.ModificationDate = File.GetLastWriteTime(FilePath);
                                disposition.ReadDate = File.GetLastAccessTime(FilePath);

                                // Add the file attachment to this e-mail message.
                                message1.Attachments.Add(data);
                            }
                            HttpContext.Current.Session["file_info"] = null;
                        }
                    }
                    catch (Exception ex)
                    {
                        PrintError(ex, "News Letter.aspx");
                    }

                    message1.IsBodyHtml = true;
                    message1.Subject = subject;
                    message1.Body = message;
                    smtp1.Send(message1);
                }

                return true;
            }
            catch (Exception ex)
            {
                PrintError(ex, "News Letter.aspx");
                return false;
            }
        }








        public List<Alphabets> GetAlphabets()
        {
            List<Alphabets> alphabetses = new List<Alphabets>();
            for (short i = 65; i < 91; i++)
            {
                alphabetses.Add(new Alphabets(i));
            }
            return alphabetses;
        }

        /// <summary>
        /// Gets the message to display to the end user
        /// </summary>
        /// <param name="status">Membership creation status returned by the Membership Provider</param>
        /// <returns></returns>
        public static string GetUserCreationStatusMessage(MembershipCreateStatus status)
        {
            string userstatus = "";
            string currentStatus = status.ToString();
            foreach (char c in currentStatus)
            {
                userstatus += (!currentStatus.StartsWith(c.ToString()) && char.IsUpper(c))
                                  ? (" " + char.ToLower(c))
                                  : c.ToString();
            }
            return userstatus;
        }

        public string GetPositionID(string uplineUser, string placement)
        {
            string strSQL = string.Empty;
            try
            {
                strSQL = string.Format("select UserLevel  from user_master where fUpID='{0}' and position='{1}'",
                                       uplineUser, placement);
                Open();
                using (SqlCommand objCom = new SqlCommand(strSQL, PublicCon))
                {
                    using (SqlDataReader objReader = objCom.ExecuteReader())
                    {
                        if (objReader != null)
                            return objReader.Read() ? objReader.GetValue(0).ToString() : string.Empty;
                    }
                }
            }
            catch (Exception ex)
            {
                DBAccess.PrintError(ex, strSQL);
            }
            finally
            {
                Close();
            }
            return string.Empty;
        }

        public string GetUserLevel(string username)
        {
            string strSQL = string.Format("select UserLevel  from user_master where Username='{0}'", username);
            try
            {
                Open();
                using (SqlCommand objCom = new SqlCommand(strSQL, PublicCon))
                using (SqlDataReader objReader = objCom.ExecuteReader())
                    if (objReader != null)
                        return objReader.Read() ? objReader.GetValue(0).ToString() : string.Empty;
            }
            catch (Exception ex)
            {
                DBAccess.PrintError(ex, strSQL);
            }
            finally
            {
                Close();
            }
            return string.Empty;
        }
        public DateTime GetCurrentDate()
        {
            return DateTime.Now.AddMinutes(-208);
        }
        public int CommandExecute(string StrSQL)
        {
            try
            {

                Open();
                SqlCommand ObjCom = new SqlCommand(StrSQL, PublicCon);
                return ObjCom.ExecuteNonQuery();
            }
            catch (Exception Ex)
            {
                PrintError(Ex, StrSQL);
                return 0;
            }
            finally
            {
                Close();
            }
        }

        public int CreateLog(string pagename, string processName, string compid, string Returns_Sts = "")
        {
            string SQLQuery = "";
            try
            {
                SQLQuery = "dbo.Usp_CreateLog";
                Open();
                SqlCommand ObjCom = new SqlCommand();
                ObjCom.CommandText = SQLQuery;
                ObjCom.Connection = PublicCon;
                ObjCom.CommandType = CommandType.StoredProcedure;
                ObjCom.Parameters.AddWithValue("@PageName", pagename);
                ObjCom.Parameters.AddWithValue("@ProcessName", processName);
                ObjCom.Parameters.AddWithValue("@Company_id", compid);
                ObjCom.Parameters.AddWithValue("@Returns_Sts", Returns_Sts);
                return ObjCom.ExecuteNonQuery();
            }
            catch (Exception Ex)
            {
                PrintError(Ex, SQLQuery);
                return 0;
            }
            finally
            {
                Close();
            }
        }

    }

    public class Alphabets
    {
        private readonly short asciicode;

        public Alphabets(short code)
        {
            asciicode = code;
        }

        public short AsciiCode
        {
            get { return asciicode; }
        }

        public string Alphabet
        {
            get { return ((char)asciicode).ToString(); }
        }
    }

}