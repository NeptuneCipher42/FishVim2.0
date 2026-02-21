$ErrorActionPreference = 'Stop'

$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..\..")
$NvimConfigDir = Join-Path $env:LOCALAPPDATA "nvim"

function Ensure-WingetPackage {
  param(
    [string]$Id
  )
  winget install --id $Id --exact --source winget --accept-package-agreements --accept-source-agreements
}

Write-Host "[FishVim] Installing Windows dependencies with winget..."
Ensure-WingetPackage -Id "Git.Git"
Ensure-WingetPackage -Id "Neovim.Neovim"
Ensure-WingetPackage -Id "BurntSushi.ripgrep.MSVC"
Ensure-WingetPackage -Id "sharkdp.fd"
Ensure-WingetPackage -Id "OpenJS.NodeJS.LTS"
Ensure-WingetPackage -Id "Python.Python.3.12"
Ensure-WingetPackage -Id "7zip.7zip"

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
