<#  
.NOTES  
    Version    : 3.0.0
#> 
function Get-StaticData{

$Events = Get-EventLog -Log "System" | where {($_.EventID -eq 6006) -or ($_.EventID -eq 6005) -or ($_.EventID -eq 6008)}
$Crashed = 0
foreach ($Event in $Events){
    if ($Event.EventID -eq 6005){
        $Boots++
        $Boot = $Event.TimeGenerated
        if ($Boots -eq 1){$LastBoot = $Boot}
        if ($Shutdown -ne $null){
            if ($Shutdown -eq $LastShutDown){$Up = 0}
            else{$Up = $Shutdown - $Boot}
            $TotalUp += $Up
            if ($MaxUp -lt $Up){$MaxUp = $Up}
        }
        $LastShutDown = $Shutdown
    }
    elseif ($Event.EventID -eq 6006){
        $Shutdown = $Event.TimeGenerated
        if ($Crashed -eq 1){
            $Down = $Crash - $Shutdown
        $Crashed = 0}
        else {    
        $Down = $Boot - $Shutdown
        }
        $TotalDown += $Down
        if ($MaxDown -lt $Down){$MaxDown = $Down}}
    else {
    $Crashes++
    if ($Crashed -eq 0){$Crash = $Event.TimeGenerated
    $Crashed =1}
    }
}


[hashtable]$return = @{}
$return.Boots = [int] $Boots
$return.Crashes = [int] $Crashes
$return.LastBoot = $LastBoot
$return.FirstBoot = $Boot
$return.Up = $TotalUp
$return.MaxUp = $MaxUp
$return.Down = $TotalDown
$return.MaxDown = $MaxDown
$return.Name = $env:computername
return $return
}


function Used-Disk{
Try
{
$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'" | Select-Object Size,FreeSpace
}
Catch
{
    return "NaN"
    break
}
return "{0:P0}" -f (1 - ($disk.FreeSpace / $disk.Size))
}


function Used-CPU(){
Try
{
$Values = (Get-Counter -Counter "\Processor Information(_Total)\% Processor Utility").CounterSamples.CookedValue
}
Catch
{
    return "NaN"
    break
}
if ($Values -gt 100){return "{0:P0}" -f 1}
else{return "{0:P0}" -f ($Values/100)}

}