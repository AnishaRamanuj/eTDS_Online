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
    public partial class AspnetPersonalizationallusers
    {
        private static IAspnetPersonalizationallusersPersister _DefaultPersister;
        private IAspnetPersonalizationallusersPersister _Persister;
        private Guid _PathId;
        private byte[] _PageSettings;
        private Stream _PageSettingsStream;
        private DateTime _LastUpdatedDate;

        static AspnetPersonalizationallusers()
        {
            // Assign default persister
            _DefaultPersister = new SqlServerAspnetPersonalizationallusersPersister();
        }

        public AspnetPersonalizationallusers()
        {
            // Assign default persister to instance persister
            _Persister = _DefaultPersister; 
        }

        public AspnetPersonalizationallusers(Guid _PathId)
        {
            // Assign default persister to instance persister
            _Persister = _DefaultPersister; 

            // Assign method parameter to private fields
            this._PathId = _PathId; 

            // Call associated retrieve method
            Retrieve();
        }

        public AspnetPersonalizationallusers(DataRow row)
        {
            // Assign default persister to instance persister
            _Persister = _DefaultPersister; 

            // Assign column values to private members
            for (int  i = 0; i < row.Table.Columns.Count; i++)
            {
                switch (row.Table.Columns[i].ColumnName.ToUpper())
                {
                    case "PATHID":
                        if(row[i, DataRowVersion.Current] is Guid)
                        {
                            this.PathId = (Guid)row[i, DataRowVersion.Current]; 
                        }
                        else
                        {
                            this.PathId = new Guid((Byte[])row[i, DataRowVersion.Current]); 
                        }
                        break;
                    
                    case "PAGESETTINGS":
                        this.PageSettings = (Byte[])row[i, DataRowVersion.Current]; 
                        break;
                    
                    case "LASTUPDATEDDATE":
                        this.LastUpdatedDate = Convert.ToDateTime(row[i, DataRowVersion.Current]); 
                        break;
                    
                }
            }
        }

        public static IAspnetPersonalizationallusersPersister DefaultPersister
        {
            get { return _DefaultPersister; }
            set { _DefaultPersister = value; }
        }

        public IAspnetPersonalizationallusersPersister Persister
        {
            get { return _Persister; }
            set { _Persister = value; }
        }

        public Guid PathId
        {
            get { return _PathId; }
            set { _PathId = value; }
        }

        public byte[] PageSettings
        {
            get { return _PageSettings; }
            set { _PageSettings = value; }
        }

        public Stream PageSettingsStream
        {
            get { return _PageSettingsStream; }
            set { _PageSettingsStream = value; }
        }

        public DateTime LastUpdatedDate
        {
            get { return _LastUpdatedDate; }
            set { _LastUpdatedDate = value; }
        }

        public virtual void Clone(AspnetPersonalizationallusers sourceObject)
        {
            // Clone attributes from source object
            this._PathId = sourceObject.PathId; 
            if(sourceObject.PageSettings == null)
            {
                this._PageSettings = null; 
            }
            else
            {
                this._PageSettings = (byte[])sourceObject.PageSettings.Clone(); 
            }
            this._LastUpdatedDate = sourceObject.LastUpdatedDate; 
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

        public static IReader<AspnetPersonalizationallusers> ListAll()
        {
            return _DefaultPersister.ListAll(); 
        }

        public static IReader<AspnetPersonalizationallusers> ListForPathId(Guid pathId)
        {
            return _DefaultPersister.ListForPathId(pathId); 
        }

    }
    
    public partial interface IAspnetPersonalizationallusersPersister
    {
        int Retrieve(AspnetPersonalizationallusers aspnetPersonalizationallusers);
        int Update(AspnetPersonalizationallusers aspnetPersonalizationallusers);
        int Delete(AspnetPersonalizationallusers aspnetPersonalizationallusers);
        int Insert(AspnetPersonalizationallusers aspnetPersonalizationallusers);
        IReader<AspnetPersonalizationallusers> ListAll();
        IReader<AspnetPersonalizationallusers> ListForPathId(Guid pathId);
    }
    
    public partial class SqlServerAspnetPersonalizationallusersPersister : SqlPersisterBase, IAspnetPersonalizationallusersPersister
    {
        public SqlServerAspnetPersonalizationallusersPersister()
        {
        }

        public SqlServerAspnetPersonalizationallusersPersister(string connectionString) : base(connectionString)
        {
        }

        public SqlServerAspnetPersonalizationallusersPersister(SqlConnection connection) : base(connection)
        {
        }

        public SqlServerAspnetPersonalizationallusersPersister(SqlTransaction transaction) : base(transaction)
        {
        }

        public int Retrieve(AspnetPersonalizationallusers aspnetPersonalizationallusers)
        {
            int __rowsAffected = 1;
            
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AspnetPersonalizationallusersGet"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                try
                {
                    // Attach command
                    AttachCommand(sqlCommand);

                    // Add command parameters
                    SqlParameter vPathId = new SqlParameter("@PathId", SqlDbType.UniqueIdentifier);
                    vPathId.Direction = ParameterDirection.InputOutput; 
                    sqlCommand.Parameters.Add(vPathId);
                    SqlParameter vPageSettings = new SqlParameter("@PageSettings", SqlDbType.VarBinary, 2147483647);
                    vPageSettings.Direction = ParameterDirection.Output; 
                    sqlCommand.Parameters.Add(vPageSettings);
                    SqlParameter vLastUpdatedDate = new SqlParameter("@LastUpdatedDate", SqlDbType.DateTime);
                    vLastUpdatedDate.Direction = ParameterDirection.Output; 
                    sqlCommand.Parameters.Add(vLastUpdatedDate);

                    // Set input parameter values
                    SqlServerHelper.SetParameterValue(vPathId, aspnetPersonalizationallusers.PathId);

                    // Execute command
                    sqlCommand.ExecuteNonQuery();

                    try
                    {
                        // Get output parameter values
                        aspnetPersonalizationallusers.PathId = SqlServerHelper.ToGuid(vPathId); 
                        if(aspnetPersonalizationallusers.PageSettingsStream != null)
                            SqlServerHelper.ToStream(vPageSettings, aspnetPersonalizationallusers.PageSettingsStream);
                        else
                            aspnetPersonalizationallusers.PageSettings = SqlServerHelper.ToByteArray(vPageSettings); 
                        
                        aspnetPersonalizationallusers.LastUpdatedDate = SqlServerHelper.ToDateTime(vLastUpdatedDate); 

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

        public int Update(AspnetPersonalizationallusers aspnetPersonalizationallusers)
        {
            int __rowsAffected = 0;
            
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AspnetPersonalizationallusersUpdate"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                // Add command parameters
                SqlParameter vPathId = new SqlParameter("@PathId", SqlDbType.UniqueIdentifier);
                vPathId.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vPathId);
                SqlParameter vPageSettings = new SqlParameter("@PageSettings", SqlDbType.VarBinary, 2147483647);
                vPageSettings.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vPageSettings);
                SqlParameter vLastUpdatedDate = new SqlParameter("@LastUpdatedDate", SqlDbType.DateTime);
                vLastUpdatedDate.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vLastUpdatedDate);

                // Set input parameter values
                SqlServerHelper.SetParameterValue(vPathId, aspnetPersonalizationallusers.PathId);
                if(aspnetPersonalizationallusers.PageSettingsStream != null)
                    SqlServerHelper.SetParameterValue(vPageSettings, aspnetPersonalizationallusers.PageSettingsStream);
                else
                    SqlServerHelper.SetParameterValue(vPageSettings, aspnetPersonalizationallusers.PageSettings);
                SqlServerHelper.SetParameterValue(vLastUpdatedDate, aspnetPersonalizationallusers.LastUpdatedDate);

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

        public int Delete(AspnetPersonalizationallusers aspnetPersonalizationallusers)
        {
            int __rowsAffected = 0;
            
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AspnetPersonalizationallusersDelete"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                try
                {
                    // Attach command
                    AttachCommand(sqlCommand);

                    // Add command parameters
                    SqlParameter vPathId = new SqlParameter("@PathId", SqlDbType.UniqueIdentifier);
                    vPathId.Direction = ParameterDirection.Input; 
                    sqlCommand.Parameters.Add(vPathId);

                    // Set input parameter values
                    SqlServerHelper.SetParameterValue(vPathId, aspnetPersonalizationallusers.PathId);

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

        public int Insert(AspnetPersonalizationallusers aspnetPersonalizationallusers)
        {
            int __rowsAffected = 0;
            
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AspnetPersonalizationallusersInsert"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                // Add command parameters
                SqlParameter vPathId = new SqlParameter("@PathId", SqlDbType.UniqueIdentifier);
                vPathId.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vPathId);
                SqlParameter vPageSettings = new SqlParameter("@PageSettings", SqlDbType.VarBinary, 2147483647);
                vPageSettings.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vPageSettings);
                SqlParameter vLastUpdatedDate = new SqlParameter("@LastUpdatedDate", SqlDbType.DateTime);
                vLastUpdatedDate.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vLastUpdatedDate);

                // Set input parameter values
                SqlServerHelper.SetParameterValue(vPathId, aspnetPersonalizationallusers.PathId);
                if(aspnetPersonalizationallusers.PageSettingsStream != null)
                    SqlServerHelper.SetParameterValue(vPageSettings, aspnetPersonalizationallusers.PageSettingsStream);
                else
                    SqlServerHelper.SetParameterValue(vPageSettings, aspnetPersonalizationallusers.PageSettings);
                SqlServerHelper.SetParameterValue(vLastUpdatedDate, aspnetPersonalizationallusers.LastUpdatedDate);

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

        public IReader<AspnetPersonalizationallusers> ListAll()
        {
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AspnetPersonalizationallusersListAll"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                // Execute command
                SqlDataReader reader = sqlCommand.ExecuteReader(AttachReaderCommand(sqlCommand));

                // Return reader
                return new SqlServerAspnetPersonalizationallusersReader(reader); 
            }
        }

        public IReader<AspnetPersonalizationallusers> ListForPathId(Guid pathId)
        {
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AspnetPersonalizationallusersListForPathId"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                // Add command parameters
                SqlParameter vPathId = new SqlParameter("@PathId", SqlDbType.UniqueIdentifier);
                vPathId.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vPathId);
                
                // Set input parameter values
                SqlServerHelper.SetParameterValue(vPathId, pathId);

                // Execute command
                SqlDataReader reader = sqlCommand.ExecuteReader(AttachReaderCommand(sqlCommand));

                // Return reader
                return new SqlServerAspnetPersonalizationallusersReader(reader); 
            }
        }

    }

    public partial class SqlServerAspnetPersonalizationallusersReader : IReader<AspnetPersonalizationallusers>
    {
        private SqlDataReader sqlDataReader;

        private AspnetPersonalizationallusers _AspnetPersonalizationallusers;

        private int _PathIdOrdinal = -1;
        private int _PageSettingsOrdinal = -1;
        private int _LastUpdatedDateOrdinal = -1;

        public SqlServerAspnetPersonalizationallusersReader(SqlDataReader sqlDataReader)
        {
            this.sqlDataReader = sqlDataReader; 
            for (int  i = 0; i < sqlDataReader.FieldCount; i++)
            {
                string columnName = sqlDataReader.GetName(i);
                columnName = columnName.ToUpper(); 
                switch (columnName)
                {
                    case "PATHID":
                        _PathIdOrdinal = i; 
                        break;
                    
                    case "PAGESETTINGS":
                        _PageSettingsOrdinal = i; 
                        break;
                    
                    case "LASTUPDATEDDATE":
                        _LastUpdatedDateOrdinal = i; 
                        break;
                    
                }
            }
        }

        #region IReader<AspnetPersonalizationallusers> Implementation
        
        public bool Read()
        {
            _AspnetPersonalizationallusers = null; 
            return this.sqlDataReader.Read(); 
        }

        public AspnetPersonalizationallusers Current
        {
            get
            {
                if(_AspnetPersonalizationallusers == null)
                {
                    _AspnetPersonalizationallusers = new AspnetPersonalizationallusers();
                    if(_PathIdOrdinal != -1)
                    {
                        _AspnetPersonalizationallusers.PathId = SqlServerHelper.ToGuid(sqlDataReader, _PathIdOrdinal); 
                    }
                    _AspnetPersonalizationallusers.PageSettings = SqlServerHelper.ToByteArray(sqlDataReader, _PageSettingsOrdinal); 
                    if(_LastUpdatedDateOrdinal != -1)
                    {
                        _AspnetPersonalizationallusers.LastUpdatedDate = SqlServerHelper.ToDateTime(sqlDataReader, _LastUpdatedDateOrdinal); 
                    }
                }
                

                return _AspnetPersonalizationallusers; 
            }
        }

        public void Close()
        {
            sqlDataReader.Close();
        }

        public List<AspnetPersonalizationallusers> ToList()
        {
            List<AspnetPersonalizationallusers> list = new List<AspnetPersonalizationallusers>();
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
        
        #region IEnumerable<AspnetPersonalizationallusers> Implementation
        
        public IEnumerator<AspnetPersonalizationallusers> GetEnumerator()
        {
            return new AspnetPersonalizationallusersEnumerator(this); 
        }

        #endregion
        
        #region IEnumerable Implementation
        
        IEnumerator IEnumerable.GetEnumerator()
        {
            return new AspnetPersonalizationallusersEnumerator(this); 
        }

        #endregion
        
        
        private partial class AspnetPersonalizationallusersEnumerator : IEnumerator<AspnetPersonalizationallusers>
        {
            private IReader<AspnetPersonalizationallusers> aspnetPersonalizationallusersReader;

            public AspnetPersonalizationallusersEnumerator(IReader<AspnetPersonalizationallusers> aspnetPersonalizationallusersReader)
            {
                this.aspnetPersonalizationallusersReader = aspnetPersonalizationallusersReader; 
            }

            #region IEnumerator<AspnetPersonalizationallusers> Members
            
            public AspnetPersonalizationallusers Current
            {
                get { return this.aspnetPersonalizationallusersReader.Current; }
            }

            #endregion
            
            #region IDisposable Members
            
            public void Dispose()
            {
                this.aspnetPersonalizationallusersReader.Dispose();
            }

            #endregion
            
            #region IEnumerator Members
            
            object IEnumerator.Current
            {
                get { return this.aspnetPersonalizationallusersReader.Current; }
            }

            public bool MoveNext()
            {
                return this.aspnetPersonalizationallusersReader.Read(); 
            }

            public void Reset()
            {
                throw new Exception("Reset of aspnetpersonalizationallusers reader is not supported."); 
            }

            #endregion
            
        }
    }
}