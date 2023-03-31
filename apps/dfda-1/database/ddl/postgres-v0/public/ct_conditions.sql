create table ct_conditions
(
    id                   serial
        primary key,
    name                 varchar(100)                           not null
        constraint "conName"
            unique,
    variable_id          integer                                not null
        constraint ct_conditions_variable_id_uindex
            unique
        constraint ct_conditions_variables_id_fk
            references variables,
    updated_at           timestamp(0) default CURRENT_TIMESTAMP not null,
    created_at           timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at           timestamp(0),
    number_of_treatments integer                                not null,
    number_of_symptoms   integer,
    number_of_causes     integer                                not null
);

alter table ct_conditions
    owner to postgres;

