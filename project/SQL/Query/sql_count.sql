
-- sum count 
select  sum(count(typedealer)) over() as 'cc'  from outbound_follow_partner
--select typedealer,count(typedealer) from outbound_follow_partner
where datediff(d,applicationdate,getdate()) = 1
--group by typedealer
--order by typedealer