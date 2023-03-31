create table ip_data
(
    id             serial
        primary key,
    created_at     timestamp(0) default CURRENT_TIMESTAMP,
    deleted_at     timestamp(0),
    updated_at     timestamp(0),
    ip             varchar(255) not null
        constraint ip_data_ip_uindex
            unique,
    hostname       varchar(255),
    type           varchar(255),
    continent_code varchar(255),
    continent_name varchar(255),
    country_code   varchar(255),
    country_name   varchar(255),
    region_code    varchar(255),
    region_name    varchar(255),
    city           varchar(255),
    zip            varchar(255),
    latitude       double precision,
    longitude      double precision,
    location       text,
    time_zone      text,
    currency       text,
    connection     text,
    security       text
);

alter table ip_data
    owner to postgres;

