create table if not exists property_tags
(
    id          int auto_increment
        primary key,
    name        varchar(100) not null,
    description varchar(100) not null
);

