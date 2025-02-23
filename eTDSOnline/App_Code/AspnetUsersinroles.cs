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
    public partial class AspnetUsersinroles
    {
        private static IAspnetUsersinrolesPersister _DefaultPersister;
        private IAspnetUsersinrolesPersister _Persister;
        private Guid _UserId;
        private Guid _RoleId;

        static AspnetUsersinroles()
        {
            // Assign default persister
            _DefaultPersister = new SqlServerAspnetUsersinrolesPersister();
        }

        public AspnetUsersinroles()
        {
            // Assign default persister to instance persister
            _Persister = _DefaultPersister; 
        }

        public AspnetUsersinroles(Guid _UserId, Guid _RoleId)
        {
            // Assign default persister to instance persister
            _Persister = _DefaultPersister; 

            // Assign method parameter to private fields
            this._UserId = _UserId; 
            this._RoleId = _RoleId; 

            // Call associated retrieve method
            Retrieve();
        }

        public AspnetUsersinroles(DataRow row)
        {
            // Assign default persister to instance persister
            _Persister = _DefaultPersister; 

            // Assign column values to private members
            for (int  i = 0; i < row.Table.Columns.Count; i++)
            {
                switch (row.Table.Columns[i].ColumnName.ToUpper())
                {
                    case "USERID":
                        if(row[i, DataRowVersion.Current] is Guid)
                        {
                            this.UserId = (Guid)row[i, DataRowVersion.Current]; 
                        }
                        else
                        {
                            this.UserId = new Guid((Byte[])row[i, DataRowVersion.Current]); 
                        }
                        break;
                    
                    case "ROLEID":
                        if(row[i, DataRowVersion.Current] is Guid)
                        {
                            this.RoleId = (Guid)row[i, DataRowVersion.Current]; 
                        }
                        else
                        {
                            this.RoleId = new Guid((Byte[])row[i, DataRowVersion.Current]); 
                        }
                        break;
                    
                }
            }
        }

        public static IAspnetUsersinrolesPersister DefaultPersister
        {
            get { return _DefaultPersister; }
            set { _DefaultPersister = value; }
        }

        public IAspnetUsersinrolesPersister Persister
        {
            get { return _Persister; }
            set { _Persister = value; }
        }

        public Guid UserId
        {
            get { return _UserId; }
            set { _UserId = value; }
        }

        public Guid RoleId
        {
            get { return _RoleId; }
            set { _RoleId = value; }
        }

        public virtual void Clone(AspnetUsersinroles sourceObject)
        {
            // Clone attributes from source object
            this._UserId = sourceObject.UserId; 
            this._RoleId = sourceObject.RoleId; 
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

        public static IReader<AspnetUsersinroles> ListAll()
        {
            return _DefaultPersister.ListAll(); 
        }

        public static IReader<AspnetUsersinroles> ListForRoleId(Guid roleId)
        {
            return _DefaultPersister.ListForRoleId(roleId); 
        }

        public static IReader<AspnetUsersinroles> ListForUserId(Guid userId)
        {
            return _DefaultPersister.ListForUserId(userId); 
        }

    }
    
    public partial interface IAspnetUsersinrolesPersister
    {
        int Retrieve(AspnetUsersinroles aspnetUsersinroles);
        int Update(AspnetUsersinroles aspnetUsersinroles);
        int Delete(AspnetUsersinroles aspnetUsersinroles);
        int Insert(AspnetUsersinroles aspnetUsersinroles);
        IReader<AspnetUsersinroles> ListAll();
        IReader<AspnetUsersinroles> ListForRoleId(Guid roleId);
        IReader<AspnetUsersinroles> ListForUserId(Guid userId);
    }
    
    public partial class SqlServerAspnetUsersinrolesPersister : SqlPersisterBase, IAspnetUsersinrolesPersister
    {
        public SqlServerAspnetUsersinrolesPersister()
        {
        }

        public SqlServerAspnetUsersinrolesPersister(string connectionString) : base(connectionString)
        {
        }

        public SqlServerAspnetUsersinrolesPersister(SqlConnection connection) : base(connection)
        {
        }

        public SqlServerAspnetUsersinrolesPersister(SqlTransaction transaction) : base(transaction)
        {
        }

        public int Retrieve(AspnetUsersinroles aspnetUsersinroles)
        {
            int __rowsAffected = 1;
            
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AspnetUsersinrolesGet"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                try
                {
                    // Attach command
                    AttachCommand(sqlCommand);

                    // Add command parameters
                    SqlParameter vUserId = new SqlParameter("@UserId", SqlDbType.UniqueIdentifier);
                    vUserId.Direction = ParameterDirection.InputOutput; 
                    sqlCommand.Parameters.Add(vUserId);
                    SqlParameter vRoleId = new SqlParameter("@RoleId", SqlDbType.UniqueIdentifier);
                    vRoleId.Direction = ParameterDirection.InputOutput; 
                    sqlCommand.Parameters.Add(vRoleId);

                    // Set input parameter values
                    SqlServerHelper.SetParameterValue(vUserId, aspnetUsersinroles.UserId);
                    SqlServerHelper.SetParameterValue(vRoleId, aspnetUsersinroles.RoleId);

                    // Execute command
                    sqlCommand.ExecuteNonQuery();

                    try
                    {
                        // Get output parameter values
                        aspnetUsersinroles.UserId = SqlServerHelper.ToGuid(vUserId); 
                        aspnetUsersinroles.RoleId = SqlServerHelper.ToGuid(vRoleId); 

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

        public int Update(AspnetUsersinroles aspnetUsersinroles)
        {
            int __rowsAffected = 0;
            
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AspnetUsersinrolesUpdate"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                // Add command parameters
                SqlParameter vUserId = new SqlParameter("@UserId", SqlDbType.UniqueIdentifier);
                vUserId.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vUserId);
                SqlParameter vRoleId = new SqlParameter("@RoleId", SqlDbType.UniqueIdentifier);
                vRoleId.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vRoleId);

                // Set input parameter values
                SqlServerHelper.SetParameterValue(vUserId, aspnetUsersinroles.UserId);
                SqlServerHelper.SetParameterValue(vRoleId, aspnetUsersinroles.RoleId);

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

        public int Delete(AspnetUsersinroles aspnetUsersinroles)
        {
            int __rowsAffected = 0;
            
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AspnetUsersinrolesDelete"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                try
                {
                    // Attach command
                    AttachCommand(sqlCommand);

                    // Add command parameters
                    SqlParameter vUserId = new SqlParameter("@UserId", SqlDbType.UniqueIdentifier);
                    vUserId.Direction = ParameterDirection.Input; 
                    sqlCommand.Parameters.Add(vUserId);
                    SqlParameter vRoleId = new SqlParameter("@RoleId", SqlDbType.UniqueIdentifier);
                    vRoleId.Direction = ParameterDirection.Input; 
                    sqlCommand.Parameters.Add(vRoleId);

                    // Set input parameter values
                    SqlServerHelper.SetParameterValue(vUserId, aspnetUsersinroles.UserId);
                    SqlServerHelper.SetParameterValue(vRoleId, aspnetUsersinroles.RoleId);

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

        public int Insert(AspnetUsersinroles aspnetUsersinroles)
        {
            int __rowsAffected = 0;
            
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AspnetUsersinrolesInsert"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                // Add command parameters
                SqlParameter vUserId = new SqlParameter("@UserId", SqlDbType.UniqueIdentifier);
                vUserId.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vUserId);
                SqlParameter vRoleId = new SqlParameter("@RoleId", SqlDbType.UniqueIdentifier);
                vRoleId.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vRoleId);

                // Set input parameter values
                SqlServerHelper.SetParameterValue(vUserId, aspnetUsersinroles.UserId);
                SqlServerHelper.SetParameterValue(vRoleId, aspnetUsersinroles.RoleId);

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

        public IReader<AspnetUsersinroles> ListAll()
        {
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AspnetUsersinrolesListAll"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                // Execute command
                SqlDataReader reader = sqlCommand.ExecuteReader(AttachReaderCommand(sqlCommand));

                // Return reader
                return new SqlServerAspnetUsersinrolesReader(reader); 
            }
        }

        public IReader<AspnetUsersinroles> ListForRoleId(Guid roleId)
        {
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AspnetUsersinrolesListForRoleId"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                // Add command parameters
                SqlParameter vRoleId = new SqlParameter("@RoleId", SqlDbType.UniqueIdentifier);
                vRoleId.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vRoleId);
                
                // Set input parameter values
                SqlServerHelper.SetParameterValue(vRoleId, roleId);

                // Execute command
                SqlDataReader reader = sqlCommand.ExecuteReader(AttachReaderCommand(sqlCommand));

                // Return reader
                return new SqlServerAspnetUsersinrolesReader(reader); 
            }
        }

        public IReader<AspnetUsersinroles> ListForUserId(Guid userId)
        {
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("AspnetUsersinrolesListForUserId"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                // Add command parameters
                SqlParameter vUserId = new SqlParameter("@UserId", SqlDbType.UniqueIdentifier);
                vUserId.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vUserId);
                
                // Set input parameter values
                SqlServerHelper.SetParameterValue(vUserId, userId);

                // Execute command
                SqlDataReader reader = sqlCommand.ExecuteReader(AttachReaderCommand(sqlCommand));

                // Return reader
                return new SqlServerAspnetUsersinrolesReader(reader); 
            }
        }

    }

    public partial class SqlServerAspnetUsersinrolesReader : IReader<AspnetUsersinroles>
    {
        private SqlDataReader sqlDataReader;

        private AspnetUsersinroles _AspnetUsersinroles;

        private int _UserIdOrdinal = -1;
        private int _RoleIdOrdinal = -1;

        public SqlServerAspnetUsersinrolesReader(SqlDataReader sqlDataReader)
        {
            this.sqlDataReader = sqlDataReader; 
            for (int  i = 0; i < sqlDataReader.FieldCount; i++)
            {
                string columnName = sqlDataReader.GetName(i);
                columnName = columnName.ToUpper(); 
                switch (columnName)
                {
                    case "USERID":
                        _UserIdOrdinal = i; 
                        break;
                    
                    case "ROLEID":
                        _RoleIdOrdinal = i; 
                        break;
                    
                }
            }
        }

        #region IReader<AspnetUsersinroles> Implementation
        
        public bool Read()
        {
            _AspnetUsersinroles = null; 
            return this.sqlDataReader.Read(); 
        }

        public AspnetUsersinroles Current
        {
            get
            {
                if(_AspnetUsersinroles == null)
                {
                    _AspnetUsersinroles = new AspnetUsersinroles();
                    if(_UserIdOrdinal != -1)
                    {
                        _AspnetUsersinroles.UserId = SqlServerHelper.ToGuid(sqlDataReader, _UserIdOrdinal); 
                    }
                    if(_RoleIdOrdinal != -1)
                    {
                        _AspnetUsersinroles.RoleId = SqlServerHelper.ToGuid(sqlDataReader, _RoleIdOrdinal); 
                    }
                }
                

                return _AspnetUsersinroles; 
            }
        }

        public void Close()
        {
            sqlDataReader.Close();
        }

        public List<AspnetUsersinroles> ToList()
        {
            List<AspnetUsersinroles> list = new List<AspnetUsersinroles>();
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
        
        #region IEnumerable<AspnetUsersinroles> Implementation
        
        public IEnumerator<AspnetUsersinroles> GetEnumerator()
        {
            return new AspnetUsersinrolesEnumerator(this); 
        }

        #endregion
        
        #region IEnumerable Implementation
        
        IEnumerator IEnumerable.GetEnumerator()
        {
            return new AspnetUsersinrolesEnumerator(this); 
        }

        #endregion
        
        
        private partial class AspnetUsersinrolesEnumerator : IEnumerator<AspnetUsersinroles>
        {
            private IReader<AspnetUsersinroles> aspnetUsersinrolesReader;

            public AspnetUsersinrolesEnumerator(IReader<AspnetUsersinroles> aspnetUsersinrolesReader)
            {
                this.aspnetUsersinrolesReader = aspnetUsersinrolesReader; 
            }

            #region IEnumerator<AspnetUsersinroles> Members
            
            public AspnetUsersinroles Current
            {
                get { return this.aspnetUsersinrolesReader.Current; }
            }

            #endregion
            
            #region IDisposable Members
            
            public void Dispose()
            {
                this.aspnetUsersinrolesReader.Dispose();
            }

            #endregion
            
            #region IEnumerator Members
            
            object IEnumerator.Current
            {
                get { return this.aspnetUsersinrolesReader.Current; }
            }

            public bool MoveNext()
            {
                return this.aspnetUsersinrolesReader.Read(); 
            }

            public void Reset()
            {
                throw new Exception("Reset of aspnetusersinroles reader is not supported."); 
            }

            #endregion
            
        }
    }
}
