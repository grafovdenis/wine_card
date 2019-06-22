create or replace function get_discounts() returns json
as
$$
declare
    result json;
begin
    drop table if exists disc;
    create table if not exists disc as (select p.title, p.address, d.description, d.weekday
                                        from discounts d
                                                 join places p on d.place_id = p.place_id);
    result = (select json_object_agg(concat(disc.title, ' на ', disc.address),
                                     json_build_object('weekday', disc.weekday, 'discount', disc.description))
              from disc);
    return result;
end
$$ language plpgsql;

select *
from get_discounts();