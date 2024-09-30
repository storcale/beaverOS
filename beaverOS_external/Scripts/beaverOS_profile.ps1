$module_file = Get-ChildItem -Path '$env:beaverOS_drive' -Recurse -ErrorAction SilentlyContinue| Where-Object { $_.FullName -match '\\beaverOS_external\\Modules\\.*beaverOS_external.psm1$' } | Select-Object -ExpandProperty FullName

Import-Module($module_file)
Write-Host("Welcome to Powershell! BeaverOS_external installed") -ForegroundColor Green


