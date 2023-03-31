create table love_reacters
(
    id         bigserial
        primary key,
    type       varchar(255) not null,
    created_at timestamp(0),
    updated_at timestamp(0)
);

alter table love_reacters
    owner to postgres;

create index love_reacters_type_index
    on love_reacters (type);

