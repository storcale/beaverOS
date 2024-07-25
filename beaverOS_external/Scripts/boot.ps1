# Launch to manage beaverOS on the computer 


$module = Get-ChildItem -Path 'E:\' -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.FullName -match '\\beaverOS_external\\Modules\\.*welcomeGUI_module.psm1$' } | Select-Object -ExpandProperty FullName
Import-Module($module)

welcomeGUI
