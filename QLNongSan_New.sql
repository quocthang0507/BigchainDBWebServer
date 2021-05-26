CREATE DATABASE [QLNongSan]
USE [QLNongSan]
GO
/****** Object:  Table [dbo].[AdminBC]    Script Date: 07/31/2020 9:04:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ColumnSelected]    Script Date: 07/31/2020 9:04:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ColumnSelected](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idType] [int] NOT NULL,
	[name] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NewNoti]    Script Date: 07/31/2020 9:04:50 AM ******/
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
/****** Object:  Table [dbo].[Product]    Script Date: 07/31/2020 9:04:50 AM ******/
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
	[number] [int] NULL,
	[imgPath] [varchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductDetail]    Script Date: 07/31/2020 9:04:50 AM ******/
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
	[numberhandling] [int] NULL,
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
/****** Object:  Table [dbo].[ProductPlantingProcess]    Script Date: 07/31/2020 9:04:50 AM ******/
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
	[isDelete] [int] NULL DEFAULT ((0)),
	[isUpBD] [int] NULL DEFAULT ((0)),
	[name] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductTranfer]    Script Date: 07/31/2020 9:04:50 AM ******/
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
	[numberTranfer] [int] NULL,
	[isClick] [int] NULL,
	[idProductDetail] [int] NULL,
	[company] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[QRManager]    Script Date: 07/31/2020 9:04:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QRManager](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idProduct] [varchar](1000) NOT NULL,
	[linkImg] [varchar](2000) NULL,
	[idUserRequest] [varchar](1000) NOT NULL,
	[amount] [int] NULL,
	[accepted] [int] NULL,
	[dateCreated] [datetime] NULL,
	[dateUpdated] [datetime] NULL,
	[isDeleted] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 07/31/2020 9:04:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[id] [int] NOT NULL,
	[name] [nvarchar](1000) NOT NULL,
	[deleted] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserBC]    Script Date: 07/31/2020 9:04:50 AM ******/
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
	[company] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[Notifications]    Script Date: 07/31/2020 9:04:50 AM ******/
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
/****** Object:  View [dbo].[ProductDetailView]    Script Date: 07/31/2020 9:04:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProductDetailView]
AS
SELECT        id = ROW_NUMBER() OVER (ORDER BY 
                             (SELECT        1)), ProductDetail.id AS idProductDetail, dbo.ProductDetail.idUser, dbo.UserBC.name AS nameOfUser, dbo. Product .id AS idProduct, dbo. Product .nameProduct, dbo. Product .details, 
dbo.ProductDetail.dateCreated, dbo.ProductDetail.dateReview, UserBC.email, UserBC.adrs, UserBC.phone, UserBC.idRole, ProductDetail.IsUpBD, UserBC.Area AS userArea, UserBC.City AS userCity, 
ProductDetail.checkBuy, ProductDetail.numberhandling, accepted = ISNULL(QRManager.accepted, - 1), dbo.UserBC.company AS company, imgPath
FROM            dbo.ProductDetail LEFT JOIN
                         dbo. Product ON dbo. Product .id = dbo.ProductDetail.idProduct LEFT JOIN
                         dbo.UserBC ON dbo.ProductDetail.idUser = dbo.UserBC.username LEFT JOIN
                         dbo.QRManager ON dbo. Product .id = dbo.QRManager.idProduct

GO
/****** Object:  View [dbo].[ProductSentView]    Script Date: 07/31/2020 9:04:50 AM ******/
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
SET IDENTITY_INSERT [dbo].[AdminBC] ON 

INSERT [dbo].[AdminBC] ([id], [username], [pwd], [name], [birthday], [email], [adrs], [phone], [dateCreated], [dateUpdate], [deleted]) VALUES (1, N'qq', N'c4ca4238a0b923820dcc509a6f75849b', N'Thanh Quoc', CAST(N'1998-05-28 00:00:00.000' AS DateTime), N'a@g.c', N'Ko', N'0905061131', CAST(N'2020-06-27 15:21:03.337' AS DateTime), CAST(N'2020-06-27 15:21:03.337' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[AdminBC] OFF
SET IDENTITY_INSERT [dbo].[ColumnSelected] ON 

INSERT [dbo].[ColumnSelected] ([id], [idType], [name]) VALUES (1, 1, N'Gieo giống')
INSERT [dbo].[ColumnSelected] ([id], [idType], [name]) VALUES (2, 1, N'Bón phân')
INSERT [dbo].[ColumnSelected] ([id], [idType], [name]) VALUES (3, 1, N'Tưới nước')
INSERT [dbo].[ColumnSelected] ([id], [idType], [name]) VALUES (4, 1, N'Phun thuốc trừ sâu')
INSERT [dbo].[ColumnSelected] ([id], [idType], [name]) VALUES (5, 1, N'Thu hoạch')
INSERT [dbo].[ColumnSelected] ([id], [idType], [name]) VALUES (6, 2, N'Đường bộ')
INSERT [dbo].[ColumnSelected] ([id], [idType], [name]) VALUES (7, 2, N'Đường thủy')
SET IDENTITY_INSERT [dbo].[ColumnSelected] OFF
SET IDENTITY_INSERT [dbo].[NewNoti] ON 

INSERT [dbo].[NewNoti] ([id], [idUser], [idProduct], [dateCreate], [detail]) VALUES (1, N'ongtam', N'CAIXANH01', CAST(N'2020-06-29 17:09:51.990' AS DateTime), NULL)
INSERT [dbo].[NewNoti] ([id], [idUser], [idProduct], [dateCreate], [detail]) VALUES (2, N'nongdan1', N'KHOAITAY01', CAST(N'2020-06-29 17:19:59.857' AS DateTime), NULL)
INSERT [dbo].[NewNoti] ([id], [idUser], [idProduct], [dateCreate], [detail]) VALUES (3, N'nongdan1', N'CHUOILABA01', CAST(N'2020-06-29 17:22:25.483' AS DateTime), NULL)
INSERT [dbo].[NewNoti] ([id], [idUser], [idProduct], [dateCreate], [detail]) VALUES (4, N'ongtam', N'DAUTAY01', CAST(N'2020-06-30 16:40:30.093' AS DateTime), NULL)
INSERT [dbo].[NewNoti] ([id], [idUser], [idProduct], [dateCreate], [detail]) VALUES (5, N'sieuthixanh', N'DAUTAY01', CAST(N'2020-06-30 17:25:24.343' AS DateTime), NULL)
INSERT [dbo].[NewNoti] ([id], [idUser], [idProduct], [dateCreate], [detail]) VALUES (6, N'giaohangtietkiem', N'DAUTAY01', CAST(N'2020-06-30 17:26:03.020' AS DateTime), NULL)
INSERT [dbo].[NewNoti] ([id], [idUser], [idProduct], [dateCreate], [detail]) VALUES (7, N'sieuthibigcdalat', N'CHUOILABA01', CAST(N'2020-06-30 21:20:17.203' AS DateTime), NULL)
INSERT [dbo].[NewNoti] ([id], [idUser], [idProduct], [dateCreate], [detail]) VALUES (8, N'giaohangtietkiem', N'CHUOILABA01', CAST(N'2020-06-30 21:21:19.923' AS DateTime), NULL)
INSERT [dbo].[NewNoti] ([id], [idUser], [idProduct], [dateCreate], [detail]) VALUES (9, N'sieuthixanh', N'KHOAITAY01', CAST(N'2020-06-30 22:32:13.310' AS DateTime), NULL)
INSERT [dbo].[NewNoti] ([id], [idUser], [idProduct], [dateCreate], [detail]) VALUES (10, N'giaohangnhanh', N'KHOAITAY01', CAST(N'2020-06-30 22:34:18.147' AS DateTime), NULL)
INSERT [dbo].[NewNoti] ([id], [idUser], [idProduct], [dateCreate], [detail]) VALUES (11, N'sieuthixanh', N'KHOAITAY02', CAST(N'2020-06-30 22:32:13.310' AS DateTime), NULL)
INSERT [dbo].[NewNoti] ([id], [idUser], [idProduct], [dateCreate], [detail]) VALUES (12, N'giaohangnhanh', N'KHOAITAY02', CAST(N'2020-06-30 22:34:18.147' AS DateTime), NULL)
INSERT [dbo].[NewNoti] ([id], [idUser], [idProduct], [dateCreate], [detail]) VALUES (1011, N'nongdan1', N'RAU01', CAST(N'2020-07-26 14:00:00.613' AS DateTime), NULL)
INSERT [dbo].[NewNoti] ([id], [idUser], [idProduct], [dateCreate], [detail]) VALUES (1012, N'nongdan1', N'RAU01', CAST(N'2020-07-26 14:20:31.293' AS DateTime), NULL)
INSERT [dbo].[NewNoti] ([id], [idUser], [idProduct], [dateCreate], [detail]) VALUES (1013, N'nongdan1', N'RAU01', CAST(N'2020-07-26 14:52:10.933' AS DateTime), NULL)
INSERT [dbo].[NewNoti] ([id], [idUser], [idProduct], [dateCreate], [detail]) VALUES (1014, N'nongdan1', N'RAU02', CAST(N'2020-07-26 14:55:04.593' AS DateTime), NULL)
INSERT [dbo].[NewNoti] ([id], [idUser], [idProduct], [dateCreate], [detail]) VALUES (1015, N'daihocdalat', N'NAMDONGCO01', CAST(N'2020-07-29 21:42:16.037' AS DateTime), NULL)
INSERT [dbo].[NewNoti] ([id], [idUser], [idProduct], [dateCreate], [detail]) VALUES (1016, N'langfarm', N'DAUTAYMYDA01', CAST(N'2020-07-29 21:44:35.247' AS DateTime), NULL)
INSERT [dbo].[NewNoti] ([id], [idUser], [idProduct], [dateCreate], [detail]) VALUES (1017, N'langfarm2', N'KHOAITAY03', CAST(N'2020-07-30 08:36:33.033' AS DateTime), NULL)
INSERT [dbo].[NewNoti] ([id], [idUser], [idProduct], [dateCreate], [detail]) VALUES (1018, N'langfarm3', N'KHOAILANG01', CAST(N'2020-07-30 08:41:54.027' AS DateTime), NULL)
INSERT [dbo].[NewNoti] ([id], [idUser], [idProduct], [dateCreate], [detail]) VALUES (1019, N'ongtam', N'RAUTEST01', CAST(N'2020-07-30 16:32:21.503' AS DateTime), NULL)
INSERT [dbo].[NewNoti] ([id], [idUser], [idProduct], [dateCreate], [detail]) VALUES (1020, N'sieuthibigcdalat', N'KHOAILANG01', CAST(N'2020-07-30 16:57:03.050' AS DateTime), NULL)
INSERT [dbo].[NewNoti] ([id], [idUser], [idProduct], [dateCreate], [detail]) VALUES (1021, N'giaohangnhanh', N'KHOAILANG01', CAST(N'2020-07-30 17:02:58.620' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[NewNoti] OFF
INSERT [dbo].[Product] ([id], [nameProduct], [details], [isDeleted], [number], [imgPath]) VALUES (N'CAIXANH01', N'Cải bẹ xanh', N'Rau cải bẹ xanh có chứa rất nhiều các loại vitamin A, B, C, K, axit nicotic, catoten, abumin… Nó còn được các chuyên gia dinh dưỡng khuyên dùng vì có nhiều lợi ích đối với sức khỏe cũng như có tác dụng phòng chống bệnh tật.', 0, 2000, NULL)
INSERT [dbo].[Product] ([id], [nameProduct], [details], [isDeleted], [number], [imgPath]) VALUES (N'CHUOILABA01', N'Chuối Laba', N'Loại chuối ngon, trái bự. Mỗi buồng cho ra hơn chục nải, nặng trên dưới 30 kg, quả lại thơm ngon, bảo quản được lâu nên được người tiêu dùng rất ưa chuộng. Đặc biệt, bất kể mùa đông hay mùa hạ, màu sắc trái chín lúc nào cũng vàng tươi như dùng hoá chất bảo vệ.', 0, 1500, NULL)
INSERT [dbo].[Product] ([id], [nameProduct], [details], [isDeleted], [number], [imgPath]) VALUES (N'DAUTAY01', N'Dâu tây mỹ đá', N'Dâu tây Mỹ Đá là giống dâu truyền thống được trồng ngoài trời và gắn liền với bao thế hệ trồng dâu ở Đà Lạt.', 0, 800, NULL)
INSERT [dbo].[Product] ([id], [nameProduct], [details], [isDeleted], [number], [imgPath]) VALUES (N'DAUTAYMYDA01', N'Dâu tây mỹ đá', N'Dâu tây Mỹ Đá (danh pháp khoa học: Fragaria) hay còn gọi là dâu đất là một chi thực vật hạt kín và loài thực vật có hoa thuộc họ Hoa hồng (Rosaceae) cho quả được nhiều người ưa chuộng. Dâu tây xuất xứ từ châu Mỹ và được các nhà làm vườn châu Âu cho lai tạo vào thế kỷ 18 để tạo nên giống dâu tây được trồng rộng rãi hiện nay. Loài này được (Weston) Duchesne miêu tả khoa học đầu tiên năm 1788', 0, 3000, N'/img/productImg/langfarm_29072020_094435_dautaymyda.jpg')
INSERT [dbo].[Product] ([id], [nameProduct], [details], [isDeleted], [number], [imgPath]) VALUES (N'KHOAILANG01', N'khoai lang', N'Khoai lang là một loài cây nông nghiệp với các rễ củ lớn, chứa nhiều tinh bột, có vị ngọt, được gọi là củ khoai lang và nó là một nguồn cung cấp rau ăn củ quan trọng, được sử dụng trong vai trò của cả rau lẫn lương thực. Các lá non và thân non cũng được sử dụng như một loại rau. Khoai lang có quan hệ họ hàng xa với khoai tây (Solanum tuberosum) có nguồn gốc Nam Mỹ và quan hệ họ hàng rất xa với khoai mỡ (một số loài trong chi Dioscorea) là các loài có nguồn gốc từ châu Phi và châu Á.', 0, 3000, N'/img/productImg/langfarm3_30072020_084153_khoai_lang.jpg')
INSERT [dbo].[Product] ([id], [nameProduct], [details], [isDeleted], [number], [imgPath]) VALUES (N'KHOAITAY01', N'Khoai tây Đà Lạt', N'Khoai tây là loại cây nông nghiệp ngắn ngày trồng lấy củ chứa rất nhiều tinh bột thích hợp với khí hậu mát mẻ do đó chúng được trồng chủ yếu tại Đà lạt.', 0, 3000, NULL)
INSERT [dbo].[Product] ([id], [nameProduct], [details], [isDeleted], [number], [imgPath]) VALUES (N'KHOAITAY02', N'Khoai tây Đà Lạt', N'Khoai tây là loại cây nông nghiệp ngắn ngày trồng lấy củ chứa rất nhiều tinh bột thích hợp với khí hậu mát mẻ do đó chúng được trồng chủ yếu tại Đà lạt.', 0, 3000, NULL)
INSERT [dbo].[Product] ([id], [nameProduct], [details], [isDeleted], [number], [imgPath]) VALUES (N'KHOAITAY03', N'Khoai tây', N'Khoai tây (danh pháp hai phần: Solanum tuberosum), thuộc họ Cà (Solanaceae). Khoai tây là loài cây nông nghiệp ngắn ngày, trồng lấy củ chứa tinh bột. Chúng là loại cây trồng lấy củ rộng rãi nhất thế giới và là loại cây trồng phổ biến thứ tư về mặt sản lượng tươi - xếp sau lúa, lúa mì và ngô. Lưu trữ khoai tây dài ngày đòi hỏi bảo quản trong điều kiện lạnh.', 0, 4000, N'/img/productImg/langfarm2_30072020_083620_cay-khoai-tay.jpg')
INSERT [dbo].[Product] ([id], [nameProduct], [details], [isDeleted], [number], [imgPath]) VALUES (N'NAMDONGCO01', N'Nấm hương Shiitake', N'Nấm hương hay còn gọi là nấm đông cô (danh pháp hai phần: Lentinula edodes) là một loại nấm ăn có nguồn gốc bản địa ở Đông Á.', 0, 30, N'/img/productImg/daihocdalat_29072020_094215_Lentinula_edodes_20101113_a.jpg')
SET IDENTITY_INSERT [dbo].[ProductDetail] ON 

INSERT [dbo].[ProductDetail] ([id], [idUser], [idProduct], [dateCreated], [dateReview], [isDeleted], [IsUpBD], [checkBuy], [idRole], [numberhandling]) VALUES (1, N'ongtam', N'CAIXANH01', CAST(N'2020-05-21 00:00:00.000' AS DateTime), CAST(N'2020-06-25 00:00:00.000' AS DateTime), 0, 0, NULL, 1, 2000)
INSERT [dbo].[ProductDetail] ([id], [idUser], [idProduct], [dateCreated], [dateReview], [isDeleted], [IsUpBD], [checkBuy], [idRole], [numberhandling]) VALUES (3, N'nongdan1', N'CHUOILABA01', CAST(N'2020-03-01 00:00:00.000' AS DateTime), CAST(N'2020-06-26 00:00:00.000' AS DateTime), 0, 0, NULL, 1, 0)
INSERT [dbo].[ProductDetail] ([id], [idUser], [idProduct], [dateCreated], [dateReview], [isDeleted], [IsUpBD], [checkBuy], [idRole], [numberhandling]) VALUES (4, N'ongtam', N'DAUTAY01', CAST(N'2020-04-01 00:00:00.000' AS DateTime), CAST(N'2020-06-01 00:00:00.000' AS DateTime), 0, 0, NULL, 1, 0)
INSERT [dbo].[ProductDetail] ([id], [idUser], [idProduct], [dateCreated], [dateReview], [isDeleted], [IsUpBD], [checkBuy], [idRole], [numberhandling]) VALUES (5, N'sieuthixanh', N'DAUTAY01', CAST(N'2020-06-03 00:00:00.000' AS DateTime), CAST(N'2020-06-04 00:00:00.000' AS DateTime), 0, 0, 2, 3, 800)
INSERT [dbo].[ProductDetail] ([id], [idUser], [idProduct], [dateCreated], [dateReview], [isDeleted], [IsUpBD], [checkBuy], [idRole], [numberhandling]) VALUES (6, N'giaohangtietkiem', N'DAUTAY01', CAST(N'2020-06-03 00:00:00.000' AS DateTime), CAST(N'2020-06-04 00:00:00.000' AS DateTime), 0, 0, 2, 2, 800)
INSERT [dbo].[ProductDetail] ([id], [idUser], [idProduct], [dateCreated], [dateReview], [isDeleted], [IsUpBD], [checkBuy], [idRole], [numberhandling]) VALUES (7, N'sieuthibigcdalat', N'CHUOILABA01', CAST(N'2020-06-28 00:00:00.000' AS DateTime), CAST(N'2020-06-29 00:00:00.000' AS DateTime), 0, 0, 2, 3, 1500)
INSERT [dbo].[ProductDetail] ([id], [idUser], [idProduct], [dateCreated], [dateReview], [isDeleted], [IsUpBD], [checkBuy], [idRole], [numberhandling]) VALUES (8, N'giaohangtietkiem', N'CHUOILABA01', CAST(N'2020-06-28 00:00:00.000' AS DateTime), CAST(N'2020-06-29 00:00:00.000' AS DateTime), 0, 0, 2, 2, 1500)
INSERT [dbo].[ProductDetail] ([id], [idUser], [idProduct], [dateCreated], [dateReview], [isDeleted], [IsUpBD], [checkBuy], [idRole], [numberhandling]) VALUES (9, N'nongdan1', N'KHOAITAY01', CAST(N'2020-04-01 00:00:00.000' AS DateTime), CAST(N'2020-06-28 00:00:00.000' AS DateTime), 0, 0, NULL, 1, 0)
INSERT [dbo].[ProductDetail] ([id], [idUser], [idProduct], [dateCreated], [dateReview], [isDeleted], [IsUpBD], [checkBuy], [idRole], [numberhandling]) VALUES (10, N'sieuthixanh', N'KHOAITAY01', CAST(N'2020-06-29 00:00:00.000' AS DateTime), CAST(N'2020-06-30 00:00:00.000' AS DateTime), 0, 0, 2, 3, 3000)
INSERT [dbo].[ProductDetail] ([id], [idUser], [idProduct], [dateCreated], [dateReview], [isDeleted], [IsUpBD], [checkBuy], [idRole], [numberhandling]) VALUES (11, N'giaohangnhanh', N'KHOAITAY01', CAST(N'2020-06-29 00:00:00.000' AS DateTime), CAST(N'2020-06-30 00:00:00.000' AS DateTime), 0, 0, 2, 2, 3000)
INSERT [dbo].[ProductDetail] ([id], [idUser], [idProduct], [dateCreated], [dateReview], [isDeleted], [IsUpBD], [checkBuy], [idRole], [numberhandling]) VALUES (12, N'nongdan1', N'KHOAITAY02', CAST(N'2020-04-01 00:00:00.000' AS DateTime), CAST(N'2020-06-28 00:00:00.000' AS DateTime), 0, 0, NULL, 1, 0)
INSERT [dbo].[ProductDetail] ([id], [idUser], [idProduct], [dateCreated], [dateReview], [isDeleted], [IsUpBD], [checkBuy], [idRole], [numberhandling]) VALUES (13, N'sieuthixanh', N'KHOAITAY02', CAST(N'2020-06-29 00:00:00.000' AS DateTime), CAST(N'2020-06-30 00:00:00.000' AS DateTime), 0, 0, 2, 3, 3000)
INSERT [dbo].[ProductDetail] ([id], [idUser], [idProduct], [dateCreated], [dateReview], [isDeleted], [IsUpBD], [checkBuy], [idRole], [numberhandling]) VALUES (14, N'giaohangnhanh', N'KHOAITAY02', CAST(N'2020-06-29 00:00:00.000' AS DateTime), CAST(N'2020-06-30 00:00:00.000' AS DateTime), 0, 0, 2, 2, 3000)
INSERT [dbo].[ProductDetail] ([id], [idUser], [idProduct], [dateCreated], [dateReview], [isDeleted], [IsUpBD], [checkBuy], [idRole], [numberhandling]) VALUES (1016, N'daihocdalat', N'NAMDONGCO01', CAST(N'2020-05-01 00:00:00.000' AS DateTime), CAST(N'2020-07-29 00:00:00.000' AS DateTime), 0, 0, NULL, 1, 30)
INSERT [dbo].[ProductDetail] ([id], [idUser], [idProduct], [dateCreated], [dateReview], [isDeleted], [IsUpBD], [checkBuy], [idRole], [numberhandling]) VALUES (1017, N'langfarm', N'DAUTAYMYDA01', CAST(N'2020-04-28 00:00:00.000' AS DateTime), CAST(N'2020-07-27 00:00:00.000' AS DateTime), 0, 0, NULL, 1, 3000)
INSERT [dbo].[ProductDetail] ([id], [idUser], [idProduct], [dateCreated], [dateReview], [isDeleted], [IsUpBD], [checkBuy], [idRole], [numberhandling]) VALUES (1018, N'langfarm2', N'KHOAITAY03', CAST(N'2020-04-01 00:00:00.000' AS DateTime), CAST(N'2020-07-30 00:00:00.000' AS DateTime), 0, 0, NULL, 1, 4000)
INSERT [dbo].[ProductDetail] ([id], [idUser], [idProduct], [dateCreated], [dateReview], [isDeleted], [IsUpBD], [checkBuy], [idRole], [numberhandling]) VALUES (1019, N'langfarm3', N'KHOAILANG01', CAST(N'2020-04-16 00:00:00.000' AS DateTime), CAST(N'2020-07-06 00:00:00.000' AS DateTime), 0, 0, NULL, 1, 0)
INSERT [dbo].[ProductDetail] ([id], [idUser], [idProduct], [dateCreated], [dateReview], [isDeleted], [IsUpBD], [checkBuy], [idRole], [numberhandling]) VALUES (1021, N'sieuthibigcdalat', N'KHOAILANG01', CAST(N'2020-07-30 00:00:00.000' AS DateTime), CAST(N'2020-07-31 00:00:00.000' AS DateTime), 0, 0, 2, 3, 3000)
INSERT [dbo].[ProductDetail] ([id], [idUser], [idProduct], [dateCreated], [dateReview], [isDeleted], [IsUpBD], [checkBuy], [idRole], [numberhandling]) VALUES (1022, N'giaohangnhanh', N'KHOAILANG01', CAST(N'2020-07-30 00:00:00.000' AS DateTime), CAST(N'2020-07-31 00:00:00.000' AS DateTime), 0, 0, 2, 2, 3000)
SET IDENTITY_INSERT [dbo].[ProductDetail] OFF
SET IDENTITY_INSERT [dbo].[ProductPlantingProcess] ON 

INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (1, N'CAIXANH01', N'ongtam', N'Gieo hạt cải trực tiếp lên giá thể đất sét nung (viên sỏi nhẹ) trong khay rau Aquaponics', CAST(N'2020-05-21 00:00:00.000' AS DateTime), CAST(N'2020-05-21 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:10:26.997' AS DateTime), 0, 0, N'Gieo giống')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (2, N'CAIXANH01', N'ongtam', N'Tưới nước ngày 2 lần vào lúc sáng sớm và chiều tối.', CAST(N'2020-05-21 00:00:00.000' AS DateTime), CAST(N'2020-05-21 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:11:59.127' AS DateTime), 0, 0, N'Tưới nước')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (3, N'CAIXANH01', N'ongtam', N'Tưới nước ngày 2 lần vào lúc sáng sớm và chiều tối.', CAST(N'2020-05-22 00:00:00.000' AS DateTime), CAST(N'2020-05-22 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:12:17.077' AS DateTime), 0, 0, N'Tưới nước')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (4, N'CAIXANH01', N'ongtam', N'Tưới nước ngày 2 lần vào lúc sáng sớm và chiều tối.', CAST(N'2020-05-23 00:00:00.000' AS DateTime), CAST(N'2020-05-23 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:12:32.840' AS DateTime), 0, 0, N'Tưới nước')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (5, N'CAIXANH01', N'ongtam', N'Tưới nước ngày 2 lần vào lúc sáng sớm và chiều tối.', CAST(N'2020-05-25 00:00:00.000' AS DateTime), CAST(N'2020-05-25 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:12:43.807' AS DateTime), 0, 0, N'Tưới nước')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (6, N'CAIXANH01', N'ongtam', N'cây đã hồi xanh và có nhu cầu phát triển bón thúc lần 1 bằng phân bò', CAST(N'2020-06-23 00:00:00.000' AS DateTime), CAST(N'2020-06-23 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:13:17.793' AS DateTime), 0, 0, N'Bón phân')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (7, N'CAIXANH01', N'ongtam', N'Bón thúc lần 1 bằng phân gà', CAST(N'2020-05-30 00:00:00.000' AS DateTime), CAST(N'2020-05-30 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:13:59.957' AS DateTime), 0, 0, N'Bón phân')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (8, N'CAIXANH01', N'ongtam', N'Bón thúc lần 1 bằng phân cá', CAST(N'2020-06-06 00:00:00.000' AS DateTime), CAST(N'2020-06-06 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:14:17.520' AS DateTime), 0, 0, N'Bón phân')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (9, N'CAIXANH01', N'ongtam', N'Bón thúc lần 1 bằng phân dê', CAST(N'2020-06-05 00:00:00.000' AS DateTime), CAST(N'2020-06-05 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:14:44.767' AS DateTime), 0, 0, N'Bón phân')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (10, N'CAIXANH01', N'ongtam', N'Rau đã lớn đủ để thu hoạch', CAST(N'2020-06-26 00:00:00.000' AS DateTime), CAST(N'2020-06-26 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:16:19.217' AS DateTime), 0, 0, N'Thu hoạch')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (18, N'CHUOILABA01', N'nongdan1', N'Giống chuối tốt, thường được mọi người khen', CAST(N'2020-03-01 00:00:00.000' AS DateTime), NULL, CAST(N'2020-06-29 17:57:11.487' AS DateTime), 0, 0, N'Gieo giống')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (19, N'CHUOILABA01', N'nongdan1', N'Tưới hết vườn chuối', CAST(N'2020-03-02 00:00:00.000' AS DateTime), CAST(N'2020-03-02 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:57:35.893' AS DateTime), 0, 0, N'Tưới nước')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (20, N'CHUOILABA01', N'nongdan1', N'Bón phân Kali: Chứa nhiều trong thân giả, thân ngầm, vỏ quả và nhiều nhất ở các đỉnh sinh trưởng. Kali có ảnh hưởng rất lớn đến sản lượng và phẩm chất quả chuối.', CAST(N'2020-03-04 00:00:00.000' AS DateTime), CAST(N'2020-03-04 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:58:13.113' AS DateTime), 0, 0, N'Bón phân')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (21, N'CHUOILABA01', N'nongdan1', N'Bón phân lân: Ảnh hưởng không rõ bằng đạm và kali, nhưng bón đủ lân lá sẽ cứng, chống được nấm bệnh, lân giúp cho sự phát triển của rễ.', CAST(N'2020-03-23 00:00:00.000' AS DateTime), CAST(N'2020-03-23 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:59:01.887' AS DateTime), 0, 0, N'Bón phân')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (22, N'DAUTAY01', N'ongtam', N'Qua 2 bước trước tiến hành gieo hạt vào đất sạch và ẩm. Chậu hay khay đựng hạt cần được để khô ráo thoáng mát, có nắng tốt. Tưới nước một ngày một lần vào buổi chiều tối.', CAST(N'2020-04-01 00:00:00.000' AS DateTime), CAST(N'2020-04-01 00:00:00.000' AS DateTime), CAST(N'2020-06-30 16:41:21.290' AS DateTime), 0, 0, N'Gieo giống')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (23, N'DAUTAY01', N'ongtam', N'Bón phân vi sinh', CAST(N'2020-04-02 00:00:00.000' AS DateTime), CAST(N'2020-04-02 00:00:00.000' AS DateTime), CAST(N'2020-06-30 16:42:07.687' AS DateTime), 0, 0, N'Bón phân')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (24, N'DAUTAY01', N'ongtam', N'Tưới nước cho cây 2 lần vào sáng và chiều khi hết nắng. Tưới đều ẩm đất, sử dụng các loại nước sạch.', CAST(N'2020-04-01 00:00:00.000' AS DateTime), CAST(N'2020-04-01 00:00:00.000' AS DateTime), CAST(N'2020-06-30 16:42:56.023' AS DateTime), 0, 0, N'Tưới nước')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (25, N'DAUTAY01', N'ongtam', N'Phun thuốc trừ sâu loại thuốc trừ nhện Nissorun', CAST(N'2020-04-16 00:00:00.000' AS DateTime), CAST(N'2020-04-16 00:00:00.000' AS DateTime), CAST(N'2020-06-30 16:46:26.673' AS DateTime), 0, 0, N'Phun thuốc trừ sâu')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (26, N'DAUTAY01', N'ongtam', N'Dâu tây đã đỏ và có thể thu hoạch', CAST(N'2020-06-01 00:00:00.000' AS DateTime), CAST(N'2020-06-01 00:00:00.000' AS DateTime), CAST(N'2020-06-30 16:47:02.783' AS DateTime), 0, 0, N'Thu hoạch')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (27, N'KHOAITAY01', N'nongdan1', N'Giống Đà Lạt ngon bổ rẻ', CAST(N'2020-04-01 00:00:00.000' AS DateTime), CAST(N'2020-04-01 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:23:44.617' AS DateTime), 0, 0, N'Gieo giống')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (28, N'KHOAITAY01', N'nongdan1', N'Lượng phân bón tính chung cho 01 ha là 40m3 phân chuồng hoai mục chủ yếu là phân cá và phân bò, 800-1000 kg vôi, 800-1000 kg phân hữu cơ vi sinh, 150 kg N  (330 kg Urê), 150kg P2O5 (940kg Super lân), 180kg K2O (330 kg kali) và 40 kg MgSO4.', CAST(N'2020-04-08 00:00:00.000' AS DateTime), CAST(N'2020-04-08 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:25:34.737' AS DateTime), 0, 0, N'Bón phân')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (29, N'KHOAITAY01', N'nongdan1', N'Lượng phân bón tính chung cho 01 ha là 40m3 phân chuồng hoai mục chủ yếu là phân cá và phân bò, 800-1000 kg vôi, 800-1000 kg phân hữu cơ vi sinh, 150 kg N  (330 kg Urê), 150kg P2O5 (940kg Super lân), 180kg K2O (330 kg kali) và 40 kg MgSO4.', CAST(N'2020-05-02 00:00:00.000' AS DateTime), CAST(N'2020-05-02 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:26:22.177' AS DateTime), 0, 0, N'Bón phân')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (30, N'KHOAITAY01', N'nongdan1', N'Tưới nửa vườn', CAST(N'2020-04-03 00:00:00.000' AS DateTime), CAST(N'2020-04-03 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:27:16.897' AS DateTime), 0, 0, N'Tưới nước')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (31, N'KHOAITAY01', N'nongdan1', N'Tưới nửa vườn', CAST(N'2020-04-04 00:00:00.000' AS DateTime), CAST(N'2020-04-04 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:27:40.993' AS DateTime), 0, 0, N'Tưới nước')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (32, N'KHOAITAY01', N'nongdan1', N'Hòng trừ một số loại sâu hại chính (Ruồi đục lá, rầy, rệp): Áp dụng biện pháp phòng trừ tổng hợp (IPM), vệ sinh đồng ruộng, tiêu hủy ký chủ khác xung quanh, dùng bẫy vàng, cắt bỏ lá bị nhiễm. Sử dụng các loại thuốc Polythrin.', CAST(N'2020-04-15 00:00:00.000' AS DateTime), CAST(N'2020-04-15 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:28:36.810' AS DateTime), 0, 0, N'Phun thuốc trừ sâu')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (33, N'KHOAITAY01', N'nongdan1', N'Thu hoạch được tổng cộng 3 tấn', CAST(N'2020-06-28 00:00:00.000' AS DateTime), CAST(N'2020-06-28 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:56:36.470' AS DateTime), 0, 0, N'Thu hoạch')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (34, N'KHOAITAY02', N'nongdan1', N'Giống Đà Lạt ngon bổ rẻ', CAST(N'2020-04-01 00:00:00.000' AS DateTime), CAST(N'2020-04-01 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:23:44.617' AS DateTime), 0, 0, N'Gieo giống')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (35, N'KHOAITAY02', N'nongdan1', N'Lượng phân bón tính chung cho 01 ha là 40m3 phân chuồng hoai mục chủ yếu là phân cá và phân bò, 800-1000 kg vôi, 800-1000 kg phân hữu cơ vi sinh, 150 kg N  (330 kg Urê), 150kg P2O5 (940kg Super lân), 180kg K2O (330 kg kali) và 40 kg MgSO4.', CAST(N'2020-04-08 00:00:00.000' AS DateTime), CAST(N'2020-04-08 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:25:34.737' AS DateTime), 0, 0, N'Bón phân')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (36, N'KHOAITAY02', N'nongdan1', N'Lượng phân bón tính chung cho 01 ha là 40m3 phân chuồng hoai mục chủ yếu là phân cá và phân bò, 800-1000 kg vôi, 800-1000 kg phân hữu cơ vi sinh, 150 kg N  (330 kg Urê), 150kg P2O5 (940kg Super lân), 180kg K2O (330 kg kali) và 40 kg MgSO4.', CAST(N'2020-05-02 00:00:00.000' AS DateTime), CAST(N'2020-05-02 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:26:22.177' AS DateTime), 0, 0, N'Bón phân')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (37, N'KHOAITAY02', N'nongdan1', N'Tưới nửa vườn', CAST(N'2020-04-03 00:00:00.000' AS DateTime), CAST(N'2020-04-03 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:27:16.897' AS DateTime), 0, 0, N'Tưới nước')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (38, N'KHOAITAY02', N'nongdan1', N'Tưới nửa vườn', CAST(N'2020-04-04 00:00:00.000' AS DateTime), CAST(N'2020-04-04 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:27:40.993' AS DateTime), 0, 0, N'Tưới nước')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (39, N'KHOAITAY02', N'nongdan1', N'Hòng trừ một số loại sâu hại chính (Ruồi đục lá, rầy, rệp): Áp dụng biện pháp phòng trừ tổng hợp (IPM), vệ sinh đồng ruộng, tiêu hủy ký chủ khác xung quanh, dùng bẫy vàng, cắt bỏ lá bị nhiễm. Sử dụng các loại thuốc Polythrin.', CAST(N'2020-04-15 00:00:00.000' AS DateTime), CAST(N'2020-04-15 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:28:36.810' AS DateTime), 0, 0, N'Phun thuốc trừ sâu')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (40, N'KHOAITAY02', N'nongdan1', N'Thu hoạch được tổng cộng 3 tấn', CAST(N'2020-06-28 00:00:00.000' AS DateTime), CAST(N'2020-06-28 00:00:00.000' AS DateTime), CAST(N'2020-06-29 17:56:36.470' AS DateTime), 0, 0, N'Thu hoạch')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (1034, N'NAMDONGCO01', N'daihocdalat', N'Phun sương tạo ẩm cho độ ẩm đạt 80 90%', CAST(N'2020-05-01 00:00:00.000' AS DateTime), CAST(N'2020-05-01 00:00:00.000' AS DateTime), CAST(N'2020-07-29 21:52:56.773' AS DateTime), 0, 0, N'Tưới nước')
INSERT [dbo].[ProductPlantingProcess] ([id], [idProduct], [idUser], [details], [dateBegin], [dateEnd], [dateCreated], [isDelete], [isUpBD], [name]) VALUES (1035, N'NAMDONGCO01', N'daihocdalat', N'Phun sương tạo ẩm cho độ ẩm đạt 80 90%', CAST(N'2020-07-27 00:00:00.000' AS DateTime), CAST(N'2020-07-27 00:00:00.000' AS DateTime), CAST(N'2020-07-29 21:53:18.287' AS DateTime), 0, 0, N'Tưới nước')
SET IDENTITY_INSERT [dbo].[ProductPlantingProcess] OFF
SET IDENTITY_INSERT [dbo].[ProductTranfer] ON 

INSERT [dbo].[ProductTranfer] ([id], [idProduct], [nameProduct], [nameUser], [detail], [idUser], [numberTranfer], [isClick], [idProductDetail], [company]) VALUES (1, N'DAUTAY01', N'Dâu tây mỹ đá', N'sieuthixanh', NULL, N'giaohangtietkiem', 800, 1, 5, N'Giao Hàng Tiết Kiệm')
INSERT [dbo].[ProductTranfer] ([id], [idProduct], [nameProduct], [nameUser], [detail], [idUser], [numberTranfer], [isClick], [idProductDetail], [company]) VALUES (2, N'CHUOILABA01', N'Chuối Laba', N'sieuthibigcdalat', NULL, N'giaohangtietkiem', 1500, 1, 7, N'Giao Hàng Tiết Kiệm')
INSERT [dbo].[ProductTranfer] ([id], [idProduct], [nameProduct], [nameUser], [detail], [idUser], [numberTranfer], [isClick], [idProductDetail], [company]) VALUES (3, N'KHOAITAY01', N'Khoai tây Đà Lạt', N'sieuthixanh', N'Giao hàng quen thuộc', N'giaohangnhanh', 3000, 1, 10, N'Giao Hàng Nhanh')
INSERT [dbo].[ProductTranfer] ([id], [idProduct], [nameProduct], [nameUser], [detail], [idUser], [numberTranfer], [isClick], [idProductDetail], [company]) VALUES (4, N'KHOAITAY02', N'Khoai tây Đà Lạt', N'sieuthixanh', N'Giao hàng quen thuộc', N'giaohangnhanh', 3000, 1, 10, N'Giao Hàng Nhanh')
INSERT [dbo].[ProductTranfer] ([id], [idProduct], [nameProduct], [nameUser], [detail], [idUser], [numberTranfer], [isClick], [idProductDetail], [company]) VALUES (1004, N'KHOAILANG01', N'khoai lang', N'sieuthibigcdalat', NULL, N'giaohangnhanh', 3000, 1, 1021, N'Giao Hàng Nhanh')
SET IDENTITY_INSERT [dbo].[ProductTranfer] OFF
SET IDENTITY_INSERT [dbo].[UserBC] ON 

INSERT [dbo].[UserBC] ([id], [username], [pwd], [Area], [City], [name], [birthday], [email], [adrs], [phone], [idRole], [active], [dateCreated], [dateUpdate], [deleted], [company]) VALUES (1, N'nongdan1', N'c4ca4238a0b923820dcc509a6f75849b', N'Lâm Đồng', N'Thành Phố Đà Lạt', N'nongdan1', CAST(N'1995-04-22 00:00:00.000' AS DateTime), N'nongdan1@gmail.com', N'92 CBQ', N'0905061131', 1, 1, CAST(N'2020-06-29 16:52:08.147' AS DateTime), CAST(N'2020-06-29 16:52:08.147' AS DateTime), 0, N'Vườn chuối LaBa')
INSERT [dbo].[UserBC] ([id], [username], [pwd], [Area], [City], [name], [birthday], [email], [adrs], [phone], [idRole], [active], [dateCreated], [dateUpdate], [deleted], [company]) VALUES (2, N'giaohangtietkiem', N'c4ca4238a0b923820dcc509a6f75849b', N'Lâm Đồng', N'Thành Phố Bảo Lộc', N'giaohangtietkiem', CAST(N'2005-12-05 00:00:00.000' AS DateTime), N'vanchuyen1@gmail.com', N'88 Xô Viết', N'0905061131', 2, 1, CAST(N'2020-06-29 16:59:53.077' AS DateTime), CAST(N'2020-06-29 16:59:53.077' AS DateTime), 0, N'Giao Hàng Tiết Kiệm')
INSERT [dbo].[UserBC] ([id], [username], [pwd], [Area], [City], [name], [birthday], [email], [adrs], [phone], [idRole], [active], [dateCreated], [dateUpdate], [deleted], [company]) VALUES (3, N'giaohangnhanh', N'c4ca4238a0b923820dcc509a6f75849b', N'Vĩnh Long', N'Huyện Vũng Liêm', N'giaohangnhanh', CAST(N'2010-05-05 00:00:00.000' AS DateTime), N'giaohangnhanh@gmail.com', N'213 Phan Đình Phùng', N'0908070655', 2, 1, CAST(N'2020-06-29 17:01:02.020' AS DateTime), CAST(N'2020-06-29 17:01:02.020' AS DateTime), 0, N'Giao Hàng Nhanh')
INSERT [dbo].[UserBC] ([id], [username], [pwd], [Area], [City], [name], [birthday], [email], [adrs], [phone], [idRole], [active], [dateCreated], [dateUpdate], [deleted], [company]) VALUES (4, N'sieuthixanh', N'c4ca4238a0b923820dcc509a6f75849b', N'Lâm Đồng', N'Thành Phố Đà Lạt', N'sieuthixanh', CAST(N'2015-05-22 00:00:00.000' AS DateTime), N'cuahangrausach@gmail.com', N'422 Hai Bà Trưng', N'0807060511', 3, 1, CAST(N'2020-06-29 17:02:54.007' AS DateTime), CAST(N'2020-06-29 17:02:54.007' AS DateTime), 0, N'Siêu thị Xanh')
INSERT [dbo].[UserBC] ([id], [username], [pwd], [Area], [City], [name], [birthday], [email], [adrs], [phone], [idRole], [active], [dateCreated], [dateUpdate], [deleted], [company]) VALUES (5, N'sieuthibigcdalat', N'c4ca4238a0b923820dcc509a6f75849b', N'Lâm Đồng', N'Thành Phố Đà Lạt', N'sieuthibigcdalat', CAST(N'2011-03-31 00:00:00.000' AS DateTime), N'bigc@gmail.com', N'Quảng Trường Lâm Viên, Đường Trần Quốc Toản, Phường 1', N'0263 3545 088', 3, 1, CAST(N'2020-06-29 17:04:24.903' AS DateTime), CAST(N'2020-06-29 17:04:24.903' AS DateTime), 0, N'Big C Đà Lạt')
INSERT [dbo].[UserBC] ([id], [username], [pwd], [Area], [City], [name], [birthday], [email], [adrs], [phone], [idRole], [active], [dateCreated], [dateUpdate], [deleted], [company]) VALUES (6, N'ongtam', N'c4ca4238a0b923820dcc509a6f75849b', N'Lâm Đồng', N'Thành Phố Đà Lạt', N'ongtam', CAST(N'1988-08-08 00:00:00.000' AS DateTime), N'ongtam@gmail.com', N'342 Nguyễn Trãi', N'0888888888', 1, 1, CAST(N'2020-06-29 17:06:39.157' AS DateTime), CAST(N'2020-06-29 17:06:39.157' AS DateTime), 0, N'Vườn nhà ông Tám')
INSERT [dbo].[UserBC] ([id], [username], [pwd], [Area], [City], [name], [birthday], [email], [adrs], [phone], [idRole], [active], [dateCreated], [dateUpdate], [deleted], [company]) VALUES (7, N'daihocdalat', N'c4ca4238a0b923820dcc509a6f75849b', N'Lâm Đồng', N'Thành Phố Đà Lạt', N'daihocdalat', CAST(N'1997-03-14 00:00:00.000' AS DateTime), N'vnncnc@dlu.edu.vn', N'1 phù đổng thiên vương', N'0912345678', 1, 1, CAST(N'2020-07-29 21:38:11.527' AS DateTime), CAST(N'2020-07-29 21:38:11.527' AS DateTime), 0, N'Viện nông nghiệp công nghệ cao')
INSERT [dbo].[UserBC] ([id], [username], [pwd], [Area], [City], [name], [birthday], [email], [adrs], [phone], [idRole], [active], [dateCreated], [dateUpdate], [deleted], [company]) VALUES (8, N'langfarm', N'c4ca4238a0b923820dcc509a6f75849b', N'Lâm Đồng', N'Thành Phố Đà Lạt', N'langfarm', CAST(N'2005-02-10 00:00:00.000' AS DateTime), N'langfarm@langfarm.vn', N'6 Đường Nguyễn Thị Minh Khai', N'0987654321', 1, 1, CAST(N'2020-07-29 21:39:28.680' AS DateTime), CAST(N'2020-07-29 21:39:28.680' AS DateTime), 0, N'L''ang Farm')
INSERT [dbo].[UserBC] ([id], [username], [pwd], [Area], [City], [name], [birthday], [email], [adrs], [phone], [idRole], [active], [dateCreated], [dateUpdate], [deleted], [company]) VALUES (9, N'langfarm2', N'c4ca4238a0b923820dcc509a6f75849b', N'Lâm Đồng', N'Thành Phố Đà Lạt', N'langfarm2', CAST(N'2004-07-09 00:00:00.000' AS DateTime), N'langfarm@langfarm.vn', N'51 Đường Bùi Thị Xuân, Phường 2', N'0987654321', 1, 1, CAST(N'2020-07-30 08:32:07.737' AS DateTime), CAST(N'2020-07-30 08:32:07.737' AS DateTime), 0, N'L''ang Farm')
INSERT [dbo].[UserBC] ([id], [username], [pwd], [Area], [City], [name], [birthday], [email], [adrs], [phone], [idRole], [active], [dateCreated], [dateUpdate], [deleted], [company]) VALUES (10, N'langfarm3', N'c4ca4238a0b923820dcc509a6f75849b', N'Lâm Đồng', N'Thành Phố Đà Lạt', N'langfarm3', CAST(N'2007-03-09 00:00:00.000' AS DateTime), N'langfarm@langfarm.vn', N'67 Đường Trương Công Định, Phường 1', N'0987654321', 1, 1, CAST(N'2020-07-30 08:32:47.560' AS DateTime), CAST(N'2020-07-30 08:32:47.560' AS DateTime), 0, N'L''ang Farm')
INSERT [dbo].[UserBC] ([id], [username], [pwd], [Area], [City], [name], [birthday], [email], [adrs], [phone], [idRole], [active], [dateCreated], [dateUpdate], [deleted], [company]) VALUES (11, N'opmart', N'c4ca4238a0b923820dcc509a6f75849b', N'TP Hồ Chí Minh', N'Quận 5', N'opmart', CAST(N'1996-05-23 00:00:00.000' AS DateTime), N'opmart@coopmart.com', N'96 Đường Hùng Vương, Phường 9', N'028 3833 8156', 3, 1, CAST(N'2020-07-30 08:52:18.117' AS DateTime), CAST(N'2020-07-30 08:52:18.117' AS DateTime), 0, N'Co.opmart')
INSERT [dbo].[UserBC] ([id], [username], [pwd], [Area], [City], [name], [birthday], [email], [adrs], [phone], [idRole], [active], [dateCreated], [dateUpdate], [deleted], [company]) VALUES (12, N'vinmart', N'c4ca4238a0b923820dcc509a6f75849b', N'TP Hồ Chí Minh', N'Quận 1', N'vinmart', CAST(N'1996-05-23 00:00:00.000' AS DateTime), N'vinmart@vinmart.com', N'70-72 Lê Thánh Tôn, Bến Nghé', N'0945232321', 3, 1, CAST(N'2020-07-30 08:53:50.540' AS DateTime), CAST(N'2020-07-30 08:53:50.540' AS DateTime), 0, N'Siêu thị VinMart Đồng Khởi')
SET IDENTITY_INSERT [dbo].[UserBC] OFF
/****** Object:  Index [UQ__AdminBC__F3DBC572A9B951EF]    Script Date: 07/31/2020 9:04:50 AM ******/
ALTER TABLE [dbo].[AdminBC] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__UserBC__F3DBC5726C9637BD]    Script Date: 07/31/2020 9:04:50 AM ******/
ALTER TABLE [dbo].[UserBC] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[QRManager] ADD  DEFAULT ((0)) FOR [amount]
GO
ALTER TABLE [dbo].[QRManager] ADD  DEFAULT ((0)) FOR [accepted]
GO
ALTER TABLE [dbo].[QRManager] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[Roles] ADD  DEFAULT ((0)) FOR [deleted]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[21] 2[21] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProductDetailView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProductDetailView'
GO
