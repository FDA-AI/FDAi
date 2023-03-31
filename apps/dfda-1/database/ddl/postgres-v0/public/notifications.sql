create table notifications
(
    id              char(36)     not null
        primary key,
    type            varchar(255) not null,
    notifiable_type varchar(255) not null,
    notifiable_id   bigint       not null,
    data            text         not null,
    read_at         timestamp(0),
    created_at      timestamp(0),
    updated_at      timestamp(0),
    deleted_at      timestamp(0)
);

alter table notifications
    owner to postgres;

create index notifications_notifiable_type_notifiable_id_index
    on notifications (notifiable_type, notifiable_id);

