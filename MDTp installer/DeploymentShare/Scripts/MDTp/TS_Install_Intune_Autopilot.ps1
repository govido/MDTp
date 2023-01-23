Start-Transcript -path \\mdtp\deploymentshare$\Intune_Register_output.txt -append

# Get the TS variables
$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment
$AppID = $tsenv.Value("AppID")
$TenantID = $tsenv.Value("TenantID")
$AppSecret = $tsenv.Value("AppSecret")
$GroupTag = $tsenv.Value("GroupTag")
$ProfileID = $tsenv.Value("ProfileID")
$OSDComputerName = $tsenv.Value("OSDComputerName")

Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Confirm:$false -Force:$true

Install-Module WindowsAutopilotIntune -Force

install-script get-windowsautopilotinfo -force

get-windowsautopilotinfo -Online -TenantId $TenantID -AppId $AppID -AppSecret $AppSecret -GroupTag $GroupTag

Connect-MSGraphApp -Tenant $TenantID -AppId $AppID -AppSecret $AppSecret

Get-AutopilotProfile -id $ProfileID | ConvertTo-AutopilotConfigurationJSON | Out-File c:\drivers\AutopilotConfigurationFile.json -Encoding ASCII

#Get Hardware Hash
$hwid = ((Get-WMIObject -Namespace root/cimv2/mdm/dmmap -Class MDM_DevDetail_Ext01 -Filter "InstanceID='Ext' AND ParentID='./DevDetail'").DeviceHardwareData)
#Get SerialNumber
$ser = (Get-WmiObject win32_bios).SerialNumber
#Use Computername if SerialNumber is empty
if([string]::IsNullOrWhiteSpace($ser)) { $ser = $env:computername}  

#Add-AutopilotImportedDevice -serialNumber $ser -hardwareIdentifier $hwid -groupTag $grouptag
#Invoke-AutopilotSync

$deviceID = (Get-AutopilotDevice -serial $ser).id
Set-AutopilotDevice -id $deviceID -displayName $OSDComputerName

Stop-Transcript
