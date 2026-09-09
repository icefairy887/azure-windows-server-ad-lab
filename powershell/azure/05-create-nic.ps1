[CmdletBinding(SupportsShouldProcess)]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Lab = Import-PowerShellDataFile (Join-Path $PSScriptRoot '../../config/lab.config.psd1')
$Azure = $Lab.Azure

$Existing = Get-AzNetworkInterface `
    -Name $Azure.NetworkInterface `
    -ResourceGroupName $Azure.ResourceGroupName `
    -ErrorAction SilentlyContinue

if ($Existing) {
    Write-Host "Network interface '$($Azure.NetworkInterface)' already exists."
    return
}

$Vnet = Get-AzVirtualNetwork -Name $Azure.VirtualNetwork -ResourceGroupName $Azure.ResourceGroupName
$Subnet = Get-AzVirtualNetworkSubnetConfig -Name $Azure.SubnetName -VirtualNetwork $Vnet
$Nsg = Get-AzNetworkSecurityGroup -Name $Azure.NetworkSecurityGroup -ResourceGroupName $Azure.ResourceGroupName
$PublicIp = Get-AzPublicIpAddress -Name $Azure.PublicIpName -ResourceGroupName $Azure.ResourceGroupName

if ($PSCmdlet.ShouldProcess($Azure.NetworkInterface, 'Create NIC and attach subnet, NSG, and public IP')) {
    New-AzNetworkInterface `
        -Name $Azure.NetworkInterface `
        -ResourceGroupName $Azure.ResourceGroupName `
        -Location $Azure.Location `
        -SubnetId $Subnet.Id `
        -PublicIpAddressId $PublicIp.Id `
        -NetworkSecurityGroupId $Nsg.Id
}

