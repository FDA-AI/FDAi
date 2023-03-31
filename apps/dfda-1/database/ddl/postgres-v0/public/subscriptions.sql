create table subscriptions
(
    id            bigserial
        primary key,
    user_id       bigint       not null,
    name          varchar(255) not null,
    stripe_id     varchar(255) not null
        constraint subscriptions_stripe_id_unique
            unique,
    stripe_status varchar(255) not null,
    stripe_price  varchar(255),
    quantity      integer,
    trial_ends_at timestamp(0),
    ends_at       timestamp(0),
    created_at    timestamp(0),
    updated_at    timestamp(0)
);

alter table subscriptions
    owner to postgres;

create index subscriptions_user_id_stripe_status_index
    on subscriptions (user_id, stripe_status);

