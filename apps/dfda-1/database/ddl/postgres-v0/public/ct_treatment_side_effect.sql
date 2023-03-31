create table ct_treatment_side_effect
(
    id                      serial
        primary key,
    treatment_variable_id   integer                                not null
        constraint treatment_variables_id_fk
            references variables,
    side_effect_variable_id integer                                not null
        constraint side_effect_variables_id_fk
            references variables,
    treatment_id            integer                                not null
        constraint treatment_side_effect_treatments_id_fk
            references ct_treatments,
    side_effect_id          integer                                not null
        constraint treatment_side_effect_side_effects_id_fk
            references ct_side_effects,
    votes_percent           integer                                not null,
    updated_at              timestamp(0) default CURRENT_TIMESTAMP not null,
    created_at              timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at              timestamp(0),
    constraint treatment_id_side_effect_id_uindex
        unique (treatment_id, side_effect_id),
    constraint treatment_variable_id_side_effect_variable_id_uindex
        unique (treatment_variable_id, side_effect_variable_id)
);

alter table ct_treatment_side_effect
    owner to postgres;

create index side_effect_variables_id_fk
    on ct_treatment_side_effect (side_effect_variable_id);

create index treatment_side_effect_side_effects_id_fk
    on ct_treatment_side_effect (side_effect_id);

