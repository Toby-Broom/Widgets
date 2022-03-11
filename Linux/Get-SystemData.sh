#Version    : 1.0.0.1
#!/bin/bash

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

avail=$(tuptime | perl -ne '/System uptime:\s*(.*?)%/ && print"$1"')
CUptime=$(tuptime | perl -ne '/Current uptime:\s*(.*?)\s*since/ && print"$1"')
Up=$(FormatTime "$CUptime")

idle=$(top -bn 2 | perl -ne '/ni,\s*(.*) id/ && print"$1\n"')
CPUUse=$(echo $idle | perl -ne '/(.*) (.*)/ && printf"%.0f", ((100-($1+$2)/2))')

CPUTemp=$(echo $tistats | perl -ne '/PkgWatt (\d*)/ && print"$1"')

CPUPwr=$(echo $tistats | perl -ne '/PkgWatt \d* (\d*.\d*)/ && print$1' | awk '{if ($1 >=10) {printf "%.0f", $1} else {printf "%.1f", $1}}')

Use=$(nvidia-smi -q --display=UTILIZATION | perl -ne '/Avg.*:\s(\d*)\s%/ && print $1')
GPUUse=$(printf '%-.1s' "$Use")

GPUTemp=$(nvidia-smi -q --display=TEMPERATURE | perl -ne '/GPU\sCurrent\sTemp\s*:\s(\d*)/ && print$1')
GPUPwr=$(nvidia-smi -q --display=POWER | perl -ne '/Avg\s*:\s(.*)\sW/ && printf"%.0f", $1')

MemUse=$(free -h | perl -ne '/Mem:\s*(\d*)Gi\s*(\d*)Gi/ && printf"%.0f", ($2/$1)*100')
DiskUse=$(df / | perl -ne '/nvme\S*\s\d*\s\d*\s\d*\s*(\d*)/ && print"$1"')



echo $name,$updated,$avail%,$Up,$CPUUse%,$CPUTemp""°C"",$CPUPwr""W"",$GPUUse%,$GPUTemp""°C"",$GPUPwr""W"",$MemUse%,$DiskUse%

