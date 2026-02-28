irm https://github.com/GabiNun/script/raw/main/Registry/Registry.reg -Out Registry.reg
irm https://github.com/GabiNun/Script/raw/main/Registry/Defender.reg -Out Defender.reg

Start-Process regedit.exe -ArgumentList '/s Registry.reg'

Register-ScheduledTask -TaskName Defender -Action (New-ScheduledTaskAction -Execute regedit.exe -Argument "/s $Home\Defender.reg") -User "NT SERVICE\TrustedInstaller" | Out-Null
Start-ScheduledTask -TaskName Defender

Remove-Item Registry.reg
Remove-Item Defender.reg

Stop-Process -Name Explorer
