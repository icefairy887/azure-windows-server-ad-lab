[CmdletBinding(SupportsShouldProcess)]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Lab = Import-PowerShellDataFile (Join-Path $PSScriptRoot '../../config/lab.config.psd1')
$Azure = $Lab.Azure

$Existing = Get-AzResourceGroup -Name $Azure.ResourceGroupName -ErrorAction SilentlyContinue
if ($Existing) {
    Write-Host "Resource group '$($Azure.ResourceGroupName)' already exists in '$($Existing.Location)'."
    return
}

if ($PSCmdlet.ShouldProcess($Azure.ResourceGroupName, 'Create Azure resource group')) {
    New-AzResourceGroup `
        -Name $Azure.ResourceGroupName `
        -Location $Azure.Location
}

