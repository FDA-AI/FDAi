create table phrases
(
    client_id                 varchar(80)                            not null
        constraint phrases_client_id_fk
            references oa_clients,
    created_at                timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at                timestamp(0),
    id                        serial
        primary key,
    image                     varchar(100),
    text                      text                                   not null,
    title                     varchar(80),
    type                      varchar(80)                            not null,
    updated_at                timestamp(0) default CURRENT_TIMESTAMP not null,
    url                       varchar(100),
    user_id                   bigint                                 not null
        constraint phrases_user_id_fk
            references wp_users,
    responding_to_phrase_id   integer,
    response_phrase_id        integer,
    recipient_user_ids        text,
    number_of_times_heard     integer,
    interpretative_confidence double precision
);

alter table phrases
    owner to postgres;

create index phrases_client_id_fk
    on phrases (client_id);

