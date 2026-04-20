[CmdletBinding()]
param(
    [int]$QuietSeconds = 6,
    [int]$PollSeconds = 2,
    [switch]$RunInitialSync
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Expand-ConfiguredPath {
    param([string]$PathValue)

    $expanded = [Environment]::ExpandEnvironmentVariables($PathValue)
    if (-not [string]::IsNullOrWhiteSpace($expanded) -and (Test-Path $expanded)) {
        return (Resolve-Path $expanded).Path
    }

    return $null
}

$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = (Resolve-Path (Join-Path $scriptDirectory "..")).Path
$configPath = Join-Path $repoRoot ".skill-sync.json"
$syncScript = Join-Path $scriptDirectory "sync-local-skills.ps1"

if (-not (Test-Path $configPath)) {
    throw "Missing sync config: $configPath"
}

$config = Get-Content -Path $configPath -Raw -Encoding UTF8 | ConvertFrom-Json
$sourceRoots = New-Object System.Collections.Generic.List[string]
foreach ($configuredRoot in $config.sourceRoots) {
    $resolvedRoot = Expand-ConfiguredPath -PathValue $configuredRoot
    if ($null -ne $resolvedRoot) {
        $sourceRoots.Add($resolvedRoot)
    }
}

if ($sourceRoots.Count -eq 0) {
    throw "No configured skill source roots were found."
}

$watchers = New-Object System.Collections.Generic.List[System.IO.FileSystemWatcher]
$subscriptions = New-Object System.Collections.Generic.List[System.Management.Automation.PSEventJob]
$pending = $false
$syncRunning = $false
$lastEventTime = Get-Date

$onChange = {
    $script:pending = $true
    $script:lastEventTime = Get-Date
}

foreach ($root in $sourceRoots) {
    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = $root
    $watcher.IncludeSubdirectories = $true
    $watcher.EnableRaisingEvents = $true
    $watcher.NotifyFilter = [System.IO.NotifyFilters]"FileName, DirectoryName, LastWrite, CreationTime"
    $watchers.Add($watcher) | Out-Null

    $subscriptions.Add((Register-ObjectEvent -InputObject $watcher -EventName Changed -Action $onChange)) | Out-Null
    $subscriptions.Add((Register-ObjectEvent -InputObject $watcher -EventName Created -Action $onChange)) | Out-Null
    $subscriptions.Add((Register-ObjectEvent -InputObject $watcher -EventName Deleted -Action $onChange)) | Out-Null
    $subscriptions.Add((Register-ObjectEvent -InputObject $watcher -EventName Renamed -Action $onChange)) | Out-Null
}

try {
    if ($RunInitialSync) {
        & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $syncScript
        if ($LASTEXITCODE -ne 0) {
            throw "Initial sync failed with exit code $LASTEXITCODE"
        }
    }

    Write-Host "Watching local skill roots for changes..."
    while ($true) {
        Start-Sleep -Seconds $PollSeconds

        if (-not $pending -or $syncRunning) {
            continue
        }

        $idleSeconds = ((Get-Date) - $lastEventTime).TotalSeconds
        if ($idleSeconds -lt $QuietSeconds) {
            continue
        }

        $pending = $false
        $syncRunning = $true
        try {
            & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $syncScript -CommitMessage "Auto sync local skills $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
            if ($LASTEXITCODE -ne 0) {
                Write-Warning "Auto sync failed with exit code $LASTEXITCODE"
            }
        }
        finally {
            $syncRunning = $false
        }
    }
}
finally {
    foreach ($subscription in $subscriptions) {
        Unregister-Event -SubscriptionId $subscription.Id -ErrorAction SilentlyContinue
        Remove-Job -Id $subscription.Id -Force -ErrorAction SilentlyContinue
    }

    foreach ($watcher in $watchers) {
        $watcher.Dispose()
    }
}
