create table if not exists clinical_trial_intervention_other_names
(
    id              int           not null,
    nct_id          varchar(4369) null,
    intervention_id int           null,
    name            varchar(4369) null,
    primary key (id)
)
    comment 'Terms or phrases that are synonymous with an intervention. (Each row is linked to one of the interventions associated with the study.)'
    charset = latin1;

