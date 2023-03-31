create table unit_categories
(
    id            smallserial
        primary key,
    name          varchar(64)                            not null
        constraint "unit_categories_name_UNIQUE"
            unique,
    created_at    timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at    timestamp(0) default CURRENT_TIMESTAMP not null,
    can_be_summed boolean      default true              not null,
    deleted_at    timestamp(0),
    sort_order    integer
);

comment on column unit_categories.name is 'Unit category name';

alter table unit_categories
    owner to postgres;

