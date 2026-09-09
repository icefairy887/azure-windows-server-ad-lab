[CmdletBinding(SupportsShouldProcess)]
param(
    [switch]$LinkPolicies
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Import-Module ActiveDirectory
Import-Module GroupPolicy

$Lab = Import-PowerShellDataFile (Join-Path $PSScriptRoot '../../config/lab.config.psd1')
$DomainDn = (Get-ADDomain).DistinguishedName
$RootDn = "OU=$($Lab.ActiveDirectory.RootOuName),$DomainDn"

$Policies = @(
    @{ Name = 'Brookelab - Workstation Baseline'; Target = "OU=Workstations,$RootDn" },
    @{ Name = 'Brookelab - User Baseline'; Target = "OU=Users,$RootDn" },
    @{ Name = 'Brookelab - Server Baseline'; Target = "OU=Servers,$RootDn" }
)

foreach ($Policy in $Policies) {
    $Gpo = Get-GPO -Name $Policy.Name -ErrorAction SilentlyContinue
    if (-not $Gpo -and $PSCmdlet.ShouldProcess($Policy.Name, 'Create empty GPO')) {
        $Gpo = New-GPO -Name $Policy.Name -Comment 'Created by the Brookelab learning repository; settings require separate review.'
    }

    if ($LinkPolicies -and $Gpo) {
        $ExistingLink = (Get-GPInheritance -Target $Policy.Target).GpoLinks |
            Where-Object DisplayName -eq $Policy.Name

        if (-not $ExistingLink -and $PSCmdlet.ShouldProcess($Policy.Target, "Link GPO $($Policy.Name)")) {
            New-GPLink -Name $Policy.Name -Target $Policy.Target -LinkEnabled Yes | Out-Null
        }
    }
}

if (-not $LinkPolicies) {
    Write-Host 'GPO objects reviewed or created. No links were added. Use -LinkPolicies only after review.'
}

