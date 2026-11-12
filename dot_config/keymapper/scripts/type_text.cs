using System;
using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;
using System.Windows.Forms;

internal static class TypeText
{
    private const uint WmPaste = 0x0302;
    private const byte VkControl = 0x11;
    private const byte VkShift = 0x10;
    private const byte VkV = 0x56;
    private const uint KeyUp = 0x0002;

    [StructLayout(LayoutKind.Sequential)]
    private struct Rect
    {
        public int Left;
        public int Top;
        public int Right;
        public int Bottom;
    }

    [StructLayout(LayoutKind.Sequential)]
    private struct GuiThreadInfo
    {
        public int Size;
        public int Flags;
        public IntPtr Active;
        public IntPtr Focus;
        public IntPtr Capture;
        public IntPtr MenuOwner;
        public IntPtr MoveSize;
        public IntPtr Caret;
        public Rect CaretRect;
    }

    [DllImport("user32.dll")]
    private static extern IntPtr GetForegroundWindow();

    [DllImport("user32.dll", CharSet = CharSet.Unicode)]
    private static extern int GetClassName(IntPtr window, StringBuilder className, int maxCount);

    [DllImport("user32.dll")]
    private static extern uint GetWindowThreadProcessId(IntPtr window, out uint processId);

    [DllImport("user32.dll")]
    private static extern bool GetGUIThreadInfo(uint threadId, ref GuiThreadInfo info);

    [DllImport("user32.dll")]
    private static extern IntPtr SendMessage(IntPtr window, uint message, IntPtr wParam, IntPtr lParam);

    [DllImport("user32.dll")]
    private static extern void keybd_event(byte virtualKey, byte scanCode, uint flags, UIntPtr extraInfo);

    private static void PasteWithKeyboard(bool shift)
    {
        keybd_event(VkControl, 0, 0, UIntPtr.Zero);
        if (shift)
            keybd_event(VkShift, 0, 0, UIntPtr.Zero);
        keybd_event(VkV, 0, 0, UIntPtr.Zero);
        keybd_event(VkV, 0, KeyUp, UIntPtr.Zero);
        if (shift)
            keybd_event(VkShift, 0, KeyUp, UIntPtr.Zero);
        keybd_event(VkControl, 0, KeyUp, UIntPtr.Zero);
    }

    private static bool IsOfficeEditor(uint processId)
    {
        try
        {
            var processName = Process.GetProcessById((int)processId).ProcessName;
            return processName.Equals("OUTLOOK", StringComparison.OrdinalIgnoreCase)
                || processName.Equals("WINWORD", StringComparison.OrdinalIgnoreCase);
        }
        catch (ArgumentException)
        {
            return false;
        }
    }

    private static T RetryClipboard<T>(Func<T> action)
    {
        for (var attempt = 1; ; attempt++)
        {
            try
            {
                return action();
            }
            catch (ExternalException)
            {
                if (attempt == 10) throw;
                Thread.Sleep(25);
            }
        }
    }

    private static void RetryClipboard(Action action)
    {
        RetryClipboard(() =>
        {
            action();
            return true;
        });
    }

    [STAThread]
    private static int Main(string[] args)
    {
        if (args.Length < 1 || args.Length > 2) return 2;

        var foreground = GetForegroundWindow();
        var foregroundClass = new StringBuilder(256);
        GetClassName(foreground, foregroundClass, foregroundClass.Capacity);
        uint processId;
        var threadId = GetWindowThreadProcessId(foreground, out processId);
        var info = new GuiThreadInfo { Size = Marshal.SizeOf(typeof(GuiThreadInfo)) };
        var target = foreground;
        if (GetGUIThreadInfo(threadId, ref info) && info.Focus != IntPtr.Zero)
            target = info.Focus;

        var text = args.Length == 2 ? args[0] + "\r\n" + args[1] : args[0];
        var previous = RetryClipboard(() => Clipboard.GetDataObject());

        try
        {
            RetryClipboard(() => Clipboard.SetText(text));
            var isWindowsTerminal = foregroundClass.ToString() == "CASCADIA_HOSTING_WINDOW_CLASS";
            var isOfficeEditor = IsOfficeEditor(processId);
            if (isWindowsTerminal || isOfficeEditor)
                PasteWithKeyboard(isWindowsTerminal);
            else
                SendMessage(target, WmPaste, IntPtr.Zero, IntPtr.Zero);
            Thread.Sleep(isOfficeEditor ? 500 : 250);
        }
        finally
        {
            if (previous != null)
                RetryClipboard(() => Clipboard.SetDataObject(previous, true));
            else
                RetryClipboard(() => Clipboard.Clear());
        }

        return 0;
    }
}
