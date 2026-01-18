$ProgressPreference = 'SilentlyContinue'

irm github.com/GabiNun/Script/raw/main/Settings.reg -Out Script.reg;regedit /s Script.reg;Stop-Process -Name explorer;Remove-Item Script.reg

winget source remove msstore | Out-Null

irm github.com/GabiNun/Script/raw/main/Glazewm/glazewm.exe -Out C:\Windows\glazewm.exe
irm github.com/GabiNun/Script/raw/main/Glazewm/vcruntime140.dll -Out C:\Windows\vcruntime140.dll
irm github.com/GabiNun/Script/raw/main/Glazewm/glazewm-watcher.exe -Out C:\Windows\glazewm-watcher.exe

New-Item '.glzr\glazewm\config.yaml' -Value (irm 'https://pastebin.com/raw/zGgVsPFm') -Force | Out-Null

Remove-Item "C:\Windows.old","$Home\OneDrive" -Recurse -Force
Remove-Item "C:\Program Files (x86)\Microsoft.NET" -Recurse
Remove-Item "C:\ProgramData\Microsoft OneDrive" -Recurse

attrib +h "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\System Tools\Character Map.lnk"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Accessibility"
attrib +h $Env:Public
attrib +h "Saved Games"
attrib +h C:\inetpub
attrib +h .glzr
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

$Version = (Get-AppxPackage Microsoft.MicrosoftEdge.Stable).Version

New-Item "C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe" -Force | Out-Null
Start-Process "C:\Program Files (x86)\Microsoft\Edge\Application\$Version\Installer\setup.exe" -ArgumentList '--uninstall --system-level --force-uninstall --delete-profile' -Wait

Get-Process SearchHost,Widgets,Setup,*Edge* -ErrorAction SilentlyContinue | Stop-Process -Force
Remove-Item "$Env:ProgramFiles (x86)\Microsoft" -Recurse -Force

sc.exe delete edgeupdate | Out-Null
sc.exe delete edgeupdatem | Out-Null

$Appx = (Get-AppxPackage *SecHealthUI).PackageFullName;$Sid = (glu $Env:UserName).Sid.Value
New-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$Sid\$Appx -Force | Out-Null;Remove-AppxPackage $Appx

powershell -Command "foreach ($Package in (Get-ProvisionedAppPackage -Online).PackageName) {Remove-ProvisionedAppPackage -PackageName $Package -Online | Out-Null}"
powershell -Command "Get-AppxPackage | ? {!$_.IsFramework -and !$_.NonRemovable -and $_.Name -notmatch 'Notepad|Terminal'} | Remove-AppxPackage"
Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-RemoteDesktopConnection -NoRestart | Out-Null
C:\Windows\System32\OneDriveSetup /uninstall

Unregister-ScheduledTask -Confirm:$False

Disable-ComputerRestore $Env:SystemDrive
Get-CimInstance Win32_PageFileSetting | Remove-CimInstance
Get-CimInstance Win32_ShadowCopy | Remove-CimInstance
