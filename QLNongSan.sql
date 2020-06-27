USE [master]
GO
/****** Object:  Database [QLNongSan]    Script Date: 6/25/2020 11:48:22 AM ******/
CREATE DATABASE [QLNongSan]
GO
use QLNongSan
go
--ALTER DATABASE [QLNongSan] SET COMPATIBILITY_LEVEL = 120
--GO
--IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
--begin
--EXEC [QLNongSan].[dbo].[sp_fulltext_database] @action = 'enable'
--end
--GO
--ALTER DATABASE [QLNongSan] SET ANSI_NULL_DEFAULT OFF 
--GO
--ALTER DATABASE [QLNongSan] SET ANSI_NULLS OFF 
--GO
--ALTER DATABASE [QLNongSan] SET ANSI_PADDING OFF 
--GO
--ALTER DATABASE [QLNongSan] SET ANSI_WARNINGS OFF 
--GO
--ALTER DATABASE [QLNongSan] SET ARITHABORT OFF 
--GO
--ALTER DATABASE [QLNongSan] SET AUTO_CLOSE ON 
--GO
--ALTER DATABASE [QLNongSan] SET AUTO_SHRINK OFF 
--GO
--ALTER DATABASE [QLNongSan] SET AUTO_UPDATE_STATISTICS ON 
--GO
--ALTER DATABASE [QLNongSan] SET CURSOR_CLOSE_ON_COMMIT OFF 
--GO
--ALTER DATABASE [QLNongSan] SET CURSOR_DEFAULT  GLOBAL 
--GO
--ALTER DATABASE [QLNongSan] SET CONCAT_NULL_YIELDS_NULL OFF 
--GO
--ALTER DATABASE [QLNongSan] SET NUMERIC_ROUNDABORT OFF 
--GO
--ALTER DATABASE [QLNongSan] SET QUOTED_IDENTIFIER OFF 
--GO
--ALTER DATABASE [QLNongSan] SET RECURSIVE_TRIGGERS OFF 
--GO
--ALTER DATABASE [QLNongSan] SET  ENABLE_BROKER 
--GO
--ALTER DATABASE [QLNongSan] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
--GO
--ALTER DATABASE [QLNongSan] SET DATE_CORRELATION_OPTIMIZATION OFF 
--GO
--ALTER DATABASE [QLNongSan] SET TRUSTWORTHY OFF 
--GO
--ALTER DATABASE [QLNongSan] SET ALLOW_SNAPSHOT_ISOLATION OFF 
--GO
--ALTER DATABASE [QLNongSan] SET PARAMETERIZATION SIMPLE 
--GO
--ALTER DATABASE [QLNongSan] SET READ_COMMITTED_SNAPSHOT OFF 
--GO
--ALTER DATABASE [QLNongSan] SET HONOR_BROKER_PRIORITY OFF 
--GO
--ALTER DATABASE [QLNongSan] SET RECOVERY SIMPLE 
--GO
--ALTER DATABASE [QLNongSan] SET  MULTI_USER 
--GO
--ALTER DATABASE [QLNongSan] SET PAGE_VERIFY CHECKSUM  
--GO
--ALTER DATABASE [QLNongSan] SET DB_CHAINING OFF 
--GO
--ALTER DATABASE [QLNongSan] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
--GO
--ALTER DATABASE [QLNongSan] SET TARGET_RECOVERY_TIME = 0 SECONDS 
--GO
--ALTER DATABASE [QLNongSan] SET DELAYED_DURABILITY = DISABLED 
--GO
--USE [QLNongSan]
--GO
--/****** Object:  Table [dbo].[AdminBC]    Script Date: 6/25/2020 11:48:22 AM ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--SET ANSI_PADDING ON
--GO
CREATE TABLE [dbo].[AdminBC](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[pwd] [varchar](1000) NULL,
	[name] [nvarchar](100) NULL,
	[birthday] [datetime] NULL,
	[email] [varchar](500) NULL,
	[adrs] [nvarchar](1000) NULL,
	[phone] [varchar](15) NULL,
	[dateCreated] [datetime] NULL,
	[dateUpdate] [datetime] NULL,
	[deleted] [int] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NewNoti]    Script Date: 6/25/2020 11:48:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NewNoti](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idUser] [varchar](50) NULL,
	[idProduct] [varchar](50) NULL,
	[dateCreate] [datetime] NULL,
	[detail] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product]    Script Date: 6/25/2020 11:48:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[id] [varchar](50) NOT NULL,
	[nameProduct] [nvarchar](1000) NULL,
	[details] [nvarchar](max) NULL,
	[isDeleted] [int] NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductDetail]    Script Date: 6/25/2020 11:48:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductDetail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idUser] [varchar](50) NOT NULL,
	[idProduct] [varchar](50) NOT NULL,
	[dateCreated] [datetime] NULL,
	[dateReview] [datetime] NULL,
	[isDeleted] [int] NULL DEFAULT ((0)),
	[IsUpBD] [int] NULL DEFAULT ((0)),
	[checkBuy] [int] NULL,
	[idRole] [int] NULL,
	[isClick] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[idUser] ASC,
	[idProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductPlantingProcess]    Script Date: 6/25/2020 11:48:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductPlantingProcess](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idProduct] [varchar](50) NULL,
	[idUser] [varchar](50) NULL,
	[details] [nvarchar](1000) NULL,
	[dateBegin] [datetime] NULL,
	[dateEnd] [datetime] NULL,
	[dateCreated] [datetime] NULL,
	[isDelete] [int] NULL,
	[isUpBD] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductTranfer]    Script Date: 6/25/2020 11:48:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductTranfer](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idProduct] [varchar](50) NOT NULL,
	[nameProduct] [nvarchar](1000) NOT NULL,
	[nameUser] [nvarchar](1000) NOT NULL,
	[detail] [nvarchar](max) NULL,
	[idUser] [varchar](50) NOT NULL,
	[isClick] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 6/25/2020 11:48:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[id] [int] NOT NULL,
	[name] [nvarchar](1000) NOT NULL,
	[deleted] [int] NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserBC]    Script Date: 6/25/2020 11:48:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserBC](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[pwd] [varchar](1000) NULL,
	[Area] [nvarchar](1000) NOT NULL,
	[City] [nvarchar](1000) NOT NULL,
	[name] [nvarchar](100) NULL,
	[birthday] [datetime] NULL,
	[email] [varchar](500) NULL,
	[adrs] [nvarchar](1000) NULL,
	[phone] [varchar](15) NULL,
	[idRole] [int] NULL,
	[active] [int] NULL,
	[dateCreated] [datetime] NULL,
	[dateUpdate] [datetime] NULL,
	[deleted] [int] NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[Notifications]    Script Date: 6/25/2020 11:48:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create VIEW [dbo].[Notifications] AS
SELECT NewNoti.id as ID, UserBC.username,UserBC.name,Roles.name as roles,Product.nameProduct, NewNoti.dateCreate
FROM UserBC
LEFT JOIN ProductDetail
ON UserBC.username = ProductDetail.idUser
LEFT JOIN Product
ON Product.id = ProductDetail.idProduct
LEFT JOIN Roles
ON Roles.id=UserBC.idRole
LEFT JOIN NewNoti
ON NewNoti.idUser=ProductDetail.idUser and ProductDetail.idProduct = NewNoti.idProduct
where NewNoti.id IS NOT NULL



GO
/****** Object:  View [dbo].[ProductDetailView]    Script Date: 6/25/2020 11:48:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[ProductDetailView] as
SELECT        id = ROW_NUMBER() OVER (ORDER BY (SELECT 1)), ProductDetail.id AS idProductDetail, dbo.ProductDetail.idUser, dbo.UserBC.name AS nameOfUser, dbo. Product .id AS idProduct, dbo. Product .nameProduct, dbo. Product .details, 
dbo.ProductDetail.dateCreated, dbo.ProductDetail.dateReview, UserBC.email, UserBC.adrs, UserBC.phone, UserBC.idRole, ProductDetail.IsUpBD, UserBC.Area as userArea, UserBC.City as userCity,ProductDetail.checkBuy, ProductDetail.isClick
FROM dbo.ProductDetail LEFT JOIN
 dbo. Product ON dbo. Product .id = dbo.ProductDetail.idProduct LEFT JOIN
 dbo.UserBC ON dbo.ProductDetail.idUser = dbo.UserBC.username

GO
/****** Object:  View [dbo].[ProductSentView]    Script Date: 6/25/2020 11:48:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[ProductSentView] as
select id = ROW_NUMBER() OVER (ORDER BY (SELECT 1)), ProductDetail.idProduct, Product.nameProduct, idUser, UserBC.name as nameOfUser,details, UserBC.idRole, sentNumber from 
ProductDetail
left join UserBC on ProductDetail.idUser = UserBC.username
left join Product on Product.id = ProductDetail.idProduct
left join (select idProduct, count(id) as sentNumber from ProductDetail group by idProduct) as a on ProductDetail.idProduct = a.idProduct
GO
ALTER TABLE [dbo].[ProductPlantingProcess] ADD  DEFAULT ((0)) FOR [isDelete]
GO
ALTER TABLE [dbo].[ProductPlantingProcess] ADD  DEFAULT ((0)) FOR [isUpBD]
GO
USE [master]
GO
ALTER DATABASE [QLNongSan] SET  READ_WRITE 
GO
select * from ProductTranfer
select * from ProductDetail
INSERT INTO AdminBC (username, pwd, name, birthday, email, adrs,phone)
VALUES ('admin', '0192023a7bbd73250516f069df18b500', 'Tran Hiep', '09/14/1998', 'hiepttctk40@gmail.com', N'Đà Lạt','0916390343');
INSERT INTO Roles(id,name)
VALUES (1,N'Nhà sản xuất');
INSERT INTO Roles(id,name)
VALUES (2,N'Nhà vận chuyển');
INSERT INTO Roles(id,name)
VALUES (3,N'Nhà phân phối');



alter table ProductPlantingProcess
add name nvarchar(1000) null

create table ColumnSelected
(
id int identity primary key,
idType int not null,
name nvarchar(1000)
)
go
insert into ColumnSelected values
(1,N'Gieo giống'),
(1,N'Bón phân'),
(1,N'Tưới nước'),
(1,N'Phun thuốc trừ sâu'),
(1,N'Thu hoạch'),
(2,N'Đường bộ'),
(2,N'Đường thủy')
