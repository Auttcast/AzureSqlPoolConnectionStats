# AzureSqlPoolConnectionStats
Powershell script to assist in analyzing azure sql connections

# Prerequisites
1. Powershell core 6
2. Install-Module -Name Az
3. Install-Module -Name SqlServer 

# Example
Get-AzureSqlPoolConnectionStats.ps1 -startDateUtc "2019-08-17" -endDateUtc "2019-08-18" -poolName "my pool name" -sqlAdminConnectionString "my admin connection string"