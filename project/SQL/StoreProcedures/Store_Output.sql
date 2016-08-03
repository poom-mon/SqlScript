USE [XXXXX]
GO
/****** Object:  StoredProcedure [dbo].[GetMaxId]    Script Date: 08/03/2016 18:34:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO 


ALTER PROCEDURE [dbo].[GetMaxId]
		@repID int
		,@vColumn varchar(300)
		,@vTable  varchar(300)
		,@MaxId varchar(50) OUTPUT   
AS
BEGIN
	declare @MaxId_old nvarchar(2000)
	declare @sql nvarchar(2000)
	declare @parame  nvarchar(500)

set @sql  = 'declare @id bigint
                            declare @running nvarchar(7) --set @running = 9999999
                            declare @year nvarchar(2)
                            declare @tmp nvarchar(12)
                            declare @repID nvarchar(1) set @repID = '''+ convert(varchar(1),@repID) + '''

                        select @id=max('+ @vColumn + ')
                        from '+ @vTable + '
                        where len('+ @vColumn + ') < 11 and '+ @vColumn + ' like @repID +''%''

                        if @id is null or len(@id) <> 10
                        begin
                            set @year = right(cast(year(getdate()) as nvarchar(4)), 2)
                            set @id = cast(@repID + @year  + ''0000001'' as bigint)
                        end
                        else
                        begin
                            set @tmp = cast(@id as nvarchar)
                            set @year = substring(@tmp, 2, 2)
                            set @running = substring(@tmp, 4, 7)

                            if cast(@year as int) = right(year(getdate()), 2)
                            begin
                                set @running = cast(cast(@running as int) + 1 as nvarchar)
                            end
                            else
                            begin
                                set @running = ''1''
                                set @year = right(cast(year(getdate()) as nvarchar),2)
                            end

                            set @id = cast(@repID + @year + right(''000000'' + @running, 7) as bigint)
                        end

						set @NewId = convert(nvarchar(50),@id)
                    '

                    select @parame = ' @NewId nvarchar(50) output ' 
                    exec sp_executesql @sql , @parame , @NewId = @MaxId_old  output
				set @MaxId = convert(bigint,@MaxId_old) 
END

