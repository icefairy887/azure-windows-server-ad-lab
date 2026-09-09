[CmdletBinding(SupportsShouldProcess)]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Lab = Import-PowerShellDataFile (Join-Path $PSScriptRoot '../../config/lab.config.psd1')
$Azure = $Lab.Azure

$Existing = Get-AzPublicIpAddress `
    -Name $Azure.PublicIpName `
    -ResourceGroupName $Azure.ResourceGroupName `
    -ErrorAction SilentlyContinue

if ($Existing) {
    Write-Host "Public IP resource '$($Azure.PublicIpName)' already exists."
    return
}

if ($PSCmdlet.ShouldProcess($Azure.PublicIpName, 'Create standard static public IP resource')) {
    New-AzPublicIpAddress `
        -Name $Azure.PublicIpName `
        -ResourceGroupName $Azure.ResourceGroupName `
        -Location $Azure.Location `
        -AllocationMethod Static `
        -Sku Standard
}

