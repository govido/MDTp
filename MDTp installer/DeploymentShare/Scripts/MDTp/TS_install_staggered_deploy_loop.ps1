$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment
$today = Get-Date -Format yyyy_MM_dd_hh_mm_ss
$OSDComputerName = $tsenv.Value("OSDComputerName")
$TASKSEQUENCEID = $tsenv.Value("TASKSEQUENCEID")
$INSTALLFROMPATH = $tsenv.Value("INSTALLFROMPATH")
"$today Ready to install $TASKSEQUENCEID with $INSTALLFROMPATH" > \\mdtp\DeploymentShare$\MDTp_Staggered_Deploy\$OSDComputerName.stop
do {
    if (Test-Path -Path "\\mdtp\DeploymentShare$\MDTp_Staggered_Deploy\$OSDComputerName.stop" -OutVariable Result) {
        Start-Sleep -Milliseconds 5000
    }
}
while ($Result)
