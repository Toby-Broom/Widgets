#Version    : 1.0.0.3
#!/bin/bash
PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
ttuptime=$(tuptime)
tistats=$(istats --no-graphs)

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

name=$(hostname | perl -ne '/-(.*)-/ && print"$1"')
updated=$(date +%s)
avail=$(echo $ttuptime | perl -ne '/System uptime:\s*(.*?) %/ && print"$1"')

CUptime=$(echo $ttuptime | perl -ne '/Current uptime:\s*(.*?)\s*since/ && print"$1"')
Up=$(FormatTime "$CUptime")

idle=$(top -l 2 | perl -ne '/sys, (.*)%/ && print"$1\n"')
CPUUse=$(echo $idle | perl -ne '/ (.*)/ &&printf"%.0f", (100-$1)')

CPUTemp=$(echo $tistats | perl -ne '/(?s)Core 1 temp:\s*(\d*.\d).*?:\s*(\d*.\d).*?:\s*(\d*.\d).*?:\s*(\d*.\d).*?:\s*(\d*.\d).*?:\s*(\d*.\d)/ &&printf "%2d", (($1+$2+$3+$4+$5+$6)/6)')

MemUse=$(memory_pressure | perl -ne '/System-wide memory free percentage: (.*)%/ &&print(100-$1)')

CPUPwr ()
{
	/Applications/Intel\ Power\ Gadget/PowerLog -duration 2 -file ~/PowerLog.csv > /dev/null
	cat ~/PowerLog.csv | perl -ne '/Average Processor Power_0.*=(.*)"/ &&print$1' | awk '{if ($1 >=10) {printf "%.0f", $1} else {printf "%.1f", $1}}' 
	rm ~/PowerLog.csv	
}

DiskUse=$(df / | perl -ne '/dev.*?\s.*?\s.*?\s*(\d*)\s(\d*)/ && printf"%.0f", ($2 / $1)*100')

GPUTemp=$(echo $tistats | perl -ne '/GPU temp:\s*(\d*)/ &&print$1')

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


echo "$name,$updated,$avail%,$Up,$CPUUse%,$CPUTemp""°C"",$MemUse%,$(CPUPwr)W,$DiskUse%,$GPUTemp""°C"",$MaxUpTime,$MaxDownTime,$TotalDown,$Boots,$Crashes,$CurrentUp"