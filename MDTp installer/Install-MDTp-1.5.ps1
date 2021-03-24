$domainname = (Get-DnsClient -InterfaceAlias Ethernet*).connectionspecificsuffix
$dc = (Get-DnsClientServerAddress -InterfaceAlias "Ethernet*" -AddressFamily IPv4).ServerAddresses | Select-Object -First 1

Write-Host "Before continuing copy ---MSDaRT100.msi--- in the same folder as this installscript for DaRT remote support (not needed for updates)"
Pause
msiexec /i MSDaRT100.msi /passive
mkdir D:\MDTp-Import\Drivers
mkdir D:\MDTp-Import\PC-Infos
mkdir D:\MDTp-Import\PC-Reports
mkdir D:\MDTp-Import\WIM-Images
mkdir D:\MDTp_Tools\Import-Logs
mkdir D:\DeploymentShare\MDTp_Staggered_Deploy
mkdir D:\DeploymentShare\Scripts\MDTp\OS_Import
mkdir D:\DeploymentShare\Scripts\MDTp\WDS_PXE
robocopy .\MDTp_Tools D:\MDTp_Tools /E
robocopy .\MDTp_Tools\Shortcuts "C:\Users\Public\Desktop"
robocopy .\MDTp-Import D:\MDTp-Import /E
robocopy .\DeploymentShare\ D:\DeploymentShare /E
Copy-Item "D:\MDTp_Tools\Scripts_Win_PE_DART\Unattend_PE_x64.xml" "C:\Program Files\Microsoft Deployment Toolkit\Templates\Unattend_PE_x64.xml"
Register-ScheduledTask -Xml (Get-Content '.\MDTp_Tools\Scripts_MDTp_Server\MDTp_Servertasks_5Mins.xml' | Out-String) -TaskName "MDTp_Servertasks_5Mins" -Force
New-SmbShare -Name "MDTp-Import$" -Path "D:\MDTp-Import" -FullAccess Administrator
Clear-Host
Write-Host "Litetouch and Zerotouch need to be updated with MDTp_Tool for DaRT-Support! (remote Windows PE)"
$localmdtpassword = Read-Host -Prompt 'Enter local MDTp Administrator password'
(Get-Content "D:\DeploymentShare\Control\Bootstrap_Zerotouch.ini") | ForEach-Object { $_ -replace "YOURlocalMDTpADMINpassword", $localmdtpassword -replace "mdtp", $env:computername } | Set-Content "D:\DeploymentShare\Control\Bootstrap_Zerotouch.ini"
$SQLuser = Read-Host -Prompt 'Enter SQL username (admin)'
$SQLpassword = Read-Host -Prompt 'Enter SQL password'
$sqldatabase = Read-Host -Prompt 'Enter SQL database name (mdt)'
(Get-Content "D:\DeploymentShare\Scripts\MDTp\TS_Install_SQL_Import_Update.ps1") | ForEach-Object { $_ -replace "YOURsqlUSERpassword", $SQLpassword -replace "admin", $SQLuser -replace "-sqlServer mdtp", "-sqlServer $env:computername" -replace "-database mdt", "-database $sqldatabase" } | Set-Content "D:\DeploymentShare\Scripts\MDTp\TS_Install_SQL_Import_Update.ps1"
(Get-Content "D:\DeploymentShare\Scripts\MDTp\TS_Install_SQL_Import_Update_serialnumber_Wifi.ps1") | ForEach-Object { $_ -replace "YOURsqlUSERpassword", $SQLpassword -replace "admin", $SQLuser -replace "-sqlServer mdtp", "-sqlServer $env:computername" -replace "-database mdt", "-database $sqldatabase" } | Set-Content "D:\DeploymentShare\Scripts\MDTp\TS_Install_SQL_Import_Update_serialnumber_Wifi.ps1"
(Get-Content "D:\DeploymentShare\Scripts\MDTp\TS_Install_PC_Info_Log.ps1") | ForEach-Object { $_ -replace "YOURsqlUSERpassword", $SQLpassword -replace "admin", $SQLuser -replace "-sqlServer mdtp", "-sqlServer $env:computername" -replace "-database mdt", "-database $sqldatabase" } | Set-Content "D:\DeploymentShare\Scripts\MDTp\TS_Install_PC_Info_Log.ps1"
Copy-Item "C:\Program Files\Microsoft DaRT\v10\DartRemoteViewer.exe" "D:\MDTp_Tools\SW_MDTp_Tool\Modules\DartRemoteViewer.exe"
$confirmation = Read-Host "Install new DC_Tools in the DC? (y/n)"
if ($confirmation -eq 'y') {
    # get credentials for MDTp_DC copy
    Write-Host "Enter domain controller Administrator password:"
    $credential = Get-Credential -Credential $domainname\administrator
    New-PSDrive -Name P -PSProvider FileSystem -Root "\\$dc\c$" -Credential $credential
    mkdir \\$dc\c$\MDTp_DC_Tools
    robocopy D:\MDTp_Tools\SW_MDTp_DC_Tools \\$dc\c$\MDTp_DC_Tools
    Copy-Item "D:\MDTp_Tools\SW_MDTp_DC_Tools\MDTp_DC_Tools.lnk" "\\$dc\c$\Users\Public\Desktop\MDTp_DC_Tools.lnk"
}
Write-Output "Install complete"
Pause