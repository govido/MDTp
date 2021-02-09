#Creat file with imagename and path information for autoimport after capture, servertasks checks every 5 minutes for finished captures to import 
$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment
$today = Get-Date -Format yyyy_MM_dd_HH_mm_ss

$imagepath = "D:\DeploymentShare\Captures\" + $tsenv.Value("Backupfile")
$foldername = $tsenv.Value("Backupfile") -replace ".wim",""
$description = $tsenv.Value("Description")

$report = @()
$report += New-Object psobject -Property @{Date=$today;Imagepath=$imagepath;Foldername=$foldername;Description=$description}
$report | Select-Object Date,Imagepath,Foldername,Description | export-csv \\mdtp\DeploymentShare\Scripts\MDTp\Servertasks\OS_Import\import_os_$foldername.csv -NoTypeInformation -append