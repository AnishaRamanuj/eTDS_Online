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
    public partial class AspnetApplications
    {
        private static IAspnetApplicationsPersister _DefaultPersister;
        private IAspnetApplicationsPersister _Persister;
        private string _ApplicationName;
        private string _LoweredApplicationName;
        private Guid _ApplicationId;
        private string _Description;

        static AspnetApplications()
        {
            // Assign default persister
            _DefaultPersister = new SqlServerAspnetApplicationsPersister();
        }

        public AspnetApplications()
        {
            // Assign default persister to instance persister
            _Persister = _DefaultPersister; 
        }

        public AspnetApplications(Guid _ApplicationId)
        {
            // Assign default persister to instance persister
            _Persister = _DefaultPersister; 

            // Assign method parameter to private fields
            this._ApplicationId = _ApplicationId; 

            // Call associated retrieve method
            Retrieve();
        }

        public AspnetApplications(string _ApplicationName)
        {
            // Assign default persister to instance persister
            _Persister = _DefaultPersister; 

            // Assign method parameter to private fields
            this._ApplicationName = _ApplicationName; 

            // Call associated retrieve method
            RetrieveByApplicationName();
        }

        public AspnetApplications(DataRow row)
        {
            // Assign default persister to instance persister
            _Persister = _DefaultPersister; 

            // Assign column values to private members
            for (int  i = 0; i < row.Table.Columns.Count; i++)
            {
                switch (row.Table.Columns[i].ColumnName.ToUpper())
                {
                    case "APPLICATIONNAME":
                        this.ApplicationName = (string)row[i, DataRowVersion.Current]; 
                        break;
                    
                    case "LOWEREDAPPLICATIONNAME":
                        this.LoweredApplicationName = (string)row[i, DataRowVersion.Current]; 
                        break;
                    
                    case "APPLICATIONID":
                        if(row[i, DataRowVersion.Current] is Guid)
                        {
                            this.ApplicationId = (Guid)row[i, DataRowVersion.Current]; 
                        }
                        else
                        {
                            this.ApplicationId = new Guid((Byte[])row[i, DataRowVersion.Current]); 
                        }
                        break;
                    
                    case "DESCRIPTION":
                        if(row.IsNull(i) == false)
                        {
                            this.Description = (string)row[i, DataRowVersion.Current]; 
                        }
                        break;
                    
                }
            }
        }

        public static IAspnetApplicationsPersister DefaultPersister
        {
            get { return _DefaultPersister; }
            set { _DefaultPersister = value; }
        }

        public IAspnetApplicationsPersister Persister
        {
            get { return _Persister; }
            set { _Persister = value; }
        }

        public string ApplicationName
        {
            get { return _ApplicationName; }
            set { _ApplicationName = value; }
        }

        public string LoweredApplicationName
        {
            get { return _LoweredApplicationName; }
            set { _LoweredApplicationName = value; }
        }

        public Guid ApplicationId
        {
            get { return _ApplicationId; }
            set { _ApplicationId = value; }
        }

        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }

        public virtual void Clone(AspnetApplications sourceObject)
        {
            // Clone attributes from source object
            this._ApplicationName = sourceObject.ApplicationName; 
            this._LoweredApplicationName = sourceObject.LoweredApplicationName; 
            this._ApplicationId = sourceObject.ApplicationId; 
            this._Description = sourceObject.Description; 
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

        public static IReader<AspnetApplications> ListAll()
        {
            return _DefaultPersister.ListAll(); 
        }

        public static IReader<AspnetApplications> ListForLoweredApplicationName(string loweredApplicationName)
        {
            return _DefaultPersister.ListForLoweredApplicationName(loweredApplicationName); 
        }

        public virtual int RetrieveByApplicationName()
        {
            return _Persister.RetrieveByApplicationName(this); 
        }

        public virtual int RetrieveByLoweredApplicationName()
        {
            return _Persister.RetrieveByLoweredApplicationName(this); 
        }

    }
    
    public partial interface IAspnetApplicationsPersister
    {
        int Retrieve(AspnetApplications aspnetApplications);
        int Update(AspnetApplications aspnetApplications);
        int Delete(AspnetApplications aspnetApplications);
        int Insert(AspnetApplications aspnetApplications);
        IReader<AspnetApplications> ListAll();
        IReader<AspnetApplications> ListForLoweredApplicationName(string loweredApplicationName);
        int RetrieveByApplicationName(AspnetApplications aspnetApplications);
        int RetrieveByLoweredApplicationName(AspnetApplications aspnetApplications);
    }
    
    public partial class SqlServerAspnetApplicationsPersister : SqlPersisterBase, IAspnetApplicationsPersister
    {
        public SqlServerAspnetApplicationsPersister()
        {
        }

        public SqlServerAspnetApplicationsPersister(string connectionString) : base(connectionString)
        {
        }

        public SqlServerAspnetApplicationsPersister(SqlConnection connection) : base(connection)
        {
        }

        public SqlServerAspnetApplicationsPersister(SqlTransaction transaction) : base(transaction)
        {
        }

        public int Retrieve(AspnetApplications aspnetApplications)
        {
            int __rowsAffected = 1;
            
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AspnetApplicationsGet"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                try
                {
                    // Attach command
                    AttachCommand(sqlCommand);

                    // Add command parameters
                    SqlParameter vApplicationName = new SqlParameter("@ApplicationName", SqlDbType.NVarChar, 256);
                    vApplicationName.Direction = ParameterDirection.Output; 
                    sqlCommand.Parameters.Add(vApplicationName);
                    SqlParameter vLoweredApplicationName = new SqlParameter("@LoweredApplicationName", SqlDbType.NVarChar, 256);
                    vLoweredApplicationName.Direction = ParameterDirection.Output; 
                    sqlCommand.Parameters.Add(vLoweredApplicationName);
                    SqlParameter vApplicationId = new SqlParameter("@ApplicationId", SqlDbType.UniqueIdentifier);
                    vApplicationId.Direction = ParameterDirection.InputOutput; 
                    sqlCommand.Parameters.Add(vApplicationId);
                    SqlParameter vDescription = new SqlParameter("@Description", SqlDbType.NVarChar, 256);
                    vDescription.Direction = ParameterDirection.Output; 
                    sqlCommand.Parameters.Add(vDescription);

                    // Set input parameter values
                    SqlServerHelper.SetParameterValue(vApplicationId, aspnetApplications.ApplicationId);

                    // Execute command
                    sqlCommand.ExecuteNonQuery();

                    try
                    {
                        // Get output parameter values
                        aspnetApplications.ApplicationName = SqlServerHelper.ToString(vApplicationName); 
                        aspnetApplications.LoweredApplicationName = SqlServerHelper.ToString(vLoweredApplicationName); 
                        aspnetApplications.ApplicationId = SqlServerHelper.ToGuid(vApplicationId); 
                        aspnetApplications.Description = SqlServerHelper.ToString(vDescription); 

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

        public int Update(AspnetApplications aspnetApplications)
        {
            int __rowsAffected = 0;
            
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AspnetApplicationsUpdate"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                // Add command parameters
                SqlParameter vApplicationName = new SqlParameter("@ApplicationName", SqlDbType.NVarChar, 256);
                vApplicationName.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vApplicationName);
                SqlParameter vLoweredApplicationName = new SqlParameter("@LoweredApplicationName", SqlDbType.NVarChar, 256);
                vLoweredApplicationName.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vLoweredApplicationName);
                SqlParameter vApplicationId = new SqlParameter("@ApplicationId", SqlDbType.UniqueIdentifier);
                vApplicationId.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vApplicationId);
                SqlParameter vDescription = new SqlParameter("@Description", SqlDbType.NVarChar, 256);
                vDescription.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vDescription);

                // Set input parameter values
                SqlServerHelper.SetParameterValue(vApplicationName, aspnetApplications.ApplicationName);
                SqlServerHelper.SetParameterValue(vLoweredApplicationName, aspnetApplications.LoweredApplicationName);
                SqlServerHelper.SetParameterValue(vApplicationId, aspnetApplications.ApplicationId);
                SqlServerHelper.SetParameterValue(vDescription, aspnetApplications.Description);

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

        public int Delete(AspnetApplications aspnetApplications)
        {
            int __rowsAffected = 0;
            
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AspnetApplicationsDelete"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                try
                {
                    // Attach command
                    AttachCommand(sqlCommand);

                    // Add command parameters
                    SqlParameter vApplicationId = new SqlParameter("@ApplicationId", SqlDbType.UniqueIdentifier);
                    vApplicationId.Direction = ParameterDirection.Input; 
                    sqlCommand.Parameters.Add(vApplicationId);

                    // Set input parameter values
                    SqlServerHelper.SetParameterValue(vApplicationId, aspnetApplications.ApplicationId);

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

        public int Insert(AspnetApplications aspnetApplications)
        {
            int __rowsAffected = 0;
            
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AspnetApplicationsInsert"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                // Add command parameters
                SqlParameter vApplicationName = new SqlParameter("@ApplicationName", SqlDbType.NVarChar, 256);
                vApplicationName.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vApplicationName);
                SqlParameter vLoweredApplicationName = new SqlParameter("@LoweredApplicationName", SqlDbType.NVarChar, 256);
                vLoweredApplicationName.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vLoweredApplicationName);
                SqlParameter vApplicationId = new SqlParameter("@ApplicationId", SqlDbType.UniqueIdentifier);
                vApplicationId.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vApplicationId);
                SqlParameter vDescription = new SqlParameter("@Description", SqlDbType.NVarChar, 256);
                vDescription.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vDescription);

                // Set input parameter values
                SqlServerHelper.SetParameterValue(vApplicationName, aspnetApplications.ApplicationName);
                SqlServerHelper.SetParameterValue(vLoweredApplicationName, aspnetApplications.LoweredApplicationName);
                SqlServerHelper.SetParameterValue(vApplicationId, aspnetApplications.ApplicationId);
                SqlServerHelper.SetParameterValue(vDescription, aspnetApplications.Description);

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

        public IReader<AspnetApplications> ListAll()
        {
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AspnetApplicationsListAll"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                // Execute command
                SqlDataReader reader = sqlCommand.ExecuteReader(AttachReaderCommand(sqlCommand));

                // Return reader
                return new SqlServerAspnetApplicationsReader(reader); 
            }
        }

        public IReader<AspnetApplications> ListForLoweredApplicationName(string loweredApplicationName)
        {
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AspnetApplicationsListByLoweredApplicationName"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                // Add command parameters
                SqlParameter vLoweredApplicationName = new SqlParameter("@LoweredApplicationName", SqlDbType.NVarChar, 256);
                vLoweredApplicationName.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vLoweredApplicationName);
                
                // Set input parameter values
                SqlServerHelper.SetParameterValue(vLoweredApplicationName, loweredApplicationName);

                // Execute command
                SqlDataReader reader = sqlCommand.ExecuteReader(AttachReaderCommand(sqlCommand));

                // Return reader
                return new SqlServerAspnetApplicationsReader(reader); 
            }
        }

        public int RetrieveByApplicationName(AspnetApplications aspnetApplications)
        {
            int __rowsAffected = 1;
            
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AspnetApplicationsGetByApplicationName"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                try
                {
                    // Attach command
                    AttachCommand(sqlCommand);

                    // Add command parameters
                    SqlParameter vApplicationName = new SqlParameter("@ApplicationName", SqlDbType.NVarChar, 256);
                    vApplicationName.Direction = ParameterDirection.InputOutput; 
                    sqlCommand.Parameters.Add(vApplicationName);
                    SqlParameter vLoweredApplicationName = new SqlParameter("@LoweredApplicationName", SqlDbType.NVarChar, 256);
                    vLoweredApplicationName.Direction = ParameterDirection.Output; 
                    sqlCommand.Parameters.Add(vLoweredApplicationName);
                    SqlParameter vApplicationId = new SqlParameter("@ApplicationId", SqlDbType.UniqueIdentifier);
                    vApplicationId.Direction = ParameterDirection.Output; 
                    sqlCommand.Parameters.Add(vApplicationId);
                    SqlParameter vDescription = new SqlParameter("@Description", SqlDbType.NVarChar, 256);
                    vDescription.Direction = ParameterDirection.Output; 
                    sqlCommand.Parameters.Add(vDescription);

                    // Set input parameter values
                    SqlServerHelper.SetParameterValue(vApplicationName, aspnetApplications.ApplicationName);

                    // Execute command
                    sqlCommand.ExecuteNonQuery();

                    try
                    {
                        // Get output parameter values
                        aspnetApplications.ApplicationName = SqlServerHelper.ToString(vApplicationName); 
                        aspnetApplications.LoweredApplicationName = SqlServerHelper.ToString(vLoweredApplicationName); 
                        aspnetApplications.ApplicationId = SqlServerHelper.ToGuid(vApplicationId); 
                        aspnetApplications.Description = SqlServerHelper.ToString(vDescription); 

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

        public int RetrieveByLoweredApplicationName(AspnetApplications aspnetApplications)
        {
            int __rowsAffected = 1;
            
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AspnetApplicationsGetByLoweredApplicationName"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                try
                {
                    // Attach command
                    AttachCommand(sqlCommand);

                    // Add command parameters
                    SqlParameter vApplicationName = new SqlParameter("@ApplicationName", SqlDbType.NVarChar, 256);
                    vApplicationName.Direction = ParameterDirection.Output; 
                    sqlCommand.Parameters.Add(vApplicationName);
                    SqlParameter vLoweredApplicationName = new SqlParameter("@LoweredApplicationName", SqlDbType.NVarChar, 256);
                    vLoweredApplicationName.Direction = ParameterDirection.InputOutput; 
                    sqlCommand.Parameters.Add(vLoweredApplicationName);
                    SqlParameter vApplicationId = new SqlParameter("@ApplicationId", SqlDbType.UniqueIdentifier);
                    vApplicationId.Direction = ParameterDirection.Output; 
                    sqlCommand.Parameters.Add(vApplicationId);
                    SqlParameter vDescription = new SqlParameter("@Description", SqlDbType.NVarChar, 256);
                    vDescription.Direction = ParameterDirection.Output; 
                    sqlCommand.Parameters.Add(vDescription);

                    // Set input parameter values
                    SqlServerHelper.SetParameterValue(vLoweredApplicationName, aspnetApplications.LoweredApplicationName);

                    // Execute command
                    sqlCommand.ExecuteNonQuery();

                    try
                    {
                        // Get output parameter values
                        aspnetApplications.ApplicationName = SqlServerHelper.ToString(vApplicationName); 
                        aspnetApplications.LoweredApplicationName = SqlServerHelper.ToString(vLoweredApplicationName); 
                        aspnetApplications.ApplicationId = SqlServerHelper.ToGuid(vApplicationId); 
                        aspnetApplications.Description = SqlServerHelper.ToString(vDescription); 

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

    }

    public partial class SqlServerAspnetApplicationsReader : IReader<AspnetApplications>
    {
        private SqlDataReader sqlDataReader;

        private AspnetApplications _AspnetApplications;

        private int _ApplicationNameOrdinal = -1;
        private int _LoweredApplicationNameOrdinal = -1;
        private int _ApplicationIdOrdinal = -1;
        private int _DescriptionOrdinal = -1;

        public SqlServerAspnetApplicationsReader(SqlDataReader sqlDataReader)
        {
            this.sqlDataReader = sqlDataReader; 
            for (int  i = 0; i < sqlDataReader.FieldCount; i++)
            {
                string columnName = sqlDataReader.GetName(i);
                columnName = columnName.ToUpper(); 
                switch (columnName)
                {
                    case "APPLICATIONNAME":
                        _ApplicationNameOrdinal = i; 
                        break;
                    
                    case "LOWEREDAPPLICATIONNAME":
                        _LoweredApplicationNameOrdinal = i; 
                        break;
                    
                    case "APPLICATIONID":
                        _ApplicationIdOrdinal = i; 
                        break;
                    
                    case "DESCRIPTION":
                        _DescriptionOrdinal = i; 
                        break;
                    
                }
            }
        }

        #region IReader<AspnetApplications> Implementation
        
        public bool Read()
        {
            _AspnetApplications = null; 
            return this.sqlDataReader.Read(); 
        }

        public AspnetApplications Current
        {
            get
            {
                if(_AspnetApplications == null)
                {
                    _AspnetApplications = new AspnetApplications();
                    _AspnetApplications.ApplicationName = SqlServerHelper.ToString(sqlDataReader, _ApplicationNameOrdinal); 
                    _AspnetApplications.LoweredApplicationName = SqlServerHelper.ToString(sqlDataReader, _LoweredApplicationNameOrdinal); 
                    if(_ApplicationIdOrdinal != -1)
                    {
                        _AspnetApplications.ApplicationId = SqlServerHelper.ToGuid(sqlDataReader, _ApplicationIdOrdinal); 
                    }
                    _AspnetApplications.Description = SqlServerHelper.ToString(sqlDataReader, _DescriptionOrdinal); 
                }
                

                return _AspnetApplications; 
            }
        }

        public void Close()
        {
            sqlDataReader.Close();
        }

        public List<AspnetApplications> ToList()
        {
            List<AspnetApplications> list = new List<AspnetApplications>();
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
        
        #region IEnumerable<AspnetApplications> Implementation
        
        public IEnumerator<AspnetApplications> GetEnumerator()
        {
            return new AspnetApplicationsEnumerator(this); 
        }

        #endregion
        
        #region IEnumerable Implementation
        
        IEnumerator IEnumerable.GetEnumerator()
        {
            return new AspnetApplicationsEnumerator(this); 
        }

        #endregion
        
        
        private partial class AspnetApplicationsEnumerator : IEnumerator<AspnetApplications>
        {
            private IReader<AspnetApplications> aspnetApplicationsReader;

            public AspnetApplicationsEnumerator(IReader<AspnetApplications> aspnetApplicationsReader)
            {
                this.aspnetApplicationsReader = aspnetApplicationsReader; 
            }

            #region IEnumerator<AspnetApplications> Members
            
            public AspnetApplications Current
            {
                get { return this.aspnetApplicationsReader.Current; }
            }

            #endregion
            
            #region IDisposable Members
            
            public void Dispose()
            {
                this.aspnetApplicationsReader.Dispose();
            }

            #endregion
            
            #region IEnumerator Members
            
            object IEnumerator.Current
            {
                get { return this.aspnetApplicationsReader.Current; }
            }

            public bool MoveNext()
            {
                return this.aspnetApplicationsReader.Read(); 
            }

            public void Reset()
            {
                throw new Exception("Reset of aspnetapplications reader is not supported."); 
            }

            #endregion
            
        }
    }
}
