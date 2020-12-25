$MDTpversion = "1.5"

#========================================================================
#
# Tool Name	: MDTp Tool
# Author 	: Sebastian Wypior
#
#========================================================================

#	In Visual Studio Code press Ctrl+K and after that Ctrl+0 to collapse all region markers an display only what you need
#	use Ctrl+K and Ctrl+J to unfold everything
#	

##Initialize######
[System.Void][System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')  				
[System.Void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework') 				
[System.Void][System.Reflection.Assembly]::LoadFrom('assembly\MahApps.Metro.dll')       				
[System.Void][System.Reflection.Assembly]::LoadFrom('assembly\System.Windows.Interactivity.dll') 
[System.Void][System.Reflection.Assembly]::LoadFrom('assembly\MahApps.Metro.IconPacks.dll') 
[System.Void][System.Reflection.Assembly]::LoadFrom('assembly\MahApps.Metro.IconPacks.FontAwesome.dll')
[System.Void][System.Reflection.Assembly]::LoadFrom('assembly\MahApps.Metro.IconPacks.Material.dll') 
[System.Void][System.Reflection.Assembly]::LoadFrom('assembly\MahApps.Metro.IconPacks.MaterialLight.dll') 
[System.Void][System.Reflection.Assembly]::LoadFrom('assembly\MahApps.Metro.IconPacks.MaterialDesign.dll')
[System.Void][System.Reflection.Assembly]::LoadFrom('assembly\MahApps.Metro.IconPacks.Modern.dll') 
[System.Void][System.Reflection.Assembly]::LoadFrom('assembly\SimpleDialogs.dll') 

[String]$ScriptDirectory = split-path $myinvocation.mycommand.path

function LoadXml ($global:filename) {
	$XamlLoader = (New-Object System.Xml.XmlDocument)
	$XamlLoader.Load($filename)
	return $XamlLoader
}

# Load MainWindow
$XamlMainWindow = LoadXml("$ScriptDirectory\main.xaml")
$Reader = (New-Object System.Xml.XmlNodeReader $XamlMainWindow)
$Form = [Windows.Markup.XamlReader]::Load($Reader)


$XamlMainWindow.SelectNodes("//*[@Name]") | % {
	try { Set-Variable -Name "$($_.Name)" -Value $Form.FindName($_.Name) -ErrorAction Stop }
	catch { throw }
}
 
Function Get-FormVariables {
	if ($global:ReadmeDisplay -ne $true) { Write-host "If you need to reference this display again, run Get-FormVariables" -ForegroundColor Yellow; $global:ReadmeDisplay = $true }
	write-host "Found the following interactable elements from our form" -ForegroundColor Cyan
	get-variable 
}
#Get-FormVariables

#Close the application
$Close.add_Click( {

		$Form.Close()
 
 })

# Change the Theme to Dark or Light
$Theme.Add_Click( {
	 $Theme = [MahApps.Metro.ThemeManager]::DetectAppStyle($Form)	
	 $my_theme = ($Theme.Item1).name
	 If ($my_theme -eq "BaseLight") {
			[MahApps.Metro.ThemeManager]::ChangeAppStyle($Form, $Theme.Item2, [MahApps.Metro.ThemeManager]::GetAppTheme("BaseDark"));		
				 
		}
	 ElseIf ($my_theme -eq "BaseDark") {					
			[MahApps.Metro.ThemeManager]::ChangeAppStyle($Form, $Theme.Item2, [MahApps.Metro.ThemeManager]::GetAppTheme("BaseLight"));			
		}		
 })
 
# Open Flyout
$Accent.add_Click( {
		$Flyout.IsOpen = $true
	})
 
# Find All Accent
$AccentD = [MahApps.Metro.ThemeManager]::Accents
$AccentColors = $($AccentD.Name)
 
# Populate Accent into the Conbobox
foreach ($item in $AccentColors) {
	$MAccent.Items.Add($item) | Out-Null
}
 
# On change selection change Accent
$MAccent.Add_SelectionChanged( {
 
	 $MTheme = [MahApps.Metro.ThemeManager]::DetectAppStyle($Form)	
	 
	 $Value = $MAccent.SelectedValue
 
	 [MahApps.Metro.ThemeManager]::ChangeAppStyle($Form, [MahApps.Metro.ThemeManager]::GetAccent("$Value"), $MTheme.Item1);	
 
 })

# Make PowerShell Disappear
$windowcode = '[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);'
$asyncwindow = Add-Type -MemberDefinition $windowcode -name Win32ShowWindowAsync -namespace Win32Functions -PassThru
$null = $asyncwindow::ShowWindowAsync((Get-Process -PID $pid).MainWindowHandle, 0)
 
# Force garbage collection just to start slightly lower RAM usage.
[System.GC]::Collect()

#region ----------------------------Variables

# date variable for all scripts -> same format for all -> dot to be filename save
$date = get-date -format yyyy_MM_dd_HH.mm
# guess the dc in the network -> primary dns probably is your DC
$Global:dc = (Get-DnsClientServerAddress -InterfaceAlias "Ethernet*" -AddressFamily IPv4).ServerAddresses | select-object -first 1
# guess your domainname -> dns suffix
$domainnameauto = (Get-DnsClient -InterfaceAlias Ethernet*).connectionspecificsuffix
# Import/Delte Logfile
$logfile = "D:\MDTp_Tools\Import-Logs\Import-$date.log"
# domainconfig
$domainconfig_path = "D:\MDTp_Tools\domainconfig.csv"
# tempcsv for selected PCs in MDTp_Tools Window
$tempcsv_maingrid = "D:\MDT-Import\_datagrid_select_temp.csv"

$tempcsv = "D:\MDT-Import\temp.csv"

#endregion -------------------------Variables

#------------------------MAIN---------------------------#

$MDTp_Tool.Add_Loaded( {
		refresh_db_datagrid
		refresh_monitoring
		WDSstatus
		load_staggered_pcs
		if (Test-Path -path ".\automatic_staggered_deploy_on.txt") {
			$staggered_deploy_checkbox.ischecked = 0
		}
		else {
			$staggered_deploy_checkbox.ischecked = 1
		}
		$status.Text = "Ready to start"
	})

#region ----------------------------Common-Functions

#import MDT-Powershell Tools
Import-Module "C:\Program Files\Microsoft Deployment Toolkit\bin\MicrosoftDeploymentToolkit.psd1"
#connect MDTp deploymentshare on startup
New-PSDrive -Name "DS001" -PSProvider MDTProvider -Root "D:\DeploymentShare"
#connect SQL MDTp-Database
# MDT Database Powershell Module (Import/Delete)
Import-Module -name .\Modules\MDTDB.psm1
#Open a connection to our MDTp-database
Connect-MDTDatabase -sqlServer mdtp -instance SQLEXPRESS -database mdt

#windows explorer open file dialog
Function OpenFileDialog ($folder, $filetype) {
    

	[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |
	Out-Null
	  
	$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
	$OpenFileDialog.initialDirectory = $folder
	$OpenFileDialog.filter = "$filetype |*.$filetype"
	$OpenFileDialog.ShowDialog() | Out-Null
	$OpenFileDialog.filename
	$OpenFileDialog.ShowHelp = $true
}

#variables for domain stuff for all functions, powered by domainconfig
function load_domainconfig {
	$domainconfig = import-csv $domainconfig_path
  
	foreach ($option in $domainconfig) {
	  
		$Global:ADjoinUser = $option.ADjoinUser
		$Global:ADjoinPW = $option.ADjoinPW
		$Global:domainname = $option.Domainname
		$Global:PC_OU = $option.PC_OU
		$Global:oshomepage = $domainconfig.oshomepage
		$Global:AdminPassword_local = $domainconfig.adminpassword_local
		$Global:windows_10_key = $domainconfig.windows_10_key
		$Global:broadcastip = $domainconfig.broadcastip
	 
	}
  
}
#start RDP-session with credentials
function rdp ($pc, $rdpcredential) {
	# take each computername and process it individually
	$pc | ForEach-Object {
   
		# if the user has submitted a credential, store it
		# safely using cmdkey.exe for the given connection
	  
		# extract username and password from credential
		$User = $Global:rdpcredential.UserName
		$Password = $Global:rdpcredential.GetNetworkCredential().Password
   
		# save information using cmdkey.exe
		cmdkey.exe /generic:$_ /user:$User /pass:$Password
   
		# initiate the RDP connection
		# connection will automatically use cached credentials
		# if there are no cached credentials, you will have to log on
		# manually, so on first use, make sure you use -Credential to submit
		# logon credential
   
		mstsc.exe /v $_ /f
	}
}

#endregion -------------------------Common-Functions


#region ----------------------------Domainconfig_Flyout
$Open_DomainSettings.Add_Click( {
		$FlyOutDomainSettings.IsOpen = $true    
	})

$FlyOutDomainSettings.add_KeyUp( {
		if ($adjoinpw_pw_verify.password -eq $adjoinpw_pw.password) {
			$adjoinpw_info_text.content = "Passwords match :)" 
		}
		else {
			$adjoinpw_info_text.content = "Passwords differ!!! :("
		}

		if ($adminpassword_local_pw_verify.Password -eq $adminpassword_local_pw.Password) {
			$local_adminpw_info_text.content = "Passwords match :)"
		}
		else {
			$local_adminpw_info_text.content = "Passwords differ!!! :("
		}
	})

$FlyOutDomainSettings.add_loaded( {
		if (Test-Path "D:\MDTp_Tools\domainconfig.csv" -PathType Leaf) {
			$domainconfigfile = "D:\MDTp_Tools\domainconfig.csv"
		}
		else {
			$domainconfigfile = "D:\MDTp_Tools\template_domainconfig.csv"
		}
		$domainname_auto = (Get-DnsClient -InterfaceAlias Ethernet*).connectionspecificsuffix
		#magic, split domain name for OU display
		$domainnetbios, $domainend = $domainname_auto.Split(".")

		$domainconfig = import-csv $domainconfigfile

		foreach ($option in $domainconfig) {

			$ADjoinUser = $option.ADjoinUser
			$ADjoinPW = $option.ADjoinPW
			$domainname = $option.Domainname
			$PC_OU = $option.PC_OU
			$oshomepage = $domainconfig.oshomepage
			$AdminPassword_local = $domainconfig.adminpassword_local
			$windows_10_key = $domainconfig.windows_10_key

		}
		$domainname_text.Text = $domainname
		$ADjoinUser_text.Text = $ADjoinUser
		$adjoinpw_pw.password = $ADjoinPW
		$PC_OU_text.Text = $PC_OU
		$domainname_auto_text.content = "Automatic detect: $domainname_auto"
		$ou_info_text.content = "Template: OU=upperOUName,OU=lowerOUName,DC=$domainnetbios,DC=$domainend"
		$oshomepage_text.text = $oshomepage
		$AdminPassword_local_pw.password = $domainconfig.adminpassword_local
		$windows_10_key_text.text = $domainconfig.windows_10_key

	})

$save.Add_Click( {
		$report_domain = @()
		$report_domain += New-Object psobject -Property @{ADjoinUser = $ADjoinUser_text.Text; ADjoinPW = $adjoinpw_pw.password; Domainname = $domainname_text.Text; PC_OU = $PC_OU_text.Text; OSHomepage = $OSHomepage_text.text; AdminPassword_local = $adminpassword_local_pw.password; Windows_10_key = $windows_10_key_text.text }
		$report_domain  | select ADjoinUser, ADjoinPW, Domainname, PC_OU, OSHomepage, AdminPassword_local, Windows_10_key | export-csv "D:\MDTp_Tools\domainconfig.csv" -NoTypeInformation
		$status.Text = "New domainconfig saved! :)"
		$FlyOutDomainSettings.IsOpen = $false   
	})

$save_domain_mdt_template_import_button.add_Click( {
		$report_domain = @()
		$report_domain += New-Object psobject -Property @{ADjoinUser = $ADjoinUser_text.Text; ADjoinPW = $adjoinpw_pw.password; Domainname = $domainname_text.Text; PC_OU = $PC_OU_text.Text; OSHomepage = $OSHomepage_text.text; AdminPassword_local = $adminpassword_local_pw.password; Windows_10_key = $windows_10_key_text.text }
		$report_domain  | select ADjoinUser, ADjoinPW, Domainname, PC_OU, OSHomepage, AdminPassword_local, Windows_10_key | export-csv "D:\MDTp_Tools\domainconfig.csv" -NoTypeInformation
		$status.Text = "New domainconfig saved! :)"

		$FlyOutDomainSettings.IsOpen = $false   
	})
#endregion -------------------------Domainconfig_Flyout

#region ----------------------------DB_Tools_Flyout

$MDTp_DB_Tools.IsOpen( {
		load_domainconfig
		$pc_ou_text.text = $PC_OU
		$csvname = $save_csv_text.text
		$savepath_label.content = "D:\MDT-Import\$csvname-$date.csv"
		if (Test-Path $tempcsv_maingrid) {
			load_csv_datagrid $tempcsv_maingrid
		}
		write-host test
	})

$MDTp_DB_Tools.ClosingFinished( {
		Remove-Item $tempcsv
		Remove-Item $tempcsv_maingrid
		write-host test2
	})

function load_csv_datagrid ($tempcsvname) {
	$pcs_datagrid.Items.Clear()
	$tempcsvimport = import-csv -path $tempcsvname
	foreach ($pc in $tempcsvimport) {
		  
		$rowdata = New-Object PSObject
	  
		$rowdata = $rowdata | Add-Member Noteproperty Hostname $pc.hostname -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty ClientID $pc.clientid -PassThru    
		$rowdata = $rowdata | Add-Member Noteproperty Assettag $pc.assettag -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty UUID $pc.uuid -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty TasksequenceID $pc.TasksequenceID -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty Product $pc.product -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty Make $pc.make -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty Model $pc.model -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty Drivergroup $pc.drivergroup -PassThru
	  
		$pcs_datagrid.items.add($rowdata)
	}	
}

$select_csv_button.Add_Click( { 
		$CSVfile = OpenFileDialog "D:\MDT-Import" "CSV"
		import-csv -path $CSVfile | Out-GridView -PassThru -Title "Filter für MDT PC-Import" | export-csv -Path $tempcsv -NoTypeInformation
		load_csv_datagrid $tempcsv
 })

#only acitivate buttons if checkbox active
$save_csv_checkbox.Add_Click( {
		if ($save_csv_checkbox.IsChecked) {
			$save_csv_text.Visibility = "Visible"
		}
		else {
			$save_csv_text.Visibility = "Hidden"
		}
	})


#endregion -------------------------DB_Tools_Flyout

#region ----------------------------MDTp-Status_Tab

#region Database_tools-----------------------#

#DHCP-Export DC
$dc_rdp_button.Add_Click( {
		# promt for adminpassword for DC, start rdp connection
		$status.text = "Enter credentials for domaincontroller (Admin)"
		$Global:credential = Get-Credential -Credential $domainnameauto\administrator
		rdp $Global:dc $Global:credential
		$status.text = "DHCP-Export will be saved in D:\MDT-Import"
	})

$db_tools_button.Add_Click( {
		load_domainconfig
		$pc_ou_db_text.text = $PC_OU
		$csvname = $save_csv_text.text
		$savepath_label.content = "D:\MDT-Import\$csvname-$date.csv"
		if (Test-Path $tempcsv_maingrid) {
			load_csv_datagrid $tempcsv_maingrid
		}
		$MDTp_DB_Tools.isOpen = $true
	})

$DB_datagrid.Add_MouseRightButtonDown( {
		foreach ($item in $DB_datagri.SelectedItems) {
			$item | export-csv $tempcsv_maingrid -append -NoTypeInformation -force 
		}
		. .\Scripts\MDTp_Tool_Scripts\MDTp_DB_Tools_3.0.ps1
	})

$DB_datagrid.Add_SelectionChanged( {
		if ($DB_datagrid.SelectedItems -ne $null) {
			$filter_datagrid_button.isEnabled = $true
			$wol_button.isEnabled = $true
			$ping_button.isEnabled = $true
			$RDP_main_button.isEnabled = $true
		}
		else {
			$filter_datagrid_button.IsEnabled = $false
			$wol_button.IsEnabled = $false
			$ping_button.IsEnabled = $false
			$RDP_main_button.IsEnabled = $false
		}
	})

#Datagrid buttons:
$wol_button.Add_click( { 
		$str_wol = $NULL
		foreach ($item in $DB_datagrid.SelectedItems) {
	  $mac = $item.clientid
	  .\Modules\wol.exe $mac $broadcastip
	  $str_wol += "$mac, "
		}
		$status_wol.Text = "PCs $str_wol started with WoL"
 })
$ping_button.Add_click( { ping_datagrid $this $_ })

$RDP_main_button.Add_click( { 
		foreach ($pc in ($DB_datagrid.SelectedItems).hostname) {
			rdp $pc $Global:credentialrdp
		}
 })

#Datagrid functions:
function refresh_db_datagrid {
	$status.Text = "SQL Database refresh, please wait"
	$DB_datagrid.Items.Clear()
	foreach ($pc in (Get-MDTComputer).macaddress) {
		$rowdata = New-Object PSObject
	
		$rowdata = $rowdata | Add-Member Noteproperty Hostname (Get-MDTComputer -macaddress $pc).osdcomputername -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty ClientID $pc -PassThru    
		$rowdata = $rowdata | Add-Member Noteproperty Assettag (Get-MDTComputer -macaddress $pc).assettag -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty TasksequenceID (Get-MDTComputer -macaddress $pc).TasksequenceID -PassThru
		$mac_clean = $pc.replace(':', '')
		$rowdata = $rowdata | Add-Member Noteproperty PXE-Boot (get-wdsclient -deviceid $mac_clean).group -PassThru
		$bootimage = (get-wdsclient -deviceid $mac_clean).bootimagepath
		if ($bootimage -ne "") {
			$rowdata = $rowdata | Add-Member Noteproperty Bootimage (split-path -path $bootimage -leaf) -PassThru
		}
		$pcname = (Get-MDTComputer -macaddress $pc).osdcomputername 
		$pc_log_csv = import-csv "D:\MDT-Import\PC-Infos\$pcname.csv" | Select-Object -Last 1
		$rowdata = $rowdata | Add-Member Noteproperty Product $pc_log_csv.product -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty Laptop $pc_log_csv.laptop -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty Installdate $pc_log_csv.date -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty WIM_File (split-path -path $pc_log_csv.WIM_File -leaf) -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty Make $pc_log_csv.make -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty Model $pc_log_csv.model -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty Tasksequence_log $pc_log_csv.tasksequenceid -PassThru
	
		$DB_datagrid.items.add($rowdata)
		$pc_log_csv = $null
	}
	$status.Text = "SQL Database refresh finished"
}

$refresh_datagrid_button.add_click( { 
		refresh_db_datagrid
 })


#endregion Database_tools--------------------#

#region WDS_tools----------------------------#
$zerotouch_on_button.Add_Click( {
		$imagenamezero = (Get-WdsBootImage | where "Imagename" -match "Zero*").ImageName
		$imagenameall = (Get-WdsBootImage).ImageName
		foreach ($imagename in $imagenameall) {
			Disable-WDSBootImage -ImageName $imagename -Architecture X64
		}
		foreach ($imagename2 in $imagenamezero) {
			Enable-WDSBootImage -ImageName $imagename2 -Architecture X64
		}
		$status.Text = "$imagenamezero has been activated! All other bootimages are inactive."
		WDSstatus   
	})

$litetouch_on_button.Add_Click( {
		$imagenamelite = (Get-WdsBootImage | where "Imagename" -match "Lite*").ImageName
		$imagenameall = (Get-WdsBootImage).ImageName
		foreach ($imagename in $imagenameall) {
			Disable-WDSBootImage -ImageName $imagename -Architecture X64
		}
		foreach ($imagename2 in $imagenamelite) {
			Enable-WDSBootImage -ImageName $imagename2 -Architecture X64
		}
		$status.Text = "$imagenamelite has been activated! All other bootimages are inactive."
		WDSstatus
	})

function WDSstatus {
	#Active Bootimages
	$activeimage = (Get-WdsBootImage | where "enabled" -match "true").ImageName  
	#Inactive Bootimages
	$inactiveimage = (Get-WdsBootImage | where "enabled" -match "false").ImageName

	$wds_status_active.Text = $activeimage
	$wds_status_inactive.Text = $inactiveimage
}
#endregion WDS_tools-------------------------#

#region Staggered_deploy---------------------#

#function to make refresh at start possible
function load_staggered_pcs {
	$staggered_listbox.items.clear()
	foreach ($pc in Get-ChildItem D:\DeploymentShare\MDTp_Staggered_Deploy\ -Filter *.stop -name) {
		$staggered_listbox.items.add($pc)
	}
}

#button for manual refresh
$staggered_refresh_button.Add_Click( { 
		load_staggered_pcs
		$status.Text = "Staggered deploy refresh complete"
	})

$staggered_deploy_start_button.Add_Click( {
		$allselected = $staggered_listbox.SelectedItems
		foreach ($file in $staggered_listbox.SelectedItems) {
			Remove-Item D:\DeploymentShare\MDTp_Staggered_Deploy\$file
		}
		$status.Text = "Install started for $allselected" 
		load_staggered_pcs  
	})

$staggered_deploy_checkbox.Add_Unchecked( {
		New-Item D:\DeploymentShare\MDTp_Staggered_Deploy\automatic_staggered_deploy_on.txt
		$status.Text = "PCs will start install after 5 minutes automatically" 
	})

$staggered_deploy_checkbox.Add_checked( {
		Remove-Item D:\DeploymentShare\MDTp_Staggered_Deploy\automatic_staggered_deploy_on.txt
		$status.Text = "PCs only start install if started from this UI (better for slow networks or many PCs loading Litetouch at the same time)" 
	})

#endregion Staggered_deploy------------------#

#endregion -------------------------MDTp-Status_Tab

#region ----------------------------Deploy-Monitoring_Tab

#refresh monitoring data function
function refresh_monitoring {
	$status.Text = "Monitoring Database refresh, please wait"
	$monitoring_grid.items.clear()
	
	foreach ($deploy_pc in (Get-MDTMonitorData -Path DS001:).id) {
		$rowdata = New-Object PSObject
 
		$rowdata = $rowdata | Add-Member Noteproperty ID $deploy_pc -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty Name (Get-MDTMonitorData -Path DS001: -id $deploy_pc).name -PassThru    
		$rowdata = $rowdata | Add-Member Noteproperty PercentComplete (Get-MDTMonitorData -Path DS001: -id $deploy_pc).PercentComplete -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty Stepname (Get-MDTMonitorData -Path DS001: -id $deploy_pc).StepName -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty StartTime (Get-MDTMonitorData -Path DS001: -id $deploy_pc).StartTime -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty EndTime (Get-MDTMonitorData -Path DS001: -id $deploy_pc).EndTime -PassThru
		$status = (Get-MDTMonitorData -Path DS001: -id $deploy_pc).Deploymentstatus 
		if ($status -eq 1) { $status = "Installing..." }
		elseif ($status -eq 2) { $status = "Failed!" }
		elseif ($status -eq 3) { $status = "Install finished" }
		elseif ($status -eq 4) { $status = "Unresponsive" }
		$rowdata = $rowdata | Add-Member Noteproperty Deploymentstatus $status -PassThru
		#$rowdata = $rowdata | Add-Member Noteproperty Deploymentstatuscolor (Get-MDTMonitorData -Path DS001: -id $deploy_pc).Deploymentstatus
		$rowdata = $rowdata | Add-Member Noteproperty CurrentStep (Get-MDTMonitorData -Path DS001: -id $deploy_pc).CurrentStep -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty TotalSteps (Get-MDTMonitorData -Path DS001: -id $deploy_pc).TotalSteps -PassThru
    
		$monitoring_grid.items.add($rowdata)
	}
	$status.Text = "Monitoring Database refresh finished"
}

#only acitivate buttons if data is really selected
$monitoring_grid.Add_SelectionChanged( {
		if ($monitoring_grid.SelectedItems -ne $null) {
			$DART_button.isEnabled = $true
			$RDP_button.isEnabled = $true
		}
		else {
			$DART_button.isEnabled = $false
			$RDP_button.isEnabled = $false
		}
	})

#give function to the refresh button
$refresh_monitoring_button.add_click( {
		refresh_monitoring
	})

#function to open DART from multiple selected entries
function DART ($dartticketnumber, $dartipaddress, $dartport) {
	.\Modules\DartRemoteViewer.exe -ticket="$dartticketnumber" -ipaddress="$dartipaddress" -port="$dartport"
}

#Windows PE remote monitoring with DART in PE-Image
function dart_rv_start { 
	foreach ($deploy_pc in ($monitoring_grid.SelectedItems).id) {
		Dart (Get-MDTMonitorData -Path DS001: -id $deploy_pc).dartticket (Get-MDTMonitorData -Path DS001: -id $deploy_pc).dartip (Get-MDTMonitorData -Path DS001: -id $deploy_pc).dartport
	}
}

$DART_button.Add_click( {
		dart_rv_start
	})

$monitoring_grid.Add_MouseRightButtonDown( {
		dart_rv_start
	})

#Normal RDP to connect after install with presaved credentials
$RDP_button.Add_click( {
		foreach ($deploy_pc in ($monitoring_grid.SelectedItems).id) {
			rdp (Get-MDTMonitorData -Path DS001: -id $deploy_pc).name $Global:credentialrdp
		}
	})
#endregion -------------------------Deploy-Monitoring_Tab

#region ----------------------------TS_Image_Driver_Tab
#endregion -------------------------TS_Image_Driver_Tab

#region ----------------------------Options_Logs_Tab

#Shortcut to MDT-Import folder, where most of pc-data is stored in CSV-files (DHCP-Export, installinfo, logs)
$import_folder.Add_Click( { 
		ii D:\MDT-Import
	})

#CSV edit with CSV Buddy
$csv_edit_button.Add_Click( { $status.Text = "Open and edit CSV-file to save it (certain PCs, rooms etc.)"
		$CSVfile = OpenFileDialog "D:\MDT-Import" "CSV"
		D:\MDTp_Tools\SW_CSVBuddy\CSVBuddy-2_1_6-64-bit.exe $CSVfile 
	})

#PC reports from all single CSVs
$create_report_button.add_click( {
		md D:\MDT-Import\PC-Reports
		$date = get-date -format yyyy_MM_dd_HH.mm
		$csvname = "D:\MDT-Import\PC-Reports\PC_Install_Report_$date.csv"
		$pc_csvs = (Get-ChildItem D:\MDT-Import\PC-Infos *.csv).FullName
		foreach ($file in $pc_csvs) {
			$pc_infos = Import-Csv -Path $file | Select-Object -Last 1
			$pc_infos | export-csv -path $csvname -NoTypeInformation -Append -Force
		}
		$status.Text = "PC-Report saved to $csvname"

		$Dialog = [SimpleDialogs.Controls.MessageDialog]::new()		
		$Dialog.MessageSeverity = "Warning"
		$Dialog.Title = "WARNING!!!"
		$Dialog.TitleForeground = "White"	
		
		$Dialog.Message = "ALL WILL BE ERASED"			
		[SimpleDialogs.DialogManager]::ShowDialogAsync("ee", $Dialog)	
	})

#open PC-Report with CSV Buddy
$open_report_button.Add_Click( {
		$infocsv = OpenFileDialog "D:\MDT-Import\PC-Reports" "CSV" 
		D:\MDTp_Tools\SW_CSVBuddy\CSVBuddy-2_1_6-64-bit.exe $infocsv
	})


#endregion -------------------------Options_Logs_Tab

$Form.ShowDialog() | Out-Null