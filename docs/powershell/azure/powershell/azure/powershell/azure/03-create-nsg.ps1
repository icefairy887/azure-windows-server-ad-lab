# Creates the Network Security Group for DC01.

$ResourceGroupName = "rg-adlab"
$Location = "centralus"
$NSGName = "nsg-dc01"

New-AzNetworkSecurityGroup `
    -Name $NSGName `
    -ResourceGroupName $ResourceGroupName `
    -Location $Location
