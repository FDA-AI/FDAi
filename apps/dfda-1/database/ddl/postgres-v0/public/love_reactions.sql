create table love_reactions
(
    id               bigserial
        primary key,
    reactant_id      bigint        not null
        constraint love_reactions_reactant_id_foreign
            references love_reactants
            on delete cascade,
    reacter_id       bigint        not null
        constraint love_reactions_reacter_id_foreign
            references love_reacters
            on delete cascade,
    reaction_type_id bigint        not null
        constraint love_reactions_reaction_type_id_foreign
            references love_reaction_types
            on delete cascade,
    rate             numeric(4, 2) not null,
    created_at       timestamp(0),
    updated_at       timestamp(0)
);

alter table love_reactions
    owner to postgres;

create index love_reactions_reactant_id_reaction_type_id_index
    on love_reactions (reactant_id, reaction_type_id);

create index love_reactions_reactant_id_reacter_id_reaction_type_id_index
    on love_reactions (reactant_id, reacter_id, reaction_type_id);

create index love_reactions_reactant_id_reacter_id_index
    on love_reactions (reactant_id, reacter_id);

create index love_reactions_reacter_id_reaction_type_id_index
    on love_reactions (reacter_id, reaction_type_id);

