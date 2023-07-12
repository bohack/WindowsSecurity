# Jon Buhagiar
# 03/03/23
# Disable IPv6 and components
# https://learn.microsoft.com/en-US/troubleshoot/windows-server/networking/configure-ipv6-in-windows#use-registry-key-to-configure-ipv6

$Regkey = 'HKLM:SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters'
$Name = 'DisabledComponents'
$Value = '255'
$Exclude = 'computername'

Disable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip6

#check if it is not a VPN
If (-not ($env:computername -match $Exclude)) {
	New-ItemProperty -Path $Regkey -Name $Name -Value $Value -PropertyType DWORD -Force
	}
