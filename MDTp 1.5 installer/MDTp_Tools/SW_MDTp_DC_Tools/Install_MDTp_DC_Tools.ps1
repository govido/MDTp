# A little itelligence for a machine that is not part of the domain, getting domain name from DNS
$domainname = (Get-DnsClient -InterfaceAlias Ethernet*).connectionspecificsuffix
# Guessing the domain controller from primary DNS-Server entry
$dc = (Get-DnsClientServerAddress -InterfaceAlias "Ethernet*" -AddressFamily IPv4).ServerAddresses | select-object -first 1
# Enter domain admin credentials to start install
$credential = Get-Credential -Credential $domainname\administrator
New-PSDrive -Name P -PSProvider FileSystem -Root "\\$dc\c$" -Credential $credential
mkdir \\$dc\c$\MDTp_DC_Tools
robocopy D:\MDTp_Tools\SW_MDTp_DC_Tools \\$dc\c$\MDTp_DC_Tools
copy-item "D:\MDTp_Tools\SW_MDTp_DC_Tools\MDTp_DC_Tools.lnk" "\\$dc\c$\Users\Public\Desktop\MDTp_DC_Tools.lnk"
write-output "MDTp_Tools have been copied to the DC, run MDT-DC from the desktop shortcut"