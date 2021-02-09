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
$MEMORY = $tsenv.Value("MEMORY")
$PRODUCT = $tsenv.Value("PRODUCT")
$SERIALNUMBER = $tsenv.Value("SERIALNUMBER")
$TASKSEQUENCEID = $tsenv.Value("TASKSEQUENCEID")
$IMAGEBUILD = $tsenv.Value("IMAGEBUILD")
$ISLAPTOP = $tsenv.Value("ISLAPTOP")
$JOINDOMAIN = $tsenv.Value("JOINDOMAIN")
$INSTALLFROMPATH = $tsenv.Value("INSTALLFROMPATH")
$DRIVERGROUP001 = $tsenv.Value("DRIVERGROUP001")
$ASSETTAG = $tsenv.Value("ASSETTAG")
$UUID = $tsenv.Value("UUID")

$report = @()
$report += New-Object psobject -Property @{Date=$today;Hostname=$OSDComputerName;ClientID=$MACADDRESS001;UUID=$UUID;Assettag=$ASSETTAG;Drivergroup=$DRIVERGROUP001;OU=$MACHINEOBJECTOU;Domain=$JOINDOMAIN;Make=$MAKE;Model=$MODEL;Product=$PRODUCT;Memory=$MEMORY;Serialnumber=$SERIALNUMBER;TasksequenceID=$TASKSEQUENCEID;WinBuild=$IMAGEBUILD;WIM_File=$INSTALLFROMPATH;Laptop=$ISLAPTOP}
$report | select Date,Hostname,ClientID,UUID,Assettag,DriverGroup,OU,Domain,Make,Model,Product,Memory,Serialnumber,TasksequenceID,WinBuild,WIM_File,Laptop| export-csv \\mdtp\MDTp-Import$\PC-Infos\$OSDComputerName.csv -NoTypeInformation -append

$tsenv.Value("OSDImageName") = split-path $tsenv.Value("Installfrompath") -leaf

#verfügbare Variablen ausgeben
#Start-Transcript \\mdtp\MDT-Import$\Variables.txt
#$tsenv.GetVariables() | % { Write-Host "$_ = $($tsenv.Value($_))" }
#Stop-Transcript
