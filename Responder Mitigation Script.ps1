# Jon Buhagiar
# 09/20/23
# Turns off security related concerns related to NBT-NS, WPAD, mDNS, IPv6, and SMBv1.

$PackageName = "Responder-Security"
$Version = "1"

# For logging of installation
$Path_Intune += "$Path_Folder\Intune"
Start-Transcript -Path "$Path_Intune\Log\$PackageName-install.log" -Force

# Disble WPAD
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WinHttpAutoProxySvc" -Name 'Start' -Value '4' -PropertyType DWORD -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" -Name 'DisableWpad' -Value '1' -PropertyType DWORD -Force

# Disable mDNS
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" -Name 'EnableMDNS' -Value '0' -PropertyType DWORD -Force

# Disable NBT-NS
$RegKey = "HKLM:SYSTEM\CurrentControlSet\services\NetBT\Parameters\Interfaces"
Get-ChildItem $RegKey | ForEach { Set-ItemProperty -Path "$RegKey\$($_.pschildname)" -Name NetbiosOptions -Value '2' -Verbose}

# Disable IPv6
Disable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip6
New-ItemProperty -Path 'HKLM:SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters' -Name 'DisabledComponents' -Value '255' -PropertyType DWORD -Force

# Disable SMBv1
If ($(Get-SmbServerConfiguration | Select-Object EnableSMB1Protocol).EnableSMB1Protocol) { Set-SmbServerConfiguration -EnableSMB1Protocol $false -confirm:$false }

# Validation file and end logging
New-Item -Path "$Path_Intune\Validation\$PackageName" -ItemType "file" -Force -Value $Version
Stop-Transcript