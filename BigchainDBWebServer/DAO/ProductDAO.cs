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
            if (tempDetail != null && tempDetail.idUser == idUser)
                return new ResultOfRequest(false, "Đã tồn tại ID này");
            var user = Model.UserBCs.FirstOrDefault(f => f.username == idUser);
            if (user == null)
                return new ResultOfRequest(false, "Người dùng không đúng");
            var old = Model.Products.FirstOrDefault(f => f.id == pro.id);
            if (old != null)
            {
                var prodetail = Model.ProductDetails.Where(f=>f.idProduct==pro.id).OrderByDescending(f=>f.dateCreated).ToList();
                if (prodetail.Count > 2)
                    return new ResultOfRequest(false, "Không được phép tạo thêm thông tin vào sản phẩm này!");
                if (prodetail.Count == 1 && user.idRole != 2)
                    return new ResultOfRequest(false, "Bạn hiện không thể thêm thông tin vì người vận chuyển vẫn chưa nhập dữ liệu vào!");
                if (item.dateReview < prodetail[0].dateCreated)
                    return new ResultOfRequest(false, "Ngày tạo không được phép! Phải trể hơn!");
                var temp = new ProductDetail()
                {
                    idUser = idUser,
                    idProduct = pro.id,
                    dateCreated = item.dateCreated,
                    dateReview = item.dateReview,
                    isDeleted = 0
                };
                Model.ProductDetails.Add(temp);
                if (Model.SaveChanges() > 0)
                    return new ResultOfRequest(true, "Thêm thành công!");
                //return false;
            }
            else
            {
                if (user.idRole != 1)
                    return new ResultOfRequest(false, "Không phải nông dân không được tạo mới!");
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
        public List<ProductSentView> GetListProductByID(string username, int? role)
        {
            if (role==null || role == 1)
                return null;
            var lst = Model.ProductSentViews.Where(f => f.idUser.Contains(username.ToString()) && f.sentNumber == (role-1)).ToList();
            return lst;
        }
    }
}