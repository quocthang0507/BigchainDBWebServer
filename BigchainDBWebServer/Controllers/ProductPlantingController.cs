using BigchainDBWebServer.DAO;
using BigchainDBWebServer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BigchainDBWebServer.Controllers
{
    public class ProductPlantingController : Controller
    {
        // GET: ProductPlanting
        public ActionResult Index()
        {
            string data = "";
            //data += Request.Cookies[];
            data = HttpContext.Session.SessionID;
            ViewBag.Cookies = data;
            return View();
        }
        public ActionResult Info(string IdProduct)
        {
            ProductPlantingDAO dao = new ProductPlantingDAO();
            var product = dao.Model.Products.FirstOrDefault(x => x.id == IdProduct);
            if (product == null)
                return RedirectToAction("Index", "ProductPlanting");
            var result = dao.GetListProductPlantingProcessesByIdProduct(IdProduct);
            ViewBag.product = product;
            ViewBag.isOwner = CheckOwner(product);
            ViewBag.lstPlanting = result;
            return View();
        }
        public ActionResult AddPlanting(string IdProduct)
        {
            ProductPlantingDAO dao = new ProductPlantingDAO();
            var product = dao.Model.Products.FirstOrDefault(x => x.id == IdProduct);
            if (product == null)
                return RedirectToAction("Index");
            if (!CheckOwner(product))
                return RedirectToAction("Index");
            ViewBag.curProduct = product;
            ViewBag.idUser = getIdUser();
            return View();
        }
        [HttpPost]
        public JsonResult Insert(ProductPlantingProcess product)
        {
            ProductPlantingDAO dao = new ProductPlantingDAO();
            var result = dao.InsertPlanting(product);
            return Json(result,JsonRequestBehavior.AllowGet);
        }
        [HttpGet]
        public ActionResult Update(int id)
        {
            ProductPlantingDAO dao = new ProductPlantingDAO();
            ProductPlantingProcess curr = dao.Model.ProductPlantingProcesses.FirstOrDefault(x => x.id == id && x.isDelete == 0 && x.isUpBD == 0);
            if (curr == null)
                return RedirectToAction("Index");
            var curPro = dao.Model.Products.FirstOrDefault(f => f.id == curr.idProduct);
            if(curr == null || curPro.isDeleted == 1 || !CheckOwner(curPro))
                return RedirectToAction("Index");
            ViewBag.curPlanting = curr;
            ViewBag.curProduct = curPro;
            return View();
        }
        [HttpPost]
        public JsonResult Update(ProductPlantingProcess product)
        {
            ProductPlantingDAO dao = new ProductPlantingDAO();
            ProductPlantingProcess old = dao.Model.ProductPlantingProcesses.FirstOrDefault(f => f.id == product.id);
            if (old == null)
                return Json(new ResultOfRequest(false, "Lỗi ID!"));
            return Json(dao.UpdatePlanting(product),JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public JsonResult DeletePlanting(int id)
        {
            ProductPlantingDAO dao = new ProductPlantingDAO();
            return Json(dao.DeletePlanting(id), JsonRequestBehavior.AllowGet);
        }
        private bool CheckOwner(Product product)
        {
            ProductDAO dao = new ProductDAO();
            string productOwner = dao.GetIdUserOwner(product);
            if (productOwner == getIdUser())
                return true;
            return false;
        }
        private string getIdUser()
        {
            string idUser = null;
            if (Session["usernameFB"] != null)
            {
                idUser = Session["usernameFB"].ToString();
            }
            else if (Session["usernameGO"] != null)
            {
                idUser = Session["usernameGO"].ToString();
            }
            else if (Session["UserID"] != null)
            {
                idUser = Session["UserID"].ToString();
            }
            return idUser;
        }
    }
}