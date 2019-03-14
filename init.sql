DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;

CREATE TYPE drink_type AS ENUM (
  'пиво и сидр',
  'водка и настойки',
  'ром',
  'текила',
  'виски',
  'биттеры',
  'вино',
  'бренди и коньяк',
  'шоты',
  'коктейли',
  'безалкогольные'
  );

CREATE TABLE components
(
  component_id serial                NOT NULL,
  title        character varying(50) NOT NULL,
  alcohol      double precision,
  primary key (component_id)
);

CREATE TABLE drinks
(
  drink_id      serial                NOT NULL,
  title         character varying(50) NOT NULL,
  rating        double precision,
  volume        double precision,
  alcohol       double precision,
  average_price double precision,
  drink_type    drink_type,
  primary key (drink_id)
);

CREATE TABLE components_drinks
(
  component_id int NOT NULL references components (component_id),
  drink_id     int NOT NULL references drinks (drink_id),
  quantity     double precision
);

CREATE TABLE places
(
  place_id     serial                NOT NULL,
  title        character varying(50) NOT NULL,
  address      text,
  rating       double precision,
  average_bill double precision,
  primary key (place_id)
);

CREATE TABLE places_drinks
(
  place_id integer NOT NULL references places (place_id),
  drink_id integer NOT NULL references drinks (drink_id)
);

CREATE TABLE discounts
(
  discount_id serial           NOT NULL,
  place_id    integer          NOT NULL references places (place_id),
  drink_type  drink_type       NOT NULL,
  amount      double precision NOT NULL,
  description text,
  weekday     integer,
  time_start  time,
  time_end    time,
  primary key (discount_id)
);

CREATE TABLE food
(
  food_id       serial                NOT NULL,
  title         character varying(50) NOT NULL,
  rating        double precision,
  volume        double precision,
  average_price double precision,
  primary key (food_id)
);

CREATE TABLE places_food
(
  place_id integer NOT NULL references places (place_id),
  snack_id integer NOT NULL references food (food_id)
);