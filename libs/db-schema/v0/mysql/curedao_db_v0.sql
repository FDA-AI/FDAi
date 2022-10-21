create table if not exists action_events
(
    id              bigint unsigned auto_increment
        primary key,
    batch_id        char(36)                      not null,
    user_id         bigint unsigned               not null,
    name            varchar(255)                  not null,
    actionable_type varchar(255)                  not null,
    actionable_id   bigint unsigned               not null,
    target_type     varchar(255)                  not null,
    target_id       bigint unsigned               not null,
    model_type      varchar(255)                  not null,
    model_id        bigint unsigned               null,
    fields          text                          not null,
    status          varchar(25) default 'running' not null,
    exception       text                          not null,
    created_at      timestamp                     null,
    updated_at      timestamp                     null,
    original        text                          null,
    changes         text                          null
)
    collate = utf8_unicode_ci;

create index action_events_actionable_type_actionable_id_index
    on action_events (actionable_type, actionable_id);

create index action_events_batch_id_model_type_model_id_index
    on action_events (batch_id, model_type, model_id);

create index action_events_user_id_index
    on action_events (user_id);

create table if not exists cache
(
    `key`      varchar(255) not null,
    value      mediumtext   not null,
    expiration int          not null,
    constraint cache_key_unique
        unique (`key`)
)
    collate = utf8_unicode_ci;

create table if not exists clockwork
(
    id                       varchar(100) not null,
    version                  int          null,
    type                     varchar(100) null,
    time                     double       null,
    method                   varchar(10)  null,
    url                      mediumtext   null,
    uri                      mediumtext   null,
    headers                  mediumtext   null,
    controller               varchar(250) null,
    getData                  mediumtext   null,
    postData                 mediumtext   null,
    requestData              mediumtext   null,
    sessionData              mediumtext   null,
    authenticatedUser        mediumtext   null,
    cookies                  mediumtext   null,
    responseTime             double       null,
    responseStatus           int          null,
    responseDuration         double       null,
    memoryUsage              double       null,
    middleware               mediumtext   null,
    databaseQueries          mediumtext   null,
    databaseQueriesCount     int          null,
    databaseSlowQueries      int          null,
    databaseSelects          int          null,
    databaseInserts          int          null,
    databaseUpdates          int          null,
    databaseDeletes          int          null,
    databaseOthers           int          null,
    databaseDuration         double       null,
    cacheQueries             mediumtext   null,
    cacheReads               int          null,
    cacheHits                int          null,
    cacheWrites              int          null,
    cacheDeletes             int          null,
    cacheTime                double       null,
    modelsActions            mediumtext   null,
    modelsRetrieved          mediumtext   null,
    modelsCreated            mediumtext   null,
    modelsUpdated            mediumtext   null,
    modelsDeleted            mediumtext   null,
    redisCommands            mediumtext   null,
    queueJobs                mediumtext   null,
    timelineData             mediumtext   null,
    log                      mediumtext   null,
    events                   mediumtext   null,
    routes                   mediumtext   null,
    notifications            mediumtext   null,
    emailsData               mediumtext   null,
    viewsData                mediumtext   null,
    userData                 mediumtext   null,
    subrequests              mediumtext   null,
    xdebug                   mediumtext   null,
    commandName              mediumtext   null,
    commandArguments         mediumtext   null,
    commandArgumentsDefaults mediumtext   null,
    commandOptions           mediumtext   null,
    commandOptionsDefaults   mediumtext   null,
    commandExitCode          int          null,
    commandOutput            mediumtext   null,
    jobName                  mediumtext   null,
    jobDescription           mediumtext   null,
    jobStatus                mediumtext   null,
    jobPayload               mediumtext   null,
    jobQueue                 mediumtext   null,
    jobConnection            mediumtext   null,
    jobOptions               mediumtext   null,
    testName                 mediumtext   null,
    testStatus               mediumtext   null,
    testStatusMessage        mediumtext   null,
    testAsserts              mediumtext   null,
    clientMetrics            mediumtext   null,
    webVitals                mediumtext   null,
    parent                   mediumtext   null,
    updateToken              varchar(100) null,
    primary key (id)
);

create index clockwork_time_index
    on clockwork (time);

create table if not exists connector_devices
(
    id                int unsigned  null,
    name              tinytext      null,
    display_name      tinytext      null,
    image             varchar(2083) null,
    get_it_url        varchar(2083) null,
    short_description mediumtext    null,
    long_description  longtext      null,
    enabled           tinyint       null,
    oauth             tinyint       null,
    qm_client         tinyint       null,
    created_at        timestamp     null,
    updated_at        timestamp     null,
    client_id         tinytext      null,
    deleted_at        timestamp     null,
    is_parent         tinyint       null
)
    comment 'Various devices whose data may be obtained from a given connector''s API' charset = utf8;

create table if not exists crypto_trades
(
    id                     int unsigned auto_increment
        primary key,
    datetime               timestamp                           null,
    side                   varchar(255)                        not null,
    symbol                 varchar(255)                        not null,
    exchange               varchar(255)                        not null,
    amount                 double                              not null,
    createdUnixTimeSeconds int                                 null,
    fee                    double                              null,
    info                   longtext                            null,
    ohlcv                  longtext                            null,
    price                  double                              null,
    tradeParameters        longtext                            null,
    type                   varchar(255)                        null,
    created_at             timestamp default CURRENT_TIMESTAMP not null,
    deleted_at             timestamp                           null,
    updated_at             timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    constraint unique_index_name_here
        unique (createdUnixTimeSeconds, exchange, side, symbol)
)
    charset = utf8;

create table if not exists ct_correlations
(
    id                            int auto_increment
        primary key,
    user_id                       int                                   not null,
    correlation_coefficient       float(10, 4)                          null,
    cause_variable_id             int unsigned                          not null,
    effect_variable_id            int unsigned                          not null,
    onset_delay                   int                                   null,
    duration_of_action            int                                   null,
    number_of_pairs               int                                   null,
    value_predicting_high_outcome double                                null,
    value_predicting_low_outcome  double                                null,
    optimal_pearson_product       double                                null,
    vote                          float(3, 1) default 0.5               null,
    statistical_significance      float(10, 4)                          null,
    cause_unit_id                 int                                   null,
    cause_changes                 int                                   null,
    effect_changes                int                                   null,
    qm_score                      double                                null,
    error                         text                                  null,
    created_at                    timestamp   default CURRENT_TIMESTAMP not null,
    updated_at                    timestamp   default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at                    timestamp                             null,
    constraint user
        unique (user_id, cause_variable_id, effect_variable_id)
)
    comment 'Stores Calculated Correlation Coefficients' charset = utf8;

create index cause
    on ct_correlations (cause_variable_id);

create index effect
    on ct_correlations (effect_variable_id);

create table if not exists ctg_intervention_other_names
(
    id              int           null,
    nct_id          varchar(4369) null,
    intervention_id int           null,
    name            varchar(4369) null
);

create table if not exists failed_jobs
(
    id         bigint unsigned auto_increment
        primary key,
    connection text                                not null,
    queue      text                                not null,
    payload    longtext                            not null,
    exception  longtext                            not null,
    failed_at  timestamp default CURRENT_TIMESTAMP not null
)
    charset = utf8;

create table if not exists favorites
(
    id                bigint unsigned auto_increment
        primary key,
    user_id           bigint unsigned not null comment 'user_id',
    favoriteable_type varchar(255)    not null,
    favoriteable_id   bigint unsigned not null,
    created_at        timestamp       null,
    updated_at        timestamp       null,
    is_public         tinyint(1)      null
)
    collate = utf8_unicode_ci;

create index favorites_favoriteable_type_favoriteable_id_index
    on favorites (favoriteable_type, favoriteable_id);

create index favorites_user_id_index
    on favorites (user_id);

create table if not exists followers
(
    id               int unsigned auto_increment
        primary key,
    user_id          int       not null,
    followed_user_id int       not null,
    created_at       timestamp null,
    updated_at       timestamp null
)
    collate = utf8_unicode_ci;

create index followers_followed_user_id_index
    on followers (followed_user_id);

create index followers_user_id_index
    on followers (user_id);

create table if not exists github_repositories
(
    id                          int unsigned                        not null,
    client_id                   varchar(80)                         null,
    created_at                  timestamp default CURRENT_TIMESTAMP not null,
    deleted_at                  timestamp                           null,
    updated_at                  timestamp default CURRENT_TIMESTAMP not null,
    user_id                     bigint unsigned                     not null,
    github_repository_id        int                                 not null,
    node_id                     varchar(255)                        not null,
    name                        varchar(255)                        not null,
    full_name                   varchar(255)                        not null,
    private                     tinyint                             not null,
    owner                       longtext                            not null,
    html_url                    varchar(255)                        not null,
    description                 varchar(255)                        null,
    fork                        tinyint                             not null,
    url                         varchar(255)                        not null,
    forks_url                   varchar(255)                        not null,
    keys_url                    varchar(255)                        not null,
    collaborators_url           varchar(255)                        not null,
    teams_url                   varchar(255)                        not null,
    hooks_url                   varchar(255)                        not null,
    issue_events_url            varchar(255)                        not null,
    events_url                  varchar(255)                        not null,
    assignees_url               varchar(255)                        not null,
    branches_url                varchar(255)                        not null,
    tags_url                    varchar(255)                        not null,
    blobs_url                   varchar(255)                        not null,
    git_tags_url                varchar(255)                        not null,
    git_refs_url                varchar(255)                        not null,
    trees_url                   varchar(255)                        not null,
    statuses_url                varchar(255)                        not null,
    languages_url               varchar(255)                        not null,
    stargazers_url              varchar(255)                        not null,
    contributors_url            varchar(255)                        not null,
    subscribers_url             varchar(255)                        not null,
    subscription_url            varchar(255)                        not null,
    commits_url                 varchar(255)                        not null,
    git_commits_url             varchar(255)                        not null,
    comments_url                varchar(255)                        not null,
    issue_comment_url           varchar(255)                        not null,
    contents_url                varchar(255)                        not null,
    compare_url                 varchar(255)                        not null,
    merges_url                  varchar(255)                        not null,
    archive_url                 varchar(255)                        not null,
    downloads_url               varchar(255)                        not null,
    issues_url                  varchar(255)                        not null,
    pulls_url                   varchar(255)                        not null,
    milestones_url              varchar(255)                        not null,
    notifications_url           varchar(255)                        not null,
    labels_url                  varchar(255)                        not null,
    releases_url                varchar(255)                        not null,
    deployments_url             varchar(255)                        not null,
    pushed_at                   varchar(255)                        not null,
    git_url                     varchar(255)                        not null,
    ssh_url                     varchar(255)                        not null,
    clone_url                   varchar(255)                        not null,
    svn_url                     varchar(255)                        not null,
    homepage                    varchar(255)                        null,
    size                        int                                 not null,
    stargazers_count            int                                 not null,
    watchers_count              int                                 not null,
    language                    varchar(255)                        null,
    has_issues                  tinyint                             not null,
    has_projects                tinyint                             not null,
    has_downloads               tinyint                             not null,
    has_wiki                    tinyint                             not null,
    has_pages                   tinyint                             not null,
    forks_count                 int                                 not null,
    archived                    tinyint                             not null,
    disabled                    tinyint                             not null,
    open_issues_count           int                                 not null,
    allow_forking               tinyint                             not null,
    is_template                 tinyint                             not null,
    topics                      longtext                            not null,
    visibility                  varchar(255)                        not null,
    forks                       int                                 not null,
    open_issues                 int                                 not null,
    watchers                    int                                 not null,
    default_branch              varchar(255)                        not null,
    permissions                 longtext                            not null,
    temp_clone_token            varchar(255)                        not null,
    allow_squash_merge          tinyint                             not null,
    allow_merge_commit          tinyint                             not null,
    allow_rebase_merge          tinyint                             not null,
    allow_auto_merge            tinyint                             not null,
    delete_branch_on_merge      tinyint                             not null,
    network_count               int                                 not null,
    subscribers_count           int                                 not null,
    mirror_url                  varchar(255)                        null,
    license                     text                                null,
    web_commit_signoff_required tinyint(1)                          null,
    primary key (id),
    constraint github_repositories_git_url_unique
        unique (git_url),
    constraint github_repositories_github_repository_id_unique
        unique (github_repository_id),
    constraint github_repositories_html_url_unique
        unique (html_url),
    constraint github_repositories_id_unique
        unique (id),
    constraint github_repositories_name_unique
        unique (name),
    constraint github_repositories_ssh_url_unique
        unique (ssh_url),
    constraint github_repositories_url_unique
        unique (url)
)
    collate = utf8mb4_unicode_ci;

create index github_repositories_client_id_index
    on github_repositories (client_id);

create index github_repositories_user_id_index
    on github_repositories (user_id);

create table if not exists health_checks
(
    id             int unsigned auto_increment
        primary key,
    resource_name  varchar(255)                        not null,
    resource_slug  varchar(255)                        not null,
    target_name    varchar(255)                        not null,
    target_slug    varchar(255)                        not null,
    target_display varchar(255)                        not null,
    healthy        tinyint(1)                          not null,
    error_message  text                                null,
    runtime        double(8, 2)                        not null,
    value          varchar(255)                        null,
    value_human    varchar(255)                        null,
    created_at     timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP
)
    collate = utf8_unicode_ci;

create index health_checks_created_at_index
    on health_checks (created_at);

create index health_checks_resource_slug_index
    on health_checks (resource_slug);

create index health_checks_target_slug_index
    on health_checks (target_slug);

create table if not exists ip_data
(
    id             int unsigned not null,
    created_at     timestamp    null,
    deleted_at     timestamp    null,
    updated_at     timestamp    null,
    ip             varchar(255) not null,
    hostname       varchar(255) null,
    type           varchar(255) null,
    continent_code varchar(255) null,
    continent_name varchar(255) null,
    country_code   varchar(255) null,
    country_name   varchar(255) null,
    region_code    varchar(255) null,
    region_name    varchar(255) null,
    city           varchar(255) null,
    zip            varchar(255) null,
    latitude       double       null,
    longitude      double       null,
    location       longtext     null,
    time_zone      longtext     null,
    currency       longtext     null,
    connection     longtext     null,
    security       longtext     null,
    primary key (id),
    constraint ip_data_ip_uindex
        unique (ip)
);

create table if not exists jobs
(
    id           bigint unsigned auto_increment
        primary key,
    queue        varchar(255)     not null,
    payload      longtext         not null,
    attempts     tinyint unsigned not null,
    reserved_at  int unsigned     null,
    available_at int unsigned     not null,
    created_at   int unsigned     not null
)
    collate = utf8_unicode_ci;

create index jobs_queue_index
    on jobs (queue);

create table if not exists likes
(
    id            bigint unsigned auto_increment
        primary key,
    user_id       bigint unsigned not null comment 'user_id',
    likeable_type varchar(255)    not null,
    likeable_id   bigint unsigned not null,
    created_at    timestamp       null,
    updated_at    timestamp       null
)
    collate = utf8_unicode_ci;

create index likes_likeable_type_likeable_id_index
    on likes (likeable_type, likeable_id);

create index likes_user_id_index
    on likes (user_id);

create table if not exists love_reactants
(
    id         bigint unsigned auto_increment
        primary key,
    type       varchar(255) not null,
    created_at timestamp    null,
    updated_at timestamp    null
)
    collate = utf8_unicode_ci;

create table if not exists love_reactant_reaction_totals
(
    id          bigint unsigned auto_increment
        primary key,
    reactant_id bigint unsigned not null,
    count       bigint unsigned not null,
    weight      decimal(13, 2)  not null,
    created_at  timestamp       null,
    updated_at  timestamp       null,
    constraint love_reactant_reaction_totals_reactant_id_foreign
        foreign key (reactant_id) references love_reactants (id)
            on delete cascade
)
    collate = utf8_unicode_ci;

create index love_reactants_type_index
    on love_reactants (type);

create table if not exists love_reacters
(
    id         bigint unsigned auto_increment
        primary key,
    type       varchar(255) not null,
    created_at timestamp    null,
    updated_at timestamp    null
)
    collate = utf8_unicode_ci;

create index love_reacters_type_index
    on love_reacters (type);

create table if not exists love_reaction_types
(
    id         bigint unsigned auto_increment
        primary key,
    name       varchar(255) not null,
    mass       tinyint      not null,
    created_at timestamp    null,
    updated_at timestamp    null
)
    collate = utf8_unicode_ci;

create table if not exists love_reactant_reaction_counters
(
    id               bigint unsigned auto_increment
        primary key,
    reactant_id      bigint unsigned not null,
    reaction_type_id bigint unsigned not null,
    count            bigint unsigned not null,
    weight           decimal(13, 2)  not null,
    created_at       timestamp       null,
    updated_at       timestamp       null,
    constraint love_reactant_reaction_counters_reactant_id_foreign
        foreign key (reactant_id) references love_reactants (id)
            on delete cascade,
    constraint love_reactant_reaction_counters_reaction_type_id_foreign
        foreign key (reaction_type_id) references love_reaction_types (id)
            on delete cascade
)
    collate = utf8_unicode_ci;

create index love_reactant_reaction_counters_reactant_reaction_type_index
    on love_reactant_reaction_counters (reactant_id, reaction_type_id);

create index love_reaction_types_name_index
    on love_reaction_types (name);

create table if not exists love_reactions
(
    id               bigint unsigned auto_increment
        primary key,
    reactant_id      bigint unsigned not null,
    reacter_id       bigint unsigned not null,
    reaction_type_id bigint unsigned not null,
    rate             decimal(4, 2)   not null,
    created_at       timestamp       null,
    updated_at       timestamp       null,
    constraint love_reactions_reactant_id_foreign
        foreign key (reactant_id) references love_reactants (id)
            on delete cascade,
    constraint love_reactions_reacter_id_foreign
        foreign key (reacter_id) references love_reacters (id)
            on delete cascade,
    constraint love_reactions_reaction_type_id_foreign
        foreign key (reaction_type_id) references love_reaction_types (id)
            on delete cascade
)
    collate = utf8_unicode_ci;

create index love_reactions_reactant_id_reacter_id_index
    on love_reactions (reactant_id, reacter_id);

create index love_reactions_reactant_id_reacter_id_reaction_type_id_index
    on love_reactions (reactant_id, reacter_id, reaction_type_id);

create index love_reactions_reactant_id_reaction_type_id_index
    on love_reactions (reactant_id, reaction_type_id);

create index love_reactions_reacter_id_reaction_type_id_index
    on love_reactions (reacter_id, reaction_type_id);

create table if not exists mailbox_inbound_emails
(
    id         bigint unsigned auto_increment
        primary key,
    message_id varchar(255) not null,
    message    longtext     not null,
    created_at timestamp    null,
    updated_at timestamp    null
)
    collate = utf8_unicode_ci;

create table if not exists meddra_all_indications
(
    `STITCH compound id flat`                      varchar(55)                         null,
    `UMLS concept id as it was found on the label` varchar(55)                         null,
    `method of detection`                          varchar(55)                         null,
    `concept name`                                 varchar(55)                         null,
    `MedDRA concept type`                          varchar(55)                         null,
    `UMLS concept id for MedDRA term`              varchar(55)                         null,
    `MedDRA concept name`                          varchar(55)                         null,
    compound_name                                  varchar(255)                        null,
    compound_variable_id                           int(10)                             null,
    condition_variable_id                          int(10)                             null,
    updated_at                                     timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at                                     timestamp default CURRENT_TIMESTAMP not null,
    deleted_at                                     timestamp                           null
)
    comment 'Conditions treated by specific medications from the Medical Dictionary for Regulatory Activities'
    charset = utf8;

create index id
    on meddra_all_indications (`STITCH compound id flat`);

create table if not exists meddra_all_side_effects
(
    `STITCH compound id flat`                      varchar(255) null,
    `STITCH compound id stereo`                    varchar(255) null,
    `UMLS concept id as it was found on the label` varchar(255) null,
    `MedDRA concept type`                          varchar(255) null,
    `UMLS concept id for MedDRA term`              varchar(255) null,
    `side effect name`                             varchar(255) null
)
    comment 'Side effects from the Medical Dictionary for Regulatory Activities';

create table if not exists meddra_freq
(
    `STITCH compound id flat`                      varchar(50) null,
    `STITCH compound id stereo`                    varchar(50) null,
    `UMLS concept id as it was found on the label` varchar(50) null,
    placebo                                        varchar(50) null,
    `description of the frequency`                 double      null,
    `a lower bound on the frequency`               double      null,
    `an upper bound on the frequency`              double      null,
    `MedDRA concept type`                          varchar(50) null,
    `UMLS concept id for MedDRA term`              varchar(50) null,
    `side effect name`                             varchar(50) null
)
    comment 'Frequency of side effects from the Medical Dictionary for Regulatory Activities';

create table if not exists media
(
    id                bigint unsigned auto_increment
        primary key,
    model_type        varchar(255)    not null,
    model_id          bigint unsigned not null,
    collection_name   varchar(255)    not null,
    name              varchar(255)    not null,
    file_name         varchar(255)    not null,
    mime_type         varchar(255)    null,
    disk              varchar(255)    not null,
    size              bigint unsigned not null,
    manipulations     json            not null,
    custom_properties json            not null,
    responsive_images json            not null,
    order_column      int unsigned    null,
    created_at        timestamp       null,
    updated_at        timestamp       null
)
    collate = utf8_unicode_ci;

create index media_model_type_model_id_index
    on media (model_type, model_id);

create table if not exists migrations
(
    migration  varchar(255)                        not null,
    batch      int                                 not null,
    updated_at timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    deleted_at timestamp                           null
)
    charset = utf8;

create table if not exists notifications
(
    id              char(36)        not null,
    type            varchar(255)    not null,
    notifiable_type varchar(255)    not null,
    notifiable_id   bigint unsigned not null,
    data            text            not null,
    read_at         timestamp       null,
    created_at      timestamp       null,
    updated_at      timestamp       null,
    deleted_at      timestamp       null,
    primary key (id)
)
    collate = utf8_unicode_ci;

create index notifications_notifiable_type_notifiable_id_index
    on notifications (notifiable_type, notifiable_id);

create table if not exists nova_chartjs_metric_values
(
    id             bigint unsigned auto_increment
        primary key,
    chartable_type varchar(255)                   not null,
    chartable_id   bigint unsigned                not null,
    metric_values  json                           null,
    chart_name     varchar(100) default 'default' not null,
    created_at     timestamp                      null,
    updated_at     timestamp                      null,
    constraint nova_chartjs_metric_values_chart_unique
        unique (chartable_type, chartable_id, chart_name)
)
    collate = utf8_unicode_ci;

create index nova_chartjs_metric_values_chartable_type_chartable_id_index
    on nova_chartjs_metric_values (chartable_type, chartable_id);

create table if not exists nova_menu_menus
(
    id               bigint unsigned auto_increment
        primary key,
    name             varchar(255)    not null,
    slug             varchar(255)    not null,
    locale           varchar(255)    not null,
    created_at       timestamp       null,
    updated_at       timestamp       null,
    locale_parent_id bigint unsigned null,
    constraint menus_locale_parent_id_locale_unique
        unique (locale_parent_id, locale),
    constraint nova_menu_menus_slug_locale_unique
        unique (slug, locale),
    constraint menus_locale_parent_id_foreign
        foreign key (locale_parent_id) references nova_menu_menus (id)
)
    collate = utf8_unicode_ci;

create table if not exists nova_menu_menu_items
(
    id         bigint unsigned auto_increment
        primary key,
    menu_id    bigint unsigned              null,
    name       varchar(255)                 not null,
    class      varchar(255)                 null,
    value      varchar(255)                 null,
    target     varchar(255) default '_self' not null,
    parameters json                         null,
    parent_id  int                          null,
    `order`    int                          not null,
    enabled    tinyint(1)   default 1       not null,
    created_at timestamp                    null,
    updated_at timestamp                    null,
    constraint nova_menu_menu_items_menu_id_foreign
        foreign key (menu_id) references nova_menu_menus (id)
            on delete cascade
)
    collate = utf8_unicode_ci;

create table if not exists nova_notifications
(
    id              int unsigned auto_increment
        primary key,
    notification    varchar(255)         not null,
    notifiable_type varchar(255)         not null,
    notifiable_id   varchar(255)         not null,
    channel         varchar(255)         not null,
    failed          tinyint(1) default 0 not null,
    created_at      timestamp            null,
    updated_at      timestamp            null
)
    collate = utf8_unicode_ci;

create table if not exists oa_clients
(
    client_id                                 varchar(80)                         not null,
    client_secret                             varchar(80)                         not null,
    redirect_uri                              varchar(2000)                       null,
    grant_types                               varchar(80)                         null,
    user_id                                   bigint unsigned                     not null,
    created_at                                timestamp default CURRENT_TIMESTAMP not null,
    updated_at                                timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    icon_url                                  varchar(2083)                       null,
    app_identifier                            varchar(255)                        null,
    deleted_at                                timestamp                           null,
    earliest_measurement_start_at             timestamp                           null,
    latest_measurement_start_at               timestamp                           null,
    number_of_aggregate_correlations          int unsigned                        null comment 'Number of Global Population Studies for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from aggregate_correlations
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_aggregate_correlations = count(grouped.total)
                ]
                ',
    number_of_applications                    int unsigned                        null comment 'Number of Applications for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from applications
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_applications = count(grouped.total)
                ]
                ',
    number_of_oauth_access_tokens             int unsigned                        null comment 'Number of OAuth Access Tokens for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(access_token) as total, client_id
                            from bshaffer_oauth_access_tokens
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_oauth_access_tokens = count(grouped.total)
                ]
                ',
    number_of_oauth_authorization_codes       int unsigned                        null comment 'Number of OAuth Authorization Codes for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(authorization_code) as total, client_id
                            from bshaffer_oauth_authorization_codes
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_oauth_authorization_codes = count(grouped.total)
                ]
                ',
    number_of_oauth_refresh_tokens            int unsigned                        null comment 'Number of OAuth Refresh Tokens for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(refresh_token) as total, client_id
                            from bshaffer_oauth_refresh_tokens
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_oauth_refresh_tokens = count(grouped.total)
                ]
                ',
    number_of_button_clicks                   int unsigned                        null comment 'Number of Button Clicks for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from button_clicks
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_button_clicks = count(grouped.total)
                ]
                ',
    number_of_collaborators                   int unsigned                        null comment 'Number of Collaborators for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from collaborators
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_collaborators = count(grouped.total)
                ]
                ',
    number_of_common_tags                     int unsigned                        null comment 'Number of Common Tags for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from common_tags
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_common_tags = count(grouped.total)
                ]
                ',
    number_of_connections                     int unsigned                        null comment 'Number of Connections for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from connections
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_connections = count(grouped.total)
                ]
                ',
    number_of_connector_imports               int unsigned                        null comment 'Number of Connector Imports for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from connector_imports
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_connector_imports = count(grouped.total)
                ]
                ',
    number_of_connectors                      int unsigned                        null comment 'Number of Connectors for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from connectors
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_connectors = count(grouped.total)
                ]
                ',
    number_of_correlations                    int unsigned                        null comment 'Number of Individual Case Studies for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from correlations
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_correlations = count(grouped.total)
                ]
                ',
    number_of_measurement_exports             int unsigned                        null comment 'Number of Measurement Exports for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from measurement_exports
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_measurement_exports = count(grouped.total)]',
    number_of_measurement_imports             int unsigned                        null comment 'Number of Measurement Imports for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from measurement_imports
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_measurement_imports = count(grouped.total)]',
    number_of_measurements                    int unsigned                        null comment 'Number of Measurements for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from measurements
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_measurements = count(grouped.total)]',
    number_of_sent_emails                     int unsigned                        null comment 'Number of Sent Emails for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from sent_emails
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_sent_emails = count(grouped.total)]',
    number_of_studies                         int unsigned                        null comment 'Number of Studies for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from studies
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_studies = count(grouped.total)]',
    number_of_tracking_reminder_notifications int unsigned                        null comment 'Number of Tracking Reminder Notifications for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from tracking_reminder_notifications
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_tracking_reminder_notifications = count(grouped.total)]',
    number_of_tracking_reminders              int unsigned                        null comment 'Number of Tracking Reminders for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from tracking_reminders
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_tracking_reminders = count(grouped.total)]',
    number_of_user_tags                       int unsigned                        null comment 'Number of User Tags for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from user_tags
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_user_tags = count(grouped.total)]',
    number_of_user_variables                  int unsigned                        null comment 'Number of User Variables for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from user_variables
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_user_variables = count(grouped.total)]',
    number_of_variables                       int unsigned                        null comment 'Number of Variables for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from variables
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_variables = count(grouped.total)]',
    number_of_votes                           int unsigned                        null comment 'Number of Votes for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from votes
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_votes = count(grouped.total)]',
    primary key (client_id)
)
    comment 'OAuth Clients authorized to read or write user data' charset = utf8;

create table if not exists oauth_access_tokens
(
    id         varchar(100) not null,
    user_id    bigint       null,
    client_id  int unsigned not null,
    name       varchar(255) null,
    scopes     text         null,
    revoked    tinyint(1)   not null,
    created_at timestamp    null,
    updated_at timestamp    null,
    expires_at datetime     null,
    primary key (id)
)
    collate = utf8_unicode_ci;

create index oauth_access_tokens_user_id_index
    on oauth_access_tokens (user_id);

create table if not exists oauth_auth_codes
(
    id         varchar(100) not null,
    user_id    bigint       not null,
    client_id  int unsigned not null,
    scopes     text         null,
    revoked    tinyint(1)   not null,
    expires_at datetime     null,
    primary key (id)
)
    collate = utf8_unicode_ci;

create table if not exists oauth_clients
(
    id                     int unsigned auto_increment
        primary key,
    user_id                bigint       null,
    name                   varchar(255) not null,
    secret                 varchar(100) not null,
    redirect               text         not null,
    personal_access_client tinyint(1)   not null,
    password_client        tinyint(1)   not null,
    revoked                tinyint(1)   not null,
    created_at             timestamp    null,
    updated_at             timestamp    null
)
    collate = utf8_unicode_ci;

create index oauth_clients_user_id_index
    on oauth_clients (user_id);

create table if not exists oauth_personal_access_clients
(
    id         int unsigned auto_increment
        primary key,
    client_id  int unsigned not null,
    created_at timestamp    null,
    updated_at timestamp    null
)
    collate = utf8_unicode_ci;

create index oauth_personal_access_clients_client_id_index
    on oauth_personal_access_clients (client_id);

create table if not exists oauth_refresh_tokens
(
    id              varchar(100) not null,
    access_token_id varchar(100) not null,
    revoked         tinyint(1)   not null,
    expires_at      datetime     null,
    primary key (id)
)
    collate = utf8_unicode_ci;

create index oauth_refresh_tokens_access_token_id_index
    on oauth_refresh_tokens (access_token_id);

create table if not exists password_resets
(
    email      varchar(255)                        not null,
    token      varchar(255)                        not null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    updated_at timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at timestamp                           null,
    client_id  varchar(255)                        null
)
    charset = utf8;

create index password_resets_email_index
    on password_resets (email);

create index password_resets_token_index
    on password_resets (token);

create table if not exists permissions
(
    id          int unsigned auto_increment
        primary key,
    name        varchar(255) not null,
    slug        varchar(255) not null,
    description varchar(255) null,
    model       varchar(255) null,
    created_at  timestamp    null,
    updated_at  timestamp    null,
    deleted_at  timestamp    null,
    constraint permissions_slug_unique
        unique (slug)
)
    collate = utf8_unicode_ci;

create table if not exists roles
(
    id          int unsigned auto_increment
        primary key,
    name        varchar(255)  not null,
    slug        varchar(255)  not null,
    description varchar(255)  null,
    level       int default 1 not null,
    created_at  timestamp     null,
    updated_at  timestamp     null,
    deleted_at  timestamp     null,
    constraint roles_slug_unique
        unique (slug)
)
    collate = utf8_unicode_ci;

create table if not exists permission_role
(
    id            int unsigned auto_increment
        primary key,
    permission_id int unsigned not null,
    role_id       int unsigned not null,
    created_at    timestamp    null,
    updated_at    timestamp    null,
    deleted_at    timestamp    null,
    constraint permission_role_permission_id_foreign
        foreign key (permission_id) references permissions (id)
            on delete cascade,
    constraint permission_role_role_id_foreign
        foreign key (role_id) references roles (id)
            on delete cascade
)
    collate = utf8_unicode_ci;

create index permission_role_permission_id_index
    on permission_role (permission_id);

create index permission_role_role_id_index
    on permission_role (role_id);

create table if not exists schedules
(
    id                       int unsigned auto_increment
        primary key,
    command                  varchar(255)         not null,
    command_custom           varchar(255)         null,
    params                   text                 null,
    expression               varchar(255)         not null,
    options                  text                 null,
    even_in_maintenance_mode tinyint(1) default 0 not null,
    without_overlapping      tinyint(1) default 0 not null,
    on_one_server            tinyint(1) default 0 not null,
    webhook_before           varchar(255)         null,
    webhook_after            varchar(255)         null,
    email_output             varchar(255)         null,
    sendmail_error           tinyint(1) default 0 not null,
    status                   tinyint(1) default 1 not null,
    run_in_background        tinyint(1) default 0 not null,
    created_at               timestamp            null,
    updated_at               timestamp            null,
    deleted_at               timestamp            null,
    sendmail_success         tinyint(1) default 0 not null
)
    collate = utf8_unicode_ci;

create table if not exists schedule_histories
(
    id          int unsigned auto_increment
        primary key,
    schedule_id int unsigned not null,
    command     varchar(255) not null,
    params      text         null,
    output      text         not null,
    options     text         null,
    created_at  timestamp    null,
    updated_at  timestamp    null,
    constraint schedule_histories_schedule_id_foreign
        foreign key (schedule_id) references schedules (id)
)
    collate = utf8_unicode_ci;

create table if not exists sessions
(
    id            varchar(255)    not null,
    user_id       bigint unsigned null,
    ip_address    varchar(45)     null,
    user_agent    text            null,
    payload       text            not null,
    last_activity int             not null,
    constraint sessions_id_unique
        unique (id)
)
    collate = utf8_unicode_ci;

create table if not exists source_platforms
(
    id         smallint(5) auto_increment
        primary key,
    name       varchar(32)                         not null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    updated_at timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at timestamp                           null,
    client_id  varchar(255)                        null,
    constraint source_platforms_client_id_fk
        foreign key (client_id) references oa_clients (client_id)
)
    charset = utf8;

create table if not exists tags
(
    id           int unsigned auto_increment
        primary key,
    name         json         not null,
    slug         json         not null,
    type         varchar(255) null,
    order_column int          null,
    created_at   timestamp    null,
    updated_at   timestamp    null
)
    collate = utf8_unicode_ci;

create table if not exists taggables
(
    tag_id        int unsigned    not null,
    taggable_type varchar(255)    not null,
    taggable_id   bigint unsigned not null,
    constraint taggables_tag_id_taggable_id_taggable_type_unique
        unique (tag_id, taggable_id, taggable_type),
    constraint taggables_tag_id_foreign
        foreign key (tag_id) references tags (id)
            on delete cascade
)
    collate = utf8_unicode_ci;

create index taggables_taggable_type_taggable_id_index
    on taggables (taggable_type, taggable_id);

create table if not exists telescope_entries
(
    sequence                bigint unsigned auto_increment
        primary key,
    uuid                    char(36)             not null,
    batch_id                char(36)             not null,
    family_hash             varchar(255)         null,
    should_display_on_index tinyint(1) default 1 not null,
    type                    varchar(20)          not null,
    content                 longtext             not null,
    created_at              datetime             null,
    constraint telescope_entries_uuid_unique
        unique (uuid)
)
    charset = utf8;

create index telescope_entries_batch_id_index
    on telescope_entries (batch_id);

create index telescope_entries_family_hash_index
    on telescope_entries (family_hash);

create index telescope_entries_type_should_display_on_index_index
    on telescope_entries (type, should_display_on_index);

create table if not exists telescope_entries_tags
(
    entry_uuid char(36)     not null,
    tag        varchar(255) not null,
    constraint telescope_entries_tags_entry_uuid_foreign
        foreign key (entry_uuid) references telescope_entries (uuid)
            on delete cascade
)
    charset = utf8;

create index telescope_entries_tags_entry_uuid_tag_index
    on telescope_entries_tags (entry_uuid, tag);

create index telescope_entries_tags_tag_index
    on telescope_entries_tags (tag);

create table if not exists telescope_monitoring
(
    tag varchar(255) not null
)
    charset = utf8;

create table if not exists unit_categories
(
    id            tinyint unsigned auto_increment
        primary key,
    name          varchar(64)                          not null comment 'Unit category name',
    created_at    timestamp  default CURRENT_TIMESTAMP not null,
    updated_at    timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    can_be_summed tinyint(1) default 1                 not null,
    deleted_at    timestamp                            null,
    sort_order    int                                  not null
)
    comment 'Category for the unit of measurement' charset = utf8;

create table if not exists unit_conversions
(
    unit_id     int unsigned                        not null,
    step_number tinyint unsigned                    not null comment 'step in the conversion process',
    operation   tinyint unsigned                    not null comment '0 is add and 1 is multiply',
    value       double                              not null comment 'number used in the operation',
    created_at  timestamp default CURRENT_TIMESTAMP not null,
    updated_at  timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at  timestamp                           null,
    primary key (unit_id, step_number)
)
    charset = utf8;

create table if not exists units
(
    id                                               smallint unsigned auto_increment
        primary key,
    name                                             varchar(64)                                      not null comment 'Unit name',
    abbreviated_name                                 varchar(16)                                      not null comment 'Unit abbreviation',
    unit_category_id                                 tinyint unsigned                                 not null comment 'Unit category ID',
    minimum_value                                    double                                           null comment 'The minimum value for a single measurement. ',
    maximum_value                                    double                                           null comment 'The maximum value for a single measurement',
    created_at                                       timestamp default CURRENT_TIMESTAMP              not null,
    updated_at                                       timestamp default CURRENT_TIMESTAMP              not null on update CURRENT_TIMESTAMP,
    deleted_at                                       timestamp                                        null,
    filling_type                                     enum ('zero', 'none', 'interpolation', 'value')  not null comment 'The filling type specifies how periods of missing data should be treated. ',
    number_of_outcome_population_studies             int unsigned                                     null comment 'Number of Global Population Studies for this Cause Unit.
                [Formula:
                    update units
                        left join (
                            select count(id) as total, cause_unit_id
                            from aggregate_correlations
                            group by cause_unit_id
                        )
                        as grouped on units.id = grouped.cause_unit_id
                    set units.number_of_outcome_population_studies = count(grouped.total)
                ]
                ',
    number_of_common_tags_where_tag_variable_unit    int unsigned                                     null comment 'Number of Common Tags for this Tag Variable Unit.
                [Formula:
                    update units
                        left join (
                            select count(id) as total, tag_variable_unit_id
                            from common_tags
                            group by tag_variable_unit_id
                        )
                        as grouped on units.id = grouped.tag_variable_unit_id
                    set units.number_of_common_tags_where_tag_variable_unit = count(grouped.total)
                ]
                ',
    number_of_common_tags_where_tagged_variable_unit int unsigned                                     null comment 'Number of Common Tags for this Tagged Variable Unit.
                [Formula:
                    update units
                        left join (
                            select count(id) as total, tagged_variable_unit_id
                            from common_tags
                            group by tagged_variable_unit_id
                        )
                        as grouped on units.id = grouped.tagged_variable_unit_id
                    set units.number_of_common_tags_where_tagged_variable_unit = count(grouped.total)
                ]
                ',
    number_of_outcome_case_studies                   int unsigned                                     null comment 'Number of Individual Case Studies for this Cause Unit.
                [Formula:
                    update units
                        left join (
                            select count(id) as total, cause_unit_id
                            from correlations
                            group by cause_unit_id
                        )
                        as grouped on units.id = grouped.cause_unit_id
                    set units.number_of_outcome_case_studies = count(grouped.total)
                ]
                ',
    number_of_measurements                           int unsigned                                     null comment 'Number of Measurements for this Unit.
                    [Formula: update units
                        left join (
                            select count(id) as total, unit_id
                            from measurements
                            group by unit_id
                        )
                        as grouped on units.id = grouped.unit_id
                    set units.number_of_measurements = count(grouped.total)]',
    number_of_user_variables_where_default_unit      int unsigned                                     null comment 'Number of User Variables for this Default Unit.
                    [Formula: update units
                        left join (
                            select count(id) as total, default_unit_id
                            from user_variables
                            group by default_unit_id
                        )
                        as grouped on units.id = grouped.default_unit_id
                    set units.number_of_user_variables_where_default_unit = count(grouped.total)]',
    number_of_variable_categories_where_default_unit int unsigned                                     null comment 'Number of Variable Categories for this Default Unit.
                    [Formula: update units
                        left join (
                            select count(id) as total, default_unit_id
                            from variable_categories
                            group by default_unit_id
                        )
                        as grouped on units.id = grouped.default_unit_id
                    set units.number_of_variable_categories_where_default_unit = count(grouped.total)]',
    number_of_variables_where_default_unit           int unsigned                                     null comment 'Number of Variables for this Default Unit.
                    [Formula: update units
                        left join (
                            select count(id) as total, default_unit_id
                            from variables
                            group by default_unit_id
                        )
                        as grouped on units.id = grouped.default_unit_id
                    set units.number_of_variables_where_default_unit = count(grouped.total)]',
    advanced                                         tinyint(1)                                       not null comment 'Advanced units are rarely used and should generally be hidden or at the bottom of selector lists',
    manual_tracking                                  tinyint(1)                                       not null comment 'Include manual tracking units in selector when manually recording a measurement. ',
    filling_value                                    float                                            null comment 'The filling value is substituted used when data is missing if the filling type is set to value.',
    scale                                            enum ('nominal', 'interval', 'ratio', 'ordinal') not null comment '
Ordinal is used to simply depict the order of variables and not the difference between each of the variables. Ordinal scales are generally used to depict non-mathematical ideas such as frequency, satisfaction, happiness, a degree of pain etc.

Ratio Scale not only produces the order of variables but also makes the difference between variables known along with information on the value of true zero.

Interval scale contains all the properties of ordinal scale, in addition to which, it offers a calculation of the difference between variables. The main characteristic of this scale is the equidistant difference between objects. Interval has no pre-decided starting point or a true zero value.

Nominal, also called the categorical variable scale, is defined as a scale used for labeling variables into distinct classifications and doesn’t involve a quantitative value or order.
',
    conversion_steps                                 text                                             null comment 'An array of mathematical operations, each containing a operation and value field to apply to the value in the current unit to convert it to the default unit for the unit category. ',
    maximum_daily_value                              double                                           null comment 'The maximum aggregated measurement value over a single day.',
    sort_order                                       int                                              not null,
    slug                                             varchar(200)                                     null comment 'The slug is the part of a URL that identifies a page in human-readable keywords.',
    constraint abbr_name_UNIQUE
        unique (abbreviated_name),
    constraint name_UNIQUE
        unique (name),
    constraint units_slug_uindex
        unique (slug)
)
    comment 'Units of measurement' charset = utf8;

create index fk_unitCategory
    on units (unit_category_id);

create table if not exists user_follower
(
    id           int unsigned auto_increment
        primary key,
    following_id bigint unsigned not null,
    follower_id  bigint unsigned not null,
    accepted_at  timestamp       null,
    created_at   timestamp       null,
    updated_at   timestamp       null
)
    collate = utf8_unicode_ci;

create index user_follower_accepted_at_index
    on user_follower (accepted_at);

create index user_follower_follower_id_index
    on user_follower (follower_id);

create index user_follower_following_id_index
    on user_follower (following_id);

create table if not exists variable_categories
(
    id                                           tinyint unsigned auto_increment
        primary key,
    name                                         varchar(64)                                     not null comment 'Name of the category',
    filling_value                                double                                          null comment 'Value for replacing null measurements',
    maximum_allowed_value                        double                                          null comment 'Maximum recorded value of this category',
    minimum_allowed_value                        double                                          null comment 'Minimum recorded value of this category',
    duration_of_action                           int unsigned         default 86400              not null comment 'How long the effect of a measurement in this variable lasts',
    onset_delay                                  int unsigned         default 0                  not null comment 'How long it takes for a measurement in this variable to take effect',
    combination_operation                        enum ('SUM', 'MEAN') default 'SUM'              not null comment 'How to combine values of this variable (for instance, to see a summary of the values over a month) SUM or MEAN',
    cause_only                                   tinyint(1)           default 0                  not null comment 'A value of 1 indicates that this category is generally a cause in a causal relationship.  An example of a causeOnly category would be a category such as Work which would generally not be influenced by the behaviour of the user',
    outcome                                      tinyint(1)                                      null,
    created_at                                   timestamp            default CURRENT_TIMESTAMP  not null,
    updated_at                                   timestamp            default CURRENT_TIMESTAMP  not null on update CURRENT_TIMESTAMP,
    image_url                                    tinytext                                        null comment 'Image URL',
    default_unit_id                              smallint unsigned    default 12                 null comment 'ID of the default unit for the category',
    deleted_at                                   timestamp                                       null,
    manual_tracking                              tinyint(1)           default 0                  not null comment 'Should we include in manual tracking searches?',
    minimum_allowed_seconds_between_measurements int                                             null,
    average_seconds_between_measurements         int                                             null,
    median_seconds_between_measurements          int                                             null,
    wp_post_id                                   bigint unsigned                                 null,
    filling_type                                 enum ('zero', 'none', 'interpolation', 'value') null,
    number_of_outcome_population_studies         int unsigned                                    null comment 'Number of Global Population Studies for this Cause Variable Category.
                [Formula:
                    update variable_categories
                        left join (
                            select count(id) as total, cause_variable_category_id
                            from aggregate_correlations
                            group by cause_variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.cause_variable_category_id
                    set variable_categories.number_of_outcome_population_studies = count(grouped.total)
                ]
                ',
    number_of_predictor_population_studies       int unsigned                                    null comment 'Number of Global Population Studies for this Effect Variable Category.
                [Formula:
                    update variable_categories
                        left join (
                            select count(id) as total, effect_variable_category_id
                            from aggregate_correlations
                            group by effect_variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.effect_variable_category_id
                    set variable_categories.number_of_predictor_population_studies = count(grouped.total)
                ]
                ',
    number_of_outcome_case_studies               int unsigned                                    null comment 'Number of Individual Case Studies for this Cause Variable Category.
                [Formula:
                    update variable_categories
                        left join (
                            select count(id) as total, cause_variable_category_id
                            from correlations
                            group by cause_variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.cause_variable_category_id
                    set variable_categories.number_of_outcome_case_studies = count(grouped.total)
                ]
                ',
    number_of_predictor_case_studies             int unsigned                                    null comment 'Number of Individual Case Studies for this Effect Variable Category.
                [Formula:
                    update variable_categories
                        left join (
                            select count(id) as total, effect_variable_category_id
                            from correlations
                            group by effect_variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.effect_variable_category_id
                    set variable_categories.number_of_predictor_case_studies = count(grouped.total)
                ]
                ',
    number_of_measurements                       int unsigned                                    null comment 'Number of Measurements for this Variable Category.
                    [Formula: update variable_categories
                        left join (
                            select count(id) as total, variable_category_id
                            from measurements
                            group by variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.variable_category_id
                    set variable_categories.number_of_measurements = count(grouped.total)]',
    number_of_user_variables                     int unsigned                                    null comment 'Number of User Variables for this Variable Category.
                    [Formula: update variable_categories
                        left join (
                            select count(id) as total, variable_category_id
                            from user_variables
                            group by variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.variable_category_id
                    set variable_categories.number_of_user_variables = count(grouped.total)]',
    number_of_variables                          int unsigned                                    null comment 'Number of Variables for this Variable Category.
                    [Formula: update variable_categories
                        left join (
                            select count(id) as total, variable_category_id
                            from variables
                            group by variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.variable_category_id
                    set variable_categories.number_of_variables = count(grouped.total)]',
    is_public                                    tinyint(1)                                      null,
    synonyms                                     varchar(600)                                    not null comment 'The primary name and any synonyms for it. This field should be used for non-specific searches.',
    amazon_product_category                      varchar(100)                                    not null comment 'The Amazon equivalent product category.',
    boring                                       tinyint(1)                                      null comment 'If boring, the category should be hidden by default.',
    effect_only                                  tinyint(1)                                      null comment 'effect_only is true if people would never be interested in the effects of most variables in the category.',
    predictor                                    tinyint(1)                                      null comment 'Predictor is true if people would like to know the effects of most variables in the category.',
    font_awesome                                 varchar(100)                                    null,
    ion_icon                                     varchar(100)                                    null,
    more_info                                    varchar(255)                                    null comment 'More information displayed when the user is adding reminders and going through the onboarding process. ',
    valence                                      enum ('positive', 'negative', 'neutral')        not null comment 'Set the valence positive if more is better for all the variables in the category, negative if more is bad, and neutral if none of the variables have such a valence. Valence is null if there is not a consistent valence for all variables in the category. ',
    name_singular                                varchar(255)                                    not null comment 'The singular version of the name.',
    sort_order                                   int                                             not null,
    is_goal                                      enum ('ALWAYS', 'SOMETIMES', 'NEVER')           not null comment 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  The foods you eat are not generally an objective end in themselves. ',
    controllable                                 enum ('ALWAYS', 'SOMETIMES', 'NEVER')           not null comment 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  Symptom severity is not directly controllable. ',
    slug                                         varchar(200)                                    null comment 'The slug is the part of a URL that identifies a page in human-readable keywords.',
    constraint variable_categories_slug_uindex
        unique (slug),
    constraint variable_categories_default_unit_id_fk
        foreign key (default_unit_id) references units (id)
)
    comment 'Categories of of trackable variables include Treatments, Emotions, Symptoms, and Foods.' charset = utf8;

create table if not exists aggregate_correlations
(
    id                                                           int auto_increment
        primary key,
    forward_pearson_correlation_coefficient                      float(10, 4)                                                    not null comment 'Pearson correlation coefficient between cause and effect measurements',
    onset_delay                                                  int                                                             not null comment 'User estimated or default time after cause measurement before a perceivable effect is observed',
    duration_of_action                                           int                                                             not null comment 'Time over which the cause is expected to produce a perceivable effect following the onset delay',
    number_of_pairs                                              int                                                             not null comment 'Number of points that went into the correlation calculation',
    value_predicting_high_outcome                                double                                                          not null comment 'cause value that predicts an above average effect value (in default unit for cause variable)',
    value_predicting_low_outcome                                 double                                                          not null comment 'cause value that predicts a below average effect value (in default unit for cause variable)',
    optimal_pearson_product                                      double                                                          not null comment 'Optimal Pearson Product',
    average_vote                                                 float(3, 1) default 0.5                                         null comment 'Vote',
    number_of_users                                              int                                                             not null comment 'Number of Users by which correlation is aggregated',
    number_of_correlations                                       int                                                             not null comment 'Number of Correlations by which correlation is aggregated',
    statistical_significance                                     float(10, 4)                                                    not null comment 'A function of the effect size and sample size',
    cause_unit_id                                                smallint unsigned                                               null comment 'Unit ID of Cause',
    cause_changes                                                int                                                             not null comment 'The number of times the cause measurement value was different from the one preceding it.',
    effect_changes                                               int                                                             not null comment 'The number of times the effect measurement value was different from the one preceding it.',
    aggregate_qm_score                                           double                                                          not null comment 'A number representative of the relative importance of the relationship based on the strength, usefulness, and plausible causality.  The higher the number, the greater the perceived importance.  This value can be used for sorting relationships by importance. ',
    created_at                                                   timestamp   default CURRENT_TIMESTAMP                           not null,
    updated_at                                                   timestamp   default CURRENT_TIMESTAMP                           not null on update CURRENT_TIMESTAMP,
    status                                                       varchar(25)                                                     not null comment 'Whether the correlation is being analyzed, needs to be analyzed, or is up to date already.',
    reverse_pearson_correlation_coefficient                      double                                                          not null comment 'Correlation when cause and effect are reversed. For any causal relationship, the forward correlation should exceed the reverse correlation',
    predictive_pearson_correlation_coefficient                   double                                                          not null comment 'Pearson correlation coefficient of cause and effect values lagged by the onset delay and grouped based on the duration of action. ',
    data_source_name                                             varchar(255)                                                    null,
    predicts_high_effect_change                                  int(5)                                                          not null comment 'The percent change in the outcome typically seen when the predictor value is closer to the predictsHighEffect value. ',
    predicts_low_effect_change                                   int(5)                                                          not null comment 'The percent change in the outcome from average typically seen when the predictor value is closer to the predictsHighEffect value.',
    p_value                                                      double                                                          not null comment 'The measure of statistical significance. A value less than 0.05 means that a correlation is statistically significant or consistent enough that it is unlikely to be a coincidence.',
    t_value                                                      double                                                          not null comment 'Function of correlation and number of samples.',
    critical_t_value                                             double                                                          not null comment 'Value of t from lookup table which t must exceed for significance.',
    confidence_interval                                          double                                                          not null comment 'A margin of error around the effect size.  Wider confidence intervals reflect greater uncertainty about the true value of the correlation.',
    deleted_at                                                   timestamp                                                       null,
    average_effect                                               double                                                          not null comment 'The average effect variable measurement value used in analysis in the common unit. ',
    average_effect_following_high_cause                          double                                                          not null comment 'The average effect variable measurement value following an above average cause value (in the common unit). ',
    average_effect_following_low_cause                           double                                                          not null comment 'The average effect variable measurement value following a below average cause value (in the common unit). ',
    average_daily_low_cause                                      double                                                          not null comment 'The average of below average cause values (in the common unit). ',
    average_daily_high_cause                                     double                                                          not null comment 'The average of above average cause values (in the common unit). ',
    population_trait_pearson_correlation_coefficient             double                                                          null comment 'The pearson correlation of pairs which each consist of the average cause value and the average effect value for a given user. ',
    grouped_cause_value_closest_to_value_predicting_low_outcome  double                                                          not null comment 'A realistic daily value (not a fraction from averaging) that typically precedes below average outcome values. ',
    grouped_cause_value_closest_to_value_predicting_high_outcome double                                                          not null comment 'A realistic daily value (not a fraction from averaging) that typically precedes below average outcome values. ',
    client_id                                                    varchar(255)                                                    null,
    published_at                                                 timestamp                                                       null,
    wp_post_id                                                   bigint unsigned                                                 null,
    cause_variable_category_id                                   tinyint unsigned                                                not null,
    effect_variable_category_id                                  tinyint unsigned                                                not null,
    interesting_variable_category_pair                           tinyint(1)                                                      not null comment 'True if the combination of cause and effect variable categories are generally interesting.  For instance, treatment cause variables paired with symptom effect variables are interesting. ',
    newest_data_at                                               timestamp                                                       null,
    analysis_requested_at                                        timestamp                                                       null,
    reason_for_analysis                                          varchar(255)                                                    not null comment 'The reason analysis was requested.',
    analysis_started_at                                          timestamp                                                       not null,
    analysis_ended_at                                            timestamp                                                       null,
    user_error_message                                           text                                                            null,
    internal_error_message                                       text                                                            null,
    cause_variable_id                                            int unsigned                                                    not null,
    effect_variable_id                                           int unsigned                                                    not null,
    cause_baseline_average_per_day                               float                                                           not null comment 'Predictor Average at Baseline (The average low non-treatment value of the predictor per day)',
    cause_baseline_average_per_duration_of_action                float                                                           not null comment 'Predictor Average at Baseline (The average low non-treatment value of the predictor per duration of action)',
    cause_treatment_average_per_day                              float                                                           not null comment 'Predictor Average During Treatment (The average high value of the predictor per day considered to be the treatment dosage)',
    cause_treatment_average_per_duration_of_action               float                                                           not null comment 'Predictor Average During Treatment (The average high value of the predictor per duration of action considered to be the treatment dosage)',
    effect_baseline_average                                      float                                                           not null comment 'Outcome Average at Baseline (The normal value for the outcome seen without treatment during the previous duration of action time span)',
    effect_baseline_relative_standard_deviation                  float                                                           not null comment 'Outcome Average at Baseline (The average value seen for the outcome without treatment during the previous duration of action time span)',
    effect_baseline_standard_deviation                           float                                                           not null comment 'Outcome Relative Standard Deviation at Baseline (How much the outcome value normally fluctuates without treatment during the previous duration of action time span)',
    effect_follow_up_average                                     float                                                           not null comment 'Outcome Average at Follow-Up (The average value seen for the outcome during the duration of action following the onset delay of the treatment)',
    effect_follow_up_percent_change_from_baseline                float                                                           not null comment 'Outcome Average at Follow-Up (The average value seen for the outcome during the duration of action following the onset delay of the treatment)',
    z_score                                                      float                                                           not null comment 'The absolute value of the change over duration of action following the onset delay of treatment divided by the baseline outcome relative standard deviation. A.K.A The number of standard deviations from the mean. A zScore > 2 means pValue < 0.05 and is typically considered statistically significant.',
    charts                                                       json                                                            not null,
    number_of_variables_where_best_aggregate_correlation         int unsigned                                                    not null comment 'Number of Variables for this Best Aggregate Correlation.
                    [Formula: update aggregate_correlations
                        left join (
                            select count(id) as total, best_aggregate_correlation_id
                            from variables
                            group by best_aggregate_correlation_id
                        )
                        as grouped on aggregate_correlations.id = grouped.best_aggregate_correlation_id
                    set aggregate_correlations.number_of_variables_where_best_aggregate_correlation = count(grouped.total)]',
    deletion_reason                                              varchar(280)                                                    null comment 'The reason the variable was deleted.',
    record_size_in_kb                                            int                                                             null,
    is_public                                                    tinyint(1)                                                      not null,
    boring                                                       tinyint(1)                                                      null comment 'The relationship is boring if it is obvious, the predictor is not controllable, or the outcome is not a goal, the relationship could not be causal, or the confidence is low.  ',
    outcome_is_a_goal                                            tinyint(1)                                                      null comment 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  The foods you eat are not generally an objective end in themselves. ',
    predictor_is_controllable                                    tinyint(1)                                                      null comment 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  Symptom severity is not directly controllable. ',
    plausibly_causal                                             tinyint(1)                                                      null comment 'The effect of aspirin on headaches is plausibly causal. The effect of aspirin on precipitation does not have a plausible causal relationship. ',
    obvious                                                      tinyint(1)                                                      null comment 'The effect of aspirin on headaches is obvious. The effect of aspirin on productivity is not obvious. ',
    number_of_up_votes                                           int                                                             not null comment 'Number of people who feel this relationship is plausible and useful. ',
    number_of_down_votes                                         int                                                             not null comment 'Number of people who feel this relationship is implausible or not useful. ',
    strength_level                                               enum ('VERY STRONG', 'STRONG', 'MODERATE', 'WEAK', 'VERY WEAK') not null comment 'Strength level describes magnitude of the change in outcome observed following changes in the predictor. ',
    confidence_level                                             enum ('HIGH', 'MEDIUM', 'LOW')                                  not null comment 'Describes the confidence that the strength level will remain consist in the future.  The more data there is, the lesser the chance that the findings are a spurious correlation. ',
    relationship                                                 enum ('POSITIVE', 'NEGATIVE', 'NONE')                           not null comment 'If higher predictor values generally precede HIGHER outcome values, the relationship is considered POSITIVE.  If higher predictor values generally precede LOWER outcome values, the relationship is considered NEGATIVE. ',
    slug                                                         varchar(200)                                                    null comment 'The slug is the part of a URL that identifies a page in human-readable keywords.',
    constraint aggregate_correlations_pk
        unique (cause_variable_id, effect_variable_id),
    constraint aggregate_correlations_slug_uindex
        unique (slug),
    constraint cause_variable_id_effect_variable_id_uindex
        unique (cause_variable_id, effect_variable_id),
    constraint aggregate_correlations_cause_unit_id_fk
        foreign key (cause_unit_id) references units (id),
    constraint aggregate_correlations_cause_variable_category_id_fk
        foreign key (cause_variable_category_id) references variable_categories (id),
    constraint aggregate_correlations_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint aggregate_correlations_effect_variable_category_id_fk
        foreign key (effect_variable_category_id) references variable_categories (id)
)
    comment 'Stores Calculated Aggregated Correlation Coefficients' charset = utf8;

create index aggregate_correlations_effect_variable_id_index
    on aggregate_correlations (effect_variable_id);

create table if not exists variables
(
    id                                                  int unsigned auto_increment
        primary key,
    name                                                varchar(125)                                    not null comment 'User-defined variable display name',
    number_of_user_variables                            int         default 0                           not null comment 'Number of variables',
    variable_category_id                                tinyint unsigned                                not null comment 'Variable category ID',
    default_unit_id                                     smallint unsigned                               not null comment 'ID of the default unit for the variable',
    default_value                                       double                                          null,
    cause_only                                          tinyint(1)                                      null comment 'A value of 1 indicates that this variable is generally a cause in a causal relationship.  An example of a causeOnly variable would be a variable such as Cloud Cover which would generally not be influenced by the behaviour of the user',
    client_id                                           varchar(80)                                     null,
    combination_operation                               enum ('SUM', 'MEAN')                            null comment 'How to combine values of this variable (for instance, to see a summary of the values over a month) SUM or MEAN',
    common_alias                                        varchar(125)                                    null,
    created_at                                          timestamp   default CURRENT_TIMESTAMP           not null,
    description                                         text                                            null,
    duration_of_action                                  int unsigned                                    null comment 'How long the effect of a measurement in this variable lasts',
    filling_value                                       double      default -1                          null comment 'Value for replacing null measurements',
    image_url                                           varchar(2083)                                   null,
    informational_url                                   varchar(2083)                                   null,
    ion_icon                                            varchar(40)                                     null,
    kurtosis                                            double                                          null comment 'Kurtosis',
    maximum_allowed_value                               double                                          null comment 'Maximum reasonable value for a single measurement for this variable in the default unit. ',
    maximum_recorded_value                              double                                          null comment 'Maximum recorded value of this variable',
    mean                                                double                                          null comment 'Mean',
    median                                              double                                          null comment 'Median',
    minimum_allowed_value                               double                                          null comment 'Minimum reasonable value for this variable (uses default unit)',
    minimum_recorded_value                              double                                          null comment 'Minimum recorded value of this variable',
    number_of_aggregate_correlations_as_cause           int unsigned                                    null comment 'Number of aggregate correlations for which this variable is the cause variable',
    most_common_original_unit_id                        int                                             null comment 'Most common Unit ID',
    most_common_value                                   double                                          null comment 'Most common value',
    number_of_aggregate_correlations_as_effect          int unsigned                                    null comment 'Number of aggregate correlations for which this variable is the effect variable',
    number_of_unique_values                             int                                             null comment 'Number of unique values',
    onset_delay                                         int unsigned                                    null comment 'How long it takes for a measurement in this variable to take effect',
    outcome                                             tinyint(1)                                      null comment 'Outcome variables (those with `outcome` == 1) are variables for which a human would generally want to identify the influencing factors.  These include symptoms of illness, physique, mood, cognitive performance, etc.  Generally correlation calculations are only performed on outcome variables.',
    parent_id                                           int unsigned                                    null comment 'ID of the parent variable if this variable has any parent',
    price                                               double                                          null comment 'Price',
    product_url                                         varchar(2083)                                   null comment 'Product URL',
    second_most_common_value                            double                                          null,
    skewness                                            double                                          null comment 'Skewness',
    standard_deviation                                  double                                          null comment 'Standard Deviation',
    status                                              varchar(25) default 'WAITING'                   not null comment 'status',
    third_most_common_value                             double                                          null,
    updated_at                                          timestamp   default CURRENT_TIMESTAMP           not null on update CURRENT_TIMESTAMP,
    variance                                            double                                          null comment 'Variance',
    most_common_connector_id                            int unsigned                                    null,
    synonyms                                            varchar(600)                                    null comment 'The primary variable name and any synonyms for it. This field should be used for non-specific variable searches.',
    wikipedia_url                                       varchar(2083)                                   null,
    brand_name                                          varchar(125)                                    null,
    valence                                             enum ('positive', 'negative', 'neutral')        null,
    wikipedia_title                                     varchar(100)                                    null,
    number_of_tracking_reminders                        int                                             null,
    upc_12                                              varchar(255)                                    null,
    upc_14                                              varchar(255)                                    null,
    number_common_tagged_by                             int unsigned                                    null,
    number_of_common_tags                               int unsigned                                    null,
    deleted_at                                          timestamp                                       null,
    most_common_source_name                             varchar(255)                                    null,
    data_sources_count                                  text                                            null comment 'Array of connector or client measurement data source names as key with number of users as value',
    optimal_value_message                               varchar(500)                                    null,
    best_cause_variable_id                              int unsigned                                    null,
    best_effect_variable_id                             int unsigned                                    null,
    common_maximum_allowed_daily_value                  double                                          null,
    common_minimum_allowed_daily_value                  double                                          null,
    common_minimum_allowed_non_zero_value               double                                          null,
    minimum_allowed_seconds_between_measurements        int                                             null,
    average_seconds_between_measurements                int                                             null,
    median_seconds_between_measurements                 int                                             null,
    number_of_raw_measurements_with_tags_joins_children int unsigned                                    null,
    additional_meta_data                                text                                            null,
    manual_tracking                                     tinyint(1)                                      null,
    analysis_settings_modified_at                       timestamp                                       null,
    newest_data_at                                      timestamp                                       null,
    analysis_requested_at                               timestamp                                       null,
    reason_for_analysis                                 varchar(255)                                    null,
    analysis_started_at                                 timestamp                                       null,
    analysis_ended_at                                   timestamp                                       null,
    user_error_message                                  text                                            null,
    internal_error_message                              text                                            null,
    latest_tagged_measurement_start_at                  timestamp                                       null,
    earliest_tagged_measurement_start_at                timestamp                                       null,
    latest_non_tagged_measurement_start_at              timestamp                                       null,
    earliest_non_tagged_measurement_start_at            timestamp                                       null,
    wp_post_id                                          bigint unsigned                                 null,
    number_of_soft_deleted_measurements                 int                                             null comment 'Formula: update variables v
                inner join (
                    select measurements.variable_id, count(measurements.id) as number_of_soft_deleted_measurements
                    from measurements
                    where measurements.deleted_at is not null
                    group by measurements.variable_id
                    ) m on v.id = m.variable_id
                set v.number_of_soft_deleted_measurements = m.number_of_soft_deleted_measurements
            ',
    charts                                              json                                            null,
    creator_user_id                                     bigint unsigned                                 not null,
    best_aggregate_correlation_id                       int                                             null,
    filling_type                                        enum ('zero', 'none', 'interpolation', 'value') null,
    number_of_outcome_population_studies                int unsigned                                    null comment 'Number of Global Population Studies for this Cause Variable.
                [Formula:
                    update variables
                        left join (
                            select count(id) as total, cause_variable_id
                            from aggregate_correlations
                            group by cause_variable_id
                        )
                        as grouped on variables.id = grouped.cause_variable_id
                    set variables.number_of_outcome_population_studies = count(grouped.total)
                ]
                ',
    number_of_predictor_population_studies              int unsigned                                    null comment 'Number of Global Population Studies for this Effect Variable.
                [Formula:
                    update variables
                        left join (
                            select count(id) as total, effect_variable_id
                            from aggregate_correlations
                            group by effect_variable_id
                        )
                        as grouped on variables.id = grouped.effect_variable_id
                    set variables.number_of_predictor_population_studies = count(grouped.total)
                ]
                ',
    number_of_applications_where_outcome_variable       int unsigned                                    null comment 'Number of Applications for this Outcome Variable.
                [Formula:
                    update variables
                        left join (
                            select count(id) as total, outcome_variable_id
                            from applications
                            group by outcome_variable_id
                        )
                        as grouped on variables.id = grouped.outcome_variable_id
                    set variables.number_of_applications_where_outcome_variable = count(grouped.total)
                ]
                ',
    number_of_applications_where_predictor_variable     int unsigned                                    null comment 'Number of Applications for this Predictor Variable.
                [Formula:
                    update variables
                        left join (
                            select count(id) as total, predictor_variable_id
                            from applications
                            group by predictor_variable_id
                        )
                        as grouped on variables.id = grouped.predictor_variable_id
                    set variables.number_of_applications_where_predictor_variable = count(grouped.total)
                ]
                ',
    number_of_common_tags_where_tag_variable            int unsigned                                    null comment 'Number of Common Tags for this Tag Variable.
                [Formula:
                    update variables
                        left join (
                            select count(id) as total, tag_variable_id
                            from common_tags
                            group by tag_variable_id
                        )
                        as grouped on variables.id = grouped.tag_variable_id
                    set variables.number_of_common_tags_where_tag_variable = count(grouped.total)
                ]
                ',
    number_of_common_tags_where_tagged_variable         int unsigned                                    null comment 'Number of Common Tags for this Tagged Variable.
                [Formula:
                    update variables
                        left join (
                            select count(id) as total, tagged_variable_id
                            from common_tags
                            group by tagged_variable_id
                        )
                        as grouped on variables.id = grouped.tagged_variable_id
                    set variables.number_of_common_tags_where_tagged_variable = count(grouped.total)
                ]
                ',
    number_of_outcome_case_studies                      int unsigned                                    null comment 'Number of Individual Case Studies for this Cause Variable.
                [Formula:
                    update variables
                        left join (
                            select count(id) as total, cause_variable_id
                            from correlations
                            group by cause_variable_id
                        )
                        as grouped on variables.id = grouped.cause_variable_id
                    set variables.number_of_outcome_case_studies = count(grouped.total)
                ]
                ',
    number_of_predictor_case_studies                    int unsigned                                    null comment 'Number of Individual Case Studies for this Effect Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, effect_variable_id
                            from correlations
                            group by effect_variable_id
                        )
                        as grouped on variables.id = grouped.effect_variable_id
                    set variables.number_of_predictor_case_studies = count(grouped.total)]',
    number_of_measurements                              int unsigned                                    null comment 'Number of Measurements for this Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, variable_id
                            from measurements
                            group by variable_id
                        )
                        as grouped on variables.id = grouped.variable_id
                    set variables.number_of_measurements = count(grouped.total)]',
    number_of_studies_where_cause_variable              int unsigned                                    null comment 'Number of Studies for this Cause Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, cause_variable_id
                            from studies
                            group by cause_variable_id
                        )
                        as grouped on variables.id = grouped.cause_variable_id
                    set variables.number_of_studies_where_cause_variable = count(grouped.total)]',
    number_of_studies_where_effect_variable             int unsigned                                    null comment 'Number of Studies for this Effect Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, effect_variable_id
                            from studies
                            group by effect_variable_id
                        )
                        as grouped on variables.id = grouped.effect_variable_id
                    set variables.number_of_studies_where_effect_variable = count(grouped.total)]',
    number_of_tracking_reminder_notifications           int unsigned                                    null comment 'Number of Tracking Reminder Notifications for this Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, variable_id
                            from tracking_reminder_notifications
                            group by variable_id
                        )
                        as grouped on variables.id = grouped.variable_id
                    set variables.number_of_tracking_reminder_notifications = count(grouped.total)]',
    number_of_user_tags_where_tag_variable              int unsigned                                    null comment 'Number of User Tags for this Tag Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, tag_variable_id
                            from user_tags
                            group by tag_variable_id
                        )
                        as grouped on variables.id = grouped.tag_variable_id
                    set variables.number_of_user_tags_where_tag_variable = count(grouped.total)]',
    number_of_user_tags_where_tagged_variable           int unsigned                                    null comment 'Number of User Tags for this Tagged Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, tagged_variable_id
                            from user_tags
                            group by tagged_variable_id
                        )
                        as grouped on variables.id = grouped.tagged_variable_id
                    set variables.number_of_user_tags_where_tagged_variable = count(grouped.total)]',
    number_of_variables_where_best_cause_variable       int unsigned                                    null comment 'Number of Variables for this Best Cause Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, best_cause_variable_id
                            from variables
                            group by best_cause_variable_id
                        )
                        as grouped on variables.id = grouped.best_cause_variable_id
                    set variables.number_of_variables_where_best_cause_variable = count(grouped.total)]',
    number_of_variables_where_best_effect_variable      int unsigned                                    null comment 'Number of Variables for this Best Effect Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, best_effect_variable_id
                            from variables
                            group by best_effect_variable_id
                        )
                        as grouped on variables.id = grouped.best_effect_variable_id
                    set variables.number_of_variables_where_best_effect_variable = count(grouped.total)]',
    number_of_votes_where_cause_variable                int unsigned                                    null comment 'Number of Votes for this Cause Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, cause_variable_id
                            from votes
                            group by cause_variable_id
                        )
                        as grouped on variables.id = grouped.cause_variable_id
                    set variables.number_of_votes_where_cause_variable = count(grouped.total)]',
    number_of_votes_where_effect_variable               int unsigned                                    null comment 'Number of Votes for this Effect Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, effect_variable_id
                            from votes
                            group by effect_variable_id
                        )
                        as grouped on variables.id = grouped.effect_variable_id
                    set variables.number_of_votes_where_effect_variable = count(grouped.total)]',
    number_of_users_where_primary_outcome_variable      int unsigned                                    null comment 'Number of Users for this Primary Outcome Variable.
                    [Formula: update variables
                        left join (
                            select count(ID) as total, primary_outcome_variable_id
                            from wp_users
                            group by primary_outcome_variable_id
                        )
                        as grouped on variables.id = grouped.primary_outcome_variable_id
                    set variables.number_of_users_where_primary_outcome_variable = count(grouped.total)]',
    deletion_reason                                     varchar(280)                                    null comment 'The reason the variable was deleted.',
    maximum_allowed_daily_value                         double                                          null comment 'The maximum allowed value in the default unit for measurements aggregated over a single day. ',
    record_size_in_kb                                   int                                             null,
    number_of_common_joined_variables                   int                                             null comment 'Joined variables are duplicate variables measuring the same thing. ',
    number_of_common_ingredients                        int                                             null comment 'Measurements for this variable can be used to synthetically generate ingredient measurements. ',
    number_of_common_foods                              int                                             null comment 'Measurements for this ingredient variable can be synthetically generate by food measurements. ',
    number_of_common_children                           int                                             null comment 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. ',
    number_of_common_parents                            int                                             null comment 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. ',
    number_of_user_joined_variables                     int                                             null comment 'Joined variables are duplicate variables measuring the same thing. This only includes ones created by users. ',
    number_of_user_ingredients                          int                                             null comment 'Measurements for this variable can be used to synthetically generate ingredient measurements. This only includes ones created by users. ',
    number_of_user_foods                                int                                             null comment 'Measurements for this ingredient variable can be synthetically generate by food measurements. This only includes ones created by users. ',
    number_of_user_children                             int                                             null comment 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. This only includes ones created by users. ',
    number_of_user_parents                              int                                             null comment 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. This only includes ones created by users. ',
    is_public                                           tinyint(1)                                      null,
    sort_order                                          int                                             not null,
    is_goal                                             tinyint(1)                                      null comment 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  The foods you eat are not generally an objective end in themselves. ',
    controllable                                        tinyint(1)                                      null comment 'You can control the foods you eat directly. However, symptom severity or weather is not directly controllable. ',
    boring                                              tinyint(1)                                      null comment 'The variable is boring if the average person would not be interested in its causes or effects. ',
    slug                                                varchar(200)                                    null comment 'The slug is the part of a URL that identifies a page in human-readable keywords.',
    canonical_variable_id                               int unsigned                                    null comment 'If a variable duplicates another but with a different name, set the canonical variable id to match the variable with the more appropriate name.  Then only the canonical variable will be displayed and all data for the duplicate variable will be included when fetching data for the canonical variable. ',
    predictor                                           tinyint(1)                                      null comment 'predictor is true if the variable is a factor that could influence an outcome of interest',
    source_url                                          varchar(2083)                                   null comment 'URL for the website related to the database containing the info that was used to create this variable such as https://world.openfoodfacts.org or https://dsld.od.nih.gov/dsld ',
    constraint name_UNIQUE
        unique (name),
    constraint variables_slug_uindex
        unique (slug),
    constraint variables_aggregate_correlations_id_fk
        foreign key (best_aggregate_correlation_id) references aggregate_correlations (id)
            on delete set null,
    constraint variables_best_cause_variable_id_fk
        foreign key (best_cause_variable_id) references variables (id)
            on delete set null,
    constraint variables_best_effect_variable_id_fk
        foreign key (best_effect_variable_id) references variables (id)
            on delete set null,
    constraint variables_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint variables_default_unit_id_fk
        foreign key (default_unit_id) references units (id),
    constraint variables_variable_category_id_fk
        foreign key (variable_category_id) references variable_categories (id)
)
    comment 'Variable overviews with statistics, analysis settings, and data visualizations and likely outcomes or predictors based on the anonymously aggregated donated data.'
    charset = utf8;

alter table aggregate_correlations
    add constraint aggregate_correlations_cause_variables_id_fk
        foreign key (cause_variable_id) references variables (id);

alter table aggregate_correlations
    add constraint aggregate_correlations_effect_variables_id_fk
        foreign key (effect_variable_id) references variables (id);

create table if not exists common_tags
(
    id                      int unsigned auto_increment
        primary key,
    tagged_variable_id      int unsigned                        not null comment 'This is the id of the variable being tagged with an ingredient or something.',
    tag_variable_id         int unsigned                        not null comment 'This is the id of the ingredient variable whose value is determined based on the value of the tagged variable.',
    number_of_data_points   int(10)                             null comment 'The number of data points used to estimate the mean. ',
    standard_error          float                               null comment 'Measure of variability of the
mean value as a function of the number of data points.',
    tag_variable_unit_id    smallint unsigned                   null comment 'The id for the unit of the tag (ingredient) variable.',
    tagged_variable_unit_id smallint unsigned                   null comment 'The unit for the source variable to be tagged.',
    conversion_factor       double                              not null comment 'Number by which we multiply the tagged variable''s value to obtain the tag variable''s value',
    client_id               varchar(80)                         null,
    created_at              timestamp default CURRENT_TIMESTAMP not null,
    updated_at              timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at              timestamp                           null,
    constraint UK_tag_tagged
        unique (tagged_variable_id, tag_variable_id),
    constraint common_tags_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint common_tags_tag_variable_id_variables_id_fk
        foreign key (tag_variable_id) references variables (id),
    constraint common_tags_tag_variable_unit_id_fk
        foreign key (tag_variable_unit_id) references units (id),
    constraint common_tags_tagged_variable_id_variables_id_fk
        foreign key (tagged_variable_id) references variables (id),
    constraint common_tags_tagged_variable_unit_id_fk
        foreign key (tagged_variable_unit_id) references units (id)
)
    comment 'Variable tags are used to infer the user intake of the different ingredients by just entering the foods. The inferred intake levels will then be used to determine the effects of different nutrients on the user during analysis.'
    charset = utf8;

create table if not exists ct_causes
(
    id                   int auto_increment
        primary key,
    name                 varchar(100)                        not null,
    variable_id          int unsigned                        not null,
    updated_at           timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at           timestamp default CURRENT_TIMESTAMP not null,
    deleted_at           timestamp                           null,
    number_of_conditions int unsigned                        not null,
    constraint causeName
        unique (name),
    constraint ct_causes_variable_id_uindex
        unique (variable_id),
    constraint ct_causes_variables_id_fk
        foreign key (variable_id) references variables (id)
)
    comment 'User self-reported causes of illness' charset = utf8;

create table if not exists ct_conditions
(
    id                   int auto_increment
        primary key,
    name                 varchar(100)                        not null,
    variable_id          int unsigned                        not null,
    updated_at           timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at           timestamp default CURRENT_TIMESTAMP not null,
    deleted_at           timestamp                           null,
    number_of_treatments int unsigned                        not null,
    number_of_symptoms   int unsigned                        null,
    number_of_causes     int unsigned                        not null,
    constraint conName
        unique (name),
    constraint ct_conditions_variable_id_uindex
        unique (variable_id),
    constraint ct_conditions_variables_id_fk
        foreign key (variable_id) references variables (id)
)
    comment 'User self-reported condition names' charset = utf8;

create table if not exists ct_condition_cause
(
    id                    int auto_increment
        primary key,
    condition_id          int                                 not null,
    cause_id              int                                 not null,
    condition_variable_id int unsigned                        not null,
    cause_variable_id     int unsigned                        not null,
    votes_percent         int                                 not null,
    updated_at            timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at            timestamp default CURRENT_TIMESTAMP not null,
    deleted_at            timestamp                           null,
    constraint ct_condition_cause_cause_id_condition_id_uindex
        unique (cause_id, condition_id),
    constraint ct_condition_cause_cause_uindex
        unique (cause_variable_id, condition_variable_id),
    constraint ct_condition_cause_ct_causes_cause_fk
        foreign key (cause_id) references ct_causes (id),
    constraint ct_condition_cause_ct_conditions_id_condition_fk
        foreign key (condition_id) references ct_conditions (id),
    constraint ct_condition_cause_variables_id_condition_fk
        foreign key (condition_variable_id) references variables (id),
    constraint ct_condition_cause_variables_id_fk
        foreign key (cause_variable_id) references variables (id)
)
    comment 'User self-reported conditions and causes' charset = utf8;

create table if not exists ct_side_effects
(
    id                   int auto_increment
        primary key,
    name                 varchar(100)                        not null,
    variable_id          int unsigned                        not null,
    updated_at           timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at           timestamp default CURRENT_TIMESTAMP not null,
    deleted_at           timestamp                           null,
    number_of_treatments int unsigned                        not null,
    constraint ct_side_effects_variable_id_uindex
        unique (variable_id),
    constraint seName
        unique (name),
    constraint ct_side_effects_variables_id_fk
        foreign key (variable_id) references variables (id)
)
    comment 'User self-reported side effect names' charset = utf8;

create table if not exists ct_symptoms
(
    id                   int auto_increment
        primary key,
    name                 varchar(100)                        not null,
    variable_id          int unsigned                        not null,
    updated_at           timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at           timestamp default CURRENT_TIMESTAMP not null,
    deleted_at           timestamp                           null,
    number_of_conditions int unsigned                        not null,
    constraint ct_symptoms_variable_id_uindex
        unique (variable_id),
    constraint symName
        unique (name),
    constraint ct_symptoms_variables_id_fk
        foreign key (variable_id) references variables (id)
)
    comment 'User self-reported symptoms' charset = utf8;

create table if not exists ct_condition_symptom
(
    id                    int auto_increment
        primary key,
    condition_variable_id int unsigned                        not null,
    condition_id          int                                 not null,
    symptom_variable_id   int unsigned                        not null,
    symptom_id            int                                 not null,
    votes                 int                                 not null,
    extreme               int                                 null,
    severe                int                                 null,
    moderate              int                                 null,
    mild                  int                                 null,
    minimal               int                                 null,
    no_symptoms           int                                 null,
    updated_at            timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at            timestamp                           null,
    created_at            timestamp default CURRENT_TIMESTAMP not null,
    constraint ct_condition_symptom_condition_uindex
        unique (condition_variable_id, symptom_variable_id),
    constraint ct_condition_symptom_variable_id_uindex
        unique (symptom_variable_id, condition_variable_id),
    constraint ct_condition_symptom_conditions_fk
        foreign key (condition_id) references ct_conditions (id),
    constraint ct_condition_symptom_symptoms_fk
        foreign key (symptom_id) references ct_symptoms (id),
    constraint ct_condition_symptom_variables_condition_fk
        foreign key (condition_variable_id) references variables (id),
    constraint ct_condition_symptom_variables_symptom_fk
        foreign key (symptom_variable_id) references variables (id)
)
    comment 'User self-reported conditions and related symptoms' charset = utf8;

create table if not exists ct_treatments
(
    id                     int auto_increment
        primary key,
    name                   varchar(100)                        not null,
    variable_id            int unsigned                        not null,
    updated_at             timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at             timestamp default CURRENT_TIMESTAMP not null,
    deleted_at             timestamp                           null,
    number_of_conditions   int unsigned                        null,
    number_of_side_effects int unsigned                        not null,
    constraint treName
        unique (name),
    constraint ct_treatments_variables_id_fk
        foreign key (variable_id) references variables (id)
)
    comment 'User self-reported treatments' charset = utf8;

create table if not exists ct_condition_treatment
(
    id                    int auto_increment
        primary key,
    condition_id          int                                 not null,
    treatment_id          int                                 not null,
    condition_variable_id int unsigned                        null,
    treatment_variable_id int unsigned                        not null,
    major_improvement     int       default 0                 not null,
    moderate_improvement  int       default 0                 not null,
    no_effect             int       default 0                 not null,
    worse                 int       default 0                 not null,
    much_worse            int       default 0                 not null,
    popularity            int       default 0                 not null,
    average_effect        int       default 0                 not null,
    updated_at            timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at            timestamp default CURRENT_TIMESTAMP not null,
    deleted_at            timestamp                           null,
    constraint treatment_id_condition_id_uindex
        unique (treatment_id, condition_id),
    constraint treatment_variable_id_condition_variable_id_uindex
        unique (treatment_variable_id, condition_variable_id),
    constraint ct_condition_treatment_conditions_id_fk
        foreign key (condition_id) references ct_conditions (id),
    constraint ct_condition_treatment_ct_treatments_fk
        foreign key (treatment_id) references ct_treatments (id),
    constraint ct_condition_treatment_variables_id_fk
        foreign key (treatment_variable_id) references variables (id),
    constraint ct_condition_treatment_variables_id_fk_2
        foreign key (condition_variable_id) references variables (id)
)
    comment 'Conditions and related treatments' charset = utf8;

create table if not exists ct_treatment_side_effect
(
    id                      int auto_increment
        primary key,
    treatment_variable_id   int unsigned                        not null,
    side_effect_variable_id int unsigned                        not null,
    treatment_id            int                                 not null,
    side_effect_id          int                                 not null,
    votes_percent           int                                 not null,
    updated_at              timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at              timestamp default CURRENT_TIMESTAMP not null,
    deleted_at              timestamp                           null,
    constraint treatment_id_side_effect_id_uindex
        unique (treatment_id, side_effect_id),
    constraint treatment_variable_id_side_effect_variable_id_uindex
        unique (treatment_variable_id, side_effect_variable_id),
    constraint side_effect_variables_id_fk
        foreign key (side_effect_variable_id) references variables (id),
    constraint treatment_side_effect_side_effects_id_fk
        foreign key (side_effect_id) references ct_side_effects (id),
    constraint treatment_side_effect_treatments_id_fk
        foreign key (treatment_id) references ct_treatments (id),
    constraint treatment_variables_id_fk
        foreign key (treatment_variable_id) references variables (id)
)
    comment 'User self-reported treatments and side-effects' charset = utf8;

create table if not exists ctg_conditions
(
    id            int           null,
    nct_id        varchar(4369) null,
    name          varchar(4369) null,
    downcase_name varchar(4369) null,
    variable_id   int unsigned  null,
    constraint ctg_conditions_variable_id_uindex
        unique (variable_id),
    constraint ctg_conditions_variables_id_fk
        foreign key (variable_id) references variables (id)
)
    comment 'Conditions from clinicaltrials.gov';

create table if not exists ctg_interventions
(
    id                int           null,
    nct_id            varchar(4369) null,
    intervention_type varchar(4369) null,
    name              varchar(4369) null,
    description       text          null,
    variable_id       int unsigned  null,
    constraint ctg_interventions_variable_id_uindex
        unique (variable_id),
    constraint ctg_interventions_variables_id_fk
        foreign key (variable_id) references variables (id)
)
    comment 'Interventions from clinicaltrials.gov';

create table if not exists third_party_correlations
(
    cause_id                                                     int unsigned                        not null comment 'variable ID of the cause variable for which the user desires correlations',
    effect_id                                                    int unsigned                        not null comment 'variable ID of the effect variable for which the user desires correlations',
    qm_score                                                     double                              null comment 'QM Score',
    forward_pearson_correlation_coefficient                      float(10, 4)                        null comment 'Pearson correlation coefficient between cause and effect measurements',
    value_predicting_high_outcome                                double                              null comment 'cause value that predicts an above average effect value (in default unit for cause variable)',
    value_predicting_low_outcome                                 double                              null comment 'cause value that predicts a below average effect value (in default unit for cause variable)',
    predicts_high_effect_change                                  int(5)                              null comment 'The percent change in the outcome typically seen when the predictor value is closer to the predictsHighEffect value. ',
    predicts_low_effect_change                                   int(5)                              null comment 'The percent change in the outcome from average typically seen when the predictor value is closer to the predictsHighEffect value.',
    average_effect                                               double                              null,
    average_effect_following_high_cause                          double                              null,
    average_effect_following_low_cause                           double                              null,
    average_daily_low_cause                                      double                              null,
    average_daily_high_cause                                     double                              null,
    average_forward_pearson_correlation_over_onset_delays        float                               null,
    average_reverse_pearson_correlation_over_onset_delays        float                               null,
    cause_changes                                                int                                 null comment 'Cause changes',
    cause_filling_value                                          double                              null,
    cause_number_of_processed_daily_measurements                 int                                 not null,
    cause_number_of_raw_measurements                             int                                 not null,
    cause_unit_id                                                int                                 null comment 'Unit ID of Cause',
    confidence_interval                                          double                              null comment 'A margin of error around the effect size.  Wider confidence intervals reflect greater uncertainty about the Ã¢â‚¬Å“trueÃ¢â‚¬Â value of the correlation.',
    critical_t_value                                             double                              null comment 'Value of t from lookup table which t must exceed for significance.',
    created_at                                                   timestamp default CURRENT_TIMESTAMP not null,
    data_source_name                                             varchar(255)                        null,
    deleted_at                                                   timestamp                           null,
    duration_of_action                                           int                                 null comment 'Time over which the cause is expected to produce a perceivable effect following the onset delay',
    effect_changes                                               int                                 null comment 'Effect changes',
    effect_filling_value                                         double                              null,
    effect_number_of_processed_daily_measurements                int                                 not null,
    effect_number_of_raw_measurements                            int                                 not null,
    error                                                        text                                null,
    forward_spearman_correlation_coefficient                     float                               null,
    id                                                           int auto_increment
        primary key,
    number_of_days                                               int                                 not null,
    number_of_pairs                                              int                                 null comment 'Number of points that went into the correlation calculation',
    onset_delay                                                  int                                 null comment 'User estimated or default time after cause measurement before a perceivable effect is observed',
    onset_delay_with_strongest_pearson_correlation               int(10)                             null,
    optimal_pearson_product                                      double                              null comment 'Optimal Pearson Product',
    p_value                                                      double                              null comment 'The measure of statistical significance. A value less than 0.05 means that a correlation is statistically significant or consistent enough that it is unlikely to be a coincidence.',
    pearson_correlation_with_no_onset_delay                      float                               null,
    predictive_pearson_correlation_coefficient                   double                              null comment 'Predictive Pearson Correlation Coefficient',
    reverse_pearson_correlation_coefficient                      double                              null comment 'Correlation when cause and effect are reversed. For any causal relationship, the forward correlation should exceed the reverse correlation',
    statistical_significance                                     float(10, 4)                        null comment 'A function of the effect size and sample size',
    strongest_pearson_correlation_coefficient                    float                               null,
    t_value                                                      double                              null comment 'Function of correlation and number of samples.',
    updated_at                                                   timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    user_id                                                      bigint unsigned                     not null,
    grouped_cause_value_closest_to_value_predicting_low_outcome  double                              null,
    grouped_cause_value_closest_to_value_predicting_high_outcome double                              null,
    client_id                                                    varchar(255)                        null,
    published_at                                                 timestamp                           null,
    wp_post_id                                                   int                                 null,
    status                                                       varchar(25)                         null,
    cause_variable_category_id                                   tinyint unsigned                    null,
    effect_variable_category_id                                  tinyint unsigned                    null,
    interesting_variable_category_pair                           tinyint(1)                          null,
    cause_variable_id                                            int unsigned                        null,
    effect_variable_id                                           int unsigned                        null,
    constraint user_cause_effect
        unique (user_id, cause_id, effect_id),
    constraint third_party_correlations_cause_variable_category_id_fk
        foreign key (cause_variable_category_id) references variable_categories (id),
    constraint third_party_correlations_cause_variables_id_fk
        foreign key (cause_id) references variables (id),
    constraint third_party_correlations_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint third_party_correlations_effect_variable_category_id_fk
        foreign key (effect_variable_category_id) references variable_categories (id),
    constraint third_party_correlations_effect_variables_id_fk
        foreign key (effect_id) references variables (id)
)
    comment 'Stores Calculated Correlation Coefficients' charset = utf8;

create index cause
    on third_party_correlations (cause_id);

create index effect
    on third_party_correlations (effect_id);

create table if not exists variable_outcome_category
(
    id                          int auto_increment
        primary key,
    variable_id                 int unsigned                        not null,
    variable_category_id        tinyint unsigned                    not null,
    number_of_outcome_variables int unsigned                        not null,
    created_at                  timestamp default CURRENT_TIMESTAMP not null,
    updated_at                  timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at                  timestamp                           null,
    constraint variable_id_variable_category_id_uindex
        unique (variable_id, variable_category_id),
    constraint variable_outcome_category_variable_categories_id_fk
        foreign key (variable_category_id) references variable_categories (id),
    constraint variable_outcome_category_variables_id_fk
        foreign key (variable_id) references variables (id)
);

create table if not exists variable_predictor_category
(
    id                            int auto_increment
        primary key,
    variable_id                   int unsigned                        not null,
    variable_category_id          tinyint unsigned                    not null,
    number_of_predictor_variables int unsigned                        not null,
    created_at                    timestamp default CURRENT_TIMESTAMP not null,
    updated_at                    timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at                    timestamp                           null,
    constraint variable_id_variable_category_id_uindex
        unique (variable_id, variable_category_id),
    constraint variable_predictor_category_variable_categories_id_fk
        foreign key (variable_category_id) references variable_categories (id),
    constraint variable_predictor_category_variables_id_fk
        foreign key (variable_id) references variables (id)
);

create index IDX_cat_unit_public_name
    on variables (variable_category_id, default_unit_id, name, number_of_user_variables, id);

create index fk_variableDefaultUnit
    on variables (default_unit_id);

create index public_deleted_at_synonyms_number_of_user_variables_index
    on variables (deleted_at, synonyms, number_of_user_variables);

create index variables_analysis_ended_at_index
    on variables (analysis_ended_at);

create index variables_public_name_number_of_user_variables_index
    on variables (name, number_of_user_variables);

create table if not exists wp_actionscheduler_actions
(
    action_id            bigint unsigned auto_increment
        primary key,
    hook                 varchar(191)                                  not null,
    status               varchar(20)                                   not null,
    scheduled_date_gmt   datetime        default '0000-00-00 00:00:00' not null,
    scheduled_date_local datetime        default '0000-00-00 00:00:00' not null,
    args                 varchar(191)                                  null,
    schedule             longtext                                      null,
    group_id             bigint unsigned default 0                     not null,
    attempts             int             default 0                     not null,
    last_attempt_gmt     datetime        default '0000-00-00 00:00:00' not null,
    last_attempt_local   datetime        default '0000-00-00 00:00:00' not null,
    claim_id             bigint unsigned default 0                     not null
)
    collate = utf8mb4_unicode_520_ci;

create index args
    on wp_actionscheduler_actions (args);

create index claim_id
    on wp_actionscheduler_actions (claim_id);

create index group_id
    on wp_actionscheduler_actions (group_id);

create index hook
    on wp_actionscheduler_actions (hook);

create index last_attempt_gmt
    on wp_actionscheduler_actions (last_attempt_gmt);

create index scheduled_date_gmt
    on wp_actionscheduler_actions (scheduled_date_gmt);

create index status
    on wp_actionscheduler_actions (status);

create table if not exists wp_actionscheduler_claims
(
    claim_id         bigint unsigned auto_increment
        primary key,
    date_created_gmt datetime default '0000-00-00 00:00:00' not null
)
    collate = utf8mb4_unicode_520_ci;

create index date_created_gmt
    on wp_actionscheduler_claims (date_created_gmt);

create table if not exists wp_actionscheduler_groups
(
    group_id bigint unsigned auto_increment
        primary key,
    slug     varchar(255) not null
)
    collate = utf8mb4_unicode_520_ci;

create index slug
    on wp_actionscheduler_groups (slug(191));

create table if not exists wp_actionscheduler_logs
(
    log_id         bigint unsigned auto_increment
        primary key,
    action_id      bigint unsigned                        not null,
    message        text                                   not null,
    log_date_gmt   datetime default '0000-00-00 00:00:00' not null,
    log_date_local datetime default '0000-00-00 00:00:00' not null
)
    collate = utf8mb4_unicode_520_ci;

create index action_id
    on wp_actionscheduler_logs (action_id);

create index log_date_gmt
    on wp_actionscheduler_logs (log_date_gmt);

create table if not exists wp_arete_wp_smiley_settings
(
    id    mediumint(11) auto_increment,
    type  varchar(255) default '' not null,
    value varchar(255) default '' not null,
    constraint id
        unique (id)
)
    collate = utf8mb4_unicode_520_ci;

create table if not exists wp_arete_wp_smileys
(
    id    mediumint(11) auto_increment,
    image varchar(255) default '' not null,
    name  varchar(255) default '' not null,
    front varchar(255) default '' not null,
    constraint id
        unique (id)
)
    collate = utf8mb4_unicode_520_ci;

create table if not exists wp_arete_wp_smileys_manage
(
    id        mediumint(11) auto_increment,
    smiley_id varchar(255) default '' not null,
    user_id   varchar(255) default '' not null,
    post_id   varchar(255) default '' not null,
    ip        varchar(255) default '' not null,
    timestamp varchar(11)  default '' not null,
    constraint id
        unique (id)
)
    collate = utf8mb4_unicode_520_ci;

create table if not exists wp_as3cf_items
(
    id                   bigint auto_increment
        primary key,
    provider             varchar(18)          not null,
    region               varchar(255)         not null,
    bucket               varchar(255)         not null,
    path                 varchar(1024)        not null,
    original_path        varchar(1024)        not null,
    is_private           tinyint(1) default 0 not null,
    source_type          varchar(18)          not null,
    source_id            bigint               not null,
    source_path          varchar(1024)        not null,
    original_source_path varchar(1024)        not null,
    extra_info           longtext             null,
    constraint uidx_original_path
        unique (original_path(190), id),
    constraint uidx_original_source_path
        unique (original_source_path(190), id),
    constraint uidx_path
        unique (path(190), id),
    constraint uidx_provider_bucket
        unique (provider, bucket(190), id),
    constraint uidx_source
        unique (source_type, source_id),
    constraint uidx_source_path
        unique (source_path(190), id)
)
    charset = utf8;

create table if not exists wp_blog_versions
(
    blog_id      bigint      default 0                     not null,
    db_version   varchar(20) default ''                    not null,
    last_updated datetime    default '0000-00-00 00:00:00' not null,
    updated_at   timestamp   default CURRENT_TIMESTAMP     not null on update CURRENT_TIMESTAMP,
    created_at   timestamp   default CURRENT_TIMESTAMP     not null,
    deleted_at   timestamp                                 null,
    client_id    varchar(255)                              null,
    primary key (blog_id)
)
    charset = utf8;

create index db_version
    on wp_blog_versions (db_version);

create table if not exists wp_blogs
(
    blog_id      bigint auto_increment
        primary key,
    site_id      bigint       default 0                     not null,
    domain       varchar(200) default ''                    not null,
    path         varchar(100) default ''                    not null,
    registered   datetime     default '0000-00-00 00:00:00' not null,
    last_updated datetime     default '0000-00-00 00:00:00' not null,
    public       tinyint(2)   default 1                     not null,
    archived     tinyint(2)   default 0                     not null,
    mature       tinyint(2)   default 0                     not null,
    spam         tinyint(2)   default 0                     not null,
    deleted      tinyint(2)   default 0                     not null,
    lang_id      int          default 0                     not null,
    updated_at   timestamp    default CURRENT_TIMESTAMP     not null on update CURRENT_TIMESTAMP,
    created_at   timestamp    default CURRENT_TIMESTAMP     not null,
    deleted_at   timestamp                                  null,
    client_id    varchar(255)                               null
)
    charset = utf8;

create index domain
    on wp_blogs (domain(50), path(5));

create index lang_id
    on wp_blogs (lang_id);

create table if not exists wp_bp_groups
(
    id           bigint auto_increment
        primary key,
    creator_id   bigint                                not null,
    name         varchar(100)                          not null,
    slug         varchar(200)                          not null,
    description  longtext                              not null,
    status       varchar(10) default 'public'          not null,
    parent_id    bigint      default 0                 not null,
    enable_forum tinyint(1)  default 1                 not null,
    date_created datetime                              not null,
    updated_at   timestamp   default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at   timestamp   default CURRENT_TIMESTAMP not null,
    deleted_at   timestamp                             null,
    client_id    varchar(255)                          null
)
    charset = utf8;

create index creator_id
    on wp_bp_groups (creator_id);

create index parent_id
    on wp_bp_groups (parent_id);

create index status
    on wp_bp_groups (status);

create table if not exists wp_bp_groups_groupmeta
(
    id         bigint auto_increment
        primary key,
    group_id   bigint                              not null,
    meta_key   varchar(255)                        null,
    meta_value longtext                            null,
    updated_at timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    deleted_at timestamp                           null,
    client_id  varchar(255)                        null
)
    charset = utf8;

create index group_id
    on wp_bp_groups_groupmeta (group_id);

create index meta_key
    on wp_bp_groups_groupmeta (meta_key(191));

create table if not exists wp_bp_invitations
(
    id                bigint auto_increment
        primary key,
    user_id           bigint                       not null,
    inviter_id        bigint                       not null,
    invitee_email     varchar(100)                 null,
    class             varchar(120)                 not null,
    item_id           bigint                       not null,
    secondary_item_id bigint                       null,
    type              varchar(12) default 'invite' not null,
    content           longtext                     null,
    date_modified     datetime                     not null,
    invite_sent       tinyint(1)  default 0        not null,
    accepted          tinyint(1)  default 0        not null
)
    charset = utf8;

create index accepted
    on wp_bp_invitations (accepted);

create index class
    on wp_bp_invitations (class);

create index invite_sent
    on wp_bp_invitations (invite_sent);

create index invitee_email
    on wp_bp_invitations (invitee_email);

create index inviter_id
    on wp_bp_invitations (inviter_id);

create index item_id
    on wp_bp_invitations (item_id);

create index secondary_item_id
    on wp_bp_invitations (secondary_item_id);

create index type
    on wp_bp_invitations (type);

create index user_id
    on wp_bp_invitations (user_id);

create table if not exists wp_bp_messages_messages
(
    id         bigint auto_increment
        primary key,
    thread_id  bigint                              not null,
    sender_id  bigint                              not null,
    subject    varchar(200)                        not null,
    message    longtext                            not null,
    date_sent  datetime                            not null,
    updated_at timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    deleted_at timestamp                           null,
    client_id  varchar(255)                        null
)
    charset = utf8;

create index sender_id
    on wp_bp_messages_messages (sender_id);

create index thread_id
    on wp_bp_messages_messages (thread_id);

create table if not exists wp_bp_messages_meta
(
    id         bigint auto_increment
        primary key,
    message_id bigint                              not null,
    meta_key   varchar(255)                        null,
    meta_value longtext                            null,
    updated_at timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    deleted_at timestamp                           null,
    client_id  varchar(255)                        null
)
    charset = utf8;

create index message_id
    on wp_bp_messages_meta (message_id);

create index meta_key
    on wp_bp_messages_meta (meta_key(191));

create table if not exists wp_bp_messages_notices
(
    id         bigint auto_increment
        primary key,
    subject    varchar(200)                         not null,
    message    longtext                             not null,
    date_sent  datetime                             not null,
    is_active  tinyint(1) default 0                 not null,
    updated_at timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at timestamp  default CURRENT_TIMESTAMP not null,
    deleted_at timestamp                            null,
    client_id  varchar(255)                         null
)
    charset = utf8;

create index is_active
    on wp_bp_messages_notices (is_active);

create table if not exists wp_bp_notifications_meta
(
    id              bigint auto_increment
        primary key,
    notification_id bigint                              not null,
    meta_key        varchar(255)                        null,
    meta_value      longtext                            null,
    updated_at      timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at      timestamp default CURRENT_TIMESTAMP not null,
    deleted_at      timestamp                           null,
    client_id       varchar(255)                        null
)
    charset = utf8;

create index meta_key
    on wp_bp_notifications_meta (meta_key(191));

create index notification_id
    on wp_bp_notifications_meta (notification_id);

create table if not exists wp_bp_user_blogs_blogmeta
(
    id         bigint auto_increment
        primary key,
    blog_id    bigint                              not null,
    meta_key   varchar(255)                        null,
    meta_value longtext                            null,
    updated_at timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    deleted_at timestamp                           null,
    client_id  varchar(255)                        null
)
    charset = utf8;

create index blog_id
    on wp_bp_user_blogs_blogmeta (blog_id);

create index meta_key
    on wp_bp_user_blogs_blogmeta (meta_key(191));

create table if not exists wp_bp_xprofile_fields
(
    id                bigint unsigned auto_increment
        primary key,
    group_id          bigint unsigned                       not null,
    parent_id         bigint unsigned                       not null,
    type              varchar(150)                          not null,
    name              varchar(150)                          not null,
    description       longtext                              not null,
    is_required       tinyint(1)  default 0                 not null,
    is_default_option tinyint(1)  default 0                 not null,
    field_order       bigint      default 0                 not null,
    option_order      bigint      default 0                 not null,
    order_by          varchar(15) default ''                not null,
    can_delete        tinyint(1)  default 1                 not null,
    updated_at        timestamp   default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at        timestamp   default CURRENT_TIMESTAMP not null,
    deleted_at        timestamp                             null,
    client_id         varchar(255)                          null
)
    charset = utf8;

create index can_delete
    on wp_bp_xprofile_fields (can_delete);

create index field_order
    on wp_bp_xprofile_fields (field_order);

create index group_id
    on wp_bp_xprofile_fields (group_id);

create index is_required
    on wp_bp_xprofile_fields (is_required);

create index parent_id
    on wp_bp_xprofile_fields (parent_id);

create table if not exists wp_bp_xprofile_groups
(
    id          bigint unsigned auto_increment
        primary key,
    name        varchar(150)                        not null,
    description mediumtext                          not null,
    group_order bigint    default 0                 not null,
    can_delete  tinyint(1)                          not null,
    updated_at  timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at  timestamp default CURRENT_TIMESTAMP not null,
    deleted_at  timestamp                           null,
    client_id   varchar(255)                        null
)
    charset = utf8;

create index can_delete
    on wp_bp_xprofile_groups (can_delete);

create table if not exists wp_bp_xprofile_meta
(
    id          bigint auto_increment
        primary key,
    object_id   bigint                              not null,
    object_type varchar(150)                        not null,
    meta_key    varchar(255)                        null,
    meta_value  longtext                            null,
    updated_at  timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at  timestamp default CURRENT_TIMESTAMP not null,
    deleted_at  timestamp                           null,
    client_id   varchar(255)                        null
)
    charset = utf8;

create index meta_key
    on wp_bp_xprofile_meta (meta_key(191));

create index object_id
    on wp_bp_xprofile_meta (object_id);

create table if not exists wp_da_r_reactions
(
    ID         mediumint auto_increment
        primary key,
    label      varchar(36) default 'Reaction'        not null,
    file_name  varchar(36) default ''                not null,
    created_at timestamp   default CURRENT_TIMESTAMP not null,
    color      varchar(36) default '#006699'         not null,
    active     smallint(1) default 1                 not null,
    sort_order smallint(3) default 0                 not null
)
    collate = utf8mb4_unicode_520_ci;

create table if not exists wp_da_r_votes
(
    ID            mediumint auto_increment
        primary key,
    resource_id   mediumint                           null,
    resource_type varchar(20)                         null,
    emotion_id    mediumint                           not null,
    user_id       varchar(32)                         null,
    user_token    varchar(32)                         null,
    user_ip       varchar(16)                         null,
    created_at    timestamp default CURRENT_TIMESTAMP not null
)
    collate = utf8mb4_unicode_520_ci;

create index da_reaction_resource_id
    on wp_da_r_votes (resource_id);

create index da_reaction_resource_type
    on wp_da_r_votes (resource_type);

create index da_reaction_user_id
    on wp_da_r_votes (user_id);

create table if not exists wp_effecto
(
    id        mediumint auto_increment
        primary key,
    userID    mediumint   not null,
    apiKey    varchar(60) not null,
    shortname varchar(60) not null,
    postID    mediumint   not null,
    embedCode text        null
)
    charset = utf8;

create table if not exists wp_mailchimp_carts
(
    id         varchar(255) not null,
    email      varchar(100) not null,
    user_id    int          null,
    cart       text         not null,
    created_at datetime     not null,
    primary key (email)
)
    collate = utf8mb4_unicode_520_ci;

create table if not exists wp_mailchimp_jobs
(
    id         bigint auto_increment
        primary key,
    obj_id     text     null,
    job        text     not null,
    created_at datetime not null
)
    collate = utf8mb4_unicode_520_ci;

create table if not exists wp_options
(
    option_id    bigint unsigned auto_increment comment 'Unique number assigned to each row of the table.'
        primary key,
    option_name  varchar(191)                        null comment 'An identifying key for the piece of data.',
    option_value longtext                            null comment 'The actual piece of data. The data is often <a href="https://deliciousbrains.com/wp-migrate-db-pro/doc/serialized-data/">serialized</a> so must be handled carefully.',
    autoload     varchar(20)                         null comment 'Controls if the option is automatically loaded by the function <a href="http://codex.wordpress.org/Function_Reference/wp_load_alloptions" target="_blank">wp_load_alloptions()</a> (puts options into object cache on each page load).',
    updated_at   timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at   timestamp default CURRENT_TIMESTAMP not null,
    deleted_at   timestamp                           null,
    client_id    varchar(255)                        null,
    constraint option_name
        unique (option_name)
)
    comment 'The options table is the place where all of the site’s configuration is stored, including data about the theme, active plugins, widgets, and temporary cached data. It is typically where other plugins and themes store their settings.'
    charset = utf8;

create table if not exists wp_posts
(
    ID                    bigint unsigned auto_increment comment 'Unique number assigned to each post.'
        primary key,
    post_author           bigint unsigned                         null comment 'The user ID who created it.',
    post_date             timestamp default CURRENT_TIMESTAMP     not null on update CURRENT_TIMESTAMP comment 'Time and date of creation.',
    post_date_gmt         timestamp default '0000-00-00 00:00:00' not null comment 'GMT time and date of creation. The GMT time and date is stored so there is no dependency on a site’s timezone in the future.',
    post_content          longtext                                null comment 'Holds all the content for the post, including HTML, shortcodes and other content.',
    post_title            text                                    null comment 'Title of the post.',
    post_excerpt          text                                    null comment 'Custom intro or short version of the content.',
    post_status           varchar(20)                             null comment 'Status of the post, e.g. ‘draft’, ‘pending’, ‘private’, ‘publish’. Also a great WordPress <a href="https://poststatus.com/" target="_blank">news site</a>.',
    comment_status        varchar(20)                             null comment 'If comments are allowed.',
    ping_status           varchar(20)                             null comment 'If the post allows <a href="http://codex.wordpress.org/Introduction_to_Blogging#Pingbacks" target="_blank">ping and trackbacks</a>.',
    post_password         varchar(255)                            null comment 'Optional password used to view the post.',
    post_name             varchar(200)                            null comment 'URL friendly slug of the post title.',
    to_ping               text                                    null comment 'A list of URLs WordPress should send pingbacks to when updated.',
    pinged                text                                    null comment 'A list of URLs WordPress has sent pingbacks to when updated.',
    post_modified         timestamp default '0000-00-00 00:00:00' not null comment 'Time and date of last modification.',
    post_modified_gmt     timestamp default '0000-00-00 00:00:00' not null comment 'GMT time and date of last modification.',
    post_content_filtered longtext                                null comment 'Used by plugins to cache a version of post_content typically passed through the ‘the_content’ filter. Not used by WordPress core itself.',
    post_parent           bigint unsigned                         null comment 'Used to create a relationship between this post and another when this post is a revision, attachment or another type.',
    guid                  varchar(255)                            null comment 'Global Unique Identifier, the permanent URL to the post, not the permalink version.',
    menu_order            int                                     null comment 'Holds the display number for pages and other non-post types.',
    post_type             varchar(20)                             null comment 'The content type identifier.',
    post_mime_type        varchar(100)                            null comment 'Only used for attachments, the MIME type of the uploaded file.',
    comment_count         bigint                                  null comment 'Total number of comments, pingbacks and trackbacks.',
    updated_at            timestamp default CURRENT_TIMESTAMP     not null on update CURRENT_TIMESTAMP,
    created_at            timestamp default CURRENT_TIMESTAMP     not null,
    deleted_at            timestamp                               null,
    client_id             varchar(255)                            null,
    record_size_in_kb     int                                     null
)
    comment 'The posts table is arguably the most important table in the WordPress database. Its name sometimes throws people who believe it purely contains their blog posts. However, albeit badly named, it is an extremely powerful table that stores various types of content including posts, pages, menu items, media attachments and any custom post types that a site uses.'
    charset = utf8;

alter table aggregate_correlations
    add constraint aggregate_correlations_wp_posts_ID_fk
        foreign key (wp_post_id) references wp_posts (ID)
            on update cascade on delete set null;

create table if not exists connectors
(
    id                           int(11) unsigned auto_increment comment 'Connector ID number'
        primary key,
    name                         varchar(30)                          not null comment 'Lowercase system name for the data source',
    display_name                 varchar(30)                          not null comment 'Pretty display name for the data source',
    image                        varchar(2083)                        not null comment 'URL to the image of the connector logo',
    get_it_url                   varchar(2083)                        null comment 'URL to a site where one can get this device or application',
    short_description            text                                 not null comment 'Short description of the service (such as the categories it tracks)',
    long_description             longtext                             not null comment 'Longer paragraph description of the data provider',
    enabled                      tinyint(1) default 1                 not null comment 'Set to 1 if the connector should be returned when listing connectors',
    oauth                        tinyint(1) default 0                 not null comment 'Set to 1 if the connector uses OAuth authentication as opposed to username/password',
    qm_client                    tinyint(1) default 0                 null comment 'Whether its a connector or one of our clients',
    created_at                   timestamp  default CURRENT_TIMESTAMP not null,
    updated_at                   timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    client_id                    varchar(80)                          null,
    deleted_at                   timestamp                            null,
    wp_post_id                   bigint unsigned                      null,
    number_of_connections        int unsigned                         null comment 'Number of Connections for this Connector.
                [Formula:
                    update connectors
                        left join (
                            select count(id) as total, connector_id
                            from connections
                            group by connector_id
                        )
                        as grouped on connectors.id = grouped.connector_id
                    set connectors.number_of_connections = count(grouped.total)
                ]
                ',
    number_of_connector_imports  int unsigned                         null comment 'Number of Connector Imports for this Connector.
                [Formula:
                    update connectors
                        left join (
                            select count(id) as total, connector_id
                            from connector_imports
                            group by connector_id
                        )
                        as grouped on connectors.id = grouped.connector_id
                    set connectors.number_of_connector_imports = count(grouped.total)
                ]
                ',
    number_of_connector_requests int unsigned                         null comment 'Number of Connector Requests for this Connector.
                [Formula:
                    update connectors
                        left join (
                            select count(id) as total, connector_id
                            from connector_requests
                            group by connector_id
                        )
                        as grouped on connectors.id = grouped.connector_id
                    set connectors.number_of_connector_requests = count(grouped.total)
                ]
                ',
    number_of_measurements       int unsigned                         null comment 'Number of Measurements for this Connector.
                    [Formula: update connectors
                        left join (
                            select count(id) as total, connector_id
                            from measurements
                            group by connector_id
                        )
                        as grouped on connectors.id = grouped.connector_id
                    set connectors.number_of_measurements = count(grouped.total)]',
    is_public                    tinyint(1)                           null,
    sort_order                   int                                  not null,
    slug                         varchar(200)                         null comment 'The slug is the part of a URL that identifies a page in human-readable keywords.',
    available_outside_us         int        default 1                 not null,
    constraint connectors_slug_uindex
        unique (slug),
    constraint connectors_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint connectors_wp_posts_ID_fk
        foreign key (wp_post_id) references wp_posts (ID)
)
    comment 'A connector pulls data from other data providers using their API or a screenscraper. Returns a list of all available connectors and information about them such as their id, name, whether the user has provided access, logo url, connection instructions, and the update history.'
    charset = utf8;

create table if not exists spreadsheet_importers
(
    id                            int(11) unsigned auto_increment comment 'Spreadsheet Importer ID number'
        primary key,
    name                          varchar(30)                          not null comment 'Lowercase system name for the data source',
    display_name                  varchar(30)                          not null comment 'Pretty display name for the data source',
    image                         varchar(2083)                        not null comment 'URL to the image of the Spreadsheet Importer logo',
    get_it_url                    varchar(2083)                        null comment 'URL to a site where one can get this device or application',
    short_description             text                                 not null comment 'Short description of the service (such as the categories it tracks)',
    long_description              longtext                             not null comment 'Longer paragraph description of the data provider',
    enabled                       tinyint(1) default 1                 not null comment 'Set to 1 if the Spreadsheet Importer should be returned when listing Spreadsheet Importers',
    created_at                    timestamp  default CURRENT_TIMESTAMP not null,
    updated_at                    timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    client_id                     varchar(80)                          null,
    deleted_at                    timestamp                            null,
    wp_post_id                    bigint unsigned                      null,
    number_of_measurement_imports int unsigned                         null comment 'Number of Spreadsheet Import Requests for this Spreadsheet Importer.
                            [Formula:
                                update spreadsheet_importers
                                    left join (
                                        select count(id) as total, spreadsheet_importer_id
                                        from spreadsheet_importer_requests
                                        group by spreadsheet_importer_id
                                    )
                                    as grouped on spreadsheet_importers.id = grouped.spreadsheet_importer_id
                                set spreadsheet_importers.number_of_spreadsheet_importer_requests = count(grouped.total)
                            ]
                            ',
    number_of_measurements        int unsigned                         null comment 'Number of Measurements for this Spreadsheet Importer.
                                [Formula: update spreadsheet_importers
                                    left join (
                                        select count(id) as total, spreadsheet_importer_id
                                        from measurements
                                        group by spreadsheet_importer_id
                                    )
                                    as grouped on spreadsheet_importers.id = grouped.spreadsheet_importer_id
                                set spreadsheet_importers.number_of_measurements = count(grouped.total)]',
    sort_order                    int                                  not null,
    constraint spreadsheet_importers_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint spreadsheet_importers_wp_posts_ID_fk
        foreign key (wp_post_id) references wp_posts (ID)
)
    charset = utf8;

alter table variable_categories
    add constraint variable_categories_wp_posts_ID_fk
        foreign key (wp_post_id) references wp_posts (ID);

alter table variables
    add constraint variables_wp_posts_ID_fk
        foreign key (wp_post_id) references wp_posts (ID)
            on update cascade on delete set null;

create table if not exists wp_postmeta
(
    meta_id    bigint unsigned auto_increment comment 'Unique number assigned to each row of the table.'
        primary key,
    post_id    bigint unsigned                     null comment 'The ID of the post the data relates to.',
    meta_key   varchar(255)                        null comment 'An identifying key for the piece of data.',
    meta_value longtext                            null comment 'The actual piece of data.',
    updated_at timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    deleted_at timestamp                           null,
    client_id  varchar(255)                        null,
    constraint wp_postmeta_wp_posts_ID_fk
        foreign key (post_id) references wp_posts (ID)
            on update cascade on delete cascade
)
    comment 'This table holds any extra information about individual posts. It is a vertical table using key/value pairs to store its data, a technique WordPress employs on a number of tables throughout the database allowing WordPress core, plugins and themes to store unlimited data.'
    charset = utf8;

create index meta_key
    on wp_postmeta (meta_key(191));

create index post_id
    on wp_postmeta (post_id);

create index idx_wp_posts_post_author_post_modified_deleted_at
    on wp_posts (post_author, post_modified, deleted_at);

create index post_author
    on wp_posts (post_author);

create index post_name
    on wp_posts (post_name(191));

create index post_parent
    on wp_posts (post_parent);

create index type_status_date
    on wp_posts (post_type, post_status, post_date, ID);

create index wp_posts_post_modified_index
    on wp_posts (post_modified);

create table if not exists wp_registration_log
(
    ID              bigint auto_increment
        primary key,
    email           varchar(255) default ''                    not null,
    IP              varchar(30)  default ''                    not null,
    blog_id         bigint       default 0                     not null,
    date_registered datetime     default '0000-00-00 00:00:00' not null,
    updated_at      timestamp    default CURRENT_TIMESTAMP     not null on update CURRENT_TIMESTAMP,
    created_at      timestamp    default CURRENT_TIMESTAMP     not null,
    deleted_at      timestamp                                  null,
    client_id       varchar(255)                               null
)
    charset = utf8;

create index IP
    on wp_registration_log (IP);

create table if not exists wp_signups
(
    signup_id      bigint auto_increment
        primary key,
    domain         varchar(200) default ''                    not null,
    path           varchar(100) default ''                    not null,
    title          longtext                                   not null,
    user_login     varchar(60)  default ''                    not null,
    user_email     varchar(100) default ''                    not null,
    registered     datetime     default '0000-00-00 00:00:00' not null,
    activated      datetime     default '0000-00-00 00:00:00' not null,
    active         tinyint(1)   default 0                     not null,
    activation_key varchar(50)  default ''                    not null,
    meta           longtext                                   null,
    updated_at     timestamp    default CURRENT_TIMESTAMP     not null on update CURRENT_TIMESTAMP,
    created_at     timestamp    default CURRENT_TIMESTAMP     not null,
    deleted_at     timestamp                                  null,
    client_id      varchar(255)                               null
)
    charset = utf8;

create index activation_key
    on wp_signups (activation_key);

create index domain_path
    on wp_signups (domain(140), path(51));

create index user_email
    on wp_signups (user_email);

create index user_login_email
    on wp_signups (user_login, user_email);

create table if not exists wp_simply_static_pages
(
    id                  bigint unsigned auto_increment
        primary key,
    found_on_id         bigint unsigned                        null,
    url                 varchar(255)                           not null,
    redirect_url        text                                   null,
    file_path           varchar(255)                           null,
    http_status_code    smallint(20)                           null,
    content_type        varchar(255)                           null,
    content_hash        binary(20)                             null,
    error_message       varchar(255)                           null,
    status_message      varchar(255)                           null,
    last_checked_at     datetime default '0000-00-00 00:00:00' not null,
    last_modified_at    datetime default '0000-00-00 00:00:00' not null,
    last_transferred_at datetime default '0000-00-00 00:00:00' not null,
    created_at          datetime default '0000-00-00 00:00:00' not null,
    updated_at          datetime default '0000-00-00 00:00:00' not null
)
    collate = utf8mb4_unicode_520_ci;

create index last_checked_at
    on wp_simply_static_pages (last_checked_at);

create index last_modified_at
    on wp_simply_static_pages (last_modified_at);

create index last_transferred_at
    on wp_simply_static_pages (last_transferred_at);

create index url
    on wp_simply_static_pages (url);

create table if not exists wp_sirv_images
(
    id               int unsigned auto_increment
        primary key,
    attachment_id    int                                 not null,
    wp_path          varchar(255)                        null,
    size             int(10)                             null,
    sirvpath         varchar(255)                        null,
    sirv_image_url   varchar(255)                        null,
    sirv_folder      varchar(255)                        null,
    timestamp        timestamp                           null,
    timestamp_synced timestamp                           null,
    updated_at       timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at       timestamp default CURRENT_TIMESTAMP not null,
    deleted_at       timestamp                           null,
    client_id        varchar(255)                        null,
    constraint attachment_id
        unique (attachment_id)
)
    charset = utf8;

create table if not exists wp_sirv_shortcodes
(
    id                int unsigned auto_increment
        primary key,
    width             varchar(20)  default 'auto'            null,
    thumbs_height     varchar(20)                            null,
    gallery_styles    varchar(255)                           null,
    align             varchar(30)  default ''                null,
    profile           varchar(100) default 'false'           null,
    link_image        varchar(10)  default 'false'           null,
    show_caption      varchar(10)  default 'false'           null,
    use_as_gallery    varchar(10)  default 'false'           null,
    use_sirv_zoom     varchar(10)  default 'false'           null,
    images            text                                   null,
    shortcode_options text                                   not null,
    updated_at        timestamp    default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at        timestamp    default CURRENT_TIMESTAMP not null,
    deleted_at        timestamp                              null,
    client_id         varchar(255)                           null
)
    charset = utf8;

create table if not exists wp_site
(
    id         bigint auto_increment
        primary key,
    domain     varchar(200) default ''                not null,
    path       varchar(100) default ''                not null,
    updated_at timestamp    default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at timestamp    default CURRENT_TIMESTAMP not null,
    deleted_at timestamp                              null,
    client_id  varchar(255)                           null
)
    charset = utf8;

create index domain
    on wp_site (domain(140), path(51));

create table if not exists wp_sitemeta
(
    meta_id    bigint auto_increment
        primary key,
    site_id    bigint    default 0                 not null,
    meta_key   varchar(255)                        null,
    meta_value longtext                            null,
    updated_at timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    deleted_at timestamp                           null,
    client_id  varchar(255)                        null
)
    charset = utf8;

create index meta_key
    on wp_sitemeta (meta_key(191));

create index site_id
    on wp_sitemeta (site_id);

create table if not exists wp_termmeta
(
    meta_id    bigint unsigned auto_increment
        primary key,
    term_id    bigint unsigned default 0                 not null,
    meta_key   varchar(255)                              null,
    meta_value longtext                                  null,
    updated_at timestamp       default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at timestamp       default CURRENT_TIMESTAMP not null,
    deleted_at timestamp                                 null,
    client_id  varchar(255)                              null
)
    charset = utf8;

create index meta_key
    on wp_termmeta (meta_key(191));

create index term_id
    on wp_termmeta (term_id);

create table if not exists wp_terms
(
    term_id    bigint unsigned auto_increment comment 'Unique number assigned to each term.'
        primary key,
    name       varchar(200)                        null comment 'The name of the term.',
    slug       varchar(200)                        null comment 'The URL friendly slug of the name.',
    term_group bigint(10)                          null comment 'Ability for themes or plugins to group terms together to use aliases. Not populated by WordPress core itself.',
    updated_at timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    deleted_at timestamp                           null,
    client_id  varchar(255)                        null
)
    comment 'Terms are items of a taxonomy used to classify objects. Taxonomy what? WordPress allows items like posts and custom post types to be classified in various ways. For example, when creating a post in WordPress, by default you can add a category and some tags to it. Both ‘Category’ and ‘Tag’ are examples of a <a href="http://codex.wordpress.org/Taxonomies" target="_blank">taxonomy</a>, basically a way to group things together.'
    charset = utf8;

create table if not exists wp_term_taxonomy
(
    term_taxonomy_id bigint unsigned auto_increment comment 'Unique number assigned to each row of the table.'
        primary key,
    term_id          bigint unsigned                     null comment 'The ID of the related term.',
    taxonomy         varchar(32)                         null comment 'The slug of the taxonomy. This can be the <a href="http://codex.wordpress.org/Taxonomies#Default_Taxonomies" target="_blank">built in taxonomies</a> or any taxonomy registered using <a href="http://codex.wordpress.org/Function_Reference/register_taxonomy" target="_blank">register_taxonomy()</a>.',
    description      longtext                            null comment 'Description of the term in this taxonomy.',
    parent           bigint unsigned                     null comment 'ID of a parent term. Used for hierarchical taxonomies like Categories.',
    count            bigint                              null comment 'Number of post objects assigned the term for this taxonomy.',
    updated_at       timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at       timestamp default CURRENT_TIMESTAMP not null,
    deleted_at       timestamp                           null,
    client_id        varchar(255)                        null,
    constraint term_id_taxonomy
        unique (term_id, taxonomy),
    constraint wp_term_taxonomy_wp_terms_term_id_fk
        foreign key (term_id) references wp_terms (term_id)
)
    comment 'Following the wp_terms example above, the terms ‘Guide’, ‘database’ and ‘mysql’ that are stored in wp_terms don’t exist yet as a ‘Category’ and as ‘Tags’ unless they are given context. Each term is assigned a taxonomy using this table.'
    charset = utf8;

create table if not exists wp_term_relationships
(
    object_id        bigint unsigned                     not null comment 'The ID of the post object.',
    term_taxonomy_id bigint unsigned                     not null comment 'The ID of the term / taxonomy pair.',
    term_order       int                                 null comment 'Allow ordering of terms for an object, not fully used.',
    updated_at       timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at       timestamp default CURRENT_TIMESTAMP not null,
    deleted_at       timestamp                           null,
    client_id        varchar(255)                        null,
    primary key (object_id, term_taxonomy_id),
    constraint wp_term_relationships_wp_posts_ID_fk
        foreign key (object_id) references wp_posts (ID)
            on update cascade on delete cascade,
    constraint wp_term_relationships_wp_term_taxonomy_term_taxonomy_id_fk
        foreign key (term_taxonomy_id) references wp_term_taxonomy (term_taxonomy_id)
)
    comment 'So far we have seen how terms and their taxonomies are stored in the database, but have yet to see how WordPress stores the critical data when it comes to using taxonomies. This post exists in wp_posts and when we actually assign the category and tags through the WordPress dashboard this is the <a href="http://en.wikipedia.org/wiki/Junction_table" target="_blank">junction table</a> that records that information. Each row defines a relationship between a post (object) in wp_posts and a term of a certain taxonomy in wp_term_taxonomy.'
    charset = utf8;

create index term_taxonomy_id
    on wp_term_relationships (term_taxonomy_id);

create index taxonomy
    on wp_term_taxonomy (taxonomy);

create index name
    on wp_terms (name(191));

create index slug
    on wp_terms (slug(191));

create table if not exists wp_users
(
    ID                                                       bigint unsigned auto_increment comment 'Unique number assigned to each user.'
        primary key,
    client_id                                                varchar(255)                         not null,
    user_login                                               varchar(60)                          null comment 'Unique username for the user.',
    user_email                                               varchar(100)                         null comment 'Email address of the user.',
    email                                                    varchar(320)                         null comment 'Needed for laravel password resets because WP user_email field will not work',
    user_pass                                                varchar(255)                         null comment 'Hash of the user’s password.',
    user_nicename                                            varchar(50)                          null comment 'Display name for the user.',
    user_url                                                 varchar(2083)                        null comment 'URL of the user, e.g. website address.',
    user_registered                                          datetime                             null comment 'Time and date the user registered.',
    user_activation_key                                      varchar(255)                         null comment 'Used for resetting passwords.',
    user_status                                              int                                  null comment 'Was used in Multisite pre WordPress 3.0 to indicate a spam user.',
    display_name                                             varchar(250)                         null comment 'Desired name to be used publicly in the site, can be user_login, user_nicename, first name or last name defined in wp_usermeta.',
    avatar_image                                             varchar(2083)                        null,
    reg_provider                                             varchar(25)                          null comment 'Registered via',
    provider_id                                              varchar(255)                         null comment 'Unique id from provider',
    provider_token                                           varchar(255)                         null comment 'Access token from provider',
    remember_token                                           varchar(100)                         null comment 'Remember me token',
    updated_at                                               timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at                                               timestamp  default CURRENT_TIMESTAMP not null,
    refresh_token                                            varchar(255)                         null comment 'Refresh token from provider',
    unsubscribed                                             tinyint(1) default 0                 null comment 'Indicates whether the use has specified that they want no emails or any form of communication. ',
    old_user                                                 tinyint(1) default 0                 null,
    stripe_active                                            tinyint(1) default 0                 null,
    stripe_id                                                varchar(255)                         null,
    stripe_subscription                                      varchar(255)                         null,
    stripe_plan                                              varchar(100)                         null,
    last_four                                                varchar(4)                           null,
    trial_ends_at                                            timestamp                            null,
    subscription_ends_at                                     timestamp                            null,
    roles                                                    varchar(255)                         null comment 'An array containing all roles possessed by the user.  This indicates whether the use has roles such as administrator, developer, patient, student, researcher or physician. ',
    time_zone_offset                                         int                                  null comment 'The time-zone offset is the difference, in minutes, between UTC and local time. Note that this means that the offset is positive if the local timezone is behind UTC (i.e. UTC−06:00 Central) and negative if it is ahead.',
    deleted_at                                               timestamp                            null,
    earliest_reminder_time                                   time       default '06:00:00'        not null comment 'Earliest time of day at which reminders should appear in HH:MM:SS format in user timezone',
    latest_reminder_time                                     time       default '22:00:00'        not null comment 'Latest time of day at which reminders should appear in HH:MM:SS format in user timezone',
    push_notifications_enabled                               tinyint(1) default 1                 null comment 'Should we send the user push notifications?',
    track_location                                           tinyint(1) default 0                 null comment 'Set to true if the user wants to track their location',
    combine_notifications                                    tinyint(1) default 0                 null comment 'Should we combine push notifications or send one for each tracking reminder notification?',
    send_reminder_notification_emails                        tinyint(1) default 0                 null comment 'Should we send reminder notification emails?',
    send_predictor_emails                                    tinyint(1) default 1                 null comment 'Should we send predictor emails?',
    get_preview_builds                                       tinyint(1) default 0                 null comment 'Should we send preview builds of the mobile application?',
    subscription_provider                                    enum ('stripe', 'apple', 'google')   null,
    last_sms_tracking_reminder_notification_id               bigint unsigned                      null,
    sms_notifications_enabled                                tinyint(1) default 0                 null comment 'Should we send tracking reminder notifications via tex messages?',
    phone_verification_code                                  varchar(25)                          null,
    phone_number                                             varchar(25)                          null,
    has_android_app                                          tinyint(1) default 0                 null,
    has_ios_app                                              tinyint(1) default 0                 null,
    has_chrome_extension                                     tinyint(1) default 0                 null,
    referrer_user_id                                         bigint unsigned                      null,
    address                                                  varchar(255)                         null,
    birthday                                                 varchar(255)                         null,
    country                                                  varchar(255)                         null,
    cover_photo                                              varchar(2083)                        null,
    currency                                                 varchar(255)                         null,
    first_name                                               varchar(255)                         null,
    gender                                                   varchar(255)                         null,
    language                                                 varchar(255)                         null,
    last_name                                                varchar(255)                         null,
    state                                                    varchar(255)                         null,
    tag_line                                                 varchar(255)                         null,
    verified                                                 varchar(255)                         null,
    zip_code                                                 varchar(255)                         null,
    spam                                                     tinyint(2) default 0                 not null,
    deleted                                                  tinyint(2) default 0                 not null,
    card_brand                                               varchar(255)                         null,
    card_last_four                                           varchar(4)                           null,
    last_login_at                                            timestamp                            null,
    timezone                                                 varchar(255)                         null,
    number_of_correlations                                   int                                  null,
    number_of_connections                                    int                                  null,
    number_of_tracking_reminders                             int                                  null,
    number_of_user_variables                                 int                                  null,
    number_of_raw_measurements_with_tags                     int                                  null,
    number_of_raw_measurements_with_tags_at_last_correlation int                                  null,
    number_of_votes                                          int                                  null,
    number_of_studies                                        int                                  null,
    last_correlation_at                                      timestamp                            null,
    last_email_at                                            timestamp                            null,
    last_push_at                                             timestamp                            null,
    primary_outcome_variable_id                              int unsigned                         null,
    wp_post_id                                               bigint unsigned                      null,
    analysis_ended_at                                        timestamp                            null,
    analysis_requested_at                                    timestamp                            null,
    analysis_started_at                                      timestamp                            null,
    internal_error_message                                   text                                 null,
    newest_data_at                                           timestamp                            null,
    reason_for_analysis                                      varchar(255)                         null,
    user_error_message                                       text                                 null,
    status                                                   varchar(25)                          null,
    analysis_settings_modified_at                            timestamp                            null,
    number_of_applications                                   int unsigned                         null comment 'Number of Applications for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(id) as total, user_id
                            from applications
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_applications = count(grouped.total)
                ]
                ',
    number_of_oauth_access_tokens                            int unsigned                         null comment 'Number of OAuth Access Tokens for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(access_token) as total, user_id
                            from bshaffer_oauth_access_tokens
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_oauth_access_tokens = count(grouped.total)
                ]
                ',
    number_of_oauth_authorization_codes                      int unsigned                         null comment 'Number of OAuth Authorization Codes for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(authorization_code) as total, user_id
                            from bshaffer_oauth_authorization_codes
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_oauth_authorization_codes = count(grouped.total)
                ]
                ',
    number_of_oauth_clients                                  int unsigned                         null comment 'Number of OAuth Clients for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(client_id) as total, user_id
                            from bshaffer_oauth_clients
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_oauth_clients = count(grouped.total)
                ]
                ',
    number_of_oauth_refresh_tokens                           int unsigned                         null comment 'Number of OAuth Refresh Tokens for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(refresh_token) as total, user_id
                            from bshaffer_oauth_refresh_tokens
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_oauth_refresh_tokens = count(grouped.total)
                ]
                ',
    number_of_button_clicks                                  int unsigned                         null comment 'Number of Button Clicks for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(id) as total, user_id
                            from button_clicks
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_button_clicks = count(grouped.total)
                ]
                ',
    number_of_collaborators                                  int unsigned                         null comment 'Number of Collaborators for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(id) as total, user_id
                            from collaborators
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_collaborators = count(grouped.total)
                ]
                ',
    number_of_connector_imports                              int unsigned                         null comment 'Number of Connector Imports for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(id) as total, user_id
                            from connector_imports
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_connector_imports = count(grouped.total)
                ]
                ',
    number_of_connector_requests                             int unsigned                         null comment 'Number of Connector Requests for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(id) as total, user_id
                            from connector_requests
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_connector_requests = count(grouped.total)
                ]
                ',
    number_of_measurement_exports                            int unsigned                         null comment 'Number of Measurement Exports for this User.
                    [Formula: update wp_users
                        left join (
                            select count(id) as total, user_id
                            from measurement_exports
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_measurement_exports = count(grouped.total)]',
    number_of_measurement_imports                            int unsigned                         null comment 'Number of Measurement Imports for this User.
                    [Formula: update wp_users
                        left join (
                            select count(id) as total, user_id
                            from measurement_imports
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_measurement_imports = count(grouped.total)]',
    number_of_measurements                                   int unsigned                         null comment 'Number of Measurements for this User.
                    [Formula: update wp_users
                        left join (
                            select count(id) as total, user_id
                            from measurements
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_measurements = count(grouped.total)]',
    number_of_sent_emails                                    int unsigned                         null comment 'Number of Sent Emails for this User.
                    [Formula: update wp_users
                        left join (
                            select count(id) as total, user_id
                            from sent_emails
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_sent_emails = count(grouped.total)]',
    number_of_subscriptions                                  int unsigned                         null comment 'Number of Subscriptions for this User.
                    [Formula: update wp_users
                        left join (
                            select count(id) as total, user_id
                            from subscriptions
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_subscriptions = count(grouped.total)]',
    number_of_tracking_reminder_notifications                int unsigned                         null comment 'Number of Tracking Reminder Notifications for this User.
                    [Formula: update wp_users
                        left join (
                            select count(id) as total, user_id
                            from tracking_reminder_notifications
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_tracking_reminder_notifications = count(grouped.total)]',
    number_of_user_tags                                      int unsigned                         null comment 'Number of User Tags for this User.
                    [Formula: update wp_users
                        left join (
                            select count(id) as total, user_id
                            from user_tags
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_user_tags = count(grouped.total)]',
    number_of_users_where_referrer_user                      int unsigned                         null comment 'Number of Users for this Referrer User.
                    [Formula: update wp_users
                        left join (
                            select count(ID) as total, referrer_user_id
                            from wp_users
                            group by referrer_user_id
                        )
                        as grouped on wp_users.ID = grouped.referrer_user_id
                    set wp_users.number_of_users_where_referrer_user = count(grouped.total)]',
    share_all_data                                           tinyint(1) default 0                 not null,
    deletion_reason                                          varchar(280)                         null comment 'The reason the user deleted their account.',
    password                                                 varchar(255)                         null,
    number_of_patients                                       int unsigned                         not null,
    is_public                                                tinyint(1)                           null,
    sort_order                                               int                                  not null,
    number_of_sharers                                        int unsigned                         not null comment 'Number of people sharing their data with you.',
    number_of_trustees                                       int unsigned                         not null comment 'Number of people that you are sharing your data with.',
    slug                                                     varchar(200)                         null comment 'The slug is the part of a URL that identifies a page in human-readable keywords.',
    constraint user_email
        unique (user_email),
    constraint user_login_key
        unique (user_login),
    constraint wp_users_slug_uindex
        unique (slug),
    constraint wp_users_variables_id_fk
        foreign key (primary_outcome_variable_id) references variables (id),
    constraint wp_users_wp_posts_ID_fk
        foreign key (wp_post_id) references wp_posts (ID)
            on update cascade on delete set null,
    constraint wp_users_wp_users_ID_fk
        foreign key (referrer_user_id) references wp_users (ID)
)
    comment 'WordPress’ user management is one of its strongest features and one that makes it great as an application framework. This table is the driving force behind it.'
    charset = utf8;

create table if not exists applications
(
    id                                int unsigned auto_increment
        primary key,
    organization_id                   int unsigned                         null,
    client_id                         varchar(80)                          not null,
    app_display_name                  varchar(255)                         not null,
    app_description                   varchar(255)                         null,
    long_description                  text                                 null,
    user_id                           bigint unsigned                      not null,
    icon_url                          varchar(2083)                        null,
    text_logo                         varchar(2083)                        null,
    splash_screen                     varchar(2083)                        null,
    homepage_url                      varchar(255)                         null,
    app_type                          varchar(32)                          null,
    app_design                        mediumtext                           null,
    created_at                        timestamp  default CURRENT_TIMESTAMP not null,
    updated_at                        timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at                        timestamp                            null,
    enabled                           tinyint    default 1                 not null,
    stripe_active                     tinyint    default 0                 not null,
    stripe_id                         varchar(255)                         null,
    stripe_subscription               varchar(255)                         null,
    stripe_plan                       varchar(100)                         null,
    last_four                         varchar(4)                           null,
    trial_ends_at                     timestamp                            null,
    subscription_ends_at              timestamp                            null,
    company_name                      varchar(100)                         null,
    country                           varchar(100)                         null,
    address                           varchar(255)                         null,
    state                             varchar(100)                         null,
    city                              varchar(100)                         null,
    zip                               varchar(10)                          null,
    plan_id                           int                                  null,
    exceeding_call_count              int        default 0                 not null,
    exceeding_call_charge             decimal(16, 2)                       null,
    study                             tinyint    default 0                 not null,
    billing_enabled                   tinyint    default 1                 not null,
    outcome_variable_id               int unsigned                         null,
    predictor_variable_id             int unsigned                         null,
    physician                         tinyint    default 0                 not null,
    additional_settings               text                                 null comment 'Additional non-design settings for your application.',
    app_status                        text                                 null comment 'The current build status for the iOS app, Android app, and Chrome extension.',
    build_enabled                     tinyint(1) default 0                 not null,
    wp_post_id                        bigint unsigned                      null,
    number_of_collaborators_where_app int unsigned                         null comment 'Number of Collaborators for this App.
                [Formula:
                    update applications
                        left join (
                            select count(id) as total, app_id
                            from collaborators
                            group by app_id
                        )
                        as grouped on applications.id = grouped.app_id
                    set applications.number_of_collaborators_where_app = count(grouped.total)
                ]
                ',
    is_public                         tinyint(1)                           null,
    sort_order                        int                                  not null,
    slug                              varchar(200)                         null comment 'The slug is the part of a URL that identifies a page in human-readable keywords.',
    constraint applications_client_id_unique
        unique (client_id),
    constraint applications_slug_uindex
        unique (slug),
    constraint applications_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint applications_outcome_variable_id_fk
        foreign key (outcome_variable_id) references variables (id),
    constraint applications_predictor_variable_id_fk
        foreign key (predictor_variable_id) references variables (id),
    constraint applications_user_id_fk
        foreign key (user_id) references wp_users (ID),
    constraint applications_wp_posts_ID_fk
        foreign key (wp_post_id) references wp_posts (ID)
)
    comment 'Settings for applications created by the no-code QuantiModo app builder at https://builder.quantimo.do.  '
    charset = utf8;

create table if not exists button_clicks
(
    card_id      varchar(80)                         not null,
    button_id    varchar(80)                         not null,
    client_id    varchar(80)                         not null,
    created_at   timestamp default CURRENT_TIMESTAMP not null,
    deleted_at   timestamp                           null,
    id           int auto_increment
        primary key,
    input_fields text                                null,
    intent_name  varchar(80)                         null,
    parameters   text                                null,
    updated_at   timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    user_id      bigint unsigned                     not null,
    constraint button_clicks_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint button_clicks_user_id_fk
        foreign key (user_id) references wp_users (ID)
)
    charset = utf8;

create table if not exists buttons
(
    accessibility_text     varchar(100)                        null,
    action                 varchar(20)                         null,
    additional_information varchar(20)                         null,
    client_id              varchar(80)                         not null,
    color                  varchar(20)                         null,
    confirmation_text      varchar(100)                        null,
    created_at             timestamp default CURRENT_TIMESTAMP not null,
    deleted_at             timestamp                           null,
    function_name          varchar(20)                         null,
    function_parameters    text                                null,
    html                   varchar(200)                        null,
    element_id             varchar(80)                         not null,
    image                  varchar(100)                        null,
    input_fields           text                                null,
    ion_icon               varchar(20)                         null,
    link                   varchar(100)                        null,
    state_name             varchar(20)                         null,
    state_params           text                                null,
    success_alert_body     varchar(200)                        null,
    success_alert_title    varchar(80)                         null,
    success_toast_text     varchar(80)                         null,
    text                   varchar(80)                         null,
    title                  varchar(80)                         null,
    tooltip                varchar(80)                         null,
    type                   varchar(80)                         not null,
    updated_at             timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    user_id                bigint unsigned                     not null,
    id                     int auto_increment
        primary key,
    slug                   varchar(200)                        null comment 'The slug is the part of a URL that identifies a page in human-readable keywords.',
    constraint buttons_id_uindex
        unique (id),
    constraint buttons_slug_uindex
        unique (slug),
    constraint buttons_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint buttons_user_id_fk
        foreign key (user_id) references wp_users (ID)
)
    charset = utf8;

create table if not exists cards
(
    action_sheet_buttons text                                null,
    avatar               varchar(100)                        null,
    avatar_circular      varchar(100)                        null,
    background_color     varchar(20)                         null,
    buttons              text                                null,
    client_id            varchar(80)                         not null,
    content              text                                null,
    created_at           timestamp default CURRENT_TIMESTAMP not null,
    deleted_at           timestamp                           null,
    header_title         varchar(100)                        null,
    html                 text                                null,
    html_content         text                                null,
    element_id           varchar(80)                         not null,
    image                varchar(100)                        null,
    input_fields         text                                null,
    intent_name          varchar(80)                         null,
    ion_icon             varchar(20)                         null,
    link                 varchar(2083)                       null comment 'Link field is deprecated due to ambiguity.  Please use url field instead.',
    parameters           text                                null,
    sharing_body         text                                null,
    sharing_buttons      text                                null,
    sharing_title        varchar(80)                         null,
    sub_header           varchar(80)                         null,
    sub_title            varchar(80)                         null,
    title                varchar(80)                         null,
    type                 varchar(80)                         not null,
    updated_at           timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    user_id              bigint unsigned                     not null,
    url                  varchar(2083)                       null comment 'URL to go to when the card is clicked',
    id                   int                                 not null,
    slug                 varchar(200)                        null comment 'The slug is the part of a URL that identifies a page in human-readable keywords.',
    primary key (id),
    constraint cards_slug_uindex
        unique (slug),
    constraint cards_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint cards_user_id_fk
        foreign key (user_id) references wp_users (ID)
)
    charset = utf8;

create table if not exists child_parents
(
    id             int unsigned auto_increment
        primary key,
    child_user_id  bigint unsigned                     not null comment 'The child who has granted data access to the parent. ',
    parent_user_id bigint unsigned                     not null comment 'The parent who has been granted access to the child data.',
    scopes         varchar(2000)                       not null comment 'Whether the parent has read access and/or write access to the data.',
    created_at     timestamp default CURRENT_TIMESTAMP not null,
    updated_at     timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at     timestamp                           null,
    constraint child_user_id_parent_user_id_uindex
        unique (child_user_id, parent_user_id),
    constraint child_parents_wp_users_ID_fk
        foreign key (child_user_id) references wp_users (ID),
    constraint child_parents_wp_users_ID_fk_2
        foreign key (parent_user_id) references wp_users (ID)
);

create table if not exists collaborators
(
    id         int unsigned auto_increment
        primary key,
    user_id    bigint unsigned                                          not null,
    app_id     int unsigned                                             not null,
    type       enum ('owner', 'collaborator') default 'collaborator'    not null,
    created_at timestamp                      default CURRENT_TIMESTAMP not null,
    updated_at timestamp                      default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at timestamp                                                null,
    client_id  varchar(80)                                              null,
    constraint collaborators_user_client_index
        unique (user_id, client_id),
    constraint collaborators_applications_id_fk
        foreign key (app_id) references applications (id)
            on update cascade on delete cascade,
    constraint collaborators_client_id_fk
        foreign key (client_id) references oa_clients (client_id)
            on update cascade on delete cascade,
    constraint collaborators_user_id_fk
        foreign key (user_id) references wp_users (ID)
            on update cascade on delete cascade
)
    comment 'Collaborators authorized to edit applications in the app builder' charset = utf8;

create table if not exists connections
(
    id                                int(11) unsigned auto_increment
        primary key,
    client_id                         varchar(80)                         null,
    user_id                           bigint unsigned                     not null,
    connector_id                      int(11) unsigned                    not null comment 'The id for the connector data source for which the connection is connected',
    connect_status                    varchar(32)                         not null comment 'Indicates whether a connector is currently connected to a service for a user.',
    connect_error                     text                                null comment 'Error message if there is a problem with authorizing this connection.',
    update_requested_at               timestamp                           null,
    update_status                     varchar(32)                         not null comment 'Indicates whether a connector is currently updated.',
    update_error                      text                                null comment 'Indicates if there was an error during the update.',
    last_successful_updated_at        timestamp                           null,
    created_at                        timestamp default CURRENT_TIMESTAMP not null,
    updated_at                        timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at                        timestamp                           null,
    total_measurements_in_last_update int(10)                             null,
    user_message                      varchar(255)                        null,
    latest_measurement_at             timestamp                           null,
    import_started_at                 timestamp                           null,
    import_ended_at                   timestamp                           null,
    reason_for_import                 varchar(255)                        null,
    user_error_message                text                                null,
    internal_error_message            text                                null,
    wp_post_id                        bigint unsigned                     null,
    number_of_connector_imports       int unsigned                        null comment 'Number of Connector Imports for this Connection.
                [Formula:
                    update connections
                        left join (
                            select count(id) as total, connection_id
                            from connector_imports
                            group by connection_id
                        )
                        as grouped on connections.id = grouped.connection_id
                    set connections.number_of_connector_imports = count(grouped.total)
                ]
                ',
    number_of_connector_requests      int unsigned                        null comment 'Number of Connector Requests for this Connection.
                [Formula:
                    update connections
                        left join (
                            select count(id) as total, connection_id
                            from connector_requests
                            group by connection_id
                        )
                        as grouped on connections.id = grouped.connection_id
                    set connections.number_of_connector_requests = count(grouped.total)
                ]
                ',
    credentials                       text                                null comment 'Encrypted user credentials for accessing third party data',
    imported_data_from_at             timestamp                           null comment 'Earliest data that we''ve requested from this data source ',
    imported_data_end_at              timestamp                           null comment 'Most recent data that we''ve requested from this data source ',
    number_of_measurements            int unsigned                        null comment 'Number of Measurements for this Connection.
                    [Formula: update connections
                        left join (
                            select count(id) as total, connection_id
                            from measurements
                            group by connection_id
                        )
                        as grouped on connections.id = grouped.connection_id
                    set connections.number_of_measurements = count(grouped.total)]',
    is_public                         tinyint(1)                          null,
    slug                              varchar(200)                        null comment 'The slug is the part of a URL that identifies a page in human-readable keywords.',
    meta                              text                                null comment 'Additional meta data instructions for import, such as a list of repositories the Github connector should import from. ',
    constraint UX_userId_connectorId
        unique (user_id, connector_id),
    constraint connections_slug_uindex
        unique (slug),
    constraint connections_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint connections_connectors_id_fk
        foreign key (connector_id) references connectors (id),
    constraint connections_user_id_fk
        foreign key (user_id) references wp_users (ID),
    constraint connections_wp_posts_ID_fk
        foreign key (wp_post_id) references wp_posts (ID)
)
    comment 'Connections to 3rd party data sources that we can import from for a given user.' charset = utf8;

create index IDX_status
    on connections (connect_status);

create index status
    on connections (update_status);

create index status_update_requested
    on connections (update_requested_at, update_status);

create table if not exists connector_imports
(
    id                           int(11) unsigned auto_increment
        primary key,
    client_id                    varchar(80)                                null,
    connection_id                int(11) unsigned                           null,
    connector_id                 int(11) unsigned                           not null,
    created_at                   timestamp        default CURRENT_TIMESTAMP not null,
    deleted_at                   timestamp                                  null,
    earliest_measurement_at      timestamp                                  null,
    import_ended_at              timestamp                                  null,
    import_started_at            timestamp                                  null,
    internal_error_message       text                                       null,
    latest_measurement_at        timestamp                                  null,
    number_of_measurements       int(11) unsigned default 0                 not null,
    reason_for_import            varchar(255)                               null,
    success                      tinyint(1)       default 1                 null,
    updated_at                   timestamp        default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    user_error_message           text                                       null,
    user_id                      bigint unsigned                            not null,
    additional_meta_data         json                                       null,
    number_of_connector_requests int unsigned                               null comment 'Number of Connector Requests for this Connector Import.
                [Formula:
                    update connector_imports
                        left join (
                            select count(id) as total, connector_import_id
                            from connector_requests
                            group by connector_import_id
                        )
                        as grouped on connector_imports.id = grouped.connector_import_id
                    set connector_imports.number_of_connector_requests = count(grouped.total)
                ]
                ',
    imported_data_from_at        timestamp                                  null comment 'Earliest data that we''ve requested from this data source ',
    imported_data_end_at         timestamp                                  null comment 'Most recent data that we''ve requested from this data source ',
    credentials                  text                                       null comment 'Encrypted user credentials for accessing third party data',
    connector_requests           timestamp                                  null comment 'Most recent data that we''ve requested from this data source ',
    constraint connector_imports_connection_id_created_at_uindex
        unique (connection_id, created_at),
    constraint connector_imports_connector_id_user_id_created_at_uindex
        unique (connector_id, user_id, created_at),
    constraint connector_imports_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint connector_imports_connections_id_fk
        foreign key (connection_id) references connections (id),
    constraint connector_imports_connectors_id_fk
        foreign key (connector_id) references connectors (id),
    constraint connector_imports_wp_users_ID_fk
        foreign key (user_id) references wp_users (ID)
)
    comment 'A record of attempts to import from a given data source.' charset = utf8;

create index IDX_connector_imports_user_connector
    on connector_imports (user_id, connector_id);

create table if not exists connector_requests
(
    id                    int(11) unsigned auto_increment
        primary key,
    connector_id          int(11) unsigned                    not null,
    user_id               bigint unsigned                     not null,
    connection_id         int(11) unsigned                    null,
    connector_import_id   int unsigned                        not null,
    method                varchar(10)                         not null,
    code                  int                                 not null,
    uri                   varchar(2083)                       not null,
    response_body         mediumtext                          null,
    request_body          text                                null,
    request_headers       text                                not null,
    created_at            timestamp default CURRENT_TIMESTAMP not null,
    updated_at            timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at            timestamp                           null,
    content_type          varchar(100)                        null,
    imported_data_from_at timestamp                           null comment 'Earliest data that we''ve requested from this data source ',
    constraint connector_requests_connections_id_fk
        foreign key (connection_id) references connections (id),
    constraint connector_requests_connector_imports_id_fk
        foreign key (connector_import_id) references connector_imports (id),
    constraint connector_requests_connectors_id_fk
        foreign key (connector_id) references connectors (id),
    constraint connector_requests_wp_users_ID_fk
        foreign key (user_id) references wp_users (ID)
)
    comment 'An API request made to an HTTP endpoint during import from a data source.';

create table if not exists correlations
(
    id                                                           int auto_increment
        primary key,
    user_id                                                      bigint unsigned                                                 not null,
    cause_variable_id                                            int unsigned                                                    not null,
    effect_variable_id                                           int unsigned                                                    not null,
    qm_score                                                     double                                                          null comment 'A number representative of the relative importance of the relationship based on the strength,
                    usefulness, and plausible causality.  The higher the number, the greater the perceived importance.
                    This value can be used for sorting relationships by importance.  ',
    forward_pearson_correlation_coefficient                      float(10, 4)                                                    null comment 'Pearson correlation coefficient between cause and effect measurements',
    value_predicting_high_outcome                                double                                                          null comment 'cause value that predicts an above average effect value (in default unit for cause variable)',
    value_predicting_low_outcome                                 double                                                          null comment 'cause value that predicts a below average effect value (in default unit for cause variable)',
    predicts_high_effect_change                                  int(5)                                                          null comment 'The percent change in the outcome typically seen when the predictor value is closer to the predictsHighEffect value. ',
    predicts_low_effect_change                                   int(5)                                                          not null comment 'The percent change in the outcome from average typically seen when the predictor value is closer to the predictsHighEffect value.',
    average_effect                                               double                                                          not null comment 'The average effect variable measurement value used in analysis in the common unit. ',
    average_effect_following_high_cause                          double                                                          not null comment 'The average effect variable measurement value following an above average cause value (in the common unit). ',
    average_effect_following_low_cause                           double                                                          not null comment 'The average effect variable measurement value following a below average cause value (in the common unit). ',
    average_daily_low_cause                                      double                                                          not null comment 'The average of below average cause values (in the common unit). ',
    average_daily_high_cause                                     double                                                          not null comment 'The average of above average cause values (in the common unit). ',
    average_forward_pearson_correlation_over_onset_delays        float                                                           null,
    average_reverse_pearson_correlation_over_onset_delays        float                                                           null,
    cause_changes                                                int                                                             not null comment 'The number of times the cause measurement value was different from the one preceding it. ',
    cause_filling_value                                          double                                                          null,
    cause_number_of_processed_daily_measurements                 int                                                             not null,
    cause_number_of_raw_measurements                             int                                                             not null,
    cause_unit_id                                                smallint unsigned                                               null comment 'Unit ID of Cause',
    confidence_interval                                          double                                                          not null comment 'A margin of error around the effect size.  Wider confidence intervals reflect greater uncertainty about the true value of the correlation.',
    critical_t_value                                             double                                                          not null comment 'Value of t from lookup table which t must exceed for significance.',
    created_at                                                   timestamp default CURRENT_TIMESTAMP                             not null,
    data_source_name                                             varchar(255)                                                    null,
    deleted_at                                                   timestamp                                                       null,
    duration_of_action                                           int                                                             not null comment 'Time over which the cause is expected to produce a perceivable effect following the onset delay',
    effect_changes                                               int                                                             not null comment 'The number of times the effect measurement value was different from the one preceding it. ',
    effect_filling_value                                         double                                                          null,
    effect_number_of_processed_daily_measurements                int                                                             not null,
    effect_number_of_raw_measurements                            int                                                             not null,
    forward_spearman_correlation_coefficient                     float                                                           not null comment 'Predictive spearman correlation of the lagged pair data. While the Pearson correlation assesses linear relationships, the Spearman correlation assesses monotonic relationships (whether linear or not).',
    number_of_days                                               int                                                             not null,
    number_of_pairs                                              int                                                             not null comment 'Number of points that went into the correlation calculation',
    onset_delay                                                  int                                                             not null comment 'User estimated or default time after cause measurement before a perceivable effect is observed',
    onset_delay_with_strongest_pearson_correlation               int(10)                                                         null,
    optimal_pearson_product                                      double                                                          null comment 'Optimal Pearson Product',
    p_value                                                      double                                                          null comment 'The measure of statistical significance. A value less than 0.05 means that a correlation is statistically significant or consistent enough that it is unlikely to be a coincidence.',
    pearson_correlation_with_no_onset_delay                      float                                                           null,
    predictive_pearson_correlation_coefficient                   double                                                          null comment 'Predictive Pearson Correlation Coefficient',
    reverse_pearson_correlation_coefficient                      double                                                          null comment 'Correlation when cause and effect are reversed. For any causal relationship, the forward correlation should exceed the reverse correlation',
    statistical_significance                                     float(10, 4)                                                    null comment 'A function of the effect size and sample size',
    strongest_pearson_correlation_coefficient                    float                                                           null,
    t_value                                                      double                                                          null comment 'Function of correlation and number of samples.',
    updated_at                                                   timestamp default CURRENT_TIMESTAMP                             not null on update CURRENT_TIMESTAMP,
    grouped_cause_value_closest_to_value_predicting_low_outcome  double                                                          not null comment 'A realistic daily value (not a fraction from averaging) that typically precedes below average outcome values. ',
    grouped_cause_value_closest_to_value_predicting_high_outcome double                                                          not null comment 'A realistic daily value (not a fraction from averaging) that typically precedes below average outcome values. ',
    client_id                                                    varchar(255)                                                    null,
    published_at                                                 timestamp                                                       null,
    wp_post_id                                                   bigint unsigned                                                 null,
    status                                                       varchar(25)                                                     null,
    cause_variable_category_id                                   tinyint unsigned                                                not null,
    effect_variable_category_id                                  tinyint unsigned                                                not null,
    interesting_variable_category_pair                           tinyint(1)                                                      not null comment 'True if the combination of cause and effect variable categories are generally interesting.  For instance, treatment cause variables paired with symptom effect variables are interesting. ',
    newest_data_at                                               timestamp                                                       not null comment 'The time the source data was last updated. This indicated whether the analysis is stale and should be performed again. ',
    analysis_requested_at                                        timestamp                                                       null,
    reason_for_analysis                                          varchar(255)                                                    not null comment 'The reason analysis was requested.',
    analysis_started_at                                          timestamp                                                       not null,
    analysis_ended_at                                            timestamp                                                       null,
    user_error_message                                           text                                                            null,
    internal_error_message                                       text                                                            null,
    cause_user_variable_id                                       int unsigned                                                    not null,
    effect_user_variable_id                                      int unsigned                                                    not null,
    latest_measurement_start_at                                  timestamp                                                       null,
    earliest_measurement_start_at                                timestamp                                                       null,
    cause_baseline_average_per_day                               float                                                           not null comment 'Predictor Average at Baseline (The average low non-treatment value of the predictor per day)',
    cause_baseline_average_per_duration_of_action                float                                                           not null comment 'Predictor Average at Baseline (The average low non-treatment value of the predictor per duration of action)',
    cause_treatment_average_per_day                              float                                                           not null comment 'Predictor Average During Treatment (The average high value of the predictor per day considered to be the treatment dosage)',
    cause_treatment_average_per_duration_of_action               float                                                           not null comment 'Predictor Average During Treatment (The average high value of the predictor per duration of action considered to be the treatment dosage)',
    effect_baseline_average                                      float                                                           null comment 'Outcome Average at Baseline (The normal value for the outcome seen without treatment during the previous duration of action time span)',
    effect_baseline_relative_standard_deviation                  float                                                           not null comment 'Outcome Average at Baseline (The average value seen for the outcome without treatment during the previous duration of action time span)',
    effect_baseline_standard_deviation                           float                                                           null comment 'Outcome Relative Standard Deviation at Baseline (How much the outcome value normally fluctuates without treatment during the previous duration of action time span)',
    effect_follow_up_average                                     float                                                           not null comment 'Outcome Average at Follow-Up (The average value seen for the outcome during the duration of action following the onset delay of the treatment)',
    effect_follow_up_percent_change_from_baseline                float                                                           not null comment 'Outcome Average at Follow-Up (The average value seen for the outcome during the duration of action following the onset delay of the treatment)',
    z_score                                                      float                                                           null comment 'The absolute value of the change over duration of action following the onset delay of treatment divided by the baseline outcome relative standard deviation. A.K.A The number of standard deviations from the mean. A zScore > 2 means pValue < 0.05 and is typically considered statistically significant.',
    experiment_end_at                                            timestamp                                                       not null comment 'The latest data used in the analysis. ',
    experiment_start_at                                          timestamp                                                       not null comment 'The earliest data used in the analysis. ',
    aggregate_correlation_id                                     int                                                             null,
    aggregated_at                                                timestamp                                                       null,
    usefulness_vote                                              int                                                             null comment 'The opinion of the data owner on whether or not knowledge of this relationship is useful.
                        -1 corresponds to a down vote. 1 corresponds to an up vote. 0 corresponds to removal of a
                        previous vote.  null corresponds to never having voted before.',
    causality_vote                                               int                                                             null comment 'The opinion of the data owner on whether or not there is a plausible mechanism of action
                        by which the predictor variable could influence the outcome variable.',
    deletion_reason                                              varchar(280)                                                    null comment 'The reason the variable was deleted.',
    record_size_in_kb                                            int                                                             null,
    correlations_over_durations                                  text                                                            not null comment 'Pearson correlations calculated with various duration of action lengths. This can be used to compare short and long term effects. ',
    correlations_over_delays                                     text                                                            not null comment 'Pearson correlations calculated with various onset delay lags used to identify reversed causality or asses the significant of a correlation with a given lag parameters. ',
    is_public                                                    tinyint(1)                                                      null,
    sort_order                                                   int                                                             not null,
    boring                                                       tinyint(1)                                                      null comment 'The relationship is boring if it is obvious, the predictor is not controllable, the outcome is not a goal, the relationship could not be causal, or the confidence is low. ',
    outcome_is_goal                                              tinyint(1)                                                      null comment 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  The foods you eat are not generally an objective end in themselves. ',
    predictor_is_controllable                                    tinyint(1)                                                      null comment 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  Symptom severity is not directly controllable. ',
    plausibly_causal                                             tinyint(1)                                                      null comment 'The effect of aspirin on headaches is plausibly causal. The effect of aspirin on precipitation does not have a plausible causal relationship. ',
    obvious                                                      tinyint(1)                                                      null comment 'The effect of aspirin on headaches is obvious. The effect of aspirin on productivity is not obvious. ',
    number_of_up_votes                                           int                                                             not null comment 'Number of people who feel this relationship is plausible and useful. ',
    number_of_down_votes                                         int                                                             not null comment 'Number of people who feel this relationship is implausible or not useful. ',
    strength_level                                               enum ('VERY STRONG', 'STRONG', 'MODERATE', 'WEAK', 'VERY WEAK') not null comment 'Strength level describes magnitude of the change in outcome observed following changes in the predictor. ',
    confidence_level                                             enum ('HIGH', 'MEDIUM', 'LOW')                                  not null comment 'Describes the confidence that the strength level will remain consist in the future.  The more data there is, the lesser the chance that the findings are a spurious correlation. ',
    relationship                                                 enum ('POSITIVE', 'NEGATIVE', 'NONE')                           not null comment 'If higher predictor values generally precede HIGHER outcome values, the relationship is considered POSITIVE.  If higher predictor values generally precede LOWER outcome values, the relationship is considered NEGATIVE. ',
    slug                                                         varchar(200)                                                    null comment 'The slug is the part of a URL that identifies a page in human-readable keywords.',
    constraint correlations_pk
        unique (user_id, cause_variable_id, effect_variable_id),
    constraint correlations_slug_uindex
        unique (slug),
    constraint correlations_user_id_cause_variable_id_effect_variable_id_uindex
        unique (user_id, cause_variable_id, effect_variable_id),
    constraint correlations_aggregate_correlations_id_fk
        foreign key (aggregate_correlation_id) references aggregate_correlations (id)
            on update cascade on delete cascade,
    constraint correlations_cause_unit_id_fk
        foreign key (cause_unit_id) references units (id),
    constraint correlations_cause_variable_category_id_fk
        foreign key (cause_variable_category_id) references variable_categories (id),
    constraint correlations_cause_variable_id_fk
        foreign key (cause_variable_id) references variables (id)
            on delete cascade,
    constraint correlations_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint correlations_effect_variable_category_id_fk
        foreign key (effect_variable_category_id) references variable_categories (id),
    constraint correlations_effect_variable_id_fk
        foreign key (effect_variable_id) references variables (id),
    constraint correlations_user_id_fk
        foreign key (user_id) references wp_users (ID),
    constraint correlations_wp_posts_ID_fk
        foreign key (wp_post_id) references wp_posts (ID)
            on update cascade on delete set null
)
    comment 'Examination of the relationship between predictor and outcome variables.  This includes the potential optimal values for a given variable. '
    charset = utf8;

create table if not exists correlation_causality_votes
(
    id                       int(11) unsigned auto_increment
        primary key,
    cause_variable_id        int(11) unsigned                    not null,
    effect_variable_id       int(11) unsigned                    not null,
    correlation_id           int                                 null,
    aggregate_correlation_id int                                 null,
    user_id                  bigint unsigned                     not null,
    vote                     int                                 not null comment 'The opinion of the data owner on whether or not there is a plausible
                                mechanism of action by which the predictor variable could influence the outcome variable.',
    created_at               timestamp default CURRENT_TIMESTAMP not null,
    updated_at               timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at               timestamp                           null,
    client_id                varchar(80) charset utf8            null,
    is_public                tinyint(1)                          null,
    constraint correlation_causality_votes_user_cause_effect_uindex
        unique (user_id, cause_variable_id, effect_variable_id),
    constraint correlation_causality_votes_cause_variables_id_fk
        foreign key (cause_variable_id) references variables (id),
    constraint correlation_causality_votes_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint correlation_causality_votes_correlations_id_fk
        foreign key (correlation_id) references correlations (id),
    constraint correlation_causality_votes_effect_variables_id_fk
        foreign key (effect_variable_id) references variables (id),
    constraint correlation_causality_votes_wp_users_ID_fk
        foreign key (user_id) references wp_users (ID)
)
    comment 'The opinion of the data owner on whether or not there is a plausible mechanism of action by which the predictor variable could influence the outcome variable.';

create index correlation_causality_votes_aggregate_correlations_id_fk
    on correlation_causality_votes (aggregate_correlation_id);

create table if not exists correlation_usefulness_votes
(
    id                       int(11) unsigned auto_increment
        primary key,
    cause_variable_id        int(11) unsigned                    not null,
    effect_variable_id       int(11) unsigned                    not null,
    correlation_id           int                                 null,
    aggregate_correlation_id int                                 null,
    user_id                  bigint unsigned                     not null,
    vote                     int                                 not null comment 'The opinion of the data owner on whether or not knowledge of this
                    relationship is useful in helping them improve an outcome of interest.
                    -1 corresponds to a down vote. 1 corresponds to an up vote. 0 corresponds to removal of a
                    previous vote.  null corresponds to never having voted before.',
    created_at               timestamp default CURRENT_TIMESTAMP not null,
    updated_at               timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at               timestamp                           null,
    client_id                varchar(80) charset utf8            null,
    is_public                tinyint(1)                          null,
    constraint correlation_usefulness_votes_user_cause_effect_uindex
        unique (user_id, cause_variable_id, effect_variable_id),
    constraint correlation_usefulness_votes_cause_variables_id_fk
        foreign key (cause_variable_id) references variables (id),
    constraint correlation_usefulness_votes_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint correlation_usefulness_votes_correlations_id_fk
        foreign key (correlation_id) references correlations (id),
    constraint correlation_usefulness_votes_effect_variables_id_fk
        foreign key (effect_variable_id) references variables (id),
    constraint correlation_usefulness_votes_wp_users_ID_fk
        foreign key (user_id) references wp_users (ID)
)
    comment 'The opinion of the data owner on whether or not knowledge of this relationship is useful in helping them improve an outcome of interest. -1 corresponds to a down vote. 1 corresponds to an up vote. 0 corresponds to removal of a previous vote.  null corresponds to never having voted before.';

create index correlation_usefulness_votes_aggregate_correlations_id_fk
    on correlation_usefulness_votes (aggregate_correlation_id);

create index correlations_analysis_started_at_index
    on correlations (analysis_started_at);

create index correlations_deleted_at_analysis_ended_at_index
    on correlations (deleted_at, analysis_ended_at);

create index correlations_deleted_at_z_score_index
    on correlations (deleted_at, z_score);

create index correlations_updated_at_index
    on correlations (updated_at);

create index correlations_user_id_deleted_at_qm_score_index
    on correlations (user_id, deleted_at, qm_score);

create index user_id_cause_variable_id_deleted_at_qm_score_index
    on correlations (user_id, cause_variable_id, deleted_at, qm_score);

create index user_id_effect_variable_id_deleted_at_qm_score_index
    on correlations (user_id, effect_variable_id, deleted_at, qm_score);

create table if not exists credentials
(
    user_id      bigint unsigned                       not null,
    connector_id int(11) unsigned                      not null comment 'Connector id',
    attr_key     varchar(16)                           not null comment 'Attribute name such as token, userid, username, or password',
    attr_value   varbinary(3000)                       not null comment 'Encrypted value for the attribute specified',
    status       varchar(32) default 'UPDATED'         null,
    message      mediumtext                            null,
    expires_at   timestamp                             null,
    created_at   timestamp   default CURRENT_TIMESTAMP not null,
    updated_at   timestamp   default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at   timestamp                             null,
    client_id    varchar(255)                          null,
    primary key (user_id, connector_id, attr_key),
    constraint credentials_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint credentials_user_id_fk
        foreign key (user_id) references wp_users (ID)
)
    charset = utf8;

create index IDX_status_expires_connector
    on credentials (connector_id, expires_at, status);

create table if not exists device_tokens
(
    device_token                                      varchar(255)                        not null,
    created_at                                        timestamp default CURRENT_TIMESTAMP not null,
    updated_at                                        timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at                                        timestamp                           null,
    user_id                                           bigint unsigned                     not null,
    number_of_waiting_tracking_reminder_notifications int unsigned                        null comment 'Number of notifications waiting in the reminder inbox',
    last_notified_at                                  timestamp                           null,
    platform                                          varchar(255)                        not null,
    number_of_new_tracking_reminder_notifications     int unsigned                        null comment 'Number of notifications that have come due since last notification',
    number_of_notifications_last_sent                 int unsigned                        null comment 'Number of notifications that were sent at last_notified_at batch',
    error_message                                     varchar(255)                        null,
    last_checked_at                                   timestamp                           null,
    received_at                                       timestamp                           null,
    server_ip                                         varchar(255)                        null,
    server_hostname                                   varchar(255)                        null,
    client_id                                         varchar(255)                        null,
    primary key (device_token),
    constraint device_tokens_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint device_tokens_user_id_fk
        foreign key (user_id) references wp_users (ID)
)
    charset = utf8;

create index index_user_id
    on device_tokens (user_id);

create table if not exists measurement_exports
(
    id            int(10) auto_increment
        primary key,
    user_id       bigint unsigned                                      not null,
    client_id     varchar(255)                                         null,
    status        varchar(32)                                          not null comment 'Status of Measurement Export',
    type          enum ('user', 'app')       default 'user'            not null comment 'Whether user''s measurement export request or app users',
    output_type   enum ('csv', 'xls', 'pdf') default 'csv'             not null comment 'Output type of export file',
    error_message varchar(255)                                         null comment 'Error message',
    created_at    timestamp                  default CURRENT_TIMESTAMP not null,
    updated_at    timestamp                  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at    timestamp                                            null,
    constraint measurement_exports_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint measurement_exports_user_id_fk
        foreign key (user_id) references wp_users (ID)
)
    charset = utf8;

create table if not exists measurement_imports
(
    id                     int unsigned auto_increment
        primary key,
    user_id                bigint unsigned                       not null,
    file                   varchar(255)                          not null,
    created_at             timestamp   default CURRENT_TIMESTAMP not null,
    updated_at             timestamp   default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    status                 varchar(25) default 'WAITING'         not null,
    error_message          text                                  null,
    source_name            varchar(80)                           null comment 'Name of the application or device',
    deleted_at             timestamp                             null,
    client_id              varchar(255)                          null,
    import_started_at      timestamp                             null,
    import_ended_at        timestamp                             null,
    reason_for_import      varchar(255)                          null,
    user_error_message     varchar(255)                          null,
    internal_error_message varchar(255)                          null,
    constraint measurement_imports_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint measurement_imports_user_id_fk
        foreign key (user_id) references wp_users (ID)
)
    charset = utf8;

create table if not exists oa_access_tokens
(
    access_token varchar(40)                         not null,
    client_id    varchar(80)                         not null,
    user_id      bigint unsigned                     not null,
    expires      timestamp                           null,
    scope        varchar(2000)                       null,
    updated_at   timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at   timestamp default CURRENT_TIMESTAMP not null,
    deleted_at   timestamp                           null,
    primary key (access_token),
    constraint bshaffer_oauth_access_tokens_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint access_tokens_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint bshaffer_oauth_access_tokens_user_id_fk
        foreign key (user_id) references wp_users (ID)
)
    charset = utf8;

create table if not exists oa_authorization_codes
(
    authorization_code varchar(40)                         not null,
    client_id          varchar(80)                         not null,
    user_id            bigint unsigned                     not null,
    redirect_uri       varchar(2000)                       null,
    expires            timestamp                           null,
    scope              varchar(2000)                       null,
    updated_at         timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at         timestamp default CURRENT_TIMESTAMP not null,
    deleted_at         timestamp                           null,
    primary key (authorization_code),
    constraint bshaffer_oauth_authorization_codes_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint bshaffer_oauth_authorization_codes_user_id_fk
        foreign key (user_id) references wp_users (ID)
)
    charset = utf8;

alter table oa_clients
    add constraint bshaffer_oauth_clients_user_id_fk
        foreign key (user_id) references wp_users (ID);

create table if not exists oa_refresh_tokens
(
    refresh_token varchar(40)                         not null,
    client_id     varchar(80)                         not null,
    user_id       bigint unsigned                     not null,
    expires       timestamp                           null,
    scope         varchar(2000)                       null,
    updated_at    timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at    timestamp default CURRENT_TIMESTAMP not null,
    deleted_at    timestamp                           null,
    primary key (refresh_token),
    constraint bshaffer_oauth_refresh_tokens_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint bshaffer_oauth_refresh_tokens_user_id_fk
        foreign key (user_id) references wp_users (ID),
    constraint refresh_tokens_client_id_fk
        foreign key (client_id) references oa_clients (client_id)
)
    charset = utf8;

create table if not exists patient_physicians
(
    id                int unsigned auto_increment
        primary key,
    patient_user_id   bigint unsigned                     not null comment 'The patient who has granted data access to the physician. ',
    physician_user_id bigint unsigned                     not null comment 'The physician who has been granted access to the patients data.',
    scopes            varchar(2000)                       not null comment 'Whether the physician has read access and/or write access to the data.',
    created_at        timestamp default CURRENT_TIMESTAMP not null,
    updated_at        timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at        timestamp                           null,
    constraint patients_patient_user_id_physician_user_id_uindex
        unique (patient_user_id, physician_user_id),
    constraint patient_physicians_wp_users_ID_fk
        foreign key (patient_user_id) references wp_users (ID),
    constraint patient_physicians_wp_users_ID_fk_2
        foreign key (physician_user_id) references wp_users (ID)
);

create table if not exists permission_user
(
    id            int unsigned auto_increment
        primary key,
    permission_id int unsigned    not null,
    user_id       bigint unsigned not null,
    created_at    timestamp       null,
    updated_at    timestamp       null,
    deleted_at    timestamp       null,
    constraint permission_user_permission_id_foreign
        foreign key (permission_id) references permissions (id)
            on delete cascade,
    constraint permission_user_user_id_foreign
        foreign key (user_id) references wp_users (ID)
            on delete cascade
)
    collate = utf8_unicode_ci;

create index permission_user_permission_id_index
    on permission_user (permission_id);

create index permission_user_user_id_index
    on permission_user (user_id);

create table if not exists phrases
(
    client_id                 varchar(80)                         not null,
    created_at                timestamp default CURRENT_TIMESTAMP not null,
    deleted_at                timestamp                           null,
    id                        int auto_increment
        primary key,
    image                     varchar(100)                        null,
    text                      text                                not null,
    title                     varchar(80)                         null,
    type                      varchar(80)                         not null,
    updated_at                timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    url                       varchar(100)                        null,
    user_id                   bigint unsigned                     not null,
    responding_to_phrase_id   int                                 null,
    response_phrase_id        int                                 null,
    recipient_user_ids        text                                null,
    number_of_times_heard     int                                 null,
    interpretative_confidence double                              null,
    constraint phrases_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint phrases_user_id_fk
        foreign key (user_id) references wp_users (ID)
)
    charset = utf8;

create table if not exists purchases
(
    id                                   bigint unsigned auto_increment
        primary key,
    subscriber_user_id                   bigint unsigned                     not null,
    referrer_user_id                     bigint unsigned                     null,
    updated_at                           timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at                           timestamp default CURRENT_TIMESTAMP not null,
    subscription_provider                enum ('stripe', 'apple', 'google')  not null,
    last_four                            varchar(4)                          null,
    product_id                           varchar(100)                        not null,
    subscription_provider_transaction_id varchar(100)                        null,
    coupon                               varchar(100)                        null,
    client_id                            varchar(80)                         null,
    refunded_at                          date                                null,
    deleted_at                           timestamp                           null,
    constraint subscriber_referrer
        unique (subscriber_user_id, referrer_user_id),
    constraint purchases_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint purchases_wp_users_ID_fk
        foreign key (subscriber_user_id) references wp_users (ID)
)
    charset = utf8;

create table if not exists role_user
(
    id         int unsigned auto_increment
        primary key,
    role_id    int unsigned    not null,
    user_id    bigint unsigned not null,
    created_at timestamp       null,
    updated_at timestamp       null,
    deleted_at timestamp       null,
    constraint role_user_role_id_foreign
        foreign key (role_id) references roles (id)
            on delete cascade,
    constraint role_user_user_id_foreign
        foreign key (user_id) references wp_users (ID)
            on delete cascade
)
    collate = utf8_unicode_ci;

create index role_user_role_id_index
    on role_user (role_id);

create index role_user_user_id_index
    on role_user (user_id);

create table if not exists sent_emails
(
    id            int unsigned auto_increment
        primary key,
    user_id       bigint unsigned                     null,
    type          varchar(100)                        not null,
    created_at    timestamp default CURRENT_TIMESTAMP not null,
    updated_at    timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at    timestamp                           null,
    client_id     varchar(255)                        null,
    slug          varchar(100)                        null,
    response      varchar(140)                        null,
    content       text                                null,
    wp_post_id    bigint unsigned                     null,
    email_address varchar(255)                        null,
    subject       varchar(78)                         not null comment 'A Subject Line is the introduction that identifies the emails intent.
                    This subject line, displayed to the email user or recipient when they look at their list of messages in their inbox,
                    should tell the recipient what the message is about, what the sender wants to convey.',
    constraint sent_emails_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint sent_emails_user_id_fk
        foreign key (user_id) references wp_users (ID),
    constraint sent_emails_wp_posts_ID_fk
        foreign key (wp_post_id) references wp_posts (ID)
)
    charset = utf8;

create index sent_emails_user_id_type_index
    on sent_emails (user_id, type);

create table if not exists sharer_trustees
(
    id                int unsigned auto_increment
        primary key,
    sharer_user_id    bigint unsigned                                                         not null comment 'The sharer who has granted data access to the trustee. ',
    trustee_user_id   bigint unsigned                                                         not null comment 'The trustee who has been granted access to the sharer data.',
    scopes            varchar(2000)                                                           not null comment 'Whether the trustee has read access and/or write access to the data.',
    relationship_type enum ('patient-physician', 'student-teacher', 'child-parent', 'friend') not null,
    created_at        timestamp default CURRENT_TIMESTAMP                                     not null,
    updated_at        timestamp default CURRENT_TIMESTAMP                                     not null on update CURRENT_TIMESTAMP,
    deleted_at        timestamp                                                               null,
    constraint sharer_user_id_trustee_user_id_uindex
        unique (sharer_user_id, trustee_user_id),
    constraint sharer_trustees_wp_users_ID_fk
        foreign key (sharer_user_id) references wp_users (ID),
    constraint sharer_trustees_wp_users_ID_fk_2
        foreign key (trustee_user_id) references wp_users (ID)
);

create table if not exists studies
(
    id                            varchar(80)                           not null comment 'Study id which should match OAuth client id',
    type                          varchar(20)                           not null comment 'The type of study may be population, individual, or cohort study',
    cause_variable_id             int unsigned                          not null comment 'variable ID of the cause variable for which the user desires correlations',
    effect_variable_id            int unsigned                          not null comment 'variable ID of the effect variable for which the user desires correlations',
    user_id                       bigint unsigned                       not null,
    created_at                    timestamp   default CURRENT_TIMESTAMP not null,
    deleted_at                    timestamp                             null,
    analysis_parameters           text                                  null comment 'Additional parameters for the study such as experiment_end_time, experiment_start_time, cause_variable_filling_value, effect_variable_filling_value',
    user_study_text               longtext                              null comment 'Overrides auto-generated study text',
    user_title                    text                                  null,
    study_status                  varchar(20) default 'publish'         not null,
    comment_status                varchar(20) default 'open'            not null,
    study_password                varchar(20)                           null,
    study_images                  text                                  null comment 'Provided images will override the auto-generated images',
    updated_at                    timestamp   default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    client_id                     varchar(255)                          null,
    published_at                  timestamp                             null,
    wp_post_id                    int                                   null,
    newest_data_at                timestamp                             null,
    analysis_requested_at         timestamp                             null,
    reason_for_analysis           varchar(255)                          null,
    analysis_ended_at             timestamp                             null,
    analysis_started_at           timestamp                             null,
    internal_error_message        varchar(255)                          null,
    user_error_message            varchar(255)                          null,
    status                        varchar(25)                           null,
    analysis_settings_modified_at timestamp                             null,
    is_public                     tinyint(1)                            null,
    sort_order                    int                                   not null,
    slug                          varchar(200)                          null comment 'The slug is the part of a URL that identifies a page in human-readable keywords.',
    primary key (id),
    constraint studies_slug_uindex
        unique (slug),
    constraint user_cause_effect_type
        unique (user_id, cause_variable_id, effect_variable_id, type),
    constraint studies_cause_variable_id_variables_id_fk
        foreign key (cause_variable_id) references variables (id),
    constraint studies_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint studies_effect_variable_id_variables_id_fk
        foreign key (effect_variable_id) references variables (id),
    constraint studies_user_id_fk
        foreign key (user_id) references wp_users (ID)
)
    comment 'Stores Study Settings' charset = utf8;

create index cause_variable_id
    on studies (cause_variable_id);

create index effect_variable_id
    on studies (effect_variable_id);

create table if not exists subscriptions
(
    id            int unsigned auto_increment
        primary key,
    user_id       bigint unsigned not null,
    name          varchar(255)    not null,
    stripe_id     varchar(255)    not null,
    stripe_plan   varchar(255)    not null,
    quantity      int             not null,
    trial_ends_at timestamp       null,
    ends_at       timestamp       null,
    created_at    timestamp       null,
    updated_at    timestamp       null,
    constraint subscriptions_user_id_fk
        foreign key (user_id) references wp_users (ID)
)
    charset = utf8;

create table if not exists tracker_log
(
    id            bigint unsigned auto_increment
        primary key,
    session_id    bigint unsigned                     null,
    path_id       bigint unsigned                     null,
    query_id      bigint unsigned                     null,
    method        varchar(10)                         not null,
    route_path_id bigint unsigned                     null,
    is_ajax       tinyint(1)                          not null,
    is_secure     tinyint(1)                          not null,
    is_json       tinyint(1)                          not null,
    wants_json    tinyint(1)                          not null,
    error_id      bigint unsigned                     null,
    created_at    timestamp default CURRENT_TIMESTAMP not null,
    updated_at    timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    client_id     varchar(255)                        null,
    user_id       bigint unsigned                     not null,
    deleted_at    timestamp                           null,
    constraint tracker_log_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint tracker_log_user_id_fk
        foreign key (user_id) references wp_users (ID)
)
    charset = utf8;

create index tracker_log_created_at_index
    on tracker_log (created_at);

create index tracker_log_error_id_index
    on tracker_log (error_id);

create index tracker_log_method_index
    on tracker_log (method);

create index tracker_log_path_id_index
    on tracker_log (path_id);

create index tracker_log_query_id_index
    on tracker_log (query_id);

create index tracker_log_route_path_id_index
    on tracker_log (route_path_id);

create index tracker_log_session_id_index
    on tracker_log (session_id);

create index tracker_log_updated_at_index
    on tracker_log (updated_at);

create table if not exists tracker_sessions
(
    id         bigint unsigned auto_increment
        primary key,
    uuid       varchar(255)                        not null,
    user_id    bigint unsigned                     not null,
    device_id  bigint unsigned                     null,
    agent_id   bigint unsigned                     null,
    client_ip  varchar(255)                        not null,
    referer_id bigint unsigned                     null,
    cookie_id  bigint unsigned                     null,
    geoip_id   bigint unsigned                     null,
    is_robot   tinyint(1)                          not null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    updated_at timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at timestamp                           null,
    client_id  varchar(255)                        null,
    constraint tracker_sessions_uuid_unique
        unique (uuid),
    constraint tracker_sessions_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint tracker_sessions_user_id_fk
        foreign key (user_id) references wp_users (ID)
)
    charset = utf8;

create index tracker_sessions_agent_id_index
    on tracker_sessions (agent_id);

create index tracker_sessions_client_ip_index
    on tracker_sessions (client_ip);

create index tracker_sessions_cookie_id_index
    on tracker_sessions (cookie_id);

create index tracker_sessions_created_at_index
    on tracker_sessions (created_at);

create index tracker_sessions_device_id_index
    on tracker_sessions (device_id);

create index tracker_sessions_geoip_id_index
    on tracker_sessions (geoip_id);

create index tracker_sessions_referer_id_index
    on tracker_sessions (referer_id);

create index tracker_sessions_updated_at_index
    on tracker_sessions (updated_at);

create index tracker_sessions_user_id_index
    on tracker_sessions (user_id);

create table if not exists user_clients
(
    id                      int auto_increment
        primary key,
    client_id               varchar(80)                         null,
    created_at              timestamp default CURRENT_TIMESTAMP not null,
    deleted_at              timestamp                           null,
    earliest_measurement_at timestamp                           null comment 'Earliest measurement time for this variable and client',
    latest_measurement_at   timestamp                           null comment 'Earliest measurement time for this variable and client',
    number_of_measurements  int unsigned                        null,
    updated_at              timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    user_id                 bigint unsigned                     not null,
    constraint user
        unique (user_id, client_id),
    constraint user_clients_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint user_clients_user_id_fk
        foreign key (user_id) references wp_users (ID)
)
    comment 'Data sources for each user' charset = utf8;

create table if not exists user_variables
(
    id                                                   int unsigned auto_increment
        primary key,
    parent_id                                            int unsigned                             null comment 'ID of the parent variable if this variable has any parent',
    client_id                                            varchar(80)                              null,
    user_id                                              bigint unsigned                          not null,
    variable_id                                          int unsigned                             not null comment 'ID of variable',
    default_unit_id                                      smallint unsigned                        null comment 'ID of unit to use for this variable',
    minimum_allowed_value                                double                                   null comment 'Minimum reasonable value for this variable (uses default unit)',
    maximum_allowed_value                                double                                   null comment 'Maximum reasonable value for this variable (uses default unit)',
    filling_value                                        double       default -1                  null comment 'Value for replacing null measurements',
    join_with                                            int unsigned                             null comment 'The Variable this Variable should be joined with. If the variable is joined with some other variable then it is not shown to user in the list of variables',
    onset_delay                                          int unsigned                             null comment 'How long it takes for a measurement in this variable to take effect',
    duration_of_action                                   int unsigned                             null comment 'Estimated duration of time following the onset delay in which a stimulus produces a perceivable effect',
    variable_category_id                                 tinyint unsigned                         null comment 'ID of variable category',
    cause_only                                           tinyint(1)                               null comment 'A value of 1 indicates that this variable is generally a cause in a causal relationship.  An example of a causeOnly variable would be a variable such as Cloud Cover which would generally not be influenced by the behaviour of the user',
    filling_type                                         enum ('value', 'none')                   null comment '0 -> No filling, 1 -> Use filling-value',
    number_of_processed_daily_measurements               int                                      null comment 'Number of processed measurements',
    measurements_at_last_analysis                        int unsigned default 0                   not null comment 'Number of measurements at last analysis',
    last_unit_id                                         smallint unsigned                        null comment 'ID of last Unit',
    last_original_unit_id                                smallint unsigned                        null comment 'ID of last original Unit',
    `last_value`                                         double                                   null comment 'Last Value',
    last_original_value                                  double unsigned                          null comment 'Last original value which is stored',
    number_of_correlations                               int                                      null comment 'Number of correlations for this variable',
    status                                               varchar(25)                              null,
    standard_deviation                                   double                                   null comment 'Standard deviation',
    variance                                             double                                   null comment 'Variance',
    minimum_recorded_value                               double                                   null comment 'Minimum recorded value of this variable',
    maximum_recorded_value                               double                                   null comment 'Maximum recorded value of this variable',
    mean                                                 double                                   null comment 'Mean',
    median                                               double                                   null comment 'Median',
    most_common_original_unit_id                         int                                      null comment 'Most common Unit ID',
    most_common_value                                    double                                   null comment 'Most common value',
    number_of_unique_daily_values                        int                                      null comment 'Number of unique daily values',
    number_of_unique_values                              int                                      null comment 'Number of unique values',
    number_of_changes                                    int                                      null comment 'Number of changes',
    skewness                                             double                                   null comment 'Skewness',
    kurtosis                                             double                                   null comment 'Kurtosis',
    latitude                                             double                                   null,
    longitude                                            double                                   null,
    location                                             varchar(255)                             null,
    created_at                                           timestamp    default CURRENT_TIMESTAMP   not null,
    updated_at                                           timestamp    default CURRENT_TIMESTAMP   not null on update CURRENT_TIMESTAMP,
    outcome                                              tinyint(1)                               null comment 'Outcome variables (those with `outcome` == 1) are variables for which a human would generally want to identify the influencing factors.  These include symptoms of illness, physique, mood, cognitive performance, etc.  Generally correlation calculations are only performed on outcome variables',
    data_sources_count                                   text                                     null comment 'Array of connector or client measurement data source names as key and number of measurements as value',
    earliest_filling_time                                int                                      null comment 'Earliest filling time',
    latest_filling_time                                  int                                      null comment 'Latest filling time',
    last_processed_daily_value                           double                                   null comment 'Last value for user after daily aggregation and filling',
    outcome_of_interest                                  tinyint(1)   default 0                   null,
    predictor_of_interest                                tinyint(1)   default 0                   null,
    experiment_start_time                                timestamp                                null,
    experiment_end_time                                  timestamp                                null,
    description                                          text                                     null,
    alias                                                varchar(125)                             null,
    deleted_at                                           timestamp                                null,
    second_to_last_value                                 double                                   null,
    third_to_last_value                                  double                                   null,
    number_of_user_correlations_as_effect                int unsigned                             null comment 'Number of user correlations for which this variable is the effect variable',
    number_of_user_correlations_as_cause                 int unsigned                             null comment 'Number of user correlations for which this variable is the cause variable',
    combination_operation                                enum ('SUM', 'MEAN')                     null comment 'How to combine values of this variable (for instance, to see a summary of the values over a month) SUM or MEAN',
    informational_url                                    varchar(2000)                            null comment 'Wikipedia url',
    most_common_connector_id                             int unsigned                             null,
    valence                                              enum ('positive', 'negative', 'neutral') null,
    wikipedia_title                                      varchar(100)                             null,
    number_of_tracking_reminders                         int                                      not null,
    number_of_raw_measurements_with_tags_joins_children  int unsigned                             null,
    most_common_source_name                              varchar(255)                             null,
    optimal_value_message                                varchar(500)                             null,
    best_cause_variable_id                               int(10)                                  null,
    best_effect_variable_id                              int(10)                                  null,
    user_maximum_allowed_daily_value                     double                                   null,
    user_minimum_allowed_daily_value                     double                                   null,
    user_minimum_allowed_non_zero_value                  double                                   null,
    minimum_allowed_seconds_between_measurements         int                                      null,
    average_seconds_between_measurements                 int                                      null,
    median_seconds_between_measurements                  int                                      null,
    last_correlated_at                                   timestamp                                null,
    number_of_measurements_with_tags_at_last_correlation int                                      null,
    analysis_settings_modified_at                        timestamp                                null,
    newest_data_at                                       timestamp                                null,
    analysis_requested_at                                timestamp                                null,
    reason_for_analysis                                  varchar(255)                             null,
    analysis_started_at                                  timestamp                                null,
    analysis_ended_at                                    timestamp                                null,
    user_error_message                                   text                                     null,
    internal_error_message                               text                                     null,
    earliest_source_measurement_start_at                 timestamp                                null,
    latest_source_measurement_start_at                   timestamp                                null,
    latest_tagged_measurement_start_at                   timestamp                                null,
    earliest_tagged_measurement_start_at                 timestamp                                null,
    latest_non_tagged_measurement_start_at               timestamp                                null,
    earliest_non_tagged_measurement_start_at             timestamp                                null,
    wp_post_id                                           bigint unsigned                          null,
    number_of_soft_deleted_measurements                  int                                      null comment 'Formula: update user_variables v
                inner join (
                    select measurements.user_variable_id, count(measurements.id) as number_of_soft_deleted_measurements
                    from measurements
                    where measurements.deleted_at is not null
                    group by measurements.user_variable_id
                    ) m on v.id = m.user_variable_id
                set v.number_of_soft_deleted_measurements = m.number_of_soft_deleted_measurements
            ',
    best_user_correlation_id                             int                                      null,
    number_of_measurements                               int unsigned                             null comment 'Number of Measurements for this User Variable.
                    [Formula: update user_variables
                        left join (
                            select count(id) as total, user_variable_id
                            from measurements
                            group by user_variable_id
                        )
                        as grouped on user_variables.id = grouped.user_variable_id
                    set user_variables.number_of_measurements = count(grouped.total)]',
    number_of_tracking_reminder_notifications            int unsigned                             null comment 'Number of Tracking Reminder Notifications for this User Variable.
                    [Formula: update user_variables
                        left join (
                            select count(id) as total, user_variable_id
                            from tracking_reminder_notifications
                            group by user_variable_id
                        )
                        as grouped on user_variables.id = grouped.user_variable_id
                    set user_variables.number_of_tracking_reminder_notifications = count(grouped.total)]',
    deletion_reason                                      varchar(280)                             null comment 'The reason the variable was deleted.',
    record_size_in_kb                                    int                                      null,
    number_of_common_tags                                int                                      null comment 'Number of categories, joined variables, or ingredients for this variable that use this variables measurements to generate synthetically derived measurements. ',
    number_common_tagged_by                              int                                      null comment 'Number of children, joined variables or foods that this use has measurements for which are to be used to generate synthetic measurements for this variable. ',
    number_of_common_joined_variables                    int                                      null comment 'Joined variables are duplicate variables measuring the same thing. ',
    number_of_common_ingredients                         int                                      null comment 'Measurements for this variable can be used to synthetically generate ingredient measurements. ',
    number_of_common_foods                               int                                      null comment 'Measurements for this ingredient variable can be synthetically generate by food measurements. ',
    number_of_common_children                            int                                      null comment 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. ',
    number_of_common_parents                             int                                      null comment 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. ',
    number_of_user_tags                                  int                                      null comment 'Number of categories, joined variables, or ingredients for this variable that use this variables measurements to generate synthetically derived measurements. This only includes ones created by the user. ',
    number_user_tagged_by                                int                                      null comment 'Number of children, joined variables or foods that this use has measurements for which are to be used to generate synthetic measurements for this variable. This only includes ones created by the user. ',
    number_of_user_joined_variables                      int                                      null comment 'Joined variables are duplicate variables measuring the same thing. This only includes ones created by the user. ',
    number_of_user_ingredients                           int                                      null comment 'Measurements for this variable can be used to synthetically generate ingredient measurements. This only includes ones created by the user. ',
    number_of_user_foods                                 int                                      null comment 'Measurements for this ingredient variable can be synthetically generate by food measurements. This only includes ones created by the user. ',
    number_of_user_children                              int                                      null comment 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. This only includes ones created by the user. ',
    number_of_user_parents                               int                                      null comment 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. This only includes ones created by the user. ',
    is_public                                            tinyint(1)                               null,
    is_goal                                              tinyint(1)                               null comment 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  The foods you eat are not generally an objective end in themselves. ',
    controllable                                         tinyint(1)                               null comment 'You can control the foods you eat directly. However, symptom severity or weather is not directly controllable. ',
    boring                                               tinyint(1)                               null comment 'The user variable is boring if the owner would not be interested in its causes or effects. ',
    slug                                                 varchar(200)                             null comment 'The slug is the part of a URL that identifies a page in human-readable keywords.',
    predictor                                            tinyint(1)                               null comment 'predictor is true if the variable is a factor that could influence an outcome of interest',
    constraint user_id
        unique (user_id, variable_id),
    constraint user_variables_slug_uindex
        unique (slug),
    constraint user_variables_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint user_variables_correlations_qm_score_fk
        foreign key (best_user_correlation_id) references correlations (id)
            on delete set null,
    constraint user_variables_default_unit_id_fk
        foreign key (default_unit_id) references units (id),
    constraint user_variables_last_unit_id_fk
        foreign key (last_unit_id) references units (id),
    constraint user_variables_user_id_fk
        foreign key (user_id) references wp_users (ID),
    constraint user_variables_variable_category_id_fk
        foreign key (variable_category_id) references variable_categories (id),
    constraint user_variables_variables_id_fk
        foreign key (variable_id) references variables (id),
    constraint user_variables_wp_posts_ID_fk
        foreign key (wp_post_id) references wp_posts (ID)
            on update cascade on delete set null
)
    comment 'Variable statistics, analysis settings, and overviews with data visualizations and likely outcomes or predictors based on data for a specific individual'
    charset = utf8;

alter table correlations
    add constraint correlations_user_variables_cause_user_variable_id_fk
        foreign key (cause_user_variable_id) references user_variables (id)
            on update cascade on delete cascade;

alter table correlations
    add constraint correlations_user_variables_effect_user_variable_id_fk
        foreign key (effect_user_variable_id) references user_variables (id)
            on update cascade on delete cascade;

create table if not exists measurements
(
    id                   bigint auto_increment
        primary key,
    user_id              bigint unsigned                     not null,
    client_id            varchar(80)                         not null,
    connector_id         int unsigned                        null comment 'The id for the connector data source from which the measurement was obtained',
    variable_id          int unsigned                        not null comment 'ID of the variable for which we are creating the measurement records',
    start_time           int unsigned                        not null comment 'Start time for the measurement event in ISO 8601',
    value                double                              not null comment 'The value of the measurement after conversion to the default unit for that variable',
    unit_id              smallint unsigned                   not null comment 'The default unit for the variable',
    original_value       double                              not null comment 'Value of measurement as originally posted (before conversion to default unit)',
    original_unit_id     smallint unsigned                   not null comment 'Unit id of measurement as originally submitted',
    duration             int(10)                             null comment 'Duration of the event being measurement in seconds',
    note                 text                                null comment 'An optional note the user may include with their measurement',
    latitude             double                              null comment 'Latitude at which the measurement was taken',
    longitude            double                              null comment 'Longitude at which the measurement was taken',
    location             varchar(255)                        null comment 'location',
    created_at           timestamp default CURRENT_TIMESTAMP not null,
    updated_at           timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    error                text                                null comment 'An error message if there is a problem with the measurement',
    variable_category_id tinyint unsigned                    not null comment 'Variable category ID',
    deleted_at           datetime                            null,
    source_name          varchar(80)                         null comment 'Name of the application or device',
    user_variable_id     int unsigned                        not null,
    start_at             timestamp                           not null,
    connection_id        int(11) unsigned                    null,
    connector_import_id  int(11) unsigned                    null,
    deletion_reason      varchar(280)                        null comment 'The reason the variable was deleted.',
    original_start_at    timestamp                           not null,
    constraint measurements_pk
        unique (user_id, variable_id, start_time),
    constraint measurements_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint measurements_connections_id_fk
        foreign key (connection_id) references connections (id),
    constraint measurements_connector_imports_id_fk
        foreign key (connector_import_id) references connector_imports (id),
    constraint measurements_connectors_id_fk
        foreign key (connector_id) references connectors (id),
    constraint measurements_original_unit_id_fk
        foreign key (original_unit_id) references units (id),
    constraint measurements_unit_id_fk
        foreign key (unit_id) references units (id),
    constraint measurements_user_id_fk
        foreign key (user_id) references wp_users (ID),
    constraint measurements_user_variables_user_variable_id_fk
        foreign key (user_variable_id) references user_variables (id),
    constraint measurements_variable_category_id_fk
        foreign key (variable_category_id) references variable_categories (id),
    constraint measurements_variables_id_fk
        foreign key (variable_id) references variables (id)
)
    comment 'Measurements are quantities recorded at specific times.   Sleep minutes, apples eaten, or mood rating are examples of variables. '
    charset = utf8;

create index measurements_start_time_index
    on measurements (start_time);

create index measurements_user_id_variable_category_id_start_time_index
    on measurements (user_id, variable_category_id, start_time);

create index measurements_user_variables_variable_id_user_id_fk
    on measurements (variable_id, user_id);

create index measurements_variable_id_start_time_index
    on measurements (variable_id, start_time);

create index measurements_variable_id_value_start_time_index
    on measurements (variable_id, value, start_time);

create table if not exists tracking_reminders
(
    id                                              int unsigned auto_increment
        primary key,
    user_id                                         bigint unsigned                     not null,
    client_id                                       varchar(80)                         not null,
    variable_id                                     int unsigned                        not null comment 'Id for the variable to be tracked',
    default_value                                   double                              null comment 'Default value to use for the measurement when tracking',
    reminder_start_time                             time      default '00:00:00'        not null comment 'UTC time of day at which reminder notifications should appear in the case of daily or less frequent reminders.  The earliest UTC time at which notifications should appear in the case of intraday repeating reminders. ',
    reminder_end_time                               time                                null comment 'Latest time of day at which reminders should appear',
    reminder_sound                                  varchar(125)                        null comment 'String identifier for the sound to accompany the reminder',
    reminder_frequency                              int                                 null comment 'Number of seconds between one reminder and the next',
    pop_up                                          tinyint(1)                          null comment 'True if the reminders should appear as a popup notification',
    sms                                             tinyint(1)                          null comment 'True if the reminders should be delivered via SMS',
    email                                           tinyint(1)                          null comment 'True if the reminders should be delivered via email',
    notification_bar                                tinyint(1)                          null comment 'True if the reminders should appear in the notification bar',
    last_tracked                                    timestamp                           null,
    created_at                                      timestamp default CURRENT_TIMESTAMP not null,
    updated_at                                      timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    start_tracking_date                             date                                null comment 'Earliest date on which the user should be reminded to track in YYYY-MM-DD format',
    stop_tracking_date                              date                                null comment 'Latest date on which the user should be reminded to track  in YYYY-MM-DD format',
    instructions                                    text                                null,
    deleted_at                                      timestamp                           null,
    image_url                                       varchar(2083)                       null,
    user_variable_id                                int unsigned                        not null,
    latest_tracking_reminder_notification_notify_at timestamp                           null,
    number_of_tracking_reminder_notifications       int unsigned                        null comment 'Number of Tracking Reminder Notifications for this Tracking Reminder.
                    [Formula: update tracking_reminders
                        left join (
                            select count(id) as total, tracking_reminder_id
                            from tracking_reminder_notifications
                            group by tracking_reminder_id
                        )
                        as grouped on tracking_reminders.id = grouped.tracking_reminder_id
                    set tracking_reminders.number_of_tracking_reminder_notifications = count(grouped.total)]',
    constraint UK_user_var_time_freq
        unique (user_id, variable_id, reminder_start_time, reminder_frequency),
    constraint tracking_reminders_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint tracking_reminders_user_id_fk
        foreign key (user_id) references wp_users (ID)
            on update cascade on delete cascade,
    constraint tracking_reminders_user_variables_user_id_variable_id_fk
        foreign key (user_id, variable_id) references user_variables (user_id, variable_id),
    constraint tracking_reminders_user_variables_user_variable_id_fk
        foreign key (user_variable_id) references user_variables (id)
            on update cascade on delete cascade,
    constraint tracking_reminders_variables_id_fk
        foreign key (variable_id) references variables (id)
)
    charset = utf8;

create table if not exists tracking_reminder_notifications
(
    id                   int unsigned auto_increment
        primary key,
    tracking_reminder_id int unsigned                        not null,
    created_at           timestamp default CURRENT_TIMESTAMP not null,
    updated_at           timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at           timestamp                           null,
    user_id              bigint unsigned                     not null,
    notified_at          timestamp                           null,
    received_at          timestamp                           null,
    client_id            varchar(255)                        null,
    variable_id          int unsigned                        not null,
    notify_at            timestamp                           not null,
    user_variable_id     int unsigned                        not null,
    constraint notify_at_tracking_reminder_id_uindex
        unique (notify_at, tracking_reminder_id),
    constraint tracking_reminder_notifications_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint tracking_reminder_notifications_tracking_reminders_id_fk
        foreign key (tracking_reminder_id) references tracking_reminders (id)
            on update cascade on delete cascade,
    constraint tracking_reminder_notifications_user_id_fk
        foreign key (user_id) references wp_users (ID)
            on delete cascade,
    constraint tracking_reminder_notifications_user_variables_id_fk
        foreign key (user_variable_id) references user_variables (id)
            on update cascade on delete cascade,
    constraint tracking_reminder_notifications_variables_id_fk
        foreign key (variable_id) references variables (id)
            on update cascade on delete cascade
)
    charset = utf8;

create index tracking_reminders_user_variables_variable_id_user_id_fk
    on tracking_reminders (variable_id, user_id);

create index user_client
    on tracking_reminders (user_id, client_id);

create table if not exists user_tags
(
    id                      int unsigned auto_increment
        primary key,
    tagged_variable_id      int unsigned                        not null comment 'This is the id of the variable being tagged with an ingredient or something.',
    tag_variable_id         int unsigned                        not null comment 'This is the id of the ingredient variable whose value is determined based on the value of the tagged variable.',
    conversion_factor       double                              not null comment 'Number by which we multiply the tagged variable''s value to obtain the tag variable''s value',
    user_id                 bigint unsigned                     not null,
    created_at              timestamp default CURRENT_TIMESTAMP not null,
    updated_at              timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    client_id               varchar(80)                         null,
    deleted_at              timestamp                           null,
    tagged_user_variable_id int unsigned                        null,
    tag_user_variable_id    int unsigned                        null,
    constraint UK_user_tag_tagged
        unique (tagged_variable_id, tag_variable_id, user_id),
    constraint user_tags_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint user_tags_tag_user_variable_id_fk
        foreign key (tag_user_variable_id) references user_variables (id),
    constraint user_tags_tag_variable_id_variables_id_fk
        foreign key (tag_variable_id) references variables (id),
    constraint user_tags_tagged_user_variable_id_fk
        foreign key (tagged_user_variable_id) references user_variables (id),
    constraint user_tags_tagged_variable_id_variables_id_fk
        foreign key (tagged_variable_id) references variables (id),
    constraint user_tags_user_id_fk
        foreign key (user_id) references wp_users (ID)
)
    comment 'User self-reported variable tags, used to infer the user intake of the different ingredients by just entering the foods. The inferred intake levels will then be used to determine the effects of different nutrients on the user during analysis.'
    charset = utf8;

create index fk_conversionUnit
    on user_tags (tag_variable_id);

create table if not exists user_variable_clients
(
    id                      int auto_increment
        primary key,
    client_id               varchar(80)                         not null,
    created_at              timestamp default CURRENT_TIMESTAMP not null,
    deleted_at              timestamp                           null,
    earliest_measurement_at timestamp                           null comment 'Earliest measurement time for this variable and client',
    latest_measurement_at   timestamp                           null comment 'Earliest measurement time for this variable and client',
    number_of_measurements  int unsigned                        null,
    updated_at              timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    user_id                 bigint unsigned                     not null,
    user_variable_id        int(11) unsigned                    not null,
    variable_id             int(11) unsigned                    not null comment 'Id of variable',
    constraint user
        unique (user_id, variable_id, client_id),
    constraint user_variable_clients_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint user_variable_clients_user_id_fk
        foreign key (user_id) references wp_users (ID),
    constraint user_variable_clients_user_variables_user_variable_id_fk
        foreign key (user_variable_id) references user_variables (id),
    constraint user_variable_clients_variable_id_fk
        foreign key (variable_id) references variables (id)
)
    charset = utf8;

create table if not exists user_variable_outcome_category
(
    id                               int auto_increment
        primary key,
    user_variable_id                 int unsigned                        not null,
    variable_id                      int unsigned                        not null,
    variable_category_id             tinyint unsigned                    not null,
    number_of_outcome_user_variables int unsigned                        not null,
    created_at                       timestamp default CURRENT_TIMESTAMP not null,
    updated_at                       timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at                       timestamp                           null,
    constraint user_variable_id_variable_category_id_uindex
        unique (user_variable_id, variable_category_id),
    constraint user_variable_outcome_category_user_variables_id_fk
        foreign key (user_variable_id) references user_variables (id),
    constraint user_variable_outcome_category_variable_categories_id_fk
        foreign key (variable_category_id) references variable_categories (id),
    constraint user_variable_outcome_category_variables_id_fk
        foreign key (variable_id) references variables (id)
);

create table if not exists user_variable_predictor_category
(
    id                                 int auto_increment
        primary key,
    user_variable_id                   int unsigned                        not null,
    variable_id                        int unsigned                        not null,
    variable_category_id               tinyint unsigned                    not null,
    number_of_predictor_user_variables int unsigned                        not null,
    created_at                         timestamp default CURRENT_TIMESTAMP not null,
    updated_at                         timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at                         timestamp                           null,
    constraint user_variable_id_variable_category_id_uindex
        unique (user_variable_id, variable_category_id),
    constraint user_variable_predictor_category_user_variables_id_fk
        foreign key (user_variable_id) references user_variables (id),
    constraint user_variable_predictor_category_variable_categories_id_fk
        foreign key (variable_category_id) references variable_categories (id),
    constraint user_variable_predictor_category_variables_id_fk
        foreign key (variable_id) references variables (id)
);

create index fk_variableSettings
    on user_variables (variable_id);

create index user_variables_analysis_started_at_index
    on user_variables (analysis_started_at);

create index user_variables_user_id_latest_tagged_measurement_time_index
    on user_variables (user_id);

create index variables_analysis_ended_at_index
    on user_variables (analysis_ended_at);

create table if not exists variable_user_sources
(
    user_id                       bigint unsigned                     not null,
    variable_id                   int unsigned                        not null comment 'ID of variable',
    timestamp                     int unsigned                        null comment 'Time that this measurement occurred

Uses epoch minute (epoch time divided by 60)',
    earliest_measurement_time     int unsigned                        null comment 'Earliest measurement time',
    latest_measurement_time       int unsigned                        null comment 'Latest measurement time',
    created_at                    timestamp default CURRENT_TIMESTAMP not null,
    updated_at                    timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at                    timestamp                           null,
    data_source_name              varchar(80)                         not null,
    number_of_raw_measurements    int                                 null,
    client_id                     varchar(255)                        null,
    id                            int auto_increment
        primary key,
    user_variable_id              int unsigned                        not null,
    earliest_measurement_start_at timestamp                           null,
    latest_measurement_start_at   timestamp                           null,
    constraint user
        unique (user_id, variable_id, data_source_name),
    constraint variable_user_sources_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint variable_user_sources_user_id_fk
        foreign key (user_id) references wp_users (ID),
    constraint variable_user_sources_user_variables_user_id_variable_id_fk
        foreign key (user_id, variable_id) references user_variables (user_id, variable_id),
    constraint variable_user_sources_user_variables_user_variable_id_fk
        foreign key (user_variable_id) references user_variables (id)
            on update cascade on delete cascade,
    constraint variable_user_sources_variable_id_fk
        foreign key (variable_id) references variables (id)
)
    charset = utf8;

create index variable_user_sources_user_variables_variable_id_user_id_fk
    on variable_user_sources (variable_id, user_id);

create table if not exists votes
(
    id                       int auto_increment
        primary key,
    client_id                varchar(80)                         null,
    user_id                  bigint unsigned                     not null,
    value                    int                                 not null comment 'Value of Vote',
    created_at               timestamp default CURRENT_TIMESTAMP not null,
    updated_at               timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at               timestamp                           null,
    cause_variable_id        int unsigned                        not null,
    effect_variable_id       int unsigned                        not null,
    correlation_id           int                                 null,
    aggregate_correlation_id int                                 null,
    is_public                tinyint(1)                          null,
    constraint votes_user_id_cause_variable_id_effect_variable_id_uindex
        unique (user_id, cause_variable_id, effect_variable_id),
    constraint votes_aggregate_correlations_id_fk
        foreign key (aggregate_correlation_id) references aggregate_correlations (id)
            on delete set null,
    constraint votes_cause_variable_id_fk
        foreign key (cause_variable_id) references variables (id),
    constraint votes_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint votes_correlations_id_fk
        foreign key (correlation_id) references correlations (id),
    constraint votes_effect_variable_id_fk_2
        foreign key (effect_variable_id) references variables (id),
    constraint votes_user_id_fk
        foreign key (user_id) references wp_users (ID)
)
    comment 'Vote thumbs down button for relationships that you think are coincidences and thumbs up for correlations with a plausible causal explanation.'
    charset = utf8;

create index votes_cause_variable_id_index
    on votes (cause_variable_id);

create index votes_effect_variable_id_index
    on votes (effect_variable_id);

create table if not exists wp_bp_activity
(
    id                bigint auto_increment
        primary key,
    user_id           bigint unsigned                      not null,
    component         varchar(75)                          not null,
    type              varchar(75)                          not null,
    action            text                                 not null,
    content           longtext                             not null,
    primary_link      text                                 not null,
    item_id           bigint                               not null,
    secondary_item_id bigint                               null,
    date_recorded     datetime                             not null,
    hide_sitewide     tinyint(1) default 0                 null,
    mptt_left         int        default 0                 not null,
    mptt_right        int        default 0                 not null,
    is_spam           tinyint(1) default 0                 not null,
    updated_at        timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at        timestamp  default CURRENT_TIMESTAMP not null,
    deleted_at        timestamp                            null,
    client_id         varchar(255)                         null,
    constraint wp_bp_activity_wp_users_ID_fk
        foreign key (user_id) references wp_users (ID)
)
    charset = utf8;

create index component
    on wp_bp_activity (component);

create index date_recorded
    on wp_bp_activity (date_recorded);

create index hide_sitewide
    on wp_bp_activity (hide_sitewide);

create index is_spam
    on wp_bp_activity (is_spam);

create index item_id
    on wp_bp_activity (item_id);

create index mptt_left
    on wp_bp_activity (mptt_left);

create index mptt_right
    on wp_bp_activity (mptt_right);

create index secondary_item_id
    on wp_bp_activity (secondary_item_id);

create index type
    on wp_bp_activity (type);

create index user_id
    on wp_bp_activity (user_id);

create table if not exists wp_bp_activity_meta
(
    id          bigint auto_increment
        primary key,
    activity_id bigint                              not null,
    meta_key    varchar(255)                        null,
    meta_value  longtext                            null,
    updated_at  timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at  timestamp default CURRENT_TIMESTAMP not null,
    deleted_at  timestamp                           null,
    client_id   varchar(255)                        null,
    constraint wp_bp_activity_meta_bshaffer_oauth_clients_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint wp_bp_activity_meta_wp_bp_activity_id_fk
        foreign key (activity_id) references wp_bp_activity (id)
)
    charset = utf8;

create index activity_id
    on wp_bp_activity_meta (activity_id);

create index meta_key
    on wp_bp_activity_meta (meta_key(191));

create table if not exists wp_bp_friends
(
    id                bigint auto_increment
        primary key,
    initiator_user_id bigint unsigned                      not null,
    friend_user_id    bigint unsigned                      not null,
    is_confirmed      tinyint(1) default 0                 null,
    is_limited        tinyint(1) default 0                 null,
    date_created      datetime                             not null,
    updated_at        timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at        timestamp  default CURRENT_TIMESTAMP not null,
    deleted_at        timestamp                            null,
    client_id         varchar(255)                         null,
    constraint wp_bp_friends_friend_user_id_wp_users_ID_fk
        foreign key (friend_user_id) references wp_users (ID),
    constraint wp_bp_friends_initiator_user_id_wp_users_ID_fk
        foreign key (initiator_user_id) references wp_users (ID)
)
    charset = utf8;

create index friend_user_id
    on wp_bp_friends (friend_user_id);

create index initiator_user_id
    on wp_bp_friends (initiator_user_id);

create table if not exists wp_bp_groups_members
(
    id            bigint auto_increment
        primary key,
    group_id      bigint                               not null,
    user_id       bigint unsigned                      not null,
    inviter_id    bigint                               not null,
    is_admin      tinyint(1) default 0                 not null,
    is_mod        tinyint(1) default 0                 not null,
    user_title    varchar(100)                         not null,
    date_modified datetime                             not null,
    comments      longtext                             not null,
    is_confirmed  tinyint(1) default 0                 not null,
    is_banned     tinyint(1) default 0                 not null,
    invite_sent   tinyint(1) default 0                 not null,
    updated_at    timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at    timestamp  default CURRENT_TIMESTAMP not null,
    deleted_at    timestamp                            null,
    client_id     varchar(255)                         null,
    constraint wp_bp_groups_members_wp_users_ID_fk
        foreign key (user_id) references wp_users (ID)
)
    charset = utf8;

create index group_id
    on wp_bp_groups_members (group_id);

create index inviter_id
    on wp_bp_groups_members (inviter_id);

create index is_admin
    on wp_bp_groups_members (is_admin);

create index is_confirmed
    on wp_bp_groups_members (is_confirmed);

create index is_mod
    on wp_bp_groups_members (is_mod);

create index user_id
    on wp_bp_groups_members (user_id);

create table if not exists wp_bp_messages_recipients
(
    id           bigint auto_increment
        primary key,
    user_id      bigint unsigned                      not null,
    thread_id    bigint                               not null,
    unread_count int(10)    default 0                 not null,
    sender_only  tinyint(1) default 0                 not null,
    is_deleted   tinyint(1) default 0                 not null,
    updated_at   timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at   timestamp  default CURRENT_TIMESTAMP not null,
    deleted_at   timestamp                            null,
    client_id    varchar(255)                         null,
    constraint wp_bp_messages_recipients_wp_users_ID_fk
        foreign key (user_id) references wp_users (ID)
)
    charset = utf8;

create index is_deleted
    on wp_bp_messages_recipients (is_deleted);

create index sender_only
    on wp_bp_messages_recipients (sender_only);

create index thread_id
    on wp_bp_messages_recipients (thread_id);

create index unread_count
    on wp_bp_messages_recipients (unread_count);

create index user_id
    on wp_bp_messages_recipients (user_id);

create table if not exists wp_bp_notifications
(
    id                bigint auto_increment
        primary key,
    user_id           bigint unsigned                      not null,
    item_id           bigint                               not null,
    secondary_item_id bigint                               null,
    component_name    varchar(75)                          not null,
    component_action  varchar(75)                          not null,
    date_notified     datetime                             not null,
    is_new            tinyint(1) default 0                 not null,
    updated_at        timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at        timestamp  default CURRENT_TIMESTAMP not null,
    deleted_at        timestamp                            null,
    client_id         varchar(255)                         null,
    constraint wp_bp_notifications_wp_users_ID_fk
        foreign key (user_id) references wp_users (ID)
)
    charset = utf8;

create index component_action
    on wp_bp_notifications (component_action);

create index component_name
    on wp_bp_notifications (component_name);

create index is_new
    on wp_bp_notifications (is_new);

create index item_id
    on wp_bp_notifications (item_id);

create index secondary_item_id
    on wp_bp_notifications (secondary_item_id);

create index useritem
    on wp_bp_notifications (user_id, is_new);

create table if not exists wp_bp_user_blogs
(
    id         bigint auto_increment
        primary key,
    user_id    bigint unsigned                     not null,
    blog_id    bigint                              not null,
    updated_at timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    deleted_at timestamp                           null,
    client_id  varchar(255)                        null,
    constraint wp_bp_user_blogs_wp_users_ID_fk
        foreign key (user_id) references wp_users (ID)
)
    charset = utf8;

create index blog_id
    on wp_bp_user_blogs (blog_id);

create index user_id
    on wp_bp_user_blogs (user_id);

create table if not exists wp_bp_xprofile_data
(
    id           bigint unsigned auto_increment
        primary key,
    field_id     bigint unsigned                     not null,
    user_id      bigint unsigned                     not null,
    value        longtext                            not null,
    last_updated datetime                            not null,
    updated_at   timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at   timestamp default CURRENT_TIMESTAMP not null,
    deleted_at   timestamp                           null,
    client_id    varchar(255)                        null,
    constraint wp_bp_xprofile_data_wp_users_ID_fk
        foreign key (user_id) references wp_users (ID)
)
    charset = utf8;

create index field_id
    on wp_bp_xprofile_data (field_id);

create index user_id
    on wp_bp_xprofile_data (user_id);

create table if not exists wp_comments
(
    comment_ID           bigint unsigned auto_increment comment 'Unique number assigned to each comment.'
        primary key,
    comment_post_ID      bigint unsigned                         null comment 'ID of the post this comment relates to.',
    comment_author       tinytext                                null comment 'Name of the comment author.',
    comment_author_email varchar(100)                            null comment 'Email of the comment author.',
    comment_author_url   varchar(200)                            null comment 'URL for the comment author.',
    comment_author_IP    varchar(100)                            null comment 'IP Address of the comment author.',
    comment_date         timestamp default CURRENT_TIMESTAMP     not null on update CURRENT_TIMESTAMP comment 'Time and data the comment was posted.',
    comment_date_gmt     timestamp default '0000-00-00 00:00:00' not null comment 'GMT time and data the comment was posted.',
    comment_content      text                                    null comment 'The actual comment text.',
    comment_karma        int                                     null comment 'Unused by WordPress core, can be used by plugins to help manage comments.',
    comment_approved     varchar(20)                             null comment 'If the comment has been approved.',
    comment_agent        varchar(255)                            null comment 'Where the comment was posted from, eg. browser, operating system etc.',
    comment_type         varchar(20)                             null comment 'Type of comment: comment, pingback or trackback.',
    comment_parent       bigint unsigned                         null comment 'Refers to another comment when this comment is a reply.',
    user_id              bigint unsigned                         null comment 'ID of the comment author if they are a registered user on the site.',
    updated_at           timestamp default CURRENT_TIMESTAMP     not null on update CURRENT_TIMESTAMP,
    created_at           timestamp default CURRENT_TIMESTAMP     not null,
    deleted_at           timestamp                               null,
    client_id            varchar(255)                            null,
    constraint wp_comments_wp_posts_ID_fk
        foreign key (comment_post_ID) references wp_posts (ID),
    constraint wp_comments_wp_users_ID_fk
        foreign key (user_id) references wp_users (ID)
)
    comment 'Any post that allows discussion can have comments posted to it. This table stores those comments and some specific data about them. Further information can be stored in <a href="#wp_commentmeta">wp_commentmeta</a>.'
    charset = utf8;

create table if not exists wp_commentmeta
(
    meta_id    bigint unsigned auto_increment comment 'Unique number assigned to each row of the table.'
        primary key,
    comment_id bigint unsigned                     null comment 'The ID of the post the data relates to.',
    meta_key   varchar(255)                        null comment 'An identifying key for the piece of data.',
    meta_value longtext                            null comment 'The actual piece of data.',
    updated_at timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    deleted_at timestamp                           null,
    client_id  varchar(255)                        null,
    constraint wp_commentmeta_wp_comments_comment_ID_fk
        foreign key (comment_id) references wp_comments (comment_ID)
)
    comment 'This table stores any further information related to a comment.' charset = utf8;

create index comment_id
    on wp_commentmeta (comment_id);

create index meta_key
    on wp_commentmeta (meta_key(191));

create index comment_approved_date_gmt
    on wp_comments (comment_approved, comment_date_gmt);

create index comment_author_email
    on wp_comments (comment_author_email(10));

create index comment_date_gmt
    on wp_comments (comment_date_gmt);

create index comment_parent
    on wp_comments (comment_parent);

create index comment_post_ID
    on wp_comments (comment_post_ID);

create index woo_idx_comment_type
    on wp_comments (comment_type);

create index wp_comments_user_id_fk
    on wp_comments (user_id);

create table if not exists wp_links
(
    link_id          bigint unsigned auto_increment comment 'Unique number assigned to each row of the table.'
        primary key,
    link_url         varchar(760)                           not null comment 'Unique universal resource locator for the link.',
    link_name        varchar(255)                           null comment 'Name of the link.',
    link_image       varchar(255)                           null comment 'URL of an image related to the link.',
    link_target      varchar(25)                            null comment 'The target frame for the link. e.g. _blank, _top, _none.',
    link_description varchar(255)                           null comment 'Description of the link.',
    link_visible     varchar(20)                            null comment 'Control if the link is public or private.',
    link_owner       bigint unsigned                        null comment 'ID of user who created the link.',
    link_rating      int                                    null comment 'Add a rating between 0-10 for the link.',
    link_updated     timestamp    default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment 'Time and date of link update.',
    link_rel         varchar(255)                           null comment 'Relationship of link.',
    link_notes       mediumtext                             null comment 'Notes about the link.',
    link_rss         varchar(255) default ''                not null,
    updated_at       timestamp    default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at       timestamp    default CURRENT_TIMESTAMP not null,
    deleted_at       timestamp                              null,
    client_id        varchar(255)                           null,
    constraint wp_links_link_url_uindex
        unique (link_url),
    constraint wp_links_wp_users_ID_fk
        foreign key (link_owner) references wp_users (ID)
)
    comment 'During the rise of popularity of blogging having a blogroll (links to other sites) on your site was very much in fashion. This table holds all those links for you.'
    charset = utf8;

create index link_visible
    on wp_links (link_visible);

alter table wp_posts
    add constraint wp_posts_wp_users_ID_fk
        foreign key (post_author) references wp_users (ID);

create table if not exists wp_usermeta
(
    umeta_id   bigint unsigned auto_increment comment 'Unique number assigned to each row of the table.'
        primary key,
    user_id    bigint unsigned                     null comment 'ID of the related user.',
    meta_key   varchar(255)                        null comment 'An identifying key for the piece of data.',
    meta_value longtext                            null comment 'The actual piece of data.',
    updated_at timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    deleted_at timestamp                           null,
    client_id  varchar(255)                        null,
    constraint wp_usermeta_wp_users_ID_fk
        foreign key (user_id) references wp_users (ID)
)
    comment 'This table stores any further information related to the users. You will see other user profile fields for a user in the dashboard that are stored here.'
    charset = utf8;

create index meta_key
    on wp_usermeta (meta_key);

create index user_id
    on wp_usermeta (user_id);

create index user_nicename
    on wp_users (user_nicename);
