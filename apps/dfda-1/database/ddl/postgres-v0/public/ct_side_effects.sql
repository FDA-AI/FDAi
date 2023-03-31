create table ct_side_effects
(
    id                   serial
        primary key,
    name                 varchar(100)                           not null
        constraint "seName"
            unique,
    variable_id          integer                                not null
        constraint ct_side_effects_variable_id_uindex
            unique
        constraint ct_side_effects_variables_id_fk
            references variables,
    updated_at           timestamp(0) default CURRENT_TIMESTAMP not null,
    created_at           timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at           timestamp(0),
    number_of_treatments integer                                not null
);

alter table ct_side_effects
    owner to postgres;

