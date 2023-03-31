create table love_reaction_types
(
    id         bigserial
        primary key,
    name       varchar(255) not null,
    mass       smallint     not null,
    created_at timestamp(0),
    updated_at timestamp(0)
);

alter table love_reaction_types
    owner to postgres;

create index love_reaction_types_name_index
    on love_reaction_types (name);

