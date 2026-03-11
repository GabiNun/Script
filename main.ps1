irm https://github.com/GabiNun/script/raw/main/Registry.ps1 | iex | Out-Null
irm https://github.com/GabiNun/script/raw/main/Glazewm/Glazewm.ps1 | iex
irm https://gist.github.com/GabiNun/329c01be57d546e5c8942861cb538e94/raw/UninstallEdge.ps1 | iex | Out-Null
(irm https://github.com/ChrisTitusTech/winutil/raw/main/config/tweaks.json).WPFTweaksRevertStartMenu.InvokeScript | iex

winget source remove msstore | Out-Null
OneDriveSetup /uninstall

attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Accessibility"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk"
attrib +h "$Env:ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\System Tools\Character Map.lnk"
attrib +h $Env:Public
attrib +h $Home\Favorites
attrib +h $Home\Links
attrib +h $Home\Music
attrib +h $Home\Pictures
attrib +h $Home\Searches
attrib +h $Home\Videos
attrib +h $Home\Documents
attrib +h $Home\Contacts
attrib +h $Home\OneDrive
attrib +h $Home\.glzr
attrib +h "$Home\Saved Games"
attrib +h C:\Windows.old
attrib +h C:\inetpub
attrib -h $Home\AppData

powercfg /Hibernate Off
powercfg /Setactive (powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Select-String 'Power Scheme GUID').Line.Split()[3]

$Packages =
    'Microsoft.WindowsCalculator',
    'Microsoft.WindowsCamera',
    'Microsoft.WindowsAlarms',
    'Microsoft.WindowsFeedbackHub',
    'Microsoft.ZuneMusic',
    'Microsoft.MicrosoftOfficeHub',
    'Microsoft.BingSearch',
    'Clipchamp.Clipchamp',
    'Microsoft.BingNews',
    'MSTeams',
    'Microsoft.WindowsNotepad',
    'Microsoft.Todos',
    'Microsoft.OutlookForWindows',
    'Microsoft.Paint',
    'Microsoft.Windows.Photos',
    'Microsoft.PowerAutomateDesktop',
    'MicrosoftCorporationII.QuickAssist',
    'Microsoft.ScreenSketch',
    'Microsoft.MicrosoftSolitaireCollection',
    'Microsoft.WindowsSoundRecorder',
    'Microsoft.MicrosoftStickyNotes',
    'Microsoft.BingWeather',
    'Microsoft.WebMediaExtensions',
    'Microsoft.GamingApp',
    'Microsoft.Xbox.TCUI',
    'Microsoft.Windows.DevHome',
    'Microsoft.GetHelp',
    'Microsoft.WindowsStore',
    'MicrosoftWindows.CrossDevice',
    'Microsoft.ApplicationCompatibilityEnhancements',
    'Microsoft.YourPhone',
    'Microsoft.XboxGamingOverlay',
    'MicrosoftWindows.Client.WebExperience',
    'Microsoft.SecHealthUI'

Get-Process -Name *Widget* | Stop-Process
foreach ($Package in $Packages) {
    Get-AppxPackage $Package | Remove-AppxPackage
}

Dism /Online /Disable-Feature /FeatureName:Microsoft-RemoteDesktopConnection /NoRestart | Out-Null
Dism /Online /Enable-Feature /FeatureName:Microsoft-Hyper-V-All /NoRestart | Out-Null

Unregister-ScheduledTask -Confirm:$False
Get-CimInstance Win32_ShadowCopy | Remove-CimInstance
Get-CimInstance Win32_PageFileSetting | Remove-CimInstance
Disable-ComputerRestore $Env:SystemDrive

Invoke-WebRequest -Uri https://github.com/Raphire/Win11Debloat/raw/master/Assets/Start/start2.bin -OutFile $Env:LocalAppData\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState\start2.bin

Stop-Process -Name explorer



