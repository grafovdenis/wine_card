--FILL
insert into components(title, alcohol
)
values ('водка', 40),
       ('гренадин', 0),
       ('соус табаско', 0);

insert into drinks(title, volume, alcohol, drink_type
)
values ('боярский', 50, 40 / 2, 'шоты');

insert into components_drinks(component_id, drink_id, quantity
)
values ((select component_id from components where title = 'водка'),
        (select drink_id from drinks where title = 'боярский'), 1),
       ((select component_id from components where title = 'гренадин'),
        (select drink_id from drinks where title = 'боярский'), 1),
       ((select component_id from components where title = 'соус табаско'),
        (select drink_id from drinks where title = 'боярский'), 1);


insert into components(title, alcohol
)
values ('томатный сок', 0);

insert into drinks(title, volume, alcohol, drink_type
)
values ('кровавая мэри', 50, 40 / 2, 'шоты');

insert into components_drinks(component_id, drink_id
)
values ((select component_id from components where title = 'водка'),
        (select drink_id from drinks where title = 'кровавая мэри')),
       ((select component_id from components where title = 'томатный сок'),
        (select drink_id from drinks where title = 'кровавая мэри')),
       ((select component_id from components where title = 'соус табаско'),
        (select drink_id from drinks where title = 'кровавая мэри'));

insert into places(title, address
)
values ('Контакт бар', 'пр. Просвещения, 25'),
       ('Контакт бар', 'ул. Садовая, 35'),
       ('Контакт бар', 'пр. Владимирский, 17'),
       ('Контакт бар', 'пр. Коломяжский, 15, к.2'),
       ('Контакт бар', 'пл. Стачек, 7, лит. A'),
       ('Контакт бар', 'ул. Гаккелевская, 34'),
       ('Контакт бар', 'ул. Марата, 7'),
       ('Контакт бар', 'Средний пр-т. ВО, 28'),
       ('Контакт бар', 'пр.Чернышевского 11/57'),
       ('Контакт бар', 'ул. Бухарестская, 74'),
       ('СПБ бар', 'Каменноостровский пр., 37');

insert into food(title
)
values ('стрипсы'),
       ('начос');

insert into places_drinks(place_id, drink_id
)
select distinct place_id, drink_id
from places,
     drinks
where drinks.title = 'боярский'
  and places.title = 'Контакт бар';

insert into places_food(place_id, snack_id
)
select distinct place_id, food_id
from places,
     food
where food.title = 'стрипсы'
  and places.title = 'Контакт бар';

insert into places_food(place_id, snack_id
)
select distinct place_id, food_id
from places,
     food
where food.title = 'начос'
  and places.title = 'Контакт бар';

insert into supplies_food(place_id, food_id
)
select distinct place_id, food_id
from places,
     food
where food.title = 'начос'
  and places.title = 'Контакт бар';

insert into supplies_drinks(place_id, drink_id
)
select distinct place_id, drink_id
from places,
     drinks
where drinks.title = 'боярский'
  and places.title = 'Контакт бар';

insert into discounts(place_id, drink_type, amount, description
)
select distinct place_id, 'пиво и сидр'::drink_type, 0.15, 'Цены для друзей на пиво!'
from places
where places.title = 'Контакт бар';