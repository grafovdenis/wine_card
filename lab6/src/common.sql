create sequence if not exists test_table_seq as int start with 1;

create table if not exists test_table
(
    id    int primary key not null,
    value int
);

create or replace function test_id_correction() returns trigger as
$$
begin
    new.id = nextval('test_table_seq');
    return new;
end;
$$ language plpgsql;

create trigger auto_upd
    before insert
    on test_table
    for each row
execute procedure test_id_correction();

insert into test_table (value)
values (1),
       (2),
       (3),
       (4);

select *
from test_table;

drop table if exists test_table;
drop sequence if exists test_table_seq;

---

create table if not exists test_table_master
(
    id    int primary key not null,
    value int
);

create table if not exists test_table_slave
(
    id        int primary key not null,
    master_id int references test_table_master (id),
    name      text
);

create or replace function slave_update_before_func()
    returns trigger as
$$
begin
    if (tg_op = 'DELETE') then
        delete from test_table_slave where master_id = old.id;
        return old;
    end if;
    raise notice 'start updating';
    --create fake record in master
    insert into test_table_master values (-1, 0);
    --redirect slave to fake record
    update test_table_slave set master_id = -1 where master_id = old.id;
    raise notice 'slave redirected';
    return new;
end;
$$ language plpgsql;

create or replace function slave_update_after_func()
    returns trigger as
$$
begin
    --redirect slave to new record
    update test_table_slave set master_id = new.id where master_id = -1;
    raise notice 'slave redirect back';
    --delete fake record
    delete from test_table_master where id = -1;
    return new;
end;
$$ language plpgsql;

create trigger slave_update_before
    before update or delete
    on test_table_master
    for each row
execute procedure slave_update_before_func();

create trigger slave_update_after
    after update
    on test_table_master
    for each row
execute procedure slave_update_after_func();

insert into test_table_master
values (1, 1),
       (2, 2),
       (3, 3);

insert into test_table_slave
values (1, 1, 'first slave of 1'),
       (2, 1, 'second slave of 2'),
       (3, 2, 'first slave of 2');

update test_table_master
set id = 4
where id = 2;

delete
from test_table_master
where id = 1;