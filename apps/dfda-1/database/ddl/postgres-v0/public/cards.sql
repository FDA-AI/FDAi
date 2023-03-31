create table cards
(
    action_sheet_buttons text,
    avatar               varchar(100),
    avatar_circular      varchar(100),
    background_color     varchar(20),
    buttons              text,
    client_id            varchar(80)                            not null
        constraint cards_client_id_fk
            references oa_clients,
    content              text,
    created_at           timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at           timestamp(0),
    header_title         varchar(100),
    html                 text,
    html_content         text,
    element_id           varchar(80)                            not null,
    image                varchar(100),
    input_fields         text,
    intent_name          varchar(80),
    ion_icon             varchar(20),
    link                 varchar(2083),
    parameters           text,
    sharing_body         text,
    sharing_buttons      text,
    sharing_title        varchar(80),
    sub_header           varchar(80),
    sub_title            varchar(80),
    title                varchar(80),
    type                 varchar(80)                            not null,
    updated_at           timestamp(0) default CURRENT_TIMESTAMP not null,
    user_id              bigint                                 not null
        constraint cards_user_id_fk
            references wp_users,
    url                  varchar(2083),
    id                   integer                                not null
        primary key,
    slug                 varchar(200)
        constraint cards_slug_uindex
            unique
);

comment on column cards.link is 'Link field is deprecated due to ambiguity.  Please use url field instead.';

comment on column cards.url is 'URL to go to when the card is clicked';

comment on column cards.slug is 'The slug is the part of a URL that identifies a page in human-readable keywords.';

alter table cards
    owner to postgres;

create index cards_client_id_fk
    on cards (client_id);

create index cards_user_id_fk
    on cards (user_id);

