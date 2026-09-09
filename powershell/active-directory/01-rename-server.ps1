[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
param(
    [switch]$Restart
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Lab = Import-PowerShellDataFile (Join-Path $PSScriptRoot '../../config/lab.config.psd1')
$TargetName = $Lab.Azure.VmName

if ($env:COMPUTERNAME -eq $TargetName) {
    Write-Host "Computer is already named '$TargetName'."
    return
}

if ($PSCmdlet.ShouldProcess($env:COMPUTERNAME, "Rename computer to $TargetName")) {
    Rename-Computer -NewName $TargetName -Force
    Write-Host 'Rename completed. A restart is required.'

    if ($Restart) {
        Restart-Computer -Force
    }
}

