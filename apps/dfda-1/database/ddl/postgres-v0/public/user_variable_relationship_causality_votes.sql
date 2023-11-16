create table correlation_causality_votes
(
    id                       serial
        primary key,
    cause_variable_id        integer                                not null
        constraint correlation_causality_votes_cause_variables_id_fk
            references variables,
    effect_variable_id       integer                                not null
        constraint correlation_causality_votes_effect_variables_id_fk
            references variables,
    correlation_id           integer
        constraint correlation_causality_votes_correlations_id_fk
            references correlations,
    global_variable_relationship_id integer
        constraint correlation_causality_votes_global_variable_relationships_id_fk
            references global_variable_relationships,
    user_id                  bigint                                 not null
        constraint "correlation_causality_votes_wp_users_ID_fk"
            references wp_users,
    vote                     integer                                not null,
    created_at               timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at               timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at               timestamp(0),
    client_id                varchar(80)
        constraint correlation_causality_votes_client_id_fk
            references oa_clients,
    is_public                boolean,
    constraint correlation_causality_votes_user_cause_effect_uindex
        unique (user_id, cause_variable_id, effect_variable_id)
);

comment on column correlation_causality_votes.vote is 'The opinion of the data owner on whether or not there is a plausible
                                mechanism of action by which the predictor variable could influence the outcome variable.';

alter table correlation_causality_votes
    owner to postgres;

create index correlation_causality_votes_cause_variables_id_fk
    on correlation_causality_votes (cause_variable_id);

create index correlation_causality_votes_effect_variables_id_fk
    on correlation_causality_votes (effect_variable_id);

create index correlation_causality_votes_correlations_id_fk
    on correlation_causality_votes (correlation_id);

create index correlation_causality_votes_global_variable_relationships_id_fk
    on correlation_causality_votes (global_variable_relationship_id);

create index correlation_causality_votes_client_id_fk
    on correlation_causality_votes (client_id);

