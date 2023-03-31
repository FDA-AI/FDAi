create table taggables
(
    tag_id        integer      not null
        constraint taggables_tag_id_foreign
            references tags
            on delete cascade,
    taggable_type varchar(255) not null,
    taggable_id   bigint       not null,
    constraint taggables_tag_id_taggable_id_taggable_type_unique
        unique (tag_id, taggable_id, taggable_type)
);

alter table taggables
    owner to postgres;

create index taggables_taggable_type_taggable_id_index
    on taggables (taggable_type, taggable_id);

