create table ct_treatments
(
    id                     serial
        primary key,
    name                   varchar(100)                           not null
        constraint "treName"
            unique,
    variable_id            integer                                not null
        constraint ct_treatments_variables_id_fk
            references variables,
    updated_at             timestamp(0) default CURRENT_TIMESTAMP not null,
    created_at             timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at             timestamp(0),
    number_of_conditions   integer,
    number_of_side_effects integer                                not null
);

alter table ct_treatments
    owner to postgres;

create index ct_treatments_variables_id_fk
    on ct_treatments (variable_id);

