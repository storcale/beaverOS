@{
    RootModule        = 'beaverOS_external.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = 'c298c5e0-4dde-4257-ba2c-358fc7e30e4c'
    Author            = 'Storcale'
    CompanyName       = 'Overbeaver'
    Copyright         = ''
    Description       = 'A PowerShell module for beaverOS functionalities.'
    PowerShellVersion = '5.1'
    DotNetFrameworkVersion = '4.7.2'
    FormatsToProcess  = @()
    TypesToProcess    = @()
    PrivateData       = @{
        PSData         = @{
            ProjectUri = 'https://github.com/storcale/beaverOS'
            LicenseUri = 'https://opensource.org/license/lgpl-2-0/'
        }
    }
    FunctionsToExport = 'login'
    AliasesToExport   = @()
    VariablesToExport = @()
    CmdletsToExport   = @()
    ExportedCmdlets   = @()
    RequiredModules   = @()
    RequiredAssemblies = @()
}