create table user_variable_predictor_category
(
    id                                 serial
        primary key,
    user_variable_id                   integer                                not null
        constraint user_variable_predictor_category_user_variables_id_fk
            references user_variables,
    variable_id                        integer                                not null
        constraint user_variable_predictor_category_variables_id_fk
            references variables,
    variable_category_id               smallint                               not null
        constraint user_variable_predictor_category_variable_categories_id_fk
            references variable_categories,
    number_of_predictor_user_variables integer                                not null,
    created_at                         timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at                         timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at                         timestamp(0),
    constraint user_variable_predictor_category_uindex
        unique (user_variable_id, variable_category_id)
);

alter table user_variable_predictor_category
    owner to postgres;

create index user_variable_predictor_category_variables_id_fk
    on user_variable_predictor_category (variable_id);

create index user_variable_predictor_category_variable_categories_id_fk
    on user_variable_predictor_category (variable_category_id);

