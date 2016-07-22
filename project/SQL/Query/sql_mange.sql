


-- ดูว่า query ตายอยู
sp_who_ex 

      CREATE Procedure [dbo].[sp_who_ex]  as     
	 SELECT r.session_id,r.cpu_time,d.name AS [Database_Name], 
			t.text,r.start_time as [เวลาเริ่มต้น execute],r.command,
			s.program_name   FROM sys.dm_exec_requests r   
	 CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t   
	 INNER JOIN sys.databases d ON d.database_id = r.database_id   
	 INNER JOIN sys.dm_exec_sessions s ON r.session_id = s.session_id   
	 where r.session_id  > 50    
	 order by r.cpu_time desc,r.start_time asc   --,s.host_name AS [Server_Name]  

-- kill process 
kill 58