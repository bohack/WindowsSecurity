# Jon Buhagiar
# 11/1/22
# Disable SMBv1

If ($(Get-SmbServerConfiguration | Select-Object EnableSMB1Protocol).EnableSMB1Protocol) { Set-SmbServerConfiguration -EnableSMB1Protocol $false -confirm:$false }
