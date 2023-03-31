create table wp_terms
(
    term_id    bigserial
        primary key,
    name       varchar(200),
    slug       varchar(200),
    term_group bigint,
    updated_at timestamp(0) default CURRENT_TIMESTAMP not null,
    created_at timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at timestamp(0),
    client_id  varchar(255)
);

comment on column wp_terms.term_id is 'Unique number assigned to each term.';

comment on column wp_terms.name is 'The name of the term.';

comment on column wp_terms.slug is 'The URL friendly slug of the name.';

comment on column wp_terms.term_group is 'Ability for themes or plugins to group terms together to use aliases. Not populated by WordPress core itself.';

alter table wp_terms
    owner to postgres;

create index name
    on wp_terms (name);

create index slug
    on wp_terms (slug);

