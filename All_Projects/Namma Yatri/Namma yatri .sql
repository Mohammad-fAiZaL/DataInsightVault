use namma_yatri_project;

select * from trips;

select * from trips_details;

select * from loc;

select * from duration;

select * from payment;


-- total trips --

select count(distinct tripid) as total_trips from trips_details;


-- total drivers -- 

select * from trips;

select count(distinct driverid) total_drivers from trips;

-- total earnings

select sum(fare) total_earnings from trips;

-- total Completed trips

select * from trips_details;
select sum(end_ride) from trips_details;

-- total searches --

select sum(searches)
from trips_details;

-- total searches which got estimate --
select * from trips_details;
select sum(searches_got_estimate) from trips_details;

-- total searches for quotes --

select sum(searches_for_quotes) from trips_details;

-- total searches which got quotes --

select sum(searches_got_quotes) from trips_details;

-- total driver cancelled --

select count(*) - sum(driver_not_cancelled) from  trips_details;

-- total otp entered --

select sum(otp_entered) from  trips_details;

-- total end ride --

select sum(end_ride) from  trips_details;


-- average distance per trip

select * from trips;
select avg(distance) average_distance from trips;


-- average fare per trip

select sum(fare)/count(*) from trips;

-- distance travelled --

select sum(distance) total_distance from trips;



-- which is the most used payment method --
select * from payment;
select * from trips;
select * from loc; 

select p.method from payment p inner join 
(select faremethod, count(tripid) cnt from trips 
group by faremethod
order by count(tripid) desc limit 1) t
on p.id = t.faremethod;


-- the top 3 highest payment was made through which instrument --

select t.fare as max_payment, t.faremethod, p.method 
from trips t  inner join payment p
on t.faremethod = p.id
order by t.fare desc limit 3;


-- which three locations had the most trips --

select * from 
(select *, dense_rank() over(order by trip desc) rnk
from
(select loc_from,loc_to,count(distinct tripid) trip from trips
group by loc_from,loc_to
)a)b
where rnk >=1 and rnk <=2 ;


-- top 5 earning drivers --

select * from trips_details;

select sum(fare) as earnings ,driverid from trips 
group by driverid 
order by earnings desc limit 5;

-- which duration had more trips --

select *,rank() over(order by cnt desc) rnk from
(select duration, count(tripid) cnt from trips 
group by duration)b;

-- which driver , customer pair had more orders --

select *, rank() over(order by cnt desc) rnk from
(select custid,driverid,count(tripid) cnt from trips 
group by custid, driverid
order by cnt desc) b;

-- search to estimate rate --

select round(sum(searches_got_estimate) / sum(searches) * 100,2) as Search_to_Estimate_Ratio from trips_details;

-- estimate to search for quote rates --
select * from trips_details;

select round(sum(searches_for_quotes) / sum(searches_got_estimate) * 100,2) as Search_to_Estimate_Ratio from trips_details;

-- quote acceptance rate --

select round(sum(searches_got_quotes) / sum(searches_for_quotes) * 100,2) as Search_to_Estimate_Ratio from trips_details;

-- quote to booking rate --

select round(sum(customer_not_cancelled) / sum(searches_got_quotes) * 100,2) as Search_to_Estimate_Ratio from trips_details;

-- booking cancellation rate --

select 100 - round(sum(customer_not_cancelled) / sum(driver_not_cancelled) * 100,2) as Search_to_Estimate_Ratio from trips_details;

-- conversion rate --

select round(sum(end_ride) / sum(searches) * 100,2) as Search_to_Estimate_Ratio from trips_details;

-- which area got highest trips in which duration --

select * from
(select *, rank() over(partition by duration order by cnt desc) rnk from 
(select duration, loc_from, count(distinct tripid) cnt from trips
group by duration, loc_from) b) c
where rnk =1 ; 


select * from
(select *, rank() over(partition by loc_from order by cnt desc) rnk from 
(select duration, loc_from, count(distinct tripid) cnt from trips
group by duration, loc_from) b) c
where rnk =1 ; 


-- which area got the highest fares, cancellations,trips --

select loc_from, sum(fare) as highest from trips
group by loc_from
order by highest desc limit 1;

select loc_from, count(*) - sum(driver_not_cancelled) as driver_cancelled
from trips_details 
group by loc_from
order by driver_cancelled desc limit 1;


-- which duration got the highest trips and fares --

select * from
(select *, rank() over(order by fare desc) rnk from 
(select duration,count(distinct tripid) fare  from trips 
group by duration)b)c
where rnk =1;

