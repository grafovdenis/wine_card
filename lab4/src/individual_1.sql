--ИНДИВИДУАЛЬНОЕ ЗАДАНИЕ
--1
(select *
 from (select distinct p.place_id,
                       p.title                                                         place_title,
                       p.address,
                       p.rating                                                        place_rating,
                       d.drink_id                                                      item_id,
                       d.title                                                         item_title,
                       d.rating                                                        item_rating,
                       sd.date,
                       row_number() over (partition by p.place_id order by d.drink_id) top
       from supplies_drinks sd
                join drinks d on sd.drink_id = d.drink_id
                join places p on sd.place_id = p.place_id
       where date > (select (now() - interval '1 month'))
         and d.rating > (select avg(rating) from drinks)) as subquery
 where top <= 3)
union
(select *
 from (select distinct p.place_id,
                       p.title                                                        place_title,
                       p.address,
                       p.rating                                                       place_rating,
                       f.food_id                                                      item_id,
                       f.title                                                        item_title,
                       f.rating                                                       item_rating,
                       sd.date,
                       row_number() over (partition by p.place_id order by f.food_id) top
       from supplies_food sd
                join food f on sd.food_id = f.food_id
                join places p on sd.place_id = p.place_id
       where date > (select (now() - interval '1 month'))
         and f.rating > (select avg(rating) from drinks)) as subquery
 where top <= 3)
order by place_id, item_id;