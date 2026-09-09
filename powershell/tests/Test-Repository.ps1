[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
$Failures = [System.Collections.Generic.List[string]]::new()

$RequiredPaths = @(
    'README.md',
    'SECURITY.md',
    'config/lab.config.psd1',
    'docs/01-architecture.md',
    'docs/02-azure-infrastructure.md',
    'docs/03-windows-server.md',
    'docs/04-active-directory.md',
    'docs/05-users-groups-ous.md',
    'docs/06-group-policy.md',
    'docs/07-validation.md',
    'docs/troubleshooting.md',
    'powershell/azure/07-create-dc01-vm.ps1',
    'powershell/active-directory/09-validate-ad.ps1',
    'review-notes/REVIEW_NOTES.txt'
)

foreach ($RelativePath in $RequiredPaths) {
    if (-not (Test-Path (Join-Path $RepoRoot $RelativePath))) {
        $Failures.Add("Missing required path: $RelativePath")
    }
}

$Scripts = Get-ChildItem (Join-Path $RepoRoot 'powershell') -Filter '*.ps1' -Recurse
foreach ($Script in $Scripts) {
    $Tokens = $null
    $ParseErrors = $null
    [void][System.Management.Automation.Language.Parser]::ParseFile(
        $Script.FullName,
        [ref]$Tokens,
        [ref]$ParseErrors
    )

    foreach ($ParseError in $ParseErrors) {
        $Failures.Add("PowerShell parse error in $($Script.FullName): $($ParseError.Message)")
    }
}

$SensitiveFiles = Get-ChildItem (Join-Path $RepoRoot 'powershell'), (Join-Path $RepoRoot 'config'), (Join-Path $RepoRoot 'data') -Recurse -File
$ForbiddenPatterns = @(
    '-----BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY-----',
    '(?i)(api[_-]?key|token|password)\s*=\s*["''][^"'']{8,}["'']',
    '(?i)SourceAddressPrefix\s+["'']0\.0\.0\.0/0["'']'
)

foreach ($File in $SensitiveFiles) {
    $Content = Get-Content $File.FullName -Raw
    foreach ($Pattern in $ForbiddenPatterns) {
        if ($Content -match $Pattern) {
            $Failures.Add("Possible secret or unsafe network rule in $($File.FullName): $Pattern")
        }
    }
}

if ($Failures.Count -gt 0) {
    $Failures | ForEach-Object { Write-Error $_ }
    throw "Repository validation failed with $($Failures.Count) finding(s)."
}

Write-Host "Repository validation passed: $($Scripts.Count) PowerShell scripts parsed and required files were found."

