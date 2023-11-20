create table intuitive_condition_cause_votes
(
    id                    serial
        primary key,
    condition_id          integer                                not null
        constraint intuitive_condition_cause_votes_ct_conditions_id_condition_fk
            references ct_conditions,
    cause_id              integer                                not null
        constraint intuitive_condition_cause_votes_ct_causes_cause_fk
            references ct_causes,
    condition_variable_id integer                                not null
        constraint intuitive_condition_cause_votes_variables_id_condition_fk
            references variables,
    cause_variable_id     integer                                not null
        constraint intuitive_condition_cause_votes_variables_id_fk
            references variables,
    votes_percent         integer                                not null,
    updated_at            timestamp(0) default CURRENT_TIMESTAMP not null,
    created_at            timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at            timestamp(0),
    constraint intuitive_condition_cause_votes_cause_id_condition_id_uindex
        unique (cause_id, condition_id),
    constraint intuitive_condition_cause_votes_cause_uindex
        unique (cause_variable_id, condition_variable_id)
);

alter table intuitive_condition_cause_votes
    owner to postgres;

create index intuitive_condition_cause_votes_ct_conditions_id_condition_fk
    on intuitive_condition_cause_votes (condition_id);

create index intuitive_condition_cause_votes_variables_id_condition_fk
    on intuitive_condition_cause_votes (condition_variable_id);

