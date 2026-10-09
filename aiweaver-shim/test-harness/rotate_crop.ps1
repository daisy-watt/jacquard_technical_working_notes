param([string]$In, [string]$OutPrefix, [int]$Pieces = 3, [int]$Cols = 1,
      [double]$Top = 0, [double]$Bottom = 1, [double]$Left = 0, [double]$Right = 1,
      [string]$Rotate = "Rotate90FlipNone")
Add-Type -AssemblyName System.Drawing
$img = [System.Drawing.Image]::FromFile($In)
$img.RotateFlip([System.Drawing.RotateFlipType]::$Rotate)
$bmp = New-Object System.Drawing.Bitmap $img
$img.Dispose()
$x0 = [int]($bmp.Width * $Left); $x1 = [int]($bmp.Width * $Right)
$y0 = [int]($bmp.Height * $Top); $y1 = [int]($bmp.Height * $Bottom)
$h = [int][Math]::Ceiling(($y1 - $y0) / $Pieces)
$w = [int][Math]::Ceiling(($x1 - $x0) / $Cols)
for ($i = 0; $i -lt $Pieces; $i++) {
  for ($j = 0; $j -lt $Cols; $j++) {
    $y = $y0 + $i * $h; $ph = [Math]::Min($h + 30, $y1 - $y)
    $x = $x0 + $j * $w; $pw = [Math]::Min($w + 30, $x1 - $x)
    $crop = $bmp.Clone((New-Object System.Drawing.Rectangle $x, $y, $pw, $ph), $bmp.PixelFormat)
    $crop.Save("$OutPrefix-r$($i + 1)c$($j + 1).png"); $crop.Dispose()
  }
}
"$($bmp.Width)x$($bmp.Height) -> $Pieces x $Cols pieces"
$bmp.Dispose()
