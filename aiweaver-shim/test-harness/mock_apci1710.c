/*
 * Test-only APCI1710.DLL: pretends one APCI-1710 is fitted in PCI slot 5 and
 * accepts every call, logging what AIWeaver asks for. For running AIWeaver on
 * a PC with no card. Never put this on the loom PC.
 *
 * Prototypes follow ADDI's APCI1710.PAS (driver 2246-0404). ConfigureAllModule
 * is undocumented; its six arguments are taken from AIWeaver's call site.
 */
#define WIN32_LEAN_AND_MEAN
#include <windows.h>

#define MOCK_SLOT   5
#define MOCK_HANDLE 0
#define LOG_FIRST_N 25

enum {
    F_CHECK, F_SETBOARD, F_HWINFO, F_CLOSE, F_CONFIG, F_INITDIO,
    F_MEMON, F_CHLON, F_CHLOFF, F_READCHL, F_COUNT
};

static const char *g_names[F_COUNT] = {
    "CheckAndGetPCISlotNumber", "SetBoardInformation", "GetHardwareInformation",
    "CloseBoardHandle", "ConfigureAllModule", "InitDigitalIO",
    "SetDigitalIOMemoryOn", "SetDigitalIOChlOn", "SetDigitalIOChlOff",
    "ReadDigitalIOChlValue"
};

static LONG g_calls[F_COUNT];
static char g_log_path[MAX_PATH];

static void write_line(const char *line, int len)
{
    DWORD written;
    HANDLE h;

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

static void log_call(int fn, const char *args)
{
    char line[256];
    SYSTEMTIME t;
    LONG n = InterlockedIncrement(&g_calls[fn]);

    if (n > LOG_FIRST_N)
        return;
    GetLocalTime(&t);
    write_line(line, wsprintfA(line, "%02u:%02u:%02u.%03u  %s(%s)%s\r\n",
                               t.wHour, t.wMinute, t.wSecond, t.wMilliseconds,
                               g_names[fn], args,
                               n == LOG_FIRST_N ? "  [further calls counted only]" : ""));
}

int __stdcall i_APCI1710_CheckAndGetPCISlotNumber(BYTE *pb_SlotNumberArray)
{
    if (pb_SlotNumberArray)
        pb_SlotNumberArray[0] = MOCK_SLOT;
    log_call(F_CHECK, "-> 1 board");
    return 1;
}

int __stdcall i_APCI1710_SetBoardInformation(BYTE b_SlotNumber, BYTE *pb_BoardHandle)
{
    char a[64];
    if (pb_BoardHandle)
        *pb_BoardHandle = MOCK_HANDLE;
    wsprintfA(a, "slot=%u", b_SlotNumber);
    log_call(F_SETBOARD, a);
    return 0;
}

int __stdcall i_APCI1710_GetHardwareInformation(BYTE b_BoardHandle, LONG *pl_BaseAddress,
                                                BYTE *pb_InterruptNbr, BYTE *pb_SlotNumber)
{
    char a[64];
    if (pl_BaseAddress)
        *pl_BaseAddress = 0xE000;
    if (pb_InterruptNbr)
        *pb_InterruptNbr = 11;
    if (pb_SlotNumber)
        *pb_SlotNumber = MOCK_SLOT;
    wsprintfA(a, "handle=%u", b_BoardHandle);
    log_call(F_HWINFO, a);
    return 0;
}

int __stdcall i_APCI1710_CloseBoardHandle(BYTE b_BoardHandle)
{
    char a[64];
    wsprintfA(a, "handle=%u", b_BoardHandle);
    log_call(F_CLOSE, a);
    return 0;
}

int __stdcall i_APCI1710_ConfigureAllModule(BYTE b_BoardHandle, const char *m0,
                                            const char *m1, const char *m2,
                                            const char *m3, INT *pi_Result)
{
    char a[200];
    if (pi_Result)
        *pi_Result = 0;
    wsprintfA(a, "handle=%u, %.40s, %.40s, %.40s, %.40s", b_BoardHandle,
              m0 ? m0 : "(null)", m1 ? m1 : "(null)", m2 ? m2 : "(null)",
              m3 ? m3 : "(null)");
    log_call(F_CONFIG, a);
    return 0;
}

int __stdcall i_APCI1710_InitDigitalIO(BYTE b_BoardHandle, BYTE b_ModulNbr,
                                       BYTE b_ChannelAMode, BYTE b_ChannelBMode)
{
    char a[64];
    wsprintfA(a, "handle=%u, module=%u, A=%u, B=%u", b_BoardHandle, b_ModulNbr,
              b_ChannelAMode, b_ChannelBMode);
    log_call(F_INITDIO, a);
    return 0;
}

int __stdcall i_APCI1710_SetDigitalIOMemoryOn(BYTE b_BoardHandle, BYTE b_ModulNbr)
{
    char a[64];
    wsprintfA(a, "handle=%u, module=%u", b_BoardHandle, b_ModulNbr);
    log_call(F_MEMON, a);
    return 0;
}

int __stdcall i_APCI1710_SetDigitalIOChlOn(BYTE b_BoardHandle, BYTE b_ModulNbr,
                                           BYTE b_OutputChannel)
{
    char a[64];
    wsprintfA(a, "handle=%u, module=%u, channel=%u", b_BoardHandle, b_ModulNbr,
              b_OutputChannel);
    log_call(F_CHLON, a);
    return 0;
}

int __stdcall i_APCI1710_SetDigitalIOChlOff(BYTE b_BoardHandle, BYTE b_ModulNbr,
                                            BYTE b_OutputChannel)
{
    char a[64];
    wsprintfA(a, "handle=%u, module=%u, channel=%u", b_BoardHandle, b_ModulNbr,
              b_OutputChannel);
    log_call(F_CHLOFF, a);
    return 0;
}

int __stdcall i_APCI1710_ReadDigitalIOChlValue(BYTE b_BoardHandle, BYTE b_ModulNbr,
                                               BYTE b_InputChannel,
                                               BYTE *pb_ChannelStatus)
{
    char a[64];
    if (pb_ChannelStatus)
        *pb_ChannelStatus = 0;
    wsprintfA(a, "handle=%u, module=%u, channel=%u -> 0", b_BoardHandle,
              b_ModulNbr, b_InputChannel);
    log_call(F_READCHL, a);
    return 0;
}

BOOL WINAPI DllMain(HINSTANCE h, DWORD reason, LPVOID reserved)
{
    (void)reserved;
    if (reason == DLL_PROCESS_ATTACH) {
        DWORD n = GetModuleFileNameA(h, g_log_path, MAX_PATH);
        while (n > 0 && g_log_path[n - 1] != '\\')
            n--;
        if (n > 0 && n + sizeof("APCI1710_mock.log") <= MAX_PATH)
            lstrcpyA(g_log_path + n, "APCI1710_mock.log");
        else
            g_log_path[0] = 0;
        DisableThreadLibraryCalls(h);
    } else if (reason == DLL_PROCESS_DETACH) {
        char line[128];
        int i;
        for (i = 0; i < F_COUNT; i++)
            if (g_calls[i])
                write_line(line, wsprintfA(line, "total %s: %ld\r\n", g_names[i],
                                           g_calls[i]));
    }
    return TRUE;
}
