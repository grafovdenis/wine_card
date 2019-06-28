insert into drinks(title)
values ('test'),
       ('test');

create or replace function places_drinks_correction() returns trigger as
$$
declare
    _title       varchar(50);
    equal_titles boolean;
    old_price    double precision;
begin
    _title = (select d.title
              from drinks d
              where drink_id = new.drink_id
              limit 1);
    equal_titles = (select count(*) from drinks where title = _title) > 0;
    if (equal_titles) then
        old_price = (select pd.price
                     from places_drinks pd
                              join drinks d
                                   on pd.drink_id = d.drink_id and d.title = _title and pd.place_id = new.place_id);
        if (new.price != old_price) then
            raise exception 'Error! Trying to add new item with different price.';
        end if;
    end if;
    return new;
end;
$$ language plpgsql;

create trigger places_drinks_correction_tr
    before insert
    on places_drinks
    for each row
execute procedure places_drinks_correction();

insert into places_drinks(place_id, drink_id, price, amount)
values (1, (select drink_id from drinks where title = 'test' limit 1), 100, 1);

insert into places_drinks(place_id, drink_id, price, amount)
values (1, (select drink_id from drinks where title = 'test' offset 1 limit 1), 200, 1);