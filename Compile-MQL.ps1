#gets the File To Compile as an external parameter... Defaults to a Test file...
Param($Filename)

#cleans the terminal screen and sets the log file name...
Clear-Host
$LogFile = $Filename + ".log"
$Compiler = "C:\Forex\FPM\metaeditor.exe"
$IncludePath = """C:\Forex\FPM\MQL4"""

#first of all, kill MT Terminal (if running)... otherwise it will not see the new compiled version of the code...
#Get-Process -Name terminal64 -ErrorAction SilentlyContinue | Where-Object {$_.Id -gt 0} | Stop-Process

#fires up the Metaeditor compiler...
& $Compiler /compile:"""$Filename""" /log:"""$LogFile""" /inc:$IncludePath | Out-Null

#get some clean real state and tells the user what is being compiled (just the file name, no path)...
Write-Host "Compiling........: " (Split-Path $Filename -Leaf)
""

#reads the log file. Eliminates the blank lines. Skip the first line because it is useless.
$Log = Get-Content -Path $LogFile | Where-Object { $_ -ne "" } | Select-Object -Skip 1

$Success = $false
$mqFile = $(Split-Path $Filename -Leaf)
#runs through all the log lines...
$Log | ForEach-Object {
      #ignores the ": information: error generating code" line when ME was successful
      if (-Not $_.Contains("information:")) {
            #common log line... just print it...
            $Line = $_ -Split(": ")
            if ($_.Contains(": error")) {
				  $point2code = $Line[0] -Split {$_ -eq "(" -or $_ -eq ")" -or $_ -eq ","}
				  $pointForm = $point2code[1] + ":" + $point2code[2]
                  Write-Host $mqFile":"$pointForm $Line[1] $Line[2] -ForegroundColor "Red"       
            }
            elseif ($_.Contains(": warning")) {
				  $point2code = $Line[0] -Split {$_ -eq "(" -or $_ -eq ")" -or $_ -eq ","}
				  $pointForm = $point2code[1] + ":" + $point2code[2]
                  Write-Host $mqFile":"$pointForm $Line[1] $Line[2] -ForegroundColor "DarkYellow"
            }
            elseif ($_.Contains("0 errors,")) {
                  $Success = $true
                  Write-Host $Line -ForegroundColor "Green"
            }
            else {
                  Write-Host $Line -ForegroundColor "Red"
            }
      }
}


if ($Success) {
      Remove-Item $LogFile
      #get the MT Terminal back if all went well...
      #& "C:\Program Files\MetaTrader 5\terminal64.exe"
}