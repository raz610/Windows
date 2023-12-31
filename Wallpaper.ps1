$RegPath = "HKCU:\Control Panel\Desktop"
$ImageURL = 'https://www.tufin.com/wp-content/uploads/2023/07/tufin-image.jpg'
$ImageLocation = "C:\Temp\Wallpaper"
$ScriptURL = "https://raw.githubusercontent.com/raz610/Windows/main/Wallpaper.ps1"

#Donwload image if not exsist
if (-not (Test-Path $ImageLocation -PathType Leaf)) 
  {
   # Create image directory
md $ImageLocation -ErrorAction SilentlyContinue

# Download image files
Start-BitsTransfer -Source $ImageURL -Destination $ImageLocation
Start-BitsTransfer -Source $ScriptURL -Destination $ImageLocation
}

# Background Wallpaper Registry Keys
Set-ItemProperty -Path $RegPath -Name WallPaper -Value C:\Temp\Wallpaper\tufin-image.jpg -Force

#task_scheduler
$scriptPath = "C:\Temp\Wallpaper\Wallpaper.ps1"
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-File $scriptPath"
$trigger = New-ScheduledTaskTrigger -AtLogOn -LogonType Interactive
$taskName = "Wallpaper"  

if (-not (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue)) {
    Register-ScheduledTask -Action $action -Trigger $trigger -TaskName $taskName
}
