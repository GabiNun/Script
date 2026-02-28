$ProgressPreference = 'SilentlyContinue'

winget source remove msstore | Out-Null

irm https://github.com/GabiNun/script/raw/main/Registry/Registry.ps1 | iex
irm https://github.com/GabiNun/script/raw/main/Glazewm/Glazewm.ps1 | iex

$Files =
    "$Env:ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Windows Media Player Legacy.lnk",
    "$Env:ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\System Tools\Character Map.lnk",
    "$Env:ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Steps Recorder.lnk",
    "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk",
    "$Env:AppData\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk",
    "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Accessibility","Links",
    "$Env:Public","Saved Games","Videos",".glzr","Searches","Pictures","Music",
    "Documents","Contacts","OneDrive","C:\inetpub","Favorites"

foreach ($File in $Files) {
    attrib +h $File
}

powercfg /Hibernate Off
powercfg /Setactive (powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Select-String "Power Scheme GUID").Line.Split()[3]

$Appx = (Get-AppxPackage *SecHealthUI).PackageFullName
$Sid = (Get-LocalUser $Env:UserName).Sid.Value

New-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$Sid\$Appx -Force | Out-Null

$Version = (Get-AppxPackage Microsoft.MicrosoftEdge.Stable).Version
New-Item C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe -Force | Out-Null
Start-Process "C:\Program Files (x86)\Microsoft\Edge\Application\$Version\Installer\setup.exe" -ArgumentList '--uninstall --system-level --force-uninstall --delete-profile' -Wait

Stop-Process -Name SearchHost,*Edge* -Force
Remove-Item "C:\Program Files (x86)\Microsoft" -Recurse -Force

Start-Process OneDriveSetup.exe /uninstall

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

foreach ($Package in $Packages[0..($Packages.Count - 2)]) {
    Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $Package | Remove-AppxProvisionedPackage -Online | Out-Null
}

Dism /Online /Disable-Feature /FeatureName:Microsoft-RemoteDesktopConnection /NoRestart | Out-Null
Dism /Online /Enable-Feature /FeatureName:Microsoft-Hyper-V-All /NoRestart | Out-Null

Get-CimInstance Win32_PageFileSetting | Remove-CimInstance
Unregister-ScheduledTask -Confirm:$False
