create table love_reactant_reaction_totals
(
    id          bigserial
        primary key,
    reactant_id bigint         not null
        constraint love_reactant_reaction_totals_reactant_id_foreign
            references love_reactants
            on delete cascade,
    count       bigint         not null,
    weight      numeric(13, 2) not null,
    created_at  timestamp(0),
    updated_at  timestamp(0)
);

alter table love_reactant_reaction_totals
    owner to postgres;

