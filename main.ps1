$ProgressPreference = 'SilentlyContinue'

irm github.com/GabiNun/Script/raw/main/Settings.reg -Out Script.reg;regedit /s Script.reg;Remove-Item Script.reg

winget source remove msstore | Out-Null

irm github.com/GabiNun/Script/raw/main/Glazewm/config.yaml -Out C:\Windows\config.yaml
irm github.com/GabiNun/Script/raw/main/Glazewm/glazewm.exe -Out C:\Windows\glazewm.exe
irm github.com/GabiNun/Script/raw/main/Glazewm/vcruntime140.dll -Out C:\Windows\vcruntime140.dll
irm github.com/GabiNun/Script/raw/main/Glazewm/glazewm-watcher.exe -Out C:\Windows\glazewm-watcher.exe

Start-Process OneDriveSetup.exe /uninstall
Start-Process glazewm.exe

attrib +h "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Windows Media Player Legacy.lnk"
attrib +h "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\System Tools\Character Map.lnk"
attrib +h "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Steps Recorder.lnk"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Accessibility"
attrib +h "$Env:Public"
attrib +h "$Home\Saved Games"
attrib +h "$Home\Videos"
attrib +h "$Home\.glzr"
attrib +h "$Home\Searches"
attrib +h "$Home\Pictures"
attrib +h "$Home\Music"
attrib +h "$Home\Links"
attrib +h "$Home\Favorites"
attrib +h "$Home\Documents"
attrib +h "$Home\Contacts"
attrib +h "$Home\OneDrive"
attrib -h "$Home\AppData"
attrib +h "C:\inetpub"

powercfg /Hibernate Off
powercfg /Setactive (powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Select-String "Power Scheme GUID").Line.Split()[3]

$Appx = (Get-AppxPackage *SecHealthUI).PackageFullName
$Sid = (Get-LocalUser $Env:UserName).Sid.Value

New-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$Sid\$Appx -Force | Out-Null

New-Item "C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe" -Force | Out-Null
Start-Process "C:\Program Files (x86)\Microsoft\Edge\Application\*\Installer\setup.exe" -ArgumentList '--uninstall --system-level --force-uninstall --delete-profile' -Wait

Stop-Process -Name SearchHost,*Edge* -Force
Remove-Item "C:\Program Files (x86)\Microsoft" -Recurse -Force

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

$pm = [Windows.Management.Deployment.PackageManager, Windows.Management.Deployment, ContentType = WindowsRuntime]::new()

Stop-process -Name Widgets
foreach ($pkgName in $Packages) {
    foreach ($Package in $pm.FindPackages() | Where-Object { $_.Id.Name -eq $pkgName }) {
        $pm.RemovePackageAsync($Package.Id.FullName) | Out-Null
    }
}

foreach ($Package in (Get-ProvisionedAppPackage -Online).PackageName) {
    Dism /Online /Remove-ProvisionedAppxPackage /PackageName:$Package | Out-Null
}

Dism /Online /Disable-Feature /FeatureName:Microsoft-RemoteDesktopConnection /NoRestart | Out-Null
Dism /Online /Enable-Feature /FeatureName:Microsoft-Hyper-V-All /NoRestart | Out-Null

Unregister-ScheduledTask -Confirm:$False

Disable-ComputerRestore $Env:SystemDrive
Get-CimInstance Win32_PageFileSetting | Remove-CimInstance
Get-CimInstance Win32_ShadowCopy | Remove-CimInstance

takeown /f C:\Windows\System32\AggregatorHost.exe | Out-Null
takeown /f C:\Windows\System32\SmartScreen.exe | Out-Null
takeown /f C:\Windows\System32\LsaIso.exe | Out-Null

icacls C:\Windows\System32\AggregatorHost.exe /deny Administrators:F | Out-Null
icacls C:\Windows\System32\SmartScreen.exe /deny Administrators:F | Out-Null
icacls C:\Windows\System32\LsaIso.exe /deny Administrators:F | Out-Null

Stop-Process -Name Explorer
