# WindowsSecurity

The following script are to be used with GPO and deployed as a startup script.

**DisableIPv6.ps1** - This script will disable IPv6 and related IPv6 components on a computer excluding the $Exclude computer. For more reference see https://learn.microsoft.com/en-US/troubleshoot/windows-server/networking/configure-ipv6-in-windows#use-registry-key-to-configure-ipv6

**TurnOff-NBT-NS.ps1** - This script will turn off NBT-NS for each adapter present in the operating system. For more information see https://woshub.com/how-to-disable-netbios-over-tcpip-and-llmnr-using-gpo/

**TurnOffSMBv1.ps1** - This script will disable the SMB v1 protocol.

 GPO
 
 Disable LLMNR
    Computer Configuration > Administrative Templates > Network > DNS Client > Turn Off Multicast Name Resolution (Enable)

 Regedit
 
  Disable WPAD
    HKLM\SYSTEM\CurrentControlSet\Services\WinHttpAutoProxySvc\Start -> 4
    HKLM\SYSTEM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp\DisableWpad -> 1

  Disable mDNS
    HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters\EnableMDNS -> 0
