#Version    : 1.0.0.0
#!/bin/bash

ttuptime=$(tuptime)
tistats=$(sudo turbostat -c package -n 1 -q --show CoreTmp,PkgWatt)

FormatTime ()
{
	days=$(echo $1| perl -ne '/(\d*) day/ && print"$1"')
	hours=$(echo $1 | perl -ne '/(\d*) hour/ &&printf"%02d", $1')
	mins=$(echo $1 | perl -ne '/(\d*) minute/ &&printf"%02d", $1')
	if [ -z "$days" ]; then
		days="0"
	fi
	if [ -z "$hours" ]; then
		hours="00"
	fi
	if [ -z "$mins" ]; then
		mins="00"
	fi
	if [ -z $2 ]; then
		echo $days"d "$hours":"$mins
	else
		echo $days"d "$hours"h"
	fi
}

name=$(hostname)
updated=$(date +%s)
avail=$(echo $ttuptime | perl -ne '/System uptime:\s*(.*?)%/ && print"$1"')
CUptime=$(echo $ttuptime | perl -ne '/Current uptime:\s*(.*?)\s*since/ && print"$1"')
Up=$(FormatTime "$CUptime")

idle=$(top -bn 2 | perl -ne '/ni,\s*(.*) id/ && print"$1\n"')
CPUUse=$(echo $idle | perl -ne '/(.*) (.*)/ && printf"%.0f", ((100-($1+$2)/2))')

CPUTemp=$(echo $tistats | perl -ne '/PkgWatt (\d*)/ && print"$1"')

MemUse=$(free -h | perl -ne '/Mem:\s*(\d*)Gi\s*(\d*)Gi/ && printf"%.0f", ($2/$1)*100')

CPUPwr=$(echo $tistats | perl -ne '/PkgWatt \d* (\d*.\d*)/ && print$1' | awk '{if ($1 >=10) {printf "%.0f", $1} else {printf "%.1f", $1}}')


DiskUse=$(df / | perl -ne '/nvme\S*\s\d*\s\d*\s\d*\s*(\d*)/ && print"$1"')

GPUTemp=$(nvidia-smi -q --display=TEMPERATURE | perl -ne '/GPU\sCurrent\sTemp\s*:\s(\d*)/ && print$1')

MaxUp=$(echo $ttuptime | perl -ne '/Largest uptime:\s*(.*?)\s*from/ && print$1')
MaxUpTime=$(FormatTime "$MaxUp")

MaxDown=$(echo $ttuptime | perl -ne '/Largest downtime:\s*(.*?)\s*from/ && print$1')
MaxDownTime=$(FormatTime "$MaxDown")

TDown=$(echo $ttuptime | perl -ne '/System downtime:.*-\s*(.*) Sys/ && print$1')
TotalDown=$(FormatTime "$TDown" "s")

Boots=$(echo $ttuptime | perl -ne '/System startups:\s*(\d*) since/ &&print$1')
Crashes=$(echo $ttuptime | perl -ne '/<-\s*(\d*) bad/ &&print$1')

TUp=$(echo $ttuptime | perl -ne '/System uptime:.*?-\s(.*?) and/ &&print$1')
CurrentUp=$(FormatTime "$TUp" "s")


echo $name,$updated,$avail%,$Up,$CPUUse%,$CPUTemp""°C"",$MemUse%,$CPUPwr""W"",$DiskUse%,$GPUTemp""°C"",$MaxUpTime,$MaxDownTime,$TotalDown,$Boots,$Crashes,$CurrentUp

