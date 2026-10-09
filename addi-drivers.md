# ADDI driver stack

The 1710 software is several pieces that land in different folders. “The driver is installed” can mean any one of them.

## Pieces

| Piece | Typical place | Job |
| --- | --- | --- |
| Kernel / PnP | `ADDIKERN.SYS`, `ADDI_PCI.SYS` | Device Manager binds the PCI ID |
| User-mode kernel bridge | `addikern.dll`, `ADDI_INT.dll` | What `APCI1710.DLL` actually imports |
| Board programming DLL | `APCI1710.DLL` (~137 KB) | `CheckAndGetPCISlotNumber` and I/O |
| Registration list | ADDIREG.exe | Table SET1710 / AIWeaver consult |
| Card setup utility | `C:\ADDIDATA\32BIT\PCI1710\Set1710\SET1710.exe` | Show boards; program FPGA modules |
| Module config files | `Set1710\cfg\`, also `DGI_IO.CFG` next to AIWeaver | Digital I/O personality |

AIWeaver also needs `DGI_IO.CFG` in its **Start in** folder. It passes that bare filename into `ConfigureAllModule` four times (one per function module on the card).

## Where files actually were

On the salvaged patchwork old machine PC tower:

```
C:\ADDIDATA\32BIT\PCI1710\
  C\            headers / libs
  Delphi\
  Set1710\      SET1710.exe, cfg\, doc\
  VB\
```

The 1710 **installer** (ADDI CD → APCI1710 → Windows XP/2000) in maintenance mode asks *“completely remove the selected application…?”* That means the **product is already registered**, not that `APCI1710.DLL` is in `C:\Program Files\AIWeaver`. **Cancel.** Do not uninstall.

`APCI1710.DLL` had to be **copied** into `C:\Program Files\AIWeaver`. It was not there by default. Search `C:` (and the ADDI CD `APCI1710_Dll` folder) rather than re-running setup.

ADDIREG.exe was found under `C:\WINNT` (search result: Addireg, ~528 KB). Opening the **CD** “Registration Software” tab launches InstallShield **Modify / Repair / Remove**. That is setup, not the program. Cancel unless you intend **Repair**.

## Device Manager vs SET1710 vs ADDIREG

Observed in October 2026:

| Check | Result |
| --- | --- |
| Device Manager → ADDI-DATA GmbH PCI board(s) | `ADDI-DATA GmbH APCI-1710`, no yellow mark |
| SET1710 → APCI-1710 configuration | **No APCI-1710 found** |
| ADDIREG board list | **Empty** |
| After Insert → APCI1710 | Slot **131** |
| After Set / Save / Test, then SET1710 | Board present |
| AIWeaver Digital I/O | Became selectable |

Slot 131 is ADDI’s encoded PCI slot, not a chassis hole.

Yellow entries under **Other devices** (Ethernet, generic PCI, USB) are unrelated missing drivers. Ignore them.

## How to register a PCI 1710 (the step that unblocked us)

Need Administrator rights.

1. Run `ADDIREG.EXE` from the hard disk, not the CD wizard
2. **Insert**
3. Choose **APCI-1710** (or “Insert all ADDI-DATA PCI board(s)” if offered)
4. **OK**: bus/slot and IRQ fill themselves. Do not invent addresses
5. **Set**
6. **Save**
7. **Test registration**: want **OK**
8. **Quit**: reboot if asked

Do not use **Deinstall registration** or **Clear**.

## SET1710

`SET1710` is the official “is the API alive?” tool.

1. `C:\ADDIDATA\32BIT\PCI1710\Set1710\SET1710.exe`
2. Splash: **APCI-1710 configuration** / About / Exit
3. Click **APCI-1710 configuration**
4. A board/slot list is success; “no APCI-1710 found” is the empty ADDIREG problem

Do not click Configure / Program until you intend to rewrite the card’s module personality. AIWeaver already loads `DGI_IO.CFG` when Digital I/O is selected.

## Loom power

The 1710 is a PCI card inside the PC. Mainframe / loom power off does **not** hide it from Device Manager, ADDIREG, SET1710, or AIWeaver. Keep the loom off until you mean to weave.
