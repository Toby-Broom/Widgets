<#
.NOTES
    Version    : 3.0.0
#>
function Get-UpTime{

[hashtable]$return = @{}

$Up = (Get-Date) - ($Static.LastBoot)
$Total = $Static.Up + $Up

$return.Up = $Up
$return.TotalUp = $Total
if ($Up -gt $Static.MaxUp){
$Stats.SysInfo.MaxUpTime_Raw = $Up.ToString()
$Stats.SysInfo.MaxUpTime_Form = "{0:%d}d {0:hh}:{0:mm}"-f $Up
}
$return.Aval = "{0:P3}" -f ($Total.TotalSeconds/ (((Get-Date)- $Static.FirstBoot).TotalSeconds))


return $return
}


function Out-XMLStats{

Param
([Switch] $L)
$scriptPath = $PSScriptRoot

if ($L){$path = "$PSScriptRoot\SysInfo.xml"}
else{$path = "$PSScriptRoot\Documents\SysInfo.xml"}

if ((Test-Path $path) -eq $false){break}
[xml]$Stats = Get-Content -Path $path
if ((Test-Path $scriptPath\Get-SystemData.ps1) -eq $false){break}
. $scriptPath\Get-SystemData.ps1

If ((Test-Path $scriptPath\reboot.txt) -eq $true){
    Start-Sleep -Seconds 30
    Remove-Item $scriptPath\reboot.txt
    $Static = Get-StaticData
    $Stats.SysInfo.Boots = $Static.Boots.ToString()
    $Stats.SysInfo.Crashes = $Static.Crashes.ToString()
    $Stats.SysInfo.LastBoot = $Static.LastBoot.ToString()
    $Stats.SysInfo.FirstBoot = $Static.FirstBoot.ToString()
    $Stats.SysInfo.TotalUpTime = $Static.Up.ToString()
    $Stats.SysInfo.MaxUpTime_Raw = $Static.MaxUp.ToString()
    $Stats.SysInfo.MaxUpTime_Form= "{0:%d}d {0:hh}:{0:mm}"-f $Static.MaxUp
    $Stats.SysInfo.TotalDownTime_Raw = $Static.Down.ToString()
    $Stats.SysInfo.TotalDownTime_Form = "{0:%d}d {0:hh}h" -f $Static.Down
    $Stats.SysInfo.MaxDownTime_Raw = $Static.MaxDown.ToString()
    $Stats.SysInfo.MaxDownTime_Form = "{0:%d}d {0:hh}:{0:mm}" -f $Static.MaxDown
    $Stats.SysInfo.Computer = $Static.Name
    }
Else{
    [hashtable]$Static = @{}
    $Static.Boots = $Stats.SysInfo.Boots
    $Static.Crashes = $Stats.SysInfo.Crashes
    $Static.LastBoot = Get-Date $Stats.SysInfo.LastBoot
    $Static.FirstBoot = Get-Date $Stats.SysInfo.FirstBoot
    [TimeSpan] $Static.Up = $Stats.SysInfo.TotalUpTime
    [TimeSpan] $Static.MaxUp = $Stats.SysInfo.MaxUpTime_Raw
    [TimeSpan] $Static.Down = $Stats.SysInfo.TotalDownTime_Raw
    [TimeSpan] $Static.MaxDown= $Stats.SysInfo.MaxDownTime_Raw
}


$Stats.SysInfo.Updated = [DateTimeOffset]::Now.ToUnixTimeSeconds().ToString()
$Stats.SysInfo.Availability = (Get-UpTime).Aval
$Stats.SysInfo.Uptime_Raw = ((Get-UpTime).Up).ToString()
$Stats.SysInfo.Uptime_Form= "{0:%d}d {0:hh}:{0:mm}" -f (Get-UpTime).Up
$Stats.SysInfo.CPUUse = Used-CPU
$Stats.SysInfo.DiskUse = Used-Disk
$Stats.SysInfo.CurrentUp = "{0:%d}d {0:hh}h" -f (Get-UpTime).TotalUp

try {
    $Stats.Save($path)
}
catch {
    continue
}


}
