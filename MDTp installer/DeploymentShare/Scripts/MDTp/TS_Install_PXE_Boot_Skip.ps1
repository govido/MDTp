#create file tihe MAC and Hostname on MDTp Server, files are checked every 5 minutes and clients get entries in WDS presatged clients to skip PXE boot
$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment
$today = Get-Date -Format yyyy_MM_dd_HH_mm_ss
$filename = $tsenv.Value("OSDComputername")
$pxebootprogram = "/BootProgram:boot\x64\abortpxe.com"
$pxeextraparameter ="/force"
$pxegroup="PXE_SKIP"

$report = @()
$report += New-Object psobject -Property @{Date=$today;Hostname=$tsenv.Value("OSDComputername");ClientID=$tsenv.Value("MACADDRESS001");pxeparameter1=$pxebootprogram;pxeparameter2=$pxeextraparameter;pxeparameter3=$pxegroup}
$report | select Date,Hostname,ClientID,pxeparameter1,pxeparameter2,pxeparameter3 | export-csv "\\mdtp\DeploymentShare$\Scripts\MDTp\Servertasks\WDS_PXE\$filename.csv" -NoTypeInformation