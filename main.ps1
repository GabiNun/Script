irm https://github.com/GabiNun/Script/raw/main/Settings.ps1 | iex
irm https://github.com/GabiNun/Script/raw/main/GlazeWm.ps1 | iex
irm https://github.com/GabiNun/Script/raw/main/Packages.ps1 | iex

takeown /f C:\Windows\System32\AggregatorHost.exe | Out-Null
takeown /f C:\Windows\System32\SmartScreen.exe | Out-Null
takeown /f C:\Windows\System32\NgcIso.exe | Out-Null
takeown /f C:\Windows\System32\LsaIso.exe | Out-Null

icacls C:\Windows\System32\AggregatorHost.exe /deny Administrators:F | Out-Null
icacls C:\Windows\System32\SmartScreen.exe /deny Administrators:F | Out-Null
icacls C:\Windows\System32\NgcIso.exe /deny Administrators:F | Out-Null
icacls C:\Windows\System32\LsaIso.exe /deny Administrators:F | Out-Null
