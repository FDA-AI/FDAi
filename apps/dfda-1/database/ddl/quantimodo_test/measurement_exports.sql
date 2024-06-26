create table quantimodo_test.measurement_exports
(
    id            int auto_increment
        primary key,
    user_id       bigint unsigned                                      not null,
    client_id     varchar(255)                                         null,
    status        varchar(32)                                          not null comment 'Status of Measurement Export',
    type          enum ('user', 'app')       default 'user'            not null comment 'Whether user''s measurement export request or app users',
    output_type   enum ('csv', 'xls', 'pdf') default 'csv'             not null comment 'Output type of export file',
    error_message varchar(255)                                         null comment 'Error message',
    created_at    timestamp                  default CURRENT_TIMESTAMP not null,
    updated_at    timestamp                  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at    timestamp                                            null,
    constraint measurement_exports_client_id_fk
        foreign key (client_id) references quantimodo_test.oa_clients (client_id),
    constraint measurement_exports_user_id_fk
        foreign key (user_id) references quantimodo_test.wp_users (ID)
)
    charset = utf8mb3;

