create table common_tags
(
    id                      serial
        primary key,
    tagged_variable_id      integer                                not null
        constraint common_tags_tagged_variable_id_variables_id_fk
            references variables,
    tag_variable_id         integer                                not null
        constraint common_tags_tag_variable_id_variables_id_fk
            references variables,
    number_of_data_points   integer,
    standard_error          double precision,
    tag_variable_unit_id    smallint
        constraint common_tags_tag_variable_unit_id_fk
            references units,
    tagged_variable_unit_id smallint
        constraint common_tags_tagged_variable_unit_id_fk
            references units,
    conversion_factor       double precision                       not null,
    client_id               varchar(80)
        constraint common_tags_client_id_fk
            references oa_clients,
    created_at              timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at              timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at              timestamp(0),
    constraint "UK_tag_tagged"
        unique (tagged_variable_id, tag_variable_id)
);

comment on column common_tags.tagged_variable_id is 'This is the id of the variable being tagged with an ingredient or something.';

comment on column common_tags.tag_variable_id is 'This is the id of the ingredient variable whose value is determined based on the value of the tagged variable.';

comment on column common_tags.number_of_data_points is 'The number of data points used to estimate the mean. ';

comment on column common_tags.standard_error is 'Measure of variability of the
mean value as a function of the number of data points.';

comment on column common_tags.tag_variable_unit_id is 'The id for the unit of the tag (ingredient) variable.';

comment on column common_tags.tagged_variable_unit_id is 'The unit for the source variable to be tagged.';

comment on column common_tags.conversion_factor is 'Number by which we multiply the tagged variable''s value to obtain the tag variable''s value';

alter table common_tags
    owner to postgres;

create index common_tags_tag_variable_id_variables_id_fk
    on common_tags (tag_variable_id);

create index common_tags_tag_variable_unit_id_fk
    on common_tags (tag_variable_unit_id);

create index common_tags_tagged_variable_unit_id_fk
    on common_tags (tagged_variable_unit_id);

create index common_tags_client_id_fk
    on common_tags (client_id);

