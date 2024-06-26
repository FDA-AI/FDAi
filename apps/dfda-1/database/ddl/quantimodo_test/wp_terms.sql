create table quantimodo_test.wp_terms
(
    term_id    bigint unsigned auto_increment comment 'Unique number assigned to each term.'
        primary key,
    name       varchar(200)                        null comment 'The name of the term.',
    slug       varchar(200)                        null comment 'The URL friendly slug of the name.',
    term_group bigint                              null comment 'Ability for themes or plugins to group terms together to use aliases. Not populated by WordPress core itself.',
    updated_at timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    deleted_at timestamp                           null,
    client_id  varchar(255)                        null
)
    comment 'Terms are items of a taxonomy used to classify objects. Taxonomy what? WordPress allows items like posts and custom post types to be classified in various ways. For example, when creating a post in WordPress, by default you can add a category and some tags to it. Both ‘Category’ and ‘Tag’ are examples of a <a href="http://codex.wordpress.org/Taxonomies" target="_blank">taxonomy</a>, basically a way to group things together.'
    charset = utf8mb3;

create index name
    on quantimodo_test.wp_terms (name(191));

create index slug
    on quantimodo_test.wp_terms (slug(191));

