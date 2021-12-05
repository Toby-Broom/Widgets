<#  
.NOTES  
    Version    : 1.0.2
#> 
$scriptPath = (Get-Location).Path
if ((Test-Path $scriptPath\Out-XMLStats.ps1) -eq $false){break}
. $scriptPath\Out-XMLStats.ps1

while ($true){
Try
{
Out-XMLStats
Start-Sleep -Seconds 55
}
Catch
{
    $a = $_.Exception.Message
    $b = $_.Exception.ItemName
    $c = $_.Exception.InnerException
    $d = $_.Exception.StackTrace
    $e = $_.ScriptStackTrace

    "$a - $b - $c - $d - $e" | Add-Content textfile.txt
    Continue
}

}

