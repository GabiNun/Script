$ProgressPreference = 'SilentlyContinue'

irm github.com/GabiNun/Script/raw/main/Settings.reg -Out Script.reg

Regedit /s Script.reg
Stop-Process -Name Explorer

Remove-Item Script.reg

attrib +h "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\System Tools\Character Map.lnk"
attrib +h "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Steps Recorder.lnk"
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

powercfg /Hibernate Off
powercfg /SetActive (powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Select-String "Power Scheme GUID").Line.Split()[3]

winget source remove msstore | Out-Null

Unregister-ScheduledTask -Confirm:$False

Disable-ComputerRestore $Env:SystemDrive
Get-CimInstance Win32_PageFileSetting | Remove-CimInstance
Get-CimInstance Win32_ShadowCopy | Remove-CimInstance
