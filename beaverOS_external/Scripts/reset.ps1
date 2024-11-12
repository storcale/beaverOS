# Launch to reset profile (uninstall beaverOS)

$projectRoot = (Get-Item -Path $PSScriptRoot).Parent.FullName
$old_profile_file = Join-Path -Path $projectRoot -ChildPath "Data\old_profile.txt"

Copy-Item $old_profile_file -Destination $PROFILE
Write-Host "Sucessfully removed beaverOS_external and mounted previous profile." -ForegroundColor Green
