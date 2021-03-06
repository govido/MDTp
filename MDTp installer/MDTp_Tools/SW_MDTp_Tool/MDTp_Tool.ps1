$MDTpversion = Get-Content "D:\MDTp_Tools\MDTp_Version.txt"

#========================================================================
#
# Tool Name	: MDTp Tool
# Author 	: Sebastian Wypior
#
#========================================================================

#	In Visual Studio Code press Ctrl+K and after that Ctrl+0 to collapse all region markers and display only what you need
#	use Ctrl+K and Ctrl+J to unfold everything
#	

##Initialize######
[System.Void][System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')  				
[System.Void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework') 				
[System.Void][System.Reflection.Assembly]::LoadFrom('Assembly\MahApps.Metro.dll')       				
[System.Void][System.Reflection.Assembly]::LoadFrom('Assembly\System.Windows.Interactivity.dll') 
[System.Void][System.Reflection.Assembly]::LoadFrom('Assembly\MahApps.Metro.IconPacks.dll') 
[System.Void][System.Reflection.Assembly]::LoadFrom('Assembly\MahApps.Metro.IconPacks.FontAwesome.dll')
[System.Void][System.Reflection.Assembly]::LoadFrom('Assembly\MahApps.Metro.IconPacks.Material.dll') 
[System.Void][System.Reflection.Assembly]::LoadFrom('Assembly\MahApps.Metro.IconPacks.MaterialLight.dll') 
[System.Void][System.Reflection.Assembly]::LoadFrom('Assembly\MahApps.Metro.IconPacks.Modern.dll') 
[System.Void][System.Reflection.Assembly]::LoadFrom('Assembly\SimpleDialogs.dll') 

[String]$ScriptDirectory = Split-Path $myinvocation.mycommand.path

function LoadXml ($global:filename) {
	$XamlLoader = (New-Object System.Xml.XmlDocument)
	$XamlLoader.Load($filename)
	return $XamlLoader
}

# Load MainWindow
$XamlMainWindow = LoadXml("$ScriptDirectory\main.xaml")
$Reader = (New-Object System.Xml.XmlNodeReader $XamlMainWindow)
$Form = [Windows.Markup.XamlReader]::Load($Reader)


$XamlMainWindow.SelectNodes("//*[@Name]") | ForEach-Object {
	try { Set-Variable -Name "$($_.Name)" -Value $Form.FindName($_.Name) -ErrorAction Stop }
	catch { throw }
}
 
Function Get-FormVariables {
	if ($global:ReadmeDisplay -ne $true) { Write-Host "If you need to reference this display again, run Get-FormVariables" -ForegroundColor Yellow; $global:ReadmeDisplay = $true }
	Write-Host "Found the following interactable elements from our form" -ForegroundColor Cyan
	Get-Variable 
}
#Get-FormVariables

# Make PowerShell Disappear
#$windowcode = '[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);'
#$asyncwindow = Add-Type -MemberDefinition $windowcode -Name Win32ShowWindowAsync -Namespace Win32Functions -PassThru
#$null = $asyncwindow::ShowWindowAsync((Get-Process -PID $pid).MainWindowHandle, 0)
 
# Force garbage collection just to start slightly lower RAM usage.
[System.GC]::Collect()

#region ----------------------------Variables

# date variable for all scripts -> same format for all -> dot to be filename save
$date = Get-Date -Format yyyy_MM_dd_HH.mm
# guess the dc in the network -> primary dns probably is your DC
$Global:dc = (Get-DnsClientServerAddress -InterfaceAlias "Ethernet*" -AddressFamily IPv4).ServerAddresses | Select-Object -First 1
# guess your domainname -> dns suffix
$domainnameauto = (Get-DnsClient -InterfaceAlias Ethernet*).connectionspecificsuffix
# Import/Delte Logfile
$logfile = "D:\MDTp_Tools\Import-Logs\Import-$date.log"
# domainconfig
$domainconfig_path = "D:\MDTp_Tools\domainconfig.csv"
# tempcsv for selected PCs in MDTp_Tools Window
$tempcsv_maingrid = "D:\MDTp-Import\_datagrid_select_temp.csv"

$tempcsv = "D:\MDTp-Import\temp.csv"

#endregion -------------------------Variables

#------------------------MAIN---------------------------#

$MDTp_Tool.Add_Loaded( {
		# deactivate refresh if startperformance is bad (over 400PCs take about 15 seconds)
		refresh_db_datagrid
		refresh_monitoring
		WDSstatus
		load_staggered_pcs
		load_ts_list $ts_combobox2
		if (Test-Path -Path ".\automatic_staggered_deploy_on.txt") {
			$staggered_deploy_checkbox.ischecked = 0
		}
		else {
			$staggered_deploy_checkbox.ischecked = 1
		}
		customsettingsstatus
		$status.Text = "Ready to start"
		$MDTp_Tool.Title = "MDTp Tool $MDTpversion											be FASTER";
	})

###/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\##
#region -----------------Common-Functions--##
###/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\##

#import MDT-Powershell Tools
Import-Module "C:\Program Files\Microsoft Deployment Toolkit\bin\MicrosoftDeploymentToolkit.psd1"
#connect MDTp deploymentshare on startup
New-PSDrive -Name "DS001" -PSProvider MDTProvider -Root "D:\DeploymentShare"
#connect SQL MDTp-Database
# MDT Database Powershell Module (Import/Delete)
Import-Module -Name .\Modules\MDTDB.psm1
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
	$domainconfig = Import-Csv $domainconfig_path
  
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

#load TS list to comboboxes, lists etc.
function load_ts_list ($UIitemname_ts) {
	$UIitemname_ts.Items.Clear()
	$tsxml = New-Object xml
	$tsxml.load("D:\DeploymentShare\Control\TaskSequences.xml")
	# list all TS without those with _ in the beginning
	$ts_pick = ($tsxml.selectNodes("//tss/ts")).ID | Where-Object { $_ -notlike "_*" }
	foreach ($ts in $ts_pick) {
		$UIitemname_ts.items.add($ts)
	}
}

#load drivergroups to comboboxes, lists etc.
function load_drivergroup_list ($UIitemname_driver) {
	# empty for refresh
	$UIitemname_driver.items.clear()
	# load Drivergroups from XML:
	# defaultvalue set
	$drivergroup_combobox.items.add("NONE")
	$drivergroups = "D:\DeploymentShare\Control\DriverGroups.xml"
	[XML]$drivergroup_name = Get-Content $drivergroups
	$driverpick = ($drivergroup_name.groups.group).name | Where-Object { $_ -notlike "hidden" } | Where-Object { $_ -notlike "default" }
	foreach ($drivergroup in $driverpick) {
		$UIitemname_driver.items.add($drivergroup)
	}
	# defaultvalue select ("NONE")
	$UIitemname_driver.SelectedIndex = 0
}

# write TS and OS image info from selected TS item
function load_ts_info_item_selected ($UIitemselected, $UIitemTSinfo, $UIitemOSname, $UIitemOSinfo) {

	$tasksequence_pick = $UIitemselected.SelectedItem
	$tasksequence_xml = "D:\DeploymentShare\Control\$tasksequence_pick\ts.xml"

	$mdtTSxml = New-Object XML
	$mdtTSxml.Load($tasksequence_xml)
	$tsdescription = ($mdtTSxml.SelectSingleNode('//sequence')).description
	$ospickxml = $mdtTSxml.SelectSingleNode('//sequence/group/step[@type="BDD_InstallOS"]')
	$ospick = $ospickxml.defaultVarList.variable | Where-Object { ($_.Name -like "OSGUID") -and ($_.Property -like "OSGUID") }
	$ospick = $ospick.innertext

	#find imagename with GUID
	$mdtOSxml = New-Object XML
	$mdtOSxml.Load("D:\DeploymentShare\Control\Operatingsystems.xml")
	$ospathTS = ($mdtOSxml.selectSingleNode("//oss/os[@guid='$ospick']")).ImageFile.replace('.\', '\')
	$imagename = (Split-Path $ospathTS -Leaf).replace('.wim', '')
	$ospathcomplete = "D:\DeploymentShare\Operating Systems\$imagename\$imagename" + "_info.txt"
    
	$tsxml = New-Object xml
	$tsxml.load("D:\DeploymentShare\Control\TaskSequences.xml")
	$tscomments = ($tsxml.selectNodes("//tss/ts") | Where-Object ID -Like $tasksequence_pick).comments
	$UIitemOSinfo.text = Get-Content $ospathcomplete
	$UIitemTSinfo.text = "$tsdescription `r`n$tscomments"
	$UIitemOSname.text = "OS-Info für: $imagename.wim"

	#load custom TS variables to datagrid
	$TSvariables = $mdtTSxml.SelectNodes('//sequence/group[@name="MDTp_Set_Custom_Variables"]').step
	$ts_variables_datagrid.Items.Clear()
	foreach ($variable in $TSvariables) {
			  
		$rowdata = New-Object PSObject
		  
		$rowdata = $rowdata | Add-Member Noteproperty Disabled $variable.disable -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty Variablestep $variable.name -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty Variablename ($variable.defaultVarList.variable | Where-Object { ($_.Name -like "VariableName") -and ($_.Property -like "VariableName") })."#text" -PassThru    
		$rowdata = $rowdata | Add-Member Noteproperty VariableValue ($variable.defaultVarList.variable | Where-Object { ($_.Name -like "VariableValue") -and ($_.Property -like "VariableValue") })."#text" -PassThru
		  
		$ts_variables_datagrid.items.add($rowdata)
	}
}

###/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\##
#endregion --------------Common-Functions--##
###/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\##

###[][][][][][][][][][][][][][][][][][][][][][][][][]##
#region ------------------------Domainconfig_Flyout--##
###[][][][][][][][][][][][][][][][][][][][][][][][][]##

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

		$domainconfig = Import-Csv $domainconfigfile

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
		$bios_pw_text.text = $domainconfig.bios_pw

	})

function saveDomainConfig {
	$report_domain = @()
	$report_domain += New-Object psobject -Property @{ADjoinUser = $ADjoinUser_text.Text; ADjoinPW = $adjoinpw_pw.password; Domainname = $domainname_text.Text; PC_OU = $PC_OU_text.Text; OSHomepage = $OSHomepage_text.text; AdminPassword_local = $adminpassword_local_pw.password; Windows_10_key = $windows_10_key_text.text; BIOS_PW = $bios_pw_text.text }
	$report_domain | Select-Object ADjoinUser, ADjoinPW, Domainname, PC_OU, OSHomepage, AdminPassword_local, Windows_10_key, BIOS_PW | Export-Csv "D:\MDTp_Tools\domainconfig.csv" -NoTypeInformation
}


$save.Add_Click( {
		saveDomainConfig
		$status.Text = "New domainconfig saved! :)"
		$FlyOutDomainSettings.IsOpen = $false   
	})

$save_domain_mdt_template_import_button.add_Click( {
		saveDomainConfig

		#write settings to MDTp-TS-templates and save them
		$templates = (Get-ChildItem D:\MDTp-Import\MDTp-Templates *.xml).FullName | Where-Object { $_ -like "*$MDTpversion*" }
		foreach ($file in $templates) {
			$domainnamets = $domainname_text.Text
			$filename = Split-Path $file -Leaf
			$exportpath = "D:\DeploymentShare\Templates\$domainnamets.$filename"
			
			[xml]$tsxml = Get-Content $file
			$steps = ($tsxml.sequence.group | Where-Object { $_.Name -eq "MDTp_Set_Custom_Variables" }).step
			#Domainname
			($steps.defaultVarList | Where-Object { $_.variable."#text" -eq "JoinDomain" }).variable | Where-Object { $_.property -eq "VariableValue" } | ForEach-Object { $_."#text" = $domainname_text.Text }
			#Domainjoinuser_Domain
			($steps.defaultVarList | Where-Object { $_.variable."#text" -eq "DomainAdminDomain" }).variable | Where-Object { $_.property -eq "VariableValue" } | ForEach-Object { $_."#text" = $domainname_text.Text }
			#Domainjoinuser
			($steps.defaultVarList | Where-Object { $_.variable."#text" -eq "DomainAdmin" }).variable | Where-Object { $_.property -eq "VariableValue" } | ForEach-Object { $_."#text" = $ADjoinUser_text.Text }
			#DomainJoinPW
			($steps.defaultVarList | Where-Object { $_.variable."#text" -eq "DomainAdminPassword" }).variable | Where-Object { $_.property -eq "VariableValue" } | ForEach-Object { $_."#text" = $adjoinpw_pw.password }
			#AdminPassword_local
			($steps.defaultVarList | Where-Object { $_.variable."#text" -eq "AdminPassword" }).variable | Where-Object { $_.property -eq "VariableValue" } | ForEach-Object { $_."#text" = $adminpassword_local_pw.password }
			#MachineObjectOU
			($steps.defaultVarList | Where-Object { $_.variable."#text" -eq "MachineObjectOU" }).variable | Where-Object { $_.property -eq "VariableValue" } | ForEach-Object { $_."#text" = $PC_OU_text.Text }
			#OSHome_Page
			($steps.defaultVarList | Where-Object { $_.variable."#text" -eq "OSHome_Page" }).variable | Where-Object { $_.property -eq "VariableValue" } | ForEach-Object { $_."#text" = $OSHomepage_text.text }
			#OrgName
			($steps.defaultVarList | Where-Object { $_.variable."#text" -eq "OrgName" }).variable | Where-Object { $_.property -eq "VariableValue" } | ForEach-Object { $_."#text" = $domainname_text.Text }
			#Productkey
			($steps.defaultVarList | Where-Object { $_.variable."#text" -eq "ProductKey" }).variable | Where-Object { $_.property -eq "VariableValue" } | ForEach-Object { $_."#text" = $windows_10_key_text.text }			
			#BIOS_PW
			($steps.defaultVarList | Where-Object { $_.variable."#text" -eq "BIOS_PW" }).variable | Where-Object { $_.property -eq "VariableValue" } | ForEach-Object { $_."#text" = $bios_pw_text.text }	
			
			$tsxml.Save($exportpath)
			$newtemplates += "$domainnamets.$filename, "
		}
			
		$status.text = "Domainconfig saved! :) `r`nNew MDTp-templates $newtemplates are ready to use"
		$FlyOutDomainSettings.IsOpen = $false   
	})

###[][][][][][][][][][][][][][][][][][][][][][][][][]##
#endregion ---------------------Domainconfig_Flyout--##
###[][][][][][][][][][][][][][][][][][][][][][][][][]##

###[][][][][][][][][][][][][][][][][][][][][][][][][]##
#region ---------------------TS_info_OS_change_Flyout##
###[][][][][][][][][][][][][][][][][][][][][][][][][]##

$FlyoutTSinfo.add_IsOpenChanged( {
		load_ts_list $ts_combobox
		$os_listbox.Items.Clear()
		$os_listbox.isEnabled = $false
		$save_os_change_exit_button.isEnabled = $false
		#find imagename GUID
		$mdtOSxml = New-Object XML
		$mdtOSxml.Load("D:\DeploymentShare\Control\Operatingsystems.xml")
		$availableos = New-Object xml
		$availableos.Load("D:\DeploymentShare\Control\OperatingSystemGroups.xml")
		$nonhiddenos = $availableos.SelectNodes("//groups/group") | Where-Object Name -NE "hidden"
		$nonhiddenos_guids = $nonhiddenos.Member
		foreach ($osguid in $nonhiddenos_guids) {
			$imagename = Split-Path -Path ($mdtOSxml.selectNodes("//oss/os[@guid='$osguid']")).Source -Leaf
			$os_type = ($mdtOSxml.selectNodes("//oss/os[@guid='$osguid']")).Flags

			$os_listbox.items.add("$imagename,$os_type,$osguid")
		}

	})

$ts_combobox.Add_SelectionChanged( {
		load_ts_info_item_selected $ts_combobox $tsinfo_text $osname_text $osinfo_text
		
	})

$os_change_checkbox.Add_checked( {
		$os_listbox.isEnabled = $true
		$save_os_change_exit_button.isEnabled = $true
	})

$os_change_checkbox.Add_unchecked( {
		$os_listbox.isEnabled = $false
		$save_os_change_exit_button.isEnabled = $false
	})

$os_listbox.Add_SelectionChanged( {
		$imagename = $os_listbox.SelectedItem.split(',')[0]
		$ospathcomplete = "D:\DeploymentShare\Operating Systems\$imagename\$imagename" + "_info.txt"
		$osinfo_new_text.text = Get-Content $ospathcomplete
	})

$ts_variables_datagrid.Add_MouseRightButtonDown( {


		$TSvariablename = ($ts_variables_datagrid.SelectedItems[0]).VariableName
		if ($TSvariablename -ne $null) {
			# Show external dialog
			$result = [MahApps.Metro.Controls.Dialogs.DialogManager]::ShowModalInputExternal($Form, "Change TS variable:", ($ts_variables_datagrid.SelectedItems[0]).VariableName, $okAndCancel) 
  
			If ($result -ne $NULL) { 
				$tasksequence_pick = $ts_combobox.SelectedItem
				$tasksequence_xml = "D:\DeploymentShare\Control\$tasksequence_pick\ts.xml"
			
				[xml]$tsxml = Get-Content $tasksequence_xml
				$steps = ($tsxml.sequence.group | Where-Object { $_.Name -eq "MDTp_Set_Custom_Variables" }).step
			
				#add #text property if it is missing (not configured via domainconfig file)
				if ((($steps.defaultVarList | Where-Object { $_.variable."#text" -eq $TSVariableName }).variable | Where-Object { $_.property -eq "VariableValue" } | Where-Object { $_."#text" }) -eq $null) {
					$notextstep = ($steps.defaultVarList | Where-Object { $_.variable."#text" -eq $TSVariableName }).variable | Where-Object { $_.property -eq "VariableValue" }
					$notextstep.innertext = $result
				} 
				else {
					($steps.defaultVarList | Where-Object { $_.variable."#text" -eq $TSVariableName }).variable | Where-Object { $_.property -eq "VariableValue" } | ForEach-Object { $_."#text" = $result }	
				}
		
				$tsxml.Save($tasksequence_xml)
			
				$status.text = "TS variable changed :) `r`n$TSvariablename changed to $result" 
				load_ts_info_item_selected $ts_combobox $tsinfo_text $osname_text $osinfo_text
			}
		}
    
		
	})

$ts_variables_datagrid.Add_MouseDoubleClick( {

		$TSvariablestep = ($ts_variables_datagrid.SelectedItems[0]).VariableStep
		$tscheckboxvalue = ($ts_variables_datagrid.SelectedItems[0]).Disabled
		if ($tscheckboxvalue -like "true") {
			$tscheckboxvaluenew = "false"
		}
		elseif ($tscheckboxvalue -like "false") {
			$tscheckboxvaluenew = "true"
		}
		Write-Host $tscheckboxvalue
		Write-Host $tscheckboxvaluenew
		$tasksequence_pick = $ts_combobox.SelectedItem
		$tasksequence_xml = "D:\DeploymentShare\Control\$tasksequence_pick\ts.xml"
		
		[xml]$tsxml = Get-Content $tasksequence_xml
		$steps = ($tsxml.sequence.group | Where-Object { $_.Name -eq "MDTp_Set_Custom_Variables" }).step
		$steps | Where-Object { $_.name -eq $TSVariableStep } | ForEach-Object { $_.disable = $tscheckboxvaluenew }
		
		$tsxml.Save($tasksequence_xml)
		
		$status.text = "TS variable changed :) `r`n$TSvariableStep changed to $tscheckboxvaluenew" 
		load_ts_info_item_selected $ts_combobox $tsinfo_text $osname_text $osinfo_text


	})

$save_os_change_exit_button.add_click( {
		$os_pick_guid = $os_listbox.SelectedItem.split(',')[2]

		$ts_oschange = New-Object xml
		$ts_id = $ts_combobox.selecteditem
		$os_name = $os_listbox.SelectedItem.split(',')[0]
		$ts_oschange.load("D:\DeploymentShare\Control\$ts_id\ts.xml")

		$osxml = $TS_oschange.SelectNodes("//sequence/globalVarList/variable") | Where-Object property -EQ "OSGUID"
		$osxml[0]."#text" = $os_pick_guid
		$osxml[1]."#text" = $os_pick_guid

		$osxml2 = $TS_oschange.SelectSingleNode('//sequence/group/step[@type="BDD_InstallOS"]/defaultVarList/variable') | Where-Object property -EQ "OSGUID"
		$osxml2."#text" = $os_pick_guid

		$ts_oschange.save("D:\DeploymentShare\Control\$ts_id\ts.xml")
		$status.Text = "OS image for tasksequnce $ts_id has been changed to $os_name!"
		$FlyoutTSinfo.IsOpen = $false
	})

###[][][][][][][][][][][][][][][][][][][][][][][][][]##
#endregion ------------------TS_info_OS_change_Flyout##
###[][][][][][][][][][][][][][][][][][][][][][][][][]##

###[][][][][][][][][][][][][][][][][][][][][][][][][]##
#region ----------------------------DB_Tools_Flyout--##
###[][][][][][][][][][][][][][][][][][][][][][][][][]##

$MDTp_DB_Tools.add_IsOpenChanged( {
		$pcs_datagrid.Items.Clear()	
		$save_csv_checkbox.IsChecked = $false
		$wol_checkbox.IsChecked = $false
		$restart_checkbox.IsChecked = $false
		$pxe_off_radiobutton.IsChecked = $false
		$pxe_on_radiobutton.IsChecked = $false
		load_domainconfig
		load_ts_list $ts_db_combobox
		load_drivergroup_list $drivergroup_combobox
		$csvname = $save_csv_text.text
		$savepath_label.content = "D:\MDTp-Import\$csvname-$date.csv"
		if (Test-Path $tempcsv_maingrid) {
			load_csv_datagrid $tempcsv_maingrid
		}
	})

$MDTp_DB_Tools.add_ClosingFinished( {
		Remove-Item $tempcsv
		Remove-Item $tempcsv_maingrid
	})

$MDTp_DB_Tools.add_KeyUp( {
		$csvname = $save_csv_text.text
		$savepath_label.content = "D:\MDTp-Import\$csvname-$date.csv"
	})
function load_csv_datagrid ($tempcsvname) {
	$tempcsvimport = Import-Csv -Path $tempcsvname
	foreach ($pc in $tempcsvimport) {
		  
		$rowdata = New-Object PSObject
	  
		$rowdata = $rowdata | Add-Member Noteproperty Hostname $pc.hostname -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty ClientID $pc.clientid -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty Serialnumber $pc.serialnumber -PassThru    
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

$ts_db_combobox.Add_SelectionChanged( {
		load_ts_info_item_selected $ts_db_combobox $tsinfo_db_text $osname_db_text $osinfo_db_text
	})

$select_csv_button.Add_Click( { 
		$CSVfile = OpenFileDialog "D:\MDTp-Import" "CSV"
		Import-Csv -Path $CSVfile | Out-GridView -PassThru -Title "Filter PCs for MDTp import" | Export-Csv -Path $tempcsv -NoTypeInformation
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

#Database import/update
$import_csv_button.Add_Click( {
		#Set up the log file information and initialize counters
		$validrecords = 0
		$invalidrecords = 0
  
		# load PCs from datagrid
		foreach ($row in $pcs_datagrid.items) {
	  
	  #read assettag from database to save it before rewrite
	  if ($row.assettag -eq "") {
				$ASSETTAG = (Get-MDTComputer -macAddress $row.clientid).assettag
	  }
	  else {
				$ASSETTAG = $row.assettag
	  }

	  #don't change TS if nothing new is selected, get TS from datagrid
	  if ($ts_db_combobox.SelectedIndex -eq "-1") {
				$ts_name = $row.TaskSequenceID
	  }
	  else {
				$ts_name = $ts_db_combobox.SelectedValue
	  }

	  #IMPORT
	  # convert MAC to allowed form, check right format
	  $row.ClientId = $row.ClientId.ToUpper()
	  $macvalid = $TRUE
	  $temp = $row.ClientId.Split(":")
	  if (($temp.count -ne 6) -or ($row.ClientId.length -ne 17)) {
				$macvalid = $FALSE
	  }  
  
	  # check hostname >15 characters
	  $namevalid = $TRUE
	  if ($row.Hostname.length -gt 15) {
				$namevalid = $FALSE
	  }
	  if ($row.serialnumber -gt "") {
		  $serialpresent = $true
	  }
  
	  # if both checks pass, start import
	  if ($namevalid -and $macvalid -or $serialpresent) { 
				$validrecords = $validrecords + 1
				$machineid = Get-MDTComputer -serialnumber $row.Serialnumber -macAddress $row.ClientId
				if ($machineid.id -gt 0) {
					Remove-MDTComputer $machineid.id
				}
				New-MDTComputer -serialNumber $row.SerialNumber -macAddress $row.ClientId -description $row.Hostname -uuid $row.uuid -assettag $ASSETTAG -settings @{
					OSInstall            = 'YES';
					SkipComputerName     = 'YES';
					SkipDomainMembership = 'YES';
					SkipSummary          = 'YES';
					SkipTaskSEquence     = 'YES';
					SkipApplications     = 'YES';
					OSDComputerName      = $row.Hostname;
					DriverGroup          = $drivergroup_combobox.SelectedValue;
					TaskSequenceID       = $ts_name;
		  
					#deprecated, use TS options insted for greater flexibility
					#MachineObjectOU      = $pc_ou_text.text;
					#JoinDomain           = $Global:domainname;
					#DomainAdmin          = $Global:ADjoinUser;
					#DomainAdminDomain    = $Global:domainname;
					#DomainAdminPassword  = $Global:ADjoinPW;
				}
	  }
	  else {
				#log the invalid record
				$invalidrecords = $invalidrecords + 1
				$text = "Invalid Record :" + " " + $row.ClientId + " " + $row.Hostname
				$text >> $logfile
	  }
	  $mac_clean = $row.clientid.replace(':', '')
	  $hostname = $row.hostname

	  # PXE on
	  if ($pxe_on_radiobutton.ischecked) {
				Remove-WdsClient -DeviceID $mac_clean
				New-WdsClient -DeviceID $mac_clean -DeviceName $row.hostname -Group "PXE_INSTALL" -PxePromptPolicy OptOut
	  }
	  # PXE off
	  if ($pxe_off_radiobutton.ischecked) {
				$pxebootprogram = "/BootProgram:boot\x64\abortpxe.com"
				$pxeextraparameter = "/force"
				Remove-WdsClient -DeviceID $mac_clean
				New-WdsClient -DeviceID $mac_clean -DeviceName $hostname -Group "PXE_SKIP"
				wdsutil /set-device /id:$mac_clean /device:$hostname $pxebootprogram $pxeextraparameter
			}
	  # WOL
	  if ($wol_checkbox.ischecked) {
				$mac = $row.clientid
				.\Modules\wol.exe $mac $broadcastip
				$str_wol += "$mac, "
			}
			if ($restart_checkbox.ischecked) {
				$restarthost += "$hostname, "
			}
		}

		# restart PCs
		if ($restart_checkbox.ischecked) {
			Restart-Computer -ComputerName $restarthost -Credential (Get-Credential -UserName $domainname\administrator -Message "Enter domain password to restart PCs") -Force
		}

		$status_wol.Text = "Wake on LAN sent to $str_wol `r`nHosts $restarthost restarted"
   
  
		" " >> $logfile
		$text = "Total records processed = " + ($invalidrecords + $validrecords)
		$text>>$logfile
		$text = "Invalid records         = " + $invalidrecords
		$text>>$logfile
		$text = "Valid records           = " + $validrecords
		$text>>$logfile
  
		$logfilecheck = Get-Content $logfile
		$status.Text = "Importresult:  $logfilecheck" 
  
		if ($save_csv_checkbox.ischecked) {
			if (Test-Path $tempcsv_maingrid) {
				copy $tempcsv_maingrid $savepath_label.content
			}
			else { copy "D:\MDTp-Import\temp.csv" $savepath_label.content }
		}
		$MDTp_DB_Tools.isOpen = $false
	})

#Database delete
$delete_csv_button.Add_Click( {
		#Set up the log file information and initialize counters
		$report = @()
		$validrecords = 0
		$invalidrecords = 0
	  
		# load PCs from datagrid
		foreach ($row in $pcs_datagrid.items) {
			   
			#DELETE
			# convert MAC to allowed form, check right format
			$row.ClientId = $row.ClientId.ToUpper()
			$macvalid = $TRUE
			$temp = $row.ClientId.Split(":")
			if (($temp.count -ne 6) -or ($row.ClientId.length -ne 17)) {
		  $macvalid = $FALSE
			}  
			# check hostname >15 characters
			$namevalid = $TRUE
			if ($row.Hostname.length -gt 15) {
		  $namevalid = $FALSE
			}
			# if both checks pass, start delete
			if ($namevalid -and $macvalid) { 
		  $validrecords = $validrecords + 1
		  $assettag = (Get-MDTComputer -macAddress $row.ClientId).assettag
		  $hostname = (Get-MDTComputer -macAddress $row.ClientId).osdcomputername
		  $uuid = (Get-MDTComputer -macAddress $row.ClientId).uuid
		  $machineid = Get-MDTComputer -macAddress $row.ClientId
		  $report += New-Object psobject -Property @{Hostname = $hostname; ClientID = $row.ClientId; UUID = $UUID; AssetTag = $assettag }
		  if ($machineid.id -gt 0) {
					Remove-MDTComputer $machineid.id
		  }
		  $mac_clean = $row.clientid.replace(':', '')
		  Remove-WdsClient -DeviceID $mac_clean
			}
			else {
		  #log the invalid record
		  $invalidrecords = $invalidrecords + 1
		  $text = "Invalid Record :" + " " + $row.ClientId + " " + $row.Hostname
		  $text >> $logfile
			}
		}
		" " >> $logfile
		$text = "Total records processed = " + ($invalidrecords + $validrecords)
		$text>>$logfile
		$text = "Invalid records         = " + $invalidrecords
		$text>>$logfile
		$text = "Valid records           = " + $validrecords
		$text>>$logfile
	   
		$logfilecheck = Get-Content $logfile
		$status.Text = "Importergebnis:  $logfilecheck" 
		$report | select Hostname, ClientID, UUID, AssetTag | Export-Csv "D:\MDTp_Tools\Import-Logs\csv_delete.$date.csv" -NoTypeInformation
		$pcdelete = Get-Content -Path "D:\MDTp_Tools\Import-Logs\csv_delete.$date.csv" | Out-String
		$status.Text = "PCs deleted from DB: `r`n$pcdelete `r`nData has been saved to D:\MDTp_Tools\Import-Logs\csv_delete.$date.csv"
		
		if ($save_csv_checkbox.ischecked) {
			copy "D:\MDTp-Import\temp.csv" $savepath_label.content
		}
		$MDTp_DB_Tools.isOpen = $false
	})

###[][][][][][][][][][][][][][][][][][][][][][][][][]##
#endregion -------------------------DB_Tools_Flyout--##
###[][][][][][][][][][][][][][][][][][][][][][][][][]##

###[][][][][][][][][][][][][][][][][][][][][][][][][]##
#region ------------------------------New_TS_Flyout--##
###[][][][][][][][][][][][][][][][][][][][][][][][][]##

$FlyoutNewTS.add_IsOpenChanged( {
		
	})

$FlyoutNewTS.add_ClosingFinished( {

	})

$FlyoutNewTS.add_KeyUp( {
	
	})

$template_button.Add_Click( {
		$os_listbox3.items.clear()
		$comments_text3.clear()
		$tssequence_text3.clear()
		$template_pick = OpenFileDialog "D:\DeploymentShare\Templates" "XML"
		$template_text.text = $template_pick
		$tstempxml = New-Object xml
		$tstempxml.load($template_pick)
		$template_description.text = ($tstempxml.sequence).description

		$mdtOSxml = New-Object XML
		$mdtOSxml.Load("D:\DeploymentShare\Control\Operatingsystems.xml")
		$availableos = New-Object xml
		$availableos.Load("D:\DeploymentShare\Control\OperatingSystemGroups.xml")
		$nonhiddenos = $availableos.SelectNodes("//groups/group") | where Name -NE "hidden"
		$nonhiddenos_guids = $nonhiddenos.Member
		foreach ($osguid in $nonhiddenos_guids) {
			$imagename = Split-Path -Path ($mdtOSxml.selectNodes("//oss/os[@guid='$osguid']")).Source -Leaf
			$os_type = ($mdtOSxml.selectNodes("//oss/os[@guid='$osguid']")).Flags
			$os_listbox3.items.add("$imagename")   
		}           
	})

$os_listbox3.Add_SelectionChanged( {
		$imagename = $os_listbox3.SelectedItem
		$ospathcomplete = "D:\DeploymentShare\Operating Systems\$imagename\$imagename" + "_info.txt"
		$osinfo_text3.text = Get-Content $ospathcomplete
	})


$create_ts_button.Add_Click( {
		# find the 'real' name of the wim-file, otherwise no import is possible, the ps-drive is only using the name from the xml file
		$os_select = $os_listbox3.SelectedItem
		$mdtOSxml = New-Object XML
		$mdtOSxml.Load("D:\DeploymentShare\Control\Operatingsystems.xml")
		$osmdtname = (Get-ChildItem "DS001:\Operating Systems" | Where-Object { $_.Name -like "*$os_select*" }).name

		$ID = $tssequence_text3.text.ToUpper()
		import-mdttasksequence -path "DS001:\Task Sequences" -Name $tssequence_text3.text -Template $template_text.text -Comments $comments_text3.text -ID $ID -Version $MDTpversion -OperatingSystemPath "DS001:\Operating Systems\$osmdtname" -Verbose
		$status.text = "Tasksequence $ID with image $osmdtname has been imported"
		Start-Sleep 2
		load_ts_list $ts_combobox2
		$FlyoutNewTS.IsOpen = $false
	})

###[][][][][][][][][][][][][][][][][][][][][][][][][]##
#endregion ---------------------------New_TS_Flyout--##
###[][][][][][][][][][][][][][][][][][][][][][][][][]##



###[][][][][][][][][][][][][][][][][][][][][][][][][]##
#region ------------------Customsettings.ini_Flyout--##
###[][][][][][][][][][][][][][][][][][][][][][][][][]##

$customsettings_flyout.add_IsOpenChanged( {
		load_ts_list $preselected_TS_listbox
		customsettingsstatus
	})

$ts_preselect_on_radiobutton.Add_checked( {
		$preselected_TS_listbox.isEnabled = $true
	})

$ts_preselect_off_radiobutton.Add_checked( {
		$preselected_TS_listbox.isEnabled = $false
	})

$save_customsettings_button.add_click( {
		$customsettingsold = Get-Content D:\DeploymentShare\Control\CustomSettings.ini

		$sqlstartline = ($customsettingsold | Select-String -Pattern "CSettings]").LineNumber
		$sqlstopline = ($customsettingsold | Select-String -Pattern "MMSettings]").LineNumber
		$sqlstartline = $sqlstartline - 1
		$sqlstopline = $sqlstopline - 1
		$CSettings = $customsettingsold[$sqlstartline..$sqlstopline]
		$activecsettings = $CSettings | Where-Object { $_ -Match "Parameters=" } | Where-Object { $_ -NotMatch "'" }

		if ($ts_preselect_off_radiobutton.ischecked -eq $true) {
			$customsettingsold = Get-Content D:\DeploymentShare\Control\CustomSettings.ini
			$tspreselect = $customsettingsold | Where-Object { $_ -Match "TASKSEQUENCEID" } 
			$customsettingsold -replace $tspreselect, "'TaskSequenceID=" | Set-Content D:\DeploymentShare\Control\CustomSettings.ini
		}
		if ($ts_preselect_on_radiobutton.ischecked -eq $true) {
			$customsettingsold = Get-Content D:\DeploymentShare\Control\CustomSettings.ini
			$tsname = $preselected_TS_listbox.selecteditem
			$tspreselect = $customsettingsold | Where-Object { $_ -Match "TASKSEQUENCEID" } 
			$customsettingsold -replace $tspreselect, "TaskSequenceID=$tsname" | Set-Content D:\DeploymentShare\Control\CustomSettings.ini
		}
		if ($ts_skip_off_radiobutton.IsChecked -eq $true) {
			$customsettingsold = Get-Content D:\DeploymentShare\Control\CustomSettings.ini
			$ts_skip = $customsettingsold | Where-Object { $_ -Match "SkipTaskSequence" }
			$customsettingsold -replace $ts_skip, "'SkipTaskSequence=YES" | Set-Content D:\DeploymentShare\Control\CustomSettings.ini
		}
		if ($ts_skip_on_radiobutton.IsChecked -eq $true) {
			$customsettingsold = Get-Content D:\DeploymentShare\Control\CustomSettings.ini
			$ts_skip = $customsettingsold | Where-Object { $_ -Match "SkipTaskSequence" }
			$customsettingsold -replace $ts_skip, "SkipTaskSequence=YES" | Set-Content D:\DeploymentShare\Control\CustomSettings.ini
		}
		if ($db_match_mac_radiobutton.ischecked -eq $true) {
			$customsettingsold = Get-Content D:\DeploymentShare\Control\CustomSettings.ini
			$customsettingsold -replace $activecsettings, "Parameters=MacAddress" | Set-Content D:\DeploymentShare\Control\CustomSettings.ini
		}
		if ($db_match_mac_serial_radiobutton.ischecked -eq $true) {
			$customsettingsold = Get-Content D:\DeploymentShare\Control\CustomSettings.ini
			$customsettingsold -replace $activecsettings, "Parameters=MacAddress, SerialNumber" | Set-Content D:\DeploymentShare\Control\CustomSettings.ini
		}
		if ($db_match_mac_serial_uuid_radiobutton.ischecked -eq $true) {
			$customsettingsold = Get-Content D:\DeploymentShare\Control\CustomSettings.ini
			$customsettingsold -replace $activecsettings, "Parameters=MacAddress, SerialNumber, UUID" | Set-Content D:\DeploymentShare\Control\CustomSettings.ini
		}
		$customsettings_flyout.isOpen = $false

	})


###[][][][][][][][][][][][][][][][][][][][][][][][][]##
#endregion ---------------Customsettings.ini_Flyout--##
###[][][][][][][][][][][][][][][][][][][][][][][][][]##



##########################################################
#region -------------------------------MDTp-Tools_Tab--###
##########################################################

#region Database_tools-----------------------#

#DHCP-Export DC
$dc_rdp_button.Add_Click( {
		# promt for adminpassword for DC, start rdp connection
		$status.text = "Enter credentials for domaincontroller (Admin)"
		$Global:credential = Get-Credential -Credential $domainnameauto\administrator
		rdp $Global:dc $Global:credential
		$status.text = "DHCP-Export will be saved in D:\MDTp-Import"
	})

#open DB tools
$db_tools_button.Add_Click( {
		$MDTp_DB_Tools.isOpen = $true
	})

#
$customsettings_flyout_button.add_click( {
		$customsettings_flyout.isOpen = $true
		customsettingsstatus
	})

#customsettings info
function customsettingsstatus {
	$customsettings = Get-Content D:\DeploymentShare\Control\CustomSettings.ini
	$TASKSEQUENCEID_custom = $customsettings | Where-Object { $_ -Match "TASKSEQUENCEID" }
	#Active TS
	if ($TASKSEQUENCEID_custom.StartsWith("'")) {
		$default_TS_active.text = "OFF"
		$ts_preselect_off_radiobutton.IsChecked = $true
	}
	else {
		$default_TS_active.text = $TASKSEQUENCEID_custom.Split("=")[1]
		$ts_preselect_on_radiobutton.IsChecked = $true
		$preselected_TS_listbox.selecteditem = $TASKSEQUENCEID_custom.Split("=")[1]
	}
	#Skip TS
	$SkipTaskSequence_custom = $customsettings | Where-Object { $_ -Match "SkipTaskSequence" }
	if ($SkipTaskSequence_custom.StartsWith("'") -or $SkipTaskSequence_custom.Split("=")[1] -eq "NO") {
		$skip_TS_selection.text = "NO"
		$ts_skip_off_radiobutton.IsChecked = $true
	}
	elseif ($SkipTaskSequence_custom.Split("=")[1] -eq "YES") {
		$skip_TS_selection.text = "SKIP and install preselected TS"
		$ts_skip_on_radiobutton.IsChecked = $true
	}
	$sqlstartline = ($customsettings | Select-String -Pattern "CSettings]").LineNumber
	$sqlstopline = ($customsettings | Select-String -Pattern "MMSettings]").LineNumber
	$sqlstartline = $sqlstartline - 1
	$sqlstopline = $sqlstopline - 1
	$CSettings = $customsettings[$sqlstartline..$sqlstopline]
	$activecsettings = $CSettings | Where-Object { $_ -Match "Parameters=" } | Where-Object { $_ -NotMatch "'" }
	$activecsettings_short = $activecsettings.Split("=")[1]
	$sql_database_option.text = "$activecsettings_short"
	
	if ($activecsettings_short -eq "MacAddress") {
		$db_match_mac_radiobutton.ischecked = $true
	}
	elseif ($activecsettings_short -like "MacAddress, SerialNumber") {
		$db_match_mac_serial_radiobutton.ischecked = $true
	}
	elseif ($activecsettings_short -like "MacAddress, SerialNumber, UUID") {
		$db_match_mac_serial_UUID_radiobutton.ischecked = $true
	}
	else {
		$db_match_mac_serial_radiobutton.ischecked = $false
		$db_match_mac_serial_UUID_radiobutton.ischecked = $false
		$db_match_mac_serial_radiobutton.ischecked = $false
		$customsettings_info.content = "Custom! Default not found!"
	}
}


#open import-log folder
$import_logs_button.Add_Click( {
		Invoke-Item D:\MDTp_Tools\Import-Logs
	})

#filter PCs from datagrid
$filter_datagrid_button.add_click( {
		$DB_datagrid.items | Out-GridView -PassThru -Title "Filter for MDTp PC-Import" | Export-Csv -Path $tempcsv_maingrid -NoTypeInformation
		$MDTp_DB_Tools.isOpen = $true
	})
	
#edit selected PCs from datagrid
$DB_datagrid.Add_MouseRightButtonDown( {
		$DB_datagrid.SelectedItems | Export-Csv $tempcsv_maingrid -NoTypeInformation -Force
		Write-Host $item
		$MDTp_DB_Tools.isOpen = $true
	})

#enable datagrid buttons on selection	
$DB_datagrid.Add_SelectionChanged( {
		if ($DB_datagrid.SelectedItems -ne $null) {
			$filter_datagrid_button.isEnabled = $true
			$wol_button.isEnabled = $true
			#$ping_button.isEnabled = $true
			$RDP_main_button.isEnabled = $true
		}
		else {
			$filter_datagrid_button.IsEnabled = $false
			$wol_button.IsEnabled = $false
			#$ping_button.IsEnabled = $false
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

#wip
#$ping_button.Add_click( {
#
#	})

#wip add option to add credentials
$RDP_main_button.Add_click( { 
		foreach ($pc in ($DB_datagrid.SelectedItems).hostname) {
			rdp $pc $Global:credentialrdp
		}
	})

#Datagrid functions:
function refresh_db_datagrid {
	$status.Text = "SQL Database refresh, please wait"
	$DB_datagrid.Items.Clear()
	$wdsclients = Get-WdsClient
	foreach ($pc in (Get-MDTComputer).id) {
		$currentPC = Get-MDTComputer -id $pc

		$rowdata = New-Object PSObject
	
		$rowdata = $rowdata | Add-Member Noteproperty Hostname $currentPC.osdcomputername -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty ClientID $currentPC.macAddress -PassThru    
		$rowdata = $rowdata | Add-Member Noteproperty Assettag $currentPC.assettag -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty SerialNumber $currentPC.serialnumber -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty TasksequenceID $currentPC.TasksequenceID -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty DriverGroup $currentPC.Drivergroup -PassThru
		$mac_clean = ($currentPC.macAddress).replace(':', '-')
		$rowdata = $rowdata | Add-Member Noteproperty PXE-Boot ($wdsclients | Where-Object DeviceID -EQ $mac_clean).group -PassThru
		#$bootimage = ($wdsclients | Where-Object DeviceID -EQ $mac_clean).bootimagepath
		#if ($bootimage -ne "") {
		#	$rowdata = $rowdata | Add-Member Noteproperty Bootimage (Split-Path -Path $bootimage -Leaf) -PassThru
		#}
		$pcname = $currentPC.osdcomputername 
		if (Test-Path "D:\MDTp-Import\PC-Infos\$pcname.csv") {
			$pc_log_csv = Import-Csv "D:\MDTp-Import\PC-Infos\$pcname.csv" | Select-Object -Last 1
			$rowdata = $rowdata | Add-Member Noteproperty Product $pc_log_csv.product -PassThru
			$rowdata = $rowdata | Add-Member Noteproperty Laptop $pc_log_csv.laptop -PassThru
			$rowdata = $rowdata | Add-Member Noteproperty Installdate $pc_log_csv.date -PassThru
			$rowdata = $rowdata | Add-Member Noteproperty WIM_File (Split-Path -Path $pc_log_csv.WIM_File -Leaf) -PassThru
			$rowdata = $rowdata | Add-Member Noteproperty Make $pc_log_csv.make -PassThru
			$rowdata = $rowdata | Add-Member Noteproperty Model $pc_log_csv.model -PassThru
			$rowdata = $rowdata | Add-Member Noteproperty Tasksequence_log $pc_log_csv.tasksequenceid -PassThru
		}
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
		$imagenamezero = (Get-WdsBootImage | Where-Object "Imagename" -Match "Zero*").ImageName
		$imagenameall = (Get-WdsBootImage).ImageName
		foreach ($imagename in $imagenameall) {
			Disable-WdsBootImage -ImageName $imagename -Architecture X64
		}
		foreach ($imagename2 in $imagenamezero) {
			Enable-WdsBootImage -ImageName $imagename2 -Architecture X64
		}
		$status.Text = "$imagenamezero has been activated! All other bootimages are inactive."
		WDSstatus   
	})

$litetouch_on_button.Add_Click( {
		$imagenamelite = (Get-WdsBootImage | Where-Object "Imagename" -Match "Lite*").ImageName
		$imagenameall = (Get-WdsBootImage).ImageName
		foreach ($imagename in $imagenameall) {
			Disable-WdsBootImage -ImageName $imagename -Architecture X64
		}
		foreach ($imagename2 in $imagenamelite) {
			Enable-WdsBootImage -ImageName $imagename2 -Architecture X64
		}
		$status.Text = "$imagenamelite has been activated! All other bootimages are inactive."
		WDSstatus
	})

function WDSstatus {
	#Active Bootimages
	$activeimage = (Get-WdsBootImage | Where-Object "enabled" -Match "true").ImageName  
	#Inactive Bootimages
	$inactiveimage = (Get-WdsBootImage | Where-Object "enabled" -Match "false").ImageName

	$wds_status_active.Text = $activeimage
	$wds_status_inactive.Text = $inactiveimage

	if ($activeimage -eq "Zero Touch Windows PE (x64)") {
		$litetouch_on_button.isEnabled = $true
		$zerotouch_on_button.isEnabled = $false
	}
	elseif ($activeimage -eq "Lite Touch Windows PE (x64)") {
		$litetouch_on_button.isEnabled = $false
		$zerotouch_on_button.isEnabled = $true
	}
}
#endregion WDS_tools-------------------------#

#region TS_info------------------------------#

$TSinfoButton.add_Click( {
		$FlyoutTSinfo.IsOpen = $true
	})

$ts_combobox2.Add_SelectionChanged( {
		load_ts_info_item_selected $ts_combobox2 $tsinfo_text2 $osname_text2 $osinfo_text2
	})
#endregion TS_info---------------------------#

#region Staggered_deploy---------------------#

#function to make refresh at start possible
function load_staggered_pcs {
	$staggered_listbox.items.clear()
	foreach ($pc in Get-ChildItem D:\DeploymentShare\MDTp_Staggered_Deploy\ -Filter *.stop -Name) {
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
		if (Test-Path D:\DeploymentShare\MDTp_Staggered_Deploy\automatic_staggered_deploy_on.txt) {
			Remove-Item D:\DeploymentShare\MDTp_Staggered_Deploy\automatic_staggered_deploy_on.txt
		}
		$status.Text = "PCs only start install if started from this UI (better for slow networks or many PCs loading Litetouch at the same time)" 
	})

#endregion Staggered_deploy------------------#

##########################################################
#endregion ----------------------------MDTp-Tools_Tab--###
##########################################################

##########################################################
#region ------------------------Deploy-Monitoring_Tab--###
##########################################################

#refresh monitoring data function
function refresh_monitoring {
	$status.Text = "Monitoring Database refresh, please wait"
	$monitoring_grid.items.clear()
	
	foreach ($deploy_pc in (Get-MDTMonitorData -Path DS001:).id) {
		$currentPC = Get-MDTMonitorData -Path DS001: -id $deploy_pc
		
		$rowdata = New-Object PSObject
		 
		$rowdata = $rowdata | Add-Member Noteproperty ID $deploy_pc -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty Name $currentPC.name -PassThru    
		$rowdata = $rowdata | Add-Member Noteproperty PercentComplete $currentPC.PercentComplete -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty Stepname $currentPC.StepName -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty StartTime $currentPC.StartTime -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty EndTime $currentPC.EndTime -PassThru
		$status = $currentPC.Deploymentstatus 
		if ($status -eq 1) { $status = "Installing..." }
		elseif ($status -eq 2) { $status = "Failed!" }
		elseif ($status -eq 3) { $status = "Install finished" }
		elseif ($status -eq 4) { $status = "Unresponsive" }
		$rowdata = $rowdata | Add-Member Noteproperty Deploymentstatus $status -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty CurrentStep $currentPC.CurrentStep -PassThru
		$rowdata = $rowdata | Add-Member Noteproperty TotalSteps $currentPC.TotalSteps -PassThru
    
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

##########################################################
#endregion ---------------------Deploy-Monitoring_Tab--###
##########################################################

##########################################################
#region --------------------------TS_Image_Driver_Tab--###
##########################################################
#region----Deploymentshareupdate, Zero-, Litetouch

#Litetouch config, change config files for zero or litetouch (Zero contains local MDTp password for auto login WIN PE)
function change_litetouch_config_file ($litezero) {
	Copy-Item "D:\DeploymentShare\Control\Bootstrap_${litezero}touch.ini" D:\DeploymentShare\Control\Bootstrap.ini
	$filePathToTask = "D:\DeploymentShare\Control\Settings.xml"
	$xml = New-Object XML
	$xml.Load($filePathToTask)
	$description = $xml.SelectSingleNode("//Boot.x64.LiteTouchWIMDescription")
	$description.InnerText = "$litezero Touch Windows PE (x64)"
	$isoname = $xml.SelectSingleNode("//Boot.x64.LiteTouchISOName")
	$isoname.InnerText = "${litezero}TouchPE_x64.iso"
	$xml.Save($filePathToTask)
	$status.Text = "Deploymentshare ${litezero}touch is updating, time for a drink..."
}

function deploymentshare_update {
	if ($image_recreate_checkbox.ischecked) {
		$script = {
			Write-Output 'Zerotouch and Litetouch are updating. Don''t close this window until this is finished!!!!!!!!!!'
			Write-Output 'Images will be erased and rebuild' 
			Import-Module '"C:\Program Files\Microsoft Deployment Toolkit\bin\MicrosoftDeploymentToolkit.psd1"'
			New-PSDrive -Name "DS001" -PSProvider MDTProvider -Root "D:\DeploymentShare"
			update-MDTDeploymentShare -path "DS001:" -Force -Verbose
		}
		Start-Process powershell -ArgumentList $script -Wait
	}
	else {
		$script = {
			Write-Output 'Zerotouch and Litetouch are updating. Don''t close this window until this is finished!!!!!!!!!!'
			Import-Module 'C:\Program Files\Microsoft Deployment Toolkit\bin\MicrosoftDeploymentToolkit.psd1'
			New-PSDrive -Name "DS001" -PSProvider MDTProvider -Root "D:\DeploymentShare"
			update-MDTDeploymentShare -path "DS001:" -Compress -Verbose 
		}
		Start-Process powershell -ArgumentList $script -Wait
	}	
}

function zerotouch_wds_import {
	#Zerotouch copy, because every new image is called LiteTouchPE_x64.wim /xml
	Copy-Item D:\DeploymentShare\Boot\LiteTouchPE_x64.wim D:\DeploymentShare\Boot\ZeroTouchPE_x64.wim
	Copy-Item D:\DeploymentShare\Boot\LiteTouchPE_x64.xml D:\DeploymentShare\Boot\ZeroTouchPE_x64.xml

	Remove-WdsBootImage -Architecture X64 -ImageName "Zero Touch Windows PE (x64)"
	Import-WdsBootImage -Path "D:\DeploymentShare\Boot\ZeroTouchPE_x64.wim" -DisplayOrder 1
}

function litetouch_wds_import {
	Remove-WdsBootImage -Architecture X64 -ImageName "Lite Touch Windows PE (x64)"
	Import-WdsBootImage -Path "D:\DeploymentShare\Boot\LiteTouchPE_x64.wim" -DisplayOrder 0
}

$deployment_update_button.add_click( {
		#preserve state which image was active before (lite or zero)
		$inactiveimage = (Get-WdsBootImage | Where-Object "enabled" -Match "false").ImageName
		change_litetouch_config_file Zero
		deploymentshare_update
		zerotouch_wds_import
		change_litetouch_config_file Lite
		deploymentshare_update
		litetouch_wds_import
		foreach ($imagename in $inactiveimage) {
			Disable-WdsBootImage -ImageName $imagename -Architecture X64
		}
		$status.Text = "All images are updated, imported and ready to go"
		WDSstatus
	})
#endregion-Deploymentshareupdate, Zero-, Litetouch

#wip new_Tasksequence
$new_tasksequence_button.Add_Click( {
		$FlyoutNewTS.IsOpen = $true
	})

#open driverimport folder
$driver_import_button.Add_Click( {
		Invoke-Item D:\MDTp-Import\Drivers
	})

#import old WIM files
$import_old_wim_button.Add_Click( {
		$wimfile = OpenFileDialog "D:\MDTp-Import\WIM-Images" "wim"
		Write-Host $wimfile
		$foldername = (Split-Path $wimfile -Leaf).replace('.wim', '')
		import-mdtoperatingsystem -path "DS001:\Operating Systems" -SourceFile $wimfile -DestinationFolder $foldername -Verbose -move 
		$Description = 'Enter image info and save this file'
		$text_info = "D:\DeploymentShare\Operating Systems\$foldername\$foldername" + "_info.txt"
		$Description | Out-File $text_info
		& $text_info

		if (Test-Path -Path "D:\DeploymentShare\Operating Systems\$foldername\$foldername.wim") {
			$status.text = "Import successfull of file $foldername, image has been moved to deployment share"
  }
		else { 
			$status.text = "Import failed! Check free available space or wrong filenames" 
		}
	})

##########################################################
#endregion -----------------------TS_Image_Driver_Tab--###
##########################################################

##########################################################
#region -----------------------------Options_Logs_Tab--###
##########################################################

#Shortcut to MDTp-Import folder, where most of pc-data is stored in CSV-files (DHCP-Export, installinfo, logs)
$import_folder.Add_Click( { 
		Invoke-Item D:\MDTp-Import
	})

#CSV edit with CSV Buddy
$csv_edit_button.Add_Click( { $status.Text = "Open and edit CSV-file to save it (certain PCs, rooms etc.)"
		$CSVfile = OpenFileDialog "D:\MDTp-Import" "CSV"
		D:\MDTp_Tools\SW_CSVBuddy\CSVBuddy-2_1_6-64-bit.exe $CSVfile 
	})

#PC reports from all single CSVs
$create_report_button.add_click( {
		mkdir D:\MDTp-Import\PC-Reports
		$date = Get-Date -Format yyyy_MM_dd_HH.mm
		$csvname = "D:\MDTp-Import\PC-Reports\PC_Install_Report_$date.csv"
		$pc_csvs = (Get-ChildItem D:\MDTp-Import\PC-Infos *.csv).FullName
		foreach ($file in $pc_csvs) {
			$pc_infos = Import-Csv -Path $file | Select-Object -Last 1
			$pc_infos | Export-Csv -Path $csvname -NoTypeInformation -Append -Force
		}
		$status.Text = "PC-Report saved to $csvname"
	})

#open PC-Report with CSV Buddy
$open_report_button.Add_Click( {
		$infocsv = OpenFileDialog "D:\MDTp-Import\PC-Reports" "CSV" 
		D:\MDTp_Tools\SW_CSVBuddy\CSVBuddy-2_1_6-64-bit.exe $infocsv
	})

#open CustomSettings.ini to edit
$CustomSettings_button.Add_Click( {
		notepad.exe D:\DeploymentShare\Control\CustomSettings.ini
	})

#TS delete
$MDTp_TS_delete_button.add_click( {
		$Dialog = [SimpleDialogs.Controls.MessageDialog]::new()		
		$Dialog.MessageSeverity = "Warning"
		$Dialog.Title = "WARNING!!!"
		$Dialog.TitleForeground = "White"	
		$Dialog.ShowFirstButton = $True
		$Dialog.ShowSecondButton = $True
		$Dialog.ShowThirdButton = $False

		$Dialog.Message = "Tasksequence will be deleted permanently!!!"			
		[SimpleDialogs.DialogManager]::ShowDialogAsync("ee", $Dialog)	
		$Dialog.Add_ButtonClicked( {
				$Button_Args = [SimpleDialogs.Controls.DialogButtonClickedEventArgs]$args[1] 
				$Button_Value = $Button_Args.Button
				If ($Button_Value -eq "FirstButton") {
					$pick = Get-ChildItem "DS001:\Task Sequences" -Name | Out-GridView -PassThru -Title "delete Tasksequence"
					foreach ($ts in $pick) {
						Remove-Item -Path "DS001:\Task Sequences\$ts"
						$deletedTS += $ts
					}				 
					$status.text = "TS(s) $deletedTS deleted from MDTp!" 
					Start-Sleep 2
					load_ts_list $ts_combobox2
				}
				ElseIf ($Button_Value -eq "SecondButton") {
					$status.text = "TS delete aborted"  
				}    
			})   
	})


#OS delete
$MDTp_OS_delete_button.add_click( {
		$Dialog_OS_delete = [SimpleDialogs.Controls.MessageDialog]::new()		
		$Dialog_OS_delete.MessageSeverity = "Warning"
		$Dialog_OS_delete.Title = "WARNING!!!"
		$Dialog_OS_delete.TitleForeground = "White"	
		$Dialog_OS_delete.ShowFirstButton = $True
		$Dialog_OS_delete.ShowSecondButton = $True
		$Dialog_OS_delete.ShowThirdButton = $False

		$Dialog_OS_delete.Message = "OS image will be deleted permanently!!!"			
		[SimpleDialogs.DialogManager]::ShowDialogAsync("ee", $Dialog_OS_delete)	
		$Dialog_OS_delete.Add_ButtonClicked( {
				$Button_Args = [SimpleDialogs.Controls.DialogButtonClickedEventArgs]$args[1] 
				$Button_Value = $Button_Args.Button
				If ($Button_Value -eq "FirstButton") {
					$pick = Get-ChildItem "DS001:\Operating Systems" -Name | Out-GridView -PassThru -Title "delete OS image"
					foreach ($os in $pick) {
						Remove-Item -Path "DS001:\Operating Systems\$os"
						$deletedOS += $os
					}				 
					$status.text = "OS image(s) $deletedOS deleted from MDTp!" 
				}
				ElseIf ($Button_Value -eq "SecondButton") {
					$status.text = "OS image delete aborted"    
				}    
			})   
	})

#Driver folder delete
$MDTp_drivergroup_delete_button.add_click( {
		$Dialog_drivergroup_delete = [SimpleDialogs.Controls.MessageDialog]::new()		
		$Dialog_drivergroup_delete.MessageSeverity = "Warning"
		$Dialog_drivergroup_delete.Title = "WARNING!!!"
		$Dialog_drivergroup_delete.TitleForeground = "White"	
		$Dialog_drivergroup_delete.ShowFirstButton = $True
		$Dialog_drivergroup_delete.ShowSecondButton = $True
		$Dialog_drivergroup_delete.ShowThirdButton = $False

		$Dialog_drivergroup_delete.Message = "Drivergroup will be deleted permanently!!!"			
		[SimpleDialogs.DialogManager]::ShowDialogAsync("ee", $Dialog_drivergroup_delete)	
		$Dialog_drivergroup_delete.Add_ButtonClicked( {
				$Button_Args = [SimpleDialogs.Controls.DialogButtonClickedEventArgs]$args[1] 
				$Button_Value = $Button_Args.Button
				If ($Button_Value -eq "FirstButton") {
					$pick = Get-ChildItem "DS001:\Out-of-Box Drivers\Windows_10_X64" -Name | Out-GridView -PassThru -Title "delete drivergroup"
					foreach ($driver in $pick) {
						Remove-Item -Path "DS001:\Out-of-Box Drivers\Windows_10_X64\$driver"
						$deleteddriver += $driver
					}	
					$status.text = "Drivergroup(s) $deleteddriver deleted from MDTp!" 
				}
				ElseIf ($Button_Value -eq "SecondButton") {
					$status.text = "Drivergroup delete aborted"    
				}    
			})   
	})


$MDTp_template_delete_button.add_click( {
		$Dialog_template_delete = [SimpleDialogs.Controls.MessageDialog]::new()		
		$Dialog_template_delete.MessageSeverity = "Warning"
		$Dialog_template_delete.Title = "WARNING!!!"
		$Dialog_template_delete.TitleForeground = "White"	
		$Dialog_template_delete.ShowFirstButton = $True
		$Dialog_template_delete.ShowSecondButton = $True
		$Dialog_template_delete.ShowThirdButton = $False

		$Dialog_template_delete.Message = "Template will be deleted permanently!!!"			
		[SimpleDialogs.DialogManager]::ShowDialogAsync("ee", $Dialog_template_delete)	
		$Dialog_template_delete.Add_ButtonClicked( {
				$Button_Args = [SimpleDialogs.Controls.DialogButtonClickedEventArgs]$args[1] 
				$Button_Value = $Button_Args.Button
				If ($Button_Value -eq "FirstButton") {
					$pick = Get-ChildItem "D:\DeploymentShare\Templates" -Name | Out-GridView -PassThru -Title "delete template"
					foreach ($template in $pick) {
						Remove-Item -Path "D:\DeploymentShare\Templates\$template"
						$deletedtemplate += $template
					}	
					$status.text = "Template(s) $deletedtemplate deleted from MDTp!" 
				}
				ElseIf ($Button_Value -eq "SecondButton") {
					$status.text = "Template delete aborted"    
				}    
			})   
	})

	
##########################################################	
#endregion --------------------------Options_Logs_Tab--###
##########################################################

$Form.ShowDialog() | Out-Null