$today = Get-Date -Format yyyy_MM_dd
#Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
#Install-Script -Name Get-WindowsAutoPilotInfo -Force
\\mdtp\DeploymentShare$\Scripts\MDTp\Get-WindowsAutoPilotInfo.ps1 -Name localhost -OutputFile \\mdtp\MDTp-Import$\PC-Infos\Intune-Import\Intune-Import_$today.csv -Append