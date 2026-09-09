[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
param(
    [Parameter(Mandatory)]
    [ValidatePattern('^(?:\d{1,3}\.){3}\d{1,3}$')]
    [string]$AllowedRdpSourceIp
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Lab = Import-PowerShellDataFile (Join-Path $PSScriptRoot '../../config/lab.config.psd1')
$Azure = $Lab.Azure
$SourcePrefix = "$AllowedRdpSourceIp/32"

if ($AllowedRdpSourceIp -eq '0.0.0.0') {
    throw 'RDP cannot be opened to 0.0.0.0. Supply one public IPv4 address.'
}

$Nsg = Get-AzNetworkSecurityGroup `
    -Name $Azure.NetworkSecurityGroup `
    -ResourceGroupName $Azure.ResourceGroupName `
    -ErrorAction SilentlyContinue

if (-not $Nsg) {
    $Rule = New-AzNetworkSecurityRuleConfig `
        -Name 'Allow-RDP-Admin' `
        -Description 'Allow RDP from one explicitly supplied administrator address' `
        -Access Allow `
        -Protocol Tcp `
        -Direction Inbound `
        -Priority 1000 `
        -SourceAddressPrefix $SourcePrefix `
        -SourcePortRange '*' `
        -DestinationAddressPrefix '*' `
        -DestinationPortRange 3389

    if ($PSCmdlet.ShouldProcess($Azure.NetworkSecurityGroup, "Create NSG with RDP limited to $SourcePrefix")) {
        New-AzNetworkSecurityGroup `
            -Name $Azure.NetworkSecurityGroup `
            -ResourceGroupName $Azure.ResourceGroupName `
            -Location $Azure.Location `
            -SecurityRules $Rule
    }
    return
}

$ExistingRule = $Nsg.SecurityRules | Where-Object Name -eq 'Allow-RDP-Admin'
if ($ExistingRule -and $ExistingRule.SourceAddressPrefix -eq $SourcePrefix) {
    Write-Host "NSG and restricted RDP rule already exist for $SourcePrefix."
    return
}

if ($PSCmdlet.ShouldProcess($Azure.NetworkSecurityGroup, "Set RDP source to $SourcePrefix")) {
    $Nsg | Set-AzNetworkSecurityRuleConfig `
        -Name 'Allow-RDP-Admin' `
        -Description 'Allow RDP from one explicitly supplied administrator address' `
        -Access Allow `
        -Protocol Tcp `
        -Direction Inbound `
        -Priority 1000 `
        -SourceAddressPrefix $SourcePrefix `
        -SourcePortRange '*' `
        -DestinationAddressPrefix '*' `
        -DestinationPortRange 3389 | Out-Null

    $Nsg | Set-AzNetworkSecurityGroup
}

