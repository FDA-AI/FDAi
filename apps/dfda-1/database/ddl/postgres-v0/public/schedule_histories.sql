create table schedule_histories
(
    id          serial
        primary key,
    schedule_id integer      not null
        constraint schedule_histories_schedule_id_foreign
            references schedules,
    command     varchar(255) not null,
    params      text,
    output      text         not null,
    options     text,
    created_at  timestamp(0),
    updated_at  timestamp(0)
);

alter table schedule_histories
    owner to postgres;

create index schedule_histories_schedule_id_foreign
    on schedule_histories (schedule_id);

