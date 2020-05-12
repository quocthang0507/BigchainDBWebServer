﻿using BigchainDBWebServer.DAO;
using BigchainDBWebServer.Models;
using Microsoft.Ajax.Utilities;
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
            if (old.active == 0)
            {
                return false;
            }
            return true;
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
            else if (Session["usernameGO"] != null)
            {
                var userGO = Session["usernameGO"].ToString();
                if (CheckLogin(userGO))
                    idUser = userGO;
            }
            if(idUser != null)
            {
                ProductDAO dao = new ProductDAO();
                ViewBag.lst = dao.GetAllByUsername(idUser);
                return View();
            }
            return RedirectToAction("Login", "User");
        }
        public ActionResult AddProduct()
        {
            if (Session["usernameFB"] != null)
            {
                var userFB = Session["usernameFB"].ToString();
                if (CheckLogin(userFB))
                    return View();
            }
            if (Session["usernameGO"] != null)
            {
                var userGO = Session["usernameGO"].ToString();
                if (CheckLogin(userGO))
                    return View();
            }
            return RedirectToAction("Login", "User");
        }
        public JsonResult InsertProduct(Product pro, ProductDetail item)
        {
            ProductDAO dao = new ProductDAO();
            var UserFb = Session["usernameFB"];
            var UserGO = Session["usernameGO"];
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
            dao.InsertProduct(pro, item, idUser);

            return Json(new { Success = true }, JsonRequestBehavior.AllowGet);
        }
    }
}