# PowerShell Scripts for Windows

These are the files to create the xml file with the system data in

## Setup

To create a blank SysInfo.xml run the New-SysXML.ps1

I put the SysInfo.xml in the public documents folder and share this to the network and then put the remaining files in the root of public

I abstracted the code for running the updates out of the main code so I could more easily update the main

I typically convert the Invoke-SysXML to an .exe with https://github.com/MScholtes/Win-PS2EXE as it less hassle to run as a scheduled task

Invoke-SysXML.xml can be used to create scheduled task

I also run the log off script reboot.cmd when shutting down to trigger the reset of the more static data generated with Get-SystemData.ps1

