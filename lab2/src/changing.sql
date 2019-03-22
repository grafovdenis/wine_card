--ISSUE
alter table places_drinks
  add column price double precision;

alter table places_food
  add column price double precision;

alter table places_drinks
  add column amount int;

alter table places_food
  add column amount int;

create table supplies_food
(
  supplies_snacks_id serial not null,
  place_id           int references places (place_id) on delete cascade,
  food_id            int references food (food_id) on delete cascade,
  amount             int,
  price_per_item     double precision,
  date               timestamp,
  primary key (supplies_snacks_id)
);

create table supplies_drinks
(
  supplies_drinks_id serial not null,
  place_id           int references places (place_id) on delete cascade,
  drink_id           int references drinks (drink_id) on delete cascade,
  amount             int,
  price_per_item     double precision,
  date               timestamp,
  primary key (supplies_drinks_id)
);

insert into supplies_food(place_id, food_id)
select distinct place_id, food_id
from places,
     food
where food.title = 'начос'
  and places.title = 'Контакт бар';

insert into supplies_drinks(place_id, drink_id)
select distinct place_id, drink_id
from places,
     drinks
where drinks.title = 'боярский'
  and places.title = 'Контакт бар';

