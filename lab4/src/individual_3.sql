--ИНДИВИДУАЛЬНОЕ ЗАДАНИЕ
--3
select *
from discounts
         join drinks on drinks.drink_type = discounts.drink_type
where alcohol = (select max(alcohol) from drinks)
   or average_price = (select min(average_price) from drinks)
   or volume = (select max(volume) from drinks)
group by discount_id, drink_id
order by alcohol desc , average_price, volume desc;