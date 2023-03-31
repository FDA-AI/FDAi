create table wp_posts
(
    "ID"                  bigserial
        primary key,
    post_author           bigint       default '0'::bigint
        constraint "wp_posts_wp_users_ID_fk"
            references wp_users,
    post_date             timestamp(0),
    post_date_gmt         timestamp(0),
    post_content          text,
    post_title            text,
    post_excerpt          text,
    post_status           varchar(20)  default 'publish'::character varying,
    comment_status        varchar(20)  default 'open'::character varying,
    ping_status           varchar(20)  default 'open'::character varying,
    post_password         varchar(255),
    post_name             varchar(200),
    to_ping               text,
    pinged                text,
    post_modified         timestamp(0),
    post_modified_gmt     timestamp(0),
    post_content_filtered text,
    post_parent           bigint       default '0'::bigint,
    guid                  varchar(255),
    menu_order            integer      default 0,
    post_type             varchar(20)  default 'post'::character varying,
    post_mime_type        varchar(100),
    comment_count         bigint       default '0'::bigint,
    updated_at            timestamp(0) default CURRENT_TIMESTAMP not null,
    created_at            timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at            timestamp(0),
    client_id             varchar(255),
    record_size_in_kb     integer
);

comment on column wp_posts."ID" is 'Unique number assigned to each post.';

comment on column wp_posts.post_author is 'The user ID who created it.';

comment on column wp_posts.post_content is 'Holds all the content for the post, including HTML, shortcodes and other content.';

comment on column wp_posts.post_title is 'Title of the post.';

comment on column wp_posts.post_excerpt is 'Custom intro or short version of the content.';

comment on column wp_posts.post_status is 'Status of the post, e.g. ‘draft’, ‘pending’, ‘private’, ‘publish’. Also a great WordPress <a href="https://poststatus.com/" target="_blank">news site</a>.';

comment on column wp_posts.comment_status is 'If comments are allowed.';

comment on column wp_posts.ping_status is 'If the post allows <a href="http://codex.wordpress.org/Introduction_to_Blogging#Pingbacks" target="_blank">ping and trackbacks</a>.';

comment on column wp_posts.post_password is 'Optional password used to view the post.';

comment on column wp_posts.post_name is 'URL friendly slug of the post title.';

comment on column wp_posts.to_ping is 'A list of URLs WordPress should send pingbacks to when updated.';

comment on column wp_posts.pinged is 'A list of URLs WordPress has sent pingbacks to when updated.';

comment on column wp_posts.post_content_filtered is 'Used by plugins to cache a version of post_content typically passed through the ‘the_content’ filter. Not used by WordPress core itself.';

comment on column wp_posts.post_parent is 'Used to create a relationship between this post and another when this post is a revision, attachment or another type.';

comment on column wp_posts.guid is 'Global Unique Identifier, the permanent URL to the post, not the permalink version.';

comment on column wp_posts.menu_order is 'Holds the display number for pages and other non-post types.';

comment on column wp_posts.post_type is 'The content type identifier.';

comment on column wp_posts.post_mime_type is 'Only used for attachments, the MIME type of the uploaded file.';

comment on column wp_posts.comment_count is 'Total number of comments, pingbacks and trackbacks.';

alter table wp_posts
    owner to postgres;

create index idx_wp_posts_post_author_post_modified_deleted_at
    on wp_posts (post_author, post_modified, deleted_at);

create index type_status_date
    on wp_posts (post_type, post_status, post_date, "ID");

create index post_author
    on wp_posts (post_author);

create index post_name
    on wp_posts (post_name);

create index wp_posts_post_modified_index
    on wp_posts (post_modified);

create index post_parent
    on wp_posts (post_parent);

