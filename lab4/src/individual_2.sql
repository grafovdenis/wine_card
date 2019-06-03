--ИНДИВИДУАЛЬНОЕ ЗАДАНИЕ
--2
select *
from (select d.drink_id, count(d.drink_id) components
      from drinks d
               join components_drinks cd on d.drink_id = cd.drink_id
      group by d.drink_id) sub
         join drinks d on d.drink_id = sub.drink_id
where components > (select avg(cnt)
                    from (select count(d.drink_id) cnt
                          from drinks d
                                   join components_drinks cd on d.drink_id = cd.drink_id
                          group by d.drink_id) sub)
group by d.drink_id, sub.drink_id, sub.components
order by alcohol desc;