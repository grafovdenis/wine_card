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
  place_id           int references places (place_id),
  food_id            int references food (food_id),
  amount             int,
  price_per_item     double precision,
  date               timestamp,
  primary key (supplies_snacks_id)
);

create table supplies_drinks
(
  supplies_drinks_id serial not null,
  place_id           int references places (place_id),
  drink_id           int references drinks (drink_id),
  amount             int,
  price_per_item     double precision,
  date               timestamp,
  primary key (supplies_drinks_id)
);