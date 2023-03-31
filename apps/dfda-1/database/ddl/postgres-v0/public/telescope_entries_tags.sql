create table telescope_entries_tags
(
    entry_uuid char(36)     not null
        constraint telescope_entries_tags_entry_uuid_foreign
            references telescope_entries (uuid)
            on delete cascade,
    tag        varchar(255) not null
);

alter table telescope_entries_tags
    owner to postgres;

create index telescope_entries_tags_entry_uuid_tag_index
    on telescope_entries_tags (entry_uuid, tag);

create index telescope_entries_tags_tag_index
    on telescope_entries_tags (tag);

