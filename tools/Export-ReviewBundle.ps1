[CmdletBinding()]
param(
    [string]$OutputPath = (Join-Path $PSScriptRoot '../review-bundle.txt')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$ResolvedOutput = [System.IO.Path]::GetFullPath($OutputPath)
$AllowedExtensions = @('.md', '.txt', '.ps1', '.psd1', '.csv', '.json', '.yml', '.yaml')

$Files = Get-ChildItem -Path $RepoRoot -Recurse -File |
    Where-Object {
        $_.Extension -in $AllowedExtensions -and
        $_.FullName -ne $ResolvedOutput -and
        $_.FullName -notmatch '[\\/]\.git[\\/]'
    } |
    Sort-Object FullName

$Builder = [System.Text.StringBuilder]::new()
[void]$Builder.AppendLine('AZURE ACTIVE DIRECTORY LAB - REVIEW BUNDLE')
[void]$Builder.AppendLine("Generated: $(Get-Date -Format o)")
[void]$Builder.AppendLine('This bundle contains repository text only. It does not prove deployment.')

foreach ($File in $Files) {
    $RelativePath = [System.IO.Path]::GetRelativePath($RepoRoot, $File.FullName)
    [void]$Builder.AppendLine()
    [void]$Builder.AppendLine(('=' * 80))
    [void]$Builder.AppendLine("FILE: $RelativePath")
    [void]$Builder.AppendLine(('=' * 80))
    [void]$Builder.AppendLine((Get-Content -Path $File.FullName -Raw))
}

$Builder.ToString() | Set-Content -Path $ResolvedOutput -Encoding utf8
Write-Host "Review bundle written to: $ResolvedOutput"

