// This code was generated by an EVALUATION copy of Schematrix SchemaCoder.
// Redistribution of this source code, or an application developed from it, is forbidden.
// Modification of this source code to remove this comment is also forbidden.
// Please visit http://www.schematrix.com/ to obtain a license to use this software.


using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.IO;

namespace PayrollProject
{
    public partial class AdminPrivs
    {
        private static IAdminPrivsPersister _DefaultPersister;
        private IAdminPrivsPersister _Persister;
        private int _id;
        private string _username;
        private string _pwd;

        static AdminPrivs()
        {
            // Assign default persister
            _DefaultPersister = new SqlServerAdminPrivsPersister();
        }

        public AdminPrivs()
        {
            // Assign default persister to instance persister
            _Persister = _DefaultPersister; 
        }

        public AdminPrivs(int _id)
        {
            // Assign default persister to instance persister
            _Persister = _DefaultPersister; 

            // Assign method parameter to private fields
            this._id = _id; 

            // Call associated retrieve method
            Retrieve();
        }

        public AdminPrivs(DataRow row)
        {
            // Assign default persister to instance persister
            _Persister = _DefaultPersister; 

            // Assign column values to private members
            for (int  i = 0; i < row.Table.Columns.Count; i++)
            {
                switch (row.Table.Columns[i].ColumnName.ToUpper())
                {
                    case "ID":
                        this.id = Convert.ToInt32(row[i, DataRowVersion.Current]); 
                        break;
                    
                    case "USERNAME":
                        if(row.IsNull(i) == false)
                        {
                            this.username = (string)row[i, DataRowVersion.Current]; 
                        }
                        break;
                    
                    case "PWD":
                        if(row.IsNull(i) == false)
                        {
                            this.pwd = (string)row[i, DataRowVersion.Current]; 
                        }
                        break;
                    
                }
            }
        }

        public static IAdminPrivsPersister DefaultPersister
        {
            get { return _DefaultPersister; }
            set { _DefaultPersister = value; }
        }

        public IAdminPrivsPersister Persister
        {
            get { return _Persister; }
            set { _Persister = value; }
        }

        public int id
        {
            get { return _id; }
            set { _id = value; }
        }

        public string username
        {
            get { return _username; }
            set { _username = value; }
        }

        public string pwd
        {
            get { return _pwd; }
            set { _pwd = value; }
        }

        public virtual void Clone(AdminPrivs sourceObject)
        {
            // Clone attributes from source object
            this._id = sourceObject.id; 
            this._username = sourceObject.username; 
            this._pwd = sourceObject.pwd; 
        }

        public virtual int Retrieve()
        {
            return _Persister.Retrieve(this); 
        }

        public virtual int Update()
        {
            return _Persister.Update(this); 
        }

        public virtual int Delete()
        {
            return _Persister.Delete(this); 
        }

        public virtual int Insert()
        {
            return _Persister.Insert(this); 
        }

        public static IReader<AdminPrivs> ListAll()
        {
            return _DefaultPersister.ListAll(); 
        }

    }
    
    public partial interface IAdminPrivsPersister
    {
        int Retrieve(AdminPrivs adminPrivs);
        int Update(AdminPrivs adminPrivs);
        int Delete(AdminPrivs adminPrivs);
        int Insert(AdminPrivs adminPrivs);
        IReader<AdminPrivs> ListAll();
    }
    
    public partial class SqlServerAdminPrivsPersister : SqlPersisterBase, IAdminPrivsPersister
    {
        public SqlServerAdminPrivsPersister()
        {
        }

        public SqlServerAdminPrivsPersister(string connectionString) : base(connectionString)
        {
        }

        public SqlServerAdminPrivsPersister(SqlConnection connection) : base(connection)
        {
        }

        public SqlServerAdminPrivsPersister(SqlTransaction transaction) : base(transaction)
        {
        }

        public int Retrieve(AdminPrivs adminPrivs)
        {
            int __rowsAffected = 1;
            
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AdminPrivsGet"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                try
                {
                    // Attach command
                    AttachCommand(sqlCommand);

                    // Add command parameters
                    SqlParameter vid = new SqlParameter("@id", SqlDbType.Int);
                    vid.Direction = ParameterDirection.InputOutput; 
                    sqlCommand.Parameters.Add(vid);
                    SqlParameter vusername = new SqlParameter("@username", SqlDbType.VarChar, 255);
                    vusername.Direction = ParameterDirection.Output; 
                    sqlCommand.Parameters.Add(vusername);
                    SqlParameter vpwd = new SqlParameter("@pwd", SqlDbType.VarChar, 255);
                    vpwd.Direction = ParameterDirection.Output; 
                    sqlCommand.Parameters.Add(vpwd);

                    // Set input parameter values
                    SqlServerHelper.SetParameterValue(vid, adminPrivs.id);

                    // Execute command
                    sqlCommand.ExecuteNonQuery();

                    try
                    {
                        // Get output parameter values
                        adminPrivs.id = SqlServerHelper.ToInt32(vid); 
                        adminPrivs.username = SqlServerHelper.ToString(vusername); 
                        adminPrivs.pwd = SqlServerHelper.ToString(vpwd); 

                    }
                    catch(Exception ex)
                    {
                        if(ex is System.NullReferenceException)
                        {
                            __rowsAffected = 0; 
                        }
                        else
                        {
                            throw ex; 
                        }
                    }
                }
                finally
                {
                    // Detach command
                    DetachCommand(sqlCommand);
                }

            }
            
            return __rowsAffected; 
        }

        public int Update(AdminPrivs adminPrivs)
        {
            int __rowsAffected = 0;
            
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AdminPrivsUpdate"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                // Add command parameters
                SqlParameter vid = new SqlParameter("@id", SqlDbType.Int);
                vid.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vid);
                SqlParameter vusername = new SqlParameter("@username", SqlDbType.VarChar, 255);
                vusername.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vusername);
                SqlParameter vpwd = new SqlParameter("@pwd", SqlDbType.VarChar, 255);
                vpwd.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vpwd);

                // Set input parameter values
                SqlServerHelper.SetParameterValue(vid, adminPrivs.id);
                SqlServerHelper.SetParameterValue(vusername, adminPrivs.username);
                SqlServerHelper.SetParameterValue(vpwd, adminPrivs.pwd);

                try
                {
                    // Attach command
                    AttachCommand(sqlCommand);

                    // Execute command
                    __rowsAffected = sqlCommand.ExecuteNonQuery(); 
                    if(__rowsAffected == 0)
                    {
                        return __rowsAffected; 
                    }
                    

                }
                finally
                {
                    // Detach command
                    DetachCommand(sqlCommand);
                }

            }
            
            return __rowsAffected; 
        }

        public int Delete(AdminPrivs adminPrivs)
        {
            int __rowsAffected = 0;
            
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AdminPrivsDelete"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                try
                {
                    // Attach command
                    AttachCommand(sqlCommand);

                    // Add command parameters
                    SqlParameter vid = new SqlParameter("@id", SqlDbType.Int);
                    vid.Direction = ParameterDirection.Input; 
                    sqlCommand.Parameters.Add(vid);

                    // Set input parameter values
                    SqlServerHelper.SetParameterValue(vid, adminPrivs.id);

                    // Execute command
                    __rowsAffected = sqlCommand.ExecuteNonQuery(); 

                }
                finally
                {
                    // Detach command
                    DetachCommand(sqlCommand);
                }

            }
            
            return __rowsAffected; 
        }

        public int Insert(AdminPrivs adminPrivs)
        {
            int __rowsAffected = 0;
            
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AdminPrivsInsert"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                // Add command parameters
                SqlParameter vid = new SqlParameter("@id", SqlDbType.Int);
                vid.Direction = ParameterDirection.InputOutput; 
                sqlCommand.Parameters.Add(vid);
                SqlParameter vusername = new SqlParameter("@username", SqlDbType.VarChar, 255);
                vusername.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vusername);
                SqlParameter vpwd = new SqlParameter("@pwd", SqlDbType.VarChar, 255);
                vpwd.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vpwd);

                // Set input parameter values
                SqlServerHelper.SetParameterValue(
                    vid, 
                    adminPrivs.id, 
                    0);
                SqlServerHelper.SetParameterValue(vusername, adminPrivs.username);
                SqlServerHelper.SetParameterValue(vpwd, adminPrivs.pwd);

                try
                {
                    // Attach command
                    AttachCommand(sqlCommand);

                    // Execute command
                    __rowsAffected = sqlCommand.ExecuteNonQuery(); 
                    if(__rowsAffected == 0)
                    {
                        return __rowsAffected; 
                    }
                    

                    // Get output parameter values
                    adminPrivs.id = SqlServerHelper.ToInt32(vid); 

                }
                finally
                {
                    // Detach command
                    DetachCommand(sqlCommand);
                }

            }
            
            return __rowsAffected; 
        }

        public IReader<AdminPrivs> ListAll()
        {
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AdminPrivsListAll"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                // Execute command
                SqlDataReader reader = sqlCommand.ExecuteReader(AttachReaderCommand(sqlCommand));

                // Return reader
                return new SqlServerAdminPrivsReader(reader); 
            }
        }

    }

    public partial class SqlServerAdminPrivsReader : IReader<AdminPrivs>
    {
        private SqlDataReader sqlDataReader;

        private AdminPrivs _AdminPrivs;

        private int _idOrdinal = -1;
        private int _usernameOrdinal = -1;
        private int _pwdOrdinal = -1;

        public SqlServerAdminPrivsReader(SqlDataReader sqlDataReader)
        {
            this.sqlDataReader = sqlDataReader; 
            for (int  i = 0; i < sqlDataReader.FieldCount; i++)
            {
                string columnName = sqlDataReader.GetName(i);
                columnName = columnName.ToUpper(); 
                switch (columnName)
                {
                    case "ID":
                        _idOrdinal = i; 
                        break;
                    
                    case "USERNAME":
                        _usernameOrdinal = i; 
                        break;
                    
                    case "PWD":
                        _pwdOrdinal = i; 
                        break;
                    
                }
            }
        }

        #region IReader<AdminPrivs> Implementation
        
        public bool Read()
        {
            _AdminPrivs = null; 
            return this.sqlDataReader.Read(); 
        }

        public AdminPrivs Current
        {
            get
            {
                if(_AdminPrivs == null)
                {
                    _AdminPrivs = new AdminPrivs();
                    if(_idOrdinal != -1)
                    {
                        _AdminPrivs.id = SqlServerHelper.ToInt32(sqlDataReader, _idOrdinal); 
                    }
                    _AdminPrivs.username = SqlServerHelper.ToString(sqlDataReader, _usernameOrdinal); 
                    _AdminPrivs.pwd = SqlServerHelper.ToString(sqlDataReader, _pwdOrdinal); 
                }
                

                return _AdminPrivs; 
            }
        }

        public void Close()
        {
            sqlDataReader.Close();
        }

        public List<AdminPrivs> ToList()
        {
            List<AdminPrivs> list = new List<AdminPrivs>();
            while(this.Read())
            {
                list.Add(this.Current);
            }
            this.Close();
            return list; 
        }

        public DataTable ToDataTable()
        {
            DataTable dataTable = new DataTable();
            dataTable.Load(sqlDataReader);
            return dataTable; 
        }

        #endregion
        
        #region IDisposable Implementation
        
        public void Dispose()
        {
            sqlDataReader.Dispose();
        }
        #endregion
        
        #region IEnumerable<AdminPrivs> Implementation
        
        public IEnumerator<AdminPrivs> GetEnumerator()
        {
            return new AdminPrivsEnumerator(this); 
        }

        #endregion
        
        #region IEnumerable Implementation
        
        IEnumerator IEnumerable.GetEnumerator()
        {
            return new AdminPrivsEnumerator(this); 
        }

        #endregion
        
        
        private partial class AdminPrivsEnumerator : IEnumerator<AdminPrivs>
        {
            private IReader<AdminPrivs> adminPrivsReader;

            public AdminPrivsEnumerator(IReader<AdminPrivs> adminPrivsReader)
            {
                this.adminPrivsReader = adminPrivsReader; 
            }

            #region IEnumerator<AdminPrivs> Members
            
            public AdminPrivs Current
            {
                get { return this.adminPrivsReader.Current; }
            }

            #endregion
            
            #region IDisposable Members
            
            public void Dispose()
            {
                this.adminPrivsReader.Dispose();
            }

            #endregion
            
            #region IEnumerator Members
            
            object IEnumerator.Current
            {
                get { return this.adminPrivsReader.Current; }
            }

            public bool MoveNext()
            {
                return this.adminPrivsReader.Read(); 
            }

            public void Reset()
            {
                throw new Exception("Reset of adminprivs reader is not supported."); 
            }

            #endregion
            
        }
    }
}
