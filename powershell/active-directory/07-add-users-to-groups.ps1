[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$CsvPath = (Join-Path $PSScriptRoot '../../data/memberships.sample.csv')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Import-Module ActiveDirectory
$Memberships = Import-Csv $CsvPath

foreach ($Membership in $Memberships) {
    $User = Get-ADUser -Identity $Membership.UserSamAccountName
    $Group = Get-ADGroup -Identity $Membership.GroupSamAccountName
    $AlreadyMember = Get-ADGroupMember -Identity $Group -Recursive |
        Where-Object SamAccountName -eq $User.SamAccountName

    if ($AlreadyMember) {
        Write-Host "'$($User.SamAccountName)' is already in '$($Group.SamAccountName)'."
        continue
    }

    if ($PSCmdlet.ShouldProcess($Group.SamAccountName, "Add member $($User.SamAccountName)")) {
        Add-ADGroupMember -Identity $Group -Members $User
    }
}

