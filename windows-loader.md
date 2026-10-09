# Windows loader and the 1500 stub

These notes were worked out after months of treating the 1500 error as “wrong software version”. That reading came from the dialog text, not from a spec. The loader rule below is inferred from the PE import table and from what Windows actually showed.

## The rule that blocked every early start

`AIWeaver.exe` is a 32-bit Delphi PE. Its import table names both `APCI1500.DLL` and `APCI1710.DLL`. The Windows loader:

1. Walks that table **before** any program code runs
2. Requires each DLL to exist on the search path
3. Requires every imported **export name** to exist in that DLL
4. Stops at the **first** failure and reports only that name

So “Unable to locate APCI1500.DLL” does not mean “this program is a 1500 build”. It means “I have not even started AIWeaver yet”.

Search path used on this machine (typical Win2000):

1. Folder of `AIWeaver.exe` (`C:\Program Files\AIWeaver`)
2. Current directory (the shortcut’s **Start in**)
3. `C:\WINNT\system32`
4. `C:\WINNT\system`
5. `C:\WINNT`
6. `PATH`

## Why renaming the 1710 DLL failed

`APCI1710.DLL` exports `i_APCI1710_*`. AIWeaver’s 1500 imports are `i_APCI1500_*` (nine names). A renamed file still does not provide `i_APCI1500_SetOutputMemoryOff` and the rest. The error moves from “DLL not found” to “entry point not found”.

## What the stand-in does

Source: [`aiweaver-shim/apci1500_stub.c`](aiweaver-shim/apci1500_stub.c)

| Export | Behaviour |
| --- | --- |
| `i_APCI1500_CheckAndGetPCISlotNumber` | Returns **0**, logs `CheckAndGetPCISlotNumber -> 0 boards` |
| The other eight | Log `(unexpected)` and return `-1` |

A clean log is **only** the `0 boards` line (it may appear more than once per start). Any `(unexpected)` line means AIWeaver tried to drive a 1500 that is not there. Stop and do not weave.

On the loom PC the log is `APCI1500_stub.log` next to the DLL. Observed in October 2026: only `0 boards`. That is success for the stub.

Calling convention is **stdcall** (Delphi). Argument **count** must match; the callee pops the stack.

The stub is built for Windows 2000 (`x86`, `i686`, `/subsystem:windows,5.0`, no UCRT). See `aiweaver-shim/build.sh`.

## After the stub, the next missing name

Once `APCI1500.DLL` existed, the loader reported `APCI1710.DLL`. Same rule, next row in the import table. Copying the real ADDI `APCI1710.DLL` (about 137 KB) into the AIWeaver folder cleared that.

`APCI1710.DLL` then needs:

- `addikern.dll`
- `ADDI_INT.dll`

Those come from the ADDIREG / 1710 package, usually under `C:\WINNT\system32` or `C:\ADDIDATA`. If they are missing, Windows fails to load the 1710 DLL and AIWeaver will not start.

Finding a board is a **later** step. See [addi-drivers.md](addi-drivers.md).

## Local proof

A mock `APCI1710.DLL` that reports “one board, slot 5” was enough to start the real `AIWeaver.exe` on a machine with no PCI card. The 1500 stub was only asked for its count. The 1710 mock received `ConfigureAllModule(DGI_IO.CFG × 4)`, `InitDigitalIO` on modules 0–3, and `SetDigitalIOMemoryOn`.

![AIWeaver main window in Digital I/O mode (local mock)](images/aiweaver-digital-io.png)

![Open pattern file: Actrom `*.p`](images/aiweaver-open-pattern.png)
