irm github.com/GabiNun/Script/raw/main/Settings.reg -Out Script.reg;regedit /s Script.reg;Stop-Process -Name explorer;Remove-Item Script.reg

winget source remove msstore | Out-Null

$ProgressPreference = 0
irm github.com/GabiNun/Script/raw/main/glazewm.exe -Out C:\Windows\glazewm.exe
irm github.com/GabiNun/Script/raw/main/vcruntime140.dll -Out C:\Windows\vcruntime140.dll
irm github.com/GabiNun/Script/raw/main/glazewm-watcher.exe -Out C:\Windows\glazewm-watcher.exe
 
New-Item .glzr\glazewm\config.yaml -Value (irm 'https://pastebin.com/raw/zGgVsPFm') -Force | Out-Null

Remove-Item "$Home\OneDrive","C:\Windows.old" -Recurse -Force
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

powercfg /setactive (powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Select-String "Power Scheme GUID").Line.Split()[3]
powercfg /change monitor-timeout-ac 60

$Version = (Get-AppxPackage Microsoft.MicrosoftEdge.Stable).Version

New-Item "C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe" -Force | Out-Null
& "C:\Program Files (x86)\Microsoft\Edge\Application\$Version\Installer\setup.exe" --uninstall --system-level --force-uninstall --delete-profile

$Appx = (Get-AppxPackage *SecHealthUI).PackageFullName;$Sid = (glu $Env:UserName).Sid.Value
New-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$Sid\$Appx -Force | Out-Null;Remove-AppxPackage $Appx

Stop-Process -Name Widgets -ErrorAction Ignore
Get-AppxPackage | ? {!$_.IsFramework -and !$_.NonRemovable -and $_.Name -notmatch 'Notepad|terminal'} | Remove-AppxPackage
Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-RemoteDesktopConnection -NoRestart | Out-Null
C:\Windows\System32\OneDriveSetup /uninstall

Get-Process SearchHost,Setup,*Edge* | Stop-Process -Force
Remove-Item "$Env:ProgramFiles (x86)\Microsoft" -Recurse -Force

sc.exe delete edgeupdate | Out-Null
sc.exe delete edgeupdatem | Out-Null

Unregister-ScheduledTask -Confirm:$False
