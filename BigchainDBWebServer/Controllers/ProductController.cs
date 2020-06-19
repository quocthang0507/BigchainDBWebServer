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
			if(old==null)
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
				return View();
			}
			return RedirectToAction("Login", "User");
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
			else { return RedirectToAction("Login", "User"); }

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
			return RedirectToAction("Login", "User");
		SetView:
			ProductDAO dao = new ProductDAO();
			var user = dao.Model.UserBCs.FirstOrDefault(x => x.username == userName);
			ViewBag.TheRole = user.idRole;
			if (user.idRole > 1)
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
	}
}