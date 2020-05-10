using BigchainDBWebServer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BigchainDBWebServer.DAO
{
    public class ProductDAO:BaseDAO
    {
        public List<ProductDetailView> GetAllByUsername(string username)
        {
            List<ProductDetailView> lst = Model.ProductDetailViews.Where(x => x.idUser == username).ToList();
            return lst;
        }
        public ResultOfRequest InsertProduct(Product pro, ProductDetail item, string idUser)
        {
            if (item.dateCreated < item.dateReview)
                return new ResultOfRequest(false, "Ngày tạo không được sau ngày xem xét!");
            var tempDetail = Model.ProductDetailViews.FirstOrDefault(f => f.idProduct == pro.id);
            if (tempDetail != null && tempDetail.idUser != idUser)
                return new ResultOfRequest(false, "Đã tồn tại ID này");
            var old = Model.Products.FirstOrDefault(f => f.id == pro.id);
            if (old != null)
            {
                var prodetail = Model.ProductDetails.Where(f=>f.idProduct==pro.id).OrderByDescending(f=>f.dateCreated).FirstOrDefault();
                if (item.dateCreated < prodetail.dateCreated)
                    return new ResultOfRequest(false, "Ngày tạo không được phép! Phải trể hơn!");
                prodetail = new ProductDetail();
                prodetail.idUser = idUser;
                prodetail.idProduct = pro.id;
                prodetail.dateCreated = item.dateCreated;
                prodetail.dateReview = item.dateReview;
                prodetail.isDeleted = 0;
                Model.ProductDetails.Add(prodetail);
                if (Model.SaveChanges() > 0)
                    return new ResultOfRequest(true, "Thêm thành công!");
                //return false;
            }
            else
            {
                old = new Product();
                old.id = pro.id;
                old.nameProduct = pro.nameProduct;
                old.details = pro.details;
                old.isDeleted = 0;
                Model.Products.Add(old);
                Model.SaveChanges();
                var prodetail = new ProductDetail();
                prodetail.idUser = idUser;
                prodetail.idProduct = old.id;
                prodetail.dateCreated = item.dateCreated;
                prodetail.dateReview = item.dateReview;
                prodetail.isDeleted = 0;
                Model.ProductDetails.Add(prodetail);
                if (Model.SaveChanges() > 0)
                    return new ResultOfRequest(true,"Thêm thành công!");
                //return false;
            }
            return new ResultOfRequest(false,"Lỗi tạo!");
        }
    }
}