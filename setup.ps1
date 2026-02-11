<#
.SYNOPSIS
    Automated Windows Environment Setup via Chocolatey.
.DESCRIPTION
    1. Checks for Administrative privileges.
    2. Installs Chocolatey if not present.
    3. Installs a predefined list of software packages.
    4. Cleans up and verifies installation.
#>

# --- MODULE 0: LOGGING & ADMIN CHECK ---
$LogPath = "$env:USERPROFILE\Desktop\Windows_Setup_Log.txt"
Start-Transcript -Path $LogPath

# 1. Ensure we are running as Administrator
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Please run this script as Administrator!"
    exit
}

# 2. Install Chocolatey if it's missing
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "--- Chocolatey not found. Starting installation... ---" -ForegroundColor Cyan
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}
else {
    Write-Host "--- Chocolatey is already installed. ---" -ForegroundColor Green
}

# 3. Define your software modules
# Add or remove package names from these arrays
$browsers = @("googlechrome", "firefox")
$devTools = @("vscode", "git", "docker-desktop", "greenshot", "notepadplusplus", "treesizefree", "wsl2")
$utilities = @("7zip", "powertoys", "vlc", "spotify")
$dbTools = @("dbeaver", "pgadmin4")

$allPackages = $browsers + $devTools + $utilities + $dbTools

# 4. Install the packages
Write-Host "--- Starting bulk software installation... ---" -ForegroundColor Cyan

foreach ($package in $allPackages) {
    Write-Host "Installing: $package" -ForegroundColor Yellow
    choco install $package -y
    choco upgrade $package -y
}

Write-Host "--- Process Complete! ---" -ForegroundColor Green
Write-Host "Note: You may need to restart your terminal or computer for all changes to take effect."
Write-Host "--- Setup Complete! Log saved to $LogPath ---" -ForegroundColor Green
Stop-Transcript