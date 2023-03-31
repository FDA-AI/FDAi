create table ct_condition_cause
(
    id                    serial
        primary key,
    condition_id          integer                                not null
        constraint ct_condition_cause_ct_conditions_id_condition_fk
            references ct_conditions,
    cause_id              integer                                not null
        constraint ct_condition_cause_ct_causes_cause_fk
            references ct_causes,
    condition_variable_id integer                                not null
        constraint ct_condition_cause_variables_id_condition_fk
            references variables,
    cause_variable_id     integer                                not null
        constraint ct_condition_cause_variables_id_fk
            references variables,
    votes_percent         integer                                not null,
    updated_at            timestamp(0) default CURRENT_TIMESTAMP not null,
    created_at            timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at            timestamp(0),
    constraint ct_condition_cause_cause_id_condition_id_uindex
        unique (cause_id, condition_id),
    constraint ct_condition_cause_cause_uindex
        unique (cause_variable_id, condition_variable_id)
);

alter table ct_condition_cause
    owner to postgres;

create index ct_condition_cause_ct_conditions_id_condition_fk
    on ct_condition_cause (condition_id);

create index ct_condition_cause_variables_id_condition_fk
    on ct_condition_cause (condition_variable_id);

