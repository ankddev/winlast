# WinLast Tweaker for Windows 10/11. By ANKDDEV, licensed under MIT License
# Make sure that you downloaded it from https://github.com/ankddev/winlast

$version = "1.0.0"

$tweaks = @(
    # Disable Cortana
    @{
        Name = "Disable Cortana";
        Description = "Disable Cortana Assistant";
        Admin = $true;
        ApplyCommand = "reg add `"HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search`" /v AllowCortana /t REG_DWORD /d 0 /f";
        RevertCommand = "reg delete `"HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search`" /v AllowCortana /f";
    }
    # Show file extensions in explorer
    @{
        Name = "Show file extensions";
        Description = "Show file extensions in Explorer";
        Admin = $false;
        ApplyCommand = "reg add `"HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced`" /v HideFileExt /t REG_DWORD /d 0 /f";
        RevertCommand = "reg add `"HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced`" /v HideFileExt /t REG_DWORD /d 1 /f";
    }
    # Show hidden files in Explorer
    @{
        Name = "Show hidden files";
        Description = "Show hidden files in Explorer";
        Admin = $false;
        ApplyCommand = "reg add `"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced`" /v Hidden /t REG_DWORD /d 1 /f";
        RevertCommand = "reg add `"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced`" /v Hidden /t REG_DWORD /d 2 /f";
    }
    # Disable New Outlook
    @{
        Name = "Disable New Outlook";
        Description = "Prevent installation of new Outlook";
        Admin = $true;
        ApplyCommand = "reg delete `"HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\OutlookUpdate`" /f";
        # TODO: Allow nullable revert command
        RevertCommand = "echo 'Install Outlook or restore registry keys manually'";
    }
    # Enable long file paths
    @{
        Name = "Enable long file paths";
        Description = "Allow path longer than 260 characters";
        Admin = $true;
        ApplyCommand = "reg add `"HKLM\SYSTEM\CurrentControlSet\Control\FileSystem`" /v LongPathsEnabled /t REG_DWORD /d 1 /f";
        RevertCommand = "reg add `"HKLM\SYSTEM\CurrentControlSet\Control\FileSystem`" /v LongPathsEnabled /t REG_DWORD /d 0 /f";
    }
    # Disable News and Interests
    @{
        Name = "Disable News and Interests";
        Description = "Hide News and Interests widget from taskbar";
        Admin = $true;
        ApplyCommand = "reg add `"HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds`" /v EnableFeeds /t REG_DWORD /d 0 /f";
        RevertCommand = "reg delete `"HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds`" /v EnableFeeds /f";
    }
    # Disable Windows Search Service
    @{
        Name = "Disable Windows Search Service";
        Description = "Stops and disables Windows Search service";
        Admin = $true;
        ApplyCommand = "Stop-Service -Name WSearch; Set-Service -Name WSearch -StartupType Disabled";
        RevertCommand = "Set-Service -Name WSearch -StartupType Automatic; Start-Service -Name WSearch";
    }
    # Disable Windows Error Reporting
    @{
        Name = "Disable Windows Error Reporting";
        Description = "Stops error reporting service (`YourApp has stop working` messages)";
        Admin = $true;
        ApplyCommand = "reg add `"HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting`" /v Disabled /t REG_DWORD /d 1 /f";
        RevertCommand = "reg add `"HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting`" /v Disabled /t REG_DWORD /d 0 /f";
    }
    # Disable Lock Screen
    @{
        Name = "Disable Lock Screen";
        Description = "Removes lock screen, goes directly to login";
        Admin = $true;
        ApplyCommand = "reg add `"HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization`" /v NoLockScreen /t REG_DWORD /d 1 /f";
        RevertCommand = "reg add `"HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization`" /v NoLockScreen /t REG_DWORD /d 0 /f";
    }
    # Disable Windows Defender Real-time Protection
    @{
        Name = "Disable Windows Defender Real-time Protection";
        Description = "Turns off Defender real-time protection; results in security risks";
        Admin = $true;
        ApplyCommand = "Set-MpPreference -DisableRealtimeMonitoring `$true";
        RevertCommand = "Set-MpPreference -DisableRealtimeMonitoring `$false";
    }
    # Disable automatic drivver updates
    @{
        Name = "Disable automatic driver updates";
        Description = "Prevents automatic driver updates via Windows Update";
        Admin = $true;
        ApplyCommand = "reg add `"HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching`" /v SearchOrderConfig /t REG_DWORD /d 0 /f";
        RevertCommand = "reg add `"HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching`" /v SearchOrderConfig /t REG_DWORD /d 1 /f";
    }
    # Disable Windows Tips
    @{
        Name = "Disable Windows Tips";
        Description = "Stops Windows tips and suggestions";
        Admin = $true;
        ApplyCommand = "reg add `"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager`" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f";
        RevertCommand = "reg add `"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager`" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 1 /f";
    }
    # Disable background apps
    @{
        Name = "Disable background apps";
        Description = "Stops apps running in background";
        Admin = $false;
        ApplyCommand = "reg add `"HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications`" /v GlobalUserDisabled /t REG_DWORD /d 1 /f";
        RevertCommand = "reg add `"HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications`" /v GlobalUserDisabled /t REG_DWORD /d 0 /f";
    }
    # Disable SMBv1 protocol
    @{
        Name = "Disable SMBv1 protocol";
        Description = "Disable SMBv1 protocol to improve security";
        Admin = $false;
        ApplyCommand = "Set-SmbServerConfiguration -EnableSMB1Protocol `$false -Force";
        RevertCommand = "Set-SmbServerConfiguration -EnableSMB1Protocol `$true -Force";
    }
)

function Show-Menu {
    param(
        [int]$selectedIndex = 0
    )
    Clear-Host

    $headerLines = 5
    $bufferWidth = $Host.UI.RawUI.BufferSize.Width
    $bufferHeight = $Host.UI.RawUI.WindowSize.Height
    $menuAreaHeight = $bufferHeight - $headerLines
    if ($menuAreaHeight -lt 1) { $menuAreaHeight = 1 }

    $start = 0
    $end = $tweaks.Count - 1
    if ($tweaks.Count -gt $menuAreaHeight) {
        $half = [Math]::Floor($menuAreaHeight / 2)
        $start = [Math]::Max(0, $selectedIndex - $half)
        $end = $start + $menuAreaHeight - 1
        if ($end -ge $tweaks.Count) {
            $end = $tweaks.Count - 1
            $start = $end - $menuAreaHeight + 1
        }
    }

    # Header
    Write-Host "WinLast Tweaker v$version. Created by ANKDDEV, licensed under MIT License."
    Write-Host "You can find source code at https://github.com/ankddev/winlast"
    Write-Warning "ALWAYS CREATE BACKUPS! Author is not responsible for the damage caused by program!"
    Write-Host "Use Up/Down arrows to navigate, Enter to view details, Escape to exit." -ForegroundColor Cyan
    Write-Host ""

    if ($start -gt 0) {
        Write-Host "   ... there are items above ..." -ForegroundColor DarkGray
    }

    # Menu items
    for ($i = $start; $i -le $end; $i++) {
        $text = "   $($tweaks[$i].Name)"
        if ($i -eq $selectedIndex) {
            $text = " > $($tweaks[$i].Name)".PadRight($bufferWidth)
            Write-Host $text -ForegroundColor Yellow
        } else {
            $text = "   $($tweaks[$i].Name)".PadRight($bufferWidth)
            Write-Host $text
        }
    }

    if ($end -lt $tweaks.Count - 1) {
        Write-Host "   ... there are items below ..." -ForegroundColor DarkGray
    }
}

function Update-MenuItems {
    param(
        [int]$prevIndex,
        [int]$newIndex
    )
    Show-Menu -selectedIndex $newIndex
}

function Show-Details {
    param(
        [hashtable]$tweak
    )
    Clear-Host
    Write-Host "Tweak Details" -ForegroundColor Cyan
    Write-Host "-------------"
    Write-Host "Name:           $($tweak.Name)"
    Write-Host "Description:    $($tweak.Description)"
    Write-Host "Admin Req:      $($tweak.Admin)"
    Write-Host "Apply Command:  $($tweak.ApplyCommand)"
    Write-Host "Revert Command: $($tweak.RevertCommand)"
    Write-Host ""
    Write-Host "Press 1 to apply this tweak, 0 to revert, or Escape to go back." -ForegroundColor Green
}

function Apply-Tweak {
    param(
        [hashtable]$tweak
    )
    if ($tweak.Admin -and -not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole] "Administrator")) {
        Write-Warning "This tweak requires administrative privileges. Please run PowerShell as Administrator."
        Pause
        return
    }
    try {
        # Execute the command string
        Invoke-Expression $tweak.ApplyCommand
        Write-Host "Tweak applied successfully!" -ForegroundColor Green
    } catch {
        Write-Host "Failed to apply tweak: $_" -ForegroundColor Red
    }
    Write-Host "Press any key to continue..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function Revert-Tweak {
    param(
        [hashtable]$tweak
    )
    if ($tweak.Admin -and -not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole] "Administrator")) {
        Write-Warning "This tweak requires administrative privileges. Please run PowerShell as Administrator."
        Pause
        return
    }
    try {
        # Execute the command string
        Invoke-Expression $tweak.RevertCommand
        Write-Host "Tweak reverted successfully!" -ForegroundColor Green
    } catch {
        Write-Host "Failed to revert tweak: $_" -ForegroundColor Red
    }
    Write-Host "Press any key to continue..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# Main loop
$selectedIndex = 0
[Console]::CursorVisible = $false
Clear-Host
Show-Menu -selectedIndex $selectedIndex

while ($true) {
    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

    switch ($key.VirtualKeyCode) {
        38 { # Up arrow
            $prevIndex = $selectedIndex
            if ($selectedIndex -gt 0) {
                $selectedIndex--
                Update-MenuItems -prevIndex $prevIndex -newIndex $selectedIndex
            }
        }
        40 { # Down arrow
            $prevIndex = $selectedIndex
            if ($selectedIndex -lt ($tweaks.Count - 1)) {
                $selectedIndex++
                Update-MenuItems -prevIndex $prevIndex -newIndex $selectedIndex
            }
        }
        13 { # Enter
            while ($true) {
                Show-Details -tweak $tweaks[$selectedIndex]
                $detailKey = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
                if ($detailKey.VirtualKeyCode -eq 49) { # 1 to apply
                    Apply-Tweak -tweak $tweaks[$selectedIndex]
                    break
                } elseif ($detailKey.VirtualKeyCode -eq 48) { # 0 to revert
                    Revert-Tweak -tweak $tweaks[$selectedIndex]
                    break
                } elseif ($detailKey.VirtualKeyCode -eq 27) { # Escape to go back
                    break
                }
            }
            Clear-Host
            Show-Menu -selectedIndex $selectedIndex
        }
        27 { # Escape
            Clear-Host
            [Console]::CursorVisible = $true
            Write-Host "Exiting..." -ForegroundColor Cyan
            exit
        }
    }
}
