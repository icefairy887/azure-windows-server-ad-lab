[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
param(
    [Parameter(Mandatory)]
    [securestring]$DirectoryServicesRestoreModePassword
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Lab = Import-PowerShellDataFile (Join-Path $PSScriptRoot '../../config/lab.config.psd1')
$Ad = $Lab.ActiveDirectory

Import-Module ADDSDeployment

$ExistingDomain = Get-ADDomain -ErrorAction SilentlyContinue
if ($ExistingDomain) {
    Write-Host "This server already belongs to AD domain '$($ExistingDomain.DNSRoot)'."
    return
}

if ($PSCmdlet.ShouldProcess($env:COMPUTERNAME, "Create AD forest $($Ad.DomainName)")) {
    Install-ADDSForest `
        -DomainName $Ad.DomainName `
        -DomainNetbiosName $Ad.NetBIOSName `
        -InstallDNS `
        -SafeModeAdministratorPassword $DirectoryServicesRestoreModePassword `
        -Force
}

