create table ct_condition_treatment
(
    id                    serial
        primary key,
    condition_id          integer                                not null
        constraint ct_condition_treatment_conditions_id_fk
            references ct_conditions,
    treatment_id          integer                                not null
        constraint ct_condition_treatment_ct_treatments_fk
            references ct_treatments,
    condition_variable_id integer
        constraint ct_condition_treatment_variables_id_fk_2
            references variables,
    treatment_variable_id integer                                not null
        constraint ct_condition_treatment_variables_id_fk
            references variables,
    major_improvement     integer      default 0                 not null,
    moderate_improvement  integer      default 0                 not null,
    no_effect             integer      default 0                 not null,
    worse                 integer      default 0                 not null,
    much_worse            integer      default 0                 not null,
    popularity            integer      default 0                 not null,
    average_effect        integer      default 0                 not null,
    updated_at            timestamp(0) default CURRENT_TIMESTAMP not null,
    created_at            timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at            timestamp(0),
    constraint treatment_id_condition_id_uindex
        unique (treatment_id, condition_id),
    constraint treatment_variable_id_condition_variable_id_uindex
        unique (treatment_variable_id, condition_variable_id)
);

alter table ct_condition_treatment
    owner to postgres;

create index ct_condition_treatment_conditions_id_fk
    on ct_condition_treatment (condition_id);

create index ct_condition_treatment_variables_id_fk_2
    on ct_condition_treatment (condition_variable_id);

