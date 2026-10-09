# Concordia / AIWeaver

Technical notes for restoring a **Martel Catala / Albany International Concordia** jacquard under **AIWeaver** on a Windows 2000 PC with an **ADDI-DATA APCI-1710**.

This is **ad-hoc reverse engineering**, not a vendor manual. The project started from a dead loom, no PC or data cards, a random disc with "AIWeaver" on it in permanent marker, and scattered notes, starting about one to two years into learning to code... now im about 5 years in. The path was trial and error: a Windows 2000 VM in **late 2024 to early 2025** (Internet Archive ISO), tried first because it was more affordable and easier to keep long term, then a physical old PC and a real APCI-1710 once the proprietary PCI card would not virtualize. What I “know” below was inferred from error dialogs, the EXE, ADDIREG, and the machine, and some of it was wrong for a long time. Read the [recovery log](recovery.md) for that chronology.

AdaCAD is the planned design tool. Its source is **not** in this repo. 

## Knowledge map

Topics that had to be learned before the next step would move. Detail lives in the linked note.

| To get past | Topics | Why |
| --- | --- | --- |
| Booting the controller | Virtualisation, ISO images, 32-bit Windows 2000 | AIWeaver and the ADDI drivers are built for that OS. [Recovery](recovery.md) |
| The VM stall | PCI devices, serial passthrough | A guest can be given a COM port. This loom’s I/O is a PCI card the guest never saw. [Recovery](recovery.md) |
| The compressor | Supply pressure, flow, air treatment | A 3000 PSI figure was read as industrial plant. The heads need studio air matched to the valves. [Recovery](recovery.md) |
| The wiring drawings | How a schematic set is organised: index, supplies, connectors, pin table | The scan is a 3-head electrical box. Its index is a 15 V supply, a 5 V supply, the APCI-1710 plug, interface modules 1–3, and the cylinder sensor. [Architecture](architecture.md) |
| Cabinet power | DC rails separate from the PC | The power sheet is 20 V in, EWS 300/15V supplies, and 24 V. The card takes power from the PC. A correct loom supply is still open. [Architecture](architecture.md) |
| The 50-pin | Clocked digital lines | Clock, data, and feedback per module, plus stop, fault, and the cylinder. That is the loom side of Digital I/O. [Architecture](architecture.md) |
| Head and harness sheets | Sett (ends per cm), which harness holes are used | Those sheets describe the MJB heads. They are not the wiring of this 4-head machine. [Architecture](architecture.md) |
| “Wrong software version” | How Windows loads a program: import tables, DLL search order | The missing `APCI1500.DLL` dialog appears before AIWeaver runs. [Loader](windows-loader.md) |
| Digital I/O staying grey | Plug and Play, and a separate vendor board list | Device Manager can see the card while ADDIREG’s list is empty. [Drivers](addi-drivers.md) |
| Modules and 2304 | Jacquard heads, hooks, harness tie, lift plan | The scan is drawn as 3 heads. This machine is 4 × 576. Same 2304 hooks, different dressing. [Config](aiweaver-config.md), [formats](file-formats.md) |
| A new design | Binary file layouts, bit order | The loom loads Actrom. AdaCAD does not write it yet. [AdaCAD plan](adacad.md) |
| A first weave | Timing, feedback, sensors, loom power | The program can be up while air, the cylinder, and the supply are still wrong. [Architecture](architecture.md) |

## Status log table (last updated October 2026)

| Item | State |
| --- | --- |
| Fix the cable damaged in the initial move | Yes |
| Acquire a Windows 2000 ISO | Yes |
| Set up a working OS, virtual or physical | Yes |
| Acquire and understand the correct air compressor for the pneumatics | Yes (not purchased perm one yet) |
| Acquire an APCI-1710 ADDI-DATA card | Yes |
| APCI-1710 visible in Device Manager | Yes (`ADDI-DATA GmbH APCI-1710`) |
| Board registered in ADDIREG | Yes (PCI slot **131**) |
| AIWeaver starts on the loom PC | Yes |
| Loom comms | **Digital I/O cards** |
| Modules | **4** (four heads, four cable sets) |
| Colour module | **No** |
| Heddles / yarns | **2304** (`4 × 576`) |
| First weave under AIWeaver | Not done yet |
| Correct supply of power | No |

## Read in this order

1. [System architecture](architecture.md): what is connected to what, including the schematic scan
2. [Recovery log](recovery.md): chronological: VM first, then hardware, April 2026 card, then the software unblocking
3. [Windows loader and the 1500 stub](windows-loader.md): why it looked like a “wrong software version”
4. [ADDI driver stack](addi-drivers.md): Device Manager vs ADDIREG vs SET1710 vs DLL search
5. [AIWeaver configuration](aiweaver-config.md): Digital I/O, registry, modules
6. [File formats](file-formats.md): Actrom `.p` / `.S01` and the `.tie` harness map
7. [AdaCAD plan](adacad.md): how to design on AdaCAD and reach AIWeaver

## Source in this repo

| Path | What it is |
| --- | --- |
| [`aiweaver-shim/apci1500_stub.c`](aiweaver-shim/apci1500_stub.c) | 1500 stand-in |
| [`aiweaver-shim/disk/`](aiweaver-shim/disk/) | Files burned to the shim CD |
| [`aiweaver-shim/test-harness/`](aiweaver-shim/test-harness/) | Mock 1710 + local AIWeaver runs |
| [`aiweaver-shim/addi-cd/`](aiweaver-shim/addi-cd/) | Extracted ADDI driver / headers |
| [`aiweaver-shim/schematics/`](aiweaver-shim/schematics/) | Schematic scan pages |


Pin 38 on the 1710 drives “stop the loom” and the cylinder valves. The PCI card itself is powered by the PC, not by the loom.
