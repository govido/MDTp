# Get the TS variables
$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment
$BIOS_PW = $tsenv.Value("BIOS_PW")

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