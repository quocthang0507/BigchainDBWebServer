-- use master drop database QLNongSan

create database QLNongSan
go
use QLNongSan
go
create table amsm
(
id int primary key identity,
username varchar(50) unique not null,
pwd varchar(1000) null,
name nvarchar(100) null ,
birthday datetime null ,
email varchar(500) null ,
adrs nvarchar(1000) null ,
teleNum1 varchar(15) null ,
teleNum2 varchar(15) null ,
rolls int ,
token varchar(1000) null ,
deleted int default 0 not null -- 1 is deleted
)
create table custommer
(
id int primary key identity ,
username varchar(50) unique not null ,
pwd varchar(1000) not null ,
name nvarchar(100) null ,
birthday datetime null ,
email varchar(500) null ,
adrs nvarchar(1000) null ,
teleNum1 varchar(15) null ,
teleNum2 varchar(15) null ,
token varchar(1000) null ,
deleted int default 0 -- 1 is deleted
)
create table memberUser
(
id int primary key identity ,
loginType varchar(100) null ,
username varchar(50) unique null ,
pwd varchar(1000) null ,
name nvarchar(100) null ,
birthday datetime null ,
email varchar(500) null ,
adrs nvarchar(1000) null ,
teleNum varchar(15) null ,
token varchar(1000) null ,
deleted int default 0 -- 1 is deleted
)
create table theFarm
(
id int primary key identity ,
idCustommer int FOREIGN key references dbo.custommer(id) null ,
adrs nvarchar(1000) null ,
deleted int default 0 -- 1 is deleted
)
create table agriculturalProduce
(
id int primary key identity ,
name nvarchar(100) null ,
details nvarchar(MAX) null ,
deleted int default 0 -- 1 is deleted
)
create table farm_agriPro
(
id int primary key identity ,
idFarm int foreign key references dbo.theFarm(id) null ,
idAgriPro int foreign key references dbo.agriculturalProduce(id) null ,
deleted int default 0 -- 1 is deleted
)


