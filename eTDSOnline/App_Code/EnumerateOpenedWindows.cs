using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.InteropServices;
using System.Text;
using System.Diagnostics;

/// <summary>
/// Summary description for EnumerateOpenedWindows
/// </summary>
public class EnumerateOpenedWindows
{
    const int MAXTITLE = 255;

    private static string closewindow;

    private static List<string> lstTitles;

    private delegate bool EnumDelegate(IntPtr hWnd, int lParam);

    [DllImport("user32.dll", EntryPoint = "EnumDesktopWindows",
    ExactSpelling = false, CharSet = CharSet.Auto, SetLastError = true)]
    private static extern bool EnumDesktopWindows(IntPtr hDesktop,
    EnumDelegate lpEnumCallbackFunction, IntPtr lParam);

    [DllImport("user32.dll", EntryPoint = "GetWindowText",
    ExactSpelling = false, CharSet = CharSet.Auto, SetLastError = true)]
    private static extern int _GetWindowText(IntPtr hWnd,
    StringBuilder lpWindowText, int nMaxCount);

    [DllImport("user32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    static extern bool IsWindowVisible(IntPtr hWnd);


    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    private static extern IntPtr SendMessage(IntPtr hWnd, UInt32 Msg, IntPtr wParam, IntPtr lParam);

    private const UInt32 WM_CLOSE = 0x0010;

    static void CloseWindow(IntPtr hwnd)
    {
        SendMessage(hwnd, WM_CLOSE, IntPtr.Zero, IntPtr.Zero);
    }



    private static bool EnumWindowsProc(IntPtr hWnd, int lParam)
    {
        string strTitle = GetWindowText(hWnd);
        if (strTitle != "" & IsWindowVisible(hWnd)) //
        {
            if (strTitle == closewindow)
            {
                CloseWindow(hWnd);
                lstTitles.Add(strTitle);
            }
        }
        return true;
    }

    /// <summary>
    /// Return the window title of handle
    /// </summary>
    /// <param name="hWnd"></param>
    /// <returns></returns>
    public static string GetWindowText(IntPtr hWnd)
    {
        StringBuilder strbTitle = new StringBuilder(MAXTITLE);
        int nLength = _GetWindowText(hWnd, strbTitle, strbTitle.Capacity + 1);
        strbTitle.Length = nLength;
        return strbTitle.ToString();
    }

    /// <summary>
    /// Return titles of all visible windows on desktop
    /// </summary>
    /// <returns>List of titles in type of string</returns>
    private static string[] GetDesktopWindowsTitles()
    {
        lstTitles = new List<string>();
        EnumDelegate delEnumfunc = new EnumDelegate(EnumWindowsProc);
        bool bSuccessful = EnumDesktopWindows(IntPtr.Zero, delEnumfunc, IntPtr.Zero); //for current desktop

        if (bSuccessful)
        {
            return lstTitles.ToArray();
        }
        else
        {
            // Get the last Win32 error code
            int nErrorCode = Marshal.GetLastWin32Error();
            string strErrMsg = String.Format("EnumDesktopWindows failed with code {0}.", nErrorCode);
            throw new Exception(strErrMsg);
        }
    }

    public string[] ret(string closewindowname)
    {
        closewindow = closewindowname;
        string[] strWindowsTitles = GetDesktopWindowsTitles();
        return strWindowsTitles;
    }



   

}

public class ParentPid
{
    public void dMain()
    {
        var childPidToParentPid = GetAllProcessParentPids();
        int currentProcessId = Process.GetCurrentProcess().Id;// ProcessName("javaw").id;

        Console.WriteLine("Current Process ID: " + currentProcessId);
        Console.WriteLine("Parent Process ID: " + childPidToParentPid[currentProcessId]);
    }

    public static Dictionary<int, int> GetAllProcessParentPids()
    {
        var childPidToParentPid = new Dictionary<int, int>();

        var processCounters = new SortedDictionary<string, PerformanceCounter[]>();
        var category = new PerformanceCounterCategory("Process");

        // As the base system always has more than one process running, 
        // don't special case a single instance return.
        var instanceNames = category.GetInstanceNames();
        foreach (string t in instanceNames)
        {
            try
            {
                processCounters[t] = category.GetCounters(t);
            }
            catch (InvalidOperationException)
            {
                // Transient processes may no longer exist between 
                // GetInstanceNames and when the counters are queried.
            }
        }

        foreach (var kvp in processCounters)
        {
            int childPid = -1;
            int parentPid = -1;

            foreach (var counter in kvp.Value)
            {
                if ("ID Process".CompareTo(counter.CounterName) == 0)
                {
                    childPid = (int)(counter.NextValue());
                }
                else if ("Creating Process ID".CompareTo(counter.CounterName) == 0)
                {
                    parentPid = (int)(counter.NextValue());
                }
            }

            if (childPid != -1 && parentPid != -1)
            {
                childPidToParentPid[childPid] = parentPid;
            }
        }

        return childPidToParentPid;
    }
}