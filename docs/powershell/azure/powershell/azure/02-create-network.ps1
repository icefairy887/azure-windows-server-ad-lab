# Creates the virtual network and subnet for the Active Directory lab.

$ResourceGroupName = "rg-adlab"
$Location = "centralus"
$VirtualNetworkName = "vnet-adlab"
$SubnetName = "snet-ad"

$Subnet = New-AzVirtualNetworkSubnetConfig `
    -Name $SubnetName `
    -AddressPrefix "10.10.1.0/24"

New-AzVirtualNetwork `
    -Name $VirtualNetworkName `
    -ResourceGroupName $ResourceGroupName `
    -Location $Location `
    -AddressPrefix "10.10.0.0/16" `
    -Subnet $Subnet
