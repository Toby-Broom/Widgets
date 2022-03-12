<#  
.NOTES  
    Version    : 3.0.0
#> 
[xml]$Doc = New-Object System.Xml.XmlDocument
$dec = $Doc.CreateXmlDeclaration("1.0","UTF-8",$null)
$doc.AppendChild($dec) | Out-Null
$text = @"
 
System Infomation Report
v1.2
 
"@
$elements = @("Computer","Updated","Availability","Uptime_Raw","Uptime_Form","CPUUse","DiskUse",`
"MaxUpTime_Raw","MaxUpTime_Form","MaxDownTime_Raw","MaxDownTime_Form","CurrentUp","TotalUpTime",`
"TotalDownTime_Raw","TotalDownTime_Form","Boots","Crashes","LastBoot","FirstBoot")

$doc.AppendChild($doc.CreateComment($text)) | Out-Null
$root = $doc.CreateNode("element","SysInfo",$null)

foreach ($element in $elements){

$child = $doc.CreateNode("element",$element,$null)
$root.AppendChild($child) | Out-Null

}


$doc.AppendChild($root) | Out-Null
$doc.save("C:\Users\Public\Documents\SysInfo.xml")