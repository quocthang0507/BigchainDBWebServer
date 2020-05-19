select * from UserBC


go
create view ProductDetailView as
SELECT id = ROW_NUMBER() OVER (ORDER BY (SELECT 1)), dbo.ProductDetail.idUser, dbo.UserBC.name as nameOfUser,
dbo. Product .id AS idProduct, dbo. Product .nameProduct, dbo. Product .details, 
dbo.ProductDetail.dateCreated, dbo.ProductDetail.dateReview, UserBC.email, UserBC.adrs, UserBC.phone, UserBC.idRole
FROM dbo.ProductDetail LEFT JOIN  dbo. Product  ON dbo. Product .id = dbo.ProductDetail.idProduct
LEFT JOIN dbo.UserBC on dbo.ProductDetail.idUser = dbo.UserBC.username

--alter view ProductSentView as
SELECT        ProductDetailView.idProduct, nameProduct, ProductDetailView.idUser, nameOfUser, details, idRole, COUNT(ProductDetailView.idProduct) AS sentNumber
FROM            dbo.ProductDetailView 
left join dbo.ProductDetail on ProductDetailView.idProduct = dbo.ProductDetail.idProduct
GROUP BY ProductDetailView.idProduct, ProductDetailView.idUser, nameOfUser, details, ProductDetailView.nameProduct, idRole


select * from ProductDetailView
select * from Roles
select * from ProductDetail

select * from ProductSentView

update UserBC set active = 1 where id = 4

create view ProductSentView as
select id = ROW_NUMBER() OVER (ORDER BY (SELECT 1)), ProductDetail.idProduct, Product.nameProduct, idUser, UserBC.name as nameOfUser,details, idRole, sentNumber from 
ProductDetail
left join UserBC on ProductDetail.idUser = UserBC.username
left join Product on Product.id = ProductDetail.idProduct
left join (select idProduct, count(id) as sentNumber from ProductDetail group by idProduct) as a on ProductDetail.idProduct = a.idProduct


