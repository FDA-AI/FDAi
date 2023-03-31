create table telescope_entries
(
    sequence                bigserial
        primary key,
    uuid                    char(36)             not null
        constraint telescope_entries_uuid_unique
            unique,
    batch_id                char(36)             not null,
    family_hash             varchar(255),
    should_display_on_index boolean default true not null,
    type                    varchar(20)          not null,
    content                 text                 not null,
    created_at              timestamp(0)
);

alter table telescope_entries
    owner to postgres;

create index telescope_entries_type_should_display_on_index_index
    on telescope_entries (type, should_display_on_index);

create index telescope_entries_batch_id_index
    on telescope_entries (batch_id);

create index telescope_entries_family_hash_index
    on telescope_entries (family_hash);

