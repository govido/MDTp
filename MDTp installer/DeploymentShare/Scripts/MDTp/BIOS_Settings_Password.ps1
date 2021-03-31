# Get the TS variables
$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment
$BIOS_PW = $tsenv.Value("BIOS_PW")
$model = $tsenv.Value("model")
$make = $tsenv.Value("make")

#apply special BIOS to Lenovo E15 Gen2 AMD models
if ($model -eq "20T9S0N500"){
  $CSV_File = "\\mdtp\deploymentshare$\scripts\MDTp\E15Gen2Config.csv"
  $Get_CSV_Content = import-csv $CSV_File
  $BIOS = gwmi -class Lenovo_SetBiosSetting -namespace root\wmi 
    ForEach($Settings in $Get_CSV_Content)
    {
    $MySetting = $Settings.Setting
    $NewValue = $Settings.Value  
    $BIOS.SetBiosSetting("$MySetting,$NewValue") | out-null
    } 
$Save_BIOS = (gwmi -class Lenovo_SaveBiosSettings -namespace root\wmi)
$Save_BIOS.SaveBiosSettings()
}

#set supervisor password for LENOVO machines if nothing is set (requires F12, del boot)
if ($make -eq "LENOVO"){
if ((Get-CimInstance -Namespace root/WMI -ClassName Lenovo_BiosPasswordSettings).PasswordState -eq 0)
{
    $PasswordSet = Get-WmiObject -Namespace root\wmi -Class Lenovo_SetBiosPassword
    $result = ($PasswordSet.SetBiosPassword("pap,$BIOS_PW,$BIOS_PW,ascii,gr")).return
    if ($result -ne "Success")
    {
        exit 5000
    }
}
else
{
exit 0
}
}