create table github_repositories
(
    id                          integer                                not null
        constraint github_repositories_id_uindex
            unique,
    client_id                   varchar(80)
        constraint github_repositories_oa_clients_client_id_fk
            references oa_clients,
    created_at                  timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at                  timestamp(0),
    updated_at                  timestamp(0)                           not null,
    user_id                     bigint
        constraint "github_repositories_wp_users_ID_fk"
            references wp_users,
    github_repository_id        integer                                not null
        constraint github_repositories_github_repository_id_uindex
            unique,
    node_id                     varchar(255)                           not null,
    name                        varchar(255)                           not null
        constraint github_repositories_name_uindex
            unique,
    full_name                   varchar(255)                           not null,
    private                     boolean                                not null,
    owner                       text                                   not null,
    html_url                    varchar(255)                           not null
        constraint github_repositories_html_url_uindex
            unique,
    description                 text,
    fork                        boolean                                not null,
    url                         varchar(255)                           not null
        constraint github_repositories_url_uindex
            unique,
    forks_url                   varchar(255)                           not null,
    keys_url                    varchar(255)                           not null,
    collaborators_url           varchar(255)                           not null,
    teams_url                   varchar(255)                           not null,
    hooks_url                   varchar(255)                           not null,
    issue_events_url            varchar(255)                           not null,
    events_url                  varchar(255)                           not null,
    assignees_url               varchar(255)                           not null,
    branches_url                varchar(255)                           not null,
    tags_url                    varchar(255)                           not null,
    blobs_url                   varchar(255)                           not null,
    git_tags_url                varchar(255)                           not null,
    git_refs_url                varchar(255)                           not null,
    trees_url                   varchar(255)                           not null,
    statuses_url                varchar(255)                           not null,
    languages_url               varchar(255)                           not null,
    stargazers_url              varchar(255)                           not null,
    contributors_url            varchar(255)                           not null,
    subscribers_url             varchar(255)                           not null,
    subscription_url            varchar(255)                           not null,
    commits_url                 varchar(255)                           not null,
    git_commits_url             varchar(255)                           not null,
    comments_url                varchar(255)                           not null,
    issue_comment_url           varchar(255)                           not null,
    contents_url                varchar(255)                           not null,
    compare_url                 varchar(255)                           not null,
    merges_url                  varchar(255)                           not null,
    archive_url                 varchar(255)                           not null,
    downloads_url               varchar(255)                           not null,
    issues_url                  varchar(255)                           not null,
    pulls_url                   varchar(255)                           not null,
    milestones_url              varchar(255)                           not null,
    notifications_url           varchar(255)                           not null,
    labels_url                  varchar(255)                           not null,
    releases_url                varchar(255)                           not null,
    deployments_url             varchar(255)                           not null,
    pushed_at                   varchar(255)                           not null,
    git_url                     varchar(255)                           not null
        constraint github_repositories_git_url_uindex
            unique,
    ssh_url                     varchar(255)                           not null
        constraint github_repositories_ssh_url_uindex
            unique,
    clone_url                   varchar(255)                           not null,
    svn_url                     varchar(255)                           not null,
    homepage                    varchar(255),
    size                        integer                                not null,
    stargazers_count            integer                                not null,
    watchers_count              integer                                not null,
    language                    varchar(255)                           not null,
    has_issues                  boolean                                not null,
    has_projects                boolean                                not null,
    has_downloads               boolean                                not null,
    has_wiki                    boolean                                not null,
    has_pages                   boolean                                not null,
    forks_count                 integer                                not null,
    archived                    boolean                                not null,
    disabled                    boolean                                not null,
    open_issues_count           integer                                not null,
    allow_forking               boolean                                not null,
    is_template                 boolean                                not null,
    topics                      text                                   not null,
    visibility                  varchar(255)                           not null,
    forks                       integer                                not null,
    open_issues                 integer                                not null,
    watchers                    integer                                not null,
    default_branch              varchar(255)                           not null,
    permissions                 text                                   not null,
    temp_clone_token            varchar(255),
    allow_squash_merge          boolean,
    allow_merge_commit          boolean,
    allow_rebase_merge          boolean,
    allow_auto_merge            boolean,
    delete_branch_on_merge      boolean,
    network_count               integer,
    subscribers_count           integer,
    score                       integer,
    mirror_url                  varchar(255),
    license                     text,
    web_commit_signoff_required boolean
);

comment on column github_repositories.id is 'Automatically generated unique id for the github repository';

comment on column github_repositories.client_id is 'The ID for the API client that created the record';

comment on column github_repositories.created_at is 'The time the record was originally created';

comment on column github_repositories.deleted_at is 'The time the record was deleted';

comment on column github_repositories.updated_at is 'The time the record was last modified';

comment on column github_repositories.user_id is 'The user ID for the owner of the record';

comment on column github_repositories.github_repository_id is 'Github repository id Example: 158861117';

comment on column github_repositories.node_id is 'Example: MDEwOlJlcG9zaXRvcnkxNTg4NjExMTc=';

comment on column github_repositories.name is 'Example: qm-api';

comment on column github_repositories.full_name is 'Example: mikepsinn/qm-api';

comment on column github_repositories.private is 'Example: 1';

comment on column github_repositories.owner is 'Example: login:mikepsinn,id:2808553,node_id:MDQ6VXNlcjI4MDg1NTM=,avatar_url:https://avatars.githubusercontent.com/u/2808553?v=4,gravatar_id:,url:https://api.github.com/users/mikepsinn,html_url:https://github.com/mikepsinn,followers_url:https://api.github.com/users/mikepsinn/followers,following_url:https://api.github.com/users/mikepsinn/following/other_user,gists_url:https://api.github.com/users/mikepsinn/gists/gist_id,starred_url:https://api.github.com/users/mikepsinn/starred/owner/repo,subscriptions_url:https://api.github.com/users/mikepsinn/subscriptions,organizations_url:https://api.github.com/users/mikepsinn/orgs,repos_url:https://api.github.com/users/mikepsinn/repos,events_url:https://api.github.com/users/mikepsinn/events/privacy,received_events_url:https://api.github.com/users/mikepsinn/received_events,type:User,site_admin:false';

comment on column github_repositories.html_url is 'Example: https://github.com/mikepsinn/qm-api';

comment on column github_repositories.description is 'Example: I''m a description';

comment on column github_repositories.fork is 'Example: ';

comment on column github_repositories.url is 'Example: https://api.github.com/repos/mikepsinn/qm-api';

comment on column github_repositories.forks_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/forks';

comment on column github_repositories.keys_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/keys/key_id';

comment on column github_repositories.collaborators_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/collaborators/collaborator';

comment on column github_repositories.teams_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/teams';

comment on column github_repositories.hooks_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/hooks';

comment on column github_repositories.issue_events_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/issues/events/number';

comment on column github_repositories.events_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/events';

comment on column github_repositories.assignees_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/assignees/user';

comment on column github_repositories.branches_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/branches/branch';

comment on column github_repositories.tags_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/tags';

comment on column github_repositories.blobs_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/git/blobs/sha';

comment on column github_repositories.git_tags_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/git/tags/sha';

comment on column github_repositories.git_refs_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/git/refs/sha';

comment on column github_repositories.trees_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/git/trees/sha';

comment on column github_repositories.statuses_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/statuses/sha';

comment on column github_repositories.languages_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/languages';

comment on column github_repositories.stargazers_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/stargazers';

comment on column github_repositories.contributors_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/contributors';

comment on column github_repositories.subscribers_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/subscribers';

comment on column github_repositories.subscription_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/subscription';

comment on column github_repositories.commits_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/commits/sha';

comment on column github_repositories.git_commits_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/git/commits/sha';

comment on column github_repositories.comments_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/comments/number';

comment on column github_repositories.issue_comment_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/issues/comments/number';

comment on column github_repositories.contents_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/contents/+path';

comment on column github_repositories.compare_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/compare/base...head';

comment on column github_repositories.merges_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/merges';

comment on column github_repositories.archive_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/archive_format/ref';

comment on column github_repositories.downloads_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/downloads';

comment on column github_repositories.issues_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/issues/number';

comment on column github_repositories.pulls_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/pulls/number';

comment on column github_repositories.milestones_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/milestones/number';

comment on column github_repositories.notifications_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/notifications?since,all,participating';

comment on column github_repositories.labels_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/labels/name';

comment on column github_repositories.releases_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/releases/id';

comment on column github_repositories.deployments_url is 'Example: https://api.github.com/repos/mikepsinn/qm-api/deployments';

comment on column github_repositories.pushed_at is 'Example: 2021-10-24T00:07:07Z';

comment on column github_repositories.git_url is 'Example: git://github.com/mikepsinn/qm-api.git';

comment on column github_repositories.ssh_url is 'Example: git@github.com:mikepsinn/qm-api.git';

comment on column github_repositories.clone_url is 'Example: https://github.com/mikepsinn/qm-api.git';

comment on column github_repositories.svn_url is 'Example: https://github.com/mikepsinn/qm-api';

comment on column github_repositories.homepage is 'Example: https://quantimo.do';

comment on column github_repositories.size is 'Example: 178451';

comment on column github_repositories.stargazers_count is 'Example: 2';

comment on column github_repositories.watchers_count is 'Example: 2';

comment on column github_repositories.language is 'Example: PHP';

comment on column github_repositories.has_issues is 'Example: 1';

comment on column github_repositories.has_projects is 'Example: 1';

comment on column github_repositories.has_downloads is 'Example: 1';

comment on column github_repositories.has_wiki is 'Example: 1';

comment on column github_repositories.has_pages is 'Example: ';

comment on column github_repositories.forks_count is 'Example: 0';

comment on column github_repositories.archived is 'Example: ';

comment on column github_repositories.disabled is 'Example: ';

comment on column github_repositories.open_issues_count is 'Example: 89';

comment on column github_repositories.allow_forking is 'Example: 1';

comment on column github_repositories.is_template is 'Example: ';

comment on column github_repositories.topics is 'Example: [digital-health,health,healthcare-data]';

comment on column github_repositories.visibility is 'Example: private';

comment on column github_repositories.forks is 'Example: 0';

comment on column github_repositories.open_issues is 'Example: 89';

comment on column github_repositories.watchers is 'Example: 2';

comment on column github_repositories.default_branch is 'Example: develop';

comment on column github_repositories.permissions is 'Example: admin:true,maintain:true,push:true,triage:true,pull:true';

comment on column github_repositories.temp_clone_token is 'Example: AAVNV2SECRETYTBOS7ZI';

comment on column github_repositories.allow_squash_merge is 'Example: 1';

comment on column github_repositories.allow_merge_commit is 'Example: 1';

comment on column github_repositories.allow_rebase_merge is 'Example: 1';

comment on column github_repositories.allow_auto_merge is 'Example: ';

comment on column github_repositories.delete_branch_on_merge is 'Example: ';

comment on column github_repositories.network_count is 'Example: 0';

comment on column github_repositories.subscribers_count is 'Example: 0';

comment on column github_repositories.score is 'Example: 0';

comment on column github_repositories.mirror_url is 'Example: git@github.com:mikepsinn/qm-api.git';

comment on column github_repositories.license is 'GPL-3.0';

comment on column github_repositories.web_commit_signoff_required is 'Example: false';

alter table github_repositories
    owner to postgres;

create index github_repositories_oa_clients_client_id_fk
    on github_repositories (client_id);

create index "github_repositories_wp_users_ID_fk"
    on github_repositories (user_id);

