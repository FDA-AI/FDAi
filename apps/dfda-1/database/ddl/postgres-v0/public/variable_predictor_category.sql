create table variable_predictor_category
(
    id                            serial
        primary key,
    variable_id                   integer                                not null
        constraint variable_predictor_category_variables_id_fk
            references variables,
    variable_category_id          smallint                               not null
        constraint variable_predictor_category_variable_categories_id_fk
            references variable_categories,
    number_of_predictor_variables integer                                not null,
    created_at                    timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at                    timestamp(0) default CURRENT_TIMESTAMP not null
);

alter table variable_predictor_category
    owner to postgres;

