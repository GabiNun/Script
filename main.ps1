$ProgressPreference = 'SilentlyContinue'

irm github.com/GabiNun/Script/raw/main/Settings.reg -Out Script.reg;regedit /s Script.reg;Stop-Process -Name explorer

winget source remove msstore | Out-Null

irm github.com/GabiNun/Script/raw/main/Glazewm/config.yaml -Out C:\Windows\config.yaml
irm github.com/GabiNun/Script/raw/main/Glazewm/glazewm.exe -Out C:\Windows\glazewm.exe
irm github.com/GabiNun/Script/raw/main/Glazewm/vcruntime140.dll -Out C:\Windows\vcruntime140.dll
irm github.com/GabiNun/Script/raw/main/Glazewm/glazewm-watcher.exe -Out C:\Windows\glazewm-watcher.exe
irm github.com/GabiNun/UninstallEdge/releases/latest/download/UninstallEdge.exe -Out UninstallEdge.exe

Start-Process OneDriveSetup.exe /uninstall
Start-Process UninstallEdge.exe -Wait
Start-Process glazewm.exe

attrib +h "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\System Tools\Character Map.lnk"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Accessibility"
attrib +h $Env:Public
attrib +h "Saved Games"
attrib +h C:\inetpub
attrib +h Videos
attrib +h Searches
attrib +h Pictures
attrib +h Music
attrib +h Links
attrib +h Favorites
attrib +h Documents
attrib +h Contacts
attrib -h AppData

powercfg /h off
powercfg /setactive (powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Select-String "Power Scheme GUID").Line.Split()[3]

$Appx = (Get-AppxPackage *SecHealthUI).PackageFullName;$Sid = (glu $Env:UserName).Sid.Value
New-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$Sid\$Appx -Force | Out-Null;Remove-AppxPackage $Appx

Stop-Process -Name Widgets,GameBar,SearchHost,*Edge* -Force -ErrorAction SilentlyContinue
Remove-Item "C:\Program Files (x86)\Microsoft" -Recurse -Force

foreach ($Package in (Get-ProvisionedAppPackage -Online).PackageName) {
    Dism /Online /Remove-ProvisionedAppPackage /PackageName:$Package /Quiet /NoRestart | Out-Null
}

foreach ($feature in (Get-WindowsOptionalFeature -Online | Where-Object State -eq Enabled | Where-Object FeatureName -notmatch 'Defender').FeatureName) {
    Dism /Online /Disable-Feature /FeatureName:$feature /NoRestart | Out-Null
}

Get-AppxPackage | Where-Object { -not $_.IsFramework -and -not $_.NonRemovable -and $_.Name -notmatch 'Notepad|Terminal' } | Remove-AppxPackage
Dism /Online /Enable-Feature /FeatureName:Microsoft-Hyper-V-All /All /NoRestart | Out-Null

Unregister-ScheduledTask -Confirm:$False

Disable-ComputerRestore $Env:SystemDrive
Get-CimInstance Win32_PageFileSetting | Remove-CimInstance
Get-CimInstance Win32_ShadowCopy | Remove-CimInstance

takeown /f C:\Windows\System32\SmartScreen.exe | Out-Null
takeown /f C:\Windows\System32\ctfmon.exe | Out-Null
takeown /f C:\Windows\System32\LsaIso.exe | Out-Null
icacls C:\Windows\System32\SmartScreen.exe /deny User:RX | Out-Null
icacls C:\Windows\System32\ctfmon.exe /deny User:RX | Out-Null
icacls C:\Windows\System32\LsaIso.exe /deny User:RX | Out-Null
