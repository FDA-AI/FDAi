create table love_reactants
(
    id         bigserial
        primary key,
    type       varchar(255) not null,
    created_at timestamp(0),
    updated_at timestamp(0)
);

alter table love_reactants
    owner to postgres;

create index love_reactants_type_index
    on love_reactants (type);

