create table ct_causes
(
    id                   serial
        primary key,
    name                 varchar(100)                           not null
        constraint "causeName"
            unique,
    variable_id          integer                                not null
        constraint ct_causes_variable_id_uindex
            unique
        constraint ct_causes_variables_id_fk
            references variables,
    updated_at           timestamp(0) default CURRENT_TIMESTAMP not null,
    created_at           timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at           timestamp(0),
    number_of_conditions integer                                not null
);

alter table ct_causes
    owner to postgres;

