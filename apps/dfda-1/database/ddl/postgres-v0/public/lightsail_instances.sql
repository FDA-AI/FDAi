create table lightsail_instances
(
    id                  serial
        primary key,
    client_id           varchar(80)
        constraint lightsail_instances_client_id_fk
            references oa_clients,
    created_at          timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at          timestamp(0),
    updated_at          timestamp(0)                           not null,
    user_id             bigint                                 not null
        constraint "lightsail_instances_wp_users_ID_fk"
            references wp_users,
    name                varchar(255)                           not null,
    arn                 varchar(255)                           not null,
    support_code        varchar(255)                           not null,
    external_created_at varchar(255)                           not null,
    location            text                                   not null,
    resource_type       varchar(255)                           not null,
    tags                text                                   not null,
    blueprint_id        varchar(255)                           not null,
    blueprint_name      varchar(255)                           not null,
    bundle_id           varchar(255)                           not null,
    add_ons             text                                   not null,
    is_static_ip        boolean                                not null,
    private_ip_address  varchar(255)                           not null,
    public_ip_address   varchar(255)                           not null,
    ipv6_addresses      text                                   not null,
    ip_address_type     varchar(255)                           not null,
    hardware            text                                   not null,
    networking          text                                   not null,
    state               text                                   not null,
    username            varchar(255)                           not null,
    ssh_key_name        varchar(255)                           not null,
    jenkins_labels      text                                   not null,
    computer            varchar(255)                           not null
);

comment on column lightsail_instances.id is 'Automatically generated unique id for the lightsail instance';

comment on column lightsail_instances.client_id is 'The ID for the API client that created the record';

comment on column lightsail_instances.created_at is 'The time the record was originally created';

comment on column lightsail_instances.deleted_at is 'The time the record was deleted';

comment on column lightsail_instances.updated_at is 'The time the record was last modified';

comment on column lightsail_instances.user_id is 'The QuantiModo user ID for the owner of the record';

comment on column lightsail_instances.name is 'Example: cc-wp';

comment on column lightsail_instances.arn is 'Example: arn:aws:lightsail:us-east-1:335072289018:Instance/14eb6cec-1c74-429a-96f5-8f8f5e5fbbc1';

comment on column lightsail_instances.support_code is 'Example: 102336889266/i-005d61af88d99927e';

comment on column lightsail_instances.external_created_at is 'Example: 2021-03-22T01:47:10+00:00';

comment on column lightsail_instances.location is 'Example: {availabilityZone:us-east-1a,regionName:us-east-1}';

comment on column lightsail_instances.resource_type is 'Example: Instance';

comment on column lightsail_instances.tags is 'Example: [{key:wordpress},{key:HEALTH_CHECK_URL,value:https://CrowdsourcingCures.org}]';

comment on column lightsail_instances.blueprint_id is 'Example: wordpress';

comment on column lightsail_instances.blueprint_name is 'Example: WordPress';

comment on column lightsail_instances.bundle_id is 'Example: micro_2_0';

comment on column lightsail_instances.add_ons is 'Example: [{name:AutoSnapshot,status:Enabled,snapshotTimeOfDay:00:00}]';

comment on column lightsail_instances.is_static_ip is 'Example: 1';

comment on column lightsail_instances.private_ip_address is 'Example: 172.26.7.226';

comment on column lightsail_instances.public_ip_address is 'Example: 3.224.6.200';

comment on column lightsail_instances.ipv6_addresses is 'Example: [2600:1f18:1ae:1700:c92e:b66f:52cd:5f01]';

comment on column lightsail_instances.ip_address_type is 'Example: dualstack';

comment on column lightsail_instances.hardware is 'Example: {cpuCount:1,disks:[{createdAt:2021-03-22T01:47:10+00:00,sizeInGb:40,isSystemDisk:true,iops:120,path:/dev/xvda,attachedTo:cc-wp,attachmentState:attached}],ramSizeInGb:1}';

comment on column lightsail_instances.networking is 'Example: {monthlyTransfer:{gbPerMonthAllocated:2048},ports:[{fromPort:80,toPort:80,protocol:tcp,accessFrom:Anywhere (0.0.0.0/0),accessType:public,commonName:,accessDirection:inbound,cidrs:[0.0.0.0/0],ipv6Cidrs:[],cidrListAliases:[]},{fromPort:8000,toPort:8000,protocol:tcp,accessFrom:Custom,accessType:public,commonName:,accessDirection:inbound,cidrs:[24.178.226.180/32],ipv6Cidrs:[],cidrListAliases:[]},{fromPort:7777,toPort:7777,protocol:tcp,accessFrom:Custom,accessType:public,commonName:,accessDirection:inbound,cidrs:[24.178.226.180/32],ipv6Cidrs:[],cidrListAliases:[]},{fromPort:6379,toPort:6379,protocol:tcp,accessFrom:Custom,accessType:public,commonName:,accessDirection:inbound,cidrs:[24.178.226.180/32],ipv6Cidrs:[],cidrListAliases:[]},{fromPort:888,toPort:888,protocol:tcp,accessFrom:Custom,accessType:public,commonName:,accessDirection:inbound,cidrs:[24.178.226.180/32],ipv6Cidrs:[],cidrListAliases:[]},{fromPort:20,toPort:20,protocol:tcp,accessFrom:Custom,accessType:public,commonName:,accessDirection:inbound,c';

comment on column lightsail_instances.state is 'Example: {code:16,name:running}';

comment on column lightsail_instances.username is 'Example: bitnami';

comment on column lightsail_instances.ssh_key_name is 'Example: qm-aws-20160528';

comment on column lightsail_instances.jenkins_labels is 'Example: []';

comment on column lightsail_instances.computer is 'Example: ';

alter table lightsail_instances
    owner to postgres;

create index lightsail_instances_client_id_fk
    on lightsail_instances (client_id);

create index "lightsail_instances_wp_users_ID_fk"
    on lightsail_instances (user_id);

