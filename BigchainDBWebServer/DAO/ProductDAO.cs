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
        public bool InsertProduct(Product pro, ProductDetail item, string idUser)
        {
            var old = Model.Products.FirstOrDefault(f => f.id == pro.id);
            if (old != null)
            {
                var prodetail = Model.ProductDetails.FirstOrDefault(f => f.id == item.id);
                prodetail = new ProductDetail();
                prodetail.idUser = idUser;
                prodetail.idProduct = pro.id;
                prodetail.dateCreated = item.dateCreated;
                prodetail.dateReview = item.dateReview;
                prodetail.isDeleted = 0;
                Model.ProductDetails.Add(prodetail);
                if (Model.SaveChanges() > 0)
                    return true;
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
                var prodetail = Model.ProductDetails.FirstOrDefault(f => f.id == item.id);
                prodetail = new ProductDetail();
                prodetail.idUser = idUser;
                prodetail.idProduct = old.id;
                prodetail.dateCreated = item.dateCreated;
                prodetail.dateReview = item.dateReview;
                prodetail.isDeleted = 0;
                Model.ProductDetails.Add(prodetail);
                if (Model.SaveChanges() > 0)
                    return true;
                //return false;
            }
            return false;
        }
    }
}