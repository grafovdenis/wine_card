create or replace function get_available(place_id integer, from_date timestamp)
    returns TABLE
            (
                title         varchar(50),
                rating        double precision,
                volume        double precision,
                average_price double precision,
                date          timestamp
            )
as
$$
declare
    req_time     date = from_date - interval '2 weeks';
    req_place_id int  = place_id;
begin
    return query (select d.title, d.rating, d.volume, d.average_price, sd.date
                  from drinks d
                           join supplies_drinks sd on d.drink_id = sd.drink_id
                  where sd.date > req_time
                    and sd.place_id = req_place_id
                  union
                  select f.title, f.rating, f.volume, f.average_price, sf.date
                  from food f
                           join supplies_food sf on f.food_id = sf.food_id
                  where sf.date > req_time
                    and sf.place_id = req_place_id);
end ;
$$ language plpgsql;

select *
from get_available(15, (now() - interval '1 year')::timestamp);