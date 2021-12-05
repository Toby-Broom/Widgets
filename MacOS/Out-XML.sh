#Version    : 1.0.0.1

data=$(/Users/toby/Get-SystemData.sh)
OLDIFS="$IFS"
IFS=',' read -r -a array <<< "$data"
IFS="$OLDIFS"

/usr/local/bin/xmlstarlet ed -L -u "/SysInfo/Computer" -v ${array[0]}  ~/Public/SysInfo.xml
/usr/local/bin/xmlstarlet ed -L -u "/SysInfo/Updated" -v "${array[1]}"  ~/Public/SysInfo.xml
/usr/local/bin/xmlstarlet ed -L -u "/SysInfo/Availability" -v ${array[2]}  ~/Public/SysInfo.xml
/usr/local/bin/xmlstarlet ed -L -u "/SysInfo/Uptime_Raw" -v "NaN"  ~/Public/SysInfo.xml
/usr/local/bin/xmlstarlet ed -L -u "/SysInfo/Uptime_Form" -v "${array[3]}" ~/Public/SysInfo.xml
/usr/local/bin/xmlstarlet ed -L -u "/SysInfo/CPUUse" -v ${array[4]}  ~/Public/SysInfo.xml
/usr/local/bin/xmlstarlet ed -L -u "/SysInfo/CPUTemp" -v ${array[5]}  ~/Public/SysInfo.xml
/usr/local/bin/xmlstarlet ed -L -u "/SysInfo/MemoryUse" -v ${array[6]}  ~/Public/SysInfo.xml
/usr/local/bin/xmlstarlet ed -L -u "/SysInfo/CPUPower" -v ${array[7]}  ~/Public/SysInfo.xml
/usr/local/bin/xmlstarlet ed -L -u "/SysInfo/DiskUse" -v ${array[8]}  ~/Public/SysInfo.xml
/usr/local/bin/xmlstarlet ed -L -u "/SysInfo/GPUTemp" -v "${array[9]}"  ~/Public/SysInfo.xml
/usr/local/bin/xmlstarlet ed -L -u "/SysInfo/MaxUpTime_Raw" -v "NaN"  ~/Public/SysInfo.xml
/usr/local/bin/xmlstarlet ed -L -u "/SysInfo/MaxUpTime_Form" -v "${array[10]}"  ~/Public/SysInfo.xml
/usr/local/bin/xmlstarlet ed -L -u "/SysInfo/MaxDownTime_Raw" -v "NaN"  ~/Public/SysInfo.xml
/usr/local/bin/xmlstarlet ed -L -u "/SysInfo/MaxDownTime_Form" -v "${array[11]}"  ~/Public/SysInfo.xml
/usr/local/bin/xmlstarlet ed -L -u "/SysInfo/TotalUpTime" -v "NaN"  ~/Public/SysInfo.xml
/usr/local/bin/xmlstarlet ed -L -u "/SysInfo/TotalDownTime_Raw" -v "NaN"  ~/Public/SysInfo.xml
/usr/local/bin/xmlstarlet ed -L -u "/SysInfo/TotalDownTime_Form" -v "${array[12]}"  ~/Public/SysInfo.xml
/usr/local/bin/xmlstarlet ed -L -u "/SysInfo/Boots" -v "${array[13]}"  ~/Public/SysInfo.xml
/usr/local/bin/xmlstarlet ed -L -u "/SysInfo/Crashes" -v "${array[14]}"  ~/Public/SysInfo.xml
/usr/local/bin/xmlstarlet ed -L -u "/SysInfo/LastBoot" -v "NaN"  ~/Public/SysInfo.xml
/usr/local/bin/xmlstarlet ed -L -u "/SysInfo/FirstBoot" -v "NaN"  ~/Public/SysInfo.xml
/usr/local/bin/xmlstarlet ed -L -u "/SysInfo/CurrentUp" -v "${array[15]}"  ~/Public/SysInfo.xml
