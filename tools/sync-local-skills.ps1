[CmdletBinding()]
param(
    [switch]$NoPush,
    [switch]$NoPull,
    [switch]$NoPrune,
    [switch]$NoReadme,
    [switch]$Quiet,
    [string]$CommitMessage
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Write-Info {
    param([string]$Message)

    if (-not $Quiet) {
        Write-Host $Message
    }
}

function Invoke-Git {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$Arguments
    )

    $output = & git @Arguments
    if ($LASTEXITCODE -ne 0) {
        $joined = $Arguments -join " "
        throw "git $joined failed."
    }

    return $output
}

function Invoke-RobocopyMirror {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Source,
        [Parameter(Mandatory = $true)]
        [string]$Destination,
        [string[]]$ExcludeDirectories,
        [string[]]$ExcludeFiles
    )

    New-Item -ItemType Directory -Force -Path $Destination | Out-Null

    $arguments = @(
        $Source,
        $Destination,
        "/MIR",
        "/FFT",
        "/R:2",
        "/W:1",
        "/NFL",
        "/NDL",
        "/NJH",
        "/NJS",
        "/NP"
    )

    if ($ExcludeDirectories.Count -gt 0) {
        $arguments += "/XD"
        $arguments += $ExcludeDirectories
    }

    if ($ExcludeFiles.Count -gt 0) {
        $arguments += "/XF"
        $arguments += $ExcludeFiles
    }

    $null = & robocopy @arguments
    if ($LASTEXITCODE -gt 7) {
        throw "robocopy failed for $Source -> $Destination with exit code $LASTEXITCODE"
    }
}

function Expand-ConfiguredPath {
    param([string]$PathValue)

    $expanded = [Environment]::ExpandEnvironmentVariables($PathValue)
    if (-not [string]::IsNullOrWhiteSpace($expanded) -and (Test-Path $expanded)) {
        return (Resolve-Path $expanded).Path
    }

    return $null
}

function Get-ManagedSkills {
    param(
        [string[]]$SourceRoots,
        [string[]]$IgnoreNames
    )

    $skillMap = @{}

    for ($index = 0; $index -lt $SourceRoots.Count; $index += 1) {
        $root = $SourceRoots[$index]
        Write-Info "Scanning $root"

        $directories = Get-ChildItem -Path $root -Directory -Force | Sort-Object Name
        foreach ($directory in $directories) {
            if ($IgnoreNames -contains $directory.Name) {
                continue
            }

            $skillFile = Join-Path $directory.FullName "SKILL.md"
            if (-not (Test-Path $skillFile)) {
                continue
            }

            if ($skillMap.ContainsKey($directory.Name)) {
                Write-Info "Skip duplicate $($directory.Name) from $root"
                continue
            }

            $skillMap[$directory.Name] = [pscustomobject]@{
                Name = $directory.Name
                SourceDir = $directory.FullName
                SourceRoot = $root
                Precedence = $index
            }
        }
    }

    return $skillMap
}

function Update-Readme {
    param(
        [string]$RepoRoot,
        [string[]]$SourceRoots,
        [System.Collections.IEnumerable]$Skills
    )

    $lines = New-Object System.Collections.Generic.List[string]
    $lines.Add("# claude-skills")
    $lines.Add("")
    $lines.Add("Mirror of local Codex/Claude skills from this machine.")
    $lines.Add("")
    $lines.Add("This repository is kept in sync from the local skill roots below:")
    $lines.Add("")
    foreach ($root in $SourceRoots) {
        $lines.Add("- ``$root``")
    }
    $lines.Add("")
    $lines.Add("The sync order is intentional:")
    $lines.Add("")
    $lines.Add("1. Workspace skill directories win first.")
    $lines.Add("2. Installed Codex skills win next.")
    $lines.Add('3. Legacy `.agents` skills fill the rest.')
    $lines.Add("")
    $lines.Add('Duplicate directory names are de-duplicated by that precedence order. Hidden/system skill folders such as `.system` are skipped.')
    $lines.Add("")
    $lines.Add('Secret-like local artifacts are also excluded from sync, including `Zone.Identifier`, cookies, storage/session files, `.env`, token files, and private keys.')
    $lines.Add("")
    $lines.Add("## Manual Sync")
    $lines.Add("")
    $lines.Add('```powershell')
    $lines.Add("powershell -ExecutionPolicy Bypass -File .\tools\sync-local-skills.ps1")
    $lines.Add('```')
    $lines.Add("")
    $lines.Add("## Auto Sync")
    $lines.Add("")
    $lines.Add('```powershell')
    $lines.Add("powershell -ExecutionPolicy Bypass -File .\tools\install-sync-task.ps1")
    $lines.Add('```')
    $lines.Add("")
    $lines.Add("That installs a local watcher which listens for file changes in the configured skill roots and pushes updates to GitHub automatically.")
    $lines.Add("")
    $lines.Add("## Install All Skills Locally")
    $lines.Add("")
    $lines.Add('```bash')
    $lines.Add("./install.sh")
    $lines.Add('```')
    $lines.Add("")
    $lines.Add("## Synced Skill Directories")
    $lines.Add("")
    $lines.Add("| Skill | Source Root |")
    $lines.Add("|-------|-------------|")
    foreach ($skill in ($Skills | Sort-Object Name)) {
        $sourceName = $skill.SourceRoot.Replace($env:USERPROFILE, "%USERPROFILE%")
        $lines.Add("| [$($skill.Name)](./$($skill.Name)) | $sourceName |")
    }
    $lines.Add("")
    $lines.Add('The README is regenerated by `tools/sync-local-skills.ps1` on every sync.')
    $lines.Add("")

    $readmePath = Join-Path $RepoRoot "README.md"
    [System.IO.File]::WriteAllLines($readmePath, $lines, [System.Text.UTF8Encoding]::new($false))
}

$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = (Resolve-Path (Join-Path $scriptDirectory "..")).Path
$configPath = Join-Path $repoRoot ".skill-sync.json"

if (-not (Test-Path $configPath)) {
    throw "Missing sync config: $configPath"
}

$config = Get-Content -Path $configPath -Raw -Encoding UTF8 | ConvertFrom-Json
$branch = if ($config.branch) { [string]$config.branch } else { "master" }
$ignoreNames = @($config.ignoreNames)
$excludeDirectories = @($config.excludeDirectories)
$excludeFiles = @($config.excludeFiles)

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

$managedSkills = Get-ManagedSkills -SourceRoots $sourceRoots -IgnoreNames $ignoreNames
if ($managedSkills.Count -eq 0) {
    throw "No skill directories with SKILL.md were found in the configured roots."
}

Push-Location $repoRoot
try {
    $null = Invoke-Git -Arguments @("checkout", $branch)

    if (-not $NoPull) {
        Write-Info "Pulling latest $branch"
        $null = Invoke-Git -Arguments @("pull", "--rebase", "--autostash", "origin", $branch)
    }

    foreach ($skill in ($managedSkills.Values | Sort-Object Name)) {
        $destination = Join-Path $repoRoot $skill.Name
        Write-Info "Sync $($skill.Name)"
        Invoke-RobocopyMirror -Source $skill.SourceDir -Destination $destination -ExcludeDirectories $excludeDirectories -ExcludeFiles $excludeFiles
    }

    if (-not $NoPrune) {
        $repoSkillDirs = Get-ChildItem -Path $repoRoot -Directory -Force | Where-Object {
            $_.Name -ne ".git" -and $_.Name -ne "tools" -and (Test-Path (Join-Path $_.FullName "SKILL.md"))
        }

        foreach ($repoSkillDir in $repoSkillDirs) {
            if (-not $managedSkills.ContainsKey($repoSkillDir.Name)) {
                Write-Info "Remove stale skill $($repoSkillDir.Name)"
                Remove-Item -LiteralPath $repoSkillDir.FullName -Recurse -Force
            }
        }
    }

    if (-not $NoReadme) {
        Update-Readme -RepoRoot $repoRoot -SourceRoots $sourceRoots -Skills $managedSkills.Values
    }

    $status = Invoke-Git -Arguments @("status", "--porcelain")
    if (-not $status) {
        Write-Info "No skill changes detected."
        return
    }

    $null = Invoke-Git -Arguments @("add", "-A")

    if ([string]::IsNullOrWhiteSpace($CommitMessage)) {
        $CommitMessage = "Sync local skills $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    }

    $null = Invoke-Git -Arguments @("commit", "-m", $CommitMessage)

    if (-not $NoPush) {
        Write-Info "Push to origin/$branch"
        $null = Invoke-Git -Arguments @("push", "origin", $branch)
    }
}
finally {
    Pop-Location
}
