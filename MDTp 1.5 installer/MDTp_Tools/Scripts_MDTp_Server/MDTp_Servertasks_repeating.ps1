# Import captured images automagically into MDT Database and add info-file :)

Import-Module "C:\Program Files\Microsoft Deployment Toolkit\bin\MicrosoftDeploymentToolkit.psd1"
New-PSDrive -Name "DS001" -PSProvider MDTProvider -Root "D:\DeploymentShare"
$today = Get-Date -Format yyyy_MM_dd_HH:mm:ss

#get all csv-files, import as one csv
$images = import-csv -Path  (Get-ChildItem -Path "D:\DeploymentShare\Scripts\MDTp\Servertasks\OS_Import" -Filter '*.csv').FullName

foreach ($image in $images) {

    $text_info = "D:\DeploymentShare\Operating Systems\" + $image.foldername + "\" + $image.foldername + "_info.txt"
    $description = $image.Description
    import-mdtoperatingsystem -path "DS001:\Operating Systems" -SourceFile $image.imagepath -DestinationFolder $image.foldername -Verbose -move 
    $Description | out-file $text_info

    $report = @()
    if (Test-Path -path "D:\DeploymentShare\Operating Systems\" + $image.foldername + "\" + $image.foldername + ".wim") {
        Remove-Item "D:\DeploymentShare\Scripts\MDTp\Servertasks\OS_Import\import_os_" + $image.Foldername + ".csv" 
        $success = "Import success!"    
    }
    else { $success = "Import failed! Check MDTp-Path, free available space or wrong filenames" }
    $report += New-Object psobject -Property @{Date = $today; Imagepath = $image.Imagepath; Foldername = $image.foldername; Description = $Description; Result = $success }
    $report | Select-Object Date, Imagepath, Folder, Description | export-csv "D:\MDTp_Tools\Import-Logs\Import_OS_log.csv" -NoTypeInformation -append
}

# deactivate pxe start if client install has started successfully (client gets entry in the WDS-Server to skip PXE, loading the OS almost instant)
$pxe_pcs = import-csv -Path  (Get-ChildItem -Path "D:\DeploymentShare\Scripts\MDTp\Servertasks\WDS_PXE" -Filter '*.csv').FullName
$csv_files_pxe = (Get-ChildItem -Path "D:\DeploymentShare\Scripts\MDTp\Servertasks\WDS_PXE" -Filter '*.csv').FullName

foreach ($pc in $pxe_pcs) {
    
    #wdsutil doesn't like ':', converts csv-file variables to normal ones (otherwise parameters don't convert properly)
    $id = $pc.ClientId.replace(':', '-')
    $hostname = $pc.Hostname
    $pxeparameter1 = $pc.pxeparameter1
    $pxeparameter2 = $pc.pxeparameter2
    $pxeparameter3 = $pc.pxeparameter3
   
    #delete pc if already in database (avoiding conflicts if pc renamed or setting already present)
    Remove-WdsClient -DeviceID $id
    #WDS Powershell-Tool add new client with group-name to make sorting easier (not available in wdsutil) 
    New-WdsClient -DeviceID $id -Devicename $hostname -group $pxeparameter3
    #abortpxe.com as default, worked with BIOS, UEFI an VMware (new powershell tool abort option doesn't)
    wdsutil /set-device /id:$id /device:$hostname $pxeparameter1 $pxeparameter2
 

    #TESTING!!! doesn't work with BIOS VMware
    #New-WdsClient -DeviceID $id -Devicename $hostname -PxePromptPolicy abort -group $pxeparameter3

    $report = @()
    $report += New-Object psobject -Property @{Date = $today; Hostname = $pc.Hostname; ClientID = $pc.ClientID }
    $report | Select-Object Date, Hostname, ClientID | export-csv "D:\MDTp_Tools\Import-Logs\pxe_off_log.csv" -NoTypeInformation -append
}

Remove-Item $csv_files_pxe

# Staggered deploy automatic, this starts all pending clients automatically, if staggered deploy is deactivated in the GUI

if (Test-Path -path "D:\DeploymentShare\MDTp_Staggered_Deploy\automatic_staggered_deploy_on.txt") {
    Get-ChildItem D:\DeploymentShare\MDTp_Staggered_Deploy\  -Filter *.stop | Remove-Item
}

# Driver Import

$driverfolder = (Get-ChildItem -Path "D:\MDTp-Import\Drivers" -Directory).FullName

foreach ($driverpack in $driverfolder) {

    $infofile = import-csv -Path  (Get-ChildItem -Path $driverpack -Filter '*.csv').FullName
    $csvname = (Get-ChildItem -Path $driverpack -Filter '*.csv').FullName
    if ($infofile.driverfoldername -gt $null) {
        write-host Maiboard found
        new-item -path "DS001:\Out-of-Box Drivers\Windows_10_X64" -enable "True" -Name $infofile.driverfoldername -Comments $infofile.pcinfos -ItemType "folder" -Verbose
        $driverpath = "DS001:\Out-of-Box Drivers\Windows_10_X64\" + $infofile.driverfoldername
        import-mdtdriver -path $driverpath -SourcePath $driverpack -Verbose
        $report = @()
        $report += New-Object psobject -Property @{Date = $today; Foldername = $infofile.driverfoldername; PCinfos = $infofile.pcinfos}
        $report | Select-Object Date, Mainboard, PCinfos | export-csv "D:\MDTp_Tools\Import-Logs\Import_Drivers_log.csv" -NoTypeInformation -append
        Rename-Item -path $csvname -newname import_finished_csv
    }
    else {
         write-host Abort, no file or foldername found
    }
    $infofile = $null
}