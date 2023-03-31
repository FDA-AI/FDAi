create table subscription_items
(
    id              bigserial
        primary key,
    subscription_id bigint       not null,
    stripe_id       varchar(255) not null
        constraint subscription_items_stripe_id_unique
            unique,
    stripe_product  varchar(255) not null,
    stripe_price    varchar(255) not null,
    quantity        integer,
    created_at      timestamp(0),
    updated_at      timestamp(0),
    constraint subscription_items_subscription_id_stripe_price_unique
        unique (subscription_id, stripe_price)
);

alter table subscription_items
    owner to postgres;

