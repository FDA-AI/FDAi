create table wp_term_relationships
(
    object_id        bigint                                 not null
        constraint "wp_term_relationships_wp_posts_ID_fk"
            references wp_posts
            on update cascade on delete cascade,
    term_taxonomy_id bigint                                 not null
        constraint wp_term_relationships_wp_term_taxonomy_term_taxonomy_id_fk
            references wp_term_taxonomy,
    term_order       integer,
    updated_at       timestamp(0) default CURRENT_TIMESTAMP not null,
    created_at       timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at       timestamp(0),
    client_id        varchar(255),
    primary key (object_id, term_taxonomy_id)
);

comment on column wp_term_relationships.object_id is 'The ID of the post object.';

comment on column wp_term_relationships.term_taxonomy_id is 'The ID of the term / taxonomy pair.';

comment on column wp_term_relationships.term_order is 'Allow ordering of terms for an object, not fully used.';

alter table wp_term_relationships
    owner to postgres;

create index term_taxonomy_id
    on wp_term_relationships (term_taxonomy_id);

