# System architecture

The installation is a **PC-controlled jacquard**. AIWeaver on Windows 2000 is the loom controller. Pattern CAD (historically Scotweave / Pointcarré / Albany DAO; planned: AdaCAD) is a separate step that only produces files.

This diagram is a **reconstruction**. Nobody handed over a current system drawing. It was assembled from the schematic scan, the ADDI CD, `AIWeaver.exe`, and what is actually plugged in. In **late 2024 to early 2025** the first plan was to run the old OS in a VM, because that looked more affordable and maintainable. That died on the PCI data card. The PC in this picture is the salvaged patchwork old machine PC tower, a real Windows 2000 tower built so the card could sit in a real slot. A virtualised controller can still be a later upgrade. See [recovery.md](recovery.md).

## Whole system

```mermaid
flowchart TB
  subgraph cad [Design machine - any OS]
    AdaCAD["AdaCAD / Scotweave / Pointcarré / DAO"]
    Actrom["Actrom pair\nSname.P + Dname.S01"]
    AdaCAD --> Actrom
  end

  subgraph pc [Loom PC - Windows 2000 - salvaged patchwork old machine PC tower]
    AIW["AIWeaver.exe"]
    Tie["Default.tie\n2304 heddles"]
    Stub["APCI1500.DLL\nstand-in: 0 boards"]
    Dll1710["APCI1710.DLL"]
    Kern["addikern.dll +\nADDI_INT.dll"]
    Sys["ADDIKERN.SYS /\nADDI_PCI.SYS"]
    Card["APCI-1710 PCI card\n50-pin"]

    Actrom --> AIW
    Tie --> AIW
    AIW --> Stub
    AIW --> Dll1710
    Dll1710 --> Kern
    Kern --> Sys
    Sys --> Card
  end

  subgraph loom [Loom cabinet]
    I1["Head 1 interface"]
    I2["Head 2 interface"]
    I3["Head 3 interface"]
    I4["Head 4 interface"]
    H1["MJB head 1"]
    H2["MJB head 2"]
    H3["MJB head 3"]
    H4["MJB head 4"]
    Card -->|"clock / data / feedback / TOP\n+ sensors, pedal, stop"| I1
    Card --> I2
    Card --> I3
    Card --> I4
    I1 --> H1
    I2 --> H2
    I3 --> H3
    I4 --> H4
  end
```

The drawings call those interface boxes **ICR** (*interface de commande ratière*, Martel Catala). On the machine they are the boxes with the 25-pin plugs and the 5 V / 15 V / DATA / CLOCK / FEEDBACK / TOP LEDs. There are **four**, one per head.

## Schematic scan

Pages: [`aiweaver-shim/schematics/`](aiweaver-shim/schematics/). This is a **3-head electrical box**, not a drawing of this 4-head machine.

| Sheets | Contents |
| --- | --- |
| Index | 15 V supply, 5 V supply, APCI-1710 connector, jacquard interface modules 1–3, cylinder sensor |
| 15 V power | 20 V in, EWS 300/15V supplies, 24 V |
| 50-pin | Clock, data, and feedback per module, plus stop, fault, and the cylinder |
| Later sheets | MJB heads, ends per cm, which harness holes are used |

Use the scan for signals and supplies. Use the live machine for the head count: 4 × 576.

## Two ADDI stacks

Windows can “see” the card in two different ways. Both have to work.

```mermaid
flowchart LR
  PCI["PCI slot\nAPCI-1710"]

  subgraph pnp [Plug and Play]
    DM["Device Manager\nADDI-DATA GmbH APCI-1710"]
    PCI --> DM
  end

  subgraph api [User-mode API]
    REG["ADDIREG board list"]
    SET["SET1710"]
    AIW["AIWeaver"]
    REG --> SET
    REG --> AIW
    PCI --> REG
  end
```

| Stack | What it answers | If it fails |
| --- | --- | --- |
| Device Manager | Is there a PCI device and a `.sys` bound to it? | Yellow `!`, or no ADDI group |
| ADDIREG list | May SET1710 / AIWeaver open the board? | “No APCI-1710 found”, Digital I/O greyed out |

In October 2026 Device Manager was already healthy and ADDIREG’s table was **empty**. That single gap blocked Digital I/O. Inserting **APCI1710** (slot **131**) filled it.

ADDI’s own CD text says ADDIREG is “not used” for PCI boards under Windows 2000. That is only true for **installing** the Plug and Play driver. The **programming API** still reads the ADDIREG list.

## Data path when weaving

```mermaid
sequenceDiagram
  participant P as Pattern Dname.S01
  participant T as Default.tie
  participant A as AIWeaver
  participant D as APCI1710.DLL
  participant C as 1710 card
  participant H as Four heads

  A->>P: read pick N (288 bytes / 2304 bits)
  A->>T: map design ends to hooks
  A->>D: SetDigitalIOChlOn / Off per hook
  D->>C: digital outputs on 50-pin
  C->>H: shared clock, per-head data
  H-->>C: feedback, faults, cylinder sensor, pedal
  C-->>D: ReadDigitalIOChlValue
  D-->>A: pick complete / loom stop / fault
```

The 1710 is powered by the PC. Loom / mainframe power only energises the interface boxes, valves, and sensors. It does **not** hide the PCI card. Leave loom power off until you mean to move the jacquard.

## What AIWeaver is not

AIWeaver is not a design program. It loads a finished lift plan and a harness map, then clocks bits out to the heads.

| Role | Program |
| --- | --- |
| Draw the cloth | AdaCAD (planned), historically Scotweave / Pointcarré / DAO |
| Map ends to hooks | `Default.tie` (loom dressing, rarely changed) |
| Run the loom | AIWeaver |

See [file formats](file-formats.md) and [AdaCAD plan](adacad.md).
