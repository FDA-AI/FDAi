create table if not exists migrations
(
    id        int          null,
    migration varchar(191) null,
    batch     int          null
);

