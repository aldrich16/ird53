
New-NetFirewallRule -DisplayName "Permitir RDP" -Direction Inbound -Protocol TCP -LocalPort 3389 -Action Allow
New-NetFirewallRule -DisplayName "Bloquear FTP Saliente" -Direction Outbound -Protocol TCP -LocalPort 21 -Action Block
Enable-NetFirewallRule -DisplayName "File and Printer Sharing"
Remove-NetFirewallRule -DisplayName "ReglaPrueba"
Get-NetFirewallRule | Where-Object { $_.Enabled -eq "True" -and $_.Profile -eq "Domain" }
New-NetFirewallRule -DisplayName "Permitir HTTP en red privada" -Direction Inbound -Protocol TCP -LocalPort 80 -Action Allow -Profile Private
Export-WindowsFirewallRules -FilePath "C:\RespaldoFirewall.wfw"
Import-WindowsFirewallRules -FilePath "C:\RespaldoFirewall.wfw"
Get-NetFirewallRule | Where-Object {
    ($_ | Get-NetFirewallPortFilter).LocalPort -eq 1433 -and
    ($_.Action -eq "Allow")
}
Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled True
