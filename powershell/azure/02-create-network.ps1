[CmdletBinding(SupportsShouldProcess)]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Lab = Import-PowerShellDataFile (Join-Path $PSScriptRoot '../../config/lab.config.psd1')
$Azure = $Lab.Azure

$Existing = Get-AzVirtualNetwork `
    -Name $Azure.VirtualNetwork `
    -ResourceGroupName $Azure.ResourceGroupName `
    -ErrorAction SilentlyContinue

if ($Existing) {
    Write-Host "Virtual network '$($Azure.VirtualNetwork)' already exists."
    return
}

$Subnet = New-AzVirtualNetworkSubnetConfig `
    -Name $Azure.SubnetName `
    -AddressPrefix $Azure.SubnetCidr

if ($PSCmdlet.ShouldProcess($Azure.VirtualNetwork, 'Create virtual network and AD subnet')) {
    New-AzVirtualNetwork `
        -Name $Azure.VirtualNetwork `
        -ResourceGroupName $Azure.ResourceGroupName `
        -Location $Azure.Location `
        -AddressPrefix $Azure.VirtualNetworkCidr `
        -Subnet $Subnet
}

