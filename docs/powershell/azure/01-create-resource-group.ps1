# Creates the Azure resource group for the Active Directory lab.

$ResourceGroupName = "rg-adlab"
$Location = "centralus"

New-AzResourceGroup `
    -Name $ResourceGroupName `
    -Location $Location
