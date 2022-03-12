<#  
.NOTES  
    Version    : 3.0.0
#> 
[xml]$Doc = New-Object System.Xml.XmlDocument
$dec = $Doc.CreateXmlDeclaration("1.0","UTF-8",$null)
$doc.AppendChild($dec) | Out-Null
$text = @"
 
System Infomation Report
v1.3
 
"@
$elements = @("Computer","Updated","Availability","Uptime_Form","CPUUse","CPUTemp",`
"CPUPower","GPUUse","GPUTemp","GPUPower","DiskUse","MemoryUse")

$doc.AppendChild($doc.CreateComment($text)) | Out-Null
$root = $doc.CreateNode("element","SysInfo",$null)

foreach ($element in $elements){

$child = $doc.CreateNode("element",$element,$null)
$root.AppendChild($child) | Out-Null

}


$doc.AppendChild($root) | Out-Null
$doc.save("SysInfo.xml")