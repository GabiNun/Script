$ProgressPreference = 'SilentlyContinue'

irm github.com/GabiNun/Script/raw/main/Settings.reg -Out Script.reg

Regedit /s Script.reg
Stop-Process -Name Explorer

Remove-Item Script.reg
