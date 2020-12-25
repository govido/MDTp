$domainname = (Get-DnsClient -InterfaceAlias Ethernet*).connectionspecificsuffix
$dc = (Get-DnsClientServerAddress -InterfaceAlias "Ethernet*" -AddressFamily IPv4).ServerAddresses | select-object -first 1

robocopy .\MDTP_Tools D:\MDTp_Tools /E
robocopy .\MDTp_Tools\Shortcuts "C:\Users\Public\Desktop"
robocopy .\MDT-Import D:\MDT-Import /E
robocopy .\DeploymentShare\ D:\DeploymentShare /E
msiexec /i MSDaRT100.msi /passive
Copy-Item "D:\MDTp_Tools\Scripts_Win_PE_DART\Unattend_PE_x64.xml" "C:\Program Files\Microsoft Deployment Toolkit\Templates\Unattend_PE_x64.xml"
Register-ScheduledTask -Xml (get-content '.\MDTp_Tools\Scripts_MDTp_Server\MDTp_Servertasks_5Mins.xml' | out-string) -TaskName "MDTp_Servertasks_5Mins" -force
Clear-Host
write-host "Litetouch and Zerotouch need to be updated with MDTp_Tool for DART-Support! (remote Windows PE)"
pause
# get credentials for MDTp_DC copy
$credential = Get-Credential -Credential $domainname\administrator
New-PSDrive -Name P -PSProvider FileSystem -Root "\\$dc\c$" -Credential $credential
mkdir \\$dc\c$\MDTp_DC_Tools
robocopy D:\MDTp_Tools\Scripts\MDTp_DC_Tools \\$dc\c$\MDTp_DC_Tools
Copy-Item "D:\MDTp_Tools\SW_MDTp_DC_Tools\MDTp_DC_Tools.lnk" "\\$dc\c$\Users\Public\Desktop\MDTp_DC_Tools.lnk"
Write-Output "Install complete"
pause