--выборка всех данных из таблицы
select *
from components;

--выборка данных из одной таблицы при нескольких условиях, с использованием логических операций
--LIKE, BETWEEN, IN
select *
from components
where title like 'водка';
select *
from drinks
where alcohol between 30 and 100;
select *
from food
where title in ('начос', 'стрипсы');

--вычисляемое поле в запросе
select count(drink_id)
from drinks;

--выборка всех данных с сортировкой по нескольким полям
select *
from places
order by address desc, place_id;

--запрос, вычисляющий несколько совокупных характеристик таблиц
select max(drink_id), min(place_id)
from drinks,
     places;

--выборка данных из связанных таблиц
select d.title, p.title, p.address
from drinks d
         join places_drinks pd on d.drink_id = pd.drink_id
         join places p on p.place_id = pd.place_id
where d.title = 'боярский'
order by d.title desc;

--пример использования вложенного запроса
select dtitle
from (select drinks.title dtitle, c.title ctitle
      from drinks
               left outer join components_drinks cd on drinks.drink_id = cd.drink_id
               left outer join components c on cd.component_id = c.component_id) as d
where d.ctitle = 'водка';

insert into components(title, alcohol)
values ('апельсиновый сок', 0);

update components
set title   = 'jagermeister',
    alcohol = 35
where component_id = 5;

delete
from discounts
where discount_id = (select max(discount_id) from discounts);

delete
from places
where place_id not in (select place_id from supplies_drinks)
  and place_id not in (select place_id from supplies_food);