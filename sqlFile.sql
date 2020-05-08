-- use master drop database QLNongSan

create database QLNongSan
go
use QLNongSan
go

create table Roles
(
id int primary key identity,
name nvarchar(1000) not null,
deleted int default 0,
)
create table AdminBC
(
id int primary key identity,
username varchar(50) unique not null,
pwd varchar(1000) null,
name nvarchar(100) null ,
birthday datetime null ,
email varchar(500) null ,
adrs nvarchar(1000) null ,
phone varchar(15) null ,
mobile varchar(15) null ,
token varchar(1000) null ,
dateCreated datetime,
dateUpdate datetime null,
deleted int default 0 not null -- 1 is deleted
)
create table UserBC
(
id int primary key identity ,
username varchar(50) unique not null ,
pwd varchar(1000) not null ,
name nvarchar(100) null ,
birthday datetime null ,
email varchar(500) null ,
adrs nvarchar(1000) null,
phone varchar(15) null ,
idRole int,
active int,
dateCreated datetime,
dateUpdate datetime null,
deleted int default 0 -- 1 is deleted
)
create table Product
(
id varchar(50) primary key,
nameProduct nvarchar(1000),
details nvarchar(MAX) null,
isDeleted int default 0
)
create table ProductDetail
(
id int identity ,
idUser varchar(50),
idProduct varchar(50) ,
dateCreated datetime,
dateReview datetime null,
isDeleted int default 0
PRIMARY KEY (id,idUser,idProduct)
)
