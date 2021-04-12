$MDTpversion = Get-Content ".\MDTp_Tools\MDTp_Version.txt"
$domainname = (Get-DnsClient -InterfaceAlias Ethernet*).connectionspecificsuffix
$dc = (Get-DnsClientServerAddress -InterfaceAlias "Ethernet*" -AddressFamily IPv4).ServerAddresses | Select-Object -First 1
$customsettings = Get-Content D:\DeploymentShare\Control\CustomSettings.ini
$TASKSEQUENCEID = $customsettings | Where-Object { $_ -Match "TASKSEQUENCEID" }
$SkipTaskSequence = $customsettings | Where-Object { $_ -Match "SkipTaskSequence" }
$sqlstartline = ($customsettings | Select-String -Pattern "CSettings]").LineNumber
$sqlstopline = ($customsettings | Select-String -Pattern "MMSettings]").LineNumber
$sqlstartline = $sqlstartline - 1
$sqlstopline = $sqlstopline - 1
$CSettings = $customsettings[$sqlstartline..$sqlstopline]
$activecsettings = ($CSettings | Where-Object { $_ -Match "Parameters=" } | Where-Object { $_ -NotMatch "'" })

Write-Host "Install/Update"
Write-Host -ForegroundColor Green "MDTp $MDTpversion" 
Pause
if ((Test-Path -Path "D:\MDTp_Tools\SW_MDTp_Tool\Modules\DartRemoteViewer.exe") -eq $False) {
    Write-Host -ForegroundColor Yellow "DartRemoteViewer not found! `r`nBefore continuing copy ---MSDaRT100.msi--- in the same folder as this installscript for DaRT remote support"
    Pause
    msiexec /i MSDaRT100.msi /passive
}
mkdir D:\MDTp-Import\Drivers
mkdir D:\MDTp-Import\PC-Infos
mkdir D:\MDTp-Import\PC-Infos\Bitlocker-Keys
mkdir D:\MDTp-Import\PC-Infos\Intune-Import
mkdir D:\MDTp-Import\PC-Reports
mkdir D:\MDTp-Import\WIM-Images
mkdir D:\MDTp-Import\MDTp-Templates
mkdir D:\MDTp_Tools\Import-Logs
mkdir D:\DeploymentShare\MDTp_Staggered_Deploy
mkdir D:\DeploymentShare\Scripts\MDTp\OS_Import
mkdir D:\DeploymentShare\Scripts\MDTp\WDS_PXE
robocopy .\MDTp_Tools D:\MDTp_Tools /E
robocopy .\MDTp_Tools\Shortcuts "C:\Users\Public\Desktop"
robocopy .\MDTp-Import D:\MDTp-Import /E
robocopy .\DeploymentShare\ D:\DeploymentShare /E
foreach ($file in (Get-ChildItem .\MDTp-Import\MDTp-Templates *.xml)) {
    Copy-Item .\MDTp-Import\MDTp-Templates\$file "D:\MDTp-Import\MDTp-Templates\${MDTpversion}_${file}"
}
foreach ($template in (Get-ChildItem D:\MDTp-Import\MDTp-Templates *.xml).FullName | Where-Object { $_ -like "*$MDTpversion*" }) {
    (Get-Content $template) | ForEach-Object { $_ -replace "TEMPLATEversion", $MDTpversion } | Set-Content $template
}
Copy-Item "D:\MDTp_Tools\Scripts_Win_PE_DART\Unattend_PE_x64.xml" "C:\Program Files\Microsoft Deployment Toolkit\Templates\Unattend_PE_x64.xml"
Register-ScheduledTask -Xml (Get-Content '.\MDTp_Tools\Scripts_MDTp_Server\MDTp_Servertasks_5Mins.xml' | Out-String) -TaskName "MDTp_Servertasks_5Mins" -Force
New-SmbShare -Name "MDTp-Import$" -Path "D:\MDTp-Import" -FullAccess Administrator
Clear-Host
Write-Host "Litetouch and Zerotouch need to be updated with MDTp_Tool for DaRT-Support! (remote Windows PE)"
$localmdtpassword = Read-Host -Prompt 'Enter local MDTp Administrator password'
(Get-Content "D:\DeploymentShare\Control\Bootstrap_Zerotouch.ini") | ForEach-Object { $_ -replace "YOURlocalMDTpADMINpassword", $localmdtpassword -replace "mdtp", $env:computername } | Set-Content "D:\DeploymentShare\Control\Bootstrap_Zerotouch.ini"
$SQLuser = Read-Host -Prompt 'Enter SQL username (admin), press ENTER for default'
$SQLpassword = Read-Host -Prompt 'Enter SQL password'
$sqldatabase = Read-Host -Prompt 'Enter SQL database name (mdt), press ENTER for default'
if ($SQLuser -eq "") {
    $SQLuser = "admin" 
}
if ($sqldatabase -eq "") {
    $sqldatabase = "mdt" 
}
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
if (Test-Path -Path "D:\MDTp_Tools\domainconfig.csv") {
    $domainconfig = Import-Csv "D:\MDTp_Tools\domainconfig.csv"
    $Global:domainname = $domainconfig.Domainname
    $confirmation = Read-Host "Import new templates with existing domainconfig? (y/n)"
    
    if ($confirmation -eq 'y') {
        $templates = (Get-ChildItem D:\MDTp-Import\MDTp-Templates *.xml).FullName | Where-Object { $_ -like "*$MDTpversion*" }
        foreach ($file in $templates) {
            $domainnamets = $Global:domainname
            $filename = Split-Path $file -Leaf
            $exportpath = "D:\DeploymentShare\Templates\$domainnamets.$filename"
			
            [xml]$tsxml = Get-Content $file
            $steps = ($tsxml.sequence.group | Where-Object { $_.Name -eq "MDTp_Set_Custom_Variables" }).step
            #Domainname
            ($steps.defaultVarList | Where-Object { $_.variable."#text" -eq "JoinDomain" }).variable | Where-Object { $_.property -eq "VariableValue" } | ForEach-Object { $_."#text" = $domainconfig.Domainname }
            #Domainjoinuser_Domain
            ($steps.defaultVarList | Where-Object { $_.variable."#text" -eq "DomainAdminDomain" }).variable | Where-Object { $_.property -eq "VariableValue" } | ForEach-Object { $_."#text" = $domainconfig.Domainname }
            #Domainjoinuser
            ($steps.defaultVarList | Where-Object { $_.variable."#text" -eq "DomainAdmin" }).variable | Where-Object { $_.property -eq "VariableValue" } | ForEach-Object { $_."#text" = $domainconfig.ADjoinUser }
            #DomainJoinPW
            ($steps.defaultVarList | Where-Object { $_.variable."#text" -eq "DomainAdminPassword" }).variable | Where-Object { $_.property -eq "VariableValue" } | ForEach-Object { $_."#text" = $domainconfig.ADjoinPW }
            #AdminPassword_local
            ($steps.defaultVarList | Where-Object { $_.variable."#text" -eq "AdminPassword" }).variable | Where-Object { $_.property -eq "VariableValue" } | ForEach-Object { $_."#text" = $domainconfig.adminpassword_local }
            #MachineObjectOU
            ($steps.defaultVarList | Where-Object { $_.variable."#text" -eq "MachineObjectOU" }).variable | Where-Object { $_.property -eq "VariableValue" } | ForEach-Object { $_."#text" = $domainconfig.PC_OU }
            #OSHome_Page
            ($steps.defaultVarList | Where-Object { $_.variable."#text" -eq "OSHome_Page" }).variable | Where-Object { $_.property -eq "VariableValue" } | ForEach-Object { $_."#text" = $domainconfig.OSHomepage }
            #OrgName
            ($steps.defaultVarList | Where-Object { $_.variable."#text" -eq "OrgName" }).variable | Where-Object { $_.property -eq "VariableValue" } | ForEach-Object { $_."#text" = $domainconfig.domainname }
            #Productkey
            ($steps.defaultVarList | Where-Object { $_.variable."#text" -eq "ProductKey" }).variable | Where-Object { $_.property -eq "VariableValue" } | ForEach-Object { $_."#text" = $domainconfig.Windows_10_key }			
            #BIOS_PW
            ($steps.defaultVarList | Where-Object { $_.variable."#text" -eq "BIOS_PW" }).variable | Where-Object { $_.property -eq "VariableValue" } | ForEach-Object { $_."#text" = $domainconfig.bios_pw }	
			
            $tsxml.Save($exportpath)
            $newtemplates += "$domainnamets.$filename, " 
        }
			
        Write-Host -ForegroundColor Yellow "New MDTp-templates $newtemplates are ready to use"
    }
}
$customsettingsnew = Get-Content D:\DeploymentShare\Control\CustomSettings.ini
$SMSTSORGNAME = $customsettingsnew | Where-Object { $_ -Match "SMSTSORGNAME" }
$customsettingsnew -replace $SMSTSORGNAME, "_SMSTSORGNAME=MDTp 42 $MDTpversion by SeWy" | Set-Content D:\DeploymentShare\Control\CustomSettings.ini

if ($TASKSEQUENCEID -ne "'TaskSequenceID=W10_INSTALL_PXE" -or $SkipTaskSequence -ne "'SkipTaskSequence=YES") {
    $OLDTASKSEQUENCEID = $TASKSEQUENCEID
    $OLDSkipTaskSequence = $SkipTaskSequence
    $confirmkeep = Read-Host "Keep customsettings TS settings (skip/default TS)? (y/n)"
    if ($confirmkeep -eq 'y') {
        $customsettingsnew -replace "'TaskSequenceID=W10_INSTALL_PXE", $OLDTASKSEQUENCEID -replace "'SkipTaskSequence=YES", $OLDSkipTaskSequence | Set-Content D:\DeploymentShare\Control\CustomSettings.ini       
    }
}
$customsettingsnew = Get-Content D:\DeploymentShare\Control\CustomSettings.ini
if ($activecsettings -ne "Parameters=MacAddress") {
    $OLDCSettings = $activecsettings
    $confirmkeep = Read-Host "Keep customsettings PC SQL settings (MAC, SERIAL, UUID)? (y/n)"
    if ($confirmkeep -eq 'y') {
        $customsettingsnew -replace "Parameters=MacAddress", $OLDCSettings | Set-Content D:\DeploymentShare\Control\CustomSettings.ini
    }
}


Write-Host -ForegroundColor Green "Install complete"
Pause