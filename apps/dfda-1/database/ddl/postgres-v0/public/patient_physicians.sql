create table patient_physicians
(
    id                serial
        primary key,
    patient_user_id   bigint                                 not null
        constraint "patient_physicians_wp_users_ID_fk"
            references wp_users,
    physician_user_id bigint                                 not null
        constraint "patient_physicians_wp_users_ID_fk_2"
            references wp_users,
    scopes            varchar(2000)                          not null,
    created_at        timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at        timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at        timestamp(0),
    constraint patients_patient_user_id_physician_user_id_uindex
        unique (patient_user_id, physician_user_id)
);

comment on column patient_physicians.patient_user_id is 'The patient who has granted data access to the physician. ';

comment on column patient_physicians.physician_user_id is 'The physician who has been granted access to the patients data.';

comment on column patient_physicians.scopes is 'Whether the physician has read access and/or write access to the data.';

alter table patient_physicians
    owner to postgres;

create index "patient_physicians_wp_users_ID_fk_2"
    on patient_physicians (physician_user_id);

