#Version    : 1.0.0.2

data=$(/home/toby/Get-SystemData.sh)
OLDIFS="$IFS"
IFS=',' read -r -a array <<< "$data"
IFS="$OLDIFS"

xmlstarlet ed -L -u "/SysInfo/Computer" -v ${array[0]}  ~/Stats/SysInfo.xml
xmlstarlet ed -L -u "/SysInfo/Updated" -v "${array[1]}"  ~/Stats/SysInfo.xml
xmlstarlet ed -L -u "/SysInfo/Availability" -v ${array[2]}  ~/Stats/SysInfo.xml
xmlstarlet ed -L -u "/SysInfo/Uptime_Form" -v "${array[3]}" ~/Stats/SysInfo.xml
xmlstarlet ed -L -u "/SysInfo/CPUUse" -v ${array[4]}  ~/Stats/SysInfo.xml
xmlstarlet ed -L -u "/SysInfo/CPUTemp" -v ${array[5]}  ~/Stats/SysInfo.xml
xmlstarlet ed -L -u "/SysInfo/CPUPower" -v ${array[6]}  ~/Stats/SysInfo.xml
xmlstarlet ed -L -u "/SysInfo/GPUUse" -v ${array[7]}  ~/Stats/SysInfo.xml
xmlstarlet ed -L -u "/SysInfo/GPUTemp" -v ${array[8]}  ~/Stats/SysInfo.xml
xmlstarlet ed -L -u "/SysInfo/GPUPower" -v "${array[9]}"  ~/Stats/SysInfo.xml
xmlstarlet ed -L -u "/SysInfo/MemoryUse" -v ${array[10]}  ~/Stats/SysInfo.xml
xmlstarlet ed -L -u "/SysInfo/DiskUse" -v ${array[11]}  ~/Stats/SysInfo.xml


