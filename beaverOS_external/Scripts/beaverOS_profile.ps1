$module_path = "C:\Users\21GFrette-ChambaudTC\OneDrive - Longford and Westmeath Education and Training Board\BOS\beaverOS_external\Modules\beaverOS_external.psm1"
$executionTime = Measure-Command { Import-Module -Force $module_path }
Write-Host "Imported beaverOS in $($executionTime.TotalMilliseconds) ms" -ForegroundColor Gree
$utilities_path = "C:\Users\21GFrette-ChambaudTC\OneDrive - Longford and Westmeath Education and Training Board\BOS\beaverOS_external\Modules\utilities.psm1"
$executionTime = Measure-Command { Import-Module -Force $utilities_path }
Write-Host "Imported utilities in $($executionTime.TotalMilliseconds) ms" -ForegroundColor Green

Write-Host @"
 ________  _______   ________  ___      ___ _______   ________          ________  ________      
|\   __  \|\  ___ \ |\   __  \|\  \    /  /|\  ___ \ |\   __  \        |\   __  \|\   ____\     
\ \  \|\ /\ \   __/|\ \  \|\  \ \  \  /  / | \   __/|\ \  \|\  \       \ \  \|\  \ \  \___|_    
 \ \   __  \ \  \_|/_\ \   __  \ \  \/  / / \ \  \_|/_\ \   _  _\       \ \  \\\  \ \_____  \   
  \ \  \|\  \ \  \_|\ \ \  \ \  \ \    / /   \ \  \_|\ \ \  \\  \|       \ \  \\\  \|____|\  \  
   \ \_______\ \_______\ \__\ \__\ \__/ /     \ \_______\ \__\\ _\        \ \_______\____\_\  \ 
    \|_______|\|_______|\|__|\|__|\|__|/       \|_______|\|__|\|__|        \|_______|\_________\
                                                                                    \|_________|
                                                                                                
"@ -ForegroundColor Yellow

Write-Host "Welcome to Powershell! BeaverOS_external installed" -ForegroundColor Green
