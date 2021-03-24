# Vers 1.2 CSV
# Inventory Script by SEWY for MDT Database
$today = Get-Date -Format yyyy_MM_dd_hh_mm_ss
# Get the TS variables
$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment

$OSDComputerName = $tsenv.Value("OSDComputerName")
$MACHINEOBJECTOU = $tsenv.Value("MACHINEOBJECTOU")
$MACADDRESS001 = $tsenv.Value("MACADDRESS001")
$MAKE = $tsenv.Value("MAKE")
$MODEL = $tsenv.Value("MODEL")
$MEMORY = Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum | Foreach {"{0:N2}" -f ([math]::round(($_.Sum / 1GB),2))}
$PRODUCT = $tsenv.Value("PRODUCT")
$SERIALNUMBER = $tsenv.Value("SERIALNUMBER")
$TASKSEQUENCEID = $tsenv.Value("TASKSEQUENCEID")
$IMAGEBUILD = $tsenv.Value("IMAGEBUILD")
$ISLAPTOP = $tsenv.Value("ISLAPTOP")
$INSTALLFROMPATH = $tsenv.Value("INSTALLFROMPATH")
$DRIVERGROUP001 = $tsenv.Value("DRIVERGROUP001")
$UUID = $tsenv.Value("UUID")
$JOINDOMAIN = (Get-ComputerInfo).csdomain
$CPU = (Get-ComputerInfo).CsProcessors
$GPU = (Get-WmiObject win32_VideoController).name

#Import the module that allows us to interact with MDT
Import-Module -name "\\mdtp\DeploymentShare$\Scripts\MDTp\MDTDB_PE_SEWY.psm1"

Connect-MDTDatabase -sqlServer mdtp -instance SQLEXPRESS -database mdt -user admin -password YOURsqlUSERpassword
#read Assettag from database
$ASSETTAG=(Get-MDTComputer -macAddress $MACADDRESS001).assettag
if ($ASSETTAG -eq $NULL){
$ASSETTAG=(Get-MDTComputer -serialnumber $SERIALNUMBER).assettag
}

write-host $ASSETTAG

$report = @()
$report += New-Object psobject -Property @{Date=$today;Hostname=$OSDComputerName;ClientID=$MACADDRESS001;UUID=$UUID;Assettag=$ASSETTAG;Drivergroup=$DRIVERGROUP001;OU=$MACHINEOBJECTOU;Domain=$JOINDOMAIN;Make=$MAKE;Model=$MODEL;Product=$PRODUCT;CPU=$CPU;GPU=$GPU;Memory=$MEMORY;Serialnumber=$SERIALNUMBER;TasksequenceID=$TASKSEQUENCEID;WinBuild=$IMAGEBUILD;WIM_File=$INSTALLFROMPATH;Laptop=$ISLAPTOP}
$report | select Date,Hostname,ClientID,UUID,Assettag,DriverGroup,OU,Domain,Make,Model,Product,CPU,GPU,Memory,Serialnumber,TasksequenceID,WinBuild,WIM_File,Laptop| export-csv \\mdtp\MDTp-Import$\PC-Infos\$OSDComputerName.csv -NoTypeInformation -append

$tsenv.Value("OSDImageName") = split-path $tsenv.Value("Installfrompath") -leaf

#Start-Transcript \\mdtp\MDT-Import$\Variables.txt
#$tsenv.GetVariables() | % { Write-Host "$_ = $($tsenv.Value($_))" }
#Stop-Transcript
