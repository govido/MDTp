
Start-Process Powershell -Verb runAs -Argument "-Command "

#-------------------------------------------------------------#
#----Initial Declarations-------------------------------------#
#-------------------------------------------------------------#

Add-Type -AssemblyName PresentationCore, PresentationFramework

$Xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" Title="MDTp automatic driver export tool (requires admin privileges)" Width="600" Height="300">
<Grid>
<Button Content="List additional drivers" HorizontalAlignment="Left" VerticalAlignment="Top" Width="150" Margin="15,14,0,0" Name="show_drivers_button"/>
<Button Content="Export drivers to MDTp" HorizontalAlignment="Left" VerticalAlignment="Top" Width="150" Margin="15,41,0,0" Name="export_drivers_button"/>
<CheckBox HorizontalAlignment="Left" VerticalAlignment="Top" Content="Custom driverfolder, no automatic mainboard detection" Margin="190,14,0,0" Name="customdriver_checkbox"/>
<TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="262" TextWrapping="Wrap" Margin="190,42,0,0" Name="foldername_textbox"/>
<TextBlock TextWrapping="Wrap" Text="Status_Driver" Margin="15,80,5,5" Name="Status_driver" FontWeight="Bold" ToolTip="Status"/>
</Grid></Window>
"@

#-------------------------------------------------------------#
#----Control Event Handlers-----------------------------------#
#-------------------------------------------------------------#


#Write your code here
$today = Get-Date -Format yyyy_MM_dd_HH.mm.ss

function export_drivers {
    $credential = Get-Credential -Credential mdtp\administrator
    New-PSDrive -Name P -PSProvider FileSystem -Root "\\mdtp\MDTp-Import$" -Credential $credential
    $product = (Get-WmiObject -Class Win32_BaseBoard).Product
    $make = (Get-WmiObject -Class Win32_BaseBoard).Manufacturer
    $model = (Get-WmiObject -Class win32_BaseBoard).model
    if ($customdriver_checkbox.ischecked) {
        Write-Host "custom_folder"
        $foldername = "custom_" + $foldername_textbox.text
    }
    else {
        $foldername = $product
    }
    Export-WindowsDriver -Online -Destination "\\MDTp\MDTp-Import$\Drivers\$foldername"
    if (Test-Path -Path "\\MDTp\MDTp-Import$\Drivers\$foldername") {
        $report = @()
        $report += New-Object psobject -Property @{Date = $today; driverfoldername = $foldername; PCinfos = "$make, $model, $product" }
        $report | select Date, driverfoldername, PCinfos | Export-Csv "\\MDTp\MDTp-Import$\Drivers\$foldername\Driverimport.csv" -NoTypeInformation
        $Status_Driver.text = "Drivers have been exported to \\MDTp\MDTp-Import$\Drivers\$foldername`r`nDrivers will be imported automatically from MDTp every 5 minutes`r`nIf import finished the csv-file will be renamed to import_finished_csv`r`nDepending on the filesize import can take 10-20 minutes"
    }
    else {
        $Status_Driver.text = "Path couldn't be found or created`r`nCheck if started correctly with admin rights and MDTp can be resolved correctly by DNS"
    }
}

function show_drivers {
    (Get-WindowsDriver -Online) | Out-GridView
}
#endregion

#-------------------------------------------------------------#
#----Script Execution-----------------------------------------#
#-------------------------------------------------------------#

$Window = [Windows.Markup.XamlReader]::Parse($Xaml)

[xml]$xml = $Xaml

$xml.SelectNodes("//*[@Name]") | ForEach-Object { Set-Variable -Name $_.Name -Value $Window.FindName($_.Name) }


$show_drivers_button.Add_Click( { show_drivers $this $_ })
$export_drivers_button.Add_Click( { export_drivers $this $_ })

$Window.ShowDialog()


"
"