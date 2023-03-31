create table wp_term_taxonomy
(
    term_taxonomy_id bigserial
        primary key,
    term_id          bigint
        constraint wp_term_taxonomy_wp_terms_term_id_fk
            references wp_terms,
    taxonomy         varchar(32),
    description      text,
    parent           bigint,
    count            bigint,
    updated_at       timestamp(0) default CURRENT_TIMESTAMP not null,
    created_at       timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at       timestamp(0),
    client_id        varchar(255),
    constraint term_id_taxonomy
        unique (term_id, taxonomy)
);

comment on column wp_term_taxonomy.term_taxonomy_id is 'Unique number assigned to each row of the table.';

comment on column wp_term_taxonomy.term_id is 'The ID of the related term.';

comment on column wp_term_taxonomy.taxonomy is 'The slug of the taxonomy. This can be the <a href="http://codex.wordpress.org/Taxonomies#Default_Taxonomies" target="_blank">built in taxonomies</a> or any taxonomy registered using <a href="http://codex.wordpress.org/Function_Reference/register_taxonomy" target="_blank">register_taxonomy()</a>.';

comment on column wp_term_taxonomy.description is 'Description of the term in this taxonomy.';

comment on column wp_term_taxonomy.parent is 'ID of a parent term. Used for hierarchical taxonomies like Categories.';

comment on column wp_term_taxonomy.count is 'Number of post objects assigned the term for this taxonomy.';

alter table wp_term_taxonomy
    owner to postgres;

create index taxonomy
    on wp_term_taxonomy (taxonomy);

