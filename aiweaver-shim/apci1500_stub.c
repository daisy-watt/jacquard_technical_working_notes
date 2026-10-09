/*
 * APCI1500.DLL stand-in for AIWeaver.exe on a machine that only has an
 * ADDI-DATA APCI-1710.
 *
 * AIWeaver statically imports both APCI1500.DLL and APCI1710.DLL, so Windows
 * refuses to start it unless both DLLs exist and export every imported name.
 * The program then probes each board family and picks its operating mode from
 * how many of each it found:
 *
 *   1x APCI-1710, 0x APCI-1500, Modules 1..3  ->  mode 0x20 (1710 only)
 *
 * In that mode every loom I/O call goes to APCI1710.DLL and the 1500 entry
 * points below are never reached, provided CheckAndGetPCISlotNumber reports
 * zero boards.
 *
 * Signatures come from the call sites in AIWeaver.exe (Delphi, stdcall, byte
 * arguments widened to 32-bit pushes). The argument COUNT is what must be
 * exact: stdcall callees pop their own arguments, so a wrong count corrupts
 * the caller's stack.
 */
#define WIN32_LEAN_AND_MEAN
#include <windows.h>

#define STUB_ERROR (-1)

static char g_log_path[MAX_PATH];

static void log_call(const char *fn)
{
    char line[160];
    DWORD written;
    HANDLE h;
    int len;
    SYSTEMTIME t;

    GetLocalTime(&t);
    len = wsprintfA(line, "%04u-%02u-%02u %02u:%02u:%02u.%03u  %s\r\n",
                    t.wYear, t.wMonth, t.wDay, t.wHour, t.wMinute, t.wSecond,
                    t.wMilliseconds, fn);
    OutputDebugStringA(line);

    if (!g_log_path[0])
        return;
    h = CreateFileA(g_log_path, FILE_APPEND_DATA, FILE_SHARE_READ, NULL,
                    OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
    if (h == INVALID_HANDLE_VALUE)
        return;
    WriteFile(h, line, (DWORD)len, &written, NULL);
    CloseHandle(h);
}

/* Returns the number of APCI-1500 boards found. Zero steers AIWeaver onto the
   1710-only configuration. */
int __stdcall i_APCI1500_CheckAndGetPCISlotNumber(BYTE *pb_SlotNumberArray)
{
    (void)pb_SlotNumberArray;
    log_call("CheckAndGetPCISlotNumber -> 0 boards");
    return 0;
}

int __stdcall i_APCI1500_SetBoardInformation(BYTE b_SlotNumber,
                                             BYTE *pb_BoardHandle)
{
    (void)b_SlotNumber;
    (void)pb_BoardHandle;
    log_call("SetBoardInformation (unexpected)");
    return STUB_ERROR;
}

int __stdcall i_APCI1500_CloseBoardHandle(BYTE b_BoardHandle)
{
    (void)b_BoardHandle;
    log_call("CloseBoardHandle (unexpected)");
    return STUB_ERROR;
}

int __stdcall i_APCI1500_Read1DigitalInput(BYTE b_BoardHandle, BYTE b_Channel,
                                           BYTE *pb_ChannelValue)
{
    (void)b_BoardHandle;
    (void)b_Channel;
    (void)pb_ChannelValue;
    log_call("Read1DigitalInput (unexpected)");
    return STUB_ERROR;
}

int __stdcall i_APCI1500_Set1DigitalOutputOn(BYTE b_BoardHandle,
                                             BYTE b_Channel)
{
    (void)b_BoardHandle;
    (void)b_Channel;
    log_call("Set1DigitalOutputOn (unexpected)");
    return STUB_ERROR;
}

int __stdcall i_APCI1500_Set1DigitalOutputOff(BYTE b_BoardHandle,
                                              BYTE b_Channel)
{
    (void)b_BoardHandle;
    (void)b_Channel;
    log_call("Set1DigitalOutputOff (unexpected)");
    return STUB_ERROR;
}

int __stdcall i_APCI1500_Set16DigitalOutputOn(BYTE b_BoardHandle,
                                              DWORD dw_Value)
{
    (void)b_BoardHandle;
    (void)dw_Value;
    log_call("Set16DigitalOutputOn (unexpected)");
    return STUB_ERROR;
}

int __stdcall i_APCI1500_SetOutputMemoryOn(BYTE b_BoardHandle)
{
    (void)b_BoardHandle;
    log_call("SetOutputMemoryOn (unexpected)");
    return STUB_ERROR;
}

int __stdcall i_APCI1500_SetOutputMemoryOff(BYTE b_BoardHandle)
{
    (void)b_BoardHandle;
    log_call("SetOutputMemoryOff (unexpected)");
    return STUB_ERROR;
}

BOOL WINAPI DllMain(HINSTANCE h, DWORD reason, LPVOID reserved)
{
    (void)reserved;
    if (reason == DLL_PROCESS_ATTACH) {
        DWORD n = GetModuleFileNameA(h, g_log_path, MAX_PATH);
        while (n > 0 && g_log_path[n - 1] != '\\')
            n--;
        if (n > 0 && n + sizeof("APCI1500_stub.log") <= MAX_PATH)
            lstrcpyA(g_log_path + n, "APCI1500_stub.log");
        else
            g_log_path[0] = 0;
        DisableThreadLibraryCalls(h);
    }
    return TRUE;
}
