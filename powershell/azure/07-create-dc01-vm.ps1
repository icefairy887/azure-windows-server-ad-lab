[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
param(
    [Parameter(Mandatory)]
    [pscredential]$AdministratorCredential
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Lab = Import-PowerShellDataFile (Join-Path $PSScriptRoot '../../config/lab.config.psd1')
$Azure = $Lab.Azure

$Existing = Get-AzVM `
    -Name $Azure.VmName `
    -ResourceGroupName $Azure.ResourceGroupName `
    -ErrorAction SilentlyContinue

if ($Existing) {
    Write-Host "VM '$($Azure.VmName)' already exists."
    return
}

$Nic = Get-AzNetworkInterface `
    -Name $Azure.NetworkInterface `
    -ResourceGroupName $Azure.ResourceGroupName

$Vm = New-AzVMConfig -VMName $Azure.VmName -VMSize $Azure.VmSize
$Vm = Set-AzVMOperatingSystem `
    -VM $Vm `
    -Windows `
    -ComputerName $Azure.VmName `
    -Credential $AdministratorCredential `
    -ProvisionVMAgent `
    -EnableAutoUpdate

$Vm = Set-AzVMSourceImage `
    -VM $Vm `
    -PublisherName $Azure.ImagePublisher `
    -Offer $Azure.ImageOffer `
    -Skus $Azure.ImageSku `
    -Version $Azure.ImageVersion

$Vm = Add-AzVMNetworkInterface -VM $Vm -Id $Nic.Id

if ($PSCmdlet.ShouldProcess($Azure.VmName, "Create Windows Server VM in $($Azure.Location)")) {
    New-AzVM `
        -ResourceGroupName $Azure.ResourceGroupName `
        -Location $Azure.Location `
        -VM $Vm
}

