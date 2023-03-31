create table media
(
    id                bigserial
        primary key,
    model_type        varchar(255) not null,
    model_id          bigint       not null,
    collection_name   varchar(255) not null,
    name              varchar(255) not null,
    file_name         varchar(255) not null,
    mime_type         varchar(255),
    disk              varchar(255) not null,
    size              bigint       not null,
    manipulations     json         not null,
    custom_properties json         not null,
    responsive_images json         not null,
    order_column      integer,
    created_at        timestamp(0),
    updated_at        timestamp(0)
);

alter table media
    owner to postgres;

create index media_model_type_model_id_index
    on media (model_type, model_id);

