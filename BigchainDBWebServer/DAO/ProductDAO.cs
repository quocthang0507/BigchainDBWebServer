using BigchainDBWebServer.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace BigchainDBWebServer.DAO
{
	public class ProductDAO : BaseDAO
	{
		public List<ProductDetailView> GetAllByUsername(string username)
		{
			List<ProductDetailView> lst = Model.ProductDetailViews.Where(x => x.idUser == username).ToList();
			return lst;
		}
		public List<UserBC> GetListTranferUser()
		{
			List<UserBC> lst = Model.UserBCs.Where(x => x.idRole == 2).ToList();
			return lst;
		}
		public ResultOfRequest InsertProductdiff(Product pro, ProductDetail item, string idUser, int idProductDetail)
		{
			if (item.dateCreated > item.dateReview)
				return new ResultOfRequest(false, "Ngày tạo không được sau ngày xem xét!");
			var tempDetail = Model.ProductDetailViews.FirstOrDefault(f => f.idProduct == pro.id);
			if (tempDetail != null && tempDetail.idUser == idUser)
				return new ResultOfRequest(false, "Đã tồn tại ID này");
			var noti = Model.NewNotis.FirstOrDefault(f => f.idProduct == pro.id);
			noti = new NewNoti();
			noti.idUser = idUser;
			noti.idProduct = pro.id;
			noti.dateCreate = DateTime.Now;
			Model.NewNotis.Add(noti);
			var user = Model.UserBCs.FirstOrDefault(f => f.username == idUser);
			if (user == null)
				return new ResultOfRequest(false, "Người dùng không đúng");
			var old = Model.Products.FirstOrDefault(f => f.id == pro.id);
			if (old != null)
			{
				var prodetail = Model.ProductDetails.Where(f => f.idProduct == pro.id).OrderByDescending(f => f.dateCreated).ToList();
				//if (prodetail.Count > 3)
				//	return new ResultOfRequest(false, "Không được phép tạo thêm thông tin vào sản phẩm này!");
				//if (prodetail.Where(f => f.idUser == idUser).ToList().Count > 1)
				//    return new ResultOfRequest(false, "Bạn đã thêm sản phẩm này, không thể thêm được nữa!");
				//ProductDetail process = Model.ProductDetails.FirstOrDefault(f => f.idProduct == pro.id && f.idRole == 1);
				//if (process == null)
				//    return new ResultOfRequest(false, "Bạn đã thêm sản phẩm này, không thể thêm được nữa!");
				//if (process.numberhandling == 0)
				//{
				//    return new ResultOfRequest(false, "Bạn đã thêm sản phẩm này, không thể thêm được nữa!");
				//}
				//if (prodetail.Count == 1 && user.idRole != 2)
				//	return new ResultOfRequest(false, "Bạn hiện không thể thêm thông tin vì người vận chuyển vẫn chưa nhập dữ liệu vào!");
				if (item.dateReview < prodetail[0].dateCreated)
					return new ResultOfRequest(false, "Ngày tạo không được phép! Phải trễ hơn!");
				if (user.idRole == 3)
				{
					var temp = new ProductDetail()
					{
						idUser = idUser,
						idProduct = pro.id,
						dateCreated = item.dateCreated,
						isDeleted = 0,
						IsUpBD = 0,
						//checkBuy = 1,
						idRole = user.idRole,
					};
					if (checkNumber(pro.id, int.Parse(item.numberhandling.ToString())))
					{
						if (int.Parse(item.numberhandling.ToString()) > 0)
						{
							temp.numberhandling = item.numberhandling;
						}
						else
						{
							return new ResultOfRequest(false, "Số lượng nhập phải lớn hơn 0");
						}
					}
					else
					{
						return new ResultOfRequest(false, "Số lượng nhập phải nhỏ hơn số lượng nông sản: " + getNumber(pro.id));
					}
					Model.ProductDetails.Add(temp);
					if (Model.SaveChanges() > 0)
					{
						//UpdateBuy(pro.id);
						var result = UpdateClickTranfer(pro.id, int.Parse(item.numberhandling.ToString()));
						return result;
						//return new ResultOfRequest(true, "Thêm thành công!");
					}
				}
				if (user.idRole == 2)
				{
					if (item.dateCreated < prodetail.Where(f => f.idRole == 1).FirstOrDefault().dateReview)
						return new ResultOfRequest(false, "Ngày vận chuyển không thể sớm hơn ngày thu hoạch!");
					var temp = new ProductDetail()
					{
						idUser = idUser,
						idProduct = pro.id,
						dateCreated = item.dateCreated,
						dateReview = item.dateReview,
						isDeleted = 0,
						IsUpBD = 0,
						checkBuy = 2,
						numberhandling = item.numberhandling,
						idRole = user.idRole
					};
					Model.ProductDetails.Add(temp);
					if (Model.SaveChanges() > 0)
					{
						//UpdateTranfer(pro.id);
						UpdateClick(pro.id);
						var update = Model.ProductDetails.FirstOrDefault(x => x.idProduct == pro.id && x.idRole == 3 && x.id == idProductDetail);
						update.checkBuy = 2;
						UpdateDateOfBuy(pro.id, DateTime.Parse(item.dateReview.ToString()), idProductDetail);
						return new ResultOfRequest(true, "Thêm thành công!");
					}
				}
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
				old.number = pro.number;
				Model.Products.Add(old);
				Model.SaveChanges();
				var prodetail = new ProductDetail();
				prodetail.idUser = idUser;
				prodetail.idProduct = old.id;
				prodetail.dateCreated = item.dateCreated;
				prodetail.dateReview = item.dateReview;
				prodetail.isDeleted = 0;
				prodetail.IsUpBD = 0;
				prodetail.numberhandling = pro.number;
				//prodetail.checkBuy = 0;
				prodetail.idRole = user.idRole;
				Model.ProductDetails.Add(prodetail);
				if (Model.SaveChanges() > 0)
				{
					return new ResultOfRequest(true, "Thêm thành công!");
				}
				//return false;
			}
			return new ResultOfRequest(false, "Lỗi tạo!");
		}

		//public ResultOfRequest UpdateBuy(string idProduct)
		//{
		//    ProductDetail process = Model.ProductDetails.FirstOrDefault(f => f.idProduct == idProduct && f.idRole == 1);
		//    if (process == null)
		//        return new ResultOfRequest(false, "ID không tồn tại! Kiểm tra lại!");
		//    ProductDetail productDetail = Model.ProductDetails.FirstOrDefault(f => f.idProduct == idProduct);
		//    if (productDetail == null)
		//        return new ResultOfRequest(false, "Lỗi mã sản phẩm!");       
		//    process.checkBuy = 1;
		//    if (Model.SaveChanges() > 0)
		//        return new ResultOfRequest(true, "Thành công!");
		//    return new ResultOfRequest(false, "Lỗi lưu!");
		//}
		public bool checkNumber(string idProduct, int num)
		{
			ProductDetail process = Model.ProductDetails.FirstOrDefault(f => f.idProduct == idProduct && f.idRole == 1);
			if (process == null)
				return false;
			if (process.numberhandling >= num && process.numberhandling > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		public int getNumber(string idProduct)
		{
			ProductDetail process = Model.ProductDetails.FirstOrDefault(f => f.idProduct == idProduct && f.idRole == 1);
			if (process == null)
				return -1;
			return int.Parse(process.numberhandling.ToString());
		}
		public int getIDDetail(string idProduct)
		{
			ProductTranfer process = Model.ProductTranfers.FirstOrDefault(f => f.idProduct == idProduct);
			if (process == null)
				return -1;
			return int.Parse(process.idProductDetail.ToString());
		}
		public ResultOfRequest UpdateDateOfBuy(string idProduct, DateTime date, int id)
		{
			ProductDetail process = Model.ProductDetails.FirstOrDefault(f => f.idProduct == idProduct && f.idRole == 3 && f.id == id);
			if (process == null)
				return new ResultOfRequest(false, "ID không tồn tại! Kiểm tra lại!");
			ProductDetail productDetail = Model.ProductDetails.FirstOrDefault(f => f.idProduct == idProduct);
			if (productDetail == null)
				return new ResultOfRequest(false, "Lỗi mã nông sản!");
			process.dateReview = date;
			if (Model.SaveChanges() > 0)
				return new ResultOfRequest(true, "Thành công!");
			return new ResultOfRequest(false, "Lỗi lưu!");
		}
		//public ResultOfRequest UpdateTranfer(string idProduct)
		//{
		//    ProductDetail process = Model.ProductDetails.FirstOrDefault(f => f.idProduct == idProduct);
		//    if (process == null)
		//        return new ResultOfRequest(false, "ID không tồn tại! Kiểm tra lại!");
		//    ProductDetail productDetail = Model.ProductDetails.FirstOrDefault(f => f.idProduct == idProduct);
		//    if (productDetail == null)
		//        return new ResultOfRequest(false, "Lỗi mã sản phẩm!");
		//    process.checkBuy = 2;
		//    ProductDetail buy = Model.ProductDetails.FirstOrDefault(f => f.idProduct == idProduct && f.idRole==3);
		//    if (buy == null)
		//        return new ResultOfRequest(false, "Lỗi mã sản phẩm!");
		//    buy.checkBuy = 2;
		//    if (Model.SaveChanges() > 0)
		//        return new ResultOfRequest(true, "Thành công!");
		//    return new ResultOfRequest(false, "Lỗi lưu!");
		//}
		public ResultOfRequest UpdateClick(string idProduct)
		{
			ProductTranfer product = Model.ProductTranfers.FirstOrDefault(f => f.idProduct == idProduct && f.isClick == 0);
			product.isClick = 1;
			if (Model.SaveChanges() > 0)
				return new ResultOfRequest(true, "Thành công!");
			return new ResultOfRequest(false, "Thất bại!");
		}
		public ResultOfRequest UpdateClickTranfer(string idProduct, int num)
		{
			ProductDetail process = Model.ProductDetails.FirstOrDefault(f => f.idProduct == idProduct && f.idRole == 1);
			if (process == null)
				return new ResultOfRequest(false, "ID không tồn tại! Kiểm tra lại!");
			if (process.numberhandling >= num && process.numberhandling > 0)
			{
				process.numberhandling = process.numberhandling - num;
				if (Model.SaveChanges() > 0)
					return new ResultOfRequest(true, "Thành công!");
			}
			else
			{
				return new ResultOfRequest(false, "Số lượng nhập phải nhỏ hơn số lượng nông sản: " + process.numberhandling);
			}
			return new ResultOfRequest(false, "Lỗi lưu!");
		}
		public List<ProductDetailView> GetListProductByID(string idProduct, int? role)
		{
			if (role == null || role == 1)
				return null;
			var lst = Model.ProductDetailViews.Where(f => f.idProduct.Contains(idProduct) && f.IsUpBD == 1 && f.idRole == 1).ToList();
			return lst;
		}
		public List<ProductTranfer> GetListProductTranfer(string idUser, int? role)
		{
			if (role == null || role == 1 || role == 3)
				return null;
			var lst = Model.ProductTranfers.Where(f => f.idUser.Contains(idUser)).ToList();
			return lst;
		}
		public ResultOfRequest UpBD(int id)
		{
			ProductDetail productDetail = Model.ProductDetails.FirstOrDefault(f => f.id == id);
			productDetail.IsUpBD = 1;
			if (Model.SaveChanges() > 0)
				return new ResultOfRequest(true, "Thành công!");
			return new ResultOfRequest(false, "Thất bại!");
		}

		public ResultOfRequest InsertProduct(Product pro, ProductDetail item, string idUser)
		{
			if (item.dateCreated > item.dateReview)
				return new ResultOfRequest(false, "Ngày tạo không được sau ngày xem xét!");
			var tempDetail = Model.ProductDetailViews.FirstOrDefault(f => f.idProduct == pro.id);
			if (tempDetail != null && tempDetail.idUser == idUser)
				return new ResultOfRequest(false, "Đã tồn tại ID này");
			var noti = Model.NewNotis.FirstOrDefault(f => f.idProduct == pro.id);
			noti = new NewNoti();
			noti.idUser = idUser;
			noti.idProduct = pro.id;
			noti.dateCreate = DateTime.Now;
			Model.NewNotis.Add(noti);
			var user = Model.UserBCs.FirstOrDefault(f => f.username == idUser);
			if (user == null)
				return new ResultOfRequest(false, "Người dùng không đúng");
			var old = Model.Products.FirstOrDefault(f => f.id == pro.id);
			if (old != null)
			{
				var prodetail = Model.ProductDetails.Where(f => f.idProduct == pro.id).OrderByDescending(f => f.dateCreated).ToList();
				//if (prodetail.Count > 3)
				//	return new ResultOfRequest(false, "Không được phép tạo thêm thông tin vào sản phẩm này!");
				//if (prodetail.Where(f => f.idUser == idUser).ToList().Count > 1)
				//    return new ResultOfRequest(false, "Bạn đã thêm sản phẩm này, không thể thêm được nữa!");
				//ProductDetail process = Model.ProductDetails.FirstOrDefault(f => f.idProduct == pro.id && f.idRole == 1);
				//if (process == null)
				//    return new ResultOfRequest(false, "Bạn đã thêm sản phẩm này, không thể thêm được nữa!");
				//if (process.numberhandling == 0)
				//{
				//    return new ResultOfRequest(false, "Bạn đã thêm sản phẩm này, không thể thêm được nữa!");
				//}
				//if (prodetail.Count == 1 && user.idRole != 2)
				//	return new ResultOfRequest(false, "Bạn hiện không thể thêm thông tin vì người vận chuyển vẫn chưa nhập dữ liệu vào!");
				if (item.dateReview < prodetail[0].dateCreated)
					return new ResultOfRequest(false, "Ngày tạo không được phép! Phải trễ hơn!");
				if (user.idRole == 3)
				{
					var temp = new ProductDetail()
					{
						idUser = idUser,
						idProduct = pro.id,
						dateCreated = item.dateCreated,
						isDeleted = 0,
						IsUpBD = 0,
						//checkBuy = 1,
						idRole = user.idRole,
					};
					if (checkNumber(pro.id, int.Parse(item.numberhandling.ToString())))
					{
						if (int.Parse(item.numberhandling.ToString()) > 0)
						{
							temp.numberhandling = item.numberhandling;
						}
						else
						{
							return new ResultOfRequest(false, "Số lượng nhập phải lớn hơn 0");
						}
					}
					else
					{
						return new ResultOfRequest(false, "Số lượng nhập phải nhỏ hơn số lượng nông sản: " + getNumber(pro.id));
					}
					Model.ProductDetails.Add(temp);
					if (Model.SaveChanges() > 0)
					{
						//UpdateBuy(pro.id);
						var result = UpdateClickTranfer(pro.id, int.Parse(item.numberhandling.ToString()));
						return result;
						//return new ResultOfRequest(true, "Thêm thành công!");
					}
				}
				if (user.idRole == 2)
				{
					if (item.dateCreated < prodetail.Where(f => f.idRole == 1).FirstOrDefault().dateReview)
						return new ResultOfRequest(false, "Ngày vận chuyển không thể sớm hơn ngày thu hoạch!");
					var temp = new ProductDetail()
					{
						idUser = idUser,
						idProduct = pro.id,
						dateCreated = item.dateCreated,
						dateReview = item.dateReview,
						isDeleted = 0,
						IsUpBD = 0,
						numberhandling = item.numberhandling,
						idRole = user.idRole
					};
					Model.ProductDetails.Add(temp);
					if (Model.SaveChanges() > 0)
					{
						//UpdateTranfer(pro.id);
						UpdateClick(pro.id);
						return new ResultOfRequest(true, "Thêm thành công!");
					}
				}
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
				old.number = pro.number;
				Model.Products.Add(old);
				Model.SaveChanges();
				var prodetail = new ProductDetail();
				prodetail.idUser = idUser;
				prodetail.idProduct = old.id;
				prodetail.dateCreated = item.dateCreated;
				prodetail.dateReview = item.dateReview;
				prodetail.isDeleted = 0;
				prodetail.IsUpBD = 0;
				prodetail.numberhandling = pro.number;
				//prodetail.checkBuy = 0;
				prodetail.idRole = user.idRole;
				Model.ProductDetails.Add(prodetail);
				if (Model.SaveChanges() > 0)
				{
					return new ResultOfRequest(true, "Thêm thành công!");
				}
				//return false;
			}
			return new ResultOfRequest(false, "Lỗi tạo!");
		}


		public string GetIdUserOwner(Product product)
		{
			ProductDetail detail = Model.ProductDetails.Where(f => f.idProduct == product.id && f.idRole == 1).OrderBy(f => f.dateCreated).FirstOrDefault();
			if (detail == null)
				return "";
			return detail.idUser;
		}
		public int GetNumberProduct(string username)
		{
			var num = Model.ProductDetails.FirstOrDefault(x => x.idUser == username && x.idRole == 1);
			Product detail = Model.Products.Where(f => f.id == num.idProduct).FirstOrDefault();
			if (detail == null)
				return -1;
			return int.Parse(detail.number.ToString());
		}
		public string GetCompanyName(string username)
		{
			var user = Model.UserBCs.FirstOrDefault(x => x.username == username);
			if (user == null)
				return "";
			return user.company;
		}
		public ResultOfRequest RequestQRCode(QRManager qRManager)
		{
			var old = Model.QRManagers.FirstOrDefault(f => f.idProduct == qRManager.idProduct);
			if (old != null)
				return new ResultOfRequest(false, "Đã gửi yêu cầu, vui lòng chờ quản trị viên xem xét!");
			qRManager.isDeleted = 0;
			qRManager.linkImg = "";
			qRManager.accepted = 0;
			qRManager.dateCreated = DateTime.Today;
			qRManager.dateUpdated = DateTime.Today;
			if (qRManager.amount == null || qRManager.amount < 0)
				qRManager.amount = 100;
			Model.QRManagers.Add(qRManager);
			if (Model.SaveChanges() > 0)
				return new ResultOfRequest(true, "Gửi yêu cầu thành công!");
			return new ResultOfRequest(false, "Lỗi gửi yêu cầu, vui lòng thử lại!");
		}
		public List<QRManager> GetListRequest(string search = null)
		{
			if (search == null)
				return Model.QRManagers.Where(f => f.isDeleted == 0).ToList();
			else
				return Model.QRManagers.Where(f => f.isDeleted == 0 && f.idProduct == search).ToList();
		}
		public ResultOfRequest AcceptQRRequest(string code, string urlPath)
		{
			var qrManager = Model.QRManagers.FirstOrDefault(f => f.idProduct == code && f.isDeleted == 0);
			qrManager.accepted = 1;
			qrManager.linkImg = urlPath;
			qrManager.dateUpdated = System.DateTime.Today;
			if (Model.SaveChanges() > 0)
				return new ResultOfRequest(true, "Tạo thành công!");
			return new ResultOfRequest(false, "Lỗi cập nhật!");
		}
	}
}