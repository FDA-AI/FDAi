create table ct_condition_symptom
(
    id                    serial
        primary key,
    condition_variable_id integer                                not null
        constraint ct_condition_symptom_variables_condition_fk
            references variables,
    condition_id          integer                                not null
        constraint ct_condition_symptom_conditions_fk
            references ct_conditions,
    symptom_variable_id   integer                                not null
        constraint ct_condition_symptom_variables_symptom_fk
            references variables,
    symptom_id            integer                                not null
        constraint ct_condition_symptom_symptoms_fk
            references ct_symptoms,
    votes                 integer                                not null,
    extreme               integer,
    severe                integer,
    moderate              integer,
    mild                  integer,
    minimal               integer,
    no_symptoms           integer,
    updated_at            timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at            timestamp(0),
    created_at            timestamp(0) default CURRENT_TIMESTAMP not null,
    constraint ct_condition_symptom_condition_uindex
        unique (condition_variable_id, symptom_variable_id),
    constraint ct_condition_symptom_variable_id_uindex
        unique (symptom_variable_id, condition_variable_id)
);

alter table ct_condition_symptom
    owner to postgres;

create index ct_condition_symptom_conditions_fk
    on ct_condition_symptom (condition_id);

create index ct_condition_symptom_symptoms_fk
    on ct_condition_symptom (symptom_id);

