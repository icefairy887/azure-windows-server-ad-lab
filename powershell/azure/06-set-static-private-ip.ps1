[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Lab = Import-PowerShellDataFile (Join-Path $PSScriptRoot '../../config/lab.config.psd1')
$Azure = $Lab.Azure

$Nic = Get-AzNetworkInterface `
    -Name $Azure.NetworkInterface `
    -ResourceGroupName $Azure.ResourceGroupName

$IpConfig = $Nic.IpConfigurations[0]
if ($IpConfig.PrivateIpAllocationMethod -eq 'Static' -and
    $IpConfig.PrivateIpAddress -eq $Azure.PrivateIpAddress) {
    Write-Host "NIC already uses static private IP $($Azure.PrivateIpAddress)."
    return
}

if ($PSCmdlet.ShouldProcess($Azure.NetworkInterface, "Set static private IP to $($Azure.PrivateIpAddress)")) {
    $IpConfig.PrivateIpAllocationMethod = 'Static'
    $IpConfig.PrivateIpAddress = $Azure.PrivateIpAddress
    $Nic | Set-AzNetworkInterface
}

