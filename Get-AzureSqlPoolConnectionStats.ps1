param($startDateUtc, $endDateUtc, $poolName, $sqlAdminConnectionString)

$ErrorActionPreference = "Stop"  

$databases = .\Get-DatabasesWithinPool.ps1 -poolName $poolName 

$formattedDatabaseNames = $databases |
    select -ExpandProperty DatabaseName |
    % { $_ -replace $_, "'$_'" } |
    Join-String -Separator ", "

$query = @'
SELECT start_time AS StartTime, SUM(success_count) AS TotalConnections
FROM sys.database_connection_stats
WHERE start_time >= '{0}' and end_time <= '{1}'
AND database_name IN ({2})
AND database_name IS NOT NULL
GROUP BY start_time
'@ -f $startDateUtc, $endDateUtc, $formattedDatabaseNames

$queryResult = Invoke-Sqlcmd -ConnectionString $sqlAdminConnectionString $query

$queryResult | Export-Csv SqlPoolConnectionStats.csv