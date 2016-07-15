

 

declare @tb table(
  product varchar(50),
  unit int , 
  price money
)
insert into @tb values('product1',2,'500')
insert into @tb values('product2',1,'1500')
insert into @tb values('product3',5,'1000')
insert into @tb values('product2',2,'500')

 
--- เรียงลำดับ
  select
	--row_number() over(partition by unit order by unit)  ord,
	row_number() over(order by unit)  ord,
	*
  from @tb 


--- order by ตาม produt 
  select
	 row_number() over(partition by product order by product)  ord, 
	*
  from @tb