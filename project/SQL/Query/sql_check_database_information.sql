

 


  
 /**************************
	CHECK  database Info
 ************************/
select top 10 *
from sys.columns c inner join sys.tables t on c.object_id = t.object_id
where t.name = 'voucher' and c.name = 'voucherNo'

select top 10 *
from information_schema.tables
where table_name = 'voucher'

select top 10 *
from information_schema.columns
where table_name = 'voucher' 


 



 /***********************
	check Rows and check Size Table
 ***************************/ 
SELECT 
TableName = obj.name,
TotalRows = prt.rows,
[SpaceUsed(KB)] = SUM(alloc.used_pages)*8
FROM sys.objects obj
JOIN sys.indexes idx on obj.object_id = idx.object_id
JOIN sys.partitions prt on obj.object_id = prt.object_id
JOIN sys.allocation_units alloc on alloc.container_id = prt.partition_id
WHERE
obj.type = 'U' AND idx.index_id IN (0, 1)
GROUP BY obj.name, prt.rows
ORDER BY TableName



 
/*************************
	check index In table
************************/
SELECT o.name objectname,i.name indexname, partition_id, partition_number, [rows]
FROM sys.partitions p
INNER JOIN sys.objects o ON o.object_id=p.object_id
INNER JOIN sys.indexes i ON i.object_id=p.object_id and p.index_id=i.index_id
WHERE o.name LIKE '%log_webpq%'
 