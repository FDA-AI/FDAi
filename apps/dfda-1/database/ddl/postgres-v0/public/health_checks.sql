create table health_checks
(
    id             serial
        primary key,
    resource_name  varchar(255)     not null,
    resource_slug  varchar(255)     not null,
    target_name    varchar(255)     not null,
    target_slug    varchar(255)     not null,
    target_display varchar(255)     not null,
    healthy        boolean          not null,
    error_message  text,
    runtime        double precision not null,
    value          varchar(255),
    value_human    varchar(255),
    created_at     timestamp(0)     not null
);

alter table health_checks
    owner to postgres;

create index health_checks_resource_slug_index
    on health_checks (resource_slug);

create index health_checks_target_slug_index
    on health_checks (target_slug);

create index health_checks_created_at_index
    on health_checks (created_at);

