# Launch to reset profile (uninstall beaverOS)

 $pld_profile_file = Get-ChildItem -Path 'C:\Users\' -Recurse | Where-Object { $_.FullName -match '\\beaverOS_external\\Data\\.*old_profile.txt$' } | Select-Object -ExpandProperty FullName

 Copy-Item $old_profile_file -Destination $PROFILE
 Write-Host "Sucessfully removed beaverOS_external and mounted previous profile." -ForegroundColor Green

