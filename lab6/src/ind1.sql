create or replace function fill_avg_price_drinks() returns trigger as
$$
begin
    new.price_per_item = (select avg(average_price) from drinks);
    return new;
end;
$$ language plpgsql;

create or replace function fill_avg_price_food() returns trigger as
$$
begin
    new.price_per_item = (select avg(average_price) from food);
    return new;
end;
$$ language plpgsql;

create trigger fill_avg_price_drinks_trig
    before insert
    on supplies_drinks
    for each row
execute procedure fill_avg_price_drinks();

create trigger fill_avg_price_food
    before insert
    on supplies_food
    for each row
execute procedure fill_avg_price_food();

insert into supplies_drinks (place_id, drink_id, amount, date)
values (1, 1, 1, now());

insert into supplies_food (place_id, food_id, amount, date)
values (1, 1, 1, now());

select * from supplies_drinks where date is not null order by date desc limit 1;
select * from supplies_food where date is not null order by date desc limit 1;