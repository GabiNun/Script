$ProgressPreference = 'SilentlyContinue'

Install-PackageProvider -Name NuGet -Force | Out-Null
Install-Module Microsoft.WinGet.Client -Force
Repair-WinGetPackageManager

irm github.com/GabiNun/Script/raw/ltsc/Registry.reg -Out Registry.reg
irm github.com/GabiNun/Script/raw/main/Glazewm/config.yaml -Out C:\Windows\config.yaml
irm github.com/GabiNun/Script/raw/main/Glazewm/glazewm.exe -Out C:\Windows\glazewm.exe
irm github.com/GabiNun/Script/raw/main/Glazewm/vcruntime140.dll -Out C:\Windows\vcruntime140.dll
irm github.com/GabiNun/Script/raw/main/Glazewm/glazewm-watcher.exe -Out C:\Windows\glazewm-watcher.exe

Start-Process regedit.exe -ArgumentList '/s Registry.reg'
Start-Process glazewm.exe
Start-Process mspaint.exe /uninstall
Start-Process SnippingTool.exe /uninstall

Remove-Item Registry.reg

attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Accessibility"
attrib +h "$Env:ProgramData\Microsoft\Windows\Start Menu\Programs\Notepad.lnk"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk"
attrib +h "$Env:ProgramData\Microsoft\Windows\Start Menu\Programs\Calculator.lnk"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk"
attrib +h "$Env:Public"
attrib +h "$Home\Favorites"
attrib +h "$Home\Links"
attrib +h "$Home\Music"
attrib +h "$Home\Pictures"
attrib +h "$Home\Saved Games"
attrib +h "$Home\Searches"
attrib +h "$Home\Videos"
attrib +h "$Home\Documents"
attrib +h "$Home\Contacts"
attrib +h "C:\PerfLogs"
attrib +h "C:\Windows.old"
attrib -h "$Home\AppData"

powercfg /Hibernate Off
powercfg /Setactive (powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Select-String "Power Scheme GUID").Line.Split()[3]

New-Item C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe -Force | Out-Null
Start-Process "C:\Program Files (x86)\Microsoft\Edge\Application\*\Installer\setup.exe" -ArgumentList '--uninstall --system-level --force-uninstall --delete-profile' -Wait

Stop-Process -Name SearchHost,*Edge* -Force
Remove-Item "C:\Program Files (x86)\Microsoft" -Recurse -Force

Dism /Online /Disable-Feature /FeatureName:Microsoft-RemoteDesktopConnection /NoRestart | Out-Null
Dism /Online /Enable-Feature /FeatureName:Microsoft-Hyper-V-All /NoRestart | Out-Null

Unregister-ScheduledTask -Confirm:$False
Get-CimInstance Win32_PageFileSetting | Remove-CimInstance

Stop-Process -Name Explorer
