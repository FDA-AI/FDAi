create table correlation_usefulness_votes
(
    id                       serial
        primary key,
    cause_variable_id        integer                                not null
        constraint correlation_usefulness_votes_cause_variables_id_fk
            references variables,
    effect_variable_id       integer                                not null
        constraint correlation_usefulness_votes_effect_variables_id_fk
            references variables,
    correlation_id           integer
        constraint correlation_usefulness_votes_correlations_id_fk
            references correlations,
    global_variable_relationship_id integer
        constraint correlation_usefulness_votes_global_variable_relationships_id_fk
            references global_variable_relationships,
    user_id                  bigint                                 not null
        constraint "correlation_usefulness_votes_wp_users_ID_fk"
            references wp_users,
    vote                     integer                                not null,
    created_at               timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at               timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at               timestamp(0),
    client_id                varchar(80)
        constraint correlation_usefulness_votes_client_id_fk
            references oa_clients,
    is_public                boolean,
    constraint correlation_usefulness_votes_user_cause_effect_uindex
        unique (user_id, cause_variable_id, effect_variable_id)
);

comment on column correlation_usefulness_votes.vote is 'The opinion of the data owner on whether or not knowledge of this
                    relationship is useful in helping them improve an outcome of interest.
                    -1 corresponds to a down vote. 1 corresponds to an up vote. 0 corresponds to removal of a
                    previous vote.  null corresponds to never having voted before.';

alter table correlation_usefulness_votes
    owner to postgres;

create index correlation_usefulness_votes_cause_variables_id_fk
    on correlation_usefulness_votes (cause_variable_id);

create index correlation_usefulness_votes_effect_variables_id_fk
    on correlation_usefulness_votes (effect_variable_id);

create index correlation_usefulness_votes_correlations_id_fk
    on correlation_usefulness_votes (correlation_id);

create index correlation_usefulness_votes_global_variable_relationships_id_fk
    on correlation_usefulness_votes (global_variable_relationship_id);

create index correlation_usefulness_votes_client_id_fk
    on correlation_usefulness_votes (client_id);

