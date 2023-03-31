create table sent_emails
(
    id            serial
        primary key,
    user_id       bigint
        constraint sent_emails_user_id_fk
            references wp_users,
    type          varchar(100)                           not null,
    created_at    timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at    timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at    timestamp(0),
    client_id     varchar(255)
        constraint sent_emails_client_id_fk
            references oa_clients,
    slug          varchar(100),
    response      varchar(140),
    content       text,
    wp_post_id    bigint
        constraint "sent_emails_wp_posts_ID_fk"
            references wp_posts,
    email_address varchar(255),
    subject       varchar(78)                            not null
);

comment on column sent_emails.subject is 'A Subject Line is the introduction that identifies the emails intent.
                    This subject line, displayed to the email user or recipient when they look at their list of messages in their inbox,
                    should tell the recipient what the message is about, what the sender wants to convey.';

alter table sent_emails
    owner to postgres;

create index sent_emails_user_id_type_index
    on sent_emails (user_id, type);

create index sent_emails_client_id_fk
    on sent_emails (client_id);

create index "sent_emails_wp_posts_ID_fk"
    on sent_emails (wp_post_id);

