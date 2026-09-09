[CmdletBinding(SupportsShouldProcess)]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Import-Module ActiveDirectory
$Lab = Import-PowerShellDataFile (Join-Path $PSScriptRoot '../../config/lab.config.psd1')
$Ad = $Lab.ActiveDirectory
$DomainDn = (Get-ADDomain).DistinguishedName
$RootDn = "OU=$($Ad.RootOuName),$DomainDn"

$Root = Get-ADOrganizationalUnit `
    -LDAPFilter "(ou=$($Ad.RootOuName))" `
    -SearchBase $DomainDn `
    -SearchScope OneLevel `
    -ErrorAction SilentlyContinue

if (-not $Root -and $PSCmdlet.ShouldProcess($DomainDn, "Create root OU $($Ad.RootOuName)")) {
    New-ADOrganizationalUnit `
        -Name $Ad.RootOuName `
        -Path $DomainDn `
        -ProtectedFromAccidentalDeletion $true | Out-Null
}

foreach ($OuName in $Ad.ChildOus) {
    $Existing = Get-ADOrganizationalUnit `
        -LDAPFilter "(ou=$OuName)" `
        -SearchBase $RootDn `
        -SearchScope OneLevel `
        -ErrorAction SilentlyContinue

    if (-not $Existing -and $PSCmdlet.ShouldProcess($RootDn, "Create child OU $OuName")) {
        New-ADOrganizationalUnit `
            -Name $OuName `
            -Path $RootDn `
            -ProtectedFromAccidentalDeletion $true | Out-Null
    }
}

