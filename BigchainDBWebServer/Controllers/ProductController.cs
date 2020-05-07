using BigchainDBWebServer.DAO;
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
            AccountDAO dao = new AccountDAO();
            var UserFb = Session["usernameFB"];
            var UserGO = Session["usernameGO"];
            if (item == null)
                return Json(new { Success = false }, JsonRequestBehavior.AllowGet);
            var old = dao.Model.Products.FirstOrDefault(f => f.id == pro.id);
            if (old != null)
            {
                var prodetail = dao.Model.ProductDetails.FirstOrDefault(f => f.id == item.id);
                prodetail = new ProductDetail();
                if (UserFb != null)
                {
                    prodetail.idUser = UserFb.ToString();
                }
                if (UserGO != null)
                {
                    prodetail.idUser = UserGO.ToString();
                }
                prodetail.idProduct = pro.id;
                prodetail.dateCreated=item.dateCreated;
                prodetail.dateReview = item.dateReview;
                prodetail.isDeleted = 0;
                dao.Model.ProductDetails.Add(prodetail);
                dao.Model.SaveChanges();
                return Json(new { Success = true }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                old = new Product();
                old.id = pro.id;
                old.nameProduct = pro.nameProduct;
                old.details = pro.details;
                old.isDeleted = 0;
                dao.Model.Products.Add(old);
                dao.Model.SaveChanges();
                var prodetail = dao.Model.ProductDetails.FirstOrDefault(f => f.id == item.id);
                prodetail = new ProductDetail();
                if (UserFb != null)
                {
                    prodetail.idUser = UserFb.ToString();
                }
                if (UserGO != null)
                {
                    prodetail.idUser = UserGO.ToString();
                }
                prodetail.idProduct = old.id;
                prodetail.dateCreated = item.dateCreated;
                prodetail.dateReview = item.dateReview;
                prodetail.isDeleted = 0;
                dao.Model.ProductDetails.Add(prodetail);
                dao.Model.SaveChanges();
                return Json(new { Success = true }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}