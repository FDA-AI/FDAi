create table purchases
(
    id                                   bigserial
        primary key,
    subscriber_user_id                   bigint                                 not null
        constraint "purchases_wp_users_ID_fk"
            references wp_users,
    referrer_user_id                     bigint,
    updated_at                           timestamp(0) default CURRENT_TIMESTAMP not null,
    created_at                           timestamp(0) default CURRENT_TIMESTAMP not null,
    subscription_provider                varchar(255)                           not null
        constraint purchases_subscription_provider_check
            check ((subscription_provider)::text = ANY
                   ((ARRAY ['stripe'::character varying, 'apple'::character varying, 'google'::character varying])::text[])),
    last_four                            varchar(4),
    product_id                           varchar(100)                           not null,
    subscription_provider_transaction_id varchar(100),
    coupon                               varchar(100),
    client_id                            varchar(80)
        constraint purchases_client_id_fk
            references oa_clients,
    refunded_at                          date,
    deleted_at                           timestamp(0),
    constraint subscriber_referrer
        unique (subscriber_user_id, referrer_user_id)
);

alter table purchases
    owner to postgres;

create index purchases_client_id_fk
    on purchases (client_id);

