select * 
from employee
where employee_name regexp '[HTK].{0,14}';

update customer 
set address = 'Sài Gòn'
where customerId = 1;

update customer
set address = 'Quảng Nam'
where customerId = 3;

select *
from customer 
where timestampdiff(year, date_of_birth, curdate()) between 18 and 50 and (address like '%Sài Gòn' or address like '%Quảng Nam');

select c.customerId, c.customer_name, count(*) as booking_count
from customer c
join contract co on c.customerId = co.customerId
join customer_type ct on c.customer_type_id = ct.customer_type_id
where ct.customer_type_name = 'Diamon' and co.is_delete = 0
group by c.customerId, c.customer_name
order by booking_count asc;

select 
	c.customerId,
    c.customer_name,
    af.attach_facility_name, 
    af.cost,
    af.unit,
    af.status
from 
	customer c
join
	contract co on c.customerId = co.customerId
join
	customer_type ct on c.customer_type_id = ct.customer_type_id
join
	contract_detail cd on co.contractID = cd.contractId
join
	attach_facility af on cd.attach_facility_id = af.attach_facility_id
where (ct.customer_type_name = 'Diamon')
and (c.address like '%Vinh' or c.address like '%Quảng Ngãi')
and co.is_delete = 0
and cd.is_delete = 0;


