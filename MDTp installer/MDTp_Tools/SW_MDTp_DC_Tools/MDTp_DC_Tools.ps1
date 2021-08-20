$DHCPscope = (Get-DhcpServerv4Scope).ScopeId
#-------------------------------------------------------------#
#----Initial Declarations-------------------------------------#
#-------------------------------------------------------------#

Add-Type -AssemblyName PresentationCore, PresentationFramework

$Xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" Width="800" Height="400" Name="MDTp_DC_Tools" Title="MDTp DC Tools by SeWy"><Window.Resources>
    <ResourceDictionary xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" 
                    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" 
                    xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
                    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
                    mc:Ignorable="d">

	    <!-- *********************************  RESOURCES  ********************************* -->
	    <ResourceDictionary.MergedDictionaries>
		    <ResourceDictionary xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" xmlns:d="http://schemas.microsoft.com/expression/blend/2008" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:System="clr-namespace:System;assembly=mscorlib" mc:Ignorable="d">

              <!-- *********************************  RESOURCES  ********************************* -->
              <ResourceDictionary.MergedDictionaries>
                <ResourceDictionary xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" xmlns:d="http://schemas.microsoft.com/expression/blend/2008" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" mc:Ignorable="d">

                  <!-- *********************************  COLORS  ********************************* -->
                  <ResourceDictionary.MergedDictionaries>
                    <ResourceDictionary
                        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
                        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
                        xmlns:ig="http://schemas.infragistics.com/xaml"
                        xmlns:igPrim="http://schemas.infragistics.com/xaml/primitives"
                        xmlns:igPivot="http://schemas.infragistics.com/xaml"
                        xmlns:igPivotPrim="http://schemas.infragistics.com/xaml/primitives"
                        xmlns:System="clr-namespace:System;assembly=mscorlib"
	                    xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
	                    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" mc:Ignorable="d">

                        <!-- ********************************** COLORS **********************************-->

                        <!--Color Tuner Theme Brushes-->
                        <SolidColorBrush x:Key="Brush01" Color="#FF2788B1"/>
                        <SolidColorBrush x:Key="Brush02" Color="#FF185170"/>
                        <SolidColorBrush x:Key="Brush03" Color="#FF7C7C7C"/>
                        <SolidColorBrush x:Key="Brush04" Color="#FF505050"/>
                        <SolidColorBrush x:Key="Brush05" Color="#FF333333"/>

                        <!--Ig Theme Base colors-->
                        <Color x:Key="Color_000">#FF000000</Color>
                        <Color x:Key="Color_001">#FF333333</Color>
                        <Color x:Key="Color_002">#FF3E3E3E</Color>
                        <Color x:Key="Color_003">#FF505050</Color>
                        <Color x:Key="Color_004">#FF696969</Color>
                        <Color x:Key="Color_005">#FF818181</Color>
                        <Color x:Key="Color_006">#FF9B9B9B</Color>
                        <Color x:Key="Color_007">#FFB1B1B1</Color>
                        <Color x:Key="Color_008">#FFD0D0D0</Color>
                        <Color x:Key="Color_009">#FFE0E0E0</Color>
                        <Color x:Key="Color_010">#FFF1F1F1</Color>
                        <Color x:Key="Color_011">#FFffffff</Color>
                        <Color x:Key="Color_012">#FFDCEDF3</Color>
                        <Color x:Key="Color_013">#FF94D7F3</Color>
                        <Color x:Key="Color_014">#FF3BB7EB</Color>
                        <Color x:Key="Color_015">#FF16A9E7</Color>
                        <Color x:Key="Color_016">#FF2788B1</Color>
                        <Color x:Key="Color_017">#FF19759B</Color>
                        <Color x:Key="Color_018">#FF1A5F7C</Color>

                        <!--Theme Error colors -->
                        <Color x:Key="Color_019">#FFd3404b</Color>
                        <Color x:Key="Color_020">#FFc62d36</Color>

                        <!--Whites with transparency-->
                        <Color x:Key="Color_021">#00FFFFFF</Color>  <!--0% White-->
                        <Color x:Key="Color_022">#33FFFFFF</Color>  <!--20% White-->
                        <Color x:Key="Color_023">#66FFFFFF</Color>  <!--40% White-->
                        <Color x:Key="Color_024">#99FFFFFF</Color>  <!--60% White-->
                        <Color x:Key="Color_025">#CCFFFFFF</Color>  <!--80% White-->

                        <!--Blacks with transparency-->
                        <Color x:Key="Color_026">#00000000</Color>  <!--0% Black-->
                        <Color x:Key="Color_027">#33000000</Color>  <!--20% Black-->
                        <Color x:Key="Color_028">#66000000</Color>  <!--40% Black-->
                        <Color x:Key="Color_029">#99000000</Color>  <!--60% Black-->
                        <Color x:Key="Color_030">#CC000000</Color>  <!--80% Black-->

                        <!--Colors for Chart Series-->
                        <Color x:Key="Color_031">#FF6E7E16</Color>
                        <Color x:Key="Color_032">#FFa4ba29</Color>
                        <Color x:Key="Color_033">#FFfdbd48</Color>
                        <Color x:Key="Color_034">#FFF7AA1B</Color>
                        <Color x:Key="Color_035">#FFff888b</Color>
                        <Color x:Key="Color_036">#FFff6a6f</Color>
                        <Color x:Key="Color_037">#FF9e73c1</Color>
                        <Color x:Key="Color_038">#FF714199</Color>
                        <Color x:Key="Color_039">#FFf79036</Color>
                        <Color x:Key="Color_040">#FFBC5900</Color>
                        <Color x:Key="Color_041">#FF69299D</Color>
                        <Color x:Key="Color_042">#FF371356</Color>
                        <Color x:Key="Color_043">#FF48892d</Color>
                        <Color x:Key="Color_044">#FF285017</Color>
                        <Color x:Key="Color_045">#FFDC8F00</Color>
                        <Color x:Key="Color_046">#FFCA4E52</Color>

                        <!--Specific ToolTip Color-->
                        <Color x:Key="Color_047">#E5E7E7E7</Color>

                        <!--Colors for gradient brushes-->
                        <Color x:Key="Color_048">#33818181</Color>

                        <!-- ********************************** BULLETGRAPH/LINEARGAUGE COLORS **********************************-->
  
                        <Color x:Key="Color_049">#FF1487B8</Color>
                        <Color x:Key="Color_050">#FF106A92</Color>
                        <Color x:Key="Color_051">#FF1797CE</Color>
                        <Color x:Key="Color_052">#FF137BA8</Color>
                        <Color x:Key="Color_053">#FF3EA9D7</Color>
                        <Color x:Key="Color_054">#FF2894C1</Color>
                        <Color x:Key="Color_055">#FF65BBE0</Color>
                        <Color x:Key="Color_056">#FF42ABD9</Color>
                        <Color x:Key="Color_057">#FF8BCCE9</Color>
                        <Color x:Key="Color_058">#FF67BDE2</Color>
                    </ResourceDictionary>
                  </ResourceDictionary.MergedDictionaries>

                  <!-- *********************************  BRUSHES  ********************************* -->
                  <SolidColorBrush x:Key="ThemeForegroundBrush" Color="{StaticResource Color_001}" />
                  <SolidColorBrush x:Key="ThemeLightForegroundBrush" Color="{StaticResource Color_011}" />
                  <SolidColorBrush x:Key="TransparentBrush" Color="{StaticResource Color_021}" />
                  <SolidColorBrush x:Key="DarkGrayBorderBrush" Color="{StaticResource Color_003}" />
                  <SolidColorBrush x:Key="DisabledBackgroundBrush" Color="{StaticResource Color_007}" />
                  <SolidColorBrush x:Key="DisabledBorderBrush" Color="{StaticResource Color_008}" />

                  <!-- Scrollbar/ScrollViewer Brushes -->
                  <LinearGradientBrush x:Key="VScrollbarThumbHoverBackgroundBrush" StartPoint="0.199,0.469" EndPoint="1.17,0.469">
                    <GradientStop Color="{StaticResource Color_014}" />
                    <GradientStop Color="{StaticResource Color_016}" Offset="1" />
                  </LinearGradientBrush>

                  <LinearGradientBrush x:Key="VScrollbarThumbPressedBackgroundBrush" StartPoint="0.199,0.469" EndPoint="1.17,0.469">
                    <GradientStop Color="{StaticResource Color_014}" Offset="1" />
                    <GradientStop Color="{StaticResource Color_016}" />
                  </LinearGradientBrush>

                  <LinearGradientBrush x:Key="VScrollbarThumbBackgroundBrush" EndPoint="1,0.5" StartPoint="0,0.5">
                    <GradientStop Color="{StaticResource Color_004}" Offset="1" />
                    <GradientStop Color="{StaticResource Color_005}" />
                  </LinearGradientBrush>

                  <RadialGradientBrush x:Key="VScrollbarBackgroundBrush" Center="0.071435546875,0.5039216175738735" GradientOrigin="0,0.5" RadiusX="0.5" RadiusY="1.1">
                    <GradientStop Color="{StaticResource Color_008}" />
                    <GradientStop Color="{StaticResource Color_009}" Offset="1" />
                  </RadialGradientBrush>
                  <RadialGradientBrush x:Key="HScrollbarBackgroundBrush" Center="0.495,0.128" GradientOrigin="0.495,0.128" RadiusX="1.134" RadiusY="0.65">
                    <GradientStop Color="{StaticResource Color_008}" />
                    <GradientStop Color="{StaticResource Color_009}" Offset="1" />
                  </RadialGradientBrush>

                  <LinearGradientBrush x:Key="HScrollbarThumbBackgroundBrush" EndPoint="0.5,1" StartPoint="0.5,0">
                    <GradientStop Color="{StaticResource Color_004}" Offset="1" />
                    <GradientStop Color="{StaticResource Color_005}" />
                  </LinearGradientBrush>

                  <LinearGradientBrush x:Key="HScrollbarThumbHoverBackgroundBrush" StartPoint="0.684,-0.023" EndPoint="0.684,0.971">
                    <GradientStop Color="{StaticResource Color_014}" />
                    <GradientStop Color="{StaticResource Color_016}" Offset="1" />
                  </LinearGradientBrush>

                  <LinearGradientBrush x:Key="HScrollbarThumbPressedBackgroundBrush" StartPoint="0.684,1.2" EndPoint="0.684,0.03">
                    <GradientStop Color="{StaticResource Color_014}" />
                    <GradientStop Color="{StaticResource Color_016}" Offset="1" />
                  </LinearGradientBrush>

                  <SolidColorBrush x:Key="ScrollbarBorderBrush" Color="{StaticResource Color_022}" />
                  <SolidColorBrush x:Key="ScrollbarThumbDisabledBrush" Color="{StaticResource Color_005}" />
                  <SolidColorBrush x:Key="ArrowHoverBorderBrush" Color="{StaticResource Color_016}" />
                  <SolidColorBrush x:Key="ArrowDisabledBorderBrush" Color="{StaticResource Color_006}" />
                  <SolidColorBrush x:Key="ArrowDarkBorderBrush" Color="{StaticResource Color_004}" />
                  <SolidColorBrush x:Key="ArrowBackgroundBrush" Color="{StaticResource Color_005}" />
                  <SolidColorBrush x:Key="ScrollviewerCornerBackgroundBrush" Color="{StaticResource Color_009}" />
                  <SolidColorBrush x:Key="ScrollviewerBorderBrush" Color="{StaticResource Color_006}" />

                  <!-- ComboBox Brushes -->
                  <LinearGradientBrush x:Key="ComboBoxInnerShadowBackgroundBrush" StartPoint="0.505,0.469" EndPoint="0.505,-0.023">
                    <GradientStop Color="{StaticResource Color_026}" Offset="0.377" />
                    <GradientStop Color="{StaticResource Color_048}" Offset="1" />
                  </LinearGradientBrush>

                  <SolidColorBrush x:Key="ComboBoxBackgroundBrush" Color="{StaticResource Color_011}" />
                  <SolidColorBrush x:Key="ComboBoxBorderBrush" Color="{StaticResource Color_006}" />
                  <SolidColorBrush x:Key="ComboBoxHoverBorderBrush" Color="{StaticResource Color_014}" />
                  <SolidColorBrush x:Key="PopupBorderBrush" Color="{StaticResource Color_007}" />

                  <LinearGradientBrush x:Key="PopupBackgroundBrush" EndPoint="0.5,1" StartPoint="0.5,0">
                    <GradientStop Color="{StaticResource Color_009}" Offset="1" />
                    <GradientStop Color="{StaticResource Color_011}" />
                  </LinearGradientBrush>

                  <!-- ComboBoxItem Brushes -->
                  <LinearGradientBrush x:Key="ComboBoxItemHoverBackgroundBrush" StartPoint="0,0" EndPoint="0,1">
                    <GradientStop Color="{StaticResource Color_014}" />
                    <GradientStop Color="{StaticResource Color_016}" Offset="1" />
                  </LinearGradientBrush>

                  <SolidColorBrush x:Key="ComboBoxItemHoverBorderBrush" Color="{StaticResource Color_016}" />
                  <LinearGradientBrush x:Key="ComboBoxItemPressedBackgroundBrush" StartPoint="0,0 " EndPoint="0,1 ">
                    <GradientStop Color="{StaticResource Color_014}" Offset="1" />
                    <GradientStop Color="{StaticResource Color_016}" />
                  </LinearGradientBrush>
                  <SolidColorBrush x:Key="ComboBoxItemPressedBorderBrush" Color="{StaticResource Color_016}" />
                  <LinearGradientBrush x:Key="ComboBoxItemSelectedBackgroundBrush" StartPoint="0,0" EndPoint="0,1">
                    <GradientStop Offset="0" Color="{StaticResource Color_011}" />
                    <GradientStop Offset="0.97" Color="{StaticResource Color_009}" />
                    <GradientStop Offset="0.99" Color="{StaticResource Color_009}" />
                  </LinearGradientBrush>

                  <SolidColorBrush x:Key="ComboBoxItemFocusedBorderBrush" Color="{StaticResource Color_014}" />

                  <!-- ToggleButton Brushes -->
                  <LinearGradientBrush x:Key="ToggleButtonPressedBackgroundBrush" StartPoint="0,0 " EndPoint="0,1 ">
                    <GradientStop Color="{StaticResource Color_014}" Offset="1" />
                    <GradientStop Color="{StaticResource Color_016}" />
                  </LinearGradientBrush>

                  <LinearGradientBrush x:Key="ToggleButtonDisabledBackgroundBrush" StartPoint="0,0 " EndPoint="0,1 ">
                    <GradientStop Color="{StaticResource Color_008}" />
                    <GradientStop Color="{StaticResource Color_006}" Offset="1" />
                  </LinearGradientBrush>

                  <LinearGradientBrush x:Key="ToggleButtonFocusedBackgroundBrush" StartPoint="0,0 " EndPoint="0,1 ">
                    <GradientStop Color="{StaticResource Color_004}" Offset="1" />
                    <GradientStop Color="{StaticResource Color_002}" />
                  </LinearGradientBrush>

                  <LinearGradientBrush x:Key="ToggleButtonBackgroundBrush" EndPoint="0.5,1" StartPoint="0.5,0">
                    <GradientStop Color="{StaticResource Color_004}" />
                    <GradientStop Color="{StaticResource Color_002}" Offset="1" />
                  </LinearGradientBrush>

                  <LinearGradientBrush x:Key="ToggleButtonHoverBackgroundBrush" StartPoint="0,0" EndPoint="0,1">
                    <GradientStop Color="{StaticResource Color_014}" />
                    <GradientStop Color="{StaticResource Color_016}" Offset="1" />
                  </LinearGradientBrush>

                  <SolidColorBrush x:Key="ToggleButtonBorderBrush" Color="{StaticResource Color_002}" />
                  <SolidColorBrush x:Key="ToggleButtonHoverBorderBrush" Color="{StaticResource Color_016}" />
                  <SolidColorBrush x:Key="ToggleButtonDisabledBorderBrush" Color="{StaticResource Color_007}" />
                  <SolidColorBrush x:Key="ToggleButtonPressedBorderBrush" Color="{StaticResource Color_016}" />
                  <SolidColorBrush x:Key="ToggleButtonFocusedBorderBrush" Color="{StaticResource Color_014}" />

                  <!-- TextBox Brushes -->
                  <RadialGradientBrush x:Key="TextBoxInnerShadowBackgroundBrush" RadiusX="0.916" RadiusY="1.667" Center="0.72,0.528" GradientOrigin="0.72,0.528">
                    <GradientStop Color="{StaticResource Color_026}" Offset="0.679" />
                    <GradientStop Color="{StaticResource Color_027}" Offset="0.913" />
                  </RadialGradientBrush>

                  <LinearGradientBrush x:Key="TextBoxShadowBackgroundBrush" StartPoint="0.505,0.469" EndPoint="0.505,-0.023">
                    <GradientStop Color="{StaticResource Color_026}" Offset="0.377" />
                    <GradientStop Color="{StaticResource Color_048}" Offset="1" />
                  </LinearGradientBrush>

                  <LinearGradientBrush x:Key="TextBoxGradientBackgroundBrush" StartPoint="0.505,0.469" EndPoint="0.505,-0.023">
                    <GradientStop Color="{StaticResource Color_011}" Offset="0.377" />
                    <GradientStop Color="{StaticResource Color_009}" Offset="1" />
                  </LinearGradientBrush>

                  <SolidColorBrush x:Key="TextBoxBackgroundBrush" Color="{StaticResource Color_011}" />
                  <SolidColorBrush x:Key="TextBoxBorderBrush" Color="{StaticResource Color_006}" />
                  <SolidColorBrush x:Key="TextBoxHoverBorderBrush" Color="{StaticResource Color_015}" />
                  <SolidColorBrush x:Key="TextBoxnDisabledBorderBrush" Color="{StaticResource Color_007}" />
                  <SolidColorBrush x:Key="TextBoxDisabledForegroundBrush" Color="{StaticResource Color_007}" />
                  <SolidColorBrush x:Key="TextBoxFocusedBorderBrush" Color="{StaticResource Color_015}" />
                  <SolidColorBrush x:Key="ReadonlyBackgroundBrush" Color="{StaticResource Color_009}" />
                  <SolidColorBrush x:Key="ReadonlyBorderBrush" Color="{StaticResource Color_006}" />
                  <SolidColorBrush x:Key="TextBoxEditableBorderBrush" Color="{StaticResource Color_008}" />
                  <SolidColorBrush x:Key="TextBoxFocusedBrush" Color="{StaticResource Color_015}" />
                  <SolidColorBrush x:Key="TextBoxSelectionBackgroundBrush" Color="{StaticResource Color_015}" Opacity="0.4" />
                  <SolidColorBrush x:Key="TextBoxSelectionForegroundBrush" Color="{StaticResource Color_018}" />

                  <!-- Button Brushes -->
                  <LinearGradientBrush x:Key="ButtonBackgroundBrush" EndPoint="0.5,1" StartPoint="0.5,0">
                    <GradientStop Color="{StaticResource Color_004}" />
                    <GradientStop Color="{StaticResource Color_002}" Offset="1" />
                  </LinearGradientBrush>

                  <LinearGradientBrush x:Key="ButtonHoverBackgroundBrush" EndPoint="0.5,1" StartPoint="0.5,0">
                    <GradientStop Color="{StaticResource Color_014}" />
                    <GradientStop Color="{StaticResource Color_016}" Offset="1" />
                  </LinearGradientBrush>

                  <LinearGradientBrush x:Key="ButtonPressedBackgroundBrush" EndPoint="0.5,1" StartPoint="0.5,0">
                    <GradientStop Color="{StaticResource Color_014}" Offset="1" />
                    <GradientStop Color="{StaticResource Color_016}" />
                  </LinearGradientBrush>

                  <LinearGradientBrush x:Key="ButtonFocusedBackgroundBrush" EndPoint="0.5,1" StartPoint="0.5,0">
                    <GradientStop Color="{StaticResource Color_003}" />
                    <GradientStop Color="{StaticResource Color_001}" Offset="1" />
                  </LinearGradientBrush>

                  <LinearGradientBrush x:Key="ButtonDisabledBackgroundBrush" EndPoint="0.5,1" StartPoint="0.5,0">
                    <GradientStop Color="{StaticResource Color_008}" />
                    <GradientStop Color="{StaticResource Color_006}" Offset="1" />
                  </LinearGradientBrush>

                  <SolidColorBrush x:Key="ButtonHoverBorderBrush" Color="{StaticResource Color_016}" />
                  <SolidColorBrush x:Key="ButtonFocusedBorderBrush" Color="{StaticResource Color_014}" />
                  <SolidColorBrush x:Key="ButtonPressedBorderBrush" Color="{StaticResource Color_016}" />
                  <SolidColorBrush x:Key="ButtonBorderBrush" Color="{StaticResource Color_002}" />
                  <SolidColorBrush x:Key="ButtonDisabledBorderBrush" Color="{StaticResource Color_007}" />

                  <!-- CheckBox Brushes -->
                  <RadialGradientBrush x:Key="CheckBoxInnerShadowBrush" RadiusX="0.916" RadiusY="2.028" Center="0.929,0.499" GradientOrigin="0.929,0.499">
                    <GradientStop Color="{StaticResource Color_026}" Offset="0.679" />
                    <GradientStop Color="{StaticResource Color_027}" Offset="0.997" />
                  </RadialGradientBrush>

                  <RadialGradientBrush x:Key="CheckBoxBackgroundBrush" RadiusX="0.916" RadiusY="0.667" Center="0.5,0.6" GradientOrigin="0.5,0.6">
                    <GradientStop Color="{StaticResource Color_011}" Offset="0.645" />
                    <GradientStop Color="{StaticResource Color_008}" Offset="1" />
                  </RadialGradientBrush>

                  <SolidColorBrush x:Key="CheckBoxBorderBrush" Color="{StaticResource Color_006}" />
                  <SolidColorBrush x:Key="CheckBoxHoverBorderBrush" Color="{StaticResource Color_014}" />
                  <SolidColorBrush x:Key="CheckBoxFocusedBorderBrush" Color="{StaticResource Color_014}" />
                  <SolidColorBrush x:Key="CheckBoxGlyphBackgroundBrush" Color="{StaticResource Color_003}" />

                  <!-- RadioButton Brushes -->
                  <RadialGradientBrush x:Key="RadioButtonBackgroundBrush" RadiusX="0.916" RadiusY="0.667" Center="0.5,0.6" GradientOrigin="0.5,0.6">
                    <GradientStop Color="{StaticResource Color_011}" Offset="0.645" />
                    <GradientStop Color="{StaticResource Color_008}" Offset="1" />
                  </RadialGradientBrush>

                  <LinearGradientBrush x:Key="RadioButtonCheckBackgroundBrush" StartPoint="0.5,0" EndPoint="0.5,1">
                    <GradientStop Offset="0" Color="{StaticResource Color_014}" />
                    <GradientStop Offset="0.80" Color="{StaticResource Color_017}" />
                    <GradientStop Offset="1" Color="{StaticResource Color_017}" />
                  </LinearGradientBrush>

                  <SolidColorBrush x:Key="RadioButtonHoverBorderBrush" Color="{StaticResource Color_013}" />
                  <SolidColorBrush x:Key="RadioButtonPressedBorderBrush" Color="{StaticResource Color_015}" />
                  <SolidColorBrush x:Key="RadioButtonDisabledBorderBrush" Color="{StaticResource Color_007}" />
                  <SolidColorBrush x:Key="RadioButtonBorderBrush" Color="{StaticResource Color_006}" />
                  <SolidColorBrush x:Key="RadioButtonCheckBorderBrush" Color="{StaticResource Color_016}" />

                  <!-- Validation Brushes -->
                  <SolidColorBrush x:Key="InvalidUnfocusedBrush" Color="{StaticResource Color_019}" />
                  <SolidColorBrush x:Key="InvalidFocusedBrush" Color="{StaticResource Color_020}" />
                  <SolidColorBrush x:Key="ValidationToolTipBackgroundFill" Color="{StaticResource Color_027}" />
                  <SolidColorBrush x:Key="ValidationErrorElementBrush" Color="{StaticResource Color_020}" />

                  <!-- ListBox Brushes -->
                  <SolidColorBrush x:Key="ListBoxBorderBrush" Color="{StaticResource Color_006}" />

                  <SolidColorBrush x:Key="ListBoxItemBackgroundBrush" Color="{StaticResource Color_021}" />
                  <SolidColorBrush x:Key="ListBoxItemBorderBrush" Color="{StaticResource Color_021}" />

                  <LinearGradientBrush x:Key="ListBoxItemHoverBackgroundBrush" EndPoint="0.5,1" StartPoint="0.5,0">
                    <GradientStop Color="{StaticResource Color_014}" />
                    <GradientStop Color="{StaticResource Color_016}" Offset="1" />
                  </LinearGradientBrush>
                  <SolidColorBrush x:Key="ListBoxItemHoverBorderBrush" Color="{StaticResource Color_016}" />

                  <SolidColorBrush x:Key="ListBoxItemFocusedBorderBrush" Color="{StaticResource Color_014}" />
                  <LinearGradientBrush x:Key="LIstBoxItemSelectedBackgroundBrush" StartPoint="0.7,-0.0390625" EndPoint="0.7,1">
                    <GradientStop Color="{StaticResource Color_011}" Offset="0" />
                    <GradientStop Color="{StaticResource Color_009}" Offset="1" />
                  </LinearGradientBrush>

                  <!-- ******************************************************** SL-WPF INLINE-CONTROLS SHARED RESOURCES ***********************************************************
                *********************************************************************************************************************************************************************    -->

                  <!-- *********************************  ValidationToolTipTemplate  ********************************* -->
                  <ControlTemplate x:Key="ValidationToolTipTemplate">
                    <Grid x:Name="Root" Margin="5,0" RenderTransformOrigin="0,0" Opacity="0">
                      <Grid.RenderTransform>
                        <TranslateTransform x:Name="xform" X="-25" />
                      </Grid.RenderTransform>
                      <VisualStateManager.VisualStateGroups>
                        <VisualStateGroup Name="OpenStates">
                          <VisualStateGroup.Transitions>
                            <VisualTransition GeneratedDuration="0" />
                            <VisualTransition To="Open" GeneratedDuration="0:0:0.2">
                              <Storyboard>
                                <DoubleAnimation Storyboard.TargetName="xform" Storyboard.TargetProperty="X" To="0" Duration="0:0:0.2">
                                  <DoubleAnimation.EasingFunction>
                                    <BackEase Amplitude=".3" EasingMode="EaseOut" />
                                  </DoubleAnimation.EasingFunction>
                                </DoubleAnimation>
                                <DoubleAnimation Storyboard.TargetName="Root" Storyboard.TargetProperty="Opacity" To="1" Duration="0:0:0.2" />
                              </Storyboard>
                            </VisualTransition>
                          </VisualStateGroup.Transitions>
                          <VisualState x:Name="Closed">
                            <Storyboard>
                              <DoubleAnimation Storyboard.TargetName="Root" Storyboard.TargetProperty="Opacity" To="0" Duration="0" />
                            </Storyboard>
                          </VisualState>
                          <VisualState x:Name="Open">
                            <Storyboard>
                              <DoubleAnimation Storyboard.TargetName="xform" Storyboard.TargetProperty="X" To="0" Duration="0" />
                              <DoubleAnimation Storyboard.TargetName="Root" Storyboard.TargetProperty="Opacity" To="1" Duration="0" />
                            </Storyboard>
                          </VisualState>
                        </VisualStateGroup>
                      </VisualStateManager.VisualStateGroups>
                      <Border Margin="3,3,-3,-3" Background="{StaticResource ValidationToolTipBackgroundFill}" CornerRadius="4" />
                      <Border Margin="2,2,-2,-2" Background="{StaticResource ValidationToolTipBackgroundFill}" CornerRadius="3" />
                      <Border Margin="1,1,-1,-1" Background="{StaticResource ValidationToolTipBackgroundFill}" CornerRadius="2" />
                      <Border Background="{StaticResource InvalidFocusedBrush}" CornerRadius="2" />
                      <Border CornerRadius="2">
                        <TextBlock UseLayoutRounding="false" Foreground="{StaticResource ThemeLightForegroundBrush}" Margin="8,4,8,4" MaxWidth="250" TextWrapping="Wrap" Text="{Binding (Validation.Errors)[0].ErrorContent}" />
                      </Border>
                    </Grid>
                  </ControlTemplate>
                  <!-- *********************************  ButtonStyle  ********************************* -->
                  <Style x:Key="ButtonStyle" TargetType="Button">
                    <Setter Property="Foreground" Value="{StaticResource ThemeLightForegroundBrush}" />
                    <Setter Property="Padding" Value="8,0,8,2" />
                    <Setter Property="Margin" Value="0" />
                    <Setter Property="MinHeight" Value="22" />
                    <Setter Property="FontFamily" Value="Segoe UI" />
                    <Setter Property="FontSize" Value="12" />
                    <Setter Property="BorderThickness" Value="1" />
                    <Setter Property="Template">
                      <Setter.Value>
                        <ControlTemplate TargetType="Button">
                          <Grid>
                            <VisualStateManager.VisualStateGroups>
                              <VisualStateGroup x:Name="CommonStates">
                                <VisualStateGroup.Transitions>
                                  <VisualTransition GeneratedDuration="0:0:0.2" />
                                </VisualStateGroup.Transitions>
                                <VisualState x:Name="Normal" />
                                <VisualState x:Name="MouseOver">
                                  <Storyboard>
                                    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="hover" d:IsOptimized="True" />
                                  </Storyboard>
                                </VisualState>
                                <VisualState x:Name="Pressed">
                                  <Storyboard>
                                    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="pressed" d:IsOptimized="True" />
                                  </Storyboard>
                                </VisualState>
                                <VisualState x:Name="Disabled">
                                  <Storyboard>
                                    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="disabled" d:IsOptimized="True" />
                                    <DoubleAnimation Duration="0" To="0.5" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="contentPresenter" d:IsOptimized="True" />
                                  </Storyboard>
                                </VisualState>
                              </VisualStateGroup>
                              <VisualStateGroup x:Name="FocusStates">
                                <VisualState x:Name="Focused">
                                  <Storyboard>
                                    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="focused" d:IsOptimized="True" />
                                  </Storyboard>
                                </VisualState>
                                <VisualState x:Name="Unfocused" />
                              </VisualStateGroup>
                            </VisualStateManager.VisualStateGroups>
                            <Rectangle x:Name="normal" Opacity="1" RadiusX="3" RadiusY="3" StrokeThickness="{TemplateBinding BorderThickness}" Stroke="{StaticResource ButtonBorderBrush}" Fill="{StaticResource ButtonBackgroundBrush}" />
                            <Rectangle x:Name="hover" Opacity="0" RadiusX="3" RadiusY="3" StrokeThickness="{TemplateBinding BorderThickness}" Stroke="{StaticResource ButtonHoverBorderBrush}" Fill="{StaticResource ButtonHoverBackgroundBrush}" />
                            <Rectangle x:Name="pressed" Opacity="0" RadiusX="3" RadiusY="3" StrokeThickness="{TemplateBinding BorderThickness}" Stroke="{StaticResource ButtonPressedBorderBrush}" Fill="{StaticResource ButtonPressedBackgroundBrush}" />
                            <Rectangle x:Name="focused" Opacity="0" RadiusX="3" RadiusY="3" StrokeThickness="{TemplateBinding BorderThickness}" Stroke="{StaticResource ButtonFocusedBorderBrush}" />
                            <Rectangle x:Name="disabled" Opacity="0" RadiusX="3" RadiusY="3" StrokeThickness="{TemplateBinding BorderThickness}" Stroke="{StaticResource ButtonDisabledBorderBrush}" Fill="{StaticResource ButtonDisabledBackgroundBrush}" />
                            <ContentPresenter x:Name="contentPresenter" ContentTemplate="{TemplateBinding ContentTemplate}" Content="{TemplateBinding Content}" Margin="{TemplateBinding Padding}" HorizontalAlignment="Center" VerticalAlignment="Center" />
                          </Grid>
                        </ControlTemplate>
                      </Setter.Value>
                    </Setter>
                  </Style>

                  <!-- ********************************** CheckBoxStyle **********************************-->
                  <Style x:Key="CheckBoxStyle" TargetType="CheckBox">
                    <Setter Property="Foreground" Value="{StaticResource ThemeForegroundBrush}" />
                    <Setter Property="HorizontalContentAlignment" Value="Left" />
                    <Setter Property="VerticalContentAlignment" Value="Top" />
                    <Setter Property="Padding" Value="4,1,0,0" />
                    <Setter Property="BorderThickness" Value="1" />
                    <Setter Property="Template">
                      <Setter.Value>
                        <ControlTemplate TargetType="CheckBox">
                          <Grid>
                            <Grid.ColumnDefinitions>
                              <ColumnDefinition Width="18" />
                              <ColumnDefinition Width="*" />
                            </Grid.ColumnDefinitions>
                            <VisualStateManager.VisualStateGroups>
                              <VisualStateGroup x:Name="CommonStates">
                                <VisualStateGroup.Transitions>
                                  <VisualTransition GeneratedDuration="0:0:0.2" />
                                </VisualStateGroup.Transitions>
                                <VisualState x:Name="Normal" />
                                <VisualState x:Name="MouseOver">
                                  <Storyboard>
                                    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="hover" d:IsOptimized="True" />
                                  </Storyboard>
                                </VisualState>
                                <VisualState x:Name="Pressed">
                                  <Storyboard>
                                    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="pressed" d:IsOptimized="True" />
                                  </Storyboard>
                                </VisualState>
                                <VisualState x:Name="Disabled">
                                  <Storyboard>
                                    <DoubleAnimation Duration="0" To=".55" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="contentPresenter" />
                                    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="disabled" d:IsOptimized="True" />
                                  </Storyboard>
                                </VisualState>
                              </VisualStateGroup>
                              <VisualStateGroup x:Name="CheckStates">
                                <VisualState x:Name="Checked">
                                  <Storyboard>
                                    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="checkBox" d:IsOptimized="True" />
                                  </Storyboard>
                                </VisualState>
                                <VisualState x:Name="Unchecked" />
                                <VisualState x:Name="Indeterminate">
                                  <Storyboard>
                                    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="IndeterminateIcon" d:IsOptimized="True" />
                                  </Storyboard>
                                </VisualState>
                              </VisualStateGroup>
                              <VisualStateGroup x:Name="FocusStates">
                                <VisualState x:Name="Focused">
                                  <Storyboard>
                                    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="focused" d:IsOptimized="True" />
                                  </Storyboard>
                                </VisualState>
                                <VisualState x:Name="Unfocused" />
                              </VisualStateGroup>
                              <VisualStateGroup x:Name="ValidationStates">
                                <VisualState x:Name="Valid" />
                                <VisualState x:Name="InvalidUnfocused">
                                  <Storyboard>
                                    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="invalidUnfocused" d:IsOptimized="True" />
                                  </Storyboard>
                                </VisualState>
                                <VisualState x:Name="InvalidFocused">
                                  <Storyboard>
                                    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="invalidFocused" d:IsOptimized="True" />
                                  </Storyboard>
                                </VisualState>
                              </VisualStateGroup>
                            </VisualStateManager.VisualStateGroups>
                            <Rectangle x:Name="normal" Opacity="1" Width="14" RadiusX="1" RadiusY="1" Stroke="{StaticResource CheckBoxBorderBrush}" StrokeThickness="1" HorizontalAlignment="Left" Margin="2,2,0,0" Height="14" VerticalAlignment="Top" Fill="{StaticResource CheckBoxBackgroundBrush}" />
                            <Rectangle x:Name="hover" Width="14" RadiusX="1" RadiusY="1" Stroke="{StaticResource CheckBoxHoverBorderBrush}" StrokeThickness="1" HorizontalAlignment="Left" Margin="2,2,0,0" Height="14" VerticalAlignment="Top" Fill="{StaticResource CheckBoxBackgroundBrush}" Opacity="0" />
                            <Rectangle x:Name="pressed" Opacity="0" Width="14" RadiusX="1" RadiusY="1" Stroke="{StaticResource CheckBoxFocusedBorderBrush}" StrokeThickness="1" Fill="{StaticResource CheckBoxBackgroundBrush}" HorizontalAlignment="Left" Margin="2,2,0,0" Height="14" VerticalAlignment="Top" />
                            <Rectangle x:Name="focused" Opacity="0" Width="14" RadiusX="1" RadiusY="1" Stroke="{StaticResource CheckBoxFocusedBorderBrush}" StrokeThickness="1" Fill="{StaticResource CheckBoxBackgroundBrush}" HorizontalAlignment="Left" Margin="2,2,0,0" Height="14" VerticalAlignment="Top" />
                            <Rectangle x:Name="disabled" Opacity="0" Width="14" RadiusX="1" RadiusY="1" Stroke="{StaticResource DisabledBorderBrush}" StrokeThickness="1" Fill="{StaticResource CheckBoxBackgroundBrush}" HorizontalAlignment="Left" Margin="2,2,0,0" Height="14" VerticalAlignment="Top" />
                            <Rectangle x:Name="invalidUnfocused" Opacity="0" Width="14" RadiusX="1" RadiusY="1" Stroke="{StaticResource InvalidUnfocusedBrush}" StrokeThickness="1" HorizontalAlignment="Left" Margin="2,2,0,0" Height="14" VerticalAlignment="Top" Fill="{StaticResource CheckBoxBackgroundBrush}" />
                            <Rectangle x:Name="invalidFocused" Opacity="0" Width="14" RadiusX="1" RadiusY="1" Stroke="{StaticResource InvalidFocusedBrush}" StrokeThickness="1" HorizontalAlignment="Left" Margin="2,2,0,0" Height="14" VerticalAlignment="Top" Fill="{StaticResource CheckBoxBackgroundBrush}" />
                            <Rectangle x:Name="innerShadow" Width="14" StrokeThickness="1" HorizontalAlignment="Left" Margin="2,2,0,0" Height="14" VerticalAlignment="Top" RadiusX="0.5" RadiusY="0.5" Fill="{StaticResource CheckBoxInnerShadowBrush}" />
                            <Path x:Name="checkBox" Height="8" Width="10" Stretch="Fill" Opacity="0" Fill="{StaticResource CheckBoxGlyphBackgroundBrush}" HorizontalAlignment="Left" Data="M 1145.607177734375,430 C1145.607177734375,430 1141.449951171875,435.0772705078125 1141.449951171875,435.0772705078125 1141.449951171875,435.0772705078125 1139.232177734375,433.0999755859375 1139.232177734375,433.0999755859375 1139.232177734375,433.0999755859375 1138,434.5538330078125 1138,434.5538330078125 1138,434.5538330078125 1141.482177734375,438 1141.482177734375,438 1141.482177734375,438 1141.96875,437.9375 1141.96875,437.9375 1141.96875,437.9375 1147,431.34619140625 1147,431.34619140625 1147,431.34619140625 1145.607177734375,430 1145.607177734375,430 z" Margin="4,5,0,0" UseLayoutRounding="False" VerticalAlignment="Top" />
                            <Rectangle x:Name="IndeterminateIcon" Fill="{StaticResource CheckBoxGlyphBackgroundBrush}" Height="2" Width="6" VerticalAlignment="Top" Margin="0,8,0,0" Opacity="0" />
                            <ContentPresenter x:Name="contentPresenter" ContentTemplate="{TemplateBinding ContentTemplate}" Content="{TemplateBinding Content}" Grid.Column="1" HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" Margin="{TemplateBinding Padding}" VerticalAlignment="{TemplateBinding VerticalContentAlignment}" />
                          </Grid>
                        </ControlTemplate>
                      </Setter.Value>
                    </Setter>
                  </Style>

                  <!-- ********************************** RadioButton Style **********************************-->
                  <Style x:Key="RadioButtonStyle" TargetType="RadioButton">
                    <Setter Property="Foreground" Value="{StaticResource ThemeForegroundBrush}" />
                    <Setter Property="HorizontalContentAlignment" Value="Left" />
                    <Setter Property="VerticalContentAlignment" Value="Center" />
                    <Setter Property="Padding" Value="4,0,0,0" />
                    <Setter Property="Template">
                      <Setter.Value>
                        <ControlTemplate TargetType="RadioButton">
                          <Grid>
                            <Grid.ColumnDefinitions>
                              <ColumnDefinition Width="16" />
                              <ColumnDefinition Width="*" />
                            </Grid.ColumnDefinitions>
                            <VisualStateManager.VisualStateGroups>
                              <VisualStateGroup x:Name="CommonStates">
                                <VisualState x:Name="Normal" />
                                <VisualState x:Name="MouseOver">
                                  <Storyboard>
                                    <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Visibility)" Storyboard.TargetName="hoverBd">
                                      <DiscreteObjectKeyFrame KeyTime="0">
                                        <DiscreteObjectKeyFrame.Value>
                                          <Visibility>Visible</Visibility>
                                        </DiscreteObjectKeyFrame.Value>
                                      </DiscreteObjectKeyFrame>
                                    </ObjectAnimationUsingKeyFrames>
                                  </Storyboard>
                                </VisualState>
                                <VisualState x:Name="Pressed">
                                  <Storyboard>
                                    <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Visibility)" Storyboard.TargetName="pressedBd">
                                      <DiscreteObjectKeyFrame KeyTime="0">
                                        <DiscreteObjectKeyFrame.Value>
                                          <Visibility>Visible</Visibility>
                                        </DiscreteObjectKeyFrame.Value>
                                      </DiscreteObjectKeyFrame>
                                    </ObjectAnimationUsingKeyFrames>
                                  </Storyboard>
                                </VisualState>
                                <VisualState x:Name="Disabled">
                                  <Storyboard>
                                    <DoubleAnimation Duration="0" To=".55" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="contentPresenter" />
                                    <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetProperty="Stroke" Storyboard.TargetName="RadioButtonBackground">
                                      <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButtonDisabledBorderBrush}" />
                                    </ObjectAnimationUsingKeyFrames>
                                  </Storyboard>
                                </VisualState>
                              </VisualStateGroup>
                              <VisualStateGroup x:Name="CheckStates">
                                <VisualState x:Name="Checked">
                                  <Storyboard>
                                    <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Visibility)" Storyboard.TargetName="check">
                                      <DiscreteObjectKeyFrame KeyTime="0">
                                        <DiscreteObjectKeyFrame.Value>
                                          <Visibility>Visible</Visibility>
                                        </DiscreteObjectKeyFrame.Value>
                                      </DiscreteObjectKeyFrame>
                                    </ObjectAnimationUsingKeyFrames>
                                  </Storyboard>
                                </VisualState>
                                <VisualState x:Name="Unchecked">
                                  <Storyboard>
                                    <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Visibility)" Storyboard.TargetName="check">
                                      <DiscreteObjectKeyFrame KeyTime="0">
                                        <DiscreteObjectKeyFrame.Value>
                                          <Visibility>Collapsed</Visibility>
                                        </DiscreteObjectKeyFrame.Value>
                                      </DiscreteObjectKeyFrame>
                                    </ObjectAnimationUsingKeyFrames>
                                  </Storyboard>
                                </VisualState>
                                <VisualState x:Name="Indeterminate" />
                              </VisualStateGroup>
                              <VisualStateGroup x:Name="FocusStates">
                                <VisualState x:Name="Unfocused" />
                                <VisualState x:Name="Focused" />
                              </VisualStateGroup>
                            </VisualStateManager.VisualStateGroups>
                            <Rectangle x:Name="RadioButtonBackground" Width="13" Height="13" RadiusX="3" RadiusY="3" Fill="{StaticResource RadioButtonBackgroundBrush}" Stroke="{StaticResource RadioButtonBorderBrush}" StrokeThickness="1" Margin="2,2,0,0" />
                            <Rectangle x:Name="hoverBd" Visibility="Collapsed" Width="13" Height="13" RadiusX="3" RadiusY="3" Fill="{StaticResource RadioButtonBackgroundBrush}" Stroke="{StaticResource RadioButtonHoverBorderBrush}" StrokeThickness="1" Margin="2,2,0,0" />
                            <Rectangle x:Name="pressedBd" Visibility="Collapsed" Width="13" Height="13" RadiusX="3" RadiusY="3" Fill="{StaticResource RadioButtonBackgroundBrush}" Stroke="{StaticResource RadioButtonPressedBorderBrush}" StrokeThickness="1" Margin="2,2,0,0" />
                            <Rectangle x:Name="check" Visibility="Collapsed" Width="9" Height="9" RadiusX="2" RadiusY="2" Stroke="{StaticResource RadioButtonCheckBorderBrush}" StrokeThickness="1" Fill="{StaticResource RadioButtonCheckBackgroundBrush}" Margin="2,2,0,0" />
                            <ContentPresenter x:Name="contentPresenter" ContentTemplate="{TemplateBinding ContentTemplate}" Content="{TemplateBinding Content}" Grid.Column="1" HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" Margin="{TemplateBinding Padding}" VerticalAlignment="{TemplateBinding VerticalContentAlignment}" />
                          </Grid>
                        </ControlTemplate>
                      </Setter.Value>
                    </Setter>
                  </Style>

                  <!-- *********************************  ComboBoxToggleButton Style   ********************************* -->
                  <Style x:Key="ComboToggleStyle" TargetType="ToggleButton">
                    <Setter Property="Background" Value="{StaticResource ComboBoxBackgroundBrush}" />
                    <Setter Property="BorderBrush" Value="{StaticResource ComboBoxBorderBrush}" />
                    <Setter Property="BorderThickness" Value="1" />
                    <Setter Property="Foreground" Value="{StaticResource ThemeLightForegroundBrush}" />
                    <Setter Property="Padding" Value="5,0,5,0" />
                    <Setter Property="Cursor" Value="Hand" />
                    <Setter Property="Template">
                      <Setter.Value>
                        <ControlTemplate TargetType="ToggleButton">
                          <Grid>
                            <VisualStateManager.VisualStateGroups>
                              <VisualStateGroup x:Name="CommonStates">
                                <VisualState x:Name="Normal" />
                                <VisualState x:Name="MouseOver">
                                  <Storyboard>
                                    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="hover" d:IsOptimized="True" />
                                    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="arrowHover" d:IsOptimized="True" />
                                  </Storyboard>
                                </VisualState>
                                <VisualState x:Name="Pressed">
                                  <Storyboard>
                                    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="pressed" d:IsOptimized="True" />
                                    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="arrowHover" d:IsOptimized="True" />
                                  </Storyboard>
                                </VisualState>
                                <VisualState x:Name="Disabled">
                                  <Storyboard>
                                    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="disabled" d:IsOptimized="True" />
                                    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="arrowDisabled" d:IsOptimized="True" />
                                  </Storyboard>
                                </VisualState>
                              </VisualStateGroup>
                              <VisualStateGroup x:Name="CheckStates">
                                <VisualState x:Name="Checked">
                                  <Storyboard>
                                    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="focused" d:IsOptimized="True" />
                                  </Storyboard>
                                </VisualState>
                                <VisualState x:Name="Unchecked" />
                                <VisualState x:Name="Indeterminate" />
                              </VisualStateGroup>
                              <VisualStateGroup x:Name="FocusStates">
                                <VisualState x:Name="Focused" />
                                <VisualState x:Name="Unfocused" />
                              </VisualStateGroup>
                            </VisualStateManager.VisualStateGroups>
                            <Grid.ColumnDefinitions>
                              <ColumnDefinition Width="*" />
                              <ColumnDefinition Width="22" />
                            </Grid.ColumnDefinitions>
                            <Rectangle Fill="Transparent" HorizontalAlignment="Stretch" />
                            <Rectangle x:Name="normal" Fill="{StaticResource ToggleButtonBackgroundBrush}" Stroke="{StaticResource ToggleButtonBorderBrush}" RadiusX="3" Grid.Column="1" RadiusY="3" Width="{Binding Height, Mode=OneWay, RelativeSource={RelativeSource TemplatedParent}}" />
                            <Rectangle x:Name="hover" Fill="{StaticResource ToggleButtonHoverBackgroundBrush}" Stroke="{StaticResource ToggleButtonHoverBorderBrush}" RadiusX="3" Grid.Column="1" RadiusY="3" Opacity="0" />
                            <Rectangle x:Name="pressed" Fill="{StaticResource ToggleButtonPressedBackgroundBrush}" Stroke="{StaticResource ToggleButtonPressedBorderBrush}" RadiusX="3" Grid.Column="1" RadiusY="3" Opacity="0" />
                            <Rectangle x:Name="disabled" Fill="{StaticResource ToggleButtonDisabledBackgroundBrush}" Stroke="{StaticResource ToggleButtonDisabledBorderBrush}" RadiusX="3" Grid.Column="1" RadiusY="3" Opacity="0" />
                            <Rectangle x:Name="focused" Fill="{StaticResource ToggleButtonFocusedBackgroundBrush}" Stroke="{StaticResource ToggleButtonFocusedBorderBrush}" RadiusX="3" Grid.Column="1" RadiusY="3" Opacity="0" />
                            <Path x:Name="BtnArrow" Stretch="Uniform" Height="4" Fill="White" Data="F1 M 301.14,-189.041L 311.57,-189.041L 306.355,-182.942L 301.14,-189.041 Z" Grid.Column="1" UseLayoutRounding="False" VerticalAlignment="Center" HorizontalAlignment="Center" />
                            <Path HorizontalAlignment="{TemplateBinding HorizontalAlignment}" VerticalAlignment="{TemplateBinding VerticalAlignment}" Height="7" Width="10" Stretch="Fill" Opacity="1" Data="M 17,19 C17,19 12,26 12,26 12,26 7,19 7,19 7,19 17,19 17,19 z" Stroke="{StaticResource DarkGrayBorderBrush}" Fill="{TemplateBinding Foreground}" Grid.Column="1" StrokeThickness="{TemplateBinding BorderThickness}" />
                            <Path x:Name="arrowHover" HorizontalAlignment="{TemplateBinding HorizontalAlignment}" VerticalAlignment="{TemplateBinding VerticalAlignment}" Height="7" Width="10" Stretch="Fill" Opacity="0" Data="M 17,19 C17,19 12,26 12,26 12,26 7,19 7,19 7,19 17,19 17,19 z" Stroke="{StaticResource ArrowHoverBorderBrush}" Fill="{TemplateBinding Foreground}" Grid.Column="1" StrokeThickness="{TemplateBinding BorderThickness}" />
                            <Path x:Name="arrowDisabled" HorizontalAlignment="{TemplateBinding HorizontalAlignment}" VerticalAlignment="{TemplateBinding VerticalAlignment}" Height="7" Width="10" Stretch="Fill" Opacity="0" Data="M 17,19 C17,19 12,26 12,26 12,26 7,19 7,19 7,19 17,19 17,19 z" Stroke="{StaticResource ArrowDisabledBorderBrush}" Fill="{TemplateBinding Foreground}" Grid.Column="1" StrokeThickness="{TemplateBinding BorderThickness}" />
                          </Grid>
                        </ControlTemplate>
                      </Setter.Value>
                    </Setter>
                  </Style>

                  <!-- *********************************  ComboBoxItem Style  ********************************* -->
                  <Style x:Key="ComboBoxItemStyle" TargetType="ComboBoxItem">
                    <Setter Property="Padding" Value="5,3,5,3" />
                    <Setter Property="HorizontalContentAlignment" Value="Left" />
                    <Setter Property="VerticalContentAlignment" Value="Center" />
                    <Setter Property="Background" Value="{StaticResource TransparentBrush}" />
                    <Setter Property="Foreground" Value="{StaticResource ThemeForegroundBrush}" />
                    <Setter Property="BorderThickness" Value="1" />
                    <Setter Property="Height" Value="22" />
                    <Setter Property="Template">
                      <Setter.Value>
                        <ControlTemplate TargetType="ComboBoxItem">
                          <Grid Background="{TemplateBinding Background}">
                            <VisualStateManager.VisualStateGroups>
                              <VisualStateGroup x:Name="CommonStates">
                                <VisualState x:Name="Normal" />
                                <VisualState x:Name="MouseOver">
                                  <Storyboard>
                                    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="Opacity" Storyboard.TargetName="fillColor" />
                                    <ObjectAnimationUsingKeyFrames Storyboard.TargetName="contentControl" Storyboard.TargetProperty="Foreground">
                                      <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource ThemeLightForegroundBrush}" />
                                    </ObjectAnimationUsingKeyFrames>
                                  </Storyboard>
                                </VisualState>
                                <VisualState x:Name="Disabled">
                                  <Storyboard>
                                    <DoubleAnimation Duration="0" To="0.5" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="contentControl" d:IsOptimized="True" />
                                  </Storyboard>
                                </VisualState>
                              </VisualStateGroup>
                              <VisualStateGroup x:Name="SelectionStates">
                                <VisualState x:Name="Unselected" />
                                <VisualState x:Name="Selected" />
                                <VisualState x:Name="SelectedUnfocused" />
                              </VisualStateGroup>
                              <VisualStateGroup x:Name="FocusStates">
                                <VisualState x:Name="Focused">
                                  <Storyboard>
                                    <ObjectAnimationUsingKeyFrames Storyboard.TargetName="FocusVisualElement" Storyboard.TargetProperty="(UIElement.Visibility)">
                                      <DiscreteObjectKeyFrame KeyTime="00:00:00">
                                        <DiscreteObjectKeyFrame.Value>
                                          <Visibility>Visible</Visibility>
                                        </DiscreteObjectKeyFrame.Value>
                                      </DiscreteObjectKeyFrame>
                                    </ObjectAnimationUsingKeyFrames>
                                    <ObjectAnimationUsingKeyFrames Storyboard.TargetName="contentControl1" Storyboard.TargetProperty="(UIElement.Visibility)">
                                      <DiscreteObjectKeyFrame KeyTime="00:00:00">
                                        <DiscreteObjectKeyFrame.Value>
                                          <Visibility>Collapsed</Visibility>
                                        </DiscreteObjectKeyFrame.Value>
                                      </DiscreteObjectKeyFrame>
                                    </ObjectAnimationUsingKeyFrames>
                                    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="contentControl1" d:IsOptimized="True" />
                                  </Storyboard>
                                </VisualState>
                                <VisualState x:Name="Unfocused" />
                              </VisualStateGroup>
                              <VisualStateGroup x:Name="LayoutStates">
                                <VisualState x:Name="AfterLoaded" />
                                <VisualState x:Name="BeforeLoaded" />
                                <VisualState x:Name="BeforeUnloaded" />
                              </VisualStateGroup>
                            </VisualStateManager.VisualStateGroups>
                            <Rectangle x:Name="fillColor" Fill="{StaticResource ComboBoxItemHoverBackgroundBrush}" IsHitTestVisible="False" Opacity="0" RadiusY="1" RadiusX="1" Stroke="{StaticResource ComboBoxItemHoverBorderBrush}" StrokeThickness="{TemplateBinding BorderThickness}" />
                            <Rectangle x:Name="FocusVisualElement" RadiusY="1" RadiusX="1" Stroke="{StaticResource ComboBoxItemFocusedBorderBrush}" Visibility="Collapsed" StrokeThickness="{TemplateBinding BorderThickness}" />
                            <ContentControl x:Name="contentControl" HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" VerticalAlignment="{TemplateBinding VerticalContentAlignment}" Margin="{TemplateBinding Padding}" Foreground="{TemplateBinding Foreground}">
                              <ContentPresenter x:Name="contentPresenter" />
                            </ContentControl>
                            <ContentControl x:Name="contentControl1" HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" Opacity="0" VerticalAlignment="{TemplateBinding VerticalContentAlignment}" Margin="{TemplateBinding Padding}" Foreground="{TemplateBinding Foreground}">
                              <ContentPresenter x:Name="contentPresenter1" />
                            </ContentControl>
                          </Grid>
                        </ControlTemplate>
                      </Setter.Value>
                    </Setter>
                  </Style>

                  <!-- *********************************  ListBoxItem Style  ********************************* -->
                  <Style x:Key="ListBoxItemStyle" TargetType="ListBoxItem">
                    <Setter Property="Background" Value="{StaticResource TransparentBrush}" />
                    <Setter Property="Foreground" Value="{StaticResource ThemeForegroundBrush}" />
                    <Setter Property="TextOptions.TextHintingMode" Value="Animated" />
                    <Setter Property="Padding" Value="3" />
                    <Setter Property="Margin" Value="0" />
                    <Setter Property="MinHeight" Value="22" />
                    <Setter Property="HorizontalContentAlignment" Value="Stretch" />
                    <Setter Property="VerticalContentAlignment" Value="Stretch" />
                    <Setter Property="BorderThickness" Value="1" />
                    <Setter Property="Template">
                      <Setter.Value>
                        <ControlTemplate TargetType="ListBoxItem">
                          <Grid Background="{TemplateBinding Background}">
                            <VisualStateManager.VisualStateGroups>
                              <VisualStateGroup x:Name="CommonStates">
                                <VisualState x:Name="Normal">
                                  <Storyboard>
                                    <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetProperty="Foreground" Storyboard.TargetName="contentControl">
                                      <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource ThemeForegroundBrush}" />
                                    </ObjectAnimationUsingKeyFrames>
                                  </Storyboard>
                                </VisualState>
                                <VisualState x:Name="MouseOver">
                                  <Storyboard>
                                    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="Opacity" Storyboard.TargetName="hover" />
                                    <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetProperty="Foreground" Storyboard.TargetName="contentControl">
                                      <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource ThemeLightForegroundBrush}" />
                                    </ObjectAnimationUsingKeyFrames>
                                  </Storyboard>
                                </VisualState>
                                <VisualState x:Name="Disabled">
                                  <Storyboard>
                                    <DoubleAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="contentPresenter">
                                      <EasingDoubleKeyFrame KeyTime="0" Value="0.5" />
                                    </DoubleAnimationUsingKeyFrames>
                                  </Storyboard>
                                </VisualState>
                              </VisualStateGroup>
                              <VisualStateGroup x:Name="SelectionStates">
                                <VisualState x:Name="Unselected" />
                                <VisualState x:Name="Selected">
                                  <Storyboard>
                                    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="selected" />
                                    <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Visibility)" Storyboard.TargetName="SelectedContent">
                                      <DiscreteObjectKeyFrame KeyTime="0">
                                        <DiscreteObjectKeyFrame.Value>
                                          <Visibility>Visible</Visibility>
                                        </DiscreteObjectKeyFrame.Value>
                                      </DiscreteObjectKeyFrame>
                                    </ObjectAnimationUsingKeyFrames>
                                    <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Visibility)" Storyboard.TargetName="contentControl">
                                      <DiscreteObjectKeyFrame KeyTime="0">
                                        <DiscreteObjectKeyFrame.Value>
                                          <Visibility>Collapsed</Visibility>
                                        </DiscreteObjectKeyFrame.Value>
                                      </DiscreteObjectKeyFrame>
                                    </ObjectAnimationUsingKeyFrames>
                                  </Storyboard>
                                </VisualState>
                                <VisualState x:Name="SelectedUnfocused">
                                  <Storyboard>
                                    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="selected" />
                                    <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Visibility)" Storyboard.TargetName="SelectedContent">
                                      <DiscreteObjectKeyFrame KeyTime="0">
                                        <DiscreteObjectKeyFrame.Value>
                                          <Visibility>Visible</Visibility>
                                        </DiscreteObjectKeyFrame.Value>
                                      </DiscreteObjectKeyFrame>
                                    </ObjectAnimationUsingKeyFrames>
                                    <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Visibility)" Storyboard.TargetName="contentControl">
                                      <DiscreteObjectKeyFrame KeyTime="0">
                                        <DiscreteObjectKeyFrame.Value>
                                          <Visibility>Collapsed</Visibility>
                                        </DiscreteObjectKeyFrame.Value>
                                      </DiscreteObjectKeyFrame>
                                    </ObjectAnimationUsingKeyFrames>
                                  </Storyboard>
                                </VisualState>
                              </VisualStateGroup>
                              <VisualStateGroup x:Name="FocusStates">
                                <VisualState x:Name="Focused">
                                  <Storyboard>
                                    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="focused" />
                                  </Storyboard>
                                </VisualState>
                                <VisualState x:Name="Unfocused" />
                              </VisualStateGroup>
                              <VisualStateGroup x:Name="LayoutStates">
                                <VisualState x:Name="AfterLoaded" />
                                <VisualState x:Name="BeforeLoaded" />
                                <VisualState x:Name="BeforeUnloaded" />
                              </VisualStateGroup>
                            </VisualStateManager.VisualStateGroups>
                            <Rectangle x:Name="hover" Fill="{StaticResource ListBoxItemHoverBackgroundBrush}" IsHitTestVisible="False" Opacity="0" RadiusY="1" RadiusX="1" />
                            <Rectangle x:Name="selected" Fill="{StaticResource LIstBoxItemSelectedBackgroundBrush}" IsHitTestVisible="False" Opacity="0" RadiusY="1" RadiusX="1" Stroke="{StaticResource ListBoxItemFocusedBorderBrush}" />
                            <Rectangle x:Name="focused" IsHitTestVisible="False" Opacity="0" RadiusY="1" RadiusX="1" Stroke="{StaticResource ListBoxItemFocusedBorderBrush}" />
                            <ContentControl x:Name="contentControl" HorizontalContentAlignment="{TemplateBinding HorizontalContentAlignment}" VerticalContentAlignment="{TemplateBinding VerticalContentAlignment}">
                              <ContentPresenter x:Name="contentPresenter" Margin="5,3,5,0" />
                            </ContentControl>
                            <ContentControl x:Name="SelectedContent" Visibility="Collapsed" HorizontalContentAlignment="{TemplateBinding HorizontalContentAlignment}" VerticalContentAlignment="{TemplateBinding VerticalContentAlignment}">
                              <ContentPresenter x:Name="contentPresenter2" Margin="5,3,5,0" />
                            </ContentControl>
                          </Grid>
                        </ControlTemplate>
                      </Setter.Value>
                    </Setter>
                  </Style>
                </ResourceDictionary>
              </ResourceDictionary.MergedDictionaries>

              <!-- ******************************************************** WPF SPECIFIC INLINE-CONTROLS RESOURCES ***********************************************************
                ***********************************************************************************************************************************************************************    -->
              <!-- *********************************  ScrollBarButton Style  ********************************* -->
              <Style x:Key="ScrollBarButtonStyle" TargetType="{x:Type RepeatButton}">
                <Setter Property="OverridesDefaultStyle" Value="true" />
                <Setter Property="Focusable" Value="false" />
                <Setter Property="IsTabStop" Value="false" />
                <Setter Property="Template">
                  <Setter.Value>
                    <ControlTemplate TargetType="{x:Type RepeatButton}">
                      <Grid x:Name="grid1">
                        <VisualStateManager.VisualStateGroups>
                          <VisualStateGroup x:Name="CommonStates">
                            <VisualState x:Name="Normal" />
                            <VisualState x:Name="MouseOver">
                              <Storyboard>
                                <DoubleAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="hover">
                                  <EasingDoubleKeyFrame KeyTime="0" Value="1" />
                                </DoubleAnimationUsingKeyFrames>
                              </Storyboard>
                            </VisualState>
                            <VisualState x:Name="Pressed">
                              <Storyboard>
                                <DoubleAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="pressed">
                                  <EasingDoubleKeyFrame KeyTime="0" Value="1" />
                                </DoubleAnimationUsingKeyFrames>
                              </Storyboard>
                            </VisualState>
                            <VisualState x:Name="Disabled">
                              <Storyboard>
                                <DoubleAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="normal">
                                  <EasingDoubleKeyFrame KeyTime="0" Value="0.5" />
                                </DoubleAnimationUsingKeyFrames>
                              </Storyboard>
                            </VisualState>
                          </VisualStateGroup>
                        </VisualStateManager.VisualStateGroups>
                        <Rectangle Fill="Transparent" />
                        <Path x:Name="normal" Data="F1 M 541.537,173.589L 531.107,173.589L 536.322,167.49L 541.537,173.589 Z " Height="5" Stretch="Uniform" Width="8" Stroke="{StaticResource ArrowDarkBorderBrush}" Fill="{StaticResource ArrowBackgroundBrush}" />
                        <Path x:Name="hover" Data="F1 M 541.537,173.589L 531.107,173.589L 536.322,167.49L 541.537,173.589 Z " Height="5" Stretch="Uniform" Width="8" Fill="{StaticResource ButtonFocusedBorderBrush}" Opacity="0" Stroke="{StaticResource ArrowHoverBorderBrush}" />
                        <Path x:Name="pressed" Data="F1 M 541.537,173.589L 531.107,173.589L 536.322,167.49L 541.537,173.589 Z " Height="5" Stretch="Uniform" Width="8" Fill="{StaticResource ButtonHoverBorderBrush}" Opacity="0" Stroke="{StaticResource ArrowHoverBorderBrush}" />
                      </Grid>
                    </ControlTemplate>
                  </Setter.Value>
                </Setter>
              </Style>

              <!-- *********************************  ScrollBarPageButton Style  ********************************* -->
              <Style x:Key="ScrollBarPageButtonStyle" TargetType="{x:Type RepeatButton}">
                <Setter Property="OverridesDefaultStyle" Value="true" />
                <Setter Property="Background" Value="Transparent" />
                <Setter Property="Focusable" Value="false" />
                <Setter Property="IsTabStop" Value="false" />
                <Setter Property="Template">
                  <Setter.Value>
                    <ControlTemplate TargetType="{x:Type RepeatButton}">
                      <Rectangle Fill="{TemplateBinding Background}" Height="{TemplateBinding Height}" Width="{TemplateBinding Width}" />
                    </ControlTemplate>
                  </Setter.Value>
                </Setter>
              </Style>

              <!-- *********************************  Horizontal ScrollBarThumb Style  ********************************* -->
              <Style x:Key="HScrollBarThumbStyle" TargetType="{x:Type Thumb}">
                <Setter Property="OverridesDefaultStyle" Value="true" />
                <Setter Property="IsTabStop" Value="false" />
                <Setter Property="Template">
                  <Setter.Value>
                    <ControlTemplate TargetType="{x:Type Thumb}">
                      <Grid Margin="0">
                        <VisualStateManager.VisualStateGroups>
                          <VisualStateGroup x:Name="CommonStates">
                            <VisualState x:Name="Normal" />
                            <VisualState x:Name="MouseOver">
                              <Storyboard>
                                <DoubleAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="hover">
                                  <EasingDoubleKeyFrame KeyTime="0" Value="1" />
                                </DoubleAnimationUsingKeyFrames>
                              </Storyboard>
                            </VisualState>
                            <VisualState x:Name="Pressed">
                              <Storyboard>
                                <DoubleAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="pressed">
                                  <EasingDoubleKeyFrame KeyTime="0" Value="1" />
                                </DoubleAnimationUsingKeyFrames>
                              </Storyboard>
                            </VisualState>
                            <VisualState x:Name="Disabled">
                              <Storyboard>
                                <DoubleAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="normal">
                                  <EasingDoubleKeyFrame KeyTime="0" Value="0.5" />
                                </DoubleAnimationUsingKeyFrames>
                              </Storyboard>
                            </VisualState>
                          </VisualStateGroup>
                        </VisualStateManager.VisualStateGroups>
                        <Rectangle x:Name="normal" RadiusY="2" RadiusX="2" StrokeThickness="1" Margin="1" Fill="{StaticResource HScrollbarThumbBackgroundBrush}" Stroke="{StaticResource ArrowDarkBorderBrush}" />
                        <Rectangle x:Name="hover" RadiusY="2" RadiusX="2" StrokeThickness="1" Margin="1" Fill="{StaticResource HScrollbarThumbHoverBackgroundBrush}" Opacity="0" Stroke="{StaticResource ArrowHoverBorderBrush}" />
                        <Rectangle x:Name="pressed" Fill="{StaticResource HScrollbarThumbPressedBackgroundBrush}" RadiusY="2" RadiusX="2" StrokeThickness="1" Margin="1" Opacity="0" Stroke="{StaticResource ArrowHoverBorderBrush}" />
                      </Grid>
                    </ControlTemplate>
                  </Setter.Value>
                </Setter>
              </Style>

              <!-- *********************************  Vertical ScrollbarThumb Style  ********************************* -->
              <Style x:Key="VScrollBarThumbStyle" TargetType="{x:Type Thumb}">
                <Setter Property="OverridesDefaultStyle" Value="true" />
                <Setter Property="Stylus.IsPressAndHoldEnabled" Value="false" />
                <Setter Property="Template">
                  <Setter.Value>
                    <ControlTemplate TargetType="{x:Type Thumb}">
                      <Grid x:Name="grid" Height="Auto" Width="Auto">
                        <VisualStateManager.VisualStateGroups>
                          <VisualStateGroup x:Name="CommonStates">
                            <VisualState x:Name="Normal" />
                            <VisualState x:Name="MouseOver">
                              <Storyboard>
                                <DoubleAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="hover">
                                  <EasingDoubleKeyFrame KeyTime="0" Value="1" />
                                </DoubleAnimationUsingKeyFrames>
                              </Storyboard>
                            </VisualState>
                            <VisualState x:Name="Pressed">
                              <Storyboard>
                                <DoubleAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="pressed">
                                  <EasingDoubleKeyFrame KeyTime="0" Value="1" />
                                </DoubleAnimationUsingKeyFrames>
                              </Storyboard>
                            </VisualState>
                            <VisualState x:Name="Disabled">
                              <Storyboard>
                                <DoubleAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="normal">
                                  <EasingDoubleKeyFrame KeyTime="0" Value="0.4" />
                                </DoubleAnimationUsingKeyFrames>
                              </Storyboard>
                            </VisualState>
                          </VisualStateGroup>
                        </VisualStateManager.VisualStateGroups>
                        <Rectangle x:Name="normal" RadiusY="2" RadiusX="2" StrokeThickness="1" Margin="1" Stroke="{StaticResource ArrowDarkBorderBrush}" Fill="{StaticResource HScrollbarThumbBackgroundBrush}">

                        </Rectangle>
                        <Rectangle x:Name="hover" RadiusY="2" RadiusX="2" StrokeThickness="1" Margin="1" Fill="{StaticResource VScrollbarThumbHoverBackgroundBrush}" Opacity="0" Stroke="{StaticResource ArrowHoverBorderBrush}" />
                        <Rectangle x:Name="pressed" Fill="{StaticResource VScrollbarThumbPressedBackgroundBrush}" RadiusY="2" RadiusX="2" StrokeThickness="1" Margin="1" Opacity="0" Stroke="{StaticResource ArrowHoverBorderBrush}" />
                      </Grid>
                    </ControlTemplate>
                  </Setter.Value>
                </Setter>
              </Style>

              <!-- *********************************  ScrollBar Style  ********************************* -->
              <Style x:Key="ScrollbarStyle" TargetType="{x:Type ScrollBar}">
                <Setter Property="Stylus.IsPressAndHoldEnabled" Value="false" />
                <Setter Property="Stylus.IsFlicksEnabled" Value="false" />
                <Setter Property="Width" Value="20" />
                <Setter Property="MinWidth" Value="20" />
                <Setter Property="Template">
                  <Setter.Value>
                    <ControlTemplate TargetType="{x:Type ScrollBar}">
                      <Grid x:Name="Bg" SnapsToDevicePixels="true">
                        <Grid.RowDefinitions>
                          <RowDefinition MaxHeight="{DynamicResource {x:Static SystemParameters.VerticalScrollBarButtonHeightKey}}" />
                          <RowDefinition Height="0.00001*" />
                          <RowDefinition MaxHeight="{DynamicResource {x:Static SystemParameters.VerticalScrollBarButtonHeightKey}}" />
                        </Grid.RowDefinitions>
                        <VisualStateManager.VisualStateGroups>
                          <VisualStateGroup x:Name="CommonStates">
                            <VisualStateGroup.Transitions>
                              <VisualTransition GeneratedDuration="0:0:0.3" />
                            </VisualStateGroup.Transitions>
                            <VisualState x:Name="Normal" />
                            <VisualState x:Name="MouseOver" />
                            <VisualState x:Name="Disabled">
                              <Storyboard>
                                <DoubleAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="repeatButton">
                                  <EasingDoubleKeyFrame KeyTime="0" Value="0.6" />
                                </DoubleAnimationUsingKeyFrames>
                                <DoubleAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="repeatButton1">
                                  <EasingDoubleKeyFrame KeyTime="0" Value="0.6" />
                                </DoubleAnimationUsingKeyFrames>
                                <DoubleAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="thumb">
                                  <EasingDoubleKeyFrame KeyTime="0" Value="0" />
                                </DoubleAnimationUsingKeyFrames>
                              </Storyboard>
                            </VisualState>
                          </VisualStateGroup>
                        </VisualStateManager.VisualStateGroups>
                        <Rectangle Grid.RowSpan="3" StrokeThickness="1" Fill="{StaticResource VScrollbarBackgroundBrush}" Stroke="{StaticResource ScrollbarBorderBrush}" Margin="0" />
                        <RepeatButton x:Name="repeatButton" Margin="1" Command="{x:Static ScrollBar.LineUpCommand}" Style="{StaticResource ScrollBarButtonStyle}" />
                        <Track x:Name="PART_Track" IsDirectionReversed="true" Grid.Row="1">
                          <Track.DecreaseRepeatButton>
                            <RepeatButton Command="{x:Static ScrollBar.PageUpCommand}" Style="{StaticResource ScrollBarPageButtonStyle}" />
                          </Track.DecreaseRepeatButton>
                          <Track.IncreaseRepeatButton>
                            <RepeatButton Command="{x:Static ScrollBar.PageDownCommand}" Style="{StaticResource ScrollBarPageButtonStyle}" />
                          </Track.IncreaseRepeatButton>
                          <Track.Thumb>
                            <Thumb x:Name="thumb" Style="{StaticResource VScrollBarThumbStyle}" Margin="5,0" />
                          </Track.Thumb>
                        </Track>
                        <RepeatButton x:Name="repeatButton1" Command="{x:Static ScrollBar.LineDownCommand}" Grid.Row="2" Style="{StaticResource ScrollBarButtonStyle}" Margin="1" RenderTransformOrigin="0.5,0.5">
                          <RepeatButton.RenderTransform>
                            <TransformGroup>
                              <ScaleTransform />
                              <SkewTransform />
                              <RotateTransform Angle="180" />
                              <TranslateTransform />
                            </TransformGroup>
                          </RepeatButton.RenderTransform>
                          <Path x:Name="smallIncreaseGlyph" Width="9" Height="5" Data="M 4,5 C4,5 4,4 4,4 4,4 3,4 3,4 3,4 3,3 3,3 3,3 2,3 2,3 2,3 2,2 2,2 2,2 1,2 1,2 1,2 1,1 1,1 1,1 0,1 0,1 0,1 0,0 0,0 0,0 9,0 9,0 9,0 9,1 9,1 9,1 8,1 8,1 8,1 8,2 8,2 8,2 7,2 7,2 7,2 7,3 7,3 7,3 6,3 6,3 6,3 6,4 6,4 6,4 5,4 5,4 5,4 5,5 5,5 5,5 4,5 4,5 z" IsHitTestVisible="False" HorizontalAlignment="Center" VerticalAlignment="Center" Fill="Lime">
                          </Path>
                        </RepeatButton>
                      </Grid>
                      <ControlTemplate.Triggers>
                        <Trigger Property="IsEnabled" Value="false">
                          <Setter Property="Background" TargetName="Bg" Value="{StaticResource DisabledBackgroundBrush}" />
                        </Trigger>
                      </ControlTemplate.Triggers>
                    </ControlTemplate>
                  </Setter.Value>
                </Setter>
                <Style.Triggers>
                  <Trigger Property="Orientation" Value="Horizontal">
                    <Setter Property="Width" Value="Auto" />
                    <Setter Property="MinWidth" Value="0" />
                    <Setter Property="Height" Value="20" />
                    <Setter Property="MinHeight" Value="20" />
                    <Setter Property="Template">
                      <Setter.Value>
                        <ControlTemplate TargetType="{x:Type ScrollBar}">
                          <Grid x:Name="Bg" SnapsToDevicePixels="true">
                            <Grid.ColumnDefinitions>
                              <ColumnDefinition MaxWidth="{DynamicResource {x:Static SystemParameters.HorizontalScrollBarButtonWidthKey}}" />
                              <ColumnDefinition Width="0.00001*" />
                              <ColumnDefinition MaxWidth="{DynamicResource {x:Static SystemParameters.HorizontalScrollBarButtonWidthKey}}" />
                            </Grid.ColumnDefinitions>
                            <VisualStateManager.VisualStateGroups>
                              <VisualStateGroup x:Name="CommonStates">
                                <VisualStateGroup.Transitions>
                                  <VisualTransition GeneratedDuration="0:0:0.3" />
                                </VisualStateGroup.Transitions>
                                <VisualState x:Name="Normal" />
                                <VisualState x:Name="MouseOver">
                                  <Storyboard>
                                    <DoubleAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="repeatButton">
                                      <EasingDoubleKeyFrame KeyTime="0" Value="1" />
                                    </DoubleAnimationUsingKeyFrames>
                                    <DoubleAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="repeatButton1">
                                      <EasingDoubleKeyFrame KeyTime="0" Value="1" />
                                    </DoubleAnimationUsingKeyFrames>
                                  </Storyboard>
                                </VisualState>
                                <VisualState x:Name="Disabled" />
                              </VisualStateGroup>
                            </VisualStateManager.VisualStateGroups>
                            <Rectangle Grid.ColumnSpan="5" StrokeThickness="1" Fill="{StaticResource HScrollbarBackgroundBrush}" Stroke="{StaticResource ScrollbarBorderBrush}" />
                            <RepeatButton x:Name="repeatButton" Command="{x:Static ScrollBar.LineLeftCommand}" Style="{StaticResource ScrollBarButtonStyle}" Opacity="1" RenderTransformOrigin="0.5,0.5">
                              <RepeatButton.RenderTransform>
                                <TransformGroup>
                                  <ScaleTransform />
                                  <SkewTransform />
                                  <RotateTransform Angle="-90" />
                                  <TranslateTransform />
                                </TransformGroup>
                              </RepeatButton.RenderTransform>
                              <Path x:Name="horizontalSmallDecreaseGlyph" Width="5" Height="9" Data="M 0,4 C0,4 1,4 1,4 1,4 1,3 1,3 1,3 2,3 2,3 2,3 2,2 2,2 2,2 3,2 3,2 3,2 3,1 3,1 3,1 4,1 4,1 4,1 4,0 4,0 4,0 5,0 5,0 5,0 5,9 5,9 5,9 4,9 4,9 4,9 4,8 4,8 4,8 3,8 3,8 3,8 3,7 3,7 3,7 2,7 2,7 2,7 2,6 2,6 2,6 1,6 1,6 1,6 1,5 1,5 1,5 0,5 0,5 0,5 0,4 0,4 z" IsHitTestVisible="False" HorizontalAlignment="Center" Margin="0" d:LayoutOverrides="Width" VerticalAlignment="Center" Fill="Magenta">
                              </Path>
                            </RepeatButton>
                            <Track x:Name="PART_Track" Grid.Column="1">
                              <Track.DecreaseRepeatButton>
                                <RepeatButton Command="{x:Static ScrollBar.PageLeftCommand}" Style="{StaticResource ScrollBarPageButtonStyle}" />
                              </Track.DecreaseRepeatButton>
                              <Track.IncreaseRepeatButton>
                                <RepeatButton Command="{x:Static ScrollBar.PageRightCommand}" Style="{StaticResource ScrollBarPageButtonStyle}" />
                              </Track.IncreaseRepeatButton>
                              <Track.Thumb>
                                <Thumb Style="{StaticResource HScrollBarThumbStyle}" Margin="0,5" />
                              </Track.Thumb>
                            </Track>
                            <RepeatButton x:Name="repeatButton1" Grid.Column="2" Command="{x:Static ScrollBar.LineRightCommand}" Style="{StaticResource ScrollBarButtonStyle}" Opacity="1" RenderTransformOrigin="0.5,0.5">
                              <RepeatButton.RenderTransform>
                                <TransformGroup>
                                  <ScaleTransform />
                                  <SkewTransform />
                                  <RotateTransform Angle="90" />
                                  <TranslateTransform />
                                </TransformGroup>
                              </RepeatButton.RenderTransform>
                              <Path x:Name="horizontalSmallIncreaseGlyph" Width="5" Height="9" Data="M 5,4 C5,4 4,4 4,4 4,4 4,3 4,3 4,3 3,3 3,3 3,3 3,2 3,2 3,2 2,2 2,2 2,2 2,1 2,1 2,1 1,1 1,1 1,1 1,0 1,0 1,0 0,0 0,0 0,0 0,9 0,9 0,9 1,9 1,9 1,9 1,8 1,8 1,8 2,8 2,8 2,8 2,7 2,7 2,7 3,7 3,7 3,7 3,6 3,6 3,6 4,6 4,6 4,6 4,5 4,5 4,5 5,5 5,5 5,5 5,4 5,4 z" IsHitTestVisible="False" HorizontalAlignment="Center" Margin="0" d:LayoutOverrides="Width" VerticalAlignment="Center" Fill="Cyan">
                              </Path>
                            </RepeatButton>
                          </Grid>
                          <ControlTemplate.Triggers>
                            <Trigger Property="IsEnabled" Value="false">
                              <Setter Property="Background" TargetName="Bg" Value="{StaticResource DisabledBackgroundBrush}" />
                            </Trigger>
                          </ControlTemplate.Triggers>
                        </ControlTemplate>
                      </Setter.Value>
                    </Setter>
                  </Trigger>
                </Style.Triggers>
              </Style>

              <!-- *********************************  ScrollViewer Style ********************************* -->
              <Style x:Key="ScrollViewerStyle" TargetType="{x:Type ScrollViewer}">
                <Setter Property="Foreground" Value="{StaticResource ThemeForegroundBrush}" />
                <Setter Property="HorizontalContentAlignment" Value="Left" />
                <Setter Property="VerticalContentAlignment" Value="Top" />
                <Setter Property="VerticalScrollBarVisibility" Value="Auto" />
                <Setter Property="Padding" Value="0" />
                <Setter Property="BorderThickness" Value="1" />
                <Setter Property="Template">
                  <Setter.Value>
                    <ControlTemplate TargetType="{x:Type ScrollViewer}">
                      <Grid x:Name="Grid">
                        <Grid.ColumnDefinitions>
                          <ColumnDefinition Width="*" />
                          <ColumnDefinition Width="Auto" />
                        </Grid.ColumnDefinitions>
                        <Grid.RowDefinitions>
                          <RowDefinition Height="*" />
                          <RowDefinition Height="Auto" />
                        </Grid.RowDefinitions>
                        <Rectangle x:Name="Corner" Grid.Column="1" Fill="{StaticResource ScrollviewerCornerBackgroundBrush}" Grid.Row="1" Opacity="0.5" />
                        <ScrollContentPresenter x:Name="PART_ScrollContentPresenter" CanContentScroll="{TemplateBinding CanContentScroll}" CanHorizontallyScroll="False" CanVerticallyScroll="False" ContentTemplate="{TemplateBinding ContentTemplate}" Content="{TemplateBinding Content}" Grid.Column="0" Margin="{TemplateBinding Padding}" Grid.Row="0" />
                        <ScrollBar x:Name="PART_VerticalScrollBar" AutomationProperties.AutomationId="VerticalScrollBar" Cursor="Arrow" Grid.Column="1" Maximum="{TemplateBinding ScrollableHeight}" Minimum="0" Grid.Row="0" Visibility="{TemplateBinding ComputedVerticalScrollBarVisibility}" Value="{Binding VerticalOffset, Mode=OneWay, RelativeSource={RelativeSource TemplatedParent}}" ViewportSize="{TemplateBinding ViewportHeight}" Style="{StaticResource ScrollbarStyle}" />
                        <ScrollBar x:Name="PART_HorizontalScrollBar" AutomationProperties.AutomationId="HorizontalScrollBar" Cursor="Arrow" Grid.Column="0" Maximum="{TemplateBinding ScrollableWidth}" Minimum="0" Orientation="Horizontal" Grid.Row="1" Visibility="{TemplateBinding ComputedHorizontalScrollBarVisibility}" Value="{Binding HorizontalOffset, Mode=OneWay, RelativeSource={RelativeSource TemplatedParent}}" ViewportSize="{TemplateBinding ViewportWidth}" Style="{StaticResource ScrollbarStyle}" />
                      </Grid>
                    </ControlTemplate>
                  </Setter.Value>
                </Setter>
              </Style>


              <!-- *********************************  ComboBoxEditableTextBox Style  ********************************* -->
              <Style x:Key="ComboBoxEditableTextBoxStyle" TargetType="{x:Type TextBox}">
                <Setter Property="Foreground" Value="{StaticResource ThemeForegroundBrush}" />
                <Setter Property="FontSize" Value="12" />
                <Setter Property="FontFamily" Value="Segoe UI" />
                <Setter Property="AllowDrop" Value="true" />
                <Setter Property="MinHeight" Value="24" />
                <Setter Property="Padding" Value="5,3" />
                <Setter Property="FocusVisualStyle" Value="{x:Null}" />
                <Setter Property="Template">
                  <Setter.Value>
                    <ControlTemplate TargetType="{x:Type TextBox}">
                      <ScrollViewer Style="{StaticResource ScrollViewerStyle}" x:Name="PART_ContentHost" Background="Transparent" Focusable="false" HorizontalScrollBarVisibility="Hidden" VerticalScrollBarVisibility="Hidden">
                        <VisualStateManager.VisualStateGroups>
                          <VisualStateGroup x:Name="CommonStates">
                            <VisualState x:Name="Normal" />
                            <VisualState x:Name="Disabled">
                              <Storyboard>
                                <DoubleAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="PART_ContentHost">
                                  <EasingDoubleKeyFrame KeyTime="0" Value="0.3" />
                                </DoubleAnimationUsingKeyFrames>
                              </Storyboard>
                            </VisualState>
                            <VisualState x:Name="ReadOnly" />
                            <VisualState x:Name="MouseOver" />
                          </VisualStateGroup>
                        </VisualStateManager.VisualStateGroups>
                      </ScrollViewer>
                    </ControlTemplate>
                  </Setter.Value>
                </Setter>
              </Style>

              <!-- *********************************  TextBoxValidationToolTipTemplate  ********************************* -->
              <ControlTemplate x:Key="TextBoxValidationToolTipTemplate">
                <Grid x:Name="Root" Margin="5,0" RenderTransformOrigin="0,0" Opacity="0">
                  <Grid.RenderTransform>
                    <TranslateTransform x:Name="xform" X="-25" />
                  </Grid.RenderTransform>
                  <VisualStateManager.VisualStateGroups>
                    <VisualStateGroup Name="OpenStates">
                      <VisualStateGroup.Transitions>
                        <VisualTransition GeneratedDuration="0" />
                        <VisualTransition To="Open" GeneratedDuration="0:0:0.2">
                          <Storyboard>
                            <DoubleAnimation Storyboard.TargetName="xform" Storyboard.TargetProperty="X" To="0" Duration="0:0:0.2">
                              <DoubleAnimation.EasingFunction>
                                <BackEase Amplitude=".3" EasingMode="EaseOut" />
                              </DoubleAnimation.EasingFunction>
                            </DoubleAnimation>
                            <DoubleAnimation Storyboard.TargetName="Root" Storyboard.TargetProperty="Opacity" To="1" Duration="0:0:0.2" />
                          </Storyboard>
                        </VisualTransition>
                      </VisualStateGroup.Transitions>
                      <VisualState x:Name="Closed">
                        <Storyboard>
                          <DoubleAnimation Storyboard.TargetName="Root" Storyboard.TargetProperty="Opacity" To="0" Duration="0" />
                        </Storyboard>
                      </VisualState>
                      <VisualState x:Name="Open">
                        <Storyboard>
                          <DoubleAnimation Storyboard.TargetName="xform" Storyboard.TargetProperty="X" To="0" Duration="0" />
                          <DoubleAnimation Storyboard.TargetName="Root" Storyboard.TargetProperty="Opacity" To="1" Duration="0" />
                        </Storyboard>
                      </VisualState>
                    </VisualStateGroup>
                  </VisualStateManager.VisualStateGroups>
                  <Border Margin="3,3,-3,-3" Background="{StaticResource ValidationToolTipBackgroundFill}" CornerRadius="4" />
                  <Border Margin="2,2,-2,-2" Background="{StaticResource ValidationToolTipBackgroundFill}" CornerRadius="3" />
                  <Border Margin="1,1,-1,-1" Background="{StaticResource ValidationToolTipBackgroundFill}" CornerRadius="2" />
                  <Border Background="{StaticResource InvalidFocusedBrush}" CornerRadius="2" />
                  <Border CornerRadius="2">
                    <TextBlock UseLayoutRounding="false" Foreground="{StaticResource ThemeLightForegroundBrush}" Margin="8,4,8,4" MaxWidth="250" TextWrapping="Wrap" Text="{Binding (Validation.Errors).CurrentItem.ErrorContent}" />
                  </Border>
                </Grid>
              </ControlTemplate>

              <!-- *********************************  ComboBoxEditable Template  ********************************* -->
              <ControlTemplate x:Key="ComboBoxEditableTemplate" TargetType="{x:Type ComboBox}">
                <Grid x:Name="MainGrid" SnapsToDevicePixels="true">
                  <VisualStateManager.VisualStateGroups>
                    <VisualStateGroup x:Name="CommonStates">
                      <VisualState x:Name="Normal" />
                      <VisualState x:Name="MouseOver">
                        <Storyboard>
                          <DoubleAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="DropDownhover">
                            <EasingDoubleKeyFrame KeyTime="0" Value="1" />
                          </DoubleAnimationUsingKeyFrames>
                        </Storyboard>
                      </VisualState>
                      <VisualState x:Name="Disabled" />
                    </VisualStateGroup>
                    <VisualStateGroup x:Name="FocusStates">
                      <VisualState x:Name="Unfocused" />
                      <VisualState x:Name="Focused" />
                      <VisualState x:Name="FocusedDropDown" />
                    </VisualStateGroup>
                  </VisualStateManager.VisualStateGroups>
                  <Border x:Name="ContentPresenterBorder"  Background="{StaticResource ThemeLightForegroundBrush}" CornerRadius="3">
                    <Grid>
                      <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*" />
                        <ColumnDefinition Width="22" />
                      </Grid.ColumnDefinitions>
                      <Rectangle x:Name="DropDownNormal" Fill="{TemplateBinding Background}" RadiusY="3" RadiusX="3" Stroke="{TemplateBinding BorderBrush}" Grid.ColumnSpan="2" StrokeThickness="{TemplateBinding BorderThickness}" />
                      <Rectangle x:Name="DropDownhover" RadiusY="3" RadiusX="3" Stroke="{StaticResource ComboBoxHoverBorderBrush}" StrokeThickness="1" Margin="0" Opacity="0" Grid.ColumnSpan="2" />
                      <Rectangle x:Name="DropDownBackground" Fill="{StaticResource ComboBoxInnerShadowBackgroundBrush}" Height="22" RadiusY="3" RadiusX="3" Grid.ColumnSpan="2" VerticalAlignment="Top" IsHitTestVisible="False"/>
                      <ToggleButton x:Name="DropDownToggle" BorderThickness="{TemplateBinding BorderThickness}" Style="{StaticResource ComboToggleStyle}" Height="{TemplateBinding Height}" Grid.Column="1" HorizontalAlignment="Stretch" IsChecked="{Binding IsDropDownOpen, Mode=TwoWay, RelativeSource={RelativeSource TemplatedParent}}" VerticalAlignment="Stretch" />
                      <Rectangle x:Name="DropDownDisabled" Fill="{StaticResource ToggleButtonDisabledBackgroundBrush}" RadiusX="3" RadiusY="3" IsHitTestVisible="false" d:LayoutOverrides="GridBox" Grid.Column="1" Opacity="0" />
                     <TextBox x:Name="PART_EditableTextBox" Grid.Column="0" Margin="0,0,0,-1" HorizontalContentAlignment="Left" IsReadOnly="{Binding IsReadOnly, RelativeSource={RelativeSource TemplatedParent}}" Style="{StaticResource ComboBoxEditableTextBoxStyle}" />
                      <TextBlock IsHitTestVisible="False" Text=" " Margin="5,2,5,0" Visibility="Collapsed" />
                    </Grid>
                  </Border>
                  <Popup x:Name="PART_Popup" Margin="1" AllowsTransparency="true" IsOpen="{Binding IsDropDownOpen, RelativeSource={RelativeSource TemplatedParent}}" Placement="Bottom" PopupAnimation="{DynamicResource {x:Static SystemParameters.ComboBoxPopupAnimationKey}}" Grid.ColumnSpan="2">
                    <Border x:Name="DropDownBorder" HorizontalAlignment="Stretch" BorderBrush="{StaticResource PopupBorderBrush}" Background="{StaticResource PopupBackgroundBrush}" BorderThickness="1" MaxHeight="{TemplateBinding MaxDropDownHeight}" MinWidth="{Binding ActualWidth, ElementName=MainGrid}">
                      <Border.Effect>
                        <DropShadowEffect BlurRadius="15" Direction="270" ShadowDepth="1" Opacity="0.26" Color="{StaticResource Color_000}" />
                      </Border.Effect>
                      <ScrollViewer CanContentScroll="true" BorderThickness="0" Padding="1" Style="{StaticResource ScrollViewerStyle}" Margin="0">
                        <ItemsPresenter SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}" KeyboardNavigation.DirectionalNavigation="Contained" />
                      </ScrollViewer>
                    </Border>
                  </Popup>
                </Grid>
                <ControlTemplate.Triggers>
                  <Trigger Property="HasItems" Value="false">
                    <Setter Property="Height" TargetName="DropDownBorder" Value="95" />
                  </Trigger>
                </ControlTemplate.Triggers>
              </ControlTemplate>

              <!-- *********************************  ComboBox Style  ********************************* -->
              <Style x:Key="ComboBoxStyle" TargetType="ComboBox">
                <Setter Property="ItemContainerStyle" Value="{StaticResource ComboBoxItemStyle}" />
                <Setter Property="Padding" Value="5,3,20,3" />
                <Setter Property="MinHeight" Value="24" />
                <Setter Property="Foreground" Value="{StaticResource ThemeForegroundBrush}" />
                <Setter Property="Background" Value="{StaticResource ComboBoxBackgroundBrush}" />
                <Setter Property="BorderBrush" Value="{StaticResource ComboBoxBorderBrush}" />
                <Setter Property="HorizontalContentAlignment" Value="Left" />
                <Setter Property="BorderThickness" Value="1" />
                <Setter Property="Cursor" Value="Hand" />
                <Setter Property="ScrollViewer.HorizontalScrollBarVisibility" Value="Auto" />
                <Setter Property="ScrollViewer.VerticalScrollBarVisibility" Value="Auto" />
                <Setter Property="Template">
                  <Setter.Value>
                    <ControlTemplate TargetType="ComboBox">
                      <Grid x:Name="MainGrid" SnapsToDevicePixels="true">
                        <VisualStateManager.VisualStateGroups>
                          <VisualStateGroup x:Name="CommonStates">
                            <VisualState x:Name="Normal" />
                            <VisualState x:Name="MouseOver">
                              <Storyboard>
                                <DoubleAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="DropDownhover">
                                  <EasingDoubleKeyFrame KeyTime="0" Value="1" />
                                </DoubleAnimationUsingKeyFrames>
                              </Storyboard>
                            </VisualState>
                            <VisualState x:Name="Disabled">
                              <Storyboard>
                                <DoubleAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="DropDownDisabled">
                                  <EasingDoubleKeyFrame KeyTime="0" Value="0.3" />
                                </DoubleAnimationUsingKeyFrames>
                                <DoubleAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="ContentPresenter">
                                  <EasingDoubleKeyFrame KeyTime="0" Value="0.5" />
                                </DoubleAnimationUsingKeyFrames>
                              </Storyboard>
                            </VisualState>
                          </VisualStateGroup>
                          <VisualStateGroup x:Name="FocusStates">
                            <VisualState x:Name="Unfocused" />
                            <VisualState x:Name="Focused" />
                            <VisualState x:Name="FocusedDropDown">
                              <Storyboard>
                                <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="(UIElement.Visibility)" Storyboard.TargetName="DropDownBorder">
                                  <DiscreteObjectKeyFrame KeyTime="0" Value="{x:Static Visibility.Visible}" />
                                </ObjectAnimationUsingKeyFrames>
                              </Storyboard>
                            </VisualState>
                          </VisualStateGroup>
                          <VisualStateGroup x:Name="EmptyState">
                            <VisualState x:Name="Empty">
                              <Storyboard>
                                <ObjectAnimationUsingKeyFrames BeginTime="00:00:00" Storyboard.TargetName="itemText" Storyboard.TargetProperty="(UIElement.Visibility)">
                                  <DiscreteObjectKeyFrame KeyTime="00:00:00">
                                    <DiscreteObjectKeyFrame.Value>
                                      <Visibility>Visible</Visibility>
                                    </DiscreteObjectKeyFrame.Value>
                                  </DiscreteObjectKeyFrame>
                                </ObjectAnimationUsingKeyFrames>
                              </Storyboard>
                            </VisualState>
                            <VisualState x:Name="Selected">
                              <Storyboard>
                                <ObjectAnimationUsingKeyFrames BeginTime="00:00:00" Storyboard.TargetName="itemText" Storyboard.TargetProperty="(UIElement.Visibility)">
                                  <DiscreteObjectKeyFrame KeyTime="00:00:00">
                                    <DiscreteObjectKeyFrame.Value>
                                      <Visibility>Collapsed</Visibility>
                                    </DiscreteObjectKeyFrame.Value>
                                  </DiscreteObjectKeyFrame>
                                </ObjectAnimationUsingKeyFrames>
                              </Storyboard>
                            </VisualState>
                          </VisualStateGroup>
                        </VisualStateManager.VisualStateGroups>
                        <Border x:Name="ContentPresenterBorder">
                          <Grid>
                            <Grid.ColumnDefinitions>
                              <ColumnDefinition Width="*" />
                              <ColumnDefinition Width="22" />
                            </Grid.ColumnDefinitions>
                            <Rectangle x:Name="DropDownNormal" Fill="{TemplateBinding Background}" RadiusY="3" RadiusX="3" Stroke="{TemplateBinding BorderBrush}" Grid.ColumnSpan="2" StrokeThickness="{TemplateBinding BorderThickness}" />
                            <Rectangle x:Name="DropDownhover" RadiusY="3" RadiusX="3" Stroke="{StaticResource ComboBoxHoverBorderBrush}" StrokeThickness="1" Margin="0" Opacity="0" Grid.ColumnSpan="2" />
                            <Rectangle x:Name="DropDownBackground" Fill="{StaticResource ComboBoxInnerShadowBackgroundBrush}" Height="22" RadiusY="3" RadiusX="3" Grid.ColumnSpan="2" VerticalAlignment="Top" IsHitTestVisible="False" />
                            <ToggleButton x:Name="DropDownToggle" BorderThickness="{TemplateBinding BorderThickness}" Style="{StaticResource ComboToggleStyle}" Height="{TemplateBinding Height}" Grid.ColumnSpan="2" HorizontalAlignment="Stretch" IsChecked="{Binding IsDropDownOpen, Mode=TwoWay, RelativeSource={RelativeSource TemplatedParent}}" VerticalAlignment="Stretch" />
                            <Rectangle x:Name="DropDownDisabled" Fill="{StaticResource ToggleButtonDisabledBackgroundBrush}" RadiusX="3" RadiusY="3" IsHitTestVisible="false" d:LayoutOverrides="GridBox" Grid.Column="1" Opacity="0" />
                            <ContentPresenter x:Name="ContentPresenter" HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" Margin="{TemplateBinding Padding}" VerticalAlignment="{TemplateBinding VerticalContentAlignment}" IsHitTestVisible="false" SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}" Content="{TemplateBinding SelectionBoxItem}" ContentTemplate="{TemplateBinding SelectionBoxItemTemplate}" ContentStringFormat="{TemplateBinding SelectionBoxItemStringFormat}" ContentTemplateSelector="{TemplateBinding ItemTemplateSelector}" />
                            <TextBlock IsHitTestVisible="False" Text=" " Margin="5,2,5,0" Visibility="Collapsed" />
                          </Grid>
                        </Border>
                        <Popup x:Name="PART_Popup" Margin="1" AllowsTransparency="true" IsOpen="{Binding IsDropDownOpen, RelativeSource={RelativeSource TemplatedParent}}" Placement="Bottom" PopupAnimation="{DynamicResource {x:Static SystemParameters.ComboBoxPopupAnimationKey}}" Grid.ColumnSpan="2">
                          <Border x:Name="DropDownBorder" HorizontalAlignment="Stretch" BorderBrush="{StaticResource PopupBorderBrush}" Background="{StaticResource PopupBackgroundBrush}" BorderThickness="1" MaxHeight="{TemplateBinding MaxDropDownHeight}" MinWidth="{Binding ActualWidth, ElementName=MainGrid}">
                            <Border.Effect>
                              <DropShadowEffect BlurRadius="15" Direction="270" ShadowDepth="1" Opacity="0.26" Color="{StaticResource Color_000}" />
                            </Border.Effect>
                            <ScrollViewer CanContentScroll="true" BorderThickness="0" Padding="1" Style="{StaticResource ScrollViewerStyle}" Margin="0">
                              <ItemsPresenter SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}" KeyboardNavigation.DirectionalNavigation="Contained" />
                            </ScrollViewer>
                          </Border>
                        </Popup>
                      </Grid>
                    </ControlTemplate>
                  </Setter.Value>
                </Setter>
                <Style.Triggers>
                  <Trigger Property="IsEditable" Value="true">
                    <Setter Property="IsTabStop" Value="false" />
                    <Setter Property="Template" Value="{StaticResource ComboBoxEditableTemplate}" />
                  </Trigger>
                </Style.Triggers>
              </Style>

              <!-- ********************************** TextBox Style **********************************-->
              <Style x:Key="TextBoxStyle" TargetType="{x:Type TextBox}">
                <Setter Property="Background" Value="{StaticResource TextBoxBackgroundBrush}" />
                <Setter Property="BorderBrush" Value="{StaticResource TextBoxBorderBrush}" />
                <Setter Property="Foreground" Value="{StaticResource ThemeForegroundBrush}" />
                <Setter Property="Padding" Value="2" />
                <Setter Property="BorderThickness" Value="1" />
                <Setter Property="Padding" Value="4,2" />
                <Setter Property="MinHeight" Value="24" />
                <Setter Property="AllowDrop" Value="true" />
                <Setter Property="FocusVisualStyle" Value="{x:Null}" />
                <Setter Property="ScrollViewer.PanningMode" Value="VerticalFirst" />
                <Setter Property="Stylus.IsFlicksEnabled" Value="False" />
                <Setter Property="FlowDirection" Value="LeftToRight" />
                <Setter Property="Validation.ErrorTemplate" Value="{StaticResource TextBoxValidationToolTipTemplate}"/>
	            <Setter Property="SelectionBrush" Value="{StaticResource TextBoxFocusedBrush}" />
                <Setter Property="SelectionOpacity" Value="0.4" />
                <Setter Property="Template">
                  <Setter.Value>
                    <ControlTemplate>
                                <Grid SnapsToDevicePixels="True">
                        <VisualStateManager.VisualStateGroups>
                          <VisualStateGroup x:Name="ValidationStates">
                            <VisualState x:Name="Valid" />
                            <VisualState x:Name="InvalidUnfocused">
                              <Storyboard>
                                                    <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Visibility" Storyboard.TargetName="ValidationErrorElement">
                                                        <DiscreteObjectKeyFrame KeyTime="0">
                                                            <DiscreteObjectKeyFrame.Value>
                                                                <Visibility>Visible</Visibility>
                                                            </DiscreteObjectKeyFrame.Value>
                                                        </DiscreteObjectKeyFrame>
                                                    </ObjectAnimationUsingKeyFrames>
                              </Storyboard>
                            </VisualState>
                            <VisualState x:Name="InvalidFocused">
                              <Storyboard>
                                                    <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Visibility" Storyboard.TargetName="ValidationErrorElement">
                                                        <DiscreteObjectKeyFrame KeyTime="0">
                                                            <DiscreteObjectKeyFrame.Value>
                                                                <Visibility>Visible</Visibility>
                                                            </DiscreteObjectKeyFrame.Value>
                                                        </DiscreteObjectKeyFrame>
                                                    </ObjectAnimationUsingKeyFrames>
                                <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="IsOpen" Storyboard.TargetName="validationTooltip">
                                  <DiscreteObjectKeyFrame KeyTime="0">
                                    <DiscreteObjectKeyFrame.Value>
                                      <System:Boolean>True</System:Boolean>
                                    </DiscreteObjectKeyFrame.Value>
                                  </DiscreteObjectKeyFrame>
                                </ObjectAnimationUsingKeyFrames>
                              </Storyboard>
                            </VisualState>
                          </VisualStateGroup>
                        </VisualStateManager.VisualStateGroups>
                        <Border Background="{TemplateBinding Background}" CornerRadius="3" />
                        <Border Background="{StaticResource TextBoxShadowBackgroundBrush}" Height="22" CornerRadius="3" VerticalAlignment="Top" IsHitTestVisible="False" />
                        <Border x:Name="Bd" BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}" CornerRadius="3">
                          <ScrollViewer x:Name="PART_ContentHost" />
                        </Border>
                        <Rectangle x:Name="innerShadow" Width="20" IsHitTestVisible="False" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="1,1,0,1" RadiusX="2" RadiusY="2" Fill="{StaticResource TextBoxInnerShadowBackgroundBrush}" />
                                    <Border x:Name="ValidationErrorElement" CornerRadius="3" BorderBrush="{StaticResource InvalidUnfocusedBrush}" BorderThickness="1" Margin="0" Visibility="Collapsed" >
                          <ToolTipService.ToolTip>
                            <ToolTip x:Name="validationTooltip" DataContext="{Binding RelativeSource={RelativeSource TemplatedParent}}" Placement="Right" PlacementTarget="{Binding RelativeSource={RelativeSource TemplatedParent}}" Template="{StaticResource TextBoxValidationToolTipTemplate}"/>
                          </ToolTipService.ToolTip>
                          <Grid Background="Transparent" HorizontalAlignment="Right" Height="12" Margin="1,-4,-4,0" VerticalAlignment="Top" Width="12">
                            <Path Data="M 1,0 L6,0 A 2,2 90 0 1 8,2 L8,7 z" Fill="{StaticResource ValidationErrorElementBrush}" Margin="1,3,0,0" />
                            <Path Data="M 0,0 L2,0 L 8,6 L8,8" Fill="{StaticResource ThemeLightForegroundBrush}" Margin="1,3,0,0" />
                          </Grid>
                        </Border>
                      </Grid>
                      <ControlTemplate.Triggers>
                        <Trigger Property="IsEnabled" Value="False">
                          <Setter Property="BorderBrush" Value="{StaticResource TextBoxnDisabledBorderBrush}" TargetName="Bd" />
                          <Setter Property="Foreground" Value="{StaticResource TextBoxDisabledForegroundBrush}" />
                        </Trigger>
                        <Trigger Property="IsMouseOver" Value="True">
                          <Setter Property="BorderBrush" Value="{StaticResource TextBoxHoverBorderBrush}" TargetName="Bd" />
                        </Trigger>
                        <Trigger Property="IsFocused" Value="True">
                          <Setter Property="BorderBrush" Value="{StaticResource TextBoxFocusedBorderBrush}" TargetName="Bd" />
                        </Trigger>
                        <MultiDataTrigger>
                          <MultiDataTrigger.Conditions>
                            <Condition Binding="{Binding IsReadOnly, RelativeSource={RelativeSource Self}}" Value="True" />
                            <Condition Binding="{Binding IsEnabled, RelativeSource={RelativeSource Self}}" Value="True" />
                          </MultiDataTrigger.Conditions>
                          <Setter Property="Background" Value="{StaticResource ReadonlyBackgroundBrush}" />
                          <Setter Property="BorderBrush" Value="{StaticResource ReadonlyBorderBrush}" />
                        </MultiDataTrigger>
                      </ControlTemplate.Triggers>
                    </ControlTemplate>
                  </Setter.Value>
                </Setter>
              </Style>

              <!-- ********************************** ListBoxStyle **********************************-->
              <Style x:Key="ListBoxStyle" TargetType="{x:Type ListBox}">
                <Setter Property="Background" Value="{StaticResource ThemeLightForegroundBrush}" />
                <Setter Property="BorderBrush" Value="{StaticResource ListBoxBorderBrush}" />
                <Setter Property="Foreground" Value="{StaticResource ThemeForegroundBrush}" />
                <Setter Property="BorderThickness" Value="1" />
                <Setter Property="Padding" Value="1" />
                <Setter Property="ScrollViewer.HorizontalScrollBarVisibility" Value="Auto" />
                <Setter Property="ScrollViewer.VerticalScrollBarVisibility" Value="Auto" />
                <Setter Property="ScrollViewer.CanContentScroll" Value="true" />
                <Setter Property="ScrollViewer.PanningMode" Value="Both" />
                <Setter Property="Stylus.IsFlicksEnabled" Value="False" />
                <Setter Property="HorizontalContentAlignment" Value="Left" />
                <Setter Property="VerticalContentAlignment" Value="Top" />
                <Setter Property="ItemContainerStyle" Value="{StaticResource ListBoxItemStyle}" />
                <Setter Property="Template">
                  <Setter.Value>
                    <ControlTemplate TargetType="{x:Type ListBox}">
                      <Border x:Name="Bd" BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}" Background="{TemplateBinding Background}" Padding="1" SnapsToDevicePixels="true">
                        <ScrollViewer Focusable="false" Style="{StaticResource ScrollViewerStyle}" Margin="-1">
                          <ItemsPresenter SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}" />
                        </ScrollViewer>
                      </Border>
                      <ControlTemplate.Triggers>
                        <Trigger Property="IsEnabled" Value="false">
                          <Setter Property="Opacity" TargetName="Bd" Value="0.5" />
                        </Trigger>
                        <Trigger Property="IsGrouping" Value="true">
                          <Setter Property="ScrollViewer.CanContentScroll" Value="false" />
                        </Trigger>
                      </ControlTemplate.Triggers>
                    </ControlTemplate>
                  </Setter.Value>
                </Setter>
              </Style>
            </ResourceDictionary>
	    </ResourceDictionary.MergedDictionaries>

	    <!-- *********************************  BRUSHES  ********************************* -->
	    <!--  Slider Brushes -->
	    <LinearGradientBrush x:Key="SliderThumbBackgroundBrush" EndPoint="0.5,1" StartPoint="0.5,0">
		    <GradientStop Color="{StaticResource Color_004}" />
		    <GradientStop Color="{StaticResource Color_002}" Offset="1" />
	    </LinearGradientBrush>
	    <SolidColorBrush x:Key="SliderThumbBorderBrush" Color="{StaticResource Color_002}" />
	    <LinearGradientBrush x:Key="SliderThumbHoverBackgroundBrush" EndPoint="0.5,1" StartPoint="0.5,0">
		    <GradientStop Color="{StaticResource Color_014}" />
		    <GradientStop Color="{StaticResource Color_016}" Offset="1" />
	    </LinearGradientBrush>
	    <SolidColorBrush x:Key="SliderThumbHoverBorderBrush" Color="{StaticResource Color_016}" />
	    <LinearGradientBrush x:Key="SliderThumbPressedBackgroundBrush" EndPoint="0.5,1" StartPoint="0.5,0">
		    <GradientStop Color="{StaticResource Color_014}" Offset="1" />
		    <GradientStop Color="{StaticResource Color_016}" />
	    </LinearGradientBrush>
	    <SolidColorBrush x:Key="SliderThumbPressedBorderBrush" Color="{StaticResource Color_016}" />
	    <LinearGradientBrush x:Key="SliderThumbDisabledBackgroundBrush" EndPoint="0.5,1" StartPoint="0.5,0">
		    <GradientStop Color="{StaticResource Color_008}" />
		    <GradientStop Color="{StaticResource Color_006}" Offset="1" />
	    </LinearGradientBrush>
	    <SolidColorBrush x:Key="SliderThumbDisabledBorderBrush" Color="{StaticResource Color_007}" />
	    <SolidColorBrush x:Key="SliderThumbFocusedBorderBrush" Color="{StaticResource Color_014}" />
	    <LinearGradientBrush x:Key="HSliderTrackBackgroundBrush" StartPoint="0.82,1" EndPoint="0.82,0.25">
		    <GradientStop Offset="0" Color="{StaticResource Color_006}" />
		    <GradientStop Offset="0.93" Color="{StaticResource Color_008}" />
		    <GradientStop Offset="0.98" Color="{StaticResource Color_008}" />
	    </LinearGradientBrush>
	    <SolidColorBrush x:Key="HSliderTrackBorderBrush" Color="{StaticResource Color_005}" />
	    <LinearGradientBrush x:Key="VSliderTrackBackgroundBrush" StartPoint="0.82,1" EndPoint="0.82,0.25">
		    <GradientStop Offset="0" Color="{StaticResource Color_006}" />
		    <GradientStop Offset="0.93" Color="{StaticResource Color_008}" />
		    <GradientStop Offset="0.98" Color="{StaticResource Color_008}" />
	    </LinearGradientBrush>
	    <SolidColorBrush x:Key="VSliderTrackBorderBrush" Color="{StaticResource Color_005}" />
	    <LinearGradientBrush x:Key="SliderTrackDisabledBackgroundBrush" EndPoint="0.5,1" StartPoint="0.5,0">
		    <GradientStop Color="{StaticResource Color_008}" />
		    <GradientStop Color="{StaticResource Color_006}" Offset="1" />
	    </LinearGradientBrush>
	    <LinearGradientBrush x:Key="SliderSelectionRangeBackgroundBrush" EndPoint="0.5,1" StartPoint="0.5,0">
		    <GradientStop Color="{StaticResource Color_014}" />
		    <GradientStop Color="{StaticResource Color_016}" Offset="1" />
	    </LinearGradientBrush>
	    <SolidColorBrush x:Key="SliderSelectionRangeBorderBrush" Color="{StaticResource Color_016}" />

	    <!--  GridSplitter Brushes -->
	    <SolidColorBrush x:Key="GridSplitterBackgroundBrush" Color="{StaticResource Color_002}" />
	    <SolidColorBrush x:Key="GridSplitterBorderBrush" Color="{StaticResource Color_002}" />
	    <SolidColorBrush x:Key="GridSplitterHoverBackgroundBrush" Color="{StaticResource Color_014}" />
	    <SolidColorBrush x:Key="GridSplitterHoverBorderBrush" Color="{StaticResource Color_016}" />
	    <SolidColorBrush x:Key="GridSplitterPressedBackgroundBrush" Color="{StaticResource Color_016}" />
	    <SolidColorBrush x:Key="GridSplitterFocusedBorderBrush" Color="{StaticResource Color_014}" />

	    <!-- ProgressBar Brushes -->
	    <LinearGradientBrush x:Key="ProgressBarBackgroundBrush" EndPoint="0.5,1" StartPoint="0.5,0">
		    <GradientStop Offset="0" Color="{StaticResource Color_010}" />
		    <GradientStop Offset="1" Color="{StaticResource Color_008}" />
	    </LinearGradientBrush>
	    <SolidColorBrush x:Key="ProgressBarBorderBrush" Color="{StaticResource Color_006}" />
	    <LinearGradientBrush x:Key="ProgressBarForegroundBrush" EndPoint="0.5,1" StartPoint="0.5,0">
		    <GradientStop Offset="0" Color="{StaticResource Color_014}" />
		    <GradientStop Offset="1" Color="{StaticResource Color_017}" />
	    </LinearGradientBrush>
	    <SolidColorBrush x:Key="ProgressBarDeterminateBorderBrush" Color="{StaticResource Color_016}" />
	    <LinearGradientBrush x:Key="ProgressBarIndeterminateBackgroundBrush" EndPoint="0,1" MappingMode="Absolute" SpreadMethod="Repeat" StartPoint="20,1" Opacity="0.8">
		    <LinearGradientBrush.Transform>
			    <TransformGroup>
				    <TranslateTransform X="0" />
				    <SkewTransform AngleX="-30" />
			    </TransformGroup>
		    </LinearGradientBrush.Transform>
		    <GradientStop Color="{StaticResource Color_016}" Offset="0.249" />
		    <GradientStop Color="{StaticResource Color_014}" Offset=".25" />
		    <GradientStop Color="{StaticResource Color_014}" Offset="0.75" />
		    <GradientStop Color="{StaticResource Color_016}" Offset="0.751" />
	    </LinearGradientBrush>
	    <SolidColorBrush x:Key="ProgressBarIndeterminateBorderBrush" Color="{StaticResource Color_016}" />

	    <!-- Tooltip Brushes -->
	    <LinearGradientBrush x:Key="TooltipBackgroundBrush" EndPoint="0.5,1" StartPoint="0.5,0">
		    <GradientStop Color="{StaticResource Color_009}" Offset="1" />
		    <GradientStop Color="{StaticResource Color_010}" />
	    </LinearGradientBrush>
	    <SolidColorBrush x:Key="TooltipBorderBrush" Color="{StaticResource Color_007}" />
	    <SolidColorBrush x:Key="TooltipShadowBackgroundBrush" Color="{StaticResource Color_000}" />

	    <!-- Expander Brushes -->
	    <LinearGradientBrush x:Key="ExpanderButtonBackgroundBrush" EndPoint="0.5,1" StartPoint="0.5,0">
		    <GradientStop Color="{StaticResource Color_004}" />
		    <GradientStop Color="{StaticResource Color_002}" Offset="1" />
	    </LinearGradientBrush>
	    <SolidColorBrush x:Key="ExpanderButtonBorderBrush" Color="{StaticResource Color_002}" />
	    <LinearGradientBrush x:Key="ExpanderButtonHoverBackgroundBrush" EndPoint="0.5,1" StartPoint="0.5,0">
		    <GradientStop Color="{StaticResource Color_014}" />
		    <GradientStop Color="{StaticResource Color_016}" Offset="1" />
	    </LinearGradientBrush>
	    <SolidColorBrush x:Key="ExpanderButtonHoverBorderBrush" Color="{StaticResource Color_016}" />
	    <LinearGradientBrush x:Key="ExpanderButtonPressedBackgroundBrush" EndPoint="0.5,1" StartPoint="0.5,0">
		    <GradientStop Color="{StaticResource Color_014}" Offset="1" />
		    <GradientStop Color="{StaticResource Color_016}" />
	    </LinearGradientBrush>
	    <SolidColorBrush x:Key="ExpanderButtonPressedBorderBrush" Color="{StaticResource Color_016}" />
	    <SolidColorBrush x:Key="ExpanderArrowBorderBrush" Color="{StaticResource Color_011}" />
	    <SolidColorBrush x:Key="ExpanderDisabledBackgroundBrush" Color="{StaticResource Color_024}" />
	    <SolidColorBrush x:Key="ExpanderDisabledForegroundBrush" Color="{StaticResource Color_024}" />

	    <!-- GroupBox Brushes -->
	    <SolidColorBrush x:Key="GroupBoxBorderBrush" Color="{StaticResource Color_006}" />

	    <!-- PassWordBox Brushes -->
	    <SolidColorBrush x:Key="PasswordBoxForegroundBrush" Color="{StaticResource Color_016}" />

	    <!-- *********************************  SliderRepeatButton Style  ********************************* -->
	    <Style x:Key="SliderRepeatButtonStyle" TargetType="{x:Type RepeatButton}">
		    <Setter Property="OverridesDefaultStyle" Value="true" />
		    <Setter Property="Focusable" Value="false" />
		    <Setter Property="IsTabStop" Value="false" />
		    <Setter Property="Template">
			    <Setter.Value>
				    <ControlTemplate TargetType="{x:Type RepeatButton}">
					    <Rectangle Fill="{StaticResource TransparentBrush}" />
				    </ControlTemplate>
			    </Setter.Value>
		    </Setter>
	    </Style>

	    <!-- *********************************  Horizontal Thumb Style  ********************************* -->
	    <Style x:Key="HSliderThumbStyle" TargetType="{x:Type Thumb}">
		    <Setter Property="Background" Value="{StaticResource SliderThumbBackgroundBrush}" />
		    <Setter Property="BorderBrush" Value="{StaticResource SliderThumbBorderBrush}" />
		    <Setter Property="BorderThickness" Value="1" />
		    <Setter Property="MinHeight" Value="12" />
		    <Setter Property="MinWidth" Value="8" />
		    <Setter Property="IsTabStop" Value="False" />
		    <Setter Property="Template">
			    <Setter.Value>
				    <ControlTemplate TargetType="{x:Type Thumb}">
					    <Grid>
						    <Path x:Name="HThumbBackground" Data="M 1561,382 C1561,382 1559,382 1559,382 1557,382 1556,380 1556,379 1556,379 1556,373 1556,373 1556,371 1557,370 1559,370 1559,370 1561,370 1561,370 1563,370 1564,371 1564,373 1564,373 1564,379 1564,379 1564,380 1563,382 1561,382 z" Fill="{TemplateBinding Background}" Stroke="{TemplateBinding BorderBrush}" StrokeThickness="{TemplateBinding BorderThickness}" Height="12" Width="8" Stretch="Fill" Opacity="1" />
						    <Path x:Name="HThumbHover" Data="M 1561,382 C1561,382 1559,382 1559,382 1557,382 1556,380 1556,379 1556,379 1556,373 1556,373 1556,371 1557,370 1559,370 1559,370 1561,370 1561,370 1563,370 1564,371 1564,373 1564,373 1564,379 1564,379 1564,380 1563,382 1561,382 z" Fill="{StaticResource SliderThumbHoverBackgroundBrush}" Stroke="{StaticResource SliderThumbHoverBorderBrush}" StrokeThickness="{TemplateBinding BorderThickness}" Height="12" Width="8" Stretch="Fill" Opacity="0" />
						    <Path x:Name="HThumbPressed" Data="M 1561,382 C1561,382 1559,382 1559,382 1557,382 1556,380 1556,379 1556,379 1556,373 1556,373 1556,371 1557,370 1559,370 1559,370 1561,370 1561,370 1563,370 1564,371 1564,373 1564,373 1564,379 1564,379 1564,380 1563,382 1561,382 z" Fill="{StaticResource SliderThumbPressedBackgroundBrush}" Stroke="{StaticResource SliderThumbPressedBorderBrush}" StrokeThickness="{TemplateBinding BorderThickness}" Height="12" Width="8" Stretch="Fill" Opacity="0" />
						    <Path x:Name="HThumbDisabled" Data="M 1561,382 C1561,382 1559,382 1559,382 1557,382 1556,380 1556,379 1556,379 1556,373 1556,373 1556,371 1557,370 1559,370 1559,370 1561,370 1561,370 1563,370 1564,371 1564,373 1564,373 1564,379 1564,379 1564,380 1563,382 1561,382 z" Fill="{StaticResource SliderThumbDisabledBackgroundBrush}" Stroke="{StaticResource SliderThumbDisabledBorderBrush}" StrokeThickness="{TemplateBinding BorderThickness}" Height="12" Width="8" Stretch="Fill" Opacity="0" />
					    </Grid>
					    <ControlTemplate.Triggers>
						    <Trigger Property="IsMouseOver" Value="True">
							    <Setter TargetName="HThumbHover" Property="Opacity" Value="1" />
						    </Trigger>
						    <Trigger Property="IsMouseCaptured" Value="True">
							    <Setter TargetName="HThumbPressed" Property="Opacity" Value="1" />
						    </Trigger>
						    <Trigger Property="IsEnabled" Value="false">
							    <Setter TargetName="HThumbDisabled" Property="Opacity" Value="1" />
						    </Trigger>
					    </ControlTemplate.Triggers>
				    </ControlTemplate>
			    </Setter.Value>
		    </Setter>
	    </Style>

	    <!-- *********************************  Vertical Thumb Style  ********************************* -->
	    <Style x:Key="VSliderThumbStyle" TargetType="{x:Type Thumb}">
		    <Setter Property="Background" Value="{StaticResource SliderThumbBackgroundBrush}" />
		    <Setter Property="BorderBrush" Value="{StaticResource SliderThumbBorderBrush}" />
		    <Setter Property="BorderThickness" Value="1" />
		    <Setter Property="MinHeight" Value="8" />
		    <Setter Property="MinWidth" Value="12" />
		    <Setter Property="IsTabStop" Value="False" />
		    <Setter Property="Template">
			    <Setter.Value>
				    <ControlTemplate TargetType="{x:Type Thumb}">
					    <Grid>
						    <Path x:Name="VThumbBackground" Data="M 1531,375 C1531,375 1531,377 1531,377 1531,379 1529,380 1528,380 1528,380 1522,380 1522,380 1520,380 1519,379 1519,377 1519,377 1519,375 1519,375 1519,373 1520,372 1522,372 1522,372 1528,372 1528,372 1529,372 1531,373 1531,375 z" Fill="{TemplateBinding Background}" Stroke="{TemplateBinding BorderBrush}" StrokeThickness="{TemplateBinding BorderThickness}" Height="8" Width="12" Stretch="Fill" Opacity="1" />
						    <Path x:Name="VThumbHover" Data="M 1531,375 C1531,375 1531,377 1531,377 1531,379 1529,380 1528,380 1528,380 1522,380 1522,380 1520,380 1519,379 1519,377 1519,377 1519,375 1519,375 1519,373 1520,372 1522,372 1522,372 1528,372 1528,372 1529,372 1531,373 1531,375 z" Fill="{StaticResource SliderThumbHoverBackgroundBrush}" Stroke="{StaticResource SliderThumbHoverBorderBrush}" StrokeThickness="{TemplateBinding BorderThickness}" Height="8" Width="12" Stretch="Fill" Opacity="0" />
						    <Path x:Name="VThumbPressed" Data="M 1531,375 C1531,375 1531,377 1531,377 1531,379 1529,380 1528,380 1528,380 1522,380 1522,380 1520,380 1519,379 1519,377 1519,377 1519,375 1519,375 1519,373 1520,372 1522,372 1522,372 1528,372 1528,372 1529,372 1531,373 1531,375 z" Fill="{StaticResource SliderThumbPressedBackgroundBrush}" Stroke="{StaticResource SliderThumbPressedBorderBrush}" StrokeThickness="{TemplateBinding BorderThickness}" Height="8" Width="12" Stretch="Fill" Opacity="0" />
						    <Path x:Name="VThumbDisabled" Data="M 1531,375 C1531,375 1531,377 1531,377 1531,379 1529,380 1528,380 1528,380 1522,380 1522,380 1520,380 1519,379 1519,377 1519,377 1519,375 1519,375 1519,373 1520,372 1522,372 1522,372 1528,372 1528,372 1529,372 1531,373 1531,375 z" Fill="{StaticResource SliderThumbDisabledBackgroundBrush}" Stroke="{StaticResource SliderThumbDisabledBorderBrush}" StrokeThickness="{TemplateBinding BorderThickness}" Height="8" Width="12" Stretch="Fill" Opacity="0" />
					    </Grid>
					    <ControlTemplate.Triggers>
						    <Trigger Property="IsMouseOver" Value="True">
							    <Setter TargetName="VThumbHover" Property="Opacity" Value="1" />
						    </Trigger>
						    <Trigger Property="IsMouseCaptured" Value="True">
							    <Setter TargetName="VThumbPressed" Property="Opacity" Value="1" />
						    </Trigger>
						    <Trigger Property="IsEnabled" Value="false">
							    <Setter TargetName="VThumbDisabled" Property="Opacity" Value="1" />
						    </Trigger>
					    </ControlTemplate.Triggers>
				    </ControlTemplate>
			    </Setter.Value>
		    </Setter>
	    </Style>

	    <!-- *********************************  Slider Style  ********************************* -->
	    <Style x:Key="SliderStyle" TargetType="{x:Type Slider}">
		    <Setter Property="Stylus.IsPressAndHoldEnabled" Value="false" />
		    <Setter Property="Foreground" Value="{StaticResource ThemeForegroundBrush}" />
		    <Setter Property="Background" Value="Transparent" />
		    <Setter Property="Template">
			    <Setter.Value>
				    <ControlTemplate TargetType="{x:Type Slider}">
					    <Border BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}" Background="{TemplateBinding Background}" SnapsToDevicePixels="true">
						    <Grid>
							    <Grid.RowDefinitions>
								    <RowDefinition Height="Auto" />
								    <RowDefinition Height="Auto" MinHeight="{TemplateBinding MinHeight}" />
								    <RowDefinition Height="Auto" />
							    </Grid.RowDefinitions>
							    <TickBar x:Name="TopTick" Fill="{TemplateBinding Foreground}" Height="4" Placement="Top" Grid.Row="0" Visibility="Collapsed" />
							    <TickBar x:Name="BottomTick" Fill="{TemplateBinding Foreground}" Height="4" Placement="Bottom" Grid.Row="2" Visibility="Collapsed" />
							    <Border x:Name="TrackBackground" Background="{StaticResource HSliderTrackBackgroundBrush}" CornerRadius="1" Height="4" Grid.Row="1" VerticalAlignment="center" BorderBrush="{StaticResource HSliderTrackBorderBrush}" BorderThickness="1">
								    <Canvas Margin="-6,-1">
									    <Rectangle x:Name="PART_SelectionRange" Fill="{StaticResource SliderSelectionRangeBackgroundBrush}" Stroke="{StaticResource SliderSelectionRangeBorderBrush}" Height="4.0" StrokeThickness="1.0" RadiusY="1" RadiusX="1" Width="0" Visibility="Hidden" />
								    </Canvas>
							    </Border>
							    <Track x:Name="PART_Track" Grid.Row="1">
								    <Track.DecreaseRepeatButton>
									    <RepeatButton Command="{x:Static Slider.DecreaseLarge}" Style="{StaticResource SliderRepeatButtonStyle}" />
								    </Track.DecreaseRepeatButton>
								    <Track.IncreaseRepeatButton>
									    <RepeatButton Command="{x:Static Slider.IncreaseLarge}" Style="{StaticResource SliderRepeatButtonStyle}" />
								    </Track.IncreaseRepeatButton>
								    <Track.Thumb>
									    <Thumb x:Name="Thumb" Style="{StaticResource HSliderThumbStyle}" Height="18" />
								    </Track.Thumb>
							    </Track>
						    </Grid>
					    </Border>
					    <ControlTemplate.Triggers>
						    <Trigger Property="TickPlacement" Value="TopLeft">
							    <Setter Property="Visibility" TargetName="TopTick" Value="Visible" />
							    <Setter Property="Style" TargetName="Thumb" Value="{StaticResource HSliderThumbStyle}" />
							    <Setter Property="Margin" TargetName="TrackBackground" Value="5,2,5,0" />
						    </Trigger>
						    <Trigger Property="TickPlacement" Value="BottomRight">
							    <Setter Property="Visibility" TargetName="BottomTick" Value="Visible" />
							    <Setter Property="Style" TargetName="Thumb" Value="{StaticResource HSliderThumbStyle}" />
							    <Setter Property="Margin" TargetName="TrackBackground" Value="5,0,5,2" />
						    </Trigger>
						    <Trigger Property="TickPlacement" Value="Both">
							    <Setter Property="Visibility" TargetName="TopTick" Value="Visible" />
							    <Setter Property="Visibility" TargetName="BottomTick" Value="Visible" />
						    </Trigger>
						    <Trigger Property="IsSelectionRangeEnabled" Value="true">
							    <Setter Property="Visibility" TargetName="PART_SelectionRange" Value="Visible" />
						    </Trigger>
						    <Trigger Property="IsKeyboardFocused" Value="true">
							    <Setter Property="Foreground" TargetName="Thumb" Value="{StaticResource SliderThumbFocusedBorderBrush}" />
						    </Trigger>
					    </ControlTemplate.Triggers>
				    </ControlTemplate>
			    </Setter.Value>
		    </Setter>
		    <Style.Triggers>
			    <Trigger Property="Orientation" Value="Vertical">
				    <Setter Property="Template">
					    <Setter.Value>
						    <ControlTemplate TargetType="{x:Type Slider}">
							    <Border BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}" Background="{TemplateBinding Background}" SnapsToDevicePixels="true">
								    <Grid>
									    <Grid.ColumnDefinitions>
										    <ColumnDefinition Width="Auto" />
										    <ColumnDefinition MinWidth="{TemplateBinding MinWidth}" Width="Auto" />
										    <ColumnDefinition Width="Auto" />
									    </Grid.ColumnDefinitions>
									    <TickBar x:Name="TopTick" Grid.Column="0" Fill="{TemplateBinding Foreground}" Placement="Left" Visibility="Collapsed" Width="4" />
									    <TickBar x:Name="BottomTick" Grid.Column="2" Fill="{TemplateBinding Foreground}" Placement="Right" Visibility="Collapsed" Width="4" />
									    <Border x:Name="TrackBackground" Background="{StaticResource VSliderTrackBackgroundBrush}" BorderBrush="{StaticResource VSliderTrackBorderBrush}" Grid.Column="1" CornerRadius="1" HorizontalAlignment="center" Width="4" BorderThickness="1">
										    <Canvas Margin="-1,-6">
											    <Rectangle x:Name="PART_SelectionRange" Fill="{StaticResource SliderSelectionRangeBackgroundBrush}" Stroke="{StaticResource SliderSelectionRangeBorderBrush}" StrokeThickness="1.0" RadiusY="1" RadiusX="1" Visibility="Hidden" Width="4.0" />
										    </Canvas>
									    </Border>
									    <Track x:Name="PART_Track" Grid.Column="1">
										    <Track.DecreaseRepeatButton>
											    <RepeatButton Command="{x:Static Slider.DecreaseLarge}" Style="{StaticResource SliderRepeatButtonStyle}" />
										    </Track.DecreaseRepeatButton>
										    <Track.IncreaseRepeatButton>
											    <RepeatButton Command="{x:Static Slider.IncreaseLarge}" Style="{StaticResource SliderRepeatButtonStyle}" />
										    </Track.IncreaseRepeatButton>
										    <Track.Thumb>
											    <Thumb x:Name="Thumb" Style="{StaticResource VSliderThumbStyle}" Width="14" Height="9" />
										    </Track.Thumb>
									    </Track>
								    </Grid>
							    </Border>
							    <ControlTemplate.Triggers>
								    <Trigger Property="TickPlacement" Value="TopLeft">
									    <Setter Property="Visibility" TargetName="TopTick" Value="Visible" />
									    <Setter Property="Style" TargetName="Thumb" Value="{StaticResource VSliderThumbStyle}" />
									    <Setter Property="Margin" TargetName="TrackBackground" Value="2,5,0,5" />
								    </Trigger>
								    <Trigger Property="TickPlacement" Value="BottomRight">
									    <Setter Property="Visibility" TargetName="BottomTick" Value="Visible" />
									    <Setter Property="Style" TargetName="Thumb" Value="{StaticResource VSliderThumbStyle}" />
									    <Setter Property="Margin" TargetName="TrackBackground" Value="0,5,2,5" />
								    </Trigger>
								    <Trigger Property="TickPlacement" Value="Both">
									    <Setter Property="Visibility" TargetName="TopTick" Value="Visible" />
									    <Setter Property="Visibility" TargetName="BottomTick" Value="Visible" />
								    </Trigger>
								    <Trigger Property="IsSelectionRangeEnabled" Value="true">
									    <Setter Property="Visibility" TargetName="PART_SelectionRange" Value="Visible" />
								    </Trigger>
								    <Trigger Property="IsKeyboardFocused" Value="true">
									    <Setter Property="Foreground" TargetName="Thumb" Value="{StaticResource SliderThumbFocusedBorderBrush}" />
								    </Trigger>
							    </ControlTemplate.Triggers>
						    </ControlTemplate>
					    </Setter.Value>
				    </Setter>
			    </Trigger>
		    </Style.Triggers>
	    </Style>

	    <!-- *********************************  RepeatButton Style  ********************************* -->
	    <Style x:Key="RepeatButtonStyle" TargetType="{x:Type RepeatButton}">
		    <Setter Property="FontFamily" Value="Segoe UI" />
		    <Setter Property="FontSize" Value="12" />
		    <Setter Property="Foreground" Value="{StaticResource ThemeLightForegroundBrush}" />
		    <Setter Property="BorderThickness" Value="1" />
		    <Setter Property="Padding" Value="8,0,8,2" />
		    <Setter Property="Margin" Value="0" />
		    <Setter Property="MinHeight" Value="22" />
		    <Setter Property="Template">
			    <Setter.Value>
				    <ControlTemplate TargetType="{x:Type RepeatButton}">
					    <Grid SnapsToDevicePixels="True">
						    <VisualStateManager.VisualStateGroups>
							    <VisualStateGroup x:Name="CommonStates">
								    <VisualStateGroup.Transitions>
									    <VisualTransition GeneratedDuration="0:0:0.2" />
								    </VisualStateGroup.Transitions>
								    <VisualState x:Name="Normal" />
								    <VisualState x:Name="MouseOver">
									    <Storyboard>
										    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="hover" />
									    </Storyboard>
								    </VisualState>
								    <VisualState x:Name="Pressed">
									    <Storyboard>
										    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="pressed" />
									    </Storyboard>
								    </VisualState>
								    <VisualState x:Name="Disabled">
									    <Storyboard>
										    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="disabled" />
										    <DoubleAnimation Duration="0" To="0.5" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="contentPresenter" />
									    </Storyboard>
								    </VisualState>
							    </VisualStateGroup>
							    <VisualStateGroup x:Name="FocusStates">
								    <VisualState x:Name="Focused">
									    <Storyboard>
										    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="focused" />
									    </Storyboard>
								    </VisualState>
								    <VisualState x:Name="Unfocused" />
							    </VisualStateGroup>
						    </VisualStateManager.VisualStateGroups>
						    <Rectangle x:Name="normal" Opacity="1" RadiusX="3" RadiusY="3" StrokeThickness="{TemplateBinding BorderThickness}" Stroke="{StaticResource ButtonBorderBrush}" Fill="{StaticResource ButtonBackgroundBrush}" />
						    <Rectangle x:Name="hover" Opacity="0" RadiusX="3" RadiusY="3" StrokeThickness="{TemplateBinding BorderThickness}" Stroke="{StaticResource ButtonHoverBorderBrush}" Fill="{StaticResource ButtonHoverBackgroundBrush}" />
						    <Rectangle x:Name="pressed" Opacity="0" RadiusX="3" RadiusY="3" StrokeThickness="{TemplateBinding BorderThickness}" Stroke="{StaticResource ButtonPressedBorderBrush}" Fill="{StaticResource ButtonPressedBackgroundBrush}" />
						    <Rectangle x:Name="focused" Opacity="0" RadiusX="3" RadiusY="3" StrokeThickness="{TemplateBinding BorderThickness}" Stroke="{StaticResource ButtonFocusedBorderBrush}" />
						    <Rectangle x:Name="disabled" Opacity="0" RadiusX="3" RadiusY="3" StrokeThickness="{TemplateBinding BorderThickness}" Stroke="{StaticResource ButtonDisabledBorderBrush}" Fill="{StaticResource ButtonDisabledBackgroundBrush}" />
						    <ContentPresenter x:Name="contentPresenter" ContentTemplate="{TemplateBinding ContentTemplate}" Content="{TemplateBinding Content}" Margin="{TemplateBinding Padding}" HorizontalAlignment="Center" VerticalAlignment="Center" />
					    </Grid>
				    </ControlTemplate>
			    </Setter.Value>
		    </Setter>
	    </Style>

	    <!-- ********************************** GridSplitter Style **********************************-->
	    <Style x:Key="GridSplitterStyle" TargetType="{x:Type GridSplitter}">
		    <Setter Property="Foreground" Value="{StaticResource ThemeLightForegroundBrush}" />
		    <Setter Property="Background" Value="{StaticResource GridSplitterBackgroundBrush}" />
		    <Setter Property="BorderBrush" Value="{StaticResource GridSplitterBorderBrush}" />
		    <Setter Property="BorderThickness" Value="1" />
		    <Setter Property="SnapsToDevicePixels" Value="True" />
		    <Setter Property="PreviewStyle">
			    <Setter.Value>
				    <Style TargetType="Control">
					    <Setter Property="Control.Template">
						    <Setter.Value>
							    <ControlTemplate>
								    <Rectangle Fill="{StaticResource GridSplitterPressedBackgroundBrush}" RadiusX="3" RadiusY="3" Opacity="0.8" />
							    </ControlTemplate>
						    </Setter.Value>
					    </Setter>
				    </Style>
			    </Setter.Value>
		    </Setter>
		    <Setter Property="Template">
			    <Setter.Value>
				    <ControlTemplate>
					    <Grid>
						    <Border x:Name="border" BorderThickness="{TemplateBinding BorderThickness}" BorderBrush="{TemplateBinding BorderBrush}" Background="{TemplateBinding Background}" CornerRadius="3">
							    <Grid>
								    <StackPanel x:Name="HGrip" Height="5" VerticalAlignment="Center" HorizontalAlignment="Center" Orientation="Vertical">
									    <Rectangle Fill="{StaticResource ThemeLightForegroundBrush}" Height="1" Margin="1" StrokeThickness="0" Width="15" />
									    <Rectangle Fill="{StaticResource ThemeLightForegroundBrush}" Height="1" Margin="0" StrokeThickness="0" Width="15" />
								    </StackPanel>
								    <StackPanel x:Name="VGrip" Width="5" VerticalAlignment="Center" HorizontalAlignment="Center" Orientation="Horizontal" Visibility="Visible">
									    <Rectangle Fill="{StaticResource ThemeLightForegroundBrush}" Height="15" Margin="1" StrokeThickness="0" Width="1" />
									    <Rectangle Fill="{StaticResource ThemeLightForegroundBrush}" Height="15" Margin="0" StrokeThickness="0" Width="1" />
								    </StackPanel>
							    </Grid>
						    </Border>
					    </Grid>
					    <ControlTemplate.Triggers>
						    <Trigger Property="HorizontalAlignment" Value="Stretch">
							    <Setter TargetName="HGrip" Property="Visibility" Value="Visible" />
							    <Setter TargetName="VGrip" Property="Visibility" Value="Collapsed" />
						    </Trigger>
						    <Trigger Property="VerticalAlignment" Value="Stretch">
							    <Setter TargetName="VGrip" Property="Visibility" Value="Visible" />
							    <Setter TargetName="HGrip" Property="Visibility" Value="Collapsed" />
						    </Trigger>
						    <Trigger Property="IsMouseOver" Value="True">
							    <Setter TargetName="border" Property="Background" Value="{StaticResource GridSplitterHoverBackgroundBrush}" />
							    <Setter TargetName="border" Property="BorderBrush" Value="{StaticResource GridSplitterHoverBorderBrush}" />
						    </Trigger>
						    <Trigger Property="IsFocused" Value="True">
							    <Setter TargetName="border" Property="BorderBrush" Value="{StaticResource GridSplitterFocusedBorderBrush}" />
						    </Trigger>
					    </ControlTemplate.Triggers>
				    </ControlTemplate>
			    </Setter.Value>
		    </Setter>
	    </Style>

	    <!-- ********************************** ProgressBar Style **********************************-->
	    <Style x:Key="ProgressBarStyle" TargetType="{x:Type ProgressBar}">
		    <Setter Property="Foreground" Value="{StaticResource ProgressBarForegroundBrush}" />
		    <Setter Property="Background" Value="{StaticResource ProgressBarBackgroundBrush}" />
		    <Setter Property="BorderBrush" Value="{StaticResource ProgressBarBorderBrush}" />
		    <Setter Property="BorderThickness" Value="1" />
		    <Setter Property="Template">
			    <Setter.Value>
				    <ControlTemplate TargetType="{x:Type ProgressBar}">
					    <Grid x:Name="TemplateRoot" SnapsToDevicePixels="true">
						    <VisualStateManager.VisualStateGroups>
							    <VisualStateGroup x:Name="CommonStates">
								    <VisualState x:Name="Determinate" />
								    <VisualState x:Name="Indeterminate">
									    <Storyboard RepeatBehavior="Forever">
										    <DoubleAnimation Duration="00:00:.5" From="0" To="20" Storyboard.TargetProperty="(Shape.Fill).(LinearGradientBrush.Transform).(TransformGroup.Children)[0].X" Storyboard.TargetName="IndeterminateGradientFill" />
									    </Storyboard>
								    </VisualState>
							    </VisualStateGroup>
						    </VisualStateManager.VisualStateGroups>
						    <Border x:Name="ProgressBarTrack" BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}" Background="{TemplateBinding Background}" CornerRadius="3" />
						    <Rectangle x:Name="PART_Track" Margin="1" />
						    <Decorator x:Name="PART_Indicator" HorizontalAlignment="Left" Margin="1">
							    <Grid x:Name="Foreground">
								    <Rectangle x:Name="Indicator" Fill="{TemplateBinding Foreground}" />
							    </Grid>
						    </Decorator>
						    <Grid x:Name="IndeterminateRoot" Visibility="Collapsed">
							    <Rectangle x:Name="IndeterminateSolidFill" Fill="{TemplateBinding Foreground}" Stroke="{StaticResource ProgressBarIndeterminateBorderBrush}" StrokeThickness="1" Opacity="1" RadiusY="3" RadiusX="3" RenderTransformOrigin="0.5,0.5" />
							    <Rectangle x:Name="IndeterminateGradientFill" Fill="{StaticResource ProgressBarIndeterminateBackgroundBrush}" RadiusY="3" RadiusX="3" Margin="1" />
						    </Grid>
					    </Grid>
					    <ControlTemplate.Triggers>
						    <Trigger Property="Orientation" Value="Vertical">
							    <Setter Property="LayoutTransform" TargetName="TemplateRoot">
								    <Setter.Value>
									    <RotateTransform Angle="-90" />
								    </Setter.Value>
							    </Setter>
						    </Trigger>
						    <Trigger Property="IsIndeterminate" Value="true">
							    <Setter Property="Visibility" TargetName="Indicator" Value="Collapsed" />
							    <Setter Property="Visibility" TargetName="IndeterminateRoot" Value="Visible" />
						    </Trigger>
						    <Trigger Property="IsIndeterminate" Value="false">
						    </Trigger>
					    </ControlTemplate.Triggers>
				    </ControlTemplate>
			    </Setter.Value>
		    </Setter>
	    </Style>
    
	    <!-- ********************************** PasswordBox Style **********************************-->
	    <Style x:Key="PasswordBoxStyle" TargetType="{x:Type PasswordBox}">
		    <Setter Property="Foreground" Value="{StaticResource PasswordBoxForegroundBrush}" />
		    <Setter Property="Background" Value="{StaticResource TextBoxBackgroundBrush}" />
		    <Setter Property="BorderBrush" Value="{StaticResource TextBoxBorderBrush}" />
		    <Setter Property="BorderThickness" Value="1" />
		    <Setter Property="Padding" Value="4,2" />
		    <Setter Property="MinHeight" Value="24" />
		    <Setter Property="PasswordChar" Value="●" />
		    <Setter Property="KeyboardNavigation.TabNavigation" Value="None" />
		    <Setter Property="AllowDrop" Value="true" />
		    <Setter Property="FocusVisualStyle" Value="{x:Null}" />
		    <Setter Property="ScrollViewer.PanningMode" Value="VerticalFirst" />
		    <Setter Property="Stylus.IsFlicksEnabled" Value="False" />
		    <Setter Property="FlowDirection" Value="LeftToRight" />
		    <Setter Property="Template">
			    <Setter.Value>
				    <ControlTemplate TargetType="{x:Type PasswordBox}">
					    <Grid>
						    <Border Background="{TemplateBinding Background}" x:Name="Bd" BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}" CornerRadius="3">
							    <ScrollViewer x:Name="PART_ContentHost" />
						    </Border>
                            <Rectangle x:Name="innerShadow" Height="22" IsHitTestVisible="False" StrokeThickness="1" HorizontalAlignment="Stretch" VerticalAlignment="Top" Margin="1,1,0,1" RadiusX="2" RadiusY="2" Fill="{StaticResource TextBoxShadowBackgroundBrush}" />
					    </Grid>
					    <ControlTemplate.Triggers>
						    <Trigger Property="IsEnabled" Value="False">
							    <Setter Property="BorderBrush" Value="{StaticResource TextBoxnDisabledBorderBrush}" TargetName="Bd" />
							    <Setter Property="Foreground" Value="{StaticResource TextBoxDisabledForegroundBrush}" />
						    </Trigger>
						    <Trigger Property="IsMouseOver" Value="True">
							    <Setter Property="BorderBrush" Value="{StaticResource TextBoxHoverBorderBrush}" TargetName="Bd" />
						    </Trigger>
						    <Trigger Property="IsFocused" Value="True">
							    <Setter Property="BorderBrush" Value="{StaticResource TextBoxFocusedBorderBrush}" TargetName="Bd" />
						    </Trigger>
						    <MultiDataTrigger>
							    <MultiDataTrigger.Conditions>
								    <Condition Binding="{Binding IsReadOnly, RelativeSource={RelativeSource Self}}" Value="True" />
								    <Condition Binding="{Binding IsEnabled, RelativeSource={RelativeSource Self}}" Value="True" />
							    </MultiDataTrigger.Conditions>
							    <Setter Property="Background" Value="{StaticResource ReadonlyBackgroundBrush}" />
							    <Setter Property="BorderBrush" Value="{StaticResource ReadonlyBorderBrush}" />
						    </MultiDataTrigger>
					    </ControlTemplate.Triggers>
				    </ControlTemplate>
			    </Setter.Value>
		    </Setter>
	    </Style>

	    <!-- *********************************  Tooltip Style  ********************************* -->
	    <Style x:Key="{x:Type ToolTip}" TargetType="ToolTip">
		    <Setter Property="Foreground" Value="{StaticResource ThemeForegroundBrush}" />
		    <Setter Property="Background" Value="{StaticResource TooltipBackgroundBrush}" />
		    <Setter Property="BorderBrush" Value="{StaticResource TooltipBorderBrush}" />
		    <Setter Property="BorderThickness" Value="1" />
		    <Setter Property="OverridesDefaultStyle" Value="true" />
		    <Setter Property="Padding" Value="5" />
		    <Setter Property="Template">
			    <Setter.Value>
				    <ControlTemplate TargetType="ToolTip">
					    <Grid x:Name="Shadow">
						    <Rectangle StrokeThickness="{TemplateBinding BorderThickness}" Fill="{StaticResource TooltipShadowBackgroundBrush}" Margin="-1" RadiusX="1" RadiusY="1" Opacity="0.03" />
						    <Rectangle StrokeThickness="{TemplateBinding BorderThickness}" Fill="{StaticResource TooltipShadowBackgroundBrush}" Margin="-2" RadiusX="2" RadiusY="2" Opacity="0.03" />
						    <Rectangle StrokeThickness="{TemplateBinding BorderThickness}" Fill="{StaticResource TooltipShadowBackgroundBrush}" Margin="-3" RadiusX="3" RadiusY="3" Opacity="0.03" />
						    <Rectangle StrokeThickness="{TemplateBinding BorderThickness}" Fill="{StaticResource TooltipShadowBackgroundBrush}" Margin="-4" RadiusX="4" RadiusY="4" Opacity="0.03" />
						    <Rectangle StrokeThickness="{TemplateBinding BorderThickness}" Fill="{StaticResource TooltipShadowBackgroundBrush}" Margin="-5" RadiusX="5" RadiusY="5" Opacity="0.03" />
						    <Rectangle Stroke="{TemplateBinding BorderBrush}" Fill="{TemplateBinding Background}" StrokeThickness="{TemplateBinding BorderThickness}" />
						    <StackPanel Orientation="Horizontal">
							    <ContentPresenter Margin="{TemplateBinding Padding}" Content="{TemplateBinding Content}" />
						    </StackPanel>
					    </Grid>
				    </ControlTemplate>
			    </Setter.Value>
		    </Setter>
	    </Style>

	    <!-- *********************************  Expander Right Style  ********************************* -->
	    <Style x:Key="ExpanderRightHeaderStyle" TargetType="{x:Type ToggleButton}">
		    <Setter Property="Template">
			    <Setter.Value>
				    <ControlTemplate TargetType="{x:Type ToggleButton}">
					    <Border Padding="{TemplateBinding Padding}">
						    <Grid Background="{StaticResource TransparentBrush}" SnapsToDevicePixels="False">
							    <Grid.RowDefinitions>
								    <RowDefinition Height="19" />
								    <RowDefinition Height="*" />
							    </Grid.RowDefinitions>
							    <Grid>
								    <Grid.LayoutTransform>
									    <TransformGroup>
										    <TransformGroup.Children>
											    <TransformCollection>
												    <RotateTransform Angle="-90" />
											    </TransformCollection>
										    </TransformGroup.Children>
									    </TransformGroup>
								    </Grid.LayoutTransform>
								    <Rectangle x:Name="rectangle" Fill="{StaticResource ExpanderButtonBackgroundBrush}" RadiusX="2" RadiusY="2" HorizontalAlignment="Center" Height="19" Stroke="{StaticResource ExpanderButtonBorderBrush}" VerticalAlignment="Center" Width="19" />
								    <Path x:Name="arrow" Stretch="Fill" Width="7" Height="4" Data="M0,0 L6.8,0 3.4,3.9 z" HorizontalAlignment="Center" Fill="{StaticResource ExpanderArrowBorderBrush}" VerticalAlignment="Center" RenderTransformOrigin="0.5, 0.5" />
							    </Grid>
							    <ContentPresenter HorizontalAlignment="Center" Margin="0,4,0,0" Grid.Row="1" RecognizesAccessKey="True" SnapsToDevicePixels="True" VerticalAlignment="Stretch" />
						    </Grid>
					    </Border>
					    <ControlTemplate.Triggers>
						    <Trigger Property="IsChecked" Value="true">
							    <Setter Property="Data" TargetName="arrow" Value="M3.4,-4.4 L6.8,3.9 3.9566912E-07,3.9 z" />
						    </Trigger>
						    <Trigger Property="IsMouseOver" Value="true">
							    <Setter Property="Fill" TargetName="rectangle" Value="{StaticResource ExpanderButtonHoverBackgroundBrush}" />
							    <Setter Property="Stroke" TargetName="rectangle" Value="{StaticResource ExpanderButtonHoverBorderBrush}" />
						    </Trigger>
						    <Trigger Property="IsPressed" Value="true">
							    <Setter Property="Fill" TargetName="rectangle" Value="{StaticResource ExpanderButtonPressedBackgroundBrush}" />
							    <Setter Property="Stroke" TargetName="rectangle" Value="{StaticResource ExpanderButtonPressedBorderBrush}" />
						    </Trigger>
					    </ControlTemplate.Triggers>
				    </ControlTemplate>
			    </Setter.Value>
		    </Setter>
	    </Style>

	    <!-- *********************************  Expander Up Style  ********************************* -->
	    <Style x:Key="ExpanderUpHeaderStyle" TargetType="{x:Type ToggleButton}">
		    <Setter Property="Template">
			    <Setter.Value>
				    <ControlTemplate TargetType="{x:Type ToggleButton}">
					    <Border Padding="{TemplateBinding Padding}">
						    <Grid Background="{StaticResource TransparentBrush}" SnapsToDevicePixels="False">
							    <Grid.ColumnDefinitions>
								    <ColumnDefinition Width="19" />
								    <ColumnDefinition Width="*" />
							    </Grid.ColumnDefinitions>
							    <Grid>
								    <Grid.LayoutTransform>
									    <TransformGroup>
										    <TransformGroup.Children>
											    <TransformCollection>
												    <RotateTransform Angle="180" />
											    </TransformCollection>
										    </TransformGroup.Children>
									    </TransformGroup>
								    </Grid.LayoutTransform>
								    <Rectangle x:Name="rectangle" Fill="{StaticResource ExpanderButtonBackgroundBrush}" RadiusX="2" RadiusY="2" HorizontalAlignment="Center" Height="19" Stroke="{StaticResource ExpanderButtonBorderBrush}" VerticalAlignment="Center" Width="19" />
								    <Path x:Name="arrow" Stretch="Fill" Width="7" Height="4" Data="M0,0 L6.8,0 3.4,3.9 z" HorizontalAlignment="Center" Fill="{StaticResource ExpanderArrowBorderBrush}" VerticalAlignment="Center" RenderTransformOrigin="0.5, 0.5" />
							    </Grid>
							    <ContentPresenter Grid.Column="1" HorizontalAlignment="Stretch" Margin="4,0,0,0" RecognizesAccessKey="True" SnapsToDevicePixels="True" VerticalAlignment="Center" />
						    </Grid>
					    </Border>
					    <ControlTemplate.Triggers>
						    <Trigger Property="IsChecked" Value="true">
							    <Setter Property="Data" TargetName="arrow" Value="M3.4,-4.4 L6.8,3.9 3.9566912E-07,3.9 z" />
						    </Trigger>
						    <Trigger Property="IsMouseOver" Value="true">
							    <Setter Property="Fill" TargetName="rectangle" Value="{StaticResource ExpanderButtonHoverBackgroundBrush}" />
							    <Setter Property="Stroke" TargetName="rectangle" Value="{StaticResource ExpanderButtonHoverBorderBrush}" />
						    </Trigger>
						    <Trigger Property="IsPressed" Value="true">
							    <Setter Property="Fill" TargetName="rectangle" Value="{StaticResource ExpanderButtonPressedBackgroundBrush}" />
							    <Setter Property="Stroke" TargetName="rectangle" Value="{StaticResource ExpanderButtonPressedBorderBrush}" />
						    </Trigger>
					    </ControlTemplate.Triggers>
				    </ControlTemplate>
			    </Setter.Value>
		    </Setter>
	    </Style>

	    <!-- *********************************  Expander Left Style  ********************************* -->
	    <Style x:Key="ExpanderLeftHeaderStyle" TargetType="{x:Type ToggleButton}">
		    <Setter Property="Template">
			    <Setter.Value>
				    <ControlTemplate TargetType="{x:Type ToggleButton}">
					    <Border Padding="{TemplateBinding Padding}">
						    <Grid Background="{StaticResource TransparentBrush}" SnapsToDevicePixels="False">
							    <Grid.RowDefinitions>
								    <RowDefinition Height="19" />
								    <RowDefinition Height="*" />
							    </Grid.RowDefinitions>
							    <Grid>
								    <Grid.LayoutTransform>
									    <TransformGroup>
										    <TransformGroup.Children>
											    <TransformCollection>
												    <RotateTransform Angle="90" />
											    </TransformCollection>
										    </TransformGroup.Children>
									    </TransformGroup>
								    </Grid.LayoutTransform>
								    <Rectangle x:Name="rectangle" Fill="{StaticResource ExpanderButtonBackgroundBrush}" RadiusX="2" RadiusY="2" HorizontalAlignment="Center" Height="19" Stroke="{StaticResource ExpanderButtonBorderBrush}" VerticalAlignment="Center" Width="19" />
								    <Path x:Name="arrow" Stretch="Fill" Width="7" Height="4" Data="M0,0 L6.8,0 3.4,3.9 z" HorizontalAlignment="Center" Fill="{StaticResource ExpanderArrowBorderBrush}" VerticalAlignment="Center" RenderTransformOrigin="0.5, 0.5" />
							    </Grid>
							    <ContentPresenter Grid.Row="1" HorizontalAlignment="Center" Margin="0,4,0,0" RecognizesAccessKey="True" SnapsToDevicePixels="True" VerticalAlignment="Stretch" />
						    </Grid>
					    </Border>
					    <ControlTemplate.Triggers>
						    <Trigger Property="IsChecked" Value="true">
							    <Setter Property="Data" TargetName="arrow" Value="M3.4,-4.4 L6.8,3.9 3.9566912E-07,3.9 z" />
						    </Trigger>
						    <Trigger Property="IsMouseOver" Value="true">
							    <Setter Property="Fill" TargetName="rectangle" Value="{StaticResource ExpanderButtonHoverBackgroundBrush}" />
							    <Setter Property="Stroke" TargetName="rectangle" Value="{StaticResource ExpanderButtonHoverBorderBrush}" />
						    </Trigger>
						    <Trigger Property="IsPressed" Value="true">
							    <Setter Property="Fill" TargetName="rectangle" Value="{StaticResource ExpanderButtonPressedBackgroundBrush}" />
							    <Setter Property="Stroke" TargetName="rectangle" Value="{StaticResource ExpanderButtonPressedBorderBrush}" />
						    </Trigger>
					    </ControlTemplate.Triggers>
				    </ControlTemplate>
			    </Setter.Value>
		    </Setter>
	    </Style>

	    <!-- *********************************  Expander Down Style  ********************************* -->
	    <Style x:Key="ExpanderDownHeaderStyle" TargetType="{x:Type ToggleButton}">
		    <Setter Property="Template">
			    <Setter.Value>
				    <ControlTemplate TargetType="{x:Type ToggleButton}">
					    <Border Padding="{TemplateBinding Padding}">
						    <Grid Background="{StaticResource TransparentBrush}" SnapsToDevicePixels="False">
							    <Grid.ColumnDefinitions>
								    <ColumnDefinition Width="19" />
								    <ColumnDefinition Width="*" />
							    </Grid.ColumnDefinitions>
							    <Rectangle x:Name="rectangle" Fill="{StaticResource ExpanderButtonBackgroundBrush}" RadiusX="2" RadiusY="2" HorizontalAlignment="Center" Height="19" Stroke="{StaticResource ExpanderButtonBorderBrush}" VerticalAlignment="Center" Width="19" />
							    <Path x:Name="arrow" Stretch="Fill" Width="7" Height="4" Data="M0,0 L6.8,0 3.4,3.9 z" HorizontalAlignment="Center" Fill="{StaticResource ExpanderArrowBorderBrush}" VerticalAlignment="Center" RenderTransformOrigin="0.5, 0.5" />
							    <ContentPresenter Grid.Column="1" HorizontalAlignment="Stretch" Margin="4,0,0,0" RecognizesAccessKey="True" SnapsToDevicePixels="True" VerticalAlignment="Center" />
						    </Grid>
					    </Border>
					    <ControlTemplate.Triggers>
						    <Trigger Property="IsChecked" Value="true">
							    <Setter Property="Data" TargetName="arrow" Value="M3.4,-4.4 L6.8,3.9 3.9566912E-07,3.9 z" />
						    </Trigger>
						    <Trigger Property="IsMouseOver" Value="true">
							    <Setter Property="Fill" TargetName="rectangle" Value="{StaticResource ExpanderButtonHoverBackgroundBrush}" />
							    <Setter Property="Stroke" TargetName="rectangle" Value="{StaticResource ExpanderButtonHoverBorderBrush}" />
						    </Trigger>
						    <Trigger Property="IsPressed" Value="true">
							    <Setter Property="Fill" TargetName="rectangle" Value="{StaticResource ExpanderButtonPressedBackgroundBrush}" />
							    <Setter Property="Stroke" TargetName="rectangle" Value="{StaticResource ExpanderButtonPressedBorderBrush}" />
						    </Trigger>
					    </ControlTemplate.Triggers>
				    </ControlTemplate>
			    </Setter.Value>
		    </Setter>
	    </Style>

	    <!-- *********************************  Expander Style  ********************************* -->
	    <Style x:Key="ExpanderStyle" TargetType="{x:Type Expander}">
		    <Setter Property="BorderThickness" Value="1" />
		    <Setter Property="HorizontalContentAlignment" Value="Stretch" />
		    <Setter Property="VerticalContentAlignment" Value="Stretch" />
		    <Setter Property="Template">
			    <Setter.Value>
				    <ControlTemplate TargetType="{x:Type Expander}">
					    <Border BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}" Background="{TemplateBinding Background}" CornerRadius="3" SnapsToDevicePixels="true">
						    <DockPanel>
							    <ToggleButton x:Name="HeaderSite" ContentTemplate="{TemplateBinding HeaderTemplate}" ContentTemplateSelector="{TemplateBinding HeaderTemplateSelector}" Content="{TemplateBinding Header}" DockPanel.Dock="Top" Foreground="{TemplateBinding Foreground}" FontWeight="{TemplateBinding FontWeight}" FontStyle="{TemplateBinding FontStyle}" FontStretch="{TemplateBinding FontStretch}" FontSize="{TemplateBinding FontSize}" FontFamily="{TemplateBinding FontFamily}" HorizontalContentAlignment="{TemplateBinding HorizontalContentAlignment}" IsChecked="{Binding IsExpanded, Mode=TwoWay, RelativeSource={RelativeSource TemplatedParent}}" Margin="1" MinWidth="0" MinHeight="0" Padding="{TemplateBinding Padding}" Style="{StaticResource ExpanderDownHeaderStyle}" VerticalContentAlignment="{TemplateBinding VerticalContentAlignment}" />
							    <ContentPresenter x:Name="ExpandSite" DockPanel.Dock="Bottom" Focusable="false" HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" Margin="{TemplateBinding Padding}" Visibility="Collapsed" VerticalAlignment="{TemplateBinding VerticalContentAlignment}" />
						    </DockPanel>
					    </Border>
					    <ControlTemplate.Triggers>
						    <Trigger Property="IsExpanded" Value="true">
							    <Setter Property="Visibility" TargetName="ExpandSite" Value="Visible" />
						    </Trigger>
						    <Trigger Property="ExpandDirection" Value="Right">
							    <Setter Property="DockPanel.Dock" TargetName="ExpandSite" Value="Right" />
							    <Setter Property="DockPanel.Dock" TargetName="HeaderSite" Value="Left" />
							    <Setter Property="Style" TargetName="HeaderSite" Value="{StaticResource ExpanderRightHeaderStyle}" />
						    </Trigger>
						    <Trigger Property="ExpandDirection" Value="Up">
							    <Setter Property="DockPanel.Dock" TargetName="ExpandSite" Value="Top" />
							    <Setter Property="DockPanel.Dock" TargetName="HeaderSite" Value="Bottom" />
							    <Setter Property="Style" TargetName="HeaderSite" Value="{StaticResource ExpanderUpHeaderStyle}" />
						    </Trigger>
						    <Trigger Property="ExpandDirection" Value="Left">
							    <Setter Property="DockPanel.Dock" TargetName="ExpandSite" Value="Left" />
							    <Setter Property="DockPanel.Dock" TargetName="HeaderSite" Value="Right" />
							    <Setter Property="Style" TargetName="HeaderSite" Value="{StaticResource ExpanderLeftHeaderStyle}" />
						    </Trigger>
						    <Trigger Property="IsEnabled" Value="false">
							    <Setter Property="Foreground" Value="{StaticResource ExpanderDisabledForegroundBrush}" />
						    </Trigger>
					    </ControlTemplate.Triggers>
				    </ControlTemplate>
			    </Setter.Value>
		    </Setter>
	    </Style>

	    <!-- *********************************  ToggleButton Style  ********************************* -->
	    <Style x:Key="ToggleButtonStyle" TargetType="{x:Type ToggleButton}">
		    <Setter Property="Foreground" Value="{StaticResource ThemeLightForegroundBrush}" />
		    <Setter Property="BorderThickness" Value="1" />
		    <Setter Property="Padding" Value="2" />
		    <Setter Property="Template">
			    <Setter.Value>
				    <ControlTemplate TargetType="{x:Type ToggleButton}">
					    <Grid>
						    <VisualStateManager.VisualStateGroups>
							    <VisualStateGroup x:Name="CommonStates">
								    <VisualState x:Name="Normal" />
								    <VisualState x:Name="MouseOver">
									    <Storyboard>
										    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="hover" d:IsOptimized="True" />
									    </Storyboard>
								    </VisualState>
								    <VisualState x:Name="Pressed">
									    <Storyboard>
										    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="pressed" d:IsOptimized="True" />
									    </Storyboard>
								    </VisualState>
								    <VisualState x:Name="Disabled">
									    <Storyboard>
										    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="disabled" d:IsOptimized="True" />
									    </Storyboard>
								    </VisualState>
							    </VisualStateGroup>
							    <VisualStateGroup x:Name="CheckStates">
								    <VisualState x:Name="Checked">
									    <Storyboard>
										    <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="(UIElement.Opacity)" Storyboard.TargetName="pressed" d:IsOptimized="True" />
									    </Storyboard>
								    </VisualState>
								    <VisualState x:Name="Unchecked" />
								    <VisualState x:Name="Indeterminate" />
							    </VisualStateGroup>
							    <VisualStateGroup x:Name="FocusStates">
								    <VisualState x:Name="Focused" />
								    <VisualState x:Name="Unfocused" />
							    </VisualStateGroup>
						    </VisualStateManager.VisualStateGroups>
						    <Rectangle Fill="{StaticResource TransparentBrush}" />
						    <Rectangle x:Name="normal" Fill="{StaticResource ToggleButtonBackgroundBrush}" Stroke="{StaticResource ToggleButtonBorderBrush}" RadiusX="3" Grid.Column="1" RadiusY="3" />
						    <Rectangle x:Name="hover" Fill="{StaticResource ToggleButtonHoverBackgroundBrush}" Stroke="{StaticResource ToggleButtonHoverBorderBrush}" RadiusX="3" Grid.Column="1" RadiusY="3" Opacity="0" />
						    <Rectangle x:Name="pressed" Fill="{StaticResource ToggleButtonPressedBackgroundBrush}" Stroke="{StaticResource ToggleButtonPressedBorderBrush}" RadiusX="3" Grid.Column="1" RadiusY="3" Opacity="0" />
						    <Rectangle x:Name="disabled" Fill="{StaticResource ToggleButtonDisabledBackgroundBrush}" Stroke="{StaticResource ToggleButtonDisabledBorderBrush}" RadiusX="3" Grid.Column="1" RadiusY="3" Opacity="0" />
						    <Rectangle x:Name="focused" Fill="{StaticResource ToggleButtonFocusedBackgroundBrush}" Stroke="{StaticResource ToggleButtonFocusedBorderBrush}" RadiusX="3" Grid.Column="1" RadiusY="3" Opacity="0" />
						    <ContentPresenter x:Name="contentPresenter" ContentTemplate="{TemplateBinding ContentTemplate}" Content="{TemplateBinding Content}" HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" Margin="{TemplateBinding Padding}" VerticalAlignment="{TemplateBinding VerticalContentAlignment}" />
					    </Grid>
				    </ControlTemplate>
			    </Setter.Value>
		    </Setter>
	    </Style>
	
	    <!-- *********************************  GroupBox Style  ********************************* -->
	    <BorderGapMaskConverter x:Key="BorderGapMaskConverter" />
	    <Style x:Key="GroupBoxStyle" TargetType="{x:Type GroupBox}">
		    <Setter Property="BorderBrush" Value="{StaticResource GroupBoxBorderBrush}" />
		    <Setter Property="BorderThickness" Value="1" />
		    <Setter Property="Template">
			    <Setter.Value>
				    <ControlTemplate TargetType="{x:Type GroupBox}">
					    <Grid SnapsToDevicePixels="true">
						    <Grid.ColumnDefinitions>
							    <ColumnDefinition Width="6" />
							    <ColumnDefinition Width="Auto" />
							    <ColumnDefinition Width="*" />
							    <ColumnDefinition Width="6" />
						    </Grid.ColumnDefinitions>
						    <Grid.RowDefinitions>
							    <RowDefinition Height="Auto" />
							    <RowDefinition Height="Auto" />
							    <RowDefinition Height="*" />
							    <RowDefinition Height="6" />
						    </Grid.RowDefinitions>
						    <Border BorderBrush="{StaticResource TransparentBrush}" BorderThickness="{TemplateBinding BorderThickness}" Background="{TemplateBinding Background}" Grid.ColumnSpan="4" Grid.Column="0" CornerRadius="4" Grid.Row="1" Grid.RowSpan="3" />
						    <Border x:Name="Header" Grid.Column="1" Padding="3,1,3,0" Grid.Row="0" Grid.RowSpan="2">
							    <ContentPresenter ContentSource="Header" RecognizesAccessKey="True" SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}" />
						    </Border>
						    <ContentPresenter Grid.ColumnSpan="2" Grid.Column="1" Margin="{TemplateBinding Padding}" Grid.Row="2" SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}" />
						    <Border Grid.ColumnSpan="4" CornerRadius="4" Grid.Row="1" Grid.RowSpan="3">
							    <Border.OpacityMask>
								    <MultiBinding ConverterParameter="7" Converter="{StaticResource BorderGapMaskConverter}">
									    <Binding ElementName="Header" Path="ActualWidth" />
									    <Binding Path="ActualWidth" RelativeSource="{RelativeSource Self}" />
									    <Binding Path="ActualHeight" RelativeSource="{RelativeSource Self}" />
								    </MultiBinding>
							    </Border.OpacityMask>
							    <Border BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}" CornerRadius="3">
							    </Border>
						    </Border>
					    </Grid>
				    </ControlTemplate>
			    </Setter.Value>
		    </Setter>
	    </Style>
    
        <!--********************** Implicit Styles *********************** -->
        <Style BasedOn="{StaticResource ButtonStyle}" TargetType="{x:Type Button}" />
        <Style BasedOn="{StaticResource ScrollbarStyle}" TargetType="{x:Type ScrollBar}" />
        <Style BasedOn="{StaticResource ScrollViewerStyle}" TargetType="{x:Type ScrollViewer}" />
        <Style BasedOn="{StaticResource ComboBoxStyle}" TargetType="{x:Type ComboBox}" />
        <Style BasedOn="{StaticResource ComboBoxItemStyle}" TargetType="{x:Type ComboBoxItem}" />
        <Style BasedOn="{StaticResource TextBoxStyle}" TargetType="{x:Type TextBox}" />
        <Style BasedOn="{StaticResource ListBoxStyle}" TargetType="{x:Type ListBox}" />
        <Style BasedOn="{StaticResource ListBoxItemStyle}" TargetType="{x:Type ListBoxItem}" />
        <Style BasedOn="{StaticResource CheckBoxStyle}" TargetType="{x:Type CheckBox}" />
        <Style BasedOn="{StaticResource RadioButtonStyle}" TargetType="{x:Type RadioButton}" />
        <Style BasedOn="{StaticResource SliderStyle}" TargetType="{x:Type Slider}" />
        <Style BasedOn="{StaticResource RepeatButtonStyle}" TargetType="{x:Type RepeatButton}" />
        <Style BasedOn="{StaticResource GridSplitterStyle}" TargetType="{x:Type GridSplitter}" />
        <Style BasedOn="{StaticResource ProgressBarStyle}" TargetType="{x:Type ProgressBar}" />
        <Style BasedOn="{StaticResource PasswordBoxStyle}" TargetType="{x:Type PasswordBox}" />
        <Style BasedOn="{StaticResource ExpanderStyle}" TargetType="{x:Type Expander}" />
        <Style BasedOn="{StaticResource ToggleButtonStyle}" TargetType="{x:Type ToggleButton}" />
        <Style BasedOn="{StaticResource GroupBoxStyle}" TargetType="{x:Type GroupBox}" />
    </ResourceDictionary>
</Window.Resources>

<Grid Margin="-1,-1,1,1">
 <Button Content="Set static DHCP options (deprecated)" VerticalAlignment="Top" Margin="70,40,470,0" Name="dhcp_options" BorderBrush="#d0021b"/>
<Button Content="Export DHCP-Leases to MDTp" VerticalAlignment="Top" Margin="70,90,470,0" BorderBrush="#7ed321" Name="kgkorgaj1m5ws"/>
<TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="23" Width="171" TextWrapping="Wrap" Margin="360,40,0,0" Name="DHCPtextbox" Text="$DHCPscope"/>
<TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Margin="600,27,0,0" Name="scopeError"/>
<TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Status" Margin="70,150,0,0" Name="status"/>
<Label HorizontalAlignment="Left" VerticalAlignment="Top" Content="DHCP-Scope for MDTp (automatic detection, change if necessary):" Margin="360,9,0,0" Width="427" Height="42" Name="Dhcp_Label"/>
<Label HorizontalAlignment="Left" VerticalAlignment="Top" Content="Export DHCP-Leases to MDTp (Date will be added)" Margin="360,88,0,0" Name="export_label"/>
</Grid>
</Window>
"@

#-------------------------------------------------------------#
#----Control Event Handlers-----------------------------------#
#-------------------------------------------------------------#


#Write your code here
$DHCPscope = (Get-DhcpServerv4Scope).ScopeId

function dhcp_options_set(){ 
[System.Windows.Forms.Application]::DoEvents()
    if($DHCPtextbox.Text -eq ""){
        $scopeError.Text = "You have to provide an URL or IP"
        return
    }
    
     $scopeError.Text = ""
    
    Set-DhcpServerv4OptionValue -ScopeId $DHCPtextbox.Text -OptionId 66 -Value "MDTP"
    Set-DhcpServerv4OptionValue -ScopeId $DHCPtextbox.Text -OptionId 67 -Value "boot\x64\wdsnbp.com"
    
    $status.Text =  "Importing " + $DHCPtextbox.Text #Update the result label informing we importing
    
    $Option66 = (Get-DhcpServerv4OptionValue -ScopeId $DHCPtextbox.Text -OptionId 66).Value
    $Option67 = (Get-DhcpServerv4OptionValue -ScopeId $DHCPtextbox.Text -OptionId 67).Value
    $DHCPconverted = $DHCPtextbox.text
    if($Option66 -eq "MDTP"){
        $status.Text= "DHCP-Option for $DHCPconverted on erver: $Option66 with startoption: $Option67 has been set"
    }else{
        $status.Text= "Error, please check if DHCP-Scope is correct"
    }
}

function dhcp_leases_export(){
[System.Windows.Forms.Application]::DoEvents()
$DomainName = (Get-ADDomain).DNSRoot
$DomainReplace = ".$DomainName"
$today = Get-Date -Format yyyy_MM_dd

$credential = Get-Credential -Credential mdtp\administrator
New-PSDrive -Name P -PSProvider FileSystem -Root "\\mdtp\mdtp-import$" -Credential $credential

$status.Text = "Exporting $domainname with DHCP-Scope $DHCPscope to MDTp"
[System.Windows.Forms.Application]::DoEvents()

Get-DhcpServerv4Lease -ComputerName $domainname -ScopeId $DHCPscope | select-object Hostname, ClientId | Export-csv -path "C:\DHCP_LEASES.csv" -NoTypeInformation


$DHCP = Import-CSV C:\DHCP_LEASES.csv
foreach ($pc in $DHCP)
{
    $pc.Hostname = $pc.Hostname.replace($DomainReplace,'')
    $pc.ClientId = $pc.ClientId.replace('-', ':')
	$pc.ClientId = $pc.ClientId.toupper()

}
$DHCP | Export-CSV -Path \\mdtp\MDTp-Import$\DC_DHCP_Export_$today.csv -NoTypeInformation
$fileToCheck="\\mdtp\MDTp-Import$\DC_DHCP_Export_$today.csv"
$CSVfilecheck= Get-Content $fileToCheck
if (Test-Path $fileToCheck -PathType leaf){
        $status.Text= "Export successfull! Datapreview:           $CSVfilecheck"
    }else{
        $status.Text= "Error, please check conenction to MDTp and DNS settings"
    }


Remove-Item C:\DHCP_LEASES.csv
    
    
    
}
#endregion

#-------------------------------------------------------------#
#----Script Execution-----------------------------------------#
#-------------------------------------------------------------#

$Window = [Windows.Markup.XamlReader]::Parse($Xaml)

[xml]$xml = $Xaml

$xml.SelectNodes("//*[@Name]") | ForEach-Object { Set-Variable -Name $_.Name -Value $Window.FindName($_.Name) }


$dhcp_options.Add_Click({dhcp_options_set $this $_})
$kgkorgaj1m5ws.Add_Click({dhcp_leases_export $this $_})

$Window.ShowDialog()