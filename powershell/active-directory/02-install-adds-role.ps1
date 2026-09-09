[CmdletBinding(SupportsShouldProcess)]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Feature = Get-WindowsFeature -Name AD-Domain-Services
if ($Feature.Installed) {
    Write-Host 'Active Directory Domain Services is already installed.'
    return
}

if ($PSCmdlet.ShouldProcess($env:COMPUTERNAME, 'Install AD DS and management tools')) {
    Install-WindowsFeature `
        -Name AD-Domain-Services `
        -IncludeManagementTools
}

