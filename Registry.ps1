Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value 1
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSystrayDateTimeValueName" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarBadges" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarFlashing" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowStatusbar" -Value 0

Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "ServiceKeepAlive" -Value 1
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Value 1
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiVirus" -Value 1

Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Value 0
Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold1" -Value 0
Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold2" -Value 0

Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "PromptOnSecureDesktop" -Value 0

Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "SecurityHealth"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "Glazewm" -Value "glazewm.exe"

Remove-ItemProperty -Path "HKCU:\Environment" -Name "OneDrive"
Set-ItemProperty -Path "HKCU:\Environment" -Name "GLAZEWM_CONFIG_PATH" -Value "C:\Windows\config.yaml"

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "AutomaticManagedPagefile" -Value 0
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "PagingFiles" -Value ""

Set-ItemProperty -Path "HKCU:\Software\Microsoft\Accessibility" -Name "CursorColor" -Value 0

Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsDeviceSearchHistoryEnabled" -Value 0

Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Name "AppCaptureEnabled" -Value 0

New-Item -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education" | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education" -Name "IsEducationEnvironment" -Value 1

New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "HideRecommendedSection" -Value 1

New-Item -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "HideRecommendedSection" -Value 1

Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" -Name "DisabledComponents" -Value 255

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\BootAnimation" -Name "DisableStartupSound" -Value 1
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\EditionOverrides" -Name "UserSetting_DisableStartupSound" -Value 1

New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" -Name "DisableSR" -Value 1

New-Item -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableNotificationCenter" -Value 1

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name "TimeZoneKeyName" -Value "Israel Standard Time"

Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Value 0

Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -Name "Favorites"

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Value 33554432

New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\PowerShell" | Out-Null
Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\PowerShell" -Name "EnableScripts" -Value 1
Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\PowerShell" -Name "ExecutionPolicy" -Value "Unrestricted"

Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value 1

New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Value 1

Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "Wallpaper" -Value "C:\Windows\Web\Wallpaper\ThemeD\img32.jpg"

Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -Value 1

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\BootAnimation" -Name "DisableStartupSound" -Value 0

Set-ItemProperty -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" -Name "SystemTrayChevronVisibility" -Value 0

New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Modules\GlobalSettings\Sizer" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Modules\GlobalSettings\Sizer" -Name "PageSpaceControlSizer" -Value ([byte[]](0xa0,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xec,0x03,0x00,0x00))

$Value = ([byte[]](0x30,0x00,0x00,0x00,0xfe,0xff,0xff,0xff,0x03,0x00,0x00,0x00,0x03,0x00,0x00,0x00,0x30,0x00,0x00,0x00,0x30,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x08,0x04,0x00,0x00,0x80,0x07,0x00,0x00,0x38,0x04,0x00,0x00,0x60,0x00,0x00,0x00,0x01,0x00,0x00,0x00))
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3" -Name "Settings" -Value $Value

Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\vss" -Recurse 
Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc" -Recurse 
Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Spooler" -Recurse 
Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\DiagTrack" -Recurse 
Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\webthreatdefsvc" -Recurse 
Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\webthreatdefusersvc" -Recurse 

Stop-Process -Name Explorer
