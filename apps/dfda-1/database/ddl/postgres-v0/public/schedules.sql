create table schedules
(
    id                       serial
        primary key,
    command                  varchar(255)          not null,
    command_custom           varchar(255),
    params                   text,
    expression               varchar(255)          not null,
    environments             varchar(255),
    options                  text,
    log_filename             varchar(255),
    even_in_maintenance_mode boolean default false not null,
    without_overlapping      boolean default false not null,
    on_one_server            boolean default false not null,
    webhook_before           varchar(255),
    webhook_after            varchar(255),
    email_output             varchar(255),
    sendmail_error           boolean default false not null,
    log_success              boolean default true  not null,
    log_error                boolean default true  not null,
    status                   boolean default true  not null,
    run_in_background        boolean default false not null,
    groups                   varchar(255),
    created_at               timestamp(0),
    updated_at               timestamp(0),
    deleted_at               timestamp(0),
    sendmail_success         boolean default false not null
);

alter table schedules
    owner to postgres;

