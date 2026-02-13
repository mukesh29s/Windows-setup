# Windows Ultimate Setup Script

A modular PowerShell script to clean up Windows and install essential software using **Chocolatey**.

##  Features
1. **Sanitize:** Disables "Consumer Experiences" to prevent new junk from auto-installing.
2. **Automate:** Installs Chocolatey and a list of essential apps silently.

##  Usage
1. Open **PowerShell** as an **Administrator**.
2. Run the following command:
   ```powershell

   Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex (New-Object System.Net.WebClient).DownloadString('YOUR_RAW_GITHUB_LINK_HERE')

