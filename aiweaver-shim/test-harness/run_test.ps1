param([string]$Dir = "$env:LOCALAPPDATA\Temp\aiweaver-test", [int]$Wait = 10, [int]$ConfigID = -1)
$ErrorActionPreference = "Stop"

Add-Type -AssemblyName System.Drawing
Add-Type @"
using System;
using System.Runtime.InteropServices;
public static class W {
  [DllImport("user32.dll")] public static extern bool GetWindowRect(IntPtr h, out RECT r);
  [DllImport("user32.dll")] public static extern bool PrintWindow(IntPtr h, IntPtr hdc, uint flags);
  [DllImport("user32.dll")] public static extern bool EnumWindows(EnumProc cb, IntPtr p);
  [DllImport("user32.dll")] public static extern uint GetWindowThreadProcessId(IntPtr h, out uint pid);
  [DllImport("user32.dll")] public static extern bool IsWindowVisible(IntPtr h);
  [DllImport("user32.dll", CharSet=CharSet.Auto)] public static extern int GetWindowText(IntPtr h, System.Text.StringBuilder s, int n);
  public delegate bool EnumProc(IntPtr h, IntPtr p);
  public struct RECT { public int L, T, R, B; }
}
"@

Start-Process reg.exe -ArgumentList "import `"$Dir\AIWeaver.reg`"" -Wait -WindowStyle Hidden
if ($ConfigID -ge 0) { Set-ItemProperty HKCU:\Software\AIWeaver -Name ConfigID -Value $ConfigID -Type DWord }
"ConfigID = $((Get-ItemProperty HKCU:\Software\AIWeaver).ConfigID)"
Remove-Item "$Dir\*.log", "$Dir\shot-*.png" -ErrorAction SilentlyContinue

$p = Start-Process -FilePath "$Dir\AIWeaver.exe" -WorkingDirectory $Dir -PassThru
Start-Sleep -Seconds $Wait

$wins = New-Object System.Collections.ArrayList
$cb = [W+EnumProc]{ param($h, $x)
  $procId = 0; [void][W]::GetWindowThreadProcessId($h, [ref]$procId)
  if ($procId -eq $p.Id -and [W]::IsWindowVisible($h)) {
    $sb = New-Object System.Text.StringBuilder 256; [void][W]::GetWindowText($h, $sb, 256)
    [void]$wins.Add([pscustomobject]@{ Handle = $h; Title = $sb.ToString() })
  }
  $true }
[void][W]::EnumWindows($cb, [IntPtr]::Zero)

"Process running: $(-not $p.HasExited)"
"Visible windows:"
$i = 0
foreach ($w in $wins) {
  "  [$i] '$($w.Title)'"
  $r = New-Object W+RECT; [void][W]::GetWindowRect($w.Handle, [ref]$r)
  $wd = $r.R - $r.L; $ht = $r.B - $r.T
  "      size ${wd}x${ht}"
  if ($wd -gt 0 -and $ht -gt 0) {
    $bmp = New-Object System.Drawing.Bitmap $wd, $ht
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $hdc = $g.GetHdc(); [void][W]::PrintWindow($w.Handle, $hdc, 2); $g.ReleaseHdc($hdc)
    $bmp.Save("$Dir\shot-$i.png"); $g.Dispose(); $bmp.Dispose()
  }
  $i++
}

if (-not $p.HasExited) { Stop-Process -Id $p.Id -Force }
Start-Sleep -Milliseconds 500
Remove-Item HKCU:\Software\AIWeaver -Recurse -ErrorAction SilentlyContinue
"Registry test key removed: $(-not (Test-Path HKCU:\Software\AIWeaver))"
