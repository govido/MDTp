
#-------------------------------------------------------------#
#----Initial Declarations-------------------------------------#
#-------------------------------------------------------------#

Add-Type -AssemblyName PresentationCore, PresentationFramework

$Xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" Width="600" Height="240" Topmost="True" Name="PCName" FocusManager.FocusedElement="{Binding ElementName=hostname_text}">
<Grid>
 <Button Content="OK" HorizontalAlignment="Left" VerticalAlignment="Top" Width="75" Margin="500,32,0,0" Name="OK_button"/>
<TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Text="" Height="28" Width="332" TextWrapping="Wrap" Margin="150,28,0,0" Name="hostname_text"/>
<Label HorizontalAlignment="Left" VerticalAlignment="Top" Content="Inventarnummer" Margin="15,85,0,0" Name="description_label"/>
<TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Text="" Height="28" Width="332" TextWrapping="Wrap" Margin="150,85,0,0" Name="inventory_no_text"/>
<Label HorizontalAlignment="Left" VerticalAlignment="Top" Content="PC-Name" Margin="15,28,0,0" Name="hostname_description_text"/>
<Label HorizontalAlignment="Left" VerticalAlignment="Top" Content="PC-Name-Preview" Margin="15,50,0,0" Name="hostname_preview_text"/>
</Grid></Window>
"@

#-------------------------------------------------------------#
#----Control Event Handlers-----------------------------------#
#-------------------------------------------------------------#


#Write your code here

$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment

function window_load{
$hostname_text.text = $tsenv.Value("OSDComputername")
$tsenv.Value("manualpcname") = "1"
}

function window_refresh{
#all special characters will be killed, only a-z, 0-9 or "-" is allowed for PC names
$cleanhostname = $hostname_text.text -replace '[^a-zA-Z0-9/-]', ''
$tsenv.Value("OSDComputername") = $cleanhostname
$tsenv.Value("Assettag") = $inventory_no_text.Text
$hostname_preview_text.content = $cleanhostname
}

#endregion

#-------------------------------------------------------------#
#----Script Execution-----------------------------------------#
#-------------------------------------------------------------#

$Window = [Windows.Markup.XamlReader]::Parse($Xaml)

[xml]$xml = $Xaml

$xml.SelectNodes("//*[@Name]") | ForEach-Object { Set-Variable -Name $_.Name -Value $Window.FindName($_.Name) }


$PCName.Add_KeyDown({window_refresh $this $_})
$PCName.Add_KeyUp({window_refresh $this $_})
$PCName.Add_Loaded({window_load $this $_})
$OK_button.Add_Click({$window.close()})
$inventory_no_text.Add_KeyDown({
    if ($args[1].key -eq 'Return')
    {
        $window.close()
        }
    })


$Window.ShowDialog()
