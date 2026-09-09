[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [securestring]$TemporaryPassword,

    [string]$CsvPath = (Join-Path $PSScriptRoot '../../data/users.sample.csv')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Import-Module ActiveDirectory
$Lab = Import-PowerShellDataFile (Join-Path $PSScriptRoot '../../config/lab.config.psd1')
$Domain = Get-ADDomain
$RootDn = "OU=$($Lab.ActiveDirectory.RootOuName),$($Domain.DistinguishedName)"
$Users = Import-Csv $CsvPath

foreach ($User in $Users) {
    $Existing = Get-ADUser -Identity $User.SamAccountName -ErrorAction SilentlyContinue
    if ($Existing) {
        Write-Host "User '$($User.SamAccountName)' already exists."
        continue
    }

    $TargetPath = $User.Path.Replace('{LAB_ROOT_DN}', $RootDn)
    $Upn = "$($User.SamAccountName)@$($Domain.DNSRoot)"

    if ($PSCmdlet.ShouldProcess($TargetPath, "Create user $($User.SamAccountName)")) {
        New-ADUser `
            -Name $User.DisplayName `
            -DisplayName $User.DisplayName `
            -GivenName $User.GivenName `
            -Surname $User.Surname `
            -SamAccountName $User.SamAccountName `
            -UserPrincipalName $Upn `
            -Department $User.Department `
            -Title $User.Title `
            -Path $TargetPath `
            -AccountPassword $TemporaryPassword `
            -ChangePasswordAtLogon $true `
            -Enabled $true
    }
}

