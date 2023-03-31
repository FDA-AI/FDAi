create table ct_symptoms
(
    id                   serial
        primary key,
    name                 varchar(100)                           not null
        constraint "symName"
            unique,
    variable_id          integer                                not null
        constraint ct_symptoms_variable_id_uindex
            unique
        constraint ct_symptoms_variables_id_fk
            references variables,
    updated_at           timestamp(0) default CURRENT_TIMESTAMP not null,
    created_at           timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at           timestamp(0),
    number_of_conditions integer                                not null
);

alter table ct_symptoms
    owner to postgres;

