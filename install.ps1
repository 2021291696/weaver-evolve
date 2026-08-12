# weaver-evolve dual-platform skill installer (PowerShell)
# Usage: .\install.ps1 [-Platform Codex|Claude|All] [-Force] [-DryRun]
param(
  [ValidateSet("Codex", "Claude", "All")]
  [string]$Platform = "All",
  [switch]$Force,
  [switch]$DryRun
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$CodexSkillsDir = if ($env:CODEX_SKILLS) { $env:CODEX_SKILLS } else { Join-Path $HOME ".agents\skills" }
$ClaudeSkillsDir = if ($env:CLAUDE_SKILLS) { $env:CLAUDE_SKILLS } else { Join-Path $HOME ".claude\skills" }
$Skills = @("weaver-自我迭代", "file-tidy", "memory-keeper", "debug-architect")

function Install-SkillSet {
  param(
    [string]$Label,
    [string]$SourceRoot,
    [string]$TargetRoot
  )

  Write-Host "--- $Label ---"
  Write-Host "Source: $SourceRoot"
  Write-Host "Target: $TargetRoot"

  if ($DryRun) {
    foreach ($Skill in $Skills) {
      Write-Host "  [dry-run] $Skill"
    }
    Write-Host ""
    return
  }

  New-Item -ItemType Directory -Path $TargetRoot -Force | Out-Null
  $Installed = 0
  $Skipped = 0

  foreach ($Skill in $Skills) {
    $Source = Join-Path $SourceRoot $Skill
    $Target = Join-Path $TargetRoot $Skill

    if (-not (Test-Path -LiteralPath $Source -PathType Container)) {
      throw "Missing source skill: $Source"
    }

    if ((Test-Path -LiteralPath $Target) -and (-not $Force)) {
      Write-Host "  SKIP $Skill (already exists; use -Force to overwrite)"
      $Skipped++
      continue
    }

    if (Test-Path -LiteralPath $Target) {
      Remove-Item -LiteralPath $Target -Recurse -Force
    }
    Copy-Item -LiteralPath $Source -Destination $Target -Recurse
    Write-Host "  OK   $Skill"
    $Installed++
  }

  Write-Host "Result: $Installed installed, $Skipped skipped"
  Write-Host ""
}

Write-Host "=== weaver-evolve installer ==="
Write-Host "Platform: $Platform"
Write-Host ""

if ($Platform -in @("Codex", "All")) {
  Install-SkillSet -Label "OpenAI Codex" -SourceRoot (Join-Path $ScriptDir "skills\codex") -TargetRoot $CodexSkillsDir
}

if ($Platform -in @("Claude", "All")) {
  Install-SkillSet -Label "Claude Code" -SourceRoot (Join-Path $ScriptDir "skills") -TargetRoot $ClaudeSkillsDir
}
