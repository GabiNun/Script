irm https://github.com/GabiNun/script/raw/main/Registry/Defender.reg -Out Registry.reg
irm https://github.com/GabiNun/Script/raw/main/Registry/Defender.reg -Out Defender.reg

Start-Process regedit.exe -ArgumentList '/s Registry.reg'
