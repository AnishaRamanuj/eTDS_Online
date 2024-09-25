using System;
using System.Collections.Generic;
using System.Data;

namespace PayrollProject
{
    public interface IReader<T> : IDisposable, IEnumerable<T>
    {
        T Current { get; }
        bool Read();
        void Close();
        List<T> ToList();
        DataTable ToDataTable();
    }
}