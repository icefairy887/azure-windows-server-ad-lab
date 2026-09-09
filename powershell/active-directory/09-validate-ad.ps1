[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Import-Module ActiveDirectory
Import-Module DnsServer
Import-Module GroupPolicy

$Lab = Import-PowerShellDataFile (Join-Path $PSScriptRoot '../../config/lab.config.psd1')
$Domain = Get-ADDomain
$Forest = Get-ADForest
$RootDn = "OU=$($Lab.ActiveDirectory.RootOuName),$($Domain.DistinguishedName)"

[pscustomobject]@{
    Check = 'Domain'
    Expected = $Lab.ActiveDirectory.DomainName
    Actual = $Domain.DNSRoot
    Passed = $Domain.DNSRoot -eq $Lab.ActiveDirectory.DomainName
}

[pscustomobject]@{
    Check = 'Forest'
    Expected = $Lab.ActiveDirectory.DomainName
    Actual = $Forest.Name
    Passed = $Forest.Name -eq $Lab.ActiveDirectory.DomainName
}

[pscustomobject]@{
    Check = 'Domain controller'
    Expected = $Lab.Azure.VmName
    Actual = (Get-ADDomainController -Discover).HostName
    Passed = (Get-ADDomainController -Discover).Name -eq $Lab.Azure.VmName
}

foreach ($OuName in @($Lab.ActiveDirectory.RootOuName) + $Lab.ActiveDirectory.ChildOus) {
    $SearchBase = if ($OuName -eq $Lab.ActiveDirectory.RootOuName) { $Domain.DistinguishedName } else { $RootDn }
    $Ou = Get-ADOrganizationalUnit -LDAPFilter "(ou=$OuName)" -SearchBase $SearchBase -SearchScope OneLevel -ErrorAction SilentlyContinue
    [pscustomobject]@{
        Check = "OU: $OuName"
        Expected = 'Present'
        Actual = if ($Ou) { 'Present' } else { 'Missing' }
        Passed = [bool]$Ou
    }
}

$Dns = Get-Service DNS
[pscustomobject]@{
    Check = 'DNS service'
    Expected = 'Running'
    Actual = $Dns.Status
    Passed = $Dns.Status -eq 'Running'
}

Get-GPO -All | Where-Object DisplayName -like 'Brookelab -*' |
    Select-Object @{ Name = 'Check'; Expression = { "GPO: $($_.DisplayName)" } },
                  @{ Name = 'Expected'; Expression = { 'Present' } },
                  @{ Name = 'Actual'; Expression = { 'Present' } },
                  @{ Name = 'Passed'; Expression = { $true } }

