$ProgressPreference = 'SilentlyContinue'

[Environment]::SetEnvironmentVariable('GLAZEWM_CONFIG_PATH','C:\Windows\config.yaml','Machine')
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run -Name Glazewm -Value glazewm.exe

Invoke-WebRequest https://github.com/GabiNun/Script/raw/main/Glazewm/config.yaml -OutFile C:\Windows\config.yaml
Invoke-WebRequest https://github.com/GabiNun/Script/raw/main/Glazewm/glazewm.exe -OutFile C:\Windows\glazewm.exe
Invoke-WebRequest https://github.com/GabiNun/Script/raw/main/Glazewm/vcruntime140.dll -OutFile C:\Windows\vcruntime140.dll
Invoke-WebRequest https://github.com/GabiNun/Script/raw/main/Glazewm/glazewm-watcher.exe -OutFile C:\Windows\glazewm-watcher.exe

Start-Process glazewm.exe
