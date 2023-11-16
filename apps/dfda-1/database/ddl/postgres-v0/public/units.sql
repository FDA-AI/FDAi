create table units
(
    id                                               smallserial
        primary key,
    name                                             varchar(64)                            not null
        constraint "units_name_UNIQUE"
            unique,
    abbreviated_name                                 varchar(16)                            not null
        constraint "abbr_name_UNIQUE"
            unique,
    unit_category_id                                 smallint                               not null,
    minimum_value                                    double precision,
    maximum_value                                    double precision,
    created_at                                       timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at                                       timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at                                       timestamp(0),
    filling_type                                     varchar(255)                           not null
        constraint units_filling_type_check
            check ((filling_type)::text = ANY
                   ((ARRAY ['zero'::character varying, 'none'::character varying, 'interpolation'::character varying, 'value'::character varying])::text[])),
    number_of_outcome_population_studies             integer,
    number_of_common_tags_where_tag_variable_unit    integer,
    number_of_common_tags_where_tagged_variable_unit integer,
    number_of_outcome_case_studies                   integer,
    number_of_measurements                           integer,
    number_of_user_variables_where_default_unit      integer,
    number_of_variable_categories_where_default_unit integer,
    number_of_variables_where_default_unit           integer,
    advanced                                         boolean                                not null,
    manual_tracking                                  boolean                                not null,
    filling_value                                    double precision,
    scale                                            varchar(255)                           not null
        constraint units_scale_check
            check ((scale)::text = ANY
                   ((ARRAY ['nominal'::character varying, 'interval'::character varying, 'ratio'::character varying, 'ordinal'::character varying])::text[])),
    conversion_steps                                 text,
    maximum_daily_value                              double precision,
    sort_order                                       integer,
    slug                                             varchar(200)
        constraint units_slug_uindex
            unique
);

comment on column units.name is 'Unit name';

comment on column units.abbreviated_name is 'Unit abbreviation';

comment on column units.unit_category_id is 'Unit category ID';

comment on column units.minimum_value is 'The minimum value for a single measurement. ';

comment on column units.maximum_value is 'The maximum value for a single measurement';

comment on column units.filling_type is 'The filling type specifies how periods of missing data should be treated. ';

comment on column units.number_of_outcome_population_studies is 'Number of Global Population Studies for this Cause Unit.
                [Formula:
                    update units
                        left join (
                            select count(id) as total, cause_unit_id
                            from global_variable_relationships
                            group by cause_unit_id
                        )
                        as grouped on units.id = grouped.cause_unit_id
                    set units.number_of_outcome_population_studies = count(grouped.total)
                ]
                ';

comment on column units.number_of_common_tags_where_tag_variable_unit is 'Number of Common Tags for this Tag Variable Unit.
                [Formula:
                    update units
                        left join (
                            select count(id) as total, tag_variable_unit_id
                            from common_tags
                            group by tag_variable_unit_id
                        )
                        as grouped on units.id = grouped.tag_variable_unit_id
                    set units.number_of_common_tags_where_tag_variable_unit = count(grouped.total)
                ]
                ';

comment on column units.number_of_common_tags_where_tagged_variable_unit is 'Number of Common Tags for this Tagged Variable Unit.
                [Formula:
                    update units
                        left join (
                            select count(id) as total, tagged_variable_unit_id
                            from common_tags
                            group by tagged_variable_unit_id
                        )
                        as grouped on units.id = grouped.tagged_variable_unit_id
                    set units.number_of_common_tags_where_tagged_variable_unit = count(grouped.total)
                ]
                ';

comment on column units.number_of_outcome_case_studies is 'Number of Individual Case Studies for this Cause Unit.
                [Formula:
                    update units
                        left join (
                            select count(id) as total, cause_unit_id
                            from user_variable_relationships
                            group by cause_unit_id
                        )
                        as grouped on units.id = grouped.cause_unit_id
                    set units.number_of_outcome_case_studies = count(grouped.total)
                ]
                ';

comment on column units.number_of_measurements is 'Number of Measurements for this Unit.
                    [Formula: update units
                        left join (
                            select count(id) as total, unit_id
                            from measurements
                            group by unit_id
                        )
                        as grouped on units.id = grouped.unit_id
                    set units.number_of_measurements = count(grouped.total)]';

comment on column units.number_of_user_variables_where_default_unit is 'Number of User Variables for this Default Unit.
                    [Formula: update units
                        left join (
                            select count(id) as total, default_unit_id
                            from user_variables
                            group by default_unit_id
                        )
                        as grouped on units.id = grouped.default_unit_id
                    set units.number_of_user_variables_where_default_unit = count(grouped.total)]';

comment on column units.number_of_variable_categories_where_default_unit is 'Number of Variable Categories for this Default Unit.
                    [Formula: update units
                        left join (
                            select count(id) as total, default_unit_id
                            from variable_categories
                            group by default_unit_id
                        )
                        as grouped on units.id = grouped.default_unit_id
                    set units.number_of_variable_categories_where_default_unit = count(grouped.total)]';

comment on column units.number_of_variables_where_default_unit is 'Number of Variables for this Default Unit.
                    [Formula: update units
                        left join (
                            select count(id) as total, default_unit_id
                            from variables
                            group by default_unit_id
                        )
                        as grouped on units.id = grouped.default_unit_id
                    set units.number_of_variables_where_default_unit = count(grouped.total)]';

comment on column units.advanced is 'Advanced units are rarely used and should generally be hidden or at the bottom of selector lists';

comment on column units.manual_tracking is 'Include manual tracking units in selector when manually recording a measurement. ';

comment on column units.filling_value is 'The filling value is substituted used when data is missing if the filling type is set to value.';

comment on column units.scale is '
Ordinal is used to simply depict the order of variables and not the difference between each of the variables. Ordinal scales are generally used to depict non-mathematical ideas such as frequency, satisfaction, happiness, a degree of pain etc.

Ratio Scale not only produces the order of variables but also makes the difference between variables known along with information on the value of true zero.

Interval scale contains all the properties of ordinal scale, in addition to which, it offers a calculation of the difference between variables. The main characteristic of this scale is the equidistant difference between objects. Interval has no pre-decided starting point or a true zero value.

Nominal, also called the categorical variable scale, is defined as a scale used for labeling variables into distinct classifications and doesn’t involve a quantitative value or order.
';

comment on column units.conversion_steps is 'An array of mathematical operations, each containing a operation and value field to apply to the value in the current unit to convert it to the default unit for the unit category. ';

comment on column units.maximum_daily_value is 'The maximum aggregated measurement value over a single day.';

comment on column units.slug is 'The slug is the part of a URL that identifies a page in human-readable keywords.';

alter table units
    owner to postgres;

create index "fk_unitCategory"
    on units (unit_category_id);

