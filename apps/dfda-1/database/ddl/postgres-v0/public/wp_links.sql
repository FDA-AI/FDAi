create table wp_links
(
    link_id          bigserial
        primary key,
    link_url         varchar(760)                               not null
        constraint wp_links_link_url_uindex
            unique,
    link_name        varchar(255),
    link_image       varchar(255),
    link_target      varchar(25),
    link_description varchar(255),
    link_visible     varchar(20)  default 'Y'::character varying,
    link_owner       bigint       default '1'::bigint
        constraint "wp_links_wp_users_ID_fk"
            references wp_users,
    link_rating      integer      default 0,
    link_updated     timestamp(0),
    link_rel         varchar(255),
    link_notes       text,
    link_rss         varchar(255) default ''::character varying not null,
    updated_at       timestamp(0) default CURRENT_TIMESTAMP     not null,
    created_at       timestamp(0) default CURRENT_TIMESTAMP     not null,
    deleted_at       timestamp(0),
    client_id        varchar(255)
);

comment on column wp_links.link_id is 'Unique number assigned to each row of the table.';

comment on column wp_links.link_url is 'Unique universal resource locator for the link.';

comment on column wp_links.link_name is 'Name of the link.';

comment on column wp_links.link_image is 'URL of an image related to the link.';

comment on column wp_links.link_target is 'The target frame for the link. e.g. _blank, _top, _none.';

comment on column wp_links.link_description is 'Description of the link.';

comment on column wp_links.link_visible is 'Control if the link is public or private.';

comment on column wp_links.link_owner is 'ID of user who created the link.';

comment on column wp_links.link_rating is 'Add a rating between 0-10 for the link.';

comment on column wp_links.link_rel is 'Relationship of link.';

comment on column wp_links.link_notes is 'Notes about the link.';

alter table wp_links
    owner to postgres;

create index link_visible
    on wp_links (link_visible);

create index "wp_links_wp_users_ID_fk"
    on wp_links (link_owner);

