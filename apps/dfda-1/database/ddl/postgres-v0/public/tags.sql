create table tags
(
    id           serial
        primary key,
    name         json not null,
    slug         json not null,
    type         varchar(255),
    order_column integer,
    created_at   timestamp(0),
    updated_at   timestamp(0)
);

alter table tags
    owner to postgres;

