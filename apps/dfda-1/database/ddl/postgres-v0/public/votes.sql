create table votes
(
    id                       serial
        primary key,
    client_id                varchar(80)
        constraint votes_client_id_fk
            references oa_clients,
    user_id                  bigint                                 not null
        constraint votes_user_id_fk
            references wp_users,
    value                    integer                                not null,
    created_at               timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at               timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at               timestamp(0),
    cause_variable_id        integer                                not null
        constraint votes_cause_variable_id_fk
            references variables,
    effect_variable_id       integer                                not null
        constraint votes_effect_variable_id_fk_2
            references variables,
    correlation_id           integer
        constraint votes_correlations_id_fk
            references correlations,
    global_variable_relationship_id integer
        constraint votes_global_variable_relationships_id_fk
            references global_variable_relationships
            on delete set null,
    is_public                boolean,
    constraint votes_user_id_cause_variable_id_effect_variable_id_uindex
        unique (user_id, cause_variable_id, effect_variable_id)
);

comment on column votes.value is 'Value of Vote';

alter table votes
    owner to postgres;

create index votes_client_id_fk
    on votes (client_id);

create index votes_cause_variable_id_index
    on votes (cause_variable_id);

create index votes_effect_variable_id_index
    on votes (effect_variable_id);

create index votes_correlations_id_fk
    on votes (correlation_id);

create index votes_global_variable_relationships_id_fk
    on votes (global_variable_relationship_id);

