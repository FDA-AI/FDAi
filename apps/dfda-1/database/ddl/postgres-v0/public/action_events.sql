create table action_events
(
    id              bigserial
        primary key,
    batch_id        char(36)                                         not null,
    user_id         bigint                                           not null,
    name            varchar(255)                                     not null,
    actionable_type varchar(255)                                     not null,
    actionable_id   bigint                                           not null,
    target_type     varchar(255)                                     not null,
    target_id       bigint                                           not null,
    model_type      varchar(255)                                     not null,
    model_id        bigint,
    fields          text                                             not null,
    status          varchar(25) default 'running'::character varying not null,
    exception       text                                             not null,
    created_at      timestamp(0),
    updated_at      timestamp(0),
    original        text,
    changes         text
);

alter table action_events
    owner to postgres;

create index action_events_actionable_type_actionable_id_index
    on action_events (actionable_type, actionable_id);

create index action_events_batch_id_model_type_model_id_index
    on action_events (batch_id, model_type, model_id);

create index action_events_user_id_index
    on action_events (user_id);

