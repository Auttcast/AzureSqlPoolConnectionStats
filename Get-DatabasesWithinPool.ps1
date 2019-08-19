param($poolName)

$ErrorActionPreference = "Stop"  

Login-AzAccount | Out-Null

$resourceGroups = Get-AzResourceGroup

$sqlServers = $resourceGroups | % { Get-AzSqlServer -ResourceGroupName $_.ResourceGroupName }

$allPools = $sqlServers | % { Get-AzSqlElasticPool -ResourceGroupName $_.ResourceGroupName -ServerName $_.ServerName }

$targetPool = $allPools | where ElasticPoolName -EQ $poolName

if($targetPool -eq $null) {
    throw "SQL Pool $poolName was not found"
}

$poolDatabases = Get-AzSqlDatabase -ResourceGroupName $targetPool.ResourceGroupName -ServerName $targetPool.ServerName |
    where ElasticPoolName -EQ $poolName

return $poolDatabases
