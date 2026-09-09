# Creates the public IP used to reach DC01 over RDP.

$ResourceGroupName = "rg-adlab"
$Location = "centralus"
$PublicIPName = "pip-dc01"

New-AzPublicIpAddress `
    -Name $PublicIPName `
    -ResourceGroupName $ResourceGroupName `
    -Location $Location `
    -AllocationMethod Static `
    -Sku Standard
