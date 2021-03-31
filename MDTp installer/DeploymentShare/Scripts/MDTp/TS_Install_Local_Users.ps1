# Get the TS variables
$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment
$localusers = $tsenv.Value("localusers")
$localpasswords = $tsenv.Value("localpasswords")
$localadmins = $tsenv.Value("localadmins")
$localadminpasswords = $tsenv.Value("localadminpasswords")

$localuserlist=$localusers.split(",")
$localpasswordlist=$localpasswords.split(",")
for ($i=0; $i -lt $localuserlist.length; $i++)
{
    New-LocalUser -Name $localuserlist[$i] -Password (ConvertTo-SecureString $localpasswordlist[$i] -AsPlainText -Force) -Description "local User-Account"
    #normal Users Group
    Add-LocalGroupMember -SID "S-1-5-32-545" -Member $localuserlist[$i]
    }

$localadminlist=$localadmins.split(",")
$localadminpasswordlist=$localadminpasswords.split(",")
for ($i=0; $i -lt $localadminlist.length; $i++)
{
    New-LocalUser -Name $localadminlist[$i] -Password (ConvertTo-SecureString $localadminpasswordlist[$i] -AsPlainText -Force) -Description "local Admin-Account"
    #Administrators Group
    Add-LocalGroupMember -SID "S-1-5-32-544" -Member $localadminlist[$i]
    }