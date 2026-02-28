irm https://github.com/GabiNun/script/raw/main/Registry/Registry.reg -Out Registry.reg
Start-Process regedit.exe -ArgumentList '/s Registry.reg'

Remove-Item Registry.reg
Stop-Process -Name Explorer
