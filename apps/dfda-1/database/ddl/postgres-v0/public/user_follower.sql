create table user_follower
(
    id           serial
        primary key,
    following_id bigint not null,
    follower_id  bigint not null,
    accepted_at  timestamp(0),
    created_at   timestamp(0),
    updated_at   timestamp(0)
);

alter table user_follower
    owner to postgres;

create index user_follower_following_id_index
    on user_follower (following_id);

create index user_follower_follower_id_index
    on user_follower (follower_id);

create index user_follower_accepted_at_index
    on user_follower (accepted_at);

