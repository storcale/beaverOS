# Launch to reset profile (uninstall beaverOS)

$scriptPath = $PSScriptRoot
$old_profile_file = Join-Path $scriptPath "..\Data\old_profile.txt"
$old_profile_file = [System.IO.Path]::GetFullPath($old_profile_file)

 Copy-Item $old_profile_file -Destination $PROFILE
 Write-Host "Sucessfully removed beaverOS_external and mounted previous profile." -ForegroundColor Green

