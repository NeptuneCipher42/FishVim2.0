$ErrorActionPreference = 'Stop'

$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..\..")
$NvimConfigDir = Join-Path $env:LOCALAPPDATA "nvim"

function Ensure-WingetPackage {
  param(
    [string]$Id
  )
  winget install --id $Id --exact --source winget --accept-package-agreements --accept-source-agreements
}

function Set-UTF8Encoding {
  # Fix PowerShell UTF-8 encoding so Nerd Font glyphs reach Neovim correctly
  $profileDir = Split-Path $PROFILE -Parent
  if (-not (Test-Path $profileDir)) { New-Item -ItemType Directory -Force -Path $profileDir | Out-Null }
  if (-not (Test-Path $PROFILE)) { New-Item -ItemType File -Force -Path $PROFILE | Out-Null }
  $marker = '# FishVim: UTF-8 encoding for Nerd Font icons'
  if (-not (Select-String -Path $PROFILE -Pattern 'FishVim: UTF-8' -Quiet)) {
    $block = @"

$marker
`$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
"@
    Add-Content -Path $PROFILE -Value $block
    Write-Host "[FishVim] PowerShell profile updated: UTF-8 encoding enabled."
  } else {
    Write-Host "[FishVim] PowerShell profile already has UTF-8 encoding."
  }
}

function Set-WindowsTerminalNerdFont {
  # Use JetBrainsMono Nerd Font Mono (installed by bootstrap — guaranteed present)
  $wtSettings = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
  if (-not (Test-Path $wtSettings)) {
    Write-Warning "[FishVim] Windows Terminal settings not found. Please manually set font to 'JetBrainsMono Nerd Font Mono'."
    return
  }
  $json = Get-Content $wtSettings -Raw | ConvertFrom-Json
  if (-not $json.profiles) { $json | Add-Member -NotePropertyName 'profiles' -NotePropertyValue ([PSCustomObject]@{}) -Force }
  if (-not $json.profiles.defaults) { $json.profiles | Add-Member -NotePropertyName 'defaults' -NotePropertyValue ([PSCustomObject]@{}) -Force }
  if (-not $json.profiles.defaults.PSObject.Properties['font']) {
    $json.profiles.defaults | Add-Member -NotePropertyName 'font' -NotePropertyValue ([PSCustomObject]@{ face = 'JetBrainsMono Nerd Font Mono' }) -Force
  } else {
    $json.profiles.defaults.font.face = 'JetBrainsMono Nerd Font Mono'
  }
  $json | ConvertTo-Json -Depth 20 | Set-Content -Encoding UTF8 $wtSettings
  Write-Host "[FishVim] Windows Terminal font set to 'JetBrainsMono Nerd Font Mono'. Restart Windows Terminal to apply."
}

Write-Host "[FishVim] Installing Windows dependencies with winget..."
Set-UTF8Encoding
Ensure-WingetPackage -Id "Git.Git"
Ensure-WingetPackage -Id "Neovim.Neovim"
Ensure-WingetPackage -Id "BurntSushi.ripgrep.MSVC"
Ensure-WingetPackage -Id "sharkdp.fd"
Ensure-WingetPackage -Id "OpenJS.NodeJS.LTS"
Ensure-WingetPackage -Id "Python.Python.3.12"
Ensure-WingetPackage -Id "7zip.7zip"
Ensure-WingetPackage -Id "DEVCOM.JetBrainsMonoNerdFont"
Set-WindowsTerminalNerdFont

$SourceConfig = Join-Path $RepoRoot "config\nvim"
if (Test-Path $SourceConfig) {
  Write-Host "[FishVim] Installing Neovim config to $NvimConfigDir"
  if (Test-Path $NvimConfigDir) {
    Remove-Item -Recurse -Force $NvimConfigDir
  }
  New-Item -ItemType Directory -Force -Path $NvimConfigDir | Out-Null
  Copy-Item -Recurse -Force "$SourceConfig\*" $NvimConfigDir
} else {
  Write-Warning "[FishVim] $SourceConfig not found. Skipping config copy."
}

Write-Host "[FishVim] Bootstrap complete. Start with: nvim"
