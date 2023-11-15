create table variable_categories
(
    id                                           smallserial
        primary key,
    name                                         varchar(64)                                   not null,
    filling_value                                double precision,
    maximum_allowed_value                        double precision,
    minimum_allowed_value                        double precision,
    duration_of_action                           integer      default 86400                    not null,
    onset_delay                                  integer      default 0                        not null,
    combination_operation                        varchar(255) default 'SUM'::character varying not null
        constraint variable_categories_combination_operation_check
            check ((combination_operation)::text = ANY
                   ((ARRAY ['SUM'::character varying, 'MEAN'::character varying])::text[])),
    cause_only                                   boolean      default false                    not null,
    outcome                                      boolean,
    created_at                                   timestamp(0) default CURRENT_TIMESTAMP        not null,
    updated_at                                   timestamp(0) default CURRENT_TIMESTAMP        not null,
    image_url                                    text,
    default_unit_id                              smallint     default '12'::smallint
        constraint variable_categories_default_unit_id_fk
            references units,
    deleted_at                                   timestamp(0),
    manual_tracking                              boolean      default false,
    minimum_allowed_seconds_between_measurements integer,
    average_seconds_between_measurements         integer,
    median_seconds_between_measurements          integer,
    wp_post_id                                   bigint
        constraint "variable_categories_wp_posts_ID_fk"
            references wp_posts,
    filling_type                                 varchar(255)
        constraint variable_categories_filling_type_check
            check ((filling_type)::text = ANY
                   ((ARRAY ['zero'::character varying, 'none'::character varying, 'interpolation'::character varying, 'value'::character varying])::text[])),
    number_of_outcome_population_studies         integer,
    number_of_predictor_population_studies       integer,
    number_of_outcome_case_studies               integer,
    number_of_predictor_case_studies             integer,
    number_of_measurements                       integer,
    number_of_user_variables                     integer,
    number_of_variables                          integer,
    is_public                                    boolean,
    synonyms                                     varchar(600)                                  not null,
    amazon_product_category                      varchar(100)                                  not null,
    boring                                       boolean,
    effect_only                                  boolean,
    predictor                                    boolean,
    font_awesome                                 varchar(100),
    ion_icon                                     varchar(100),
    more_info                                    varchar(255),
    valence                                      varchar(255)                                  not null
        constraint variable_categories_valence_check
            check ((valence)::text = ANY
                   ((ARRAY ['positive'::character varying, 'negative'::character varying, 'neutral'::character varying])::text[])),
    name_singular                                varchar(255)                                  not null,
    sort_order                                   integer,
    slug                                         varchar(200)                                  not null
        constraint vc_slug_uindex
            unique,
    is_goal                                      varchar(255)                                  not null
        constraint variable_categories_is_goal_check
            check ((is_goal)::text = ANY
                   ((ARRAY ['ALWAYS'::character varying, 'SOMETIMES'::character varying, 'NEVER'::character varying])::text[])),
    controllable                                 varchar(255)                                  not null
        constraint variable_categories_controllable_check
            check ((controllable)::text = ANY
                   ((ARRAY ['ALWAYS'::character varying, 'SOMETIMES'::character varying, 'NEVER'::character varying])::text[]))
);

comment on column variable_categories.name is 'Name of the category';

comment on column variable_categories.filling_value is 'Value for replacing null measurements';

comment on column variable_categories.maximum_allowed_value is 'Maximum recorded value of this category';

comment on column variable_categories.minimum_allowed_value is 'Minimum recorded value of this category';

comment on column variable_categories.duration_of_action is 'How long the effect of a measurement in this variable lasts';

comment on column variable_categories.onset_delay is 'How long it takes for a measurement in this variable to take effect';

comment on column variable_categories.combination_operation is 'How to combine values of this variable (for instance, to see a summary of the values over a month) SUM or MEAN';

comment on column variable_categories.cause_only is 'A value of 1 indicates that this category is generally a cause in a causal relationship.  An example of a causeOnly category would be a category such as Work which would generally not be influenced by the behaviour of the user';

comment on column variable_categories.image_url is 'Image URL';

comment on column variable_categories.default_unit_id is 'ID of the default unit for the category';

comment on column variable_categories.manual_tracking is 'Should we include in manual tracking searches?';

comment on column variable_categories.number_of_outcome_population_studies is 'Number of Global Population Studies for this Cause Variable Category.
                [Formula:
                    update variable_categories
                        left join (
                            select count(id) as total, cause_variable_category_id
                            from global_variable_relationships
                            group by cause_variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.cause_variable_category_id
                    set variable_categories.number_of_outcome_population_studies = count(grouped.total)
                ]
                ';

comment on column variable_categories.number_of_predictor_population_studies is 'Number of Global Population Studies for this Effect Variable Category.
                [Formula:
                    update variable_categories
                        left join (
                            select count(id) as total, effect_variable_category_id
                            from global_variable_relationships
                            group by effect_variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.effect_variable_category_id
                    set variable_categories.number_of_predictor_population_studies = count(grouped.total)
                ]
                ';

comment on column variable_categories.number_of_outcome_case_studies is 'Number of Individual Case Studies for this Cause Variable Category.
                [Formula:
                    update variable_categories
                        left join (
                            select count(id) as total, cause_variable_category_id
                            from correlations
                            group by cause_variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.cause_variable_category_id
                    set variable_categories.number_of_outcome_case_studies = count(grouped.total)
                ]
                ';

comment on column variable_categories.number_of_predictor_case_studies is 'Number of Individual Case Studies for this Effect Variable Category.
                [Formula:
                    update variable_categories
                        left join (
                            select count(id) as total, effect_variable_category_id
                            from correlations
                            group by effect_variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.effect_variable_category_id
                    set variable_categories.number_of_predictor_case_studies = count(grouped.total)
                ]
                ';

comment on column variable_categories.number_of_measurements is 'Number of Measurements for this Variable Category.
                    [Formula: update variable_categories
                        left join (
                            select count(id) as total, variable_category_id
                            from measurements
                            group by variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.variable_category_id
                    set variable_categories.number_of_measurements = count(grouped.total)]';

comment on column variable_categories.number_of_user_variables is 'Number of User Variables for this Variable Category.
                    [Formula: update variable_categories
                        left join (
                            select count(id) as total, variable_category_id
                            from user_variables
                            group by variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.variable_category_id
                    set variable_categories.number_of_user_variables = count(grouped.total)]';

comment on column variable_categories.number_of_variables is 'Number of Variables for this Variable Category.
                    [Formula: update variable_categories
                        left join (
                            select count(id) as total, variable_category_id
                            from variables
                            group by variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.variable_category_id
                    set variable_categories.number_of_variables = count(grouped.total)]';

comment on column variable_categories.synonyms is 'The primary name and any synonyms for it. This field should be used for non-specific searches.';

comment on column variable_categories.amazon_product_category is 'The Amazon equivalent product category.';

comment on column variable_categories.boring is 'If boring, the category should be hidden by default.';

comment on column variable_categories.effect_only is 'effect_only is true if people would never be interested in the effects of most variables in the category.';

comment on column variable_categories.predictor is 'Predictor is true if people would like to know the effects of most variables in the category.';

comment on column variable_categories.more_info is 'More information displayed when the user is adding reminders and going through the onboarding process. ';

comment on column variable_categories.valence is 'Set the valence positive if more is better for all the variables in the category, negative if more is bad, and neutral if none of the variables have such a valence. Valence is null if there is not a consistent valence for all variables in the category. ';

comment on column variable_categories.name_singular is 'The singular version of the name.';

comment on column variable_categories.slug is 'The slug is the part of a URL that identifies a page in human-readable keywords.';

comment on column variable_categories.is_goal is 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  The foods you eat are not generally an objective end in themselves. ';

comment on column variable_categories.controllable is 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  Symptom severity is not directly controllable. ';

alter table variable_categories
    owner to postgres;

create index variable_categories_default_unit_id_fk
    on variable_categories (default_unit_id);

create index "variable_categories_wp_posts_ID_fk"
    on variable_categories (wp_post_id);

