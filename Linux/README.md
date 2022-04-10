# Shell Scripts for Linux

These are the files to create the xml file with the system data, I put the files in my home directly and share a folder from there with the xml file in.

I edited the XML file a little for Linux so it has different parameters in, use the Linux version of the New-SysXML.ps1

## Setup

You need to install [turbostat](https://github.com/torvalds/linux/tree/master/tools/power/x86/turbostat), [tuptime](https://github.com/rfrail3/tuptime), nvidia drivers for nvidia-smi, [XmlStarlet](http://xmlstar.sourceforge.net/doc/UG/)

`sudo apt install linux-tools-common`

`sudo apt install tuptime`

you'll need to tweek the paths in the files and setup a Cron job to start the update of the XML in the background

`sudo crontab -e`

Add in 

`@reboot /home/toby/Invoke-XML.sh`
