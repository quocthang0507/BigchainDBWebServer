USE [QLNongSan]
GO
/****** Object:  Table [dbo].[AdminBC]    Script Date: 07/30/2020 5:13:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AdminBC]') AND type in (N'U'))
BEGIN
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
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ColumnSelected]    Script Date: 07/30/2020 5:13:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ColumnSelected]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ColumnSelected](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idType] [int] NOT NULL,
	[name] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[NewNoti]    Script Date: 07/30/2020 5:13:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NewNoti]') AND type in (N'U'))
BEGIN
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
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product]    Script Date: 07/30/2020 5:13:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Product]') AND type in (N'U'))
BEGIN
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
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductDetail]    Script Date: 07/30/2020 5:13:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductDetail]') AND type in (N'U'))
BEGIN
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
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductPlantingProcess]    Script Date: 07/30/2020 5:13:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductPlantingProcess]') AND type in (N'U'))
BEGIN
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
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductTranfer]    Script Date: 07/30/2020 5:13:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductTranfer]') AND type in (N'U'))
BEGIN
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
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[QRManager]    Script Date: 07/30/2020 5:13:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QRManager]') AND type in (N'U'))
BEGIN
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
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 07/30/2020 5:13:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Roles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Roles](
	[id] [int] NOT NULL,
	[name] [nvarchar](1000) NOT NULL,
	[deleted] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[UserBC]    Script Date: 07/30/2020 5:13:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserBC]') AND type in (N'U'))
BEGIN
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[Notifications]    Script Date: 07/30/2020 5:13:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[Notifications]'))
EXEC dbo.sp_executesql @statement = N'create VIEW [dbo].[Notifications] AS
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






' 
GO
/****** Object:  View [dbo].[ProductDetailView]    Script Date: 07/30/2020 5:13:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ProductDetailView]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[ProductDetailView]
AS
SELECT        id = ROW_NUMBER() OVER (ORDER BY 
                             (SELECT        1)), ProductDetail.id AS idProductDetail, dbo.ProductDetail.idUser, dbo.UserBC.name AS nameOfUser, dbo. Product .id AS idProduct, dbo. Product .nameProduct, dbo. Product .details, 
dbo.ProductDetail.dateCreated, dbo.ProductDetail.dateReview, UserBC.email, UserBC.adrs, UserBC.phone, UserBC.idRole, ProductDetail.IsUpBD, UserBC.Area AS userArea, UserBC.City AS userCity, 
ProductDetail.checkBuy, ProductDetail.numberhandling, accepted = ISNULL(QRManager.accepted, - 1), dbo.UserBC.company AS company, imgPath
FROM            dbo.ProductDetail LEFT JOIN
                         dbo. Product ON dbo. Product .id = dbo.ProductDetail.idProduct LEFT JOIN
                         dbo.UserBC ON dbo.ProductDetail.idUser = dbo.UserBC.username LEFT JOIN
                         dbo.QRManager ON dbo. Product .id = dbo.QRManager.idProduct
' 
GO
/****** Object:  View [dbo].[ProductSentView]    Script Date: 07/30/2020 5:13:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ProductSentView]'))
EXEC dbo.sp_executesql @statement = N'CREATE view [dbo].[ProductSentView] as
select id = ROW_NUMBER() OVER (ORDER BY (SELECT 1)), ProductDetail.idProduct, Product.nameProduct, idUser, UserBC.name as nameOfUser,details, UserBC.idRole, sentNumber from 
ProductDetail
left join UserBC on ProductDetail.idUser = UserBC.username
left join Product on Product.id = ProductDetail.idProduct
left join (select idProduct, count(id) as sentNumber from ProductDetail group by idProduct) as a on ProductDetail.idProduct = a.idProduct



' 
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__QRManager__amoun__22AA2996]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[QRManager] ADD  DEFAULT ((0)) FOR [amount]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__QRManager__accep__239E4DCF]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[QRManager] ADD  DEFAULT ((0)) FOR [accepted]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__QRManager__isDel__24927208]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[QRManager] ADD  DEFAULT ((0)) FOR [isDeleted]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__Roles__deleted__276EDEB3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Roles] ADD  DEFAULT ((0)) FOR [deleted]
END

GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'ProductDetailView', NULL,NULL))
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
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'ProductDetailView', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProductDetailView'
GO
