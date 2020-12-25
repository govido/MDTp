
#-------------------------------------------------------------#
#----Initial Declarations-------------------------------------#
#-------------------------------------------------------------#

Add-Type -AssemblyName PresentationCore, PresentationFramework

$Xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" Width="800" Height="240" Topmost="True" Name="Imagename" FocusManager.FocusedElement="{Binding ElementName=imagename_text}">
<Grid>
 <Button Content="OK" HorizontalAlignment="Left" VerticalAlignment="Top" Width="75" Margin="674,32,0,0" Name="OK_button"/>
<TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Text="" Height="28" Width="332" TextWrapping="Wrap" Margin="200,28,0,0" Name="imagename_text"/>
<Label HorizontalAlignment="Left" VerticalAlignment="Top" Content="Imagebeschreibung / Infos" Margin="546,85,0,0" Name="description_label"/>
<TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Text="" Height="90" Width="332" TextWrapping="Wrap" Margin="200,85,0,0" Name="description_text"/>
<Label HorizontalAlignment="Left" VerticalAlignment="Top" Content="Label" Margin="546,30,0,0" Name="imagename_end_text"/>
<Label HorizontalAlignment="Left" VerticalAlignment="Top" Content="Label" Margin="22,60,0,0" Name="complete_filename_text"/>
</Grid></Window>
"@

#-------------------------------------------------------------#
#----Control Event Handlers-----------------------------------#
#-------------------------------------------------------------#


#Write your code here

$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment
$today = Get-Date -Format yyyy-MM-dd


function window_load{

$imagename_end_text.content="-$today.wim"
$backupfile = $imagename_text.text
$tsenv.Value("Backupfile") =$backupfile+"-$today.wim"
$complete_filename_text.content=$tsenv.Value("ComputerBackupLocation")+$tsenv.Value("Backupfile")
$tsenv.Value("Description") = $description_text.text
}

#endregion

#-------------------------------------------------------------#
#----Script Execution-----------------------------------------#
#-------------------------------------------------------------#

$Window = [Windows.Markup.XamlReader]::Parse($Xaml)

[xml]$xml = $Xaml

$xml.SelectNodes("//*[@Name]") | ForEach-Object { Set-Variable -Name $_.Name -Value $Window.FindName($_.Name) }


$Imagename.Add_KeyDown({window_load $this $_})
$Imagename.Add_KeyUp({window_load $this $_})
$Imagename.Add_Loaded({window_load $this $_})
$OK_button.Add_Click({$window.close()})
$imagename_text.Add_KeyDown({
    if ($args[1].key -eq 'Return')
    {
        $window.close()
        }
    })


$Window.ShowDialog()
