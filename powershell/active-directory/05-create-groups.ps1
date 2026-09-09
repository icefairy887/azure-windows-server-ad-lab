[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$CsvPath = (Join-Path $PSScriptRoot '../../data/groups.sample.csv')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Import-Module ActiveDirectory
$Lab = Import-PowerShellDataFile (Join-Path $PSScriptRoot '../../config/lab.config.psd1')
$DomainDn = (Get-ADDomain).DistinguishedName
$RootDn = "OU=$($Lab.ActiveDirectory.RootOuName),$DomainDn"
$Groups = Import-Csv $CsvPath

foreach ($Group in $Groups) {
    $Existing = Get-ADGroup -Identity $Group.SamAccountName -ErrorAction SilentlyContinue
    if ($Existing) {
        Write-Host "Group '$($Group.SamAccountName)' already exists."
        continue
    }

    $TargetPath = $Group.Path.Replace('{LAB_ROOT_DN}', $RootDn)
    if ($PSCmdlet.ShouldProcess($TargetPath, "Create group $($Group.SamAccountName)")) {
        New-ADGroup `
            -Name $Group.Name `
            -SamAccountName $Group.SamAccountName `
            -GroupScope $Group.Scope `
            -GroupCategory $Group.Category `
            -Description $Group.Description `
            -Path $TargetPath | Out-Null
    }
}

