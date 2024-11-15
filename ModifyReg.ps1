# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
        Start-Process -FilePath PowerShell.exe -Verb RunAs -ArgumentList $CommandLine
        Exit
    }
}

function Show-Menu {
    Clear-Host
    Write-Host "================================" -ForegroundColor Cyan
    Write-Host "Browser Registry Installation Script" -ForegroundColor Cyan
    Write-Host "================================" -ForegroundColor Cyan
    Write-Host "1. Install for Chrome"
    Write-Host "2. Install for Brave"
    Write-Host "3. Install for Edge"
    Write-Host "4. Install for All Browsers"
    Write-Host "5. Exit"
    Write-Host ""
}

function Install-ChromeRegistry {
    Write-Host "`nInstalling registry entries for Chrome..." -ForegroundColor Yellow
    try {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Force | Out-Null
        New-Item -Path "HKLM:\SOFTWARE\Policies\Google\Chrome\ExtensionInstallAllowlist" -Force | Out-Null
        New-Item -Path "HKLM:\SOFTWARE\Policies\Google\Chrome\ExtensionInstallSources" -Force | Out-Null
        
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome\ExtensionInstallAllowlist" `
            -Name "1" `
            -Value "kcpfnbjlimolkcjllfooaipdpdjmjigg" `
            -Type String -Force
            
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome\ExtensionInstallSources" `
            -Name "1" `
            -Value "https://github.com/subham8907/Linkumori/releases/latest/download/updates.xml*" `
            -Type String -Force
            
        Write-Host "Chrome registry entries installed successfully." -ForegroundColor Green
    }
    catch {
        Write-Host "Error installing Chrome registry entries: $_" -ForegroundColor Red
    }
}

function Install-BraveRegistry {
    Write-Host "`nInstalling registry entries for Brave..." -ForegroundColor Yellow
    try {
        New-Item -Path "HKLM:\SOFTWARE\Policies\BraveSoftware\Brave" -Force | Out-Null
        New-Item -Path "HKLM:\SOFTWARE\Policies\BraveSoftware\Brave\ExtensionInstallAllowlist" -Force | Out-Null
        New-Item -Path "HKLM:\SOFTWARE\Policies\BraveSoftware\Brave\ExtensionInstallSources" -Force | Out-Null
        
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\BraveSoftware\Brave\ExtensionInstallAllowlist" `
            -Name "1" `
            -Value "kcpfnbjlimolkcjllfooaipdpdjmjigg" `
            -Type String -Force
            
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\BraveSoftware\Brave\ExtensionInstallSources" `
            -Name "1" `
            -Value "https://github.com/subham8907/Linkumori/releases/latest/download/updates.xml*" `
            -Type String -Force
            
        Write-Host "Brave registry entries installed successfully." -ForegroundColor Green
    }
    catch {
        Write-Host "Error installing Brave registry entries: $_" -ForegroundColor Red
    }
}

function Install-EdgeRegistry {
    Write-Host "`nInstalling registry entries for Edge..." -ForegroundColor Yellow
    try {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Force | Out-Null
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallAllowlist" -Force | Out-Null
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallSources" -Force | Out-Null
        
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallAllowlist" `
            -Name "1" `
            -Value "kcpfnbjlimolkcjllfooaipdpdjmjigg" `
            -Type String -Force
            
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallSources" `
            -Name "1" `
            -Value "https://github.com/subham8907/Linkumori/releases/latest/download/updates.xml*" `
            -Type String -Force
            
        Write-Host "Edge registry entries installed successfully." -ForegroundColor Green
    }
    catch {
        Write-Host "Error installing Edge registry entries: $_" -ForegroundColor Red
    }
}

function Install-AllBrowsers {
    Write-Host "`nInstalling registry entries for all browsers..." -ForegroundColor Yellow
    Install-ChromeRegistry
    Install-BraveRegistry
    Install-EdgeRegistry
}

# Main script loop
do {
    Show-Menu
    $choice = Read-Host "Enter your choice (1-5)"
    
    switch ($choice) {
        "1" { Install-ChromeRegistry }
        "2" { Install-BraveRegistry }
        "3" { Install-EdgeRegistry }
        "4" { Install-AllBrowsers }
        "5" { 
            Write-Host "`nExiting script..." -ForegroundColor Yellow
            Start-Sleep -Seconds 2
            exit 
        }
        default { 
            Write-Host "`nInvalid choice. Please try again." -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
    
    if ($choice -in "1", "2", "3", "4") {
        Write-Host "`nDo you want to perform another operation?" -ForegroundColor Cyan
        $continue = Read-Host "Press 'Y' to continue or any other key to exit"
        if ($continue -notmatch '^[Yy]$') {
            Write-Host "`nThank you for using the script." -ForegroundColor Green
            Start-Sleep -Seconds 2
            break
        }
    }
} while ($true)