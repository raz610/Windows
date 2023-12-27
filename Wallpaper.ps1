$RegPath = "HKCU:\Control Panel\Desktop"
$ImageURL = 'https://www.tufin.com/wp-content/uploads/2023/07/tufin-image.jpg'
$ImageLocation = "C:\Temp\Wallpaper"

#Donwload image if not exsist
if (-not (Test-Path $ImageLocation -PathType Leaf)) 
  {
   # Create image directory
md $ImageLocation -ErrorAction SilentlyContinue

# Download image files
Start-BitsTransfer -Source $ImageURL -Destination $ImageLocation
}

# Background Wallpaper Registry Keys
Set-ItemProperty -Path $RegPath -Name WallPaper -Value C:\Temp\Wallpaper\tufin-image.jpg -Force