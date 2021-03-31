# SQL MDT Database Import Update Script for Windows PE by SeWy
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
$ASSETTAG = $tsenv.Value("AssetTag")
$UUID = $tsenv.Value("UUID")


#Import the module that allows us to interact with MDT
Import-Module -name "\\mdtp\DeploymentShare$\Scripts\MDTp\MDTDB_PE_SEWY.psm1"

Connect-MDTDatabase -sqlServer mdtp -instance SQLEXPRESS -database mdt -user admin -password YOURsqlUSERpassword
#read Assettag from database, if the PC hasn't been named manually, the Assettag is not loaded from the database by default
if ($tsenv.Value("manualpcname") -ne 1){
$ASSETTAG=(Get-MDTComputer -serialnumber $SERIALNUMBER).assettag
}

$machineid=Get-MDTComputer -serialnumber $SERIALNUMBER
if ($machineid.id -gt 0) 
			{
			Remove-MDTComputer $machineid.id
			}
		New-MDTComputer -description $OSDComputerName -serialnumber $SERIALNUMBER -assetTag $ASSETTAG -settings @{
			OSInstall='YES';
			SkipComputerName='YES';
			SkipDomainMembership='YES';
			SkipSummary='YES';
			SkipTaskSEquence='YES';
			SkipApplications='YES';
	 		OSDComputerName=$OSDComputerName;
			TaskSequenceID=$TASKSEQUENCEID;
			MachineObjectOU=$MACHINEOBJECTOU;
			DRIVERGROUP=$DRIVERGROUP001;
			}
