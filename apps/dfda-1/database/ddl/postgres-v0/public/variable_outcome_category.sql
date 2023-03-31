create table variable_outcome_category
(
    id                          serial
        primary key,
    variable_id                 integer                                not null
        constraint variable_outcome_category_variables_id_fk
            references variables,
    variable_category_id        smallint                               not null
        constraint variable_outcome_category_variable_categories_id_fk
            references variable_categories,
    number_of_outcome_variables integer                                not null,
    created_at                  timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at                  timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at                  timestamp(0),
    constraint variable_outcome_category_uindex
        unique (variable_id, variable_category_id)
);

alter table variable_outcome_category
    owner to postgres;

create index v_outcome_category_variable_categories_id_fk
    on variable_outcome_category (variable_category_id);

