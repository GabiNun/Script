$ProgressPreference = 'SilentlyContinue'

irm github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -out DesktopAppInstaller.msixbundle
irm github.com/microsoft/winget-cli/releases/latest/download/DesktopAppInstaller_Dependencies.zip -Out DesktopAppInstaller_Dependencies.zip

Expand-Archive DesktopAppInstaller_Dependencies.zip
Add-AppxPackage DesktopAppInstaller.msixbundle -DependencyPath DesktopAppInstaller_Dependencies\x64\*
Remove-Item DesktopAppInstaller*

irm https://github.com/GabiNun/script/raw/main/Registry/Registry.ps1 | iex
irm https://github.com/GabiNun/script/raw/main/Glazewm/Glazewm.ps1 | iex

attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Accessibility"
attrib +h "$Env:ProgramData\Microsoft\Windows\Start Menu\Programs\Notepad.lnk"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk"
attrib +h "$Env:ProgramData\Microsoft\Windows\Start Menu\Programs\Calculator.lnk"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk"
attrib +h "$Env:ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\System Tools\Character Map.lnk"
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
attrib +h "$Home\.glzr"
attrib +h "C:\Windows.old"
attrib -h "$Home\AppData"

powercfg /Hibernate Off
powercfg /Setactive (powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Select-String "Power Scheme GUID").Line.Split()[3]

mspaint.exe /uninstall
SnippingTool.exe /uninstall

$Version = (Get-AppxPackage Microsoft.MicrosoftEdge.Stable).Version
New-Item C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe -Force | Out-Null
Start-Process "C:\Program Files (x86)\Microsoft\Edge\Application\$Version\Installer\setup.exe" -ArgumentList '--uninstall --system-level --force-uninstall --delete-profile' -Wait

Stop-Process -Name SearchHost,*Edge* -Force
Remove-Item "C:\Program Files (x86)\Microsoft" -Recurse -Force

Dism /Online /Disable-Feature /FeatureName:Microsoft-RemoteDesktopConnection /NoRestart | Out-Null
Dism /Online /Enable-Feature /FeatureName:Microsoft-Hyper-V-All /NoRestart | Out-Null

Unregister-ScheduledTask -Confirm:$False
Get-CimInstance Win32_PageFileSetting | Remove-CimInstance
