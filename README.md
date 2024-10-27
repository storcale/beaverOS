# beaverOS

## How to run: 
Make sure to have script execution policy enabled
Launch scripts/boot.ps1 

### Components: 
A custom powershell module wraparound with an installer and an updater
beaverOS_external.psm1:
 Main module with core functionalities (currently non-existing) that is updatable
utilies.psm1: 
 Secondary module with useful cmd line utilities
manager.psm1: 
 beaverOS utility module used by the beaverOS manager script

