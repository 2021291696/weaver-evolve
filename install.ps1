# weaver-evolve skill cluster installer (PowerShell)
# Usage: .\install.ps1 [-Force] [-DryRun]
param(
  [switch]$Force,
  [switch]$DryRun
)

$ErrorActionPreference = "Stop"
$SkillsDir = if ($env:CLAUDE_SKILLS) { $env:CLAUDE_SKILLS } else { "$env:USERPROFILE\.claude\skills" }
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

$Skills = @(
  "weaver-自我迭代",
  "file-tidy",
  "memory-keeper",
  "debug-architect",
  "skill-optimizer"
)

Write-Host "=== weaver-evolve skill cluster installer ==="
Write-Host "Target: $SkillsDir"
Write-Host ""

if ($DryRun) {
  Write-Host "[dry-run] Would install these skills:"
  foreach ($skill in $Skills) {
    Write-Host "  - $skill"
  }
  exit 0
}

$Installed = 0
$Skipped = 0
foreach ($skill in $Skills) {
  $target = Join-Path $SkillsDir $skill
  $source = Join-Path $ScriptDir $skill
  if ((Test-Path $target) -and (-not $Force)) {
    Write-Host "⚠ $skill already exists, use -Force to overwrite"
    $Skipped++
  } else {
    if (Test-Path $target) {
      Remove-Item -Recurse -Force $target
    }
    Copy-Item -Recurse $source $target
    Write-Host "✓ $skill installed"
    $Installed++
  }
}

Write-Host ""
Write-Host "Done: $Installed installed, $Skipped skipped"
