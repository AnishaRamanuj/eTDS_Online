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
    public partial class UserInRoles
    {
        private static IUserInRolesPersister _DefaultPersister;
        private IUserInRolesPersister _Persister;
        private int _RoleID;
        private int _UserID;

        static UserInRoles()
        {
            // Assign default persister
            _DefaultPersister = new SqlServerUserInRolesPersister();
        }

        public UserInRoles()
        {
            // Assign default persister to instance persister
            _Persister = _DefaultPersister; 
        }

        public UserInRoles(DataRow row)
        {
            // Assign default persister to instance persister
            _Persister = _DefaultPersister; 

            // Assign column values to private members
            for (int  i = 0; i < row.Table.Columns.Count; i++)
            {
                switch (row.Table.Columns[i].ColumnName.ToUpper())
                {
                    case "ROLEID":
                        this.RoleID = Convert.ToInt32(row[i, DataRowVersion.Current]); 
                        break;
                    
                    case "USERID":
                        this.UserID = Convert.ToInt32(row[i, DataRowVersion.Current]); 
                        break;
                    
                }
            }
        }

        public static IUserInRolesPersister DefaultPersister
        {
            get { return _DefaultPersister; }
            set { _DefaultPersister = value; }
        }

        public IUserInRolesPersister Persister
        {
            get { return _Persister; }
            set { _Persister = value; }
        }

        public int RoleID
        {
            get { return _RoleID; }
            set { _RoleID = value; }
        }

        public int UserID
        {
            get { return _UserID; }
            set { _UserID = value; }
        }

        public virtual void Clone(UserInRoles sourceObject)
        {
            // Clone attributes from source object
            this._RoleID = sourceObject.RoleID; 
            this._UserID = sourceObject.UserID; 
        }

        public virtual int Insert()
        {
            return _Persister.Insert(this); 
        }

        public static IReader<UserInRoles> ListAll()
        {
            return _DefaultPersister.ListAll(); 
        }

        public static IReader<UserInRoles> ListForUserID(int userID)
        {
            return _DefaultPersister.ListForUserID(userID); 
        }

    }
    
    public partial interface IUserInRolesPersister
    {
        int Insert(UserInRoles userInRoles);
        IReader<UserInRoles> ListAll();
        IReader<UserInRoles> ListForUserID(int userID);
    }
    
    public partial class SqlServerUserInRolesPersister : SqlPersisterBase, IUserInRolesPersister
    {
        public SqlServerUserInRolesPersister()
        {
        }

        public SqlServerUserInRolesPersister(string connectionString) : base(connectionString)
        {
        }

        public SqlServerUserInRolesPersister(SqlConnection connection) : base(connection)
        {
        }

        public SqlServerUserInRolesPersister(SqlTransaction transaction) : base(transaction)
        {
        }

        public int Insert(UserInRoles userInRoles)
        {
            int __rowsAffected = 0;
            
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("UserInRolesInsert"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                // Add command parameters
                SqlParameter vRoleID = new SqlParameter("@RoleID", SqlDbType.Int);
                vRoleID.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vRoleID);
                SqlParameter vUserID = new SqlParameter("@UserID", SqlDbType.Int);
                vUserID.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vUserID);

                // Set input parameter values
                SqlServerHelper.SetParameterValue(vRoleID, userInRoles.RoleID);
                SqlServerHelper.SetParameterValue(vUserID, userInRoles.UserID);

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

        public IReader<UserInRoles> ListAll()
        {
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("UserInRolesListAll"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                // Execute command
                SqlDataReader reader = sqlCommand.ExecuteReader(AttachReaderCommand(sqlCommand));

                // Return reader
                return new SqlServerUserInRolesReader(reader); 
            }
        }

        public IReader<UserInRoles> ListForUserID(int userID)
        {
            // Create command
            using (SqlCommand sqlCommand = new SqlCommand("UserInRolesListForUserID"))
            {
                // Set command type
                sqlCommand.CommandType = CommandType.StoredProcedure; 

                // Add command parameters
                SqlParameter vUserID = new SqlParameter("@UserID", SqlDbType.Int);
                vUserID.Direction = ParameterDirection.Input; 
                sqlCommand.Parameters.Add(vUserID);
                
                // Set input parameter values
                SqlServerHelper.SetParameterValue(vUserID, userID);

                // Execute command
                SqlDataReader reader = sqlCommand.ExecuteReader(AttachReaderCommand(sqlCommand));

                // Return reader
                return new SqlServerUserInRolesReader(reader); 
            }
        }

    }

    public partial class SqlServerUserInRolesReader : IReader<UserInRoles>
    {
        private SqlDataReader sqlDataReader;

        private UserInRoles _UserInRoles;

        private int _RoleIDOrdinal = -1;
        private int _UserIDOrdinal = -1;

        public SqlServerUserInRolesReader(SqlDataReader sqlDataReader)
        {
            this.sqlDataReader = sqlDataReader; 
            for (int  i = 0; i < sqlDataReader.FieldCount; i++)
            {
                string columnName = sqlDataReader.GetName(i);
                columnName = columnName.ToUpper(); 
                switch (columnName)
                {
                    case "ROLEID":
                        _RoleIDOrdinal = i; 
                        break;
                    
                    case "USERID":
                        _UserIDOrdinal = i; 
                        break;
                    
                }
            }
        }

        #region IReader<UserInRoles> Implementation
        
        public bool Read()
        {
            _UserInRoles = null; 
            return this.sqlDataReader.Read(); 
        }

        public UserInRoles Current
        {
            get
            {
                if(_UserInRoles == null)
                {
                    _UserInRoles = new UserInRoles();
                    if(_RoleIDOrdinal != -1)
                    {
                        _UserInRoles.RoleID = SqlServerHelper.ToInt32(sqlDataReader, _RoleIDOrdinal); 
                    }
                    if(_UserIDOrdinal != -1)
                    {
                        _UserInRoles.UserID = SqlServerHelper.ToInt32(sqlDataReader, _UserIDOrdinal); 
                    }
                }
                

                return _UserInRoles; 
            }
        }

        public void Close()
        {
            sqlDataReader.Close();
        }

        public List<UserInRoles> ToList()
        {
            List<UserInRoles> list = new List<UserInRoles>();
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
        
        #region IEnumerable<UserInRoles> Implementation
        
        public IEnumerator<UserInRoles> GetEnumerator()
        {
            return new UserInRolesEnumerator(this); 
        }

        #endregion
        
        #region IEnumerable Implementation
        
        IEnumerator IEnumerable.GetEnumerator()
        {
            return new UserInRolesEnumerator(this); 
        }

        #endregion
        
        
        private partial class UserInRolesEnumerator : IEnumerator<UserInRoles>
        {
            private IReader<UserInRoles> userInRolesReader;

            public UserInRolesEnumerator(IReader<UserInRoles> userInRolesReader)
            {
                this.userInRolesReader = userInRolesReader; 
            }

            #region IEnumerator<UserInRoles> Members
            
            public UserInRoles Current
            {
                get { return this.userInRolesReader.Current; }
            }

            #endregion
            
            #region IDisposable Members
            
            public void Dispose()
            {
                this.userInRolesReader.Dispose();
            }

            #endregion
            
            #region IEnumerator Members
            
            object IEnumerator.Current
            {
                get { return this.userInRolesReader.Current; }
            }

            public bool MoveNext()
            {
                return this.userInRolesReader.Read(); 
            }

            public void Reset()
            {
                throw new Exception("Reset of userinroles reader is not supported."); 
            }

            #endregion
            
        }
    }
}
