#!/usr/bin/env bash
# Builds build/APCI1500.DLL: 32-bit x86, no C runtime, loadable on Windows 2000.
set -euo pipefail
cd "$(dirname "$0")"

ZIG_DIR=${ZIG_DIR:-.tools/zig-linux-x86_64-0.13.0}
ZIG=$ZIG_DIR/zig
MINGW_DEFS=$ZIG_DIR/lib/libc/mingw/lib32
export ZIG_GLOBAL_CACHE_DIR=$PWD/.tools/cache ZIG_LOCAL_CACHE_DIR=$PWD/.tools/cache

rm -rf build && mkdir -p build/obj
"$ZIG" cc -target x86-windows-gnu -mcpu=i686 -Os -c -fno-stack-protector \
  -mno-stack-arg-probe -fno-builtin -Wall -Wextra \
  -o build/obj/apci1500_stub.o apci1500_stub.c

for lib in kernel32 user32; do
  "$ZIG" dlltool -m i386 -k -d "$MINGW_DEFS/$lib.def" -l "build/obj/$lib.lib"
done

"$ZIG" lld-link /nologo /dll /machine:x86 /nodefaultlib \
  /entry:DllMain@12 /subsystem:windows,5.0 /osversion:5.0 \
  /def:apci1500_stub.def /out:build/APCI1500.DLL \
  build/obj/apci1500_stub.o build/obj/kernel32.lib build/obj/user32.lib
rm -rf build/obj build/*.lib build/*.exp build/*.pdb

cp build/APCI1500.DLL disk/APCI1500.DLL
sed -i 's/\r$//; s/$/\r/' disk/INSTALL.txt

objdump -p build/APCI1500.DLL | grep -E "DLL Name|OperatingSystemVersion|SubsystemVersion"
objdump -p build/APCI1500.DLL | sed -n '/\[Ordinal\/Name Pointer\] Table/,/^$/p'
