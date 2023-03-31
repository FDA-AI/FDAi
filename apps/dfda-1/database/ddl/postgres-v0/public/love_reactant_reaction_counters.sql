create table love_reactant_reaction_counters
(
    id               bigserial
        primary key,
    reactant_id      bigint         not null
        constraint love_reactant_reaction_counters_reactant_id_foreign
            references love_reactants
            on delete cascade,
    reaction_type_id bigint         not null
        constraint love_reactant_reaction_counters_reaction_type_id_foreign
            references love_reaction_types
            on delete cascade,
    count            bigint         not null,
    weight           numeric(13, 2) not null,
    created_at       timestamp(0),
    updated_at       timestamp(0)
);

alter table love_reactant_reaction_counters
    owner to postgres;

create index love_reactant_reaction_counters_reactant_reaction_type_index
    on love_reactant_reaction_counters (reactant_id, reaction_type_id);

