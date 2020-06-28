﻿using BigchainDBWebServer.DAO;
using BigchainDBWebServer.Models;
using System.Linq;
using System.Web.Mvc;

namespace BigchainDBWebServer.Controllers
{
	public class ProductController : Controller
	{
		public bool CheckLogin(string item)
		{
			AccountDAO dao = new AccountDAO();
			if (item == null)
				return false;
			var old = dao.Model.UserBCs.FirstOrDefault(f => f.username == item);
			if (old == null)
			{
				Session.RemoveAll();
				return false;
			}
			if (old.active == 0)
			{
				return false;
			}
			return true;
		}

		public int CheckRoles(string item)
		{
			AccountDAO dao = new AccountDAO();
			if (item == null)
				return 0;
			var old = dao.Model.UserBCs.FirstOrDefault(f => f.username == item);
			if (old.idRole == 1)
			{
				return 1;
			}
			if (old.idRole == 2)
			{
				return 2;
			}
			if (old.idRole == 3)
			{
				return 3;
			}
			return 0;
		}

		// GET: Product
		public ActionResult Manager()
		{
			string idUser = null;
			if (Session["usernameFB"] != null)
			{
				var userFB = Session["usernameFB"].ToString();
				if (CheckLogin(userFB))
					idUser = userFB;
			}
			if (Session["usernameGO"] != null)
			{
				var userGO = Session["usernameGO"].ToString();
				if (CheckLogin(userGO))
					idUser = userGO;
			}
			if (Session["UserID"] != null)
			{
				var user = Session["UserID"].ToString();
				if (CheckLogin(user))
					idUser = user;
			}
			if (idUser != null)
			{
				ProductDAO dao = new ProductDAO();
				ViewBag.lst = dao.GetAllByUsername(idUser);
				ViewBag.Roles = CheckRoles(idUser);
				ViewBag.lstTranfer = dao.GetListTranferUser();
				return View();
			}
			return RedirectToAction("NoActiveLogin", "User");
		}

		public ActionResult AddProduct()
		{
			string userName = null;
			if (Session["usernameFB"] != null)
			{
				userName = Session["usernameFB"].ToString();
				if (CheckLogin(userName) && CheckRoles(Session["usernameFB"].ToString()) == 1)
					return View(); //
				else
					return RedirectToAction("AddProductForDiffAc", "Product");
			}
			if (Session["usernameGO"] != null)
			{
				userName = Session["usernameGO"].ToString();
				if (CheckLogin(userName) && CheckRoles(Session["usernameGO"].ToString()) == 1)
					return View();//
				else
					return RedirectToAction("AddProductForDiffAc", "Product");
			}
			if (Session["UserID"] != null)
			{
				userName = Session["UserID"].ToString();
				if (CheckLogin(userName) && CheckRoles(Session["UserID"].ToString()) == 1)
					return View();//
				else
					return RedirectToAction("AddProductForDiffAc", "Product");
			}
			else { return RedirectToAction("NoActiveLogin", "User"); }

		}

		public ActionResult AddProductForDiffAc(string search = null)
		{
			string userName = null;
			if (Session["usernameFB"] != null)
			{
				userName = Session["usernameFB"].ToString();
				if (CheckLogin(userName))
					goto SetView;
			}
			if (Session["usernameGO"] != null)
			{
				userName = Session["usernameGO"].ToString();
				if (CheckLogin(userName))
					goto SetView;
			}
			if (Session["UserID"] != null)
			{
				userName = Session["UserID"].ToString();
				if (CheckLogin(userName))
					goto SetView;
			}
			return RedirectToAction("NoActiveLogin", "User");
		SetView:
			ProductDAO dao = new ProductDAO();
			var user = dao.Model.UserBCs.FirstOrDefault(x => x.username == userName);
			ViewBag.TheRole = user.idRole;
			if (user.idRole == 2)
			{
				ViewBag.lstProductSent = dao.GetListProductTranfer(userName, user.idRole);
			}
			if (user.idRole == 3)
			{
				ViewBag.lstProductSent = dao.GetListProductByID(search, user.idRole);
			}
			ViewBag.Roles = CheckRoles(userName);
			return View();
			// 
		}

		[HttpPost]
		public JsonResult InsertProduct(Product pro, ProductDetail item)
		{
			ProductDAO dao = new ProductDAO();
			var UserFb = Session["usernameFB"];
			var UserGO = Session["usernameGO"];
			var UserID = Session["UserID"];
			if (item == null)
				return Json(new { Success = false }, JsonRequestBehavior.AllowGet);
			var old = dao.Model.Products.FirstOrDefault(f => f.id == pro.id);
			string idUser = null;
			if (UserFb != null)
			{
				idUser = UserFb.ToString();
			}
			if (UserGO != null)
			{
				idUser = UserGO.ToString();
			}
			if (UserID != null)
			{
				idUser = UserID.ToString();
			}
			if (idUser == null)
				return Json(false, JsonRequestBehavior.AllowGet);
			var result = dao.InsertProduct(pro, item, idUser);
			return Json(result, JsonRequestBehavior.AllowGet);
		}
		public JsonResult InsertProductTranfer(ProductTranfer item)
		{
			ProductDAO dao = new ProductDAO();
			if (item == null)
				return Json(new ResultOfRequest(false, "Dữ liệu nhận bị lỗi!"), JsonRequestBehavior.AllowGet);
			var old = dao.Model.ProductTranfers.FirstOrDefault(f => f.id == item.id);
			if (old != null)
			{
				return Json(new ResultOfRequest(false, "Đã tồn tại tài khoản này, vui lòng nhập lại!"), JsonRequestBehavior.AllowGet);
			}
			else
			{
				old = new ProductTranfer();
				old.idProduct = item.idProduct;
				old.nameProduct = item.nameProduct;
				old.nameUser = item.nameUser;
				old.detail = item.detail;
				old.idUser = item.idUser;
				dao.Model.ProductTranfers.Add(old);
				ProductDetail product = dao.Model.ProductDetails.FirstOrDefault(f => f.idProduct == item.idProduct && f.idRole==1);
				product.isClick = 2;
				if (dao.Model.SaveChanges() > 0)
					return Json(new ResultOfRequest(true, "Thành công!"), JsonRequestBehavior.AllowGet);
				return Json(new ResultOfRequest(false, "Lỗi lưu dữ liệu!"), JsonRequestBehavior.AllowGet);
			}
		}
	}
}